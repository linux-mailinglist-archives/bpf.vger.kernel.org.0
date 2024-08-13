Return-Path: <bpf+bounces-37040-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4357095082E
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 16:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 000452868EC
	for <lists+bpf@lfdr.de>; Tue, 13 Aug 2024 14:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 436611A00F4;
	Tue, 13 Aug 2024 14:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HiIghhrf"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F9619EEB1
	for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723560620; cv=none; b=YCf+BHLJG5LJYx1KyrsPKJw1omWzRRrAmdaKC32BVSS8USBYnwMrXHfSuu44pnuRabCVw8XrrSfQslOJK3hP442PhW1FrErP9zwVrHvGF7zOcR2vp3KPy59uYkvOPUkCCGzJcoILRMzqvwjIoAMcJDe7JSgxT4ftEAZTLtQ0Ilg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723560620; c=relaxed/simple;
	bh=SRr9RR1XGVl/Gq4f+pVqu724Zkszcled1QcXL1G5piw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t5AUl05zBrSgke8hRi+JE1nMfl4iRxCB5WvEIu89Md5HSN9RH1KTlOt8E3NhhCCcN7VdHlnrsmb7gQPdVLj1RLKjPGKsRES7m60iGWs6a/fNZ4XosiLufvzcKO2sXvJd3sC4p1qlEbHhkdg/r6UQkGwkc6BYyA6vHm+U7HFyRVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HiIghhrf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723560618;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Gux5ta0vcNtAHtv9zFHe9kquCitSuFpqmPRD5zXDWjs=;
	b=HiIghhrfbkRw+2aX/b4uUN8M6NwROwVJPU1JSJ5hWtgUWJGX82LTrwmCUBc2o9C2+zw08p
	L8hoTE55QO2xlODCrLMLgvPqI0zmvo5ISeq98odyNMlu0wX0+hjz34oF6WCLy5fNCL1WNh
	0Wcrm5fGX4+qgpI7IqS6ImVy5JM14vs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-515-d_7FO1tcOZ2MNji2seuJag-1; Tue,
 13 Aug 2024 10:50:13 -0400
X-MC-Unique: d_7FO1tcOZ2MNji2seuJag-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EDB6118EA953;
	Tue, 13 Aug 2024 14:50:10 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.225.159])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 91C2D1955F6B;
	Tue, 13 Aug 2024 14:50:07 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Tue, 13 Aug 2024 16:50:07 +0200 (CEST)
Date: Tue, 13 Aug 2024 16:50:03 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, peterz@infradead.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org
Subject: Re: [PATCH v2] uprobes: make trace_uprobe->nhit counter a per-CPU one
Message-ID: <20240813145002.GB31977@redhat.com>
References: <20240809192357.4061484-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240809192357.4061484-1-andrii@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 08/09, Andrii Nakryiko wrote:
>
> @@ -815,13 +824,21 @@ static int probes_profile_seq_show(struct seq_file *m, void *v)
>  {
>  	struct dyn_event *ev = v;
>  	struct trace_uprobe *tu;
> +	unsigned long nhits;
> +	int cpu;
>
>  	if (!is_trace_uprobe(ev))
>  		return 0;
>
>  	tu = to_trace_uprobe(ev);
> +
> +	nhits = 0;
> +	for_each_possible_cpu(cpu) {
> +		nhits += READ_ONCE(*per_cpu_ptr(tu->nhits, cpu));

why not

		nhits += per_cpu(*tu->nhits, cpu);

?

See for example per_cpu_sum() or nr_processes(), per_cpu() should work just fine...

Other than that

Reviewed-by: Oleg Nesterov <oleg@redhat.com>



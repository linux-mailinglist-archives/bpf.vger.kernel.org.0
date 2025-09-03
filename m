Return-Path: <bpf+bounces-67274-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A47C9B41C33
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 12:51:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BA431603E4
	for <lists+bpf@lfdr.de>; Wed,  3 Sep 2025 10:51:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C12042EC0AC;
	Wed,  3 Sep 2025 10:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1GQSCto"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72A52D6607
	for <bpf@vger.kernel.org>; Wed,  3 Sep 2025 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756896670; cv=none; b=eMX7knd+C6SeqqwyszY6giZnfxHEub/N617wsWqP4wdZBPPzbqC1yIJwdGTNvN8XFLw6v8Grc/KN7EspJ6ESFtbSzyuKGc6lznj6lGE4TFBb2tkk3c1ecY3NrfRmtSZWM3Dv9GimvVEey/vuiynTh9itEvj/GDX6aew0f5Enq6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756896670; c=relaxed/simple;
	bh=R2LCpwreJdznLf2leEoWhdR9qD3ooKnYR6/rcs01KWU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CuN+UvSuojiFoCZcKN5HGRPo1xUZsf6nRediE90RduNPrr8ZNC9ax9xhCie/sHPrlITF1xdzyY7xCFTfo6qL4d8OB4TlnsAYeTOQLuT3HL2k1W5D30SPn3nQ4YkVoyYQki+qkloWZE7DNc6bqWkYiR3g8AcqN5Ir5g7sybu6YQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1GQSCto; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756896667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N3Ukxt9C+GpVZT/jwVqngtAkGPSKE0YadV98aD+g7Ro=;
	b=h1GQSCto/lctXjlc9EyTEOtaLiHgcEFNMJ8ZiD/ZE5M3dcjR2bRs4FFHbb19xq3lkzuWyQ
	FfG98M3WQiTXabcdUhNDyLKZM0g5uxsDHi6wfk9VMd5ZgL3MnJRPLzfHos/yyEYli32JoW
	J+tt68FxNNMqLpDZZ2EJJLBxlMSJ89w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-389-TYMDsMzpOqGvS4HR5evMRg-1; Wed,
 03 Sep 2025 06:51:04 -0400
X-MC-Unique: TYMDsMzpOqGvS4HR5evMRg-1
X-Mimecast-MFC-AGG-ID: TYMDsMzpOqGvS4HR5evMRg_1756896662
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3768218002C1;
	Wed,  3 Sep 2025 10:51:02 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.52])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 2B19819560B1;
	Wed,  3 Sep 2025 10:50:56 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Wed,  3 Sep 2025 12:49:40 +0200 (CEST)
Date: Wed, 3 Sep 2025 12:49:33 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH perf/core 01/11] uprobes: Add unique flag to uprobe
 consumer
Message-ID: <20250903104933.GB18799@redhat.com>
References: <20250902143504.1224726-1-jolsa@kernel.org>
 <20250902143504.1224726-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250902143504.1224726-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/02, Jiri Olsa wrote:
>
> +static bool consumer_can_add(struct list_head *head, struct uprobe_consumer *uc)
> +{
> +	/* Uprobe has no consumer, we can add any. */
> +	if (list_empty(head))
> +		return true;
> +	/* Uprobe has consumer/s, we can't add unique one. */
> +	if (uc->is_unique)
> +		return false;
> +	/*
> +	 * Uprobe has consumer/s, we can add nother consumer only if the
> +	 * current consumer is not unique.
> +	 **/
> +	return !list_first_entry(head, struct uprobe_consumer, cons_node)->is_unique;
> +}

Since you are going to send V2 anyway... purely cosmetic and subjective nit,
but somehow I can't resist,

	bool consumer_can_add(struct list_head *head, struct uprobe_consumer *new)
	{
		struct uprobe_consumer *old = list_first_entry_or_null(...);

		return !old || (!old->exclusive && !new->exclusive);
	}

looks a bit more readable to me. Please ignore if you like your version more.

Oleg.



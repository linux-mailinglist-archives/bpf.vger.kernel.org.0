Return-Path: <bpf+bounces-39027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAC596DB29
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 16:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9E162284DA4
	for <lists+bpf@lfdr.de>; Thu,  5 Sep 2024 14:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C741F19E7E4;
	Thu,  5 Sep 2024 14:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XUUK4FH9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBE1C19DF99
	for <bpf@vger.kernel.org>; Thu,  5 Sep 2024 14:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725545253; cv=none; b=oFqY51AqTNV8H3P9NmXs0FSyxLmE/Vj2Jp98R76ISCxNd1tr5gFb/0tnQqRt2VpLMkugN1Ll3pUR8eglkEgR15Jub6mendIYgw5/v02bBZIiuLlWcJLF2O2i4okLQyVIQEoAlyOYZbKQg16nxzSyWsf7X0kiNi4CjBPaPWscyis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725545253; c=relaxed/simple;
	bh=ZhDuFPB8i/pdMnH8D6fzK9d2WCVS8v4P3DkRdReEl9Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UC2n9cRV5T+IuQz234ODrkC7so0RDv5jvQHDGrE2JoX7D1El6VUhZeBHJ7jmtVGnLPlw4gAQ8J4wLXrSOI/pbO4Bc6Cc24YXN5HVVZPl0sjHkLrshYQX/j/qrcgXRvd1135mISelEQIO+z+SrpqmggSPNiyZB6I/RHz9z7ZsHIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XUUK4FH9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725545250;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LhN+GibnIvA+qPNPKKBdsGGFPE74LrEC5aoJsFzjbD8=;
	b=XUUK4FH9YRnHXEGYXQwCQLINFjFVGtAjK4yFKebqOEwB/rvZLaDdsgFWtpuOFkm3FWuse1
	XdTh7Gt+IkpcVODv+jKV2SnMq9ZgJF1k00HHf77Hlysj6PM4TGGeP3SfkJunmvw2GKmQ7g
	HqOWUJ1XVGK9k1lM0rN+Mjwb0AW4NfQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-222-oAaeWWVKM_SwEO68_ZVhDw-1; Thu,
 05 Sep 2024 10:07:24 -0400
X-MC-Unique: oAaeWWVKM_SwEO68_ZVhDw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 53A321955F65;
	Thu,  5 Sep 2024 14:07:23 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.224.32])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id CEAEF19560AA;
	Thu,  5 Sep 2024 14:07:19 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Thu,  5 Sep 2024 16:07:13 +0200 (CEST)
Date: Thu, 5 Sep 2024 16:07:08 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tianyi Liu <i.pear@outlook.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, bpf@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv2 bpf-next 1/4] bpf: Fix uprobe multi pid filter check
Message-ID: <20240905140708.GA8336@redhat.com>
References: <20240905115124.1503998-1-jolsa@kernel.org>
 <20240905115124.1503998-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240905115124.1503998-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/05, Jiri Olsa wrote:
>
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -3207,7 +3207,7 @@ static int uprobe_prog_run(struct bpf_uprobe *uprobe,
>  	struct bpf_run_ctx *old_run_ctx;
>  	int err = 0;
>
> -	if (link->task && current->mm != link->task->mm)
> +	if (link->task && !same_thread_group(current, link->task))
>  		return 0;

plus the current check can return false negative if link->task->mm == NULL

Acked-by: Oleg Nesterov <oleg@redhat.com>



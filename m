Return-Path: <bpf+bounces-39822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED8B6977EE5
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 13:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6BD31F21A5B
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 11:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6161D88A8;
	Fri, 13 Sep 2024 11:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DvcZhikQ"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCFC61D6C7F
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 11:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726228376; cv=none; b=cCdWQN+dO20l6l0JfJQzYdp2ApdxRjrf5OSEOuV5UZteguGZCj8DeaWl4bc33ojAnCaLGOaq/Dve9kNvLE/jT8joEis4PZ+nNkz6BxrsE/s65akqaHA0A2PB6iSt86jZp6QMl3A0leZC35ftjpcBg/Y7i7y6cOPm5WfYE0yjgok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726228376; c=relaxed/simple;
	bh=pMCipnQS2GEzxtn5f/uJ+jzhSgUq2j2uXgI3jBB5eCI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CH6Ki+P6USKBRpLUEgYy+M30qSDCsPmNKeQHXHJbvt3IjPz9kyu04QdBjWb5+Gw7RUjxA2svIy6A4OQZ9o9I4CwtFkR0CxfuOB0SZcfBkgo3bwwaxtoNFB8dBD+s05UC70Li6ibL+LqXZSRBv3ZrkG9lSGWCucNuCMFLsli+9YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DvcZhikQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1726228374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kjWhGkYRLL4AoRfx/SSMTKGWIse43z4bAnG3BFGqR34=;
	b=DvcZhikQ0I/oSeStepD2bgto/U/7KWCHWUxjdjXmA88fNqqOo1FtX5uYhiTvy94iJJu52T
	FY6a+dAwGwcW/ttX8NJ+9KA44/ig33NaTgi7MBXaSaA+x1gi/TytQnchungMcsFJ2QPr+K
	F9ZsotFNeS1dRYibEtrzH1zA4pr16NA=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-rBokVC_iPJ6RNTN59bqzpw-1; Fri,
 13 Sep 2024 07:52:50 -0400
X-MC-Unique: rBokVC_iPJ6RNTN59bqzpw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 995611955F07;
	Fri, 13 Sep 2024 11:52:47 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.45.226.25])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 9F46519560AB;
	Fri, 13 Sep 2024 11:52:41 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Fri, 13 Sep 2024 13:52:35 +0200 (CEST)
Date: Fri, 13 Sep 2024 13:52:28 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <20240913115228.GE19305@redhat.com>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909074554.2339984-2-jolsa@kernel.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

On 09/09, Jiri Olsa wrote:
>
> @@ -37,13 +37,16 @@ struct uprobe_consumer {
>  	 * for the current process. If filter() is omitted or returns true,
>  	 * UPROBE_HANDLER_REMOVE is effectively ignored.
>  	 */
> -	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs);
> +	int (*handler)(struct uprobe_consumer *self, struct pt_regs *regs, __u64 *data);
>  	int (*ret_handler)(struct uprobe_consumer *self,
>  				unsigned long func,
> -				struct pt_regs *regs);
> +				struct pt_regs *regs, __u64 *data);

And... I won't insist, but I'd suggest to do this in a separate patch
which should also update the current users in bpf_trace.c, trace_uprobe.c
and bpf_testmod.c.

Then it would be easier to review the next "functional" change. But this
is minor, feel free to ignore.


Finally, imo this documentation in handler_chain()

		/*
		 * The handler can return following values:
		 * 0 - execute ret_handler (if it's defined)
		 * 1 - remove uprobe
		 * 2 - do nothing (ignore ret_handler)
		 */

should be moved to uprobes.h and explain UPROBE_HANDLER_REMOVE/IGNORE there.

And note that "remove uprobe" is misleading, it should say something
like "remove the breakpoint from current->mm".

Oleg.



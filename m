Return-Path: <bpf+bounces-75384-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DD2C8200A
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 19:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6D1DD4E56D1
	for <lists+bpf@lfdr.de>; Mon, 24 Nov 2025 18:01:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9416314B61;
	Mon, 24 Nov 2025 18:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gEGmBRJY"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82DF9BA3F
	for <bpf@vger.kernel.org>; Mon, 24 Nov 2025 18:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764007292; cv=none; b=OU4wrZ+28bdUmUo0IWK2vecsr4hZ3bRcIc1jtmGe0Fb1sVJO/XB5anEx+Ziq+dRLn4w7U4yxTKaQKUPYFLiQnxjbWNYskGlLEyXfWpDKOwlzK1lgMCPXlYyeL+AZPh3xROJi1Q9g2rc8rE3DlvCYRRwDVX9TiBq2erq750uzG0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764007292; c=relaxed/simple;
	bh=2Ytx+AfbbP8o2otQZvERArwaVjbdh3MIdWrkMwyAhiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YieXk0HF0UBUbMOL3jtC1oJzoMc6cW1drPGZ+yqXhYhijUyFqdnRwiWmfAjBmw8gO/2Igr6iFmXKrg+aOSTDnZZMaKGNbhftaAszfM2DbkzMHK5mVtnmkhl5b4Y/XKHNceG6Jvbn6V5GkVQZYiZwvsLz9Tstr0xdmgTGCvYQALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gEGmBRJY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764007289;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=viUvJ6Jb1j9XnKCLQYPTYJox6+KrzbpKeENNCfsboHY=;
	b=gEGmBRJYGY2iDS9M05SG+CtLZbDFuWM8JobD0J3e2jcBHuGwnFg+ltLUIQihS597GuOjA0
	dpoeXQtn9s4wFfoiSKN7wTjjcpIq0zLibYZm6G7h9B0ibYzJES6tFaEEB9cO8l04/vABIl
	BJD7ffWZ1SvXErg5aqEidzK3Lti637g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-29-LlhZ06nDMB2bySU4IiDCOQ-1; Mon,
 24 Nov 2025 13:01:24 -0500
X-MC-Unique: LlhZ06nDMB2bySU4IiDCOQ-1
X-Mimecast-MFC-AGG-ID: LlhZ06nDMB2bySU4IiDCOQ_1764007282
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EF18E195605B;
	Mon, 24 Nov 2025 18:01:21 +0000 (UTC)
Received: from fedora (unknown [10.45.224.27])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id AF1A2195608E;
	Mon, 24 Nov 2025 18:01:15 +0000 (UTC)
Received: by fedora (nbSMTP-1.00) for uid 1000
	oleg@redhat.com; Mon, 24 Nov 2025 19:01:21 +0100 (CET)
Date: Mon, 24 Nov 2025 19:01:14 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ingo Molnar <mingo@kernel.org>,
	David Laight <David.Laight@aculab.com>
Subject: Re: [RFC PATCH 5/8] uprobe/x86: Add support to optimize on top of
 emulated instructions
Message-ID: <aSSdavSy_unRaEgF@redhat.com>
References: <20251117124057.687384-1-jolsa@kernel.org>
 <20251117124057.687384-6-jolsa@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251117124057.687384-6-jolsa@kernel.org>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Hi Jiri,

I am trying to understand this series, will try to read it more carefully
later...

(damn why do you always send the patches when I am on PTO? ;)

On 11/17, Jiri Olsa wrote:
>
>  struct arch_uprobe {
>  	union {
> -		u8			insn[MAX_UINSN_BYTES];
> +		u8			insn[5*MAX_UINSN_BYTES];

Hmm. OK, this matches the "for (i = 0; i < 5; i++)" loop in
opt_setup_xol_ops(), but do we really need this change? Please see
the question at the end.

> +static int opt_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
> +{
> +	unsigned long offset = insn->length;
> +	struct insn insnX;
> +	int i, ret;
> +
> +	if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
> +		return -ENOSYS;

I think this logic needs some cleanups... If ARCH_UPROBE_FLAG_CAN_OPTIMIZE
is set by the caller, the it doesn't make sense to call xxx_setup_xol_ops(),
right? But lets forget it for now.

> +	ret = opt_setup_xol_insns(auprobe, &auprobe->opt.xol[0], insn);

I think this should go into the main loop, see below

> +	for (i = 1; i < 5; i++) {
> +		ret = uprobe_init_insn_offset(auprobe, offset, &insnX, true);
> +		if (ret)
> +			break;
> +		ret = opt_setup_xol_insns(auprobe, &auprobe->opt.xol[i], &insnX);
> +		if (ret)
> +			break;
> +		offset += insnX.length;
> +		auprobe->opt.cnt++;
> +		if (offset >= 5)
> +			goto optimize;
> +	}
> +
> +	return -ENOSYS;

I don't think -ENOSYS makes sense if opt_setup_xol_insns() succeeds at least once.
IOW, how about

	static int opt_setup_xol_ops(struct arch_uprobe *auprobe, struct insn *insn)
	{
		unsigned long offset = 0;
		struct insn insnX;
		int i, ret;

		if (test_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags))
			return -ENOSYS;

		for (i = 0; i < 5; i++) {
			ret = opt_setup_xol_insns(auprobe, &auprobe->opt.xol[i], insn);
			if (ret)
				break;
			offset += insn->length;
			if (offset >= 5)
				break;

			insn = &insnX;
			ret = uprobe_init_insn_offset(auprobe, offset, insn, true);
			if (ret)
				break;
		}

		if (!offset)
			return -ENOSYS;

		if (offset >= 5) {
			auprobe->opt.cnt = i + 1;
			auprobe->xol.ops = &opt_xol_ops;
			set_bit(ARCH_UPROBE_FLAG_CAN_OPTIMIZE, &auprobe->flags);
			set_bit(ARCH_UPROBE_FLAG_OPTIMIZE_EMULATE, &auprobe->flags);
		}

		return 0;
	}

?

This way the caller, arch_uprobe_analyze_insn(), doesn't need to call
push/mov/sub/_setup_xol_ops(), and the code looks a bit simpler to me.

No?

> +      * TODO perhaps we could 'emulate' nop, so there would be no need for
> +      * ARCH_UPROBE_FLAG_OPTIMIZE_EMULATE flag, because we would emulate
> +      * allways.

Agreed... and this connects to "this logic needs some cleanups" above.
I guess we need nop_setup_xol_ops() extracted from branch_setup_xol_ops()
but again, lets forget it for now.

-------------------------------------------------------------------------------
Now the main question. What if we avoid this change

	-             u8                      insn[MAX_UINSN_BYTES];
	+             u8                      insn[5*MAX_UINSN_BYTES];

mentioned above, and change opt_setup_xol_ops() to just do

	-	for (i = 0; i < 5; i++)
	+	for (i = 0;; i++)

?

The main loop stops when offset >= 5 anyway.

And. if auprobe->insn[offset:MAX_UINSN_BYTES] doesn't contain a full/valid
insn at the start, then uprobe_init_insn_offset()->insn_decode() should fail?

Most probably I missed something, but I can't understand this part.

Oleg.



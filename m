Return-Path: <bpf+bounces-9117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6157578FED6
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 16:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AC24281B44
	for <lists+bpf@lfdr.de>; Fri,  1 Sep 2023 14:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B08EC126;
	Fri,  1 Sep 2023 14:19:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1EE3AD41
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 14:19:23 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEFB170F
	for <bpf@vger.kernel.org>; Fri,  1 Sep 2023 07:19:17 -0700 (PDT)
Date: Fri, 1 Sep 2023 16:19:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1693577954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVSHiPc+Wjt2grFVxFSUlfiQYzdzH1UHgChhJ/Olk+M=;
	b=hQSu7/0a+sdNVJCoMPSBVdwXL9+x/vW5FI1UzP1B0l+uh0UYZl2X0MMu1Z6AtAA8ybrRQb
	Epnof31BPPEyqtM5bQCEeDSL8apVQrK1N6RndMMmKr8a96fPfKb1KHsjgckneXGnoxfaGl
	IcrlO13XHpr3GP2oWp20no6/GjiUj7dJHqNIZX3FQyTsQ9BvCzsXreoZqOVzdDPFFWHuNq
	c9a1xTWlbkLaOGiQAIQ1m9U8lUefahcfYuWgz187Jzf9ZKS6EgB6YuBF8OaFarmcCXG0IX
	l6Hs5mriMTlaIRxw/Q+dUi7xTNv2yge3QubYpIvYnMySUj+mNlLoqJ66dQJDBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1693577954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xVSHiPc+Wjt2grFVxFSUlfiQYzdzH1UHgChhJ/Olk+M=;
	b=IAs/lVq/oQbTQmTA0t88WQ+Q/eSmpQo/HLXMrhfB/oO6Sx/N9/DLbinskmMvBVeSAzuUaN
	3KwjW/VMwlfVT6BQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Kui-Feng Lee <kuifeng@fb.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before
 recursion check.
Message-ID: <20230901141908.vMoXrBK6@linutronix.de>
References: <20230830080405.251926-1-bigeasy@linutronix.de>
 <20230830080405.251926-3-bigeasy@linutronix.de>
 <ZPHxAbQDzZVNyXBL@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZPHxAbQDzZVNyXBL@krava>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-01 16:13:04 [+0200], Jiri Olsa wrote:
> On Wed, Aug 30, 2023 at 10:04:05AM +0200, Sebastian Andrzej Siewior wrote:
> > __bpf_prog_enter() assigns bpf_tramp_run_ctx::saved_run_ctx before
> 
> I guess you meant __bpf_prog_enter_recur right?
> 
> > performing the recursion check which means in case of a recursion
> > __bpf_prog_exit() uses the previously set
> > bpf_tramp_run_ctx::saved_run_ctx value.
> > 
> > __bpf_prog_enter_sleepable() assigns bpf_tramp_run_ctx::saved_run_ctx
> 
> __bpf_prog_enter_sleepable_recur ?
> 
> > after the recursion check which means in case of a recursion
> > __bpf_prog_exit_sleepable() uses an uninitialized value.
> > This does not look right. If I read the entry trampoline code right,
> > then bpf_tramp_run_ctx isn't initialized upfront.
> > 
> > Align __bpf_prog_enter_sleepable() with __bpf_prog_enter() and set
> 
> ditto

Yes, in both cases. The ones I mentioned have no conditionals. Sorry.

> jirka

Sebastian


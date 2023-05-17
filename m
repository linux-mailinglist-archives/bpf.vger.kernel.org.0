Return-Path: <bpf+bounces-727-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 038D7705FB7
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 08:09:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F06E81C20B15
	for <lists+bpf@lfdr.de>; Wed, 17 May 2023 06:09:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2567567E;
	Wed, 17 May 2023 06:09:08 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180C5255
	for <bpf@vger.kernel.org>; Wed, 17 May 2023 06:09:08 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4665C30D2
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 23:09:07 -0700 (PDT)
Date: Wed, 17 May 2023 08:09:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1684303745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kTEQVP3/QsoHEr84FslerCi8bQcBpdTanG7Y4VWDBpE=;
	b=sYdoBiPw427PpyF92ZeAJjdaWgUOEIIfeJgMyL4dtGfKIZaLqQyIHC8yZ56lpiqnPBSget
	EIE0iCRjHalALQ5zGKB/FGs1ZJC43Vh1NlUYBg5Ar6PcLlTHB0bs9jVTPPt73M0Jnr4Z2J
	pWf944zw89ISuA0NNE4y9DqHEOR8xtHxu4XWJ4E9O1dQGFDUbzRzcs6nK3XOkWR7b9MU+D
	8DQYkrylcu0SHRKYn0TBoGSNZc/34Y2KuXs0zNIrPA7FpCBadNrfUH+YupqOF+FN9MUkWO
	Ho1iV730iDt9THklmZjOM6ZOmGJ//JMsVVfCeiQ8OoOndRA+5zHsPDmUtvgbXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1684303745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kTEQVP3/QsoHEr84FslerCi8bQcBpdTanG7Y4VWDBpE=;
	b=2+IaMNG6i6PM7tGBFOIqY/vUYTV8x5KMctN3wU9gdTCgdZUJYP+SIyPlvcg1c5iAlhVpTE
	ckeMbLt/3K+Tn8AA==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, bpf <bpf@vger.kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [RFC PATCH] bpf: Remove in_atomic() from bpf_link_put().
Message-ID: <20230517060903.mWi0S23a@linutronix.de>
References: <20230509132433.2FSY_6t7@linutronix.de>
 <CAEf4BzZcPKsRJDQfdVk9D1Nt6kgT4STpEUrsQ=UD3BDZnNp8eQ@mail.gmail.com>
 <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAADnVQLzZyZ+cPqBFfrqa8wtQ8ZhWvTSN6oD9z4Y2gtrfs8Vdg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
	SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-05-16 22:26:01 [-0700], Alexei Starovoitov wrote:
> Sebastian,
Hi Alexei,

> Andrii is correct. We cannot do this unconditionally,
> but we can do it for IS_ENABLED(CONFIG_PREEMPT_RT)
> if it's causing issues on RT, but BPF users won't be happy
> with non deterministic prog detach.
> Do you see a different way of solving it?

Yes. I've been distracted with other things, I get back to it.

Sebastian


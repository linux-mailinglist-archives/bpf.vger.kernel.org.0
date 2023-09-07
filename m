Return-Path: <bpf+bounces-9420-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 140A5797682
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 18:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449791C20BAD
	for <lists+bpf@lfdr.de>; Thu,  7 Sep 2023 16:11:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BA0134B0;
	Thu,  7 Sep 2023 16:11:39 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A3028E7
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 16:11:39 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E4D33AB9
	for <bpf@vger.kernel.org>; Thu,  7 Sep 2023 09:11:11 -0700 (PDT)
Date: Thu, 7 Sep 2023 12:12:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1694081538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6U5abOhWSw3+4J+OxxHRy5LrGr4oNqSnDD1ZY8GQhWA=;
	b=BP2n+vCtLJcOF2HcueqU0ozGi0Uu1lmLRsv1IxDJ25slpCa/t21KqVsjhEdziitDZ0dyGW
	5fvDnyvvxUTcdfeJTj51W3Fppw9e0EToip/uo8jvDyWdTdGgsNAvmDb2l6plZ2n3atBPcQ
	kqGbhrn22MV90o8PwZuJe1zNM+9JWHMbEcChcFGEYGKjt3Dv0KK7UBWgI6sbuvm/5VtbeI
	semLFFOuh5iiH9xmK+93M2lQQLe29PrSpXW+gdtLagmKmK9en/hW0Kf/A7mWRnKGKGadr4
	VgY2TAdcEjQPENeLm0d2aUZIH5FisdpYvHpr0kJVD7gsR9fpVheUddITtZWA+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1694081538;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6U5abOhWSw3+4J+OxxHRy5LrGr4oNqSnDD1ZY8GQhWA=;
	b=vJTq2x5uN0yYinKsOtbjFlZSQGdlCik2wAYS0+unkRBMyU2W3wYbvgFTDc5dWaxjYQLxDk
	U3kIGoG/fnQwZvDw==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>, KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Kui-Feng Lee <kuifeng@fb.com>, Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] bpf: Assign bpf_tramp_run_ctx::saved_run_ctx before
 recursion check.
Message-ID: <20230907101213.Qqv7i5vN@linutronix.de>
References: <20230830080405.251926-1-bigeasy@linutronix.de>
 <20230830080405.251926-3-bigeasy@linutronix.de>
 <ZPHxAbQDzZVNyXBL@krava>
 <20230901141908.vMoXrBK6@linutronix.de>
 <e51947bb-c01b-8bbd-603b-19c11a71ceff@iogearbox.net>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e51947bb-c01b-8bbd-603b-19c11a71ceff@iogearbox.net>
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 2023-09-06 10:52:36 [+0200], Daniel Borkmann wrote:
> Sebastian, I fixed this up and also the __bpf_prog_exit*() presumably should
> have been the _recur flavor.

I'm sorry, for not following up in time. Thank you.

> https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/commit/?id=6764e767f4af1e35f87f3497e1182d945de37f93
> 
> Thanks,
> Daniel

Sebastian


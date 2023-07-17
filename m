Return-Path: <bpf+bounces-5134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8966B756BAC
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 20:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA43F1C20B56
	for <lists+bpf@lfdr.de>; Mon, 17 Jul 2023 18:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B59EC12C;
	Mon, 17 Jul 2023 18:17:11 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03922BE73
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 18:17:10 +0000 (UTC)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295EE10C8
	for <bpf@vger.kernel.org>; Mon, 17 Jul 2023 11:16:39 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 10FCA5C0132;
	Mon, 17 Jul 2023 14:16:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 17 Jul 2023 14:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm2; t=1689617760; x=1689704160; bh=P9
	Dc4ovw8t1HgCkEGdo3NCrF35KmEHIy/ZDVtB4z3pA=; b=09tBiL58CO61cTnw9/
	YnAUolz11ATRtkBWfnTALCEQ505vKpa93a9L/9DFs6Wz56r6R+CwhlZZRF3WgCZ+
	SNjUcEF6Ck8Y/S/aTjBtpF+8enLmBNghqOfqgaogqZqpRb39A3PleyLLl5bFE/+H
	hMzdUycVzLoINL6b9+Qo1Zjpfm/jxnwbHui/TWsiw9OrEKrOiAUj3nAqwFrYVnuG
	9zPd/Ctu9J2576ikO9Joqc91/OK0ll1j/PkN3+MIds7C5F5aVroWsw4S7jW9787V
	Sa0xRdCxN+shU0V7NjEFCV8OZkTCXH+yfjwcKBhPkXeObICbv4iM13tA9pPKVk8v
	shJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm3; t=1689617760; x=1689704160; bh=P9Dc4ovw8t1Hg
	CkEGdo3NCrF35KmEHIy/ZDVtB4z3pA=; b=MzBQu+27cMiE4Xbpk979HafiwOxvP
	CNCt8NHC41QdzkJl9NQbGug3K1t+B/4z3hAu4xtko3lfsn7jZh65FalhOCpF+0lM
	WGhjU6UnrP1R7Yu57mV9bKBVXoiOqZGRM6UAOjXCg+8YbETEgfYgnjA/wJJXLyqA
	z/aPu8DmgU5WlxoK3nUo2UUFTmT4kc9oOKBE/F3dPDafXchYbNHr+ckOFo1oyH1J
	Tp/8sfsjOYacyTSNQJ/D1iXA7R3ZW6aGkitpAHgRyK9bZYQmyikvnWBsees/e/Jz
	4xQSG4EHIDUuhWjAUb9TwDMMP+FyzkIgNbK5EGz967YgJpEHOlx34xaNQ==
X-ME-Sender: <xms:X4W1ZJhu5oWLFTTPKRVx8eTjBZfbriHcCWgbwd7j45vG_oi9E59J4w>
    <xme:X4W1ZODCjxbz2LBKPCHFCkf-gxvRLWPpVgeTjdPbbEZ5x8GvQUBQYIewaDw0t8OZW
    yMHgVtX_-cHPWmB8w>
X-ME-Received: <xmr:X4W1ZJGRK6KpHbqDtpjbSU48HO3JjUIrwRyNQJAbVfuAdUA6rC7saD6F3v0ZsLRInt9Cm7Im1sPEZ1SHzA-DAqsCIOUo0T8p3wal>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedrgedvgdduvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    gfrhhlucfvnfffucdljedtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepvdefkeetuddufeeigedtheefffekuedukeehudffudfffffg
    geeitdetgfdvhfdvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilh
    hfrhhomhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:X4W1ZOSs5GVsHFqgLlfjY3dXibkzM1SuitSor273OZJJjKfSkvbIiw>
    <xmx:X4W1ZGw5JiyXQPXXqY-AWskRXdBIxIMpOdFmrl7f6reZIkpY2T0Tpg>
    <xmx:X4W1ZE4XVDwhhONnD4AxW0jL3OxdNm1C-mEIV8ptIVephp0dBhHTjQ>
    <xmx:YIW1ZNrItfjsSS2g1E7OqIbDujhvJ7sf0gUXy5GMJl_P-g0HLGXWIQ>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Jul 2023 14:15:58 -0400 (EDT)
Date: Mon, 17 Jul 2023 12:15:57 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, David Vernet <void@manifault.com>
Subject: Re: [PATCH bpf-next v1 00/10] Exceptions - 1/2
Message-ID: <vjicfsbmp62pxqpmiyd55sh32ddovr2cosjux3ecsyekpx6ncs@36y7tfs56h3p>
References: <20230713023232.1411523-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713023232.1411523-1-memxor@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Thu, Jul 13, 2023 at 08:02:22AM +0530, Kumar Kartikeya Dwivedi wrote:
> This series implements the _first_ part of the runtime and verifier
> support needed to enable BPF exceptions. Exceptions thrown from programs
> are processed as an immediate exit from the program, which unwinds all
> the active stack frames until the main stack frame, and returns to the
> BPF program's caller. The ability to perform this unwinding safely
> allows the program to test conditions that are always true at runtime
> but which the verifier has no visibility into.
> 
> Thus, it also reduces verification effort by safely terminating
> redundant paths that can be taken within a program.
> 
> The patches to perform runtime resource cleanup during the
> frame-by-frame unwinding will be posted as a follow-up to this set.
> 
> It must be noted that exceptions are not an error handling mechanism for
> unlikely runtime conditions, but a way to safely terminate the execution
> of a program in presence of conditions that should never occur at
> runtime. They are meant to serve higher-level primitives such as program
> assertions.

Sure, that makes sense.

> 
> As such, a program can only install an exception handler once for the
> lifetime of a BPF program, and this handler cannot be changed at
> runtime. The purpose of the handler is to simply interpret the cookie
> value supplied by the bpf_throw call, and execute user-defined logic
> corresponding to it. The primary purpose of allowing a handler is to
> control the return value of the program. The default handler returns 0
> when from the program when an exception is thrown.
> 
> Fixing the handler for the lifetime of the program eliminates tricky and
> expensive handling in case of runtime changes of the handler callback
> when programs begin to nest, where it becomes more complex to save and
> restore the active handler at runtime.
> 
> The following kfuncs are introduced:
> 
> // Throw a BPF exception, terminating the execution of the program.
> //
> // @cookie: The cookie that is passed to the exception callback. Without
> //          an exception callback set by the user, the programs returns
> //          0 when an exception is thrown.
> void bpf_throw(u64 cookie);

If developers are only supposed to use higher level primitives, then why
expose a kfunc for it? The above description makes it sound like this
should be an implementation detail.

[...]

Thanks,
Daniel


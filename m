Return-Path: <bpf+bounces-62090-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C3E51AF0FF0
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 11:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 948FE4A4096
	for <lists+bpf@lfdr.de>; Wed,  2 Jul 2025 09:28:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C8F2459D4;
	Wed,  2 Jul 2025 09:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgPBYoOE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0B519E81F
	for <bpf@vger.kernel.org>; Wed,  2 Jul 2025 09:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751448529; cv=none; b=DHjq5hrmscSSjqa+G7TIBIng0tKyHl3FCGTFovImS2WcqrZZ6elXYChfF6GpL4r0ex3ySHZgIanrB7KIzWdaY1Eh2lN47as004edIECHVMaShb6qgnh5ooDf9wCNMT1R/EOCVrTI7LKKvnE8P/OIXDAD+gB+tUE3CqxC7zKNV/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751448529; c=relaxed/simple;
	bh=HFAfuoiOYgSAbB0HlyrBa4CIGbjBBJUGVGml0bVLGss=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=feU6CQQ3thGlukqzImkoOPJFfDwTgzr2yV02SJQdK1Cy4DRytBsKeFE67PLMEVvZ6GDa/m3n1FkgMSB8n3E7pwxtERs1o7ZPuOJvr9O1cx0V5n1njTLUFjeagyN3TrbogQB0oHKaf8HjSS0C8qVqEwS9w+09ByfUjXUyA6L61aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgPBYoOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB36C4AF0B;
	Wed,  2 Jul 2025 09:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751448528;
	bh=HFAfuoiOYgSAbB0HlyrBa4CIGbjBBJUGVGml0bVLGss=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=SgPBYoOEKa8jK/wWuYcUdRTnAagiTfxHuFieT9NtOYDx0uttRV72KqKc0k2LSW60m
	 11Yt/US1nAExiE/BBtmrX1ycMnUV39g5xCKpHxN5UL9U7v3H8/kFyzFL7o4B4aHxeI
	 rLe9mqglF41PzDCVGnZAtDMbslUJiVv7P7iBXG4s5qwqSFvf9Sg79oYBw+MvR3O+VW
	 6ielfXR/m5UMkH2AcGbk/uxNPxDRCKAJa8FM0z5NwS7TpWbjUgfWW5qvJguYV99AUq
	 VLrLYzonEoMMpwtNqSrWmp+J11mLAtwb9W78hbsI7WHqLaZwLJ3zcRvuTIT33sCCY/
	 aYzb3B8TvguTQ==
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfauth.phl.internal (Postfix) with ESMTP id 475B1F40066;
	Wed,  2 Jul 2025 05:28:47 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-05.internal (MEProxy); Wed, 02 Jul 2025 05:28:47 -0400
X-ME-Sender: <xms:z_tkaDnTOsXioL5FvlhKApTIoCbH3dKx7Gb8XsPB7c6dbknKmhYfcw>
    <xme:z_tkaG1BU0KEVfjU2guuh9cxUuUJ2Pak7akI0MtWvOrpJhrZuj1pgxcH0AqHBr1Oc
    EkqaVoiBBDwitY4SKA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefoggffhffvvefkjghfufgtgfesthejredtredttdenucfhrhhomhepfdetrhhnugcu
    uegvrhhgmhgrnhhnfdcuoegrrhhnugeskhgvrhhnvghlrdhorhhgqeenucggtffrrghtth
    gvrhhnpeejteeguefhffevgfehueetudevieeuueffhedvvefhjedthfdutdethefgfeek
    leenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomheprghrnhguodhmvghsmhhtphgruhhthhhpvghr
    shhonhgrlhhithihqdduvdekhedujedtvdegqddvkeejtddtvdeigedqrghrnhgupeepkh
    gvrhhnvghlrdhorhhgsegrrhhnuggsrdguvgdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepkhgvrhhnvghlqdhtvggrmhesfhgsrdgtohhmpd
    hrtghpthhtohepuggrnhhivghlsehiohhgvggrrhgsohigrdhnvghtpdhrtghpthhtohep
    rghnughrihhisehkvghrnhgvlhdrohhrghdprhgtphhtthhopegrshhtsehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehmrghrthhinhdrlhgruheskhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohephihonhhghhhonhhgrdhsohhngheslhhinhhugidruggvvhdprhgtphhtth
    hopegsphhfsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:z_tkaJohF9j0r-pIPpJdcC4mY6Fy2a2JBrMSwB5QsFkEQi9EzTxGFw>
    <xmx:z_tkaLkW5ZTC6peq_tOG44Tq7bZU7vH4MjFLaDBqMhBNeuRiyIUZpA>
    <xmx:z_tkaB2nxNQfg2soPDy_EVpT66p6ZTE8aBrKdXC53CzUnJ7Ki_7LzQ>
    <xmx:z_tkaKvRgfvEVOMrgRcb4brASvBqlwVwJVgsWEmI0cQCWMXnbowJWg>
    <xmx:z_tkaFV55766m_2ZSYOON3jekW_u22DAmINcjfxYYOCRrmNOj6T3lSZY>
Feedback-ID: i36794607:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 201A7700069; Wed,  2 Jul 2025 05:28:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: T0d36e4a7600bae39
Date: Wed, 02 Jul 2025 11:28:26 +0200
From: "Arnd Bergmann" <arnd@kernel.org>
To: "Yonghong Song" <yonghong.song@linux.dev>, bpf@vger.kernel.org
Cc: "Alexei Starovoitov" <ast@kernel.org>,
 "Andrii Nakryiko" <andrii@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, kernel-team@fb.com,
 "Martin KaFai Lau" <martin.lau@kernel.org>
Message-Id: <8300caad-1919-47cf-bdd1-481c30c5f4c3@app.fastmail.com>
In-Reply-To: <20250702053332.1991516-1-yonghong.song@linux.dev>
References: <20250702053332.1991516-1-yonghong.song@linux.dev>
Subject: Re: [PATCH bpf-next 1/2] bpf: Reduce stack frame size by using env->insn_buf
 for bpf insns
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Wed, Jul 2, 2025, at 07:33, Yonghong Song wrote:
> Arnd Bergmann reported an issue ([1]) where clang compiler (less than
> llvm18) may trigger an error where the stack frame size exceeds the 
> limit.
> I can reproduce the error like below:
>   kernel/bpf/verifier.c:24491:5: error: stack frame size (2552) exceeds 
> limit (1280) in 'bpf_check'
>       [-Werror,-Wframe-larger-than]
>   kernel/bpf/verifier.c:19921:12: error: stack frame size (1368) 
> exceeds limit (1280) in 'do_check'
>       [-Werror,-Wframe-larger-than]
>
> Use env->insn_buf for bpf insns instead of putting these insns on the
> stack. This can resolve the above 'bpf_check' error. The 'do_check' error
> will be resolved in the next patch.
>
>   [1] https://lore.kernel.org/bpf/20250620113846.3950478-1-arnd@kernel.org/
>
> Reported-by: Arnd Bergmann <arnd@kernel.org>
> Signed-off-by: Yonghong Song <yonghong.song@linux.dev>

I have confirmed that the fix addresses the issue in bpf_check().
In the worst case I see on an arm64 (clang-15, kasan) randconfigs,
the bpf_stack usage goes down from 1680 bytes to 1024.

On powerpc64 (clang-15, allmodconfig, kasan), I see an even larger
reduction from from 2112 bytes to 1200 for bpf_check().

Tested-by: Arnd Bergmann <arnd@arndb.de>

However, I still see 1952 bytes used in do_check() on powerpc64
allmodconfig. This number is much lower in newer clang versions,
I see 1888 bytes for clang-19 but only 1232 bytes for clang-20
and -21. Roughly a third of the 1952 bytes seems to come from
each one of do_check_insn() and is_state_visited(), but I haven't
found where exactly the stack is consumed there. This may be
a powerpc specific issue since on arm64 the same function needs
less than 1KB stack space.

I also tried turning off individual sanitizers (kasan, array-bounts,
trace-pc, ...) and they each seem to have a notable impact on
the total stack usage of powerpc64 do_check(), i.e. it's
not just a problem triggered by kasan or one particular other
option.

      Arnd


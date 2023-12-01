Return-Path: <bpf+bounces-16468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB2B8014D5
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 21:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 898AB281DFA
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 20:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF92758AAE;
	Fri,  1 Dec 2023 20:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="nIg0wlqJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KlTtA6eZ"
X-Original-To: bpf@vger.kernel.org
Received: from new1-smtp.messagingengine.com (new1-smtp.messagingengine.com [66.111.4.221])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C91C710D;
	Fri,  1 Dec 2023 12:51:48 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailnew.nyi.internal (Postfix) with ESMTP id 1616B580C55;
	Fri,  1 Dec 2023 15:51:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 01 Dec 2023 15:51:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701463908; x=1701471108; bh=nK
	6LDD0U/Eoft2OMP2N2jIS27TuNzocTptkvpWvSp38=; b=nIg0wlqJmQgXCJuSDe
	92opTTkESihZX/Vg+hr56JZfOTb/wJHRhYAT0gFgqhaMf0UFj+sQ9YOEBZzb4THf
	hVsLO+HLag8r8iXKOlqvQrJwj7Q7mjfpwCjuzfzdqkL839ubPiI83D1rSVLKkn3T
	X0f+ypmSuv4i17xXHAQ4hbaZcND+vagqN5lHW1g7ffj0+Pwrh61aR9W8hVlFwfbf
	+nisRjKKfWSvmcfZOZ9SFR90/1vWF2gbFi6gLSRECJ+WcZcvZF//G2eRazd/4MYl
	n+bxHhlZoqpczSaZac477GzLBCoCd/TIaAYsXT4ECq0BYpUiKj0zPy3fWZzmTKWQ
	qleA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701463908; x=1701471108; bh=nK6LDD0U/Eoft
	2OMP2N2jIS27TuNzocTptkvpWvSp38=; b=KlTtA6eZzg0M3pIQr2eDndN+IiA/W
	QJ+ZVpHZzSIG27e/3SRLqTZBx4B/hO2kdBseqEgy9ERGf+aB+pE201vJ19clUMSh
	3cMMl9+qjM4+jfzpX8zpUnv8eqVj0oYQbkgUPDtn72poDdvrJqTcDIEDCEnb7oeq
	ENf1qiMzvajJGsVoBKudmk37r3sRu/jKOCYfXnvt26mUEzksbi5lprCz7thOo4ox
	23I7aElDYSVI3XgFMNAxqs9xsjzmPCNtgAFPWfchnUPy6HdRfGpx69GozTImpjel
	h3AA2zJetUZaAH2Y6SKGxrFQtVzEpAZkky3nYVH7J4jI3sTt1r4XCjxDA==
X-ME-Sender: <xms:Y0dqZdWw7Z57e_F_jzT6r77jA0oChVoCY-e3yhbfkKF2hBvfhnENEw>
    <xme:Y0dqZdnEZTpBK67nO26_viJxeoRX99IjOGl2jh4KJUtapmauTVnk-uMH-Eb3TjFKX
    Ixm3b2SV2qsjJp-ZQ>
X-ME-Received: <xmr:Y0dqZZYenOkTMeGG3PeTLGtgu6UpKfVY7QxNQKEl0KQmYEsOb-4QL9WMLQja40f2RIpPNHHKUkHRldbUlNKxnI-nUmhvOmiYnsBBjbU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeiledgudegvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculddvfedmnecujfgurhepfffhvffukfhfgggtuggjsehttdfstddt
    tddvnecuhfhrohhmpeffrghnihgvlhcuighuuceougiguhesugiguhhuuhdrgiihiieqne
    cuggftrfgrthhtvghrnhepkeehjeekudeltdeljeehhfefjeevjefgudfhteehlefftdfh
    hfduieeiieeifeelnecuffhomhgrihhnpehllhhvmhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:Y0dqZQU2H0aSXaMmYGtnXM6NhyhX8jPS57zW40zKz6W3tC-BEDk4kQ>
    <xmx:Y0dqZXlCskQjQ51LmOLr2-gvpbSVz_2nlLzOcxkNcNVXj7RU5idvZw>
    <xmx:Y0dqZdefER4FRLOR8mmKFjBUlM_l_64-lCV-0fSvzWx0fCI3-DDyCA>
    <xmx:ZEdqZZXZvPoszJ8kX480_MlkQBL4KrHQk4d1Ca-kpSKmH3qbMdYlbw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 1 Dec 2023 15:51:46 -0500 (EST)
Date: Fri, 1 Dec 2023 13:51:44 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: ndesaulniers@google.com, daniel@iogearbox.net, nathan@kernel.org, 
	ast@kernel.org, andrii@kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, alexei.starovoitov@gmail.com, yonghong.song@linux.dev, 
	eddyz87@gmail.com, martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	trix@redhat.com, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	llvm@lists.linux.dev, devel@linux-ipsec.org, netdev@vger.kernel.org, 
	Jonathan Lemon <jlemon@aviatrix.com>
Subject: Re: [devel-ipsec] [PATCH ipsec-next v3 3/9] libbpf: Add
 BPF_CORE_WRITE_BITFIELD() macro
Message-ID: <2schji4oladptrev3tswmwkbhspz6mdy5u2v7tvll4du7iylri@2u2zmfdzn6fm>
References: <cover.1701462010.git.dxu@dxuuu.xyz>
 <adea997dff6d07332d294ad9cd233f3b71494a81.1701462010.git.dxu@dxuuu.xyz>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adea997dff6d07332d294ad9cd233f3b71494a81.1701462010.git.dxu@dxuuu.xyz>

On Fri, Dec 01, 2023 at 01:23:14PM -0700, Daniel Xu via Devel wrote:
> === Motivation ===
> 
> Similar to reading from CO-RE bitfields, we need a CO-RE aware bitfield
> writing wrapper to make the verifier happy.
> 
> Two alternatives to this approach are:
> 
> 1. Use the upcoming `preserve_static_offset` [0] attribute to disable
>    CO-RE on specific structs.
> 2. Use broader byte-sized writes to write to bitfields.
> 
> (1) is a bit hard to use. It requires specific and not-very-obvious
> annotations to bpftool generated vmlinux.h. It's also not generally
> available in released LLVM versions yet.
> 
> (2) makes the code quite hard to read and write. And especially if
> BPF_CORE_READ_BITFIELD() is already being used, it makes more sense to
> to have an inverse helper for writing.
> 
> === Implementation details ===
> 
> Since the logic is a bit non-obvious, I thought it would be helpful
> to explain exactly what's going on.
> 
> To start, it helps by explaining what LSHIFT_U64 (lshift) and RSHIFT_U64
> (rshift) is designed to mean. Consider the core of the
> BPF_CORE_READ_BITFIELD() algorithm:
> 
>         val <<= __CORE_RELO(s, field, LSHIFT_U64);
>                 val = val >> __CORE_RELO(s, field, RSHIFT_U64);
> 
> Basically what happens is we lshift to clear the non-relevant (blank)
> higher order bits. Then we rshift to bring the relevant bits (bitfield)
> down to LSB position (while also clearing blank lower order bits). To
> illustrate:
> 
>         Start:    ........XXX......
>         Lshift:   XXX......00000000
>         Rshift:   00000000000000XXX
> 
> where `.` means blank bit, `0` means 0 bit, and `X` means bitfield bit.
> 
> After the two operations, the bitfield is ready to be interpreted as a
> regular integer.
> 
> Next, we want to build an alternative (but more helpful) mental model
> on lshift and rshift. That is, to consider:
> 
> * rshift as the total number of blank bits in the u64
> * lshift as number of blank bits left of the bitfield in the u64
> 
> Take a moment to consider why that is true by consulting the above
> diagram.
> 
> With this insight, we can how define the following relationship:
> 
>               bitfield
>                  _
>                 | |
>         0.....00XXX0...00
>         |      |   |    |
>         |______|   |    |
>          lshift    |    |
>                    |____|
>               (rshift - lshift)
> 
> That is, we know the number of higher order blank bits is just lshift.
> And the number of lower order blank bits is (rshift - lshift).
> 
> Finally, we can examine the core of the write side algorithm:
> 
>         mask = (~0ULL << rshift) >> lshift;   // 1
>         nval = new_val;                       // 2
>         nval = (nval << rpad) & mask;         // 3
>         val = (val & ~mask) | nval;           // 4
> 
> (1): Compute a mask where the set bits are the bitfield bits. The first
>      left shift zeros out exactly the number of blank bits, leaving a
>      bitfield sized set of 1s. The subsequent right shift inserts the
>      correct amount of higher order blank bits.
> (2): Place the new value into a word sized container, nval.
> (3): Place nval at the correct bit position and mask out blank bits.
> (4): Mix the bitfield in with original surrounding blank bits.
> 
> [0]: https://reviews.llvm.org/D133361
> Co-authored-by: Eduard Zingerman <eddyz87@gmail.com>
> Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>

Just pointing out I inserted Eduard's tags here. Eduard - I hope that's
OK. Not sure what the usual procedure for this is.

> Co-authored-by: Jonathan Lemon <jlemon@aviatrix.com>
> Signed-off-by: Jonathan Lemon <jlemon@aviatrix.com>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> ---
>  tools/lib/bpf/bpf_core_read.h | 34 ++++++++++++++++++++++++++++++++++
>  1 file changed, 34 insertions(+)
> 

[..]


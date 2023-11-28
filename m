Return-Path: <bpf+bounces-16074-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1B527FC418
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 20:16:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62786282C3F
	for <lists+bpf@lfdr.de>; Tue, 28 Nov 2023 19:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 891F846BA0;
	Tue, 28 Nov 2023 19:15:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="Ie5DH8Oh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YC5rg7c9"
X-Original-To: bpf@vger.kernel.org
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D67D66;
	Tue, 28 Nov 2023 11:15:52 -0800 (PST)
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailnew.west.internal (Postfix) with ESMTP id BA6E32B0011C;
	Tue, 28 Nov 2023 14:15:46 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Tue, 28 Nov 2023 14:15:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1701198946; x=1701206146; bh=cY
	OZQ38Ev4q/vOiKyAZOmafzVAVzihcQxUYgmkqmmR8=; b=Ie5DH8OhUPUS8UVIYu
	QAQsUPJ9SijS+yZOJ+Ohi5LFlA/p5S0YB+RXSN7Zt+8en9SveUsXAp0VAi9gPp8P
	4qBjAis12AEHiocvAYrct/whzkR3nM/jTjS+80fKg6ofcyl9g2180gHC8xn5h5Xx
	RZ02k/gjuafT82Wyt8+ZEUrQHDODZtstEhyqAleHaD4hwrIJ/2Z0cpJGgJrFaEYi
	/WIHpOkDZ4HpEAO2A42u6wQ4+PBEqMYeoNKiIIY+1W7mAMSdFPISV5EXVE4uPl4M
	dN2YdCgajG7AXSN6ecG42gj7eTm/Mf5mrT1vBSqjkdtSVnPQXV6oksOnPgtpAFkx
	azjw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1701198946; x=1701206146; bh=cYOZQ38Ev4q/v
	OiKyAZOmafzVAVzihcQxUYgmkqmmR8=; b=YC5rg7c9WsU6h0PUBFWCMz3/MqM/q
	F6rk44aqQmxnOCPdnvXRroqJetVbIFMTF2/hnU784IvyOxENW/Y4S7CGDVwmRQds
	igPUY7H3pPRbuiPZbcqjXSgOQ7im8U1yHi1bxQdcO/x53kLD1yXh6Q/Kbj4nkhWg
	7P7U6qgzXJ/DMm0vbRDyKYqzIIGr1RBErTT0N/GbVGalvYhAbPneZY2XzzQOBTRh
	WZJBuK5430+bnChoZg8+8+Ih5ZuwcjNLWDur+MDFRknahYlaG17xc/xPXRQJ+Z/v
	k5pdVR3usMcL2tx7TZfVBdPTjMD3N2FsO3RkBmy8SxmvQaO766x+Lvs3g==
X-ME-Sender: <xms:YTxmZemDR2Zp5BW8BSnqqAJUlILJmN4imWjRRsC0DKqoaS1ja1KJrw>
    <xme:YTxmZV2cuL1rSVyZDC99LEJg9VubIpekL5NLFI8KbBR6cJIijLFXm3ydLpioXO_0G
    c-M1Nt-kkAtYlOlhg>
X-ME-Received: <xmr:YTxmZcp5MmfhDXwerCoDXicQiD6Fcc3am3PXmAlvvlxU9tg4xDvuLoZaggR8K4uyaeul9A7-1bBZDfhNTApxF0fhVrBjnREGBJWBdwrF29oikqrGUiEJ02Ry19I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudeifedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhepff
    fhvfevuffkfhggtggujgesthdtsfdttddtvdenucfhrhhomhepffgrnhhivghlucgiuhcu
    oegugihusegugihuuhhurdighiiiqeenucggtffrrghtthgvrhhnpeeftdffueduheehud
    fhgefgfeejlefhteegieetveeiieehfedvheduieefvdefudenucffohhmrghinheplhhl
    vhhmrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepugiguhesugiguhhuuhdrgiihii
X-ME-Proxy: <xmx:YTxmZSnDBAGMNn0wrHlKa4ShF4GfCH1zBOmiSCrSXLV1U-8wdqjy2A>
    <xmx:YTxmZc2ybWod_0nq7HjvY4tpPGXravJUC-sNOGlBcz3b6tKMy6lKpA>
    <xmx:YTxmZZvrO_uTXm18VGI5udd6Mi7G-iDhIZYTGxIcvuwA1986V62mwA>
    <xmx:YjxmZX_Qrp3OfPKr5yKsoaOYZrrB65tYaj5VIehQJLR-JzuMhsYoAv2BgUw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Nov 2023 14:15:43 -0500 (EST)
Date: Tue, 28 Nov 2023 13:15:41 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: ndesaulniers@google.com, andrii@kernel.org, nathan@kernel.org, 
	daniel@iogearbox.net, ast@kernel.org, steffen.klassert@secunet.com, 
	antony.antony@secunet.com, alexei.starovoitov@gmail.com, yonghong.song@linux.dev, 
	martin.lau@linux.dev, song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, trix@redhat.com, 
	bpf@vger.kernel.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	devel@linux-ipsec.org, netdev@vger.kernel.org
Subject: Re: [PATCH ipsec-next v2 3/6] libbpf: Add BPF_CORE_WRITE_BITFIELD()
 macro
Message-ID: <qcjvpbuhnj3jwbc5gb5c3tmla7scwpxuwgcqgfbvc6ewwjej3j@o7t3f6wacwps>
References: <cover.1701193577.git.dxu@dxuuu.xyz>
 <ed7920365daf5eff1c82892b57e918d3db786ac7.1701193577.git.dxu@dxuuu.xyz>
 <20c593b6f31720a3d24d75e5e5cc3245b67249d1.camel@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20c593b6f31720a3d24d75e5e5cc3245b67249d1.camel@gmail.com>

On Tue, Nov 28, 2023 at 07:59:01PM +0200, Eduard Zingerman wrote:
> On Tue, 2023-11-28 at 10:54 -0700, Daniel Xu wrote:
> > Similar to reading from CO-RE bitfields, we need a CO-RE aware bitfield
> > writing wrapper to make the verifier happy.
> > 
> > Two alternatives to this approach are:
> > 
> > 1. Use the upcoming `preserve_static_offset` [0] attribute to disable
> >    CO-RE on specific structs.
> > 2. Use broader byte-sized writes to write to bitfields.
> > 
> > (1) is a bit a bit hard to use. It requires specific and
> > not-very-obvious annotations to bpftool generated vmlinux.h. It's also
> > not generally available in released LLVM versions yet.
> > 
> > (2) makes the code quite hard to read and write. And especially if
> > BPF_CORE_READ_BITFIELD() is already being used, it makes more sense to
> > to have an inverse helper for writing.
> > 
> > [0]: https://reviews.llvm.org/D133361
> > From: Eduard Zingerman <eddyz87@gmail.com>
> > 
> > Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
> > ---
> 
> Could you please also add a selftest (or several) using __retval()
> annotation for this macro?

Sure, I'll take a look.

Thanks,
Daniel


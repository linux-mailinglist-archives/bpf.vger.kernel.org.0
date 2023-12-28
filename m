Return-Path: <bpf+bounces-18703-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A2381F448
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 04:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236111C2179B
	for <lists+bpf@lfdr.de>; Thu, 28 Dec 2023 03:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2401F3C1D;
	Thu, 28 Dec 2023 03:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="H9HwezNJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0eXsmHa"
X-Original-To: bpf@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 794663C0B
	for <bpf@vger.kernel.org>; Thu, 28 Dec 2023 03:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id 6248C5C019E;
	Wed, 27 Dec 2023 22:10:20 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 27 Dec 2023 22:10:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1703733020; x=1703819420; bh=hCgpk3ygA1
	pVep5+d2FRtMnN3gNn9ecaJnc5WRpNUMY=; b=H9HwezNJG8nBMD920BDIJmW1sf
	3GPunKoY6bvjUl+T0MINBvMQgwmH3rT+8UNflIPigFJrnMktaeL6Xri/5O5Il8Aj
	0wbuJDGPJZiBojReAvxWxrI1ywoSZUKEpdQ+jz9P5KVqN1A7Fa3YyYOAbl3hMU9U
	/L0jJ/vaPgGPpujQB34nUmepILPuojfVnTgY9TQbFEVDHJDSO3iW11w9BMSb2uUc
	Gz4K+yNTwg5uG9Pr/Cb1/ZIY8SnDGeBVW41EaB81jySSErez3Nfk0K5JvqvKRj58
	ZbjiQDW63qx+wMe3VC8hoPl71yNt8ZFryIVsHbuUpGLm2orL2szUm45WJo3Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1703733020; x=1703819420; bh=hCgpk3ygA1pVep5+d2FRtMnN3gNn
	9ecaJnc5WRpNUMY=; b=k0eXsmHapM9Wlcz42HQA4F0a/4buB1KnZMjhuU9TV4N9
	sD/hXhZcNR1Ei+6pE4k/4syn7je2espJ8TTanKPnCTyamX7t5pXFX3V5EX43Jf2X
	qhpbzyPS1GsUQzUzvrvcGHXncl+R2dEamRvoq37r6ObJkC6VXERdpH9bMGhzcAvK
	Q1aA28rmSa22qRFHnsd5xbWl7GCiE6y0KFunrvgDGLRW+9Zov4BXHJ9r41QvhQTM
	vGpImYzWJmlW9Osu116b55xvfvL0A02q5gUV+6Kj4OFylyW8o87D+0JWcABN49+c
	Zpxi2OriF7CgFdHLNzl1wtOBOr56vDydBp3WrHS6fQ==
X-ME-Sender: <xms:HOeMZawFjzswiNJIXfP_QY6v1ntoYWZCi8VwdbioygWAUjQdzv0fcg>
    <xme:HOeMZWQOhIUxe7YQZQ4DnIZadn0zbdV1Wx6LM4UIxjjC55qQXEX8Qax6Hv6cjcMiA
    lZKf__d54NIqmDnRA>
X-ME-Received: <xmr:HOeMZcVQuHGbydXF58XYFYOLwXCZvnp8kGVpkFTC8xn54BKBlyikCnZdR6eU31nzgvUju5NHN1zICVOkY1MM_Val5A0ffrS1Ql57y5u5ky3COvRg1DXxOE78OhY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeftddgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdljedtmdenucfjughrpeffhf
    fvvefukfhfgggtuggjsehttdfstddttddvnecuhfhrohhmpeffrghnihgvlhcuighuuceo
    ugiguhesugiguhhuuhdrgiihiieqnecuggftrfgrthhtvghrnhepgeetteduteevffffle
    dviefgffekgfdvhffhgfevjedutdefueehudegkeelveeunecuffhomhgrihhnpehthhhi
    shdrthhoohhlshenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:HOeMZQjOipSPQGM5zpGLUVBTVV6_3lqLLz1aOeq1DFnmLoAGcSi5-w>
    <xmx:HOeMZcCt2A8YJdcZ_EanPv8VyzK0z0MM7RzUQcrsNp5KdU3S9-RgkQ>
    <xmx:HOeMZRIXQ5nPDSoRZfzuBnAMaeCx3STxkUuA7c3KvyD-QGPYLfFotg>
    <xmx:HOeMZXrhslJ4SHeB4FGW7pq7vEhCe8Oo22z5LbU-ZcQwYbXIKfDw-g>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 27 Dec 2023 22:10:19 -0500 (EST)
Date: Wed, 27 Dec 2023 21:10:18 -0600
From: Daniel Xu <dxu@dxuuu.xyz>
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Subject: Re: progs/test_tunnel_kern.c:802:43: error: use of undeclared
 identifier 'FOU_BPF_ENCAP_FOU'
Message-ID: <lc2bp2dzzn3jtwjunfgdifppmtjj27dargat276utybmjndzn7@tvzhqos2u5vd>
References: <CAK3+h2z-aymvqqCnuh_LgdF_PnOBRd5PxF7LQxHcQ4uoEirsDQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK3+h2z-aymvqqCnuh_LgdF_PnOBRd5PxF7LQxHcQ4uoEirsDQ@mail.gmail.com>

Hi Vincent,

On Wed, Dec 27, 2023 at 06:59:12PM -0800, Vincent Li wrote:
> Hi,
> 
> When I make the bpf-next master branch bpf selftests, which failed
> with error below, seems related to commit 02b4e126e6 bpf: selftests:
> test_tunnel: Use vmlinux.h declarations ?
> 
>   CLNG-BPF [test_maps] test_tunnel_kern.bpf.o
> 
> progs/test_tunnel_kern.c:30:13: error: declaration of 'struct
> bpf_fou_encap' will not be visible outside of this function
> [-Werror,-Wvisibility]
> 
>                           struct bpf_fou_encap *encap, int type) __ksym;
> 
>                                  ^
> 
> progs/test_tunnel_kern.c:32:13: error: declaration of 'struct
> bpf_fou_encap' will not be visible outside of this function
> [-Werror,-Wvisibility]
> 
>                           struct bpf_fou_encap *encap) __ksym;
> 
>                                  ^
> 
> progs/test_tunnel_kern.c:741:23: error: variable has incomplete type
> 'struct bpf_fou_encap'

[...]

Do you have CONFIG_NET_FOU enabled? I think you'll need that for
test_tunnel to build correctly. BPF CI enables this.
tools/testing/selftests/bpf/config has it set to =y.

Thanks,
Daniel


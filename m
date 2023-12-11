Return-Path: <bpf+bounces-17460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6A8B80DE37
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 23:27:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F18C281F5D
	for <lists+bpf@lfdr.de>; Mon, 11 Dec 2023 22:27:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8437255799;
	Mon, 11 Dec 2023 22:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="ZZlSJsiA";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xeo/K0ah"
X-Original-To: bpf@vger.kernel.org
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64813AD;
	Mon, 11 Dec 2023 14:26:59 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 0F6535C0275;
	Mon, 11 Dec 2023 17:26:56 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 11 Dec 2023 17:26:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:sender
	:subject:subject:to:to; s=fm3; t=1702333616; x=1702420016; bh=hZ
	hhMs/oMiL/6xoxqOZLivYo3XO3IpkCCaEeLusob9M=; b=ZZlSJsiAKQqBrDDSFB
	87xSTMwEmeD4Ul/8LLjgGcgGTeU4fmnJ8gwJ3aqu/pnqv/wZGejm2uAYruGGtE2q
	oPi5j3YP+7O2XBHARLrUR2mzOJaZwAO62r53Q1IG5V3MnJ2DlZlKq2ZS7jssNqwM
	6PbQ8WfwLovpbVuJuabNayY5P1GlDXGpqDAtPmVlYDWb0P0I6Rjtbtf/aqEyQCty
	ltZaIq6WTM7zMeZMLVLLQlCeRZmH4B5zM/X2urSo+esbdKoc0R9AdmsyXOQ5+d3u
	tRWJCGBtjKeBpOwXMqd1WoQ5ijJ3ik4ngrdppv7CN0ssTnkfSf0OwQrfWPcoPCEh
	MnBw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:sender:subject
	:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
	:x-sasl-enc; s=fm1; t=1702333616; x=1702420016; bh=hZhhMs/oMiL/6
	xoxqOZLivYo3XO3IpkCCaEeLusob9M=; b=Xeo/K0ahAmVTZeokWnp7xEQ+u0aEL
	4YbAWpU0IE7M2syCD/aa6cW0jkJ6TNbaYV2d2CIKyNjjaaJyCvj8ZTvqzptrIE4u
	2Wcf/bNc6UdLaObumqjIGabAO1YXqI4IfgLblMPZEaSGO9Fv8i1EXkkLrIDP26Gm
	ndEkfUntR5T9TSUS8dhu0pJ9NsWO3vorrO+WhA8DqGEq6w0oNGpPIsXGWGPmBbZT
	bThaPnBszkUbxSCkXwOWYG5EjgBCqyAvLENNbvCb1fN5QPVfCgebJS32WJtkjss1
	CgjSAeOqMWXLY8JSN07J8rAYwaoRS3EKYOaVpt48IddYTZ3o9+JbP2+Fg==
X-ME-Sender: <xms:rox3ZWFI0QmnvR_DlW8BNPsfqUobIAIzah1eeu20qsY_ScuNU9K3eA>
    <xme:rox3ZXUThVSebZroGKHG-3knIyokjwCwacFAdeK-IwzqUbntYfVg054CzNTHQxkQ3
    IgBxbHEZztO0CxGaQ>
X-ME-Received: <xmr:rox3ZQK_YOkh4D-sdjuRxaxR5-Q13qsOF3zHQtDSsSRwJzKly9MbfOyV6mzUL6iSqQ22oF6-AQSt76HGuqTU0Jpjry5rUlbRdk7z>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrudelvddgudeifecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
    tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffff
    gfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:rox3ZQGMiGCjcRMPwFqqUxiau4S2YwKaVwW9uXsQMOYpAkSAsAIUrg>
    <xmx:rox3ZcVGHPMvW5m042T2xM4xFlH25Phot2b0OQozOmmdGEtGI7lhkA>
    <xmx:rox3ZTO8IX_yb928rnqy91Sikx0trMIQ0L_u3dWrsozRPhiUwSGvWw>
    <xmx:sIx3ZSZnPC-rQ_kddp6XKVVsS-e_CQk9K-VeGIN1Jl5VnlrJd6sIZw>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Dec 2023 17:26:53 -0500 (EST)
Date: Mon, 11 Dec 2023 15:26:52 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: daniel@iogearbox.net, davem@davemloft.net, edumazet@google.com, 
	Herbert Xu <herbert@gondor.apana.org.au>, ast@kernel.org, john.fastabend@gmail.com, kuba@kernel.org, 
	steffen.klassert@secunet.com, pabeni@redhat.com, hawk@kernel.org, antony.antony@secunet.com, 
	alexei.starovoitov@gmail.com, yonghong.song@linux.dev, eddyz87@gmail.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org, 
	devel@linux-ipsec.org
Subject: Re: [PATCH bpf-next v5 1/9] bpf: xfrm: Add bpf_xdp_get_xfrm_state()
 kfunc
Message-ID: <2hcvru32qvfuhlvfdnayvn4kk4uq7caahloaabdzvxbpxfn6re@f5inqdnr4f5j>
References: <cover.1702325874.git.dxu@dxuuu.xyz>
 <e8029421b1a0d045fadb214ba919cc25efab4952.1702325874.git.dxu@dxuuu.xyz>
 <CAHsH6Gt4k3myGhyznhvhknup+U+aWq3dsMuhaWD=p1RWd+ABKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHsH6Gt4k3myGhyznhvhknup+U+aWq3dsMuhaWD=p1RWd+ABKw@mail.gmail.com>

On Mon, Dec 11, 2023 at 01:39:00PM -0800, Eyal Birger wrote:
> Hi Daniel,
> 
> Tiny nits below in case you respin this for other reasons:

Ack. Will fixup if I respin. Otherwise I can do a followup.

[...]

Thanks,
Daniel


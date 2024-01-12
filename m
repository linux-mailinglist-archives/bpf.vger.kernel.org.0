Return-Path: <bpf+bounces-19490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B9B982C669
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 21:41:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CF31F23AA3
	for <lists+bpf@lfdr.de>; Fri, 12 Jan 2024 20:41:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA8F8168C0;
	Fri, 12 Jan 2024 20:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="gc4GiDVf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vczIM62m"
X-Original-To: bpf@vger.kernel.org
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF2428ED
	for <bpf@vger.kernel.org>; Fri, 12 Jan 2024 20:41:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.west.internal (Postfix) with ESMTP id 21E0E3200A02;
	Fri, 12 Jan 2024 15:41:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Fri, 12 Jan 2024 15:41:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1705092103; x=1705178503; bh=we7zyrV7Az
	bLw8ZgpdSGDk+XTz4OSJJ70ue0WhIwp34=; b=gc4GiDVf7EKqXgAvq62db/gWRt
	/lvsngA5PJCoz5AsG0uhaXDroAKdFs7K2/PRSrkWP2pN+Dxk5cUtCzS0Vkw3guU2
	vM1bBt/Vj/9JW7/M4hAw7dmhurBN625PiNiUSMFxItLZXf3uIL/cbGfmSXn2Pkwm
	tgGt5YI2HqB1ubJ6qUEBsMmanrydroG5HPvRm5Ya/Vr1GW1XOJRkiB+4wG3lten/
	tU1y+wo7BnsflMKLUgf58++WGTH8n91rgYiKNRMp91aavwUc2Y/ZOGLfKAjEmtDR
	V2KwtYwaQQNGjbfyr5JFstoRcOUEKUHotRYdyaGyD7zN/leisKgr33h0N4GA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1705092103; x=1705178503; bh=we7zyrV7AzbLw8ZgpdSGDk+XTz4O
	SJJ70ue0WhIwp34=; b=vczIM62muo2henkBQHwC6yWtSFuFWoNbufZ8Oz3kZNOV
	JU8N2uud2d0LQolRh5CaWa3pZcUzwVEx2BeGwoywLml7YTIJZ/tTRnhapr99le3W
	/W7clTWTpOHG4bnLzoVOGi76Rq/V2MPzcV4mMC34x6a3D2dpcaDtKztL6Zv/04MC
	fjgyu4AVegeA3wJgj+G9HZk35WojdDJz60Gnn8V/A+PqGq1521SWf++rwnHVjjbd
	lt8xN2tL4pqcpUwJ984BDtju9fQSBtU34ooXmxZeEqXJkcjqXeB7CmUCJfxm2IOL
	gjouuQpu51LS1s8Brrs8+Rm0T220dLyu72haCzwRcg==
X-ME-Sender: <xms:B6ShZWrCJ9wEmNUZjBqLTww4sRv20FHMi1RqImVtxWRyJ9ZioTV-GA>
    <xme:B6ShZUofR-MgG59SUDbaqltC-vIYOhhNU6nTBtS5q5gTXKJLhcy4YHuLPpTp5g1KG
    X1js_OsR7Hc0g6iOA>
X-ME-Received: <xmr:B6ShZbMm_aY_rFqyZwNacqQxm6J7fN-g8J3bIITjmbMrXY8GEberDsl06QCu9Gtpv4zKBM-xyc_Wxoj1bHsQAlbg5Aw47O-shbq1kGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdeihedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enfghrlhcuvffnffculdejtddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdt
    tddtvdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqe
    enucggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffff
    gfegiedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:B6ShZV64dbZr4SW3X4IUnfxzCIv3vw3eTdq5etfJfib8rvY4cy05CA>
    <xmx:B6ShZV64rypVT7m4LMyidQnhfEqIqdWZb6Dc0rbT_RHqazSeIU6BkQ>
    <xmx:B6ShZViQBAh8JoEL9Fxg8TXMApbQaGMhNL1YPMlULkkVfjtSA3LV8A>
    <xmx:B6ShZTQbfHBIXmQSxVyb0JABU3lHniZjyq1gnaFfcp__UIU3ACUK7g>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 12 Jan 2024 15:41:42 -0500 (EST)
Date: Fri, 12 Jan 2024 13:41:41 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: acme@kernel.org, quentin@isovalent.com, andrii.nakryiko@gmail.com, 
	ast@kernel.org, daniel@iogearbox.net, bpf@vger.kernel.org
Subject: Re: [PATCH dwarves v2] pahole: Inject kfunc decl tags into BTF
Message-ID: <kdnf3vegkn5r3rndtbxlthbzbq4in5gr2lke6jrlx3yczpyj3n@ne3m2yo7r5od>
References: <85caea4c48659502544329e6cd8b41c12ab50dfc.1704929857.git.dxu@dxuuu.xyz>
 <ZaFlx89aXd7eEO1P@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZaFlx89aXd7eEO1P@krava>

Hi Jiri,

Thanks for reviewing!

On Fri, Jan 12, 2024 at 05:16:07PM +0100, Jiri Olsa wrote:
> On Wed, Jan 10, 2024 at 06:14:25PM -0700, Daniel Xu wrote:
> 
> are .BTF_ids records guaranteed to be sorted by address? so we are
> sure that the set will be followed by its records?

I think so, unless I am misunderstanding something. The asm directives
are basically laying out the btf_id_set8 datastructures by hand.  So if
the entries don't adhere to the exact layout then lots more will break
right?

> 
> I thought we'd need to find size for each set and then check each
> .BTF_ids record if it belongs to the set

Not sure I'm following. How would the check be done differently than in
the patch?


Thanks,
Daniel


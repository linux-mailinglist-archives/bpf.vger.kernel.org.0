Return-Path: <bpf+bounces-21350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E334984B9C3
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 16:36:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B5920B313FC
	for <lists+bpf@lfdr.de>; Tue,  6 Feb 2024 15:29:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9DD5134751;
	Tue,  6 Feb 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b="BVF3zjws";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GYYcr1so"
X-Original-To: bpf@vger.kernel.org
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9DE133292
	for <bpf@vger.kernel.org>; Tue,  6 Feb 2024 15:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707233300; cv=none; b=HgEGYEUkWMQ1S5z3tFADpcvfgr6wZA0zz8bD4Unvzamrxzg1O6hHTjYjJVy1dHIp+kMhBz3QMvpit0y6cWFUbfaPoX27QRujVXl6lnWrlhMl5jwHhDRRwiSIb03J4MkDIaqMxr10OIK7zNJa0OJkIcHQGsZWIcRl611XqegpG8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707233300; c=relaxed/simple;
	bh=PG4Lt3Wq53GVaZcKohF4jr7zQUWxZL5lIavSo4jbtSQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k2MVpVkLZFVNPoTj0Vc42RUBoVvalVEj/M91HcKVA6sahDK0IgYJA13cFUDbxipsIw1CAOkdb8qJMSLmfikTkEylIsN2lgxFE1hec3pVHpfVqGAG57p+DmRTKVqE8gCh5HK8VRx1GZpVr8LyQh3T8auC+83rGkLBPKBszykJeVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz; spf=pass smtp.mailfrom=dxuuu.xyz; dkim=pass (2048-bit key) header.d=dxuuu.xyz header.i=@dxuuu.xyz header.b=BVF3zjws; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GYYcr1so; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dxuuu.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dxuuu.xyz
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.nyi.internal (Postfix) with ESMTP id A25265C00F2;
	Tue,  6 Feb 2024 10:28:16 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Tue, 06 Feb 2024 10:28:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dxuuu.xyz; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1707233296; x=1707319696; bh=uQPZdPs45w
	XARw9FTkLra4YREfUFy4FHNAygl4/9wKI=; b=BVF3zjwsdbG9gBdcSSBMVbodFt
	MywD1a7C2u5GvZtTInmBVvNUEvtO0PSgJ5UoF8nWY17VV7Kx7AYY+7IbPYQrzibG
	bRABZ3gJBkWpbBTYGoPQ3Fk5IsSzjyEmMJxRpp0FGEdXauPtYrrsvM6TkUth+rNR
	2yGm8j5joJsyWdihNCdGPirAWd8Tv3JMeQW14TVGw8hIe61ep53y3E3oDbCC9DUi
	OWUVR7niaX7+zoBRvHmrOcaZreVJnN37IgcQTmIX9/R6T/GPu/htCX6KDMjj5tei
	Bl5CdBlSq016cKJV6nxmkQGsLPhAQ4D1wGKcXYkPHyQr5mdKYma3gkE2Ex4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707233296; x=1707319696; bh=uQPZdPs45wXARw9FTkLra4YREfUF
	y4FHNAygl4/9wKI=; b=GYYcr1so7IIf4I8JFvYOfhZFCVGgZIn5ykpa7xE2Bs4N
	YAGUw3ADB+TxXp2cJTZ7PvdUTcfN5AGquZIspZU1gFXytEou7RcjbwDB+3DpRIFs
	M12mJ9uwjmgDkbShc6Wa662uQGk7JQn3kz38qAmtprJ5LUZpD9Cs8hnI9ws7ecne
	uY109e5qhYecXkmA4WdtIe/kdhHgznd0XUqiCcEptMHdlbVbr9VYkwpVRj5XdutM
	GtVVglXcyLJ9K/on4orCGS9PGZwWlLMq9eMYY91DzAPBRYk733+QiXB7zTMFD+iS
	NUvkwCUOGfKnnaDqZUVpCjw/JGxRSS7fspJCvMVeQw==
X-ME-Sender: <xms:EFDCZbngSLNfpcpAZlVF2brABYf_Fkxar3sd2orEr1Jv827Dc23geg>
    <xme:EFDCZe0AcLBoYmCSnzQkaFND14WKjICxOF0dmwL_awzfm_xoaOxeBhNT26317tp6Y
    v95XFL-uK3aF75WHw>
X-ME-Received: <xmr:EFDCZRqrYRjoxelsE93xR06rnGRh7F1UiS2YGiDzeo42NW5gBaGGQ1rj24e6UL7McYXFDWMNyuN_0ka8Cea2Iz9_DCcpTbR_taBQgp8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrtddtgdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenfg
    hrlhcuvffnffculdefhedmnecujfgurhepfffhvfevuffkfhggtggujgesthdtsfdttddt
    vdenucfhrhhomhepffgrnhhivghlucgiuhcuoegugihusegugihuuhhurdighiiiqeenuc
    ggtffrrghtthgvrhhnpedvfeekteduudefieegtdehfeffkeeuudekheduffduffffgfeg
    iedttefgvdfhvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpegugihusegugihuuhhurdighiii
X-ME-Proxy: <xmx:EFDCZTmiKq7L6nJU8f-Tg59Onk7dpHuSoe5_oXPOeXKU6o9AFan9ag>
    <xmx:EFDCZZ0MtqznsBF3TL3T2fINODTp5voDiHdFXdyYtfuKoFpgAk36qg>
    <xmx:EFDCZSsJe2CVOXG6FnyLB-Sj4UR-4XfTD_vnT5tCiYtqA4xpdZENGw>
    <xmx:EFDCZaHaolBAfE_2bgerz3tLOLdctsR46_w94nnAJ6hOn-O4xGhe0w>
Feedback-ID: i6a694271:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Feb 2024 10:28:14 -0500 (EST)
Date: Tue, 6 Feb 2024 08:28:13 -0700
From: Daniel Xu <dxu@dxuuu.xyz>
To: Viktor Malik <vmalik@redhat.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, 
	Alexey Dobriyan <adobriyan@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Manu Bretelle <chantr4@gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] tools/resolve_btfids: Refactor set
 sorting with types from btf_ids.h
Message-ID: <b7vpc3rwbvpkf4vrbqbu5ayv2f37xnno2q4ul2fxifun6l5xi6@3fnzxjkzupwh>
References: <cover.1707223196.git.vmalik@redhat.com>
 <ff7f062ddf6a00815fda3087957c4ce667f50532.1707223196.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff7f062ddf6a00815fda3087957c4ce667f50532.1707223196.git.vmalik@redhat.com>

On Tue, Feb 06, 2024 at 01:46:09PM +0100, Viktor Malik wrote:
> Instead of using magic offsets to access BTF ID set data, leverage types
> from btf_ids.h (btf_id_set and btf_id_set8) which define the actual
> layout of the data. Thanks to this change, set sorting should also
> continue working if the layout changes.
> 
> This requires to sync the definition of 'struct btf_id_set8' from
> include/linux/btf_ids.h to tools/include/linux/btf_ids.h. We don't sync
> the rest of the file at the moment, b/c that would require to also sync
> multiple dependent headers and we don't need any other defs from
> btf_ids.h.
> 
> Signed-off-by: Viktor Malik <vmalik@redhat.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 35 ++++++++++++++++++++-------------
>  tools/include/linux/btf_ids.h   |  9 +++++++++
>  2 files changed, 30 insertions(+), 14 deletions(-)

Acked-by: Daniel Xu <dxu@dxuuu.xyz>

[...]


Return-Path: <bpf+bounces-33606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBF6291F0EF
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 10:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DDF2E1C20A41
	for <lists+bpf@lfdr.de>; Tue,  2 Jul 2024 08:21:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029BD14B97A;
	Tue,  2 Jul 2024 08:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b="jjPi2tWi"
X-Original-To: bpf@vger.kernel.org
Received: from submarine.notk.org (62-210-214-84.rev.poneytelecom.eu [62.210.214.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75AE17829C;
	Tue,  2 Jul 2024 08:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.210.214.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719908464; cv=none; b=PgB8anPtpk3WLeE2bcS5y0LmiT+9oZDQll3PffPxdj0l/G4J4LPfDy/GxPu38hdFiLCW2OjmnwIymTC44AEHYXDTcB413ns5d0aqDLf0YMtweqOJOiKgCf1SMp73g5Laozs8Ow/Em+quhZydQK7uBtvZkCvwCF8Ik9IY6BHBllo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719908464; c=relaxed/simple;
	bh=ltTU1jjpksscy88CQUgovGBPuuFSNhvY+R52IMfM6TQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EdbTWC8zBSDe8CThQ45UhtHwdbxZCiNk4xJolgwhlbh6YOcCf0w9UqBaFzUJzNDG4a3JGpSPYNA1tJhsr8dut34NQV7Xcds3HN3NMNxfb1rXKZX6NObamIhJCE4rX4Vl4dHfJy0tLkJsuJWmtF71pqTW3TykkkgBy/rPk7v25i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org; spf=pass smtp.mailfrom=codewreck.org; dkim=pass (2048-bit key) header.d=codewreck.org header.i=@codewreck.org header.b=jjPi2tWi; arc=none smtp.client-ip=62.210.214.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codewreck.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codewreck.org
Received: from gaia.codewreck.org (localhost [127.0.0.1])
	by submarine.notk.org (Postfix) with ESMTPS id A827814C1E1;
	Tue,  2 Jul 2024 10:20:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org;
	s=2; t=1719908456;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lKlB2Lo1Tj0ZL4kVYWbn12m4jdB0MZvffzHvvLvzLug=;
	b=jjPi2tWipzIa94/BBeRCwRPtN9Y8OGE9ngz8cF44Xa1IJLDy2Fm+0S+BxZa4cHrXLm5+sX
	sAOLlswOXorzRes6JggC2daiBdouDbJDymVPsPujDxb4CAZehTwtDSe31/GfAMDsF+UUAy
	bI3XsW/LdqgtR2mLQ15kTUwWTu2vKqZJ5k6b3Ok2PzRcB+c88RdXUI+MQI+JLPPNndkWxD
	V3Ny8olqYHpEj5kR0+zJeppln9B4+97/Mwvrmxvf6BB2wwO2KspcUI0uJns79lVXpIDYtC
	sn4T0zGCgY9bu9Y2EzzIVksTz8qYnixkWECgXEyiJJKVTrCmZVFMLrJxACGpfA==
Received: from localhost (gaia.codewreck.org [local])
	by gaia.codewreck.org (OpenSMTPD) with ESMTPA id 737de09b;
	Tue, 2 Jul 2024 08:20:46 +0000 (UTC)
Date: Tue, 2 Jul 2024 17:20:31 +0900
From: asmadeus@codewreck.org
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
	andrii@kernel.org, daniel@iogearbox.net, nathan@kernel.org,
	nicolas@fjasle.eu, martin.lau@linux.dev, eddyz87@gmail.com,
	song@kernel.org, yonghong.song@linux.dev, john.fastabend@gmail.com,
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
	jolsa@kernel.org, bpf@vger.kernel.org, linux-kbuild@vger.kernel.org
Subject: Re: [PATCH bpf-next] kbuild, bpf: reproducible BTF from pahole when
 KBUILD_BUILD_TIMESTAMP set
Message-ID: <ZoO4Ty_o4LSVfihj@codewreck.org>
References: <20240701173133.3283312-1-alan.maguire@oracle.com>
 <CAK7LNAStVrAx8LjDiYogRvS16-dZ+LrwcWq8gHnTbvKvR_JFFA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAK7LNAStVrAx8LjDiYogRvS16-dZ+LrwcWq8gHnTbvKvR_JFFA@mail.gmail.com>

Masahiro Yamada wrote on Tue, Jul 02, 2024 at 04:58:50PM +0900:
> If --btf_features=reproducible_build has no downside,
> please add it whenever supported.

It makes the build slightly slower (from [1], 3.858 -> 3.991 (+3%) on
my crippled machine for the vmlinux BTF phase -- the modules also get
similar treatment, I'm not sure how big the total time exactly is --
for large kernels with tons of modules it definitely adds up but for small
kernels it's probably "short enough")

[1] https://lkml.kernel.org/r/20240626032253.3406460-1-asmadeus@codewreck.org


I don't particularly mind either way, so this is mostly out of curiosity:
do we have any other setting that would be closer better than this
KBUILD_BUILD_TIMESTAMP to say "make this reproducible", or is the kernel
build supposed to be reproducible except for the date by default?


Thank you,
-- 
Dominique Martinet | Asmadeus


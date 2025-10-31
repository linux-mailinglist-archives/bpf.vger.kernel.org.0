Return-Path: <bpf+bounces-73161-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA3FC2594D
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 15:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 09F9B4F65DA
	for <lists+bpf@lfdr.de>; Fri, 31 Oct 2025 14:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD6534BA5C;
	Fri, 31 Oct 2025 14:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hRia0Ay9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D90DF1A9F87
	for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 14:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761921028; cv=none; b=RaW+NkoSAp+ht/g1SNZ1yliSE9A73kj1Y+gAkWe2ofjcJQY3kxW9l+2gpwlRw75q25M7U2TQRwLs89kWgikj8SvqvyxTq4bwAAkZEfYW2YtZOJiZJ1FEjoKmc/3CbOY0w3Do5hBef7x7scyxXGgODv4CUGaFecEnKAmJG6KsrTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761921028; c=relaxed/simple;
	bh=ia+M42NiQvrmHNhVtx6g1EFyz+OuuCQ1rF/Q3fUKCuI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aCvjTv5vo5wMdcSgc3OAqRc3ptDOdGcbFCKVk+bnSg/Q/gWQmQ9ZWkaV55OfGqAEyWisKjYj9hrs1NoAo4Ndm3KehwTlDGY0TOcjWq2dVwfhfvfJeurrRZZ5lf1IdDQuVN0yOwSca7xrYcld3t1+LwS7/vuUUi8XCctvC7EwVBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hRia0Ay9; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-429bf011e6cso996468f8f.1
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 07:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761921025; x=1762525825; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ia+M42NiQvrmHNhVtx6g1EFyz+OuuCQ1rF/Q3fUKCuI=;
        b=hRia0Ay9mTHS94yq6vsEmXsHyXE+sU8GoFAwvpQ1qmf9vKB5eLF6F6y+f8V+0km16/
         dyyzfgwhsQRkFfTjuxsQy6nmG4OOcn35lZVMUdbeRj6lbJQqemAg1NBUW+C015Ti7dnE
         TJsvASF9K2bOGvdQLPIuXbZ0PJcAnw392ZanBIhhVTP7rpkbnAoEJXV52zmjbyuWoEqm
         wDvBaIJr4k4cXUP5aSYcR6smxm2pZEvnWB5QpwLPjX4gjeP5vjtSPrCenTgL6ELVNlZh
         givM0cBk3hpTCAIFPxmoFYRznO7x8ONiZpCjxBbXGwbfICvvGeNcRHs90u2IA9GD7/47
         LTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761921025; x=1762525825;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ia+M42NiQvrmHNhVtx6g1EFyz+OuuCQ1rF/Q3fUKCuI=;
        b=L20WJ8Vr+HXGPiVumYmWmbqZ5cs8BKeUCpnHibPTWkLLWa6Hl1GlroMa/S2zSsOwvc
         eVvyGJQgCZsXDcJxGWLAe08x7eYmBdj0pAuaf33p2L2Rg/LM9No/BWvEACPHxfHrz5NX
         w3GTYFLuH+FBgIhNFdwtMiTAch6jv7bDIYvB7JabvwqWsuB9scNcUISfZsGfPD/yhCt4
         I1gNn8CzxU7ZWaRDsRteSzh/G+GTqeEPBs5wZANfJKxHEb9sSOT7sonqgUwVZOhreXqF
         Q8Mjlgg6fWDwQxBwUSEEBuHqC52E/fmabOkhDtHVgOwGZyLqXP1hVWwDqk2hbt6NrS/W
         +ZNg==
X-Gm-Message-State: AOJu0YyzuJNqcPHC1a/QC1fn0V+EzdU3bNGlH4BYSe46FK0yBH+01WpV
	F/Y3JDChLFI8L51rOHXEc9DBv2hfMk/r8ZuIi4vPmL6lCTzOzsFkXEF5M2Pixp/KcdHDU4Vc6Br
	nIKuHng1mH5EO6U8lfnHCxWyTqE1rkTM=
X-Gm-Gg: ASbGnctp0eYZIrIJ3hlOYROCG77PVYTfivxgcTHq7dfOuNqRjwW6oAL4t0arv20E23m
	BNvQo5XcqoY9h47O64HU1EXfiU46Rv9c/Yy1MKbs+wo0BlqoWX2M5DAti9/sy59j1GgvYKRVUfm
	lXzWIPRggqt82r0twlNpShrz1gu11WcFC28OEDDPpN2V8ctN3B2PUkYEPX9FfcEdQuDti6L68OZ
	f4ZZv1RfQQwLGNKOHpNQFYKCorJ61dlHC2gw4E1pHfSlPMVNgRySBMSIpi8lzDF8A4FwCciO3ip
	OOgLl5KHfgLYAs4QO+CCHZA5g3WN
X-Google-Smtp-Source: AGHT+IG47+1l6FUj2/1yJRideOAXxtsrE8rGnANzQdIWUW6DOVBq3l0Iv41VbMySpGkkF01BSpkfDesVFy8Szgf9fo0=
X-Received: by 2002:a05:6000:144a:b0:429:b8f9:a882 with SMTP id
 ffacd0b85a97d-429bd675f77mr3223983f8f.10.1761921024798; Fri, 31 Oct 2025
 07:30:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251031032627.1414462-1-jianyungao89@gmail.com>
In-Reply-To: <20251031032627.1414462-1-jianyungao89@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 31 Oct 2025 07:30:13 -0700
X-Gm-Features: AWmQ_bnznBbDi_yNCkuW1kxoDfv4wWjEeJzqF_OTpFLEUCa1V4CI_Ja3Wv55C0U
Message-ID: <CAADnVQKzF=jrJ84es2=Ko-WdcNxQnBWErb06huFyZs6-HuhowA@mail.gmail.com>
Subject: Re: [PATCH 0/5] libbpf: add Doxygen docs for public LIBBPF_API APIs
To: Jianyun Gao <jianyungao89@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 30, 2025 at 8:26=E2=80=AFPM Jianyun Gao <jianyungao89@gmail.com=
> wrote:
>
> Hi,
>
> Background:
> While consulting libbpf's online documentation at https://libbpf.readthed=
ocs.io/
> I noticed that many public LIBBPF_API helpers in tools/lib/bpf/bpf.h eith=
er

You or AI ?
The whole thing looks like AI generated garbage.
Sorry, but no.

pw-bot: cr


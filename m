Return-Path: <bpf+bounces-29005-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 241898BF44F
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 04:03:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD5B6281075
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 02:03:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E2899449;
	Wed,  8 May 2024 02:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C412zg8X"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA5D8F4E;
	Wed,  8 May 2024 02:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715133805; cv=none; b=dV3M1PRpdPcofD7Isp3xeWVsrwOvGNxiEr2i4BmYZhB75XWe4vYUGVFqaIrzUtv9pUP5IxLxIMuuBZQU0QxyfuQgm/Dxwf1hZNFjOeoeBZduND8H995+3jm9viAsNom30VY/64AhsVqDDwpweD8akW8SerLB0GU7XgeFFP9FRx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715133805; c=relaxed/simple;
	bh=W9c1/LUlqt+J7rmgnVdnVICk6caTmrVCrm7z1rP5LHs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qeg4uLiJnQXVX1In/QwgRRn0DPYEwrvLS3Abf2Wsi2nYJ73kyG4Pc4J/PH3VQtorf6o0qPl9b1hRixvz6QDZeShiEL42OmrLliwhNm35n6pIcpqgtir5J4lprPB/a/SNmgpPGzFnF1dsk5jGWIVnaKBMZOQRHNcaFBNy9Rmd9lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C412zg8X; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-41dc9c83e57so1708585e9.0;
        Tue, 07 May 2024 19:03:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715133803; x=1715738603; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W9c1/LUlqt+J7rmgnVdnVICk6caTmrVCrm7z1rP5LHs=;
        b=C412zg8Xt8F2OPhxzBV7YlWybAFpT9q/QIUEy+DznUdO8w67kUODVlW8i1g71OH7gy
         u/87nzk+fZZf1qLRmh3tyOBH7JI5olnWdWB/HUgmdci3S0nXuP/2NVg5iFdpta05L6YL
         LIp0L7U8swahezseHS4986SQKq6QF1Y8HNe2t4ZaK6TA8B2PNwx/wjj2nCfShS1cH9f2
         wrM4c1UvNoYT8+QP20auZvHrRdJFcdC9ncZdcbh5o86E5rNseZK2oCROU7REjlgQDVFL
         4dbC8KW6XD7xFrMwv1guWKapg8chQ75ClkRpPj6YZ0B+rQ1igRnulV1qRt8iQVYhuLei
         meXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715133803; x=1715738603;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W9c1/LUlqt+J7rmgnVdnVICk6caTmrVCrm7z1rP5LHs=;
        b=NO6+k87HNlDVO1zTPgBYoqyvA6DOCrQ/R5CwpR6KT9Z3bODFQDmZ1vbiHihJdjlgAU
         wXNJVheP5eDQ+YQNKo6UkIIB13RGCFcYQ1lR82Qynzk+yQRc8VVVwgEX8doSV/ZWnsCo
         yQJ+x3MtWsmOMWj26iUSf3DcMbkxiUMBuRUIMrtcZ9O+R+rIAT5GXzRzELsKN8lBYxH7
         7mTXU67JudIk1OEI+sEdzD1AOMGdp+iXCZ3goh6aKhBPhChc4qNi0ZtPrdw1vLlQ4MaO
         0TyJGoLlpkX7ZPciomkYC5xnnvkcR3WwkUWwUxIt/sRgidzuqcD6Ls2j83dBk5XDElkF
         9nAA==
X-Forwarded-Encrypted: i=1; AJvYcCWu99o4MxHNVelNK71xLWRje7vSOmBsOyy7gOzK2LAYgBPEVnF+V1GK1xJE2VGDxG2LffF3/luGuYwu5vmfiTI9w5MZFv3NVr1fl484UHNx7cMDJGAZxTBPlIMiMxZzfSzk
X-Gm-Message-State: AOJu0YwMIp9eh0tkA9+7fgF4c6ntraUf4TecPV9yUTM+4ZvF296dWod4
	NcZFltMP/+Z78uMG/AzbjgJpJb85/0CBXpGLXimo15aaIxFzSyasjjxCMDEk1ViJcuZqYrgHvaj
	lh9Q7qWrNT1f4i5da1MFJT6PoxgQ=
X-Google-Smtp-Source: AGHT+IHTgN2NiqlvSTrFgy/1Gpj+C8gkMgIPlSsAmWReNl3B1rh/SayYQuvFjyEE28A28uuaDdPcyffsX3u6rq1bsLE=
X-Received: by 2002:a05:6000:d8b:b0:34e:8a10:3c2 with SMTP id
 ffacd0b85a97d-34fca90a7ecmr1140017f8f.24.1715133802457; Tue, 07 May 2024
 19:03:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240422-sleepable_array_progs-v1-1-7c46ccbaa6e2@kernel.org>
 <7344022a-6f59-7cbf-ee45-6b7d59114be6@iogearbox.net> <un4jw2ef45vu3vwojpjca3wezso7fdp5gih7np73f4pmsmhmaj@csm3ix2ygd5i>
 <35nbgxc7hqyef3iobfvhbftxtbxb3dfz574gbba4kwvbo6os4v@sya7ul5i6mmd>
 <CAADnVQJaG8kDaJr5LV29ces+gVpgARLAWiUvE9Ee5huuiW5X=Q@mail.gmail.com>
 <mhkzkf4e23uvljtmwizwcxyuyat2tmfxn33xb4t7waafgmsa66@mcrzpj3b6ssx>
 <CAADnVQLJ=nxp3bZYYMJd0yrUtMNx2DcvYXXmbGKBQAiG85kSLQ@mail.gmail.com> <xt2zckipzs24eur4ozdo64uoxfed6jm3qixxgnp3o2gogjmosc@723s2u7jbsaz>
In-Reply-To: <xt2zckipzs24eur4ozdo64uoxfed6jm3qixxgnp3o2gogjmosc@723s2u7jbsaz>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 7 May 2024 19:03:10 -0700
Message-ID: <CAADnVQK9qeMmzxE-aivmue-CF_hn1EFUTUAZyaMRqy2cW6j73A@mail.gmail.com>
Subject: Re: [PATCH] bpf: verifier: allow arrays of progs to be used in
 sleepable context
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>, 
	bpf <bpf@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 7, 2024 at 6:32=E2=80=AFAM Benjamin Tissoires <bentiss@kernel.o=
rg> wrote:
>
> Yes, exactly that. See [0] for my current WIP. I've just sent it, not
> for reviews, but so you see what I meant here.

The patches helped to understand, for sure, and on surface
they kind of make sense, but without seeing what is that
hid specific kfunc that will use it
it's hard to make a call.
The (u64)(long) casting concerns and prog lifetime are
difficult to get right. The verifier won't help and it all
will fall on code reviews.
So I'd rather not go this route.
Let's explore first what exactly the goal here.
We've talked about sleepable tail_calls, this async callbacks
from hid kfuncs, and struct-ops.
Maybe none of them fit well and we need something else.
Could you please explain (maybe once again) what is the end goal?

> Last time I checked, I thought struct_ops were only for defining one set
> of operations. And you could overwrite them exactly once.
> But after reading more carefully how it was used in tcp_cong.c, it seems
> we can have multiple programs which define the same struct_ops, and then
> it's the kernel which will choose which one needs to be run.

struct-ops is pretty much a mechanism for kernel to define
a set of callbacks and bpf prog to provide implementation for
these callbacks. The kernel choses when to call them.
tcp-bpf is one such user. sched_ext is another and more advanced.
Currently struct-ops bpf prog loading/attaching mechanism
only specifies the struct-ops. There is no device-id argument,
but that can be extended and kernel can keep per-device a set
of bpf progs.
struct-ops is a bit of overkill if you have only one callback.
It's typically for a set of callbacks.

> Last, I'm not entirely sure how I can specify which struct_ops needs to b=
e
> attached to which device, but it's worth a shot. I've already realized
> that I would probably have to drop the current way of HID-BPF is running,
> so now it's just technical bits to assemble :)

You need to call different bpf progs per device, right?
If indirect call is fine from performance pov,
then tailcall or struct_ops+device_argument might fit.

If you want max perf with direct calls then
we'd need to generalize xdp dispatcher.

So far it sounds that tailcalls might be the best actually,
since prog lifetime is handled by prog array map.
Maybe instead of bpf_tail_call helper we should add a kfunc that
will operate on prog array differently?
(if current bpf_tail_call semantics don't fit).


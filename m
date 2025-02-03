Return-Path: <bpf+bounces-50316-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857A1A257F9
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 12:19:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F1C43A369E
	for <lists+bpf@lfdr.de>; Mon,  3 Feb 2025 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2448B20127C;
	Mon,  3 Feb 2025 11:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jlkDuF1A"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1647F2A1A4
	for <bpf@vger.kernel.org>; Mon,  3 Feb 2025 11:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738581589; cv=none; b=Zz3YiOO4UIZCgwjbl/wlJcKsVHoDuWboExmOafPceRJSjV++Iqq8ZUVxvL/752C/hrzJAQ4Ooqzl9+yv6qtttPtcmKoq4Nn3JgC4r15DLnqigD0Z2KTC9VBj16yA9xslSlnr6QVXfm8f9oguQcmSGFpA1+dVX2d43+2EYbe/ajM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738581589; c=relaxed/simple;
	bh=GeyuGAU1E/ISgDbUNQvfMXKbws650LnUrlW2pl6Nbhc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ICEvGjirMJTJVC9bZ5ItrgIgzjHKh1AHDtF5ZxLaNdn1hLyYxmADmOvyMYqYgYFrYcHSDnAanLt7nmHYlz2nflARqVF4OH17yz+FvlL378GyxBNdat6/KgZQk59HPBICeaw30E4b/GYxKysWcVytdY1Fx8Cud1qkKbO5foLgGBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jlkDuF1A; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-43625c4a50dso29246295e9.0
        for <bpf@vger.kernel.org>; Mon, 03 Feb 2025 03:19:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738581586; x=1739186386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Zty+qzW18hF5S9StHQX2210t4xfBPu6YOwLiDcPbz9k=;
        b=jlkDuF1ApbnxksB1zRMEoyUXUB5NvpWCPEgVuxy1M2LXw/LQvOgok+DChM3Uixufb/
         bEkAOz2eEHZGW5caSknFBEB/xGSc6JDCOQOzTX4HMdB7z1Mh0Sy7OVpJU6XCUn+bkd1f
         Au+kYwAMyMT8RbAaGGvwOVVVQVkceo6HTPl5zeRyT5ejsKHVqTX1W5trMV4SK7h8Onb2
         I/+NbI3C1AoqZbp+dZTy5CApjBU6CEYzuflWPWkifdSrmDn1vFaP1o/KO92uMJLDulDk
         8u4WoX9pr+m2VigRHPTUTgABzezp6Y3ndkdd9UwNidpEUKC2jrKhBDRCZp+kWUldms4u
         TcBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738581586; x=1739186386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zty+qzW18hF5S9StHQX2210t4xfBPu6YOwLiDcPbz9k=;
        b=pOvb/V9cd35kjS3grxk2OvVnVDFP89eGFmszyuGyaqdbCqI3Q1EOFrndOvlU8PcBjL
         xIJPQTZi7PLukKhYZ1kIGlCaZ0Syx2xvkoua7rVzdM1DM/6YoioicAJJLSPHFouvsaiT
         6/vpASjWemXLhy9y9Xorm0PQgHq3yRMgLjwsDB+EpxUpLgUWOBLgO265OkrMQprKUDUy
         16LfujKn2NyqvUjV0+XMABAQ0eHpUz+ho/XzeLmjzF9vOsp+vySJpvKp2bRa3VmjFmbB
         VY1QerrrFy5967Vh3Ys9qCTvUdsjX6h6aDdiXu97hnA8oWHbOhe+B6Az4sMC+i3fQGRM
         vrmA==
X-Gm-Message-State: AOJu0YyCQVteV9DxMNqNAkKeR62tFncj0Hk0GvQgivK/XX+UGduwN/8t
	4v9IS9yv/lN3pJdKtFhN0dpdfxeI3qvvZ7fPFHkm+G5+6HrVR8Asxnrg2mqf90md2GnVWZUFla4
	gDwwE7k3F4HtP0RAn+7a6jgGjFyI=
X-Gm-Gg: ASbGncuQRX0ROdMxoyZJiTCicl7RJeYCX6R3YAiCLXmpIPftQVXtajkPfgyu05cJVq4
	clnSN2nukKrDgA9kQZH1YNf3PwML0GCXdW2oZIBVLiHs8tyKzXWJ4nrY0iUe5O8ZtfaSzzdY4hQ
	==
X-Google-Smtp-Source: AGHT+IFkgzE6lSLReRzaq8JDG6I2ZGMKvZqW1eJD41F+Spv1QnjZDmGABZ3MUOxLTvETdG9uknOnNnE10Z0dDU0N7ao=
X-Received: by 2002:a05:600c:3d9b:b0:434:ff08:202b with SMTP id
 5b1f17b1804b1-438dc3c360dmr178549185e9.12.1738581586044; Mon, 03 Feb 2025
 03:19:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2xsd4H-mYmhb4-gwBV9ogXZDK6XaLU=jRfHT9X80=5Oow@mail.gmail.com>
In-Reply-To: <CAK3+h2xsd4H-mYmhb4-gwBV9ogXZDK6XaLU=jRfHT9X80=5Oow@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 3 Feb 2025 12:19:35 +0100
X-Gm-Features: AWEUYZm7O5e8PFme0YP6_xeOm5MNlH-1kTpSwMMCCbDEIckDeK5nVV7XvbJG5JQ
Message-ID: <CAADnVQK01RwKVOZ4aMMXpdMSeD40eV2grXSSD4z4g5C7nEsfLQ@mail.gmail.com>
Subject: Re: [QUESTION] map has to have BTF in order to use bpf_spin_lock
To: Vincent Li <vincent.mc.li@gmail.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 2, 2025 at 8:46=E2=80=AFPM Vincent Li <vincent.mc.li@gmail.com>=
 wrote:
>
> Hi
>
> I am attempting to load loxilb ebpf load balancer project  ebpf
> program and ran into bpf verifier error like below, the kernel is
> upstream stable release 6.12.5 and has CONFIG_DEBUG_INFO_BTF=3Dy kernel
> config. I tried both clang 18.1.0 and clang 19.1.7. I reported the
> issue to loxilb here [0] with BTF LOAD LOG and PROG LOAD LOG output
> detail. Google search and AI  hasn't been helpful so far :)
>
> 8113: (bf) r1 =3D r8                    ; frame1:
> R1_w=3Dmap_value(map=3Dpolx_map,ks=3D4,vs=3D96)
> R8_w=3Dmap_value(map=3Dpolx_map,ks=3D4,vs=3D96)
> 8114: (07) r1 +=3D 16                   ; frame1:
> R1_w=3Dmap_value(map=3Dpolx_map,ks=3D4,vs=3D96,off=3D16)
> 8115: (7b) *(u64 *)(r10 -16) =3D r1     ; frame1:
> R1_w=3Dmap_value(map=3Dpolx_map,ks=3D4,vs=3D96,off=3D16) R10=3Dfp0
> fp-16_w=3Dmap_value(map=3Dpolx_map,ks=3D4,vs=3D96,off=3D16)
> 8116: (85) call bpf_spin_lock#93

> map 'polx_map' has to have BTF in order to use bpf_spin_lock

The message from the verifier is pretty clear.
The problem is somewhere in loxilb.
The kernel and clang are fine.


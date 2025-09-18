Return-Path: <bpf+bounces-68806-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B151CB85F6B
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 18:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8A107C5011
	for <lists+bpf@lfdr.de>; Thu, 18 Sep 2025 16:21:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113322459FF;
	Thu, 18 Sep 2025 16:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RLHKE4oS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAD5312814
	for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 16:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758212488; cv=none; b=LHx0bFZuUVM9iseUWznTXAdhFb4iqh4vsFbPnxtlKfFapBGRecnkZhxmR8bd55XLutEtlydKknuhBUi4fPmTNS0GFscqKfVn6RleNEwFvCYRun+2ZE1rmotpyFGgOsZYE5DDemriAP1L/aGL0/0vj0N12ZCEHo8QV1gHfdjOgs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758212488; c=relaxed/simple;
	bh=x1QnhRo4NDS30n89NtZPGr3Wtna/fdvKeoPG8BieR4Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qWX8aX+0pZHZqeS81q1/uC29GcP3Wc8tUzPPOu7+Jx6qK1SpGSYVV1v9nPXQMXaVwQmC57deZcBTEMSyPDtJ8tbFQZks/HYG0Dzk5D9MJqFfFRmmHP4LNqNs/MrZAlK5wJ6Cb2iYGezp2Ryyllr9Ydccug1aimAS7gsoR/31Aiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RLHKE4oS; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3e98c5adbbeso780112f8f.0
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 09:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758212485; x=1758817285; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1UF2l9oJfaIkWEg932bzggZno8bIHmiX4kcDQgqd+ls=;
        b=RLHKE4oS1lsPlLHw4VkS4YoKw+rThVmx8Hi0x72oGhWSacPGP0mTKUd9HwlacQxVkw
         yvFMd+yzEHr4bfRTiNZ7ObMqUL9ttkoKubGJxQOEDZLXmUG394rek5zEhLD24iWf8fNe
         4H5RN4zg2y26HdyMuUkNP6iXvzJSaf7XjLL88l2/x0GodDns0se13WhsZZj6pNifdv9H
         XfrfDswkI4IWqm5TECx09J/3AG6Aa3iTBzB/zoQG4G8qRKEs9TYmnmmM3vhtG4COc2bV
         5DxlQWiQwSoGtvctJwc9rLJOij4Uxi3g2xPLx9mV14bs8MrSrceODFGy4iESQC/wllKc
         R61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758212485; x=1758817285;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UF2l9oJfaIkWEg932bzggZno8bIHmiX4kcDQgqd+ls=;
        b=AB51bk0jd6tZoBGz4lOWXsc4RnQlwI1TufjQ/X7pRP3StQQC65bK4fOBH5Yh2dA65s
         sT8TshbppBMUcfWvOMxoFOrv+T+sf6vWST3jEy9QmND4pB5uWeprRDgbByDpy5dWEsle
         hLChjGvQGMPhVSLzXgr9p7EIwIuVCPlNpA+eLUwIhkm2hsICRSi7p83+sHBDC8dNvz8F
         hIUr+fxOZ8Lef1ajybzc8u8Hk5Czejn6EJwt45L3E/Hf8Xt8YREi9LSHLOBmS398gm5j
         2lCB+B4wgmfg77ledojzZdOrIQD6CX+fR9LWbqyA4jxspuvZ/mZTVQ8cUP2aEZbetqNR
         QTPg==
X-Gm-Message-State: AOJu0YxjHRnbVyeSmTQDR5pNmPnmY803n3Bjj90WmNR4NSPSDhrVPpAO
	V7GnIZF62xAi7EMnA72GDtdKDz0d1SfyDjpbqz8ZyEVv3z6yBbImifOK5THmUg==
X-Gm-Gg: ASbGncszD43/XfnvPc0s/2kI42QKVIWbOxPqlKuPiucuttH6k4NEPw5WGKxNuuunW9c
	OryWQwmfxGjHxb0kME7z06TlWbK3XInHU3M++mRGqcfXeLUe6ow365bmdcXPGBIzlb5eHIqqOet
	zEtWNqWnpjlp6MXi88MrubWF8jVhTBMOTN4ffFmBN7vqC65m2N3bbKAWTkOIDzz6gUehEzNXkTT
	S9pBeUtbsyZHVY8tcpBC5iG+XqsfSZzoV2TD4b7ETyM7GhuWHW9HA8DEmSzgk9FdZP9PGIJ/vTM
	UYoflduqglxuc4vxx6fOVCs18sdyyE5dBKvkRIweWUgLu0VUOXHMOPwJ5XacXJFfxXE/sRTnfdB
	buDmgO9H2snLdZjD0/w3xeLqnWdh65Orx+PePX7BZ6ds/ndzk2IA=
X-Google-Smtp-Source: AGHT+IHhUnWSGR0rmIoVLOw+F8Sexip3PxUIKF4ZQ2dlIa7WKxAMK3oF+0TM+C1lGcxAKssM5fZdNA==
X-Received: by 2002:a05:6000:40cb:b0:3ee:1461:1659 with SMTP id ffacd0b85a97d-3ee146119c6mr1643126f8f.31.1758212484850;
        Thu, 18 Sep 2025 09:21:24 -0700 (PDT)
Received: from mail.gmail.com ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4613d14d212sm102344105e9.12.2025.09.18.09.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 09:21:24 -0700 (PDT)
Date: Thu, 18 Sep 2025 16:27:38 +0000
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Puranjay Mohan <puranjay@kernel.org>
Subject: Re: [PATCH bpf-next] selftests/bpf: fix build with new LLVM
Message-ID: <aMwy+pt+Rg1eNr0z@mail.gmail.com>
References: <20250918093606.454541-1-a.s.protopopov@gmail.com>
 <CAADnVQLso776xFQTzPFahmV=JbE3Ca8jQ7UdPuMChjJAK_echg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQLso776xFQTzPFahmV=JbE3Ca8jQ7UdPuMChjJAK_echg@mail.gmail.com>

On 25/09/18 08:02AM, Alexei Starovoitov wrote:
> On Thu, Sep 18, 2025 at 2:30 AM Anton Protopopov
> <a.s.protopopov@gmail.com> wrote:
> >
> > The progs/stream.c BPF program now uses arena helpers, so it includes
> > bpf_arena_common.h, which conflicts with the declarations generated
> > in vmlinux.h. This leads to the following build errors with the recent
> > LLVM:
> >
> >     In file included from progs/stream.c:8:
> >     .../tools/testing/selftests/bpf/bpf_arena_common.h:47:15: error: conflicting types for 'bpf_arena_alloc_pages'
> >        47 | void __arena* bpf_arena_alloc_pages(void *map, void __arena *addr, __u32 page_cnt,
> >           |               ^
> >     .../tools/testing/selftests/bpf/tools/include/vmlinux.h:229284:14: note: previous declaration is here
> >      229284 | extern void *bpf_arena_alloc_pages(void *p__map, void *addr__ign, u32 page_cnt, int node_id, u64 flags) __weak __ksym;
> >             |              ^
> >
> >     ... etc
> 
> I suspect you're using old pahole.
> New one can transfer __arena tags into vmlinux.h

Ok, TIL about CONFIG_PAHOLE_VERSION (before I've sent the patch,
I've updated the pahole, re-built the kernel, but didn't do `make
oldconfig` after updating pahole.)

> pw-bot: cr


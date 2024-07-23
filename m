Return-Path: <bpf+bounces-35310-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7189397AE
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0AEA1B21654
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0842132111;
	Tue, 23 Jul 2024 00:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw4KD2BM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-il1-f171.google.com (mail-il1-f171.google.com [209.85.166.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8AF432C8B
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 00:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721696266; cv=none; b=dSa5jib54hn6tpuMPmIPGH57HvtxHxFheqna8YsR9vte6Z67ND3hjUXqJOWbCz3BeClNZ6UabjHExEC4qcuUWcrdO/MS7Hm3rQHXYxqwOL91C5/Uc0OF7Ta8vjvn5A8TcdU94oVu9edboQmX03zrnikLhim+PQP3E5BHYdGXrfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721696266; c=relaxed/simple;
	bh=/3TF8dT7JygGy6tck3pt5aCPyDOZXsuqmmZXC/KXUFU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DwSmE7O4oyzA9GIz8RatBUZKcBv5ZPmfGwq83ewAfXMZjzJCT/VfNYbAixO3gbRCQd2XpK4BSpQEh2ylAFKAtGnT+zfWd5HInR2Q5I3cQFVI7j9G9QRyKDRLHKmC/sWW3NE7SOCLyRsrXjLF4GmoUw8DZDrahkrblFT73B4myC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fw4KD2BM; arc=none smtp.client-ip=209.85.166.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f171.google.com with SMTP id e9e14a558f8ab-3993c6dd822so10282655ab.1
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 17:57:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721696264; x=1722301064; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=NJ7JQHCTYQRcnOS7dubZ5cPw1DwjzQae65shzSdx9Rc=;
        b=fw4KD2BMym1sLaYfRDgSi8Bns5Wo+zy+dSOV8dtkjqM+2B35KN+10MJ2dZ1py3HfIm
         M3MDn1o57LnffO1A7qietSROCWw2syhT4DqQgkapAefa7O/KT8L3gznQ91nEOIQg6VO7
         zLjfOqVVTEOrHhEj0hzJN7tVazhETaFffnfNbaU8sSola/SabxswGZrrUbuPVVhB8j3Q
         x602dU4iZWg6uI9hGODc08yWs3SkXV3195PMKmhH29FMI78gLv0MPHD+t8XcjcsBaFzn
         YMexPei7Mzq+ToBo/laO/K/4ILVAsLcvcUBVsLWGCFrMTKZH0i7MaV/1UZ2F+tVGD+BR
         U9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721696264; x=1722301064;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJ7JQHCTYQRcnOS7dubZ5cPw1DwjzQae65shzSdx9Rc=;
        b=T2igozJkQhRKoNokPrUT8kk5xbw2KswVRMoYPf5r6JtuWVYWOKXw7DuWZg6hVrIzod
         cmDszreSt6+NlntVddQye7qe6zhjnJ6r9Z2u0jBq3z3be30b6JDgfGpHxKVsji5YuGl5
         hPf7HX9/6aiPhVhD70XzIXG82+OxybDr2A3Q+y02DJS0gBSsu+8x9NVTcMmlj5MrLO9Q
         NO8fbP2yiDK4W0se3RX+0kFcTV5UNCh4ASEQ8zOrdWzEikm7Bf1WcEEpffsK2w0lBitF
         WtoMM1x8AohNuIwrIrOoKaeaVYcRmfil/pT0FpCxz7QIqh/u7c1zqHlNisVcKx3VRZs1
         N2Nw==
X-Forwarded-Encrypted: i=1; AJvYcCXXC5Rl+mK3S0Y6bvJBEQMxb8qg+Dcj/NdH8IGZ7zXJWXkF/f/fIYIYnEUxele/AxG/k7pB8d4ohr5mDvsYrkudmDhj
X-Gm-Message-State: AOJu0Yz1qYp4f34/R0MR4xLnAgykpo5BcGAdlRsRrr5THIifP0qpVvRR
	EAm8Tk3my14OboqWwae9ifA63l1BpOuVS3bVaqXpp9tSqUKH3yMU
X-Google-Smtp-Source: AGHT+IF1k1OAHO4/eDupnj0RFCGhO9d409+kTnGSUO7egX/mage7TVJI+3cA1IlPWNT1+aA4NOeivQ==
X-Received: by 2002:a05:6e02:1c42:b0:375:9d6d:130e with SMTP id e9e14a558f8ab-3993fee5ac5mr92900885ab.0.1721696263836;
        Mon, 22 Jul 2024 17:57:43 -0700 (PDT)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7a3f2b8546bsm699607a12.49.2024.07.22.17.57.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jul 2024 17:57:43 -0700 (PDT)
Message-ID: <24a6649743528b2c8f44cc5415df32a3020b0951.camel@gmail.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for
 test objects
From: Eduard Zingerman <eddyz87@gmail.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>, 
	patchwork-bot+netdevbpf@kernel.org
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf <bpf@vger.kernel.org>, Alexei
 Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>
Date: Mon, 22 Jul 2024 17:57:38 -0700
In-Reply-To: <CAADnVQ+F6JKp1e61NC22wt8L9YEVAz9w648GvdV8hUrM3dkDFA@mail.gmail.com>
References: 
	<VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
	 <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org>
	 <CAADnVQ+F6JKp1e61NC22wt8L9YEVAz9w648GvdV8hUrM3dkDFA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3 (3.52.3-1.fc40) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-07-22 at 17:39 -0700, Alexei Starovoitov wrote:

[...]

> Andrii, Ihor,
>=20
> not sure what happened, but 'make clean' now takes forever.
> Pls take a look.

It happens under certain conditions, here is a scenario that behaves
badly for me:
- two branches:
  - 'master' at cca09a371fa7
  - 'tmp' with [0] applied on top of master
- Steps to repro:

    # cd selftests directory
    $ git checkout tmp
    $ git clean -xfd .      # be careful
    $ make -j test_progs
    $ git checkout master
    $ make clean
   =20
After which output looks as follows:

  CLNG-BPF [test_maps] access_map_in_map.bpf.o
  GEN-SKEL [test_progs] access_map_in_map.skel.h
  CLNG-BPF [test_maps] arena_atomics.bpf.o
  GEN-SKEL [test_progs] arena_atomics.skel.h
  CLNG-BPF [test_maps] arena_htab_asm.bpf.o
  GEN-SKEL [test_progs] arena_htab_asm.skel.h
  CLNG-BPF [test_maps] arena_htab.bpf.o
  GEN-SKEL [test_progs] arena_htab.skel.h
  CLNG-BPF [test_maps] arena_list.bpf.o
  GEN-SKEL [test_progs] arena_list.skel.h
  CLNG-BPF [test_maps] async_stack_depth.bpf.o
  GEN-SKEL [test_progs] async_stack_depth.skel.h
  CLNG-BPF [test_maps] atomic_bounds.bpf.o
  GEN-SKEL [test_progs] atomic_bounds.skel.h
  CLNG-BPF [test_maps] bad_struct_ops2.bpf.o
  GEN-SKEL [test_progs] bad_struct_ops2.skel.h
  CLNG-BPF [test_maps] bad_struct_ops.bpf.o
  GEN-SKEL [test_progs] bad_struct_ops.skel.h
  CLNG-BPF [test_maps] bench_local_storage_create.bpf.o
  GEN-SKEL [test_progs] bench_local_storage_create.skel.h
  CLNG-BPF [test_maps] bind4_prog.bpf.o
  GEN-SKEL [test_progs] bind4_prog.skel.h
  ...

[0] https://lore.kernel.org/bpf/20240719110059.797546-1-xukuohai@huaweiclou=
d.com/



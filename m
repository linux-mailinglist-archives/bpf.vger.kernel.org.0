Return-Path: <bpf+bounces-57766-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B40CAAFCA7
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 16:16:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BEF6188442F
	for <lists+bpf@lfdr.de>; Thu,  8 May 2025 14:16:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7814D26B951;
	Thu,  8 May 2025 14:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JcnRLeDS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com [209.85.160.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB7426FA4C
	for <bpf@vger.kernel.org>; Thu,  8 May 2025 14:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746713766; cv=none; b=ZenPNS+W5Q512DZgezrVzBOKFMAnnbL4Yhw1MBEVzcKzdsIg+FyMV5yOjpP7/7mS7x96oiFRqC+rpYfySxYpANJoG8ppOpzn/otG4ydDwD6K9PVvEB81tn8t2AoBbDxPGsjf+iitwKIuaBBfNxxOder7PKsxhMlIF3k5G9ZnYig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746713766; c=relaxed/simple;
	bh=QDdR5tA6fCYdLD5am3vh8l+BGODzygPrPOJzBOfeJVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WDRNNu+MlofQ/Ljk5rVtF+eDVbyJn7b2rgRHsInfx+yXG+9doPSv/uW7yO4O8qObNNtAl7DabWmmD7jG6pnD0eOISveVBckdSgVTtBzUaD7fSYXTMlP2/HWA/9FdAa/shqqSt7Wb56ekO/TGBrjJtDP5LRKW6zy4dCn7oKCSBlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JcnRLeDS; arc=none smtp.client-ip=209.85.160.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f169.google.com with SMTP id d75a77b69052e-47690a4ec97so12619111cf.2
        for <bpf@vger.kernel.org>; Thu, 08 May 2025 07:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746713762; x=1747318562; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDpuFbmKPGhtwFhs8+1sRyHe3lBe73vGf+W6LNv5WMo=;
        b=JcnRLeDSkQcQUqiy+gsijavEXmhAzVVqoNc8O9PCjNwfc+9Ew4w/oRfxoTWhoIIcym
         L930pyDD7/oBfA7RMkCKvUEPVqHZOeN+Z0DrENQ4KaKKGSORVZNxvSROBrFeZed0mjM6
         OlSdLN4gZ6q2TR7+b1lXSE9KFln2OxkhITlXzhIotZUFcWBCjjEEOzPeoOfoCfvkv201
         4u9df0O6F93h7WGSr5LAHClpPgGMteoXXlXyCLikMe/k9z0WpeoTxMkKuNMolIzWtaxL
         95L13ABpTXJj6E2Pc47k1+As/AYx6YPCY59JK7v5Evw1+kxhHFdzb644ZuOVm0BeVlXa
         Ic8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746713762; x=1747318562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IDpuFbmKPGhtwFhs8+1sRyHe3lBe73vGf+W6LNv5WMo=;
        b=dpbLR8dm0AMYy6HXQsHaeJWVU+rCoejVIPjT9LXeA+NoBKny6j0wmf1cBM617MbjAG
         pi2Pm4n4XvzaxxOSfi0j0EyF35E/t4EBTuxarbBEpCzqytyzZtqeeRKJHrbKMiQkR5Ro
         22zq5WsxK3QfREWHZZbPe1uqROUVGBwKbQkstizy8rBezSeWZKDQo8iE7fExBv2tRjO0
         3yyo8r0AssY0Kb/7EUT7nhCdBsWM5Rhhr43kRHHjIeI6LisseTJlA+YMhNBVQoo+glGk
         QbbrkvE1FabPezFEfS/DC7GRtOSXsoB7EP0tRgWOCyG3PYNSHaJjj7twdNn838bmkIHt
         /GOA==
X-Forwarded-Encrypted: i=1; AJvYcCV4PzryGMwKAjSqclxA7BG6E2LWx5AV2UZXgh7TO4iw1pPMFaEA8E5Nf5+zhSm3jx349Ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjOnVovV3/m2BqGizv27C9pN4qkbZnKptzvq3FyYVY7F78+NDx
	C3G7C86S45dyCDaYoRKzMCe79qJYRbsfn2Q8FgJEeXAWPxQ0joTs6TE8AV0WqZDWW1Uoh+bueg1
	UrworJEPi4q5uGGmSyYWPGCNmEYrVm9lr
X-Gm-Gg: ASbGnctOUsJqpkdYjFtGWUw5Y/taktbI7AWLhl5YTsL9csu3glSV9b+JUSAOsstSRJT
	QHLlR3+jdBI62vRb5NB8BKfNo87dtuJ1a72J+rHoWvh09P9WxM78z+f6j9D2gcsVayEC8ibV8wB
	d83DCgFtXEHxMxLY86jwgCuovBfxUFDbojnwLS0SVmUSO/R930VHMfv1U=
X-Google-Smtp-Source: AGHT+IGWwi9f8f4070aPaewqXIlv5BeMpweYLPsMY8g6yIECw6MfdPIpRTrkMYHJ/KIn4UMTnzqtKzUo89BgwWb56Ns=
X-Received: by 2002:ac8:58d1:0:b0:477:c04:b511 with SMTP id
 d75a77b69052e-4922620f004mr107953411cf.31.1746713761746; Thu, 08 May 2025
 07:16:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAK3+h2wo3KidH9yrGSNsV522BSkUJyn2TUp==tSv62937xPDMw@mail.gmail.com>
 <8f375e63-c4d5-b9cc-64c4-7563ba5c2763@loongson.cn>
In-Reply-To: <8f375e63-c4d5-b9cc-64c4-7563ba5c2763@loongson.cn>
From: Vincent Li <vincent.mc.li@gmail.com>
Date: Thu, 8 May 2025 07:15:51 -0700
X-Gm-Features: ATxdqUEEa1Z1mQa00hevvXcOIkbom88mG0ZyK3kU2QMuIfP-9O-RhE7kX4UTYbM
Message-ID: <CAK3+h2xJX6de6EX=W=Pk8Ai3+-H5U7wQ9AWvQqZZ4MG5vNUUQA@mail.gmail.com>
Subject: Re: [QUESTION] Loongarch bpf selftest liburandom_read.so build error
To: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: loongarch@lists.linux.dev, bpf <bpf@vger.kernel.org>, 
	Hengqi Chen <hengqi.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 12:23=E2=80=AFAM Tiezhu Yang <yangtiezhu@loongson.cn=
> wrote:
>
> On 05/08/2025 05:30 AM, Vincent Li wrote:
> > Hi,
> >
> > I tried to build kernel 6.15-rc5 bpf selftests on Loongarch machine
> > running Fedora, the bpf test programs seems built ok, but I got
> > liburandom_read.so build error below:
> >
> >   LIB      liburandom_read.so
> >
> > /usr/bin/ld: cannot find crtbeginS.o: No such file or directory
> >
> > /usr/bin/ld: cannot find -lstdc++: No such file or directory
> >
> > /usr/bin/ld: cannot find -lgcc: No such file or directory
> >
> > /usr/bin/ld: cannot find -lgcc_s: No such file or directory
> >
> > clang: error: linker command failed with exit code 1 (use -v to see inv=
ocation)
> >
> > make: *** [Makefile:253:
> > /usr/src/linux/tools/testing/selftests/bpf/liburandom_read.so] Error 1
> >
> > Am I missing  gcc tools for Fedora loongarch?
>
> This is related with the cmake option when compiling Clang:
>
>    "-DLLVM_HOST_TRIPLE=3Dloongarch64-redhat-linux"
>
> You can native compile and update your Clang like this:
>
> git clone https://github.com/llvm/llvm-project.git
> mkdir -p llvm-project/llvm/build && cd llvm-project/llvm/build
> cmake .. -G "Ninja" \
>           -DCMAKE_BUILD_TYPE=3DRelease \
>           -DLLVM_BUILD_RUNTIME=3DOFF \
>           -DLLVM_ENABLE_PROJECTS=3D"clang;lldb" \
>           -DCMAKE_INSTALL_PREFIX=3D/usr/local/llvm \
>           -DLLVM_TARGETS_TO_BUILD=3D"BPF;LoongArch" \
>           -DLLVM_HOST_TRIPLE=3Dloongarch64-redhat-linux
> ninja -j4
> sudo rm -rf /usr/local/llvm && sudo ninja install
> export PATH=3D/usr/local/llvm/bin:$PATH
> export LD_LIBRARY_PATH=3D/usr/local/llvm/lib:$LD_LIBRARY_PATH
>

Thanks Tiezhu!

Below is what I used, it looks like I missed the "lldb" in
LLVM_ENABLE_PROJECTS, I will add that.

cd $(DIR_APP)/llvm && mkdir build

cd $(DIR_APP)/llvm/build && cmake .. -G "Ninja"
-DLLVM_TARGETS_TO_BUILD=3D"BPF;LoongArch" \

-DLLVM_ENABLE_PROJECTS=3D"clang"    \

-DCMAKE_BUILD_TYPE=3DRelease        \

-DLLVM_BUILD_RUNTIME=3DOFF \

-DCMAKE_INSTALL_PREFIX=3D/usr \

-DLLVM_HOST_TRIPLE=3Dloongarch64-unknown-linux

> or install the fedora 42 and then use this software repo:
>
> https://mirrors.wsyu.edu.cn/fedora/linux/F42/rawhide/Everything/loongarch=
64/iso/

good to know, I will upgrade when I get chance.

>
> Thanks,
> Tiezhu
>


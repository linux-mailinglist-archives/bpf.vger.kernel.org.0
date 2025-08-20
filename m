Return-Path: <bpf+bounces-66115-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76811B2E7B5
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 23:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A9F5AA0875F
	for <lists+bpf@lfdr.de>; Wed, 20 Aug 2025 21:49:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BA1A33436B;
	Wed, 20 Aug 2025 21:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kxt0Ta4n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5331E1E19
	for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755726571; cv=none; b=VzZ9x9CjFica+d+QeM2sccU9+yE79a9/G+lT/CVv/gZva0V/b3Lq9CzHlvxxtj5tDhrYq1U2Ch8LXrhwkbPcrMg8rBgZMbj/Tx+nTwO/QH0ppN+rL4639KaaRFZP+rOD+qHgOuU9jetCiJtP7WtenBH8yyM7CDyxAue5a+cW71g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755726571; c=relaxed/simple;
	bh=+l4vIL8/PvwgO05TN20UEHe9XWBncgeOFPZLs0LFW0Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EZ0X1/UHZTOOQs8zoIAEsG/WTLQDEZZzQAAVvkOM4bsGROrDZbz/AuifPNPxX/Z4/XJ7BYSKpbq6qAFr+NcZ6ELUVLjOOVXrDyEYm+ukL04dqgwFYAm7SFIg1uH8ZdQSHMwILxRNEME87loN6wdmZTXcpE8niReHNfcPOUX06c0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kxt0Ta4n; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-32326e09f58so460331a91.2
        for <bpf@vger.kernel.org>; Wed, 20 Aug 2025 14:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755726570; x=1756331370; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=emI41Pkzr+O4VleC2pjruT+hzOHpw6ayuGsRwO0sAZw=;
        b=kxt0Ta4nAzO2vy09sV+YvsBPQ7tkJLEQTCkUoyHVu9s8uarmNZbm7LLi8ia8kubHYZ
         q5ggkSeTS4/GrWdNv70WDhCVCOM26UETAHLvllufJY7tWrH74uTLDelT3u4bbZSINRBG
         spUVr0tN1aZMh48SQG0nnodWA/FR6peZ8vAlQFyMTXVZlyuygEnmxXvdEH7AcXf+WVq1
         JP5jNuxUtNYu+PhlkPdN91fjsLRbIhvHBBmSnHU7Tm0LU7AqVysSR1S9mqWegEJx78sV
         JHbX6GdaGVRgbEEt6XfiH/Od19dr7o5KYwJRjRpThLPsbZHT5xs1CFiEavb8T4+MPnhn
         LLvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755726570; x=1756331370;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=emI41Pkzr+O4VleC2pjruT+hzOHpw6ayuGsRwO0sAZw=;
        b=WcyfL57Swoxp3z9Iu2IIqhbY1vpGftLUkCdCMekCa4J3K09gglXZaYEI68JNjVqafp
         S2LD8afZuCbJ6obGWQpHzsa/eIkZDBRSxS/YQoI6FYg4BAlKtfVI3WpZUA71cuvqpI2p
         JEqUsO3d8NLQSZ5THNmrqS5f0DPk3AnQ2MDvAjUXz/4h6Du/WLCfIl2kErGgoZ/qun1N
         P6Aeh3FV4CufNBelLA3k26i6HI1YY9j/BqfacWOteeE+Erb/zTompHt/cx2J25rl3jxU
         yLDM7q+/YUHcDiHpzRyuS6oKRYPPhnwA7ZXzNB4sBeTMdLrkhiRKsj/SYtBUQIahPLRO
         m6DQ==
X-Gm-Message-State: AOJu0Yz0sfrU71qukGjUM6avFb90mGTG0gWzF20Q+8NS9O/lcUJIL0Yb
	E0PxUMdI8YQ+RDXDfxbTCcE0XRGnMMK2txTENnn/rRmKRJeG6u2/JtHZaajYR7kebVkb4IshbbZ
	+t5dnc2n8G7HrjSnLx5C44DFhXw0A+Wg=
X-Gm-Gg: ASbGncsU/BiUbUpQRf//CnEUAoh0D9XppmoqxAhZOGp5z8XJDwdJ0msB6fOaXnSTDVN
	hDuiy5UWzB8JBBVdgwSjzEY6bUekDrY9vsaRQTLG4UEJrHq2dCP3G4thyHTkTsh2aqxwLqCSnVC
	0/XXrKcmkP0oSoQ9/5iOEuy/vcP9VSqKDeTXBXvDTBKXaBfSqReU7eV+BzIrgYdm4DRCufarFr0
	AJ3dxwKUyY6azVxvA3Ldgt6/yONs1CfYQ==
X-Google-Smtp-Source: AGHT+IEg/W2faBBELb2oBnRAmD7Wmw++WatT1PkULg0BGPznWZqAKurWm7YBX3jH5kPEZg2+rU3un6wEGFIqivvLpA8=
X-Received: by 2002:a17:90b:3886:b0:31c:3669:3bd8 with SMTP id
 98e67ed59e1d1-324ed193887mr433668a91.21.1755726569706; Wed, 20 Aug 2025
 14:49:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250818043020.371093-1-hengqi.chen@gmail.com>
In-Reply-To: <20250818043020.371093-1-hengqi.chen@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 20 Aug 2025 14:49:15 -0700
X-Gm-Features: Ac12FXznGFMccao6CEA-p2Vp3JdrdMhquWSgJvR23lXx2BRbnfuIoq-27ZP7Oaw
Message-ID: <CAEf4BzbK+4m9MynJ_23uOdRX7p3C0qsqqh1_odp-_xKhpiwkLQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2] selftests/bpf: Use vmlinux.h for BPF programs
To: Hengqi Chen <hengqi.chen@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, martin.lau@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 17, 2025 at 11:31=E2=80=AFPM Hengqi Chen <hengqi.chen@gmail.com=
> wrote:
>
> Some of the bpf test progs still use linux/libc headers.
> Let's use vmlinux.h instead like the rest of test progs.
> This will also ease cross compiling.
>
> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/testing/selftests/bpf/progs/loop1.c         |  7 +------
>  tools/testing/selftests/bpf/progs/loop2.c         |  7 +------
>  tools/testing/selftests/bpf/progs/loop3.c         |  7 +------
>  tools/testing/selftests/bpf/progs/loop6.c         | 15 ++++-----------
>  tools/testing/selftests/bpf/progs/test_overhead.c |  5 +----
>  5 files changed, 8 insertions(+), 33 deletions(-)
>

I'm getting this:


progs/loop6.c:58:5: error: redefinition of 'config' as different kind of sy=
mbol
   58 | int config =3D 0;
      |   CLNG-BPF [test_progs] sock_addr_kern.bpf.o
    ^
/data/users/andriin/linux/tools/testing/selftests/bpf/tools/include/vmlinux=
.h:71906:25:
note: previous definition is here
 71906 | typedef struct config_s config;
       |                         ^
progs/loop6.c:69:6: error: unexpected type name 'config': expected expressi=
on
   69 |         if (config !=3D 0)
      |             ^
  CLNG-BPF [test_progs] sock_destroy_prog.bpf.o
progs/loop6.c:92:9: error: expected identifier or '('
   92 |         config =3D 1;
      |                ^


So let's rename a too generically named variable?

pw-bot: cr


[...]


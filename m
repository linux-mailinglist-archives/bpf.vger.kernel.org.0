Return-Path: <bpf+bounces-14117-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CFEA7E0A4A
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 21:26:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 648601C210CC
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 20:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E5F623762;
	Fri,  3 Nov 2023 20:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XliUnG2Q"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE53D2375B
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 20:26:49 +0000 (UTC)
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 152A4D53
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 13:26:48 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2c50fbc218bso30824351fa.3
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699043206; x=1699648006; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lIPkfPZvsJFl00A6YMaZROp6c7APaKkERcq3nCq6tRk=;
        b=XliUnG2Q3qWIU811msTMJQBrAkbKAasGwmpD3QHOvWBQ5mnEYMMV68R5Gg0GBL8jhr
         ZwYn1MiM/eGaevP2+i3yoODXk4qmvZOPD/6mAk3B6YbegFp3vGMjtBdv87ThYUbq0NDM
         iZIRc6cmMmTeFzKwYeI2e6L8PBA1i+62mZk7kDiJDh5UryvvuC/+FoRr5MYseGOvWbCR
         AZe9wpvkKmZDlErXSaxb+S6/oMNsW4Z3M6u2EUDtvA/0n4GwbZSilxtbVu29Z5aN0jMR
         IHiQXe1VseBKnI1oN/r0VOA+F1F1Gesg4PMEj+y0DalAPiZ2D+rOdE8DWPv2Tk4obWIu
         enbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699043206; x=1699648006;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lIPkfPZvsJFl00A6YMaZROp6c7APaKkERcq3nCq6tRk=;
        b=Vv+Xnz6993zoTDEKc6O4vPzia0xWi1tkepgjXiEw9BbExzo3/0S6p87EmdY6NST9Fu
         P3rgpinspchFT1nqIcBGyZp9SUNp5Td9kZc3j3O2ouh4mq7TbWZVEDjFGjRx+ZUt7A5g
         dwv2cakaxPU6Qp5mh1PNeiV8b9FJGVJJcy/o+XM30tVNRNQ41t0mYzInlCZQOXfaKj+3
         CHU2LtGyKQP2lzaTnlXtNNEEPprG/zoRTZuisJOFoepOwvUJP3A/xpnx9+j3MLtYSi6A
         xejqOpi6qwnpkePKAJ9HZXeTYl7YX0nuK0M8/kc9C8k6bAztKsP/qWgGLddONodctWtH
         8cZw==
X-Gm-Message-State: AOJu0Yyu/fPRj7yBiUIETHio7YOlZGA9abk2Et99XZ0nke/QGUgc43AU
	DfNt8GU5A32uRHCPONbBJT5JT0+dbnmtqaHNOds=
X-Google-Smtp-Source: AGHT+IHYpRg8cWvsELbq/cDvWCzFmXw8xZgCCK+woCvoFKHU89G7hjvAxcsp33/6p5G3nKV9dLLrgXTv/26EZC8XeZo=
X-Received: by 2002:a19:f70c:0:b0:503:3278:3221 with SMTP id
 z12-20020a19f70c000000b0050332783221mr15770642lfe.69.1699043206004; Fri, 03
 Nov 2023 13:26:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231103190147.1757520-1-song@kernel.org> <20231103190147.1757520-3-song@kernel.org>
In-Reply-To: <20231103190147.1757520-3-song@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 3 Nov 2023 13:26:35 -0700
Message-ID: <CAADnVQJgsaH1XddyKphFW0to_0n7xFY_5SFQ2BjMeFACQNH2Zg@mail.gmail.com>
Subject: Re: [PATCH v9 bpf-next 2/9] bpf: Factor out helper check_reg_const_str()
To: Song Liu <song@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, fsverity@lists.linux.dev, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Eric Biggers <ebiggers@kernel.org>, 
	"Theodore Ts'o" <tytso@mit.edu>, Roberto Sassu <roberto.sassu@huaweicloud.com>, 
	KP Singh <kpsingh@kernel.org>, Vadim Fedorenko <vadfed@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 3, 2023 at 12:02=E2=80=AFPM Song Liu <song@kernel.org> wrote:
>
>
> +static int check_reg_const_str(struct bpf_verifier_env *env,
> +                              struct bpf_reg_state *reg, u32 regno)
> +{
> +       struct bpf_map *map =3D reg->map_ptr;
> +       int err;
> +       int map_off;
> +       u64 map_addr;
> +       char *str_ptr;
> +
> +       if (WARN_ON_ONCE(reg->type !=3D PTR_TO_MAP_VALUE))
> +               return -EINVAL;

Pls drop WARN. People run kernels with panic_on_warn.
This is not an error that is worth panicking on.


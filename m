Return-Path: <bpf+bounces-50825-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 28750A2D1F0
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 01:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A99B188E8BB
	for <lists+bpf@lfdr.de>; Sat,  8 Feb 2025 00:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFD1A8C1F;
	Sat,  8 Feb 2025 00:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nhnK193r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B2C29CE8
	for <bpf@vger.kernel.org>; Sat,  8 Feb 2025 00:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738974223; cv=none; b=gKLRajEz1EXGcjpE6WTtRz4fsqt4bXoxBpfxISDhmXvBUPV0oH0+utAUfIO47oyacSDwIiKvdMsyf1D7C/pNFYa6vesQhpceEPg7QQ06xcKHeiau5p7E/aCYPiLtM5aNhMOgjAVk4RjeMiA9xJ9yW0BIcgZkDjScLIepDGYn0hs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738974223; c=relaxed/simple;
	bh=hoyDtzO67Dh6ArIc58+ZMt7Z2C+fRhlzS0vf1xMC8D0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvdvVuNcOpIHx74gWVYFSxbabeXIfQP9JTHn7/sIA4I2olhQb0fnS60W74LpNGClmK+TGiMH7djeWlMSNgNUMHV/XKW5o+CRD8jyN9AsdBL//iLA7dogywLGPuhTZq4CsSUdE7YixqVcgrCUPv4a3l1lWuXgGGD2lBbatLCO3Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nhnK193r; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4361b0ec57aso25687665e9.0
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 16:23:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738974220; x=1739579020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2tRghJIEJue7F9MuUMO6PiPGCqFuWqiVwLzGk2L1Lrc=;
        b=nhnK193rIYR3LXNKHYh3HrXVs7Lif/LH2zYwPtIU4JVkP/VC/NyNyb+EkQMlcOtFEA
         68XuMaRc7lS873db6Rw0qzW6kUjnKPDF3yREydW9FncNnaTXXXUlY88t7Dc7EuE8ci0t
         9hAiHytgXhrC0vTH6riqJHU2R1ZAB7bFkAbOgvdmCGQpmlBx+SyHdsst4AkR/mIbF/rn
         sBgtnv0Jb4wqsSRUIG4EZXmGByQAFheVbkH8nYk4NRK0Qyn+x2rTZxirkjBgwdSwtKcx
         TNycOiidfAgCcQm1sueCNzkzbgQusOcNYhAjgXXxGH+H7c/UzULMNRo6lVLT6PVn8KTA
         n7kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738974220; x=1739579020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2tRghJIEJue7F9MuUMO6PiPGCqFuWqiVwLzGk2L1Lrc=;
        b=JuTbCv5d2rRibFXtoGCZUDg79Z+8uagtdLzXDngBU8uhrS5mQIob39DeneNtvmHEng
         Fwqg6Qm75cRQQXKGmpDBq1Y8+9CeX4Bf/9zcJsd3t83gwGxYbMLPHH2Z8+srlpN8OeN4
         zFBoh6t0yGdqx66kRIh6x5ydrm2hdwClVB9/M97/ZF420S0cVZpgB8H+GWMTcpJIUGnf
         gqRLFwtxbe/U8UjzQs5aHthgBNzyMPqj07kxN5pJ++PDnPhzn/GaospOzdEnHrccJltn
         plNqV+rODmv2ocDPsvPLIJQqlOvRHrulXcN0vw/4eukBX6XGYJicf7aTub7f2bg2x3q7
         cmsA==
X-Gm-Message-State: AOJu0YwELAdWrlOXH6qEIGy80HKr9u2bNomV7hvTTW5JEr3E/5B05BJ8
	P1ynqSfdj2gZ7fq67MeX7RgSqSVyrQSAnrDfVeFYHfYxhnrqHbe6j0nvYZNVZEKJoke7GHFoxa/
	kl48r2fOLBnx0MudMKlqQE7hZzwY=
X-Gm-Gg: ASbGncvug/WWMROUGdlXZBCqn1bVQFBHB7oj/oXysNCOOtdudQqLcMC6zN9w+6Tb4oP
	6IibbwzYD/nnfgprulJ4yq/RP+HMOC4/pxwmF9seqs9iVT0pH1VCM2eK7F8/atHCDORMEdQ5CCb
	yul3+g+kWrQdLK0NMbi2jyxWNVTSr5
X-Google-Smtp-Source: AGHT+IGOb1g3xr+DZDYIxO/L0Nct0tLyXAUtW6AjWJ72/aaw1UVIDnJ0xk43cPUsgwFIh8+IJaSVnoG63Gi7ByIFZ0g=
X-Received: by 2002:a05:6000:1562:b0:38d:be29:fa5b with SMTP id
 ffacd0b85a97d-38dc8d9bed1mr3874958f8f.5.1738974219953; Fri, 07 Feb 2025
 16:23:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127162158.84906-1-leon.hwang@linux.dev> <20250127162158.84906-2-leon.hwang@linux.dev>
In-Reply-To: <20250127162158.84906-2-leon.hwang@linux.dev>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 7 Feb 2025 16:23:29 -0800
X-Gm-Features: AWEUYZmz1uH8WDK1lZZijxL8O6dWhtOV-SyUWgQbze3GeGJh49wrObTe_oa2qmw
Message-ID: <CAADnVQJu3KCOQFP6M2MSaan2jZSYrQEa=1+ZS=XfbpnV=iGmZw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/4] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, Eddy Z <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Daniel Xu <dxu@dxuuu.xyz>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 8:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> +
> +static int percpu_array_map_direct_value_meta(const struct bpf_map *map,
> +                                             u64 imm, u32 *off)
> +{
> +       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +       u64 base =3D (u64) array->pptrs[0];
> +       u64 range =3D array->elem_size;
> +
> +       if (map->max_entries !=3D 1)
> +               return -EOPNOTSUPP;
> +       if (imm < base || imm >=3D base + range)
> +               return -ENOENT;
> +       if (!bpf_jit_supports_percpu_insn())
> +               return -EOPNOTSUPP;
> +
> +       *off =3D imm - base;
> +       return 0;
> +}

Pls add a selftest for off !=3D 0.
I think the above should work, but this is not obvious.

>
> +#ifdef CONFIG_SMP
> +               if (insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
> +                   (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
> +                    insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE)) {

Is there a selftest for BPF_PSEUDO_MAP_IDX_VALUE part ?
I couldn't find it.


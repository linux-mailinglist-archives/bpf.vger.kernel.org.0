Return-Path: <bpf+bounces-71609-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35418BF7F74
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 19:49:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7216B4FFEE1
	for <lists+bpf@lfdr.de>; Tue, 21 Oct 2025 17:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B688334D4E8;
	Tue, 21 Oct 2025 17:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RHfVKKSM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EBD73557F5
	for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 17:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761068972; cv=none; b=Rn4nbvphrnjZg0Va0MGXQNxjbxGk11wH4gedszAN7P6qGthDqEedyEMuRPAIwhdM1zQ+lf7BVagR6Ad721zEzbNsSXpY93J8rqw9Qp9cEOgmNeh+IjBdReyW8AQCRtHiFG9qmtH6rCpo28KqhwZNrz6ex3Ul7Nnv8jUh+XuEFMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761068972; c=relaxed/simple;
	bh=u13EVMrPrzTJhz9jYJJ1yCySUbPWtGIFgItzk3PKokM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lQO14VnwuhZlYBo6spX+NtAeHhOWtU5ImlAGm2szfiEaMFOe2+d0SwXN14tGjvdcm8F4t/BajHFcXY8NjIdcdqC4xSPP7RFHd2wVWmnukxCQ2fRPOvTw8VLBCzQGo3ZHvIMxNvSGXsktNfAXQJGFsZXZiYyeBE35710HG2fNRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RHfVKKSM; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3f0ae439b56so4321145f8f.3
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 10:49:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761068969; x=1761673769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JvBlVAFkGeYhVHWR2dhdAwJJhL860Mgj5uATbp3FWJA=;
        b=RHfVKKSMdiJsPxQ+aGDR6b7I/Obe4WBYANvBcEDKziQjNM+/vYw8TAPlQkZGCqOXJ2
         iOfG4PEazK6uumeiKSzFem8NR25+Ea2KepTSu5CcCE5L7/IuYieuQi5viBCIuyGZeR7r
         s3/b899HlZUGhazQZUcdlaQPKYIana6UNFBG+BajAYX6y2FwADqmQBx3Y4U7dPnmkDSN
         QLYIcl+e0qwNs2zfJPq1v9op/x2rHSiFafracteTjFL+/VOQFGBMYoO4fOOojb94sxmu
         8+mbI/BlHKMDWxqbk0YLQuV/ub65xNapIrny8X6+P6UqOHrjdd6TNfTGMVV94Ng/4tYo
         0aSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761068969; x=1761673769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JvBlVAFkGeYhVHWR2dhdAwJJhL860Mgj5uATbp3FWJA=;
        b=g2HKLm6CKVtCkkNrHf+YKzZwuhxOfk4D61xsfkqyrjXWr1VSpUel0K0NatGlCP5HsE
         LPkjrOEqNE8LdLsFHQDjZH8PV/kc3Ym9c8voS2hnT39FjCaXX6DOYHQso6FTlrPrQpRD
         hiOMX1C4MSPsWGvAx8vJoRM6JYSEPSHNuBjmIXEggEFQaD8a8HSMSekTwjUzeBksSbqY
         z70jJei8l7zJv+Q5XyU3VS0jQ6mmQhb5ga0rfdbZWEVzL1L4Y2OVz0LXoZZnpDhCFwBI
         U+679SmqCKLdDldq3xt/6i57SgZAlQlVXv0BGRe1Baj0ZJdc/Ebit97yKveMFcxGXy9j
         uNvw==
X-Gm-Message-State: AOJu0YyFeikXE4l881hH4Kq9aqIi+MkPl0HVUr3FKEe4QAYruLdaQVhn
	8tUAXDGDcTQidxd/oWpGZH6OORK032NX2Z4ks59n48YW6xOL3rRm/uH5xO6ARxAFmJGDdH7fqHW
	HG6/EZo5I0gHVgd5rbAFQ6ba4G/C1DMZJmRdz
X-Gm-Gg: ASbGncsaHb7Lc4iIVVP0KKkVKhw3K6bFRduX9a6yPVzYAHPwFuwNQQY3w+UwP7TGPPZ
	KK+6endonpzXmGl/1nxyvvStpJEgZO7aJKHlKjFgVCDw1u0B1ShfvBW+D76YrYqfHCmb7xHvboe
	hy3wqDgg+ApbITnGkJS73WycJDP6TtSyPWqB9OPlfshUyNSLCqPVrydo/c+cMvJQJbgA8GWJrgh
	7x6SASXGEJGz5hKH3Qosyn6cYU90ri/7jzwj8C+HSSp0/WmFCdvcF/yGkSegMoXASDwOl7aaz4m
	L893U67446E=
X-Google-Smtp-Source: AGHT+IGxDsr+ggHVf56/MKDGLzcfWZS1JGAx5oCHdaa4Aj+sSglmoIQHfBXL0I+LOll/ZCnkLR2JhdW0ASS9ki5skVk=
X-Received: by 2002:a05:6000:2c09:b0:3ec:e0d0:60e5 with SMTP id
 ffacd0b85a97d-42704d75008mr13104119f8f.15.1761068968666; Tue, 21 Oct 2025
 10:49:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251019202145.3944697-1-a.s.protopopov@gmail.com> <20251019202145.3944697-5-a.s.protopopov@gmail.com>
In-Reply-To: <20251019202145.3944697-5-a.s.protopopov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Oct 2025 10:49:15 -0700
X-Gm-Features: AS18NWDqG8GaPlTwVv_ua5XH8ONsn-ovmbp9A_VHqRYP9LFLSX5yYi7qjssCGX0
Message-ID: <CAADnVQLOtQWMb4eOtLXyXhWrkPV8DKdYajb+DbG=sSucEbtJFw@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 04/17] bpf, x86: add new map type:
 instructions array
To: Anton Protopopov <a.s.protopopov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Anton Protopopov <aspsk@isovalent.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Eduard Zingerman <eddyz87@gmail.com>, 
	Quentin Monnet <qmo@kernel.org>, Yonghong Song <yonghong.song@linux.dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 19, 2025 at 1:15=E2=80=AFPM Anton Protopopov
<a.s.protopopov@gmail.com> wrote:
> diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
> index d4c93d9e73e4..c8e628410d2c 100644
> --- a/arch/x86/net/bpf_jit_comp.c
> +++ b/arch/x86/net/bpf_jit_comp.c
> @@ -1691,6 +1691,7 @@ static int do_jit(struct bpf_prog *bpf_prog, int *a=
ddrs, u8 *image, u8 *rw_image
>         prog =3D temp;
>
>         for (i =3D 1; i <=3D insn_cnt; i++, insn++) {
> +               u32 abs_xlated_off =3D bpf_prog->aux->subprog_start + i -=
 1;
>                 const s32 imm32 =3D insn->imm;
>                 u32 dst_reg =3D insn->dst_reg;
>                 u32 src_reg =3D insn->src_reg;
> @@ -2751,6 +2752,13 @@ st:                      if (is_imm8(insn->off))
>                                 return -EFAULT;
>                         }
>                         memcpy(rw_image + proglen, temp, ilen);
> +
> +                       /*
> +                        * Instruction arrays need to know how xlated cod=
e
> +                        * maps to jitted code
> +                        */
> +                       bpf_prog_update_insn_ptr(bpf_prog, abs_xlated_off=
, proglen,
> +                                                image + proglen);

...

> +void bpf_prog_update_insn_ptr(struct bpf_prog *prog,
> +                             u32 xlated_off,
> +                             u32 jitted_off,
> +                             void *jitted_ip)
> +{
> +       struct bpf_insn_array *insn_array;
> +       struct bpf_map *map;
> +       int i, j;
> +
> +       for (i =3D 0; i < prog->aux->used_map_cnt; i++) {
> +               map =3D prog->aux->used_maps[i];
> +               if (!is_insn_array(map))
> +                       continue;
> +
> +               insn_array =3D cast_insn_array(map);
> +               for (j =3D 0; j < map->max_entries; j++) {
> +                       if (insn_array->ptrs[j].user_value.xlated_off =3D=
=3D xlated_off) {
> +                               insn_array->ips[j] =3D (long)jitted_ip;
> +                               insn_array->ptrs[j].jitted_ip =3D jitted_=
ip;
> +                               insn_array->ptrs[j].user_value.jitted_off=
 =3D jitted_off;
> +                       }
> +               }
> +       }
> +}

This algorithm doesn't scale.
You're calling bpf_prog_update_insn_ptr() for every insn
and doing it as many times as they're JIT passes.
There could be up to 20 passes and hundreds of thousands of insns.
x86 JIT already keeps the mapping from insn to IP in jit_datat->addrs[].
Use it. Roughly like:
insn_array =3D cast_insn_array(map);
for (j =3D 0; j < map->max_entries; j++) {
   ip =3D addrs[insn_array->ptrs[j].user_value.xlated_off -
subprog_start] + image;
And this is done once per insn_array after JIT is done.


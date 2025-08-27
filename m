Return-Path: <bpf+bounces-66745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A1A46B38F00
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 01:18:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA623BADF4
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 23:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FC330CD80;
	Wed, 27 Aug 2025 23:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZgF0/AlS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02861239E8B
	for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 23:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756336700; cv=none; b=s3ecNlH9hV1qxXHSyjSYFj7H23797PRqdsSIujBh2BVTheDVPFushx7ur6Hnmz6Ma4r7277AlIH8UOOZsgH4nJbBL8MVJrzKNwt8ugBeXjHCRawEM/OIp+Y5IOpEyn6jPQx8vmOXaGbj5AmP/vOGTCKPqA4b4LrCYtNhHcxMPWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756336700; c=relaxed/simple;
	bh=1OTIrtEbW/qDWAwsIbHryjux3Va3r5auhMI3MLuKwmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPgVsBkmNfgd7gGk9o/hUwODzU2Y4IeWUsPykSArj3ORpW7QOMnoCS+/IIS7VUyC3K1g04gJSA86fF3PdF5e/sxUu52Q4FId608r2QrofE/YtvfIDv1nwzOWaX8poiUVHJuTxgQPFAZM+bJ8OvDUcuRFdlZqWKbMywaB7ssFaco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZgF0/AlS; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3252c3b048cso337674a91.2
        for <bpf@vger.kernel.org>; Wed, 27 Aug 2025 16:18:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756336698; x=1756941498; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l8+uFlrjeT+Ukr+wEIWpTRGQd1QRdf6huTdc9xZnDBo=;
        b=ZgF0/AlSC7Ejh6GA8iJi/yHqVFv39Voe5Z2PJb86NQ4TSgN1xN9AaQ8mIbDEpHPCpc
         8DP3In+IVLV2YIsqMp6SnFAyAhXW9xwTixPWB9+Dl194pmM+TK9rz8/tbj2gqm6IeAUL
         1PoX4cgFxH2dtbJrUaquDdwKwaICdYScytjx6mnVk8h0aTtyEycknahvyYyo4Fq2Ze31
         BPbVxrXTLYyyvyD0fGczkuuODpppAwKIShf2BoCPlI1zS5Gur4kNBskKa23b38nCY5s5
         iJmTY4XCBOFSb3JE5df1wPTbVZIdBAhTUnutd20cJTdxIESetGODMbYCy3rApbgKg1j2
         VLNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756336698; x=1756941498;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l8+uFlrjeT+Ukr+wEIWpTRGQd1QRdf6huTdc9xZnDBo=;
        b=MZyXSFgViJwYDb8f2ArhepdzuwwEtylaU4MHuu6CIqOFu3rvTMz2YwgFPvjYZcKJ0u
         oZuGIrVu204hSZUX8nrU9FTtchSjqtk5rE0Y02Rx0k9fp2PMoshDCdLxq1iGi3B5BM2i
         cDGzkWNZnw0i3Mt6fwQvftsVfIk9c08LPniUkqgzpnd7ydbNVPfuTVrPd/acwRdFpaI9
         ZTYXPolf3mkoPtTxrisjfFZcwsF/fFc5YOO/JOY8M+QHVM+w6S7/zIAy8JLqwZitzdKF
         sz8RniutsX9tPGuvcuBMOvcSx6jcMGRXnAO1mEghXeLnDFIN/f276T4WQXP4rVjKgFAF
         eqkQ==
X-Gm-Message-State: AOJu0YxNOEMZf+HvI6iX9EPiWOHuVK+lJNkF/4c8X7cfCvgzpbuyLwYQ
	fBDEMxsjagy4LabzD3d9r+RQIFqjQJZ0plWO21irCmaTQ+y070pbrNYOdce5iaJwh8Ixr4vAkCM
	a5MfeTAZsSBRHtAJuMySlAcrTF/j6VRk=
X-Gm-Gg: ASbGncttivvILuAvDQ9payDt5lMmSKVllQIvZTbc5C3VI/k7/5k5NSvgC39Ze84mx+4
	/UyjnSmW3twiW6/fbFhbJvAB1RDr9Jl3w08r+nejy33wi0p2nmtNYpGetkNuUHLnK0VXvOmJVrt
	PSIMwVDxsCOmqXIbL84IGmQaGCB2PVXE3tOiThx+Hoo6yRACYm7RFuCuqe2VfWMCvRR2SmSWNhM
	eWAFVbmDpy0oJ2WNkz1jyY=
X-Google-Smtp-Source: AGHT+IHPkqCWqh1CGyiAlT9UZr0mtKSaUyRsZvVdHbBOajJzQJtHj8ZRp0gTjs2nZ+6D7+322RlAGi/Ht1kozl4v4JA=
X-Received: by 2002:a17:90b:3b92:b0:325:3937:ef95 with SMTP id
 98e67ed59e1d1-3253937f223mr25855944a91.15.1756336698141; Wed, 27 Aug 2025
 16:18:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827164509.7401-1-leon.hwang@linux.dev> <20250827164509.7401-3-leon.hwang@linux.dev>
In-Reply-To: <20250827164509.7401-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 27 Aug 2025 16:18:01 -0700
X-Gm-Features: Ac12FXwevnJvrE1ECmOZ88i9UoMWIcrF43TlgIN1RXgwTPIRMkLp4y5xmBYmx_Q
Message-ID: <CAEf4BzaUw868nNG3ngMci4fLPDGsaffQ-O3YrPOEo7N5QEkM_w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/7] bpf: Introduce BPF_F_CPU and
 BPF_F_ALL_CPUS flags
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, jolsa@kernel.org, yonghong.song@linux.dev, 
	song@kernel.org, eddyz87@gmail.com, dxu@dxuuu.xyz, deso@posteo.net, 
	kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 27, 2025 at 9:45=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> Introduce BPF_F_CPU and BPF_F_ALL_CPUS flags and the following internal
> helper functions for percpu maps:
>
> * bpf_percpu_copy_to_user: For lookup_elem and lookup_batch user APIs,
>   copy data to user-provided value pointer.
> * bpf_percpu_copy_from_user: For update_elem and update_batch user APIs,
>   copy data from user-provided value pointer.
> * bpf_map_check_cpu_flags: Check BPF_F_CPU, BPF_F_ALL_CPUS and cpu info i=
n
>   flags.
>
> And, get the correct value size for these user APIs.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  include/linux/bpf.h            | 89 ++++++++++++++++++++++++++++++++--
>  include/uapi/linux/bpf.h       |  2 +
>  kernel/bpf/syscall.c           | 24 ++++-----
>  tools/include/uapi/linux/bpf.h |  2 +
>  4 files changed, 103 insertions(+), 14 deletions(-)
>
> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> index 512717d442c09..a83364949b64c 100644
> --- a/include/linux/bpf.h
> +++ b/include/linux/bpf.h
> @@ -547,6 +547,56 @@ static inline void copy_map_value_long(struct bpf_ma=
p *map, void *dst, void *src
>         bpf_obj_memcpy(map->record, dst, src, map->value_size, true);
>  }
>
> +#ifdef CONFIG_BPF_SYSCALL
> +static inline void bpf_percpu_copy_to_user(struct bpf_map *map, void __p=
ercpu *pptr, void *value,
> +                                          u32 size, u64 flags)
> +{
> +       int current_cpu =3D raw_smp_processor_id();
> +       int cpu, off =3D 0;
> +
> +       if (flags & BPF_F_CPU) {
> +               cpu =3D flags >> 32;
> +               copy_map_value_long(map, value, cpu !=3D current_cpu ? pe=
r_cpu_ptr(pptr, cpu) :
> +                                   this_cpu_ptr(pptr));
> +               check_and_init_map_value(map, value);

I'm not sure it's the question to you, but why would we
"check_and_init_map_value" when copying data to user space?... this is
so confusing...

> +       } else {
> +               for_each_possible_cpu(cpu) {
> +                       copy_map_value_long(map, value + off, per_cpu_ptr=
(pptr, cpu));
> +                       check_and_init_map_value(map, value + off);
> +                       off +=3D size;
> +               }
> +       }
> +}
> +
> +void bpf_obj_free_fields(const struct btf_record *rec, void *obj);
> +
> +static inline void bpf_percpu_copy_from_user(struct bpf_map *map, void _=
_percpu *pptr, void *value,
> +                                            u32 size, u64 flags)
> +{
> +       int current_cpu =3D raw_smp_processor_id();
> +       int cpu, off =3D 0;
> +       void *ptr;
> +
> +       if (flags & BPF_F_CPU) {
> +               cpu =3D flags >> 32;
> +               ptr =3D cpu =3D=3D current_cpu ? this_cpu_ptr(pptr) : per=
_cpu_ptr(pptr, cpu);
> +               copy_map_value_long(map, ptr, value);
> +               bpf_obj_free_fields(map->record, ptr);
> +       } else {
> +               for_each_possible_cpu(cpu) {
> +                       copy_map_value_long(map, per_cpu_ptr(pptr, cpu), =
value + off);
> +                       /* same user-provided value is used if
> +                        * BPF_F_ALL_CPUS is specified, otherwise value i=
s
> +                        * an array of per-cpu values.
> +                        */
> +                       if (!(flags & BPF_F_ALL_CPUS))
> +                               off +=3D size;
> +                       bpf_obj_free_fields(map->record, per_cpu_ptr(pptr=
, cpu));
> +               }
> +       }
> +}
> +#endif

hm... these helpers are just here with no way to validate that they
generalize existing logic correctly... Do a separate patch where you
introduce this helper before adding per-CPU flags *and* make use of
them in existing code? Then we can check that you didn't introduce any
subtle differences? Then in this patch you can adjust helpers to
handle BPF_F_CPU and BPF_F_ALL_CPUS?

pw-bot: cr

[...]


Return-Path: <bpf+bounces-50810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 075AEA2CFF3
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 22:45:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B43097A1468
	for <lists+bpf@lfdr.de>; Fri,  7 Feb 2025 21:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CFEC1AAA10;
	Fri,  7 Feb 2025 21:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YSIM32Hf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BE018FC7B
	for <bpf@vger.kernel.org>; Fri,  7 Feb 2025 21:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738964747; cv=none; b=qHiRpJYQQQD/HU+c6GOqCdectXjfZJtc/4FT52cTgGGdY4GM4j1UliNdSaOR6aNARwxjfpi0LxnFsp2Fel0EQq7cThjo9T7XoGos1f6pCnVaQejvi9nivF6hp3k1bDG+Piprj3w468J6/0cv1ZgLDz11BID/4I8WckYPote69Mk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738964747; c=relaxed/simple;
	bh=YAGXei3uIb2xstssswdfDLaO16tDnZyZbrPIHqD+Yjc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YIDlylGlqzIbP7IalGlAtA4QOPs42MVz4T2f/S1YB4VtU31G3m29ns4QP+/esygMREjoWRDGNo4lvr/vAQAEC9JWG6hvWAFxczTg1wgFjXaeNtffowjHGONMRwY2hANPhElKXsdMm2GLApDB7AzjljK3/GzjbNj/yrVK4OXJ+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YSIM32Hf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-21c2f1b610dso63281955ad.0
        for <bpf@vger.kernel.org>; Fri, 07 Feb 2025 13:45:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738964745; x=1739569545; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xjWvW7s4b+iC4IQG7CWaGbPnbtG7PfnL6I0B6U/ZmRU=;
        b=YSIM32HfLWjr4Sc7/3kh1F56zceXYiUlD5BhASr4mZ/ZjpCrHLpykPEtPWKgGsW9c/
         jLp7G4KqPFPMKboWsN/cC4zBw/E8bAwQDzjZg36yaZKLhF415qMeBgaLexHu7k3Zf2Jv
         71cd0B04QP0e6kXLnfzY9bl5W3C1XtDlfspMI8XFkYtuNwtD/oxbwVbbEDQEAQ+KjMUS
         6KiSrHK8c3k3eZNopIoCFAxzXKB158MMPveLVPGCbZA5VIdmRnVgpIwtyruj+gST5P1q
         fs2fzqSKzoDNdCBLgjMT1JKgdF9b+BQ3I7mAPRhtBNNGOhm4/CPijOTAfToWnJ535dEH
         7MAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738964745; x=1739569545;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xjWvW7s4b+iC4IQG7CWaGbPnbtG7PfnL6I0B6U/ZmRU=;
        b=qoclzkXS/6pH3SBhpHqMGObhOzix4GrBhUTmXYj8j4QU/DyNzAlZjiAhkEGTjusVDU
         WbZcxyiZrBbIOSANjifRz7zo7dJA66S4RMAFLTr6OavvO0DTvSF/jUSmZtwlHVY6lt5u
         JcNVvV9OQbr25l2REIEVbeUdwBDdxIju+Z+TRirEm+LFZfZU9UvCOYxlRywa1tu09Su7
         nKC+7V9yv0hZlJvAcQCZ8EjpBKPESSNiwuhzzBP9sND5HthUneo2yFh0y8izXrJ2Uvap
         oIm7W5eaIegEsvKSOaKRaivZeACdpJCVS44C21ST3imIw9MkU5roc2LOcRbc8oEKb3jr
         ASrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUghj1UNV7TcltIZHGT7HohmobzeUHI3A5fgR/1Xkq25PueSeLvavptJEItgEeO8B/JmgA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfqqhMW6t4I0np5Ty8QwE+xsmk85sNfoc4LnXTECT3gB31aVj+
	Hl0BrPqLg/lDC5ipEVIesZE8T0X6nwqY5ZujZIkDpBZe6xDik1eqhGZQnA==
X-Gm-Gg: ASbGncskNaiMykdMxdur2EvQVfae7Wu8MS/L4TTmLqW/NmrubriGbs8sOZ4AvQJd9qc
	wMZQbNOmaCjD5zSDShnYXA6AevWGQgQweP20yJ4pHoTvKuRY2oW1erP4Qi+BRcZo9Smi65xSQhm
	DbpAQX3hblATRnYrG9W7pRKpXVJoz+YL5RPgSbHPP9MwhNkXsO++kR+f1Z60iHZqt48Wg2xxXHw
	xuo0UoSJlnZ0AHkNY9tyY1y5VCVFbEIdkAsDOJ4amRidU+HsXguIsZBC69xz3XHTG6D5bthWD5K
	tIJuaqa/PQ6/
X-Google-Smtp-Source: AGHT+IFfL4LrYSOBBO+ewJYNQ3VIfQnHvEqqfeXqjZ39xxAqgaNUSgvtO/0DghT/nZJ9d+RGtz7BqA==
X-Received: by 2002:a17:902:ce8f:b0:216:6769:9eea with SMTP id d9443c01a7336-21f4e798090mr73163875ad.37.1738964745419;
        Fri, 07 Feb 2025 13:45:45 -0800 (PST)
Received: from [192.168.0.235] ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa2716c1ecsm2007903a91.25.2025.02.07.13.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Feb 2025 13:45:44 -0800 (PST)
Message-ID: <58436ca32a9ba1fb1cad6d822d6dbbd926ac2375.camel@gmail.com>
Subject: Re: [PATCH bpf-next 1/2] libbpf: fix LDX/STX/ST CO-RE relocation
 size adjustment logic
From: Eduard Zingerman <eddyz87@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
 ast@kernel.org, 	daniel@iogearbox.net, martin.lau@kernel.org
Cc: kernel-team@meta.com, Emil Tsalapatis <emil@etsalapatis.com>
Date: Fri, 07 Feb 2025 13:45:39 -0800
In-Reply-To: <20250207014809.1573841-1-andrii@kernel.org>
References: <20250207014809.1573841-1-andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2025-02-06 at 17:48 -0800, Andrii Nakryiko wrote:
> Libbpf has a somewhat obscure feature of automatically adjusting the
> "size" of LDX/STX/ST instruction (memory store and load instructions),
> based on originally recorded access size (u8, u16, u32, or u64) and the
> actual size of the field on target kernel. This is meant to facilitate
> using BPF CO-RE on 32-bit architectures (pointers are always 64-bit in
> BPF, but host kernel's BTF will have it as 32-bit type), as well as
> generally supporting safe type changes (unsigned integer type changes
> can be transparently "relocated").
>=20
> One issue that surfaced only now, 5 years after this logic was
> implemented, is how this all works when dealing with fields that are
> arrays. This isn't all that easy and straightforward to hit (see
> selftests that reproduce this condition), but one of sched_ext BPF
> programs did hit it with innocent looking loop.
>=20
> Long story short, libbpf used to calculate entire array size, instead of
> making sure to only calculate array's element size. But it's the element
> that is loaded by LDX/STX/ST instructions (1, 2, 4, or 8 bytes), so
> that's what libbpf should check. This patch adjusts the logic for
> arrays and fixed the issue.
>=20
> Reported-by: Emil Tsalapatis <emil@etsalapatis.com>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Do I understand correctly, that for nested arrays relocation size
would be resolved to the innermost element size?
To allow e.g.:

    struct { int a[2][3]; }
    ...
    int *a =3D __builtin_preserve_access_index(({ in->a; }));
    a[0] =3D 42;

With a justification that nothing useful could be done with 'int **a'
type when dimensions are not known?
I guess this makes sense.

Acked-by: Eduard Zingerman <eddyz87@gmail.com>?

>  tools/lib/bpf/relo_core.c | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/lib/bpf/relo_core.c b/tools/lib/bpf/relo_core.c
> index 7632e9d41827..2b83c98a1137 100644
> --- a/tools/lib/bpf/relo_core.c
> +++ b/tools/lib/bpf/relo_core.c
> @@ -683,7 +683,7 @@ static int bpf_core_calc_field_relo(const char *prog_=
name,
>  {
>  	const struct bpf_core_accessor *acc;
>  	const struct btf_type *t;
> -	__u32 byte_off, byte_sz, bit_off, bit_sz, field_type_id;
> +	__u32 byte_off, byte_sz, bit_off, bit_sz, field_type_id, elem_id;
>  	const struct btf_member *m;
>  	const struct btf_type *mt;
>  	bool bitfield;
> @@ -706,8 +706,14 @@ static int bpf_core_calc_field_relo(const char *prog=
_name,
>  	if (!acc->name) {
>  		if (relo->kind =3D=3D BPF_CORE_FIELD_BYTE_OFFSET) {
>  			*val =3D spec->bit_offset / 8;
> -			/* remember field size for load/store mem size */
> -			sz =3D btf__resolve_size(spec->btf, acc->type_id);
> +			/* remember field size for load/store mem size;
> +			 * note, for arrays we care about individual element
> +			 * sizes, not the overall array size
> +			 */
> +			t =3D skip_mods_and_typedefs(spec->btf, acc->type_id, &elem_id);
> +			while (btf_is_array(t))
> +				t =3D skip_mods_and_typedefs(spec->btf, btf_array(t)->type, &elem_id=
);
> +			sz =3D btf__resolve_size(spec->btf, elem_id);

Nit: while trying to figure out what this change is about
     I commented out the above hunk and this did not trigger any test failu=
res.

[...]



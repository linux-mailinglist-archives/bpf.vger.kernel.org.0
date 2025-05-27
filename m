Return-Path: <bpf+bounces-59028-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67642AC5D26
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 00:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E7D483A49E0
	for <lists+bpf@lfdr.de>; Tue, 27 May 2025 22:31:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D406A20D516;
	Tue, 27 May 2025 22:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JwvVy6Un"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C243423A6
	for <bpf@vger.kernel.org>; Tue, 27 May 2025 22:31:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748385086; cv=none; b=SxYyswAOL3zE2ffULUhJ1wEtbe0W/6uUfah2Fx76QNv6G0tGAtGQmUefhZ1/qpqGorvntaEsVjVtJ4fxL4VmE7TaNeOjyM6C2/oUmQhXH1K45VVOtkAkTSwDreNJkQOHgBe+JHmkASZqYCtycEHUTYmGtyb0eRZAG/iqpGCFZ5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748385086; c=relaxed/simple;
	bh=sAaTWJulXovJroVD20ZtS+6qyU07DcLAn2SKpVpenFQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Po4gB5WDgL88cnIHaCk+y7HAuvSjwBXeCZJDRwu7GzfCQfkBhmI5jvYTqRCeMguUrIzMT7gXU2JLJaS6lv5Sp+1//KvDddUE2HsReK2Gc5plRTe1vWvxoZ2K91JY0QmWMxAf1RUeQeX4paOA2D4DEsDBbaIcXWCzslqoy1B9qGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JwvVy6Un; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-b170c99aa49so2150641a12.1
        for <bpf@vger.kernel.org>; Tue, 27 May 2025 15:31:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748385084; x=1748989884; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1RyDjtM8r9zQm/d1mA5pJ1RwD9wg6ROCkfq/OpHxBVA=;
        b=JwvVy6UnxJD2NZFmEYWcz54yqrgmFP9Ye1tEa0zbqUj/3gFE4n5hqzDlULdYC3xg5w
         04WkdIlvI+ww6P9mY2SArKyr/3Fa5ko09btLW6J/9mypuXb647IcUx64837DP3+rp8qn
         I8hevmYCLBZS3xtXavkHxoQH8AmQ9KA49pAgAicLFnkVHaIezy7+GenaIrgU86gIGU0f
         O+2OIleeffnlZGr/tCf5muMwhXMKsMQV8boKA1Wjfxr0lSo3JznLlxFVlMBhwxLl4uG4
         leBeUP9s0dR1PeY1gvudVFxPNUPRu52Mznnf4alIUwoiUdbAxUbN2443HtwSRjwDPay7
         8vSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748385084; x=1748989884;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1RyDjtM8r9zQm/d1mA5pJ1RwD9wg6ROCkfq/OpHxBVA=;
        b=FicCNT+ue4J4KYXeC69OZjzTFI/bOM+wqzAgOP5lK9ocs9IQdmARS1u+Tfat3eUX12
         +yfx0zJo6jOPswEFdrmu7n8e0BTqpIhcevS9R+eFcG4gR8r+LBrZ1t7r2J9kVWR+Pjte
         asSYuX9zBrLOLmODifhYmCBi6tzSmqCvKALQ3ZwIupl9/H6cjRw/uJNCoM4UlB5R/e38
         1ui4xyEYReT7iGRDqSoFOpftAMlyNCA9/PK8ImDD0PM2LGFaADlJEKMGB9CayqY932Du
         SIfU+h3zyWs/pwXeoAmOrjQApeaSCqLVqCXbDVguj0NYGvZp1P9eXWew8RiNFNnEhk8F
         +u9w==
X-Gm-Message-State: AOJu0YzD12wU3JMWiNjoxZE6EY+c9NO15TUwm618ogP2krlGTLLZqoFy
	1P0RAzURW0Zf847wbAgqsen9/mWEqH295AHS71duF0+KmNvRaP4yBikyBYi38H6wfaMnRNrETi/
	3JrXwZYvzBWh4DsQvowDdlC3nSm33IM8=
X-Gm-Gg: ASbGncvCs+VOK2jCnVrN8aCrT3hiGQ7pL4j/N/82H9MXu+AKo51bVCvDAj5+GE2q8PZ
	NftUzhxnHjAlqeQkW2z61hXOx1saC6mMI9g02iev0pXnYjlhpnRa9qcjTcXpzTwdvB+Lmf+RBuA
	Pr6CPrxuwwjYbur+Eo3QfkslGsVtxVvaZOttWfI+mV7zer7pyA
X-Google-Smtp-Source: AGHT+IHb4RwusOKLMZ9Q0f+6RNRaUDg+DA0Z2NI6822uEru9qag1+x9Fa8xodjPSVhlq0OPAUvXeFiwLfifhjoGOO+I=
X-Received: by 2002:a17:90b:5282:b0:311:df4b:4b8c with SMTP id
 98e67ed59e1d1-311df4b4d23mr959481a91.7.1748385083910; Tue, 27 May 2025
 15:31:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250526162146.24429-1-leon.hwang@linux.dev> <20250526162146.24429-2-leon.hwang@linux.dev>
In-Reply-To: <20250526162146.24429-2-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 27 May 2025 15:31:09 -0700
X-Gm-Features: AX0GCFuU80gIfZ4AOlVXCBOL-wVdxOj6wusk-JK_cDNbnVZ8xMPRWQRzybKWb2I
Message-ID: <CAEf4BzZw_OgDWRzRsni5crcOs=9V3VT+c_Fz_gf2zCvx1wLzuA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 1/4] bpf: Introduce global percpu data
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, yonghong.song@linux.dev, song@kernel.org, 
	eddyz87@gmail.com, qmo@kernel.org, dxu@dxuuu.xyz, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 26, 2025 at 9:22=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> This patch introduces global percpu data, inspired by commit
> 6316f78306c1 ("Merge branch 'support-global-data'"). It enables the
> definition of global percpu variables in BPF, similar to the
> DEFINE_PER_CPU() macro in the kernel[0].
>
> For example, in BPF, it is able to define a global percpu variable like:
>
> int data SEC(".data..percpu");
>
> With this patch, tools like retsnoop[1] and bpfsnoop[2] can simplify thei=
r
> BPF code for handling LBRs. The code can be updated from
>
> static struct perf_branch_entry lbrs[1][MAX_LBR_ENTRIES] SEC(".data.lbrs"=
);
>
> to
>
> static struct perf_branch_entry lbrs[MAX_LBR_ENTRIES] SEC(".data..percpu.=
lbrs");
>
> This eliminates the need to retrieve the CPU ID using the
> bpf_get_smp_processor_id() helper.
>
> Additionally, by reusing global percpu data map, sharing information
> between tail callers and callees or freplace callers and callees becomes
> simpler compared to reusing percpu_array maps.
>
> Links:
> [0] https://github.com/torvalds/linux/blob/fbfd64d25c7af3b8695201ebc85efe=
90be28c5a3/include/linux/percpu-defs.h#L114
> [1] https://github.com/anakryiko/retsnoop
> [2] https://github.com/bpfsnoop/bpfsnoop
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  kernel/bpf/arraymap.c | 41 +++++++++++++++++++++++++++++++++++++--
>  kernel/bpf/verifier.c | 45 +++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 84 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
> index eb28c0f219ee4..91d06f0165a6e 100644
> --- a/kernel/bpf/arraymap.c
> +++ b/kernel/bpf/arraymap.c
> @@ -249,6 +249,40 @@ static void *percpu_array_map_lookup_elem(struct bpf=
_map *map, void *key)
>         return this_cpu_ptr(array->pptrs[index & array->index_mask]);
>  }
>
> +static int percpu_array_map_direct_value_addr(const struct bpf_map *map,
> +                                             u64 *imm, u32 off)
> +{
> +       struct bpf_array *array =3D container_of(map, struct bpf_array, m=
ap);
> +
> +       if (map->max_entries !=3D 1)
> +               return -EOPNOTSUPP;
> +       if (off >=3D map->value_size)
> +               return -EINVAL;
> +       if (!bpf_jit_supports_percpu_insn())
> +               return -EOPNOTSUPP;
> +
> +       *imm =3D (u64) array->pptrs[0];
> +       return 0;
> +}
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
> +
>  /* emit BPF instructions equivalent to C code of percpu_array_map_lookup=
_elem() */
>  static int percpu_array_map_gen_lookup(struct bpf_map *map, struct bpf_i=
nsn *insn_buf)
>  {
> @@ -532,9 +566,10 @@ static int array_map_check_btf(const struct bpf_map =
*map,
>  {
>         u32 int_data;
>
> -       /* One exception for keyless BTF: .bss/.data/.rodata map */
> +       /* One exception for keyless BTF: .bss/.data/.rodata/.data..percp=
u map */
>         if (btf_type_is_void(key_type)) {
> -               if (map->map_type !=3D BPF_MAP_TYPE_ARRAY ||
> +               if ((map->map_type !=3D BPF_MAP_TYPE_ARRAY &&
> +                    map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY) ||
>                     map->max_entries !=3D 1)
>                         return -EINVAL;
>
> @@ -815,6 +850,8 @@ const struct bpf_map_ops percpu_array_map_ops =3D {
>         .map_get_next_key =3D array_map_get_next_key,
>         .map_lookup_elem =3D percpu_array_map_lookup_elem,
>         .map_gen_lookup =3D percpu_array_map_gen_lookup,
> +       .map_direct_value_addr =3D percpu_array_map_direct_value_addr,
> +       .map_direct_value_meta =3D percpu_array_map_direct_value_meta,
>         .map_update_elem =3D array_map_update_elem,
>         .map_delete_elem =3D array_map_delete_elem,
>         .map_lookup_percpu_elem =3D percpu_array_map_lookup_percpu_elem,
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d5807d2efc922..9203354208732 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -6939,6 +6939,8 @@ static int bpf_map_direct_read(struct bpf_map *map,=
 int off, int size, u64 *val,
>         u64 addr;
>         int err;
>
> +       if (map->map_type !=3D BPF_MAP_TYPE_ARRAY)
> +               return -EINVAL;
>         err =3D map->ops->map_direct_value_addr(map, &addr, off);
>         if (err)
>                 return err;
> @@ -7451,6 +7453,7 @@ static int check_mem_access(struct bpf_verifier_env=
 *env, int insn_idx, u32 regn
>                         /* if map is read-only, track its contents as sca=
lars */
>                         if (tnum_is_const(reg->var_off) &&
>                             bpf_map_is_rdonly(map) &&
> +                           map->map_type =3D=3D BPF_MAP_TYPE_ARRAY &&
>                             map->ops->map_direct_value_addr) {
>                                 int map_off =3D off + reg->var_off.value;
>                                 u64 val =3D 0;
> @@ -9414,6 +9417,11 @@ static int check_reg_const_str(struct bpf_verifier=
_env *env,
>                 return -EACCES;
>         }
>
> +       if (map->map_type !=3D BPF_MAP_TYPE_ARRAY) {
> +               verbose(env, "only array map supports direct string value=
 access\n");
> +               return -EINVAL;
> +       }
> +
>         err =3D check_map_access(env, regno, reg->off,
>                                map->value_size - reg->off, false,
>                                ACCESS_HELPER);
> @@ -11101,6 +11109,11 @@ static int check_bpf_snprintf_call(struct bpf_ve=
rifier_env *env,
>                 return -EINVAL;
>         num_args =3D data_len_reg->var_off.value / 8;
>
> +       if (fmt_map->map_type !=3D BPF_MAP_TYPE_ARRAY) {
> +               verbose(env, "only array map supports snprintf\n");
> +               return -EINVAL;
> +       }
> +
>         /* fmt being ARG_PTR_TO_CONST_STR guarantees that var_off is cons=
t
>          * and map_direct_value_addr is set.
>          */
> @@ -21906,6 +21919,38 @@ static int do_misc_fixups(struct bpf_verifier_en=
v *env)
>                         goto next_insn;
>                 }
>
> +#ifdef CONFIG_SMP

Instead of CONFIG_SMP, I think it's more appropriate to check for
bpf_jit_supports_percpu_insn(). We check CONFIG_SMP for
BPF_FUNC_get_smp_processor_id inlining because of `cpu_number` per-CPU
variable, not because BPF_MOV64_PERCPU_REG() doesn't work on single
CPU systems (IIUC).

pw-bot: cr


> +               if (insn->code =3D=3D (BPF_LD | BPF_IMM | BPF_DW) &&
> +                   (insn->src_reg =3D=3D BPF_PSEUDO_MAP_VALUE ||
> +                    insn->src_reg =3D=3D BPF_PSEUDO_MAP_IDX_VALUE)) {
> +                       struct bpf_map *map;
> +
> +                       aux =3D &env->insn_aux_data[i + delta];
> +                       map =3D env->used_maps[aux->map_index];
> +                       if (map->map_type !=3D BPF_MAP_TYPE_PERCPU_ARRAY)
> +                               goto next_insn;
> +
> +                       /* Reuse the original ld_imm64 insn. And add one
> +                        * mov64_percpu_reg insn.
> +                        */
> +
> +                       insn_buf[0] =3D insn[1];
> +                       insn_buf[1] =3D BPF_MOV64_PERCPU_REG(insn->dst_re=
g, insn->dst_reg);
> +                       cnt =3D 2;
> +
> +                       i++;
> +                       new_prog =3D bpf_patch_insn_data(env, i + delta, =
insn_buf, cnt);
> +                       if (!new_prog)
> +                               return -ENOMEM;
> +
> +                       delta    +=3D cnt - 1;
> +                       env->prog =3D prog =3D new_prog;
> +                       insn      =3D new_prog->insnsi + i + delta;
> +
> +                       goto next_insn;
> +               }
> +#endif
> +
>                 if (insn->code !=3D (BPF_JMP | BPF_CALL))
>                         goto next_insn;
>                 if (insn->src_reg =3D=3D BPF_PSEUDO_CALL)
> --
> 2.49.0
>


Return-Path: <bpf+bounces-78784-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D5DAD1BCDD
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 01:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DFC13007643
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 00:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D621F4180;
	Wed, 14 Jan 2026 00:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kvwIMoHF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81531DC198
	for <bpf@vger.kernel.org>; Wed, 14 Jan 2026 00:29:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350588; cv=none; b=b1VZ0fqXHkXUVbb3aKK1A+itQrdulpduxQ6Q5r0yADPIB2i+T7W9SWfRjzi0bjnq7uOX1rlsUxsbqAUPb5mwai76Sxp57K5HVTs1XKbzlCMha8OgLeHzC1jqskUmwkQ4VXikAHeB9/aK3AjUtDZpt8VPaJ1yxpcMbbT5Bvnmk3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350588; c=relaxed/simple;
	bh=ofL14vl8TmDe+DNnpy+n8sy4WO7fuJZ/HKmQQIidzn0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sr7COXxWI0fJdoOhfz2B7sVlVzWznqEFVrq84zY9oGhqK+FwuAUgwIwCwJf+jVJOZ2eqynOSs6kZ8g1WkMtiQfIwtOOxxTW2NYQ0pTRYt1hkRAi3w6RTqzR//BxP9kmI95cF6ILQSNJtID7A85DqHDXcvemC9V7AHaO9AnA61sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kvwIMoHF; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a137692691so53263835ad.0
        for <bpf@vger.kernel.org>; Tue, 13 Jan 2026 16:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768350586; x=1768955386; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/Aivjs+fEafdtC+uKUtkyzhv+JbYFAhhPrP8Rdocn9s=;
        b=kvwIMoHFmdDBgEgd3vWXRQFRVOj0ECrk+ZZoC3MCxBgt0kERCyneKMepH+uSPl1GRP
         SipYvRVBoYAhBSrDj5Cv/Ofa5y/hKZDETX4Sdfv+OwLOeCmpV3TnXxrq5gnkVm8hJhFB
         L+4QQ+leWtw5tQLhvgIWjCOgDpIC4neUreM2eYorEnvloPt6uDHZSemrld1qnPEnNrzd
         BEI2GPh0fsR4iJxcQLxJaF6M9xUVFMbTnbb8GphPB1zPqEdTNjTAH6HWij+dTJjgL8xQ
         fIDNu0Y8PEwot1tn5SEDCA/ctoOjdfOz1JkhqTsOs71nykFLcTpscUMznqRHwCnTDR7n
         i+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768350586; x=1768955386;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/Aivjs+fEafdtC+uKUtkyzhv+JbYFAhhPrP8Rdocn9s=;
        b=m/ciOVHasGd59wm26h1t1CWvfa03Axb4JI7gzcSVMEJXk0MiJD1Ay1CK59Y+BHT8sj
         4T74fWShfD1hiHpaL4IfMsEwewiBApZ0mMbBQz4QyU1QoO/q/N21dytY1oqLX2dtH4RJ
         frNkpdJkZzRxK30bgsum/ZW29glyPTnP0y+13JJnuUm+3z70WJuTI9l+K1Y7tNDADp/s
         RWYad5tSppspnM8Ckw/KREag/dU2VdIr7IwOxrHMjrqVCTB0BXDrD+m5qYeOqpM61k+B
         13rh3/3v+cqSYZ+/YdydW7XBrJ6a/aeX+/ne/PjfEJbEciIAuL9Z9KzF3eonaqMfnvId
         vfrQ==
X-Forwarded-Encrypted: i=1; AJvYcCUW6s2KAOvCq/toQIKaEvNZIQ1LjxUgqWAaf+Mpr98UDDSqKshPxo5V71D+Fxld3LPRTX8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqHWhvDAU9g3+LXWlQ9OCjmKGY8r500UyFB/2kvkV0rPGBedla
	J2PAOI/5R/v26sTdU8Zu945OLAET9n6etvScClt6NTuTN0txFhClZou1ElDWdLB1yAdlIfBAFwp
	RA60sv5OQhelJFjMdeaAvMw8nJ6xs8u6gHA==
X-Gm-Gg: AY/fxX5EUPa3PyIMl6c0+T6uW8tmCoAu7JTwnUT7L5boujM5GsQGGQYWLOi38/Rju/1
	eDmH7Aqffm1sjY8L0QFjSFN7tATPIRNwT6ZoIgr94pyJ5KEyHd8IvVueWphYOzHKxC72YbdFmrB
	prF0xjASKJ+bvOd2trRkmQAgIlArR2KEz+9tq2glYgBiFtckTywG6jVAl+/ylDwxLzWa2L1Ei7E
	AVLj3Fj6lgPD8IWwpwGvKBRtVK3O+yQBLq0Lmt/w90zEFNDXAMOEfyR6N0nK2fYXdQ3rpow7DTS
	Xbe31xorOtQ=
X-Received: by 2002:a17:90b:2542:b0:340:5c27:a096 with SMTP id
 98e67ed59e1d1-3510b08e916mr225181a91.6.1768350586002; Tue, 13 Jan 2026
 16:29:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260109130003.3313716-1-dolinux.peng@gmail.com> <20260109130003.3313716-4-dolinux.peng@gmail.com>
In-Reply-To: <20260109130003.3313716-4-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 13 Jan 2026 16:29:32 -0800
X-Gm-Features: AZwV_QjkgwRz1s-OgvGYqv1G9qZNd8TYTn-exO5goMKMWA7oJzgVPHUR4BolNiQ
Message-ID: <CAEf4BzZZ3xaCURCUJsUDH=_eLj31XKeXy34x-jczyM862Cw=TQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v12 03/11] tools/resolve_btfids: Support BTF
 sorting feature
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	Donglin Peng <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 9, 2026 at 5:00=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: Donglin Peng <pengdonglin@xiaomi.com>
>
> This introduces a new BTF sorting phase that specifically sorts
> BTF types by name in ascending order, so that the binary search
> can be used to look up types.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 64 +++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index df39982f51df..343d08050116 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -850,6 +850,67 @@ static int dump_raw_btf(struct btf *btf, const char =
*out_path)
>         return 0;
>  }
>
> +/*
> + * Sort types by name in ascending order resulting in all
> + * anonymous types being placed before named types.
> + */
> +static int cmp_type_names(const void *a, const void *b, void *priv)
> +{
> +       struct btf *btf =3D (struct btf *)priv;
> +       const struct btf_type *ta =3D btf__type_by_id(btf, *(__u32 *)a);
> +       const struct btf_type *tb =3D btf__type_by_id(btf, *(__u32 *)b);
> +       const char *na, *nb;
> +
> +       na =3D btf__str_by_offset(btf, ta->name_off);
> +       nb =3D btf__str_by_offset(btf, tb->name_off);
> +       return strcmp(na, nb);

let's disambiguate the case when strcmp() =3D=3D 0:

int r =3D strcmp(na, nb);
if (r !=3D 0)
    return r;

/* preserve original relative order of anonymous or same-named types */
return *(__u32 *)a < *(__u32 *)b ? -1 : 1;

(please send as a follow up)


> +}
> +
> +static int sort_btf_by_name(struct btf *btf)
> +{
> +       __u32 *permute_ids =3D NULL, *id_map =3D NULL;
> +       int nr_types, i, err =3D 0;
> +       __u32 start_id =3D 0, start_offs =3D 1, id;
> +
> +       if (btf__base_btf(btf)) {
> +               start_id =3D btf__type_cnt(btf__base_btf(btf));
> +               start_offs =3D 0;

with the above cmp_type_names disambiguation sorting becomes stable,
so you won't need this start_offs thing here, you can safely compare
VOID with any other type and it will stay the very first one

(please include in the follow up as well)



> +       }
> +       nr_types =3D btf__type_cnt(btf) - start_id;
> +
> +       permute_ids =3D calloc(nr_types, sizeof(*permute_ids));
> +       if (!permute_ids) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       id_map =3D calloc(nr_types, sizeof(*id_map));
> +       if (!id_map) {
> +               err =3D -ENOMEM;
> +               goto out;
> +       }
> +
> +       for (i =3D 0, id =3D start_id; i < nr_types; i++, id++)
> +               permute_ids[i] =3D id;
> +
> +       qsort_r(permute_ids + start_offs, nr_types - start_offs,
> +               sizeof(*permute_ids), cmp_type_names, btf);
> +
> +       for (i =3D 0; i < nr_types; i++) {
> +               id =3D permute_ids[i] - start_id;
> +               id_map[id] =3D i + start_id;
> +       }
> +
> +       err =3D btf__permute(btf, id_map, nr_types, NULL);
> +       if (err)
> +               pr_err("FAILED: btf permute: %s\n", strerror(-err));
> +
> +out:
> +       free(permute_ids);
> +       free(id_map);
> +       return err;
> +}
> +
>  static inline int make_out_path(char *buf, u32 buf_sz, const char *in_pa=
th, const char *suffix)
>  {
>         int len =3D snprintf(buf, buf_sz, "%s%s", in_path, suffix);
> @@ -1025,6 +1086,9 @@ int main(int argc, const char **argv)
>         if (load_btf(&obj))
>                 goto out;
>
> +       if (sort_btf_by_name(obj.btf))
> +               goto out;
> +
>         if (elf_collect(&obj))
>                 goto out;
>
> --
> 2.34.1
>


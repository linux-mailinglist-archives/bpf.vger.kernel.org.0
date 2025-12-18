Return-Path: <bpf+bounces-77060-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB67CCDE72
	for <lists+bpf@lfdr.de>; Fri, 19 Dec 2025 00:09:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 025BB300DEAC
	for <lists+bpf@lfdr.de>; Thu, 18 Dec 2025 23:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399A730F947;
	Thu, 18 Dec 2025 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e65BvOCV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403E72F12D9
	for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 23:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766099389; cv=none; b=hfsbvovQWB+N4XuLSSyyprWpKwVwlSDPEJEP/co4ipNSlYJ1bvxkPHGC5a8rjHS7LYU2wnB2s81fLv/SH7CvsahMG+mDakfXaFzKXQbqaEHq1KLY+b5PeeFPA3lrymxfCsu2s/2lNbJsX1CQxYhtS9SlXv0JxkD9wxOfLoiY72Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766099389; c=relaxed/simple;
	bh=OsRPmsimr/QvpB4N3O83XBlB/H45pLzietrG4ce8x+I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FDcuss3/O4EWRUpQJzAIQJApwzM0jIMYWP9hvu4RZImRbz7kksRY0sE82YlxUU6hgqomgnjzg82arTFfPLYXgcIhz8fsk7io6zjHhIUHwzqv6w7Q4XFQj8Yz1cjCicgZUjv6Ri6ZC17qt5SNhd8KYkf5aqZe1RwI2ampy9LNNWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e65BvOCV; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so1092936a91.3
        for <bpf@vger.kernel.org>; Thu, 18 Dec 2025 15:09:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766099387; x=1766704187; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=axK+I1yAr77RWHJ66Npeye9Futw7RFb89JcOsyYqL8E=;
        b=e65BvOCVGKjLho94MGB/yuw3ADbkd9Z8BsSpX+EjfYi7kLrnEnZps2oBHzr8TrjBew
         HRqmMIGhbIDT1RfGaPCgjYiY//FCVDPVU66ZugN1Ubg6JKw84rhDeIalmp9AwDdWEBvo
         r2hjyLu61xWryEu0h1x2/uBkilZiTaxKhqv2zMcSrKgxnN4yN8TjJvi7gk6Ma3XnYbPp
         msHRJIJUyy262hUplFH25oG4oW4Hyv7A3Hfsc7EoNPtbRDfOK1mDESzUQVxxHq5ZmDsr
         cDqeb+12yUS0Cv/RrKYvak9bkqUFeKRib3RmGQR3KCk+j9G+mOL3X98jZ9vYBb7vRhep
         uFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766099387; x=1766704187;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=axK+I1yAr77RWHJ66Npeye9Futw7RFb89JcOsyYqL8E=;
        b=Q7//YCMWQTrKAsBqOQcdRY8YvFRYs3mRtg6ogMmb5rus18nKO0iDbVP51jCnWAM9lK
         FO4wlxft1Cf1D40EMmhhPM9Z6Yb1ZbhvNRqYU71CUOk123t+C6gQBm5+xYQPwNEZs9qA
         mp4kmc9SRePdlDZNb93+yzDXELW1IVvQiijv4L+ZnYY2wsAZB4Fd8EiVWcVOwnks5qEa
         cXQmd6qLGK67fjxe0wvn+YhtBeL2h+Cw1yBOFd9ElxT7xwEheA2bB1kHUOCh8hYsr2xi
         CuQCN5PlucnDpakQdfteCr5fjfZCqB8ZG1iLlueB5zb8e8xPmFnNCAkPM1TEnvYV2Afr
         kqYA==
X-Forwarded-Encrypted: i=1; AJvYcCWnSL4BTCgQknwj/WnExfRNLUKH2J6Phd4U1/3B3NfJNO+66VGZuYBmwXXh2DWNd5RTGCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxhuv6gY3p4m/hXIhIqIBT7XUqyO5Y1vq4lVXwvj2hRjnYNDC6+
	eWVXLyOzgt1zcpCS2ENIBAReO3Iqd4j0HjGbkwJkhEItbJQUzmKnAMyBRFAdjL7yfi9bM88pplc
	htpqzmbQ/ZgirbaoxbLQmMYtw/hiqLLs=
X-Gm-Gg: AY/fxX7+RHHX3qcE/OARcWGFOltUjtySsdtMPBpBaxKfCDakdT5fFM6+r5lrlvtyTCl
	UxEaelLbCcx3f+j95KQSPBoa9f5/x/4PbZN+flBGILDEhD5AXZY16LsfTL150lLzYZv5WaQv0S+
	eiAiN0EPmX8yjydbbbQz5i+IbW565Zx/AYkylXlqOj2juloD2FLFi85vGGBK3VTZ1HmJAiaOvEP
	bqWdSQenplJHuuOAS6yIDQp4uJQ8GUOoxVMdiK9pGyqUoB8lE5k/DuIh2CAa4X/Ph04tYxejfWq
	q7lCye8BB1VXffHuO4TUXw==
X-Google-Smtp-Source: AGHT+IGjy/abo27KIesk2Umf+RQnxVHJSk2JSk6JD6AOpDuBaJxVb7hbvQnkVyaTA1LyenYU5K8W/GcxtxsVYTHd3Ks=
X-Received: by 2002:a17:90b:548c:b0:343:60ab:ca8e with SMTP id
 98e67ed59e1d1-34e921bec08mr808355a91.17.1766099387567; Thu, 18 Dec 2025
 15:09:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218113051.455293-1-dolinux.peng@gmail.com> <20251218113051.455293-4-dolinux.peng@gmail.com>
In-Reply-To: <20251218113051.455293-4-dolinux.peng@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 18 Dec 2025 15:09:35 -0800
X-Gm-Features: AQt7F2qAuXb9PC7g5LdTiWLPPI6_XqGNLdZ9Prmee0zTOaZJRjqWrjUPbYgMxig
Message-ID: <CAEf4Bzb0HEFsJ7KG6upatR792baKTKFV6n+91dHdXNL174ud5Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 03/13] tools/resolve_btfids: Support BTF
 sorting feature
To: Donglin Peng <dolinux.peng@gmail.com>
Cc: ast@kernel.org, eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, 
	ihor.solodrai@linux.dev, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 18, 2025 at 3:31=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.co=
m> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
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
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>

Signed-off-by is supposed to use properly spelled full name, this
should be "Donglin Peng", right?

> Acked-by: Eduard Zingerman <eddyz87@gmail.com>
> ---
>  tools/bpf/resolve_btfids/main.c | 68 +++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/m=
ain.c
> index 3e88dc862d87..659de35748ec 100644
> --- a/tools/bpf/resolve_btfids/main.c
> +++ b/tools/bpf/resolve_btfids/main.c
> @@ -848,6 +848,71 @@ static int dump_raw_btf(struct btf *btf, const char =
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
> +}
> +
> +static int sort_btf_by_name(struct btf *btf)
> +{
> +       __u32 *permute_ids =3D NULL, *id_map =3D NULL;
> +       int nr_types, i, err =3D 0;
> +       __u32 start_id =3D 1, id;
> +
> +       if (btf__base_btf(btf))
> +               start_id =3D btf__type_cnt(btf__base_btf(btf));
> +       nr_types =3D btf__type_cnt(btf) - start_id;
> +       if (nr_types < 2)
> +               goto out;

why this check, will anything break if you don't do it?

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
> +       qsort_r(permute_ids, nr_types, sizeof(*permute_ids), cmp_type_nam=
es, btf);
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
> +static int btf2btf(struct object *obj)

what's the point of having this function?

> +{
> +       return sort_btf_by_name(obj->btf);
> +}
> +
>  static inline int make_out_path(char *buf, u32 buf_sz, const char *in_pa=
th, const char *suffix)
>  {
>         int len =3D snprintf(buf, buf_sz, "%s%s", in_path, suffix);
> @@ -906,6 +971,9 @@ int main(int argc, const char **argv)
>         if (load_btf(&obj))
>                 goto out;
>
> +       if (btf2btf(&obj))
> +               goto out;
> +
>         if (elf_collect(&obj))
>                 goto out;
>
> --
> 2.34.1
>


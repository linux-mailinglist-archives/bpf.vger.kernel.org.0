Return-Path: <bpf+bounces-76335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F85CAECD2
	for <lists+bpf@lfdr.de>; Tue, 09 Dec 2025 04:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A11D43046EF4
	for <lists+bpf@lfdr.de>; Tue,  9 Dec 2025 03:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B10D301002;
	Tue,  9 Dec 2025 03:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LJPAUHC2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1459224220
	for <bpf@vger.kernel.org>; Tue,  9 Dec 2025 03:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765250529; cv=none; b=JFa8LL2/HGFNRkfI7NNcDxLg+nc5m9mEyEhazU9AAVu02Vtz5tG1pJrNlBCLtAX2X03Rnoeia5jq5Dcb6pnytq56VCTa4DsbgguMHemkeCiZ6kZZzWQBqc2WKtA2OYQSZIBRmPLQgcURT2R5aenOTsmvQcFlRld0TJ0v3PZSnZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765250529; c=relaxed/simple;
	bh=oXPAKxijwrMglJlfT7dQUS/OTdofkEoqdaFdI/Dx99Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=epMDcICEQPiLhjI4zhbsCYn4K/vyEI9QNI7xlrMu141Gb4at4OaQwv2QOZNVwwzFSWtHD9AdbgWSUd3jEQqrcSYYp04tsNaFLgzihgdoPU2bLoS9+D/j4qqougQdYyxwqAh1ZLyxHdLUmjz3MiLC3PiRMelo2D31+5PxytGMifQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LJPAUHC2; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b7633027cb2so810500566b.1
        for <bpf@vger.kernel.org>; Mon, 08 Dec 2025 19:22:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765250526; x=1765855326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X0tNjzv+TFsYJHxpCcjHL5oUzLdU8NHjEcL9uKX7KG0=;
        b=LJPAUHC25eWL8figzlSEnrvRmg7jKisYXUj2TCqPvL6UeuKmDJdS5xWjj68ZN0vbz2
         ZX4W8Y4vjyAVv/yYVmRTiqC+GM+qCMhFqzcPiU/FpogK3RTmGlMdYvABPx3ePCUvrNjy
         vkMjf3idkaeShkXfOcD2fWlUMite7gdbXJ/2BaFCDLwLheuU0svk4SrfB35o+rOBbwRS
         5W5MIfHZ/uwzEuDIuycnZ6ZS32w/lS1eK2FEJ2MLF+HSEgVuvoC7xu0tx1eWWbLhdxb9
         PnFgOGG0/FlHkiqkYhV7KnvxmxYAsfKipFo2mLaCVmkt5CWqNRkvZN1m8xhVJoCvFjhv
         JQ2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765250526; x=1765855326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=X0tNjzv+TFsYJHxpCcjHL5oUzLdU8NHjEcL9uKX7KG0=;
        b=cKqPG4KP+hRnpEB5pnzPBiHH1M05PqqGQLMqSaiFmKaFvBVf3UYbniDQ1TQioL7dWM
         c5Jf4VvyIy4snjLaGdS8satMkJDgflEp6M+oEPKkop/RgzT2vNU5edB3HIlGg+p9zJ/d
         ARXwNGOWRhiuzI9CdC49C5n5TnWvSCdyIvUH5Za5kja866lqxpGUE37BCOwl81HxRKvE
         0itJepocXK9/NefvNPVZs0RRrDfgQmTAh4FD3/p13afQKEttrdXvavw9jB5R0EyXHTDo
         aFQNKlIZ9v306Y91YK37oKFkrqx2riQvpk/0l9OnpLKH5msBXE40urEtrB69mBuSJ/SA
         CttA==
X-Forwarded-Encrypted: i=1; AJvYcCXdkqLw2Y8W7Nxeb8Ahfa8d2gw+JtM4DW3hN/g5MCS3dHF6NFu/DOR3zexrfgNqGnfkZTw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw11wwAp8zljO/ozhvl25/e9nDPZ9bxm78vr+f3F9EUHe16AsLw
	DwAH9bUXxiv2oPaUNzAz/ttZzzE99IOFXXNVowd0P+yJdCUcx7joZpG6F+TTCZ9LbeRgQtarY1o
	ALcItRm8q8yxKwMM1JhJRa8q5iUdxmIc=
X-Gm-Gg: ASbGnct9enEZ5SEQwyi5B6ISeaDr9p05lZltN0Nrl75a6UgXkoz/I14+nPT1BK/OkWN
	et6T2rILgv0tpawf3Au3FTGmX5VOQbt3fuaY0sPkTo4NHRMZaFqtSlmD5usISuVB+vqeiQVuE44
	W7BBiKYI9yNV0IH8zAwjbE3QhxA8YHqu6hNUqCoBQn393KoRQkKxQJipYSiF1SJPeFo6gp8/IUp
	PczxW3F7ZBorAZTUyJzqWO81Wi1CiyEP7HavpHAn7X2rOv/5pRGhrSAON+qvkk7lMZfo5/H
X-Google-Smtp-Source: AGHT+IEq0KtY2zfAnw+D62ESt65wuc+Wj2zcjwZFj6jg+eoeiY8iSrAPQydrQPUIT2SM/TooifXbYGp0cSWDzucrYqU=
X-Received: by 2002:a17:907:dac:b0:b79:f965:1cd4 with SMTP id
 a640c23a62f3a-b7a247f95d6mr1010868466b.55.1765250526180; Mon, 08 Dec 2025
 19:22:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208062353.1702672-1-dolinux.peng@gmail.com> <20251208062353.1702672-8-dolinux.peng@gmail.com>
In-Reply-To: <20251208062353.1702672-8-dolinux.peng@gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Tue, 9 Dec 2025 11:21:54 +0800
X-Gm-Features: AQt7F2qRhSdpisoWCShkOFbLtNB7maBEpqbYBX4M9i6lYvA_hCGlNHE2mJU81-E
Message-ID: <CAErzpms9K8h=76K9=SK_BmhR4hYetrztFpuQ8h8Q4HSZPguUng@mail.gmail.com>
Subject: Re: [PATCH bpf-next v9 07/10] btf: Verify BTF Sorting
To: ast@kernel.org, andrii.nakryiko@gmail.com
Cc: eddyz87@gmail.com, zhangxiaoqin@xiaomi.com, ihor.solodrai@linux.dev, 
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	pengdonglin <pengdonglin@xiaomi.com>, Alan Maguire <alan.maguire@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 8, 2025 at 2:24=E2=80=AFPM Donglin Peng <dolinux.peng@gmail.com=
> wrote:
>
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> This patch checks whether the BTF is sorted by name in ascending order.
> If sorted, binary search will be used when looking up types.
>
> Specifically, vmlinux and kernel module BTFs are always sorted during
> the build phase with anonymous types placed before named types, so we
> only need to identify the starting ID of named types.
>
> Cc: Eduard Zingerman <eddyz87@gmail.com>
> Cc: Alexei Starovoitov <ast@kernel.org>
> Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
> Cc: Alan Maguire <alan.maguire@oracle.com>
> Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
> Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>
> ---
>  kernel/bpf/btf.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 58 insertions(+)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 842f9c0200e4..925cb524f3a8 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -550,6 +550,60 @@ u32 btf_nr_types(const struct btf *btf)
>         return total;
>  }
>
> +/*
> + * Assuming that types are sorted by name in ascending order.
> + */
> +static int btf_compare_type_names(const void *a, const void *b, void *pr=
iv)
> +{
> +       struct btf *btf =3D (struct btf *)priv;
> +       const struct btf_type *ta =3D btf_type_by_id(btf, *(__u32 *)a);
> +       const struct btf_type *tb =3D btf_type_by_id(btf, *(__u32 *)b);
> +       const char *na, *nb;
> +
> +       na =3D btf_name_by_offset(btf, ta->name_off);
> +       nb =3D btf_name_by_offset(btf, tb->name_off);
> +       return strcmp(na, nb);
> +}
> +
> +/* Note that vmlinux and kernel module BTFs are always sorted
> + * during the building phase.
> + */
> +static void btf_check_sorted(struct btf *btf)
> +{
> +       const struct btf_type *t;
> +       bool skip_cmp =3D btf_is_kernel(btf);
> +       u32 sorted_start_id =3D 0;
> +       int i, n, k =3D 0;
> +
> +       if (btf->nr_types < 2)
> +               return;
> +
> +       n =3D btf_nr_types(btf) - 1;
> +       for (i =3D btf_start_id(btf); i < n; i++) {
> +               k =3D i + 1;
> +               if (!skip_cmp &&
> +                       btf_compare_type_names(&i, &k, btf) > 0)
> +                       return;
> +
> +               if (sorted_start_id =3D=3D 0) {
> +                       t =3D btf_type_by_id(btf, i);
> +                       if (t->name_off) {
> +                               sorted_start_id =3D i;
> +                               if (skip_cmp)
> +                                       break;
> +                       }
> +               }
> +       }
> +
> +       if (sorted_start_id =3D=3D 0) {
> +               t =3D btf_type_by_id(btf, k);
> +               if (t->name_off)
> +                       sorted_start_id =3D k;
> +       }
> +       if (sorted_start_id)
> +               btf->sorted_start_id =3D sorted_start_id;
> +}
> +
>  static s32 btf_find_by_name_bsearch(const struct btf *btf, const char *n=
ame,
>                                     s32 start_id, s32 end_id)
>  {
> @@ -5889,6 +5943,8 @@ static struct btf *btf_parse(const union bpf_attr *=
attr, bpfptr_t uattr, u32 uat
>         if (err)
>                 goto errout;
>
> +       btf_check_sorted(btf);

I think there is no need to check sorting here, because the BTF in this
code path is generated by the compiler. We only need to cover the cases
of vmlinux and kernel module BTF.

> +
>         struct_meta_tab =3D btf_parse_struct_metas(&env->log, btf);
>         if (IS_ERR(struct_meta_tab)) {
>                 err =3D PTR_ERR(struct_meta_tab);
> @@ -6296,6 +6352,7 @@ static struct btf *btf_parse_base(struct btf_verifi=
er_env *env, const char *name
>         if (err)
>                 goto errout;
>
> +       btf_check_sorted(btf);
>         refcount_set(&btf->refcnt, 1);
>
>         return btf;
> @@ -6430,6 +6487,7 @@ static struct btf *btf_parse_module(const char *mod=
ule_name, const void *data,
>         }
>
>         btf_verifier_env_free(env);
> +       btf_check_sorted(btf);
>         refcount_set(&btf->refcnt, 1);
>         return btf;
>
> --
> 2.34.1
>


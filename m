Return-Path: <bpf+bounces-28215-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0B78B6699
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 01:43:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E4891C22628
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:43:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FE31BF6CC;
	Mon, 29 Apr 2024 23:40:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L9XIij98"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 513F51A38FF
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 23:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714434047; cv=none; b=YtG5QLfFjKCMEmP17pYDtlplUCVXdo6vyfamGUJAbyvVInYiZgmg41KuJSIOOGVCEzaAx68qIc5+dC786Ju1b3qsTnVitn0Vf2mCUb6jkQiu/AXn5hAhbEzS4B5hcHD4Lg4VyJ5S3M4FG/GKSj/eNfc4dTmAKfAiW4MSQoBrrP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714434047; c=relaxed/simple;
	bh=3xZ065ks36vW7fBrT4FsYSajkq2fZhszUnbEhf8Eyr4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dtv3EGUjt5cez9pJZ5Sr8HZhtjlPlkzlbK3YGK5c+M21MuvyIPAyBYhlkLnHIjFRpZXUID+Z8c/mmfmwGCGzDYJPHkUoyAqxcMAoFRrXXDQyyGS6cm3trekjLQP0uuAeeLvyyVxs/zMXzI3j4xOYscYwYXSXmQnepRU/SbX1nNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L9XIij98; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2b12b52fbe0so1462359a91.0
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 16:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714434044; x=1715038844; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bifi55mI9WQDsyCbx46s3C4MpoyJI7KzPlhLbxStVl0=;
        b=L9XIij98sTQKvyLDkvctBSLxg2HiStCCoo9Mn9kbftH6HRFcbA1p8VVsqHvgpGN7/6
         +7iNlPC86hOuttf0+23M+tN624EvMZG48PiaFMtZqEL3pJU4qVIkbDQvRoSkXrR3bUUL
         a2GrhbEZ+KlM3S2IQuJgp1iJAB/08ss/wGhdephRzf34YqF30vtq4UemKCAT+25QXJX2
         sS94atWvk0dro0YVQ7bHSTs/No4Fs8AofMZp+Q4GjY/iw1Om0NSaShP+LIQZCEYQmdjK
         1009Roj/g9tJbm3D7Kb0QpotBhjrCI5F8R/dO8AI1KVH80DoVWf/mO8FreSLYvGRSNRJ
         35kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714434044; x=1715038844;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bifi55mI9WQDsyCbx46s3C4MpoyJI7KzPlhLbxStVl0=;
        b=ZKE6zzsGB+862PNdLclvT4aIY7tJSr1tVauMLVLbIjVXx6GDE7TxZ8tSKqDcYEnv5P
         9LUrN9YRqncZebn4+OQTgcg6+wLdc7ihQKNYkSzKKuWN1VmKQkg1ZH1iW4ZrxhXhqc8e
         oyzXV769Q1tanaCzhAf9GtcNQn/88a/Imx5SIXa/H5qknHx7ww+TmJgMbElfhSzSRUbC
         Q+vjmbbCTIbYjvtEj1Ip2PbefEROQ5JnodnEHYkVIWdtghDtgEJ0NI6OJGhHqmtKPpX7
         H69OJUB8oXrNVknIGiy+32d5GNAVrk4oyGG2ueADHPU4OiPuYmNkIsn2I5XxF90d78+L
         v1xQ==
X-Forwarded-Encrypted: i=1; AJvYcCUNISalhx5zhYMZn0PcU8Pwd8eG245kOyiaCdtT4qo1hid0sDZozPkTOFPB2FrhQ3UxRMKgylPZEj/j4iRzmN0PHFZX
X-Gm-Message-State: AOJu0Ywfe2NO9gvtU8/VmXuaL7jj8X+LQ50ig3Q4S9pX20AY6f+9747g
	Xs7D2NUMThGIudWsOZOJQ/C0bOJZWQ6J6WqbLfdGnQdHWmvQBSy06oR8KzfVAQbWV6rx7qew33h
	6rHNbB00SXQmIv8IT96DrfoiUP4E=
X-Google-Smtp-Source: AGHT+IFHTuMmxwhEDwHhJ77gcbpsPlg9XSlrmypN9+foME1DRuSY0q2AJItetdu7WhGMQtqbtigdaXVeN5eh4bGj46E=
X-Received: by 2002:a17:90b:b06:b0:2ac:23ec:6a54 with SMTP id
 bf6-20020a17090b0b0600b002ac23ec6a54mr12712460pjb.38.1714434044495; Mon, 29
 Apr 2024 16:40:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424154806.3417662-1-alan.maguire@oracle.com> <20240424154806.3417662-5-alan.maguire@oracle.com>
In-Reply-To: <20240424154806.3417662-5-alan.maguire@oracle.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 29 Apr 2024 16:40:32 -0700
Message-ID: <CAEf4Bzau4J3UHKzz2QJgZsSSqCx=BxkG=Zf+SZXm5ESgzpcrHw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 04/13] libbpf: add btf__parse_opts() API for
 flexible BTF parsing
To: Alan Maguire <alan.maguire@oracle.com>
Cc: andrii@kernel.org, ast@kernel.org, jolsa@kernel.org, acme@redhat.com, 
	quentin@isovalent.com, eddyz87@gmail.com, mykolal@fb.com, 
	daniel@iogearbox.net, martin.lau@linux.dev, song@kernel.org, 
	yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, houtao1@huawei.com, bpf@vger.kernel.org, 
	masahiroy@kernel.org, mcgrof@kernel.org, nathan@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 8:48=E2=80=AFAM Alan Maguire <alan.maguire@oracle.c=
om> wrote:
>
> Options cover existing parsing scenarios (ELF, raw, retrieving
> .BTF.ext) and also allow specification of the ELF section name
> containing BTF.  This will allow consumers to retrieve BTF from
> .BTF.base sections (BTF_BASE_ELF_SEC) also.
>
> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
> ---
>  tools/lib/bpf/btf.c      | 50 ++++++++++++++++++++++++++++------------
>  tools/lib/bpf/btf.h      | 32 +++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.map |  1 +
>  3 files changed, 68 insertions(+), 15 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 419cc4fa2e86..9036c1dc45d0 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1084,7 +1084,7 @@ struct btf *btf__new_split(const void *data, __u32 =
size, struct btf *base_btf)
>         return libbpf_ptr(btf_new(data, size, base_btf));
>  }
>
> -static struct btf *btf_parse_elf(const char *path, struct btf *base_btf,
> +static struct btf *btf_parse_elf(const char *path, const char *btf_sec, =
struct btf *base_btf,
>                                  struct btf_ext **btf_ext)
>  {
>         Elf_Data *btf_data =3D NULL, *btf_ext_data =3D NULL;
> @@ -1146,7 +1146,7 @@ static struct btf *btf_parse_elf(const char *path, =
struct btf *base_btf,
>                                 idx, path);
>                         goto done;
>                 }
> -               if (strcmp(name, BTF_ELF_SEC) =3D=3D 0) {
> +               if (strcmp(name, btf_sec) =3D=3D 0) {
>                         btf_data =3D elf_getdata(scn, 0);
>                         if (!btf_data) {
>                                 pr_warn("failed to get section(%d, %s) da=
ta from %s\n",
> @@ -1166,7 +1166,7 @@ static struct btf *btf_parse_elf(const char *path, =
struct btf *base_btf,
>         }
>
>         if (!btf_data) {
> -               pr_warn("failed to find '%s' ELF section in %s\n", BTF_EL=
F_SEC, path);
> +               pr_warn("failed to find '%s' ELF section in %s\n", btf_se=
c, path);
>                 err =3D -ENODATA;
>                 goto done;
>         }
> @@ -1212,12 +1212,12 @@ static struct btf *btf_parse_elf(const char *path=
, struct btf *base_btf,
>
>  struct btf *btf__parse_elf(const char *path, struct btf_ext **btf_ext)
>  {
> -       return libbpf_ptr(btf_parse_elf(path, NULL, btf_ext));
> +       return libbpf_ptr(btf_parse_elf(path, BTF_ELF_SEC, NULL, btf_ext)=
);
>  }
>
>  struct btf *btf__parse_elf_split(const char *path, struct btf *base_btf)
>  {
> -       return libbpf_ptr(btf_parse_elf(path, base_btf, NULL));
> +       return libbpf_ptr(btf_parse_elf(path, BTF_ELF_SEC, base_btf, NULL=
));
>  }
>
>  static struct btf *btf_parse_raw(const char *path, struct btf *base_btf)
> @@ -1293,7 +1293,8 @@ struct btf *btf__parse_raw_split(const char *path, =
struct btf *base_btf)
>         return libbpf_ptr(btf_parse_raw(path, base_btf));
>  }
>
> -static struct btf *btf_parse(const char *path, struct btf *base_btf, str=
uct btf_ext **btf_ext)
> +static struct btf *btf_parse(const char *path, const char *btf_elf_sec, =
struct btf *base_btf,
> +                            struct btf_ext **btf_ext)
>  {
>         struct btf *btf;
>         int err;
> @@ -1301,23 +1302,42 @@ static struct btf *btf_parse(const char *path, st=
ruct btf *base_btf, struct btf_
>         if (btf_ext)
>                 *btf_ext =3D NULL;
>
> -       btf =3D btf_parse_raw(path, base_btf);
> -       err =3D libbpf_get_error(btf);
> -       if (!err)
> -               return btf;
> -       if (err !=3D -EPROTO)
> -               return ERR_PTR(err);
> -       return btf_parse_elf(path, base_btf, btf_ext);
> +       if (!btf_elf_sec) {
> +               btf =3D btf_parse_raw(path, base_btf);
> +               err =3D libbpf_get_error(btf);
> +               if (!err)
> +                       return btf;
> +               if (err !=3D -EPROTO)
> +                       return ERR_PTR(err);
> +       }
> +       if (!btf_elf_sec)
> +               btf_elf_sec =3D BTF_ELF_SEC;
> +
> +       return btf_parse_elf(path, btf_elf_sec, base_btf, btf_ext);

nit: btf_elf_sec ?: BTF_ELF_SEC


> +}
> +
> +struct btf *btf__parse_opts(const char *path, struct btf_parse_opts *opt=
s)
> +{
> +       struct btf *base_btf;
> +       const char *btf_sec;
> +       struct btf_ext **btf_ext;
> +
> +       if (!OPTS_VALID(opts, btf_parse_opts))
> +               return libbpf_err_ptr(-EINVAL);
> +       base_btf =3D OPTS_GET(opts, base_btf, NULL);
> +       btf_sec =3D OPTS_GET(opts, btf_sec, NULL);
> +       btf_ext =3D OPTS_GET(opts, btf_ext, NULL);
> +       return libbpf_ptr(btf_parse(path, btf_sec, base_btf, btf_ext));
>  }
>
>  struct btf *btf__parse(const char *path, struct btf_ext **btf_ext)
>  {
> -       return libbpf_ptr(btf_parse(path, NULL, btf_ext));
> +       return libbpf_ptr(btf_parse(path, NULL, NULL, btf_ext));
>  }
>
>  struct btf *btf__parse_split(const char *path, struct btf *base_btf)
>  {
> -       return libbpf_ptr(btf_parse(path, base_btf, NULL));
> +       return libbpf_ptr(btf_parse(path, NULL, base_btf, NULL));
>  }
>
>  static void *btf_get_raw_data(const struct btf *btf, __u32 *size, bool s=
wap_endian);
> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 025ed28b7fe8..94dfdfdef617 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -18,6 +18,7 @@ extern "C" {
>
>  #define BTF_ELF_SEC ".BTF"
>  #define BTF_EXT_ELF_SEC ".BTF.ext"
> +#define BTF_BASE_ELF_SEC ".BTF.base"

Does libbpf code itself use this? If not, let's get rid of it.

>  #define MAPS_ELF_SEC ".maps"
>
>  struct btf;
> @@ -134,6 +135,37 @@ LIBBPF_API struct btf *btf__parse_elf_split(const ch=
ar *path, struct btf *base_b
>  LIBBPF_API struct btf *btf__parse_raw(const char *path);
>  LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf=
 *base_btf);
>
> +struct btf_parse_opts {
> +       size_t sz;
> +       /* use base BTF to parse split BTF */
> +       struct btf *base_btf;
> +       /* retrieve optional .BTF.ext info */
> +       struct btf_ext **btf_ext;
> +       /* BTF section name */

let's mention that if not set, libbpf will default to trying to parse
data as raw BTF, and then will fallback to .BTF in ELF. If it is set
to non-NULL, we'll assume ELF and use that section to fetch BTF data.

> +       const char *btf_sec;
> +       size_t:0;

nit: size_t :0; (consistency)

> +};
> +
> +#define btf_parse_opts__last_field btf_sec
> +
> +/* @brief **btf__parse_opts()** parses BTF information from either a
> + * raw BTF file (*btf_sec* is NULL) or from the specified BTF section,
> + * also retrieving  .BTF.ext info if *btf_ext* is non-NULL.  If
> + * *base_btf* is specified, use it to parse split BTF from the
> + * specified location.
> + *
> + * @return new BTF object instance which has to be eventually freed with
> + * **btf__free()**
> + *
> + * On error, error-code-encoded-as-pointer is returned, not a NULL. To e=
xtract

this is false, we don't encode error as pointer anymore. starting from
v1.0 it's always NULL + errno.

> + * error code from such a pointer `libbpf_get_error()` should be used. I=
f
> + * `libbpf_set_strict_mode(LIBBPF_STRICT_CLEAN_PTRS)` is enabled, NULL i=
s
> + * returned on error instead. In both cases thread-local `errno` variabl=
e is
> + * always set to error code as well.
> + */
> +
> +LIBBPF_API struct btf *btf__parse_opts(const char *path, struct btf_pars=
e_opts *opts);
> +
>  LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
>  LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, str=
uct btf *vmlinux_btf);
>
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index c4d9bd7d3220..a9151e31dfa9 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -421,6 +421,7 @@ LIBBPF_1.5.0 {
>         global:
>                 bpf_program__attach_sockmap;
>                 btf__distill_base;
> +               btf__parse_opts;
>                 ring__consume_n;
>                 ring_buffer__consume_n;
>  } LIBBPF_1.4.0;
> --
> 2.31.1
>


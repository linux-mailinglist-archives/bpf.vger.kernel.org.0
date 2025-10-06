Return-Path: <bpf+bounces-70454-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 296F4BBFBF5
	for <lists+bpf@lfdr.de>; Tue, 07 Oct 2025 01:09:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D35D83C175A
	for <lists+bpf@lfdr.de>; Mon,  6 Oct 2025 23:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94BC71DF75C;
	Mon,  6 Oct 2025 23:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN42wmIR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 939481A9F82
	for <bpf@vger.kernel.org>; Mon,  6 Oct 2025 23:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759792139; cv=none; b=hisKaDSNUq20RsdIpM4kTkR3f7R1kc0by1WbdHxJWJomISt80oqGQOWtwuGtkKc9/aWC878cSVNj+LE7gR9I2Z8/NRXKNLTf2nLWSyolxnqMaBmWzt84JTZxYKSnahZygCocIqYUas5XJAJFS7l3l80PLMuwGtGtR+i+IBKR8J4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759792139; c=relaxed/simple;
	bh=DnpxMOXXa+qt0rDJX96/H749KHW33plz1d7WdVsFqcE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SKwrb9Svd/ord+9A860GD8iYuhzTimXCB47sm27FUDwuNh8ix4hHDIp3hI8Eu9KNEcCH4bhOGVBfq7sE1LY4xqXRrNeCXZlAwkfgHh0SMLkW9AoltftOviKFNLS9Wjy7HlI15oN0x9OfGnYokp4KB0cWa60gfMiI66FNjcJ2/OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN42wmIR; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3306b83ebdaso5373272a91.3
        for <bpf@vger.kernel.org>; Mon, 06 Oct 2025 16:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759792137; x=1760396937; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b71ZXnezlpK2mBejio5/C0zF0YSEkd35Dd/Sp35VG5g=;
        b=aN42wmIRuMD6xCKBm2bmeYVxRrZlV+7sIKtYL3HaFJFFXJ02lW+HlDXy+AWUcTEhlL
         s6rqpUvj/7lxBk0TvDb5iTq/R55tVNa17PBnoAHxSI3zYUoXWeNT8o3kQPicZ8DzMxdb
         ljhOFQuy6rvqnCLRvx916XvHDfB6vOhQ03wprqtm/a6WLQ7hOlOedxXVV8HOsN0LdvPz
         tcUzHZ/Y5vr/BUCdfCBxNG3tx+49TfHv0LrAWJcJlovFPiPonBbFOCFX3cHQGBoyH3ol
         PXCBWe9TVnz6qnteCWygYQvTb3x0FstK/qNsHLfv2SATb5unptMTDMxt5S2ho/V1xL7+
         5RIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759792137; x=1760396937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b71ZXnezlpK2mBejio5/C0zF0YSEkd35Dd/Sp35VG5g=;
        b=QIMKHEz4XyUApT0dZgrqRtdd1r5p4N8uEOBa280SIM2Jcl6/dYNyyj5KBa+YrXA3Tr
         FznhF6K/MX0nDQfV2KMbPGOKNTsRDsZQ0cR2KRuqjpxol8DmWh/QZkkeRm4tJyf4/j/6
         J+Um0sav6xDpuPuQG5OJ6S5Yw7EgZo8bS1EFWGFKiTVysNsCb0OSX4RwqDmyF8c6DV8s
         01iSNkg8eveeQP4/bKHg50hFHexjTdtdTnR93vPBc33fsctjr3Q/KH1NFKs89BizLC2m
         Bw7/pvkXeX4cnqrbSxWkJlxfTr7AmKiPV/K5CclYzWTL5lv+iVX7diTIYDdkigrBPtmt
         9Vtw==
X-Gm-Message-State: AOJu0YxHENKjGOxkIsStR2IVguqkBebVjI0sXMn6D/JoNbCXE70xNDaV
	YLJE1djQYnXH83ybkVTdUIwDRzf/iiJ3A6BCBQyhqFx1VAC9zyqJ1FZQcEbWuuCtQIHhdxY5XU6
	ASYXoSzeZuOyxXCglLfM5vgp52prq2j4=
X-Gm-Gg: ASbGncuhpSfnDBAWtUxWcHG/59tT/Lza+K8HBDADpxPPpG6upCiaQdiUQ8ice5ocLM+
	AAQP/fIyN9yknhbq75OPO5Oy9+KXkonnLEaD0WQ5x14UUOTQdpzLnCfrCzArBxky10eaCVB0Fm+
	1n37FD5n+EIiOFhlBp4p55SEHrnz+m3GZB6144D/KkBFFVixYEXY7zZkZG7WpDrUhj3Z5eanjWS
	Gr3uHxwXKpeJ5jTHpJHxlmETs7FVS2BhYOPSDF0bNMt3Wg=
X-Google-Smtp-Source: AGHT+IG7oZ0CAa2mBSrcKhmtbfSfP3rR+NMGewr1m/AteYzVJ4Cf4B9YBV/l7iOw78zq+l6CBVbnmZZC8QClUgU+DdY=
X-Received: by 2002:a17:90b:38cb:b0:32e:dd8c:dd18 with SMTP id
 98e67ed59e1d1-339c27dad6emr18919589a91.17.1759792136788; Mon, 06 Oct 2025
 16:08:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002154841.99348-1-leon.hwang@linux.dev> <20251002154841.99348-3-leon.hwang@linux.dev>
In-Reply-To: <20251002154841.99348-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 6 Oct 2025 16:08:41 -0700
X-Gm-Features: AS18NWD1NpDkqDErMegHoDsNVSUi288ab2nWNe6ANhtrU4dDiQQ9cCnCmSMylpM
Message-ID: <CAEf4BzZm+51H6hRq1UOTyXi7UtRX9o3Y8Fr_GS_UkaqJJX4d1g@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v3 02/10] libbpf: Add support for extended
 bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 8:49=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> wr=
ote:
>
> To support the extended 'bpf()' syscall introduced in the previous commit=
,
> introduce the following internal APIs:
>
> * 'sys_bpf_ext()'
> * 'sys_bpf_ext_fd()'
>   They wrap the raw 'syscall()' interface to support passing extended
>   attributes.
> * 'probe_sys_bpf_ext()'
>   Check whether current kernel supports the extended attributes.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c             | 33 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/features.c        |  8 ++++++++
>  tools/lib/bpf/libbpf_internal.h |  3 +++
>  3 files changed, 44 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index 339b197972374..9cd79beb13a2d 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -69,6 +69,39 @@ static inline __u64 ptr_to_u64(const void *ptr)
>         return (__u64) (unsigned long) ptr;
>  }
>
> +static inline int sys_bpf_ext(enum bpf_cmd cmd, union bpf_attr *attr,
> +                             unsigned int size,
> +                             struct bpf_common_attr *common_attrs,
> +                             unsigned int size_common)
> +{
> +       cmd =3D common_attrs ? cmd | BPF_COMMON_ATTRS : cmd & ~BPF_COMMON=
_ATTRS;

nit: put those () two branches of ternary operator, there is no need
to rely on obscure C operator precedence order here

> +       return syscall(__NR_bpf, cmd, attr, size, common_attrs, size_comm=
on);
> +}
> +
> +static inline int sys_bpf_ext_fd(enum bpf_cmd cmd, union bpf_attr *attr,
> +                                unsigned int size,
> +                                struct bpf_common_attr *common_attrs,
> +                                unsigned int size_common)
> +{
> +       int fd;
> +
> +       fd =3D sys_bpf_ext(cmd, attr, size, common_attrs, size_common);
> +       return ensure_good_fd(fd);
> +}
> +
> +int probe_sys_bpf_ext(void)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_token_f=
d);
> +       union bpf_attr attr;
> +       int fd;
> +
> +       memset(&attr, 0, attr_sz);
> +       fd =3D syscall(__NR_bpf, BPF_PROG_LOAD | BPF_COMMON_ATTRS, &attr,=
 attr_sz, NULL,
> +                    sizeof(struct bpf_common_attr));
> +       fd =3D errno =3D=3D EFAULT ? syscall(__NR_memfd_create, "fd", 0) =
: fd;
> +       return ensure_good_fd(fd);

why do we need to create FD?..

> +}
> +
>  static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>                           unsigned int size)
>  {
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 760657f5224c2..d01df62394f89 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -507,6 +507,11 @@ static int probe_kern_arg_ctx_tag(int token_fd)
>         return probe_fd(prog_fd);
>  }
>
> +static int probe_kern_extended_syscall(int token_fd)
> +{
> +       return probe_fd(probe_sys_bpf_ext());
> +}
> +

just do that feature detection right here without creating any new
FDs... make sys_bpf_ext() exposed just like we do that with sys_bpf()
and use this here


>  typedef int (*feature_probe_fn)(int /* token_fd */);
>
>  static struct kern_feature_cache feature_cache;
> @@ -582,6 +587,9 @@ static struct kern_feature_desc {
>         [FEAT_BTF_QMARK_DATASEC] =3D {
>                 "BTF DATASEC names starting from '?'", probe_kern_btf_qma=
rk_datasec,
>         },
> +       [FEAT_EXTENDED_SYSCALL] =3D {
> +               "Kernel supports extended syscall", probe_kern_extended_s=
yscall,
> +       },
>  };
>
>  bool feat_supported(struct kern_feature_cache *cache, enum kern_feature_=
id feat_id)
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index c93797dcaf5bc..af05df8d040ce 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -380,6 +380,8 @@ enum kern_feature_id {
>         FEAT_ARG_CTX_TAG,
>         /* Kernel supports '?' at the front of datasec names */
>         FEAT_BTF_QMARK_DATASEC,
> +       /* Kernel supports extended syscall */
> +       FEAT_EXTENDED_SYSCALL,
>         __FEAT_CNT,
>  };
>
> @@ -740,4 +742,5 @@ int probe_fd(int fd);
>  #define SHA256_DWORD_SIZE SHA256_DIGEST_LENGTH / sizeof(__u64)
>
>  void libbpf_sha256(const void *data, size_t len, __u8 out[SHA256_DIGEST_=
LENGTH]);
> +int probe_sys_bpf_ext(void);
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> --
> 2.51.0
>


Return-Path: <bpf+bounces-73524-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B083C33618
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 00:27:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2E15E4E2025
	for <lists+bpf@lfdr.de>; Tue,  4 Nov 2025 23:27:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2CD32E093F;
	Tue,  4 Nov 2025 23:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RygzuO+5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819FA2DCF5B
	for <bpf@vger.kernel.org>; Tue,  4 Nov 2025 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762298831; cv=none; b=sNctyJ3SH2vwdWxNTxSIahz2gpDo6mfq0m6ftQR+OcnMin6dzr7ppoqLLEiNC0uLEenm80BQdVrEHbcYJyaVS/HOz6u8lwpLG0OcCELDqze6SuSWA40R7W43t6iewHzKdJSzV5b32k9XKxiVvG864YJOgjGJCcHtBmmBT/DInNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762298831; c=relaxed/simple;
	bh=qVBLGpCVWEb/fKsz5o7sI6+UQwQTW6Zj0Zi7bspsDxA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sPhBPfQmii5fL2tu/MVKf87cxHD6syGwTXB3xvRVmByaLloV0/JMfUvRnvVQJW9VHVpGkbEb48s3/ldt7b3+d6kxw43bpPysaGC2FBn64gZPbHR5qDShG0gpoZgnLUj1ACLGeTEXkJhckAmtVxowavxO57iIPkmnjCdGkWzmMTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RygzuO+5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-294fd2ca6acso2653935ad.0
        for <bpf@vger.kernel.org>; Tue, 04 Nov 2025 15:27:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762298829; x=1762903629; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ujp9P34IbLYn85zZwW+PJOR0krLUjQ+5pePK2TgJ4yI=;
        b=RygzuO+5ggSRAI/c1bEegkrAhlcRjTHEq25l2uA5FNcTWpBUr6ElvWgYT2qiEepUqB
         G1AiTlrDfHdhACYX11AKVxVnPWDyhncbwGYCG2Qca176KhD7qKNddQjHqW3kBU/dQ/M2
         7qBLHEmGnC0HOC0sb+4ci82vbpm5CUNOeruBt2j4Rj+mjNC2D1FOJJ7EPokZaKC49nxi
         mq3mypNuohpftyiIvxOfXpRwrR0qhJLEmnSDpTi5K4xutt3K8qD1E2aKmocby3iuLAy6
         70bcOtKTsUC1dQrgOyXveUtbQE8WPlXjnsyKxkVX01lMN0w7aZv5OnDDnTGOvQqo0ekb
         8slg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762298829; x=1762903629;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ujp9P34IbLYn85zZwW+PJOR0krLUjQ+5pePK2TgJ4yI=;
        b=PaC8ad8JPkH/tbRIiCq8faNLDCC5YG6buTVdcsIAUYI6ttWw3JiogMSGFTJWKIlSXr
         Cyt7DV7NvAIQkdtgDbKISLgaempKk3gnmt/Uk993hlEQmsbx2E/4WyxW3dBEJ4NBs+Uv
         A8/9pmtKgPn7f/4M2zT/xNQJ2m1I5kPxU74jsK7rR8Yc/WoMIUzc1IG3Yha8lBxetXJV
         pDFeOgP86kSGkUCLwmvIUiU/izEGl4LDlhbIfCilL7qzMJDP83pus9Sx52XsL0JFRQSa
         MO5X10jhWVyAxK1P5sy8BDM4IJs4YBh5p9AppvMRG691QQao5YlDHynhVhrb5iMokqCS
         NGHg==
X-Gm-Message-State: AOJu0Yz0L9uYeA6AWlpb+hymFQe2tvAlWbowkZVgDGFHeFs/hcu3alhH
	5eUuBNOMz5t/CdEcawAt80f02dsYbEutXnNfSkh5v1Tu5B4I1Nqu17ZF1R3a28VTDhgPNMN6ozh
	nHuGdalcqdwT//U5AeS4qUB1Utg/vJQI=
X-Gm-Gg: ASbGnctKMxBHE0a1z18V2SCfTIfbrxD09QLXKLBfEfA3doDfi0zUu7h45VwkXQRO0zA
	c3wVy+agicAE1Z0UApf9RQnp1nxbltIvSHmTNwvdCjX8N35c0iZfVUx7TwgkP1Ry2zny9H5KlPn
	8tMW8ER1dSB4NDzsWZ1v+rzONu4DtJnI19xDJVN+DtDaXAdwnCY5lHkNHCJLpD7gw5Aa/S4ZQyc
	/23QIssihN3B/aF9378VRYN1A9uGz9ZCFb5QynIDbjVT7gGtuEAYD5vQl2sE5zjzStcf7k8lwSG
	JcBiUkHDN5M=
X-Google-Smtp-Source: AGHT+IE1HAXKMqkoS3b8WkHwb7z7CBn0AXzGubQUeHnhc1NCb1NVxWjlw8I3CWftUcrKquwjPmuYGW6VRjXftZM1e70=
X-Received: by 2002:a17:903:1a0b:b0:294:fc77:f041 with SMTP id
 d9443c01a7336-2962addfa05mr14653155ad.25.1762298828573; Tue, 04 Nov 2025
 15:27:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251104172652.1746988-1-ameryhung@gmail.com> <20251104172652.1746988-5-ameryhung@gmail.com>
In-Reply-To: <20251104172652.1746988-5-ameryhung@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 4 Nov 2025 15:26:54 -0800
X-Gm-Features: AWmQ_bkTXIo41na74UU32DfeQLIv5u6KKFcy7gl0zas_R6dLDOW9tjtePUXVtnc
Message-ID: <CAEf4BzbqEsZbO4AjKn7iRQCzKVSD0db9WdG7uKXMCA_4ueFYig@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 4/7] libbpf: Add support for associating BPF
 program with struct_ops
To: Amery Hung <ameryhung@gmail.com>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, alexei.starovoitov@gmail.com, 
	andrii@kernel.org, daniel@iogearbox.net, tj@kernel.org, martin.lau@kernel.org, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 4, 2025 at 9:27=E2=80=AFAM Amery Hung <ameryhung@gmail.com> wro=
te:
>
> Add low-level wrapper and libbpf API for BPF_PROG_ASSOC_STRUCT_OPS
> command in the bpf() syscall.
>
> Signed-off-by: Amery Hung <ameryhung@gmail.com>
> ---
>  tools/lib/bpf/bpf.c      | 19 +++++++++++++++++++
>  tools/lib/bpf/bpf.h      | 21 +++++++++++++++++++++
>  tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   | 16 ++++++++++++++++
>  tools/lib/bpf/libbpf.map |  2 ++
>  5 files changed, 88 insertions(+)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index b66f5fbfbbb2..21b57a629916 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -1397,3 +1397,22 @@ int bpf_prog_stream_read(int prog_fd, __u32 stream=
_id, void *buf, __u32 buf_len,
>         err =3D sys_bpf(BPF_PROG_STREAM_READ_BY_FD, &attr, attr_sz);
>         return libbpf_err_errno(err);
>  }
> +
> +int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
> +                             struct bpf_prog_assoc_struct_ops_opts *opts=
)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_assoc_s=
truct_ops);
> +       union bpf_attr attr;
> +       int err;
> +
> +       if (!OPTS_VALID(opts, bpf_prog_assoc_struct_ops_opts))
> +               return libbpf_err(-EINVAL);
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.prog_assoc_struct_ops.map_fd =3D map_fd;
> +       attr.prog_assoc_struct_ops.prog_fd =3D prog_fd;
> +       attr.prog_assoc_struct_ops.flags =3D OPTS_GET(opts, flags, 0);
> +
> +       err =3D sys_bpf(BPF_PROG_ASSOC_STRUCT_OPS, &attr, attr_sz);
> +       return libbpf_err_errno(err);
> +}
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index e983a3e40d61..1f9c28d27795 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -733,6 +733,27 @@ struct bpf_prog_stream_read_opts {
>  LIBBPF_API int bpf_prog_stream_read(int prog_fd, __u32 stream_id, void *=
buf, __u32 buf_len,
>                                     struct bpf_prog_stream_read_opts *opt=
s);
>
> +struct bpf_prog_assoc_struct_ops_opts {
> +       size_t sz;
> +       __u32 flags;
> +       size_t :0;
> +};
> +#define bpf_prog_assoc_struct_ops_opts__last_field flags
> +
> +/**
> + * @brief **bpf_prog_assoc_struct_ops** associates a BPF program with a
> + * struct_ops map.
> + *
> + * @param prog_fd FD for the BPF program
> + * @param map_fd FD for the struct_ops map to be associated with the BPF=
 program
> + * @param opts optional options, can be NULL
> + *
> + * @return 0 on success; negative error code, otherwise (errno is also s=
et to
> + * the error code)
> + */
> +LIBBPF_API int bpf_prog_assoc_struct_ops(int prog_fd, int map_fd,
> +                                        struct bpf_prog_assoc_struct_ops=
_opts *opts);
> +
>  #ifdef __cplusplus
>  } /* extern "C" */
>  #endif
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index fbe74686c97d..260e1feaa665 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -13891,6 +13891,36 @@ int bpf_program__set_attach_target(struct bpf_pr=
ogram *prog,
>         return 0;
>  }
>
> +int bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_m=
ap *map,
> +                                 struct bpf_prog_assoc_struct_ops_opts *=
opts)
> +{
> +       int prog_fd;
> +
> +       prog_fd =3D bpf_program__fd(prog);
> +       if (prog_fd < 0) {
> +               pr_warn("prog '%s': can't associate BPF program without F=
D (was it loaded?)\n",
> +                       prog->name);
> +               return -EINVAL;
> +       }
> +
> +       if (prog->type =3D=3D BPF_PROG_TYPE_STRUCT_OPS) {
> +               pr_warn("prog '%s': can't associate struct_ops program\n"=
, prog->name);
> +               return -EINVAL;
> +       }
> +
> +       if (map->fd < 0) {

heh, this is a bug. we use create_placeholder_fd() to create fixed FDs
associated with maps, and later we replace them with the real
underlying BPF map kernel objects. It's all details, but the point is
that this won't detect map that wasn't created. Use bpf_map__fd()
instead, it handles that correctly.

> +               pr_warn("map '%s': can't associate BPF map without FD (wa=
s it created?)\n", map->name);
> +               return -EINVAL;
> +       }
> +
> +       if (!bpf_map__is_struct_ops(map)) {
> +               pr_warn("map '%s': can't associate non-struct_ops map\n",=
 map->name);
> +               return -EINVAL;
> +       }
> +
> +       return bpf_prog_assoc_struct_ops(prog_fd, map->fd, opts);
> +}
> +
>  int parse_cpu_mask_str(const char *s, bool **mask, int *mask_sz)
>  {
>         int err =3D 0, n, len, start, end =3D -1;
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 5118d0a90e24..45720b7c2aaa 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -1003,6 +1003,22 @@ LIBBPF_API int
>  bpf_program__set_attach_target(struct bpf_program *prog, int attach_prog=
_fd,
>                                const char *attach_func_name);
>
> +struct bpf_prog_assoc_struct_ops_opts; /* defined in bpf.h */
> +
> +/**
> + * @brief **bpf_program__assoc_struct_ops()** associates a BPF program w=
ith a
> + * struct_ops map.
> + *
> + * @param prog BPF program
> + * @param map struct_ops map to be associated with the BPF program
> + * @param opts optional options, can be NULL
> + *
> + * @return error code; or 0 if no error occurred.

we normally specify returns like so:

@return 0, on success; negative error code, otherwise

keep it consistent?

> + */
> +LIBBPF_API int
> +bpf_program__assoc_struct_ops(struct bpf_program *prog, struct bpf_map *=
map,
> +                             struct bpf_prog_assoc_struct_ops_opts *opts=
);
> +
>  /**
>   * @brief **bpf_object__find_map_by_name()** returns BPF map of
>   * the given name, if it exists within the passed BPF object
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index 8ed8749907d4..84fb90a016c9 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -451,4 +451,6 @@ LIBBPF_1.7.0 {
>         global:
>                 bpf_map__set_exclusive_program;
>                 bpf_map__exclusive_program;
> +               bpf_prog_assoc_struct_ops;
> +               bpf_program__assoc_struct_ops;
>  } LIBBPF_1.6.0;
> --
> 2.47.3
>


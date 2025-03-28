Return-Path: <bpf+bounces-54862-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C9B0DA74F1E
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 18:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35B0D7A7409
	for <lists+bpf@lfdr.de>; Fri, 28 Mar 2025 17:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426211DDA36;
	Fri, 28 Mar 2025 17:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KmhijbxL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A661DD0DC
	for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 17:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743182088; cv=none; b=nrR/0cBwsrN09GMDCIhY7byqNj4MQ0lTqH0INkYyHANs/0sqsz0QySzuQbaM3wsWPK/RgylE8KzEERIwbe6LK//k1v97gpNLB3b8FgYAP7NsolSBCI5JW2dIY1EfZGJHBGdcoEwywoBgR81+DUiw51mS5RGjXCRB4R17JYiHR78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743182088; c=relaxed/simple;
	bh=I+uh82Evs8NTTnpNOr7MUupMU9rHspQZqRTYBb2+XGw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gL1EDu/WuSntEK4dR7ZLSsIWcqxHQ9ACxwb7fL6r8RHbb8x5eEfxOG40fTShLeZ6cMOlYNGX6dEXv/Gc7JuD9PUumIGFNuSZgamF1PsCYIZjWpqpW4L0QSSWhh4AR9iPY+0RLuNZ7vxRcr/6Qb15nroYxK1sVK+mpHSLdbfStHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KmhijbxL; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2ff6e91cff5so4388744a91.2
        for <bpf@vger.kernel.org>; Fri, 28 Mar 2025 10:14:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743182086; x=1743786886; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vApnCDibFrqUcI36uG0RrYK1S6ltT5tJqiBxSM6N9FY=;
        b=KmhijbxLd44WVwWk7g75PorVU7gWKTqp8kXr4hYkKGYOfSOD1BAitS7AI0dRAKBUYT
         OU357PBJR7yjgEqxlIVGd/X6KVw3xov34cvRykV+n/Fc1coWn/mSbrGVBu+kIDrflxsT
         6kK63TINKDPDohv2SNVDhSFN6xw82x7UOeTmiXY3XzsXhXkYafrXq36gZ9LWOjLSTy6T
         WR3bSbyhzQhUAtOr1V5O6Tg8oZhq+M2/ZL6E1q4IZqsk0IaJHJ1sCN2CvmwT3oJH50e8
         O6mehxtRHl90EK612XgnTu1ftD24yQEbffkoEBp8Nf4JUt2NccSloi78EDUP9JSNrkJa
         gtJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743182086; x=1743786886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vApnCDibFrqUcI36uG0RrYK1S6ltT5tJqiBxSM6N9FY=;
        b=hKrn+tXp/FUr71QAVpV5TggSHc1nlMiR/o2R5YmifjC0lNmQN/K/Exx4K1Pcc7d7hM
         3I/RwmpqMRSGd6FzgURXqVQ5ivHglSVfsfL646soaS3kvX/JPZ2BWU4AnLcmepWRYvzS
         sebERvZ+RctmEejzs0vpsm5LY+Hzi4ycXqr4rN4AIHMtmp/6O0+8lT8gQl84BKyvG9yp
         X03BY35W9ntNYKQc60M3O9bixo8bWmYjB6hLcqkItUk+Zx8dtIBHb5r5bSycRVzNzLjA
         dyzA/DXiYVnwXfM+QLbXJhKGZHLOWPVkid3COWVxCUb7h/POJFlPkQV5vR1a04Moiszx
         Pnrw==
X-Gm-Message-State: AOJu0YxGTQvSykEWWhx2zDTOA/Ll3orw53ihQYO3UKVsUPTPc2GISD/3
	SVrvxc0NxL6xP601XCK/WRAyUs/S+vGFCM240jBqkiXsqhKe8/o660+2EEphBdX6HVZEs1mYs0J
	FdFvj3TM7ZRsv7jtcPw6IE/zvOvU=
X-Gm-Gg: ASbGnctAZfvfXeb7x032tG1oh7h71BAmRj70xBckfhzMXg8EHtAF/GDtVPojFk3HSXe
	6/vmXJAEokpNpVro07kWB3q1FQ+Z9L7leKSvt8kCSNg2GIParaFTjiwH6+YexwVvtBPr9mfiw+2
	NfoKYwIPXZeB5m6QLAX+SStxpnDeux1MiNWtVOMj4+kzXakzpGrFE3
X-Google-Smtp-Source: AGHT+IFlx3zyRWCnkqRjQiQ2t0rm5+cVV3cywaPdn2LtuDcomZRrsihElZp1O2MnUoAaK1tj5nTJ83W5d0jCfOyrdpU=
X-Received: by 2002:a17:90b:2643:b0:2ee:741c:e9f4 with SMTP id
 98e67ed59e1d1-30531fa4e8fmr106605a91.11.1743182086166; Fri, 28 Mar 2025
 10:14:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250326180714.44954-1-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250326180714.44954-1-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Fri, 28 Mar 2025 10:14:33 -0700
X-Gm-Features: AQ5f1Jqn_eTQSK-DiZ9b3Fh2r-nIUFfboVVRLbjXXmKzfMmVPNj2Jq4XNDxz1pw
Message-ID: <CAEf4BzY_rbdXFDyYN=s7c25R5kwpBX5-zxQd8Q+6wX2N0r6Uhw@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: add getters for BTF.ext func and line info
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 26, 2025 at 11:07=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introducing new libbpf API getters for BTF.ext func and line info,
> namely:
>   bpf_program__func_info
>   bpf_program__func_info_cnt
>   bpf_program__func_info_rec_size
>   bpf_program__line_info
>   bpf_program__line_info_cnt
>   bpf_program__line_info_rec_size
>
> This change enables scenarios, when user needs to load bpf_program
> directly using `bpf_prog_load`, instead of higher-level
> `bpf_object__load`. Line and func info are required for checking BTF
> info in verifier; verification may fail without these fields if, for
> example, program calls `bpf_obj_new`.
>

Really, bpf_obj_new() needs func_info/line_info? Can you point where
in the verifier we check this, curious why we do that.

> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 30 ++++++++++++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  8 ++++++++
>  tools/lib/bpf/libbpf.map |  6 ++++++
>  3 files changed, 44 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6b85060f07b3..bc15526ed84c 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9455,6 +9455,36 @@ int bpf_program__set_log_buf(struct bpf_program *p=
rog, char *log_buf, size_t log
>         return 0;
>  }
>
> +void *bpf_program__func_info(struct bpf_program *prog)

const struct bpf_program, here and everywhere else

> +{
> +       return prog->func_info;
> +}
> +
> +__u32 bpf_program__func_info_cnt(struct bpf_program *prog)
> +{
> +       return prog->func_info_cnt;
> +}
> +
> +__u32 bpf_program__func_info_rec_size(struct bpf_program *prog)
> +{
> +       return prog->func_info_rec_size;
> +}
> +
> +void *bpf_program__line_info(struct bpf_program *prog)

should be `const void *`, if we went with `void *`, but see below about typ=
es

> +{
> +       return prog->line_info;
> +}
> +
> +__u32 bpf_program__line_info_cnt(struct bpf_program *prog)
> +{
> +       return prog->line_info_cnt;
> +}
> +
> +__u32 bpf_program__line_info_rec_size(struct bpf_program *prog)
> +{
> +       return prog->line_info_rec_size;
> +}
> +

As Eduard mentioned, I don't think `void *` is a good interface. We
have bpf_line_info_min and bpf_func_info_min structs in
libbpf_internal.h. We have never changed those types, so at this point
I feel comfortable enough to expose them as API types. Let's drop the
_min suffix, and move definitions to btf.h?

The only question is whether to document that each record could be
bigger in size than sizeof(struct bpf_func_info) (and similarly for
bpf_line_info), and thus user should always care about
func_info_rec_size? Or, to keep it ergonomic and simple, and basically
always return sizeof(struct bpf_func_info) data (and if it so happens
that we'll in the future have different record sizes, then we'll
create a local trimmed representation for user; it's a pain, but we
won't be really stuck from API compatibility standpoint).

I'd go with simple and ergonomic, given we haven't ever extended these
records, and it's unlikely we will. Those types work well and provide
enough information as is. So let's not even add _rec_size() APIs (at
least for now; we can always revisit this later)

pw-bot: cr

>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                    =
   \
>         .sec =3D (char *)sec_pfx,                                        =
     \
>         .prog_type =3D BPF_PROG_TYPE_##ptype,                            =
     \
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index e0605403f977..29a5fd7f51f0 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -940,6 +940,14 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf=
_program *prog, __u32 log_le
>  LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *pr=
og, size_t *log_size);
>  LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *=
log_buf, size_t log_size);
>
> +LIBBPF_API void *bpf_program__func_info(struct bpf_program *prog);
> +LIBBPF_API __u32 bpf_program__func_info_cnt(struct bpf_program *prog);
> +LIBBPF_API __u32 bpf_program__func_info_rec_size(struct bpf_program *pro=
g);
> +
> +LIBBPF_API void *bpf_program__line_info(struct bpf_program *prog);
> +LIBBPF_API __u32 bpf_program__line_info_cnt(struct bpf_program *prog);
> +LIBBPF_API __u32 bpf_program__line_info_rec_size(struct bpf_program *pro=
g);
> +
>  /**
>   * @brief **bpf_program__set_attach_target()** sets BTF-based attach tar=
get
>   * for supported BPF program types:
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index d8b71f22f197..a5d83189c084 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -437,6 +437,12 @@ LIBBPF_1.6.0 {
>                 bpf_linker__add_fd;
>                 bpf_linker__new_fd;
>                 bpf_object__prepare;
> +               bpf_program__func_info;
> +               bpf_program__func_info_cnt;
> +               bpf_program__func_info_rec_size;
> +               bpf_program__line_info;
> +               bpf_program__line_info_cnt;
> +               bpf_program__line_info_rec_size;
>                 btf__add_decl_attr;
>                 btf__add_type_attr;
>  } LIBBPF_1.5.0;
> --
> 2.48.1
>


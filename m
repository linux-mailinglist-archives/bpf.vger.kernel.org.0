Return-Path: <bpf+bounces-54987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43547A76DEF
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2487188C0CC
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9351A215191;
	Mon, 31 Mar 2025 20:09:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RI7uaKWa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9965826AF6
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743451768; cv=none; b=CSp18Iyl2/qYa3/TEZspY2donOf4rXp+lRd0ZIhnCq3Q3sRK/sFZkYzpLBwKZygB3p9yV/IbJuftkJpIe1YBmMNM6uidusDyoTCnIlFj13ztQULg8iN9oqgDK8kd7A+UDukGUWU/8bzAsvXC2EEXaa8pxTjtc8sm0g5bViNksz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743451768; c=relaxed/simple;
	bh=9VLM8k2GkSx5v86mw2gpFSyXBqhGGe5w+m60EC1KHJ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bmLirX43Lg8j+Bfsr8o0H2EaLQBGunYDXew/mIhlDf1iee7vFDSdULmTm0dbQdxe1qPZPlhkW18A+YyTxrwppc3hEE+iVEVOZYTkA3gpIbR2QcSQcqnwe2Kp5F0P8qGnYo8ZfiOGf3N/WnbNjMSDEd9mGVSlZspYRkPkWfZbUzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RI7uaKWa; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-2ff615a114bso8604230a91.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743451766; x=1744056566; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MywlvUg8Foj3pCZMKYYjbXMk+0OJmZbRdbLJCD2WP+w=;
        b=RI7uaKWaM9qvcsabcCyAqMEk56hGQ20Q5s/LID0TNB2cBD3ugeFU9QQAnA/NlScAKu
         9swuB49cGvEB2wELxA5o1HGZNfIrWQ9uWUBv10SsBuVL6DIjYm7DdM+7c3mUt3vcJs5D
         X3qLhYSnIgeAaykTuoau9GbhhygFAuQItJuFzOMDe+SSy702hLgUYZAJ+Yw4j0F6dnOL
         HTDQkNYdQIRKvMXeDNQ8Rite2pUN5LVSN3rLP+Rg5lV0h6e4pkgri9L3p98AeF3NwtFj
         T3ZYGEaeul6sHv4yGrg8DhKDrQtHJ68ZKsSO1tX+vvtarO3azHSgSx5dzcqpV5bW1a1W
         WN2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743451766; x=1744056566;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MywlvUg8Foj3pCZMKYYjbXMk+0OJmZbRdbLJCD2WP+w=;
        b=aOOmhROHmz6Xd+98ol3MFX5z8xpx9Rmz5n3GV8YZYYWsBMR40CSZBzPz+iDMXm6KQ+
         Soo0WmqKSFu1T99+zszpVIA+adj/z6WyCBLiGZqxxseRNcVdJRRtCk/1Mew28zrP1OLO
         lFuD2n1r6T4Y7P/zprJhDCs1TB/CW5JfINzXZSFSpR3nj2u4l2bE0GpQDUK7COOVGXnm
         ZHbwxGgcXwFPGd05x/Dl1PaJg8v+aEonK18/HbY5CkWUOzK6HN0Dqsew9hHJd4WahM8J
         RhSpqNq1O3IkBWwuuw5VK92lz45WmBAv/us3NAETPBnlEgS+W+W5Q1wkhsq1a9EY7RcJ
         VqmA==
X-Gm-Message-State: AOJu0YzShBkrKc0dyk8KUN5NnEqldG6pdSpyYY3ckIUi9fKR4toDCa15
	zjWYWqRXZ98jukB1UhxfpQpcNVF4cv36J8gegH3OA/bhiimMJAMMwOJruLsBQTuUfzJ+JfC0NeQ
	Twsa3KRp9iNV2mBZ6mlTypOiddpM=
X-Gm-Gg: ASbGncvrF32LTClWmCow6jOeD6FsAPhbOIhlCdDQkIqfvlO6SuoUHlXWght48PLoAhc
	UTPplgjUAu+WBNzjDJC8SUBrpNbeQq4Juf1LLSdLHqOy4/zHORGykgMWdI4ZKR6m/mCho98hqHg
	g/q59ruvrTudboAXvn14pizVyQexbTaWk2liWD3ZQWcA==
X-Google-Smtp-Source: AGHT+IHI4qc9T83lwuul/gBwfQ54y2JBV+rvz6H4AXPE0Cp++3mj/Uq0bVau6AvRcpZrHg26j1E3sMwcRswuZIJ+fKc=
X-Received: by 2002:a17:90b:5345:b0:2ff:5267:e7da with SMTP id
 98e67ed59e1d1-3053186c823mr14665928a91.3.1743451765827; Mon, 31 Mar 2025
 13:09:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250331144817.78443-1-mykyta.yatsenko5@gmail.com> <20250331144817.78443-3-mykyta.yatsenko5@gmail.com>
In-Reply-To: <20250331144817.78443-3-mykyta.yatsenko5@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 31 Mar 2025 13:09:13 -0700
X-Gm-Features: AQ5f1JrQcEmUUxQs7CscY8purwC8jyZtL8OevCSKycCcBy65Bm2nc2l9lY1T4AQ
Message-ID: <CAEf4BzYeRxXhDXVuE2d34Q5c5Fzx32k0iVHyJgLaD9KU0+F4xA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/2] libbpf: add getters for BTF.ext func and
 line info
To: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, kafai@meta.com, kernel-team@meta.com, eddyz87@gmail.com, 
	Mykyta Yatsenko <yatsenko@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 31, 2025 at 7:48=E2=80=AFAM Mykyta Yatsenko
<mykyta.yatsenko5@gmail.com> wrote:
>
> From: Mykyta Yatsenko <yatsenko@meta.com>
>
> Introducing new libbpf API getters for BTF.ext func and line info,
> namely:
>   bpf_program__func_info
>   bpf_program__func_info_cnt
>   bpf_program__line_info
>   bpf_program__line_info_cnt
>
> This change enables scenarios, when user needs to load bpf_program
> directly using `bpf_prog_load`, instead of higher-level
> `bpf_object__load`. Line and func info are required for checking BTF
> info in verifier; verification may fail without these fields if, for
> example, program calls `bpf_obj_new`.
>
> Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
> ---
>  tools/lib/bpf/libbpf.c   | 20 ++++++++++++++++++++
>  tools/lib/bpf/libbpf.h   |  6 ++++++
>  tools/lib/bpf/libbpf.map |  4 ++++
>  3 files changed, 30 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 6b85060f07b3..86f6aff76ef2 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -9455,6 +9455,26 @@ int bpf_program__set_log_buf(struct bpf_program *p=
rog, char *log_buf, size_t log
>         return 0;
>  }
>
> +struct bpf_func_info_min *bpf_program__func_info(const struct bpf_progra=
m *prog)
> +{
> +       return prog->func_info;
> +}
> +
> +__u32 bpf_program__func_info_cnt(const struct bpf_program *prog)
> +{
> +       return prog->func_info_cnt;
> +}
> +
> +struct bpf_line_info_min *bpf_program__line_info(const struct bpf_progra=
m *prog)
> +{
> +       return prog->line_info;
> +}
> +
> +__u32 bpf_program__line_info_cnt(const struct bpf_program *prog)
> +{
> +       return prog->line_info_cnt;
> +}
> +

I didn't realize that we already have bpf_line_info/bpf_func_info as
part of Linux UAPI. If that's the case, let's keep _min variants where
they are (internal), and use public types. No need for patch #1.

Let's just add:

if (prog->func_info_rec_size !=3D sizeof(struct bpf_func_info_min))
    return libbpf_err_ptr(-EOPNOTSUPP);

everywhere so we don't accidentally return invalid data, ok?


Also, let's do a bit of testing here. I think it would be nice to have
a selftests that loads some simple BPF program (perhaps with
non-inlined subprog to test func/line info with subprogs) first
through normal skeleton load approach. Capture its func_info/line_info
from kernel. Then use these new APIs you are adding and do
bpf_prog_load(), and then compare that we got identical
func_info/line_info (as reported by the kernel). Can you please add
that?

>  #define SEC_DEF(sec_pfx, ptype, atype, flags, ...) {                    =
   \
>         .sec =3D (char *)sec_pfx,                                        =
     \
>         .prog_type =3D BPF_PROG_TYPE_##ptype,                            =
     \
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index e0605403f977..a6ec87fb0fb9 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -940,6 +940,12 @@ LIBBPF_API int bpf_program__set_log_level(struct bpf=
_program *prog, __u32 log_le
>  LIBBPF_API const char *bpf_program__log_buf(const struct bpf_program *pr=
og, size_t *log_size);
>  LIBBPF_API int bpf_program__set_log_buf(struct bpf_program *prog, char *=
log_buf, size_t log_size);
>
> +LIBBPF_API struct bpf_func_info_min *bpf_program__func_info(const struct=
 bpf_program *prog);
> +LIBBPF_API __u32 bpf_program__func_info_cnt(const struct bpf_program *pr=
og);
> +
> +LIBBPF_API struct bpf_line_info_min *bpf_program__line_info(const struct=
 bpf_program *prog);
> +LIBBPF_API __u32 bpf_program__line_info_cnt(const struct bpf_program *pr=
og);
> +
>  /**
>   * @brief **bpf_program__set_attach_target()** sets BTF-based attach tar=
get
>   * for supported BPF program types:
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index d8b71f22f197..1205f9a4fe04 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -437,6 +437,10 @@ LIBBPF_1.6.0 {
>                 bpf_linker__add_fd;
>                 bpf_linker__new_fd;
>                 bpf_object__prepare;
> +               bpf_program__func_info;
> +               bpf_program__func_info_cnt;
> +               bpf_program__line_info;
> +               bpf_program__line_info_cnt;
>                 btf__add_decl_attr;
>                 btf__add_type_attr;
>  } LIBBPF_1.5.0;
> --
> 2.49.0
>


Return-Path: <bpf+bounces-45987-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AB039E1161
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 03:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C8C14B22735
	for <lists+bpf@lfdr.de>; Tue,  3 Dec 2024 02:34:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C1701442F4;
	Tue,  3 Dec 2024 02:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GG/68Zc3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2031D5A7AA
	for <bpf@vger.kernel.org>; Tue,  3 Dec 2024 02:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733193290; cv=none; b=NfQzQt+0vGsymTWGydwihR7KZeiyjeW8rT+X9wPb7iyBsAOjX82C18CLpD28olWzJ8p1hg2cKgcFHhuqk3zu6g3dZKprxLjeldqQ2XUofYF+LSpHYJa7CfNoVIquroN49FhOZXY/QPebGtyrZS7El1yVngCtPXtH5+cLINOWkU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733193290; c=relaxed/simple;
	bh=9Kkzk4MOipH5nDH8PY29alsZgQk5hHP6dDW5lL1nFH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipw9z09Ni8OKpNQX3xiSkbqpb3OxF2jBYuaZaFeIFC3E/fNxZf8PbuAA0ZwcPYluHOXqIdMyhLaguT8gJSqqEBvxK4d1T+Svn7rngSsymHFbBHndTbPetp7raf/bfnDKRdiqHsuUOSIDggnYDV/1YrA7bDOEKPNDikCjO/xe5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GG/68Zc3; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-385de9f789cso2665399f8f.2
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 18:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733193287; x=1733798087; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z7NDmMk8xSt/lpqNGt/4V08+c+zNqad+A5DegSvRxb4=;
        b=GG/68Zc3Llq8ADRE7M9Q8Pq4Uj8kMCLJYVkuKWjydjm6y91pZ1XWPdcKfUg/49tDAL
         ueR55G9K8Xn0K6dtpvYd6TiioZEnuU+eT06/ueGqbvOJys9MhC69vOG1FoaHZDSGoi6S
         kpEIzrv1Buj8nQdwLFrad6l2/XXAXI+JoKz0mSCXL/yRuNQRFYRuBHKs5n+e22KoBUMY
         JLyvSvxikRfMLmm0B5Xf/kUSK5JxMowdBv7RLa/a/Ai5F9OgH9jQNNsLUeziXmJanMBW
         oAOpOj8beS8Lud8qVUtEIXiPGtfuQF1tPPenYjBhyXP+PoYKHcw0XS8+ZDI8DHgpUZPh
         5iXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733193287; x=1733798087;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z7NDmMk8xSt/lpqNGt/4V08+c+zNqad+A5DegSvRxb4=;
        b=snkSvlfRPvEd07fDdmJ18YZOihod/cvTTCYPHb5zMmpiMhFjFr5EZHwqi7+YudEEeY
         Z+r4w22ac9AryCw2FilyYVY+MvQFatscHhT4qX9LN+m5z3ht/Olbhwvc4jBatC0gmHA+
         WWlXaX3ge8yRBnJJhFhplIQ1VlTByttxpO+BBQEo3fGhOj6VNb9/8KdjMlWZQi7g6FA9
         VaoKkvskp5y1KmaT1IR+MqWzpzdb0azv9aHwZ6Luy36x5bjZ3gVNnvcr7rtV6k9W5tr3
         fUyMpjGe1f96MRDpf678yTVIKSxb6IuVN/AnkCQ6Z8ewvfFNqWHXT0loq2HAFUn9xKP/
         7xDQ==
X-Gm-Message-State: AOJu0YyTUtiP91E9L1lbfPXbu8Bn9GVqJPi1JvqT7J1gmEzpA58XSBxP
	BaRSaREBawzL1lbZiYZLxUzubjeOXtkCReazvcNObpWLj8pIMjIrE5as9YwrB/c6WovRKrueXrA
	QBe9YN49CLrgcMIBkEQWxraW770iRI/3f
X-Gm-Gg: ASbGncu+gSrB9Q6LzLtuAw8XMUTB2VqQYWJfqqotMI/wKs+jwAZyj409uexAZfgilB0
	ekNZOEor515dd+gennxrT/Bvut/KQ8hHvXRJ0TRf/4T1YSYU=
X-Google-Smtp-Source: AGHT+IHn7nMU/dBUdNvdmC0ngIjmE2mQOtDU37La+iDkzHo3LGI9JGBnJXxgII+2L8v1lnaIuPiZPYWwiwXreoXXboc=
X-Received: by 2002:a05:6000:2c5:b0:385:ddd2:6ab7 with SMTP id
 ffacd0b85a97d-385fd433581mr572807f8f.52.1733193287320; Mon, 02 Dec 2024
 18:34:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241129132813.1452294-1-aspsk@isovalent.com> <20241129132813.1452294-5-aspsk@isovalent.com>
In-Reply-To: <20241129132813.1452294-5-aspsk@isovalent.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 2 Dec 2024 18:34:35 -0800
Message-ID: <CAADnVQJgYEiMbtPStOwGJLV4Dt1yj98Hy73-FEnDVh6a2be++w@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/7] libbpf: prog load: allow to use fd_array_cnt
To: Anton Protopopov <aspsk@isovalent.com>
Cc: bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 29, 2024 at 5:29=E2=80=AFAM Anton Protopopov <aspsk@isovalent.c=
om> wrote:
>
> Add new fd_array_cnt field to bpf_prog_load_opts
> and pass it in bpf_attr, if set.
>
> Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
> ---
>  tools/lib/bpf/bpf.c      | 5 +++--
>  tools/lib/bpf/bpf.h      | 5 ++++-
>  tools/lib/bpf/features.c | 2 +-
>  3 files changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index becdfa701c75..0e7f59224936 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -105,7 +105,7 @@ int sys_bpf_prog_load(union bpf_attr *attr, unsigned =
int size, int attempts)
>   */
>  int probe_memcg_account(int token_fd)
>  {
> -       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_token_f=
d);
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, fd_array_cnt=
);

Thankfully this function doesn't set fd_array_cnt below.
Otherwise the detection of memcg would fail on older kernels.
Let's avoid people mindlessly adding init of fd_array_cnt here by accident.
Simply keep this line as-is.
offsetofend(.., prog_token_fd) is fine.

>         struct bpf_insn insns[] =3D {
>                 BPF_EMIT_CALL(BPF_FUNC_ktime_get_coarse_ns),
>                 BPF_EXIT_INSN(),
> @@ -238,7 +238,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>                   const struct bpf_insn *insns, size_t insn_cnt,
>                   struct bpf_prog_load_opts *opts)
>  {
> -       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_token_f=
d);
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, fd_array_cnt=
);
>         void *finfo =3D NULL, *linfo =3D NULL;
>         const char *func_info, *line_info;
>         __u32 log_size, log_level, attach_prog_fd, attach_btf_obj_fd;
> @@ -311,6 +311,7 @@ int bpf_prog_load(enum bpf_prog_type prog_type,
>         attr.line_info_cnt =3D OPTS_GET(opts, line_info_cnt, 0);
>
>         attr.fd_array =3D ptr_to_u64(OPTS_GET(opts, fd_array, NULL));
> +       attr.fd_array_cnt =3D OPTS_GET(opts, fd_array_cnt, 0);
>
>         if (log_level) {
>                 attr.log_buf =3D ptr_to_u64(log_buf);
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index a4a7b1ad1b63..435da95d2058 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -107,9 +107,12 @@ struct bpf_prog_load_opts {
>          */
>         __u32 log_true_size;
>         __u32 token_fd;
> +
> +       /* if set, provides the length of fd_array */
> +       __u32 fd_array_cnt;
>         size_t :0;
>  };
> -#define bpf_prog_load_opts__last_field token_fd
> +#define bpf_prog_load_opts__last_field fd_array_cnt
>
>  LIBBPF_API int bpf_prog_load(enum bpf_prog_type prog_type,
>                              const char *prog_name, const char *license,
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 760657f5224c..5afc9555d9ac 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c
> @@ -22,7 +22,7 @@ int probe_fd(int fd)
>
>  static int probe_kern_prog_name(int token_fd)
>  {
> -       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_token_f=
d);
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, fd_array_cnt=
);

Same here. Don't change it.


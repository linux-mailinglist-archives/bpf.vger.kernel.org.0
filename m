Return-Path: <bpf+bounces-53916-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BA4EA5E3C7
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 19:40:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90B92177ECD
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 18:40:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3C42528E3;
	Wed, 12 Mar 2025 18:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JEBIXeeC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349D81662F1
	for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 18:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741804835; cv=none; b=sj4bZx+vyeFcJePO2+xs0KvFAUDRCtoTMYNztJW/HvHK1LfutNy/1GUnekZMSzwA1WJ2LfrH2Tez96OCZWdaQHydwD/qe6nImo683kTdlsNTiOjH6JwibmEQkklWPpuNhARn83g1Pm6CdPolpkVJvt+2pMtJNP0bfkDUXC5eoLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741804835; c=relaxed/simple;
	bh=H7uf6iTKILX8EUUZh9JtjoyC1WyqAbJLYXI+SZNR/Nk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Q7Ufp2Q19IVxY6eE9PEV+mS/GD5W4EAjQhHOO2gswcSBLucabPfc7qxh7n/2MTTFcMyBS6Na1hNrpg3f0JPEWT3U0K445SAzU91p73S8FGrPzHG/9TUh11zTjac2DJp2bLKW1HVnVj/lYOnL3+0wc1GBnTR5vR+6v5WthZMb+VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JEBIXeeC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22337bc9ac3so3500025ad.1
        for <bpf@vger.kernel.org>; Wed, 12 Mar 2025 11:40:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741804833; x=1742409633; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cpisDlTv9hih3Q/34WOT/MAw8em+i5EtxVg9Tzee7/E=;
        b=JEBIXeeCnJTPJwXjUI8zN4ef8FgMmupn0bIJOWjoikrWo6cUXJWoRYoCJ1b/mk7dkI
         JWivJrEDh3Jlw1l8ZzlsNzkngVtobGFOLzq2GaMBaUEGJgTKiCLtXMvV5iVOreP32TdD
         XmUz1RRjAQwQO/ipsgf/a2KKH4n3Wj+rxMe5h2f8nopZMfdZ1sF8TIHH8ssDH7IVpLM+
         dFouEm89XKUjEs+aRWJHzyA1hefCJ8JJ5V9zPLOOxnCfNeiVKybIbLxNCg8HRQXQ3QDY
         fJ/4qa2cygd36l9iUiYr9B11dg9VqEiRTp+vB7ihm6d3FGxewIS/WVigvK5EYYtXBP6E
         hq7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741804833; x=1742409633;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cpisDlTv9hih3Q/34WOT/MAw8em+i5EtxVg9Tzee7/E=;
        b=H2Hlozy5c2dzvfPCqSmCKrkDTAHbSy0nk+E7CikCSNeG3D4BgIj9DK4WEO13a1ZmH6
         kPuBiEMCqJwXp2Q+RTe8B1fcwvaWZElGu6iviZQZSPB38IcTfKNXTKeCN5eHCf//MbZy
         6c80fvs9R4YF/+4wRk8y1VBrSKHt89c3lqpHlnFuE+0T/m4eGuZlWg47TsQnzURsrgsD
         cgn1FhDfeyPev1dgLEmFeq11NFgjsiePs4gX+C6ak4IVHoStJNCVPxZBC+wpmj+DmeFU
         yMypP+BeSDa/piZkIzrQGH9Ve2yJQiqTpw/AJUg/WoY+PrgmOEWYSpDuTXNK1C1hhYZ7
         jCiA==
X-Gm-Message-State: AOJu0Ywv1wpIAiLk5eBrRc53Ckhn3nzZCF80e3QGeVmTt9Viv7EVvVli
	Wa4TwP0smPVOy1JfCU2rHrzi20ZLp8GOyjyiF/KXf3hYuGOKXckk+QmL+1+Z5Snig4yKGRy7jVB
	MRm/JQCFqIZn3G+O9hGT5fS1Zn64=
X-Gm-Gg: ASbGncspiHTD5vl+mLVAD6s1nYijYcgOaVeUXrP6VE9J9poWxqYKO8jJoB3Btwci7uR
	qDtz1tTlss7vpTG5kFksHjvUZqIWHvlOZdRbOsuNgLF8Xjr2eolF+MPkMoxn0MiBUMN3uAkJoin
	BrBwdqvURT3Xr379Xre8BcHzBBGrGnLXU3eGEgcbOUiw==
X-Google-Smtp-Source: AGHT+IHLNHs+aGpz7XL64Z2ML1iBMJAz8k5BOHsb5xZwiCjTihp0jYaW6ArvoqZp3aEtQtKBwppmSd7mCwcv6/nA1Pk=
X-Received: by 2002:a17:902:d483:b0:223:35cb:e421 with SMTP id
 d9443c01a7336-225931af172mr106520635ad.49.1741804833345; Wed, 12 Mar 2025
 11:40:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250312010358.3468811-1-linux@jordanrome.com>
In-Reply-To: <20250312010358.3468811-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 12 Mar 2025 11:40:21 -0700
X-Gm-Features: AQ5f1Jrl2d-wLyTXsEwbf5CBYROHoBoaa2ZKrb5BH0wTaHRNmWnI4qvx4rGJb3M
Message-ID: <CAEf4Bzb_TqinCgS92ehz8p00PQ=Z3U-8cTKBn9gfDu0Dh4EcNg@mail.gmail.com>
Subject: Re: [bpf-next v4] bpf: adjust btf load error logging
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 11, 2025 at 6:04=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> For kernels where btf is not mandatory
> we should log loading errors with `pr_info`
> and not retry where we increase the log level
> as this is just added noise.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  tools/lib/bpf/btf.c             | 36 ++++++++++++++++++---------------
>  tools/lib/bpf/libbpf.c          |  3 ++-
>  tools/lib/bpf/libbpf_internal.h |  2 +-
>  3 files changed, 23 insertions(+), 18 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index eea99c766a20..7da4807451bb 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1379,9 +1379,10 @@ static void *btf_get_raw_data(const struct btf *bt=
f, __u32 *size, bool swap_endi
>
>  int btf_load_into_kernel(struct btf *btf,
>                          char *log_buf, size_t log_sz, __u32 log_level,
> -                        int token_fd)
> +                        int token_fd, bool btf_mandatory)
>  {
>         LIBBPF_OPTS(bpf_btf_load_opts, opts);
> +       enum libbpf_print_level print_level;
>         __u32 buf_sz =3D 0, raw_size;
>         char *buf =3D NULL, *tmp;
>         void *raw_data;
> @@ -1435,22 +1436,25 @@ int btf_load_into_kernel(struct btf *btf,
>
>         btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
>         if (btf->fd < 0) {
> -               /* time to turn on verbose mode and try again */
> -               if (log_level =3D=3D 0) {
> -                       log_level =3D 1;
> -                       goto retry_load;
> +               if (btf_mandatory) {
> +                       /* time to turn on verbose mode and try again */
> +                       if (log_level =3D=3D 0) {
> +                               log_level =3D 1;
> +                               goto retry_load;
> +                       }
> +                       /* only retry if caller didn't provide custom log=
_buf, but
> +                        * make sure we can never overflow buf_sz
> +                        */
> +                       if (!log_buf && errno =3D=3D ENOSPC && buf_sz <=
=3D UINT_MAX / 2)

Original behavior was to go from log_level 0 to log_level 1 when the
user provided custom log_buf, which would happen even for
non-btf_mandatory case. I'd like to not change that behavior.

Did you find some problem with the code I proposed a few emails back?
If not, why not do that instead and preserve that custom log_buf and
log_level upgrade behavior?

pw-bot: cr

> +                               goto retry_load;
>                 }
> -               /* only retry if caller didn't provide custom log_buf, bu=
t
> -                * make sure we can never overflow buf_sz
> -                */
> -               if (!log_buf && errno =3D=3D ENOSPC && buf_sz <=3D UINT_M=
AX / 2)
> -                       goto retry_load;
> -
>                 err =3D -errno;
> -               pr_warn("BTF loading error: %s\n", errstr(err));
> -               /* don't print out contents of custom log_buf */
> -               if (!log_buf && buf[0])
> -                       pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END BT=
F LOAD LOG --\n", buf);
> +               print_level =3D btf_mandatory ? LIBBPF_WARN : LIBBPF_INFO=
;
> +               __pr(print_level, "BTF loading error: %s\n", errstr(err))=
;
> +               if (!log_buf && log_level)
> +                       __pr(print_level,
> +                            "-- BEGIN BTF LOAD LOG ---\n%s\n-- END BTF L=
OAD LOG --\n",
> +                            buf);
>         }
>
>  done:
> @@ -1460,7 +1464,7 @@ int btf_load_into_kernel(struct btf *btf,
>
>  int btf__load_into_kernel(struct btf *btf)
>  {
> -       return btf_load_into_kernel(btf, NULL, 0, 0, 0);
> +       return btf_load_into_kernel(btf, NULL, 0, 0, 0, true);
>  }
>
>  int btf__fd(const struct btf *btf)
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8e32286854ef..2cb3f067a12e 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -3604,9 +3604,10 @@ static int bpf_object__sanitize_and_load_btf(struc=
t bpf_object *obj)
>                  */
>                 btf__set_fd(kern_btf, 0);
>         } else {
> +               btf_mandatory =3D kernel_needs_btf(obj);
>                 /* currently BPF_BTF_LOAD only supports log_level 1 */
>                 err =3D btf_load_into_kernel(kern_btf, obj->log_buf, obj-=
>log_size,
> -                                          obj->log_level ? 1 : 0, obj->t=
oken_fd);
> +                                          obj->log_level ? 1 : 0, obj->t=
oken_fd, btf_mandatory);
>         }
>         if (sanitize) {
>                 if (!err) {
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_inter=
nal.h
> index de498e2dd6b0..f1de2ba462c3 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -408,7 +408,7 @@ int libbpf__load_raw_btf(const char *raw_types, size_=
t types_len,
>                          int token_fd);
>  int btf_load_into_kernel(struct btf *btf,
>                          char *log_buf, size_t log_sz, __u32 log_level,
> -                        int token_fd);
> +                        int token_fd, bool btf_mandatory);
>
>  struct btf *btf_get_from_fd(int btf_fd, struct btf *base_btf);
>  void btf_get_kernel_prefix_kind(enum bpf_attach_type attach_type,
> --
> 2.47.1
>


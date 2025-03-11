Return-Path: <bpf+bounces-53776-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51306A5B17D
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 01:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CF9FA18863AA
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 00:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75FAF1876;
	Tue, 11 Mar 2025 00:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GVdN/RA6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8572E2F5E
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 00:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741651809; cv=none; b=VliVHl3bQ9gWM3NCaKnMtO2TnreN3gLsPHDG1/pqcYP/RyHdIxlMyE1R/fehaRtKPIaF8u2FhyhtU6L6iPB6snrF/APYWfQU4GAoF5Jr6TsjE6AYfaLkDj28EhMxZBe8OUMd3cAqpXv94tCLgY0CGJy76hFpBdnWa/ZDBEcg0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741651809; c=relaxed/simple;
	bh=Rj0rRuyYZJgCGm+JR66FkbSAzIR0yiB+MNFJLCr1WrM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y209dr5HCNVF+3xvrPnmyfIrFTakAYoI3EaN1Y25FJL7qUihZZWxGAwWl9mZN0A8CzTcg/1nTCcwXnuGRM/Ls3FEYlMG0jhLrDqzY041mIE2JfDQ09y4xekBfGy6ou0FD29zQHLghCV6SHUYhPcOHQyKj3lkR4PLBOEgmIrTXHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GVdN/RA6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2fee05829edso9567382a91.3
        for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 17:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741651807; x=1742256607; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0AZYxd74wYFMcu+xhiTGydX/thBxa5tymqwvGpltYAw=;
        b=GVdN/RA6dWUneBtaHHaOxH7+r9i73RZMyO485TUhnuK2elGK30UvEYKIJkP2X3c3mq
         gcTMsKC80G1hovtHazKuY0OD3S1N86i8/OWz8yj4NKAGfN3Z8BVuGrMMivdWM3l0gXzg
         0xRw02p8AqMm0oUdEMkhLEQeRYGZwJMY2akh3tWTjcsT44qEVF3rfxotbRDA6DMXSHAO
         r8Z3VvrHErqrUih7qmVMfkVdpehuAv7su/AbJzjU0Q8sMQVqNwKKQOOhXXntR5NNovQG
         +XShSj3RVBvDQxHpcJfm/Xlddh95teU6UKFSRtm6OJmYXOXUFIf5GKcvOove/h77Ophu
         A9vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741651807; x=1742256607;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0AZYxd74wYFMcu+xhiTGydX/thBxa5tymqwvGpltYAw=;
        b=RwUQlGRoOZk/RREmJABwm2Zi1Iga5RlgqgPX/jgq5YlLDowQP/OoSgRq+LBylky+u1
         eOvH9pQ78bOxq9vqsrtIe1dISAqmcnOJtol67TTCJ/81ql/Fj9A/Li7g3VfsmU5ZP7Rn
         Q3m6VWiy0URAhA9cw54Nkn7887YSaaC0TaqvnFu/WOBVEaTryWY542qmwXwN+lYcIQ+F
         rkg5/WhdJOMqlogG66yK9hAFx2OM34BhnDrq4Xh+xSOxpVesFgnF7tMnhMFlxeUf0AA0
         X0CSShVsnaN4ZjP9JGGDtp0dC4hwR61ru7e4EvTA5z7dVgjkq9hXJU8v6yshP/RIBmaL
         A2DQ==
X-Gm-Message-State: AOJu0YwZaYztMbfNfwLdXVhLBHQmqs+wx8lRb8/AqpRTUMhgLX4urX1c
	jz60LntraJR61IMuMTL7yDIRq16qw9+mIKUI60/gqIQPbRidXIkx7hur0xxnl85SjseH+/5WiEL
	cfkfE76ybaeCmlVXrVS2SuAY70FE=
X-Gm-Gg: ASbGncuzE/rQ0mockZ2yY/MJyzwYMmR5e3UWZOFqYfYd/2CK519nVVeygw0qvT4PKxY
	rqhtNAUOUYJjy9i/CLxY6ZPws5aXGKOQwKF6cwXDtN768gNCR/p1RwFBuYRwCCL+PSxgSYQF/aK
	DC9fSVd+imWL8WXOGkYUoMts4JMyqub6LZNpHjDHB45A==
X-Google-Smtp-Source: AGHT+IHn3PUXu+T7RXF+sThhc2DMuaeHLyAc4fPIOwU0W92w1WcTlWd4dXy/fbqQUziYEOOH0zfty0m1jb3d4zOLpZ8=
X-Received: by 2002:a17:90b:3804:b0:2ee:edae:75e with SMTP id
 98e67ed59e1d1-2ff7ce77a3fmr24548933a91.13.1741651806662; Mon, 10 Mar 2025
 17:10:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250307150016.2172675-1-linux@jordanrome.com>
In-Reply-To: <20250307150016.2172675-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 10 Mar 2025 17:09:54 -0700
X-Gm-Features: AQ5f1Joz3RDoj3MNnb_HTThkQzfnH1z2H7U1LyIibiZTiXh-vL_Y9_ADL0n9Xms
Message-ID: <CAEf4BzbEPm22eV=LFvJTkMp0OQeScp2MnKT4oy7RPdygmcqdvg@mail.gmail.com>
Subject: Re: [bpf-next v3] bpf: adjust btf load error logging
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 7, 2025 at 7:00=E2=80=AFAM Jordan Rome <linux@jordanrome.com> w=
rote:
>
> For kernels where btf is not mandatory
> we should log loading errors with `pr_info`
> and not retry where we increase the log level
> as this is just added noise.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  tools/lib/bpf/btf.c             | 16 ++++++++++++----
>  tools/lib/bpf/libbpf.c          |  3 ++-
>  tools/lib/bpf/libbpf_internal.h |  2 +-
>  3 files changed, 15 insertions(+), 6 deletions(-)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index eea99c766a20..c8139c3bc9e0 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -1379,7 +1379,7 @@ static void *btf_get_raw_data(const struct btf *btf=
, __u32 *size, bool swap_endi
>
>  int btf_load_into_kernel(struct btf *btf,
>                          char *log_buf, size_t log_sz, __u32 log_level,
> -                        int token_fd)
> +                        int token_fd, bool btf_mandatory)
>  {
>         LIBBPF_OPTS(bpf_btf_load_opts, opts);
>         __u32 buf_sz =3D 0, raw_size;
> @@ -1435,6 +1435,15 @@ int btf_load_into_kernel(struct btf *btf,
>
>         btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
>         if (btf->fd < 0) {
> +               if (!btf_mandatory) {
> +                       err =3D -errno;
> +                       pr_info("BTF loading error: %s\n", errstr(err));
> +
> +                       if (!log_buf && log_level)
> +                               pr_info("-- BEGIN BTF LOAD LOG ---\n%s\n-=
- END BTF LOAD LOG --\n", buf);

I'm not a fan of duplicating this. Wouldn't something along the
following lines work as well?

diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
index eea99c766a20..fc06f3a8e8d7 100644
--- a/tools/lib/bpf/btf.c
+++ b/tools/lib/bpf/btf.c
@@ -1436,18 +1436,19 @@ int btf_load_into_kernel(struct btf *btf,
        btf->fd =3D bpf_btf_load(raw_data, raw_size, &opts);
        if (btf->fd < 0) {
                /* time to turn on verbose mode and try again */
-               if (log_level =3D=3D 0) {
+               if (log_level =3D=3D 0 && (log_buf || btf_mandatory)) {
                        log_level =3D 1;
                        goto retry_load;
                }
                /* only retry if caller didn't provide custom log_buf, but
                 * make sure we can never overflow buf_sz
                 */
-               if (!log_buf && errno =3D=3D ENOSPC && buf_sz <=3D UINT_MAX=
 / 2)
+               if (!log_buf && btf_mandatory && errno =3D=3D ENOSPC &&
buf_sz <=3D UINT_MAX / 2)
                        goto retry_load;

                err =3D -errno;
-               pr_warn("BTF loading error: %s\n", errstr(err));
+               __pr(btf_mandatory ? LIBBPF_WARN : LIBBPF_INFO,
+                    "BTF loading error: %s\n", errstr(err));
                /* don't print out contents of custom log_buf */
                if (!log_buf && buf[0])
                        pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END
BTF LOAD LOG --\n", buf);


pw-bot: cr

> +                       goto done;
> +               }
> +
>                 /* time to turn on verbose mode and try again */
>                 if (log_level =3D=3D 0) {
>                         log_level =3D 1;
> @@ -1448,8 +1457,7 @@ int btf_load_into_kernel(struct btf *btf,
>
>                 err =3D -errno;
>                 pr_warn("BTF loading error: %s\n", errstr(err));
> -               /* don't print out contents of custom log_buf */
> -               if (!log_buf && buf[0])
> +               if (!log_buf && log_level)
>                         pr_warn("-- BEGIN BTF LOAD LOG ---\n%s\n-- END BT=
F LOAD LOG --\n", buf);
>         }
>
> @@ -1460,7 +1468,7 @@ int btf_load_into_kernel(struct btf *btf,
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
> 2.43.5
>


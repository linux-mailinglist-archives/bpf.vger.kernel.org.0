Return-Path: <bpf+bounces-68591-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A79CB7C472
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84E65320764
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 00:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4D31388;
	Wed, 17 Sep 2025 00:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FpRcfl/s"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095CD1401B
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 00:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758067626; cv=none; b=bKgT351kbOOs5ARVIsrrHrmotQtcSweCHDCxnXikuYGzCFcjMV6bbzaOHpn5+6II1FcAW6P9/bHOXzrY1guziqOHoFEyKunh7bp/OMAVFNO1oThtaqPt9FgXY69F+7gIPYHl3ATnMx2veZoTZDjr1CWAcq35ZUXcfICuodHmfFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758067626; c=relaxed/simple;
	bh=HCeRv0Or0f0aOF1ZLssA9bcpaWccFF3WqcL9lsbgK44=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ec2GgJWOHi671gg9scZA67vnDn6+6yGjkpYY4qFZLyLnCi9VQOyuXEKP5T8pD554ZhiXks8sNfHRod1fofMNyze9jfiDgdDfmfyFGyzI2pw5mmLjiI9o4NYiyqU1guFht03sZsUMN5yaW+Z5ahFgbf8ek4giP+APM42QSf35k1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FpRcfl/s; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-77796ad4c13so2056840b3a.0
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 17:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758067624; x=1758672424; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iA4QV5hklHLXLXYUDGSkY2qtyBTqduDwWoHo3KHFJxE=;
        b=FpRcfl/sQrJKzOXbnUfTfyxIHJZRe3TvuxXjUriJlhKx0yxXw3fbYzp6v55OHgFuLc
         A7kwG5Ewlzk3RrG1NidB6hTSTQuy0xIBcLw3a4DUXBL2n8ku+ZZXoeNY7PepLiAuovlK
         AFbiGCbnw12vVBt0lqN25FyswiEYyVQVP++9XSy+sdF41EbW8vPxXJhTIYMlFaIIYCBi
         BagoZ6aSxCO//oXnHvIT7fKJOuzVgaPxEzFn/L3BlDJkeTlowM16zxh49zMmzg1gy9+R
         4PlMPv2jNb16DeaTQ1NsVf2ryA+T3JcPU4faf148Z9oaPWaUV9IMezdROEC+hOw2PYNb
         XCNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758067624; x=1758672424;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iA4QV5hklHLXLXYUDGSkY2qtyBTqduDwWoHo3KHFJxE=;
        b=LVKPV1FRoxQwSAgIhXxnLjqqIBTzDu/aAYg/E/nspL8XyYJ6w9KO2KBtbnKH6dOpsw
         7L4TedqJt0NPCfzzGJ01KLksPZj4a/3fKe9Rq+QrwTFZFVyuKtquY/gYVraS5TyK7vvo
         dzO0R6ANrwMR9iW/D9bGRtmM8xT7lq0bepZ44ZSwHTJMIS3dr9FzfJdceKkshG38jN6u
         g3rdhuZIi9PL36PLZSuJN21kwYX+K/58ZeyAKB1ae7GtUuJeMRsy9d1rfhcTrMHuSk86
         OABfzWXuYD0tHJtwujHoivuAhp3hlR9rZlOce1MqIqjo6wZTceH5wY+SyVwpDNJJsQdl
         lS4Q==
X-Gm-Message-State: AOJu0YwjnSbaZtidjT6TeGhWLMppM09E+R3TF4nbiqaJYt0V+yd+FmPi
	n5/COD7IST5VfoavSfQHlRqLka/ZNfz9L30A/O2utF6bpI/x7g1uM8EVf/PF8446a2Osm6lcZ8u
	Q0Eu/K+RGNZJh3aJ0+NLSJ6iYS85kkjU=
X-Gm-Gg: ASbGncuQTNGScyUfXkpshF9HiHPoYcEIhqytztJfwv17ZvwH8JJSpzLrXmimxXnIddd
	G3WGhoLAuslS5/YG71dVvkZxPb9n5DRqNl5sMNNB49p6ACKVJ9+Baxk9C+8VbetXmW1AB3tS7uf
	G1J5bubSxElLB3wGzFdU3XZG2Tca7tnL/pWJlyZo/sHJ1d+z3YYgckGzu2Y88ck757pu9Eisty/
	A4jutX0NjaalxxX/GyDtBQ=
X-Google-Smtp-Source: AGHT+IHGXUgypyMzv4Ao1EN569bx7WpDECGDbXTtG5XUrlelFcQvnRAx4oLwBlaubm7QUSZPFPLFmqFzUdHwF0RLzYI=
X-Received: by 2002:a05:6a20:734f:b0:243:78a:8273 with SMTP id
 adf61e73a8af0-27aabb44fd2mr124209637.57.1758067624408; Tue, 16 Sep 2025
 17:07:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250911163328.93490-1-leon.hwang@linux.dev> <20250911163328.93490-3-leon.hwang@linux.dev>
In-Reply-To: <20250911163328.93490-3-leon.hwang@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 17:06:39 -0700
X-Gm-Features: AS18NWCLzcPeFwsE7JzvK92GBE-lIXoqMaVB0hTksNsszHN2NE-OJX7t2lfU3Fo
Message-ID: <CAEf4BzZp8vb3EYwvSCbewdZi0eKZjW5sJkDnm6YfPqaRbjf2NA@mail.gmail.com>
Subject: Re: [RFC PATCH bpf-next v2 2/6] libbpf: Add support for extended bpf syscall
To: Leon Hwang <leon.hwang@linux.dev>
Cc: bpf@vger.kernel.org, ast@kernel.org, andrii@kernel.org, 
	daniel@iogearbox.net, menglong8.dong@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 11, 2025 at 9:33=E2=80=AFAM Leon Hwang <leon.hwang@linux.dev> w=
rote:
>
> To support the extended 'bpf()' syscall introduced in the previous commit=
,
> this patch adds the following APIs:
>
> 1. *Internal:*
>
>    * 'sys_bpf_extended()'
>    * 'sys_bpf_fd_extended()'
>      These wrap the raw 'syscall()' interface to support passing extended
>      attributes.
>
> 2. *Exported:*
>
>    * 'probe_sys_bpf_extended()'
>      This function checks whether the running kernel supports the extende=
d
>      'bpf()' syscall with common attributes.
>
> Signed-off-by: Leon Hwang <leon.hwang@linux.dev>
> ---
>  tools/lib/bpf/bpf.c             | 45 +++++++++++++++++++++++++++++++++
>  tools/lib/bpf/bpf.h             |  1 +
>  tools/lib/bpf/features.c        |  8 ++++++
>  tools/lib/bpf/libbpf.map        |  2 ++
>  tools/lib/bpf/libbpf_internal.h |  2 ++
>  5 files changed, 58 insertions(+)
>

(ran out of time, will continue reviewing the rest of patches
tomorrow, so please don't yet send new revision)

> diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> index ab40dbf9f020f..27845e287dd5c 100644
> --- a/tools/lib/bpf/bpf.c
> +++ b/tools/lib/bpf/bpf.c
> @@ -69,6 +69,51 @@ static inline __u64 ptr_to_u64(const void *ptr)
>         return (__u64) (unsigned long) ptr;
>  }
>
> +static inline int sys_bpf_extended(enum bpf_cmd cmd, union bpf_attr *att=
r,
> +                                  unsigned int size,
> +                                  struct bpf_common_attr *common_attrs,
> +                                  unsigned int size_common)
> +{
> +       cmd =3D common_attrs ? cmd | BPF_COMMON_ATTRS : cmd & ~BPF_COMMON=
_ATTRS;
> +       return syscall(__NR_bpf, cmd, attr, size, common_attrs, size_comm=
on);
> +}
> +
> +static inline int sys_bpf_fd_extended(enum bpf_cmd cmd, union bpf_attr *=
attr,

please shorten to sys_bpf_ext() and sys_bpf_ext_fd() (also note ext before =
fd)


> +                                     unsigned int size,
> +                                     struct bpf_common_attr *common_attr=
s,
> +                                     unsigned int size_common)
> +{
> +       int fd;
> +
> +       fd =3D sys_bpf_extended(cmd, attr, size, common_attrs, size_commo=
n);
> +       return ensure_good_fd(fd);
> +}
> +
> +int probe_sys_bpf_extended(int token_fd)
> +{
> +       const size_t attr_sz =3D offsetofend(union bpf_attr, prog_token_f=
d);
> +       struct bpf_common_attr common_attrs;
> +       struct bpf_insn insns[] =3D {
> +               BPF_MOV64_IMM(BPF_REG_0, 0),
> +               BPF_EXIT_INSN(),
> +       };
> +       union bpf_attr attr;
> +
> +       memset(&attr, 0, attr_sz);
> +       attr.prog_type =3D BPF_PROG_TYPE_SOCKET_FILTER;
> +       attr.license =3D ptr_to_u64("GPL");
> +       attr.insns =3D ptr_to_u64(insns);
> +       attr.insn_cnt =3D (__u32)ARRAY_SIZE(insns);
> +       attr.prog_token_fd =3D token_fd;
> +       if (token_fd)
> +               attr.prog_flags |=3D BPF_F_TOKEN_FD;
> +       libbpf_strlcpy(attr.prog_name, "libbpf_sysbpftest", sizeof(attr.p=
rog_name));
> +       memset(&common_attrs, 0, sizeof(common_attrs));
> +
> +       return sys_bpf_fd_extended(BPF_PROG_LOAD, &attr, attr_sz, &common=
_attrs,
> +                                  sizeof(common_attrs));

I think we can set up this feature detector such that we get -EINVAL
due to BPF_COMMON_ATTRS not supported on old kernels, while -EFAULT on
newer kernels due to NULL passed in common_attrs. This would be cheap
and simple. Try it.

> +}
> +
>  static inline int sys_bpf(enum bpf_cmd cmd, union bpf_attr *attr,
>                           unsigned int size)
>  {
> diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> index 7252150e7ad35..38819071ecbe7 100644
> --- a/tools/lib/bpf/bpf.h
> +++ b/tools/lib/bpf/bpf.h
> @@ -35,6 +35,7 @@
>  extern "C" {
>  #endif
>
> +LIBBPF_API int probe_sys_bpf_extended(int token_fd);

why adding this as a public UAPI?

>  LIBBPF_API int libbpf_set_memlock_rlim(size_t memlock_bytes);
>
>  struct bpf_map_create_opts {
> diff --git a/tools/lib/bpf/features.c b/tools/lib/bpf/features.c
> index 760657f5224c2..a63172c6343d0 100644
> --- a/tools/lib/bpf/features.c
> +++ b/tools/lib/bpf/features.c

[...]


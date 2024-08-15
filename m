Return-Path: <bpf+bounces-37335-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52831953D5C
	for <lists+bpf@lfdr.de>; Fri, 16 Aug 2024 00:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0F8E2885D2
	for <lists+bpf@lfdr.de>; Thu, 15 Aug 2024 22:39:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48E4D154C12;
	Thu, 15 Aug 2024 22:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XNqJK0wc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C81014D2B8
	for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 22:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723761541; cv=none; b=SqaQAqWAbJij2lpdr3MrgSNvBJmyhno4kGNy98O1tHzP3q3brhAgELKncQ7urIqIQ3OSYIn/x+cVwDVuml1AyVddty52phQtLcIjCTskmMwGrdRT9NZoUy9cPvJRz3N9Svh8qlpLraSBgHinRgR3KKL1b+qwnT8HI4gSeB+awNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723761541; c=relaxed/simple;
	bh=dvOIICa3Rni3/Mu0us/gAmZGSOARRYRsyqMik1AjoG0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDwolgHqfRNgtdJ5LQiyKzb3OMray41U/Edm6W/okJAvlr8XOaMsMRtbGf/yPHWrlMIclIRW9UmBEllA2+YRGUyBHGEWf4XyRCssx+GlO6+1wtKSB8zPfB4IzUyNXPRGX4YgTbStuQmVfWuHO4DxXagpugJQvH+rN6VOHHrD5WE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XNqJK0wc; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7b594936e9bso982346a12.1
        for <bpf@vger.kernel.org>; Thu, 15 Aug 2024 15:39:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723761539; x=1724366339; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e7dBRWikv9YDbO3+GK5EfbU8sO7TDxAH4mUITQxqzjo=;
        b=XNqJK0wcWpGqiJf7uh3ER1UZF/g8fifjybirq6f+IxfAS0EMDOqsHytF7E6Yi559pz
         Pyddn+RRUty2xM8Cgz5e5gle7T4Sy1vhCrQSU3s07thn6oe0fND6x4hDh8Xl1VKbnW5z
         NpbU++0jHvJbcT5n3vb426iZF3ZHG6DNsAlsTP/jJUTw9D2E1nYoTcNUbXFi35LUJ65N
         JdXJDj3pvr92KtcDovFRefgaF4FQMOyY1OeAV3CEZhB3VCgedCRUsSaynJ+LgFmIWvxt
         1xFXLrsJTNb0Wwj0951Y9kXFpKEgjMXiBvNxzrpVal36gYNsIpZgLAbh7jnDfLp5h5TL
         PeYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723761539; x=1724366339;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e7dBRWikv9YDbO3+GK5EfbU8sO7TDxAH4mUITQxqzjo=;
        b=DJOhs+997ufqahx4F8Sx3GyqfKKewSZHQoE6m8czhnzWJrt+4RiovW4KIEqWoAldj5
         +X4CIPA1cppL2VjUsuKVVT1pG6I2xmvX2v4arOBa66nZT+TmPNRyGLk53S8J0ir9j/Ib
         Jjm3G96Y5JSZjYMBN7N7Y4YJBWGlwK6IOWXgPFloHhqGfbyHHqE9Tc6V5/fz3s1eScHh
         hzphLc1TnFq//Z/5u+jQXD0qS+N3eGbv+LCg9qjqoLjly6i8wlovCg43b2oPpJoNbFya
         QXl69voraa9IilX7/6gENqiZxp6wSRCVB3ZYtaPpaof0NqEI/1IatTv4TUtuawdRSJaJ
         ECBw==
X-Gm-Message-State: AOJu0YyqZ+K4zFfJmYfl8NJtirtvvQlwkImNysU+rOI5fL742o9bLkDH
	wcOTgMKIsL9zu377ds4eQTKdYU801Xn/DpedGI746sqWOn+C9ZBED+B27O5XJxBGYBfak8m4Spf
	cXKGP1cOK8N9m6CyByG5VSGeWO6D+dhCX
X-Google-Smtp-Source: AGHT+IESU+fCHVpJELifsHDniVcJOW8VsWwCtGUseEbTnQ3L7C0qGBaE9jvQRvdGVtIK4ZjPid7p9DQKoUXAgParwAM=
X-Received: by 2002:a17:90b:19c9:b0:2cd:2992:e8dc with SMTP id
 98e67ed59e1d1-2d3dfc22128mr1271398a91.5.1723761539460; Thu, 15 Aug 2024
 15:38:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815112733.4100387-1-linux@jordanrome.com>
In-Reply-To: <20240815112733.4100387-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 15 Aug 2024 15:38:47 -0700
Message-ID: <CAEf4Bzb+W2PyvUuHixc+mTTt73zTCYBBpBwtoYmTtv++rxd4+g@mail.gmail.com>
Subject: Re: [bpf-next v5 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 15, 2024 at 4:28=E2=80=AFAM Jordan Rome <linux@jordanrome.com> =
wrote:
>
> This adds a kfunc wrapper around strncpy_from_user,
> which can be called from sleepable BPF programs.
>
> This matches the non-sleepable 'bpf_probe_read_user_str'
> helper except it includes an additional 'flags'
> param, which allows consumers to clear the entire
> destination buffer on success.
>
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>  include/uapi/linux/bpf.h       |  8 +++++++
>  kernel/bpf/helpers.c           | 41 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  8 +++++++
>  3 files changed, 57 insertions(+)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e05b39e39c3f..e207175981be 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7513,4 +7513,12 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +/*
> + * Flags to control bpf_copy_from_user_str() behaviour.
> + *     - BPF_ZERO_BUFFER: Memset 0 the tail of the destination buffer on=
 success
> + */
> +enum {
> +       BPF_ZERO_BUFFER =3D (1ULL << 0)

We call all flags BPF_F_<something>, so let's stay consistent.

And just for a bit of bikeshedding, "zero buffer" isn't immediately
clear and it would be nice to have a clearer verb in there. I don't
have a perfect name, but something like BPF_F_PAD_ZEROS or something
with "pad" maybe?

Also, should we keep behavior a bit more consistent and say that on
failure this flag will also ensure that buffer is cleared?

> +};
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d02ae323996b..fe4348679d38 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2939,6 +2939,46 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_=
iter_bits *it)
>         bpf_mem_free(&bpf_global_ma, kit->bits);
>  }
>
> +/**
> + * bpf_copy_from_user_str() - Copy a string from an unsafe user address
> + * @dst:             Destination address, in kernel space.  This buffer =
must be at
> + *                   least @dst__szk bytes long.
> + * @dst__szk:        Maximum number of bytes to copy, including the trai=
ling NUL.
> + * @unsafe_ptr__ign: Source address, in user space.
> + * @flags:           The only supported flag is BPF_ZERO_BUFFER
> + *
> + * Copies a NUL-terminated string from userspace to BPF space. If user s=
tring is
> + * too long this will still ensure zero termination in the dst buffer un=
less
> + * buffer size is 0.
> + *
> + * If BPF_ZERO_BUFFER flag is set, memset the tail of @dst to 0 on succe=
ss.
> + */
> +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const vo=
id __user *unsafe_ptr__ign, u64 flags)
> +{
> +       int ret;
> +       int count;
> +

validate that flags doesn't have any unknown flags

if (unlikely(flags & ~BPF_F_ZERO_BUFFER))
    return -EINVAL;

> +       if (unlikely(!dst__szk))
> +               return 0;
> +
> +       count =3D dst__szk - 1;
> +       if (unlikely(!count)) {
> +               ((char *)dst)[0] =3D '\0';
> +               return 1;
> +       }

Do we need to special-case this unlikely scenario? Especially that
it's unlikely, why write code for it and pay a tiny price for an extra
check?

> +
> +       ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
> +       if (ret >=3D 0) {
> +               if (flags & BPF_ZERO_BUFFER)
> +                       memset((char *)dst + ret, 0, dst__szk - ret);
> +               else
> +                       ((char *)dst)[ret] =3D '\0';
> +               ret++;

so if string is truncated, ret =3D=3D count, no? And dst[ret] will go
beyond the buffer?

we need more tests to validate all those various conditions


I'd also rewrite this a bit, so it's more linear:


ret =3D strncpy(...);
if (ret < 0)
    return ret;

((char *)dst)[count - 1] =3D '\0';

if (flags & BPF_F_ZERO_BUF)
      memset(...);

return ret < count ? ret + 1 : count;


or something along those lines


pw-bot: cr


> +       }
> +
> +       return ret;
> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3024,6 +3064,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
>  BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index e05b39e39c3f..15c2c3431e0f 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7513,4 +7513,12 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +/*
> + * Flags to control bpf_copy_from_user_str() behaviour.
> + *     - BPF_ZERO_BUFFER: Memset 0 the entire destination buffer on succ=
ess
> + */
> +enum {
> +       BPF_ZERO_BUFFER =3D (1ULL << 0)
> +};
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> --
> 2.43.5
>


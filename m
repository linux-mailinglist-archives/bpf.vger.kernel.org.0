Return-Path: <bpf+bounces-37553-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 928589577F2
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2024 00:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49728283C23
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 22:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0211DF669;
	Mon, 19 Aug 2024 22:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vh6p91+V"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF491DC481
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 22:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724107322; cv=none; b=AQgB1+QGXBVoE+EI9FYfTHuXD5X5lA5wV0ptrMsZnTm3+Fv+Ee+/2GtyJpPCcwxtkVDKfyIkIO4WINKp3rH7etjczjBPLteIdxl3hsDTFiVl5CEF1IVo+AuobIijnRw9wfP+KGty/VEU9arQbLiAc6akx9TQAb5y9iEmVRQzf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724107322; c=relaxed/simple;
	bh=GB2mSMF5JUl8l6KpX26zyfq+TAKh2H67rFXNbhb7mNQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VUCis3QjTwlrztFMLf//WWD9HygAvQKIo4jn33Z6+n3KPtSmW3eKGyVvQV2ZQqrnu8PPlGEHEoIyzmlOF/Hxq/tkzbpc6skGOccja8mMXOHddWfZS0BjjPMFmsgNG6qUofFcsKrp66fkizp3Wjm3GeS2x/SPY8U4QfiWCghTVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vh6p91+V; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-2d3b36f5366so3342173a91.0
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 15:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724107320; x=1724712120; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hLYsuQhM6b2RU1ReV3vrE8zWiYPWTVhm7xqqXtBJRu8=;
        b=Vh6p91+VSrZyeDcmmP1noSuWGVssS/fN7s0H3rQCPOdhRSzMpJIYhH60hcYPWyxn8Y
         S4azudvgoP7qSFn9HuvMW87wYTBWn9dCwGucQa/MWslkdkFLCWvQbwCzGG1OlTOXHgDW
         gFmzlVhBT/efpOhn4jJ3+1BJrebIywBfY/E+UpKWjZlTwawAmpmjhbqCyeC0BvlzaUCj
         2M8JQ1zIQ6Yc1TzY4rdh6sGFuTz3tWN0cykVEpRUro+l5JbLZWccr3Xfa1YBKV9Wp1vG
         HHTcX/emWqoHlI3iJsVk2hhPgdendhNQlhBnMQ0T6lm4+N6qAzClgsYsPPwgzdyM0Ijd
         g+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724107320; x=1724712120;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hLYsuQhM6b2RU1ReV3vrE8zWiYPWTVhm7xqqXtBJRu8=;
        b=F0mwTgjspYIfL6asKPrRPjZ5kVKTAUnFLHVUEiRbU2yn5xDSU56O3JJV6V8oZOz3oX
         3QFdsQPf4jIdRijX0u7Jtp3afy77vabn6JrpU70VUqj+GW5vJDGZWy2AcpY/LW8mfiCH
         Q1wkDulQSPN9gLFmhi4+2Cwhp8hSWow0eGmki42WS/8BARNDHCnaoVOtFQN3DTf0xzOr
         67Y4L01c5y3seDjNcf3gibkZ7CjpqbrW+aTmUllx0C6eFnr0c22nCgNFS5gbLhUJSJmW
         pjbYZ+CEePG/4D+0QZVVYBPwT+vwPI90aKqUmXgB2uokBS3Q+Cw6fmWGpUYThw+PBqE7
         hq8Q==
X-Gm-Message-State: AOJu0YztQpiBc7BwTYXP9aXnzYO/b8iSpw7YYSNSm9JMHEnlT6GwwI56
	yfkJ2Dx0F1pc+S2H/iiJLEbs/zvo+YXMxrcsj2NYvISsL6Egs7hKI+I6MTV++XTT4eFiaeMoyaj
	wmDsiF0dml/e1qb/ThHilz0uNEbk=
X-Google-Smtp-Source: AGHT+IF3ErPoQ9bh5eFN5MZQ/T9Ctcolq/pV+a7cb6ILkZmWFl7RMZusQiLAthAIVQ91G6WkkWfrGw7tEjyHjcKGE2Q=
X-Received: by 2002:a17:90a:3986:b0:2d3:ba42:775c with SMTP id
 98e67ed59e1d1-2d3dfc368e8mr11806732a91.1.1724107319776; Mon, 19 Aug 2024
 15:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240818002350.1401842-1-linux@jordanrome.com>
In-Reply-To: <20240818002350.1401842-1-linux@jordanrome.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Aug 2024 15:41:47 -0700
Message-ID: <CAEf4BzZK7+=FRFXzMMtL7-hz5YgKjbthUDae4Wh0OMTP2PqJxw@mail.gmail.com>
Subject: Re: [bpf-next v6 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Jordan Rome <linux@jordanrome.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kernel Team <kernel-team@fb.com>, sinquersw@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Aug 17, 2024 at 5:24=E2=80=AFPM Jordan Rome <linux@jordanrome.com> =
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
>  kernel/bpf/helpers.c           | 44 ++++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |  8 +++++++
>  3 files changed, 60 insertions(+)
>

LGTM overall, with the issues pointed out below:

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index e05b39e39c3f..5e6be3489e43 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -7513,4 +7513,12 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +/*
> + * Flags to control bpf_copy_from_user_str() behaviour.
> + *     - BPF_F_PAD_ZEROS: Memset 0 the tail of the destination buffer on=
 success

I suspect we might want to reuse this flag for similar kfuncs/helpers
in the future, so I'd generalize description a bit. How about
something like:

BPF_F_PAD_ZEROS: pad destination buffer with zeros. (See respective
helpers documentation for exact details.)

> + */
> +enum {
> +       BPF_F_PAD_ZEROS =3D (1ULL << 0)
> +};
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index d02ae323996b..a0d2cc8f4f3f 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2939,6 +2939,49 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct bpf_=
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
> + * @flags:           The only supported flag is BPF_F_PAD_ZEROS
> + *
> + * Copies a NUL-terminated string from userspace to BPF space. If user s=
tring is
> + * too long this will still ensure zero termination in the dst buffer un=
less
> + * buffer size is 0.
> + *
> + * If BPF_F_PAD_ZEROS flag is set, memset the tail of @dst to 0 on succe=
ss and
> + * memset all of @dst on failure.
> + */
> +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const vo=
id __user *unsafe_ptr__ign, u64 flags)
> +{
> +       int ret;
> +
> +       if (unlikely(!dst__szk))
> +               return 0;
> +
> +       if (unlikely(flags & ~BPF_F_PAD_ZEROS))
> +               return -EINVAL;
> +

let's move this up before dst__szk check, invalid flags should be
rejected regardless of dst__szk

pw-bot: cr

> +       ret =3D strncpy_from_user(dst, unsafe_ptr__ign, dst__szk - 1);
> +       if (ret < 0) {
> +               if (flags & BPF_F_PAD_ZEROS)
> +                       memset((char *)dst, 0, dst__szk);
> +
> +               return ret;
> +       }
> +
> +       if (flags & BPF_F_PAD_ZEROS)
> +               memset((char *)dst + ret, 0, dst__szk - ret);
> +       else
> +               ((char *)dst)[ret] =3D '\0';
> +
> +       ret++;
> +
> +       return ret;

nit: return ret + 1;


> +}
> +
>  __bpf_kfunc_end_defs();
>
>  BTF_KFUNCS_START(generic_btf_ids)
> @@ -3024,6 +3067,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
>  BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
>  BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
>  BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> +BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
>  BTF_KFUNCS_END(common_btf_ids)
>
>  static const struct btf_kfunc_id_set common_kfunc_set =3D {
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bp=
f.h
> index e05b39e39c3f..a8dcb99ed904 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -7513,4 +7513,12 @@ struct bpf_iter_num {
>         __u64 __opaque[1];
>  } __attribute__((aligned(8)));
>
> +/*
> + * Flags to control bpf_copy_from_user_str() behaviour.
> + *     - BPF_F_PAD_ZEROS: Memset 0 the entire destination buffer on succ=
ess
> + */
> +enum {
> +       BPF_F_PAD_ZEROS =3D (1ULL << 0)
> +};
> +
>  #endif /* _UAPI__LINUX_BPF_H__ */
> --
> 2.43.5
>


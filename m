Return-Path: <bpf+bounces-37526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00B41957026
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 18:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD9602823D4
	for <lists+bpf@lfdr.de>; Mon, 19 Aug 2024 16:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C18C1171E5F;
	Mon, 19 Aug 2024 16:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fDGeWwbR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7AF16D4EA
	for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 16:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724084721; cv=none; b=gXEUqlwjxZHQJK1V40Qf1Dpe9Z+p6I+PiOZKUkAmCxJLOdYiaxtBnrO/WOaoofPZVVdp6pKXts0ycGaXH7SphGyjNHK+3Y+CWEmQP4eol0lVLB1etjZ7RZqE9A2Exn5L5Zo/dJoF9eW4amVadL1sUgGSIQagBbDe82qeQXmsvSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724084721; c=relaxed/simple;
	bh=cPS0o/N0CK/JL5DZi+nForyXz/ArsZKYs2Uo3kArxh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UoLttyvSQdbV8kutd4YR8abmUy1MO0S1kS2HqhosOfQA10f7LvL28FLzGd9w9m014PSAJ5VKtUfwEZtN9mYV1Vx6XhwuQGQhk86iW6YDvGJsT59rfndT4eKwHJ37BWOxMxSHf9BDurIJLIzZX98aRoTldEmpV09aeXppLXtIA3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fDGeWwbR; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-7a1c7857a49so2602815a12.1
        for <bpf@vger.kernel.org>; Mon, 19 Aug 2024 09:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724084719; x=1724689519; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+KYaH+vljKuNGLQLIKHD0iiblhLjzcKX/Q8/yKFhshY=;
        b=fDGeWwbRvAN4+bht78VcB3AfGN6nJjJLDFD2Gl7UC7JaTZ7kUXStm7qI2X/jQ8jvmo
         o9YjQ8ynsmPTqI7AZ5Wsl5Lm7DZyoXWf2CADzZExp6sh5yr8FCi9g2Ot43jVSiBtmzAo
         sKibaB3B0uWlb2QWVQsH8rR3Tqp2Rdq6FEI5cZuMfC5g8Pl/tOFfBYtZx9s3ABRj7AuW
         dNaW32uM7ZDm4gj6uWWojZ5ma45XPnlJuY0O4bokMBKPvR/mcTXteBXmp8thO53JehwT
         rUsxp6JoVzYbxpWupPi9Pi6kwarIfkkk8uZsIdO2jON7UNvxPdIHTwQmJEb1wdHUbOtC
         745g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724084719; x=1724689519;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+KYaH+vljKuNGLQLIKHD0iiblhLjzcKX/Q8/yKFhshY=;
        b=bDDowWYOJnP0227dOz0A4N8y462RbBh+D2o8Tz9r71lgIJlp4vg/20M8HMPP2krynF
         7gGBbLbsRg9MyNOI/SvsUNX1wlSED0e+KSjpip8iydKcBlyfqdDEvMLlUZWneDu5iqlj
         /osKR6oNVL+RyrNOYRLqxFIemITreCGAbu1InPicAxX7nuo8CnnJsr/JT71nwuixsQR5
         pXQrqpMRvuFfhZ69Rajsp1CKZr8yQO4lQWYb0Esi6/Ns3v3gZh9DuLs86dmXwaySZLSH
         Ms2mcoDGH5yBfAev3ceNlFm6FwsnoMAvo+PRw5hIvQ9A0RJr7gNqpKXr0GywAwfR+U1x
         TH/w==
X-Forwarded-Encrypted: i=1; AJvYcCUfsHBEj1xyxYo07Yycbk8ywvGquD7zxoGintKepnEnycSQ+y/eNFp88sPpFn9BzseiTlVG8K6l3mkMMWAGBKIbQSQR
X-Gm-Message-State: AOJu0YymVrss/kw+DRfSMv0r7FIAjbpcIUsDUNtDGSpwYOMfxL0byTyU
	4GhgONQeWfH22NGFs8Cf1W8XjBcZDR+NtWLUTvSGrDa7Q7o7G9ZI8l3EQz/FiEEBmmYufbkEjY7
	6XRfIzLidHw1Sw1GkgjWbbgTHM4g=
X-Google-Smtp-Source: AGHT+IFoGrMTnQyGbzVRQsiYny+/9tYo5URNDg4ghPwTawpJJLuAPVGcP5S3fthQzHoEadTaXRrcydG1UCFIc81tjLg=
X-Received: by 2002:a17:90b:234f:b0:2cf:28c1:4cc9 with SMTP id
 98e67ed59e1d1-2d3dfc2ae5bmr10454819a91.3.1724084718918; Mon, 19 Aug 2024
 09:25:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240815112733.4100387-1-linux@jordanrome.com>
 <CAEf4Bzb+W2PyvUuHixc+mTTt73zTCYBBpBwtoYmTtv++rxd4+g@mail.gmail.com> <6ddc8fda-3fcd-4e5f-8a0c-475323b08de9@gmail.com>
In-Reply-To: <6ddc8fda-3fcd-4e5f-8a0c-475323b08de9@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 19 Aug 2024 09:25:06 -0700
Message-ID: <CAEf4BzY=5+_fzJFozTtWQKJOf2Zn8Cxx_queVLOF0+moe_S3wA@mail.gmail.com>
Subject: Re: [bpf-next v5 1/2] bpf: Add bpf_copy_from_user_str kfunc
To: Kui-Feng Lee <sinquersw@gmail.com>
Cc: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@kernel.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 16, 2024 at 12:23=E2=80=AFAM Kui-Feng Lee <sinquersw@gmail.com>=
 wrote:
>
>
>
> On 8/15/24 15:38, Andrii Nakryiko wrote:
> > On Thu, Aug 15, 2024 at 4:28=E2=80=AFAM Jordan Rome <linux@jordanrome.c=
om> wrote:
> >>
> >> This adds a kfunc wrapper around strncpy_from_user,
> >> which can be called from sleepable BPF programs.
> >>
> >> This matches the non-sleepable 'bpf_probe_read_user_str'
> >> helper except it includes an additional 'flags'
> >> param, which allows consumers to clear the entire
> >> destination buffer on success.
> >>
> >> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> >> ---
> >>   include/uapi/linux/bpf.h       |  8 +++++++
> >>   kernel/bpf/helpers.c           | 41 ++++++++++++++++++++++++++++++++=
++
> >>   tools/include/uapi/linux/bpf.h |  8 +++++++
> >>   3 files changed, 57 insertions(+)
> >>
> >> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> >> index e05b39e39c3f..e207175981be 100644
> >> --- a/include/uapi/linux/bpf.h
> >> +++ b/include/uapi/linux/bpf.h
> >> @@ -7513,4 +7513,12 @@ struct bpf_iter_num {
> >>          __u64 __opaque[1];
> >>   } __attribute__((aligned(8)));
> >>
> >> +/*
> >> + * Flags to control bpf_copy_from_user_str() behaviour.
> >> + *     - BPF_ZERO_BUFFER: Memset 0 the tail of the destination buffer=
 on success
> >> + */
> >> +enum {
> >> +       BPF_ZERO_BUFFER =3D (1ULL << 0)
> >
> > We call all flags BPF_F_<something>, so let's stay consistent.
> >
> > And just for a bit of bikeshedding, "zero buffer" isn't immediately
> > clear and it would be nice to have a clearer verb in there. I don't
> > have a perfect name, but something like BPF_F_PAD_ZEROS or something
> > with "pad" maybe?
> >
> > Also, should we keep behavior a bit more consistent and say that on
> > failure this flag will also ensure that buffer is cleared?
> >
> >> +};
> >> +
> >>   #endif /* _UAPI__LINUX_BPF_H__ */
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index d02ae323996b..fe4348679d38 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2939,6 +2939,46 @@ __bpf_kfunc void bpf_iter_bits_destroy(struct b=
pf_iter_bits *it)
> >>          bpf_mem_free(&bpf_global_ma, kit->bits);
> >>   }
> >>
> >> +/**
> >> + * bpf_copy_from_user_str() - Copy a string from an unsafe user addre=
ss
> >> + * @dst:             Destination address, in kernel space.  This buff=
er must be at
> >> + *                   least @dst__szk bytes long.
> >> + * @dst__szk:        Maximum number of bytes to copy, including the t=
railing NUL.
> >> + * @unsafe_ptr__ign: Source address, in user space.
> >> + * @flags:           The only supported flag is BPF_ZERO_BUFFER
> >> + *
> >> + * Copies a NUL-terminated string from userspace to BPF space. If use=
r string is
> >> + * too long this will still ensure zero termination in the dst buffer=
 unless
> >> + * buffer size is 0.
> >> + *
> >> + * If BPF_ZERO_BUFFER flag is set, memset the tail of @dst to 0 on su=
ccess.
> >> + */
> >> +__bpf_kfunc int bpf_copy_from_user_str(void *dst, u32 dst__szk, const=
 void __user *unsafe_ptr__ign, u64 flags)
> >> +{
> >> +       int ret;
> >> +       int count;
> >> +
> >
> > validate that flags doesn't have any unknown flags
> >
> > if (unlikely(flags & ~BPF_F_ZERO_BUFFER))
> >      return -EINVAL;
> >
> >> +       if (unlikely(!dst__szk))
> >> +               return 0;
> >> +
> >> +       count =3D dst__szk - 1;
> >> +       if (unlikely(!count)) {
> >> +               ((char *)dst)[0] =3D '\0';
> >> +               return 1;
> >> +       }
> >
> > Do we need to special-case this unlikely scenario? Especially that
> > it's unlikely, why write code for it and pay a tiny price for an extra
> > check?
> >
> >> +
> >> +       ret =3D strncpy_from_user(dst, unsafe_ptr__ign, count);
> >> +       if (ret >=3D 0) {
> >> +               if (flags & BPF_ZERO_BUFFER)
> >> +                       memset((char *)dst + ret, 0, dst__szk - ret);
> >> +               else
> >> +                       ((char *)dst)[ret] =3D '\0';
> >> +               ret++;
> >
> > so if string is truncated, ret =3D=3D count, no? And dst[ret] will go
> > beyond the buffer?
>
> Since count =3D dst__szk - 1, it is not going beyond the buffer.
>

ah, I forgot that count is adjusted size already, ok

> >
> > we need more tests to validate all those various conditions
> >
> >
> > I'd also rewrite this a bit, so it's more linear:
> >
> >
> > ret =3D strncpy(...);
> > if (ret < 0)
> >      return ret;
> >
> > ((char *)dst)[count - 1] =3D '\0';
> >
> > if (flags & BPF_F_ZERO_BUF)
> >        memset(...);
> >
> > return ret < count ? ret + 1 : count;
> >
> >
> > or something along those lines
> >
> >
> > pw-bot: cr
> >
> >
> >> +       }
> >> +
> >> +       return ret;
> >> +}
> >> +
> >>   __bpf_kfunc_end_defs();
> >>
> >>   BTF_KFUNCS_START(generic_btf_ids)
> >> @@ -3024,6 +3064,7 @@ BTF_ID_FLAGS(func, bpf_preempt_enable)
> >>   BTF_ID_FLAGS(func, bpf_iter_bits_new, KF_ITER_NEW)
> >>   BTF_ID_FLAGS(func, bpf_iter_bits_next, KF_ITER_NEXT | KF_RET_NULL)
> >>   BTF_ID_FLAGS(func, bpf_iter_bits_destroy, KF_ITER_DESTROY)
> >> +BTF_ID_FLAGS(func, bpf_copy_from_user_str, KF_SLEEPABLE)
> >>   BTF_KFUNCS_END(common_btf_ids)
> >>
> >>   static const struct btf_kfunc_id_set common_kfunc_set =3D {
> >> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux=
/bpf.h
> >> index e05b39e39c3f..15c2c3431e0f 100644
> >> --- a/tools/include/uapi/linux/bpf.h
> >> +++ b/tools/include/uapi/linux/bpf.h
> >> @@ -7513,4 +7513,12 @@ struct bpf_iter_num {
> >>          __u64 __opaque[1];
> >>   } __attribute__((aligned(8)));
> >>
> >> +/*
> >> + * Flags to control bpf_copy_from_user_str() behaviour.
> >> + *     - BPF_ZERO_BUFFER: Memset 0 the entire destination buffer on s=
uccess
> >> + */
> >> +enum {
> >> +       BPF_ZERO_BUFFER =3D (1ULL << 0)
> >> +};
> >> +
> >>   #endif /* _UAPI__LINUX_BPF_H__ */
> >> --
> >> 2.43.5
> >>


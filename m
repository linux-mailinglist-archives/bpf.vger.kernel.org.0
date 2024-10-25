Return-Path: <bpf+bounces-43169-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D14DB9B08CA
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 17:45:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8601F28139
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 15:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BD0815ADA4;
	Fri, 25 Oct 2024 15:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DH0EjNjH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5A2B33D8
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729871131; cv=none; b=JVb4e+fpVBmwVZ/5PBFYUYhrkrvLSp8tsKVwW8+DcvVXTZmkxKTn98IiJ9qN5IVihv40+pd4Fw2fPp3d91VP+VCii5CBsK0GkxR6024hOw8w2vprbp2cEATbiAp8RddtuFXgEOqnLXAjE08FHejbTwew6LpP8THlSqxRNJXP4xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729871131; c=relaxed/simple;
	bh=t2h5M9YeqmEqZG3MVzRl3E3QLCzzG6denqTuebNSQO8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DZvpUDpmV3ZeoYiDJ7pXsn0IUdJs602doFDsGAMGS6Q1rpn8aDLGaGr5J/8m5YVe3ddjv1/JILCF/2nqNbInLBPAYs8rKLsfrmOEVgHgmnoAg719OlMhDQmtPFr6ossCNpizmP2wk842zzpYHIkWxyZYV0j04ejFNQP4+asm4t0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DH0EjNjH; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-431548bd1b4so21217055e9.3
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 08:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729871127; x=1730475927; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jgHX7nLuraSOloslAnXsKCDjgntUZ9ONIttGcUEzlrU=;
        b=DH0EjNjHlNAXwde6wIFpAVt1tPlnDU05TYyCc4+0qYNMfzLdYwoQgUpX6UhcuJptZv
         u1ozVXKO6e5Y8A1Zuky/kkMz9Poua565gG2a5GTyJ5/kmziGcPEBiWIqy1JR5UjJBlTF
         1ogLo2kL2KYDtf/y5vYZKOwouSJ6EHXkWaSP2aQ0zsKdy3pS/DA+yRM9oT0XhPlDmU//
         3NDFEcZa3YsJGTdk53L1h+96CH0EEMzUL00SfWflEjRZJAmCs93699Fzxy6mK1FwjzGD
         0dBAzkpEwte260zvVC47lPxdCy46zKzPNnMawOnkefYfHq17pxg67Zzxuu+Ibdxldj9r
         qcOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729871127; x=1730475927;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jgHX7nLuraSOloslAnXsKCDjgntUZ9ONIttGcUEzlrU=;
        b=qtEgeTtISqfujDUAzMcUDzJbkAcu+zzbFJ1B9ejvwGFtEc9+vK1LLtFJ7TDKOki7Rm
         coICjHJLbDBx4AF+4d0rwTnjT9A7uti4vuIqp5XNKQPF4KEnNtNcRz4x1TCU5JWUqpbi
         5MJP6v04hat2uClEjY1ntP/zxFjftpiq/xHmYdX4eDZSL60bM67W0Pe5BdyM2kLObgxd
         H/RgVyu1Eld42Y5SPQH2u0QdDcKdR8cZcPW33ma5jhLdi1BQO/9Jnsc8m6H6oxNOR7hK
         +0w6IUUBNjYDfZQKVwNWIYgCLQh4t2Zbet1FrktNnVFAvH4vo8CTx5SXbrQnmRZ3qM8T
         dmnQ==
X-Forwarded-Encrypted: i=1; AJvYcCW4QWU4Z2QIa2+5KIEf0TjF5NXQ0+F752/mO+JKMqZthBMHri3xyBnYtph3DNGRt+j8lIo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnvSpXJ0J6xCMGQ+GwcNodPJVOxDKo39qobghTqW9VdnKdv54O
	wkDjWVaRZT5uJThL0QMhkbgRkmNP96+fJ3cE9pXM66Cud8ouvwqxf1Q5+mTtsv4U5mMmEqZgtkO
	ArFVhPpHuxlw1zJ/mCDcvAIFEopv5qvnN
X-Google-Smtp-Source: AGHT+IFBVbdueW2bmHO42P57PZ9fYFsRxsLyi45Qw97CUgktNPLt3MpfKzuJrTcF2OCFRtd0zBHmhpDTO6JiW3NetG4=
X-Received: by 2002:a05:600c:1d99:b0:431:52cc:877e with SMTP id
 5b1f17b1804b1-43184209af9mr73862365e9.20.1729871126668; Fri, 25 Oct 2024
 08:45:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025013233.804027-1-houtao@huaweicloud.com>
 <20241025013233.804027-4-houtao@huaweicloud.com> <CALOAHbDwKh3xZa1pFURSuOV=md+eAfKbrsPGyxh3xH39e50qWA@mail.gmail.com>
 <623079fc-c66f-e597-b6b1-b810b1a717f4@huaweicloud.com> <CALOAHbB+KtaAHgeQsMe2qeenmmyRKty6kq=NQBffDfJ6_t_8og@mail.gmail.com>
In-Reply-To: <CALOAHbB+KtaAHgeQsMe2qeenmmyRKty6kq=NQBffDfJ6_t_8og@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Oct 2024 08:45:15 -0700
Message-ID: <CAADnVQK_vbK6+1ijM06VeFa9idgLx9dT62M0GR9soUGZA=fW6Q@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/5] bpf: Check the validity of nr_words in bpf_iter_bits_new()
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Hou Tao <houtao@huaweicloud.com>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Hou Tao <houtao1@huawei.com>, 
	Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 6:29=E2=80=AFAM Yafang Shao <laoar.shao@gmail.com> =
wrote:
>
> On Fri, Oct 25, 2024 at 3:52=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> =
wrote:
> >
> > Hi Yafang,
> >
> > On 10/25/2024 2:04 PM, Yafang Shao wrote:
> > > On Fri, Oct 25, 2024 at 9:20=E2=80=AFAM Hou Tao <houtao@huaweicloud.c=
om> wrote:
> > >> From: Hou Tao <houtao1@huawei.com>
> > >>
> > >> Check the validity of nr_words in bpf_iter_bits_new(). Without this
> > >> check, when multiplication overflow occurs for nr_bits (e.g., when
> > >> nr_words =3D 0x0400-0001, nr_bits becomes 64), stack corruption may =
occur
> > >> due to bpf_probe_read_kernel_common(..., nr_bytes =3D 0x2000-0008).
> > >>
> > >> Fix it by limiting the maximum value of nr_words to 511. The value i=
s
> > >> derived from the current implementation of BPF memory allocator. To
> > >> ensure compatibility if the BPF memory allocator's size limitation
> > >> changes in the future, use the helper bpf_mem_alloc_check_size() to
> > >> check whether nr_bytes is too larger. And return -E2BIG instead of
> > >> -ENOMEM for oversized nr_bytes.
> > >>
> > >> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> > >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> > >> ---
> > >>  kernel/bpf/helpers.c | 18 ++++++++++++++----
> > >>  1 file changed, 14 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> > >> index 40ef6a56619f..daec74820dbe 100644
> > >> --- a/kernel/bpf/helpers.c
> > >> +++ b/kernel/bpf/helpers.c
> > >> @@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
> > >>         __u64 __opaque[2];
> > >>  } __aligned(8);
> > >>
> > >> +#define BITS_ITER_NR_WORDS_MAX 511
> > >> +
> > >>  struct bpf_iter_bits_kern {
> > >>         union {
> > >>                 unsigned long *bits;
> > >> @@ -2865,7 +2867,8 @@ struct bpf_iter_bits_kern {
> > >>   * @it: The new bpf_iter_bits to be created
> > >>   * @unsafe_ptr__ign: A pointer pointing to a memory area to be iter=
ated over
> > >>   * @nr_words: The size of the specified memory area, measured in 8-=
byte units.
> > >> - * Due to the limitation of memalloc, it can't be greater than 512.
> > >> + * The maximum value of @nr_words is @BITS_ITER_NR_WORDS_MAX. This =
limit may be
> > >> + * further reduced by the BPF memory allocator implementation.
> > >>   *
> > >>   * This function initializes a new bpf_iter_bits structure for iter=
ating over
> > >>   * a memory area which is specified by the @unsafe_ptr__ign and @nr=
_words. It
> > >> @@ -2878,8 +2881,7 @@ __bpf_kfunc int
> > >>  bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__=
ign, u32 nr_words)
> > >>  {
> > >>         struct bpf_iter_bits_kern *kit =3D (void *)it;
> > >> -       u32 nr_bytes =3D nr_words * sizeof(u64);
> > >> -       u32 nr_bits =3D BYTES_TO_BITS(nr_bytes);
> > >> +       u32 nr_bytes, nr_bits;
> > >>         int err;
> > >>
> > >>         BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(s=
truct bpf_iter_bits));
> > >> @@ -2892,9 +2894,14 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, c=
onst u64 *unsafe_ptr__ign, u32 nr_w
> > >>
> > >>         if (!unsafe_ptr__ign || !nr_words)
> > >>                 return -EINVAL;
> > >> +       if (nr_words > BITS_ITER_NR_WORDS_MAX)
> > >> +               return -E2BIG;
> > >> +
> > >> +       nr_bytes =3D nr_words * sizeof(u64);
> > >> +       nr_bits =3D BYTES_TO_BITS(nr_bytes);
> > >>
> > >>         /* Optimization for u64 mask */
> > >> -       if (nr_bits =3D=3D 64) {
> > >> +       if (nr_words =3D=3D 1) {
> > >>                 err =3D bpf_probe_read_kernel_common(&kit->bits_copy=
, nr_bytes, unsafe_ptr__ign);
> > >>                 if (err)
> > >>                         return -EFAULT;
> > >> @@ -2903,6 +2910,9 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, co=
nst u64 *unsafe_ptr__ign, u32 nr_w
> > >>                 return 0;
> > >>         }
> > >>
> > >> +       if (bpf_mem_alloc_check_size(false, nr_bytes))
> > >> +               return -E2BIG;
> > >> +
> > > Is this check necessary here? If `E2BIG` is a concern, perhaps it
> > > would be more appropriate to return it using ERR_PTR() in
> > > bpf_mem_alloc()?
> >
> > The check is necessary to ensure a correct error code is returned.
> > Returning ERR_PTR() in bpf_mem_alloc() is also feasible, but the return
> > value of bpf_mem_alloc() and bpf_mem_cache_alloc() will be different, s=
o
> > I prefer to introduce an extra helper for the size checking.
>
> Perhaps we should refactor the return values of both bpf_mem_alloc()
> and bpf_mem_cache_alloc() to return more appropriate error codes, such
> as -E2BIG, -ENOMEM, and -EINVAL. However, this change would be better
> addressed in a separate patchset.

No. bpf_mem_alloc() returns NULL or valid and will stay this way.


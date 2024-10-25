Return-Path: <bpf+bounces-43159-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDA3E9B0406
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 418581F23D0C
	for <lists+bpf@lfdr.de>; Fri, 25 Oct 2024 13:29:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1851370811;
	Fri, 25 Oct 2024 13:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ngUJ6TS8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f177.google.com (mail-qk1-f177.google.com [209.85.222.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE4C21216E
	for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 13:29:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729862952; cv=none; b=ROV6LskGvfJmJpYcp2OpbussPHQLazIeOyS75D4sXJHiJ+RAmer4wC+UC7qrxzPGujVtoEg5GjmJE8qym2LCjfuxIf8xQZXFMTW7jBffilk07wSzajM2r7mS9oHrXU0Pa5kM9sh/AwMJyyY0mTAptS+pDZtFXxmTzHmZloYI7+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729862952; c=relaxed/simple;
	bh=bKrE6wKXtncdLbX45U1vAFFDyEZYJEvVm7qBSDnpENY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eHtXcN8q4/RqemPzggi6rzWt+4OOHz7FGMDClhSEKtefUxSH+j160d3qtMkADrOg2QGqkbF2bp7UUaGz53BCX0+UXspInW2hiKXHE4ij3ewUklqTmlyZHfualrlwN4W9CuAxT7zled+bXT5nEbY7gZd/7fKVcqzYuD0n+3dOr30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ngUJ6TS8; arc=none smtp.client-ip=209.85.222.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f177.google.com with SMTP id af79cd13be357-7b148919e82so137781685a.0
        for <bpf@vger.kernel.org>; Fri, 25 Oct 2024 06:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729862949; x=1730467749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8NwbOOYh2NQvkXLUm7rM5C/MGSPhxDbq+dvI6knjYRY=;
        b=ngUJ6TS89bPaN21yPq3ZQzqMZQExzzJuzm7Lde3+MVdRoxnbRU+S8BUXOl/Cqh+pJr
         8FjVM+1oVWYdF87YZXSNF2LdC2/gB8vAtRPIE1bldDdKPRgtTFRQiChOF2/lERVIIqOa
         Iscb6LsCZ/FTVV4u6AQefNRBU/OVClfaQIwb4ogabrHvbkMChkbdIqydEp7VRB0FSk6k
         qR5F46zO167HH1gX6Rq4I1WQUbjJZW/7Tn25GtfZpjKicNMLlwZI4vWStMAiioeaUDMa
         lRA/R0Bc5r2EQl1K5OnnpKsno71NaxkG7mkcHvW74D99wm3NMM8/7d86XeZND48LrqSg
         MSEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729862949; x=1730467749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8NwbOOYh2NQvkXLUm7rM5C/MGSPhxDbq+dvI6knjYRY=;
        b=LBd9smnKfb+4UGpoEWEecPT6pp452sEqHHI/jFezqfW2EW7X5MPSmS5rQ9uLEwlcyb
         +tjdZljD1YxXKbq3UL1CO0Bc/k/oaDQZbBeZFYZlWVVyd7f3RrEeGBtr6oy7zSIRCbPw
         RBgDBFBRREr2rEo1VtMRhknxjrO6pi///0a0EOkGlMUMRkFAHE4Wf3QbKhYOc2g5cm3+
         vSR7FbfIo5f9H+bR42v34m4e1gnElyIKnIV7sCm2OwoIdc+Hqms7BVobpou0A6qHKRDF
         OawR16ZooUG2bqITXcJVW1+Ry6LfR96uQ2HKH+2ToHxJGGeMBonxWsp+GFlMduj/0rOx
         Aerw==
X-Gm-Message-State: AOJu0Yy1N+UeX7QzfoYhjGXi7W5zxndRuKecQQgF9D3pYecCxYG9REyL
	VvrchJUs/F3n2APAhDnlZwJhNdlW1BNixLHY63Fp9DcRvHImpcZlnthyVyKFJ6F89Jzggg9VXDR
	mJIM/6z9smyXY/uT7nYZyOmPfiFw=
X-Google-Smtp-Source: AGHT+IHx2x8HOk0sunhypwhjJ+4CZGthinw1fSgB1Gn+u0oDRYIdp9oaFf4ge8Hg4SVyvFeKYyG4vrinQ+J+upEq/so=
X-Received: by 2002:a05:6214:5693:b0:6cb:fa74:bafb with SMTP id
 6a1803df08f44-6ce341ccb21mr103764186d6.31.1729862947826; Fri, 25 Oct 2024
 06:29:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025013233.804027-1-houtao@huaweicloud.com>
 <20241025013233.804027-4-houtao@huaweicloud.com> <CALOAHbDwKh3xZa1pFURSuOV=md+eAfKbrsPGyxh3xH39e50qWA@mail.gmail.com>
 <623079fc-c66f-e597-b6b1-b810b1a717f4@huaweicloud.com>
In-Reply-To: <623079fc-c66f-e597-b6b1-b810b1a717f4@huaweicloud.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 25 Oct 2024 21:28:30 +0800
Message-ID: <CALOAHbB+KtaAHgeQsMe2qeenmmyRKty6kq=NQBffDfJ6_t_8og@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/5] bpf: Check the validity of nr_words in bpf_iter_bits_new()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 25, 2024 at 3:52=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi Yafang,
>
> On 10/25/2024 2:04 PM, Yafang Shao wrote:
> > On Fri, Oct 25, 2024 at 9:20=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Check the validity of nr_words in bpf_iter_bits_new(). Without this
> >> check, when multiplication overflow occurs for nr_bits (e.g., when
> >> nr_words =3D 0x0400-0001, nr_bits becomes 64), stack corruption may oc=
cur
> >> due to bpf_probe_read_kernel_common(..., nr_bytes =3D 0x2000-0008).
> >>
> >> Fix it by limiting the maximum value of nr_words to 511. The value is
> >> derived from the current implementation of BPF memory allocator. To
> >> ensure compatibility if the BPF memory allocator's size limitation
> >> changes in the future, use the helper bpf_mem_alloc_check_size() to
> >> check whether nr_bytes is too larger. And return -E2BIG instead of
> >> -ENOMEM for oversized nr_bytes.
> >>
> >> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/bpf/helpers.c | 18 ++++++++++++++----
> >>  1 file changed, 14 insertions(+), 4 deletions(-)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 40ef6a56619f..daec74820dbe 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
> >>         __u64 __opaque[2];
> >>  } __aligned(8);
> >>
> >> +#define BITS_ITER_NR_WORDS_MAX 511
> >> +
> >>  struct bpf_iter_bits_kern {
> >>         union {
> >>                 unsigned long *bits;
> >> @@ -2865,7 +2867,8 @@ struct bpf_iter_bits_kern {
> >>   * @it: The new bpf_iter_bits to be created
> >>   * @unsafe_ptr__ign: A pointer pointing to a memory area to be iterat=
ed over
> >>   * @nr_words: The size of the specified memory area, measured in 8-by=
te units.
> >> - * Due to the limitation of memalloc, it can't be greater than 512.
> >> + * The maximum value of @nr_words is @BITS_ITER_NR_WORDS_MAX. This li=
mit may be
> >> + * further reduced by the BPF memory allocator implementation.
> >>   *
> >>   * This function initializes a new bpf_iter_bits structure for iterat=
ing over
> >>   * a memory area which is specified by the @unsafe_ptr__ign and @nr_w=
ords. It
> >> @@ -2878,8 +2881,7 @@ __bpf_kfunc int
> >>  bpf_iter_bits_new(struct bpf_iter_bits *it, const u64 *unsafe_ptr__ig=
n, u32 nr_words)
> >>  {
> >>         struct bpf_iter_bits_kern *kit =3D (void *)it;
> >> -       u32 nr_bytes =3D nr_words * sizeof(u64);
> >> -       u32 nr_bits =3D BYTES_TO_BITS(nr_bytes);
> >> +       u32 nr_bytes, nr_bits;
> >>         int err;
> >>
> >>         BUILD_BUG_ON(sizeof(struct bpf_iter_bits_kern) !=3D sizeof(str=
uct bpf_iter_bits));
> >> @@ -2892,9 +2894,14 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, con=
st u64 *unsafe_ptr__ign, u32 nr_w
> >>
> >>         if (!unsafe_ptr__ign || !nr_words)
> >>                 return -EINVAL;
> >> +       if (nr_words > BITS_ITER_NR_WORDS_MAX)
> >> +               return -E2BIG;
> >> +
> >> +       nr_bytes =3D nr_words * sizeof(u64);
> >> +       nr_bits =3D BYTES_TO_BITS(nr_bytes);
> >>
> >>         /* Optimization for u64 mask */
> >> -       if (nr_bits =3D=3D 64) {
> >> +       if (nr_words =3D=3D 1) {
> >>                 err =3D bpf_probe_read_kernel_common(&kit->bits_copy, =
nr_bytes, unsafe_ptr__ign);
> >>                 if (err)
> >>                         return -EFAULT;
> >> @@ -2903,6 +2910,9 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, cons=
t u64 *unsafe_ptr__ign, u32 nr_w
> >>                 return 0;
> >>         }
> >>
> >> +       if (bpf_mem_alloc_check_size(false, nr_bytes))
> >> +               return -E2BIG;
> >> +
> > Is this check necessary here? If `E2BIG` is a concern, perhaps it
> > would be more appropriate to return it using ERR_PTR() in
> > bpf_mem_alloc()?
>
> The check is necessary to ensure a correct error code is returned.
> Returning ERR_PTR() in bpf_mem_alloc() is also feasible, but the return
> value of bpf_mem_alloc() and bpf_mem_cache_alloc() will be different, so
> I prefer to introduce an extra helper for the size checking.

Perhaps we should refactor the return values of both bpf_mem_alloc()
and bpf_mem_cache_alloc() to return more appropriate error codes, such
as -E2BIG, -ENOMEM, and -EINVAL. However, this change would be better
addressed in a separate patchset.

--=20
Regards
Yafang


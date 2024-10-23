Return-Path: <bpf+bounces-42882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C57CB9AC64D
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 11:26:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13A71B224BD
	for <lists+bpf@lfdr.de>; Wed, 23 Oct 2024 09:26:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 845F01946C4;
	Wed, 23 Oct 2024 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RNQVte+n"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B86015B971
	for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 09:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729675555; cv=none; b=vDTyx3b1VutvTpK9x1EfEq0yZTbgslPwnvHIFJnfy66TniAc/ekpsMKBMhkwBdBIGaBJFF2egDiBY2GijaohN+f3LS0ZlcNBp6FetxjBz5LLQnZ1OU/KnFdSSg8W6e05FiaKsvMnT5iRVpCDmtUn6jyJfrs1FukLpsFZoSQ/0b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729675555; c=relaxed/simple;
	bh=7IT83dvZUXaTV2W3Qs++liQk3w0yRHNCAROfLFwhE7s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J0cxPXvj1Oe3LwyJqiPVE5gw9yc76FojGTMy26AMs4g4S+vj2bSADLxDpUwRQxdXztFi1xgCXb+1TbBHJ5wmBRM9HkRxJkrtC7xSYCn3/ktzHPSqWRT4wBXP6Pc3SgiIuBgd1h8CnYEhyyNv/J6e3iude+7p7mln1d0hQC8Xy7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RNQVte+n; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b1418058bbso486012985a.3
        for <bpf@vger.kernel.org>; Wed, 23 Oct 2024 02:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729675552; x=1730280352; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xrtM5V4367PNRSUfJrFTQcm5Llf/UCDPfu55zyHYtAU=;
        b=RNQVte+nq1jPuYqzhhh79BTFgZzPZ+uZmdhkShZnFLrppEA7rd6T48s+VdJtWanXZk
         5SfriItml4A+XZFFt+yVf8wVYO8J9JU1J3oJWkwmTnobyr5FJ2m6LzwE6DDP+3fSVCwG
         t5Fsma9sgotFAjxBE67UaKysLdHqUbzQ+Rdd2R0b/fltzrA/bW3wGeas4xXNc325rYa8
         w1GHaXvVEmIc+jRvRNJrC7jBdLLYkO0f29O5Kz2k2zFQ7EDbZxTH+3XaOqi5Sz3v7MAw
         H0MSSBnhT/kio+FAdOoimmIFRj7xDa94tZeRaqj+tdS6U569ey5WtLbGgJ3dGemBq6dL
         /FQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729675552; x=1730280352;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xrtM5V4367PNRSUfJrFTQcm5Llf/UCDPfu55zyHYtAU=;
        b=KBWziTwKtC91kvocxdDpVFhF99RsmZOVdmPYHRnDcdIYyzMyYS3U4gcMWYQRraisg+
         6iON5bVEUzSzaPNSxAvX2S5wcRC3NyNwCG6uNU/VW/kEJhCYwXCciz2rU6r9GiAqbeg/
         bXBwFbqzkebbiGQuMBLuFBlHlHh9PDyZQmkGeH1Re0f6FPi/vXMSBE7IZrNs0bXxniwF
         eCYtJXmZxbumsWRG5f1+id//y2qeUM4Jt/ufhoqm0AtAw88FAQ5lwQZl50I4plARllKQ
         u8K7QSNtvAnL/UF0zQSotM/i96EEA7AlY87a8S3QozW8dms1vwZH/dZn1Pl0GFKI/MJO
         bVLA==
X-Gm-Message-State: AOJu0YzU89VgCVz7huWt/OaJrBT+eMjKagYiYzAG6G9k5sAZC7TK/zcR
	rFxmBvNwxSBGyg4FSwCePB6oO3gNaQ0Lbd/jvbkNFA3jbBORysvdx2xQLVdHymil1QPHe6xuniF
	3Cw63Cthvwrqs6Pi60Hy5//p9Heg=
X-Google-Smtp-Source: AGHT+IFpiAeHeS6JSaaEBRIzIIt6x+0KwIk8PvgXr3n33XvLKw3P/tRGT4nNMjsrpjiXFkRJoXVaS+d82YG8RJpiCME=
X-Received: by 2002:a05:6214:440d:b0:6cc:2d3c:6472 with SMTP id
 6a1803df08f44-6ce3420dd4cmr28038066d6.14.1729675552209; Wed, 23 Oct 2024
 02:25:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021014004.1647816-1-houtao@huaweicloud.com>
 <20241021014004.1647816-6-houtao@huaweicloud.com> <CALOAHbDq4R=Exe6cUEindutk8NuLKBdiMayR3=HGL4zwYDrWQQ@mail.gmail.com>
 <2368d81f-9356-b472-8a51-4fb2f88b4235@huaweicloud.com>
In-Reply-To: <2368d81f-9356-b472-8a51-4fb2f88b4235@huaweicloud.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 23 Oct 2024 17:25:15 +0800
Message-ID: <CALOAHbCD8QbowivtZu=CFN1Jajk1FOdNx6JVuGgnbYGzWzfwew@mail.gmail.com>
Subject: Re: [PATCH bpf v2 5/7] bpf: Check the validity of nr_words in bpf_iter_bits_new()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, houtao1@huawei.com, xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 4:29=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
>
> On 10/23/2024 11:17 AM, Yafang Shao wrote:
> > On Mon, Oct 21, 2024 at 9:28=E2=80=AFAM Hou Tao <houtao@huaweicloud.com=
> wrote:
> >> From: Hou Tao <houtao1@huawei.com>
> >>
> >> Check the validity of nr_words in bpf_iter_bits_new(). Without this
> >> check, when multiplication overflow occurs for nr_bits (e.g., when
> >> nr_words =3D 0x0400-0001, nr_bits becomes 64), stack corruption may oc=
cur
> >> due to bpf_probe_read_kernel_common(..., nr_bytes =3D 0x2000-0008).
> >>
> >> Fix it by limiting the max value of nr_words to 512.
> >>
> >> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> >> Signed-off-by: Hou Tao <houtao1@huawei.com>
> >> ---
> >>  kernel/bpf/helpers.c | 4 ++++
> >>  1 file changed, 4 insertions(+)
> >>
> >> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> >> index 62349e206a29..c147f75e1b48 100644
> >> --- a/kernel/bpf/helpers.c
> >> +++ b/kernel/bpf/helpers.c
> >> @@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
> >>         __u64 __opaque[2];
> >>  } __aligned(8);
> >>
> >> +#define BITS_ITER_NR_WORDS_MAX 512
> >> +
> >>  struct bpf_iter_bits_kern {
> >>         union {
> >>                 unsigned long *bits;
> >> @@ -2892,6 +2894,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, cons=
t u64 *unsafe_ptr__ign, u32 nr_w
> >>
> >>         if (!unsafe_ptr__ign || !nr_words)
> >>                 return -EINVAL;
> >> +       if (nr_words > BITS_ITER_NR_WORDS_MAX)
> >> +               return -E2BIG;
> > It is documented that nr_words cannot exceed 512, not due to overflow
> > concerns, but because of memory allocation limits. It might be better
> > to use 512 directly instead of BITS_ITER_NR_WORDS_MAX. Alternatively,
> > if we decide to keep using the macro, the documentation should be
> > updated accordingly.
>
> Thanks for the explanation. Actually according to the limitation of bpf
> memory allocator, the limitation should be (4096 - 8) / 8 =3D 511 due to
> the overhead of llist_head in the returned pointer.

If that's the case, we should make the following code change, right ?

diff --git a/kernel/bpf/memalloc.c b/kernel/bpf/memalloc.c
index 1a1b4458114c..64e73579c7d6 100644
--- a/kernel/bpf/memalloc.c
+++ b/kernel/bpf/memalloc.c
@@ -65,7 +65,7 @@ static u8 size_index[24] __ro_after_init =3D {

 static int bpf_mem_cache_idx(size_t size)
 {
-       if (!size || size > 4096)
+       if (!size || size > (4096 - 8))
                return -1;

        if (size <=3D 192)



--
Regards
Yafang


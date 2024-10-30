Return-Path: <bpf+bounces-43481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C47BA9B59B1
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 02:56:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F0371F21D38
	for <lists+bpf@lfdr.de>; Wed, 30 Oct 2024 01:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4C418FC8F;
	Wed, 30 Oct 2024 01:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJflBlZB"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D61F8DDC3
	for <bpf@vger.kernel.org>; Wed, 30 Oct 2024 01:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730253410; cv=none; b=K0aDxVrlG5hK47l13kaf9wPo/EaRo3JKXwaQxNfXxRrqBDm9GxXxxkW+9qzg69lu3xEZ1L2WRWqQmgCChblrH75rpIJq/wmn1rFXCwsLyf0quz916zzDnpyQ3RwYBTTQ+2LDqMFJ2m45QCcOXFyOrMFHlgkn/C2DWlnoWZMrdts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730253410; c=relaxed/simple;
	bh=PR7j9NYfTn8/DokcSM3rqqKJuAa/z/sxRvlP9SAGwY8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bAYnsG03uEfOAwGI7pX07cIUvlHe9kM/UHv03wt4wqZeYGG0ikEAOgs1vuXWpvv/k4LyPuB78eprH2oTSxzQFaKIn4xo1v5u+/PXKDJ6nos/+nvsjFDvq5MFZDt+e/0GrbGObsxrP7xM9IHb4lPS5K1DSzEbEDBxZLr2+U7MmS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJflBlZB; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-37d70df0b1aso4764589f8f.3
        for <bpf@vger.kernel.org>; Tue, 29 Oct 2024 18:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730253406; x=1730858206; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YaWEr01jisczZZ3d9B0f276DNtuV8+PnFCS/ZzYCzcs=;
        b=EJflBlZBM8ewLvBqazTagWfDtfkpYl5SQRmukF1/fkN5E2tEAKJtBlouTkeAj23wry
         BLMhl0U8zylRurL95wAh/APd6/Cd30DmuE8ca0GAKj0CSCxw3BbfcyzXynBDbeh3JiOx
         2oj9mOom38iy/HReQvjuAEFKyvlb8bFaxt87CMPejBPW4iuEBRO4tI0+FEOebQNi9X2W
         rHsmZ30Oe174yQygSmLAPE5rYHIatbgaqLAtGihuiAwI713xB21g9Aqjs+UTAhGXcbh7
         qTMc+3dm1IBcMSnqIsNzsSmNJZauZkRQFv/zf8CVUT/uPF7EKFOrPeagpE9WQsAPW6bc
         UVow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730253406; x=1730858206;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YaWEr01jisczZZ3d9B0f276DNtuV8+PnFCS/ZzYCzcs=;
        b=UB3cEfPOFFY7pYbJonySqBoLsJivEhLtMU/JwbzkNM5lrN31TObcTMFnT2jkhNxvyM
         f4bovg7OGNi6J4/mc1n4e3YFKWF1My7sV/tiFFIxdNXubFxzcoqVE0Hs7vYrIuWx0xss
         seYHLPjfpr+zezL5ircH3MGOFfLFZYJUH1k1DuXYUbAzlI1jssQWyrx446+vi3VlpunF
         87s1g2tu2WLQAFHW/JW8O03aT2EzdCfOD2VjoS3ZufSC6RkR2tBkd+kSDrrccIfd5Z7u
         hnttkL8N3sNaRGbHKbCjjvxQXe6wFZAT2YzS3FlvCTPI/QdqMnEpS2PqdbFk7CSzaByF
         GOdg==
X-Forwarded-Encrypted: i=1; AJvYcCVeaJfKVpNosmndnF6ivYeC5iRfuDozxXovzNhoq2I5igyfh/nocvinYp8HWsop9kXivqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhJYd2u0cV0jcEkjsyGtBhn1rX2fY/GjOpomMD0cTrnSGmRDmX
	csTFx7DBpkaPptWBH/q3HaOhzvlbDMRt8S0mubsGSgDClYihbCMIBLrSQ6YQs9lq3Z5yJ5hjeEw
	xQRzuKFCsp6dOL+tryTLhHt6ZyW8=
X-Google-Smtp-Source: AGHT+IHiz9shGKP7PYIFHGT7fDh/CXEEM/Q5f0HOobTDnFYA84YcB/1HVpMQ3vjSsLo9B5TJdrUheRYmxXg/3w5rwIA=
X-Received: by 2002:adf:f28f:0:b0:37d:4b73:24c0 with SMTP id
 ffacd0b85a97d-38061190da2mr9189930f8f.35.1730253405855; Tue, 29 Oct 2024
 18:56:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241025013233.804027-1-houtao@huaweicloud.com>
 <20241025013233.804027-4-houtao@huaweicloud.com> <CAADnVQKvHXEv_-MZpZBMPdDtptQuTjHhMUd0j+3j2DqhMV=w_g@mail.gmail.com>
 <4c37f26d-8c45-56a8-e5f1-624c51c8e392@huaweicloud.com>
In-Reply-To: <4c37f26d-8c45-56a8-e5f1-624c51c8e392@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 29 Oct 2024 18:56:34 -0700
Message-ID: <CAADnVQ+QbEeLTOA7Nkzj6TKMyGQMhvn0jLG_=M9E3OH-YbP+tg@mail.gmail.com>
Subject: Re: [PATCH bpf v3 3/5] bpf: Check the validity of nr_words in bpf_iter_bits_new()
To: Hou Tao <houtao@huaweicloud.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 29, 2024 at 6:45=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> Hi,
>
> On 10/30/2024 4:53 AM, Alexei Starovoitov wrote:
> > On Thu, Oct 24, 2024 at 6:20=E2=80=AFPM Hou Tao <houtao@huaweicloud.com=
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
>
> SNIP
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
> > The check for nr_words is good, but moving computation after 'if'
> > feels like code churn and nothing else.
> > Even if nr_words is large, it's fine to do the math.
>
> No intention for code churn. I thought the overflow during
> multiplication may lead to UBSAN warning, but it seems the overflow
> warning is only for signed integer. Andrii also suggested me to move the
> assignment after the check [1].
>
> [1]:
> https://lore.kernel.org/bpf/CAEf4BzahtDCZDEdejm6cNMzDNTc0gXPzhc5xcWg9c8S_=
i6yWNA@mail.gmail.com/

u32 overflow is defined.
nr_words * sizeof(u64) and BYTES_TO_BITS(nr_bytes)
are ok to do regardless of the value of nr_words,
since it's in the unsigned domain.
Let's not make a precedent out of this.
Otherwise people will change the code this way all over the place.

Saying it differently... if UBSAN had an issue with existing code
it would have complained long ago.

> >>         /* Optimization for u64 mask */
> >> -       if (nr_bits =3D=3D 64) {
> >> +       if (nr_words =3D=3D 1) {
> > This is also unnecessary churn.
> >
> > Also it seems it's causing a warn on 32-bit:
> > https://netdev.bots.linux.dev/static/nipa/902902/13849894/build_32bit/
>
> It is weird that using "nr_bits =3D 64" doesn't reproduce the warning.
> Because the warning is due to the size of bits_copy is 4 bytes under
> 32-bit host and the error path of bpf_probe_read_kernel_common() invokes
> memset(&bits_copy, 0, 8). The warning will be fixed by the following
> patch "bpf: Use __u64 to save the bits in bits iterator". Anyway, will
> change it back to "nr_bits =3D 64".

It was puzzling for me as well. Thanks for these details.


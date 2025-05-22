Return-Path: <bpf+bounces-58739-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FDEAAC1142
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 18:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9897F3A70B5
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 16:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54EAE28C00A;
	Thu, 22 May 2025 16:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J3q+Fhwm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639AA2512EC
	for <bpf@vger.kernel.org>; Thu, 22 May 2025 16:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747931873; cv=none; b=ZfmQp/XlCQKOii6nG89Ip6uSOiYJ7zxTSHAd2BUab5oBxoKaLhogNx4ANF8TfRaz3jsgAQciKVa67dDJ9wuyEHyr4MWM8Jfy8JdqIv6TuKRoIVoU6ONRkaVLsnasObFPriakxnkSenyizDlLzQ/YBNrb6hZeYh58HR1K9pK1VzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747931873; c=relaxed/simple;
	bh=OtPcY+ANHcmrEwGhBhV3O3tYLWb8LX96uJi+PWvghWM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik3pVA6+Ju7vhkwgAB3OpBmviGQLP37OMAmSKBxSfI9iqqIoqWTTbcGLfrPeJNzeXir5uPwpwivjoyd8Do2GOr+T0+H3UR8smjqyfsyR4TD5HeZ33bHZpSPUBTAVLtxEXxzaLaxMg1kP3x2D8RERB41D/Nv3Up1dKhQb1vAZpJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J3q+Fhwm; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e16234307so604255ad.0
        for <bpf@vger.kernel.org>; Thu, 22 May 2025 09:37:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747931871; x=1748536671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsBLJgfxzXDs4sXvJdN8Vsq1w3M6e5rpZNiWAAEWz3k=;
        b=J3q+Fhwmd5QqzbwSiGwd6KruTvrEP6Y6K1iftDgLBmYNa0pcZnQ6LgE8Q4XpnW2DLg
         OEoiLu3s/x0dQd/DFjTydvDqL1AP8qz2EoaARgeQaZKM845elFEAlM4V7C7oDExxWkGG
         GpLiTfCAZtWsR4DYxzc96LsamerByUGZcDRW2vQusCs2dT7l++yPLlwwgNp2JlPxkkDe
         TL8Ghcfg+i5FOjwF5LY6lTuskJbclPRI/g39hr7YWuckqixyfN6bKb+GEuZMb9/DZQE3
         lbXPvROGs4CJUbzw71NtxvVhILy0E51qxgvwuqHkHSrgsmhqBphtmYu0De0i3pFZIAdZ
         KrIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747931871; x=1748536671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsBLJgfxzXDs4sXvJdN8Vsq1w3M6e5rpZNiWAAEWz3k=;
        b=LhKzAJG0XlOcL1uCLuSIzdp890oCv771n9dHyHctMnJDp+aw/tN5idkSs5EAjdU/xc
         97389YjNy+OjB41u3A/Vk572BJG4WJ79fzG8pEycswH3YsGzo4wPKB6i1s/WET7S0lr5
         HTEJB3HQ4b/0LYSDIIFnl9p+r/pea51qO/+Z6dOKSK1l3ECIs01DecRW1IdyBxcbcxJF
         eHvb4BF51hyp7yzXT5Lqhli9fVQ0eVy8vo5mBa9YBJN9cloL0W9MaTDvSyKdCRbpq2ru
         Ftlw865fBhus++xL0D22b4hj2qvAK9AYbLSUW2rZHgIlBA5qrF/HZDimtvclc7Xin9IZ
         58+A==
X-Gm-Message-State: AOJu0YzS3ViFZyttJsmWKzW0cPcmFjDmbT/PNJpo1DAn3EDnbDFaJvva
	dEoLByODRk+ubV1OICkhroLoaeyt1Ofs0rqPtll11+z2Xhjjc60YtPfRgEpN/mWJCfGj+Ib0Sy2
	2di2L+BXy0tfrsiNE9y79x7okkpzz6Go=
X-Gm-Gg: ASbGncudPfjSfC9pRmRcI7wZmbvAylnwZUbeuMq7eObCz7NEbThmAagpePZxrdUoNOU
	CokASngFKWrF8a0pc86vRFqpWc/Ohcm2yR50+x7nVQRxtFixNp8II5yVDftXOyTCvBmGzW/6/pn
	1Od6ofpLmeWkBMydTRwVvQqQaoCUGG6EEUMyiTfxVX3cMF4/Mk
X-Google-Smtp-Source: AGHT+IHTIdovEUgpXwcG7LwXbujZ5EJZF94wqAtEA/1ic8eZLnza+oYoLsbChPEUwfZZvWWuM7JCrTNOq3RkOuoXsm8=
X-Received: by 2002:a17:902:e943:b0:231:f382:4031 with SMTP id
 d9443c01a7336-233f06d2de3mr1583755ad.20.1747931871497; Thu, 22 May 2025
 09:37:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522062116.1885601-1-tony.ambardar@gmail.com>
In-Reply-To: <20250522062116.1885601-1-tony.ambardar@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 22 May 2025 09:37:39 -0700
X-Gm-Features: AX0GCFuJG2xUOup48i3rqhLvIv_vPRsz3KGGQ5P9QBoSlw2PhUmKye0BZ7g1DtA
Message-ID: <CAEf4BzYuVzgDPAPtp6WPshf369dw3unuCruQADZd3DSrSwUNOQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] libbpf: Fix inheritance of BTF pointer size
To: Tony Ambardar <tony.ambardar@gmail.com>
Cc: bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 21, 2025 at 11:21=E2=80=AFPM Tony Ambardar <tony.ambardar@gmail=
.com> wrote:
>
> Update btf_new_empty() to copy the pointer size from a provided base BTF.
> This ensures split BTF works properly and fixes test failures seen on
> 32-bit targets:
>
>   root@qemu-armhf:/usr/libexec/kselftests-bpf# ./test_progs -a btf_split
>   __test_btf_split:PASS:empty_main_btf 0 nsec
>   __test_btf_split:PASS:main_ptr_sz 0 nsec
>   __test_btf_split:PASS:empty_split_btf 0 nsec
>   __test_btf_split:FAIL:inherit_ptr_sz unexpected inherit_ptr_sz: actual =
4 !=3D expected 8
>   [...]
>   #41/1    btf_split/single_split:FAIL
>

Hm... can you debug it a little bit, please? I see that
btf__pointer_size() on split BTF will do determine_ptr_size() call,
which will do

if (btf->base_btf && btf->base_btf->ptr_sz > 0)
    return btf->base_btf->ptr_sz;

So it looks intentional (though I can't claim I remember much of the
details by now) that we don't proactively cache btf->ptr_sz when
creating a new split BTF, but it should have resolved into base's
pointer size. And if it doesn't, let's try to understand why?

> Fixes: ba451366bf44 ("libbpf: Implement basic split BTF support")
> Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
> ---
>  tools/lib/bpf/btf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
> index 8d0d0b645a75..b1977888b35e 100644
> --- a/tools/lib/bpf/btf.c
> +++ b/tools/lib/bpf/btf.c
> @@ -995,6 +995,7 @@ static struct btf *btf_new_empty(struct btf *base_btf=
)
>
>         if (base_btf) {
>                 btf->base_btf =3D base_btf;
> +               btf->ptr_sz =3D base_btf->ptr_sz;
>                 btf->start_id =3D btf__type_cnt(base_btf);
>                 btf->start_str_off =3D base_btf->hdr->str_len + base_btf-=
>start_str_off;
>                 btf->swapped_endian =3D base_btf->swapped_endian;
> --
> 2.34.1
>


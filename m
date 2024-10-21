Return-Path: <bpf+bounces-42705-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770289A93F0
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 01:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F554283AD3
	for <lists+bpf@lfdr.de>; Mon, 21 Oct 2024 23:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 099CE1FEFD4;
	Mon, 21 Oct 2024 23:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wt2qNtSX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1418D1E25E1
	for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 23:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729552189; cv=none; b=T+vRKCEWwQf6YjAvsc5c4Eplmu4BwFjdXQqOHQdr2RNKlte7D8/WntjNRbZ6kzCBPGlcEqOpiwcuD/rcXbCdWRnrMuYsZABjhR2YLZxOarUW8mcutfEmiCF+hFMU11zUImgDVxAnbwlULvzYNvVJ8662+MzaY0giYMn5dJE/Epc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729552189; c=relaxed/simple;
	bh=rgtSb923fheJOMK6KDiQs9PQ6FrMkaRK8e2Vo5GleHE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l2VcsRTLqPXBHNi831sb8HdEjyxbhuckQUc9wsbfqtz8f+j3DQ37bx7eVpX+MKZtpSn98PBQp6Yy2jYpHEz2oUuRz8kxilHRzvSAwOfUF+zcb3kYctxD/fOM7VqXUlVNjzWKvIlofJQPucRlsNOZphtmIh2uNiAN+tdeLHKVXbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wt2qNtSX; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-71e5a1c9071so3562136b3a.0
        for <bpf@vger.kernel.org>; Mon, 21 Oct 2024 16:09:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729552187; x=1730156987; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFFGXUahcRa0SPx6MZODbXDckEIF8nDydBPlyHS43O8=;
        b=Wt2qNtSXQzJDc3YrQyo3pS/M4fmwXDv/OfakWRTsMvMPARSauBsDCIVivKtXxGn+3a
         clHv6woYE6KuqnMyDIv6CWlJE3pUsSsSDw2tiMjPcv599U/DgLGSKs+BW+2REIpkuJZO
         i6Q2vpKXpwSlmFKpnCzKkjp2SQbnjG0YZ6zr8CP551Ead7CrVUUEjKaBXR5W3fUpMl2I
         bzfq+VqsBuzZyJTmYUad8i58fxfJLL7udqAZ/jPc9VBtyjVN3RB2UiQ0YUruYmFKA7i3
         h02/Wzhj2FDeNpfD8bQR9ldA7c0DpWArdSg808zupDyCJ/hcHkljTm2JMcTbgDX6qQET
         A0eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729552187; x=1730156987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pFFGXUahcRa0SPx6MZODbXDckEIF8nDydBPlyHS43O8=;
        b=ivjwXcZ9zkSF1IEq8A+svWihy4hh8NHXjSxEFvxxu7gmw65eWvp5v5j2SHaQgTwrBE
         Vg4VNmmJfMZuBKqfVulCf05ibjBUIpPIesQKLZQkhqiYqHBpiI1zmFFX10bXyNbjhH4B
         wFMig7CBK3qgnjhU7zcLqbOH3ZsGo9Fe+GgN/ZnFWOGjKRQgdLniKYHyMqaN0fYD8itP
         Hbmp4BpI+wPOOdxthOvmn+GgCGwVT7rcBHyQRvzblz/Rhv2sdYq2Re3McJG9M7ymzOa/
         jinXyDSy5iC661nGAOtKKo5lyx6VmaRLYF8sGoBx5gdwu1hyAtL8FWePfeouHYip6qzB
         1KrQ==
X-Gm-Message-State: AOJu0YwUgBgckXkb3yOCNn03iGk1ge027gGVfSwnYELwpvdiZiTMlUL6
	91zYSmcAhNdLBCjDJA0MLWlcVv9EGhLIGtU6dQqBCYGwC0+HN+lDqnXSHrcC+kx1zPveIOKdCN2
	Samon0xqmUWG6OUOn74PrJJnwrbo=
X-Google-Smtp-Source: AGHT+IFJjuIYJAn0eZxXldiPvSEwhrS9uyMsq91naeOt4UoFhQDYeCEicMEchGcftCQRUbJ5BpyooNPgTSDvccuc1GI=
X-Received: by 2002:a05:6a00:4610:b0:71e:6489:d06 with SMTP id
 d2e1a72fcca58-71edb972451mr2362207b3a.0.1729552187278; Mon, 21 Oct 2024
 16:09:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021014004.1647816-1-houtao@huaweicloud.com> <20241021014004.1647816-6-houtao@huaweicloud.com>
In-Reply-To: <20241021014004.1647816-6-houtao@huaweicloud.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 21 Oct 2024 16:09:34 -0700
Message-ID: <CAEf4BzahtDCZDEdejm6cNMzDNTc0gXPzhc5xcWg9c8S_i6yWNA@mail.gmail.com>
Subject: Re: [PATCH bpf v2 5/7] bpf: Check the validity of nr_words in bpf_iter_bits_new()
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <martin.lau@linux.dev>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, 
	Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>, 
	Yonghong Song <yonghong.song@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Yafang Shao <laoar.shao@gmail.com>, houtao1@huawei.com, 
	xukuohai@huawei.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 20, 2024 at 6:28=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
> From: Hou Tao <houtao1@huawei.com>
>
> Check the validity of nr_words in bpf_iter_bits_new(). Without this
> check, when multiplication overflow occurs for nr_bits (e.g., when
> nr_words =3D 0x0400-0001, nr_bits becomes 64), stack corruption may occur
> due to bpf_probe_read_kernel_common(..., nr_bytes =3D 0x2000-0008).
>
> Fix it by limiting the max value of nr_words to 512.
>
> Fixes: 4665415975b0 ("bpf: Add bits iterator")
> Signed-off-by: Hou Tao <houtao1@huawei.com>
> ---
>  kernel/bpf/helpers.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
> index 62349e206a29..c147f75e1b48 100644
> --- a/kernel/bpf/helpers.c
> +++ b/kernel/bpf/helpers.c
> @@ -2851,6 +2851,8 @@ struct bpf_iter_bits {
>         __u64 __opaque[2];
>  } __aligned(8);
>
> +#define BITS_ITER_NR_WORDS_MAX 512
> +
>  struct bpf_iter_bits_kern {
>         union {
>                 unsigned long *bits;
> @@ -2892,6 +2894,8 @@ bpf_iter_bits_new(struct bpf_iter_bits *it, const u=
64 *unsafe_ptr__ign, u32 nr_w
>
>         if (!unsafe_ptr__ign || !nr_words)
>                 return -EINVAL;
> +       if (nr_words > BITS_ITER_NR_WORDS_MAX)
> +               return -E2BIG;

ah, didn't see this before replying on the previous patch. But still,
maybe, let's move nr_bytes and nr_bits assignment to after this check?

>
>         /* Optimization for u64 mask */
>         if (nr_bits =3D=3D 64) {
> --
> 2.29.2
>


Return-Path: <bpf+bounces-45233-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C3AC9D31D3
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 02:17:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B165BB2525A
	for <lists+bpf@lfdr.de>; Wed, 20 Nov 2024 01:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4884F208D7;
	Wed, 20 Nov 2024 01:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RulcnjGr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F082A920
	for <bpf@vger.kernel.org>; Wed, 20 Nov 2024 01:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732065399; cv=none; b=EK9Iy2VLj7mCKh8O3x4kEEKjjdNJp0QZ0MHbXvTMT4aHrwSN6DYmm1ww9AM1J1MzduCBNbrQgnvrxnahkf+sS2wv8fOVvBnqcmTaECY+sLzcnG7X7fn3Vqv1k2f3UPHLe+GG5/SdtLxBcqA3T5lqHSdooiP0BR4g7MOH+1WzwUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732065399; c=relaxed/simple;
	bh=c1kpPFn1UmTv6UynV3Q2Ua/wQwVvyAfCzOZptteybtw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mYnUpKcsl4IBl5qXeV5B7JHXv3Z/im+zujIJmKwHHNQ2N/wmB0XqQR5I/3TqbE+0F++uS0FFsnLNSE6ClaCdVfDoArFxACOxh805D2898G7p19vB7JfmVHRXb6luNuEQVTb0L+TLuWXwil8BjtoDrGe4Z9+w4Fq5a8UZcAjUVBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RulcnjGr; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-432d866f70fso14190295e9.2
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2024 17:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732065396; x=1732670196; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bLGbLzjvYLT2PuGiyv5EUR4GvrkePKsCo0pbtctqFOo=;
        b=RulcnjGroQK45gn1ZnUG8If7fNaQYlE8bUHiKJbfYIhpxb7s3zqLZoi/UXVn2NGxGd
         31mC81L1xqSo3ktVPfl8eyGvuvETpj/EyllOOa0W9jWwvB4tZSAcwHqHYWd5YALJnC83
         COIJHtaFlnz8/V++UMGVvKhKt8r8qYhMarz3PEkS0xrt6O7Hxu7m/CrZU8Vnzsv/NRPV
         wcE1Myxj5K9U02PyV97WZAkfx0hsgik9lFDRzKtBlfdEA/bGPe5botgu174gsNxTrDL3
         9yoK9q2csd8DPBMo033wMP02Tu6btojLiF9OnhVRA9eUueNNasstQSGP9YqpHypCSlTC
         h6mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732065396; x=1732670196;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bLGbLzjvYLT2PuGiyv5EUR4GvrkePKsCo0pbtctqFOo=;
        b=PgUlNQaBC9FtFv1hLSsUB+rAiD2RVffd5MF0kqbVCfSaGIo4lMzZi9KVLVPWiX1PzS
         gLJKCGyaM2LdtMvNfXtoYY6kZuSYpE7lgA773/kdBq2W6C1UmOBnoZ0PLVgcOUQTvRIo
         vL0Id2LNTU+hNGZf1/27Ke3W2pwWnVY+pftMkoPeYEj10h1UACZoiUe1o3dxxdoVPvzw
         yUlMBiQz7EnG16qUJRW/N2M0mHiGJ5a5eODHYyGgTTE0qE4KHywF5QQp2sue41sg2MI5
         pMDuLxXm+2T5fKZY5YqWdd40Hp8A7hc1KlPdnLOp1Rds+ingQ1REPEKHxTuKQWxncn9w
         j2uw==
X-Gm-Message-State: AOJu0YylCEjio3tRNpN0yNiZMppy0YSHVBUl/d2ljreDc9+7erR8eM/X
	ySX6MSPXN6H/7U+XuJMMfbd4bS85lUlCbNiGaJhxW+wwbeSMO/U5zx7fDOgm5I8nsyekgf+IWVK
	1NfmAPHxVS3wYf5TQ5AmyeQ7Nmk4=
X-Gm-Gg: ASbGncubMOq1uoPrPJVmOpFtiYc/DxaLVa/dw7FGo1zur5EpbSX9F8+S2503Y2yRCpT
	i1sdOvZCJ4usitbmH0PLLqChyoxTe8g==
X-Google-Smtp-Source: AGHT+IFJ5lw/WCwFvb/RCZeV8quxPU6rzgw3tWqQKGZqAqeAvcK9A0kcX3zuk4vDkt0sqIQ/9fN0xIz9couoLOrg0Ms=
X-Received: by 2002:a05:600c:4fd5:b0:42c:b905:2bf9 with SMTP id
 5b1f17b1804b1-433489d46ecmr8478645e9.16.1732065396235; Tue, 19 Nov 2024
 17:16:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241118010808.2243555-1-houtao@huaweicloud.com> <20241118010808.2243555-8-houtao@huaweicloud.com>
In-Reply-To: <20241118010808.2243555-8-houtao@huaweicloud.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 19 Nov 2024 17:16:25 -0800
Message-ID: <CAADnVQJPhkNbq0nHANJ5W03-dQ3t7ZPeh3gk+WJbtXFOL=GwUA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 07/10] bpf: Switch to bpf mem allocator for LPM trie
To: Hou Tao <houtao@huaweicloud.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, Yonghong Song <yonghong.song@linux.dev>, 
	Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jiri Olsa <jolsa@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>, 
	Hou Tao <houtao1@huawei.com>, Xu Kuohai <xukuohai@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 17, 2024 at 4:56=E2=80=AFPM Hou Tao <houtao@huaweicloud.com> wr=
ote:
>
>
> +enum {
> +       LPM_TRIE_MA_IM =3D 0,
> +       LPM_TRIE_MA_LEAF,
> +       LPM_TRIE_MA_CNT,
> +};
> +
>  struct lpm_trie {
>         struct bpf_map                  map;
>         struct lpm_trie_node __rcu      *root;
> +       struct bpf_mem_alloc            ma[LPM_TRIE_MA_CNT];
> +       struct bpf_mem_alloc            *im_ma;
> +       struct bpf_mem_alloc            *leaf_ma;

We cannot use bpf_ma-s liberally like that.
Freelists are not huge, but we shouldn't be adding new bpf_ma
in every map and every use case.

bpf_mem_cache_is_mergeable() in the previous patch also
leaks implementation details.

Can you use bpf_global_ma for all nodes?

pw-bot: cr


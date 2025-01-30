Return-Path: <bpf+bounces-50082-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C919FA22742
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 01:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E38533A7084
	for <lists+bpf@lfdr.de>; Thu, 30 Jan 2025 00:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB6257464;
	Thu, 30 Jan 2025 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6WxNtjL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 292E74A32
	for <bpf@vger.kernel.org>; Thu, 30 Jan 2025 00:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738197279; cv=none; b=NUejBC7Dns1Wu3T+fw+OSYeO94bUxh5ZfTcde2HgbmN/lCMod7XiXHQft92VmV4wDWGMS2ClvocdGvCCc+2DetTLbBOenXp+1jR6gLLXmevA/2s2BxZkQtez0VPqGQ+7Y6/SVCPgaGRlwXpiQ1/nKf4EmW5r0Prwa3DfEa0Tk0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738197279; c=relaxed/simple;
	bh=GYY1sLU0KRCun66Je2EkhSsEGqz51cimCKLO/My3HHg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=feY1dtvtqreenMOnsEQcG+Gt/lZpT/Ea2s9EJYETFK+/VQ6sGgyry/m5hnwKHoocY62O0+yQEix/dZ9F3WcslGJdpaYlPVX5AAB2qlzfwDGq5sWLWQqeZg8pBQolAJm8Tf19yfcCa6/HpZUvu8LD1+nJ2GVliwax2lI4flvqOCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a6WxNtjL; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2165cb60719so3952755ad.0
        for <bpf@vger.kernel.org>; Wed, 29 Jan 2025 16:34:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738197277; x=1738802077; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av1w9gkzfHrj6GP18gCUm04IfEfATxr8zMSfIiCQS6g=;
        b=a6WxNtjLMvKvVT9f/nt4u4P/R1N8ro9ODvnWH36lAHhBfVQkNs79V3ynOcIRd8jdtM
         GRSYc7yj28ndqK/xjGoWDyDvVFUJEpzgKC2sTdjainL4ffaqaBaw3Zi/3997oyKKizu8
         eLcRIfY2nCPY2M3SM9QzKmbTxyM9PO/uRO6ZegtJq22GOVGPlFGHesNrfgmPGs6E+Oey
         5+44sK/Xaov3ke8X1LL6+8GOamS0CV461/jDmbrLvdErVcvwwrsQxESczIbY2mv23aW7
         plEDSZ5yOwsyzFC61pDZY6m5XQWFK/dOVvAFMkFoXNIQrvgfZp8own4CXYQzQQZdqp5d
         /ZVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738197277; x=1738802077;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=av1w9gkzfHrj6GP18gCUm04IfEfATxr8zMSfIiCQS6g=;
        b=ZMpC2cln6B7gCAI+XHSUWsWNn2wd2EBAFBa0DnF5hjPJx/+Yqu9ItSgJwNqC1pCSxI
         UKlmUNGLvLT4jQn97FTpBVWd2jLrdmqBiaa9gRZ7dNPdwVx0riiKsEu3xh6DHRaP+Vw9
         KaN80Z+1zmH1hryfQHk4mFiCbOCltO/Qxo4a125SLLBwvXNGCo+Gv63iinPeDaCwxBF1
         ioC4LhxtZkMCDv5U3zx5ybJTd4Lmi7mRX6lhEVgglnzF5tQtWNCZ9dc+leNKZTraYcwX
         3EmHNvQ1KRujy1V5tBUnjGYZDqFOph91WY3vVJXjGiQ1+tatilcbDfhwibd3V3VP1xjd
         UlAw==
X-Gm-Message-State: AOJu0YyDbCzzIW5+QvwEfhzY8IgDeXNytDsxBLktPg5f2LbHqODZwmMW
	tZxLyQ9Q0SF7E4jf5L3msGbDSIxBiayKHer8wU1IPhUmf4YegWszrIl3rqGWDyOlZ8PO6nIVf2m
	/emQR0Ohp7kIAWb3qiGAWFiClDOMyGA==
X-Gm-Gg: ASbGncst/4Ov1QNChom9+7ctuC7uL14xItEzjF8Zg4SCtL8AwGaeO0R2eYT7wRR5xk4
	kE2rJUt+z6cOC9biNfq3jFzoPC2YDrSdUK8ihY6uaZWl+1mzG6GEdCESYD1h6yOHqOo+RBrXoY4
	1OyB9MUC0b/Frq
X-Google-Smtp-Source: AGHT+IEoHis17pLFTKX6jWGuGsMmD2vbvKzYrsrheHm6x+MHJqZ6Uzbc92g7YMIqORNb1Nwkf3/B7Frm4438zNAA/Ck=
X-Received: by 2002:a05:6a20:841e:b0:1e7:6f82:321f with SMTP id
 adf61e73a8af0-1ed7a4dccfbmr7773294637.17.1738197277365; Wed, 29 Jan 2025
 16:34:37 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127233955.2275804-1-ihor.solodrai@linux.dev> <20250127233955.2275804-6-ihor.solodrai@linux.dev>
In-Reply-To: <20250127233955.2275804-6-ihor.solodrai@linux.dev>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 29 Jan 2025 16:34:23 -0800
X-Gm-Features: AWEUYZmEWx_K9Ya7DLS0WPozFyusWZBCZDXU8xYKL3XD8zhdEl7yi08mzckMZG4
Message-ID: <CAEf4BzZ59q-A2+X+i7zRQULgXEBjJGjD=Mu0kd59Q+TbYcsSSQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 5/6] bpf: allow kind_flag for BTF type and
 decl tags
To: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: bpf@vger.kernel.org, andrii@kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, mykolal@fb.com, 
	jose.marchesi@oracle.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 27, 2025 at 3:40=E2=80=AFPM Ihor Solodrai <ihor.solodrai@linux.=
dev> wrote:
>
> BTF type tags and decl tags now may have info->kflag set to 1,
> changing the semantics of the tag.
>
> Change BTF verification to permit BTF that makes use of this feature:
>   * remove kflag check in btf_decl_tag_check_meta(), as both values
>     are valid
>   * allow kflag to be set for BTF_KIND_TYPE_TAG type in
>     btf_ref_type_check_meta()
>
> Make sure kind_flag is NOT set when checking for specific BTF tags,
> such as "kptr", "user" etc.
>
> Modify a selftest checking for kflag in decl_tag accordingly.
>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@linux.dev>
> ---
>  kernel/bpf/btf.c                             | 26 +++++++++-----------
>  tools/testing/selftests/bpf/prog_tests/btf.c |  4 +--
>  2 files changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
> index 8396ce1d0fba..98919c6b6b87 100644
> --- a/kernel/bpf/btf.c
> +++ b/kernel/bpf/btf.c
> @@ -2575,7 +2575,7 @@ static int btf_ref_type_check_meta(struct btf_verif=
ier_env *env,
>                 return -EINVAL;
>         }
>
> -       if (btf_type_kflag(t)) {
> +       if (btf_type_kflag(t) && BTF_INFO_KIND(t->info) !=3D BTF_KIND_TYP=
E_TAG) {

nit: use btf_type_is_type_tag(t) ?


[...]


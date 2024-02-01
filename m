Return-Path: <bpf+bounces-20888-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB15845002
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 05:02:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 838F6B255E3
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 04:02:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FBDA3B7A9;
	Thu,  1 Feb 2024 04:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NtNOpGBb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82BCC3B197;
	Thu,  1 Feb 2024 04:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706760164; cv=none; b=hbs/ux0Nyi68lh91sN1QaglSGdVpk0gh4vfXoOcZDR7MBgKl4S/ixjjmoQnGr+nMlAr9cRtX4LYSJM2gtSo4IR6tQfjnf1vLZ+ezx6kQSME2Oo5PUWL4m1hT0a5N5WzuFs/AUYrwNg/WS7E6O+Ddu0Lp/0a083NIOJoB9cIReyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706760164; c=relaxed/simple;
	bh=hPKW73gAksxfQpaKEhrAgPFmqi1zqRBcjvlb3w5rebQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KKGB3AoA5ZtYPtwoqI5VoxqFeRV7HrreEz1O6va8Oop8rZpVWTEgElRJi1YvcftBgMGlEBAwmcYC8THphr5l0rBcmExN9V+d/PkJTBWZRp/3hKY1bz/PDXpV6voTzD62qRwHt/5gFE0n1JalfNcBwrWj2RGitW2GWQDgFyOeKjU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NtNOpGBb; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-40e775695c6so4329155e9.3;
        Wed, 31 Jan 2024 20:02:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706760160; x=1707364960; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s1i8p9n07cJh4ODWFjIGPnEhKZdHIlULx3g4LfLVCIs=;
        b=NtNOpGBbpWnYjPCyHJstCviaGDSW4Bq1QFFkYDQc4OaJ8HBvjla6g5AQc0hoYgRaTt
         ywD3P/MySOttOnntRQKuoWF7CrvT9urmOSCNjMyYEcih+vkIRIzspjByIweLseA3Aki8
         2egp8ssCPhUXgq84Ri/knAp5iu2nbfC/xE7DYjdQ/k0j1ztffKIR/nBX18b2ZkcDvLgm
         FiKr+VdXbyclJKkIVFALxnYEa3Y1GwVvy3mMJJOzjjlM3N0eCupmZV533rs5GjeGozQ0
         zWLupO5AfxJ3FumozmQKCNNkrEX9keeYupYv4xjrO1vutZjFMKncfEUnoimh/ObqxzYk
         4rLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706760160; x=1707364960;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s1i8p9n07cJh4ODWFjIGPnEhKZdHIlULx3g4LfLVCIs=;
        b=U7jYJlxDx/b5/OIFsQdYLB4f/GAEc/DbMnNEyYyd/eqTrswpbQHfT647ICCnFsibFJ
         kyef1WyuceQ1VTfYaHpyc/s8srsePw3YiS1Oyc3Wy4f5xI07E/wxNNEXSM2s4pGF/g+R
         eT8ZhhHcAkCJPsbUoxFJJbn1js5esDg0+9PF8+ZGznxR7XyRG05yNG8MKepZsacJKVsq
         TDJTDx/vQJBr5RHtJH8SuTeEQ9skY+78O4Y/1wRVHErUihbpEtdr09429WjfmU7v3zFO
         Pcz5dZ2tyRD7a7CULcCfW/oaWfaZ4j00XBw/a8oi7vTLEWS5p3ok+p6JbGmYJfBEj891
         tkkA==
X-Gm-Message-State: AOJu0YyQ8LAALFHZFmTV7Pn4cZkW6Qsxnhg3x3azbnoA13rwuCHET7Nx
	oeTTG3NnyERCzSBODvs1/3RUxMW7xhNzs+5rWupyUn2zJeU1FncX1+/VHQkAWFPjToTdJrnAdBM
	/T5o23Trro2GoaT/rMG6k20WNn90=
X-Google-Smtp-Source: AGHT+IGGkb96zpJM/P8w8LxvQTONN/AaUnpoZY25e9Lt+ah7T6i5ENdcMUOLj7ojHL5lv5lHP3YGZ+rz1DXaZ2zPvZM=
X-Received: by 2002:adf:f5d0:0:b0:33b:14e8:c97a with SMTP id
 k16-20020adff5d0000000b0033b14e8c97amr300079wrp.30.1706760160438; Wed, 31 Jan
 2024 20:02:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201142348.38ac52d5@canb.auug.org.au> <yeujnwul3nd6vhk2pidnh72l5lx4zp4sgup4qzgbe2fpex42yf@2wtt67dvl7s3>
In-Reply-To: <yeujnwul3nd6vhk2pidnh72l5lx4zp4sgup4qzgbe2fpex42yf@2wtt67dvl7s3>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Wed, 31 Jan 2024 20:02:28 -0800
Message-ID: <CAADnVQJT8nOiiX90g3Pm7Ud0hzBBjBOQmPtPV1iwUYKMcuBFig@mail.gmail.com>
Subject: Re: linux-next: runtime warnings after merge of the bpf-next tree
To: Daniel Xu <dxu@dxuuu.xyz>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Networking <netdev@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 7:55=E2=80=AFPM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
>
>
> diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
> index 0fe4f1cd1918..e24aabfe8ecc 100644
> --- a/include/linux/btf_ids.h
> +++ b/include/linux/btf_ids.h
> @@ -227,7 +227,7 @@ BTF_SET8_END(name)
>  #define BTF_SET_END(name)
>  #define BTF_SET8_START(name) static struct btf_id_set8 __maybe_unused na=
me =3D { 0 };
>  #define BTF_SET8_END(name)
> -#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused =
name =3D { 0 };
> +#define BTF_KFUNCS_START(name) static struct btf_id_set8 __maybe_unused =
name =3D { .flags =3D BTF_SET8_KFUNCS };
>  #define BTF_KFUNCS_END(name)

Most likely you're correct.
Force pushed bpf-next with this fix.


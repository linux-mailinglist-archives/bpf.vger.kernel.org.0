Return-Path: <bpf+bounces-52608-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F14EAA453DC
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 04:17:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88C7B188B4D2
	for <lists+bpf@lfdr.de>; Wed, 26 Feb 2025 03:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8491524EF8D;
	Wed, 26 Feb 2025 03:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bHGPJ4Y/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81960176AB5
	for <bpf@vger.kernel.org>; Wed, 26 Feb 2025 03:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740539848; cv=none; b=iYG9MZiozszKDBTeB6F90Bpqti+zf+kCR99tYqTX+JF3f+oEqKTdCU+F5Ifn6+qLIlZKiAfhJ4nBWwVgAAl72HXlpOQzCs2jcDTwzvuLqVD+rJHqKLWFJqUDTVAsjL06LMDqAOJ9hl689acBJkxlfiMdy51PdUt3jx8fm0TBxKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740539848; c=relaxed/simple;
	bh=litMGS0BqmpV+uSKSeB57DVUWO6aXS90BGHpTgQdmd4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LPDlywd5Agd/FVshMmEQsGXbewbUlbGTAIqck75XNgyWlb9FRpOSAp5T5xlUvPA/2dc+27RB5IawaNawfKAxJNCcdHHnkmbRVUkVz6Az6iHZwYvFV1d7Pc7R9kl+yx0vaXb3VflLyvatf94iJ9RJD9dh6ZTGxFT223Xfi1jdZuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bHGPJ4Y/; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43994ef3872so38812625e9.2
        for <bpf@vger.kernel.org>; Tue, 25 Feb 2025 19:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740539845; x=1741144645; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwnxxwMJ7Cb9Fcxi59SXga7fciZWniVk9ZeqfJH1GtY=;
        b=bHGPJ4Y/jBREzaYV9IQkFFRKDav1AxSA6iK2vvGqme6w7uNmGQTTb3t6HOTwsOZWsH
         7G3lm5W9DU6XRvwPrzEvzyQGDKQ8BwrQHQZ2BV1g12w15fDz8lVdC+kkIZ9zTRhi7MWk
         H0//mBfLEpE6Bd88RGuOA5A1aDLjrHx4zw8izVCPfvtdi2EDWOHLHo03mUtRtZUpjfL8
         TMg3qTE3t4lN7QmuPkBIC+2NJD3mRc12lCUWqceaDRZyRB00dvw2PhYVi6NA0SuCa8Yx
         oiuhDaPYTRbLUMdng2EdmPjiZ/eOKU/jeSo6mNFZqvAl99ZYDXbTWoR4O8ryy7LKPY3+
         e1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740539845; x=1741144645;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pwnxxwMJ7Cb9Fcxi59SXga7fciZWniVk9ZeqfJH1GtY=;
        b=I6ErYt3zFu3mHezHafdBWOQXj5dh4rjE8SCzHCGTP4dlUXgaRkEhZkPezKXPe2Lu5D
         AJh2fhKYGv4ZMktKJvm7m5npXMLsKzOPp4zcYJbXsAMXxkBOzzkVSvXnoDuBbBTsUeyZ
         StMjUForvck0/VDgC4SCpQOe4wHEZxzQdtHWoHJHeWLkzASGE/NBTp48oMPWCldsYPM2
         rjBDnEbXvlSsA0f+kfVnfye1Lz21fvNc3Fifent5L56K8IAdmM46HwB9P8bnZP/A6Wi+
         ZKjky3te93D9Ldai/3qJuQdgbhnGO6e/S9DAcT22ZfVUPw/+UtcvBCdVUia091ypjecq
         Lm2w==
X-Forwarded-Encrypted: i=1; AJvYcCUGRFavC4/5EK76Hv1tghrf1oBYAYnnmpU9r3LMCLU3MjnXCmXxMlHeLpTvZXsx2DhsC3U=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeekiNxuezpLhCkP0FAF/j7mBZLEkjMtCZWKr7j1Yx/BS+9E+5
	ayoP+mGbIZtkFS9ZFotfIhdDedjRMGCAGrPOZEfI4Q2m/zqxGVuDRviOdTFwpEf2dl31uu+UTNl
	OypRynkuFQwDNHWPvVBg1wQ69LLU=
X-Gm-Gg: ASbGnculuzfF7Tl00liGw2hkGLP/B80nlZyj+ynZUE0+SjSHSaNsz06qchsKqf/K10n
	yeX9wWfEw0/hrWyiidGIPS2WFq60mRhbyxwsL0tWf1JfAwo06w8oMbSDnAM7x8CKHfxksShjHHl
	9VV6y3o/kWYNrPkFzcJbXwAac=
X-Google-Smtp-Source: AGHT+IEu3YjW4a/IYJaEoxEZmNTKOlHKFsOVlrKHK8qBFdrQHlJBmpOBW6lMbJk1zsyabAfPlG8aPb9lNhgDJdCPcKI=
X-Received: by 2002:a05:600c:5012:b0:439:98b0:f8ce with SMTP id
 5b1f17b1804b1-43ab60f0c1bmr34654485e9.7.1740539844434; Tue, 25 Feb 2025
 19:17:24 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250224153352.64689-1-leon.hwang@linux.dev> <20250224153352.64689-3-leon.hwang@linux.dev>
 <CAADnVQKOeKfxL_3tCw1xWNS1CpXz-6pVUG-1UWhZwpPjRy+32A@mail.gmail.com>
 <CAEf4BzaE+sRmnPMN_ePQ1sa7wHuRNn9zktu85Z5=BRyyVEXM=A@mail.gmail.com>
 <f6a428a0-9016-4c38-b03f-f47504d08826@linux.dev> <CAEf4BzYQuX_+sz+0jsD_YHdoH7S4ROja28nhQH4ixzDcyW94PA@mail.gmail.com>
In-Reply-To: <CAEf4BzYQuX_+sz+0jsD_YHdoH7S4ROja28nhQH4ixzDcyW94PA@mail.gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 25 Feb 2025 19:17:13 -0800
X-Gm-Features: AQ5f1JrGJGI9DKtY34UXAj4fyfiTxXAy6N31NVhKWepPawYhmYSGsQ0WdIpFR7M
Message-ID: <CAADnVQKf7k-qW2Bccka_vHEeC4C9b=SbcCOCe-ZDPskW8Gd6Dw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/4] bpf: Improve error reporting for freplace
 attachment failure
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Leon Hwang <leon.hwang@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>, 
	Eddy Z <eddyz87@gmail.com>, Manjusaka <me@manjusaka.me>, kernel-patches-bot@fb.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 25, 2025 at 9:19=E2=80=AFAM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> > But, how can we achieve it?
>
> There is no *elegant* way to do this, but I think we could retrofit
> this as extra common bpf_attrs into existing bpf() syscall. Something
> along the lines of:
>
> struct bpf_common_attr {
>     __u64 log_buf;
>     __u32 log_size;

other than missing log_level I like this approach.

> }
>
> #define BPF_COMMON_ATTRS 0x80000000

negative enum/int is a bit meh, can we use 64 instead?
In token we have:
BUILD_BUG_ON(__MAX_BPF_CMD >=3D 64);
and delegate_cmds mount option too.

Currently __MAX_BPF_CMD =3D 37
so we have some room.
BPF_COMMON_ATTRS (1 << 16) is fine too.
Just not the sign bit.

>
> static int __sys_bpf(enum bpf_cmd cmd, bpfptr_t uattr, unsigned int
> size, bpfptr_t uattr_common, unsigned int size_common)
> {
>     if (cmd & BPF_COMMON_ATTRS) {
>         cmd &=3D ~BPF_COMMON_ATTRS;
>         /* read out bpf_common_attr from uattr_common */
>     }
> }
>
>
> i.e., we add two extra arguments to bpf() syscall, but only look at
> them if we have an extra flag set in cmd.
>
> >
> > Thanks,
> > Leon
> >


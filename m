Return-Path: <bpf+bounces-71666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A6BBF9D06
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 05:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D84454ECFB2
	for <lists+bpf@lfdr.de>; Wed, 22 Oct 2025 03:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D601D2327A3;
	Wed, 22 Oct 2025 03:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fqiV863w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2E719E82A
	for <bpf@vger.kernel.org>; Wed, 22 Oct 2025 03:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761103254; cv=none; b=NbxUcPt9zWFcimvxWqc18LTJxcb7uysLTosRlyWRcIzeRMf/lJlBtQhGlm2q+tOUZV0hUM9Rb/dcEOx1wvhXihGiusXhqekSKSirVdATZV++6283kKsdCifoiLv9RQcXbrAB5cN1QXG5BoI3r4iFz0BCRSFt+pXU5CjtryfF3l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761103254; c=relaxed/simple;
	bh=+X5SqWoDFfoI2c9akgItJeGjJLH1IJggeu/maoBWvRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AYKNvp+rFc4ZuBUjMgMavmHBu2auRDVDZLZazlXwpUlCJsay2ZKEUyC9FkPlu4g7XmDIKZy1g3cxZuyxLHUbLAHlFv4J/ehyQ2QS5LLcF36CJDu7PdoIHZdX6d9wrM1iwbhaLBPfWzs6xA6WSLNYP2ukfqtGbueJ0GDb3OQGEo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fqiV863w; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-427091cd4fdso3046186f8f.1
        for <bpf@vger.kernel.org>; Tue, 21 Oct 2025 20:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761103251; x=1761708051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+X5SqWoDFfoI2c9akgItJeGjJLH1IJggeu/maoBWvRk=;
        b=fqiV863wNzHDQzq1LRtwN4jg+4gdphknq/woOxOCZxvvlaMohu+vTolG9w3zCYgOGF
         r5WKXV8hRsWwPPLZ3rKYjXcY0WeyYgQ0z30QxErKQgxEIzzzbwGu1DCHvoZpktg2cTAS
         vaVLtVNAYc6ZIaSziP5qUzgwTTc/lj7jA38UpL92S/6DxO6634w5FhZCAuvrXFSljVww
         vXe9XplLKnF51j6A//FW9HThdcZM6JHk+/V8QXajtmkR4yQfWLDgGItPwyOp3JVf8rgh
         m/GgMwEel8hujTdb+hSl6DtdKLJn3b0Mc+4w1fPHmbapJd8ATHdU5J1zu/nY1njYTM3Y
         C/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761103251; x=1761708051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+X5SqWoDFfoI2c9akgItJeGjJLH1IJggeu/maoBWvRk=;
        b=iRtxlOxWDfKExwrKa/9+m3bRUfggMOmliCBSuPglwkKXn4YsnG3++q+sPpIvq7d7/s
         7mVPwWAaz1jvv0Bc/Y/jyardjklHh+OjFHVCbXZe8IBoNgYEWLO8Gay8+URW9Z6UzYd3
         zqGau2diFQfrgccXWTGGHyohintOvYU7UlefDMD5TQDGSkbEF4Q8Eq9R3jowo3p+PwQ2
         NzltUDuJOQcXTytdkn2EK5zCsQh8JSl/op52bdk8Cxp+547Eqwb/3IJ6fttmC0u7A1JD
         XJukjGBugGcO72hkqVMxaskpHpDFQHXZKvVsaRXLVr2VV4j4ToDXPgKlxHZn3cKXGPqt
         wuaQ==
X-Forwarded-Encrypted: i=1; AJvYcCW7V0u37GVlZthFpAvkplUhyZWLaMuxhx0oW8dyuuxpLdr4oxZJYv6aAA6JKy2TI1Ja0Q4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2ClOXULIQxZyD3oKSwHavnzMSPbvWA/siUk5x5Qz76+2GcEWW
	M3rdpq3oCr/joRr4X1JL7wALRz80uK93+QPgVclAvFpXE6PkgeN8nTAxwK5tYeqdXWikpW23W2X
	xTgpDK3GnLWop9IBvU+jF0Yh4OX6zpFk=
X-Gm-Gg: ASbGncu/aMCkHB96AF2TE9RK8DM0dDtuAXmYKx8TvrGEGMfXrnCJ9kwviop8gbFmt4v
	SL+/atzPpiPjYRWu4Qqef/LHyxTj/ZTZ4HFD8+6iq13giJVURNg2+NyO8unyfPtV5vZySXrLdfq
	mMJ0YMa08oCi8/rB7rA3b6/EciNiPkke9t+czv8RGfXkVnrz1/66r8w2nhUv2Lgo+iU2XyEXVuo
	hq1JLksOs4aGctqeswTZjF7cAdDFf33VpYn9VxqNGdWcS+MmM7XEyNCzU9JDX4QxPeiU39xiJnE
	RWqACRztijoaOm+t5mXLZZqiG++HUWyH18A3jNA=
X-Google-Smtp-Source: AGHT+IE50lKb+kPEoKZc5F3yM7N6BTaVXzqzA0yb2g3dXRmZDfN34hIy3RF0WFwJUXE1TFtQJel2WUllphPVQvGIhcc=
X-Received: by 2002:adf:e19a:0:b0:427:613:7772 with SMTP id
 ffacd0b85a97d-42706137842mr11242112f8f.32.1761103250588; Tue, 21 Oct 2025
 20:20:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <636d45a8-cdc4-46ce-b1cb-6d2e4e3226ae@hust.edu.cn>
 <CAADnVQLFuMAYHXXd_=2ebnhsE_tECKrVcLwuOt9b0dK4-Ww+gQ@mail.gmail.com>
 <034fed44-2640-4338-8f7a-89a4c9c4af6f@hust.edu.cn> <CAADnVQJ4HeTzm+2DNSFG83HF01OxN98QLXZ_zUVThsMzSF6=CA@mail.gmail.com>
 <7b86d9eb-313d-4a3e-8547-6a8c1ec2caaf@hust.edu.cn>
In-Reply-To: <7b86d9eb-313d-4a3e-8547-6a8c1ec2caaf@hust.edu.cn>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Tue, 21 Oct 2025 20:20:39 -0700
X-Gm-Features: AS18NWDI7sGDOd_4h8R6aGR4qYNbtyuA1mLh5TyeFyaBk0xVrcOZBXThhhFluoo
Message-ID: <CAADnVQ+GuhM5ZbPPZ7R_pVfEjsfX_rneqaEtZ-u_qABQetJ3ZQ@mail.gmail.com>
Subject: Re: Information Leakage via Type Confusion in bpf_snprintf_btf()
To: Yinhao Hu <dddddd@hust.edu.cn>
Cc: Daniel Borkmann <daniel@iogearbox.net>, bpf <bpf@vger.kernel.org>, dzm91@hust.edu.cn, 
	M202472210@hust.edu.cn, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 21, 2025 at 8:08=E2=80=AFPM Yinhao Hu <dddddd@hust.edu.cn> wrot=
e:
>
> On 10/22/25 10:20 AM, Alexei Starovoitov wrote:
> > On Tue, Oct 21, 2025 at 6:42=E2=80=AFPM Yinhao Hu <dddddd@hust.edu.cn> =
wrote:
> >>
> >> Hi,
> >>
> >> Thank you for reviewing our report.
> >> We have verified the content in the report. Could you please point out
> >> which specific part caused confusion? We would be happy to provide
> >> additional details or clarification.
> >
> > Do not top-post.
> >
> > Am I talking to a person or an AI bot?
> >
> > Did you read what you wrote: "programs with `CAP_SYS_ADMIN`
> > to leak kernel memory" and that made sense to you?
>
> Apologies for the misnomer, it means that if the PoC is granted the
> CAP_SYS_ADMIN capability, it can trigger the vulnerability and cause
> information leakage.

I thought AI can read the code...
Please see include/uapi/linux/capability.h
what CAP_SYS_ADMIN means and what is allowed.


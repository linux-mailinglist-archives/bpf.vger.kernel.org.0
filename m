Return-Path: <bpf+bounces-68899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2565BB87B86
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 04:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2C87BD6C7
	for <lists+bpf@lfdr.de>; Fri, 19 Sep 2025 02:19:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDAD0257435;
	Fri, 19 Sep 2025 02:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I4E1cU+r"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05C2254841
	for <bpf@vger.kernel.org>; Fri, 19 Sep 2025 02:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248386; cv=none; b=o47pM0klFVbTs4XKbz9c0EDhwOSPTlHVv5tLLKv9fmC2ZikswOt6D+oq+s6lwrc4UF8Uc3494JZjgB/Q/NcRURGtyEI75Ljg4h1bEELX1d29gEybllkp4wVAUeSdUTrys16l03W2OS8fxQrpTZEO69zqoMOsyTnf/GRQ/iYiQV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248386; c=relaxed/simple;
	bh=emvmFV6gt4sH77fH9Bh1RItBSzfNP8I7enfoTm7bE2g=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p9jxKttTSgfJ1Si5jgqVfWD+WzPIvZ6kJHUH29KRFf3miOJ2SiaWj0h6o05IAgqrg8ppUgUFAgOj65hwpws/obGV/b3bEaez1jVtobESxyh3w1CTt15eypOrVTjNbf2GaV8nSm7z1AeEObMvxdUrYOpgUYXi8lEdW5NsnG8/Ku0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I4E1cU+r; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-45decc9e83eso15508455e9.3
        for <bpf@vger.kernel.org>; Thu, 18 Sep 2025 19:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248383; x=1758853183; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R8n7EY/AGGTtwI6KgYgIDwupIYQFTu+v14oHPas8+fk=;
        b=I4E1cU+rI9Mz4D+xFTdxvD4GIv/38o4CGbRUYUvGfNkKMAP+A2faMdyPB5r5DGr1FP
         2fz2u+zqyJ2zz1Zi4Q/fJEwk1XPihngOyNSoFgiwaSo81t/02E5LTXcrPjKyZhuDvV/H
         3cUFUHs2y+JYO38R+/EcZewEgA8aBxgmNegnll1vuL3fNl3Uz3p8eR9JZIkDo9+pU1hJ
         LN0kf7PXwbPEdwvqaVwcE7X+H4320RBVh3JH5ecZI60gKYmSTU48nTkM1A/0MMnPwAkt
         VBxYP5dp1cRaLBZ4TcrHHMb+5vbwX50qQYYuLK30yJkVE4kN/CjDw8v2R2tH6A/knE93
         0Z5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248383; x=1758853183;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=R8n7EY/AGGTtwI6KgYgIDwupIYQFTu+v14oHPas8+fk=;
        b=BLW10fVhGaInGSw+t5NP+oaLQKklT3DJaszmIKCkuu+izq8jFHn2pGyfPMUX75xwFU
         Rt//QpaAkbxUOam3AgQ0GhXourttANpsFbGMWoMi9P/eK6fB8uZfp7S+ztsEGUKwLlMm
         tmPItjS9wcrJrfv4SgI2pId0nij5p1iZzTzQ3TUtR0ZGQoH9eZMGm8p1yCwnzgD77Dr1
         YWWJqJzAkG+SiC+OL5CxuuHi+JwFQebErdXvBoQzkFp79XphsJuQ+lV6kd1XKVvWepR2
         BFBNyimpAF3Yv0GuFqF9k7JctWcfVMvhKZUm5IfGzdp5ijEFetU3fiYs+DHfaLh57XX5
         8onw==
X-Gm-Message-State: AOJu0YxrTamu9JxQ7EMASa9WbAIBJnr30sC9PSC5gwbQ94K582d6C9rJ
	wm/+QZfVzlwv3UO7tjHIV3UL2r3aCU/0C1KO6yz0VEKUfajn/qXaP7pyCRc4MLhkhoMs/QIia9u
	tQlx8mEgGkhoLhCmEIzXQeGMgdGzPcfk=
X-Gm-Gg: ASbGncsse1ofM3hTOz4/B4mz6lhYFg79cb2FGnmy8DOTtaSsMFZO3hDCx+KZlGnNCvA
	5UoPJQnbGh0awFPxZuxg6KPu/nVp1qsVrTvc2EBCpDo4/FKFIo/6MxxxBo1VYuXIQjif2IachbF
	u1XZPcOgQT/iBxkv+zsZOshdc/b4VRnPyeMp5/NYB21iS+GHNMOKVEOjlyIUkd6fYC4CF3Yf7OK
	ilUsvX/G+7ePifKyZFsxKceed7u469/F4OYi18aD+iGxHrujHfDxok=
X-Google-Smtp-Source: AGHT+IFSIllND5LsmTREPu1Jp792g2q2mvMQXo40LGCv1dkyhPlNQC5E07prEnb0QS17ki7xd/BN+mS/CxsfwEqTolQ=
X-Received: by 2002:a05:6000:2689:b0:3ee:1125:fb61 with SMTP id
 ffacd0b85a97d-3ee7c5529a4mr959660f8f.7.1758248382964; Thu, 18 Sep 2025
 19:19:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250914215141.15144-1-kpsingh@kernel.org> <20250914215141.15144-2-kpsingh@kernel.org>
In-Reply-To: <20250914215141.15144-2-kpsingh@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 18 Sep 2025 19:19:32 -0700
X-Gm-Features: AS18NWA2D9XDvX4ildEjyo3VK1FVBBpLlviSn1PPafUMaIeLPTItIZ_4bwmvcoI
Message-ID: <CAADnVQLo8udasPu_tWeffY88opzpxb2Xj9c2ppt1Lvz5VkRUvA@mail.gmail.com>
Subject: Re: [PATCH v4 01/12] bpf: Update the bpf_prog_calc_tag to use SHA256
To: KP Singh <kpsingh@kernel.org>
Cc: bpf <bpf@vger.kernel.org>, LSM List <linux-security-module@vger.kernel.org>, 
	Blaise Boscaccy <bboscaccy@linux.microsoft.com>, Paul Moore <paul@paul-moore.com>, 
	"K. Y. Srinivasan" <kys@microsoft.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 14, 2025 at 2:51=E2=80=AFPM KP Singh <kpsingh@kernel.org> wrote=
:
>
>  int bpf_prog_calc_tag(struct bpf_prog *fp)
>  {
> -       size_t size =3D bpf_prog_insn_size(fp);
> -       u8 digest[SHA1_DIGEST_SIZE];
> +       u32 insn_size =3D bpf_prog_insn_size(fp);
>         struct bpf_insn *dst;
>         bool was_ld_map;
> -       u32 i;
> +       int i, ret =3D 0;

I undid all of the above extra noise and removed unnecessary 'ret'
while applying the first 7 patches.

Pls address comments and respin.


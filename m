Return-Path: <bpf+bounces-23194-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B0386EB15
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 22:23:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7EC1F25F39
	for <lists+bpf@lfdr.de>; Fri,  1 Mar 2024 21:23:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59AAD57864;
	Fri,  1 Mar 2024 21:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JAxhzuNL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6047B56B98
	for <bpf@vger.kernel.org>; Fri,  1 Mar 2024 21:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709328183; cv=none; b=fK0G18ADsmliJvv46L7Dr+AZQBv7ksbIZ0hCMwnuOWTGXq2KKJB+pNdb0Ath9anc9qqEF/SHmTQYjKsR8DIgcz/+TF+WuZUyakptTCpya+ZTna9wDh2kWEVPXQC68H53rgxBQORHMpOjg64mC77+3hAlky+7h/cQj9rKjFZXDxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709328183; c=relaxed/simple;
	bh=LOrtvHFv2f/VDRK1rqtxppAJe7svYSHNXM2bYtLrPPc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FhnAgmQY1D+gjdOecYB97olmCGNceFsP/7FyOXnaHo49RTDNJ9DS0EhoUSsEBzTgnpF3IaKFkR6uVZQh8m+rcJsFKRVkSVDUdpdmA/MKoOkpPIQBKslddKS6Oa9S8SkYeLpBBqy1ZX3E79OGe0Ppmd4m6vVLOGQzpNTZxJX2Shc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JAxhzuNL; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33d754746c3so1312231f8f.1
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 13:23:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709328180; x=1709932980; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rdgqiGnEIEZ9WsxPyRmKlc22d5K3UBRO1JVmpTIP87Y=;
        b=JAxhzuNLahaitGfu4gnWvRkXLHZUZbJqLsvzLkxghOB7XXCD4ELYrucmuVFwjx3TA7
         MlNbaGILEepHL8XLjvLVvHYtBc9X1NwZbwOLod/jT6wsGB2Wq8SdrH2W3i+xa4qzz2Hd
         Su56O9YKLxDP8gFOhbfVPdXlwxrbna/5acKPXQWV8DHXcaXB3Rsr7Ik+/BsAApk2eqci
         zX79Dk/opl7CgF4YP9AoYJP6Vwb/NWS/PpEVwwev60d5T0Ova3AaLD2ErLxKy83b3cjl
         J6oy9bpeZMpsIwX4juvZUuuRmFRZnVJVdGSrIxaJx7Qv2eyklFMU42ul0MXif5CNRpCd
         u9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709328180; x=1709932980;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rdgqiGnEIEZ9WsxPyRmKlc22d5K3UBRO1JVmpTIP87Y=;
        b=IuzRvoVN/6j5OEOPyxI+tLSevjb9trbefyEX+/erpQd2tYODZjMVFnHTBBiSlrqBPx
         KbKRmluqJUDEW+GKiokBsj5XqbhfT72xbYxpn/t4L4tdb+703G9Q/oxHCkqny2CFSoMH
         fQIAeE3hzSj/kTbv7PTOZm9yo2EFmaX8/Iq8MTwjVxUQxOBsonEaG4loQ+LQ/tEx0kTv
         UbNONnPESrqTVLtn/cXR0wY2AqGoyBK5trpwTWu0CV6LpHBqLF2zueBH1Ut7z2Yd0JIG
         Z2vBKLSK0yrA9bKRUSVpvGfirIWDiPB1Hc+dcKv2qK54SwL54jfyMZ67InVMjfLNrpiP
         pl+Q==
X-Gm-Message-State: AOJu0YzcnQ48lhatwtgzGVFO4YrW832I9AfVfvtEt0ndxUqutjjZaTep
	CAeh+mOGo1JHzIt+nLkRpH3R9hG+HZk2wdFdYfrTnGNjl/DIyzzuGvRnXbePn3RIq9Tw4iVcBrf
	kaxvFfna/q+QlbNDp/LBUACGrbX54OoGlbME=
X-Google-Smtp-Source: AGHT+IEfKahnUdgfPfK+++noEdw9YbCntz7tKxbSl9suw0FOJwI2fmtYw34CdzE4AuKNKULMklfGeNm2c0PgozO6ko4=
X-Received: by 2002:a5d:4c46:0:b0:33d:2f2f:e779 with SMTP id
 n6-20020a5d4c46000000b0033d2f2fe779mr2098704wrt.40.1709328180301; Fri, 01 Mar
 2024 13:23:00 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301033734.95939-1-alexei.starovoitov@gmail.com> <20240301033734.95939-5-alexei.starovoitov@gmail.com>
In-Reply-To: <20240301033734.95939-5-alexei.starovoitov@gmail.com>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 1 Mar 2024 13:22:49 -0800
Message-ID: <CAADnVQKUdHhccL4f6pSS+GU6oPevgb53a=NtY1R8f8MaQgazwg@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 4/4] selftests/bpf: Test may_goto
To: bpf <bpf@vger.kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 7:37=E2=80=AFPM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> +#define ARR_SZ 1000000
> +int zero;
> +char arr[ARR_SZ];
> +
> +SEC("socket")
> +__success __retval(0xd495cdc0)
> +int cond_break1(const void *ctx)
> +{
> +       unsigned int i;
> +       unsigned int sum =3D 0;

This is the reason for CI -no_alu32 fail.
I'll fix it in the next revision with:

 int cond_break1(const void *ctx)
 {
-       unsigned int i;
+       unsigned long i;
        unsigned int sum =3D 0;


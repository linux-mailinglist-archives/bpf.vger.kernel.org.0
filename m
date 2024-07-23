Return-Path: <bpf+bounces-35304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C1E939782
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 02:39:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 657A91C2199A
	for <lists+bpf@lfdr.de>; Tue, 23 Jul 2024 00:39:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 213588249A;
	Tue, 23 Jul 2024 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnHARTKK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EB018120F
	for <bpf@vger.kernel.org>; Tue, 23 Jul 2024 00:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721695162; cv=none; b=Jls6v4rJ7PPGYM/YxIUhrhFHgWMdJ1qk82kap/4Ti6z6BoHBg6G/+9xQcL7d9W3rk8znzern7JtWXVFWvUL0C17I91xKAdK9UEM3DCEKioUseWrZGhSnoE2FdeRfKhoYDr7Dm84qnt6f1WbNsuNID6VaVaE+UXQ9aCQOvGmVoVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721695162; c=relaxed/simple;
	bh=Vr7rmjat4ZlPABax0oAUWmyGTitEAol85O1PyZKqvBM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXLJBTQYQVwY6rGdZZ8MhYLhEdN9pzx1fmrlnPiKkn+5Oc2f55kUBi27d2HgR861OHJo5qZSf+WmRVWPQuiUPKIQPU0SkU/LlhfxEYJLMRUYjTwMIACJqQ4OJftNIDgb1AJ+SR8AMUyDam2gziNMGkSG6cR8XtiVQrv6GMgrxEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnHARTKK; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-427d8f1f363so26156425e9.2
        for <bpf@vger.kernel.org>; Mon, 22 Jul 2024 17:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721695159; x=1722299959; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3jKQw8JF6MUR1eXqOX577AFCii9A8tRt4rni2pckpCU=;
        b=XnHARTKKqs/N4ZC1gKc9j43gimOG+1PE44ZfOB+HU+85anbgA17kCzRUZalfOF/VG6
         JOcIIZ9K0v5CW+Bw8iT38n9Po5Jh+tsrT309KDJl2xZ2ELhbQxnjYDvRMPBpYBvsVWxO
         pcORRhGK9qHX1njs3/sFx3p6lurkw+CL71WFILYHaHxiGSGmXObdij4ufkk/84pue2Bo
         tL1lMTCiFyIG3Lj4CIgtlGbt4tGr6IOVMemkV2WazH3my6KPUxK+KFoyxHt3Y7qlqZzP
         QDVC0rc8Xoc10fmHAzjWv5XxztBrnZufaSbPxNUSafSJ4drFjH9oYQiUGnLr4YLum1tG
         NCiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721695159; x=1722299959;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3jKQw8JF6MUR1eXqOX577AFCii9A8tRt4rni2pckpCU=;
        b=pEvrZk5+4NCDJFwPEgGtboAUVv+lisen5rHdgeVNutkEAC3zQLHqqT+Pt2VJt/UdXK
         cBhGaoBgnFI6ZEIqojWOX9MbrTT8dqTaGdmVypKQfUH5vaFPaZLDJsQug63gcD12jCpG
         7luGiOgDy9a7bF8EcatacNUShpFH4rgCW5PleFl3IBRPRBbkwsVDhZ1gUMgkmTuB8uYl
         eqyvDSBy8inT4CJ+9c5HRMnwFoJCmazfQ8zdZoO2ODAvkZqjBvZ9NdZ+yy8mcHeRfVTX
         /t+zENJvjY2vJoiwP6kaIb/mJ00MEPB1d7sb80UlhWN0xKxrXIfhMMj7OiHQuP/HpCLN
         iT9A==
X-Forwarded-Encrypted: i=1; AJvYcCVgrSDbBXhpYtvGFyFOwKiJ59/FsBREwYuUIIdPfcRIgjJCqlRY0eFf6MkYbGHJru3x54QIhcV/VNwf1Zt6a8Zvpyro
X-Gm-Message-State: AOJu0Yym8vWDQeEJp/acB2k3GTeBzx9/buO2IQfc5edzMv/5s82HOz9O
	K3769+8XkaGBd/3C7KaMbdThMJTl+1W/GamTQPWzwxCn/PCFWhWHboj8WPPhP2D4bYXwzLsjHPV
	QUSISrCEyEche2/+CX2xXw64byoU=
X-Google-Smtp-Source: AGHT+IHo6/QEhVVckR5wus21wMwffeJPmUCEgmktQfxePmAm98/7iJboqNj4SerVYEz1966bSl0RBPJ7WcZqPWhSuQE=
X-Received: by 2002:a5d:5744:0:b0:368:5b78:c92e with SMTP id
 ffacd0b85a97d-369bae136c6mr4777211f8f.24.1721695159294; Mon, 22 Jul 2024
 17:39:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <VJihUTnvtwEgv_mOnpfy7EgD9D2MPNoHO-MlANeLIzLJPGhDeyOuGKIYyKgk0O6KPjfM-MuhtvPwZcngN8WFqbTnTRyCSMc2aMZ1ODm1T_g=@pm.me>
 <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org>
In-Reply-To: <172141323037.13293.5496223993427449959.git-patchwork-notify@kernel.org>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Mon, 22 Jul 2024 17:39:08 -0700
Message-ID: <CAADnVQ+F6JKp1e61NC22wt8L9YEVAz9w648GvdV8hUrM3dkDFA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] selftests/bpf: use auto-dependencies for test objects
To: patchwork-bot+netdevbpf@kernel.org
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, bpf <bpf@vger.kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii.nakryiko@gmail.com>, Eddy Z <eddyz87@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Mykola Lysenko <mykolal@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 19, 2024 at 11:20=E2=80=AFAM <patchwork-bot+netdevbpf@kernel.or=
g> wrote:
>
> Hello:
>
> This patch was applied to bpf/bpf-next.git (master)
> by Andrii Nakryiko <andrii@kernel.org>:
>
> On Thu, 18 Jul 2024 22:57:43 +0000 you wrote:
> > Make use of -M compiler options when building .test.o objects to
> > generate .d files and avoid re-building all tests every time.
> >
> > Previously, if a single test bpf program under selftests/bpf/progs/*.c
> > has changed, make would rebuild all the *.bpf.o, *.skel.h and *.test.o
> > objects, which is a lot of unnecessary work.
> >
> > [...]
>
> Here is the summary with links:
>   - [bpf-next,v4] selftests/bpf: use auto-dependencies for test objects
>     https://git.kernel.org/bpf/bpf-next/c/a3cc56cd2c20

Andrii, Ihor,

not sure what happened, but 'make clean' now takes forever.
Pls take a look.


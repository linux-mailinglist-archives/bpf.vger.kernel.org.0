Return-Path: <bpf+bounces-63292-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D014B04DF2
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 04:45:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9824A7660
	for <lists+bpf@lfdr.de>; Tue, 15 Jul 2025 02:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279F61B043A;
	Tue, 15 Jul 2025 02:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iGNL57u9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f193.google.com (mail-yb1-f193.google.com [209.85.219.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534645FEE6
	for <bpf@vger.kernel.org>; Tue, 15 Jul 2025 02:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752547543; cv=none; b=OuNaYLuc0dKHenx+RhvfBR2oELvjSBuHuWwCmCwvjshTAnyPYsjkRzGXT3/aIEu5HVA43gB6FbSV6YQNYJq0rjdT895+Yja7tL1uEJ9s5LY3q5yGaydKNnfXPcs/nHLOMDDddyi/oVxFIL+jrSZA1nrh/ojXvxLYlDlSkms2TUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752547543; c=relaxed/simple;
	bh=JiAajW+z3ZYPT+V1dNcNylkpH9j+9GG1zaSk3WE9mmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H79LyizDSq5ceXClXxtgKwUQHccHruaXDstuZxuaCBWxWmUTj6XAFqxe/s9HWN2ra2XAYDB5l3AwZPQvYiu9F8xkPDfE6fBTzFfsA10jMr6wly6ZkY3/61UqNbzFl9OnUklaws3NeNqiUIIJvhZErWD+znmhHOpQew8BFdRUABg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iGNL57u9; arc=none smtp.client-ip=209.85.219.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f193.google.com with SMTP id 3f1490d57ef6-e812c817de0so3998558276.0
        for <bpf@vger.kernel.org>; Mon, 14 Jul 2025 19:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752547541; x=1753152341; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiAajW+z3ZYPT+V1dNcNylkpH9j+9GG1zaSk3WE9mmE=;
        b=iGNL57u9zX2AOUzCqejizvSp0J5GG/gUExoAGvj2vVwkM75CxPQCFs/FjCIO1az22a
         WWZy956Ayl2aanXkhjfikHQQ/NavE54+PjFWOXdR2rPXkRGD78oxj/YvyV3zpzbit862
         bVj7meVjvnFWdvzR1BRAwvaE4+DCR4cs2+JDLRGFpXf5jdsM+TcjdFqb2SiH0F6nY0kT
         pEEm/v0Fhy15rrOb8hLUQT7BRqOhdKeV49wpylS/G6PhxA0+7+WjaAIbdGBx9kyS199y
         5GLXuYXDWXPfvybHksgZiF12voxSdBiyXXXOtJK4Ex0yS8jnzFW1Lpb1H0z76TYNMT9v
         65wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752547541; x=1753152341;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiAajW+z3ZYPT+V1dNcNylkpH9j+9GG1zaSk3WE9mmE=;
        b=Xzr3Zph+QbeQMpv31P4tn9kDWGoPp7GCsTXyCbmcCVrBOKBpvjN/iiFsc6Swhqcoa6
         dD/NR9takRO23M8LAXYZWXk4yA+Li3keN89AhM3CFn6J/8bhEpNi7vbf1cdfe8j4bVtL
         aSbFNK/o0X0t3te7wP/mmELvCsuJQo67yK0NxQbR9UW0IscgLxFmwRVknuFOqo30rOf6
         sNDstasWtiGQrmWO6eWlbbOija6kGgKuWWsSZvDlBEAQP70+igYhwlSdi1/w1DzdD/c6
         7cJxBRJm87DO+gprGnGkh1nxGc2ju/0HGjg7Ky2UDSz27tRe0bSkv3srNfQfZam4h9vC
         U58Q==
X-Forwarded-Encrypted: i=1; AJvYcCX7kyoRxAODaWOw0C/ycMdxOwzxIV3XijFEismJk5plA24h5YmVegpYiA0bNQLp+jm0u0s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU84PZ1LobthFQ19M2gwz9/rczGtv9C8kkiswx5rd+dZNIOVj+
	0aEPvLT4BfDmgbxVTA5KDD8yTU0dVQ+n0e4d/MMsZMN/lPgSFspNKFV33BFrYWHnwgyO06YeHyQ
	KyyPJfMoMo9psnDzsPyzEcOw0+QoCnFU=
X-Gm-Gg: ASbGncuT/LEQmrmE+8J5CqPAE3wSEbljpDGnwZdPxnj3/Aa/5GEBmaop5iVFi+rVA54
	w+BKbD+B0mqqRCnNaafCbx6eS5Gb8aeAkYtuGTkEsfXP+lm+sXr+MNY0syejWfeYK4AYmNbqRn0
	biCvqFmlXRAzxomQf5J7RLYWygq1Tv6WA8Qa0sa3WZnmV71dqTiHpe5mwGuC9vvrVwftMykDXlc
	9MjiXQ=
X-Google-Smtp-Source: AGHT+IHuW7nGq7cqoUnY29Eio/zyknzXGJTqYA6cwjKOUNk6cfbbaHpsJf6xsFZagArpL3Nk49tQmmi40QJBh9E3kC4=
X-Received: by 2002:a05:690c:6d0d:b0:70d:f47a:7e40 with SMTP id
 00721157ae682-717d790e42emr248594427b3.16.1752547541228; Mon, 14 Jul 2025
 19:45:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250703121521.1874196-1-dongml2@chinatelecom.cn> <CAADnVQKWjvmM2sGbnVEbbwe7nRiN6omjnjP593vdJjGsqYzL1g@mail.gmail.com>
In-Reply-To: <CAADnVQKWjvmM2sGbnVEbbwe7nRiN6omjnjP593vdJjGsqYzL1g@mail.gmail.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Tue, 15 Jul 2025 10:44:36 +0800
X-Gm-Features: Ac12FXx0SoFjpVbaO2l9hdo442HwGevatGbFL0uJPzhT7XbiCLVxdBXFQN-ud60
Message-ID: <CADxym3Zrqb6MxoV6mg4ioQMCiR+Cden9tmD5YHj8DtRFjn14HA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 00/18] bpf: tracing multi-link support
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jiri Olsa <jolsa@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Menglong Dong <dongml2@chinatelecom.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 15, 2025 at 10:32=E2=80=AFAM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Thu, Jul 3, 2025 at 5:17=E2=80=AFAM Menglong Dong <menglong8.dong@gmai=
l.com> wrote:
> >
> > Besides the performance, we also need to make the global trampoline
> > collaborate with bpf trampoline. For now, FENTRY_MULTI will be attached
> > to the target who already have FENTRY on it, and -EEXIST will be return=
ed.
> > So we need another series to make them work together.
>
> This needs to be thought through from the beginning.
> Without it the feature is way too limiting.
> People have fentry attached 24/7. It's not merely tracing use case.
> fentry-multi has to be able to co-exist.

V1 contained this part. To make the series simple, I splitted it out to ano=
ther
series. Should I put it back in this series? There are already 18
patches in this
series, and there are about 5 patches for that part :/


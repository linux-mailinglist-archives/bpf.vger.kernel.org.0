Return-Path: <bpf+bounces-71011-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30507BDF284
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 16:49:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5619E3AF538
	for <lists+bpf@lfdr.de>; Wed, 15 Oct 2025 14:49:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 075382C21E1;
	Wed, 15 Oct 2025 14:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mc33ijTD"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E04C2C11C9
	for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 14:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760539777; cv=none; b=hAivx0+nraxYWGSR1ActjUZF2Nt+RwfhbnBT3mDOeH4C/iUi4LkW8OijGKBsUPgg0yDIZxzlDJ0EPrZ7Ybzkat8+KrCfLFcoHiXlXtUsUbbiY34IBAV1vZECWp5xwbK7XkJUeLJQcBprWgz/aHkQM6extonaUWg8LLzifE3TryQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760539777; c=relaxed/simple;
	bh=Ugr7IgQEch7CkBgCAdZs0bbGqpAGoYyvZ+rvrv51b08=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q9WeX3geRxJt3L8xWbWEUGOqkhvJXYpgHoEJBTUssK8CHPNkQgHBd8SsAs5f7Bxd1YlQNu+xaehAIjlczPV/W8VKoVx+SiZCo5WNzuwYE2r17pcB76eebq518VTstDdaWmWNTL9gtU+B5KR2Oy1oZNgE6CO+bOqGjPXVse0p86Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mc33ijTD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3304dd2f119so5144478a91.2
        for <bpf@vger.kernel.org>; Wed, 15 Oct 2025 07:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760539775; x=1761144575; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ugr7IgQEch7CkBgCAdZs0bbGqpAGoYyvZ+rvrv51b08=;
        b=Mc33ijTDJCf1lpTtTmF6jo7G1rBVsnlJSZqfxRzDX4fURVShHBGqv8KbywDvb1wxYY
         hfHgPv4G1pakBzFqjEgHIMs0DuzC07X5jfeL1zHrBpsiHm9FZVsxNGLrSD/OMvzPUmBF
         VAhvvZx+QXyIiu5yAAksCPXGv1v/Q8O/KjhSYHq+zj+aTLr56EMJPrME6i3fOxOdRokS
         zgkcwdwcxSsEEj5HuL1wtYM1V/EnjDyd+BWuH7Sr60VQRSEHJK1SzcmynPOsFpKZ1bg6
         tnvRFHhfu8eF3HPDvHRsW0KB4X8uRdHW4q75onqb5ozBvJNQomt5IPR25NPtun74ODlU
         EkKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760539775; x=1761144575;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ugr7IgQEch7CkBgCAdZs0bbGqpAGoYyvZ+rvrv51b08=;
        b=jgnbFHB0ENUS5OGD3ggWly2L+SvcKWUvwPRv2JQcDcCJTmUTT3rvtDCBV/qaWOCKim
         hS7w7qmrtqHzUObG1aIh46wHHH/YXQJImuTSCdvo7C4mW3/Y9kzHHDXoW591Iu6Ob5CT
         X2Gnmy+RBS++I9DbEv7LEYBTKBDnzYuc6LmzD5N61IxXpwcIGYuNQB95aiXb5EnXXlsj
         fwzXrlCzCdbd9wPc7Q32eIyySBDEWkra4v+G/YcmF8+dtrbcO6Nt/txcKIODsR5T4NOz
         JNIrW4omEmSIY1zuTD+kLGXHjyA7vNbH/jrqRsKV3z8bDJN1S/roFxIneaoHJTa28vde
         gMQA==
X-Forwarded-Encrypted: i=1; AJvYcCVYTBORnfYS1YBo71gKvjB4BDKGQSYxkYxH5wofUwstLO1/vvFfTyF1VaVCZmdZZyq7qxg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMIbEVHgp8+hiZ2HOHa2Jc8GXZKnPPlOTIDTDxoIO3OFLG2Et9
	hGpoxJs7sbkhNgofPx0GjTXRUD7LFoB1lL8svtKuXpVZOZf7jiJHP1Jcnmu2l0dCLjbQuYqcRiL
	5sApW8vAqc4W1vVe+IPE8T8eSiblCTaY=
X-Gm-Gg: ASbGnctplnxiYhKHBTlC9tu6xu90dZcULhUjdyvkOxbgUteoR37cwyMAEfxAxYUKv97
	5oCQhh/CpBgY8RwAOaLj/1ox+xVj2CnEt5j0uJpjYQuNASrr3i8qINUjwUb1KqnAFrARv1P5kR8
	Tk5PimwXbA35M4RC8MzklYUkL/qeOFt5cY2jhE3FHXKTqajy4QGCT2mHibS4dM2dl+SscAMlXva
	KXVJ2UpcF9Ft3EmvCPiMj2F9TIduxE8j6LQMQ==
X-Google-Smtp-Source: AGHT+IE69LKH/NE6WW9KYSfgI5K8eXDRrZSpNwn7Zg+fzj0drMI9U+jkzmrowvG1UrutOgnm3kdrLWQIhWCejBy9GBI=
X-Received: by 2002:a17:90b:3ec5:b0:334:29f0:a7e4 with SMTP id
 98e67ed59e1d1-33b5138e32cmr36496555a91.21.1760539775424; Wed, 15 Oct 2025
 07:49:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250912195339.20635-1-yana2bsh@gmail.com> <20250912131722.74658ec0@kernel.org>
In-Reply-To: <20250912131722.74658ec0@kernel.org>
From: =?UTF-8?B?0K/QvdCwINCR0LDRiNC70YvQutC+0LLQsA==?= <yana2bsh@gmail.com>
Date: Wed, 15 Oct 2025 17:49:22 +0300
X-Gm-Features: AS18NWC8jphTpk8XmfrNi0U2OyQEvZMStTycvFUqIt8mxiSBHWFeGjYnyBqSIBA
Message-ID: <CAEP49o+-=HeW4NgB5a0H6gM9tPJg=oNeUA1iCbXq_1qZPPaGnA@mail.gmail.com>
Subject: Re: [PATCH 6.1 00/15] genetlink: Test Netlink subsystem of Linux v6.1
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <ndesaulniers@google.com>, Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-riscv@lists.infradead.org, bpf@vger.kernel.org, llvm@lists.linux.dev, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

The motivation for this work is to improve the test coverage and
reliability of the Netlink subsystem, specifically for the core
af_netlink.c and genetlink.c components. While the subsystem is
critical for kernel-userspace communication, its coverage by the
existing selftests is quite limited.

To quantify the improvement, these new selftests achieve the following
line coverage (as measured by gcov):
- net/netlink/af_netlink.c: 84.0%
- net/netlink/genetlink.c: 88.8%

Integrating these tests into the upstream suite will provide long-term
stability and make it safer to refactor or add new features to the
Netlink core in the future.

=D0=BF=D1=82, 12 =D1=81=D0=B5=D0=BD=D1=82. 2025=E2=80=AF=D0=B3. =D0=B2 23:1=
7, Jakub Kicinski <kuba@kernel.org>:


=D0=BF=D1=82, 12 =D1=81=D0=B5=D0=BD=D1=82. 2025=E2=80=AF=D0=B3. =D0=B2 23:1=
7, Jakub Kicinski <kuba@kernel.org>:
>
> On Fri, 12 Sep 2025 22:53:23 +0300 Yana Bashlykova wrote:
> > This series adds comprehensive testing infrastructure for Netlink
> > and Generic Netlink
> >
> > The implementation includes both kernel module and userspace tests to
> > verify correct Generic Netlink and Netlink behaviors under
> > various conditions.
>
> What is the motivation for this work?


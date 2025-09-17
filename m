Return-Path: <bpf+bounces-68602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23E8DB7DF8A
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 14:39:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5B0A97AF5EA
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 01:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34AD52F5316;
	Wed, 17 Sep 2025 02:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci6fAv7+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D0E02F49EF
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 02:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758074422; cv=none; b=EznqWWmlye6lcD5uXro/yxX2H4uC+I1U2m6Ejv4oSRq4j8mjRhdVNJwrPDqcEowjVnLuintf+Czrxs2kNOLaTizyTJDD3RNS1VF3QfEgfxoo5TKobiP1XRfkW3V5h40IzWQK6K14++QpOUYZM1TI4BYE+cDkMpBPMF4zJEjNT8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758074422; c=relaxed/simple;
	bh=KCwC/Tils8G1zj8VfjodPAGBvj3LA75XORNG9eGxiR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xu2si27igjyEYnwqINFnRfazrbPw1RPRA4Bjb9n9UVvV+gG4y37kIwUFgqVj07gfx3E078I/PT5WPGYYVtXOtnfZOOHSnx20UQnScJs9ugu9Dwd8YFLNIKl7omcIDc+B3qabz7Nkff3fWdNjVL7x2C6hcw4GlY7NTbdsJyS2E9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci6fAv7+; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-758a28587e5so3118266a34.1
        for <bpf@vger.kernel.org>; Tue, 16 Sep 2025 19:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758074420; x=1758679220; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0OXwPxdIT48vjOXlf0w33hJy3bKFcwuyJwXmlOX6pI=;
        b=ci6fAv7+57M+sUmU9F22SuIAFqwIkGC9slQJMC8IN1j4A5ruSrWn6giqi2rjwHfI+U
         OCh0mnUIC/KNa7G/rfrXpeF5OHaetqd4uk+h7zrqLxdJMRXXw5jq24Xv8xlwuEI6qDZv
         cubuDwxGYN8gMh4+YvrfIPE5bSllyNVoJUMLP7niHJaPdYrKeHttI5ruKno7msvSNRCT
         rvu9SncM1SVLr8C0h25nVRipunr1a0nNmJe5ZlbnV11c/dj5x5FtfrEiNCYTIj2c3hLk
         Z+5OHxSayULPYiXXGkhLyuUbKWt83I4gQtr4FapvLdhoHyqofOrluDLggX6BN9VfkoTz
         g2xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758074420; x=1758679220;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u0OXwPxdIT48vjOXlf0w33hJy3bKFcwuyJwXmlOX6pI=;
        b=DDu7X4IFnlCnSmIAFgEBinYayk4MsQJDWBdUpR49ycHTOQBUaOi79k6fBAUGEqStpI
         s75jP0SLE1L6M8O/IKCMFn2Rb8MnLbQFRn20KidaCI89m6G9h/qu13kdsMjiAyGHx08d
         dJWEFPtNAViafhmwhPxeHPvXrsHlH2+IVuHvEh1CmgKjM5N+/l3WqZ1CtC66nihxUfuF
         OlIXrqXH0Pdp53+CEmIAy3tbFDGjt1iD5F/uzK6pGmlsHXu2UoYh0e9yq30phFl3E8iI
         geQ9ciMRIGrYaqCgwDWHmkEF/IraBQ25P+Ltyau4QioMcX0+apLv62vmhnd9qRP7s7XR
         DbDg==
X-Gm-Message-State: AOJu0Yye5ln6jWFwTeIHNBduJ6AxLgUHfvf9hi0Qoi/BXQbn77TcxV4D
	p1kJc8C6Y6eX6OyvOvk4Z2W9humhL6WU2ceMvOuvSfOGLXA4/O82Qm9ODbENHRBZSHKYqB517Hy
	znP9lbXFjxPlwbQ7sm9Q4ggZ8OPfJ9ZM=
X-Gm-Gg: ASbGnctnX5DhCkhejhj6rUgj8RPQTXPdXuCvu965MgbzRhzEO0+I3kUx6dt90tWsN34
	0tsq1pfJlBSXJz7mNldSPS5W1nFPOCq2J0Wrvga2UA3JJi/W9Eeex+pANY9qnULD7NHPRGDje7N
	92j43a/dIJLi3PyfMWP7bX83GfZsPQX1DuqmUk2Npg49M7RYjByPrZvVwVm9hRVtm8kOFtxYjyD
	bqkfYmNS443PWlVsg==
X-Google-Smtp-Source: AGHT+IEvQPffb0A49dnuVx7i/YljAiKqmt2JDujS9nYAKj8zvldXslNByuFRawd2w3gpKptjllm4V0Fh0j98yevJ6jE=
X-Received: by 2002:a05:6808:1706:b0:438:407e:4a2 with SMTP id
 5614622812f47-43d50ca6e10mr204635b6e.23.1758074420479; Tue, 16 Sep 2025
 19:00:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916155649.54991-1-higuoxing@gmail.com> <3f2353b9-055d-4332-8abe-5af20e9d55fd@linux.dev>
In-Reply-To: <3f2353b9-055d-4332-8abe-5af20e9d55fd@linux.dev>
From: Xing Guo <higuoxing@gmail.com>
Date: Wed, 17 Sep 2025 10:00:08 +0800
X-Gm-Features: AS18NWBdAeIFFQuw4_4TBuAjN3tAD7V__JxtSQD87SyNVvLVbyQ638uoAGMDOmM
Message-ID: <CACpMh+DhTYfhDom3XywEYECCk50g=c+KZy1L9tuHuu=Y334syA@mail.gmail.com>
Subject: Re: [PATCH] selftests/bpf: Add back removed kfuncs declarations
To: Martin KaFai Lau <martin.lau@linux.dev>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, ameryhung@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 17, 2025 at 12:17=E2=80=AFAM Martin KaFai Lau <martin.lau@linux=
.dev> wrote:
>
> On 9/16/25 8:56 AM, Xing Guo wrote:
> > These kfuncs are removed in commit 2f9838e25790
> > ("selftests/bpf: Cleanup bpf qdisc selftests"), but they are still
> > referenced by multiple tests.  Otherwise, we will get the following err=
ors.
>
> They are declared in vmlinux.h which depends on a ~1 year old pahole. The=
re are
> other selftests also depends on the kfunc declared in vmlinux.h alone. Up=
date
> your pahole. There is nothing to fix.

Ah, silly me. I forgot to enable CONFIG_NET_SCH_BPF in my kernel
build. Thanks for the information!


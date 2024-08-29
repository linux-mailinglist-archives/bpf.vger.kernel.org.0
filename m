Return-Path: <bpf+bounces-38463-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A2F965081
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 22:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C1791C2154D
	for <lists+bpf@lfdr.de>; Thu, 29 Aug 2024 20:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DF91BA876;
	Thu, 29 Aug 2024 20:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JHnp7tBX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D521311B5
	for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 20:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724962234; cv=none; b=mCiCfrPIc0vL871P7gQS/w5hVa6n21JmqbgTAN03aMidd1p1lPeM3l/KRvigDzdsPZrkK6PRnyloqtROFb5VV7DBlR4HwvEx5DMhcwBE/U62m6iLSB6H7JnnhJvsiOFskGFwuaBe4eMVygrjhXTXiG2XuKJUnXp2PGMi6enwTFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724962234; c=relaxed/simple;
	bh=5KVDQSRJqn1uLOrwPqOnPp59IExMMYu9Go6kY04yP5E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EsuIXwi7x6E4oZLTCceVgiJfhMFezzDctiftPhNvDoArtFwEva2x6r+zzNangR+fPHRxX6Yxf/2pZzNIL2a6s7CdV9x5K8QcI3XMHrlh3CfTmfxwrq1lEyOb4YXbkJZuemvTBdZtRV3ukqc7ONSdWCn0NbqDX46r9dBKQR5YrhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JHnp7tBX; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-201fed75b38so12375ad.1
        for <bpf@vger.kernel.org>; Thu, 29 Aug 2024 13:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724962232; x=1725567032; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5KVDQSRJqn1uLOrwPqOnPp59IExMMYu9Go6kY04yP5E=;
        b=JHnp7tBXqmcw9d2ybPEhuJbzHspZn6y79KTFnWRZhAYoCX9VSD7uwNzTxvLu5CSdC6
         fs+DZkaeuz9T3XzIAbW8Vf9d/1BSjH+KhFlZ2zCS+VtcCfEcdOfzv+Cpci/TRdXDp22K
         GzNqBj9uWk2oxMO4qQp4fu2ynndCEYNQelI1sQCV2xTzFJBHhPki+yNf37vhDIrX15U7
         Irfe1mNd8bXxMfqce6Suv7nwm5MEdBx+unOwZQYYKmPH7rH220WRFM4q8UfRL1/sd9g4
         IMT8kTrSzmsIfX6NC8SBA9uKwMh/tTWC/nxTNYaeAuXU8ZTqq1hp9QPH/pRzSHCGKBtQ
         tLkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724962232; x=1725567032;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5KVDQSRJqn1uLOrwPqOnPp59IExMMYu9Go6kY04yP5E=;
        b=nM/5EDnu7/82H8hH3lRjWlkvpgbvx4hRbGh5geScEnOtdfGEDEsqCR1sBWjXPOSGvm
         FxCITPzPol/vSsCtfP6qyK2DVNUCCCXJNjV87Vn4v7vVHq5D8nPUfLYxTnG5pd0oHvBR
         O0bjIhHNL5Qt4Yni/iNMtFB2uw85aeLr6Jrcy+RmXP06ArwiVS6vv28boYHMXYg9CB8L
         PMYjCiSlEfrnncS1MClTPVjcfgvec+8ZXrL/OzAJs0gKxg67pTbVyPUyIWbr64ZaTfUy
         EiV4/2fyn+d74fbbCWG5VLDRJtlmNxIGxvlDZpnnx02ZKPX+MBMAFF2rx/OkwILDmEkH
         URbg==
X-Forwarded-Encrypted: i=1; AJvYcCUcfe53m3j4d2xBgZfMA3x8ZWgUl6r2KL6gCjVpCABko3yqzy4gDbKiwJww4oX4UsVIg/I=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJynoCj/pV5AbQ75bnMTn6+25cv8aqWYbgTgdUxtTPObMBIZv
	WaAeIyCjygTuH+wfBKemM/YvNJ+hNGzdzZdyVqQhti8FcS8mpZN+BdVEHz9TWE4VDA++OOK4gb7
	mxj7ul2wWPAhZxt7e1SYA1fP+ERnOv+G7TIOZ
X-Google-Smtp-Source: AGHT+IFQRNbNGLHbbGCo2uMEpZQ8l/Z8Qfl7lbbo3l69mIFsmK7QVww06v7HFuoldRojF6blnNbqjyk2g2kuM7Aop/A=
X-Received: by 2002:a17:903:2282:b0:1fb:19fb:a1f0 with SMTP id
 d9443c01a7336-2052388c8f1mr664215ad.4.1724962231569; Thu, 29 Aug 2024
 13:10:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANikGpeQuBKj89rTkaAs5ADrz0+YLQ54g-0CshYzE3h06G0U5g@mail.gmail.com>
 <202408281719.8BBA257@keescook>
In-Reply-To: <202408281719.8BBA257@keescook>
From: Jann Horn <jannh@google.com>
Date: Thu, 29 Aug 2024 22:09:51 +0200
Message-ID: <CAG48ez3bxCBtWbMG7eooSivNQtb+kTixk6Z2EaEQbmLPB+G=bg@mail.gmail.com>
Subject: Re: BUG: null pointer dereference in seccomp
To: Juefei Pu <juefei.pu@email.ucr.edu>
Cc: Kees Cook <kees@kernel.org>, luto@amacapital.net, wad@chromium.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 29, 2024 at 2:38=E2=80=AFAM Kees Cook <kees@kernel.org> wrote:
> On Tue, Aug 27, 2024 at 09:09:49PM -0700, Juefei Pu wrote:
> > Hello,
> > We found the following null-pointer-dereference issue using syzkaller
> > on Linux v6.10.
>
> In seccomp! Yikes.
>
> > Unfortunately, the syzkaller failed to generate a reproducer.
>
> That's a bummer.
>
> > But at least we have the report:
> >
> > Oops: general protection fault, probably for non-canonical address
> > 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN PTI
> > KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
> > CPU: 0 PID: 4493 Comm: systemd-journal Not tainted 6.10.0 #13
> > Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04=
/01/2014
> > RIP: 0010:__bpf_prog_run include/linux/filter.h:691 [inline]

So, the issue can't be that we went through the seccomp filter setup
path properly and the bpf_prog was never actually installed, because
in that case we would've crashed in seccomp_cache_prepare_bitmap().

I'm pretty confused how we could've possibly gotten into this situation...

What kind of test setup are you using - is this QEMU in TCG mode or in
KVM mode? Can you share your vmlinux binary, so we can see if there's
a clue left in the register state of the crash?


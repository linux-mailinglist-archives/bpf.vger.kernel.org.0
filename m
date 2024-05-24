Return-Path: <bpf+bounces-30498-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED1F8CE771
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 16:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B8E01C219DD
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 14:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E8E612CD84;
	Fri, 24 May 2024 14:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="Hcr2Mbsm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CE412C7F8
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 14:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716562729; cv=none; b=LzFipaAlvpRT7wU9ZHxhJTLl3yOCnYB4w11bgyMWlHsVwIPbmBMgeL0I78ED+8sYnKH8OWIn8FjJziwYvX6fsvaMShviOwy5zcthh99iddW8s0Fl/avY56RMrtRClLfQ72i0PeCvRd2+ObXIo2A9Hlvg4L4YNg6WnIwNmV5RBb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716562729; c=relaxed/simple;
	bh=2PAF37j9F18Nf5iuq9vX6tcKGUy44bEVYVrsHN5w9GU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eDoPImnioofUZ0lsLz8NFCqALn46DUvQ74TYgmw0aTj+6T17waHDTWqaKJbBOn1Nyy9bmplCVoLcDMvUUR84FDVTK7Yxg+HRiVGaVMWlIsvRyQmXhacFE8Gz9TLswPU3+zmcqg88f08TbAf2cuYVTHlnOsV3qO5IhUt3f8Lh3oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=Hcr2Mbsm; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5295f201979so1116257e87.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 07:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1716562725; x=1717167525; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rcMspqehBFuBupFDxybL8n0NBRn8g86OZY15bYliGX4=;
        b=Hcr2MbsmZ+IdUPrT/Z53hUrQBPhqvBWWOdoMYHlgkoHNeGvbgnDrrYd/lIY2mVd270
         xIGtlZz4+UJxFwocspcYGdco3JsgV97huG1f44nlBNE4f9pp4g+MZM3c4rL62f6Gup5G
         3EPJL0niAJZ/izTWY+e/dhHLXhZFJnwK5wd5Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716562725; x=1717167525;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rcMspqehBFuBupFDxybL8n0NBRn8g86OZY15bYliGX4=;
        b=aB7ZrGCdR0DiDgf7b59O+rva7H+jk9OHjIkNUFmZUbzCCEyzSl6lPft8J462mcG+xM
         OiDdAiWordiZn36oOnUZYTMt4foYTCn9jcCfhxY1/nuYsVSpjnLWNOUEsFpsSWlDgOxM
         O3EmCOPl2Bn3Wt1s+EcVtEHTEHZyX9rdxu+iHF//AQX/fdeGp6NOOXQrjFs6dRydX89R
         XBQOxB/nwdRmrxZDTYeUV+flGtzCAc5w5O+ZyD9kC73jJ9bNJ5HF/OkeUh6DuJKJtdef
         BEz4RciQXU8HGCi2Ez/p61+bbFmBscGHfTenZaP1Eb5ca/9cLZqzEh9dtEXudDx2xD8k
         E1Qg==
X-Gm-Message-State: AOJu0YwtvyXr306G2b7RTRtlT5cyw9VWHZmt6drw1URrKD7MKGX549jL
	MxAgpEAKUuR+jy7lPX+/WAJniM3FxEKXcQuvaur7GMMtPFMPHPQB+Xaj9s+w1wf7WnktJSHHF/m
	hPgtRhQ==
X-Google-Smtp-Source: AGHT+IHMuRbsARaWOu9C6fIc92vJrfevZsLEv64Irl20Imojp80tJuNhwegouyMT3WBqBf35ftcv4w==
X-Received: by 2002:ac2:46e9:0:b0:520:5261:9cd0 with SMTP id 2adb3069b0e04-52966ca7a45mr1398624e87.57.1716562724898;
        Fri, 24 May 2024 07:58:44 -0700 (PDT)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com. [209.85.218.52])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-578524ba2ecsm1845007a12.89.2024.05.24.07.58.44
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 May 2024 07:58:44 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a6269ad9a6fso114978566b.2
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 07:58:44 -0700 (PDT)
X-Received: by 2002:a17:906:2296:b0:a59:afba:d0a4 with SMTP id
 a640c23a62f3a-a62641de237mr167222666b.23.1716562723858; Fri, 24 May 2024
 07:58:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <o89373n4-3oq5-25qr-op7n-55p9657r96o8@vanv.qr> <CAHk-=wjxdtkFMB8BPYpU3JedjAsva3XXuzwxtzKoMwQ2e8zRzw@mail.gmail.com>
 <ZkvO-h7AsWnj4gaZ@slm.duckdns.org> <CALOAHbCYpV1ubO3Z3hjMWCQnSmGd9-KYARY29p9OnZxMhXKs4g@mail.gmail.com>
 <CAHk-=wj9gFa31JiMhwN6aw7gtwpkbAJ76fYvT5wLL_tMfRF77g@mail.gmail.com>
 <CALOAHbAmHTGxTLVuR5N+apSOA29k08hky5KH9zZDY8yg2SAG8Q@mail.gmail.com>
 <CAHk-=wjAmmHUg6vho1KjzQi2=psR30+CogFd4aXrThr2gsiS4g@mail.gmail.com>
 <CALOAHbAAAU9MTQFc56GYoYWR3TsLbkncp5QrrwHMbqJ9SECivw@mail.gmail.com>
 <CAHk-=whwtEFJnDVrkkMtb6SWcmBQMK8+qXGtqvBO+xH8y2i6nA@mail.gmail.com> <CALOAHbD0LdbQTWyvDiLcgGupcQJKmadzWhoZiUTj126Rqqn6fQ@mail.gmail.com>
In-Reply-To: <CALOAHbD0LdbQTWyvDiLcgGupcQJKmadzWhoZiUTj126Rqqn6fQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 24 May 2024 07:58:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com>
Message-ID: <CAHk-=wivfrF0_zvf+oj6==Sh=-npJooP8chLPEfaFV0oNYTTBA@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Yafang Shao <laoar.shao@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>, 
	Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"

On Fri, 24 May 2024 at 00:43, Yafang Shao <laoar.shao@gmail.com> wrote:
>
> Actually, there are already helpers for this: get_task_comm() and
> __get_task_comm(). We can simply replace the memcpy() with one of
> these

No. We should get rid of those horrendous helpers.

> If the task_lock() in __get_task_comm() is a concern, we could
> consider adding a new __get_current_comm().

The task_lock is indeed the problem - it generates locking problems
and basically means that most places cannot use them. Certainly not
things like tracing etc.

The locking is also entirely pointless\, since absolutely nobody
cares. If somebody is changing the name at the same time - which
doesn't happen in practice - getting some halfway result is fine as
long as you get a proper NUL terminated result.

Even for non-current, they are largely useless. They were a mistake.

So those functions should never be used for any normal thing. Instead
of locking, the function should literally just do a "copy a couple of
words and make sure the end result still has a NUL at the end".

That's literally what selinuxfs.c wants, for example - it copies the
thing to a local buffer not because it cares about some locking issue,
but because it wants one stable value. But by using 'memcpy()' and
that fixed size, it means that we can't sanely extend the source size
because now it wouldn't be NUL-terminated. But selinux never wanted a
lock, and never wanted any kind of *consistent* result, it just wanted
a *stable* result.

Since user space can randomly change their names anyway, using locking
was always wrong for readers (for writers it probably does make sense
to have some lock - although practically speaking nobody cares there
either, but at least for a writer some kind of race could have
long-term mixed results)

Oh well.

                Linus


Return-Path: <bpf+bounces-30473-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F148CE1AE
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 09:43:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57FE91F21E3F
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 07:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE40C128833;
	Fri, 24 May 2024 07:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BgmhP/FF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D657F328DB;
	Fri, 24 May 2024 07:43:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716536598; cv=none; b=LnFj04bdzmeGlEyLr6SmtZUtxT15YrbXJguGSUyATUJl2CBiyPDB26iHrX01dIo5cqQQxn92Hu85zFou5WzjaIkCVPh5wthebj6bZYAfvCmo/eEmS5YyiSNW2//w8h237rd5+dfbYa1L+4USHeZwB9QR5AlEbXrsupqrVjOwC0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716536598; c=relaxed/simple;
	bh=EEAPAkvRWTP87ptJdkXmynH7J+7oWnWgXa8qzJjCnUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=i/Wc6f80qsYvhNBpbkbY14AhuXil5ugeJ6m2cDxTVouITBhFrtnpt+4MCDx8f84T1K16z5qAtg/fcYetGIppUtZ2gOIgt6rkkNaFQUtkkH8t8WiSa9fpFwY/IpsRKPQQfkwZ0bPM3QWYBaJO0uKD6KPYrb0ssoimJL3rtzCppHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BgmhP/FF; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-62a082720f0so6218867b3.1;
        Fri, 24 May 2024 00:43:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716536596; x=1717141396; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+5o0jnvfHIMGelQ8b/lLWEj2CJxrw/Z+KD+l+PaAQk=;
        b=BgmhP/FFu5vBHzEvhKmIZTVicCcbO0W0HGcuxoEkrYO9d+30s1cEVHBseD6seKN3Cc
         g6gp1PShJXVxyA9HnEktWk8xvzpUIYAy/dIOXfTiQUuyrmV3WJXYjVT5pRZ1lvDMjrW3
         aV80M/5ydSyPBJgvhwj6rZ8nJT7rY//lrr4lTTbIY+mCzQVTDiL/IEyHvzGVMHiXzdoT
         5hghpe8eMLCMFH//xfVZXR5WH+PfM/uMHzzNm6tpcKUf1UgN5vGp08bSQ+5q9nFgY03Z
         BRETdqqS+sf9hnDg0/xrGephcLjC3lhnDwaS6ZCO3myKNO/epwcdRmgFO90qz5ewSf1V
         KEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716536596; x=1717141396;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8+5o0jnvfHIMGelQ8b/lLWEj2CJxrw/Z+KD+l+PaAQk=;
        b=o+kqHi57tR9RFV75p7Ojy2AL7LIRho3SAi3Y4USwRATTuKLg8fTBv/il4vjH/Fz++a
         jE1pdlK8zJn0L/O06l+r+uZimDHOSJMJmiR5e4IAu1k4Io++hT3DX/SPmO8lDymkGUwx
         WOQrOglKWn+WaGIpsjJVjltRDjOnn7eyG3DHi+rO2JfHQzkIKHR/mMoaHYJr8Csd7vcD
         W5PFgcKyEnpAL7XljFiMUYU82cGkiHxYVFf0DgfsSgAU6W+z3wdrfs2EnzIhwuapQgkG
         HdQCbtWWB6ovQodtcQHOAj4uQKnH3DsuDOPSylrUdc5ItpAZvnSIn4KH2x/fS5og6Oke
         vN2A==
X-Forwarded-Encrypted: i=1; AJvYcCXJqqfjSDO9OVvZfi9f09AJN28/06Lpufndv+rQDMhfPgaJ0ouYHWInlwSHNH9Ey8LTlQdCuAB43/dTfXcveZflyPoafAsGmZQvMS+A
X-Gm-Message-State: AOJu0YyvnBR1trdpRBBiU37w6OP1gQoEyx7CnWsXzlTaDJY0jeAXESHn
	eEp6yS7s0hp5zCPvO/dtDyUVqKO0doUOAowN4IQelyogDquiLRASPCn+5P3cllCRfkDQ2w/Q2Af
	6hmYKbJ439dCVNsKRL439znwf7SM=
X-Google-Smtp-Source: AGHT+IFUF3ICaiQTE3zr4leR5Pkgem+HIQRPp295oMXpzO1jFJa/rHWdUCrzDilFW5dbZDoWbiLbuNViNj8R7nTRSAA=
X-Received: by 2002:a0d:e8c4:0:b0:619:da17:87be with SMTP id
 00721157ae682-62a08ee8ad9mr13994687b3.42.1716536595834; Fri, 24 May 2024
 00:43:15 -0700 (PDT)
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
 <CALOAHbAAAU9MTQFc56GYoYWR3TsLbkncp5QrrwHMbqJ9SECivw@mail.gmail.com> <CAHk-=whwtEFJnDVrkkMtb6SWcmBQMK8+qXGtqvBO+xH8y2i6nA@mail.gmail.com>
In-Reply-To: <CAHk-=whwtEFJnDVrkkMtb6SWcmBQMK8+qXGtqvBO+xH8y2i6nA@mail.gmail.com>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Fri, 24 May 2024 15:42:39 +0800
Message-ID: <CALOAHbD0LdbQTWyvDiLcgGupcQJKmadzWhoZiUTj126Rqqn6fQ@mail.gmail.com>
Subject: Re: [PATCH workqueue/for-6.10-fixes] workqueue: Refactor worker ID
 formatting and make wq_worker_comm() use full ID string
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: bpf <bpf@vger.kernel.org>, Tejun Heo <tj@kernel.org>, Jan Engelhardt <jengelh@inai.de>, 
	Craig Small <csmall@enc.com.au>, linux-kernel@vger.kernel.org, 
	Lai Jiangshan <jiangshanlai@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 11:55=E2=80=AFPM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Thu, 23 May 2024 at 06:04, Yafang Shao <laoar.shao@gmail.com> wrote:
> >
> > If it's not urgent and no one else will handle it, I'll take care of
> > it. However, I might not be able to complete it quickly.
>
> It's not urgent. In fact, I'm not convinced we need to even increase
> the current comm[] size, since for normal user programs the main way
> 'ps' and friends get it is by just reading the full command line etc.
>
> But I think it would be good to at least do the cleanup and walk away
> from the bare hardcoded memcpy() so that we can move in that
> direction.

Certainly, let's start with the cleanup.

Actually, there are already helpers for this: get_task_comm() and
__get_task_comm(). We can simply replace the memcpy() with one of
these. If the task_lock() in __get_task_comm() is a concern, we could
consider adding a new __get_current_comm().

It's important to note that people may continue to directly access
task->comm in new code, even if we've added a comment to avoid that:

    struct task_struct {
        ...
        /*
         * executable name, excluding path.
         *
         * - normally initialized setup_new_exec()
         * - access it with [gs]et_task_comm()
         * - lock it with task_lock()
         */
        char                            comm[TASK_COMM_LEN];
        ...
    }

We might add a rule in checkpatch.pl to warn against this, but that=E2=80=
=99s
not an ideal solution.

--=20
Regards
Yafang


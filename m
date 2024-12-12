Return-Path: <bpf+bounces-46745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E1089EFEDE
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 22:57:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C02216B7E9
	for <lists+bpf@lfdr.de>; Thu, 12 Dec 2024 21:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C4AE1D8E06;
	Thu, 12 Dec 2024 21:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnBbJdFC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C26D1547F5
	for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 21:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734040672; cv=none; b=gNYqC7Js7u39TNHWqvGHDduecxL+lKOfWpXvxA4uGPDozzx4y98hBa7N6c0hAd4K2+UT/5trYpIaoOiDEGfBFFbltM2ncRx0lHsrLj/X0K5pHgbHdtN16he35W1Rw5U3Gs5qAcNfp30FIAIMYHmhKv/4WnuGwP8QEAIqz5RZGFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734040672; c=relaxed/simple;
	bh=ds1DKNZ09aflVNmSHp4GkuOh9tG+AcOM8gfQX3oAbvU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kTHK73dxLbwqEEgojHZaTTGA4HlrU9NdfPpJN0VTdq+gzq2XCW6spypDPvpDgASP+Ebf3Bk6VPoEC+5Rn8TM2EvjIlgMpnjdW3pN4AxmcZrA2w39hu5BnCD2IbhtqVTT6mMIHRi5HPfhG6SIPuxD6ZCn5QKFM9TdOBUmC2ebC0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnBbJdFC; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-385e27c75f4so839335f8f.2
        for <bpf@vger.kernel.org>; Thu, 12 Dec 2024 13:57:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734040668; x=1734645468; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5mGyYgy+DRNnCRKz6HMactLCf5DP3kRlh3ALtNNtG8g=;
        b=lnBbJdFC9tdRF8nLmKqADN6DqZU1PlnrkgxntWn7yhvOVAgKZPFx5a3DtaOzF1mJ8l
         cYTQ7DYG8BToWH+VvZL6vrlLYzBeV+KJvthjG7HKXKwxyCG7LlmbmxZ2C1jSslNozn0x
         mZe1SQqHjKFaNYWqHVyf2z0s9xHTXDSMkCPuTwBshbR7UfJEvOPgJ1V21/wTSsVa57kp
         jsgMSI3mLkIL2BEu1gik6xSZSTbifaa+phCA+IT6nN13l4ZbcTbRqNjpl9/MF+JwukZ0
         ZBCp7x3dLCd1kEsp5Llh/NfKjmPB5nHMfWPWphF7wruVMmFZQcu81Kvn69mD3b91+18I
         tkBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734040668; x=1734645468;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5mGyYgy+DRNnCRKz6HMactLCf5DP3kRlh3ALtNNtG8g=;
        b=YnPISfCRADAXsSa0OkH/Aw/XkQfnXewf3uaTcRABzHU+c/iWNHhpPm3BD9RiRy/A9e
         FiGezxDCMK67ckqHljS76iKN014jB48j15IrZWk3dJdcQ+gtCYRgR2WOq0JRs6mthyU8
         4snjgTD4W8ePB1ZvcRNi72i+2BplNZPUxbFjVqrbq0A3jC+X5vB3gDyohIs5hft4q1tO
         Szs2yhH7UB+eCup+QVaQZcEoFFQu0Fmy4GgueVR+/S05yd8fT61Z0pOOfKY4AuFGzPFJ
         7b0IBExBGaiOixyqK0U14SkHxkuCWo36zC87ZmeLP7s0B14cNe1g1qRrKUBeYdSGOoYB
         BUQQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7E7pGIcYqvagSjeh06q99LfarNkVwKpGl1ua11NUlgQ4m3BLw7l6zxgiyUlKdu/5lOGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMNWSbXzHs03q2HJZor9X2n23twpCZIRVBDkHyOUSOLAjb07QI
	467PVgNPU+rgD/T/2yBUeUBSsPlPh1m24YZeU+Qx514c5gFPu4Ufzi7iN2YmKLJvSmILyf5ohhh
	GQ4aU6k18/TuzzWBnJg2rcOCvuMQ=
X-Gm-Gg: ASbGnctWF8kx9KwUh9YMY2HgRzO1B6dzJQcCAQwsO0Gjpet6JzJfQhsvksYLkVg20dQ
	Upr6j6pb5q1ZNQtn67JuNOF8q3USTxxWXg4aUTHsviRja9e88KGG3FA3xb+NBBqz44SJftQ==
X-Google-Smtp-Source: AGHT+IFo8gVUN/en+pzKBM/w59K6WRrZbZIlXUf6Adhkdp498nx88e88022kLpeEIqvAnEbkp5Di8ezvKDndufTRaA8=
X-Received: by 2002:a05:6000:1fae:b0:385:e013:73f0 with SMTP id
 ffacd0b85a97d-3888e0c23f8mr132680f8f.59.1734040668299; Thu, 12 Dec 2024
 13:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241210023936.46871-1-alexei.starovoitov@gmail.com>
 <20241210023936.46871-2-alexei.starovoitov@gmail.com> <Z1fSMhHdSTpurYCW@casper.infradead.org>
 <Z1gEUmHkF1ikgbor@tiehlicka> <CAADnVQKj40zerCcfcLwXOTcL+13rYzrraxWABRSRQcPswz6Brw@mail.gmail.com>
 <20241212150744.dVyycFUJ@linutronix.de> <Z1r_eKGkJYMz-uwH@tiehlicka> <20241212153506.dT1MvukO@linutronix.de>
In-Reply-To: <20241212153506.dT1MvukO@linutronix.de>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 12 Dec 2024 13:57:37 -0800
Message-ID: <CAADnVQKr+pAUBuDV3zW41eGa+i4AmMZS+=A94EWsLqpgcdZgBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 1/6] mm, bpf: Introduce __GFP_TRYLOCK for
 opportunistic page allocation
To: Sebastian Sewior <bigeasy@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>, Matthew Wilcox <willy@infradead.org>, bpf <bpf@vger.kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
	Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Steven Rostedt <rostedt@goodmis.org>, Hou Tao <houtao1@huawei.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, shakeel.butt@linux.dev, 
	Thomas Gleixner <tglx@linutronix.de>, Tejun Heo <tj@kernel.org>, linux-mm <linux-mm@kvack.org>, 
	Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Dec 12, 2024 at 7:35=E2=80=AFAM Sebastian Sewior <bigeasy@linutroni=
x.de> wrote:
>
> On 2024-12-12 16:21:28 [+0100], Michal Hocko wrote:
> > On Thu 12-12-24 16:07:44, Sebastian Sewior wrote:
> > > But since I see in_nmi(). You can't trylock from NMI on RT. The trylo=
ck
> > > part is easy but unlock might need to acquire rt_mutex_base::wait_loc=
k
> > > and worst case is to wake a waiter via wake_up_process().
> >
> > Ohh, I didn't realize that. So try_lock would only be safe on
> > raw_spin_lock right?
>
> If NMI is one of the possible calling contexts, yes.

Looks like in_nmi both trylock and unlock are not safe.

pcp_spin_trylock() calls __rt_spin_trylock() on RT,
which can deadlock inside rt_mutex_slowtrylock().
This part has a potential workaround like:

@@ -102,8 +102,11 @@ static __always_inline int
__rt_spin_trylock(spinlock_t *lock)
 {
        int ret =3D 1;

-       if (unlikely(!rt_mutex_cmpxchg_acquire(&lock->lock, NULL, current))=
)
+       if (unlikely(!rt_mutex_cmpxchg_acquire(&lock->lock, NULL, current))=
) {
+               if (in_nmi())
+                       return 0;
                ret =3D rt_mutex_slowtrylock(&lock->lock);
+       }

but when there are waiters and cmpxchg in this part fails:
        if (unlikely(!rt_mutex_cmpxchg_release(&lock->lock, current, NULL))=
)
                rt_mutex_slowunlock(&lock->lock);

will trigger slowunlock that is impossible to do from nmi.
We can punt it to irqwork with IRQ_WORK_HARD_IRQ to make sure
it runs as soon as nmi finishes.
Since it's hard irq debug_rt_mutex_unlock(lock); shouldn't complain.
The current will stay the same ?
Other ideas?


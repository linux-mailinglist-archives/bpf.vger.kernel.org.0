Return-Path: <bpf+bounces-32061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0BD9069E2
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 12:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C42721F26E20
	for <lists+bpf@lfdr.de>; Thu, 13 Jun 2024 10:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5AD01428E8;
	Thu, 13 Jun 2024 10:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVc6NlfY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7B514264C;
	Thu, 13 Jun 2024 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718274232; cv=none; b=iR8ZDC2phbUeE+MKjdD7tfkNkguRj55ZjrqqR/taSBO8aZCuXS0fjVzgRSM/07nxHIu9/JxTwp/2j0gEMfDJXygA1o42o1pjFgUi0y1GK1aRWePaQrGCe2ihLCLy3rMxCpD8pIo5MZjNc7DlzHw7T7T3DJE1xOWPAGBK7bkIUlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718274232; c=relaxed/simple;
	bh=lo+bPwhtGA+tRPpZUVzE6TD7PL6muxe9lHxnCSl55n4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=l5Wjr5NexTjv2TmfnobpgbNaZMAR+nShvxGh1Vwrj0Ls5dxHgXjPngymcaWMPhUkn/C5od9Tf4kx5TF0k8aI9JD5MQX0sE0adaW3krfCBGF+2jCaoYHBSPFHUYc8qG7SfBLnxWMmpaUnWzjEF9D5ya6mqBGHcq/FnH+/591132Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVc6NlfY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-57a30dbdb7fso982880a12.3;
        Thu, 13 Jun 2024 03:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718274229; x=1718879029; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EHVM5SxeBIjaEUbHe4OexzDWg/RJX3ZdKco+qdr+tro=;
        b=YVc6NlfYZg49ZKYmx2YfdRED7guoIQroUGtqfGrTzTc7+WD6vdMFzUGR+EWIfbKqjf
         xqD249OsjJIunT4pFvTGHMH5mp1fqB8Jr6XH+XRfCFz7611VNdE2zHKhRfwxv9eX5FnL
         iehUayxnmSNpjPQNXHtmPefkWvXOdA3z+6kRgkB5WQ4AC5oM4gl1cesEG5fwdU2PY2Yk
         GAs/eAfg/mjISfRoeN/v18PG8yhBirCmg4LoFwmJUjr0LxgjHQOXJX2Q1zRzQtwbaWup
         jgZhBVxCC+VLbkNW7ZirSIyaVp/cQro+vUxq7J05yBpFhIrJE0IocCKWnbfsTQI1W/c2
         hj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718274229; x=1718879029;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHVM5SxeBIjaEUbHe4OexzDWg/RJX3ZdKco+qdr+tro=;
        b=LssIefBcYDEjzUDSy6kg5AjjxNDY4GSzWjOuV4dQ465LcT4J+53BsKOODh+2OmfDIL
         Tn9AnELJmPI4lPH6/wKbOu+s/hyY2AbM39BAROyFROEUHnJsxYzAVdd+FNT5++9j3Y8S
         onOem8E2NjxWPSsuP41CPsd4Mk76xM+qgLLlh9cdb4Z1Y5Y3ic0Po9GD+IOHKmzkfqlt
         QzOm5GsrRVd58SeZ1czK/VoGywnOIYNQNu2jQKlPg9i0nCPOgV9Vx+SUlMeBMEazT4Os
         M7nJt/nsNfy93HrvDICQTQHpmBf/BERf5F2ZGoVFr1aEyit8JCRL2zRkk7LAgSSZCRUz
         EDHg==
X-Forwarded-Encrypted: i=1; AJvYcCVplVOHI/N56Gni/lccdZaHjllyJZWTdx3RVKOMR8HzLvSjM4zyT9Xd66UPhZkLAcDajGu4sFeUHWG7KbIeWvXDVFFn8ng3ZSetLXWEbHE=
X-Gm-Message-State: AOJu0Yy7YxTY9HxWbxeQ6QeLHesZQgO2XQDjdb9h8cQV3ELw3iL7rUyP
	pSw6JV3ExP7wzXoFGpu43NW0x5C92pnrebHwAA+mhuLbZG2TYdAj36abtQ==
X-Google-Smtp-Source: AGHT+IEq5UGo+cTTQSgUkvzJEAS8d2l5lxA21jQxjT1KsxQOcYGPyub19ElRN3gnXNYPfyt4zlvRlg==
X-Received: by 2002:a50:d710:0:b0:579:edac:df13 with SMTP id 4fb4d7f45d1cf-57ca973f506mr3043623a12.8.1718274228788;
        Thu, 13 Jun 2024 03:23:48 -0700 (PDT)
Received: from ddolgov-thinkpadt14sgen1.rmtde.csb (dslb-178-012-035-234.178.012.pools.vodafone-ip.de. [178.12.35.234])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57cb743b032sm723352a12.92.2024.06.13.03.23.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jun 2024 03:23:48 -0700 (PDT)
Date: Thu, 13 Jun 2024 12:23:46 +0200
From: Dmitry Dolgov <9erthalion6@gmail.com>
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: bpf@vger.kernel.org, linux-rt-users@vger.kernel.org, ast@kernel.org, 
	daniel@iogearbox.net, andrii@kernel.org
Subject: Re: bpf_ringbuf_reserve deadlock on rt kernels
Message-ID: <mt2yblzo4ezlx4vjfmw3pul3cqgd27oddbaq2coqjkcp342cni@ob4gkaxfz7mg>
References: <jxkyec5jd54r3cmel4e3pep4ebo3pd4xgedwtb7gj65fntf4s7@om5r3mowjknb>
 <20240612143223.BO0LMFEZ@linutronix.de>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240612143223.BO0LMFEZ@linutronix.de>

> On Wed, Jun 12, 2024 at 04:32:23PM GMT, Sebastian Andrzej Siewior wrote:
>
> > The BPF program in question is attached to sched_switch. The issue seems
> > to be similar to a couple of syzkaller reports [1], [2], although the
> > latter one is about nested progs, which seems to be not the case here.
> > Talking about nested progs, applying a similar approach as in [3]
> > reworked for bpf_ringbuf, elliminates the issue.
> >
> > Do I miss anything, is it a known issue? Any ideas how to address that?
>
> I haven't attached bpf program to trace-events so this new to me. But if
> you BPF attach programs to trace-events then there might be more things
> that can go wrong…

Things related to RT kernels, or something else?

> Let me add this to the bpf-list-to-look-at.
> Do you get more splats with CONFIG_DEBUG_ATOMIC_SLEEP=y?

Thanks. Adding CONFIG_DEBUG_ATOMIC_SLEEP gives me this:

    BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
    in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 154, name: script
    preempt_count: 3, expected: 0
    RCU nest depth: 1, expected: 1
    4 locks held by script/154:
     #0: ffff8881049798a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x28/0x60
     #1: ffff88813bdb2558 (&rq->__lock){-...}-{2:2}, at: __schedule+0xc4/0xca0
     #2: ffffffff83590540 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x6c/0x1e0
     #3: ffffc90007b61158 (&rb->spinlock){....}-{2:2}, at: __bpf_ringbuf_reserve+0x5a/0xf0
    irq event stamp: 129370
    hardirqs last  enabled at (129369): [<ffffffff82216818>] _raw_spin_unlock_irq+0x28/0x50
    hardirqs last disabled at (129370): [<ffffffff822084a9>] __schedule+0x5d9/0xca0
    softirqs last  enabled at (0): [<ffffffff81110ecb>] copy_process+0xc3b/0x2fd0
    softirqs last disabled at (0): [<0000000000000000>] 0x0


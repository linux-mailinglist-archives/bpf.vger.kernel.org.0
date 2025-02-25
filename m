Return-Path: <bpf+bounces-52499-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91F62A43E2A
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 12:48:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA044188514D
	for <lists+bpf@lfdr.de>; Tue, 25 Feb 2025 11:48:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 998472690F9;
	Tue, 25 Feb 2025 11:47:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82015268C64;
	Tue, 25 Feb 2025 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740484020; cv=none; b=PJAHCKT9aUmxHh4LbIXTNbzo2F0hVP4R7ldZgYm8qRUoZ9bqws53JHi5DPIWNZotT/mxrhIXRFuWI0uyGaey430qQw4uKpYQXIMcavDDggoIH9cGzepcV+l3tbRRJpjVChnRZUkFaxPxBuEl22+BVqDgE2Nh5hCZnvdZl/11yJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740484020; c=relaxed/simple;
	bh=0AVg+PqMZwCn6ffLSDS5fWOyG7qaHKlj438PbjbBKUY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K8oU7WQTpPS5o8tJ1/AVLdgj8vnv9q1eBxFJwysUZKAslWnrofXgbkHpDbz5N29BmseHSRm2QtP/AjeRF2xubudVNx4/fp1MXsNpUG2fYvEgl97aVCXI0n1TRUnjSFEFQQJ/dtOCiS/1lwBbzBwdp7SVXi4ZHgx312G7CyyerYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5ded368fcd9so7906641a12.1;
        Tue, 25 Feb 2025 03:46:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740484017; x=1741088817;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WnmpmMtgyV/RpBxxJNHh9adjrFRxaDmV/HVToi6KENU=;
        b=Kp2TseC4bx0lAIlzhqMVxjEgtg5EkQwiHbndVuG+RFxbzrspvodpERuU36rlKXazdh
         4bPtm1zBC+p2ekFAgf8jvIpG9VGJ4ivL9awf3gpA8Rr3hCkA3GjDMZudSiBR46Rhoh09
         jIOYzwJkoIFIJNcvrdsCUlyD/9H/AX9XyUjJpLxWtYhO635n2G3MINYPA11FH6mOFk2P
         4hYSWfcEt9N5axzLliaHCG8Xs+YeZuvd0284Z1G4WV0ez33r1c0qaaUtS5BKyI1xwM1L
         lSDKXw/LfJFdXZDtHOrWgdJuSYClZvSJAVpY+Rvr9wgChGW/qCqgAkp2hHoNxeA+7QCW
         8esg==
X-Forwarded-Encrypted: i=1; AJvYcCUCaTs8mHHebYMuVV8qdwr9xtZBUDIBuTB8tRxi9BYfNJEafxViaPer3t3Edfz1H2GXtSI/wbovtzR3Zo5e@vger.kernel.org, AJvYcCUPyTiJa2xLF5hn3ce5gTUgFqsXw8BzhamcJruVogy6kMK3b6mxBPNBUlF3v7cgzVfZ1uNWJW2RkVIINIsRDdA89BIF@vger.kernel.org, AJvYcCVcIJdp+ERMGsntCURR9Y5xZ4Qj2Ir7HEvUsBge8PI/IZ9DXniMqS3+7G0mpEhbu7bIiFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwjAX+tn9t1vxRriVP38Emr1oBZPenbWG/rwxLulXfWq529M1e
	fLcd1kpx+lnvX57ZmBSl90SaWVJkjPBYZ6rEGg5araNRWuKpXMDzbLPv0A==
X-Gm-Gg: ASbGncsV/ACbAV3IMM8WlU2u9VM0LH/rA+figvYEOc1mdL5n7zaBX+NtvQvwttB31iu
	RDr2yyN4hl/QnvkMT5yO76D+W2cDipaQUjoan89qX7ZmWm1qROCR+Y5EZ4+l65ue9FUR9agRJbI
	+4g2QUhjqMR0KOO8oOGNcZhYh84YQORe51sO5pwf67mwRZU2qatNyewD9iqPP7ieUeoT3oZF/I/
	CRFnMoL1oXhBGr7vDBdv9iL5GzSDL+jjIRFu2hP4yK3mMzn4Rv/M+Qcxy/Y+ZAHUCcL/gH/+R1K
	CEcgsSCsd6DaF2bp
X-Google-Smtp-Source: AGHT+IH/rGv667ezHBwpRbWaGnx2NOPOuCNeGDXskfDoS9UGlpsfrLje1MDh0pGnfrPTeCMlekZVhw==
X-Received: by 2002:a05:6402:13d2:b0:5de:c9d0:673b with SMTP id 4fb4d7f45d1cf-5e0b70b6f86mr16417676a12.1.1740484016465;
        Tue, 25 Feb 2025 03:46:56 -0800 (PST)
Received: from gmail.com ([2a03:2880:30ff:7::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5e45ab9866csm1086076a12.32.2025.02.25.03.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 03:46:55 -0800 (PST)
Date: Tue, 25 Feb 2025 03:46:53 -0800
From: Breno Leitao <leitao@debian.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org,
	peterz@infradead.org, oleg@redhat.com, rostedt@goodmis.org,
	mhiramat@kernel.org, mingo@kernel.org, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org
Subject: Re: [PATCH v3 tip/perf/core 2/2] uprobes: SRCU-protect uretprobe
 lifetime (with timeout)
Message-ID: <20250225-transparent-bronze-cobra-bafff4@leitao>
References: <20241024044159.3156646-1-andrii@kernel.org>
 <20241024044159.3156646-3-andrii@kernel.org>
 <20250224-impressive-onyx-boa-36e85d@leitao>
 <CAEf4BzbupJe10k0MROG5iZq6cYu6PRoN3sHhNK=L7eDLOULvNQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzbupJe10k0MROG5iZq6cYu6PRoN3sHhNK=L7eDLOULvNQ@mail.gmail.com>

Hello Andrii,

On Mon, Feb 24, 2025 at 02:23:51PM -0800, Andrii Nakryiko wrote:
> On Mon, Feb 24, 2025 at 4:23 AM Breno Leitao <leitao@debian.org> wrote:
> >
> > Hello Andrii,
> >
> > On Wed, Oct 23, 2024 at 09:41:59PM -0700, Andrii Nakryiko wrote:
> > >
> > > +static struct uprobe* hprobe_expire(struct hprobe *hprobe, bool get)
> > > +{
> > > +     enum hprobe_state hstate;
> > > +
> > > +     /*
> > > +      * return_instance's hprobe is protected by RCU.
> > > +      * Underlying uprobe is itself protected from reuse by SRCU.
> > > +      */
> > > +     lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu));
> >
> > I am hitting this warning in d082ecbc71e9e ("Linux 6.14-rc4") on
> > aarch64. I suppose this might happen on x86 as well, but I haven't
> > tested.
> >
> >         WARNING: CPU: 28 PID: 158906 at kernel/events/uprobes.c:768 hprobe_expire (kernel/events/uprobes.c:825)
> >
> >         Call trace:
> >         hprobe_expire (kernel/events/uprobes.c:825) (P)
> >         uprobe_copy_process (kernel/events/uprobes.c:691 kernel/events/uprobes.c:2103 kernel/events/uprobes.c:2142)
> >         copy_process (kernel/fork.c:2636)
> >         kernel_clone (kernel/fork.c:2815)
> >         __arm64_sys_clone (kernel/fork.c:? kernel/fork.c:2926 kernel/fork.c:2926)
> >         invoke_syscall (arch/arm64/kernel/syscall.c:35 arch/arm64/kernel/syscall.c:49)
> >         do_el0_svc (arch/arm64/kernel/syscall.c:139 arch/arm64/kernel/syscall.c:151)
> >         el0_svc (arch/arm64/kernel/entry-common.c:165 arch/arm64/kernel/entry-common.c:178 arch/arm64/kernel/entry-common.c:745)
> >         el0t_64_sync_handler (arch/arm64/kernel/entry-common.c:797)
> >         el0t_64_sync (arch/arm64/kernel/entry.S:600)
> >
> > I broke down that warning, and the problem is on related to
> > rcu_read_lock_held(), since RCU read lock does not seem to be held in
> > this path.
> >
> > Reading this code, RCU read lock seems to protect old hprobe, which
> > doesn't seem so.
> >
> > I am wondering if we need to protect it properly, something as:
> >
> >         @@ -2089,7 +2092,9 @@ static int dup_utask(struct task_struct *t, struct uprobe_task *o_utask)
> >                                 return -ENOMEM;
> >
> >                         /* if uprobe is non-NULL, we'll have an extra refcount for uprobe */
> >         +               rcu_read_lock();
> >                         uprobe = hprobe_expire(&o->hprobe, true);
> >         +               rcu_write_lock();
> >
> 
> I think this is not good enough. rcu_read_lock/unlock should be around
> the entire for loop, because, technically, that return_instance can be
> freed before we even get to hprobe_expire.

re you suggesting that we should use an RCU read lock to protect the
"traversal" of return_instances? In other words, is it currently being
traversed unsafely, given that return_instance can be freed at any time?

> So, just like we have guard(srcu)(&uretprobes_srcu); we should have
> guard(rcu)();
> 
> Except, there is that kmemdup() hidden inside dup_return_instance(),
> so we can't really do that.

Right. kmemdup() is using GFP_KERNEL, which might sleep, so, it cannot
be called using rcu read lock.

Thanks
--breno


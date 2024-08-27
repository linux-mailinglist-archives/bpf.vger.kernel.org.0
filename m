Return-Path: <bpf+bounces-38134-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F90960747
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 12:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496471C22B36
	for <lists+bpf@lfdr.de>; Tue, 27 Aug 2024 10:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3F5919AD48;
	Tue, 27 Aug 2024 10:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lpXdO9So"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD17A192599;
	Tue, 27 Aug 2024 10:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724754013; cv=none; b=pVDS2osZZDMZdQ5ioAoZc4sCb8Z79jW1NUokNBKOnn/owKBWu6k2xly2clD/Jd56SmkUjbzGln4fqYfGRD8I1SyVaBgyKK95D9njP6QetKremYpjtHwkNJdtxx8I2+gJdDBsShOWJmr6d/YjZMjexlRU4BXA658ksBXAIzungeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724754013; c=relaxed/simple;
	bh=AmugtmQNEQwnGQLwANmEH1cOaKQwN5YS6BV7rUsaYWg=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Mbk4TvQjVEZaXDyDUHGcgUCIx8q/NZkQ3e74atKGfdgSzFoyjHfmdFz6n2D4Y8ox8igO2oxb8u5ixY6uiFT3/VRuCBQDxCqErLIhA+UsJh/SL8z7vnHUnetaVIBSxmRorBfHTje8gtkMlJIZbQcAr0cdbysj48X2EaBXXZ4JuWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lpXdO9So; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3717ff2358eso2902534f8f.1;
        Tue, 27 Aug 2024 03:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724754010; x=1725358810; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OK7QDaiBdtadt/DGchsA4SWvcM4JEY9t7gr4Zp7ER8E=;
        b=lpXdO9Soc8VBYRZiIP7S0rX+Rin8X0Yc+IBe+PIGtGvSfY0STgu5DKyHszMpH6tmmI
         02MaHfUnVCuZ1KRcthdanBlMOjgh2YC4aSZd3ePIs2oEXKLs+0jSyxMp11w+Ds8zgIkd
         kjvWt41Hjm3jQjnG3EwIyXJSj595Pk1+rRIPMtTBnTp1YaYxofdxXChJsQ/q0D5f2yq6
         T8c0qeAJbzLB8zNS/tqBMEzYtQmC4kSp5+uSHSOD0jwHwO1wzGhjfT2GPmdDESfnN0BE
         4/0+T8lcFypmM9L0G5QwCAJSFRJle82IOdqOa/80Hqlgu7VzNJ1zzytTTIGZnwKARjPA
         LHEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724754010; x=1725358810;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OK7QDaiBdtadt/DGchsA4SWvcM4JEY9t7gr4Zp7ER8E=;
        b=WAbA99AC7TridD/s1Dvzf/CBBcHzPwPAhva1ImnLK0n6OP4XnJFOPwzeLJ4EIaDSO2
         UZIdK7Lw0oo5/mFkvsrbtnnzml6Jgr8JauZeYIwazIMi2D0VjI1e8ohua5Ilb60V5/RV
         QI1uX5BNuwaUcT0Lp7vxFZu6idR0LgbR9tw6XTQiCn1h30tF+jtqt6pIp1LW8AMTuSxB
         RV8+kcDmF8swDhL2bfkinCFBGKZ1UelkSI6xI4WPEUXeop0pt7lWXEvVEXQ2niJQR9sA
         KxstVbJswiPYXh9k0qTS77GQmNrFF1OpuJf361Mr5374unmJpfbkn3b9V6rhZJwVX5fT
         GZWg==
X-Forwarded-Encrypted: i=1; AJvYcCWOXh1VvDTye1n/lOrlUtQ62Chx/eYvVUS1Cze7dUarcvzIxPHJQPlF+O1WrmefBaAW0YyX06vS5kSPHL2UHFb8VQrr@vger.kernel.org, AJvYcCXdtZb8Gor3x+NRDpEsKWCWclv0UX8YQayUixqObgJdkrkxcjPbK7LFqS2fOFEnVsseqKY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRlVfvAVEjWIP5s42ij82G2sXeO0kqFm1Q+QJ7aAf2Ibz4Qaia
	qZLCRsNj0d6sGIySIJNmvww171nOQysO2SrneSbSFIic8AUZsDFx
X-Google-Smtp-Source: AGHT+IF8UHWFpWd5wXX6mUes+jRfPndU+BzJLZGO+wKK9/PJwKhEZXsF1ShYpVQWVuFc4ojytJgCNg==
X-Received: by 2002:a5d:63cc:0:b0:371:7c71:9ab2 with SMTP id ffacd0b85a97d-373118e2f0fmr7834820f8f.52.1724754009654;
        Tue, 27 Aug 2024 03:20:09 -0700 (PDT)
Received: from krava ([173.38.220.47])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-373081457d1sm12731237f8f.43.2024.08.27.03.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 03:20:09 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 27 Aug 2024 12:20:07 +0200
To: Oleg Nesterov <oleg@redhat.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Tianyi Liu <i.pear@outlook.com>,
	andrii.nakryiko@gmail.com, mhiramat@kernel.org, ajor@meta.com,
	albancrequy@linux.microsoft.com, bpf@vger.kernel.org,
	flaniel@linux.microsoft.com, linux-trace-kernel@vger.kernel.org,
	linux@jordanrome.com, mathieu.desnoyers@efficios.com
Subject: Re: [PATCH v2] tracing/uprobe: Add missing PID filter for uretprobe
Message-ID: <Zs2oV5R2blKw5c9w@krava>
References: <CAEf4Bzb29=LUO3fra40XVYN1Lm=PebBFubj-Vb038ojD6To2AA@mail.gmail.com>
 <ME0P300MB04163A2993D1B545C3533DDC9D892@ME0P300MB0416.AUSP300.PROD.OUTLOOK.COM>
 <20240825171417.GB3906@redhat.com>
 <20240825224018.GD3906@redhat.com>
 <ZsxTckUnlU_HWDMJ@krava>
 <20240826115752.GA21268@redhat.com>
 <Zs2lpd0Ni0aJoHwI@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zs2lpd0Ni0aJoHwI@krava>

On Tue, Aug 27, 2024 at 12:08:39PM +0200, Jiri Olsa wrote:
> On Mon, Aug 26, 2024 at 01:57:52PM +0200, Oleg Nesterov wrote:
> > On 08/26, Jiri Olsa wrote:
> > >
> > > On Mon, Aug 26, 2024 at 12:40:18AM +0200, Oleg Nesterov wrote:
> > > > 	$ ./test &
> > > > 	$ bpftrace -p $! -e 'uprobe:./test:func { printf("%d\n", pid); }'
> > > >
> > > > I hope that the syntax of the 2nd command is correct...
> > > >
> > > > I _think_ that it will print 2 pids too.
> > >
> > > yes.. but with CLONE_VM both processes share 'mm'
> > 
> > Yes sure,
> > 
> > > so they are threads,
> > 
> > Well this depends on definition ;) but the CLONE_VM child is not a sub-thread,
> > it has another TGID. See below.
> > 
> > > and at least uprobe_multi filters by process [1] now.. ;-)
> > 
> > OK, if you say that this behaviour is fine I won't argue, I simply do not know.
> > But see below.
> > 
> > > > But "perf-record -p" works as expected.
> > >
> > > I wonder it's because there's the perf layer that schedules each
> > > uprobe event only when its process (PID1/2) is scheduled in and will
> > > receive events only from that cpu while the process is running on it
> > 
> > Not sure I understand... The task which hits the breakpoint is always
> > current, it is always scheduled in.
> > 
> > The main purpose of uprobe_perf_func()->uprobe_perf_filter() is NOT that
> > we want to avoid __uprobe_perf_func() although this makes sense.
> > 
> > The main purpose is that we want to remove the breakpoints in current->mm
> > when uprobe_perf_filter() returns false, that is why UPROBE_HANDLER_REMOVE.
> > IOW, the main purpose is not penalise user-space unnecessarily.
> > 
> > IIUC (but I am not sure), perf-record -p will work "correctly" even if we
> > remove uprobe_perf_filter() altogether. IIRC the perf layer does its own
> > filtering but I forgot everything.
> > 
> > And this makes me think that perhaps BPF can't rely on uprobe_perf_filter()
> > either, even we forget about ret-probes.
> > 
> > > [1] 46ba0e49b642 bpf: fix multi-uprobe PID filtering logic
> > 
> > Looks obviously wrong... get_pid_task(PIDTYPE_TGID) can return a zombie
> > leader with ->mm == NULL while other threads and thus the whole process
> > is still alive.
> > 
> > And again, the changelog says "the intent for PID filtering it to filter by
> > *process*", but clone(CLONE_VM) creates another process, not a thread.
> > 
> > So perhaps we need
> > 
> > 	-	if (link->task && current->mm != link->task->mm)
> > 	+	if (link->task && !same_thread_group(current, link->task))
> > 
> > in uprobe_prog_run() to make "filter by *process*" true, but this won't
> > fix the problem with link->task->mm == NULL in uprobe_multi_link_filter().
> 
> would the same_thread_group(current, link->task) work in such case?
> (zombie leader with other alive threads)

should uprobe_perf_filter use same_thread_group as well instead
of mm pointers check?

jirka


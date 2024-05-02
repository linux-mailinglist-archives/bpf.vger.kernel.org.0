Return-Path: <bpf+bounces-28477-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4FF18BA151
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 22:04:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 781BF284821
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 20:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A9A180A97;
	Thu,  2 May 2024 20:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcgE78um"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A7017F392;
	Thu,  2 May 2024 20:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714680280; cv=none; b=LTGMSAfXCJZO92q4fFqbo/xvU+ZEsu25I7WpjCsE3oM1QQTWurs/uLAKhQFqJQ8x2eVa/U/Cj4BJ5kl6QVCWG05eMxkjkwzYscYsP3pYrEk2j1xq0/UfWPS/OmhEPJYMMp3Pu5iJQYKDQnewvTOYe3Mg/SRz4+8VCmh/5VtJodc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714680280; c=relaxed/simple;
	bh=7FCmVIdhb8qFtvDaZmeGrAF1uCcpjSj8SEAZWRsf7kc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AguNlnxe3RrBXxGu0CzIPD3pQ/PwBh5LqHZud77cvYRzTwed08WHjo2HtksfGSWmpdRsdsvaWC0WdCse5+NrN1wKnckLcjKt48ZEzapN7MDEIAHE5hbDL7SVM9Szp/Yta03M4AV4J9Kv0HcCXZzw0KqdvS44hmbgs1krg1eaRZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcgE78um; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a4702457ccbso1201948066b.3;
        Thu, 02 May 2024 13:04:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714680277; x=1715285077; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wKUSJ46i/1gUl3iF4hfQIWgYETEC/EKPdVMoKnC9CT8=;
        b=KcgE78umrzmF6H/yMKrotZPb7EMXkqZoTHKbstk4/dCP4bQQIR4kq4dvXGeK3h5mLH
         iG1ZqBEhFVtIcABgPkNob4IVsTMF3ar9/T8oTy4lYTo3pL5bKAd/kaTNjJUqQonZaqwa
         YAGeUE5rp/5AenddTrXh/wQA05i/nUUyCinaVJtDSAQjxzWsxbp8z+jYIHSWizh2Vu35
         LibrErWlWILL4kfjmj7yZiv0iO5I85sx/YUd9G0cdpeCHOzP/oB6xGmnO/UvGkD/WgkH
         Upl+byRX2RVsn4GlTwFU4DoQinjdgpxTLtx3gDjiEwn2XmW1nUSDWZbOuJ1JogVIvo9P
         yldw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714680277; x=1715285077;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wKUSJ46i/1gUl3iF4hfQIWgYETEC/EKPdVMoKnC9CT8=;
        b=Ne43z3SZPi/icE/4vOe1kvljIQVJTetqcx03y3+1CEKi6IMETDv7j4HJCqw8G+4/dN
         fZM0K951MQoyfnjoDlBGNLplSGHDIKZfHoxiIPjEMC2K/7uWxGkWkSn8bM9c0vuMbdBM
         ur2YiQHeJiD0sJhzLaTk5spMp+KlXEv8NjJoLpyjjRdz/HBS6lMpPX1SEDeVcV8OQ/Sm
         MGwIg6ZVFKfT/O8m7fj2bGtFvWursdf/oNsAXAQKuC7wMHTtSx+cbvqWhtCY9z72obm0
         VqQmwokLeU/NXpYBiqF0a57PiV4Bee0vNifTtGLQhTAKD11RXGGlaBGUnvIIDl/+533r
         H5gw==
X-Forwarded-Encrypted: i=1; AJvYcCW1kGuj1oUSOgp1uTZBI0mTmkHEadlRUrLE41Ozbg9pYh9qMJZtEePH+YKOE2jvmtHLknGaz48YGGZ4KNmI6giXHhSjpT+cd7EAUjTTega6PPIy5Cchqu6RaM5ratJBBjTkAUUmR/AAi/cCTjMebYvt0t9IYuoyMXiP6V9+cWtkbsQvX6ZdOkSRhXdPnZb5rvp+eOSmKWsfveKz8GlvYTM78BEzjU8kUbI+hIg+Vd1g3UbclfZVLBJ91GQl
X-Gm-Message-State: AOJu0YxIHuHp052Gvg89HeJPWCZeU1nF5uP0dtfo3MyZPbm5fTT5EYzd
	SdlxWxvzbHzTQw1+N1Apg8mOApFF5l8tx79dvmuoHIndcoXTzZpx
X-Google-Smtp-Source: AGHT+IF54QP7sxH15mqmjojykVUWN58GonsqCzbbE0qoxSCDVfwCxjsiRGyijzVxmFameQW8rHW24A==
X-Received: by 2002:a17:906:4aca:b0:a55:5ed2:44d5 with SMTP id u10-20020a1709064aca00b00a555ed244d5mr307287ejt.68.1714680276341;
        Thu, 02 May 2024 13:04:36 -0700 (PDT)
Received: from krava ([83.240.62.36])
        by smtp.gmail.com with ESMTPSA id l27-20020a170906079b00b00a524b33fd9asm885469ejc.68.2024.05.02.13.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 May 2024 13:04:36 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Thu, 2 May 2024 22:04:33 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCHv4 bpf-next 0/7] uprobe: uretprobe speed up
Message-ID: <ZjPx0fncg-8brFBk@krava>
References: <20240502122313.1579719-1-jolsa@kernel.org>
 <CAEf4BzYxsRMx9M_AiLavTHFpndSmZqOM8QcYhDTbBviSpv1r+A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYxsRMx9M_AiLavTHFpndSmZqOM8QcYhDTbBviSpv1r+A@mail.gmail.com>

On Thu, May 02, 2024 at 09:43:02AM -0700, Andrii Nakryiko wrote:
> On Thu, May 2, 2024 at 5:23 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > hi,
> > as part of the effort on speeding up the uprobes [0] coming with
> > return uprobe optimization by using syscall instead of the trap
> > on the uretprobe trampoline.
> >
> > The speed up depends on instruction type that uprobe is installed
> > and depends on specific HW type, please check patch 1 for details.
> >
> > Patches 1-6 are based on bpf-next/master, but path 1 and 2 are
> > apply-able on linux-trace.git tree probes/for-next branch.
> > Patch 7 is based on man-pages master.
> >
> > v4 changes:
> >   - added acks [Oleg,Andrii,Masami]
> >   - reworded the man page and adding more info to NOTE section [Masami]
> >   - rewrote bpf tests not to use trace_pipe [Andrii]
> >   - cc-ed linux-man list
> >
> > Also available at:
> >   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
> >   uretprobe_syscall
> >
> 
> It looks great to me, thanks! Unfortunately BPF CI build is broken,
> probably due to some of the Makefile additions, please investigate and
> fix (or we'll need to fix something on BPF CI side), but it looks like
> you'll need another revision, unfortunately.
> 
> pw-bot: cr
> 
>   [0] https://github.com/kernel-patches/bpf/actions/runs/8923849088/job/24509002194

yes, I think it's missing the 32-bit libc for uprobe_compat binary,
probably it needs to be added to github.com:libbpf/ci.git setup-build-env/action.yml ?
hm but I'm not sure how to test it, need to check

> 
> 
> 
> But while we are at it.
> 
> Masami, Oleg,
> 
> What should be the logistics of landing this? Can/should we route this
> through the bpf-next tree, given there are lots of BPF-based
> selftests? Or you want to take this through
> linux-trace/probes/for-next? In the latter case, it's probably better
> to apply only the first two patches to probes/for-next and the rest
> should still go through the bpf-next tree (otherwise we are running

I think this was the plan, previously mentioned in here:
https://lore.kernel.org/bpf/20240423000943.478ccf1e735a63c6c1b4c66b@kernel.org/

> into conflicts in BPF selftests). Previously we were handling such
> cross-tree dependencies by creating a named branch or tag, and merging
> it into bpf-next (so that all SHAs are preserved). It's a bunch of
> extra work for everyone involved, so the simplest way would be to just
> land through bpf-next, of course. But let me know your preferences.
> 
> Thanks!
> 
> > thanks,
> > jirka
> >
> >
> > Notes to check list items in Documentation/process/adding-syscalls.rst:
> >
> > - System Call Alternatives
> >   New syscall seems like the best way in here, becase we need
> 
> typo (thanks, Gmail): because

ok

> 
> >   just to quickly enter kernel with no extra arguments processing,
> >   which we'd need to do if we decided to use another syscall.
> >
> > - Designing the API: Planning for Extension
> >   The uretprobe syscall is very specific and most likely won't be
> >   extended in the future.
> >
> >   At the moment it does not take any arguments and even if it does
> >   in future, it's allowed to be called only from trampoline prepared
> >   by kernel, so there'll be no broken user.
> >
> > - Designing the API: Other Considerations
> >   N/A because uretprobe syscall does not return reference to kernel
> >   object.
> >
> > - Proposing the API
> >   Wiring up of the uretprobe system call si in separate change,
> 
> typo: is

ok, thanks

jirka


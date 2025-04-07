Return-Path: <bpf+bounces-55390-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD96FA7DBBA
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 13:01:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C8DB3B59E6
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 10:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400E5239594;
	Mon,  7 Apr 2025 10:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYk0Geni"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B6122376E4;
	Mon,  7 Apr 2025 10:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744023526; cv=none; b=C/VM4h78kgvr20jgAtwzYcfmZGuW1h+Y8Lc3m4Odb3iteyv/iW7AjOoz/JCSnZUdJRtdhX6Ea0ryC2RoreajgYVznMcXlNyzdhb5oy+vAfXYUajQN1txSRHsXW3QaVERlxuZsTgP7cZ9MMiymrW7mddZ69NCapX7Hd1eFMmsmIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744023526; c=relaxed/simple;
	bh=YfyJDHndhImXwHD+lxLnucJr9+H2E0EsPltuV6QeOLM=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=paIvxrYxr45UiJMI9UtlWVOVCbCEOcqy8ffdTaYTaAEeY87pnqHA7gBQpFzG/fkKvye1lx25tPwqkrR+6W5b9T0Ry5BypRBpKWCkaweBwE0KoY8bLbcnvdiKtmweE8z4p0BMIsDV5UOSJYoFb6sNCS9zm5PoqWoqiR4aO2uywaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYk0Geni; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43ce71582e9so27602495e9.1;
        Mon, 07 Apr 2025 03:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744023523; x=1744628323; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Sg7LM8I4duyMiZu2NKZNMofpZDJY8JJbr9Kg0MAWPq4=;
        b=bYk0GeniMc2QoUn6rBXqSip7tvWh8B2jv80HL2pibOXZ7k2Pk7Nlqw7G59Gjg2tNky
         ySYgl11mxfr2+0H3YvJk7UHa+z8hgl+ddMhoWqrAZdi0gEu51ETwFxv78eXNXtDEiL0F
         hZQ7gZmbumldsPH3H6foI5w1VzqkaYWVzJE+twMalYhd/k9ZmicEg3UV2kPqzIWwInH0
         e4uGlm8N/dR+zW/i/zxjUixcpL0t1Z5x8wHkdLFZG716/1SazSZzq/vA1hcyeZYr/7fu
         kXSohIDqrylMQGg7XVRyXlLHXl7D0D1lBgKrMb3U0kLGARO33VxS5rzBqOLNYcwN94bP
         KHSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744023523; x=1744628323;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sg7LM8I4duyMiZu2NKZNMofpZDJY8JJbr9Kg0MAWPq4=;
        b=RGpMUAM2zVRao6B1AZ+7yOUMQXle4vMTbpZx8S4BGVI5PNH4M08sDUluA3FhHATbHN
         /COsxIycTGqZbG6T3hn2BuXFSphqMdMEhsvYXzhF8/5rAiv/L/+8OxuR2hdmdG2bW7r6
         WS/Yun2ct/ZeCUVetmu2Iij62v6Yhma6SKtadlwP1w8hyow91y2YZpCFNohYPEKKSrD2
         0DZZM9IHd2OxRYO3axV4evw6COUS9cKvScKML3/Yywoak0Q8CVlwXsTN0nUPa8VwA8zb
         eeED5pAHK8vGlMjTMQIjhCkzQ9AqU22r/j/YDXDSm7Pxb3cA9lxHzeDAZl1uBebiww4j
         BsDw==
X-Forwarded-Encrypted: i=1; AJvYcCUs7hanp3YijVhhQHoYwvqjbNZWTl5L8WEgKWCPRfw9XDXAFOsB1SzhCNYS2XSH6ZW++vpTY2EgHB9HTFJO66/mQtSz@vger.kernel.org, AJvYcCViwmn4Tbh94Q9uHMDjeT9I+o2JM7x5RJKRe8UOO963sIvKNLUgVE3BfrthQlqv5w9AgyM0SuC1deOQlo6w@vger.kernel.org, AJvYcCWRFTtVaSDyhm+3ocREm/sKokbNqEUzjqpbKkiEKXpTZLS2yI0P3WaA9PlXfbnPrE8aoJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1fbyl2V3tC4GMyhcmsdh1MD9PEZ3nk+9HxgO5fftGCDG7oggQ
	n9UPKaIlCHj1V7ltPfU3gd5at4LgdJY1pyPHZQNTOl0L0d6CqJkCnrMt0cz/
X-Gm-Gg: ASbGncs1Fhbfl4hTkiesKvMz9D4/bLLJPIO3gQx3NKsVZp6ZOFl7Fl4nXFukjKNa7LB
	632IiZgiEzw2p10GirrAX3/qG05dZnGMuDJscShzQngaL4t6193ZSMOHwz+0fzIBUcX5OzWswgg
	AYLnaGdbCMcfW+9+oPng9Q8MImmm1gW1MQRQwX4zIr3/NV8BtoQkpQTZA9JUIhXESmAaShyQqgS
	cWa2VxIUyFE/VMSfvgxeFmHeMLaIVEdVdH1x4FYiCYaZe49tUue46IjPM2RjM6LUgvqrV35oerN
	2nXp2FpkXjH1KITciNkc38A3XGFchdw=
X-Google-Smtp-Source: AGHT+IG+glvYwDwffBOQs2J0FSZI/LoAk4me/YkWBCwkWnI6fWYtuQp8he4h3ld4OKZY6A0PyR3uog==
X-Received: by 2002:a05:600c:3548:b0:43d:77c5:9c1a with SMTP id 5b1f17b1804b1-43ed0b5e285mr113999015e9.4.1744023523083;
        Mon, 07 Apr 2025 03:58:43 -0700 (PDT)
Received: from krava ([173.38.220.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43ec147c9dbsm132237005e9.0.2025.04.07.03.58.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 03:58:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 7 Apr 2025 12:58:40 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	x86@kernel.org, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>, Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Alan Maguire <alan.maguire@oracle.com>,
	David Laight <David.Laight@aculab.com>,
	Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>
Subject: Re: [PATCH RFCv3 08/23] uprobes/x86: Add uprobe syscall to speed up
 uprobe
Message-ID: <Z_Ov4Eh_leCHMG0J@krava>
References: <20250320114200.14377-1-jolsa@kernel.org>
 <20250320114200.14377-9-jolsa@kernel.org>
 <CAEf4Bza=xexa6jixoz7dDY7WSoX3k5Tub231o_6nO_89LB_BjA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza=xexa6jixoz7dDY7WSoX3k5Tub231o_6nO_89LB_BjA@mail.gmail.com>

On Fri, Apr 04, 2025 at 01:33:07PM -0700, Andrii Nakryiko wrote:
> On Thu, Mar 20, 2025 at 4:43 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding new uprobe syscall that calls uprobe handlers for given
> > 'breakpoint' address.
> >
> > The idea is that the 'breakpoint' address calls the user space
> > trampoline which executes the uprobe syscall.
> >
> > The syscall handler reads the return address of the initial call
> > to retrieve the original 'breakpoint' address. With this address
> > we find the related uprobe object and call its consumers.
> >
> > Adding the arch_uprobe_trampoline_mapping function that provides
> > uprobe trampoline mapping. This mapping is backed with one global
> > page initialized at __init time and shared by the all the mapping
> > instances.
> >
> > We do not allow to execute uprobe syscall if the caller is not
> > from uprobe trampoline mapping.
> >
> > The uprobe syscall ensures the consumer (bpf program) sees registers
> > values in the state before the trampoline was called.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/entry/syscalls/syscall_64.tbl |   1 +
> >  arch/x86/kernel/uprobes.c              | 134 +++++++++++++++++++++++++
> >  include/linux/syscalls.h               |   2 +
> >  include/linux/uprobes.h                |   1 +
> >  kernel/events/uprobes.c                |  22 ++++
> >  kernel/sys_ni.c                        |   1 +
> >  6 files changed, 161 insertions(+)
> >
> 
> [...]
> 
> > +void handle_syscall_uprobe(struct pt_regs *regs, unsigned long bp_vaddr)
> > +{
> > +       struct uprobe *uprobe;
> > +       int is_swbp;
> > +
> > +       rcu_read_lock_trace();
> > +       uprobe = find_active_uprobe_rcu(bp_vaddr, &is_swbp);
> > +       if (!uprobe)
> > +               goto unlock;
> > +
> > +       if (!get_utask())
> > +               goto unlock;
> > +
> > +       if (arch_uprobe_ignore(&uprobe->arch, regs))
> > +               goto unlock;
> > +
> > +       handler_chain(uprobe, regs);
> > +
> > + unlock:
> > +       rcu_read_unlock_trace();
> 
> we now have `guard(rcu_tasks_trace)();`, let's use that in this
> function, seems like a good fit?

yes, will use it

thanks,
jirka

> 
> 
> > +}
> > +
> >  /*
> >   * Perform required fix-ups and disable singlestep.
> >   * Allow pending signals to take effect.
> > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > index c00a86931f8c..bf5d05c635ff 100644
> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -392,3 +392,4 @@ COND_SYSCALL(setuid16);
> >  COND_SYSCALL(rseq);
> >
> >  COND_SYSCALL(uretprobe);
> > +COND_SYSCALL(uprobe);
> > --
> > 2.49.0
> >


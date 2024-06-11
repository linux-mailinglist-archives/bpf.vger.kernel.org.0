Return-Path: <bpf+bounces-31781-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A9F90341C
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 09:45:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 897A11C21A09
	for <lists+bpf@lfdr.de>; Tue, 11 Jun 2024 07:45:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AEE8172BCC;
	Tue, 11 Jun 2024 07:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZS9uLdIn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A5A1E52F;
	Tue, 11 Jun 2024 07:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091889; cv=none; b=Fwws9DLq0FPEGQQM8Q3IhYDEp0bSAZmCuMuPx8NOzLx+geMsiRgagiJJiRR0POondbXOD7xlXla9U7ZZQoqvPVdStggn+eLkrJ8f+4to//iOK9ar5BTTjslb3dW09i6VqRWt6Rj3ZSgoewF8U2BeDg0jnR+hgGa6ZqKoIkfbNSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091889; c=relaxed/simple;
	bh=SDqAx+l0Jjbh3zwtEx4gpEmG6LW9mMxqD0J4QCprdCk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XvXaQ+Y5VT+M6PydciBB+z3+ty+Hc20G14CmkR4KTlAn14WPF7jinxCId9FBypJtg/qTEup04Qd82PKN4eTwu0tIqan+9CdiyP3RaPOJGZJtVd+lb+x34fQs12INfDMfzIV1frbJmzvPkIuhVw7Qtz1wV6uvIMZ5mituZV9AS4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZS9uLdIn; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a6f0c3d0792so81813566b.3;
        Tue, 11 Jun 2024 00:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718091886; x=1718696686; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hq7VlDHf7pEbFf7v8zZEUyFUewiFD+NWVkc0x5bTvZM=;
        b=ZS9uLdInbVq4n6as0JN+a6QjMdMMV+ZUKgNDHRWblWBfLXUC9Gjab5edoicc/QqB+g
         WmPithd7wCU+hHQK9u7sYqg1P60M8bITEgVKJXWIKO5ywemNe3GW6yNuVTUzMSZkpbdf
         xN6VbCrwQRoC1HxPYekgtO1DkT/xIPzjHIXzME2vFQV+JmcQfkD/PSVaJDFG1dJB0BNQ
         rKmUwbuzm2b2aVuBKaxX0w8yJMItk+Ks6FmUbaa7s4rXc8u+DbzqLC/QrFiLtDOgF3JY
         cnFnHm60orjKp5k3ZAYf//IlXpHV3MR6QDE+Nfd7HfrdXRykUa/5vLDB7U+LuJFidj4x
         bxUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718091886; x=1718696686;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hq7VlDHf7pEbFf7v8zZEUyFUewiFD+NWVkc0x5bTvZM=;
        b=dAUKwfkDJ1lzO9eH82iVqiUQX/j951/aU53gcLN7ieCevbw9rCwgCOMCaooG1jZkIQ
         wb9x/qwnNaOG6TON1v0rokR4S2zkMiLZ7Gx2bDCZ7bNOAykJ5YQmcDmvKFrgplSO2wWR
         Qr4r8ZF/uno9rGWU8TD6KUjSFm98oDxLPgbb2hcaqjksrsfHD3gERhr2KGnrc+wg3mUj
         wZVsdIOaEcYOv6RfjypEQEG4VxxmRN3ytSOHwp9gYuNd+LCsSBuQ+tcSsjkG9d0JoLXp
         20s4JQuJPLGBWE54s09y/luO3uT6379DowLfwc86V0fm3bTeAOvdFQxX0apWHktsGYaO
         Wh3g==
X-Forwarded-Encrypted: i=1; AJvYcCUIOKAJV9UinP2/pv7F9KWzj5OHuXrmz4ogOSMMXvEwgMoZc+8k95qXtI2wa4KGEYXL2OKtAr7tWyGv4o/FUbEbqaGLY7OuO6R2YoRzqt089ERZoU+GJR3WFIpjxhPz2ZgVvDT+TU0x4ZbkfKG+NJVTrNro7eoXGUsTeT9PCtDD6b1M4MERj2wie9glBgFhAlM2NuXRcaLiiO6D66wbCGeZSKvXs4Wr7MycWZCoowJeizh6q7xHcvafVCOh
X-Gm-Message-State: AOJu0YyaSeSgsqpDIjhI37eC5pjMGdBodZJ2rQDXGh74rfN43pya3TN9
	zepOJqG+Wb6N2OzQEQ3yxQ3w8Nh4lSt6+EraifYP6fW7fNEBCgFu
X-Google-Smtp-Source: AGHT+IHlSFuxcjLt48JBJua/3vo0MpwKdqxWfXLKbeLpZ2nG+r1CWlnSG/xlxAddGeHS3HfvKBYIUQ==
X-Received: by 2002:a17:906:3c06:b0:a6f:1f5d:4db5 with SMTP id a640c23a62f3a-a6f1f5d4e67mr307274566b.34.1718091886042;
        Tue, 11 Jun 2024 00:44:46 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f152b0bf9sm316620866b.65.2024.06.11.00.44.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 00:44:45 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 11 Jun 2024 09:44:43 +0200
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
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
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv7 bpf-next 2/9] uprobe: Wire up uretprobe system call
Message-ID: <ZmgAawOdLZAZynA_@krava>
References: <20240523121149.575616-1-jolsa@kernel.org>
 <20240523121149.575616-3-jolsa@kernel.org>
 <20240611070521.82da62690e8865ff498327f7@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240611070521.82da62690e8865ff498327f7@kernel.org>

On Tue, Jun 11, 2024 at 07:05:21AM +0900, Masami Hiramatsu wrote:
> On Thu, 23 May 2024 14:11:42 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Wiring up uretprobe system call, which comes in following changes.
> > We need to do the wiring before, because the uretprobe implementation
> > needs the syscall number.
> > 
> > Note at the moment uretprobe syscall is supported only for native
> > 64-bit process.
> > 
> 
> BTW, this does not cleanly applied to probes/for-next, based on
> 6.10-rc1. Which version did you use?

ah new syscall just got merged, I'll rebase and send new version

jirka

> 
> Thank you,
> 
> > Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> > Reviewed-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/x86/entry/syscalls/syscall_64.tbl | 1 +
> >  include/linux/syscalls.h               | 2 ++
> >  include/uapi/asm-generic/unistd.h      | 5 ++++-
> >  kernel/sys_ni.c                        | 2 ++
> >  4 files changed, 9 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
> > index cc78226ffc35..47dfea0a827c 100644
> > --- a/arch/x86/entry/syscalls/syscall_64.tbl
> > +++ b/arch/x86/entry/syscalls/syscall_64.tbl
> > @@ -383,6 +383,7 @@
> >  459	common	lsm_get_self_attr	sys_lsm_get_self_attr
> >  460	common	lsm_set_self_attr	sys_lsm_set_self_attr
> >  461	common	lsm_list_modules	sys_lsm_list_modules
> > +462	64	uretprobe		sys_uretprobe
> >  
> >  #
> >  # Due to a historical design error, certain syscalls are numbered differently
> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index e619ac10cd23..5318e0e76799 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -972,6 +972,8 @@ asmlinkage long sys_lsm_list_modules(u64 *ids, u32 *size, u32 flags);
> >  /* x86 */
> >  asmlinkage long sys_ioperm(unsigned long from, unsigned long num, int on);
> >  
> > +asmlinkage long sys_uretprobe(void);
> > +
> >  /* pciconfig: alpha, arm, arm64, ia64, sparc */
> >  asmlinkage long sys_pciconfig_read(unsigned long bus, unsigned long dfn,
> >  				unsigned long off, unsigned long len,
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index 75f00965ab15..8a747cd1d735 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -842,8 +842,11 @@ __SYSCALL(__NR_lsm_set_self_attr, sys_lsm_set_self_attr)
> >  #define __NR_lsm_list_modules 461
> >  __SYSCALL(__NR_lsm_list_modules, sys_lsm_list_modules)
> >  
> > +#define __NR_uretprobe 462
> > +__SYSCALL(__NR_uretprobe, sys_uretprobe)
> > +
> >  #undef __NR_syscalls
> > -#define __NR_syscalls 462
> > +#define __NR_syscalls 463
> >  
> >  /*
> >   * 32 bit systems traditionally used different
> > diff --git a/kernel/sys_ni.c b/kernel/sys_ni.c
> > index faad00cce269..be6195e0d078 100644
> > --- a/kernel/sys_ni.c
> > +++ b/kernel/sys_ni.c
> > @@ -391,3 +391,5 @@ COND_SYSCALL(setuid16);
> >  
> >  /* restartable sequence */
> >  COND_SYSCALL(rseq);
> > +
> > +COND_SYSCALL(uretprobe);
> > -- 
> > 2.45.1
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


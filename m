Return-Path: <bpf+bounces-27680-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD0B8B0AB1
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 15:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DE1B28783
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 13:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7D2B15CD55;
	Wed, 24 Apr 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lHgApBrG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45EF715B568
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 13:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964789; cv=none; b=CZ+WclpTNtVHx/EQ8Z1cTsGBlPr4JcsX+lEt5KkJqMc8pZMKONs8DfufYvmdBfX65eTbbQot4Yuxqa3TGtalC5Z9fOx2lYSBp703htVMCeOOtJxyLIE0soRxdPi/HZBmxT9RkbV9nLiTdsjGoi7rhW99w2YdDIAgzTTG1zOdFLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964789; c=relaxed/simple;
	bh=/GQoX1gc0yl6e/Pz8zk6L9EPOwroU4wExy1cX78SnUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXALhwtaZm8kuG9KpPL9bVk7IdPnu9An30afX0qcX0XoWmwEPJtO4DBLr4y76FqydsjmLG8oTfYTJoBcR1OKEzYhstUqELcmiVGlB3jYQUlGHFDD2Keoc/qn9Ph/jRnwxRaE3Fi838e3e5QwhWNlldPmQb99q5F4Qe9/K4wDpqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=lHgApBrG; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-5ce07cf1e5dso4840423a12.2
        for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 06:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1713964786; x=1714569586; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8VvHJ58Y+Q3UWAzWsSTTjuIwD8U8vgOkrH/9YIF6f+M=;
        b=lHgApBrG4E6j0tbQuXywkr1MB58N2Bx9nktuAzORtFE377i1FUVwrKNdg871OpwQvK
         tmBuLsubIW6D+NgNoy9IcN4PgzuKaN/7pYR36T1Bwmxfh7+2yPQn7npHwO+e/kPs2K63
         WmHL37zDXk4UHA6ztqWrVCiy4aFkqIrmHZVUI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964786; x=1714569586;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8VvHJ58Y+Q3UWAzWsSTTjuIwD8U8vgOkrH/9YIF6f+M=;
        b=FgTb2LjPjAD8cCJMafjZmMUq6e0qbPs7Etd42/SnjyGRmtAAUdKapiXhid5XecyI36
         8tDs6SwMtczWdf8roaIt4Aw/uruLt9QEisJcYtYtZ7OmF1jRD0CHmkQ6L6CFXboVoIum
         hYOqVGYNTBwHwoNL5NPN/SojO6Wez+AWBLg5EG/HSWhkBZ5D2NvqyJgWLz8Wp/C3WfBj
         qCvMOzVvBR3dW35/6yBVtBYZLFUDqIOIrhLMbbTHZpr9aPZCUAXTFwB4yDht18joNulK
         Td1LczgHaNtlK9pLSym2wIy2DC6mtjkSgwVglHeT82cZCuRhYstyX2krTFqI/TR/nEaz
         +56Q==
X-Forwarded-Encrypted: i=1; AJvYcCXVJtQsnvvEF0ICB275e9BQtpmxD82h6UhWPwFhMdrQG/DEaM9xkJidTRE7NQGGjVJHaG3+X3Azx7k+sfHWlh3+/BHf
X-Gm-Message-State: AOJu0Yyh/4dfjMj4m+ifTP5AlzhkLKANo8NmJ/KX3ozSMRzi9hatrWfV
	ITSZsKsNJ8N96j1h9xDr8qQezoKtt2uTPsqodNhs7lL8kaycJPe6gwWtkZJayUB3ymrpJjjVbmn
	a/5XpgkfySKtnrEmL2Dl7Bo38t95BbzJf6f39
X-Google-Smtp-Source: AGHT+IEUzUPrMZm5/9Nr7/HujqEqTFgw9lpTp1RH6c+ZBPmhrdCrzL9/trH59BuNk2ibQ8CFKYuYBk72hhVixMAIZqA=
X-Received: by 2002:a17:90b:4f41:b0:2a5:275c:ed with SMTP id
 pj1-20020a17090b4f4100b002a5275c00edmr2474867pjb.23.1713964786600; Wed, 24
 Apr 2024 06:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <171318533841.254850.15841395205784342850.stgit@devnote2>
 <171318535003.254850.2125783941049872788.stgit@devnote2> <CABRcYmK_Btem8cBbz=j==RWxw11PQ8cNAUshNA540VD3O=2WEQ@mail.gmail.com>
In-Reply-To: <CABRcYmK_Btem8cBbz=j==RWxw11PQ8cNAUshNA540VD3O=2WEQ@mail.gmail.com>
From: Florent Revest <revest@chromium.org>
Date: Wed, 24 Apr 2024 15:19:24 +0200
Message-ID: <CABRcYmK+JMLDf41csuZB4aJSb9956wTy=5rpB1YDsSv0-MoZHg@mail.gmail.com>
Subject: Re: [PATCH v9 01/36] tracing: Add a comment about ftrace_regs definition
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alan Maguire <alan.maguire@oracle.com>, Mark Rutland <mark.rutland@arm.com>, 
	Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Guo Ren <guoren@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 24, 2024 at 2:23=E2=80=AFPM Florent Revest <revest@chromium.org=
> wrote:
>
> On Mon, Apr 15, 2024 at 2:49=E2=80=AFPM Masami Hiramatsu (Google)
> <mhiramat@kernel.org> wrote:
> >
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> > To clarify what will be expected on ftrace_regs, add a comment to the
> > architecture independent definition of the ftrace_regs.
> >
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > Acked-by: Mark Rutland <mark.rutland@arm.com>
> > ---
> >  Changes in v8:
> >   - Update that the saved registers depends on the context.
> >  Changes in v3:
> >   - Add instruction pointer
> >  Changes in v2:
> >   - newly added.
> > ---
> >  include/linux/ftrace.h |   26 ++++++++++++++++++++++++++
> >  1 file changed, 26 insertions(+)
> >
> > diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
> > index 54d53f345d14..b81f1afa82a1 100644
> > --- a/include/linux/ftrace.h
> > +++ b/include/linux/ftrace.h
> > @@ -118,6 +118,32 @@ extern int ftrace_enabled;
> >
> >  #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS
> >
> > +/**
> > + * ftrace_regs - ftrace partial/optimal register set
> > + *
> > + * ftrace_regs represents a group of registers which is used at the
> > + * function entry and exit. There are three types of registers.
> > + *
> > + * - Registers for passing the parameters to callee, including the sta=
ck
> > + *   pointer. (e.g. rcx, rdx, rdi, rsi, r8, r9 and rsp on x86_64)
> > + * - Registers for passing the return values to caller.
> > + *   (e.g. rax and rdx on x86_64)
>
> Ooc, have we ever considered skipping argument registers that are not
> return value registers in the exit code paths ? For example, why would
> we want to save rdi in a return handler ?
>
> But if we want to avoid the situation of having "sparse ftrace_regs"
> all over again, we'd have to split ftrace_regs into a ftrace_args_regs
> and a ftrace_ret_regs which would make this refactoring even more
> painful, just to skip a few instructions. :|
>
> I don't necessarily think it's worth it, I just wanted to make sure
> this was considered.

Ah, well, I just reached patch 22 and noticed that there you add add:

+ * Basically, ftrace_regs stores the registers related to the context.
+ * On function entry, registers for function parameters and hooking the
+ * function call are stored, and on function exit, registers for function
+ * return value and frame pointers are stored.

So ftrace_regs can be a a sparse structure then. That's fair enough with me=
! ;)


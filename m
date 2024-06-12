Return-Path: <bpf+bounces-31899-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C50904890
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 03:52:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5124B1F231EF
	for <lists+bpf@lfdr.de>; Wed, 12 Jun 2024 01:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093075CB0;
	Wed, 12 Jun 2024 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZvKsVxH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344623A6;
	Wed, 12 Jun 2024 01:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157117; cv=none; b=S2hOqstsUELCpFppNLxKa5gxoA9CAoLZGwjGS9sPWXB4z+EubZtDulBOsbK/6cIkXSuERL5/P8PpFXmX8OtbjlQzl3MguCKEtaHAxpQlGegdkoin+Oj1JTtCiQDi25sZprM604NnwMagoVA5srQ3HzS/lVgJsp65/ugxQPjBXF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157117; c=relaxed/simple;
	bh=1lKjKHgZXxpzKEQ4D77NUPkcv/NqaWGJUPk357x+XNM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xb5qJ0vOebIXxFIohL6TA2FM8QO9HP+pmLK1Qgx0kPKkV9QapKVgjbw9R6ZnIXC2W1yKSXzmlxhtSh0JukLq86WGK86v5w9mRLQYW+df0+tlHR0CPFVcENMd7Yv2cxZcVkcQd54wUlh2H5kC7Jpu7slDEbCktFUOhpSP6V95dpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZvKsVxH; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dfac121b6a6so370970276.0;
        Tue, 11 Jun 2024 18:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718157115; x=1718761915; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+LnnyAhOCYXQLVabOMqh38kfH9Iz+v6Vt2+PY+nihaA=;
        b=OZvKsVxHW+Ccdhh6diGpqRdQob6qDpwmdKQk0aKujR6BoTJZ+BpUTcpbGcVdYvZ0pb
         JeL2P89Dh6rEAGSRdNKi8BTyvq3I45TG/43RhAHX2pQMNL7nkSQ4E1D4BZYF+Xz0UeDl
         z3VbQLYg+tV2D6wSAMD6K8nQtfQeQnd1BNLVwTLy9PHEZSL3jHDfG7QpJCM8oshJ1dTV
         EY/97rP+JuyawSrzfUNrTcgUCI+XEIDwEtsDenYGrntlBdysN/WeCgvcRPHEaTtubJ1v
         tG5IrXdlg709TfCB6Z1Wu/Dm8toUCGg26WVe3XMzg/ND+WEOqzW4UxjeibqTcixJtidw
         2EFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718157115; x=1718761915;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+LnnyAhOCYXQLVabOMqh38kfH9Iz+v6Vt2+PY+nihaA=;
        b=KFil4Gb6Hk8rzBHyhQrzHG1wtZPhDzQWDU6y1P7z+hDBymIhxpP0yhpz0sTHBvYvJC
         nHB24PHLcphjg99JDZ6LLXyfb7aRqdoirjFz5NbpZgfN82RvIFXXmQSfQ4COt+76kGtC
         8+ZGJN2NN5Yaku+CBoXU3ETBvsa1lO0tIvhZxM+Wpe3KHawPuzDW+e0ttXbfkNTLlXph
         my71lHnK8bvAZ2EEzIdBPaC796yThDw0wp9VJ5DXzU9kVTpm1Dc1y3P4GXb81uxZTQcL
         2c89fWef0ktdFlenVV8+qo+IpQWE9bBrI4xeUxCcKqUJsuw3hNVkfLKzRwkLs48la8kN
         IVsA==
X-Forwarded-Encrypted: i=1; AJvYcCXx5shOezrXDw2dG+haZa6wMzfs6xO1jUNQqsIFsiaZQEOEdIbyxZaY0aNI6Tgvs7cyAHM4r2HzeQc40OCTZsQqjjkMSKPJum72/scue+8YG7Lp4imBBroMOj7YQO27SOvtHS1DHBXvqOaAQZFgbw3X+gv7lxhmhPie4Yn+juNNiNtFjMU+wLc9NaclWPtiJ6BksXqwgQs/tji3g9/z+mWl0ON+MZlpGePM4g==
X-Gm-Message-State: AOJu0YyWVKNao80yWGOEln9TLwu5ULvG0oe6cvZmPXO9zKicJpoWtgqL
	zEXcCIZL06XVbqyhej7q2wsPhsV/uXWYf1jNp4L3iFaa65bPuFGBbfFoWN5Pkr/W+BQwnGJBYjY
	ae3N70bufGPgMxWbAnXXR5VGxZRM=
X-Google-Smtp-Source: AGHT+IFuPc14bIak76YCYivfOYSFKOKYpp1NO+8Np7OS9qj8Cg7q6QEHqa70qRg5t2uLkrA5Iztwio+7HKipTjQ0SBY=
X-Received: by 2002:a5b:b02:0:b0:dfa:de92:19e6 with SMTP id
 3f1490d57ef6-dfe4c57964fmr324443276.28.1718157114767; Tue, 11 Jun 2024
 18:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240610131032.516323-1-howardchu95@gmail.com> <ZmiftHw-66m3WymK@x1>
In-Reply-To: <ZmiftHw-66m3WymK@x1>
From: Howard Chu <howardchu95@gmail.com>
Date: Wed, 12 Jun 2024 09:51:45 +0800
Message-ID: <CAH0uvoigeXvLPXKz4Yp=jHHm637bkEvDdSUKW7MYOj5Pu7WNbw@mail.gmail.com>
Subject: Re: [PATCH v1] perf trace: BTF-based enum pretty printing
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: peterz@infradead.org, mingo@redhat.com, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com, 
	mic@digikod.net, gnoack@google.com, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

[Resend because of the HTML error]

Hello Arnaldo,
Thanks a lot for the review, I guess you call it v1 for a reason. :)
> > +
> > +     id = btf__find_by_name(btf, type);
>
>         int id = ...

Do you want me to do the initialization in the middle of the function
body sir? A little reminder, char* pointer 'type' has to be shifted to
the first non-enum-prefix location to do the btf__find_by_name().

>
> > +     if (id < 0)
>
> Shouldn't we have some warning here? ok, I see you do it later, in
> trace__read_syscall_info().

I'm sorry, could you be more specific please? To my understanding, it
is syscall__scnprintf_args() who called btf_enum_scnprintf(), and I
did the error handling(or fallback) by calling
syscall_arg_fmt__scnprintf_val(). It's like:

if btf_enum_scnprintf() returns non-0 // success
        continue;
else // error
        syscall_arg_fmt__scnprintf_val()

So we fall back to just printing the long value.

>
> Also I looked at the btf_enum_scnprintf() caller and if this isn't found
> nothing is printed, it is better to fallback to printing the integer
> value, as done in other parts, see:

Do you think the code below could be seen as a sort of fallback
mechanism? If nothing is printed, btf_enum_scnprintf() returns a 0, we
continue to do a syscall_arg_fmt__scnprintf_val() as the fallback. I
tested it by putting return 0 at the top of btf_enum_scnprintf(), and
it works, although not so straightforward... Maybe I should put the
fallback straight in btf_enum_scnprintf().

> > +                     if (sc->arg_fmt[arg.idx].is_enum == true && trace->btf) {
> > +                             p = btf_enum_scnprintf(bf + printed, size - printed, val,
> > +                                                    trace->btf, field->type);
> > +                             if (p) {
> > +                                     printed += p;
> > +                                     continue;
> > +                             }
> > +                     }
> > +
> >                       printed += syscall_arg_fmt__scnprintf_val(&sc->arg_fmt[arg.idx],
> >                                                                 bf + printed, size - printed, &arg, val);

>
> size_t strarray__scnprintf(struct strarray *sa, char *bf, size_t size, const char *intfmt, bool show_prefix, int val)
>
> That intfmt is configurable to show hex or decimal and is used when the
> 'val' isn't found in the strarray, so we should use the same approach
> with BTF.
>
> > +             return 0;
> > +
> > +     bt = btf__type_by_id(btf, id);
> > +     e = btf_enum(bt);
>
> Declare 'bt' and 'e' here
>
> > +
> > +     for (int i = 0; i < btf_vlen(bt); i++, e++) {
> > +             if (e->val == val)
> > +                     return scnprintf(bf, size, "%s",
> > +                                      btf__name_by_offset(btf, e->name_off));

you mean doing it like this?
```
for (bt = btf__type_by_id(btf, id), e = btf_enum(bt), i = 0;
     i < btf_vlen(bt); i++, e++) {
        if (e->val == val) {
                return scnprintf(bf, size, "%s",
                btf__name_by_offset(btf, e->name_off));
        }
}
```

> This is shaping up super nicely, great!

:) Thank you so much sir.

>
> I'm pushing the simplified first patch to my tmp.perf-tools-next branch
> in my tree at:
>
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tmp.perf-tools-next
>
> https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git/log/?h=tmp.perf-tools-next

Sure, I'll pull from it and build the enum support on top of that.

>
> Some more comments below.
>
> >       if (last_field)
> >               sc->args_size = last_field->offset + last_field->size;
> > @@ -1811,6 +1854,7 @@ static int trace__read_syscall_info(struct trace *trace, int id)
> >       char tp_name[128];
> >       struct syscall *sc;
> >       const char *name = syscalltbl__name(trace->sctbl, id);
> > +     int err;
> >
> >  #ifdef HAVE_SYSCALL_TABLE_SUPPORT
> >       if (trace->syscalls.table == NULL) {
> > @@ -1883,7 +1927,17 @@ static int trace__read_syscall_info(struct trace *trace, int id)
> >       sc->is_exit = !strcmp(name, "exit_group") || !strcmp(name, "exit");
> >       sc->is_open = !strcmp(name, "open") || !strcmp(name, "openat");
> >
> > -     return syscall__set_arg_fmts(sc);
> > +     err = syscall__set_arg_fmts(sc);
>
> > +     /* after calling syscall__set_arg_fmts() we'll know whether use_btf is true */
> > +     if (sc->use_btf && trace->btf == NULL) {
> > +             trace->btf = btf__load_vmlinux_btf();
> > +             if (verbose > 0)
> > +                     fprintf(trace->output, trace->btf ? "vmlinux BTF loaded\n" :
> > +                                                         "Failed to load vmlinux BTF\n");
> > +     }
>
> One suggestion here is to get the body of the above if and have it in a
> trace__load_vmlinux_btf(), as that call and the test under verbose will
> be used in other places, for instance, when supporting using BTF to
> pretty print non-syscall tracepoints.
>
> This function probably will grow to support detached BTF, possibly that
> idea about generating BTF from the scrape scripts, etc.

Sure.

Thank you very much for reviewing this patch, v2 is coming up.

Thanks,
Howard

>
> Thanks,
>
> - Arnaldo
>
> > +     return err;
> >  }
> >
> >  static int evsel__init_tp_arg_scnprintf(struct evsel *evsel)
> > @@ -2050,7 +2104,7 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
> >                                     unsigned char *args, void *augmented_args, int augmented_args_size,
> >                                     struct trace *trace, struct thread *thread)
> >  {
> > -     size_t printed = 0;
> > +     size_t printed = 0, p;
> >       unsigned long val;
> >       u8 bit = 1;
> >       struct syscall_arg arg = {
> > @@ -2103,6 +2157,15 @@ static size_t syscall__scnprintf_args(struct syscall *sc, char *bf, size_t size,
> >                       if (trace->show_arg_names)
> >                               printed += scnprintf(bf + printed, size - printed, "%s: ", field->name);
> >
> >               }
> > --
> > 2.45.2


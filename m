Return-Path: <bpf+bounces-29765-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D113E8C68C9
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 16:32:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E6A0281C4E
	for <lists+bpf@lfdr.de>; Wed, 15 May 2024 14:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA7015534E;
	Wed, 15 May 2024 14:32:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dJkJiNn6"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663D01552F9;
	Wed, 15 May 2024 14:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715783564; cv=none; b=Eys7l/rYSBfBj8e5fagaoTNgZuBf4YeughJgonhnxPlw2DWz8PP3y7PRBQHr0cPq9IbKemZaBEBEcsjYBEJQ+gffo1vAItEJOCSpmdCWOT1QIzPjrcXtPnxf6aqEt991brnW7l5Zhqx64rMfr2Yi8JEeaC0xy1/szfUI6Yqc/Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715783564; c=relaxed/simple;
	bh=Yg7jgxyl4X82FxAlAReEjwuh9q2p3wzZQFhJR6p+Lwk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omSzyFdaANnEdZ7Y3A7TUXD2tUrxFz3YGbOJInZHsv20rfKz0kKssda/ZOE1DqzmmTWsWdHJUfclUYnGoq/AUjItU7RvBKaTisvRC0CW5nAjfb68JWqKflqFc6hZbcSRKlUXyQfENYPMb5L9DLHvQX3qybHeyVOX09Uv/Fic9Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dJkJiNn6; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-2b33e342c03so5955790a91.0;
        Wed, 15 May 2024 07:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715783562; x=1716388362; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sRekZWcFDy+QJE7Lne8xPlJLlBrRM+zl8GZZB+TlTa0=;
        b=dJkJiNn6F9Mn0dHg97pQCzciIdg+217lABfIsMNzPYeUtcld1U0F7ugi1DKKPT2JTN
         F9P8zdC8AKPzcR+F/5f1xjwdM6+DYMNSG2Ac1Z263yJm4dsj+WoFU8A1aKGSmaYE0SRK
         nCie98Fu/USztOxjaYLYLEImK3uj5bhVnRoVw807/A+200ZVtfFiYgn63/Wxs7EmUtmw
         0V0ziEk5r2J5q8qvCkesUiD7xYghy7Y8VPp/9in3Ahkb404MV4Kngapghr36zTrhtPjh
         1n/dXqPh8C9CGkv+ornKG1P/zIAv1WwFsaAQo+iwXHiCLIMpuwnwkpqx8j87icf8hzBP
         LuAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715783562; x=1716388362;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sRekZWcFDy+QJE7Lne8xPlJLlBrRM+zl8GZZB+TlTa0=;
        b=bFvxK42eWKdd5ZmRv1QvhOP8xkI/se/iCyP2t/tujBbJDfm9V2jxWc3Kgwjkg1S3am
         oJOzINYXNr9zT6VVjRn9Ps/mbTnuZ7YsXhEeQwdwADafzQ4Q//hRb9ykhBDfb5Sm0EaN
         oNBjeFhSwDxI8/mLvSG9LvmIhPO0ZHUbCcRhBVTCQyl96AjYcEZZrud+W/r/hjmvLpDB
         Pc53noeogqI3Ejq7G1sfAZ/5SLOgXFRzs1amlDvLbJU0PslO+99rVsO7SL1N0ELJwG91
         3pqBMYBJ0IsK0jnXBR2kaox1TW5+Zv9Rq9fQGFzP1LMl0ef8Uowm9xmKLk3S6ezSK3xA
         kzPA==
X-Forwarded-Encrypted: i=1; AJvYcCVBSc9V1A3kFvb0UUbTSfLfWox3Zu7g8AqVEkdlRbvodyy0GtWhD+2SfaGeit/SXytXOdCMgqqz3F0AIbvQoBZmh9f4jy5f5KYP57gQg1RQukW870W5lRgAi3hSA1MPpwG0GcEW+HmMEWMP2dD3vnVNgFVVldWfpzMuYXPuS1lDXoKwW0HKTiuM5g==
X-Gm-Message-State: AOJu0Yzk/4rKIQ3d1D7yr2sO4hLStKHn8OeyHetUDAm125bMsIIopaPp
	rx28oD6XqQMOIT6sG6H7/AZXpw/LqyVJWoBOzD7dBUf6ldR5sUyRQxNjqv5IX7/YvYB2sgqKYtD
	DHdj/kZ0DyLPueZhZuQiyGM82Mt4=
X-Google-Smtp-Source: AGHT+IGXEaEJceL/acYsYX2RIdNQGHDA4F5Wz1Ob2iQaCC7TdMMEr0eNi/Ni9YYf3CD4uSSNDG1iJNWxokS7o2zikjY=
X-Received: by 2002:a17:90a:8c83:b0:2a4:e9d:9888 with SMTP id
 98e67ed59e1d1-2b6cc452f7emr15077923a91.16.1715783562495; Wed, 15 May 2024
 07:32:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508212605.4012172-1-andrii@kernel.org> <20240508212605.4012172-3-andrii@kernel.org>
 <20240515093013.GE40213@noisy.programming.kicks-ass.net>
In-Reply-To: <20240515093013.GE40213@noisy.programming.kicks-ass.net>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 15 May 2024 08:32:30 -0600
Message-ID: <CAEf4Bzazi7YMz9n0V46BU7xthQjNdQL_zma5vzgCm_7C-_CvmQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf,uprobes: fix user stack traces in the presence
 of pending uretprobes
To: Peter Zijlstra <peterz@infradead.org>
Cc: Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com, 
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com, 
	linux-perf-users@vger.kernel.org, Riham Selim <rihams@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 15, 2024 at 3:30=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Wed, May 08, 2024 at 02:26:03PM -0700, Andrii Nakryiko wrote:
>
> > +static void fixup_uretprobe_trampoline_entries(struct perf_callchain_e=
ntry *entry,
> > +                                            int start_entry_idx)
> > +{
> > +#ifdef CONFIG_UPROBES
> > +     struct uprobe_task *utask =3D current->utask;
> > +     struct return_instance *ri;
> > +     __u64 *cur_ip, *last_ip, tramp_addr;
> > +
> > +     if (likely(!utask || !utask->return_instances))
> > +             return;
> > +
> > +     cur_ip =3D &entry->ip[start_entry_idx];
> > +     last_ip =3D &entry->ip[entry->nr - 1];
> > +     ri =3D utask->return_instances;
> > +     tramp_addr =3D uprobe_get_trampoline_vaddr();
> > +
> > +     /* If there are pending uretprobes for current thread, they are
>
> Comment style fail. Also 'for *the* current thread'.
>

ack, will fix

> > +      * recorded in a list inside utask->return_instances; each such
> > +      * pending uretprobe replaces traced user function's return addre=
ss on
> > +      * the stack, so when stack trace is captured, instead of seeing
> > +      * actual function's return address, we'll have one or many uretp=
robe
> > +      * trampoline addresses in the stack trace, which are not helpful=
 and
> > +      * misleading to users.
>
> I would beg to differ, what if the uprobe is causing the performance
> issue?

If uprobe/uretprobe code itself is causing performance issues, you'll
see that in other stack traces, where this code will be actively
running on CPU. I don't think we make anything worse here.

Here we are talking about the case where the uprobe part is done and
it hijacked the return address on the stack, uretprobe is not yet
running (and so not causing any performance issues). The presence of
this "snooping" (pending) uretprobe is irrelevant to the user that is
capturing stack trace. Right now address in [uprobes] VMA section
installed by uretprobe infra code is directly replacing correct and
actual calling function address.

Worst case, one can argue that both [uprobes] and original caller
address should be in the stack trace, but I think it still will be
confusing to users. And also will make implementation less efficient
because now we'll need to insert entries into the array and shift
everything around.

So as I mentioned above, if the concern is seeing uprobe/uretprobe
code using CPU, that doesn't change, we'll see that in the overall set
of captured stack traces (be it custom uprobe handler code or BPF
program).

>
> While I do think it makes sense to fix the unwind in the sense that we
> should be able to continue the unwind, I don't think it makes sense to
> completely hide the presence of uprobes.

Unwind isn't broken in this sense, we do unwind the entire stack trace
(see examples in the later patch). We just don't capture actual
callers if they have uretprobe pending.

>
> > +      * So here we go over the pending list of uretprobes, and each
> > +      * encountered trampoline address is replaced with actual return
> > +      * address.
> > +      */
> > +     while (ri && cur_ip <=3D last_ip) {
> > +             if (*cur_ip =3D=3D tramp_addr) {
> > +                     *cur_ip =3D ri->orig_ret_vaddr;
> > +                     ri =3D ri->next;
> > +             }
> > +             cur_ip++;
> > +     }
> > +#endif
> > +}


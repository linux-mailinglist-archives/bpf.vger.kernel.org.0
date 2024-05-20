Return-Path: <bpf+bounces-30070-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CAB28CA542
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 01:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36E07281AC1
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 23:57:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 739651386D5;
	Mon, 20 May 2024 23:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ri10lk+M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97C5428E7;
	Mon, 20 May 2024 23:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716249430; cv=none; b=NsxsyxLeLKE2pDv0ZR+GHFynyZa9/RzpjRot1/eGhvX57X3WwKW4Lom3fdG1RnnB6kwzjzb3vwXbmsro9FXD82nMbSh6pMwteXpqlZdm1cGZnaFCXrTRHSZtp5v8U1D9qYqrGPCvV1vE2cAucTXVTjWqFNfEUXA6EhON/0s5pLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716249430; c=relaxed/simple;
	bh=0jo+sgVIkLOwEsgCQvcpC+PmTYdsxS5rYEqEcSy7mCs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLQ4Q1VWXhAze0yiXPc8w6NKMAFTogH6T8n74RutavpdGWz6avtmEwjkKjzhovXatExwklhrh35bnsg6Qs7ZNlDAfAmGSAw1dtmrhXIfJ6Hq9U8c6FU7/5McwvJkbU9YJAzLOXdXFdlCM9ST7rLqQoTLphjArDffpr0hle8Xeak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ri10lk+M; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1ed41eb3382so91549075ad.0;
        Mon, 20 May 2024 16:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716249428; x=1716854228; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EE6IpG5I4UOCyMj9vqRWxuu1/1ZMKl94G/m/Ym1EC/8=;
        b=Ri10lk+Muo9JkeAsm/b+YzXQF9cD/MvoWm2tn6+1xO//flThqcqovjHQt/N6FfSgXq
         7gx9zt0T4Uc3Ft7MCbpu0CjJFiAc+2UzUwE1RemaCW6Gpr83VPa+baHR30tir83tg6LP
         7ZVbNK+geCAj760FYdrJsDYry8Tn7qDLfpctijsGPSiUS/DgZt9sH3uIgys8Ne2CSpzK
         T9TMNnx30IgyTxL0twhjY09tn7n5R9ShrNgWBfIDxqiHfomIpsTQIEDuq0TJQ+OHO0A+
         QUSYOIrDdKXIft/nwnavTLk9rXa0HDVUFt9nmAYlgRkme9eOCB5InC2Z9hqlJd+yMNSq
         qULw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716249428; x=1716854228;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EE6IpG5I4UOCyMj9vqRWxuu1/1ZMKl94G/m/Ym1EC/8=;
        b=GSRP1tnWF0zqTx189miCTrjYm8NWNAceHIsCivFmkamaSBLmXtOcDYfUc7nlWClKve
         F1y0DGRYW77WJh00wGoSaEYnZXy3Iv8AkrJ5LQbpI+OJSViY3DTOq+pdE/PGlLMxtdM2
         vNG1TMSIg46M+PZVT9xGYl7kqQBmKqUeuJYH0v1uKnouHgDBJKQeqv+KljF24sQ406Mu
         2W/+od+dnXgbgsFu0IgxNDSMSpaz6/fqqpMIK8HIKTxCKZSbC/dCcJ6b8QsdVRvqEP7f
         guxXbVYQqhKRDsAqqMJlQ90eAnTvOatipK3Tq061nylFYS9ln1s+C1GzAySwLuDMHJIh
         PQVw==
X-Forwarded-Encrypted: i=1; AJvYcCXdYW5f8hHKxJWc9Uj2oEZnKGpCqBgaa5/EKqje92Wb7QAGojJ+OYo1J2IA3vAYHFqcitKZlFFwMeTwJgCbxtRjav88mXE4rb++ZZULFwEC73Bs/9icjIJE8DK4XwMzjsVRDlBdzDZs2wlYcjiciSEn9fGiKgJVcVS8A6NO7W1tWjLPwVdwTDj7kA==
X-Gm-Message-State: AOJu0YwLcoQVG9yF/ESWvFuoNoolbijpwZnxQ52fX1GdHY7x3mmnJ00F
	Ksl3oWZGjnmKz8Mbvj0OBSm4kEN5OWvEwDq4CsUffEaEdQ4Ql75NMl8kRan0c1yC56/2OQt2/PN
	3xRKk5JOVmsfRX+ybGITgIq3KDpSg7yQq
X-Google-Smtp-Source: AGHT+IFPoFGAICpYFTWVuTiR6gPb55eBEmy+MP86n98A24XcxoTf2f6uBv7B9PnxrBctr3G1sHHCtVkSxe+QUOXq+/M=
X-Received: by 2002:a05:6a20:2594:b0:1ae:3f36:28d3 with SMTP id
 adf61e73a8af0-1afde197878mr48322732637.49.1716249427867; Mon, 20 May 2024
 16:57:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240508212605.4012172-1-andrii@kernel.org> <20240508212605.4012172-3-andrii@kernel.org>
 <20240515093013.GE40213@noisy.programming.kicks-ass.net> <CAEf4Bzazi7YMz9n0V46BU7xthQjNdQL_zma5vzgCm_7C-_CvmQ@mail.gmail.com>
 <ZktqJEsmsVawdPNU@krava>
In-Reply-To: <ZktqJEsmsVawdPNU@krava>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 20 May 2024 16:56:55 -0700
Message-ID: <CAEf4BzZw_a1eE8YSnEyhvznS+Uj6k6xTasv2pD41nD7BGe_=Hg@mail.gmail.com>
Subject: Re: [PATCH 2/4] perf,uprobes: fix user stack traces in the presence
 of pending uretprobes
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Andrii Nakryiko <andrii@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	x86@kernel.org, mingo@redhat.com, tglx@linutronix.de, bpf@vger.kernel.org, 
	rihams@fb.com, linux-perf-users@vger.kernel.org, 
	Riham Selim <rihams@meta.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, May 20, 2024 at 8:20=E2=80=AFAM Jiri Olsa <olsajiri@gmail.com> wrot=
e:
>
> On Wed, May 15, 2024 at 08:32:30AM -0600, Andrii Nakryiko wrote:
> > On Wed, May 15, 2024 at 3:30=E2=80=AFAM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> > >
> > > On Wed, May 08, 2024 at 02:26:03PM -0700, Andrii Nakryiko wrote:
> > >
> > > > +static void fixup_uretprobe_trampoline_entries(struct perf_callcha=
in_entry *entry,
> > > > +                                            int start_entry_idx)
> > > > +{
> > > > +#ifdef CONFIG_UPROBES
> > > > +     struct uprobe_task *utask =3D current->utask;
> > > > +     struct return_instance *ri;
> > > > +     __u64 *cur_ip, *last_ip, tramp_addr;
> > > > +
> > > > +     if (likely(!utask || !utask->return_instances))
> > > > +             return;
> > > > +
> > > > +     cur_ip =3D &entry->ip[start_entry_idx];
> > > > +     last_ip =3D &entry->ip[entry->nr - 1];
> > > > +     ri =3D utask->return_instances;
> > > > +     tramp_addr =3D uprobe_get_trampoline_vaddr();
> > > > +
> > > > +     /* If there are pending uretprobes for current thread, they a=
re
> > >
> > > Comment style fail. Also 'for *the* current thread'.
> > >
> >
> > ack, will fix
> >
> > > > +      * recorded in a list inside utask->return_instances; each su=
ch
> > > > +      * pending uretprobe replaces traced user function's return a=
ddress on
> > > > +      * the stack, so when stack trace is captured, instead of see=
ing
> > > > +      * actual function's return address, we'll have one or many u=
retprobe
> > > > +      * trampoline addresses in the stack trace, which are not hel=
pful and
> > > > +      * misleading to users.
> > >
> > > I would beg to differ, what if the uprobe is causing the performance
> > > issue?
> >
> > If uprobe/uretprobe code itself is causing performance issues, you'll
> > see that in other stack traces, where this code will be actively
> > running on CPU. I don't think we make anything worse here.
>
> I think we do similar thing in kernel unwind for rethook trampoline used
> in fprobe/kretprobe code, so seems ok to me to do it for uprobes as well
>
> >
> > Here we are talking about the case where the uprobe part is done and
> > it hijacked the return address on the stack, uretprobe is not yet
> > running (and so not causing any performance issues). The presence of
> > this "snooping" (pending) uretprobe is irrelevant to the user that is
> > capturing stack trace. Right now address in [uprobes] VMA section
> > installed by uretprobe infra code is directly replacing correct and
> > actual calling function address.
> >
> > Worst case, one can argue that both [uprobes] and original caller
> > address should be in the stack trace, but I think it still will be
> > confusing to users. And also will make implementation less efficient
> > because now we'll need to insert entries into the array and shift
> > everything around.
>
> agreed this would be confusing.. also as you noted above the return
> trampoline did not get executed yet at the time of the callstack,
> so it's bit misleading
>
> might be stupid idea.. but we do have the 'special' context entries
> that we store in the callstack to mark user/kernel/guest context ..

only when explicitly requested (add_mark argument to
get_perf_callchain), right? BPF doesn't ever set this to true and
generally speaking users don't care and shouldn't care about pending
uretprobe. I think we are conflating unrelated things here, uretprobe
is not running, so it's not really in the stack trace. I'd just do
nothing about it, it should stay transparent.

If uretprobe *handler* is causing issues, you'll see that in all the
other stack traces (according to relative CPU/resource usage of that
handler).

> maybe we could add some special entry (context does not fit too well)
> to point out there's uretprobe going on .. perf tool could print
> 'uretprobe' hint when displaying the original address
>
> jirka
>
> >
> > So as I mentioned above, if the concern is seeing uprobe/uretprobe
> > code using CPU, that doesn't change, we'll see that in the overall set
> > of captured stack traces (be it custom uprobe handler code or BPF
> > program).
> >
> > >
> > > While I do think it makes sense to fix the unwind in the sense that w=
e
> > > should be able to continue the unwind, I don't think it makes sense t=
o
> > > completely hide the presence of uprobes.
> >
> > Unwind isn't broken in this sense, we do unwind the entire stack trace
> > (see examples in the later patch). We just don't capture actual
> > callers if they have uretprobe pending.
> >
> > >
> > > > +      * So here we go over the pending list of uretprobes, and eac=
h
> > > > +      * encountered trampoline address is replaced with actual ret=
urn
> > > > +      * address.
> > > > +      */
> > > > +     while (ri && cur_ip <=3D last_ip) {
> > > > +             if (*cur_ip =3D=3D tramp_addr) {
> > > > +                     *cur_ip =3D ri->orig_ret_vaddr;
> > > > +                     ri =3D ri->next;
> > > > +             }
> > > > +             cur_ip++;
> > > > +     }
> > > > +#endif
> > > > +}
> >


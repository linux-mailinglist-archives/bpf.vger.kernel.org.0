Return-Path: <bpf+bounces-30029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 887F08C9F81
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 17:20:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC2651C21225
	for <lists+bpf@lfdr.de>; Mon, 20 May 2024 15:20:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BFC5136E1A;
	Mon, 20 May 2024 15:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFVb44CA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7F1E49D;
	Mon, 20 May 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716218411; cv=none; b=CZjq6BjsobnUBgAZ2/thgt/cZD7nkck4PyoNoTgssSVUdr9a+2XLuV/cezImTUi0wTHhHPl9/RcD2sc7Sdv9mtQrlCPUi9JfOkcmSyDbRhLM8lOZGwkNfyPnbJS9BxboUV2Ehl5uOR+3fe3zk2KGA5CQP973sFNB+fusyprFh5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716218411; c=relaxed/simple;
	bh=N6fEg1pyqaOsfC47bR4QbKVFbMf4jtbYbZ3SQBu6klk=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rokDhc5q/OL1300HiHoDGPXVcQBF+Bzn/mJfUR0he8hXsYhjph4cPpGI2XcItEvMTj0Gv2FVtfg5OIvWyj+KzifrVR92bid/8RnuAME7aKbvcTERiBFyE3+nCJXzA5mEQkFYgT9cz4ftHdK1a6e9vRiXYHMcajzPzvYQJ9klpkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AFVb44CA; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4200ee78f33so22125915e9.3;
        Mon, 20 May 2024 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716218408; x=1716823208; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=em/KEqasq7vpAe1VPn6oJS+HRlUkBEq2Y5EIncGB1fo=;
        b=AFVb44CAjMQXAUvps2X3KdvH8aSWv407TzpFD5sMtYtVqvdZJajoTpfsHM3H6F+PPM
         R6qSiI5US6d94PSdxO110q7APqbf7crW6g2B+TdCpm7fGFS26V+TI07p8e94qEyABrZn
         usqjHbYDleD+DJ84/XfiTUIVZPBy2heQu0C4m/m8JLbMMtf5/xeM6kKltOCyki0T60mM
         yamfiOzO8KnxqBZkSbAE4ayY2QSUlX1BlikFwWH9GxvvP2rZXQ8JdbGdL4sfhmhHleFF
         wyUkPOhMM5y9sVfyxWVLNcqABqm3jhFFseV/uAJfJzdAptdGJbTEFeM9dEob1vBvfup4
         OlOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716218408; x=1716823208;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=em/KEqasq7vpAe1VPn6oJS+HRlUkBEq2Y5EIncGB1fo=;
        b=Yxz78DSNKe908rVD+qtvcCwMM2RWIRbIhRpS65KONfIJ6fAF59zOABp4VZWoTlGWTy
         YBq+WSr75oUmYRGxbLIlBLGGKBTj3wmywX033AgOHk/4dnKZUr25/hgBxXlhDQWEzTWo
         3zLxS1txfnWJCanzFaA+PjbrceAlcwg+s5pbzpQcwpSep+Zsr4WdhrvpXm6AR64/0imL
         PLJ7+U3H+sgRGcvqqWvqUTG0gsDlx4XuAyEMUvIufOX4hOzfyuQOc1KoYWewmpTuMHzM
         FDaheKsZgjavM5jYQ4LMOc1nln2Z7xCwiHAA8y8Cj6Gs04/s9CAcRICllv00QgUFpUsF
         5VWA==
X-Forwarded-Encrypted: i=1; AJvYcCWbHlE3ZRUmRNOs3fbBqfzAW1UlwCm0f56nixLHk2uOC+92/9rD0w8rD8E1KZ9guRgFacvDEky03593JLZVp3PItmHw2rSXsnJ4GYqXGMKpST0sRjJ+cULuuwoliKBTFVDpEf6e3zkUFMosPx8GnGV/8ZSdqdsnvpuDD2VW9SDxfQLLhtA5PMj98A==
X-Gm-Message-State: AOJu0Yy/HWx7KwnayvrojIG5yxJ+4dnyWxs+S3kpHg0hjL4uKaw45r6P
	T0CKSfVx8lluJNIqlLivoyQe/2BARY7bVtpmBX+z2ib3xjGmSNqP
X-Google-Smtp-Source: AGHT+IGQLam3jCntGZ7QaJLqSJe6OjnQfTqwX/5OLP3js7D9iL3km/fMHr0inTnl10uAYNKvcB72zw==
X-Received: by 2002:a05:600c:4ecc:b0:420:2b2e:f6e7 with SMTP id 5b1f17b1804b1-4202b2ef814mr107282885e9.17.1716218407408;
        Mon, 20 May 2024 08:20:07 -0700 (PDT)
Received: from krava ([2a00:102a:4030:3ad2:f918:d0bd:fbd5:61c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87b2653bsm458947885e9.4.2024.05.20.08.20.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 May 2024 08:20:07 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 20 May 2024 17:20:04 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org,
	mhiramat@kernel.org, x86@kernel.org, mingo@redhat.com,
	tglx@linutronix.de, bpf@vger.kernel.org, rihams@fb.com,
	linux-perf-users@vger.kernel.org, Riham Selim <rihams@meta.com>
Subject: Re: [PATCH 2/4] perf,uprobes: fix user stack traces in the presence
 of pending uretprobes
Message-ID: <ZktqJEsmsVawdPNU@krava>
References: <20240508212605.4012172-1-andrii@kernel.org>
 <20240508212605.4012172-3-andrii@kernel.org>
 <20240515093013.GE40213@noisy.programming.kicks-ass.net>
 <CAEf4Bzazi7YMz9n0V46BU7xthQjNdQL_zma5vzgCm_7C-_CvmQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bzazi7YMz9n0V46BU7xthQjNdQL_zma5vzgCm_7C-_CvmQ@mail.gmail.com>

On Wed, May 15, 2024 at 08:32:30AM -0600, Andrii Nakryiko wrote:
> On Wed, May 15, 2024 at 3:30 AM Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Wed, May 08, 2024 at 02:26:03PM -0700, Andrii Nakryiko wrote:
> >
> > > +static void fixup_uretprobe_trampoline_entries(struct perf_callchain_entry *entry,
> > > +                                            int start_entry_idx)
> > > +{
> > > +#ifdef CONFIG_UPROBES
> > > +     struct uprobe_task *utask = current->utask;
> > > +     struct return_instance *ri;
> > > +     __u64 *cur_ip, *last_ip, tramp_addr;
> > > +
> > > +     if (likely(!utask || !utask->return_instances))
> > > +             return;
> > > +
> > > +     cur_ip = &entry->ip[start_entry_idx];
> > > +     last_ip = &entry->ip[entry->nr - 1];
> > > +     ri = utask->return_instances;
> > > +     tramp_addr = uprobe_get_trampoline_vaddr();
> > > +
> > > +     /* If there are pending uretprobes for current thread, they are
> >
> > Comment style fail. Also 'for *the* current thread'.
> >
> 
> ack, will fix
> 
> > > +      * recorded in a list inside utask->return_instances; each such
> > > +      * pending uretprobe replaces traced user function's return address on
> > > +      * the stack, so when stack trace is captured, instead of seeing
> > > +      * actual function's return address, we'll have one or many uretprobe
> > > +      * trampoline addresses in the stack trace, which are not helpful and
> > > +      * misleading to users.
> >
> > I would beg to differ, what if the uprobe is causing the performance
> > issue?
> 
> If uprobe/uretprobe code itself is causing performance issues, you'll
> see that in other stack traces, where this code will be actively
> running on CPU. I don't think we make anything worse here.

I think we do similar thing in kernel unwind for rethook trampoline used
in fprobe/kretprobe code, so seems ok to me to do it for uprobes as well

> 
> Here we are talking about the case where the uprobe part is done and
> it hijacked the return address on the stack, uretprobe is not yet
> running (and so not causing any performance issues). The presence of
> this "snooping" (pending) uretprobe is irrelevant to the user that is
> capturing stack trace. Right now address in [uprobes] VMA section
> installed by uretprobe infra code is directly replacing correct and
> actual calling function address.
> 
> Worst case, one can argue that both [uprobes] and original caller
> address should be in the stack trace, but I think it still will be
> confusing to users. And also will make implementation less efficient
> because now we'll need to insert entries into the array and shift
> everything around.

agreed this would be confusing.. also as you noted above the return
trampoline did not get executed yet at the time of the callstack,
so it's bit misleading

might be stupid idea.. but we do have the 'special' context entries
that we store in the callstack to mark user/kernel/guest context ..
maybe we could add some special entry (context does not fit too well)
to point out there's uretprobe going on .. perf tool could print
'uretprobe' hint when displaying the original address

jirka

> 
> So as I mentioned above, if the concern is seeing uprobe/uretprobe
> code using CPU, that doesn't change, we'll see that in the overall set
> of captured stack traces (be it custom uprobe handler code or BPF
> program).
> 
> >
> > While I do think it makes sense to fix the unwind in the sense that we
> > should be able to continue the unwind, I don't think it makes sense to
> > completely hide the presence of uprobes.
> 
> Unwind isn't broken in this sense, we do unwind the entire stack trace
> (see examples in the later patch). We just don't capture actual
> callers if they have uretprobe pending.
> 
> >
> > > +      * So here we go over the pending list of uretprobes, and each
> > > +      * encountered trampoline address is replaced with actual return
> > > +      * address.
> > > +      */
> > > +     while (ri && cur_ip <= last_ip) {
> > > +             if (*cur_ip == tramp_addr) {
> > > +                     *cur_ip = ri->orig_ret_vaddr;
> > > +                     ri = ri->next;
> > > +             }
> > > +             cur_ip++;
> > > +     }
> > > +#endif
> > > +}
> 


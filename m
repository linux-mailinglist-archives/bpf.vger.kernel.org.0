Return-Path: <bpf+bounces-70210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14056BB4693
	for <lists+bpf@lfdr.de>; Thu, 02 Oct 2025 17:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D32D77A8C62
	for <lists+bpf@lfdr.de>; Thu,  2 Oct 2025 15:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F1823815D;
	Thu,  2 Oct 2025 15:56:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g5dyak8T"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF88FC8E6
	for <bpf@vger.kernel.org>; Thu,  2 Oct 2025 15:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420577; cv=none; b=QJiEsrvkf+OloD2c6J9gg3VIafcvZ4YsBXI2j47M2qglTezoq95jq308fHFLffKhjQUgnhXP4k7RPtvx3nGyywdQY1WfWko+EEP3dtjWqB8dW8zLhsMW+f8AtreQMF9qYK64yzhcODw5Wd8oJcTgwy57a78rJkz+OQGcvEcxiMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420577; c=relaxed/simple;
	bh=KUfcYUbu/muEbj74ERfxLXABYKawkKI307LZWTNHAgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jrc+tpc7xYhoMz9PtQvLvEvtKBerhvkybTq0hdVKbY97JyRhW/8CzZ7JutRf4xd596LiOtQKYEdO0LQxARl14/7J/4aTbSQPGaOdTmVWR2sn4+xwYbzw1tBCL70QK9Cx1lxcl1VXOjyC6F+JKZuZ2WFrgjoNhrKlB+RSnUleMCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g5dyak8T; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3ece0e4c5faso908322f8f.1
        for <bpf@vger.kernel.org>; Thu, 02 Oct 2025 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759420574; x=1760025374; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdyh4wmb5V8pyfrkTTwZj4YHUfqOyJgCfii0PZkBZ5U=;
        b=g5dyak8TxrOycf8cXivhyyhMRfB7ouYvhmWrxfIFIv12zxMl3Rn2jWqLwG3grLY6k6
         4f1AHz8hT3+hWkSVyEkJ83MWugpnl5FUFTB5JQemMp5O1ghUBDL014/gEkhMNyqIFiD0
         xQCEbBZSUUBxnSwhW4pW6XP4dwXEJil2gFUMmO2Gw4tuAljbA9zmTziQ7pTT3h3LlJSP
         3CtXg9joNv45RvKoBrPSimJi+95GL/KRRIaROct/5I2ROLj4K7wIdpsNkn8Qrg+YNVoR
         Po9qUKPd+yppxQcSjoD9pF1URU/B9sNfdrv/1gmzRQ5Jt/y62lJfQxFeGNHwJt4YnybB
         tSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759420574; x=1760025374;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jdyh4wmb5V8pyfrkTTwZj4YHUfqOyJgCfii0PZkBZ5U=;
        b=Lbgf6vNHpnt7MKpo+rBZ7c8b1S+HYDQGLN8eMQNfPk9wYpx2BlNPxeEHqJMV/HepkW
         6HNMfhNcDM6WaOmZy5G5fioTWcEbbKqn1ycr5OsaQJOeVkCTj4CNnEby1ZHrH4TDS9ff
         KfAcIKoCfEAe/8XfmMnx9yWHuYV8XET4VBAA8pLLevCDv2UKekZCp0LBatUQGDIBfSEL
         cK27xAiABTUwdEd+DHNftv3DnkGcKGX73lhGsJso8Jlp6epzdTuaUXoTJ2CM8BDiTqIG
         Nvfv7UEto6gZB2opccH0W+pbcHa68d7NtN7iyDqJJxVlTp/DwaQivSV77ctqq9YzQA/t
         g4lQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmBxH06ya2bGbincTsjsnmb1+A2jxrQ9x4ddbvIaEw/QseG7CJ6ACNr4s+x7cdreI9RN0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1mM3w4OLc46Dr8+vLZqeyo64ELhC5UXmHW1fi1GLbWDIKhv0U
	FS25+iR/y07zEXndyJP12B/U5ANrP4qMEqFZxGuBnSa7DKW/HCf6Ku4lja78DuTsxj+LqO9P81c
	7Fzdb01zLc2z6njOrkmQiqLvsGSsJqrc=
X-Gm-Gg: ASbGncucY1rgXThBPUwwfCHkjJdzDHZgzgB7vN46ObKQzOCP3yn27efs5nvpjpbkPgf
	LI9X0aNGO9m2ls0clXN2Ri/xZ5trldNsOY6sGkDdUWTU/BgKSBNDYOYM65zQAVD+qFCfr8XlVKN
	9GCRoIVV5G823Zm/pqNGtL7vLTaYc+20yzU5AmgUFf1GSYU9WQEgwu6eAYpmj3/gVNSAZPXliUl
	0jsSzzZG/zHSzeFtBKs5DNTkaKmKf1imfuKr55QUOqhLxo=
X-Google-Smtp-Source: AGHT+IEDMwvbUr2B4eb1eZb0+PAIl/xbEYkOoOwsMQQFC4JmRupQckAhNbPcsupE4KDmrFw5eVL6bDr5gQLcnqvrPLY=
X-Received: by 2002:a05:6000:430d:b0:3ee:141a:ede5 with SMTP id
 ffacd0b85a97d-4255781eba6mr6016604f8f.57.1759420573740; Thu, 02 Oct 2025
 08:56:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <7fa58961-2dce-4e08-8174-1d1cc592210f@paulmck-laptop>
 <20251001144832.631770-8-paulmck@kernel.org> <CAADnVQLozKuSPMe4qUDxCV6pCSQ=rQNKy524K7R=uM5yTpLV0Q@mail.gmail.com>
 <5e9b7d89-fbd9-48f2-a538-a3aeaab5d9ec@paulmck-laptop>
In-Reply-To: <5e9b7d89-fbd9-48f2-a538-a3aeaab5d9ec@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 2 Oct 2025 08:56:01 -0700
X-Gm-Features: AS18NWAStqe9dfpAB3Avy46hxPEr4IQu2RChUx_xDCBuWYq7ABMx1dXRJ73yh-I
Message-ID: <CAADnVQJQCA-PCnaCVP8QE8W-S_8PsX8W=L7AUjo2Q10ekYndUA@mail.gmail.com>
Subject: Re: [PATCH v2 08/21] rcu: Add noinstr-fast rcu_read_{,un}lock_tasks_trace()
 APIs
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: rcu@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, 
	Kernel Team <kernel-team@meta.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 6:38=E2=80=AFAM Paul E. McKenney <paulmck@kernel.org=
> wrote:
>
> On Wed, Oct 01, 2025 at 06:37:33PM -0700, Alexei Starovoitov wrote:
> > On Wed, Oct 1, 2025 at 7:48=E2=80=AFAM Paul E. McKenney <paulmck@kernel=
.org> wrote:
> > >
> > > +static inline struct srcu_ctr __percpu *rcu_read_lock_tasks_trace(vo=
id)
> > > +{
> > > +       struct srcu_ctr __percpu *ret =3D __srcu_read_lock_fast(&rcu_=
tasks_trace_srcu_struct);
> > > +
> > > +       rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> > > +       if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
> > > +               smp_mb(); // Provide ordering on noinstr-incomplete a=
rchitectures.
> > > +       return ret;
> > > +}
> >
> > ...
> >
> > > @@ -50,14 +97,15 @@ static inline void rcu_read_lock_trace(void)
> > >  {
> > >         struct task_struct *t =3D current;
> > >
> > > +       rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep_map);
> > >         if (t->trc_reader_nesting++) {
> > >                 // In case we interrupted a Tasks Trace RCU reader.
> > > -               rcu_try_lock_acquire(&rcu_tasks_trace_srcu_struct.dep=
_map);
> > >                 return;
> > >         }
> > >         barrier();  // nesting before scp to protect against interrup=
t handler.
> > > -       t->trc_reader_scp =3D srcu_read_lock_fast(&rcu_tasks_trace_sr=
cu_struct);
> > > -       smp_mb(); // Placeholder for more selective ordering
> > > +       t->trc_reader_scp =3D __srcu_read_lock_fast(&rcu_tasks_trace_=
srcu_struct);
> > > +       if (!IS_ENABLED(CONFIG_TASKS_TRACE_RCU_NO_MB))
> > > +               smp_mb(); // Placeholder for more selective ordering
> > >  }
> >
> > Since srcu_fast() __percpu pointers must be incremented/decremented
> > within the same task, should we expose "raw" rcu_read_lock_tasks_trace(=
)
> > at all?
> > rcu_read_lock_trace() stashes that pointer within a task,
> > so implementation guarantees that unlock will happen within the same ta=
sk,
> > while _tasks_trace() requires the user not to do stupid things.
> >
> > I guess it's fine to have both versions and the amount of copy paste
> > seems justified, but I keep wondering.
> > Especially since _tasks_trace() needs more work on bpf trampoline
> > side to pass this pointer around from lock to unlock.
> > We can add extra 8 bytes to struct bpf_tramp_run_ctx and save it there,
> > but set/reset run_ctx operates on current anyway, so it's not clear
> > which version will be faster. I suspect _trace() will be good enough.
> > Especially since trc_reader_nesting is kinda an optimization.
>
> The idea is to convert callers and get rid of rcu_read_lock_trace()
> in favor of rcu_read_lock_tasks_trace(), the reason being the slow
> task_struct access on x86.  But if the extra storage is an issue for
> some use cases, we can keep both.  In that case, I would of course reduce
> the copy-pasta in a future patch.

slow task_struct access on x86? That's news to me.
Why is it slow?
static __always_inline struct task_struct *get_current(void)
{
        if (IS_ENABLED(CONFIG_USE_X86_SEG_SUPPORT))
                return this_cpu_read_const(const_current_task);

        return this_cpu_read_stable(current_task);
}


The former is used with gcc 14+ while later is with clang.
I don't understand the difference between the two.
I'm guessing gcc14+ can be optimized better within the function,
but both look plenty fast.

We need current access anyway for run_ctx.


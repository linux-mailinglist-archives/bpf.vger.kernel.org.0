Return-Path: <bpf+bounces-43068-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A690B9AED6E
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 19:14:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65F95281122
	for <lists+bpf@lfdr.de>; Thu, 24 Oct 2024 17:14:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92EBC200132;
	Thu, 24 Oct 2024 17:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIDOqRZR"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E29061FF7B9;
	Thu, 24 Oct 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729789962; cv=none; b=HA1AQZdwaEn0TqsGYBt7iAoNEsFr5wOyZoBofBanaWPxumIyWeBOdMagJcFANykY2mp8u8/0qS3m3R6Tr0EwG/Zp4gf+b3CcEgAeNuQK5J/wDzccm1IyRpAS0lr0xa/8jhTDFavYa5RbuaOTrpxvL2zJMoxIC+8noI2BQwwF2po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729789962; c=relaxed/simple;
	bh=qooFLoDzNVp+u9t3WDthRztPfIQE7At8c07/hzonvCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gvNs4eJU37Wq0/ZXQ7surVNrtEbs7rfgZJpxeAS1fdez01eUTHmUTwBibr9PsqJQ7co6hslvtoQw7jL8E8abW7bl1q6+nL6xdCG4fNOalWSnxFjJhl0pp70PEn9GvT8tT2GaRwUD7yr7rIW0K6InGPf/jL60exSnXcys3ZTkxQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIDOqRZR; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7ea7e250c54so824408a12.0;
        Thu, 24 Oct 2024 10:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729789959; x=1730394759; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M2a7HtinUc8E27y0RukSWxjxiEAN0ZIxICpL86iKsyQ=;
        b=lIDOqRZREf+ego4W5bvIFzAbpkODklVQmOkLKrwNpBTtCT3fVhG+4FLOrm52C5LSse
         3rwgWoosxGU5LmYPmTTuuF723p4PUY+ul0Y/EscOHo9MKVEmzCc+1N1hUeG0v/GreoWV
         GWapo59/KFMOkhupMDIT6GACj+hZTxAiRAMUBSSjOXJC+OtMMIcWRpUrcv71OtJ9su+e
         m1CDtZzLvGMVJXZfchIvnS9VM744WxHOI5R6BwR8tX1KyST9jrbCPCOCcfPNxiReIYsu
         zhbkf/D45Xl4DU9iuC/FPr8uE+k9pp/kSwSPZE4Xk8DbMs6roOwNBnOdH5UFkarpbeRi
         N7sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729789959; x=1730394759;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M2a7HtinUc8E27y0RukSWxjxiEAN0ZIxICpL86iKsyQ=;
        b=I7fi1rQRpkbzlFJToC5M7fH6+0LAuqRuhH2NKi/9Df+JDEnGjJJIvDaoT9e+T2QyQB
         JSyEXZ1HcO0RAJs04o3WRD2i26+VdpF/8HDpbtUs6UjG6sRl+ilUMWIi0uVmdurHO3lB
         HxitI6JDGwqCVsvKbQs8R99zu2trGWxxXtRhWluDKeSidREJHMM4Sjku9mNy7R5+nKkB
         jxuhheOkVjkzeJzd/hwQxuyd9cUrDmzePFGFAX8EBoH8+7misELDHkAQhqLZ90qz7O7M
         bFVFm82Lx9mQzgjw1D4qxqR9UfJ1NKTY+McLcRivKadYOb/FhEa1mKzvO/oJAy60N1LF
         RWvw==
X-Forwarded-Encrypted: i=1; AJvYcCUKpKwUEJs/eDTRgutnGhzhjfKrAUm8EqY8FUM3UVUjMOjg44XbVX3PKWzuHClYn+B/8nmaJie08JHaOFK7@vger.kernel.org, AJvYcCWB7TXTlFjrHaN2wPU5yldAXyX/4MbOGi4glmXhR7t413Lry5fDF7rVeSNzcwul3WWci4s=@vger.kernel.org
X-Gm-Message-State: AOJu0YztWlbQjTS4CreuQUOI6bwR1r72U34THeosCx3nQtn7JDLa+RCr
	frLmLv3XyX6Qhy60V7hDBwWngOsxKCpDnqOt3m45+y3V6jWDNN2nJqOjbIdM1f+VFJWzzhr4xPJ
	F82TxkYK4GkPzsbn5+6rE8Q52NdQ=
X-Google-Smtp-Source: AGHT+IGnQdkRtuaPIWv7vmuzGMztfBta0ZHAR6mQxtlYEZ87sFVRadTD2un/SSDCz4bB7Uwg1sGL8oeRnJgHv4nADkE=
X-Received: by 2002:a05:6a21:a343:b0:1d9:275b:4ef8 with SMTP id
 adf61e73a8af0-1d978b2dac4mr8674183637.23.1729789959193; Thu, 24 Oct 2024
 10:12:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADKFtnTdWX9prHYMe62oNraaNm=Q3WC9wTfdDD35a=CYxaX2Gw@mail.gmail.com>
 <20241023145640.1499722-1-jrife@google.com> <CAADnVQJupBceq2DAeChBvdjSG4zOpYsMP7_o7gREVmVCA0PUYQ@mail.gmail.com>
 <7bcea009-b58c-4a00-b7cd-f2fc06b90a02@efficios.com> <20241023220552.74ca0c3e@rorschach.local.home>
In-Reply-To: <20241023220552.74ca0c3e@rorschach.local.home>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 24 Oct 2024 10:12:25 -0700
Message-ID: <CAEf4Bzb4ywpMxchWcMfW9Lzh=re4x1zbMfz2aPRiUa29nUMB=g@mail.gmail.com>
Subject: Re: [RFC PATCH] tracing: Fix syscall tracepoint use-after-free
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Alexei Starovoitov <alexei.starovoitov@gmail.com>, Jordan Rife <jrife@google.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
	Alexei Starovoitov <ast@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Joel Fernandes <joel@joelfernandes.org>, LKML <linux-kernel@vger.kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Michael Jeanson <mjeanson@efficios.com>, 
	Namhyung Kim <namhyung@kernel.org>, "Paul E. McKenney" <paulmck@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, 
	syzbot+b390c8062d8387b6272a@syzkaller.appspotmail.com, 
	Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 23, 2024 at 7:05=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Wed, 23 Oct 2024 11:19:40 -0400
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >
> > > Looks like Mathieu patch broke bpf program contract somewhere.
> >
> > My patch series introduced this in the probe:
> >
> > #define __BPF_DECLARE_TRACE_SYSCALL(call, proto, args)                 =
 \
> > static notrace void                                                    =
 \
> > __bpf_trace_##call(void *__data, proto)                                =
 \
> > {                                                                      =
 \
> >          might_fault();                                                =
  \
> >          preempt_disable_notrace();                                    =
  \
>
> Is the problem that we can call this function *after* the prog has been
> freed? That is, the preempt_disable_notrace() here is meaningless.
>

Yes, I think so.

> Is there a way to add something here to make sure the program is still
> valid? Like set a flag in the link structure?

So I think a big assumption right now is that waiting for RCU grace
period is enough to make sure that BPF link (and thus its underlying
BPF program) are not referenced from that tracepoint anymore, and so
we can proceed with freeing the memory.

Now that some tracepoints are sleepable and are RCU Tasks Trace
protected, this assumption is wrong.

One solution might be to teach BPF raw tracepoint link to recognize
sleepable tracepoints, and then go through cal_rcu_task_trace ->
call_rcu chain instead of normal call_rcu. Similarly, for such cases
we'd need to do the same chain for underlying BPF program, even if BPF
program itself is not sleepable.

Alternatively, we'd need to add synchronize_rcu() +
synchronize_rcu_task_trace() somewhere inside
tracepoint_probe_unregister() or bpf_probe_unregister(), which is just
a thin wrapper around the former. Which would make detaching multiple
tracepoints extremely slow (just like the problem we had with kprobe
detachment before multi-kprobes were added).

The fundamental reason for this is how we do lifetime tracking between
tracepoint object and bpf_link/bpf_program. tracepoint doesn't hold a
refcount on bpf_link. It's rather that when bpf_link's last refcount
drops to zero, we go and do this:

static void bpf_raw_tp_link_release(struct bpf_link *link)
{
        struct bpf_raw_tp_link *raw_tp =3D
                container_of(link, struct bpf_raw_tp_link, link);

        bpf_probe_unregister(raw_tp->btp, raw_tp);
        bpf_put_raw_tracepoint(raw_tp->btp);
}

And the assumption is that after bpf_probe_unregister() it should be
fine to free BPF link and program after call_rcu(). So we either make
bpf_probe_unregister() synchronously wait for
synchronize_rcu[_task_trace](), or we make sure to not free link/prog
until call_rcu_tasks_trace->call_rcu.

I'd prefer the former (add call_rcu_tasks_trace for sleepable BPF raw
tracepoint link).

You guys said you have a reproducer, right? Can you please share
details (I know it's somewhere on another thread, but let's put all
this in this thread). And as Alexei asked, where are the applied
patches adding faultable tracepoints?

>
> (I don't know how BPF works well enough to know what is involved here,
> so excuse me if this is totally off)

it's not off, but I don't think we want tracepoint to hold a refcount
on bpf_link (and thus bpf_program), because that invalidates how we do
detachment.

>
> -- Steve
>
>
> >          CONCATENATE(bpf_trace_run, COUNT_ARGS(args))(__data, CAST_TO_U=
64(args));        \
> >          preempt_enable_notrace();                                     =
  \
> > }
> >


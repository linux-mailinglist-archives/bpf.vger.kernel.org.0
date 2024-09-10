Return-Path: <bpf+bounces-39410-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DD163972A6F
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 09:18:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AEE3B226FD
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 07:18:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D17D17DFE9;
	Tue, 10 Sep 2024 07:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nEz+tmG5"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 241AD17DFE0;
	Tue, 10 Sep 2024 07:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725952665; cv=none; b=MKaLMVD4tFO2x0wVAoPvY26LqPd2qErWby3C0mcAMLFaq4ZmadksiODW7gTqQY4AmqsTpY2r5oDUJ1zSUZ24BSvI2m2DO/Bf520yMVaAfN6UU+u3ebWSXtdyzsPbFsRmIuffSZHmooZcTqlkca0RsV80bPG6Cyddr+S8m39oJGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725952665; c=relaxed/simple;
	bh=XJl+vd0cq7AagBKexmrUajdv7HHUvuazYCEuJoSKXqU=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TUVG7zlnzFtqxghPUyxezWxT1oKh1LLl5vkswjeYPUXEIYhjTSGN5Z1PW3DlIcxXGeCH7QNEksfU80qL/k6U+wiYuS01yq0ocxK6yHqsfUhHTMMeCkz9sOBMrJcW2yVzzVnhAOtHcYGfHDF5ZRp/Qk+0UG84+zHy1frjNCpUwfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nEz+tmG5; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-374c1120a32so283852f8f.1;
        Tue, 10 Sep 2024 00:17:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725952662; x=1726557462; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=D+NEhNyV9yhytNfRQ8dc32ceQjxxT4HnUZWvxwKpwtQ=;
        b=nEz+tmG5On7RauNw+8B1ZpXkI6fOFImyOYhkDwHh7GOgeTxODi0wUCIGv0nA16EkCk
         6+nQgJuoI763Yhnner72ttbuYAXAhEfJJkzvsA5HwMSItKy832U/91PBVkc37/mnJznk
         2i6IghmqKnjvgjrfIIgx0nY29annWH66AiT41vp2eae48aqZn+GwgY9+US7YQazOKQod
         yChvYfO7eOs4vBYTbT3SBBoBZBBi0ruTCf/mIueKOiBjwc084P3+JWCN5mwC++4PVPmO
         PbrQXhZryKwBQC75BfROJKwRilVg2CEa63S4Dvqy3iTalfJ6zBx+HYmpAPfTFt/XTSw+
         lViQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725952662; x=1726557462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+NEhNyV9yhytNfRQ8dc32ceQjxxT4HnUZWvxwKpwtQ=;
        b=bObtOYxqkOKRvGsdTztKFep8lnqpjpAkbQw0B0PHKKUPZrmCFz/b+UA+/YuIuKjTF/
         hLcmc8w7q+wmLpjJ71N2R5MZLzLJHTnBvUd7NkOYwUT7eq2cWHEmzsSTbyJTV3TnpdkO
         IngV5OEVha7+rb2ZVVsCzsVXcFiukK4wopU+tS476IuRbq9QecYHGE/DXno4CPLvf4Wd
         Uxo3Eo8kVOcm6e4UQJoA1F1FAKJ6qESM6nReZfR6O28R8q1lpeCdZsRZ6QvCy4fVBzw1
         Bvk2kQ0EUm5rcRLirgBbca9sDyLPYDlEZkipozJ3ONBVz4TTxu2vLS3ACGT8I6MRvg2W
         9BFw==
X-Forwarded-Encrypted: i=1; AJvYcCVePkQm3ErmLnZ9gd55h0MyfBmP8e7+G1I+HQue4nDNDGSv9MfPOxYP1qpXtDk0NWkuc9s=@vger.kernel.org, AJvYcCWOKRZlfxzJ1KBs7uS9G0HhFx2G6NodD+jJYiKRx9ocuWweQIrwp9mDeyYxaeJa52FlnX8puTYTXIbDPMxx@vger.kernel.org, AJvYcCWhrcnRb8wWONzstEHNGmIPJM6z6OGOL/uqjHdMsCyqvLmNgKgNMhefx6i5PtVi0shso3aUieg3krput4RO42wLjihO@vger.kernel.org
X-Gm-Message-State: AOJu0Yzko+5a7rhFJ+0X4L1Gv1blKjC/NnBFLPB9ajPD4BN6MFiyD5Dq
	4aA1ps+5DthLrn3YwsN6sGoXOAirT3p2z+pvOKedNYOrzf08RMp5LJuqTi86znI=
X-Google-Smtp-Source: AGHT+IGTz0m3fzoYQYe1mKalnETE7virHsNqmgtUgOIKULDCqXj+j+RnIQwVGSs+vyKRVRDHNtKjVA==
X-Received: by 2002:adf:fc88:0:b0:371:8ec6:f2f0 with SMTP id ffacd0b85a97d-378895cb875mr8927435f8f.16.1725952662386;
        Tue, 10 Sep 2024 00:17:42 -0700 (PDT)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37895649bafsm8094934f8f.7.2024.09.10.00.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Sep 2024 00:17:42 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 10 Sep 2024 09:17:39 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCHv3 1/7] uprobe: Add support for session consumer
Message-ID: <Zt_yk0LZ8r8N2MZu@krava>
References: <20240909074554.2339984-1-jolsa@kernel.org>
 <20240909074554.2339984-2-jolsa@kernel.org>
 <CAEf4Bza-aJQ_qzJxnzkE07xn66TppVLO6t5ps_AOjO3eFaiQqA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza-aJQ_qzJxnzkE07xn66TppVLO6t5ps_AOjO3eFaiQqA@mail.gmail.com>

On Mon, Sep 09, 2024 at 04:44:09PM -0700, Andrii Nakryiko wrote:
> On Mon, Sep 9, 2024 at 12:46 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding support for uprobe consumer to be defined as session and have
> > new behaviour for consumer's 'handler' and 'ret_handler' callbacks.
> >
> > The session means that 'handler' and 'ret_handler' callbacks are
> > connected in a way that allows to:
> >
> >   - control execution of 'ret_handler' from 'handler' callback
> >   - share data between 'handler' and 'ret_handler' callbacks
> >
> > The session is enabled by setting new 'session' bool field to true
> > in uprobe_consumer object.
> >
> > We use return_consumer object to keep track of consumers with
> > 'ret_handler'. This object also carries the shared data between
> > 'handler' and and 'ret_handler' callbacks.
> 
> and and

ok

> 
> >
> > The control of 'ret_handler' callback execution is done via return
> > value of the 'handler' callback. This patch adds new 'ret_handler'
> > return value (2) which means to ignore ret_handler callback.
> >
> > Actions on 'handler' callback return values are now:
> >
> >   0 - execute ret_handler (if it's defined)
> >   1 - remove uprobe
> >   2 - do nothing (ignore ret_handler)
> >
> > The session concept fits to our common use case where we do filtering
> > on entry uprobe and based on the result we decide to run the return
> > uprobe (or not).
> >
> > It's also convenient to share the data between session callbacks.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> 
> Just minor things:
> 
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> 
> >  include/linux/uprobes.h                       |  17 ++-
> >  kernel/events/uprobes.c                       | 132 ++++++++++++++----
> >  kernel/trace/bpf_trace.c                      |   6 +-
> >  kernel/trace/trace_uprobe.c                   |  12 +-
> >  .../selftests/bpf/bpf_testmod/bpf_testmod.c   |   2 +-
> >  5 files changed, 133 insertions(+), 36 deletions(-)
> >
> 
> [...]
> 
> >  enum rp_check {
> > diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> > index 4b7e590dc428..9e971f86afdf 100644
> > --- a/kernel/events/uprobes.c
> > +++ b/kernel/events/uprobes.c
> > @@ -67,6 +67,8 @@ struct uprobe {
> >         loff_t                  ref_ctr_offset;
> >         unsigned long           flags;
> 
> we should shorten flags to unsigned int, we use one bit out of it
> 
> >
> > +       unsigned int            consumers_cnt;
> > +
> 
> and then this won't increase the size of the struct unnecessarily

right, makes sense

> 
> >         /*
> >          * The generic code assumes that it has two members of unknown type
> >          * owned by the arch-specific code:
> > @@ -826,8 +828,12 @@ static struct uprobe *alloc_uprobe(struct inode *inode, loff_t offset,
> >
> 
> [...]
> 
> >         current->utask->auprobe = NULL;
> >
> > -       if (need_prep && !remove)
> > -               prepare_uretprobe(uprobe, regs); /* put bp at return */
> > +       if (ri && !remove)
> > +               prepare_uretprobe(uprobe, regs, ri); /* put bp at return */
> > +       else
> > +               kfree(ri);
> 
> maybe `else if (ri) kfree(ri)` to avoid unnecessary calls to kfree
> when we only have uprobes?

there's null check in kfree, but it's true that we can skip the
whole call and there's the else condition line already, ok

> 
> >
> >         if (remove && has_consumers) {
> >                 down_read(&uprobe->register_rwsem);
> > @@ -2160,15 +2230,25 @@ static void handler_chain(struct uprobe *uprobe, struct pt_regs *regs)
> >  static void
> >  handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
> >  {
> > +       struct return_consumer *ric = NULL;
> >         struct uprobe *uprobe = ri->uprobe;
> >         struct uprobe_consumer *uc;
> > -       int srcu_idx;
> > +       int srcu_idx, iter = 0;
> 
> iter -> next_ric_idx  or just ric_idx?

sure, ric_idx seems ok to me

thanks,
jirka

> 
> >
> >         srcu_idx = srcu_read_lock(&uprobes_srcu);
> >         list_for_each_entry_srcu(uc, &uprobe->consumers, cons_node,
> >                                  srcu_read_lock_held(&uprobes_srcu)) {
> > +               /*
> > +                * If we don't find return consumer, it means uprobe consumer
> > +                * was added after we hit uprobe and return consumer did not
> > +                * get registered in which case we call the ret_handler only
> > +                * if it's not session consumer.
> > +                */
> > +               ric = return_consumer_find(ri, &iter, uc->id);
> > +               if (!ric && uc->session)
> > +                       continue;
> >                 if (uc->ret_handler)
> > -                       uc->ret_handler(uc, ri->func, regs);
> > +                       uc->ret_handler(uc, ri->func, regs, ric ? &ric->cookie : NULL);
> >         }
> >         srcu_read_unlock(&uprobes_srcu, srcu_idx);
> >  }
> 
> [...]


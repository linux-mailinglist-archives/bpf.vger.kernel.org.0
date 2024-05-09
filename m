Return-Path: <bpf+bounces-29312-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB9F58C180A
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 23:04:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80A6F282649
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1243684A50;
	Thu,  9 May 2024 21:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yk+yL7yb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE34D811E0
	for <bpf@vger.kernel.org>; Thu,  9 May 2024 21:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715288690; cv=none; b=b1npiynG4/lkarqQyUTBtYSq5ymcYY46l3drf+hzAWUv5pscmldBJiFjqk9VaOkSbHleNRA3TPDYrr4l3AtMN3/tp1t7wP5WaxkJzVGDTxzszVRQ6j/B8/kYouDznv3gR1jhWCDNglZsEj6xa0/4RNMgJJaxrE80xUmCNMMoPyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715288690; c=relaxed/simple;
	bh=C2amn8/MjN0IM4RIO4S50Amv3j2rBOJd6EWDwyLABjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KQzUCRqZJ1/oQse65Fs1eBcohLnRDdh1ARPFf/QcVsJaNGxdO8+9fDqKVFTNI5QVLrAV9z6ZYToTjlZuRLyM/iejVt8cqYMCrYZpmtcASr8jSOL6SIzmoTGW+1DF9uFTAIEr9i8QSIsdE94hRo8DcLoC7ViGohWVmOWw7DMDISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=yk+yL7yb; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-43dfe020675so109141cf.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 14:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715288688; x=1715893488; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zasTy8CP2/aUCe8GaQUqPrWEeq4iZIR2Q40eyzR1FwA=;
        b=yk+yL7ybHcGoz5oeAeJhNaTSMUUILZviIimfwuxMLi+/i0bTk1KJ16reHCoE1b38jD
         85pMfJrqO01NV9PwoWTl7+XWmYeYucKe9qgWt/fj3+s/xTahAc0lTG6vAXfsG984KgOz
         Cx9W99pfikb4CMnj5WlxkE1ZJwlJ5FtAkTGzxOjAhjnx+0pRE0icGgnmTnXav42RRfp5
         7Gtm61EoRqZ5/IuYV25nJr0vIiMpXzsgOM3ulXuic3NBrrbZleiWRALNs2WtH8Rs0dK8
         LcWOBIvoi99s+I2leNYn2umLzYlc0PNeL7FZiohaOGf94EefM2zeEGac+LJHi0ZXlmRo
         yVRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715288688; x=1715893488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zasTy8CP2/aUCe8GaQUqPrWEeq4iZIR2Q40eyzR1FwA=;
        b=e5mOKeH5mhVpVjSOKTr/uI/wQtjg5W/tGIyLDnwlm989NeJgVRTl5ZqCW13tNLxPcS
         Bu8NeFR23s2pP75pQFt7kfQxbBYcsKsQyJhAeFywvFOjPS8fkWACX8mGs/NislG+58ie
         YY+zkiJRXYRUg7l6aoY+DOia3mUMMb4CTT1eB/H88nmPfU+pbOzTXkBc4O7XeEZw+193
         MwRNBWc1I8jIsOeIJi3/4XW6jdp8xpml84+Jp0YgnCSbJqjmFDIvItkZ0L6rYV+u6Smf
         LPjPpprlyjzGMTxtKoqTLxxsDa4xJM1N+rH1aXIwihHz3zOLu5LwBkAIIg2WTY71Z++x
         kCZA==
X-Forwarded-Encrypted: i=1; AJvYcCXElKh14SxZZ4u0IwKeLWsanb2IYEDSeR7uOm4yVr3MTO/1AoPd4BYZ1C9DkjsY/UsBltC0WLmZMGVuLkqjmcVAFb7K
X-Gm-Message-State: AOJu0YwzBUK8+45M4+6jz1RnJeoDBLV6CK/3F71yurqPnE+QdEM/Oiz7
	SraS2/QxVmLbPIB+hejlirG6IaXGjSabDad9JrOcS5w+P8cnwi3L+MP0yXK33thYk93QCgSxltw
	3NrLrM9kTTwQeWKd6K7W7bhF2MgUc+AlzwHg=
X-Google-Smtp-Source: AGHT+IFqsgOT5Sqi/rvjdtFNKVETF+FGAJDzIhh0L7MAaIjIevIF3vvjDcaZTcL42uS/yzK+o79KstjQCZdjpG/x2ao=
X-Received: by 2002:a05:622a:5190:b0:43a:b8f3:f079 with SMTP id
 d75a77b69052e-43dfdd09fd1mr742981cf.20.1715288687602; Thu, 09 May 2024
 14:04:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502000602.753861-1-yabinc@google.com> <CAM9d7cj2WUdbXz1E4kQCYY=7tO+C9XXQidMJuQNp=WP6dudLkw@mail.gmail.com>
 <CAM9d7cg0vCLf+X30PnmR9wcXT9+taXKntJoeAdWae+_G6mWjvw@mail.gmail.com>
In-Reply-To: <CAM9d7cg0vCLf+X30PnmR9wcXT9+taXKntJoeAdWae+_G6mWjvw@mail.gmail.com>
From: Yabin Cui <yabinc@google.com>
Date: Thu, 9 May 2024 14:04:31 -0700
Message-ID: <CALJ9ZPPv6Yj6FrpLY9u0G_4y1Th8BzjM+eTsYJAhRViQuaSfRA@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Save raw sample data conditionally based on
 sample type
To: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for reviewing the patch! I will update a v3 patch based on the comme=
nts.


On Thu, May 9, 2024 at 12:55=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Another thought.
>
> On Thu, May 9, 2024 at 12:45=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > Hello,
> >
> > On Wed, May 1, 2024 at 5:06=E2=80=AFPM Yabin Cui <yabinc@google.com> wr=
ote:
> > >
> > > Currently, space for raw sample data is always allocated within sampl=
e
> > > records for both BPF output and tracepoint events. This leads to unus=
ed
> > > space in sample records when raw sample data is not requested.
> >
> > Oh, I thought it was ok because even if it sets _RAW bit in the
> > data->sample_flags unconditionally, perf_prepare_sample() and
> > perf_output_sample() checks the original event's attr->sample_type
> > so the raw data won't be recorded.
> >
> > But I've realized that it increased data->dyn_size already. :(
> > Which means the sample would have garbage at the end.
> >
> > I need to check if there are other places that made the same
> > mistake for other sample types.
> >
> > >
> > > This patch checks sample type of an event before saving raw sample da=
ta
> > > in both BPF output and tracepoint event handling logic. Raw sample da=
ta
> > > will only be saved if explicitly requested, reducing overhead when it
> > > is not needed.
> > >
> > > Fixes: 0a9081cf0a11 ("perf/core: Add perf_sample_save_raw_data() help=
er")
> > > Signed-off-by: Yabin Cui <yabinc@google.com>
> >
> > Acked-by: Namhyung Kim <namhyung@kernel.org>
> >
> > Thanks,
> > Namhyung
> >
> > > ---
> [SNIP]
> > > @@ -10180,13 +10181,18 @@ static void __perf_tp_event_target_task(u64=
 count, void *record,
> > >         /* Cannot deliver synchronous signal to other task. */
> > >         if (event->attr.sigtrap)
> > >                 return;
> > > -       if (perf_tp_event_match(event, data, regs))
> > > +       if (perf_tp_event_match(event, raw, regs)) {
> > > +               perf_sample_data_init(data, 0, 0);
> > > +               if (event->attr.sample_type & PERF_SAMPLE_RAW)
> > > +                       perf_sample_save_raw_data(data, raw);
>
> Hmm.. to prevent future mistakes, maybe we can move the
> check into the perf_sample_save_raw_data() itself.
>
> And it'd be great if you could do the same for callchain
> and brstack too. :)
>
> Thanks,
> Namhyung
>
>
> > >                 perf_swevent_event(event, count, data, regs);
> > > +       }
> > >  }
> > >
> > >  static void perf_tp_event_target_task(u64 count, void *record,
> > >                                       struct pt_regs *regs,
> > >                                       struct perf_sample_data *data,
> > > +                                     struct perf_raw_record *raw,
> > >                                       struct perf_event_context *ctx)
> > >  {
> > >         unsigned int cpu =3D smp_processor_id();
> > > @@ -10194,15 +10200,15 @@ static void perf_tp_event_target_task(u64 c=
ount, void *record,
> > >         struct perf_event *event, *sibling;
> > >
> > >         perf_event_groups_for_cpu_pmu(event, &ctx->pinned_groups, cpu=
, pmu) {
> > > -               __perf_tp_event_target_task(count, record, regs, data=
, event);
> > > +               __perf_tp_event_target_task(count, record, regs, data=
, raw, event);
> > >                 for_each_sibling_event(sibling, event)
> > > -                       __perf_tp_event_target_task(count, record, re=
gs, data, sibling);
> > > +                       __perf_tp_event_target_task(count, record, re=
gs, data, raw, sibling);
> > >         }
> > >
> > >         perf_event_groups_for_cpu_pmu(event, &ctx->flexible_groups, c=
pu, pmu) {
> > > -               __perf_tp_event_target_task(count, record, regs, data=
, event);
> > > +               __perf_tp_event_target_task(count, record, regs, data=
, raw, event);
> > >                 for_each_sibling_event(sibling, event)
> > > -                       __perf_tp_event_target_task(count, record, re=
gs, data, sibling);
> > > +                       __perf_tp_event_target_task(count, record, re=
gs, data, raw, sibling);
> > >         }
> > >  }
> > >
> > > @@ -10220,15 +10226,10 @@ void perf_tp_event(u16 event_type, u64 coun=
t, void *record, int entry_size,
> > >                 },
> > >         };
> > >
> > > -       perf_sample_data_init(&data, 0, 0);
> > > -       perf_sample_save_raw_data(&data, &raw);
> > > -
> > >         perf_trace_buf_update(record, event_type);
> > >
> > >         hlist_for_each_entry_rcu(event, head, hlist_entry) {
> > > -               if (perf_tp_event_match(event, &data, regs)) {
> > > -                       perf_swevent_event(event, count, &data, regs)=
;
> > > -
> > > +               if (perf_tp_event_match(event, &raw, regs)) {
> > >                         /*
> > >                          * Here use the same on-stack perf_sample_dat=
a,
> > >                          * some members in data are event-specific an=
d
> > > @@ -10238,7 +10239,9 @@ void perf_tp_event(u16 event_type, u64 count,=
 void *record, int entry_size,
> > >                          * because data->sample_flags is set.
> > >                          */
> > >                         perf_sample_data_init(&data, 0, 0);
> > > -                       perf_sample_save_raw_data(&data, &raw);
> > > +                       if (event->attr.sample_type & PERF_SAMPLE_RAW=
)
> > > +                               perf_sample_save_raw_data(&data, &raw=
);
> > > +                       perf_swevent_event(event, count, &data, regs)=
;
> > >                 }
> > >         }
> > >
> > > @@ -10255,7 +10258,7 @@ void perf_tp_event(u16 event_type, u64 count,=
 void *record, int entry_size,
> > >                         goto unlock;
> > >
> > >                 raw_spin_lock(&ctx->lock);
> > > -               perf_tp_event_target_task(count, record, regs, &data,=
 ctx);
> > > +               perf_tp_event_target_task(count, record, regs, &data,=
 &raw, ctx);
> > >                 raw_spin_unlock(&ctx->lock);
> > >  unlock:
> > >                 rcu_read_unlock();
> > > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > > index 9dc605f08a23..4b3ff71b4c0a 100644
> > > --- a/kernel/trace/bpf_trace.c
> > > +++ b/kernel/trace/bpf_trace.c
> > > @@ -620,7 +620,8 @@ static const struct bpf_func_proto bpf_perf_event=
_read_value_proto =3D {
> > >
> > >  static __always_inline u64
> > >  __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
> > > -                       u64 flags, struct perf_sample_data *sd)
> > > +                       u64 flags, struct perf_raw_record *raw,
> > > +                       struct perf_sample_data *sd)
> > >  {
> > >         struct bpf_array *array =3D container_of(map, struct bpf_arra=
y, map);
> > >         unsigned int cpu =3D smp_processor_id();
> > > @@ -645,6 +646,9 @@ __bpf_perf_event_output(struct pt_regs *regs, str=
uct bpf_map *map,
> > >         if (unlikely(event->oncpu !=3D cpu))
> > >                 return -EOPNOTSUPP;
> > >
> > > +       if (event->attr.sample_type & PERF_SAMPLE_RAW)
> > > +               perf_sample_save_raw_data(sd, raw);
> > > +
> > >         return perf_event_output(event, sd, regs);
> > >  }
> > >
> > > @@ -688,9 +692,8 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs =
*, regs, struct bpf_map *, map,
> > >         }
> > >
> > >         perf_sample_data_init(sd, 0, 0);
> > > -       perf_sample_save_raw_data(sd, &raw);
> > >
> > > -       err =3D __bpf_perf_event_output(regs, map, flags, sd);
> > > +       err =3D __bpf_perf_event_output(regs, map, flags, &raw, sd);
> > >  out:
> > >         this_cpu_dec(bpf_trace_nest_level);
> > >         preempt_enable();
> > > @@ -749,9 +752,8 @@ u64 bpf_event_output(struct bpf_map *map, u64 fla=
gs, void *meta, u64 meta_size,
> > >
> > >         perf_fetch_caller_regs(regs);
> > >         perf_sample_data_init(sd, 0, 0);
> > > -       perf_sample_save_raw_data(sd, &raw);
> > >
> > > -       ret =3D __bpf_perf_event_output(regs, map, flags, sd);
> > > +       ret =3D __bpf_perf_event_output(regs, map, flags, &raw, sd);
> > >  out:
> > >         this_cpu_dec(bpf_event_output_nest_level);
> > >         preempt_enable();
> > > --
> > > 2.45.0.rc0.197.gbae5840b3b-goog
> > >


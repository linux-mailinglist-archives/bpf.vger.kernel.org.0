Return-Path: <bpf+bounces-29229-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A4588C15A3
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 21:55:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CAB44283838
	for <lists+bpf@lfdr.de>; Thu,  9 May 2024 19:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BF9D7FBDD;
	Thu,  9 May 2024 19:55:44 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81C92907;
	Thu,  9 May 2024 19:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715284544; cv=none; b=kQ2I9OhrvYH8we45ISEIRko5o6uvBnNwYRNsLmtjHPPPmNrGo9ZM9hYwfdyKPFVWXco3dYcmQYwm0gYGlwDgDvlcY9P1AgOYEEsISSzLIzv/Yt5FBLNrvNzlbPbrgsqmr4648HkQSIrZtOyb8QQN1LU7kF5M1Z1tZify+rnbzjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715284544; c=relaxed/simple;
	bh=zbu/IGQfUBc/Eq+bOd62MWZ17jU/HCjaq7V/oU5X5d8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=os4QJe/0xyk//XFXcWjQ97nMoe36UL0S3nJF60B+/YVl9Q9RhNSKqocu+hKv5c2Ca2IM6SERLB6X2hfi7b29Epz9xlCl8Q69C3hF0iWH8YEJrI4ftBKlNPo+wpkamaqZ/3HcKXxM/dYmwuLUyCxCCHL3obd7aGcBZ7CKT7M85rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2b37731c118so1070809a91.1;
        Thu, 09 May 2024 12:55:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715284542; x=1715889342;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O/Ml7CX2KT81liQorKyRALPGhqTOeMdtMPyFG6ydCgw=;
        b=VSd0+KZzC/deghSAqirUr7t/13riAszeZPxmdRxBzJ4qOn4X4iLTTsDFI0rlosHxOy
         jr3gBOUn2cbznQYaUOB+8TyyQhdBOLuX92NCCm7F7IE2V0xQ0rIhlR9e4LakRqmd8nb2
         e0oVlHJMzM2+b8sNSf0buczGqqirFhmJ/ww5YojRjRyrenPUKZ5IQORQgqhsTiHAJlJ6
         dtUiWV61UO9BFg6Jm8WzJuVyCZDNTr/UT9T7h5RsQENzp+Z8n7E3PZ6RI5THqDuyej9Z
         IKrezniSZN5yois9ppgWL7ICXVdqMpaVey9VTV11CjNxmml4t9nyxIeUwcINT3ITVqlp
         BvgA==
X-Forwarded-Encrypted: i=1; AJvYcCV+pIsTjnYTRyiHCYTe/hzB4KIULt9oWId9MGyBX4VfvnQ95I7/HUv0gO/Omi7GD0SAYLTrr8mDs67am+bYSmAx6Ejb1qizKWcHb2oQPZ8lVVWCJnkRQMDKhYb1GwtJDyOTitEDnJJv6b2p2MtYewJq89/anQmMzN5v0cn8+gDjYGoJdQ==
X-Gm-Message-State: AOJu0YyfH3j2pWgnkkINXl+b11WvBUfiUYNxnSIauJgNIjxK3W3iAwR9
	91x1wHbAJ1L1ofUSElGhZci2OfKel9jAFnxIcgGWJDlDBRerV9U8vTDRa3X/V1RP11wolekScK5
	zxXgPGWoXMhPX6/QWIgb70ul4tnk=
X-Google-Smtp-Source: AGHT+IGQnK5k9VmctCtJUB7NtGIF2piUgInCtKQzIzp36Q/QXeaOWXRPQeFgx7BkHN2t9nR29dSOVZBvNnQzxcoaRrE=
X-Received: by 2002:a17:90a:17c4:b0:2a9:f861:223e with SMTP id
 98e67ed59e1d1-2b6cc7800edmr460740a91.29.1715284541779; Thu, 09 May 2024
 12:55:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502000602.753861-1-yabinc@google.com> <CAM9d7cj2WUdbXz1E4kQCYY=7tO+C9XXQidMJuQNp=WP6dudLkw@mail.gmail.com>
In-Reply-To: <CAM9d7cj2WUdbXz1E4kQCYY=7tO+C9XXQidMJuQNp=WP6dudLkw@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Thu, 9 May 2024 12:55:30 -0700
Message-ID: <CAM9d7cg0vCLf+X30PnmR9wcXT9+taXKntJoeAdWae+_G6mWjvw@mail.gmail.com>
Subject: Re: [PATCH v2] perf/core: Save raw sample data conditionally based on
 sample type
To: Yabin Cui <yabinc@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Alexander Shishkin <alexander.shishkin@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>, 
	Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Another thought.

On Thu, May 9, 2024 at 12:45=E2=80=AFPM Namhyung Kim <namhyung@kernel.org> =
wrote:
>
> Hello,
>
> On Wed, May 1, 2024 at 5:06=E2=80=AFPM Yabin Cui <yabinc@google.com> wrot=
e:
> >
> > Currently, space for raw sample data is always allocated within sample
> > records for both BPF output and tracepoint events. This leads to unused
> > space in sample records when raw sample data is not requested.
>
> Oh, I thought it was ok because even if it sets _RAW bit in the
> data->sample_flags unconditionally, perf_prepare_sample() and
> perf_output_sample() checks the original event's attr->sample_type
> so the raw data won't be recorded.
>
> But I've realized that it increased data->dyn_size already. :(
> Which means the sample would have garbage at the end.
>
> I need to check if there are other places that made the same
> mistake for other sample types.
>
> >
> > This patch checks sample type of an event before saving raw sample data
> > in both BPF output and tracepoint event handling logic. Raw sample data
> > will only be saved if explicitly requested, reducing overhead when it
> > is not needed.
> >
> > Fixes: 0a9081cf0a11 ("perf/core: Add perf_sample_save_raw_data() helper=
")
> > Signed-off-by: Yabin Cui <yabinc@google.com>
>
> Acked-by: Namhyung Kim <namhyung@kernel.org>
>
> Thanks,
> Namhyung
>
> > ---
[SNIP]
> > @@ -10180,13 +10181,18 @@ static void __perf_tp_event_target_task(u64 c=
ount, void *record,
> >         /* Cannot deliver synchronous signal to other task. */
> >         if (event->attr.sigtrap)
> >                 return;
> > -       if (perf_tp_event_match(event, data, regs))
> > +       if (perf_tp_event_match(event, raw, regs)) {
> > +               perf_sample_data_init(data, 0, 0);
> > +               if (event->attr.sample_type & PERF_SAMPLE_RAW)
> > +                       perf_sample_save_raw_data(data, raw);

Hmm.. to prevent future mistakes, maybe we can move the
check into the perf_sample_save_raw_data() itself.

And it'd be great if you could do the same for callchain
and brstack too. :)

Thanks,
Namhyung


> >                 perf_swevent_event(event, count, data, regs);
> > +       }
> >  }
> >
> >  static void perf_tp_event_target_task(u64 count, void *record,
> >                                       struct pt_regs *regs,
> >                                       struct perf_sample_data *data,
> > +                                     struct perf_raw_record *raw,
> >                                       struct perf_event_context *ctx)
> >  {
> >         unsigned int cpu =3D smp_processor_id();
> > @@ -10194,15 +10200,15 @@ static void perf_tp_event_target_task(u64 cou=
nt, void *record,
> >         struct perf_event *event, *sibling;
> >
> >         perf_event_groups_for_cpu_pmu(event, &ctx->pinned_groups, cpu, =
pmu) {
> > -               __perf_tp_event_target_task(count, record, regs, data, =
event);
> > +               __perf_tp_event_target_task(count, record, regs, data, =
raw, event);
> >                 for_each_sibling_event(sibling, event)
> > -                       __perf_tp_event_target_task(count, record, regs=
, data, sibling);
> > +                       __perf_tp_event_target_task(count, record, regs=
, data, raw, sibling);
> >         }
> >
> >         perf_event_groups_for_cpu_pmu(event, &ctx->flexible_groups, cpu=
, pmu) {
> > -               __perf_tp_event_target_task(count, record, regs, data, =
event);
> > +               __perf_tp_event_target_task(count, record, regs, data, =
raw, event);
> >                 for_each_sibling_event(sibling, event)
> > -                       __perf_tp_event_target_task(count, record, regs=
, data, sibling);
> > +                       __perf_tp_event_target_task(count, record, regs=
, data, raw, sibling);
> >         }
> >  }
> >
> > @@ -10220,15 +10226,10 @@ void perf_tp_event(u16 event_type, u64 count,=
 void *record, int entry_size,
> >                 },
> >         };
> >
> > -       perf_sample_data_init(&data, 0, 0);
> > -       perf_sample_save_raw_data(&data, &raw);
> > -
> >         perf_trace_buf_update(record, event_type);
> >
> >         hlist_for_each_entry_rcu(event, head, hlist_entry) {
> > -               if (perf_tp_event_match(event, &data, regs)) {
> > -                       perf_swevent_event(event, count, &data, regs);
> > -
> > +               if (perf_tp_event_match(event, &raw, regs)) {
> >                         /*
> >                          * Here use the same on-stack perf_sample_data,
> >                          * some members in data are event-specific and
> > @@ -10238,7 +10239,9 @@ void perf_tp_event(u16 event_type, u64 count, v=
oid *record, int entry_size,
> >                          * because data->sample_flags is set.
> >                          */
> >                         perf_sample_data_init(&data, 0, 0);
> > -                       perf_sample_save_raw_data(&data, &raw);
> > +                       if (event->attr.sample_type & PERF_SAMPLE_RAW)
> > +                               perf_sample_save_raw_data(&data, &raw);
> > +                       perf_swevent_event(event, count, &data, regs);
> >                 }
> >         }
> >
> > @@ -10255,7 +10258,7 @@ void perf_tp_event(u16 event_type, u64 count, v=
oid *record, int entry_size,
> >                         goto unlock;
> >
> >                 raw_spin_lock(&ctx->lock);
> > -               perf_tp_event_target_task(count, record, regs, &data, c=
tx);
> > +               perf_tp_event_target_task(count, record, regs, &data, &=
raw, ctx);
> >                 raw_spin_unlock(&ctx->lock);
> >  unlock:
> >                 rcu_read_unlock();
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 9dc605f08a23..4b3ff71b4c0a 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -620,7 +620,8 @@ static const struct bpf_func_proto bpf_perf_event_r=
ead_value_proto =3D {
> >
> >  static __always_inline u64
> >  __bpf_perf_event_output(struct pt_regs *regs, struct bpf_map *map,
> > -                       u64 flags, struct perf_sample_data *sd)
> > +                       u64 flags, struct perf_raw_record *raw,
> > +                       struct perf_sample_data *sd)
> >  {
> >         struct bpf_array *array =3D container_of(map, struct bpf_array,=
 map);
> >         unsigned int cpu =3D smp_processor_id();
> > @@ -645,6 +646,9 @@ __bpf_perf_event_output(struct pt_regs *regs, struc=
t bpf_map *map,
> >         if (unlikely(event->oncpu !=3D cpu))
> >                 return -EOPNOTSUPP;
> >
> > +       if (event->attr.sample_type & PERF_SAMPLE_RAW)
> > +               perf_sample_save_raw_data(sd, raw);
> > +
> >         return perf_event_output(event, sd, regs);
> >  }
> >
> > @@ -688,9 +692,8 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *,=
 regs, struct bpf_map *, map,
> >         }
> >
> >         perf_sample_data_init(sd, 0, 0);
> > -       perf_sample_save_raw_data(sd, &raw);
> >
> > -       err =3D __bpf_perf_event_output(regs, map, flags, sd);
> > +       err =3D __bpf_perf_event_output(regs, map, flags, &raw, sd);
> >  out:
> >         this_cpu_dec(bpf_trace_nest_level);
> >         preempt_enable();
> > @@ -749,9 +752,8 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags=
, void *meta, u64 meta_size,
> >
> >         perf_fetch_caller_regs(regs);
> >         perf_sample_data_init(sd, 0, 0);
> > -       perf_sample_save_raw_data(sd, &raw);
> >
> > -       ret =3D __bpf_perf_event_output(regs, map, flags, sd);
> > +       ret =3D __bpf_perf_event_output(regs, map, flags, &raw, sd);
> >  out:
> >         this_cpu_dec(bpf_event_output_nest_level);
> >         preempt_enable();
> > --
> > 2.45.0.rc0.197.gbae5840b3b-goog
> >


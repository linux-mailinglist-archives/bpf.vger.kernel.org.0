Return-Path: <bpf+bounces-69832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D7CA8BA3671
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 12:54:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02BD71C201FB
	for <lists+bpf@lfdr.de>; Fri, 26 Sep 2025 10:54:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D672F4A08;
	Fri, 26 Sep 2025 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IW8rqNH/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004A12BF01E
	for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 10:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758884060; cv=none; b=gWrATmpHS+rYPuwZIXn6jpf7hj/sWUwnMqx8p+y1zG2VslG3luh6NmMNkiOeg9a81covPhNN3jASTCr3NwFvN6waPEsMcxn3FrmlU7oqbRLJwzA8J3EoYNCEMJvkRVRI9FagB3BkMbAz2I4PPkycjyOZa55S1FGr49vhvMMl8EM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758884060; c=relaxed/simple;
	bh=ZqJ9gWc509cwsHWwJkNg4NON23HFhjy8X0SEdcYZJdQ=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ns5KqpWKl2dWG8dGdgDvrpi4pameZ5SPOUMt16PB6XYciqpMIGawW1pzqr92Km7K6ZWoUuTmQj+1u3VZVCayWe0f+Y4EgNrJgkCcuxanDh84agZ145gykJ8JO4qAHK0nbvRyXf5BzSNF4UJy65A1kkAYYT6ncc/PHNrBW4zMyEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IW8rqNH/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3f2ae6fae12so1068860f8f.1
        for <bpf@vger.kernel.org>; Fri, 26 Sep 2025 03:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758884057; x=1759488857; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UJQS+YYB0NzVkBYe1TuZ4CgN8KO3C/Ns6qyjEQZVUms=;
        b=IW8rqNH/1yhFb0gGVJYACjrM3qwnw0O+mRjnnsVnKBetIp5s6F2n6ZCB1kKwEKC+pw
         B950MYusjWienDRj8noQHTW+KaEsATmsD8kwRMbpMkri9FO6+z65yzWqMXqYNPC2wOTO
         woX3TAsMdqQrvI+ttoPzdL4XEXm9mJ42NWRL4hN71FinoDbcyoSSq/ztclaLLCprBzGn
         zij4vvNdldsYoX3IiJBDpEeH3zSaZSN3sVPYaejYXIvYGRwrYy1DvQmLro/L8Zlft1IG
         aYJsnd9KwjyJ6PSPitlEvJHxCqaIcQd2Gn4gF5WJpyADihnNRqpRrfI3yvfnrMo/Abv+
         yo4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758884057; x=1759488857;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UJQS+YYB0NzVkBYe1TuZ4CgN8KO3C/Ns6qyjEQZVUms=;
        b=t/1Oqr53uY0vxUq9mk9+vPVWAjikgQ//wrmcEqutyaZEwqKNy6ELqRAT+zSeNqa1qx
         td9O7UrEJ34EH2Otpq91nAP5xyrMzm76mxv9r5lSTIepBhWyuSG9d+uXcM+ZZuZbs6Lv
         lrwtO8m41gNHtMu6HG2GMLp9V2kGjEAdjHlUZZ10Lga9SkUKHwX4dH+IQIQ4J4xoZ2A7
         Q/p0Rx9k5IDMUAQZzUI8dqt1MHYPQLeAzuSDLmlv9AK0JvuplRKSz8zWqnbDOCLlgaD/
         NwcF5YqqhaWuOHFJB+bi4w79nrOoMBtlXYZ4Wuz/mx7RhFhxDCtyxY0zv3qyJcRqi/PX
         PpMA==
X-Forwarded-Encrypted: i=1; AJvYcCVjbhFGFHSHLQvFVo/D+2TyHQJyvnM0GJtiB7YFqfc0Y3nZcPkYJ0Z/dgJ0F/l9fQTpyno=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzm5S6vetsoa17JvD2t+hLFyYLY+RW7lX3WDT9lHleKFkV7jeCd
	N/MfXDjuCt60GsFYv9hw2f4XATXTtLsjFWDWQt+dCboPCvp5V28wMmDP
X-Gm-Gg: ASbGncsoew4WaV7Bs5lSetfIbdmvMu1lnEYZxIyENjFXFv3EFqvDgHip/lHuKMFB4yI
	0z7rn9UJ9MB8na1e7GoZXNvEG2Q63aizJEJFEAR3F+K3WJYS1v8JhgbrZsXJWG/LnP04jFUIb5m
	ccGQLnoEeeb/d3vjQyS5yJ1KHwSeDxpoOGCeSCzWvEwHA+3OGhKh0qPHH/3hluk1hu3RK039rpW
	iiHXv92ZwbkZMFa0aGbuJxzOoLphKvHUdZIePHOHBSwPCcU8M9AqKEvtGkmIxS4j+xFOzQVyK7j
	WY2ZsMRzTp1BLukBMtCDM2CK+j7tdWKxjaothGldtdtm9wzSDIeha8F6FPGcnFlS1RVo3KOw51K
	eIlnHbRs=
X-Google-Smtp-Source: AGHT+IGNiZG0zTs7QJIGVAfP9xqyiBKqMoVnPCEQ/mevzBFGRcZCQruWumPhglYyA6JRq8GUffO6ow==
X-Received: by 2002:a05:6000:178b:b0:3b7:9c79:32bb with SMTP id ffacd0b85a97d-40e4ff1991bmr6941603f8f.44.1758884057002;
        Fri, 26 Sep 2025 03:54:17 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::31e0])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-40fb72face8sm6615912f8f.5.2025.09.26.03.54.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 03:54:16 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 26 Sep 2025 12:54:15 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Feng Yang <yangfeng59949@163.com>, bpf@vger.kernel.org,
	linux-perf-users@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Hao Luo <haoluo@google.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: Add stacktrace test for kprobe
 multi
Message-ID: <aNZw13CJARm5EZGB@krava>
References: <20250925115145.1916664-1-jolsa@kernel.org>
 <CAEf4BzYPkuD0SnfhjwWU3X_HaRGk-gSVqe_-AxYe7P5kfAZ9Vw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4BzYPkuD0SnfhjwWU3X_HaRGk-gSVqe_-AxYe7P5kfAZ9Vw@mail.gmail.com>

On Thu, Sep 25, 2025 at 04:26:08PM -0700, Andrii Nakryiko wrote:
> On Thu, Sep 25, 2025 at 4:51 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding stacktrace test for kprobe multi probe.
> >
> > Cc: Feng Yang <yangfeng59949@163.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> > test for arm64 fix posted separately in here:
> >   https://lore.kernel.org/bpf/20250925020822.119302-1-yangfeng59949@163.com/
> >
> >  .../selftests/bpf/prog_tests/stacktrace_map.c | 107 +++++++++++++-----
> >  .../selftests/bpf/progs/test_stacktrace_map.c |  28 ++++-
> >  2 files changed, 106 insertions(+), 29 deletions(-)
> >
> > diff --git a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> > index 84a7e405e912..922224adc86b 100644
> > --- a/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> > +++ b/tools/testing/selftests/bpf/prog_tests/stacktrace_map.c
> > @@ -1,13 +1,44 @@
> >  // SPDX-License-Identifier: GPL-2.0
> >  #include <test_progs.h>
> > +#include "test_stacktrace_map.skel.h"
> >
> 
> Tao just refactored this to skeleton, so please rebase and adjust accordingly

ok

> 
> pw-bot: cr
> 
> 
> > -void test_stacktrace_map(void)
> > +static void check_stackmap(int control_map_fd, int stackid_hmap_fd,
> > +                          int stackmap_fd, int stack_amap_fd)
> > +{
> > +       __u32 key, val, duration = 0;
> > +       int err, stack_trace_len;
> > +
> > +       /* disable stack trace collection */
> > +       key = 0;
> > +       val = 1;
> > +       bpf_map_update_elem(control_map_fd, &key, &val, 0);
> > +
> > +       /* for every element in stackid_hmap, we can find a corresponding one
> > +        * in stackmap, and vice versa.
> > +        */
> > +       err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
> > +       if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
> > +                 "err %d errno %d\n", err, errno))
> > +               return;
> > +
> > +       err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
> > +       if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
> > +                 "err %d errno %d\n", err, errno))
> > +               return;
> > +
> > +       stack_trace_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
> > +       err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
> > +       CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
> > +               "err %d errno %d\n", err, errno);
> > +}
> > +
> > +static void test_stacktrace_map_tp(void)
> >  {
> >         int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> >         const char *prog_name = "oncpu";
> > -       int err, prog_fd, stack_trace_len;
> > +       int err, prog_fd;
> >         const char *file = "./test_stacktrace_map.bpf.o";
> > -       __u32 key, val, duration = 0;
> > +       __u32 duration = 0;
> >         struct bpf_program *prog;
> >         struct bpf_object *obj;
> >         struct bpf_link *link;
> > @@ -44,32 +75,56 @@ void test_stacktrace_map(void)
> >         /* give some time for bpf program run */
> >         sleep(1);
> >
> > -       /* disable stack trace collection */
> > -       key = 0;
> > -       val = 1;
> > -       bpf_map_update_elem(control_map_fd, &key, &val, 0);
> > -
> > -       /* for every element in stackid_hmap, we can find a corresponding one
> > -        * in stackmap, and vice versa.
> > -        */
> > -       err = compare_map_keys(stackid_hmap_fd, stackmap_fd);
> > -       if (CHECK(err, "compare_map_keys stackid_hmap vs. stackmap",
> > -                 "err %d errno %d\n", err, errno))
> > -               goto disable_pmu;
> > -
> > -       err = compare_map_keys(stackmap_fd, stackid_hmap_fd);
> > -       if (CHECK(err, "compare_map_keys stackmap vs. stackid_hmap",
> > -                 "err %d errno %d\n", err, errno))
> > -               goto disable_pmu;
> > -
> > -       stack_trace_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
> > -       err = compare_stack_ips(stackmap_fd, stack_amap_fd, stack_trace_len);
> > -       if (CHECK(err, "compare_stack_ips stackmap vs. stack_amap",
> > -                 "err %d errno %d\n", err, errno))
> > -               goto disable_pmu;
> > +       check_stackmap(control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd);
> >
> >  disable_pmu:
> >         bpf_link__destroy(link);
> >  close_prog:
> >         bpf_object__close(obj);
> >  }
> > +
> > +static void test_stacktrace_map_kprobe_multi(bool retprobe)
> > +{
> > +       int control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd;
> > +       LIBBPF_OPTS(bpf_kprobe_multi_opts, opts,
> > +               .retprobe = retprobe
> > +       );
> > +       LIBBPF_OPTS(bpf_test_run_opts, topts);
> > +       struct test_stacktrace_map *skel;
> > +       struct bpf_link *link;
> > +       int prog_fd, err;
> > +
> > +       skel = test_stacktrace_map__open_and_load();
> > +       if (!ASSERT_OK_PTR(skel, "test_stacktrace_map__open_and_load"))
> > +               return;
> > +
> > +       link = bpf_program__attach_kprobe_multi_opts(skel->progs.kprobe,
> > +                                                    "bpf_fentry_test1", &opts);
> > +       if (!ASSERT_OK_PTR(link, "bpf_program__attach_kprobe_multi_opts"))
> > +               goto cleanup;
> > +
> > +       prog_fd = bpf_program__fd(skel->progs.trigger);
> > +       err = bpf_prog_test_run_opts(prog_fd, &topts);
> > +       ASSERT_OK(err, "test_run");
> > +       ASSERT_EQ(topts.retval, 0, "test_run");
> > +
> > +       control_map_fd  = bpf_map__fd(skel->maps.control_map);
> > +       stackid_hmap_fd = bpf_map__fd(skel->maps.stackid_hmap);
> > +       stackmap_fd     = bpf_map__fd(skel->maps.stackmap);
> > +       stack_amap_fd   = bpf_map__fd(skel->maps.stack_amap);
> > +
> > +       check_stackmap(control_map_fd, stackid_hmap_fd, stackmap_fd, stack_amap_fd);
> > +
> > +cleanup:
> > +       test_stacktrace_map__destroy(skel);
> > +}
> > +
> > +void test_stacktrace_map(void)
> > +{
> > +       if (test__start_subtest("tp"))
> > +               test_stacktrace_map_tp();
> > +       if (test__start_subtest("kprobe_multi"))
> > +               test_stacktrace_map_kprobe_multi(false);
> > +       if (test__start_subtest("kretprobe_multi"))
> > +               test_stacktrace_map_kprobe_multi(true);
> > +}
> > diff --git a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> > index 47568007b668..7a27e162a407 100644
> > --- a/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> > +++ b/tools/testing/selftests/bpf/progs/test_stacktrace_map.c
> > @@ -3,6 +3,7 @@
> >
> >  #include <vmlinux.h>
> >  #include <bpf/bpf_helpers.h>
> > +#include <bpf/bpf_tracing.h>
> >
> >  #ifndef PERF_MAX_STACK_DEPTH
> >  #define PERF_MAX_STACK_DEPTH         127
> > @@ -50,8 +51,7 @@ struct sched_switch_args {
> >         int next_prio;
> >  };
> >
> > -SEC("tracepoint/sched/sched_switch")
> > -int oncpu(struct sched_switch_args *ctx)
> > +static inline void test_stackmap(void *ctx)
> >  {
> >         __u32 max_len = PERF_MAX_STACK_DEPTH * sizeof(__u64);
> >         __u32 key = 0, val = 0, *value_p;
> > @@ -59,7 +59,7 @@ int oncpu(struct sched_switch_args *ctx)
> >
> >         value_p = bpf_map_lookup_elem(&control_map, &key);
> >         if (value_p && *value_p)
> > -               return 0; /* skip if non-zero *value_p */
> > +               return; /* skip if non-zero *value_p */
> >
> >         /* The size of stackmap and stackid_hmap should be the same */
> >         key = bpf_get_stackid(ctx, &stackmap, 0);
> > @@ -69,7 +69,29 @@ int oncpu(struct sched_switch_args *ctx)
> >                 if (stack_p)
> >                         bpf_get_stack(ctx, stack_p, max_len, 0);
> >         }
> > +}
> > +
> > +SEC("tracepoint/sched/sched_switch")
> > +int oncpu(struct sched_switch_args *ctx)
> > +{
> > +       test_stackmap(ctx);
> > +       return 0;
> > +}
> >
> > +/*
> > + * No tests in here, just to trigger 'bpf_fentry_test*'
> > + * through tracing test_run.
> > + */
> > +SEC("fentry/bpf_modify_return_test")
> > +int BPF_PROG(trigger)
> > +{
> > +       return 0;
> > +}
> > +
> > +SEC("kprobe.multi")
> > +int kprobe(struct pt_regs *ctx)
> > +{
> > +       test_stackmap(ctx);
> >         return 0;
> >  }
> >
> 
> Can you please expland the set of program types you are testing:
> kprobe/kretprobe, kprobe.multi/kretprobe.multi, fentry/fexit/fmod_ret,
> maybe even uprobe/uretprobe?

right, will add those

> 
> Also, for check_stack_ips(), can we make sure that we look for
> expected >1 IPs there? We had (still have?) issues where we'd get
> (successfully) stack trace with just single (but valid!) entry
> corresponding to traced function, but nothing beyond that. Which
> clearly is broken. So it would be good to be able to detect this going
> forward.

ok

thanks,
jirka


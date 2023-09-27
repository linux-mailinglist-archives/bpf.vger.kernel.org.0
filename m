Return-Path: <bpf+bounces-10910-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 375167AF78A
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 02:50:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 6D24D282095
	for <lists+bpf@lfdr.de>; Wed, 27 Sep 2023 00:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3992515C9;
	Wed, 27 Sep 2023 00:50:45 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38864EA8;
	Wed, 27 Sep 2023 00:50:43 +0000 (UTC)
Received: from mail-io1-f53.google.com (mail-io1-f53.google.com [209.85.166.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658D13C21;
	Tue, 26 Sep 2023 17:50:41 -0700 (PDT)
Received: by mail-io1-f53.google.com with SMTP id ca18e2360f4ac-79f989480e0so314028139f.3;
        Tue, 26 Sep 2023 17:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695775840; x=1696380640;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=49VLLRdtyvTR9zrUZJfnDfe9+Yw6E25El1lehQytcPs=;
        b=mM77ZXb39cItcCMSR6Vg7Yska+rnHCXT8ffib6LbemqdyTUEFR96NbIhNjAjJSoD0f
         nMmnxjz0uMzD3GL675fYRPekQwRqWaEc8XULgTWV/09XyrDjYOGdZwRCZvNCa4LFBCXY
         31b9p3S3eUhpAYaK1Ke+cw6hBCtE+ZzDlQO1bbcjyXgvifmluK0FdV86xE/jXXMO17sT
         gz5W6cbAi2tOwy9nvgefLIV1Hlt4lZoOc+BHtDzNMRF9/d1c3acNk+xOAMmH5836NLXa
         VKke8Unq5H6xfyi5JKEHMf6GPx7zTj7o8bT92Yz3IdrZ36KSLz3qoEgkmBkIDfTJ+EUu
         Hpyg==
X-Gm-Message-State: AOJu0YzCI7mC4IfjvxGxd/DTW4vljDoa+o2RFpV7UB7meHTpQdBui3C/
	QvZ9fQMPhR/CI5RT38DkcFVNtcUatz1YwA6aMuo=
X-Google-Smtp-Source: AGHT+IHfqddDhz0mWHuZuybn15arEe1k1jWr2QNcgQQvttagjCshwasBMO6deSBz8icSk4kdZ667J4Lr+E8uYwj9LoA=
X-Received: by 2002:a6b:6806:0:b0:79f:b6b3:9dde with SMTP id
 d6-20020a6b6806000000b0079fb6b39ddemr481066ioc.9.1695775840642; Tue, 26 Sep
 2023 17:50:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230922234444.3115821-1-namhyung@kernel.org> <CAP-5=fVMdX+vLPNBSe-8arKGvAGcdgHGt7ypEX-J-SZpUi2PGg@mail.gmail.com>
In-Reply-To: <CAP-5=fVMdX+vLPNBSe-8arKGvAGcdgHGt7ypEX-J-SZpUi2PGg@mail.gmail.com>
From: Namhyung Kim <namhyung@kernel.org>
Date: Tue, 26 Sep 2023 17:50:29 -0700
Message-ID: <CAM9d7cg0ZoGHJ1hMBFviEg4hSmx0V8nBZyTAP+hkiDzEQUZAKw@mail.gmail.com>
Subject: Re: [PATCH] perf record: Fix BTF type checks in the off-cpu profiling
To: Ian Rogers <irogers@google.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, Peter Zijlstra <peterz@infradead.org>, 
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>, 
	linux-perf-users@vger.kernel.org, Song Liu <song@kernel.org>, 
	Hao Luo <haoluo@google.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi Ian,

On Sun, Sep 24, 2023 at 11:03=E2=80=AFAM Ian Rogers <irogers@google.com> wr=
ote:
>
> On Fri, Sep 22, 2023 at 4:44=E2=80=AFPM Namhyung Kim <namhyung@kernel.org=
> wrote:
> >
> > The BTF func proto for a tracepoint has one more argument than the
> > actual tracepoint function since it has a context argument at the
> > begining.  So it should compare to 5 when the tracepoint has 4
> > arguments.
> >
> >   typedef void (*btf_trace_sched_switch)(void *, bool, struct task_stru=
ct *, struct task_struct *, unsigned int);
> >
> > Also, recent change in the perf tool would use a hand-written minimal
> > vmlinux.h to generate BTF in the skeleton.  So it won't have the info
> > of the tracepoint.  Anyway it should use the kernel's vmlinux BTF to
> > check the type in the kernel.
> >
> > Fixes: b36888f71c85 ("perf record: Handle argument change in sched_swit=
ch")
> > Cc: Song Liu <song@kernel.org>
> > Cc: Hao Luo <haoluo@google.com>
> > CC: bpf@vger.kernel.org
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks for the review!

>
> > ---
> >  tools/perf/util/bpf_off_cpu.c | 5 +++--
> >  1 file changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/bpf_off_cpu.c b/tools/perf/util/bpf_off_cp=
u.c
> > index 01f70b8e705a..21f4d9ba023d 100644
> > --- a/tools/perf/util/bpf_off_cpu.c
> > +++ b/tools/perf/util/bpf_off_cpu.c
> > @@ -98,7 +98,7 @@ static void off_cpu_finish(void *arg __maybe_unused)
> >  /* v5.18 kernel added prev_state arg, so it needs to check the signatu=
re */
> >  static void check_sched_switch_args(void)
> >  {
> > -       const struct btf *btf =3D bpf_object__btf(skel->obj);
> > +       const struct btf *btf =3D btf__load_vmlinux_btf();
> >         const struct btf_type *t1, *t2, *t3;
> >         u32 type_id;
> >
> > @@ -116,7 +116,8 @@ static void check_sched_switch_args(void)
> >                 return;
> >
> >         t3 =3D btf__type_by_id(btf, t2->type);
> > -       if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) =3D=3D 4) {
> > +       /* btf_trace func proto has one more argument for the context *=
/
> > +       if (t3 && btf_is_func_proto(t3) && btf_vlen(t3) =3D=3D 5) {
> >                 /* new format: pass prev_state as 4th arg */
>
> nit: does this comment need updating?

No, it's the 4th arg and the sched_switch is called like.

        trace_sched_switch(sched_mode & SM_MASK_PREEMPT, prev, next,
prev_state);

Thanks,
Namhyung


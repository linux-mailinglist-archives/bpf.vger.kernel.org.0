Return-Path: <bpf+bounces-4061-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E51374866E
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 16:34:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D2AC1C20B79
	for <lists+bpf@lfdr.de>; Wed,  5 Jul 2023 14:34:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A876FC6;
	Wed,  5 Jul 2023 14:34:14 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8181C3233
	for <bpf@vger.kernel.org>; Wed,  5 Jul 2023 14:34:14 +0000 (UTC)
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B9C12A;
	Wed,  5 Jul 2023 07:34:13 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id 6a1803df08f44-635dd1b52a2so43929846d6.3;
        Wed, 05 Jul 2023 07:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688567652; x=1691159652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZDeKMKFJALokCROCQuqvEHo8pC4cIA2g+6O+FK4XHZk=;
        b=TzacOxCkL+Gdw+wJd7YoFfWv/kZHiWrp2q6GyrloLwe/ogbbzjMo55xfh3wCumNNxr
         dHgxzy1uKQvzdMKj86tXEWi4AR008XNLByQemW2wCsTyO4AolqUCGXE2Fro/Lc+BJqDj
         H6vozzmv3iCtPp1ux/xlmYYWgY0wPUps8xliUorl4fiOrcq+3WrqmgBh2OoE5iW7FpBr
         HDUrMcAN5cUKQkvEXxvpA0M8SmYOH9B6E8gpVsbYTahnQzeSMacQDP19RvKh//NrSQsB
         qURxuV8IX/5lZXHvuZuypJNjg3ukgl0xSFKBI44GJS4kKj+zCSYA6uHSJj5z7aCm0slg
         F1hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688567652; x=1691159652;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZDeKMKFJALokCROCQuqvEHo8pC4cIA2g+6O+FK4XHZk=;
        b=fO7DXoKQ7aoC/hd5rqS31hOVXZXVXJtqRD+EhvwD3XKLydXDmWVUOGTkCSXfXIyQbD
         UEqBvbCelYxhC4g0Jyy43q+C5rv/he360CnulwDTY+qnPbSWkAQg5CQEsLsgYAcIAuz7
         jgEzE9b2zSi3Ll6/QVL78mOQYPA7XZ1P3CIWauZ5KBQMFBfXOlYubONVaPvn4qnZ4FvS
         rGAgBb+81gWmDxsNPlCtVAxLrwaYLsTqWGgD7eTSblRx/xFBceetJsG1rK7jpjcKi8tu
         D7zZPaF2MidFXR5er+2aeCIkT68LIdbTQ/WwjnpOK8V1Fv56twEGLJKvmSBpOwE6wVeE
         6Orw==
X-Gm-Message-State: ABy/qLbsM5DWBIEogwy50QAD8eh8F3t8sZJIiFs0tm6M9EnI84DbC90Z
	ULtwND0//X1bhXikhA3RMU08CPHASqN7eJotnHs=
X-Google-Smtp-Source: APBJJlHLkb8lKKq0KfdKvlkkaH6RCMWT4ux66g7837Ku5Qf1li6dqX7vnKph42bWwHNGmEzbJevYJQnNHlctH+Gario=
X-Received: by 2002:a0c:9c49:0:b0:625:b3a2:f637 with SMTP id
 w9-20020a0c9c49000000b00625b3a2f637mr2228886qve.8.1688567652206; Wed, 05 Jul
 2023 07:34:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230628115329.248450-1-laoar.shao@gmail.com> <20230628115329.248450-6-laoar.shao@gmail.com>
 <5ed6bc64-ab80-486b-fb13-207174d9ff2d@iogearbox.net>
In-Reply-To: <5ed6bc64-ab80-486b-fb13-207174d9ff2d@iogearbox.net>
From: Yafang Shao <laoar.shao@gmail.com>
Date: Wed, 5 Jul 2023 22:33:36 +0800
Message-ID: <CALOAHbA_cu7Jn=3YyqHLYi8OX=CU5txRHWs3aZo1BHQGjtJ5ow@mail.gmail.com>
Subject: Re: [PATCH v6 bpf-next 05/11] bpf: Clear the probe_addr for uprobe
To: Daniel Borkmann <daniel@iogearbox.net>
Cc: ast@kernel.org, john.fastabend@gmail.com, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, kpsingh@kernel.org, 
	sdf@google.com, haoluo@google.com, jolsa@kernel.org, quentin@isovalent.com, 
	rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Wed, Jul 5, 2023 at 4:19=E2=80=AFPM Daniel Borkmann <daniel@iogearbox.ne=
t> wrote:
>
> On 6/28/23 1:53 PM, Yafang Shao wrote:
> > To avoid returning uninitialized or random values when querying the fil=
e
> > descriptor (fd) and accessing probe_addr, it is necessary to clear the
> > variable prior to its use.
> >
> > Fixes: 41bdc4b40ed6 ("bpf: introduce bpf subcommand BPF_TASK_FD_QUERY")
> > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > Acked-by: Yonghong Song <yhs@fb.com>
> > ---
> >   kernel/trace/bpf_trace.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> > index 1f9f78e1992f..ac9958907a7c 100644
> > --- a/kernel/trace/bpf_trace.c
> > +++ b/kernel/trace/bpf_trace.c
> > @@ -2382,10 +2382,12 @@ int bpf_get_perf_event_info(const struct perf_e=
vent *event, u32 *prog_id,
> >                                                 event->attr.type =3D=3D=
 PERF_TYPE_TRACEPOINT);
> >   #endif
> >   #ifdef CONFIG_UPROBE_EVENTS
> > -             if (flags & TRACE_EVENT_FL_UPROBE)
> > +             if (flags & TRACE_EVENT_FL_UPROBE) {
> >                       err =3D bpf_get_uprobe_info(event, fd_type, buf,
> >                                                 probe_offset,
> >                                                 event->attr.type =3D=3D=
 PERF_TYPE_TRACEPOINT);
> > +                     *probe_addr =3D 0x0;
> > +             }
>
> Could we make this a bit more robust by just moving the zero'ing into the=
 common path?

After a second thought, I prefer to clear it in bpf_get_uprobe_info().
That way we can avoid setting them twice for kprobe.

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 8b92e34..015dbf2 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1432,6 +1432,7 @@ int bpf_get_uprobe_info(const struct perf_event
*event, u32 *fd_type,
                                    : BPF_FD_TYPE_UPROBE;
        *filename =3D tu->filename;
        *probe_offset =3D tu->offset;
+       *probe_addr =3D 0;
        return 0;
 }
 #endif /* CONFIG_PERF_EVENTS */


>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 03b7f6b8e4f0..795e16d5d2f7 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -2362,6 +2362,9 @@ int bpf_get_perf_event_info(const struct perf_event=
 *event, u32 *prog_id,
>                  return -EOPNOTSUPP;
>
>          *prog_id =3D prog->aux->id;
> +       *probe_offset =3D 0x0;
> +       *probe_addr =3D 0x0;
> +
>          flags =3D event->tp_event->flags;
>          is_tracepoint =3D flags & TRACE_EVENT_FL_TRACEPOINT;
>          is_syscall_tp =3D is_syscall_trace_event(event->tp_event);
> @@ -2370,8 +2373,6 @@ int bpf_get_perf_event_info(const struct perf_event=
 *event, u32 *prog_id,
>                  *buf =3D is_tracepoint ? event->tp_event->tp->name
>                                       : event->tp_event->name;
>                  *fd_type =3D BPF_FD_TYPE_TRACEPOINT;
> -               *probe_offset =3D 0x0;
> -               *probe_addr =3D 0x0;
>          } else {
>                  /* kprobe/uprobe */
>                  err =3D -EOPNOTSUPP;



--=20
Regards
Yafang


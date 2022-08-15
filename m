Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C492259274D
	for <lists+bpf@lfdr.de>; Mon, 15 Aug 2022 03:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbiHOBBv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 14 Aug 2022 21:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiHOBBv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 14 Aug 2022 21:01:51 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CF06340
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 18:01:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gk3so11174826ejb.8
        for <bpf@vger.kernel.org>; Sun, 14 Aug 2022 18:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=sEy1ayDT6LAS5t84Be7F57qDHykKyjM4RTLH5eJOS14=;
        b=Q5Gst2qBQnHPjJuzpndtFaKUztXASV3ti/0llEkLzaZIVqQtJFSSC8/YUEzYKD15MU
         yZaDQZbUpNHauKsLtFmu31jvdAhfAPJR1TgizZydHgOaJ0HBLOfSE9v8jUuC1Fqk5mSu
         dZlgmtU2NcbUOMHPV2hgqMSGhKH2t0opHqno2qirDJiSc4PASFIwR0l1PFoodZGgAVcX
         LgkoxjDVWxYo51sdnc6SVoIHEpS38u+nEZ7bU6TEGB1PnTXBvSAA5pCu5Ugf5K+OPrZY
         NoBLfRf9ea8rL76G7LCoyNfsvx0MLYuIFU1EnyTpVpuxlwLMfDwx26c1uGTbI19NQfJ1
         +A5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=sEy1ayDT6LAS5t84Be7F57qDHykKyjM4RTLH5eJOS14=;
        b=4p6WnUJfHTIc6f4b3h/aJQ1CJSXdD7s6YtdzYf2ntIdO3sPvVU1j0PU/7miaXEq8MG
         XD0lNRz5UJQs2QZ7xCC7aO/58wIOdVAQ1l7fCO9+v7uj+nmatXKkX+WO4SGQMFTP0AV7
         4bz0Oond8es3IHk90D88TFbJZSQ8t0+xUqYpUKxtV59CjybmI+TVa2g0KyshkhXYk6r2
         R9eSfMZ8vNh1yQuNO0BIrRWX+KHxT13iYb48E3inXkXpIcvMVeRXqbdcDcyC1LMAkPmH
         v6Q3tcyREMg3p0aFOG76aujQrFrkCGbu91ZWqwocBVeJAnaJ7RTE/+a4xw/P7Br+5RbO
         kwUw==
X-Gm-Message-State: ACgBeo3HtF41/lrVuk8fBhYpFqajA3c40+9IiLQAV5YdatRhNSp/gNua
        6Osk7yd6AyHezB1CtuQRU5jaoZuQCKvGwdUlcrF2FFznhxU=
X-Google-Smtp-Source: AA6agR5IBO3SZ6jAmjZv7QGjsbLPkqVNjj+VmpvxJ8OkovdXkMVOKcw1QyUOH8QaU9UVnQZfQHk4L3c07EvF3TRMmD4=
X-Received: by 2002:a17:907:272a:b0:731:4699:b375 with SMTP id
 d10-20020a170907272a00b007314699b375mr8992194ejl.633.1660525305466; Sun, 14
 Aug 2022 18:01:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220811001654.1316689-1-kuifeng@fb.com> <20220811001654.1316689-2-kuifeng@fb.com>
 <0f5123dc-5334-7e23-e143-c82002762242@fb.com>
In-Reply-To: <0f5123dc-5334-7e23-e143-c82002762242@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 14 Aug 2022 18:01:33 -0700
Message-ID: <CAADnVQJoSvO7J2OYqtjA0FuR-nO_Uo571rPA-g47gQO2k4HfsA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Parameterize task iterators.
To:     Yonghong Song <yhs@fb.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Aug 13, 2022 at 3:17 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/10/22 5:16 PM, Kui-Feng Lee wrote:
> > Allow creating an iterator that loops through resources of one task/thread.
> >
> > People could only create iterators to loop through all resources of
> > files, vma, and tasks in the system, even though they were interested
> > in only the resources of a specific task or process.  Passing the
> > additional parameters, people can now create an iterator to go
> > through all resources or only the resources of a task.
> >
> > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > ---
> >   include/linux/bpf.h            |  29 ++++++++
> >   include/uapi/linux/bpf.h       |   8 +++
> >   kernel/bpf/task_iter.c         | 126 ++++++++++++++++++++++++++-------
> >   tools/include/uapi/linux/bpf.h |   8 +++
> >   4 files changed, 147 insertions(+), 24 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index 11950029284f..6bbe53d06faa 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1716,8 +1716,37 @@ int bpf_obj_get_user(const char __user *pathname, int flags);
> >       extern int bpf_iter_ ## target(args);                   \
> >       int __init bpf_iter_ ## target(args) { return 0; }
> >
> > +/*
> > + * The task type of iterators.
> > + *
> > + * For BPF task iterators, they can be parameterized with various
> > + * parameters to visit only some of tasks.
> > + *
> > + * BPF_TASK_ITER_ALL (default)
> > + *   Iterate over resources of every task.
> > + *
> > + * BPF_TASK_ITER_TID
> > + *   Iterate over resources of a task/tid.
> > + *
> > + * BPF_TASK_ITER_TGID
> > + *   Iterate over reosurces of evevry task of a process / task group.
> > + */
> > +enum bpf_iter_task_type {
> > +     BPF_TASK_ITER_ALL = 0,
> > +     BPF_TASK_ITER_TID,
> > +     BPF_TASK_ITER_TGID,
> > +};
> > +
> >   struct bpf_iter_aux_info {
> >       struct bpf_map *map;
> > +     struct {
> > +             enum bpf_iter_task_type type;
> > +             union {
> > +                     u32 tid;
> > +                     u32 tgid;
> > +                     u32 pid_fd;
> > +             };
> > +     } task;
> >   };
> >
> >   typedef int (*bpf_iter_attach_target_t)(struct bpf_prog *prog,
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index ffcbf79a556b..6328aca0cf5c 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -91,6 +91,14 @@ union bpf_iter_link_info {
> >       struct {
> >               __u32   map_fd;
> >       } map;
> > +     /*
> > +      * Parameters of task iterators.
> > +      */
>
> The comment can be put into one line.
>
> > +     struct {
> > +             __u32   tid;
> > +             __u32   tgid;
> > +             __u32   pid_fd;
>
> The above is a max of kernel and user space terminologies.
> tid/pid are user space concept and tgid is a kernel space
> concept.
>
> In bpf uapi header, we have
>
> struct bpf_pidns_info {
>          __u32 pid;
>          __u32 tgid;
> };
>
> which uses kernel terminologies.
>
> So I suggest the bpf_iter_link_info.task can also
> use pure kernel terminology pid/tgid/tgid_fd here.
>
> Alternative, using pure user space terminology
> can be tid/pid/pid_fd but seems the kernel terminology
> might be better since we already have precedence.

Great catch and excellent point!

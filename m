Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FF7584545
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 20:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiG1RxT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 13:53:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiG1RxT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 13:53:19 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC01274CC9
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 10:53:17 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id l24so1907113ion.13
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 10:53:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lxFSB97t9mYbvQZzQJeisKp0yku201wmSpum1atsuhg=;
        b=WSLYhAUbtZcquE+RnFH+b6irCKs95RE9JTG7BTZ7PA81H33AAE3686gYGPZhF1nXzr
         2U4SaeczjOxxjWncF8mVfDTB7LnKHbJCKzJ+HF5HYI8z9qSdySTnLRZKskS+XyN5tHmB
         e8ByLMF4bXg5nLg/O5/KfeMhXXZAsI8tHvRYNGOXkzJIckws3hSRtCiZ516+WE/+V8pE
         AU1Lv2H7WYg4WMN3Hh5OAz0+ShmkZ3K8Aatvw5NQWgTS7GdM4dGyThTYhuqSMjO+dPes
         CGJPinCedYp/SrRmRh8R2gFspWZ9cgAAx5qi3U2UO7gcmLAyavK4UCpwWFOguIOIoRdj
         wOig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lxFSB97t9mYbvQZzQJeisKp0yku201wmSpum1atsuhg=;
        b=N6lymijbYc7vr/WLCo5CUdVC30gJyAdesrOIXUECq6+xhOI4862UH0ywjXoexIE4uP
         Cm4XZH1AikMdhZDhurU0xMFpEQEIoiwOX2fp6JyyrYNLvtWPwD2NWQVFQUOOvQaj7Gmb
         qCAcFlR/me9tFUCMUBOLNqZ/qofb9DFoF4ru2R/Iv/xk/SS4d7S2+Ldcusx9Z0U39Fr/
         bbaD1RibyAsIKBkdThJMAQZZUVmu3jl5+Pjr8tg0OJzB9U9TCjC0Iwlw5mparYZnRIGm
         GV11Z9YusVNla3Y8Jw+rfTMa5jMMfP8CVDTRVRdumGzqG7VOsdNCzMyI3LpQPQeH2xPM
         8gZA==
X-Gm-Message-State: AJIora/ZpGoEg6rzrlAVx/AqRCAcVZXDxVhgdOlFrQtjvFCBo1OR93uQ
        XxSzx/YS4jvwlJlW/eXKOkFRe8I+8FSrrz1iARw=
X-Google-Smtp-Source: AGRyM1slCXosMYhbWJROEMBEthl1misUH1EjsnRvf1zebVi/x204h+HaN0urG+ebOACidJrtr0DxCs56fKmC3xsK/pM=
X-Received: by 2002:a05:6638:3807:b0:341:709f:31a7 with SMTP id
 i7-20020a056638380700b00341709f31a7mr11738618jav.206.1659030797250; Thu, 28
 Jul 2022 10:53:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220726051713.840431-1-kuifeng@fb.com> <20220726051713.840431-2-kuifeng@fb.com>
 <Yt/aXYiVmGKP282Q@krava> <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
 <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
 <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com> <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
 <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com> <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
 <3805b621c511ee9bd76c6655d6ba814d1b54ee37.camel@fb.com> <555a171a-9855-e827-878d-e75e533f72ad@fb.com>
In-Reply-To: <555a171a-9855-e827-878d-e75e533f72ad@fb.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Thu, 28 Jul 2022 19:52:39 +0200
Message-ID: <CAP01T75pO1CgccUuSNWnWgyVnGuhCALMPPWsF=YJr9yfAz4=zA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
To:     Yonghong Song <yhs@fb.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, 28 Jul 2022 at 19:08, Yonghong Song <yhs@fb.com> wrote:
> > [...]
>
> There is one problem here. The current pidfd_open syscall
> only supports thread-group leader, i.e., main thread, i.e.,
> it won't support any non-main-thread tid's. Yes, thread-group
> leader and other threads should share the same vma and files
> in most of times, but it still possible different threads
> in the same process may have different files which is why
> in current task_iter.c we have:
>                  *tid = pid_nr_ns(pid, ns);
>                  task = get_pid_task(pid, PIDTYPE_PID);
>                  if (!task) {
>                          ++*tid;
>                          goto retry;
>                  } else if (skip_if_dup_files &&
> !thread_group_leader(task) &&
>                             task->files == task->group_leader->files) {
>                          put_task_struct(task);
>                          task = NULL;
>                          ++*tid;
>                          goto retry;
>                  }
>
>
> Each thread (tid) will have some fields different from
> thread-group leader (tgid), e.g., comm and most (if not all)
> scheduling related fields.
>
> So it would be good to support for each tid from the start
> as it is not clear when pidfd_open will support non
> thread-group leader.

I think this is just a missing feature, not a design limitation. If we
just disable thread pifdfd from waitid and pidfd_send_signal, I think
it is ok to use it elsewhere.

>
> If it worries wrap around, a reference to the task
> can be held when tid passed to the kernel at link
> create time. This is similar to pid is passed to
> the kernel at pidfd_open syscall. But in practice,
> I think taking the reference during read() should
> also fine. The race always exist anyway.
>
> Kumar, could you give more details about security
> concerns? I am not sure about the tight relationship
> between bpf_iter and security. bpf_iter just for
> iterating kernel data structures.
>

There is no security 'concern' per se. But having an fd which is used
to set up the iterator just gives a chance to a BPF LSM to easily
isolate permissions to attach the iterator to a task represented by
that fd. i.e. the fd is an object to which this permission can be
bound, the fd can be passed around (to share the same permission with
others but it is limited to the task corresponding to it), etc. The
permission management is even easier and faster once you have a file
local storage map (which I plan to send soon).

So you could have two pidfds, one which allows the process to attach
the iter to it, and one which doesn't, without relying on the task's
capabilities, the checks can become more fine grained, and the
original task can even drop its capabilities (because they are bound
to the fd instead), which allows privilege separation.

It becomes a bit difficult when kernel APIs take IDs because then you
don't have any subject (other than the task) to draw the permissions
from.

But anyway, all of this was just a suggestion (which is why I
solicited opinions in the original reply). Feel free to drop/ignore if
it is too much of a hassle to support (i.e. it is understandable you
wouldn't want to spend time extending pidfd_open for this).

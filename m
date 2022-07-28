Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC39358465F
	for <lists+bpf@lfdr.de>; Thu, 28 Jul 2022 21:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiG1TLW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 28 Jul 2022 15:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiG1TLV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 28 Jul 2022 15:11:21 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864EB6611A
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 12:11:20 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id v28so2123119qkg.13
        for <bpf@vger.kernel.org>; Thu, 28 Jul 2022 12:11:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Isc9lLeWkdBYTH1xSuxcBP+WmP0U8gy232BOvKP3rPw=;
        b=SoRTuFkB36aEw1B4v1Us5rnsLjiC6DHLx8yL1Skl1cOwaLo6Go0cX+GFUhyZ1Z4ptv
         m+mOwzdXKlCSWY2hzjt6miiTcmdHRocP1rvi/VI7iNfdhmAHowlIS6XKswYzNWs/dvH7
         EVbteUBLeVb/sPF+1O2/2A+hJ+OU0OHxLyBKsMZqxP5rrpg910JMP3avfAp4dalE3jIU
         njLk6bN9YNtzKpY/fChZvqxgULoZHEyCkebfyQf4WItWvy3zqC26+IUpkeTzZbgc9jcG
         H5VSNV03H4RFTQXH39PJ/5yxoE/oloNnxi6uc4CIhiFx+9ZQGyGpIGFMyPCtmVarQBXB
         LDfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Isc9lLeWkdBYTH1xSuxcBP+WmP0U8gy232BOvKP3rPw=;
        b=a3d5fLUZgfvIKtcsfOQ0QPAoeKsILAXrG6ayD7kyCaJ7sH7FlJu4bgG/XbTHP1JCdo
         kNx6VHjbi8wmhKSUjuCvOQzVfzRCwZlPixvU1DIy+3GosfyMIo+bouQBwU4iqGpZcTjs
         n5TfYZd0aDVlqDP5d2nxbKPCqNO7tZlIjthZfDUP0Od3+uAduBHFbDdvCjXdGJFVGgMd
         qOs3ExrILpEaxjNRv7+0SdMXvkBLKIax7zvMNZNOaXhi5I3VEYSgjhIfx+/BQZH9UqBs
         xZ7k1XtqSvq06UTCSEWNngwd7egmIquirRY6BJ5SJgtUEeDv68saun5be4rsPsiQpvlm
         N22Q==
X-Gm-Message-State: AJIora9KCp9A8aYse1kbCWpG2SkfP1vAIYl0Z5T8P/lCydmNFnp7usCW
        q8+wEbCcSEkxZJ/8WODKs/LU3lq9JszVgZju0QEVQg==
X-Google-Smtp-Source: AGRyM1sGioO4GKh+DcRWYR0AG+odVdOyLgy2qq7Pm2a/jqwLpix/TEj6Z3NgSIqCl4Buqa0xFfDa3MdXd9nSnTN5Gro=
X-Received: by 2002:a05:620a:1927:b0:6b5:fe70:9acc with SMTP id
 bj39-20020a05620a192700b006b5fe709accmr228553qkb.669.1659035479549; Thu, 28
 Jul 2022 12:11:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220726051713.840431-1-kuifeng@fb.com> <20220726051713.840431-2-kuifeng@fb.com>
 <Yt/aXYiVmGKP282Q@krava> <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
 <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
 <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com> <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
 <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com> <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
 <3805b621c511ee9bd76c6655d6ba814d1b54ee37.camel@fb.com> <555a171a-9855-e827-878d-e75e533f72ad@fb.com>
 <CAP01T75pO1CgccUuSNWnWgyVnGuhCALMPPWsF=YJr9yfAz4=zA@mail.gmail.com>
In-Reply-To: <CAP01T75pO1CgccUuSNWnWgyVnGuhCALMPPWsF=YJr9yfAz4=zA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 28 Jul 2022 12:11:08 -0700
Message-ID: <CA+khW7jMHURJ2oFQ8b655gncQSbGttHFMA5xuhwHEmh8s5wzdA@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, Kui-Feng Lee <kuifeng@fb.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kumar,

On Thu, Jul 28, 2022 at 10:53 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Thu, 28 Jul 2022 at 19:08, Yonghong Song <yhs@fb.com> wrote:
> > > [...]
> >
> > There is one problem here. The current pidfd_open syscall
> > only supports thread-group leader, i.e., main thread, i.e.,
> > it won't support any non-main-thread tid's. Yes, thread-group
> > leader and other threads should share the same vma and files
> > in most of times, but it still possible different threads
> > in the same process may have different files which is why
> > in current task_iter.c we have:
> >                  *tid = pid_nr_ns(pid, ns);
> >                  task = get_pid_task(pid, PIDTYPE_PID);
> >                  if (!task) {
> >                          ++*tid;
> >                          goto retry;
> >                  } else if (skip_if_dup_files &&
> > !thread_group_leader(task) &&
> >                             task->files == task->group_leader->files) {
> >                          put_task_struct(task);
> >                          task = NULL;
> >                          ++*tid;
> >                          goto retry;
> >                  }
> >
> >
> > Each thread (tid) will have some fields different from
> > thread-group leader (tgid), e.g., comm and most (if not all)
> > scheduling related fields.
> >
> > So it would be good to support for each tid from the start
> > as it is not clear when pidfd_open will support non
> > thread-group leader.
>
> I think this is just a missing feature, not a design limitation. If we
> just disable thread pifdfd from waitid and pidfd_send_signal, I think
> it is ok to use it elsewhere.
>
> >
> > If it worries wrap around, a reference to the task
> > can be held when tid passed to the kernel at link
> > create time. This is similar to pid is passed to
> > the kernel at pidfd_open syscall. But in practice,
> > I think taking the reference during read() should
> > also fine. The race always exist anyway.
> >
> > Kumar, could you give more details about security
> > concerns? I am not sure about the tight relationship
> > between bpf_iter and security. bpf_iter just for
> > iterating kernel data structures.
> >
>
> There is no security 'concern' per se. But having an fd which is used
> to set up the iterator just gives a chance to a BPF LSM to easily
> isolate permissions to attach the iterator to a task represented by
> that fd. i.e. the fd is an object to which this permission can be
> bound, the fd can be passed around (to share the same permission with
> others but it is limited to the task corresponding to it), etc. The
> permission management is even easier and faster once you have a file
> local storage map (which I plan to send soon).
>

I like the idea of a file local storage map. I have several questions
in mind, but don't want to digress from the discussion under
Kui-Feng's patchset. It probably will be clear when seeing your
change. Please cc me when you send it out. thanks.

> So you could have two pidfds, one which allows the process to attach
> the iter to it, and one which doesn't, without relying on the task's
> capabilities, the checks can become more fine grained, and the
> original task can even drop its capabilities (because they are bound
> to the fd instead), which allows privilege separation.
>
> It becomes a bit difficult when kernel APIs take IDs because then you
> don't have any subject (other than the task) to draw the permissions
> from.
>
> But anyway, all of this was just a suggestion (which is why I
> solicited opinions in the original reply). Feel free to drop/ignore if
> it is too much of a hassle to support (i.e. it is understandable you
> wouldn't want to spend time extending pidfd_open for this).

On another thread, I was having a discussion with Tejun on FD vs ID
for cgroup_iter. I am in favor of ID in general, because it's
stateless and matches the info reported by bpf_link_info. This is nice
from the userspace's perspective.

Hao

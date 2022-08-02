Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA45B587E16
	for <lists+bpf@lfdr.de>; Tue,  2 Aug 2022 16:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231271AbiHBO0L (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 2 Aug 2022 10:26:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230497AbiHBO0K (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 2 Aug 2022 10:26:10 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBBB56369
        for <bpf@vger.kernel.org>; Tue,  2 Aug 2022 07:26:09 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id x64so10765947iof.1
        for <bpf@vger.kernel.org>; Tue, 02 Aug 2022 07:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=q+swPFxQ5uod60mgGYeDaGgzkscbLWW/ST1CK9IY86I=;
        b=o/gjrcOl/LzanEqF5+sqkZ7WZmisvsChdzpjCqlh6de9EuojSIq+CnemUgBR+Wcnon
         Dp+loS86xlH3BmBHhH/WsZ8x3pYj0yPOjUMgUMhf3z0+g9nh0AZUjbnvwsAliscDaSxH
         RnsRK5QEkefqBGfLJe6HaE1ytEVtryHdxEt41QtXTBcJRnQc9TI34UHGMvoH2GIAs4iQ
         x6RF0++2AoOMZeDPH0iP/Q+UuukE0da6wrZiznUxJthv20jnjI6J0rMgKvGgTTUBwfJ8
         fExgwWfXQG9RBxqTbxv56Nqy44lbGeqxsu2e0dCunkia5MKCiIyZiSAtG/zhHfoiphjq
         PbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=q+swPFxQ5uod60mgGYeDaGgzkscbLWW/ST1CK9IY86I=;
        b=uyp5O930yuje7tzCmdisBTzmlGDwVafqnwvbnj3SV8jcruQe7ES4IWLreENUQC8rn3
         yzxC5JALknQkHrPycPrdNupU5CKW7BiAIqyStgJUj9hLgslBxFZ5QOA1QK4zUy6QWgHT
         SDQEyBRcJDV7z+9ZI6MuX7F8zk/4k/wzqqjZsYllaZ/wEItywW39OEpkGXbtPVSpgyuH
         auYz1I3odrJwfvmZBbMKZOrLDkyLkLL0mrZ6V0ozmmdKrA+Sg3Gif2D3d9lGA41ZGV2E
         qDfFBrG4eAort45QhSm/FLvEFWX2X5M7oqLqcKGsvPd9u8sXfBnl9WVdP2XAo7K5z9zq
         btvQ==
X-Gm-Message-State: AJIora9aTTEzumptEqfReEOUPc7sRewFPTRyPTv/PGpWNKCDgCUrv2O6
        ahJvEIGL/nD29WYC8PNInsJn8bOL7ZH56szgNwAmBgk9
X-Google-Smtp-Source: AGRyM1tfjlNj85N032H5uRYd1l9BfaQlcGyiPjv2T0NVb3be5DfQcKI8tfLZ3r7j0rkd2E4zP81REQ6sNaRBRpwihP0=
X-Received: by 2002:a5d:9da8:0:b0:67c:557:2ab1 with SMTP id
 ay40-20020a5d9da8000000b0067c05572ab1mr7374346iob.18.1659450369172; Tue, 02
 Aug 2022 07:26:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220726051713.840431-1-kuifeng@fb.com> <20220726051713.840431-2-kuifeng@fb.com>
 <Yt/aXYiVmGKP282Q@krava> <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
 <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
 <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com> <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
 <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com> <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
 <3805b621c511ee9bd76c6655d6ba814d1b54ee37.camel@fb.com> <555a171a-9855-e827-878d-e75e533f72ad@fb.com>
 <CAP01T75pO1CgccUuSNWnWgyVnGuhCALMPPWsF=YJr9yfAz4=zA@mail.gmail.com> <CA+khW7jMHURJ2oFQ8b655gncQSbGttHFMA5xuhwHEmh8s5wzdA@mail.gmail.com>
In-Reply-To: <CA+khW7jMHURJ2oFQ8b655gncQSbGttHFMA5xuhwHEmh8s5wzdA@mail.gmail.com>
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
Date:   Tue, 2 Aug 2022 16:25:32 +0200
Message-ID: <CAP01T76UC2Lsk5H8W6Okt5j1MHNtENzwYwGjjL6TGp0QW96_0A@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
To:     Hao Luo <haoluo@google.com>
Cc:     Yonghong Song <yhs@fb.com>, Kui-Feng Lee <kuifeng@fb.com>,
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

On Thu, 28 Jul 2022 at 21:11, Hao Luo <haoluo@google.com> wrote:
>
> Hi Kumar,
>
> On Thu, Jul 28, 2022 at 10:53 AM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Thu, 28 Jul 2022 at 19:08, Yonghong Song <yhs@fb.com> wrote:
> > > > [...]
> > >
> > > There is one problem here. The current pidfd_open syscall
> > > only supports thread-group leader, i.e., main thread, i.e.,
> > > it won't support any non-main-thread tid's. Yes, thread-group
> > > leader and other threads should share the same vma and files
> > > in most of times, but it still possible different threads
> > > in the same process may have different files which is why
> > > in current task_iter.c we have:
> > >                  *tid = pid_nr_ns(pid, ns);
> > >                  task = get_pid_task(pid, PIDTYPE_PID);
> > >                  if (!task) {
> > >                          ++*tid;
> > >                          goto retry;
> > >                  } else if (skip_if_dup_files &&
> > > !thread_group_leader(task) &&
> > >                             task->files == task->group_leader->files) {
> > >                          put_task_struct(task);
> > >                          task = NULL;
> > >                          ++*tid;
> > >                          goto retry;
> > >                  }
> > >
> > >
> > > Each thread (tid) will have some fields different from
> > > thread-group leader (tgid), e.g., comm and most (if not all)
> > > scheduling related fields.
> > >
> > > So it would be good to support for each tid from the start
> > > as it is not clear when pidfd_open will support non
> > > thread-group leader.
> >
> > I think this is just a missing feature, not a design limitation. If we
> > just disable thread pifdfd from waitid and pidfd_send_signal, I think
> > it is ok to use it elsewhere.
> >
> > >
> > > If it worries wrap around, a reference to the task
> > > can be held when tid passed to the kernel at link
> > > create time. This is similar to pid is passed to
> > > the kernel at pidfd_open syscall. But in practice,
> > > I think taking the reference during read() should
> > > also fine. The race always exist anyway.
> > >
> > > Kumar, could you give more details about security
> > > concerns? I am not sure about the tight relationship
> > > between bpf_iter and security. bpf_iter just for
> > > iterating kernel data structures.
> > >
> >
> > There is no security 'concern' per se. But having an fd which is used
> > to set up the iterator just gives a chance to a BPF LSM to easily
> > isolate permissions to attach the iterator to a task represented by
> > that fd. i.e. the fd is an object to which this permission can be
> > bound, the fd can be passed around (to share the same permission with
> > others but it is limited to the task corresponding to it), etc. The
> > permission management is even easier and faster once you have a file
> > local storage map (which I plan to send soon).
> >
>
> I like the idea of a file local storage map. I have several questions
> in mind, but don't want to digress from the discussion under
> Kui-Feng's patchset. It probably will be clear when seeing your
> change. Please cc me when you send it out. thanks.
>

Thanks for the interest! I'll cc you when I send it out.

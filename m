Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 494D0584DE1
	for <lists+bpf@lfdr.de>; Fri, 29 Jul 2022 11:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234845AbiG2JKr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 29 Jul 2022 05:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234830AbiG2JKq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 29 Jul 2022 05:10:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA11279EFD
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 02:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6736EB82706
        for <bpf@vger.kernel.org>; Fri, 29 Jul 2022 09:10:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C840DC433D6;
        Fri, 29 Jul 2022 09:10:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659085843;
        bh=IXXLsG1s5nDVaGU8HV9pHVX3isjRL4ZOgVUwU/OjiwU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Gonlo2bo+c+EfznwJ/xGNqzXeH6xoUhdg5GbJxcll0OUtbTRhY/S1j3Gta+vsdVjb
         BrSNK2m1RFPmvgGfsFSR7LibvK/qu9WQrljoM5RTybT9uUFwaazqj8JsowtRfn7XEh
         XI9dj5MWj5l+7h3XETKVH+p7FiTLq2DIROTE5AF6pPJeXtbnWhjTZCciO0AdpY5SOA
         VKsl/LWJOwty1VdVLcE43noHThdbaaBc75ndm3VqKwBeBJiG+rb1hKBxIiVDoP8lDE
         gJqvhbf7/T95n8EDhI5pxY9vPJw17Ta+MjAlJFbM76Yb6+nW46jmBgmaGd5mjRN/Vj
         Vs2cJukZyv1/A==
Date:   Fri, 29 Jul 2022 11:10:37 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Yonghong Song <yhs@fb.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Kui-Feng Lee <kuifeng@fb.com>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "olsajiri@gmail.com" <olsajiri@gmail.com>,
        "ast@kernel.org" <ast@kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "andrii@kernel.org" <andrii@kernel.org>
Subject: Re: [PATCH bpf-next 1/3] bpf: Parameterize task iterators.
Message-ID: <20220729091037.otankmb46uifjw7p@wittgenstein>
References: <9e6967ec22f410edf7da3dc6e5d7c867431e3a30.camel@fb.com>
 <CAP01T75twVT2ea5Q74viJO+Y9kALbPFw4Yr6hbBfTdok0vAXaw@mail.gmail.com>
 <30a790ad499c9bb4783db91e305ee6546f497ebd.camel@fb.com>
 <CAP01T75=vMUTqpDHjgb_FokmbbG4VpQCUORUavCs0Z3ujT8Obw@mail.gmail.com>
 <cb91084ff7b92f06759358323c45c312da9fe029.camel@fb.com>
 <CAP01T7579jeBY8R8wnqamYsYk810S+S2_WHPMx16daK9+AQTCw@mail.gmail.com>
 <3805b621c511ee9bd76c6655d6ba814d1b54ee37.camel@fb.com>
 <555a171a-9855-e827-878d-e75e533f72ad@fb.com>
 <CAP01T75pO1CgccUuSNWnWgyVnGuhCALMPPWsF=YJr9yfAz4=zA@mail.gmail.com>
 <a0a56b1d-c0c9-8982-f695-db00983d90f7@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a0a56b1d-c0c9-8982-f695-db00983d90f7@fb.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jul 28, 2022 at 03:54:01PM -0700, Yonghong Song wrote:
> 
> 
> On 7/28/22 10:52 AM, Kumar Kartikeya Dwivedi wrote:
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
> > >                   *tid = pid_nr_ns(pid, ns);
> > >                   task = get_pid_task(pid, PIDTYPE_PID);
> > >                   if (!task) {
> > >                           ++*tid;
> > >                           goto retry;
> > >                   } else if (skip_if_dup_files &&
> > > !thread_group_leader(task) &&
> > >                              task->files == task->group_leader->files) {
> > >                           put_task_struct(task);
> > >                           task = NULL;
> > >                           ++*tid;
> > >                           goto retry;
> > >                   }
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
> 
> Yes, I agree this is a missing feature. It is desirable
> that the missing feature gets implemented in kernel or
> at least promising work is recognized before we use pidfd
> for this task structure.

When I did pidfd_{open,getfd,send_signal}, CLONE_PIDFD, and the waitid
support we simply didn't enable support for pidfd to refer to individual
threads because there was no immediate use-case for it and we hade some
concerns that I can't remember off the top of my head. Plus, we were
quite happy that we got the pidfd stuff in so we limited the scope of
what we wanted to do in the first iteration.

But if there is a good use-case for this then by all means we should
enable pidfds to refer to individual threads and I'm happy to route that
upstream. But this needs to be solid work as that area of the kernel can
be interesting technically and otherwise...

There have been requests for this before already.

I've added a wrapper pidfd_get_task() a while ago that encodes the
PIDTYPE_TGID restriction. If you grep for it you should find all places
that rely on pidfds (process_mrelease() and whatnot). All these places
need to be able to deal with individual threads if you change that.

But note, the mw is coming up.

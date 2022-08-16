Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECAD959546E
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 10:04:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbiHPIDo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 04:03:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiHPIDC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 04:03:02 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF6A61B1F
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 22:25:15 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id w3so12093015edc.2
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 22:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=TuF3rxb7e0kjwPjJh2NJYHcH2QdfephzOFONxzk0IW8=;
        b=ZA+JRwZ6zr4HTAHLdBMeWfU5pB1X00iFTd7qIjt2xatI/13dUEGqkHsuTunRig5wzV
         1IEFr6Zg8umMgkJjSamtYib0Dgjd4eNfqT/EXALTwWtS/iRosydNu4QO6WpgsCvvlGiV
         amvyLpaW4X0Z3rxkoaO0H+k9qem6ZAlYI2krL4riQ/E8A8RBK3SD1AjV6vRyjOgI+oP2
         DTHHFOlRlGVTCTsYk5EFlWOXduJve1YgDTMR2zobOpUC1yhWRsVZc+FnemzML62osYDp
         IdXvcu+KlncoNGR4hteGjDGUWMhIMs1R9L9+XVWS/GiwiNxmQglQ+aLu6n8OsR7R3rTc
         +XIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=TuF3rxb7e0kjwPjJh2NJYHcH2QdfephzOFONxzk0IW8=;
        b=f5rKMmXuepnhv868wcwiGuQDAnuMVRbta7gYIvtNFwJBpm/rPUtRwke7+FnMgDz84X
         GGKvsgvK2XZGEy0xlnUNKsXZ/VOzGyF4YIXrzL1eTJs70/aVbpWl30LdpUDinlZb0nJ9
         MrG/feVXmkBH6GnjZuF0gobIQoWZoTZ7NoKAH+TfkpvfWzCOku4jeY6xQQJhUZ9b21fO
         g9c5uQzSR65Wb350PtcjsLa0zJrUf+SH33nXdqKkZ1qZHw33L1q03hduwN1ThbxiSkBX
         B6fYa11bA3kfTJgIsVPGggnxBrcFV5Q62/2emF/RTJsSBGY6eLolz0tV5Cz+8jWdWtYv
         HBbg==
X-Gm-Message-State: ACgBeo1MS+QJXbRYavv7iyKDx2C0rihXq0phJM8o+owWaTgvCws9Y6zM
        IQphTzjzzKN/4L1K6SgxWFTLIQKrn+esQ77yZNdGOBWB
X-Google-Smtp-Source: AA6agR6WC3wmUSQss8VYFPK+ouk1oxfwhSFsOKyijPu34ej7UqUhJmDwQlJBlDS9c9ZO0Emq3h8yevDIQvVCqOOzgWk=
X-Received: by 2002:aa7:ccc4:0:b0:43d:9e0e:b7ff with SMTP id
 y4-20020aa7ccc4000000b0043d9e0eb7ffmr17818967edt.14.1660627513845; Mon, 15
 Aug 2022 22:25:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220811001654.1316689-1-kuifeng@fb.com> <20220811001654.1316689-2-kuifeng@fb.com>
 <0f5123dc-5334-7e23-e143-c82002762242@fb.com>
In-Reply-To: <0f5123dc-5334-7e23-e143-c82002762242@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Aug 2022 22:25:02 -0700
Message-ID: <CAEf4BzaRK5hfuDP6HJXzCHfhuLZBF44z7RTzdEGQw54zTwrAaw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v5 1/3] bpf: Parameterize task iterators.
To:     Yonghong Song <yhs@fb.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kernel-team@fb.com
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

Btw, Yonghong, I tried to figure it out myself, but got lost in all
the kernel functions that don't seem to be very well documented. Sorry
for being lazy and throwing this at you :)

Is it easy and efficient to iterate only processes using whatever
kernel helpers we have at our disposal? E.g., if I wanted to write an
iterator that would go only over processes (not individual threads,
just task leaders of each different process) within a cgroup, is that
possible?

I see task iterator as consisting of two different parts (and that
makes it a bit hard to define nice and clean interface, but if we can
crack this, we'd get an elegant and powerful construct):

1. What entity to iterate: threads or processes? (I'm ignoring
task_vma and task_files here, but one could task about files of each
thread or files of each process, but it's less practical, probably)

2. What's the scope of objects to iterate: just a thread by tid, just
a process by pid/pidfd, once cgroup iter lands, we'll be able to talk
about threads or processes within a cgroup or cgroup hierarchy (this
is where descendants_{pre,post}, cgroup_self_only and ancestors
ordering comes in as well).

Currently Kui-Feng is addressing first half of #2 (tid/pid/pidfd
parameters), we can use cgroup iter's parameters to define the scope
of tasks/processes by cgroup "filter" in a follow up (it naturally
extends what we have in this patch set).

So now I'm wondering if there is any benefit to also somehow
specifying threads vs processes as entities to iterate? And if we do
that, does kernel support efficient iteration of processes (as opposed
to threads).


To be clear, there is a lot of value in having just #2, but while we
are all at this topic, I thought I'd clarify for myself #1 as well.

Thanks!

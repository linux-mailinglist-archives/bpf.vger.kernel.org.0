Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 006ED5A1825
	for <lists+bpf@lfdr.de>; Thu, 25 Aug 2022 19:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239089AbiHYRuu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 25 Aug 2022 13:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231931AbiHYRut (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 25 Aug 2022 13:50:49 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 770EBA8957
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 10:50:48 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id w19so41031611ejc.7
        for <bpf@vger.kernel.org>; Thu, 25 Aug 2022 10:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Kq5NCG/Dcfv3fMvHlGc6AqJdZ2o+2zzgqOfL4O8RTEs=;
        b=Pv/qG6Qf6ZVKLXT0Vzzbs0loyO/UkYcCYymlhUAtLeT/+Iks6SBc5Hz7Zr53IbKIMX
         sNKqygbRAowEVwAXDrs876a2rc9xh337szI5glAF7T0ijgAB1Efv7nAhOlCzOSILxt5B
         soXf3IO45S2qiP6fi1rC33uQpjJZ90z8n5qQ806Jda6FidlvVv70PdyUg0LPuWcl9CtL
         AH5TxmbS1LNaRaY7NRy9obSc4LDEVeEAJmxbxx4oBQMhlhAzfkJvpEVWlnqrwnCSHOGN
         Yk4jPtERkGsw9XUNYKa87Ia8J3Fx4idZpI3onEYZkJUnHXbNseH4ggKmPuroAGSxkT46
         L5ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Kq5NCG/Dcfv3fMvHlGc6AqJdZ2o+2zzgqOfL4O8RTEs=;
        b=AcnaBUybgG8YROqFVKhwEa4zdi1K7yxcsdL/eiUN7dSUw4pQ664gOmf8JzEM4WvijH
         k2AP+ZJNoUg8jF7XCTkuIK//lbbEJkpzJ6PbOBH30q2QEdCo7g+B5WmZUNaFBYN/Sl+P
         yKKlJ4LDhVAm3mQD1UMj3ue3RX2fux5wiFQi0pHDwk77sTQW/BPzgFwkMNEkX5oHtGxU
         FIxUmiMn6bYYFO0GBtlybTJIT1pEOeYkzkblVqGKv6UOXLX0vJY08q0Im4V0MqOK5eql
         o8vBeRprw8yQKrKkOeqkYjykwMdrLg+Z1FUMlfgqXREwfPW5E0Vclj5Jf27Yh/gm3ocw
         K8rA==
X-Gm-Message-State: ACgBeo2i1YRb3Md8XgpLGUAbY43b/yFcHyHJQcmLK98/qmqnyY5uInvB
        SFvpLT9JModJtS3IMKV3fpZeETcV4uoNOArccJA=
X-Google-Smtp-Source: AA6agR5SDmrGfe13EfYSrdTOEJn2pEzF+pTrU9QVLUC1hKzV15haO1hBMo2jw//0X8hxTpxsAXGtrwhMoYuEC2afhJY=
X-Received: by 2002:a17:907:2bdb:b0:73d:d7af:c133 with SMTP id
 gv27-20020a1709072bdb00b0073dd7afc133mr1940452ejc.545.1661449847038; Thu, 25
 Aug 2022 10:50:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220811001654.1316689-1-kuifeng@fb.com> <20220811001654.1316689-2-kuifeng@fb.com>
 <0f5123dc-5334-7e23-e143-c82002762242@fb.com> <CAEf4BzaRK5hfuDP6HJXzCHfhuLZBF44z7RTzdEGQw54zTwrAaw@mail.gmail.com>
 <c752a54f-d2e2-157e-778a-5b3f01bf5e6f@fb.com>
In-Reply-To: <c752a54f-d2e2-157e-778a-5b3f01bf5e6f@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 25 Aug 2022 10:50:35 -0700
Message-ID: <CAEf4BzbmxcO9wiN9k+AROq7JDHvwBoJ7eV43tE2mSUXao89oEQ@mail.gmail.com>
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

On Wed, Aug 17, 2022 at 9:31 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 8/15/22 10:25 PM, Andrii Nakryiko wrote:
> > On Sat, Aug 13, 2022 at 3:17 PM Yonghong Song <yhs@fb.com> wrote:
> >>
> >>
> >>
> >> On 8/10/22 5:16 PM, Kui-Feng Lee wrote:
> >>> Allow creating an iterator that loops through resources of one task/thread.
> >>>
> >>> People could only create iterators to loop through all resources of
> >>> files, vma, and tasks in the system, even though they were interested
> >>> in only the resources of a specific task or process.  Passing the
> >>> additional parameters, people can now create an iterator to go
> >>> through all resources or only the resources of a task.
> >>>
> >>> Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> >>> ---
> >>>    include/linux/bpf.h            |  29 ++++++++
> >>>    include/uapi/linux/bpf.h       |   8 +++
> >>>    kernel/bpf/task_iter.c         | 126 ++++++++++++++++++++++++++-------
> >>>    tools/include/uapi/linux/bpf.h |   8 +++
> >>>    4 files changed, 147 insertions(+), 24 deletions(-)
> >>>
> >
> > Btw, Yonghong, I tried to figure it out myself, but got lost in all
> > the kernel functions that don't seem to be very well documented. Sorry
> > for being lazy and throwing this at you :)
> >
> > Is it easy and efficient to iterate only processes using whatever
> > kernel helpers we have at our disposal? E.g., if I wanted to write an
> > iterator that would go only over processes (not individual threads,
> > just task leaders of each different process) within a cgroup, is that
> > possible?
>
> To traverse processes in a cgroup, the best location is in
> kernel/cgroup/cgroup.c where there exists a seq_ops to
> traverse all processes in cgroup.procs file. If we try
> to implement a bpf based iterator, we could reuse some
> codes in that file.
>

yep

> >
> > I see task iterator as consisting of two different parts (and that
> > makes it a bit hard to define nice and clean interface, but if we can
> > crack this, we'd get an elegant and powerful construct):
> >
> > 1. What entity to iterate: threads or processes? (I'm ignoring
> > task_vma and task_files here, but one could task about files of each
> > thread or files of each process, but it's less practical, probably)
> >
> > 2. What's the scope of objects to iterate: just a thread by tid, just
> > a process by pid/pidfd, once cgroup iter lands, we'll be able to talk
> > about threads or processes within a cgroup or cgroup hierarchy (this
> > is where descendants_{pre,post}, cgroup_self_only and ancestors
> > ordering comes in as well).
> >
> > Currently Kui-Feng is addressing first half of #2 (tid/pid/pidfd
> > parameters), we can use cgroup iter's parameters to define the scope
> > of tasks/processes by cgroup "filter" in a follow up (it naturally
> > extends what we have in this patch set).
>
> For #2 as well, it is also possible to have a complete new seq_ops
> if the traversal is only once. That is why in Kui-Feng's patch,
> there are a few special case w.r.t. TID. But current approach
> is also okay.
>

sounds good!

> >
> > So now I'm wondering if there is any benefit to also somehow
> > specifying threads vs processes as entities to iterate? And if we do
> > that, does kernel support efficient iteration of processes (as opposed
> > to threads).
>
> IIUC, I didn't find an efficient way to traverse processes only.
> The current pid_ns.idr records all tasks so traversing processes
> have to skip intermediate non-main-thread tasks.
>

I see, too bad, but thanks for checking!

> >
> >
> > To be clear, there is a lot of value in having just #2, but while we
> > are all at this topic, I thought I'd clarify for myself #1 as well.
> >
> > Thanks!

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F0A595419
	for <lists+bpf@lfdr.de>; Tue, 16 Aug 2022 09:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiHPHqk (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 16 Aug 2022 03:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229809AbiHPHqJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 16 Aug 2022 03:46:09 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D66C88A9
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 21:42:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kb8so16852493ejc.4
        for <bpf@vger.kernel.org>; Mon, 15 Aug 2022 21:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=tvPQmqKsDl0S0UzoyUWVBsNLkWeN+UJdqqafKa92CoY=;
        b=B2M4TdqJatm4cKeTM2r0Sa0Qly/wx+Gvmsm9xE0JhVxbA6aPZDm2/KkBy3ecJyUdzl
         m779uIxUjDON/vOsP3lbeCXeRC6qcEyNCAX/pRrgv69iEjJLTF7sDt7Nf2BCu/jEjD5y
         nQpBneiqdZR4nV3qP4cM26+k2ONKXA1j4GyktZSL73JwTWviNtlC3rNIQuYSbNN1sAnd
         1G+j/nTF/WbgA3AHq1PTKsdM4tXc/vIyCAk6YyNey7GGqrTzB2FrUWn4RYlNDmDmc/Hw
         JBsV7VBQ6xp3sfLpwQTDSWueePPD69/MsnhBz8HBrI9qxsmekVpe+1UePcsScCUyqTwn
         pFxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=tvPQmqKsDl0S0UzoyUWVBsNLkWeN+UJdqqafKa92CoY=;
        b=O5QSbtTG3ZWMIuC/Nd+hd69wKC8VHITjKJVcg2QdZj2Jqlc03RPjRBOQjfNXAb/DDs
         O7iRqfCIVmPqTPuZbDhAkTyPaoUah7mvhBFsIvqt2M+Mn0ecVgIC9+gNDWWnGK/GypIZ
         ieBz/m6IMg14QBcGTV/AMfTmCwt4jbjwznqsTm437mAgN7XdIG1H67gb7Aqk2ek7H2eW
         kQ0CF7rTQX1lgMpsBUmoWvD58z/6Ctj9kcMBENYuxt+gJ3e/fnB3jKVeTYv24GT8ryux
         uM6luXURfJKJfhSyfmbEjoGBXei/+19xEWKS4WluCF1a/Lxbye6nK+OoQJ9VjusdwgIV
         9QGw==
X-Gm-Message-State: ACgBeo2vKa9CZ3KZmlT+wyCJEIU8WTqzuomJk9K/AsmsHtFTsVF8geWw
        T5wY/3Okss21ik4h66Efe+um2M7RfokOz/Lpfr0=
X-Google-Smtp-Source: AA6agR47Oln5U5hmsypHn+KZmpc/E+ymCpOJWRjFtNueN4QX4blQ2MMu2NW/8uMSjmTAWPJksKF76fLipwghlbHhDlo=
X-Received: by 2002:a17:907:3d90:b0:730:a937:fb04 with SMTP id
 he16-20020a1709073d9000b00730a937fb04mr12562389ejc.176.1660624974495; Mon, 15
 Aug 2022 21:42:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220811001654.1316689-1-kuifeng@fb.com> <20220811001654.1316689-2-kuifeng@fb.com>
 <0f5123dc-5334-7e23-e143-c82002762242@fb.com>
In-Reply-To: <0f5123dc-5334-7e23-e143-c82002762242@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 15 Aug 2022 21:42:43 -0700
Message-ID: <CAEf4BzYsKaFJHPn2uDz+xLGWLz5BFi5Q9ESDffbVXetZbiC5fA@mail.gmail.com>
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

[...]

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

Except tgid_fd is a made up terminology. It is called pidfd in
documentation and even if pidfd gains add support for threads (tasks),
it would still be created through pidfd_open() syscall, probably. So
it seems better to stick to "pidfd" here.

As for pid/tgid precedent. Are we referring to
bpf_get_current_pid_tgid() BPF helper and struct bpf_pidns_info? Those
are kernel-side BPF helper and kernel-side auxiliary type to describe
return results of another in-kernel helper, so I think it's a bit less
relevant here to set a precedent.

On the other hand, if we look at user-space-facing perf_event
subsystem UAPI, for example, it seems to be using pid/tid terminology
(and so does getpid()/gettid() syscall, etc). So I wonder if for a
user-space-facing API it's better to stick with user-space-facing
terminology?

>
> Alternative, using pure user space terminology
> can be tid/pid/pid_fd but seems the kernel terminology
> might be better since we already have precedence.
>
>
> > +     } task;
> >   };
> >

[...]

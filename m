Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48CED4D2310
	for <lists+bpf@lfdr.de>; Tue,  8 Mar 2022 22:08:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238108AbiCHVJt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Mar 2022 16:09:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiCHVJt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Mar 2022 16:09:49 -0500
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F75E29CA5
        for <bpf@vger.kernel.org>; Tue,  8 Mar 2022 13:08:51 -0800 (PST)
Received: by mail-qk1-x72a.google.com with SMTP id q194so168365qke.5
        for <bpf@vger.kernel.org>; Tue, 08 Mar 2022 13:08:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aDSOBm4d5nO/KrS/W0aAAr28zrJ753qvjHwTkTdw9kk=;
        b=IQNlE95xzFsoZ/PblHHm/qEE1xW6I0QhH4ifACt1mBjmMJif3RQXXYM4RzLT/psSl8
         9Anm/9FEbRjZtMEZ2MfvZHD9Pu+dRyx7z783YEo0MawjZetnl2/G4Lo3yB6DC4z/BCta
         AYpElEbrSlfmX9AE3nvcbP5lcT8pAQkJqyB2YiKCRDgcitKKIARW+lB4G6yumt9gAHRA
         lSRsTjy8h84X0kRBXr4etBPqLx5b1ZweTPDGCzhjgr9ZKjsy/KKEHHOdtEe4jbD0z2Au
         93LEAczwx87RZhku6PtgEn2yhr6ZqsR6LszCnikopuJOp5zA01ChuDkOYHbv0whsNRu+
         wrCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aDSOBm4d5nO/KrS/W0aAAr28zrJ753qvjHwTkTdw9kk=;
        b=wnsbp/fTG728JDGME7D74NrEgIwk0unQo08CKNFE5gTxuV+twxEHvBtjBAbk7NHBnc
         gG8zyMXBC3cxuS+prNh91awZrBU/mclguFaCcC8bdR0ay4+XvY2nNq9zY/sr7nbSDzIL
         tbuBU1E+iMcQyHh8tOrl3AsGvuXqOL417VNU2GwrCarhYdsWvCAK+gWuRjFgsPXZHShp
         mpCv1zaTeILN8dLtLlwlSYDvfV2Xyl/pfX7dB3IWUCCCRV7Kbju7GNTilXg7eqXTXBMC
         GltQ6vTHuekeupXxEuHDgC1ThZIVbqROqiVnBCHqylEgrYUaGmAfFYAVEmSd0Qnb4FLo
         1TWg==
X-Gm-Message-State: AOAM533N6F5FUcN4ORXPNmX3uQjQWhaeTBU8Zh0IEotHJFMBNdWzid9P
        YXUA7s9IGLh4WZN+eDc4ShTcNbm9nL7GpJOoo0CquQ==
X-Google-Smtp-Source: ABdhPJwUz+BS2DcHTmdLJAf815JaWVdyXiZass6ggduXJR8Sq164BEaJZ5AcIUrPOpW+bpSFyNuf3NDUGLnlMB1wYyQ=
X-Received: by 2002:a05:620a:2849:b0:67d:2462:15e4 with SMTP id
 h9-20020a05620a284900b0067d246215e4mr2356259qkp.583.1646773730521; Tue, 08
 Mar 2022 13:08:50 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <20220227051821.fwrmeu7r6bab6tio@apollo.legion> <CA+khW7g4mLw9W+CY651FaE-2SF0XBeaGKa5Le7ZnTBTK7eD30Q@mail.gmail.com>
 <20220302193411.ieooguqoa6tpraoe@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7goNwmt2xJb8SMaagXcsZdquQha8kax-LF033wFexKCcA@mail.gmail.com>
 <CA+khW7hK9JKU3be7gDDJ9DsOeaUS3RxCGJOJAUrZwvyVJiSSSA@mail.gmail.com> <CAADnVQ+-9DAuqj3jLvnwPn0PwuRnfSZ4niDOPqOaF+SH-_+P8A@mail.gmail.com>
In-Reply-To: <CAADnVQ+-9DAuqj3jLvnwPn0PwuRnfSZ4niDOPqOaF+SH-_+P8A@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Tue, 8 Mar 2022 13:08:39 -0800
Message-ID: <CA+khW7iQ6w99pB+kodXheJDo5nAZ6wxZiaWtt08xKQETs=uJFg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Joe Burton <jevburton.kernel@gmail.com>,
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>,
        Stanislav Fomichev <sdf@google.com>, bpf <bpf@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Mar 5, 2022 at 3:47 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Fri, Mar 4, 2022 at 10:37 AM Hao Luo <haoluo@google.com> wrote:
> >
> > I gave this question more thought. We don't need to bind mount the top
> > bpffs into the container, instead, we may be able to overlay a bpffs
> > directory into the container. Here is the workflow in my mind:
>
> I don't quite follow what you mean by 'overlay' here.
> Another bpffs mount or future overlayfs that supports bpffs?
>
> > For each job, let's say A, the container runtime can create a
> > directory in bpffs, for example
> >
> >   /sys/fs/bpf/jobs/A
> >
> > and then create the cgroup for A. The sleepable tracing prog will
> > create the file:
> >
> >   /sys/fs/bpf/jobs/A/100/stats
> >
> > 100 is the created cgroup's id. Then the container runtime overlays
> > the bpffs directory into container A in the same path:
>
> Why cgroup id ? Wouldn't it be easier to use the same cgroup name
> as in cgroupfs ?
>

Cgroup name isn't unique. We don't need the hierarchy information of
cgroups. We can use a library function to translate cgroup path to
cgroup id. See the get_cgroup_id() in patch 9/9. It works fine in the
selftest.

> >   [A's container path]/sys/fs/bpf/jobs/A.
> >
> > A can see the stats at the path within its mount ns:
> >
> >   /sys/fs/bpf/jobs/A/100/stats
> >
> > When A creates cgroup, it is able to write to the top layer of the
> > overlayed directory. So it is
> >
> >   /sys/fs/bpf/jobs/A/101/stats
> >
> > Some of my thoughts:
> >   1. Compared to bind mount top bpffs into container, overlaying a
> > directory avoids exposing other jobs' stats. This gives better
> > isolation. I already have a patch for supporting laying bpffs over
> > other fs, it's not too hard.
>
> So it's overlayfs combination of bpffs and something like ext4, right?
> I thought you found out that overlaryfs has to be upper fs
> and lower fs shouldn't be modified underneath.
> So if bpffs is a lower fs the writes into it should go
> through the upper overlayfs, right?
>

It's overlayfs combining bpffs and ext4. Bpffs is the upper layer. The
lower layer is an empty ext4 directory. The merged directory is a
directory in the container.
The upper layer contains bpf objects that we want to expose to the
container, for example, the sleepable tracing progs and the iter link
for reading stats. Only the merged directory is visible to the
container and all the updates go through the merged directory.

The following is the example of workflow I'm thinking:

Step 1: We first set up directories and bpf objects needed by containers.

[# ~] ls /sys/fs/bpf/container/upper
tracing_prog   iter_link
[# ~] ls /sys/fs/bpf/container/work
[# ~] ls /container
root   lower
[# ~] ls /container/root
bpf
[# ~] ls /container/root/bpf

Step 2: Use overlayfs to mount a directory from bpffs into the container's home.

[# ~] mkdir /container/lower
[# ~] mkdir /sys/fs/bpf/container/workdir
[# ~] mount -t overlay overlay -o \
 lowerdir=/container/lower,\
 upperdir=/sys/fs/bpf/container/upper,\
 workdir=/sys/fs/bpf/container/work \
  /container/root/bpf
[# ~] ls /container/root/bpf
tracing_prog    iter_link

Step 3: pivot root for container, we expect to see the bpf objects are
mapped into container,

[# ~] chroot /container/root
[# ~] ls /
bpf
[# ~] ls /bpf
tracing_prog   iter_link

Note:

- I haven't tested Step 3. But Step 1 and step 2 seem to be working as
expected. I am testing the behaviors of the bpf objects, after we
enter the container.

- Only a directory in bpffs is mapped into the container, not the top
bpffs. The path is uniform in all containers, that is, /bpf. The
container should be able to mkdir in /bpf, etc.

> >   2. Once the container runtime has overlayed directory into the
> > container, it has no need to create more cgroups for this job. It
> > doesn't need to track the stats of job-created cgroups, which are
> > mainly for inspection by the job itself. Even if it needs to collect
> > the stats from those cgroups, it can read from the path in the
> > container.
> >   3. The overlay path in container doesn't have to be exactly the same
> > as the path in root mount ns. In the sleepable tracing prog, we may
> > select paths based on current process's ns. If we choose to do this,
> > we can further avoid exposing cgroup id and job name to the container.
>
> The benefits make sense.

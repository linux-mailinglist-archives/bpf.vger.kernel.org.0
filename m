Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 083034CE7CA
	for <lists+bpf@lfdr.de>; Sun,  6 Mar 2022 00:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiCEXsX (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 5 Mar 2022 18:48:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiCEXsV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 5 Mar 2022 18:48:21 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6365ADD9;
        Sat,  5 Mar 2022 15:47:29 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id g1so10721233pfv.1;
        Sat, 05 Mar 2022 15:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8xHcyjm0EShrfW/6kiv17bipizmd4vd+MkZwRWGD9cM=;
        b=JEkvRAzVSRZwkKVtuKUiHR0/a3AEck1yAb6VU4oPxdB2ALsOGCB7ln3hvKlQw51/IR
         1pcgGaC6E98akJ9Rttugzn4sp8LHt9RHpIjCpLqxc3TXs3WHlK5WE5r14dHjn+NVoAO/
         bTIfvsPsX0nv1ngCMZV/1xAc0iO2hW6L4lbEf3xoxN6X/LUTPUbPNBYLFK7R8p8zEG45
         9PQxi5/GuWC9BTsZljST7CDBCu4YiO3ST71n2IaCSoADpSBySA7KMwPuvtoTc6aJt7vV
         brsbDL70NILV0OGJ5z5VWaZXJvxA2ByYfiz7Px6FlLNS78TxTB6VsljlM/ex2iOUxNSY
         GIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8xHcyjm0EShrfW/6kiv17bipizmd4vd+MkZwRWGD9cM=;
        b=GlIyAc/cyOQfgeSydfHPeNhY/3uv8dKLIwwx3yHabqOQ6JD0UR3lvqnVej9OnmN7iu
         5dtxidCCzrQ07pdjQIxly73aud/aGE7Th98ABkXYj60MiJIWN0y3HBchZjjIXlKY44TE
         uXzPHjlp2xlWws5JbC2wtpF9Mj+N15zVXO/W8ckbBHn8WgKK5ctrwuhXQdqjNOBkop+U
         1M1EbK8oJKFPkGHHtXevJYt6ZflxVngbmAcIM+Df723xg5vs7xCU9Qz4EA0YvEkEOGDg
         k9uJQdcN8pAjBrLlwtmkJ0NzHdHvlgy07ub4QT4JFXQMOILxETJ2hAojFNudgQAUflYw
         W8Xg==
X-Gm-Message-State: AOAM5313wBOEGlIqW4LK91O/9P44+pWLqNBZ3uH0J2cBSlnEaCmplmIc
        I5g5BYwjmALW8qP1fPvRUjG+GD8QNx31kqZfQ1ggOU7V
X-Google-Smtp-Source: ABdhPJwKiGI6QR670tcsRY7p24v/iXjAVNYkNxTB68/c4a3gj2wYxjXNuJl0aHsgM045jmhP66Y7jzIZLchpNEJNsR8=
X-Received: by 2002:aa7:805a:0:b0:4f6:dc68:5d41 with SMTP id
 y26-20020aa7805a000000b004f6dc685d41mr3697586pfm.69.1646524048739; Sat, 05
 Mar 2022 15:47:28 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <20220227051821.fwrmeu7r6bab6tio@apollo.legion> <CA+khW7g4mLw9W+CY651FaE-2SF0XBeaGKa5Le7ZnTBTK7eD30Q@mail.gmail.com>
 <20220302193411.ieooguqoa6tpraoe@ast-mbp.dhcp.thefacebook.com>
 <CA+khW7goNwmt2xJb8SMaagXcsZdquQha8kax-LF033wFexKCcA@mail.gmail.com> <CA+khW7hK9JKU3be7gDDJ9DsOeaUS3RxCGJOJAUrZwvyVJiSSSA@mail.gmail.com>
In-Reply-To: <CA+khW7hK9JKU3be7gDDJ9DsOeaUS3RxCGJOJAUrZwvyVJiSSSA@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 5 Mar 2022 15:47:17 -0800
Message-ID: <CAADnVQ+-9DAuqj3jLvnwPn0PwuRnfSZ4niDOPqOaF+SH-_+P8A@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
To:     Hao Luo <haoluo@google.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Mar 4, 2022 at 10:37 AM Hao Luo <haoluo@google.com> wrote:
>
> I gave this question more thought. We don't need to bind mount the top
> bpffs into the container, instead, we may be able to overlay a bpffs
> directory into the container. Here is the workflow in my mind:

I don't quite follow what you mean by 'overlay' here.
Another bpffs mount or future overlayfs that supports bpffs?

> For each job, let's say A, the container runtime can create a
> directory in bpffs, for example
>
>   /sys/fs/bpf/jobs/A
>
> and then create the cgroup for A. The sleepable tracing prog will
> create the file:
>
>   /sys/fs/bpf/jobs/A/100/stats
>
> 100 is the created cgroup's id. Then the container runtime overlays
> the bpffs directory into container A in the same path:

Why cgroup id ? Wouldn't it be easier to use the same cgroup name
as in cgroupfs ?

>   [A's container path]/sys/fs/bpf/jobs/A.
>
> A can see the stats at the path within its mount ns:
>
>   /sys/fs/bpf/jobs/A/100/stats
>
> When A creates cgroup, it is able to write to the top layer of the
> overlayed directory. So it is
>
>   /sys/fs/bpf/jobs/A/101/stats
>
> Some of my thoughts:
>   1. Compared to bind mount top bpffs into container, overlaying a
> directory avoids exposing other jobs' stats. This gives better
> isolation. I already have a patch for supporting laying bpffs over
> other fs, it's not too hard.

So it's overlayfs combination of bpffs and something like ext4, right?
I thought you found out that overlaryfs has to be upper fs
and lower fs shouldn't be modified underneath.
So if bpffs is a lower fs the writes into it should go
through the upper overlayfs, right?

>   2. Once the container runtime has overlayed directory into the
> container, it has no need to create more cgroups for this job. It
> doesn't need to track the stats of job-created cgroups, which are
> mainly for inspection by the job itself. Even if it needs to collect
> the stats from those cgroups, it can read from the path in the
> container.
>   3. The overlay path in container doesn't have to be exactly the same
> as the path in root mount ns. In the sleepable tracing prog, we may
> select paths based on current process's ns. If we choose to do this,
> we can further avoid exposing cgroup id and job name to the container.

The benefits make sense.

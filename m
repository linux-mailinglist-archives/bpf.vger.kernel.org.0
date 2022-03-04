Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0B234CDCBD
	for <lists+bpf@lfdr.de>; Fri,  4 Mar 2022 19:38:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241789AbiCDSiv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Mar 2022 13:38:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241778AbiCDSiu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Mar 2022 13:38:50 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4F15D676
        for <bpf@vger.kernel.org>; Fri,  4 Mar 2022 10:38:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id b5so13967050wrr.2
        for <bpf@vger.kernel.org>; Fri, 04 Mar 2022 10:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1PsjmwZ7wPNO/sJ0EQSCs1v5VwJYm3XrJ4Rza4PWy+c=;
        b=UAIliSWqX+pV0t9ELcbITJPMm/CYkQTcfgO8SW3VSKjUj3H5+Gn0aROKgexNQta44r
         /9LY2LMJGTZIlmP6OMfN5GUN3AVl3s9C3TRZD4zZbk8HTqeLC2a5d24LhV04sj109ywi
         VblOZZvECHecxZSWikE1L6W1CeNyZlH7glI9N+vKoPqmmnBjNXBepMAsJw+6JO+lGva4
         8q1Xr+oz5wEtsfCP0LiG3I3Qm0NfXUsYUknDXwz8RdNi1/qmuMOtW59PDJp0kNH9Thmm
         C09kfQ0uBKg+MPlukA/oI5kuPWdwyMVs2H48n0iwyk2peouBL/KF7HXsFoAD6Pj1K4ul
         eV9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1PsjmwZ7wPNO/sJ0EQSCs1v5VwJYm3XrJ4Rza4PWy+c=;
        b=WP3L/MLoJBikOPfy0yCAgT+RvSX0V2ObPt9S+vVsFaUccaDHnS6l3svwVQfb4ctazF
         VIzvCsip4Dh848zMJLH2h+PU6E4hLf0MdbY0IZgMzP+vSZEb4w8Pjgzdgz58AeTXJm4c
         ZY9/Rk+uJfoGkL/63jEK22hj/oX6q4S7k8qlCQKtjjraw2/2UWieelZb7mRyaYLD70HI
         EdKmkGxzcgBirW0lk1R0847iPt/1/TL+Gn3B4FRmul1BCEAb7flmV3/e/moc5Pd/zG66
         AYqdQspovsyW3CHHldCqjp+CTlXOYnZLn66rXdzTU6VLxnPEzQTA0jQkw6uGGATrCep7
         fa4g==
X-Gm-Message-State: AOAM532cYLLInMzyK2n/kc/W85CE8gTrIBatyY/cz0FRwbjxQYooSNjG
        hES5DC8RZUuuxl6vaJXjIgIwZFHbaR713vfGZzi/eg==
X-Google-Smtp-Source: ABdhPJzPKppQL0G+1sCTZ52f5TA2F99NYFEEvDwh7mmcFf6Td1sejwpGxXQfg806pJ5lagLK4NR3VvSV/2FfeRvlgwg=
X-Received: by 2002:adf:f18f:0:b0:1f0:761:491d with SMTP id
 h15-20020adff18f000000b001f00761491dmr24154wro.505.1646419078903; Fri, 04 Mar
 2022 10:37:58 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <20220227051821.fwrmeu7r6bab6tio@apollo.legion> <CA+khW7g4mLw9W+CY651FaE-2SF0XBeaGKa5Le7ZnTBTK7eD30Q@mail.gmail.com>
 <20220302193411.ieooguqoa6tpraoe@ast-mbp.dhcp.thefacebook.com> <CA+khW7goNwmt2xJb8SMaagXcsZdquQha8kax-LF033wFexKCcA@mail.gmail.com>
In-Reply-To: <CA+khW7goNwmt2xJb8SMaagXcsZdquQha8kax-LF033wFexKCcA@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Fri, 4 Mar 2022 10:37:47 -0800
Message-ID: <CA+khW7hK9JKU3be7gDDJ9DsOeaUS3RxCGJOJAUrZwvyVJiSSSA@mail.gmail.com>
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
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Mar 3, 2022 at 10:50 AM Hao Luo <haoluo@google.com> wrote:
>
> On Wed, Mar 2, 2022 at 11:34 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Mon, Feb 28, 2022 at 02:10:39PM -0800, Hao Luo wrote:
> > > Hi Kumar,
> > >
> > > On Sat, Feb 26, 2022 at 9:18 PM Kumar Kartikeya Dwivedi
> > > <memxor@gmail.com> wrote:
> > > >
> > > > On Sat, Feb 26, 2022 at 05:13:31AM IST, Hao Luo wrote:
> > > > > This patch allows bpf_syscall prog to perform some basic filesystem
> > > > > operations: create, remove directories and unlink files. Three bpf
> > > > > helpers are added for this purpose. When combined with the following
> > > > > patches that allow pinning and getting bpf objects from bpf prog,
> > > > > this feature can be used to create directory hierarchy in bpffs that
> > > > > help manage bpf objects purely using bpf progs.
> > > > >
> > > > > The added helpers subject to the same permission checks as their syscall
> > > > > version. For example, one can not write to a read-only file system;
> > > > > The identity of the current process is checked to see whether it has
> > > > > sufficient permission to perform the operations.
> > > > >
> > > > > Only directories and files in bpffs can be created or removed by these
> > > > > helpers. But it won't be too hard to allow these helpers to operate
> > > > > on files in other filesystems, if we want.
> > > > >
> > > > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > > > ---
> > > > > + *
> > > > > + * long bpf_mkdir(const char *pathname, int pathname_sz, u32 mode)
> > > > > + *   Description
> > > > > + *           Attempts to create a directory name *pathname*. The argument
> > > > > + *           *pathname_sz* specifies the length of the string *pathname*.
> > > > > + *           The argument *mode* specifies the mode for the new directory. It
> > > > > + *           is modified by the process's umask. It has the same semantic as
> > > > > + *           the syscall mkdir(2).
> > > > > + *   Return
> > > > > + *           0 on success, or a negative error in case of failure.
> > > > > + *
> > > > > + * long bpf_rmdir(const char *pathname, int pathname_sz)
> > > > > + *   Description
> > > > > + *           Deletes a directory, which must be empty.
> > > > > + *   Return
> > > > > + *           0 on sucess, or a negative error in case of failure.
> > > > > + *
> > > > > + * long bpf_unlink(const char *pathname, int pathname_sz)
> > > > > + *   Description
> > > > > + *           Deletes a name and possibly the file it refers to. It has the
> > > > > + *           same semantic as the syscall unlink(2).
> > > > > + *   Return
> > > > > + *           0 on success, or a negative error in case of failure.
> > > > >   */
> > > > >
> > > >
> > > > How about only introducing bpf_sys_mkdirat and bpf_sys_unlinkat? That would be
> > > > more useful for other cases in future, and when AT_FDCWD is passed, has the same
> > > > functionality as these, but when openat/fget is supported, it would work
> > > > relative to other dirfds as well. It can also allow using dirfd of the process
> > > > calling read for a iterator (e.g. if it sets the fd number using skel->bss).
> > > > unlinkat's AT_REMOVEDIR flag also removes the need for a bpf_rmdir.
> > > >
> > > > WDYT?
> > > >
> > >
> > > The idea sounds good to me, more flexible. But I don't have a real use
> > > case for using the added 'dirfd' at this moment. For all the use cases
> > > I can think of, absolute paths will suffice, I think. Unless other
> > > reviewers have opposition, I will try switching to mkdirat and
> > > unlinkat in v2.
> >
> > I'm surprised you don't need "at" variants.
> > I thought your production setup has a top level cgroup controller and
> > then inner tasks inside containers manage cgroups on their own.
> > Since containers are involved they likely run inside their own mountns.
> > cgroupfs mount is single. So you probably don't even need to bind mount it
> > inside containers, but bpffs is not a single mount. You need
> > to bind mount top bpffs inside containers for tasks to access it.
> > Now for cgroupfs the abs path is not an issue, but for bpffs
> > the AT_FDCWD becomes a problem. AT_FDCWD is using current mount ns.
> > Inside container that will be different. Unless you bind mount into exact
> > same path the full path has different meanings inside and outside of the container.
> > It seems to me the bpf progs attached to cgroup sleepable events should
> > be using FD of bpffs. Then when these tracepoints are triggered from
> > different containers in different mountns they will get the right dir prefix.
> > What am I missing?
> >
>
> Alexei, you are perfectly right. To be honest, I failed to see the
> fact that the sleepable tp prog is in the container's mount ns. I
> think we can bind mount the top bpffs into exactly the same path
> inside container, right? But I haven't tested this idea. Passing FDs
> should be better.
>

I gave this question more thought. We don't need to bind mount the top
bpffs into the container, instead, we may be able to overlay a bpffs
directory into the container. Here is the workflow in my mind:

For each job, let's say A, the container runtime can create a
directory in bpffs, for example

  /sys/fs/bpf/jobs/A

and then create the cgroup for A. The sleepable tracing prog will
create the file:

  /sys/fs/bpf/jobs/A/100/stats

100 is the created cgroup's id. Then the container runtime overlays
the bpffs directory into container A in the same path:

  [A's container path]/sys/fs/bpf/jobs/A.

A can see the stats at the path within its mount ns:

  /sys/fs/bpf/jobs/A/100/stats

When A creates cgroup, it is able to write to the top layer of the
overlayed directory. So it is

  /sys/fs/bpf/jobs/A/101/stats

Some of my thoughts:
  1. Compared to bind mount top bpffs into container, overlaying a
directory avoids exposing other jobs' stats. This gives better
isolation. I already have a patch for supporting laying bpffs over
other fs, it's not too hard.
  2. Once the container runtime has overlayed directory into the
container, it has no need to create more cgroups for this job. It
doesn't need to track the stats of job-created cgroups, which are
mainly for inspection by the job itself. Even if it needs to collect
the stats from those cgroups, it can read from the path in the
container.
  3. The overlay path in container doesn't have to be exactly the same
as the path in root mount ns. In the sleepable tracing prog, we may
select paths based on current process's ns. If we choose to do this,
we can further avoid exposing cgroup id and job name to the container.


> > I think non-AT variants are not needed. The prog can always pass AT_FDCWD
> > if it's really the intent, but passing actual FD seems more error-proof.
>
> Let's have the AT version. Passing FD seems the right approach, when
> we use it in the context of container.

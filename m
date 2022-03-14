Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72A04D8A77
	for <lists+bpf@lfdr.de>; Mon, 14 Mar 2022 18:07:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiCNRIz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 14 Mar 2022 13:08:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234173AbiCNRIz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 14 Mar 2022 13:08:55 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5755D3D4B2
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 10:07:44 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id b19so2730641wrh.11
        for <bpf@vger.kernel.org>; Mon, 14 Mar 2022 10:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=I9gjU0x/PgdM8bvtL6SwyLtmlqm3fb9Iulm2fPDe870=;
        b=TDH+vn8MRDd0TIB/7sTaTIjyrSXs8HnE41Pah2MUMlSNzgrfQ07BlDrRt6vnV9JeF/
         RAWJ1UkMrKFqkzQiiuZsik44O39eSmBjZ/Z0Nxr6go34gwnOlZ7Ocq/eSGzObW4s6hAk
         pgR/q2kn736c/MTokUaliD8FOZ8zTosL3VNsOoT1c/fv+Y/lg4bXIp8Zcku0zjJlrY64
         OWXit4bmUsIXP1MjuvvbYNu5lMsMWpfkEt7UlsGPcmiLIfqn/Xh65eL6h9/L9yURmFxi
         2KUh12l/KKOJ7r0Jvvaq7WFBa4alT8MiNUNfvkD5HmQbLUmb+GtN1TCdrrQXLhaUEzq7
         NSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=I9gjU0x/PgdM8bvtL6SwyLtmlqm3fb9Iulm2fPDe870=;
        b=jpwk+3z6vidk1by449PXD2DMLQyRBoTG7d8kp6dQvJESzMeZNk1WW59Ff+720r4xDG
         VCuNBFIBe2PzYStYDRrZxdEIZxmFP0XNBiCEpgALmPdxRtBorYlaoykQdiGSXK4BXsVp
         sAVaMsNg54CnVbN+JViRLvV+AO4qIZG2d9wF1XfC00IkZB9r7b/1clDTPxGpYc247TqL
         LQqTOEc3+yr5k8YL1Lzv5SpB7E3uskwD3BL+THSn26dc5oJhW3j4GRlZYyvTYZ8P368K
         UJY25DcAm4S5FiXSQu1C40IimcdC2/DXCh/iqivVYNhbCTbIffkoIhoD2qF5Pa3P3VkY
         ky3w==
X-Gm-Message-State: AOAM5313d49C1hEkWn4EnZ31yawCpx5A2juopRLm/NbzIus52/XR9erV
        IxObTsbhtoPMn1ek3RiRMrzi9WTPFloYX3C1nHTHkA==
X-Google-Smtp-Source: ABdhPJx1lcNmqCv85hlXRj7qoj+pc07cQQmq4rWlMg08lDktFz47BLCOP1mr2/KTpAMc+M3aq8bmx8xnegsS0Y2U0DU=
X-Received: by 2002:adf:e6c7:0:b0:1ed:9f7c:c99e with SMTP id
 y7-20020adfe6c7000000b001ed9f7cc99emr16863843wrm.0.1647277662677; Mon, 14 Mar
 2022 10:07:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <YiwXnSGf9Nb79wnm@zeniv-ca.linux.org.uk>
In-Reply-To: <YiwXnSGf9Nb79wnm@zeniv-ca.linux.org.uk>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 14 Mar 2022 10:07:31 -0700
Message-ID: <CA+khW7g+T2sAkP1aycmts_82JKWgYk5Y0ZJp+EvjFUyNY8W_5w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Alexei Starovoitov <ast@kernel.org>,
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

Hello Al,

On Fri, Mar 11, 2022 at 7:46 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, Feb 25, 2022 at 03:43:31PM -0800, Hao Luo wrote:
> > This patch allows bpf_syscall prog to perform some basic filesystem
> > operations: create, remove directories and unlink files. Three bpf
> > helpers are added for this purpose. When combined with the following
> > patches that allow pinning and getting bpf objects from bpf prog,
> > this feature can be used to create directory hierarchy in bpffs that
> > help manage bpf objects purely using bpf progs.
> >
> > The added helpers subject to the same permission checks as their syscall
> > version. For example, one can not write to a read-only file system;
> > The identity of the current process is checked to see whether it has
> > sufficient permission to perform the operations.
> >
> > Only directories and files in bpffs can be created or removed by these
> > helpers. But it won't be too hard to allow these helpers to operate
> > on files in other filesystems, if we want.
>
> In which contexts can those be called?
>

In a sleepable context. The plan is to introduce a certain tracepoints
as sleepable, a program that attaches to sleepable tracepoints is
allowed to call these functions. In particular, the first sleepable
tracepoint introduced in this patchset is one at the end of
cgroup_mkdir(). Do you have any advices?

> > +BPF_CALL_2(bpf_rmdir, const char *, pathname, int, pathname_sz)
> > +{
> > +     struct user_namespace *mnt_userns;
> > +     struct path parent;
> > +     struct dentry *dentry;
> > +     int err;
> > +
> > +     if (pathname_sz <= 1 || pathname[pathname_sz - 1])
> > +             return -EINVAL;
> > +
> > +     err = kern_path(pathname, 0, &parent);
> > +     if (err)
> > +             return err;
> > +
> > +     if (!bpf_path_is_bpf_dir(&parent)) {
> > +             err = -EPERM;
> > +             goto exit1;
> > +     }
> > +
> > +     err = mnt_want_write(parent.mnt);
> > +     if (err)
> > +             goto exit1;
> > +
> > +     dentry = kern_path_locked(pathname, &parent);
>
> This can't be right.  Ever.  There is no promise whatsoever
> that these two lookups will resolve to the same place.
>
> > +BPF_CALL_2(bpf_unlink, const char *, pathname, int, pathname_sz)
> > +{
> > +     struct user_namespace *mnt_userns;
> > +     struct path parent;
> > +     struct dentry *dentry;
> > +     struct inode *inode = NULL;
> > +     int err;
> > +
> > +     if (pathname_sz <= 1 || pathname[pathname_sz - 1])
> > +             return -EINVAL;
> > +
> > +     err = kern_path(pathname, 0, &parent);
> > +     if (err)
> > +             return err;
> > +
> > +     err = mnt_want_write(parent.mnt);
> > +     if (err)
> > +             goto exit1;
> > +
> > +     dentry = kern_path_locked(pathname, &parent);
> > +     if (IS_ERR(dentry)) {
> > +             err = PTR_ERR(dentry);
> > +             goto exit2;
> > +     }
>
> Ditto.  NAK; if you want to poke into fs/namei.c guts, do it right.
> Or at least discuss that on fsdevel.  As it is, it's completely broken.
> It's racy *and* it blatantly leaks both vfsmount and dentry references.
>
> NAKed-by: Al Viro <viro@zeniv.linux.org.uk>

Thanks Al for taking a look. Actually, there is a simpler approach:
can we export two functions in namei.c that wrap call to do_mkdirat
and do_unlinkat, but take a kernel string as pathname? Then these two
bpf helpers can use them, don't have to be this complicated. Does this
sound good to you?

Thanks!

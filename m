Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A5EE4CAEC8
	for <lists+bpf@lfdr.de>; Wed,  2 Mar 2022 20:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241023AbiCBTfB (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Mar 2022 14:35:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240776AbiCBTfA (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Mar 2022 14:35:00 -0500
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 291A5C1C8B;
        Wed,  2 Mar 2022 11:34:16 -0800 (PST)
Received: by mail-pf1-x431.google.com with SMTP id k1so2813448pfu.2;
        Wed, 02 Mar 2022 11:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=UtUIqChNwIGiM6BzTSKzlQEWchWVUYsbZYtiHQAXLaI=;
        b=Sj4Eeu+nBBfoMN1uavFkIabMJjbhxcWY9UzBPUg71hSA25R0GL0CeZN8G8q8DK/jbZ
         82Wgr/wLyWX/Fuvgxu1z+dahLEw/4ZyAhdE9PX0gX91IaiTOa1Q/eEXInk3Ws63FLMxP
         mOQpXgYlF0P2WMkp2vG7HhrLbz76tlGQ4TiVlepaZLLVbzjAEzyBY/Bne0LiSYRVv/OI
         eh5CIFWUYth0qkfFgKZp/oYgFFGTJnbEmol6t9Jx5Yzj7wKxcYWsS8b6aAYMNyPkhM9o
         Ym6u6z3n8GSnEBHhYJYzkLiZ9IrUz/6IQ3CBH45Z16VDXcNSGWcLQw8+M0IeogQQNsgH
         QPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UtUIqChNwIGiM6BzTSKzlQEWchWVUYsbZYtiHQAXLaI=;
        b=OpFckQnrijzhw9r4o199MfpCeSISIDTbhamH0oNPUQu5t8lXoUfQ4iyT0vRK7ufH/p
         4htJ5F11sGbc1q5iuy1dtiWxfKyDrnqsBMvzunI1aXlwEMq+V0ojiFTB8eEy5bTaNzHR
         OZlRUaf2qEY7234Y62A01ejkm/WJhSl/x3Q2ahRznr1Xgs6VnMDzWUVeL1CeuekTRUoH
         vo7sL76mXK91ZhuxsTd8wXgi037npQ8ZP8uZGJLTkyEhR5WhTRxmMtz3HqbuwqCZmyln
         /nVrwLcMpPJh9iuWLwOOUI3bKh3PSy9bjdMIypavDRNfZ52vcl6bTfPvkWy6SJBIO5fk
         iqYg==
X-Gm-Message-State: AOAM533dOccnLZrR0SKv8wicL93yJHfR0FwmpHzassoY4YxLqjSm1ZhD
        C79NiUTe1V774kVmwnKWpNU=
X-Google-Smtp-Source: ABdhPJzQlWf7mMBYOZ5bO2uklD2VXAdI3sKQf9qb/biLCDQ5fHBF8fvZxPrTckH9bkE37eRy7vCfnA==
X-Received: by 2002:a63:4005:0:b0:373:9ac7:fec1 with SMTP id n5-20020a634005000000b003739ac7fec1mr26990808pga.12.1646249655409;
        Wed, 02 Mar 2022 11:34:15 -0800 (PST)
Received: from ast-mbp.dhcp.thefacebook.com ([2620:10d:c090:500::2:156b])
        by smtp.gmail.com with ESMTPSA id d5-20020a17090acd0500b001b9c05b075dsm5861616pju.44.2022.03.02.11.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 11:34:15 -0800 (PST)
Date:   Wed, 2 Mar 2022 11:34:11 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
        Tejun Heo <tj@kernel.org>, joshdon@google.com, sdf@google.com,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
Message-ID: <20220302193411.ieooguqoa6tpraoe@ast-mbp.dhcp.thefacebook.com>
References: <20220225234339.2386398-1-haoluo@google.com>
 <20220225234339.2386398-2-haoluo@google.com>
 <20220227051821.fwrmeu7r6bab6tio@apollo.legion>
 <CA+khW7g4mLw9W+CY651FaE-2SF0XBeaGKa5Le7ZnTBTK7eD30Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+khW7g4mLw9W+CY651FaE-2SF0XBeaGKa5Le7ZnTBTK7eD30Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 28, 2022 at 02:10:39PM -0800, Hao Luo wrote:
> Hi Kumar,
> 
> On Sat, Feb 26, 2022 at 9:18 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
> >
> > On Sat, Feb 26, 2022 at 05:13:31AM IST, Hao Luo wrote:
> > > This patch allows bpf_syscall prog to perform some basic filesystem
> > > operations: create, remove directories and unlink files. Three bpf
> > > helpers are added for this purpose. When combined with the following
> > > patches that allow pinning and getting bpf objects from bpf prog,
> > > this feature can be used to create directory hierarchy in bpffs that
> > > help manage bpf objects purely using bpf progs.
> > >
> > > The added helpers subject to the same permission checks as their syscall
> > > version. For example, one can not write to a read-only file system;
> > > The identity of the current process is checked to see whether it has
> > > sufficient permission to perform the operations.
> > >
> > > Only directories and files in bpffs can be created or removed by these
> > > helpers. But it won't be too hard to allow these helpers to operate
> > > on files in other filesystems, if we want.
> > >
> > > Signed-off-by: Hao Luo <haoluo@google.com>
> > > ---
> > > + *
> > > + * long bpf_mkdir(const char *pathname, int pathname_sz, u32 mode)
> > > + *   Description
> > > + *           Attempts to create a directory name *pathname*. The argument
> > > + *           *pathname_sz* specifies the length of the string *pathname*.
> > > + *           The argument *mode* specifies the mode for the new directory. It
> > > + *           is modified by the process's umask. It has the same semantic as
> > > + *           the syscall mkdir(2).
> > > + *   Return
> > > + *           0 on success, or a negative error in case of failure.
> > > + *
> > > + * long bpf_rmdir(const char *pathname, int pathname_sz)
> > > + *   Description
> > > + *           Deletes a directory, which must be empty.
> > > + *   Return
> > > + *           0 on sucess, or a negative error in case of failure.
> > > + *
> > > + * long bpf_unlink(const char *pathname, int pathname_sz)
> > > + *   Description
> > > + *           Deletes a name and possibly the file it refers to. It has the
> > > + *           same semantic as the syscall unlink(2).
> > > + *   Return
> > > + *           0 on success, or a negative error in case of failure.
> > >   */
> > >
> >
> > How about only introducing bpf_sys_mkdirat and bpf_sys_unlinkat? That would be
> > more useful for other cases in future, and when AT_FDCWD is passed, has the same
> > functionality as these, but when openat/fget is supported, it would work
> > relative to other dirfds as well. It can also allow using dirfd of the process
> > calling read for a iterator (e.g. if it sets the fd number using skel->bss).
> > unlinkat's AT_REMOVEDIR flag also removes the need for a bpf_rmdir.
> >
> > WDYT?
> >
> 
> The idea sounds good to me, more flexible. But I don't have a real use
> case for using the added 'dirfd' at this moment. For all the use cases
> I can think of, absolute paths will suffice, I think. Unless other
> reviewers have opposition, I will try switching to mkdirat and
> unlinkat in v2.

I'm surprised you don't need "at" variants.
I thought your production setup has a top level cgroup controller and
then inner tasks inside containers manage cgroups on their own.
Since containers are involved they likely run inside their own mountns.
cgroupfs mount is single. So you probably don't even need to bind mount it
inside containers, but bpffs is not a single mount. You need
to bind mount top bpffs inside containers for tasks to access it.
Now for cgroupfs the abs path is not an issue, but for bpffs
the AT_FDCWD becomes a problem. AT_FDCWD is using current mount ns.
Inside container that will be different. Unless you bind mount into exact
same path the full path has different meanings inside and outside of the container.
It seems to me the bpf progs attached to cgroup sleepable events should
be using FD of bpffs. Then when these tracepoints are triggered from
different containers in different mountns they will get the right dir prefix.
What am I missing?

I think non-AT variants are not needed. The prog can always pass AT_FDCWD
if it's really the intent, but passing actual FD seems more error-proof.

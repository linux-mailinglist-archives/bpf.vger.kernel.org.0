Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11364C7D12
	for <lists+bpf@lfdr.de>; Mon, 28 Feb 2022 23:10:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230302AbiB1WLd (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Feb 2022 17:11:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230133AbiB1WLc (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Feb 2022 17:11:32 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E100FC6833
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 14:10:52 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id i8so506328wrr.8
        for <bpf@vger.kernel.org>; Mon, 28 Feb 2022 14:10:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0f1W4Wc0EEoXA/hJdBQxq1Gp1glgbsbboI5sHwm0rI=;
        b=dbuCifi5i+s3laQK3MjadtEFvIaRuSFEgIgs6v+ZXKni+Uy6rtBlqfgbKbaERW/Vm1
         6qpTNdPApqL8ttGC58JdO2m32ISLCxCp9lgTqt9qHVEM5Up+KJ6s0837mtLlEEer5Jsp
         rOSTtj0S66wvuhJZPTQdev8Lo0+ur6L7tvlxGIivcI9PdXalv+tXMPK8VVVm07MRaSY+
         Xpa6gf2FjPZt7rm3pfMZsc/bYGSzbyaNjnOpJwKjfwxjese1IJa7Fb30PIGk8rXsxBzd
         GVDlAcjlEOIQzv8J5MLmfVjLTgvBWDa966RLFV0DKx+6MjGRW+1gBUbxkQLeNw+jz4iA
         f0wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0f1W4Wc0EEoXA/hJdBQxq1Gp1glgbsbboI5sHwm0rI=;
        b=6ympUxFELLDH4AN/wWugmsKo8IqUW/H8wAf8Rfby2AdOy0Fabd800hbJPnX7b3IsPw
         vmADCYOfqDkyf4QDVfAzmPkbWRvVPtpooFNp6StGp6VEhDCnjLjP3cVSlnO7SenZ2DBj
         YKMF1S2EybnaZUzVvpbRFNINWYFbkcDPqd37JP+pBWzPJx9+cd/ums7QM6b3X2EA+4Gu
         Hu3EgpXyUmQ1CIO0abY0/fD2YNL/p2m3496qqHyvk9WeOAHS1t3wm3eq6gy9JSv2gAPj
         PKAi195xL2F9Jjvs6gw8U5Khf40b5KDMPbTffdOqUXXGc9tGNUrr1V4QMPUG/qPBfLXq
         Yqfw==
X-Gm-Message-State: AOAM532GRIDIDlkVEmkyNT6xLwGZuxWtEHAMZzulIAjzBAiiybG1z7mk
        jXJFzOzWozcv9d3ymApooP48mhaoBbn92REoJ4eB+w==
X-Google-Smtp-Source: ABdhPJw6PXGJIac5rut6ZC/vWklpF7aamF7EfGb1aEh9WRRLAHsBR9tQMNEYrHisL9SdJHFVLRLoE6GVV5puGg+mONQ=
X-Received: by 2002:adf:cd04:0:b0:1f0:d63:392c with SMTP id
 w4-20020adfcd04000000b001f00d63392cmr173680wrm.489.1646086251275; Mon, 28 Feb
 2022 14:10:51 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <20220227051821.fwrmeu7r6bab6tio@apollo.legion>
In-Reply-To: <20220227051821.fwrmeu7r6bab6tio@apollo.legion>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 28 Feb 2022 14:10:39 -0800
Message-ID: <CA+khW7g4mLw9W+CY651FaE-2SF0XBeaGKa5Le7ZnTBTK7eD30Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
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
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Kumar,

On Sat, Feb 26, 2022 at 9:18 PM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> On Sat, Feb 26, 2022 at 05:13:31AM IST, Hao Luo wrote:
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
> >
> > Signed-off-by: Hao Luo <haoluo@google.com>
> > ---
> > + *
> > + * long bpf_mkdir(const char *pathname, int pathname_sz, u32 mode)
> > + *   Description
> > + *           Attempts to create a directory name *pathname*. The argument
> > + *           *pathname_sz* specifies the length of the string *pathname*.
> > + *           The argument *mode* specifies the mode for the new directory. It
> > + *           is modified by the process's umask. It has the same semantic as
> > + *           the syscall mkdir(2).
> > + *   Return
> > + *           0 on success, or a negative error in case of failure.
> > + *
> > + * long bpf_rmdir(const char *pathname, int pathname_sz)
> > + *   Description
> > + *           Deletes a directory, which must be empty.
> > + *   Return
> > + *           0 on sucess, or a negative error in case of failure.
> > + *
> > + * long bpf_unlink(const char *pathname, int pathname_sz)
> > + *   Description
> > + *           Deletes a name and possibly the file it refers to. It has the
> > + *           same semantic as the syscall unlink(2).
> > + *   Return
> > + *           0 on success, or a negative error in case of failure.
> >   */
> >
>
> How about only introducing bpf_sys_mkdirat and bpf_sys_unlinkat? That would be
> more useful for other cases in future, and when AT_FDCWD is passed, has the same
> functionality as these, but when openat/fget is supported, it would work
> relative to other dirfds as well. It can also allow using dirfd of the process
> calling read for a iterator (e.g. if it sets the fd number using skel->bss).
> unlinkat's AT_REMOVEDIR flag also removes the need for a bpf_rmdir.
>
> WDYT?
>

The idea sounds good to me, more flexible. But I don't have a real use
case for using the added 'dirfd' at this moment. For all the use cases
I can think of, absolute paths will suffice, I think. Unless other
reviewers have opposition, I will try switching to mkdirat and
unlinkat in v2.

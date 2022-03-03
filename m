Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED7A54CC57F
	for <lists+bpf@lfdr.de>; Thu,  3 Mar 2022 19:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbiCCS54 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Mar 2022 13:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234634AbiCCS5v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Mar 2022 13:57:51 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922661A29
        for <bpf@vger.kernel.org>; Thu,  3 Mar 2022 10:57:05 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id s6so2096743qtc.4
        for <bpf@vger.kernel.org>; Thu, 03 Mar 2022 10:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yS7kazZpf1WctKIduUm7SU3KoWdFaMISwpfhZK76qk4=;
        b=Nc+Q0v+PIGcbgNSKGbAhoiP4zv0ZLw9EYz+X+vcZ7eAvYAkptoELg10H+l8UiNtoQd
         zTdX1x+Dejrwn4ZSU240LOeUObpgjLNFjn6VhA87Bwir4Zd3RnU4IrPqjJPyTMqfnnbW
         TRjwEalgqsarcOi9ia2xb267aKpZApOuvMurAkWuYqQ0Wd7WIeYIAsrlvb6jxVyVX9sc
         7WNuDEZytTuZxDL7mlDkxob3dH1Y0V11qSnKIefDDmk1Xein6gXCNLxJzzqFMMynOROe
         Z2y+e7G4bGHlc4zthKwbDP8O5oo7rYFxSEazLVK2bVW1XBoMsZlxJveTaRdgTStHcJW2
         g5LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yS7kazZpf1WctKIduUm7SU3KoWdFaMISwpfhZK76qk4=;
        b=ie+Vu8RwqtuLf9RA5u+9gCHfwOU6FK2s2/NN9O3CliUiFjC9k67GbMQc8029fJ8swT
         5+9nBIji7uy7ngd+ZuUdq3wRYkit+7UJpU16B0XQP5SoMFLDWUA+MUJTph3IP5KEObAH
         G15i/oTJtnSO4YWVcjutyAso0QBMW4tgFO0w/6m5+41Y0xjA+THVsN1MFuUvCiPEwIys
         AZOp3FHwy8AUhB1dz9WJg5pMlmJesOxEVxnd19PVfSDI4Eto3Lfpp2XdSlEgswqPIv0G
         h16l9wP77s1aWPanIQK7nYD9HBiL7nlLqksL+MeN7btwQtMDlCfLHhmOmg+cEj2x8OyS
         76Fg==
X-Gm-Message-State: AOAM530nQIfJM3tEyJwyawEmcyv72nP8vvjkDFgTA73Gya5wIVRmRuO8
        3uLj/ZdodJaOLZhGl+NmFxZehdziYSWPFRJot1gk3Q==
X-Google-Smtp-Source: ABdhPJxedlbfXtoMJQMP8Jo1Mh1Laf2i0+pAwrCkSOLmzz9A1WP/B6pZotVHj++FMBJwTIhOsrUW1XQIEyA+cC81Iv0=
X-Received: by 2002:ac8:58d5:0:b0:2de:2dfc:77d3 with SMTP id
 u21-20020ac858d5000000b002de2dfc77d3mr28109007qta.168.1646333824282; Thu, 03
 Mar 2022 10:57:04 -0800 (PST)
MIME-Version: 1.0
References: <20220225234339.2386398-1-haoluo@google.com> <20220225234339.2386398-2-haoluo@google.com>
 <7e862b1c-7818-6759-caf1-962598d2c8b3@fb.com>
In-Reply-To: <7e862b1c-7818-6759-caf1-962598d2c8b3@fb.com>
From:   Hao Luo <haoluo@google.com>
Date:   Thu, 3 Mar 2022 10:56:53 -0800
Message-ID: <CA+khW7gAEL+yBmXjWO28ns5hU4oHVZrEArfepuOfy6Q1y7VDKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 1/9] bpf: Add mkdir, rmdir, unlink syscalls
 for prog_bpf_syscall
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
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

On Wed, Mar 2, 2022 at 12:55 PM Yonghong Song <yhs@fb.com> wrote:
>
>
>
> On 2/25/22 3:43 PM, Hao Luo wrote:
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
> >   include/linux/bpf.h            |   1 +
> >   include/uapi/linux/bpf.h       |  26 +++++
> >   kernel/bpf/inode.c             |   9 +-
> >   kernel/bpf/syscall.c           | 177 +++++++++++++++++++++++++++++++++
> >   tools/include/uapi/linux/bpf.h |  26 +++++
> >   5 files changed, 236 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/bpf.h b/include/linux/bpf.h
> > index f19abc59b6cd..fce5e26179f5 100644
> > --- a/include/linux/bpf.h
> > +++ b/include/linux/bpf.h
> > @@ -1584,6 +1584,7 @@ int bpf_link_new_fd(struct bpf_link *link);
> >   struct file *bpf_link_new_file(struct bpf_link *link, int *reserved_fd);
> >   struct bpf_link *bpf_link_get_from_fd(u32 ufd);
> >
> > +bool bpf_path_is_bpf_dir(const struct path *path);
> >   int bpf_obj_pin_user(u32 ufd, const char __user *pathname);
> >   int bpf_obj_get_user(const char __user *pathname, int flags);
> >
> > diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> > index afe3d0d7f5f2..a5dbc794403d 100644
> > --- a/include/uapi/linux/bpf.h
> > +++ b/include/uapi/linux/bpf.h
> > @@ -5086,6 +5086,29 @@ union bpf_attr {
> >    *  Return
> >    *          0 on success, or a negative error in case of failure. On error
> >    *          *dst* buffer is zeroed out.
> > + *
> > + * long bpf_mkdir(const char *pathname, int pathname_sz, u32 mode)
>
> Can we make pathname_sz to be u32 instead of int? pathname_sz should
> never be negative any way.
>
> Also, I think it is a good idea to add 'u64 flags' parameter for all
> three helpers, so we have room in the future to tune for new use cases.
>

SG. Will make this change.

Actually, I think I need to cap patthname_sz from above, to ensure
pathname_sz isn't too big. Is that necessary? I see there are other
helpers that don't have this type of check.

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
> >    */
> >   #define __BPF_FUNC_MAPPER(FN)               \
> >       FN(unspec),                     \
> > @@ -5280,6 +5303,9 @@ union bpf_attr {
> >       FN(xdp_load_bytes),             \
> >       FN(xdp_store_bytes),            \
> >       FN(copy_from_user_task),        \
> > +     FN(mkdir),                      \
> > +     FN(rmdir),                      \
> > +     FN(unlink),                     \
> >       /* */
> >
> >   /* integer value in 'imm' field of BPF_CALL instruction selects which helper
> [...]

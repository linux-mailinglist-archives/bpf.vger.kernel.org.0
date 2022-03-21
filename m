Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D78114E3450
	for <lists+bpf@lfdr.de>; Tue, 22 Mar 2022 00:28:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbiCUX2H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 21 Mar 2022 19:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233304AbiCUX2B (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 21 Mar 2022 19:28:01 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8FE035F191
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:24:25 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id b9so11402607ila.8
        for <bpf@vger.kernel.org>; Mon, 21 Mar 2022 16:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D2haUQ1GjLsXX9PM3Hfh9XGw56TWMfJ53nTjS8+8VGw=;
        b=l8y0F5br4MxmyWAiDca7uHiIHugE+MChtDmsU7/sMkTODFAJ1SYqrdTdvECCnHtD3A
         dkMxrFgyjfpyU5Yzhddys4LvLLgHcScMkfgcq2b7zSjHZha7EWzmU6xFIPpeCNG/z5EE
         l+qwhitOBrCg0wBgL/BtPE07+ECo2D4gHz9Rs6IpOXYTIc0dfvLiFnzDpo4qq+bdemBl
         xPUir3JpQp6tROr0xNIvnctvO5y7jK3tZ2vQE/hoNb7dBbB9uTSYykVbxO1KdICgO3CU
         +NShcUt2MRKux1KLssJhEC54DeYp5LHCdrEUREg8P33ZHuBW/uwN7Xi1bFtnc/1z8gRd
         LSqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D2haUQ1GjLsXX9PM3Hfh9XGw56TWMfJ53nTjS8+8VGw=;
        b=tBAz34W4n5Qrb6W4WVaz9TWz9oPpufMKA0u8GDpAvdui5hQXIMjGxnHazD3ZR/5lbi
         RjKStMMTWU5NUOvNE31+svPDEMZ2aUMJcL3EM9a2EnRfukKqUHDwCgjQ+l4ynJbGVlHQ
         4QYXdnmuLOHQOSvByUfmxc139LhgW9Rfi54coMoEn1VO4TJmt3JkeZpc+pcKyCf/SeXA
         iYVEumlbMupcdOsPWk2XXLcu04/Q591smSqmVXX6bPAnwFRnJIUJo5QYRDwg6R6Yssvk
         Ua+zBu7v7EpzIEA2rvRaTSC+vm3NwBNg3Za/3Ui6mA48/uLx//45fl5Q+oBcpkMyVpFR
         w/Nw==
X-Gm-Message-State: AOAM5316AH1FuVDoHAnAO5Vt/ZIYQO1dJfp4qRZ1aMwG6Nmtq7gWWJ59
        0tUKRwHEXj/VFM0bZ6CTMSMv077YU1BP/uU0OuM=
X-Google-Smtp-Source: ABdhPJxziJ63eIp0miJtwq1DbZoj12tsQJSayn5MmqyxBlutwxo/QqPfG2WvDyHWKK+hDYZd8jrkGV6cJd0QYyTd1ds=
X-Received: by 2002:a92:c568:0:b0:2c8:8dd:e8bf with SMTP id
 b8-20020a92c568000000b002c808dde8bfmr6650758ilj.98.1647905064983; Mon, 21 Mar
 2022 16:24:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220316004231.1103318-1-kuifeng@fb.com> <20220316004231.1103318-4-kuifeng@fb.com>
 <20220318191332.7qsztafrjyu7bjtc@ast-mbp>
In-Reply-To: <20220318191332.7qsztafrjyu7bjtc@ast-mbp>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 21 Mar 2022 16:24:13 -0700
Message-ID: <CAEf4BzZF02Jn3PP8LJ7oF55ogPOePt0Wt8+Dtmj5fN0r7PfU0w@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 3/4] bpf, x86: Support BPF cookie for fentry/fexit/fmod_ret.
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Kui-Feng Lee <kuifeng@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
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

On Fri, Mar 18, 2022 at 12:13 PM Alexei Starovoitov
<alexei.starovoitov@gmail.com> wrote:
>
> On Tue, Mar 15, 2022 at 05:42:30PM -0700, Kui-Feng Lee wrote:
> > Add a bpf_cookie field to attach a cookie to an instance of struct
> > bpf_link.  The cookie of a bpf_link will be installed when calling the
> > associated program to make it available to the program.
> >
> > Signed-off-by: Kui-Feng Lee <kuifeng@fb.com>
> > ---
> >  arch/x86/net/bpf_jit_comp.c    |  4 ++--
> >  include/linux/bpf.h            |  1 +
> >  include/uapi/linux/bpf.h       |  1 +
> >  kernel/bpf/syscall.c           | 11 +++++++----
> >  kernel/trace/bpf_trace.c       | 17 +++++++++++++++++
> >  tools/include/uapi/linux/bpf.h |  1 +
> >  tools/lib/bpf/bpf.c            | 14 ++++++++++++++
> >  tools/lib/bpf/bpf.h            |  1 +
> >  tools/lib/bpf/libbpf.map       |  1 +
> >  9 files changed, 45 insertions(+), 6 deletions(-)
>
> please split kernel and libbpf changes into two different patches.
>

+1

> > diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
> > index f69ce3a01385..dbbf09c84c21 100644
> > --- a/tools/lib/bpf/bpf.c
> > +++ b/tools/lib/bpf/bpf.c
> > @@ -1133,6 +1133,20 @@ int bpf_raw_tracepoint_open(const char *name, int prog_fd)
> >       return libbpf_err_errno(fd);
> >  }
> >
> > +int bpf_raw_tracepoint_cookie_open(const char *name, int prog_fd, __u64 bpf_cookie)
>
> lets introduce opts style to raw_tp_open instead.

I remember I brought this up earlier, but I forgot the outcome. What
if don't touch BPF_RAW_TRACEPOINT_OPEN and instead allow to create all
the same links through more universal BPF_LINK_CREATE command. And
only there we add bpf_cookie? There are few advantages:

1. We can separate raw_tracepoint and trampoline-based programs more
cleanly in UAPI (it will be two separate structs: link_create.raw_tp
with raw tracepoint name vs link_create.trampoline, or whatever the
name, with cookie and stuff). Remember that raw_tp won't support
bpf_cookie for now, so it would be another advantage not to promise
cookie in UAPI.

2. libbpf can be smart enough to pick either RAW_TRACEPOINT_OPEN (and
reject it if bpf_cookie is non-zero) or BPF_LINK_CREATE, depending on
kernel support. So users would need to only use bpf_link_create()
moving forward with all the backwards compatibility preserved.


>
> > +{
> > +     union bpf_attr attr;
> > +     int fd;
> > +
> > +     memset(&attr, 0, sizeof(attr));
> > +     attr.raw_tracepoint.name = ptr_to_u64(name);
> > +     attr.raw_tracepoint.prog_fd = prog_fd;
> > +     attr.raw_tracepoint.bpf_cookie = bpf_cookie;
> > +
> > +     fd = sys_bpf_fd(BPF_RAW_TRACEPOINT_OPEN, &attr, sizeof(attr));
> > +     return libbpf_err_errno(fd);
> > +}
> > +
> >  int bpf_btf_load(const void *btf_data, size_t btf_size, const struct bpf_btf_load_opts *opts)
> >  {
> >       const size_t attr_sz = offsetofend(union bpf_attr, btf_log_level);
> > diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
> > index 5253cb4a4c0a..23bebcdaf23b 100644
> > --- a/tools/lib/bpf/bpf.h
> > +++ b/tools/lib/bpf/bpf.h
> > @@ -477,6 +477,7 @@ LIBBPF_API int bpf_prog_query(int target_fd, enum bpf_attach_type type,
> >                             __u32 query_flags, __u32 *attach_flags,
> >                             __u32 *prog_ids, __u32 *prog_cnt);
> >  LIBBPF_API int bpf_raw_tracepoint_open(const char *name, int prog_fd);
> > +LIBBPF_API int bpf_raw_tracepoint_cookie_open(const char *name, int prog_fd, __u64 bpf_cookie);
> >  LIBBPF_API int bpf_task_fd_query(int pid, int fd, __u32 flags, char *buf,
> >                                __u32 *buf_len, __u32 *prog_id, __u32 *fd_type,
> >                                __u64 *probe_offset, __u64 *probe_addr);
> > diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> > index df1b947792c8..20f947a385fa 100644
> > --- a/tools/lib/bpf/libbpf.map
> > +++ b/tools/lib/bpf/libbpf.map
> > @@ -434,6 +434,7 @@ LIBBPF_0.7.0 {
> >               bpf_xdp_detach;
> >               bpf_xdp_query;
> >               bpf_xdp_query_id;
> > +             bpf_raw_tracepoint_cookie_open;

this (if still needed) should go into 0.8.0 section

> >               libbpf_probe_bpf_helper;
> >               libbpf_probe_bpf_map_type;
> >               libbpf_probe_bpf_prog_type;
> > --
> > 2.30.2
> >
>
> --

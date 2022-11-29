Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB75563B9BF
	for <lists+bpf@lfdr.de>; Tue, 29 Nov 2022 07:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235355AbiK2GUt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 01:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235397AbiK2GUq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 01:20:46 -0500
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2512531EC8
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 22:20:45 -0800 (PST)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-3b5d9050e48so126527877b3.2
        for <bpf@vger.kernel.org>; Mon, 28 Nov 2022 22:20:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=6zF97yhZ3lac4VKURksYb9ObamSTItMZiDW3YpTvMVY=;
        b=SZF0cK7OKUxpxokaL6z7IAK5fIt+sSVAA6EkH4WuRXsvLSEOuOxK5YnGOo5vHLD4yu
         Skviwxmg60tXGa1wnl2nJp/Y8wOFSXzT2FKSdn97eT3kRayux+ctW4GyDa4fhwZpspOq
         tXpRQ3ppY+hqdPXu64yKQAA0v4iu6/JZFJHcuD5sClyCYyDg5AyCKo44LsT96NAKUmz9
         bAki9CcL4woO5LQYdgkbWQa9tcpX1AUDmaSL+6APeq8hUBBrlzOz5iVakzDcL94khGhK
         qxQaj0xw7+V+p2YHVZDTGaBwsgYkHvN7ipna/wKPIHtWru6juHQEwBa9Jlk5GH4+cgLi
         d/3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6zF97yhZ3lac4VKURksYb9ObamSTItMZiDW3YpTvMVY=;
        b=c7Nmw6hun9qAIraxFuD1XSSdAR7U8v2U3uVqnJHQdJMiTdn3qG3kG9wQZ8Pfy1rCDl
         1Ds/jJaIrCbY0+zvJbB6ipc3mpRpwHpFgpMoKFvWy61ljdgyajjqf/b0g5MJWhoT3rby
         3KKtBkqHnef7xoSCJJiIxEFsQK8iL8lNHmvNczjicjabCAQ1kPwyRnXEyQ81XibmvJM3
         c8qMAW8Ro5KICqsOTPA7RaLKVxhKQUglXJgWad668nkydEtMFP/0Wg7Y0B9xrRMFfcOe
         MFmnH5GfCW65e+iukaKT15VT8jy6P1923zhBIJ8bVKQpxDq4o23BeY/3fFe0Wr+ami/p
         ruOg==
X-Gm-Message-State: ANoB5pnyISXTrSwqCVkucT0gwNYfQW9mPfHs7trUk/cLJaj98SLhBZCg
        4wS+CpWAak+qIuXdFos68Ne8MY+tob7DfJoyaHePEQ==
X-Google-Smtp-Source: AA0mqf4l7xt0/DChnRw3kJvhtSzShkDMLlVYWRDKuXJwCK7DSyN+EpA0+vhUwHzxnVeAgbRiBN1JfxbLOk7IQr/Fr2g=
X-Received: by 2002:a81:4f54:0:b0:3c0:d2aa:baac with SMTP id
 d81-20020a814f54000000b003c0d2aabaacmr12845854ywb.391.1669702844218; Mon, 28
 Nov 2022 22:20:44 -0800 (PST)
MIME-Version: 1.0
References: <20221128132915.141211-1-jolsa@kernel.org> <20221128132915.141211-3-jolsa@kernel.org>
 <CAEf4BzaZCUoxN_X2ALXwQeFTCwtL17R4P_B_-hUCcidfyO2xyQ@mail.gmail.com>
In-Reply-To: <CAEf4BzaZCUoxN_X2ALXwQeFTCwtL17R4P_B_-hUCcidfyO2xyQ@mail.gmail.com>
From:   Hao Luo <haoluo@google.com>
Date:   Mon, 28 Nov 2022 22:20:33 -0800
Message-ID: <CA+khW7gAYHmoUkq0UqTiZjdOqARLG256USj3uFwi6z_FyZf31w@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/4] bpf: Add bpf_vma_build_id_parse function
 and kfunc
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 5:15 PM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Mon, Nov 28, 2022 at 5:29 AM Jiri Olsa <jolsa@kernel.org> wrote:
> >
> > Adding bpf_vma_build_id_parse function to retrieve build id from
> > passed vma object and making it available as bpf kfunc.
>
> As a completely different way of solving this problem of retrieving
> build_id for tracing needs, can we teach kernel itself to parse and
> store build_id (probably gated behind Kconfig option) in struct file
> (ideally)? On exec() and when mmap()'ing with executable permissions,
> Linux kernel will try to fetch build_id from ELF file and if
> successful store it in struct file. Given build_id can be up to 20
> bytes (currently) and not each struct file points to executable, we
> might want to only add a pointer field to `struct file` itself, which,
> if build_id is present, will point to
>
> struct build_id {
>     char sz;
>     char data[];
> };
>
> This way we don't increase `struct file` by much.
>
> And then any BPF program would be able to easily probe_read_kernel
> such build_id from vma_area_struct->vm_file->build_id?
>
> I'm sure I'm oversimplifying, but this seems like a good solution for
> all kinds of profiling BPF programs without the need to maintain all
> these allowlists and adding new helpers/kfuncs?
>
> I know Hao was looking at the problem of getting build_id, I'm curious
> if something like this would work for their use cases as well?
>

This helps a little. We would like to get build_id reliably. There are
two problems we encountered.

First, sometimes we need to get build_id from an atomic context. We
fail to get build_id if the page that contains the build_id has been
evicted from pagecache. Storing the build_id in `struct file` or
`struct inode` is a good and natural solution. But, this problem can
also be solved by using mlock to pin the page in memory. We are using
mlock, it seems to be working well right now.

The other problem we encountered may be very specific to our own use
case. Sometimes we execute code that is mapped in an anonymous page
(not backed by file). In that case, we can't get build_id either. What
we are doing right now is writing the build_id into the
vm_area_struct->anon_name field and teach build_id_parse to try
parsing from there, when seeing an anonymous page. I can send this
with upstream if there are other users who have the same problem.

>
> >
> > We can't use build_id_parse directly as kfunc, because we would
> > not have control over the build id buffer size provided by user.
> >
> > Instead we are adding new bpf_vma_build_id_parse function with
> > 'build_id__sz' argument that instructs verifier to check for the
> > available space in build_id buffer.
> >
> > This way we check that there's always available memory space
> > behind build_id pointer. We also check that the build_id__sz is
> > at least BUILD_ID_SIZE_MAX so we can place any buildid in.
> >
> > The bpf_vma_build_id_parse kfunc is marked as KF_TRUSTED_ARGS,
> > so it can be only called with trusted vma objects. These are
> > currently provided only by find_vma callback function and
> > task_vma iterator program.
> >
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  include/linux/bpf.h      |  4 ++++
> >  kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
> >  2 files changed, 35 insertions(+)
> >
>
> [...]

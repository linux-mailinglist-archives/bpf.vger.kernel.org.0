Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85CF163CC84
	for <lists+bpf@lfdr.de>; Wed, 30 Nov 2022 01:35:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbiK3Af2 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 29 Nov 2022 19:35:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiK3Af0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 29 Nov 2022 19:35:26 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6D44A9C4
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 16:35:21 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id a16so547158edb.9
        for <bpf@vger.kernel.org>; Tue, 29 Nov 2022 16:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ZDbuuf2b5Szkr+2ehM4rLFxHMCGLYuKB0dkx4VosbYs=;
        b=htdVjgKhY9ETWTwmIwvSLvsfdXgxI3q86LRMnGDYDrmCVXTHgbKSkXWOiV2lBZpSZS
         1aUt4mbuOSyuYl/K1iv1/QtIFNV12PXDcNl8SaXhvU0/OLw3bmIWx1swZIC3juI2yixG
         /b2026CJ3teVsv2NczzsrjLXKCMQFSsSfItO5Qlu/swVAYI+Ifb1SW+npSXwED+9ACY4
         FGCZcRiyZlTrxfeEIinYwwnUCcO1uam8LaRFesCo3FrF5ZDl5W1ga0PlZxm5+hFChG8E
         0iYG3NsbqxhGWQ38BXS0HhKIGVaVovxB4ve4rwfY+OOHsp5dJQFiFvHsCuH7PfHf5XP5
         Pzew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZDbuuf2b5Szkr+2ehM4rLFxHMCGLYuKB0dkx4VosbYs=;
        b=vME2bl989L4PIgdmcWCcbA8Kki2FgvN7S84XQYc20LhjIKV8dAztgbxbWp+r/RtTXk
         okFy40AkOeS1hdpaH90TuIcVMnjIRyYFSn7KgPcl1hZcPJrgbFEK+vGDC0f2Pu0zH91r
         ESECh2yT/UQsCgMN5hqwfacZ4oLudowoMKANJGmStI2eApkznhu6DvciH78YR7VPv1Hq
         etqz3tDaqhlEymrDGxC2P19g2MwE++0zZMnbH7TcMB10hXwX03j0LjvPe1hp4WYGH64s
         0jvTtEJvpG1hzGHsoClIez9Niih79Oi4QgCu/WSjbRFUfAziHxNrBf7LyGQC8uq5snKl
         Ew/g==
X-Gm-Message-State: ANoB5pmov1kcHD/Bq8H8UfJrp6+ygSDJn89DfLBqD4XcQ0zNjpM/0KfD
        Tqj1TQXl5L9wd+t/kNuhzvps6Xv7qHVY+R+4sA+euOmB
X-Google-Smtp-Source: AA0mqf6hrFBL27sbbyqUdIvdvDFGe2SEfl31g/YpFfQ0CgBplZcf5BTjrYvM2hQvnTqX9vkT3/RJgQx9q5hNBA7OAfs=
X-Received: by 2002:a05:6402:2421:b0:461:524f:a8f4 with SMTP id
 t33-20020a056402242100b00461524fa8f4mr53415545eda.260.1669768520302; Tue, 29
 Nov 2022 16:35:20 -0800 (PST)
MIME-Version: 1.0
References: <20221128132915.141211-1-jolsa@kernel.org> <20221128132915.141211-3-jolsa@kernel.org>
 <CAEf4BzaZCUoxN_X2ALXwQeFTCwtL17R4P_B_-hUCcidfyO2xyQ@mail.gmail.com> <CA+khW7gAYHmoUkq0UqTiZjdOqARLG256USj3uFwi6z_FyZf31w@mail.gmail.com>
In-Reply-To: <CA+khW7gAYHmoUkq0UqTiZjdOqARLG256USj3uFwi6z_FyZf31w@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 29 Nov 2022 16:35:08 -0800
Message-ID: <CAEf4Bza6R2uedPiKi_FXMPOVe-WGS5LO-EbBzpqK9T-xCybS5Q@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/4] bpf: Add bpf_vma_build_id_parse function
 and kfunc
To:     Hao Luo <haoluo@google.com>
Cc:     Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Nov 28, 2022 at 10:20 PM Hao Luo <haoluo@google.com> wrote:
>
> On Mon, Nov 28, 2022 at 5:15 PM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Mon, Nov 28, 2022 at 5:29 AM Jiri Olsa <jolsa@kernel.org> wrote:
> > >
> > > Adding bpf_vma_build_id_parse function to retrieve build id from
> > > passed vma object and making it available as bpf kfunc.
> >
> > As a completely different way of solving this problem of retrieving
> > build_id for tracing needs, can we teach kernel itself to parse and
> > store build_id (probably gated behind Kconfig option) in struct file
> > (ideally)? On exec() and when mmap()'ing with executable permissions,
> > Linux kernel will try to fetch build_id from ELF file and if
> > successful store it in struct file. Given build_id can be up to 20
> > bytes (currently) and not each struct file points to executable, we
> > might want to only add a pointer field to `struct file` itself, which,
> > if build_id is present, will point to
> >
> > struct build_id {
> >     char sz;
> >     char data[];
> > };
> >
> > This way we don't increase `struct file` by much.
> >
> > And then any BPF program would be able to easily probe_read_kernel
> > such build_id from vma_area_struct->vm_file->build_id?
> >
> > I'm sure I'm oversimplifying, but this seems like a good solution for
> > all kinds of profiling BPF programs without the need to maintain all
> > these allowlists and adding new helpers/kfuncs?
> >
> > I know Hao was looking at the problem of getting build_id, I'm curious
> > if something like this would work for their use cases as well?
> >
>
> This helps a little. We would like to get build_id reliably. There are
> two problems we encountered.
>
> First, sometimes we need to get build_id from an atomic context. We
> fail to get build_id if the page that contains the build_id has been
> evicted from pagecache. Storing the build_id in `struct file` or
> `struct inode` is a good and natural solution. But, this problem can
> also be solved by using mlock to pin the page in memory. We are using
> mlock, it seems to be working well right now.

This is hardly a generic solution, as it requires instrumenting every
application to do this, right? So what I'm proposing is exactly to
avoid having each individual application do something special just to
allow profiling tools to capture build_id.

>
> The other problem we encountered may be very specific to our own use
> case. Sometimes we execute code that is mapped in an anonymous page
> (not backed by file). In that case, we can't get build_id either. What
> we are doing right now is writing the build_id into the
> vm_area_struct->anon_name field and teach build_id_parse to try
> parsing from there, when seeing an anonymous page. I can send this
> with upstream if there are other users who have the same problem.
>

Is this due to remapping some binary onto huge pages?

But regardless, your custom BPF applications can fetch this build_id
from vm_area_struct->anon_name in pure BPF code, can't it? Why do you
need to modify in-kernel build_id_parse implementation?

> >
> > >
> > > We can't use build_id_parse directly as kfunc, because we would
> > > not have control over the build id buffer size provided by user.
> > >
> > > Instead we are adding new bpf_vma_build_id_parse function with
> > > 'build_id__sz' argument that instructs verifier to check for the
> > > available space in build_id buffer.
> > >
> > > This way we check that there's always available memory space
> > > behind build_id pointer. We also check that the build_id__sz is
> > > at least BUILD_ID_SIZE_MAX so we can place any buildid in.
> > >
> > > The bpf_vma_build_id_parse kfunc is marked as KF_TRUSTED_ARGS,
> > > so it can be only called with trusted vma objects. These are
> > > currently provided only by find_vma callback function and
> > > task_vma iterator program.
> > >
> > > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > > ---
> > >  include/linux/bpf.h      |  4 ++++
> > >  kernel/trace/bpf_trace.c | 31 +++++++++++++++++++++++++++++++
> > >  2 files changed, 35 insertions(+)
> > >
> >
> > [...]

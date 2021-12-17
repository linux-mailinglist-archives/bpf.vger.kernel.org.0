Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 663E94781B8
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbhLQAlb (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:41:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhLQAlb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 16 Dec 2021 19:41:31 -0500
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81B3C061574
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:41:30 -0800 (PST)
Received: by mail-yb1-xb2d.google.com with SMTP id f9so1679766ybq.10
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1LlZ5R4h1d1GIqJ+mJOj16sptdUzxjCZqqBtfhQptt0=;
        b=HMpXh9cbRtZV5vIdoUMe2hHkOpUXtKv92Pjwc62+5e58HH1P6NyKss4Lsi1apLBTQ8
         DL/lQZqK/mP/VuPN2quL6IEdAaNxBgUHWa/or7Mnw58sc0wbYdH1ZWn43w77JfIwMtFm
         JrOS2ZL3kI9sBAG0kcx0Ialdsggzjhw9qPqgBQz18P97zHa9Mo83riD95CX6kPJZIquT
         VwAepEwgwVmIBkTNinFBJjMEljmr6vR0s08ryM/PvF59plSnbKGld0NNxF+LDF4lxkHQ
         0f4RxTkkFP+wZ70Qqr2pH1yT1c0dZCN9zJmDwJ/1gebuPcgUwqVTCVFru9+elAptTAwx
         zGNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1LlZ5R4h1d1GIqJ+mJOj16sptdUzxjCZqqBtfhQptt0=;
        b=SLlJrHuCa+SP8k7a+t9kWISlD8icRFZn9AIVrqcZg++CAYhgPl/maaJ/rii4BP2ikc
         CBBhNa7IfJPXYcW/8zZ26WamqBK+VdDjnNWjCUzqS1ow3Av3xIJiH8R72R3o6w4fFCD6
         kKb+G0LdywYa1UokmET+EGzQQBMQcOsMsfNxby3Ybodee/hVRm8nQdt0ifYDQ6CZegwg
         b7qKSCiw0bp1WifyeKWw+sCCUeI70MClU+P8R9vUVUQ4I/GijPBwxzhqXdXo89skUVJf
         e0JVSypuYYPt197kKDkkwhyUih2Wv57UW9WWuDUi6TR23VFIBZSYsEkc84tnut5mQlZ8
         ORMg==
X-Gm-Message-State: AOAM532fzY5fFXsvUrJFNcpdPBBFz4YjhLT2DBp0Cl1+257aSfYkd3hC
        qZnDnxk4o9a4LRJM4xtaYBuPBmAWDroOsU6Iwpw=
X-Google-Smtp-Source: ABdhPJwy9bsBxv/XLjcva4uWQ36zoqRmRNEydrWfabAiFXiix1AmYmy7EFU8r21jUxLS0f9TfEDPkMT7r1Kbee2aEws=
X-Received: by 2002:a25:3c9:: with SMTP id 192mr960803ybd.766.1639701690025;
 Thu, 16 Dec 2021 16:41:30 -0800 (PST)
MIME-Version: 1.0
References: <20211216070442.1492204-1-andrii@kernel.org> <20211216070442.1492204-2-andrii@kernel.org>
 <587861ab-e072-c448-c649-ddc6e51353d6@fb.com>
In-Reply-To: <587861ab-e072-c448-c649-ddc6e51353d6@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 16 Dec 2021 16:41:18 -0800
Message-ID: <CAEf4BzYpxJKcXH9DGDT0J=f2jFa+_tAabz2j2+_kfYtdzcrkdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 1/3] libbpf: rework feature-probing APIs
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>, Julia Kartseva <hex@fb.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Dec 16, 2021 at 4:10 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
>
> On 12/16/21 2:04 AM, Andrii Nakryiko wrote:
> > Create three extensible alternatives to inconsistently named
> > feature-probing APIs:
> >   - libbpf_probe_bpf_prog_type() instead of bpf_probe_prog_type();
> >   - libbpf_probe_bpf_map_type() instead of bpf_probe_map_type();
> >   - libbpf_probe_bpf_helper() instead of bpf_probe_helper().
> >
> > Set up return values such that libbpf can report errors (e.g., if some
> > combination of input arguments isn't possible to validate, etc), in
> > addition to whether the feature is supported (return value 1) or not
> > supported (return value 0).
> >
> > Also schedule deprecation of those three APIs. Also schedule deprecation
> > of bpf_probe_large_insn_limit().
> >
> > Also fix all the existing detection logic for various program and map
> > types that never worked:
> >   - BPF_PROG_TYPE_LIRC_MODE2;
> >   - BPF_PROG_TYPE_TRACING;
> >   - BPF_PROG_TYPE_LSM;
> >   - BPF_PROG_TYPE_EXT;
> >   - BPF_PROG_TYPE_SYSCALL;
> >   - BPF_PROG_TYPE_STRUCT_OPS;
> >   - BPF_MAP_TYPE_STRUCT_OPS;
> >   - BPF_MAP_TYPE_BLOOM_FILTER.
> >
> > Above prog/map types needed special setups and detection logic to work.
> > Subsequent patch adds selftests that will make sure that all the
> > detection logic keeps working for all current and future program and map
> > types, avoiding otherwise inevitable bit rot.
> >
> >   [0] Closes: https://github.com/libbpf/libbpf/issues/312
> >
> > Cc: Dave Marchevsky <davemarchevsky@fb.com>
> > Cc: Julia Kartseva <hex@fb.com>
> > Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> > ---
>
> [...]
>
> > diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
> > index 4bdec69523a7..65232bcaa84c 100644
> > --- a/tools/lib/bpf/libbpf_probes.c
> > +++ b/tools/lib/bpf/libbpf_probes.c
>
> [...]
>
> > @@ -84,6 +92,38 @@ probe_load(enum bpf_prog_type prog_type, const struct bpf_insn *insns,
> >       case BPF_PROG_TYPE_KPROBE:
> >               opts.kern_version = get_kernel_version();
> >               break;
> > +     case BPF_PROG_TYPE_LIRC_MODE2:
> > +             opts.expected_attach_type = BPF_LIRC_MODE2;
> > +             break;
> > +     case BPF_PROG_TYPE_TRACING:
> > +     case BPF_PROG_TYPE_LSM:
> > +             opts.log_buf = buf;
> > +             opts.log_size = sizeof(buf);
> > +             opts.log_level = 1;
> > +             if (prog_type == BPF_PROG_TYPE_TRACING)
> > +                     opts.expected_attach_type = BPF_TRACE_FENTRY;
> > +             else
> > +                     opts.expected_attach_type = BPF_MODIFY_RETURN;
> > +             opts.attach_btf_id = 1;
> > +
> > +             exp_err = -EINVAL;
> > +             exp_msg = "attach_btf_id 1 is not a function";
> > +             break;
> > +     case BPF_PROG_TYPE_EXT:
> > +             opts.log_buf = buf;
> > +             opts.log_size = sizeof(buf);
> > +             opts.log_level = 1;
> > +             opts.attach_btf_id = 1;
> > +
> > +             exp_err = -EINVAL;
> > +             exp_msg = "Cannot replace kernel functions";
> > +             break;
> > +     case BPF_PROG_TYPE_SYSCALL:
> > +             opts.prog_flags = BPF_F_SLEEPABLE;
> > +             break;
> > +     case BPF_PROG_TYPE_STRUCT_OPS:
> > +             exp_err = -524; /* -EOPNOTSUPP */
>
> Why not use the ENOTSUPP macro here, and elsewhere in this patch?

ENOTSUPP is kernel-internal code, so there is no #define ENOTSUPP
available to user-space applications.

> Also, maybe the comment in this particular instance is incorrect?
> (EOPNOTSUPP -> ENOTSUPP)

Yeah, I seem to constantly mess up comments. It should be -ENOTSUPP.

>
> > +             break;
> >       case BPF_PROG_TYPE_UNSPEC:
> >       case BPF_PROG_TYPE_SOCKET_FILTER:
> >       case BPF_PROG_TYPE_SCHED_CLS:
>
> [...]
>
> > +int libbpf_probe_bpf_helper(enum bpf_prog_type prog_type, enum bpf_func_id helper_id,
> > +                         const void *opts)
> > +{
> > +     struct bpf_insn insns[] = {
> > +             BPF_EMIT_CALL((__u32)helper_id),
> > +             BPF_EXIT_INSN(),
> > +     };
> > +     const size_t insn_cnt = ARRAY_SIZE(insns);
> > +     char buf[4096];
> > +     int ret;
> > +
> > +     if (opts)
> > +             return libbpf_err(-EINVAL);
> > +
> > +     /* we can't successfully load all prog types to check for BPF helper
> > +      * support, so bail out with -EOPNOTSUPP error
> > +      */
> > +     switch (prog_type) {
> > +     case BPF_PROG_TYPE_TRACING:
> > +     case BPF_PROG_TYPE_EXT:
> > +     case BPF_PROG_TYPE_LSM:
> > +     case BPF_PROG_TYPE_STRUCT_OPS:
> > +             return -EOPNOTSUPP;
> > +     default:
> > +             break;
> > +     }
> > +
> > +     buf[0] = '\0';
> > +     ret = probe_prog_load(prog_type, insns, insn_cnt, buf, sizeof(buf), 0);
> > +     if (ret < 0)
> > +             return libbpf_err(ret);
> > +
> > +     /* If BPF verifier doesn't recognize BPF helper ID (enum bpf_func_id)
> > +      * at all, it will emit something like "invalid func unknown#181".
> > +      * If BPF verifier recognizes BPF helper but it's not supported for
> > +      * given BPF program type, it will emit "unknown func bpf_sys_bpf#166".
> > +      * In both cases, provided combination of BPF program type and BPF
> > +      * helper is not supported by the kernel.
> > +      * In all other cases, probe_prog_load() above will either succeed (e.g.,
> > +      * because BPF helper happens to accept no input arguments or it
> > +      * accepts one input argument and initial PTR_TO_CTX is fine for
> > +      * that), or we'll get some more specific BPF verifier error about
> > +      * some unsatisfied conditions.
> > +      */
> > +     if (ret == 0 && (strstr(buf, "invalid func ") || strstr(buf, "unknown func ")))
> > +             return 0;
>
> Maybe worth adding a comment where these are logged in verifier.c, so that if
> format is changed or a less brittle way of conveying this info is added, this
> fn can be updated.

Not sure I want to point out that this is done in verifier.c
specifically. What if that code is moved somewhere else? Seems like a
bit too detailed and specific comment to add. I was hoping the above
big comment explains what we do here, thought?

As for the need to change this, with selftests I added we'll get
immediate selftests failure, so this won't bit rot and we'll be always
aware when the detection breaks.

>
> > +     return 1; /* assume supported */
> >  }
> >
>
> [...]

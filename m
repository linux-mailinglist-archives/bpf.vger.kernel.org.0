Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5026E494545
	for <lists+bpf@lfdr.de>; Thu, 20 Jan 2022 02:02:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230426AbiATBB4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 19 Jan 2022 20:01:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240710AbiATBB4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 19 Jan 2022 20:01:56 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF6E5C061574;
        Wed, 19 Jan 2022 17:01:55 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id x15so3762204ilc.5;
        Wed, 19 Jan 2022 17:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tgFIDNZGxcD+cxOGJIv6yrYTTSso13PAlw1HHHnn78o=;
        b=jap48ZBRTMOGXP19WpQPTprNul1uSVpvGY+0g3T9ZMRGJYsZ9dIYniW49ajcQZoOR+
         DMZ+9KyiGxOv02NnlMgu8QF3m5JGBP89++6aTLhPESAT36oAeUTCe8svLjk/XDeVXvww
         7befEqatdwxVbEm24jZlKFt6rhPkUiw1RubMlGjjo61Ly2a0GMsbmHWICZsnorBM+Hte
         VKtXUeg+qoTh0PlW9q4bPa0vhl0/Byc9EovSK8XbJnfxVxL1uR1pNVyjT/IYyNPnKyok
         Cpj3Vds2+rbJ4ZymDr4vNVsCDXBbVddiFHqEVY7MHDEiZ3hT9F3PqEnVqRr7TzDMF2+T
         NtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tgFIDNZGxcD+cxOGJIv6yrYTTSso13PAlw1HHHnn78o=;
        b=MTCRniNa+4tz55lX0CPDODbESVWFuhJjalktBt+qNeSgk96N8djNsExWRb9pJ3ftF5
         n16SUU/sO0k/ohuZ/6i+e9fd5hhw31wjJLfnfi0iBWUPrzOsdSMBZ4pkCls7R6/Yt07U
         Wv0kWCf2DGXHqcpWxrrGj/f9wP3CADPR7ziruv3Ecx7ImEzGhJz/4Pd718zxqhfYDcmC
         koZ1Di1qd10loGJb3okiP5jVaJKjD/1LtGsjf728Nr2vZqhbtbhBvJnQzElyLaRKCeSB
         NiIFjKkcQlT3gwi3sA0TsexRvOJM+NpK7oGMYyc//omCUjuHtV70Bvg49H/Ox080+iEp
         YwOQ==
X-Gm-Message-State: AOAM531wOWqDZCr1rlTuS3f2JYX9w+tiyOm5LQ8cF+1ikg/lNMdBOPfm
        fXMrlZy+F9Kx+ISVfIyj6OEbnyfFrm0907R3A+k=
X-Google-Smtp-Source: ABdhPJyVHI6GVNxFtry1caSOHafz0BUg+Wuj0oTa+JHvekWWPEB62P/I64tJTZ1rB9TjBcRsRdmtoHM3Cq50Mdt60VA=
X-Received: by 2002:a05:6e02:1c01:: with SMTP id l1mr2461686ilh.239.1642640515183;
 Wed, 19 Jan 2022 17:01:55 -0800 (PST)
MIME-Version: 1.0
References: <20220119230636.1752684-1-christylee@fb.com> <20220119230636.1752684-2-christylee@fb.com>
 <C02B00A0-5760-44CE-B727-90CF601A8437@fb.com> <CAEf4BzaoqsxOvYsPjC4RX-mL+HsgEP=GsnS5fKm0UZsYvY=Sjw@mail.gmail.com>
 <D753C41C-A70A-4316-8201-9F8369D1E627@fb.com>
In-Reply-To: <D753C41C-A70A-4316-8201-9F8369D1E627@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 19 Jan 2022 17:01:43 -0800
Message-ID: <CAEf4Bzbz231HjbgyVs-P=_tUj4XKAe9oOkxh5zpAa81bFe_cgQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 1/2] perf: stop using deprecated
 bpf_load_program() API
To:     Song Liu <songliubraving@fb.com>
Cc:     "Christy Lee-Eusman (PL&R)" <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        "christyc.y.lee@gmail.com" <christyc.y.lee@gmail.com>,
        bpf <bpf@vger.kernel.org>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        "wangnan0@huawei.com" <wangnan0@huawei.com>,
        "bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
        "yuehaibing@huawei.com" <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 19, 2022 at 3:35 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Jan 19, 2022, at 3:26 PM, Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Jan 19, 2022 at 3:20 PM Song Liu <songliubraving@fb.com> wrote:
> >>
> >>
> >>
> >>> On Jan 19, 2022, at 3:06 PM, Christy Lee <christylee@fb.com> wrote:
> >>>
> >>> bpf_load_program() API is deprecated, remove perf's usage of the
> >>> deprecated function. Add a __weak function declaration for libbpf
> >>> version compatibility.
> >>>
> >>> Signed-off-by: Christy Lee <christylee@fb.com>
> >>> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> >>
> >> Acked-by: Song Liu <songliubraving@fb.com>
> >>
> >> With one minor comment below.
> >>
> >>> ---
> >>> tools/perf/tests/bpf.c      | 14 ++++----------
> >>> tools/perf/util/bpf-event.c | 16 ++++++++++++++++
> >>> 2 files changed, 20 insertions(+), 10 deletions(-)
> >>>
> >>> diff --git a/tools/perf/tests/bpf.c b/tools/perf/tests/bpf.c
> >>> index 573490530194..57b9591f7cbb 100644
> >>> --- a/tools/perf/tests/bpf.c
> >>> +++ b/tools/perf/tests/bpf.c
> >>> @@ -281,8 +281,8 @@ static int __test__bpf(int idx)
> >>>
> >>> static int check_env(void)
> >>> {
> >>> +     LIBBPF_OPTS(bpf_prog_load_opts, opts);
> >>
> >> This changes seems unnecessary.
> >>
> >>>      int err;
> >>> -     unsigned int kver_int;
> >>>      char license[] = "GPL";
> >>>
> >>>      struct bpf_insn insns[] = {
> >>> @@ -290,19 +290,13 @@ static int check_env(void)
> >>>              BPF_EXIT_INSN(),
> >>>      };
> >>>
> >>> -     err = fetch_kernel_version(&kver_int, NULL, 0);
> >>> +     err = fetch_kernel_version(&opts.kern_version, NULL, 0);
> >
> > Opts are used here. Libbpf is now performing the same kern_version
> > extraction logic, so we might not need fetch_kernel_version() now, but
> > I'd still keep it to avoid unnecessary regressions.
>
> Yeah, I noticed opts is used. But we only use opts.kern_version
> here, which is an u32. Will this be a problem if we compile perf
> against an older libbpf? (if we ever do that).

Oh, because struct bpf_prog_load_opts might not be defined? Yes, but
there will also be a problem if linking against libbpf older than v0.6
anyways (due to the bpf_prog_load() macro overload shenanigans), so I
think libbpf 0.6 is the minimum version for perf, essentially.

>
> Thanks,
> Song
>
>
>
>

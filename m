Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6B4968E39B
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 23:50:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjBGWuo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 17:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbjBGWun (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 17:50:43 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C741EFEE;
        Tue,  7 Feb 2023 14:50:40 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id q19so18220930edd.2;
        Tue, 07 Feb 2023 14:50:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=a19ongoHR0lKc5Z2rB3GGnOVjxdQWZVAxVKvBk5S0+M=;
        b=ZJ0Q7OTnYM+Oy94s/9Skmk77bZf9qQ+yCYfNpWTwxJMZwbckg1EQpq8/KqCVguIx4V
         XVbsB3BVu29Mhh+yYgwhVyf42J/g2IlcgI7fgBduElkaJPXna0Q2YmkxDy9M/8sdzvKT
         1XlCuD5KwsB4h8mGrIeVc1jdqW5zf3fhSzZT77qyrtQvFeUGufuPDtLbd8oS/kuzR71z
         wpBCG9vPh2x5i5P/A6Qlvw3oqFwnHrBl6BiJDQmRGdvpILrKBW8ThJfjt553A6jjJDUX
         pz6fPlly3XB6sjv8tAOW6CFmkYUkYQKThkwb6eGU+ngSOvZDDWNlT707G8ts+LBFpyWx
         yO4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=a19ongoHR0lKc5Z2rB3GGnOVjxdQWZVAxVKvBk5S0+M=;
        b=cwpEebVn4oUxPrQv6RdT+vvr7x8aaM/LvCHsf/AE6e/VtzuNh3nFD902LlKHs0Ya+W
         NVmAPejlnPRRigBi7dFsDrX775vB0ha2iQ6Yq0Srb+bx9+8J0fb7/hdMTd4yRQekl+6o
         1vIci3uSf5KFN+DipXB4oE5c9GcoUehhezyafVWgIh8ZKyrMJEcfozkorpV1SBmzkWxo
         +2UgYHFe0lZjBijfza/VMStBOz4Kor4Ph3dxdsWHFqCPU/ySJ1ONzkD0xSz7R6kFlufj
         zFPHx6r2HAJrJmbCeLdV1FiTPmHX1je6Z2TpCVFz9dV4BFYPDLB0MecP11r63skN9cPI
         5xVg==
X-Gm-Message-State: AO0yUKXaCC5Vu0w82i9SoMClPvxcJBuuexhaFwbNopnoOfXi/an+4I9q
        OeFfon7XzB8nKW5Idrj3gtTFZDA/Xpy4heXMJYSu3Z2u
X-Google-Smtp-Source: AK7set/ERxgo4HCE3Z8jQMdo+dm2UKuyJs3boT0Bixkl9QsGKweZutA1CjUuz/R5pOyj//cfBwEozyjffOpakIl1OtY=
X-Received: by 2002:a05:6402:4308:b0:4aa:a516:8ea0 with SMTP id
 m8-20020a056402430800b004aaa5168ea0mr268331edc.0.1675810238927; Tue, 07 Feb
 2023 14:50:38 -0800 (PST)
MIME-Version: 1.0
References: <20230203031742.1730761-1-imagedong@tencent.com>
 <20230203031742.1730761-3-imagedong@tencent.com> <CAEf4BzYh90NyyYvfTT=M=-KLspydMX4PZK8jCwNDydAP=kFgYw@mail.gmail.com>
 <CADxym3a6_wBHW_c_ZYtZ5QXbbunhKxau6k-fn4TNrn+6qzW6fw@mail.gmail.com>
In-Reply-To: <CADxym3a6_wBHW_c_ZYtZ5QXbbunhKxau6k-fn4TNrn+6qzW6fw@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 7 Feb 2023 14:50:26 -0800
Message-ID: <CAEf4BzZAo6Bfio3pbY3j5yUDArCbdiWPC-r=XhFM9Bwq+4VVMg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add test for legacy/perf
 kprobe/uprobe attach mode
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     alan.maguire@oracle.com, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Menglong Dong <imagedong@tencent.com>
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

On Mon, Feb 6, 2023 at 6:39 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> On Tue, Feb 7, 2023 at 4:05 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Thu, Feb 2, 2023 at 7:18 PM <menglong8.dong@gmail.com> wrote:
> > >
> > > From: Menglong Dong <imagedong@tencent.com>
> > >
> > > Add the testing for kprobe/uprobe attaching in legacy and perf mode.
> > > And the testing passed:
> > >
> > > ./test_progs -t attach_probe
> > > $5       attach_probe:OK
> > > Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > >
> > > Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > ---
> >
> > Do you mind refactoring attach_probe test into multiple subtests,
> > where each subtest will only test one of the attach mode and type. The
> > reason is that libbpf CI runs tests with latest selftests and libbpf
> > against old kernels (4.9 and 5.5, currently). Due to attach_probe
> > testing all these uprobe/kprobe attach modes with extra features (like
> > cookie, ref count, etc), we had to disable attach_probe test in libbpf
> > CI on old kernels.
> >
> > If we can split each individual uprobe/kprobe mode, that will give us
> > flexibility to selectively allowlist those tests that don't force
> > libbpf to use newer features (like cookies, LINK or PERF mode, etc).
> >
> > It would be a great improvement and highly appreciated! If you don't
> > mind doing this, let's do the split of existing use cases into subtest
> > in a separate patch, and then add PERF/LEGACY/LINK mode tests on top
> > of that patch.
> >
>
> Of course, with pleasure. For the existing use cases, we split it into
> subtests, such as:
>
>   kprobe/kretprobe auto attach
>   kprobe/kretprobe manual attach
>   uprobe/uretprobe ref_ctr test
>   uprobe/uretprobe auto attach
>   sleepable kprobe/uprobe
>   ......
>
> Am I right?

I haven't analysed all the different cases, but roughly it makes
sense. With more granular subtests we can also drop `legacy` flag and
rely on subtest allowlisting in CI.

>
> Thanks!
> Dongmeng Long
>
> >
> > >  .../selftests/bpf/prog_tests/attach_probe.c   | 61 ++++++++++++++++++-
> > >  .../selftests/bpf/progs/test_attach_probe.c   | 32 ++++++++++
> > >  2 files changed, 92 insertions(+), 1 deletion(-)
> > >
> >
> > [...]

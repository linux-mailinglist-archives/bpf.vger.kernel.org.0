Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9897B690EF5
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 18:13:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbjBIRNn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 12:13:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjBIRNm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 12:13:42 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68FEF66ED5;
        Thu,  9 Feb 2023 09:13:38 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id m8so2654278edd.10;
        Thu, 09 Feb 2023 09:13:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z+Ov3XaXRvzeO63TK3217oyLNCEzuRnIKM04ym/Z/co=;
        b=R5hnYLdFauYb+iFUd+3kQcrTgL1E6nMZniQ0REuV6rS7Ia9OxAglfqRHkn9NjyR1a7
         3RQ06EWEUd7py2YMwGx4L66Ti9hMJGjY7ZBS1Luz3hDR3fz7bYn+HJYDtUbLai2tdt/d
         pWRjVGjBVU9B2eRBJBPSXkqsyNfUDA7KFodxi646Wa4RDIlfQQ1qwn02QyvLnlAORteM
         DPijxGGXvzzjGi0FQMSRnDL0S7KKikPWT7qQzK1j/TZxGvZdgqUyeKfOJ/IEdr+6+lA5
         hI+CoHqv81tjzPwBQhk6Lq5r6O3t7kA2VKMHnacmlFfdmtPYKH1feHL0LxsAWewh7uRJ
         CkiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z+Ov3XaXRvzeO63TK3217oyLNCEzuRnIKM04ym/Z/co=;
        b=zfH1DciBzZzd6pFyR1i/gQGwR4UNhdnb2PSklCy6l4UnZW3wpQiSuxk8DqriOjhUTp
         Y/RQRFjmpHms2Bx7xQzNel9FKe5DMs/rYJ99PfyKkup0hVUlJc6q+42WfncEgajqoHsW
         Uq6Qwzfq3hQL/KujrfxpqXqV8WtKRrXlP5icKdV7JtfbFuZ0zOvhBJBb8KtCJCupJulk
         48AJCR6CwPvXqoK3ePVWA6RJQzz5z9ZjGayYmp6WFuXSeKAJsla55cAkj2JEPMLIOb8N
         nxJENqp7ayj5dT2khmsfPGtheAqqxda7qiTv9rRpiITnxipqkYTV7yWsMfPEpYPNMCei
         HE+Q==
X-Gm-Message-State: AO0yUKW1ErnzbAKYc+g4RIVq1TVydEWc1gkoTwA21hVkjKK4QHo8osmv
        o4WayQ+hCV1bK/goVLNNQGI9Z5ih8lhCO23MsuM=
X-Google-Smtp-Source: AK7set+cQvw8bqTZ44P4Wog2413dySGEtLrxdcgnenr/aMxhp1YAZFMd7VDLxtDjuaKrzVuPMYMzKfwtkHSNLTp3ppk=
X-Received: by 2002:a50:9f43:0:b0:4ab:1712:b268 with SMTP id
 b61-20020a509f43000000b004ab1712b268mr881368edf.5.1675962816860; Thu, 09 Feb
 2023 09:13:36 -0800 (PST)
MIME-Version: 1.0
References: <20230203031742.1730761-1-imagedong@tencent.com>
 <20230203031742.1730761-3-imagedong@tencent.com> <CAEf4BzYh90NyyYvfTT=M=-KLspydMX4PZK8jCwNDydAP=kFgYw@mail.gmail.com>
 <CADxym3a6_wBHW_c_ZYtZ5QXbbunhKxau6k-fn4TNrn+6qzW6fw@mail.gmail.com>
 <CAEf4BzZAo6Bfio3pbY3j5yUDArCbdiWPC-r=XhFM9Bwq+4VVMg@mail.gmail.com>
 <75421c53-fa5c-d7c7-4b19-2d97e3e6d7f6@oracle.com> <CAEf4BzZicf3B7BwPj=fWkcVJz0JayB9qUUbJFBPunxOJwQoMdw@mail.gmail.com>
 <CADxym3YR6PS_0XfzH6p1CNUAbDxX=gO_aAoOu7fEkx1pAn2AKQ@mail.gmail.com>
In-Reply-To: <CADxym3YR6PS_0XfzH6p1CNUAbDxX=gO_aAoOu7fEkx1pAn2AKQ@mail.gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 9 Feb 2023 09:13:24 -0800
Message-ID: <CAEf4BzYTE8OqL5f9i1v+2OGnvgN+_Rx46yVWjqw5rAi_yFcALg@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add test for legacy/perf
 kprobe/uprobe attach mode
To:     Menglong Dong <menglong8.dong@gmail.com>
Cc:     Alan Maguire <alan.maguire@oracle.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, Menglong Dong <imagedong@tencent.com>
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

On Thu, Feb 9, 2023 at 6:08 AM Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> On Thu, Feb 9, 2023 at 7:31 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
> >
> > On Wed, Feb 8, 2023 at 3:49 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> > >
> > > On 07/02/2023 22:50, Andrii Nakryiko wrote:
> > > > On Mon, Feb 6, 2023 at 6:39 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
> > > >>
> > > >> On Tue, Feb 7, 2023 at 4:05 AM Andrii Nakryiko
> > > >> <andrii.nakryiko@gmail.com> wrote:
> > > >>>
> > > >>> On Thu, Feb 2, 2023 at 7:18 PM <menglong8.dong@gmail.com> wrote:
> > > >>>>
> > > >>>> From: Menglong Dong <imagedong@tencent.com>
> > > >>>>
> > > >>>> Add the testing for kprobe/uprobe attaching in legacy and perf mode.
> > > >>>> And the testing passed:
> > > >>>>
> > > >>>> ./test_progs -t attach_probe
> > > >>>> $5       attach_probe:OK
> > > >>>> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > > >>>>
> > > >>>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > > >>>> ---
> > > >>>
> > > >>> Do you mind refactoring attach_probe test into multiple subtests,
> > > >>> where each subtest will only test one of the attach mode and type. The
> > > >>> reason is that libbpf CI runs tests with latest selftests and libbpf
> > > >>> against old kernels (4.9 and 5.5, currently). Due to attach_probe
> > > >>> testing all these uprobe/kprobe attach modes with extra features (like
> > > >>> cookie, ref count, etc), we had to disable attach_probe test in libbpf
> > > >>> CI on old kernels.
> > > >>>
> > > >>> If we can split each individual uprobe/kprobe mode, that will give us
> > > >>> flexibility to selectively allowlist those tests that don't force
> > > >>> libbpf to use newer features (like cookies, LINK or PERF mode, etc).
> > > >>>
> > > >>> It would be a great improvement and highly appreciated! If you don't
> > > >>> mind doing this, let's do the split of existing use cases into subtest
> > > >>> in a separate patch, and then add PERF/LEGACY/LINK mode tests on top
> > > >>> of that patch.
> > > >>>
> > > >>
> > > >> Of course, with pleasure. For the existing use cases, we split it into
> > > >> subtests, such as:
> > > >>
> > > >>   kprobe/kretprobe auto attach
> > > >>   kprobe/kretprobe manual attach
> > > >>   uprobe/uretprobe ref_ctr test
> > > >>   uprobe/uretprobe auto attach
> > > >>   sleepable kprobe/uprobe
> > > >>   ......
> > > >>
> > > >> Am I right?
> > > >
> > > > I haven't analysed all the different cases, but roughly it makes
> > > > sense. With more granular subtests we can also drop `legacy` flag and
> > > > rely on subtest allowlisting in CI.
> > > >
> > >
> > > I'm probably rusty on the details, but when you talk about subtest
> > > splitting for the [uk]probe manual attach, are we talking about running
> > > the same manual attach test for the different modes, with each as a
> > > separate subtest, such that each registers as a distinct pass/fail (and
> > > can thus be allowlisted as appropriate)? So in other words
> > >
> > > test__start_subtest("manual_attach_kprobe_link");
> > > attach_kprobe_manual(link_options);
> > > test__start_subtest("manual_attach_kprobe_legacy");
> > > attach_kprobe_manual(legay_options);
> > > test__start_subtest("manual_attach_kprobe_perf");
> > > attach_kprobe_manual(perf_options);
> > >
> > > ?
> >
> > Yep. One of the reasons is that on 4.9 kernel there won't be link or
> > perf method available, so it is expected for such modes to fail. I
> > want to be able to still test the legacy code path on 4.9, though.
> > Similarly tests that are using ref_ctr_offset or bpf_cookie won't work
> > on older kernels as well. Right now because of all of them being in a
> > single test, I have to block entire test, losing coverage on older
> > kernels.
> >
>
> I think I am beginning to understand it now. So we need 2 patches
> for the selftests part. In the 1th patch, we split the existing testings
> into multi subtests, such as:
>
> test__start_subtest("manual_attach_probe") // test kprobe/uprobe manual attach
> test__start_subtest("auto_attach_probe") // test kprobe/uprobe auto attach
> test__start_subtest("bpf_cookie") // test bpf_cookie
> test__start_subtest("ref_ctr_offset") test ref_ctr_offset
> test__start_subtest("sleepable_probe") // test sleepable
> uprobe/uretprobe, and sleepable kprobe
> ......
>
> And in the 2th patch, we change the subtest "manual_attach_probe" into
> the following tests:
>
> test__start_subtest("manual_attach_kprobe_link");
> test__start_subtest("manual_attach_kprobe_legacy");
> test__start_subtest("manual_attach_kprobe_perf");
>
> Therefore, every feature can be tested in a subtest alone.
>
> Am I right?

yep, exactly!

>
> Thanks!
> Menglong Dong
> > >
> > > >>
> > > >> Thanks!
> > > >> Dongmeng Long
> > > >>
> > > >>>
> > > >>>>  .../selftests/bpf/prog_tests/attach_probe.c   | 61 ++++++++++++++++++-
> > > >>>>  .../selftests/bpf/progs/test_attach_probe.c   | 32 ++++++++++
> > > >>>>  2 files changed, 92 insertions(+), 1 deletion(-)
> > > >>>>
> > > >>>
> > > >>> [...]

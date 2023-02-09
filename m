Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6CD3690B58
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 15:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBIOIa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Feb 2023 09:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229669AbjBIOIa (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 9 Feb 2023 09:08:30 -0500
Received: from mail-yb1-xb43.google.com (mail-yb1-xb43.google.com [IPv6:2607:f8b0:4864:20::b43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E1C5D3C9;
        Thu,  9 Feb 2023 06:08:28 -0800 (PST)
Received: by mail-yb1-xb43.google.com with SMTP id x71so1551779ybg.6;
        Thu, 09 Feb 2023 06:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zTk6c7xxPoE+rwd+rpVS+Rn18/CnyngZ+h+vq3GImYA=;
        b=mMuAVI0L/O4e8lyP0mgsBY0VHx4Ld0Fo2w4jL50qICuexc5hlBgpX8vH6/LB+W7iVT
         DUz5YQfVX3A7Mwi25p3U/9vdVEVAJeMf3pmsACemtFyhnPQoHCZ0GsVwNvLpAbyQao0L
         sA73C077Kk91uiCxZ/al97biL1eS30b9I2pZElh35nF9hnn9oCsDCfYshKTWSqKeEzHe
         YrhGSQe5BtPN0UbZL8IZpB1OnssTcrKbL6YTT+X0dRdjQnnfuTfPwQ8sAu1XQ/9ppoBG
         QWx8ymsIDj2WL9iuKzRwJ43KkLV/z2VKTnQeI9m9IvtBqVYSE81YLqOJ34ZROEx+xkM5
         Z7zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zTk6c7xxPoE+rwd+rpVS+Rn18/CnyngZ+h+vq3GImYA=;
        b=jdSod7X/BpBBKMGDLHilgMMvJGPPQuMcPu57H8GHF2NtCn497WbPydgFhpe3Ng6G5t
         odov7S3LFGF61kP3bbrb4Cn+Gi6V/spdU/5T8XpNYjP7OGJkb5+HWF6T8+B70KntcOME
         L/LPZIFHTHGYIqu0vXjO+kwsA+MbpOVuoSAioNKv64iM6ZVgJj/sgJBw3E+a6c4xRDdF
         QWitUK7mFM8z/4k+kRkwbpGnKaO3v/9hq9TWJu2jtb4GYIwaWecdRTqIkFXdQzMEi5td
         lkFCs/t18xdprqm/WmVZYzPMsv7gVgsxUNMHRZOihdXdQlSh//5lVFO80pXgiO8OLK8N
         Nf0g==
X-Gm-Message-State: AO0yUKWpbIBwZs9GoffWaaV2UCpVg78Nwm+NKvdoJca5MdAXh7omrKIH
        mXvnGZKkjb57z1/pdgiziHeb/5VXKSODlNsQqp4=
X-Google-Smtp-Source: AK7set+BF8dIBnhSDmbVZKebbFLMPnR35VaCGnuFoKxHBFulMnf8WDhFJOOYtg6wGwkFZH2ju3P9h0+o2X0T4RKzzOM=
X-Received: by 2002:a25:73d1:0:b0:87e:d379:a629 with SMTP id
 o200-20020a2573d1000000b0087ed379a629mr1232996ybc.285.1675951707531; Thu, 09
 Feb 2023 06:08:27 -0800 (PST)
MIME-Version: 1.0
References: <20230203031742.1730761-1-imagedong@tencent.com>
 <20230203031742.1730761-3-imagedong@tencent.com> <CAEf4BzYh90NyyYvfTT=M=-KLspydMX4PZK8jCwNDydAP=kFgYw@mail.gmail.com>
 <CADxym3a6_wBHW_c_ZYtZ5QXbbunhKxau6k-fn4TNrn+6qzW6fw@mail.gmail.com>
 <CAEf4BzZAo6Bfio3pbY3j5yUDArCbdiWPC-r=XhFM9Bwq+4VVMg@mail.gmail.com>
 <75421c53-fa5c-d7c7-4b19-2d97e3e6d7f6@oracle.com> <CAEf4BzZicf3B7BwPj=fWkcVJz0JayB9qUUbJFBPunxOJwQoMdw@mail.gmail.com>
In-Reply-To: <CAEf4BzZicf3B7BwPj=fWkcVJz0JayB9qUUbJFBPunxOJwQoMdw@mail.gmail.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Thu, 9 Feb 2023 22:08:16 +0800
Message-ID: <CADxym3YR6PS_0XfzH6p1CNUAbDxX=gO_aAoOu7fEkx1pAn2AKQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add test for legacy/perf
 kprobe/uprobe attach mode
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
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

On Thu, Feb 9, 2023 at 7:31 AM Andrii Nakryiko
<andrii.nakryiko@gmail.com> wrote:
>
> On Wed, Feb 8, 2023 at 3:49 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >
> > On 07/02/2023 22:50, Andrii Nakryiko wrote:
> > > On Mon, Feb 6, 2023 at 6:39 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
> > >>
> > >> On Tue, Feb 7, 2023 at 4:05 AM Andrii Nakryiko
> > >> <andrii.nakryiko@gmail.com> wrote:
> > >>>
> > >>> On Thu, Feb 2, 2023 at 7:18 PM <menglong8.dong@gmail.com> wrote:
> > >>>>
> > >>>> From: Menglong Dong <imagedong@tencent.com>
> > >>>>
> > >>>> Add the testing for kprobe/uprobe attaching in legacy and perf mode.
> > >>>> And the testing passed:
> > >>>>
> > >>>> ./test_progs -t attach_probe
> > >>>> $5       attach_probe:OK
> > >>>> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> > >>>>
> > >>>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> > >>>> ---
> > >>>
> > >>> Do you mind refactoring attach_probe test into multiple subtests,
> > >>> where each subtest will only test one of the attach mode and type. The
> > >>> reason is that libbpf CI runs tests with latest selftests and libbpf
> > >>> against old kernels (4.9 and 5.5, currently). Due to attach_probe
> > >>> testing all these uprobe/kprobe attach modes with extra features (like
> > >>> cookie, ref count, etc), we had to disable attach_probe test in libbpf
> > >>> CI on old kernels.
> > >>>
> > >>> If we can split each individual uprobe/kprobe mode, that will give us
> > >>> flexibility to selectively allowlist those tests that don't force
> > >>> libbpf to use newer features (like cookies, LINK or PERF mode, etc).
> > >>>
> > >>> It would be a great improvement and highly appreciated! If you don't
> > >>> mind doing this, let's do the split of existing use cases into subtest
> > >>> in a separate patch, and then add PERF/LEGACY/LINK mode tests on top
> > >>> of that patch.
> > >>>
> > >>
> > >> Of course, with pleasure. For the existing use cases, we split it into
> > >> subtests, such as:
> > >>
> > >>   kprobe/kretprobe auto attach
> > >>   kprobe/kretprobe manual attach
> > >>   uprobe/uretprobe ref_ctr test
> > >>   uprobe/uretprobe auto attach
> > >>   sleepable kprobe/uprobe
> > >>   ......
> > >>
> > >> Am I right?
> > >
> > > I haven't analysed all the different cases, but roughly it makes
> > > sense. With more granular subtests we can also drop `legacy` flag and
> > > rely on subtest allowlisting in CI.
> > >
> >
> > I'm probably rusty on the details, but when you talk about subtest
> > splitting for the [uk]probe manual attach, are we talking about running
> > the same manual attach test for the different modes, with each as a
> > separate subtest, such that each registers as a distinct pass/fail (and
> > can thus be allowlisted as appropriate)? So in other words
> >
> > test__start_subtest("manual_attach_kprobe_link");
> > attach_kprobe_manual(link_options);
> > test__start_subtest("manual_attach_kprobe_legacy");
> > attach_kprobe_manual(legay_options);
> > test__start_subtest("manual_attach_kprobe_perf");
> > attach_kprobe_manual(perf_options);
> >
> > ?
>
> Yep. One of the reasons is that on 4.9 kernel there won't be link or
> perf method available, so it is expected for such modes to fail. I
> want to be able to still test the legacy code path on 4.9, though.
> Similarly tests that are using ref_ctr_offset or bpf_cookie won't work
> on older kernels as well. Right now because of all of them being in a
> single test, I have to block entire test, losing coverage on older
> kernels.
>

I think I am beginning to understand it now. So we need 2 patches
for the selftests part. In the 1th patch, we split the existing testings
into multi subtests, such as:

test__start_subtest("manual_attach_probe") // test kprobe/uprobe manual attach
test__start_subtest("auto_attach_probe") // test kprobe/uprobe auto attach
test__start_subtest("bpf_cookie") // test bpf_cookie
test__start_subtest("ref_ctr_offset") test ref_ctr_offset
test__start_subtest("sleepable_probe") // test sleepable
uprobe/uretprobe, and sleepable kprobe
......

And in the 2th patch, we change the subtest "manual_attach_probe" into
the following tests:

test__start_subtest("manual_attach_kprobe_link");
test__start_subtest("manual_attach_kprobe_legacy");
test__start_subtest("manual_attach_kprobe_perf");

Therefore, every feature can be tested in a subtest alone.

Am I right?

Thanks!
Menglong Dong
> >
> > >>
> > >> Thanks!
> > >> Dongmeng Long
> > >>
> > >>>
> > >>>>  .../selftests/bpf/prog_tests/attach_probe.c   | 61 ++++++++++++++++++-
> > >>>>  .../selftests/bpf/progs/test_attach_probe.c   | 32 ++++++++++
> > >>>>  2 files changed, 92 insertions(+), 1 deletion(-)
> > >>>>
> > >>>
> > >>> [...]

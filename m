Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09C4668FB2F
	for <lists+bpf@lfdr.de>; Thu,  9 Feb 2023 00:31:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbjBHXbG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 8 Feb 2023 18:31:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjBHXbG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 8 Feb 2023 18:31:06 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF9EBBAA;
        Wed,  8 Feb 2023 15:31:04 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id u22so1499006ejj.10;
        Wed, 08 Feb 2023 15:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WZ4xSQGtDTmivX4P00tlfaiaMy+3i6nGamkuws/1MpQ=;
        b=hNefvENfOyTSE5CtJfhup0Zowj7f5Zz5ahWwAZGlA1HE9pPLSzprXwnNEOPIQZSZtQ
         2o2EGyvXLT0NGF/J094PmdHDokKOFsmRLrjkL2cfE6dJ3Qox3HPqvYXcCYmRHu5mWVuE
         ZSYhZC5jDCFncharYXBbQb/0Bar7Ub7NBxg7Vnneo006A7i05+WNn5LrIcXYyYDoVVA2
         7E4pF81wD8q27s9o2A3RsLb9elzs8Qji75l/esvwGnUZXzzCxfBSrzgjPclvTG1zP9Xq
         x9dbtPNjqUBMr4BYpUVaWYs7KtgDK4AemqHNKUKUSOPojmk/oFQPYCy+1i0KHAb5IGe0
         3ppg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WZ4xSQGtDTmivX4P00tlfaiaMy+3i6nGamkuws/1MpQ=;
        b=QNic+4KamREwmUaA7R1J/4+XIq7jWPVpqAtkIE0GVgX1e3f6DrQP+2nSZIL7piXkwH
         YuDeLRm2O8rUgaFfn7Hyv+W0j6qfuiJ9YGy9CG8OnoTVJsi05MVGDJHB33PxR+31DnXr
         WpW/bSi9s8Jiv3v6ZenmKF5lH/nBpZYmTs4VSQIslNvVh6+ColMRtC2FVJ/tLbiYoDXT
         2LR4s6The/RsA8LSsAP6vR+ucG/Vw/PgMJJ6EzBz9vpO0gFWr0ay87al/WpTDb30LONh
         XwImgeDtoBjxS/hrJHVZ3kmy2oTpUbvcWrFzVmlEA7FR0TafiicRoOEFsvWNVkMACMMr
         tgiA==
X-Gm-Message-State: AO0yUKWUKxgzXRzO+BuGs8Kpo153P4UVnjr0QsXNgS4sNQdwlCVBvOOb
        BzisVGBTnx5tcz+nUhCmA3uCib86snZAHIYel/w=
X-Google-Smtp-Source: AK7set9nvDTwPa7Oy1kFOSVeBjKEhm5a5BqEpYfNyFTC/Ctpmq1SBVNBKJ6B1efKvn8McOIxg7/LUzm/xaQNNJFsFxM=
X-Received: by 2002:a17:906:5a60:b0:8aa:bdec:d9ae with SMTP id
 my32-20020a1709065a6000b008aabdecd9aemr1300706ejc.12.1675899063105; Wed, 08
 Feb 2023 15:31:03 -0800 (PST)
MIME-Version: 1.0
References: <20230203031742.1730761-1-imagedong@tencent.com>
 <20230203031742.1730761-3-imagedong@tencent.com> <CAEf4BzYh90NyyYvfTT=M=-KLspydMX4PZK8jCwNDydAP=kFgYw@mail.gmail.com>
 <CADxym3a6_wBHW_c_ZYtZ5QXbbunhKxau6k-fn4TNrn+6qzW6fw@mail.gmail.com>
 <CAEf4BzZAo6Bfio3pbY3j5yUDArCbdiWPC-r=XhFM9Bwq+4VVMg@mail.gmail.com> <75421c53-fa5c-d7c7-4b19-2d97e3e6d7f6@oracle.com>
In-Reply-To: <75421c53-fa5c-d7c7-4b19-2d97e3e6d7f6@oracle.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 8 Feb 2023 15:30:51 -0800
Message-ID: <CAEf4BzZicf3B7BwPj=fWkcVJz0JayB9qUUbJFBPunxOJwQoMdw@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add test for legacy/perf
 kprobe/uprobe attach mode
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Menglong Dong <menglong8.dong@gmail.com>, ast@kernel.org,
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

On Wed, Feb 8, 2023 at 3:49 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 07/02/2023 22:50, Andrii Nakryiko wrote:
> > On Mon, Feb 6, 2023 at 6:39 PM Menglong Dong <menglong8.dong@gmail.com> wrote:
> >>
> >> On Tue, Feb 7, 2023 at 4:05 AM Andrii Nakryiko
> >> <andrii.nakryiko@gmail.com> wrote:
> >>>
> >>> On Thu, Feb 2, 2023 at 7:18 PM <menglong8.dong@gmail.com> wrote:
> >>>>
> >>>> From: Menglong Dong <imagedong@tencent.com>
> >>>>
> >>>> Add the testing for kprobe/uprobe attaching in legacy and perf mode.
> >>>> And the testing passed:
> >>>>
> >>>> ./test_progs -t attach_probe
> >>>> $5       attach_probe:OK
> >>>> Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED
> >>>>
> >>>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> >>>> ---
> >>>
> >>> Do you mind refactoring attach_probe test into multiple subtests,
> >>> where each subtest will only test one of the attach mode and type. The
> >>> reason is that libbpf CI runs tests with latest selftests and libbpf
> >>> against old kernels (4.9 and 5.5, currently). Due to attach_probe
> >>> testing all these uprobe/kprobe attach modes with extra features (like
> >>> cookie, ref count, etc), we had to disable attach_probe test in libbpf
> >>> CI on old kernels.
> >>>
> >>> If we can split each individual uprobe/kprobe mode, that will give us
> >>> flexibility to selectively allowlist those tests that don't force
> >>> libbpf to use newer features (like cookies, LINK or PERF mode, etc).
> >>>
> >>> It would be a great improvement and highly appreciated! If you don't
> >>> mind doing this, let's do the split of existing use cases into subtest
> >>> in a separate patch, and then add PERF/LEGACY/LINK mode tests on top
> >>> of that patch.
> >>>
> >>
> >> Of course, with pleasure. For the existing use cases, we split it into
> >> subtests, such as:
> >>
> >>   kprobe/kretprobe auto attach
> >>   kprobe/kretprobe manual attach
> >>   uprobe/uretprobe ref_ctr test
> >>   uprobe/uretprobe auto attach
> >>   sleepable kprobe/uprobe
> >>   ......
> >>
> >> Am I right?
> >
> > I haven't analysed all the different cases, but roughly it makes
> > sense. With more granular subtests we can also drop `legacy` flag and
> > rely on subtest allowlisting in CI.
> >
>
> I'm probably rusty on the details, but when you talk about subtest
> splitting for the [uk]probe manual attach, are we talking about running
> the same manual attach test for the different modes, with each as a
> separate subtest, such that each registers as a distinct pass/fail (and
> can thus be allowlisted as appropriate)? So in other words
>
> test__start_subtest("manual_attach_kprobe_link");
> attach_kprobe_manual(link_options);
> test__start_subtest("manual_attach_kprobe_legacy");
> attach_kprobe_manual(legay_options);
> test__start_subtest("manual_attach_kprobe_perf");
> attach_kprobe_manual(perf_options);
>
> ?

Yep. One of the reasons is that on 4.9 kernel there won't be link or
perf method available, so it is expected for such modes to fail. I
want to be able to still test the legacy code path on 4.9, though.
Similarly tests that are using ref_ctr_offset or bpf_cookie won't work
on older kernels as well. Right now because of all of them being in a
single test, I have to block entire test, losing coverage on older
kernels.

>
> >>
> >> Thanks!
> >> Dongmeng Long
> >>
> >>>
> >>>>  .../selftests/bpf/prog_tests/attach_probe.c   | 61 ++++++++++++++++++-
> >>>>  .../selftests/bpf/progs/test_attach_probe.c   | 32 ++++++++++
> >>>>  2 files changed, 92 insertions(+), 1 deletion(-)
> >>>>
> >>>
> >>> [...]

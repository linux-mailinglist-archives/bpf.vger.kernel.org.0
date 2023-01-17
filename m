Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3150266D483
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 03:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235744AbjAQCpx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 16 Jan 2023 21:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjAQCp3 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 16 Jan 2023 21:45:29 -0500
Received: from mail-yb1-xb42.google.com (mail-yb1-xb42.google.com [IPv6:2607:f8b0:4864:20::b42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA48436B01;
        Mon, 16 Jan 2023 18:39:39 -0800 (PST)
Received: by mail-yb1-xb42.google.com with SMTP id 188so32346993ybi.9;
        Mon, 16 Jan 2023 18:39:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=44hB+akApnLL1+4V33/fJ5lpbLMN3HBa2OFsRs6WaJc=;
        b=JAq3rv/wML/4aGYx/XJo/ogHrf6Cfhb4h7sShmOtBvThhlj/UpaThqDTsyrMzoy9o0
         N0IlS44wNEncXmr8l15GdbpuJBR8vXvcM6ujVadrKZiIAAZ36Njt3Hyt5hNh4mU5mTuF
         Kte38CAJP/wsQN8p7iGhkD3Qrlvp5e/nq3+nqFDWohOmS2lJqWRL7FIkgibZCrAXOzJE
         s7CmF2D+1rjlXGK6FV5jy2cC/4029texiUZZTYT5V0HTZDIFOOd5yN5ZSNdJnbMmJiM7
         Ye5+1WsbqQKPyOMAj4Gn7Alg7BPekBEZleF6UO8ySwnfptoGFivPUALAfmjOZwVvekt8
         115A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=44hB+akApnLL1+4V33/fJ5lpbLMN3HBa2OFsRs6WaJc=;
        b=nJX8IdewHthbq1vbfziBazFe3LaRq5YsrY4791HCEgLGmD7ykMz60Uv+hRtc3mT8QR
         iTIKS/YRpCP/oO43FrYwG1N4uKD8uwIBk6dsymEKcWT5pbQglRZT6A7AlayClV+J6bj4
         gMITzAsqxgh5n2NI1+dFxG/7ICw1G64/HYG0FYjrU0kFPRF7Ftn++5A48Wzj59gWwE48
         xp/hNDx4gjzaVf8gymxjwVih48Izu10MII4sgpmsA6qGM336SWH5wGipxRHOiQEaHpCc
         QAaLIQoOxL+GkTvqS5+HO8DdL8lw0eCth9j01tKqbcAM9ngJf88nhFys2dL03t81f8Bj
         2RVw==
X-Gm-Message-State: AFqh2kpRYCeJKvwr3g6HjkumshIxcTLP/WpUo/osZyFgNOZNX2XbjyHW
        ZRyD0o6wQt7agMX1U1PMdLnch+SAw31BTc/WlII=
X-Google-Smtp-Source: AMrXdXu6GjhsExBKGELUOU/FoLDszB5IoySjFBKDOEbW2n4UTUWnP3HE2VQ4NF/Fv9oikfLsOXhLEBH63Dgfz/7rfRs=
X-Received: by 2002:a25:8704:0:b0:7d2:e86c:dbd with SMTP id
 a4-20020a258704000000b007d2e86c0dbdmr202665ybl.26.1673923129738; Mon, 16 Jan
 2023 18:38:49 -0800 (PST)
MIME-Version: 1.0
References: <20230113093427.1666466-1-imagedong@tencent.com>
 <bdca73eb-07e3-2187-c46f-a3f14a9e50a4@oracle.com> <CAEf4BzZ5FNw-j3F8cUpy4knRiM1sqQOOPZnM43Kj8peN9kKQLg@mail.gmail.com>
 <CADxym3YqgvYt71+WhMM4jzp+9uqkNdq3nB9kvBxT=CVM7hwRsA@mail.gmail.com> <76c1acd9-1981-279b-87ff-90860886abc6@oracle.com>
In-Reply-To: <76c1acd9-1981-279b-87ff-90860886abc6@oracle.com>
From:   Menglong Dong <menglong8.dong@gmail.com>
Date:   Tue, 17 Jan 2023 10:38:38 +0800
Message-ID: <CADxym3YOKTMxAcB_=EGpsBwHG6eAmD-vHpc8oqWEw5Hi6_D1wA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: replace '.' with '_' in legacy kprobe event name
To:     Alan Maguire <alan.maguire@oracle.com>
Cc:     Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
        ast@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
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

On Mon, Jan 16, 2023 at 6:27 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>
> On 16/01/2023 02:27, Menglong Dong wrote:
> > Hello,
> >
> > On Sat, Jan 14, 2023 at 6:07 AM Andrii Nakryiko
> > <andrii.nakryiko@gmail.com> wrote:
> >>
> >> On Fri, Jan 13, 2023 at 6:13 AM Alan Maguire <alan.maguire@oracle.com> wrote:
> >>>
> >>> On 13/01/2023 09:34, menglong8.dong@gmail.com wrote:
> >>>> From: Menglong Dong <imagedong@tencent.com>
> >>>>
> >>>> '.' is not allowed in the event name of kprobe. Therefore, we will get a
> >>>> EINVAL if the kernel function name has a '.' in legacy kprobe attach
> >>>> case, such as 'icmp_reply.constprop.0'.
> >>>>
> >>>> In order to adapt this case, we need to replace the '.' with other char
> >>>> in gen_kprobe_legacy_event_name(). And I use '_' for this propose.
> >>>>
> >>>> Signed-off-by: Menglong Dong <imagedong@tencent.com>
> >>>> ---
> >>>>  tools/lib/bpf/libbpf.c | 7 +++++++
> >>>>  1 file changed, 7 insertions(+)
> >>>>
> >>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> >>>> index fdfb1ca34ced..5d6f6675c2f2 100644
> >>>> --- a/tools/lib/bpf/libbpf.c
> >>>> +++ b/tools/lib/bpf/libbpf.c
> >>>> @@ -9994,9 +9994,16 @@ static void gen_kprobe_legacy_event_name(char *buf, size_t buf_sz,
> >>>>                                        const char *kfunc_name, size_t offset)
> >>>>  {
> >>>>       static int index = 0;
> >>>> +     int i = 0;
> >>>>
> >>>>       snprintf(buf, buf_sz, "libbpf_%u_%s_0x%zx_%d", getpid(), kfunc_name, offset,
> >>>>                __sync_fetch_and_add(&index, 1));
> >>>> +
> >>>> +     while (buf[i] != '\0') {
> >>>> +             if (buf[i] == '.')
> >>>> +                     buf[i] = '_';
> >>>> +             i++;
> >>>> +     }
> >>>>  }
> >>>
> >>> probably more naturally expressed as a for() loop as is done in
> >>> gen_uprobe_legacy_event_name(), but not a big deal.
> >>>
> >>> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> >>
> >> Applied, but tuned to be exactly the same loop as in
> >> gen_uprobe_legacy_event_name. Thanks.
> >>
> >
> > Thanks for your modification, it looks much better now!
> >
> >>>
> >>> One issue with the legacy kprobe code is that we don't get test coverage
> >>> with it on new kernels - I wonder if it would be worth adding a force_legacy
> >>> option to bpf_kprobe_opts? A separate issue to this change of course, but
> >>> if we had that we could add some legacy kprobe tests that would run
> >>> for new kernels as well.
> >>
> >> Yep, good idea. If we ever have some bug in the latest greatest kprobe
> >> implementation, users will have an option to work around that with
> >> this.
> >>
> >> The only thing is that we already have 3 modes: legacy, perf-based
> >> through ioctl, and bpf_link-based, so I think it should be something
> >> like
> >>
> >> enum kprobe_mode {
> >>     KPROBE_MODE_DEFAULT = 0, /* latest supported by kernel */
> >>     KPROBE_MODE_LEGACY,
> >>     KPROBE_MODE_PERF,
> >>     KPROBE_MODE_LINK,
> >> };
> >>
> >> LEGACY/PERF/LINK naming should be thought through, just a quick example.
> >>
> >> And then just have `enum kprobe_mode mode;` in kprobe_opts, which
> >> would default to 0 (KPROBE_MODE_DEFAULT).
> >>
> >> Would that work?
> >>
>
> Looks good - I'd missed the "no BPF link" case, it'd be great to test that too.
>

My mistake, I forgot to add the 'bpf-next' tag :)

> So for legacy mode, we'd force using the legacy codepath, and to simulate the
> PERF mode where BPF link isn't supported I think we'd need to add to bpf_perf_event_opts
> so that we could choose the "no bpf link" code path rather than purely relying on the
> kernel support test.
>
> This would be nice as it would allow us to test other "pre-BPF link" attach targets
> too.
>
> So I think we need add an option to bpf_perf_event_opts for when KPROBE_MODE_PERF is set,
> such as PE_MODE_PERF or PE_MODE_NO_BPF_LINK.
>
> All of this would generalize to uprobe too I think; having a perf option makes that
> straightforward I suspect.
>
> >
> > Sounds great, which means I don't have to switch to an older
> > kernel to test this function for my app.
> >
> > BTW, should I do this job, (which is my pleasure), or Alan?
> >
> >
>
> Feel free to take this on if you've got time; I'm trying to get the dwarves patches
> covering support for .isra functions out as soon as possible so it would probably be
> a week or so before I get to this. Something like the above combined with updating
> the attach_probe selftests to run through the various attach modes would be great for
> testing legacy codepaths on newer kernels. We could perhaps rework the test_attach_probe()
> function to take an attach mode argument, and add subtests for each attach mode (skipping
> if it wasn't supported). Thanks!
>

Okay, I'll have a try!

> Alan
>
> > Thanks!
> > Menglong Dong
> >
> >>>
> >>> Alan
> >>>>
> >>>>  static int add_kprobe_event_legacy(const char *probe_name, bool retprobe,
> >>>>

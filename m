Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CC01563780
	for <lists+bpf@lfdr.de>; Fri,  1 Jul 2022 18:12:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbiGAQMm (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 1 Jul 2022 12:12:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231676AbiGAQMl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 1 Jul 2022 12:12:41 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19486237DC
        for <bpf@vger.kernel.org>; Fri,  1 Jul 2022 09:12:41 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id z14so2852385pgh.0
        for <bpf@vger.kernel.org>; Fri, 01 Jul 2022 09:12:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NqaAoVTRt3mx42tGv/fMRe0LGeHFOWmNmh13EcjF+WY=;
        b=IRvezL4YH5AEmWN7YoTDIuuogkmECmrqyVIMUClxcQKOhwNovxRT+Z7R5mCFy/LRPz
         G6Qxph9/QRFyfnMG6eTxdbPBtaKGOKZP4bjBR1FRROsVkeXy1S3JeVWZaoHvEUymcEne
         YQfkvYPnrPfS0M0ckdmxp5pR4MtnpKR+Kovvwyyt6HeAPH5SPK7ewaKiEN0rhZofKPg2
         nC5kGQNrXyeErlo4ZWolJ0h0myelSoGycm/ALcsRxXAJx4h7g/YAwuw+U4V8C1nZdvhb
         WhOJUJp8JzRYGMtkNmHuReg98c0AkUoQ8qBn0pBuDwG0PPdbkghWq0ZKLcD6ZV0AIQa1
         NBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NqaAoVTRt3mx42tGv/fMRe0LGeHFOWmNmh13EcjF+WY=;
        b=waHoPC7OJwSTgnrdRfL//RPIxakNEk/Ym5Y/t5Nx5ZAPYPwDeCiJrMmpLKw8zWJu99
         iOYuikhJmZEUJXkAPh2kbvBLEXQlr4NHyKsoExQObQVJE/E5+okUOg4RpcRkXO2dZtq2
         5GftL98nCdge40VDy/POkcRGd3ek/ZTOtix0OCknzESgjZ/5QcLjJCft64vsGUr53Vy/
         l2oEJqd/pN1cI/ZFhmcWNejT6g8VrZUA5RVmKI1+yOxLGXF9vxtp1is8Arh0/RoQ70Fb
         U62OL6+SJQf+9Dkfx3wni5/LKKTNHJyaDXw1Aykhhh010WphDyYcYRkPesD0GUvE6ke1
         dRMA==
X-Gm-Message-State: AJIora+o25Uqk26VfjM6w9Hbu457ARApx3NWe+inUSs/Sf9pHW2YT1Nb
        SLRbfc1OT0xxhg6bQ5MmFHu4qT5DPVwzMOtR3noZ4A==
X-Google-Smtp-Source: AGRyM1ss82mTuZW13RpyoRTBpAT2DaLXh9HZYUgRBfa4v2G56SCVI/hTVmvKJ/1oUwornRven98clJtb25ShwAACHpI=
X-Received: by 2002:a63:494:0:b0:40d:9ebf:6e86 with SMTP id
 142-20020a630494000000b0040d9ebf6e86mr13266476pge.253.1656691960411; Fri, 01
 Jul 2022 09:12:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220630224203.512815-1-sdf@google.com> <CA+khW7ixZWuKPXk0f-8=BNSUUWopKgkKJ8ev+KJ9oJdf8AyUQg@mail.gmail.com>
 <CAKH8qBv=3hMzpTy=K-n5+rObPhkns0gjJibVFHhNgG7ojrrMVQ@mail.gmail.com> <bf5f2bcb-9c19-f5a7-f74c-cee874def883@iogearbox.net>
In-Reply-To: <bf5f2bcb-9c19-f5a7-f74c-cee874def883@iogearbox.net>
From:   Stanislav Fomichev <sdf@google.com>
Date:   Fri, 1 Jul 2022 09:12:29 -0700
Message-ID: <CAKH8qBszRKrM==hs4NZVu+5w6pV+k1k3YvBYPE2-k_z9+ocaxA@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: skip lsm_cgroup when don't have trampolines
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Hao Luo <haoluo@google.com>, bpf@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Jul 1, 2022 at 6:22 AM Daniel Borkmann <daniel@iogearbox.net> wrote:
>
> On 7/1/22 2:16 AM, Stanislav Fomichev wrote:
> > On Thu, Jun 30, 2022 at 4:48 PM Hao Luo <haoluo@google.com> wrote:
> >> On Thu, Jun 30, 2022 at 3:42 PM Stanislav Fomichev <sdf@google.com> wrote:
> [...]
> >>> With arch_prepare_bpf_trampoline removed on x86:
> >>>
> >>>   #98/1    lsm_cgroup/functional:SKIP
> >>>   #98      lsm_cgroup:SKIP
> >>>   Summary: 1/0 PASSED, 1 SKIPPED, 0 FAILED
> >>>
> >>> Fixes: dca85aac8895 ("selftests/bpf: lsm_cgroup functional test")
> >>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
> >>> ---
> >>>   tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c | 8 ++++++++
> >>>   1 file changed, 8 insertions(+)
> >>>
> >>> diff --git a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> >>> index d40810a742fa..c542d7e80a5b 100644
> >>> --- a/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> >>> +++ b/tools/testing/selftests/bpf/prog_tests/lsm_cgroup.c
> >>> @@ -9,6 +9,10 @@
> >>>   #include "cgroup_helpers.h"
> >>>   #include "network_helpers.h"
> >>>
> >>> +#ifndef ENOTSUPP
> >>> +#define ENOTSUPP 524
> >>> +#endif
> >>> +
> >>>   static struct btf *btf;
> >>>
> >>>   static __u32 query_prog_cnt(int cgroup_fd, const char *attach_func)
> >>> @@ -100,6 +104,10 @@ static void test_lsm_cgroup_functional(void)
> >>>          ASSERT_EQ(query_prog_cnt(cgroup_fd, "bpf_lsm_sk_alloc_security"), 0, "prog count");
> >>>          ASSERT_EQ(query_prog_cnt(cgroup_fd, NULL), 0, "total prog count");
> >>>          err = bpf_prog_attach(alloc_prog_fd, cgroup_fd, BPF_LSM_CGROUP, 0);
> >>> +       if (err == -ENOTSUPP) {
> >>> +               test__skip();
> >>> +               goto close_cgroup;
> >>> +       }
> >>
> >> It seems ENOTSUPP is only used in the kernel. I wonder whether we
> >> should let libbpf map ENOTSUPP to ENOTSUP, which is the errno used in
> >> userspace and has been used in libbpf.
> >
> > Yeah, this comes up occasionally, I don't think we've agreed on some
> > kind of general policy about what to do with these :-(
> > Thanks for the review!
>
> Consensus was that for existing code, the ship has sailed to change it given
> applications could one way or another depend on this error code, but it should
> be avoided for new APIs (e.g. [0]).

Ah, great, thanks Daniel!

> Thanks,
> Daniel
>
>    [0] https://lore.kernel.org/bpf/20211209182349.038ac2b8@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com/

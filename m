Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6D8068868A
	for <lists+bpf@lfdr.de>; Thu,  2 Feb 2023 19:31:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjBBSbx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Feb 2023 13:31:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232816AbjBBSbi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Feb 2023 13:31:38 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F7F56778F
        for <bpf@vger.kernel.org>; Thu,  2 Feb 2023 10:29:51 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4b718cab0e4so37831067b3.9
        for <bpf@vger.kernel.org>; Thu, 02 Feb 2023 10:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GEZyjJ0mnjQz+NRAeTQHCjCDfKCS7rmfLl1d2MlgIfQ=;
        b=jCtjIWTIrU92q/gzigttsITW+8OSokaY5YMNzQlfVM401sdNtkY7U25xUmEzNh3hoa
         zhDJU4rtO8STnKusbbLZickO89AlALZr2fYNukGQxA3lkEj+74iJXukT6IqzQlJrujII
         HqIfLnm3CgXZ+sgfmzZwdQcMnUKH/gSq+uKMXSS2eRj5n+Q+sC300Wgx/krgd+Vy3KN9
         WMaenmIH5e4S2nXcdZjjrMoOSh0j5Y3G6uo4YsExaDRwcqtV9Midn8g8f92xktQTWX3E
         iRAUwgWr+EuAyy2d3C+cwIoaJxTZY16/CxhhFJ31IEGvfxiW3ox7xA/ytYbbdMp6rQaS
         yWCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GEZyjJ0mnjQz+NRAeTQHCjCDfKCS7rmfLl1d2MlgIfQ=;
        b=lJ/jIMlylzLfwlAAJyx37afoKmoWoQ90fwNNdXcYpIvONbKTnHLduKqMPgPHPz3Evo
         Qt97unWpsDZAT8X6Wt1qgY+RWf0TEH6N1wPVlK9eAgg3riW4LRwDuKJzHzUw93anvLgu
         iXisax01M2tdVNeyKBWt2y/D9EaWXx+HrX5X4W4S3XFVEkkDDGrY3wO63kvegbMOnu2f
         VuDdEW8h/uavfQrlUxFvXiRuWTeGS814ItHEY0O039NV64dIMpl3Dus1W7WYi7WCAsSt
         9u2E9ApLS+rHCrxBHDaOjIfJABKAxFjMM0tKhM5iCvc/TfJSIeuxYe0H/ghTjNqb5pGm
         1sUQ==
X-Gm-Message-State: AO0yUKXDLQ9f0MhQ5JC6CJjv24Q2INysWtOnLp+jd+RewoYndkQRw9qz
        pPj5fJKX0BjCuzzm7j7NDu2goh3jSxo9lTAhrQCmCOuoLcEzVw==
X-Google-Smtp-Source: AK7set93xq+sANBpMRKGc/TW8/f1mqhR8KupyDlEwCv0utIfthWxNJC/WfEpeaDKblA0QNhn/SooLJui86Wk3P+mIyU=
X-Received: by 2002:a0d:d5c8:0:b0:524:af5a:803e with SMTP id
 x191-20020a0dd5c8000000b00524af5a803emr43735ywd.264.1675362555367; Thu, 02
 Feb 2023 10:29:15 -0800 (PST)
MIME-Version: 1.0
References: <20230129190501.1624747-1-iii@linux.ibm.com> <CAADnVQL4Kmk-Hz5XB_AiVC+xVBhVvBqBZTTtedAJC5op2xGD6g@mail.gmail.com>
 <32bf5c1fc3dcfcf735f34f83e89cbb821878b931.camel@linux.ibm.com>
 <CAADnVQ+f3_AdYjvOCHystXe1vEmXzpABbLzU4tLZD7Wuu1CCgA@mail.gmail.com> <bdb3f8f0d81c0c2c05fc8003beda2f351ce1a504.camel@linux.ibm.com>
In-Reply-To: <bdb3f8f0d81c0c2c05fc8003beda2f351ce1a504.camel@linux.ibm.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 2 Feb 2023 10:29:02 -0800
Message-ID: <CAJnrk1YvB_n0ie5QiwSJ2_b5tYBWRke2bn+xoR4WAFENObZoBw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v3 0/8] Support bpf trampoline for s390x - CI issue
To:     Ilya Leoshkevich <iii@linux.ibm.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>
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

On Tue, Jan 31, 2023 at 5:47 AM Ilya Leoshkevich <iii@linux.ibm.com> wrote:
>
> On Mon, 2023-01-30 at 19:13 -0800, Alexei Starovoitov wrote:
> > On Mon, Jan 30, 2023 at 10:56 AM Ilya Leoshkevich <iii@linux.ibm.com>
> > wrote:
> > >
> > > On Sun, 2023-01-29 at 19:28 -0800, Alexei Starovoitov wrote:
> > > > On Sun, Jan 29, 2023 at 11:05 AM Ilya Leoshkevich
> > > > <iii@linux.ibm.com>
> > > > wrote:
> > > > >
> > > > > v2:
> > > > > https://lore.kernel.org/bpf/20230128000650.1516334-1-iii@linux.ibm.com/#t
> > > > > v2 -> v3:
> > > > > - Make __arch_prepare_bpf_trampoline static.
> > > > >   (Reported-by: kernel test robot <lkp@intel.com>)
> > > > > - Support both old- and new- style map definitions in
> > > > > sk_assign.
> > > > > (Alexei)
> > > > > - Trim DENYLIST.s390x. (Alexei)
> > > > > - Adjust s390x vmlinux path in vmtest.sh.
> > > > > - Drop merged fixes.
> > > >
> > > > It looks great. Applied.
> > > >
> > > > Sadly clang repo is unreliable today. I've kicked BPF CI multiple
> > > > times,
> > > > but it didn't manage to fetch the clang. Pushed anyway.
> > > > Pls watch for BPF CI failures in future runs.
> > >
> > > I think this is because llvm-toolchain-focal contains llvm 17 now.
> > > So we need to either use llvm-toolchain-focal-16, or set
> > > llvm_default_version=16 in libbpf/ci.
> >
> > Yep. That was fixed.
> > Looks like only one test is failing on s390:
> > test_synproxy:PASS:./xdp_synproxy --iface tmp1 --single 0 nsec
> > expect_str:FAIL:SYNACKs after connection unexpected SYNACKs after
> > connection: actual '' != expected 'Total SYNACKs generated: 1\x0A'
> >
> > #284/1 xdp_synproxy/xdp:FAIL
> > #284 xdp_synproxy:FAIL
> > Summary: 260/1530 PASSED, 31 SKIPPED, 1 FAILED
>
> Thanks! Where do you see the xdp_synproxy failure? I checked the jobs
> at [1] and rather see two migrate_reuseport failures ([2], [3]):

Hi Ilya,

I'm seeing these xdp_synproxy failures consistently in CI on
"test_progs/test_progs_no_alu32 on s390x with gcc" builds. These links
are to some of the latest ones:

https://github.com/kernel-patches/bpf/actions/runs/4074723783/jobs/7021760646
https://github.com/kernel-patches/bpf/actions/runs/4073866949/jobs/7019322847
https://github.com/kernel-patches/bpf/actions/runs/4073861356/jobs/7018721175

>
>   count_requests:FAIL:count in BPF prog unexpected count in BPF prog:
> actual 10 != expected 25
>   #127/7   migrate_reuseport/IPv6 TCP_NEW_SYN_RECV
> reqsk_timer_handler:FAIL
>
>   count_requests:FAIL:count in BPF prog unexpected count in BPF prog:
> actual 14 != expected 25
>   #127/4   migrate_reuseport/IPv4 TCP_NEW_SYN_RECV
> inet_csk_complete_hashdance:FAIL
>
> I tried running vmtest.sh in a loop, and could not reproduce neither
> the xdp_synproxy nor the migrate_reuseport failure.
>
> In migrate_reuseport, from the userspace perspective everything works,
> (count_requests:PASS:count in userspace 0 nsec). This means that we
> always get to the bpf_sk_select_reuseport() call and it succeeds.
> The eBPF program still records at least some migrations while the
> connection is in the TCP_NEW_SYN_RECV state, so I wonder if other
> migrations, for whatever reason, happen in a different state?
>
> [1] https://github.com/libbpf/libbpf/actions/workflows/test.yml
> [2]
> https://github.com/libbpf/libbpf/actions/runs/4049227053/jobs/6965361085#step:30:8908
> [3]
> https://github.com/libbpf/libbpf/actions/runs/4049783307/jobs/6966526594#step:30:8911

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193131498C8
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2020 05:52:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729117AbgAZEwp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 23:52:45 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:33799 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729014AbgAZEwp (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jan 2020 23:52:45 -0500
Received: by mail-qk1-f193.google.com with SMTP id d10so6456478qke.1;
        Sat, 25 Jan 2020 20:52:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=2V9KFWxEYBE4ZuksC6/Zvch05pfuHaIlNtgQhSeo9f8=;
        b=F5HITKI+hL5FSwlOvrIPHIwmL3IenT8wI5WoGKEUb1uQmitDB+RZCZ9lxMxrSWMQi6
         usCCSfdXvkQmNrRenTXHoTT7XZiGoIpl9/gIJdtf3DmwPd+m8K4/NN9sImvT4ogLQ98D
         tqhzMVRgmZuc9Mf6X5bbjxZajAOK1uSXyRbFJQTjVO6tz+19/fwtBsX1fTT+JLTxASFh
         DqLWf9yZztQYQPDSl7gD4PeL82ulKNeMjz4Y4OY3zywQBd0hE3Qc/z0ZdWneGv4GxvzO
         B5i+hWasgLT4Jlr+IpktxFz7k0O0yI1B7+4cV39es+tF6huK8geh6ih+GjOHJyYNVEK+
         n6fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=2V9KFWxEYBE4ZuksC6/Zvch05pfuHaIlNtgQhSeo9f8=;
        b=NkcOZj4MKh/c3SGQBECfwqL/1U4mYeLW4wThLeNdOBOejiJp+JTF9gF3AdyoWoUjxd
         Y5o6oUAVLCUDsqcaT9T/PZ0tipuBFTNQrFySDSYGTgfpKIn7zcLl9CAKse87C3Dn+q3P
         pZ/HZpVRSIN1ga3crDqnbg10qDUBdUmL+/j5zrA2SLtHvLq/IbfOxUhHe36GSwaegOJK
         /tFRJrE/h1s81Eus6iCOQtu06aDFRSmYxjyJ+EE3MkCY/Mi4nFiiRv2XqxFB+eqDaHXL
         /waFPhprFi09uwtMNXbSJ7geHzC9WOrSrb028nD4bND7iIHG4751RDOJAF31qEeul2+c
         QdKg==
X-Gm-Message-State: APjAAAXwhrJbr4f9816t+MBPNh2pSNnAyEpgVgcajc+eTzXHCAF8dSMp
        eZUiMe/wdny0j4eYeRwin7PcNL55//Q=
X-Google-Smtp-Source: APXvYqwshYdgYYkjwKeFAgN4G21w8jHbEgkVtCzkllcc2fCwy/9yaRg7u+IK8B1uEGdzwn+QcpexyQ==
X-Received: by 2002:a05:620a:248:: with SMTP id q8mr11343908qkn.354.1580014364024;
        Sat, 25 Jan 2020 20:52:44 -0800 (PST)
Received: from ast-mbp ([2620:10d:c091:480::a64e])
        by smtp.gmail.com with ESMTPSA id 184sm3754880qkl.81.2020.01.25.20.52.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jan 2020 20:52:43 -0800 (PST)
Date:   Sat, 25 Jan 2020 20:52:38 -0800
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Daniel Xu <dxu@dxuuu.xyz>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v5 bpf-next 2/2] selftests/bpf: add
 bpf_read_branch_records() selftest
Message-ID: <20200126045236.d6ah2l7joxtthdw6@ast-mbp>
References: <C05FGIY6DS21.3FOPNFKMT6EWK@dlxu-fedora-R90QNFJV>
 <fcbc20dd-e5ca-e779-774f-49490dc87c3b@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcbc20dd-e5ca-e779-774f-49490dc87c3b@fb.com>
User-Agent: NeoMutt/20180223
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 26, 2020 at 04:50:14AM +0000, Yonghong Song wrote:
> 
> 
> On 1/25/20 8:10 PM, Daniel Xu wrote:
> > On Sat Jan 25, 2020 at 6:53 PM, Alexei Starovoitov wrote:
> >> On Sat, Jan 25, 2020 at 2:32 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> >>> +       attr.type = PERF_TYPE_HARDWARE;
> >>> +       attr.config = PERF_COUNT_HW_CPU_CYCLES;
> >>> +       attr.freq = 1;
> >>> +       attr.sample_freq = 4000;
> >>> +       attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
> >>> +       attr.branch_sample_type = PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_ANY;
> >>> +       pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
> >>> +       if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
> >>> +               goto out_destroy;
> >>
> >>
> >> It's failing for me in kvm. Is there way to make it work?
> >> CIs will be vm based too. If this test requires physical host
> >> such test will keep failing in all such environments.
> >> Folks will be annoyed and eventually will disable the test.
> >> Can we figure out how to test in the vm from the start?
> > 
> > It seems there's a patchset that's adding LBR support to guest hosts:
> > https://lkml.org/lkml/2019/8/6/215 . However it seems to be stuck in
> > review limbo. Is there anything we can do to help that set along?
> > 
> > As far as hacking it, nothing really comes to mind. Seems that patchset
> > is our best hope.
> 
> prog_tests/send_signal.c tests send_signal helper under nmi with 
> hardware counters. It added a check to see whether the underlying
> hardware counter is supported, if it is not, the test is
> skipped.
> 
> Maybe we can use the same appraoch here. If perf_event_open with
> PERF_TYPE_HARDWARE/PERF_SAMPLE_BRANCH_STACK failed,
> we just mark the test as skipped instead of failing.

Instead of failing and skipping the test how about making it test error case?
Like instead of lbr perf_event some other event can be passed into bpf prog.
New helper can still be called and in such case it should return einval?

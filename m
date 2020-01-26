Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1FB149883
	for <lists+bpf@lfdr.de>; Sun, 26 Jan 2020 03:53:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729050AbgAZCxe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 25 Jan 2020 21:53:34 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:38169 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728842AbgAZCxd (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 25 Jan 2020 21:53:33 -0500
Received: by mail-lj1-f194.google.com with SMTP id w1so7066540ljh.5;
        Sat, 25 Jan 2020 18:53:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OEnj2kiwYLznKlJVo3yvAhfsKhH1hw584iUR8u5OCkk=;
        b=kKiKSmXvwzx5PTxC+jZ10pPoehY0tlvmMT65gnHMD7h5jCs5lDreLo/gRxv7VXTws1
         SQ4i9cwJ/rsoABGcIK5igQMANBNFcyROocuG48TgAAZ9ApqaU5ExJ/Rssoc/hHi/sidh
         HobaF0dDP05tPK6crZE1j1B5GY+sR6ENTP6JZFkkk/rKOy77M+1Xxpv77Pv02pB12VdU
         YLxvKsLTWAZhKOVwLcqfyZis9RWR/T6gDc+1fEZFlOcMm4i8nbqFyk//gvAThpMHS3v0
         apg4NHfIUmWISfHEbcoAEivL7acqec9Ok89vpDvO/Jwoy3HxHS1EbEu2D34QLydUx9VD
         yS/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OEnj2kiwYLznKlJVo3yvAhfsKhH1hw584iUR8u5OCkk=;
        b=EKRAYYvVxTct55HqnZ3KmHkOQoxgU7LsqsoiPzdXB3oc1Cykh5FCb0yVuJ/APkXEwE
         XIYk5WxE55+DsTysUw3713hj24wsNGZ/ZBMqBMohrmnoQYzT4ZKUghvPoh3b9ZIc4s2I
         Lstk7+hmfBdZISkc9Dq+29/Oe/8SDNJn0bFnm0pZOXLPFS/GCbWz+eamvR+Ow8D3/bZO
         8gx4JZfkGYmmdBFcOoHRYuJgVCmJU7P0krmjrl8BhfG/XK2dctXJlfhisJhcctrsFBFL
         5jJAMeCh+kjxdo2/25kldM65XN8NoNezXe57WuttBB8qOA4A4x1w9eom9u3WJ9eJWHY+
         Vknw==
X-Gm-Message-State: APjAAAX+/6r96ztEsK8eygWoZX1TkYVwOOjwLcEpXsDGPb0POVl0IZz5
        ieh2p5ZmOka4CN2BvihJGDhHBNjBWNk8CO6FMmA=
X-Google-Smtp-Source: APXvYqyVjL3DwCWegX0p4DFS0YHW+U1SX1R9URCafFx2E2s/SL4+vrjn3RI/LHVQbImg5heLf8Pj7+FwHzhitGGvM30=
X-Received: by 2002:a05:651c:20f:: with SMTP id y15mr5952903ljn.7.1580007211478;
 Sat, 25 Jan 2020 18:53:31 -0800 (PST)
MIME-Version: 1.0
References: <20200125223117.20813-1-dxu@dxuuu.xyz> <20200125223117.20813-3-dxu@dxuuu.xyz>
In-Reply-To: <20200125223117.20813-3-dxu@dxuuu.xyz>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sat, 25 Jan 2020 18:53:19 -0800
Message-ID: <CAADnVQ+Gy_Ph+83TLJkqtLM_pC2g65NhpX2vOwBH=JM3To2Thw@mail.gmail.com>
Subject: Re: [PATCH v5 bpf-next 2/2] selftests/bpf: add bpf_read_branch_records()
 selftest
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Jan 25, 2020 at 2:32 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> +       attr.type = PERF_TYPE_HARDWARE;
> +       attr.config = PERF_COUNT_HW_CPU_CYCLES;
> +       attr.freq = 1;
> +       attr.sample_freq = 4000;
> +       attr.sample_type = PERF_SAMPLE_BRANCH_STACK;
> +       attr.branch_sample_type = PERF_SAMPLE_BRANCH_USER | PERF_SAMPLE_BRANCH_ANY;
> +       pfd = syscall(__NR_perf_event_open, &attr, -1, 0, -1, PERF_FLAG_FD_CLOEXEC);
> +       if (CHECK(pfd < 0, "perf_event_open", "err %d\n", pfd))
> +               goto out_destroy;

It's failing for me in kvm. Is there way to make it work?
CIs will be vm based too. If this test requires physical host
such test will keep failing in all such environments.
Folks will be annoyed and eventually will disable the test.
Can we figure out how to test in the vm from the start?

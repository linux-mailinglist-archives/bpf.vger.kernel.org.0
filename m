Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1229D3D83EE
	for <lists+bpf@lfdr.de>; Wed, 28 Jul 2021 01:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232198AbhG0XZ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 27 Jul 2021 19:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232972AbhG0XZz (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 27 Jul 2021 19:25:55 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CB73C061760
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 16:25:54 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id f22-20020a25b0960000b029055ed6ffbea6so552060ybj.14
        for <bpf@vger.kernel.org>; Tue, 27 Jul 2021 16:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=mGM8M0Rqcjh0WsMdE9FDNh3Xtmb+3k1gm95RBfkhsuI=;
        b=wJ6ukFI8fNqdJiIj4f1n10480H69F6cb6eG1tb5mCeW4dHMtOl8e0ghVAhHxYCpEyc
         NELdNUMxDB16751ssBwXS7xSqDbqyOM0KIsk5kJWlmwL+hcnxrFvZA0NnVXCAJuZZCIS
         eCyNvOSiSWMiHvr3j8oux4LXCCmYkYb9GgJpuPHGQk0M5i26HFMH6I83tZt54esefIw6
         CCG1ethlQaKrl+BksVhTuFO6VtlippDaclEGkafTAoJhZfobyU86cnOb7KlY4xLope4R
         n2UhUisUrdLRBC1oj/M6mms3HMlBeYHqZmiP4bWz6gFKTvB6jzDea5KkyIixUFDH9g2o
         Pnjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=mGM8M0Rqcjh0WsMdE9FDNh3Xtmb+3k1gm95RBfkhsuI=;
        b=a+Y5c5i89hisjPx1JivmcCFlm2dd0fPd+TWT7Iz454Ci5RWyVkyOjkZv3BzmcMFLRc
         eoRp1SUe/xy5m4HBm+2cDwhLKl/TZsk/WQkunIxExve3uWXmUccw/dsNewZ3lR3hN3iR
         CbzoW21TQ0/Z4o0toRQ2UnbFEacligrYtetTN9lAq7uE8KZo4K5uXfuZXDvt6Nb53/Ho
         WKrCPqo/gbOISgQHSqCHTCeZxbGblGXvAWv+DUrqDHCPJRSPW01APDzR/byBiV0MKODK
         Ef6B7m2jNpolSjZA3iU3I20pEXGJ2QaRWGUDjiiO6veh7M2dsJOFA/ht1ul3EyOcuRCi
         QnjQ==
X-Gm-Message-State: AOAM532O22w4xT9FyFTWlLmZJ9EHQ9dfn58LMs4RlV4a+f4NOESNFKS8
        7ZWsHxD8m5LgQQTi5/IWPbQzjfM=
X-Google-Smtp-Source: ABdhPJxFOlplKbo+KjG015KQ0xI4BKDtOjaLt5zALkbA42+PmAxdx9URivURan0kE/lxGrGOityawI8=
X-Received: from sdf2.svl.corp.google.com ([2620:15c:2c4:201:d295:8a87:15f8:cb7])
 (user=sdf job=sendgmr) by 2002:a5b:4c8:: with SMTP id u8mr34964561ybp.255.1627428353489;
 Tue, 27 Jul 2021 16:25:53 -0700 (PDT)
Date:   Tue, 27 Jul 2021 16:25:51 -0700
In-Reply-To: <CAEf4BzZJOH1wbQ2BCjaqkYWtW406Oh+UyWt_wM9AtggabY46RQ@mail.gmail.com>
Message-Id: <YQCV/9NtQvtOk0sW@google.com>
Mime-Version: 1.0
References: <20210727222335.4029096-1-sdf@google.com> <CAEf4BzZJOH1wbQ2BCjaqkYWtW406Oh+UyWt_wM9AtggabY46RQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4] bpf: increase supported cgroup storage value size
From:   sdf@google.com
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     Networking <netdev@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 07/27, Andrii Nakryiko wrote:
> On Tue, Jul 27, 2021 at 3:23 PM Stanislav Fomichev <sdf@google.com> wrote:
> >
> > Current max cgroup storage value size is 4k (PAGE_SIZE). The other local
> > storages accept up to 64k (BPF_LOCAL_STORAGE_MAX_VALUE_SIZE). Let's  
> align
> > max cgroup value size with the other storages.
> >
> > For percpu, the max is 32k (PCPU_MIN_UNIT_SIZE) because percpu
> > allocator is not happy about larger values.
> >
> > netcnt test is extended to exercise those maximum values
> > (non-percpu max size is close to, but not real max).
> >
> > v4:
> > * remove inner union (Andrii Nakryiko)
> > * keep net_cnt on the stack (Andrii Nakryiko)
> >
> > v3:
> > * refine SIZEOF_BPF_LOCAL_STORAGE_ELEM comment (Yonghong Song)
> > * anonymous struct in percpu_net_cnt & net_cnt (Yonghong Song)
> > * reorder free (Yonghong Song)
> >
> > v2:
> > * cap max_value_size instead of BUILD_BUG_ON (Martin KaFai Lau)
> >
> > Cc: Martin KaFai Lau <kafai@fb.com>
> > Cc: Yonghong Song <yhs@fb.com>
> > Cc: Andrii Nakryiko <andrii@kernel.org>
> > Signed-off-by: Stanislav Fomichev <sdf@google.com>
> > ---

> Added Martin's ack and applied to bpf-next. Please carry over received
> Acks between revisions.
Ah, sorry, forgot about it :-(

> It's also a good practice to separate selftest from the kernel (or
> libbpf) changes, unless kernel change doesn't immediately break
> selftest. Please consider doing that for the future.
I've actually seen some back and forth on this one. I used to split
them in the past (assuming it makes it easy to do the
backports/cherry-picks), but I remember at some point it was
suggested not to split them for small changes like this.

Might be a good idea to document this (when and if to separate  
libbpf/selftests)
on bpf_devel_QA.rst

> I also just noticed that test_netcnt isn't part of test_progs. It
> would be great to migrate it under the common test_progs
> infrastructure. We've been steadily moving towards that, but there are
> still a bunch of tests that are not run in CI.
SG, I might do a follow up on this one.

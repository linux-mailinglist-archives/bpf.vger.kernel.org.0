Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AFF185256
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 19:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387999AbfHGRta (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 13:49:30 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:45474 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388600AbfHGRta (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Aug 2019 13:49:30 -0400
Received: by mail-lj1-f194.google.com with SMTP id m23so86216116lje.12
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 10:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6V0A6GCEg68jXtpGy/UsDgt2jqmpxm72Evgj1E9HNn0=;
        b=V6npBXkAkJlRMugacUa+LOLTEMJh46lTlcl/Ol59vtG0Gx0QPRipAAHJSPOx8B4CLd
         Dt/O1uB4chZ6VUeq/VxSAWCxkbdAKoDyN9md3kNL+OmqicIq6Nw+c1f1n9Sd8yHW1OS3
         ofEg8AUKGCTC8DZd11muHjEZWUxf8kmpPt2j4zeW/p++gVboMBJX/hRl4blsIK/uJ/8w
         L5jIEYEf57JWGHi/TVjxCX54Qu9lFUgcBLNH48NGFELdVxGT7Y/wKRGfoYcbuOIzjCUL
         Z7AQHDKgvl2U+3h+O7Cv8Kh7O2cZfJijRzkhTSuRBYWT/jJpr4yA3/LiKDhIgwT8WE1U
         x5iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6V0A6GCEg68jXtpGy/UsDgt2jqmpxm72Evgj1E9HNn0=;
        b=M+as9fYXtVPSfMqgE3CCgtB/F647Rp6EeaJ5IEOTLqKumSC/7k8pZBBHkpfpQiuxzp
         Ll5+8v0a1JCPNoq4RoESM60iEZqMtDmplN85BWuxrpzWgizbAnduyIVZVhobCs76kQs1
         UXG3ATiMyCEW3t24PVyu/poOlrN0g7eGhRlyE/84oI3olOWbuI459p12oJa39RGbh78d
         1IelFlLPO3nz+SPFmr165Bs5iPxdiNJhNTzPI279gRYYy3I+oDl3+48z34g3DMSARbLe
         OerqnZDDDZRwnjo8aD9bTha5txv1+QVctmTt+zUlwi82SOb4ew8brtFJeqVcorUwSBri
         Bzfg==
X-Gm-Message-State: APjAAAXo82HKUNQ4JoXVS0ZoH7Nlx+N4YNPPv5FAkSHNAhkj0LkQIHUX
        YjRVaiUU4A5E7WbKSahk0kiuqFhOi19MZTqgNhQ=
X-Google-Smtp-Source: APXvYqwJzsATP7kl4zzRMwWAbi2f1Qneh/Ydlq5pfJJtgSBk4v6vS5rueG00X5o/XazIxY3Ij5e0XdKM2ziJGRVt+Y8=
X-Received: by 2002:a2e:9a87:: with SMTP id p7mr5517205lji.133.1565200168137;
 Wed, 07 Aug 2019 10:49:28 -0700 (PDT)
MIME-Version: 1.0
References: <20190806233826.2478-1-dxu@dxuuu.xyz>
In-Reply-To: <20190806233826.2478-1-dxu@dxuuu.xyz>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Wed, 7 Aug 2019 10:49:16 -0700
Message-ID: <CAPhsuW4z-2CpH7fwYb1_a_ZArLkWBdriwUynMzpDTO=Jj0nxKg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>, bpf <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Aug 6, 2019 at 4:39 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> It's useful to know kprobe's nmissed and nhit stats. For example with
> tracing tools, it's important to know when events may have been lost.
> There is currently no way to get that information from the perf API.
> This patch adds a new ioctl that lets users query this information.
>

Part of the change is on perf side, so please include linux-kernel and
perf mantainers and reviewers:

M:      Peter Zijlstra <peterz@infradead.org>
M:      Ingo Molnar <mingo@redhat.com>
M:      Arnaldo Carvalho de Melo <acme@kernel.org>
R:      Alexander Shishkin <alexander.shishkin@linux.intel.com>
R:      Jiri Olsa <jolsa@redhat.com>
R:      Namhyung Kim <namhyung@kernel.org>
L:      linux-kernel@vger.kernel.org

I guess this is based on bpf-next tree. So please use subject perfix
[PATCH bpf-next] ([PATCH v2 bpf-next] when resend).

Thanks,
Song

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A06B85362
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2019 21:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730264AbfHGTDN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Aug 2019 15:03:13 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:44681 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730262AbfHGTDN (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 7 Aug 2019 15:03:13 -0400
Received: by mail-qt1-f193.google.com with SMTP id 44so58426029qtg.11
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2019 12:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=GO2qWklrPTPdY6PSLC4MqlCYKOmVqOrH1O/3SwUXsio=;
        b=QM4puvkgIWzFUKMLfxUB9rppW6axYcJyMWkEhxRaI7eoaMkLq7bZIC2C/3KBn5Hl2p
         r0KhErbvnUnGubz9GhHq5agi21/3eoejbIo7nzJwJulkqkpyigtCTsBQndWEURXZiyo5
         l28yN+fySAvhpcqyOeQgqOXKThS09dQvUh/y6ehsOAbbS3tLOLr/wo/1//TZWMf3oSux
         4Lrg/oD5hPhwZKvv9fPNExJ0w8tXHbangpW5SBkiFlBHLIJSOSYBWPAOcGeznBO6JXNK
         Loq8X1mUd1m817nF15Ivq2cqrQtEDKM9tHbnbosiVcWS6psIwECEpaLWzvlJrpXBhiMK
         cShw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=GO2qWklrPTPdY6PSLC4MqlCYKOmVqOrH1O/3SwUXsio=;
        b=lOLBSUvxjnyH/6/rqezVOv+f6Gseqf1lh3U5FvxLszvRAgAP8cQXc7QvfJWW7AF1eM
         aHGfrx6MGZzJpPtI4egIj/PhNdxkZhfqiMT4Y/EGY537Ud0vcxJdMb9nH0Cjq6Ej4EpE
         A5EL3+WZrPmOuS10qMbivo60i8esmrIan+54vq7XjipCclUdMyKIzuyNx2n6K2Wj70ru
         nZHBqIoPk68DmgDvu25e7G4yCDft2tLuPmYSVnGHnaDDcCIv2logj+7duxuWUFHmDLzg
         qb/ly8aUIMEL/8sOdGNxTZwq8e8n9T61ydfmDqVQGvcEufE02fFSCIHYYPMIn5mRyss0
         G1aA==
X-Gm-Message-State: APjAAAWdLr7+A9hcfqaZyHTpJVUt16TU6ZoUH4ywMyUa4lLJfFN9iOsM
        w6Koo1xKuwmsl/Bvcz6Va1nxCoBvuIaqI+4Mi/U=
X-Google-Smtp-Source: APXvYqyipi0D7aKctjRqD9FIqbAO3JKsSOP6eXsJFag9Hkol3C4+eqtib5ihlODgcsh/nqHUSwuWcEB4u3hwq7eSxJ4=
X-Received: by 2002:a05:6214:1306:: with SMTP id a6mr7589884qvv.38.1565204592743;
 Wed, 07 Aug 2019 12:03:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190806233826.2478-1-dxu@dxuuu.xyz>
In-Reply-To: <20190806233826.2478-1-dxu@dxuuu.xyz>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 7 Aug 2019 12:03:01 -0700
Message-ID: <CAEf4BzbTeZLpMT0d0CchYZnMTUj3yYUxi4M0Ki6Urgo8_Lqz4w@mail.gmail.com>
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

Is nmissed/nhit kprobe-specific? What about tracepoints and raw
tracepoints, do they have something similar or they can never be
missed? At least nhit still seems useful, so would be nice to have
ability to get that with the same API, is it possible?

> tracing tools, it's important to know when events may have been lost.
> There is currently no way to get that information from the perf API.
> This patch adds a new ioctl that lets users query this information.
>
> Daniel Xu (3):
>   tracing/kprobe: Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
>   libbpf: Add helper to extract perf fd from bpf_link
>   tracing/kprobe: Add self test for PERF_EVENT_IOC_QUERY_KPROBE
>
>  include/linux/trace_events.h                  |  6 +++
>  include/uapi/linux/perf_event.h               | 23 ++++++++++
>  kernel/events/core.c                          | 11 +++++
>  kernel/trace/trace_kprobe.c                   | 25 +++++++++++
>  tools/include/uapi/linux/perf_event.h         | 23 ++++++++++
>  tools/lib/bpf/libbpf.c                        | 13 ++++++
>  tools/lib/bpf/libbpf.h                        |  1 +
>  tools/lib/bpf/libbpf.map                      |  5 +++
>  .../selftests/bpf/prog_tests/attach_probe.c   | 43 +++++++++++++++++++
>  9 files changed, 150 insertions(+)
>
> --
> 2.20.1
>

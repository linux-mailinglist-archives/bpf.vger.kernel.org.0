Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACFB9851F
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2019 22:04:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730167AbfHUUEy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 21 Aug 2019 16:04:54 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36757 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730101AbfHUUEy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 21 Aug 2019 16:04:54 -0400
Received: by mail-qk1-f194.google.com with SMTP id d23so3015923qko.3;
        Wed, 21 Aug 2019 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PnHB8gyKyQN8X+3fWDRw3LLnwjDF9vWYPYJU7kI+Ljs=;
        b=Qb4/QdgAopIiPsSKrI0Ml0FWuBhpglzWZIh34AIf9iP1mPAKLFYigjyoH+2SHsz34F
         81taKwT3AOCD3UzL6iPnjsIIABaX//3Lb+s8TX4PxB8BzCZ4o4NkEPmgau+U5WV+UO+D
         nMfmqHhkFKaY0sYs9lt3ejUsgNLbBu0rXaLEhlUWGP4HwThKtMrCeeFG3JXgIvGyZEEd
         VXdW/LXakjSdP3TWg+coGg4lY6bBqwtGgDeJI/YihggwX/NMvQFokdp9kiJ0SJFKMOWe
         7dOBsGnUKzNodvA9Mwc3NgTOecfTaAo17cBPqd87Vult6Ci2ciYoY+L1alA6zEIUyW+s
         CQYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PnHB8gyKyQN8X+3fWDRw3LLnwjDF9vWYPYJU7kI+Ljs=;
        b=TYkRRaJNUqU81uGIzh5/vm69uHk31MY/GSqHDEZJ+MLIafaTRx4zk4koBL4BgeO6fZ
         g7+zpH0OvmF1iu0m6jZV1RtISxtWJcZxdz0tzQOFN2bcdiVMf1/HG0YAksYJkkoL9gzB
         Wz+oPiBwl4kQSx24xQByBNiYWwqHzzHaY1jjOBmgcK22GN/HbGAwFLCizKPV+jefbJ7q
         Vg4sRHfbD29Nj2eyKd0Sgib7TtPzj22hu2ap7tGzhnqz7ishaIwG23PKNDEV2ARUtg1p
         qZbTTNYKiqAVSOf+hrsacyosSjAnSbSYj4l5CB4QALRn89xiUy5+ImsjAnb6UIq/vfZP
         IXCw==
X-Gm-Message-State: APjAAAX+0IEFO8Wd5TXPTS5/+yeJEqk/u5HGfbWLifzn68Y52pHpQI7Y
        RAPgJ0BgSFX6JkGVQbhIdcw=
X-Google-Smtp-Source: APXvYqzd/Qv9AuvHu75iKH8704islEG5IzXmqfXzwc75rcmXXQUqVMYv6u8IerQCnt47p1VJEYr0Ig==
X-Received: by 2002:a37:2c41:: with SMTP id s62mr34120263qkh.415.1566417893345;
        Wed, 21 Aug 2019 13:04:53 -0700 (PDT)
Received: from quaco.ghostprotocols.net ([177.195.211.175])
        by smtp.gmail.com with ESMTPSA id m194sm10497757qke.123.2019.08.21.13.04.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2019 13:04:52 -0700 (PDT)
From:   Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>
X-Google-Original-From: Arnaldo Carvalho de Melo <acme@kernel.org>
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 9B23B40340; Wed, 21 Aug 2019 17:04:43 -0300 (-03)
Date:   Wed, 21 Aug 2019 17:04:43 -0300
To:     Yonghong Song <yhs@fb.com>
Cc:     Peter Zijlstra <peterz@infradead.org>, Daniel Xu <dxu@dxuuu.xyz>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Song Liu <songliubraving@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        Alexei Starovoitov <ast@fb.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add
 PERF_EVENT_IOC_QUERY_PROBE ioctl
Message-ID: <20190821200443.GH3929@kernel.org>
References: <20190820144503.GV2332@hirez.programming.kicks-ass.net>
 <BWENHQJIN885.216UOYEIWNGFU@dlxu-fedora-R90QNFJV>
 <20190821110856.GB2349@hirez.programming.kicks-ass.net>
 <62874df3-cae0-36a1-357f-b59484459e52@fb.com>
 <20190821183155.GE2349@hirez.programming.kicks-ass.net>
 <5ecdcd72-255d-26d1-baf3-dc64498753c2@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ecdcd72-255d-26d1-baf3-dc64498753c2@fb.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Em Wed, Aug 21, 2019 at 06:43:49PM +0000, Yonghong Song escreveu:
> On 8/21/19 11:31 AM, Peter Zijlstra wrote:
> > On Wed, Aug 21, 2019 at 04:54:47PM +0000, Yonghong Song wrote:
> >> A lot of bpf-based tracing programs uses maps to communicate and
> >> do not allocate ring buffer at all.
> > 
> > So extending PERF_RECORD_LOST doesn't work. But PERF_FORMAT_LOST might
> > still work fine; but you get to implement it for all software events.
> 
> Could you give more specifics about PERF_FORMAT_LOST? Googling 
> "PERF_FORMAT_LOST" only yields two emails which we are discussing here :-(

Perhaps he's talking about using read(perf_event_fd, ...) after having set it
up with perf_event_attr.read_format with the-to-be-implemented
PERF_FORMAT_LOST bit?

Look at perf_read() and perf_read_one() in kernel/events/core.c.
 
- Arnaldo

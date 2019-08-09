Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABBB88106
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2019 19:19:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407547AbfHIRTK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Aug 2019 13:19:10 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:38989 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407546AbfHIRTJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Aug 2019 13:19:09 -0400
Received: by mail-qk1-f196.google.com with SMTP id w190so72205036qkc.6
        for <bpf@vger.kernel.org>; Fri, 09 Aug 2019 10:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lojgrSsgEvtpH0qICZfY/jzrnLUpyJUsRBmKI5p5csU=;
        b=LtDr5cWqm+lURKKd0f6Hzacbs4ywOQGvFYTendBPSTIZIhVeL38/FbEclhNxinQ4cR
         88bvAZng9IYhEYcrX9Gh6IVg+pOq48eDpJ2zrhElR6PktGGsufdMmEFIy5UAJjWlR+6w
         s1ZV6aQT7UJG3XJmIWMwNQjBHBo4PJGGYxBioMwQ/bwyFQm2+Mn5QCGg5vqnklLRxPsE
         3RGnFicrZrr20OpMLcRjCyJCWHsMBS+dWj2eV6DidaMrir0EetdRI3rQUtN7UYoFsDmD
         wWXPPgOdxFGNCG9++LfY/zL2C3145Oty4cWRtuKWLPvZmOOPjgALeXUqwhRM/xqO16IP
         pXuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lojgrSsgEvtpH0qICZfY/jzrnLUpyJUsRBmKI5p5csU=;
        b=kctDc4zKVYTln30307aQZgqMApRCwmIQbbwCokiI5u7AP94Vfkv4Ku0lSWmh+55QJx
         J9H50VVOcOSQeE42l0T17/FQtCDrTwgxYO282QLtmybNfQxLR3a6HL4hvj2xdneUHOgJ
         pwvX1yXBXMxB/rXatu8ERLVSAABCOtx77jp2KKm7iWZlW+ig8uVShFgxXkSV+KQmqbNe
         7hft/kZrQqaor/djZfJ2PgTFjT1VRItaWyw6084KZQHq3XS9KWKoYl98AZOqRW2AJU6y
         WS/Fe4Dp3HWQ6jy3x18vjY2AAx0VqC+ZHVkU80Tqb0u/XprTrZLYN0z5qUVfk9iImEct
         eJ4Q==
X-Gm-Message-State: APjAAAVeHg2jvxjYWWMc+/Siu6tPn17NkUGdH8D5dA7cjtzmWDb/i2gn
        moT1X+BSusyAbIs2SQpPNtpIM1r2597bZigeEL4=
X-Google-Smtp-Source: APXvYqzz+10KSoIofdmpErCxsg+DfQBaKguS3Rd+yyYFYWmPSrL0CvZ1Y7sOy5xX0XcAo4CwWiFEQMRmuLzyFruWjy8=
X-Received: by 2002:a37:bf42:: with SMTP id p63mr19673088qkf.437.1565371148713;
 Fri, 09 Aug 2019 10:19:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190806233826.2478-1-dxu@dxuuu.xyz> <CAEf4BzbTeZLpMT0d0CchYZnMTUj3yYUxi4M0Ki6Urgo8_Lqz4w@mail.gmail.com>
 <d97ee4ce-06b6-45a6-a999-6e654e0236e4@www.fastmail.com>
In-Reply-To: <d97ee4ce-06b6-45a6-a999-6e654e0236e4@www.fastmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Aug 2019 10:18:57 -0700
Message-ID: <CAEf4BzZn88eDeZ3jcD8mLGsf7dY3Wpxc47PqbiyGD7U_xLcOig@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add PERF_EVENT_IOC_QUERY_KPROBE ioctl
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Aug 8, 2019 at 3:32 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> On Wed, Aug 7, 2019, at 12:03 PM, Andrii Nakryiko wrote:
> > On Tue, Aug 6, 2019 at 4:39 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
> > >
> > > It's useful to know kprobe's nmissed and nhit stats. For example with
> >
> > Is nmissed/nhit kprobe-specific? What about tracepoints and raw
> > tracepoints, do they have something similar or they can never be
> > missed? At least nhit still seems useful, so would be nice to have
> > ability to get that with the same API, is it possible?
> >
>
> I'm still trying to grok all the tracepoint/ftrace machinery, but it appears
> to me like it is kprobe/uprobe specific. My guess is that b/c tracepoints are
> inline (and don't require trapping interrupts), it cannot really "miss".
>
> This brings up a good point, though. I think we want the same querying
> functionality for uprobes so it might be worthwhile to make this API generic.
> Something like PERF_EVENT_IOC_QUERY_PROBE so we can later add in
> uprobe stats. And maybe tracepoint if it makes sense.
>
> Thoughts?

Yeah, we should definitely unify uprobes, if possible. Having nhit
would be great for tracepoints/raw_tracepoints, but we need to look
whether it's possible and whether it hurts performance. With bpf_stats
we trigger them only from time to time, so counting overhead might be
noticeable for some use cases.

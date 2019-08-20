Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E40A495358
	for <lists+bpf@lfdr.de>; Tue, 20 Aug 2019 03:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728689AbfHTB0X (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 19 Aug 2019 21:26:23 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:32894 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728647AbfHTB0X (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 19 Aug 2019 21:26:23 -0400
Received: by mail-lj1-f193.google.com with SMTP id z17so3522218ljz.0;
        Mon, 19 Aug 2019 18:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nIUbOMmJ/E0/oxoqpCDRKKZSlsVwBIRmIfZMOXNreVE=;
        b=FNpmXbZ1lx/YCyO+nTSN7Qo/7qg1MM89bnr70fjrzymPENeBcOICjeJMcFkkgXo5UN
         99nDxSYp7P79RZp2sP/akN1J8yzP85m7joZMHJcVh3c3bOymor3nQCsmsLpuULw/WSFI
         aF3KXevj+HDEH8LZKni4dh7O49aWotJZwRwOqjQdreFFsKq++QZduGyLYKajQZStXBng
         84uVJ3H5LvsB6clrLmSrE9hxrmdvi7KTJTQqdR3T1ShnWHwUnEkQDMcJXrF4g6MUBatO
         jRenCyz5oQ0JQL5J/xpvdrJHwI/ABdmB6BSglQJzF4EXulgiiatyJuT94XzJE6mqo4OU
         Hk+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nIUbOMmJ/E0/oxoqpCDRKKZSlsVwBIRmIfZMOXNreVE=;
        b=bC4Meyca6iMS5fj7/zS2VkpfEhglC0ar/bLTeeC4lntDD8YVm2vXvCf559kfXpaVoe
         43GD5YDxFgON1SNAGcvrMHyCZqZaFe7SGv2AKcfh204JMkG9KOiA8y4nlCO30PmFzf5c
         c9U4fO+Qbwr8gVoMOFmpTA4Yyr1WefjVZbQAunMApl8V2wHDJ2IBYuMZ6WAPVGABA4em
         LN5oVOddBm8gXejksajidnFdmxKA7Qx03VDrPC5np95/qBZpaoc/FBwzCZzW9wF/NRgK
         BnAcELwjNRPvoaSw8DcgAyMYBBDC2Sm/cr1EYeGTMhK6Xv/ertRpiqRL0+Yk5pehni+n
         bkXA==
X-Gm-Message-State: APjAAAU0jV7Y4vzHGPeS6IchkrG4grn8eZ24vLFtRdVw2bIRsGd9bU0D
        WGIh6XHgUVLs8HhUl6IeBGihtTkXsVAQH4/5Xrk=
X-Google-Smtp-Source: APXvYqypNqtw8gx1UvZs3VXty59BJkONiznthKWuc9ViOhnoMBfXElleSyreYerN3b2hpModMB6obOF3Ye2CGHnBq9Q=
X-Received: by 2002:a2e:89da:: with SMTP id c26mr850927ljk.214.1566264381062;
 Mon, 19 Aug 2019 18:26:21 -0700 (PDT)
MIME-Version: 1.0
References: <20190816223149.5714-1-dxu@dxuuu.xyz> <20190816223149.5714-2-dxu@dxuuu.xyz>
In-Reply-To: <20190816223149.5714-2-dxu@dxuuu.xyz>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Mon, 19 Aug 2019 18:26:09 -0700
Message-ID: <CAADnVQ+RKuJB5G+-1fjsE2xLp8CxJMmidd6Qobi_4dXQOWjrow@mail.gmail.com>
Subject: Re: [PATCH v3 bpf-next 1/4] tracing/probe: Add PERF_EVENT_IOC_QUERY_PROBE
 ioctl
To:     Daniel Xu <dxu@dxuuu.xyz>
Cc:     bpf <bpf@vger.kernel.org>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>, Andrii Nakryiko <andriin@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexei Starovoitov <ast@fb.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Aug 16, 2019 at 3:33 PM Daniel Xu <dxu@dxuuu.xyz> wrote:
>
> It's useful to know [uk]probe's nmissed and nhit stats. For example with
> tracing tools, it's important to know when events may have been lost.
> debugfs currently exposes a control file to get this information, but
> it is not compatible with probes registered with the perf API.
>
> While bpf programs may be able to manually count nhit, there is no way
> to gather nmissed. In other words, it is currently not possible to
> retrieve information about FD-based probes.
>
> This patch adds a new ioctl that lets users query nmissed (as well as
> nhit for completeness). We currently only add support for [uk]probes
> but leave the possibility open for other probes like tracepoint.
>
> Signed-off-by: Daniel Xu <dxu@dxuuu.xyz>
...
> +int perf_kprobe_event_query(struct perf_event *event, void __user *info)
> +{
> +       struct perf_event_query_probe __user *uquery = info;
> +       struct perf_event_query_probe query = {};
> +       struct trace_event_call *call = event->tp_event;
> +       struct trace_kprobe *tk = (struct trace_kprobe *)call->data;
> +       u64 ncopy;
> +
> +       if (!capable(CAP_SYS_ADMIN))
> +               return -EPERM;
> +       if (copy_from_user(&query, uquery,
> +                          offsetofend(struct perf_event_query_probe, size)))
> +               return -EFAULT;
> +
> +       ncopy = min_t(u64, query.size, sizeof(query));
> +       query.nhit = trace_kprobe_nhit(tk);
> +       query.nmissed = tk->rp.kp.nmissed;
> +
> +       if (copy_to_user(uquery, &query, ncopy))
> +               return -EFAULT;

shouldn't kernel update query.size before copying back?
Otherwise how user space would know which fields
were populated?

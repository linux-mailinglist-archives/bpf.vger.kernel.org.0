Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 89D9C499CB4
	for <lists+bpf@lfdr.de>; Mon, 24 Jan 2022 23:13:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355604AbiAXWHA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 24 Jan 2022 17:07:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1456554AbiAXVjb (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 24 Jan 2022 16:39:31 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F411C0417C9;
        Mon, 24 Jan 2022 12:24:50 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id d3so14924662ilr.10;
        Mon, 24 Jan 2022 12:24:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+0DfIzUd/ezfmUaeDHpKS419P3nuSSa30w/qAOCXOUo=;
        b=FINA02oqdgI49V5pDTUNWp+f1wRBRXRjVYOQ4OGUxbr21BpM1VHGaanpGCZwetjP+K
         PLd70jyw3UFem1YDA/KU1hve/lZ4TdAaSr4TDJQq65UuonAOIYxnCjyOb15VDuF1bQ/E
         +Evo6GezZ/zmy4CpH0NNmFux4g2wVAKmOVkB+Y3sBdWVV4dQps93YsbLI9PCxLCELsLT
         FcbO/A4voCYcpCNgWSydfAHLsRkrlLFwK3RMr54Fl1R2yOPU8t6Ps7HX/Qlnr4rADGEl
         4m6bUszvCkeV6wWl4DsxOqRgUeg0JhqfAbOb2bQcTsRci3hap3oM7Zj/pDpL/8gZhQA/
         ITvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+0DfIzUd/ezfmUaeDHpKS419P3nuSSa30w/qAOCXOUo=;
        b=i7CBM2C5T8MgPHEilcAurnKT/7j5jg5e12CTyQBeBJxzTpN4PqAf7NXbMDR2q/Bl+n
         ZfJXfGYabfz8kO4B4jJnTZjR/wLR+mYysn9qiHYHDZLn6qujnEniKV1TcAcdPg0XsKME
         ONg2ItFI5or7gqT72UtIEn38Vn0Ax8EnZELzxSENilLcfd2W1NDNK8z9WUUncS6E75Ep
         5WYiYaz9+AimFMTiadRFPVlx8bUEVHbNh3aP1Mv2nrYfDFfExAoY4mxM9G9t9j6UsUqe
         z0zJ5qWu5bTajmZ/iDcCeKgbGWY9N9LG703uLaJBJsKbrlblLM16zLIFLB3rRxNOjw5G
         q39Q==
X-Gm-Message-State: AOAM531OoMSe7ivf5DAtX8D6Zp/N4Q4SzbamTYmFU4VbPQZvdrSKj1Ah
        b7h6RA+pv2d4HZa9ku7hUJlx4E9FZNyr0xJXTJRYNXhN
X-Google-Smtp-Source: ABdhPJzKYkrknHARLlIq31qbbDDkJ2kCRKf3f1tlHB/njnslRMNqdRKMx94tzWj0V6cFsqH3e3wf8G3XdQhSJV23ACg=
X-Received: by 2002:a05:6e02:1748:: with SMTP id y8mr9622914ill.305.1643055889771;
 Mon, 24 Jan 2022 12:24:49 -0800 (PST)
MIME-Version: 1.0
References: <20220123221932.537060-1-jolsa@kernel.org>
In-Reply-To: <20220123221932.537060-1-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Mon, 24 Jan 2022 12:24:38 -0800
Message-ID: <CAEf4BzZj7awfwi-JoAB=aahxVF8p6FKhgu4OKpyY_pjePy75ig@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf/bpf: Remove prologue generation
To:     Jiri Olsa <jolsa@redhat.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        Christy Lee <christylee@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sun, Jan 23, 2022 at 2:19 PM Jiri Olsa <jolsa@redhat.com> wrote:
>
> Removing code for ebpf program prologue generation.
>
> The prologue code was used to get data for extra arguments specified
> in program section name, like:
>
>   SEC("lock_page=__lock_page page->flags")
>   int lock_page(struct pt_regs *ctx, int err, unsigned long flags)
>   {
>          return 1;
>   }
>
> This code is using deprecated libbpf API and blocks its removal.
>
> This feature was not documented and broken for some time without
> anyone complaining, also original authors are not responding,
> so I'm removing it.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/Makefile.config     |  11 -
>  tools/perf/builtin-record.c    |  14 -
>  tools/perf/util/bpf-loader.c   | 242 +---------------
>  tools/perf/util/bpf-prologue.c | 508 ---------------------------------
>  tools/perf/util/bpf-prologue.h |  37 ---
>  5 files changed, 1 insertion(+), 811 deletions(-)

Love the stats! Thanks for taking this on!

>  delete mode 100644 tools/perf/util/bpf-prologue.c
>  delete mode 100644 tools/perf/util/bpf-prologue.h
>

[...]

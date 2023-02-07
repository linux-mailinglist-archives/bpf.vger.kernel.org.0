Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E51268E367
	for <lists+bpf@lfdr.de>; Tue,  7 Feb 2023 23:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbjBGWWg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 7 Feb 2023 17:22:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjBGWWg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 7 Feb 2023 17:22:36 -0500
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73BAF86AA;
        Tue,  7 Feb 2023 14:22:35 -0800 (PST)
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-52bdbd30328so6776927b3.8;
        Tue, 07 Feb 2023 14:22:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=u5/ICA1zuDi5UMCa0OSVrQXJ51oSoYHr0B2mFzKfu14=;
        b=CKQHWwn4d10Y+q0EpzsTDyer4kRcFczoy8CpG+X8c9rkAMzitZkE7ETTokcAQhGaEA
         A8mgrHkIMTf9Y+r7TN4IZ5gCUK1dYF62Ys9ZZLL8oapRFLHyRRQQ6xB4fHro2/ZpEr76
         2d41uqIaFJh41c0Ba9iqiJ5r+3D3JlEZIbyYAS+ZRjFHCBo1gF6GlZVz+2Qn0+X/o6lZ
         HPhe/wrPadm9YYO2PxSL8CgRQXNSH88MWUeDm3PEiVgw6VYkfsErtXXHtZd+9oZRMn0u
         O7gsVsz63fXK63T3XHMI5ueAvz/qpnpcRL9OuSPZ38zxGxC+c1gm0UyD9QLvQEHQkZ37
         jquQ==
X-Gm-Message-State: AO0yUKUlCtvbUW2Up30e5XyQLMay745XafGDM4hCtWNz5o4bf5XgzKzS
        o16YW4pHe1wYj34r5A2A8r2rjuZLl+P2wWnE++KckmDn
X-Google-Smtp-Source: AK7set9ZKue0HJ9TiJY3C0a9PTqzN0SD0gVYQJz+jTL8EOqyR0v2eq9x9lv/fyjxaXHVNOLE3J/MJF2k+qgBZn0X62k=
X-Received: by 2002:a0d:e24f:0:b0:52a:772e:3e84 with SMTP id
 l76-20020a0de24f000000b0052a772e3e84mr424614ywe.390.1675808554545; Tue, 07
 Feb 2023 14:22:34 -0800 (PST)
MIME-Version: 1.0
References: <20230207002403.63590-1-namhyung@kernel.org> <20230207002403.63590-2-namhyung@kernel.org>
In-Reply-To: <20230207002403.63590-2-namhyung@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 7 Feb 2023 14:22:23 -0800
Message-ID: <CAM9d7ch4k8PFt1fB4MPaGVmz6P4HJZ48Yi6HA_Ec5Pe9GL_F9A@mail.gmail.com>
Subject: Re: [PATCH 1/3] perf lock contention: Fix to save callstack for the
 default modified
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Song Liu <song@kernel.org>, Hao Luo <haoluo@google.com>,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Feb 6, 2023 at 4:24 PM Namhyung Kim <namhyung@kernel.org> wrote:
>
> The previous change missed to set the con->save_callstack for the
> LOCK_AGGR_CALLER mode resulting in no caller information.
>
> Fixes: ebab291641be ("perf lock contention: Support filters for different aggregation")
> Signed-off-by: Namhyung Kim <namhyung@kernel.org>

Arnaldo, can you please take this one asap?

Thanks,
Namhyung


> ---
>  tools/perf/builtin-lock.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/tools/perf/builtin-lock.c b/tools/perf/builtin-lock.c
> index 0d11f301fd72..a4b5c481129c 100644
> --- a/tools/perf/builtin-lock.c
> +++ b/tools/perf/builtin-lock.c
> @@ -1806,6 +1806,9 @@ static int __cmd_contention(int argc, const char **argv)
>         con.aggr_mode = aggr_mode = show_thread_stats ? LOCK_AGGR_TASK :
>                 show_lock_addrs ? LOCK_AGGR_ADDR : LOCK_AGGR_CALLER;
>
> +       if (con.aggr_mode == LOCK_AGGR_CALLER)
> +               con.save_callstack = true;
> +
>         /* for lock function check */
>         symbol_conf.sort_by_name = true;
>         symbol_conf.allow_aliases = true;
> --
> 2.39.1.519.gcb327c4b5f-goog
>

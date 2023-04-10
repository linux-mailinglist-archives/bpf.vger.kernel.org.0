Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518456DC893
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 17:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbjDJPeG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 10 Apr 2023 11:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbjDJPeE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 11:34:04 -0400
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B471F65A1;
        Mon, 10 Apr 2023 08:34:03 -0700 (PDT)
Received: by mail-ua1-f50.google.com with SMTP id t20so16577521uaw.5;
        Mon, 10 Apr 2023 08:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681140842; x=1683732842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mh/TgqLDoXZo3DSGarUMsnIbppwaEVvC2iIeIHqNcDI=;
        b=4HDIK8nX0hV65L4BV5h7kfzYYPuExRKRtC0n1yhYTKuCSmn9I8Ffn4DgGSNgAwBRwI
         J415ylgBTDNqG4qZeDJ5Z9ko0qmT1kENuYh8w33SyDttBI8aaVfJ9hHeXgLhK2K1rZzx
         v6lxMLlq5oxKBQ7C3bKk7I9DQW0JPOAUwzwvnFpgjS8128UJTrB3IvcarTwEL73UTbo1
         QEpbKUN7kSJDV8IWqWsuWqWZB1KB55FvnkOl3d1Het27+TxkgpvwvXRGAxkc9lxfEYad
         mh+9X4XUTRJuNuvdz4Ak12TCKYOpBTNEkk4CJk2YhUyRLeykVh/EEwHIaDJ4TC0AD5HI
         gaEw==
X-Gm-Message-State: AAQBX9eT8YLY5UZ0y4KyYVGj3qPxlf1NCPBQTLQLmwgjTpQTWYswUyEj
        bsuNwEKmduu8V0x49blZ7S+epbWMqgdo3Z3DMHA=
X-Google-Smtp-Source: AKy350ZsGJ+9GIvXzk8Q5OEPnI+nljD1PKGaCxGl6DorZz+J8X9pc9MB2nElkt2KV0O5eL06vAs0wnc4NdcUymRdW40=
X-Received: by 2002:a05:6122:1166:b0:436:6a4a:68ab with SMTP id
 q6-20020a056122116600b004366a4a68abmr2893501vko.7.1681140842607; Mon, 10 Apr
 2023 08:34:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230408055208.1283832-1-irogers@google.com>
In-Reply-To: <20230408055208.1283832-1-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 10 Apr 2023 08:33:50 -0700
Message-ID: <CAM9d7cjn1mxBB5MvrUX=-iyu+FnoHtbMk7wLYi=QiQJ1LyL9KA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] perf lock contention: Support pre-5.14 kernels
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi Ian,

On Fri, Apr 7, 2023 at 10:52 PM Ian Rogers <irogers@google.com> wrote:
>
> struct rq's variable __lock was renamed from lock in 5.14.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks for fixing this.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/bpf_skel/lock_contention.bpf.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
>
> diff --git a/tools/perf/util/bpf_skel/lock_contention.bpf.c b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> index 23f6e63544ed..8911e2a077d8 100644
> --- a/tools/perf/util/bpf_skel/lock_contention.bpf.c
> +++ b/tools/perf/util/bpf_skel/lock_contention.bpf.c
> @@ -418,6 +418,14 @@ int contention_end(u64 *ctx)
>
>  extern struct rq runqueues __ksym;
>
> +struct rq__old {
> +       raw_spinlock_t lock;
> +} __attribute__((preserve_access_index));
> +
> +struct rq__new {
> +       raw_spinlock_t __lock;
> +} __attribute__((preserve_access_index));
> +
>  SEC("raw_tp/bpf_test_finish")
>  int BPF_PROG(collect_lock_syms)
>  {
> @@ -426,11 +434,16 @@ int BPF_PROG(collect_lock_syms)
>
>         for (int i = 0; i < MAX_CPUS; i++) {
>                 struct rq *rq = bpf_per_cpu_ptr(&runqueues, i);
> +               struct rq__new *rq_new = (void *)rq;
> +               struct rq__old *rq_old = (void *)rq;
>
>                 if (rq == NULL)
>                         break;
>
> -               lock_addr = (__u64)&rq->__lock;
> +               if (bpf_core_field_exists(rq_new->__lock))
> +                       lock_addr = (__u64)&rq_new->__lock;
> +               else
> +                       lock_addr = (__u64)&rq_old->lock;
>                 lock_flag = LOCK_CLASS_RQLOCK;
>                 bpf_map_update_elem(&lock_syms, &lock_addr, &lock_flag, BPF_ANY);
>         }
> --
> 2.40.0.577.gac1e443424-goog
>

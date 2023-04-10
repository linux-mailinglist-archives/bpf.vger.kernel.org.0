Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95D176DC894
	for <lists+bpf@lfdr.de>; Mon, 10 Apr 2023 17:35:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230035AbjDJPfG convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Mon, 10 Apr 2023 11:35:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbjDJPfE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 10 Apr 2023 11:35:04 -0400
Received: from mail-ua1-f47.google.com (mail-ua1-f47.google.com [209.85.222.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E965B83;
        Mon, 10 Apr 2023 08:34:46 -0700 (PDT)
Received: by mail-ua1-f47.google.com with SMTP id e7so5224283uav.10;
        Mon, 10 Apr 2023 08:34:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681140886; x=1683732886;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKwWntZPV9b+u4mbaMyCH2u5m/WMPbO/p7LpAHGAL9k=;
        b=bYbb6M9+RLLtTjqH1G3zN62rG6ybGFa4cJ/0cyw+F2knl0nmx8KdjBgm61EXggEA1d
         9j//vQqvWbM4cLNgtdRX48rRn/mStnIpH9cKWaLYk3WsODxLMLDiInj89mJVRBSCN9uG
         dJXKHw9w26aJUwD7id+loDIXyB2idhXR3196I/0NIvNmf/yKI9J4T65Uamwe/3eCB8pp
         ILiHzkweLnwS2MFjorzu+Un0LLIf+xPk6GCoMSjLqpMeny+SVqQVoNqQmoSeu0Fu16Ej
         4HQK7VsuyEcnKiRIituLhrwPaWvI8ct1woDf1TvnAWJbdH7nbTkgfA4K2oSJYv5Xik8j
         vPEQ==
X-Gm-Message-State: AAQBX9fXq6RsMwyKcBWjxqLNJDgiMqS6eg6ZsYfMPqqtaIIC/2olbOq4
        uKZKL55yjv0dj3SIvjJ1FbQlMriF6UU6wvpUDmw=
X-Google-Smtp-Source: AKy350ZUc+k8BCHWK3Rk5BKP0Xeoehxisof6OZsTAv/T3zERJnBNz5i6+4NjTh5DsnnOKRI41TkfwvB7Zm6CViJFJ2c=
X-Received: by 2002:a1f:1cd5:0:b0:43f:ef50:b54a with SMTP id
 c204-20020a1f1cd5000000b0043fef50b54amr667488vkc.1.1681140885819; Mon, 10 Apr
 2023 08:34:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230408055208.1283832-1-irogers@google.com> <20230408055208.1283832-2-irogers@google.com>
In-Reply-To: <20230408055208.1283832-2-irogers@google.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 10 Apr 2023 08:34:34 -0700
Message-ID: <CAM9d7cgfkx6VEazYpJEFZ=OTvJL+875_kHShSET4qyN_t9ixkQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] perf bpf filter: Support pre-5.16 kernels
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

On Fri, Apr 7, 2023 at 10:52 PM Ian Rogers <irogers@google.com> wrote:
>
> The mem_hops bits were added in 5.16 with no prior equivalent.
>
> Signed-off-by: Ian Rogers <irogers@google.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/util/bpf_skel/sample_filter.bpf.c | 28 ++++++++++++++++++--
>  1 file changed, 26 insertions(+), 2 deletions(-)
>
> diff --git a/tools/perf/util/bpf_skel/sample_filter.bpf.c b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> index 57e3c67d6d37..cffe493af1ed 100644
> --- a/tools/perf/util/bpf_skel/sample_filter.bpf.c
> +++ b/tools/perf/util/bpf_skel/sample_filter.bpf.c
> @@ -24,6 +24,24 @@ struct perf_sample_data___new {
>         __u64 sample_flags;
>  } __attribute__((preserve_access_index));
>
> +/* new kernel perf_mem_data_src definition */
> +union perf_mem_data_src__new {
> +       __u64 val;
> +       struct {
> +               __u64   mem_op:5,       /* type of opcode */
> +                       mem_lvl:14,     /* memory hierarchy level */
> +                       mem_snoop:5,    /* snoop mode */
> +                       mem_lock:2,     /* lock instr */
> +                       mem_dtlb:7,     /* tlb access */
> +                       mem_lvl_num:4,  /* memory hierarchy level number */
> +                       mem_remote:1,   /* remote */
> +                       mem_snoopx:2,   /* snoop mode, ext */
> +                       mem_blk:3,      /* access blocked */
> +                       mem_hops:3,     /* hop level */
> +                       mem_rsvd:18;
> +       };
> +};
> +
>  /* helper function to return the given perf sample data */
>  static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
>                                     struct perf_bpf_filter_entry *entry)
> @@ -89,8 +107,14 @@ static inline __u64 perf_get_sample(struct bpf_perf_event_data_kern *kctx,
>                         return kctx->data->data_src.mem_dtlb;
>                 if (entry->part == 7)
>                         return kctx->data->data_src.mem_blk;
> -               if (entry->part == 8)
> -                       return kctx->data->data_src.mem_hops;
> +               if (entry->part == 8) {
> +                       union perf_mem_data_src__new *data = (void *)&kctx->data->data_src;
> +
> +                       if (bpf_core_field_exists(data->mem_hops))
> +                               return data->mem_hops;
> +
> +                       return 0;
> +               }
>                 /* return the whole word */
>                 return kctx->data->data_src.val;
>         default:
> --
> 2.40.0.577.gac1e443424-goog
>

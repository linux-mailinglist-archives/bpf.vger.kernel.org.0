Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754DB5F6C98
	for <lists+bpf@lfdr.de>; Thu,  6 Oct 2022 19:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231826AbiJFRN0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Oct 2022 13:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231829AbiJFRNI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Oct 2022 13:13:08 -0400
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68908BBE12;
        Thu,  6 Oct 2022 10:12:50 -0700 (PDT)
Received: by mail-oo1-f51.google.com with SMTP id q70-20020a4a3349000000b0047f9951ad3aso1314922ooq.7;
        Thu, 06 Oct 2022 10:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtuVKtBzoKt+jjbMVURehUv1VCPg1XF6D/AE8RGN56s=;
        b=LqNjXvS8jqmHA1KhM7v3sX2YNUvNNsUWLvJMigBpbVkVKRHWewXWsdk3LSKh+QdCL9
         fEpvq9DF6paP7FlIwMoyzsVCm4sXEiWRq2PEEbRjQe3Q1LcdzD/y7Zqtk0NbkGWLAv9Y
         bZxuogNajNnMh7Awq91ab8D0F8PJ+C9kor3JUs3Apx+cHx0LQvO205N7sV7ob6uUkg+1
         HFIq7i4KcgBFWWFjE9lAocSgSDBGx0lPEtxjZv8PLj15uKD348Dl3cLlLc7/xPnCVtiX
         dOstUM/4xY56J2hM0/D6JR7l4DpgHbDQgA7+VUdJOQLjZ7fW0PYWF3kxbVsPF+wwHRdS
         t0ig==
X-Gm-Message-State: ACrzQf163HOeVONRNG91L+1WLghWezPZbwkP5icZouonBG6AT3BrAouB
        YrUy71nw2Hth3NIHskdFxEyayHnxS/0elWWKKyA=
X-Google-Smtp-Source: AMsMyM5wuCJUzTKp9TI/kiM8x8/PMnUws2JzhLIGBD920S8QVuI8y+eWoXERHiNlnjNIOLS2FOM7R6e7vTyAXKLJIRY=
X-Received: by 2002:a05:6830:621a:b0:660:dd14:c2f4 with SMTP id
 cd26-20020a056830621a00b00660dd14c2f4mr408265otb.190.1665076370095; Thu, 06
 Oct 2022 10:12:50 -0700 (PDT)
MIME-Version: 1.0
References: <166434824149.401.4361243714612738808.tip-bot2@tip-bot2> <20221006160044.3397237-1-sumanthk@linux.ibm.com>
In-Reply-To: <20221006160044.3397237-1-sumanthk@linux.ibm.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 6 Oct 2022 10:12:37 -0700
Message-ID: <CAM9d7ciTeePbQokkn_OAhwpa3cPfun-VacQRP4eOMmRzOkd6=w@mail.gmail.com>
Subject: Re: [PATCH] Re: [tip: perf/core] perf: Use sample_flags for raw_data
To:     Sumanth Korikkar <sumanthk@linux.ibm.com>
Cc:     tip-bot2@linutronix.de, linux-kernel@vger.kernel.org,
        linux-tip-commits@vger.kernel.org, peterz@infradead.org,
        x86@kernel.org, iii@linux.ibm.com, gor@linux.ibm.com,
        hca@linux.ibm.com, svens@linux.ibm.com, tmricht@linux.ibm.com,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hello,

On Thu, Oct 6, 2022 at 9:01 AM Sumanth Korikkar <sumanthk@linux.ibm.com> wrote:
>
> Hi,
>
> This causes segfaults.
>
> Steps to recreate:
> *  Run ./samples/bpf/trace_output
> BUG pid 9 cookie 1001000000004 sized 4
> BUG pid 9 cookie 1001000000004 sized 4
> BUG pid 9 cookie 1001000000004 sized 4
> Segmentation fault (core dumped)
>
> Problem:
> * The following commit sets data->raw to NULL, when the raw data is not filled
> by PMU driver. This leads to stale data.
>
> * raw data could also be filled by bpf_perf_event_output(), bpf_event_output()
> ...
>  686         perf_sample_data_init(sd, 0, 0);
>  687         sd->raw = &raw;
>  688
>  689         err = __bpf_perf_event_output(regs, map, flags, sd);
> ...
>
> * The below patch eliminates segfaults. However, contradicts with
> the description mentioned in this commit (Filled by only PMU driver).

Thank you for the fix.  Don't worry about the description - it said
it's usually filled by PMU drivers and it should be fine as long as
you set the sample flags after filling the raw data.

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung

>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index 49fb9ec8366d..1ed08967fb97 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -687,6 +687,7 @@ BPF_CALL_5(bpf_perf_event_output, struct pt_regs *, regs, struct bpf_map *, map,
>
>         perf_sample_data_init(sd, 0, 0);
>         sd->raw = &raw;
> +       sd->sample_flags |= PERF_SAMPLE_RAW;
>
>         err = __bpf_perf_event_output(regs, map, flags, sd);
>
> @@ -745,6 +746,7 @@ u64 bpf_event_output(struct bpf_map *map, u64 flags, void *meta, u64 meta_size,
>         perf_fetch_caller_regs(regs);
>         perf_sample_data_init(sd, 0, 0);
>         sd->raw = &raw;
> +       sd->sample_flags |= PERF_SAMPLE_RAW;
>
>         ret = __bpf_perf_event_output(regs, map, flags, sd);
>  out:
>
> --
> Thanks,
> Sumanth

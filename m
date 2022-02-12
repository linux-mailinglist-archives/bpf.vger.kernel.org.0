Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABAAA4B370C
	for <lists+bpf@lfdr.de>; Sat, 12 Feb 2022 19:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229469AbiBLSSY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 12 Feb 2022 13:18:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229533AbiBLSSX (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 12 Feb 2022 13:18:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29CAA5E772;
        Sat, 12 Feb 2022 10:18:20 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id u18so21081049edt.6;
        Sat, 12 Feb 2022 10:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JU3dYDsQt6ZfloLKvcqqzWf7Qg3OYXA02oSzVnFJQtA=;
        b=jlaEawZM/8wCVsPixXzsOJAeRJrTdHFlLRrdBJ/VV2CIiLDlBoxVeGEAGsJjKuhWVl
         9zI4SAuBRYLo4hvxINq0Ikp3mpKRc6vwEFQHBM/baLLYYqEmi+SoPJxH9mzffVDt9ADM
         Y6HSYn7t+3unlaBB2fBBM4fk5zbAEQyee8waWOGkjhEy04ssI+2uvfaiQ8ZmcdxRUU0v
         Cd+qHZJhqlQNMXIn/PQCfWwrioNFgvJh3T3OXznQ5MuyGeRH+mmEbGma2KVaNBgQeb6I
         SqcJcgR1dyW3WE9X+nnwy5yOM0NfgJLt7OyS37ooYSIOG4SbN/iRQ652gF07BsPxEUqI
         yJVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JU3dYDsQt6ZfloLKvcqqzWf7Qg3OYXA02oSzVnFJQtA=;
        b=BIpnEN20fuBcuO2v2b3aronNEMa2HAjexGRnh+mGNryFwh7nDbTtwEKbFaJ0ZwkKzv
         ISAir3Ju85hm290kX3uLQpVpglJS3OxW/LCaqgfqHJY7ZjxxPTUkJfGjeJFZipNDxlZ8
         e8nTe3YY6zMfQF5djZe1xiUOZ5UBB4wSKZdTbKcBwZZAypJHBrth3XKigj7H5hsMQIjZ
         oaGiYWzFuaueB5NZDEsNiCVaQmPYgNwdbJ7EMxT1sQ4cxe02yLVnVfIjDQjcmMjIcRmt
         NZP0iIx7FfJxZPZejmWpjzB6t4N+arRUBEVu11kD9TSIkJMhEM95TH61U2aueC0KPljf
         m1dw==
X-Gm-Message-State: AOAM5306W+kgWTWe/p623UzMAvOi6BjAwpYTbMDOeKNN8HKgUQ+0PmgZ
        e+uN15xfSHyert7DNCOhb94=
X-Google-Smtp-Source: ABdhPJz/KFZY5X+ueRe4knsqsTeGc5wXv1bCKUwn+tAKZzBUZTLEVtUVnN4KebKya39yjUS4zYfM8g==
X-Received: by 2002:a05:6402:1e91:: with SMTP id f17mr7696835edf.407.1644689898279;
        Sat, 12 Feb 2022 10:18:18 -0800 (PST)
Received: from krava ([83.240.63.12])
        by smtp.gmail.com with ESMTPSA id cz12sm7594044edb.30.2022.02.12.10.18.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 10:18:18 -0800 (PST)
Date:   Sat, 12 Feb 2022 19:18:16 +0100
From:   Jiri Olsa <olsajiri@gmail.com>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     acme@kernel.org, linux-perf-users@vger.kernel.org,
        bpf@vger.kernel.org, christylee@fb.com, jolsa@redhat.com
Subject: Re: [PATCH v6 perf/core 0/2] perf: stop using deprecated bpf APIs
Message-ID: <Ygf56M45VuWfippn@krava>
References: <20220212155125.3406232-1-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220212155125.3406232-1-andrii@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Sat, Feb 12, 2022 at 07:51:23AM -0800, Andrii Nakryiko wrote:
> libbpf's bpf_prog_load() and bpf__object_next() APIs are deprecated.
> remove perf's usage of these deprecated functions. After this patch
> set, the only remaining libbpf deprecated APIs in perf would be
> bpf_program__set_prep() and bpf_program__nth_fd().
> 
> v5 -> v6:
>   - rebase onto perf/core tree (Arnaldo);

looks good, tests are passing for me

jirka

> v4 -> v5:
>   - add bpf_perf_object__add() and use it where appropriate (Jiri);
>   - use __maybe_unused in first patch;
> v3 -> v4:
>   - Fixed commit title
>   - Added weak definition for deprecated function
> v2 -> v3:
>   - Fixed commit message to use upstream perf
> v1 -> v2:
>   - Added missing commit message
>   - Added more details to commit message and added steps to reproduce
>     original test case.
> 
> Christy Lee (2):
>   perf: Stop using deprecated bpf_load_program() API
>   perf: Stop using deprecated bpf_object__next() API
> 
>  tools/perf/tests/bpf.c       | 14 ++----
>  tools/perf/util/bpf-event.c  | 13 +++++
>  tools/perf/util/bpf-loader.c | 98 +++++++++++++++++++++++++++++-------
>  3 files changed, 96 insertions(+), 29 deletions(-)
> 
> -- 
> 2.30.2
> 

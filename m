Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F2F35ED8FA
	for <lists+bpf@lfdr.de>; Wed, 28 Sep 2022 11:31:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233749AbiI1Ja7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Sep 2022 05:30:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233863AbiI1Jan (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Sep 2022 05:30:43 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC57476C8
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 02:30:31 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id l18so6831887wrw.9
        for <bpf@vger.kernel.org>; Wed, 28 Sep 2022 02:30:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=s3Jx1PqsIRPOtL0gRbTaeGm3+t/Zwx2FKLGokZsbuxA=;
        b=TsYnTZRprVmm+Fjv99is0aTnYSr2n8dbiZxaNrkBy0kYoHChkCUVp2SD2x9em+H6q1
         2hLdlCXojgJmMH7sngbaUawyTQD8LX5D5zVLjXkAWz1Lju0RjggeqlubAiuBgPA+RJRG
         nVSYJUyeweNo1guCjmKeI8XTlYPslHWFWSZRIN6ddSwv4+J9gCm2gzqi8QTtDTAXJO/4
         lmhfS1okzQeUJ85WObgh4/Gkbcif2gOECf+gIfZ42RcN7+WieMWiVAdsNbGBHRj+ndC0
         HklVBmOVAmTVXmqigZ81syPBLCMxrZVDlmjLKA8u7AnWBp/OXyqX23mbRZ9VyBOaFqq8
         m4Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=s3Jx1PqsIRPOtL0gRbTaeGm3+t/Zwx2FKLGokZsbuxA=;
        b=yvsUoFlzxZB63bkdKxlPAmin9tjUjpzpNb3mGhk6RM5iDp8DNO3kJ5IhI+G4KxGbyt
         Cuj7YBHpUIyhgU7gVJErOxjGq16JKDWBxHFezK0RyObyATjwA/NvmmzgccOMd39iyvby
         ni+rppLVD/VCBVO5YaZzZsZ+jGo8JByXKqnZlJxymd48rs5qcTZI4nsLc5AncrKurNt8
         2IX8vURXbVbZqrtWslxcDgvkxm9TwFQn8PT54/7BpSCApWwQTpthpsGmMYtQWzSkM3XJ
         7/NH9QD2wsfyhdM8kil4n0w5nNEbMPjPMCwR7s7YHSosI9l3tQSUlyhwbcywqpVykYGn
         zo8Q==
X-Gm-Message-State: ACrzQf1Ac2q2kii9UbgOESKhyBb+mokIsdACcnKJoIcXlJvTganC51pE
        Tk6r3v2a56HFgBmnXrgMAfl/cQ==
X-Google-Smtp-Source: AMsMyM46x1drHB1K6T+fpnpWL/P76kz9eT3lGvo+eArJTyXkUPkjQ4MIG7hmhA0ocMIIhNdgNwH/Jw==
X-Received: by 2002:a5d:6609:0:b0:22a:3965:d5ad with SMTP id n9-20020a5d6609000000b0022a3965d5admr20359575wru.62.1664357430433;
        Wed, 28 Sep 2022 02:30:30 -0700 (PDT)
Received: from [192.168.178.32] ([51.155.200.13])
        by smtp.gmail.com with ESMTPSA id n2-20020a05600c4f8200b003b27f644488sm1261388wmq.29.2022.09.28.02.30.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Sep 2022 02:30:29 -0700 (PDT)
Message-ID: <fa36f8bf-f111-152d-6a8a-c50be49f1e72@isovalent.com>
Date:   Wed, 28 Sep 2022 10:30:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH 0/2] tools: bpftool: Remove unused struct
Content-Language: en-GB
To:     Yuan Can <yuancan@huawei.com>, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, martin.lau@linux.dev,
        song@kernel.org, yhs@fb.com, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@google.com, haoluo@google.com,
        jolsa@kernel.org, bpf@vger.kernel.org
References: <20220928090440.79637-1-yuancan@huawei.com>
From:   Quentin Monnet <quentin@isovalent.com>
In-Reply-To: <20220928090440.79637-1-yuancan@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Wed Sep 28 2022 10:04:38 GMT+0100 (British Summer Time) ~ Yuan Can
<yuancan@huawei.com>
> This series contains two cleanup patches, remove unused struct.
> 
> Yuan Can (2):
>   tools: bpftool: Remove unused struct btf_attach_point
>   tools: bpftool: Remove unused struct event_ring_info
> 
>  tools/bpf/bpftool/btf.c           | 5 -----
>  tools/bpf/bpftool/map_perf_ring.c | 7 -------
>  2 files changed, 12 deletions(-)
> 

Reviewed-by: Quentin Monnet <quentin@isovalent.com>

Thanks for the clean-up.
Quentin

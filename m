Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544C852F65E
	for <lists+bpf@lfdr.de>; Sat, 21 May 2022 01:46:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233961AbiETXqv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 20 May 2022 19:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiETXqv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 20 May 2022 19:46:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4042AF59D
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 16:46:50 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id g12so12555761edq.4
        for <bpf@vger.kernel.org>; Fri, 20 May 2022 16:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uAAf4cDaQKdQ50X9BHXbSs0yRh2zZMmYYuYaTbhjpDI=;
        b=Z5Nz9Fv9c4V6AV/MllfHDtnQXZdmsbrOwbGJAUDUYfq08AXdO+4XxSIBA5oyNcaw4G
         gF526MMhs7YtXOdecAFvy4RRKgZj3qOeWZBpopZ91ucXiWns/AihVPJDoTBgC3056G+M
         BPKk8TVswtsjqW2gskzuA+zSwIoLX5R/URWZdgQCVA1yvKqrpt1qE8s1xim4CvlR7gn/
         ylzhB7LyW7/vmpBsKd0uxjYDmt5BZUaJSSAJ3ujuqL1nezdADuAetjMjZkC29FHEyWN1
         wl4exa18li1GgLct7fbTIlCMExbbJrSkGf6cvU6qx8lIgPTi/FunzQ3PTO4jEx7qNNW4
         20Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uAAf4cDaQKdQ50X9BHXbSs0yRh2zZMmYYuYaTbhjpDI=;
        b=Bl3hzmjGte95Z07BwmgDqCHAdTyttmmZKpuQMPDE2i+NIKmsLGCD7eFgw+v+fHmLAf
         dAnSIajkw/Ksbt/WM0iFKXMTPQI+kL7ggKuYqFG99WK1ptlz2bCcb/QeABjctc3zE4fZ
         hg45eC9EvS0jEwtX/c1as3o+/YaOW9ThCFAenfcbX4f4pd27yQab8wza95hGgrFnWLwb
         KWxpuVjKMX26KIXlpoajHnDqx/3vLcd2NASm0cZ5hO0zCE8ERnc2mENmp3X2vs5OGSV1
         YHJK440l3VPVrRyyQ5AdiJY/SizyeFT18dUh1Xk7uU4Dbq5depD/7IOWpDa+N1Z6N/YQ
         /uDw==
X-Gm-Message-State: AOAM531gOeISqlj0k9PDbkMW4FFIaUckl4wjpAhzGVL/Kp1Xc2/kNJLe
        UaqqE6/cTGfXpTUFH8QiuZbIiGq3wVA0fY5/Ola5hQo7
X-Google-Smtp-Source: ABdhPJzYn1xjgBz/PAYFqL/eqmj3GYvQ92fL1lCLuEjvruz/I14ENlTrz/NnnZhXq8TlwfgLaFN1nc+AvptMgPy3Cn0=
X-Received: by 2002:aa7:da8d:0:b0:42a:aa60:8af3 with SMTP id
 q13-20020aa7da8d000000b0042aaa608af3mr13385489eds.94.1653090408806; Fri, 20
 May 2022 16:46:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220518035131.725193-1-davemarchevsky@fb.com>
In-Reply-To: <20220518035131.725193-1-davemarchevsky@fb.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 20 May 2022 16:46:36 -0700
Message-ID: <CAADnVQ+eDH5mAdb4Nobf1Np3myhxBprgB-jOHLsJKMJ0KBK7Nw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next] selftests/bpf: Add benchmark for
 local_storage get
To:     Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, May 17, 2022 at 8:51 PM Dave Marchevsky <davemarchevsky@fb.com> wrote:
> maps increases, though.
>
> Note that the test programs need to split task_storage_get calls across
> multiple programs to work around the verifier's MAX_USED_MAPS
> limitations.
...
> +++ b/tools/testing/selftests/bpf/progs/local_storage_bench.h
> @@ -0,0 +1,69 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +
> +struct {
> +       __uint(type, BPF_MAP_TYPE_ARRAY_OF_MAPS);
> +       __uint(max_entries, 1000);
> +       __type(key, int);
> +       __type(value, int);
> +} array_of_maps SEC(".maps");
> +
> +long important_hits;
> +long hits;
> +
> +#ifdef LOOKUP_HASHMAP
> +static int do_lookup(unsigned int elem, struct task_struct *task /* unused */)
> +{
> +       void *map;
> +       int zero = 0;
> +
> +       map = bpf_map_lookup_elem(&array_of_maps, &elem);
> +       if (!map)
> +               return -1;
> +
> +       bpf_map_lookup_elem(map, &zero);
> +       __sync_add_and_fetch(&hits, 1);
> +       if (!elem)
> +               __sync_add_and_fetch(&important_hits, 1);
> +       return 0;
> +}

This prog accesses only two maps: array_of_maps and global data
(hidden array map).

Where do you see it's reaching MAX_USED_MAPS limit ?

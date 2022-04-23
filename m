Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89D8C50C5C4
	for <lists+bpf@lfdr.de>; Sat, 23 Apr 2022 02:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229785AbiDWAkA (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 22 Apr 2022 20:40:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbiDWAj7 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 22 Apr 2022 20:39:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 643F014DEA3
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 17:37:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j6so7130211pfe.13
        for <bpf@vger.kernel.org>; Fri, 22 Apr 2022 17:37:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=s4mK3vXP3EKAqlSTeJgr4nvBqyO4wXvkikeFPh0hMro=;
        b=TmVNzZak4TcpEZzLpczbgg983THGQafCixSLGxkDGvYezrXZsL+hXdLrPWie5pJltp
         gumnSmkoFQ8+W9gYkU6JXGjc3tcX1fs3eEvVchSa7H6gIC0NMlFa/DF2ZPRWRtNgheWD
         usiB30qlXIsSmPOCRk5qFUWq6c4+MRcUvuNOJZBn8qFljQYree8g1I4G3v++J0pOaq+o
         ghfeTHQMqf8tH0TYozvgkETHiOeMFS2uTI/t8T+53H1/Vt9CM+tfWlb2UvD0ODhfZ26N
         sI3FC2K4hrpwOGOTgRaqWWRic4LYiIeW/Vl4MVYD1rZ4QcmfRLPkF33qy36l2TL4kzXW
         XsnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=s4mK3vXP3EKAqlSTeJgr4nvBqyO4wXvkikeFPh0hMro=;
        b=UFq2qifHZB85lNHd9+0ThKTrlOyck1CqBVh6wVq0E5/uhrEHPkiN7qahZZ4WTSKetu
         ROJKa3qC1LaFH7lF8Os/+S6LK1E/NasuD15wS34re6gTCEYi7enPzIMTSRm1amc6tDb3
         mYGXX6hJpmbPLJebHqON+oz274NmOGK3kYSVlPV2VXprkiMn1hCEsFweAdyfUoyZB9B6
         QvvWZKpqOGPUybKQfMM+qcEHeokWwIainkvXdK80mhBqeedBaDdw4Dr1qEpG97jI0NqA
         KjcnpwA0R4zMECWZHEV7LW+CeoewH43iSEO1mITFQpRWtfJI9vdfqzIZJl8AYyl5fo5K
         Unrg==
X-Gm-Message-State: AOAM530Q19b2NQD9F40C9kjUeXLK1JmjAuxJj9i/BcsTmPu9Ht5wmUa3
        VJamdrDQmk2YGWeG2JsO9ubZY9wxDZaLukZEhfY=
X-Google-Smtp-Source: ABdhPJwzpx5twE8jtAYvccGvS8uufHX5aSPBQEVHUwMNy5KuktTv+38LXC5gSkpTad2sSjl8DskiXjhbLJyulp60LFU=
X-Received: by 2002:a62:b515:0:b0:50a:3d51:671e with SMTP id
 y21-20020a62b515000000b0050a3d51671emr7645179pfe.48.1650674223886; Fri, 22
 Apr 2022 17:37:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220422120259.10185-1-fankaixi.li@bytedance.com> <20220422120259.10185-3-fankaixi.li@bytedance.com>
In-Reply-To: <20220422120259.10185-3-fankaixi.li@bytedance.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Fri, 22 Apr 2022 17:36:53 -0700
Message-ID: <CAADnVQL9=XivjNeg3CyE67N3cp6xB+cetUhWG6b+DtXo-6x0VA@mail.gmail.com>
Subject: Re: [External] [PATCH bpf-next v5 2/3] selftests/bpf: Move vxlan
 tunnel testcases to test_progs
To:     fankaixi.li@bytedance.com
Cc:     Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
        Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Apr 22, 2022 at 5:04 AM <fankaixi.li@bytedance.com> wrote:
> +#define VXLAN_TUNL_DEV0 "vxlan00"
> +#define VXLAN_TUNL_DEV1 "vxlan11"
> +#define IP6VXLAN_TUNL_DEV0 "ip6vxlan00"
> +#define IP6VXLAN_TUNL_DEV1 "ip6vxlan11"
> +
> +#define SRC_INGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_ingress_src"
> +#define SRC_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_egress_src"
> +#define DST_EGRESS_PROG_PIN_FILE "/sys/fs/bpf/tc/test_tunnel_egress_dst"
> +
> +#define PING_ARGS "-c 3 -w 10 -q"

Thanks for moving the test to test_progs,
but its runtime is excessive.

time ./test_progs -t tunnel
#195 tunnel:OK
Summary: 1/2 PASSED, 0 SKIPPED, 0 FAILED

real    0m26.530s
user    0m0.075s
sys    0m1.317s

Please find a way to test the functionality in a second or so.

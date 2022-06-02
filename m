Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A3153C002
	for <lists+bpf@lfdr.de>; Thu,  2 Jun 2022 22:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235127AbiFBUnx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 2 Jun 2022 16:43:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239255AbiFBUnw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 2 Jun 2022 16:43:52 -0400
Received: from mail-pj1-x1064.google.com (mail-pj1-x1064.google.com [IPv6:2607:f8b0:4864:20::1064])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4010C01
        for <bpf@vger.kernel.org>; Thu,  2 Jun 2022 13:43:47 -0700 (PDT)
Received: by mail-pj1-x1064.google.com with SMTP id o6-20020a17090a0a0600b001e2c6566046so10524592pjo.0
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 13:43:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:dkim-signature:mime-version:references
         :in-reply-to:from:date:message-id:subject:to:cc;
        bh=7Akd9F5RhYTnk2DKxtOSkM0eLGAw4F7uKrkIutX2DK4=;
        b=KhRwinlUqQi6zJfdyelMQQ3w6epbKpv6WPXtnKY/OlALBVtF8UnJz/2YnPLe4BjIJ/
         mH8ER2fcbm8Qm+A+b+eCTZgjjcitUl8DgN1qtL7SKDPGaGp4fAodTwpzBAp8C0AW56YH
         duDYf3a9aDfMJAs3/6px7LsGBiTArYZiqzWdypoun+wRlDovk9rqIu8DGvLY99ysyLAR
         OKkhnjtsTEmjKSdX7gqPzAW4TTXQcBNy343TbfPTvTeOm+g8AorUz2tXW9NhwJI4qIXD
         uwiwX9TA4WuqlRTKPWeO5Lk8xhpGGAD7hKqg9aPkF9WQAbSjqXzhhAh9Gf30qMe+K3/s
         sCdw==
X-Gm-Message-State: AOAM5306ZI4qniOOYD7N4k8RGvk4tshsCTO13Gm8KJpTmOn44BTmIMI4
        UZGCui6dniDhc8iODy+VQfwzifYCtieoFJixqd6AM36tEFTBKg==
X-Google-Smtp-Source: ABdhPJwr8nSGq3z+a29n/QhOK1O8V0aD2T/9ufsZjmhir30OXsy8OnBQk2GnXB60AKYRiOS1oq2ZtQxVSfzV
X-Received: by 2002:a17:902:c951:b0:166:4f65:cff2 with SMTP id i17-20020a170902c95100b001664f65cff2mr2134635pla.7.1654202627458;
        Thu, 02 Jun 2022 13:43:47 -0700 (PDT)
Received: from netskope.com ([163.116.128.205])
        by smtp-relay.gmail.com with ESMTPS id x7-20020a1709028ec700b001640eb9ed52sm465987plo.80.2022.06.02.13.43.47
        for <bpf@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 13:43:47 -0700 (PDT)
X-Relaying-Domain: riotgames.com
Received: by mail-qk1-f199.google.com with SMTP id p13-20020a05620a132d00b006a362041049so4571334qkj.0
        for <bpf@vger.kernel.org>; Thu, 02 Jun 2022 13:43:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=riotgames.com; s=riotgames;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7Akd9F5RhYTnk2DKxtOSkM0eLGAw4F7uKrkIutX2DK4=;
        b=d69dWt6HJQoiZC+5MFqWXaicN4JpYi+RWnOOF/pOfRBKwVUmlrSJlrlXBSNIyKNVAi
         z9m12QvfNIs49nr8dth8DdwQsDsdPaes77zgEtQmm12frTzYYvX/FiH+h/o09yPWCgaK
         tDxxQep7h5p0hfLK/lADwNSh/rNY9WFDu6JIM=
X-Received: by 2002:a05:622a:102:b0:304:b7b8:45b3 with SMTP id u2-20020a05622a010200b00304b7b845b3mr5046506qtw.369.1654202625656;
        Thu, 02 Jun 2022 13:43:45 -0700 (PDT)
X-Received: by 2002:a05:622a:102:b0:304:b7b8:45b3 with SMTP id
 u2-20020a05622a010200b00304b7b845b3mr5046491qtw.369.1654202625418; Thu, 02
 Jun 2022 13:43:45 -0700 (PDT)
MIME-Version: 1.0
References: <20220602173657.36252-1-varshini.elangovan@gmail.com>
In-Reply-To: <20220602173657.36252-1-varshini.elangovan@gmail.com>
From:   Zvi Effron <zeffron@riotgames.com>
Date:   Thu, 2 Jun 2022 13:43:34 -0700
Message-ID: <CAC1LvL1=Vf7khHRR+WHNmv1Ose=RnXbXQ6gJtfPDpz8ztia-JQ@mail.gmail.com>
Subject: Re: [PATCH] staging: r8188eu: Add queue_index to xdp_rxq_info
To:     Varshini Elangovan <varshini.elangovan@gmail.com>
Cc:     ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net,
        kuba@kernel.org, hawk@kernel.org, john.fastabend@gmail.com,
        andrii@kernel.org, kafai@fb.com, songliubraving@fb.com, yhs@fb.com,
        kpsingh@kernel.org, netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
x-netskope-inspected: true
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, Jun 2, 2022 at 10:37 AM Varshini Elangovan
<varshini.elangovan@gmail.com> wrote:
>
> Queue_index from the xdp_rxq_info is populated in cpumap file.
> Using the NR_CPUS, results in patch check warning, as recommended,
> using the num_possible_cpus() instead of NR_CPUS
>
> Signed-off-by: Varshini Elangovan <varshini.elangovan@gmail.com>
> ---
> kernel/bpf/cpumap.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/kernel/bpf/cpumap.c b/kernel/bpf/cpumap.c
> index 650e5d21f90d..756fd81f474c 100644
> --- a/kernel/bpf/cpumap.c
> +++ b/kernel/bpf/cpumap.c
> @@ -102,8 +102,8 @@ static struct bpf_map *cpu_map_alloc(union bpf_attr *attr)
>
> bpf_map_init_from_attr(&cmap->map, attr);
>
> - /* Pre-limit array size based on NR_CPUS, not final CPU check */
> - if (cmap->map.max_entries > NR_CPUS) {
> + /* Pre-limit array size based on num_possible_cpus, not final CPU check */
> + if (cmap->map.max_entries > num_possible_cpus()) {
> err = -E2BIG;
> goto free_cmap;
> }
> @@ -227,7 +227,7 @@ static int cpu_map_bpf_prog_run_xdp(struct bpf_cpu_map_entry *rcpu,
>
> rxq.dev = xdpf->dev_rx;
> rxq.mem = xdpf->mem;
> - /* TODO: report queue_index to xdp_rxq_info */
> + rxq.queue_index = ++i;

I don't think this is correct. i is the frame index, not the queue index. There
is (as far as I can tell) no correlation between the two.

Additionally, i is the loop variable, and the ++ operator will change its
value, causing frames to be skipped.

>
> xdp_convert_frame_to_buff(xdpf, &xdp);

>
> --
> 2.25.1
>

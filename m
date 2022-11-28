Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75554639E7F
	for <lists+bpf@lfdr.de>; Mon, 28 Nov 2022 01:44:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiK1Ao1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 27 Nov 2022 19:44:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiK1Ao0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 27 Nov 2022 19:44:26 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80D72644
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 16:44:25 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id e27so22119261ejc.12
        for <bpf@vger.kernel.org>; Sun, 27 Nov 2022 16:44:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tmAzqeZQ/KT8e8jQWsnHkP/gD+JBnySes7q9esaB/JM=;
        b=je8tRNOEAPOvL8f+uvGsWnyjU8QXQ9dvSYLapTnts6dh4zGRsKJh2HaPQzQa1KB5wU
         cLxzjcVfBJbAh3y7mM0bSXG2Hr+4B7BJlOK8P+0pPGECmR/lXe27g8qo9CxRaW8v6ko0
         SDVnzt3UrmNTFtzE/oVbO13cgtqTVfSL+csE3hL1n8dAmwuiTMgM8mvOFyRyehEqUImY
         zfUCVH+VSmPKipHX5Il6dpOr6hMiQ6MQmaMGcEmBfp9u+d87aJsxnZUJq9qvxqgJbwWw
         bTxO/8189H5hwhu9tABkcp8X4ChsM64JovBUJ4rmHKITc2q+Rwp6qXXqCV5cmJ5UE/fy
         KDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tmAzqeZQ/KT8e8jQWsnHkP/gD+JBnySes7q9esaB/JM=;
        b=j57BCvfdcdDgHVjnyT/HKekxCq1j10zuqWHibFw50lGJwRSSOMii4i1X0Vm48vyH2f
         P9vA54uhVchXZ1USOhXh9Obp6UIbRn9rUgBEt+Tq1oL+cDdx1FAu2dFbWVIAyWnbM/lo
         cpoVc+8+RSeBO2gxBqJnVKg6C2o9gUJUrf9+vM0lc429Um0iapMAieGBX71GXHBjm9k8
         6TgBDGrNztvQyxVqkX86G05TigTScerHUpVJCmTJ2/CxbE30NxuQTr58RZecRZBS7kGU
         vupUc1Y/yFutq0oDCZY17anrOHeASoQYqfHZNlEoVZDQxLUVsGWx6IElapZxWik51853
         Us+A==
X-Gm-Message-State: ANoB5pnOvALx2xlU1oc1voCCtHV+Rz8KG6mPR6wO+a8VJro3bVMa1poq
        zd0MRc0mIAkR8OHiAFwgWz7SlRZEcGVQpaA6bEhuG0SH
X-Google-Smtp-Source: AA0mqf7X6IgNSgxHBr7uQD4Lhtp0e9D2ecybn/DoNtF+OKbsZ/wVNoW5lDfRjVhgB9lhcHhXASsM0LOMkbue1nSkIpM=
X-Received: by 2002:a17:906:34d0:b0:78d:c16e:dfc9 with SMTP id
 h16-20020a17090634d000b0078dc16edfc9mr41533546ejb.327.1669596264496; Sun, 27
 Nov 2022 16:44:24 -0800 (PST)
MIME-Version: 1.0
References: <20221126105351.2578782-1-hengqi.chen@gmail.com> <20221126105351.2578782-2-hengqi.chen@gmail.com>
In-Reply-To: <20221126105351.2578782-2-hengqi.chen@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Sun, 27 Nov 2022 16:44:13 -0800
Message-ID: <CAADnVQJ8B0oDss95P+qfQx7r0Xr8RmY-_9dAincqESzyD+ZG+w@mail.gmail.com>
Subject: Re: [PATCH bpf 1/2] bpf: Check timer_off for map_in_map only when map
 value have timer
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
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

On Sat, Nov 26, 2022 at 2:54 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> The timer_off value could be -EINVAL or -ENOENT when map value of
> inner map is struct and contains no bpf_timer. The EINVAL case happens
> when the map is created without BTF key/value info, map->timer_off
> is set to -EINVAL in map_create(). The ENOENT case happens when
> the map is created with BTF key/value info (e.g. from BPF skeleton),
> map->timer_off is set to -ENOENT as what btf_find_timer() returns.
> In bpf_map_meta_equal(), we expect timer_off to be equal even if
> map value does not contains bpf_timer. This rejects map_in_map created
> with BTF key/value info to be updated using inner map without BTF
> key/value info in case inner map value is struct. This commit lifts
> such restriction.

Sorry, but I prefer to label this issue as 'wont-fix'.
Mixing BTF enabled and non-BTF inner maps is a corner case
that is not worth fixing.
At some point we will require all programs and maps to contain BTF.
It's necessary for introspection.
The maps as blobs of data should not be used.
Much so adding support for mixed use as inner maps.

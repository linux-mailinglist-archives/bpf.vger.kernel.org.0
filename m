Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB1086DC180
	for <lists+bpf@lfdr.de>; Sun,  9 Apr 2023 23:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbjDIVWC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 9 Apr 2023 17:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjDIVWC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 9 Apr 2023 17:22:02 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78CDB30F0
        for <bpf@vger.kernel.org>; Sun,  9 Apr 2023 14:21:58 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-50240a3b7fcso3333455a12.0
        for <bpf@vger.kernel.org>; Sun, 09 Apr 2023 14:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1681075317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=sKWYTJa9CQf0Rm+RxF5Jd2uCGDdkh+yTSb8bYj8+9EQ=;
        b=DLnBhKASZWQIM6qlLxwhlIH05/ZqFSsTZzrU9GAItlo7+dN4w9L50zg9BkNc7idmMZ
         eYyOEmhQAoGrOSLP7mb00qWh30bNuLfgsbtobOmVasatDndzB42RYeMfIeEHur7BKCwy
         Gw2EmqWG5YOs5GZXpa5esaFSNCrMn/4GhLBPlfzRDtjb3NhHNtaXW0jUbKzpTpDAUdLE
         jdRnVn1yfclAQ9yaRQOrseP1ptfs+yrGVQmj+6wHVr5kxSgTvlOLdDIljnoXnIh9ECD6
         VHyQZcUgBAERRigwqoAHU+Tov2xSbICDwNV+1m9lR9Y2/Tt+gpVJm0voGw2dohEF10NX
         lF2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681075317;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sKWYTJa9CQf0Rm+RxF5Jd2uCGDdkh+yTSb8bYj8+9EQ=;
        b=v+32bi335PrqKu3nzQ/Bd9+m0LL0Ct64Hcs+W6jubjkkwE8bCXWg5LPIwoCaExmGvh
         PRq8JizEA3w3En139JQpdOHXYqLLsfceqczUCkBX27OwtxWu6PaIsvYxqbMJ/CXxW6FI
         aDXOz9LYtKt0m3fiZZS831125QsYG2yEm57B3lO9UxxWND8+OHyoBJXq+2aGVt+yNLH+
         rwcJBOPtLyAULDZHkZ89x3JssqpwPOghreo0k4ceHypX4C1vUoxyRm2iirRRpsmx2YUf
         BaNKdLPneSkak80rfJYc9nO2pgGrkM1ksDU6Ld+DT4YuhBzToWPjtwzNMQkPzk8K0TOL
         xTTw==
X-Gm-Message-State: AAQBX9cB4ayQQzFsgf+uucz0TRLSZ1BzcN2ify5HC/axQEZSoLoKBChq
        khItqYEgWHp9XdtMUAO3lw1Cdm3PRwnqDVkGiWVS5w==
X-Google-Smtp-Source: AKy350b6UiczSFUrlDXSEwstpvYnrKojzZotsUdZH2yjdFCBV3clV7fnruucsRiOb6u+TF5NOwjxDTUxdKa7nPpFn4E=
X-Received: by 2002:a50:d4c6:0:b0:504:7094:2b59 with SMTP id
 e6-20020a50d4c6000000b0050470942b59mr2273712edj.7.1681075316944; Sun, 09 Apr
 2023 14:21:56 -0700 (PDT)
MIME-Version: 1.0
References: <20230407081427.2621590-1-weiyongjun@huaweicloud.com>
In-Reply-To: <20230407081427.2621590-1-weiyongjun@huaweicloud.com>
From:   Quentin Monnet <quentin@isovalent.com>
Date:   Sun, 9 Apr 2023 22:21:45 +0100
Message-ID: <CACdoK4+qORRJ9zdSD4aabpe3Br0Ea5wPJpsFeO3Okpk05wiztQ@mail.gmail.com>
Subject: Re: [PATCH bpf-next] bpftool: set program type only if it differs
 from the desired one
To:     Wei Yongjun <weiyongjun@huaweicloud.com>
Cc:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 7 Apr 2023 at 08:48, Wei Yongjun <weiyongjun@huaweicloud.com> wrote:
>
> From: Wei Yongjun <weiyongjun1@huawei.com>
>
> After commit d6e6286a12e7 ("libbpf: disassociate section handler on explicit
> bpf_program__set_type() call"), bpf_program__set_type() will force cleanup
> the program's SEC() definition, this commit fixed the test helper but missed
> the bpftool, which leads to bpftool prog autoattach broken as follows:
>
>   $ bpftool prog load spi-xfer-r1v1.o /sys/fs/bpf/test autoattach
>   Program spi_xfer_r1v1 does not support autoattach, falling back to pinning
>
> This patch fix bpftool to set program type only if it differs.
>
> Fixes: d6e6286a12e7 ("libbpf: disassociate section handler on explicit bpf_program__set_type() call")
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>

I'm late, but for the record:

Acked-by: Quentin Monnet <quentin@isovalent.com>

Thank you!

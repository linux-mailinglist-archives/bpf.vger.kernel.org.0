Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752185F7B2E
	for <lists+bpf@lfdr.de>; Fri,  7 Oct 2022 18:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229751AbiJGQIv (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 7 Oct 2022 12:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbiJGQIu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 7 Oct 2022 12:08:50 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82904114DC9;
        Fri,  7 Oct 2022 09:08:49 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j16so7978323wrh.5;
        Fri, 07 Oct 2022 09:08:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HDSNhZ4Sfk5K4RF7zJw4ZOJbQhRl9dsVaLFuDO2S9ZI=;
        b=bxGpn72DZjAT1zrodZHvxysfLGbJVnYR1DwthBl/sqnKJVBCsQ36bEqkGwZYqEIDkR
         CMf+vlF5Iw3zRC2b04ZkpKhq5kH3mmbgAI/x1Jr/6PoRlFMAaJ7hc9gkj3Nk8FnVEhjJ
         F0GzK1pqfArUlA6NvGKIdjimBOA/vZGA4wIWBel5jgisjf+zXhYr72OM9SMF1sxN6Np0
         30FkAvtDwRe1Nov52z3fnU6FaQjV8exL+7EyEpaoH9PiBw3o/bz16bgli3xuFrx44V1N
         jnaHumfCTImyEmjCfZPQtrU1Q5IFred2c08l6U9Ghgx6YY2fJVjryduz3++oHknU3FU0
         cTAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:references:message-id:date:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HDSNhZ4Sfk5K4RF7zJw4ZOJbQhRl9dsVaLFuDO2S9ZI=;
        b=RCHN8AkWu5QPX93XffxStM+88RmvfLrztvSKjgirzUpUlJzTLd1fZ9VYrIiI2NvHSB
         Zr/syCKhG5ZfGrwRNnmg3bGxXX1WLAosj/IkQy4D/S0MinJohv11Xh1BbSgCNEb6bHB+
         z2TWa8GAg2Eh5Sh0uTYZZQMURshTumWTelVJomoe+HG4ftW3+0tPzBNkBN56PLl445GX
         luVxRjbwDKmgWmYDKvuO+yntkjQL0JEJjKTESu8jU1T5F22T+vQcfZuUwRaUJs/FC+kI
         QvD9gTiymy2BwypZ/jNQQ1zT2upSv8F8VOA3H41pNignGd4y0DOPqKJO7NlwQ3HY90xy
         oGiw==
X-Gm-Message-State: ACrzQf3/0QvyMi9FOuPO9UR26a2Urw0EkkFlu/+Hbr9h6XlGHp5ePtZ6
        pA6GL1PlhisElf9pdsjgDcc=
X-Google-Smtp-Source: AMsMyM6axC1ZKtHZq9J068r/wXG3/9hqe5RUm+1KFmFgbusyaMgPb5sFsSGHWsvutbOPVzGJ4rRfNA==
X-Received: by 2002:adf:e310:0:b0:22c:c50f:46c8 with SMTP id b16-20020adfe310000000b0022cc50f46c8mr3748524wrj.231.1665158927953;
        Fri, 07 Oct 2022 09:08:47 -0700 (PDT)
Received: from imac ([88.97.103.74])
        by smtp.gmail.com with ESMTPSA id i9-20020a5d5229000000b0022cd59331b2sm2449297wra.95.2022.10.07.09.08.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 09:08:47 -0700 (PDT)
From:   Donald Hunter <donald.hunter@gmail.com>
To:     Daniel Borkmann <daniel@iogearbox.net>
Cc:     Jiri Olsa <olsajiri@gmail.com>, bpf@vger.kernel.org,
        linux-doc@vger.kernel.org, dave@dtucker.co.uk,
        Alexei Starovoitov <ast@kernel.org>
Subject: Re: [PATCH bpf-next v6 1/1] bpf, docs: document BPF_MAP_TYPE_ARRAY
In-Reply-To: <4b2cc38f-7ea8-56ad-30b3-af91553028ec@iogearbox.net> (Daniel
        Borkmann's message of "Fri, 7 Oct 2022 16:54:29 +0200")
Date:   Fri, 07 Oct 2022 17:07:53 +0100
Message-ID: <m2fsfzborq.fsf@gmail.com>
References: <20221005104634.66406-1-donald.hunter@gmail.com>
        <20221005104634.66406-2-donald.hunter@gmail.com>
        <Yz69qfI7ZkJPrUt7@krava>
        <4b2cc38f-7ea8-56ad-30b3-af91553028ec@iogearbox.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (darwin)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Daniel Borkmann <daniel@iogearbox.net> writes:

> On 10/6/22 1:36 PM, Jiri Olsa wrote:
>> I recently hit 32k size limit for per-cpu map value.. it seems to be
>> size limit for generic per cpu allocation, but would be great to have
>> it confirmed by somebody who knows mm better ;-)
>
> Yes, for percpu the max is PCPU_MIN_UNIT_SIZE which is 32k, see mm/percpu.c +1756.
> In many cases it's implementation specific, so it probably does not make too much
> sense to state limits like 2^32, or at least it should say that its theoretical/uapi
> limit and actual limits may be implementation/config specific.

Yes, good point. I will just drop the 2^32 bit. Same issue was
raised by Stanislav Fomichev for BPF_MAP_TYPE_HASH here:

https://patchwork.kernel.org/project/netdevbpf/patch/20220713211612.84782-1-donald.hunter@gmail.com/#24936386

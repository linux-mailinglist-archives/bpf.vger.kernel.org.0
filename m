Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C32169F900
	for <lists+bpf@lfdr.de>; Wed, 22 Feb 2023 17:30:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjBVQaK (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Feb 2023 11:30:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjBVQaK (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Feb 2023 11:30:10 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A732940E
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 08:30:08 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id f13so32228624edz.6
        for <bpf@vger.kernel.org>; Wed, 22 Feb 2023 08:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KS5/b7k0a9CbIe425fXBYHTSRJd1MpW8ZtbFfW1S0lE=;
        b=YnlGXNmEDOTF+Rfqs43mUvkRfdM0KnnnCMX4rRmHwjoiXzYjOFCv6J9066D0zgVhr5
         C2cWkeFXPGXKBPnzjGpDzjTtwDkjB3tM7F6fo5QCSk+sFljSgdpKDfwzD7L9X/rzzqfb
         ASZNZIgXJuzkPgPrlu/bkyPjB6HjZKK0lacnLETraru/3S6BXelEpkl5hwcDtL2XSC0x
         weDw8D8AEXuhnJqA9qVD3taKEPeox6qMcr0j4OomXwICumiBzPQtyg8xbZrhvSi44coO
         27YkCHFpUTx3sDdfC2y/fnwnFmoyxHLI/IQ7Sg4hG23PQ3Kv5ewdKUw+BLy7fOvTrYkK
         nxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KS5/b7k0a9CbIe425fXBYHTSRJd1MpW8ZtbFfW1S0lE=;
        b=3haVZhZjuVUVBdqvXFUKAHnBO2eN9aIZaUbkmvyLLUgKV1nu/Es2zukypr4GaimCAO
         LI+EOWHZDB8g7IruoXvT3rTxFNyFOhzOpxoD6zo1y3Zrs73DMJ32GLWmzUrZtZZ8GEbK
         xQFRM2QIlNZ0er/iuP+FPIHFSeHeGfKnYCUeujhbBzePGY9QAVmwagBO4n7Q1J1l0zY+
         SI6wLYdnbXV/4aOslZHCf+GtYRsQ7sZb2xL15w2gSXFBIVoqybDApW52nL+L3gNGiQg/
         Y2du11rUlT/6foEvop3lmAugoaXvfw15u+YejP92mERPYJ2P8thvIDuaScgGV/vk7oKl
         bXdw==
X-Gm-Message-State: AO0yUKXROduofEmoyOn00xkEErDi8OlpGhijpYcmp1OSASCGHSGQi4z6
        jeu+IJfuicuXZJjn4xGDLPzY/INNCqcgvFrJUuixejO+
X-Google-Smtp-Source: AK7set9vPOPlpEvFs2pIjNAQt914D7sHAFwd1Vo3dCgNHePCJLO48AzbUYjBjUPHSS4FObW4AD/JQdU3s7iholfen/g=
X-Received: by 2002:a05:6402:35ca:b0:4af:62ad:60b1 with SMTP id
 z10-20020a05640235ca00b004af62ad60b1mr1665212edc.3.1677083407291; Wed, 22 Feb
 2023 08:30:07 -0800 (PST)
MIME-Version: 1.0
References: <20230222025048.3677315-1-chenhuacai@loongson.cn>
 <167704261767.377.7977555061947404632.git-patchwork-notify@kernel.org> <CAAhV-H4TkQ7Nf2PekGgpykzdoLtVbd7b_5UtiWMFOEZtbLDf4g@mail.gmail.com>
In-Reply-To: <CAAhV-H4TkQ7Nf2PekGgpykzdoLtVbd7b_5UtiWMFOEZtbLDf4g@mail.gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Wed, 22 Feb 2023 08:29:55 -0800
Message-ID: <CAADnVQ+Pta_k2BHN5Y+LE+Cjd=6WAmpUwhwwRzmJWBu-UU9H_Q@mail.gmail.com>
Subject: Re: [PATCH] BPF: Include missing nospec.h to avoid build error
To:     Huacai Chen <chenhuacai@gmail.com>
Cc:     patchwork-bot+netdevbpf@kernel.org,
        Huacai Chen <chenhuacai@loongson.cn>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        bpf <bpf@vger.kernel.org>, Xuefeng Li <lixuefeng@loongson.cn>,
        Tiezhu Yang <yangtiezhu@loongson.cn>
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

On Tue, Feb 21, 2023 at 10:27 PM Huacai Chen <chenhuacai@gmail.com> wrote:
>
> Oh, I'm sorry but the modified commit message seems broken.

You didn't do it correctly. I fixed it up while applying.

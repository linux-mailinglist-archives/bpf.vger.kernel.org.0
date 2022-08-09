Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6804558DFD0
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 21:09:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345330AbiHITHh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 15:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348254AbiHITGe (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 15:06:34 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5D4426123
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 11:49:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a7so23813949ejp.2
        for <bpf@vger.kernel.org>; Tue, 09 Aug 2022 11:49:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QZy73iwn0mRk3wjAi7x5BepN1zxlkLUpEV67mokAMag=;
        b=fH2/w8CNJJuMEEjO/DVPkQGhB4Ur+WtnJCBTL/1w6PxhVPqPQjCBcXsYJObdpRpYQx
         psz+e1CF3dbkRHXWG4ZQmNls76ceAxvLNrz9SQ2QpJatgU0zzvITDSkEvZxP1iAJh6BE
         1WeJmbQmGMqe3lnVhtIMpcpJ8aDahug1T6Z3W96+5m++sT7o3itrdVLmONiOc2TelkAt
         mK7XQrawhA9XKCja84Z1RZzeUQUmNC/tgN0FDmHfq4S4rD/dEl6ugoM0uyWZtnpEmjrU
         xGkBJIhrFvvjpwyukh3LkIorq0OfHOErsXSyca3Yyab2wJ4NpT1BmmlEAeif9C3A8P8+
         8/Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QZy73iwn0mRk3wjAi7x5BepN1zxlkLUpEV67mokAMag=;
        b=brbj3ZPPlwl5Djz4cl0yGVyokjc45Z2QjdaZ4YXRZCQKFeqSvSZ3XFZX7Iz6uL0H3g
         FydGdkvv2OHqOjGumMisZr/mf84osVTQO0vvP5B5xpSCnhi0a2UOsk1NifEGm/ZmZ9Gx
         ac7EuCiDVyqqSaAO8kSsFONOt2dLRNp9zgwidKLzPmilMqBN9Xi6Z4bpzKR9cZo8oExf
         9uv8nm86X9Rhrpm4uYO/viQL6/VpxxCG8CdeJ0qyLsf6NvYpj+v/pB+BAnS+2sdXTr13
         UGei2GOfm9UC5fJ0rd/QSsykoTBeTxErI+wWImke7WBa27IK8ikKD8nHA6WLf1lvaHD9
         rdWQ==
X-Gm-Message-State: ACgBeo07QydjuAGjzeIBtwSKmnhZAh7mXQw7D99gFr8hw2iMh8NJbRaX
        kVmkGhF3SM43GOJjdTIZX45OD71FUINKyOV/grU=
X-Google-Smtp-Source: AA6agR5qlSXOeSU4Vad+xtgIvlHuDoDOSvqUG+hd8ODfYXpsllohDOCQCth/ebYpTeynCBzGpaorUB4ZfZoCFvvyztM=
X-Received: by 2002:a17:907:2896:b0:730:983c:4621 with SMTP id
 em22-20020a170907289600b00730983c4621mr18433058ejc.502.1660070977133; Tue, 09
 Aug 2022 11:49:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220809140615.21231-1-memxor@gmail.com>
In-Reply-To: <20220809140615.21231-1-memxor@gmail.com>
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date:   Tue, 9 Aug 2022 11:49:25 -0700
Message-ID: <CAADnVQKBajvLk7L5Oe8jX9fp3XQznsLY_Od9sP2_z_ox-eMMXg@mail.gmail.com>
Subject: Re: [PATCH bpf v2 0/3] Don't reinit map value in prealloc_lru_pop
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
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

On Tue, Aug 9, 2022 at 7:06 AM Kumar Kartikeya Dwivedi <memxor@gmail.com> wrote:
>
> Fix for a bug in prelloc_lru_pop spotted while reading the code, then a test +
> example that checks whether it is fixed.
>
> Changelog:
> ----------
> v1 -> v2:
> v1: https://lore.kernel.org/bpf/20220806014603.1771-1-memxor@gmail.com
>
>  * Expand commit log to include summary of the discussion with Yonghong
>  * Make lru_bug selftest serial to not mess up refcount for map_kptr test

hmm. CI is still not happy.

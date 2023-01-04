Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9B4365E0AC
	for <lists+bpf@lfdr.de>; Thu,  5 Jan 2023 00:10:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234792AbjADXB6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 4 Jan 2023 18:01:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234724AbjADXBw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 4 Jan 2023 18:01:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2201900E
        for <bpf@vger.kernel.org>; Wed,  4 Jan 2023 15:01:51 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id bp15so52619723lfb.13
        for <bpf@vger.kernel.org>; Wed, 04 Jan 2023 15:01:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7hgjdjVmSCAjQXc9BiQk/HuDSt/hP8r1TxUdDybOj4U=;
        b=NrJQ1AnmZ+KiQFac+aUI/3XTaXALDlzNP19tJZ7NA0P36IhhjLBcoLK6AjFF0t22LT
         aYMqZp3wEnpst3zJ2a24MqXl3Wa340QDlDqhSrqdba4d413lOWQ3U3RPP2dAu/LUdhRY
         Zyus5KNzAdr8etWw7lppZz12HSv2ukmEzMaE7ygwpbohxCtEz8NE19WbiHss9v5MrK/c
         fBTLCJhuFFS0kXpzHlqxKWTqVPu8yToLXquqvzzK1OftV6KpxZvNpuK/S+H6XWH1nMqU
         COitpgELebMyMGSgvjqTvXjakFS9cntTOom7OShP0Jik1AXHnOqTqGtr6W1EdXGj7UPO
         zAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7hgjdjVmSCAjQXc9BiQk/HuDSt/hP8r1TxUdDybOj4U=;
        b=4g0KtLl4KDEUG4ulL0jdqAfnIUVuHu07Lyd8Nox+HYtG9B7C0WLxz924JvlDva2prs
         rKRE0HarXrI4m1YImeGEbqVAAD/m36s+DMvP9BOHMw9x9V+ZgtXqXsrdZ4ftkXA2xK3O
         mZNkwXLILMQZ3WP4k4mJ2mHLslxdIYF3mv46tSnaopQcro0sTFJMXSMP0tqIrOrBsjV6
         2JczSfSbnpJDtEqGXFukE6g1sJabWeCSEjCqY89Tbib2rovRAaTBn/dTHv7XDzY1Mq/D
         N0khg23fJm0O73CQ5yloycHDUtxJYQsTVV0iXGWYBJo/ed0pXW+SlWBFOz+lW+39sQln
         pv9w==
X-Gm-Message-State: AFqh2ko7B5g2DHbntKsoRfhIAohC9DT4Q4CBVlXjZJ6d+VCLFxDmbMcu
        Cu4xN1whOaQ5dvTNH2dWzdqVz1lQmU8aZc6zWkHX6woozuQ=
X-Google-Smtp-Source: AMrXdXs9yfXc0WrjMaB3QgZemxoLsslLPbqFRvVA6ybu/DANK179SeR4b1eIbd0FP8i6P1tVGYPvAMp8qyQ93IG7+cg=
X-Received: by 2002:aa7:c948:0:b0:48e:9afd:de63 with SMTP id
 h8-20020aa7c948000000b0048e9afdde63mr768221edt.232.1672872699761; Wed, 04 Jan
 2023 14:51:39 -0800 (PST)
MIME-Version: 1.0
References: <20230101083403.332783-1-memxor@gmail.com>
In-Reply-To: <20230101083403.332783-1-memxor@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 4 Jan 2023 14:51:27 -0800
Message-ID: <CAEf4BzaZuCWq5KrO-NPZjAya1etM4_zCFxWgva4zVDYaWJ89iw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1 0/8] Dynptr fixes
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Joanne Koong <joannelkoong@gmail.com>,
        David Vernet <void@manifault.com>,
        Eduard Zingerman <eddyz87@gmail.com>
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

On Sun, Jan 1, 2023 at 12:34 AM Kumar Kartikeya Dwivedi
<memxor@gmail.com> wrote:
>
> Happy New Year!
>
> This is part 2 of https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com.
>
> Changelog:
> ----------
> Old v1 -> v1
> Old v1: https://lore.kernel.org/bpf/20221018135920.726360-1-memxor@gmail.com
>
>  * Allow overwriting dynptr stack slots from dynptr init helpers
>  * Fix a bug in alignment check where reg->var_off.value was still not included
>  * Address other minor nits
>
> Kumar Kartikeya Dwivedi (8):
>   bpf: Fix state pruning for STACK_DYNPTR stack slots
>   bpf: Fix missing var_off check for ARG_PTR_TO_DYNPTR
>   bpf: Fix partial dynptr stack slot reads/writes
>   bpf: Allow reinitializing unreferenced dynptr stack slots
>   selftests/bpf: Add dynptr pruning tests
>   selftests/bpf: Add dynptr var_off tests
>   selftests/bpf: Add dynptr partial slot overwrite tests
>   selftests/bpf: Add dynptr helper tests
>

Hey Kumar, thanks for fixes! Left few comments, but I was also
wondering if you thought about current is_spilled_reg() usage in the
code? It makes an assumption that stack slots can be either a scalar
(MISC/ZERO/INVALID) or STACK_SPILL. With STACK_DYNPTR it's not the
case anymore, so it feels like we need to audit all the places where
we assume stack spill and see if anything should be fixed. Was just
wondering if you already looked at this?

>  kernel/bpf/verifier.c                         | 243 ++++++++++++++++--
>  .../bpf/prog_tests/kfunc_dynptr_param.c       |   2 +-
>  .../testing/selftests/bpf/progs/dynptr_fail.c |  68 ++++-
>  tools/testing/selftests/bpf/verifier/dynptr.c | 182 +++++++++++++
>  4 files changed, 464 insertions(+), 31 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/verifier/dynptr.c
>
>
> base-commit: bb5747cfbc4b7fe29621ca6cd4a695d2723bf2e8
> --
> 2.39.0
>

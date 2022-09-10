Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2ABA5B436E
	for <lists+bpf@lfdr.de>; Sat, 10 Sep 2022 02:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229748AbiIJAoQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 9 Sep 2022 20:44:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229690AbiIJAoO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 9 Sep 2022 20:44:14 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8AC2FC652;
        Fri,  9 Sep 2022 17:44:12 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id gh9so7814272ejc.8;
        Fri, 09 Sep 2022 17:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JIgqb5b60C8SmDMIEm+s+7Z4AskuEzxdfRuYH/CGCZE=;
        b=KjT2/7h4lMbloMYZZWErBlgfsEJzqgWBEH3BP6COYgwI1mG3PsjVp+CvvAs5Cz+fbS
         OXxEz0jUY3VZm2oZ4Ln5vXloM809c2PDIUI+tt1QraYNHo8jv1tWISzhWUxrosvYE5zZ
         L6slugx6ZYCXiGwX/eP+DCh1R4nawgR6mIS5sW1AU5aatw03k5VggnzF9F7WnIlSGGDz
         0tcCVtZ9f3ZoFCayp6vAt/Po0HY36kQhZjhV3PtEv6JnkUNbRGN1piPxlQPrQcv7VzeQ
         SvArKEoN5SxR9+kAKX14haT6V5dM4KFnOQgktMq66mLNvdsLRU3k+xwGxiMgNN4NjVS0
         oj9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JIgqb5b60C8SmDMIEm+s+7Z4AskuEzxdfRuYH/CGCZE=;
        b=5tvJ8TXOAxmQJ/rYYrReJ1RY/Vi5AA2T64x9QLauyEsRNKadIMk4ql1+g6/iPyGhtl
         52CRdNUhDSWlpXCHH25zlY3G3nVZs658/OAwiwRxZDiduivExsjdrGXP9vLydfdfGqX2
         nh0S2vLfzbdExAyMOLMCXaBPT3emIQ4zlu98DUTBvVLCF4PLX03wsctTEBLKTv2FCO8A
         UOKkcg7mZItmiKR+SpDKFSFs828ivXlsX+PKRGZleqtsKGOE0jvr+10VMgCpgCtxQpeA
         GWD9T4KykYNa/xEtAMAKWxlDJT1ZtdAkk2qNVMKlx9U4WD3CUXHcKSI+ddkv6YH2zPXP
         0keQ==
X-Gm-Message-State: ACgBeo1Aw0OU2LDff8qHv+AiJO1PL59LrAxe9o1Jr4IY5pWic4EQytrA
        PJARIz5/L+PAIU+6AF4TCBG8V8bMM6ccvEnkqJA=
X-Google-Smtp-Source: AA6agR7ZqKSHRNZnLs+LbXYkv/LNJ06v615sK2byxFJ6sF/4qxG1bzhnUcSFnWQH09ZZu7cz60xrhxBuVfkxDZuziTI=
X-Received: by 2002:a17:906:8454:b0:772:7b02:70b5 with SMTP id
 e20-20020a170906845400b007727b0270b5mr8878137ejy.114.1662770651341; Fri, 09
 Sep 2022 17:44:11 -0700 (PDT)
MIME-Version: 1.0
References: <94275aa1e5af4efea53f322f91b27380@huawei.com>
In-Reply-To: <94275aa1e5af4efea53f322f91b27380@huawei.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 9 Sep 2022 17:44:00 -0700
Message-ID: <CAEf4BzZw8R1UH4R_FmeAVAXAALmh0ETtMVkOKytvDTs_GxqbLg@mail.gmail.com>
Subject: Re: [PATCH v2] libbpf: Clean up legacy bpf maps declaration in bpf_helpers
To:     "Liuxin(EulerOS)" <liuxin350@huawei.com>
Cc:     "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "song@kernel.org" <song@kernel.org>, "yhs@fb.com" <yhs@fb.com>,
        "john.fastabend@gmail.com" <john.fastabend@gmail.com>,
        "kpsingh@kernel.org" <kpsingh@kernel.org>,
        "sdf@google.com" <sdf@google.com>,
        "haoluo@google.com" <haoluo@google.com>,
        "jolsa@kernel.org" <jolsa@kernel.org>,
        "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "854182924@qq.com" <854182924@qq.com>,
        "Yanan (Euler)" <yanan@huawei.com>,
        "Wuchangye (EulerOS)" <wuchangye@huawei.com>,
        Xiesongyang <xiesongyang@huawei.com>,
        "zhudi (E)" <zhudi2@huawei.com>,
        "kongweibin (A)" <kongweibin2@huawei.com>
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

On Tue, Sep 6, 2022 at 7:51 PM Liuxin(EulerOS) <liuxin350@huawei.com> wrote:
>
> Legacy bpf maps declaration were no longer supported in Libbpf 1.0, so it was time to remove the definition of bpf_map_def in bpf_helpers.h.

please make sure that commit log lines are wrapped at <80 characters
>
> LINK:[1] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0

don't add "LINK", just two spaces and then [0] and then refer to it
from the above as "supported in Libbpf 1.0 ([0])"


>
> Acked-by: Song Liu <song@kernel.org>
> Signed-off-by: Xin Liu<liuxin350@huawei.com>

space after name and before opening < is missing

> ---
> Changes in v2:
>     - Fix strange signatures
>

It looks good overall, but your patch doesn't apply. Please make sure
you base it on top of bpf-next's master and you use git send-email
which won't clobber the patch. Thanks.

> V1: https://lore.kernel.org/bpf/CAPhsuW7Em6q5hqiKWEZpJOaU5DTrZE+BPPHq+Chyz0-+-yQ_ZA@mail.gmail.com/T/#t
>
> tools/lib/bpf/bpf_helpers.h | 12 ------------
> 1 file changed, 12 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h index 867b73483..9cad13e7f 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -167,18 +167,6 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot) } #endif
>
> -/*
> - * Helper structure used by eBPF C program
> - * to describe BPF map attributes to libbpf loader
> - */
> -struct bpf_map_def {
> -       unsigned int type;
> -       unsigned int key_size;
> -       unsigned int value_size;
> -       unsigned int max_entries;
> -       unsigned int map_flags;
> -} __attribute__((deprecated("use BTF-defined maps in .maps section")));
> -
> enum libbpf_pin_type {
>         LIBBPF_PIN_NONE,
>         /* PIN_BY_NAME: pin maps by name (in /sys/fs/bpf by default) */
> --
> 2.33.0

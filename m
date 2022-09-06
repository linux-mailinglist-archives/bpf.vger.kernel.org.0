Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7509F5AF5EB
	for <lists+bpf@lfdr.de>; Tue,  6 Sep 2022 22:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbiIFUbn (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 6 Sep 2022 16:31:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiIFUbm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 6 Sep 2022 16:31:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B0090C48;
        Tue,  6 Sep 2022 13:31:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EF6836157D;
        Tue,  6 Sep 2022 20:31:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59216C433D6;
        Tue,  6 Sep 2022 20:31:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662496300;
        bh=r6C8I6H9slvWl19aG25ndT1qrQs1nCb5lub5kG6oMVM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IBxJB0kY8IdmdiwIctGlt20BRhMPgy/q7I6Ft2NI2cnP5lk97gNaFqVFwkfvmFYwp
         z8K7gbDiLCKZkB9WBFvnysDzlY4vnkqQbhmMClOEXhiJZ1YXe3QogxbGGr3D8FL6n0
         V9pi7j4lewk7w1lcu0NDT8o5a4HiUlGpt2pnKcHQGae7PIAb+cswhzsHp6lH+cIUM+
         9h85gOnc15YhRY7rB5ZyNO+Z16sbSdSHLK/OuKFIrko406Sp3DagqOsSttzKDc5cSr
         vX0S/ZvwybNeEIg/TDK2AMM/A77ld9H3Mq68rzs4xXy4GKhKbLMCYe5xMI9oovwR8F
         sWGeu6GvX2qqQ==
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-1278624b7c4so12847074fac.5;
        Tue, 06 Sep 2022 13:31:40 -0700 (PDT)
X-Gm-Message-State: ACgBeo38/WPfIq/+csrtKdeNytkYK4dE9BgA3DlrMqRMybVcIHLnUZvW
        SpeOQ60tysCDB+AeUlvuCZYfM6gg5yTc3bdz8gc=
X-Google-Smtp-Source: AA6agR5bslcLEkAX68DDQ1hm4d4hlb0UQqBdySwDdLluNxVqQfl/fEkrRXLkeHf66mthaEsUmz5zqVwPriCVRhTLJmk=
X-Received: by 2002:a05:6808:195:b0:342:ed58:52b5 with SMTP id
 w21-20020a056808019500b00342ed5852b5mr86646oic.22.1662496299511; Tue, 06 Sep
 2022 13:31:39 -0700 (PDT)
MIME-Version: 1.0
References: <6d349d1047f44001b926f80ad5416245@huawei.com>
In-Reply-To: <6d349d1047f44001b926f80ad5416245@huawei.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 6 Sep 2022 13:31:28 -0700
X-Gmail-Original-Message-ID: <CAPhsuW7Em6q5hqiKWEZpJOaU5DTrZE+BPPHq+Chyz0-+-yQ_ZA@mail.gmail.com>
Message-ID: <CAPhsuW7Em6q5hqiKWEZpJOaU5DTrZE+BPPHq+Chyz0-+-yQ_ZA@mail.gmail.com>
Subject: Re: [PATCH] libbpf: Clean up legacy bpf maps declaration in bpf_helpers
To:     "Liuxin(EulerOS)" <liuxin350@huawei.com>
Cc:     "andrii@kernel.org" <andrii@kernel.org>,
        "daniel@iogearbox.net" <daniel@iogearbox.net>,
        "ast@kernel.org" <ast@kernel.org>,
        "martin.lau@linux.dev" <martin.lau@linux.dev>,
        "yhs@fb.com" <yhs@fb.com>,
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
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Mon, Sep 5, 2022 at 1:38 AM Liuxin(EulerOS) <liuxin350@huawei.com> wrote:
>
> Legacy bpf maps declaration were no longer supported in Libbpf 1.0,
> so it was time to remove the definition of bpf_map_def in
> bpf_helpers.h.
>
> LINK:[1] https://github.com/libbpf/libbpf/wiki/Libbpf:-the-road-to-v1.0
>
> Signed-off-by: Liu Xin<liuxin350@huawei.com>

This looks a little weird.

From: "Liuxin(EulerOS)" <liuxin350@huawei.com>

Please fix your name in git config:

Otherwise,

Acked-by: Song Liu <song@kernel.org>

> ---
> tools/lib/bpf/bpf_helpers.h | 12 ------------
> 1 file changed, 12 deletions(-)
>
> diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
> index 867b73483..9cad13e7f 100644
> --- a/tools/lib/bpf/bpf_helpers.h
> +++ b/tools/lib/bpf/bpf_helpers.h
> @@ -167,18 +167,6 @@ bpf_tail_call_static(void *ctx, const void *map, const __u32 slot)
> }
> #endif
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

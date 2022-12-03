Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8701C6412BD
	for <lists+bpf@lfdr.de>; Sat,  3 Dec 2022 01:45:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235266AbiLCApi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 2 Dec 2022 19:45:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbiLCApT (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 2 Dec 2022 19:45:19 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36959FB89F;
        Fri,  2 Dec 2022 16:39:25 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id vv4so15101024ejc.2;
        Fri, 02 Dec 2022 16:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ETGHnnHIgxVXTPrH41fr6V5n9u5cAImypbTy8FSNQvE=;
        b=gZbkLKMKM3PWDeS7TFmqS8aTdK1AcZgh52X9w6XbiC6g2MpbdBbVfcMOp9Gm22JJpo
         yBXRe6pbM6oG+VNyfrVkXSASYlnyrzsuuXgpciNQEE4LEr/7BIBRkGNcMdnNEUkAcVbE
         62MMuINAOAxO5W65oqWQhs3XMgOy0exKGQHSqX4U9K4n/lrxz859XgKiK94V4ffSoUlr
         300UVAN9/l06mFDeTn0AufpU/wqD2F7/4dKf12P2eBV/JHMDwgrM+SfZVaM9E7UdSE8L
         tfdzuKo0HaXgz2ebn/sbTdDZ0NupufwWjARcWA+XP1gGi4CfDpHzGMLahQTUX7pIgKkQ
         myFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ETGHnnHIgxVXTPrH41fr6V5n9u5cAImypbTy8FSNQvE=;
        b=0d2uGRgKoQSbdr5G0nbyVPHAkC2DP+r+oXHu93FzRoN1rANrXCZ0O+wnjMk2wNf12X
         DTWm6C++jmDN9cM37sWiUK6S5AzHuEq4KiR2qqJlHW4QTaxu8sPk2MGuhCj33diYYgX0
         zXP2fSAffN+1moSkEr/gfSWjHi5DXBm2x8mXUGp3YW1Vz7lofDntDou736KgmKRe8Wvf
         fTI1Ge9P69xsNmJ/EFsccCyX40KSEBiLW8DWCwaFxGo9Eep7+2pufGV1MiSRabqAmaY1
         N+rYX4sJCnKN9Fr/aWRdTHxSvplGxg1lXlXsfGx6CmxgR7t0VCZrWBRpN27flXHWMmTL
         0lVQ==
X-Gm-Message-State: ANoB5pkAvFftCZyukeRg4DV9FZ2p37FGu+QZzYaAcMZGYTkV4yKnNbB3
        d6P+ZLH8SmAPYpMBi74jxgLULFghHX+9Es85riw=
X-Google-Smtp-Source: AA0mqf6S0zKLumOuy+xJJRojFPfa4XGXSCvoqkQhH/bjqXp+yjbOGtx9TRXRU/lfyuyN3/Ana9qNedBc+eLdwBP0LGE=
X-Received: by 2002:a17:906:414c:b0:7a9:ecc1:2bd2 with SMTP id
 l12-20020a170906414c00b007a9ecc12bd2mr50717390ejk.545.1670027963525; Fri, 02
 Dec 2022 16:39:23 -0800 (PST)
MIME-Version: 1.0
References: <20221202153816.1180450-1-timo.hunziker@gmx.ch>
In-Reply-To: <20221202153816.1180450-1-timo.hunziker@gmx.ch>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 2 Dec 2022 16:39:11 -0800
Message-ID: <CAEf4BzbzgDfkvEtcQbCE1wZ4YHOTTWwr3rfX3D63RfD08qGj-Q@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: parse usdt args without offset on x86
 (e.g. 8@(%rsp))
To:     Timo Hunziker <timo.hunziker@gmx.ch>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, jolsa@google.com,
        linux-kernel@vger.kernel.org
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

On Fri, Dec 2, 2022 at 7:39 AM Timo Hunziker <timo.hunziker@gmx.ch> wrote:
>
> Parse USDT arguments like "8@(%rsp)" on x86. These are emmited by
> systemtap. The syntax is a mixture between the "memory dereference
> case" and the "register read case" as the offset is zero but the
> register is wrapped in parentheses. We treat them the same as the
> the "register read case".

wait, why? I'd assume this is equivalent to 8@0(%rsp) and that's
actually the USDT_ARG_REG_DEREF case? I.e., we read the value of %rsp
and then use that as a pointer to a memory.

>
> I've tested that this fixes the "unrecognized arg #N spec: 8@(%rsp).."
> error I've run into when attaching to a probe with such an argument.
> Attaching and reading the arguments works.
>
> Something similar might be needed for the other supported
> architectures.
>
> ref: https://github.com/libbpf/libbpf/issues/559
>
> Signed-off-by: Timo Hunziker <timo.hunziker@gmx.ch>
> ---
>  tools/lib/bpf/usdt.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> index b8daae265f99..5e7ec7ad8ad7 100644
> --- a/tools/lib/bpf/usdt.c
> +++ b/tools/lib/bpf/usdt.c
> @@ -1233,6 +1233,14 @@ static int parse_usdt_arg(const char *arg_str, int arg_num, struct usdt_arg_spec
>                 if (reg_off < 0)
>                         return reg_off;
>                 arg->reg_off = reg_off;
> +       } else if (sscanf(arg_str, " %d @ ( %%%15[^)] ) %n", &arg_sz, reg_name, &len) == 2) {
> +               /* Register read case with parentheses, e.g., 8@(%rsp) */
> +               arg->arg_type = USDT_ARG_REG;

while you implemented it as "return %rsp value", it's a very different case


> +               arg->val_off = 0;
> +               reg_off = calc_pt_regs_off(reg_name);
> +               if (reg_off < 0)
> +                       return reg_off;
> +               arg->reg_off = reg_off;
>         } else if (sscanf(arg_str, " %d @ %%%15s %n", &arg_sz, reg_name, &len) == 2) {
>                 /* Register read case, e.g., -4@%eax */
>                 arg->arg_type = USDT_ARG_REG;
> --
> 2.36.2
>

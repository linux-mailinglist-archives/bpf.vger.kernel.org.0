Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB711567D95
	for <lists+bpf@lfdr.de>; Wed,  6 Jul 2022 07:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiGFFFu (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 6 Jul 2022 01:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbiGFFFu (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 6 Jul 2022 01:05:50 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58E13192A6
        for <bpf@vger.kernel.org>; Tue,  5 Jul 2022 22:05:49 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id lg18so5255196ejb.0
        for <bpf@vger.kernel.org>; Tue, 05 Jul 2022 22:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Gpk8AVT2xRi5t3jKe08PVPmP7WlyKw3+itmLPtRM7Kw=;
        b=jDqF/3kiDJ9rk6zg2V2jfh6Pov2eyuw+E9PTozME2RqEp4prra9JTR6Uhpyhy776GH
         mpLLPOE3T5Noi8EzAgWm07A9KAnpF8a0Xk5txa3BcZ/7NwUPIxgqu2LXjiBpvl4Xh5bR
         OpNlwG5u2GjkNV5iWHLly/rvH6FrxLZJV0+ucvthqxPpxllGur2O4nFRlxPjyz935Jja
         5q/tBxSy7b0Ds+OADS+pPCDtGazwUOh+QWsx6LuFcqmKWMeZZCqGnNSqFljV7PEDi5J/
         vSnalwWLvyeuBUR+cWbj/QZpvP8YcSRjntvUEIo6KDQlyVZ3fDA/QdSB2jN6DAuC8Z7J
         dwQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Gpk8AVT2xRi5t3jKe08PVPmP7WlyKw3+itmLPtRM7Kw=;
        b=MqNb2zw5sLmfREUczifF9I+6IZ2gPjdhkMqA+yLCCNkPk7vhlHIKGDoOmOo/V49iTB
         zaXuOr29ECFC0e7NhZYqO/QkvvYZz/C4VbVxL4nI0EXs/V5iF9xGYj0RiEHmvCZUn+dR
         zaMXkA+WUBKWHpCV0aJc6wYupAl8qzik2LXqcfeRi2ik117aoNK5rNdUvRTAAOENJSk7
         14uJ1IlZh5dINnWoa9WUsV1AnfFDc509OKwHHudb0WOGUTcLIJ5PPTFk/3E27rX1TnP7
         M84uOwlJq2IV4R4na6xq/xetJecJIOHUtGYZFtoSXKzF5utMEmmSUPyapoOmg3eEbFJw
         mouw==
X-Gm-Message-State: AJIora+Z57nPDRmuxJMloZwyQG+tCGwXXcAmcKEQvgZ3xvyrWqY7mkc5
        9f2g8b8cpjFVZ1xS9/8PibXqyggLATt27qcc08c=
X-Google-Smtp-Source: AGRyM1sd5IPKxozBn6Fnaq6t7Jtrhi53T+nPQBRsx0aA3R8ofsJKaEh1yRY/opDAjNDh0xX85eBD2dk2ZCcOH4ebloM=
X-Received: by 2002:a17:906:8447:b0:72a:f120:50cd with SMTP id
 e7-20020a170906844700b0072af12050cdmr3492384ejy.114.1657083947927; Tue, 05
 Jul 2022 22:05:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220704140850.1106119-1-hengqi.chen@gmail.com>
In-Reply-To: <20220704140850.1106119-1-hengqi.chen@gmail.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Tue, 5 Jul 2022 22:05:37 -0700
Message-ID: <CAEf4Bzbo0GbLv0YdyLLZq8myGK=eGz_GgYbifw1LMu2Adxhjvg@mail.gmail.com>
Subject: Re: [PATCH bpf-next] libbpf: Error out when missing binary_path for
 USDT attach
To:     Hengqi Chen <hengqi.chen@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>
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

On Mon, Jul 4, 2022 at 7:09 AM Hengqi Chen <hengqi.chen@gmail.com> wrote:
>
> The binary_path parameter is required for bpf_program__attach_usdt().
> Error out when user attach USDT probe without specifying a binary_path.
>

This is a required parameter, libbpf doesn't add pr_warn() for every
`const char *` parameter that the user incorrectly passes NULL for
(e.g., bpf_program__attach_kprobe's func_name). If you think
bpf_program__attach_usdt() doc comment about this is not clear enough,
let's improve the documentation instead of littering libbpf source
code with Java-like NULL checks everywhere.

> Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
> ---
>  tools/lib/bpf/libbpf.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 8a45a84eb9b2..5e4153c5b0a6 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -10686,6 +10686,12 @@ struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
>                 return libbpf_err_ptr(-EINVAL);
>         }
>
> +       if (!binary_path) {
> +               pr_warn("prog '%s': USDT attach requires binary_path\n",
> +                       prog->name);
> +               return libbpf_err_ptr(-EINVAL);
> +       }
> +
>         if (!strchr(binary_path, '/')) {
>                 err = resolve_full_path(binary_path, resolved_path, sizeof(resolved_path));
>                 if (err) {
> --
> 2.30.2

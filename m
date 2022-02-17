Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CDAE4BAC11
	for <lists+bpf@lfdr.de>; Thu, 17 Feb 2022 22:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232099AbiBQVuG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Feb 2022 16:50:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbiBQVuF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Feb 2022 16:50:05 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DCF165C06;
        Thu, 17 Feb 2022 13:49:50 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id z2so5360998iow.8;
        Thu, 17 Feb 2022 13:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Xms7LO7cPVPOQl8+2SFpWEDKuxRRkay4Sft0SGc9bY=;
        b=NpXhdUseollFh3xfuow1UWeu6kuIlc8MEd70XdcWOJ0ZWNwN8j8mLttgZn39Nlawfz
         fx6xL2+OweiX7BAMy6TAENXNOXyhncpxSHYhn5OT7pzWtiniNjXPWRfYbuvCZ+wQHgOf
         K9N0pvl+B3SS2gJ3+XoFl2Bwe5c6cxXS+bNdFZTsdKfV2nXPFy/vkUR4VJM6H8HuacQ0
         8hmRjOnTYRhCRx6AxhamgvkGTA9udu6XUYO71bFvD760Fpqe1X04sEIwvfw3+zDnSEFY
         ZJcQLy/L/iqiFZilkWQDtezVVTxbcaOj95ijAZs5UGIWUvo9e4VYsnGibM+JNyjnTQG1
         d3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Xms7LO7cPVPOQl8+2SFpWEDKuxRRkay4Sft0SGc9bY=;
        b=jz4evxBYzGTofZZVxx4RKMHEre2FHsXHmGbRNVnOgY/PEEjIcf7k+yTSi4uf3wmNVl
         WW0AX9IEmi15/ZgG/MLCqpDfPV7CEBNPdWCmyxMysdreTY4gf0OT9wIgFKEBHAHvGaRb
         FIX+uBcSwj9ZZS+fjLFmvmUpeG+DCJLlrPyrKPU/kCrfnMMJ7RRzxtAnCg7e5IpC0Pbz
         eR/V5baAgwGMnr50UkU27Mj2OHpeq7tswaEcEeiFynbP7KUBw/Yw7Yt81rtM2GRBokpH
         IVSk3bTbn9JeWtVAxC5pT9Mug/KX1O//rVDvd6ZzQYy5xyv2dZ5ZOU9abO0Gpl2BCftk
         0Amw==
X-Gm-Message-State: AOAM533edzeEeAFO3D1qk7aUVwBgx99p5LbrNxF3Rilv3a56mrEtKhjU
        jDc9OBIA+MisC/A8fpidC+qWtcI8apTeGueXud8=
X-Google-Smtp-Source: ABdhPJyWMI8xx72jX8VcSld5R1mofbY2wDIJA5trPclGm8VjqJpjnrrqUbiwvg0BoAGuL51kWFEXJ6xX+Y3qGLlGLuY=
X-Received: by 2002:a05:6638:22c3:b0:30a:2226:e601 with SMTP id
 j3-20020a05663822c300b0030a2226e601mr3297478jat.237.1645134590110; Thu, 17
 Feb 2022 13:49:50 -0800 (PST)
MIME-Version: 1.0
References: <20220217131916.50615-1-jolsa@kernel.org> <20220217131916.50615-3-jolsa@kernel.org>
In-Reply-To: <20220217131916.50615-3-jolsa@kernel.org>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Thu, 17 Feb 2022 13:49:39 -0800
Message-ID: <CAEf4BzYoCioENBuXEb-B7ZK8D0YFzs_j3XFN8NS35PAWY04O+g@mail.gmail.com>
Subject: Re: [PATCH 2/3] perf tools: Remove bpf_map__set_priv/bpf_map__priv usage
To:     Jiri Olsa <jolsa@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        "linux-perf-use." <linux-perf-users@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>
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

On Thu, Feb 17, 2022 at 5:19 AM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Both bpf_map__set_priv/bpf_map__priv are deprecated
> and will be eventually removed.
>
> Using hashmap to replace that functionality.
>
> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  tools/perf/util/bpf-loader.c | 62 ++++++++++++++++++++++++++++++++----
>  1 file changed, 55 insertions(+), 7 deletions(-)
>

[...]

> +static int map_set_priv(struct bpf_map *map, void *priv)
> +{
> +       void *old_priv;
> +
> +       if (!bpf_map_hash) {
> +               bpf_map_hash = hashmap__new(ptr_hash, ptr_equal, NULL);
> +               if (!bpf_map_hash)

same as in previous patch, on error this is not going to be NULL

> +                       return -ENOMEM;
> +       }
> +
> +       old_priv = map_priv(map);
> +       if (old_priv) {
> +               bpf_map_priv__clear(map, old_priv);
> +               return hashmap__set(bpf_map_hash, map, priv, NULL, NULL);
> +       }
> +       return hashmap__add(bpf_map_hash, map, priv);
> +}
> +

[...]

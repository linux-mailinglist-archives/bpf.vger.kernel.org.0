Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3922B53D358
	for <lists+bpf@lfdr.de>; Fri,  3 Jun 2022 23:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349501AbiFCVuQ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 3 Jun 2022 17:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349672AbiFCVuO (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 3 Jun 2022 17:50:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EACF580EE
        for <bpf@vger.kernel.org>; Fri,  3 Jun 2022 14:50:08 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id a15so14568582lfb.9
        for <bpf@vger.kernel.org>; Fri, 03 Jun 2022 14:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Sp99gRlLvCbASvYFNGwlBpCjYDNOgy5HzqofWU+WCMU=;
        b=Fngwpq/Pt5foeV933ausIEey7mqpWPd91mTvYwp5vLf2qpNVn/y1+wc43swkDfsGvY
         s64FlSSZKG+iAuBbM2KuI1BF0I03VoFhiDVC1KzeJD7VYir93sAjA7F3Nkhwr8vUF57+
         amKtm4a2MQatzWpmnpY2sLEsX15MjgjSvxWxMr4j2MSKL87J7KIRhzxWTVIoFuTuQjUV
         pviPdUEfG5iVaNskmJ+1EtDVy21ZgxD98knHFlxar4i+SZEyKNV5Zpbm7vyQd/dM75NC
         znbdx+6TqOpdN2Nxk9j0gEBa2IhGZ/8HtCDJKekuZsv2djnAEHJvopqMeb13Vexc0lK0
         jVpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Sp99gRlLvCbASvYFNGwlBpCjYDNOgy5HzqofWU+WCMU=;
        b=u/xsLM/5I7L+qVKnkej+d2uWTaYVP2JcyUDCR9dvx9+udBCM/4SK3t16GOQJOxDIMS
         50JUp6bTYB270JZSoKL9lUOQrg5v6BaPyOpSjuL6yK7OPB/Q4IX4mmrtLEgptk333BQo
         vvHApzFrxKPsHrBfxrRzSK8BO8wcJAQc1POJt58voxxpQ5k4WvZF2JRTUWSSYTRsXMNL
         GS5Y1sgp69X2AueMjXQu3Ox8m+tCxM5/IH6L1/ULfTbefkt3w+KOMYzStj6/8mvvPl9k
         pW23t1+zuvQG/f6vwMtmoXjdGXZO25cMtYwlLztxQEYNo2+pstWJxvFVtVfhh35Lo+Eq
         YcqA==
X-Gm-Message-State: AOAM532GUDWwmPvcheTJHTCeATmt783ifoeil1+SGOVRGDBEaXABIL1Q
        8g+2OYjZTKKSTiWL9iBO1u7swr6xu0pyqPwUVKg=
X-Google-Smtp-Source: ABdhPJyHaUqy3kmgK5gostdbr6ABugx7DX3eQn6LIiXy/H5t3c10NGJxD/aGxi0a+obL4U08lI72Nd9wS9XwGgpe+zo=
X-Received: by 2002:a05:6512:2286:b0:473:e3bb:db02 with SMTP id
 f6-20020a056512228600b00473e3bbdb02mr7945508lfu.302.1654293006088; Fri, 03
 Jun 2022 14:50:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220603015855.1187538-1-yhs@fb.com> <20220603015947.1191456-1-yhs@fb.com>
In-Reply-To: <20220603015947.1191456-1-yhs@fb.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Fri, 3 Jun 2022 14:49:54 -0700
Message-ID: <CAEf4Bza-jGuLGXdBswUi5EaA2xw=c=yPj7REurdwAan9xB7uDg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 10/18] libbpf: Add enum64 relocation support
To:     Yonghong Song <yhs@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
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

On Thu, Jun 2, 2022 at 6:59 PM Yonghong Song <yhs@fb.com> wrote:
>
> The enum64 relocation support is added. The bpf local type
> could be either enum or enum64 and the remote type could be
> either enum or enum64 too. The all combinations of local enum/enum64
> and remote enum/enum64 are supported.
>
> Signed-off-by: Yonghong Song <yhs@fb.com>
> ---
>  tools/lib/bpf/btf.h       |  7 +++++
>  tools/lib/bpf/libbpf.c    |  7 ++---
>  tools/lib/bpf/relo_core.c | 54 +++++++++++++++++++++++++++------------
>  3 files changed, 48 insertions(+), 20 deletions(-)
>

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
> index 83312c34007a..9fb416eb5644 100644
> --- a/tools/lib/bpf/btf.h
> +++ b/tools/lib/bpf/btf.h
> @@ -537,6 +537,13 @@ static inline bool btf_is_any_enum(const struct btf_type *t)
>         return btf_is_enum(t) || btf_is_enum64(t);
>  }
>

[...]

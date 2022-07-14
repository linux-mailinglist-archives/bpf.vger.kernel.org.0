Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A79665757E6
	for <lists+bpf@lfdr.de>; Fri, 15 Jul 2022 01:15:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232319AbiGNXPJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Jul 2022 19:15:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiGNXPI (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Jul 2022 19:15:08 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADEB470E49
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 16:15:07 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id va17so6153859ejb.0
        for <bpf@vger.kernel.org>; Thu, 14 Jul 2022 16:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vFT0gtQ5Fhe3bkychWRacJcdfGvp1Y8aCikkIll1xsw=;
        b=Wlx8nGbJz65HtUP+Yhy1hQZjGQBj4xf88Uv6fVM3IQITeZ7Btfw9bs/1TIT8XFa8be
         QVvDpbxobuZaPwm3IwFik4SH6xFZKwbFYvvaxERp3KEqJRcMWCPYl0q6u+67l4ulgVWr
         5f1bwN2D9gKNMv9Ej1Rc+QYoG/QtN5XneiH+XwflC4anQOD5tqzqDQmgUDA8yJrkh3HQ
         PEt/fdy/QU1BbY+wJWoFBGwtUTm0uc6cMTmnrxQDp6WojDSH++wh4vXa6k3GRsmUjMMd
         jkwGq3pdYfBC79J2h7FB0qhLRh3ColkXBNLzvii/la2NNY1sx0sJPK1h1rXwKm1CvOf8
         ALGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vFT0gtQ5Fhe3bkychWRacJcdfGvp1Y8aCikkIll1xsw=;
        b=aGHVjRzdVVt6MON6ZZeI1SgmBvYlAglycMHsmkkwyLQmyoYW736O+ui/DZT5mcsP/j
         tYNY9tBi+mJ5Jbyt/jZZjn5uqlMtMimlJ4Q7n7KPuOATJtYlBvYi/rvEooEK9JhoSZhJ
         jQtYqNR4hSZQYfBtf6Uw4D9CDtagw4/0boYZd7VRCPQ2G/sHhBcllo+LKOwavFsI4Ak/
         aM9U1TDUMxaDq0hV/v68dh3vzXzHl5r2W2fmvrfzx+kces9PGDkhY/KRXCzEwmce/3iN
         4sssCfwv36vcOdt0YJeMjUYGb/af0kS+LeNYhZ+QghEvZHww6dgp4ws/UEkuUXQ/RpF+
         qAmA==
X-Gm-Message-State: AJIora/fy+sj3CRXqhQp7yR6atco2nbL7/JKi1pfYMf976dpZ4X7aZ2p
        vcyBJ9TRizDDOzZg3BroNYbEJsWNRPPfaiUPunpC4XGH
X-Google-Smtp-Source: AGRyM1uvifZuLETSGMqgvfJ2sllVs+21l+EyXjTQNvk85ZzlSirFvTGiMVJxrGZawLkGnRuziUDClH9AYMuGvwTY79A=
X-Received: by 2002:a17:906:6c82:b0:709:f868:97f6 with SMTP id
 s2-20020a1709066c8200b00709f86897f6mr10836093ejr.555.1657840506100; Thu, 14
 Jul 2022 16:15:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220714224721.2615592-1-joannelkoong@gmail.com>
In-Reply-To: <20220714224721.2615592-1-joannelkoong@gmail.com>
From:   Joanne Koong <joannelkoong@gmail.com>
Date:   Thu, 14 Jul 2022 16:14:55 -0700
Message-ID: <CAJnrk1ZcDjMVPgf2QSfmjJDjmWEGp0h0ZXuUEPByv9w542txmw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v1] bpf: fix bpf_skb_pull_data documentation
To:     bpf <bpf@vger.kernel.org>
Cc:     Daniel Borkmann <daniel@iogearbox.net>, quentin@isovalent.com,
        Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>
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

On Thu, Jul 14, 2022 at 3:48 PM Joanne Koong <joannelkoong@gmail.com> wrote:
>
> Fix documentation for bpf_skb_pull_data() helper for
> when flags == 0.
sorry, this commit message should be "when len == 0" (not flags).
>
> Fixes: fa15601ab31e ("bpf: add documentation for eBPF helpers (33-41)")
> Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
> ---
>  include/uapi/linux/bpf.h       | 3 ++-
>  tools/include/uapi/linux/bpf.h | 3 ++-
>  2 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
> index 379e68fb866f..a80c1f6bbe25 100644
> --- a/include/uapi/linux/bpf.h
> +++ b/include/uapi/linux/bpf.h
> @@ -2361,7 +2361,8 @@ union bpf_attr {
>   *             Pull in non-linear data in case the *skb* is non-linear and not
>   *             all of *len* are part of the linear section. Make *len* bytes
>   *             from *skb* readable and writable. If a zero value is passed for
> - *             *len*, then the whole length of the *skb* is pulled.
> + *             *len*, then all bytes in the head of the skb will be made readable
> + *             and writable.
>   *
>   *             This helper is only needed for reading and writing with direct
>   *             packet access.
> diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
> index 379e68fb866f..a80c1f6bbe25 100644
> --- a/tools/include/uapi/linux/bpf.h
> +++ b/tools/include/uapi/linux/bpf.h
> @@ -2361,7 +2361,8 @@ union bpf_attr {
>   *             Pull in non-linear data in case the *skb* is non-linear and not
>   *             all of *len* are part of the linear section. Make *len* bytes
>   *             from *skb* readable and writable. If a zero value is passed for
> - *             *len*, then the whole length of the *skb* is pulled.
> + *             *len*, then all bytes in the head of the skb will be made readable
> + *             and writable.
>   *
>   *             This helper is only needed for reading and writing with direct
>   *             packet access.
> --
> 2.30.2
>

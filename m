Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22D1C6C5A89
	for <lists+bpf@lfdr.de>; Thu, 23 Mar 2023 00:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbjCVXhh (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Mar 2023 19:37:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjCVXhg (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Mar 2023 19:37:36 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C105234ED
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:37:34 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id cy23so79522783edb.12
        for <bpf@vger.kernel.org>; Wed, 22 Mar 2023 16:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679528252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FP9qd+JXXg9JacRuJM7C1p2hEvWlA3zoQa44MGvEN9M=;
        b=PZVy96D60I/6p9fVSABW/77a8197YH8zOCSNa+x7JLfkzMdeX/YDSQvfuEZkzU/n5w
         tstTtIEgdOM4FGdeJPKFv7cfJ9g66HtXYUwR+xWImR31e4s7XPHQ89rtOPLIfyx+CAUl
         bMuOIBq5g0VJ9CuSF3wtHPGcmm2vi8OtSwIsPZLH0sE1rDhGp9UK7tRBhGi6pqHM2VAE
         eTkBm95FwuOXHzitxis/C1S1vcSNsbMCy1hVV79HK8l1VDeI3bWzzNGRQ+iwqCGG0P4L
         xuTC6APMlWQCbXeLtk8fJgNrKW68QO+ewnpXxStO26W6hiratoqEPGyRisHfDwsz+gWM
         GtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679528252;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FP9qd+JXXg9JacRuJM7C1p2hEvWlA3zoQa44MGvEN9M=;
        b=en6nC80wDzhh4ag/o55SFj/4szV7Ed+oIgFv0jLEO3ewh60wIrXq7VChJZBocjvbr8
         HiA/lX67ypRbq4YTC/+lSs4VTkbzZsrLCOIePWBegc5wvieifh8hc/Z0vUkwoW+h+n4+
         xnWp5VyDueGKUaAHbIGDZDPzT8sP9SUBYCuFgsIstDKJA+hZzPNxfZC7LtVMDVROwqzn
         DQAPn181zKBR8+J9ua/lOJ+CaLBvBX9liO7j1aR4i9B60JW7VhHFI2CbksK32jG0hDUi
         wyTWbbwLp7Yd7RLUt86Z2UF6OyKDsSmFFnWAaERtotDpyDTdlOfEvmc+GEVkDGBo6De2
         Naaw==
X-Gm-Message-State: AO0yUKU/umpeSKw9mtIQY+2JRxpSOVKxZb+Q+xxXZ75k7lLjTlkszFLx
        9wbq32yAZPlOMiH/iDlXsdQgKGvi9nxyYZEXbNo=
X-Google-Smtp-Source: AK7set9V7sDzIBP54FpFND6mTUrngza8nK6U2keZDzy3NiEnbw/XUfZA58vOWEkk1Ob2l7qTfCOiFDnNHnJpZYeInos=
X-Received: by 2002:a17:906:148d:b0:92d:591f:645f with SMTP id
 x13-20020a170906148d00b0092d591f645fmr4362813ejc.5.1679528252588; Wed, 22 Mar
 2023 16:37:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230321232813.3376064-1-kuifeng@meta.com> <20230321232813.3376064-6-kuifeng@meta.com>
In-Reply-To: <20230321232813.3376064-6-kuifeng@meta.com>
From:   Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date:   Wed, 22 Mar 2023 16:37:20 -0700
Message-ID: <CAEf4BzZzm__1gf=ycm5xJBQwaW_rORQfd5oQFOcB09q=gZ2Wvw@mail.gmail.com>
Subject: Re: [PATCH bpf-next v10 5/8] bpf: Update the struct_ops of a bpf_link.
To:     Kui-Feng Lee <kuifeng@meta.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, martin.lau@linux.dev,
        song@kernel.org, kernel-team@meta.com, andrii@kernel.org,
        sdf@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Tue, Mar 21, 2023 at 4:28=E2=80=AFPM Kui-Feng Lee <kuifeng@meta.com> wro=
te:
>
> By improving the BPF_LINK_UPDATE command of bpf(), it should allow you
> to conveniently switch between different struct_ops on a single
> bpf_link. This would enable smoother transitions from one struct_ops
> to another.
>
> The struct_ops maps passing along with BPF_LINK_UPDATE should have the
> BPF_F_LINK flag.
>
> Signed-off-by: Kui-Feng Lee <kuifeng@meta.com>
> ---

Overall API and LINK_UPDATE handling looks good to me.

Acked-by: Andrii Nakryiko <andrii@kernel.org>

>  include/linux/bpf.h            |  3 +++
>  include/uapi/linux/bpf.h       | 21 +++++++++++----
>  kernel/bpf/bpf_struct_ops.c    | 48 +++++++++++++++++++++++++++++++++-
>  kernel/bpf/syscall.c           | 34 ++++++++++++++++++++++++
>  net/ipv4/bpf_tcp_ca.c          |  6 +++++
>  tools/include/uapi/linux/bpf.h | 21 +++++++++++----
>  6 files changed, 122 insertions(+), 11 deletions(-)
>

[...]

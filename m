Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7F86D0C69
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 19:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231270AbjC3RMz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 13:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbjC3RMv (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 13:12:51 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6314EE38D
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:12:47 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id i5so79451513eda.0
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:12:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680196366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IvGUSi065rPVm3ZfYKGK5MDm9PmleP65euGwVIifD5Y=;
        b=bkJhB109950NwiVqXUBU2jB0u7cV59c5mL9v4qsKTAQjiodwHKV+S3D33GwPC+mrw6
         E1DEwDDbT4zk8iFwakAxpYsI4UAq2kZ6BdhNcV5myei+tcAA90z+HAzKPYPjlWGWI5lH
         oBc9XS6+8FEtjPOV2t6T/OXIDy/u5TLoE3du4y6KaYroz8Z/leU87zqze8UfmnGALKbW
         01uLvJzZNRdr0OaAMQxzLickvZ3Xr4uCeOYf/KwpZ5mhovjWisv4OiBN311l+zYx2L28
         4LcibdK6JKzlgFIfjjVWLPaqaCcq02g96xPFhtU8WgDKavGj0PecfiwSS3XF5rAB2GlX
         zqag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196366;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IvGUSi065rPVm3ZfYKGK5MDm9PmleP65euGwVIifD5Y=;
        b=EZvt+B/IfGRvgBYRYf6urwaCEBhJs4z0yIce7n0tE3N1+y0geFk5tNl4L7iwK+Tt3O
         jv2ds2js75Kh2n1Nt8G2MgWmcWM7AIQMeCeeuwrK3QREX7BVbVcFE0zm4GfWwFCGHY7a
         z+/rOiGED4v095z0onuDiimwEEB5/x6cTWsfO/ACspBblqOTIbU8ROGU3EN3J8Cw1yDZ
         HsAXPjkrr9my6ANHu3Tq3XcmJK9BOIyPqB3FlS+reVNjiLKRfg6wN/2TRQq1lgjteU3n
         85x7bMg5gDhqeALGyqOya5W9dtC5s8/pL1WYwenjoTR4yIzxSrsQ/DX4mN7T5DESX0ph
         cLZA==
X-Gm-Message-State: AAQBX9epWQdJF6XfAIXmtt/bHA2VxKsxJqfJOnAn2E4BnjadLEzHE9TJ
        rS2W+Hm9V3vpyX6EgS6cjDFDdkRf4HBqEGiIQayuQA==
X-Google-Smtp-Source: AKy350ZZBG1hB/4KYLsB5AoGGWPQRPtSzHLvPGslIWST4rJAmGPiHGQW+YR2iLcfsRf5r/wCyr8amVz6E8oVjSodTKs=
X-Received: by 2002:a50:cd0b:0:b0:4fc:a484:c6ed with SMTP id
 z11-20020a50cd0b000000b004fca484c6edmr11780895edi.2.1680196365781; Thu, 30
 Mar 2023 10:12:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-3-andrii@kernel.org>
In-Reply-To: <20230328235610.3159943-3-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 30 Mar 2023 18:12:34 +0100
Message-ID: <CAN+4W8gsHdFd8BgjyndvpabZ-m3tNohU8LhQwT=yv+wi6NKvXw@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 2/6] bpf: remove minimum size restrictions on
 verifier log buffer
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, timo@incline.eu, robin.goegge@isovalent.com,
        kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Mar 29, 2023 at 12:56=E2=80=AFAM Andrii Nakryiko <andrii@kernel.org=
> wrote:
>
> It's not clear why we have 128 as minimum size, but it makes testing
> harder and seems unnecessary, as we carefully handle truncation
> scenarios and use proper snprintf variants. So remove this limitation
> and just enfore positive length for log buffer.

Nit: enforce

>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>

> ---
>  kernel/bpf/log.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/bpf/log.c b/kernel/bpf/log.c
> index 920061e38d2e..1974891fc324 100644
> --- a/kernel/bpf/log.c
> +++ b/kernel/bpf/log.c
> @@ -11,7 +11,7 @@
>
>  bool bpf_verifier_log_attr_valid(const struct bpf_verifier_log *log)
>  {
> -       return log->len_total >=3D 128 && log->len_total <=3D UINT_MAX >>=
 2 &&
> +       return log->len_total > 0 && log->len_total <=3D UINT_MAX >> 2 &&
>                log->level && log->ubuf && !(log->level & ~BPF_LOG_MASK);

Probably discussion for your second series. Thought experiment, could
this be len_total >=3D 0? I'm still after a way to get the correct log
buffer size from the first PROG_LOAD call. If the kernel could handle
this I could mmap a PROT_NONE page, set len_total to 0 and later read
out the correct buffer size.

I'm guessing that the null termination logic would have to be
adjusted, anything else though?

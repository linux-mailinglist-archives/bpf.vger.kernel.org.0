Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 912E56D0C6C
	for <lists+bpf@lfdr.de>; Thu, 30 Mar 2023 19:13:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjC3RNM (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 30 Mar 2023 13:13:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231585AbjC3RNL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 30 Mar 2023 13:13:11 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90B6B199E
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:13:09 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id y4so79330106edo.2
        for <bpf@vger.kernel.org>; Thu, 30 Mar 2023 10:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680196388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y1GOkiH/468oWJCMYLq2Pa9NWkVDgZmfd5RY3W8RTPg=;
        b=LcoN0ebBaskVXRdh9D5WR6y2BuxPfK25XshENFAxItLw/fjzdmvF5xbqXvGDIVy7ab
         QrxnpFlydDvSnid7r9MfjyHPJnudIVSAQ3RPtCceVt929a6r9iPbzXKzekofcNB9lgoW
         UBru4ejydfbzfyQW8/AYd7RXW/wf7BhOTgclbaLqtEiRoxdEfx8al3dxEjq3t3AHFm/X
         34c857Vf+s81eolPmnpjFXaXd8D2XttDoBDjw9xw6quxyt5Gg0caROrvsaet0DdOy73a
         7rnHYSWvbhnmXfdevt3koHmsNzx1og3vUMwyyW2dKeR732zrtjfNOupC0G613lb44jRz
         T4ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680196388;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y1GOkiH/468oWJCMYLq2Pa9NWkVDgZmfd5RY3W8RTPg=;
        b=wooGXkF8KHz+ZagODQBVpobPOxQf0KnXNbZgT1UTTvq2kIlvDexTrKykYdc/UsEXUH
         /X3WmewY2DOI0ZWxGpZPZVpzNq3Xe7THfLO+2TjKZKd05euSR5ej+f9dC9IJ0LuPjmbf
         +szlI3Aqud8WxxjfIV9wqI/roOnuoo/l6YxScIQQrRd1pkNMuAoIvC9KC83ZgBa5rhwr
         JbSoD+cGD+UEqB/od2Bd3YLyvHSR/o3TX4p9SmUG5L95R0KojHsOlNmILyMdNKcjGJGO
         FziAtcPJbpFSqKDZ3HbsIpybpb/ebeyXO7eKPW6EO+K95i9vjoyMcgK1+P/00vRnJZtO
         W/Cw==
X-Gm-Message-State: AAQBX9d5q4+3Z0IFI3mTygU5o09aZD63OHTQcN20Nin6xLv146mgCY8J
        FXKNG1Kb52NN/sruQFaVAwp5z7JATl5sU0Ly73+o0Q==
X-Google-Smtp-Source: AKy350YUp5GLaFM7rCi79e1v+WawWIMM55M1FI7n6iKRxZ3jZN6WhVWa4X7u8EXr4BthGR0Zzdxm8J5iDD9hpVrG8bM=
X-Received: by 2002:a17:906:1185:b0:92b:ec37:e4b7 with SMTP id
 n5-20020a170906118500b0092bec37e4b7mr12100943eja.14.1680196388043; Thu, 30
 Mar 2023 10:13:08 -0700 (PDT)
MIME-Version: 1.0
References: <20230328235610.3159943-1-andrii@kernel.org> <20230328235610.3159943-8-andrii@kernel.org>
In-Reply-To: <20230328235610.3159943-8-andrii@kernel.org>
From:   Lorenz Bauer <lmb@isovalent.com>
Date:   Thu, 30 Mar 2023 18:12:57 +0100
Message-ID: <CAN+4W8ju8Bdqe59QXbX+eQWARfiy2-zqgkD5N0rMpmRn9-W4Vg@mail.gmail.com>
Subject: Re: [PATCH v2 bpf-next 6/6] selftests/bpf: add fixed vs rotating
 verifier log tests
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
> Add selftests validating BPF_LOG_FIXED behavior, which used to be the
> only behavior, and now default rotating BPF verifier log, which returns
> just up to last N bytes of full verifier log, instead of returning
> -ENOSPC.
>
> To stress test correctness of in-kernel verifier log logic, we force it
> to truncate program's verifier log to all lengths from 1 all the way to
> its full size (about 450 bytes today). This was a useful stress test
> while developing the feature.
>
> For both fixed and rotating log modes we expect -ENOSPC if log contents
> doesn't fit in user-supplied log buffer.
>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

Acked-by: Lorenz Bauer <lmb@isovalent.com>

> +       /* validate BPF_LOG_FIXED works as verifier log used to work, tha=
t is:
> +        * we get -ENOSPC and beginning of the full verifier log. This on=
ly
> +        * works for log_level 2 and log_level 1 + failed program. For lo=
g
> +        * level 2 we don't reset log at all. For log_level 1 + failed pr=
ogram
> +        * we don't get to verification stats output. With log level 1
> +        * for successful program  final result will be just verifier sta=
ts.
> +        * But if provided too short log buf, kernel will NULL-out log->u=
buf

Out of curiousity: why is ubuf NULLed? Is that something we could change?

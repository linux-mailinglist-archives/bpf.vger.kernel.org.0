Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 823A64C0B96
	for <lists+bpf@lfdr.de>; Wed, 23 Feb 2022 06:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232428AbiBWFSt (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 23 Feb 2022 00:18:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbiBWFSt (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 23 Feb 2022 00:18:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B23E3673F0
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 21:18:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4F65C60C62
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 05:18:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2040C340F1
        for <bpf@vger.kernel.org>; Wed, 23 Feb 2022 05:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645593501;
        bh=7/PEgC9OdMQwkhXo7I7xyCnp4zeXMNT+jkvhy6E+hv4=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=O5dG+UODgJF1Ul1SH8mg37+4U+NizqZ9TvsUivvb49wUYoL8qRpvu6mb5bRz0nf4x
         iXRSSHHXsNl5AxDTiuEjF8SbecMxhPBtr9gUKramGSz73pA1aa008o8L5CuczgoBkE
         6iF912TwojNsP6qAoDuRRK+jzEiZuKZ+o+IbCc7dd0dWoyvyxTooqQaqJio0ZxiktM
         ++av2GSC8Od/r7dcS2lKJCVsyin4OIVlCRC3H4YhWgZW8GLtmq4DHmTGFr8Fg0XbfW
         FBC40OqiSriAkXsAfEByJeXY3rBd+4joginhMrLS+SQKeYnbW01gBxYdP+jgzfUQH8
         UEr6AKlXHWMZQ==
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-2d07c4a0d06so198188147b3.13
        for <bpf@vger.kernel.org>; Tue, 22 Feb 2022 21:18:21 -0800 (PST)
X-Gm-Message-State: AOAM530pwcDWJQibNmw8qCHmMTgU/Vhx94TLeJBjNhodLp5LU36yHIIp
        GEIhwOPwbCTfv9PXI+B7qBlbj/WaAiK6Z1aXFUs=
X-Google-Smtp-Source: ABdhPJzsI9y7VEtisZuQsGeW6/PZeSqVvXugsjkWeVU2j2L06wQs9WZbrNCCsIuo+YsRAl+tw9MZUipyAuIaNHx2plY=
X-Received: by 2002:a81:c47:0:b0:2d6:beec:b381 with SMTP id
 68-20020a810c47000000b002d6beecb381mr22681095ywm.148.1645593500714; Tue, 22
 Feb 2022 21:18:20 -0800 (PST)
MIME-Version: 1.0
References: <20220223000544.3524440-1-fallentree@fb.com>
In-Reply-To: <20220223000544.3524440-1-fallentree@fb.com>
From:   Song Liu <song@kernel.org>
Date:   Tue, 22 Feb 2022 21:18:09 -0800
X-Gmail-Original-Message-ID: <CAPhsuW5yLP=q2vh_ogdnq93MTuFeKRi5pM70no_BbpS5Y_cx9g@mail.gmail.com>
Message-ID: <CAPhsuW5yLP=q2vh_ogdnq93MTuFeKRi5pM70no_BbpS5Y_cx9g@mail.gmail.com>
Subject: Re: [PATCH bpf-next] selftests/bpf: workaround stdout issue in VM
 launched by vmtest.sh
To:     Yucong Sun <fallentree@fb.com>
Cc:     bpf <bpf@vger.kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        sunyucong@gmail.com
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

On Tue, Feb 22, 2022 at 4:06 PM Yucong Sun <fallentree@fb.com> wrote:
>
> This apply a workaround to fix stdout issue in `./vmtest.sh` invocations,
> but doesn't work on `./vmtest.sh -s`
>
> Signed-off-by: Yucong Sun <fallentree@fb.com>

Could you please provide more information about the issue?

> ---
>  tools/testing/selftests/bpf/vmtest.sh | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/tools/testing/selftests/bpf/vmtest.sh b/tools/testing/selftests/bpf/vmtest.sh
> index e0bb04a97e10..a9f943a84ed5 100755
> --- a/tools/testing/selftests/bpf/vmtest.sh
> +++ b/tools/testing/selftests/bpf/vmtest.sh
> @@ -184,6 +184,10 @@ EOF
>         fi
>
>         sudo bash -c "echo '#!/bin/bash' > ${init_script}"
> +       sudo bash -c "cat >>${init_script}" <<EOF
> +# Force rebinding stdout/stderr to /dev/ttyS0, to workaround a mysterious issue
> +exec 1>/dev/ttyS0 2>/dev/ttyS0
> +EOF
>
>         if [[ "${command}" != "" ]]; then
>                 sudo bash -c "cat >>${init_script}" <<EOF
> --
> 2.30.2
>

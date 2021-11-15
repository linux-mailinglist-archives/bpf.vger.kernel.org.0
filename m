Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C8F45187F
	for <lists+bpf@lfdr.de>; Mon, 15 Nov 2021 23:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349635AbhKOXA7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 15 Nov 2021 18:00:59 -0500
Received: from mail.kernel.org ([198.145.29.99]:45524 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350937AbhKOWeD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 15 Nov 2021 17:34:03 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id F3A3C63246
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 22:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1637015467;
        bh=mqnR1THDXts7xjd5u3HL2dRewThBweafrUfUFFECMAE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=WoKx0spJsl5HRUfTZ+IotfH4uQ+ffKDrHnAsXj2h+RGXe1T9CrtOlzC+m/CoHE8GF
         Gj1IhcUNDBtdGS6A33fqFiWCLMYGKqcG5vZN5JID2PK8YMnza8zasU+LE429w7IX9N
         Ab2QugAf4/U+T2cNpoOenUgbTOEWGalp5RRvkZWt+7BV8GIohxsXuy1wdTM0wt4ynh
         5abyDBOyExhad+pDHGBE+W6nutkqeEUaaXrOdWCl6bTIKKL5CNjP1J9z4JhcOFa84O
         kVmGibjTCt81BJnvXy059k6WG5QLnoSwFhHCygKUQkJ7ze/og4ili7+v79hKReta0g
         oi2+cfZDzsAuQ==
Received: by mail-ed1-f42.google.com with SMTP id g14so14902850edb.8
        for <bpf@vger.kernel.org>; Mon, 15 Nov 2021 14:31:06 -0800 (PST)
X-Gm-Message-State: AOAM5310Cp1AQJwy+dEysIYDw4CK4pEIj0IDzxxUumWjdkOIkc6gJ57S
        cKPPihoOjvOIrhaNfCwMoH4b4ai/8iegtQla4MKoMQ==
X-Google-Smtp-Source: ABdhPJyvdS2ddY91KjTgsqkctCOFOOVXVJDFwxz8j0/OTtmJqtiN1fbEHPD18GcJ87Bdy8XwQkJgl1Igq/ks4E3ugN4=
X-Received: by 2002:a17:907:7805:: with SMTP id la5mr3261733ejc.188.1637015465447;
 Mon, 15 Nov 2021 14:31:05 -0800 (PST)
MIME-Version: 1.0
References: <cover.1636749493.git.dave@dtucker.co.uk> <49fe0f370a2b28500c1b60f1fdb6fb7ec90de28a.1636749493.git.dave@dtucker.co.uk>
In-Reply-To: <49fe0f370a2b28500c1b60f1fdb6fb7ec90de28a.1636749493.git.dave@dtucker.co.uk>
From:   KP Singh <kpsingh@kernel.org>
Date:   Mon, 15 Nov 2021 23:30:54 +0100
X-Gmail-Original-Message-ID: <CACYkzJ4MFRedC1j1PK4EU3AjVKzPOYMX1ngSxGa-iUHuBKXmew@mail.gmail.com>
Message-ID: <CACYkzJ4MFRedC1j1PK4EU3AjVKzPOYMX1ngSxGa-iUHuBKXmew@mail.gmail.com>
Subject: Re: [PATCH bpf-next 2/3] docs: Rename bpf_lsm.rst to prog_lsm.rst
To:     Dave Tucker <dave@dtucker.co.uk>
Cc:     bpf@vger.kernel.org, corbet@lwn.net, ast@kernel.org,
        daniel@iogearbox.net, andrii@kernel.org, kafai@fb.com,
        songliubraving@fb.com, john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, Nov 12, 2021 at 10:18 PM Dave Tucker <dave@dtucker.co.uk> wrote:
>
> This allows for documentation relating to BPF Program Types to be
> matched by the glob pattern prog_* for inclusion in a sphinx toctree
>
> Signed-off-by: Dave Tucker <dave@dtucker.co.uk>
> ---
>  Documentation/bpf/{bpf_lsm.rst => prog_lsm.rst} | 0
>  MAINTAINERS                                     | 2 +-
>  2 files changed, 1 insertion(+), 1 deletion(-)
>  rename Documentation/bpf/{bpf_lsm.rst => prog_lsm.rst} (100%)
>
> diff --git a/Documentation/bpf/bpf_lsm.rst b/Documentation/bpf/prog_lsm.rst
> similarity index 100%
> rename from Documentation/bpf/bpf_lsm.rst
> rename to Documentation/bpf/prog_lsm.rst
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f96aa662ee32..bd690d1ba272 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3529,7 +3529,7 @@ R:        Florent Revest <revest@chromium.org>
>  R:     Brendan Jackman <jackmanb@chromium.org>
>  L:     bpf@vger.kernel.org
>  S:     Maintained
> -F:     Documentation/bpf/bpf_lsm.rst
> +F:     Documentation/bpf/prog_lsm.rst
>  F:     include/linux/bpf_lsm.h
>  F:     kernel/bpf/bpf_lsm.c
>  F:     security/bpf/
> --

Acked-by: KP Singh <kpsingh@kernel.org>

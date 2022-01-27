Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7D3D49ED70
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 22:33:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344379AbiA0Vdo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 16:33:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344375AbiA0Vdo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jan 2022 16:33:44 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C1DC061747
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 13:33:43 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id b14so6319929ljb.0
        for <bpf@vger.kernel.org>; Thu, 27 Jan 2022 13:33:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Pj2ihRLwWcnkU2m8JuS/1g0rkYd31KOK39iBZzKRwHI=;
        b=YAvfTELJOYXEq4lNEQ8SEGhnPrRLybHWBu8Vpq2+bMZSmjby8SbpSDDeLtAR6HOqZL
         Cl+PtxIC9OzHDK4SFvYus8nUTgKScsyIvFBgzB3gOoQckincJ11yc8a+qVzOUqvrmu9w
         SN6OQm+G2dYgK40N9Xy/V9nBrhNShxYRdSVroAeEEVgcoARYl0Ki2LdDtlCfK6WLmZEt
         kMSaxKUydYOA5OCjE1dScNjnd80jfImbzwIX535aLEaLx1/NCq4QOs1Lmy/wvIOABraX
         BWeGv53RG5+K+pAMieKbxeK0aPTBvW/+3ucW7eC+0y7Ne8ligRHSzE2eEEm6oSJrw3On
         dRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Pj2ihRLwWcnkU2m8JuS/1g0rkYd31KOK39iBZzKRwHI=;
        b=Yb5Z6Px1TGRfnJkz0mJJV7VqeSpvhWUrivNrH8YTulsvCMx+bvb9hQinp5xVIFSZrd
         Z7Z0ZjA7+kzQBIRq9yyPcyvj+OOytGuTjd1BhVyZBDtc7RV7carl5DvkXV1MjnlFFzIz
         OnLaYdFFW12pINAF5a72CVjGTSEVb8UfCULlfLN9Xe4URQ3F+3jokBICXALYOEqhV8wu
         oKxCBf1AEyxoWDeRsNDSZAOweWChqI0pZzu7OYb4QmWYhhw1v4XUvRX//gPyTJoCw+yv
         7zlolBpGY7qVvPGQ3HoG2re/ka1zq/UxsMNUTwn8v8ZzPgYqhC/ZFC136IshgGgtpn4T
         vcDw==
X-Gm-Message-State: AOAM53115ojAd+4jGX/GBJ7mg9whBFneek9Sl36OFNhFGTbEJrq3rgpn
        Gu39kZwfltMcYZYrSYizNdisJ5Mbw5lXORGfz/YgXQ==
X-Google-Smtp-Source: ABdhPJxrQrAeBZI2D8ISfWQYBlvwSSA/N/+ormQYDjRg8lr4ebaGO2ltoN+P/nUp2kUaa5X2JWYNcvdO614Uil7pvZY=
X-Received: by 2002:a2e:2e16:: with SMTP id u22mr3869908lju.205.1643319221748;
 Thu, 27 Jan 2022 13:33:41 -0800 (PST)
MIME-Version: 1.0
References: <20220124151146.376446-1-maximmi@nvidia.com> <20220124151146.376446-2-maximmi@nvidia.com>
 <CACAyw98mbtZSH3yddaptKb4Qi7Grxzt80ihqiHA3qw9n4XwVjg@mail.gmail.com>
In-Reply-To: <CACAyw98mbtZSH3yddaptKb4Qi7Grxzt80ihqiHA3qw9n4XwVjg@mail.gmail.com>
From:   Petar Penkov <ppenkov@google.com>
Date:   Thu, 27 Jan 2022 13:33:30 -0800
Message-ID: <CAG4SDVUZTHzA9DD7bagig5UREMHOuVHh25hzezXJhb11TeHSoQ@mail.gmail.com>
Subject: Re: [PATCH bpf v2 1/4] bpf: Use ipv6_only_sock in bpf_tcp_gen_syncookie
To:     Lorenz Bauer <lmb@cloudflare.com>
Cc:     Maxim Mikityanskiy <maximmi@nvidia.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Networking <netdev@vger.kernel.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Wed, Jan 26, 2022 at 1:46 AM Lorenz Bauer <lmb@cloudflare.com> wrote:
>
> On Mon, 24 Jan 2022 at 15:13, Maxim Mikityanskiy <maximmi@nvidia.com> wrote:
> >
> > Instead of querying the sk_ipv6only field directly, use the dedicated
> > ipv6_only_sock helper.
> >
> > Fixes: 70d66244317e ("bpf: add bpf_tcp_gen_syncookie helper")
> > Signed-off-by: Maxim Mikityanskiy <maximmi@nvidia.com>
> > Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
>
> Acked-by: Lorenz Bauer <lmb@cloudflare.com>

Acked-by: Petar Penkov <ppenkov@google.com>

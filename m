Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B4A612C20
	for <lists+bpf@lfdr.de>; Sun, 30 Oct 2022 19:01:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiJ3SA5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sun, 30 Oct 2022 14:00:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3SA4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sun, 30 Oct 2022 14:00:56 -0400
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB31818C;
        Sun, 30 Oct 2022 11:00:55 -0700 (PDT)
Received: by mail-ua1-x92c.google.com with SMTP id c26so1069876uak.5;
        Sun, 30 Oct 2022 11:00:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OhvDG29Bt/buhOfUrnDiZGriPE828q/V5FYRl5mJiwU=;
        b=lLXdvwZclyw8W406puBzN7TXelJzu1eRVh4tGF5eOYC8bMvr/nd1bYlMKw+Ck5eDNH
         uRGH5PnItyrSJm14my6muHWqZoqwllvTn3cM1z8BNeVvExHGWlYDZvvNF1vi7XH4Grbm
         ngXJ/WHtlJ2EPJ8LkDMRuvNrfb/xCa7AOMRwy5/rRarvGs4E6qTFAEwR4oU4nUGWsh0M
         iG3nxPFzQhSCWvxWb4pSlBkCMUTwixzrOnuiXADCQq9+3okMBa0zVOCWoUGdEsDrigQY
         cDWKqyv8keP9BUJZfQETBtliGloKOgUzaopzqADxjCu1ONArDt+1k70tLHBozfweQZYR
         upBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OhvDG29Bt/buhOfUrnDiZGriPE828q/V5FYRl5mJiwU=;
        b=rVMSiYjPDj0Rhe7WpSagfCd2LjMiNoRq/G8vmV2W8fUuiVEqW9ShzUQnEhtOz/ovcr
         +vA+C+L77hPR51vhivRT8t6NuCoxKRTFnpgInXQUa6jXrO6LoV0YFDDYYrPQK+YlIi8o
         ty9g5d0tSHqSYcc9KZvPe+9SpGBfHQAoEa4ZoPJnLH0HWmxJfqtJ8dYi8sWVKs63ibkz
         mmrJtnI2rnYj2gNFIKuW7M1hlPjd0qFaPL6OUG817qMrEjQek0g+oU2KfsGXrAqtbiSO
         SRtsFMx0RdzLqyJNjA7S/swBm9d7JXIzj5nWxC3CXStK0q8hsfg2upFAj0QDAJH4CngZ
         EgPw==
X-Gm-Message-State: ACrzQf0MTn8s0K0oiMzMsup3lpXfbOSjXb+fk01LQYsyCb1BIlODHZtF
        7/RUzTM8+3gFazVZuGigEa9PvzIAPVtEMuZQFtAxQ0BJtqw=
X-Google-Smtp-Source: AMsMyM5fpY2WhhSsZknOqMGJelxEDZzf93cdPEsHrxDNEuIcyn5KtrUWBO003o9EoNf895fUyedVmRWwupON2w1jK6Q=
X-Received: by 2002:a9f:301b:0:b0:3ae:a45f:463e with SMTP id
 h27-20020a9f301b000000b003aea45f463emr2099934uab.28.1667152854911; Sun, 30
 Oct 2022 11:00:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221029211520.24033-1-tegongkang@gmail.com> <Y151wBUkhDHbhzzq@debian.me>
In-Reply-To: <Y151wBUkhDHbhzzq@debian.me>
From:   Kang Minchul <tegongkang@gmail.com>
Date:   Mon, 31 Oct 2022 03:00:43 +0900
Message-ID: <CA+uqrQDPxDptFWCoSq4ksndBMZd=k7e6FL59BtomA8Wts46Q9A@mail.gmail.com>
Subject: Re: [PATCH] samples: bpf: fix typo in README
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

2022=EB=85=84 10=EC=9B=94 30=EC=9D=BC (=EC=9D=BC) =EC=98=A4=ED=9B=84 10:01,=
 Bagas Sanjaya <bagasdotme@gmail.com>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> On Sun, Oct 30, 2022 at 06:15:20AM +0900, Kang Minchul wrote:
> > This commit fixes a simple typo in samples/bpf/README.rst
> >
> > changed cofiguration to configuration.
>
> Better say "Fix 'cofiguration' typo in BPF samples README".
>
> And please write patch description in imperative mood instead of
> descriptive one.
Thanks for your feedback.
I just amended the message and sent patch v2.

regards,

Kang Minchul

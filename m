Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DDF525639
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 22:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358274AbiELUHG (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 16:07:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358283AbiELUHF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 16:07:05 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1E55DBD0
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 13:07:03 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id q130so7853453ljb.5
        for <bpf@vger.kernel.org>; Thu, 12 May 2022 13:07:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ieee.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=oO7C2vw614ul0mQK6BxzOvLBf+YYDu+I4LzerhhwUEU=;
        b=HTV3Wkh2Lp4YrH79XsJ7m0xKncbjKkXKpfJU55vortLtEMUxXdGTLCNroyEEFytiTy
         dB11pDocVgYUwakiYNWnPx9xXCiovqxq1mS8kxFMtFs4y9cavCyv7fkpYSyCbGcgBV0v
         ZMWBp2vvvkseRGrEx1+gl02Ta3LNPqo54W+zU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=oO7C2vw614ul0mQK6BxzOvLBf+YYDu+I4LzerhhwUEU=;
        b=TLyVSnGLLefrsNPw5k2Eqy0Sf/pLRe4fgzvklpkcSZXh9PGjEeyL+SeMc2heai+CHy
         jCYNJKYqKp9/ujvuFmljFqhCkJptTbGL3QwBNaRGGmdGh4c1vjAM2pPI0++qNVXZBvox
         n8smOhK7874Tu1mUyIIaQh1104Pvm04UJc3enjCx27LXwf8CTO/v8Vphmmld/91H/YZf
         m88WXzvs8L03CdQ5sGH5Eb/NYvsHyQSsV1Ogq8UN7M8zKY0hGjj6htPJuZL/508WyStu
         WZI2aSiVHHWXgh4oCrTtbao5YxtD+aON7f+PFxyudz6BBsaPvuyURA/PJcrQzA5BD314
         qK4g==
X-Gm-Message-State: AOAM532C32XP2PGXHNwS0WvwmqgJUcDZVQKCQmT2BvXazbpdar+5NZZR
        3LtKIaiCLR2BMoag+prqG7+3GodAR8SJF4IfehvjtQ==
X-Google-Smtp-Source: ABdhPJzJlTnaa7a64N7kMzAJom5twCQHCM6va8kx+fcA1V4vXHNXxciYrh9O2VwNVkpoU2ZmYx1BNMaAtK9QlwkOL7Y=
X-Received: by 2002:a2e:9993:0:b0:250:b5a9:18dc with SMTP id
 w19-20020a2e9993000000b00250b5a918dcmr1023327lji.364.1652386021895; Thu, 12
 May 2022 13:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <CAOFRbGnQ1P4q+egG+K=BcZL4bwaAdtp7hQ1nh9TYJyky0j3WDw@mail.gmail.com>
In-Reply-To: <CAOFRbGnQ1P4q+egG+K=BcZL4bwaAdtp7hQ1nh9TYJyky0j3WDw@mail.gmail.com>
From:   Ozgur <ozgurk@ieee.org>
Date:   Fri, 13 May 2022 00:06:51 +0400
Message-ID: <CAADfD8zu9z1EPwMjc0VG2aGg9kzDfpV6qcMqUCGKa+bPNTsr+g@mail.gmail.com>
Subject: Re: ERROR: drivers: net: ethernet: stmicro: stmmac: stmmac_main.c
To:     Test Bot <zgrieee@gmail.com>, peppe.cavallaro@st.com
Cc:     lkml <linux-kernel@vger.kernel.org>,
        "David S . Miller" <davem@davemloft.net>, linux@armlinux.org.uk,
        linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Thu, May 12, 2022 at 11:49 PM Test Bot <zgrieee@gmail.com> wrote:
>
> Hi,

Hello,

its a bot and still in beta and looks like same warning as any other findin=
g.

Looks like Linus e-mail Linus explained this warning and i wanted to
share e-mail.

https://lore.kernel.org/lkml/CAHk-=3Dwh5E-xdc5P6SfN-ey6zvVri43rTj0g8kjUBWD3=
hhE-jiw@mail.gmail.com/

Regards

> I automatically test (RC) kernel and caught ERROR word.
> Please ignore, if its unimportant.
>
> Kernel: 5.18-rc6
> Arch: x86_64 (SMP)
> Compiler: 7.5.0 (gcc)
> FIle: drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
>
> Codebase Block:
>
> static int stmmac_request_irq_multi_msi(struct net_device *dev)
> {
>         struct stmmac_priv *priv =3D netdev_priv(dev);
>         enum request_irq_err irq_err;
>         cpumask_t cpu_mask;
>         int irq_idx =3D 0;
>         char *int_name;
>         int ret;
>         int i;
>
>         int_name =3D priv->int_name_mac;
>         sprintf(int_name, "%s:%s", dev->name, "mac");
>         ret =3D request_irq(dev->irq, stmmac_mac_interrupt,
>                           0, int_name, dev);
>
>         if (unlikely(ret < 0)) {
>                 netdev_err(priv->dev,
>                            "%s: alloc mac MSI %d (error: %d)\n",
>                            __func__, dev->irq, ret);
>                 irq_err =3D REQ_IRQ_ERR_MAC;
>                 goto irq_error;
>         }
>
>         if (priv->wol_irq > 0 && priv->wol_irq !=3D dev->irq) {
>                 int_name =3D priv->int_name_wol;
>                 sprintf(int_name, "%s:%s", dev->name, "wol");
>                 ret =3D request_irq(priv->wol_irq,
>                                   stmmac_mac_interrupt,
>                                   0, int_name, dev);
>
>                 if (unlikely(ret < 0)) {
>                         netdev_err(priv->dev,
>                                    "%s: alloc wol MSI %d (error: %d)\n",
>                                    __func__, priv->wol_irq, ret);
>                         irq_err =3D REQ_IRQ_ERR_WOL;
>                         goto irq_error;
>                 }
>         }
>
> Compiler  Log:
>
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: In function
> =E2=80=98stmmac_request_irq_multi_msi=E2=80=99:
> drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:3562:1: warning: the
> frame size of 1040 bytes is larger than 1024 bytes
> [-Wframe-larger-than=3D]

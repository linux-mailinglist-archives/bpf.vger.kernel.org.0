Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA11652560A
	for <lists+bpf@lfdr.de>; Thu, 12 May 2022 21:49:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358181AbiELTtN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 May 2022 15:49:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358162AbiELTtM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 May 2022 15:49:12 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2986C0CB;
        Thu, 12 May 2022 12:49:11 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id s11so3703606edy.6;
        Thu, 12 May 2022 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=L6bc/v2q9wAOZf+bsMrDYFkU4XW2OPwKGzrf/4IaxOw=;
        b=oKNxmUSRY97LZxvn4LykNJx9l+VNSrrOP9A+bFIG8JBTsJ3FgU/CvT38d3BaIHrCxM
         KJp1hc8RdA1O5jZStUVeiPgvhCr7z12dywOkUo/Gqljzg53oTRKpLT/mcCqQOggENFgm
         OAR9KGhGGh34eVHX3t8pd/N0zYk2/hZG8I9CIk/wyreDFJg9oTBUq8E2zVltYgE4HSW5
         OiS5JL667+4/2BIcIWhnGf6FVZ2O+CyE72gevQ1BqRaiNaTY/5jdwLmASD2g9Jaqe1xR
         4Wo02fzPqPL1kn4LFJHUH5zM/cYxMDYoCR3JVhDaQk3YskSW/2ctf2ALcMEn61IouzTI
         hXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=L6bc/v2q9wAOZf+bsMrDYFkU4XW2OPwKGzrf/4IaxOw=;
        b=2+1mIBMfXc05t28iDNUI3BuHEbywgAfwWHGhKDDDJCyoy+EGsfeH/AMobGz0FeMc4u
         N0lvS6cqp9cnTfyML4fuFngO1xI+8bv8+jKnjq2P3R+JqnVy9A5JIBR+se14mGkRQu/B
         sdpKkMXM5z6nTb+n6KTmMIn4LEmgcUDVJp1rBe+B95FeALhpcv/bwVJHxkjMFLfvnnTZ
         I5Ofq+VeTlS1juFjG3euA75HrS8j583lZFUoxhtwoAoI/R3Xg7TjePCFMFREmPtdRaEK
         k+jU5BFT1eeitO7edS1Eq9ty02DvYaS5TWHEFJzDCFkZ08GRDIAPOuRe/8GaPFp48uA9
         Y86Q==
X-Gm-Message-State: AOAM531KBzoV1aCBKY0hWe4FWI9E/egI/385ULLQ4nBG/N5YAvjyrp0V
        QDfLJeW6CSdLOtDDjBlGNS/viYPydDWbkCBGbsk=
X-Google-Smtp-Source: ABdhPJwZtff2PRHohfwpuQPnoqgF6843ayY4Y5H4s4QohcvBZEVKaooZLAQp+5U/kSShim+yChyf+HRSMyKwtvbzugc=
X-Received: by 2002:aa7:d954:0:b0:425:f621:f77f with SMTP id
 l20-20020aa7d954000000b00425f621f77fmr36567273eds.363.1652384950339; Thu, 12
 May 2022 12:49:10 -0700 (PDT)
MIME-Version: 1.0
From:   Test Bot <zgrieee@gmail.com>
Date:   Thu, 12 May 2022 23:48:59 +0400
Message-ID: <CAOFRbGnQ1P4q+egG+K=BcZL4bwaAdtp7hQ1nh9TYJyky0j3WDw@mail.gmail.com>
Subject: ERROR: drivers: net: ethernet: stmicro: stmmac: stmmac_main.c
To:     peppe.cavallaro@st.com, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, linux@armlinux.org.uk,
        linux-stm32@st-md-mailman.stormreply.com, bpf@vger.kernel.org,
        ozgurk@ieee.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Hi,

I automatically test (RC) kernel and caught ERROR word.
Please ignore, if its unimportant.

Kernel: 5.18-rc6
Arch: x86_64 (SMP)
Compiler: 7.5.0 (gcc)
FIle: drivers/net/ethernet/stmicro/stmmac/stmmac_main.c

Codebase Block:

static int stmmac_request_irq_multi_msi(struct net_device *dev)
{
        struct stmmac_priv *priv =3D netdev_priv(dev);
        enum request_irq_err irq_err;
        cpumask_t cpu_mask;
        int irq_idx =3D 0;
        char *int_name;
        int ret;
        int i;

        int_name =3D priv->int_name_mac;
        sprintf(int_name, "%s:%s", dev->name, "mac");
        ret =3D request_irq(dev->irq, stmmac_mac_interrupt,
                          0, int_name, dev);

        if (unlikely(ret < 0)) {
                netdev_err(priv->dev,
                           "%s: alloc mac MSI %d (error: %d)\n",
                           __func__, dev->irq, ret);
                irq_err =3D REQ_IRQ_ERR_MAC;
                goto irq_error;
        }

        if (priv->wol_irq > 0 && priv->wol_irq !=3D dev->irq) {
                int_name =3D priv->int_name_wol;
                sprintf(int_name, "%s:%s", dev->name, "wol");
                ret =3D request_irq(priv->wol_irq,
                                  stmmac_mac_interrupt,
                                  0, int_name, dev);

                if (unlikely(ret < 0)) {
                        netdev_err(priv->dev,
                                   "%s: alloc wol MSI %d (error: %d)\n",
                                   __func__, priv->wol_irq, ret);
                        irq_err =3D REQ_IRQ_ERR_WOL;
                        goto irq_error;
                }
        }

Compiler  Log:

drivers/net/ethernet/stmicro/stmmac/stmmac_main.c: In function
=E2=80=98stmmac_request_irq_multi_msi=E2=80=99:
drivers/net/ethernet/stmicro/stmmac/stmmac_main.c:3562:1: warning: the
frame size of 1040 bytes is larger than 1024 bytes
[-Wframe-larger-than=3D]

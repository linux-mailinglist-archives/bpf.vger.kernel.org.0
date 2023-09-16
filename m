Return-Path: <bpf+bounces-10211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 316137A326B
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 22:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AAD41C20954
	for <lists+bpf@lfdr.de>; Sat, 16 Sep 2023 20:17:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0477D1C289;
	Sat, 16 Sep 2023 20:17:10 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A1101BDF9;
	Sat, 16 Sep 2023 20:17:08 +0000 (UTC)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90179CD8;
	Sat, 16 Sep 2023 13:17:05 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-50300cb4776so1285856e87.3;
        Sat, 16 Sep 2023 13:17:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694895424; x=1695500224; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=UNhhSv5EciaOBb+e1S2UjWYyLKGfXoLDerHcISpMZ/M=;
        b=G6xoVExFBGrKOGOYRSsaDGVJXefddpTV5eGBtOG114Y4xy0BlE56OldylcnFcyUcz/
         j4kaAuJlnVCAU74dUlQX68e1ErrDTdlUFMh72oIQNtdbxDglTOCJNV5sZQi0wtNe4i4K
         z+00lde4ZmERj08Sdi3VCcLWFWCZLqg9ggQFcny+/11jVPo28U312pGN91s70XOfrBUv
         6OAK/+C+hu9tTLQ2tdbov8pA529CXqHeVypfTozu9SyemOeBFBwFZju7PBfxXlVsIfHk
         FxRx/275nhd+SOH0amX6Q1zCpqO+ydArUh7SkyXI5cGTjt+mOeIEuOrsVEu3mW9fI+3N
         kA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694895424; x=1695500224;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UNhhSv5EciaOBb+e1S2UjWYyLKGfXoLDerHcISpMZ/M=;
        b=JF+Tc9Ro5ZmKl3iFPdEjwiZF/Tps3ctmYr+jw4N0XXNzRyboX9EBsd+aNePNMz9Kqi
         7FIKeEdorKRpYf0xEGHNtPIBtbB0XRfQlPGnvnsOVwfjMXzWIXg2UY+8AL74Fhq3olpb
         3+QkklLhBAfci969PPq6jFBCNg1JzuJaLM3KwQZcbW1syr8rVxpDQ+OoLUBFtn/JnH3K
         u4+8gSJIHTfdYvv71wjvrR1tui+GXgQRhTXQxDrANzqJDuasCcKx6+uWKzpdw7sZtl5f
         Hijsx8axhK9qD492Xhed00r1ArGII/RIrovo7X8tfYJPKlK+e6JBA/sJ9RT5TBhAw+O2
         6KRQ==
X-Gm-Message-State: AOJu0YzQAo6EE/DAaoPfyZHNP2+gWd7IpvhbpdbbdsJaIwoElBh//SJj
	dlUpfK7XW/l/om0UBYTG6TQ=
X-Google-Smtp-Source: AGHT+IH/c4i0uop45XSoB3FVHudZLfQx+wFFjmngE5fSGUxt14oE+PYAFRWGPEKb4HXVctYTbkYdMQ==
X-Received: by 2002:a05:6512:a96:b0:4f8:7513:8cac with SMTP id m22-20020a0565120a9600b004f875138cacmr5451811lfu.48.1694895423484;
        Sat, 16 Sep 2023 13:17:03 -0700 (PDT)
Received: from mobilestation ([95.79.219.206])
        by smtp.gmail.com with ESMTPSA id h10-20020ac25d6a000000b004f85d80ca64sm1140038lft.221.2023.09.16.13.17.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 13:17:02 -0700 (PDT)
Date: Sat, 16 Sep 2023 23:17:00 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jose Abreu <Jose.Abreu@synopsys.com>
Cc: Russell King <linux@armlinux.org.uk>, Jakub Kicinski <kuba@kernel.org>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, Alexei Starovoitov <ast@kernel.org>, 
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	"David S. Miller" <davem@davemloft.net>, Emil Renner Berthing <kernel@esmil.dk>, 
	Eric Dumazet <edumazet@google.com>, Fabio Estevam <festevam@gmail.com>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Samin Guo <samin.guo@starfivetech.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 4/6] net: stmmac: rk: use
 stmmac_set_tx_clk_gmii()
Message-ID: <c7jenrfdzdbvg4wa4pukan7qb6sumigulafmwgmiyjoexr5w3d@djcti5cf6b6s>
References: <ZQMPnyutz6T23E8T@shell.armlinux.org.uk>
 <E1qgmkp-007Z4s-GL@rmk-PC.armlinux.org.uk>
 <7vhtvd25qswsju34lgqi4em5v3utsxlvi3lltyt5yqqecddpyh@c5yvk7t5k5zz>
 <ZQMgtXSTsNoZohnx@shell.armlinux.org.uk>
 <rene2x562lqsknmwpaxpu337mhl4bgynct6vcyryebvem2umso@2pjocnxluxgg>
 <ZQMmV2pSCAX8AJzz@shell.armlinux.org.uk>
 <ZQMnA1PgPDDQzDrC@shell.armlinux.org.uk>
 <DM4PR12MB50888CA414C76F5C59C27E50D3F7A@DM4PR12MB5088.namprd12.prod.outlook.com>
 <uzvjph54kg2jkfbmwrvmunqv64ig7j6szr6pxxbiesnz5lletg@zq57w7jj2up4>
 <DM4PR12MB5088A61E5F067EB459C06CCFD3F6A@DM4PR12MB5088.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5088A61E5F067EB459C06CCFD3F6A@DM4PR12MB5088.namprd12.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On Fri, Sep 15, 2023 at 08:38:51AM +0000, Jose Abreu wrote:
> From: Serge Semin <fancer.lancer@gmail.com>
> Date: Thu, Sep 14, 2023 at 18:05:09
> 
> > I actually thought the driver has been long abandoned seeing how many
> > questionable changes have been accepted. That's why I decided to step
> > in with more detailed reviews for now. Anyway It's up to you to
> > decide. You are the driver maintainer after all.
> 

> It's up to everyone to decide. I understand your comments on the patchset
> and agree with most of them 

Ok. Thanks for clarification. I'll keep reviewing the bits then
submitted for the STMMAC driver based on my knowledges of the driver
guts and the DW GMAC/XGMAC/Eth QoS IP-cores implementation.

> but on the topic of changing the entire
> patchset to add the fix on "plat_stmmacenet_data->fix_mac_speed",
> I don't think it's on the scope of this series.

That's what I meant in my comment. Of course it's out of the series
scope.

-Serge(y)

> 
> Thanks,
> Jose


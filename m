Return-Path: <bpf+bounces-9734-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D4479CBE6
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 11:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC372816BA
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 09:33:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82BCB168AF;
	Tue, 12 Sep 2023 09:32:48 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 536041641A;
	Tue, 12 Sep 2023 09:32:48 +0000 (UTC)
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 321811BE;
	Tue, 12 Sep 2023 02:32:47 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-500b66f8b27so9295077e87.3;
        Tue, 12 Sep 2023 02:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694511165; x=1695115965; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0tisjtGn5HwTnlDuYa+imw6wh2RyyzM10er9tYhq8WM=;
        b=snvGSoPjxEL/s4jIixTw3OEYv4z5to0wlSuFMbExcC6FoxfPa5BY33kJdhwAtsNUlo
         LYIrclGX4BldiBLlI+ccG6dJPLbfYEZB76PQou8q4J+xOyQ96iYGZ2Gjz/F9A4vjjGZj
         jHumjYvxkgiHwwdIPyk3AzuJnkg8n1bH4/H1zvrLRldC0FdYVbO1Svs6wcQQXiGqE3Ld
         Kn9p0eFv159pNBIuM2NH3PjpNJ8XYsLa4zFaNugB0rmjgISvWF4ZshPiJ9/hkuh2SChX
         4VlXW0+/pY+SZ9CMnJPcJGfZw0zHLEzkXbUQ2w3L/lV1gyjiYKbexzkTa+An5eCusLMq
         +r8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694511165; x=1695115965;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0tisjtGn5HwTnlDuYa+imw6wh2RyyzM10er9tYhq8WM=;
        b=eygyoGwmaimW9jiFwEkg+H7XQYv0xH8eIkj8qTvvZwhI+y66TtYjXjR5Q77zXa7BMB
         y9FsgT5lkRqdi+s6EYcORWc5YiDls0OpEos294pKr79Sd96pXk2WlfMvR3KKeD1ZbJ4n
         vWT1EIbSHf523WK76akwamSH4slylxdUSPZvN2y6KV/JzV+QbQtJTJ+RX5E0CnfKI6Vs
         09tBxfDBRFzTTE7nb2M8tHYJPgXGSns96Ck5RHTOhXXKpeaeHcpL72h8BglGtWxYFJYg
         S7oLW61+swdwr0eUdHpYZ6Pz9yI9g3zHrVnSPWpBTrTpaS8wtxJsz51KH1V6DZzmUAsq
         lQYw==
X-Gm-Message-State: AOJu0Yz98Lw61upQ1TPoxM6lzS2LtMfuJNHqyOt4Ksn+fNp1mGQVyoJ+
	rZ40EyM+Sj23z7JNv15r2yI=
X-Google-Smtp-Source: AGHT+IFN0FGqvBqLO0ShV2AAM8xsq5NGKgI5Df4M79ZbrNaAs0NTSfr0K19fMExUSUhkJbZjrDV/ig==
X-Received: by 2002:ac2:4297:0:b0:500:b8bc:bd9a with SMTP id m23-20020ac24297000000b00500b8bcbd9amr8613584lfh.49.1694511164975;
        Tue, 12 Sep 2023 02:32:44 -0700 (PDT)
Received: from mobilestation ([85.249.16.222])
        by smtp.gmail.com with ESMTPSA id c10-20020ac2530a000000b004fdfd4c1fcesm1663425lfh.36.2023.09.12.02.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 02:32:44 -0700 (PDT)
Date: Tue, 12 Sep 2023 12:32:40 +0300
From: Serge Semin <fancer.lancer@gmail.com>
To: Jose Abreu <Jose.Abreu@synopsys.com>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
	Alexei Starovoitov <ast@kernel.org>, "bpf@vger.kernel.org" <bpf@vger.kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, "David S. Miller" <davem@davemloft.net>, 
	Emil Renner Berthing <kernel@esmil.dk>, Eric Dumazet <edumazet@google.com>, 
	Fabio Estevam <festevam@gmail.com>, Jakub Kicinski <kuba@kernel.org>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-stm32@st-md-mailman.stormreply.com" <linux-stm32@st-md-mailman.stormreply.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, NXP Linux Team <linux-imx@nxp.com>, 
	Paolo Abeni <pabeni@redhat.com>, Pengutronix Kernel Team <kernel@pengutronix.de>, 
	Samin Guo <samin.guo@starfivetech.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 1/6] net: stmmac: add platform library
Message-ID: <u7sabfdqk7i6wlv2j4cxuyb6psjwqs2kukdkafhcpq2zc766m3@m6iqexqjrvkv>
References: <E1qfiq8-007TOe-9F@rmk-PC.armlinux.org.uk>
 <DM4PR12MB5088F83CE829184956147E6BD3F1A@DM4PR12MB5088.namprd12.prod.outlook.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DM4PR12MB5088F83CE829184956147E6BD3F1A@DM4PR12MB5088.namprd12.prod.outlook.com>

On Tue, Sep 12, 2023 at 07:59:49AM +0000, Jose Abreu wrote:
> From: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> Date: Mon, Sep 11, 2023 at 16:28:40
> 
> > Add a platform library of helper functions for common traits in the
> > platform drivers. Currently, this is setting the tx clock.
> > 
> > Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
> > ---

> >  drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
> >  .../ethernet/stmicro/stmmac/stmmac_plat_lib.c | 29 +++++++++++++++++++
> >  .../ethernet/stmicro/stmmac/stmmac_plat_lib.h |  8 +++++
> 
> Wouldn't it be better to just call it "stmmac_lib{.c,.h}" in case we need to add
> more helpers on the future that are not only for platform-based drivers?

What is the difference between stmmac_platform.{c,h} and
stmmac_plat_lib.{c,h} files? It isn't clear really. In perspective it
may cause confusions like mixed definitions in both of these files.

Why not to use the stmmac_platform.{c,h} instead of adding one more
file? Especially seeing it already has some generic
platform/glue-drivers helpers like:
stmmac_get_platform_resources() <- especially this one.
(devm_)stmmac_probe_config_dt()
stmmac_remove_config_dt()
stmmac_pltfr_init()
stmmac_pltfr_exit()
(devm_)stmmac_pltfr_probe()
stmmac_pltfr_remove()
stmmac_pltfr_suspend()
stmmac_pltfr_resume()
stmmac_runtime_suspend()
stmmac_runtime_resume()
stmmac_pltfr_noirq_suspend()
stmmac_pltfr_noirq_resume()
All of them look like being decent to be defined in the generic
platform library methods too.

-Serge(y)

> 
> I believe it's also missing the SPDX identifiers?
> 
> Thanks,
> Jose


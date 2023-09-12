Return-Path: <bpf+bounces-9756-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D9A279D418
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 16:52:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C161281CC5
	for <lists+bpf@lfdr.de>; Tue, 12 Sep 2023 14:52:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704D118B0C;
	Tue, 12 Sep 2023 14:52:38 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7098179A0;
	Tue, 12 Sep 2023 14:52:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93AF7C433CD;
	Tue, 12 Sep 2023 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694530356;
	bh=Ayl+OQo2GhxKzgk/+pTD2IDT8nzvjC7bYrHEQNjKOhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tbX5NZaZDg4omgGReZeg3XcT52zv8O95SQf5BlDQ6yAxYUCyCznrpQ8kEgx+Mh4dZ
	 4VyxXJD9UCo5/BbZfC1mfbdxdeuq+sCGl6v+7r9c/6+2eOKpnpxsRwHtwwzhQLPTeH
	 7pQhxIN1IJJ9IRyS4FzWQfCOlMswRunfMQ1jdJNVofX+gnjHeQm0lZXYGS+tvetqNB
	 OHXficeHt+wN9/CKI/UP1ZtH7DFPH4/VCOlndcwvJx4p5vQK7ieaJ/h+EmY/HqTFHj
	 /Q//KGi+Zh1WtjpbAncBMicQTuYW4Js/UXPTx1844+Yu96/qBFQV+PwctmZwFdaTHt
	 5vh4QNf4rjf9A==
Date: Tue, 12 Sep 2023 16:52:27 +0200
From: Simon Horman <horms@kernel.org>
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Alexei Starovoitov <ast@kernel.org>, bpf@vger.kernel.org,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Emil Renner Berthing <kernel@esmil.dk>,
	Eric Dumazet <edumazet@google.com>,
	Fabio Estevam <festevam@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
	NXP Linux Team <linux-imx@nxp.com>, Paolo Abeni <pabeni@redhat.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Samin Guo <samin.guo@starfivetech.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Shawn Guo <shawnguo@kernel.org>
Subject: Re: [PATCH net-next 1/6] net: stmmac: add platform library
Message-ID: <20230912145227.GE401982@kernel.org>
References: <ZP8yEFWn0Ml3ALWq@shell.armlinux.org.uk>
 <E1qfiqd-007TPL-7K@rmk-PC.armlinux.org.uk>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1qfiqd-007TPL-7K@rmk-PC.armlinux.org.uk>

On Mon, Sep 11, 2023 at 04:29:11PM +0100, Russell King (Oracle) wrote:
> Add a platform library of helper functions for common traits in the
> platform drivers. Currently, this is setting the tx clock.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Hi Russell,

some minor issues raised by checkpatch follow.

> ---
>  drivers/net/ethernet/stmicro/stmmac/Makefile  |  2 +-
>  .../ethernet/stmicro/stmmac/stmmac_plat_lib.c | 29 +++++++++++++++++++
>  .../ethernet/stmicro/stmmac/stmmac_plat_lib.h |  8 +++++
>  3 files changed, 38 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.c
>  create mode 100644 drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.h
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index 5b57aee19267..ba2cbfa0c9d1 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
>  	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
>  	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
>  	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
> -	      stmmac_xdp.o \
> +	      stmmac_xdp.o stmmac_plat_lib.o \
>  	      $(stmmac-y)
>  
>  stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.c
> new file mode 100644
> index 000000000000..abb9f512bb0e
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_plat_lib.c
> @@ -0,0 +1,29 @@

Is an SPDX identifier appropriate here?

> +#include <linux/stmmac.h>
> +#include <linux/clk.h>
> +
> +#include "stmmac_plat_lib.h"
> +
> +int dwmac_set_tx_clk_gmii(struct clk *tx_clk, int speed)
> +{
> +	unsigned long rate;
> +
> +	switch (speed) {
> +	case SPEED_1000:
> +		rate = 125000000;
> +		break;
> +
> +	case SPEED_100:
> +		rate = 25000000;
> +		break;
> +
> +	case SPEED_10:
> +		rate = 2500000;
> +		break;
> +
> +	default:
> +		return -ENOTSUPP;

Checkpatch seems to think that EOPNOTSUPP would be more appropriate
as "ENOTSUPP is not a SUSV4 error code".

> +	}
> +
> +	return clk_set_rate(tx_clk, rate);
> +}
> +EXPORT_SYMBOL_GPL(dwmac_set_tx_clk_gmii);

...


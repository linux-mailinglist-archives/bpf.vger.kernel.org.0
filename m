Return-Path: <bpf+bounces-47055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3EC9F38B4
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 19:18:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C701893E00
	for <lists+bpf@lfdr.de>; Mon, 16 Dec 2024 18:14:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A34720626B;
	Mon, 16 Dec 2024 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwYee7zj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEADF77111;
	Mon, 16 Dec 2024 18:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734372826; cv=none; b=amk6bxKKcs0p2G7bX9EHfNdoteiZUCG8Qk2FfJq0xLUo5/cljyQtF7G/ojnuktclWluwtiCBCUWOM54DtPTVY9/SzCsXk4YHM+JXP9EdVJL6S4ZX3d5zsJH15EozFszcqfoSxRP/qZ8ouKkVT3rUkpEaYFyzsIuca+1hyg1+rlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734372826; c=relaxed/simple;
	bh=rTSVGeTAEVvK+AxoNrmfg8BdP+uyP0VmOX+NVHE+U0U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nEvE1tqLuvoB8IJgsxsr2Xl3vVAWTfMMMbIVAWQNSsRU41WO0BBDNEqJtTkTcVvu6cgyIQC5WHFb4Qg3EUX8NcEmo5hCJlqBaPqWuTXI8nbDP2SlDrv6aOeLB4tQMdD49kxL6sQDZpGud96tFV/MF4w4EbWpmT6zvvt8m6M6sXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KwYee7zj; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-43616bf3358so4940115e9.3;
        Mon, 16 Dec 2024 10:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734372823; x=1734977623; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eKosbrGAKaQf5wL58+32oIlGngsxMjL01ZKFwtIXOgQ=;
        b=KwYee7zjkcJ586wCZz3SPcgfM+rJYkun4+Umr6ZVlye36X9Avw3jNnH4LwnUKKihLz
         Z2/O8eQAperFkmiyakblqiMYfdgrTaK0F2poVbfUjbN5tGy7TFgo4VXmdUjiu7oBlvla
         R+Xbdk6MJbTUtP4fe9emkBUKKbzkvhcTz3fgZy8Co+tbE/6gwwPTv1kqNGU/CWhrORbC
         dc8m/FLHx1GvovP2dley7/NCXi+xR0Wi/9xFnlpNuEGo+G+7fwgro/9sNQmrd5QJJoAm
         a3ujbVMPQ4Y2E9xpEJRRNViOFZL5zjAvLzGpzlnzSOrEDjOOuteRpyKsnxhh31V1iDBr
         CEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734372823; x=1734977623;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKosbrGAKaQf5wL58+32oIlGngsxMjL01ZKFwtIXOgQ=;
        b=VZYMF1NGPpCSy0D8OP50nnUs6a4ZB1NNZ9qeZOFlV7CoeeSZ5B0261pXQCSnrjp0Al
         QgIcTn3qzsP8flXfiuy9dwX/58ZWYCII1kZz0Gk7wkFPTFDkITXIUremutG1KhGIiscj
         srPqvY2m5gB4pU4JCJZ/QO5T5OW6HvctaXpuZBwrsXXXjq4Yom90e56xCwTpY3BI/+j1
         xT04y9Ret6d6lPJm8/DrPGyWrGmCH9zHiq3yC4E5EcvCtUUflx79j8XXkUB2vmm+xqwd
         FU7EF7ea1ufnh8b6XwilTDBiltyQFL5g6JnVuNaIc/L5QwsmJz4Y403nsr/AcR0oTsDE
         g6Dg==
X-Forwarded-Encrypted: i=1; AJvYcCUOR5dMZDAKC+VHHU+TTs60tl0I32xag5Md0K8X0xWVF5b/+XJLN2vpVxvlo0Tfh1y5vr2c3y1d@vger.kernel.org, AJvYcCUUPQ9JT2220KoD4copBgEyWCNKWDkk2mM2gIYjo7DucAEhr6zji5U092LEcpuHBwU6c8U=@vger.kernel.org, AJvYcCWY7+wYQFVkNJsPD5xL3pNXmiSsWlZCrS9dlqr5psMlACOII9+iBTkK4nwLbtVbd2fJoaskzQ5IlWiCEatf@vger.kernel.org
X-Gm-Message-State: AOJu0Yww2BYPyn8P5cL1hHWDOYwQVfNtsxCgzjJTwDv/tw9DHIWJlM+F
	rfz2qZhWwKRGPpA11DNjIxjG1795z6/FoC7gseL5CmIva8CjQyrh
X-Gm-Gg: ASbGncsLKZdB/2AzB4Rrm2H217eySyhPH5AgY33APlAOC7t9HCdajHwyyFZkgiewTiA
	zcoCFsdBxPa0lWVGFSFWftuetCJAB6y1pmLvCTYbRJehfWMjg8byWEAIy74FiHaVIGVAPmEoGOG
	Abqr2yHSTU/vJ4lSFjXUVHikLSQfInhnuekTDQKiSoiPE8RVgumNzsA/Vk+h1Zlcto/hOWUozh2
	EjpqKQBxiW7Mo/bJ38chNjFT6JT5bWkq4+h1Y/lYXFx
X-Google-Smtp-Source: AGHT+IHjkKdWKxbJS3rOEPYm4fJp4TvPgsg3dhDscLnCl4WBKJ2SfbzqiGNWjCGQ4jbqAIrGKfMCng==
X-Received: by 2002:a05:600c:3c89:b0:430:52ec:1e2a with SMTP id 5b1f17b1804b1-4362aaac597mr46319645e9.7.1734372822562;
        Mon, 16 Dec 2024 10:13:42 -0800 (PST)
Received: from skbuf ([86.127.124.81])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4363601739asm91602395e9.8.2024.12.16.10.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Dec 2024 10:13:41 -0800 (PST)
Date: Mon, 16 Dec 2024 20:13:39 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next 5/9] igc: Add support to set MAC Merge data via
 ethtool
Message-ID: <20241216181339.zcnnqna2nc73sdgh@skbuf>
References: <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-1-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-6-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-6-faizal.abdul.rahim@linux.intel.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241216064720.931522-6-faizal.abdul.rahim@linux.intel.com>
 <20241216064720.931522-6-faizal.abdul.rahim@linux.intel.com>

On Mon, Dec 16, 2024 at 01:47:16AM -0500, Faizal Rahim wrote:
> Created fpe_t struct to store MAC Merge data and implement the
> "ethtool --set-mm" callback. The fpe_t struct will host other frame
> preemption related data in future patches.
> 
> The following fields are used to set IGC register:
> a) pmac_enabled -> TQAVCTRL.PREEMPT_ENA
>    This global register sets the preemption scheme, controlling
>    preemption capabilities in transmit and receive directions, as well as
>    the verification handshake capability.

I'm sorry, I'm not able to mentally translate this explanation into
something technical. Which capabilities are we talking about, that this
bit controls? I'm not clear what it does. The kernel-doc description of
pmac_enabled is much more succinct (and at the same time, appears to
contradict this much more elaborate yet unclear description).

> b) tx_min_frag_size -> TQAVCTRL.MIN_FRAG
>    Global register to set minimum fragments.

When you say "global register", you mean global as opposed to what?
Per station interface?

> The fields below don't set any register but will be utilized in the
> upcoming patches:
> a) verify_time
> b) verify_enabled
> c) tx_enabled
>    Note that IGC doesn't have any register to enforce "tx_enabled"
>    (preemption in transmit direction) like some other NIC. This field
>    will be used in driver level to control verification procedure and
>    managing preemption capability in transmit direction.

This is perfectly ok, tx_enabled can be a software setting. At the end
of the day, it's important for
	tx_active == tx_enabled && (!verify_enabled || verify_success)
to dictate the FPE state of the hardware in the TX direction.

> 
> At this point, verify response handshake is not enabled yet.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---
>  drivers/net/ethernet/intel/igc/igc.h         | 24 ++++++++++++-
>  drivers/net/ethernet/intel/igc/igc_defines.h |  3 ++
>  drivers/net/ethernet/intel/igc/igc_ethtool.c | 30 ++++++++++++++++
>  drivers/net/ethernet/intel/igc/igc_main.c    |  2 ++
>  drivers/net/ethernet/intel/igc/igc_tsn.c     | 37 ++++++++++++++++++--
>  drivers/net/ethernet/intel/igc/igc_tsn.h     |  9 +++++
>  6 files changed, 102 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ethernet/intel/igc/igc.h b/drivers/net/ethernet/intel/igc/igc.h
> index 480b54573d60..5a14e9101723 100644
> --- a/drivers/net/ethernet/intel/igc/igc.h
> +++ b/drivers/net/ethernet/intel/igc/igc.h
> @@ -40,6 +40,25 @@ void igc_ethtool_set_ops(struct net_device *);
>  
>  #define IGC_MAX_TX_TSTAMP_REGS		4
>  
> +/**
> + * @verify_time: see struct ethtool_mm_state
> + * @verify_enabled: see struct ethtool_mm_state
> + * @tx_enabled:
> + * Note that IGC NIC does not have the capability to enable preemption in
> + * "transmit direction". This field is used to manage transmit preemption in
> + * driver level.
> + * @pmac_enabled:
> + * Enable the capability to receive preemptible frames.
> + * @tx_min_frag_size: see struct ethtool_mm_state
> + */
> +struct fpe_t {
> +	u32 verify_time;
> +	bool verify_enabled;
> +	bool tx_enabled;
> +	bool pmac_enabled;
> +	u32 tx_min_frag_size;
> +};
> +
>  enum igc_mac_filter_type {
>  	IGC_MAC_FILTER_TYPE_DST = 0,
>  	IGC_MAC_FILTER_TYPE_SRC
> @@ -332,6 +351,8 @@ struct igc_adapter {
>  		struct timespec64 period;
>  	} perout[IGC_N_PEROUT];
>  
> +	struct fpe_t fpe;
> +
>  	/* LEDs */
>  	struct mutex led_mutex;
>  	struct igc_led_classdev *leds;
> @@ -387,10 +408,11 @@ extern char igc_driver_name[];
>  #define IGC_FLAG_TSN_QBV_ENABLED	BIT(17)
>  #define IGC_FLAG_TSN_QAV_ENABLED	BIT(18)
>  #define IGC_FLAG_TSN_LEGACY_ENABLED	BIT(19)
> +#define IGC_FLAG_TSN_PREEMPT_ENABLED	BIT(20)
>  
>  #define IGC_FLAG_TSN_ANY_ENABLED				\
>  	(IGC_FLAG_TSN_QBV_ENABLED | IGC_FLAG_TSN_QAV_ENABLED |	\
> -	 IGC_FLAG_TSN_LEGACY_ENABLED)
> +	 IGC_FLAG_TSN_LEGACY_ENABLED | IGC_FLAG_TSN_PREEMPT_ENABLED)
>  
>  #define IGC_FLAG_RSS_FIELD_IPV4_UDP	BIT(6)
>  #define IGC_FLAG_RSS_FIELD_IPV6_UDP	BIT(7)
> diff --git a/drivers/net/ethernet/intel/igc/igc_defines.h b/drivers/net/ethernet/intel/igc/igc_defines.h
> index 3a78753ab050..3088cdd08f35 100644
> --- a/drivers/net/ethernet/intel/igc/igc_defines.h
> +++ b/drivers/net/ethernet/intel/igc/igc_defines.h
> @@ -544,6 +544,9 @@
>  #define IGC_TQAVCTRL_TRANSMIT_MODE_TSN	0x00000001
>  #define IGC_TQAVCTRL_ENHANCED_QAV	0x00000008
>  #define IGC_TQAVCTRL_FUTSCDDIS		0x00000080
> +#define IGC_TQAVCTRL_PREEMPT_ENA	0x00000002
> +#define IGC_TQAVCTRL_MIN_FRAG_MASK	0x0000C000
> +#define IGC_TQAVCTRL_MIN_FRAG_SHIFT	14

Shouldn't these fields be in a particular order? like 0x00000002 should
come after 0x00000001?

>  
>  #define IGC_TXQCTL_QUEUE_MODE_LAUNCHT	0x00000001
>  #define IGC_TXQCTL_STRICT_CYCLE		0x00000002
> diff --git a/drivers/net/ethernet/intel/igc/igc_ethtool.c b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> index 817838677817..1954561ec4aa 100644
> --- a/drivers/net/ethernet/intel/igc/igc_ethtool.c
> +++ b/drivers/net/ethernet/intel/igc/igc_ethtool.c
> @@ -8,6 +8,7 @@
>  
>  #include "igc.h"
>  #include "igc_diag.h"
> +#include "igc_tsn.h"
>  
>  /* forward declaration */
>  struct igc_stats {
> @@ -1781,6 +1782,34 @@ static int igc_ethtool_set_eee(struct net_device *netdev,
>  	return 0;
>  }
>  
> +static int igc_ethtool_set_mm(struct net_device *netdev,
> +			      struct ethtool_mm_cfg *cmd,
> +			      struct netlink_ext_ack *extack)
> +{
> +	struct igc_adapter *adapter = netdev_priv(netdev);
> +	struct fpe_t *fpe = &adapter->fpe;
> +
> +	if (cmd->tx_min_frag_size < IGC_TX_MIN_FRAG_SIZE ||
> +	    cmd->tx_min_frag_size > IGC_TX_MAX_FRAG_SIZE)
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Invalid value for tx-min-frag-size");

Shouldn't the execution actually stop here with an error code?

> +	else
> +		fpe->tx_min_frag_size = cmd->tx_min_frag_size;
> +
> +	if (cmd->verify_time < MIN_VERIFY_TIME ||
> +	    cmd->verify_time > MAX_VERIFY_TIME)
> +		NL_SET_ERR_MSG_MOD(extack,
> +				   "Invalid value for verify-time");

And here too?

> +	else
> +		fpe->verify_time = cmd->verify_time;
> +
> +	fpe->tx_enabled = cmd->tx_enabled;
> +	fpe->pmac_enabled = cmd->pmac_enabled;
> +	fpe->verify_enabled = cmd->verify_enabled;
> +
> +	return igc_tsn_offload_apply(adapter);

hmm, igc_tsn_offload_apply() is a function which always returns zero.
It seems more natural to make it return void.

> +}
> +
>  static int igc_ethtool_get_link_ksettings(struct net_device *netdev,
>  					  struct ethtool_link_ksettings *cmd)
>  {
> @@ -2068,6 +2097,7 @@ static const struct ethtool_ops igc_ethtool_ops = {
>  	.set_rxfh		= igc_ethtool_set_rxfh,
>  	.get_ts_info		= igc_ethtool_get_ts_info,
>  	.get_channels		= igc_ethtool_get_channels,
> +	.set_mm			= igc_ethtool_set_mm,
>  	.set_channels		= igc_ethtool_set_channels,
>  	.get_priv_flags		= igc_ethtool_get_priv_flags,
>  	.set_priv_flags		= igc_ethtool_set_priv_flags,
> diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
> index 3f0751a9530c..b85eaf34d07b 100644
> --- a/drivers/net/ethernet/intel/igc/igc_main.c
> +++ b/drivers/net/ethernet/intel/igc/igc_main.c
> @@ -7144,6 +7144,8 @@ static int igc_probe(struct pci_dev *pdev,
>  
>  	igc_tsn_clear_schedule(adapter);
>  
> +	igc_fpe_init(&adapter->fpe);
> +
>  	/* reset the hardware with the new settings */
>  	igc_reset(adapter);
>  
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.c b/drivers/net/ethernet/intel/igc/igc_tsn.c
> index 5cd54ce435b9..b968c02f5fee 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.c
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.c
> @@ -5,6 +5,18 @@
>  #include "igc_hw.h"
>  #include "igc_tsn.h"
>  
> +#define DEFAULT_VERIFY_TIME		10
> +#define IGC_MIN_FOR_TX_MIN_FRAG		0
> +#define IGC_MAX_FOR_TX_MIN_FRAG		3
> +
> +void igc_fpe_init(struct fpe_t *fpe)
> +{
> +	fpe->verify_enabled = false;
> +	fpe->verify_time = DEFAULT_VERIFY_TIME;
> +	fpe->pmac_enabled = false;
> +	fpe->tx_min_frag_size = IGC_TX_MIN_FRAG_SIZE;
> +}
> +
>  static bool is_any_launchtime(struct igc_adapter *adapter)
>  {
>  	int i;
> @@ -49,6 +61,9 @@ static unsigned int igc_tsn_new_flags(struct igc_adapter *adapter)
>  	if (adapter->strict_priority_enable)
>  		new_flags |= IGC_FLAG_TSN_LEGACY_ENABLED;
>  
> +	if (adapter->fpe.pmac_enabled)
> +		new_flags |= IGC_FLAG_TSN_PREEMPT_ENABLED;
> +
>  	return new_flags;
>  }
>  
> @@ -148,7 +163,8 @@ static int igc_tsn_disable_offload(struct igc_adapter *adapter)
>  
>  	tqavctrl = rd32(IGC_TQAVCTRL);
>  	tqavctrl &= ~(IGC_TQAVCTRL_TRANSMIT_MODE_TSN |
> -		      IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS);
> +		      IGC_TQAVCTRL_ENHANCED_QAV | IGC_TQAVCTRL_FUTSCDDIS |
> +		      IGC_TQAVCTRL_PREEMPT_ENA | IGC_TQAVCTRL_MIN_FRAG_MASK);
>  
>  	wr32(IGC_TQAVCTRL, tqavctrl);
>  
> @@ -194,12 +210,22 @@ static void igc_tsn_set_retx_qbvfullthreshold(struct igc_adapter *adapter)
>  	wr32(IGC_RETX_CTL, retxctl);
>  }
>  
> +static u8 igc_fpe_get_frag_size_mult(const struct fpe_t *fpe)
> +{
> +	u32 tx_min_frag_size = fpe->tx_min_frag_size;
> +	u8 mult = (tx_min_frag_size / 64) - 1;
> +
> +	return clamp_t(u8, mult, IGC_MIN_FOR_TX_MIN_FRAG,
> +		       IGC_MAX_FOR_TX_MIN_FRAG);
> +}

If you translate the continuous range of TX fragment sizes into
discrete multipliers because that's what the hardware works with, why
don't you just reject the non-multiple values using
ethtool_mm_frag_size_min_to_add(), and at the same time use the output
of that function directly to obtain your multiplier? IIUC it gets you
the same result.

> +
>  static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>  {
>  	struct igc_hw *hw = &adapter->hw;
>  	u32 tqavctrl, baset_l, baset_h;
>  	u32 sec, nsec, cycle, rxpbs;
>  	ktime_t base_time, systim;
> +	u32 frag_size_mult;
>  	int i;
>  
>  	wr32(IGC_TSAUXC, 0);
> @@ -370,10 +396,17 @@ static int igc_tsn_enable_offload(struct igc_adapter *adapter)
>  		wr32(IGC_TXQCTL(i), txqctl);
>  	}
>  
> -	tqavctrl = rd32(IGC_TQAVCTRL) & ~IGC_TQAVCTRL_FUTSCDDIS;
> +	tqavctrl = rd32(IGC_TQAVCTRL) & ~(IGC_TQAVCTRL_FUTSCDDIS |
> +		   IGC_TQAVCTRL_MIN_FRAG_MASK | IGC_TQAVCTRL_PREEMPT_ENA);
>  
>  	tqavctrl |= IGC_TQAVCTRL_TRANSMIT_MODE_TSN | IGC_TQAVCTRL_ENHANCED_QAV;
>  
> +	if (adapter->fpe.pmac_enabled)
> +		tqavctrl |= IGC_TQAVCTRL_PREEMPT_ENA;
> +
> +	frag_size_mult = igc_fpe_get_frag_size_mult(&adapter->fpe);
> +	tqavctrl |= frag_size_mult << IGC_TQAVCTRL_MIN_FRAG_SHIFT;
> +
>  	adapter->qbv_count++;
>  
>  	cycle = adapter->cycle_time;
> diff --git a/drivers/net/ethernet/intel/igc/igc_tsn.h b/drivers/net/ethernet/intel/igc/igc_tsn.h
> index 98ec845a86bf..08e7582f257e 100644
> --- a/drivers/net/ethernet/intel/igc/igc_tsn.h
> +++ b/drivers/net/ethernet/intel/igc/igc_tsn.h
> @@ -4,6 +4,15 @@
>  #ifndef _IGC_TSN_H_
>  #define _IGC_TSN_H_
>  
> +/* IGC_TX_MIN_FRAG_SIZE is based on the MIN_FRAG field in Section 8.12.2 of the
> + * SW User Manual.
> + */
> +#define IGC_TX_MIN_FRAG_SIZE		68
> +#define IGC_TX_MAX_FRAG_SIZE		260

Odd. Is there a link to this manual (for I225 I suppose)? Standard values are 60, 124, 188, 252.
Maybe the methodology for calculating these is used here? As things stand,
if the driver reports these values, IIUC, openlldp gets confused and communicates
a LLDP_8023_ADD_ETH_CAPS_ADD_FRAG_SIZE value to the link partner which is higher
than it could have been (68 is rounded up to the next standard TX fragment size,
which is 124). So the link partner will preempt in larger chunks and this will
not reduce latency as much.

If you run tools/testing/selftests/drivers/net/hw/ethtool_mm.sh, that
should also spot some inconsistencies, since some of the tests run openlldp
on both ends.

> +#define MIN_VERIFY_TIME			1
> +#define MAX_VERIFY_TIME			128
> +
> +void igc_fpe_init(struct fpe_t *fpe);
>  int igc_tsn_offload_apply(struct igc_adapter *adapter);
>  int igc_tsn_reset(struct igc_adapter *adapter);
>  void igc_tsn_adjust_txtime_offset(struct igc_adapter *adapter);
> -- 
> 2.25.1
> 
> 



Return-Path: <bpf+bounces-13365-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BA97D8B5A
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 00:03:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6AD631F2339F
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953DD3E483;
	Thu, 26 Oct 2023 22:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WOVbvVk2"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845ED34CDA;
	Thu, 26 Oct 2023 22:02:57 +0000 (UTC)
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C63BFCA;
	Thu, 26 Oct 2023 15:02:55 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2c515527310so19785821fa.2;
        Thu, 26 Oct 2023 15:02:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698357774; x=1698962574; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BQfvT8y1gch6L7r+cd34RGIc+yfvci8UCEz/1CgAlZs=;
        b=WOVbvVk2PczdxkZpmrH3J73c21neRGzHLwWu35GU7oYdns8w3gByVlRez/SjI1lpKF
         BlAuzRZ4emRga0j1wmtUKMuwLIRSbBvYqcy6DpqlMMYwM/hNaNz3H1XbS21+9YF1SNYF
         2jdpvNngxUv0+qy9qnWf3+GHiM+ia5g/XIHYjClVBdCO4Bw60gfJLaf1c1lf1M3PM2oZ
         EQFxYEpWB9LSP0CQ3tKjZ3lfKst4Aoj3iI3Gng64Iaf13wfxFA2urmWLPQZOa/kMfqTF
         LsBKDq/sm6aoQcq0F0sVRHBTKX0nFqaA6go5A56eHC78hxi0QAeqgxXJ0uznhyynXKoA
         uSXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698357774; x=1698962574;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQfvT8y1gch6L7r+cd34RGIc+yfvci8UCEz/1CgAlZs=;
        b=DqJZaS4JIQYY6Z2NwcdAhB4Gnma2/wyD72Ri429SVqIkyKdLETt5q9EzvZsoThChRT
         nTvZIdGXTpCGbu7UQJtwg0FaYcwXuiONR28hNBWXKMEtutnNFeeNUCD+v0Mnnv367CiX
         ZXMGgGs1KpJAlLO4xwtEX1dFycdy07A1EEHDMLtOecfT5zzZLPw0WXBED1OKC54l/kUr
         3NRyE+EW72KJ3XdfmNam4AGCLHdrapEc5/P5MGmfT/ZrmTzfkLE6W5+rBM3TVLp99nMQ
         sULWBk7k8MObgW3NwQTr7IZg0zhjoxzMzG8caATT4yW2L8a73RkOA2oJ+zQLh3sD//xL
         VJUg==
X-Gm-Message-State: AOJu0Yz8sFkIdhxZgrfUyEeEuMqSNmQWJ1/lM2gQawNha07oCplkVzQA
	S/kDzMSq9ludF226+lail4E62yPPmIl3ng==
X-Google-Smtp-Source: AGHT+IGuubdy/jFwl4wBIyZtQBS6fd10jfaDuzrU+e7/3gTcDFAAkjVweuEKeSjFQKbqhqZh5dT0+g==
X-Received: by 2002:ac2:5f76:0:b0:507:a66f:55e2 with SMTP id c22-20020ac25f76000000b00507a66f55e2mr482508lfc.10.1698357773694;
        Thu, 26 Oct 2023 15:02:53 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id q26-20020adfb19a000000b0031f82743e25sm324618wra.67.2023.10.26.15.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:02:52 -0700 (PDT)
Date: Fri, 27 Oct 2023 01:02:48 +0300
From: Vladimir Oltean <olteanv@gmail.com>
To: Justin Stitt <justinstitt@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>, Noam Dagan <ndagan@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>, Rasesh Mody <rmody@marvell.com>,
	Sudarsana Kalluru <skalluru@marvell.com>,
	GR-Linux-NIC-Dev@marvell.com,
	Dimitris Michailidis <dmichail@fungible.com>,
	Yisen Zhuang <yisen.zhuang@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Louis Peens <louis.peens@corigine.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Brett Creeley <brett.creeley@amd.com>, drivers@pensando.io,
	"K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
	Ronak Doshi <doshir@vmware.com>,
	VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
	Andy Whitcroft <apw@canonical.com>, Joe Perches <joe@perches.com>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Hauke Mehrtens <hauke@hauke-m.de>, Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	=?utf-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Landen Chao <Landen.Chao@mediatek.com>,
	DENG Qingfang <dqfext@gmail.com>,
	Sean Wang <sean.wang@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	NXP Linux Team <linux-imx@nxp.com>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com, Jiawen Wu <jiawenwu@trustnetic.com>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	Nick Desaulniers <ndesaulniers@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Kees Cook <keescook@chromium.org>, intel-wired-lan@lists.osuosl.org,
	oss-drivers@corigine.com, linux-hyperv@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH next v2 1/3] ethtool: Implement ethtool_puts()
Message-ID: <20231026220248.blgf7kgt5fkkbg7f@skbuf>
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-1-0d67cbdd0538@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-ethtool_puts_impl-v2-1-0d67cbdd0538@google.com>

Hi Justin,

On Thu, Oct 26, 2023 at 09:56:07PM +0000, Justin Stitt wrote:
> Use strscpy() to implement ethtool_puts().
> 
> Functionally the same as ethtool_sprintf() when it's used with two
> arguments or with just "%s" format specifier.
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  include/linux/ethtool.h | 34 +++++++++++++++++++++++-----------
>  net/ethtool/ioctl.c     |  7 +++++++
>  2 files changed, 30 insertions(+), 11 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 226a36ed5aa1..7129dd2e227c 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -1053,22 +1053,34 @@ static inline int ethtool_mm_frag_size_min_to_add(u32 val_min, u32 *val_add,
>   */
>  extern __printf(2, 3) void ethtool_sprintf(u8 **data, const char *fmt, ...);
>  
> +/**
> + * ethtool_puts - Write string to ethtool string data
> + * @data: Pointer to start of string to update
> + * @str: String to write
> + *
> + * Write string to data. Update data to point at start of next
> + * string.
> + *
> + * Prefer this function to ethtool_sprintf() when given only
> + * two arguments or if @fmt is just "%s".
> + */
> +extern void ethtool_puts(u8 **data, const char *str);
> +
>  /* Link mode to forced speed capabilities maps */
>  struct ethtool_forced_speed_map {
> -	u32		speed;
> +	u32 speed;
>  	__ETHTOOL_DECLARE_LINK_MODE_MASK(caps);
>  
> -	const u32	*cap_arr;
> -	u32		arr_size;
> +	const u32 *cap_arr;
> +	u32 arr_size;
>  };
>  
> -#define ETHTOOL_FORCED_SPEED_MAP(prefix, value)				\
> -{									\
> -	.speed		= SPEED_##value,				\
> -	.cap_arr	= prefix##_##value,				\
> -	.arr_size	= ARRAY_SIZE(prefix##_##value),			\
> -}
> +#define ETHTOOL_FORCED_SPEED_MAP(prefix, value)                      \
> +	{                                                            \
> +		.speed = SPEED_##value, .cap_arr = prefix##_##value, \
> +		.arr_size = ARRAY_SIZE(prefix##_##value),            \
> +	}
>  
> -void
> -ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size);
> +void ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps,
> +				    u32 size);
>  #endif /* _LINUX_ETHTOOL_H */

Maybe this is due to an incorrect rebase conflict resolution, but you
shouldn't have touched any of the ethtool force speed maps.

Please wait for at least 24 hours to pass before posting a new version,
to allow for more comments to come in.


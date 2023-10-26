Return-Path: <bpf+bounces-13369-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB0107D8B7B
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 00:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76400282215
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899423F4AB;
	Thu, 26 Oct 2023 22:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN5f6ncj"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C163E46C;
	Thu, 26 Oct 2023 22:12:14 +0000 (UTC)
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E6E7192;
	Thu, 26 Oct 2023 15:12:12 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-32d80ae19f8so952711f8f.2;
        Thu, 26 Oct 2023 15:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698358331; x=1698963131; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=9dxV0z/KJX2jAtAYojUd4aHcjxi+u31o0EAgu6F7IwM=;
        b=IN5f6ncj7iukrDUcd6JuT8NsgCZszbYS7mty/v/snDJSUB2IB0ESvl7hUhFP5PSqRo
         GuS9UEF+L1ptgcPQJIW4JiKbJ8UxkKx9ri7Sudn7LmaL6HhOoXovNL60rMyNVm1IpWMA
         MtBeaJNf8edBGkbY4GL+NBND/A6Oe27g1s8GQ0Bz8s89E3aVKtiPpKI/lZxhAnTn7klO
         mRAu5OU44U7Ad8nNzQMDQVJGt9Qno6Xl2gTzeQu0FaGAOeOeQAbXtxVEzzo1iZo/nDOe
         fdrzcysmRYYMIxpLQMNOecCKdtRt8Xli94unglZkeKjoTeBC4QSWqikr1up15yr1Snxd
         eieQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698358331; x=1698963131;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dxV0z/KJX2jAtAYojUd4aHcjxi+u31o0EAgu6F7IwM=;
        b=i6IjBNKzuaf/JE54QMtEZ1hr5p4bSRit5HuGsY3pq++18wO5DXYWvxIaKvFlXVNqgB
         puBguRqP7goPCTiQvbgREn9Mo63wD3j6j3ywqw2XCrJ8E6cJ1oG4G/HBQlwOplAzFsZs
         cS8wqk3OM56B4D3rGL63BN6Oe2pAgWqjb6KkkNuh15YUO2lasK05CMQCXN4gh9Z3WbGN
         Y6DUvaEtJtSmotEOOAgCT1K1FsMC+Za+UIJosrAtlrmd+o7JL7Johj6O0HqMuU1Oo7En
         k1J6Yjd97ls/xVPITQQI+2gUuUiSwbwmhyGY+zT9QRG7LWCRkopx0/1c46kUdc3AuvDd
         SXiA==
X-Gm-Message-State: AOJu0Yw9NbzDIvIt3GU7D2xLW9e2IMAuNnCoTsZ5DbUIZ1lRbK3rQvIS
	+WkbvDKOiOBJATz2fcKSZnE=
X-Google-Smtp-Source: AGHT+IEFBkpZiWpPOgBWSz7VhB+L8HEH65ute3OKtRNDPYBqco6PY6IhRvs9olvc+3J8je+BIT3EsA==
X-Received: by 2002:a5d:5a06:0:b0:32d:a101:689d with SMTP id bq6-20020a5d5a06000000b0032da101689dmr886013wrb.56.1698358330949;
        Thu, 26 Oct 2023 15:12:10 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id d16-20020adfef90000000b0032326908972sm358008wro.17.2023.10.26.15.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:12:10 -0700 (PDT)
Date: Fri, 27 Oct 2023 01:12:06 +0300
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
Subject: Re: [PATCH next v2 2/3] checkpatch: add ethtool_sprintf rules
Message-ID: <20231026221206.52oge3a5w4uxkkd5@skbuf>
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-2-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-2-0d67cbdd0538@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231026-ethtool_puts_impl-v2-2-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-2-0d67cbdd0538@google.com>

On Thu, Oct 26, 2023 at 09:56:08PM +0000, Justin Stitt wrote:
> Add some warnings for using ethtool_sprintf() where a simple
> ethtool_puts() would suffice.
> 
> The two cases are:
> 
> 1) Use ethtool_sprintf() with just two arguments:
> |       ethtool_sprintf(&data, driver[i].name);
> or
> 2) Use ethtool_sprintf() with a standalone "%s" fmt string:
> |       ethtool_sprintf(&data, "%s", driver[i].name);
> 
> The former may cause -Wformat-security warnings while the latter is just
> not preferred. Both are safely in the category of warnings, not errors.
> 
> Signed-off-by: Justin Stitt <justinstitt@google.com>
> ---
>  scripts/checkpatch.pl | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/scripts/checkpatch.pl b/scripts/checkpatch.pl
> index 25fdb7fda112..22f007131337 100755
> --- a/scripts/checkpatch.pl
> +++ b/scripts/checkpatch.pl
> @@ -7011,6 +7011,25 @@ sub process {
>  			     "Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90\n" . $herecurr);
>  		}
>  
> +# ethtool_sprintf uses that should likely be ethtool_puts
> +		if ($line =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*$FuncArg\s*\)/) {
> +			if(WARN("ETHTOOL_SPRINTF",
> +			   "Prefer ethtool_puts over ethtool_sprintf with only two arguments\n" . $herecurr) &&
> +         $fix) {
> +         $fixed[$fixlinenr] =~ s/ethtool_sprintf\s*\(/ethtool_puts\(/;
> +       }
> +		}
> +
> +		# use $rawline because $line loses %s via sanitization and thus we can't match against it.
> +		if ($rawline =~ /\bethtool_sprintf\s*\(\s*$FuncArg\s*,\s*\"\%s\"\s*,\s*$FuncArg\s*\)/) {
> +			if(WARN("ETHTOOL_SPRINTF",
> +			   "Prefer ethtool_puts over ethtool_sprintf with standalone \"%s\" specifier\n" . $herecurr) &&
> +         $fix) {
> +         $fixed[$fixlinenr] =~ s/ethtool_sprintf\s*\(\s*(.*?),.*?,(.*?)\)/ethtool_puts\($1,$2)/;
> +       }
> +		}
> +
> +
>  # typecasts on min/max could be min_t/max_t
>  		if ($perl_version_ok &&
>  		    defined $stat &&
> 
> -- 
> 2.42.0.820.g83a721a137-goog
> 

I don't really know Perl, but does the indentation and coding style here
conform to any rules, or is it just free-form? The rest of the script
looks almost as you'd expect from C. This is unreadable to me.


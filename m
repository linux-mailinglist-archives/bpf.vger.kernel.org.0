Return-Path: <bpf+bounces-13371-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7B7A7D8B9D
	for <lists+bpf@lfdr.de>; Fri, 27 Oct 2023 00:21:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7917BB213A7
	for <lists+bpf@lfdr.de>; Thu, 26 Oct 2023 22:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7783F4CD;
	Thu, 26 Oct 2023 22:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DWt7kbDw"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AFC3D980;
	Thu, 26 Oct 2023 22:21:09 +0000 (UTC)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035DBCC;
	Thu, 26 Oct 2023 15:21:08 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-4084b0223ccso11073175e9.2;
        Thu, 26 Oct 2023 15:21:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698358866; x=1698963666; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BZVyVYzi+6QbDuBCDPXiv+7wbOfcRmZKqyElOZWrfZc=;
        b=DWt7kbDwohqS9bxyyggcvuxhI5HWgiH+dY5yaD8kijELakjz2DiQoxrFh5QubCBhV6
         CLhhLm6BXlYk4KCwSCjEwEh1aIXAZNZb3L+dDf2p9ZOIMMnMBNggC6O206wFSxR+c3Ze
         byBHekN06lUKX5Av9ZfTcwXed+DeTgw68/Omif5jP0qufMIzY7FlfXoZnhm8ozwq1Kw4
         i40qxj+ts+WV8x/xg0jK+cfJW3M5fLMDnoQ1OQPLz4nE6LRsk79+fbLNYOpQCUtD/GY/
         o7wgzEyIhNYWqsJWwguT2aGgc80ef9ggtU1ZlLuyxKofo75VpGa0JXDlkgvoOgAoGUeJ
         l40g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698358866; x=1698963666;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BZVyVYzi+6QbDuBCDPXiv+7wbOfcRmZKqyElOZWrfZc=;
        b=PNZYTYK9ThUnUQgHR86LgWWvfBnQNi13UPXnrypr7SA66/9pjHjfdV4OHdNlqcd22s
         GVVuLfmmqQnvfJgOQAlJyD9+Gehftu1Yai5sb3PkxizzCsyqsO1OlR61rCWUl6/7X7L6
         ze1hNUGfEhMbMeS4XkRVa1M5KNjKF4gi8em2vuWOzyjT0WJi3U6BH5G8GS3luKChbGaS
         Q8EmKghHJ8NCtz3WsVct3heBIE9KbHSk7IMIGFIlJ9jXr7+D1CoZETQecX17p0QtyvPW
         glgtbDSUuY9DPmMyXayNoEv4m6052BuqzF6laO6OPasxSlaaHFnzxCqsw6TuS7KCGikT
         bsJw==
X-Gm-Message-State: AOJu0Yzn+yub9ob1aXZ7YoybPMKDDHVV1seApxDm4DeJLoFUsZRxy590
	oyJ4zPSBzGP+dgXfrcDV10I=
X-Google-Smtp-Source: AGHT+IEKimHb5xke6jH18TsHWKRxjcjGmlx0/kFhipt1/3/BG8Q2ivqVE2EsAdNFToNo9uL7wPtB6A==
X-Received: by 2002:a05:600c:3c9a:b0:409:1d9a:1dec with SMTP id bg26-20020a05600c3c9a00b004091d9a1decmr908421wmb.35.1698358866086;
        Thu, 26 Oct 2023 15:21:06 -0700 (PDT)
Received: from skbuf ([188.26.57.160])
        by smtp.gmail.com with ESMTPSA id hg10-20020a05600c538a00b0040775fd5bf9sm148982wmb.0.2023.10.26.15.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 15:21:05 -0700 (PDT)
Date: Fri, 27 Oct 2023 01:21:00 +0300
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
Message-ID: <20231026222100.yrjsdlq47djaurjf@skbuf>
References: <20231026-ethtool_puts_impl-v2-0-0d67cbdd0538@google.com>
 <20231026-ethtool_puts_impl-v2-1-0d67cbdd0538@google.com>
 <20231026220248.blgf7kgt5fkkbg7f@skbuf>
 <CAFhGd8rWOE8zGFCdjM6i8H3TP8q5BFFxMGCk0n-nmLmjHojefg@mail.gmail.com>
 <CAFhGd8pJkdpF4BYDf_Ym-zsisAVzM06_4ba+_6Uca_2Xerp1Qg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFhGd8pJkdpF4BYDf_Ym-zsisAVzM06_4ba+_6Uca_2Xerp1Qg@mail.gmail.com>

On Thu, Oct 26, 2023 at 03:11:28PM -0700, Justin Stitt wrote:
> On Thu, Oct 26, 2023 at 3:09 PM Justin Stitt <justinstitt@google.com> wrote:
> > On Thu, Oct 26, 2023 at 3:02 PM Vladimir Oltean <olteanv@gmail.com> wrote:
> > > Maybe this is due to an incorrect rebase conflict resolution, but you
> > > shouldn't have touched any of the ethtool force speed maps.
> >
> > Ah, I did have a conflict and resolved by simply moving the hunks
> > out of each other's way. Trivial resolution.
> >
> > Should I undo this? I want my patch against next since it's targeting
> > some stuff in-flight over there. BUT, I also want ethtool_puts() to be
> > directly below ethtool_sprintf() in the source code. What to do?
> 
> Oh, I just realized my auto formatter had a field day with that function.
> I will rectify this in a new version after waiting 24hrs for comments to
> trickle in as well.

Nothing other than ethtool_puts() should appear in the patch delta.

pw-bot: cr


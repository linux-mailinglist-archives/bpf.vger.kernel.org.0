Return-Path: <bpf+bounces-6746-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 685C876D817
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 21:41:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9878D1C210C3
	for <lists+bpf@lfdr.de>; Wed,  2 Aug 2023 19:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C37511CB3;
	Wed,  2 Aug 2023 19:40:26 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE9611C9C
	for <bpf@vger.kernel.org>; Wed,  2 Aug 2023 19:40:26 +0000 (UTC)
X-Greylist: delayed 3591 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 02 Aug 2023 12:40:24 PDT
Received: from mx09lb.world4you.com (mx09lb.world4you.com [81.19.149.119])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CEA4D9;
	Wed,  2 Aug 2023 12:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=engleder-embedded.com; s=dkim11; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=+IumxvxKi+iMawNAaFtZK2UTAxlSL2j77qZ9xPuW9H8=; b=CroP3RA+k/rOE7AQbNo4oTgRJa
	34GSZMOuq76KLSYV52p0p+qQ9JYfD4HhTOcwk0hjF8Lu4mCdtOrFcdlrp/lcn6PEWevT8zJtHwv14
	CPU4HT54usIODNpBFKQROn9PXoxvQYqYsogrXC809Fyzc+tkSVCnTsnDZjx2k8cJr+3s=;
Received: from [88.117.54.85] (helo=[10.0.0.160])
	by mx09lb.world4you.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <gerhard@engleder-embedded.com>)
	id 1qRGEv-00028k-0j;
	Wed, 02 Aug 2023 20:06:29 +0200
Message-ID: <58b4f563-5bfc-65ed-c213-ae17724e5a33@engleder-embedded.com>
Date: Wed, 2 Aug 2023 20:06:28 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH bpf-next 1/3] eth: add missing xdp.h includes in drivers
To: Jakub Kicinski <kuba@kernel.org>, ast@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, hawk@kernel.org,
 amritha.nambiar@intel.com, aleksander.lobakin@intel.com,
 j.vosburgh@gmail.com, andy@greyhouse.net, shayagr@amazon.com,
 akiyano@amazon.com, ioana.ciornei@nxp.com, claudiu.manoil@nxp.com,
 vladimir.oltean@nxp.com, wei.fang@nxp.com, shenwei.wang@nxp.com,
 xiaoning.wang@nxp.com, linux-imx@nxp.com, dmichail@fungible.com,
 jeroendb@google.com, pkaligineedi@google.com, shailend@google.com,
 jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, grygorii.strashko@ti.com,
 longli@microsoft.com, sharmaajay@microsoft.com, daniel@iogearbox.net,
 john.fastabend@gmail.com, simon.horman@corigine.com, leon@kernel.org,
 linux-hyperv@vger.kernel.org
References: <20230802003246.2153774-1-kuba@kernel.org>
 <20230802003246.2153774-2-kuba@kernel.org>
Content-Language: en-US
From: Gerhard Engleder <gerhard@engleder-embedded.com>
In-Reply-To: <20230802003246.2153774-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AV-Do-Run: Yes
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H3,
	RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 02.08.23 02:32, Jakub Kicinski wrote:
> Handful of drivers currently expect to get xdp.h by virtue
> of including netdevice.h. This will soon no longer be the case
> so add explicit includes.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

(...)

> diff --git a/drivers/net/ethernet/engleder/tsnep.h b/drivers/net/ethernet/engleder/tsnep.h
> index 11b29f56aaf9..6e14c918e3fb 100644
> --- a/drivers/net/ethernet/engleder/tsnep.h
> +++ b/drivers/net/ethernet/engleder/tsnep.h
> @@ -14,6 +14,7 @@
>   #include <linux/net_tstamp.h>
>   #include <linux/ptp_clock_kernel.h>
>   #include <linux/miscdevice.h>
> +#include <net/xdp.h>

Reviewed-by: Gerhard Engleder <gerhard@engleder-embedded.com>


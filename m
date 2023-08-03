Return-Path: <bpf+bounces-6868-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4768976EC03
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 16:11:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 774431C21579
	for <lists+bpf@lfdr.de>; Thu,  3 Aug 2023 14:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3BED23BCA;
	Thu,  3 Aug 2023 14:10:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E154015482;
	Thu,  3 Aug 2023 14:10:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E1AC433C8;
	Thu,  3 Aug 2023 14:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691071804;
	bh=Rx0WClHmnNKVmsFeZGA3nBlclFqEd5ganx10t5XvSmU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=ckTD8ivVPsqOxgZZCRUD5ATL34b1ZWDoD5CkDZhe5TxEToNzmRmtJXVZvB4mN5Oll
	 l2H4er3bia0MfNWNGQwxNKI/Q12GiCxM/Ht6CXwhudw0TWiMBx3YIN8IkpCq/UIhWr
	 j4i11pO4aU02hjw24mkd5xXS2IlcVBnI5Qe3rPUrqusTo6EgbQZDSuSsEhh5F5Rgrs
	 st/Sc1g9pWpM9ntF6rrCJogSeiiey76UfezwHD3M5FtEgt14ifdO0XIl6nSIm4r73G
	 aOUhmDJZPNGJFkp8tl9JG8UXkiE7PgyfBW45TcFo5/GQz9B4FvQdYaBG5qKqmbcycC
	 B2XZCBtAVmDhQ==
Message-ID: <01fcf1f1-d2d8-f26c-dd5c-be2655ef39a2@kernel.org>
Date: Thu, 3 Aug 2023 16:09:55 +0200
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH bpf-next v2 1/3] eth: add missing xdp.h includes in
 drivers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, ast@kernel.org
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, amritha.nambiar@intel.com,
 aleksander.lobakin@intel.com, Wei Fang <wei.fang@nxp.com>,
 Gerhard Engleder <gerhard@engleder-embedded.com>, j.vosburgh@gmail.com,
 andy@greyhouse.net, shayagr@amazon.com, akiyano@amazon.com,
 ioana.ciornei@nxp.com, claudiu.manoil@nxp.com, vladimir.oltean@nxp.com,
 shenwei.wang@nxp.com, xiaoning.wang@nxp.com, linux-imx@nxp.com,
 dmichail@fungible.com, jeroendb@google.com, pkaligineedi@google.com,
 shailend@google.com, jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
 horatiu.vultur@microchip.com, UNGLinuxDriver@microchip.com,
 kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
 decui@microsoft.com, peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
 joabreu@synopsys.com, mcoquelin.stm32@gmail.com, grygorii.strashko@ti.com,
 longli@microsoft.com, sharmaajay@microsoft.com, daniel@iogearbox.net,
 john.fastabend@gmail.com, simon.horman@corigine.com, leon@kernel.org,
 linux-hyperv@vger.kernel.org
References: <20230803010230.1755386-1-kuba@kernel.org>
 <20230803010230.1755386-2-kuba@kernel.org>
From: Jesper Dangaard Brouer <hawk@kernel.org>
In-Reply-To: <20230803010230.1755386-2-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 03/08/2023 03.02, Jakub Kicinski wrote:
> Handful of drivers currently expect to get xdp.h by virtue
> of including netdevice.h. This will soon no longer be the case
> so add explicit includes.
> 
> Reviewed-by: Wei Fang<wei.fang@nxp.com>
> Reviewed-by: Gerhard Engleder<gerhard@engleder-embedded.com>
> Signed-off-by: Jakub Kicinski<kuba@kernel.org>
> ---

LGTM

Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>



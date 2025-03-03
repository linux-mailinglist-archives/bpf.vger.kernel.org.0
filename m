Return-Path: <bpf+bounces-53051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A21B5A4BF4D
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 12:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9DF167477
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 11:50:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9EB320D4E2;
	Mon,  3 Mar 2025 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="ObLVyW93"
X-Original-To: bpf@vger.kernel.org
Received: from fllvem-ot03.ext.ti.com (fllvem-ot03.ext.ti.com [198.47.19.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A70420C028;
	Mon,  3 Mar 2025 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.245
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741002625; cv=none; b=cnsm6e+EuXg6ltuvvEXL7uO48gX93wGFtX8/vzxPlklb2R48Z/NXYmL0ocVHJATBF/2tUg/xFW927amurRYgN6M2sbw0/KhKB0XfRTESKyfXqBwS7nWZ1owc7AkriIdkFbdP49g1tCRkiUH1n2SUUFmhLvzJQeG1nzIS4IsnQ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741002625; c=relaxed/simple;
	bh=EIYFdXApveqnm4xf9rgkR4gC39U63SZZJHFclnE2ODQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Go1/xx/Wg97SrRyPIgiNE37qCax5sjPHH+J89EGKKxvrzw13LKtSyc0ZvBkAbH1tMHTndxJjeVfQ8EjpCQ97ACsCAcLwSGAWUa3atoj5FqMr2Us0mEQCxV7nHTUKoYvb7oCfF8nFXrlrxb5bFQvQt6E5DI7yJ2acmzJVh1Om5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=ObLVyW93; arc=none smtp.client-ip=198.47.19.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0034.itg.ti.com ([10.64.40.246])
	by fllvem-ot03.ext.ti.com (8.15.2/8.15.2) with ESMTPS id 523BnaOA2672834
	(version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Mar 2025 05:49:36 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1741002576;
	bh=LtLTcgj+wTfwtj7P3s1/LE4IyDDTgXqvwipyBUTOI18=;
	h=Date:Subject:To:CC:References:From:In-Reply-To;
	b=ObLVyW93xulqoW6jAymFcaL01GbRW6yejSpjz1KmauRIAYoBh+4QLKrz7qVp+Uk1/
	 KP7AZorNrO+VZDq2nlT9Pwx6j6rpJpKtxfpdbC8vI3snKumo//FkBEA8Woj0NRjqyO
	 HVB++sLbrK15SZFx8qiV3E3OuMSu5BnunZSyAbCo=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 523Bnaac119408
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 3 Mar 2025 05:49:36 -0600
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 3
 Mar 2025 05:49:36 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 3 Mar 2025 05:49:36 -0600
Received: from [172.24.21.156] (lt9560gk3.dhcp.ti.com [172.24.21.156])
	by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 523BnTXH029594;
	Mon, 3 Mar 2025 05:49:30 -0600
Message-ID: <06d2b616-9f11-46ae-91f7-e97f86f9f24c@ti.com>
Date: Mon, 3 Mar 2025 17:19:28 +0530
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH net-next v3 2/3] net: ti: icssg-prueth:
 introduce and use prueth_swdata struct for SWDATA
To: Dan Carpenter <dan.carpenter@linaro.org>
CC: <rogerq@kernel.org>, <danishanwar@ti.com>, <pabeni@redhat.com>,
        <kuba@kernel.org>, <edumazet@google.com>, <davem@davemloft.net>,
        <andrew+netdev@lunn.ch>, <bpf@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <u.kleine-koenig@baylibre.com>,
        <matthias.schiffer@ew.tq-group.com>, <schnelle@linux.ibm.com>,
        <diogo.ivo@siemens.com>, <glaroque@baylibre.com>, <macro@orcam.me.uk>,
        <john.fastabend@gmail.com>, <hawk@kernel.org>, <daniel@iogearbox.net>,
        <ast@kernel.org>, <srk@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
References: <20250224110102.1528552-1-m-malladi@ti.com>
 <20250224110102.1528552-3-m-malladi@ti.com>
 <41fbeb70-bf49-4751-b4ba-6b122a45233d@stanley.mountain>
Content-Language: en-US
From: "Malladi, Meghana" <m-malladi@ti.com>
In-Reply-To: <41fbeb70-bf49-4751-b4ba-6b122a45233d@stanley.mountain>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea



On 2/26/2025 3:59 PM, Dan Carpenter wrote:
> On Mon, Feb 24, 2025 at 04: 31: 01PM +0530, Meghana Malladi wrote: > 
> From: Roger Quadros <rogerq@ kernel. org> > > We have different cases 
> for SWDATA (skb, page, cmd, etc) > so it is better to have a dedicated 
> data structure for
> ZjQcmQRYFpfptBannerStart
> This message was sent from outside of Texas Instruments.
> Do not click links or open attachments unless you recognize the source 
> of this email and know the content is safe.
> Report Suspicious
> <https://us-phishalarm-ewt.proofpoint.com/EWT/v1/G3vK! 
> uldqnT1FPMdbygXOdhMC_1iqujTzdK2ZTrOjiy9hZrrhggm_lCduTFVqMq5QnhhjXmDeSX6KQhxE9U6zpHeghHYcqYQiiHpSSbljHpY$>
> ZjQcmQRYFpfptBannerEnd
> 
> On Mon, Feb 24, 2025 at 04:31:01PM +0530, Meghana Malladi wrote:
>> From: Roger Quadros <rogerq@kernel.org>
>> 
>> We have different cases for SWDATA (skb, page, cmd, etc)
>> so it is better to have a dedicated data structure for that.
>> We can embed the type field inside the struct and use it
>> to interpret the data in completion handlers.
>> 
>> Increase SWDATA size to 48 so we have some room to add
>> more data if required.
> 
> What is the "SWDATA size"?  Where is that specified?  Is
> that a variable or a define or the size of a struct or
> what?
> 

Will be removing this line, since "increase SWDATA size" change is not 
applicable anymore. It is a macro PRUETH_NAV_SW_DATA_SIZE used to define 
the size held for swdata.

>> 
>> Signed-off-by: Roger Quadros <rogerq@kernel.org>
>> Signed-off-by: MD Danish Anwar <danishanwar@ti.com>
>> Signed-off-by: Meghana Malladi <m-malladi@ti.com>
>> ---
>> Changes since v2 (v3-v2):
>> - Fix leaking tx descriptor in emac_tx_complete_packets()
>> - Free rx descriptor if swdata type is not page in emac_rx_packet()
>> - Revert back the size of PRUETH_NAV_SW_DATA_SIZE
>> - Use build time check for prueth_swdata size
>> - re-write prueth_swdata to have enum type as first member in the struct
>> and prueth_data union embedded in the struct
>> 
>> All the above changes have been suggested by Roger Quadros <rogerq@kernel.org>
>> 
>>  drivers/net/ethernet/ti/icssg/icssg_common.c  | 52 +++++++++++++------
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.c  |  3 ++
>>  drivers/net/ethernet/ti/icssg/icssg_prueth.h  | 16 ++++++
>>  .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |  4 +-
>>  4 files changed, 57 insertions(+), 18 deletions(-)
>> 
>> diff --git a/drivers/net/ethernet/ti/icssg/icssg_common.c b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> index acbb79ad8b0c..01eeabe83eff 100644
>> --- a/drivers/net/ethernet/ti/icssg/icssg_common.c
>> +++ b/drivers/net/ethernet/ti/icssg/icssg_common.c
>> @@ -136,12 +136,12 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>  	struct net_device *ndev = emac->ndev;
>>  	struct cppi5_host_desc_t *desc_tx;
>>  	struct netdev_queue *netif_txq;
>> +	struct prueth_swdata *swdata;
>>  	struct prueth_tx_chn *tx_chn;
>>  	unsigned int total_bytes = 0;
>>  	struct sk_buff *skb;
>>  	dma_addr_t desc_dma;
>>  	int res, num_tx = 0;
>> -	void **swdata;
>>  
>>  	tx_chn = &emac->tx_chns[chn];
>>  
>> @@ -163,12 +163,19 @@ int emac_tx_complete_packets(struct prueth_emac *emac, int chn,
>>  		swdata = cppi5_hdesc_get_swdata(desc_tx);
>>  
>>  		/* was this command's TX complete? */
>> -		if (emac->is_sr1 && *(swdata) == emac->cmd_data) {
>> +		if (emac->is_sr1 && (void *)(swdata) == emac->cmd_data) {
> 
> I don't think this conversion is correct.  You still need to say:
> 
> 		if (emac->is_sr1 && swdata->data.something == emac->cmd_data) {
> 
> Where something is probably "page".
> 

Yes you are right. This needs to be changes to:

if (emac->is_sr1 && swdata->data.cmd== emac->cmd_data) {

This issue can be addressed more cleanly with the fix Roger mentioned 
here: 
https://lore.kernel.org/all/3d3d180a-12b7-4bee-8172-700f0dae2439@kernel.org/

> regards,
> dan carpenter
> 
>>  			prueth_xmit_free(tx_chn, desc_tx);
>>  			continue;
>>  		}
>>  
>> -		skb = *(swdata);
>> +		if (swdata->type != PRUETH_SWDATA_SKB) {
>> +			netdev_err(ndev, "tx_complete: invalid swdata type %d\n", swdata->type);
>> +			prueth_xmit_free(tx_chn, desc_tx);
>> +			budget++;
>> +			continue;
>> +		}
> 



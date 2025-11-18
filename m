Return-Path: <bpf+bounces-74928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 528CAC68988
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 10:41:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 530EA4EE36D
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 09:36:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AAAF321421;
	Tue, 18 Nov 2025 09:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j9XJWv5G"
X-Original-To: bpf@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013052.outbound.protection.outlook.com [40.93.196.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46DED3164A0;
	Tue, 18 Nov 2025 09:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763458564; cv=fail; b=cQTLdNtMWDgrHWRVFYo4ZFvANmH0lmduH2WHoyqEASmOdAeMmyERg7sWBC4LJhRFexXkjdwaXL/yr0/KwKG+pEAeaVzydvcoD3u9z6azIvLMVaOpPCGRu4AZCLYR9MIzugkbRyd0PeSF+CEigeg4OlOJi2kN+oIF9yAfq/WdidA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763458564; c=relaxed/simple;
	bh=dDA8OVVUmsQSqxtCq0uAvgP6l3AbZ+7WuaN1BZMF8pU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=I0m/igm+ymPE3henoT06KJYKSyB4mQx4x5ittDIHSzDd2oM5SRLTFK2sroNyWYOUrfZ690VRvfdOqfiZ0xkOW1p00V1VLi7d1QXWpucQiZfcH4+QCJvWQVV0/yGKf7W5alBWHJQzlFKqRdWG9uZKvrb1mgvCeXoOAx2+YHFqdEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j9XJWv5G; arc=fail smtp.client-ip=40.93.196.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e/ATdemcZ70Q5pCcOeH2/1B0c9KTWHrBDlneSRbAJkbBFkjPfuPW/rX21K5zh385BKx98i2IGW8Z456JX98f49djrBZOEJlBao/qDsb8cYDic+3sAQm88YrudyB/OOkNDvmIsA82qy+i3gCxowOP7vWCiihcmsNGDDlb9BXjuZM42ubSIzzFy+/445UnKvy4OWRoThoN91W953RSehTJciEmJGlPRy+fUpdv0fbNuFl5f0WYwCcH9METCVvFy9FePubzGfnQSAy3eS6rRdmWhQDRLxAMw9OW4l9I4q3sRTD34h/Eb8R5b50WwFYdVhUxEdcBOPjsTc7bhJN6k8j6pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUpiTQfvsDZbzIHdNAsrhIrRg5LtS1Nl9EuJff2jzCU=;
 b=FvNlTXqrnDxJq6QlHQSdu0KE1xVIeamTOiW9OcSxgf7HUacMpz2Um4SVrzxxUXnsYok5erAQpW8bNaRbswa9g0fOk0yTLNbek2HeV4GrJ7lZLfMxyGsGLVG79ZfdI58WiNc+VLEeszzG92hfuwOvEcRnWbivx72oZv7n7N7IDuU/r5FDrJZAEXVClWCmQhVURFx4/SLTZQii5u026xI0A7S1X5ZNDwBb35+x21AtHZ077AcdTrtNl42m57iQJY49onWTO3pqf4nAMBeuefzmYynhGpSPnXDvAjdM37tS88ieSdcLZFgbCUIe111FiW/1FbzfHANs+RSZgcTO41UuIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUpiTQfvsDZbzIHdNAsrhIrRg5LtS1Nl9EuJff2jzCU=;
 b=j9XJWv5GBQRYXlg4M6j0vQS+3IiC2rb4e9vRXN/Ab609Muka3tdPtUMSkYAUZ3JILp4u/r2FGXdqsh2kYqC17jg3bRZHpeDP+BvLUKxxn+IqfFHrchGh5aYn3K74AefRNiFc0vIXeloErZcEeWaNya1f71iotiiW0J/0twSz5vxYA27b7GywntWh4HREb7ORXfjEzbxcejP5+/+uc6/jEHgktie4IZedA0I8BinO57RfHZJXQSNJMoPvxA28KLxB9rXHmoAqs55dZbpA9BMDD6NcaVlXS/jbI0UG5+5aBt7KN50vKmcZVxq0XbdXRbb95fl5MTAO89I05sqBwdfeeg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by IA0PR12MB8326.namprd12.prod.outlook.com (2603:10b6:208:40d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 09:35:58 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 09:35:58 +0000
Message-ID: <b646c522-d4ac-4cb3-ba10-9c456a3ab5c5@nvidia.com>
Date: Tue, 18 Nov 2025 11:35:52 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/3] tools: ynl: cli: Display enum values in
 --list-attrs output
To: Donald Hunter <donald.hunter@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, bpf@vger.kernel.org,
 Nimrod Oren <noren@nvidia.com>
References: <20251116192845.1693119-1-gal@nvidia.com>
 <20251116192845.1693119-4-gal@nvidia.com> <m2jyzomypp.fsf@gmail.com>
From: Gal Pressman <gal@nvidia.com>
Content-Language: en-US
In-Reply-To: <m2jyzomypp.fsf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TL2P290CA0022.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:3::6)
 To CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|IA0PR12MB8326:EE_
X-MS-Office365-Filtering-Correlation-Id: 64b0c0cd-c2d3-41e7-ef01-08de2685e0d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bm5Zd3AvNVB4bkN2S29uTmYweWJxL2c1Kzl4UStVSDFicnFsMkxvTlVNWng0?=
 =?utf-8?B?TTJrendqYWF1akxndDh5U2c0K2JPS0w0bnNIV0p3RURMeUdlaFJQY3g0VlQw?=
 =?utf-8?B?MVB1U3N2R1JHUXN2OU9nYkJBOEZ1bXNYYmwzUGRnWFdScmxyY2VNeDVOMUgx?=
 =?utf-8?B?QUpsWDl3TWFia0RUQU9mK2hOckNpaFA0YzM3dk1qcE9Uc0FQMkV5aGZjL2pT?=
 =?utf-8?B?dHEwM1djUUdoRW1BQVREdkpTNERDaFlmMWs0SGVlZVE2dFlxYTRBSVhCMzJL?=
 =?utf-8?B?RW9GK0c3S09BZHJqcXFxU0xTbDlMUzhLTDBzdWtjcHhQNE9EcjRhMUtCaGhr?=
 =?utf-8?B?TGMxNlBNcEp5aHV1M253YVJyS1RJNmUwRmFDR1hVTkZnRXp5WHpPMVUrOFZW?=
 =?utf-8?B?c3hDeS9nN3J4d3FqZ2tITVFVZGVyZmRvcXJTTlRoODcyVWhxdmdHS0NydXVR?=
 =?utf-8?B?YmVkMk9BSmMyRE1tVHkwOTlUY2ZxOFc5UDl1WE1KZURMZWtHMFMvT1h6YUtK?=
 =?utf-8?B?NUszczFCY2psMnMvaVo4NytZazNOaHMvUmMzSC9JK09CbXRrTnF4V0IwdzZE?=
 =?utf-8?B?MVgrYnl5TEg4V3NMbkFOVHhMY3QySjFocTRjbFUxK3MzbFFrdXVXaEpOT1Zh?=
 =?utf-8?B?TVZCVzdzYU0wMVIxa2VDdGYzNmRlYUEyQU9qenJvd2JkYjJodjd0R2ZTTDB3?=
 =?utf-8?B?Zi9OQlhOTXVGbGFCNDhqZGx3STlocXJ4dnpITXhDUEswUVhiTU1kUzR0R05S?=
 =?utf-8?B?WkczWHNiclVwNXVMMlcyQmRwMzFrM3J0Y0d6SDlhcW85T20yeXNPRDZSbnB0?=
 =?utf-8?B?eStLVFBaSzM1TU9zbGE1ZnV5TFZQRHYzM3BKUHV4bkdRU3ZuS3VhLzJVOXpM?=
 =?utf-8?B?Yk5ybVY4S1M1UEw0TGNyd0k2c1pxOC9yemJJN243YWQ5Nks2RWN1bnU0NVkx?=
 =?utf-8?B?USswZGNVMWswbElxalVtanpVVkRjYVNzVXBvU1AydUVJMXBmT2FzcjJmSkpm?=
 =?utf-8?B?Q2lZR3o5b0ZBL1dtU1dCZUtWLzM1R3lyVENNMW1MZDRsbFNDT08xdE9rdmZ5?=
 =?utf-8?B?SnBvR2dWNHBHTXBNUzdMamdqME9mZnd6bDNkMHY2aDdWdUZsQ2Zqd04wRUh4?=
 =?utf-8?B?aTYzV1pPRWE1V0ZCQzM5UnYweEVCeHJVRHQ1U1M2dngySVA4amIrR2xtcUdm?=
 =?utf-8?B?aWllRnN3SDdzcFRSZGVDVzZqRVJHNmVHYWhaRGdla2pwSDRPcW9GS0JkZGM0?=
 =?utf-8?B?Rm5NWGtDMlBpeHFwdHJwTlZydzlXd2VFZ09tSTczWkp4MTJEQlQ4S2JHUkZZ?=
 =?utf-8?B?Z1BESFdJTXNjOEk4YW5SSWYyZ3NGVzc3cjhSRVBscGE4eTFVUVpiWm9HVnVY?=
 =?utf-8?B?ZjgrSVMyRFdnckpZdUFsTHU4SFVIVmx3Uk5zSWJtRE9XbXoxMFhsSllzQi9o?=
 =?utf-8?B?dVA5Y0RockdPelFkekx0NjVNUm9udFpIMzc5Sko4ekovMFRWNkRFNjJwcHhy?=
 =?utf-8?B?eVRKUHFRdndROG1YR21wSnpxaGlCNWh5Mys2aTlJTmhTaUR0WThmSnJLT0sz?=
 =?utf-8?B?ZlRHS09iZDVIWC9xYWdtV1VwcWNlamorKzJxZXU0akdPMGp3WjUzdHpxbHBH?=
 =?utf-8?B?SjE3OFcrVis5QUNMcmFBUDNleXNUVmE0bGhrUjJISExCRzh3enJBUnRNcUxI?=
 =?utf-8?B?M1gwdjJUMVY5NlIvd0FweUYwTDVxR054cnhKbkhnbnhGRE1lT3VuTlJUWGJU?=
 =?utf-8?B?SEdRcExyYjNTNGNqa2REQk1kTXlSakczbHlDNGk2dllDeFF2YWpXRWVwVDJm?=
 =?utf-8?B?WkNaUktLTXdIZHBaWWFXOEhUYmNlZ0xjSDNqMSs0WjZISkwyY1ZSWVpZU3ox?=
 =?utf-8?B?WTZ0ckpjbHZyZ0tYbUNzMTYxcElsdDBNck5aS1JPdGFlRDdIYlNzenBhWGJn?=
 =?utf-8?Q?YzpBgWoMwibHWfmO1D5LCaADG1wdp8IO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YmZSQlZYNW1GaitzejdKYjRRdi9DUTlJVi9lNUFoREFUMlg1NlVGdDVlRHUx?=
 =?utf-8?B?d1J3d1RVK1VRVm04aFQ1eHMzamRSQXVUeG9ycSt2aG9OTHpDbExKM3ZRUGxn?=
 =?utf-8?B?Y01uU2VTS0FZRzBzbmtTcW1mcXpYWmpZb1ZhcGhUV0NUa0hwSjlCaTVzS0Q4?=
 =?utf-8?B?V0lZeFNhVjBwV2MxWFVTT1FtS0tsMkFKMEdqcVprOHFrUS82TCs4OGtrNGZI?=
 =?utf-8?B?ODFEZ1V1QmVYR2ZWNXRUNTU3UjB2aHhnak8zY2MxVm11Vk02UnpzZzVybTB2?=
 =?utf-8?B?N2xxUEtRbTYvbzE5UjZKVHByTnNqZGhsdjVsVFhHeFpac0xqT0c1SEVYS3dQ?=
 =?utf-8?B?OGw2VE5jNDdGZUI5S0I5ZFZwbVUvdjFSQldYeDJTSnQrTkV0NG5tWFlTdG5a?=
 =?utf-8?B?SnVCNUpTaXUrSTV1dmwvM05EdDl6ME8yNTZ0TTRaekNKMm5NMjI5Wjh2NW0y?=
 =?utf-8?B?UXd3OWFkOUNFRUYxNkdxMTJYQ0tLLy93TEYyQ2pSK2dKU0N0QW43Zy84Z1Q2?=
 =?utf-8?B?WXF0TFVEVUs0d1FnMXp6bkhKRm1iaXVmUGpnZlhDNHFBcHl2RFJBbVBMNFNx?=
 =?utf-8?B?Z09QRE0vTXVOc0w0cnZBeW5lNC94cm5GWDRmMkRjZ2RLN01EZ21lY0hrdkxV?=
 =?utf-8?B?c3dTTFY5K1p5NWJsUXZBOEVmMHdhWlBIbnJrV0hrTGhlZ0xNdWFZMFVnc1pO?=
 =?utf-8?B?b2xKL0dET3N5ZWlRWUVrTVgzLzhlc0xpeDJBOHcvZ0Y0M2RjR3FSVG8reEV0?=
 =?utf-8?B?V1dlcUJNTkEvMTFOczQ2VEpNMjdzQUw5V3FQdzNBZDE4OVB5MFYwRkRhUy9V?=
 =?utf-8?B?bTVGU0VlRmdjN0xUZmtEOWs0VWxBc09tUzI1TWZZREs5VytqRjdxTEhZaDZZ?=
 =?utf-8?B?aE85WElWZ1ZnUEU2Z2lCOURYY0hHREtabzZvZCtETTVNZm5waldHdjhLS3hC?=
 =?utf-8?B?RkZnNjNENlN4djY2RHRKMUQ2SjlYSG1QMVhuUXlJTzhhNk11RERyT1k3TzhE?=
 =?utf-8?B?K280V1dKME94bnhQR1Y3RWx0T0xadU0wbU9aVkVZMFQzRXJVYXNtc1llVkVG?=
 =?utf-8?B?RkhHQmpBTjUyRnJ4SUNXbWcxZzNNanUyLzNzeEhGNkFoaVBOUEE3Vm1RMHU5?=
 =?utf-8?B?RWorZUNpUkRRcGFqVG9WUEczWk5OYmxRV1M5LzBKd2VudnlsSi9jODlNN29J?=
 =?utf-8?B?Y2t0a3NlZXRtUVhDQkdmSGxiTkgyY2lLcFh5NzhKTC9NTnlJZE5WM0xmU3l5?=
 =?utf-8?B?NW5FcGZoZnFnc25FdjR5a25Pakx6Z0NSMURGYnZEa3pkSmROUm4raWg2cWFW?=
 =?utf-8?B?bFc2U25UWGRiSUx6RGY3ZUgyQjI4Zm9CRnNrc1F2UW5IcTJGZ29hREhldUkw?=
 =?utf-8?B?NGdjYXBGaDg5dWVMRy80ZUlwK2JIRVpEa0JvSDZINjdQWGhROWEvc2tVaVpH?=
 =?utf-8?B?VDFkZHFCcFV1QUY4dHMwQmt4MkNyc1JxUy9vQVNscTZYSnRxSWhsRWNDZkVR?=
 =?utf-8?B?S2o4emRtVys1Y1lsY3g2amVTYkM4aCs3TjFVTEFLdUc5am9sYTBid2NLUWIz?=
 =?utf-8?B?bmd5U09waXBJNFhxenlkMFQ5UysvVjFyTVNGM2tqeW5DSXBDVnBjVVRZeU9J?=
 =?utf-8?B?bUlQejk1d3Y1bk9xVkJvVm5pZmN4cGZUWE5tR0ZhQ3FZNXNvMzNyT2pVajZH?=
 =?utf-8?B?cSs5YzVWSUZpaWVWRUU1VTJzMDF1a0dCWlllVmZnY0VPQ1hrVk1JdkhEWFhB?=
 =?utf-8?B?L083dG05TDRsNWlLOXArR1Q2TEsvUW5ranNsbm9MSEhQeHNQRGo4Qk9JYjVC?=
 =?utf-8?B?NU8rN3JyYmJqMytyeXhjM2taMVUzRVNoRFNqQ2Y1SjhrZlh1c2ZxbzN4OWJa?=
 =?utf-8?B?aTNHSTFGRS9RN1ZjNDhTVmNNSmNMN0dzdkVObGRuNEJNQ2tlTHpIZDVBbjRz?=
 =?utf-8?B?SmdBYmo3SDI1dnRMUm1jYVFLZ2FpUHFrWC9PMUh4M1IxWUdYcExiNU5XSWpC?=
 =?utf-8?B?VkI2eE1SeUl2VHZoTE1tU0hFSmhoT1lBWlNXUkwxaTRIN2UzMDgwMWhqVEY2?=
 =?utf-8?B?cy9FV3ZnWGtITWFNSkFrZGJvdmhXQ3dzV21MalNrZURTWWVPajlzaXJGT3Jq?=
 =?utf-8?Q?fKhdk3BWEX1rYvA+j723PRy+x?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 64b0c0cd-c2d3-41e7-ef01-08de2685e0d8
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 09:35:58.1075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A9fUQHBH2sKW6xJ21s9zhImCQz9V6uKEkqgQUj3kW97CJsVded+F84z6ZxMPV/Oc
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8326

On 17/11/2025 18:05, Donald Hunter wrote:
>> diff --git a/tools/net/ynl/pyynl/cli.py b/tools/net/ynl/pyynl/cli.py
>> index 3389e552ec4e..d305add514cd 100755
>> --- a/tools/net/ynl/pyynl/cli.py
>> +++ b/tools/net/ynl/pyynl/cli.py
>> @@ -139,7 +139,12 @@ def main():
>>                  attr = attr_set.attrs[attr_name]
>>                  attr_info = f'{prefix}- {attr_name}: {attr.type}'
>>                  if 'enum' in attr.yaml:
>> -                    attr_info += f" (enum: {attr.yaml['enum']})"
>> +                    enum_name = attr.yaml['enum']
>> +                    attr_info += f" (enum: {enum_name})"
> 
> Would be good to say enum | flags so that people know what semantics are valid.

I changed "Values: " to "enum:"/"flags:".

> 
>> +                    # Print enum values if available
>> +                    if enum_name in ynl.consts:
>> +                        enum_values = list(ynl.consts[enum_name].entries.keys())
>> +                        attr_info += f"\n{prefix}  Values: {', '.join(enum_values)}"
> 
> This produces quite noisy output for e.g.
> 
> ./tools/net/ynl/pyynl/cli.py --family ethtool --list-attrs rss-get
> 
> Not sure what to suggest to improve readability but maybe it doesn't
> need 'Values:' or commas, or perhaps only output each enum once?

Values was replaced, I don't see how removing the commas improves the
situation.


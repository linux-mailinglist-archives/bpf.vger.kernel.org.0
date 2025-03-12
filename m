Return-Path: <bpf+bounces-53901-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CA75A5E121
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:53:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 219DC3B5619
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 15:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0343E1D6DBB;
	Wed, 12 Mar 2025 15:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IRaFzG0H"
X-Original-To: bpf@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2057.outbound.protection.outlook.com [40.107.21.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 938DE248861;
	Wed, 12 Mar 2025 15:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741794776; cv=fail; b=bmMZdJuqWDB2LKdnYcXvCoA87ZGn1LcX4+TfQj8Nodds288GczJIBBc3lkGhifSw55fEGQ8oehBDow+z8cPpQy0FR8e6pUGtkYbfvxjJtch9NB9YeUkefU0iQWpJuT2GOmsR0sxb7xSVhlkoqipfREawHIFlVfNtsFS26WntCnY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741794776; c=relaxed/simple;
	bh=qpDD5HIHeLSyhFr38FaWKG2OgoE4WlX2BG7a/pKM2Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=S2RIjiN5j2XidKro12JUeAt7BBQpqy5KgUdV/gaZSJXCbbb8Q4nkMfuj3/74RLQI2m8C/ZABaWz6LsuD5d9UxQ6Uw6g5h0JyZc0/UP6NjLMNUwvKvYZ7ZwnvaVeaALnaoyeiaOOGXTdF0zcmeT1gaoNIxAQXgpRSQcEIQPvsydk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IRaFzG0H; arc=fail smtp.client-ip=40.107.21.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H+C6Tpd4Lp2GoKwh0+JYRQJjf3GzEPX6VFS5vDtSDyvraV4iwmK7qzDYouvU20tgME0ouAumMHw7CACES42qR5UUG7fkF5lpXxn/QlQb4AiHO0jRT4y3nPhYprtdu6YELIiz0vFgohpTD5mVK9O6tuD/qmI2UIhf+/vrADnxxIRNdiqI36AQ8Eu8t6/vVNkqRhrSfgMB3FfUFvnXGHjSNHOw6IuQ1ZGRoZgGkUpIYfsibB9D/lPphZS1RVf99SGcBk/DS6fZvmej/9TUKv/zvtU9vGDVrxrV0dhFxEkK81rUNSSwy90wk5U484Bvd9aOtaMsE5GYH++eQx4yY+osrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ov5t6cJSulQvtamNGQtd1mFFPhPtGp8Re9lUEpd8Ans=;
 b=aclsHTuashUrfU0Ze29H+gYRrcBZsSKhXOY1E5c6AMojNJD4hUYIKhdYsTOfolSpVEj3q/9Mg4ywiM1sXztl475ECanSgfbmnXAAjHCf4C0A9nEW/b9mQkv0IoEWlmrnb+lCRJNlbAO3zz55IeaBMTpPhvk8PbEtOB5F7HQr3Th5hugaSibHu1auTJTCJIXSGdqJvhkqP7iHOgXTS4zVtt9FZY3xm0UYfETSk9BWt8uXx8/AoAGEIvQc06yTR0wkuGLxeSU3uDawkuO5TL56jGMnXeGzVFH8mkvWRUrR9g3lulUSfsMG+9CDKIpSBRoBBee1Ia2PX4MYd9ia3tgtLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ov5t6cJSulQvtamNGQtd1mFFPhPtGp8Re9lUEpd8Ans=;
 b=IRaFzG0HaB+Wa2Dd1aweVOje8a5oNSDZRtLJWfn8fISdeCY1bCF+zCUP+EVMBiMnkRFj2x7Ub0IxNxD3a4+oaa/YShwHXOkFmH8Wn+vq3A+ltQpD3Io0XmfYIbZW2RifmgScBNK5yQaRxkMA9IQkUnNj/5K5LM38l7mECqq3ffpxIqzpaKHyQcZ3EvVq6Q0A5jOpOpB5sjr98LJg3QEFaYUiGhicGEaw6K8oflKyGVMA+zgF4hSH+8aoUFQznpzfHiyqUhX82Mjp/mOtkWQ685FiuS18DZAcTVleUaCubT2dTRLCIh/o95V947HP+L1zXfqxUTajgAIk6TemExeanw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AM8PR04MB7457.eurprd04.prod.outlook.com (2603:10a6:20b:1d9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 15:52:49 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%6]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 15:52:49 +0000
Date: Wed, 12 Mar 2025 17:52:45 +0200
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Furong Xu <0x1207@gmail.com>,
	Russell King <rmk+kernel@armlinux.org.uk>,
	Serge Semin <fancer.lancer@gmail.com>,
	Xiaolei Wang <xiaolei.wang@windriver.com>,
	Suraj Jaiswal <quic_jsuraj@quicinc.com>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Gal Pressman <gal@nvidia.com>,
	Jesper Nilsson <jesper.nilsson@axis.com>,
	Choong Yong Liang <yong.liang.choong@linux.intel.com>,
	Chwee-Lin Choong <chwee.lin.choong@intel.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org
Subject: Re: [PATCH iwl-next v9 10/14] igc: add support for frame preemption
 verification
Message-ID: <20250312155245.fdntan3nml424ufe@skbuf>
References: <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-1-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-11-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-11-faizal.abdul.rahim@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250309104648.3895551-11-faizal.abdul.rahim@linux.intel.com>
 <20250309104648.3895551-11-faizal.abdul.rahim@linux.intel.com>
X-ClientProxiedBy: VI1PR02CA0049.eurprd02.prod.outlook.com
 (2603:10a6:802:14::20) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AM8PR04MB7457:EE_
X-MS-Office365-Filtering-Correlation-Id: fef8725d-811c-4255-50b2-08dd617df0cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RWlMdWRIR2tmNW9qUmMxRVM3c1hOTDJVUEY3bWgzWTNWdXEzNXIyRGYvQ2ly?=
 =?utf-8?B?YW1IRElTaHFVekpkbWdjYlVRdkxPV2FMVmlwMUdjdzREUkNDVm96TzQ5ZkZB?=
 =?utf-8?B?elVFWEVTOEpoY1FIVVRUTzgvT2drQS9tUWdLeWlhT3gvRzA4S0lrdllSQkJ6?=
 =?utf-8?B?MmJ6MVc3bG5qb3lCYndvelhmM28wT1hQWHMyT051Z3lUdnlteDc0UnBpY202?=
 =?utf-8?B?bDBCRGl0NEtDdi9CS3VWWm1RRzJmMWw0S1BLbVE5K001RFhUNFEzdXFLQmdh?=
 =?utf-8?B?QVFOY0tWQXU2MzhrOUl3WVQrNUpOOFh0Z3lVTmJZcDFMbSt6U3ZpL25mZ3BC?=
 =?utf-8?B?eVZsSTk4L3d5QW82OVpEMWRQQ2xRRkw0TDBNVWRDUHgrZmxNZ2g1VzlBdVZy?=
 =?utf-8?B?dHVOYzNYc0dCSkJxMkp6NmYzTmxySXg5VXEzTlhCZytmRTFSc05vMDFHZ1Ir?=
 =?utf-8?B?ZmR2bWxqa0sxSG84WUtuUTVGS01iTzQzcFZBdWpOYTBqTjBSRi96bnE2cTJF?=
 =?utf-8?B?enl0YTBOVVA3V2srNlpvWm0vSTJSSEttZFRpcmxmRlY2RWd1MG5SNEVTUXlS?=
 =?utf-8?B?WlplME9yTlhoS2YzeWsvaFhyK0VhaC95Nmc0Z2dEVmhCbE1SMUJCbFZWdlhz?=
 =?utf-8?B?N3lOZHlJOFBQbmZ2VkVFdU9pMzJjYkZIZHVyWTl2RUR5eDdHaWtTVXdnMUJ0?=
 =?utf-8?B?LzZIRis0RlNON3crcG1LcjNNSGJxNGdKMkdBV24vWjJmNXlOT3k1a1JCcm8x?=
 =?utf-8?B?SHV6L2llZzQrVUZaY29uVTRqZUdGcWFEdW5uSS9ZMWtOUG5TYyt1ZmVtRzgv?=
 =?utf-8?B?UGhrV2s4SnU1M09qUzdMd1hZUUZWaHl0M2lzeEd2VElmNHVHSVYrT04yZGpu?=
 =?utf-8?B?aldnSGgxYWwyeXMyaURDdElvMWtUK1UrNGhZQzRMK0gyRE04Sjh4dTVqZUFi?=
 =?utf-8?B?dUF3OVMwbDROMnc5YUxoV1BIR003cjJNNFFlcENsaFZPK28xV2VaRzZRZmMy?=
 =?utf-8?B?VGNoTE9IMTNsdmlZeVZYWDlpYWt6L3hibVA1U2YyeHVBb0VvWC9HR3dhSjZE?=
 =?utf-8?B?NitlM2t5a0NOeHQxMXNUMlVmdXZtN2tBRFkxbzZiWnNpOVJDdUR5UE1RMURN?=
 =?utf-8?B?NjVBUnVhZ084YldzUTNoQnFzUkx1MmdoN0VyQVJCY2ZrSkd0MDN6eTdIcEI3?=
 =?utf-8?B?RmFsVm80aS9JcEd5YitaeHduRnpKcE00NnVQVnNURENGb3puU05kK2VkeVBB?=
 =?utf-8?B?Y1loYVk5cHRocTFZa1BsMk9lU3dtMDFIK1VXMkJwZkIzd2l1OW1XNkk3RFNR?=
 =?utf-8?B?ZHNON2ZubUdaMGlMNmN2QTE3eEVVWktEY2pRYmdua1JXbFNPR0hKL1JaUlIr?=
 =?utf-8?B?NzRZM2hoUlhyYU4ycWRYYWlMdmVXeUVmNTFhK1dVbTNmQkFTVHRCa0V2QkVW?=
 =?utf-8?B?VGJOeVUxUUJzcHdyQ1lWbmprL2lHSVJMQUpya2xTMXIwcnJKSVBpSmRlQU03?=
 =?utf-8?B?Umt5eG5KNE5PYXhQYVF6V0RDcktneHk5YUNuSDF4QU4zRVRPVGpzSGdmcVJX?=
 =?utf-8?B?NmR3dTlINm1tdmZEQ2YwaS9aWTZ6cUJHM1NtRjVDWmhDRldkcitYR3lseGNO?=
 =?utf-8?B?ZWl6YzJDMjFlUkRnK1ZJRUpaYm5Hd2FpeXpmMW9wNkFSQTJTU0xVZFFLN3pW?=
 =?utf-8?B?ODdQekQ2bXltVGtzKzhTWkVyVmt1a1R2NDh1Wmt1d1RUUUd3VWt4YXpPcytM?=
 =?utf-8?B?d2ZIelJVSEp0Zkt0Y2VUNjg1bzhVcGZNSXJ3NzRwc1Q5Zjg5YXQ4TnZ5dzRv?=
 =?utf-8?B?RnlnaFFMMHNsLzJVVGZhOTNwNmpaay9SYnJoWGhSSVdPMWM5M0Z0NzJhSDVU?=
 =?utf-8?Q?KcUfdGtYjmFWM?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZkZZT3oyYXNJWXlxNGVlNDJtcDNGZlJMRzJVemE5WWh0YVlVRi9NbllrTSsv?=
 =?utf-8?B?d1VtRTVEeC9jVVVHNWNXZm1CL1F5Z1lNR3V0ZStxTmNjTlZaUzNrZnZLRzVY?=
 =?utf-8?B?Q0FOVnlMSkMwUmNja2luWHk0U1Y3dG14cEYwV0NjY05PMFZwMzZWS291MnhI?=
 =?utf-8?B?ejhJa05QcFZ1OEVvWitDdThRb05LQ0JxMCtDSmRaQlhaM3p4Mm5VcDNmYlM3?=
 =?utf-8?B?NGM3TGhDRXNPa04yNzVuNnpLdzVZWXNoKzl0T3RVaW9KTGwvY2JiZWFJZGlE?=
 =?utf-8?B?YlJJeHhmajJONE43VUxBSWsyT214SjVWdW9Ea1ZoOFVuUmNGWFdGSVVIWXN6?=
 =?utf-8?B?dEkxd28zOTBmd2dlSmY3Qm9JdjRZcThrelVXUmtwaktYMmdpdGF6NW9HTW9X?=
 =?utf-8?B?UDFGMmI0am5jcThWbVgyL1ZjK2RqK1BrUkZxQklteFJHUTBET2pKaHJidHBH?=
 =?utf-8?B?dDduZjZpNUtkUDdXd2wzMndiT1hZNlJBVkx0RFpOZ1FWeHlwWlBvTGswSUlE?=
 =?utf-8?B?ZjlGdGk4a0NZTExkQXI2SjdmczRZQ0RKUkJvS2lLRnQxTlZWN3NudzVIdUE2?=
 =?utf-8?B?V3VOQUZIWHhDa2NRSUFXbHlZOUJuY3VCNGVGMEFpd2pOZ0hxTmZmZkNqdjZ0?=
 =?utf-8?B?M2dCRnVwM05yeFZTc1lZTDJOUXd6R040d1FMMjVuSHVuRW1nekNqcVJ6VENl?=
 =?utf-8?B?ZWhqbjVmRmY5YVorRUVWanZ4amxac0JpUmt0VnNndGdCUExXN0s0SW9LMjFn?=
 =?utf-8?B?NW81UlFUVVg1ZDZvazA4OTd1M1Aya1ZzTWpQUWJtUVNzNjAyVHE4ckQzcENY?=
 =?utf-8?B?UFZoMDRUN0dmS1hvNFFxSEhjZVUzQ1N0dnVoV0htZ0FrR095cmtGdnJLRGVq?=
 =?utf-8?B?NjkyUHVnZG5mbm15R3loMnVmQlcwWGYvODNVNGNGRVRNMTJLaVpkcHpWMEgw?=
 =?utf-8?B?WXFHUStaRS9QWHU3b1hQcUlYbkphbWZtMjhWeUQwK25Sa21KL3VGb3ZWUEVL?=
 =?utf-8?B?eG90VjltVnRHcGh5cU1yekJEVUdRbkh0QlV1cC8xV0lIa2xsVURQMFpvUlJp?=
 =?utf-8?B?azVZUXluSGIxVTlCVVA5bGU5NkNGRXplT1UzcyszU2pTNmkwaEI3RzlROGZN?=
 =?utf-8?B?N1JyQm5hUUYzR29kRUk0ZUxwMjBWY3BKNENvbXc3K3Z6Sm1qWnpGQWlDV2VR?=
 =?utf-8?B?WnZUb0NIVW5TNlBORC9Eam9DQjYyRDVZczRqM01NU2x5N1JCbHV5UVRNbjBL?=
 =?utf-8?B?THAxVm1CdWp1b1d5K0kwZkRlMmpqZXJpSktZNVZobUs0cEpnZndQbFh5Z0pH?=
 =?utf-8?B?VStPWGpGRnBiZDI1YitpS1BPeE5oY1dkeG5zQVNFSEcxd2orU0h6ZzRuV1ZU?=
 =?utf-8?B?RFYrTkZjSDdieFZNQ0p1Q2E2WU9QUXRjOTNMb3FZZ2IvWkhzcDBCTHoxRzVp?=
 =?utf-8?B?VXZPUFZzNDJBMUZjdG9INFFhakFST3BRbmRRQ3NRN1JTWEczRldBWjZwSEp5?=
 =?utf-8?B?NEFlYWJNNWVOTUZmVTh4SlREUHVJWGQ3MmNZZG1jcmRJd3JOdno0OFA2eDQy?=
 =?utf-8?B?M0pJSDI1UGRxeXhCMmtwYUZOS09GTW5OcGkyOGc4YktST1Q3eG9hYUN6bnNL?=
 =?utf-8?B?a0JlY1ZPQWd1OGh0OGxHYmxKRFVRc2QxanpQVk5vK3JqUEtHZnU2UzhwRUls?=
 =?utf-8?B?WkNhV3lGY2NocVhsWDB4UXhxcEJkVktuVDE1UGw3dHBQZzU2U1loVlNueW5j?=
 =?utf-8?B?Qkp3K0cveGx3RGxOTU1mUjNPSDROdmlaRGg1NjBmNVhETTRjbDFUY3FwUVo2?=
 =?utf-8?B?MDNnR21MdzhZZTE4T3RvQ1RTWmVEZ3VsY1hzR3kzT3pzdmVYMENDd2tjQVVw?=
 =?utf-8?B?VysxRjhYY2l2SU1ESmlCOG1YbW9kQzVzaFIwTW1IMWtYTDY5Zm5IdFlNcmcz?=
 =?utf-8?B?UXovK3hEUVRGYk5Tblp3SDMrU1U1aEdpMlphZlFmZ1ZuQWZoSWlkc0lWdW1y?=
 =?utf-8?B?K3ZsRVBndUNVMFdUbUNLS3NLL0lZaEV1cXlRU1lvYllkaGVFZ0trQUx4emNy?=
 =?utf-8?B?U0VLZEY4ak9TRHIxTnpaNUZMV0t5OEdrWXhNT0ZCbnAvVW95MURTeFJBMmFi?=
 =?utf-8?B?cDVTYWprcEZXSndENnpwWDh4QUY1dHZISGw1NnZRM1JGWHU4cFVTMjM3SEg1?=
 =?utf-8?B?Y2c9PQ==?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fef8725d-811c-4255-50b2-08dd617df0cd
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 15:52:49.7789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zwFMJ6U2CT1l8sbcl5UEo1QNLpigaKz+vNYyCbgO3SLOdbJOIwkaDHxKcGmWCngYCJOTLCnAEF0LN1dcwdGqtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7457

On Sun, Mar 09, 2025 at 06:46:44AM -0400, Faizal Rahim wrote:
> This patch implements the "ethtool --set-mm" callback to trigger the
> frame preemption verification handshake.
> 
> Uses the MAC Merge Software Verification (mmsv) mechanism in ethtool
> to perform the verification handshake for igc.
> The structure fpe.mmsv is set by mmsv in ethtool and should remain
> read-only for the driver.
> 
> Other mmsv callbacks:
> a) configure_tx() -> not used yet at this point
>    - igc lacks registers to configure FPE in the transmit direction, so
>      this API is not utilized for now. When igc supports preemptible queue,
>      driver will use this API to manage its configuration.
> 
> b) configure_pmac() -> not used
>    - this callback dynamically controls pmac_enabled at runtime. For
>      example, mmsv calls configure_pmac() and disables pmac_enabled when
>      the link partner goes down, even if the user previously enabled it.
>      The intention is to save power but it is not feasible in igc
>      because it causes an endless adapter reset loop:
> 
>    1) Board A and Board B complete the verification handshake. Tx mode
>       register for both boards are in TSN mode.
>    2) Board B link goes down.
> 
>    On Board A:
>    3) mmsv calls configure_pmac() with pmac_enabled = false.
>    4) configure_pmac() in igc updates a new field based on pmac_enabled.
>       Driver uses this field in igc_tsn_new_flags() to indicate that the
>       user enabled/disabled FPE.
>    5) configure_pmac() in igc calls igc_tsn_offload_apply() to check
>       whether an adapter reset is needed. Calls existing logic in
>       igc_tsn_will_tx_mode_change() and igc_tsn_new_flags().
>    6) Since pmac_enabled is now disabled and no other TSN feature is
>       active, igc_tsn_will_tx_mode_change() evaluates to true because Tx
>       mode will switch from TSN to Legacy.
>    7) Driver resets the adapter.
>    8) Registers are set, and Tx mode switches to Legacy.
>    9) When link partner is up, steps 3–8 repeat, but this time with
>       pmac_enabled = true, reactivating TSN.
>       igc_tsn_will_tx_mode_change() evaluates to true again, since Tx
>       mode will switch from Legacy to TSN.
>   10) Driver resets the adapter.
>   11) Adapter reset completes, registers are set, and Tx mode switches to
>       TSN.
> 
>   On Board B:
>   12) Adapter reset on Board A at step 10 causes it to detect its link
>       partner as down.
>   13) Repeats steps 3–8.
>   14) Once reset adapter on Board A is completed at step 11, it detects
>       its link partner as up.
>   15) Repeats steps 9–11.
> 
>    - this cycle repeats indefinitely. To avoid this issue, igc only uses
>      mmsv.pmac_enabled to track whether FPE is enabled or disabled.
> 
> Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
> Co-developed-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Signed-off-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> Co-developed-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> Signed-off-by: Chwee-Lin Choong <chwee.lin.choong@intel.com>
> Signed-off-by: Faizal Rahim <faizal.abdul.rahim@linux.intel.com>
> ---

Reviewed-by: Vladimir Oltean <vladimir.oltean@nxp.com>


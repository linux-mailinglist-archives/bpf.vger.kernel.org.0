Return-Path: <bpf+bounces-37882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3324D95BCEA
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 19:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2A991F23A2B
	for <lists+bpf@lfdr.de>; Thu, 22 Aug 2024 17:18:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9235C1CEAA5;
	Thu, 22 Aug 2024 17:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="tT+Rcf8I"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DC81B948;
	Thu, 22 Aug 2024 17:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724347081; cv=fail; b=RJXX8Ca1JIkkxQ3OesoEzfqNO2LDarjLFXxf0WzClLo5FS99vLr7VB4GQwrbmD13qSCtcL/KlFwppFAjw4V0ZrCh8C6YQj0ivmOPW+cGbg1I5kZovE6petkFoFxT38uGzhmsWwsWLJqjn7h/OQYssCAXHiIYs9fe0VQ5qEsqIP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724347081; c=relaxed/simple;
	bh=IRaZpFGAmFeGVfMPa0CXEdakThW97XX84hrXIHqK+80=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uWZ4ChWUBTzPi2tZud8gSH9Y0GXqOWsdWMfFjrEC/uB+DcxWRiOwATELiAtvOUji3ubfdFLRm9by7Qtg8O+3uZNiCl7JrLnrhUSfedpy/gt8pJCTPf7m351grs2lDLg/W2hXf31QMX8HbGTEZi1rzRXETXRhDJPK9Drv1IDkQwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=tT+Rcf8I; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47MGecD5019744;
	Thu, 22 Aug 2024 10:17:09 -0700
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 41692cr7a0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 10:17:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q4tU9+VdgZPQPFpZAI/yAR1AlE3g5Z7QRNtgeO13xL0AE9C27lu0cutera4X9jzwcZceuuU8QHNbYYAF0yQuq0SrgJeWlpqpyleaZBEIHpcd/ZT3yLJlfY/VKdmUsFXQW/Puiq1mIj/jh9+kumBfh0H6T0yZAbmNC7zA1XCeSBNS6RXV9w6FmjCSEBBpCH1YNs3sezs6FyUtpvgmyveVSsl76uMGMW2tbQcM8tcr9277eKTrLzVkkJL06NXCBLcW0pPHYO/tyfEmbIcI9d2jy9i9daCchHOHNS1snO6Gy38XsYmEpr6y5QjDj1hKbLIQY5IAzY9BcF5jF/FSjzd6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LJSl2yjti3iAfJluY85e12KGCfUVn3UgCTsA79D+UsE=;
 b=ONNj7Q+1rFrUyJVuhD+yyfDnHjtNDCrDGEJ/Ims4pmLeAP0OXSG9tFNSlj/FfT3khF5r97wLt9vhUGTT1I4F2mhbcaYdw3kuUztO8tmmpf4rDnbcUkpMQ+r94bwsJ/C9RKsG99ypeGs7bwRxDegeksyZsPQvkkCQqMCSaQFoploacljmo4SAXhQr+cM5VwzQMCrthB99KNs9P//ekWY8bDsmZnr+MX1A0Rfga1iWcA0/RkI0IXrZH/8D+a4bmVRN1/eHsmGQ8xnFjwV8AFa8VkRS9wl47baD06ANGKgTv/2Y/bPLyEH/NwrUxbfdcN/Q5tyV+v3SXTTv4PdXQsqKoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LJSl2yjti3iAfJluY85e12KGCfUVn3UgCTsA79D+UsE=;
 b=tT+Rcf8IarQN57gKjLGcBhUmjslRLwRXAlBaY0ai8WkOuF8wXR+6xGNH6v54V/ivSGW+7r5ug1UR4iJmIYk2UuLIgBBhei9T6uHQdwUeHzfS3a/Fis6UAWGsn0apC9q5JdfItR+NuGa79JjU7DWe2OYkUGMBRHcFhdDu2qyN31I=
Received: from MW4PR18MB5084.namprd18.prod.outlook.com (2603:10b6:303:1a7::8)
 by CH4PR18MB6165.namprd18.prod.outlook.com (2603:10b6:610:22e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Thu, 22 Aug
 2024 17:17:04 +0000
Received: from MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905]) by MW4PR18MB5084.namprd18.prod.outlook.com
 ([fe80::1fe2:3c84:eebf:a905%6]) with mapi id 15.20.7875.019; Thu, 22 Aug 2024
 17:17:04 +0000
Message-ID: <0de48667-fe8e-4cd8-a84a-e3e5407c7263@marvell.com>
Date: Thu, 22 Aug 2024 22:46:59 +0530
User-Agent: Mozilla Thunderbird
Subject: [net-next v4 2/5] net: stmmac: Add basic dw25gmac support to stmmac
 core
To: jitendra.vegiraju@broadcom.com, netdev@vger.kernel.org
Cc: alexandre.torgue@foss.st.com, joabreu@synopsys.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        mcoquelin.stm32@gmail.com, bcm-kernel-feedback-list@broadcom.com,
        richardcochran@gmail.com, ast@kernel.org, daniel@iogearbox.net,
        hawk@kernel.org, john.fastabend@gmail.com, fancer.lancer@gmail.com,
        rmk+kernel@armlinux.org.uk, ahalaney@redhat.com,
        xiaolei.wang@windriver.com, rohan.g.thomas@intel.com,
        Jianheng.Zhang@synopsys.com, leong.ching.swee@intel.com,
        linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, bpf@vger.kernel.org,
        andrew@lunn.ch, linux@armlinux.org.uk, horms@kernel.org,
        florian.fainelli@broadcom.com
References: <20240814221818.2612484-1-jitendra.vegiraju@broadcom.com>
 <20240814221818.2612484-3-jitendra.vegiraju@broadcom.com>
Content-Language: en-US
From: Amit Singh Tomar <amitsinght@marvell.com>
In-Reply-To: <20240814221818.2612484-3-jitendra.vegiraju@broadcom.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0070.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:99::22) To MW4PR18MB5084.namprd18.prod.outlook.com
 (2603:10b6:303:1a7::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR18MB5084:EE_|CH4PR18MB6165:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd76579-517b-4ebf-eb84-08dcc2ce3e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THZKRVlwTzlQQit5SkFnK0NvOXpsOXNCL1VVUmNOMU82YVFBUWFzRDEzVUFs?=
 =?utf-8?B?eEY4RHYzTUZyQ01JZEN2RzRXS3pBbVFQMytNL1cyUG52MXlvbGY2RTJxaFJG?=
 =?utf-8?B?TDV3RytlK0VlK25iOGI4RmwwamZCQjRNN2hNcStEQWY2ZUVvSHViQ2FlSDNC?=
 =?utf-8?B?WTkrY3Nqa2NaR0ZuUGQ5cHFwZVdaSGtrTnQwQ1hzUmVnV0t0ZnRLaDBRamx0?=
 =?utf-8?B?L2RxcmYwRDkyenRhbmpxTzRvRnJvYXE2b2VVNzV4R0FiaHBXdFF2c21nOHp4?=
 =?utf-8?B?aG9CbUxwN2VwUXpBaUt1QncyeG1SVENjOTJhZzhIazhnVUhmaEgrNUoySGt6?=
 =?utf-8?B?bmV6bnZxRWs1Z3pYT0lyT2JmeTVCTUF0NEo4THpBS2NYbE92ODJ5N1ViZ3pL?=
 =?utf-8?B?b01xVUI2YVFNY09xM2V5eTFPanlxN0pYM1l2WHVzVkJpbVFCcmQydWVsY0d6?=
 =?utf-8?B?VVpoOHhlaXYxeDU0eStFUXJWUXBTaUF4YVUyVEpzejlGTXl0RWVjaG1mbWxV?=
 =?utf-8?B?T1ByNllMS1B5TUpVZGluMUk5cSs3b0RGNXAwZmV5U1ludnZxQ1hxaWo5cGkw?=
 =?utf-8?B?RjVUSHNOc0FYWEltVGhJb0xibXhwL1VuY0NjTDNxMkYyeGlIT2prSisyRFNW?=
 =?utf-8?B?WlQrZ0RmK0FJcDAybUNla3hrUnJVQUlQZ0dFYjl2UU5oK3BSem1uQVdCdmQr?=
 =?utf-8?B?Nm1EMmJjRlZIK1llMDN6Q3hQNlByQ1RIa2xwRFNmeGl4dXBGZFkwYkN5eDR0?=
 =?utf-8?B?cEdVc0U1Ym9nekVwbHpSdExIWnlPTksvS2hrSGg2QzFJbW9hTGcrMDlDbTRJ?=
 =?utf-8?B?Und5UFZ5RVk4N01MU3JOQmtxWXk1RFNPWDFyTUNPdXJWM0hyWW4ra2NOTzRX?=
 =?utf-8?B?MGNsUTIxY3ZndlV1Y291RVpKc2hVY2JCL2ovaHV3bFhUS1poS1NXWG92Zmhk?=
 =?utf-8?B?T1VaczRSNzBZeXJtV0lzcHJjNXc2d3U0ZVEwZ1VtU1BKRklnL2VUbXVoenJU?=
 =?utf-8?B?VGgzeG9SZ0VlelFxLzRhbUpNMEFUYktjZWoxQ0puVFIzV0NQOW9UekFMSW1P?=
 =?utf-8?B?UzZFcVBNQ1dhSXhGVm0rRXhyUVA3bUtGNmVPa1JVQ0Yyb0ZGdFNHNFErVmFJ?=
 =?utf-8?B?LzVzOGduSjNlN3ZLQ2l1cEpMYzVzNTIyQk42Q2RaWmwvQ3B1STdYUW1La2VE?=
 =?utf-8?B?QWRBR2lOckhFUDRnZHBtQlN5bG9USnNhZ3ZNTVRyYllaRkhpSGZXVWRDWkE3?=
 =?utf-8?B?R1BRdVNlOWUxcFlWUlEzMjhuNWl6b1VHZ2kxNG9kYXBocDJvVUN5UzFHZXJx?=
 =?utf-8?B?bThkZFJZdW9XVDcxYSt3UlVGZ2hmcjJJRHNSMjV4Z3RXWDY0VDIwR3YySVpU?=
 =?utf-8?B?Q2hiTi9uZCtmdHlCT1paL0Q2dFlrck8rcWlna21TQ1hCNm5LVXlZM1haQk5x?=
 =?utf-8?B?ckdwUWhvVlllWURwc29GMmRDLzR3N05CWHpJTmRRYkhJMStTTEpiUzQ4UXMz?=
 =?utf-8?B?VTRUaUErTElQcGZCSmhJRkVyTW1jcGhZODhtMC9mcE9KVG1mVGxtL1JXZzBT?=
 =?utf-8?B?cHhPV0lnN0ViOGN1WEltdWRQNTJZanRiMHJFRHpGeFJXZXFpakI0S3k2YzhK?=
 =?utf-8?B?eGFXbzJhL0o2c1NOWjUrL1A1NUdpblRXUlViODVzWUxZbGRBZW96ZmxZNzZC?=
 =?utf-8?B?WEZWY0tCck9vc011eFB1SDlsYWdYV1g1UXpJNlRYWVZIUzE1V0NtbU5KZUJX?=
 =?utf-8?B?NlNQeTk4cWhsaFVOcEZoUk5sTnh5bDVZb3BqckZMNFhCaWtXWE1GM3JYNDN3?=
 =?utf-8?B?eURCNHRoeW5OWUR2LzhtQT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR18MB5084.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WVp2Wm0rZ1hGLy9ic0c1WlN1T1lNVmxRNnJvc3dzTWVKYjMvVGRkeVFFeW5Y?=
 =?utf-8?B?L1lBV0ZrSHlNcFRubXFxR3FUTHY1aUlWY2VjSDJ4empCMnVZQXBCWnErUHZa?=
 =?utf-8?B?bTZsYVNtamFmUXdvRkJpOVRyN2tNdjZLZnhINE9pdll3S0R6RFRLU2xld3dO?=
 =?utf-8?B?aEw4NnpxUXNSYnlad2IyVjhZcFc0VFNkNHlkY1ZqUmM4VkZiTTNwNGh3aTdk?=
 =?utf-8?B?VVNva0ZiN1B6TmVyeXcvS1pZN2lhRG9Zb0tBK1BkZW5iQVNXWThGY3JmUk1z?=
 =?utf-8?B?V1dSOUttN25LVFdwanZPLzM5TWFSa2Nha0NzbFRNNS9jdXdnci9BK2FkeSsr?=
 =?utf-8?B?bkhKVUJkRks3cVgwUXNTZDZFMXpWNGRWV3paTWJKM0lCOEtkckVMelNtMFd4?=
 =?utf-8?B?dHpMRCtzelJpdXJWa2FuR2luWW1ETnFONkg1ZUpzRGl6QnZONi9mUXlpREJw?=
 =?utf-8?B?Mzc4bzViTDFSRmNKNjVBUWtPOEgzYTRFaVJ1RE04dHkzR045RHJBSHNJWUE1?=
 =?utf-8?B?NkVqSCt1b0pia3JuVVlRV2NUYzUwT25TRFdxWVprVS9jajZZL0N6MHRmdGRH?=
 =?utf-8?B?dGFNeW16UkMxOUY3d3pEb29adFpXYUJJaWNRL2trY0dGWW5SYzVMdmRmTExY?=
 =?utf-8?B?L00rY1poeit6R3FnMnBMMXpzbGtYQVVQYmU2RGxtcXRjZ0h0dE4yL0RFbGlr?=
 =?utf-8?B?ZHNMT2t3R3RDUkRIcllMVjVMK0x6OGNwaWZBa245a0xoTlRwWE94djdRSVox?=
 =?utf-8?B?d0VIL3UyWFB1Y3dNMnp2KzZnZW1PSFVEdHNPMmF0RGN6bDNNU1ZvV1lMZFRN?=
 =?utf-8?B?Sk1uQVBEanNNZ0hGQy9WSkthRk9BSzZoMGxab2I2clB1MUVEdklHVUxFb0ht?=
 =?utf-8?B?Syt6cG5mWkp2bnpSc0t1QktGcVVvSjBUZU5wYVVQMVhxcFMyblhTbDdHeVhs?=
 =?utf-8?B?ajlHbCtjdWJZNjZVT0tIV0xCM09IVGw1V2pDNGM1V0IzajMzSzRmdlgrVU1I?=
 =?utf-8?B?Snd1YnBzc1FDOC95NCs2V0NRNEdJdlZEUlBoMUtrT25tdXJHZjNqZmVsQ1ZI?=
 =?utf-8?B?YWovNWE4aC90enQ4cXlWaHB0N1lDV1RLRFh5VVVHZnJROTViczgwNHlnbysz?=
 =?utf-8?B?eHZOMlRLWVBONXdIRUJjcUtBTGQyNS9hT1N3MC9taUdyOUIybW5uT2hxdDhw?=
 =?utf-8?B?bzhEakNKek54UzlEcG9udTJUWlczN2Jkeis4akFTU2UyaXptbmYzSm5mQXFG?=
 =?utf-8?B?VlNsc0lBYTVWdjhPVkxGd3VHZTdLWnVLUk90UzBxcWJZZ2dTV0JCTUhiR0xS?=
 =?utf-8?B?RUk2M0FLazZXTCtJTWpNYVB0bmxYSEw0UkV0bXJPWURTSkdiZWkvN1RzMjJp?=
 =?utf-8?B?eHE2N0xnb25HM2kxVXk1S0s0VS9NclZWWGQ3VVo5Y0J3WTZiL3ZmNjM4RG4v?=
 =?utf-8?B?SThBWmRrYjk3RnpnYzhLQ0o1aHRMN0ZMODV5c3hYanhFR1BpSWpzY2dqSzNF?=
 =?utf-8?B?c1JPT28zZUlIbmQ4SCtJWHpzQmF3aGlKQ2hyTXRoZVNMWXRYWVNzeVZqOFl5?=
 =?utf-8?B?cEczMFh1bzF1NjFNMksxRlR0dUxGeTdFc1lnTXYyMDVmaWhERWsxZVBSVzhp?=
 =?utf-8?B?eEVRRlVjS0hBQjFCZ3RtTEtveHNGR1phK3FZTTdLanJ2TVVhZ296SW9PcWdS?=
 =?utf-8?B?TVpkNEVUT1g4bnRZZ1JYNDU1SURDZFB2U3g4Y3p2Q2tiRkZCcnpNNWp6cW9E?=
 =?utf-8?B?N3dObkcyNDhaRk5iZWg3V2ZLRlRGby80Q0pFRDVCQ1FTNlVGQ2JmeUkxVnNR?=
 =?utf-8?B?ZzI4eUZxNUZZbXRDVUFhb1R2MTNlK1hETVZka054a2dvdjI3QUhkSURjcVpC?=
 =?utf-8?B?ZEF1KzBQQVk4T2RRUW9GMzNDNXY0SDlwZ21tcGNncmw2eFpUN3dUc0c4MnNZ?=
 =?utf-8?B?b3VTWGN1UFRPVnF0MXFIZ25nNklHL29QdDlHSWhWYXdGMDU0RXZrQkk5TjJi?=
 =?utf-8?B?cmZaR05FckhuaGV3NnZyZDBNOXBtOG5JNGNEcnhrVEhjVEp6NTcwTkorOEQy?=
 =?utf-8?B?c09pdHBKdVpsclVEOGFrbHA2NVAxZTFKVWhuaWorUlBuOElJMjhEV2EwVW5j?=
 =?utf-8?Q?ClVSvFYKXKRDGDWleNzbWPlhk?=
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd76579-517b-4ebf-eb84-08dcc2ce3e45
X-MS-Exchange-CrossTenant-AuthSource: MW4PR18MB5084.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Aug 2024 17:17:04.5137
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EquPJ5MgKqNHlPjLWe8VulwnRTgDbHmflm6pxPyaD/BDv0h6G69JUyudQsdv7WcDgBiy6eFpEoWFe8VFh1bcNw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR18MB6165
X-Proofpoint-GUID: ykKIbIttqWq6PBKORIPsNItXHMm0wmGG
X-Proofpoint-ORIG-GUID: ykKIbIttqWq6PBKORIPsNItXHMm0wmGG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_10,2024-08-22_01,2024-05-17_01

Hi,

> The BCM8958x uses early adaptor version of DWC_xgmac version 4.00a for
> ethernet MAC. The DW25GMAC introduced in this version adds new DMA
> architecture called Hyper-DMA (HDMA) for virtualization scalability.
> This is realized by decoupling physical DMA channels(PDMA) from potentially
> large number of virtual DMA channels (VDMA). The VDMAs are software
> abastractions that map to PDMAs for frame transmission and reception.
You should either run ./scripts/checkpatch.pl --strict --codespell 
--patch or use :set spell in vi to check for spelling mistakes
> 
> To support the new HDMA architecture, a new instance of stmmac_dma_ops
> dw25gmac400_dma_ops is added.
> Most of the other dma operation functions in existing dwxgamc2_dma.c file
> are reused where applicable.
> 
> Signed-off-by: Jitendra Vegiraju <jitendra.vegiraju@broadcom.com>
> ---
>    drivers/net/ethernet/stmicro/stmmac/Makefile  |   2 +-
>    .../net/ethernet/stmicro/stmmac/dw25gmac.c    | 173 ++++++++++++++++++
>    .../net/ethernet/stmicro/stmmac/dw25gmac.h    |  90 +++++++++
>    .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    |  31 ++++
>    drivers/net/ethernet/stmicro/stmmac/hwif.h    |   1 +
>    5 files changed, 296 insertions(+), 1 deletion(-)
>    create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
>    create mode 100644 drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
> 
> diff --git a/drivers/net/ethernet/stmicro/stmmac/Makefile b/drivers/net/ethernet/stmicro/stmmac/Makefile
> index c2f0e91f6bf8..967e8a9aa432 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/Makefile
> +++ b/drivers/net/ethernet/stmicro/stmmac/Makefile
> @@ -6,7 +6,7 @@ stmmac-objs:= stmmac_main.o stmmac_ethtool.o stmmac_mdio.o ring_mode.o	\
>    	      mmc_core.o stmmac_hwtstamp.o stmmac_ptp.o dwmac4_descs.o	\
>    	      dwmac4_dma.o dwmac4_lib.o dwmac4_core.o dwmac5.o hwif.o \
>    	      stmmac_tc.o dwxgmac2_core.o dwxgmac2_dma.o dwxgmac2_descs.o \
> -	      stmmac_xdp.o stmmac_est.o \
> +	      stmmac_xdp.o stmmac_est.o dw25gmac.o \
>    	      $(stmmac-y)
>    
>    stmmac-$(CONFIG_STMMAC_SELFTESTS) += stmmac_selftests.o
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
> new file mode 100644
> index 000000000000..7cb0ff4328c3
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.c
> @@ -0,0 +1,173 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2024 Broadcom Corporation
> + */
> +#include "dwxgmac2.h"
> +#include "dw25gmac.h"
> +
> +static int rd_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel)
> +{
> +	u32 reg_val = 0;
> +
> +	reg_val |= FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
> +	reg_val |= FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
> +	reg_val |= XXVGMAC_CMD_TYPE | XXVGMAC_OB;
> +	writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
> +	return readl(ioaddr + XXVGMAC_DMA_CH_IND_DATA);
> +}
> +
> +static void wr_dma_ch_ind(void __iomem *ioaddr, u8 mode, u32 channel, u32 val)
> +{
> +	u32 reg_val = 0;
> +
> +	writel(val, ioaddr + XXVGMAC_DMA_CH_IND_DATA);
> +	reg_val |= FIELD_PREP(XXVGMAC_MODE_SELECT, mode);
> +	reg_val |= FIELD_PREP(XXVGMAC_ADDR_OFFSET, channel);
> +	reg_val |= XGMAC_OB;
> +	writel(reg_val, ioaddr + XXVGMAC_DMA_CH_IND_CONTROL);
> +}
> +
> +static void xgmac4_tp2tc_map(void __iomem *ioaddr, u8 pdma_ch, u32 tc_num)
> +{
> +	u32 val = 0;
> +
> +	val = rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, pdma_ch);
> +	val &= ~XXVGMAC_TP2TCMP;
> +	val |= FIELD_PREP(XXVGMAC_TP2TCMP, tc_num);
> +	wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, pdma_ch, val);
> +}
> +
> +static void xgmac4_rp2tc_map(void __iomem *ioaddr, u8 pdma_ch, u32 tc_num)
> +{
> +	u32 val = 0;
> +
> +	val = rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, pdma_ch);
> +	val &= ~XXVGMAC_RP2TCMP;
> +	val |= FIELD_PREP(XXVGMAC_RP2TCMP, tc_num);
> +	wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, pdma_ch, val);
> +}
> +
> +static u32 decode_vdma_count(u32 regval)
> +{
> +	/* compressed encoding for vdma count
> +	 * regval: VDMA count
> +	 * 0-15	 : 1 - 16
> +	 * 16-19 : 20, 24, 28, 32
> +	 * 20-23 : 40, 48, 56, 64
> +	 * 24-27 : 80, 96, 112, 128
> +	 */
> +	if (regval < 16)
> +		return regval + 1;
> +	return (4 << ((regval - 16) / 4)) * ((regval % 4) + 5);
Is there a potential for regval to be out of bounds (regval > 27)  that 
needed to be handled properly?
> +}
> +
> +void dw25gmac_dma_init(void __iomem *ioaddr,
> +		       struct stmmac_dma_cfg *dma_cfg)
> +{
> +	u32 num_vdma_tx;
> +	u32 num_vdma_rx;
> +	u32 num_pdma_tx;
> +	u32 num_pdma_rx;
> +	u32 hw_cap;
> +	u32 value;
> +	u32 i;
> +
> +	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE2);
> +	num_pdma_tx = FIELD_GET(XGMAC_HWFEAT_TXQCNT, hw_cap) + 1;
> +	num_pdma_rx = FIELD_GET(XGMAC_HWFEAT_RXQCNT, hw_cap) + 1;
> +
> +	num_vdma_tx = decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_TXCNT,
> +						  hw_cap));
> +	if (num_vdma_tx > STMMAC_DW25GMAC_MAX_NUM_TX_VDMA)
> +		num_vdma_tx = STMMAC_DW25GMAC_MAX_NUM_TX_VDMA;
> +	num_vdma_rx = decode_vdma_count(FIELD_GET(XXVGMAC_HWFEAT_VDMA_RXCNT,
> +						  hw_cap));
> +	if (num_vdma_rx > STMMAC_DW25GMAC_MAX_NUM_RX_VDMA)
> +		num_vdma_rx = STMMAC_DW25GMAC_MAX_NUM_RX_VDMA;
> +
> +	value = readl(ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +	value &= ~(XGMAC_AAL | XGMAC_EAME);
> +	if (dma_cfg->aal)
> +		value |= XGMAC_AAL;
> +	if (dma_cfg->eame)
> +		value |= XGMAC_EAME;
> +	writel(value, ioaddr + XGMAC_DMA_SYSBUS_MODE);
> +
> +	for (i = 0; i < num_vdma_tx; i++) {
> +		value = rd_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i);
> +		value &= ~XXVGMAC_TXDCSZ;
> +		value |= FIELD_PREP(XXVGMAC_TXDCSZ,
> +				    XXVGMAC_TXDCSZ_256BYTES);
> +		value &= ~XXVGMAC_TDPS;
> +		value |= FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_TDPS_HALF);
> +		wr_dma_ch_ind(ioaddr, MODE_TXDESCCTRL, i, value);
> +	}
> +
> +	for (i = 0; i < num_vdma_rx; i++) {
> +		value = rd_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i);
> +		value &= ~XXVGMAC_RXDCSZ;
> +		value |= FIELD_PREP(XXVGMAC_RXDCSZ,
> +				    XXVGMAC_RXDCSZ_256BYTES);
> +		value &= ~XXVGMAC_RDPS;
> +		value |= FIELD_PREP(XXVGMAC_TDPS, XXVGMAC_RDPS_HALF);
> +		wr_dma_ch_ind(ioaddr, MODE_RXDESCCTRL, i, value);
> +	}
> +
> +	for (i = 0; i < num_pdma_tx; i++) {
> +		value = rd_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i);
> +		value &= ~(XXVGMAC_TXPBL | XXVGMAC_TPBLX8_MODE);
> +		if (dma_cfg->pblx8)
> +			value |= XXVGMAC_TPBLX8_MODE;
> +		value |= FIELD_PREP(XXVGMAC_TXPBL, dma_cfg->pbl);
> +		wr_dma_ch_ind(ioaddr, MODE_TXEXTCFG, i, value);
> +		xgmac4_tp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->tpdma_tc[i]);
> +	}
> +
> +	for (i = 0; i < num_pdma_rx; i++) {
> +		value = rd_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i);
> +		value &= ~(XXVGMAC_RXPBL | XXVGMAC_RPBLX8_MODE);
> +		if (dma_cfg->pblx8)
> +			value |= XXVGMAC_RPBLX8_MODE;
> +		value |= FIELD_PREP(XXVGMAC_RXPBL, dma_cfg->pbl);
> +		wr_dma_ch_ind(ioaddr, MODE_RXEXTCFG, i, value);
> +		xgmac4_rp2tc_map(ioaddr, i, dma_cfg->hdma_cfg->rpdma_tc[i]);
> +	}
> +}
> +
> +void dw25gmac_dma_init_tx_chan(struct stmmac_priv *priv,
> +			       void __iomem *ioaddr,
> +			       struct stmmac_dma_cfg *dma_cfg,
> +			       dma_addr_t dma_addr, u32 chan)
> +{
> +	u32 value;
> +
> +	value = readl(ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +	value &= ~XXVGMAC_TVDMA2TCMP;
> +	value |= FIELD_PREP(XXVGMAC_TVDMA2TCMP,
> +			    dma_cfg->hdma_cfg->tvdma_tc[chan]);
> +	writel(value, ioaddr + XGMAC_DMA_CH_TX_CONTROL(chan));
> +
> +	writel(upper_32_bits(dma_addr),
> +	       ioaddr + XGMAC_DMA_CH_TxDESC_HADDR(chan));
> +	writel(lower_32_bits(dma_addr),
> +	       ioaddr + XGMAC_DMA_CH_TxDESC_LADDR(chan));
> +}
> +
> +void dw25gmac_dma_init_rx_chan(struct stmmac_priv *priv,
> +			       void __iomem *ioaddr,
> +			       struct stmmac_dma_cfg *dma_cfg,
> +			       dma_addr_t dma_addr, u32 chan)
> +{
> +	u32 value;
> +
> +	value = readl(ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +	value &= ~XXVGMAC_RVDMA2TCMP;
> +	value |= FIELD_PREP(XXVGMAC_RVDMA2TCMP,
> +			    dma_cfg->hdma_cfg->rvdma_tc[chan]);
> +	writel(value, ioaddr + XGMAC_DMA_CH_RX_CONTROL(chan));
> +
> +	writel(upper_32_bits(dma_addr),
> +	       ioaddr + XGMAC_DMA_CH_RxDESC_HADDR(chan));
> +	writel(lower_32_bits(dma_addr),
> +	       ioaddr + XGMAC_DMA_CH_RxDESC_LADDR(chan));
> +}
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dw25gmac.h b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
> new file mode 100644
> index 000000000000..c7fdf6624fea
> --- /dev/null
> +++ b/drivers/net/ethernet/stmicro/stmmac/dw25gmac.h
> @@ -0,0 +1,90 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/* Copyright (c) 2024 Broadcom Corporation
> + * DW25GMAC definitions.
> + */
> +#ifndef __STMMAC_DW25GMAC_H__
> +#define __STMMAC_DW25GMAC_H__
> +
> +/* Hardware features */
> +#define XXVGMAC_HWFEAT_VDMA_RXCNT	GENMASK(16, 12)
> +#define XXVGMAC_HWFEAT_VDMA_TXCNT	GENMASK(22, 18)
> +
> +/* DMA Indirect Registers*/
> +#define XXVGMAC_DMA_CH_IND_CONTROL	0X00003080
> +#define XXVGMAC_MODE_SELECT		GENMASK(27, 24)
> +enum dma_ch_ind_modes {
> +	MODE_TXEXTCFG	 = 0x0,	  /* Tx Extended Config */
> +	MODE_RXEXTCFG	 = 0x1,	  /* Rx Extended Config */
> +	MODE_TXDBGSTS	 = 0x2,	  /* Tx Debug Status */
> +	MODE_RXDBGSTS	 = 0x3,	  /* Rx Debug Status */
> +	MODE_TXDESCCTRL	 = 0x4,	  /* Tx Descriptor control */
> +	MODE_RXDESCCTRL	 = 0x5,	  /* Rx Descriptor control */
> +};
> +
> +#define XXVGMAC_ADDR_OFFSET		GENMASK(14, 8)
> +#define XXVGMAC_AUTO_INCR		GENMASK(5, 4)
> +#define XXVGMAC_CMD_TYPE			BIT(1)
> +#define XXVGMAC_OB			BIT(0)
> +#define XXVGMAC_DMA_CH_IND_DATA		0X00003084
nit: lower case please, 0x00003084.
> +
> +/* TX Config definitions */
> +#define XXVGMAC_TXPBL			GENMASK(29, 24)
> +#define XXVGMAC_TPBLX8_MODE		BIT(19)
> +#define XXVGMAC_TP2TCMP			GENMASK(18, 16)
> +#define XXVGMAC_ORRQ			GENMASK(13, 8)
> +
> +/* RX Config definitions */
> +#define XXVGMAC_RXPBL			GENMASK(29, 24)
> +#define XXVGMAC_RPBLX8_MODE		BIT(19)
> +#define XXVGMAC_RP2TCMP			GENMASK(18, 16)
> +#define XXVGMAC_OWRQ			GENMASK(13, 8)
> +
> +/* Tx Descriptor control */
> +#define XXVGMAC_TXDCSZ			GENMASK(2, 0)
> +#define XXVGMAC_TXDCSZ_0BYTES		0
> +#define XXVGMAC_TXDCSZ_64BYTES		1
> +#define XXVGMAC_TXDCSZ_128BYTES		2
> +#define XXVGMAC_TXDCSZ_256BYTES		3
> +#define XXVGMAC_TDPS			GENMASK(5, 3)
> +#define XXVGMAC_TDPS_ZERO		0
> +#define XXVGMAC_TDPS_1_8TH		1
> +#define XXVGMAC_TDPS_1_4TH		2
> +#define XXVGMAC_TDPS_HALF		3
> +#define XXVGMAC_TDPS_3_4TH		4
> +
> +/* Rx Descriptor control */
> +#define XXVGMAC_RXDCSZ			GENMASK(2, 0)
> +#define XXVGMAC_RXDCSZ_0BYTES		0
> +#define XXVGMAC_RXDCSZ_64BYTES		1
> +#define XXVGMAC_RXDCSZ_128BYTES		2
> +#define XXVGMAC_RXDCSZ_256BYTES		3
> +#define XXVGMAC_RDPS			GENMASK(5, 3)
> +#define XXVGMAC_RDPS_ZERO		0
> +#define XXVGMAC_RDPS_1_8TH		1
> +#define XXVGMAC_RDPS_1_4TH		2
> +#define XXVGMAC_RDPS_HALF		3
> +#define XXVGMAC_RDPS_3_4TH		4
> +
> +/* DWCXG_DMA_CH(#i) Registers*/
> +#define XXVGMAC_DSL			GENMASK(20, 18)
> +#define XXVGMAC_MSS			GENMASK(13, 0)
> +#define XXVGMAC_TFSEL			GENMASK(30, 29)
> +#define XXVGMAC_TQOS			GENMASK(27, 24)
> +#define XXVGMAC_IPBL			BIT(15)
> +#define XXVGMAC_TVDMA2TCMP		GENMASK(6, 4)
> +#define XXVGMAC_RPF			BIT(31)
> +#define XXVGMAC_RVDMA2TCMP		GENMASK(30, 28)
> +#define XXVGMAC_RQOS			GENMASK(27, 24)
> +
> +void dw25gmac_dma_init(void __iomem *ioaddr,
> +		       struct stmmac_dma_cfg *dma_cfg);
> +
> +void dw25gmac_dma_init_tx_chan(struct stmmac_priv *priv,
> +			       void __iomem *ioaddr,
> +			       struct stmmac_dma_cfg *dma_cfg,
> +			       dma_addr_t dma_addr, u32 chan);
> +void dw25gmac_dma_init_rx_chan(struct stmmac_priv *priv,
> +			       void __iomem *ioaddr,
> +			       struct stmmac_dma_cfg *dma_cfg,
> +			       dma_addr_t dma_addr, u32 chan);
> +#endif /* __STMMAC_DW25GMAC_H__ */
> diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> index 7840bc403788..02abfdd40270 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> +++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
> @@ -7,6 +7,7 @@
>    #include <linux/iopoll.h>
>    #include "stmmac.h"
>    #include "dwxgmac2.h"
> +#include "dw25gmac.h"
>    
>    static int dwxgmac2_dma_reset(void __iomem *ioaddr)
>    {
> @@ -641,3 +642,33 @@ const struct stmmac_dma_ops dwxgmac210_dma_ops = {
>    	.enable_sph = dwxgmac2_enable_sph,
>    	.enable_tbs = dwxgmac2_enable_tbs,
>    };
> +
> +const struct stmmac_dma_ops dw25gmac400_dma_ops = {
> +	.reset = dwxgmac2_dma_reset,
> +	.init = dw25gmac_dma_init,
> +	.init_chan = dwxgmac2_dma_init_chan,
> +	.init_rx_chan = dw25gmac_dma_init_rx_chan,
> +	.init_tx_chan = dw25gmac_dma_init_tx_chan,
> +	.axi = dwxgmac2_dma_axi,
> +	.dump_regs = dwxgmac2_dma_dump_regs,
> +	.dma_rx_mode = dwxgmac2_dma_rx_mode,
> +	.dma_tx_mode = dwxgmac2_dma_tx_mode,
> +	.enable_dma_irq = dwxgmac2_enable_dma_irq,
> +	.disable_dma_irq = dwxgmac2_disable_dma_irq,
> +	.start_tx = dwxgmac2_dma_start_tx,
> +	.stop_tx = dwxgmac2_dma_stop_tx,
> +	.start_rx = dwxgmac2_dma_start_rx,
> +	.stop_rx = dwxgmac2_dma_stop_rx,
> +	.dma_interrupt = dwxgmac2_dma_interrupt,
> +	.get_hw_feature = dwxgmac2_get_hw_feature,
> +	.rx_watchdog = dwxgmac2_rx_watchdog,
> +	.set_rx_ring_len = dwxgmac2_set_rx_ring_len,
> +	.set_tx_ring_len = dwxgmac2_set_tx_ring_len,
> +	.set_rx_tail_ptr = dwxgmac2_set_rx_tail_ptr,
> +	.set_tx_tail_ptr = dwxgmac2_set_tx_tail_ptr,
> +	.enable_tso = dwxgmac2_enable_tso,
> +	.qmode = dwxgmac2_qmode,
> +	.set_bfsize = dwxgmac2_set_bfsize,
> +	.enable_sph = dwxgmac2_enable_sph,
> +	.enable_tbs = dwxgmac2_enable_tbs,
> +};
> diff --git a/drivers/net/ethernet/stmicro/stmmac/hwif.h b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> index 7e90f34b8c88..9764eadf72c2 100644
> --- a/drivers/net/ethernet/stmicro/stmmac/hwif.h
> +++ b/drivers/net/ethernet/stmicro/stmmac/hwif.h
> @@ -682,6 +682,7 @@ extern const struct stmmac_desc_ops dwxgmac210_desc_ops;
>    extern const struct stmmac_mmc_ops dwmac_mmc_ops;
>    extern const struct stmmac_mmc_ops dwxgmac_mmc_ops;
>    extern const struct stmmac_est_ops dwmac510_est_ops;
> +extern const struct stmmac_dma_ops dw25gmac400_dma_ops;
>    
>    #define GMAC_VERSION		0x00000020	/* GMAC CORE Version */
>    #define GMAC4_VERSION		0x00000110	/* GMAC4+ CORE Version */
> -- 
> 2.34.1
> 
> 



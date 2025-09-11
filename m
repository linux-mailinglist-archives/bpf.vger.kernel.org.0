Return-Path: <bpf+bounces-68150-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CE9B536C8
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:01:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4941E5625C7
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 15:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2130E343D6C;
	Thu, 11 Sep 2025 14:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oRtzTNoi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Ph26avnJ"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4473343D76;
	Thu, 11 Sep 2025 14:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602777; cv=fail; b=a22IqY1bjXZ55vbzp6EVYjIeLMzyOC6K2ODq4faO4yOS0Yviwo22njbxjlMUDxg/gLH9txLdoyytkWXR1EF5aEJLQnpyWrrPGvKLCgPw/SGMrStVlghoQPq9k0MJOYmLNwbUD4+IZZLePC+6xVRV2eR/gPzR+1Y2zL6Ka8Fdvx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602777; c=relaxed/simple;
	bh=b6yJ/CEYML0umv0IlWIZWHmGqMuikQVVA/zmBmJoNwM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CBwN2h32tixWl6fgK4/BgAuNDvQ03frf2Rn2PX0xl7SXFuUmjMANrLhUWGsiZtgLIn5fjqJyxuGCGRoILpVGVgSotmcfGffwrSaHfTcZfwLNmWxd1pOfikDOt66pH74fgsRCki9p7K/rPDgRS0wTyvloafd+N6vGxYDQnBQweS0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oRtzTNoi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Ph26avnJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDtjg2011866;
	Thu, 11 Sep 2025 14:58:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=LmLCaJ7iOCj4owM2hnjYwbQufw9N4Jkk32/ywrZhdQw=; b=
	oRtzTNoiaMNj9O5yzfD9OHVODLv7gA+Juyct+YnWqHdZ8ovMUezPc9LW+5ehNm75
	jsavQApWcnddqlsDjEKr0iuSnkxih/M4eodwroNTB9K5ZyFadcSEhIQldIVKuIjt
	PJ6n5tKIeOHwc97X7ZoHabAJwAlxO8AilUReywJ1xrFwoP/PmFLYXx907lw/xndG
	QWB3EQcgozQJhHRdAgU9Hr1JT3mtcoW93NhIqiBICLPZkmgacefXsHZ+oxe1nI7F
	QnGdaMIHZXV/pGZf6LXlnzR0Ix5pWmVq/pQQ2i8mfNSUWF+k6kLNtMiIWSMqE5Qk
	VZD0PiUYihYhN0Pw9lqRvQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226sxfmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:58:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BE5BOQ038916;
	Thu, 11 Sep 2025 14:58:40 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011003.outbound.protection.outlook.com [40.107.208.3])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcjmkh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:58:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sp76mfyUrKcNLCEzSD0BAUfMaSut1UeBHvj/BBNFB1HHEi5Xq7/AnLRllegIcJzyt3mZlsVNF/JZQzVYkbRZZFBigs2fK1leRWAkW6Dwc+tEE/KP4ddryY3WIw4jkogLZV2V0BrHLyEei8BTXUg/9a4FEwLI5KTyONPjhndFizXAZgzpgmjvoujW0DMy6Ti9DYDEcGmwkSjqeZlkrJkNcPZDPM82qMXBF/SWr80D/iyhgTeOSlyeLqf7BcZQRYuuUsGDxfzMbWEV4B6y6rUHriBA5GZZyuGfTfd9emb+Hh/H3gpQ64Dcgps+GSScJYlEXj91PP84Kk9rcaoBuRAGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LmLCaJ7iOCj4owM2hnjYwbQufw9N4Jkk32/ywrZhdQw=;
 b=nQdwWbyGCsPmX0se9khb/KPhHXygpnNj1sS3B+6aZhai6ZuZm2HlrCy+uEMGwOAc4b5WaU7N9gQ1DnTywjpCeSK51yI01nfwyaUgkUuSw/x2vW0gNUHoxd/HvmWh7wohRqku9gSSU2QDrQeuDi0+H4vjh9qZA36nE2Jr/FaHoOyje9EBSpKxIUAcLnOeqq2Ce1CwJraci0xUleQEE30xldwAFKUor4xa4DTpl5TnTjoc/Y+XjOnatbFe9a0w07WSWCvj25Iz1l6qt3898Ln3J69suDHdXvtxdhAwwUSLj2p9y1de2YwSgHJ1LpD8hcJwg460ZoPgAoBgIB51FlXcSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LmLCaJ7iOCj4owM2hnjYwbQufw9N4Jkk32/ywrZhdQw=;
 b=Ph26avnJXTRVYNaoi2G1YLOc14wartZ4VX3x3RZ9PGG44EvtVKdVOl+/nqrnTx1uhlnkpfxK7HmJK0G7kj1fNw+oQHeHvmmAf/UPFPr95Vx8yYYEpciHa+LetjqpjuF5mZYVDfyPCvReyEq4yNqofN6otSEvlAmPMxwI7VcwPao=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7260.namprd10.prod.outlook.com (2603:10b6:610:12e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:58:13 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:58:13 +0000
Date: Thu, 11 Sep 2025 15:58:11 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <4fba4e8a-a735-4cac-b003-39363583ad19@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-3-laoar.shao@gmail.com>
 <CABzRoyZm32HT2fDpSy_PRDxeXZVJD35+9YqRpn9XWix8jG6w8g@mail.gmail.com>
 <3b1c6388-812f-4702-bd71-33a6373a381a@lucifer.local>
 <5a2a4b59-9368-4185-bd08-74324eebacb3@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5a2a4b59-9368-4185-bd08-74324eebacb3@linux.dev>
X-ClientProxiedBy: LO4P123CA0280.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: 97341448-785b-426d-bcbd-08ddf143a193
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?NzVBU3hKckE0N1A5cEowb3hwSVI5cUFNRlhIdEM0OVBGTnFaNnhDbWlDQnor?=
 =?utf-8?B?WEhNYTZSYno3aVlHMEtrbWNqbW1VMFdOZkxHTWo1ZkFYRjVZcGxOclFSb1Yr?=
 =?utf-8?B?Y0hWT2IzcEhzdUZpbzJ1SXl2RnZNd1IrWi85aHI2ZzFQalAvN0hOSnYzSm85?=
 =?utf-8?B?K3o5YkdiTDQ2c3ZBdW82cjRERzVaSDRpVnhBZS9pWFB3RVZXQnFmeis4V3JZ?=
 =?utf-8?B?TlFvUWV0cWY5cTNzd2M2aXZPckpTcmxKbnFMOWpqVkFNQ1crSnJuRHp3KzJw?=
 =?utf-8?B?T0xRQ1BYVTZNa051RGdjSTRxQ2gxYVhZcko2dndIRmp3WVVtUmtTL2hMbExP?=
 =?utf-8?B?NmMxbFhkc0c0TXYxa1A2STBhTksxcHpLY012TUtMZUNoc2NrbmN5Z0lrdnRw?=
 =?utf-8?B?RGlMZXlLWkFjRTNYay9JbWdNWUl1WFNNK2NtZTJKY3B4TGh5QlA1SUFOZHFT?=
 =?utf-8?B?OE5ITGVFZ24wY3FXSlRXajFLRlltKzJPbmhSd1FwYXA0cmhJS2JMMjBXTkZh?=
 =?utf-8?B?Z0M0RWdZWmNKU09nbVpvK3pIaEJFTmlMclAxY0tHRTlFUXZYbHIvNi9DRVQ1?=
 =?utf-8?B?NnRaMTU0S252ZFFEU2owRWY1NDIyK0VHcGtLTDk1MGpsbTBMNTdrMGVRQyth?=
 =?utf-8?B?UGJwbHYvOUxKMitvb1lUczRCTDNtR1NNcncyRGthZERqQlRiSExtNFJncnIv?=
 =?utf-8?B?VVZRcVlZeFJkK3pZbVhqSnJOUWc1NEE5SUhBQnhPQjdWb3M5Z3hyVzQ4VEhE?=
 =?utf-8?B?a3NTdnRCUzcrN3gyR2hvN0JOYUl2QndZa3Rud3djNGRnVEc4UysyZmM5Sk1l?=
 =?utf-8?B?eDJRbVNPaWpHM2FzSW1wS090UVFHSjFpOHc3L0Ftb2lqWXN0MXRIN2d0eXhk?=
 =?utf-8?B?eUdsQkFnNU52K3kvRU82YmxPY1NCVC9aSHZJNlMvZm1CT0c0aTBpSFY0Uk4w?=
 =?utf-8?B?ajc5Mm9VOEZTVmtUU3NWQzJyM3ZIQVRpeUxvS1M4ZGZiZkVpYTNpZkMvbVVm?=
 =?utf-8?B?T2lGWXZXQ3RlN0h5Z3hIbkRtbTFJWE5mZnN0Sk9ZZGoyL3NVSFlMZnhWelRV?=
 =?utf-8?B?cDVLRTVhcVpNY2pzNXZIdExra0x6UFlmUnNKTXJJVHN4UUZlQnFtbGlHR1Vv?=
 =?utf-8?B?UVJZY0hNYlkxVHZMZFJnM1VBRjA5cFY0MUMwRk5JSWs0MFE1WGMrS1dvaytE?=
 =?utf-8?B?Tm9TS0lGaVRsNzRaV2R2d2FlZnpmd2JHRW9QakFGWkJIWmRadnA0ZEttM0Rj?=
 =?utf-8?B?aEM3TnNqN2VmcVZ5L0RkZVdIWEJnRWt5TzRnS1hickRnamN1bnlZd2tvUXpy?=
 =?utf-8?B?eHRlR3Nza2JEL3UrY2xHQW5EMkM3NWFzRktEY0dPNC9jZUlZL0MrUlFHOGdV?=
 =?utf-8?B?cmxMeGhpYUovTlNTQkN6U1VCcU40REpRNGo3WVpOanJiYTViU2FmalBPbFg2?=
 =?utf-8?B?bFFiZlhENDRJTTc5dWtublVyM0gxMFZ6S0lPbndSalFXZzk5OTAwWkl2L3RL?=
 =?utf-8?B?N1VBSmIzK3lNWEZza0diSU13V3dWaUF0cDVuekhzN1ZoU1dmSU16M3F3amNG?=
 =?utf-8?B?S0JSRlNNU2dKeTJNRkZCWVhCOU52WEpDTWVWNnNqcmRnWUVVU0tGenh3QkxH?=
 =?utf-8?B?OVlMVGFQWkJLQ0hHVStidWtUME1KaDc2cy8rVGhIZUJCVFYrSDhjQWpiUUJt?=
 =?utf-8?B?RWNabXk1MmhnT0hwOTFrdEVDQmVQZ25NREtwbnhObnQ4elp3SnlMeWJUejUz?=
 =?utf-8?B?SzRRUVhmVEZvaEdMNkNDZzk2VHRua1pqWVpvbGt6TEw0UFlSSlRlTTM1UG1Q?=
 =?utf-8?B?MEJMWEUwelhqejdmRS8zZ1ZYdXVOdDE2SmlvYnFqZ1hMMnlLYUpyaU9YZ3h3?=
 =?utf-8?B?TU5MNjJRb2dHRVBGK2RGbkVHdEFMUmoxWmhCTEVKNThYbmxDa0IvQmZGOGdz?=
 =?utf-8?Q?5rIiKIuFbEY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGR3WjBFdWtLY0g2SDNRQVN0K2dnUFloemxrV1FJWkxTUk9zRHd2amRaek5H?=
 =?utf-8?B?ck8wdnNaQ2VXOWVhOFd0VHc4M2wzT3dNQzhhMVpIM1hIUHpQVUtqY281MTYx?=
 =?utf-8?B?dnIrQkpYdjh1YXk5RnFOVTREeXVVVW5YTU9aNEo1K1ZGaHpVU2dLbmpEbHZv?=
 =?utf-8?B?T0s5cWNaaU1SUGhSVFR4eUhWUzlxejdMZ0krN2wyZHFkVGlKbkdUdnFrMWtr?=
 =?utf-8?B?Wit4aDJwcWMyYXRreXdsUnFCayt6bXlZV0RxckFPZHRQYjNJOU04dHlEd3dZ?=
 =?utf-8?B?TnVKOXg4eHAybWN6Wk8wanN3Mlp2bE5sMXp6SjVMNFdDSi9TcEJ5SngyRW9y?=
 =?utf-8?B?MmczcWRKVU5aQTltYlgydFM0YlAwc09mQWpjYlR6bUpZdis0R0pJbXJJbWx4?=
 =?utf-8?B?VU83TlRJeC9xSm03aGpXTmp2bWVCNWMzNWhRYmlQOEFjR21NLzAyTDljbEU3?=
 =?utf-8?B?cXloanpJUElGNFVMcEsxNEVuR0tpc3FoRXp5a2ZjS3FQdGdHeU5sTEo1M2dP?=
 =?utf-8?B?cVNXRlYyVDdmajd2NURENkdDUnZ2RVp1UThCY3FSSUVTTUpaZ1JtVjBpS042?=
 =?utf-8?B?STRMbUhPZzhxVUEydXczM0J0NmFCQjhrUGNES1duS2tsandnOWppUW84bjRo?=
 =?utf-8?B?b2FJMmdMTjdwUm9FL1N6cUVVYXJ0bi8vVUhCbjI3WW9pT3hsMnBLalNiVzIy?=
 =?utf-8?B?Q0xsbkZnZmFmY0FNUGJCYzloL2JzWUNSeWtDcFBEbWN1RHc3eDdvNEpPaVdN?=
 =?utf-8?B?K0YrVTUxdlkxeEV2SlVDdjVnYkZhVmdhVUdVUUdKMGExdWtvYko1NWsrT0d3?=
 =?utf-8?B?cDRVQ2xOQ2ZOZjIzcldsR2xXczRwSGdzL0JDVWNEYjMvcHYwdGZ1SFIwZXpq?=
 =?utf-8?B?Ujc4Wm1lMUJQNkk4TVhFS2JCUW1oWDhPVGJJb1RMRDRkVnFrdkFnbmtjQlNK?=
 =?utf-8?B?eEZXakZDWHFYRWhGZU9ESW1PNEwrTkQ0UGh2d3ZwMzAwVGkxZnRhdEtib3Jw?=
 =?utf-8?B?ay9JbThhMVQrMjVoUklzaWlCRjM3czRVUGhzUmNsbTRBVDEvVllRVjRjVGRZ?=
 =?utf-8?B?YkZHeEFZa2JmTkUra2pRd2ZnV0g2TlhSeElKYU1nZlJRTHRYRWsvSnRZclhS?=
 =?utf-8?B?b1g5VEdnaEdqVXQ3K09kcHlIcjJ6WFJiaEQ1MHFtQXFVUnJYOVhyNXQ2Zyti?=
 =?utf-8?B?Si9QUnlrMTVBVk9CZUxvM3hqZWRaSGJUZjNsT29mZ01wbkNiZjh1K3AwVlhh?=
 =?utf-8?B?SENWWFMwZzV4aXF5czlrZ3c2aDFzZGN0cUYzUVVJb1J1NUkxZk9QQzdhcUc5?=
 =?utf-8?B?Y21KR1cwWUxUR0lIL0xKcm5vMUpWSUpqQkJMUUw0dTZpUXZrWE9yV3FjTytQ?=
 =?utf-8?B?NDRIWlkyRE1ZbXZEanNCSHRkYUZkVDIrblMyaG1HUWpxT3VoNldXRmdSWk9B?=
 =?utf-8?B?WWwyblZYRElyUWRaei9XTlVPRVU4cE9FeTBmZ08vQy9oL1pBV0tKa0k0RERW?=
 =?utf-8?B?MXhGdGVudWNYdmo2d0hXN05DMnUzYysvV2I3SkZ6Ti9Tdnp2S0tiU2trdmlS?=
 =?utf-8?B?alhpcjFQQ0hzRTcvakJ2QzB6Y09QaGZ5N1QxQklQWm1jSDRIVzdoZTFOcDFS?=
 =?utf-8?B?ck54c0t1dUFUZlZsSUZ0NWEzYTRCMXhkeEdPRHo4dkRYbHlFbUNVc0NnMGdU?=
 =?utf-8?B?MjFLdlJaZENzWmdBVllEUERmZFFUbTB4aTA3MHFiVmdkSU9sbEdRdmRWWXdl?=
 =?utf-8?B?YnJVb2s0Z2tYb0dsMCt3TG9DS04zSXhVdDFmOTJkZUFXWkNPbGdrVG00MHE1?=
 =?utf-8?B?MG1aV1ZkUGd2SHY0S09OeFBFZWl3Z2pFKzI2MGZpMVpvWU56cFFUZ3BFSlpE?=
 =?utf-8?B?NThsZlN6VTVON1JEbmdrK3JHTHlTYU5nK29aUjdTM2pYT21mMXJ6RFFOYnRN?=
 =?utf-8?B?VlhzcGVtV05FMjlWb1o0UGJJTkRpQTB6MEROTnpDcWVidVRYTExuRUI5WHFP?=
 =?utf-8?B?cFRTOVFZbnNDSHlESGJYNXpLU3dhM0Q1dGE2ZUhaa0tXWG1KY3BVVGtuUXRu?=
 =?utf-8?B?eFlOQlNjNXlFWEJaN010UjB6Yjcwa3JEMWlMRExSL1FIc24wd1Q5UXNTYllh?=
 =?utf-8?B?SjArYys2OXBmbzM3bEk1RmlKODQ4WHpOY3dpS1RiemZ3TEMreHJnanU4NGl0?=
 =?utf-8?B?bnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ALjy5RCmIpmljNNgMjNo+qmC5mB3HtATH9w34TkwzaocV9n8yEAkoyHwlnQAmOYqK4Q59IQtbYtPnnksgb48dA+sjNgpe9TS2oe5+8Guf4z/PVjssxG9XVh3sNppIuO2ZsEDW2sVynE0LKFNNsBs1CQ2UwrIaY0QI6SbPSJgCWv1JkVgUj7gwHldSF/cywHj5rQ8Q6O8oHucsIETjwgupuHQ/OlhKP+Ims2G40xA5d3xZ4C67sOh0sQXf/bp4CLka6J/QRGGcpAnc7FIYf6urKZK/psLT1fF0+K9m+oE/i+vEREUpVx/zHGXpc/hpr0CXQL3yU8QbZT89f6+idg49fAZCNqod8YoWM3c/VeO1e8nNa2RyUiDXpEVSmBzSu34uBRuHQM3dMfkr28ZxeDioBjqxo3pKJUfUXqrxFogatDPfehe2LJbj35aFIINJ0+OrnQu5FKfyybSZtW6AIUqx1mIvvbc/y2dxiozM1M8dzgm9E2YXHjaEttosi2WmSGRGVaKSAcRO1DUTwF4uC7iid81NLcqqm8CFW37YcoTkRVPaaMlekxHUpSM7l7onqGFfPRLIJ0/bDqwpKvEGN0x/nU1L5xrw9zj/Io32beG8A0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97341448-785b-426d-bcbd-08ddf143a193
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:58:13.3094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZcVZ1wTqVd65MrrQ0CYwZb2s7kIoPNbGVIXddQSBu9Q3pQTjRUhg97x/dXc7D71Osm1AQPXf0VI9PWQWcTFb822IzVDUxwr5Uf0DalDgmM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 adultscore=0 spamscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110132
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c2e3a2 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=-4zaChfW14p0fnKyauwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12083
X-Proofpoint-ORIG-GUID: 234oXUBdpIrYsM4bLhp8Y-wy9FKHzvX1
X-Proofpoint-GUID: 234oXUBdpIrYsM4bLhp8Y-wy9FKHzvX1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfXz518bEZiJzNp
 jRaJmd016VHXdV81FrVBugem5cA7/Kl8m4CWmkuG+ZWMaxJnamVyBHeK5XVftzp4yt4n0svWIhn
 JavfbX4Fv18VrpqQ2zAvPZkTa7ERhifn9XeR2iPlzzGrp66Zc93DTqcWnVKez0l5Ed94laecgbw
 TdA//MYv2e8fOZIq/VriNVoz4r7YzWSzDX98ZLsnkFp1ZLlY2w9aQssdywoUVDVerZnFZ9NDfNn
 H4QxjoU6EebhWqLZtkGiAm6buHqK/5O2/OKHm20Oheo2zsQoVommAtSKNicG5HpqJ1mCW89wWtb
 x6BrElrwktSOIsOlHgJ1c+J051OQtkDyRzn/Vkk3nZRc39CoQ3GLEUKMY/ft3xM8ctzzDOAOYJn
 OoTKGe2/cJjU4iXFUl0czcsV6mO/vg==

On Thu, Sep 11, 2025 at 10:42:26PM +0800, Lance Yang wrote:
>
>
> On 2025/9/11 22:02, Lorenzo Stoakes wrote:
> > On Wed, Sep 10, 2025 at 08:42:37PM +0800, Lance Yang wrote:
> > > Hey Yafang,
> > >
> > > On Wed, Sep 10, 2025 at 10:53 AM Yafang Shao <laoar.shao@gmail.com> wrote:
> > > >
> > > > This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
> > > > THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
> > > > programs to influence THP order selection based on factors such as:
> > > > - Workload identity
> > > >    For example, workloads running in specific containers or cgroups.
> > > > - Allocation context
> > > >    Whether the allocation occurs during a page fault, khugepaged, swap or
> > > >    other paths.
> > > > - VMA's memory advice settings
> > > >    MADV_HUGEPAGE or MADV_NOHUGEPAGE
> > > > - Memory pressure
> > > >    PSI system data or associated cgroup PSI metrics
> > > >
> > > > The kernel API of this new BPF hook is as follows,
> > > >
> > > > /**
> > > >   * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
> > > >   * @vma: vm_area_struct associated with the THP allocation
> > > >   * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
> > > >   *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
> > > >   *            neither is set.
> > > >   * @tva_type: TVA type for current @vma
> > > >   * @orders: Bitmask of requested THP orders for this allocation
> > > >   *          - PMD-mapped allocation if PMD_ORDER is set
> > > >   *          - mTHP allocation otherwise
> > > >   *
> > > >   * Return: The suggested THP order from the BPF program for allocation. It will
> > > >   *         not exceed the highest requested order in @orders. Return -1 to
> > > >   *         indicate that the original requested @orders should remain unchanged.
> > > >   */
> > > > typedef int thp_order_fn_t(struct vm_area_struct *vma,
> > > >                             enum bpf_thp_vma_type vma_type,
> > > >                             enum tva_type tva_type,
> > > >                             unsigned long orders);
> > > >
> > > > Only a single BPF program can be attached at any given time, though it can
> > > > be dynamically updated to adjust the policy. The implementation supports
> > > > anonymous THP, shmem THP, and mTHP, with future extensions planned for
> > > > file-backed THP.
> > > >
> > > > This functionality is only active when system-wide THP is configured to
> > > > madvise or always mode. It remains disabled in never mode. Additionally,
> > > > if THP is explicitly disabled for a specific task via prctl(), this BPF
> > > > functionality will also be unavailable for that task.
> > > >
> > > > This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to be
> > > > enabled. Note that this capability is currently unstable and may undergo
> > > > significant changes—including potential removal—in future kernel versions.
> > > >
> > > > Suggested-by: David Hildenbrand <david@redhat.com>
> > > > Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > > > Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> > > > ---
> > > [...]
> > > > diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> > > > new file mode 100644
> > > > index 000000000000..525ee22ab598
> > > > --- /dev/null
> > > > +++ b/mm/huge_memory_bpf.c
> > > > @@ -0,0 +1,243 @@
> > > > +// SPDX-License-Identifier: GPL-2.0
> > > > +/*
> > > > + * BPF-based THP policy management
> > > > + *
> > > > + * Author: Yafang Shao <laoar.shao@gmail.com>
> > > > + */
> > > > +
> > > > +#include <linux/bpf.h>
> > > > +#include <linux/btf.h>
> > > > +#include <linux/huge_mm.h>
> > > > +#include <linux/khugepaged.h>
> > > > +
> > > > +enum bpf_thp_vma_type {
> > > > +       BPF_THP_VM_NONE = 0,
> > > > +       BPF_THP_VM_HUGEPAGE,    /* VM_HUGEPAGE */
> > > > +       BPF_THP_VM_NOHUGEPAGE,  /* VM_NOHUGEPAGE */
> > > > +};
> > > > +
> > > > +/**
> > > > + * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
> > > > + * @vma: vm_area_struct associated with the THP allocation
> > > > + * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
> > > > + *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
> > > > + *            neither is set.
> > > > + * @tva_type: TVA type for current @vma
> > > > + * @orders: Bitmask of requested THP orders for this allocation
> > > > + *          - PMD-mapped allocation if PMD_ORDER is set
> > > > + *          - mTHP allocation otherwise
> > > > + *
> > > > + * Return: The suggested THP order from the BPF program for allocation. It will
> > > > + *         not exceed the highest requested order in @orders. Return -1 to
> > > > + *         indicate that the original requested @orders should remain unchanged.
> > >
> > > A minor documentation nit: the comment says "Return -1 to indicate that the
> > > original requested @orders should remain unchanged". It might be slightly
> > > clearer to say "Return a negative value to fall back to the original
> > > behavior". This would cover all error codes as well ;)
> > >
> > > > + */
> > > > +typedef int thp_order_fn_t(struct vm_area_struct *vma,
> > > > +                          enum bpf_thp_vma_type vma_type,
> > > > +                          enum tva_type tva_type,
> > > > +                          unsigned long orders);
> > >
> > > Sorry if I'm missing some context here since I haven't tracked the whole
> > > series closely.
> > >
> > > Regarding the return value for thp_order_fn_t: right now it returns a
> > > single int order. I was thinking, what if we let it return an unsigned
> > > long bitmask of orders instead? This seems like it would be more flexible
> > > down the road, especially if we get more mTHP sizes to choose from. It
> > > would also make the API more consistent, as bpf_hook_thp_get_orders()
> > > itself returns an unsigned long ;)
> >
> > I think that adds confusion - as in how an order might be chosen from
> > those. Also we have _received_ a bitmap of available orders - and the intent
> > here is to select _which one we should use_.
>
> Yep. Makes sense to me ;)

Thanks :)

>
> >
> > And this is an experimental feature, behind a flag explicitly labelled as
> > experimental (and thus subject to change) so if we found we needed to change
> > things in the future we can.
>
> You're right, I didn't pay enough attention to the fact that this is
> an experimental feature. So my suggestions were based on a lack of
> context ...

It's fine, don't worry :) these are sensible suggestions - it to me highlights
that we haven't been clear enough perhaps.

>
> >
> > >
> > > Also, for future extensions, it might be a good idea to add a reserved
> > > flags argument to the thp_order_fn_t signature.
> >
> > We don't need to do anything like this, as we are behind an experimental flag
> > and in no way guarantee that this will be used this way going forwards.
> > >
> > > For example thp_order_fn_t(..., unsigned long flags).
> > >
> > > This would give us aforward-compatible way to add new semantics later
> > > without breaking the ABI and needing a v2. We could just require it to be
> > > 0 for now.
> >
> > There is no ABI.
> >
> > I mean again to emphasise, this is an _experimental_ feature not to be relied
> > upon in production.
> >
> > >
> > > Thanks for the great work!
> > > Lance
> >
> > Perhaps we need to put a 'EXPERIMENTAL_' prefix on the config flag too to really
> > bring this home, as it's perhaps not all that clear :)
>
> No need for a 'EXPERIMENTAL_' prefix, it was just me missing
> the background. Appreciate you clarifying this!

Don't worry about it, but also it suggests that we probably need to be
ultra-super clear to users in general. So I think an _EXPERIMENTAL suffix is
probably pretty valid here just to _hammer home_ that - hey - we might break
you! :)

>
> Cheers,
> Lance
>

Cheers, Lorenzo


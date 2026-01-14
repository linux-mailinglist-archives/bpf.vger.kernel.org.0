Return-Path: <bpf+bounces-78949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E7551D20CBF
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 19:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DC934304F512
	for <lists+bpf@lfdr.de>; Wed, 14 Jan 2026 18:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E96337111;
	Wed, 14 Jan 2026 18:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QlkqvDtQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jttoIhGE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E079B3358BC;
	Wed, 14 Jan 2026 18:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768414994; cv=fail; b=MSy4ikVD1miN7P935ca7c8jDjSRW+7WDQdhmYVlsG/dZiEOwQFlkIvvc+7sIN7KY2lsO/K/Z02jq/SRcAk4vWPHXwZD++EX1sZSRsuwWm/99LCE8DRkbwt5BtjAPJ5hxlby0xYDkPh6hY39KAp9UHJdnVQMJ4OqhaeqnH8UFj0o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768414994; c=relaxed/simple;
	bh=XOs+gWkUe2Eb9BjCxAa/K04He2DZDghABk4ImWXk0+4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WEL1FK2csw2QDWxZzvuh7eWRixZQm1tregLU0+J21ORfXfx+T096G8QMB4vkg9LAmdbNlgVBtfbi7rRGSQN4cxgVCnWeOXTCfoutay901/f8ETyuHUwlDSSmtes/B2gJGLtxh8h4X7LA76EqHcwLIovuieAnV2LM/eHOSrmMC9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QlkqvDtQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jttoIhGE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60EIF1MZ1299107;
	Wed, 14 Jan 2026 18:23:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oguaVnetnBUil45cBAXMTkYje3V0pkvlC2BLn6Iu72M=; b=
	QlkqvDtQxe+6j8zbPyBVSHyagZfBohA89QYUbrfRXoN6KtDtRnJ65jrWjXPWSugX
	4enHsDvU//xf9g30V66LRMWTKtGcpYOHeDMtS2H6Rx1+iXYkq4oTAAphbIl2qlIj
	DVux6DTXzzxF3VQAgdJq20ZEzKLAPwM5rZEac2aN5nhb85Tmv0ZJyJuYSutwtnRo
	dUVjQVPRzthas4eF2iHUkquFCq4I9+X8JdRn7eGOp9wqC0HHUAXMh9AQcifQC8pf
	iLsCKk3krYkBJnshD69F5WUqjyqMvnlXueaOy90AhrbHGluSHKYMgdfNtAIrgcyF
	s6Zfu2zSgs15tvmzo45UaQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5tc10n9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:23:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60EHZ6kP029145;
	Wed, 14 Jan 2026 18:22:59 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013002.outbound.protection.outlook.com [40.93.201.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7m516e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Jan 2026 18:22:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HJrzwSa0WaMS7mD+Z3VQUKP2zuttnanJARllke3k69yOW0GP2odinY7akkv3CbVX6PaJbDBdonZN2fDvXbMFaBZOQ2nAkizYwkmzuXQtu3M8a6CcrUktxe5Lyi/AtnnjZD7PmR86uES7HhpeGNCowWs9VKewIJ97f8g9Ukq+YEkH/2u8H76rnEKLXWzQdmchhOfv8pbuh1ZBOXdNqn1T5OwgC56Ym0nJjD70yA0NVQHYDwykvrokZ1Wv211QOjdX50O59HcUmpRr7+cE1zPNz03CGJRMYQwX6K8VhzNgb9B97euw5crwStO6a8WPGYMCXGyvfQVU0meh53Ikz5OHVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oguaVnetnBUil45cBAXMTkYje3V0pkvlC2BLn6Iu72M=;
 b=FNTZnO4t7IiBsPNex4Poqdw5ZzombrBmmupi/ZoZOQ5lBeqrp0ajO1pEhQx4TpH6+mmRUepsUUy7JIItsxQn5hHSSfVfGU1CHILg+kQg4Kxkgentfq86FRZcxfUdMFzkQVim+3ltUaelWk2dtBLYVkr11yqBuvsn+Ey8a+5an9ZRMnLOhdAffPGUJBKBhMPCIW3SSDlGZoVQs7mzZEIp8GoEFzmhoqQlyCEv8fc4r5iBpQ9e4nQ3sO5/VwgG9m6foiZ2OmmNXWxvCPQcfceF+Q0HgLGqFfBYRaANLAWez2K32CDfx7UJrpokRlEzTLbVOHoBYA2+Ckwooo47JL9jOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oguaVnetnBUil45cBAXMTkYje3V0pkvlC2BLn6Iu72M=;
 b=jttoIhGEVbkiuXk5p63jYXMjttnlsKIeCJMCHOaHsQfwMAQbFqTVQCfFUh5qvy94qCALo91mdYKR/4H9Aj1XNf1sI0lUQxEPAIpkQYy0Scgyn+beKnPxeOP/CeHoRgYZyZG4GQt10VW5g6nJZ7lRg7gVGQEKfWtg3j4LcR0OhjQ=
Received: from IA0PR10MB7622.namprd10.prod.outlook.com (2603:10b6:208:483::19)
 by SJ0PR10MB5694.namprd10.prod.outlook.com (2603:10b6:a03:3ed::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Wed, 14 Jan
 2026 18:22:55 +0000
Received: from IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad]) by IA0PR10MB7622.namprd10.prod.outlook.com
 ([fe80::26db:f0ca:5cc7:f3ad%5]) with mapi id 15.20.9499.005; Wed, 14 Jan 2026
 18:22:54 +0000
Message-ID: <9ad1097b-a450-401b-80ab-9c02a9700ede@oracle.com>
Date: Wed, 14 Jan 2026 10:22:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 3/4] btf_encoder: Add true_signature feature
 support for "."-suffixed functions
To: Alan Maguire <alan.maguire@oracle.com>,
        Yonghong Song <yonghong.song@linux.dev>, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
        bpf@vger.kernel.org, "Jose E. Marchesi" <jose.marchesi@oracle.com>
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
 <20260113131352.2395024-4-alan.maguire@oracle.com>
 <79fac2fa-b5f8-4a7e-aafb-5b80d596db34@linux.dev>
 <0486f774-6e09-483f-8e25-0e440eff1234@oracle.com>
Content-Language: en-US
From: David Faust <david.faust@oracle.com>
In-Reply-To: <0486f774-6e09-483f-8e25-0e440eff1234@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR05CA0010.namprd05.prod.outlook.com
 (2603:10b6:a03:254::15) To IA0PR10MB7622.namprd10.prod.outlook.com
 (2603:10b6:208:483::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR10MB7622:EE_|SJ0PR10MB5694:EE_
X-MS-Office365-Filtering-Correlation-Id: 542a1c48-364f-414b-bb5d-08de5399eed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STdrdkpmS1VsV05QQWpoOVd1UU5mSjB3N3EvYmMzV3ZOOWZpVFFTYVJ4dFJY?=
 =?utf-8?B?VWt6T2hKYnNJY3pFR3diUC9jOGY3aGgwMzFZWnZ6M2VOMit5QWl2UDN0bjg1?=
 =?utf-8?B?QzFPcUxBQnZLVkpFem1BU2hrZEhZdjd0cHhHQjVMNmxpYklVbmdhOVVobjk4?=
 =?utf-8?B?UjFmcTFLTjhhVzh1Q0NwdXJvc2hvT2tic1ZBR2FrZVhvSjdwOWVKdnBuMzdN?=
 =?utf-8?B?bkhVWWtHTVJ0d3NMalRPNmNkYVM3Tk5hRmE3d2J2SjREM0VjQU9zc1NVWTVG?=
 =?utf-8?B?YWxzdytGeGpOVVR5ZVJndDBhM1U0eCs3TzVkeFRQWGlrMnNBWjk1VnB2elJv?=
 =?utf-8?B?TTl2QkxhQmtKajgzRHBIeDBINld3bVk1NHJ1NThLaW5Jb1ptMkxGaVRsVUVQ?=
 =?utf-8?B?amorNzFJdUxrY3JCZDErUFcrc0pOYjdGaHJrOTV5ZGtzQnp4UDdQVUlueSt3?=
 =?utf-8?B?c3pjbHNGa2ZwbXRSblBkMGRXUEt4SnFGNmV0UkNLL0NxVEgwZFpsK3p6UHg4?=
 =?utf-8?B?QjhDd1FEUlBmZlZwb0VUTnVTdld3NkZKZXJVVUFEdVVYMlRXWjMyUEpYdU1w?=
 =?utf-8?B?Zi9ZVFNIeEdQd0hRaGJzVmJJMnVXVTJ3UituS0tkL3EvbS9tUFY4aGJDVy9P?=
 =?utf-8?B?TzlMZEZocXpla1FXWExVSlRJM1ZvVWkvMHpkaWhKSUR4QndoUWNlQ0xkbVJ3?=
 =?utf-8?B?aGQwbTlwOVoxbWN1dXJCcHo0SExDdkdJRG5za2N2KzluNXZkQzh1ZUYxVXMr?=
 =?utf-8?B?ejh1SEJraXN5ckw1anZ1RWkzWnU1c2tkNFowdTZndGVjb1J0L1E1SkYrdmhl?=
 =?utf-8?B?RGpIYmhuTE9nTDRkTkdhOHB5TzZXYmN2TE44MDRDYmpBb1V6YUNYVTBZRUJ4?=
 =?utf-8?B?Rm5CVndqaFZxUW1nQ1Z4dHlvTWtSVGx1OHZzcHI1Y0s2ZWcxdGFMZmcxNWhz?=
 =?utf-8?B?VW4yeDM5dm03VkR2bjFIWEhUbGZtQWpSeERzZEhSNHNsTzQ1Nkk3bnJEV25H?=
 =?utf-8?B?Vzk4RHp2RS9lalpOQTd0NFo4RWNXd1o4UUUvRzJLejhIZHBLT0gzUjgxeXlG?=
 =?utf-8?B?NHdxdnhNWFhXM3NyVDlpQ1A4VHJhcCtodlNhSFB3WHd5cDlmQmFldVdweFpa?=
 =?utf-8?B?UmdIdFRqTGxrcFlWQjJNaWM1L1NvbklsWWZrYXR6VTcwN0dMSkU1MEJjQWFl?=
 =?utf-8?B?djY0NHJveHVzMXVrWU5jYlU3cmF4MllUZk9xV1pIOHhpaitEN2VoZFFVUG5u?=
 =?utf-8?B?SE5tc1FrUXhQeXlXNldZZ2g2TERKM0h6RmxSNHowVE15TUhiS2VxTjhoM25I?=
 =?utf-8?B?TFBsbDBtUVJmUDRtRjY3VndjSDFsQ1Erd1lROFEwNTlRSmtRMHlPc041dmlJ?=
 =?utf-8?B?eWxNOHBZVGRxdXlzODFRb21ndnNKazRpVm5YSHpna0lJZ0JyY1FTVm1GNE8z?=
 =?utf-8?B?cThqZ3VSUmsyVFd5VU5GbmVkT0RwYUtWSmJ6dm92MkswWEZYZ1Q0enNPU3ZD?=
 =?utf-8?B?dElTTmo5ek9oajRXeTRBRUlaMU83N0ExeEtaOVVaOFZ1dWlMR2tnbXZudnI1?=
 =?utf-8?B?d2xzZUdTakwzS0NwZVZ6YWI3WTJlaUIwdkw1UTllNlZtRmczU0RvTjJLbHFz?=
 =?utf-8?B?Tlh6UTAyNEV4VHpkOFRiM1pNc3NZS1pUekNNdHVoRU9BRUNCdk8wQU1mUEhj?=
 =?utf-8?B?VlJaU3E0K0FOak1BNnprdC9SVVZSSjN4TUE4Z25iR3Y3bWxvS0h4K0svOTJw?=
 =?utf-8?B?WWlSQ0Uyci9yL3YxOHozOHRmV1Frc0UwQWJzM2wyMFZEclNZUHBQU1hITGxV?=
 =?utf-8?B?dGVQc1UwRCtJcW5qSEV6RlJSQ0VsdEV5QXF1TWVLVGFqOGhPUDJZUlhLc3Fk?=
 =?utf-8?B?cTgwZ2JCbjJzS0JMN2ZldEt3dHhXVEI3RFpkcjUxbG5jd1pDTFY0d1duT2h4?=
 =?utf-8?B?elp6d09mTktWYWVRRVFnTkkvQ3pYZGV0RVNWMWZHalUzejc0cXBmTFFhK24y?=
 =?utf-8?B?VUNEZFpnamlXaUVsWmdHNFhnaVE0MnphRG1RNlVpbllpeTdsZ3FUdVI4VzMr?=
 =?utf-8?B?N1Q4eThzTHFQNkhXRy9HS0puRmZFZ3Znb0VkY2pMOS9OcytpZmdXdGhNOWN5?=
 =?utf-8?Q?89FI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR10MB7622.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VGJDZVRYNkpJS3JNQXJTaEpRK042Z1lpeGFjYjA4aVdud05OQVF0R0FWZ2RF?=
 =?utf-8?B?SFJQMnQ4Q3plQ1FrVTFndFh5OEZsUkNPOGJmSGJOMVdkMEZkRWZsaDJkZFk1?=
 =?utf-8?B?Q3BJTjhDMUxzYVRvMSs0dmRoWVFBLzhsZHlLVVAxbmRLL3l6cXFJanRKVVJ4?=
 =?utf-8?B?aXJWVUJKMzcxaXlkOGE0SFdka0Q1cnJITVRIY3I0OXN6MUErMmY4YlJvMTda?=
 =?utf-8?B?enJFWWxUR01tMC9OdnhQQ1JOcEZyTmR2TGRvOVNtMTZTNXF6WkNQWHdOVlVp?=
 =?utf-8?B?b25PMnRHLzBVWjNZd3NjZENkSzFXRkV2VG1QeExKY1ZDVy82K0NJNjRiOXk2?=
 =?utf-8?B?YkpPanpzVFloVUVBRnRUVVFQUzErL05HUzNVL2xmcWlQamVQZ1ZxODBLUSt5?=
 =?utf-8?B?VjBpWkQ0TmlERWFJSDBkWW5NYmtobkZTdnZtWlhKZzVkVkV5VlJzbXZUK3ND?=
 =?utf-8?B?aVo3Z09XdmJnaE5KNFRZOG05L0xCdGwxT3RnbmcyTjhDakU3RGdZdzdZSTdR?=
 =?utf-8?B?R3I5T3l2bnI4MVlCQlBPL1J4WHYycVRFVWNNTjMxYUl1YU1NQmdMUzM0Mnln?=
 =?utf-8?B?UTNUajNpVEZVYnlaeFM1MnFzQjRobGpHMTA4MWxLNUkwek1hcWNJVmRBa25N?=
 =?utf-8?B?Mlpzb1dpSFF0NldJNnNGOTk5SkZQR3p0bW13VWMweTBiNGFqckhLUldvSFg1?=
 =?utf-8?B?dHVCYWVicm8zV0xFKzlhUmtFcjdET28vK2NLS2dZMXNiSk9WWlFoYTRPOFoy?=
 =?utf-8?B?UlR6N0g0Y2ZySnA4dnNLVWdpcG8xejJmaVFEOUtGbFl2VHczMW9meG9Ud1hL?=
 =?utf-8?B?UmZTekhSNG9YaDE3cnFERnBGMWlueWlONS9IV3V2Zlpoa0RhVE43dlBWQzcv?=
 =?utf-8?B?U3RKcDcxdzR2YmFvVFB6YjVlKzBvOG1xTzZFWnFKY3IvaXhyWkZyWjMxWGdK?=
 =?utf-8?B?WS9zcEZiUno2U1ZkSkdkeFRRWHdCZWQ1SHlBUTI0Rm4zL1BjRXZtZ3gvc1VI?=
 =?utf-8?B?VlJwdjdMU1FtUFh6VWp2UFFRSE1lZ3luRGU3NE9uVzhCMldZTG1QWmozM0Z2?=
 =?utf-8?B?c3pINUxYaE8ya1JlV3FwM2hYdjdsc091WmdXZTN5V0NZVktUMTV2K01wS3BO?=
 =?utf-8?B?WUNVMXV5clRVVFUzRjdBeExCT09XMGxNWENaRDl2L0JzeVZDT0M3UWZnTU5E?=
 =?utf-8?B?NmtCR3lZYXc0S20rYWtyS0M2ellKWXZYM0RBQ0hBWGtFUnNrTDRJeFUzMEJH?=
 =?utf-8?B?UFhKMnhYOTV5dE9lT1FsQTNSUU5OOVlOWkpaK2ErK1Z4UzhLWWVzT0ZMcGFC?=
 =?utf-8?B?R1hRWXFmOThIRFJXd0ZYSWFHTlFsUWZ4SWhWOFhFbkVzaFBCYng2eU8ycGwy?=
 =?utf-8?B?N2VtdTV5Qk1lK3lROFVaZlF3WUZYR1UzY24yTUFySjYra2NXM2dndjFkZXFw?=
 =?utf-8?B?NTR2VWVuRGJFYTMyeXVicmlUc2ZiTFJHS25RZlVTclRQbHBQemErbjRjRXFD?=
 =?utf-8?B?eHNGdVNVZnhWNUY3cFZnVDU3eEt0VTYycy9Fc3ROaUlMWHJlbEhmL2VPbWZH?=
 =?utf-8?B?eFNyVjUzWjdDelF2cmZFbkZGY3ROT1J0MnhqaDYvSDBxQ1orMjA3MzJhTHli?=
 =?utf-8?B?Rk5CRXAwTjI2RjVmU0RiaU5ibXRQZU1uT204N2l0cWs1SGJzRVFHejExeXJ3?=
 =?utf-8?B?WWN1RVZBU25qYmY1SHVUUVA5SnV4WmJOVVpMVmxTWGt2b2hLUVhORnJzeno4?=
 =?utf-8?B?SW13cENDT0g5TnNyckZReTBJTjRKbTNvMGo1bWtSeHdsYjZKTG1qbVp0WTFC?=
 =?utf-8?B?WG54YTFGVlNCWHpmR3dBL2h0aElXZEhtYVZDb0pnYjljT1NGVWhUWFUyRk1l?=
 =?utf-8?B?emthYjJZU2NFd1hITHJTKzJvdWpFRG4xTGxnTVIxd0hadGN6WDR5NW55Mzgr?=
 =?utf-8?B?WCtxblBvRk1GUVVDSzdLSDRtUHRoUFQ3V2pIbHJzVkU2emtWV3FRdWJIeDhC?=
 =?utf-8?B?bHpiY3VVeGJibkxzUW5BUGkyWnllZ1VwaVZVandudXpyd1YydktJNzRkUXlR?=
 =?utf-8?B?c3c4SWRpWWRMUDNDd1E2YlR4bzRtemJWNTBtajlmcFpONWpPT1Z3TGhjTHZ4?=
 =?utf-8?B?QTBQT3ArRHd3Tlk4S200M1RtNWJ2dGtzMDhXOUo0QlB0bU1UQS9Mc3JhaEdO?=
 =?utf-8?B?b01tdEhQSk1yZjlsZzk3YmQ3ZkdVd09Id0E0akJjeXdEd01mTDAzRENqNHNC?=
 =?utf-8?B?QTNwUWcyeU5XMUQzd1FlZjlycEhWVk5PMzBkc1p2L1V0d212T3RGMlFrSDl2?=
 =?utf-8?B?UVQxV2NaV0QwL0N0eXhtbFRnRUt0Ukt1eHdjczZEeUYwWUdGU0hkUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	f2/fPm3s/hTFS1XgPQ/2KQxyzCRaODvKtbKB2Ci0VuqCtSvibJx/Qkdn4TT7WdudcniACdEy4Qf4wbhSw6AkD26X79P+AHzMUMWW6JEs4DAVr0mTB4wKS4cmRnCK3W4e2jO6TeUCd6MqfMKnXk1kz5gNylXrGogq3/zUTWox0U+3Suf4yi/R81nkNccpAMQQz81Cw6luqyl/7DVEEVIBgqdzobDpZUEWBhPGMCROXEhuywcD8ev+8KVUu2IBvXLuwCoFrTC6wEL+L2B0PQteZepCjQYYpDUt8FPDT4sji3b4W7PtI6q6BgBA3wcZpnXDKEetCiIwBsIIUVUhmjXEoHrKd3bLdcgZ6mcjYInnIc8OF5Lyg54wChTFVC+tNqVu7I7N7EM5N2e/4PCd7qp+VrBKXAtp/V6S5GYvVmNRJb6XUJDMiD7ffR1K2VDnrfUxxoummQxorsjaxWMjB1+8rPZqm7V61urSih2YqMI9Ii5GTezRaa8rNWicaR5FxAuBuVwVR+RkbIVQs0ewOTWXq9d2SMOoWtTuRQQ++eD+/nPUfyx3+//tCfnPcnuz8BN5grOIrV5+9AozN7Ph6G+Dr4BISQyKuUgtYAeXGaUsC5o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 542a1c48-364f-414b-bb5d-08de5399eed6
X-MS-Exchange-CrossTenant-AuthSource: IA0PR10MB7622.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jan 2026 18:22:54.4805
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7OdQapA1eLMkfBMNOicCp3Ie+tZcIRRa6Wls12FS9vEKqMJ3IzHgIHlUd2wJlp77W/oZVJkz1OqNObaE7ktqtQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-14_05,2026-01-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601140152
X-Authority-Analysis: v=2.4 cv=XP09iAhE c=1 sm=1 tr=0 ts=6967df04 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=U7P4Y8wlG3QW_2owxtEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12109
X-Proofpoint-GUID: FOpGzH32mn8UME9Rj9xq6lNitGed1gl9
X-Proofpoint-ORIG-GUID: FOpGzH32mn8UME9Rj9xq6lNitGed1gl9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE0MDE1MiBTYWx0ZWRfX/+VqMs1Q4vDk
 myvn03a+oM1OtP/KiXAi2IjOZvz/cgDWJFhNykick/femwlGDxuhz5kU7/VmMEZO5Ab1sXykKYI
 E/DRVN1YHqi7mxqKzeO/M7HlwLCYgZUCN61TzRKs5F+DdndBdPA8TaxeDwR6DaWaDQl1JTlO0Ty
 ODEVKiKcKkCjFzjyUew9YtifoROJVqhu0/HSpO3V9CB8E2zi2itnVo4eaHFmEBX+dv3xcLQSkJB
 dAWNFL2lutEUoXDDYpFwhcqaYsRmltmD9qyO/EvUaayFWmiVWW1sK1trYw/14YPB7c2+sWuWkIj
 Y3gIPX7oZhhCjjxq35/lMPuxvXdvLalS5tsXsLoPhmpe65uy8LwwCL8dCaI/wVhQb5sPKvQ0WQd
 N3LFD9gyYF37uFfWUjy8hKoz6FHHsbhWh/i/Z9o3C+W0k/cGM6QiDDk/VJW2oaKoPm0tIRxiM9Z
 36zT1kI04vRmbDrWmQ1Vu5uVpwDWaLU3GDZcoQbI=



On 1/14/26 08:55, Alan Maguire wrote:
> On 14/01/2026 16:15, Yonghong Song wrote:
>>
>>
>> On 1/13/26 5:13 AM, Alan Maguire wrote:
>>> Currently we collate function information by name and add functions
>>> provided there are no inconsistencies across various representations.
>>>
>>> For true_signature support - where we wish to add the real signature
>>> of a function even if it differs from source level - we need to do
>>> a few things:
>>>
>>> 1. For "."-suffixed functions, we need to match from DWARF->ELF;
>>>     we can do this via the address associated with the function.
>>>     In doing this, we can then be confident that the debug info
>>>     for foo.isra.0 is the right info for the function at that
>>>     address.
>>>
>>> 2. When adding saved functions we need to look for such cases
>>>     and provided they do not violate other constraints around BTF
>>>     representation - unexpected reg usage for function, uncertain
>>>     parameter location or ambiguous address - we add them with
>>>     their "."-suffixed name.  The latter can be used as a signal
>>>     that the function is transformed from the original.
>>>
>>> Doing this adds 500 functions to BTF.  These are traceable with
>>> their "."-suffix names and because we have excluded ambiguous
>>> address cases we know exactly which function address they refer
>>> to.
>>>
>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>> ---
>>>   btf_encoder.c | 73 ++++++++++++++++++++++++++++++++++++++++++++++-----
>>>   dwarves.h     |  1 +
>>>   pahole.c      |  1 +
>>>   3 files changed, 68 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/btf_encoder.c b/btf_encoder.c
>>> index 5bc61cb..01fd469 100644
>>> --- a/btf_encoder.c
>>> +++ b/btf_encoder.c
>>> @@ -77,9 +77,16 @@ struct btf_encoder_func_annot {
>>>       int16_t component_idx;
>>>   };
>>>   +struct elf_function_sym {
>>> +    const char *name;
>>> +    uint64_t addr;
>>> +};
>>> +
>>>   /* state used to do later encoding of saved functions */
>>>   struct btf_encoder_func_state {
>>>       struct elf_function *elf;
>>> +    struct elf_function_sym *sym;
>>> +    uint64_t addr;
>>>       uint32_t type_id_off;
>>>       uint16_t nr_parms;
>>>       uint16_t nr_annots;
>>> @@ -94,11 +101,6 @@ struct btf_encoder_func_state {
>>>       struct btf_encoder_func_annot *annots;
>>>   };
>>>   -struct elf_function_sym {
>>> -    const char *name;
>>> -    uint64_t addr;
>>> -};
>>> -
>>>   struct elf_function {
>>>       char        *name;
>>>       struct elf_function_sym *syms;
>>> @@ -145,7 +147,8 @@ struct btf_encoder {
>>>                 skip_encoding_decl_tag,
>>>                 tag_kfuncs,
>>>                 gen_distilled_base,
>>> -              encode_attributes;
>>> +              encode_attributes,
>>> +              true_signature;
>>>       uint32_t      array_index_id;
>>>       struct elf_secinfo *secinfo;
>>>       size_t             seccnt;
>>> @@ -1271,14 +1274,34 @@ static int32_t btf_encoder__save_func(struct btf_encoder *encoder, struct functi
>>>               goto out;
>>>           }
>>>       }
>>> +    if (encoder->true_signature && fn->lexblock.ip.addr) {
>>> +        int i;
>>> +
>>> +        for (i = 0; i < func->sym_cnt; i++) {
>>> +            if (fn->lexblock.ip.addr != func->syms[i].addr)
>>> +                continue;
>>> +            /* Only need to record address for '.'-suffixed
>>> +             * functions, since we only currently need true
>>> +             * signatures for them.
>>> +             */
>>> +            if (!strchr(func->syms[i].name, '.'))
>>> +                continue;
>>> +            state->sym = &func->syms[i];
>>> +            break;
>>> +        }
>>> +    }
>>>       state->inconsistent_proto = ftype->inconsistent_proto;
>>>       state->unexpected_reg = ftype->unexpected_reg;
>>>       state->optimized_parms = ftype->optimized_parms;
>>>       state->uncertain_parm_loc = ftype->uncertain_parm_loc;
>>>       state->reordered_parm = ftype->reordered_parm;
>>>       ftype__for_each_parameter(ftype, param) {
>>> -        const char *name = parameter__name(param) ?: "";
>>> +        const char *name;
>>>   +        /* No location info + reordered means optimized out. */
>>> +        if (ftype->reordered_parm && !param->has_loc)
>>> +            continue;
>>> +        name = parameter__name(param) ?: "";
>>>           str_off = btf__add_str(btf, name);
>>>           if (str_off < 0) {
>>>               err = str_off;
>>> @@ -1367,6 +1390,9 @@ static int32_t btf_encoder__add_func(struct btf_encoder *encoder,
>>>         btf_fnproto_id = btf_encoder__add_func_proto_for_state(encoder, state);
>>>       name = func->name;
>>> +    if (encoder->true_signature && state->sym)
>>> +        name = state->sym->name;
>>> +
>>>       if (btf_fnproto_id >= 0)
>>>           btf_fn_id = btf_encoder__add_ref_type(encoder, BTF_KIND_FUNC, btf_fnproto_id,
>>>                                 name, false);
>>> @@ -1509,6 +1535,38 @@ static int btf_encoder__add_saved_funcs(struct btf_encoder *encoder, bool skip_e
>>>           while (j < nr_saved_fns && saved_functions_combine(encoder, &saved_fns[i], &saved_fns[j]) == 0)
>>>               j++;
>>>   +        /* Add true signatures for case where we have an exact
>>> +         * symbol match by address from DWARF->ELF and have a
>>> +         * "." suffixed name.
>>> +         */
>>> +        if (encoder->true_signature) {
>>> +            int k;
>>> +
>>> +            for (k = i; k < nr_saved_fns; k++) {
>>> +                struct btf_encoder_func_state *true_state = &saved_fns[k];
>>> +
>>> +                if (state->elf != true_state->elf)
>>> +                    break;
>>> +                if (!true_state->sym)
>>> +                    continue;
>>> +                /* Unexpected reg, uncertain parm loc and
>>> +                 * ambiguous address mean we cannot trust fentry.
>>> +                 */
>>> +                if (true_state->unexpected_reg ||
>>> +                    true_state->uncertain_parm_loc ||
>>> +                    true_state->ambiguous_addr)
>>> +                    continue;
>>> +                err = btf_encoder__add_func(encoder, true_state);
>>> +                if (err < 0)
>>> +                    goto out;
>>> +                break;
>>> +            }
>>> +        }
>>> +
>>> +        /* True symbol that was handled above; skip. */
>>> +        if (state->sym)
>>> +            continue;
>>> +
>>>           /* do not exclude functions with optimized-out parameters; they
>>>            * may still be _called_ with the right parameter values, they
>>>            * just do not _use_ them.  Only exclude functions with
>>> @@ -2585,6 +2643,7 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
>>>           encoder->tag_kfuncs     = conf_load->btf_decl_tag_kfuncs;
>>>           encoder->gen_distilled_base = conf_load->btf_gen_distilled_base;
>>>           encoder->encode_attributes = conf_load->btf_attributes;
>>> +        encoder->true_signature = conf_load->true_signature;
>>>           encoder->verbose     = verbose;
>>>           encoder->has_index_type  = false;
>>>           encoder->need_index_type = false;
>>> diff --git a/dwarves.h b/dwarves.h
>>> index 78bedf5..d7c6474 100644
>>> --- a/dwarves.h
>>> +++ b/dwarves.h
>>> @@ -101,6 +101,7 @@ struct conf_load {
>>>       bool            btf_decl_tag_kfuncs;
>>>       bool            btf_gen_distilled_base;
>>>       bool            btf_attributes;
>>> +    bool            true_signature;
>>>       uint8_t            hashtable_bits;
>>>       uint8_t            max_hashtable_bits;
>>>       uint16_t        kabi_prefix_len;
>>> diff --git a/pahole.c b/pahole.c
>>> index ef01e58..02a0d19 100644
>>> --- a/pahole.c
>>> +++ b/pahole.c
>>> @@ -1234,6 +1234,7 @@ struct btf_feature {
>>>       BTF_NON_DEFAULT_FEATURE(global_var, encode_btf_global_vars, false),
>>>       BTF_NON_DEFAULT_FEATURE_CHECK(attributes, btf_attributes, false,
>>>                         attributes_check),
>>> +    BTF_NON_DEFAULT_FEATURE(true_signature, true_signature, false),
>>>   };
>>>     #define BTF_MAX_FEATURE_STR    1024
>>
>> Currently, in pahole, when checking whether signature has changed during
>> optimization or not, we only check parameters.
>>
>> But compiler optimization may optimize away return value and such
>> information is not available in dwarf.
>>
>> For example,
>>
>> $ cat test.c
>> #include <stdio.h>
>> unsigned tar(int a);
>> __attribute__((noinline)) static int foo(int a, int b)
>> {
>>   return tar(a) + tar(a + 1);
>> }
>> __attribute__((noinline)) int bar(int a)
>> {
>>   foo(a, 1);
>>   return 0;
>> }
>>
>> In this particular case, the return value of foo() is actually not used
>> and the compiler will optimize it away with returning void (at least
>> for llvm).
>>
>> $ /opt/rh/gcc-toolset-15/root/usr/bin/gcc -O2 -g -c test.c
>> $ llvm-dwarfdump test.o
>> ...
>> 0x000000d9:   DW_TAG_subprogram
>>                 DW_AT_name      ("foo")
>>                 DW_AT_decl_file ("/home/yhs/tests/sig-change/deadret/test.c")
>>                 DW_AT_decl_line (3)
>>                 DW_AT_decl_column       (38)
>>                 DW_AT_prototyped        (true)
>>                 DW_AT_type      (0x0000005d "int")
>>                 DW_AT_inline    (DW_INL_inlined)
>>                 DW_AT_sibling   (0x000000fb)
>>                                                                                                                     0x000000ea:     DW_TAG_formal_parameter
>>                   DW_AT_name    ("a")
>>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
>>                   DW_AT_decl_line       (3)
>>                   DW_AT_decl_column     (46)
>>                   DW_AT_type    (0x0000005d "int")
>>                                                                                                                     0x000000f2:     DW_TAG_formal_parameter
>>                   DW_AT_name    ("b")
>>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
>>                   DW_AT_decl_line       (3)
>>                   DW_AT_decl_column     (53)
>>                   DW_AT_type    (0x0000005d "int")
>>
>> 0x000000fa:     NULL
>>
>> 0x000000fb:   DW_TAG_subprogram
>>                 DW_AT_abstract_origin   (0x000000d9 "foo")
>>                 DW_AT_low_pc    (0x0000000000000000)
>>                 DW_AT_high_pc   (0x0000000000000011)
>>                 DW_AT_frame_base        (DW_OP_call_frame_cfa)
>>                 DW_AT_call_all_calls    (true)
>>
>> 0x00000112:     DW_TAG_formal_parameter
>>                   DW_AT_abstract_origin (0x000000ea "a")
>>                   DW_AT_location        (0x00000026:
>>                      [0x0000000000000000, 0x0000000000000007): DW_OP_reg5 RDI
>>                      [0x0000000000000007, 0x000000000000000c): DW_OP_reg3 RBX
>>                      [0x000000000000000c, 0x0000000000000010): DW_OP_breg5 RDI-1, DW_OP_stack_value
>>                      [0x0000000000000010, 0x0000000000000011): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>                   DW_AT_GNU_locviews    (0x0000001e)
>>
>> 0x0000011f:     DW_TAG_formal_parameter
>>                   DW_AT_abstract_origin (0x000000f2 "b")
>>                   DW_AT_const_value     (0x01)
>> ...
>>
>> Assembly code:
>> 0000000000000000 <foo.constprop.0.isra.0>:
>>        0: 53                            pushq   %rbx
>>        1: 89 fb                         movl    %edi, %ebx
>>        3: e8 00 00 00 00                callq   0x8 <foo.constprop.0.isra.0+0x8>
>>        8: 8d 7b 01                      leal    0x1(%rbx), %edi
>>        b: 5b                            popq    %rbx
>>        c: e9 00 00 00 00                jmp     0x11 <foo.constprop.0.isra.0+0x11>
>>       11: 66 66 2e 0f 1f 84 00 00 00 00 00      nopw    %cs:(%rax,%rax)
>>       1c: 0f 1f 40 00                   nopl    (%rax)
>>
>> 0000000000000020 <bar>:
>>       20: 48 83 ec 08                   subq    $0x8, %rsp
>>       24: e8 d7 ff ff ff                callq   0x0 <foo.constprop.0.isra.0>
>>       29: 31 c0                         xorl    %eax, %eax
>>       2b: 48 83 c4 08                   addq    $0x8, %rsp
>>       2f: c3                            retq
>>
>> $ clang -O2 -g -c test.c
>> $ llvm-dwarfdump test.o
>> ...
>> 0x0000004e:   DW_TAG_subprogram
>>                 DW_AT_low_pc    (0x0000000000000010)
>>                 DW_AT_high_pc   (0x0000000000000022)
>>                 DW_AT_frame_base        (DW_OP_reg7 RSP)
>>                 DW_AT_call_all_calls    (true)
>>                 DW_AT_name      ("foo")
>>                 DW_AT_decl_file ("/home/yhs/tests/sig-change/deadret/test.c")
>>                 DW_AT_decl_line (3)
>>                 DW_AT_prototyped        (true)
>>                 DW_AT_calling_convention        (DW_CC_nocall)
>>                 DW_AT_type      (0x00000096 "int")
>>
>> 0x0000005e:     DW_TAG_formal_parameter
>>                   DW_AT_location        (indexed (0x1) loclist = 0x00000022:
>>                      [0x0000000000000010, 0x0000000000000018): DW_OP_reg5 RDI
>>                      [0x0000000000000018, 0x000000000000001a): DW_OP_reg3 RBX
>>                      [0x000000000000001a, 0x0000000000000022): DW_OP_entry_value(DW_OP_reg5 RDI), DW_OP_stack_value)
>>                   DW_AT_name    ("a")
>>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
>>                   DW_AT_decl_line       (3)
>>                   DW_AT_type    (0x00000096 "int")
>>
>> 0x00000067:     DW_TAG_formal_parameter
>>                   DW_AT_name    ("b")
>>                   DW_AT_decl_file       ("/home/yhs/tests/sig-change/deadret/test.c")
>>                   DW_AT_decl_line       (3)
>>                   DW_AT_type    (0x00000096 "int")
>> ...
>> Assembly code:encs 
>> 0000000000000000 <bar>:
>>        0: 50                            pushq   %rax
>>        1: e8 0a 00 00 00                callq   0x10 <foo>
>>        6: 31 c0                         xorl    %eax, %eax
>>        8: 59                            popq    %rcx
>>        9: c3                            retq
>>        a: 66 0f 1f 44 00 00             nopw    (%rax,%rax)
>>
>> 0000000000000010 <foo>:
>>       10: 53                            pushq   %rbx
>>       11: 89 fb                         movl    %edi, %ebx
>>       13: e8 00 00 00 00                callq   0x18 <foo+0x8>
>>       18: ff c3                         incl    %ebx
>>       1a: 89 df                         movl    %ebx, %edi
>>       1c: 5b                            popq    %rbx
>>       1d: e9 00 00 00 00                jmp     0x22 <foo+0x12>
>>
>>
>> The compiler knows whether the return type has changed or not.
>> Unfortunately the information is not available in dwarf. So
>> BTF will encode source level return type even if the actual
>> return type could be void due to optimization.
>>
>> This is not perfect but at least it is an improvement
>> for true signature. But it would be great if llvm/gcc
>> side can coordinate to propose something in compiler/dwarf
>> to encode return type change as well. In llvm,
>> AFAIK, the only return type change will be
>> 'original non-void type' -> 'void type'.
>>
> 
> Yeah, we dug into this a bit on the gcc side with David's help and it 
> appears the only mechanism used seems to be abstract origin reference 
> unfortunately. It seems to me that in theory the compiler could encode 
> the actual type for return types and any parameters that change type
> from the abstract to concrete representation, and we could end up with
> a mix of abstract origin refererences for the types that don't change and
> non-abstract for the types that do.
> 
> David, Jose, I'm wondering if the information is available to gcc to do 
> that at late DWARF encoding time? Thanks!

Yes, at least to some degree.  For non-inlined cases, I don't currently know
of a case where we do not have the information.  For inlined cases I am
less confident that it's still available.

I spent some time looking at this last year, thinking that we could at least
use this to improve gcc-emitted BTF with the final signatures for non-inline
funcs, even if there is no perfect way to encode it in DWARF.

For example, I have:

  __attribute__((noinline))
  static int callee (struct tcphdr *tcp, int x, int y)
  {...}

In this case both the return value and the param 'x' are dropped by
optimizations. 

At late DWARF time we have a function_decl node for the optimized version
'callee.constprop.isra' which has a return type of void and arg type list
reflecting the remaining two parameters.  We can also get a pointer to
the original pre-optimized decl to compare against. i.e. we have both:

  callee.constprop.isra
    return type: void
    arg types:   struct tcphdr*, int, void 
  callee
    return type: int
    arg types:   struct tcphdr*, int, int, void

This also extends to more complicated cases where IPA-SRA splits
aggregate parameters into individual pieces (e.g. split a pass-by-value
struct into only passing the relevant fields which are used).
I think some of these transformations are not always reflected in DWARF.

For a simpler case like the one here, it is currently reflected in DWARF
via the abstract_origin subprogram DIE for callee in which only the
remaining two parameters have concrete AT_location.
(Although IMO it is rather ambiguous whether the abstract_origin DIE's
 lack of AT_type means "return type is unchanged" or "return type is void")


> 
> Alan



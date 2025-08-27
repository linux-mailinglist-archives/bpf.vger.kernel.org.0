Return-Path: <bpf+bounces-66661-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60C5FB3838A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:15:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457327A915A
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 13:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 892D728F1;
	Wed, 27 Aug 2025 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DB2mZn2Q";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QGo5FpAv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB45212D83;
	Wed, 27 Aug 2025 13:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756300538; cv=fail; b=jcQOhNEWprxRep7SZWk09ymaxRYAoRN9TCPLZY+rFyj+S0d8knINHHohYvWqHkGa8bgvJ6vTif2cQ0VD7wCNieZH8U1inz5rRJ5BXHL67d3z3Q7mLCzeKTm1XD9fXcJukA/fZrnVWqAXXkLywhtFHBHXh3wPz1oOrfvsuWAklRY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756300538; c=relaxed/simple;
	bh=ED49BZmWr9jwa+wGBwzMiTERUFABFoQ+t01W1uoa7zU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SU2I0D0xfn5vZJ3zh5c/wpnm8UfkhHNxuQwYwK97NhrTydLDhddReY4A4U8Kk4iY3lIjiLoLxATpqVzZh80rmAJYV/KZiDk1uAmvHcIH5eExRqC8jUSBs0pea6xoB2fF11M55AOXAIcjCHFf9GVNgyknyl8M9ppwr9XkDY35xpg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DB2mZn2Q; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QGo5FpAv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7uAoE008720;
	Wed, 27 Aug 2025 13:14:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=hyJXhW1MD2hd6Y3Nm7px/Ou2Ze33ZHFVYos2ib/nBKQ=; b=
	DB2mZn2Q3zCyuHr3cO5u0+pB0DDC4uX7UG7bQoIRQZFYiyeC6gV+AoKmlOOAhbEz
	F4eWF1rv4/+3tmQo0I3jxqibOYg48J2ScZmFTDxQI8Y8gs/X981ya73fZu+xSZ9c
	R4RI2G03Z5jn5JZNir6p8VafB5rZ0t9tQws3TcM/Dz2Q003fsBTWLJrrM1RwvaQ9
	YuEPoi4g5ORKWQ1W7qE3sWrhlAc1flR6YtznzAH/Hf32w9N3ycbTt4hUH3fkhC96
	LClzmdK4zkf7Bs0jMeF9IMkgAW1t4Rr7kXntlYx4z3WSj/XZnuLF6ALgSNYE7tBt
	/eQ0N0fIg1r/YZHBkmohZQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt6gmx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 13:14:34 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RD4Z9Q012331;
	Wed, 27 Aug 2025 13:14:34 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2066.outbound.protection.outlook.com [40.107.244.66])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43an0m6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 13:14:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WSsIQMAlE7pF9Sj7v0xEHz8P28+eQmdearVKn5Y4VaR8O46g8fWz2U6vRDIc3yhatBXqckG97Ix2/IFPWTHzyFbJbeT6tt8IJW97WAH2MBAo6AzGvk8HcAvJhGucm97OsbELSxSQkYBq0mBCg01omg8PK1KO8xhkpvUV8IUYPu3bEA5q2JBCwzzu5QbRhYVgQDsg56fCwWMhy4zOfT89HxwT1F6EajD+zMmgf8GIixkcV6Jw2uW2v14oRpJVQmH7RcBYeWCbxwvmHy+JtC+aoNEIttdo9xXLnN48AQU2MnUN04ybTiCsdHo0hpduxYTTShPY3Dxh64xLE/+4IpUgMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyJXhW1MD2hd6Y3Nm7px/Ou2Ze33ZHFVYos2ib/nBKQ=;
 b=fFG+8PU5jL22PCye07DUZL8jY/l+Eq7FxgLysiF146EIH6yZOxe9XpuQEqE7O/u0ILpFsiNtDOuZsZEeblGdzz/8pEmWLw+KhIElMHMNO5TVodvXN0fxMtMrjgLELagOJeW1g5hyBdr19T7zd2cUpRqGurezQTta1/2OQeCGMjzB7P41AM+vScgdUW7tp4Rn/1duYM/BsI0DAyJx86xlwgu57HBirLBky9UQuJkzKxKMPNmj39ZHYA/9GJODA2aKsfPs9gxt1JGg7Y1LJlWgbw8CtqutM7sHQZvk36vaJD9E7Xuayk+FxE5nYovlAoXMM7K/LFHPsfD4HmthA+n/5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyJXhW1MD2hd6Y3Nm7px/Ou2Ze33ZHFVYos2ib/nBKQ=;
 b=QGo5FpAvsXh2fYoOUJolJeqbW8tzSXakHUR70zIdtlAWJRjQYx1A9qRJqHXqrYJVlUvisECzzJahd7hKFF3IDxJ9WyDQULPs5mW3HRmxNujdqODRYkhAlWt4iTK3W9tBUKrjKazwi3itq97ju5zWiJeLFG3NK3PhG2oTboznnY0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH4PR10MB8003.namprd10.prod.outlook.com (2603:10b6:610:240::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.13; Wed, 27 Aug
 2025 13:14:30 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 13:14:30 +0000
Date: Wed, 27 Aug 2025 14:14:27 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 00/10] mm, bpf: BPF based THP order selection
Message-ID: <06d7bde9-e3f8-45fd-9674-2451b980ef13@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250826071948.2618-1-laoar.shao@gmail.com>
X-ClientProxiedBy: LO2P265CA0092.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8::32) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH4PR10MB8003:EE_
X-MS-Office365-Filtering-Correlation-Id: fd55dfb1-9c71-481f-5df1-08dde56ba83e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?b1JPQkdNWG1FWGFqQXRSVzRCSXdQUmdoSG9zUzBUSHozMEZZWDdoL1NlcGVk?=
 =?utf-8?B?NjAybEIxYzloZGJ4L0RjQmwxMng5NkowSHBYcVphTVpsV1AyTmFNTkVIL2VT?=
 =?utf-8?B?S3lWYXpwRE9lMzZoWlVTeHMrMDVkbk43UGZLRUdLcUY0dndxYmt2eVBvU0pC?=
 =?utf-8?B?aFVKdXRTZ0ZaZlRPbENBc2FLVDEyRytBa082KzhjZElZbzFkSjBlUnFsZkxG?=
 =?utf-8?B?VVNvd0FHRTh1c05oRlRoTW9ySmt5T3dvUjNJZHlHREdNZmsrcXRqTTM2Wm8x?=
 =?utf-8?B?YTVMOHAyOXBUT1c0am1rSEdKci9tbElmU1laNVZLY3VRYUV1NmNWajVXT1Ay?=
 =?utf-8?B?WklHNHpRVE8xU2hkbHFQNUQxWDVTNS96enl5VXZpMjRXVC92MmRZYVVVbFFr?=
 =?utf-8?B?c1NHcytWNVd3STR1Skc4eUE1UmVKK2NHR3h6Q1RvQVUxMzF5MEJ3MmJyWjFN?=
 =?utf-8?B?cFpJQWxlUTJWckxYSnNGN1F4cGZiSVYzalorSG84TDAvUlk5TkZ1YUQ5b3V0?=
 =?utf-8?B?djFVdGZQL2M1aG94ZmlyOFdueFFFNjdLVkIvejB0THlURzdCMUwxdDR4TzhR?=
 =?utf-8?B?V3pobUJNeUhidWhwTmNYL1Z2TURmY0ozTWw1K1o1RGlpUFoyUDBvRU0zcjNo?=
 =?utf-8?B?YlIrMFA2WXZJcXRPRHErajZuWnNrWlBzb1RTV09FdEZSU254RDU5NEpkUTlU?=
 =?utf-8?B?dndRaU9vLzNoVFYvVGNkbld1VEcvZnVFQTBwYXZja3MzOWVYWVhGVGZ1dkt2?=
 =?utf-8?B?Wkx6SHRLdEo3N1BpRHA1cjVJTlZRaDJ3dVA0amtJQmtuejduTmQyZ2N3bjk3?=
 =?utf-8?B?LzRYeW9jWFdSMjdOejNtdXIzM0dReHF0S3JZQnpHcTNGNmxQZHZnQWJISWgr?=
 =?utf-8?B?UkZBeHhHVXUzZ0xSaWdvODZWaXYwa3lkdDMzblBzY2plcFJwa215Q3ZReHpz?=
 =?utf-8?B?WmRmbVo4SDJCb25qY09WUUZ6NHRvNjlRSERNM1JhTlVaYlhBS3luTmFRR1I0?=
 =?utf-8?B?WDJXWlI2MFZsTTRVNXJ2d0I2QjZYODN4V1BrUGtnWVlqRko4TVdMcmltbitK?=
 =?utf-8?B?ZmQvWkNDQjZNbVAvSktnQk8yMnJnaGhnUi9wZzJmTWtIU01hc1hiM1VUVnpn?=
 =?utf-8?B?UWZRRWpSbnBQaXFMVERJVGNhVWVNTnJUOEswWTJzdzBCeHpzSjNrSjg5K2Zt?=
 =?utf-8?B?NVIwUlhLVWxJK0xvUncxekZRTnNlYWtIWFViQVh6UTJESjB4MDFoTHZudFhK?=
 =?utf-8?B?MFltR3k1dTZKRWRENXFZbWJRY1lqUHBSSVlKd01jdjBlcTgyZk1GVmRsTmc3?=
 =?utf-8?B?bXo3WjhZUUFJOHBPTHc3WklnbllZRm5UMklRTVdiYWlZcTR1SzJXYThOQ3NY?=
 =?utf-8?B?RnlwSzR2VFNCckFZVko3cjlOeW4rRmk4UlVqRS84SUVIbGRVb2pCMm80ZlVK?=
 =?utf-8?B?ZG5ORG5ORlE2bUF5Q25KVFl4Z1VmajFkeFhnM2x5amIxU2htdEJzaHlVZjND?=
 =?utf-8?B?by9hbkJMcVEzN0hQVjNOL2NoQzVJRFdKQmFRWWVQdmM4RXhVazJTd3k0akpP?=
 =?utf-8?B?WURzekVPaVg4U3JoRmRVRjQzMk92VVQ2RU5ZRExSbVZ6Z01LSW1ZZEtaYWdQ?=
 =?utf-8?B?Q3FxTGp1eCswZkQrYVM0SDBBTVVaRkJFeVRVNmY1NUZDUHp0ZVh3M2ZhODBV?=
 =?utf-8?B?YnFGMHNTNVNRMXltNUR5eE1SZVdaZjhGR3ZBT3hpL0RoR1owcHdLWTVJVndw?=
 =?utf-8?B?SW5iaEkxUEdNR1Z4S3VmV1VqYndBRWZjRkJQUUoyKzh0ZEh1TXhzZXYvTVR6?=
 =?utf-8?B?QmdMRVVOR2RrTmhkZy9QKzk5ZWEwcEVWZFA0Sktpb2FFUUhmNURVTW52dkxq?=
 =?utf-8?Q?zOaXrFpbRRdbu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?QXNFVlU3SG1VMERLdm9TdFBvOTBmYm1MY0VMQkF4VXJFMVd6WHhZT0J2RFVS?=
 =?utf-8?B?bFJlWG5aUThoMHFZR3V2cmRjeGpFSktyQTlKc2h3S2ZmMGpMSWVCVTJ2YnpS?=
 =?utf-8?B?eC9jUkxDTnJ0U21YTlV1TlRsSkZVWXBPQmpXcWZMVTJXVWtXS1NTeElWS09z?=
 =?utf-8?B?Q0Nua2JaNXEzV0NhKzIvTmpmUG94MkIyQzRYWlNQTlhaWU8xOGxxNDg0bDVt?=
 =?utf-8?B?Wis3Tmd5Sk9hNEVxU0FoeW53d2xqWnYydGRrREdSdDRabG1BNHhkd0JIR0hi?=
 =?utf-8?B?UWdtNUIxT3k0L0NaTmdzUWI3MFhpZFJPQmNQajZFUEVqeEEwRE9FRmIva2NO?=
 =?utf-8?B?OXREWGMvRmhjMTVvVm4zWTRYZEI2THdQRE9va1JSZG9QNkJTUmY2ekM2VzRL?=
 =?utf-8?B?YzIxbVpUQk1DZG5xZlJrSDZxUjRnQUJkdnBTREk2ZjlnTVlaV2JEcE9iNE5i?=
 =?utf-8?B?amxkcmtmOEkxTHplVGp2enZnMjFhUXpWMzVrQ3VlNGtrL24rNmxmRjlOQmlO?=
 =?utf-8?B?RlZQQTlod0xjSy9aV1dzdEhKSGxEckFzOVZBQ3A0ZnBDb1NUdHg3VU1uYkNo?=
 =?utf-8?B?b2FZQkUzdUtCeXVxcWxoYTJDQXhKZEZOSUk0VHV1U09RcEhWUzM1Vm9CeHNO?=
 =?utf-8?B?dWMva3lQWHFpUHJ0QjNxMzU3REhUYWxpYnVsb2JHS0wwU21NUHdxSTYzQjg0?=
 =?utf-8?B?TUVFZzNyd28relJWS2dlT29LOXFneGI3MnhiUTZSQ3J6UG1yVk5sQWNCaGJw?=
 =?utf-8?B?aXdPQnIyOHk4SEhJWHV4cjNIbG5GZ2wwN2txSWdFajBkMmVMdnFnWllQQWJJ?=
 =?utf-8?B?LzRpeXFPcEx2UHRGRUc3S3lEMVN4eDNzY0lodkhKc0xZU1VLZzhKRzcxNDRK?=
 =?utf-8?B?M1p3dDVTNGpwWWhGdTE4bTNsNjVMZWo2djRxY3NObkY3cEx4NEtRbWhOdTlD?=
 =?utf-8?B?UG4yREhwSm84N0s2b1FUcjJDei9JS3plNVA5anBSRHpCazFET3FFL0NENGd0?=
 =?utf-8?B?M2d3NXl5TjhpRUZDOGJrNWdtanc5eVZySmQvQVB6bklVZVZCdDEwRGZhZGFu?=
 =?utf-8?B?ZXlCRmZIOCsrb1g3dUw1MkZqNWRodTIzNjdUY0JjTFhyVGFxOVJ6SUN5ZEli?=
 =?utf-8?B?QVRiYnVwdUlaTUZOb0dGY0dwbVdJbjQvY2Q2b2plcEpxb3FiTm9RQU8wSHhH?=
 =?utf-8?B?R1ZCT2FrcG9DV05RRC80V083cHF5YkkzMUZaUWpqdXpGVVQ5WHd0dmVVZWRF?=
 =?utf-8?B?d3g4N1NIV2lRWDd5bk14UXlQdER6dldUQUNjQkltZkdRUVdNL0RZcTh4OHR5?=
 =?utf-8?B?ZEw1dnBKUndBUjZ2OG5KUVp4ZmR2L0JKQ01DZXhXem54ZWQ3S1dmNDZYMTRS?=
 =?utf-8?B?N1Q2UWE4enNHZkk1dStyb2IvV0p6cURmQVVvUWJ6N1ROQnJpa1RuWFNlNmNn?=
 =?utf-8?B?UVQ2WGgvWHNnOElwemx5Q09xREdZTlpJdmluMlJCUy84WWF0dVIrYytreHJQ?=
 =?utf-8?B?ak5PV0NWalIvVS93Q2RaajdCVE9MMkd2Y1RpT1VRcEdTWEw4TFE0UE5NVFhK?=
 =?utf-8?B?NkYzTldRQkJ0dTJLTWg3Y0pIL09CTmNKeWFiNi9jZ0V1bE1SblRJVWdUejUw?=
 =?utf-8?B?U0RIbVpPQXZFcHNBYTNiRXY3MW1PT0IzclBjbmQwTXgzeHhXMXB5UzNhU3dx?=
 =?utf-8?B?Q1dKcHpOL0huODQ1S3o3RHNlNi82dUk1NnM1dXlQeGh0RHNXMWVIVVU3ejhs?=
 =?utf-8?B?djcyaW16UVZRNXFUUDBXYUx2WXQxdUovbFNTL0NIWlRxUm9hSXhiWmxaQ1dn?=
 =?utf-8?B?NTdjVnRpSVZaU0J2cnJ1akhwWXNRTS9JMXNwME1vYWtNM1pBZEZ6aHRzSjNF?=
 =?utf-8?B?TDJFZnA2cW9QZW9LdE5GZVliaVd6amhqNW1ET1BPRVk2d0M2YWl5UVhEdjk1?=
 =?utf-8?B?L3daN2JqeVBsWVFvN1RSSVo2djk0VkMvUXpCL3dHV2kvaUxVeTVpUjBycUlq?=
 =?utf-8?B?OGhGSTNnVy9BaURwNzFIWWhKSnBHVlUzc0VHSnJnR2dJZ05kZlJmL3dQN0gz?=
 =?utf-8?B?T1IwTlIvbTBONVNscFR3Y3gvRjIrQzN0emV2VTNSRTIyU3JMMTNPbVVlWDFn?=
 =?utf-8?B?dmhxQmM0SnlndEo4Tk9wa0RDY1huWTc3OEN1VzB3cGJVeXJlcVBhaXRxc3VX?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7onRB4aSPCm4FwJ5HgsWp2JkSE8AX9SVGX7LdJEuTSvyCUenVQTksjGSf0vZWkKL9dUjN/FSU9+2yS4om0TF5sUU6cX+vVt84Se0FMRRVEwEHj0ztFYHXsLWuzU1MzLGxpgJWhFj8G0oUpZLj9UVsyK+tWbqJFf37xNp1hjzMMGZIpNsX6ztZs51ey5hU6IX4IiEw2Nkb/IeQlwQMzEBjDh7EDhnbIcw05mEvOjodbqcOaz9WII8ZyczBQDoEnXFZSml0kU1dO3DoRbZAgZh4E9mAC39PKJpnmzmxbUIxOAx1ZIkSGx997FUho0Ea7Kf9YcB9PhrJjqhnb7imcJJVaGR3iTfOddX/zzYKGK04zTNDT6hfeSYbAUpkaLOh2IrQN+e6kenMCfGq9gwPUhvTAWUITnmz4zpvr+CTo9+9RmNradAkCgezqOhHL/TIw4Pwj3UJ7abYjjEReMBcosmKTqLUvsjAH5gO7VUu8hYQZdoX7DpISiXFQOivBImqncWFbRBy/oVs2hvlW6yM0fInbHyCKXW9v1eLvI+MEek3nI3tD7CfzG53P3gc8AHBvFSXwjmdigySYSRfs5CPFxDKgmfGa9tLilInq0XhvK/bzA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd55dfb1-9c71-481f-5df1-08dde56ba83e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 13:14:30.5148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: L06BjVWLKe8AAJWzeLiFC8ox+fnLvwT+5jPkGBNkMDEQdxco6AXZbv52SF1BQYUtRBt8Ci6WpuBSLU0agdQmGj8tPq7xy7Ev2A4gy34nqO4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_03,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270113
X-Proofpoint-ORIG-GUID: -N9F9sWj9SiLaFc-p8iQ5f2iFwaNMaTW
X-Proofpoint-GUID: -N9F9sWj9SiLaFc-p8iQ5f2iFwaNMaTW
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68af04ba b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=07d9gI8wAAAA:8 a=20KFwNOVAAAA:8
 a=NEAV23lmAAAA:8 a=pGLkceISAAAA:8 a=pqtBnG_gAAAA:8 a=MCc6aL20a-eiWrZqb7EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=e2CUPOnPG4QKp8I52DXD:22
 a=dozIAI4aeI13xyvB2pX3:22 cc=ntf awl=host:12069
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfX+HMS5oGfs30w
 FtHVoCi+FN6E+J36KZgKIGY9QaQ4Ze4FvzCAD/S8h9ZrZTQABN7eCIR08eoPCsJBuztK8+pqWKA
 41Cks5tlhmBc19XZq0N42Z68MUQPOT6L7YBD1nTTTEREcNwJyKzVebNL8cKlFjV+XSsZ7M/h2fa
 rbzHZ5V+S3S6ybDZw8zFAxy4dZ8oIItXbhE3+IHMBKng7EK5SX3Ts8bRYq4R4cv9HHlL90t77EQ
 dxKBaZnmLJWTJr2Ar7Pp3YNvFc8LwY1y8N5ZiEXBIi2Tw6/p7YAtLmNILYXnDpULqYRsaIE2GQl
 +O1rh/AYBrYJh3R64kGcS6bY7NH5M9Azgtb50Gz7W1UF88dnwQGjR+NkNeveHYiBeappzlSOs0Z
 BlGA19QMJDyDY+hcF1on3YIK8fxocA==

On Tue, Aug 26, 2025 at 03:19:38PM +0800, Yafang Shao wrote:
> Background
> ==========
>
> Our production servers consistently configure THP to "never" due to
> historical incidents caused by its behavior. Key issues include:
> - Increased Memory Consumption
>   THP significantly raises overall memory usage, reducing available memory
>   for workloads.
>
> - Latency Spikes
>   Random latency spikes occur due to frequent memory compaction triggered
>   by THP.
>
> - Lack of Fine-Grained Control
>   THP tuning is globally configured, making it unsuitable for containerized
>   environments. When multiple workloads share a host, enabling THP without
>   per-workload control leads to unpredictable behavior.
>
> Due to these issues, administrators avoid switching to madvise or always
> modes—unless per-workload THP control is implemented.
>
> To address this, we propose BPF-based THP policy for flexible adjustment.
> Additionally, as David mentioned [0], this mechanism can also serve as a
> policy prototyping tool (test policies via BPF before upstreaming them).

I think it's important to highlight here that we are exploring an _experimental_
implementation.

>
> Proposed Solution
> =================
>
> As suggested by David [0], we introduce a new BPF interface:

I do agree, to be clear, with this broad approach - that is, to provide the
minimum information that a reasonable decision can be made upon and to keep
things as simple as we can.

As per the THP cabal (I think? :) the general consensus was in line with
this.


>
> /**
>  * @get_suggested_order: Get the suggested THP orders for allocation
>  * @mm: mm_struct associated with the THP allocation
>  * @vma__nullable: vm_area_struct associated with the THP allocation (may be NULL)
>  *                 When NULL, the decision should be based on @mm (i.e., when
>  *                 triggered from an mm-scope hook rather than a VMA-specific
>  *                 context).

I'm a little wary of handing a VMA to BPF, under what locking would it be
provided?

>  *                 Must belong to @mm (guaranteed by the caller).
>  * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma is NULL)

Hmm this one is also a bit odd - why would these flags differ? Note that I will
be changing the VMA flags to a bitmap relatively soon which may be larger than
the system word size.

So 'handing around all the flags' is something we probably want to avoid.

For the f_op->mmap_prepare stuff I provided an abstraction

>  * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
>  * @orders: Bitmask of requested THP orders for this allocation
>  *          - PMD-mapped allocation if PMD_ORDER is set
>  *          - mTHP allocation otherwise
>  *
>  * Rerurn: Bitmask of suggested THP orders for allocation. The highest

Obv. a cover letter thing but typo her :P rerurn -> return.

>  *         suggested order will not exceed the highest requested order
>  *         in @orders.

In what sense are they 'suggested'? Is this a product of sysfs settings or? I
think this needs to be clearer.

>  */
>  int (*get_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
>                             u64 vma_flags, enum tva_type tva_flags, int orders) __rcu;

Also here in what sense is this suggested? :)

>
> This interface:
> - Supports both use cases (per-workload tuning + policy prototyping).
> - Can be extended with BPF helpers (e.g., for memory pressure awareness).

Hm how would extensions like this work?

>
> This is an experimental feature. To use it, you must enable
> CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION.

Yes! Thanks. I am glad we are putting this behind a config flag.

>
> Warning:
> - The interface may change
> - Behavior may differ in future kernel versions
> - We might remove it in the future
>
>
> Selftests
> =========
>
> BPF selftests
> -------------
>
> Patch #5: Implements a basic BPF THP policy that restricts THP allocation
>           via khugepaged to tasks within a specified memory cgroup.
> Patch #6: Contains test cases validating the khugepaged fork behavior.
> Patch #7: Provides tests for dynamic BPF program updates and replacement.
> Patch #8: Includes negative tests for invalid BPF helper usage, verifying
>           proper verification by the BPF verifier.
>
> Currently, several dependency patches reside in mm-new but haven't been
> merged into bpf-next:
>   mm: add bitmap mm->flags field
>   mm/huge_memory: convert "tva_flags" to "enum tva_type"
>   mm: convert core mm to mm_flags_*() accessors
>
> To enable BPF CI testing, these dependencies were manually applied to
> bpf-next [1]. All selftests in this series pass successfully. The observed
> CI failures are unrelated to these changes.

Cool, glad at least my mm changes were ok :)

>
> Performance Evaluation
> ----------------------
>
> As suggested by Usama [2], performance impact was measured given the page
> fault handler modifications. The standard `perf bench mem memset` benchmark
> was employed to assess page fault performance.
>
> Testing was conducted on an AMD EPYC 7W83 64-Core Processor (single NUMA
> node). Due to variance between individual test runs, a script executed
> 10000 iterations to calculate meaningful averages and standard deviations.
>
> The results across three configurations show negligible performance impact:
> - Baseline (without this patch series)
> - With patch series but no BPF program attached
> - With patch series and BPF program attached
>
> The result are as follows,
>
>   Number of runs: 10,000
>   Average throughput: 40-41 GB/sec
>   Standard deviation: 7-8 GB/sec

You're not giving data comparing the 3? Could you do so? Thanks.

>
> Production verification
> -----------------------
>
> We have successfully deployed a variant of this approach across numerous
> Kubernetes production servers. The implementation enables THP for specific
> workloads (such as applications utilizing ZGC [3]) while disabling it for
> others. This selective deployment has operated flawlessly, with no
> regression reports to date.
>
> For ZGC-based applications, our verification demonstrates that shmem THP
> delivers significant improvements:
> - Reduced CPU utilization
> - Lower average latencies

Obviously it's _really key_ to point out that this feature is intendend to
be _absolutely_ ephemeral - we may or may not implement something like this
- it's really about both exploring how such an interface might look and
also helping to determine how an 'automagic' future might look.

>
> Future work
> ===========
>
> Based on our validation with production workloads, we observed mixed
> results with XFS large folios (also known as File THP):
>
> - Performance Benefits
>   Some workloads demonstrated significant improvements with XFS large
>   folios enabled
> - Performance Regression
>   Some workloads experienced degradation when using XFS large folios
>
> These results demonstrate that File THP, similar to anonymous THP, requires
> a more granular approach instead of a uniform implementation.
>
> We will extend the BPF-based order selection mechanism to support File THP
> allocation policies.
>
> Link: https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@redhat.com/ [0]
> Link: https://github.com/kernel-patches/bpf/pull/9561 [1]
> Link: https://lwn.net/ml/all/a24d632d-4b11-4c88-9ed0-26fa12a0fce4@gmail.com/ [2]
> Link: https://wiki.openjdk.org/display/zgc/Main#Main-EnablingTransparentHugePagesOnLinux [3]
>
> Changes:
> =======
>
> RFC v5-> v6:
> - Code improvement around the RCU usage (Usama)
> - Add selftests for khugepaged fork (Usama)
> - Add performance data for page fault (Usama)
> - Remove the RFC tag
>

Sorry I haven't been involved in the RFC reviews, always intended to but
workload etc.

Will be looking through this series as very interested in exploring this
approach.

Cheers, Lorenzo

> RFC v4->v5: https://lwn.net/Articles/1034265/
> - Add support for vma (David)
> - Add mTHP support in khugepaged (Zi)
> - Use bitmask of all allowed orders instead (Zi)
> - Retrieve the page size and PMD order rather than hardcoding them (Zi)
>
> RFC v3->v4: https://lwn.net/Articles/1031829/
> - Use a new interface get_suggested_order() (David)
> - Mark it as experimental (David, Lorenzo)
> - Code improvement in THP (Usama)
> - Code improvement in BPF struct ops (Amery)
>
> RFC v2->v3: https://lwn.net/Articles/1024545/
> - Finer-graind tuning based on madvise or always mode (David, Lorenzo)
> - Use BPF to write more advanced policies logic (David, Lorenzo)
>
> RFC v1->v2: https://lwn.net/Articles/1021783/
> The main changes are as follows,
> - Use struct_ops instead of fmod_ret (Alexei)
> - Introduce a new THP mode (Johannes)
> - Introduce new helpers for BPF hook (Zi)
> - Refine the commit log
>
> RFC v1: https://lwn.net/Articles/1019290/
>
> Yafang Shao (10):
>   mm: thp: add support for BPF based THP order selection
>   mm: thp: add a new kfunc bpf_mm_get_mem_cgroup()
>   mm: thp: add a new kfunc bpf_mm_get_task()
>   bpf: mark vma->vm_mm as trusted
>   selftests/bpf: add a simple BPF based THP policy
>   selftests/bpf: add test case for khugepaged fork
>   selftests/bpf: add test case to update thp policy
>   selftests/bpf: add test cases for invalid thp_adjust usage
>   Documentation: add BPF-based THP adjustment documentation
>   MAINTAINERS: add entry for BPF-based THP adjustment
>
>  Documentation/admin-guide/mm/transhuge.rst    |  47 +++
>  MAINTAINERS                                   |  10 +
>  include/linux/huge_mm.h                       |  15 +
>  include/linux/khugepaged.h                    |  12 +-
>  kernel/bpf/verifier.c                         |   5 +
>  mm/Kconfig                                    |  12 +
>  mm/Makefile                                   |   1 +
>  mm/bpf_thp.c                                  | 269 ++++++++++++++
>  mm/huge_memory.c                              |  10 +
>  mm/khugepaged.c                               |  26 +-
>  mm/memory.c                                   |  18 +-
>  tools/testing/selftests/bpf/config            |   3 +
>  .../selftests/bpf/prog_tests/thp_adjust.c     | 343 ++++++++++++++++++
>  .../selftests/bpf/progs/test_thp_adjust.c     | 115 ++++++
>  .../bpf/progs/test_thp_adjust_trusted_vma.c   |  27 ++
>  .../progs/test_thp_adjust_unreleased_memcg.c  |  24 ++
>  .../progs/test_thp_adjust_unreleased_task.c   |  25 ++
>  17 files changed, 955 insertions(+), 7 deletions(-)
>  create mode 100644 mm/bpf_thp.c
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_trusted_vma.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_memcg.c
>  create mode 100644 tools/testing/selftests/bpf/progs/test_thp_adjust_unreleased_task.c
>
> --
> 2.47.3
>


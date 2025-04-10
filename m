Return-Path: <bpf+bounces-55687-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B11A84BCE
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 20:05:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A88DE9A542C
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 18:05:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA66528EA4C;
	Thu, 10 Apr 2025 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VH406x5j";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="mox0C1Z2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A79528D82E;
	Thu, 10 Apr 2025 18:05:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744308320; cv=fail; b=VD5SQZJMGqJTf7GM9C2YJlbE6m2/YRd2NCtvqPt7TVvSa/KOthOdD0h4bzK15B7TxpMfuWiH8M4e4h/BGbd0hP8ghLIoVTbsHS20ScxpPzLdT/Zv8h0rRVCYLsyG5Yf7e9ZvzUkjlK/mHIuj3EBtqlpgFrlhJ6FoDJGmZOCB8xA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744308320; c=relaxed/simple;
	bh=uv3Fg9+ICtl+Aw3zsBPmJUph6+Aqi7FqSQuNfA9Q7DU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UzWgxtzjTvdT2t7lHdGOjsS8qeaFvlTqv54/+UbBBU3KsjEqCx1MpvvrYE7RweRpEdYop86PrHijfrhVSX2pcEt7aJdMjhl+6yi4V4yazmucnVl5j1QqoV15JdxnTTDXTNZ2qvqfTHw+3XBBoVNFlXG+ACmnRWWQ2Ehe18Nto6s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VH406x5j; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=mox0C1Z2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53AHBxtL002894;
	Thu, 10 Apr 2025 18:04:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=pNBl5LigeeEEnEzLTdOVP2/833VmGv+SFnE8OZugjeo=; b=
	VH406x5j7prYZoNlHfitS92R6RYztxW65rRqGr3ryNC1BKXEUYz6M3ti+1rncTaQ
	ZwAAH17DZs0u7p8VIKRP8Y2curi1fWPyn0lhwhZkRAUG7YW1MH1CyKDYSTXEMXnX
	YgV6A5JKZuX6RaZ/XwanpT4OxJ/Yaj17ncwQixzcNLSKkas+kbmBku9EL2uN47fy
	ha0/JPkiSg2fCg4J5v7P6i3UvtlHWy9vl+x7FrD9TyLyl1AgRty9IjOcTq7DwbvZ
	I3ScelMnr3GlEy/ryHgz4nU/TOVOGru59LegJfhrDw2hNw1r+V0iZSQK8Buw6Msj
	X6GW4/WQgOvyrdObFn86UQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45xj64042j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:04:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53AHooKH001690;
	Thu, 10 Apr 2025 18:04:49 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013077.outbound.protection.outlook.com [40.93.1.77])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45ttyckhcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 18:04:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i2DOrU3xDnIlGm5pADJ9jroRfd7zuqe2DeqejZteJKwRkr/6cwp+EMrBne6zXNLqBdPKXwnCZ43REcMe4LvujMkITZuu0BhfL1mdmrfHjmv1BvAfiy6L8b9verfNMIQFqcVw0ERnNfyzTUZ/PYzVVhLhpxkLifTsUwF8IQN9UcebRLyJAjLS9Hayq6w5HYA6rAnQZP4mIV2nUNIKfeh9kkqDhU5hI/GIguhEwpSH6/WZwYtXIlUUezpDAHaGxUY0LKnJOo+tgVHqxKIITaFX45/7eJ3dTU4T03ER5J2JyluLCUaiRoique49CriJaIPoWJlTCvLgIAmZik+lQmLElA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pNBl5LigeeEEnEzLTdOVP2/833VmGv+SFnE8OZugjeo=;
 b=gqTSa09GX5ywVlKLVQ4+S+q53Q5HjbV1EatDuOwNGnqWNejgGfv1/j37kpgm/W5KCjCjW2+Vdo8dEm8eMwVjCRAeZDJBPH0uxA5xsZguhd7lsqWcsEef2EeA76cba6HZUT5Cb1Fb9JR9ttP7+p2WzcWzYHEOOin6CiFPGmbtVm2rwE7n6aqOtSppu9l4YZ47IvmQWceDeoKBQio/cYUa1CzANw8W2hewLX7iVcZ78zpA9WNBHd8/hnksm7qBRYq1mL93a+6pA2CjAwkCMmp5nuL4c8qpN+9UEtK7ZV82sHlYvdtLTrxy6zjeeMN+KLUxSw2eOw6qqfbBdtW0GlRX0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pNBl5LigeeEEnEzLTdOVP2/833VmGv+SFnE8OZugjeo=;
 b=mox0C1Z2svGv2eAKgJcsnvMdPUPk3UWVJD285NhQ6lcTzaHH+Q3JkcyYPUYWMHdD6/AGfA0KAYTlpcO7pEONZ7kirN3VmUEcv5dGlKinIZatl4fAwFbf1ywuU7IYvJUL5El/zxp68jzCz94KeeIZS/L+F99kRwBAGrMWJZvPN3Q=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by PH7PR10MB7768.namprd10.prod.outlook.com (2603:10b6:510:30d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.32; Thu, 10 Apr
 2025 18:04:46 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8632.021; Thu, 10 Apr 2025
 18:04:46 +0000
Message-ID: <63762579-60b4-40fd-94c0-580a2dd97674@oracle.com>
Date: Thu, 10 Apr 2025 19:04:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 dwarves 0/2] dwarves: Introduce github actions for CI
To: acme@kernel.org
Cc: ihor.solodrai@linux.dev, yonghong.song@linux.dev, dwarves@vger.kernel.org,
        ast@kernel.org, andrii@kernel.org, bpf@vger.kernel.org,
        daniel@iogearbox.net, song@kernel.org, eddyz87@gmail.com,
        olsajiri@gmail.com
References: <20250401092435.1619617-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20250401092435.1619617-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P251CA0030.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d3::18) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|PH7PR10MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: a906065c-daf5-4c3b-cf5d-08dd785a2d5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1VpL3haM3k1cUhlVGtENjdmS1hOTWNYTktGLzFDREkzODJucjdzOGt4LzU1?=
 =?utf-8?B?bDErUFZzRjlTVUlBU1VDcncvN3N0UkgwWWdZRFczZVRsQ2ZKQXovZjlyR0tI?=
 =?utf-8?B?LzF2V3o2RUFwK0pCdWE0NnUzZ0x6MzlaUkRnc1VGTXNwNUZDMFRqcVNJM3Ez?=
 =?utf-8?B?Ry9IYUg4K292VUNDRnNmaXYvWlJoSCtlZlBPTk9zd3l3ejZVMFRRQnRvTzI4?=
 =?utf-8?B?d1E3UFlETmxxTGI5SGR3M2NpMEdjSVBmd2VkQy9qTWx6RHdQTCtUamF3cXFs?=
 =?utf-8?B?eW01a21ZOUxGa2wvL2ptaGdVeVMyRy9DS1MrZGlsT2RwNE1FaktkQ1ovemMv?=
 =?utf-8?B?UDRXVjJGS2xOd1h6cDR3eGNsdzcxN0JBZHdDWFJlSHpqVUNNVjdqTVBmQWk4?=
 =?utf-8?B?cDBaUTZaVlZSdC9jV0Jpdy9RMm5SVUU2eDVobUpYTitHMHdQQ3ZRZTJCTHZK?=
 =?utf-8?B?RHFDcHZ4T0JEVXZvZGo0WEZGTEtqUmx0UW5ENFd0Y2ExZTVHK3lYU1NXditl?=
 =?utf-8?B?UUJGbWdoWG5WK1g3bzhzK1JyVTczRnIvV3FjTlV0M0NkbUpUbjU0RWcvYzUw?=
 =?utf-8?B?UitOQ1o1RUl0QWo3SVR1RFdYRUdSbFk4d3NjMllMN3E1WWZJeU5OODhlMXJh?=
 =?utf-8?B?c2tZMk4wUDdEOGE1VS8zWXoxRFVHM3dBK0p5d0dRUFY2R3FpVWJlaFlvYk5m?=
 =?utf-8?B?Y25NMzBCNjBzQkNuV0liRXZXdVJ6QVlCZUhpb09jbmZ1N3d0SWZDbU9scTIx?=
 =?utf-8?B?STR1UzFERkNzd2g3RWJsZ1JYNyt0Nk1NS0gyZ0lXU1k5NmtzRUxPRUJDZkhY?=
 =?utf-8?B?TldaM3VROEpZd0RRVDJ2Ly9tTDFvd0tCc2dnRTlqM3lxY0VyWEZPUnBUaVZX?=
 =?utf-8?B?amkyd1dEeGppOGQyUTl0ZERZdUtXcFFDeDhTLzVNZEVybGF6Ly9odDBjSldJ?=
 =?utf-8?B?ZVFER3c2T3BaUGJ1OWxqTEF6bmt3Yks0Zk9kVVQ4eFVOV0RXenVCMndxVUYy?=
 =?utf-8?B?WmNIM3pMZTlxSFlKQUFRd0dib2NEc1NlQlpRZDBRN295N3JMVlRzYWdDLzNp?=
 =?utf-8?B?U1FzeTlOcDdCaGhMMllMVVM3emNyOGdJZjZUbjJmZ0hvdlBhY1k4eXgrZ2hr?=
 =?utf-8?B?MXIxdlZZbEJVczdqckh3UU0zV1piWmk5YnF6N3ZVU1d2bzVwVVRuWFZtcWl2?=
 =?utf-8?B?QmtpcUhLRmdTSGd2alhrSUNwOSsvZGVSdWRLSnNidjVBWmwzdXpqWmJHNVdV?=
 =?utf-8?B?cHVmbThSUVRKUTNZdVJpWnI4K2RRU0JYQ2JuOVVSNWlWS1JzQnh1aStDUk9J?=
 =?utf-8?B?S09XRVFxVER1RHJRQ3hjaUU5S0FzT3oxaWd6UnJ1WHhJQjdBelBaYUMzMmM4?=
 =?utf-8?B?Vzk3WVFkR0JsV2s1VlRZcmFNa0hQZEYzMkJST1pzNWdldWF3dThMdDZuVmNP?=
 =?utf-8?B?d0VycTZjZVd2UitscUROLzZRQzdmWmRSNWJYVkZvRTlDMmFSaUc4djZPL2t4?=
 =?utf-8?B?Mmw4Tk9WclVqdFQ4M0w2T2x3TDZQOXFpRndQZnhhYnp6ZTJ0cG1PVUg4bmV3?=
 =?utf-8?B?aVNuRkJlQ2pRSWxhZGlZRmFLNkJ5QzBnc21WZ1dFd0F0ZTErMFpScFhZa21Y?=
 =?utf-8?B?ZGwxVVV3Nlp0eHFDbitmVEVWbXJ2cVRSNjA4OVBrckl1dFg4RmMvOXhlU1Nw?=
 =?utf-8?B?U0hFMGxmd2lFWGdncjRVY2hNTC93bnU2Wml2amlaaXZOWndCbmo2VDA4T1NX?=
 =?utf-8?B?Z2VlVCt0ZGxmaHYrTXNVVXNObkVVOUxCWUlWSkwxTmFpbjlVN2NBdVFySTFv?=
 =?utf-8?B?T0ZMQUIwdU9nRS8rbzV4akFCdG85dmJmb01BQ0VSdUtvc0tQSE4wNGJkVVdo?=
 =?utf-8?B?bjU0UUVHa0JCVURkckQ4dWVKYVFWSWo1UnJUdHZ4QkxSMEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?THE3a1NOUWRDTTEvS2tJcEtPZWhaM29oNXh5TkhHOG0wN2lMN0VERjM0QnFU?=
 =?utf-8?B?eDQ2dU94S0habUY4V0t2cjI1bVRCQk5IemxPWmVVbDY2OUIya21QN2IyY2sw?=
 =?utf-8?B?SzAzUkw0ZG1EL0dYRitiMk4zTmk2T1U4NWt2OG5zZ0p1ZmdtNmlUSUhqLzlt?=
 =?utf-8?B?b3BiUThEd3BmNXhIYVF3OTNiYk5zcXNaK3laYVNaMlZyMjdJc25jRGZwOERo?=
 =?utf-8?B?VEZCM0xRWEgzVG40ME9tS0phMENjZnhobHFYcFpaQkNadnZOZDltQjkwR1F3?=
 =?utf-8?B?RkVtemQ2SG1xa0hvSW4yb3B6L0ppRU14bU8wSUZtSWJlL1NwdE1XVDhyd3Zw?=
 =?utf-8?B?R1hiY1lVdGZFRWs0TE5JQ2I0citWbGcxMDhUampzc1NCQTVYZHZ1WS9oWlZu?=
 =?utf-8?B?TzFBZEhXcDhzNVdhTTJqZmJvU2lFZkwwMnB3dXBvUE1RY24yZTJvWXdwZ3pn?=
 =?utf-8?B?ZnEzdW1FVkorK2VpMTZWRE5LK1ZVYnRqV20reWxPUmxEdXhpS2FPVGsxVVVX?=
 =?utf-8?B?YjRCNHdwaWNsMGQxWlRLZXdLOUhFZ3orc29VR2l3UGMyM29SSFFKS3IzT1Fz?=
 =?utf-8?B?Y2Y3TDI2Z3RENkR5V2RlMG5KWldZd0tGWUw5c005WStaZGl1Z0p2RTFjdkVr?=
 =?utf-8?B?MzYzMGY1dnBZVFd2OCtMbTlWZ0xvbnp5UHZxUCtyTFE5NGM4Wm9RVndvQXFV?=
 =?utf-8?B?eGloeVJtN2I4TnpFYkozVzFScS9yNGNrOXo3RVZ4K1dBRW9XNEl5aUdRUHRw?=
 =?utf-8?B?VlloNDNJZ0RwWUpjV2tUV05sN2lIbXk5SWhJTC8vS2dCZFpqcTJBSHBkSU50?=
 =?utf-8?B?Uk9VY1hJM1BhbTlFbytWOGZEUVE0MEFWK1Z2SDRsaTRHOU8zMlJZMEZlek5I?=
 =?utf-8?B?MmM5RXI3QUxDTWNUMmxBcmpZaVJpdXlWMzRFdyswV0I5SGpFNFFVZHQxTFhJ?=
 =?utf-8?B?dHo0OUJEMXJ2WmFSZTVQQk1yOHFkV0w0Ymx1dXVKdFpCVkRSYnMwdVYrb09I?=
 =?utf-8?B?ckVFbExNZ3haellCNEtxU3djV05LUWdVNkFoTWhyODZVb05XZFUvYUVCQ0ZR?=
 =?utf-8?B?VmsweE1YVE9HSVVXQWRZZWMvS2d3SzdXTEhTeWdza2NQL0RzL3BHdWN0WmhW?=
 =?utf-8?B?YStHWXVLQUJSaWRhYUN2dVNZVGxkaE0wN1RIQjJ5MHZ2RzhMdzNUNFQxQ3lk?=
 =?utf-8?B?TE5TbmRPSlJsVlRncVRTVjJjVWVBQ3AvMXBFYzJVUXVLci9tYUMrSjVyaFZ3?=
 =?utf-8?B?bXpHNnFpa0ZwUHVhSGwwMWFqUXZTenBJQ3oyMHlmdnN6aFpJeHFKRjI2UVdp?=
 =?utf-8?B?Njl0NlZaYXRsTVVHbis1b0VmSXdwZ2hycTJoei9SWWtvZk5GdW10bDlqdkpI?=
 =?utf-8?B?c0NnTTdCWGVqOVk2M2NETnhIRTdLMit3djd0UmN2TlFhTGJ0NkZJNVpTNCtv?=
 =?utf-8?B?cFVrR3NGTlBNMmpJVzV2Q1RXZmNwUlVOY3RwYUNqMGxsV0d3OTFRNENhaThp?=
 =?utf-8?B?MGhmOTRjWlJhWm5TcXhGQ0FiT2ZtK3ZsK0NHUnlIdnlsSUVETFpZaHBPL21K?=
 =?utf-8?B?ZzI0eUh2Z0o4VkpjNVdhWVU4cjRTN01CSXRXbG1LZG1DazhYZFZYZFMxR0ZU?=
 =?utf-8?B?NjVhVDlLU3Z6Y2tVb1ZHdlZhb2xTZUp6djlxTGZVd3dGOFpodG5Sd3NDeEQz?=
 =?utf-8?B?bmNiN1NvTHlWOCtwOWlBU1ZYVW95K0I5WDB5eE9yNytTVzlMRm5GaWRzVEpB?=
 =?utf-8?B?anh2SWU0d0toUFFMdUx5ekVyZy9SUmlyZEFrcE1RUGREWktETXExN0F6NzBx?=
 =?utf-8?B?UGIxOXBlWnprV3hIRG56WmpGd0hzd1NCWDdkWnJYNFp1cjZweVc4c1VZS252?=
 =?utf-8?B?UGMyTlEzOVAybVZteWNPM09HbkU3bm5CSjVZRU5CWElxb3NTeUFKbll3ZlZ5?=
 =?utf-8?B?TS9LK2tvV2NpQjNlYUM2TVVyMGo1amFJbGhJcjJtMnpSR3VmbzZTTUtkWnhZ?=
 =?utf-8?B?bmQwbFVXcEF2U0xVNjVZdDI5d3dROHF5eDYrVlhNVHoxMTZNSTlhNVR4cVhF?=
 =?utf-8?B?cHRFK3JhM0oraVdaVE5rUFFTY3F6RmtFb0krWDBkNzZUeUlaOHdMUHk1YThE?=
 =?utf-8?B?RFgxaGlOUHBDT0FKSWRYT004cDdiL0tvVEx1K1FnY0VMa01GYnpDcGZhcFhL?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rXiu52i6fryXfEa59hoS/4Afv5l5IGBRhPpSlfaI14T6KulQ8W4Xut8Rtat01WkhOzarYHCRQjxNJJ8gOOjgr28IPtGw2TNrfFQ7DoVzHDTGh7n+X7FvcNS0Xu40oNOJ0GrpTEpz98nMTlLU1wL/FvuPJjY/piR/3Qk63Wppc4ACdYvywxkjseco09k+/3qrIzjQYpNANttMntgYdmEUJrf4NXweILhuC1CHgfIzWSOYf6v19NT3+vGYIWtG5Kyc3p9x4RMd3n61S3xJ2ixAyxvxo+npsPXQBXUJmrK3f3hjBFn+RWJ6urGK2GtEnd6t+1FVpEukpZUQ4cxfcB8i8CU/kCSk5kompw++gYpg9kXJ1PFSLDKYvVBlZIJODAAcPnT90uLnSmLra8AuH2lsNIQ+d8kxvxXqRksYfjIaIl/Uz9P4drFFWCvCmgnM+3VFvmh6N78kLrp9GKSRnKG3M9HM2K+Xl63dH0frS+WDauXYIRZ9Hh2VDlsSOLEggES8FwS8X9kF5cPfX09Ot9+8fgKdDWdmI2BgaP2WiJFi5lJ3CS9wmVZj0cOcyMYUGTtwnOwWR9EVPqLekbBB5JtVhdg2ISP5p65s4TOGR6FZ8oA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a906065c-daf5-4c3b-cf5d-08dd785a2d5b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 18:04:46.5567
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MGMBXBxJiwwzPH5YxMPJZ+CLzLSqGMZ/NUM9R0SF9s3rtREUleiNJIw485qtvqcPVcEiuXjaAkgdiPGccnBTPA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_05,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2504100130
X-Proofpoint-GUID: h6iyaAiUjdxdCZWuI76mLQ4UmRQIXFZy
X-Proofpoint-ORIG-GUID: h6iyaAiUjdxdCZWuI76mLQ4UmRQIXFZy

On 01/04/2025 10:24, Alan Maguire wrote:
> libbpf and bpf kernel patch infrastructure have made great use
> of github actions to provide continuous integration (CI) testing.
> Here the libbpf CI is adapted to build pahole and run the associated
> selftests.  Examples of what the action workflows look like are
> at [1] and [2].
> 
> Details about the workflows can be found in patch 1.
> 
> Patch 2 fixes an issue exposed by the dwarves-build workflow -
> a compilation error when building dwarves with clang.
> 
> Changes since v1:
> 
> - rework to be locally executable as bash scripts as well as via
>   GitHub actions (Ihor, patch 1)
> - add note to README about various ways of running tests via
>   GitHub actions, local scripts (Arnaldo, patch 1)
> 
> [1] https://github.com/alan-maguire/dwarves/actions/runs/14191907449
> [2] https://github.com/alan-maguire/dwarves/actions/runs/14191907451
>

series is applied with Ihor's suggested change to dump config info;
for now I've removed the codeql and coverity jobs as further testing
revealed they didn't work. We can look at adding them back later.


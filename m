Return-Path: <bpf+bounces-44944-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D826E9CDD9B
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 12:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F3E01F23F98
	for <lists+bpf@lfdr.de>; Fri, 15 Nov 2024 11:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F37A11B6D0A;
	Fri, 15 Nov 2024 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TrotxuN4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="GjHuuORN"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A3B1B218E;
	Fri, 15 Nov 2024 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731670852; cv=fail; b=m1ZhWI5t+DIkpjK/9xDk1+nYcOVXa2uJfhkC+r2ufBQJIFnUCO8hnNEUeM/1e24NMW0W8XMFRdNlGtog9lyBKJw2g+Mj0R1NToNfn1QzVe6etstIWBM5K+65Cv4ZH1caUOOCiZCKF0jRKin9g5vCUPVIchLyKzKe2r0NaFN+z48=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731670852; c=relaxed/simple;
	bh=LJ4OR5BNHnNTZYXIn7orlCisJgUtpLlLidL8rct0XIw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WHFDG1tElHhI3mbk9Lo6sb+m2aYHhR4/BeCvw58LNbZ5kXM3zPJjNzm0fkdqMl20v6mTM5/kCAOKsOI0kszmZKe3dSsvDz3N7ZEc56E5pZkWC4P0X7bZLmmsHhqqffAkDDlXKaKI6rl4nRF5Vq9qqYM5omxy9qRsFuDQgfJA6Qs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TrotxuN4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=GjHuuORN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AFAH1UL000371;
	Fri, 15 Nov 2024 11:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Z6e8atUvqwPQ5GgmGXO4eAFS/Kr3tzG9sUrN8tuVXRg=; b=
	TrotxuN4uKqoR+IyVPp0DVaWu5jkKzHMPgoshtz1Gb72LNl40FCjeNAvbeclGbGm
	o6f4T2DxNjIg13MlDrsyDu+LRabbpC6OFcrfmtPyVkrowBR8gRSzn2DOTHsnxH5f
	HidVtXowVcLgh1J2RH3OBVPdcW7dJy9ppa3LwOE+k7MgpkX9LeWy/lyDT4g4vSLr
	T88jsvo9DWaO7ik2xPSHQQUtKON16Xd3/hXtJX5U9MrUCdWfWnnedzxEd7qqkZEA
	fBuMMuG3TTbXs9JZoStsNEm+Yj9iL3pf2S9OD+rwIXISQOIU0U7h9exX4cqiLIBw
	jZrIFNmCM++x6dWjaY3OFw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0mbkawn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 11:40:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF9vokk005673;
	Fri, 15 Nov 2024 11:40:24 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6chx2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 11:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JZCdyfeMZ24fjiZCTBvBT13iWH5U3VObC/5osnXQzGrlaQwfR1yQ0U35D79JbX6waKxHTzf0dQpo8GXgtVZaY3qZW8/7RE2Hbj/jITpqsl9GRTeV5zkPyh1MP3McI/Xx87W3+IRIrb2s3QNHnJU3eiJ+Bv5XGt3I7DdX8lQp6EUECX8Mh0RqUOKUTGH9rh2lPVNDebW6/FZYJU6YtseYZz6G088sGhRN8Vhw/ySkLA6uVF/XV2JqWhWx/HKsXSskD3YxYBwbK3cgS1KLbjSlJIHLWEaRLQc3hXN/0x+VcLfVt18UnZa9ydvMznEoEVR53JXzQWXuRlJZ2dIeAZ7RAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z6e8atUvqwPQ5GgmGXO4eAFS/Kr3tzG9sUrN8tuVXRg=;
 b=xUsTGT6YzTTZVV9vERn/tzgJL6uCfc5Ow/cllEPR3TmtFg4V/GAtbNi+6SOTOReotiFG94Cr93F0QppqN2ItBTRtg8w6LDCK/aDNCIcJ2w7ZBxeWg7zeJ+5q0j2CvG3F1174TtfBh9qrIX/dYU09JlcVs5iobM5H8KsZoy5PxnxWqApi7hEgILgAaVp4uXbqMFWaijZoAunM3W1QQ9sBwKv29ARgG6oPLpsu9msl2St/CPnZ6+HxZEnQTdI3zJFSCAMf0FZrDRFr5NE89cNgWbPwMrB+dJ1Mc7C0/B9fcSAuH0aTtD4la/wi95la3JYnts5oa6kQMFibsNwP2kWQkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z6e8atUvqwPQ5GgmGXO4eAFS/Kr3tzG9sUrN8tuVXRg=;
 b=GjHuuORNWXe8hUER1XfaJt3Y2BIXBGbItqVTkYI9mLwLnNjtGj21PJmrljbNKXwYXR6+DtRSPTlUIR+0AaF7JJIf+6wHcDF0MZJfq11v2sghKIHMTzXS1uWhoBE9x/ZDZbcBQ9MRM8VApsY0H4LB3ggHx6sEemQZsCcS/2pa2gA=
Received: from DS7PR10MB5278.namprd10.prod.outlook.com (2603:10b6:5:3a5::9) by
 CH0PR10MB4857.namprd10.prod.outlook.com (2603:10b6:610:c2::21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8158.18; Fri, 15 Nov 2024 11:40:22 +0000
Received: from DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378]) by DS7PR10MB5278.namprd10.prod.outlook.com
 ([fe80::eb46:3581:87c4:e378%2]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 11:40:22 +0000
Message-ID: <a1ffc678-5d72-45f5-a304-07be3cca7f86@oracle.com>
Date: Fri, 15 Nov 2024 11:40:16 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 dwarves 0/2] Check DW_OP_[GNU_]entry_value for possible
 parameter matching
To: acme@kernel.org
Cc: yonghong.song@linux.dev, dwarves@vger.kernel.org, ast@kernel.org,
        andrii@kernel.org, bpf@vger.kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, song@kernel.org, eddyz87@gmail.com,
        olsajiri@gmail.com
References: <20241115113605.1504796-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241115113605.1504796-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0681.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:351::15) To DS7PR10MB5278.namprd10.prod.outlook.com
 (2603:10b6:5:3a5::9)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5278:EE_|CH0PR10MB4857:EE_
X-MS-Office365-Filtering-Correlation-Id: 703b22e4-8d6e-42ed-da6d-08dd056a499f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RG9PVDJ1bTFzOGNpTm4yZEhMcDhrMHJKeXlVZFNSV1F2NWNBRkYvSFh2NEVn?=
 =?utf-8?B?ZW5SQVM1NHVyWC9sR0NyQVV2UDVDNFludDNScTgrS2NRSy9ZZndibVNHRzZB?=
 =?utf-8?B?bjN0dDh1a25qZG9zdFZ4dmhkTWVWMTdFRDIxVFM4Vm9hVEJvZDkvVHdkMWE3?=
 =?utf-8?B?UFZ1bHlBTWVUaVRITWR2Y3R6ZDFVTjZReGdPN2RUWHc4cXNnajhuU0kwaDZY?=
 =?utf-8?B?Q3U2amZrYlBGZ0FpOVVtNkVYKzhMSUxubEZCRHUySHczdlI3NkFtRnpEaDRl?=
 =?utf-8?B?YUJEM3BOakZRVjIwZGpLQ2ppajUxZDlsdkpzQ3Y1UGN0c0t2YmVXSWJ1Rndy?=
 =?utf-8?B?WlZQRGJPVmoyOFpINXZKazR5Z1dreGJEWWdNOUpkYnZ1OVlQdEJxWVpEc3NN?=
 =?utf-8?B?VGNDUTB2RmZZUmJtS0g5MGEyQlFjOEZ2MmxpbFNqM1d6U05BMzFmRldsRzdh?=
 =?utf-8?B?RG9RUTNFdFpqdXNsNDl0bHdpRi9lVndIK0dTSlVCTUpzQzFkTUMzTmVkaWZY?=
 =?utf-8?B?enNBZVRmd0MrZUUyQTc3dnhUUXQ3WDhwNHkxUVB0Znl3OFVpNXR6dHlNcXU3?=
 =?utf-8?B?Qy9TR0Fva0lyTHBDcVdSN24rZVlRWWxBenpkYmpMT2tKVjY1cVBCT1k0eHRB?=
 =?utf-8?B?eVNtWFQ0TlJ6TTFPenFQTzl4K3VmTUwzb2h2VGZWVUtlRndFTkd6L3ZvbWxQ?=
 =?utf-8?B?UDdEL2RRUEpMYVJzMit3bjBrUFpGSXQ1SUMvYk9rbHMvU21XWHA5eEVpUU4x?=
 =?utf-8?B?Y0FXam52eWgxTEtsRnZtRFk3LzhSUmN2K3YwdEdQMmFrYTg3cGRKcko0RHdy?=
 =?utf-8?B?b0Rad05sTXFlWm55MGYxZmU2b3RGald3V0tnVFJGY29EckV2aUpBOVl3cG16?=
 =?utf-8?B?bjlpUDduZXpUYWFDWXA0VlNoUXpKYlBwaC9veVdZNzNkSlJNalUwemQwZzYy?=
 =?utf-8?B?Q3ZLaklxQnNHYzlCSVlhUkEyaGNuUDNEY0l1ZmRJK2hTM2xXRHRNaTFDREd3?=
 =?utf-8?B?WU9ITnRYVG0vZkhqTm4rYUJzVWVMb2hpbXVhdVBJenFBK200L0wxaGQrbTF3?=
 =?utf-8?B?bTFadE5jNlRpVEJsVENMYWdZSmxMdVRCSnJIaEFQb3MrQmplaHBjMFg3a045?=
 =?utf-8?B?N2NBbHhiRlIwSU0zenQrMzVlZjE2enc3ZmhPQXlTeW5lSHhXc29SUWpUU1Ur?=
 =?utf-8?B?VWpEdEkvNW9zbFBkS0RRKzdvMGh6b0Z1S3UyNEJoUEFQdGdTeUE2N0UxL0pa?=
 =?utf-8?B?TnpUQjZRTmhkZldqVmF4V0dkTXEyRHlJTGNNNWhONDNoODcxajBIb0VZV1h1?=
 =?utf-8?B?TmcybUIrQmtwYXdZankwRXB0TEpYSHR2SEdoWWF5VzZMWkxJM2c2cEd2SU50?=
 =?utf-8?B?UndFNStWL3ZaSUxIdXlpTnpCVlRlS1JHRGtTbUJUSkd6M2t4d2NENHMzQkd3?=
 =?utf-8?B?c01uY2NETmJjRy8relBSS1V2b3NUSnpudlpNOXBkYmRUbWUvaFY2SXdXeFVz?=
 =?utf-8?B?YTRDSDRpd3Z0VmZxZzdoMmoramhnYXN4YjI0TElDUWZHZVhqUlFwVTJYT2lG?=
 =?utf-8?B?R0pNYkJoRElvQVdDVVU1QjBCak91ak50NUxZWmZTRjZLcUhLSmV3OGVMbVQ2?=
 =?utf-8?B?V1VMT1BSbVlRREhZSWRidkxpNTNoQktPYWF2UDRXcjV1aFFoVGhjYnp2VUNt?=
 =?utf-8?B?NUMxRnkxWW1nTjJuM0d5WTdGM3dORitoYzAvQWpKN3dmRW5WYUhWZkNhdmtW?=
 =?utf-8?Q?3piRz0/53V4J7zWzRs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5278.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?amNMcm1BNDBrVVVnOWJXeThRREZIM092ZnFZV0RHaERiMDZvVnpNOUhYWk5F?=
 =?utf-8?B?ZXNTZHFwRnBvSGx3cERZV1RWTHlSaTFYSDkwSkNYSW5jdnoxWTAwWXQ4NU1r?=
 =?utf-8?B?MmVkblJyYmsySG0ySGcvWHY4Ris3RmFCanlQSE1ZOGQ1WnJSeTBkd3JESzYw?=
 =?utf-8?B?S05ST2lGbEM2b1c3UGYrcHA3T256N2t6R1k2V1V4Snc3WXVIVmoxdE9OcU1m?=
 =?utf-8?B?N2ovYldaS041WFNoS1hYbUJMQUlMNXNSV1h0U1N2MDVxN0RmMUJsOThNVFhD?=
 =?utf-8?B?NXFjN3E3UWpMbmI5UVp4MnlYVGV1UkVPcmxId3hSVmZJdVBWbUJudzA5ZVpK?=
 =?utf-8?B?VnFTem54c0EvblVRU2xhNXovMUJUeUZnalBJYkZZREdBaDBZQnRnc2c3VzI3?=
 =?utf-8?B?OGhoZnhDUFNYOUxPTXdzd09ONlhhRjNrWURTanFFQ052Z2Jxa2pBVlBHaXJV?=
 =?utf-8?B?SW5hQXFEMjZML21vZmpNYVd6SFYrTGQzaUkrK1N2dzlZT0g0Zi9oOXdHaXI5?=
 =?utf-8?B?ZWtGeGlwK1JOZ1M0QXFIeW9hZlo0TjNXYU9iREt6bXd2NzVOQVM4ZWRiaVRt?=
 =?utf-8?B?MWZPVHF4WCt3UjhkUkdFNnJJZWcvMmZ0S3poaWlxMktnOUhNSnhOVHRZQlJl?=
 =?utf-8?B?QmlWQUM0ODA0Z0xSM3hWNHc0citKZjV2K1d1UExiK2x5Tk8rUy9mNTlqYy9C?=
 =?utf-8?B?bUMrZS9JMThjRlQ4NWZPM3dnSE4xUGxTK0RLeHFVZVF3QnpOb3ZKaGtlcDBn?=
 =?utf-8?B?d1BqcUpMVWRZVHZ1TytuQ1B2aGhUS0d3T1hhbEJZM1h2MTUwR1ZYdUFqM2FQ?=
 =?utf-8?B?T3Q5Vm96OHR0MUZxT2ZpWXRzMGRBMzVUeGR3ekhZWnd3andkSTFKd2dYdE53?=
 =?utf-8?B?VmszMVo2L2hjNnNNZlNpdnp6VEUxNGRmbDBnMzMwdVYyWER1ZlN4Q3E1d2hl?=
 =?utf-8?B?YjQ5T1hYa3cyQlllTFlOcHNqRExFeEVrTHQ5Qm9iR25NSXdlbDlzdUxLYktq?=
 =?utf-8?B?NkZuYStXZ0pGalEzbnN2d0xPeFpoYlF0ZzUxdGt1M2FYSkVLNGJGdmdjMTBl?=
 =?utf-8?B?MG9UR1dpcjZLaVZ6V0p0S2FXSjJxYlNBSmNhZ2E4YjVtQ1hiOGRPaTFrNEhP?=
 =?utf-8?B?M3B5OGZEUlRWbHhIdmxCR2tCTW9PR0VFZmNKemN4WGVlNkxuUnZ1aWtaOWt6?=
 =?utf-8?B?VE9JVENvNS9SN2lNS2lSWWFicXhHRUdET0RpTHpRSXg5NGhCY3FMVkNvcWgr?=
 =?utf-8?B?RHQ3YSsxRFpoeFJabDEyQUhoNWxmbmRqY2ozMDlRdHltOE1kRVRlb05VU3B0?=
 =?utf-8?B?SHVzUGNZcDZlR085ZGxuaHpPWnNEYmd3NG5oMjMzVklzaHZCVDNtczdhaXBk?=
 =?utf-8?B?WVB3cDV0OGlMc2svbyt3R2dsK2E4Uk5NOUxUSloyMGJZOHgwZ3h5M3JsbUNy?=
 =?utf-8?B?TTA4dzd4bHM2TklpZzk3Q3pLdVpwcC9hSUYwbVpSWlN2eEs2cGZrTlVqZ1hv?=
 =?utf-8?B?RXMxU0dOL0M5SnVBd2s4eTFCNkJPZWppNEFaOEFTWk1ZeDdmWVBZVDNYKzJh?=
 =?utf-8?B?alQ3MUFVR1F1MEQvdzVLSWVSbERGaEMwc3VWeHFBM3g0NU51SkF0SGlKRzZR?=
 =?utf-8?B?K05FSENqelFSelJLZ3pqaStjdzhuNEMyeER1bFlpYjZSNlhjcmVBV09MYXdT?=
 =?utf-8?B?YWFRdVp1bThBbEl2dTFuOTRCcWhOM0czOHdpcDZwcitLbERGWUUrNTBJS05l?=
 =?utf-8?B?M0F0RGl2UlByQytnc3lQU3E0TnJNZkgwNEJZUFhOayt6MlBVMEhMSWVHYzlR?=
 =?utf-8?B?UFBEbmU5M2VKSmxjcmVLcDFnanZiV2dtRWY4Q3g5eFRQSlNCWU9wM3hpVmpS?=
 =?utf-8?B?dTBYdXpxcWFZTDZCRnkwa2lTR1BxN1ZHMWZsRjBVTlV5SkFrQUFEWUJ0aDdI?=
 =?utf-8?B?WGpMMXZueEp4TlpRMEJBWGxXV2Q2STdSREJsUER0eVBsWklFMmovZGQxR2tV?=
 =?utf-8?B?NU1tejV3N0Mvc1J4dVNGSmtlVm1QSFNoT3BjMGJjOHlJQ0RkS2hpSXFwTVRY?=
 =?utf-8?B?a2RVaFcyVHBlRHlJZ1JRdUhtRnNyT05IRi91Zk1NamZKRXZ3UlVnNUJPcVU1?=
 =?utf-8?B?SVB1TjVHMk5FdjNYVWpVdGNmcVRUbS96bExyNjdNODVvKzIrN2xiY1p1WGlU?=
 =?utf-8?Q?hoSt4MdL5WmGVdgVFHYZaoU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jJUvu4i6V24YcIdhFuoBxqQEgxkcvRuyJXsMzTN7g7FrNXoXTZXx5r9fnM397RmidOGO4QCsPU+x+3Jt9YXiJelCrM6fPqQuId5ggggFaIKeJrFWL1z5auA6bNPWGX4wLCs1CHs4rzKpv5CEoDZNcwSnSR9O/n+boBqO7yrlXCUC9m1MWl/REX26gI/IvSKXOIRk8T26KxMfVoRMg0VpqYf/c6E8KBtuAG2iVCRUk3finSDMSOG+wIVauMkFOjuHPyjDKRNSHMhJAtCg3NK6NoYLqIRvJFadVrAbPpYXebajem3axx0paQwbByZ9t5UtbWeE4F5ftGTjfbVwy3Q6o0DifHnECFrtx8JkKBoLprpkSaxBL8blCjDdKfWS4ghc+eaIQReEtyPPCKUZcUYAvdFISinV6lVkCm6eKy3thJXrK8DG/NAnJK/Z0WcDCZmRCow+eu5X5W8gmrcwHfhnIUPyIidXhrnO4pgORVlM2Eq04pxCRVHL3bwEy/Aetz8xSzlxmU+Y4F1KlKlkkBCO+OaB5Ibvag6cEd2vJP0SFbERgkYi1aW1OhGDrYK/g08vVaZUYOJf78huLW8JyKyWKpIv1+xBNiT8L/SWQvD7b3Y=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 703b22e4-8d6e-42ed-da6d-08dd056a499f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5278.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2024 11:40:21.9290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kQCyk8Jp9ES0WPpY/dGzsrsRuYLX2CHAGjOzm2swfPONP7toxr/tOMeyTjh8B/6cB2miqHrKG9c1OcsoyHVEsQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4857
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-14_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 spamscore=0 adultscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411150099
X-Proofpoint-GUID: YHKUnuVXYvwvwMN6kSf2j-OlWGmw789c
X-Proofpoint-ORIG-GUID: YHKUnuVXYvwvwMN6kSf2j-OlWGmw789c

On 15/11/2024 11:36, Alan Maguire wrote:
> Currently, pahole relies on DWARF to find whether a particular func
> has its parameter mismatched with standard or optimized away.
> In both these cases, the func will not be put in BTF and this
> will prevent fentry/fexit tracing for these functions.
> 
> The current parameter checking focuses on the first location/expression
> to match intended parameter register. But in some cases, the first
> location/expression does not have expected matching information,
> but further location like DW_OP_[GNU_]entry_value can provide
> information which matches the expected parameter register.
> 
> Patch 1 supports this; patch 2 adds locking around dwarf_getlocation*
> as it is unsafe in a multithreaded environment.
>

apologies, forgot to note

Changes since v2:

- handle multiple DW_OP_entry_value expressions by bailing if the
register matches expected, otherwise save reg in return value (Eduard
Yonghong, Jiri, patch 1)

> Alan Maguire (1):
>   dwarf_loader: use libdw__lock for dwarf_getlocation(s)
> 
> Eduard Zingerman (1):
>   dwarf_loader: Check DW_OP_[GNU_]entry_value for possible parameter
>     matching
> 
>  dwarf_loader.c | 123 +++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 98 insertions(+), 25 deletions(-)
> 



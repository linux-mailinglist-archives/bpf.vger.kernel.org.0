Return-Path: <bpf+bounces-79586-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EF2BDD3C4ED
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 11:18:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EF5BB709A5F
	for <lists+bpf@lfdr.de>; Tue, 20 Jan 2026 09:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0A5333E356;
	Tue, 20 Jan 2026 09:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="O9SwIs9h";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QjJKKE5G"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2001727F75F;
	Tue, 20 Jan 2026 09:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768902802; cv=fail; b=WMHXJ6IWr2wjyUKl4VVbTP1I/Sj7VP8MADmk39IxMAJwGmolh1aNOT5DaAZhMGpoP2YmiLp5nRNuyCmrcw2k5Lw9ghdwQGpe17EZ4syXndjRqfPKF/JlORUenSfmbX2Xmt5nuFF0De6VVUZtzssDQvqe0DiiBJFToRzxhVo0TaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768902802; c=relaxed/simple;
	bh=3QwHZ09w8uNWaIVEsYdjYZmXO1OR0UmiFQK5ez9guiw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=tMsxpnruHdLSCLzDLujgobKForOjHAJ6dJX7Gqd4nBzR87HTMH+yfRUBKyLtETUo6v1bN+LjjrV4TbfG8Trat3XZC/6o3jXNQILTJ6f6TsZon3QujrZ0rHllU1NJmo55U7MC8R53rI3e6ijikM3xi4Hcq3bqBP2rkGA7uXpG/2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=O9SwIs9h; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QjJKKE5G; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60K7vDKw4086352;
	Tue, 20 Jan 2026 09:53:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PQe7vbUsfycYaakp8cad6wfjtsGJbMlOhLdaT4Smf7w=; b=
	O9SwIs9hs2hj1IBopPne+1LandYCT1uzOCBsC8/XnrtbnMPVdwfjSwdIoOhY3nqL
	GXioU7lM2VEBa1EZce8avHOQmNvzy/aLYsVen5b92qDhQ79zy9HNADpiEpCPlR5W
	B81teex4pGfuUpucSTtipuqDcgbQQnV6FRQGNByxrKa0S1J+Sw7/3o+deHvTaiEK
	umrLsP1P7fgrQ3e/IKKTsz/Q8dZ3/AbFr6Ae3wtXotSaoJNeuvenbV/8EKHIvO95
	QYBCrvVb6LLVIXyWeVq7RBVrs48kfNfchhVSXIBVuEzZ50GXe6/m9D850WB6tQyd
	Uo8pmJjmPKN/0LJ5MJONVg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2fa3dg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 09:53:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60K9PE0v017988;
	Tue, 20 Jan 2026 09:53:12 GMT
Received: from sn4pr2101cu001.outbound.protection.outlook.com (mail-southcentralusazon11012060.outbound.protection.outlook.com [40.93.195.60])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4br0v9cy6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Jan 2026 09:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y5HJlLAGAlXBPriDSb7pMowR6CNsTRJqFLjdvZFTggxGQB9Ynfq0C5OkFXx1fKpRFqHqLczR7U1DRtmMdU1BT5YvhMppgPraTYOWuLZmM/516ppbyz264nD2hvIogL+e6MQh2r+qyLMiv9l4v4NdyI77+oC7UVOjMxra3gBh70GlIjfHr/Fos9qUDrVnn9pGi7G0tRP/pvmhlR5BbL+1d339CSwjggV3HgYP3f1HhHv6axx2hT6bP8FnIAyTZJQVFpCR6+gXX5XIjkrejJXuOQj+UvVN3sgwRJpap6UOqAfFnjBJDDx3TEnZczr4NbhskRqAIT4YkPnLbdBeblkMmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PQe7vbUsfycYaakp8cad6wfjtsGJbMlOhLdaT4Smf7w=;
 b=Fi5NHt5uVn7qyx12JEZnj3ON8rS+0dCaqctyTG489N4ubU4bwTG+5htqYFL5gbvT/KrzUTEiX6QkQGdcKE1upNdDKat/JeMxtZEtQRmtU9z/hjp3k8N8MjzN21VnQrGwi6Rqocny5od6oiW/YtRNJiYGrV+zSdleyf13cu7vbUfcbDBrPQLxbp8DrtdqBoOsofu7LGJJs9lg3s5oMSliL/g3mzhIl630K/5QfRa2hNui6DmzUkm+hrUofnZywGBe6eMU3+anEHVArqXnfT/D9Hb36Id9JbGdaFbzPjbXcKArMaZmufQY8y43BNkSFmUQu6pYcUB+lXd5Ru2fS3vz7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PQe7vbUsfycYaakp8cad6wfjtsGJbMlOhLdaT4Smf7w=;
 b=QjJKKE5GLwqLPb2E8twVW87XNzANdcGbQoT1qjg+gCmmuMij7RYIGgGpSrHrSKJcuzlJmnUbSIV2Oc/eJ7Oc6G+5CWRwwvtlqi5K5WGtFNtPr+NeYG76chXqkj0YjQeGMHE0qfkYGhlYj01thyDtw6BeJm+mUyn/M9JMjtqPDm8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CYXPR10MB7973.namprd10.prod.outlook.com (2603:10b6:930:dd::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.12; Tue, 20 Jan 2026 09:52:58 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::3292:21a0:97be:4836%4]) with mapi id 15.20.9520.011; Tue, 20 Jan 2026
 09:52:57 +0000
Message-ID: <f4b8dc11-e697-4be3-a500-c4373e913628@oracle.com>
Date: Tue, 20 Jan 2026 09:52:52 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves 0/4] Improve BTF concrete function accuracy
To: yonghong.song@linux.dev, mattbobrowski@google.com
Cc: eddyz87@gmail.com, ihor.solodrai@linux.dev, jolsa@kernel.org,
        andrii@kernel.org, ast@kernel.org, dwarves@vger.kernel.org,
        bpf@vger.kernel.org
References: <20260113131352.2395024-1-alan.maguire@oracle.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20260113131352.2395024-1-alan.maguire@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0560.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::18) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CYXPR10MB7973:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f3a7ce2-dd9f-43d6-4f3a-08de5809b0a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?STV1OTVZMVJVdTlWV05KdDZTNldLYXIrUk8xZG1sME9razZONEJXSllVM2t6?=
 =?utf-8?B?RU5BeSsvVVZsSFI4d2RSdGZ4a0hrckFnL0FyTmwwcWR6Z3FrK1I3ZTVLMi81?=
 =?utf-8?B?TkdrU3RjcWxGR0h6R1Y2ZDRXSUYvQzRBZ3lnYUw4c2YvSm1uVEpjbG50Vjhq?=
 =?utf-8?B?MGltMmZUSWhFQ01nalo1aUF1cUE4YTk5WjZUMWZXOEtDU3N0QU1vTU9IaU1o?=
 =?utf-8?B?YnhFbEptT3ZtaFdqcGl0V2hjZmE0YkxVNXIweWVpc3A4TkdqR3RRVkpDTDJQ?=
 =?utf-8?B?akdad0owYUxmUythTllLNHdMNkYzUWdTQ3JRS28zWC8xamwyZ2gyUVJJWm9r?=
 =?utf-8?B?bHVrVWFzVEVsOWp0VXdLRkRDQlczVkN1YzBRQklZQUwwelkyYnF1R1pEeUpB?=
 =?utf-8?B?eTJrVW9hY1VITGpXM3pzQlNmemE0YjVIR2JJcU1CRXY3cnY0UDJKdzd6dlRk?=
 =?utf-8?B?ZVdPYmZnM3hBL29nMjhUSXpScy8vVnFjbHZGa1J6S1d1Y0xnUXV2eklaRW5k?=
 =?utf-8?B?N2kwZXdjVEEwd2xFMGhjS3U5RmU3MHdsV2RkQnM3Z05IMHNlOHFjTTRGb2xI?=
 =?utf-8?B?RCtaNkxDSWdPdEFEUlIrUlJmUjRjK2twL2JWWTlHZWZqazFoSmVTbU1IOTRE?=
 =?utf-8?B?WDkyVXovdmNhbnhnSFVsV2JrVXAvcUhUd25ES3hHcjBoSDZ0WTE4SVRtOWhn?=
 =?utf-8?B?eE91dnRneVJvbklhYThmWlp5ZUtHbTVNVDE0WGl2SVlVWGw5eFJHVUhpbC9T?=
 =?utf-8?B?Y3RTaWQwRUJDQU1OdUJ5TFdCNVpqZUhSRGtwa2VManhzWDZzRWhxSitYV05a?=
 =?utf-8?B?OUpXeUFZaWhsa1ZIOURHYUlqREpuSUYzVStwY2FPcTg4VS9BeS9oOHBJNElW?=
 =?utf-8?B?aVNrUWZwRThBcFBqdFpTWWVac0lLV3BlL3hhZVQ1Y3hNeGpQcmNsdlNjWm5w?=
 =?utf-8?B?QXNMZStTRHQydXhWWmlERE1aL09FZlAvTDZ3UlI2R0FRa2VVSWc1eUgvL0hY?=
 =?utf-8?B?N01TYmZncitObnpwcloyZE5ueDhtekpYRkZWVDhmMFoxcGlhWnV5WERsaThY?=
 =?utf-8?B?ek0zRnBsNGZrM3FEZ0hMMzNlNFdpRTg2N1dXNVlSd1k0dHUxN1UzRHFNdk42?=
 =?utf-8?B?U3FCOXpQRGd5Vi9Yd1VDOGY3bjBKYXpFdkczYWRKckwxbmIxRmxJenRub2oz?=
 =?utf-8?B?RW8zU2F0NVczR1ZuSkVjRnEvRkN1V2p5ZHVGckNqOWVjV25RQ2FMUXpxVkJD?=
 =?utf-8?B?OVFFMGFrY09QUS9ZNVRJREs0S00xaFFCdEpJNFlkY3hRZkNpYXdZcmhTR05P?=
 =?utf-8?B?bng4OGoxdEREeC9FNVh3a3ROczVsM09WWTlvRWZlWldoNlduT1ZYM29NeUkz?=
 =?utf-8?B?MXp0d2VLVFVxcENGYXN5RE5GZURQS3RjTDFFckVxMS82SGpLWHh1SG9UVGxn?=
 =?utf-8?B?TkVKckVieEJvaXpHZHRtdnZWbjh0UjQrUFA5bWd0Z3RnYThtcWN4aE9yQzlO?=
 =?utf-8?B?bnpUSC9FQTMrSHF3QTQzNHZBQmwwUzZhOG4xOTRzd3g4bHlPRlE4c1E2TCs4?=
 =?utf-8?B?OHA1TllEVFo1ME1COUduMVFNV2FLNkU1cXN2Q2YzOEc3VURYQzB0SzlvSjZX?=
 =?utf-8?B?MG9ydVl0OUl5RU9kSE0wSEpkREhnNklFRUNJZ3pGZUFHRkNHN0pEcTZ5UmVw?=
 =?utf-8?B?Z2FjdFRvdEl2dENiTWt4cU5SeHY1MjNDKzVVTkpRYWMxcjViV0d0NnFmRXVl?=
 =?utf-8?B?MU9BSGY2dHFvTDc3Y1FERmdtVktqcWsySURseVE1TWRRSE1TT21tMXoySUF4?=
 =?utf-8?B?bGd0NVhUSlNFZ1NDSEJXVUl3RCs4eEhHWHduL1YwK1FITjFlRTgrVjZ0WUp5?=
 =?utf-8?B?Um5TQUtVQ2w2MXZFSGo4L09TbWNTc3NyREpKY01kWGtWZTQ1WWVGZExvcVRr?=
 =?utf-8?B?YWpqbkEweUk0aFhmdGdJMXNmdk9QQmswbXA0b3dmWk8rTXIySG5oTXBOVDRC?=
 =?utf-8?B?R2VidndaWTFrMnlUeU1nTkNUOHBvaDdtMGp2S1dSSkJLWitLbU43OEJGZUlV?=
 =?utf-8?B?QW9hK0x6bDJTYW5WQ2VRa0dDTmIyVHFjaGthN3Jwa24xVFpNeGlLdFVTOG9u?=
 =?utf-8?Q?7tdQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MklNVndsYWVuWjFueVRESVhEUnl2U3M5eWtwZzJPRjZMaURWZjJHbUJSeXlr?=
 =?utf-8?B?L3Y3T3cyVE14bnhiaXBsNnRWNUZrQlRKOFhJK243V0VCZERsamhaZkFYQnBB?=
 =?utf-8?B?QStIZHdCdzc1YVVPcEhjUmhzTXZJY24wZjdDejd3NktwWVNOU1h6M3ZOeXlV?=
 =?utf-8?B?eFBjSW80cGo1bjBoY0FOdEtob0FmT0F2VVJDbDN3ZFFpcHlma0pxZThhMVoz?=
 =?utf-8?B?cGlXeDVCemdjTFA5QzFGSjdVeFNWSUZTWFB4b0UvdFh5NnhkQWViY04xSFh5?=
 =?utf-8?B?YTNXRkJSTENrdVY4WU9XS3RYenBESGN1ZDRFaGF6NWcwRGlmYklmV085RVRM?=
 =?utf-8?B?bWs1c21aUXBHYlUzNFFzZTBTZVgzL092b2N5aDh1eE1BS2VVOXN1eVdOTk42?=
 =?utf-8?B?V0hiQ3NFczBEQkNqcHBEd01OT2N5SEpSTy9ib3I5TXFIUE5kTkdCZGllVTlt?=
 =?utf-8?B?TDl4SEhGaFNGdUxWM0grbHljbTBqdkFUYW5kUFBIR0k1bkFWMHZqMmVraWNt?=
 =?utf-8?B?MXVHeCtCRVVkc2Z3ZnpnNm9BOEhkM21SbnhPWlRNQVBEbFhxZTdrRTA5OFc1?=
 =?utf-8?B?TEhwYVF4Z3dQM0YvZmgxRVgyL01EcnQyM2ljV2ZFSFROZ24rWmd1ekwxZjli?=
 =?utf-8?B?bW5oQ1JhOWtrOTdyOGQyK2t3YUpYUTRoR285Q2xmbEsxczROajJwY2ExU0pr?=
 =?utf-8?B?NklzQ05FSFBOV3pwNVU4eVlSQStVcjBTem5ZQUNPL0luNE9abmhGQ295VXMy?=
 =?utf-8?B?M3Z5YTBjMjZzQkwzcWZDTVJETDZFSTd2dEIrWDdMTlNBem5JeDVZbFN4eGdx?=
 =?utf-8?B?UDFnUzR5QXp3TU1NWjZCYlpFbS9zYXhGVmdLeWx2Y0dYUy9EQktmM3dyY1FS?=
 =?utf-8?B?M1kyUi9kaG9USWd5U1V1Zkk0N0Nsb0dtbFJYS1lRN05JU25GU0lVZjBhKzd0?=
 =?utf-8?B?RlhEVGdFaTR2cDMzaEt3RlVGRWdMaitNOWp5dXV1RzE0ZjdKcDV2ODJCeWxl?=
 =?utf-8?B?OFBjeDAvYXZyYk92dURJWkRNbzV2WTB4b2FxY0hHTjBEc1o0WWlPTEp3ckJI?=
 =?utf-8?B?Ry9yVDRIS0hjM0pUUlZ6UkgweHhDaDV3NHJFWXNsUHNxaXVyd1VtMmhhbmpn?=
 =?utf-8?B?QkxaOUNRODR3amQ4eG1kd0hWNjRtbk1mM3VrWDE3OHdvc2F6S0gzRHNuTE8x?=
 =?utf-8?B?WnFTWWJrWkFDNFRWanQ2YmN1TnFFTm5OWnBaZzBsMjBBSlVMZ3FpUTdKa2s2?=
 =?utf-8?B?aG5JNmtHVDk5R1NnOFRPRlhZNUpJdWFhUk9ZVktSak1yTjRrRlVPeHhUUG51?=
 =?utf-8?B?bmtNaFZldm1SeHoveWlXRVBWY2pXNUl5VVNuQ3g1dmZyZlBkYThtYTdjZXdh?=
 =?utf-8?B?dTdnczJDbitYcUtoZDIwV0J1OWJNM29VOEN0OS9wWTF3OUVTWExLY0M1K1Vh?=
 =?utf-8?B?ZTQxa0luWWU4aEVNSXRZOVRMbjkxbURNTnV1aFNrcHBWU3JRMWFodUVPa0Nt?=
 =?utf-8?B?ZG1COVNZNys1Q3RLS0dIbm5MOElzT1pEUE9aSUVkb1lXVXgyTUR2amRxcUxo?=
 =?utf-8?B?L0NrYVZTRTYzY3k5NmhCYnU3M09EN2lVbWlqcU9IL3V3dkh4UTEvYk5WYW14?=
 =?utf-8?B?L3YvYzdZbUJWbGJ6U0c1QXIwNksvRDJvbVJvYzN5OUxaNy9wYnNnOFZHUS83?=
 =?utf-8?B?RVlEOE5JOHI4bkFPMzl3ZGhjbHYrbGJiaEtKSGZrS2RqZWNNd1VMNGF5M3dj?=
 =?utf-8?B?UEgxYlNHR2RYNmJ3YkRCWlZNcXlaaGxPVzQyeGZTZjQ5aWlZMjVYdS9XSlFH?=
 =?utf-8?B?cUJlVk1zQzBjcVJrdHBONmhHSTVpTlB1dzVMTENwY2RlSy9WZ3VPc1k0ZjE4?=
 =?utf-8?B?K2loTXVPb0RFYUN2TVZIRWxybWpQZXRlMkI3TW1LOEEyWGlKUWxlY0JwdTFH?=
 =?utf-8?B?OGZ4RkJxbTFGRzhtakVMaWtObDZtcVNKaDRDcGhNZlkvNXpKWVhiVlE5YU5W?=
 =?utf-8?B?VmZjbHlYSXRtbkRKdnA4MGd3MnlDczFNNktEbldhVWV5aHphVG9oajExRlRG?=
 =?utf-8?B?cDdLRWxXMHIyOCtkOVI5bFE3NlpobnNsUFB5d1pJMjNXUFhJcUlrbFg2UHQ2?=
 =?utf-8?B?Yy9uMHFTTUNoK1pWL0VQOVBtTHVuVmM3MWloeWJpa2EvUjdzcFd6ditmQllD?=
 =?utf-8?B?aWswLzRxVWZrSm5ici9xcHhzanhqSnhZb2taaE95eUpCT2p3MjBhY1lvUkZu?=
 =?utf-8?B?OG9DSzgzdE9mZ2R2cFI3ME1nT2xDL09aRk9oVUxPQXpCNi8wOXdoVDJrQkZI?=
 =?utf-8?B?QnBXZ2h0Z1dNK2h1aWYxTzRKM1FuMEFscDY3eXBqYkZYaXJCL0NyQT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	V6Kabo2UGTex3XMnklt9aQytPEUMQAbJzQaT8aNbbYDioOTitaIFtMGq3D0A8hFdyENaiycCFA9S5dZvH/4V0mV0+r5f7q48Z4ADCHHQGH4/dVHRVr2/6ueqWkQ5l1fcCp4MThbqRHX6yLg/f0qFovytb0sg0KDj9u8xNrAmse422eg1bMf6nRz0t6Ddox0D6dSWPak7WbTxcaF3s0vOI81oK6BfMoqyyxdoBKI8ZooG5ijrFNHpEstzSFoKUZFuPm26+09KdP8q04qc0bJEilsWxk3RvPeKjESFUNaUE0u/qNuhLkB0kWHtG/smSpR4NwBa0L1u73uEbQ+GH85xvfLC84cvqwbCt4cvGLssZjBkXG3rbflwWe6r8RLYYd/lf4qtgI9yNnZwiRk/j8AYCtC243yzB41Mkk+ldopP5RFcwne6k7ACaOBE/VD4MhYhEjYNIHzLAS6So77Pkvd4OcTSB9cqjIK6kSL2ypQ4Dq/chqf+KCM+I0df+BXcm0PLTi57m+iuU6m1FCUDY4Rn44kdFxPSVdzkvdexayZIGRTsPjd6OuSpBLAP6kdkZmrh5gXo3fPLLBdqGGMgsOLCnJoIvIrRpuf8tF1189WMMmo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f3a7ce2-dd9f-43d6-4f3a-08de5809b0a8
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jan 2026 09:52:57.7566
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OpAjl6x5LqzBzMUDS7dK8HEz2f1BLdjWyYfoqwas0TeySoeWcXuTscotaOy+oqrBNFI3V8UA3I3ZiCH2mg+VHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR10MB7973
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-20_02,2026-01-19_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 adultscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=631 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601200082
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIwMDA4MSBTYWx0ZWRfX3bBdoyuG+kDD
 jeabFYPBGL8J2FW8G+NTcoR+TDALiyrIgGOVJ/MFIopAH5NLGqDGBCZ1nrEKm0llMbsjIvWaikY
 m0v0TSsun1t7jOcsrpfrNzLUyZCCpkBj5VBFGwG4Xwe3miy5wnu0rG2eTy8N45aYYU3a+4a2yKL
 bALTtQXN3wL+S2KNSTb9vibH9BDRIFxUQ79kFGs6NFtIvmO9M5Sv2s68YvlxWV+mgxaMNrWNim0
 4iok3JXg1PB3csTNMCIzXqYTcJgJjMw3tcfto9VD1mnN1aUz+icY2M06Y087JFrATJaMswMWskg
 8y0jQI2PBjr+6CmpK2af40yGpK3Z1no/MLHnOSYdkekAoSJQSSus/iHYaUIpZMto7m2bREvtLbF
 4bW6ykubAOKoIXIcL2+CD/KvH50/zbEqPgsTdPfCboNGlARhnlkUaPRNUYU4Ljh9sSenbPjHMr8
 X/0V1IONih6yOM7Xn2A==
X-Authority-Analysis: v=2.4 cv=HvB72kTS c=1 sm=1 tr=0 ts=696f5089 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=bQee2gRIvITMQXyztsEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: RQz_IcFEIgfgjriFBsvc94Vox3weN8pJ
X-Proofpoint-GUID: RQz_IcFEIgfgjriFBsvc94Vox3weN8pJ

On 13/01/2026 13:13, Alan Maguire wrote:
> This series brings together a few solutions to issues we have
> with accuracy of BTF function representation at the binary level.
> 
> The first patch detects mismatches between concrete (binary)
> and abstract (source-level) function signatures as a means
> of either excluding them or providing a "true" function signature.
> 
> Patch 2 is from Yonghong's LLVM true function signature series,
> and helps for patch 3 which adds GCC true function signature
> support for optimized functions; with that support, we use
> binary-level signatures for .isra, .constprop functions and
> represent them with their "." suffixes as BTF_KIND_FUNC
> names.  This allows for fentry attach to such functions, and
> the "." suffix is an indicator of signature modification.
> The feature is guarded by a default-off BTF feature because
> older kernels did not support a "." in a function name.
> 
> Patch 4 is Matt's patch to favour the strong function
> over the associated weak declaration.  The other patches
> are important prerequisites for this as the patch selects
> the binary-level function (with a lowpc value), and in
> the case of optimized functions we were often selecting
> the .isra function with optimized-out parameters.  Because
> pahole did not previously detect this correctly we ended
> up with functions with signatures having reordered parameters.
> 
> Patches 1-3 help avoid this by better detecting optimized-out
> function parameters.
> 
> With these patches in place, ~20 functions are omitted from
> vmlinux BTF; all these are "."-suffixed functions which
> we were not noticing had optimized-out parameters.
> 
> Experimenting with adding true_signature to BTF features
> we end up adding approximately 500 .isra and .constprop
> functions to vmlinux BTF.
> 
> The true function signature support here will also hopefully
> help pave the way for Yonghong's work on the LLVM side.
>

hi folks, I'd like to land this series (patches 1, 3 and 4;
patch 2 isn't needed right now) soon so we have Matt's
fix in place; if anyone has cycles to further look at the patches 
or test it to ensure the vmlinux and module BTF generated doesn't 
cause problems, that would be great. Thanks!

Alan


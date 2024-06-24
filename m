Return-Path: <bpf+bounces-32938-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B0E915785
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 22:03:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 048371C2363D
	for <lists+bpf@lfdr.de>; Mon, 24 Jun 2024 20:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7395245976;
	Mon, 24 Jun 2024 20:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LUfYigoI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sQnHwXoS"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4000FBEF;
	Mon, 24 Jun 2024 20:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719259431; cv=fail; b=A0RNrfj2cOWzpxTWsg0eZsSkVpErExKSAq6FL/Nr5AV8rG1cThsPvpmx2VbIqNEtHljwCxj26zMHS7iQwYrP6Ba+MKxNiyzHvq6yG64f7/QrLp+vCJswuGJ79VHmdQwa1C5GjDyqDyyAQndkZ9O2SjS8jfooqabwhU45cZLeW6I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719259431; c=relaxed/simple;
	bh=akQ4Eq2TIN5L3GNuWtMsV51bYm4rjI49ipxd8bKWuuA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LOKSbBFuf+mhM+hXxwGekOTHAfo+9g/Nmp0XM7J9U6Yk1WkpkcV0zD6u8aSdAm0hXSLIFI+/eOTUtbFBCZyqk9AcWzU7uv3ysMSKLjmfDOQ3qQodFJ+W6kkcM2dWSqE4EoZXUGtN+J6AcFMbaTtCpnEovVm0pM9gFLXEKgkDNug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LUfYigoI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sQnHwXoS; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45OJnAdT030857;
	Mon, 24 Jun 2024 20:03:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=EiOxeu2zWdOp21YJz9MNdjZkyN0mf1H7tM8zQLaNBvs=; b=
	LUfYigoIrsW27X1+jeDeJImRA+IVKfCl/S3CDCl+tFQ3pIRyQ8fyfU0fiT2iaepS
	EFGrpP1+UIgITIzIu219aNHgcR+cM9ruz4IaFXFaRXiTPjL3BF0iDVr2y8jEawYr
	MmbPvLsBcMeQqI9WrY7IID/g9owf/C9AfabMeHDLQsEhM3zVOiSAGCTtAjBmjUEs
	Y2QkEq8kSjNn1mRt7LH28m0lmykppLR6QBT+QJvendk4SKrtAcfcPwVqKgTFqEkB
	VslSM3MTVm+t2KZ7HZJw3jV+1887kWLlQoGKFuNVg7469F3CIOlkC7TBI5KxkDVF
	KoJo+WRDsVBkdmXAkmo5lw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ywpg95w9q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 20:03:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45OJVGM6023503;
	Mon, 24 Jun 2024 20:03:21 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ywn2d3j7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Jun 2024 20:03:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=REigJvn3atyB2G7acwvNw+zOZJvdTXdrIRY7h+pPnp9uai1nD67FV5BCmPt3/kGaxuv8mUeM4JWAiLygZtwEeUIgi2PjB2oWqpixRwE0HdQ91OGv5PNstWrzO6PJ+QEzGJ7sri780Yyh+FGhMWdDj5B8R/S9h45cGsGaeC2ZmQyHIYOqf/FE2dmHVCxTDiI8GQQ9PP2JSIpqwus1VcIKKfUHiKLtlHa/SmgvWO1a7Pgsnzzd8fCb+iUA1xqjREEWaTuUcjt34G/d39Qrb+peKreitxRDyBJVEe8u1IM1DVdOQXS3yoP2R38alDH9OkXmccbVlCF7bHkDHioK4ZVQ7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EiOxeu2zWdOp21YJz9MNdjZkyN0mf1H7tM8zQLaNBvs=;
 b=Iw+xHgqf8FGiynYzJzkkhS3RVU0tawwfjCxBiczfTcRN4Ex8pZJdD3ZsfWz9nnxxYstNgIb2Ze/8Ks9yCdh8PVmz2UsCEenq7k6ICqxRhM6eBLtv7vTUxUjrMHxlF8p8WYG1Mgu5Ojx1pVCceILQtcgYMOM5P0UAkxhP1l3Vm6jCXe0t9x2iA7Nbg6hlFy9Y8UNOYPITmGtvp2aax+slKCpMF4VXZy25GPB5hO4n3he4GjJ2dg7iUsbDQ2oOvXIoM9HSh3sCVzQ4xUHzWP5mOPkGfxdFEfLHuZoSYCj+x2QKeo2sKqflAkQ5kCBxGPEgMJpyQNBNmcVFDCTPiE5lPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EiOxeu2zWdOp21YJz9MNdjZkyN0mf1H7tM8zQLaNBvs=;
 b=sQnHwXoStx1/G24n3qhmwrFRfVDEIupxE2sO3V+hTG2qvKsgIVZRPp0UY+yXMwuIV9thF0EMilbG6rmWjswdslu0XI/K8o6YqRkJQcbWN6Kr/yCNTLZzQeNFIoNDGVW+4vo07u4ltLlAAsr4wNHursKgIbW6j4BC5mlm76pEUPk=
Received: from CH3PR10MB6833.namprd10.prod.outlook.com (2603:10b6:610:150::8)
 by DM4PR10MB6109.namprd10.prod.outlook.com (2603:10b6:8:b5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 20:02:52 +0000
Received: from CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485]) by CH3PR10MB6833.namprd10.prod.outlook.com
 ([fe80::8372:fd65:d1ad:2485%7]) with mapi id 15.20.7698.025; Mon, 24 Jun 2024
 20:02:52 +0000
Message-ID: <c5f6abbe-de43-48b8-856a-36ded227e94f@oracle.com>
Date: Mon, 24 Jun 2024 13:02:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf v2] af_unix: Disable MSG_OOB handling for sockets in
 sockmap/sockhash
To: Jakub Sitnicki <jakub@cloudflare.com>, Michal Luczaj <mhal@rbox.co>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        john.fastabend@gmail.com, kuniyu@amazon.com,
        Cong Wang <cong.wang@bytedance.com>
References: <20240622223324.3337956-1-mhal@rbox.co>
 <874j9ijuju.fsf@cloudflare.com>
Content-Language: en-US
From: Rao Shoaib <rao.shoaib@oracle.com>
In-Reply-To: <874j9ijuju.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0060.namprd13.prod.outlook.com
 (2603:10b6:a03:2c2::35) To CH3PR10MB6833.namprd10.prod.outlook.com
 (2603:10b6:610:150::8)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB6833:EE_|DM4PR10MB6109:EE_
X-MS-Office365-Filtering-Correlation-Id: c2402557-bae9-48df-a4b1-08dc9488a167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|376011|366013|7416011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bXhKa1c0a2hHVUFOVGxuaVlzeVhVa1YzN0JGbVlTWCtBNU9tcDhvWDJIUVNB?=
 =?utf-8?B?R2hHRHNCazdoYnVTOVRLSHFMSlVQaFFEUTJyYlRvWkFHOElvZEFObGE5bzVr?=
 =?utf-8?B?TFhVNm9hQXBFV2tNQklMZFdQWnYxVTAzSzRZRzhpTVhrYSs4TzlRYWtYRnNS?=
 =?utf-8?B?NXJUMmhzRkE4dHRPc3hNa2VLd3k4VmFMTWYxNndOQXpxR21Edyt5SEpjWFBY?=
 =?utf-8?B?WXhFM3ZkZzJFUlY2Y29hUVpKSURRTkwrZEpaUzRoUnhRSUhjMkhuenVVRm9L?=
 =?utf-8?B?VHVIU1pSb1hoRWdvcm5XM21kR2JPeTZGZFo0Y0hPSVBmdktDSmtyV0hXdlZx?=
 =?utf-8?B?YkpjTjlQWnJnalM5UFFoWTQxNjZXMlBzTEh2U1RydFh5TkgzRlp5RHRXK01H?=
 =?utf-8?B?MzFZcCtJZHcxRk9maWhlbTJIait4UE9lYm0vYlVqYkRrMmVSZW5zaFF6Q29n?=
 =?utf-8?B?K0NpbU5IeEo0SkdMRTJYMmVPcGtPK2JkeG85RVZKQkRBdVhFUUJJR1E1d1lB?=
 =?utf-8?B?MzFXVUZ3RmFwaWxIV3RUVHdVM1o5ZVhpQWc2YlpzMU9yT2V0a1VPL3hwTm1E?=
 =?utf-8?B?cFhscXFhY0N2UldlanM1QXQvY3Fvelc0NUdDc012Z1cwOEVrQ3FEbHpBczlR?=
 =?utf-8?B?dkJWRkJKWTl6WjZQTlI2a3ZOSGk1ZTU3OFAxc2ZZS2FlZmFjYUNHandEd3Nn?=
 =?utf-8?B?ZFJyWEo4eW1JWVRwQm82SjZUNTVTWVR2eEhKUHdKb0tEVHRBMmZOc2tDU01w?=
 =?utf-8?B?VitkQkxZa0lZbk9DQ0ZtMG50M0M3TUZ1VWxhQVk4QVBZSjhyb1lnQ0tURnB0?=
 =?utf-8?B?Y1ZCVkpVZGp5bWREUm9PN1NoU3JqUHVodk1ySE1uWXhGSE0xTUtudmpBd1FZ?=
 =?utf-8?B?UWJMRUYrVlVxREZrbUZrNGpHUVdQVUdLMExxUGtPS3JtVGlhNTZXLzErR1JQ?=
 =?utf-8?B?OVdQcjkrNlc0VjkxcFc3RmRkL1g1bWRYaTNwKzV5YTZ0VUt5c0JZUFY2b0F4?=
 =?utf-8?B?a1JXZ2RlSnVxNFJUS3ZoUlR4ZGpjdy9qdkUyUkdPZlBhRVdRSEVPZ0FROXJB?=
 =?utf-8?B?YjY5aUNReXIraTF3ZEhMdEZvL29KVHRUNnppaG9CRlVTN3FqTzYxVDlUNnkz?=
 =?utf-8?B?R01FNUhWSDEwaEExWmdGdnpiUnA5WjVyR2xMS3JhcHZyT0lkT0hXVm9jTysy?=
 =?utf-8?B?Z2s4L0tDLytLdWdzWGRHNHJYSitmVmtmWElrTHRmS3lWK3lPWEZKem5FWVpP?=
 =?utf-8?B?RDVUOW1TNEdUR2hxYkdGVCsvUWxYR2MyZkR4UExVbWJUMXY3Y2tZdUx5aDFX?=
 =?utf-8?B?eUNLaTNMZ00zRmNraTgyV2lqR0hyVFZRdDQ2RjJHWnpNblQ1NktGR1NOUmNl?=
 =?utf-8?B?QTA3amhBZ2ZGZWNYZzZXbHFZWXBxSUp6SStwWkJnS1diU2Z4Z3NEYkVPa3lo?=
 =?utf-8?B?RjJsSFhaaGREZDZKTVF5WXhyNWIxaUVOTzFubThFa0VydDM1cFRBTkd6MkVB?=
 =?utf-8?B?NExHa3U1OU1yZFVNckZGYkttVzB1OHNFeHV4amgrMUxNbUpCckdaUU9jcHFy?=
 =?utf-8?B?eHNNa0R2VXhPSUFaekpNLzdUSE5hR0h1ZFBRMzZOUnJINi9ZWnBXREF3QVVG?=
 =?utf-8?B?RVdqbUdOWENHa0dzWFNKMDZwZDk3aURQNFlNTWpSNXZESjNReENVTW9hOS9a?=
 =?utf-8?Q?DoFxU0lGfTwDO1aTN9Sz?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB6833.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(376011)(366013)(7416011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?a1RSWGl4azhNdVlYN0hIeVJsVjhmQ0V0UmRuQmNOVmdzQUZFeHdBeUk4Nyty?=
 =?utf-8?B?UHlBUXlPWUlESTZNNTRpbk5BemgyYnN2TTdHVXNuKzRXNklXUjNTRHpCMG40?=
 =?utf-8?B?Yjc5YndlYjd4R2lFTmEycnZwVCtyY2laMEJmMTN3aVBkTFJvakVseXpHbHRm?=
 =?utf-8?B?ZHp4TjNwRGtYdm1LOElqZlBmOWd1bEFhS0ZkZXJuRWRnVUY3RExBSzFzY0hN?=
 =?utf-8?B?QTdBbG10MDFzUVpyU05FeThIQ2xHcWZjNW1hbjJjakthenY3Znd3K3U3Ym56?=
 =?utf-8?B?NG9OdmQxWGdHL0NxOGU4dnVhMHpZd0JRUG5IVFVBYXB0MmZsdjZvZTV6SHFL?=
 =?utf-8?B?RXplWDVnR21VLzJXZmVHWVFWcUxxSGdLbEI2emdCRjRYUXFpZTl2NityYjFk?=
 =?utf-8?B?UHozMERheExUdld6SE5IdWx6VWR2UjdSekQ1WmpvWUNrczUrTEprdzVyZ1hr?=
 =?utf-8?B?NERhSXpKRDNkZklqNVo5ajRqejVXMU0zdHkwUFVtK0owK3IwUk5yandPczlz?=
 =?utf-8?B?dHdGdiswKzVzV0tGaVN2TnRIY0I5SE94T09kb1h2Q1ovZDEwRkJsVUpadkNa?=
 =?utf-8?B?MHBmcHpkS3hYcVVjUU15RmZPRWdPeXkzNVJWcEswUzAvQWJLdENyU0V2TFVo?=
 =?utf-8?B?SEx1dW5UeG1oa0tDSktzMkJ5Sno1dHROVGhLck9ISEpjZ3A3a1dxR3JKVlZT?=
 =?utf-8?B?ZDRLODFPSHA3enlIWDd4MUJaY3NmcmlIYnJuejdQRStqM0ZoMVc1M0JXeHg2?=
 =?utf-8?B?MStvMnBlNStQYmZTbldhSDNtRHFkcXE2VUJPWThORUw3dHptQmxTMXRxNzN5?=
 =?utf-8?B?dkhESWNoSkVJenZmR3V3VWlrSUZ6RHlhK1NSWEZuZ0ZxU0hjcUxpaXVZakZZ?=
 =?utf-8?B?MUhoN1ZNWXcwWXdJMzJTNWNsK2xNRlBzMHpOZkNXMEpGYlV6K1l1ay85amJJ?=
 =?utf-8?B?aWtJeGZKMnZia0laaFQ2WVhYU0xuRmMxWis4MlllcGxGZHdzOW1OL2VQeDVv?=
 =?utf-8?B?OGhEcGpTamVVS0xEVGJScUNjS1dBTmViUHpWeDBiSlY0UzlGUTJmV0twVjcy?=
 =?utf-8?B?RjVQVFk4MnVERjBhSlBXREZJSnFKNS85QlhNeXE0anhuUTc0TWZVVG8rczBO?=
 =?utf-8?B?Z25rcmw1aEdoMmpGQzlULzJHMWhweXFKVmdWMCtuNjR1UStGVFJwcXlVRGw0?=
 =?utf-8?B?Y3kvck1oekFtNmlqMDBROVEvUlkxeTE4Njl0bElSRmxUVVEyWXhHVW43bVpa?=
 =?utf-8?B?L0poV0pNNkVnMGxNRkVQdWptVXBuQWwzSmdvM2RUWEhqcENhSU1TUVFFL0dM?=
 =?utf-8?B?dWd6U24xTlFaL3dxUy9XNm1BTVJsQmZIVGhsMUZjUURNenFEUTQzTVNLcTlX?=
 =?utf-8?B?VHZUWDlNbnJFdVZ5WXd1NGdKQ1RIcGdDSmM5anlueDlGc3c0dlN6a3FhNXVS?=
 =?utf-8?B?aEV3eDNMdjIrR3B6TXNodmpLSWUrYVNUeUJiQkgwQTdZUzBpUDltbEd1TXpq?=
 =?utf-8?B?Nm5hcWFUbkZyU1lueW11ZzVWS0xMdG96QkNtMW9vc1hKWUw5aVJnczRLdk5N?=
 =?utf-8?B?VE4xQmNxWlhhUGhKRGtWK2FOZGlyMnBDRjAzK1ZBWVdlS2JoSlpKbFZxc3B3?=
 =?utf-8?B?VHgwMUlJZVV4ajRUc2ZTbmRmOEsxdit0bElhbGNyQkdXYkNaUFB5aFMxMGVB?=
 =?utf-8?B?aDhjV3pJLzYxenZPRW9HWTZURUhYUGFLbzViWDdDQlZlblBSSUVLODgzVmtH?=
 =?utf-8?B?SWt2Q25uYmlXZnhSZEhuOG9EaGliK3NTYk9YVTgzVHhtRVNzZUFlTVRFcTdB?=
 =?utf-8?B?SXZuT0lpQ3lQODJQcDdKWDl6N0g2MHBsVVBPWUV5dnhPUERoWmVjUU11OFBk?=
 =?utf-8?B?ZFcvVWo3aE9BczVVaXZnOWZibG8yRURWanErK2dSY1hSVnE2akJ5Q0RvRUty?=
 =?utf-8?B?UnF2SFE2eGZkZFVtS3YyWUtjUmNMKzRUSG9DZ1U4T1g3b0Q0bVJUWGtZeXNY?=
 =?utf-8?B?Mmc4Y0dRcTFzcmtEUkFHTi9OakEzY01zbVpXUHhvT0tnZ2NKMnlWU3JsRkNY?=
 =?utf-8?B?NlY4WXUzMGRLN2xycmtJTENPQm5iWkxLZGZiWDFpc0pIS0ZTSnNvLzFPYWp6?=
 =?utf-8?Q?zYeSTVGV26MXeYqzJtZJ0bjkr?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	2HANMtfPj9HnX8S3K6SXeepH48EoewG4Mhf/u38b/PCcpFnJ/1UWau01hlGs1Y1IKrB7EaYSGW00Obp1m7TqhzgF4tQuexz8htdXmedIYktu0RgMdzn9Macb8BPfxtPUcJ2tulM5LKa0QJ4oHbwI8hg5wzayq1DqOa/OmpXls3EH0G3hY39d+wx9udr0WTBkni47K+MbFuaMI3f2DN1i10h7/ebOD7xqzBjaTC4+F5nyVkw6Ept+jF+wxHB/5TYAlOo5ktO4XQZpuIrjiojqYWg+RVWXO4uwiQHM6SDlgi38gG4KxUa1IiKXIcqAgcUhGlVPBjqbMQspFXPFBG9Y0a2LhaZewrYaO0oaBdamyPIDCDS2UedOUprmShj1UZAw95Wzy+ZOA4TB7dczijLulrwuV5TcAYF/NyXU3a/5ynlpzOH+qQb02EdLNUB8bEZprLiBziTqQ9cuFX/EIQln4+DvOuQ9ooDqxFr233ljEyhNo69tYWnl7gJ8OvvssuMCmvhFFCfcultWoUilLJXHxArb7E+iaURTZI8DJ+0CHyM7A0Lrm369dtWcPYCT+kBI1Z10kJ28NSFxA8Fz29FM9lp8IIyIfK/jdaI2VQE1x/g=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2402557-bae9-48df-a4b1-08dc9488a167
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB6833.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 20:02:52.5552
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0eklX/Byw1+EtoxKf+Fb+gz7nICepnK1GLMS3W3vtlXUZUNXRL3txXcSRVWbtdSLk38dH9OZebXH01zZi6i4rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6109
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-24_16,2024-06-24_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 phishscore=0 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2406240160
X-Proofpoint-ORIG-GUID: 2jJU9pIeiW7tGdkDy_BBf05-0yv2GvKX
X-Proofpoint-GUID: 2jJU9pIeiW7tGdkDy_BBf05-0yv2GvKX


On 6/24/24 07:15, Jakub Sitnicki wrote:
> On Sun, Jun 23, 2024 at 12:25 AM +02, Michal Luczaj wrote:
>> AF_UNIX socket tracks the most recent OOB packet (in its receive queue)
>> with an `oob_skb` pointer. BPF redirecting does not account for that: when
>> an OOB packet is moved between sockets, `oob_skb` is left outdated. This
>> results in a single skb that may be accessed from two different sockets.
>>
>> Take the easy way out: silently drop MSG_OOB data targeting any socket that
>> is in a sockmap or a sockhash. Note that such silent drop is akin to the
>> fate of redirected skb's scm_fp_list (SCM_RIGHTS, SCM_CREDENTIALS).
>>
>> For symmetry, forbid MSG_OOB in unix_bpf_recvmsg().
>>
>> Suggested-by: Kuniyuki Iwashima <kuniyu@amazon.com>
>> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
>> Signed-off-by: Michal Luczaj <mhal@rbox.co>
>> ---
> [+CC Cong who authored ->read_skb]
>
> I'm guessing you have a test program that you're developing the fix
> against. Would you like to extend the test case for sockmap redirect
> from unix stream [1] to incorporate it?
>
> Sadly unix_inet_redir_to_connected needs a fix first because it
> hardcodes sotype to SOCK_DGRAM.
>
> [1] https://urldefense.com/v3/__https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git/tree/tools/testing/selftests/bpf/prog_tests/sockmap_listen.c*n1884__;Iw!!ACWV5N9M2RV99hQ!K-FmI13Wd7NvcxnWmsgoiqJtOSe4b4ydFXIvMs4JFOWWesx2LLtlg8LG22_Fd49e67cl50SdkB4JFg4-$ 

I would like to understand why this is not an issue for TCP as we try to
mimic TCP OOB behavior for AF_UNIX sockets. However, I am out of the
office till July 8th and can only look at the issue after my return.

Shoaib





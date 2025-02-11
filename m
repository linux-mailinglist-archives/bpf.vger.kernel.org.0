Return-Path: <bpf+bounces-51128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 89260A30879
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 11:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A011677A7
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 10:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5000C1F4182;
	Tue, 11 Feb 2025 10:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j39NyGiK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EFvSG2Yp"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2AF1F3BB1
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 10:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739269665; cv=fail; b=soBYAbtfvhzQoC7Hi4tBdVSlWupUuwjktzGuIgMbO9hQ+vYOwKEc3qxJwyik4FVlSbecg6IKuS6hOVV9vwY7xMcKLv41pWGnttZDGhrKsz9PVCM1G22qKoUS3ni/ng+yh6Nv8QKktCzTerAoBK91wF1OM0eLDQ/Mt7OKAKDaHmo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739269665; c=relaxed/simple;
	bh=nZ32p2kIYZPlucaPWCcU593OKH3+MYSV3ckOYOEAPx0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PvRgQEYdI0raT7EUuYlfKB2v0aA/e+ZWJtHxb83cFU5pMpZ9vKRVGpwoM1sqQcGacU30UxwWV89LgfyTHtwLF75ebvZ+qiBkrKUeddbopJkW1n3vCBTwAuj5831P0TL/R5UOezDz3hhYst2abk1v+K3wMgnPt4uxZw5u/p9hf7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j39NyGiK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EFvSG2Yp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51B7tdYs023502;
	Tue, 11 Feb 2025 10:27:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=9opH3vkRVn4JMgUPEHEGYUz3buGfx2rHjKzUcAOXw7M=; b=
	j39NyGiKSeAi/ik2OKgHV3GxsQ2EK0/bFsbA+A3+I3WDA3rz44ZOnYMeoPVFrtRj
	MCrds/zF4OvTnedCOoCzN9NWEUGPTWl8pLKzJPajJOybHI+6zdlEmA9kjTzBIaFI
	AZ+SSFb5TlVRiIwFrYE67i9/RcMRhnqoAf+SnYezW8sJiro1GJeme2Fbdd1+H/2u
	sGsUAEbH27OtlFZ0jIOxe0oNjjenKpliHuquNRPKrM5lkwQIlaigsJASt5lLJmG/
	MRSGQIgGTmtka8CZ0ZTXumG5f/L9X7sB8fUIzbzdJfjvJL16Ow0O9/cXwQBAypPN
	GB8D8MST4JwZ53hYO1wtOg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tn4uj5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 10:27:20 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51B8KEfl012554;
	Tue, 11 Feb 2025 10:27:19 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwq8jmnu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Feb 2025 10:27:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PoM/vE6opgXnLdeuSY1b/eGVCSuA/degQCfyqvjf1XWphQHicjpeCtxlyqQ8zqVOc0+sADHQf2JE5eOjT62BQsVV7I3a9nTSnLZhfIw2wW+itnv2Xs2j1NkcJkQ4P0xUUzqeOgFrId9Uv0s7kZaF6RTgLNVQ5eHh2yWd5lJHdhhbaplUy3Xt4j1UjiMb1iCjANTt653XmnQbJJieOknqGbZIdeSjO+Ylqam0P8dTbH1hWE+jqTvighyrqaO5M7XWKA8O6/q8ukHnnSn4AOqPPsU7XUd1oA1T3AAlOA4iDDsjZnaqVS4nSc1M0oCs34tzK9Y1zmN6AxObrZeQyau4vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9opH3vkRVn4JMgUPEHEGYUz3buGfx2rHjKzUcAOXw7M=;
 b=WKa+TL98GCEdxsGUNQuZnBs6FCBqG6o/DJDXACcvDSlmK4dkbGaME74gfLwsI81eHP8EAjz/CEvEHC2iSDz+3UZnRzmBZA5YXyB8xLXZx9Vawn9eXtxfD3Wl7SIhw1siNry1rOuUCmrCqdy4ASyB8diGSa6h9aTlp6eDFsv89WnxksCmqg9wXNYy6zgCGRgPf7vDXOt1AS2JTODcEaUYhCQ92M/sTx8wiGZ2JkhhAgGq8OVc6nCBqTFkvfs4wMXj1Q2aZgI37I3VZ1YCgPldRXtQqXmJ815IxZ/W5lz37c8EN2tr84o7/C0FlafvdWsfase0m+de9ylEF4WY3YvIGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9opH3vkRVn4JMgUPEHEGYUz3buGfx2rHjKzUcAOXw7M=;
 b=EFvSG2Ypw50fyyPR1kh6VqNp1SFVx0QvsUyDavB4a+vii6BSPDqvOnMPs7dAKX9MSUU9iGfmFK82ONOVe7j4R8gqHaKMHCAzJeFYC8ukv/zOusazjy+x2A6bw0CoAvSmJt9MK2gm2CqPohePWngX3gvAo8UvEqLM1wN8uOYJM84=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by SA1PR10MB6447.namprd10.prod.outlook.com (2603:10b6:806:2b0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.18; Tue, 11 Feb
 2025 10:27:16 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%5]) with mapi id 15.20.8422.015; Tue, 11 Feb 2025
 10:27:16 +0000
Message-ID: <19509eac-c9e3-4c9a-aeaf-dda933f477cc@oracle.com>
Date: Tue, 11 Feb 2025 10:27:13 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf-next 2/2] selftests/bpf: add test for LDX/STX/ST
 relocations over array field
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, ast@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, kernel-team@meta.com,
        Emil Tsalapatis <emil@etsalapatis.com>
References: <20250207014809.1573841-1-andrii@kernel.org>
 <20250207014809.1573841-2-andrii@kernel.org>
 <3313c853-9ed7-4498-b78d-96713ff7b50d@oracle.com>
 <CAEf4BzZAOJMm7pdaM6DYn=_nhL9qA2h29V-itpQx=RvgyMsodw@mail.gmail.com>
From: Cupertino Miranda <cupertino.miranda@oracle.com>
Content-Language: en-US
In-Reply-To: <CAEf4BzZAOJMm7pdaM6DYn=_nhL9qA2h29V-itpQx=RvgyMsodw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PR0P264CA0227.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:100:1e::23) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|SA1PR10MB6447:EE_
X-MS-Office365-Filtering-Correlation-Id: c54e362d-33c7-45d4-852a-08dd4a86a817
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djJ3Qk9PM2wvK2R3amVNdmZyb3k1U2M0K1M1bW5pNWRmV0YzRXZ1dlFvZEN5?=
 =?utf-8?B?dm5YbE5ybHVjNmFnTTJZMmZ2ejIyTk9JekM0bnQycHNnUEhVeG5ldkRDMWVM?=
 =?utf-8?B?S25ySXozVlFTZXYrdUNFZWpnRGVoNTNNTWJlc2RFYmlaTno5a29uRlE0MFA5?=
 =?utf-8?B?dDc1L1RrN3BaOWxPTDVUMHVzUTd0TSs5Yjh5a1htSFQ1eDR1c0s5RlJDYlNj?=
 =?utf-8?B?UkY5YTlIcWVmOEllZm9SM3U3TFducXNacTVjNDhXeExzZDcvL0FuR0Z2WndG?=
 =?utf-8?B?eVpMM3pIUU9LT25qZFEyR0l6dkt4YXdOVi80S0E2KzJHOWJlWEdnZkRCenlB?=
 =?utf-8?B?M085UzR1QWRpcWNGRHpqd3JkZmtrT0FCYkt6L2xXZUNkblZPT3RabksyMzRi?=
 =?utf-8?B?VUFSZEdJNDZDTEg0VzNTdEp2a3Vwdng4MG03VHBoR2Q2aytqVklGRDJQTHZ6?=
 =?utf-8?B?RittNU9WZjhiSy9DTWdsVVpVZDcyQThIUUpjTDhTMXZ4Vi9oRnB4V0FTd2hs?=
 =?utf-8?B?V0NSNmEvWDhWNjlvallQZU0vVjh6a2VqVmRpSitlSHVqV0puRHZkejRUbEpz?=
 =?utf-8?B?Wk5QS1FDU2dUc2xERXhjbG0rT1U0MkVlOEFkUWs5WDdaY0owWjQwUFBJTFda?=
 =?utf-8?B?NER4M2IrT1hwK0ZMRzRaQmVFOEtnMVZPTmVvLzhnZDFmaXFWNitSK3Z5ano4?=
 =?utf-8?B?bkU5NzBkQ254NEk0WlZJTEZhcWdkdXF5TWJydUF2ZkNXak9JeFhIU2Z0RXVh?=
 =?utf-8?B?Wms0bzdRVmxKZUVaeGsvSDNZZnEwR2ZDWDJXNjZScmxWbzlIdDVWeHBLa2lK?=
 =?utf-8?B?MVlNNEpuSzlvU2EwSkp2MlMzM3Vqa0lnRVJkTjN6cFRhdW9sYThvQm05SUlF?=
 =?utf-8?B?TjdqdXdNVEswUzU1eVVtTWxaZmhBUGlHZndnZzl0Qm9Qbi8yazNhbE02ZDgw?=
 =?utf-8?B?QndGeVN0eDNlN2k5Q0NRb29JK2lianBPOHRDZWJLbnN1RFc3SEJsNHBCQ3lT?=
 =?utf-8?B?eCtya2tzRGJhVlB4L2hBcnJuU2F1OVF6MS9ia3JVMnpZQlorQmt6TWw0VzFi?=
 =?utf-8?B?ejYvK0x2V1JkOGRoc1F1NTJIMldpMjc4UVlBUi9iQ3RUWkVmZXNkdVo1UTll?=
 =?utf-8?B?WVVOdElaeExMcDlQZUtYUHZKQWRwY0lJS01hWDkyVzF4OXorbkNhMnhScFM2?=
 =?utf-8?B?dkx2aGhscC9DazhSL2NUUVRCYVZJOXNzTmpXSWNJaHI5YW91MUZ5REl6WFJR?=
 =?utf-8?B?K1llaXg1YVp3UVREZHE3MlhLSGptUGZiMzNpeHArVWd4NU5ZUWNRV1RPdmJV?=
 =?utf-8?B?dCtOWjlxWTN2c1JmeXBhUUcyYjhGamFqQ1BYNndRZkp4dWhrZmlWMTRTZVVM?=
 =?utf-8?B?THhJT2s5MU5hcVBIZ1hGL25PQTlLY3o3emdaMEFzeU9RUWRJSllwOHZPbGox?=
 =?utf-8?B?NUVMQUhRVzhhcXNvc2Q2T1JpbHozVmhPakJabExybnY0ckwvaDF0Z0ljS2Rr?=
 =?utf-8?B?V0VEZVFkZHZpS0c0RTJQbldHY1lVOXZ5dUFlRmx0WVpNa3V5TEljZTBnWWpI?=
 =?utf-8?B?VExvcXpISTBKbVpMdWdXSTMxRHpTaGJXT0tJOGZXbFhEQjlqNFN1Z1B1ckJs?=
 =?utf-8?B?Z3ZxQndneHN0VUQ4YnU0OWtReGVjdDlmNmdpd1FNOG5jZjY3VFFId3VVNlZL?=
 =?utf-8?B?SVA1bElKYTE4bW1idXp4bFMwMkIzalhWV2w5Q3gwTWlEWUo4UisvZnFhMUpv?=
 =?utf-8?B?K2plWnZWdTR1WnNzcTh4dWdQQnNMMnM5RFJJRXJWNStrTTBqREg4SFI5dWlt?=
 =?utf-8?B?LzlVYjQ0d3pBOVp6QzVNQUt3dmtpVjFpUGQvbU9sa1J1eUlPZlZ0cTVpak12?=
 =?utf-8?Q?iGd/nv5Yko7hL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?a0NDRDJSR3ZVcDRjMEtmSkh4N2JSbVcvT2dGNGhjbURCUWlrWHd3ZlhCOXVa?=
 =?utf-8?B?VmZXaW03eEFxVXRwK3Ywb3FORjZ4QnhuK28reVloT2RCd2hCT2FYZHArMFg2?=
 =?utf-8?B?WmJUZG5yZzIxanoyNnU3SnpyNEFoZWZPVW5DRnhsYmV4a0MvdXh2dHhURFUx?=
 =?utf-8?B?VWNzR29Cbzc0RlljdkhORjZEd2V6azNaNWJjWjBoeUV2R2w4ZzhpSFhwWDVn?=
 =?utf-8?B?YUhwVWFHbEtGeHRabTZJS2RibElqNVpGbWRqbnZ0eDdnc2htd1g1a2srRmRi?=
 =?utf-8?B?ZjB2YSs1ekFONnZNc0w2WC9JQ215S1JrUXRmZ0lJSDNIbXc2YTVtNFFWUjdj?=
 =?utf-8?B?d3c4cXVRbnlRMFVFZFE4SkNRdkZpVWtEZEF4dUMvLzMrbDUvV3RBVkxCVHVn?=
 =?utf-8?B?VEdiczB1Z2tHNWJpT0k3Z0JObjJoeFBWU1YxMXlvTS9ab0lHZ2xzenpjcWRi?=
 =?utf-8?B?M3U3MVVJSjJMaGZ4OVFrRnZOOVMzWkd5SVd4UXlvTjlyZlBuMmthbmZwSm4w?=
 =?utf-8?B?dTVIckhwYitOVDNwbDlZTDhqRkRzcWpNaDRIZmhteDBJVGZIaXAydzZFbXc5?=
 =?utf-8?B?ZUpDTjM3ZDl2RkduVzFreWUyQ2pnTWlJMStvMHRYcHZwcW1OdkY0T3prSFZE?=
 =?utf-8?B?QXZEU2JHQnIrcjg2THAwaUxJS0xCUFQxWGk1Sm5Ja2FqME1kaE5JL21UYWxM?=
 =?utf-8?B?cWE0MHBYcUVNYWlwaDVoU0tFeGoxTytBL0dUczNaaXQ2Vm5pcWNZSmNXMWU1?=
 =?utf-8?B?ODY5RS9LWXNIcnZNQ21MUkxWbnRZVnVMRzNnenRtd1R0ekFKUkM5VGdzV05o?=
 =?utf-8?B?WTVacUt5RkFqa2JLcVVEZHI1VzA0cGZUeTVNNHI5QkhXMldKWVI1NUlML2U2?=
 =?utf-8?B?RjlkYXI4ZUk1Qi9sc0NBMWhseUF4cXl6dVhiNG9oVENRNEFxV3hJSFRzNnEv?=
 =?utf-8?B?REZnNElCSFFOclo3c3RPcjdKMXFOYXZJc2JEdkZXZDR2VHFJRmpKWHRaMkk4?=
 =?utf-8?B?YlBlODhUNURPZk5mMm1pNVpKNXJXYmhUYnRDcVpRT3hnYUoydjFyN29ZNFVW?=
 =?utf-8?B?ZWloTEhrellSSE5vWlBOYXl5bDVyYm5UU3dKalpmSFh1Vko5dGIxOGRTMTdP?=
 =?utf-8?B?VFVZUmZVYmx4RHI5UXdzRVBZKzgyeWJDNFZKcTlHa291VDdiaTBqZy9CY0lQ?=
 =?utf-8?B?MFVKM3MzVXNGT3JqZTlCNDI0SXRMQXpNenhMODRBakRjTnNRTkNwK1c4MjNS?=
 =?utf-8?B?RkFWcUxrUW9VS0cwNjFSZHJ3OEYwUHR5ODFwRTJlTTY2cGtTRHRldHlrdXBw?=
 =?utf-8?B?alV2MENxR0ZPenp1REk4RGpGWDl0amVJM1Z1UXB3SEhUWTAyTGxnVkM0M1FH?=
 =?utf-8?B?R1BReEtJWGllYXdtVUdFdE9jL21RczBzVEJzT1QwWHl0NEQ0bXpVVnVpdWNt?=
 =?utf-8?B?SmgyVHpZRWtJS2JDRUFtbVJ0WjJGTUx0REhHWkM4emlPUXZEdUMrNUZRbjZM?=
 =?utf-8?B?S1UvTmUwUVNRaEZnbHd1MTZ6a2ZndkFpcFp5Nm5WZ1hEbmk0Sms0aEw1WWpy?=
 =?utf-8?B?b0tBcER6UmJVZlNSemFsU3l3Zy9VcjU3VXZaVWpxeSt3STdvSGFWY3psTnFZ?=
 =?utf-8?B?NTYwRVBCZk1tMkpsaVl0YWE1MjF3OUlRdnRYSmlyWVA2U05DbFVvNzB0NDdi?=
 =?utf-8?B?R1N5UXU3SUQxTmkzWXh2dnFuN0tlWmp3b004V0o3OXZ1cXpudjhPYjFxQlZ2?=
 =?utf-8?B?WHlaQ1YyTmg3ZFBFaTY3MXJmVFpBdHFhQjEwTy9FK1FMSkVmaVdVaE0wV2JR?=
 =?utf-8?B?dlBVSGRrS2JKWFNZN3ozOFJHV3FIUWs2ejZRalUvZGpYOGZYN3U2SDBOZXNP?=
 =?utf-8?B?SjdwMU9JRlQ5Y1dYZVF5Q1JRRXpDZGR2dG83Qk5QaHpHWDFjbWNJOTJpaEky?=
 =?utf-8?B?cUFuZEd6Z1lYY05HSWw4RDNXcDZnbGRGMU1GSmFOOU0wbkVpSWtndWJ3RkJK?=
 =?utf-8?B?cmdXbURHMWNPSXZMR2ttcEF4OW9qQmsrb1ZLa1QvUUdlL25ES2RVdFBGSTdq?=
 =?utf-8?B?a0d6UG02aUtjZnZFeTArKzJlYjNscGp6NTg2RTJabE53ZURUS042MkxGdy9r?=
 =?utf-8?B?ektRMURUdDloeEdkTzJFVGJYTlg5cWxsR2NYdmxkdU9MVU4zdUtBeXcvY0Rq?=
 =?utf-8?B?WkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LikQceOrqLyDPB3rtSFSa7BQxdDx2WU9x2NhiKL6NNngdvhV31Idxugt0+URdwRqxLbfotIR57EEUFkRiE1Iyta1nIetFkL3K+hz3ZYagps1yCd3wF6nSf8X5IhoYLlUcRWOLDOmEBFt3lrE9OrdkZ7S4FrwvcdGZukDE7pKXETq+ZCSvXllu3Tb8RA3GCEER4Sbev2I6gCSDn20fStXhhsO9iLqeJUcl9yyUeDcOgfEO9v9z22dxr7XSwupduW1AEdsautWLd6s3Pa0+vjlvpFQ0Rq7ac2ju0lmijohj9r61fvBzn1UZvjheYtD9ThH7AgMs7m2T/pmFeAoy+wxi3ZeEAxJedPypqOoUR+/1txbCBNtKqY5Ezaxh2ofJR6k7+/JAkIEi/sOrPjUhzRv7Q+cKMU8zBfPXe55a7SRZU98kUaH6xYRpoFkeDpcGOYKhEj5m8Ov6Y1WsSVHUfYcY8HcK7b7rmuSbbvvOAb7dkwVoq7Qc5BomqQOzWgGA+BmgQ+m39HKjoEfN1i0CLRbUg1jxLqZZkDNa6tmVl0E0PHj/SG4/M2ymyf91AqlzOHsWtkyiOvU7V/FrMbaFdvBDKSSASHhE/D78fl8AQZjRcY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c54e362d-33c7-45d4-852a-08dd4a86a817
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2025 10:27:16.4230
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kyC6+hcUV7Dd897ahOhQN2PCMK7gGH7O6TbzORR9xfdgo4AkAel1RycrEoLVzP1fYsjLSQxhICso0UtGdHeZOPVq1o91Vsla8pUoDSNE58=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6447
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-11_04,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502110065
X-Proofpoint-GUID: 6FyxAxvKCqIwhS9MS9w5L-lSAfC6CDZU
X-Proofpoint-ORIG-GUID: 6FyxAxvKCqIwhS9MS9w5L-lSAfC6CDZU



On 11-02-2025 00:33, Andrii Nakryiko wrote:
> On Mon, Feb 10, 2025 at 12:13 PM Cupertino Miranda
> <cupertino.miranda@oracle.com> wrote:
>>
>> Hi Andrii,
>>
>> On 07-02-2025 01:48, Andrii Nakryiko wrote:
>>> Add a simple repro for the issue of miscalculating LDX/STX/ST CO-RE
>>> relocation size adjustment when the CO-RE relocation target type is an
>>> ARRAY.
>>>
>>> We need to make sure that compiler generates LDX/STX/ST instruction with
>>> CO-RE relocation against entire ARRAY type, not ARRAY's element. With
>>> the code pattern in selftest, we get this:
>>>
>>>         59:       61 71 00 00 00 00 00 00 w1 = *(u32 *)(r7 + 0x0)
>>>                   00000000000001d8:  CO-RE <byte_off> [5] struct core_reloc_arrays::a (0:0)
>>>
>>> Where offset of `int a[5]` is embedded (through CO-RE relocation) into memory
>>> load instruction itself.
>>>
>>> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
>>> ---
>>>    tools/testing/selftests/bpf/prog_tests/core_reloc.c    |  6 ++++--
>>>    ...f__core_reloc_arrays___err_bad_signed_arr_elem_sz.c |  3 +++
>>>    tools/testing/selftests/bpf/progs/core_reloc_types.h   | 10 ++++++++++
>>>    .../selftests/bpf/progs/test_core_reloc_arrays.c       |  5 +++++
>>>    4 files changed, 22 insertions(+), 2 deletions(-)
>>>    create mode 100644 tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/core_reloc.c b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
>>> index e10ea92c3fe2..08963c82f30b 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/core_reloc.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/core_reloc.c
>>> @@ -85,11 +85,11 @@ static int duration = 0;
>>>    #define NESTING_ERR_CASE(name) {                                    \
>>>        NESTING_CASE_COMMON(name),                                      \
>>>        .fails = true,                                                  \
>>> -     .run_btfgen_fails = true,                                                       \
>>> +     .run_btfgen_fails = true,                                       \
>>>    }
>>>
>>>    #define ARRAYS_DATA(struct_name) STRUCT_TO_CHAR_PTR(struct_name) {  \
>>> -     .a = { [2] = 1 },                                               \
>>> +     .a = { [2] = 1, [3] = 11 },                                     \
>>>        .b = { [1] = { [2] = { [3] = 2 } } },                           \
>>>        .c = { [1] = { .c =  3 } },                                     \
>>>        .d = { [0] = { [0] = { .d = 4 } } },                            \
>>> @@ -108,6 +108,7 @@ static int duration = 0;
>>>        .input_len = sizeof(struct core_reloc_##name),                  \
>>>        .output = STRUCT_TO_CHAR_PTR(core_reloc_arrays_output) {        \
>>>                .a2   = 1,                                              \
>>> +             .a3   = 12,                                             \
>>>                .b123 = 2,                                              \
>>>                .c1c  = 3,                                              \
>>>                .d00d = 4,                                              \
>>> @@ -602,6 +603,7 @@ static const struct core_reloc_test_case test_cases[] = {
>>>        ARRAYS_ERR_CASE(arrays___err_non_array),
>>>        ARRAYS_ERR_CASE(arrays___err_wrong_val_type),
>>>        ARRAYS_ERR_CASE(arrays___err_bad_zero_sz_arr),
>>> +     ARRAYS_ERR_CASE(arrays___err_bad_signed_arr_elem_sz),
>>>
>>>        /* enum/ptr/int handling scenarios */
>>>        PRIMITIVES_CASE(primitives),
>>> diff --git a/tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c b/tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c
>>> new file mode 100644
>>> index 000000000000..21a560427b10
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/progs/btf__core_reloc_arrays___err_bad_signed_arr_elem_sz.c
>>> @@ -0,0 +1,3 @@
>>> +#include "core_reloc_types.h"
>>> +
>>> +void f(struct core_reloc_arrays___err_bad_signed_arr_elem_sz x) {}
>>> diff --git a/tools/testing/selftests/bpf/progs/core_reloc_types.h b/tools/testing/selftests/bpf/progs/core_reloc_types.h
>>> index fd8e1b4c6762..5760ae015e09 100644
>>> --- a/tools/testing/selftests/bpf/progs/core_reloc_types.h
>>> +++ b/tools/testing/selftests/bpf/progs/core_reloc_types.h
>>> @@ -347,6 +347,7 @@ struct core_reloc_nesting___err_too_deep {
>>>     */
>>>    struct core_reloc_arrays_output {
>>>        int a2;
>>> +     int a3;
>>>        char b123;
>>>        int c1c;
>>>        int d00d;
>>> @@ -455,6 +456,15 @@ struct core_reloc_arrays___err_bad_zero_sz_arr {
>>>        struct core_reloc_arrays_substruct d[1][2];
>>>    };
>>>
>>> +struct core_reloc_arrays___err_bad_signed_arr_elem_sz {
>>> +     /* int -> short (signed!): not supported case */
>>> +     short a[5];
>>> +     char b[2][3][4];
>>> +     struct core_reloc_arrays_substruct c[3];
>>> +     struct core_reloc_arrays_substruct d[1][2];
>>> +     struct core_reloc_arrays_substruct f[][2];
>>> +};
>>> +
>>>    /*
>>>     * PRIMITIVES
>>>     */
>>> diff --git a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
>>> index 51b3f79df523..448403634eea 100644
>>> --- a/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
>>> +++ b/tools/testing/selftests/bpf/progs/test_core_reloc_arrays.c
>>> @@ -15,6 +15,7 @@ struct {
>>>
>>>    struct core_reloc_arrays_output {
>>>        int a2;
>>> +     int a3;
>>>        char b123;
>>>        int c1c;
>>>        int d00d;
>>> @@ -41,6 +42,7 @@ int test_core_arrays(void *ctx)
>>>    {
>>>        struct core_reloc_arrays *in = (void *)&data.in;
>>>        struct core_reloc_arrays_output *out = (void *)&data.out;
>>> +     int *a;
>>>
>>>        if (CORE_READ(&out->a2, &in->a[2]))
>>>                return 1;
>>> @@ -53,6 +55,9 @@ int test_core_arrays(void *ctx)
>>>        if (CORE_READ(&out->f01c, &in->f[0][1].c))
>>>                return 1;
>>>
>>> +     a = __builtin_preserve_access_index(({ in->a; }));
>>> +     out->a3 = a[0] + a[1] + a[2] + a[3];
>> Just to try to understand what seems to be the expectation from the
>> compiler and CO-RE in this case.
>> Do you expect that all those a[n] accesses would be generating CO-RE
>> relocations assuming the size for the elements in in->a ?
>>
> 
> Well, I only care to get LDX instruction with associated in->a CO-RE
> relocation. This is what Clang currently generates for this piece of
> code. You can see that it combines both LDX+CO-RE relo for a[0], and
> then non-CO-RE relocated LDX for a[1], a[2], a[3], where the base was
> relocated with CO-RE a bit earlier.
> 
>        44:       18 07 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r7 = 0x0 ll
>                  0000000000000160:  R_BPF_64_64  data
> 
> ...
> 
>        55:       b7 01 00 00 00 00 00 00 r1 = 0x0
>                  00000000000001b8:  CO-RE <byte_off> [5] struct
> core_reloc_arrays::a (0:0)
>        56:       18 02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 r2 = 0x0 ll
>                  00000000000001c0:  R_BPF_64_64  data
>        58:       0f 12 00 00 00 00 00 00 r2 += r1
>        59:       61 71 00 00 00 00 00 00 w1 = *(u32 *)(r7 + 0x0)
>                  00000000000001d8:  CO-RE <byte_off> [5] struct
> core_reloc_arrays::a (0:0)
>        60:       61 23 04 00 00 00 00 00 w3 = *(u32 *)(r2 + 0x4)
>        61:       0c 13 00 00 00 00 00 00 w3 += w1
>        62:       61 21 08 00 00 00 00 00 w1 = *(u32 *)(r2 + 0x8)
>        63:       0c 13 00 00 00 00 00 00 w3 += w1
>        64:       61 21 0c 00 00 00 00 00 w1 = *(u32 *)(r2 + 0xc)
>        65:       0c 13 00 00 00 00 00 00 w3 += w1
>        66:       63 37 04 01 00 00 00 00 *(u32 *)(r7 + 0x104) = w3
> 
> Clang might change code generation pattern in the future, of course,
> but at least as of right now I know I did test this logic :) Ideally
> I'd be able to generate embedded asm with CO-RE relocation, but I'm
> not sure that's supported today.
Ok, good! I just miss read it. :)
Thanks!
> 
>>> +
>>>        return 0;
>>>    }
>>>
>>



Return-Path: <bpf+bounces-78313-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A305D09A42
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 13:29:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52D4330281F5
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 12:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AA7135A94B;
	Fri,  9 Jan 2026 12:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qGZ6M1HM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NlWZenQa"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB3F335567
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 12:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767961520; cv=fail; b=gVCSfCQafHw/BQskyqLP3wrLj5bThOw+JIYbjVtoK2l7Nvzm5+Awdnr1Vu89vrWYePq3nB7Rr3QjjkmpAEjKyXCQzDGo/owhTQSoi632iBDnNYWNga4OGMxgL8y06YcK9cs9IURex6S+1x8rtT3TcljTPCVLkgB9d5NUc0g+mig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767961520; c=relaxed/simple;
	bh=kYjpTn3/HfxUj51zFU0oyruw774kmi2y2Xr9EO2c3LY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=oTSn2hCWoFPfXvzXFySIMjka/bWjM+cM5rleEnuNz3+BixalwwhHaHdXqEcpMRQx+8bC7bNNpn095zVnNNcbgj2tgkcLCU3zOB9VUpue69UjiPjSTfM1cJB+Jf3UKti4TjpReTY85/1lxtpEyE74Rg64P6gev07Pbvq2wWq8yBI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qGZ6M1HM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NlWZenQa; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 609A9o7O2696969;
	Fri, 9 Jan 2026 12:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lrg1CjhsLAjdNnNuuEnQqu1n7xUst3byTv4p+w2Hh00=; b=
	qGZ6M1HMqUaFXm0KzL/hzmOabxxzTIJq/6FZFDImn/vs/LakBEVsHzd529GMIznr
	gMq1438XNoCHQNCxRd1QFw4Lq3RilGbIkBjTcMWo4xzP0ESutfyRobJNQ+cCY8ce
	YRMgWUr/EMA/KQD23YszEw9WXL2//mFqMnnnc/3HquLdPGxSvSSW8zt3ksEVXSD/
	qFHmgRQ4aL6gsakSBYxcAHVd8ydxEmfRn2UuLclybcVdfhNdS4NJREQDBNvEzQV7
	Tw1b+iISTVXZQ2oL19Ppdfp7vhgyqS9iK3w8cvwJ6VYG2uNH2CDtmlUtvBTrqF+v
	GkRx/XvjZu/n17osMOUSEw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjyp7g3yd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 12:24:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6099Y5rq026351;
	Fri, 9 Jan 2026 12:24:43 GMT
Received: from dm5pr21cu001.outbound.protection.outlook.com (mail-centralusazon11011001.outbound.protection.outlook.com [52.101.62.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjpjvnm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 09 Jan 2026 12:24:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mc5LLVSOF5imSlFH7buLgiSea9YG3JQYpIsyk5t2MYh8F5JMZmTPUklTJsIRqS7YS330H5ve6xf5pmlVM9btoLSr+ok0UD3yWNvQLF8Zc0IG1y4nKoaa/o1vTrDDydWikUniwS33HIjjHW+N3qRZAtNzjxTzmTA+ZOlvjsewpf/B1HB6BGvrjndh8mNy/63hOFT2+iQ0I5lCYc852/fLHmM7Ikipw/8W2GEq+qMq7/DxP+J/qB8tuf0i5K7kv2b5zIzHT11NUqnY9Ry1bXO4BEA4qjwjGyNqbc0RQGLNqe+ycAFfE8CFG2r8eRp+Clm1p77m+AsvEZkhLCCL1ieBJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lrg1CjhsLAjdNnNuuEnQqu1n7xUst3byTv4p+w2Hh00=;
 b=OISmi5+Er9y8NYqvgXBuVVR3VhXfz4yv+4lfC3YfPhLD7TioyOcIGJhABohbOYwa1PUYwFF35fDSrtIUMlgljtkIGTlRahqW83BeRnaUFdG1wRkgyYL3sMvq/6Z2UsaRaZtg20FJyR9ZIwEzw9zzFtGvsMQqK3wDbu/4nIWNfZkh9SLYtyp8x+7OgKJlZmup5l2B3SaHMFP3XVUgaLEk9HgE86hgFvpzpoqvZFzbPou43AziXPnK66T0tOBR/KhtrrZ9EtkRpmVAhCpz7c1dnFo9kNgLW60810LnBsjpbROVE8Y1GNmK1yxblbderm9dUCNbss0/mGasjZQv7YV+Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lrg1CjhsLAjdNnNuuEnQqu1n7xUst3byTv4p+w2Hh00=;
 b=NlWZenQaIn6B5+JjN0ELl7Tm7s6dteLQGNo7bSzuZogRnDixQOWK66zJdx61pPHXYowVoE0K1ECP91nJaX+0cG8N/atJXNInM4/wc25rV5lWtl9SjJOzap2c7auASou9Y3pda5JSTQSErP2YHccjtzKOn3n2KlkkczvBPI65Xzg=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 CH0PR10MB4953.namprd10.prod.outlook.com (2603:10b6:610:de::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.4; Fri, 9 Jan 2026 12:24:40 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Fri, 9 Jan 2026
 12:24:40 +0000
Message-ID: <e2019eca-e360-41c4-b582-ff7c3704c854@oracle.com>
Date: Fri, 9 Jan 2026 12:24:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH bpf] libbpf: BTF dedup should ignore modifiers in type
 equivalence checks
To: bot+bpf-ci@kernel.org, andrii@kernel.org
Cc: ast@kernel.org, yonghong.song@linux.dev, jolsa@kernel.org,
        daniel@iogearbox.net, martin.lau@linux.dev, eddyz87@gmail.com,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@fomichev.me, haoluo@google.com, nilay@linux.ibm.com,
        bvanassche@acm.org, bpf@vger.kernel.org, martin.lau@kernel.org,
        clm@meta.com, ihor.solodrai@linux.dev
References: <20260109101325.47721-1-alan.maguire@oracle.com>
 <30e36e721900df2580a112faeba7c725911347d2bc925656d241a7a42d754727@mail.kernel.org>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <30e36e721900df2580a112faeba7c725911347d2bc925656d241a7a42d754727@mail.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0466.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::21) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|CH0PR10MB4953:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b44c986-68b0-485c-d35a-08de4f7a0f90
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?WTFOZjljV0xmcU1UWXBuMHhndVRRWE14R2NBMzBtMVZtVkFjMC9WNFF1V0g1?=
 =?utf-8?B?MkRmSkhwS0FUVUdKWHFVRUJPd3VaMzhackxKeCsweS90WkhMWlFPRU8wMWcr?=
 =?utf-8?B?TGxwRTZVYVRPdTZEL29zQ214Ykwxd1lnVnYzUjBhbDk5QnFtajNUQVh2M0JG?=
 =?utf-8?B?Ny9UaHZ6K1JTOEV1bTVaSVNnQm5zaHp6WnR0SFRkR0k3bktNQ010M05SN2tv?=
 =?utf-8?B?TlZQYUlkTkpBMWJ5eGhlY2dET1BWVkdEbWZydGFpL1FzdGQvL2JUam1HVjhS?=
 =?utf-8?B?QUNkQVByVVZwb3FhMEN2NmdBaEZFeGlvVFp3TGhaUDM4V2M0T3hkcDJYSEZY?=
 =?utf-8?B?MDV4SUQvZVlBb3QrYWhOR2puN1I2c2Mwek14K3pnTmlPdm1QWXk3Q21iZ0Zi?=
 =?utf-8?B?NzhRT3k4ZlZpRVVta0lKa3V6SW1KNEVJSDJBMkY0blQwNllZOUsyVE03enhN?=
 =?utf-8?B?NktWRW1pNTNQZm0rdUpaaTVBb3Z5WG45SE0zZUdibGxYQVByOVQ0djNvVXhB?=
 =?utf-8?B?aERsSzFqbzdXVDJlRFprYng4UTJNOWlzTXp3b05kT1ZEdEdTUVRYSlJFa1BN?=
 =?utf-8?B?Q09MTmtKME1Ca1htbjl5TXByQzgrY0JFeUJ6MDFxVXIwMjZCZjlyZmVxc284?=
 =?utf-8?B?eGdRSHBQb0hEMFNTcXgyYm1UTkpYQ2hOM0FZeUszNXRyMEU5clplblJiMDd2?=
 =?utf-8?B?Wmo0bWducjB5dmNWRXhIUjlvVzU0TW5CRnBHWU1OVzMwNXgwMk9WN3dwRENK?=
 =?utf-8?B?VG41L3V6REpSRnFIbHg2Y1paYmVRMi8zNU9DLzlBQS9SWGhWUjBJNmhmamNT?=
 =?utf-8?B?RVNRdHhTVmVtcW42MHR3RWdhWFJ6Q3hrOE5BRnZmTkkyZTg4OTN1NG02NWh0?=
 =?utf-8?B?enBraWpLVE1aZUdkb2c1dlVZU1ZvS04yTmtucTBrM1JCR01Id0EyTzFKckp4?=
 =?utf-8?B?UEg5NDZlQnU5UWtpMkdzNlo5bGRIbTNncS8yeFlYd2Y0VEx1bGEvS0xHZGh3?=
 =?utf-8?B?aEdkaFlHb283VE1xeXBXaGdGaUtZN3ZubnZ0VjNLNGJuSEJjeWRLTzljWHJ0?=
 =?utf-8?B?cUpNVUh4U2UrbVl3SUUrbjFZQ2ZWbkJtUWNybWEyWWNKS1BnZkNzYVBMRTRC?=
 =?utf-8?B?VlhFRTc2SzR5NnpJK2EwbmI4amxaVG1aK3ZuS2xZcGtYTWlPWFNmTFdrTUN2?=
 =?utf-8?B?WWplb2taUDg0WUpGS3lHK2hocHNYRm56QlE0S041VzRsczZBZDByak00bGxM?=
 =?utf-8?B?aGpHdXhSL05QZ0ROS0tLTm5kZXdqR3RKekNJMUxRZWY5TWVibGJiTjRXUTVN?=
 =?utf-8?B?TFM4aSsxM3R4eWJjM3BkRGs3ZGdKYUZFSVRtaVNMMW5YUzhpS2tYVEEwWjBi?=
 =?utf-8?B?NDg2YThEY1kzQ2VZMTBwWGpUZmhNTkc1emI5T2ZNQnpRNDU0Y0RQNDJiQWpv?=
 =?utf-8?B?QVYxM01pcjE2S1F2a1F2ODR4NW9WS3hLMWhpdTFkZk9wWk5lYTZzT3NMT1Zl?=
 =?utf-8?B?aEF1ZHIvWUJDNFRhRi9jcmRSeitsZS9JL3VzQjNHQURvZmhHdy8xRVBnYWY5?=
 =?utf-8?B?aUFIRklXRXVIVDVzeXNlMDBmRmJpVGNkK1BFUlA2MnE5NnBoMFVRR2JDSEFL?=
 =?utf-8?B?dU1vTjNRcXBUaHVDVkpBMmRJdnQ5U2hzMWFySnh4ZExFMklZc29JNjluN2lG?=
 =?utf-8?B?R3c1SmRjQncvYy9DbjFKVFR5ZXNDdldmVTBOY3BuYkcvNnhSVnBEbGQxY1d4?=
 =?utf-8?B?TzRKc1o5TW1FeWFFUVhSVE9oMy85cURlOCs1Q21GRUF4N1cySDZDS0Q1Sklm?=
 =?utf-8?B?YzZHRFRYb0wwMStmR1RYaXIySCt0TWZSeDVwZFFZL0tib0FWK2ozOHllRnpq?=
 =?utf-8?B?QjNkTkVjalJsVW9KWFhxTklpMlZWYWxkMFkwZlovWS95akhOSFBpTEhtUnZD?=
 =?utf-8?B?NUpwUDNXejNZMGZsUUgrRWJhalExVHBndmtad0UwYU1kR3pIMFBkcytUTTFB?=
 =?utf-8?B?a3k5YlZmdHB3PT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?TG81d1l6R3BuWVprWHVUVGpST0J3WUFwYTAyVHU4TndDS2I5T0w5U1c3blg2?=
 =?utf-8?B?SUVpcmpQNjJueWNNcWhzSnptVXF3UTUxWXoxWjRydjgwUjRqazNOakxBUGJV?=
 =?utf-8?B?dTNGSVhEZXdJcW5BYkQyWlh2aEkzVjBaR2pNb3JPUUkxMyszVTdVcmszYmpU?=
 =?utf-8?B?eitmL05QVW5pemVOQmRYOE9neVlrcHppMkxCQUFWdit1Qnh0UUxsZGpPRFNu?=
 =?utf-8?B?MGdaUTdzVC9udlRTSDV1ZTVRendJeVVhczRTdTBaK0tZdW9UTVY3ZElHQ0RG?=
 =?utf-8?B?aDMxcnB2VDl1eTN2WE5ncmFNV1Q0VHdqTmlpbWthRCsxY3FOQm1RSjFnRnRK?=
 =?utf-8?B?RE9HQ0FENldIcS8wQjNIN2svdVloM2tXQTFDZVJidmdUbzRkQlA4OXJ6K0Zp?=
 =?utf-8?B?Uk1PR05mVnJTOFl6VXFBWDc3Yy9sNlZ0KzhBOFJzM3p2VnlIQnY3R3pKbWc3?=
 =?utf-8?B?YzB1c1NEM2hBdnRUR0h2djJ5R1lPRDk1OVhLOC9JMi94SXZ4dnFhUjdVQzVz?=
 =?utf-8?B?cTlkWjAwMFlCSTJmTGd3SFpxR0xib3BaSFZZc21TM2xkc1FvVlFRVnBpYmlq?=
 =?utf-8?B?eDV5aTJYYzhqWXo4Z1hXR21RTlo1SG0yVTZRUkVNVCs4azJTWWQ4ckhPWVlF?=
 =?utf-8?B?bUdoSHhPYWFJM2JhajZnRWU4MVlLbXovSTdqb1h5M0FteWtOYzk4T1dZL0dL?=
 =?utf-8?B?aTZNeG5kMEIrZWYrVzhZVWsvcWZUMXc2ODF1MzJwVzZ4MVFhbkcxb2o2MEQv?=
 =?utf-8?B?blhQM09uQndsTDhlaGUrUmRYK2dDN3FQd0xRL3IyN0pjWFpNT0Z5ZGUzamFw?=
 =?utf-8?B?UVVpRVE3OXpwZkhhVDluNnhXK2hZdVN3U1ozcHhkUTRKS1R5RVg3RzZBME1S?=
 =?utf-8?B?MVpZanc5ejBsUTZJVHpwK3AvM3pmRHphV0pkYzlzQmtRTEtzQ2J5NCtPRExk?=
 =?utf-8?B?VnhQTzVCWDNxcVJuRHhtUW9SaHp2ZTF4d09HWFE3Z1N6SEpOU0FDc3NKajVV?=
 =?utf-8?B?WDRaaWk4bWpkdnJCRUIrNWk1VDhqNklIUjVaMmhUdGN0RnVCVkZ0bmwrVEtL?=
 =?utf-8?B?UnhWRW5nUWtveWpBdlRGOGRXSVNNaGxFLzZnYjBGUmxPUjNTZzBNQmswamsr?=
 =?utf-8?B?VE56ODJvMXZaQXdRazdHbUFCbUM4by91NmhGY2x4NE5IZkNDV0lTaCtBamVC?=
 =?utf-8?B?SVlENWZSb3YvU1BFRWx3NjNDbkY0My91eFRDY0dTOEFtS1NkVTkrczRtUDJ0?=
 =?utf-8?B?NkRZQnlGTFhnMllGL2hwUXV3djJ4SGRDNjF4ZEpReWFHbHorUStHa0ZqV2U0?=
 =?utf-8?B?a3M5VDhsMXFNL1h6ZElWcnZlbytOR09FYUN4Mjd5dUI2VnJZSnlMZmJVZDVQ?=
 =?utf-8?B?R3lpTDB4R2NIZlFEVWE5VHpReDBLNlJUZ3NMWXFJYVZKSy9RSWpyb3J0SGp0?=
 =?utf-8?B?YmxsSStvZmFVSERKTWlxVWorKzhLYWZGZmNRUU1ucFRDYm9aYnhud01QOFNM?=
 =?utf-8?B?NWNXakJXY0JNK0ZWdnVwZnVhZmhkdGhxN3FqeGFkQzZReU1mTk5uL0M4OUhF?=
 =?utf-8?B?bitiekZ1SkVybEJMVGM2WkVYaklxMHVIakk5UGs4dlk1VDFXeFkxaEt3eThB?=
 =?utf-8?B?WHdhbjViTkhIRUpURUU1SEd6c0NCTE9aa05GUWExRzRIUU5NNWlOWjNqSjhr?=
 =?utf-8?B?TmdxZzZkN1ZWRTBvTzB4UmZMaWpmZ2cwcUdSdmVoYjZKdHF0TktnelpsdUky?=
 =?utf-8?B?ZVdKOWRrbDN1V1VjTHo3cnprUEo0QVZqRkV2dFM4MDhKbk5lVWs4aWFCQmxx?=
 =?utf-8?B?RnZoUEZuMG43d2xFYWhhOTV5S201Nm0zTmIzTWI2NnZoUE1rakVMYW9vd2Ri?=
 =?utf-8?B?M3RQZE1mR2ZvemNtdDB4TXlzT2huUjRZSHRJbkhxUmcvVUtzRThFY0dPVkw0?=
 =?utf-8?B?cWpWMnQxMXVPU0E1SVhaY2dPNW9ndmVqeE1ZL3Z4emdJeVAwL1hCb3EzM1o0?=
 =?utf-8?B?bnlWTzFWMXJCb21xUVU1NldSdUUreDZwenVTU0lEdVFhMW93RERmQ2RJbFhW?=
 =?utf-8?B?Y1dOQks0QkEvcHJ2OHlhSE5PRG5tOExnTnVmb05ncUdrczY4SFRjRlBUcEpa?=
 =?utf-8?B?WG5Pdm1iamFqeDZBU3JwYlpEYUhZaFRjMzFxSkE1NXdXejBmVElObmZ0and2?=
 =?utf-8?B?UVQwY3gvM3VjVDFzTlJiL0srdkF3ZjhnL3pxUnZERThISGhrOHo2OW04Y1VO?=
 =?utf-8?B?Rm81QVR4OWFWWDNCcnVkckxqRmloQzRiUnVrZi92WjJvd21URGFubmRLR09y?=
 =?utf-8?B?QS9FZjMwQld6TS83TlRWczhUeUw3cDJicXppU2hYeTBkTkozUGtiOEJjeEUz?=
 =?utf-8?Q?9dkDIZquIbKe67pU=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WKyNwyQ3AuDd7Et05G8VEx7fWM9Mu/OGJf18wdZuLcGcLqDKq6vZeVp5DXOPAdHp+PLwfLEwwWLDsegSOpOQqUyaZI+lMIPQjtgORDE2q+rhyt3Va9qPVWLmF9xGLS90/pCC+F793yNqCzA9vATKRYNVop/Y/GUl4gmOh9D5lDO8TVOEOagZhOTQLCll3QRUUuL83MmMcIPiOEh6pHvLReFEDWMwwQw6kj7c1U0hcekfrR9edcrJkVgr15Y9Q+dDk/91md3SJhwOiTBAKnge3cJ+vCwA4H7P9AdVLoBlFiXblcuJl2VDK0nOTVIEmnXGccSj7DVYnvvIRodagBC6dggwISO0UAehJk7UeZ9rqsKj8OXYM1//cnoYIyi30mbyFeWj2ghc2ss15iDE+DASaCcNdDvxP70zoqwDeHlqDPI3Zl6tYnwJpKmFzuMUpiHzfxAn5aZQUSUts+DYdW4mIRbGFwLu+nQfPHB85xQ9O++/ZmH8dG5A+YZkq3fHLvDZlNxBVrzMI3ITQsmWjRj/CCFR0pTPfgmCw0YaMWV4qeYmmAjpN1K/B+2yeB1u4v6dq7wRyULkCBAnvMu9XTBZMIThsGUBL60Ziw3u0ePQRps=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b44c986-68b0-485c-d35a-08de4f7a0f90
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 12:24:40.2621
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DVK5jL3GE+a0MVCxH0ZA3GueMZT2gbHTRtplhJQIgZY4WJpPYMaC4y4VKjMYudJy1KERnGbHoIIxMvIWSsY9LA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4953
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-09_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601090091
X-Proofpoint-GUID: J1NL8rflhEK6ETVBefYzT9Ori119NOC3
X-Proofpoint-ORIG-GUID: J1NL8rflhEK6ETVBefYzT9Ori119NOC3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA5MDA5MSBTYWx0ZWRfXz+dFmtHLGYBi
 TVyqbtAysEjxrDNWRHQ4mN8zLb62aCOa5yfLt0Bu0qMl9sHo6FOFhJ7wgKMFu561dV2Mq6uNrNO
 64U9o+w1+zjmdJIH+vDbbk5gcUPlrKl8vfRwI9jp5ecMrBO4jexWKpnzR1wulMeJSMeeX0CBOyw
 patK/oItdn+XRCrjGzu63J90VqPxK7xm9AD6xCWsDe8kj0R0omZxmKSKt28UMI9CfVwmCBdroih
 vz8dZrqmlsEEiblqhOwjosrAvgw/We5lsJNt10JpSaBDEf9jMKCEYnm+JKYNsPH0ylIajydqN6r
 fLLsR5iSGf5wgDyNeg/l3xKaA6nwR+wA9l5gKO4v/9j9U0ymcrEtqxR7E+X+yRHGiQ09oVcxHNj
 uFRl8w7X6+8GE3cC0iy0orRh2iAp5AuGghnIbw2sjq6llJU2olAvHl1f0Bh7vn1FJweyRKl1lQ6
 poiOyOOqPLN2KdJkiLKdcedkZmNX6n55B2jx8HwI=
X-Authority-Analysis: v=2.4 cv=ZfgQ98VA c=1 sm=1 tr=0 ts=6960f38c b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=iFABrAoMAAAA:20 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8 a=T53K6hvJ0HW8WLB0CmMA:9
 a=QEXdDO2ut3YA:10 a=bA3UWDv6hWIuX7UZL3qL:22 cc=ntf awl=host:12110

On 09/01/2026 10:33, bot+bpf-ci@kernel.org wrote:
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 84a4b0abc8be..8ef0354e66cc 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
> 
> [ ... ]
> 
>> @@ -4688,7 +4686,24 @@ static int btf_dedup_is_equiv(struct btf_dedup *d, __u32 cand_id,
>>  		return fwd_kind == real_kind;
>>  	}
>>
>> -	if (cand_kind != canon_kind)
>> +	/*
>> +	 * Types are considered equivalent if modifiers (const, volatile,
>> +	 * restrict) are present for one but not the other.
>> +	 */
>> +	if (cand_kind != canon_kind) {
>> +		__u32 next_cand_id = cand_id;
>> +		__u32 next_canon_id = canon_id;
>> +
>> +		if (btf_is_mod(cand_type) && !btf_is_type_tag(cand_type))
>> +			next_cand_id = cand_type->type;
>> +		if (btf_is_mod(canon_type) && !btf_is_type_tag(canon_type))
>> +			next_canon_id = canon_type->type;
>> +		if (cand_id == next_cand_id && canon_id == next_canon_id)
>> +			return 0;
>> +		return btf_dedup_is_equiv(d, next_cand_id, next_canon_id);
>> +	}
> 
> Can this recursive call fail when there are multiple levels of modifiers?
> 
> Consider comparing "volatile const int" (cand_id=20) against "int" (canon_id=5):
> 
> 1. The first call adds hypot_map[5] = 20 via btf_dedup_hypot_map_add()
>    earlier in btf_dedup_is_equiv() before the kinds are checked.
> 
> 2. btf_is_mod(VOLATILE) is true, so next_cand_id becomes the underlying
>    "const int" (ID=15), while next_canon_id stays at 5 since INT is not
>    a modifier.
> 
> 3. The recursive call btf_dedup_is_equiv(d, 15, 5) is made.
> 
> 4. In the recursive call, hypot_map[5] is already set to 20 (from step 1).
>    Since 20 != 15, the code falls through to btf_dedup_identical_types().
> 
> 5. btf_dedup_identical_types(d, 20, 15) compares VOLATILE vs CONST kinds,
>    which differ, so it returns false.
> 
> 6. The function returns 0, incorrectly reporting the types as not equivalent.
> 
> This appears to break the intended behavior for types with nested modifiers
> like "volatile const X" vs "X", even though single modifiers like
> "volatile X" vs "X" would work correctly (because next_cand_id and
> next_canon_id would both resolve to the same underlying type).
> 
> 

The above is all true, but I _think_ it neglects an aspect of deduplication;
that it is symmetric; i.e. in one case a type id is canonical, and in another
it is a candidate. So for the above case, consider what happens when
cand_id=5 ("int") and canon_id=20 ("volatile const int"):

1. we add hypot_map[20] = 5 (i.e hypot_map["volatile const int"] = "int";
2. btf_is_mod(VOLATILE) is true so we recurse to btf_dedup_is_equiv(d, 5, 15)
   (where 15 is "const int")
3. hypot_map[15] is not set so we do equivalence checking and recurse to
   btf_dedup_is_equiv(d, 5, 5) ("int") and return 1.
4. As a result the original hypot_map["volatile const int"] = "int" is
   verified.

So unless I'm missing something we end up deduplicating successfully in 
this case, but the deduplication is weighted towards making the more complex 
type canonical. That's what we want I think since these equivalence checks 
will be just used to validate struct/union equivalence.

> ---
> AI reviewed your patch. Please fix the bug or email reply why it's not a bug.
> See: https://github.com/kernel-patches/vmtest/blob/master/ci/claude/README.md
> 
> CI run summary: https://github.com/kernel-patches/bpf/actions/runs/20848783658



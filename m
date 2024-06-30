Return-Path: <bpf+bounces-33445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C31791D0AE
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 10:58:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B37C2281B7B
	for <lists+bpf@lfdr.de>; Sun, 30 Jun 2024 08:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BECD12C498;
	Sun, 30 Jun 2024 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JyELiHLR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XXkJvW8B"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724D322331
	for <bpf@vger.kernel.org>; Sun, 30 Jun 2024 08:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719737881; cv=fail; b=i33bBjpGea0nAYhBz/CTrJbcbt3Mx9SrayXy0sZ/aoyduiXsTV9S/GAbVQ0yfoEzqFGsx4tqS6HrBmFFe0jR8emZuEcfWk+eQ9br40ksATg7t4NTRYJtGwuO7DeW3i/KdOl6XYCrqWj7GeNorPR6dKXNVJWXm08Y64OMiltirw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719737881; c=relaxed/simple;
	bh=XG98TQip1lUUfthCzkNoCdKg2hWcJhEMNpTISILrxdQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SwZAB4ZGYHAFtuRR2cvLVrMc51Vi3CI2npNqO6bhQ8nCHjyV2zPzG0Qys5Ox2uD/vgvCjwZ7vslEuFxSI5mjPlP1Tpzox23AuEiqv7f8/tAUsVfhvffp7vif8S2gyiixh4EhCWL2W38v7tFmDU1pWw5xrBK3P90Duuc5pROElN0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JyELiHLR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XXkJvW8B; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45U3wrqa030984;
	Sun, 30 Jun 2024 08:57:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=VW2U7xUUW8fmvCb7uJAs3wAfj1q0MwQnubYHciZ41Jw=; b=
	JyELiHLRNBfjFLucqBScG9ONLHd019YVXxzMSBqDiMnIuElBUGi1b1t2LzdEABYB
	mPpYJiiu20XR1HMqL5yhYGXnNWqWNwN2SWj+5FXIEFE3j4+2aKxqJRhaugxeb7Vu
	jFPIcTTnyBzf8bi8g7lQ5G2WHPID9DPtzLAJK+LD5RgPSc+njBEVIeJXfuaeWNPi
	TjBc4d79bF8S8SFBovUiEaki8CCErIUW4UGuYdQy5VYUx7xbrmVgADQgU6TSZDV4
	SOPbT3zsAA4WejWMg8uCpLRgMkD4ZjWnUg7/gBzsV75xTP8cKbMZDuXihW91VAsb
	EVCQktqVyBZnP2JuD9c2nA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402att92s5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 08:57:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45U7FWca009913;
	Sun, 30 Jun 2024 08:57:37 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2168.outbound.protection.outlook.com [104.47.56.168])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4028q5grne-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 30 Jun 2024 08:57:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b7FDS6K/WPo6DejZ7Am5ylPFm3qDw9ppxw+SXBGEmCKfat/Hkcl++z1mZclWecNEPFvk6Ol8E/c250vhJQxrCOGX5lodYFItNrrP34V+e7DaeUw9Zz7O+ytXAE8bRZqGq6Qlo6du1QFFQlR0v4lyQQp4XhalaFflz9zaBIabWTBkBDNE1jSt37t1p5ip7SRlLPZtV9O1nD6QqCr58uyekux0UCXtb5RkGosFpJ8c1E41OwRdKteb2lM3dCNz2XeOj3Eub1hxSFbv11jGAXc8ZsQhsaeyvYI8AYSWQ3iFODC0qncU/IYvEGWMVrmiBmVPC6PJMcBhyXUgxNnhYo0gLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VW2U7xUUW8fmvCb7uJAs3wAfj1q0MwQnubYHciZ41Jw=;
 b=c6BwC+FdD9GN5qcsxzeV6mctkGVD6my3eZcd6mFzWEJtfNHVt9BPZIRLcbIfvcD4j7C/zYtjd57HVOegxYI/v5/3O1McVRhtkqBcdnrfCRRNdpqX6d0gDB8X88rvADwAqa3GIc2UMVp3FNPQ59Tjuthifv0E17Q/AGSW+8xUQY5wU8+2mJQLKjTqjZgq4/n+8rOkAR6HUTKUrOkvHKdiArRc9Jjji0jh/iGTW9TYqHiPZBQ5/x+E50ZO5A3PNUoWUyLfkCcoBohLYVwrVqSIWKQ4cI+j2fMSQuIDVjdvG42IR8mWZjN62nqhG044cg57aBfJZQJhWS6Sm/zv4Mk6uA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VW2U7xUUW8fmvCb7uJAs3wAfj1q0MwQnubYHciZ41Jw=;
 b=XXkJvW8Bi95B8RI+VD+0FUfWg3isawtKbCXi9x7jwBvPLgLlzmhvm+iTdr2HeTmJk3+YoRnR3+/5ruEICok0HwJkH7VOilRUvlh8tcOvFWAcIIYmGGDYM2fKOVX1Irg+egGzlF1rSr0HqurXho91RwnDZikxeygA7lUCed4EF00=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB5007.namprd10.prod.outlook.com (2603:10b6:5:3ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.29; Sun, 30 Jun
 2024 08:57:35 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%7]) with mapi id 15.20.7719.028; Sun, 30 Jun 2024
 08:57:34 +0000
Message-ID: <4622dacf-9141-4b06-a3cb-8e65b157c568@oracle.com>
Date: Sun, 30 Jun 2024 09:57:29 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [Linux-v6.9.7] BTF/pahole issue with LLVM/Clang ThinLTO
To: sedat.dilek@gmail.com, Arnaldo Carvalho de Melo <acme@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>
Cc: llvm@lists.linux.dev, Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <kees@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Martin KaFai Lau
 <martin.lau@linux.dev>, bpf@vger.kernel.org
References: <CA+icZUU71k9kh3GGc8w=F4rdJeBc3LOPH-gNXrjTTUicnufe5g@mail.gmail.com>
 <CA+icZUXJj10358cBqxGo_zdR-JncbwPmBRAxiow3KRrVyHJjEQ@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CA+icZUXJj10358cBqxGo_zdR-JncbwPmBRAxiow3KRrVyHJjEQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DB8PR04CA0004.eurprd04.prod.outlook.com
 (2603:10a6:10:110::14) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB5007:EE_
X-MS-Office365-Filtering-Correlation-Id: a6913687-e8b7-4842-fad0-08dc98e2aefc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?cEM3ZjJEbUFqcTRVaDUvdW04dTBZRVE5eFplaDdjUUVhZTA2MWtTVjNKR3Ji?=
 =?utf-8?B?UzlOUHFrcjVIV01iTWZoR2R2VU9DSC9xRHQwZlJaWDRXNVlCU1duYmlFcURi?=
 =?utf-8?B?dnpmcU9OdmFwbWcrcXA2Q1RMa2RBUTQyTjVaekxscUFpL01VZEt6cU1tQmVS?=
 =?utf-8?B?UTRCWjFTMzdXMDRtUDFlMUw2dVYxRDdBYlBPMDJDbTUrNi9oM2dSaG1TcTJ1?=
 =?utf-8?B?MjcwcEN5MEZDMGN0eXY1M2tka0lWMjV4bFpVYnlmZmV4eHZjK2FkeGt0R0xF?=
 =?utf-8?B?bU9UcERGazlGWlRoUTZ0RGhtb0tLdDRJOWtvSWlzbVdkSGptOTJ2SmxidUlz?=
 =?utf-8?B?d1duVU5qQ29CVStabjVDL3I5RXpYSDE2V0Y3MDVqNjFyRll3Q1pxTEp3aUNJ?=
 =?utf-8?B?V3N3dXA5Wjl2T0MyOUpzQWhuenozYzhDbmQvYmNkMUxHZDhrZUlOcjJWNFdx?=
 =?utf-8?B?TWFVNjhiTmtQRGc5NVhteng4b0Vab2pkdThoME9JVUJQVGZaS0NaTG4yVFdN?=
 =?utf-8?B?Rm9yV0R0LzNSTm1KVk9nVHlhQkRTUnczN2kvdnVwZU52c0wvZmdFRkQ5aVZX?=
 =?utf-8?B?RHQ1ZS9LSEFUVW9Kbm4zRUhPaUlTUys2N1pCR3dVVHpNZThJcThaMEp0WkJt?=
 =?utf-8?B?ejdLWmMxZnc5Ry9hcUZNQVBVUUhPL09hdkFQbE1EOWlLL1UxUzlRS1ZIZ3BB?=
 =?utf-8?B?bk9DcHd3ZFhNb2ZYZytXZU1vb1hLR0t6WnJCdWZCRUF4Wnc0YUJVK1pwdklU?=
 =?utf-8?B?RGcyVjdQN0VoYjcxQVdSZVJpWFl4ajNWRWZOdjJQRERaZ3Q0T3ptUThpYVFH?=
 =?utf-8?B?Zm9Rek9LRmsrNmhmRTJoeVgxN2NaeXRkK3ZBUlJYR3BaSmtrT29ReEI3NXBt?=
 =?utf-8?B?TVVpRGt3dFQzeElwODN6RThLSEJZN1pTYjN1dFQ5Q2ZOMDlTYkhQbFVzMU9w?=
 =?utf-8?B?cnBFTzl4RDE5QUFaWnBqWE94ZEMwSlFGdzFJWUd6Q1B6Uy84VVBQQUZhYVNF?=
 =?utf-8?B?RG1QeHoydnp5bm1CdHJMeXh6SEJseStLdEh3Z0prRnU0cWxSTU9qZmJOL2VK?=
 =?utf-8?B?U2FaR2dhOWxReEsvL1JHa0hOY2NIeXpPTW8wckVIVElmWE9nZVdiYjR3NlYw?=
 =?utf-8?B?MXNqNUhZZFo1NmtSQWNFYmhJOW1yVnZVQWRzWVdCeVk4dGpiSUpoMXBXclEw?=
 =?utf-8?B?WEFNRWt6Q25lODY0OFdRcEhlZjJ3a1hDeXEwOFc3dFlyUnloSXdJWEgyMFNU?=
 =?utf-8?B?aFc2TnU3cDhmWE9lNjhGRG1NRjJna2ZHYTRYRTlrbE0zcVFJd2pjUm1PNUdp?=
 =?utf-8?B?QkhvWkdiZEJHL2ordFE5blFTYWZWYkRQWjFIUHY5Y2VxSjRXSDFRYXdWY2lL?=
 =?utf-8?B?WVhCN0djRmtCZjYzTW5mKzBmQVlwUEJnYk5HektDRGlickJmV0dRcE14RTdt?=
 =?utf-8?B?ME5YZm53cjFhNzhkYVUwempoRWltcitGYXIyYjJmc0ZmaHRTSnZrcmMrNVZC?=
 =?utf-8?B?dzZqT2MyQUY5SXNPKzNPcFJzZFBwd0R0NmM3dUg4RFRNRGNOdmh5OTZmWG83?=
 =?utf-8?B?a0VZSUY1T0N2SE5hemEyWmZ2YUFTYkZkUW5HS1hlRUlmVzBNd2RLTlNrREFh?=
 =?utf-8?B?bm5wNUY3bU9PcXVQMk4rS1kyclF0VGFNSm1ucUpkdjBES1IyV0U5MSthUXVB?=
 =?utf-8?B?aTNDaXVaUEIrYWJFV0h6QkFHT2padzYwbXk5aFl6eXJSQWgwMG9ZL3p2ejU1?=
 =?utf-8?Q?5OSYmevzLVAWwTWxHE=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?T0RJcUdGaTQrZzJLQWNOZ1cvaDk5S3RyaUhBSUZaeHIwUXVNZ25pdFBxM09q?=
 =?utf-8?B?ZFZJWHBnVXJnNG1GVFBOb29NVG9ENVZYRnZhOWRmMU4wRVJXckFlMUpoWXR5?=
 =?utf-8?B?WFlZL0UrcHBIbFBLQ0duRmZjUzZrdFhSRGxTdmRrbXZLdDU2a1o5eVpHaG9G?=
 =?utf-8?B?MlZPZW8ycXVsdzRoNFViMlV6aE1ndWx2dm1ZVXdzM2FidkI1MHVNOWVJR20r?=
 =?utf-8?B?MG9LQU5hSVh1RGt6UWkrTVpNalRyUzhNaTZ5REFaQ3NOcHZ1ZTJOLzZCL2dC?=
 =?utf-8?B?cW5yZUFZQVl5Z2pWR0dvb041em9HZW1DVzRoRzJZY05Kd1Q5Nml4SExYZmM4?=
 =?utf-8?B?cElpdWFhTElzZTUrRFYvY09BT05qcGpTNU91b1hCc1ErT0ZvNGc1dkdRN0tt?=
 =?utf-8?B?ZWhQcTIxMXo5dGxXUjZOTXhCaGwweXdLUk9qNWQwQno3RG1yelNhbWNiSDQz?=
 =?utf-8?B?N3FHWENZd1MyUU1pSUlqN2ZrbGVCdldHbU5yclJPeHRid0xwZU9JSDRvczZu?=
 =?utf-8?B?S1l0QVJHM1h1amxpMUQ4ai8vT0Vod1hTWStDbE1IakhTcTkxeFB6Y2F6djAy?=
 =?utf-8?B?aENudFVPV1ZGaGJGM1VXS0x2WjNSWHU3KzFPWlBmYWV0TFBtSlJBZzJUM1li?=
 =?utf-8?B?OGlDYzBzYTM4dm51LzEwUm5ieFFYbFVxOHMrS2EvVUdRSTZxVFNkS3huaGN2?=
 =?utf-8?B?MFZKRnQ3KzEvcVlNbVlRUEVxVS9SYkdiYytrQ1p2QVlsVWFlRGxzc1RQSDM3?=
 =?utf-8?B?UEpMVFRtT21jVE1HZWF2WFRnNWxVMUVpMnY1cWo3NWlyS1o3dm13YTIyQjBt?=
 =?utf-8?B?SVM3VHBFbkUyZjZReXkxM1I1MS8vWFZYUFdKUHZmU3I3UkNDUEt1MFljWnB6?=
 =?utf-8?B?TTFvaktCbzRCeVo1K2ZBalV1VVdhSjBMSFJVcFpBQ0t2WGMvWHBtWm5aTHpr?=
 =?utf-8?B?U2FUdEtBTmdXWTdLSXVnVm1SbU5SbUJJUnZ1MmIrWnJ5SS9keVladFJ6OEFP?=
 =?utf-8?B?aVA5RnV5a0pRVitkVUthL2JUeTRGNnRDZnlqMEpiUFRBWlJ1eGhUQlNZQmY0?=
 =?utf-8?B?cFBPdzBuRlhXWENwS3JZOENTMHc5VHQ3Q2V3d2U3U2JuSUcvUUIyZVV6Rk9r?=
 =?utf-8?B?S0IweFMweVpaaGRwdUhESFRaRHM0MmR0WGxONDZuUVR2aU9NaGtYczFYM2dD?=
 =?utf-8?B?bHRUWWM2dFBxdUNBcVpxbmtMTEJvWDZWRkY3dlNDV3psWkpPYzZoNUYrSEJo?=
 =?utf-8?B?Vy83MmdlTUEwYXlYdE1ndko1ay8zMll0MEc2VlhJTksxdGFjeVl6QytxK0Vl?=
 =?utf-8?B?elVGMGNqK1MwZ2t5RGRyN2JUd3UyczluL1hGdy9SS3pJZ1JYVVFUNkJaaTY0?=
 =?utf-8?B?TFBkNmtscVpxNUVORk54NFNwMTJXTGRtekREemRnbFhoSG1CLy96UnZCaFN2?=
 =?utf-8?B?NlVvY2FsekozcEhPdzdJeFRBN1lFdFY2L1dPV3BlR3hEYjVydmsxSWxJMTJn?=
 =?utf-8?B?OTh1UU9jUWdLYUxNVm1WRjRtaTJyL1ZLOTBDendlNC9Mb1pkRCtNUTFySWI5?=
 =?utf-8?B?a3dNaHNPMi9WTUZCdVZod2wxRVdBeXBuZUJNS3doV2g3OG1QT1ljWGZ2RmVy?=
 =?utf-8?B?T2wyNkZJRTBpVHVQYlZxanFLeDc5MnRRdU1zajhiclFJajIyK3ZIbmNrbUpk?=
 =?utf-8?B?bWJBWXFwS2VSakxWUE9NS0g5eE5JTk44SDNZeGxHVVErTGowaFNyL1EwMmls?=
 =?utf-8?B?bjdJKzQ2UDZzZFlIemVJK1kyYnFVTjc1Z0RZZmtsOEROUFZVOEhhanJaK0Z5?=
 =?utf-8?B?ZjVOWlVjRWozek1iMklvUXhWeGFaMm54SDlDNW5BaFV1Unl2VXdvYW1EMlJl?=
 =?utf-8?B?WWt3UXB5dGtHTGxSdHlxWkJvYm9vL2d2bmtjMmxXeVNHY2F3Q3RDbmNOSllL?=
 =?utf-8?B?WXlWV2lpVGNneGp1UXdJWWRqV0pkSFh5TE9ocWZ1ZnFsenR3TTZUazNzWFNn?=
 =?utf-8?B?YzVmcTY4VkpOR3VVNk9RZ3lLTXVwZzhkWjA1M08vVlFyaWV3TWp1Z1k1S0w2?=
 =?utf-8?B?Ym5ZNTdpOW1HWUd3STlRT1JGOUtuOFpaM3IrMjBNU241Y0Z4SkltZDBYTTFL?=
 =?utf-8?B?MHNXL0x3alNCZFdJb20xRzRNUVRueFV3U0Jnc0xzand3ZWh5YzQvM3dkZlh6?=
 =?utf-8?B?ZmMxNDJURTJEV2xMMHRmRnVJMnBrZzgzNC9VcTJLM1hiOUF1Snk0cER4dk5Z?=
 =?utf-8?B?TFhVc1JlVnM3aG44VGRoQlNobEN3PT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	VV1SllW8QxpA6ASB2VCes8up2K1daZ+RKX/6tZpt/KM08+qs9bT48M4wOk6JYbWoPyf/iowY+CtiaBvC4hLav2i9gVzZjmmDNJbli7XXy1zRPrRA2XnSvkMoDxa1V3BmCbrzAW1FqUNtTzwL7LEPHJdt2yEMlanzut5AtRZIPNLN49z1AWkfVzOL4a2+xFWFfOrP3uYu/mzfxb0xy9NgwGdL/Pt5MudbdRypbCsXJs/98YVgheKPrWc+f+fPwICgMYNfwnJjqHD5EKgojH8VBdP5Xk8QFanJNZDsCJyMC0rPYdVnwOpv5C5H3WRxOD+DhSa1tKOa3CBfqVQQt9/QQxgoarS+OG2X9GTOBuGaEPYBmGN/DTGWfzVFKwwYFc2Oc6npXZQSindTgkvRUnbkeOjp7NVJUyCViXMK808HJAKvKAvrWceL6YV5zDoXldY028SAELzQCAoHkRWtoevdocSPGqzZGIO3xynbpATgMgKuihfRPEO4zaXOc2IhG1AmwZ418p0QMg9yeGBurWQkZdoT1LDTMI78s7KX7WJbGBBsemy0mOadUo81Ewu1OS6XJhEFchWkDHTGTmSHxB1um3xgggWoJqRM4jZMvUpHjjs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6913687-e8b7-4842-fad0-08dc98e2aefc
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2024 08:57:34.6784
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qdLagaUOW+mN4X44Ugyi1qqWxkoMb3AnPnRpKGUPz+Qqv/FA2BVdQuJ6f4SdcKMdu2qHLxbyYkG+1/PoJOU7rg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5007
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-30_07,2024-06-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2406300068
X-Proofpoint-GUID: igDmUTWXrIhNq9ODL6HTnn4r2lBTOPXw
X-Proofpoint-ORIG-GUID: igDmUTWXrIhNq9ODL6HTnn4r2lBTOPXw

On 29/06/2024 17:48, Sedat Dilek wrote:
> On Sat, Jun 29, 2024 at 10:13 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
>>
>> Hi,
>>
>> I wanted to test the impact on build-time with Linux v6.9.7.
>>
>> The motivation was to build with and without this revert:
>>
>> $ git revert f1feed67c79e
>> ( Revert "kbuild: Remove support for Clang's ThinLTO caching" )
>>
>> As I read about pahole issues with LLVM/Clang and LTO in the
>> ClangBuiltLinux BTS I used pahole/next.git.
>>
>> $ git log --oneline tags/v1.27..
>> 693522ee3a94 (HEAD -> pahole-next-v1.27-7-g693522ee3a94,
>> origin/tmp.master, origin/next, next) core: Ignore DW_TAG_inheritance
>> with byte_size zero when finding holes
>> 43f9515d8211 dwarf_loader: Print the DWARF offset in
>> tag__print_unsupported_tag()
>> e82a0fdcfb8e dwarf_loader: Simplify tag__print_not_supported()
>> f7e3f0942fed pahole: Bail out when not finding debug anywhere
>> 94a01bde592c dwarf_loader: Add missing cus__add(cus, cu) to
>> cus__merge_and_process_cu()
>> 6a2b27c0f512 core: Initialize cu->node with INIT_LIST_HEAD()
>> 0ce7745fa46d PKG-MAINTAINERS: Add maintainer for nixpkgs package
>>
>> DWARF-v5 was enabled.
>>
>> The slim LLVM toolchain version 18.1.8 from kernel.org was used (Thanks Nathan).
>> Link: https://mirrors.edge.kernel.org/pub/tools/llvm/
>>
>> This constellation is BROKEN in the modfinal/BTF section:
>>
>> # BTF [M] drivers/gpu/drm/i915/i915.ko
>>   if [ ! -f vmlinux ]; then printf "Skipping BTF generation for %s due
>> to unavailability of vmlinux
>> " drivers/gpu/drm/i915/i915.ko 1>&2; else LLVM_OBJCOPY="llvm-objcopy"
>> /opt/pahole/bin/pahole -J --btf_gen_floats -j --lang_exclude=rust
>> --skip_encoding_btf_inconsistent_proto --btf_gen_optimized --btf_base
>> vmlinux drivers/gpu/drm/i915/i915.ko;
>> ./tools/bpf/resolve_btfids/resolve_btfids -b vmlinux
>> drivers/gpu/drm/i915/i915.ko; fi;
>> ld.lld: error: drivers/gpu/drm/nouveau/nouveau.o:(.debug_str): offset
>> is outside the section
>> make[5]: *** [scripts/Makefile.modfinal:57:
>> drivers/gpu/drm/nouveau/nouveau.ko] Error 1
>> make[5]: *** Waiting for unfinished jobs....
>> ld.lld: error: drivers/gpu/drm/amd/amdgpu/amdgpu.o:(.debug_info+0x7d117f5):
>> unknown relocation (33554442) against symbol
>> make[5]: *** [scripts/Makefile.modfinal:56:
>> drivers/gpu/drm/amd/amdgpu/amdgpu.ko] Error 1
>> make[4]: *** [Makefile:1852: modules] Error 2c
>> make[3]: *** [debian/rules:74: build-arch] Error 2
>> dpkg-buildpackage: error: make -f debian/rules binary subprocess
>> returned exit status 2
>> make[2]: *** [scripts/Makefile.package:121: bindeb-pkg] Error 2
>> make[1]: *** [/home/dileks/src/linux/git/Makefile:1541: bindeb-pkg] Error 2
>> make: *** [Makefile:240: __sub-make] Error 2
>>
>> Before doing wild experiments I like to see a confirmation of
>> reproducing the ERROR.
>> Nathan, can you support me?
>> My last successful build: Linux-kernel version 6.8.10 using Debian's
>> pahole version 1.26.
>>
>> Attached is my linux-config which is based on Debian's kernel v6.9.7.
>>
>> Thanks.
>>
>> Best regards,
>> -Sedat-
> 
> [ Add some BPF/BTF folks ]
> 
> I found upstream commit fcd1ed89a0439c45e1336bd9649485c44b7597c7
> ("kbuild,bpf: Switch to using --btf_features for pahole v1.26 and later")
> 
> Can BPF/BTF folk comment?
>

Hmm, the above commit doesn't look relevant to me; it just switches to
using a different way of expressing command-line parameters for BTF
generation. From the snippet above you either don't have that commit or
are using a pahole < 1.27 since if you had the commit you'd have
"--btf_features=..." on the commandline instead of
"--skip_encoding_btf_inconsistent_proto --btf_gen_optimized". The
relevant errors from the snippet above appear to be

>> ld.lld: error: drivers/gpu/drm/nouveau/nouveau.o:(.debug_str): offset
>> is outside the section
>> make[5]: *** [scripts/Makefile.modfinal:57:
>> drivers/gpu/drm/nouveau/nouveau.ko] Error 1
>> make[5]: *** Waiting for unfinished jobs....
>> ld.lld: error:
drivers/gpu/drm/amd/amdgpu/amdgpu.o:(.debug_info+0x7d117f5):
>> unknown relocation (33554442) against symbol
>> make[5]: *** [scripts/Makefile.modfinal:56:


...neither of which originate in the BTF generation pahole does; this
looks like a linking issue with ld.lld. Now insofar as such an issue
messes up debug info generation it could certainly impact BTF generation
in turn, but I don't see any output that suggest that is happening above
(BTF generation operates upon .debug_info sections once they are
generated but doesn't actually generate them itself). Is there
additional info that points at BTF generation as being the problem here?
Thanks!

Alan


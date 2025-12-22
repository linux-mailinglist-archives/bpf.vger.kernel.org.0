Return-Path: <bpf+bounces-77286-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF0ACD5397
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 10:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 39CB0300E82F
	for <lists+bpf@lfdr.de>; Mon, 22 Dec 2025 09:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1104A239E79;
	Mon, 22 Dec 2025 09:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lSekNCCk";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CnSyEfvn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20DB02874F5;
	Mon, 22 Dec 2025 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766394033; cv=fail; b=taACLVsOuDTL3lFg4PXFpZDwWWvDKdSOfB0sYfkWAdIIK4l6FFu86rgNzIBzthsOyGsFMrZONuVDZikmsyjbWqQj/oc9LKib809IXKBktSCWWD5L8oyfiNdY4w0AvTK5Srhl/0wVzAjMmZX27rvVZeSZg7NQkMXyHejNlgRnkg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766394033; c=relaxed/simple;
	bh=CHUtiGKm1QTJtLpl3AHDsncBg7qW/11BYHSRJxssHl0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=u35Vzj1JVXCAriXBuWJYuIOcgMqoTjr0YfY4TV4PyzIFfzkV8iNtLUwCUm4X6EAakUbE0OEovRlcBfr0IyQLzcYLl6twt6UdlLUjLlw3nNbC6luBL95A4A7jvy8gUBrhCVTc43sF9/zaTEoQyDCaEGO+xu7cYAdPxC2divyUcXU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lSekNCCk; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CnSyEfvn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BM8lVc91732370;
	Mon, 22 Dec 2025 08:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=OuFWijtHFAhD6kSOY31pNeiU+L1G1J4D9NhCvZhNCdo=; b=
	lSekNCCkiQkPJjvOMuIBbfRoKuq3LJCAEXN75vcK7z+sMtnlUVwoGgVV/F6j3si7
	hMzyFc0H7bXWVU1tz8iV+7vvYnrjcEWXh/sR7+NurgCz/Q8fwQsjRQdNFrFHgq/Q
	uWBODnxTLCA8ci7bzBfwmgwQTlxKeJTI2rVkcfd0cWaSxaOtowTysTsaWt86uC65
	4ld10GNv/sV2nnNL6MnJiMocXosoiJTtiO6kZipIYQvYFKiRVL1AWdAgXD4C/Dtn
	Hyv0gyH7a42Q1loVO5iazsLMFzzyPr0gpuQX3Xi6cyGm05wwZFqAuUHo8QRaVqwm
	khFCiqvJWHF4QJ7W25e6Bw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b72sr00gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 08:58:38 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM7EH1e040045;
	Mon, 22 Dec 2025 08:58:38 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011055.outbound.protection.outlook.com [40.107.208.55])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b5j873jgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Dec 2025 08:58:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZzgrVEIKqBwBswu6WRAaNVYQxvl9/+84ADCdjPgkBeVpPZNZlMX5L+wAko5eaCn76HaAfNn8aSztOiLkuvjcxnEAtAyX06WkjhFdQQERQxiHaVGMqeFtns+/i2ZDBKk+i4tYVtb378tqV6hc8Qf59csV9PXjwPyfxfE9BvPEDjOQusWY6pA7qBvYMOMdp8BrbnXTIOcHUudjyZ92Mvvid2LVN5PpCV7g/IOVEsWBOaI9E7xO2AVPxHEzOU3QAkZivMiAhrg+Zs1sLd6vWTdEQJRsqMjddkSc1lT1NhXj2xNrRVCOT/dmLz6Vx0deXPAuZ4xahcZmjNh637AMaB8S3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuFWijtHFAhD6kSOY31pNeiU+L1G1J4D9NhCvZhNCdo=;
 b=DeX7tSchTz5z7YsJ9FE3cx9+YNejJkeXd0P/ddmro90ZnN58zYDPhJlupv/SiOQon6J0j7mUmPRpDaP0uQrAgcN66PVJUhirAGGd8AgfXEWE0MnTNEls5TYJx6RaZ1xesMugEVdrQQVhohiAX65AUOY/0qzKLPl9a295yN8lkl6PSmlk+tgixIaNFxoEtpN3WH5K+DYdD+I2y4xQJ5Lo3v/eWkVqd0ZhYJYR1xMz2W6llIFQu/f1LbcXN1GJB8yA63FwhYrlSOxhw01Oxgem1CL98kJ9aqojzXOsEJOJ2PZ0JjOqFK33MxMdzyXj0oDYypRNyLQnGT/dGQ/K//9ExQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuFWijtHFAhD6kSOY31pNeiU+L1G1J4D9NhCvZhNCdo=;
 b=CnSyEfvna92jNhRTLZ5K8XBLn2JgweaC1W3fqs8lhUBWnA7A8S5eY+hUmOdJC0XJerPSTVx6IErv4cjnmeCPF1zmYfEViQ1KLTNOlmTXl36Ac6Ug1HQV1O+PKd6nefYawQXLBv/CX2tCleEPLPsEBKmYTzOQsPmdk9NN0PthTZ8=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 MW4PR10MB6581.namprd10.prod.outlook.com (2603:10b6:303:22a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.11; Mon, 22 Dec
 2025 08:58:35 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9434.009; Mon, 22 Dec 2025
 08:58:35 +0000
Message-ID: <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com>
Date: Mon, 22 Dec 2025 08:58:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>, Eduard <eddyz87@gmail.com>,
        Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        dwarves <dwarves@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
        Thierry Treyer <ttreyer@meta.com>,
        Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
References: <20251215091730.1188790-1-alan.maguire@oracle.com>
 <20251215091730.1188790-2-alan.maguire@oracle.com>
 <CAEf4Bzaw6KRU2yDbawOe+eusCjCwvg0FwhkpvGA3HE=gC=ZLbQ@mail.gmail.com>
 <42914a9b-0f34-4cee-bc36-4847373fa0b5@oracle.com>
 <CAEf4BzZuikZK5cZQyV=ge6UBKHxc+dwTLjcHZB_1Smw1AwntNA@mail.gmail.com>
 <e2df60e1-db17-4b75-8e0e-56fcfdb53686@oracle.com>
 <CAEf4BzarPLAcwKApft_nBVM_d3WW58zytZfLQVz387TF2c2FVg@mail.gmail.com>
 <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQ+achE6ebfCxyfHyxMMFJ-Oq=hUK=JkWUAGwz+7HeV4Qw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DUZPR01CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::14) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|MW4PR10MB6581:EE_
X-MS-Office365-Filtering-Correlation-Id: 251c45d3-8eb3-4319-f275-08de41384a09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SWYrU1Y5SjA3MnM5SXYxZnNpbEVoc25lRjRMM1BHcDJsZTh0OXBOWWZyMXEy?=
 =?utf-8?B?MzduSkdnTXN0dnM0UmIrMkUzODBjcGhQd0pSWTlWdno3cnlFTCtYYWJtWFJN?=
 =?utf-8?B?c09mcUFiRmpTS3ZwYnl4blJZWUl1UTBzekJrd3B2dEhqN1FPYitFaVViWnJX?=
 =?utf-8?B?YUUrc1Jram15Z2NlVXZxamNETFArTWxxcFZnaGFyTnR0NXRSbTk4eWZYZlJX?=
 =?utf-8?B?YjFQNldsZjJHZVAzYkJWc2hTVDZ4SUxLRlYxenhNWERDSU9aeWh5Uy9ZZEFa?=
 =?utf-8?B?c2o3V3YyUkpzMGY2VkpuVGJESU1leHk0MzFBZjB0c1AyTkZNWDdtT0FCc213?=
 =?utf-8?B?RkdOaGlTUmNVV1JuZU1FVURzd0E5SU5oTjNobEVJRTJ3ai9za25nWW1jN1RN?=
 =?utf-8?B?MldoU0M0Qm8rYkFJRG55Q3dwcXBPQm1TdzdSc2FGNE01SGZaL0RxZUx0RVkv?=
 =?utf-8?B?bDVkejlVck4yeDhLRm5leTkvWVNaRmxwMXpEeUVHSHJpekdPemNoTXhWdjJ6?=
 =?utf-8?B?VFNtUHEydjk1TXAxRDh4UkxldnNnMlNkK1dPdGJXUnFWQVd6Um9MNWIrWS84?=
 =?utf-8?B?OXMyWnhCVTEyYURHek93aTNVMGlNOFdZbjZCenlSNFBqbTUxN21nbzFOVng2?=
 =?utf-8?B?UXBiYlZpMlFOTnJiMUZrMnRYdVpmUWRhblFwQy9SYmJ0Y0JRdlBzTnR1ZUtK?=
 =?utf-8?B?akhJK3VhRVEvWFF1a3N6L213SllHTk5WMzY1SW1tRHBoSkxHaGd5TVJrakZB?=
 =?utf-8?B?YXNtdUFsUzJoVVhtdXowc2NhS3VLMGZVRS85VWJEMHAvVWVBQ25RUEhCT2Zz?=
 =?utf-8?B?VkVoRkhpR0kwa3FhWHFZMUlwY2QyTlBZV2poQkFQUXNDYlkzdW5DOWVkMnkx?=
 =?utf-8?B?cllWOHpMa1ptV3ZaTzhKZk5IK0N6SGtKd0FScHk1V1RyQTU4R21NeTM2UW54?=
 =?utf-8?B?OWRQZWZEM0NTaG9yRTNsRjlDczIwQmNSN0x0WXpyZGVKdURZQ0c5d0JQSDdn?=
 =?utf-8?B?WjFIejdEdUZrc0hDejgxZS8xVUFjWDJkRXo3Uk5waHlSRkdGQjZ6aW5CVnV0?=
 =?utf-8?B?NnNLMDZINkRDMW5IV3BxU281dDVPa3lOY1diSmlKUk5jQ3Zyb0hxTlpuWkNI?=
 =?utf-8?B?SGdYdXdZUm53RHVBSXczVWRwUng1NW1tTk9nUkVaaDZZU3hod1cxaXc2MDdJ?=
 =?utf-8?B?cS8xSjRIa29OVnNrR0Z2VTdkVjM2SEd3b0lCL0svdGJoZXFMTEFhM3dYdUZx?=
 =?utf-8?B?Q21OZUZiS29OQ3VoY3Mxemsxc3lpbkRqb3lNdTJ3RlhRTUt5Q3R1dVA2eGpu?=
 =?utf-8?B?SmJVTmxvTXl2MmZzQThKdVRVNEhSRytKRmRrZ2NmaTJYb2pmVFZ4OW5rQ0Z4?=
 =?utf-8?B?NmRwbzhOMjZoNlAyN29BUEFnMUJVTi9KdkRsZlIyQmNiM0JRZGZPWTdXampY?=
 =?utf-8?B?UjRUY0ZmcnhvMXd6VnJ3Tm5COFJ6cUVMeEI1emRKb3QvNDB4ZXV4Q2ZMcGFH?=
 =?utf-8?B?YU5hS01XczN0UDdiTVZMTXp6RDRPbmVVeEtXTEtvSzZlSlM4aW1jWVdwK1la?=
 =?utf-8?B?WWZ2aTh1S29YcEpFK003TUU5dFBtTXVBQjBadHc5bm5ISGNCcjlaTEoyYmtH?=
 =?utf-8?B?RlYwVytVUXFyZEpXWG1acUpIcHdKb3NGb2t5aTc5MzR1bkovUFl3YXVneEl6?=
 =?utf-8?B?dGxQdUFTV3p0eEk3WXA5WlpZTndZNy9QbGdzZ2U1OEd3aloxaklWQzdBb0I4?=
 =?utf-8?B?QnlLeHh5dlVlNk9oZTFFVmtOcHVVaERWaWliNVVEMHFtS1lHMU5kcVllQnkr?=
 =?utf-8?B?d051VTdaZG1XOG1pb2Y1N0dvK3UwVXpWdkZHeFF5dGNnT3VibUd2VW1qMjZs?=
 =?utf-8?B?dEkxZXZYbzFrQmlmR0cxTkRBQWNNT3ZPOTNGeVRSb0I5WFhSeDRBNlN5TG10?=
 =?utf-8?B?eFJEN2x3SGI2WnpqYWVRVG9wRTdFZzU1ZjZqaDhrdDQ3TllQRDJOamNSYlRV?=
 =?utf-8?B?a3hQa0VrRTVnPT0=?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UEdoRGZQTERkT1dtbzNwNGoxTFZQeFB6bTFaVjduZzkwK2ZLelBjTFRHRXds?=
 =?utf-8?B?T1dKS3JlL09ZTG9aRkFzVjJSRUxZdlNxYmRYN3Jsdk1rbFN1bHJpZmR2eVhm?=
 =?utf-8?B?T3FFd2dhSkJsYTJ5K2xUZG9PTlNtcDJFRnlmUGlPeUlTV2xXbEwyTlM0eEZK?=
 =?utf-8?B?d0tnQTJaOWJiaG42Nkg2bUhNU0RTV1A4ZHJXS3hsMWlBZmVFK3JVbjQrL2p4?=
 =?utf-8?B?SjYvdVRscitmUHZaZmF0MC9OLzJieHVSMHI3Mmo3c2RVUXYyV3dnZEhpbjBW?=
 =?utf-8?B?djdodkJ5bk9uUEhiQWdmdEVObW5UT2VjUk45VFVvV2NpcFNacTBnRktkaDRp?=
 =?utf-8?B?Y0JzL0VxNC9sd2E1Tk81ekZ0QUYxLzVLbTZNSDdqY3VEOWhjQUs2emp5azVJ?=
 =?utf-8?B?QkdJWGhQaG4rRUNWdHNDSFR3WlFCSXNMY25WT1hJTzBwSjRPeWM3OXA1UzNX?=
 =?utf-8?B?R050WXZnQk5heTFqL1dFbWxNNEN3QVZtenhUcHV0U0x3MmdsMnZyTDRvM1FR?=
 =?utf-8?B?cFhIaTJvNTZVNFMrUXgzWDgyc1pFT29FTlFvN05tR1F6cmJJdUxwRUxySU10?=
 =?utf-8?B?MGpsa2lvOWxXVE1GYkVSSzNNNnlzNHhxdE9xOCtDZWVQN0tyR3F6bWdXUzA0?=
 =?utf-8?B?THNnZlZLV2FQY3JoUi8xVndWRzYwc2NXSmdDOFRmKzhZWUdsS1NVUEJqUE9U?=
 =?utf-8?B?eklmL0hvUWcreTV0QTJ3OVlVSmpEaWNLdExNdGUweEZJTm1lN2V1cFFEeVdr?=
 =?utf-8?B?K3c2QTVvc042SzY0T0tnbHpodWJQamZ3SEd2M1VaZ3ZmckNkSVJ2cGFXVHBF?=
 =?utf-8?B?TEkwemEzYlYzWEdqZnM5dWFQOUFLYytSQUp3Sk1laWFxa2NlRmhWVFpzbWt6?=
 =?utf-8?B?cGxNTWhVa1QxWC8yblZranJmU3oxeTB5R2tLcWEwWmhHNEhDSWFMbCtkSEw1?=
 =?utf-8?B?RTFBcmE3MU9qditxYW13RFB1Tm1iczdLKzQwWmdNZjFJVk1tTDJpRUE5NWkr?=
 =?utf-8?B?VW9YV3NZOGd5TU16enRncHI2YUhDUW9JVDJTaC9uV0dOWmVQWEpIVmhiTytB?=
 =?utf-8?B?OGVGT2RxUVlLcVRVZXRQTXR5RDRucGJ0c3U4M0dBNlc4UnlBUXpyaHdmcFVx?=
 =?utf-8?B?Nlo1dy93ME8zQ3JIVUtlcGcxSUNScm9IYTNySnFhWmhFeVVjV3NZQmRtOHU0?=
 =?utf-8?B?OVZhQ1lWczU5cVlCOS9iVVdxZlpMQ1Bmd3NCK0lXSGZiUlFmTFB5T242bk5y?=
 =?utf-8?B?L2F6WStQZTBueWJyMXdFMGJZVVBhbnVCalNBbjZiWlFrQUdxd29vV2wwd1Fz?=
 =?utf-8?B?YmRrNHpKNWRaRGVONDk2VHRRWFpwU05RTG1mZk1oMVpkclZLd1k1T1BXenpy?=
 =?utf-8?B?Skt4RjY1TXRaNUxqcmtYdHNvOTBrb2lFSk1sTTlwb1p2ZTliNnp6U3k1UVpw?=
 =?utf-8?B?QWRWK2JxSkljQlljYjBLbDRWRko2d05pMU1scllxb1RLQW03UVJ3NTJOZzZB?=
 =?utf-8?B?bGhmQ1V1aFVyNGJvREk1MFdqVXdpZVpyR1RDZWxQWXpuQ2NUbXZvR0VIQmV6?=
 =?utf-8?B?b214Yno4b1pWMmN1Tm9DNW43ZlJ3WUZxUUM2aDFUZTcvWUg1TlA5cU12a3Ri?=
 =?utf-8?B?bnBHaThnUnNoZm9sOFlOS3c5dytsWEc3bmlDcSttMzBiVmVoYnhLM2x5YkVk?=
 =?utf-8?B?ZnFDZXNCN0s3Nkp5bFdGRU9zUG04R3FPcFpNYllXRXk1bHV2UlNkcno4L0xX?=
 =?utf-8?B?RkFoUThaQlZsVnBMREVYRmR0WEkvUnlIQW9YeC90V2VWNmNveUhLdWVSTnow?=
 =?utf-8?B?NlBFeks0aytudlBlQXF5WnUyY1BuSGpmcjdVelNIZWtYK0VhM0VIemkwQ0xI?=
 =?utf-8?B?MUwvdkd0eFZmbzkxeWtFNXAyU2l6MXFRV01NcUVRRFNsV21NR21teFN1MXBk?=
 =?utf-8?B?blFVczQ0Y1NjZnFkWm5lckJLbFFIQ25FU3I5TXYzM25kcHpiYTljbXlsL0Zu?=
 =?utf-8?B?emIwTVM2dWJFZnBYMi93c1JtQmNGbDlBa3dUQTFPcVlaemRPR2xKZFVVOGUy?=
 =?utf-8?B?d3JSYjM3a1NuVW9PeTNJTldZYi9zZ1B3RDJTdWJ2VDJkaEtmSEhFZ0Iwb2Yw?=
 =?utf-8?B?MUVYREVPenIyYklKVjlvN1FzVnRkOStMZVE3SVFJN2w3Q0orKy9hT3J0NmdM?=
 =?utf-8?B?S25vZVMvMW5UeGh1L0UzN0dyWitKRWpmL2RCWVFGaXB6NTFtd3JORVBKYlA1?=
 =?utf-8?B?TnpjbmFCd0hUamtKZ2cvbytzS0RwZ1VDUndRSXV4TXlCSGNSNmpJVU5IMXpI?=
 =?utf-8?B?NEllSkNMZStxK2E0OEY5cTRhYU1obUlYSE1uaWZvcEd0TXdSdXViUT09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	CNN494QEYGYIMlJI4Ss7TXLR1LGwm3gmREbfoG5fFNe8tbQEx5lENj7XYqbRkMpBFB2g3ZVMvS6avM9Y5DMkjCfhbo64+NehrXSm+dtuPn16jTsU7KcY0bgB7xR2I3Qnc+PqWhn0qQOmN6Q5GMOKYUI1rfl3SUwDnEBRnc+8MkwQXUSLoReeEQXGZOzrms/1BjT2GDYw3nD6gw26cy1mBMt2Yhb5kiKqTngHu1rcC7KDgUj/Ur4krSb1qTCr1Tl7bjqPQ39s894o4qRePL3Jhs6t0huGql9O4w4T6S/RWT0s2bQeG9mSDCTBNFjX+liekI/qRKK1p4SkfFH4iviSPlqFrHMI4Cz7ybmw7ZGLgxkJFUbV9YEp7Luk814wEBfR52pWbPtTAnxQVddkdZzviE2XmGMo92UD1gDhQ6kkXL5+zV87bvDxay95IfQNNo3AvErasdETtBrApcBZRPRBl/Ihf8w0j7jtKrSS8cL0Jj/SQZTUOaxvYu4MtfoYwvdxpXn0SGbWqtq0tFi5kHeZR8I6OYKyIWHMkdcnqoBUdN9hPgH3PUXY8soKbjCK8Y7NUsABkRwvNAlrfnE28MOBxWS0/j2Smb9l3MGraSov0vE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 251c45d3-8eb3-4319-f275-08de41384a09
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2025 08:58:35.1756
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0jmG3KXdTbr2GET/7ORjMituvzCTmhulc0vRgiGIzkEE7kg/EUfpZdIf5z7bj8jbZlbqXRf7EYgH5oZyYuB5Yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB6581
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512220081
X-Proofpoint-GUID: Javn9-h8PPrnSN5ICkDm9xX0t5z9bODj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA4MCBTYWx0ZWRfX6pLJC815ioby
 SMZ2KxDQQiJLyOXvokbvORW7ZgPvLRIdHiyMLdzfRreKIRigBWLt+NyOOb70FhiwJFlpeLHQldl
 Wu0ytgYzJmHu65CUpEFGNrJON9NncZljoZX09VOul3+OYe80Vq0aVtdvUiKOKP5h5mzixEv91BO
 Nokav4vWUXybKq2K2oEkgxfuMvetcHGqIj9lVvIs/rhn5Qp9mePZE4K6hYHYFc+6XIdiSYnMYen
 QmLdx9nCNlTvHQ7tbo4IRjULcG1rDxBMhWx0dwDkC20NFTdyLaTX82joxGVmCM8840gxIPhin/b
 HTQVVtv4IJbLuRBeGEfN/jipMWp8ciHoG3qBjCVuTLetNTowcNGOMbVH3hy0XQ3mIF75hgq1iJ1
 USL+EIBTgN0zNKeRVlKL4w2z31iKrYD6Uqe8+LQm6mJ0vkx/svzOTZcbCUCbCM0jfjAbQxEKP8U
 cmQOOi6ZMOXvZQvyqJw==
X-Proofpoint-ORIG-GUID: Javn9-h8PPrnSN5ICkDm9xX0t5z9bODj
X-Authority-Analysis: v=2.4 cv=KJNXzVFo c=1 sm=1 tr=0 ts=6949083e b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=vdGYDiZz1HvJ6Cqlt1AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10

On 20/12/2025 00:05, Alexei Starovoitov wrote:
> On Fri, Dec 19, 2025 at 8:19 AM Andrii Nakryiko
> <andrii.nakryiko@gmail.com> wrote:
>>
>> On Fri, Dec 19, 2025 at 10:14 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> On 19/12/2025 17:53, Andrii Nakryiko wrote:
>>>> On Fri, Dec 19, 2025 at 5:15 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>> On 16/12/2025 19:23, Andrii Nakryiko wrote:
>>>>>> On Mon, Dec 15, 2025 at 1:18 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>>
>>>>>>> BTF kind layouts provide information to parse BTF kinds. By separating
>>>>>>> parsing BTF from using all the information it provides, we allow BTF
>>>>>>> to encode new features even if they cannot be used by readers. This
>>>>>>> will be helpful in particular for cases where older tools are used
>>>>>>> to parse newer BTF with kinds the older tools do not recognize;
>>>>>>> the BTF can still be parsed in such cases using kind layout.
>>>>>>>
>>>>>>> The intent is to support encoding of kind layouts optionally so that
>>>>>>> tools like pahole can add this information. For each kind, we record
>>>>>>>
>>>>>>> - length of singular element following struct btf_type
>>>>>>> - length of each of the btf_vlen() elements following
>>>>>>>
>>>>>>> The ideas here were discussed at [1], [2]; hence
>>>>>>>
>>>>>>> Suggested-by: Andrii Nakryiko <andrii@kernel.org>
>>>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>>>>
>>>>>>> [1] https://lore.kernel.org/bpf/CAEf4BzYjWHRdNNw4B=eOXOs_ONrDwrgX4bn=Nuc1g8JPFC34MA@mail.gmail.com/
>>>>>>> [2] https://lore.kernel.org/bpf/20230531201936.1992188-1-alan.maguire@oracle.com/
>>>>>>> ---
>>>>>>>  include/uapi/linux/btf.h       | 11 +++++++++++
>>>>>>>  tools/include/uapi/linux/btf.h | 11 +++++++++++
>>>>>>>  2 files changed, 22 insertions(+)
>>>>>>>
>>>>>>> diff --git a/include/uapi/linux/btf.h b/include/uapi/linux/btf.h
>>>>>>> index 266d4ffa6c07..c1854a1c7b38 100644
>>>>>>> --- a/include/uapi/linux/btf.h
>>>>>>> +++ b/include/uapi/linux/btf.h
>>>>>>> @@ -8,6 +8,15 @@
>>>>>>>  #define BTF_MAGIC      0xeB9F
>>>>>>>  #define BTF_VERSION    1
>>>>>>>
>>>>>>> +/*
>>>>>>> + * kind layout section consists of a struct btf_kind_layout for each known
>>>>>>> + * kind at BTF encoding time.
>>>>>>> + */
>>>>>>> +struct btf_kind_layout {
>>>>>>> +       __u8 info_sz;           /* size of singular element after btf_type */
>>>>>>> +       __u8 elem_sz;           /* size of each of btf_vlen(t) elements */
>>>>>>
>>>>>> So Eduard pointed out that at some point we discussed having a name of
>>>>>> a kind (i.e., "struct", "typedef", etc). By now I have no recollection
>>>>>> what were the arguments, do you remember? I'm not sure how I feel now
>>>>>> about having extra 4 bytes per kind, but that's not really a lot of
>>>>>> data (20*4 = 80 bytes added), so might as well add it, I suppose?
>>>>>>
>>>>>
>>>>> Yeah we went back and forth on that; I think it's on balance worthwhile
>>>>> to be honest; tools can be a bit more expressive about what's missing.
>>>>>
>>>>>> I think we were also discussing having flags per kind to designate
>>>>>> some extra semantics, where applicable. Again, don't remember
>>>>>> arguments for or against, but one case where I think this would be
>>>>>> very beneficial is when we add something like type_tag, which is
>>>>>> inevitably used from "normal" struct and will be almost inevitable in
>>>>>> normal vmlinux BTF. Think about it, we have some field which will be
>>>>>> CONST -> PTR -> TYPE_TAG -> STRUCT. That TYPE_TAG shouldn't just
>>>>>> totally break (old) bpftool's dump, as it really can be easily ignored
>>>>>> **if we know TYPE_TAG can be ignored and it is just a reference
>>>>>> type**. That reference type means that there is another type pointed
>>>>>> to using struct btf_type::type field (instead of that field being a
>>>>>> size).
>>>>>>
>>>>>> So I think it would be nice to encode this as a flag that says a) kind
>>>>>> can be ignored without compromising type integrity (i.e., memory
>>>>>> layout is preserved) which will be true for all kinds of modifier
>>>>>> kinds (const/volatile/restrict/type_tag, even for typedef that should
>>>>>> be true) and b) kind is reference type, so struct btf_type::type is a
>>>>>> "pointer" to a valid other underlying type.
>>>>>>
>>>>>> Thoughts?
>>>>>>
>>>>>
>>>>> Again we did go back and forth here but to me there's much more value in
>>>>> being both able to parse _and_ sanitize BTF, at least for the simple cases.
>>>>> What we can include are as you say types in the type graph that are optional
>>>>> reference kinds (like type tag), and kinds that are not implicated in the
>>>>> known type graph like the location stuff (it only points _to_ known kinds,
>>>>> no known kinds will point to location data). So any case where known
>>>>> types + optional ref types constitute the type graph we are good.
>>>>> Anything more complex than these would involve having to represent the
>>>>> layout of type references within unknown kinds (kind of like what we do for
>>>>> field iteration) which seems a bit much.
>>>>>
>>>>> Now one thing that we might want to introduce here is a sanitization-friendly
>>>>> kind, either re-using BTF_KIND_UNKN or adding a new vlen-supporting kind
>>>>> which can be used to overwrite kinds we don't want in the sanitized output.
>>>>> We need this to preserve the type ids for the kernel BTF we sanitize.
>>>>> I get that it seems weird to add a new incompatibility to handle incompatibility,
>>>>> but the sooner we do it the better I guess. The reason I suggest it now is we'd
>>>>> potentially need some more complex sanitization for the location stuff for
>>>>> cases like large location sections, and it might be cleaner to have a special
>>>>> "ignore this it's just sanitization info" kind, especially for cases like
>>>>> BTF C dump.
>>>>
>>>> So you mean you'd like some "dummy" BTF kind with 4-byte-per-vlen so
>>>> we can "overwrite" any possible unknown BTF kind?.. As you said,
>>>> though, this would only work for new kernels, so that's sad... I don't
>>>> know, I don't hate the idea, but curious what others think.
>>>>
>>>> Alternatively, we can just try to never add kinds where the vlen
>>>> element is not a multiple of 8 or 12. We can then use ENUM
>>>> (8-bytes-per-vlen) or ENUM64 (12-bytes-per-vlen) to paper over unknown
>>>> types. FUNC_PROTO (8-bytes-per-vlen) and DATASEC (12-bytes-per-vlen)
>>>> are other options. We just don't have 4-bytes-per-vlen for the most
>>>> universal "filler", unfortunately.
>>>>
>>>> The advantage of the latter is full backwards compatibility with old kernels.
>>>>
>>>
>>> True. And I guess during sanitization we can just handle intermediate
>>> types in a type graph by adjusting type ids to skip over them, so we
>>> likely have everything we need already. Funnily enough the BTF location
>>> stuff will give us a vlen-specified 4 byte object (specifying the
>>> location parameters associated with an inline), so that will help in
>>> the future for cases where it is recognized but other kinds are not.
>>
>> So coming back to flags? Let's do two flags: "safe modifier-like
>> reference kind" (for type_tag-like things where they can be dropped
>> from the chain of types) and "safe to ignore non-structural type" that
>> can't be part of any struct/union and are more like decl_tag where
>> they only reference other types, but can be dropped/replaced with
>> something? And if kind doesn't have either of those, we won't attempt
>> to sanitize (and hopefully we won't even have kinds like that, but if
>> necessary we can add more flags with some other "safe" semantics, if
>> necessary?)
> 
> Hold on. I'm missing how libbpf will sanitize things for older kernels?

The sanitization we can get from layout info is for handling a kernel built with
newer kernel/module BTF. The userspace tooling (libbpf and others) does not fully
understand it due to the presence of new kinds. In such a case layout data gives us 
info to parse it by providing info on kind layout, and libbpf can sanitize it 
to be usable for some cases (where the type graph is not fatally compromised
by the lack of a kind). This will always be somewhat limited, but it
does provide more usability than we have today.
 
Alan


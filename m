Return-Path: <bpf+bounces-53908-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A5DA5E20D
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 17:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 205CF174A67
	for <lists+bpf@lfdr.de>; Wed, 12 Mar 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0063242904;
	Wed, 12 Mar 2025 16:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eSIg9F1X";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cvLEDlDT"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756B71B0406;
	Wed, 12 Mar 2025 16:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741798383; cv=fail; b=Nnea69qRemQbYL9qU7FgR/WnQz9XZ1+h0X6dYNNsiodWuA3E3mSe2QDKrL+i8oCir6N2bojgG2O7epF8NdFVhQNuXKgupPXBAeW0Qe8rFLszP40Lm0sU8rvt6yS7g+MagsE+oAXadnamVsPvCdHwuCCLa1n5Z8NmOXdApOrsH7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741798383; c=relaxed/simple;
	bh=8RbQ/ZNZ4GcjYupABprSrum54DNI4wL4FkUJiD5sAMA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=EUnHQAO8oGBD+ScUH3+GbVPC22mDsvEvRutyjISDOtg+0xiJGrzaRIHzGxGqsFtM745mSEe+VmYBseHxSQXZMmB9LUTqGhVT5mly8xwcrapTLx22pXWJZ9FoTJZ3xQllFp+fgffICVkq1wS+/K0cM+wBhicdLLyoqS2GetA4d9c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eSIg9F1X; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cvLEDlDT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52CCM3ge022173;
	Wed, 12 Mar 2025 16:52:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=iSNKv64SIyrKiPlO8CXYyZhG76pJkcA2pMdVPSzwiLg=; b=
	eSIg9F1Xl24NpjMxPYQsfkqh1gtcsUsqVLergd/O2cdZh/oxEE+EVXA6+kUolOqT
	izPI6H85wVt7kQVgBIz85eBaCxY194DNBNCDWhiwzMHfg6WfZhHodZzh0UA4nQaY
	wMmtkBdRJCJHc62QNnhFiJ159u0ep8y0easc36mZ8YfLK8rAzUG/2ay5j4b9MEs8
	FRAjwDrYx3NXJ33ett46ptnADfM62PUO2BCQ/bXW1KTC+kov1dArCFDsu4ool351
	YLGvcdazmf0OwCdh6MTAFhWGqKhXcOIlYtp1RSzHbzcR021ykZtTZKU9OUuS11ep
	NLHuXTus/V18XNL27NAlJg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4h28rv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:52:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52CGYsgq022296;
	Wed, 12 Mar 2025 16:52:50 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 45atmvgqt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Mar 2025 16:52:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dy3T6YYeQk2/bsG3Iy8NW7Ffn0H9QGbYJL4S2XIJsluaOIjSHfCCnUYoHCCvzT0UPn5anjLHrh1JuJBg7jkTo+FfpoQ7UwWLf8k6hbsHBWDxD2eAGCuOrL43j29tlR7f0q3U4aHPIIt3CFy3zj/CUG5MrSnopi9aL5y2fdv17VXYyDznsUWNuLrOvH9Za8sg5dA0j1KZ995IoIQ6HPhlaM7PmefRd+L9zz2rZHc416+7Y5aLxOt+864I/MTV57P5EzXm04Eno2l5DJfItXwSLysfdeU6iDjVK6zLcgPinhigLa21hXp0K3Ag1rRVSzdLatC7BCHxMAeTzVsZrEN03Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iSNKv64SIyrKiPlO8CXYyZhG76pJkcA2pMdVPSzwiLg=;
 b=aBH8n1XCIAq43UQG8w2RsXq+xpToDzvQQJoQHJ01IYWl0WPYt8WIe+iJWCrklpktYvjuNJI0bBCi7IPdV8OkTYskUqD7hg6jtD3K3qfqf8Uzz22+PwcykCcqN5+l16cmQsqIXxknwZVRW3GLsladSJj/TcAPyoDe+lLQlEed9hQHFs8AFeyYopOxvEnPgeobipuiETUZeuSj8MXOS5XWwTznieoSnzMtj7XntQouYuzKKao96UXGkxNTvPlsiKzshgXtU6Fi2754XPX7JDkuvOmPtDzNV0cta8AL6p5kiiEP5wNkAo+IjNgEvRU8ZrgeNty6p54gxs5FClaIe/g1gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iSNKv64SIyrKiPlO8CXYyZhG76pJkcA2pMdVPSzwiLg=;
 b=cvLEDlDTq7rYAL74KD2cCNCaMykk4l2KkhBOnL89L+Id3YUEn+Wz2WugorpFlICAepAs44/uPcx/L0O+l3ssCMXRrcrXWyZbPC+mhF0cViFvJHaF955TE1wOlwM1+jJuoY8vmxAKes32TrF9+nPaLAAq4fBSHCD4ZR30P8DzE4k=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by DS7PR10MB7155.namprd10.prod.outlook.com (2603:10b6:8:e0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Wed, 12 Mar
 2025 16:52:46 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::682b:c879:9f97:a34f%5]) with mapi id 15.20.8511.026; Wed, 12 Mar 2025
 16:52:46 +0000
Message-ID: <b69d11dc-220a-4279-aaac-f820f84eeb92@oracle.com>
Date: Wed, 12 Mar 2025 16:52:38 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH dwarves v2] btf_encoder: fix memory access bugs
To: Ihor Solodrai <ihor.solodrai@pm.me>, dwarves@vger.kernel.org
Cc: acme@kernel.org, eddyz87@gmail.com, andrii@kernel.org, mykolal@fb.com,
        bpf@vger.kernel.org
References: <20241216183112.206072-1-ihor.solodrai@pm.me>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <20241216183112.206072-1-ihor.solodrai@pm.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0032.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::15) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BLAPR10MB5267:EE_|DS7PR10MB7155:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e9eb50b-66a8-4c63-1ef8-08dd618650a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0RnSkxJNG42WXh5UWMwalVRUkVoMlBjWnYvR3UzT1REcFlJaFVoZkM4MkR5?=
 =?utf-8?B?ZDU3aSs2eDJNa05tUy92SVJSVW9mN28rbFdTU1M4ajFqekJuQzIxR1JqSVhK?=
 =?utf-8?B?bllmOGhvdW9EV0ZMUHBoS3NUZUwyUjBTZE1OYnNUaFVJZVRXVmZaVVJwa2NN?=
 =?utf-8?B?T0drcEtHZWJnU2FvTkpLN2FSbnB6S2RoWlR1WVJVdXBkWkFaZWRGWUk3VXJF?=
 =?utf-8?B?OU5yRzlISGNFOW52U2dENjJmT3NuMjBSd2NQN01WMC9nZVplMjVKcWg5NCtU?=
 =?utf-8?B?ODl1dklENVhXa1d1OElVM1kyZ2E2UlFKS2ViRGpUNGd1NlgvN2VFOXdQZ1g5?=
 =?utf-8?B?YVRxT2NVczRPV3llQjdGdGNtZ2lCZzFraE9Pd29FaTNIdnJCVzZOT2tEUjkv?=
 =?utf-8?B?ZHB2VjRtRndFU3lkd0p0THNzcFRDMytXTkFnc2QvL1ZSaTJTL0JxeE8yc0k4?=
 =?utf-8?B?THhWaDJOVjFpbXFLVDZtWXpGbFQ1N2FiWmYxLzUrNXZteXM2aWYwRkI1aHVP?=
 =?utf-8?B?WWNRSVlEYzEzaWF6d1JyS091UDByUzM4VHJWa1poZU55MGZmeVZKdnJhYmxO?=
 =?utf-8?B?NFE0eDBKQjlFS1RKeEVTdlR6dTl4QU11clZYaWhmYTFjbnNoZXNlOHFiRHZt?=
 =?utf-8?B?Ym5iNUc1TEUwMlZKQllscmJVb0IzLzdmZmV2VCt6YVJXWWtVM3czc3NReENE?=
 =?utf-8?B?T29mWDg3eGJ6eXlhNWlYa2pyRVV0NWNDQVhzZ0Z3YTc5SkE1YmtHaWxJSGsy?=
 =?utf-8?B?UmV6czZLcXJBRWRxc2NrK3IyUEErWlR6Rk16Q2ZKN2hxL2xqOWdsbmZ2MG5L?=
 =?utf-8?B?UVRUK1hqaFQ4ampyV0FIc043cG03ZVJWN25PT2F1OVltaFpvdnNBYW13ME9K?=
 =?utf-8?B?amJ6WVgxZjVncW5EeTNkYjZXMHYwWXo0TjBTeURHLzFobTBVcHhob2dUWkN2?=
 =?utf-8?B?ZkdJWTcxK2I0RGtKSWYrK213L1ZpeTIwVmdjeUcwVnI2dDUzdGV1cGhKeHFE?=
 =?utf-8?B?RzI1L0FXOU1yb2FlWXpKaTdRaHNraFh0Q29sQ01KNklyQUtFSWczd053Z1ZE?=
 =?utf-8?B?eWthazMrM0RoMHFQMHpCSFNhWnpPcVlSNjBOcjZaSDVldFRKK2V4bjdKYTJN?=
 =?utf-8?B?T1ozNGdnRUl6MFd1Z1lHbjZLeGp4VHN1N3VHd2FYU2JyTjFBVDYxdlE4SUN0?=
 =?utf-8?B?eU0zYzBGVDhBV1pDZUJXUnQ2VjVaVkJpRDVRR0lvZEVYbm9pS3dVWXFvT0ZB?=
 =?utf-8?B?NDI2SmpDNGpoTkN5YjBwL1lJM1RzeXBabnZwaVF4Yyt5QklHWWRtYjVlRjZT?=
 =?utf-8?B?TEVJZStNdU1qNGhzQXkyOU5xVDVtSG02bTIrdDNTTW16ZzVJMldDVFpxNTZh?=
 =?utf-8?B?T0pkYUppcVNLWnlvbjFvU3NadUd2L3VRb09qWXEybFFzS213azYxSWFZdjM0?=
 =?utf-8?B?QVhQSWszKzJkVUhPZ1AzeHVSS0FGcjh5M0F2V0F6WGNFVkRzMjN5RjdVQUNl?=
 =?utf-8?B?c2hLSXUySHA1Tmp3bjJ2VFAxQ2gyRjduN2xadUtKd0hHRnlxMGhJcVVVUzAr?=
 =?utf-8?B?VkhXc2N2ZFF4STZISGppSmFoQ083SUlPbUxzalUyVmlpQ3V1QnpMM0FMQnM5?=
 =?utf-8?B?eHhIcHpEREJadjBJSFM5MjcvRkwvWDNBQVZnV0g1MlpMMTNZUEd5R21NVDJJ?=
 =?utf-8?B?NFVMbnNhNlgycFNCb1Z0S2FqY0tZRlhMbW1lTTFJUFJTNGc2NC9KSk0xSFNs?=
 =?utf-8?B?aUJsZUxEN1VpZ3hXRHFZRW9GeHpLU1J3NjdLMzFmekFIc05kR28vcU9KbVlj?=
 =?utf-8?B?eGpRUTZweGNrY3JtdFhQaENhMGxuUjRLcC8vV3labWdORU5DY2Y2NzRQUHRr?=
 =?utf-8?B?R2VNYkU0bFh0MWMwVUxIaG16TWF5MzAySDFxRXdoQzZ3dHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Qk1yVzUyVlhvcStCdEdZVXA2MlkxQ1hMbmdJTXdtZEp6MnBPWTZuR3I5TXd4?=
 =?utf-8?B?dUEvUzFhK2N1WDExWFp2OTEzS2RPR1N5dE40N1hHNGdEUzcvbXg1YzdIV2U1?=
 =?utf-8?B?dngwMkI2dWNjdmlYS1Ftcy9IV3hGZ1dxbk9RS1NlODViVnJhbVZER0lFNDA5?=
 =?utf-8?B?N29WazNPdW14bU1iSVlXeHRzTEFGUExsdU5PSDh6TW83VEVqV3E5OUlVOG9J?=
 =?utf-8?B?c1l3R28vUEQxOTc3M0dpaEd2ajZYUFRWb28wN0w1MHVtSXlxUmpsc1RaeGdU?=
 =?utf-8?B?WEYybjJMWEZmMlJzWGE1cTlIYnZGSXZZMWNJTFA5M09kVkgwOHY5TElxdUNU?=
 =?utf-8?B?dHpWSWgvUis4ZS9uWnFaa0xHQlk0U2hYSk93NVJVNzJBM0syMXJjTUhISGE5?=
 =?utf-8?B?ai95M3NONzRmVnBvdEFMbzFaMjdhWG1GenlSOG8wa2dwcGlMMW5LeUZEb3Y3?=
 =?utf-8?B?Q0VhbnpTdDFVbEhnelFWalVVQVJhWVlWS3JnQWYzemhpYUc1ck00TFNGTWdN?=
 =?utf-8?B?VzRFSTlHWTc1QzlaYkJOTWNRKzhvbWhrcjR2bTFwU1lHK2FkYmFOMGluYTRq?=
 =?utf-8?B?L1RhRVlWejdQQk5pS3hGK1ZnSERzd2FjYzNqc2tGd1FHWUt2V0xQMkw3OFk2?=
 =?utf-8?B?NGsrekZhTm5OMVJ4bDZBYjJxTnZ4WXhQUHZsSXdMUm80SEhlQ1BpRW9YbmhW?=
 =?utf-8?B?d1RhdENtYzBKUUVLMGYzTk10TXJCNzdiSlFrclJaTThrcEpSblk1dVhIMGF3?=
 =?utf-8?B?dWM2bE5xaFF4L0ozdDVPRnhFdjhoOGpxQ2hleG1DL0NMQkNQbnp0NjlUVUc3?=
 =?utf-8?B?MEZOdmliczVreHdpRnZ6a015cFUvVEFidVY3ZkRGNUxEa1c1RWlmaDB2TG5p?=
 =?utf-8?B?Um50QVdPc0RiRlBxSTY2cGh3OUdNYlRDYnBZR2lOdmlRL1EvUlFyNGI2Rkp1?=
 =?utf-8?B?MmR5RHg0SlJIKy9yMGZFa2krYVFMUEZWZzRxOG5CeGJSSVJEeHRoeGw5QzhL?=
 =?utf-8?B?K094ZnNtaWJGd2EzYVprdHlHM2haUnF2alVXamg4QzFiTlJDOVFsdWJkNGcx?=
 =?utf-8?B?T05PRlFsa2JMejRyeEdoWE92dDRHQk9ZTDE2cmhKR0JBMk5XbGRaeVlyc1hZ?=
 =?utf-8?B?OTcxbVJ6ZzhFTk1yRjQ4Q0dhWnRvOWVrMmsrQ2xXZThrT2dOTS9pWk5ZNlBh?=
 =?utf-8?B?MWhRUy9yeldCcWFSTWJURWJhUU5uS25iUjBUS1p2RFpDNG9FUzJKWi9HbG55?=
 =?utf-8?B?OGFYdER6Q2c0SWI3ZVRmT21QYmpvNGxFMGhSUUdhVjVlTy9CdlZ6eTNSUXRZ?=
 =?utf-8?B?T1NVTStsc2dXRUg3eFNJTWhHN1g1dGFyMkNYOVdSOFVjRkVmV2RuSTN6L2pS?=
 =?utf-8?B?SW5LWFRaTkkzR0tnS01iYXQ4Z0JJVGt2aFZzS0NsQUdMaExrNGFjZWVoYndm?=
 =?utf-8?B?Wmg3S01YY0RONkVxZDNkcHljdTZVNGpsYnlkS0RZaVh0VExQUFNjQXd4ejhM?=
 =?utf-8?B?cVUySkF4ZWFkbEt3Q28wcURtQ2oxbmZ1VDhhNG1yYmwyMkQyQzM0bTVEb2kw?=
 =?utf-8?B?V3lXdkF6L2FodjRnVWxBWittMFlsd2VSencwTW05dUFab1lZQ0dNWS9KMlJB?=
 =?utf-8?B?VXVDT2ZwQThHcGJyNkt2L29WVWo2RDNuL3MvU0pkSEhmUGlQd1NFTXg0TUx2?=
 =?utf-8?B?M0puUlcwUlU5UFl2Sm5KQ0NUYWkrNkhzL2dvczFZTWZzeTNVcjBwWDI3aFZz?=
 =?utf-8?B?TWZLd0YwbXVsVVhZTThYUlFYczlIcGEvRHdYWlp0T1IzTURpV1I4L250SjRn?=
 =?utf-8?B?OVA0K0owWFFRTXdqYWtLWnlRa0w2dEdpV21xZjE5dmxGUC9La0ZxaXJ1NW5Z?=
 =?utf-8?B?OVBjeVFnSVljWlNJOEl6Ri9aU1lUeXgrL1hwMXE4NGhaN2NJc0g0TzdueEZn?=
 =?utf-8?B?WDE4OWE5M0ZyeU9ndS82c0FpYXExUEE5NlZiVVRHM1VrR3JYMDNhUzZqT3ZK?=
 =?utf-8?B?ZEtkbkR5R1B5dyttMjQzOGxzZXpvV1hIS0VQR0FibDF3NU9sYTdOOW1YZjNJ?=
 =?utf-8?B?TnF1azRFWjZnOGtoSVpQTGVEdDNQL2NzYnFoV1htZG0yU1JCSmR6ZEo4M1JK?=
 =?utf-8?B?ZFQ5RGduQUZmRnBxTDE5N3ExNFZYa0srNnBIWUV6SE01ZWV3V29ydDBTN1RC?=
 =?utf-8?B?N0E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	K2hRjxIKY7kmNNLXvylR73EFa9mOpWvjbbsLXwoJaHtfhFtpfNHP5rJNBdlnczVIIyTUb9q0UfLCR9uo4M2N8griRnf2BpM4Wzz0wiAHU7/xt8pF9BUx9ZnSs4dzGJAl+SK2iZHkfNWwYZdQNU/WPQQMO0r3Jp0wlV+9UMhVaJhy0D+9PQHSZGI0/qYdXfCmbMgdwCSe9ayBhmdP7jEnMetY1SqZcDIUx9zj8vV1Lk3oHVrbuD+rKoiXybD4yOQt7Y45bbAkUV+q52zfhTGPHKXuZoWtqFgT+pC0fvdpRWxPos8UA5QMVFbRIufQn+1mjhlVPkYYvBdWgf+InCIhwJkIi9TohNW2OWPxJysZqV/Vfiwp0GqGlMkoWYhzaCIHIOfGa5lPRPxCSZT8Qfn0K+JnxkZVqLGDfAqHPuj+5B0FozaB413yZmWQi2oiDYXrh4unQ6ghOMsD16cJmk9hHCLIc6byhsbbGXWUw3HWOk00zua+H6OSmvLcoc8RlZlFKguRQVDZ4s+suiIsyNrjFdA0vgjnKkSJp9u3Dr5qPO3icUnzkuAA3Mx5PPWn0ZrkN0bV+NTlY0tj0YNXoz66GikpxF6Yuk3d8CZ3IxQs53I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e9eb50b-66a8-4c63-1ef8-08dd618650a1
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 16:52:46.4673
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: agk17OXF1omAldMHjN+UfISKjQAT8w6LHhmj/Da3BIBIYB/S+lPdttIifwS+2LTOFVYM9wtuP/XarTXGD7Lx9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7155
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-12_06,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 bulkscore=0 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2502280000
 definitions=main-2503120115
X-Proofpoint-ORIG-GUID: nJH9D357sARGv2r_MIA6BpEtCQc_nJL_
X-Proofpoint-GUID: nJH9D357sARGv2r_MIA6BpEtCQc_nJL_

On 16/12/2024 18:31, Ihor Solodrai wrote:
> When compiled with address sanitizer, a couple of errors were reported
> on pahole BTF encoding:
>   * A memory leak of strdup(func->alias), due to unchecked
>     reassignment.
>   * A read of uninitialized memory in gobuffer__sort or bsearch in
>     case btf_funcs gobuffer is empty.
> 
> Used compiler flags:
>     -fsanitize=undefined,address
>     -fsanitize-recover=address
>     -fno-omit-frame-pointer
> 
> v1: https://lore.kernel.org/dwarves/20241213233205.633927-1-ihor.solodrai@pm.me/
> 
> Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
> Signed-off-by: Ihor Solodrai <ihor.solodrai@pm.me>

applied to the next branch of

https://git.kernel.org/pub/scm/devel/pahole/pahole.git/

thanks!

> ---
>  btf_encoder.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/btf_encoder.c b/btf_encoder.c
> index 3754884..fbc9509 100644
> --- a/btf_encoder.c
> +++ b/btf_encoder.c
> @@ -1794,7 +1794,8 @@ static int btf_encoder__collect_btf_funcs(struct btf_encoder *encoder, struct go
>  	}
>  
>  	/* Now that we've collected funcs, sort them by name */
> -	gobuffer__sort(funcs, sizeof(struct btf_func), btf_func_cmp);
> +	if (gobuffer__nr_entries(funcs) > 0)
> +		gobuffer__sort(funcs, sizeof(struct btf_func), btf_func_cmp);
>  
>  	err = 0;
>  out:
> @@ -1954,6 +1955,11 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
>  		goto out;
>  	}
>  
> +	if (gobuffer__nr_entries(&btf_funcs) == 0) {
> +		err = 0;
> +		goto out;
> +	}
> +
>  	/* First collect all kfunc set ranges.
>  	 *
>  	 * Note we choose not to sort these ranges and accept a linear
> @@ -2607,7 +2613,8 @@ int btf_encoder__encode_cu(struct btf_encoder *encoder, struct cu *cu, struct co
>  						       ", has optimized-out parameters" :
>  						       fn->proto.unexpected_reg ? ", has unexpected register use by params" :
>  						       "");
> -					func->alias = strdup(name);
> +					if (!func->alias)
> +						func->alias = strdup(name);
>  				}
>  			}
>  		} else {



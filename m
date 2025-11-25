Return-Path: <bpf+bounces-75467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B011C85920
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 15:54:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0576F351886
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 14:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75E8F3271FE;
	Tue, 25 Nov 2025 14:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="FdnUm82A"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0753271EB;
	Tue, 25 Nov 2025 14:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.153.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764082411; cv=fail; b=l2Ywh8QpvBznPNjRAH8dH+4ifcPmnOD9GeNcR6nZRdeTVvpJJ73p8BEQfUSOBa8cdODR8OP0EKP8btH3BED4xbsYEjA3IAO0tYBaAlf2FLcnHG1ZZ9EAqF7v/bs/lghRBlPRBs2aMvuo1z1RvMNMLZIqLc+QaU5jxbB1RG1dpGA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764082411; c=relaxed/simple;
	bh=puUYU6QnjkG0Rk1liJfKOj2DUhyMY+6PTYp17DYQKHU=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QU5o56+nAAXeiXIGlAcfgGcX7ENvzEZj00URwjF3Dvf7Gbek7Qn3keQt/eyVkqqJZrGKKpPmfrIsE+X4MncRBf36ErnxOtWr5J6D6SDMIyVvIMyI444NHB+kJ7+TsiTfpC6R0+jsQbUDXTBwJnfJBYT4YzaDX3z0YeIkP1FwmSg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=FdnUm82A; arc=fail smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APEhrd71751176;
	Tue, 25 Nov 2025 06:52:53 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=40btvS+zymr93hHyOQ8oF+w1Jue3XHxBuK0rPZMnjTI=; b=FdnUm82AHFhv
	L/lyeS6lW/UXlCwf9K5B3X7a2UIP25SJuGBwkDrUEXemH6Nwz4IQC/NjIKaIUWTN
	84RzCa6uJMtyi/H/BjDIkA0GU4e1ogzlCtod9997po3ZUbFVMHLt2ckeOtETNBU3
	VOwvinTcZzJeupMWB2MZgKCZKeWx8SLAVS6MXRmXfJeYcUhw98zZlY/1/XQWy4FE
	MVdNsHqXr9W/MJk6tq7+nyjHxhl4qgLWZYjKp0qkb0tJI5mgUxlmFVuOxjx9f/mM
	sCU0pv16VvY6JY6qVWuBnain5Wa2LYierYU2gUgtXQUwMVJBh3ie1ICKoD7uNSF1
	1l0mQkc37w==
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012020.outbound.protection.outlook.com [52.101.43.20])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4ana2gsvpw-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 06:52:52 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aLTtVpWbFx4WZTs9wm4CQDq/jmDExWCrIuBuBR8kYzhMLtMWH2dryDK6BWo88mGFA1e4PKZo8F2bQwthEtDFEIPjH7Gn0bmIIOtFPJ/H6ZsGhr7QR7jwhvQDtS1RweYLHkFz2dL6LBEffbMQqUrkVQ6IdrzTDK2welQWKu/WYGSfdLxDmIzw2/PG2Wp4ml+WmGsxaf8DfMkyIzM4RM8HBJ4ONVTa92S82Yb3hmnizLFYYNNbCqBU34cGvz4rYyTNidmWd0OZK3VTjehdFYVRIofn1QcYcldRYosC0joOGU/vUReZ7nJBf3Znu/qurqklyPR7J9nWWjFBulR45ZI/yQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=40btvS+zymr93hHyOQ8oF+w1Jue3XHxBuK0rPZMnjTI=;
 b=Oh9C4PHyNei5Xl3Ey88XQ5JiXL67iLVjsMErSfl4maQBf7QgjTcbX04Cq2qWCjyJQF3KI8jfyzX6sxxEe5xEhVQ3wshdBwP+cFu0gWj24xpPRnhtKot2I/21tyqefo9QdjCmM+Gy+bWsMLHkYvmDzRSkv2AaWHHmcCHblkZ78F+Kkz8DJJX2CIg7Y7bVwxaGkGOOFtfGNBHNcPiMVTlx7wsFBLL/MIXX9qFS56btGOgp6iEu7VZrRqU1ZxIJoXYLE1lV6RIXcHZ4Mx+pcECKX3vgpTZMidovH+Qg8ElYVrCtD7dxMwujXxRrXYbMVCil1w2U+KB2GS2BEx3GB/OksA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by LV3PR15MB6521.namprd15.prod.outlook.com (2603:10b6:408:27b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 14:52:47 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::8102:bfca:2805:316e%5]) with mapi id 15.20.9343.011; Tue, 25 Nov 2025
 14:52:47 +0000
Message-ID: <6bd2a44a-0e79-497b-8add-2db8bff81f28@meta.com>
Date: Tue, 25 Nov 2025 09:52:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC bpf-next 15/15] bpf: Realign skb metadata for TC progs
 using data_meta
To: Jakub Sitnicki <jakub@cloudflare.com>, bot+bpf-ci@kernel.org
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com,
        martin.lau@linux.dev, ast@kernel.org, andrii@kernel.org,
        daniel@iogearbox.net, martin.lau@kernel.org, eddyz87@gmail.com,
        yonghong.song@linux.dev, ihor.solodrai@linux.dev
References: <20251124-skb-meta-safeproof-netdevs-rx-only-v1-15-8978f5054417@cloudflare.com>
 <4d340abe294ac0290710c745f5f48bfb89b12ed3ac2be1c2df6d85848b45724f@mail.kernel.org>
 <87cy565gxw.fsf@cloudflare.com>
Content-Language: en-US
From: Chris Mason <clm@meta.com>
In-Reply-To: <87cy565gxw.fsf@cloudflare.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0112.namprd13.prod.outlook.com
 (2603:10b6:208:2b9::27) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|LV3PR15MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 0bd2e0c2-751c-4b1d-c2e9-08de2c324c41
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Rk0xSHhpc29PVWl1SDcyRUp6eC9yUDNlOXlPUW1LZXRwUnNra2pHZWxCUlRY?=
 =?utf-8?B?K1Z1NFI0SHRtWmZ3WWtKQUxja1EyeklxcUVzZHhxRTFCZlRYR2lYWlFLNUwx?=
 =?utf-8?B?dlpCVWp1bUxHRUxIOGVmS1p3QlgvR1pjV0krS1R2NVRSN3FZVGxxeDBZOWhK?=
 =?utf-8?B?YlhPeDVHNWlDWHFteFJaK0NkQzRqV3o1Y1FyODNKY21JU2RLcUx0aW44NUFE?=
 =?utf-8?B?dUdma0JoWU9oNjR2a0VtcmRFSTNIaVBJT1IvWVFwOXQrZ1JaR1MyRmZ1TTVq?=
 =?utf-8?B?aEhqZE94WE4vOGJmODFINC9tOXltTDF3WnZHMjdMVzE4R1BIL1VMRjBGb3ZZ?=
 =?utf-8?B?dWc1YTkwMnNCRzAwMW9nQXU2TjNUK3REY3U1UytTY3UvUHpOZENxejZPUXdG?=
 =?utf-8?B?RFhuaVV5NWZLcUMrN25MemVrckZCbUY1U0tUYnFGcTl3NlQvNDBzMDB1TUxC?=
 =?utf-8?B?ckdxUUxGbllCeTdXQ2IrL1FsclQzZjkzTlZFQlJRdEZIelBVRmpndXhBTTNV?=
 =?utf-8?B?UHlNUFhzQU9mMktSWUNzclVCbzBaclJUNmF1RXptN0lJbksvV0Q3NVUvYTgy?=
 =?utf-8?B?bmMyY3RqNWZvMUdKWDB2VnRIQU5BMlNoL1AwWUpPbVZDTzRnMm5rT2svdU8y?=
 =?utf-8?B?SUo4T2dNOWpLd3hwWUlnS0RSSlplRzhEcmpJd1VrMWlDUkRydXM2YVEyVzdB?=
 =?utf-8?B?Y1NqSXlKbnliMW5QUzljam0yUHZYR0RiSUkvRnZXQmZlYjdKYlYxOGVWRCtK?=
 =?utf-8?B?bDFLOEQvelplY241UDUxc1hxMzRkbGVQbzQwNjVXVkFqRk1YUnBYTHFIMUZL?=
 =?utf-8?B?RnUxLzhNWStYSlZubDhPRElqRmFZcjBiSElFSW5qY1l3WEhSWVNqLzBybzM5?=
 =?utf-8?B?OU41ZHNYTVFuZXNCODdGNTNxS2hzQk0zSnNtZWJhMUQzVXNyRktTcVBrcGg2?=
 =?utf-8?B?eFNkWXFad1VydFIyRG1MRG1Ya2k1L2Q5WE9oSElqM0l5K1FPc3hFUzJoOHpV?=
 =?utf-8?B?MFdHSXY4ajlGdVRGejJoTjNia0JyYjJhN29MSDFxSEtPaUVYUDNMSXhuZE4r?=
 =?utf-8?B?TnR5ODRrc3lHNWlWTk1UV1hmQzI1RGh3MUpLM1dBczA3TFpSWWNUeHh1OE1p?=
 =?utf-8?B?QW5zanF4eUNhZVpvT1R1YWM5SmNrZW5waUpEbmtOV25LYW9FVVR1V0pkOUJZ?=
 =?utf-8?B?Z2dCRVB0Ync2WUxMNlZjTk82R2N4NzZqMC81TmU3UVFETkJEM2hWY3VucUlB?=
 =?utf-8?B?TlA0a0c1NmFBaFBpci91RHhsTDNYNEFlZW1rbGR6d1E5NjBjSWx2b1lHUk1O?=
 =?utf-8?B?ZjhNOFg0c1hPdlM3ODkyYy9FbXhTOWIzSjBENHZNUDlzTXo4cjNsdHRCRmow?=
 =?utf-8?B?bVBTOTJtckl4YW9lV1B1S2FvWmRLRmczbDkwbW5LUmlnOFpYWVZaVHpwQWQy?=
 =?utf-8?B?VGxiRU9ubDNLY05TM1VzMU5yMzhDRTgyc1JCMWlQcEZoK3NoVEZCUzltSlBz?=
 =?utf-8?B?clVodXpCZEhpME5OQ2JVUlVtZFE5UXJNeWR2Z2pMSVRBU0NSK1JYdFg5Mzll?=
 =?utf-8?B?U3U1cnlQMWVWeVl0dXF4NVVaenFidDgvc3NzYlMzZk9CV0xsM1B1NDlwZUx1?=
 =?utf-8?B?ZkFhNU1MVWYrMU1TZzdsUWFvWGZhTE5TNnZrT3BLNmkvQlEwVFdOTlo0bnBM?=
 =?utf-8?B?clcxa1ptSWc4aVROOW9lYzR6RUM4QXpFZnB4eE9WWVhib29zYzVQVzdaamhV?=
 =?utf-8?B?bTdrbW1BOGl5YTB2S0grQTRDOEFrQ2d2SWVBNU5CYnJwWTVGb1VKRVNnRVVv?=
 =?utf-8?B?T2hnQVBrT2NvS3hJRDNjeEY0a3piRUp3RVVudjIvanE4WXE5N2RnS0xRQmhv?=
 =?utf-8?B?Z3hES0luYm5iWHUwNEJvbERTS0xJdjBDc1VHMWhyL1l6RjIxVTE5VFNzMTVJ?=
 =?utf-8?Q?Vg4s+QKetLVcJnpGy3pE6iZ1rIeVp8dG?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YWVERXdYcjN3S0FMY25Hb1VUcTBLWnFWanpLV0dPOEczN2owbXJpZ2dIM1Ay?=
 =?utf-8?B?MjZKWHRZYUk1dkFNYnYvcTNJR2c4eURaM2VpUWp1ajJrYXJyRFlmaVlrOFZm?=
 =?utf-8?B?Y21lOUpzeEhDbGxiQWlpazRVN0dKL05aVTUwUDlzTlM4RGFqRmxldmJhVFpo?=
 =?utf-8?B?NExzL053dzcwTHZHcWdxQ2dYQVQ5Ykx5MFpmRlRnMm9uRHlMdENMcytPWXBi?=
 =?utf-8?B?cUk1Q2tBYUJ6RHVkVFBGNkN3eXpyMzFiMS9yWmY4L0ZrWlFvQWtEWmoxN0c5?=
 =?utf-8?B?T3lvR3lDUnhFOGNKcHplNnlLNVVQM0FkZGluQlcrYXpJbi9lSXM0NjZtRERk?=
 =?utf-8?B?S2huSFVxZWpKZ1pMU3ArbnJjVkd6dmlOcFhrT3ZOSkRyWlFyVEFyMGpyYVRN?=
 =?utf-8?B?NDJTdFlYRWRWMkVrQjg3L1g0OEdyNWp4aGtMUFlkeEtnaTk5MUpJKzlsenRE?=
 =?utf-8?B?ajQrVnVsTS83K2ptQVozV2ZLZSsrOGhWY2VQNHM0cTRlZ05FMmRqTDh6TENq?=
 =?utf-8?B?Z0l6M0txcllNVlE0UklZNllmVGpuaStIQW05NjRFUWQrK0Q4UEJmbXFWdW5R?=
 =?utf-8?B?aWZpMk9VQTA3M2svbFZXeUI3Ymk4VWZWeHF1bGU1Sm9DbGIwMkVZa1FrcURE?=
 =?utf-8?B?N1lsa0h0Lys4QVZMM0MxZWJZaFd0SXdRMkdpN2xBU0dBcm5pcmZlanFoa0Mx?=
 =?utf-8?B?em5Ibi9rTFRZRDRBSDhNbWRYWERYcjUzRy93MFF3ZDMvUXh0dFMyVDg2Nm1i?=
 =?utf-8?B?b1VVY3JTTS9BTmE3RWlITWZSTzJOQlc1eENiOUVrMFpHbVlBanZteXJKMEQ0?=
 =?utf-8?B?S3NRT0VyUmdvUDRFd2oxc2RXWVAyRXA2SDJvTUk0OWhvNFBhbXhMSjJFZjRM?=
 =?utf-8?B?a2t3LzYxVjg1azhRYWlvZkhXVzkzWlNVbm1oTDZYcms3Ny9saFVlN0t6UjRm?=
 =?utf-8?B?TmlIS1FPMFczWTBkN2h6VEpnSFFaaldNZ1FLUXkwdTN2UGttbzFpTVZ1aHpO?=
 =?utf-8?B?MWZiRDdySUJjMHlIdkpnVENjdVBJWWs0dmhmb0pCcGc1QnV4eGZUWXJPWmJm?=
 =?utf-8?B?aXBIbFova0JYdlFReExJenFWaVcvZWxIQWdKUkMvRHVybjNrZllMNDhCN2hm?=
 =?utf-8?B?Nkl2cVJ0ZDFGdVRYODM1NUswVkJWSW8wUTdyWE5FcnRTL3hreXNvMy9iNExk?=
 =?utf-8?B?OTR3VHJaa291SjZ6WFJSdEN6ZWRFM25rdHZPRktrbCtETFZqS1hXdTZrYVZK?=
 =?utf-8?B?OFRZSWJvTmdZK0FZcVBBZ3ovWjllcmVPOG9mSXVRLzVrckRDR1JwcDg2Zi9G?=
 =?utf-8?B?WDBuSGQ4WXBzTzlaRGtvWDVJd0ZDQ2tPVkx5UStQTkQrSm94TU9rd3A4YXBN?=
 =?utf-8?B?VmJURDVpV0VLb2JZc01rSGhNdTI1QWFRMWd4L013ZTZBaXhIalVmT1p3QnVO?=
 =?utf-8?B?dzBwWU42Uy9OR0RiZ24yMjViSHZ2VzdDdSsvUjhzTisxRk1reWxXQmdQcVNL?=
 =?utf-8?B?VkRzaEE5d1V5VUlQV3RuNVhzMGpqMHhVejc1VUlURHV3aHpDeFhUZW03RlB3?=
 =?utf-8?B?NHNTQ0pEaWVRelJMRkZKK2dISkdZMFB6QXd6ZnhKYlBsaGRXM3A3ZHR4cCtM?=
 =?utf-8?B?Ung3YUhoRE41QnZsdlRQQWt5VTRORGxVallySjVJeGVublp5OFphUm11MVJl?=
 =?utf-8?B?WkFnaVVHTWVCSmNkOGhCRDFoaEszVzJ2TndISnB2SVh3SzlITDE2aXZLbDdC?=
 =?utf-8?B?SWs3WHk1ZmFtdkZGM2N2dVQ3bGF4ZDR5bXBsOFRnU0JHZ0tYUzZJUmkyWG4v?=
 =?utf-8?B?bzQyMVo4RE15R1ZwenJBQktPeFBtWXhSMVlqNDVBYnZpMUVPTzhjTUFOMVNC?=
 =?utf-8?B?a2N4b1VnWUpLY2J6bGhHVUZBUkl6R0EzdGFwTVNjQmhTTVQ3Q1Fxc255VFZF?=
 =?utf-8?B?UHdpUko5TTR6aHhrQVB3aGhlZllXRWcwZ1RReTFCM1FGRjY4SVFSeWVPcTFK?=
 =?utf-8?B?aTNIc3R1bFMzNis3Q0lSZXR5WWc0TzBOeVExSExNOTBnZDZwOHRrYkc1eUVi?=
 =?utf-8?B?MkcrUXhjTFBjOVVWZ2s0VmNJclpCL0xJUUdxN0tlN3Y4RTdHKzg1ZHJPUHkv?=
 =?utf-8?Q?vPVlh8eupcr+NPhda8oqkdXju?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bd2e0c2-751c-4b1d-c2e9-08de2c324c41
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 14:52:47.3846
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R7JYkz1gpUdGOvzciIcoflToA9lZJ8x9JxrPyzzqrbOfhmgrzQumHvL3HOX6niGQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR15MB6521
X-Authority-Analysis: v=2.4 cv=CcMFJbrl c=1 sm=1 tr=0 ts=6925c2c5 cx=c_pps
 a=NjM7+/ez9qG7m02rljsF/A==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=ZORHwhWzwpkR40MhGfwA:9
 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-GUID: IsFJTBw4fb7so_2lcHHcJVuh6ow0oWkx
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDEyNCBTYWx0ZWRfX3gp7dOq+ZzG4
 f8hlSmj2AqRlstAANCQshzbL7XDzIy0vwAV41HzxvuyQqY/oMNp2pYX0CGwZCotPKpZYXJX1PsP
 OGDBPEIlw+BrSGEUdLOSiC7K96E4TecZR6CAFII36mR6WaNedyXmxpc+eftvuoFkGrK2SMrTcwe
 9M4FMr/8CIrElDhotmqm9/wdH10JTr3IPLHA8H/6Jbtrsvlpi8mglJyjQ9EU+wpTvhB/UNa+Dnv
 CpNUmh53L+G62CH2fl7xZ8RvSW2NvqFw497XDmqQPRjiWp3CNONQAMTIYZicpChYwzIYjkVR6O6
 +vKiOgaXNDdNnW8/XNxO1iQuMVaBtkEJxBNI78MAsKOL1dggi5WwwvP3KcAVeLKyXtZoTv0vlBL
 0jRFxdu2tAqoTZfEbuj4SGLERnZS8Q==
X-Proofpoint-ORIG-GUID: IsFJTBw4fb7so_2lcHHcJVuh6ow0oWkx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01



On 11/25/25 9:23 AM, Jakub Sitnicki wrote:
> On Mon, Nov 24, 2025 at 04:58 PM GMT, bot+bpf-ci@kernel.org wrote:
>> This appears to fix the bug introduced by commit 016079023cef ("net:
>> Track skb metadata end separately from MAC offset"). Should this include
>> a Fixes: tag?
>>
>> The earlier commit message explicitly noted: "Note that this breaks BPF
>> skb metadata access through skb->data_meta when there is a gap between
>> meta_end and skb->data. Following BPF verifier changes address this."
>>
>> This commit is one of those follow-up changes that addresses the
>> breakage.
> 
> False-positive feedback, naturally. Both breaking change and the fix
> belong to the same patch series, so Fixes tagging rules don't apply.

Thanks, I disabled the Fixes: tag checks until I can beef them up a bit.
 Sounds like I need to get the patch series aware reviews working first.

-chris


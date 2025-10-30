Return-Path: <bpf+bounces-73051-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D34FC21475
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 17:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03B59188CEC7
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 16:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43ADF2C3277;
	Thu, 30 Oct 2025 16:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b="r7JYoDpB"
X-Original-To: bpf@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011053.outbound.protection.outlook.com [52.101.65.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDE0E1D618C;
	Thu, 30 Oct 2025 16:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761842845; cv=fail; b=q86UcqVjn8rY4xYqH1AC6pmFGWIPBjskdYGB3/EspS4UWpxMsCaxMXGeI/ZtUhB85R13a6OKWKG9wKfVNWqptwj38rVX4EovIOG3aVIZO97XeiZI3WqbNSCKmeIHs0c378KTCtZQD8GUVi+4sWGufoyhT+E34ok8/06QEekPLrk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761842845; c=relaxed/simple;
	bh=xrKO9SJSS6ywtE60xX+5hG8W4tktzszhu7p+qeu69iE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gkM2KhTbvvrbcE5yB0nFEp3vKRBpzkawXW7PrrtSV9CjMALcXI1CHkAr3FNFyT88/uIT/e+opHUza7CG47b0r8zNxDxhh3hlbJPmoqnUV1NFo9jYTLAAqTibTXujt010eUUPVp1zAz+dfKTp7AgERvpPMsSI2GXhbSnGOKSSCjY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=@siemens.com header.b=r7JYoDpB; arc=fail smtp.client-ip=52.101.65.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=siemens.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jmxir2vPwyNBQmoN+VuS0vU/g9j6PEYFN6AIqrK7Wf+hHDQYg1N+Rq1/iTlktjl8rhjLbn1Ex8AT6PkxpTa6qdu7DGwSzONxWiP82jyJHlfUK98G1z2QoDYP70QynoWBsCjCHXhHFZc/TNuQCfltSmD9xIzjGVoLSzkS/ZZb3TlP39MIcHawKi6iWKS+u5F5bcdtqt715qqWPu0hCyUeK6OF2csUQoRIfbLWOqCArPVhsbqGcx+4dDFYTblDO/mcUhhooI5m6idLXnyXJzisKa8gRf0te6K/fo+40EhrO1xdYHeem/LNDpuCPA0VbzB1Px9z3c8kig3DA19m5kahwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RUwPLz+c5QoCXNo50BsConM3laevK2g9EFaT+qaRk0o=;
 b=bCVh/hXXNYN1dLubpzzhglmJYVIo8pLp5608Yop2gqPwONs30/e0GXm0oXIRF05SIz9gle1hLNc0nwXfW9UtsYks+rGh2cy6yj7psgaOsixP/wKwThwcMYNJMGPb0O+wR3O0gb84Gu/uE011vhhQ92xazsBOpiK/yIp0LPHI93ufUFZy39IOHr8EMYIJqM4ahUGhK4p2cAzOCh5iXlchp4KZf5bRT2dVYpQlcI/lW97AY7l4pEqQXZAMtvTBaXeat3kcl6NdbWJBbqQd3dwfHC6S+jWDzNcT15KJXCtw+SqHc9Tro6XxHHccP9ZB/lhHRFhbnBq60F/az7nAdyGqeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RUwPLz+c5QoCXNo50BsConM3laevK2g9EFaT+qaRk0o=;
 b=r7JYoDpB3cSswQBAT6cs+XpxdAYN09zb41cfcePPP4XqXHe2YcluzPmDiY6y6reHc+FdIpbBmEUni188OGJsaYz7fAMWQKLy52zGICfiI72/6/mrnWRlUFnYk6+cm9ctC3L4mG3azvQL7iJdEfPOjwRCxiKUIFHRhe5m+mCwJIWTEq4+mo7jaGQoSA1mxUPni7KDHdCujV8LPE4YDQ9SUauk5pKq3T6RnF8c4BuFVUQEyFTZcWJeLnQSCuvgC8twi+vyrC1CBsdU5I4yKQ89uKPdRheuzIpKZXt+2HqI8L4qwMhJPHFT80QrfXIh8wG+ysL0PX3RahOybZ1U77mQsQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by DBAPR10MB4011.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 16:47:21 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::8fe1:7e71:cf4a:7408%6]) with mapi id 15.20.9275.013; Thu, 30 Oct 2025
 16:47:21 +0000
Message-ID: <1eec0bc4-dc4a-4fe1-affa-3b8620dfc79d@siemens.com>
Date: Thu, 30 Oct 2025 17:47:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] scripts/gdb/symbols: make BPF debug info available to
 GDB
To: Ilya Leoshkevich <iii@linux.ibm.com>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Kieran Bingham <kbingham@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20250710115920.47740-1-iii@linux.ibm.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
Content-Language: en-US
Autocrypt: addr=jan.kiszka@siemens.com; keydata=
 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
In-Reply-To: <20250710115920.47740-1-iii@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0105.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::20) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|DBAPR10MB4011:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a060d07-458a-482b-a78d-08de17d3fe76
X-MS-Exchange-AtpMessageProperties: SA
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tks3bFcyNTJpbFk4N2xtSWZjQW5sV3lHOG56ZGE0NXd0UjArYUJHTm5SbG5V?=
 =?utf-8?B?cWdJUjdYcDBTSG5GUldTNlVnRGV0WlFOOGtWQXlDZnBhTWxrS3lTdWkrMlVo?=
 =?utf-8?B?NEFoQkRZWkd4MHJzNXNuWEFLU25zM05nRnNYWk1FQVp0YTNnSGdRTGpLZ3Zz?=
 =?utf-8?B?QWZ6Wkh4TXR1emJ0Ly95cit6WUs3VjhqZlo0L1M0NDdValBQcDNtRUI0aG1Z?=
 =?utf-8?B?czVuZUx4RVdmTDhmRGJ4VnpJSmVyQWkxZThLTnJsdnhtdkpJVVNKUTVIOTF2?=
 =?utf-8?B?K215U2R0NDMrbFphdDlUZ3UvWld0ZGRFQ05kakNZY2tzcURHemRuTnd1cUp5?=
 =?utf-8?B?a1VSZW15UXFvd2oxZDBFN2lpYlFrU3poVmx0Y0RJa3BQb25Qb3dUeTdVTUdD?=
 =?utf-8?B?amt1amR1anhRT1QwWlpPUithMEk1ZXJLWjZJQ04vWWNmSXRXdk54Y1N5RGlz?=
 =?utf-8?B?YWYxM2huUTdsNEJRdHk3N0pncWpBY0kyV0F6TFpIQ054NENuZmxSUG9oYVdK?=
 =?utf-8?B?c2tBTkRYOFlwVGdudEhIWE1nOXFsaWdlSlVKK2hDOVBHdG9OT3YzUTRxME1U?=
 =?utf-8?B?YXBQcGppSG9pYnJvWThlZ0FIcWtvZUY0WndRc2pHZUs4REloYWF4MmhsQ0Mz?=
 =?utf-8?B?czZsU0JCbVhnRTN0RFNQbWVlVUt3L1h5eFBEM0lTOUh2T2gxc2FYMFZISHZi?=
 =?utf-8?B?Ukw1am9iT3c3YjBFVGxCT2FGY2d0dGtiUkJjS0tmd3JnL2phVjlSMDJnTnA3?=
 =?utf-8?B?QUFuSFllTEFsdDlrTEdEdEhValpPS1ZRRDVGN1JmTkNpdyt6bE83MUtxSThD?=
 =?utf-8?B?UDNWVXpzTktJcGNRZ0Zma1BNV1BRUVc0TVZMTThYSUtPcjdheXpjZGJmZm1m?=
 =?utf-8?B?bDFaYTlIZlp6NkI2ei9JN0c5NjFiTnNBU0JhOHMycVpOTHVCYjdoNjJPTUwv?=
 =?utf-8?B?T2FHZlNFMFZubER6b0lSSDZxcXNYMzVLS2RONTZVS2dWNXVNRUN2cllpdUVw?=
 =?utf-8?B?R2ZIbzRrZ0cvWVBQZGdYTHBOT0NhR01NRDgxVnIvaWRQMnV3amVZSGU2Vm1C?=
 =?utf-8?B?aFNuemJwU01mSXVxaVZGK0QxeTJ2U2VlVldhaEYzaUtUNjhQVnZNTjhKcHFt?=
 =?utf-8?B?clNRWUpTWjRRRDN2OGE4VnF6ZGFBSERtc0Naa3pRUURSa05jQzkrY2ZrK2Iv?=
 =?utf-8?B?SVNHZTJwdzRCRXZzQXZBSDFOYW9FN3B4Tzd0eXVFdlArS1l6S2pYKzRTTzJZ?=
 =?utf-8?B?OXBKeUNOOC9ocndLdlpzeGRYZmNWSnBpSitPYTdsNDRrejBJbDdpZmdpem16?=
 =?utf-8?B?U2F6RFd6Vy81NllYeStqbW5sM1J0Nk0zTEIvTEYxVjBsUDMyT2RRbmY1WUo3?=
 =?utf-8?B?ZHRyaTRVTFp6QW45cWJIaHBwTFJwcDR4QkE5R2FURWhQN1NzdEQ2SWxwZHVv?=
 =?utf-8?B?TTJ2czlsa3c0ZmpXVjlETXpjMlV4SVlLeWpya2c5L3RkYXF4UEJtc1RvWmxQ?=
 =?utf-8?B?QXZxdkxzMjIxMlJmZThEV0ZRc0N0bVV1UEI5SVQxa1VUdVNtM1pZOGExM29X?=
 =?utf-8?B?ZE92MTYvQVFtajVGcnhPN05FbWJldURFL2NNekJmNUVYRlRYS2tHUEpxTEsz?=
 =?utf-8?B?YWJ0bjFueEtOb2hTdElLZHNXeDZKV2xnVTBpM1VwSzRwaklWa0ZUMXBjQytJ?=
 =?utf-8?B?bW5kV094Yzh3KzUvY1ptSG1EUS92R0Y5aHRxU2svK05XNlFMSUdwRm1iMkNx?=
 =?utf-8?B?YnJTOEQ3V2tyWi96SVg0VEkzc1h3czVWd1gxRUpabjN0T0ZnNXRRc3pIdDg3?=
 =?utf-8?B?NzNnUUxvTlQyc0lmckxCTzZOcktVcWpCNEE4bWx1K3hTZDZHbFJwZHY0SzNO?=
 =?utf-8?B?TmoxanJFSnVlbUIyM3h1S0F0dGQzUUloTTI4RnBtdGZHSmZZNWsrc1VYSTR4?=
 =?utf-8?Q?NgtSCsYhZDnOj4HeGoJMub0p/CZAlLSL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEVqNlVoVlIvdkNqVDNRWEdKdUdBeEc0Ly9DV1ZEUHR0dVFNMjJjd2xyTElY?=
 =?utf-8?B?c2ZxZHZQZUw4eU5nODdFMzB0ZEJsK0ZBbUdQTzllZE5kSWZpM2I3RW1nZEFt?=
 =?utf-8?B?MUs3OFBJcm1HMTl1aUpIWVlqNHpYaktLVWxjRUtOUHo4bFNOeG5RS3N5QnRJ?=
 =?utf-8?B?bGZxNHdiTXFMb2hJR0s5UUVhVFFiU3FLbWpEa1lLMzlTQkRsbDcra25YTExa?=
 =?utf-8?B?a0ZOSDFnN0FLbHlGcWo5SU85MlhrYStHejYwc1UwK0R2NU5mWTJFZ21aYlY5?=
 =?utf-8?B?WkV1QS9xVnpQWmpNNDZCS0pET3pCa2lsUHo1M0lFRExoQmZvTndsc3dxNDho?=
 =?utf-8?B?bzZ2NUtjYS93bVljSnRoT0MzeTZBekF2WTFueWlnZHNZNXd5NkRoWDVVeS9N?=
 =?utf-8?B?c09lam9vVkdDeFd5TVJrVW1OSXc1MUdMdUN0YTVFNS9rRndNanFpeVhPSUkz?=
 =?utf-8?B?UkJIclM3aVBRM3N0aStRbnNSTVNmWkw1RUtBZTNPS2JGZGZVNFZvbEMxeWVH?=
 =?utf-8?B?NWNSY0M3Y1BBVmZqY2VobmJydmVIV1dyNTZMNW9vSWhzNzFYQ0RGT1Jqbmx0?=
 =?utf-8?B?ZlhkSDJGV1JGYkVGaGd6R3A2bzNmK2FONlVQSW12bXdOQ3RaNHoyL0dTZGM0?=
 =?utf-8?B?SG5mU3ZURFFMOHZoOUdydWQ0TTdRT244elJiSTlaZ2cvYmV6bjJKdXJBVDVk?=
 =?utf-8?B?bldPTE9pNDRGWmNSdEl6Z2FXeDNyT0NZbmFYYjg0TkltQ2cxVVl2ZkpUbElx?=
 =?utf-8?B?SXFFaUFyY0RDaGlmeU03RXM0aEtOZEpZdTJ1bEJOWUhmOXR5UUxWWlc1aEp4?=
 =?utf-8?B?c2JLWXJDbmdjeTRFV0VEei83a2JGMFJOOWpkeVUvanNHUHdSbm5ObzlVSElB?=
 =?utf-8?B?ZTJsc3g3T25UanhVeEt6UEw3N3lXZnNNOG82dWQ2czBzaEc2MVVtSGdSL3Ft?=
 =?utf-8?B?R0ZSZk4xSFFiTUlrMDJFdlpjVlh5djBHWkR2S3NRSSs0TmpLb1h4cUpQdFhq?=
 =?utf-8?B?YlIwbGNNL29td3NuNUpKckNPRUgyMlMxdy9udkdWYmdhOUh3NGxYVjJVcUVN?=
 =?utf-8?B?SnRBWE1KRnJ1OW1PWWNGbVFwM1dhWkdKSFpNcm8yZE81b1JNQnVBcTFzSGk4?=
 =?utf-8?B?U3hFQ0ZRem1zK1l1Y0pZNzFIZ09VZkVvbkNIK0d3TnJGc1lqWlVRVFFVSWJ0?=
 =?utf-8?B?VCtiUGhjSHVZdWxUT21jK3UrbkNoOHRPSWFZR0ZlT0d2RUIxb3ZpKzdEdFN6?=
 =?utf-8?B?bkdESzF6aS9oZE9xSThPWVc2dXVEUDRidzVadjZXNUNZYjVmN3Qra1NGVmpq?=
 =?utf-8?B?U2JhK2dET3M5TlZ1Z2tRUXFTQURLa1FwWjRPcExraWFWdzNoQkU1ZHh1cnlj?=
 =?utf-8?B?R1lxN2RxSkVSZ2E5c1dNb2tuWGIvN05LYk5XZW1aSEcyME5FQ2FDbjhxaVRG?=
 =?utf-8?B?VXE5QWVIRloxek82M0Q1NU5IdEtieTA2NVVJK1VaWndSOE1qNE1zL0FranBE?=
 =?utf-8?B?eHFTa3RnZ0czRXlZNkU2d3FiOTBQbW9oejk5Ymk0dnZ3Y2s5am5xUkh4a05Q?=
 =?utf-8?B?QWhBRFhXSmp5SDhKRGplZ092dGs3VHFXS3RzUCtoVHJESFNOWkNtUjZTM05m?=
 =?utf-8?B?RWhYc2VqRElCUUkyeHUwVEFmQmFnOHBRWDRtVXlyd3d6ZEFmUnorTjUxTzc3?=
 =?utf-8?B?NGhoOGQzK2ZGRFFyZWFmZGMwUzJqMEhkemVCdmkrTmttQStlbFI3LzladTE5?=
 =?utf-8?B?OXdyd3ZhTnpRUGk0YUFaTWlaSE5nc1hEL0FGalpvNjhGUkl1SWNXcWhGWC90?=
 =?utf-8?B?bWlUeThPZkE4empWYnp2MVZXSXNXdCszY25seEh6UUNrcnJMTjhLUjJNZWJK?=
 =?utf-8?B?bEJ5VGV6aG1QRE1sSXIyTXovdVJsWXhKdTc5RkVvWWFPUWRwMjhtOHBiV0lK?=
 =?utf-8?B?Nk50ZkN4bmhmK2NnREpxNUw5RjErSzgwSDRVMWxhTEp4ZkNKWUVBZGZnbHVH?=
 =?utf-8?B?Tjh6N1dNYnh1NkFjaDFMbDhjOXVVZXJDc2RTcFlMRTdoQVg2aDJYa1dCYTdS?=
 =?utf-8?B?SFY5YmdsT1JnRGJ6Rk5oTGF4Ym5Cc1RXYTJBR3N6eW9qbVVIZ2ppaXBFMmNt?=
 =?utf-8?B?a25SZittYjVOdTEwUExWMHljc1JJL2NhbEIzNEVNNVI0RnBHbkozeFp2bll2?=
 =?utf-8?B?WWc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a060d07-458a-482b-a78d-08de17d3fe76
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:47:20.9613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAE703qwjmSkF3xLFWhFDCxflEii/N5aIvChLa2Bhp3bP0wt4vUNn3W/YpLMMCUnzHaYE7ZKoFLG1y2E9Eif+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR10MB4011

On 10.07.25 13:53, Ilya Leoshkevich wrote:
> Hi,
> 
> This series greatly simplifies debugging BPF progs when using QEMU
> gdbstub by providing symbol names, sizes, and line numbers to GDB.
> 
> Patch 1 adds radix tree iteration, which is necessary for parsing
> prog_idr. Patch 2 is the actual implementation; its description
> contains some details on how to use this.
> 
> Best regards,
> Ilya
> 
> Ilya Leoshkevich (2):
>   scripts/gdb/radix-tree: add lx-radix-tree-command
>   scripts/gdb/symbols: make BPF debug info available to GDB
> 
>  scripts/gdb/linux/bpf.py          | 253 ++++++++++++++++++++++++++++++
>  scripts/gdb/linux/constants.py.in |   3 +
>  scripts/gdb/linux/radixtree.py    | 139 +++++++++++++++-
>  scripts/gdb/linux/symbols.py      |  77 ++++++++-
>  4 files changed, 462 insertions(+), 10 deletions(-)
>  create mode 100644 scripts/gdb/linux/bpf.py
> 

This wasn't picked up yet, right? Sorry for the late reply, my part of
the "maintenance" here is best effort based.

Looks good to me regarding integration. I haven't tried it out, I'm just
wondering if it has notable performance impact on starting gdb or
interacting or when that could be the case. BPF programs are not
uncommon in common setups today. But if you don't want to debug them,
does this add unneeded overhead?

Otherwise, I think it could move forward if it still applies (which it
likely does).

Jan

-- 
Siemens AG, Foundational Technologies
Linux Expert Center


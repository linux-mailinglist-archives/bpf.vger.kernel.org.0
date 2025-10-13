Return-Path: <bpf+bounces-70798-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2EDBD1D83
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 09:40:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C19DD4ECCA0
	for <lists+bpf@lfdr.de>; Mon, 13 Oct 2025 07:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC2802E9721;
	Mon, 13 Oct 2025 07:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pZ6qhtG+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0F7D0aU5"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7723E2E8DFE
	for <bpf@vger.kernel.org>; Mon, 13 Oct 2025 07:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760341217; cv=fail; b=dO5zqWMGEhYQ6ySdxpjKk75zifFP3OLx37xRxCpeDAV9UHnNGBnmsEkTXK56J/dIXEj3Ou8vCzvWELpnnifppgnI47DBANDcSOwJ3Ge+RBG5Dc5XRpsB94RtvgPgil0TbzL8wfu8DVCNqnFIvVdhRfoE1ebdxfqhtAzhV5c9Z7g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760341217; c=relaxed/simple;
	bh=xiHWX0vXQNTeOhKZHYjVstfKBethH9WPKm03WjzUfBM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rGX15KvO1XO9kzpIClXzWCSigsyZB8wA6XbXVgvYk0U6rR+vSUCt/V/CUk6kxk9p4+VNW9AfJjFYdXNl+M1MB9S+FywmriRPqbEEvTjRxOGNj/QJi6/2Ifk2/BN3GziDLrbvqSC5MShr7+XK7riIikWgKqsLut8j2xtA3KoRK2o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pZ6qhtG+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0F7D0aU5; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59CNNIvW011209;
	Mon, 13 Oct 2025 07:38:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=lyD5DxwdO8bu8leD8HEbkt6ODYAD2H/dcnzJCIdpOBg=; b=
	pZ6qhtG+nlsG9w3sXvzQCPudnXNnviyFoEzih+THfsKUP3R87NTeO7S5ADrGlyUo
	knTUUhZD30fabtjxyscbWrAZDMk9HlKDaVKMLZ6A/AL2SEJHTLvCGWz3HJAHG9Nq
	C5UZN6QufHjhzSJW8u7PmqCGUzALffsL9aPq9ZjS9/u/xuebuW0g8OebbSF6b7XX
	hoDIIDDW/JBo3FmYjXdGlnm0ABspo5YHxBU/qNcqSsQ0eGZyT8Bgv7SBh9IMIE+7
	oefc2a12sp6Ih78wIU3waKI/hCuRIfavk638LrerZfc/jInwML6CB0hMflEi5055
	/MNdX6QtT3V5ZiBxhqIkBQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qf9bsnv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 07:38:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59D6GW6M037914;
	Mon, 13 Oct 2025 07:38:11 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012008.outbound.protection.outlook.com [40.107.209.8])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpd7c5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 07:38:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xIpFC1F8cQxwbnbQNaHCeH9q2C6rzzRzWX4s+8v1gDLfmjmkEjItBPB/TX3ViG1kqHUiT+qfL2YHdbEPOvAbOmcJLjyTqOdGTYtjE6YorIczbjd7Y23PM9JunywpxH5izHE1LQS5zrV+zmDZM6E63iZEMPmvOUp+9DfNj+P5Hdgv5IVgNUaP21xUECsbSKtqfNdWl3rH4TSldQWJ812qNLDnmb0TUYMNbmAGUqFcVYwRf0908CqIadZpQgxMm1h1Lrsj6qZoczAUJJZdLHFMa6k+bWO8D2vbFN1qORUVibt1Lb27xcPD7fv2onSc6oZcD0Yt+x44VGX7fC8hww0AZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lyD5DxwdO8bu8leD8HEbkt6ODYAD2H/dcnzJCIdpOBg=;
 b=MbVlNyq/S5eENM18qZ5JkS8KHUWgicoCMiv0TpHLnU1643Qk8hI5d+76sRKoR5/YrAk5wqejBWOe8Id0852a35AYN7nja7/MO4spFQVwRsV04fOSpIAY97eRsWtHEUOYGjJPf0bIm0FWnwRDzXM+xNV7uLzrq7/yu51bWkpde4DUx+WqEmbFOIlRv47vndhMvSX11PCNLZ2FT/LZX80y0lmxhWrqbvT15xhqlD4rZCDiDycnMJZ6u//5qqD3lTRDv6nZklwjPVOdE6EAqax89njH89luhhTopMfj9CubJEHxlGq6YAaoV9WxJrEa/lvBzxOFiNFj2sP42CH0iABLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lyD5DxwdO8bu8leD8HEbkt6ODYAD2H/dcnzJCIdpOBg=;
 b=0F7D0aU5vLewiQYgxWdXXT4E7s8sQMtYkjUILnYBRH3UC4di2336GrUfDmmNkMUrh1byxp3IiLCRQ2sj3IBP+5bCULXb2ig0E/wEfbD3pgFm271IF/Ovx7+m6Wv6Rw7Zx4V9vLiPnrTwEYQGgSFggKbR57L6+9QxBMwHoFi9EvA=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 SA2PR10MB4459.namprd10.prod.outlook.com (2603:10b6:806:11f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.13; Mon, 13 Oct
 2025 07:38:08 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 07:38:08 +0000
Message-ID: <b4cd1254-59b4-4bac-9742-49968109c8af@oracle.com>
Date: Mon, 13 Oct 2025 08:38:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 00/15] support inline tracing with BTF
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Thierry Treyer
 <ttreyer@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>, Song Liu <song@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Quentin Monnet <qmo@kernel.org>,
        Ihor Solodrai <ihor.solodrai@linux.dev>,
        David Faust <david.faust@oracle.com>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>,
        bpf <bpf@vger.kernel.org>
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAADnVQLN3jQLfkjs-AG2GqsG5Ffw_nefYczvSVmiZZm5X9sd=A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0349.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f4::9) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|SA2PR10MB4459:EE_
X-MS-Office365-Filtering-Correlation-Id: 16ba766f-f79f-4558-7a16-08de0a2b740b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WjNTdXpPakQ0VFZTdzd5TlNxWXkxQ0FzYkxGL1FUWFdNZE00MzFQWUtpa29S?=
 =?utf-8?B?bEJWRVgyb1ZER2ZEQUpUbzFzU1hxZmVjZTBCSWZ3S2NteldEZXpnSEM4RUJG?=
 =?utf-8?B?QnE4UEo2Q296TVdxazBtYnBmVlU5aTJTSmJubkYvaENwUTV1dDBKTmIxdzE2?=
 =?utf-8?B?b2hyeUFscUVKOWIzc1hna0FNR2RsaUdBV3dyM1RHc2QvMWlpODlZSlFYREpN?=
 =?utf-8?B?NXJvaFJLMU5wNHBwMEZObzdKT2paQWxSS0JwY1RKcDZ2Q2JSc1ZkRENZSklQ?=
 =?utf-8?B?TGsxT1pQbFgyM29nSjYycXlreGN1VGZ4dTNSNEpWaVpBd3dnMTlrMUZQTUZx?=
 =?utf-8?B?ZVRENmJpRVZSbEx0UDZwNHNUVjRXdDVQa0NVMU5BTWtQcmhGWnAxbjZLK2Mx?=
 =?utf-8?B?Z291TytIdGZSdis0UXN0RmhzWmV3dCt1ejgzcWw1NldVNGFGR1VlVDhhWWRZ?=
 =?utf-8?B?bnRUNkRVWENHaUZlbnhVakh5cjF1NHJhZ1AwdHhXeEVDTVhQT1RtbTJUZ0xT?=
 =?utf-8?B?U3FvWDJSN3RWQ245Q3htVmR5QmVUT21BUnJSeHZwUlpkd3F2V1lBZTRpM2x2?=
 =?utf-8?B?eHpubmxtUEllZmo3NDhsaFhERzlvMUxiVWZMcENiTkxTSVRUMHh2ZmZCVURU?=
 =?utf-8?B?OUwvMXFEaEVKMVRYS1NURmFOVDNoT0NrTDd1WFRFbXRqYVRUZ2xBMUpzdk4z?=
 =?utf-8?B?WllieUlFUVNHV3hYcHl2WTFEQ2pJcVdOWHJHQ0M5T3JCclU2YkVsSXBqcGJa?=
 =?utf-8?B?RUlaV3N1NGZnM1NFRSt0S0VJSFBlWU43VngwekovU1BHZjFTVG56ODZwZC9l?=
 =?utf-8?B?Y3FzOGdGY3NPa3NxbFZTZ2JqMG5jWTZXU016cnhmNm80Nm9vWXdxVmV6OW94?=
 =?utf-8?B?c3BqbjhoSTFQTFRHY0FqaDRPdm8yT2dGRnNlVk1FYmxKYUJ1RzFsd2ZuQW5h?=
 =?utf-8?B?dlRoNERPUjdhMEY2K2pQZkY4UmZXNVJyREJmTEpZV25zTmY4UGNpQ3RTNFNB?=
 =?utf-8?B?VmdhYzhMeWI0NERvM24xSUdBVkNCVDcvMmRsTDVMZElzS1RLNTNNTk9oK0s3?=
 =?utf-8?B?dy9OZlp4ZkJLM3B6WEl6TldnaUJQSU01ajVDcnN1K3p4LytrelFNclBJRy84?=
 =?utf-8?B?bjhlcGlHT0NGV0ZhclFZQmtob09SVGhnd1ZmMFcwOVFFMjlKVDRzMzRiejRo?=
 =?utf-8?B?N2RINmJVbFY3QUJOcmlZOTg1b0J6VVdNMnQ1Q0xNbk41UFVIcEdGKytzamVj?=
 =?utf-8?B?R3BYd2tKRldJOGl3NzgwdE5iS0lFdGk2Rnl3dXc4N1R6QWZPOVBDdWRxWkFt?=
 =?utf-8?B?bDVHSldabGd4UkFSdE1Ob1FGSlBmdm9BWjR5TTVqM1p3SFZCWGhVbkoxUXow?=
 =?utf-8?B?aE9wYXZPNnh6amRIWEQ1S1dNemd5clgxUGY4Q29aN04yRjlWOE5yNzVwKy9r?=
 =?utf-8?B?bnhGUWc1UjlkdUY1YklMSXF5TzJLbys2TFJHZXQ3ZzE1Y2dSSXB0UU1wZWIw?=
 =?utf-8?B?QmZXWUpYUjRnLzc3ZTY1dGs5b2IwaUdDakVNUGhCcWpJdEpvems2SjJYaXVt?=
 =?utf-8?B?aVBHTmtmSUtaT01WSTVuR2FMc0E2Q1IxOHBHNGJMZGJFbWZCckJscjh1ekNu?=
 =?utf-8?B?Nko4REJXbXJkcUE5YzF1TnpZWUxvczNFQUV0UUs1TER5WU5Pa3M5MzM5THRx?=
 =?utf-8?B?YVdUdmtHaUdPU1hhZ1NUeU9VT29tOE1CT0NGL0JsWlk5dWpxM28vREdQbVI0?=
 =?utf-8?B?eWJVd2xNU1Q4UVBPUmc3NWF0bVBwRy9hZzRoMktzTUx2MDgrckQ5TStHVjVr?=
 =?utf-8?B?Qm5vTEhzVzhaamhiL1NXVzRvZ2wzb3I0NUx0R0hBL3dKRjVSTDhlQU90dXhG?=
 =?utf-8?B?OVB2SHk0aHdTd2NRRTQwMkZMcU9qVEpoNFJ0VjAwR3ptL1E9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aGhzaWhNWU56MGcxaExsN01aYmMrL1BOcVlqa25hSWVaZm9sK2VYOXdJUmtB?=
 =?utf-8?B?NUdPQW1BaGJ1N3liYzhnSWk3enB1RXIyYkJySUNSU0Q3OEhVbUdqZjh2bDlI?=
 =?utf-8?B?TVJUdjlmcXJwMUJ6WUxWQ3E0eDlrSTJnM0dUVGJBdjNQNDJWaVBKcDdvblJG?=
 =?utf-8?B?aDM3RFhub3BSZVRTVEcwejFlQXlTZ3djeWtCUk8yQlFhcDZ2L3lBS1lHL1Zz?=
 =?utf-8?B?ZmtXQi91emFhd01GVmFEUE16MVJRWFVXSWEvM0t2UXNjejdmUXBld2tHam9D?=
 =?utf-8?B?WWlLVnFXb0VmUlZrYWRCaXd6dXBLaitVQ2UwY0loVWYzNElZRHBJWEJRczBn?=
 =?utf-8?B?SXJYNWlXV0RFWlUxRSt5V1B0NzFBajZHTEJZNGhScFhVTUV2Ty9SOFRUa0Zj?=
 =?utf-8?B?U1daS2hSZmdMbk1zZUsrQ0p6R09VV1RQbER1WVR4NGNFRDN5NVlUSmdaRjdE?=
 =?utf-8?B?V0NBV0VGUWdPdWlkdnJnZjdIeG90SlI1aFhMelpHZnRjMUUzc2FsV1kyTEZJ?=
 =?utf-8?B?MkVRNXBtbkpSNERCRnRtdFFsUE1CZ1FpRmFrcHpZQ0l5RmtBRkxnZmFKa0w1?=
 =?utf-8?B?RlNoMFZKZjl0S2syN29PVUEzanVoSnU5Sk1FZGpIaUhDTEJXL2pjSzNMcFBK?=
 =?utf-8?B?NE9tWEMrdC9mMU5qbVp1aEpDeGYyd0lQYVFDQkdCdmU2Z0dZenp1WmpWQUk4?=
 =?utf-8?B?UTJSVGRObm4rYXNzQnpaOXEyd3RTTlI3NFNYbVA1Zk83cVg1RWM1Y0pmTGtE?=
 =?utf-8?B?ZEN1Yks1UzFQdWsxODFkbGxVQy9KRThXb3paUFR3ZXFwSGM4a0dtV2VUcWxu?=
 =?utf-8?B?TG5xWDV5ck1PT1RESXlhZUlHS0Q0SXl3REU3NmFDMXRaR21WWnZXTlFvWmNG?=
 =?utf-8?B?aDRQSHE1ZDcxYUxWNHpFbnZSOHM5QjdkcEtFckhKZWNZK01YVWpGWVlDWFVn?=
 =?utf-8?B?RDVsMFM5UDJVS3YyeUlzK3lUbTYxVmpRQ2dHR1ZYQjBmN0RMOXZ6RmdKQlQz?=
 =?utf-8?B?NXAwLys5cFc3cURiWVlqNUpldldLWndjOFVDelVDQ3lRTXlFYVhDYVkyVGky?=
 =?utf-8?B?UmZOSWt1LzU0N2xNanpTM2w0TFhhdjRjcHFCOGNkZjBBbG9vNEJVNkczTHkx?=
 =?utf-8?B?OHV5QUJrNmdwV29KYUpjNTlvUjFJNjdEQUFjaE1HNXNVcUdFd0tHMzZzV1Zv?=
 =?utf-8?B?WUdZendvNXBkaXMycFh3ajN0ZEREQXZNd2JaWUkvNUdiZ2lseWRLSm1lMzcx?=
 =?utf-8?B?M21OZCs4c3BBWlFJTHlXUjAxdE1sc2s2anQxNzBkd254VnFiNSsrWUJIa0di?=
 =?utf-8?B?cWNVUjlxRmlWQ09pemlRM1NIWmNyQlJJQVdGbklncGVHMm9RUkx0eUpQaFRP?=
 =?utf-8?B?VVNqQllKbmo0NmYzY0pZTGE3a3lOYTNXR3A0M0syWW54aG1DSGFoQXc3bDRB?=
 =?utf-8?B?c1lQRVlsMlpMR0pyazFReDZDMldJV01uWkZyS0YvdGpkOTM1S0VkNjlFSEh1?=
 =?utf-8?B?TUV6UWpzaDBaelFYZGd3WGltWEErSHBVKzRrK3ZobzM0VGkwOGFEWU5ObFJq?=
 =?utf-8?B?NzZUMXdmVWY3bUJWZXcyWXlxZjMwUjVIbVhocit2T0RySmdnWXY0N3lqL1hZ?=
 =?utf-8?B?akxMbDZOQU1xbkIwM1NsSFo1aU1idC9UY3pnNlNEL09xR3BmbTBMT3d0VWtC?=
 =?utf-8?B?UzlLQWJFR2haTklxREw5blhDSGIwSDJoSXUxZThDMU1TaStKMGtlb2RycnAx?=
 =?utf-8?B?a0N1K1dVbUxKR3krWnZGbms2SWc1emRhRHR2OXhROS9rdXVlMGZ4UFliK3dY?=
 =?utf-8?B?akNRc1I0ampiMThvV3BRQW1zZnRBY0xMdVUwaGpkUGRoYzM1d0thTE8xUm8r?=
 =?utf-8?B?MVpSQWZmRitORkR5R0VrLy9BSnZ4c1BKUWZOeER6N3FBckdVZVNGbytVUWFq?=
 =?utf-8?B?cWVIaUtkam00enZGczRCMDI0c1dMTjNNa0VkSnhqTjV1SStiOW00OEM4ekJU?=
 =?utf-8?B?VFhZUjN2Q09tc2k3S0NVZHFNaUEzY0tqQ3ZIMm04cmE4RFVDTU9xNFVIYWtY?=
 =?utf-8?B?SmVHcnM5NitmUzB5Nkwzd2pwbGZWL05MZnFzTmsyOHB6V1VvVXE2NEN1cVdP?=
 =?utf-8?B?UEJHb00reksweVVMOThPZ3dSTGc1K004Z01ZaEpBZmZqVTNCc3NnQ1dsbTln?=
 =?utf-8?B?b3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KpCXlNlRDjzB2noRD/6+GshN4lIR1omPRw2VNS44jqb5wI/htjihSgQP5DX03bpwELJllJSiQGXqLvBSMJkA1wHT7zw9GbPp98H/bneEfcc96EQTBuU02/HHYrQ6jg+vZQiHSaIdOaiYqZKXxTlHcn7vP0iJgeofY0sQpmY8P9uhVuZfRP0rowcZRJ9qA0hFx1ufK6nlR1dVOu0kFvrOwcXAxJV+WcMYFL8bhPI3Qn7sTjhh+RwQEEEjyk8ZMqAUOcevkVPLUahQclaIWipoOPGfurKP4y9PMTqyBFh0lV/jgL6pu+kUNkHzZVPwfIi1n7OF2tog+EnOxCE+ftEmcxyPzvQ8luWsOL/kCxDQa9Vj2Y9f7GU1khQapiw1CX7b9irF3DTNQ3rK7dYmDkF/+6RCwW8jleT++LGtt0RLhvUjHAAEPTesAu8MQqPMYmjL4Mu6Z7KIu+q+Y31MhaQa8KUNJyqVj40Uz2kdu+rVkI/JwdD+ge2HlYiWYPO018TDWFWPOPLbBq4tG399m/Z5REeFTR0pG51DOSk3BQnf5Px4J5nwiE4vsxo8F/wlcYfWzHV1yDuQgDl28JSg/kpU2gdahyFfJKVD/rUGjM0lMOU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16ba766f-f79f-4558-7a16-08de0a2b740b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2025 07:38:08.1944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6N1USck6EWPVVWlxVYvBPlP6bBPUIOjlvypVqzakQZLCHXjzwLwWS1/rXhPAylP4Rn1lh87OjEnJMHNqWkRXcA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4459
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510130036
X-Proofpoint-GUID: 98JDdYOBLs_ESVifAk01sf81Lq0rVtMc
X-Proofpoint-ORIG-GUID: 98JDdYOBLs_ESVifAk01sf81Lq0rVtMc
X-Authority-Analysis: v=2.4 cv=QfNrf8bv c=1 sm=1 tr=0 ts=68ecac64 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=vnREMb7VAAAA:8 a=yPCof4ZbAAAA:8
 a=7NwytJgeWYuL-Z4NmlEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12091
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNyBTYWx0ZWRfX07ieRhksb4xp
 fgh68M8RC0OxlP2vMc33oHFVqd6KIZTll7qkBT6za4nVQ/WaZkR8YtN0b92ihlBrS2w0CNzFEOv
 5bCYMhXKHRN4ZcNauK1f3fXt3LDbzqgA6tQ7rZ4PeVB9PMzA3BkUy+tOcJftiQOonADPB2K+OcZ
 kv4AKj/9ZcnH+MdEHxnDAayyBLAuKAC7yRPNUtB5ELQqus5SyhCjzHklpjr94jiluYSvzFbgBDf
 Pre7txeCJFW/r1945c35O7BB4PiwRJnhPi0pvtuldZgW2Qr55vpa9yf1T1ysnPTG64T69ZFxJ8L
 Tn8ipO8uTx9clAMr0C5SCy3gAvy0cqWqpL2ur44oeIU5IgAu0+qqBTA5XB94RH56b6jMRPIqMx9
 4JsH7Y55TJWilsoqSqMWOAPmFSBxRhs1UzWa76ivQvbeUTWXw7E=

On 13/10/2025 00:45, Alexei Starovoitov wrote:
> On Wed, Oct 8, 2025 at 10:35 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> In terms of BTF encoding, we wind up with 12010 LOC_PARAM which are
>> referenced in various combinations from 37061 LOC_PROTO. We see that
>> given that there are over 400,000 inline sites, deduplication has
>> considerably cut down on the overhead of representing this information.
> 
> Looking at loc_param and loc_proto... they could have been 8 bytes
> smaller easily. So the math there is (12k+37k) * 8 ~= 400k byte
> is not worth saving, since locsec dominates the size anyway ?

Yeah, LOCSEC dominates, and making the params and prototypes easily
dedup-able really helps; they wind up totalling less than 1Mb for all
inline sites. The LOCSEC are over two-thirds of the size, then the
majority of the remainder is function prototypes and string names.
So LOC_PROTO/LOC_PARAM turn out to be one of the smallest components
thanks to dedup.

> Having a common struct btf_type for all of them also helps dedup, I guess ?
> A bit uncomfortable choice, but probably ok.
>

Yeah.

>> LOCSEC will be 443354*16 bytes, i.e. 6.76 Mb. Between extra FUNC_PROTO,
>> LOC_PROTO, LOC_PARAM and LOCSECs we wind up adding 9.2Mb to accommodate
>> 443354 inline sites and all their metadata. This works out as
>> approximately 22 bytes to fully represent each inline site, so we can
>> see the benefits of deduplication of LOC_PARAM and LOC_PROTOs in this scheme.
>>
>> When vmlinux BTF inline-related info (FUNC_PROTO, LOC_PARAM, LOC_PROTO
>> and LOCSECs are delivered via a module (btf_extra.ko.gz), the on-disk
>> size of that module with compression drops from 9.2Mb to 2.8Mb.
>>
>> Modules also provide .BTF.extra info in their .BTF.extra sections; we
>> can see the stats for these as follows:
>>
>> $ find . -name *.ko|xargs objdump -h |grep ".BTF.extra"|awk '{ sum += strtonum("0x"$3); count++ } END { print "total (kbytes): " sum/1024 " num modules: " count " average(kbytes): " sum/1024/count}'
>> total (kbytes): 46653.5 num modules: 3044 average(kbytes): 15.3264
>>
>> So we add 46Mb of .BTF.extra data in total across 3044 modules, averaging
>> 15kbytes per module.
>>
>> Future work/questions
>>
>> - the same scheme could be used to represent functions with optimized-out
>>   parameters (which we leave out of BTF encoding), hence the more general
>>   "location" term (as opposed to calling them inlines)
>> - perhaps we should have a separate CONFIG_DEBUG_INFO_BTF_EXTRA_MODULES=y|n
>>   as we do with CONFIG_DEBUG_INFO_BTF_MODULES?
>> - .BTF.extra is probably a bad name, given that we have .BTF.ext already...
> 
> yeah. 'extra' doesn't really fit. Especially since that will be a hard coded
> name of the special module.
> Maybe "BTF.inline_info" for section name and "btf_inline_info.ko" ?
> 

I was trying to avoid being specific about inlines since the same
approach works for function sites with optimized-out parameters and they
could be easily added to the representation (and probably should be in a
future version of this series). Another "extra" source of info
potentially is the (non per-cpu) global variables that Stephen sent
patches for a while back and the feeling was it was too big to add to
vmlinux BTF proper.

But extra is a terrible name. .BTF.aux for auxiliary info perhaps?

> The partially inlined functions were the biggest footgun so far.
> Missing fully inlined is painful, but it's not a footgun.
> So I think doing "kloc" and usdt-like bpf_loc_arg() completely in
> user space is not enough. It's great and, probably, can be supported,
> but the kernel should use this "BTF.inline_info" as well to
> preserve "backward compatibility" for functions that were
> not-inlined in an older kernel and got partially inlined in a new kernel.
> 

That would be great; we'd need to teach the kernel to handle multi-split
BTF but I would hope that wouldn't be too tricky.

> If we could use kprobe-multi then usdt-like bpf_loc_arg() would
> make a lot of sense, but since libbpf has to attach a bunch
> of regular kprobes it seems to me the kernel support is more appropriate
> for the whole thing.

I'm happy with either a userspace or kernel-based approach; the main aim
is to provide this functionality in as straightforward a form as
possible to tracers/libbpf. I have to confess I didn't follow the whole
kprobe multi progress, but at one stage that was more kprobe-based
right? Would there be any value in exploring a flavour of kprobe-multi
that didn't use fprobe and might work for this sort of use case? As you
say if we had that keeping a user-space based approach might be more
attractive as an option.

> I mean when the kernel processes SEC("fentry/foo") into partially
> inlined function "foo" it should use fentry for "foo" and
> automatically add kprobe into inlined callsites and automatically
> generated code that collects arguments from appropriate registers
> and make "fentry/foo" behave like "foo" was not inlined at all.
> Arguably, we can use a new attach type.
> If we teach the kernel to do that then doing bpf_loc_arg() and a bunch
> of regular kprobes from libbpf is unnecessary.
> The kernel can do the same transparently and prepare the args
> depending on location.
> If some of the callsites are missing args it can fail the whole operation.

There's a few options here but I think having attach modes which are
selectable - either best effort or all-or-none would both be needed I
think. The other thing that can go wrong (apart from args missing) is an
inline site can be within a "notrace" function but looking at the code,
kprobe attachment seems to handle that already (by failing) which is great.

> Of course, doing the whole thing from libbpf feels good,
> since we're burdening the kernel with extra complexity,
> but lack of kprobe-multi changes the way to think about this trade off.
> 
> Whether we decide that the kernel should do it or stay with bpf_loc_arg()
> the first few patches and pahole support can/should be landed first.
>

Sounds great! Having patches 1-10 would be useful as that would allow us
in turn to update pahole's libbpf submodule commit to generate location
data, which would then allow us to update kbuild and start using it for
attach. So we can focus on generating the inline info first, and then
think about how we want to present that info to consumers.

> Just .02 so far. Need to understand the whole thing better.

Sure, thanks for the feedback! BTW the GNU cauldron videos are online
already so the presentation [1] about this is available now for folks
who missed it. I'd be happy to do a BPF office hours too of course if
that would be helpful in ironing out the details.

[1]
https://www.youtube.com/watch?v=03FiWIcic_g&list=PL_GiHdX17WtxuKn7QYme8EfbBS-RKSn0w&t=1640s


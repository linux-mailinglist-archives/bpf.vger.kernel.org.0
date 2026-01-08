Return-Path: <bpf+bounces-78246-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A28FD05AEE
	for <lists+bpf@lfdr.de>; Thu, 08 Jan 2026 19:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 472D830312CE
	for <lists+bpf@lfdr.de>; Thu,  8 Jan 2026 18:55:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21782320CB1;
	Thu,  8 Jan 2026 18:55:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HgytbT1u";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0OqZrEbG"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E8C319873;
	Thu,  8 Jan 2026 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767898548; cv=fail; b=cL7gZynjNm6epuJeARDOrUp2Kl2oLDmjmvyMXjqL5RG50CaScqf9irp1Tp2rVY706H0W/Qz0efoLEmooLfBDvsmrK6OgNdNIOjPck/TbeZIC/MVq5p8KkmPrtgA0j941hblr7r6GQ/aKBIT6ekov0FN25oMNFXAgNuJFhuI5YIc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767898548; c=relaxed/simple;
	bh=QYsArc+4omEQK+wGJhpD0nPeCYVXKsEU1qccaJ0Ob94=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Di3OddppQkY6U8LmGdNpbZSv9OHPZ1UDzKqzKcJiASvKsH0h04Tpa7zYo6ddFebO0Oxea5eiwG4XbgLPBeBQTuc10OxCTm5GxdRTELd8FuYiEJ99sTTge6Lb6YgHkD6KHhXn5Y7zuftsxGc9lAu62dAeTbyvF+jA5PULPtKaNYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HgytbT1u; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0OqZrEbG; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 608IYkMo798999;
	Thu, 8 Jan 2026 18:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=i529WZNvtF/6RrwDRh0vnztXa5bI3snZpBqPo3WhL4Y=; b=
	HgytbT1u3o3sRiMhPil62yEy2WGyrBNj1cYXJTqNIbxA0H74CZKnNdmfzazRQCbz
	K3dPCDUN5wJYiHAWh5SDqDv2uuUKbogoFgTc13BLKtP8QxrxJ863kuw+xN7mvujW
	Ia0133ad4kmD+WCOA03mCON715EvR2jVU5DEaE2zmeZJC6Q9ypsDpI0h4ALzAQ9i
	F/a78DYtRv+hLtFaWfH6J5vEvBJqgoCGQK40njMzYi06DxzLf4ncu9xE5B8gtcHY
	mhclDBi8qn2Dr/AtpJJ5GG9eYbYXuqONvmnqNatCdp8oeRMgZwanN6CPhv8s3e1a
	Db4enC+dqmTymZAEMTqo9g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bjhyy80vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 18:55:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 608Hj46n020440;
	Thu, 8 Jan 2026 18:55:18 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010031.outbound.protection.outlook.com [52.101.193.31])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjnf2xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 08 Jan 2026 18:55:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETJEEeqtPp2tz7+VVM/IkbOtfZzjdai2/E8WnkRShJpD2sdDK+Kum3JK82WYkc/hUCQVuTgf3/pM6dpX2fKDYW4c0NkSIimCrXQf5q2UBuxtQ0WXy6Z9DpCbmliVh7kb33qrDh2uwkSHYVFqesNtxkLYDx6O7EUrlbzqFXLnAbbQAUYuyJ0hfMELW/7YVM9Foxxo2Y8uJJ/uVl1JXyklRnAvpcFruqTPVlGt2Xq5uHD3jR2dv5Oaw7kyzZoXoz3VAn1BaIacrJFv/dPfidcEdrG5xN5MNuiBGIs6O1hGoYbw0ZyBVTn4VY7S3JXmA4md2Q4sMzGnl+0dg6sCN5fW6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i529WZNvtF/6RrwDRh0vnztXa5bI3snZpBqPo3WhL4Y=;
 b=AWmexqOYtE4uKmYnjHXeZc5QnUv1UC1wwJ9g8PwC8regFzOxtGQ0RlfkU0ILYaivQW8F9hBRHF/wwcSFpnkzFsHxAJTpwck7lMhxWPA4rfyS0WindPc6dWecVm3cWtMjXmGQUOn3xDUqQKT7NmrT+vK9V0s71B+Tyq8vKRVwH/HcbVa8pSW66N5j7+2Erb99zq7LYSODv1meq4yCPoOcMhl7nRWy0NOkTjv0uwqHPYS8OY2zPZtxoSy5eKnye4BIb9qnv0ROxnB+wR1k2tMbjedOPWJefFsMyfTKhoZG5m4LcP6ewpml778txKit2SarYfYvmo07CN/cIzZNM+NLYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i529WZNvtF/6RrwDRh0vnztXa5bI3snZpBqPo3WhL4Y=;
 b=0OqZrEbGIlUGgxeR0/YiRllOijtRDncQOnj+xU0L8yMGlB7tdab4vJjv4pqM0aNAygYBrh0DV+RbxM8bBP7HujfcOfdV8l4dnrTsMz1xGu6zauC/EDWlDMl7o89p3enjJxkAg4kmSlKNxkq/SkF8upe8KGKv73ckXgMfb5KRnvo=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DM3PPF9AA7322D8.namprd10.prod.outlook.com (2603:10b6:f:fc00::c39) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.3; Thu, 8 Jan
 2026 18:55:16 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Thu, 8 Jan 2026
 18:55:15 +0000
Message-ID: <64de60b6-4912-4ec8-9c85-342b314c3c5c@oracle.com>
Date: Thu, 8 Jan 2026 18:55:08 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 bpf-next 01/10] btf: add kind layout encoding to UAPI
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
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
 <22c54404-512c-4229-8c93-8ec1321619e0@oracle.com>
 <CAADnVQ+VU_nRgPS0H6j6=macgT49+eW7KCf7zPEn9V5K0HN5-A@mail.gmail.com>
 <19a4596d-06dc-42ae-b149-cc2b52fffae9@oracle.com>
 <CAEf4BzbCxGaFu5E_oYdMxzkqhtVxSnwHawcUv5jM5Sodut5cdA@mail.gmail.com>
 <CAADnVQKYTMPyWLNn-5HHnA23Ay3qNdGUJ9TNVcy62zPEf013Xg@mail.gmail.com>
 <CAEf4Bzb5askzzBL4BnR1tcjio+jW3zdVs_pPPgSq7vd+N5zuXA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4Bzb5askzzBL4BnR1tcjio+jW3zdVs_pPPgSq7vd+N5zuXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0034.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::8) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DM3PPF9AA7322D8:EE_
X-MS-Office365-Filtering-Correlation-Id: 007f2447-9920-4140-20b9-08de4ee775d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a0tQV3YrclhtbGJhQ2xla2hQbUgxZ0ZmRE1aeHlyYWJOMXdqdGhFWVhUQjVF?=
 =?utf-8?B?a1prVUtYdEZWOXBBRVNHWEM0NmY5bU9DUStMR3ZJaVhlZjB6blkwMEVOZDRh?=
 =?utf-8?B?YzRISUxxYi9ZcUlEclRpSU9wNExzRmhXUE5PUUJ1cTI1cml3aXR0c0Zobk9K?=
 =?utf-8?B?ZDg2a215ckszSWFFVXh6Z2YyQ3haMnU2ZGNvUkdiSzlCNWxNMHZCemh2cWNI?=
 =?utf-8?B?eExkSXc0emJQcmVxUlhaMU5ud2Y4SXVDSGsxRkFRK0d2U0xFRHdEd2pQQ0pi?=
 =?utf-8?B?LzV5MWpld0huV01Ua3ZadFV4a1hXMzJjVEVTRWVydHdHUnpzZjdvYkk1RmJs?=
 =?utf-8?B?Q1RDSkhiRC9udUJvQnZuYitZdU1jdHBERndWdUpTcHpFRk8zSGcxMEN5WG1D?=
 =?utf-8?B?VW9NazFTWXI2ZGsrdmxMNEc3alRrcnVkZlllK1c4UlN2bUdwVm8xdUpxNVp4?=
 =?utf-8?B?MFNlYlpYTDVrWHhBSGRJR3F6Zy9Kc2NBdXBMYTA3YWowKzdjZCt3UEtkeXFC?=
 =?utf-8?B?cVdma2dCcTZlR1hWTDBxNlJCM2xlYlZWOUdEUlorTG9XU2FVc0xGK09RajVI?=
 =?utf-8?B?cU5oRWNxTnR0Q2JjRFJqYTRVVFBOM04zazNpaG54QmtsbFA5b29yVnJjL3RM?=
 =?utf-8?B?dHpMTitOYW5sT0JIcllTUGkxZno2QTQ3R0pVR0orclkxT0tFQ1hvU1VyTVo1?=
 =?utf-8?B?WmRjU0p2VHlleWEzZGV4VWVMampkRkNUSTlJd1JPNjBHcTdWUm14SCsvUEpZ?=
 =?utf-8?B?K0g2bGdKOTlxSTBYelhGVi95U1VSWXZOcWRYMnhTMGJEOXM3ZnBBclZWUDJU?=
 =?utf-8?B?aUlKSlZLSE5uU3BKSFQ3M1M0ek53N1ZoaUE5Wm1tTStzVXJqT0M0SzRRcTgy?=
 =?utf-8?B?T0Y2MFRVbUl6aGcvQjZIK2UyVGdxTHRiL0t5OFBJNUFDZ1hRckFYemVKYmY1?=
 =?utf-8?B?OGRkMGtVd2w0T3oxRVR4RSttd0J1Lzd1OWNuQ3hPK1RtV0xmME5XV0F3ZnlE?=
 =?utf-8?B?MmlLcTFKbzZKN2d6WWs4MzVoT015dTI4TndXZWRVSE1JSXp0eWZJcWp3ZW5q?=
 =?utf-8?B?ZGFGR3JUTTlncnh1RUtVc1FrTE9IVGtGVng4WjZJVEZSSlk3dXozV09PSW1B?=
 =?utf-8?B?UGpCNWYwQW85N1N1VEtQUlVZUkk1RzFtSkd4dlpyNnBxVnI0eXpxc3pzUXNw?=
 =?utf-8?B?dW5RekZJcDJmWWErZ3BVbWZ1SmlTR3p2bVhxM3hsbnR1MUFoZFJSS0VTNVNw?=
 =?utf-8?B?WGtjSXpYbkJMcGlkaXdtMER4NFphcGlNVVlXVU4rdHg4TlY0TThPYmM5UVU5?=
 =?utf-8?B?a2s2UE5tQU5Id1UrYzNMNHV2SGZhWkh3c0hoTjBxMXVYSkYvYkZIUnpXZ3lZ?=
 =?utf-8?B?TFZEYTlLdk95cHdtTEMyL3I5UEliV3RudktMVi9PbjFxbkZZSUVUQTd3dUVE?=
 =?utf-8?B?cjdLQ080Nk53V3JLMHdPNHVpWHFkTU9mYkdKb3IrWFRGVVd2ancrcU5pbDBF?=
 =?utf-8?B?dVAxQjV4OGhKYjg0ZEtmL0wzZERaNTg2aE1Jc2ZkaXI0NEpRZ3dpTjgwNHpp?=
 =?utf-8?B?b1VKYVE5a1JUa3R4ZGRtTzVsUVRPTXV4OGVmVUhuQWcwdmdNOE04K1FJbUZh?=
 =?utf-8?B?NVJSbmpkTFZJZDZHTGNwVVBvUnBxV3IvMWdEWHcxN0x4RndKTkh1UzlKR2tS?=
 =?utf-8?B?SzFyVWZrVmF1TUtGWFh5WlF5a1d6Yk5YZm5qbDZyMTdRTjZXNWU4cDdyVkV0?=
 =?utf-8?B?UXRXUlR3Qm0wSjVCNjNRL21TN3ZCaTlZaG5yUXNUNDZHaGFUWXl4NmtnUmkz?=
 =?utf-8?B?SGZpdlNUTHF6VzNPcDZOZGpFSGQyREsrS3Z3L2xKeUNMM3dEWjVkWTE4ekxt?=
 =?utf-8?B?YmZkY3kycWFselV3OEJvT3RCRmUwdE02TE9uK2Y5V3B5N0UvaEU5MGlhRFFr?=
 =?utf-8?Q?IZcFYWZX9n3qJliWgcbzII64VLEoc1yJ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dmJKdkNLaUhCZDV2ZzI3WTJDRGRtRXM5QkFSMWhXZmZKU0NYNVZ0L0l5S0I1?=
 =?utf-8?B?NFhjdzJQeXlyYXQ2WSsxVm5hVE1DdzN0SlBtZ25oR0w2S3hwNlI1QzVDYVll?=
 =?utf-8?B?S3V3L256cXBWcGFHMlNrWGdUYUNKTDhlYlBWRzZFcm1OdUlCL1VoVGtHRjhW?=
 =?utf-8?B?Rm8wQVZuVEwvVVAxeVI1KzY1QXVmUU9PcUFVMVk4Zy82NC8vdnkraFhZVDNR?=
 =?utf-8?B?Q2luMGdZUEJlOGJlMHArUXNhdGl5SlhVbit2d3J0N25rT0dRWkMxeFhnamIr?=
 =?utf-8?B?b2JDTWdWSlErVmF6cXA4VWFiQ29QWDdYZUpoT1lTbkQrVFhvRnhlWTRmbmRR?=
 =?utf-8?B?QkJWM0owSk5MNE5JekZzakpTYU9xVkFnblhLK0Ivb3QyZVV5SFdTMEhuWG9Y?=
 =?utf-8?B?UjAyeU9MQlVuMnlkWFRyZFdRekNQdVlGblB6ZytZSXRTb0dTSGtYcmo2TEdh?=
 =?utf-8?B?TysyeWFaK3I3RmFadElqN0RjSU5iWEZTVzRONi8yeFVkZjhTQ0xGaWhPdG1u?=
 =?utf-8?B?dWhCR2lhOUhpQjhUdlJmc2xPRWYvbTFQZmEzL214djVmSWtHaklpT1Y4azJV?=
 =?utf-8?B?QS8wb3ZTenpIcUpJQ3hNQ2pDNmovdmJZQ1lQV0VVcXh2cEU3K2U5bkVlZEd4?=
 =?utf-8?B?VWhWZ2Y5K0xnZnZuNkQ2QWRKOXo1Y3RYQmVkSmlTSzJBM2JWckNoMkMxb1gv?=
 =?utf-8?B?V2tMSmw5Snk0eVgvKzdvN0E2eFVSU21pbzNERFpRZ0RYL1JPQjcyL0xicXVX?=
 =?utf-8?B?UXJpdmdOR2g4RUk2YWNaUlgrTDFWalFYdElDd0Zad1p1bmkzL1dzTGUxcDMy?=
 =?utf-8?B?M0pnYUp4RmdFMGlvOWJlbUtxcjA2ZnZRVWJvWjFkRmJIeHU4YW00aGpMT1Y2?=
 =?utf-8?B?QmdqRjh0L015VVJ6b3NReEpLekVMcmplL1BPSnRsdzYyN29UbStIZkFYNXlN?=
 =?utf-8?B?cEJvS3FBckMyTFVCU1IrT2k1Z3drT2Q4c09Kd2J6RDRxdnZmdFRsQTBvTmls?=
 =?utf-8?B?ZTJtcjZUcFExOFEwbHBkSkg3UGZCeUtpOWpaU2dFNCtOZ0EybE9KN2JLeGhz?=
 =?utf-8?B?TGl4cmJBZUhJdXRQeGNOa0lycXpPZ3NOMmZIVFJhbjJyN0Z1eEpvWCtodU1y?=
 =?utf-8?B?L3lEbS92SDdHOEU4MEVyRXNxb2ZvMmpERlVkZGxLazJERWJTSlZlOXlVNFo4?=
 =?utf-8?B?V0U4eFh2emJrVXc3elFZRjdtMXZEYmR2SlpRaVFkWXc1N0swNGZhMXJYSjgw?=
 =?utf-8?B?cWJPai9neEpraDBtbmEyUTZzWXgwcnF1RlVQNHB1dHdubThBQVBWbzJsc1Jz?=
 =?utf-8?B?azFGVWJNTElsNng3bXhOUi80TnZwQWdBaTdHL0IxQWtabk9LOXhTMmlLMUEx?=
 =?utf-8?B?OGZnSDV5cHZJNE1taUJrNU5EZmJ2ZkNNUDh2UEgrVjRycFZzRlltemtTcHlH?=
 =?utf-8?B?WHNwM3dGdGlyOFBnZjVlZmp6d0lRcEN4dTRnWDFLenpiK2dlc1RPbTY3SjZE?=
 =?utf-8?B?VTE3RXdPc0NIR0pwWlN6akRxYms3MGdNNUZkaVJaTVpUZThPTlY5Q3VjbHhU?=
 =?utf-8?B?alhLWkk5YTZHUS80dG1Xb3VIdGFBOWFhbUhCdHdTbWlrWXNaRzhrdzQ4QnpF?=
 =?utf-8?B?RDFvc0laQ2dJd1ZEOUNBRHlqNzFjSnNubE1LZ2JJbm03d1lVcGhTb1JNK29Q?=
 =?utf-8?B?N1JwaGprNVVSYUhDUndGSEZoZmcwdGhhL2t2USttRnpLNVpVOGhoTkxSVHFn?=
 =?utf-8?B?bXJkc2lzSVJLeWZldXlGaGQzVUU1OWtYeXJVMHl6SHBKOStpWWJwT0g5eUJq?=
 =?utf-8?B?cmEzSU5aTmkwR3VTMHlHQkNPWmpVZUpiUGtYa1NCOUFkMDJIOGF2THcwZ1FO?=
 =?utf-8?B?Zkg1cVlPS3A3dWhxY1lqclN2VmlvL2FzSmVHczRKL0FjYUtmR3oxWkt1WVly?=
 =?utf-8?B?LzFXWEFGeWF4djBPSHd5MlZ6dExtb3lndUxFRFo0V2x5L3ppRWxhamF5ZFlU?=
 =?utf-8?B?REM5RTcveFE1OUpjbHk4eDdta2tKanJ1bnFyYUwzdW1mSitRTTdLazF6aGRG?=
 =?utf-8?B?eUs4MjNkQjNJNUpUNWx0eWZxWUkvUXA1TzhaQW5zWndnN05xazZHRkNEanZx?=
 =?utf-8?B?aVltbGZ1Q0RudndQOWlMQ0xSQWRZTUpzYVFrMTJ4d29hUUI5YWpBMk9KcmFL?=
 =?utf-8?B?SGpaYlBRYkc3U0lkUjZoMWRCVmNCVTVpV1BDSHRzS1NLUDhCdjk1cHRJaG0y?=
 =?utf-8?B?VWxNTWN3MHhrdWFmc21SN25NcTFpNjR6L1VsaEZtMGRNV0ZDWFA1aHFsYkhy?=
 =?utf-8?B?cVE0Y1dUMTY2c00yUDVlUm0yUTQ0b3ovTUE1NU9XaU1yaXQ5Z3NjZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6bTE38Hv9fjnAA2GM5XvL5L/RbXiXE0bjElDAst5enkL4IyIRrtStYPHG/SCS9ar2rgVh8YRQUZNeU9Jf8ZgfoHYmlmd5cj6zad3tDI6IH0FFuRjuNORJ0HFBdeGXCnjHdy3c44e93a7FYO50Ly/2DAslOFDgxUr+8Aa/uvB/FdWnMQpjDs7M+rhH7o81hi5G4VFKV/vDXBPwBcxts1uOq4bcoIbbpZ4VBvBG8xTAvg/NYgnIv0n0lMcN05PXAiaiy32XZAjuWXyccsxCWO0kbfkxIxFj3LL7Z1eQmP0frxCbL/O4Hmxm4N7SBGRAMsJHo5DWfPsimb5Y578mHRv6zi6g/vkhStg0+6QM5J2b+QZ4hsh661mQ0eK4XM1Y+/Vfk1AILTzxJ5/pMATMQAnWU1mf91l/w5/W8xrP5Xws+2UlLJi3Hj5/QMsO9RkYJXLueyitHZJHFEXRxlQTmy+T3bpDD/6K/wXoT+C1bBvgjhzqK39n48KVVnk6c2QfMiy0w5s84cMUv3GgQ3dw7jx0V0WUJG5sVgLeL3dPL7f4YJjeH5Cb8MjcFMS+eXchSV0HO1VlJLEou3nFx6KzqqN89hSC4LyNnTeWRhw34FzIIc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 007f2447-9920-4140-20b9-08de4ee775d3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2026 18:55:15.5996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VTR1tnMdyr27jGdoDo4Ntrm8ZIjO0y1fMgd0pULUdFkmrwwuIH7vwyYmaYPg8l6UjzT82MWjq3UQNmm39l43vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF9AA7322D8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-08_03,2026-01-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601080141
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA4MDE0MCBTYWx0ZWRfX1+E9UKAN3lDy
 YZyEI5cWcuuIvoRL85k0TzmQFNc1WOnUo9Khyjb7q74vVgx0T1ICF7f83o7HtnwWwFSIkcFT+hp
 nCbA13cc1nMG88m+VNgnm40BfAQiNirgwRMhRT0eN/tpGxPs9Dev++E2ydG+jprjEWV5qz2025S
 5QQsmLe8s+Q5GerZ4GGesCPHuk5mndb4abnoTwy4vSDCAZwj2XbEuRsqz9T5G9w69qkAYdxppJc
 44Hj/jxBia4vF8q1b5qt2gqw2acMBj1W8Tc7JxdiuJmntztWpzb9OWLCxQeEQUplOYljXThbgQr
 E7fjD5dK2/dsyygFr/VCRW4tjqBSlBmsXwCufaZeQV5ZRU9oA0q0566c6epiQWoysca0EEDQhz/
 gNY7YGOgF9UqdeCB6YTa2alJbUMhTRiDjWbCcZOIlmYXZNlppKOBuZHOwEWhsxBlVVNeaEJwYp9
 ec+Bnz6BjOo8qa02pIiLSOm3aQLpyEGW7rfq6Tfc=
X-Proofpoint-ORIG-GUID: pceSlT7rbbWQwGtpbE_YRvFOGqJ-Lt8N
X-Authority-Analysis: v=2.4 cv=dN+rWeZb c=1 sm=1 tr=0 ts=695ffd97 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=kxHYgX4Ll7yivG-7ZfUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12109
X-Proofpoint-GUID: pceSlT7rbbWQwGtpbE_YRvFOGqJ-Lt8N

On 06/01/2026 01:19, Andrii Nakryiko wrote:
> On Mon, Jan 5, 2026 at 4:51 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Mon, Jan 5, 2026 at 4:11 PM Andrii Nakryiko
>> <andrii.nakryiko@gmail.com> wrote:
>>>
>>> On Tue, Dec 23, 2025 at 3:09 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>
>>>> On 22/12/2025 19:03, Alexei Starovoitov wrote:
>>>>> On Sun, Dec 21, 2025 at 10:58 PM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>>
>>>>>>>
>>>>>>> Hold on. I'm missing how libbpf will sanitize things for older kernels?
>>>>>>
>>>>>> The sanitization we can get from layout info is for handling a kernel built with
>>>>>> newer kernel/module BTF. The userspace tooling (libbpf and others) does not fully
>>>>>> understand it due to the presence of new kinds. In such a case layout data gives us
>>>>>> info to parse it by providing info on kind layout, and libbpf can sanitize it
>>>>>> to be usable for some cases (where the type graph is not fatally compromised
>>>>>> by the lack of a kind). This will always be somewhat limited, but it
>>>>>> does provide more usability than we have today.
>>>>>
>>>>> I'm even more confused now. libbpf will sanitize BTF for the sake of
>>>>> user space? That's not something it ever did. libbpf sanitizes BTF
>>>>> only to
>>>>
>>>> Right; it's an extension of the sanitization concept from what it does today.
>>>> Today we sanitize newer _program_ BTF to ensure it is acceptable to a kernel which
>>>> lacks specific aspects of that BTF; the goal here is to support some simple sanitization
>>>> of the newer _kernel_ BTF by libbpf to help tools (that know about kind layout but may lack
>>>> latest kind info kernel has) to make that kernel BTF usable.
>>>
>>> Wait, is that really a goal? I get why Alexei is confused now :)
>>>
>>> I think we should stick to libbpf sanitizing only BPF program's BTFs
>>> for the sake of loading it into the kernel. If some user space tool is
>>> trying to work with kernel BTF that has BTF features that tool doesn't
>>> support, then we only have two reasonable options: a) tool just fails
>>> to process that BTF altogether or b) the tool is smart enough to
>>> utilize BTF layout information to know which BTF types it can safely
>>> skip (that's where those flags I argue for would be useful). In both
>>> cases libbpf's btf__parse() will succeed because libbpf can utilize
>>> layout info to construct a lookup table for btf__type_by_id(). And
>>> libbpf doesn't need to do anything beyond that, IMO.
>>>
>>> We'll teach bpftool to dump as much of BTF as possible (I mean
>>> `bpftool btf dump file`), so it's possible to get an idea of what part
>>> of BTF is not supported and show those that we know about. We could
>>> teach btf_dump to ignore those types that are "safe modifier-like
>>> reference kind" (as marked with that flag I proposed earlier), so that
>>> `format c` works as well (though I wouldn't recommend using such
>>> output as a proper vmlinux.h, users should update bpftool ASAP for
>>> such use cases).
>>>
>>> As far as the kernel is concerned, BTF layout is not used and should
>>> not be used or trusted (it can be "spoofed" by the user). It can
>>> validate it for sanity, but that's pretty much it. Other than that, if
>>> the kernel doesn't *completely* understand every single piece of BTF,
>>> it should reject it (and that's also why libbpf should sanitize BPF
>>> object's BTF, of course).
>>
>> +1 to all of the above, except ok-to-skip flag, since I feel
>> it will cause more bike sheding and arguing whether a particular
>> new addition to BTF is skippable or not. Like upcoming location info.
> 
> I was thinking about something like TYPE_TAG, where it's in the chain
> of types and is unavoidable when processing STRUCT and its field.
> Having a flag specifying that it's ref-like (so btf_type::type field
> points to a valid type ID) would allow it to still make sense of the
> entire struct and its fields, though you might be missing some
> (presumably) optional and highly-specialized extra annotation.
> 
> But it's fine not to add it, just some type graphs will be completely
> unprocessable using old tools. Perhaps not such a big deal.
> 
> I suspect all the newly added BTF kinds will be of "ok-to-skip" kind,
> whether they are more like DECL_TAG (roots pointing to other types) or
> TYPE_TAG (in the middle of type chain, being pointed to from STRUCT
> fields, PROTO args, etc).
> 
>> Is it skippable? kinda. Or, say, we decide to add vector types to BTF.
>> Skippable? One might argue that they are while they are mandatory
>> for some other use case.
>> Looking at it differently, if the kernel is old and cannot understand that
>> BTF feature the libbpf has to sanitize it no matter skippable or not.
>> While from btf__parse() pov it also doesn't matter.
>> btf_new()->btf_parse_hdr() will remember kind layout,
>> and btf_parse_type_sec() can construct the index for the whole thing
>> with layout info,
>> while btf_validate_type() has to warn about unknown kind regardless
>> of skippable flag. The tool (bpftool or else) needs to yell when
>> final vmlinux.h is incomplete. Skipping printing modifier-like decl_tag
>> is pretty bad for vmlinux.h. It's really not skippable (in my opinion)
>> though one might argue that they are.
> 
> Yeah, I agree about vmlinux.h. One way to enforce this would be to
> have btf_dump emit something uncompilable as
> "HERE_BE_DRAGONS_SKIPPED_SOMETHING"  as if it was const/volatile
> modified.
> 
> But yeah, we don't want bikeshedding. It's fine.
> 

Ok so is it best to leave out flags entirely then? If so where we
are now is to have each kind layout entry have a string name offset,
a singular element size and a vlen-specified object size. To be
conservative it might make sense to allow 16 bits for each size field,
leaving us with 64 bits per kind, 160 bytes in total for the 20 kinds.
We could cut down further by leaving out kind name strings if needed.


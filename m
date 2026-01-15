Return-Path: <bpf+bounces-79153-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EA3D28D2B
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 22:46:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 28EA93037BF2
	for <lists+bpf@lfdr.de>; Thu, 15 Jan 2026 21:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 074A332D7DE;
	Thu, 15 Jan 2026 21:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="h69rT7Kw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pgb1+B6b"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3FB3346BF
	for <bpf@vger.kernel.org>; Thu, 15 Jan 2026 21:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513468; cv=fail; b=XTadmuhBCKcAcEHBIBFRm70EhCwU1Lsx74LYOgxAXeONwz9IoxhgcI3/3BuA2rEjqUO0ZuMebq76NEL+VEGXNUBniWoRTZVK4QMcaZsMnabOPipRXrpjiqiFnaJwMenN1LY4bTRwzuJw5z1Zk0cqCcns2YCHL2RZOaJH1eFfVYE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513468; c=relaxed/simple;
	bh=6cAnpl/ieePF/PvMqBTZDnYdt7axNQkLIjNi5wUp140=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UHWvA+aE76wTOnw4XgBkYsu0gRwTriCc7Rjjqo8j/m3S386aXN8TkWyS0OfdlT+4NQLT/67u1SUqQORzVIJb7X4lcJzrjWNxhcQbvecZvsN70GZsmICOPSK5MVRJoReD0h23FxRQG53NCsLnI0CiRTZHWC3A7PNNU3XAevyjOiw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=h69rT7Kw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pgb1+B6b; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FLIAm13643762;
	Thu, 15 Jan 2026 21:43:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3bvhn3tccNTGJCiO04T1sERUjxgqX4wt5vgVFCgFmaE=; b=
	h69rT7KwFB4ev13XTT/8aahRcnWmLbAmcY5iSsAYU4fU/obYVRc/k3L0aMEUgRll
	5kENrudKLLYtBmYLop4m431KAfA2SRk9rFh7LzQHXS7FmBGlj/HRaFeSelxQU0sb
	Xdv/kZIZGa4TiGhOcfdz6kqcYZQ0hteiOjkCQVa0rp1FenGqJIjW/+sOgzGwQH75
	pykUawc3QVpXfiezCeJDWbputliojj3qlds1Ktxa0+pMqlLbYXyk/uEGnMZKhCBj
	1jTBhBCCIzd0bU/9BV1QOMWbN3mg1m5c08GEJdrwlPkZo5mBaU9xst1N19FQ04GO
	wWmNtAbvPYF49iBRhWs+AA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bp5tc423b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 21:43:47 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60FLQmcI000463;
	Thu, 15 Jan 2026 21:43:46 GMT
Received: from cy7pr03cu001.outbound.protection.outlook.com (mail-westcentralusazon11010021.outbound.protection.outlook.com [40.93.198.21])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7fnmeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Jan 2026 21:43:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hiT1gTgOQSdY6N5NjfrJnFkwbda1e8orSML1oc9eB3OxfWmjK+zyfFhMg0EV/Wd+lSZYoyJN8aQ2GgrcCfgnV8jDN3KENK0rSvTh3KHHFB6yU0U8/ODQENsFqYUa1gi0b9wjpr3WH2Bdtg3GnT4nK6zOhK6UH6HtsfdPWhl1va5MAYzIHGCeNIbAkY05cubxn6o7eBkdnV82AEY8AdMg1w5AmP9OyjjeLRcnG+hZfYzxs9Tf77DlrUWr4izypyA//8En6BVEsS7hQSQwuTvA1R8uel7hgPwiSeVtYQY/ZUJrOxvyM9owwrtqiXTefN9WWlBYj0JA7QcUuVxITvGSgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3bvhn3tccNTGJCiO04T1sERUjxgqX4wt5vgVFCgFmaE=;
 b=lgbxMnSm1kndEQdSaH1a2liagyl5BN1iXYHUSJJ8sHG/HzepnXCvB0f+SKhOtNGFIwFfwNMN5f+ZXYqJjSY80GxJg31BoqBDeQlVW5V8pbdoq1U3A/ACrA6v4AR6Ru5o2b5EqYWicwgkE+yX5Kw4k5P4TQ0079Zj8OiUp+eZ2UlJAOpFOVy+/74xQV/o3HPQBGoIwRypWBx5IrsvngYiWk1yi1BfYowow5qPWvJxSfuhZacTk0AoC7o3tq+1GmG/6NKSBq3e990UqtFilqAuQQU1H+PX3l14Wf6sxKOrw0WJiFVNuGemQDgm7dAcPce3MfwIjQSY8an03/MGnJ1yuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3bvhn3tccNTGJCiO04T1sERUjxgqX4wt5vgVFCgFmaE=;
 b=Pgb1+B6bCXaXuMlQhQC4SBUMkP0Pdy88GSRKTyh9HOaENfh9gllUVxGBGAzFqyoL6XOSn6vENnfVPMsWYMtItYBV/o6hLBV8143hpOQEtDczS6DVI610H9tgsuWlIEpLcUwvEn/W9TEnPjPvE92O47mj7cngyZvrJtw2p2B1ko4=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 BLAPR10MB4882.namprd10.prod.outlook.com (2603:10b6:208:30d::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.5; Thu, 15 Jan 2026 21:43:43 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9478.004; Thu, 15 Jan 2026
 21:43:43 +0000
Message-ID: <b0d768b9-5a5a-461b-b931-850b56dc5d9b@oracle.com>
Date: Thu, 15 Jan 2026 21:43:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: KCSCAN and duplicate types in BTF [was Re: [PATCH bpf v2 1/2]
 libbpf: BTF dedup should ignore modifiers in type equivalence checks)]
From: Alan Maguire <alan.maguire@oracle.com>
To: Marco Elver <elver@google.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>, andrii@kernel.org,
        yonghong.song@linux.dev, nilay@linux.ibm.com, ast@kernel.org,
        jolsa@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        eddyz87@gmail.com, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        bvanassche@acm.org, bpf@vger.kernel.org
References: <20260114183808.2946395-1-alan.maguire@oracle.com>
 <20260114183808.2946395-2-alan.maguire@oracle.com>
 <CAEf4BzZruKmtcwK+V_qT8RcaXpp3=GXaZaiQtK4OchSR8Ye4Yg@mail.gmail.com>
 <5886e8c8-7646-4686-91b7-185cc953be20@oracle.com>
 <CANpmjNPJfmN57BsZknURkPG+1__1CsxW3zk+gpWS83c1diKstg@mail.gmail.com>
 <7b09d0ce-9d4a-439a-969a-24b808f76b30@oracle.com>
Content-Language: en-GB
In-Reply-To: <7b09d0ce-9d4a-439a-969a-24b808f76b30@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO3P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::11) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|BLAPR10MB4882:EE_
X-MS-Office365-Filtering-Correlation-Id: 54cadae6-0693-45d3-0021-08de547f277d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDZFVkNBamdyem5ua0F0WTVIWHFCUzg1U3E4SU1KNnFjWkJwSTIrV2NJNW02?=
 =?utf-8?B?M1dKdC9kdFNIMUJBc1F1Vk5EWWJmbTdSRTRCY1FkWDBMYmNzTVMvTGtHNjMy?=
 =?utf-8?B?SThLR3RpUTdvaHNNOER1aDZhZnFiUUZZUkdvK1JFb0xEajJXakFYOXE1K0JM?=
 =?utf-8?B?NVFhY3BDbGpmQXpNODRBTDcvMTdNY0pOQ1BLY0RQTUFYbmY4OXJxZ1RLaFV0?=
 =?utf-8?B?R3NIaHJCbE5USm9xQVR6OFJicFU5VjZvUmVwMlNxUG9vcmFxZTJaQWhtM1Vp?=
 =?utf-8?B?ZUlJUDdhRFB5UHFkU1gwYnVYVXVCbCtleit0TTk4bS9kVDlFWGw1SDRIbStu?=
 =?utf-8?B?S2hscVRUd21EMncxNVU0bXV3b1RBZG9MZ3h6SUhnSjlITTJZRm9aM1hSSTl1?=
 =?utf-8?B?MVg4UENIdnNFS2NtdlBkR1NtczZBQzRMWlVtUWFicFd4TGFBVzhWcUpJdnNM?=
 =?utf-8?B?YWxHa0M4NXdUNTJ4VUtUbXJ3RHZCc0lHRitVbHFOSCs0c29wRWdMblRBSjI1?=
 =?utf-8?B?aEw3MlczekNyMUF2QkNmbDd0VGdEN1pZTVROR2xvWDE5cC9GcG9pUWhlUE9t?=
 =?utf-8?B?OUg3WDl5a3pPL2k3d2llVDROTXlJekEvb0NwK2krNGkxYmZhK2ptTmpwWHhV?=
 =?utf-8?B?WWZDYk9VV1c0WEVHNitIS1Y1UE1lVlVJY0xIVFJEc1BWSDdGZ0NNUS8yRFQv?=
 =?utf-8?B?QTZsTC9aS1ZvVmhSMUFTZDRYRTRJdXBuMTdnSWNVT0dnT1hGMXNYaGdwbk8w?=
 =?utf-8?B?UkhEZzhrci9oR2dNVkVURXNER2RmRXIzb0g4QWhXem5EODZoOFVCWTFtb1ZY?=
 =?utf-8?B?SDJqMXlvcWNobzQwMUhCdHNqV0c5QjlsalBNOVRKWVlGUmhkelRtTTkzb1E2?=
 =?utf-8?B?QlpBRWFJSkozVG1GT3F4R3JGL2NPSnoyYzdYOWhFeGxST3hJdlBtN0J4bmsy?=
 =?utf-8?B?WUhRQjJHcDJmRjJrdnloWHdhQkhsemlIb01UMytVOXdKQm9PTEhJWkYxTEJu?=
 =?utf-8?B?U1J0d2M2K3NDM0VlNTZqcUVRWXdjV3R3RTJSb3ptWlVTSDVHZmw1N0U0REx0?=
 =?utf-8?B?RGZQeEpSSFZMYnhqaklDUWtRMm52Q1BuS3NuWDNpbSs1QjBUbXZOVkhGQ2Zx?=
 =?utf-8?B?aHJBcU94cGR2NitFRkMrbGRPMTJRd1RmYTk1em84TzF3cndTaXNqYTN3Ty96?=
 =?utf-8?B?aEVRZ1NxM1VXYzVLUFBZYzNQQjhXcC9DeXluVFNNU3dpNHh2a0paeXJ3SnJI?=
 =?utf-8?B?OXQyU2FLd3NnWTd0TVE4QVhURXZHTXJCMFUrUTBwUjVDOEZVU2NOOHdIcjNv?=
 =?utf-8?B?enppTmFyMWVrMEJiNmVNVUp3bElsdzlvNkZnSkxWcUdMcmcvQUNUeFJDTDYr?=
 =?utf-8?B?ek5CRHZzSHY4S2o4UUdmZHB2d1dmekE5N2hyQ1k3ejVLMktMRDMwMDlKQktm?=
 =?utf-8?B?ejdUV3QwalJNL1lDT3BxOUVuTmhmQTMyZjhVU1lRZ3FNUUpNWjNsT2U3U25Y?=
 =?utf-8?B?d1hvWm1vNmlDWlhCUGNQMFQrUzFYV0h6Z1JLWVlGVUNkR0Z6bytGT1VuRjZN?=
 =?utf-8?B?SnJrdmo0MHUyTU93VEJ1SklyTUJ1TjRYdkdxMG9PVXJGSnhCcmVGZmJLYmRF?=
 =?utf-8?B?WS9FTDZQOHZ6eUlDL0xpaDRqYmpCNHBhVjFtc1Z4S0NxdFNLRXY3NUZlQWdG?=
 =?utf-8?B?OHRRVG9zOW9INkMxLzJTOG1SVFFvRnlkWXBKYmlWUHUrMG9IeEswV2ppaUZF?=
 =?utf-8?B?MHdSZVMza2ZtKzJkTzdmdk9GUWNxdnFQSDRTUVZEdW5kaXMvSEZzOEtqRHIr?=
 =?utf-8?B?cjU5YTdhcWVlZEtIYlNhQjMwMzh0U2tkYUJ0cThUSllJWTkzMmNXVEM1SGRt?=
 =?utf-8?B?bWZ2R1QyanNOa1l2Y2dJVmNVSU5wMUV2ZDAxK29iUGhQYWoxcWoxYlFxRkZx?=
 =?utf-8?B?TW43WmJPRVc0RElyeWc0a1VBZzk4S2pYYmVrQ2VhdjZ3cHd5UXgvY1VJTmF0?=
 =?utf-8?B?cXZtdWJuRVM1OFNyRVZyUnhEYkJySFFMOHNIK3dTSW1wc3N1V241alRTZU1w?=
 =?utf-8?B?dEZNeDBvWUVBZFI1bEdkYUZjWEZ5T1JMQ3VPMDk5YlZZTE9jNU9FRENMWlls?=
 =?utf-8?Q?etCo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eC83bjFCTzVIYkp1clM3c1I4aDVRMGdFVC9CZFlCWTVkR0NUWkVHcGJYdnZH?=
 =?utf-8?B?T2xSZnliTXhubjRkN0FGU0tWTS94dTZrNk44eVU1TjlZQitIMjh0VHZFK2J6?=
 =?utf-8?B?UURZVlJnMjlLRkVoaThNbEVUV3ZZSGtVSlJnenUzT21VN1F6cjYvYlBBUkp6?=
 =?utf-8?B?Tm9TVWtKZ1ZCcXRFN1Q1SkRCeFkyT2ZKVmUrYW1JWVZqbU1PVkYvMDBYdG5W?=
 =?utf-8?B?U0NMTGpjdkgvNmJ0bWRrd1o1OUpHNG5yOGUrUUQ0cVZLZjJ6Y1BZbUtWRHdH?=
 =?utf-8?B?Mm9JdlQwaDNMQ0orVG1reG5EUGtqMkRXdkxmaUtVZmtXS2xlc282V2NCL2V1?=
 =?utf-8?B?UWEvZVRUbjhVL1dLUHRxY2Vod3EzcThrbGd4L2FJRzBvc2RRSVR1b3pic2Ir?=
 =?utf-8?B?L3hkbGttdmZLMjUzV1k2M21qaUFRQldwT3FTNEI5TFZCOGhUbkNsNS9FMDR2?=
 =?utf-8?B?TXF0SHVDbXI1WGloV2VkTVp1Vk5Sdi8xWWFVVVlweGorTWVmL0dvS1BWRHEw?=
 =?utf-8?B?NzBpeDFiZFZodTdmeVdRUDNnVDJPck1ZTDBLaExCM2lTU1ZmRm9JVFhQSjBY?=
 =?utf-8?B?aHEwVFExTFNKWCt6aUVJUUhXeXNvN29hZmk5U0dEaFM1Sk95UlZKYjQxQ01N?=
 =?utf-8?B?WWdoUVVMTWF1UGtMT2g1UUR3d2RqU2h6WEc3OFRKRkoxeUpKczRjWlAzYW9O?=
 =?utf-8?B?RzhnVHIwRGZ2WFVmR0N6bEZDWW1oQnZwNTRGYmdRL1crMDF0R3FZRUwrejBJ?=
 =?utf-8?B?U0lRR0Fzdlk3NmlXRUVjVXVPanN2S2FVQnladU05elB3K3QwVWRIVjBTRWFi?=
 =?utf-8?B?TVhMYmt4aFJTWk1VM05VWWh0ZC96WEpGd3UrWXJUUGhFQ0Q4d3gxcUZ5NTNo?=
 =?utf-8?B?bGlJS3RmUVhIR2ZjaDdPTTI2cHdQdmV3THRDQjkzMEMyNW5qSHZzUFlXN29L?=
 =?utf-8?B?d05tRGVqRmNFVkhsSWxHVWZSSkNjT0d1a2ZuNmhXMHkybm5JYzlhQWI0K3Va?=
 =?utf-8?B?V2Rsa3hub2dxeVlUb0JMTkNCVjc4eTVzWThIdmRMU2o1TEpFejJ4ZEo1U25Z?=
 =?utf-8?B?Q282cWFTZ1BlNGYyZkdlNXFRamRuR0phSUZQbjRCSzhVWURIUE15R1c4SEhv?=
 =?utf-8?B?VjJ4UlR6NXN3Vm1LVnNncThaQWNsODM5dENlNWdIQkFCMHdlM2YrdUJTbXov?=
 =?utf-8?B?ZW4wUCtoWW0yUUpxeS8rang5aUVBWHlONWp5M3ZLNkM3VVlmZE9YM3dvRWFj?=
 =?utf-8?B?bjRjU2F5aGx2azNGYlhxSGVycVRUUTRmb1F0UVExcC9laTNNcGJ6OGNSLzdk?=
 =?utf-8?B?aEp1VE01eG4vUzdsZnJmZVJPVFQ1bkg1K0hvZXhrMGZHQkVpVlk5OGhDK1hx?=
 =?utf-8?B?Y3RxK0Z0QlpyWDVuTnRaSDIwNUw5WHBqbXFPUzd4R1VwZWJNUDVSdm9lRDJp?=
 =?utf-8?B?SFdxbFlIZUN0cGJFK2IzV1cvTW1oMkQrVG1MWjlqWkpzN0x2S3NtWE81N0Rp?=
 =?utf-8?B?ZlNaV1MzbmlDU04xdjRoZHpaQ3VNQSt0SG1jVXR2STg3cFdYbm5ZRUpuMHNR?=
 =?utf-8?B?dFJqb2lkVzhyOXFBVWpiNkdDckxJZm5BNi9XVU9yYzlVSW1SNHFVTXJxcXVl?=
 =?utf-8?B?QnRzTmxWY1NtZmZiUDVJMmRhTm94V2VnVWhVVW8vU0RwOGlYZ2JnR0VrWGZB?=
 =?utf-8?B?eW5sbVpzYUxRUStHbEVWUU1NMGZaZ2VESGZFdmxuT0dQWE92SjJnc1JlQzY5?=
 =?utf-8?B?QmJpOGxlR1hmcmxRL29IYjRVRGo3YkRKSDllbWExMnpKcGV4Ry8xZlVHZk5Q?=
 =?utf-8?B?QTVMOXMwaWNFRGIxTjBqUnk5QjlEMU1HcEhQNHRJVmRNcnVQTHVScjhvSEN3?=
 =?utf-8?B?a1lOYVVxVHFyZDI0NE51ek5LRFVyajRVRHhweHEyNHE1dGpEaTh0bXRydEp0?=
 =?utf-8?B?U0tFRFZKNjhSVWJnUVVtVDNsRVl2V2NscGE2RkgrclMremdiSkFzMHpLdzVL?=
 =?utf-8?B?dml1d0lCeVlvQkhOU3p6bU8yVWo1UDJTdGwwRTkvQWVLamUrNkczQ0YwSm94?=
 =?utf-8?B?bmF4dkx2UW9jZHk1MGJpSjh3cmZVdHE4dTZJNTd3MG1jNkJWTm5YUmVyWDlp?=
 =?utf-8?B?WTBRZnBpWDk5NDR2SWNpVnF3dS9GZWQyUnJlbXJvV1BKVkVSNVBTeDB6bG10?=
 =?utf-8?B?NTUzNDljbzBYajZIUEJEZVF6U0YzdHRTdExYK0xYNS9wSDFRWXhYbyt1SjZT?=
 =?utf-8?B?QnV6dUgzck15Qm02aWRGNmJkOGhrSXBlNjFkUVJXNVVzRjBHZ3RPOEZwaTht?=
 =?utf-8?B?RmNuT0hCdElzOUdZNXJJOG1lVjNCWE45R2VPK2NqOW9Xdng1UEtQZz09?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DHx1GD2pzvd+vaX0ygmlP8das6gc+7dni/zp/+6D3lcgendPflr/SET2EXUBTZeySbNHXMXHk6k5dsD7L1GPLpU8kFSPArhq/DfAdSoFBaJSdwHbJdyPv+ByepdSejO2PAkbb1/PQxqGSZT/ku7Ynor0fpyhXR489iGNJFFxphJESa5kHA7LdzqiIZhaAHPS6nRQBcGPVXsS7janKW3wJSXy070c/h1iIuhmVKYGRX/klT05vmURdZ+W5DNdrClidPGgCF+Gr0C8zw8HUELu3JifSELbE5+LwcfSDrVSiTJRPV2+5tqprLfHHNKM8m/FBGz/0h8jWarb+COH47FGOjlKF6qXIcHdPFtqes6tcQXq5TgBrxSynGvi8lEewDzH36u4K2hKXR7ccKlR929SfgARPbqKhGFlnwgDZPFatjROpMVaPGzRDp3kh/ENGGbyuTe559Txv/egqWYi609mlkfLgGwUDeriPYU1y+PVRsKfxTsr/fGsnvbch9yQc3RP1PiDSp584fKbTZJsYCa62Er69WKoDpDmMpwFaw3KSryOJDx3iuR9P0kcijJUU6pd7tHVgfGHQ13BDeA8rHBeVCvgl89muamtrBGtSI6Z/Fw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 54cadae6-0693-45d3-0021-08de547f277d
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2026 21:43:43.5348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7/LinjR2yXY1xPgqgedvH0zUZ2NPNKqcpt6sO0WqD2aHXPrm2xicTQjHXvmtgAGaReMr4PEN8PucM7DvXt90HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB4882
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-15_06,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601150171
X-Authority-Analysis: v=2.4 cv=XP09iAhE c=1 sm=1 tr=0 ts=69695f94 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=yPCof4ZbAAAA:8 a=DsQR504YYo8ZoXaCmvgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654
X-Proofpoint-GUID: wPmr7FiRctdgcB7rvVaQ87z7ML-O1OM8
X-Proofpoint-ORIG-GUID: wPmr7FiRctdgcB7rvVaQ87z7ML-O1OM8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE1MDE3MCBTYWx0ZWRfXwxXvsjjHxalC
 3Fip6fZbRfJtf1dKlKF1dN1Jl/j81/brizfkGBmW6MGuHih2iIay9dLxsVE/6uO/6GLchpQjZA2
 phtKDO0PkjlBKqHmzAFnFR/G2h+m5tClAhvA/9Y5t1vY8sEUUv01tqpY8C6XgbEwXMim5OzL2eV
 7n2FbZl5W0BQr+PW8YHtVvVlDvxmwQiEijt1GVe7/eYgTFTE+ZB48pmyNHMOFqAcihE8T8oXyOS
 TvjJSS5ikwPKSOkEXazxNSIcVYHoX1htobxsXa96cU36F6H7JHoCSdKFfHRMFdnrcsln9W9ecjy
 9k05E+2q2elzSC2Imf701Rxdws4eU8jroh0WATG7yAZW1/IcD0YpSuDNMCW0Sg0sy01vz7/B2gi
 j5M+8ALYDbsLIBByGaBqfWAZ6++eG5NjT6+COUXH3U6UOejmmPviQ+ff71nFAq+NNT5u6dSm351
 RyJm8n447mWoeu8ZVbKUVZB59+REqEedA4W+8pYU=

On 15/01/2026 19:11, Alan Maguire wrote:
> On 15/01/2026 18:55, Marco Elver wrote:
>> On Thu, 15 Jan 2026 at 19:36, Alan Maguire <alan.maguire@oracle.com> wrote:
>>>
>>> On 15/01/2026 17:50, Andrii Nakryiko wrote:
>>>> On Wed, Jan 14, 2026 at 10:38 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>>>>
>>>>> We see identical type problems in [1] as a result of an occasionally
>>>>> applied volatile modifier to kernel data structures. Such things can
>>>>> result from different header include patterns, explicit Makefile
>>>>> rules, and in the KCSAN case compiler flags.  As a result consider
>>>>> types with modifiers const, volatile and restrict as equivalent
>>>>> for dedup equivalence testing purposes.
>>>>>
>>>>> Type tag is excluded from modifier equivalence as it would be possible
>>>>> we would end up with the type without the type tag annotations in the
>>>>> final BTF, which could potentially lead to information loss.
>>>>>
>>>>> Importantly we do not update the hypothetical map for matching types;
>>>>> this allows us to match in both directions where the canonical has
>>>>> the modifier _and_ when it does not.  This bidirectional matching is
>>>>> important because in some cases we need to favour the modifier,
>>>>> and in other cases not.  Consider split BTF; if the base BTF has
>>>>> a struct containing a type without modifier and the split has the
>>>>> modifier, we want to deduplicate and have base type as canonical.
>>>>> Also if a type has a mix of modifier and non-modifier qualified
>>>>> types we want it to deduplicate against a possibly different mix.
>>>>> See the following selftest for examples of these cases.
>>>>>
>>>>> [1] https://lore.kernel.org/bpf/42a1b4b0-83d0-4dda-b1df-15a1b7c7638d@linux.ibm.com/
>>>>>
>>>>> Reported-by: Nilay Shroff <nilay@linux.ibm.com>
>>>>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>>>>> ---
>>>>>  tools/lib/bpf/btf.c | 35 ++++++++++++++++++++++++++---------
>>>>>  1 file changed, 26 insertions(+), 9 deletions(-)
>>>>>
>>>>
>>>> Alan,
>>>>
>>>> I do not like this approach and I do not want to teach BTF dedup to
>>>> ignore random volatiles. Let's either work with KCSAN folks to fix
>>>> __data_racy discrepancy or add some option to pahole to strip
>>>> volatiles (but not by default, only if KCSAN is enabled in Kconfig)
>>>> before dedup (and thus we can't do that in resolve_btfids,
>>>> unfortunately; it has to go into pahole).
>>>>
>>>
>>> Okay, I think the former would be the better path if possible; cc'ed Marco
>>> who introduced __data_racy with commit
>>>
>>> 31f605a308e6 ("kcsan, compiler_types: Introduce __data_racy type qualifier")
>>>
>>>
>>> ...and Bart is already on the cc list. Feel free to include anyone
>>> else who might be able to help here.
>>>
>>> The background here is that in generating BPF Type Format (BTF)
>>> info for kernels we are hitting a problem since a few structures
>>> use __data_racy annotations for fields and these structures are compiled
>>> into both KCSAN and non-KCSAN objects. The result is some have a volatile
>>> modifier and some do not, and we wind up with a bunch of duplicated
>>> core kernel data structures as a result of the differences, and this
>>> creates problems for BTF generation.
>>>
>>> Perhaps one way out of this would be to have an unconditional __data_racy
>>> definition specific for struct fields
>>>
>>> #define __data_racy_field       volatile
>>>
>>> ...and use it for the two cases below?
>>>
>>> By having that defined regardless of whether KCSAN was enabled or not,
>>> and using it for struct fields (while leaving variables intact) we
>>> can sidestep the problem from the BTF side. Would that work from the
>>> KCSAN side and for the fields in question in general?
>>>
>>>> Furthermore, it seems like __data_racy is meant to be used with
>>>> *variables*, not as part of *field* declaration ([0]), so perhaps it
>>>> was a mistake to add those to fields. Note, there are just *TWO*
>>>> fields with __data_racy:
>>>>
>>>> include/linux/blkdev.h
>>>> 498:    unsigned int __data_racy rq_timeout;
>>>>
>>>> include/linux/backing-dev-defs.h
>>>> 174:    unsigned long __data_racy ra_pages;
>>>>
>>>
>>> Not sure, the original commit above gives a struct field annotation
>>> as an example. Anyway hopefully we can find a workable solution.
>>
>> By "KCSAN enabled or not", I assume you mean in KCSAN kernels only? We
> 
> I should have clarified this, sorry; I meant _within_ a KCSAN kernel where
> some objects opt out of KCSAN with KCSAN_SANITIZE like
> 
> KCSAN_SANITIZE_slab_common.o := n
> 
>> should _not_ define __data_racy as volatile outside KCSAN kernels, as
>> that's not what __data_racy is for and would have other unintended
>> consequences. KCSAN just knows to treat "volatile" specially, which is
>> why it's used like it is here, but otherwise explicit volatile
>> variables are a no-no in general.
>>
>> Right now we have this in include/linux/compiler_types.h:
>>
>> #ifdef __SANITIZE_THREAD__
>> ... other defs that should remain untouched ...
>> # define __data_racy volatile
>> #else
>> ...
>> # define __data_racy
>> #endif
>>
>> But perhaps that should be moved to a separate #ifdef block:
>>
>> #ifdef CONFIG_KCSAN
>> # define __data_racy volatile
>> #else
>> # define __data_racy
>> #endif
>>
>> ... with an explanation why (consistent definitions across
>> instrumented and uninstrumented source files), and why it's benign for
>> uninstrumented code in KCSAN kernels (behaviour unchanged, but subtle
>> performance loss, although it's an already instrumented kernel so
>> performance is moot anyway). I think that should work, but it needs
>> some testing.
>>
>> Could you test something like that?
>>
> 
> I'm pretty sure that would work; let me try it out. Thanks!
>

yep, the below change resolved the problem. I can submit it with a
Suggested-by: from you if that works? Thanks!

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index d3318a3c2577..86111a189a87 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -303,6 +303,22 @@ struct ftrace_likely_data {
 # define __no_kasan_or_inline __always_inline
 #endif
 
+#ifdef CONFIG_KCSAN
+/*
+ * Type qualifier to mark variables where all data-racy accesses should be
+ * ignored by KCSAN. Note, the implementation simply marks these variables as
+ * volatile, since KCSAN will treat such accesses as "marked".
+ *
+ * Defined here because defining __data_racy as volatile for KCSAN objects only
+ * causes problems in BPF Type Format (BTF) generation since struct members
+ * of core kernel data structs will be volatile in some objects and not in
+ * others.  Instead define it globally for KCSAN kernels.
+ */
+# define __data_racy volatile
+#else
+# define __data_racy
+#endif
+
 #ifdef __SANITIZE_THREAD__
 /*
  * Clang still emits instrumentation for __tsan_func_{entry,exit}() and builtin
@@ -314,16 +330,9 @@ struct ftrace_likely_data {
  * disable all instrumentation. See Kconfig.kcsan where this is mandatory.
  */
 # define __no_kcsan __no_sanitize_thread __disable_sanitizer_instrumentation
-/*
- * Type qualifier to mark variables where all data-racy accesses should be
- * ignored by KCSAN. Note, the implementation simply marks these variables as
- * volatile, since KCSAN will treat such accesses as "marked".
- */
-# define __data_racy volatile
 # define __no_sanitize_or_inline __no_kcsan notrace __maybe_unused
 #else
 # define __no_kcsan
-# define __data_racy
 #endif
 
 #ifdef __SANITIZE_MEMORY__



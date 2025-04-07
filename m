Return-Path: <bpf+bounces-55400-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 15EF9A7DF8E
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 15:39:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95A70188AB3E
	for <lists+bpf@lfdr.de>; Mon,  7 Apr 2025 13:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C97217A302;
	Mon,  7 Apr 2025 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JgSkxUWT"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2066.outbound.protection.outlook.com [40.107.220.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73CE51531E3;
	Mon,  7 Apr 2025 13:36:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744032968; cv=fail; b=r2C4M8VuFr9wZCt6ZNmTkUUFXeVxYDAB0sm5rIZOwAbDAnshpN1FE+Wf6VWTTsAOtkRXiLcsHMJ0Pn80Yh1nC5wEMtkAc0X22SUcy95/cZ32IC5syra17snONBLO7/dMgOQD1eVIbdnalpVJs16DPaq1j0xhBCVVGUU+RAtT4CU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744032968; c=relaxed/simple;
	bh=U0SAqfjESFuLndANzL5DABQoqntvULwgLiMsn67Wro8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Lgi+VFsP/Wu+RPMqexqYLJulWcDdfHNFsdsZL+BDSxtc2bj74gklJdEF4og/JFMUgDg/sSZpCoAp1T2qfyLq0pGOxdvHd8GKPC/2vdJRvHfXuioTEm0FIDzMLXwXQLxTwUFFUQ6t6eraHllrn9My9FDhId9wYOSYaraTY8LDj6M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JgSkxUWT; arc=fail smtp.client-ip=40.107.220.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J/g2rVyJT/JFlar2Xt1qzTQDktMONTtd22Nx/rhCEJDvrk/jKEM6hFbGsmfQ7lSiBQtYPzjK/WabEtw7VsHG+CfA+3NpRNd7cptMOwgFHEq5Ui3srITBy5+sM8ZEqSQjw+F1qBUISvglkgm+TMdwbEe5geqYNlXVL5EUIHNXXALX0Xp9kfm6QzzFtuZXxCHLNMvuKuCWjDTTyOOfOLj8fKmv4ozQcSqzcASJdUp8qAiUDce9DSeFkygjBKM2h+h34PqHcW58uTlbGTYjSeQhY15Eqv7GURczLLbTGAyZ4DqARAFz76Ix3NBYBPOb95J4RFupffQcHx3lgBrhW+sWOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w/vf4szwjjcvdYhf+hpDb7GYDAyUNze446LOIT5xxv4=;
 b=FmJVgBpBfud094RVYjWbmUWeU3Ez0AO+9FNUoNhoY2nsRIAQ5Te0V1eIhiBR0hhYKjZBbQehWe6sRhNTVGvPO7zIFalXnUdfXl1dRynEYj3vgSg76LtZ/eHGjf53ozOaqijvuC+KczjyqYJ6TqWgu/0JsoFGEHmW96sCuZnaT0fx9sefjhPAc7y8rvwRExQv+DqD4NE8vI2HNL5zatDe9d6a6o6goYl/CLO9myV9HLwy7cri93/e4FK0yJ70dmgVCZRBcufTnZyICOMuTRSwvVOqcLxs/jgcPPvwZFRugODnLwfIQh4+GFd1FFC27FBFDns/pDASGaw9zFgPCyljgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w/vf4szwjjcvdYhf+hpDb7GYDAyUNze446LOIT5xxv4=;
 b=JgSkxUWTcvCxtK3/kbOezvZTQVv9D1B6WbPXqLQQXdt7aWq4n8mLDxA+jUg9HxxiPIimT9b5WgJpiStbn3gkpK6k07pRGUe2pibYUuHfD4nbtzlQQ533m25STQQvD5bUPilhcSHHZ6TgZRzOEvrs2+5zN7n67ZsODSWS3gqn85nlyBKBym28PZtvHctp+HUY7Nbb0dKP3qvV8gkdfaoSowOpmz9J+hLaEnEGrLxpgVLSxDLmq0W9ZLjSDIempcHcSXoRojGbtrjQQvOn1x+dluaATC1IOi+n6EQPIpj5qeBnLbu+tqXpbbgR55X8QtoyDT/WI8xngZ2vLZRZUdOfFA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 MW3PR12MB4428.namprd12.prod.outlook.com (2603:10b6:303:57::15) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.34; Mon, 7 Apr 2025 13:36:03 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8583.041; Mon, 7 Apr 2025
 13:36:03 +0000
From: Zi Yan <ziy@nvidia.com>
To: =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Simon Horman <horms@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
 Mina Almasry <almasrymina@google.com>, Yonglong Liu <liuyonglong@huawei.com>,
 Yunsheng Lin <linyunsheng@huawei.com>,
 Pavel Begunkov <asml.silence@gmail.com>,
 Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
 bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH net-next v7 1/2] page_pool: Move pp_magic check into
 helper functions
Date: Mon, 07 Apr 2025 09:36:01 -0400
X-Mailer: MailMate (2.0r6238)
Message-ID: <E9D0B5C7-B387-46A9-82CC-8F29623BFF6C@nvidia.com>
In-Reply-To: <87v7rgw1us.fsf@toke.dk>
References: <20250404-page-pool-track-dma-v7-0-ad34f069bc18@redhat.com>
 <20250404-page-pool-track-dma-v7-1-ad34f069bc18@redhat.com>
 <D8ZSA9FSRHX2.2Q6MA2HLESONR@nvidia.com> <87cydoxsgs.fsf@toke.dk>
 <DF12251B-E50F-4724-A2FA-FE5AAF3E63DF@nvidia.com> <87v7rgw1us.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: MN2PR16CA0018.namprd16.prod.outlook.com
 (2603:10b6:208:134::31) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|MW3PR12MB4428:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ccf8f1f-77eb-4f87-52f3-08dd75d92450
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eGNRTUhiMGxuR2U3QjZDbGVLZEFROHMwSkZsalN0cUhPTGs4NlUyKzUxbEZ5?=
 =?utf-8?B?MW9NcWx3aDJ4M3N4VnNVQnNxNFhUOW5xR2N1cjcyWFlIQ1pXVGxzTXpwbTJP?=
 =?utf-8?B?blg5TzRiMk40dXNrcmV1QUtEVU1wNG91NDVkZm1wdU95N3drWGVDUldDdWlj?=
 =?utf-8?B?VElobExLbnBlMVBHQ0hvakpkbzgrczR0d2ZwcjZESko2eEQydVZhbnNWTHhr?=
 =?utf-8?B?SE44TVB0Zk5LZ2RYaXcrcVZDV01LamQ5eGhzVHVsQ2wzc1JOUWxpcFZXNUda?=
 =?utf-8?B?K0kwcnB2SnNMdVNwYU9RR1didUpaT1RzQWJvYU41TEY2RlZLc1MwZERrcnQy?=
 =?utf-8?B?VnVVYnRNSDZSVVBFblRyaVlTMlpPK1RVbVFsWkZ3dkpxVWw5cDlRWXAydVpF?=
 =?utf-8?B?ZkFqQnpPeTYrT0hUcFZ4YmwvNCtnZTJtNm9CQXY2ckFqdDlnVUd5b2JNRjNy?=
 =?utf-8?B?elVkQ245UXVWOExXajk3bVN3cUNEV2hCM3dmUktRVWZiM1U3RFFwTmRNN2tv?=
 =?utf-8?B?NjRpS0RZZnBMZmd2S2dLUjdIQXVyUkxjNG55YVRkcFp5d3ZuWkltaVRTcEJq?=
 =?utf-8?B?TmdLTkJ0dGtpNFZLbHdVZmkrRjRCM28wMTdibEI1V1M5YlJBN3pwMjF1Tis5?=
 =?utf-8?B?MzFpbHFySzVZTlFTK0laNExzT3BoRUprUUtvWjZoNWZnK2tUUGRmdWVnREJj?=
 =?utf-8?B?RmRqc1pHbldrRXlMQVd4NlVqK1pGMktSUVowM2RLS1o5NjJrQ1JaQjRVaHRG?=
 =?utf-8?B?TktZdDBQd1Y5dzdrVGYzWmVOanVsbVMzaWdpcGlhczBzb2gzQ29GNFBrdGUx?=
 =?utf-8?B?K25UcE9lWkdOdVIxRnNHRXFLNHN3Vzl1dVZvVDk0dmhLL1lvaFoxNkRKS2g4?=
 =?utf-8?B?L0JSejlpd1FoZE5YTUpZLzRBZGQ5MFRKUjFEOTYxUVpyUTk2bjFNUzkvNkNv?=
 =?utf-8?B?V3Z4MUpHbnlCZHZFalZBLzNvVkhDQnI3QkZNZ1J2RXkvZFdLRjJ0MnhZdGNW?=
 =?utf-8?B?SjFzbWg0d3NlYnAyTXRtM0t4dFR3d2I3Sm9iUDFwYUR4L0VRbzVKNlRwSDRL?=
 =?utf-8?B?THkybGUveHA2alhmNGdZT0xSQ2RqNHhzSkFNMFAwWHFCTjNOQm5LWGNvbGhj?=
 =?utf-8?B?WTZ0b3BVdC9jWTJQR3luMFhXK2FoRnlhUUJEVVBLVnFXTUhUc0Z5WUdQVXd5?=
 =?utf-8?B?OU1jcFFvSGVORmJSN2lLUExxMmE1UlBSbUc3U29MYjFmQjdDOUtNYzgvWWdI?=
 =?utf-8?B?YjFxVzdVaUxUUFpOYStSYzhuK1hjaXljNEhMOE4xcEw3MjJKUFBsY1VTWmNW?=
 =?utf-8?B?TzVYT3NrVjJBNVk3TDRCd25oc2E5cWYwcXdVVjQxdVM3Ny9COWlGQ1RGSjF4?=
 =?utf-8?B?RVdsL3VRQ3hXYlJ3L0kzVWNBNHkzTlUwV0lpVmxuSklnRnBLQjJzZ0pqU28z?=
 =?utf-8?B?aHlnbFZrMG9oRVR2Rm52VGhXWEhTUTdMMnBGSnV5Y1VCL3pVdlpmSnhlLy9N?=
 =?utf-8?B?Yk9Zc2VKS1MxT1JBeFNpWUVjMlNQNXhqSk1nd1dwOU9qcEZsWUxoa2hkQnJH?=
 =?utf-8?B?cEluaXd1SHFuSHJ5eHJTc3IvRU9FclR5Y0o0TlUxZ1BvQ3RnTXk4TWhOcThs?=
 =?utf-8?B?OVF6OFVLU1o0MFNDVEE3QW1TV1FXOTdnZjBtOGZORUZUMm1OaC9yd2VBaE9G?=
 =?utf-8?B?bkpPc3cwY3hGaDlWcjhzajJ1cTRJaXQ1Z3ZQWlR0bEF5WlFTTW93Slp6Mk9x?=
 =?utf-8?B?b0hVYllYOG5yQTVDT1VHS1Q4QzJ5Um1RK1pKR29QdmJoeDl5UEVuRGkxV0J1?=
 =?utf-8?B?TGhVdlZOUHBGWXRGSS9YNWI5NTRsWkJGTFJRdGtnMkdIa3JLVk1RcG5QaXRL?=
 =?utf-8?Q?7ipM9h530mA/F?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SUZ2ZnYvb1BpQlk0QiswRk4xeGZxNE1zTkNXcGkrZ0Jwc3hxWVVmT2pNS1Jx?=
 =?utf-8?B?VjFhNVhReEZQcVRHWDIzWFMxeDZabmJsZnZDU3hFMHhkczU0cTlyeGZiUXlY?=
 =?utf-8?B?aURXL3Brd1AxNTcxK1F5Yk1qdDY3QUhIeGcralJmV1lyNFprL2hFeWVrVzBJ?=
 =?utf-8?B?R3EwZ1cyQ1JPUTYrb2JEaEJ3Vy81aEMzSHgrckIzK0NRTVVNcjk5a0dRVkJI?=
 =?utf-8?B?M3NFSmNJQXpZNis0a2VvQzBJQkplOTRDaThxVnBMQ2ptM1B2TU9rN2ZrYVJ5?=
 =?utf-8?B?OHVITTNoL2ZSQTdRMnNMbW1tUWFJc0F1bHA1ci9RMnQ2UXFwM1RqaWU3K3N1?=
 =?utf-8?B?WnJCNzJyeHVYMUJPblFmTmxzQzVycGVTU0sycnVKZ0ZVbEIrQS9wd3V2TFNl?=
 =?utf-8?B?QVVZSXlNc01zd21HWlZnVDJtdXF1RnBoODNLVGNjMERNVGRXeXprQU4yZWRK?=
 =?utf-8?B?ZEtJd0FuSUkzNThXYm4xeDI1d1V5cUhxMENXZ2YrdG1FQWV4R2RvWEpYTzEy?=
 =?utf-8?B?MnRaWkpnQnlxUXVkTmM1Z2pxOHpsUHR4bUZ1VEthY1BYOXRMWVFveVhsYXhU?=
 =?utf-8?B?UGpyODVKamZYWnU4WENRK3M4VXFtek4wV01iS2xSWjY4SSszakRnS1pyWDhB?=
 =?utf-8?B?L1lyS1hIWC82L1FZYkNOVFh0RHBmbndyRWlRZmp4REk3am5qZG5NNTBXQzlk?=
 =?utf-8?B?ZkpFVHhIZXNRaVI0UDhUdDNuelplQzVJTEJxdSt0YVkwUDVtclhZMkMyeUU4?=
 =?utf-8?B?R0dTQVJFUVRkaElKODcvVGdJTnJQM1pIdSt1OXVXYiszVHNBWm5tdWxBcEFh?=
 =?utf-8?B?L2NaUUE0eWRyWXB1VVBVSzRoRE9JWFdSaTQxSldaMXlELzJBbTFvL2p2OEtt?=
 =?utf-8?B?WWFtRFhRTTRjQndsN1NIWm0wVkhaTm4rMWZIMjBRY0RQWnQxVGVsMm1uNG1K?=
 =?utf-8?B?bkpvMENxS1ZLWGk5d3dlQTdMMTRVcGVzVUNlQlNXRHI3UzI0Vk5qcmNOUlpq?=
 =?utf-8?B?K3pTekFuMmpLZ2hJY1ZEelAybGlsUFY0NEhjdEVoNFcyN0VBQXRuWTY3OUhx?=
 =?utf-8?B?Mnp0OW43YjBTQjJkVTMvMTViT04vcnZ3QjFSNnJXZ0NqVzRRaTZzdHVVcHlT?=
 =?utf-8?B?Z3l5bThYTWx3YmMvbWtSaDFtWmVwTFZiR0lUdGpCZjRhalI1emphYWVzL0Fo?=
 =?utf-8?B?QTVNOFpkOG02aXZRMmZBZFE0TDdpZE44RnRYZkVSQytsbmRxL2lLRE5ENHdo?=
 =?utf-8?B?V0lnMGtoQ2JoZlhhaVArcS9ock1xbTFTcTBlSEZtMzVIZklsaXQwK3NBVUcv?=
 =?utf-8?B?T3RSMGZCb2pPZ0VCek5kQ0FCVE1abmRkNVNJYUlKdDZaOUl0SUU2NVk5aDRQ?=
 =?utf-8?B?TUdzbHZIOG5yTDZ0TnhldFJtTk0yT3JrTHpkcERGcWJZNkZhVjFSU1Uxc3du?=
 =?utf-8?B?bjRYMTM0Zmo4SFRJWW1mdVJGSi9NUjRQeTlxU09WSnZqSDdzWWhydGZzNXhW?=
 =?utf-8?B?QkphSVNvOWd4SWlZcHZ6VE1zNlpSb1FtQlh5UndxbnNUZGtyNWFjNUNFUUlM?=
 =?utf-8?B?Q0JKeU5zeFBYRU1WLys1M0ZyVUwzU0VVaWoyVm1kWWE1Sm1DL0NZc1d6MnIy?=
 =?utf-8?B?emtVSldaZ3dxK3FTVGtYeGR6OHJDNFFlQkRkdkY5d0tRWVpUMnhHSWtGMlNH?=
 =?utf-8?B?Y3J1SDBDY1BzRDVZbjF5ZmZJUDU2N3ZSbk1IakhrbFhKaVRkaGFMR3BIWkRM?=
 =?utf-8?B?alNpQ0d5eGg5ckk0WlQ4MHZ3SG1IakdqL0UwdWlWSm5GeFFUTjVKc0JEWHU0?=
 =?utf-8?B?RkN4andlM1F0bXBTOEpWUk5iUmlrKzd6MFBRRGM1cE1LQzVaemErZG9MckxY?=
 =?utf-8?B?blNqL1Y1YU1jaUo0Z2xGejhtclZLaVhSNWxCaFdNTmhrbFl1S0pPZlg2c3J3?=
 =?utf-8?B?cjVSdGlyb1JDZU54WGxoUXlCaVU4SFRzOFpTWXhyWWFNb0g3Qm5XMU84QWhw?=
 =?utf-8?B?dXF5ZnNjTnNCbXdYLzNGQWx0N0hYOTJLaVg5ajUzUW9rdklac1JNQ3ZHYmdk?=
 =?utf-8?B?QkxBaGxoK2lBU2xyVFVpY1VPeFd4VkFyODVNajZZaTBaM1A5RTRERm9yRk4w?=
 =?utf-8?Q?Qrf7DA9oG56pPTxgtZi/1DlVB?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ccf8f1f-77eb-4f87-52f3-08dd75d92450
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2025 13:36:03.6135
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a5x7l3Z8A7n/nwIPUTHZ0m9M4flXZ3y2u5XdqxoV2LwGSypHVfKzOXgiL0pRc3uC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4428

On 7 Apr 2025, at 9:14, Toke H=C3=B8iland-J=C3=B8rgensen wrote:

> Zi Yan <ziy@nvidia.com> writes:
>
>> Resend to fix my signature.
>>
>> On 7 Apr 2025, at 4:53, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
>>
>>> "Zi Yan" <ziy@nvidia.com> writes:
>>>
>>>> On Fri Apr 4, 2025 at 6:18 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen wr=
ote:
>>>>> Since we are about to stash some more information into the pp_magic
>>>>> field, let's move the magic signature checks into a pair of helper
>>>>> functions so it can be changed in one place.
>>>>>
>>>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>>>> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
>>>>> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
>>>>> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>>>>> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>>> ---
>>>>>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>>>>>  include/net/page_pool/types.h                    | 18 ++++++++++++++=
++++
>>>>>  mm/page_alloc.c                                  |  9 +++------
>>>>>  net/core/netmem_priv.h                           |  5 +++++
>>>>>  net/core/skbuff.c                                | 16 ++------------=
--
>>>>>  net/core/xdp.c                                   |  4 ++--
>>>>>  6 files changed, 32 insertions(+), 24 deletions(-)
>>>>>
>>>>
>>>> <snip>
>>>>
>>>>> diff --git a/include/net/page_pool/types.h b/include/net/page_pool/ty=
pes.h
>>>>> index 36eb57d73abc6cfc601e700ca08be20fb8281055..df0d3c1608929605224fe=
b26173135ff37951ef8 100644
>>>>> --- a/include/net/page_pool/types.h
>>>>> +++ b/include/net/page_pool/types.h
>>>>> @@ -54,6 +54,14 @@ struct pp_alloc_cache {
>>>>>  	netmem_ref cache[PP_ALLOC_CACHE_SIZE];
>>>>>  };
>>>>>
>>>>> +/* Mask used for checking in page_pool_page_is_pp() below. page->pp_=
magic is
>>>>> + * OR'ed with PP_SIGNATURE after the allocation in order to preserve=
 bit 0 for
>>>>> + * the head page of compound page and bit 1 for pfmemalloc page.
>>>>> + * page_is_pfmemalloc() is checked in __page_pool_put_page() to avoi=
d recycling
>>>>> + * the pfmemalloc page.
>>>>> + */
>>>>> +#define PP_MAGIC_MASK ~0x3UL
>>>>> +
>>>>>  /**
>>>>>   * struct page_pool_params - page pool parameters
>>>>>   * @fast:	params accessed frequently on hotpath
>>>>> @@ -264,6 +272,11 @@ void page_pool_destroy(struct page_pool *pool);
>>>>>  void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect=
)(void *),
>>>>>  			   const struct xdp_mem_info *mem);
>>>>>  void page_pool_put_netmem_bulk(netmem_ref *data, u32 count);
>>>>> +
>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>> +{
>>>>> +	return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>>>>> +}
>>>>>  #else
>>>>>  static inline void page_pool_destroy(struct page_pool *pool)
>>>>>  {
>>>>> @@ -278,6 +291,11 @@ static inline void page_pool_use_xdp_mem(struct =
page_pool *pool,
>>>>>  static inline void page_pool_put_netmem_bulk(netmem_ref *data, u32 c=
ount)
>>>>>  {
>>>>>  }
>>>>> +
>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>> +{
>>>>> +	return false;
>>>>> +}
>>>>>  #endif
>>>>>
>>>>>  void page_pool_put_unrefed_netmem(struct page_pool *pool, netmem_ref=
 netmem,
>>>>> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
>>>>> index f51aa6051a99867d2d7d8c70aa7c30e523629951..347a3cc2c188f4a9ced85=
e0d198947be7c503526 100644
>>>>> --- a/mm/page_alloc.c
>>>>> +++ b/mm/page_alloc.c
>>>>> @@ -55,6 +55,7 @@
>>>>>  #include <linux/delayacct.h>
>>>>>  #include <linux/cacheinfo.h>
>>>>>  #include <linux/pgalloc_tag.h>
>>>>> +#include <net/page_pool/types.h>
>>>>>  #include <asm/div64.h>
>>>>>  #include "internal.h"
>>>>>  #include "shuffle.h"
>>>>> @@ -897,9 +898,7 @@ static inline bool page_expected_state(struct pag=
e *page,
>>>>>  #ifdef CONFIG_MEMCG
>>>>>  			page->memcg_data |
>>>>>  #endif
>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>> -			((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE) |
>>>>> -#endif
>>>>> +			page_pool_page_is_pp(page) |
>>>>>  			(page->flags & check_flags)))
>>>>>  		return false;
>>>>>
>>>>> @@ -926,10 +925,8 @@ static const char *page_bad_reason(struct page *=
page, unsigned long flags)
>>>>>  	if (unlikely(page->memcg_data))
>>>>>  		bad_reason =3D "page still charged to cgroup";
>>>>>  #endif
>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>> -	if (unlikely((page->pp_magic & ~0x3UL) =3D=3D PP_SIGNATURE))
>>>>> +	if (unlikely(page_pool_page_is_pp(page)))
>>>>>  		bad_reason =3D "page_pool leak";
>>>>> -#endif
>>>>>  	return bad_reason;
>>>>>  }
>>>>>
>>>>
>>>> I wonder if it is OK to make page allocation depend on page_pool from
>>>> net/page_pool.
>>>
>>> Why? It's not really a dependency, just a header include with a static
>>> inline function...
>>
>> The function is checking, not even modifying, an core mm data structure,
>> struct page, which is also used by almost all subsystems. I do not get
>> why the function is in net subsystem.
>
> Well, because it's using details of the PP definitions, so keeping it
> there nicely encapsulates things. I mean, that's the whole point of
> defining a wrapper function - encapsulating the logic :)
>
>>>> Would linux/mm.h be a better place for page_pool_page_is_pp()?
>>>
>>> That would require moving all the definitions introduced in patch 2,
>>> which I don't think is appropriate.
>>
>> Why? I do not see page_pool_page_is_pp() or PP_SIGNATURE is used anywher=
e
>> in patch 2.
>
> Look again. Patch 2 redefines PP_MAGIC_MASK in terms of all the other
> definitions.

OK. Just checked. Yes, the function depends on PP_MAGIC_MASK.

But net/types.h has a lot of unrelated page_pool functions and data structu=
res
mm/page_alloc.c does not care about. Is there a way of moving page_pool_pag=
e_is_pp()
and its dependency to a separate header and including that in mm/page_alloc=
.c?

Looking at the use of page_pool_page_is_pp() in mm/page_alloc.c, it seems t=
o be
just error checking. Why can't page_pool do the error checking?

Anyway, if you think the patch is the right thing to do, I would not object=
 it.

--
Best Regards,
Yan, Zi


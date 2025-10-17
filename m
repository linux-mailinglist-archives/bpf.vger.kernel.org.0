Return-Path: <bpf+bounces-71203-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6830BE912C
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 15:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B3633AB14B
	for <lists+bpf@lfdr.de>; Fri, 17 Oct 2025 13:56:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A731369965;
	Fri, 17 Oct 2025 13:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TriSUo7U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Pj/sHrM2"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49C20231C9F
	for <bpf@vger.kernel.org>; Fri, 17 Oct 2025 13:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760709390; cv=fail; b=Cdq/N0lVlqGgRBCrMnTUZw3fypZ6w/Pq/U/bw8T+u+lFal0eKCcAk2FBboe8gqovjtSe7wnoDjiQ996oXYMUSxc7f03pmkLzDjPyRJ5vHWrq/OOiiiZgX9/BAbnxdQwqJzUJ6xYS9TWShXuhBfJbxyAu1mCxnsf87YykMwctiLw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760709390; c=relaxed/simple;
	bh=Q4Z8xU5t+oE52NvTbqcCIqfX53zPyBt+tE9FQd2RI1k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GA64E6+q+Ryr0vP7J/bqtMxWTLQgyUGlYBjzfWfMgw7Sv2nZkF4fFnUvdjQoICVZdCte04FpD3c3USLi8wQ7EbHV++CPXhz+b+foqiv6+RWydNvpvnK31GksXm3wEFgk38L+ty4PRJIWq10jv1SwbIB8k20J1Ian8k9qXhdC3QU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TriSUo7U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Pj/sHrM2; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59HCdixx019553;
	Fri, 17 Oct 2025 13:55:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xmAWzNpUFbQwI887951hC7Seatia2fOw3Sk07M/kxnI=; b=
	TriSUo7U0vEY79wxQcg13waEFCzqVIVJgIulm3adwQx8tf5Co2tR6R8cWXZJmfSW
	jfiEVsI2jyL7G0MJ5fNAPzB31XumGnqlNdnaWTEqNEg9w+jBYiDnBOMiRDYK7PyG
	I+qC8FREYWZDkFnFkgnDk1gc1zc30PflVRLQkLRE4bhY/nG40na9dim7DF88R1UA
	ctZbITOwpsuTYogUOJnGB081q05L7noptdX4Cov/rVnBt3sikgAQp2q7B0Ti7mRe
	62CUIY/i13yQG70BDTrlHDz0Wfh/mvu7X6ZYzeJnXemcE+a4BhoxAegMbJjbi+q4
	WUSoFScKceEIV/zqqwmOTA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qe59k14g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 13:55:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59HBl5OE002300;
	Fri, 17 Oct 2025 13:55:56 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013014.outbound.protection.outlook.com [40.107.201.14])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpk3uf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 13:55:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K0C6oRG7F1InQryzykbjmXSoQqrQWTr0FS27ltrdYQWGZFTqGcjpF+jrkBRXL2EzYsxELezCdcrdP3vjjm3ykiovI8QqWKnYHdJj3vkgC2m3f82vCuz+NOEZdJYQhetM3kTRX3TFRnglZOsJy8x3RFhml3sfdlQNK64cT8DnqburWU4v7Ovgr86zQBaowycXvXb4CfeoDHJ+FWKbDZ3dV/dt2uAYaZVIeFPbSAp92L6FsUe/RjRrUiY1SrjQYMjbyscfZrg3xdmR9np8SW2H0qws3LBeCQtN9jweFBHJOPbvSd/iWSXi8uFXyvg0r6lEb/SGRx4kxT11bEkH1bvRKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xmAWzNpUFbQwI887951hC7Seatia2fOw3Sk07M/kxnI=;
 b=pkDjWHJg90oAiRTDGMj+rbvfdES3/9qgfy91e7ldf2LerWj4eaCT70x+Z5Loxyujpvwul6C7RDN+0nZWZ72FnGzQRJqNo+aAdg83HlHTHLbwVe4ggfkh6U+OThPbF/tssJ5DQ8FOfwrUz7ZNn2M1+FLvXQRXx5JyazHBbrUC6uK7U8yEug2jp6p982n60dWF36mLTuhI5VzCcccHpF12tYHhnuBKrTje9lxgIDaME8CKnd4pnpXvY+Rr6dqiSdeLL4/sMlcoVqUi0U+T2Q4aOSejdWtlb6cLE8wKCyYILa+NQNE2fogNod37nXdDYTQqHRQboqTVQe4bhmGB9zhH8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xmAWzNpUFbQwI887951hC7Seatia2fOw3Sk07M/kxnI=;
 b=Pj/sHrM2zGeXs0nN9UE0FeZ3E4xgtqjIoD+IZL92LKySP3jL+os+UaDMwQb97jIOB8XmSK+XksIDfy/1kC3hxJl2vC1asZTOU+l3XOGHugZUa3w37d9/ifwcpqunjicqESms7va2A8cXRuz4JjkAo2qDw7BMC7x/JoFTUKojhrc=
Received: from DS0PR10MB6271.namprd10.prod.outlook.com (2603:10b6:8:d1::15) by
 DS7PR10MB5927.namprd10.prod.outlook.com (2603:10b6:8:85::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.13; Fri, 17 Oct 2025 13:55:53 +0000
Received: from DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c]) by DS0PR10MB6271.namprd10.prod.outlook.com
 ([fe80::940b:88ca:dd2d:6b0c%7]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 13:55:53 +0000
Message-ID: <2a39ed60-9335-429a-9b28-1ee189022e5e@oracle.com>
Date: Fri, 17 Oct 2025 14:55:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC bpf-next 13/15] libbpf: add API to load extra BTF
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, acme@kernel.org, ttreyer@meta.com,
        yonghong.song@linux.dev, song@kernel.org, john.fastabend@gmail.com,
        kpsingh@kernel.org, sdf@fomichev.me, haoluo@google.com,
        jolsa@kernel.org, qmo@kernel.org, ihor.solodrai@linux.dev,
        david.faust@oracle.com, jose.marchesi@oracle.com, bpf@vger.kernel.org
References: <20251008173512.731801-1-alan.maguire@oracle.com>
 <20251008173512.731801-14-alan.maguire@oracle.com>
 <CAEf4BzYKgyxh_RH9gGbZE6gK6G9ObjbPFKL1+R8C-sRa5yXoaA@mail.gmail.com>
Content-Language: en-GB
From: Alan Maguire <alan.maguire@oracle.com>
In-Reply-To: <CAEf4BzYKgyxh_RH9gGbZE6gK6G9ObjbPFKL1+R8C-sRa5yXoaA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0230.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b2::17) To DS0PR10MB6271.namprd10.prod.outlook.com
 (2603:10b6:8:d1::15)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6271:EE_|DS7PR10MB5927:EE_
X-MS-Office365-Filtering-Correlation-Id: 8dac81bd-9465-4c45-415e-08de0d84e369
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUtUQi9EUWFIUTBUL1oyMWtBZzZXd1VIa0VsOXRNYnZLRzJZNVVicHJqdU4z?=
 =?utf-8?B?b212THo0cnpDKzZ6SVNIK0RFc0JjeDNxN2YrZlY5NnE5VXlva0dKU0xBRW52?=
 =?utf-8?B?SEhCc09LaVdsZnBGZW5yWUhHQ0hNcUNkZE0xR2pmWDIvVVEwQndGMXdseXFT?=
 =?utf-8?B?Z1pGNGg1a1pZbjVneGdKNXRNekt0K1hZSW9BK2J4VnhHYk1TQU5wSlo4M2tw?=
 =?utf-8?B?U0NOQlpMNEdzcjZEOHRyOGcvOXk4My92dzA5bGlYbFBwWXNyN0w3ZnRHOVRJ?=
 =?utf-8?B?SXBvaFVsYmNwRlUwSzl2RnU2MlhEMVd4Y1RVVjlibzlsa0dxMnZJY29MUkIy?=
 =?utf-8?B?MkgxNENnT3paaHBzYlZhckhTdGdwMVFKc29mYmluT01NbkNSSzN4S3I1anNi?=
 =?utf-8?B?a3hmNm9YUlduTE44TGV6ZXFNVFNVN05hWEZDczVBdXM5b3JQSzZKOVc5V3Nt?=
 =?utf-8?B?eGQxNDZCQlI5RytqLzFKeGt5V1hhVzZYTHJObWNWTjBwOWRwZFRGN0M3cG1Q?=
 =?utf-8?B?eSt6VjY0MDFYWjdwRjZMb2tUSjlpMUExaFA3cDJ1SE83K1JSTnNXSFIxYjZj?=
 =?utf-8?B?RTdBWUZOOHFlZGM4WTVzeWNrUVVucldIOFQxelo3Y1ExaDZhaW1reTNjSVM2?=
 =?utf-8?B?U1ZhYndLUDBlSXFSenQyR0FVMkV6VzRTbnFFUXdqQmgxRWo4alRPMFlOcFor?=
 =?utf-8?B?dGI1VzZMR1dNME9GQWhpemFlOTFFaG9LUUlmbFVVZUxpRG81cnAxTGZWM1Uw?=
 =?utf-8?B?NVV0ZFBYWVQvOUxST3c2dXBEenhQSTJwMWw4dWxiaDVDKzdmOXl4NWY5MVhN?=
 =?utf-8?B?RlFhSzZNNjJyamRyQjl0ZjBRQjkvczZSS25pUTAzazVGcUhrTWVQUm9xNW1W?=
 =?utf-8?B?TWJHWUJ1RjJtZ05PSkQ2d3VnYW1jYjcvVUpqeVZsTnI0bnBoUlM2dFlZZm5m?=
 =?utf-8?B?RW15UzJncTBvd0JLS0h6eGY1aVd2dHZNL2ZxdlgzWnBhVjZSR3VDSHA4Q0xJ?=
 =?utf-8?B?c0pBcFY0R2puRktoS3NmVnhTWWpYaFhTTkh4UHFOcFZEMWZrL0pGQlYydXJr?=
 =?utf-8?B?d2FNSW9ISUxoTHZHcEdGQ3pWekVHMnl3OWNUS0kreWkvb0hoM2JHQTRYZ2tW?=
 =?utf-8?B?YzdPYWJqL3dmTTU0S3FjdG5NZnorZWsxS2NpTnpMTmtkWEdwYmY4S0ZJMVBE?=
 =?utf-8?B?RGhEMzdEK25XZUdpZ01aa0xza0pzVmZ4YlhCZ0FheWxNSWwwOUxiUFFlN3Z3?=
 =?utf-8?B?MjNOMVZGU3RpZldOd3dCSkRhSHJYRUZGNFplTmtYQVRvYnlxcXA3aURKWGZM?=
 =?utf-8?B?OHByekxHT2x3UlBVZ25yUEU0UC91VEVJeGgxMVMxRUh5WUhzT0FRWjJsUXZK?=
 =?utf-8?B?S0xEVXRSVUVhWC8yUnJPUlcyT2NGUUppWFhOS21XV2Q0Rms5Uko1dGcweC9q?=
 =?utf-8?B?b24rSUtYc0FJNGtZUXJobVJRQ21IR2JIZWlrMEhHVEdDeGl2bWcybzVHbUZ6?=
 =?utf-8?B?aytpKzRFSmZpTXB3cEZvU201ZDZJSm1pS2tWazNxS2FUSFZleUcwV0RqcnE2?=
 =?utf-8?B?elFobis2ci9GM0ltcmc4NW1ZQ25pVHVqMVE2MUkvdGZmOTkzUTRZcUdodWky?=
 =?utf-8?B?aVZDeDNqVVdmd2E4ZHlabUdCbExJcW51ZW5RSGxBMDBkZWQ0Zk1Rc3kvMStp?=
 =?utf-8?B?NHBWLzBoRHd4ZTQ0MEZYeUowN0RnYVlkZ2FCdnVTVlUvdUwvUW5ub3dQdEJB?=
 =?utf-8?B?TEduWktFT2REN2w4Yld6TTlrQlNjTlpUOFJTOUFiSEtmeDJvbFpEckR3cWYy?=
 =?utf-8?B?RzdPWWtnWkdsbGdaUjF5aDZYa3RlRWtxdUZDLy95NjlLRGdrSWs4K1B4bitS?=
 =?utf-8?B?a0NOeFVkMTJ0eUsxMVdRVFdiL2E1Yk9DYjEwTmtXS0RtZnM4Y0ZKRi81alNI?=
 =?utf-8?Q?X5bPQM4XbuBKcK+6zesUGntpdNYwHeZU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6271.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?YVVMM25xTzhkNGw3UlkxZ1FwUTN0MjYrQktMd3JwZTl2eGdoNmxEeDVQaHVO?=
 =?utf-8?B?cnV2dWI4cE9XR2k1UEZ0SGU4TlBXcHM0bEhnQmMrNTlZMFZjWGp4bC9GcFNl?=
 =?utf-8?B?QlQycTdZb1Voak5UdU5ZV3lOQVZ5cHVhN1R6dFFkenFnamhEbGJlZFZZS1Fq?=
 =?utf-8?B?MUVleDlKVTU3TDd4YTVHV2h4clVzUUo2aE1IUzdjcTQyMVpRK0w2dGw4MDRZ?=
 =?utf-8?B?QXpwK3R4MkR1WEFFVC80TkdxbGhQekFkTTlybXk3emJ1WnVNZXFaaDVuVzhx?=
 =?utf-8?B?U2NtcWVMeFF0WUpzRUl3L3pHS0ZhZEh4TWJMekxMTEJGWnV3TW5CMmJYOEoy?=
 =?utf-8?B?V3FuZjY4QWJoTVYzQTJVS3AycUx1eXp4WE4zTlAzSHVGUXFwSTJ2eEhmZDV3?=
 =?utf-8?B?TmRzblR2TUlmTG50c1hpTFF6dDBuNWZ2aG4xM0N6djRUU2FIb2xuMnd3Ykxq?=
 =?utf-8?B?U1V4YmkyNi9NbjFSeE95VFd0em5LNit5Vml1cDNHbE9oN0NZT05EbWZud2hP?=
 =?utf-8?B?d08rZklXaER3b2hGazJaVDBYdTVWUERKd01RSFhxN0F5U2lFZ08zY1ViQUFn?=
 =?utf-8?B?K3dOZ2dEdE5PRk05cWxhZytyK2E3UnJPTkNiMzJ3TEtyT0F3ZnhBcFJaU3hh?=
 =?utf-8?B?clBMMHJRaFhSZzFjYy9FcC9nZjUwLzh6UXdGSFM1a1hCSkNCRXU1SDlLZXZX?=
 =?utf-8?B?NTRyN0JhRTV6MlJvU2p1eDdwbEVZOVE4aEtuRkZSYmFWMVh4VTNRMzlYWXp6?=
 =?utf-8?B?Mk9mZzJnTVd2T0xMRGovRzNvY3NyU0RpT0tjdnJWSy9CYmNackJwOThEei9M?=
 =?utf-8?B?VXUveHlMZmhOLzZYMjBUUUVQalppZTR1VExsMURlTXdIYVZrZ1VIZ2NOUVdO?=
 =?utf-8?B?amV3bUR3U0lMdDFXcnE1OFptakMyeWR5T28zTGlzRXhEb1IzUENSYjJWaFRJ?=
 =?utf-8?B?N2FIblJpQXhWU2hHaDArVjMyWUJ3Zk1mVUt2a2IvMDkwV3drcEhRYVRtZlpR?=
 =?utf-8?B?UDRIM0JwdDA1MGF2M0tsUG1QalVQWnpzVS84MDgvZUg4bDNJeHhBU2NtRU1X?=
 =?utf-8?B?T0xCTjdIMGh4NnFNQlc3VGd2dnRxb1BybUZGeUhHRUJwVUhhUzZMdFBWZ0dm?=
 =?utf-8?B?Y2Vha0ttRHFLQ0RZVC9VU29LZWxTa2NIKzZ0czNyQ09Bd0k2Z2FsZ2FnNk9M?=
 =?utf-8?B?dDJZUllrSXF5M0RxUUhXSVNkT1ZMNmhoUDc2UVJhK1FmSllnZ3piVXpHNENT?=
 =?utf-8?B?WTBHd2dJNXU1Y2VFODRNUmVNSk9zQkNUOTF6OFE0M3JKSUJsWXV1WU4vbWF4?=
 =?utf-8?B?WHhQS0ZUYnFWNFF4aXdmZmJoNVhYVkNsbFhGUnFzaHNneThxU1FPNUdDeFZW?=
 =?utf-8?B?amUrbFRmeHJ4M21nSHRmRGVSaU9UamE1L0ROQUt0d2tnZThoUi93WmVnamFy?=
 =?utf-8?B?RkhSaFpLOXNCRlEvc3A5S1dMVHdmSnY1R3RHVmwrTGs3L1NDT2RQSitEWFp2?=
 =?utf-8?B?bkRPNWwvZmNxVys3dFBObUlRQ21ERDJLc0NGMEVvakNzNkVTdEluZDdLemJG?=
 =?utf-8?B?WFRjY21JaE9pQXVQb3ZwMC9zU091VGhTUys3TGdCT0RFZEhxWm5aRG9rODA2?=
 =?utf-8?B?QkRnMGtvRUg2czBYOGo1S24rZ2p4UkNYYkw4aVZnZUlEeEx2b1dJMkQ1TWRP?=
 =?utf-8?B?cFA0UEM3aVVDOG1ycitJbDlESlQzYWQ0RnIxaklETmZZbmhYdVZ4UnRreDlk?=
 =?utf-8?B?dlh4RUZsNHBLd3FJZlNlbHIwWS9zRTV4cnpnMlZaQjhRZEZpYjBKZGVLNm90?=
 =?utf-8?B?cmJLTkpDbmFtdWlMQjBYOTA1cWJFT1BWUWRMYnFNZlpjNHp0NnMyZHc2UGVZ?=
 =?utf-8?B?a3l5dnd2VTlPeTdFOWxwTlplSUYrUE4zOFRKRzFmdDBNWWNWUzFqdmhtcHQv?=
 =?utf-8?B?QXV6c0hPWGNRNHV5SzZQU082em9FTEtXQXRKekYrWmZuVW1EMVNMeDhtbHh1?=
 =?utf-8?B?cEhQZDJUTEtaR1orUnJPQi9RWU5uUlQ2cTVTaTJLRGEraWtBaVRFckpYRlpM?=
 =?utf-8?B?K2JGNi9aOVlWSEJNZDk1NXBQWFQ5a2puZWZhUkpiZG93elJzM3VjYWpTRFd4?=
 =?utf-8?B?ZGJVYUVpSTM2OHdBcTF6dW5BUzFHUFk3amRCTHFNc1BQMTQ1RFBZMmU2ZXZt?=
 =?utf-8?B?aUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qegSIgs312UP3J9rzappO/Jw7otrQ5WswL49dDhuJgCP4nYRKonLKhY5RCrs0GfCo+F9C4gAwwD2j5C+JHalk/RKLb+afxBBOoJyBXl+mthtkTIoJs50WqvINsy2dg9yYxJBkM3iyRdrbpc/1pJX4twN5yb67KP2J8DoV6kxQqhU039vurwrAysDBZxs1AAfMDEsU0JFbpDBY2lxovYHXd5Tu4R8Fo1r7n/Re0OxTgpykUC2eUrIg//bJuFnZyb7vuvIwiLf26ncohH6DshqdzuWQ1rAISOI9+mbU0rhrodDqE1q7265GILzd8kxezkNGvfpuoyrzwghR2A6WFMuIs0oIcvvq0MwuhifBBnTexA4owAOhzG8N2CDu2n3uSDf6L+Mo4h/VmttDdVFElDDf0bNV4qtcfs7W3IASbGGy6IbUqi3rX6XtKfi946mElt0DC9jrff98Mqe0QxLZMAUTVfUUNpL+Xo51Qeq62FxYlfElsSXyghKzOUOawsCjOw7HF1y4asaaizM2tN9zUXmInH/CbSAfOEah8TPMdNh3KKk19iMLcq0WV5P+wv2DWJ2w3IifJh5cMK6nFGDpigh9mgnLQ3mo+kHE9SOt5QBOQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8dac81bd-9465-4c45-415e-08de0d84e369
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6271.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 13:55:53.8391
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uW4ofOhp4HBvXenicgOJWjl31Y5iM79L9Ls2LYbaIG4q6IsFRzZKOClwv2+KIK+sB3KZnSbxqA3g3ro4Js0v7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5927
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_05,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 phishscore=0
 adultscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxMCBTYWx0ZWRfX1IitaZVDdgCg
 tNWmjQNPZO6nL9CG4Agk6fLNP7L9jYAo1rscl/hjlaICeJSbtj6UMyJq1p1A/WTdBdv5Gt8Q2jR
 x9bpopjFt099mdmBTrvlPVRfDBiBZKSSoI+9GgTobSsgbzzm/H21xc3gliUbSufPRd2O23R8+Ve
 KzLLChyRBluAE3zE58Fxu6dW5UHFLwsroRCWvQTYGn/Q8ID/mib/ogrxIWJu5c7pLuQwfwjHiGh
 +RWlk/ATrwYRn8M4FSIS1l5i+R8unIpTrXNa4pRKikNqtMBz24i2QfEdvpxnn6rAYWlcUe+THqt
 T3JQnRp51PH3NoFRsxJUE7RWczyQBfnHM0zSElg1VzRxtaLFFUcScuBqARm91VyE96RXEPsqfZn
 Xh62YexjP94vBtCHpHcwzskPfkg2bu4sZzJqChDz6oU3OSM7VTA=
X-Authority-Analysis: v=2.4 cv=V7JwEOni c=1 sm=1 tr=0 ts=68f24aed b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=q9xOT4CzXiunZLLz83sA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:12092
X-Proofpoint-ORIG-GUID: pLd17Zt3y5LdA-5HZxFTEFX5qQD-nQNw
X-Proofpoint-GUID: pLd17Zt3y5LdA-5HZxFTEFX5qQD-nQNw

On 16/10/2025 19:37, Andrii Nakryiko wrote:
> On Wed, Oct 8, 2025 at 10:36 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> Add btf__load_btf_extra() function to load extra BTF relative to
>> base passed in.  Base can be vmlinux or module BTF.
>>
>> Signed-off-by: Alan Maguire <alan.maguire@oracle.com>
>> ---
>>  tools/lib/bpf/btf.c      | 8 ++++++++
>>  tools/lib/bpf/btf.h      | 1 +
>>  tools/lib/bpf/libbpf.map | 1 +
>>  3 files changed, 10 insertions(+)
>>
>> diff --git a/tools/lib/bpf/btf.c b/tools/lib/bpf/btf.c
>> index 62d80e8e81bf..028fbb0e03be 100644
>> --- a/tools/lib/bpf/btf.c
>> +++ b/tools/lib/bpf/btf.c
>> @@ -5783,6 +5783,14 @@ struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_bt
>>         return btf__parse_split(path, vmlinux_btf);
>>  }
>>
>> +struct btf *btf__load_btf_extra(const char *name, struct btf *base)
>> +{
>> +       char path[80];
>> +
>> +       snprintf(path, sizeof(path), "/sys/kernel/btf_extra/%s", name);
>> +       return btf__parse_split(path, base);
>> +}
>> +
> 
> why do we need a dedicated libbpf API for loading split BTF?..
> 
>

that's a result of the design choice of using /sys/kernel/btf.extra as
the home for the multi-split BTF. If we moved away from that and just
had /sys/kernel/btf we could drop it I think.


>>  int btf_ext_visit_type_ids(struct btf_ext *btf_ext, type_id_visit_fn visit, void *ctx)
>>  {
>>         const struct btf_ext_info *seg;
>> diff --git a/tools/lib/bpf/btf.h b/tools/lib/bpf/btf.h
>> index 082b010c0228..f8ec3a59fca0 100644
>> --- a/tools/lib/bpf/btf.h
>> +++ b/tools/lib/bpf/btf.h
>> @@ -138,6 +138,7 @@ LIBBPF_API struct btf *btf__parse_raw_split(const char *path, struct btf *base_b
>>
>>  LIBBPF_API struct btf *btf__load_vmlinux_btf(void);
>>  LIBBPF_API struct btf *btf__load_module_btf(const char *module_name, struct btf *vmlinux_btf);
>> +LIBBPF_API struct btf *btf__load_btf_extra(const char *name, struct btf *base);
>>
>>  LIBBPF_API struct btf *btf__load_from_kernel_by_id(__u32 id);
>>  LIBBPF_API struct btf *btf__load_from_kernel_by_id_split(__u32 id, struct btf *base_btf);
>> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
>> index 82a0d2ff1176..5f5cf9773205 100644
>> --- a/tools/lib/bpf/libbpf.map
>> +++ b/tools/lib/bpf/libbpf.map
>> @@ -456,4 +456,5 @@ LIBBPF_1.7.0 {
>>                 btf__add_loc_proto_param;
>>                 btf__add_locsec;
>>                 btf__add_locsec_loc;
>> +               btf__load_btf_extra;
>>  } LIBBPF_1.6.0;
>> --
>> 2.39.3
>>



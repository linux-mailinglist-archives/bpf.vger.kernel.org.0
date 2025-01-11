Return-Path: <bpf+bounces-48630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE8EA0A515
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 18:30:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB897188AF5E
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 17:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC2B1B0F32;
	Sat, 11 Jan 2025 17:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ffRTym4g"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2062.outbound.protection.outlook.com [40.107.236.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05841553A7;
	Sat, 11 Jan 2025 17:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736616640; cv=fail; b=e46dJO93lONy4DEiTzD39KhvzrYR6soKnyee67uGh5wfUZK47o6kE5Rm8yFMBuyMLZdpm58S9wuJpkHEHfHvNMYeYazhlxUN1jnx7wNqZhSTt2BnKta0S/jyRG49QY4E4dxehNbmUSY93SuXs9uqAsqC6Odm1KV8UlXWBV7v/ds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736616640; c=relaxed/simple;
	bh=o0aZwThl5MH3HoXEHTk6ZLFYxPqFJbdJ0XqlGsUKUgA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WhjV3Od9t21V0c7jJf2tYRs7Lo4FcfgmMUHFzjIFt3kMj4fpOPIZYs4j+53vfPQluj2Vq8U3eUGT5is0zYO4CK8GZp4QgKGbXeANiML11Dmbfss2aNxs/CJa54sBvZrOrVuoKypPbvMIlY7fYGAQenqGZyNyWypgK8+RWgTQueM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ffRTym4g; arc=fail smtp.client-ip=40.107.236.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GN3J18pMYRwYMKGSdpNDEQ7iMF/7mGF+9LYnuF2Kxf3Vf42bUP2XIwjB+KM7Mb9LjogsIqVo3pWY2Q5Q+VrRO1j1e8qCtlMqhIIWi6LthwKpIG/rgWkzpvFqM51l6wsd3fUkTdGbpKBw3IYEGSRzEOZ51jk6CauqH87Diu1p4vPeFa5adOa3wX+BGHP4uB75GPz6AXsgtCAStBqSraszcywcRafvyhnpcSIEQhZnZj+zYbeywdJ+6DJ5WkhvKJnfQNI903eDC6mCuIYVyQ8BinTbgj+2Os4v4L9aB9LOwZ8RIzjt4mA/kNezsTgaoQS/3FqzU1MvIdRIUX4v/EkzEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Kvx8eK2QYfp50FLwXjktJtcTld4X3dhJeoXe//caQ4=;
 b=I5g8xV3GMBAAs4kwutrqlzNj3qz1jqpfvhdaagyxOGZKEPOZcBt07Rmre5DM/kOo1ifjfvPeHs+zhwmgk1c2/tgN/9xgwKPB0i1eUsH60BjT7o5BcUhULVvJlXCnRKWbDej1jgTPzSfkKZSPZVGkBnLx1AsEgLzG4Gszz1WTYFKv4XXNDFePLIx/PgFLmlmknra7rYf7S/7Mmmvm0r0a1gIaATDhuZoLcvmeHE80NKZameIdK3sYp/i4boLsyPkXn2uxQAMgEMxVrmTC4XA33NeX7w0GieZFZNXImx0NlQrN9fj2mvcn3BCt5WFbdkmrjVXpObkVitmGt1eYvKOMzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Kvx8eK2QYfp50FLwXjktJtcTld4X3dhJeoXe//caQ4=;
 b=ffRTym4gXg1Ip4VXRVu5AMHn/dpZIXwciIGtZcLl+70ALEHUor3UoiYIG7iXEsMESbJ3q8XU5xIxvpbvRWeyV1js4YonPXIB+av3gc7JI6TSrdkiupA95BOx95doTX00wxc+RWbib2qEi+kcNyXRFpag7EgFwnPdyGkARIF0CWU/bHiTxz5wuAnZBUzpEB53Y2yhe+YNTzMxrMrUJCwmw+vsqkLTxlbRgFC50Sq8/UohcI8pU1Avexip3UzhfbaTY9DbG74R4DxLUEwqDG3a+CcoS8YsRVWs7QQV6JdzQwiaSj9gFMs7sW+PzZzWXXJBe845MO/2qDEAJQ2n58vU7g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17)
 by CY5PR12MB6252.namprd12.prod.outlook.com (2603:10b6:930:20::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.17; Sat, 11 Jan
 2025 17:30:35 +0000
Received: from CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5]) by CY5PR12MB6405.namprd12.prod.outlook.com
 ([fe80::2119:c96c:b455:53b5%3]) with mapi id 15.20.8335.011; Sat, 11 Jan 2025
 17:30:35 +0000
Date: Sat, 11 Jan 2025 18:30:26 +0100
From: Andrea Righi <arighi@nvidia.com>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>, bpf@vger.kernel.org
Subject: Re: [PATCH] sched_ext: fix kernel-doc warnings
Message-ID: <Z4Kqso6hS2vsFdIt@gpd3>
References: <20250111063136.910862-1-rdunlap@infradead.org>
 <Z4I9tXouDIVdWBN5@gpd3>
 <5faf8551-d434-4e2e-980b-0ff5831d3db2@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5faf8551-d434-4e2e-980b-0ff5831d3db2@infradead.org>
X-ClientProxiedBy: MR1P264CA0036.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:2f::23) To CY5PR12MB6405.namprd12.prod.outlook.com
 (2603:10b6:930:3e::17)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY5PR12MB6405:EE_|CY5PR12MB6252:EE_
X-MS-Office365-Filtering-Correlation-Id: 39c61896-e744-4f30-5ed2-08dd3265a810
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CFwdIlerBFDBkjWxCVBUoFndcSCSIP08qxCSqvKFgnGwc82QjeSAncLGUq94?=
 =?us-ascii?Q?+57z25MiMAc1nwqzX7mTqocDjuKymVd8uvGEYbalMU/aAwlOtR6Aqp9TQZY7?=
 =?us-ascii?Q?0UM4/lV7EBM+SIHcH8VtO7J9W2OlDQJxq3xndXzpVVTrRLQ9e3pb4+pNCSkj?=
 =?us-ascii?Q?mc0savnE2wodj9Be22LVv/p4TYolTVXoIft+7kIguqZRxBHsY+K/PqFPQMr2?=
 =?us-ascii?Q?t59iFGzuo9cfnB4HfiXt2oOodVGpDNh79AXh3CSCH0s+BQqk65+BxuM2wdJ7?=
 =?us-ascii?Q?X/TdzhQemF8yiUAaFOl5jSCfkPdgF9IifH16mkmTrgo2H9WYSnSUGhhc3OtP?=
 =?us-ascii?Q?ZWxx7vAPW4eFnx+4wDOB9Td1fZQKr3ogqb7fWN2IXrDiyc9S6fas9MeWmCK4?=
 =?us-ascii?Q?BbPXwpZpZdKn4gqr2vX6p427fArzwy4xZD8ZwscV0daUcTKfdNMMSjKWFRdE?=
 =?us-ascii?Q?E++ixQyOCjgug1UeAFasInBJO2PIYKXAslcNxSu75RlOXcPDJDFhlRLDyZsr?=
 =?us-ascii?Q?LAj9uIbrghUWljbCeifIfRarWR2oUMx5CEN/c2bTj8njOAOSzTn5e36f/0e4?=
 =?us-ascii?Q?FJiKrLIYLF54Hxhs6x6pRIw9LY/QeBCeT2nPbzP5+zb4m1Yg7eWG4mTOnhoM?=
 =?us-ascii?Q?pqEWI2e3YL4WVSUt//aPI+dZc8w7eWigolsHGSDfxFt0fVp5RPwG9AR4AK4i?=
 =?us-ascii?Q?Ps2pR3/QcnQ8wo8WI5zkAodNxTy4qiEb4j0Vvsb36PyvCkO/sRV2BRBWyjfc?=
 =?us-ascii?Q?GeAXn3mQBlAIpLyjdTfy1GrMYF/cJS5oHhOQ0EVPU8Q5G/61xcS2M5aaQrlX?=
 =?us-ascii?Q?xSx1NFO6Nsy96NhJkvv+1Cyf6sVn4TH/NrED66AdpIomC6d+osO05foL7mJe?=
 =?us-ascii?Q?dFNvj7UUClc3XnBXuNeexWXV+FRmhNlQ10LttBHUZ2w9vu3fJOOnFzufNW1r?=
 =?us-ascii?Q?qCZFKffu8KU+SJ0aczQnoYgURV3Qpc9WUrAnhQx11LJeNkDnGmYef6kON4Zd?=
 =?us-ascii?Q?aOdKA0Y7L4sr5gBXxsx3NHwy1YlxVCpf0LXSYV7vdX9Bq2cUTC4rY+tiSJLo?=
 =?us-ascii?Q?OWrmhq/8S1Q5fpMTxtmMf9/Nn1UuYECTk8Blm1iOGpX1kB4KAMhTc2U8vHOG?=
 =?us-ascii?Q?ydlKvZgeuEKDshqlGqvelK+wahHzWQiEKAQzJnnfg7uWVe00fjBaxZsGZh2o?=
 =?us-ascii?Q?aoYLe0HJU6lCsTEMPCcBBOzIk0NS1VGfca/qAMb4F+1i8qBIE4+RxkPTWAYI?=
 =?us-ascii?Q?FZs8URBtjxcBKvSRf4Avh3A3xyrDypiFGjGBGZHD+r6uMnX09FOHaKbDkhKs?=
 =?us-ascii?Q?b/mDNPN6VyqH3Qxz+Lg4DzWY9SDnongAil7iCwTnGxQv8Qs0arz7C41MIoLp?=
 =?us-ascii?Q?B3wdmmau5BVCvsHVTN5vg6FALWqj?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR12MB6405.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?VE/Wi2Po57ZMT3eDcDw9L657IAeOshCRhEpcplN8/SLDUqobsG7GEMHYxMVT?=
 =?us-ascii?Q?dlYe3Y+GW6D8GSrPGPkhFuugrxjvmzMK2WOsbnJrqkqw5QABT2UDa6Q2RshW?=
 =?us-ascii?Q?9/s0ZFMClgf7el79hZkHXPs0gOQcugKnVzlHcaofYZoQscQQ9JMfjL6wuOy6?=
 =?us-ascii?Q?otQGuqMfgJQmeamSkp4lF1Mfi4Y8Fbt+uFe7F+n1inh2VIUM0t2Y1YZlCNPz?=
 =?us-ascii?Q?dMYovOoq1YxX7C4xpNTBvVHLyhV+KTTfFY17HdnOWP9nQHtOkAWOOWuobWs1?=
 =?us-ascii?Q?OmJF8cxBMCwQfwzW+zuXMA4Vztkap0tHGIcK/eVhQKi05ftlxC0ZB3DbDfqJ?=
 =?us-ascii?Q?gUvAgtQjEM3ZPvPCdFrV1uuZj6mYvF+8yCNyZei499Wx93HUrT/XBwfhNXDS?=
 =?us-ascii?Q?eHa37lA+5ea9llvA/itXPrLI5hr/JNoUkrOrmpJ9t2a+YWXrSMGNeQuIxkDK?=
 =?us-ascii?Q?Ltuk5ubzOZB710RA//gEhhuHNa/UaVDvsyM6D19N790hUzRmegxjU1hUmYkn?=
 =?us-ascii?Q?+nutM8CbHHQIEIa/cSg4xvze3gcYx4/NfFHNShF4YiFbhBW6jdKgs40ddpH+?=
 =?us-ascii?Q?8ysB+q91YfEiLN6cQdA9P9YWtfwS+ocPekdFtqBkHI+VtNplEjQ9DxqTuPDC?=
 =?us-ascii?Q?ASC1mr708fYseB6zZJ9Oizn5QQ65wpvTLmOeInlLTxxyxaunP+ePPTRKy4C6?=
 =?us-ascii?Q?uJT/GJRPPsxF3+bqR9PDQrEqWxDVbQD3RflGj8vr/kHmoADffQ1NTlEqjlcB?=
 =?us-ascii?Q?pWtpOk7RZs12bVsjU0oPzabiyd+cseiNLx6pTDElRJTfZLRzton0zRTHG5nN?=
 =?us-ascii?Q?x7EAXiNJmfr+P/Fy5gf8RqDNZ8fnsTqAKbSEyPbpwcE/NLGJowBfzmIeLjgj?=
 =?us-ascii?Q?oXdHvyaFwbwoFRliM9doQCecMYGYRwSiIbCAgaRYXJlKHDutreyLo7Vlpkn+?=
 =?us-ascii?Q?ZPVibX7vpdiSZn8w0G6/p6PfBlweoBKbVdvLm0BzNHp9bw6Lzt6VSErH+U2g?=
 =?us-ascii?Q?d7ImTQ1GIsubxk3dSy5Q8H02MrlWBKucLshW4oakFZWyQh8n57FuSXFA6JlD?=
 =?us-ascii?Q?Fu3acE8KHJY7Mk/Z45sNNEPw4knoRq8fpOdnSxdq6FnqWxOaRuFNklSd5EOM?=
 =?us-ascii?Q?OI1kJkvXVx9P9ylwAmxx1fwSu1uosv5yaf+UsCOi+fDZh1zRlX4CPVSSIFfB?=
 =?us-ascii?Q?FLsKeyzzSs4vTFYlaLGoyZ71PnXUqc5Zoj16Oz+sKPc0lqF1NKDbi8wK+/v8?=
 =?us-ascii?Q?Fz/23ifQfcfE9zCkBVSUP4JY6xaNIG2NR1X49B+Bm7ot7A7bj6cI7glZPG2C?=
 =?us-ascii?Q?1RwiZqPwpP6uuyH+dkXjtf+FbkI/SOyB5oiyyd4iO0nrEQG/gBQ9V7rw6GKN?=
 =?us-ascii?Q?UIDiUtUc364FDm0sp9AMmNxWco36fUfUrLLq1abbokd5cvWXl3jJcEusVK9D?=
 =?us-ascii?Q?6KoAOhC15ydIa2OvrxJO1JoQPi078Ckojn+SrmRPnAXoUzsGcfrs8RT1o72Y?=
 =?us-ascii?Q?dXsS370Gsx9okyIsYoWw6LLhJYNiQga+KLBu/xlOcimmbs0V2k2tMgtsGs52?=
 =?us-ascii?Q?/r9A78ruJl0iqLrS+4L/NWAuU5y7DPWtA0spB8lW?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 39c61896-e744-4f30-5ed2-08dd3265a810
X-MS-Exchange-CrossTenant-AuthSource: CY5PR12MB6405.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2025 17:30:35.0281
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ShGRxLOFE2T7vyJA9flg2NE2QtGdsBeNcYU8bgjMUB5fh+RO63mupoWhBylnIQpHGo27rDMiAA5AIhT63YNDTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6252

On Sat, Jan 11, 2025 at 09:27:27AM -0800, Randy Dunlap wrote:
...
> >> @@ -1408,7 +1409,6 @@ static struct task_struct *scx_task_iter
> >>  /**
> >>   * scx_task_iter_next_locked - Next non-idle task with its rq locked
> >>   * @iter: iterator to walk
> >> - * @include_dead: Whether we should include dead tasks in the iteration
> >>   *
> >>   * Visit the non-idle task with its rq lock held. Allows callers to specify
> >>   * whether they would like to filter out dead tasks. See scx_task_iter_start()
> >> @@ -3132,6 +3132,7 @@ static struct task_struct *pick_task_scx
> >>   * scx_prio_less - Task ordering for core-sched
> >>   * @a: task A
> >>   * @b: task B
> >> + * @in_fi: in forced idle state
> > 
> > in_fi is currently not used / not passed to ops.core_sched_before(), should
> > we metion this? Like appending (unused) or similar to the description?
> 
> Hi Andrea,
> I'm not sure that anyone would update that comment if it did become used  ;(
> so I think it's OK not to mention that.

Yeah, good point (sadly). Then the patch looks good as it is to me. :)

-Andrea


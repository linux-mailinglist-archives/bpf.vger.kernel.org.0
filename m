Return-Path: <bpf+bounces-55611-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A16A83584
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 03:15:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB30317097E
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 01:15:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2844818A6A7;
	Thu, 10 Apr 2025 01:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G7+HjQdH"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D911126ACD;
	Thu, 10 Apr 2025 01:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744247735; cv=fail; b=svDrV7zms9nV84TImVzIVIu3jNCJ3w94E9Tk/z1Yb8LoQ2wxj9U7DM2S3kUMeOWxA5b7DBosAjaAso9iXbnOL20nDPOd20ABInjgHFq2n+qI97on32LVD20GmIk5fMuHRscUhRFXwDCff/bxnHoUcljxBk+YSES+ZaEv25wJNvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744247735; c=relaxed/simple;
	bh=kxMJppZTI/sc9uvXS7MFwhc9DWrsR8xsHEa5feO28oU=;
	h=Content-Type:Date:Message-Id:Cc:To:From:Subject:References:
	 In-Reply-To:MIME-Version; b=QZnIbgbqHlBIChkppNVN0+23hoD9nJm8wYHX7N8t+8eH3LTi0TleWKpBi3haMA3JfEyGcIacK8qS3O1bsCGHO9qHV0bKEpxIE+PJBvm4Eew0Rq+reYQl05WgLYDTns7cLN9MoypGfHFKMktNiaeZGt6Vt/fosdNBHYR/Lqq8n7o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G7+HjQdH; arc=fail smtp.client-ip=40.107.236.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpRxtGJCEObv2jkm1e4a4yuZ3IYDGgUfYuP4eiG3MuvAJ66LrtlMFsAcHgLkYTMDdhBY16lbx+XKunu7daQZeC9jh/+B9Uvd9yOCBMSHqcsnX6xh6Wn0DKn4Sv971OrIrF8+L+fA32+SXnOmGD+GSO6GKJqMawo9bEz92wjnmNMHoe6PIhFh9Ws03AHpsm7d01db0j2znw4QAHv9pKTxbX/9jkTlakjFL+22jHMU3Uc9BZqoetwiY0rom5JNV/mE9pw1nkRXeggRY+ixKL34JZoUUYHfWymeup2OQazkFYMd6e2rcK0AZRXqU2xfLEgSBZCYwLbWXaR1gF/1HXxMMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4onLC6biwNw/sqa6EWfn2gBYWhw7akAchhHR1v9Qwg=;
 b=Rp5me2q3AEMO7eOdD7RUGU/ppwUpM4ctqPd66KuWafA/uxBvN2TjB8y0CJ6/i1kj8i0VNp34ZGQyZv3Djk8RVSfldCaI/Ifs6jsUqzQJErIOSNQ5GUa73pDK4AlIRYRnxNHO5oLTrlCwcvXqbpu4062gnurc/kp4MJpYv5bAsAhJyUgi0J/pHUKE+vYwAN6OMmATqYHKFCtCSRhhi/JN1mB3O6czpVvNJ8t+1+IBvgmCLG+wUxI4HJIhGMG9DLkXghokcH5jWIFGgK1Al+fr8j0wWc6XbWSK+slv0b5TUuD4KhdCZYE2J0wwg+VG+YP9bT/mXbENRK45Pp96Pz0FFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4onLC6biwNw/sqa6EWfn2gBYWhw7akAchhHR1v9Qwg=;
 b=G7+HjQdHcczbhziVrw5/Eq8fwug36G9TkSsvRJNkCkoMydYIdmHKyuezVxs/YkKHQAIRA/VT+U7e94G55L/Ry1jUTFVxkdexVsTBmNUmrsoDGsEYZAyiPFdRiQGP16VlTMWG89AoYmC83e7eOLAIN0ED1zgnSlQMf8mv34XrzS7wy3mhPHsLqisgfXp6ak0LNumYXoWecqSWiuI7kbtBY6P6Fl3sFAN6nSXTXyQoJr2DOMybfMSJLlawv2kgZ6FTHufSpqB2Wc+BX2VqMeYh/0zzKEL+mrYFigMJ2aDlhDJ9eztsOsWx++47BKQdbklj9QsFUq+nAsvYTkbyz2FuSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH8PR12MB6723.namprd12.prod.outlook.com (2603:10b6:510:1ce::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.22; Thu, 10 Apr
 2025 01:15:30 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8606.033; Thu, 10 Apr 2025
 01:15:30 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Apr 2025 21:15:28 -0400
Message-Id: <D92K7SAU1A06.1APBVXB2AK2HW@nvidia.com>
Cc: <netdev@vger.kernel.org>, <bpf@vger.kernel.org>,
 <linux-rdma@vger.kernel.org>, <linux-mm@kvack.org>
To: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>, "David
 S. Miller" <davem@davemloft.net>, "Jakub Kicinski" <kuba@kernel.org>,
 "Jesper Dangaard Brouer" <hawk@kernel.org>, "Saeed Mahameed"
 <saeedm@nvidia.com>, "Leon Romanovsky" <leon@kernel.org>, "Tariq Toukan"
 <tariqt@nvidia.com>, "Andrew Lunn" <andrew+netdev@lunn.ch>, "Eric Dumazet"
 <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Ilias
 Apalodimas" <ilias.apalodimas@linaro.org>, "Simon Horman"
 <horms@kernel.org>, "Andrew Morton" <akpm@linux-foundation.org>, "Mina
 Almasry" <almasrymina@google.com>, "Yonglong Liu" <liuyonglong@huawei.com>,
 "Yunsheng Lin" <linyunsheng@huawei.com>, "Pavel Begunkov"
 <asml.silence@gmail.com>, "Matthew Wilcox" <willy@infradead.org>
From: "Zi Yan" <ziy@nvidia.com>
Subject: Re: [PATCH net-next v9 1/2] page_pool: Move pp_magic check into
 helper functions
X-Mailer: aerc 0.20.1-60-g87a3b42daac6-dirty
References: <20250409-page-pool-track-dma-v9-0-6a9ef2e0cba8@redhat.com>
 <20250409-page-pool-track-dma-v9-1-6a9ef2e0cba8@redhat.com>
In-Reply-To: <20250409-page-pool-track-dma-v9-1-6a9ef2e0cba8@redhat.com>
X-ClientProxiedBy: BLAPR03CA0119.namprd03.prod.outlook.com
 (2603:10b6:208:32a::34) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH8PR12MB6723:EE_
X-MS-Office365-Filtering-Correlation-Id: baeef842-4630-4ff9-0fbc-08dd77cd2f25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ci9IdlJLcGZObjk0U0lDUjIwTlVxckE3SlNHa1JSZW83VzRRTkJxWlZiajFz?=
 =?utf-8?B?SGRqSkE1MGNId1dRRUhqeTdNZXQzNmpxNVdTWjk0UDBWWmZVQmxiSTEzc2hX?=
 =?utf-8?B?ZXZSV1RUSkkwb0hlZnVhOG96M2k4b3YvdDkzRFhvelFZL1V6bkh4aVFOSmtV?=
 =?utf-8?B?WHhqTXg0cldmRXFJYzFvYjhEMm9rZ3FvYllXV0toUTQ0Nkk2OWpLOXVYZC9w?=
 =?utf-8?B?dTY1QUVJUU9pUjdIellPdFlzWGQxeHhLVkpnbmxmOVF4b3o2QTFQTm0yNE5l?=
 =?utf-8?B?KzdqVENLQVkvOEs3YndGYjd0QW5nMFdhdFo4eDEwNlluNUpsMTZtR3hsSUs2?=
 =?utf-8?B?amU4cG52eDRJMnZmRDFlSzlUWDhZaUhMSDIxL2dML3BzRXpuelR6Rko2enpH?=
 =?utf-8?B?MGkrUlZaSGllY2s2M1RTa3dYdDg1TW1lbisrYVlHeGtyaUFwa0hLeHNkbnFF?=
 =?utf-8?B?a3dVd2VZSEw0VVUvVkgvbEEzWG1nRW1QUmZzaGZuMmJYUlNQaCtNZmdFOHEy?=
 =?utf-8?B?NkZaS3VIbkZGQ2t0RTBJdkw1Mm5NaGVXYWN4VkM3VjkyTDhGVU4xcVQ2Z1hD?=
 =?utf-8?B?SjVQckVXbDdQMm1hUHFMbnpDZTROMDVod3dubVU0ZzBuTHQxVUZIRFVyZzNt?=
 =?utf-8?B?aUxHVWNtbUFkdk5raSszb3pMc1Q5MnFRa1o1TWpRRUJVMDZkczdGeE5RK0o3?=
 =?utf-8?B?K1ovcmZjSkRXZ0luR0l1bGVISGZ0UzdPYUpyOGhnOVFoMzJoNTFkQ2RjZWU5?=
 =?utf-8?B?cjVsU0VtamVLRkJvcy9mRUFTbWxIc1FrMUt6Z3VMbC9tNndCVHdGMGhwbGY4?=
 =?utf-8?B?eHRRbExmTzluWlcrTk5wM3E5b3JUSzNyaVorL0o5b0ZwWmdPbVdIb1RKUTZQ?=
 =?utf-8?B?SUhEYTVsMWpuL0dNeDhyZStwTEVjWGNpdXZLdTF3ckI0ZVBNTDhtdjhmRGsz?=
 =?utf-8?B?a3lOdytIZk1xdXhMUGowVlRzdjAxYkJVbjF1Wk12czFFVVZ0UXlnYnNuQVdP?=
 =?utf-8?B?M3ZvcFpVR3dFdStzUklBNkpuMWRvU2Q2VWxZckZjRXg3VGpNNS9Fa1krNjdD?=
 =?utf-8?B?QlJYVDdwblF6cmdIZkRaK3N6MEVHbEtBWk5lYlB4L1FrTFVyUjhzM3hzeHl6?=
 =?utf-8?B?WVYwR3FFMkhIU1lpNDRTMElmVFhVTkc4VTNHQ3ZhVnpBTmlGdzZ2djNqdXBa?=
 =?utf-8?B?aDRSMm9uOVlhNXlMc2M1Nnk5a1dMVDJVSkdBclZYdDNKOXpHSDFkakZHb1VZ?=
 =?utf-8?B?K2JuTGJ1MnRqSXFBaVhjTlVTcnhQdm8vVTFoOWNXUittRm5Kc3hCSWNYRXEx?=
 =?utf-8?B?TW8zVVdoMXpSMXZudk1UT0oxSkRydjJHcWFVTFpnTUNLRVZZa2g1UXVZd29X?=
 =?utf-8?B?TlVpd2dSZFhmeUlScDVDN3NtWFBtckRQOThPUElrVCtETlNCSWpEdXhwQzhx?=
 =?utf-8?B?SDJ2SUZwSGNpMVVETVZUVG5vckt6Q3RJZGZiSmVBb21mNE5qZTVyT0E3Z1p1?=
 =?utf-8?B?QkhLb0tWMnZ0TXdaN1R5VExIb0daNzhFSVgzdkJjTkc3dHdqbkhEbitGYktQ?=
 =?utf-8?B?SXUxMTFGOGJVVlpiamcydVlXRW5pczFyN3dZRkpkLzlCZk1zWmFNVlpXckVD?=
 =?utf-8?B?Y3JlVVVKbUxoV3o2Q3hTYW1nWENRVm5vRXhJd3FjaE9EdHJOZERKK0hNT3VD?=
 =?utf-8?B?c3BjcmhVY0FuWE1ZN2J0d0NZUHVKd3A1Ykh2TVI1ZTUvaFFEaU5yMGRmRXNK?=
 =?utf-8?B?WDVGUENiZ0ZmdFdJamd2aUpIaTRyUzRKTnF6SXNEa25tSGRDaThpb1hEUjJD?=
 =?utf-8?B?NGYzU1dYNXlYOUwwSkUwMDI1WmFoUzJPMHYwZ0FuNTRNTy9VRHRwTWpSSlk3?=
 =?utf-8?B?cGp4NXpXRVVNNDkvL1Q1ODNGS0pXejlnT0R1NlhjMlZRNUdWQTFFM29CUXJo?=
 =?utf-8?Q?CmHqefaJJT0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dXBvSWVFbCtBUmRCOTdNWnovUml3YWRGVS9oUHB2ZXptQ0RBYXhYU28wVE9G?=
 =?utf-8?B?bGs2OWdrWVZvVnArMWhWbFhZTzdqdkg1YjJ3R0d1WlZKRGFBdUVlN3hmU2Q0?=
 =?utf-8?B?T2tISDluRnNaMjhlWnF2TVRNTEJKZlp4VjZjcEU1ZlF5RjVsZ2krZlVwbDdU?=
 =?utf-8?B?UkZJSzd4ZnhVdi9mMFdHM3pCTGp3Nk1OQ0NZa1k2a1hJQ2NtYlZ3UU9TeEMr?=
 =?utf-8?B?QU01VXM4aVJidW9tbHlET3BmT0lkT0hiem0vRlVjQXJuRm1rWmtMdnErRE9z?=
 =?utf-8?B?d3IyZjZlNGtIL2IybU1nREJRZE95WDAwcFZCM2cvQVgrMk9TZXQreUtWYjJ1?=
 =?utf-8?B?MHY5VXgyVWVoY3RtVmtRZ3ZaS3Y5UnJXUlhnUmhja2RkNlpzSjFvRmgzVVVY?=
 =?utf-8?B?SHFjMGVZTlBaSXFZREtVcEM1TFBnWTRVRDJwZndFSHY5alhsb3ZVTlZINTcv?=
 =?utf-8?B?M21sQ2drUmxjUTV3K2k2RDhMcXpXZ0YrSDJja1JIaVkyRkcvRm5rYUhsT0h0?=
 =?utf-8?B?dW1DVVh2bkhFajQrQWt5MzZwQXpWdG5CZmFPcU04N0F6RzB5S3FJYVV1VEE0?=
 =?utf-8?B?NTF4dXUyUDNpekpQNDdJTEw1KzNnVkxFamxJU2E3MUtJZm9BV0dJUFVZY2JG?=
 =?utf-8?B?b0hwQ1ltcSs3Sk13Y2llcFdxVHEwamdOWVhvWjcxVjJLL3RtcUgxZUNrMEJU?=
 =?utf-8?B?VjBMNEVEdzdPamZSTkFkTXNkY3dMSnpxMlFrcVR2SUJSbFVKejZkd3cvV2c1?=
 =?utf-8?B?dnB4WHJ5MHpYU2ZqZS9iMWhvVnY4V25RTHdoSFlrZmpkeEhIRXF5S0dpaGMz?=
 =?utf-8?B?a0IxMWZEUEVOSzJDRm5Da21aQWgwWkJYaXJJc0ZXNHRIcnNnTndtcTdrSzJq?=
 =?utf-8?B?QVlDT2c3Yk1HQmdQVGNzN0o5bU83Wi9xWWJlUWU2Yk0ycnQ0Mm56OVFNTW5n?=
 =?utf-8?B?TmZQZmg5RnJLY2YxZW5SZG9wWTZIYlJXSzBkRWlDYnM0TjM3ZmVtVmZiRnZk?=
 =?utf-8?B?YTZ6ZlJ0djgyM0RsSktRRGVwNVRkTnc4N1lXLzNnZktJRHRmNlFFcTlyYWFV?=
 =?utf-8?B?L29xT0w4dUUxUUc2ZGNLbHJpbWg5VHRac2xYbW44Tjd0M01RaHlmaUZLRjZ1?=
 =?utf-8?B?WHhwR2pHcDRaalZ4Z2ppUDlmQWZ6SXh3V1QyYnBUT0pOVmh0akVBM3pMNjVx?=
 =?utf-8?B?Ykh6L1pFMUZXODhVYW43Z0JkMWdiQVg1VFhTSGcranNsOVB6YjZkZTBjSFBK?=
 =?utf-8?B?WXhJV2gzK2FSazhHbWNja2ZQZUhFOGdhR3BEOEc5Ti95T0tUYzNod3pNTjV1?=
 =?utf-8?B?cFlzS3o5VjdkL2tmNHVEYmF4a2xDek9KMzUvOEJLT0ZXais2NTQ3VUhyRU1V?=
 =?utf-8?B?TE00ZXZHc1lTYnJLTzBCem1YYmhuWGJDbmFiK0txVFExWEN5elpmVmhyVkpE?=
 =?utf-8?B?QUpuT3ViQzBMcThWNWtXemZxY0VmRzlORlN2NG1TUFNqYkFTTzlCTVdUNDda?=
 =?utf-8?B?RkVNSU8xelB6M1owZERDM3F6dXl6SmNuMDJmZEcwRnJTNFUxSHNPWUdvTjRD?=
 =?utf-8?B?OE1jSE1DR3pGdSswREdJNG9pajgwaVZlT2hWRHlaclE0U0U2SDdTZ0N5OE4r?=
 =?utf-8?B?UWYxV0thd2Y5Y0JmaUlHdGpiRUVHWG5KWE51bitIMHFScW56N2dPWTZjeTg2?=
 =?utf-8?B?STFMcVlZdlFoSk5RUWVVdXBCcmFKWEY0LzhUdXBOREVLMTdxRk9rUVh1UHBs?=
 =?utf-8?B?YkdRbEY4bFFEcXVvN0tKTXhCaXhxeEZacGRHOWlMZ1hFUGtCNUoybzVSbVE2?=
 =?utf-8?B?YjJtajFoY1FPM3kxcEJZaXdPaVFCOG92ZGhhZXJDaGRsMHA0NnVoM1pERkly?=
 =?utf-8?B?VUIvbmV2Tjl6UlZTTXkvQzZjZDI2VjR4SXZ5KzZlZ3JRYm5xUWR0YnpqTVZR?=
 =?utf-8?B?QTJDYXpRNXBZa1VkeW96dFVhdHA4UEVLZG5BL0J3WlMzQ09ZaWJKTW16eXFy?=
 =?utf-8?B?NUo0bG5LSDZpK1BHek5RUUp0SS96VkZwN1VFejVpRmZEbEpzUjZ1M1Ewd1R1?=
 =?utf-8?B?bWtySUszVFdoMkJTOCt5V1doZC83VzhKRllhZnVyRzQ2QnZKN0NzMHZLTHk4?=
 =?utf-8?Q?S3BYEHEz34GJpiaftvPnnnovq?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baeef842-4630-4ff9-0fbc-08dd77cd2f25
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2025 01:15:30.0770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KANhl/FdXK8nhT3HzwqebCybkb6cIAfvm87XGklpa4MZ0smSC5y3qeVnSYMgrZLq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6723

On Wed Apr 9, 2025 at 6:41 AM EDT, Toke H=C3=B8iland-J=C3=B8rgensen wrote:
> Since we are about to stash some more information into the pp_magic
> field, let's move the magic signature checks into a pair of helper
> functions so it can be changed in one place.
>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> Tested-by: Yonglong Liu <liuyonglong@huawei.com>
> Acked-by: Jesper Dangaard Brouer <hawk@kernel.org>
> Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> ---
>  drivers/net/ethernet/mellanox/mlx5/core/en/xdp.c |  4 ++--
>  include/linux/mm.h                               | 20 ++++++++++++++++++=
++
>  mm/page_alloc.c                                  |  8 ++------
>  net/core/netmem_priv.h                           |  5 +++++
>  net/core/skbuff.c                                | 16 ++--------------
>  net/core/xdp.c                                   |  4 ++--
>  6 files changed, 33 insertions(+), 24 deletions(-)
>

LGTM. Reviewed-by: Zi Yan <ziy@nvidia.com>

--=20
Best Regards,
Yan, Zi



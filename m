Return-Path: <bpf+bounces-68076-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE0E3B52673
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 04:28:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D96A71C26299
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 02:29:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B3A20F08C;
	Thu, 11 Sep 2025 02:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q5c1MHCB"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F2B212559;
	Thu, 11 Sep 2025 02:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757557721; cv=fail; b=hgp8p6HE15RgYJirSabRJjxgYxtUDXFl4/F+D6ryYKjRu1CvECoTGVFu2LJExh77edBM4P+ygMHr+sNwbtNH6/zGp8FZoTYxegTF3+eVNqqZZRE0x/qNSwbROEC6yP8/0MH0fvVEqJ1qTBhH5ImliYx+M1TebF0611lZ3whxumw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757557721; c=relaxed/simple;
	bh=n5OJfiKHUxuEcO8+bUob48TU20Q8+8rKWTyHUNzfX9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=b3l5Mg0lq5elFkkklu8hbTbj/WpDcFVXVEQgA+PNCqxVnzgMgYQAy80MmKatUGQIaN4F7R49vtBQseU1GcphOK9OCGiKe4fzp9ZjpU6UrWwUKoyDJUSc/TCoKyzoQs3achMLBJLEqcC71rbKBRsKDDQJbTj3DEyWqvIuVpDaVH4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q5c1MHCB; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=usjXpkL2oW/fe2B48XLCmz1/YXT3+WiziQW6WN8O16z6roI7MB34+PoosLwobHYPLM5OUcFa5A22Yo5RnjcBFKwfnq2aZ7rkmeH0uh6OOalFEPUFGl4hr9FfVZiUr56HV96aieADk4dn96jxxTi+spD11oTX9tTGUVRLc13AC+zuA+SgIqQ4bMMIVnUJ3VGAv1APWmTDhdgskDyhSTwY5vcsxu0wfPuhIlutKQZImb4GUORZN/vBydyioA9m4tFoX2pOXOedHYanJCQXoFBGWJ1/ZuMlqbI2ZKTgkykMgn6pAqatQOg6h9s0bKp+T2mdDcbqk0OccXTyOInfbcdZcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTF/LkZntMnAwuF1n5S+0DkuAzP4GjcW8Ztek+rgLEk=;
 b=mq4/rn+DgPc3Gui3o/JLEGF6FNppcbUi+ORW5ibFyDoKRRw4d6LpLYdUTvKkxpO8w2Kn3Tdfl+RqfmXLxMUMl4JzGIj/pWz1UKM0M6qoa0l9Upe8UjL0PIrCgfHu6B6RcljxBFLJ22nrgZj7FEUN6TgC5SfVvJEjCAgmT5qgEOkB+i4VWayP9qrHbe6kJzCI/RndKzNlVvMvwqJ2HxTWFLSrDeWsCRPwHV86KLyISNwpLH85W5+Tkg0lJLiXHJf4ESR8f+P+PLyyV8yw79L9Bbh5RMq/J0wRqBHvTKnpeUVqroEOjacxfSDsrcQmDkRAYXezpknCaOg7vu4Wr1HGbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTF/LkZntMnAwuF1n5S+0DkuAzP4GjcW8Ztek+rgLEk=;
 b=Q5c1MHCBXvuexdh1FmfNWoShviFn4fBJAzK8tewGGv1UyrQkZzitinmAqVKjOfZgdVVY3usI7YsPuWJVPol3zU7eBVcQrVboS33IasStw0B/MJ4y7+IagRVOEAGeKB7HtnyHdlzizvD7TgYe2U2O8/jMi30PhDkde0ev21kYhriq3dB67dJdsEhJaerkbZpTlnwEw/imBf7nWq/cCMs9oE46fshsucS4I/jCmDNG+sS0BPIkDI8FbRLUBXJIPFS2MjY7OcY8DJB6LTjiI3jKwuUJ5sqy7KdS/Xw7cSgc9RAFaMYEB/wETRJrkwVwTfjzCGNLa+haQKtL3EQTYG03Mw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 SJ1PR12MB6049.namprd12.prod.outlook.com (2603:10b6:a03:48c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 02:28:35 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%6]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 02:28:35 +0000
From: Zi Yan <ziy@nvidia.com>
To: Lance Yang <lance.yang@linux.dev>
Cc: Yafang Shao <laoar.shao@gmail.com>, llvm@lists.linux.dev,
 oe-kbuild-all@lists.linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org,
 linux-doc@vger.kernel.org, Lance Yang <ioworker0@gmail.com>,
 akpm@linux-foundation.org, gutierrez.asier@huawei-partners.com,
 rientjes@google.com, andrii@kernel.org, david@redhat.com,
 baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com, ameryhung@gmail.com,
 ryan.roberts@arm.com, lorenzo.stoakes@oracle.com, usamaarif642@gmail.com,
 willy@infradead.org, corbet@lwn.net, npache@redhat.com, dev.jain@arm.com,
 21cnbao@gmail.com, shakeel.butt@linux.dev, ast@kernel.org,
 daniel@iogearbox.net, hannes@cmpxchg.org, kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v7 mm-new 01/10] mm: thp: remove disabled task from
 khugepaged_mm_slot
Date: Wed, 10 Sep 2025 22:28:30 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <DF4CA2C0-25AF-462B-A6D2-888DB20E0DFA@nvidia.com>
In-Reply-To: <49b70945-7483-4af1-95ba-e128eb9f6d7e@linux.dev>
References: <20250910024447.64788-2-laoar.shao@gmail.com>
 <202509110109.PSgSHb31-lkp@intel.com>
 <49b70945-7483-4af1-95ba-e128eb9f6d7e@linux.dev>
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN9PR03CA0106.namprd03.prod.outlook.com
 (2603:10b6:408:fd::21) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|SJ1PR12MB6049:EE_
X-MS-Office365-Filtering-Correlation-Id: b961a1be-ed7c-4b80-6224-08ddf0dae8bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kIn2C7blM56LA+HDboelSZDlg2/aIBa1KOl7MVQcDxejoLVstlKi+3b8TyQI?=
 =?us-ascii?Q?DgExwL5CUTNme8VeEwbvopcxhsbyh0KcEqZsiGjTE7pu/FHFyXGmSg1Y1kXh?=
 =?us-ascii?Q?+st1d6/5URG2BPmrsTwzkKEJisT4goHHN3yBEVE69mQk4NI8S7rm+9PPA05m?=
 =?us-ascii?Q?nL/FcGUl42GP16qjlqqUx24W/cLyEq9p+n4fhbbnGp+FI9rQ+XBIH/++eu3s?=
 =?us-ascii?Q?BZfP7baM+nRuFpDTjLxBckCd506ZfYs8ErlqrMWv4w3rsP+bXFg3KsRiv2/D?=
 =?us-ascii?Q?JuFHOed0xgXKhUHJX4MLQ3qtokDVe/fb3gPkff541vBDlIaEmUo7SCbkVH0o?=
 =?us-ascii?Q?HsRBkm2TsAe4uad4+Ej6JMmKLAmInCr4kxgQD5JtZ/qshSzBndGm368ujO7I?=
 =?us-ascii?Q?B/N+SF3VSMKgWCfBtq9kTkgysCstXvzaMcB22o17GAbnKBPQFub7d/lLF4ug?=
 =?us-ascii?Q?fxpNCtVEhJmlS5z0I2Iytk9vDbS158TAAQ2/EOxxq5qAEBEAXL2JKVq79LCR?=
 =?us-ascii?Q?Bbmt2rvNRWeejWdUNzHLTyz5UFHQxuDfNG27LRhv67aav965wf5q/HRFLaz9?=
 =?us-ascii?Q?C6xbN5RfAAPvjGsSd481jRYdBOXlUuAbCRHbVIE3DWumKSg8q61UVXP9lMha?=
 =?us-ascii?Q?dyxTiJHPTibEid+bSpuOLXzwQ/UKsav7TYuC+P/YXMJmLUof9T6ulwtP12nV?=
 =?us-ascii?Q?Dkf0o2sSwTdVpxe7IR6gWa4masuXwYQto/SL2YNNBX8kgMN7tVbvUkBOwNmc?=
 =?us-ascii?Q?99EEYrAPDlIe9NAaYm/Ukj8sfCJSOLGh2YaxzEq+tme9seuw2qTw0mumnpBc?=
 =?us-ascii?Q?p8UxdtFvUxJDNDNWle5gQsC7kM5gx/CksYiXTwD1xxh/4uJXonK/ZvW6ekgv?=
 =?us-ascii?Q?uWAsK8Xc1NVBzVFUREXeMw/0GOzOHvZd7OH6pDlarGBSelKVslW8/mRMrHn7?=
 =?us-ascii?Q?r2XMLeCw6lzZYZB4AROLs8E/f1h++AwnTnxU/r6n5EHBz3aOjVZTXXX3pbMg?=
 =?us-ascii?Q?wjLblwz1Is6wn5XGrk+EwJykafkjn2U4Q9FW6CmOVGm3A0Fouwu0ihLCd0EB?=
 =?us-ascii?Q?S6MqilemcAvM3PYRkOb4eZHlwmzrQAz1o4iAr3R9U6ILWG7YwDt50bFIAefj?=
 =?us-ascii?Q?2FeBU1yYTUbgcW8WxQ3WuqHOed/1BTV0UhfFmoTJhmoBjRDK+rcYU9Fyx/vz?=
 =?us-ascii?Q?xxQbT46/ohUd+H3w1a+PuDuAoYI8skX0Rtfdce360hsgJod6Tj4YbL5N/yrb?=
 =?us-ascii?Q?Th4PBrt36/THpx+XaMNdUth4U0oay8p1JpgGYNt7Y19gxNNpHcki74pP433s?=
 =?us-ascii?Q?yFc4qpMSBsaOBjWeTZ2nv0PNuEzc083pk4wVdJJclNPccvvdaoA7DTZ2q/WJ?=
 =?us-ascii?Q?seewRy7sYTs1HSNK41an0Ou1nMQiCT7yrrFGs3lZlpH5J2gaK+r2bHy24aih?=
 =?us-ascii?Q?UTZGZGzfiyVyqHhmBTvZVYmUUA2Vq7QQ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q3oQY/ZZydBjHLY2wQSw7VO0n5O8SPXL8t+I8TQkhbKRAD2Hbv1fpdZZJxBW?=
 =?us-ascii?Q?V84fpexQlrytdt3Ni4iOLiMq7oX+Mg5e+ujRoz0IkDPmV8KgCGRLEoXwYRLR?=
 =?us-ascii?Q?igZdXHlbmGnjXJyJQbOi020I63hNyXExbGpHD6kMvdppGvGwEBD6JrKwOHnx?=
 =?us-ascii?Q?9fghm8+tywc/x8o9eI6Tu+HZiTKVy01ejvQyZLiA6isPsLwFs64bNL2xycmh?=
 =?us-ascii?Q?X0Zv7xHjXgPgQYCAbsboMcWULfTLo0/KS3TlN4Q9N+iPrJa6v40dwI2L5RO/?=
 =?us-ascii?Q?01djKnBl5J8d62KtzDoTcOWL7JeVZPln48mvcgcp4ZPut9LAwFwCvL8pZzsT?=
 =?us-ascii?Q?KqPElAkkfJtXVcIM92dOIoldUu9ApTKthJxMPl0REsRYQEkmi43OEwawbj6Q?=
 =?us-ascii?Q?OlRwy7NijQj2bqzFy9WRfE3DYL1M3GVN7HgyuUdKX77HZTjf2XRFSUlvnZBv?=
 =?us-ascii?Q?5uBbhMvOZY6mC+xnLTmr75uzlauaT29/FGLbpHKmk8YssfaYOetiYyU7khih?=
 =?us-ascii?Q?jyZlRRxG1Mb8NnSKtnQ+nXZ8hLQ/N2pDolC+b/DBmtBjqDllc5xNp8qG8q+X?=
 =?us-ascii?Q?w88jpSvuZdOGJAUnyFJyJoH7MtBt0H7WczYsLDEKYRUZpXbqNKbLXfI+WH6+?=
 =?us-ascii?Q?q2ePTj2ipFxbgBuOflOeBqNCLM2WCoauwqrU0zYlajrKg4NY6HvPwowflaMD?=
 =?us-ascii?Q?XsQdvCWSNdpHKjtXK7HlXT10g+RgNkH6hJqjiVXLJqCTcvOWKDdSL0a/5PKX?=
 =?us-ascii?Q?3dW/QOv7FcwEhdP5uPJVPAVLemcD0wxB+nRMKbGnSqbJYGZ0ntnH4IYR1rjM?=
 =?us-ascii?Q?+EEK6UPuVOj3SwXq1rmodZi2X7o0k/YQaVlBLZ/B1wTLtusVYtpyFLeYl01B?=
 =?us-ascii?Q?aTjjCReldMZKZzmgzN/IBohi7fouAvfIO6mruA4wtj49YNwoCQ8+E8NCjMCO?=
 =?us-ascii?Q?uHL4T+uBic0JaF6EcUUwNyL7u+HTCTZkWr3laFpDa8tmD+JhaZBRZBrFUnFZ?=
 =?us-ascii?Q?6U4ffF8VRlpYQwizesFhEeFK+0ZFDrPAbpqRXmOnqqW89QYGpouDiJ42bUi/?=
 =?us-ascii?Q?S9YdH2E2XuCIr7Zg4S1Uf25mEQJJtVKs1q+cAX5stCRDNCUyG7PF1T3wXlMK?=
 =?us-ascii?Q?dcrEmwGwoM4qcSwbIGfvE75B/DFiV+O/2OiaBDlaRKogfgiKgUuG+Gg4kE0k?=
 =?us-ascii?Q?AFVX42WSZs01sgRb+Lk1wBdwQo4In+ImoLjcdBjRbGFYo5nhKwmt5tORznJp?=
 =?us-ascii?Q?9Ut2CG7ZC/0SG5YCHQWT6xWyEh9/JVh3/V5GSoYjqQ4imK/jZswcEbvepfTV?=
 =?us-ascii?Q?zu6J4aouuT4PrK9EZ6YISOh9k58oTDIeSNnhUev4pkZIpyy+TGU8k8E9tvET?=
 =?us-ascii?Q?aIRuKBXI7tsrqFJ06i9al0nRHNjJaOEjKOp6yBBX11T6fq6pAR21xXKwqUCK?=
 =?us-ascii?Q?/PVbBaLS0FE83SSq1wpL/Qyegd/1xZVafgVbAWn4H8/cEdxHjrGD6LYm5SUd?=
 =?us-ascii?Q?SdRwk73RjlLA9fmEdmFY6FjdH6+Tyz/tc08lgoaFZreAtsZlMZxIWzeSh/dM?=
 =?us-ascii?Q?bvmh0bfyzTAveBYuDuaFWpSVF7rMVS/r0VhRr6Wf?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b961a1be-ed7c-4b80-6224-08ddf0dae8bc
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 02:28:35.6614
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tx0XAhgsFDR03ZdoGp+EBWxlV4EDPp1XiysOtk+/HHlrlwPJfyrDPQU7pR+epwnn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6049

On 10 Sep 2025, at 22:12, Lance Yang wrote:

> Hi Yafang,
>
> On 2025/9/11 01:27, kernel test robot wrote:
>> Hi Yafang,
>>
>> kernel test robot noticed the following build errors:
>>
>> [auto build test ERROR on akpm-mm/mm-everything]
>>
>> url:    https://github.com/intel-lab-lkp/linux/commits/Yafang-Shao/mm-=
thp-remove-disabled-task-from-khugepaged_mm_slot/20250910-144850
>> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm=
-everything
>> patch link:    https://lore.kernel.org/r/20250910024447.64788-2-laoar.=
shao%40gmail.com
>> patch subject: [PATCH v7 mm-new 01/10] mm: thp: remove disabled task f=
rom khugepaged_mm_slot
>> config: x86_64-allnoconfig (https://download.01.org/0day-ci/archive/20=
250911/202509110109.PSgSHb31-lkp@intel.com/config)
>> compiler: clang version 20.1.8 (https://github.com/llvm/llvm-project 8=
7f0227cb60147a26a1eeb4fb06e3b505e9c7261)
>> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/ar=
chive/20250911/202509110109.PSgSHb31-lkp@intel.com/reproduce)
>>
>> If you fix the issue in a separate patch/commit (i.e. not just a new v=
ersion of
>> the same patch/commit), kindly add following tags
>> | Reported-by: kernel test robot <lkp@intel.com>
>> | Closes: https://lore.kernel.org/oe-kbuild-all/202509110109.PSgSHb31-=
lkp@intel.com/
>>
>> All errors (new ones prefixed by >>):
>>
>>>> kernel/sys.c:2500:6: error: call to undeclared function 'hugepage_pm=
d_enabled'; ISO C99 and later do not support implicit function declaratio=
ns [-Wimplicit-function-declaration]
>>      2500 |             hugepage_pmd_enabled())
>>           |             ^
>>>> kernel/sys.c:2501:3: error: call to undeclared function '__khugepage=
d_enter'; ISO C99 and later do not support implicit function declarations=
 [-Wimplicit-function-declaration]
>>      2501 |                 __khugepaged_enter(mm);
>>           |                 ^
>>     2 errors generated.
>
> Oops, seems like hugepage_pmd_enabled() and __khugepaged_enter() are on=
ly
> available when CONFIG_TRANSPARENT_HUGEPAGE is enabled ;)
>
>>
>>
>> vim +/hugepage_pmd_enabled +2500 kernel/sys.c
>>
>>    2471	=

>>    2472	static int prctl_set_thp_disable(bool thp_disable, unsigned lo=
ng flags,
>>    2473					 unsigned long arg4, unsigned long arg5)
>>    2474	{
>>    2475		struct mm_struct *mm =3D current->mm;
>>    2476	=

>>    2477		if (arg4 || arg5)
>>    2478			return -EINVAL;
>>    2479	=

>>    2480		/* Flags are only allowed when disabling. */
>>    2481		if ((!thp_disable && flags) || (flags & ~PR_THP_DISABLE_EXCEP=
T_ADVISED))
>>    2482			return -EINVAL;
>>    2483		if (mmap_write_lock_killable(current->mm))
>>    2484			return -EINTR;
>>    2485		if (thp_disable) {
>>    2486			if (flags & PR_THP_DISABLE_EXCEPT_ADVISED) {
>>    2487				mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
>>    2488				mm_flags_set(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
>>    2489			} else {
>>    2490				mm_flags_set(MMF_DISABLE_THP_COMPLETELY, mm);
>>    2491				mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
>>    2492			}
>>    2493		} else {
>>    2494			mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
>>    2495			mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
>>    2496		}
>>    2497	=

>>    2498		if (!mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm) &&
>>    2499		    !mm_flags_test(MMF_VM_HUGEPAGE, mm) &&
>>> 2500		    hugepage_pmd_enabled())
>>> 2501			__khugepaged_enter(mm);
>>    2502		mmap_write_unlock(current->mm);
>>    2503		return 0;
>>    2504	}
>>    2505	=

>
> So, let's wrap the new logic in an #ifdef CONFIG_TRANSPARENT_HUGEPAGE b=
lock.
>
> diff --git a/kernel/sys.c b/kernel/sys.c
> index a1c1e8007f2d..c8600e017933 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -2495,10 +2495,13 @@ static int prctl_set_thp_disable(bool thp_disab=
le, unsigned long flags,
>                 mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
>         }
>
> +#ifdef CONFIG_TRANSPARENT_HUGEPAGE
>         if (!mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm) &&
>             !mm_flags_test(MMF_VM_HUGEPAGE, mm) &&
>             hugepage_pmd_enabled())
>                 __khugepaged_enter(mm);
> +#endif
> +
>         mmap_write_unlock(current->mm);
>         return 0;
>  }

Or in the header file,

#ifdef CONFIG_TRANSPARENT_HUGEPAGE
=2E..
#else
bool hugepage_pmd_enabled()
{
	return false;
}

int __khugepaged_enter(struct mm_struct *mm)
{
	return 0;
}
#endif

Best Regards,
Yan, Zi


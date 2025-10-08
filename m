Return-Path: <bpf+bounces-70589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BD1BC48F3
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 13:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3D0F04EFC24
	for <lists+bpf@lfdr.de>; Wed,  8 Oct 2025 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF822F6576;
	Wed,  8 Oct 2025 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Pm5cvewp"
X-Original-To: bpf@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3384E2EB878;
	Wed,  8 Oct 2025 11:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759922871; cv=fail; b=C6xppgcWmsmlbCqbzwVEXDkjK8rEBVa0vehX2ICLz+0k6qsGmr1ReRpk8+gSZiX/1w0cTiOXp/pAycMG+gUZVq2Mo9yPv0PQ/QpfMyxscHtGUvvmeh13WA3sF2wzaXFI/bQiIn12AS/h4LQbB2K3+33FxKR+rNToBDdfVWL6KdA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759922871; c=relaxed/simple;
	bh=KmYlJCGOwJeQt6J7GQE9BtURqSl5wKDjgmEw8fNVQS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=e/Ao2PFi1i/QDHk+Q5hGVAugS36dDSmQk6G33CNB/y1825U54ZSX3z1v9dD2imty2XUajCkzfC+W9qag+ifgVrh1rCJ4eSN7QkPFqOeEtbp2YM5WaKgdlBK8lVzAJ7QqznOmUiZBKjp+Mn0v1Z4hkhvSa6Zc6MfLCbazt58LY/I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Pm5cvewp; arc=fail smtp.client-ip=52.101.43.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ewl3SnoYDozBPS+ONYGZQ30ONDO2AYAT5lt6L3buUZd4aFNtC+N1oKANmtFnSLAQPGjTxR6SMg6guOjVF0sOf9JfPVtSlMJ5KutGtgNH4KPyqvAP9fYb+cctC0+4WMcRvTBBP8p7eSYSy3vJ8+aLqwYI0H7iKUqABAG9ZJsnLaM+9j2RYVwDKmwu7oO0VDnpEfpNovlTR27slpFbOSCu2C4iEmmV8zUxHpUlaWUzDZI5m+mT/5FutR6KGKvqug0Pj3MX7g++t/jlNtB9jr1A17UdCmBLhRsMhsExmrCy0Whsw4Z5NU1IPkZhSfSuc7pfyDQo2waX9OP0XuRu8t87mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lPLnRIzC4mUHjAUjB+XkOMyVPoZJL9+xGl5TZh9XDw8=;
 b=WhPp2WEw+uVLfugZyVWuK4BmH2e1ZKh3jYsXk1L7g12/oSvTd0zjLPOB1qqtA9GVmL5Pt2GEvpQTn4otfVmawgxxu/Fb5SwBt4SZEP5pB2AJrajWuaaJJDNySGKko2cALFi/+d4TmbUGyrqefiqwGUp76p9GLTALKXB9oNUrINKIYbtYj8fARvQDw4Ruthd0grK/K88p7CDJgVZruFa95MiagnZCPzMyG5kdCwgl+iUX1vq0SpWWSdHLSRot2UOaj+o+nX/Ak9OnOsJy+nAwq6kcxSom78mxrFVzzVGA5Dq0dqBv01eRuCpjb9rxX5LzMNJoQZyIAoCxMGkCdfTKrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lPLnRIzC4mUHjAUjB+XkOMyVPoZJL9+xGl5TZh9XDw8=;
 b=Pm5cvewpJNNDb5C1HMZQThmqpXjkivViQp03NyBR+pR7QxdwcZOoVBRggqwQYqh5SFo3mc6JBgBUyE5OB1auaeDREyJuWTJi0PkDpetrMVkv+ZU5LjJDCqG8hlJj41UIx5Vd7eLPKE1Cv89kvmba0Q+XXr0FCU/EF3qtmG//nn0l77Qy8HVMva+5iM8elCDevFqbzSy/HEg8b+YcXvqZ3GbXPXZ+6OXSPdejm0Mbu3zMQtmhHBXVbFHM3mFbDZcil3/KMUXQyDKpBVzkGdZfImupaX+7gUkwSv2+bqYgs+2CgpIvdZeYkDO4QTmEgoA2RrEZwiUzdv6JJYggUR5dNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 PH0PR12MB5605.namprd12.prod.outlook.com (2603:10b6:510:129::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 11:27:41 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 11:27:41 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yafang Shao <laoar.shao@gmail.com>, David Hildenbrand <david@redhat.com>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>,
 Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, baolin.wang@linux.alibaba.com,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Liam Howlett <Liam.Howlett@oracle.com>, npache@redhat.com,
 ryan.roberts@arm.com, dev.jain@arm.com, usamaarif642@gmail.com,
 gutierrez.asier@huawei-partners.com, Matthew Wilcox <willy@infradead.org>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Amery Hung <ameryhung@gmail.com>,
 David Rientjes <rientjes@google.com>, Jonathan Corbet <corbet@lwn.net>,
 21cnbao@gmail.com, Shakeel Butt <shakeel.butt@linux.dev>,
 Tejun Heo <tj@kernel.org>, lance.yang@linux.dev,
 Randy Dunlap <rdunlap@infradead.org>, bpf <bpf@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v9 mm-new 03/11] mm: thp: add support for BPF based THP
 order selection
Date: Wed, 08 Oct 2025 07:27:38 -0400
X-Mailer: MailMate (2.0r6272)
Message-ID: <96AE1C18-3833-4EB8-9145-202517331DF5@nvidia.com>
In-Reply-To: <CALOAHbD_tRSyx1LXKfFrUriH6BcRS6Hw9N1=KddCJpgXH8vZug@mail.gmail.com>
References: <20250930055826.9810-1-laoar.shao@gmail.com>
 <20250930055826.9810-4-laoar.shao@gmail.com>
 <CAADnVQJtrJZOCWZKH498GBA8M0mYVztApk54mOEejs8Wr3nSiw@mail.gmail.com>
 <27e002e3-b39f-40f9-b095-52da0fbd0fc7@redhat.com>
 <CALOAHbBFNNXHdzp1zNuD530r9ZjpQF__wGWyAdR7oDLvemYSMw@mail.gmail.com>
 <7723a2c7-3750-44f7-9eb5-4ef64b64fbb8@redhat.com>
 <CALOAHbD_tRSyx1LXKfFrUriH6BcRS6Hw9N1=KddCJpgXH8vZug@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BN0PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:408:e6::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|PH0PR12MB5605:EE_
X-MS-Office365-Filtering-Correlation-Id: 37d3d5b8-8b94-4cec-a1e0-08de065db160
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aDJ4UFNSd256ZzQ0SEZzUXRIRmlKMEhzd2gyUGg4cFVIcFR5VzV6eWtuLzlW?=
 =?utf-8?B?TWh2WHpTV0JCOGs4OFpYN1Z2OUFlMjZOQ3ZyWGlXMWZ6WVlWRzJRM2RlSVNP?=
 =?utf-8?B?c3pYUVUyNklSMnZFbk5FYlQzams0UXcrL3dmZEI1REZDbmhQZThzSzRNVXl0?=
 =?utf-8?B?L2RNRWZOOTJRMi9xNE1STWh1N2JZZmZaT09NRzM5bFpsWDlzV2tTa0xJeWVS?=
 =?utf-8?B?NW9haXpYREdXbUkxa3VvbjhWWVZtamlSSE9vbElpNzdUWkxLb09OMjdPSk5o?=
 =?utf-8?B?Y2JONkM4WkdMNFpkWGMzUzkydVBwalVmeS9BYW9uSDJFUFVhSzlYSGU4STQ2?=
 =?utf-8?B?d2tLWEQ4YTJwbUFFeEpxakJOb09nRExWb2xLaWdsUGg5N0twMTEyd2hkTlg5?=
 =?utf-8?B?SjNyTEdiaTBITEFZaUJlZ2dZaXRiNzgrM3FZWmdmSzl1VzRyT3VZTHI5cXJ5?=
 =?utf-8?B?UmxMajJDVjJMaC9UNzJLWU9rcFNLdSt6SUp0cHFoVkg3L2JWSVhCV2UwRWht?=
 =?utf-8?B?TUNhbWFuNEFaV3ByUTFGN3ZtZVBxTjVNbDF3T3YwQUw4YTNzR0k3NFZjZmtM?=
 =?utf-8?B?YjM0QXFlTjNLVHpKTGZhZ01HQUtrcHBvV0ZuWkQzVmpHTmU2cWxlR0U2ZW5K?=
 =?utf-8?B?WEdZOEtkSlppRjlTZ0NpK2ZNTGZGV01ZQWcvd2V6RmV6SXpxRGdoM0VxQzVn?=
 =?utf-8?B?djluRzljQlYyS0RqWmdsdEVRWEJGT1g3cUhJNEhmZ21ibnowTkJDS3IxVU44?=
 =?utf-8?B?Y0szSkZrb3pSRnJNOWo4RmlvWVU5eXpWSmZ6SlcwUDE2dXhUNHBlNExWbU1r?=
 =?utf-8?B?c011Y0FsU3Bma21GS01pU1Q0YTNVM2dpRldLL0NZbWZhVUFxTmJkbzZWRnZX?=
 =?utf-8?B?ZnRhR3R1akFweTM1cml6ZmFvSFZPMmdET3V0Nm1pbktEL0gvWGpoWkYrVHBV?=
 =?utf-8?B?QkRYVUpVS2pOcm9kM0t0bGRCR1dNbmJZTzQxTmdKOFpnV3NubWxsOFEraVUv?=
 =?utf-8?B?a1ZXODdWNFg4YXgzc2EvdDBhd3ZwUExHY2YzUjRMaVpOTVhIeW1RaktTT0ZU?=
 =?utf-8?B?cCt6Z1hQdjFLQUdTRG5uV0lTYXp4MXNBc0NhUzAwbnJKcEhCeUFTSVg2U2Y0?=
 =?utf-8?B?UjB0Uk13K2gyMUhLTGdSYUFZZklRTjh2cmU2cjljU2FrVHVBYjhBOHkwSHdX?=
 =?utf-8?B?RkVNNEJXSlR3aXk0YmxmcUhLclVWTERva3NRY2xNS2NLb1Noa0JyRUxOSWpu?=
 =?utf-8?B?c2NFWG0wOTUvbi93Ni9xTUVkMVJ5NDBIUTlnNGF5cStSeU5hY2pQazQxWk96?=
 =?utf-8?B?cit3TFVkc0tKSDNuUWxQYXh2MlNYRUJLYmhEL29nQmZ3NjRlVjN4U0V0NkxN?=
 =?utf-8?B?clVQTytjQ2RDNktqc0dsaFFsWUY5Q3RWYWdibUVTQkpnNUJXaGQ5WHhFSlk3?=
 =?utf-8?B?eURlOGZ2eUpHSTVxdnU5UHVub2Zlb0hHMzdnWVVDVHlNbFBrbitMZlBZSTZs?=
 =?utf-8?B?MjN1SU9nVjBaWkt1bnhncmNSbU1RbVpkRENlZnJDMjVJU3lQL0hlbi9LRjlj?=
 =?utf-8?B?K2F6MnB4WjdOMnlVNXk0TEJ2dGJKdjlEMW9HUGpia2pKazlsM0tyM2h6bEpF?=
 =?utf-8?B?TzdrWUJlc1BuMGpCbmJLOGQycjJRVWpvcWFneUJBVm9rWjVaUXZsNWhHRUpW?=
 =?utf-8?B?dUtmdHcydWFWT21LbDRuQ0hyTEVnenJhTXhjUnpyeHN5T2o3WmdoNkRiZXlE?=
 =?utf-8?B?ZnNvMVdoL2U4OWtBcTNqUnFkSFl3L3lXSFA2WkJSVEg4NjdKVk9aNTZyVFly?=
 =?utf-8?B?RXI2ZWhsZndrRkZIeEJYMUNQZ1c4ODZUME1YTVJlcnhJcnpYaG9ucGRLaktF?=
 =?utf-8?B?VkpxRTlEN2tHUzlCRU1VUkJjT2NJeHBTajcvQ1hXMlBJTjBGUHRlNUZibkF0?=
 =?utf-8?Q?zyK10TvqkVE0f7+3A1M2oTW8rvLWSTKW?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TXBURUxjVmN1Rm1pczIrNEJtTVl6cjk4N2lLT29NYUJhVUk0enExNUJzT2lr?=
 =?utf-8?B?VS9RS0ZvVzdxTHVvOVFCc3c5dmpzV3V1b3V0byt0TnBCNnhBYk9CNTlDdDlU?=
 =?utf-8?B?V2JnbmQzSno1UFFtTTkweDZJR2xmN1U5ejN0RDFhb3ErbFdHRUx3MC8vZnJy?=
 =?utf-8?B?TVlGaTJUcmZ5bzVKOTVabUttMm03YnRlNUhiSHdCQlM0Mk1KSCtLM2F1VXhz?=
 =?utf-8?B?emtMKzdJTjJTVi9CS2ZxWWh1NGRwRlNxOXpvU2VseXR3MDNkUTAxa3dnczRm?=
 =?utf-8?B?S1pQNDJnMDV2bERZeXZQcU95ekxGZTF2RGJvNHk3dTlUa2FHZmtQbjg2aG9z?=
 =?utf-8?B?YndSVnpWWDdib0lyNUE0YWtuRnZOa0RyVW82cFdQZkhJKzRiTFpaZlYyRFRZ?=
 =?utf-8?B?Nm1uN1ViVlg4Zy9qWWpMYmxvVG5peFdud2VpV0IvYmZIbk4xbDhGckxwaGVV?=
 =?utf-8?B?M3pieTFRa00zdlpRZXJuczY4Nm1aOWtvdFN0a1QxZm5LK1hFeDNZdWlCVXZv?=
 =?utf-8?B?bENORUowUkJFWE9waEpJQWFkUkVWUCtYdkI5a04vSVArZzlQRmd2aGpmd2ZR?=
 =?utf-8?B?N1lYaCtveHE3c0s4MzBFNWlrMkZXOXdjaHk5aWd3ZGxKSFU5WnBVcCtXRzV6?=
 =?utf-8?B?eGhiRnJ5ZUlCQURRYldMWDd5VmREa3k5K1lKWnZMZHJvcXJvZTFJV3l2em5z?=
 =?utf-8?B?U25YRHVCbE5kYWxWSU9ad2NVdkZrZFUwdXJFVUg4VDh3VTdWQUF5cFhVNnJs?=
 =?utf-8?B?eUh1RDBjL1F1ckdCVEMrQVp5QjBrOCtUeDQ4WGpBelBDY0VDVkJLYkNYRkFG?=
 =?utf-8?B?ZFhqQlNWZ0h5a3ZyY1dXUURKVW9nczRrZXU5T1VHMzZFQldJbFVWU2h5bGlI?=
 =?utf-8?B?WFdSS0pnRHdOalpEc0RaU1YxbnpIVnFqR2l0VHRkQXhiZnVvN2pzK2RkczB6?=
 =?utf-8?B?cjBpWGwyZ0dhSDRQKzBJL2IyTTRRTGdaUGNmNDErR3M5cEQyNUFtNmpmNm5U?=
 =?utf-8?B?OHg1OVZUdm5jbTlBTFp0V3hlQUpNR1d0Nnhza1I2aE0wNGVRYnV0cG5BZVNL?=
 =?utf-8?B?THNvQXY3ZElDN2ZVa09CUSsvcTN4ajQ1Yzc3RTNUQnNIVHhmbUFLVnRKZGpy?=
 =?utf-8?B?RkxRZXp3M1Y1R2QwcmxGQmFVZmkzcG9oVUY2UXBqZ2l0RGU0QnhubEhnM1RB?=
 =?utf-8?B?R1MzbFlSTGhwSXdKcFZrTEdqYWpwMlBHa0xiRVRKTDBQL200Y3NTN2I5a3Nq?=
 =?utf-8?B?MldGRnM1bmNOTXo2Q1U0VlNJYmlVTGJmc1BhczlhM3A3QjY4dFA5TEwwOEI1?=
 =?utf-8?B?NVVFY0l1bEZZbmlPRk95TEZORUNyQ205UDc0Zm1IS1V3VXVJYS8rWitmYmVh?=
 =?utf-8?B?Q1A2Wk5BRDhQdzlnL0ZGYlcxQXpHV0JKUzJBTTQ5VVUwVTRvanJneElTWnBz?=
 =?utf-8?B?UGhPNUYxdDlhSWltRE02T2FSYjh2dzZNRzFkV1Q3TDE5Q2JNREVib1RSejFL?=
 =?utf-8?B?c3ZZVEhRZWpRM0VFQ0FsbWF2aGZRVnBwMWdLbE5pS2Q5M2dVdXN1WG8zVUZk?=
 =?utf-8?B?WnF3QW9VU3IwQ1ZsL3kyQmVsWVJERU1zSVplNmtkekxxckcxZVMzUEllZEM3?=
 =?utf-8?B?ZTVKWTBWQyt3MERteWNudDBNVmU1OXp2R1RUQmc2Vk1BVFJOMXlXVVdhT1dh?=
 =?utf-8?B?NE1lVVFXMEFUOFhnK2ZaMnRKMGVCT0E4UmwrK0lhMGpMZ092UXkzcWVwOVl3?=
 =?utf-8?B?Wk9aY3p5eVNFNE5RREZ4bGlFbzJ6OStKa0xEWCtHeWxaWDFXN3lNMEVJU2NE?=
 =?utf-8?B?WWY4YXFRMXNZNTU1VS9ieTA2OVFHM2crYkxldjIyQkhsLzcwdmg3STkwREtv?=
 =?utf-8?B?dk5vTmFQTVY0dEMvSVhtNlR2SjhGV3VoVTZyYWR3V0RxRU1TbkcrOExkOFNI?=
 =?utf-8?B?MUpzdm1UZ3k5ZTEvSTAyVU1FbVUwa3BXNklHL3ZHREY5TVJDSUd3YzhYZmtS?=
 =?utf-8?B?NlQzMVIrZG5xN2lMNXRkVGVyR1R5STFpaGVBcjZzS1lEYVlvRTFyWlpobUJG?=
 =?utf-8?B?RzRUWThwcTVQbmVpV21VbldJZWR3SHBleFhLYzIySkhJcjZrUnNaaXBxM1U5?=
 =?utf-8?Q?TLC4VM1uI83qdnsbdWaH9bnV4?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37d3d5b8-8b94-4cec-a1e0-08de065db160
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 11:27:41.2383
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V7nRJhPgfwBGFRwsbcywVBKBTdkInGv2Ana3xy30jPhZCKCYhuZi1i9P7ohT4LMH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5605

On 8 Oct 2025, at 5:04, Yafang Shao wrote:

> On Wed, Oct 8, 2025 at 4:28 PM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.10.25 10:18, Yafang Shao wrote:
>>> On Wed, Oct 8, 2025 at 4:08 PM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> On 03.10.25 04:18, Alexei Starovoitov wrote:
>>>>> On Mon, Sep 29, 2025 at 10:59 PM Yafang Shao <laoar.shao@gmail.com> wrote:
>>>>>>
>>>>>> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
>>>>>> +                                     enum tva_type type,
>>>>>> +                                     unsigned long orders)
>>>>>> +{
>>>>>> +       thp_order_fn_t *bpf_hook_thp_get_order;
>>>>>> +       int bpf_order;
>>>>>> +
>>>>>> +       /* No BPF program is attached */
>>>>>> +       if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
>>>>>> +                     &transparent_hugepage_flags))
>>>>>> +               return orders;
>>>>>> +
>>>>>> +       rcu_read_lock();
>>>>>> +       bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
>>>>>> +       if (WARN_ON_ONCE(!bpf_hook_thp_get_order))
>>>>>> +               goto out;
>>>>>> +
>>>>>> +       bpf_order = bpf_hook_thp_get_order(vma, type, orders);
>>>>>> +       orders &= BIT(bpf_order);
>>>>>> +
>>>>>> +out:
>>>>>> +       rcu_read_unlock();
>>>>>> +       return orders;
>>>>>> +}
>>>>>
>>>>> I thought I explained it earlier.
>>>>> Nack to a single global prog approach.
>>>>
>>>> I agree. We should have the option to either specify a policy globally,
>>>> or more refined for cgroups/processes.
>>>>
>>>> It's an interesting question if a program would ever want to ship its
>>>> own policy: I can see use cases for that.
>>>>
>>>> So I agree that we should make it more flexible right from the start.
>>>
>>> To achieve per-process granularity, the struct-ops must be embedded
>>> within the mm_struct as follows:
>>>
>>> +#ifdef CONFIG_BPF_MM
>>> +struct bpf_mm_ops {
>>> +#ifdef CONFIG_BPF_THP
>>> +       struct bpf_thp_ops bpf_thp;
>>> +#endif
>>> +};
>>> +#endif
>>> +
>>>   /*
>>>    * Opaque type representing current mm_struct flag state. Must be accessed via
>>>    * mm_flags_xxx() helper functions.
>>> @@ -1268,6 +1281,10 @@ struct mm_struct {
>>>   #ifdef CONFIG_MM_ID
>>>                  mm_id_t mm_id;
>>>   #endif /* CONFIG_MM_ID */
>>> +
>>> +#ifdef CONFIG_BPF_MM
>>> +               struct bpf_mm_ops bpf_mm;
>>> +#endif
>>>          } __randomize_layout;
>>>
>>> We should be aware that this will involve extensive changes in mm/.
>>
>> That's what we do on linux-mm :)
>>
>> It would be great to use Alexei's feedback/experience to come up with
>> something that is flexible for various use cases.
>
> I'm still not entirely convinced that allowing individual processes or
> cgroups to run independent progs is a valid use case. However, since
> we have a consensus that this is the right direction, I will proceed
> with this approach.
>
>>
>> So I think this is likely the right direction.
>>
>> It would be great to evaluate which scenarios we could unlock with this
>> (global vs. per-process vs. per-cgroup) approach, and how
>> extensive/involved the changes will be.
>
> 1. Global Approach
>    - Pros:
>      Simple;
>      Can manage different THP policies for different cgroups or processes.
>   - Cons:
>      Does not allow individual processes to run their own BPF programs.
>
> 2. Per-Process Approach
>     - Pros:
>       Enables each process to run its own BPF program.
>     - Cons:
>       Introduces significant complexity, as it requires handling the
> BPF program's lifecycle (creation, destruction, inheritance) within
> every mm_struct.
>
> 3. Per-Cgroup Approach
>     - Pros:
>        Allows individual cgroups to run their own BPF programs.
>        Less complex than the per-process model, as it can leverage the
> existing cgroup operations structure.
>     - Cons:
>        Creates a dependency on the cgroup subsystem.
>        might not be easy to control at the per-process level.

Another issue is that how and who to deal with hierarchical cgroup, where one
cgroup is a parent of another. Should bpf program to do that or mm code
to do that? I remember hierarchical cgroup is the main reason THP control
at cgroup level is rejected. If we do per-cgroup bpf control, wouldn't we
get the same rejection from cgroup folks?


>
>>
>> If we need a slot in the bi-weekly mm alignment session to brainstorm,
>> we can ask Dave R. for one in the upcoming weeks.
>
> I will draft an RFC to outline the required changes in both the mm/
> and bpf/ subsystems and solicit feedback.
>
> --
> Regards
> Yafang


--
Best Regards,
Yan, Zi


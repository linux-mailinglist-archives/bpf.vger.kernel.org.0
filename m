Return-Path: <bpf+bounces-54777-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B271CA727C7
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 01:29:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C02B8189B15D
	for <lists+bpf@lfdr.de>; Thu, 27 Mar 2025 00:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8614C749C;
	Thu, 27 Mar 2025 00:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VrkmT3j7"
X-Original-To: bpf@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2056.outbound.protection.outlook.com [40.107.92.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A104A55;
	Thu, 27 Mar 2025 00:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743035368; cv=fail; b=FtrX3giZa7sqJh1+Lf6kf8cvt6PCop01tZuA2F3i6Mu/As838kAqyyriLzUffIAm/yTo+XMXVFID+O6Bds2XK82ZM+NoTR58E9M8JxeRSvlo0RQxE3Li2hdMBa6eeO/F/hX3rzC27ElyjlQo/jiz4VOW7eFRjaVkZyq16S8FPnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743035368; c=relaxed/simple;
	bh=Ci4AKpQGQed+olkkBXfOUaO1lgRQxsmeUa2XsQvREg0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KNmT8p6Fo7AAzAlYjQMLUhTXwvFabQHKDhUAedpyuCj5jgWp+LdGK1SfB0ZQ2TYgo69rlUDsK+9alObJylRzbCGW3u8HS3+6lu0HdBTEfhu+5iLy0GVo6Lso8CJVwcJTn7eJ/Ai/668TH6i6HDZSsOOJfl5VeeyERaKwRY5sSwA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VrkmT3j7; arc=fail smtp.client-ip=40.107.92.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KC+ZSzWQi6RXs4htJ9grXeaeTdr2UReE58AJIB8IqVvvnNqEinjVrMrBef0onUEqUItncpUxcCsPm2mQlQUTo53RTOJOBWgKjlSqNvMer+yz8RqjafV+pptV5PXS+6mK5oF0h9uqq4ymVR3NiOw4DSscDgp6W/MJrlu2jxGuc5ITGSlTpLumYaozvs+X4ClT7dyEfVDjkQ2v0J4pbSlNulH0brjK82wsiqLanAu5ERN5VMkbPB5DbesfyoFjRNqG6M6bh4DsvWNBV0dy85eQ5oGD/DIX2hsnDgHOink4Ijorgc4ihd+JPugEPzdlzQMFAAF4dKXfujl1z1u/DXCSDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=orjFiHkpAclC/eXbrqZUL/IE0nCq2pNQqDeKjXHszYU=;
 b=a24/aorPS+hxiEIUibSU1DyZR4NBJJiFizsFRrPiTJbl4V5R7XA8XyZK1S3LM/f/Dm+pbNriNycDB1JtJ0IaZjbMEaYXEQ1Vzk0eIxGFQNwa3HdhQHeEHFvUseBcDY4+dDma2eKFqVe+Kr4HooE28LD7sRQ2DdOSKuCh2vy666rdRLJfOivaC9X8wMV5eETYll2yPGoyojhI/6Z740/tXUQad4saksY9ekkvJRl27o+V+D2jQ2m/3UDnQGmX2iqwfa1TO1/K8QjjfZ5CWqf8rf51CBODhaCeSgRygB/Bd8e7dCfdUw+8XdIk6jN+n20bWDFI8xiOLsATSgV50JLn0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=orjFiHkpAclC/eXbrqZUL/IE0nCq2pNQqDeKjXHszYU=;
 b=VrkmT3j7CI+uYzHd5eb20t51vNOqDJqHCUqEUbtTeUOQz/E2usdmjt5m7RLMIBe5bVPSiB58i/rhF/Dejp+Vj8HowXI6L3N6T/nF5E0asA2NgzsgOUQkf4J2VGGgvg3sFsnB+PXoC8W7pRPtZkrxY+0McPD5Ed8+ZEcvY3zGuW6Xane3mjxAemHxd6BPB4vXx1XOEoMK65Y/7dCy0AhuJUB3wG44Ccv/d8eLXyL31uw1ejA0cIDnCQNOqe86s08egrMRdRIvGVuUniJBZ+edD3+Ni49e+jo/ysZbOJJrJHEgOWKdr8fLqfRjRV3i/ZX+hlVNzKiUaHP9Nh5I+g28BQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB7663.namprd12.prod.outlook.com (2603:10b6:208:424::18)
 by SJ1PR12MB6124.namprd12.prod.outlook.com (2603:10b6:a03:459::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Thu, 27 Mar
 2025 00:29:20 +0000
Received: from IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12]) by IA1PR12MB7663.namprd12.prod.outlook.com
 ([fe80::4846:6453:922c:be12%4]) with mapi id 15.20.8534.043; Thu, 27 Mar 2025
 00:29:20 +0000
Date: Wed, 26 Mar 2025 17:29:05 -0700
From: Saeed Mahameed <saeedm@nvidia.com>
To: Mina Almasry <almasrymina@google.com>
Cc: Toke =?iso-8859-1?Q?H=F8iland-J=F8rgensen?= <toke@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Leon Romanovsky <leon@kernel.org>, Tariq Toukan <tariqt@nvidia.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Ilias Apalodimas <ilias.apalodimas@linaro.org>,
	Simon Horman <horms@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Yonglong Liu <liuyonglong@huawei.com>,
	Yunsheng Lin <linyunsheng@huawei.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Matthew Wilcox <willy@infradead.org>, netdev@vger.kernel.org,
	bpf@vger.kernel.org, linux-rdma@vger.kernel.org, linux-mm@kvack.org,
	Qiuling Ren <qren@redhat.com>, Yuying Ma <yuma@redhat.com>
Subject: Re: [PATCH net-next v2 3/3] page_pool: Track DMA-mapped pages and
 unmap them when destroying the pool
Message-ID: <Z-Sb0Q-inlkdTopW@x130>
References: <20250325-page-pool-track-dma-v2-0-113ebc1946f3@redhat.com>
 <20250325-page-pool-track-dma-v2-3-113ebc1946f3@redhat.com>
 <Z-RF4_yotcfvX0Xz@x130>
 <CAHS8izMj2aBeu=TreUM-O3XNqqF75vb4rvMvf7pr8mGh+N_+kw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHS8izMj2aBeu=TreUM-O3XNqqF75vb4rvMvf7pr8mGh+N_+kw@mail.gmail.com>
X-ClientProxiedBy: BYAPR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::28) To IA1PR12MB7663.namprd12.prod.outlook.com
 (2603:10b6:208:424::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB7663:EE_|SJ1PR12MB6124:EE_
X-MS-Office365-Filtering-Correlation-Id: 1fbc03ee-04b3-4837-00af-08dd6cc66a70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UUczbm5kWis2VWdEOFlUajNsYTU1Wklkb2lIYWJ6K3VVc3p0UldSL1BIS2FS?=
 =?utf-8?B?djdOZS9Zc2Y1MTA0VThZaDlZdFlQUVZ5UGdoV3VFTE9uQW13a2NVYi9Ham05?=
 =?utf-8?B?UVNMVnhGWGFVclVpUlBRVGs0NVdJMHEwd1lyUG83UDgreHNrVU1kbW51SE9t?=
 =?utf-8?B?eUJ6V2tSUncwc0E0bjhDZzgrQWRNOTdWUk5Ya2NFMUF3OXZhQ2UwOFN6c2Ir?=
 =?utf-8?B?WlR5NzZZQmFnazA2R1NNa3J4d2VGU3hHUHY5VjY4SEhIV21GdlVxaWhMTWxq?=
 =?utf-8?B?YVNtT0F3NHRVSndXTU4wdEEvR1JKN3pJOWUwRGdjZ0IzOG1nNzE1K0VmR1JQ?=
 =?utf-8?B?M1dyeWxlVitBeEI2Zm9qOWZOc3lGZEU0ZnNqSysxeXIvMm4vMkdiQzVoWTEr?=
 =?utf-8?B?UmdGRS85ZG1xQzRydk9FTDZycnUrdEprYzUweFNMZm5tMlQwSXNiU2NrOGFB?=
 =?utf-8?B?SnQxaTZlcHVQeGc0YWRPMG9ySlFYdmovOFJsRUN0UjZldVFVL3c4Uk1JYnZS?=
 =?utf-8?B?TGIrMEFMczJGb0wyZlRwN1Q3S1BIN3BNd3lHaHRISmR6RlBXb0lMK1l4eXdq?=
 =?utf-8?B?ZEczd1pENkorZnNMRytJbXVHV21QcG83VkFaR0xBQW1KeFZKb2Q1bVkxejY0?=
 =?utf-8?B?SFhHYk4rRE0xNUhxZVg4YllKQUFVbG9oR1Nrdy9lUTRFZ21KWGs2SFpqeE80?=
 =?utf-8?B?M2hXT0pUQVFwMjRsOG9QYUc3Y1poeUpUOGN1dTUxekVTaXpqVTNRSjBVTXRD?=
 =?utf-8?B?SGlGY1ErUCtqUldrUTN2UytYcTlFa0lYWUZHNnR1V1FJOHZhREhPUTlhdk9p?=
 =?utf-8?B?bVEveC94cTR4YVZyVzU5Z2dhblRUdVRHR0tFRiszNUFqRHRoWE9nZkp4cW96?=
 =?utf-8?B?dklPZXMycmpNYndPMzl1eDZnUEc5UmZsd0F2WjQ5cGIvb2h2MHdISzBrRUVa?=
 =?utf-8?B?WlJRVkVrWENSaVlyd0VVb3FnYnFSMFY3bkZ6dUtyNE9FcVFQZ1ZZbDFyZkda?=
 =?utf-8?B?UDN3SUJwMG1hanQzWWlNMTFXYmNONVloQVkyYjNSUUM2RXRvS0dNVE1pYmRO?=
 =?utf-8?B?MG9sL3NSQS9lV3cwVXZMbXJMNWRvcmFKU3d6MG0wM1JPZS9sWDJSWVh2cTBR?=
 =?utf-8?B?cFhNa1NYRHBPYlBDSVN2aTdBZEpWSG5jZW1LbUdxUmhqNHRSalBTSVFtSTBz?=
 =?utf-8?B?VUdJNzd4Z0grTUhSc09lVHo4VHRnTGNuVG1WSUNUMUt0UWtvcHR3TndxSlBi?=
 =?utf-8?B?bnhvTlBuUlhwQVYrdGllYmxGejNsY2F2eHBPZ1hTTCtTR0F1eFNOMjdtWDBO?=
 =?utf-8?B?WlNpU3lzRVlDMDVKWGxIdk9SOWRjMnYvc2ZRZzRwai9JaTNuaDJTQmJKK0ln?=
 =?utf-8?B?U2RtdzRRemgrRUFKS0xCUWtGK2U4RUFWYkNoRFZZMk80NENTTUJsaS9JcWNZ?=
 =?utf-8?B?ZDdPRHVQbWFSRE1ta01MZmxRTnRBSFZJMS9wTFNmMGh6UkNVanZFTlB4VEJR?=
 =?utf-8?B?dFVtR1Z5clU5R3BvQ3NNSFROaGlxTFlsM1ZlUVpucllXK0U1UmlUYVkzejdM?=
 =?utf-8?B?ODIvTHhHSXpxeUx6NWhBSjZ1V2FFOUJMejNXUG5KU3FpWFpOeGMzcU9HZmIx?=
 =?utf-8?B?NzJUSEw0eTdSWWRXbnNEUXJZbGFsV1dnUjRUVlUvNURIVFZ1MDh2d3kvTVVR?=
 =?utf-8?B?RkppdU5ud0o3NzJhSmo2UkdxTHFUTkUvUmJXbzVibmFMNTBhZlpjcENGQ3Nv?=
 =?utf-8?B?cVNGT1hOVEdqYlFUR3RKZXlPekhPSUlzWjV3RElZeHNsUk9NR1pCYm5RYnRB?=
 =?utf-8?B?ckJCT08rempieEFQcjNteDB0d0xtSU5maGlPMU9NM3hqS2M2OEFTS0xsRFc2?=
 =?utf-8?Q?RRsBH+URhVg+2?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR12MB7663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0tod2RodjFzZ3BFOTdIVCt1YlMwdjVQUCtTUDNESlhYS01hWmNKWjlBT0dq?=
 =?utf-8?B?WHdBRTlqN3Fhb0plYXhXQU16KzlBTzFDdFBNSlMxTzR6QW1ZUTlkZG1JWk5u?=
 =?utf-8?B?VTQ3NmVyRUx0YjgxelQwZGxtbnRVMElMbTRHb3dQOXdtT21zYlZMZkt0OU5p?=
 =?utf-8?B?bS8yY2tqdzdMOW95ZVZHKzhXWVVveERuMEdXc2JnSS80Rks4RXhKNHNaSnps?=
 =?utf-8?B?bE4xTGRDYmRGWm9VdFljMzBRTE5Gdk81T0REOHN5NUdSSmErUSt2M2Yvc0xN?=
 =?utf-8?B?N0N4bGFBc21CMzlieGZTTmJxMGx5eUFKcnkxdXVYNWpCYmtCVW5uN1RBY1pF?=
 =?utf-8?B?K1RwNlBQYzVrNFdqdW5kb1pDbEg4YjQ3ZmRDU2VocXpQUG9wT2gveE9hSk1V?=
 =?utf-8?B?cTlqcmlvdjlQOU1aTWF2UE1xcGxWcEVRbjA1SVJyR0w2RytFbndXdHk5NTAx?=
 =?utf-8?B?a0k1NDU4WFZBaW1vM1NuMVFpdzZkak9kK00zUGVrbWdsUVh5aGRQM0lUMUtS?=
 =?utf-8?B?N2QzMVZlRU1GeGVVVldMa3FlekZFdmliQWRLWEw5K1VmRVF4c3VsM0tSeFVu?=
 =?utf-8?B?bS92LytUaEhhSDhjWkc1MVR1VlZscUJwUUVSSi8vemsrRzdWVXNMSXhWUGIy?=
 =?utf-8?B?VWtvbnNKRDA5RmxSQnU1YXlIUWlmdU4zY3BEQWt4QkJyeUhaU2FnOHhNODNx?=
 =?utf-8?B?cnRxZTNoVkZnR0oydHk5ak9JaVVJNW1tVUJkYTJMMy9sYytoRC9RL0NRSFNF?=
 =?utf-8?B?S2xha0YzR2srY2FGUWo0bW4raWt6WWhnam1mR0lKS2p0Rzd6U052MTFHQ0J3?=
 =?utf-8?B?WEhCK1RucXBSOGZCaGVNVnVSOFAzbW05UmphOG1UVjltT2p4aUxSUlZqZTVz?=
 =?utf-8?B?cjF2SmdKaCsrZTM3WmpmMVNXSTFqYkRxZm16ai9GT1Y3MktEY0UvbWNhYTNG?=
 =?utf-8?B?YVRmM1FoK1BKRlhyclI5SWlBOW9YbEptUzgyc1BhOW1jaUxhd1VJRENjRVMy?=
 =?utf-8?B?QjFXMnJXN0djZGJ3ZU1PVGo0U2NhSzZITHZsNVQ4TTZlMWNYaGJZRXpnSzE1?=
 =?utf-8?B?Ulo0N0p6OWRINmhENlJ2QitydW5hRUkvU0V6VVJtTHk3WHdsSHhPTURTNy85?=
 =?utf-8?B?TEtCdlByL1lLeXA1OUxGbmZIWXYyNklrNVEzUjl6dllhVWI2eHNqQ0dQbldh?=
 =?utf-8?B?RUNLaXBXWmNicEVhTlltVEt5ak5qei9VOWh3eG9JSmRvV3dqemM5eFFHWGFo?=
 =?utf-8?B?MkZ2Z3hoWlU3THBrNlpkdDgwaDJvYkZqRm9HcVhtaGFvRitCWk1DVmNzZGpK?=
 =?utf-8?B?ZWQrTnk1cHl1Snc3UjRHbERrL1M4YkRJcU1JejNTOUkvSk1BYXVQYXVNYmdY?=
 =?utf-8?B?bmVYYm9TVjdwa2czMVBrbHA0L1U3eXNoUWhpdnNoZ0IrR2FVVGhQcThHS1NF?=
 =?utf-8?B?L1VTRlRXVDR6YkFGS1Erbnk5aWM2ZC9iWSs2cVgwdFBnanZaRmYvZU1vSUgy?=
 =?utf-8?B?OFJndHlsTkpTZWhTb1p2WWV3MmtkMW5rNEcxVG9IbktuMDBNd1NPaEVhaVA3?=
 =?utf-8?B?SFdzSHlSanZKMTV4U1B4RXRBWFA2cnhoVmxzZmJLaTVueW5PUmRObkxzWXRK?=
 =?utf-8?B?REE1QW5scGRWc0pyNmErRnBqQlAza3dhTkQyM1RqR2F2cWlSSTdKTUk1SW00?=
 =?utf-8?B?dUxZZkNGRFFzY2FnZlhtWTJEUkk2VjZHdm5yd3dubkY5YytqYW9SeXIvWEda?=
 =?utf-8?B?TXlGQWc3N3ZnTGtLbnIzUzF2Ym5LZlNiTTYrc2VCVFM2M1JrdnQ0NXFlaVc2?=
 =?utf-8?B?aFV4eVAxa0l0S0Z2ellDREdnUk1CbGRYOWVWS1NhM2lub29BTnp3UXEwWkdW?=
 =?utf-8?B?aFozcWJ1ckY3bG9aVDVzWmhPWkxlMGlISnowR2RoV1lTeEZzOGxjREI2OGVt?=
 =?utf-8?B?NGtoZnBhaWMxcmdiNVlmdmZtKzUyUmdCbmVzMWZnaHNXeHMwSXpxSTV5UXBX?=
 =?utf-8?B?NmJJUnRLdEdtR0tPSktWdTlQbiszSUE5eUJoeHJpVGticmdiOEU1Q3JMVXZF?=
 =?utf-8?B?WWltQ1gxeWZidzFya0c0YWRoaFVHYXJTU0R5ekVIbmpESjBUbnFsMjJwQlF1?=
 =?utf-8?Q?8h+6RU0zIWuncPj1yyh6bn5d6?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1fbc03ee-04b3-4837-00af-08dd6cc66a70
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB7663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2025 00:29:20.4613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I2XbUhjllV5/Z4NwJWMi+n2DP0BuUdAgh93FjS+BVEAPvMv2d/HjHCovNzkTkIjEAO76UPVrYh8WLxIn0kQbow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6124

On 26 Mar 13:02, Mina Almasry wrote:
>On Wed, Mar 26, 2025 at 11:22 AM Saeed Mahameed <saeedm@nvidia.com> wrote:
>>
>> On 25 Mar 16:45, Toke Høiland-Jørgensen wrote:
>> >When enabling DMA mapping in page_pool, pages are kept DMA mapped until
>> >they are released from the pool, to avoid the overhead of re-mapping the
>> >pages every time they are used. This causes resource leaks and/or
>> >crashes when there are pages still outstanding while the device is torn
>> >down, because page_pool will attempt an unmap through a non-existent DMA
>> >device on the subsequent page return.
>> >
>>
>> Why dynamically track when it is guaranteed the page_pool consumer (driver)
>> will return all outstanding pages before disabling the DMA device.
>> When a page pool is destroyed by the driver, just mark it as "DMA-inactive",
>> and on page_pool_return_page() if DMA-inactive don't recycle those pages
>> and immediately DMA unmap and release them.
>
>That doesn't work, AFAIU. DMA unmaping after page_pool_destroy has
>been called in what's causing the very bug this series is trying to
>fix. What happens is:
>
>1. Driver calls page_pool_destroy,

Here the driver should already have returned all inflight pages to the
pool, the problem is that those returned pages are recycled back, instead
of being dma unmapped, all we need to do is to mark page_pool as "don't
recycle" after the driver destroyed it.

>2. Driver removes the net_device (and I guess the associated iommu
>structs go away with it).

if the driver had not yet released those pages at this point then there is a
more series leak than just dma leak. If the pool has those pages, which is
probably the case, then they were already release by the driver, the problem
is that they were recycled back.

>3. Page-pool tries to unmap after page_pool_destroy is called, trying
>to fetch iommu resources that have been freed due to the netdevice
>gone away = bad stuff.
>
>(but maybe I misunderstood your suggestion)

Yes, see above, but I just double checked the code and I though that the
page_pool_destroy would wait for all inflight pages to be release before it
returns back to the caller, but apparently I was mistaken, if the pages are
still being held by stack/user-space then they will still be considered
"inflight" although the driver is done with them :/.

So yes tracking "ALL" pages is one way to solve it, but I still think that
the correct way to deal with this is to hold the driver/netdev while there
are inflight pages, but no strong opinion if we expect pages to remain in
userspace for "too" long, then I admit, tracking is the only way.

>
>-- 
>Thanks,
>Mina


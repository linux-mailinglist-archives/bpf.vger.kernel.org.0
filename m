Return-Path: <bpf+bounces-61296-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E5ECAE487D
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 17:27:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EB6F3B010B
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 15:25:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4643C287519;
	Mon, 23 Jun 2025 15:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="b+jgEPVh"
X-Original-To: bpf@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06A812673B5;
	Mon, 23 Jun 2025 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750692349; cv=fail; b=bMz5blhnhxwiFhKoPvRyr/wTqpXeSsXvjWwl5vvGEVZ7xMXvaxOv78YsPDISNHBtqkUEbzazM9C6Q34tl1kUhrstZ+UX8+QuQrPieNREbJuNyzrOQpcpj1/oUXKwB2e057LvDLdw29U8STgdsDsycrXVy0/xvXR7KtbusQMgmc0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750692349; c=relaxed/simple;
	bh=7XDT6JQigX6828VefwdyAb6OactVG+P0jVF+CE/v/ME=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=pk8IxbDvx4DNXKGvSJ3KklQzhwz054Rc0V1MpIkFuhsZ6vKP4VoJj3ksMMRjZZJTuOim+hBWtlKcEDTh9um5hQNzKHTgfg1FMDgQAGjCGZ4fJgFi7DfTGyMElKR/A4ELLDLHKNAhtepFuDLjWdfQfdSfiJv+30qkxvFYxnY1Gjo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=b+jgEPVh; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FXKOrbthvfdZGLiEWQfbBJL3twNyvbQmCykKx2N8odqWQ7gCLGyDRBCx+P6hoq0HRfeJud0EH749/UsvIQDniqtn4ZZ+1qKszpjIRXKCxdn7jD+iKMP5437QFtIH5aj3qbjW65JU7HksiIpY6nLlGliGj7Bbz/fi1NclIEHNHY54BqdMGnPR5l+ZUjAzr0+6ZaAu7t9lfnfujN+tXYyTM+vYHlrllt2QAetSwjGd2/aomrRiC/tPr2Y/PaQazT6b5CIVxIifaJVuJzOJzGc4JGUrNbtLrp0aXq4y1gAqhsrdxW5CBt0dQHIBsGEphnFij0Pd+MVKFMVCj0a5mszC4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rN24WDTR2G0ejj2La7+MVVsA4KmDVTMo2ET3Suvm6TY=;
 b=oNnYxhRRIqshdPluqw+lgwjInbrYzw0OdFEw8XWU8EZ7T55evaMejkBV/g5W5FKYl3oXz++7uI2xML/1r/Wl+Ab0vKCFKwG+D8DBQ9QasbZBuWP9lZ5sehClF/3zJJc/2dLrFV7e7pjIMysXykhk7CUJZYRnxFZ13SYq5oKT2l0dL++gTyHewJpwQOI/PvvYNERmTCBQqsjdZqXKmYrK07xO7hHBtvLh9wyZhBKK3VKZ1bozEFTUd5OVGTuTb1Lh+VFkBvC7fJvKOLcoPP1gLoRqjHFBE2dBXYnX2NXIPaZyyw5hUkh3dQ3CoytUpNSNGgofT6pC8fJ0+Hf0v+Jghw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rN24WDTR2G0ejj2La7+MVVsA4KmDVTMo2ET3Suvm6TY=;
 b=b+jgEPVhAGonsbU8e2fs/u3sKgjYvcwY1K5GLACqANc1C9GIyy7eo4EMWOkLSdm8HZ2gF09f2+2QG2MQuOxNg9Hf59qX9BBJKEa7vl7DH6/vIMeZaJxK+RfpYnFizFpFJli3jhJhbsFVc64ltPp5JGzoeB/hZ1ZSFKhv+iD8EdObuSDkP30I8kwgMm+pMoDSuYPQ4RQhgbvq0/t4Grvp3vko422oZDoLW/jMUnZCJxsxPTT2N/GdiFy/JMUpTurvGghoM8ocTC+C4KpxX+ErrNSc7A2HG0IHXVDoeIkW/JLaelBU36STQ1B86kqKQGiK4HlExK+stghw2lfNr2rpoA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PR12MB8746.namprd12.prod.outlook.com (2603:10b6:208:490::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.25; Mon, 23 Jun 2025 15:25:44 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8835.037; Mon, 23 Jun 2025
 15:25:44 +0000
From: Zi Yan <ziy@nvidia.com>
To: David Hildenbrand <david@redhat.com>,
 =?utf-8?b?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@redhat.com>
Cc: Byungchul Park <byungchul@sk.com>, willy@infradead.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 kernel_team@skhynix.com, kuba@kernel.org, almasrymina@google.com,
 ilias.apalodimas@linaro.org, harry.yoo@oracle.com, hawk@kernel.org,
 akpm@linux-foundation.org, davem@davemloft.net, john.fastabend@gmail.com,
 andrew+netdev@lunn.ch, asml.silence@gmail.com, toke@redhat.com,
 tariqt@nvidia.com, edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
 leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
 lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com, vbabka@suse.cz,
 rppt@kernel.org, surenb@google.com, mhocko@suse.com, horms@kernel.org,
 linux-rdma@vger.kernel.org, bpf@vger.kernel.org, vishal.moola@gmail.com,
 hannes@cmpxchg.org, jackmanb@google.com
Subject: Re: [PATCH net-next v6 9/9] page_pool: access ->pp_magic through
 struct netmem_desc in page_pool_page_is_pp()
Date: Mon, 23 Jun 2025 11:25:40 -0400
X-Mailer: MailMate (2.0r6265)
Message-ID: <42E9BEA8-9B02-440F-94BF-74393827B01E@nvidia.com>
In-Reply-To: <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
References: <20250620041224.46646-1-byungchul@sk.com>
 <20250620041224.46646-10-byungchul@sk.com>
 <ce5b4b18-9934-41e3-af04-c34653b4b5fa@redhat.com>
 <20250623101622.GB3199@system.software.com>
 <460ACE40-9E99-42B8-90F0-2B18D2D8C72C@nvidia.com>
 <a8d40a05-db4c-400f-839b-3c6159a1feab@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0088.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::33) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PR12MB8746:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5f7040-f9dc-4104-2726-08ddb26a389c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?enpxQXlqU3pnSGxSMk5DNjhZMmxaakNrM2pGOE56ckoxQXFFN0JXbEhlK3Bu?=
 =?utf-8?B?NGFIcTYwZFpDVkpZWitzN3VqdXdBRjFTUE1ySWp3eEtJSDJvaSsyd295YVAz?=
 =?utf-8?B?T3JIRy9xZ3p5SXBZd05wQ2Y2SzZtL3BCRm0ya3dCa1lvSnJJTWtpbTVqSkp1?=
 =?utf-8?B?V2lITzh1aFhYUXovU1Q0NWk4L2dyZHRGT09vcFhyaXJaVEtsT09VSGl4VGll?=
 =?utf-8?B?OWZKSnplc1psbFltVGdDTExwSWJza0UyUk1PYXM4RXlYVzZFeEFFUk1OU0tm?=
 =?utf-8?B?dERqNldUSG1XUFBqRllwN1pOZ0hFMFRwTnRhMXc4NmI3SUN2Sm9OOVZiUGdx?=
 =?utf-8?B?amhHL28vd1lJdHVRQStWUmxrZFdvZEYyWU0xb0RXajlhWFBNZ09FbHZqcVhO?=
 =?utf-8?B?azk4akhHa1NEdjh5VU5MSTFyZ2pFSWxiRnBSelZxWFk5RVFrMHZLZTNPQ1gy?=
 =?utf-8?B?U1ZTZEU3VzhlSFhtclFuaWVsWUxIZkZTeVlqa3VKUTZJTC9SU01MbkVpamhH?=
 =?utf-8?B?YS95b2pyWGFrWFpoeFVnUGdrbFp5K3NESVMrT0dEN1RFVzFsUDlGTWZWeCsv?=
 =?utf-8?B?M215M1JQUlZWWDVkajZvUEJsVUpoR01aL1J0ZzM2cG5lc1VLbURHSDkwV01O?=
 =?utf-8?B?M0xTem9ZNjZwd2gxYi9CWklLVytjZnVOWXZuQSs2UUZ0UVlaRVB0djVoUXZ1?=
 =?utf-8?B?SVpUZnh6bGpZZ3c3MlJSSWQyMk9XMzY3ZG5NRHhjU2hpdFRtN1JmSVF4V2lE?=
 =?utf-8?B?NWtjaXJMdmZmU203azRyUFdXU2dQaW43ZTJCODRpdnRxVmxEbkxkRTk4Qllr?=
 =?utf-8?B?cjZ1T1dOL05IckF4QmlUQ3ZpYk1lNXdoVkVjZkdIdU1TemdIR3Q5ZVNhQW5o?=
 =?utf-8?B?TUxvRFphY2d5SHN5WVAyYlhqUDlJM1JJaWJrZEdaOGNjakw5enl6Nzk5Njdu?=
 =?utf-8?B?dml5Q3l1bDlCYVQ2TXJqTXJFa3kxTFhsSzRpdkN4QUJYMytyaTIzeXJ0aFN1?=
 =?utf-8?B?MWZoUWI5VTVYeVRQdWYvZzFvaEhxQ3V4TTZxVXkwbjdGanE4Qk04Yk9rbUxC?=
 =?utf-8?B?V1MvVFp4azh5Mi9Zeml1NGdycXdvZE1Pa1R1bjFUVlkzQkN6WXpacmdHeXZx?=
 =?utf-8?B?NEdRMmVUS294anRpQ1dobG5zMUNkRzZPRG4xVS9RL2IxVXQxcnZ3Z1VhWU5X?=
 =?utf-8?B?V0hKalhwYjB5RkRnM3VUTlZtc0hpY2ZMRGxTT2NURHIxYkxsTjZBcmx4aGFy?=
 =?utf-8?B?WlJxN1JHSkpxUFFuRFZqY0Y0cmxVWWc3N1N5ZmU1bGt6UTFJaW1VbnZFUVFV?=
 =?utf-8?B?RUYydmFUYlRSVHdkSllFY0dTVWFqUFJIWDVJRnhIN1JCbnAyZXJIT0NGMEo5?=
 =?utf-8?B?KzJXWEtobTJvRkxJMHgvWEwzL0o3VFVtdkNHa2NPekplWW4zcnAvR3MyMWpG?=
 =?utf-8?B?T2JrMGxvZGhOdmZDSDc3NTQvOUllSEV3R25vVTU2dUI3WjgzM0M1NFpiZnh3?=
 =?utf-8?B?aDlVTzYzQWYyZjZvYk16aUZPZStjVUxTcFYxUXRuYmhOSzd0SHZJNHB2QlpG?=
 =?utf-8?B?STltR2U0bkQxNUdJd0hnWUtiZ0duQUpJa2Q0ZjU0OWQ0bWNvQkl2RVBWcXFp?=
 =?utf-8?B?UHZmRWlkbldUVlNrNGtpU0ZoWGNuN0N6NWliR0dOTDlGZFlPRnRFMWxIeHMw?=
 =?utf-8?B?WjdRbkpTRUowN0NXUU5sSnRLMkwyWWF3V0dFMWgzSUV2NVpjcHR3Ujh6MWxC?=
 =?utf-8?B?R1I2VjNJekN3TjZiWG9qalZmLzROTlIvQ1lrUU1pc3d3Zk9WVlRLNE1jSzBI?=
 =?utf-8?B?VkZQS2ozZUNtZTgyRXdjam9mc1BHTmt1Y0ptSkR3bUdJSDVZb3QvZVRKeFR5?=
 =?utf-8?B?K1BQMGtCL2p3eDVzdHVUakhoay81M3ZmRVNIVVRWYVBOR1lmbmNqS1FTb1Bn?=
 =?utf-8?Q?KxLRsoHi7f0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b1MrWEpSZnlJY0U4Y1dCaGNPNGNlcW9MVW9lMTQ1aHc0eWFaMit4UE1rZ1g5?=
 =?utf-8?B?VVUvcFdLUWcyMm0xT1NpTHlLM1Z6U0d4a05IbThPSWtJTXJhd3BDbW9LclAw?=
 =?utf-8?B?by9sZjBWSytxQnc3Wk5iVFE2N21nOGdhek56Vk5xUDhoNUIraE15bnpubkZ1?=
 =?utf-8?B?bjRCUC9URFpyS2tlTnBXUGxkVzhFa2VvYkh6K245czJLOWlTRnpiV0ZrWEU5?=
 =?utf-8?B?Zk5ML0ZZeDkxclFyRkc0MVFMYkoxQi94YnY0T0tQTFJpeWZEOEVkcWpDNXRz?=
 =?utf-8?B?cVN6c0lIcXoxVkk2RHZJTDhlWXNDdWcvbXN4dVNuUzJ2SmZoZlFQTXY0ZjJU?=
 =?utf-8?B?TTRWMHBTaXZyMEk0dHRaY3k0K21DZmFMNFVlendJUXdnbTZYeXgvajJLcGR2?=
 =?utf-8?B?RTFnbEVBR2dtUnA4NXd4aVZ2NEg2TnppNy9lYlZCT2ZVOFNPbGFtNm40MnFh?=
 =?utf-8?B?UUVUSGhYczRSNzAwNTh1d1I5ZXBsaC9SZUFOREdNamxSYjVRTlVUNHN6NS9S?=
 =?utf-8?B?bjJmeTVCUExjRElpRVhkeklqaTc3aTFVYnJSblltMzFPWDNoMTJJSGNwRjha?=
 =?utf-8?B?QmhBT04wTUVpWkJWcGpkaDEwdjNDdGRZU0V1RTBRM2draTh5Z1JYWkV4V3dS?=
 =?utf-8?B?d1B2OGFVK0NhWmJabU9jWGNUbitVU3BlUnJDYnVKZmVVSWI2dURZQklENmo1?=
 =?utf-8?B?b2hxL1lLZFZ4RGF6M3JaRko3Rjc0R3RyUldPQnU2amY5bXNNUXNUTXJhTGEx?=
 =?utf-8?B?ZUZTbTU0enNWRFVvN1U2ZFY5dW42OXIrRFJRbUdNTkExdExMOUJ0KzQ0MHlB?=
 =?utf-8?B?MUtOMWRlZWVGbVZ4cnl6NnkrYXhQeTVpQk5PczNnK29wUFRKakM2SmVFeHdm?=
 =?utf-8?B?Q0JKS2tOZGFzWHJjNDE5L3VXRW9weGI0bzVJNUtSczlIa0xNNG4rRk1idkQz?=
 =?utf-8?B?UVI3OGFvUnlVL09qRHRlNWtDUC9Jd09UWjBLcFEyKzdYRk1KUEs4YWthb3Vr?=
 =?utf-8?B?enRSWjR0bnMrUDhDd2pNQWV4ZDR6aVhraG9hd2tRanlSYkJrcmxkQ2IzdWVO?=
 =?utf-8?B?T1lXUFc1bSt0bmhZSTl2bmgwbkc1eVRqcFE1OCtvZ2Ezd1h3WGpJVjFaN0hY?=
 =?utf-8?B?NUkyRmJXSkFzY29kM1JmQVlMMWtjM0poamcvWHZMWnhVa2tzMzZuWEs3cmMz?=
 =?utf-8?B?SHRRZFMxV09nMmE1aW5UbUZDK1NGSHpVVDJUQ2RNTnoyTUljemYwOFhCSkJt?=
 =?utf-8?B?MDhUNHUyRzNqY1d0cS91UVRESVpyQ1MrdHVNSVFTODZKcW9rTXVUQ3FMdHlM?=
 =?utf-8?B?U09kWkFxN0w3Ylh2dUNtMlZKbmZCRlk2YlJJVktOc1Z3TVRNZFAwdXM5dUJu?=
 =?utf-8?B?eEtTMzNocDF5Wm82SnV3bVVQK0QxbVhuU2JrdHZJekhkejRxa0d0c0NUNWZR?=
 =?utf-8?B?Tll3eTlMUDNWMHkwYlhKWXduWER2S2JKUktHTTJ1LzFjaWgyQzBONUg2ZDhq?=
 =?utf-8?B?cDFwSE42QjRDSVVKTS8wWU81cS93ZVJkRVB0TXQxSi9ld28xTGxHbXUvZC8z?=
 =?utf-8?B?bEVvUU9yL2MyamZ6T254L3AzRHdUcnJJbTVJdStBcjYxUnR6eGgzZGZkcjkz?=
 =?utf-8?B?THJYMjBFSG5TZUMzK2ErbFpNYnFEUnVhUUV0bEtmQnVndEsxYVVkajZIVCt2?=
 =?utf-8?B?YWV4ZHRUS3k1SUhPL2RIWXJpdlRlcDhrWnJtUTQ0RUpmMjNQS3pZSTJGTEhP?=
 =?utf-8?B?RW5zNjFWeEJOU3c0ZmFRbjVOQTcyOUxxU1Q5OFVDZzJVc28xRmFrUGxGemZa?=
 =?utf-8?B?WmFYejNZelNXdEYrc09XcnhETnVHcVYvMXJDMnVody8yVHZXV28yRThWS21Q?=
 =?utf-8?B?YWVXa0pQTjdkYWtBblVXaW5QdzFyRi9mM0NYTXl1dGtSMVFtNm9nZHhFOUhP?=
 =?utf-8?B?UFpuOHVQaFBaYm9xSXpQczBUQVF1ZzBTSlV1c1RDSHFUaHE1L3p4VkVQRFMy?=
 =?utf-8?B?OTBQRXJLaVB6U2loMUJGbHhGUzdYcU9rUVNGZnNtMGVzeW93RDYraUc3V0hZ?=
 =?utf-8?B?NDFMRUVaMDNkdWFabkFiTXJCN3BxemJvRDlhUlBpZ0NIbUxUUnh3MWprSFBN?=
 =?utf-8?Q?ViFtf+mp82ZX2OMEwW6aR6AEN?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5f7040-f9dc-4104-2726-08ddb26a389c
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:25:44.5836
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BpKmxCxFw60frWjQXSpaVQHOZHgI2bctKDUcKyJvJSWq4SFtJEpBBHsD+YkzSczu
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8746

On 23 Jun 2025, at 10:58, David Hildenbrand wrote:

> On 23.06.25 13:13, Zi Yan wrote:
>> On 23 Jun 2025, at 6:16, Byungchul Park wrote:
>>
>>> On Mon, Jun 23, 2025 at 11:16:43AM +0200, David Hildenbrand wrote:
>>>> On 20.06.25 06:12, Byungchul Park wrote:
>>>>> To simplify struct page, the effort to separate its own descriptor fr=
om
>>>>> struct page is required and the work for page pool is on going.
>>>>>
>>>>> To achieve that, all the code should avoid directly accessing page po=
ol
>>>>> members of struct page.
>>>>>
>>>>> Access ->pp_magic through struct netmem_desc instead of directly
>>>>> accessing it through struct page in page_pool_page_is_pp().  Plus, mo=
ve
>>>>> page_pool_page_is_pp() from mm.h to netmem.h to use struct netmem_des=
c
>>>>> without header dependency issue.
>>>>>
>>>>> Signed-off-by: Byungchul Park <byungchul@sk.com>
>>>>> Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
>>>>> Reviewed-by: Mina Almasry <almasrymina@google.com>
>>>>> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
>>>>> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
>>>>> Acked-by: Harry Yoo <harry.yoo@oracle.com>
>>>>> ---
>>>>>    include/linux/mm.h   | 12 ------------
>>>>>    include/net/netmem.h | 14 ++++++++++++++
>>>>>    mm/page_alloc.c      |  1 +
>>>>>    3 files changed, 15 insertions(+), 12 deletions(-)
>>>>>
>>>>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>>>>> index 0ef2ba0c667a..0b7f7f998085 100644
>>>>> --- a/include/linux/mm.h
>>>>> +++ b/include/linux/mm.h
>>>>> @@ -4172,16 +4172,4 @@ int arch_lock_shadow_stack_status(struct task_=
struct *t, unsigned long status);
>>>>>     */
>>>>>    #define PP_MAGIC_MASK ~(PP_DMA_INDEX_MASK | 0x3UL)
>>>>>
>>>>> -#ifdef CONFIG_PAGE_POOL
>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>> -{
>>>>> -     return (page->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>>>>> -}
>>>>> -#else
>>>>> -static inline bool page_pool_page_is_pp(struct page *page)
>>>>> -{
>>>>> -     return false;
>>>>> -}
>>>>> -#endif
>>>>> -
>>>>>    #endif /* _LINUX_MM_H */
>>>>> diff --git a/include/net/netmem.h b/include/net/netmem.h
>>>>> index d49ed49d250b..3d1b1dfc9ba5 100644
>>>>> --- a/include/net/netmem.h
>>>>> +++ b/include/net/netmem.h
>>>>> @@ -56,6 +56,20 @@ NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_cou=
nt);
>>>>>     */
>>>>>    static_assert(sizeof(struct netmem_desc) <=3D offsetof(struct page=
, _refcount));
>>>>>
>>>>> +#ifdef CONFIG_PAGE_POOL
>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>> +{
>>>>> +     struct netmem_desc *desc =3D (struct netmem_desc *)page;
>>>>> +
>>>>> +     return (desc->pp_magic & PP_MAGIC_MASK) =3D=3D PP_SIGNATURE;
>>>>> +}
>>>>> +#else
>>>>> +static inline bool page_pool_page_is_pp(struct page *page)
>>>>> +{
>>>>> +     return false;
>>>>> +}
>>>>> +#endif
>>>>
>>>> I wonder how helpful this cleanup is long-term.
>>>>
>>>> page_pool_page_is_pp() is only called from mm/page_alloc.c, right?
>>>
>>> Yes.
>>>
>>>> There, we want to make sure that no pagepool page is ever returned to
>>>> the buddy.
>>>>
>>>> How reasonable is this sanity check to have long-term? Wouldn't we be
>>>> able to check that on some higher-level freeing path?
>>>>
>>>> The reason I am commenting is that once we decouple "struct page" from
>>>> "struct netmem_desc", we'd have to lookup here the corresponding "stru=
ct
>>>> netmem_desc".
>>>>
>>>> ... but at that point here (when we free the actual pages), the "struc=
t
>>>> netmem_desc" would likely already have been freed separately (remember=
:
>>>> it will be dynamically allocated).
>>>>
>>>> With that in mind:
>>>>
>>>> 1) Is there a higher level "struct netmem_desc" freeing path where we
>>>> could check that instead, so we don't have to cast from pages to
>>>> netmem_desc at all.
>>>
>>> I also thought it's too paranoiac.  However, I thought it's other issue
>>> than this work.  That's why I left the API as is for now, it can be gon=
e
>>> once we get convinced the check is unnecessary in deep buddy.  Wrong?
>>>
>>>> 2) How valuable are these sanity checks deep in the buddy?
>>>
>>> That was also what I felt weird on.
>>
>> It seems very useful when I asked last time[1]:
>>
>> |> We have actually used this at Cloudflare to catch some page_pool bugs=
.
>
> My question is rather, whether there is some higher-level freeing path fo=
r netmem_desc where we could check that instead (IOW, earlier).
>
> Or is it really arbitrary put_page() (IOW, we assume that many possible r=
eferences can be held)?

+Toke, who I talked about this last time.

Maybe he can shed some light on it.


--
Best Regards,
Yan, Zi


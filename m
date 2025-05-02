Return-Path: <bpf+bounces-57219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F0CAA7104
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 14:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A89CD7A66A9
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 11:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA14224336D;
	Fri,  2 May 2025 12:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aHE6Jn6d"
X-Original-To: bpf@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2055.outbound.protection.outlook.com [40.107.243.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EE920E70C
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746187226; cv=fail; b=lvsObY6SaA0eNA43emKmKj/sjmHTopQPjpusPdfsDHndSbADf9v9YVapBc95sptMWdMcBjVdi3WrwIiuQ4B9QEd3ygESgur0pKbznErrAlVv0fueKrH8HOJbXd7M4lI7a8oZrvFtxvAGNMUZCLSUv6Nu06WSjEoWUXl64sbOKK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746187226; c=relaxed/simple;
	bh=i/z5KIe9hZ6nwmWNcQ8//4SIPw4r2GoULe4PAxn7SYU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=oGrt8MBkiocCFCPAoEdya8e/fiK3EpmuaoJ0gBMZJn1KRpGVfxyKsbk++ufmeE7QOmH91D2Pug7PDk55UuJAnIAp+vwAMu6DHyicGt9+cXPZFLKyIsbY/nyNvF/qOOlmjVOBS7Pnk351BagHrQ/9MugsTJ1l0o1gWYDA/RU7sY0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aHE6Jn6d; arc=fail smtp.client-ip=40.107.243.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gY9BP7PNtExTIjyIGsyw+6E1VRNBrSxPqWiyjJz5hxZSaNMUcTlQniEMZIcufFEIaZ20IePBCyB7w+mjT+I/Noh0jkdSvvHuTG5V7DSyvOe7VQ76GG3/Ro7l0pqlsBtH9tHCtJF9FUNdk/OmcXN2MN/2XaaQp3iftLcsC/t+tyK1oj63zUeoOjjDitlb+JnOMwYPvzvrgXojzAZ/IJGuYlxeYWLZhrIquiLJlxc5Y1GIVlzTodiYzwkQ8/8j09yqpMXPE0p5fxBIwuo1NGs01XqIU5oYU4AifX/t6JTwK0TQCQyVFbBN/jwBrEycIjLzdy3zdB66d/5Z54EYJEduaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u0A/3RalF6E01S5UwWyy6Ru9u5oRUwPqINgTzL5eV4k=;
 b=g9BT5pf4zF2dYGlBlv1jhlmwTdUcSEDvbFW5OsuBtAfEd1H19Ndt1IU0WL5EJdzcniKkm39JUgjKXV2vjXwpAiB3eIu81FOxx0BQal5LKy8fQSRjyC7v7xaxjOZ7W0eOwlNgVpYGUUzcTr7+m37B5Hkz2hA+kaQafJTwZwJhYb7+X7w7kQOgmw3raogu8nyb16+rCro9Q9er6IwpUSRaAyERbCJ53sFDHhtGjuART/essFPw1ZiI59VW2rQT7PlaRozPsfQORgxxr9i6fGzdWEILGoUYdVae8/rSRHi7iUQ1krg7e4afdFq4N8fFfY8M/DFz9wjbnsrlNs3hlYjbvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u0A/3RalF6E01S5UwWyy6Ru9u5oRUwPqINgTzL5eV4k=;
 b=aHE6Jn6dH2GIGuPWT3U2j5GngzW5KdoMfJ7cb2UXGjnrmN/EIwX9RfX5PWGcQbxhtLIHdcuZwCA5kovBENi9i9vqSyTrEjWkujfPe3r/cp6Ff+paRbSf3cBlc60K4cDrYN8WoO9Nr3b7gnAKqN0hf85qNNeQRCGQ+BiTkG2l65oFHgLyKaji6CLfpCtLBGhYWHNG4T2lxvJrEGxUddexRwDb1iyWPgPnfEp3pPwca8xyyZrxZ7i3Rm+aRMUf7JQWZC5SK7OBLHdt+kiWzzbT3ZN/cYV+ZKkECVyakR9Pykwt6YX4CLl+LGqN+JPzy3rbeVodR5A0mswrQcc0FaqxxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 CY1PR12MB9673.namprd12.prod.outlook.com (2603:10b6:930:104::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.24; Fri, 2 May
 2025 12:00:18 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 12:00:17 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 David Hildenbrand <david@redhat.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 bpf@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Date: Fri, 02 May 2025 08:00:12 -0400
X-Mailer: MailMate (2.0r6249)
Message-ID: <3006EA5B-3E02-4D82-8626-90735FE8F656@nvidia.com>
In-Reply-To: <CALOAHbDbVOzKy9yZxePZFY8XSOgoLT4S_c=VW8sbbU6v9F-Ong@mail.gmail.com>
References: <20250429024139.34365-1-laoar.shao@gmail.com>
 <D9J7UWF1S5WH.285Y0GXSUD30W@nvidia.com>
 <CALOAHbBfSat7-qOjKseEJy=w5MVF7um3vYKPCb0VMbEgw-KAuw@mail.gmail.com>
 <42ECBC51-E695-4480-A055-36D08FE61C12@nvidia.com>
 <CALOAHbCtBB81MKV5=rTM03qt=qCF-CWctCmF0xjxDo_sXwaOYw@mail.gmail.com>
 <8F000270-A724-4536-B69E-C22701522B89@nvidia.com>
 <mnv3jjbdqx3eqrcxjrn5eeql3kpcfa6jzyjihh2cdyvrd7ldga@3cmkqwudlomh>
 <CALOAHbCNrOqqTV9gZ8PeaS1fcaQJ-CkUcwvFsx6VjHTmaTHjgQ@mail.gmail.com>
 <ygshjrctjzzggrv5kcnn6pg4hrxikoiue5bljvqcazfioa5cij@ijfcv7r4elol>
 <CALOAHbCL-NOEeA1+t=D2F_q7UUi7GvkLDry5=SiehtWs1TKX1Q@mail.gmail.com>
 <20250430174521.GC2020@cmpxchg.org>
 <84DE7C0C-DA49-4E4F-9F66-E07567665A53@nvidia.com>
 <6850ac3f-af96-4cc6-9dd0-926dd3a022c9@huawei-partners.com>
 <CALOAHbDbVOzKy9yZxePZFY8XSOgoLT4S_c=VW8sbbU6v9F-Ong@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BL1PR13CA0427.namprd13.prod.outlook.com
 (2603:10b6:208:2c3::12) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|CY1PR12MB9673:EE_
X-MS-Office365-Filtering-Correlation-Id: 9807d2cc-3dbc-4250-75d8-08dd8970e7e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?c3FLN2hsaUk4QUxQakF4UkkzalRRM1Mrc1FiQW4vQnAyVjFObTM3ei9TMGRa?=
 =?utf-8?B?WkdIQTVZM29LMFdHNjlWeGFRR1h3VEg4NkptZ3BkdCtvcTNZN1R0Um9uaDRM?=
 =?utf-8?B?K3JweW5jV0picjJ5aVBJdGp1RXNJcms5Snp2Uk9zTmRMSHlTQnhHUi9rLzlz?=
 =?utf-8?B?aVFxczh1WjlhYjZWeTZMTDlOTXpUZVIvU0FhVFlzWXozRjRTTUx4NHhjc21X?=
 =?utf-8?B?TTRoY1p0ckFHelFaeTE1UmVIS3NoYm1OWDhXR0t0bzkxOEprK3JxTVlRL214?=
 =?utf-8?B?Y0grUmlPZUw5Qy9GRmc5TjdNTHNYa2dqZUFXWm9wOTU3eWRiRHQ4OG9MWTBD?=
 =?utf-8?B?STQwOThkdVlTY2xxTm4rUGp5QW5PUGd0SndkUDUxWjJ0UmdtS0xySDZoNHZF?=
 =?utf-8?B?STFTMkVqR2V6MEhBOFJuVVkxcnZqNGFMdVhaYnQyZkhESW1OL0dnQkE3VGk3?=
 =?utf-8?B?dUhja0F5RzZXU1JzVjJUdXVKa3U0WUZLeFpWVHRUUWN2dUIzcnFBckFMdHps?=
 =?utf-8?B?Q0lobHNFend5VVZDQnBEMVpic24yRXNrdHpkZGVBWVNyQ2ZRc3hQL2ZVai9P?=
 =?utf-8?B?eGZqYjk0anFQZnpHdjRWQUNlUGVQMXpld2tRQ0huc3NUSnhIcnQ0UFVrbnFY?=
 =?utf-8?B?cHpjOGJNajdsRFNYYllrdGQzLzA0T1phYTVkUFN2RHprOGRqOFhzWGV6OG94?=
 =?utf-8?B?dTYrT3VPQnUxT0x2TEZDUFBrUlN2V3JzNWVQaXRGejNvZE9TUE9JazRqQ3Zw?=
 =?utf-8?B?ckNlbVU1ZXJsbzlWbTQ5ZGFSOUZna0NaZFJvZE1HcWJwQXVqL3QzdHVkVW1F?=
 =?utf-8?B?SVpzMU5zOG9SZ1dUYTRCUEhPZEFRd01EdmpvSVhRWlZ6YjJTN05lK2ZGSnlj?=
 =?utf-8?B?dUZ3SU1hallybjIvYnFzYXo3c0liTWIvMEcrTkVucnIvR3piUUV5WDM5My9L?=
 =?utf-8?B?U2tvY253czlxekYzaUE0WmpMeDJsSFBiRG9jODlQakltaWNOeTc4Yy84enZj?=
 =?utf-8?B?dnN0dWZtMCtkYzdsSjdNc2R1T0t0ZndYNjc1Z3ZkS1pNYVdLY1NnekJQNGtL?=
 =?utf-8?B?WDdMUFYraS80c1FNd0FIVm9zVjBGa0g2cmNJQnNHVXdNKzVOLzhZWkFPZElq?=
 =?utf-8?B?eFRPY3JYWFZRbWQ3T0ZuQzVGbTR0Vno5ZEgxMEVoWEIzbWVNTU9iYzhTMXdR?=
 =?utf-8?B?VkdrVUpzT0lRdlBkN1R0a25sbFZ3Y3lxSzF3SUpXZk82cnN4Tzc5eFJIbW5Q?=
 =?utf-8?B?MDVucEp5RzVDUzFDVGhGQ2Z6Z3RWY29jd1Z2eUZlMFFFY25ESVZLRE5Tc2Nh?=
 =?utf-8?B?Z1Y5TDhMRGZzMjQyZkFmTmlqMVQ2SkFqa0ozZnVIdTFZNHF1Rm1LbEt5ZXZw?=
 =?utf-8?B?cE1hTUJudmtDYmpVQzRnVzM4UU4wYVRGSEUzcWZZK3pmMm5USlhadFJ0Wlc2?=
 =?utf-8?B?QlI5V0pRZzFGd2E2eXNadW51cC9NaHNJdXgxeFhuSXhReWpMS2RPQllEd0c4?=
 =?utf-8?B?L2VQcUVNeExnek1ZSEs0QnRxb3I4SUd2UDRpSkFBS1I3cG1IUGlvS1dETmdY?=
 =?utf-8?B?QTlycTNIYXpSc0NReUVBTWlncU5BTmJsc3NhM2RkK2dRNEZVV3ZVT3FLeHMz?=
 =?utf-8?B?VWVLU3d4eExUVjFITmRZbXhuZDNTYSttUG9rc09WZUpFSC9pVDQ0UElUTFpj?=
 =?utf-8?B?SlNETkFYaDFSTDdYd0VCSFdPRE92Tm1EanFUUEhtQ0gzOVQxU1U2VjlWc24z?=
 =?utf-8?B?bjcvc1dMWDJNc0JuS1IreDBBc3I5RTFkb3lJWmQyTmdNUEQyODJUeVN3Y0Z0?=
 =?utf-8?B?bjNjUGNGWkU3MjVvcVpjRDJ4dFNIQ0lrdXJSVm1aQUFXekl2VlgxSUN1MEY0?=
 =?utf-8?B?Y1UwMDBvUitET2wyWFQ5VnpRUStVaGNYM2VlTzYwd2tXT2RUcUdWNkIwd2RJ?=
 =?utf-8?Q?h8U2sgqvQOQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WUJpdllFUEVReUhmSGpPQnN4R0Zob0FmTC8yVUhRdGJWUFZPcXJLVFlpU3dN?=
 =?utf-8?B?LzQySmtrWlF5SVBzMmNaY01raS9IVjl1aXRxaUlHUGEvMy9ISG43K1p4MUlJ?=
 =?utf-8?B?Y0lhSDFJZG04bFpQZUJJMWY0VTlCWHVGamVqSTNUMWowdWpUSVVVaE5pU2Vq?=
 =?utf-8?B?dGY4L01lcGEwbFNNckNUKy9lcldxTTdpZTBnMUovamVtUWdqWStXU1hNOHNT?=
 =?utf-8?B?R3JSK2YxNXl3dGdSTjVXbjB1MFd5cU1ORXA4U2tvNUVmUndwUG5MUkxLcHBj?=
 =?utf-8?B?ZmxCa3ZYdElvdUFYbUdPOFI3aUZwWXFwaEV4cEg0RWpOOHJ2M0JqWGVKKzVS?=
 =?utf-8?B?enpJOHhmbjMwdmpwN1JsdnRTNmN2bGxsMXBRY2lOdjVlQUJVQnJsWTdtckx2?=
 =?utf-8?B?UVdUVUN6L3RCbFhQdE4zRWxNZW9pcktZd3lxV28rdGpkbGp1Z1FOQjFJWlpy?=
 =?utf-8?B?cWlRU1VGZVhzQVAwaUl4U2g3VHVRbksvWnpOK0FEbjRLcDN0MnRCK29MaDlm?=
 =?utf-8?B?ZUI4M1hCMUNnWkxCYlJ2blJNVXNLY1JTcURiSHJzeGxWV1VNWlVrK20yYTJI?=
 =?utf-8?B?STlNTG9NQ3FSUTB3d2svaktOeTB5MVJLVFo4dFlVemEzOU5KQ1lyUWdVcjVq?=
 =?utf-8?B?SEw4YmNBRjVzOHRJOHNSZDhnK25mT1pzWXUvUUhFRUtKWlNNZWpXM0dodnZX?=
 =?utf-8?B?Y1ZOTmlVUlBRRUNpMlV2VWNTUEFUbUhhUVJmemtJeE5OS0VrWUpsT0x2TjRy?=
 =?utf-8?B?VkEzWHczaXNmU004Y2lOaXg3c2dxSGY4UXFJZ1IvMTl2OHVlQkxoRmxVMFlh?=
 =?utf-8?B?REREVmkrbkNrMWV5UDEzN1hlRTRnQnZ0SzlyMVJQak1KYUlBTWVuTlJUa3NW?=
 =?utf-8?B?R3FMYWJ4bzYrZGhwNjFRWFJZTnJUUDhWSnZQSXk1VE9LTHRYME16Yk9sUjFu?=
 =?utf-8?B?ZVNhcGRBMWMyVmU5TjhXZ1ZPcFdtWXBSQWM1dlNSQU9XZExheGQzZnloaUda?=
 =?utf-8?B?a1JRYXlxZzdCS1hPNnluNGNZN0l2UGpVa3pJVlNMZmpGU1VnMlBoeVkrTnI4?=
 =?utf-8?B?K20rb1FlWVBDTXovWHVCc3pPMzB1SEthZnVDTS9mQVZUMXZUQ0xOeis1dUJL?=
 =?utf-8?B?WXdsNjdyUk5Yc05DaUhxd1Y3dXE5TVNoWVpzWWFvSjlRM0g5VlpwV1Fucm5w?=
 =?utf-8?B?WFFJdlNQSndmVVdrcHVoYm5YTVJhNEc2Nk5RQ2RsUDN6TmlFcEFiQVNMVVFx?=
 =?utf-8?B?VDhNcmJHeTJRRUZKNFlHb0g0Z0VvcTUvQjgrTlBDR2M2QXMwdE4wNm41ZTVi?=
 =?utf-8?B?Wmtyb3hiNytKME9XbFJ1Z0c5UXAyN3Vld2Fwc1FDdmxjUUdhQUlGeExwTXBS?=
 =?utf-8?B?elNtM2Y4cnRRWVNDTHhTUU1ENGR3Ty82YjRtbDZjQnJiRW9OakZLazIwVFJK?=
 =?utf-8?B?MlAzOS8rOWxpcXpERlFBcVVtL3pVL3BhQ1lHZzBSSFg1Q1g4R2RacXA3U0xj?=
 =?utf-8?B?SjkzNnArVkRYcDFCMjZhbHdjQWFXOUFWMHRkSk9CZnFHL29lVkFkM296elBs?=
 =?utf-8?B?Wit5UU56dXY1NTJoRE5WYVVyNURuTW5BRkc1VkpHbFNzWlkzd0hjQVRKREJr?=
 =?utf-8?B?ZCt3R2RlZDdPNG1JeU5Od0xwTzA3OVJYempQK3YrNUxYOWg4M21DdENTdk16?=
 =?utf-8?B?WEwzN3A4SXdjbnZ5TWdYSytlS0VGQ0JacUZGMXpEaWE0VDVtYnphNkphckU2?=
 =?utf-8?B?MS9XUWxpTzdoZ0RHYktNc3MvMGFxbUN4ZGpWNFpqVjVJMUxhcmNTVUVBN0kw?=
 =?utf-8?B?N3ErTml4Q1A2amQ5OHNmWVNmYXpReVY0YlhsYWVpY0xnOHpwME9nR0t6a292?=
 =?utf-8?B?ai9reGJMbGtxTEhPdFQrU2tvMHhGMzJYVUhTdCtBazhELzVKdXVCekw0aWFz?=
 =?utf-8?B?Q3pXL3dldFAwcDYraTBDV01FZGFCemgwRGxJVGx4U2tHODlCS0tVb2FaZmpi?=
 =?utf-8?B?eWxXeWNKb3lkOWFsd1hlK1ZnNUxGdjNKSUswZVNueDV0NUs2R0FrdWxJcmhQ?=
 =?utf-8?B?OUF3OEU0YkFERXJGU0p5ajRaSXh4eEgrekd3d0hwa3hFUlZjdTdxSjdHeWNZ?=
 =?utf-8?Q?pcobWhqlxwDv1OlmiFmXg2yRd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9807d2cc-3dbc-4250-75d8-08dd8970e7e7
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 12:00:17.7975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gfPaG2pMqjRPV1Q3tLdMh9OCfdeS6ApBFVZUR6vfJSAJs1DmpXKksYgorOzo6kxr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9673

On 2 May 2025, at 1:48, Yafang Shao wrote:

> On Fri, May 2, 2025 at 3:36=E2=80=AFAM Gutierrez Asier
> <gutierrez.asier@huawei-partners.com> wrote:
>>
>>
>> On 4/30/2025 8:53 PM, Zi Yan wrote:
>>> On 30 Apr 2025, at 13:45, Johannes Weiner wrote:
>>>
>>>> On Thu, May 01, 2025 at 12:06:31AM +0800, Yafang Shao wrote:
>>>>>>>> If it isn't, can you state why?
>>>>>>>>
>>>>>>>> The main difference is that you are saying it's in a container tha=
t you
>>>>>>>> don't control.  Your plan is to violate the control the internal
>>>>>>>> applications have over THP because you know better.  I'm not sure =
how
>>>>>>>> people might feel about you messing with workloads,
>>>>>>>
>>>>>>> It=E2=80=99s not a mess. They have the option to deploy their servi=
ces on
>>>>>>> dedicated servers, but they would need to pay more for that choice.
>>>>>>> This is a two-way decision.
>>>>>>
>>>>>> This implies you want a container-level way of controlling the setti=
ng
>>>>>> and not a system service-level?
>>>>>
>>>>> Right. We want to control the THP per container.
>>>>
>>>> This does strike me as a reasonable usecase.
>>>>
>>>> I think there is consensus that in the long-term we want this stuff to
>>>> just work and truly be transparent to userspace.
>>>>
>>>> In the short-to-medium term, however, there are still quite a few
>>>> caveats. thp=3Dalways can significantly increase the memory footprint =
of
>>>> sparse virtual regions. Huge allocations are not as cheap and reliable
>>>> as we would like them to be, which for real production systems means
>>>> having to make workload-specifcic choices and tradeoffs.
>>>>
>>>> There is ongoing work in these areas, but we do have a bit of a
>>>> chicken-and-egg problem: on the one hand, huge page adoption is slow
>>>> due to limitations in how they can be deployed. For example, we can't
>>>> do thp=3Dalways on a DC node that runs arbitary combinations of jobs
>>>> from a wide array of services. Some might benefit, some might hurt.
>>>>
>>>> Yet, it's much easier to improve the kernel based on exactly such
>>>> production experience and data from real-world usecases. We can't
>>>> improve the THP shrinker if we can't run THP.
>>>>
>>>> So I don't see it as overriding whoever wrote the software running
>>>> inside the container. They don't know, and they shouldn't have to care
>>>> about page sizes. It's about letting admins and kernel teams get
>>>> started on using and experimenting with this stuff, given the very
>>>> real constraints right now, so we can get the feedback necessary to
>>>> improve the situation.
>>>
>>> Since you think it is reasonable to control THP at container-level,
>>> namely per-cgroup. Should we reconsider cgroup-based THP control[1]?
>>> (Asier cc'd)
>>>
>>> In this patchset, Yafang uses BPF to adjust THP global configs based
>>> on VMA, which does not look a good approach to me. WDYT?
>>>
>>>
>>> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierrez.=
asier@huawei-partners.com/
>>>
>>> --
>>> Best Regards,
>>> Yan, Zi
>>
>> Hi,
>>
>> I believe cgroup is a better approach for containers, since this
>> approach can be easily integrated with the user space stack like
>> containerd and kubernets, which use cgroup to control system resources.
>
> The integration of BPF with containerd and Kubernetes is emerging as a
> clear trend.
>
>>
>> However, I pointed out earlier, the approach I suggested has some
>> flaws:
>> 1. Potential polution of cgroup with a big number of knobs
>
> Right, the memcg maintainers once told me that introducing a new
> cgroup file means committing to maintaining it indefinitely, as these
> interface files are treated as part of the ABI.
> In contrast, BPF kfuncs are considered an unstable API, giving you the
> flexibility to modify them later if needed.
>
>> 2. Requires configuration by the admin
>>
>> Ideally, as Matthew W. mentioned, there should be an automatic system.
>
> Take Matthew=E2=80=99s XFS large folio feature as an example=E2=80=94it w=
as enabled
> automatically. A few years ago, when we upgraded to the 6.1.y stable
> kernel, we noticed this new feature. Since it was enabled by default,
> we assumed the author was confident in its stability. Unfortunately,
> it led to severe issues in our production environment: servers crashed
> randomly, and in some cases, we experienced data loss without
> understanding the root cause.
>
> We began disabling various kernel configurations in an attempt to
> isolate the issue, and eventually, the problem disappeared after
> disabling CONFIG_TRANSPARENT_HUGEPAGE. As a result, we released a new
> kernel version with THP disabled and had to restart hundreds of
> thousands of production servers. It was a nightmare for both us and
> our sysadmins.
>
> Last year, we discovered that the initial issue had been resolved by this=
 patch:
> https://lore.kernel.org/stable/20241001210625.95825-1-ryncsn@gmail.com/.
> We backported the fix and re-enabled XFS large folios=E2=80=94only to fac=
e a
> new nightmare. One of our services began crashing sporadically with
> core dumps. It took us several months to trace the issue back to the
> re-enabled XFS large folio feature. Fortunately, we were able to
> disable it using livepatch, avoiding another round of mass server
> restarts. To this day, the root cause remains unknown. The good news
> is that the issue appears to be resolved in the 6.12.y stable kernel.
> We're still trying to bisect which commit fixed it, though progress is
> slow because the issue is not reliably reproducible.

This is a very wrong attitude towards open source projects. You sounded
like, whether intended or not, Linux community should provide issue-free
kernels and is responsible for fixing all issues. But that is wrong.
Since you are using the kernel, you could help improve it like Kairong
is doing instead of waiting for others to fix the issue.

>
> In theory, new features should be enabled automatically. But in
> practice, every new feature should come with a tunable knob. That=E2=80=
=99s a
> lesson we learned the hard way from this experience=E2=80=94and perhaps
> Matthew did too.

That means new features will not get enough testing. People like you
will just simply disable all new features and wait for they are stable.
It would never come without testing and bug fixes.


--
Best Regards,
Yan, Zi


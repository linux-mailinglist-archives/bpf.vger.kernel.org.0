Return-Path: <bpf+bounces-57224-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5723CAA73D5
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 15:36:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED6E03B1949
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 13:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E3D111713;
	Fri,  2 May 2025 13:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I8izPPVo"
X-Original-To: bpf@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2056.outbound.protection.outlook.com [40.107.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883F214286
	for <bpf@vger.kernel.org>; Fri,  2 May 2025 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746192906; cv=fail; b=MvpXkGFGybkp6qhCLoa3IwaYH4OB8CiGAS5BosuD5GV6GBAR9GGJmoDLnpC1X0xI9axNczp5QdrDEiarlAIw62j/B6gqpWD39BWoZjrWHE65rqBZEQ0dZ5FhXiT7gSw98S4S0visjTMtNtofoeuRQsboory8rf4yF4PCwxnB6Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746192906; c=relaxed/simple;
	bh=OX+oiJaja/ETaAAJGxUZlK7loCYHanvLzK1IChODdMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZBa+lapJcECfztmy9RQIflU6EbTrW50eOafmF4ksBfumdoV4fqwMmyCOzv+IOU8NHx6hnO57lCUFQ1pjs2tNw28xIpPCHtck38qLMz/9aFLLMV7gAA86xeu7FkdJKkw43m8YgKbHnXv/TnsrFw0eRp9Uy5aMax/9WNSahrNx2R0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I8izPPVo; arc=fail smtp.client-ip=40.107.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sJA3pxcVfVcRq0FO7tkdHqF3f2BJh7YgxOy9CvzaTSFsbGz11oNSPBUrCzmxhPTDti2Gx3lB0/CAGUoxulyhPCm2brbX4jq+IgFJ1X08LhP0t6gaO+QGNTpz7qrVObbAlRbs3wg6OlJ+PpwhXzd23yq9n2Mk1QEMujus3GSfhj6Kk6ZlssBYIczUS61cbsXx0F52hR8t3CE632aWWwYY/a5sYQNWFMAAlA/jYLVqF5RexB2s/EZwWZe+0u2+4dgQbry7YoFToPI8y1MmNwY3r51n6Xq9HZN6FDTZarMduGemYdOu7jtQzfBNdewt4wn7mTZrfP5D/75icdFJwqS3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KLZrxAWbF0ZwU4P8p1pWRTZWWkbQW4EGeuN7Zs+9DD4=;
 b=AD+tvJQhJls9TGtMPl8w4TiWiI4BBuT7o2ItQAuGpoascMeQ88VABXnAJjZCu26cB7+/p+PyRCpYfLbwLGoaK9s+U8A5tCg/4npywTLhyuU9Hq8MtHbWvn2Hg/+W+4bXbCbjIJydGHOzMbjCQk5uqRaoVjBWE4WJVpEmst8gCEvs4B9BzdN1Cng+A0HHnu0HnIK2dUSnLlgc7YG5A++4R/04rSkOLhQPDYhCl/enHIveSzxwweDBff+as4BDlm4+Hc+RMWp5S8/VGOqepXRdzLPcfxss727MkF/YlEWcKBdVLBAoMTjlWvb8jWBcd/qWPrttECDqinTlX5hpXlEwTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KLZrxAWbF0ZwU4P8p1pWRTZWWkbQW4EGeuN7Zs+9DD4=;
 b=I8izPPVoioM9ZF1QgLBbRyQLGsxG0pbWyK9UK4VXzlR4m3Q4bYAYl1Yo04bnqNdG4w5/6680Zc28HgrNAEztvjWmS+0YNp4SHGctTEGT4wtHv4posp5KuykbPmDUmmyy+WmTkyef5DG88fczs4EH/EX4GAKpEtMw1I0B3LVi8iRaF9+6kuYMOeoxC66adVEXH4TIQm78z97KJMWL7Av4bqUD5dTzWPRtkutNHDExxmb2LhvVJ1VBhYsbjKkAZt4o7Xku6OQiRylSwPmp+C8WhW6HoXN+yqM4R3lL46A1JM52OR/RyTedPFi4W0yUG7waRmZ6hTH8j8xxnixAmTABDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB9473.namprd12.prod.outlook.com (2603:10b6:8:252::5) by
 IA0PPF002462CFE.namprd12.prod.outlook.com (2603:10b6:20f:fc04::bc4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Fri, 2 May
 2025 13:35:01 +0000
Received: from DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a]) by DS7PR12MB9473.namprd12.prod.outlook.com
 ([fe80::5189:ecec:d84a:133a%5]) with mapi id 15.20.8699.022; Fri, 2 May 2025
 13:35:01 +0000
From: Zi Yan <ziy@nvidia.com>
To: Yafang Shao <laoar.shao@gmail.com>, David Hildenbrand <david@redhat.com>
Cc: Gutierrez Asier <gutierrez.asier@huawei-partners.com>,
 Johannes Weiner <hannes@cmpxchg.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Nico Pache <npache@redhat.com>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 bpf@vger.kernel.org, linux-mm@kvack.org, Michal Hocko <mhocko@suse.com>
Subject: Re: [RFC PATCH 0/4] mm, bpf: BPF based THP adjustment
Date: Fri, 02 May 2025 09:34:58 -0400
X-Mailer: MailMate (2.0r6249)
Message-ID: <18FB00F5-3CF0-410B-BB39-71D742B7EEAA@nvidia.com>
In-Reply-To: <4883bdec-f7f2-4350-bf72-f0fa75c9ddd5@redhat.com>
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
 <3006EA5B-3E02-4D82-8626-90735FE8F656@nvidia.com>
 <CALOAHbA6uWTGZ10n3Lk2Jm5xBPC5ob9aw87EHmkvm6__PYJ_5g@mail.gmail.com>
 <4883bdec-f7f2-4350-bf72-f0fa75c9ddd5@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: BN0PR03CA0052.namprd03.prod.outlook.com
 (2603:10b6:408:e7::27) To DS7PR12MB9473.namprd12.prod.outlook.com
 (2603:10b6:8:252::5)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR12MB9473:EE_|IA0PPF002462CFE:EE_
X-MS-Office365-Filtering-Correlation-Id: ade83204-df0a-4ffb-7189-08dd897e2367
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?V0I4RXF4KzN1Y3FSaVJ5MStDOHZjZnBOUVlQTVlaTndYaUJXZ1hKQXZ6NUdy?=
 =?utf-8?B?NW1qU0o4MGZXbktTN3VYZm5iQTExckx4QVhMUzh2TW5aRVkzcUxYV0hGbitF?=
 =?utf-8?B?SnpSTTh0TS9hb1FoQVk2ZlQwWTJYdk91MU9FRElsT3JUWUFMcVd1bEkyRE1Q?=
 =?utf-8?B?ODVCanVEQzRoSzhHM010OXc2WG1Qa2VZK0pMazFhMU9mU0lxc3VkNWlZTE5L?=
 =?utf-8?B?cnZOM2o3cTB3bFZIRnF3aDlONmNxK04wc3N6Zm1xNkZjWno4ZmZPNWxyUHVZ?=
 =?utf-8?B?VFNNY2pDU3E0YmZQcStWVHZhM2JZUVE4ZnpKeXF3WmY0Qjh3NE13YWxQUzlI?=
 =?utf-8?B?Z3V5NSt3SHBrZ1Azc0VIa0tTTjBhb0l0RzMweFZKb2Rra3Z5K0tPZ0IwaXFG?=
 =?utf-8?B?NWNzdk9wVEtPRDNrVGxpbUk0dEYzbnlqK2V0eG55SENaWDBjd0xhb05oN1h3?=
 =?utf-8?B?YUZhVFdLdGxINzE0RElQMnFtMUlOc2d6c1V5OEJnNnRoNEFzeUNveFliaTJn?=
 =?utf-8?B?cDBYNFNmYm1TZ1ltdkFjeDFDUTdzMktJRUI0cE5vZU1DTGtyZ0xDOUZOeHpB?=
 =?utf-8?B?d1dwUUZ6d3c3YWJkM2dub2Y1aDJ0RFdBMnJWUEdlaVVjMGFvTDUxdFNqTEM1?=
 =?utf-8?B?M1FWVktDSlVTSFhFbGc2SUhXQ1o5UXpxcm1pYm5CZzJIRmVkNFRUemlTZ0hl?=
 =?utf-8?B?OXlxbFppVHQ4MDVha3BURUVPcnRXQUNxZ0p2WGd3NHpvWXZEeWdCOG9JNUVx?=
 =?utf-8?B?dEcxanJBVjF6ekJZWG1lMzJ5QXJBaGZESkM0eEZsNzEzWnBZSnVNQW1YaEh5?=
 =?utf-8?B?NGFYTnM1VTBGdjFOSlRwSm5mOUMrb1FYczFmU1FIQ1BtZzJvVzc0cHVaZUU0?=
 =?utf-8?B?L0phYjU0OWJJUkJ5V1BWWCt5SVQzbGNrbmtOVTVsVTNkSDBiNnVCejRxS0pZ?=
 =?utf-8?B?OEl5L0ZwLzVGVDhYeFY4OHNzQ3pINnlzMjA0K2xaVjZYd0xESG5obkxpNkZ5?=
 =?utf-8?B?WGg3V0JiNDJlN3dDNCtiOVJadm1YdGFtdDBwSGNlYkMwMWV0MmtyUk9rdEhx?=
 =?utf-8?B?R2ptYzlIL3ZoWi8rV3V4bVVRZTVLbEdDRjFXUU5OMkZVeVNDdmV4dzRvWE9i?=
 =?utf-8?B?OUlxc25WdjhoZ3RkM3dsQ0hKNXAxMko5QUJXUGM4d21saW9rY05zTGVpSTVG?=
 =?utf-8?B?TTFRNUNBZGdMUUcwNkJpSi8veVFCY1dvNzFuSmw3K2QrZ2lDVld6L1QzVEdC?=
 =?utf-8?B?aDkvVnM3WFF0NDJrRnVabFptejVVWkkydjB6L2EyMXNmdVBITjN6bElkMStV?=
 =?utf-8?B?QjFUL1VNOUo5dEc1Mk50NzZLc1oya0xCZGk1VWY4Vm1ZN2M4enptaHp3OTBN?=
 =?utf-8?B?NnZDMXJENVI1cXVBb1JZN0ZYZ25pSWErYmllMFhZU0NIeGZwZFlvRW9kYU51?=
 =?utf-8?B?bE9pbkdpcFdhaTFua1VZOWRuMmt6QXlGSmJNMmhkczNzb05FWnNrc2h5L0VC?=
 =?utf-8?B?bk5LTXdRbGVWSXJlaGRJN1p3NUNQQTFpMklJYVhYRlpjZkxMMWZnSXVTNUdQ?=
 =?utf-8?B?VmZ6c3phcS9qSWNXaHlVakJSSEd4M2pQY3Q2ZkY0YVoyMTlrb2RDMW9aWko5?=
 =?utf-8?B?cXp4S1RIOXFpRmRxUUxkd1JZS2g2R2R6TkI2WUhGeE9JUjM0dldVZkVzaHph?=
 =?utf-8?B?UFpRazVoZ05qV05EYi8rM3hBR25EeCsveHFZYVoxUjMvRHRFaXhxaDRMaEtY?=
 =?utf-8?B?UlppUDdGV21HaFN4ZlNrYzJPZHYvVkJXaEQ5NnBqV01XK3VPWjNCTVRnbldy?=
 =?utf-8?B?NkgxdXA3TlllbDFHSzZqeVVwelU5WFRIZmZpemNubUR0SlZBdGNGdXYrSGdE?=
 =?utf-8?B?K0NMVCthaDBXV1hOdm9Hc0ZlSkYwcmJWME9NcS9NVWlkRmxWUnpYd01OZFNF?=
 =?utf-8?Q?NUFZ+aEplr4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB9473.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?clNjS2NiVEtiQkxlbm05bzBpc2Q5WTRUOVJEZGpUeHRGeDlGZjgxa1FTaGtw?=
 =?utf-8?B?dmt1WHNGU3RiZ2pmV0p0Y2x4dkZJR2Y3MlFXNzB5UklkT09OdWgxZ2xGcXVk?=
 =?utf-8?B?WWJSSVNZcTVybjRBQVJ3Z0RFbVpsWnhCZTN4Q2VlQ2JzQkgraElDdlJnWUJE?=
 =?utf-8?B?ZHhjVmJzTUYyUGhGKzJLMnh5OHZMNmlOL0ZrTHpyYi8vN1lRVjhZU1lIbWpn?=
 =?utf-8?B?Y21tSWdqaU95VndFU1d2cWxlYjZZeUVMa3krSzNVQUxKeUJDZEMzZTV1bFNt?=
 =?utf-8?B?TlFpRlRpV0Y1aVdlSEh0YVVyTHgxcy82WldlVUVKSTlQVnVwZHZqOXJhTU5w?=
 =?utf-8?B?cXlaNkpocGNHT0E2V0MyVGRQdlMxNWkxTE9nWkZYMUI5WVRnZFNMdDEvZEtx?=
 =?utf-8?B?ZzRTTEtCS1FYWG1XZ1M5eXEvYmV5ODRHMG9NSG5LWVRsL1J5NjBmSVFZb0U3?=
 =?utf-8?B?ZFhKQ2QyZVl6TzlKWFNpazBVQ3BHY3VEN0ZWMkh2UWp1RWxOUUVnd09zVTdU?=
 =?utf-8?B?Q1JrYXl3VFJIbHZPNDd5REg0bGZDK3FEZnhBdU9tczF2UXNXczdoL1B2eTJP?=
 =?utf-8?B?NTZqTG5qL1RMbTBmdHZYU2lyUE5ncHR2d290UXZ3REVJTlpNUDIrMjF6dXp1?=
 =?utf-8?B?K0MrV0Joak4xT0Fvdk5GSHVGMWVyNlJqZERZMDBWV0tKUEQyVWoreUV2YjVL?=
 =?utf-8?B?UEhsY0VQMGRkRGk0c21vMkdyRHJ5SStTQlByajFNWFEwZEtEWTAzSUE4NG1u?=
 =?utf-8?B?MGRiTTJCVUNVOGxGQ1k4cDR2UlMxdkZhcVVhOXo4dEpBbkJ2bEt5ZitVa0NK?=
 =?utf-8?B?M0pNODlSUTdGUjhpTTlpZWVlMXRCd3VFYkpxb0l6ekxzSUo5M1pIRmxMV1U5?=
 =?utf-8?B?WlZIVnZUeGwxenNUM0pUdEN2UC9adWxYQm4xM0RFdlU0c3ZjbnRjUmdZVXhC?=
 =?utf-8?B?ekRJMlZlVCtra3dETUZaTysxam1wUTB5a240RnVtbVBYdEIvRElJczlmcGd1?=
 =?utf-8?B?VEtheGE5U1F3ak94d0pqT0xuRnAwdjJWVDZJVUUzYVBDRkh4d1RFU2VyRDdW?=
 =?utf-8?B?SnBIVUdOSGk0WkdRT1dqaHArbWlFSHRRR0ZZLzlNWW9uQ3MxVVdyV2ZiL2Z5?=
 =?utf-8?B?UFNFUWUxRElXWmJ2dVNGTEJFWUxyaGRmRTJhUk0ra0FvbzFBQWY1RkNIZmdm?=
 =?utf-8?B?cnd3MlFFOXFBa2JpWkpNUHRvc0R2cUVzR2s5YTVYWkxKNUc5VGZ4SkZlVXdx?=
 =?utf-8?B?L1owM2dzZk9PbnA3c0ZrRGcwTUQremdvR2xkWU1WOW55YzQ5Q0JnSFJmT1E3?=
 =?utf-8?B?a3FNU2FJRFdpRFhnWHRSK3ZQU1FINW5qcG9COVYwdVZIZC9rcW03dXNoNWZF?=
 =?utf-8?B?WTBpRDJYazhUUjFRMEludGIzalpyY0lyOGRYZXRCeDRDYTUvNVBGbzRCSGVR?=
 =?utf-8?B?eDBmY0FuZHZlaEhHRi8yQlFKSTIrTkpkUXJqaFllc2w3ejd1RmNySU8ya0Fs?=
 =?utf-8?B?c3Nsd2c4a0ZOVmVMMWFmcU45MDJHemRnSC9panB2aGwvNU5YeEl5NGRma2NY?=
 =?utf-8?B?MjIwc0VPRU04R0xBOGdycG1kYzhKUTJodm53ekRSdHF4UVJlbThVN2dQQndy?=
 =?utf-8?B?RDFTK1oyUCtsbnQ3MkI5SkxaT2gvdHJxN05UNmtZcTRPSk52UGd3WlNzcm1a?=
 =?utf-8?B?eDNRVXJtS1FiL3puNC9FZGVyUXl1ZE1WYmpKK1JLYkswZllVNkQvenlmQWtT?=
 =?utf-8?B?UHhXaGlVdlA1YzRkS1NuN0NMbGlVN2ZaQlF1dC9oRndzaHp0cktYbUFPbG00?=
 =?utf-8?B?RDhJT0oyQUN0QUVBb0hIcGxEcXRtd0FzUnNtQUozSTZFcnJFYWZqdmFYRzNE?=
 =?utf-8?B?S0pVQjRsbks4Tjh2U1dZRlQxakkzRGxRakIwYW4rcmh3Q0RVWWZHRnVIUWVF?=
 =?utf-8?B?NFhWZVFtcDhNbW1VRmtDSFE2b2tvNzZvYUpCaUpLSlJPc1VCN0VrRmpLNC82?=
 =?utf-8?B?UDVQd2JoK1Ixbjk1N2FUdXVNcWxMVnBldjFmTU1wWDU5SnhMa2luN3ZsSEhz?=
 =?utf-8?B?U0tMUGVXNVNiT0s0RFRsd0NSM1RzQm9VeXA4ZFZGdmJIbFUzTThQcWxVUE5G?=
 =?utf-8?Q?7TOpJy42w5j1W49taj+8YCF3U?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ade83204-df0a-4ffb-7189-08dd897e2367
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB9473.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2025 13:35:01.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pfYWeVcMh1g4meMLpzk4WN4Dz2XjgseHDpAQK5hIUnRnnKnhp2tzMTh+1qbRKUvN
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPF002462CFE

On 2 May 2025, at 9:04, David Hildenbrand wrote:

> On 02.05.25 14:18, Yafang Shao wrote:
>> On Fri, May 2, 2025 at 8:00=E2=80=AFPM Zi Yan <ziy@nvidia.com> wrote:
>>>
>>> On 2 May 2025, at 1:48, Yafang Shao wrote:
>>>
>>>> On Fri, May 2, 2025 at 3:36=E2=80=AFAM Gutierrez Asier
>>>> <gutierrez.asier@huawei-partners.com> wrote:
>>>>>
>>>>>
>>>>> On 4/30/2025 8:53 PM, Zi Yan wrote:
>>>>>> On 30 Apr 2025, at 13:45, Johannes Weiner wrote:
>>>>>>
>>>>>>> On Thu, May 01, 2025 at 12:06:31AM +0800, Yafang Shao wrote:
>>>>>>>>>>> If it isn't, can you state why?
>>>>>>>>>>>
>>>>>>>>>>> The main difference is that you are saying it's in a container =
that you
>>>>>>>>>>> don't control.  Your plan is to violate the control the interna=
l
>>>>>>>>>>> applications have over THP because you know better.  I'm not su=
re how
>>>>>>>>>>> people might feel about you messing with workloads,
>>>>>>>>>>
>>>>>>>>>> It=E2=80=99s not a mess. They have the option to deploy their se=
rvices on
>>>>>>>>>> dedicated servers, but they would need to pay more for that choi=
ce.
>>>>>>>>>> This is a two-way decision.
>>>>>>>>>
>>>>>>>>> This implies you want a container-level way of controlling the se=
tting
>>>>>>>>> and not a system service-level?
>>>>>>>>
>>>>>>>> Right. We want to control the THP per container.
>>>>>>>
>>>>>>> This does strike me as a reasonable usecase.
>>>>>>>
>>>>>>> I think there is consensus that in the long-term we want this stuff=
 to
>>>>>>> just work and truly be transparent to userspace.
>>>>>>>
>>>>>>> In the short-to-medium term, however, there are still quite a few
>>>>>>> caveats. thp=3Dalways can significantly increase the memory footpri=
nt of
>>>>>>> sparse virtual regions. Huge allocations are not as cheap and relia=
ble
>>>>>>> as we would like them to be, which for real production systems mean=
s
>>>>>>> having to make workload-specifcic choices and tradeoffs.
>>>>>>>
>>>>>>> There is ongoing work in these areas, but we do have a bit of a
>>>>>>> chicken-and-egg problem: on the one hand, huge page adoption is slo=
w
>>>>>>> due to limitations in how they can be deployed. For example, we can=
't
>>>>>>> do thp=3Dalways on a DC node that runs arbitary combinations of job=
s
>>>>>>> from a wide array of services. Some might benefit, some might hurt.
>>>>>>>
>>>>>>> Yet, it's much easier to improve the kernel based on exactly such
>>>>>>> production experience and data from real-world usecases. We can't
>>>>>>> improve the THP shrinker if we can't run THP.
>>>>>>>
>>>>>>> So I don't see it as overriding whoever wrote the software running
>>>>>>> inside the container. They don't know, and they shouldn't have to c=
are
>>>>>>> about page sizes. It's about letting admins and kernel teams get
>>>>>>> started on using and experimenting with this stuff, given the very
>>>>>>> real constraints right now, so we can get the feedback necessary to
>>>>>>> improve the situation.
>>>>>>
>>>>>> Since you think it is reasonable to control THP at container-level,
>>>>>> namely per-cgroup. Should we reconsider cgroup-based THP control[1]?
>>>>>> (Asier cc'd)
>>>>>>
>>>>>> In this patchset, Yafang uses BPF to adjust THP global configs based
>>>>>> on VMA, which does not look a good approach to me. WDYT?
>>>>>>
>>>>>>
>>>>>> [1] https://lore.kernel.org/linux-mm/20241030083311.965933-1-gutierr=
ez.asier@huawei-partners.com/
>>>>>>
>>>>>> --
>>>>>> Best Regards,
>>>>>> Yan, Zi
>>>>>
>>>>> Hi,
>>>>>
>>>>> I believe cgroup is a better approach for containers, since this
>>>>> approach can be easily integrated with the user space stack like
>>>>> containerd and kubernets, which use cgroup to control system resource=
s.
>>>>
>>>> The integration of BPF with containerd and Kubernetes is emerging as a
>>>> clear trend.
>>>>
>>>>>
>>>>> However, I pointed out earlier, the approach I suggested has some
>>>>> flaws:
>>>>> 1. Potential polution of cgroup with a big number of knobs
>>>>
>>>> Right, the memcg maintainers once told me that introducing a new
>>>> cgroup file means committing to maintaining it indefinitely, as these
>>>> interface files are treated as part of the ABI.
>>>> In contrast, BPF kfuncs are considered an unstable API, giving you the
>>>> flexibility to modify them later if needed.
>>>>
>>>>> 2. Requires configuration by the admin
>>>>>
>>>>> Ideally, as Matthew W. mentioned, there should be an automatic system=
.
>>>>
>>>> Take Matthew=E2=80=99s XFS large folio feature as an example=E2=80=94i=
t was enabled
>>>> automatically. A few years ago, when we upgraded to the 6.1.y stable
>>>> kernel, we noticed this new feature. Since it was enabled by default,
>>>> we assumed the author was confident in its stability. Unfortunately,
>>>> it led to severe issues in our production environment: servers crashed
>>>> randomly, and in some cases, we experienced data loss without
>>>> understanding the root cause.
>>>>
>>>> We began disabling various kernel configurations in an attempt to
>>>> isolate the issue, and eventually, the problem disappeared after
>>>> disabling CONFIG_TRANSPARENT_HUGEPAGE. As a result, we released a new
>>>> kernel version with THP disabled and had to restart hundreds of
>>>> thousands of production servers. It was a nightmare for both us and
>>>> our sysadmins.
>>>>
>>>> Last year, we discovered that the initial issue had been resolved by t=
his patch:
>>>> https://lore.kernel.org/stable/20241001210625.95825-1-ryncsn@gmail.com=
/.
>>>> We backported the fix and re-enabled XFS large folios=E2=80=94only to =
face a
>>>> new nightmare. One of our services began crashing sporadically with
>>>> core dumps. It took us several months to trace the issue back to the
>>>> re-enabled XFS large folio feature. Fortunately, we were able to
>>>> disable it using livepatch, avoiding another round of mass server
>>>> restarts. To this day, the root cause remains unknown. The good news
>>>> is that the issue appears to be resolved in the 6.12.y stable kernel.
>>>> We're still trying to bisect which commit fixed it, though progress is
>>>> slow because the issue is not reliably reproducible.
>>>
>>> This is a very wrong attitude towards open source projects. You sounded
>>> like, whether intended or not, Linux community should provide issue-fre=
e
>>> kernels and is responsible for fixing all issues. But that is wrong.
>>> Since you are using the kernel, you could help improve it like Kairong
>>> is doing instead of waiting for others to fix the issue.
>>>
>>>>
>>>> In theory, new features should be enabled automatically. But in
>>>> practice, every new feature should come with a tunable knob. That=E2=
=80=99s a
>>>> lesson we learned the hard way from this experience=E2=80=94and perhap=
s
>>>> Matthew did too.
>>>
>>> That means new features will not get enough testing. People like you
>>> will just simply disable all new features and wait for they are stable.
>>> It would never come without testing and bug fixes.
>
> We do have the concept of EXPERIMENTAL kernel configs, that are either ex=
pected get removed completely ("always enabled") or get turned into actual =
long-term kernel options. But yeah, it's always tricky what we actually wan=
t to put behind such options.
>
> I mean, READ_ONLY_THP_FOR_FS is still around and still EXPERIMENTAL ...
>
> Distro kernels are usually very careful about what to backport and what t=
o support. Once we (working for a distro) do backport + test, we usually fi=
nd some additional things that upstream hasn't spotted yet: in particular, =
because some workloads are only run in that form on distro kernels. We also=
 ran into some issues with large folios (e.g., me personally with s390x KVM=
 guests) and trying our best to fix them.
>
> It can be quite time consuming, so I can understand that not everybody ha=
s the time to invest into heavy debugging, especially if it's extremely har=
d to reproduce (or even corrupts data :( ).
>
> I agree that adding a toggle after the effects to work around issues is n=
ot the right approach. Introducing a EXPERIMENTAL toggle early because one =
suspects complicated interactions in a different story. It's absolutely not=
 trivial to make that decision.
>
>>
>> Pardon me?
>> This discussion has taken such an unexpected turn that I don=E2=80=99t f=
eel
>> the need to explain what I=E2=80=99ve contributed to the Linux community=
 over
>> the past few years.
>
> I'm sure Zi Yan didn't mean to insult you. I would have phrased it as:

Hi Yafang,

I do apologize if you feel insulted. I am aware of that you have contribute=
d
a lot to the community. My point is that disabling features and waiting for
they become stable might not work.

>
> "It's difficult to decide which toggles make sense. There is a fine line =
between adding a toggle and not getting people actually testing it to stabi=
lize it vs. not adding a toggle and forcing people to test it and fix it/re=
port issues."
>
> Ideally, we'd find most issue in the RC phase or at least shortly after.
>
> You've been active in the kernel for a long time, please don't feel like =
the community is not appreciating that.

David, thank you for the clarification.

--
Best Regards,
Yan, Zi


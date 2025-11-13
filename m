Return-Path: <bpf+bounces-74350-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F34BEC55B8A
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 05:58:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A4A79343F5B
	for <lists+bpf@lfdr.de>; Thu, 13 Nov 2025 04:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80545304BDF;
	Thu, 13 Nov 2025 04:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="r1kBEuk5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uo7CKJKn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38B30215A;
	Thu, 13 Nov 2025 04:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763009783; cv=fail; b=tUW027hCQ1BiJ6Vl4Tv42BDagIJldbkiRh0nwP81Uw9/sohNGhAeAoVfOlesFV/JjRmNQ+nMy8kheiMa5Qoj9c26iTLx3w34YsQuorAKq7x7eNqxJHbqYuCsUkjHsSQJ749GyUPiEJ0DmjF2ZwxcjlLp0clAXjyM6ojDsTStElw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763009783; c=relaxed/simple;
	bh=B+P4McsFJ0ushmR/Yc6g8x/8FIN1psnwKjuswq8EfG0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=fg1yvkmpkYfIGVmSS91cqbPsGZAoTnViO4mIIG/KwaykStE546zQclfM5fw143xBXBkP5/rQbc3ySh9Q7wtSej8n/ZVv2dOosXiBmbfN9D5qcMZBqrTIRU6WWPARaicb6lqCITXDXRlsCsgdyZTLkLuZ+pb8JaFW7yGcqv1gTmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=r1kBEuk5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uo7CKJKn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD1gNOF030753;
	Thu, 13 Nov 2025 04:56:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Q8K8yLEPxSsj7AeSHw
	FXOk9kqw/oWb/MgymSw2LO9mc=; b=r1kBEuk5mjv6fJQsomUDbuP1MbjT/LAZ4t
	Fdm30Go7HPpeUzEGTb9Xn5Ga30djpKs4zXO/73vcfk9EhBHymq0HVfXbwKh+bbUM
	MY+DV4K+KoWMUhWFrm8a6P2fJ7Pm4QEQnaUYJJqufVs/G/3otd9hhscBlx2ZyBmQ
	Mf/HXoWVoLBDz+pMYogpHDiCDMvwX7m9IQL75IgB6kL3gin5HZqDoMzpZoo6bPEa
	0vd/4JLDUSSFsCeHZuYYvlKdWCBOt8VOZRZxNBM+2BNVZ0ZmxrmHL9Y1iQOIx08H
	sVwwUmu8F3kvqWV0Um5nRhoyXgybVuh2l1jDfknGvZwG3NaCjKNQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyra8utc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 04:56:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AD3wn4v029113;
	Thu, 13 Nov 2025 04:56:06 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011058.outbound.protection.outlook.com [40.107.208.58])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vafnuw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 04:56:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BKE5hPFTiqU8FVVDt+X9QBBpeZadaQFQUhbHudsueeHjXGagjsOwMGJDNaqSsrRggYBF4KPffYpnAI34vxPxt2BzMBBhYHHbABBpIqWCMwcCXoaThG3Nnp62Xwo0P1gq4jNdvIW5bWYHcpRXRcuq4wV4UPwMXC/VhAsJxqhMwEHFkDBorMf+3rio8hqcg5Mi6Frf9WdjO5eoZn1rLlUoabKRdHsF7xJX+ZbAKbOsDlO3r4H95CdiHbQDJeRY0JKRq5dBO8GDDtxKXmju+mrPOzSO+e/n8hnFjw22Scwn5D33Q3TIunu4wMeGC90l76CsTpMDfHAesDQlcGudTnhQPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q8K8yLEPxSsj7AeSHwFXOk9kqw/oWb/MgymSw2LO9mc=;
 b=Rrx+YDsy20A+ug2pCwL72hSxvUEONmvjmJneBQYgeAKEJko1tlP8GA6a1oRTMD3v1hjPrCZienYl8uLNZHHopb4sOK5jeYzbN/Vgpo0VzuegetmrYXiRN2WlcB3GyzQ9itXVfWlAZd3ZN/N7eOOosdKX8Lz4YDpAqwCJcNVUUcEc7cMna1dAiQq7Iztfwmn/5R1ypdkxsyQWLrscu7Fbz772CNRIe2v6u8iwu2bxbQPzNxqHfVvqzKpeyaqVHQ7who8Akxia927HIZabLi/fTcIsXLKvmguX62wgzzVTF2ohS9zNbxlT/JXIEtYRlzZBiWBc+J+YUYXlqXKJ/khCeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q8K8yLEPxSsj7AeSHwFXOk9kqw/oWb/MgymSw2LO9mc=;
 b=uo7CKJKnh6fdVuz4H48dh9KlzzTx91xbm6oGnDUeSstlzKo6oTEO/H6ep/5+DJr5dzckArNxx5VnkxlpUYfxe8T3mDnrgtZ8GOKxT9Kiwzax7UqBT5gLWwCWRW0aZEmIWneFo+PPYsg2sSAz8KdasZgSc7WLxKwuFTYOGndA+QI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by CH3PR10MB7808.namprd10.prod.outlook.com (2603:10b6:610:1ba::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 04:56:01 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 04:56:01 +0000
Date: Thu, 13 Nov 2025 13:55:52 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 5/5] slab: prevent recursive kmalloc() in
 alloc_empty_sheaf()
Message-ID: <aRVk2BXrC2b7RJ-V@hyeyoo>
References: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz>
 <20251105-sheaves-cleanups-v1-5-b8218e1ac7ef@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-sheaves-cleanups-v1-5-b8218e1ac7ef@suse.cz>
X-ClientProxiedBy: SEWP216CA0149.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2be::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|CH3PR10MB7808:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bb5e3ed-02b1-4b3d-b4d0-08de2270f107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qQAEPUh43Y+6HE1OnMguCmVE2GH7N6OWN4pMoHEbTMHA5bPikiBVn3O5+93I?=
 =?us-ascii?Q?OLDwVYhu4VuJvD5t7xwYXwNlBx3BERgWiGjZSrrKg6sz5zuF7cCT1g/0J6/7?=
 =?us-ascii?Q?l7362vpfXyWsDk7ckZXGlwQ+6fdpCVURnLvU19nb304zTXYEoHMQtCoXTPkO?=
 =?us-ascii?Q?CiCbylbGsYxtUv8hpzfs2qzw0+OZK0NZH57MOMfY6gz0dVkWE/7qDP7pm1bz?=
 =?us-ascii?Q?vjGJPAp3SUEuO4kr3XoKp0iZk90tIMZ/7AMQEDx3EImPyzr7RRhjZCMlZwoY?=
 =?us-ascii?Q?ekGVCnhv2+KjUReT5fmxtP+KLd93TZp2UZdvMSuUUYsZGm9+o40DbG70/GCl?=
 =?us-ascii?Q?8tNQRkTkIYvSSKbjV4W6FryhGCV8dXwyF7KkT+2PpGKFIeP943NTHBKQKzOR?=
 =?us-ascii?Q?30mIEb1Sqss8uk3qojSPXX/pir/zD+vxpFkBFFOjW/EN3GVkz71LobAMFjHk?=
 =?us-ascii?Q?kNVVnqpjuez0ACvBbmuZVKBpvx1PrpP1hlC+qGh8c7mGTdqX6I2Itrwk3+rz?=
 =?us-ascii?Q?G7ANBipmM4gD2Mar5qyLmDfWsBSFr+HqRD/K1jsBOx3wEisp5z/b2MTa3sVK?=
 =?us-ascii?Q?mzhwuQmXoYvgH5rN3Xhhpd03joQ3mOdVRskBSnjCkXrtxk9o3rIiBNEzaSBb?=
 =?us-ascii?Q?vQGyuYxlMPphuMlgpZTQFmDpjHdOsSEZc4tZYojhBaoncpaVAkvjgNBvGrPD?=
 =?us-ascii?Q?KqHopaOHzWgK0W8hX+acmuBBopV1RmShQgBUvNB4t6KXkjDqVoj+0I4QYaId?=
 =?us-ascii?Q?Hx5XRxO6pIaIUifToO3JXEVXLbsiMejNRkA2tn5ZUDG5BlNFY5moTFbriLA5?=
 =?us-ascii?Q?w90JKcnMaxTfnq1cQY9+FQHF6B6YeleBu0e9SNIF9EhEIUWESzShU+7+IhdA?=
 =?us-ascii?Q?pGVo/PwcBIvoQdbg+0ZRX0pwOzvXPmK58IdD3BARPExg9Ec/oU66yZ0/gcui?=
 =?us-ascii?Q?Pb8dKcw1KRZ3G+iTCvZXbSqxyG9J4u3pIh7IjCQh70rlcXgp07uWz8akErWk?=
 =?us-ascii?Q?m/VkGqOoh3ESUyuhJs0Be+pmSuX1lfUO10bVBI/1ZqEqPx/C54uicIJyQ4l1?=
 =?us-ascii?Q?NoThSWe7SX0d+uas+aTf53T4P6kQXdmQasAVXo2zhBhgR7TQVhCkq12GGOWI?=
 =?us-ascii?Q?SFbR8v5k8aUQfqhP/qXrlJgEIBSfhYS+c7rUVMkYUOmK6VNK1bxdiP+h6hD7?=
 =?us-ascii?Q?tINtiq80hix0+2ekuo8cpoQOsDMztiJkgZdtGd5NMqS6Ynxvo4NxPIUVEtlp?=
 =?us-ascii?Q?uLCWs5tANQ2Zezx86zEoH4YX1b2vvpeaREMPFCflax/xg0Cxwed8Koa5sd6a?=
 =?us-ascii?Q?9V7zEFNiP4RdSekxFMQ0G/6NbbuIVe5z7EAqOcjbFTZNqXufPlrJQxpX2ecC?=
 =?us-ascii?Q?KXE9Oy9OZ784VemS9CBpeGqb8B+IYh/YLlSah3KXlxLssLmFZzwFlF/SRQ5m?=
 =?us-ascii?Q?lhiW+98gpXSYXgR4eJjgB3ckUoi/76yu?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UkVD3wVnDeAUb61NLaNmW7vELTRlIWB+NrA2/NPO+hQYkOk9ugqw2KSYXo32?=
 =?us-ascii?Q?jtnP2Q1ckZ5CkP5uniocGtl4ILYM7yBAW0k8M/aF9oIMI84HVI+KyaAadPz9?=
 =?us-ascii?Q?iLG95Z4ZwLd21OHIZygOAAbVQ8LgFcs0quRpMEvV+t5ITzAxBz18XcuxUU7P?=
 =?us-ascii?Q?aG+WefBqpSCmlLuu6oD0NNdpLHgR50gL9rUy9itanUgSIhSk86Qt2czNRPY5?=
 =?us-ascii?Q?MBlbExrI4Qrp8wn45XwHA8ccFYhtDZY9P+95Z3MLyt3mePGA1Iduq2EPX4KE?=
 =?us-ascii?Q?OLc3y+4PpY4wsb/WBSX/MC1BI/oWPgD8XFPhkvPTOi2vOb00BLU4xDrhtc6v?=
 =?us-ascii?Q?QKWP9PG2ync7Y9nAeaCyJmvzo1GZkn8m7HV92UJNTvBG/x8hYa1JV1a//K7H?=
 =?us-ascii?Q?iRYlaScDcCdykiUCKPy67gdj7v26uWCKk5nqIGq2mox48LgOVpZDUXqz2vS/?=
 =?us-ascii?Q?zLK/mU2DO2iFPITgDtsKq+0EmuYAYav73vIUFw2ON17xzCPDE1fCZ/6Syiyu?=
 =?us-ascii?Q?sMq0rhsuraKKQU7+NGxmj7ZtXBLw6VgLV2qkI3p3+GjAKUBj7CPqgNtzoIWw?=
 =?us-ascii?Q?FzLA8lGNasGoWJiaHAnUkkNzR8gWKwDQadeetCzdhMYEsMcONU1tO+L80een?=
 =?us-ascii?Q?cDJjbP4dq00SWY3nh+sDfx/n90ucCB69hHk3XSLfTAnpKs4S+KEZs1l84f1m?=
 =?us-ascii?Q?FV5NAJgzuNG6laXi1nO3g5wB1zhrAT2ay478BxAqk2kqvwbHNgHDpf6hXxBO?=
 =?us-ascii?Q?uCn6iGrtl7/0nK4OyqeC1KCyN6GR6UMba8Rc9yYVtt6ui3Sy5LuJHFOsLiLz?=
 =?us-ascii?Q?VHvfx+Spibu369f0cvn2YCtEHwH+NU9YBfS8p7Du/0y/XhGS8iKlh1sEC8Cs?=
 =?us-ascii?Q?XfArawPuWJjB9+VO3XGJklnQuajdtFsvi8OFRBjCgXytAHbYoHm0dhgl742A?=
 =?us-ascii?Q?MMvN8yJf4Ro8LzEtmmh6mUb91shQMcKbadntsMvCtbtk6+HtVm81yRerWou0?=
 =?us-ascii?Q?VudNOClRQZattaqIKUujQHuQuvHDDeUuD1b8JPw234xMHtaH6hnEcbY8FH44?=
 =?us-ascii?Q?d6AStKQuShEn/iOra4jTN74uHnVGrN35K1qpEkLJzrEIG4cMHuO56+/8I0u+?=
 =?us-ascii?Q?1/OBB7yLfYP272k0XYR8Tf45aHoR0Z/6ZvTzl7LvvPSLT5vy/sjRoZzFO5Yy?=
 =?us-ascii?Q?K8K7vAek/NiMRucXiCQhLFaTGzw7QbI8nZ1GRT1qrnW6oFQV1t4E3UsOpqBo?=
 =?us-ascii?Q?XUI3exvrqbcg/SHKgLJ0/oOSe5TbmzfYlMAGmPomIeSHGlET10Za/s4LwLgr?=
 =?us-ascii?Q?xs73w9WRDtvscon4ZmaS6wvsizafMdrFgDCqqTmYgEdn9os7xyQFgvIe1U8u?=
 =?us-ascii?Q?cBCGNtu58O8RFDKtOYzVAHj6JDSK81k7XQGOeK3ZzyCz82GfFvaa9t2GhRWz?=
 =?us-ascii?Q?Lcr32L/3YyiW9hkcI5+hbEY3tbzampHldWvuoTvHXAi1yWfUazqj3mJI6qyk?=
 =?us-ascii?Q?LgnAfgxpQ2VYJnTHdz8MeKGe2tBXX3ch5SPEStzkVwA3w6XGdcsJmjXplxcU?=
 =?us-ascii?Q?LnftiAHLUj8ZSVItO4tNlT5bmsht5QdhaDp7DHUC?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6bvsFaTHVZ7L9xrjTrH80oDgc3FgBwIAXvT3qtbL2SCK7AoSXvVxUiSjq5iMn3aejgj/vsq8xmsXLOb73WCc2gFsD/AYWpWd5PvDgVgDiwny6q3o+ffmzoijPfb4No2PeqVATI493nPtGiWDjcWnaWMSAkHyNTWtp1loqRa//9W/+1fmHd2sO8sPal+9enWtIsHVG4Iu6yH+z9nXvEEid1x5u4ePSvpvMcKeHpokJ5tiQSXG5Tz9oW8p3C5tATyf6UJlRbz1N32L5AXe8w61HBl6+UtJHlkxvF6hQczhZwqXnJzqdnSFZmVu4p3BMO4rlrv4FxT5h+HpCch6QKiBOKzb3OckC0TyIfkRWApxPW1mMhEvYndCLhACBNW4fM20nP+cx1K8ZvmH+B6awaPCwEV+OJTRlphFrGCYgr7OlK34car4myCZNlFnppVZt/JuN2h1qjDrXiFehHHfAqUqtn5SFrLgdjBLuqnxS3VuZTBPoDBJC7mQpREpuGxnfIimau6YmYiMxhxXra4SzOpYw3XE8fXrfjqTvvVlYEGlz2fYDz9SEZoFE5tW70PqRLeRsNDbybvmA5DyA75/slblDSQl3WY+7fAp7TN6LAjKTJM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bb5e3ed-02b1-4b3d-b4d0-08de2270f107
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 04:56:01.2489
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CP70iVoswhfSWCOJ3qBdWlCXWPVEUCGo1KE4bik3DKV7Xf8e54m1Y0DGrbJrF4YbfcqE5xj2dfNk43BPrL+1SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7808
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-12_06,2025-11-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=941 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511130030
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE1MSBTYWx0ZWRfX7fYy2vmgdjDF
 98Qc5uDqVkPSq72Sjcqi7PqGLlYVbuPtjzGl/0biIL3QEpOmxIzmppu5zoohiidfh+hk+T7t3DA
 KamjVOlgiJOchW/+dp2d3wMCwrymY3/Mnx3sy14z4fSyDYaIvCRRzqWgoEPbhgn0HLwIG1m15oO
 EY8c63HE0Ftw1CxoWHXkamkCr+I4C0I7v7OaCz2u4qjFuqhUPSV6dy7hhJMC5h0JWgucjPbmHbn
 LMSdsEv1PQ1GdcOl37UvYiTrwF/gTmv8OcaNVdbDl2IB6AGnAaVb0Mq3AY7+36sD6Ryn6PDZ+lh
 MAYqWZyxl9wvtgepBO+kRG+xJnUbQ4kNAp/LLCjTsgXSCJamsG/UQ+OL848fyMbeIDzBH9lZrLB
 K70Xmn7Qmr8qcdhAKwyDjTIyuvCQu5PCzpb6Tj0QvTIugZ+5e30=
X-Proofpoint-GUID: 2PSlp3CC5rMtTGV37He7UWR9IX93yfYP
X-Authority-Analysis: v=2.4 cv=ILgPywvG c=1 sm=1 tr=0 ts=691564e6 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=qzn9hoOiA-xk4J4z_TEA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:13634
X-Proofpoint-ORIG-GUID: 2PSlp3CC5rMtTGV37He7UWR9IX93yfYP

On Wed, Nov 05, 2025 at 10:05:33AM +0100, Vlastimil Babka wrote:
> We want to expand usage of sheaves to all non-boot caches, including
> kmalloc caches. Since sheaves themselves are also allocated by
> kmalloc(), we need to prevent excessive or infinite recursion -
> depending on sheaf size, the sheaf can be allocated from smaller, same
> or larger kmalloc size bucket, there's no particular constraint.
> 
> This is similar to allocating the objext arrays so let's just reuse the
> existing mechanisms for those. __GFP_NO_OBJ_EXT in alloc_empty_sheaf()
> will prevent a nested kmalloc() from allocating a sheaf itself - it will
> either have sheaves already, or fallback to a non-sheaf-cached
> allocation (so bootstrap of sheaves in a kmalloc cache that allocates
> sheaves from its own size bucket is possible). Additionally, reuse
> OBJCGS_CLEAR_MASK to clear unwanted gfp flags from the nested
> allocation.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

Maybe the flag can be renamed later!
But I can't come up with a good one right now.

-- 
Cheers,
Harry / Hyeonggon


Return-Path: <bpf+bounces-40124-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7357897D26E
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 10:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 380162869AF
	for <lists+bpf@lfdr.de>; Fri, 20 Sep 2024 08:19:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAD082AEF5;
	Fri, 20 Sep 2024 08:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BrYRdM2A";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="n1UhQfnY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5406A332;
	Fri, 20 Sep 2024 08:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726820367; cv=fail; b=D3dlTOhFlCSUMGt/oNooGWp1c1fZJ5FgqNf5uBWBN8nP4V7q577vCSf83LiwYxOlPd9tZ5SKCuvL7lWKsPaZaA8Qyt1aVsBA3A2R8Vl27BSDjL8M3S7skzTaKxkrxIKsYWUajp3DEsUteAxMsQg8yOvre5K82jXTYoocGkfslNU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726820367; c=relaxed/simple;
	bh=apLBnC35b1U86vkBKLRaWCrqwHhchPNf4gAluzq0wjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NWFgOqm+98JkrZ6jum+daKNLkAcb0kOj+LMnqjoyaYERAP1XsDDRrCVw+dM8jvmtqEUsgUkVjwtT9dP3vM75g1PR3wZPex5SocslBcjfU56ScjzsE4PgQcgmFKnMrv+1p31tiPHBQSD72S5A0E5suIx2/Ss813SpI9NzSXptG2Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=BrYRdM2A; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=n1UhQfnY; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7tXa9027910;
	Fri, 20 Sep 2024 08:19:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=CGT/ZXOo6Rs/UZk68eq5Zsi9fWGrIPj8Q7JTm7xwILM=; b=
	BrYRdM2AGNcpiM/D0WUEnxv9rgiu7iGp0/u9vPnx1Ffxow5pX+XG+kK/Zn0iwaJb
	fNtHHg4esXPnLb14NXGLNVOKkwO5uxJl2pjFycHzLuRUXWONx2A+siyW8FOVC32M
	MUthT9glgSz2WcLasLmtMjDkMZFibtHGilLr09aNkW8dF9Fyp7ufP07DKuy2+mMB
	uivsu4UZylKX0yo09MY75DMcfHfASQyWFzI2o4YNknA79xElTJA0UFK1GCzIkd1M
	Lps/cGvhQl13CU8tEHlkQvVpbtBCYXyC9ySL/O9F1Xg8XAZNHNhqPIWvCkGb/ZJ6
	sPppgIVK8+rScK6ZSr0jiw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41n3rx62jc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:19:21 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48K84aps017770;
	Fri, 20 Sep 2024 08:19:20 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41nyd1jn3d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Sep 2024 08:19:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NN+cnmCC7v9CTvGMCxJcTFP7M/zVbIZQ60s5O8Mwtsce8Giv8UAtZtWJI9ou+ol72+Lg3C6KzTV+2xzHhLCjtVhxZkaDwTmBTBhSAvLudEtrE2wwofQmegHwj2RQoJ3pDGXPfrzTJ/ZuJK9c3MgvcCE574Nqc6G7fPduGrhhSRvTDMytxISFRfD8X5Zs71ehkq+di8bogySWEQsiUeQiLvlvkmkAc5pMoxELEsVX84jaiKBd4N6ZBxyfXR+0QF1cEl9IF//wNpTJraUmcdn4Rgu7KObB2EpR8KMsKDriCNYo/tc83KJO5kX/FygPmNlcQccD5hOTn1tTX//nRReYhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CGT/ZXOo6Rs/UZk68eq5Zsi9fWGrIPj8Q7JTm7xwILM=;
 b=qSG2ESOt0A1YRo2tLYxTiQbGWDPk/xfX5CYYfnck0CADjRZjkx79tJ9vPIrjOzoX8Dt3wOkmZSDncg8h/Sbtv8NWFdJgDLxuUcmLG+Tp45ABxTvnXzZFVx/p1xw0aJjOOYaabRiMAXNeVtvQ+HW2ZtSPzw/ZNIiMy7VPrTqR9qiOyqEt2FbZ4SbbxsJTm3RS4dvOYcHhBaEYqDyVmuMJnaNQN5z0sNysKrZExYg2T01Ra3GjHDqkrTVQE524oy+lS124/s4Z4XN/K1FEuVSJ8LMeI2/3izsUXLj/7YdJciDBXhegDOJBSAi9HWZHi+qNRXUmid72eDwbmT888fDouQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CGT/ZXOo6Rs/UZk68eq5Zsi9fWGrIPj8Q7JTm7xwILM=;
 b=n1UhQfnYbvbro51M6M7N/ZfABz0syFRNnmnmOs8lnY++buOX4+pkL99vHuqEnnYozQcTBY7s4bPU3G3LwnmtBFWpTrgzB8ZMp43oNEk+3NuIFVJXJESAIwf7JWCZD2YOjn3DgQWwxs4zusAQ2FjWLhkm98e1i/3asIKNkODf3mQ=
Received: from PH8PR10MB6597.namprd10.prod.outlook.com (2603:10b6:510:226::20)
 by DM4PR10MB6037.namprd10.prod.outlook.com (2603:10b6:8:bb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8005.9; Fri, 20 Sep 2024 08:19:18 +0000
Received: from PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca]) by PH8PR10MB6597.namprd10.prod.outlook.com
 ([fe80::6874:4af6:bf0a:6ca%3]) with mapi id 15.20.8005.006; Fri, 20 Sep 2024
 08:19:18 +0000
From: Stephen Brennan <stephen.s.brennan@oracle.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: bpf@vger.kernel.org, dwarves@vger.kernel.org,
        linux-debuggers@vger.kernel.org,
        Stephen Brennan <stephen.s.brennan@oracle.com>,
        Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH dwarves v2 3/4] btf_encoder: cache all ELF section info
Date: Fri, 20 Sep 2024 01:19:00 -0700
Message-ID: <20240920081903.13473-4-stephen.s.brennan@oracle.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
References: <20240920081903.13473-1-stephen.s.brennan@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0102CA0104.eurprd01.prod.exchangelabs.com
 (2603:10a6:803:15::45) To PH8PR10MB6597.namprd10.prod.outlook.com
 (2603:10b6:510:226::20)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR10MB6597:EE_|DM4PR10MB6037:EE_
X-MS-Office365-Filtering-Correlation-Id: 699f4f89-f2f2-413c-3998-08dcd94cec1e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wQVqp8fubPyV3IT6HbeiobL94nzmpndILBJe5jgsxf3kQke4YMVe1ftLi1w2?=
 =?us-ascii?Q?NH7lbFyrdB1xuxjcQkTur3Qp/EX8y+5HjXZ6twsY7EFHWslXWGQlQ2Py6QqO?=
 =?us-ascii?Q?1oQ633ZZlvvqQqq7ynjmSnEHN2k6uwgAA52Q/4iUcGxCCQdBILRgn2YvvKdz?=
 =?us-ascii?Q?S4WEvsQ5sa7t/2P3RHJFDFTmKce5BweFiglCTvDeY51A5IIJld1JtMi48F1O?=
 =?us-ascii?Q?wyq/THpQ7m/zbmbRvX7zAGZhc+sC+NY/ulsFDu0p/4LfeEgw1INWkuavsyqO?=
 =?us-ascii?Q?B6ln7d41aAA+z2IUztu/x80kEjo7hGZGMJQJzD/LfPl71se0shZHincUBmeJ?=
 =?us-ascii?Q?R8trr5ZsQkR3ghNhVH87LjTC7T9CmqXDlEK5axBFeeZFDcQwwDAlt3X2tSb/?=
 =?us-ascii?Q?/C82LiYyAc1jiMKgLTZO1Fe6wsA7AKT8QEr6EwzloDoayr8nEAl2ov4OykkE?=
 =?us-ascii?Q?SYNe9rczQxgUO4bygW+8DYFDm5h8Dnld9sR05Mqv3F4WPQlqFJnxX69BSq5v?=
 =?us-ascii?Q?/Z+f2uF0V2UCkZAgBS258rQlm+P2A4mpZHAX2AuW0PjnGIMfcCK68oN9PWlD?=
 =?us-ascii?Q?15kLy/Eh/I3W1JTojqEOtMmNMzP5lOJW82Bb++tsuLQGhoxgVKrP9K1a8mdQ?=
 =?us-ascii?Q?O1IQJnUGyOKFxoV+exkmArc7qsooHGoGW7RwJJ/7MO1b7X199wTonp7dIQZM?=
 =?us-ascii?Q?AsdQUEkZJchOCUYWSfyicl0Kfu6kWgWNTguNVdHnGXz5qYSh+iG/BbJE+2qd?=
 =?us-ascii?Q?flpnWEgS6b4HXZFrWio8YNms53w9M6fpPEwwW27Cgj3+/+BYzA6TCZw+0OoC?=
 =?us-ascii?Q?6NUbUAhq4cJd9go3k+U6G/OKlGOE4bc7vdcDVcwGYDhRC5NAdIb+VxbOn/tq?=
 =?us-ascii?Q?d4vxexR3vyvsMe4/wCvHsJbViaHWrvfgFZ45D4qIErrppYts6O8vRoY1+g96?=
 =?us-ascii?Q?UGsiZdj0c6Y+M2PkdkZgr+ELc/JgvhhEuQsWVci8TgG9UE2fvNYl+mjjY/w+?=
 =?us-ascii?Q?yoh4UV4vD3yIaS8Tfhc5PM51/skaKsGqcsYLPmJbhjdqS1oNiRilfb07aCUa?=
 =?us-ascii?Q?iguJkyKbAVDNiPp7oSifP8n8OMZ5v4SYSuTdE0c08kl/VYKmmQsGWU/odwZ/?=
 =?us-ascii?Q?4/ICu46aHHhim1ffR2LWdFJy1Qg8irVq7Sw8xhH2grPb/P62cEAVXljbgaNr?=
 =?us-ascii?Q?42qwdMXd/gefKzfqOQKe6ENdPuTlFYK5HSCKg7ct8jGs20bJjvc6rAuSqoEU?=
 =?us-ascii?Q?Grg7FOtK8sTfJxg7dKI2E6llk8Aj5QojGUcCt8Oofg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR10MB6597.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DCx3/QClxUGhKbLRq3bY7osw18SFzPm+Npt6n8ac+IEHhTvkhQydGResxrGQ?=
 =?us-ascii?Q?hrKH/t/mpxior3fNvPmuM9lU+eOEloqW0n2MgOGjNLHR22kNF1bbsLTNkvv3?=
 =?us-ascii?Q?JHpR5zkjtJH2LVXA3NU7ARU61hHIro8QEfcAz33mc7fxd1sSzAUhXkCXMKV8?=
 =?us-ascii?Q?w5uK4KcsFNZQ+MZggDNO8V4/b8w7dIQ0lvbFn6C+GyVjpCZcYBzlaIUarNNQ?=
 =?us-ascii?Q?EjuSHJFypAbHQBq2RSiBBWe82sPpuGg6eDLNPwYoTr0brA5jAZk3Y7spq0Mp?=
 =?us-ascii?Q?Mlock5tSw+LoCDdRd4cyQN0qSsCv2HUrG6Av9rye8W86rMI7uQkHZdGjBzwA?=
 =?us-ascii?Q?j4ltPlrR8HskbKDZap4g5eZXnqT4pQcggGJH/YT5fy8WVLc14EDGWqVIcfYd?=
 =?us-ascii?Q?XWrJrVQsTRC+aggU4CN7lQsm3yywyyJe4dMMX+sTDf5crkYp8pJb2Wzb+4BA?=
 =?us-ascii?Q?q37NP+Lw/woOwry3qeMv+4PWtl8ao+gQ4NCgUcl7f6dOCY/wT45AsdDveLU4?=
 =?us-ascii?Q?xCqLb/yqevhwja8c3uutmN9oEsVbSs/zlFV6n+moGinNu9Rwxh3o/ol2mc5R?=
 =?us-ascii?Q?LCDZRE8TuNRYibXgtI2D0HiKPFpRm//T41MIn3btIF8oia2ynCg910aFTu94?=
 =?us-ascii?Q?3hJ/SO+5OjfsLILAXpaCXT+iKh8oxr8UJYuhJcFsmYKxL/nJwi65RAeVmp8x?=
 =?us-ascii?Q?o+li77T5KsoHoJzZP/ynYhUMTB0o7LxZpUGTG+zbnysS/PBrmAXT+AY6WyM4?=
 =?us-ascii?Q?msszBafG5tw8UeR4AyZjEg2dBi3LJji0K/t3reNVmrE3Ts636X4JRIz4tK84?=
 =?us-ascii?Q?9hnSdp6gbxe+RgQQqG4zb4khchc8XMqwe61YGVIhcyQfPjp8ehECBehS6Cn0?=
 =?us-ascii?Q?ZSU6BX3d+HSnWoRsrJd4h3KYMsgxPYNBanTrGz9b0KxQnIdFQFtVXgvMZY8l?=
 =?us-ascii?Q?QbOe0duRoAkqxGeBR2dtARLDL8KqDxkiyI6xz0lThCCaqY1PwS6u5J1WCwCg?=
 =?us-ascii?Q?ovHACqp78yXHN/KhDdYkidiFXUlSFP0b5syQA0ea1BeSR1XqzosT0EfJrHbg?=
 =?us-ascii?Q?CBBK2LiZmYvIydknhauVVHy5ypRihEiXFwIVVtLSpI6SzaYa4NxVnyrYQDrm?=
 =?us-ascii?Q?cbeDTFttrfTeem03eR7tBdTOvy1DlMfvRIHdfzNqB6aVlWFEIghDI2WQAlZg?=
 =?us-ascii?Q?WDD5EO5AGm9a5Z71vA0JzWutLmf6KYygacLl+DXylIu8+CXdql8oIMxszqFU?=
 =?us-ascii?Q?0b7lYQAmd1a87AsnfArVM5IPG4ekxpB0dxdOLmQdVwpyGrvU9C7TUa29Jk4v?=
 =?us-ascii?Q?UBY68Vnro4t92t+znHtkEuLzD96WWCJb5S6oyre4gJp3KWmXMoaADxpZbZLl?=
 =?us-ascii?Q?Qditc8woHCCYlQs9NA1YGA92k+OdX6BxtIXb2CMC0IZFJlrzg+nRCt04TOPT?=
 =?us-ascii?Q?rBWmyu9Vf3eVveqCjkJ7NtZd6EKxrLr3cyik9+6NiM+JAySJrZ1wFeu+3SGV?=
 =?us-ascii?Q?4JlUzlsEtZbZT1EVxSeP/kakmbRNGmZleLwaGBW1ZqzRGCWIjhsb+eESDmLh?=
 =?us-ascii?Q?/SBI17qu3mpE1kgEoQ2fRjimoUtfgmUVICQU26INrX769lx45RVYZCB+KLZC?=
 =?us-ascii?Q?LQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kwKtam87kYKnWmfRyNgj4jnYsAPmeBe7p9pDwW62n15RK8i5hrHUbNbR06xT2LX3ePuP7D9ifBY6FLAQcP4nXIS72ieIdbU/P9ZVD+3+GRJaVDjvSTqYov1u4iw671DZTjuchA0lonPQRPeV4TtPC6BMH3zJsBFyCrxKDKbg1rmg9WW/2lDxOoBPH0j/+zncIOgm/RbbqvLmB7oUrUUbTo6sRJPzKY3xdGcS1g7sFd3rlHs7E5RFS4E8b9GvM/P8fkTS9zu+mauozfE9gqDr+2dh5Sny8UdBQUIg/eGHrz7g3PHO7VFkVa+kycbe6d0u6+rva+VVFfFw/0XxqMJf5JGoX3J3nxB72I0zxMOnyBifTqR3TsP/wxKw8t2iibxVzSgHsjbim/+gHTdThyHqyv59j3RXkP6nNi4DvYyKrEnMaT58A3P0W177k6gOBBIFWwHlPlbqkvWXA6wroT2jcGIBTd+JSQLjhUojaIsLsZL2U9n/0pDvxBAHO4nbFzGwA0eIVTPLelMTUNIY72uMs/JEoRMogMFdguAWlY2+ElGZGmRqjgC4VtfKCwe+5+qe7DQEVDRT9R4ACZVgQ72J1tI3akfJZJ2WmGwII3imTO0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 699f4f89-f2f2-413c-3998-08dcd94cec1e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR10MB6597.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Sep 2024 08:19:18.4376
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XCsBi9CFc2TRVWcuI5GRkTEW0Pg2Fxa7N+hyvdT1XMMkWfG/K/tGxSUdC8PxAPoaJ4mNgEu/S0AjK19CnW8allDuMnSsms9ODAwndv4+Qig=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6037
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-20_03,2024-09-19_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 spamscore=0 mlxscore=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409200058
X-Proofpoint-GUID: GsVqYUmBhrigi7Arr-NB1IRjK2_gJl9d
X-Proofpoint-ORIG-GUID: GsVqYUmBhrigi7Arr-NB1IRjK2_gJl9d

To handle outputting all variables generally, we'll need to store more
section data. Create a table of ELF sections so we can refer to all the
cached data, not just the percpu section.

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
---
 btf_encoder.c | 50 ++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 36 insertions(+), 14 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 8a2d92e..97d35e0 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -71,6 +71,12 @@ struct var_info {
 	uint32_t    sz;
 };
 
+struct elf_secinfo {
+	uint64_t    addr;
+	const char *name;
+	uint64_t    sz;
+};
+
 /*
  * cu: cu being processed.
  */
@@ -95,13 +101,13 @@ struct btf_encoder {
 			  is_rel,
 			  gen_distilled_base;
 	uint32_t	  array_index_id;
+	struct elf_secinfo *secinfo;
+	size_t             seccnt;
 	struct {
 		struct var_info *vars;
 		int		var_cnt;
 		int		allocated;
 		uint32_t	shndx;
-		uint64_t	base_addr;
-		uint64_t	sec_sz;
 	} percpu;
 	struct {
 		struct elf_function *entries;
@@ -1849,7 +1855,7 @@ static int btf_encoder__collect_percpu_var(struct btf_encoder *encoder, GElf_Sym
 	 * ET_EXEC file) we need to subtract the section address.
 	 */
 	if (!encoder->is_rel)
-		addr -= encoder->percpu.base_addr;
+		addr -= encoder->secinfo[encoder->percpu.shndx].addr;
 
 	if (encoder->percpu.var_cnt == encoder->percpu.allocated) {
 		struct var_info *new;
@@ -1923,6 +1929,7 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 	uint32_t core_id;
 	struct tag *pos;
 	int err = -1;
+	struct elf_secinfo *pcpu_scn = &encoder->secinfo[encoder->percpu.shndx];
 
 	if (encoder->percpu.shndx == 0 || !encoder->symtab)
 		return 0;
@@ -1954,9 +1961,9 @@ static int btf_encoder__encode_cu_variables(struct btf_encoder *encoder)
 		 * always contains virtual symbol addresses, so subtract
 		 * the section address unconditionally.
 		 */
-		if (addr < encoder->percpu.base_addr || addr >= encoder->percpu.base_addr + encoder->percpu.sec_sz)
+		if (addr < pcpu_scn->addr || addr >= pcpu_scn->addr + pcpu_scn->sz)
 			continue;
-		addr -= encoder->percpu.base_addr;
+		addr -= pcpu_scn->addr;
 
 		if (!btf_encoder__percpu_var_exists(encoder, addr, &size, &name))
 			continue; /* not a per-CPU variable */
@@ -2099,20 +2106,35 @@ struct btf_encoder *btf_encoder__new(struct cu *cu, const char *detached_filenam
 			goto out;
 		}
 
-		/* find percpu section's shndx */
+		/* index the ELF sections for later lookup */
 
 		GElf_Shdr shdr;
-		Elf_Scn *sec = elf_section_by_name(cu->elf, &shdr, PERCPU_SECTION, NULL);
+		size_t shndx;
+		if (elf_getshdrnum(cu->elf, &encoder->seccnt))
+			goto out_delete;
+		encoder->secinfo = calloc(encoder->seccnt, sizeof(*encoder->secinfo));
+		if (!encoder->secinfo) {
+			fprintf(stderr, "%s: error allocating memory for %zu ELF sections\n",
+				__func__, encoder->seccnt);
+			goto out_delete;
+		}
 
-		if (!sec) {
-			if (encoder->verbose)
-				printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
-		} else {
-			encoder->percpu.shndx	  = elf_ndxscn(sec);
-			encoder->percpu.base_addr = shdr.sh_addr;
-			encoder->percpu.sec_sz	  = shdr.sh_size;
+		for (shndx = 0; shndx < encoder->seccnt; shndx++) {
+			const char *secname = NULL;
+			Elf_Scn *sec = elf_section_by_idx(cu->elf, &shdr, shndx, &secname);
+			if (!sec)
+				goto out_delete;
+			encoder->secinfo[shndx].addr = shdr.sh_addr;
+			encoder->secinfo[shndx].sz = shdr.sh_size;
+			encoder->secinfo[shndx].name = secname;
+
+			if (strcmp(secname, PERCPU_SECTION) == 0)
+				encoder->percpu.shndx = shndx;
 		}
 
+		if (!encoder->percpu.shndx && encoder->verbose)
+			printf("%s: '%s' doesn't have '%s' section\n", __func__, cu->filename, PERCPU_SECTION);
+
 		if (btf_encoder__collect_symbols(encoder, !encoder->skip_encoding_vars))
 			goto out_delete;
 
-- 
2.43.5



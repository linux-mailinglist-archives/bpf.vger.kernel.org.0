Return-Path: <bpf+bounces-63004-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B9797B014CE
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 09:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC6A13B0041
	for <lists+bpf@lfdr.de>; Fri, 11 Jul 2025 07:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B245C1EFF96;
	Fri, 11 Jul 2025 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="B6vOAsXc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EREj9zFk"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF351EE7A1
	for <bpf@vger.kernel.org>; Fri, 11 Jul 2025 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752219432; cv=fail; b=IVAJvjCn0DBA3ms2+PgQC/gotiI59a4kBrJsHUiFo7mT0HpHsbKjKes5/OLav50V41LBh9qg9f0mPk1bN4+yiv0guhJdqJ3cPR/8GZ0kn7yizz72z6eNqMKpEO2pBikxCav1m3V0P1YvFMTcTrfj1unS6TymhKiq8Lyy4/f2WnU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752219432; c=relaxed/simple;
	bh=51ECz+jhY08K+4fwE62gyi9AtYMyUcJzh2uD25FPJl8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=LFt8EkLjt1WOWOkd3ApccSzJFZMQwqU6xX7i4YgwpnMfgc0D0RybyJJTOf2k0f9GJH7juQXigrthaTmaeYCfAj+ZUsKP1QyCZGaWkik0RhrpTjxg5TSKnKQDyL/IEA0q0JHPx/SUdTQRTTkhM2yMnzTgV4WUoLcoQqNwtBhFKdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=B6vOAsXc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EREj9zFk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56B6wfh1015528;
	Fri, 11 Jul 2025 07:36:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=MgRgql4vVSrx8Tugd1
	lnoZ25mvFLlyuXGnp1Ua2nV7o=; b=B6vOAsXcbDYaUme/M2JIbqIervcVEuZBoc
	F/VyMdTicvWkTGeiCnRb2tmfxK3wWZCgFo5wVpg3H4DuF0DnvIORteL2RVkLQRkQ
	TM0QXTrNxXNldEUdYu57bghoFYWGbdQYRMVFvnkwsIzHPL0jlYGjL8OhB/BSFyCv
	kzazzKk4jUP4j41gAHPEjYzy5B5dwTGj8S9zxzSF1JNDkQhpwGBdbniwidmf800U
	zMkStLf/oc6ejFKYm+n8Xam2VOX4fpqkGelBoD8+4E0SeS1EmrAwJijeRtVCD03J
	WO7yzJjQvV7toL/aQdUtu1EDnqZvFLCSYdVxc/9ddzUyRt0FosCw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47twsp820k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 07:36:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B6M7de023632;
	Fri, 11 Jul 2025 07:36:44 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdgbb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 07:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k62HrThrKxPDuph1ZWCfM5lR3Jns5DhuAdu8LT0r52z/lhpKvNgZP7bGi4skjnrRGTPsKOC3sRx/BqmV+wHRXV51VovQb+UJD3lC/ojCX8JPUQoI0MGVboecrZYnj0ETWAlDETFvcfRrMpP5SXhuaTQNHiIWZsiP74rbDBIAJPjKeutiRkCPSrGBzy2s2ieO0xfJEr+AMHnxzFip7tYcsoCujqQ7kVO5HkiBU7i9C15EJa2PekTjkBRKODTaXpu5DoRB12kTrCMcE1oXGGBHY6BxZmTG6ssdMUCu4YF+hSU+GBohw0c+eevnc4V+WSBJS2/FEM0ajhcHMMrU6FVBmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgRgql4vVSrx8Tugd1lnoZ25mvFLlyuXGnp1Ua2nV7o=;
 b=pW5GQc0dX1e3UWqrgtqaOHKtAzh6Km3Pa57zII28tBenGJCGCXzAa8mGiazHyyI38VxAZ3mRclz/LVvv/firhEc2H5THqJ63959jfCfncpuBlLDGKpT3iMLFb48CILdlN4EYUrV/k9Wi4A61m6f2SHS2KnJ3Y4kc72mYNKJg7mKzObubFWsPBjW9w0fkOYg3HSMMIzNUXF8GVApwLuue6rqdCFgR+xeJnzOl39myAW/F+e1zqt1rF+TwUvexJccfZnAKqjdGAd061eY6FHrTj9A7+93X1O0OGMiW5OLsA+n8y7xHl84D979w5bdhUlc/Mx26ms+jhRNnu5Sknx308Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgRgql4vVSrx8Tugd1lnoZ25mvFLlyuXGnp1Ua2nV7o=;
 b=EREj9zFkr0n/NPJxZ9PUnVSfo7NYuRY4SmND1z82Ly0oLqw7Pu8jIvh+iYu9LAh43kjZYk7R9tJCbhBcAGs36n/XOjccmeFFLUYg3zowluVWYY0VhLAl0Xav6RLk5r0RJaqx5cxM15dEynV3NuEFvxyaWpdJvIOf/hJbe92LBCQ=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ0PR10MB4574.namprd10.prod.outlook.com (2603:10b6:a03:2dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Fri, 11 Jul
 2025 07:36:42 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%4]) with mapi id 15.20.8901.028; Fri, 11 Jul 2025
 07:36:42 +0000
Date: Fri, 11 Jul 2025 16:36:30 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf@vger.kernel.org, linux-mm@kvack.org, vbabka@suse.cz,
        shakeel.butt@linux.dev, mhocko@suse.com, bigeasy@linutronix.de,
        andrii@kernel.org, memxor@gmail.com, akpm@linux-foundation.org,
        peterz@infradead.org, rostedt@goodmis.org, hannes@cmpxchg.org
Subject: Re: [PATCH v2 6/6] slab: Introduce kmalloc_nolock() and
 kfree_nolock().
Message-ID: <aHC-_upDSW_Twplc@hyeyoo>
References: <20250709015303.8107-1-alexei.starovoitov@gmail.com>
 <20250709015303.8107-7-alexei.starovoitov@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709015303.8107-7-alexei.starovoitov@gmail.com>
X-ClientProxiedBy: SE2P216CA0055.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:115::12) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ0PR10MB4574:EE_
X-MS-Office365-Filtering-Correlation-Id: e006885c-e72e-4558-01dd-08ddc04dadbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ps9Wo8L88a2T/EjME7TTJYJY00UthrvBAnY6/+ts4S2KeDmIaISnIsdjaO3v?=
 =?us-ascii?Q?7bM8vTXeHZRd7DR43Lu1zgxj0H/yBeyu/me/L9OWGpTRtLTn/7/B1LjkTnMi?=
 =?us-ascii?Q?pj5jkXrIFDq4YJeWIaC0f6eQ4QKFgvAW8y841YRpou99jhwn8ApQsPYcRUCr?=
 =?us-ascii?Q?n0Ov+ekm9fc1Y3fC8Cl/d74aL/BI4hY9v4BFnyQonvYhumlaKRx6UBTmgxg3?=
 =?us-ascii?Q?hVwqlMedM0oIuLzAZjLNXEJ9mHxRNCbC35rKlOFUVzxl19JIbRwwB6bUjV95?=
 =?us-ascii?Q?zrOkr7vwomFM8x6FW/4DeqvBlghnb2HYiaOIKwAp8v7h4GzfZB2R7DiKqBgs?=
 =?us-ascii?Q?S/P+qxgXFk/+db/FrvIe4W/BFJfvEsqHKxG7jP3JcNjkhUJATK6BCKWr1Ywo?=
 =?us-ascii?Q?DSpzDBQipyHO64ujk+eqcvAt2u28RAth6x8wksjGnaF3pwXa70r3IimVVc1q?=
 =?us-ascii?Q?AXI+6OUPlUjOPXpJKPXnwrAJIUefG2h9FRrflhVTC0sR1GJlfJMTGpUhOkh8?=
 =?us-ascii?Q?e0W+FE2IripSdxTgJaA7J12IAVB81SfxzKOQO/WqrJC7ffCIWTSklvelDCG2?=
 =?us-ascii?Q?1khKxbUXOSi5qBH8AJTD0jcBVS8AvU0U6jAxuXFWsXllO3P6REvkh8CJ1ekr?=
 =?us-ascii?Q?ZULrYv4hBgytk5g/NinD4YOQ/3uLCVXHKsLWbK3L4ZqhC7iBOlflQDjVe1Or?=
 =?us-ascii?Q?VGGRP6sbBEZXVy6jllPrE52rvhdUN/Pvlq59j6W9I21NMlvKcafMFZHmtpIw?=
 =?us-ascii?Q?qLd1ctPM7gx3oTR3/rg07elMKFeGWi9IBS8CsuAO7xriMSWmcf3ixfaIfQnV?=
 =?us-ascii?Q?CVos3NqZxgVp1LxGgAZqjW9Wnfy1BI2x5LFKag/GmbePl8BdkvTc7XICLhGc?=
 =?us-ascii?Q?89eaCdpom1yq83NIelgGb3PD3mY+gQHFc7IjI4tysHMVdrvjM87Df/QHoOmE?=
 =?us-ascii?Q?cfnKj83nZg8oe8NHSjmEVLVVewStjQdN9TAucDASpEBUe3IB83uAquqPBs1r?=
 =?us-ascii?Q?qddFUSafBoz3TIs2OMSiVfPBAvvnp6bBj0HRJBjtE5KKUtU6yjy+4Gxgo/oS?=
 =?us-ascii?Q?QsnYvtRrjaITSsRkYPsM9MFoG1rfaUzfg7tswKsgUeCPZ27npmNLmtLGO6Ma?=
 =?us-ascii?Q?QwkHVes9PYJkquSFo+K55Nz53WY8hkyiD4drQkqAW54EwRZlPmwz1TCTyMqE?=
 =?us-ascii?Q?DT8Ion0M4SdLc+M19U15bslD7UmC1EliX4mv955YHzBAspXNcsOv7Ut0Z/fI?=
 =?us-ascii?Q?dVhZNfd5MaIqJ1u/5DBJmzrhRhJMPe3G6DKPyIQZFQfpt660MlNWxd8ANuqd?=
 =?us-ascii?Q?2K18YaY/Cab142TR3iA5qZShGM5UNk+0o0ui5j6QXoLXSvWGWpJMGEEZ4xXw?=
 =?us-ascii?Q?tuyouwAmJ0UztYa8kIFj4EoC0VkDRTlNsGCHz41iZeaxHteFki+yTMyqBVAP?=
 =?us-ascii?Q?YJBi4C/Cy+k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?QVP92hL4aH398QAx8uWaEE9Lg8LQ9DQD+nbMa5OdAzjTnel16KWQcge9Ua9n?=
 =?us-ascii?Q?IyaXBg/O9nVSO7F2RN/aptp9HApR2KP1lMGSlGVOQf7SL9hoKq4nfFOWcc4T?=
 =?us-ascii?Q?T5LRRSeldEKGCtEbx0fGA2rrgtZKZ8Mwe8elhKuHdRZJo3Q4e3OWIgZE98bW?=
 =?us-ascii?Q?P5BarhDhv+c7oPQ23QWDtuRbhFoBZwjfBXpvrKGeEfX3CjKuhp0qBy4U4u7n?=
 =?us-ascii?Q?RViU9hSR5XN9q4tkk4+PPCcfhGfxYTYI+WqD2KAFTyXzIPKObZ7Qf2baUHjF?=
 =?us-ascii?Q?Fm2f2FkO5Kmp533wjU4JNsvY3SPrK6IEFoswFAc2/Jj2LyVdwGgIk+RqUnqM?=
 =?us-ascii?Q?3fOldvcG8iSQVq5Xw4jI+KwaVikpX7Xez9CWl559fahMi/y4VhD5+EUmVuZe?=
 =?us-ascii?Q?uCS+e21YNdeXbfm2sckLEg6LHcpFsVP8ppGKTOcrBFbzoCi0MXKCEUJqAh8v?=
 =?us-ascii?Q?JS3M42MByyKhPWaVXe0QSX9YWRstb1Xes3o4EgNwdy+MX+K8EkbCxibQ1+eQ?=
 =?us-ascii?Q?f4HwX4/PH8f0RjJgYqwwV+5E0VDALjvmgRSKHzRmNITB15Cvy5eTgP5ymHBY?=
 =?us-ascii?Q?hK5npquT9KM2/GsIYusY1T1oZjrAMgDsOBtRJ8duuMwipELOn88geFW77Jft?=
 =?us-ascii?Q?jr4KF7gmQlb5TuarZLlBCVKgMBrcs+jRdC0qEaR1VG2Lj5WvQlVPHpqUVPN9?=
 =?us-ascii?Q?tviinbjcQ50qmqxYt3/Xs1vKbTmInv3MDlGQCtqnDtvUOAGZef7C3E4QYnoR?=
 =?us-ascii?Q?C7SFvBBAi9Asqud1f+sTTvFmvRnX1VU/8Jgjjnfon9uSjoKtLECjYNGbJLpV?=
 =?us-ascii?Q?yvxt3ZJXaU3F6PkI5bK0aaTjvoUBo8eR8soIy8GJxmnWME5iFSfYXi9X4Bj2?=
 =?us-ascii?Q?lOGyhowKgS1XiYVH3MFhpyo8hTvN6RjFt/EaADAOeUfb/j57yav9xOPNyE4U?=
 =?us-ascii?Q?yJodm36oGtYzRsYbVcOx0AkHWvi1Z4dQneNjTPIu6sd1FYFll5uP5XZ9X4G8?=
 =?us-ascii?Q?SBhnXl82ApQyubHPWlAt/Frol3sVMFEmH6CdJvrXEnQY/hODLYfz4SeFUi+p?=
 =?us-ascii?Q?BfaMZ1oTIe1PpwD5oftDbuY4pUlwWoWZpNFvRtHSHiT/4UFNpF9dyw6zr5B8?=
 =?us-ascii?Q?yqf334Q+CMHvemiY4oqJcx95Thddgq9cI5GCQRZNcPnl6i6rA+GnTXdPFLZS?=
 =?us-ascii?Q?2srghttzMCa4YQwBp8ZPP+qTxKR8gVtzcS36whxmugDvbt3NbEtTPUcZFsQr?=
 =?us-ascii?Q?phagfRmsnN4ra4Tw7EsY5F5rFb1/TRoJKbTE5MK3n1Og16qxzGP2dCyZmVLJ?=
 =?us-ascii?Q?y3r0tvWRrOvX3wlpDXnondgzuili8/pwN3nV4IHyw7Of9sKOEIL2ORyO63mv?=
 =?us-ascii?Q?bafDeqhrVL2iw+8KjYcCSUWW6+0OXmvTyjIhFpWD2ztZWwvDcC5xSSSAP3gA?=
 =?us-ascii?Q?eqwsCONXqn1Xb0ePWW47eRYx/WUER5ae4gt5ke9ZCmfb6Nm3cIkW04ehELWo?=
 =?us-ascii?Q?0qN21Lnx9irJX/9yFCFySmInhoLLzC13nk3qxkxDBDEYeNqjYRIk4Ga+1TfC?=
 =?us-ascii?Q?GHzBuVONOWCgK+Sjwwg7SeYwmN4GTf3uZVas8KxO?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hTF8cfPNkI9fUPWu5XPtHsuJchPh87NFVOp9YbxyvsRsn8HCh6aMJhFf3R2imBcK62SShojKUBKqNivEm+Wcum6vrN7dl0L5gqk2ngGAwfqPP/awvNCNzokBN9rJOcA8wV1lWY1nVV07/Gky4HihEiAnvNJsDXA5WO890ZRTEnjtrysWaKuHvm+8GyZVoRH6V2a7MDITxtE0WCgMGuZLWC61FG/OS0xD/POmB/DUASBF8H97lu8NZtVeZJQUMrsAMG5oVtiM8aHmOEmqvx6+xdAIjJGDviWJBvc3XOKhrdDlyAsaKyzXcvoJjLZTrS4HA0X4lO1DECyiZdx3l8mOpkb4Gkj41qxf0PqrxvMJzp03Isefj4Xnfchh/qThqYRb0sQpV3m8nmwNcZY3GaDuo/LAvXSrIFcceldgXiZCj/tyRPpkGWwTlalb4JGYKGKRyRl8t6seo3EM1Tc7gIXr+2m11Pn5KtIVm5N8mMSd26sM5cXHuWTVG4tf+DYi1GlBwsQ2ONHeFdkj17FJuR7pcX39+Rqf8ExYZQuRdoC1VJH9aUm51CUfrddl2d4HfEQ2SgJPMHMDZwExrYHo+4O91n9SX+5UEL20+FDwXv712oU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e006885c-e72e-4558-01dd-08ddc04dadbf
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 07:36:41.9975
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUBTvHZBRE+W3LHY6af/d/nh30TzidLGDz6bQkPLrkfESkwBy9TQmgvmy3n2NoRBlmQh3qFKqu+HHqaHLZUWYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4574
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_02,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 adultscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110052
X-Proofpoint-GUID: yXGlUUnZgZD7oQwMUH2llLDyVhA5rKHE
X-Proofpoint-ORIG-GUID: yXGlUUnZgZD7oQwMUH2llLDyVhA5rKHE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA1MiBTYWx0ZWRfX0sv/+ffeI2sQ tPt0ON5lCDxXO1tsCDVeQWa4GUaNijhTAUwVYGM3VWDjPWOB/YPj2nccZlXtz+pLpuISGj51RHk 9kJNKLIcc2VvU6w6YH1fEsJdzWDEVB7/boBYPbl+sdZv/CMtoFpsc7UulE+0oz64VZ541rmaIE/
 dAE9v38fw71VEraUJBOLgLl0513AdY8DNdYmnILK4PllyPcsLKtHP/6KosTapj9Nx29B5mq2xqN d5qobts7dUFDTZnOdu2wP0zI46kbo4C0gamqvzl8bxf6WQDl8LFRsZxC5FXodFl4wWUHjsPWst2 7/JgZ8IL2fDKVNoHaONb6n+MYfcuTYYMzvtcaY8u+D4k4jBBpBHvFqBIzt61cnQn1BYlQrbJAMp
 rMiWKpGSEIaVMWUf8OnP2Q8yqaBDwwjXJ7hVLB4z2LifYqL88glUygJ/FKs2Bfek8FKUPBKB
X-Authority-Analysis: v=2.4 cv=JdS8rVKV c=1 sm=1 tr=0 ts=6870bf0d b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=_p2jpVv-lSKmeqpWh6gA:9 a=CjuIK1q_8ugA:10

On Tue, Jul 08, 2025 at 06:53:03PM -0700, Alexei Starovoitov wrote:
> From: Alexei Starovoitov <ast@kernel.org>
> 
> kmalloc_nolock() relies on ability of local_lock to detect the situation
> when it's locked.
> In !PREEMPT_RT local_lock_is_locked() is true only when NMI happened in
> irq saved region that protects _that specific_ per-cpu kmem_cache_cpu.
> In that case retry the operation in a different kmalloc bucket.
> The second attempt will likely succeed, since this cpu locked
> different kmem_cache_cpu.
>
> Similarly, in PREEMPT_RT local_lock_is_locked() returns true when
> per-cpu rt_spin_lock is locked by current task. In this case re-entrance
> into the same kmalloc bucket is unsafe, and kmalloc_nolock() tries
> a different bucket that is most likely is not locked by the current
> task. Though it may be locked by a different task it's safe to
> rt_spin_lock() on it.
> 
> Similar to alloc_pages_nolock() the kmalloc_nolock() returns NULL
> immediately if called from hard irq or NMI in PREEMPT_RT.
> 
> kfree_nolock() defers freeing to irq_work when local_lock_is_locked()
> and in_nmi() or in PREEMPT_RT.

Does that mean in mm/Kconfig SLUB now needs to select IRQ_WORK?

> SLUB_TINY config doesn't use local_lock_is_locked() and relies on
> spin_trylock_irqsave(&n->list_lock) to allocate while kfree_nolock()
> always defers to irq_work.
> 
> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
> ---
>  include/linux/kasan.h |  13 +-
>  include/linux/slab.h  |   4 +
>  mm/kasan/common.c     |   5 +-
>  mm/slub.c             | 330 ++++++++++++++++++++++++++++++++++++++----
>  4 files changed, 319 insertions(+), 33 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 890011071f2b..acdc8cb0152e 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -200,7 +200,7 @@ static __always_inline bool kasan_slab_pre_free(struct kmem_cache *s,
>  }
>  
>  bool __kasan_slab_free(struct kmem_cache *s, void *object, bool init,
> -		       bool still_accessible);
> +		       bool still_accessible, bool no_quarantine);
>  /**
>   * kasan_slab_free - Poison, initialize, and quarantine a slab object.
>   * @object: Object to be freed.
> @@ -1982,6 +1983,7 @@ static inline void init_slab_obj_exts(struct slab *slab)
>  int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  		        gfp_t gfp, bool new_slab)
>  {
> +	bool allow_spin = gfpflags_allow_spinning(gfp);
>  	unsigned int objects = objs_per_slab(s, slab);
>  	unsigned long new_exts;
>  	unsigned long old_exts;
> @@ -1990,8 +1992,14 @@ int alloc_slab_obj_exts(struct slab *slab, struct kmem_cache *s,
>  	gfp &= ~OBJCGS_CLEAR_MASK;
>  	/* Prevent recursive extension vector allocation */
>  	gfp |= __GFP_NO_OBJ_EXT;
> -	vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> -			   slab_nid(slab));
> +	if (unlikely(!allow_spin)) {
> +		size_t sz = objects * sizeof(struct slabobj_ext);
> +
> +		vec = kmalloc_nolock(sz, __GFP_ZERO, slab_nid(slab));

Missing memset()?
as there is no kcalloc_nolock()...

> +	} else {
> +		vec = kcalloc_node(objects, sizeof(struct slabobj_ext), gfp,
> +				   slab_nid(slab));
> +	}
>  	if (!vec) {
>  		/* Mark vectors which failed to allocate */
>  		if (new_slab)
> @@ -3911,6 +3953,12 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
>  		void *flush_freelist = c->freelist;
>  		struct slab *flush_slab = c->slab;
>  
> +		if (unlikely(!allow_spin))
> +			/*
> +			 * Reentrant slub cannot take locks
> +			 * necessary for deactivate_slab()
> +			 */
> +			return NULL;
>  		c->slab = NULL;
>  		c->freelist = NULL;
>  		c->tid = next_tid(c->tid);
> @@ -4555,6 +4707,53 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>  	discard_slab(s, slab);
>  }
>  
> +static DEFINE_PER_CPU(struct llist_head, defer_free_objects);
> +static DEFINE_PER_CPU(struct irq_work, defer_free_work);
> +
> +static void free_deferred_objects(struct irq_work *work)
> +{
> +	struct llist_head *llhead = this_cpu_ptr(&defer_free_objects);
> +	struct llist_node *llnode, *pos, *t;
> +
> +	if (llist_empty(llhead))
> +		return;
> +
> +	llnode = llist_del_all(llhead);
> +	llist_for_each_safe(pos, t, llnode) {
> +		struct kmem_cache *s;
> +		struct slab *slab;
> +		void *x = pos;
> +
> +		slab = virt_to_slab(x);
> +		s = slab->slab_cache;
> +
> +		/*
> +		 * memcg, kasan_slab_pre are already done for 'x'.
> +		 * The only thing left is kasan_poison.
> +		 */
> +		kasan_slab_free(s, x, false, false, true);
> +		__slab_free(s, slab, x, x, 1, _THIS_IP_);
> +	}
> +}
> +
> +static void defer_free(void *head)
> +{
> +	if (llist_add(head, this_cpu_ptr(&defer_free_objects)))
> +		irq_work_queue(this_cpu_ptr(&defer_free_work));

By adding it to the lockless list, it's overwriting freed objects,
and it's not always safe.

Looking at calculate_sizes():

        if (((flags & SLAB_TYPESAFE_BY_RCU) && !args->use_freeptr_offset) ||    
            (flags & SLAB_POISON) || s->ctor ||                                 
            ((flags & SLAB_RED_ZONE) &&                                         
             (s->object_size < sizeof(void *) || slub_debug_orig_size(s)))) {    
                /*                                                              
                 * Relocate free pointer after the object if it is not          
                 * permitted to overwrite the first word of the object on           
                 * kmem_cache_free.                                             
                 *                                                              
                 * This is the case if we do RCU, have a constructor or         
                 * destructor, are poisoning the objects, or are                
                 * redzoning an object smaller than sizeof(void *) or are           
                 * redzoning an object with slub_debug_orig_size() enabled,         
                 * in which case the right redzone may be extended.             
                 *                                                              
                 * The assumption that s->offset >= s->inuse means free         
                 * pointer is outside of the object is used in the              
                 * freeptr_outside_object() function. If that is no             
                 * longer true, the function needs to be modified.              
                 */                                                             
                s->offset = size;                                               
                size += sizeof(void *);  

Only sizeof(void *) bytes from object + s->offset is always safe to overwrite.

So either 1) teach defer_free() that it needs to use s->offset for each
object, instead of zero (and that the list can have objects from
different caches), or 2) introduce per-cache per-CPU lockless lists?

-- 
Cheers,
Harry / Hyeonggon


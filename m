Return-Path: <bpf+bounces-39196-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD7C9704A2
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 03:23:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D803282903
	for <lists+bpf@lfdr.de>; Sun,  8 Sep 2024 01:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92335BA3D;
	Sun,  8 Sep 2024 01:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aXfymT6/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VmTzEIGE"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDD290F;
	Sun,  8 Sep 2024 01:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725758576; cv=fail; b=bvIAy/+A9GI5pABlSU3xpGVN6+tRX++NDWGSMkocqhLUUolDvQtUnI7VeQ1aPZIxhEnYSlKI/l5M6o8LUjF1jFwfUrMj7sPFwxp6u1E7hsBcvRBgVSpWXHBr4OZwPeiYIVPoCgMR5cgQTNV+Mb5rW0fZGmKzOz1ANLOhwrbn0I0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725758576; c=relaxed/simple;
	bh=S+FD8GQZ82JNUdrAYRY4jMSqM6YGwoi9jIr5o96sztQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=M7ZrpA6jHM581ecJysnz+O11qqazVTLk/YpM7hkZ4EpLNCGTqA02TYT+TUsDzokFjQMtQZJdzIiLzkaBkJXONj4FOqqlVCUYC2tCFOBO+PN7/vqr1jQNuBb2WLMC33aO7lMpqA0/HbLMN19rZq/yi+bP/oElMo1yGVAy59oCYcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aXfymT6/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VmTzEIGE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 487MMwW9029036;
	Sun, 8 Sep 2024 01:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=PVk821PHGMQdePu
	ha9jpctwCh4gP0PDRwiViiiN5Jww=; b=aXfymT6/wPrIZmiM/ubyi5rWvoqAzPV
	Uhh3YAo/PvR9vXWh5ngZULnGLKjzDWUCUItgLQ87H7aQ4boi1qI/y9ZLiJM9EnJZ
	VsgSGUJI/x2LZx8nS0erAx+qnaUmSPmAhRSxB+mq9xLIxx7KZ4MZmSBADrUc3oDV
	8V+J4ODoG3EyTeKu6zSjAhjvKCwTMfcoqzmGVEzDgbhl2IhDmBJzwWz4cz5mvp5z
	jMu22bHCRwoZfcgAa1SJRWbZTZYIBPscImSjouwNRRzroRL1WYZgFY7rjJgW3SFg
	eIxcaeA67WC57jZWazmgXv8Hkt5oyUO4ffsMjMdgHa1LxTAWQaVq8DA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41geq9gqud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Sep 2024 01:22:33 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 487NQfeR040912;
	Sun, 8 Sep 2024 01:22:33 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd97aswh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 08 Sep 2024 01:22:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O3QLL/yVsXHGEtZF35iVQ07rGgquBC7NvCYwRZWVGKUBwVcvkrxCvAZJH/BWEgPZQBr3GXJU8DlYi+2hyaYj0NrUa1FXrop2Qkm0XxQy3Weh0D9Pg99saydkZfm7N8jn3xpi+bKwrjgbjuXRL61CmPj/yBC0ecHUM1VfX4PrmSZV+rs7l6MHp5jn51Fm22GRwniLxFmSHzNN7iY7ncvVUoezuO6kg0VOU35K8NRNiSYq4aMoSZ5V+09usu/w0vnLt4mJqRAY/1nWc2rXX71hH3b0xFUfhlpAB+WQS92MQ8XIVOTBpvnOXjbI8bO7H7Fy5IwQmW4dMwZtJuUblmZq4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PVk821PHGMQdePuha9jpctwCh4gP0PDRwiViiiN5Jww=;
 b=VsZbQJ06lrDr0befBEdECrG98ibk2IaT892PBy37fjYFeeofsawZjAzYaVJ2SKV1AgmEz3gGOgxq9HSdMFpS35w9jjIWa9mP645nBLKNrDNqsuuRXBW6iffzztCE3xAVL2xDeaoVGLdf4iVcJGj6jwgMg2DyoNknlwtNFjGv3UmJqAiLUH/xLLVk1Dm9FqyYkzWbkoWRqZgRQuWI1KCAtouAfLOP0o5fJP3H10ZY7qZbIY+jnbVxs2lxS8L1daIdhTdvQTuo0zaIk18uMFAU6BxvN4UUm079I2G4JuWFlflo2S4szwYhAHZIk2oePLZHMdVhO2cSLUXRc57gvOlHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PVk821PHGMQdePuha9jpctwCh4gP0PDRwiViiiN5Jww=;
 b=VmTzEIGEyPYsIoPq5zqMtDxNBttz3upIXhVIyyWzMpmsXc31S6fMbueDuvQ0mJVaoTtHN9gt/mhqfzBsiJmxEZqEZBzJDk/tW5aLuGLRz8ynb3cGXJCBCmx5LezVMNpTin6O13M/2tj4Yf3YP1Iikdlx/6xlYovLCj2pwQ9LRKs=
Received: from LV8PR10MB7943.namprd10.prod.outlook.com (2603:10b6:408:1f9::22)
 by CO1PR10MB4721.namprd10.prod.outlook.com (2603:10b6:303:9b::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.14; Sun, 8 Sep
 2024 01:22:30 +0000
Received: from LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d]) by LV8PR10MB7943.namprd10.prod.outlook.com
 ([fe80::a8ec:6b6b:e1a:782d%7]) with mapi id 15.20.7918.020; Sun, 8 Sep 2024
 01:22:30 +0000
Date: Sat, 7 Sep 2024 21:22:27 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, peterz@infradead.org, oleg@redhat.com,
        rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org,
        linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org,
        willy@infradead.org, surenb@google.com, akpm@linux-foundation.org,
        linux-mm@kvack.org, mjguzik@gmail.com, brauner@kernel.org,
        jannh@google.com
Subject: Re: [PATCH 2/2] uprobes: add speculative lockless
 VMA-to-inode-to-uprobe resolution
Message-ID: <u2artc4iwuoo5y5rutseqlvnq4i44mcxne2ufwg3ya2hyonv45@v2ob54ci6ky7>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Andrii Nakryiko <andrii@kernel.org>, linux-trace-kernel@vger.kernel.org, peterz@infradead.org, 
	oleg@redhat.com, rostedt@goodmis.org, mhiramat@kernel.org, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, jolsa@kernel.org, paulmck@kernel.org, willy@infradead.org, 
	surenb@google.com, akpm@linux-foundation.org, linux-mm@kvack.org, mjguzik@gmail.com, 
	brauner@kernel.org, jannh@google.com
References: <20240906051205.530219-1-andrii@kernel.org>
 <20240906051205.530219-3-andrii@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240906051205.530219-3-andrii@kernel.org>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT1PR01CA0128.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2f::7) To LV8PR10MB7943.namprd10.prod.outlook.com
 (2603:10b6:408:1f9::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7943:EE_|CO1PR10MB4721:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a6a8949-01bc-401f-6734-08dccfa4b50f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TdQffV4gvtrKXhGfva1o5r6L3d6viJfy/nPCVgcEjnMZe+BwwD3+ePYWP0Dw?=
 =?us-ascii?Q?ujJgtnbjcHHXNSNh9t+hhhwT2nbGa/eB9nYNOVDurc9o3VhxNlif9NyC5vQn?=
 =?us-ascii?Q?cIXOEpPxIe4JcohehHMClIDkhrrU/LTOMFxnMvRIqfR34SeD2LmTHbosfipA?=
 =?us-ascii?Q?6jNXTEm4eNkHiy5Fht4xXd772ncXdtTm7NbPM1qYiezKCoZjH+wRgPy+KH5k?=
 =?us-ascii?Q?gbQYlwOjk8qw7YjFK1WDrGZieLWE84Zd6yYsVGyH/FP9xC2oh/tbdJV1Gh3P?=
 =?us-ascii?Q?co8VOjMBrDpwNG9mMbYz4tPP1U+XKBaAXZg6WevEYauvqoyIB1Pi/upgr6eR?=
 =?us-ascii?Q?pLJh8kuobLoI6rWCOiUJF+lAbDqMGjccKMWan7eDgbIqEXvVfUtg5zhc6i/b?=
 =?us-ascii?Q?PZcpmDWCVy6P+YxwdHU15/tSOtTBrMxT9l1QHVQzmpjkVAchuRuTD+OwItja?=
 =?us-ascii?Q?uwe1gzIFOpiUSC6aPVPdktGQ81p1b5pGIqBuxGuuuTKX+CxFz/a8GZ1jqdDK?=
 =?us-ascii?Q?VzZx9P9eAGgL/XkelJ6z8AqmnOmHhyJQ2TgzVFVClOWa+fcN85kPdG3cBJZ3?=
 =?us-ascii?Q?Kfr0MKGtt/hQJVEFaxVGoRtPDJX6+5EJZv+4P+cwkkT0iQR5Qa2fry+EWkDl?=
 =?us-ascii?Q?/+lBzmQjyE1h3puca0jTycFUFOxerqubgb+EFy4OJLJwGXluRsKgb5mYrK/R?=
 =?us-ascii?Q?h/6DcNBt4Uzpcdqq1Qa8wLaxpFQ9AvFhECKaNFrtWXoPTVUFEz1fF2bPWs7P?=
 =?us-ascii?Q?2LkauJ4F0FUpj03G9Nz1/Nb+kwU6+E4D8R4jM8jeoKwV4F1p//YSLfc+IpgV?=
 =?us-ascii?Q?3ZPTo+BhegU05IyeusfxfdS6A79TCO4uvTq5SRWQ8/XzUGvIi8tMa0UAF+Ai?=
 =?us-ascii?Q?G7OhCrOvkWk4fiQsi6JVWjHMaEI5aEEWH4c91wtlkD4MXkGGd7GOHpTMTpe+?=
 =?us-ascii?Q?PoRRAvzQBZ5S0tvIieHdTP4/TttHgfkw3AmGxTpb7weEGvV1zpyF0+Fwx1hf?=
 =?us-ascii?Q?9hLU0UOD6CZ26+YWlrhFP6JHblxbiUk1Zq67oTov2Ly/kgcTAGqWGPwm9yWu?=
 =?us-ascii?Q?k2VxgobgetT/8ekEDPvz2U0uxmOINHucXZ6wEpjv133DrjKLF4WgTtyCXbBd?=
 =?us-ascii?Q?O8sjXFYJxHM8B170r8z+aBEHQfd2sTzU9uxSQn0Of0tBv6ITx13ZghzHNwUo?=
 =?us-ascii?Q?a/0wdMsq0HSyLdcSoowdT9McnwQraXF+K9LOUrG9HytCENeylJeaNl39O4EO?=
 =?us-ascii?Q?NiyisiVLCnulYgxLKGGU2NaK9YiGuR31C4Va73oTe9zVTmzHotgwwrJEOz5P?=
 =?us-ascii?Q?0I2mcrLyWAqDhsaaqyOIO0w6uSy0dJTkY0gR9wbpvNZg2A=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7943.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p81s4B+QsH4BIKQg7w38dZMYay2XEyqZMw77Y6rs8UhssDLxJ4jcje351z2H?=
 =?us-ascii?Q?l4bNCMpnsJ9woRo3/zmrnY26AH7YpuVj7zjeQmnNGnSCwWeVO3dQm5KnaTVX?=
 =?us-ascii?Q?bj0QKqzDGlE5GwemgBue1s5CxMjhze3OHoFdF4ykqVSX4112fWR5+nxUzvTx?=
 =?us-ascii?Q?XeaxdemCPQTS1e2vnj7mSib9jw33vv6EodLBid65KD1OANX7Hm28ZHpdqf6z?=
 =?us-ascii?Q?cm0+LefN/CFbjRLIE01X0oicnpU56GspmPyw263iS3u2d0HBLcmeSEVRwtwC?=
 =?us-ascii?Q?UyY+8Smarzo8WdLbHJkFG+e17BVXzJQDr+LVdw48Uw4GAfb+8WLmm2ml9dhc?=
 =?us-ascii?Q?BHDzeXr7eFPlfHv36uRwQdlwcjZnqs4HKZ5v/mwHrbhhvZXXPuQSj6SvB3Ij?=
 =?us-ascii?Q?VD0/fz6Yr+v2zu+95+DIA/PDjUrzUuU9azRPgZvLfH9RSZCeZyw5WrUvBLvS?=
 =?us-ascii?Q?bd2vO0OEKwc+0Iz+/2rGGBgM870Vh5lQLBgHgIeO1B4CD4DxmDVFaySmU8nR?=
 =?us-ascii?Q?xczcd2w04WRl7fhSLN+bk6OuV3WTcThIpdznt3Tnj6cPAeGc5pHzMb2tkVZC?=
 =?us-ascii?Q?d5UQH2GXOmP/n2sXz2eD9NpzrWXBzrJ3qqAiHpxKmHkjCXwJhzLtrtXNkejD?=
 =?us-ascii?Q?pUncd5cCBIj9v7V0VliWZEy+XkzJME57XKDHh1XoiJ+f5pwENDdLZhS2vBrk?=
 =?us-ascii?Q?7UJZ6nTINDeE0uGT6TQfM+cZBf57+uNLjnmWzu7/bi753YaAXAmpNvQ+ru1g?=
 =?us-ascii?Q?XBs+F32vHD/hOJJwOhG1NfghddRXoEUbTqcFZONxscES0Hg3CykNhB+juPTp?=
 =?us-ascii?Q?xq+Ojd64KkGWae1GKMbfgAiEeh2pUgqF7vLtMhqHgJU62FbzYSRgrLJSVLyz?=
 =?us-ascii?Q?FDecDSggYMAB16ntajqzsG+Q7+eAPek/9NuAhkQrozPqP0SaHKi+Y3+9CgPO?=
 =?us-ascii?Q?LY3zOjgi6ETvWJ+lVjzrvC3i0s4cDtPQQOxO7J3K+EtobbGpM56SLzndOykp?=
 =?us-ascii?Q?jmfq32lXIk4ZhzK36p6Fvea/tDUUaaOmRe8xF3h6FZlvbsM3PyE00ezB7QG9?=
 =?us-ascii?Q?MV3PhqRMuy6KNb1HYZBQUMouEL1eCcLVhXVw5BODaFt0IDcuHbEwgzi7+HUn?=
 =?us-ascii?Q?N3dk5ZkWW3uCTUZStjrJq/Z5nsRbekxGX2PwL68+M8CE9tjZokidp/c43yHt?=
 =?us-ascii?Q?FqVJEC7Tz1acqP+fJchLpojNp25xjM1l/srelMiq2v+7dRWGmKwggcVEMOFk?=
 =?us-ascii?Q?qUFM3cx4lPGbHRqrwUVu72jsM3ga7rjU9TLtRTvsrXqoHk73wZUM4FUpi15w?=
 =?us-ascii?Q?CGfXP55tfmbXJwPROgTN579cXhj7XDnq8jfbaZPIT4awaGWUPG1hDyQ6ADU8?=
 =?us-ascii?Q?FE1jIA97MPu55aATz+DAvR5dzgmW8SJhusVx9eRJ2NSeS5LA6x6KesA0Kl26?=
 =?us-ascii?Q?PymP/6Gr7T2oyRU51pL3+jSmlhUnZpfRiibdT2nkD6H+iVVWsAPLdhd39xSl?=
 =?us-ascii?Q?btBNr6DQ93Wp+03SqQdlv4A46Li4xEnGyUS40UudimVJeMX+q4e32W+YmTq3?=
 =?us-ascii?Q?ChKrvb237JUVksCdVICtK/OJ4nVFtbaxSJEtFBT5?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mbXjP+DVeSz/A6ToYfBmiNno3Tof7YNlYcDYkThUIu4lvcUL7JRK44Hl5dpn7GsNKPdHbtfW8eoWfmxbQ7uHemVNENoNsRu0tdrh1qIMtz//EszPCXeScKubFslQ+esYj8EHXNzAG3DTQmLRKoDFr0xAu2f7Gz1k24udvgYQLHNMPBEDSobUdbjF7IAIm1g31Eqn3HfHDl23GgO7Pl+zyOSkP8UxmwqBhBHLQbLJjckzQfAjr1TXg4dNnVJlr6aaBjH75mi9z/5hf/bfCAZ7XvWtRDs9pDBu5S+UJKe//Ue4eix0ZV4gdDAYI6Hm5iIhTR9rU8HgdN9T+KFgTG3ewC8xkcHyPCOycI1dCWcoPSGmc+RHtN4G4BkbGNejdUq2T8mLne6/JqoaTKWMvTcp2tnfzuSBaV92HP9vYnyON9zGOpwrCEkxPyAAIF1/IAcLjohAyZ/SQb+dAD7GqUNJVPzz+sf72QTzCUpa+RsQRQi85lrvNG3/ZA6T0al1ItN3wTpdjLekkL/kTZoeHg4QRf6nOqqwOuVhSjqHdw4vARyVJgWEmEw+iBZesQ2VaLFLlkLrSUp/fBpO/d8ireAh69kU8Z3Zf/NU9Zr27e5qcBY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a6a8949-01bc-401f-6734-08dccfa4b50f
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7943.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2024 01:22:30.1754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Tr8ZZMWS02LyY+ZwrJNtY4fCXLxkG5bNtGdMJqsdiG5O0J9onl1zsR7yx3zuet4JOFm1zMhmkaPZ1dXVvGV+zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4721
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-07_13,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=787 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409080009
X-Proofpoint-ORIG-GUID: fRo2ZunFJ8YJxAiMGyrmrRqmRRiwmKNI
X-Proofpoint-GUID: fRo2ZunFJ8YJxAiMGyrmrRqmRRiwmKNI

* Andrii Nakryiko <andrii@kernel.org> [240906 01:12]:

...

> ---
>  kernel/events/uprobes.c | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index a2e6a57f79f2..b7e0baa83de1 100644
...

> @@ -2088,6 +2135,10 @@ static struct uprobe *find_active_uprobe_rcu(unsigned long bp_vaddr, int *is_swb

I'm having issues locating this function in akpm/mm-unstable.  What
tree/commits am I missing to do a full review of this code?

>  	struct uprobe *uprobe = NULL;
>  	struct vm_area_struct *vma;
>  
> +	uprobe = find_active_uprobe_speculative(bp_vaddr);
> +	if (uprobe)
> +		return uprobe;
> +
>  	mmap_read_lock(mm);
>  	vma = vma_lookup(mm, bp_vaddr);
>  	if (vma) {
> -- 
> 2.43.5
> 
> 


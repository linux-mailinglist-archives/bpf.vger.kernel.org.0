Return-Path: <bpf+bounces-27914-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 774FE8B33D3
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 11:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B6E42832D3
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 09:22:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55D2213DDD5;
	Fri, 26 Apr 2024 09:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LUVDK67F";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bj3ajRw0"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA2413D53D
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 09:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714123360; cv=fail; b=tsXUa0Plo3pjlEEQltkMyK61YUZW+1y7ICanmf9Xe2RTdcuh8WyXwwmWNuad/dCrjiialhPIGNPFvZVw4BP5gqvDHjqzRwJGE+XuOFSUQpSwRD7UDXJ6J04JVFo70lxOug/9U+mcyZmJquOB4q9q0w5Xr3nrPGSIkTnAMui1tGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714123360; c=relaxed/simple;
	bh=rOmkTuOtp8zUQrBGEhtnr1Oaa2niQObkqhYsdDjeOuo=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PBYVXG3EmxroBlprr0t/EoYaXaFZ3ThdYsGdRf4M1M/SJkvc89yklTvC2NSZX+4JBewzxu/X4THJNI0V1+myY3kl3XP2bNbjrD15kytWucm61NBYStXI4HLV1ijXrtRNAEgYuC7N3KRml5aytfuqZsWR9Ycemk60oEUeJZNVP+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LUVDK67F; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bj3ajRw0; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q8T7Cr000659;
	Fri, 26 Apr 2024 09:22:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=bdIRV563Hm/QZoJN2/MtQVqmT+/2mUzMx4NKeEsQAw8=;
 b=LUVDK67FvE7oDDh4kgIzh0ewICueZSOdrcgUfpf+5SabFgSXiQsro5neqXxOY5eidEVK
 YgrRolv/+bT5rlZWug7257AETtUt4n/9nr8/IT1wmwxmtnTgTBQugvypoPWawHn7vFmw
 ktoPwBOtb7gfOx2H1Z/VKQ2Yd4yi/l8+QKiCuaOEW1SkOKgl20f1KiaJjc6edl0vi5AJ
 w2BLiER4N83eCVLmw1KPQ+pU0Wgk7BEbNbqFVw1RkKjAULDiTTDMqOtVe7FU/ft2ydpd
 z4D04ciRosSYkqBGTjdW16kQBBWAnIAmmoy83DZ9zydk3oHwCGtpKEjxAV8reptt0yFU 2g== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm44f4vv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 09:22:33 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43Q9EImP006251;
	Fri, 26 Apr 2024 09:22:33 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2101.outbound.protection.outlook.com [104.47.58.101])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45bhcjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 09:22:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AO+nVChfXhaA/MVCt9TMQcrcgy5CkjNVN8o0HBKwRxTtAQG9+YxeNND77Wui7QFtfB9dobj/fY2okW9oqhjpaCNmVdJd3fBHumYS6N9o3xFA/pCJK4JOi4XKGfOQVkUsSuVdEHjh3QYTPZoY4NU117ri2b4xw2thvAFnThgV9xXW8SfS3RPD/CFChUc8lf5IJlQsx+G6RNbJQYJECSC+LBDA3qutusB6AwLufL6cwWCjKZXwe+O4dngSHiQsI69P0twMrUHFv/vuADPsXNZhutxcIWG36W6FfQe01oQ4sPXDddRinS+s+QFQf02vZ5ecKLiJBvKmnQdQqTiROR1AiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bdIRV563Hm/QZoJN2/MtQVqmT+/2mUzMx4NKeEsQAw8=;
 b=bsPtCczkGJUWdPjPBRni38OnNadq21niI7ykGcdK/o3swRLnMsI6TiAj+tnhTPG2/AlOotLStZoO6I9Iq/pSYcZpAAX/Y7EZtAsiW6f/t4bfZOPZbK33qSSVidTWgpsFQfBnxpdi7cOf363Vq9v9M7V0bg7u5j5K3slpi1jQIalBN1ZyLBh3AZrlJom1Noc3B88YYrncCth26ELxDdfIdPphphkfk0fyUfU4ofzGmJn0vvk+3TBtb3SDR0VEuTT4DZTcLAEtH8dxT4C1wlY6sd9bcp8s1PjR/22RrkP4pl4eGGvCjDLQxdxw4PIXGNkBIAS8rqIk2Gd6m9SW5K+fkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bdIRV563Hm/QZoJN2/MtQVqmT+/2mUzMx4NKeEsQAw8=;
 b=bj3ajRw0qqAr/3G+r9Q8mTR9j7nWLMQilSWkeeZvg9LkzjflzzRALputhO6z4eSqfr+lBLnMdx9kf/C9+xp1WIZH18nz3HRgrBudaKGkcl+yLe8BMwl/AvXMyqiEhgp2r4KtziArtxa3sfLjnKEmfPsEGo+VJ+6UjmAwkd/vl/w=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SJ0PR10MB5632.namprd10.prod.outlook.com (2603:10b6:a03:3df::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Fri, 26 Apr
 2024 09:22:30 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.030; Fri, 26 Apr 2024
 09:22:30 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com
Subject: [PATCH bpf-next] bpf: avoid casts from pointers to enums in bpf_tracing.h
Date: Fri, 26 Apr 2024 11:22:14 +0200
Message-Id: <20240426092214.16426-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0013.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::18) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SJ0PR10MB5632:EE_
X-MS-Office365-Filtering-Correlation-Id: dbb56c98-bc3a-4ed7-da78-08dc65d26553
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?mioJmn79WtHDRks7VnE6+fOaJ3os5P8krPRGSjL8add877Xa6jDh0Fdy6i2+?=
 =?us-ascii?Q?B7GJuH0kGRU4wGbxsDPqu8k7m90VO3ckKG8RsxjZRmlNrfjkjvuQBlZzNELC?=
 =?us-ascii?Q?gbpsIrZ/inb7mSClxqYfVKtFcGLnDNlUC+rnVJkK3aZyzKDI+4vxrFuxWeiP?=
 =?us-ascii?Q?qvx177WzWYgprhWGbFYdrzVi6b+oBZiwN+Rz4fghwPbyvCjsiuHwjQSzCT6h?=
 =?us-ascii?Q?4iYsokQ5QfKmfnWT901YXkq6UsEHrwb99ikmdLRphbZu483rR8ivqZVxXMyi?=
 =?us-ascii?Q?FHUU6p3OYTtS2bIqiIv4bZcKl1Ba73pNjiuU1NamL+3gW0+n6ZaU+gkqZPxD?=
 =?us-ascii?Q?fYz2o8O5jRzA5Bho/yPN9z13Gl7QdZbaHmeh8qH7hv8QK9usEmB/MtN2Rt9R?=
 =?us-ascii?Q?tZDB5yXn7F6+th6QFcxDA+iScrUQqbbKD/aZJ1bX1PgClEcVcLvuv9MOc8+J?=
 =?us-ascii?Q?Nw0pt9z2lmpFkiI6p6STQsqcZKIoBhMAt9JF+IGnE+gbQrS1XDe4G05vCnXK?=
 =?us-ascii?Q?VMuoA5pS80f/FqoWJLPVAujKGGIRnKcIiqk9KFQuIfbq0vA9wszu8y9e9yEr?=
 =?us-ascii?Q?NyX/kuztHYAjZFs2ZYffld7hGt1UuIVpEvvA6GKF5zOKpjvxdyxCzf7Xqmfm?=
 =?us-ascii?Q?Ysxfgo/EqUbzVI2WotEX7RpGvKbXw2+lzSwtqNEf+yowmjmUs1h0mADwTP4s?=
 =?us-ascii?Q?EkpRnEu77AfCSCST5QMhHDiXAAykcj9C2tx3J+gw1F735/nq6LvTKcGxjxCY?=
 =?us-ascii?Q?NGF8laafj6gadBhVgzAjZBapJ8uZt4+3zfLJU4r1+TgRshSbPFL+8oJkpibs?=
 =?us-ascii?Q?RSO9Bt4OMYP1FhlgjQd9c/5UqdOemWXTdq90ELOcABO4mj+DI0B0G/pE5Bun?=
 =?us-ascii?Q?B/I0I6WnO0N1aku9ZxSbKdToED0gNMfR6xB0POBwB+1a0wz8C8xFsuR97SGV?=
 =?us-ascii?Q?U/4ZdipdWO4MWxsxD/oFYzMJThiIrKocdFWGNY0o4KjZEbHzR+WvZHsFpgrv?=
 =?us-ascii?Q?j8yUuniEMZ65lHE+hT2EWVZ/adLcWpD9Gd0YXbK710ut86+Dgu9LTXn+K2Gx?=
 =?us-ascii?Q?1Pk6LP5VyYLwzl9NJlTjcFIc9bOaJq+bUpNZ/j7Qc+anDLMHPF+w+E94kCvh?=
 =?us-ascii?Q?Q90bszQETAG/Z4jTqFWk3bohHMH0i/Rt+aHDJBUdLeicC/4KF0y6KPnS1b3K?=
 =?us-ascii?Q?CQdirwKS8Dh+/aBlgu5pwwyBSIi9WFAg63IArXrc5BPf9pSE5cVn2lGNQOIF?=
 =?us-ascii?Q?6L1aINnNi06A408TGIQ5qVQ8ebkLAIN4PZfqwe3mWA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?bYIuDV1tPxdVq6JbABg+r+dJf7ljsc6apF6WkxR4H1VCi/vmfPnC0v3D7Mc8?=
 =?us-ascii?Q?T5GPPPAULi8GFEEn6UVa2INOZLGS+naR6M9chZJM4q/asiVa3TnKCp87Imrm?=
 =?us-ascii?Q?xRXeuL4TXIp6QflJQ+HUSTj3PwWnue4UCJJWjwbJSBZN6+0IrXb4dEMtfcQ5?=
 =?us-ascii?Q?N5+WEqldMd9YFCJnBS2HtBaeIKvH4/d6baIIrpedxdsBqyEvOaoUYxXDe472?=
 =?us-ascii?Q?NG8A9j4awWLt1wcrYEYvexlYSrf8El0Swpc7uFUbhsoe5V/xePwPelTu7W22?=
 =?us-ascii?Q?WOekYUwtm3ky3jFdAsfxp8vLrC/2gGibsXIu6A0GzkXOOjr4CxHzhqrgHKho?=
 =?us-ascii?Q?96qQJHqSA7LBX68jS9cW6GQFsLL1r5si18AwokuhMW5x9KThPcfQTBDPUc6/?=
 =?us-ascii?Q?FFOTmq9PgbxcHTLh3Eu2O+hmV2QacOPDHBYT62bAOkuvSgeY0Jglw+/crMEv?=
 =?us-ascii?Q?YmdUYcogxeRuVSmd9DF8eGD4li4+GS+AcKT6kUiyFpt042k5bg9nxF6TaD8o?=
 =?us-ascii?Q?GTaLkXcDPx8ky47B8r3Hz+ztpiaSNQHBNVxIi/2RwnAHBlX1XWfxKhZTfDLQ?=
 =?us-ascii?Q?/NuilcT4RFnkKxJkvTiGcfFu3TZRQ1oU9z10ZrtcNHgYpt5HAe+KUYKNTEW+?=
 =?us-ascii?Q?TWA8tscnazQYekbGSH/LcdDsUDVq5v+J/+sb+x4kvJeBsAD3aPbRnBnoczSs?=
 =?us-ascii?Q?GAb6mcliQKeYA7pCZ8FXf8UP7hmWkbb2lyJN0/d3Whn6xmhasDVfqo5UYq5Z?=
 =?us-ascii?Q?DpyavrTXzm7JWLAznv21tXZZlCPDWdG9eCWVlIh66hYOzWyTpLVP/lFiKmKe?=
 =?us-ascii?Q?RNNvgTg94xwkhy53Y6gX9yCBZaO/r9igVjZzkrOPsj0is+WQwyub+nc6bO9p?=
 =?us-ascii?Q?Nxr8RLLP40n4aGwKsNtsXb2+5y+d/yGXdyhQnUeuEKI+5ig0FnVjHNKZbgSN?=
 =?us-ascii?Q?RFs5Ung8XtGVHWaeLqscB/ezinJNQ5JNwosCgMpBelWEpcQHVVo6dthJlJSf?=
 =?us-ascii?Q?SyVVWkJ5/D4co2pNS4a2MyXeyn0wOEQsZYkDE3HRu2TbwEyjOQkmiUYh3sAK?=
 =?us-ascii?Q?MpuGeEBCvmCocDhRAcAGwE59Uq/Cqoimjtv5PcaBWY9Ar7s8bJjYN3TnCPmq?=
 =?us-ascii?Q?Q/CpkQ2wHLTxHKLCXc2cAxTLkbcsuXzxnMEtjKwAX7X5wAtSBZdCJTzV+/aP?=
 =?us-ascii?Q?kmCYUjiLJjiVAEmDUYTQDGEGbxXRFBkcQxnRZXXtDWEZ+yRpfwfce9ELF/AZ?=
 =?us-ascii?Q?hx7wCg4FRMlditCLpnOqQhLRJp0r3c/JtPvX3mcIbwMQA+dl2bJS9KIpH8Hi?=
 =?us-ascii?Q?UfQCix/8gik8q1AvF45QZv4Xi62sTySSNx4XSd/Usva+n78xZ519FNbWYmuF?=
 =?us-ascii?Q?S6dTyfyU77D1C1KGHy6+5PnzXf+ajbtQwRY59Ilo+m2rnhGCmNQLFEKSV/E+?=
 =?us-ascii?Q?pxO0G3X7sNm9Fcpqq3Ej2dF0nEXjgDh+AdtNkVI8zvs9S5gfiynGkLT5BluX?=
 =?us-ascii?Q?eGtbKBj7lYnQ6ot/xMWLudFUY2bZi/67Bw90UCno2tfu9lUhY79qwGuTbQPi?=
 =?us-ascii?Q?zlJJA2Uzz1HnxdzGqVIX4P5HJUhGx4S+K9X66UeWdEStXE/bz1JKl1NWLHvb?=
 =?us-ascii?Q?5Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	odhYFlG3WVF8NjrChELP7yM2L4G5PBZ4ZPTucpJ3bAX6AQM2GjFNzct4TS9mNZUq4e6IinaADPXXIcYiV5xkww6oXPrftUfr8uL+JBZavGYX6ESX+y5aM9umD3T0u3jjos7Ei1a4cfuMRM/O5g5rATpEPQ9bZWXVmC+cv0+7K0WE73COSQDSisOEy9Nojko6+yKRjnXKaSU17OjdJ5/GbuKlIxUcs8peA7OgdF5eqS4ZH1B7p2KMf8XEYjRWcBAVOZQNYpfTXRFWCTAghs1/GTsOoz2AjFJ1vXolU3wbYTpmEwfwoaYgpPt44bsoidBh7vl8bThgBFmmdocYtcFDp1i+lhDLoBuN2H4NynjbMAB3QpgrmOf+Q0gzQAeytBr/WA12n4cBK+nelQ8Zq6EoW59dg0MeEAiLGS9H2PryCZaJpDl+Ph9tEIEaG7SYuVfUDbzBQdawdRlFHg85IPBLSsM0aormiGzuAhhZQqs23vlWny+TaqOyoQSas6//qtuPIFpV3iLhA3kTEPR2fX7Q+MiSH5JvxN8I0aWDKvzrXZfqq5NcBdaRoO5I732lvhZMKWo5qGPtvYppiPt586UcFhhI0u8CpHE8D83Smf82bsE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dbb56c98-bc3a-4ed7-da78-08dc65d26553
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Apr 2024 09:22:29.9447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HEHJO+kSxKN+qnhbtdckS8rCjuKue/eWsxBXP9zFmcnVkbZOgn7FhUDFIuR4gbeUI5Lw8ZnUbG183ttU4AEDgL5JeyzRO+1HjcVbP3pBVoc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5632
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_09,2024-04-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404260060
X-Proofpoint-ORIG-GUID: -Esvzc6dhz3ODHWC7fbz0Vz90n2hEc3n
X-Proofpoint-GUID: -Esvzc6dhz3ODHWC7fbz0Vz90n2hEc3n

The BPF_PROG, BPF_KPROBE and BPF_KSYSCALL macros defined in
tools/lib/bpf/bpf_tracing.h use a clever hack in order to provide a
convenient way to define entry points for BPF programs as if they were
normal C functions that get typed actual arguments, instead of as
elements in a single "context" array argument.

For example, PPF_PROGS allows writing:

  SEC("struct_ops/cwnd_event")
  void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
  {
        bbr_cwnd_event(sk, event);
        dctcp_cwnd_event(sk, event);
        cubictcp_cwnd_event(sk, event);
  }

That expands into a pair of functions:

  void ____cwnd_event (unsigned long long *ctx, struct sock *sk, enum tcp_ca_event event)
  {
        bbr_cwnd_event(sk, event);
        dctcp_cwnd_event(sk, event);
        cubictcp_cwnd_event(sk, event);
  }

  void cwnd_event (unsigned long long *ctx)
  {
        _Pragma("GCC diagnostic push")
        _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")
        return ____cwnd_event(ctx, (void*)ctx[0], (void*)ctx[1]);
        _Pragma("GCC diagnostic pop")
  }

Note how the 64-bit unsigned integers in the incoming CTX get casted
to a void pointer, and then implicitly converted to whatever type of
the actual argument in the wrapped function.  In this case:

  Arg1: unsigned long long -> void * -> struct sock *
  Arg2: unsigned long long -> void * -> enum tcp_ca_event

The behavior of GCC and clang when facing such conversions differ:

  pointer -> pointer

    Allowed by the C standard.
    GCC: no warning nor error.
    clang: no warning nor error.

  pointer -> integer type

    [C standard says the result of this conversion is implementation
     defined, and it may lead to unaligned pointer etc.]

    GCC: error: integer from pointer without a cast [-Wint-conversion]
    clang: error: incompatible pointer to integer conversion [-Wint-conversion]

  pointer -> enumerated type

    GCC: error: incompatible types in assigment (*)
    clang: error: incompatible pointer to integer conversion [-Wint-conversion]

These macros work because converting pointers to pointers is allowed,
and converting pointers to integers also works provided a suitable
integer type even if it is implementation defined, much like casting a
pointer to uintptr_t is guaranteed to work by the C standard.  The
conversion errors emitted by both compilers by default are silenced by
the pragmas.

However, the GCC error marked with (*) above when assigning a pointer
to an enumerated value is not associated with the -Wint-conversion
warning, and it is not possible to turn it off.

This is preventing building the BPF kernel selftests with GCC.

This patch fixes this by avoiding intermediate casts to void*,
replaced with casts to `uintptr', which is an integer type capable of
safely store a BPF pointer, much like the standard uintptr_t.

Tested in bpf-next master.
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/lib/bpf/bpf_tracing.h | 80 ++++++++++++++++++++-----------------
 1 file changed, 43 insertions(+), 37 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 1c13f8e88833..1098505a89c7 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -4,6 +4,12 @@
 
 #include "bpf_helpers.h"
 
+/* The following integer unsigned type must be able to hold a pointer.
+   It is used in the macros below in order to avoid eventual casts
+   from pointers to enum values, since these are rejected by GCC.  */
+
+typedef unsigned long long uintptr;
+
 /* Scan the ARCH passed in from ARCH env variable (see Makefile) */
 #if defined(__TARGET_ARCH_x86)
 	#define bpf_target_x86
@@ -523,9 +529,9 @@ struct pt_regs;
 #else
 
 #define BPF_KPROBE_READ_RET_IP(ip, ctx)					    \
-	({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)PT_REGS_RET(ctx)); })
+	({ bpf_probe_read_kernel(&(ip), sizeof(ip), (uintptr)PT_REGS_RET(ctx)); })
 #define BPF_KRETPROBE_READ_RET_IP(ip, ctx)				    \
-	({ bpf_probe_read_kernel(&(ip), sizeof(ip), (void *)(PT_REGS_FP(ctx) + sizeof(ip))); })
+	({ bpf_probe_read_kernel(&(ip), sizeof(ip), (uintptr)(PT_REGS_FP(ctx) + sizeof(ip))); })
 
 #endif
 
@@ -633,18 +639,18 @@ struct pt_regs;
 #endif
 
 #define ___bpf_ctx_cast0()            ctx
-#define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[0]
-#define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)ctx[1]
-#define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
-#define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), (void *)ctx[3]
-#define ___bpf_ctx_cast5(x, args...)  ___bpf_ctx_cast4(args), (void *)ctx[4]
-#define ___bpf_ctx_cast6(x, args...)  ___bpf_ctx_cast5(args), (void *)ctx[5]
-#define ___bpf_ctx_cast7(x, args...)  ___bpf_ctx_cast6(args), (void *)ctx[6]
-#define ___bpf_ctx_cast8(x, args...)  ___bpf_ctx_cast7(args), (void *)ctx[7]
-#define ___bpf_ctx_cast9(x, args...)  ___bpf_ctx_cast8(args), (void *)ctx[8]
-#define ___bpf_ctx_cast10(x, args...) ___bpf_ctx_cast9(args), (void *)ctx[9]
-#define ___bpf_ctx_cast11(x, args...) ___bpf_ctx_cast10(args), (void *)ctx[10]
-#define ___bpf_ctx_cast12(x, args...) ___bpf_ctx_cast11(args), (void *)ctx[11]
+#define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (uintptr) ctx[0]
+#define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (uintptr) ctx[1]
+#define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (uintptr) ctx[2]
+#define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), (uintptr) ctx[3]
+#define ___bpf_ctx_cast5(x, args...)  ___bpf_ctx_cast4(args), (uintptr) ctx[4]
+#define ___bpf_ctx_cast6(x, args...)  ___bpf_ctx_cast5(args), (uintptr) ctx[5]
+#define ___bpf_ctx_cast7(x, args...)  ___bpf_ctx_cast6(args), (uintptr) ctx[6]
+#define ___bpf_ctx_cast8(x, args...)  ___bpf_ctx_cast7(args), (uintptr) ctx[7]
+#define ___bpf_ctx_cast9(x, args...)  ___bpf_ctx_cast8(args), (uintptr) ctx[8]
+#define ___bpf_ctx_cast10(x, args...) ___bpf_ctx_cast9(args), (uintptr) ctx[9]
+#define ___bpf_ctx_cast11(x, args...) ___bpf_ctx_cast10(args), (uintptr) ctx[10]
+#define ___bpf_ctx_cast12(x, args...) ___bpf_ctx_cast11(args), (uintptr) ctx[11]
 #define ___bpf_ctx_cast(args...)      ___bpf_apply(___bpf_ctx_cast, ___bpf_narg(args))(args)
 
 /*
@@ -786,14 +792,14 @@ ____##name(unsigned long long *ctx ___bpf_ctx_decl(args))
 struct pt_regs;
 
 #define ___bpf_kprobe_args0()           ctx
-#define ___bpf_kprobe_args1(x)          ___bpf_kprobe_args0(), (void *)PT_REGS_PARM1(ctx)
-#define ___bpf_kprobe_args2(x, args...) ___bpf_kprobe_args1(args), (void *)PT_REGS_PARM2(ctx)
-#define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args), (void *)PT_REGS_PARM3(ctx)
-#define ___bpf_kprobe_args4(x, args...) ___bpf_kprobe_args3(args), (void *)PT_REGS_PARM4(ctx)
-#define ___bpf_kprobe_args5(x, args...) ___bpf_kprobe_args4(args), (void *)PT_REGS_PARM5(ctx)
-#define ___bpf_kprobe_args6(x, args...) ___bpf_kprobe_args5(args), (void *)PT_REGS_PARM6(ctx)
-#define ___bpf_kprobe_args7(x, args...) ___bpf_kprobe_args6(args), (void *)PT_REGS_PARM7(ctx)
-#define ___bpf_kprobe_args8(x, args...) ___bpf_kprobe_args7(args), (void *)PT_REGS_PARM8(ctx)
+#define ___bpf_kprobe_args1(x)          ___bpf_kprobe_args0(), (uintptr)PT_REGS_PARM1(ctx)
+#define ___bpf_kprobe_args2(x, args...) ___bpf_kprobe_args1(args), (uintptr)PT_REGS_PARM2(ctx)
+#define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args), (uintptr)PT_REGS_PARM3(ctx)
+#define ___bpf_kprobe_args4(x, args...) ___bpf_kprobe_args3(args), (uintptr)PT_REGS_PARM4(ctx)
+#define ___bpf_kprobe_args5(x, args...) ___bpf_kprobe_args4(args), (uintptr)PT_REGS_PARM5(ctx)
+#define ___bpf_kprobe_args6(x, args...) ___bpf_kprobe_args5(args), (uintptr)PT_REGS_PARM6(ctx)
+#define ___bpf_kprobe_args7(x, args...) ___bpf_kprobe_args6(args), (uintptr)PT_REGS_PARM7(ctx)
+#define ___bpf_kprobe_args8(x, args...) ___bpf_kprobe_args7(args), (uintptr)PT_REGS_PARM8(ctx)
 #define ___bpf_kprobe_args(args...)     ___bpf_apply(___bpf_kprobe_args, ___bpf_narg(args))(args)
 
 /*
@@ -821,7 +827,7 @@ static __always_inline typeof(name(0))					    \
 ____##name(struct pt_regs *ctx, ##args)
 
 #define ___bpf_kretprobe_args0()       ctx
-#define ___bpf_kretprobe_args1(x)      ___bpf_kretprobe_args0(), (void *)PT_REGS_RC(ctx)
+#define ___bpf_kretprobe_args1(x)      ___bpf_kretprobe_args0(), (uintptr)PT_REGS_RC(ctx)
 #define ___bpf_kretprobe_args(args...) ___bpf_apply(___bpf_kretprobe_args, ___bpf_narg(args))(args)
 
 /*
@@ -845,24 +851,24 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 
 /* If kernel has CONFIG_ARCH_HAS_SYSCALL_WRAPPER, read pt_regs directly */
 #define ___bpf_syscall_args0()           ctx
-#define ___bpf_syscall_args1(x)          ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_SYSCALL(regs)
-#define ___bpf_syscall_args2(x, args...) ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_SYSCALL(regs)
-#define ___bpf_syscall_args3(x, args...) ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_SYSCALL(regs)
-#define ___bpf_syscall_args4(x, args...) ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_SYSCALL(regs)
-#define ___bpf_syscall_args5(x, args...) ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_SYSCALL(regs)
-#define ___bpf_syscall_args6(x, args...) ___bpf_syscall_args5(args), (void *)PT_REGS_PARM6_SYSCALL(regs)
-#define ___bpf_syscall_args7(x, args...) ___bpf_syscall_args6(args), (void *)PT_REGS_PARM7_SYSCALL(regs)
+#define ___bpf_syscall_args1(x)          ___bpf_syscall_args0(), (uintptr)PT_REGS_PARM1_SYSCALL(regs)
+#define ___bpf_syscall_args2(x, args...) ___bpf_syscall_args1(args), (uintptr)PT_REGS_PARM2_SYSCALL(regs)
+#define ___bpf_syscall_args3(x, args...) ___bpf_syscall_args2(args), (uintptr)PT_REGS_PARM3_SYSCALL(regs)
+#define ___bpf_syscall_args4(x, args...) ___bpf_syscall_args3(args), (uintptr)PT_REGS_PARM4_SYSCALL(regs)
+#define ___bpf_syscall_args5(x, args...) ___bpf_syscall_args4(args), (uintptr)PT_REGS_PARM5_SYSCALL(regs)
+#define ___bpf_syscall_args6(x, args...) ___bpf_syscall_args5(args), (uintptr)PT_REGS_PARM6_SYSCALL(regs)
+#define ___bpf_syscall_args7(x, args...) ___bpf_syscall_args6(args), (uintptr)PT_REGS_PARM7_SYSCALL(regs)
 #define ___bpf_syscall_args(args...)     ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
 
 /* If kernel doesn't have CONFIG_ARCH_HAS_SYSCALL_WRAPPER, we have to BPF_CORE_READ from pt_regs */
 #define ___bpf_syswrap_args0()           ctx
-#define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args3(x, args...) ___bpf_syswrap_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args4(x, args...) ___bpf_syswrap_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args5(x, args...) ___bpf_syswrap_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args6(x, args...) ___bpf_syswrap_args5(args), (void *)PT_REGS_PARM6_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args7(x, args...) ___bpf_syswrap_args6(args), (void *)PT_REGS_PARM7_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(), (uintptr)PT_REGS_PARM1_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args), (uintptr)PT_REGS_PARM2_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args3(x, args...) ___bpf_syswrap_args2(args), (uintptr)PT_REGS_PARM3_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args4(x, args...) ___bpf_syswrap_args3(args), (uintptr)PT_REGS_PARM4_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args5(x, args...) ___bpf_syswrap_args4(args), (uintptr)PT_REGS_PARM5_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args6(x, args...) ___bpf_syswrap_args5(args), (uintptr)PT_REGS_PARM6_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args7(x, args...) ___bpf_syswrap_args6(args), (uintptr)PT_REGS_PARM7_CORE_SYSCALL(regs)
 #define ___bpf_syswrap_args(args...)     ___bpf_apply(___bpf_syswrap_args, ___bpf_narg(args))(args)
 
 /*
-- 
2.30.2



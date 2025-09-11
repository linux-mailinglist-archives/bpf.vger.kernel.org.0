Return-Path: <bpf+bounces-68176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A62EEB53A6D
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 19:32:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2294C5A1D14
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 17:32:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9D235FC1D;
	Thu, 11 Sep 2025 17:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="dftgpKmw";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Zp5kfe+Q"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD0423D7EA;
	Thu, 11 Sep 2025 17:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757611911; cv=fail; b=d8O35sbafaPYZxav4magbuXOFbw6G576X7CkgPDQVrTWYZXka9hZlV8YjcDIGjurqcb2R7sc0vqwrqPwF+bqfBAsjCJKVCCkK2sCvL3WEfhqYyLOePdzm+iYH97buPr9q/Vc1fLWKVTRrDp2ZoMpH+tok2J0SQWaX6t2poRznaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757611911; c=relaxed/simple;
	bh=ig2BRjylQxxO3R8x2JEWqCqe7+wm/ZdOIsLOne2XAGk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=tEeGrWNyex3i5mvBinaYjtL8gxkevpoExl/qEVWh9sB/HG4cnDlupahrwwQAwQbiCnCpS0jnzMLZPRmBxVc97DTX19odC5LhyG7IFcylo+DzJQfKwPQQKcRWppNvnC7CeDXZuBvpsPko1Y4KpPHntRucH9aPDrOs7ch2+8AELeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=dftgpKmw; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Zp5kfe+Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BHBuSM007525;
	Thu, 11 Sep 2025 17:31:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=89wxt+uURpiQ6LwKPP
	eAUuOFb4G//4qr2By+fKtMpbM=; b=dftgpKmwY6udzzq/3hi7NRQwoOPdjgwcAb
	1EC9RbdFziIcaE9PSwYJQGqVk1ox0j5pFviBtb6jz32sdztedHLpQUtb5jO60irc
	R31yreyPvBSdC+rFaylEh4exkte68zTWTSgy8SI9OW9dzzE9z1no9j4GsuV5SWXa
	AL3bRPzd0rflK6BO4SHovmLFiBhB8Mjog9uEw7Jz7eOGvhAy4IAZ9dxKZCkQGGG0
	q4+LlLtVm9jLnwjSerYbJCnPsjCm7SAjpBd8x4rkUrHpT1jeC4aihJDO1A+t3Lfa
	bVeXV20ne0blYMtOO6KiTO6bGfL34NvQWfpNKLk2P53wAkX9aAyA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922x96qbc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:31:01 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BGupig030708;
	Thu, 11 Sep 2025 17:31:01 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcq1db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 17:31:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MUVucMIMoR2lY4yYXUlXr+q3rIiwqEuBcIJdtC6j/qyt2ZXxODgTEOEyTrdr1kIoPz+LO98LndeywNk/UBjPy1a8Qe5jeVsP6HrFCe8ku9a3zgRY4FgMt3BjCrbZf7aiYvR+Ha+dV+E5DVQY43J7XFOxGH9WUtc4jvW44A+ATFfaIS4kLs/jUvzrApD/3/efe1R08Pnc6W0mQvUuVVkkRZE35l5LysVWcdsqOzipsj9vfXh3dZyhhexFrLTi31lrUoSBexqKkQBEYyMzXvCRmO64Ah7MG0gOkXxNanRJzxDrmrtKgFCvrkTmCMmAGbwLtuSeGI7BP0roP5xggtviSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=89wxt+uURpiQ6LwKPPeAUuOFb4G//4qr2By+fKtMpbM=;
 b=qpwK3f+fBF9OJngAaJ6xJkh3mWsFqjdswhRYmwuwFTKnjYbii3NAp0yIWtbW29niEGMACWGjULxbpMtnGmMDj7mlZydbNwVGdayZ9xp/l6tOCwLe2qqqxShE+VNHn3bXhD3oJjqsUmtHnaB0b9EqG7Njh8T2KyEaA2QlDvqNt3O4C4D8BxxNfsY6MCZO3A1Bk5q/0kBDR95yEIxS63wynjW7+w8t13OQArXgVdFvXo0SEiwhD84tbgNa5SG9TARfyNBRZW0iaen3RSrbjOjAytQ3740uQr0tJR3sqEQ7aJzO/FMoGr+jybQGooaEFLbPddG2toVwk0HXU5x/rNVdjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=89wxt+uURpiQ6LwKPPeAUuOFb4G//4qr2By+fKtMpbM=;
 b=Zp5kfe+Q+o45GYPPdBfMs7h14DKO9iqgvDh++E+mkm4P9ioouIGQENtlboffU1f+UtBDhvPCjnZLjzFu+D8NlRbEUX+/1VY7sns3d0/R05oyu0zRF5HzccTjJJjNBdRyskn2cmdAdB4LduN7yal0yb3C5Kmq7feSoCW24nlzmUg=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by SA2PR10MB4778.namprd10.prod.outlook.com (2603:10b6:806:114::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 17:30:58 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 17:30:58 +0000
Date: Thu, 11 Sep 2025 13:30:52 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 06/10] bpf: mark vma->vm_mm as
 __safe_trusted_or_null
Message-ID: <mi5gf7wvm3hjnfm3gkrye5mpzcxlmfkzy55oqhaqdbsnnwxjfc@teia7omm3ujl>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, lorenzo.stoakes@oracle.com, npache@redhat.com, 
	ryan.roberts@arm.com, dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com, 
	gutierrez.asier@huawei-partners.com, willy@infradead.org, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net, 
	21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-7-laoar.shao@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910024447.64788-7-laoar.shao@gmail.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: MW4PR03CA0079.namprd03.prod.outlook.com
 (2603:10b6:303:b6::24) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|SA2PR10MB4778:EE_
X-MS-Office365-Filtering-Correlation-Id: a3f4df9e-4e13-42a3-794d-08ddf158f813
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?85AdgMSq+6J7KKtZeYbA5NZH0QECJlwFzsIx0tY4gHlBqp2lNHKIeD47i5Oq?=
 =?us-ascii?Q?EGTPVNcj9hi+vscAMkLVIxjW3caDPKrDdIkElDIvl4aT9ocxbGXS8VNcoCZS?=
 =?us-ascii?Q?K2PeY7jisZli3RqUj3OKlBSir9FmCf0UK3aKGQxd17ZTp13RP3+1N1mpR1+G?=
 =?us-ascii?Q?gqyhN1uCEcIWbEu8HIWGR28RTGCew38z0n+BmyrKU362cbja0iYCybD1RKSI?=
 =?us-ascii?Q?vItlV09Nq0AdABTZ8vDM0huFYGVrw18fxmkzKlXx/nuPbKLTR66VxL5l+nr2?=
 =?us-ascii?Q?4YBJgxRvN6MDCB77LiO0Vn6fOAEf2hXY4G3e3E/L8Y/9Ddzrnf7THl5NSon8?=
 =?us-ascii?Q?T2bqmogOrsc/4mZHluO0n668AfuMNHFS4eolWTUs4F+e3Yt4ikSkayK5I+05?=
 =?us-ascii?Q?qbijYWkGYF1LqwOeF8Hr6cBS5uO7ffOj9SxHb/EYchwNr2bK0lmLgHmSRP62?=
 =?us-ascii?Q?hRY9lpzl6S0xTSK3MoYaoA6fDVlh2DIf9YCrOmu9C3bgtF+mfv5evfAmnz0Z?=
 =?us-ascii?Q?PBFeLG3Tk9CuBBUf72oGZWR3Jdu4hQdrMcruvWCCLjCevtZKWGqRsWl7CORO?=
 =?us-ascii?Q?YRjox9v+CD+HJ5MnB9/MVp/Rti4IN26lyMaH7imotnzxrk69Gsv/4LnzwUka?=
 =?us-ascii?Q?mUZkCzaH7jE+88oiNDVhYmgx6sJJ+vLX4eVQ37ltRy111tIkQJt+voms5kAX?=
 =?us-ascii?Q?E/adLa0+VZylUxazmI/VtZ1OoyG8mVgRoztozThfVtBtCAZt0kkagCnjbjni?=
 =?us-ascii?Q?IlhorcD9Inv5aIKBlv7ASLiwVK0zze3XoUalGNnDFEtviGMsGc2LhJ6WjJXU?=
 =?us-ascii?Q?X+dSxXBLnYAzDjrhK8wc/EmdWUI/vDxrbyjQt5AU+Qr2izT6Lm9UFS5mNu2B?=
 =?us-ascii?Q?crjdobeQOjLwy6rVeBxM2LGdA2dVMFfczyD5HOT5V6OU1LQBoOc4xzHYJ4a/?=
 =?us-ascii?Q?wh/xGUpWkOEj9bJ4HAPTRo4r+UMjNQZ/QDDs2UQ9O0tTHsy7wFYxTBuP0l99?=
 =?us-ascii?Q?1BvmHvXlnCfsGrno5w5rq28/sd1CHnaYSRoLMYQ4xb3ruyvq4rKBPrIVbdWL?=
 =?us-ascii?Q?Uvxuv95c2Nr+F/aGdJxXMANtmmNuy/z2PJzfGgZ3k3ri5a9/LICweOxYw2Ip?=
 =?us-ascii?Q?nDk+kZPLtDYZTZg17MKtNURVOjF2NGkLHwsy2iTI8bOOHwJVAp8bqai4/h+1?=
 =?us-ascii?Q?wwACp0+eLv9a9qOFHBqy3Lqd6xRO3jXH3zRLUer1ikDTCLMg50p9klNcei/c?=
 =?us-ascii?Q?GtDkzr7eIeR11JqMIAxd70Asoqd/kyH4kWt5ev+JaNin0rBecaHwVBrtRXHv?=
 =?us-ascii?Q?LSVa02hrd6mT0GXlyV2zWAP29pGZxL+kV97VQ/oDSU51pNoLzhVYgSYJEGaA?=
 =?us-ascii?Q?97eDWvdaFpv5HvuoujGOfHE4lm4QeczchVsQ3NbatEon+rITjVKyId4aWx3v?=
 =?us-ascii?Q?dJCFsldLT9A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9GMuUh45r0z4PwxDuAz3B+G+qgUMiyGbpcoGHk4xOlOthTY0ybX0LE1TKvF+?=
 =?us-ascii?Q?ogUno79Dlo+nNYV0NyCRq2ArH74xrjLAJRirB6ioRZS/QHY4Pfq3pr3hGVI0?=
 =?us-ascii?Q?y0ElaW8wXrJup1IILfY1L0kHTdTInWpnPoY+0L54aDVlYCOM87ZfIQDeStCi?=
 =?us-ascii?Q?WMd3JASRUXUO9a7jo9MBZeCcg2Ig3rtr9BfbYhPsjQjMM8PRaFOsRXzmqfxB?=
 =?us-ascii?Q?6U/M/2y3H3PvTmjGh3rG+2xpUWhaOlSt9ukbgFARKta+4Y+yWjZpvju/3l4w?=
 =?us-ascii?Q?CjaeveZiWTeMZBoHGRGGjhc9Lob3c5AzM7mKfNAepzuHVHYqZwRfqBsHBBqb?=
 =?us-ascii?Q?GBs1Ikc0fTTohsHTbaG/AabCT5/EadCjbzZNAF8DrAwCv4QuUMn1Xdp2/NOe?=
 =?us-ascii?Q?wDIDZ9uDcn4AiC48CF7ZP46fCcRmS3NI9UbPeGEhkR5+loQIx3G6K73F4IVZ?=
 =?us-ascii?Q?CFvD9gHSFcc4eEfaRyfbhL70o7KBH0bW8J67GeVHdVK5XQ6H/E1xBqFtbDES?=
 =?us-ascii?Q?nWxYsulk05rQE9G1OpguP7O5n1E36uGb86T/SNjVcSqhjXfKHJ2/WD8l/0Wm?=
 =?us-ascii?Q?HJDZSNGkBViPtw/6BeN8orvpe/MsIRO3uHYUYp3w4y5TAM5ZyDkVhB1tU3bp?=
 =?us-ascii?Q?1ei8LOtQL2wTSlq+jAiOf40JADIG83TPbcvE2RjnurSnOtIeesq6u0f++Ywj?=
 =?us-ascii?Q?sjommRB0qUl0RsLkUuYICJC+WUu62qD5LF8mC2DEE95ap0ALslKGFOtJ3QlE?=
 =?us-ascii?Q?Z4XdSltn+MqLkVX2IuN8RAo3r3jjwpkMRw8a9+XaOz5QmEauvLnup4Mf2lsx?=
 =?us-ascii?Q?NU83bwBdIROAnSf3N3wGLNEO6xZDauJFGNED9pLETRW5Mq4tP7hFPuc9m4oY?=
 =?us-ascii?Q?7z57LTCfiAP+qT5xQm+Uk1hNfj8WqRhY07wBN4namcu/70AblEBaDSsqTyRL?=
 =?us-ascii?Q?WXg0WChEdrF0heC8dKraOazX0lLU5isJkQpCNc4kx5Y4yU6B49LBPsp677tb?=
 =?us-ascii?Q?oczONwW1QTdo5ovzUXuwbF5QUbxwef02BtewUq5OKkLTDKzmkmpGL/fLk0jt?=
 =?us-ascii?Q?l8jtGvN83HwcyfSCNxbBvqmDcP6wo+zv1BEe2HIVEgecgRLQQuwGpSXVgZsZ?=
 =?us-ascii?Q?dTpW5aVz339DgpGfbG1NR95GpRZn3NDA3XTKtH/xHv4Oejk4gmmbCT5ahEOS?=
 =?us-ascii?Q?JHPoXBl7vVQ58OlpTdHdeyHdCDpJedk231nPbrv49slf1KbGf2vU4JhMlq3N?=
 =?us-ascii?Q?t+BLvKTIYveExLrlBHBxfrv1HG2ZYi42QZPjGR4M3y7xj+OTWvBeYxz5EaVf?=
 =?us-ascii?Q?IkifN4h1Dan6OxnAVgZf9zWPddJfH2nZteLVvGxT8Xqb9mja6ZjXdcy46Vyr?=
 =?us-ascii?Q?tYLR+6msiai0AonUaSnySLN5eWF0PXIRrZeDk5OqMIWupMz09xjkHhdEzzX2?=
 =?us-ascii?Q?V+TCZZXO/Pu5ooaNtyGWVcl08RxjCIcpwWo2tvnL15w8NABuz71EGmFEycY1?=
 =?us-ascii?Q?zvVT8+Oz0/N/ECY4VWnsDQ/i/K+MXPGlF4AU6HTiN+39yP3rsCrdyaVc6JDi?=
 =?us-ascii?Q?VHoKF5v5BhqkN9m/7ZN7xGpyMeam3At9BPYLyrU6?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H5mrF0fTLoS5vGCfmCgyr2KSBI99F7qlAhlOJrInIpsksCTPr9u4xw1iySfbtmauTX6WZF+Wbn++RtODS0cGzeEd+WGJ+UquPWsVF+bgNCLvAMMq/lTjq6nMPB+KMWc9TH+THlxJv7/CqzT8yy+Ax8CKZH4vfPkUbnH+RK1D+7LzWfVgqU/1cgBIe1eBWoHu/hriYgM2JKgu7lmew1KIOrhnIxUmy80TITyFEy3kuIb7XlCD8cvGi9Cckn2QsvM128Mr62ihLKHzte4N6SHrFgoWqEXmHdVtKHM/ZYZ6BXTnElvjX3dgXo80JqEDHOqvNPSlwQQ27ue42CJcAXXuxfcjfeKlgGBALsD48zysjB5G2G68QVKevUVn9d/EssyVGHhzOeYbxSCfSwN4jnkGQn7PfuyZa0f6mJr4rqKK46E6twnMOHsAPgGNJEpA08EQD4c30lqOCk2dx1RJcQ+ZZTzw3WC1oznDwiGuWv0faMCmt0BfyoU5WpKw6IZ/HKYV4tAwhmXyU6cgmyTVyRgzLDDaF9xMSlhHxoilI1P8i0v39FvByypu9sCtZfP8T/xIQMmVIDfgCmkEU2ZH3/6GzKsKrStT5HNYwLdWU7ZAFno=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a3f4df9e-4e13-42a3-794d-08ddf158f813
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 17:30:58.0253
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ3wm/a4WhJltKeS1Y1iG1TgYZ7lVCuxXQGC7dBM/jL2UdWHJDi66plGgYU3NyLr4c6XtNb4NYGKNpUgAfuXKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR10MB4778
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_02,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509110156
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NiBTYWx0ZWRfXy2irEEQXJNAj
 iCDgGVUOIIKdU/qN9DOeuTs1HRZ7KNVTvfhp4Fiju7III8WRQfa9st2v73WbYhy0Kuj0jKsss/M
 AgKur5X/uux7ZWuIrz5LIlXOopBDPqtaqjbMDVPb/qY0i94lJSa3FZc0XrlS7sCM9tMhOJLkrCR
 3OxQNZAnuq79clq5J6kdV6ukxh1cOstnu8wxypFhwwhXXkrmFFZuwR2/zJqrtONzKGvqUaKPFF1
 pOsUzlMl0ueldvFl1uTcB7vExdLqTOrzU9M4gXKWZw0ZnZNXv6WjkTimnK7AraeWp76cAdEl4si
 nzNyxia2TxQpOwHl54U/EVSU8IEDh54n7UrX1unCAoQcgm1LBGAzoTKqPpYYuIAKP9AH4KxJP9s
 yAsveuIh
X-Proofpoint-GUID: ejjJdhFicw5NM0LhJfXz209oTq_F0VKw
X-Proofpoint-ORIG-GUID: ejjJdhFicw5NM0LhJfXz209oTq_F0VKw
X-Authority-Analysis: v=2.4 cv=LYY86ifi c=1 sm=1 tr=0 ts=68c30755 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=3TQlhlAqneZRTSxkRO4A:9 a=CjuIK1q_8ugA:10

* Yafang Shao <laoar.shao@gmail.com> [250909 22:46]:
> The vma->vm_mm might be NULL and it can be accessed outside of RCU. Thus,
> we can mark it as trusted_or_null. With this change, BPF helpers can safely
> access vma->vm_mm to retrieve the associated mm_struct from the VMA.
> Then we can make policy decision from the VMA.

I don't agree with any of that statement.

How are you getting a vma outside an rcu lock safely?

vmas are RCU type safe so I don't think you can make the statement of
null or trusted.  You can get a vma that has moved to another mm if you
are not careful.

What am I missing?  Surely there is more context to add to this commit
message.

> 
> The lsm selftest must be modified because it directly accesses vma->vm_mm
> without a NULL pointer check; otherwise it will break due to this
> change.
> 
> For the VMA based THP policy, the use case is as follows,
> 
>   @mm = @vma->vm_mm; // vm_area_struct::vm_mm is trusted or null
>   if (!@mm)
>       return;
>   bpf_rcu_read_lock(); // rcu lock must be held to dereference the owner
>   @owner = @mm->owner; // mm_struct::owner is rcu trusted or null
>   if (!@owner)
>     goto out;
>   @cgroup1 = bpf_task_get_cgroup1(@owner, MEMCG_HIERARCHY_ID);
> 
>   /* make the decision based on the @cgroup1 attribute */
> 
>   bpf_cgroup_release(@cgroup1); // release the associated cgroup
> out:
>   bpf_rcu_read_unlock();
> 
> PSI memory information can be obtained from the associated cgroup to inform
> policy decisions. Since upstream PSI support is currently limited to cgroup
> v2, the following example demonstrates cgroup v2 implementation:
> 
>   @owner = @mm->owner;
>   if (@owner) {
>       // @ancestor_cgid is user-configured
>       @ancestor = bpf_cgroup_from_id(@ancestor_cgid);
>       if (bpf_task_under_cgroup(@owner, @ancestor)) {
>           @psi_group = @ancestor->psi;
> 
>         /* Extract PSI metrics from @psi_group and
>          * implement policy logic based on the values
>          */
> 
>       }
>   }
> 
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> ---
>  kernel/bpf/verifier.c                   | 5 +++++
>  tools/testing/selftests/bpf/progs/lsm.c | 8 +++++---
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index d400e18ee31e..b708b98f796c 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7165,6 +7165,10 @@ BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket) {
>  	struct sock *sk;
>  };
>  
> +BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct) {
> +	struct mm_struct *vm_mm;
> +};
> +
>  static bool type_is_rcu(struct bpf_verifier_env *env,
>  			struct bpf_reg_state *reg,
>  			const char *field_name, u32 btf_id)
> @@ -7206,6 +7210,7 @@ static bool type_is_trusted_or_null(struct bpf_verifier_env *env,
>  {
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct socket));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct vm_area_struct));
>  
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id,
>  					  "__safe_trusted_or_null");
> diff --git a/tools/testing/selftests/bpf/progs/lsm.c b/tools/testing/selftests/bpf/progs/lsm.c
> index 0c13b7409947..7de173daf27b 100644
> --- a/tools/testing/selftests/bpf/progs/lsm.c
> +++ b/tools/testing/selftests/bpf/progs/lsm.c
> @@ -89,14 +89,16 @@ SEC("lsm/file_mprotect")
>  int BPF_PROG(test_int_hook, struct vm_area_struct *vma,
>  	     unsigned long reqprot, unsigned long prot, int ret)
>  {
> -	if (ret != 0)
> +	struct mm_struct *mm = vma->vm_mm;
> +
> +	if (ret != 0 || !mm)
>  		return ret;
>  
>  	__s32 pid = bpf_get_current_pid_tgid() >> 32;
>  	int is_stack = 0;
>  
> -	is_stack = (vma->vm_start <= vma->vm_mm->start_stack &&
> -		    vma->vm_end >= vma->vm_mm->start_stack);
> +	is_stack = (vma->vm_start <= mm->start_stack &&
> +		    vma->vm_end >= mm->start_stack);
>  
>  	if (is_stack && monitored_pid == pid) {
>  		mprotect_count++;
> -- 
> 2.47.3
> 
> 


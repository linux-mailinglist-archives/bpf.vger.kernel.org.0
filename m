Return-Path: <bpf+bounces-66670-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B10B385B4
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 958373A5DFE
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 585E6271444;
	Wed, 27 Aug 2025 15:04:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KuNN6oWX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="spYiBJsw"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE6526F477;
	Wed, 27 Aug 2025 15:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756307092; cv=fail; b=CJ9ORLVKVYH/kV7PhYHSblcPvC+ZoZF3PcDgYknKPtG5dglFsdY6pcINrCD6hcBONSyLVdVrJlMdaWQFxDX22keCyCUy1brIIV6oAoliB12/MAFziq9Gxs7kUjL+h67GQsA86IB9uyanH1TkOo8NZfla8vuEvoHSDlwaqPgPASc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756307092; c=relaxed/simple;
	bh=G7lgFAAebtlpxe6ZHCgGFDkC9yjv9JfXI0hIK15mZVc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DFFcloAD1tDAr6eNZD44Gy8dK8q05Wsm1bv1t8y92xYb8h7UXsde+XDd27hQeGMn6hy7GwNiGpqlTWjV37KpjHCrdu1VpXA+CKHUS39NE8i/+hYZgFfo5qo211LZ2qGjbbIj58ik/kWKI2gHoJ8wcDtPz8RUWgwE3xaNYx4A1R4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KuNN6oWX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=spYiBJsw; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7u5sA016072;
	Wed, 27 Aug 2025 15:03:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=xynlENpdUa5HEq8NJa
	UMs1qzX4v9np4B8arRmvp5Kdc=; b=KuNN6oWXQausW9SWCFEd4eflo6+xJONw1h
	p9uZwINsiUaAxnxETliu3DL9ETj5IqNL2FmThytnUNJ9BJTunU4AYQkK2K89qF60
	FmQZySU74lJhwNi0nLFxXigDvcp0TGiVHgholxeT2vOxrEyz6CxF/XhOxO5VsNXR
	YeuV0mU4NLXNc1Hc4NJYU/joQ8BrB38XkcrOSAp8u9uVSfnhSo6mj+3tDGVLzInw
	lfDW5Na+6s737xmcixHflRqy6WhnWOhiPC+rDhPl69pC+7sKN4vqGPwnLB1Z7fWe
	Z449Z8FF0CS2a6f3c8ffLB/01IBzd0N9UHMQDy0pI3mAxhoGayjg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4japnhx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:03:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RDwaoX014593;
	Wed, 27 Aug 2025 15:03:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04on2043.outbound.protection.outlook.com [40.107.102.43])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43arr0q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:03:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZqpaY8P6q+1k1lJoCHrMnaZi1ydsv4MoQHSQiGc4OkN3pPRA7kAIv4zSGcuZvIikdC4adc+BeH2687GXhqIb3WoLFGIJsSccfODfu05HE6J0mzV05l9cPyR0WGt2CKkRDtEiJCFmExTf2b40+uJQhigmaDr4JDqQ67vx6hAKJnESd7ZFY5+jxybkoIqmjH3Vvp0QVTXOzYh2kMNh6wBofZP6WMPxViIEdW1OdzfZ7iLN/vlXBWFEktx8YsTE9TEIunIvpPkMy+uRQH6WHhvxtT7dy07ceF3fA9AjSvhFHVamr0EkHoa4Y10WY56HM182OKo+lCnNfoEEMYANQdgqBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xynlENpdUa5HEq8NJaUMs1qzX4v9np4B8arRmvp5Kdc=;
 b=AfuFbGYKBN0c/X6IvVY7ITgMhmB876eH7qItdF7sBr09tQjET4/dN/0VIDTetG+S2sUoBrVgXSc/Gg28+bsUJOewpj9eoXi4D4MDyQLsdqf2RwITc3zWqDXwKVJ+xPlryI/aNPiNAvuymd1aFiB81w+2GJyaJJdMFQiZRS60RQ0+bicJLHcXhbIirBC0TgMZWHddKjVLQg4/fVKg4R6l7Sphwf/P84b0jfksisY9NsVRPUEmBRzaj0UmhFghZkKSCxZE7VgCCKJ4nhJSzXnaCXiPVjmJ371do+exLRl7cgEg3DC99jlVBbsRG9+Uyfv6dp+dFclgsoyTwNdgZmwhYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xynlENpdUa5HEq8NJaUMs1qzX4v9np4B8arRmvp5Kdc=;
 b=spYiBJsw/FTwPKDciMC59aSGCm1Q47Qx67nEGoYchVuZRzeTXxSy9h2AhKAOWtkPLwMgo3DbehPqlWFhrRYSNAPpFxgyfNuIygGA0eDku/DM8xw//FnbYQMc/K3SHfo3bzmQTPn7w86rVhavPq3EDV/rCSAWnyPadb+rjBlfjOY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB5900.namprd10.prod.outlook.com (2603:10b6:208:3d4::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Wed, 27 Aug
 2025 15:03:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 15:03:23 +0000
Date: Wed, 27 Aug 2025 16:03:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v6 mm-new 01/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <f1bc20e0-9d39-4294-8f70-f51315a534d8@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826071948.2618-2-laoar.shao@gmail.com>
X-ClientProxiedBy: LO3P123CA0026.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::6) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: ce71711a-4e25-429d-e692-08dde57ade07
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TRK4O9XUZo3oQL7ASu68Cw0Dfawr7tKMy6qnoqqaV05ZuEDtL+Z15qH3VfER?=
 =?us-ascii?Q?05sOc0SB4mxrCIKsbvdtaZSoFpUNAn6xJ7ijbfO3MhM2BB+wZhgQlNRDbhzP?=
 =?us-ascii?Q?nZGt/NEybcAQU1YINnF9yrmMnXDF5TS8Sv4e6jvWkNMdCGvALwE1epxNwhoX?=
 =?us-ascii?Q?MOOSqvFZ/wPiMDtihFKFQLb57FakZCqX+y6l93VaHrUQcTuNqaHTyZt65sSA?=
 =?us-ascii?Q?0UqSv9y1eA6I6hJeqEGm9w0Fc2iQ8bN53ENfUASSJtXjX8vh7I5dbWcBQhrD?=
 =?us-ascii?Q?kK8IHlHQb0LAx8JoJ2fc87DlwhUqYqHYyj/78CucTj8YS1d7U2eNnyVR5d1b?=
 =?us-ascii?Q?n2rGU+nHH6XBF5gxyAqw6bRyMMyLuSMJ7SI72Fx7hg1TBUXl2pZoc2DwNblP?=
 =?us-ascii?Q?z5GiGfVC9hFXFhttgo5MVIDDqIkK7UH+S69tsGVnUfZtJCn8UaoQJcFamzN+?=
 =?us-ascii?Q?HAjm+RmNNUp+PnHte24cF/TJ0V8cxp4b4LzJCTqIPiODLt6Z/PFlI14mYjPr?=
 =?us-ascii?Q?/Di68aPjUAugtyeFYXIXpWEe5TtgEh7DgBBoiV69vuXDnOX24aYY5EavubaZ?=
 =?us-ascii?Q?lBxR+zp0+ptemNCKwFUZx2CO6xhUMkgg4mnPdFBJzLHBTQgyGCNL3aigeX8I?=
 =?us-ascii?Q?lnKZbHVkVHqJgTTKpFJ4BVDZYSjqrNC/VcI1EakKJzwoUz5UlAWfhd9EdTit?=
 =?us-ascii?Q?38aeLrTDFfcPDnfnrsurMSAMh9KzZvi8Xh6nw77kIgE5KQ7mDlI7C1qMhe1W?=
 =?us-ascii?Q?Z4WnFuYGDQAtysnBQkThTyBu1aDh2qq+EoGDdkYDeACiR5gUI37LDlEwl6Oq?=
 =?us-ascii?Q?PHTPQqfWXeDexmLOVaGcnzFLak+zTjMgV2Wj14z9ujJq/CKsVL9ejztXxcsb?=
 =?us-ascii?Q?cnTYCwrmxsNyfCcngPPCu3HYap1swAdllWDABTucTqKbUDowZq+VSTJyFtvB?=
 =?us-ascii?Q?7ZcfiMKWYGZHDds0b9m4zsvqeoYGz6Yd3lTHbJ9ltjGuIEwKGoBUXLvAYAhL?=
 =?us-ascii?Q?F5v27A2CnmnpYrCq/8qW8SNpvTzqyq3C2OJhDwxwbtopCRv0aiDO805BQ05Q?=
 =?us-ascii?Q?u+bf4hiKrIg+RHPJ+JGwJo+ZQROWmBW8ctsq1Qt9QggH/HMdIFtZxkp3qrOP?=
 =?us-ascii?Q?MKNiHK+zGhfAcCBTNNvNE/gHKSfPTbGMvzptMVmTUx2VIyN9/IjzlHET90Ig?=
 =?us-ascii?Q?GpZzAX+tlwqY2Ry1W7Wqm5wQP8yjl2EW3fwBm9gz+d+M9SEcHRGOLkuREPIH?=
 =?us-ascii?Q?92D5y4aJnpYaiAkyVxCtsyEiR8R9qIULRZ231bONAq+cHOKvjpUm/CCarEvI?=
 =?us-ascii?Q?ccBu5Nwj0kepdUXVMjRZGPC3queeNGXoBrZU51v/nRTq1uyimXeo2wE+1yo+?=
 =?us-ascii?Q?dT3AZUs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rHUxXUSfjoJwkC8uBFoOfORQSZPvPE/+rRqVLUlyqIoNi9XJ5mAbMm1/V2Gz?=
 =?us-ascii?Q?ZE3vTd8l7qG7pXGvawhNq3lJXYGRCYAlATSyImXudY4TsNK0GfauY66gelRw?=
 =?us-ascii?Q?G8YfI/9kZNISNdj+E/2B+ZVFJ5DLZ9NQAhTIVa0KeHBn5NY5CoBzD3439HOk?=
 =?us-ascii?Q?lkGQiuRz7FyASm3oxL4Kp25rXi7DAu90Ohy8WPw0+2QDCfAiPPZ9Gdn/qUAD?=
 =?us-ascii?Q?ikwXfizxTJHySE98pMUv1VsmrImDUXtoSruy+tY+dNjxezvNXahV91smtzln?=
 =?us-ascii?Q?zwXlP0gDGox1xvnbQ5apeIz/O6dEVwVz42zWnOV/1Rnh8bpaOPhW4xV2OAC3?=
 =?us-ascii?Q?+f9nWWLiNOdrpjLn8hsOiNaRfklHF/PKgJt5YPfWiwx8Qp+wsstRHkAfV7TF?=
 =?us-ascii?Q?6N0t/EvJ1O7yCbbeL1x8tph/V3S7sk6ZStGwYd2zOWT0bbyG9kBqmPQPAWYv?=
 =?us-ascii?Q?yHo7n9n/BPMtavvNNEFIPQJKwrIpBsDaip2tHTKlhYcsLm57tmqDnVaIhfR6?=
 =?us-ascii?Q?DYwF3z7kb5BR9fZZhFc8dHQTiQOcsrGHpPph/WN36EmedRXdxvli9q5cM3u5?=
 =?us-ascii?Q?wih7YO5nSKLXxClfVA+30T5fpeL/aCGncLoHsc2CGjGJx3T/eszjqtNKtsFX?=
 =?us-ascii?Q?FzhTnT5NXCZNq6hXmcBbMV42a6xZQVuwNSqvJTEGSpMC2wbr1gmL8GO1bKBY?=
 =?us-ascii?Q?2MBMnjQrav7rxyFUQDWlMiCje0sDgfE0NTVjE6k/zxVnGUjGw37VtNudX5Wc?=
 =?us-ascii?Q?S+TNLkYf30ayr6eojxHnd0HxWni4vUDseHChrDknI3kZhHeCEfG09Yc7YFKx?=
 =?us-ascii?Q?U4MSEiwHIs9B27bb2qTuxY+3hmQkF0q2DqSVd2WQmfZhsnIohIk4qKaN/+N6?=
 =?us-ascii?Q?k643GtNvM/b4XH1eb/LW5IR2NyTPAq76n6EyiIuJL+JCdxhNhWX3WVNondXu?=
 =?us-ascii?Q?kyt78w0zpRg2qjY/+z6HPOeHkUWJjJgVLaggeyd1My5Z4R5mOPKnkkIM0s7r?=
 =?us-ascii?Q?GZfGZ51v0lyPn3dbTn/41avreSHmT9Uaft06S76w354QY6KmhJF+ga8yDdc+?=
 =?us-ascii?Q?WI0vigYrh/JKFNHEEWbCg4uA3qr11oJeK87VJTB4wEljK0rjJsp9lVN+BiR3?=
 =?us-ascii?Q?ctpMfy/jIDJ38Q71N4lG7vJ3kJvJuZLDtf8LhuocOFfmONIecWQ97xw0f7Pg?=
 =?us-ascii?Q?72jcsuCM/eZkRX7lnYyRmC+DB3ckqPkGq2e1EvgxdnNqAzSs/is822qWh7WJ?=
 =?us-ascii?Q?XwbR4/H5/8UeL3J4tSz7zNVu9pmK3/DifNRvBc0CgqqDU+7Upngcd2virO4y?=
 =?us-ascii?Q?A6g95t3lh6OeUX13UCTZkt2SyjrD9v1mKBNtyIvOyM050Ie40qvhwV1jC769?=
 =?us-ascii?Q?DBymIXqAUiPc4CuMvUFtJz2LlXJ5b2nMAomX1JBZDA7p0k/ze/wfq5HgIid2?=
 =?us-ascii?Q?2YWoHX6uKmyePpumgwGf4eJEcAdpm942mFcY++CIwOZQvp3SBN1ktR1BR6tM?=
 =?us-ascii?Q?lx67H7l6Oby4FC8M6uO4H4eXzrAcMFaDnBgNEpFKoM3rue/flbwg02taSuit?=
 =?us-ascii?Q?F6V+75DyY8u6W4Nm6QwggCtj+DVs9QjCUbIneOiYkd/pkuGjYISnWbckRR56?=
 =?us-ascii?Q?Uw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9Ue52RVm4KTAizPNvQ84JLpcNjRVNn0vALcvQZXdyOFMUa8xuZaEwg2BfW9q37dwDGMiMIL1veYB5glxUoyGg6aGJFA1lMjSE9xxITgPjgqq5NSgtjTwJ9rz+EWE8cyVcZdhl1/bEE5ANVG83xUL2ms+Pcsvoi2mTGuSBIcPaXsP6lFNuCWx7WOFSWuKZLqmwxAaVEevbVjofqVQDZSSdQ/keOnrZNwwYlAJWGLxdVDw9adsjvWz1h5by6wZ/BliijgQl5vZ5OZl7SQu1LMjLLUSOFHIhq8by5wckcXd8rICqB4Gog0eadDRdox96SO+OSaI0guX0iMECNu3uDouII8vQhiP8TwBO1Xk3gP4/3HhL4Y8iFlzwRKPeETnr3t+xrHgQVa46kbt1R22fHMmvnVUbBkirm9za4e/f46Ben21w1skq0JCXHzW1J2+bUkOPouz94UcFVvGclKYm8aoBMeUKndGMH5oQScqIqadyi7Uesph91MB2JyJxqOdQ8wOC70o2yu2Ly662e40GlPCggWhITHqVewGytqDUCf2/Fqb9mt6wGBcNlrC5cNP3xH/WTuqQc7mJilx0ai9sy2gzNxdTobFM5GCQdzge/KACdE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce71711a-4e25-429d-e692-08dde57ade07
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:03:23.2056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /MrjW60zd+6Dxg5vhF9MYKw1+5N7G7ChsUhwC+0IoFNeSjVHDbBNLhNLiT2Ga3wcs/TqOkGZSHLApPIczPGF/poWMSf5Duy08QVTNj350PA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5900
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 bulkscore=0 phishscore=0 adultscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508270129
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX9D4zbtFx1Y+N
 +i+r0AN1Yyt+xRcsHy6NJL4iTcMPf3ewJCLzBSOL8c9cSOaQIqCL8Peb8caR1w88C4SVi4pFwWA
 DydDaBsXaBZzMewIkVE3vHJTUgm2w5O/e3eALRoHgKmpTDqarfrFf11/2iE9FJiHvJ+I+8gH3tF
 D9jb7pEcdimajJeQySvwTCd6fdz8pX2ifAEmP3atyCU2ves3p9f/Mm/PXhUSJVcrD4jjKHl86fq
 J8e4o2ut+/CNTBXQ+GzhDB0I7eHwMQXnPsX7bEz1OUADC3tDykYOrx3X32n+h/kqJpCLiKJSs0Q
 bv924g+DJ0HdaJs9mVgowvgivcZ/XHj4mbiuwHr2tLBrUq8hDskM+k/BBUQXjZ0Gx/tUL0FsU7E
 C7Kr6S7fQkl92cVLvcdYtYWA30Qv+w==
X-Proofpoint-GUID: --k0iKwmGxTQyeSC38Z7zXJwvXmyr2cV
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68af1e58 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=07d9gI8wAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=pGLkceISAAAA:8 a=wE4MjZHKL1TtWxADok0A:9 a=CjuIK1q_8ugA:10
 a=e2CUPOnPG4QKp8I52DXD:22 cc=ntf awl=host:13602
X-Proofpoint-ORIG-GUID: --k0iKwmGxTQyeSC38Z7zXJwvXmyr2cV

On Tue, Aug 26, 2025 at 03:19:39PM +0800, Yafang Shao wrote:
> This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
> THP tuning. It includes a hook get_suggested_order() [0], allowing BPF
> programs to influence THP order selection based on factors such as:
> - Workload identity
>   For example, workloads running in specific containers or cgroups.
> - Allocation context
>   Whether the allocation occurs during a page fault, khugepaged, or other
>   paths.
> - System memory pressure
>   (May require new BPF helpers to accurately assess memory pressure.)
>
> Key Details:
> - Only one BPF program can be attached at a time, but it can be updated
>   dynamically to adjust the policy.
> - Supports automatic mTHP order selection and per-workload THP policies.
> - Only functional when THP is set to madise or always.
>
> It requires CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION to enable. [1]
> This feature is unstable and may evolve in future kernel versions.
>
> Link: https://lwn.net/ml/all/9bc57721-5287-416c-aa30-46932d605f63@redhat.com/ [0]
> Link: https://lwn.net/ml/all/dda67ea5-2943-497c-a8e5-d81f0733047d@lucifer.local/ [1]
>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  include/linux/huge_mm.h    |  15 +++
>  include/linux/khugepaged.h |  12 ++-
>  mm/Kconfig                 |  12 +++
>  mm/Makefile                |   1 +
>  mm/bpf_thp.c               | 186 +++++++++++++++++++++++++++++++++++++

Please add new files to MAINTAINERS as you add them.

>  mm/huge_memory.c           |  10 ++
>  mm/khugepaged.c            |  26 +++++-
>  mm/memory.c                |  18 +++-
>  8 files changed, 273 insertions(+), 7 deletions(-)
>  create mode 100644 mm/bpf_thp.c
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 1ac0d06fb3c1..f0c91d7bd267 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -6,6 +6,8 @@
>
>  #include <linux/fs.h> /* only for vma_is_dax() */
>  #include <linux/kobject.h>
> +#include <linux/pgtable.h>
> +#include <linux/mm.h>

Hm this is a bit weird as mm.h includes huge_mm... I guess it will be handled by
header defines but still.

>
>  vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf);
>  int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
> @@ -56,6 +58,7 @@ enum transparent_hugepage_flag {
>  	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
>  	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
>  	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> +	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached */
>  };
>
>  struct kobject;
> @@ -195,6 +198,18 @@ static inline bool hugepage_global_always(void)
>  			(1<<TRANSPARENT_HUGEPAGE_FLAG);
>  }
>
> +#ifdef CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION
> +int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> +			u64 vma_flags, enum tva_type tva_flags, int orders);

Not a massive fan of this naming to be honest. I think it should explicitly
reference bpf, e.g. bpf_hook_thp_get_order() or something.

Right now this is super unclear as to what it's for.

Also wrt vma_flags - this type is wrong :) it's vm_flags_t and going to change
to a bitmap of unlimiiteeed size soon. So probs best not to pass around as value
type either.

But unclear us to purpose as mentioned elsewhere.

And also get_suggested_order() should be get_suggested_orderS() no? As you
seem later in the code to be referencing a bitfield?

Also will mm ever != vma->vm_mm?

Are we hacking this for the sake of overloading what this does?

Also if we're returning a bitmask of orders which you seem to be (not sure I
like that tbh - I feel like we shoudl simply provide one order but open for
disucssion) - shouldn't it return an unsigned long?

> +#else
> +static inline int
> +get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> +		    u64 vma_flags, enum tva_type tva_flags, int orders)
> +{
> +	return orders;
> +}
> +#endif
> +
>  static inline int highest_order(unsigned long orders)
>  {
>  	return fls_long(orders) - 1;
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index eb1946a70cff..d81c1228a21f 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -4,6 +4,8 @@
>
>  #include <linux/mm.h>
>
> +#include <linux/huge_mm.h>
> +

Hm this is iffy too, There's probably a reason we didn't include this before,
the headers can be so so fragile. Let's be cautious...

>  extern unsigned int khugepaged_max_ptes_none __read_mostly;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  extern struct attribute_group khugepaged_attr_group;
> @@ -22,7 +24,15 @@ extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>
>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
> -	if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm))
> +	/*
> +	 * THP allocation policy can be dynamically modified via BPF. Even if a
> +	 * task was allowed to allocate THPs, BPF can decide whether its forked
> +	 * child can allocate THPs.
> +	 *
> +	 * The MMF_VM_HUGEPAGE flag will be cleared by khugepaged.
> +	 */
> +	if (mm_flags_test(MMF_VM_HUGEPAGE, oldmm) &&
> +		get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))

Hmmm so there seems to be some kind of additional functionality you're providing
here kinda quietly, which is to allow the exact same interface to determine
whether we kick off khugepaged or not.

Don't love that, I think we should be hugely specific about that.

This bpf interface should literally be 'ok we're deciding what order we
want'. It feels like a bit of a gross overloading?

>  		__khugepaged_enter(mm);
>  }
>
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 4108bcd96784..d10089e3f181 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -924,6 +924,18 @@ config NO_PAGE_MAPCOUNT
>
>  	  EXPERIMENTAL because the impact of some changes is still unclear.
>
> +config EXPERIMENTAL_BPF_ORDER_SELECTION
> +	bool "BPF-based THP order selection (EXPERIMENTAL)"
> +	depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> +
> +	help
> +	  Enable dynamic THP order selection using BPF programs. This
> +	  experimental feature allows custom BPF logic to determine optimal
> +	  transparent hugepage allocation sizes at runtime.
> +
> +	  Warning: This feature is unstable and may change in future kernel
> +	  versions.

Thanks! This is important to document. Absolute nitty nit: can you capitalise
'WARNING'? Thanks!

> +
>  endif # TRANSPARENT_HUGEPAGE
>
>  # simple helper to make the code a bit easier to read
> diff --git a/mm/Makefile b/mm/Makefile
> index ef54aa615d9d..cb55d1509be1 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
>  obj-$(CONFIG_NUMA) += memory-tiers.o
>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> +obj-$(CONFIG_EXPERIMENTAL_BPF_ORDER_SELECTION) += bpf_thp.o
>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>  obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
>  obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
> diff --git a/mm/bpf_thp.c b/mm/bpf_thp.c
> new file mode 100644
> index 000000000000..fbff3b1bb988
> --- /dev/null
> +++ b/mm/bpf_thp.c

As mentioned before, please update MAINTAINERS for new files. I went to great +
painful lengths to get everything listed there so let's keep it that way please
:P

> @@ -0,0 +1,186 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/huge_mm.h>
> +#include <linux/khugepaged.h>
> +
> +struct bpf_thp_ops {
> +	/**
> +	 * @get_suggested_order: Get the suggested THP orders for allocation
> +	 * @mm: mm_struct associated with the THP allocation
> +	 * @vma__nullable: vm_area_struct associated with the THP allocation (may be NULL)
> +	 *                 When NULL, the decision should be based on @mm (i.e., when
> +	 *                 triggered from an mm-scope hook rather than a VMA-specific
> +	 *                 context).
> +	 *                 Must belong to @mm (guaranteed by the caller).
> +	 * @vma_flags: use these vm_flags instead of @vma->vm_flags (0 if @vma is NULL)
> +	 * @tva_flags: TVA flags for current @vma (-1 if @vma is NULL)
> +	 * @orders: Bitmask of requested THP orders for this allocation
> +	 *          - PMD-mapped allocation if PMD_ORDER is set
> +	 *          - mTHP allocation otherwise
> +	 *
> +	 * Rerurn: Bitmask of suggested THP orders for allocation. The highest
> +	 *         suggested order will not exceed the highest requested order
> +	 *         in @orders.
> +	 */
> +	int (*get_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> +				   u64 vma_flags, enum tva_type tva_flags, int orders) __rcu;

I feel like we should be declaring this function pointer type somewhere else as
we're now duplicating this in two places.

> +};
> +
> +static struct bpf_thp_ops bpf_thp;
> +static DEFINE_SPINLOCK(thp_ops_lock);
> +
> +int get_suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> +			u64 vma_flags, enum tva_type tva_flags, int orders)

surely tva_flag? As this is an enum value?

> +{
> +	int (*bpf_suggested_order)(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> +				   u64 vma_flags, enum tva_type tva_flags, int orders);

This type for vma flags is totally incorrect. vm_flags_t. And that's going to
change soon to an opaque type.

Also right now it's actually an unsigned long.

I really really do not like that we're providing extra, unexplained VMA flags
for some reason. I may be missing something :) so happy to hear why this is
necessary.

However in future we really shouldn't be passing something like this.

Also - now a third duplication of the same function pointer :) can we do better
than this? At least typedef it.

> +	int suggested_orders = orders;
> +
> +	/* No BPF program is attached */
> +	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +		      &transparent_hugepage_flags))
> +		return suggested_orders;

This is atomic ofc, but are we concerned about races, or I guess you expect only
the first attached bpf program to work with it I suppose.

> +
> +	rcu_read_lock();

Is this sufficient? Anything stopping the mm or VMA going away here?

> +	bpf_suggested_order = rcu_dereference(bpf_thp.get_suggested_order);
> +	if (!bpf_suggested_order)
> +		goto out;
> +
> +	suggested_orders = bpf_suggested_order(mm, vma__nullable, vma_flags, tva_flags, orders);

OK so now it's suggested order_S but we're invoking suggested order :) whaaatt?
:)

> +	if (highest_order(suggested_orders) > highest_order(orders))
> +		suggested_orders = orders;

Hmmm so the semantics are - whichever is the highest order wins?

I thought the idea was we'd hand control over to bpf if provided in effect?

Definitely worth going over these semantics in the cover letter (and do forgive
me if you have and I've missed! :)

> +
> +out:
> +	rcu_read_unlock();
> +	return suggested_orders;
> +}
> +
> +static bool bpf_thp_ops_is_valid_access(int off, int size,
> +					enum bpf_access_type type,
> +					const struct bpf_prog *prog,
> +					struct bpf_insn_access_aux *info)
> +{
> +	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
> +}
> +
> +static const struct bpf_func_proto *
> +bpf_thp_get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
> +{
> +	return bpf_base_func_proto(func_id, prog);
> +}
> +
> +static const struct bpf_verifier_ops thp_bpf_verifier_ops = {
> +	.get_func_proto = bpf_thp_get_func_proto,
> +	.is_valid_access = bpf_thp_ops_is_valid_access,
> +};
> +
> +static int bpf_thp_init(struct btf *btf)
> +{
> +	return 0;
> +}
> +
> +static int bpf_thp_init_member(const struct btf_type *t,
> +			       const struct btf_member *member,
> +			       void *kdata, const void *udata)
> +{
> +	return 0;
> +}
> +
> +static int bpf_thp_reg(void *kdata, struct bpf_link *link)
> +{
> +	struct bpf_thp_ops *ops = kdata;
> +
> +	spin_lock(&thp_ops_lock);
> +	if (test_and_set_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +			     &transparent_hugepage_flags)) {
> +		spin_unlock(&thp_ops_lock);
> +		return -EBUSY;
> +	}
> +	WARN_ON_ONCE(rcu_access_pointer(bpf_thp.get_suggested_order));
> +	rcu_assign_pointer(bpf_thp.get_suggested_order, ops->get_suggested_order);
> +	spin_unlock(&thp_ops_lock);
> +	return 0;
> +}
> +
> +static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
> +{
> +	spin_lock(&thp_ops_lock);
> +	clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags);
> +	WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order));
> +	rcu_replace_pointer(bpf_thp.get_suggested_order, NULL, lockdep_is_held(&thp_ops_lock));
> +	spin_unlock(&thp_ops_lock);
> +
> +	synchronize_rcu();
> +}

I am a total beginner with BPF implementations so don't feel like I can say much
intelligent about the above. But presumably fairly standard fare BPF-wise?

Will perhaps try to dig deeper on another iteration :) as intersting to me.

> +
> +static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
> +{
> +	struct bpf_thp_ops *ops = kdata;
> +	struct bpf_thp_ops *old = old_kdata;
> +	int ret = 0;
> +
> +	if (!ops || !old)
> +		return -EINVAL;
> +
> +	spin_lock(&thp_ops_lock);
> +	/* The prog has aleady been removed. */
> +	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags)) {
> +		ret = -ENOENT;
> +		goto out;
> +	}

OK so we gate things on this flag and it's global, got it.

I see this is a hook, and I guess RCU-all-the-things is what BPF does which
makes tonnes of sense.

> +	WARN_ON_ONCE(!rcu_access_pointer(bpf_thp.get_suggested_order));
> +	rcu_replace_pointer(bpf_thp.get_suggested_order, ops->get_suggested_order,
> +			    lockdep_is_held(&thp_ops_lock));
> +
> +out:
> +	spin_unlock(&thp_ops_lock);
> +	if (!ret)
> +		synchronize_rcu();
> +	return ret;
> +}
> +
> +static int bpf_thp_validate(void *kdata)
> +{
> +	struct bpf_thp_ops *ops = kdata;
> +
> +	if (!ops->get_suggested_order) {
> +		pr_err("bpf_thp: required ops isn't implemented\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int suggested_order(struct mm_struct *mm, struct vm_area_struct *vma__nullable,
> +			   u64 vma_flags, enum tva_type vm_flags, int orders)
> +{
> +	return orders;
> +}
> +
> +static struct bpf_thp_ops __bpf_thp_ops = {
> +	.get_suggested_order = suggested_order,
> +};

Can you explain to me what this stub stuff is for? This is more 'BPF impl 101'
stuff sorry :)

> +
> +static struct bpf_struct_ops bpf_bpf_thp_ops = {
> +	.verifier_ops = &thp_bpf_verifier_ops,
> +	.init = bpf_thp_init,
> +	.init_member = bpf_thp_init_member,
> +	.reg = bpf_thp_reg,
> +	.unreg = bpf_thp_unreg,
> +	.update = bpf_thp_update,
> +	.validate = bpf_thp_validate,
> +	.cfi_stubs = &__bpf_thp_ops,
> +	.owner = THIS_MODULE,
> +	.name = "bpf_thp_ops",
> +};
> +
> +static int __init bpf_thp_ops_init(void)
> +{
> +	int err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
> +
> +	if (err)
> +		pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
> +	return err;
> +}
> +late_initcall(bpf_thp_ops_init);
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index d89992b65acc..bd8f8f34ab3c 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1349,6 +1349,16 @@ vm_fault_t do_huge_pmd_anonymous_page(struct vm_fault *vmf)
>  		return ret;
>  	khugepaged_enter_vma(vma, vma->vm_flags);
>
> +	/*
> +	 * This check must occur after khugepaged_enter_vma() because:
> +	 * 1. We may permit THP allocation via khugepaged
> +	 * 2. While simultaneously disallowing THP allocation
> +	 *    during page fault handling
> +	 */
> +	if (get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_PAGEFAULT, BIT(PMD_ORDER)) !=
> +				BIT(PMD_ORDER))

Hmmm so you return a bitmask of orders, but then you only allow this fault if
the only order provided is PMD order? That seems strange. Can you explain?

> +		return VM_FAULT_FALLBACK;

It'd be good to have a helper function for this like:

	if (!bpf_hook_allow_pmd_order(vma, tva_flag))
		return VM_FAULT_FALLBACK;

And implemented like maybe:

static bool bpf_hook_allow_pmd_order(struct vm_area_struct *vma, enum tva_type tva_flag)
{
	int orders = get_suggested_order(vma->vm_mm, vma, vma->vm_flags, tva_flag,
			BIT(PMD_ORDER));

	return orders & BIT(PMD_ORDER);
}

It's good the tva flag gives context though.

> +
>  	if (!(vmf->flags & FAULT_FLAG_WRITE) &&
>  			!mm_forbids_zeropage(vma->vm_mm) &&
>  			transparent_hugepage_use_zero_page()) {
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index d3d4f116e14b..935583626db6 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -474,7 +474,9 @@ void khugepaged_enter_vma(struct vm_area_struct *vma,
>  {
>  	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>  	    hugepage_pmd_enabled()) {
> -		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
> +		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER) &&
> +		    get_suggested_order(vma->vm_mm, vma, vm_flags, TVA_KHUGEPAGED,
> +					BIT(PMD_ORDER)))

I don't know why we aren't working the bpf hook into thp_vma_allowable_order()?

Also a helper would work here.

>  			__khugepaged_enter(vma->vm_mm);
>  	}
>  }
> @@ -934,6 +936,8 @@ static int hugepage_vma_revalidate(struct mm_struct *mm, unsigned long address,
>  		return SCAN_ADDRESS_RANGE;
>  	if (!thp_vma_allowable_order(vma, vma->vm_flags, type, PMD_ORDER))
>  		return SCAN_VMA_CHECK;
> +	if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, type, BIT(PMD_ORDER)))
> +		return SCAN_VMA_CHECK;



>  	/*
>  	 * Anon VMA expected, the address may be unmapped then
>  	 * remapped to file after khugepaged reaquired the mmap_lock.
> @@ -1465,6 +1469,11 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>  		/* khugepaged_mm_lock actually not necessary for the below */
>  		mm_slot_free(mm_slot_cache, mm_slot);
>  		mmdrop(mm);
> +	} else if (!get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER))) {
> +		hash_del(&slot->hash);
> +		list_del(&slot->mm_node);
> +		mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> +		mm_slot_free(mm_slot_cache, mm_slot);
>  	}
>  }
>
> @@ -1538,6 +1547,9 @@ int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
>  		return SCAN_VMA_CHECK;
>
> +	if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_FORCED_COLLAPSE,
> +				 BIT(PMD_ORDER)))

Again, can we please not duplicate thp_vma_allowable_order() logic?

The THP code is horrible enough, but now we have to remember to also do the bpf
check?

> +		return SCAN_VMA_CHECK;
>  	/* Keep pmd pgtable for uffd-wp; see comment in retract_page_tables() */
>  	if (userfaultfd_wp(vma))
>  		return SCAN_PTE_UFFD_WP;
> @@ -2416,6 +2428,10 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  	 * the next mm on the list.
>  	 */
>  	vma = NULL;
> +
> +	/* If this mm is not suitable for the scan list, we should remove it. */
> +	if (!get_suggested_order(mm, NULL, 0, -1, BIT(PMD_ORDER)))
> +		goto breakouterloop_mmap_lock;

OK again I'm really not loving this NULL, 0, -1 stuff. What is this supposed to
mean? The idea here is we have a hook for 'trying to determine THP order' and
now it's overloaded it seems in multiple ways?

I may be missing context here.

I'm also a bit perplexed by the comment as to what is intended here.

>  	if (unlikely(!mmap_read_trylock(mm)))
>  		goto breakouterloop_mmap_lock;
>
> @@ -2432,7 +2448,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  			progress++;
>  			break;
>  		}
> -		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER)) {
> +		if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_KHUGEPAGED, PMD_ORDER) ||
> +		    !get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_KHUGEPAGED,
> +					 BIT(PMD_ORDER))) {

Same various comments from above.

>  skip:
>  			progress++;
>  			continue;
> @@ -2769,6 +2787,10 @@ int madvise_collapse(struct vm_area_struct *vma, unsigned long start,
>  	if (!thp_vma_allowable_order(vma, vma->vm_flags, TVA_FORCED_COLLAPSE, PMD_ORDER))
>  		return -EINVAL;
>
> +	if (!get_suggested_order(vma->vm_mm, vma, vma->vm_flags, TVA_FORCED_COLLAPSE,
> +				 BIT(PMD_ORDER)))
> +		return -EINVAL;
> +

Same various comments from above.

>  	cc = kmalloc(sizeof(*cc), GFP_KERNEL);
>  	if (!cc)
>  		return -ENOMEM;
> diff --git a/mm/memory.c b/mm/memory.c
> index d9de6c056179..0178857aa058 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4486,6 +4486,7 @@ static inline unsigned long thp_swap_suitable_orders(pgoff_t swp_offset,
>  static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
> +	int order, suggested_orders;
>  	unsigned long orders;
>  	struct folio *folio;
>  	unsigned long addr;
> @@ -4493,7 +4494,6 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  	spinlock_t *ptl;
>  	pte_t *pte;
>  	gfp_t gfp;
> -	int order;
>
>  	/*
>  	 * If uffd is active for the vma we need per-page fault fidelity to
> @@ -4510,13 +4510,18 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  	if (!zswap_never_enabled())
>  		goto fallback;
>
> +	suggested_orders = get_suggested_order(vma->vm_mm, vma, vma->vm_flags,
> +					       TVA_PAGEFAULT,
> +					       BIT(PMD_ORDER) - 1);
> +	if (!suggested_orders)
> +		goto fallback;

Wait, but below we have a bunch of fallbacks, now BPF overrides everything?

I know I'm repaeting myself :P but can we just please put this into
thp_vma_allowable_orders(), it's massively gross to just duplicate this check
_everywhere_ with subtle differences.

>  	entry = pte_to_swp_entry(vmf->orig_pte);
>  	/*
>  	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
>  	 * and suitable for swapping THP.
>  	 */
>  	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
> -					  BIT(PMD_ORDER) - 1);
> +					  suggested_orders);
>  	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>  	orders = thp_swap_suitable_orders(swp_offset(entry),
>  					  vmf->address, orders);
> @@ -5044,12 +5049,12 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  {
>  	struct vm_area_struct *vma = vmf->vma;
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> +	int order, suggested_orders;
>  	unsigned long orders;
>  	struct folio *folio;
>  	unsigned long addr;
>  	pte_t *pte;
>  	gfp_t gfp;
> -	int order;
>
>  	/*
>  	 * If uffd is active for the vma we need per-page fault fidelity to
> @@ -5058,13 +5063,18 @@ static struct folio *alloc_anon_folio(struct vm_fault *vmf)
>  	if (unlikely(userfaultfd_armed(vma)))
>  		goto fallback;
>
> +	suggested_orders = get_suggested_order(vma->vm_mm, vma, vma->vm_flags,
> +					       TVA_PAGEFAULT,
> +					       BIT(PMD_ORDER) - 1);
> +	if (!suggested_orders)
> +		goto fallback;

Same comment as above.

>  	/*
>  	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
>  	 * for this vma. Then filter out the orders that can't be allocated over
>  	 * the faulting address and still be fully contained in the vma.
>  	 */
>  	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
> -					  BIT(PMD_ORDER) - 1);
> +					  suggested_orders);
>  	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>
>  	if (!orders)
> --
> 2.47.3
>


Return-Path: <bpf+bounces-68142-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B42B536BA
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:59:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B42FAA6942
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 14:59:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0123C3277A9;
	Thu, 11 Sep 2025 14:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KQ4BjkqV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="q1SOkyTj"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5ABD3469E3;
	Thu, 11 Sep 2025 14:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757602664; cv=fail; b=VTAJzIyCsx7EfVn7fKMI44y0is/UDyZP2fLtJFWg6/66nt2mgO22UfY7jM9ngMdOIB9xlFIWS9sz3tVC/LrB+9zevOMe3vxv6YFWVCvSby3smyfImg1h2NtZYIIQOl8+WHprns93ap8LkwbdsYOpY5D6oMx1xZDnpplsakiysqI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757602664; c=relaxed/simple;
	bh=qnm2XukKOIOG8GBOw7i71K3Z8UFvuZm7DdXxOKyVegM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hEw66bKcQ+tO1O9urb3oJs0Z80gJNrBIrBoE5KCuPGG9uqPU0UoOXlmSDxdT15xiBh4BI8cCSiqznjLJ5+dZnUPRJ6pMdIhoCEnX/+qIvtUQzNqXFu+gI58IrAdHaIXhONe81jCLBrVjh4y7LBPi+LUJSMkeq8qhEPQAtS/sPkA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KQ4BjkqV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=q1SOkyTj; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDtjb2011867;
	Thu, 11 Sep 2025 14:56:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=xd+yHOe+qBG5VNlmLZd0cLgzA/Ep2npg5+fHd8XxstI=; b=
	KQ4BjkqVcN2/ppTf2lYDySfryC+2yoqdKQf8HaOWA1Re4j9Dzkk8/2nJBkiX9cLP
	gXyrX76N3x6zzpSc9UU7py4NwIvuRiqcVY94En2bMea3O136MrZQggNGxooCNxZT
	XnxcOaLI5Fyhx407zgDZmSQSj2eqqAI2n7geRA9gXKGJk6wLOAuk1pCvsLKzywfJ
	XQUcvnYyCDgI5iQc9aURkv/7Vv2oemjXSKfc8HOdlmAajH6qZLvF9j/50gU2pA6q
	FmAYbVpLscCSWCLTbx+xmJvhjUThgDGOc39+Zw9DCT+y6KHjG6MBu7Cf6VQcCGeC
	gm98rZPSwgnnMuYHPapiwA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226sxfdv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:56:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BEhRZE002823;
	Thu, 11 Sep 2025 14:56:01 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013067.outbound.protection.outlook.com [40.93.196.67])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdk37ju-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:56:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tUfzf2IXnZgFo2HpBPmWXLnJfFRPZJxduHkSbkva7x159aXLimxNoAAOqIfGEckILH+nxH5sI33L+ydhB1G7kPBYjBg5wl23/0/HljX6dGczkwmiTp6J9vNknz/FLBMbaZwJfC1/DNzBC5iLfZUK8U6kuiGiz3g6CEHyzrjZ0l5Thgi+NbADlI+bp8G3YB3psg+RdqDXL6Gw1XYJzACDeBLpUIPgAVnQjeoEkusZStD7bnnQg3QGWpc5Jj1XUs7mq4anisSYvkQyNteffVtnRf1qowhl6oJ9nucuryHq69mQMRNtvGvrgIt7k4+gGmDTo21MpbzYC7lHPiWrSzbJTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xd+yHOe+qBG5VNlmLZd0cLgzA/Ep2npg5+fHd8XxstI=;
 b=MWasyNI4DYmZVLc1rojjWt2qWFSM3C6ZolHrwUkEQVrr+R72h3TyIlg4C6zeAmcIUqhbg0m0JpC0KXHLEHsq49sy3W3ANEehQ782zWrRAs608U0DQDDFf9cx2JoiG+Z0tVlCwFXaT2t+ynnsPttxbtsDX5ps4QLI57BG56wvhYhCQ5M/pZxSn8rTZUjmQDJEN3DHoLH+JDod7bR+28tKERF3ylTkaEc0wAA44sCH2pLy1TOqpTgjYsigPuf/45fsSflCH+sYePhVNFsFYPiZt5D4YvoVD/pPDcf2P/5e52NFktjpq62xs4GnEvsWPGkvDmAUldT5jV1WgggDD8S8dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xd+yHOe+qBG5VNlmLZd0cLgzA/Ep2npg5+fHd8XxstI=;
 b=q1SOkyTjQ/iCALa5DEkj/rVZ+RMVRAgjwiTqLzahT4hd+3ZGfIaO2zDbnWeJ0mEC8uCCl4Jc9EWJGyY3NXT1ylS64QZ3pIKBWBXs8fh8lY7hJMiOEroUd9IEzl50GX/CEPi5+4Jd99kbIDEcm2/hPcnlJsxaSDMUZcUQuK67OaQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7260.namprd10.prod.outlook.com (2603:10b6:610:12e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:55:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:55:56 +0000
Date: Thu, 11 Sep 2025 15:55:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: akpm@linux-foundation.org, david@redhat.com, ziy@nvidia.com,
        baolin.wang@linux.alibaba.com, Liam.Howlett@oracle.com,
        npache@redhat.com, ryan.roberts@arm.com, dev.jain@arm.com,
        hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 03/10] mm: thp: decouple THP allocation between
 swap and page fault paths
Message-ID: <0aad915f-80b1-4c2f-adcd-4b4afe5b17dc@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-4-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910024447.64788-4-laoar.shao@gmail.com>
X-ClientProxiedBy: LO4P123CA0454.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7260:EE_
X-MS-Office365-Filtering-Correlation-Id: e2bb3231-6ec5-42d4-91df-08ddf143500c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|7416014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWY2WEp6cTgwOURCYmF2N1FUZkFNRHI4MWZOZnM3MmFmWVZycmpjUm5LOWdX?=
 =?utf-8?B?OWsxNEtIVHhCQ1hNcWhwWktVbHhEWjl1MThDS01hQVNJSVduMHBnQ0pjNDZE?=
 =?utf-8?B?bENNNTBqVHJNYnFjditFZlBuTTZKZDg0WVByZk9qaEVlWno1ZXFrWlphVWts?=
 =?utf-8?B?c0ZiNTI4QjE1N1AxUjNOcGJNaG1LN1M5MThtL3IrMENlbnByaUloQnA2VWhJ?=
 =?utf-8?B?empiNFJCa1ZXdkdGUWM5Z1BxR0w1M1JLK2ZSQURrUERuMldxR3hPVEw3NWIy?=
 =?utf-8?B?K0xOeWV3alhRblYzd1l1VUlkQlpRMEM5ZHNsdSt5V1k2clR5bmpGV2lkVndo?=
 =?utf-8?B?UnZGdFlpMFFNbm1vdmtkVmg0MWNMY01xV1VPYUNDbWtlZE54V01wcUUzRS9Z?=
 =?utf-8?B?OHd5UlJoWHFFRHAvVDF4OWtIY2ltMnZkekpUY0ZndXQ5NFlYdDhKd3h4dE13?=
 =?utf-8?B?b1NFVEttMzMvT1BjVHRWbzBHM2dvWE1vOEtEaHdQNlpJa3V4MWtZU1ZvVmVo?=
 =?utf-8?B?SzNwMnRSWlVPVGcrMGJBNXg4Z29wVFZ3TmdQRitQaXV2RVY2emtRaHk4RElz?=
 =?utf-8?B?MjhLSFpxS1Jra2loZVp3a2NQK1hXT3plaXdVSzIyZEJTQmVoWGtoTmJSYXJw?=
 =?utf-8?B?c1pnVGpjK0V1bTlHVzROSDg2ZVd3WEM5S3VMUEZYMHNwN3lUaHF6ZDQ1MDF4?=
 =?utf-8?B?c2tZL2ZDVUVnSFBWcHYxai95VjlpaXNJNkhzQnJmWnUyTE5XeGp2WFZFdjl1?=
 =?utf-8?B?bUhCaThWMkZENUZudnhvSVFsR294Y1lSVDY0R3ZLS2xaUWNvMHpSMHRpODRh?=
 =?utf-8?B?QmxNaUdJMXh6cFBIdFNiMlZKZGRxcUFZQW5CSFVrRnBLMnZOQlZCeTZSWWdV?=
 =?utf-8?B?MFUyTnJjMnZJWEtWMFdtZG1yMGwrWnA3MTcxTTJ6NHB3YnlwRnFuNEJ5NjJr?=
 =?utf-8?B?YVdaZC82VnhMZU43MU9UUXRNYzdjU2dKWWlReEZMQVFDMFEzb2N5NXdHR3pr?=
 =?utf-8?B?V0dHMThOWGlLbUFBSEk2NnlIK3AxMytyQW5mWTluREwwWXdwNkRHOTRhU0Ey?=
 =?utf-8?B?b2d4VE40UXN6UWJLa3VzcDB0Y1NKTDF0MVdObjlVb0RPUTBhTFFzRzJ3Wm9w?=
 =?utf-8?B?MlhFZ1g5M0ZiQkZreDdiSHBvZkpua2xYQUhYQmRkNXNjYW8rV0Z0dXlVWW9o?=
 =?utf-8?B?YkhqWWY4U2pxWlBHUUI0RzcyT1B5T3QwVGtEVndDOSszUHBvcjc2NXpqdDVV?=
 =?utf-8?B?TTFheTgzWTU0WVZkSm9CcUUrZ2ptcVdVNXJpVGJhQkZtNWlsRUVQa3FXVlVV?=
 =?utf-8?B?UFJnVkw5elpna0dRTTlsdkIwTkp3Qjg1YS9rQklMeU9zRkRHZDBJKytJOXRt?=
 =?utf-8?B?RzhFWDBJTUNaR1NDelFIcFBJc2tPT3FXdTF0c3lPR2hmMDFyYXhtT1pTNUVO?=
 =?utf-8?B?T1h1ZEw4KzUyMmpaQU1jTUcvbHpvTjlyUnJFKzJhZFFPRTNWUDFpL0ExdHlV?=
 =?utf-8?B?bmRpb0NRM1JTb2ROcUNoMlI0a1NObXBwQndTRkJ1RW1SNSs2dStnSW9pNkgx?=
 =?utf-8?B?VUZmNEwyS09MVUlPdk1uOThhZ3NVY3J6WXE4SU1FcjNySEhncytLd3hXUXJL?=
 =?utf-8?B?bWdScS9FVTgzVzg1L0R1RkdJQ0VYMmowS0ZuYlBRTTRnZmdvSnl5OXNFYmVJ?=
 =?utf-8?B?cW0wd1Y3b3VITmQ2TU4xOGNyVU02R0lLdkJKT2N2SUp0aEZ6Y3d5L2ZRL0dH?=
 =?utf-8?B?c1JPNVBBWnZrejY4SGlNY1FOaEdwN0VYdW9TVjNqTDYxLzBHQjk3aC83YllB?=
 =?utf-8?B?eHlWTHpJY1lqcFpEc21QZTc3RkNpcFhpRGIxU0NiVHFxRTJsSFBTbjJEVHVm?=
 =?utf-8?B?UzJyS1lCZzZvNFp1VnFpTlFneVF1UXIyK2FJbGgvZ2puKzR1eERCeHJNa24z?=
 =?utf-8?Q?GPNQ+8IesaM=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NHRWUWlVMlo5dEpxSXVJd3p2eGJXUmMwSHVBRTFwNUNSdjE5YUhJOEIxQTdK?=
 =?utf-8?B?WldpcUpTbTBHSWVHdFFwNk5oNUJ2VkxyMDhlYUswMm5GY2oyVGloT1dRNDdi?=
 =?utf-8?B?dVJkQ3U4N2FyaVVSS1NqQ004US9DdjFSeHFzTmVhZk1aNmtPUk1kTFgrRUNj?=
 =?utf-8?B?eVFxN01ocGNnN1A4QUNkRnNqdmJ2U0cya0Y0UGtldVJ5Wm5hU1E0SmZvRjZU?=
 =?utf-8?B?MHdDR1RzV3d0YmhNd1dqNmJydi9oWElLMHFqS0JwSHpLYndIMEMrb0IzUXVs?=
 =?utf-8?B?MHVKYkVCZTJGTWFxWHJRejVKMmFxVUZrZDg0c2wvdmVFdUZVMGd2K3krVE41?=
 =?utf-8?B?bUJIU3I2aHJqbjYzKzNsNS9CUE9GS2piRXlnbitOeGpaMVUzeTR1dm5WbUhY?=
 =?utf-8?B?UUNwUDByUzZjZHZKQUVmY3lkQU50SEhCTHJSOVMvaWNzYk5YaEhqb0JmNVh3?=
 =?utf-8?B?RjhZRk1mcm0vN3ROOTJrL2pvVlE1bUQrYkFkK05TekdrbjlOR1h0VnZvSzQx?=
 =?utf-8?B?V3h0QzMyV203MUkxdDBaQnZFNDFDRW1ROHM1R1NIdDIzTjBmMkdZZ0JCc2xv?=
 =?utf-8?B?ZHFmeDNyN3lBM0dGRFRqZ1RYZEd1RWtabHpnUlAzVEM4M2V0dWwyMWkyNEw5?=
 =?utf-8?B?SGZZUjFJYzMwZlNETjBEdU5sVG9ubVQ3L2NMTDY0dlhWeTBnb1A3K0RuNzJ1?=
 =?utf-8?B?bThnOWxncXFqNmluNktFZzUyWFIrdjNMVyt3V1U3dmlpSGFPcG53UnYxanlq?=
 =?utf-8?B?SnRLcEtvRWMrWFFZemhmcHJhTzhVQ21DQXFjYTB4L0VqdFRwb3VJU1ZVYlFE?=
 =?utf-8?B?eU5yT0t4MzljdjJwMFNSZTQwN0NNMmxKMFVBTWNranAwamxmSzBRTmJaMlZC?=
 =?utf-8?B?WlN5SGdnT21rRjJJRTBidWRlSW8xcHF1VmR5MU5VWlRHQ1ljcmRsNjJNTGFQ?=
 =?utf-8?B?aHFjc2oyRTB5V2FONHErNlh0OUg4ZUc2Z2xueDNxWlJoRGtNejFpanFWUWhw?=
 =?utf-8?B?alAxV3lSeHVvL1lnRGhlVUJ1VWU4TkV6eWRlT2pUMTkwQjlZTzRQQXlwaStr?=
 =?utf-8?B?N01lSHNPWGJrU2pmK2tjdzdyZUN1YlRWb1J4cWxZMW4vcUVYMmlUemlLV0hR?=
 =?utf-8?B?R0xuWmRndjJQMm9adDJudTc0Rjg3azdqSnpwa0hNMnlMcDA5VXhyeGVLUStQ?=
 =?utf-8?B?QWU2U2xyM2hRM1Nja1RidE05NXowYitxVGVjekpLdnNXVDI3Nkk1SFFpOVVV?=
 =?utf-8?B?bnNtYWZ5dFlZWE9EK1FFSGNsb1RqcTk3bHBvSkFVbkZGaHUwdVZiVk1jNUU3?=
 =?utf-8?B?UkZHY2kwTmMvKytXeFBZSlBQRDFkblIzaEtIMXA1dTU5c0pjcEZxN2IvNllI?=
 =?utf-8?B?N05GS2RHTkJ4ZkFiWXBSaEhNOWRtaWZIekVuYVFnN09HYmo0emREM0RKcHRK?=
 =?utf-8?B?R3gxYXRLQ3lheDFrQnVkQ0JIMkx6NXJsMzd0TjhYL1VkdWhyVDZQTVBSc1Rp?=
 =?utf-8?B?d09JSm9XZEJYS1dBWDgzQnpkRDJxQ3h4QlZVRUNNem5qeHFOYnR5cVllVDZs?=
 =?utf-8?B?YTd0anZ4bGx1VmRDY3RxWE55dE04TGRKaEFZLzgzMCtaVU43M3VXc1hVMWhR?=
 =?utf-8?B?SjdCWWpxZ01MQUtRcEJhNlJncGtqV2pDdldZZlpBYzgxclpGN2RucFZ1VE40?=
 =?utf-8?B?MmxVMWZCU1pZQmJBU0ptUHhFSitsYlpobC9tMXNiRGEyallwMXZreVlEZFJI?=
 =?utf-8?B?QWc0OUg0Ui9NRGtIU2pUQ1NNZjBqY2tXcVhkUENGbU9kT0Z3dXdYRHk0SnQ5?=
 =?utf-8?B?WjFBb3V4Vk1oZDN5VWJQZURNN3ZhdUdVck1tSDAzNmhYcVliYVROUnlLV2M0?=
 =?utf-8?B?UFpsdkx2T3hXV2NTS0tackdOaC9HZHN2VGhhQ3RKcTlTQXdOdGtZYWRJY3JX?=
 =?utf-8?B?WnNwOTJPMzhLUDFYOUNrWVZDVmpXNVpJWG95cSszK2VZRGdjeWQyVDBWcExN?=
 =?utf-8?B?WjBIRmJ4WkZ5V2xqeVp0VlR5SnVWWjJCdlp3REJob091UDl1SWN4b3FYTWdw?=
 =?utf-8?B?UDVCRnhFa0hCRFh3eXltL0RzQlVtQlpwTWxGZmtwUHRHbnViZmk2WWdiWVB0?=
 =?utf-8?B?V1dNT0dvZzU1MFYzZ1hQSVc5SGJFOWRITXY0S3ErNWk4SlRWalJVTFVPR1BL?=
 =?utf-8?B?dFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VCH0Gedl61u9CL9XzBoXEyaHg4G4GRfcnoPMTL0R/ZEkK1252uUcW0BtLkNBfyv712qx2wh9EMWSNBstbaAbdeEzJADfurrwbv4pdESdT6ljfEUdUfaXPFNojAtQZBa7XVwHurpjBcI+6l8Q17TwfTAeKyqyDyMB8jfWkjPjrAPqg956Z0HI1Sefp6qIY+a/75p80zY1E7wCPKu9z9MYLLsCUGVMPylU3HdbX0M7m2DsbQPtCGnxOAHtgux0h1WEzPoJzVH8iMO+Ilv/vFPnik71DRKS0j4yPCd4l++1nrX62v/cNhKOgr/VQXNz13EwFjamcIORWLCks4XPKPtjbJPoVtXYGP9MiFl6pAlpQQEDSMd4pIi/vSDhHYs4v0WT7Cdgve32GoM6y18bkFovXSd0GTvzlmYdP6esbZPrJM5T96masVxFDTmVIIa9qidLKayX0heOH0fK7IalHqzbSWlL/GakoHoFH94fQC9L6mA+dd2QsS3H7Va+piXLLGs/jC/SDpjPx3A3fgaTBLXsjb29bGniTWu8njCI/yhIJnR9GQNoGGFf9oNzsN/q4Svb9BwE7W/JtNHQCCjWWsLW7ZYR54/Abr9ZhLu3UCyow3o=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bb3231-6ec5-42d4-91df-08ddf143500c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:55:56.5246
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8fzqbZu5xZHRHZY1M0BbEkUHH1SzBifrWNuPSDGlTpsikxiqzvuDIMuOv6B3+XTPtGNx1n6YKj55Ac4l0vtPUURstXYdTLFZ/XUDsIw20Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7260
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110131
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c2e301 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8
 a=2ir9tKXkK0-iLYl0BP0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12084
X-Proofpoint-ORIG-GUID: jxRTgcloltPnprOkh_Woc2GSPU11UQW5
X-Proofpoint-GUID: jxRTgcloltPnprOkh_Woc2GSPU11UQW5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX97H1dVepI9R7
 U1TYe4iPHkwlA7Cs1saPP2PTzJHkVnktGhjs4zhhMMdDzFJNz/DDJIOi+C5ztshhgMF1MoSVTdz
 RnZEzV1ty1durgr8SZwZi8sbGcq2S3iQvWORCyOHH/bhOFKPdVz6X5HUqUSVuEbML/4JRbpJsPW
 /d5y6wTqv8RL28zuwe1Zp0VjfyZOLFPtWg1EZfoBltzWRvF2hE9z7nH33coM0h4/CE+E8lhhefo
 cA7FS4CPcygULU1tYStdJ+b/ye/j8b7ZNnzxwe3jRjsay0yd6oCyFpQf6IlgsGXUZp3kaWbmMOf
 KxKvLX1Q3xIyhIZlDuPNZygRpIoBRN9xYETm0uBPQLiumb9lwLG4Dr1dy3AAXXz5iGaQ2B65peF
 2em5mTbt0hN/PuF/6FLaq7k0d41BAA==

On Wed, Sep 10, 2025 at 10:44:40AM +0800, Yafang Shao wrote:
> The new BPF capability enables finer-grained THP policy decisions by
> introducing separate handling for swap faults versus normal page faults.
>
> As highlighted by Barry:
>
>   We’ve observed that swapping in large folios can lead to more
>   swap thrashing for some workloads- e.g. kernel build. Consequently,
>   some workloads might prefer swapping in smaller folios than those
>   allocated by alloc_anon_folio().
>
> While prtcl() could potentially be extended to leverage this new policy,
> doing so would require modifications to the uAPI.
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>

Other than nits, these seems fine, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> Cc: Barry Song <21cnbao@gmail.com>
> ---
>  include/linux/huge_mm.h | 3 ++-
>  mm/huge_memory.c        | 2 +-
>  mm/memory.c             | 2 +-
>  3 files changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index f72a5fd04e4f..b9742453806f 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -97,9 +97,10 @@ extern struct kobj_attribute thpsize_shmem_enabled_attr;
>
>  enum tva_type {
>  	TVA_SMAPS,		/* Exposing "THPeligible:" in smaps. */
> -	TVA_PAGEFAULT,		/* Serving a page fault. */
> +	TVA_PAGEFAULT,		/* Serving a non-swap page fault. */
>  	TVA_KHUGEPAGED,		/* Khugepaged collapse. */
>  	TVA_FORCED_COLLAPSE,	/* Forced collapse (e.g. MADV_COLLAPSE). */
> +	TVA_SWAP,		/* Serving a swap */

Serving a swap what? :) I think TVA_SWAP_PAGEFAULT would be better here right?
And 'serving a swap page fault'.

>  };
>
>  #define thp_vma_allowable_order(vma, vm_flags, type, order) \
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 26cedfcd7418..523153d21a41 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -103,7 +103,7 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					 unsigned long orders)
>  {
>  	const bool smaps = type == TVA_SMAPS;
> -	const bool in_pf = type == TVA_PAGEFAULT;
> +	const bool in_pf = (type == TVA_PAGEFAULT || type == TVA_SWAP);
>  	const bool forced_collapse = type == TVA_FORCED_COLLAPSE;
>  	unsigned long supported_orders;
>
> diff --git a/mm/memory.c b/mm/memory.c
> index d9de6c056179..d8819cac7930 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -4515,7 +4515,7 @@ static struct folio *alloc_swap_folio(struct vm_fault *vmf)
>  	 * Get a list of all the (large) orders below PMD_ORDER that are enabled
>  	 * and suitable for swapping THP.
>  	 */
> -	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_PAGEFAULT,
> +	orders = thp_vma_allowable_orders(vma, vma->vm_flags, TVA_SWAP,
>  					  BIT(PMD_ORDER) - 1);
>  	orders = thp_vma_suitable_orders(vma, vmf->address, orders);
>  	orders = thp_swap_suitable_orders(swp_offset(entry),
> --
> 2.47.3
>


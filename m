Return-Path: <bpf+bounces-79192-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78300D2CB88
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 07:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 235CC3007612
	for <lists+bpf@lfdr.de>; Fri, 16 Jan 2026 06:48:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48EB634E764;
	Fri, 16 Jan 2026 06:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="U4k8atSb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="M5q2GG8S"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BDA225397;
	Fri, 16 Jan 2026 06:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546104; cv=fail; b=V9a8muE7JxeWCzgjqoIHfoh4AHqZz5iW6RPPdzHGPemfgfUvOmdV9ykLvRv8txBDGRiZScLQbywLpvwNPfnXkgLXuT4+kqaDJpibeIgHMH2cplcn+gStDZUnU6OS8cPFvkNPITZUsmZg6z1uvoSVa9Kx5C4pVJtRR+eQmvhGuVI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546104; c=relaxed/simple;
	bh=WIWA6Ue8h7P9OdZtoU1aJwSh9BU9US+i+Z+hd1VuyUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=KTbXHqRXsQnQV2QO54WjhVHyUutW3wfXa3rNc82mZJjDJgLiwejyHRJGv434I7d1AWSLg80vGK5rgOZM2uGXkZDw3lHZl4/o8MsBWuwHCFURPLNXeAaFm/mu/+uhofPKfT0R9T8bITcfiiWWeBgXSAjv8uqL3EOTHQpXf4V27Po=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=U4k8atSb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=M5q2GG8S; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60FNNRd01430382;
	Fri, 16 Jan 2026 06:46:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GPnEgGmtlTiHHR0NAt
	UdgVKL6jQBK92oDBKyb/fUf3U=; b=U4k8atSbLAZznfZzEU1o9m3glZM26Hls4m
	XPpNpUWZjkDo7pRZBYE6OrnlpeurAyFd11yu/DdVT/E82BFYRNFpq7F9slWJw5KX
	ztossVYqK73Xwg3ZiES/MlRb9O28YyqQjJS+ft7CrRGETwSiKf2jJ2pvxwSXKz/8
	oq3SxHKVZtAEe5adzRxelSLH6SefeVKjhr23faQ6uEd78fkv3lrWmHjGuTR+FCXG
	Oq/hYRFlDwSb6nbNz2i2gsg9BH1b86cVEUxpPCKk8Do0lECvP8BcbjqM9ypv1UyB
	HhsH//Hj9L99XR+lE3ridPNUHAUIXrAe4SoETMbApFNu52HHt+FQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bkre41h2y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 06:46:45 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60G6LXRt004464;
	Fri, 16 Jan 2026 06:46:44 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011057.outbound.protection.outlook.com [40.93.194.57])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4bkd7p8nyf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Jan 2026 06:46:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Iygy8I3e7abQbKzwgKBmPNTA5Z3vM1NF/kvrglmiYsoQgJrZtaJo8M2RYp9EwjXnVUw5QmH8i6ZMJ0HQ58vDudkCwOV0HETLVZMtW2V7vgPF6QDxjHksSnsYh9pi1+BbDHjR/AowMxj6xOftrBUlxcnHzA//9lzRKQpH4gUCz7Is2OSJQuZaBdOAH0d4rbZ2dnpzxa5w6q0OxV8mljekpXBzEBoi4lcm7m/DWOZmYRwhJQ95KXftvgumc1Lw1TJiQJwZttE7LsZICm/qK3woL+4KTPZYjWK8miWDbQZ9JqUqxIy+A77XRNuLfLcUzUgRyVyERGedAUmN/LOIaMGPsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GPnEgGmtlTiHHR0NAtUdgVKL6jQBK92oDBKyb/fUf3U=;
 b=OvJve+Lhfr3YG/3YCXk2gxANjvIjsP8o2BamKvKq0U8nVvua/Yl2b3qMmrgbmcdav0p6ZlLhrmnVDA2RTn8h6p1yAXtMQ/Iwsszilc1g7zUXx2eHSWyKbnqAjiFVvW3ww+WYwHBnUTwNO8+mHSA/4NJS7AH64ToeorJPEtg/p5rFBsetzsg0WGVInmxGct/XJPFIZnk5n04lcuXXWx06XbJQMfEWY+osbw7KuJ36rPAfw1zi4dqd2hUoPiB+v4g7+UPnwuKaBM3y+2BO25aznxtJzMam8A3Z06NZR0smCSljAOz7IyTGxTL5ixw5ZjTdPsAmHHt8PkCoCXfA8JWh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GPnEgGmtlTiHHR0NAtUdgVKL6jQBK92oDBKyb/fUf3U=;
 b=M5q2GG8SDd+r8WDSnJAdvqYXmsWFjrOW35oQXVpLZ2ZaA60JL+nSDqRm9RWJZp0OQEiIMSGFd3GKTz1kGIE/jNLTz68JlSRcNt3BH2rI0jviLrnLmVWcAB9gYpqkFI/eU8toD7lBlRrxv5JT8zx1bWq/Tsq6G9FK3P/EtUEniVk=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by DS4PPF80FDA9397.namprd10.prod.outlook.com (2603:10b6:f:fc00::d2f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.5; Fri, 16 Jan
 2026 06:46:41 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%7]) with mapi id 15.20.9520.005; Fri, 16 Jan 2026
 06:46:41 +0000
Date: Fri, 16 Jan 2026 15:46:27 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Petr Tesarik <ptesarik@suse.com>, Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, Hao Li <hao.li@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev,
        bpf@vger.kernel.org, kasan-dev@googlegroups.com
Subject: Re: [PATCH RFC v2 04/20] slab: add sheaves to most caches
Message-ID: <aWnewyp0L0WRUPud@hyeyoo>
References: <20260112-sheaves-for-all-v2-0-98225cfb50cf@suse.cz>
 <20260112-sheaves-for-all-v2-4-98225cfb50cf@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112-sheaves-for-all-v2-4-98225cfb50cf@suse.cz>
X-ClientProxiedBy: SEWP216CA0057.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2ba::18) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|DS4PPF80FDA9397:EE_
X-MS-Office365-Filtering-Correlation-Id: c2edf117-9bfb-4162-749d-08de54cb017b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yiSFLAko8dJxUnBBLkrOs7JHesJw0+IFZKXQQu1QX0hVe4ODP8QAgRNkF/In?=
 =?us-ascii?Q?rpEmFQqlXzcIMCA7anFXhKuEg0YQ9snYeqKUh6q7kUKFxopL//URS3yCz90K?=
 =?us-ascii?Q?GY+zUxhPdB+If3Ko5RXaIjvH4wkaAFrZZpz/5x/NnvN1A2bBcF5k5ZctTqUK?=
 =?us-ascii?Q?oC1kHWpZ34UZFwgsmcqOCFXETci4vioUq6D1/+KX4eaRvu7LaOAxIBiUZxAJ?=
 =?us-ascii?Q?soK0URookA4cZatKnx5hFmNzjdNg4NCW/VgCSJbq/f7warlPdAuTJE6Bdm6g?=
 =?us-ascii?Q?OstaqmK4PPREjadtBCryP+NK8JF1BZl8V96yqqE3+C8njRoux93KhuRdoQg/?=
 =?us-ascii?Q?nNFUMWT6ftQZyLucgen3Mb9DvZFdutoHy29EBRPCe52jZNhizv9CwYJUZRtT?=
 =?us-ascii?Q?go5W6FS/SKGUHElRWtkl52syipcDPAVYcYAcCPWFlCVDwdT8CiE0ZHzATsul?=
 =?us-ascii?Q?6meGnSUaFj/0Ve2wQy0M9PVx4yDVfZzmr1WKfTmStHLXniXGou8SZ88EHsDz?=
 =?us-ascii?Q?t8pDTUIHnDod15kERUG0MG96qt0kIyZVLLQOjSkp3bY2DYQGfIRCZst09ix1?=
 =?us-ascii?Q?r6i9TRto9cmdOTm5X3mhI9va7kYuaSQkXl+5ZqmFywNxUd0H8wacVlTipylE?=
 =?us-ascii?Q?FqSZqDbVunoaA/vTkYMU2Z6EgOfPaXCPnbr21H00Kd0Y1CfYnnq4HSjz2pAc?=
 =?us-ascii?Q?Fcydq9D3HVyPkPEsR2HxI8G7YS9w17YRZ0C/uoPFPB4RnmrCOlILB40R3eeZ?=
 =?us-ascii?Q?2YRVUN8P2+fdXqkYh2CkumTXI7Oh09DIxIMbs0Z0jp29ehQ9m0KAZ+IFjFap?=
 =?us-ascii?Q?73fwgkjNSqcnyJrwDksygFcvBvmgws/kzSsH3aEjaqE3u7fT7HNPN8pNXoO4?=
 =?us-ascii?Q?OgArOvXm0Cx/fbTDRXAY+p+wCXXVEZDoaYcl/9kyg4bdnwQ4nVvjlCnMikX3?=
 =?us-ascii?Q?E80HWdWUj4pCzdhuda3ccnBJSRXkQq/DvovHA2nO3mYIa/btNVaTktyFw/hN?=
 =?us-ascii?Q?5U6MO8QvNmzZ8AX1NFrfoFQeSNNtwXt60xXlB+k0nacAGMlpKYz6zTYCDgSn?=
 =?us-ascii?Q?RDVFJhPyvkKxiEEZvu1bggFWWbbs0E6a42euQgIxepzD2qXYDi9AxzbZy11S?=
 =?us-ascii?Q?3vCu4IlKakYmABW0TkgkfagM6D5upGFh44B9B1uWy0ZTA8DYYeg9wrSxmklN?=
 =?us-ascii?Q?349aZVDQ/rxr5ka1129rkKcBKk1kblKgk1s7UKWLaWhHeFeWJqLdpGh5I+VF?=
 =?us-ascii?Q?nD/dsAwxP2h7XlbXn1jBfv2TuutO8SP8yCzJmpxnrHo37UnEvqnQKcva2V2Z?=
 =?us-ascii?Q?R6OYnBJdwgxu/h9/oY646jeueeb1LctZcbOEp60LBwEPKtIiHLm5gz66zPcf?=
 =?us-ascii?Q?p79aoyNoyn90OG+89/aOa/EXhY9V5TrFHoNUddEfxw3dFLgQlZplUhBZgqAO?=
 =?us-ascii?Q?q0Uh33C1drOKIigYqGbnQ4iBIovg6EmesbKNCIAVq2uQ6x9R7cpojVHKj1gN?=
 =?us-ascii?Q?qOfcteGuwwPZwx13Bn1DeHHU8kIvDPUIuWap26g3C1WUkegDorbflvWW/NXS?=
 =?us-ascii?Q?mIGLMCw+mnobxikX48k=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KS+R/TU6ymvi+x4VPArYqNHq69yB/6D/sqpYj4FlI1cBzPS5rlBVeFwZinSy?=
 =?us-ascii?Q?N65FT7ZQgWjlz5qzxc7pOS23wZLDAERLdA7Smg6QHNGIQrLv7755MRUH2LbQ?=
 =?us-ascii?Q?g5M1WmCYLZYxvm71izIa3oEml2U59lzu1VmExaJyXRORIC7n0JdBl3+S0TWx?=
 =?us-ascii?Q?zlp3uKRUdyRXUPLFc0t5zHFQ8PGwsiB8ZwLkLHbqVcfMtmOMWCoL6OCIrio5?=
 =?us-ascii?Q?kYd4WERcJEsGPUbJRyMvJIXcNsC0eyjF4u3LuL8Or6LvQYSvC4nmot5Pi7f4?=
 =?us-ascii?Q?hIwYSVk2q/HewNKiNUjONA8NwZGrIov45HltHWPOFmmBF2H2zRDR5ixqY6wh?=
 =?us-ascii?Q?G3001RpqH+doZIeDrIJ+lZbN+5kacVi7DNh/FpdNsK6L6ZcY+5KYnrqiGMCY?=
 =?us-ascii?Q?cpFzynOkfFWG2Ynd0sUHhtBduIG9GPBVMQULngDlLesPu+j4wy3W3XSXl+e2?=
 =?us-ascii?Q?IKHCtw+Z+Mwm4a8NSKHm9vcSimmNy/f1CuIvEJvhMrVi+QfGHW9qZvlrpR/S?=
 =?us-ascii?Q?Y16VozWxPkqFpTgPY7SraTkRV6NmAs3YElmUfVuElmNEkOnV9V8HhNJUnREi?=
 =?us-ascii?Q?Wd7ZpjqamFMNBZc2V2IKG9DN2sdfAzjgHfe1gtW0SOMNkdhPjY/yza0ilnPB?=
 =?us-ascii?Q?CXPL7I6yTUSreV8LONMLpG77LPcztBDjzl4uqXjZ7V0m8OkgnMDW0DjpF8xa?=
 =?us-ascii?Q?N2ERxyN5pqZyVFe99A5zFIGdk9jzjKITf0c+JCuOwudoUBNY4HQ9EkCju2NB?=
 =?us-ascii?Q?YijJ9KIJd2kvto4K8osA8YYUFjYbRgIqu4ymkKWODtEbdQQzN+/mj44ZIyyS?=
 =?us-ascii?Q?TAV2Hmo39+5mLWq8Pq9HNTUKqtBew6p44Z1SM1NVERC50zn+TgCWse7Zfowu?=
 =?us-ascii?Q?UyPug6Bwfp4Nlhr7+E2YF3/T1IOL7HVSIi9IfEOcendtN7KUXs3dsr60oYpJ?=
 =?us-ascii?Q?RvNlkgi3OFkY0VcKaaZUze1Id67/abYhJy6L6lRtDt9YAF3U6Xu7FL0+5uCJ?=
 =?us-ascii?Q?+2+hQXSz4flIx4/z9Izd1aLvXkcb0YbxqgpRJyBhQDKbW4rR6nSUOawOa+cH?=
 =?us-ascii?Q?hIf1dqg19n1R8WinHGUfKsyXoDVgCgB/JomxMeLwwpf1aiuPn6YMzL+CPiCa?=
 =?us-ascii?Q?NttUxEDrDFnCTnOHa3WfZArZbL5UlP/x/CAv3UUXhiCJcMVgsTuVept3KiQ2?=
 =?us-ascii?Q?xGE09MkYV2qx0RxviVi6f1qoAK0/5s2c+ZT5ZYQfk5vleBcZUa7b89I6CFXc?=
 =?us-ascii?Q?QoiheS3epD0jEyvPUH6fD8xpo30Kv7WgpLGvo6eQd2Pq/mj3BF/lTEW2wucx?=
 =?us-ascii?Q?TVocw3W5oKCvuW/LIGpCFumKkNrRyKBgzvmu5L9yXkHuDp+u3NYT3//MDHKW?=
 =?us-ascii?Q?hBRcJSzOYeqydefeub7XsOnKmBwmJ3Ai6r/5g2oCCjcx6FFeErvG1XZgxF4S?=
 =?us-ascii?Q?o5DOIHh2CsqeFdQVH/s0sS6SZS27rqg+e0aUthe2uvtN5+d579y+EDRHW4jo?=
 =?us-ascii?Q?xbi9JpBmpUxoqzZfeGB2yfEBGUePkpK4UDjxNwQRsBGI6ZgkdIpxm34AGb8j?=
 =?us-ascii?Q?Llt02xlMb50jxERaWS4ZDnQCVyb28oP7whsb5myZg7NSKZLZzhiIkOTshfPw?=
 =?us-ascii?Q?Cvnxu4GHCAUCIh1PMKAkaKh8TYYoIAcj2zGR6HW0r/1Cx3Hl7TxTcPt5HB/W?=
 =?us-ascii?Q?u1xn70io3CPVew/ByA/6M6QfV1KgL0A8LxNSt+o2vsNOJo37u5zO9sV7X2JH?=
 =?us-ascii?Q?IwMe5g+XxA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TQiuuD3GTVtgMnUMrI0565B5smaLvxgutqmpXzV2EABKeqoInpMc6CBm/KJqgV7llD84ybZfGTokjqqpFD67lkDVD01ERsqUAS+6Q5YUbKTAL8Dn6sfPs+xsagnBcYnSQYpl5lW6GW9Zx+rZk/rNwrHpt3WlmS6LSF7xDHMFHu6J4u2+q5K3LzDZrBpMabaDE/qq1Wc7OIJdaexyhBTjHVIo+1QrwrWwd3ZuymBvlqxz8CxPNCFzD/ybs0vWxIm9gzdu12QJbhVbijacTxa/Hx+UsJU3s3W2xZdinKAX8h8G3UUsEBoPhWjwPZVrjV7tIwZtNZZk34seHJMuyLajPcu84jFXLjSf2T0UYqaa7DC9GJt9n/SI+fS5D+DhvhtWtvld+N0EQMuzw/RrfKpq8mfRVoqVklD5N9vQCyDoDT1Si8UkWIG+Pr82QWdpjCfbsHWk/2wtRz5V94KVTTQ0RSUIGQ6XjDKFppuaWxyfFiySr43EWNHTYsBQPp1G6/aZnkciM5a54Sw1VS1gaI7sXKIJ+eriDDVhWUDCc2us0b9RhyoBQH8f+BcZhtHxDZTxtzcs3wvFw4vvjdJusMDXpnxhJBZbsf/Z4lO56J6xWmI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2edf117-9bfb-4162-749d-08de54cb017b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 06:46:41.5109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NfGGSwSvsOHw69Td3gDfn9U+q1j8hY1YQ76ZHMQvD8M+E5hBNa9Fkxxa1VfQmuDjf1UEV1EeKyNcMIKzSeHkHA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF80FDA9397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-16_02,2026-01-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 spamscore=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601160052
X-Proofpoint-ORIG-GUID: yG2FvNIvlbgfUps6m5ttWVrBd_R2zRXR
X-Authority-Analysis: v=2.4 cv=YKOSCBGx c=1 sm=1 tr=0 ts=6969ded5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=QznUpgGXYvFiLFJPiAMA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12110
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE2MDA1MiBTYWx0ZWRfX5OhS04nPA08A
 OW1szInXMc+lLMuwCgF1k0uGSKE4aIIjc2SslIWi1A7k+TsOUQlk27vpDvUBYQ+izdbxL7MLNsD
 5VDJ3MziVCwoFM+qC31hCxlfXPHBZ/QEM4Ye9AwlvFeLb/k5HtrLCe1n8WvD8JPhhyn5J1CxEp7
 fBVqCBzEv5bYPY4o6qfq52rVNeT3UGX5VgY+BJeTtVlCjBXIc5s+bWHLWMOhxyph52aNGG4rdkO
 UQG5aQxamTnaPO/s04GWQXuw6oNBuJfZVRTVYZZ/NVjk+5YF9UcS83cKCVaVOjA7U7QYfiyCxkG
 0qA541KoXeBiSBsPjHqrUz3valC5ClXuLs/6AqUwjBGERPz84tCgq4rOZi19Qg7JxkipqzNQWFv
 YSqWCcMfEzUzc5okgzbsgZmvKiCMRpa3gBolmVLuGoaYMdjaBK9ScM31ZTmze9I4NXBVjFT7a7e
 cExyrBHkqnChwZBCBdBqwR+yIwiornsdNmX+diEE=
X-Proofpoint-GUID: yG2FvNIvlbgfUps6m5ttWVrBd_R2zRXR

On Mon, Jan 12, 2026 at 04:16:58PM +0100, Vlastimil Babka wrote:
> In the first step to replace cpu (partial) slabs with sheaves, enable
> sheaves for almost all caches. Treat args->sheaf_capacity as a minimum,
> and calculate sheaf capacity with a formula that roughly follows the
> formula for number of objects in cpu partial slabs in set_cpu_partial().
> 
> This should achieve roughly similar contention on the barn spin lock as
> there's currently for node list_lock without sheaves, to make
> benchmarking results comparable. It can be further tuned later.
> 
> Don't enable sheaves for bootstrap caches as that wouldn't work. In
> order to recognize them by SLAB_NO_OBJ_EXT, make sure the flag exists
> even for !CONFIG_SLAB_OBJ_EXT.
> 
> This limitation will be lifted for kmalloc caches after the necessary
> bootstrapping changes.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

Looks good to me,
Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon


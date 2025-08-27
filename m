Return-Path: <bpf+bounces-66679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E354BB386E4
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 17:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C065C7A5F17
	for <lists+bpf@lfdr.de>; Wed, 27 Aug 2025 15:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A96F2D0C91;
	Wed, 27 Aug 2025 15:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bhjnayvN";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tx+miP/L"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C4441A3166;
	Wed, 27 Aug 2025 15:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756309560; cv=fail; b=ACCtWKWgHUrsl+nsgMmcgEUqfVpyUrs5eJVse0McuJtgsk/EXj03TdgNETA+TowXLLsP146Pu8BVX79onvlk3MkFdvQP8mtPs5AA9jHBQAkLnStstrZUfByl0nDA63sxlE8IrtqtdpKEgDATg7P45tD6HsFiK8srPzc+abuZwAE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756309560; c=relaxed/simple;
	bh=urkU5/U1C+J5WVJiQPdlaP0xgZ1aNUE2cqTbL52we+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lt/74TpRl8jLWGRitF5ZiixP0W1frU9LS3igOaS34P01gfPWxLLnIROe+xftJrPT7/qnxPJTt2jQggwvwaq7aWiShlTyuVrK3GhTAltYOlnJM+pX/XC5caHqhZKa09Gy1Ksci65RfnOCHXdVY7mrOj7bqloSqbxpszJDS/zq46E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bhjnayvN; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tx+miP/L; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57R7tt7H004363;
	Wed, 27 Aug 2025 15:45:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=VIBWkSP3W+LGhSCRUm
	wFv1KOnqaaAgYlpOisiBvXORE=; b=bhjnayvNZ4fzVdSRLIlFC64Cdf1cclqMKY
	ofqGUNZa/2NDVkt5DrbCg+/CDZQFgpAYw+wkDF1ECKu9P9kyreSbx5JPBw61qga9
	EQ2sZR+3Ea6MfRILmrE0Hp+Go2xVVf78jHphWVsl8bAdf97Pv4nCL92X0Gb9csk5
	rfmywRhBBvNEpEGj1So9S3v8RiUkcysO2fP5IpGqNkMgZzLP1uI74jS8OazItSsK
	Csgxk+gaFgytQpnEldmvILoYnVHYkk86UkmONUTz/59bYadOP/1B5AaJgQr2Vh8L
	Mjtsa3oNSRgbaZx9X8eJT1cqLMb2e0+hwm+JqoHV/WWPwD4TbuWg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q48epttc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:45:19 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57RE5Vwf012336;
	Wed, 27 Aug 2025 15:45:17 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48q43asr4g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 27 Aug 2025 15:45:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mMeWx+7XyO6e9sNEfRc7cDYxm0zYVPTdHZCMl+fW1hU1vxSjavwRV0mBuTydo9v52BHIIYecAdT04W+rxU7+qcQR8dLQNsd8wxUDLaVOjWnLdrgaP/tnjjeNgMNZajHxJsyYcUKCMjMDlpc724Ci4hNsLoG9mpsu/AcF5I3eKv/k+oG3Xx7PRibEXk9uR2B0AMUKphUrNMfLrbbPFYKu8h5Ixkz2gUPOjGNXxjIwR3xgjtuJ0D/AFDWz2+/MVGVCEtsyvktX89+BS9p56Th595LTl3xiwLhDhwCAWzCJYBP/bJPxyI0Yj8gT+PYH/bz2cuUjz1nKEyzFyLTGBDrGbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VIBWkSP3W+LGhSCRUmwFv1KOnqaaAgYlpOisiBvXORE=;
 b=aoCtatTuE7Dir1k0t5+kkeljdCRzqLwTmqJQpKpJGvyfUDunc9jK7H4XB49/ZGardV1+VNVjJZ2sbTkUam2YWMlAwq4o/D5lTy4qRCfLnCTPi0GNqwI/9bfJ3uQy/MsSM6TAZfosRGbvwK31Z90XJANbXcIkKJW9diuQ2jpCf7LIjkDQwrJ1VPUx9lX6MOX+ncYD45DtfFFkAVasCzXA7bzF4aWKIzkDgCgg8ypEkTYKxfNF4mpeHUtb4YDY+BFwkNQVFk9Cs4e+zezvW21OEyGkHKm7+UWYF8uSwOik1Q3ILNm5gwIUPimcDRsvNy8eSw/YPPjZvrWnu/LktxQPlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VIBWkSP3W+LGhSCRUmwFv1KOnqaaAgYlpOisiBvXORE=;
 b=tx+miP/Lx1Os4ad4GWl6sECc9PxXrl05f2yKUNA7y8hSTdpZdY/WjtmuzYIoUg1FfNInv743etDZ278p9fZZoDMVsW66/ZX2eKiug0DVOxBs+Yau4m0AFY8sOzhEpz2qH2UV9uyVmOpIIxGsf9/cl40igYmlTtxbgN6H44AZ3xE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7767.namprd10.prod.outlook.com (2603:10b6:510:2fe::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Wed, 27 Aug
 2025 15:45:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Wed, 27 Aug 2025
 15:45:14 +0000
Date: Wed, 27 Aug 2025 16:45:12 +0100
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
Subject: Re: [PATCH v6 mm-new 04/10] bpf: mark vma->vm_mm as trusted
Message-ID: <bca7698c-7617-4584-afaa-4c3d2c971a79@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-5-laoar.shao@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250826071948.2618-5-laoar.shao@gmail.com>
X-ClientProxiedBy: LO3P265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7767:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb8ecd6-2678-4df0-d8fd-08dde580b702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?WJlrMi97xy+HRi86rA1Gs8RuGFov+8URoEKVMy54YY+QWNfbn0iYu37vgILI?=
 =?us-ascii?Q?n/YrmNdozemqF5ssWL3UsXaykOSqHcs/KilIxU7j2Md/nZh+6mXt+pGZKrF6?=
 =?us-ascii?Q?XeR1j/yj78iFga5DdjerCXr18feTyrR8NHXCydRXP2+2/yWdinFwHKw4IfXp?=
 =?us-ascii?Q?itX24UwO0OnJFktArSEY+ktcQqknwRAB2jKkfnDXJE6aKEE7f4O8jYyZOEq9?=
 =?us-ascii?Q?qrcC2HxT/SSeJEILfAhdLoQMcncIHtM6T8dfvdz/lSDd7KhTNdvDsPAvMrbw?=
 =?us-ascii?Q?u0t5I7MI6KuBOHfndnTbC8ch9PQV2Slckvyf9EdOrwQawqcWdXaXOJa367xi?=
 =?us-ascii?Q?gM9MSOL8C2uz+n8d+pVvT5hvJUVWX3TTZ+Lfv5apJwkROpFwdS26CRkIzyKS?=
 =?us-ascii?Q?cq67LE9amN5KEoNv3V78H7Ng18+Vj/rP5fRU9P5H+rSU1O01IC/vsJUV3C+I?=
 =?us-ascii?Q?fA/kIIp0JhPOJ1NdwkLZxFfjeTRV7aLQKwWHtIdBBVh1Is6ZfXoT41jTjjwL?=
 =?us-ascii?Q?KtFowsnDrDD7R36Gst0uIVOJtpTr3mMWKctnHJNcr+3uTWVJJ5z29cWYSdge?=
 =?us-ascii?Q?SXduwP0VzaXCToYikfPB3p+jGQHlo8WgSITrXfZcxO4tXWsuvnMZuUc6UleN?=
 =?us-ascii?Q?UZ7z8HlVkJYOOicyP6g62LA1eQUVmSuGMp3jeGcjWs2Jdf9Bh8IBT1lrwd06?=
 =?us-ascii?Q?AszMH5C8ebtlgkeV2MN8i4C6jk6eztiAhTgqpzc6KjIYSFr1XEZZl5MZzYb2?=
 =?us-ascii?Q?uVJOva/bdrZe1vuD50PggCF3Qs8cPJ1T/DbMg2ErRYFWTFQZdAUhSz0n4pqS?=
 =?us-ascii?Q?djWD4D7V8kcz23yrUVRTp5jxjKiPjIPvTrQlsRsrZdU0PDiw1I3Bo6+5XwsW?=
 =?us-ascii?Q?TaAMYSW104iyp4mSain2UWN04OClZ+gQDQEHnPAaTs+IYA22Ogrl8zUHJfEl?=
 =?us-ascii?Q?8hfbV03AIM8XdLI2UiTQQR4zCfFIoFG+RDHNI1qrPQJhIqK/ucM9ox2W9NK/?=
 =?us-ascii?Q?1R4MeWqLNFGZIftuSEXpFenkSRXSO9jvb/4j0+q72t2RTDJ8BuI/cu5E+wHf?=
 =?us-ascii?Q?CZkwTKCDyjeWapDZCkAf/k86q5yxAlf3K6hnWoWflHD81u25daHVPRe2/3aM?=
 =?us-ascii?Q?hvFZCuZsR/W22fAOLOXJgqOFJP8iV2EXnlfuqTFP41aqcSl/Ynv4KpMk3efm?=
 =?us-ascii?Q?Yzw5536N0GhjAbNtPbkQxXP4xlZWwjG9B0Q3uo+G+yLfCw8+NZuZhRPUQS/e?=
 =?us-ascii?Q?HzAuMU50NvJOu9w4oh+HqXuayV3qDWxYzuiemiwV9WNl7/ysyiAGrdKUqJ0P?=
 =?us-ascii?Q?EsEVTVA/EEebeh4uxOjlXbz2F1EFPQSREGbbXjg71sJNvMKZwuwGgSQnoruh?=
 =?us-ascii?Q?hgcwvx4sjH51h6jNDdn84NA/tmsOSlFDHDztACvTf+Ss2xzSx6+DtmK4Dt5h?=
 =?us-ascii?Q?xf7gTzbnaqI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?RADF/4r0cKQsnbz50hA+jKq9DBR3vYeBceCNIl9vLrtLgacwoQTTxuCTf0b2?=
 =?us-ascii?Q?CN3qpCuE9I5FfpxbwBkQgit4Yw0Jc/PPLQkTgEakToagWaOd6cO4YGfMBhWa?=
 =?us-ascii?Q?mvj55hTWYih45aHK2PbfTEmuzyM5H0tFH5s0lzce8VkkXldL1b/MKj6QHmW+?=
 =?us-ascii?Q?+NDDVdMkRIlFVKj2jcqxV7dpNAqgucanKKLXtGXZmyaaJL7TBY5Xtkein9aF?=
 =?us-ascii?Q?Vvh1EGhQhNpDi19NwPSs2vPzhFe4MwNLP486TI6qaVJBkemSFHkHx0HhQ9ht?=
 =?us-ascii?Q?oJxuIdOSOp4r/WF2fH94lGj2EcLtA2mvRiEfyqDs4E89nOxh3dMcZAuFgT1h?=
 =?us-ascii?Q?NcEnNq+uIeZaoZUklAYfvclqU5sE5K5I6nrs89OjnSOIminp/lxyGJqlmsTN?=
 =?us-ascii?Q?vAjAJkO5vzO1MXbQoCS2nWekdchVSc4X7CbWAPcIM2DmLgEEPcfyRPwENkm4?=
 =?us-ascii?Q?iyUZQBdfxgkVvgb8mklSTenuRLSwYQgEob0CBf/Z7Gyxv0syEGreJ3YZv68H?=
 =?us-ascii?Q?UKmATqFBBNR/aN+6Hc/DmunR+9Y26AhL9TJEqgP4X4ogcOK0kU5e0mQg2TqV?=
 =?us-ascii?Q?RMJozNS+3dNWAa4PSdpFrbrndJPz3CFVjQR5bpP4u4wtAHTW224VRkpgZqC9?=
 =?us-ascii?Q?ogVqUGzXYDIBFhUH15ZP2lNex5eEkg3nhOyAB5evtlG4N1AShZG11dCqKVRN?=
 =?us-ascii?Q?yeVu+pDCkA6dreZ/ag3mwUCuHpfdS/TfzPNYyLrlZUP1RuOMiMIHDslfoKzB?=
 =?us-ascii?Q?+b3wa/VfVleH/U57uMfWHVQ95LktjI+75c6B1JUnqwi6N8U/wTcHQac0jN8a?=
 =?us-ascii?Q?wkJJVj1I9ve31ZoUYifXri5QO1vqV8qsJrS4+cBETkkZukwdf/aNC5mV8aID?=
 =?us-ascii?Q?4ALYI6BU9VAsGsfK41HW22tdvxYWb2zR9COuEAF6yEnqMiF7/Eb6kXom9AiI?=
 =?us-ascii?Q?/cyWlETXaGXWPXnN5ETO6z/PiX50oQacfi1LcrYeN5k/wUntIcFBynC1F/Vs?=
 =?us-ascii?Q?xsBsViJK+PPFJDdDr10q4OmZjQwclNyXolT5uyH5phGzE25PGJsVCjv/SI3u?=
 =?us-ascii?Q?gg9lNNyM0YtHXEClLhqGYsp5EURqepMtkHx+kr2ffQVUQjEV5lCL+O8JkWsq?=
 =?us-ascii?Q?wfaOXCtDQa3RHM3VZYhQdajHvLw3fCn+VYBsPA0SezGIV3vwzT76PgALrJ1Z?=
 =?us-ascii?Q?8zHf9AfJaLLhbKk0VM2vUrVm+UbWhQtzHBZ7Hn1ekyq2zgLTulhKGr2Q+46K?=
 =?us-ascii?Q?DZS1POV/1LnDzJr802+h0jdCpHWm8SXQgqayoGwn1zTPfdJ66InKxv9sDnAz?=
 =?us-ascii?Q?wOwxmx/9d3q1Nrn1t+5uAPtm2kRTKwp+fmVqrvKYsIO1E0fIK25zgprE1260?=
 =?us-ascii?Q?5yXWUZGHJguo03G9t8W6VgaTydaKWPkMO2aHD8rHbhM93D1ibSz/e6sMlGmY?=
 =?us-ascii?Q?bIXDB052RDK42oPYQXhmb/ytWjSJt0R223w/5qyecNvVvaf05jfc8iZieTdY?=
 =?us-ascii?Q?IRTRf9sY/dIcDbTSKsC2hWALVYKalmBRe/oezbNZzk5oZHuh0tj5nNVzXFHD?=
 =?us-ascii?Q?omb6KUjXZnG2iTSQcKR7kHdNRX8zocZUfzSfYhmsNNl88uK7nqImDtyQaZ6n?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	hUpXz+FrvHkSYYmcVmM/4U7IfIGly9c10J8Jk6qi34c68daT3woX/36v1EHeplwR6iV7qXL4CvOkFQzEC+VEGy01vHyD58CJAJNpJNq+wxImrRoYJnXw3Wxxwr+ObDrhDzHnJcQNuscbQ5LITmEzUCmKXrHdtorrlVxZP8qqQe/JQBquo7mD/h8OGhulRn3D6XRARWLk+LYsTn6KFBSE283uJsB8rxiKr0Qpjb9SezEPYOOW7AV1F658FxmUaEZvOTBEjdQn67dSMJ2tsIEZBIb2LnXmm9ddvrRfMqxivUrsOk7TtWVaV9BdSdlzNLWJaSWaoUMaXb1DE+s6KRFfaArKA8UKlADZByjBZmxQE5FEtFmUxSUWv7zS4NvCI9cW8qrWbCXTpjI6mrZ8yJF5KaOsn85TP2ehmFzj5wxhKb2mHP73U25wkOJRuqL07mz1GUIP+mpfT7PDsFFF4IyQ4BVHFlHyM+WCVwrz/fsaUte+2ULGkfSn2DZWs5xTjLd+2xpN0I+TbrkIM4NqI5e1RSYnMB9IM2zChMF9+6G6uWDo0O6BD0eBOLLWaXhL0Ofil+c9h4aZ+7XRBPmVYVwKMeRSro8Xq0zoZA3F1TFvnoM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb8ecd6-2678-4df0-d8fd-08dde580b702
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 15:45:14.6103
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Xat/Sj5e7LgEQgbwJ8USz8BVbv3xGXR10CtdBZdtLyTxnaOvxq3qoelUbKJSoG/pNiIrP7oslpLsXJ7hTcbF3RRLhBxP5gw3sSvN6NSZ0I=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7767
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-27_04,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=864 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508270135
X-Proofpoint-GUID: woEI_chs_0SajFIi6H8dgWsJIs-DTyRq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxNCBTYWx0ZWRfX1I+eQDnJ1xm9
 Ma94RGIAcvxQpgdb71z6JNJlIJPV4ZHmwI0iVslfH/kUxti1cU2VAYnATcnnKcDciw+pFU6R6uP
 Izx9wzJovdK/jbflnCtzFbMx3OQGGpqdMam7rcN1V0Xvt8qHV13HIMSe9H1p1CjC8D2PssMOj4t
 QeEfw0Id+yh4TQXbJty0d+y/3Cle6z5VtagNwk6//K/fyXhaRPNEPfdI/gluanSQ/AfzDWXkJfZ
 GA14vn8lpU4r5COIjDeZ5z0scLC6WziQdfvkBpyjYzvAesT3k9pospZO3qrNZxANmUfZSlyo3gq
 wHPu5yysHKmcNxbJoUrgJ2WmQTLDJtW1UWzazq0Z5Sg212GvbfkZKfFbfjBZY6oI4tao7oOrXWn
 1yFWRke8siqSvR3mhrr3ji1U1t2eXg==
X-Authority-Analysis: v=2.4 cv=FtgF/3rq c=1 sm=1 tr=0 ts=68af280f b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=TklJQYSr8e24bXoXTaYA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: woEI_chs_0SajFIi6H8dgWsJIs-DTyRq

On Tue, Aug 26, 2025 at 03:19:42PM +0800, Yafang Shao wrote:
> Every VMA must have an associated mm_struct, and it is safe to access

Err this isn't true? Pretty sure special VMAs don't have that set.

> outside of RCU. Thus, we can mark it as trusted. With this change, BPF
> helpers can safely access vma->vm_mm to retrieve the associated task
> from the VMA.

On the basis of above don't think this is valid.

>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  kernel/bpf/verifier.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
> index c4f69a9e9af6..984ffbca5cbe 100644
> --- a/kernel/bpf/verifier.c
> +++ b/kernel/bpf/verifier.c
> @@ -7154,6 +7154,10 @@ BTF_TYPE_SAFE_TRUSTED(struct file) {
>  	struct inode *f_inode;
>  };
>
> +BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct) {
> +	struct mm_struct *vm_mm;
> +};
> +
>  BTF_TYPE_SAFE_TRUSTED_OR_NULL(struct dentry) {
>  	struct inode *d_inode;
>  };
> @@ -7193,6 +7197,7 @@ static bool type_is_trusted(struct bpf_verifier_env *env,
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct bpf_iter__task));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct linux_binprm));
>  	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct file));
> +	BTF_TYPE_EMIT(BTF_TYPE_SAFE_TRUSTED(struct vm_area_struct));
>
>  	return btf_nested_type_is_trusted(&env->log, reg, field_name, btf_id, "__safe_trusted");
>  }
> --
> 2.47.3
>


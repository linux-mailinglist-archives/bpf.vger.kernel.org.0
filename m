Return-Path: <bpf+bounces-68138-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78663B535AD
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 16:37:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11AF8AA5209
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 14:36:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55E49340DA2;
	Thu, 11 Sep 2025 14:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="k0khx+LM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="RvTKmoaU"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0406343D7F;
	Thu, 11 Sep 2025 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757601307; cv=fail; b=YNoE8FVa9d3AN47Jjt8+eGpgE3G+3TOrpTJxua23CbEqOdvArz+85/4u1YxHX0l8S99pKL7xNxOe/1N5pi7ELhhyr9XlCdiZmf6rIFnlFqrfGswbD/JOSlvudZpfXHuTJk/o/A/dcqAeEL3mDtk5GELpC/4Mc/Aj4LOIk7O63E0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757601307; c=relaxed/simple;
	bh=L5RK5Rc510I2OdTtjX9rhjeCBCo9scI3iA3lvfWbLcE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CgTtnfKVsvxZizaYCoUON7lGLbHdrR1kIQ1cdv55WzFiwK/dAOZsGTwrTJ3ugXaKeCBMW2uXq9kOiJDV7WUnpxcam9Lu2MX/g2UuINyw7+ulxOIK9eY8KCH2lfIenl2eDncahOYN5WBLlOwuUb7Ji7LTFw8dJF7rXVZHJ/xQurw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=k0khx+LM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=RvTKmoaU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDtlBm019593;
	Thu, 11 Sep 2025 14:34:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=5toIOah/2wNPm+vXmweZN2sthZ57GLihwAS3vuLZSZE=; b=
	k0khx+LMuqTz+paHZMnh0VttvMl/GvLliY4QhGmNnntS+obBNTIX+V8CVU0xmk9j
	cIQmt0W1l/j+TklmTC3HlAIjH3CdYVc64OG5M021x6x2PE2JMaKifJZGrasW3FHb
	QLpVjntuLbQC9lBtn3t19Yz32E3fcB84K2zszKyONXzztgap+YuU/guTaZ0zn8rS
	vQLU/qyeXmj6E7G5+yWTHY/32R60QTtgEK9qBgo+Hff2Zu1xhHczhksESSjZGQ3d
	OHFI6sIr3X1IpWhNAhbaCv4MMD2AhDok1yOwQ1KkoWgd0g3TJCJt0CE94AqENwtJ
	pCRfaXA2vtePmoiRSNcUIg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shxa25-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:34:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDX8x9030623;
	Thu, 11 Sep 2025 14:34:11 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2072.outbound.protection.outlook.com [40.107.95.72])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 490bdcg4t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 14:34:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYEn1jmuidJhUtLoKiMYkBjFzL3zfeGC1WJJoUhnMgeJnIWoMnarWU96x5uxMSC6eih5qszVVymcIaenQP+w0Rnzzs2EoOJoBan5ZXidxvWMQ2SDxP/ePVVsm/34Y+gSOEWcP2L/hfE/qypz3idIUyONlk69ZygQdn5pTqor2xG0o2W9XQ8dgRyStlNC5g4vtm8D1+cMGNCTUI72YyGSc9xFKMWzqw2lqjJyTG9ktsRfxghKMiRzkvQE/rS4P3H4oISvXGxyoKznmAgHOxp5LuJ9wc8Y6QODYe0E23iIBMDK6aCcWLfzHHuylN81yNZQqh8Opi5wdZWQHaPfINpFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5toIOah/2wNPm+vXmweZN2sthZ57GLihwAS3vuLZSZE=;
 b=DK06q8E+gZFTZ/v6AEjRi+q5D6uDwVANNw5+RadIbu5oGahDx085Kc1CrO+oxB3U2ZQ0KZPU7/2hxFFntsFVizS7e8YeyOKVZBrxOvg3tZ88spgCdPRE/Ft90Twe29ivH4c/6uwDUM5QKDtOKkZftHEbq+MLZXNahAtpUcojVjdezKf+o3sG9fHaxPKZOO+B1G8nPVNJQpk1KDTB5jrBQts/uy/JQwYQAS/dCUnzwHU56HzauifCxAYX6EXa2VK30y2CGk42FPjZ9sAK5KYgClJIAgFVHk2gJINZlznVlqXw55cUkl6GQEkuYgoV1djfDdNPC3AC/wjhTZa9FqRUeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5toIOah/2wNPm+vXmweZN2sthZ57GLihwAS3vuLZSZE=;
 b=RvTKmoaUN1isadmQFLGEdCFadJL3JN/mgmcY7LVhLRIYX2vbqUJjZTnGJ8TCbGj+tF1X/lQRg3xaUvgSPhK7vlL0VMv08FRAG8GV9iuR3Sjzqedj8E/yfCUA2N4FFqehOvCVc8pNdaAvFecPNBPYYbNowfYy4fZ8y5ucJzvZHPo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB7538.namprd10.prod.outlook.com (2603:10b6:208:44b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 14:33:12 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 14:33:11 +0000
Date: Thu, 11 Sep 2025 15:33:09 +0100
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
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <4d676324-adc6-4c4c-9d2b-a5e9725bcd6c@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-3-laoar.shao@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250910024447.64788-3-laoar.shao@gmail.com>
X-ClientProxiedBy: LO4P265CA0030.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ae::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB7538:EE_
X-MS-Office365-Filtering-Correlation-Id: 876e20fd-cec0-441d-1f93-08ddf1402291
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TExaZU9la3hDcitaaFVJMWlrR3lqK3hjSTlCUjZNcE40ckw1YnRLNmhlQXd2?=
 =?utf-8?B?Tkp5VzhkTm5PYU5xcTZRODcwdDRvalY3VmppVGlTT2NFWk14di9DZzZ0MWE2?=
 =?utf-8?B?K2YybnhXcmFoajVFYmRadkQrNHZCQk15OCszblVlU1NLazZPb1c4MEV0RHVR?=
 =?utf-8?B?djgzdFoyMlJ2eENNNWp6NDQ4bFNJU3lDQWpzSDhKOFNvVXB3NXNJWHVPT2xs?=
 =?utf-8?B?Sk9OQnAzL1B5SS9xODZtckVQcmhJYllTOW5WTnNidWxsN1p1bjFabERJcGlL?=
 =?utf-8?B?bVNINUp6UEU2MzFjUE1JSDJza08wQkd3bFpBYlcwSUZPb1BCT1Z6VDRhUDBF?=
 =?utf-8?B?SGczZXU0aDM5dnZsdy90U2x1aUNnamRoYUh4em1QTlMrMUZzbE0ya21Sdk1l?=
 =?utf-8?B?ODB3ODA4dnhKN016QkR6MVc1L1NVRVdsMTI5M0lxYUFrdmdRcGRyQ3dwbG9Y?=
 =?utf-8?B?SVNUVXYrVnl5RHFyRmpreVVBWDNCek03OUNqOFVrYWVjSEh5UlBkNTVZZEhI?=
 =?utf-8?B?cG5PU0R1VjJreGg2dm9MaWZSNlNheDBZUVkvcjF3cjIxSkdUbENUcW80dnJ4?=
 =?utf-8?B?S0FrYzZTa1pESmVGVzFpL3l4S0gvQ0FVSG9yMWp0Qk5lVEh4VDdRdzFUK2VK?=
 =?utf-8?B?RGY2Mjl2TFRKcjA3NC9kb3d2WDlKVW90cE4reGJDYjc1YUpuQTQ2T0ZHSEcz?=
 =?utf-8?B?c0d5ZGVHUW9vYzlycEU3MWYra0Y2ODg2YmhlRVZEWUxOWUZIOGd2ZS90V2lw?=
 =?utf-8?B?WkYxVlJjeUNaZU5saFlpM21hVFR0SmhKeFpZUGNDSHlGTERqdkJGM2JBQitC?=
 =?utf-8?B?aUh1Ym1CdjdaVXkrVmUwZ0p0dDNaN2g0cUprWkNjVk5sdTN2L0ZEcDJFd1d6?=
 =?utf-8?B?aVplRmhiRUg5NURGWTRBOXdVLzlNZGZZdFUwSDkzOXF1ZVZVcktJQzljZTJL?=
 =?utf-8?B?S0NmSWUxR2V1MEw5OGhlUGtVTUZ4cmFveG5RNFhzSlVJNDMyR0t5NGR1Q1M1?=
 =?utf-8?B?SGFRZ1RRRklvV2hIQTZocjZHNW4ydXE0a3hsU09OQjlWNlJIMTEzTlcza2p5?=
 =?utf-8?B?U2VhTkJJV3h3RkZ5ZVRWcWpXRjBSZW54YmZtcTE5QTR4WS9mc3BWb1dIZjMv?=
 =?utf-8?B?RVFZdjZoOThwbFErVGRVWnJQcStpeHNBVEVYSE1GbXIyZ2pmSWZJdTBmNWJh?=
 =?utf-8?B?cFlSUzdYNFMxeDNnd294SWRpTEFDODA5ZVBLVkNDMTFpdkJacHp3T1Q2aEJT?=
 =?utf-8?B?dXNwdXA1NWNTSlVwblhyc1cyMGN0Z2puWXRVc0NWa3pkQ0RpanZjMlFEbVlZ?=
 =?utf-8?B?T1JhWUxmNUFxbEJTTWtRdXRWN2JweFY0L0pFYVR2d1F2dWlDYzRUbVlSRmNr?=
 =?utf-8?B?UzJjS1daNWVXc0EzeTAwa1RvanRkTVZ6ZXJDNmh0TzFGZHBoang1bUZwOWx3?=
 =?utf-8?B?aWpjVGdXcGc2NUZFejhRWkJ1V1A5dGdIeWREZlhacjJhWUFjdm1qbUY0dkc3?=
 =?utf-8?B?VndGRVg1dEg2OU1tNUpMaStETUMzcFZBZG1kYlZtUE1LYkh4SkFHUjhydlNx?=
 =?utf-8?B?SGV3WGlMMmZRaHVPcEwvdlJLTGg2eWFCMlVNYy8yYUNQSDdHejAwbXc1dTVt?=
 =?utf-8?B?YU5SR21MUmxGTktGR1BFQWd3cU9KQ2N4U3JHc0ZPdFNFcGQzdWkyVGlmekdH?=
 =?utf-8?B?R3R5Sk90NC9xUno4bm9HSXBHVCtSdkIwWVBRYnBncE1CQ3IyajJSK2NRYXc0?=
 =?utf-8?B?YjVsRzVINThyM0dpdEtvaThSc3d6d0Z4MDgvUGVvaTZkeFhLbnYrQUs1TG9H?=
 =?utf-8?B?NS8wbUdMdXNIdXFuaG5sR2g5bUdkQUx5UW1EMUtPM3lsSlBlRGhOQlJSUk9P?=
 =?utf-8?B?THFUdDQzeUFYRGNDNDhwbzZ1WllZeVgxSVFiZkxKK3BtbmphUWJ3dFFBaGxE?=
 =?utf-8?Q?M0YmFz7pVIk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M3k2Ni9YMGZxY1hFSUFMaUFIMXk2KzRvcURWR1d2RTdzRU9TMGFCSmQ5WWcy?=
 =?utf-8?B?dzZYalN6d3hsM2RMR2lmdmNKT1FaYkxzN1oybExSZzlOQmNEeWo1S2pJZ205?=
 =?utf-8?B?eUsvMHJGenJ4TU1MczAyZmFVZmp0TUw1ZU5lZDVaY1ZLYUswOFFZOFNFRUNW?=
 =?utf-8?B?cGptSzVjTnBJVWNMZ00xWTc0d05oQWpmdzhHbFA3d1pNUWxPWmFuWFBESnJv?=
 =?utf-8?B?TXZ5V2xvbkEvNXNWNzdIVjZhYjAvS3Q5MWxIbXlHYTBsckJ0Q1dRQjByZlNV?=
 =?utf-8?B?NW03K01yS2dzTjRZU29sNTUwMUJOTU9tZy9wTHdUWXBGZE9xbU9iMWI2aWx2?=
 =?utf-8?B?TmgwdjJWb0FGakVxcGkzYUFFOGptZU1PU0tXdzRNZzYyd3F2S3RMSWQ5eDZV?=
 =?utf-8?B?RlhoUTBxUm1ZQm50QW1rdzVWYWdaUFpnd3VyZmh1aWNDekpXWkRKVTkzS1hr?=
 =?utf-8?B?MmRITThoR1VWb3JCdHFVM3FQY3lCOUh6SW1IQzBjWmNrZ09MOEFuN3Y2enpU?=
 =?utf-8?B?dkJJZkpDY2dvOGR2QXI3TzlIRzdjdWhZR0o0VmJsUVg4Mk1zcWY2MUh2R3RQ?=
 =?utf-8?B?MDcyTTFnb0VkME40clM5SWtOWkxYMzRHcktJRUxBTStvMEhaQjQweHN5Nm9N?=
 =?utf-8?B?VlJhT1hjRVhtQ1AxVkVWZTQ2K0dSQmNaK0d2QUtoN1FoVFNFdUd3eUJPYkZF?=
 =?utf-8?B?a0xieHY4eElobmFKcHdPTlEwK3QwZ2RPREtDb3N4ZmFDanRiblBRK09oM1BU?=
 =?utf-8?B?Q3c3aTl3OGtYOXZYOUlhbkN0QTBLeUxtU0pLQno5eEl0MDlZeEJRbmhxVGYy?=
 =?utf-8?B?aE8xaGZEWHN1QkUrc0grdW5hNzdXTjdBb2dnSTR2YXB2T1dzS1ZxY0FUYVRo?=
 =?utf-8?B?bjRmOHdjVGxRaHJFRE1HaU1OdmJTb0FMa21yVmJrbThQVjFzUEY3bkw2Wnov?=
 =?utf-8?B?UEM3NUY3c3RHOFB1OU5DNGNGTVJwZzNSSTBtS1o3a0VrRTc0akVDRitHZWhW?=
 =?utf-8?B?Z2hWNW9uRDltNmNuNkNGM2ttcjNPOEtwRTVHOHE3VUdOSHZMWGovRUtyS25Z?=
 =?utf-8?B?LzcyMTcrdWhDQ0JMUElxcHpJekt4bVhHckVYMXdoTWU1MDhQQW5MWE9JblR2?=
 =?utf-8?B?L0xOMUswcnBxWXJKdWpYblloZ1NtekFha0tjUExmaUN4cjVGNkxmZVZWZm1u?=
 =?utf-8?B?c0JWNnFTblJWL2xuOVE2Y2dYcGljUElDdDA4S2EweUkwQzhvcjVlSGdXcXpl?=
 =?utf-8?B?SFlldVJMcEJ6bjRWMEpZSk9Vcm9lS0ZiY0JuUlErNzdpdjQrVzE3dlJIbEJs?=
 =?utf-8?B?RjhQRHhMK0krczR3aHFkcXNiRnhVbDhvL2QvRE0yTlZjVUdpYVhacmhhUDY1?=
 =?utf-8?B?a3EwcDBXdXd3Z0NzUjVmdnI1SHBiQ0JncEh0OGExWVV3UlRxajJtdkkyTVhT?=
 =?utf-8?B?ZW5NRW45Um5qUE0xODVJdHJESlJaeTFXektDNC9BVksxYjZuL3pFc2Yvamhj?=
 =?utf-8?B?Unc5U0toUWhmVXpBUjN3N3JMeGdNTE05djZJQU93Y1gvSVpqYTFSVWtIZkV5?=
 =?utf-8?B?Ulo2cjQyL3RiWjg0WVk0OGJtZm54SlRxaW5SbWlXQUdWb2RjQmE0WTNCUHNo?=
 =?utf-8?B?UVVOQ29QditDNy9VL3AwaWdOUkhtQXkyMFZzeTk1VklnVm01Y21TMDEwWW9K?=
 =?utf-8?B?Um5acTBkcURKNCt4a2ZsSXpiK1JkeEtaUldvcTM4bDFzRzQvaStRRWQyOTEx?=
 =?utf-8?B?K2VnWTVyaEt1aXpBRmpvdys1ejlid3VKQmFZaVFRWmdhUm5pWmtyQ09IU0xy?=
 =?utf-8?B?VklJL0h0bXZvVVlMeWVpQk5sZWcrV1o0c0pKN0ZIMHIrSmQvQkU4eE5tTm5E?=
 =?utf-8?B?MTJVbElYd0F0OFNNN2R3Q1BDaWFkZWNTeVR2ZSthRWFWZzhNR1dkYWx0NmRC?=
 =?utf-8?B?ZldHdUU1ZDl0TzBVeDhHb1N5M1kvenMrc3R1MUREdnFFUldiR3k5MFUwY1Rv?=
 =?utf-8?B?Q2Nnc01lbUIwalk4UWtwOFNxNFE2ell1UkY2Tm9haVlLRGJJM1R1eUdlVklP?=
 =?utf-8?B?cmVqczlDTkI0dE9kRG5EWExLNStwWmE0OXZyTlhqS01WQUcvY0hwTGFRckR1?=
 =?utf-8?B?aEsxdjc0WWNvQWdrZTdCQkJJb2JjQVEwYThLSmtGT1haOXRpL0RrVW5MQllV?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZFpLi/Qi1BypZHgDbkxQ8QB/qsV3TCsnMTvJOpxGtn2NW7Kt2PDjW0oTa1CkxkGyOIjvSITO+BmlLP2J1kki6SPTZrsaW/ItvQLffvHciWPTcpME/jHulC51GsyAMb1jFQ+yHaLnDa56Y77gH8sBfkiyJmV+CMDqaUPc90mdmq+PBgN5/8bBVijOFxwZ+asgH0Dq+rfQ8JeVnA5pTsQ1p8EFW+arupmK3FKPnBaSdk0uqSSAgtbIfDWhV3nivkChWF3XenFdtIsIqHmXj6bTxevD2LH3OdLaf51UMRl//P6ROL7HTdxGxY7mKuPw+Sak7iQU+b3DvRNaRmF9DcO7qhxEDdZRwP6vD9mrqT91EswCCwxvTkq/rbtqphHsLykvcnatvbK7FGyCZ7Wq6LPLYzJ+rCYfxn0IL8wVeqDbi04e3xwQIs6sMj1Eq08TeLmBhb1kACHJ7rGZCSIRAAnMxDFm3hnM565ALwLo/wz7JUhsOLOerfmTTINr7F1pAjjzsthJdX7njOkdwnn8Rz6AQE+cWgG54xF4vH0ax2/Z8GgrhvWFy1cSIqGIeyNQXwJIlObE8hmM2MacMNisHn8YVA8mL9YjR2tFBkDXdZYxTFI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 876e20fd-cec0-441d-1f93-08ddf1402291
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 14:33:11.8319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GW0FsPOSE+2+SGKXsWTIs875F1OcJ154dNYh0/At/V7iIsgFdYUyKqARPNXLSuOIz4NE7dj4Zu8HnT1qsivuiQNUtIqQJsxWebFA3dnH+VY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7538
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509110128
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c2dde4 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=pGLkceISAAAA:8 a=C4rHJTz6X3AyEP4uSZ8A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX/nLd0cZvbA9I
 jOJVHathAAHzyreF6ndhTswkkyD3cL4WGU8A+KSEfLIUUHDuIBNYCOxnRaakcojkmxZ9Sb7ZjQs
 G8kunMDcBXOWSs0i/Yjl2Zilioc9iIKaUYyJqQeABoLGq/UXD2iXLjy/9baEYfPMqV1H7Qysfpl
 +EhHjw9jrCo0FmXSkKKpCb24K++VKH2ME1e9QEu0xPC3xerNYraJYRpB1ujRkPBPZb1qANJM+gf
 n1chuNIG+7hbBifJGbGSqepfIdEjj6dxDfRd7eKsaNsJ0AjSTEvzYUxvVHYhoM2GdFU1ZPgg7mZ
 5zJ0lkY/dYkUS8iYsbCIgdvavzNTaiiwm9/fUOqcNNXtTexjpsPW8qA+JLVZ7eHXHVGsmW//vGP
 W/rEHRNG
X-Proofpoint-GUID: iTeKRm6JKGk6670427SFN0ArRgtTe27b
X-Proofpoint-ORIG-GUID: iTeKRm6JKGk6670427SFN0ArRgtTe27b

On Wed, Sep 10, 2025 at 10:44:39AM +0800, Yafang Shao wrote:
> This patch introduces a new BPF struct_ops called bpf_thp_ops for dynamic
> THP tuning. It includes a hook bpf_hook_thp_get_order(), allowing BPF
> programs to influence THP order selection based on factors such as:
> - Workload identity
>   For example, workloads running in specific containers or cgroups.
> - Allocation context
>   Whether the allocation occurs during a page fault, khugepaged, swap or
>   other paths.
> - VMA's memory advice settings
>   MADV_HUGEPAGE or MADV_NOHUGEPAGE
> - Memory pressure
>   PSI system data or associated cgroup PSI metrics
>
> The kernel API of this new BPF hook is as follows,
>
> /**
>  * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation
>  * @vma: vm_area_struct associated with the THP allocation
>  * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
>  *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
>  *            neither is set.
>  * @tva_type: TVA type for current @vma
>  * @orders: Bitmask of requested THP orders for this allocation
>  *          - PMD-mapped allocation if PMD_ORDER is set
>  *          - mTHP allocation otherwise
>  *
>  * Return: The suggested THP order from the BPF program for allocation. It will
>  *         not exceed the highest requested order in @orders. Return -1 to
>  *         indicate that the original requested @orders should remain unchanged.
>  */
> typedef int thp_order_fn_t(struct vm_area_struct *vma,
> 			   enum bpf_thp_vma_type vma_type,
> 			   enum tva_type tva_type,
> 			   unsigned long orders);
>
> Only a single BPF program can be attached at any given time, though it can
> be dynamically updated to adjust the policy. The implementation supports
> anonymous THP, shmem THP, and mTHP, with future extensions planned for
> file-backed THP.
>
> This functionality is only active when system-wide THP is configured to
> madvise or always mode. It remains disabled in never mode. Additionally,
> if THP is explicitly disabled for a specific task via prctl(), this BPF
> functionality will also be unavailable for that task.
>
> This feature requires CONFIG_BPF_GET_THP_ORDER (marked EXPERIMENTAL) to be
> enabled. Note that this capability is currently unstable and may undergo
> significant changes—including potential removal—in future kernel versions.

Thanks for highlighting.

>
> Suggested-by: David Hildenbrand <david@redhat.com>
> Suggested-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> ---
>  MAINTAINERS             |   1 +
>  include/linux/huge_mm.h |  26 ++++-
>  mm/Kconfig              |  12 ++
>  mm/Makefile             |   1 +
>  mm/huge_memory_bpf.c    | 243 ++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 280 insertions(+), 3 deletions(-)
>  create mode 100644 mm/huge_memory_bpf.c
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8fef05bc2224..d055a3c95300 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16252,6 +16252,7 @@ F:	include/linux/huge_mm.h
>  F:	include/linux/khugepaged.h
>  F:	include/trace/events/huge_memory.h
>  F:	mm/huge_memory.c
> +F:	mm/huge_memory_bpf.c

THanks!

>  F:	mm/khugepaged.c
>  F:	mm/mm_slot.h
>  F:	tools/testing/selftests/mm/khugepaged.c
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 23f124493c47..f72a5fd04e4f 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -56,6 +56,7 @@ enum transparent_hugepage_flag {
>  	TRANSPARENT_HUGEPAGE_DEFRAG_REQ_MADV_FLAG,
>  	TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG,
>  	TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG,
> +	TRANSPARENT_HUGEPAGE_BPF_ATTACHED,      /* BPF prog is attached */
>  };
>
>  struct kobject;
> @@ -270,6 +271,19 @@ unsigned long __thp_vma_allowable_orders(struct vm_area_struct *vma,
>  					 enum tva_type type,
>  					 unsigned long orders);
>
> +#ifdef CONFIG_BPF_GET_THP_ORDER
> +unsigned long
> +bpf_hook_thp_get_orders(struct vm_area_struct *vma, vm_flags_t vma_flags,
> +			enum tva_type type, unsigned long orders);

Thanks for renaming!

> +#else
> +static inline unsigned long
> +bpf_hook_thp_get_orders(struct vm_area_struct *vma, vm_flags_t vma_flags,
> +			enum tva_type tva_flags, unsigned long orders)
> +{
> +	return orders;
> +}
> +#endif
> +
>  /**
>   * thp_vma_allowable_orders - determine hugepage orders that are allowed for vma
>   * @vma:  the vm area to check
> @@ -291,6 +305,12 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  				       enum tva_type type,
>  				       unsigned long orders)
>  {
> +	unsigned long bpf_orders;
> +
> +	bpf_orders = bpf_hook_thp_get_orders(vma, vm_flags, type, orders);
> +	if (!bpf_orders)
> +		return 0;

I think it'd be easier to just do:

	/* The BPF-specified order overrides which order is selected. */
	orders &= bpf_hook_thp_get_orders(vma, vm_flags, type, orders);
	if (!orders)
		return 0;

> +
>  	/*
>  	 * Optimization to check if required orders are enabled early. Only
>  	 * forced collapse ignores sysfs configs.
> @@ -304,12 +324,12 @@ unsigned long thp_vma_allowable_orders(struct vm_area_struct *vma,
>  		    ((vm_flags & VM_HUGEPAGE) && hugepage_global_enabled()))
>  			mask |= READ_ONCE(huge_anon_orders_inherit);
>
> -		orders &= mask;
> -		if (!orders)
> +		bpf_orders &= mask;
> +		if (!bpf_orders)
>  			return 0

With my suggeted change this would remain the same.

>  	}
>
> -	return __thp_vma_allowable_orders(vma, vm_flags, type, orders);
> +	return __thp_vma_allowable_orders(vma, vm_flags, type, bpf_orders);

With my suggeted change this would remain the same.

>  }
>
>  struct thpsize {
> diff --git a/mm/Kconfig b/mm/Kconfig
> index d1ed839ca710..4d89d2158f10 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -896,6 +896,18 @@ config NO_PAGE_MAPCOUNT
>
>  	  EXPERIMENTAL because the impact of some changes is still unclear.
>
> +config BPF_GET_THP_ORDER

Yeah, I think we maybe need to sledgehammer this as already Lance was confused
as to the permenancy of this, and I feel that users might be too, even with the
'(EXPERIMENTAL)' bit.

So maybe

config BPF_GET_THP_ORDER_EXPERIMENTAL

Just to hammer it home?

> +	bool "BPF-based THP order selection (EXPERIMENTAL)"
> +	depends on TRANSPARENT_HUGEPAGE && BPF_SYSCALL
> +
> +	help
> +	  Enable dynamic THP order selection using BPF programs. This
> +	  experimental feature allows custom BPF logic to determine optimal
> +	  transparent hugepage allocation sizes at runtime.
> +
> +	  WARNING: This feature is unstable and may change in future kernel
> +	  versions.
> +
>  endif # TRANSPARENT_HUGEPAGE
>
>  # simple helper to make the code a bit easier to read
> diff --git a/mm/Makefile b/mm/Makefile
> index 21abb3353550..f180332f2ad0 100644
> --- a/mm/Makefile
> +++ b/mm/Makefile
> @@ -99,6 +99,7 @@ obj-$(CONFIG_MIGRATION) += migrate.o
>  obj-$(CONFIG_NUMA) += memory-tiers.o
>  obj-$(CONFIG_DEVICE_MIGRATION) += migrate_device.o
>  obj-$(CONFIG_TRANSPARENT_HUGEPAGE) += huge_memory.o khugepaged.o
> +obj-$(CONFIG_BPF_GET_THP_ORDER) += huge_memory_bpf.o
>  obj-$(CONFIG_PAGE_COUNTER) += page_counter.o
>  obj-$(CONFIG_MEMCG_V1) += memcontrol-v1.o
>  obj-$(CONFIG_MEMCG) += memcontrol.o vmpressure.o
> diff --git a/mm/huge_memory_bpf.c b/mm/huge_memory_bpf.c
> new file mode 100644
> index 000000000000..525ee22ab598
> --- /dev/null
> +++ b/mm/huge_memory_bpf.c
> @@ -0,0 +1,243 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * BPF-based THP policy management
> + *
> + * Author: Yafang Shao <laoar.shao@gmail.com>
> + */
> +
> +#include <linux/bpf.h>
> +#include <linux/btf.h>
> +#include <linux/huge_mm.h>
> +#include <linux/khugepaged.h>
> +
> +enum bpf_thp_vma_type {
> +	BPF_THP_VM_NONE = 0,
> +	BPF_THP_VM_HUGEPAGE,	/* VM_HUGEPAGE */
> +	BPF_THP_VM_NOHUGEPAGE,	/* VM_NOHUGEPAGE */
> +};

I'm really not so sure how useful this is - can't a user just ascertain this
from the VMA flags themselves?

Let's keep the interface as minimal as possible.

> +
> +/**
> + * @thp_order_fn_t: Get the suggested THP orders from a BPF program for allocation

orders -> order?

> + * @vma: vm_area_struct associated with the THP allocation
> + * @vma_type: The VMA type, such as BPF_THP_VM_HUGEPAGE if VM_HUGEPAGE is set
> + *            BPF_THP_VM_NOHUGEPAGE if VM_NOHUGEPAGE is set, or BPF_THP_VM_NONE if
> + *            neither is set.

Obv as above let's drop this probably :)

> + * @tva_type: TVA type for current @vma
> + * @orders: Bitmask of requested THP orders for this allocation

Shouldn't requested = available?

> + *          - PMD-mapped allocation if PMD_ORDER is set
> + *          - mTHP allocation otherwise

Not sure these 2 points are super useful.

> + *
> + * Return: The suggested THP order from the BPF program for allocation. It will
> + *         not exceed the highest requested order in @orders. Return -1 to
> + *         indicate that the original requested @orders should remain unchanged.
> + */
> +typedef int thp_order_fn_t(struct vm_area_struct *vma,
> +			   enum bpf_thp_vma_type vma_type,
> +			   enum tva_type tva_type,
> +			   unsigned long orders);
> +
> +struct bpf_thp_ops {
> +	thp_order_fn_t __rcu *thp_get_order;
> +};
> +
> +static struct bpf_thp_ops bpf_thp;
> +static DEFINE_SPINLOCK(thp_ops_lock);
> +
> +/*
> + * Returns the original @orders if no BPF program is attached or if the
> + * suggested order is invalid.
> + */
> +unsigned long bpf_hook_thp_get_orders(struct vm_area_struct *vma,
> +				      vm_flags_t vma_flags,
> +				      enum tva_type tva_type,
> +				      unsigned long orders)
> +{
> +	thp_order_fn_t *bpf_hook_thp_get_order;
> +	unsigned long thp_orders = orders;
> +	enum bpf_thp_vma_type vma_type;
> +	int thp_order;
> +
> +	/* No BPF program is attached */
> +	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +		      &transparent_hugepage_flags))
> +		return orders;
> +
> +	if (vma_flags & VM_HUGEPAGE)
> +		vma_type = BPF_THP_VM_HUGEPAGE;
> +	else if (vma_flags & VM_NOHUGEPAGE)
> +		vma_type = BPF_THP_VM_NOHUGEPAGE;
> +	else
> +		vma_type = BPF_THP_VM_NONE;

As per above, not sure this is all that useful.

> +
> +	rcu_read_lock();
> +	bpf_hook_thp_get_order = rcu_dereference(bpf_thp.thp_get_order);
> +	if (!bpf_hook_thp_get_order)
> +		goto out;
> +
> +	thp_order = bpf_hook_thp_get_order(vma, vma_type, tva_type, orders);
> +	if (thp_order < 0)
> +		goto out;
> +	/*
> +	 * The maximum requested order is determined by the callsite. E.g.:
> +	 * - PMD-mapped THP uses PMD_ORDER
> +	 * - mTHP uses (PMD_ORDER - 1)

I don't think this is quite right, highest_order() figures out the highest set
bit, so mTHP can be PMD_ORDER - 1 or less (in theory ofc).

I think we can just replace this with something simpler like - 'depending on
where the BPF hook is invoked, we check for either PMD order or mTHP orders
(less than PMD order)' or something.

> +	 *
> +	 * We must respect this upper bound to avoid undefined behavior. So the
> +	 * highest suggested order can't exceed the highest requested order.
> +	 */

I think this sentence is also unnecessary.

> +	if (thp_order <= highest_order(orders))
> +		thp_orders = BIT(thp_order);
> +
> +out:
> +	rcu_read_unlock();
> +	return thp_orders;
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
> +static int bpf_thp_check_member(const struct btf_type *t,
> +				const struct btf_member *member,
> +				const struct bpf_prog *prog)
> +{
> +	/* The call site operates under RCU protection. */
> +	if (prog->sleepable)
> +		return -EINVAL;
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
> +	WARN_ON_ONCE(rcu_access_pointer(bpf_thp.thp_get_order));
> +	rcu_assign_pointer(bpf_thp.thp_get_order, ops->thp_get_order);
> +	spin_unlock(&thp_ops_lock);
> +	return 0;
> +}
> +
> +static void bpf_thp_unreg(void *kdata, struct bpf_link *link)
> +{
> +	thp_order_fn_t *old_fn;
> +
> +	spin_lock(&thp_ops_lock);
> +	clear_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED, &transparent_hugepage_flags);
> +	old_fn = rcu_replace_pointer(bpf_thp.thp_get_order, NULL,
> +				     lockdep_is_held(&thp_ops_lock));
> +	WARN_ON_ONCE(!old_fn);
> +	spin_unlock(&thp_ops_lock);
> +
> +	synchronize_rcu();
> +}
> +
> +static int bpf_thp_update(void *kdata, void *old_kdata, struct bpf_link *link)
> +{
> +	thp_order_fn_t *old_fn, *new_fn;
> +	struct bpf_thp_ops *old = old_kdata;
> +	struct bpf_thp_ops *ops = kdata;
> +	int ret = 0;
> +
> +	if (!ops || !old)
> +		return -EINVAL;
> +
> +	spin_lock(&thp_ops_lock);
> +	/* The prog has aleady been removed. */
> +	if (!test_bit(TRANSPARENT_HUGEPAGE_BPF_ATTACHED,
> +		      &transparent_hugepage_flags)) {
> +		ret = -ENOENT;
> +		goto out;
> +	}
> +
> +	new_fn = rcu_dereference(ops->thp_get_order);
> +	old_fn = rcu_replace_pointer(bpf_thp.thp_get_order, new_fn,
> +				     lockdep_is_held(&thp_ops_lock));
> +	WARN_ON_ONCE(!old_fn || !new_fn);
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
> +	if (!ops->thp_get_order) {
> +		pr_err("bpf_thp: required ops isn't implemented\n");
> +		return -EINVAL;
> +	}
> +	return 0;
> +}
> +
> +static int bpf_thp_get_order(struct vm_area_struct *vma,
> +			     enum bpf_thp_vma_type vma_type,
> +			     enum tva_type tva_type,
> +			     unsigned long orders)
> +{
> +	return -1;
> +}
> +
> +static struct bpf_thp_ops __bpf_thp_ops = {
> +	.thp_get_order = (thp_order_fn_t __rcu *)bpf_thp_get_order,
> +};
> +
> +static struct bpf_struct_ops bpf_bpf_thp_ops = {
> +	.verifier_ops = &thp_bpf_verifier_ops,
> +	.init = bpf_thp_init,
> +	.check_member = bpf_thp_check_member,
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
> +	int err;
> +
> +	err = register_bpf_struct_ops(&bpf_bpf_thp_ops, bpf_thp_ops);
> +	if (err)
> +		pr_err("bpf_thp: Failed to register struct_ops (%d)\n", err);
> +	return err;
> +}
> +late_initcall(bpf_thp_ops_init);
> --
> 2.47.3
>


Return-Path: <bpf+bounces-73795-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A55C39930
	for <lists+bpf@lfdr.de>; Thu, 06 Nov 2025 09:27:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 469E71A205F6
	for <lists+bpf@lfdr.de>; Thu,  6 Nov 2025 08:27:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8993019D8;
	Thu,  6 Nov 2025 08:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aaf1SSpC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PHseMNR4"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE3F301709;
	Thu,  6 Nov 2025 08:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762417623; cv=fail; b=bz9zW+OYN5B7QexOZlhugvswZ1ByntPXXlgP9UgDqGlpPVpD5gtm2tXG7ThBIT5rFmrJ64D7tZOEUyzl6MZhJtRGb/ARRlL+aofeIwS4k2GArhfhb5D5OIYz+yA2tVL/+tT3ml+rz7L90fs+mMD/Nvmaf7BDaILmVj3J5T0exVg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762417623; c=relaxed/simple;
	bh=lskud/HZzJSitCV3P3ObAzADcYUQ5GJy4UbrKq7+dAI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=TxPwK+RNHs8yoUB4ODUgOqv130Ys0Wi7TycX6qkY1gUPTraalf9Jjsbvh1Qsn/sShc+xVSm8+V4/Flye/4rNcUboDaiZDuM1CCDeehb0iW+GBUPnu49YsPPRJ8cxWeIucXC2jtfLnptt59/npA9aKg99ZhZjOj/zmb04lDdRiPw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aaf1SSpC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PHseMNR4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A61CRVi017516;
	Thu, 6 Nov 2025 08:26:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=swOv+Yn1cxtMZAW9I9
	RVf54ZT6xLc2DI99gSCCPv5nY=; b=aaf1SSpCOPI7o5umh/sq5DuvZPuhDNCNQ0
	orCXW0G0IQIF2xAHfPK8XY1pl78k5RREszVhBtUSYhnVaRQ1cmI/NtE276Tiv/In
	Zhp94CZggbpgVZLmSatHOF+RdqKFz9yOS1p1mzUmycKpu2hYtMh5wHnfS/YGc44g
	k4lsgkkMx2sj73GGYeelF1jgDDna0ZPArQ8jzgMWt1YOQsQHE0N5sNY6kHOhXzb4
	bplW0zih0e1vImPFcdTM+BPllRHgpwJo7Fk8BsRHP/3LRwEIQ3JvjV9iX+XGP/e6
	xDq4hcXuPi4nQs/uEI9PFf9VtyqkuPmd5gu20ObKXysEYV2XZuIQ==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aejshs2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 08:26:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A67Ic7j023183;
	Thu, 6 Nov 2025 08:26:32 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013014.outbound.protection.outlook.com [40.93.196.14])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nfna8w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Nov 2025 08:26:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jo8GPPi51TRDt4t05Khp4jiZDkDbLKuvyZgGbymc937vIxkvZsz+35UWl6liMiA5tAKU3OdJBpseh42AQn0g9ZGhF/NvFmvfo18k1cPp8U8AzHWjf4LRiVhsqairK726C7XUKHZLWTJjGu01VD4OyB+HBjaIiMAlReHfV+W9VmAaiN+sdWYyBZ2v7gViE8dbLQ1kzHjOtKpWcTt8gONsDHa8i9nxvWZj2b7FK8lexwnkqQM0RrjiR+I/FJ8Xg06f39D66kQN+2+932Rs5RUEc9WmolGeH8xsGlFZVX6xpZ+RJhkUKNklDfwTGBcmDG99/H8+mbrsoRH4MIYbSap3Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=swOv+Yn1cxtMZAW9I9RVf54ZT6xLc2DI99gSCCPv5nY=;
 b=i73BQCp/AXcrFWDMdFOkQJpTi953oDeNGZL72NqNy3JGSSya4Oo8TTbzHXdAmsh4WDVcoc+W8/wle6sRtw4Fvmwa0vKOumpo8el7eqOGI88Lu0nbKOKpCTfWbOwBoQ80szVIQKHgu2ra7JkImLmvPrEOpdiaXX9RlBWpaxOhAl9Py8v3aqqNf8D3pyfBBrUs8CZae96QWPMLqzNqwMStF36R4W0zL++ROboA7dzYHoArh/Gs+G0Xo0yYPNPVSPyru1Eo5meXm7Qb9QQsi2ed193TE8AE3Yj7u27oph5BFPF/XafKMsFFjhJ8+ika2/+/8G4qkxdo+E6AuBIn/UBctw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=swOv+Yn1cxtMZAW9I9RVf54ZT6xLc2DI99gSCCPv5nY=;
 b=PHseMNR4ZKRvXxuhHVWPSbWZR7SpMGNsiNbcEwjd+dnBeeikAs8mWHjWbDKL0oEE7Y6A5Ga4CGxQT7wHAQGBfmPn3YS9wyN5O94BnnG9Usk3jiYUJdgQy3HkSc4FceLo6TIbr1Cv2y3+zzKNLBebgi8WKj+505sRngXFdj2QYSI=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by SJ2PR10MB7760.namprd10.prod.outlook.com (2603:10b6:a03:574::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Thu, 6 Nov
 2025 08:26:28 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%5]) with mapi id 15.20.9298.007; Thu, 6 Nov 2025
 08:26:27 +0000
Date: Thu, 6 Nov 2025 17:26:15 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@gentwo.org>,
        David Rientjes <rientjes@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Alexei Starovoitov <ast@kernel.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org,
        kasan-dev@googlegroups.com
Subject: Re: [PATCH 1/5] slab: make __slab_free() more clear
Message-ID: <aQxbp0cikSkiON5M@harry>
References: <20251105-sheaves-cleanups-v1-0-b8218e1ac7ef@suse.cz>
 <20251105-sheaves-cleanups-v1-1-b8218e1ac7ef@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251105-sheaves-cleanups-v1-1-b8218e1ac7ef@suse.cz>
X-ClientProxiedBy: SL2P216CA0148.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:35::19) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|SJ2PR10MB7760:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e0d1b2-5590-44c7-b223-08de1d0e2e1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LxuA+olbTjM0JnlNRbDnrNWn4F0NeFu1urkaEvhwEPtRAvvGKPl9sWcLmF4J?=
 =?us-ascii?Q?uxNFUcKOxgCm+CStNizir4xEzYst3YpFWa4jJxNc2Lfp8uKJoeDSt9w+oW8F?=
 =?us-ascii?Q?e7yi+LVcINJ7QLWzng9oOGa8kV3Z6TJaKJHQI29jcEgJcDyTxo0HEc+dKRyt?=
 =?us-ascii?Q?3JQAj0rMDanW+UlgkHnAW7fxMPMgNC+PMuTYJ3OQ/wrT3hHhvEUjoDlaRQ0E?=
 =?us-ascii?Q?ita/voamazkiWRbgMkEZoalsOTfaQmLX1iYVA/ti2emXCS0DdvnW2q9jApbW?=
 =?us-ascii?Q?J5ztGW0g+hvlPhHgzMRoqYfMblGMqqTGRgPD+Fpd2HfJFH1dB/GLxYH6I/np?=
 =?us-ascii?Q?rs6wW6+9j+O72gF9VOAudSUiJdiT7kU5uQ0H+k6MJBSf3AforxcvhfVP8r0h?=
 =?us-ascii?Q?i8ks9ibA7vaavO8t8RAq0eW7TKf9V1mHGHKkcdoqO4udhgfriB4KqpQp2E8i?=
 =?us-ascii?Q?u8WDDfmHJ624JV2jXraWkNoaIB6ZkodfV7UvP03ywzOJBDHSk1qmLIwsin6j?=
 =?us-ascii?Q?U6+MGDxUeIVIyhM4zmY6S8lRDuLNZx8NP+l/fa/OzqWx4txdupWAxxKacmyv?=
 =?us-ascii?Q?koXIXSYJfFodkvlCPABn4G49NxBhTewp75QMuOCoCly/PT9DSy73c01sx6d8?=
 =?us-ascii?Q?lR0msW6+Aqh6370+OYuWDxbyJgEyD/famqgc0tLpyZBPlt1JR8Xvj1PlanZF?=
 =?us-ascii?Q?mgQw6ZDbX46T1wmEt19HZ0idUBtftz7aKWdqIULZkA2XWX2XLIhEzmRyMQdA?=
 =?us-ascii?Q?YG9AzZMbvxrDj+WfzAgUgKZdXuT1jwcjj177jnUHNEYTaK2AMKARFf1gC0fF?=
 =?us-ascii?Q?eWx/ziogFLBiPe8MDwCs7v90fYM+KOo7XBvfw2Ks1XIeb4NioGJxcVylqzoE?=
 =?us-ascii?Q?oWvdpF3oAAKnDpmFaRlBFcZJG5T6YaJhaCC5B0RM16Nt7tsh4GAxS/VJa0Y7?=
 =?us-ascii?Q?RLeA/xQqqMXnj3dnu7YWdcMgW07D9VLm4B+6fQbpVN0ryUG7DgCraTawxgP4?=
 =?us-ascii?Q?Cbfp/b36NqpCsQXlZU4oOJE+4yo3K3DlS/rp4edacxyCT+ExRJ7HdXp/UQid?=
 =?us-ascii?Q?MtICYJpjd5V0pdcfJxtyq0FOV97Qdpfjqe6UQFFsWy2AltJr5oJZ7La3gKNC?=
 =?us-ascii?Q?aRRjR0WIeijOD2+IPbXSnmZTETJaVVDNlII1STUdWRKeXanzEwKMcwkjl5kB?=
 =?us-ascii?Q?eAfuvB0tgLfBzX7qrKuQwo2EyCs7jcm/RrSGyhxaQ5cELyrsbVJA1J05KPrp?=
 =?us-ascii?Q?+Vg1UHcFMwPezSnmeGYH44QtVzCEbnXPh+xVLV/vTTKpdf7ttM0RUutCjU+6?=
 =?us-ascii?Q?i2oBp2rnAYYT9XJChHI1L2Sf9rBwCI92mLY+DC6keIJUZYX30Es3nWdlIpjZ?=
 =?us-ascii?Q?oOzHB4IMw+55mi1ec7uIIF0r2bAjJY2z5CGidRItH2EaiaOdXs4x3feeBa07?=
 =?us-ascii?Q?/ez2H7QVZqTd/XhYd50ytMYPJ85FdVu0?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Fk3Ig+9x5R5na8EOGJNAFaD97m3tCwa3Z4x8g/j3HFfipnZvcAeCl700ecpQ?=
 =?us-ascii?Q?zE8TkhP6H5gRm3Vzd+a/d5D0L+p6G4gzB82Gx/0gYx/Xo3jR3u/r14mU6sUG?=
 =?us-ascii?Q?KgjZrp9ocV36kZO7obh6BUmbivZYWUd5/ZQ0PAQFmmo0ONRjFcGhaJtGvCfv?=
 =?us-ascii?Q?od+J+MszQFiQJ1cuCZLKpo9y3Jg4vDG2/mAJ/mmpAcHvgXVJbuVR4rfia3/S?=
 =?us-ascii?Q?RT5tsieRayW5KPhLol3V8N1TA4BbDbPH85d0ybixKFfUV55h3+aa9pk33Dsr?=
 =?us-ascii?Q?j5IEtsDXLAxcJG6BovHmyyoRp4GDy1fik38qeqGJQ3ciTHXTXrHR1P/3CxJ/?=
 =?us-ascii?Q?ECb2gAVoBDAo9fDbAEHvTLl7BXzJbHIwU4yTWOGeQNRhYy6584UeG/Fm18KJ?=
 =?us-ascii?Q?Gp929Pas7hvnqD0xR/tF5FJewEt4yarW22ULveLkNUSAwJb5t0vMmNKAx/8V?=
 =?us-ascii?Q?hv2w95iEjeNPTzigHCg1AF15QlHaeJokBdLhFGLPd/csF0kwej42IOHKVFIq?=
 =?us-ascii?Q?tXFqnnny6dZPrXk40Ak63Hew9rVRsaTiyjX9fNrR3PPIj10G3XOC3Rjotm3v?=
 =?us-ascii?Q?06s6idzGpPzWHLiI3NslW4kSheBsT/lft+pwxAZvL646sOD3xVauG6JIGRER?=
 =?us-ascii?Q?JVNeK/E+3lyKxE34n9/eh9EksKx30XxUUe1EZ6g8uE8DVQ6V1csMtVDlWxYE?=
 =?us-ascii?Q?JfNbtZtW3tei8e+TL3NGOAP6gIEQZzwK53hGfBr5LeUsf6bOWpos3Ww22FU1?=
 =?us-ascii?Q?0NbFcm9k5+7V+Fi9WArR7rsAY9xZ66d9YJqkOHu73MWiQ7mSk4oB4aitocFp?=
 =?us-ascii?Q?tqRDKcVq7FgxFKPBkWf2li8p5m7lDYmRvZq1Drv/zyY1+Aeh2kVFhPZmkFo+?=
 =?us-ascii?Q?8QJS/q0gqRDAtB2w1c8dNwi/bSOoc3xuJhauXG/sYQ0cOYl2CEU7+z9rU6xF?=
 =?us-ascii?Q?mggOYKgDRx8MMxfW+FXPFBTf4n3/l0Yov3bm5ZQN2IX6wVw6W9m8QSULkuSE?=
 =?us-ascii?Q?8L29Pa4aDqxoztVxzlmF4WVs8OHyLLHNuofeCUsZFN2BObA9J6+Bv5Vah5yt?=
 =?us-ascii?Q?FogWVln49UMIL6h96MdBR5Vx9tP3Egs2XvKOimb00Qg7de8G83yaInon8A7O?=
 =?us-ascii?Q?dnKLsepL2CZe8brp2FeFsm/M5ikjX57E/KzIIdhs3d6JmVMwdp2UmQDxP8UD?=
 =?us-ascii?Q?fu8N08GQNw910TFXMoJx4OYCkjg2Hf0HIIsI8Nyyb3WPOxIhw6vwUhrwbkAa?=
 =?us-ascii?Q?pq/Dr19CEYzzBOQs2pJKMlbJTsXyIbWcSEdy1I+G36d1eexqGmvaMZ18/8Rk?=
 =?us-ascii?Q?R4MyuRtJFNnXUQDzQk1b61kpnMmgzHw2HbcumJTosycJ6bLVAIqNGsu9VaRD?=
 =?us-ascii?Q?+kjbi+DDSx7h6d455uei/G6m2pYD4pZlTvavaeC7kcixyg3+53931B5oIAYY?=
 =?us-ascii?Q?B2QHtkJxGHj4rxaBwyPbt70P+1MV3My0NNxs22cwcv5jUxph3eZFh+u4eJvg?=
 =?us-ascii?Q?zRwgpy6dLE3JVI1wdJDbrOPJm/yczM66RpmNt0SE1Flgr9cAvQcNUerywflR?=
 =?us-ascii?Q?H8EH7UqFeCfDzpRNV02BRfMxO3b0mEAQDfqU+KG8?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qRq7k+WVcy+fGKng5LQ4/ixQyKZ6XqeaGBmE/bmpN/a+hiAbaTHHmSrPk/30+BEa0SmhyNUJmd5/qDCyvJ1iqzVHSgdfhqi4dFm62VbPmka9HA/1xBiy91edu8pmwt3PJjheH38Ot1I3boYMrrgtSugt3BQDJQRqr8CEeLtQ+Wl91fItiHMlNJnjrsnnQvvSx8fFElJmuy2hI1GdazkFmObOapyTO4oehloqYwMvRXVxUlwJa7vT3hAt8Act40xZ8/gePEfOigfGPNbYhvfW3ClqDECjVx9CdoQ+3XoCYKfDhs4I6txaOCj7ite5Ub5gg6rgIMcckH/OsbQ9JwROj6zSY+OFFrSxG9BpgO6pGN1IPiYH6k52A3ZtoDGk5pLoIOV0kGRCpmd4ChH7Hv4+jF30OGb/YxMiW6jrLs/c739tx5lMd5K3PLL1suDvqcP0FJn0AMEu83qZjyGLSIwx9abTIMyrvi/VXDy33mFTLFXDrPFzxRtAOYSfgfwRCfqpEPhsGpQhZ+RxtUBnxN9pDjv2UnhraBnX50ArPfQAmU8bXiuWq/FEueZsT5sdtmhoepvBXtMX56cpYoxCsCRtnYsSvw9jo03ehZ+kDhV03EA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e0d1b2-5590-44c7-b223-08de1d0e2e1f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 08:26:27.7056
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLDMyJ2h/9Iqwxozau52dlKA9LaTtPISujM8ZlzH7SodTV9ULxHzi3QjcS/h1XayaN1Dup0PwSNdoMP9mVDiRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR10MB7760
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_01,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511060067
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMCBTYWx0ZWRfX5mlzTtTFNGOM
 WQKDFptWios967NlwJmk2m05m1m/nQQmuyNdlfeRp5wrxdxN0hSp4k08NLVPd10kwbpVBqDcFco
 BPJt5idfb67cSWhlV0g/5ASL1wPh7FlUxPmDKS+RigAre7OS9Wc3jU9JkXTVdCK3kxtgcX0dALN
 6KYCo9QhRfOTA+NKgJbYkCcG07ykh7CFpPCwGElSE6rYOrHEP46FkiWv4jU8vu6DjnI22h1WbXM
 Q7Kq6u2flfgzITG2+aWDKhHdLQckZqhjYoKFhb71PtaHF1tVsIlGYq2e0SOsa/kNovVT6WH6gEP
 xkTr/zNysXJR906fDv74V2LeSDXua06UlOuKPJxmMdBr8JyoY+oiW39MtkakM8SErdQAr5kpo1X
 sFiwnERyFIrcELw2j/zU7Uqcirtspf7Jx0VWyE/ph2sZVdZAKbw=
X-Authority-Analysis: v=2.4 cv=R8IO2NRX c=1 sm=1 tr=0 ts=690c5bba b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=nN8h-l-cuGAFRwiFnzwA:9 a=CjuIK1q_8ugA:10 cc=ntf
 awl=host:12123
X-Proofpoint-ORIG-GUID: f9kxo_ICtnsK7CDNRqFQjmQpJhmaJMyK
X-Proofpoint-GUID: f9kxo_ICtnsK7CDNRqFQjmQpJhmaJMyK

On Wed, Nov 05, 2025 at 10:05:29AM +0100, Vlastimil Babka wrote:
> The function is tricky and many of its tests are hard to understand. Try
> to improve that by using more descriptively named variables and added
> comments.
> 
> - rename 'prior' to 'old_head' to match the head and tail parameters
> - introduce a 'bool was_full' to make it more obvious what we are
>   testing instead of the !prior and prior tests

Yeah I recall these were cryptic when I was analyzing slab few years
ago :)

> - add or improve comments in various places to explain what we're doing
> 
> Also replace kmem_cache_has_cpu_partial() tests with
> IS_ENABLED(CONFIG_SLUB_CPU_PARTIAL) which are compile-time constants.
>
> We can do that because the kmem_cache_debug(s) case is handled upfront
> via free_to_partial_list().

This makes sense. By the way, should we also check IS_ENABLED(CONFIG_SLUB_TINY)
in kmem_cache_has_cpu_partial()?

> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---

The code is much cleaner!

Reviewed-by: Harry Yoo <harry.yoo@oracle.com>

-- 
Cheers,
Harry / Hyeonggon


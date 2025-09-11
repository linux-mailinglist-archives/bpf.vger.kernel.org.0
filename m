Return-Path: <bpf+bounces-68131-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF28B5343D
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 15:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E281D5A7181
	for <lists+bpf@lfdr.de>; Thu, 11 Sep 2025 13:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72FAE31CA59;
	Thu, 11 Sep 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fhcKrsTJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PvtqYVrD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED2B3314B7;
	Thu, 11 Sep 2025 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757598269; cv=fail; b=qLUcLpTqSFfsnj9RINkCWxGasVr+s8bkZotHKzH1TqLnzqWKzqF0+uehxmS83PfWzkTBkSUJRQYkoa0wjDG4sHX7RNLvnQpfLvyyuvf/ylzknMBaNoBtWS0KdKtJajG47S1maY2w56EejjHHFHCiCDCjKbighINIAL6uB6btYGQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757598269; c=relaxed/simple;
	bh=zMOy6x6JwUoC9mZ3O0VZZGZU9jA4dBzifhsjw9cpAiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=oZmnjWvj2JnSt3e56IIH9NfoWmPWU0dNTMde1Jn0ItuGlH5GQGkVJeJ8mzQ1+K82DnEZtY3PJrFjxiuF601W13E1oURR2AQqmP/SpuG0SjLAzMeIZpgRd5rNH7e2mArFISHOc2Otep3WmSWDiS3ZcgS263MnaWrVNWulNcsRJRU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fhcKrsTJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PvtqYVrD; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDcxeS024457;
	Thu, 11 Sep 2025 13:43:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dLTzEwU8f1wv5iglPm
	GF6nAK5mEoS9FhrAERhEB4IVk=; b=fhcKrsTJNawPy2tyHZuCDTD3YfyoeVH2e6
	6sSzPLeAnxZzB7XEhy4WefQ4BoXcJ9B2AA8LjusFgZykxS37Tu1psI64Hu67MJ2h
	gPN8QHiD4f/ipkB6d9937qO+Ez1UkZrWSCAyqfokDaM+nNH1iko5zdkNv819cbGX
	qGs5JvfCaHdEH190Ul2JUKs82R95oK3iXZXX7mg21CXumnwAbRWX/OjVwtY6kra3
	Epv4nuMS7WL17PemYndmDcj2n+2t4bYrFWiznagobAANbDymEJkjExVUmaDYCnBk
	gjR3fQgbRTBw46FM1DVyQSinCxIJL06cgAuvvWPBsWBMbynUKgVA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4922shx6f6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 13:43:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58BDCS0C002944;
	Thu, 11 Sep 2025 13:43:37 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010010.outbound.protection.outlook.com [52.101.46.10])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bdk0d6y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Sep 2025 13:43:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ph3Hx6STzKuVqpbn+L8GwFAcYzDxCpEorgRJqABI440IL6ubs1gVXzUcNHD/9d3NNz2JRNMRpGnlupLWO+Vlo6FpQEqMLUeivtocEd48woCfFOEcKJWXUx5I8Grqp9y7BkSlBOMlwfstKvgExwQAZrt3DPraFcT/xxiaJJu/f/cspvH3i4BO3snEPpvECN6rOBzugq8D9C/RVzrwbmk8GrELly7vd+JwvUJA2ulA9Zwe2b2cvqBA/BIYZUxdf7Ea2DfBoTI0u1NkumMFVfzx6KApj9dGc4S+0NcVj+dWaon297pkt3lTPR874rfR7S9NtxFWfuo7bvXefnsIpRiY4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dLTzEwU8f1wv5iglPmGF6nAK5mEoS9FhrAERhEB4IVk=;
 b=FEBlyJHbNq2rGG6ytzCy9gv40Oh6HD+3qEYNIMsqYxQ/rJvsUnL3EuoH/AN61iuL1aWCZKn5oVfRvHAO7RBYcnwH5UUnaaytYPWtzcGKj7CMFVTN/zb8SpvRQdWHqFYYoiiuymk+uiWrxi48nBjt9+fchGrnXg+iX/usbfKgpXUz8x31I6RaHEEZmCHO/JaGvlhtuPHMoaVEP6pmMXeCKJTXA1uMiEOPRNknifkYmd4Bp+UH1N/pY9+B4If8HnAxoi/RXKYVu6ryBNEtDCvWPpTW7sRxx1qrN+r3Q622llIDe8mhjUQvWYxlT+eE5a0IFmRfnho09D+0yYcoQECVuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dLTzEwU8f1wv5iglPmGF6nAK5mEoS9FhrAERhEB4IVk=;
 b=PvtqYVrD8FUlKmPjObEiEd8DF+Y/zC/fZiTBFQqPJOtXZpn7zgVrWT2Yvf6NcwymAUvERZSYvjyobNC9AqTfBSJ8sz9uconNkA5U6bpAt4QqbqJkkvPiaBVhrqF7igiueEyTU0+ku89fy/2g2fn0uYy12nuncTmV6HJU5jvTQLk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM3PPF5CC7476E1.namprd10.prod.outlook.com (2603:10b6:f:fc00::c2a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Thu, 11 Sep
 2025 13:43:33 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Thu, 11 Sep 2025
 13:43:33 +0000
Date: Thu, 11 Sep 2025 14:43:31 +0100
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
        linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Lance Yang <ioworker0@gmail.com>
Subject: Re: [PATCH v7 mm-new 01/10] mm: thp: remove disabled task from
 khugepaged_mm_slot
Message-ID: <8b7cd7d0-ec5f-4d0e-9182-03e42d37820c@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-2-laoar.shao@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250910024447.64788-2-laoar.shao@gmail.com>
X-ClientProxiedBy: LO4P123CA0459.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1aa::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM3PPF5CC7476E1:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ed1d485-fe29-45b1-d36e-08ddf1393376
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?aqSF4t1iu/8Z5x8Vo0u/svowfjXi9pyeQiICAktF/gTpJnf5UnR0HdI/hWDX?=
 =?us-ascii?Q?NawPrUp9BzDSDL3rLBODtXDsddVH+j/54507nVfbR5C2t4vyxtZE6np3R69e?=
 =?us-ascii?Q?DQIO/kuQkxsXx6gR0CUU+D677WoQD/nOMYFZvZXRrHCbjc6HRIAwOL48beEC?=
 =?us-ascii?Q?DmWp/H5eh95aSYhkWKpHnogPLb6mhvVO5mGMnllrlzQYg/mpFd125iwr1u9o?=
 =?us-ascii?Q?7DmvmQUssUeuYEAlxUVcOUDufWjMXyC1czMIp0x6TkreIwGNjkQJdYd8ckhh?=
 =?us-ascii?Q?4v1ugb3Sn0cPm3r7TlkJD0x7QT6bINCbwCvfl4KTzjpBMbg+zpkOByddw5WZ?=
 =?us-ascii?Q?eRVGWQr7ZdG6yIKdDSINoHZCz3WuFfm38GlWkNMKciwSjG9uNPV7rgtlhsbZ?=
 =?us-ascii?Q?XtZq5DcOPBKo+g3bnMXPHnDfKMQMDr7YFjkAYoCHuhyDwB6UFBkE+cUaxE3U?=
 =?us-ascii?Q?3xHuF45irTWEPxQ+ISfzHKIgJHgBiI3occjuZvQdw/jJe8PPWqRNSU4dZhVQ?=
 =?us-ascii?Q?cHG7ReGGTnD7JtI3dYam/lxfRYIOglI1DJCHIOaSXsPQKKXmZ0QMSwLND+Oi?=
 =?us-ascii?Q?0pdZtvJHtPB1BH8iMbbwU20WPBR34/jeJmHDvXDccnvjJBAp1KGpJFcScnE9?=
 =?us-ascii?Q?GZPvM6bpT/ByEI3+tzk6uLTaILQ2UES6FLeaPo3kePZ7bxNikxa8rBxF3E1m?=
 =?us-ascii?Q?90/UVfP9hxCDAd4BKL5R2vaBjEjJjj6yIPqFZs56dtzCCtGA06wM8nyO/rHS?=
 =?us-ascii?Q?Jw/4fqOIHLa2tgKXoIt/LdVXflXpCq1hUWIAV7Zdw6OnOnNeQWisv7IMH3Uq?=
 =?us-ascii?Q?l7gx8/SqVDK0vuVeDzi/mCWrG9TC8GXxiHqKFMVUcvbkYlXlwAHrdnWHVpkd?=
 =?us-ascii?Q?j29lwxzZi8mffmIdSAxqfjBULAsBBf1MrkRtwZARBmxb21wLp+JT7ODuy6ox?=
 =?us-ascii?Q?Kg3Q5sv52TRpBgsJKcdExpIizFa+qa0w5Aap+88a/qSviOmpWochFEUZkQtA?=
 =?us-ascii?Q?N1NXx24yxG37EnWAstUCrj2nGUJWRaDDALw5wd5FIImJjStFOM9aEUcxzuUt?=
 =?us-ascii?Q?rGy11xDttEVwTpLzvZZp9fAlwNuPURpJ0JYg+ZXL/C6ThiTziQh3E8xy8We0?=
 =?us-ascii?Q?VjKzOfVDtvA9PlH5r2KZ9pkKWZJlKlXMeZvb6QxGk3SV5jEqfNE9g06oWFkT?=
 =?us-ascii?Q?eKxsDgszZKPOEuSE/Vl/jSqF4V0ni/N2pbcfyah0FNg4+5RecumwgwVcA0XN?=
 =?us-ascii?Q?K4leV/KfFDHL1KvboB3BhZpxavR3fvyjxddeBvIcHat3juxcuMn6g9lKlQZo?=
 =?us-ascii?Q?BUbEvxUpOLANdiQn4SCwIoZq5QQS7ci1wvJS6wxTVHR18HT20FcrC4e5wVRc?=
 =?us-ascii?Q?+zai1BMkGKbLN3MbrYYs1Tr1MXdBakGiDHtErV/K7tUASQdDK1FR97PYgInb?=
 =?us-ascii?Q?VL4hRL0jmo0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?aoYpPx5eBB2zniSYKvAU6bJIkLreJ9GLjsKjCRLbC/LS2IcOEQPiUMckeKjX?=
 =?us-ascii?Q?UCfxCEX8JSCG+RIPksdQmee0bICqsPmyabJxGdfXpVMaz61C6zzzbGgfrM6w?=
 =?us-ascii?Q?HoxgugrieQ4l8y4nfkKuLOdrbq0ZZpQgRnowk9gOo5RrrDlD6/894hIAEWMT?=
 =?us-ascii?Q?w+fQvWTmkVNa6yyYa5eUkK6n8KNEhqXzpga68+HXoXsPHF51XW1KybtHdzC4?=
 =?us-ascii?Q?vMPf+CNMUY2HbZonQ/jBlD+PiNix4qS2UHS/T1Q/J32OUz0XiEDjbcFNHttO?=
 =?us-ascii?Q?eaaXwsjAc0n1wMLNm7ohoy7UvXzKdegFpz6HNB3pu1WKTeD25Bod9CIW0Qol?=
 =?us-ascii?Q?wtEUdVZbaDZtNHE6/wZx0p3ebPdFl5pPNKeXAiOumXeX1z1jPtEzE0F3nA4f?=
 =?us-ascii?Q?AjpiZ0b/m1qZ3j0k8tawrNwTD+wDomnMIIR80Xmkn6bOglpDfMEBVZhY1NYw?=
 =?us-ascii?Q?WfzqamddAx1Kh4bJ8XI5Zfi4MpJ+x2rb89HfgRIH4toHfo0BdnO13Ib5NcWN?=
 =?us-ascii?Q?pN5r9KDZQCtyGZIrL/ygVPWgJ8LD8r+1VA79RJQBDw79/6hnDSfXuTz008eJ?=
 =?us-ascii?Q?OEBAar/XN3brFSnl+iOmYHJ9tcVCLFONwM7+3jhOCiP3of8jQTGPXQ5Ce1zw?=
 =?us-ascii?Q?wBED2CYxeGjqHmwys9rWdigPGZYf4hVzrgMRxHD26ZqujdJznBP0VC08hQCw?=
 =?us-ascii?Q?LYzXMqMBF/0KLkQyAWF2PgFxDgpWqNwk47CafTH5blNlEbeiuJjd4blHe2Nk?=
 =?us-ascii?Q?yl6rdzStZo9ZtdvSvsj6od2c3s4H/d7ahw7UWotBjQeDSSikD1coDMUC+vKm?=
 =?us-ascii?Q?RNNpRE/b1LyYv8hPfZmTURDtmAhtnxwLeBeTgVSSpgdnsjA7wuBmYQcUTkju?=
 =?us-ascii?Q?eK0q+2vKaLGMmWKyBlxR3+djJLztxZacx94YyUpXM4A/aod5oyCZ13/BYZ+a?=
 =?us-ascii?Q?KFUzwxBrE4KpuuPB5hjqbxpuEJMViONqiQVrul7KaSjddobF/eXmSgJJB/zf?=
 =?us-ascii?Q?V3ZQ0JSJUoSiYTAIpeESpH3dRGGGHc3AKv3ghMETOm+RTxZEc27R/FyCDc6j?=
 =?us-ascii?Q?Pljhehe8jtL3xgKutfIdskZalSPRejJyOqnAxEcAYSK3mdKad5AAXO6wRlrw?=
 =?us-ascii?Q?B+R5LNJX38pDvlJJLTxucUgtygju0KOvGVXp4857q9wy/ATYTBJq0G58BuzZ?=
 =?us-ascii?Q?vRtgfmHBW4N/6Pgfb+5aTNFaQPcPdHLgmbQPod8RUHEHy0gqpc+qgKKeJsrB?=
 =?us-ascii?Q?0s8iyBQr5ghKx8CLmJwpEnU8ucd3+MOShWHfxy5YXNNn1rmOyVXEdZHJYwJz?=
 =?us-ascii?Q?MSYRpbKF0B0G59zYMPWPx5NqFfzQCKg2/pJZyL2K7yIxRsEfjauxiePbptr2?=
 =?us-ascii?Q?QvzV9m4Kk/COGF0+mVM1zVk6Er7ZNXTAcBjdmicqJPNcy+BhKd1YyW/EnkWM?=
 =?us-ascii?Q?3vKbtPUH7rc5+Hx3Zv4UUUi6FFvkTsEPNM1GekLDd+fn73qioBu8N0Gwc3Bb?=
 =?us-ascii?Q?0W26ILQC/gmLdgLATUv5oQgG3uYC/n4Lvi4/kMguqVCuvYIcGh42pRiEnk/l?=
 =?us-ascii?Q?MfmlWxohUL1xBMhis3AcX+s732iIIiR/1etWWf+PjxDHaAmYkWYwkc9QYAmz?=
 =?us-ascii?Q?hA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	pJ76EK8lSrHF2VYyeizgN69q3eun2rz5GxrbT0mUifT88ayXl14qcrubI+xU9oLUF/Gc7yR7Zd+6mc57jQMiChIhr9cZo9KcWOWc/VR/37yTpN93n5hXMsKjOtw4ABBYbCFbu4644xqmJEpLyRSKg3OgdE1D/F9YiOPCk4hha0cJ6pBM8tjG7t3QC5/EXFuJyXsPvGPUKx7hzdHDgs88eR1inqkgh7ra8nfEMFb6vpvnv2LK0RdGJHoKG5TaNAbgugaT4/cU8mzl4saxCgPGXbzUkKr3nhATllz7RKv8VPN5jdgafIQT6T/0dLILw4aobRj0nqvsDGZ8m471mvFjj6OgO1+YvYClzTCjFa6E/WwmBlIH/5L7bFreWpgsdlYmkjb8GAE747UJdBE6V8wjHKcccj4O3weH+qaED+om4kCj59h7EaQmnAj2dDmhmCq6K4bWcQN82YIYCzYR3e/pCnRHV6h3dO9DK3pTtf/JmkVm3x5fsJyG/T6h3pG2/wdgPPMvj4Rcx/JZzVIsRzduQELDXJ0Bd+FWIZl8WADnOTSgiRf8KbkVGxmJb3aUdPnk7TW+bzQVT6vtljQAYuyIaP0ski0992ZTdFAYwpp1K+I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ed1d485-fe29-45b1-d36e-08ddf1393376
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2025 13:43:33.6133
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cUQhA3ECW7RWhj7d0d/EdrLNykHLm5SIL1q8kdxHsnogTJqC4FEjGKqaCCtrAYXOuOtSFoifckyiePVzyj5PS1aUSnFAsxVgG7o1hO2XNsA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF5CC7476E1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-11_01,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 suspectscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509110121
X-Authority-Analysis: v=2.4 cv=esTfzppX c=1 sm=1 tr=0 ts=68c2d209 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=iS8Fdpo-zwEQGUKLK2kA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12084
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE2NSBTYWx0ZWRfX1STaEdyI6DqL
 b2ggPkNo9BUrry99/t6dVvyxW09coHpTgOpMortVHJYYPIdU6mfwvD43ix30lSPV9OOazkTz5sX
 6+dPzUkXE9ZYrNfFTbhfBnFIJ84sqymZTVz0TLqW2J9vn4/5HcyrC0N3nh1dQNn9Q45Yb7v5AC4
 MiR97EHeEM/K7CJ9sqRzTx3ch0XXgA/t6wk4fKILQCbvqkH7hZd3VvOQ8mDShaFKxRmVGBZVsEr
 UUVg5rrQG9ddRCx5BE+joCYrGh3PpGT9FYn8OGh2ix42VhcSVCR4eHH/nXXJk7+GdFS1GA7fsYz
 UXYveCM8hl6HQM3XMJoZd0Taq0JP+itUZ1AQcCxVYBfa3x3Z4lUVkl7BeVZOP8mvdkcTPWCQnJD
 9Sq5Qp6gsWn4Blua+qCZv4h+4SU7tA==
X-Proofpoint-GUID: ciabdTLnPlzTyy1Ec0jgAihXeqL219b9
X-Proofpoint-ORIG-GUID: ciabdTLnPlzTyy1Ec0jgAihXeqL219b9

On Wed, Sep 10, 2025 at 10:44:38AM +0800, Yafang Shao wrote:
> Since a task with MMF_DISABLE_THP_COMPLETELY cannot use THP, remove it from
> the khugepaged_mm_slot to stop khugepaged from processing it.
>
> After this change, the following semantic relationship always holds:
>
>   MMF_VM_HUGEPAGE is set     == task is in khugepaged mm_slot
>   MMF_VM_HUGEPAGE is not set == task is not in khugepaged mm_slot
>
> Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
> Cc: Lance Yang <ioworker0@gmail.com>

(Obviously on basis of fixing issue bot reported).

> ---
>  include/linux/khugepaged.h |  1 +
>  kernel/sys.c               |  6 ++++++
>  mm/khugepaged.c            | 19 +++++++++----------
>  3 files changed, 16 insertions(+), 10 deletions(-)
>
> diff --git a/include/linux/khugepaged.h b/include/linux/khugepaged.h
> index eb1946a70cff..6cb9107f1006 100644
> --- a/include/linux/khugepaged.h
> +++ b/include/linux/khugepaged.h
> @@ -19,6 +19,7 @@ extern void khugepaged_min_free_kbytes_update(void);
>  extern bool current_is_khugepaged(void);
>  extern int collapse_pte_mapped_thp(struct mm_struct *mm, unsigned long addr,
>  				   bool install_pmd);
> +bool hugepage_pmd_enabled(void);

Need to provide a !CONFIG_TRANSPARENT_HUGEPAGE version, or to not invoke
this in a context where CONFIG_TRANSPARENT_HUGEPAGE is specified.

>
>  static inline void khugepaged_fork(struct mm_struct *mm, struct mm_struct *oldmm)
>  {
> diff --git a/kernel/sys.c b/kernel/sys.c
> index a46d9b75880b..a1c1e8007f2d 100644
> --- a/kernel/sys.c
> +++ b/kernel/sys.c
> @@ -8,6 +8,7 @@
>  #include <linux/export.h>
>  #include <linux/mm.h>
>  #include <linux/mm_inline.h>
> +#include <linux/khugepaged.h>
>  #include <linux/utsname.h>
>  #include <linux/mman.h>
>  #include <linux/reboot.h>
> @@ -2493,6 +2494,11 @@ static int prctl_set_thp_disable(bool thp_disable, unsigned long flags,
>  		mm_flags_clear(MMF_DISABLE_THP_COMPLETELY, mm);
>  		mm_flags_clear(MMF_DISABLE_THP_EXCEPT_ADVISED, mm);
>  	}
> +
> +	if (!mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm) &&
> +	    !mm_flags_test(MMF_VM_HUGEPAGE, mm) &&
> +	    hugepage_pmd_enabled())
> +		__khugepaged_enter(mm);

Let's refactor this so it's not open-coded.

We can have:

void khugepaged_enter_mm(struct mm_struct *mm)
{
	if (mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm))
		return;
	if (mm_flags_test(MMF_VM_HUGEPAGE, mm))
		return;
	if (!hugepage_pmd_enabled())
		return;

	__khugepaged_enter(mm);
}

void khugepaged_enter_vma(struct vm_area_struct *vma,
			  vm_flags_t vm_flags)
{
	if (!thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
		return;

	khugepaged_enter_mm(vma->vm_mm);
}

Then just invoke khugepaged_enter_mm() here.


>  	mmap_write_unlock(current->mm);
>  	return 0;
>  }
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 4ec324a4c1fe..88ac482fb3a0 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -413,7 +413,7 @@ static inline int hpage_collapse_test_exit_or_disable(struct mm_struct *mm)
>  		mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm);
>  }
>
> -static bool hugepage_pmd_enabled(void)
> +bool hugepage_pmd_enabled(void)
>  {
>  	/*
>  	 * We cover the anon, shmem and the file-backed case here; file-backed
> @@ -445,6 +445,7 @@ void __khugepaged_enter(struct mm_struct *mm)
>
>  	/* __khugepaged_exit() must not run from under us */
>  	VM_BUG_ON_MM(hpage_collapse_test_exit(mm), mm);
> +	WARN_ON_ONCE(mm_flags_test(MMF_DISABLE_THP_COMPLETELY, mm));

Not sure why this needs to be a naked WARN_ON_ONCE()? Seems that'd be a
programmatic eror, so VM_WARN_ON_ONCE() more appropriate?

Can also change the VM_BUG_ON_MM() to VM_WARN_ON_ONCE_MM() while we're here.

>  	if (unlikely(mm_flags_test_and_set(MMF_VM_HUGEPAGE, mm)))
>  		return;
>
> @@ -472,7 +473,8 @@ void __khugepaged_enter(struct mm_struct *mm)
>  void khugepaged_enter_vma(struct vm_area_struct *vma,
>  			  vm_flags_t vm_flags)
>  {
> -	if (!mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
> +	if (!mm_flags_test(MMF_DISABLE_THP_COMPLETELY, vma->vm_mm) &&
> +	    !mm_flags_test(MMF_VM_HUGEPAGE, vma->vm_mm) &&
>  	    hugepage_pmd_enabled()) {
>  		if (thp_vma_allowable_order(vma, vm_flags, TVA_KHUGEPAGED, PMD_ORDER))
>  			__khugepaged_enter(vma->vm_mm);

See above, we can refactor this.

> @@ -1451,16 +1453,13 @@ static void collect_mm_slot(struct khugepaged_mm_slot *mm_slot)
>
>  	lockdep_assert_held(&khugepaged_mm_lock);
>
> -	if (hpage_collapse_test_exit(mm)) {
> +	if (hpage_collapse_test_exit_or_disable(mm)) {
>  		/* free mm_slot */
>  		hash_del(&slot->hash);
>  		list_del(&slot->mm_node);
>
> -		/*
> -		 * Not strictly needed because the mm exited already.
> -		 *
> -		 * mm_flags_clear(MMF_VM_HUGEPAGE, mm);
> -		 */
> +		/* If the mm is disabled, this flag must be cleared. */
> +		mm_flags_clear(MMF_VM_HUGEPAGE, mm);
>
>  		/* khugepaged_mm_lock actually not necessary for the below */
>  		mm_slot_free(mm_slot_cache, mm_slot);
> @@ -2507,9 +2506,9 @@ static unsigned int khugepaged_scan_mm_slot(unsigned int pages, int *result,
>  	VM_BUG_ON(khugepaged_scan.mm_slot != mm_slot);
>  	/*
>  	 * Release the current mm_slot if this mm is about to die, or
> -	 * if we scanned all vmas of this mm.
> +	 * if we scanned all vmas of this mm, or if this mm is disabled.
>  	 */
> -	if (hpage_collapse_test_exit(mm) || !vma) {
> +	if (hpage_collapse_test_exit_or_disable(mm) || !vma) {
>  		/*
>  		 * Make sure that if mm_users is reaching zero while
>  		 * khugepaged runs here, khugepaged_exit will find

Seems reasonable, but makes me wonder if we actually always want to invoke
hpage_collapse_test_exit_or_disable()?

I guess the VM_BUG_ON() (though it should be a VM_WARN_ON_ONCE()) in
__khugepaged_enter() is a legit use, but the only other case is
retract_page_tables().

I wonder if we should change this also? Seems reasonable to.

> --
> 2.47.3
>


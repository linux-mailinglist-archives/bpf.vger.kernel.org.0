Return-Path: <bpf+bounces-75694-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F845C91CEF
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 12:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 573FF3ABADB
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 11:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C1630F533;
	Fri, 28 Nov 2025 11:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o84pZBQE";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I03K2Yga"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBF62FFF89;
	Fri, 28 Nov 2025 11:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764329904; cv=fail; b=pAwUuVZQqdikDN8IlVt/0pNhxoWq86R6XUzEl+nbsyPp3MLhtQvvtJEa1Trmd9ycvyi+bw/NDBPDs3axabPqBtAPZFLDbJpLXr37warUj1sywaSjTrT76auXQbHWNjDQhUnDmxBbuYbkIH7rPuw451gXfnJJZg2+WLe7V0AHIUE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764329904; c=relaxed/simple;
	bh=J3NFKBLsmHaHuzYcOEV6+CmLDwx8JoL+wNA0x//RlL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SfUAcTnU7JcElrX2l73XJ1VS0elpoJgE95g5Mmrt1pmDMNeeoghB8eTWA6ZUnx0xvC2/Mn/V0nKX4HfA/9P7K+3Z76INiatWYQDJ4L28g+K7lhmu/XheP7mBw9trwNF061s/iwDEehMpWE880mXXjXIhNONEFv9eMbqf6f1j2Ls=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o84pZBQE; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I03K2Yga; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5AS7u7D83069730;
	Fri, 28 Nov 2025 11:37:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=osptdkhuuOK3X8YZ6eZAaLeBOngsDJJWdZPOUXhSpaQ=; b=
	o84pZBQEZcHXONjNuq/GN7KGfWqMT8U2VdBejgcpxNe8OsbsEe/l43N6WVra1tmK
	f84EYZsrWRY9p6Zap7iXYQdJGs39TK0w0Kuc3dXABMxLGDHiwhB6AjQcrB08ePMS
	7maO/HS4PzanfzZoN/g0SwdJ0vac1bFv8jlKBxUQItz0IpA/EzroVCtqBrQ7pVA/
	m6em4zvYWsmFCauhPfrvXo7s/icmXqEuf+/GKZgrwtdjEoX5kW7JdvQ/q2L7BPfP
	gQ6N59dhoVTY11oenmc8fUB6untD6EfIBWTPCfyld+dsNSFQL1gd+ri5UDz9JXbW
	5v8OsSVKQxhSv46yqvYFOA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aq3m2rjpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 11:37:54 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ASAd9Mv029841;
	Fri, 28 Nov 2025 11:37:53 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011058.outbound.protection.outlook.com [52.101.52.58])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4ak3mgr30r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 11:37:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypoy/5Grcg9CKN9qvzNjlQR2QWqBWXWhB8oBVRxTkQyDAENwjJdP8dCFKjAYbz88Gfa6bDp+oa5/CY5HusRs2QXBl0nbmMjai2WcPwPj+/AzVxMV8GWl/9IcirvrIkI6TLcFruBL3tzWpR1NC3W6FyLWelpbgDy02SidPUfCz+bThXhlt25/zqa/vAeODCsG4PHRfa1GREmdq1wl1m4IycKYxwt96Z5gpHPlJ+NswAcgDL5/NiamNgRRFXSzVe8PMcgnp1nRc0JeXQlBIMrS9KQqdBwtMyp03PhrVQ7SY48sP4F+IVWpbj9Xn4b22HDxK7NYAxhwJfMzUUNVYfFAcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=osptdkhuuOK3X8YZ6eZAaLeBOngsDJJWdZPOUXhSpaQ=;
 b=vrA35h41m8B6b7XjrWahbQTJHoHnBsMke+xxUw4G0TmvePdqV6Yy/yO6Scn0SwI0u1cHATNsOT3CG3q9Ws6QmKq+qNiGdJBMjRstMeH+ASP+I0edtpPTgrBa7CCIps1SVLo8gJC9m4Zzp8dRVptwk8kYyp6y8suSMsue8Dncr2QUtxiE2vkXv4BiE9rjYd40HQe0GkdhgmZ1bGzhs5g/x3GAIYlc5lWVMJ4DpnaLQ8+ia7pMpaU/GT/YoYL8mCbsVOCCWg20p8JhUlHwcWOheUFFRaJuRrBz/Gbx0eHFteJ75W45z2Uvutc7jtw06AMFixsF7zeMAmbj1xrKLW+BQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=osptdkhuuOK3X8YZ6eZAaLeBOngsDJJWdZPOUXhSpaQ=;
 b=I03K2YgaOdFe/9gYP98UY99UKmB9T+QUf8omFnt2hjPViYGK1GCqEMKEojTYBToG3Gic7LFvLd3egCN1hEnJ09y/bew9tNqnRJQnV43W7Re722R0nQ43a5193jI4o7C0zHGsLVS+KtOPPHFGnzVAkJAPVehKDGeC/h83pd5zR/c=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by PH0PR10MB5660.namprd10.prod.outlook.com (2603:10b6:510:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Fri, 28 Nov
 2025 11:37:49 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::c2a4:fdda:f0c2:6f71%6]) with mapi id 15.20.9366.009; Fri, 28 Nov 2025
 11:37:49 +0000
From: Harry Yoo <harry.yoo@oracle.com>
To: surenb@google.com
Cc: Liam.Howlett@oracle.com, atomlin@atomlin.com, bpf@vger.kernel.org,
        cl@gentwo.org, da.gomez@kernel.org, harry.yoo@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-modules@vger.kernel.org, lucas.demarchi@intel.com,
        maple-tree@lists.infradead.org, mcgrof@kernel.org, petr.pavlu@suse.com,
        rcu@vger.kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
        samitolvanen@google.com, sidhartha.kumar@oracle.com, urezki@gmail.com,
        vbabka@suse.cz, jonathanh@nvidia.com
Subject: [PATCH V1] mm/slab: introduce kvfree_rcu_barrier_on_cache() for cache destruction
Date: Fri, 28 Nov 2025 20:37:40 +0900
Message-ID: <20251128113740.90129-1-harry.yoo@oracle.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAJuCfpFTMQD6oyR_Q1ds7XL4Km7h2mmzSv4z7f5fFnQ14=+g_A@mail.gmail.com>
References: <CAJuCfpFTMQD6oyR_Q1ds7XL4Km7h2mmzSv4z7f5fFnQ14=+g_A@mail.gmail.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SE2P216CA0093.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::14) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|PH0PR10MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: 3530be48-15be-401a-1898-08de2e728f21
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5Ql9HKfn5UWSf2qB3Z+d/JBuBSJF0Uey3gQba7L7xrCYwMjnhklLxUuVkL/p?=
 =?us-ascii?Q?o20rlu/1dHZccr6gR5zEgh11SAeXbr4WLXzAHcSRKnQ/8782QMCYBQ5VfCYE?=
 =?us-ascii?Q?VRUDTn08S8n2i9ugvrafHi4fn/SnSDMlfjPzZQ4Aq80PMZlmo4MlaJg9QRlD?=
 =?us-ascii?Q?+W+qUJ2jqLyKq0v6uuCvJoIZDJRo8cYlS2wQfNKoRamOF73XYJHGvAjeegMa?=
 =?us-ascii?Q?fUrGG+yU5Emh21m3igOxdKLRD+dS0Y4Qe0YLK1dFa5IBJqaoecBOXKfWjhbw?=
 =?us-ascii?Q?NIW9pEvQH5SaHKYtZ2NiLphuRs9xnqVAz8Jh2nqJ4N+Ye3DbfU6Uzv7VAyYY?=
 =?us-ascii?Q?AQRYAxt67HlbZxIE8EMEDMoSmGqO4TdK0G2APIXFVNuJYiI+wU1VHtYYnQsf?=
 =?us-ascii?Q?sL79ihrlhxQCVxlEzQaOW5h/DNjglw2/ohH/8a8s8RwH3e2PA0bdpjt1JwA5?=
 =?us-ascii?Q?Ji+F0yFMp/AeLgWFz2mhLFK20A54qjkBcrCMIRcW3fyM+/G6XO5o+QviJOMR?=
 =?us-ascii?Q?fS5iiEt6DKLvRmrW/GRS3i2ByR9hGwcoT13bmWnGzrd+CNsfyUY95MWonNcJ?=
 =?us-ascii?Q?Afy7BvBTd7hPjkDjvoniKgS6S95cgNxiHg0oVNBlxiYaUtAlCD1mF53KpLL9?=
 =?us-ascii?Q?0eGa6BQ83DQqCgr/av7yVR+i8/p9ktr2IoxBmRbs4HZtD097cfsoxDqOfqbD?=
 =?us-ascii?Q?aEP49nDBILtq1Alie2MOqCT6MC7/YPOGFSMg1+IHNaiec/3Gm4WN5jRRPD5c?=
 =?us-ascii?Q?QZfIuwmJhPdIjaxGXMsQ32010pvfM3nKVIkgHX0HGVowsTui0N6WRhx/A9Cm?=
 =?us-ascii?Q?qOMwgU32diI7k66g/kZeFjwrEGr91hBgk2orCO4Ov8Cu2LaE/YwMcr6B+JIA?=
 =?us-ascii?Q?eYktktJe47GnnCC/wbW3ChQgBYqL/4NAKPqLY5VBbcIARkfE3DahxBbJVxgs?=
 =?us-ascii?Q?JivDwmBV/HX+MNi5CJwXPQvOd+usdjNtYMByxKHrvnatExVnznRExRbLmUS7?=
 =?us-ascii?Q?SIGtSxzfPRgWQR14CgvvB0Bx5C4HxYnLAOlzqQ1Z+krsRTGPcknFzWQYIyn5?=
 =?us-ascii?Q?e5yCYV6vGNDiaPGO16lUAQOaPUV3lfaGZPZhkzKzr8m2tEE8dgJRjpVCPpkN?=
 =?us-ascii?Q?gmzxzSRSdyPxCc1DjgPWgnTYV+udRELdtrW150gzzX8TYuuaL+UdkerRd175?=
 =?us-ascii?Q?eEGbG9ANddFb0x0GEJKjDoshQA2ccONY81/BWWl7OralOs7Egf62+5mxfsel?=
 =?us-ascii?Q?VQ2fWmioKy7g6OnfTt+CgEkYzQXV9pho0rtqGBjPPIYSMB5t0YCNfOcs1psi?=
 =?us-ascii?Q?8fiNHKlrY8Mb72xksrH1dKMVCFFybTPOGSzsqeOJ7nk9ad+PSsz/vBTv32SG?=
 =?us-ascii?Q?DeUXYDQXXYSXyFZta8qp7b0ralmTjslOlUUhSwGPc4hejAQwfkuzud7E3y9o?=
 =?us-ascii?Q?MKy4eq71/6Fqp5+cJts+Z1RTMTyjHwupC69fLYK51Xa6hhUcbtXsvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?a+Qa1d1W+ahRiy+pgFtryXpQa1zewC0Hxt9SPxQ/AN6awpwDZsPFAPMbGCz4?=
 =?us-ascii?Q?Mts9QZc/OkSHgnbIyS7R5P1sv65zxUD5VGciVEzckRBejvKP/MHW0hxPyjkx?=
 =?us-ascii?Q?86xXcXIYLzmeCKLlevwsu2jUCflabXDCBua9FMC80OaChOqZYfO1CgIaPJ77?=
 =?us-ascii?Q?m4wvSkfRt+oSNm7qYB6mjNIPIQeOYa+hxOSUKTjVbU2L+cHRtCIndnC+fmcR?=
 =?us-ascii?Q?e+Ag2xp6pP/lPD4ShhGqSBsUsvpex9/b79dD1/E0iH20XCbVlHFunUbC7aR+?=
 =?us-ascii?Q?NiM6bWGYU/6jsbFOW1ArTgn99Az2fx2qJXidGVHxyJMFkDdbL5sN7y4HxX7g?=
 =?us-ascii?Q?cx4wA5flBR/vClO83GxJ0Py6vcPOiQFbM2RK4lxMtt+McECuhcTIdvXW+r+J?=
 =?us-ascii?Q?Eu19ZBnzsnmgByWIkjn0SfGblva2cnDbSY0H1LZ/p/sRF+wTRHmd8DmDkCal?=
 =?us-ascii?Q?/XNxuV2XXQHLqv7YOnIXMbNdymNjEoMXD6moyoYJOks75uh7ZkJCwP8u7qTw?=
 =?us-ascii?Q?DlVEzpkpil8JDfcIoz00SnRRHjozJatCQezWYApeSNnG12X6GBw8Jm/skOc9?=
 =?us-ascii?Q?MdBgCgdUQEiol1FPpARM4aSo7veOh3euIGFI80jT9SNu7jIrSMPRscqgO9F4?=
 =?us-ascii?Q?W5Eh5QCRpUuxpVOclRuqwLg9/JBuHCvKeqQ0u7Ff+y4r1XV5Mq5b0n2RNT7F?=
 =?us-ascii?Q?CqlNtO26Z6aI+cbhPapH2GU01UMn+N3B4N1IG/Xm9O8G3ihyeZ/+/DERhY6v?=
 =?us-ascii?Q?MPJlhDRlqYlmZngtlTHRf85o/Zdb7wE2HuKZbaERkI2WtHIuDuUT+PnDfbH3?=
 =?us-ascii?Q?c0B+7r16zkvYUxs6bWx2+1Bat82U7J7FD9q95al76lJO1fFfVAMb05o8A5DX?=
 =?us-ascii?Q?yNpISWPFBbbi3MDptq9bNaXAZmgqN+3Gy5lXS54GZsHiLG5/mry8nBZy/Djq?=
 =?us-ascii?Q?6ohe2c2xjjT4GQ4ukN1EqH1/vw0q5cQTOwajWK02b0V7+Bo0n0xKV3D7B5Be?=
 =?us-ascii?Q?qhbjpmvf1sKnjai/hIPK16KbtXWGYJwHl2fArdHNBDkmvS2EotYYA9bzPNZS?=
 =?us-ascii?Q?IrgcqbWHaF5JZKPfbswLFjOJHVTtlCuXzjvmKIesuyvZQcFtTtbC1xqmN8Di?=
 =?us-ascii?Q?+IBlq4bTnSF/a27qbuZr7+SEC/qBWSjtZCQAFyecrrFIUhCGXBLsL1Ex5umd?=
 =?us-ascii?Q?s1PzQ9Ub4Oa1KGRnAsFr7Tl2zByFPv0jAM3cKAz5odtwK5PL+/oYkWMg/4b+?=
 =?us-ascii?Q?GV8JFJ+a7pW82BPVRiAovae1DjHA4Xeq4Fmn5vKY/XlVxx8MhdpnA7or1jcY?=
 =?us-ascii?Q?ghrr/OvEEHoNEUljJWEimjFmQoHbxFm/H+HsazF/CcA3ioVKY7mM328YI87C?=
 =?us-ascii?Q?g5O8r7QxNxt4iMmpE+y9if/dNhTd1EUV3F80Eg5Iabap2YFW+7hlkMdWZrzT?=
 =?us-ascii?Q?UZcAMuWzPTw8ifIg6CJCmvnfihX+ImM2WyeYUIpRz1djOuo7u/qHGx64UqMX?=
 =?us-ascii?Q?X+tXbbP1ltgxxvRojIVc3KBEiqWm5Xuem6GjaCkSEksVtEfQoy5M8bI7xamM?=
 =?us-ascii?Q?8nucEMP13v/QcO519bhxYkaaH8u+vZL25T6lo+pg?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZgxcIzn51kpejPAIEg2spY9mx7kUgu5Yf0NpKWuIgBFu60whGPEzbZC1SUtqJfJupWcSY6TtEoFgVfYk+ikoHG/ulYGvqw6cAajtf1+aBZXCrS4+vv8FfsqHK57fkfgbiQbMY60JMLBXgTdK3s4JAyLFGqw8CrEvpeoB90hBTJS0Z651AF3fqPycfaa0QfscocfCziS69/KeBXlox5luDVmo77j5+7iYQRZlEo3PEJMAxh0K8ZZ9ofkfSWNnA3xjsCTF8gGRWUPn/nxoo102lsLh2qCip/c5NW+seo7hvk30wTuSBdo+wkoumwQ9FlPzriDA6kUZxzkLK4gWmbwqcSgfySj3GWz8bIdgiNxz0Z/55K77OQpwfwJiqMK44xEmKADf+h9nUBX3nufINojSARmL3QfVlleqQbl/FrobADOsp9wRmE3wO3KNqiv2h2zjzk2aXydHkUtmr7StuCN76wFG2EW9Y7oH7MdgG+3hihyKBKbv5GpzlquDSSn/2LGQ6xow3m2iE46o/ZJTaEKfYBdHz0nnTpfHfu83j+W73/k9alo0RMXATMM292Qdd67IN3qPTAkUnDE/wO0td4s/vA6DakC2PYQrYXpkFgwkG68=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3530be48-15be-401a-1898-08de2e728f21
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 11:37:49.7038
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SRsEd2Sn2m68DxYU2x3XlsIlSJPtMWyfXhr/4DSTm2Wu2UHmG9aeqa54hR5LFlfUb/qBX27KXY7BLohSsP27cA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_03,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511280084
X-Authority-Analysis: v=2.4 cv=adVsXBot c=1 sm=1 tr=0 ts=69298992 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8
 a=yPCof4ZbAAAA:8 a=1DEMkN6R7iAM1vOmckEA:9 cc=ntf awl=host:12099
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI4MDA4NCBTYWx0ZWRfXx0ru2/L0b/AT
 PPyVHGaZ6yA2AWyjKP5UafnYz0DmXOON8p8feliGJeyKESVRn/gaqGU7hJN0K8tWaR0DC37h2ND
 KGf9CNd/odvIe9RYQpRllDZkszeQdfSBEFfdWUuO9lTbjShmKnDjJ31naf2O49GovD3HisJzukw
 UQmlg2pUO3cqurNH8wn9HhQSk1zSTIT7ReTGOed/CmVMEKw0z+ES+gB+kzAkmvQP7LDPMIVVH7s
 QVpjD7Lk4W/LpxPnt60Ih9w2iHvskvX5GXQSJWF0fU/+rOFyEPy/dt4URYYOTKXMHzO3FwDaFOe
 VcNJrRCGiycMW5HNh3il2qs40aH+sTmsv1ZqvuFHJ04531CkrBQ/I7kTL9G/MPQJoEJdAOSHTZV
 UKTwwjEB3DCVgXhi+mI9au2StRv2AJgSwLzbumvGEJMUVwqRpZI=
X-Proofpoint-GUID: C2twoiRNMmzKqvByyL11tVwCWmjWaUj6
X-Proofpoint-ORIG-GUID: C2twoiRNMmzKqvByyL11tVwCWmjWaUj6

Currently, kvfree_rcu_barrier() flushes RCU sheaves across all slab
caches when a cache is destroyed. This is unnecessary when destroying
a slab cache; only the RCU sheaves belonging to the cache being destroyed
need to be flushed.

As suggested by Vlastimil Babka, introduce a weaker form of
kvfree_rcu_barrier() that operates on a specific slab cache and call it
on cache destruction.

The performance benefit is evaluated on a 12 core 24 threads AMD Ryzen
5900X machine (1 socket), by loading slub_kunit module.

Before:
  Total calls: 19
  Average latency (us): 8529
  Total time (us): 162069

After:
  Total calls: 19
  Average latency (us): 3804
  Total time (us): 72287

Link: https://lore.kernel.org/linux-mm/0406562e-2066-4cf8-9902-b2b0616dd742@kernel.org
Link: https://lore.kernel.org/linux-mm/e988eff6-1287-425e-a06c-805af5bbf262@nvidia.com
Link: https://lore.kernel.org/linux-mm/1bda09da-93be-4737-aef0-d47f8c5c9301@suse.cz
Suggested-by: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Harry Yoo <harry.yoo@oracle.com>
---

Not sure if the regression is worse on the reporters' machines due to
higher core count (or because some cores were busy doing other things,
dunno).

Hopefully this will reduce the time to complete tests,
and Suren could add his patch on top of this ;)

 include/linux/slab.h |  5 ++++
 mm/slab.h            |  1 +
 mm/slab_common.c     | 52 +++++++++++++++++++++++++++++------------
 mm/slub.c            | 55 ++++++++++++++++++++++++--------------------
 4 files changed, 73 insertions(+), 40 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index cf443f064a66..937c93d44e8c 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -1149,6 +1149,10 @@ static inline void kvfree_rcu_barrier(void)
 {
 	rcu_barrier();
 }
+static inline void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
+{
+	rcu_barrier();
+}
 
 static inline void kfree_rcu_scheduler_running(void) { }
 #else
@@ -1156,6 +1160,7 @@ void kvfree_rcu_barrier(void);
 
 void kfree_rcu_scheduler_running(void);
 #endif
+void kvfree_rcu_barrier_on_cache(struct kmem_cache *s);
 
 /**
  * kmalloc_size_roundup - Report allocation bucket size for the given size
diff --git a/mm/slab.h b/mm/slab.h
index f730e012553c..e767aa7e91b0 100644
--- a/mm/slab.h
+++ b/mm/slab.h
@@ -422,6 +422,7 @@ static inline bool is_kmalloc_normal(struct kmem_cache *s)
 
 bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj);
 void flush_all_rcu_sheaves(void);
+void flush_rcu_sheaves_on_cache(struct kmem_cache *s);
 
 #define SLAB_CORE_FLAGS (SLAB_HWCACHE_ALIGN | SLAB_CACHE_DMA | \
 			 SLAB_CACHE_DMA32 | SLAB_PANIC | \
diff --git a/mm/slab_common.c b/mm/slab_common.c
index 84dfff4f7b1f..dd8a49d6f9cc 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -492,7 +492,7 @@ void kmem_cache_destroy(struct kmem_cache *s)
 		return;
 
 	/* in-flight kfree_rcu()'s may include objects from our cache */
-	kvfree_rcu_barrier();
+	kvfree_rcu_barrier_on_cache(s);
 
 	if (IS_ENABLED(CONFIG_SLUB_RCU_DEBUG) &&
 	    (s->flags & SLAB_TYPESAFE_BY_RCU)) {
@@ -2038,25 +2038,13 @@ void kvfree_call_rcu(struct rcu_head *head, void *ptr)
 }
 EXPORT_SYMBOL_GPL(kvfree_call_rcu);
 
-/**
- * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
- *
- * Note that a single argument of kvfree_rcu() call has a slow path that
- * triggers synchronize_rcu() following by freeing a pointer. It is done
- * before the return from the function. Therefore for any single-argument
- * call that will result in a kfree() to a cache that is to be destroyed
- * during module exit, it is developer's responsibility to ensure that all
- * such calls have returned before the call to kmem_cache_destroy().
- */
-void kvfree_rcu_barrier(void)
+static inline void __kvfree_rcu_barrier(void)
 {
 	struct kfree_rcu_cpu_work *krwp;
 	struct kfree_rcu_cpu *krcp;
 	bool queued;
 	int i, cpu;
 
-	flush_all_rcu_sheaves();
-
 	/*
 	 * Firstly we detach objects and queue them over an RCU-batch
 	 * for all CPUs. Finally queued works are flushed for each CPU.
@@ -2118,8 +2106,43 @@ void kvfree_rcu_barrier(void)
 		}
 	}
 }
+
+/**
+ * kvfree_rcu_barrier - Wait until all in-flight kvfree_rcu() complete.
+ *
+ * Note that a single argument of kvfree_rcu() call has a slow path that
+ * triggers synchronize_rcu() following by freeing a pointer. It is done
+ * before the return from the function. Therefore for any single-argument
+ * call that will result in a kfree() to a cache that is to be destroyed
+ * during module exit, it is developer's responsibility to ensure that all
+ * such calls have returned before the call to kmem_cache_destroy().
+ */
+void kvfree_rcu_barrier(void)
+{
+	flush_all_rcu_sheaves();
+	__kvfree_rcu_barrier();
+}
 EXPORT_SYMBOL_GPL(kvfree_rcu_barrier);
 
+/**
+ * kvfree_rcu_barrier_on_cache - Wait for in-flight kvfree_rcu() calls on a
+ *                               specific slab cache.
+ * @s: slab cache to wait for
+ *
+ * See the description of kvfree_rcu_barrier() for details.
+ */
+void kvfree_rcu_barrier_on_cache(struct kmem_cache *s)
+{
+	if (s->cpu_sheaves)
+		flush_rcu_sheaves_on_cache(s);
+	/*
+	 * TODO: Introduce a version of __kvfree_rcu_barrier() that works
+	 * on a specific slab cache.
+	 */
+	__kvfree_rcu_barrier();
+}
+EXPORT_SYMBOL_GPL(kvfree_rcu_barrier_on_cache);
+
 static unsigned long
 kfree_rcu_shrink_count(struct shrinker *shrink, struct shrink_control *sc)
 {
@@ -2215,4 +2238,3 @@ void __init kvfree_rcu_init(void)
 }
 
 #endif /* CONFIG_KVFREE_RCU_BATCHED */
-
diff --git a/mm/slub.c b/mm/slub.c
index 785e25a14999..7cec2220712b 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4118,42 +4118,47 @@ static void flush_rcu_sheaf(struct work_struct *w)
 
 
 /* needed for kvfree_rcu_barrier() */
-void flush_all_rcu_sheaves(void)
+void flush_rcu_sheaves_on_cache(struct kmem_cache *s)
 {
 	struct slub_flush_work *sfw;
-	struct kmem_cache *s;
 	unsigned int cpu;
 
-	cpus_read_lock();
-	mutex_lock(&slab_mutex);
+	mutex_lock(&flush_lock);
 
-	list_for_each_entry(s, &slab_caches, list) {
-		if (!s->cpu_sheaves)
-			continue;
+	for_each_online_cpu(cpu) {
+		sfw = &per_cpu(slub_flush, cpu);
 
-		mutex_lock(&flush_lock);
+		/*
+		 * we don't check if rcu_free sheaf exists - racing
+		 * __kfree_rcu_sheaf() might have just removed it.
+		 * by executing flush_rcu_sheaf() on the cpu we make
+		 * sure the __kfree_rcu_sheaf() finished its call_rcu()
+		 */
 
-		for_each_online_cpu(cpu) {
-			sfw = &per_cpu(slub_flush, cpu);
+		INIT_WORK(&sfw->work, flush_rcu_sheaf);
+		sfw->s = s;
+		queue_work_on(cpu, flushwq, &sfw->work);
+	}
 
-			/*
-			 * we don't check if rcu_free sheaf exists - racing
-			 * __kfree_rcu_sheaf() might have just removed it.
-			 * by executing flush_rcu_sheaf() on the cpu we make
-			 * sure the __kfree_rcu_sheaf() finished its call_rcu()
-			 */
+	for_each_online_cpu(cpu) {
+		sfw = &per_cpu(slub_flush, cpu);
+		flush_work(&sfw->work);
+	}
 
-			INIT_WORK(&sfw->work, flush_rcu_sheaf);
-			sfw->s = s;
-			queue_work_on(cpu, flushwq, &sfw->work);
-		}
+	mutex_unlock(&flush_lock);
+}
 
-		for_each_online_cpu(cpu) {
-			sfw = &per_cpu(slub_flush, cpu);
-			flush_work(&sfw->work);
-		}
+void flush_all_rcu_sheaves(void)
+{
+	struct kmem_cache *s;
+
+	cpus_read_lock();
+	mutex_lock(&slab_mutex);
 
-		mutex_unlock(&flush_lock);
+	list_for_each_entry(s, &slab_caches, list) {
+		if (!s->cpu_sheaves)
+			continue;
+		flush_rcu_sheaves_on_cache(s);
 	}
 
 	mutex_unlock(&slab_mutex);
-- 
2.43.0



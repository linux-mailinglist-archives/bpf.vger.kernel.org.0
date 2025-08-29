Return-Path: <bpf+bounces-66975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D2B30B3B926
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 12:46:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2E921BA4037
	for <lists+bpf@lfdr.de>; Fri, 29 Aug 2025 10:46:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B70B626AAAB;
	Fri, 29 Aug 2025 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="I+6pGwE2";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="LkOQUd3J"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC5D28C0B;
	Fri, 29 Aug 2025 10:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756464391; cv=fail; b=l5MZNNGesphT3n7e/WhHLLmINbpWiNxGAaSLbTLhhpwk3yxxM+M5eLhNW3SeqIjx3yL+XS4EyyhQJMKWSaBouiXWm2Y7dxjZexHhf/xJY6kXjfqUpw3brTDQJ+Pk80shbFR8wmQL3mIBVSy73sBHfoQfBLT0ipSM8y7y6wbQzZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756464391; c=relaxed/simple;
	bh=RpcwOgqu0H9MihtaaMOGTlLrfv7vHky3ey7w5cQr87I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K8Lel+vPydbK4Xd49LApc4uDq4hwO5z103xynWbklnL0EfrlGMhiZ4+6R8eg6+9joWFOb77e0an+LScx0J5rgz8CccCxUYFZuPVJpjjEmhiOg83va7AkkN3z4BdBSngNJFxrn5VgeeOMszSQ2HXk/kco+0/67sksLpTEsuwZxOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=I+6pGwE2; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=LkOQUd3J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57TAYAho007172;
	Fri, 29 Aug 2025 10:45:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=RpcwOgqu0H9MihtaaM
	OGTlLrfv7vHky3ey7w5cQr87I=; b=I+6pGwE24E5zPzADfcNdWp67+1C11wlfXR
	LpNWrfkyhB1cyWozA81Gz2Xp7nzMM1MZwYNOMynLj91vTWYj2d0bLG63DN/356id
	xTDmXl1UmXYL8GVYBl5YljFBdqugjmJA25Ta7UBDfXXQoA3q7PyrnhiQRcfxluZ5
	Fwjv0qgihQB5201EJZCOX3fKqbkV1wPpRWC3DZp1yLqLXech/an6gXJ0AsyGgXi0
	S7wdn1hFTK8JnzO0w5cDi83oB70TcxIG/jFQZLWnJ8aQggtvIdH1gWyUH/MDnNSg
	iaI3qyfnyzLILPS+BhGd8lNZlrueq8RLyZin/vhRO5cg2ifRyeDg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q4jat9c5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 10:45:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57TA0O54005066;
	Fri, 29 Aug 2025 10:45:47 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48qj8d87a5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 Aug 2025 10:45:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=elOGejI7UsNDLx241HZbtwksyhsygW75ENK5lET6otYc4fHvMKyfmS2Ij2ZW2n8W9uIHx30lAhdFm9/ACA70j2bGDw7XlUrpKAHYThSVmqxa3biCbd6J9otEkdCcn9J859l3HopBsWKeqOiFmD+WS4CFly965zhy2VZmI3D3A2q+V2zIJLIvol3eXyEg6R6ZbY4b44lRGdl9cV/SvFIN6EMSWo1X9g6mFrlOGIdluO1xI2Ad9gZIzk8xWXv6uyliOYX5ChsGtcohIFVo9SV0n4W9UKu0V3xYYaW9twx9Ka/bbRD9Flx7XZRgwO5GiVfq9nmGlxtzmp3hIf0ag8YiGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RpcwOgqu0H9MihtaaMOGTlLrfv7vHky3ey7w5cQr87I=;
 b=L6SnFmxIwWMYLCIMfrDXnEop6+vQ3J6nLgVAAfuvT4LJOMTTwz1dMavdKWRnYHmn+SIp9XdY5UuRyBSDtlpvsb1I6A8v/Orkt2UradqL2LPPnXP3xAGyAAM3oOKRC/NA9kewz0DZzDhGkjnMDS2qLmvuzK1WCxOSe3RxsP/NRL7i6OEyEGYq3KK0wuv+0OI/PRugaWd0DpSmS6XHlSB7MWT2i7ADaFHOCdfOMCnuDSxwVomLgUBFWJF9kuV2m2tr/WDFgkhyvzzkF2r+LcLCEPK8l/+oecIQkm23RlVB/SNZ2v94a84Q6grfOq3ecPLXelkY9rUAD5seAkUR/wXEQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RpcwOgqu0H9MihtaaMOGTlLrfv7vHky3ey7w5cQr87I=;
 b=LkOQUd3JYqtYJp1hHhc8Xh+M5Anw3yWkuHQIY+VgP5KCecpDoLVVC/8VYhHxDV1i8rGLHMf6TL9gbjSj4JeaNDxPUAADdUn4taUbdYCaEqaD6djMp76SiufGWDGLu+BG7mxC+qY5dpjyXCfJNtArHvqzr+z2lCEGjlWBIPRPymI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by MW6PR10MB7614.namprd10.prod.outlook.com (2603:10b6:303:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.17; Fri, 29 Aug
 2025 10:45:43 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Fri, 29 Aug 2025
 10:45:43 +0000
Date: Fri, 29 Aug 2025 11:45:41 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
Cc: Yafang Shao <laoar.shao@gmail.com>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        bpf@vger.kernel.org, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>
Subject: Re: [PATCH v6 mm-new 02/10] mm: thp: add a new kfunc
 bpf_mm_get_mem_cgroup()
Message-ID: <5b7854d3-667e-40cf-94e3-f0d887cb514d@lucifer.local>
References: <20250826071948.2618-1-laoar.shao@gmail.com>
 <20250826071948.2618-3-laoar.shao@gmail.com>
 <299e12dc-259b-45c2-8662-2f3863479939@lucifer.local>
 <3m6jhfndkoshnoj76wyjjgmqa55p4ij4desc45yz6g7gbpxnrd@xumacckayj4t>
 <46cecd34-9102-48fe-8a98-091aff6cc88a@lucifer.local>
 <gkhxoowgcfvoj5wwbaji6v7wpizj4imwyxzrxnmw3bbd3u6eg3@ekfuuadgpeer>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <gkhxoowgcfvoj5wwbaji6v7wpizj4imwyxzrxnmw3bbd3u6eg3@ekfuuadgpeer>
X-ClientProxiedBy: LO2P265CA0256.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::28) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|MW6PR10MB7614:EE_
X-MS-Office365-Filtering-Correlation-Id: e46ec9e7-529b-4272-8d4c-08dde6e9342f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?F/aQYyJQiJsSbHiqw3ZinTM3LiaNNQH+eGsE8cSi3UERYo6rp2p2W4YenTcX?=
 =?us-ascii?Q?atVxqjnl5G5tdOEuav74cbVgMv//4cNpZ719OOAnhu3GGa8PdD5h6+4d9wMZ?=
 =?us-ascii?Q?KydpjNtQc7DjMgnwgozLrZ41rv70J/IqyBwbHyAlnLLfLAlLivo/lKLtfPxP?=
 =?us-ascii?Q?C9rPzGBhTQN3DdzVXm9g5KS6971BcXT+Gn4/z1t0tnlNVp4GRdvTZpsg7TTt?=
 =?us-ascii?Q?nU5J+SusEBOl6FozsCRu8azqAQnkybj5ogRclh4cDMO5lOSw+YZ+OZPgPBoq?=
 =?us-ascii?Q?st5VtOb3BWc/+3ZoVsaHbi6T4xkg+fHNoV7dv59ZLuCN/iwIF5REBappXjaH?=
 =?us-ascii?Q?MZQZuXxJZv1oZewjwXM5v/Qfz/Nj9GqnicJ78tTjwyiZ2TwTwSE9141Rpg/z?=
 =?us-ascii?Q?fBNCEKIf2zo+F3qZOoDjY9jBKIlV2bzE5UV7MHHmLuoHo2/JMZdjBBiIRPbU?=
 =?us-ascii?Q?KE1RJPj/+aEItE8KqrQKNhgG9S1dXPYL3WxtfiQbM0K8NZsggGw4GDBJ56z8?=
 =?us-ascii?Q?TTPeMxftVbwQGB5QpiOFOvaFIhj4X3zWpW0NseoYKCP142OkgkBL4ZyCKNEX?=
 =?us-ascii?Q?2l31E4kWluKvJ1p/ORpMC2kcopWZjMMAYgaaEsVl58GyfR/GnXQPWMzreJcp?=
 =?us-ascii?Q?nK9T847aDTILbIDcdMIQg1hyfgzjjZ5UizcGlYiZsuccPNV/1syKwN6JxDnr?=
 =?us-ascii?Q?VK9NlyWhzDaZ8Tprywh40/iS9bkt1cdj8OiAiL2wtPjIyQzXUpO8hCT+NTnw?=
 =?us-ascii?Q?Cd3LIj48achBzu8uRfI0tPrn8vbCx1FdmU3onidHbIAJmOFTM+nLkGBJX5sP?=
 =?us-ascii?Q?zpuNGuSy16bCXzK2SE+nUA+ErxeXs6pNHkfFAfT0IlU5lhh/mxBrR80C20Px?=
 =?us-ascii?Q?Z75VVrW3xNiKSPfX/DDr62+pPmMjqE9PK7oFaGo7xFXbKTpTBQjlEry3uEdT?=
 =?us-ascii?Q?ZgzPcObX0sNZyKJI1RhnKWWJGOqr6Odzu3d59k/u8dp+LSWZZ30O0MKPwb/4?=
 =?us-ascii?Q?d2WsnKeU744CBEkDlO9IrlrGLKWjUZ5ByaPvOVXfPTdQVSAxnWq8dCfYP53R?=
 =?us-ascii?Q?+cB9DN8PDr2KKnWevZaUO82Ai4HotyVw1UXnoqS/WgUbv/jlRgAp0NrItnEm?=
 =?us-ascii?Q?my0ASNeZ2geptHxDIFGqQzoDGktrZ+HuXv/0Ktlqqf9bWOSYJH88USjxrSb+?=
 =?us-ascii?Q?vMCM0WS+t2eckmVcU2R38wg44EOcplPvLgVovWYT/ZGL3t78bCw7NmCGJyLj?=
 =?us-ascii?Q?MEcQ9HVSOXqgdxs9Mt2uVst4bytlK5yAS0QQZVpHghbS8XGm7ZaO/KuSy3b7?=
 =?us-ascii?Q?Wy9Aw8FxeNG2P129ZaKU/yoBO4jsNNcqohW8qjzJY1ItR5IG90ezPmu2XRbM?=
 =?us-ascii?Q?0h55fbmwoPhvQQA2sjF05SN1bLElcMmcnQ8RkS3eTQY7dAlLTRLWCLV8e1ZK?=
 =?us-ascii?Q?GtKwCE+Z6yI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9m2DFWHQyaFLZlMd/rgPSgUrD56x+iBl7BejiXGtEmG/I1yh2DoOwac/KATq?=
 =?us-ascii?Q?ClyYtYdKsIccwAnCbPyvGgR5IJYErh52bKXK7OJ0aGD0aBc557ZqoNKyCUxk?=
 =?us-ascii?Q?KVVhnbNnmyvWVMd5xtgpjymkdjtgwn4faqsiwaWawWRXk2XGqtVtnAvP91cW?=
 =?us-ascii?Q?JzyNYRdKdj9yJr2rJkh9po3+2QvowC5qcmsGtd34hB1QvgiUr3gRnxQE/P8m?=
 =?us-ascii?Q?pCWV+glXIG9hIxamw31V4ZSNQocKgcVpjvK2lvi5NsOdGi27npbd8s7T/rpn?=
 =?us-ascii?Q?5Hb3XYXX7tda6L2HniXNa+w78IHKYE9vlitQy6wtO/thRoKsvnlXLuNP8/Qi?=
 =?us-ascii?Q?yVXQdoZJrOCt4EwDWAoeL2Vg5TCwbpqCF+N67V1PcNmNZDmS4T/qHsbFwrY9?=
 =?us-ascii?Q?QSTxj291obkVeXlkmm6rdlxIBu8CjKSLOUARkWlnnnkh4sL2zQ+6zpkoKBVr?=
 =?us-ascii?Q?9Nr4gJP1e3NOBMDh4a5Qv0c6z2VrjBzaC1tp6nXyeZLDBRlZJLOfdE7KAhYj?=
 =?us-ascii?Q?V/Qt6MKS0MfvQUv97Nc1hGUf4pKi+qfUk2QrmN1o4wp95wpZSGKsdGFYrl1k?=
 =?us-ascii?Q?BASsEmmRPcOoZVFcbNiI91D8/hFme8hi0HZ4oSaxgzf7twmgEdh2U8IkHt2M?=
 =?us-ascii?Q?BWgUSaHgb/1/LDNUJqbiZrq7W0t5vHIVUqEZ77AR6tlAjNQd2bwNTeHfrbaR?=
 =?us-ascii?Q?tsfmZN5v2ExbisKhb174uO7AehZ1jXeCfEPKXLbCwq21AfzNx+X16OWjkKE9?=
 =?us-ascii?Q?HRNsZcNrocINvNhpo/jNQQslVjP2+pXrpapvDR0UZ1w4aF/LWmvLP67H2+RU?=
 =?us-ascii?Q?L75hCEjlsUTSFIPJYkLUcEUnDo2VW99NRfebP5chd9Bzg/YX3PT8kvoRC5IT?=
 =?us-ascii?Q?ipEe8UcQaBJdEmLHOe/mswOOSuElMiCluzbbXJh4xzFcObUbfK+5vb4HJu+n?=
 =?us-ascii?Q?JLg58Qs9kWvlynTBbDgF3c90ktcJJ7UJ+hNJm+RGMLkhZrWzi7U/+9N3fQOW?=
 =?us-ascii?Q?4cMP7ARdPkqXI2O5N37R1j4tLq827ySFJUV5Jz9cYqK4yHCFGPVznbrusInD?=
 =?us-ascii?Q?o/NGxxX/2Hk6gvsxqjPXBhHWvgWtkVwNQFMGLsPrGuOJRPTMJJs+OHZ67DvL?=
 =?us-ascii?Q?YVnRpbs86wq4l+mEzn2L4177B39XXZ8qhCETqwzCU0Ah87w4Hne1VPqXKeB3?=
 =?us-ascii?Q?Gc738tmuIDTljjXk8UWfsGc1rmhVgqCheJeEdbWku6ZL0NUiBpCCylcRUEK0?=
 =?us-ascii?Q?EMhNZmAP42THd0phR1ZkubeNtTcyW+tfsbXixsN1lq8xtux1C7dkshJXKU0y?=
 =?us-ascii?Q?xUOeRLlpGgVD/nvAdKXDRCmUkYzDeCp7okpGz4Y48Raflt4OQU5KZ2hkmjen?=
 =?us-ascii?Q?4ahwB/1zgrRvdagublKBYIeZrPrPLzQauhIf/xpBS20nhksDVa3FqKzDortT?=
 =?us-ascii?Q?195qt0wS1dTWCv8g18Kh8Ld+TuMSfQ65B4JD4dJTV4Zv0f7LCeq+4E7OjmMM?=
 =?us-ascii?Q?Fuk3OopxCs0NOTQEKI/XNzhtr2Ni8RZbRdrkMLFf9UKPLp/uefboDrWdV5l5?=
 =?us-ascii?Q?MxngalZUynstvXTcSCTOv+2dsHYlBY+UWrSB+O95uzqdOeX5U6obpICBEUS+?=
 =?us-ascii?Q?ZA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tDugEdw9Bs6R1JBVnaTcamxFC4uIgU5wIr3ENX8VmhlJ/oqLhhipddVeJopAn50//1UdPYbSP9/KJQql++IVua54OPSjCJd2+NTLkVfYWmlauhYClWITcc0QKz8kTGB2fIgAjsmm7op6iWMUSg4v7Da24uJcEiKYWjQiMkDYjf1ckRMrqYUtBU0GD85kqhW4CcuZ0fCNw40PPr9+Aawt5BwiBwC4f8MUBwOdCIgCWppKuBKZbkB+DWBT/h4F3kHEGciAeecjr6my6OLctPLOMfvf4s1vw58NWhrvlJCnX3a+AvyLbvUNgBEv1KBNHTF0kjeZ2Hcj//oxt/5ST7ftVREWEfrxAptTpUD0dODDCogj9MtwosCQapgWBqS/GZoz71jR4SVSYxmNsHbVu0072vOhuurjBVWgJWqDZZODFsL3e2PcFF9tbTcQeMiRZ3CVxQBpvSC99fCL72Ck5S7lb99WNy6JJ8gIZEcFoH/lNMat0jg4Y2gdCJKRsGsz3u7g0mXv6IBwtoIiqIUvyhnosrCDGuPdiit2Jox0T9eMJJlbKdW3izaRpioOGxQ/i3Q3b1BJ3wwJHQk/XWmbzvRftVVsXBnt5za/OnL87ZYh5s4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e46ec9e7-529b-4272-8d4c-08dde6e9342f
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 10:45:43.4427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /yHazjD5ygf6axMdN6yTNUp21cxmppMM1E/Ij6aQ1NOuzdf5iPnGJZio27ywa1eDXSgW/56IjtVf0lp/DqNN9o7SkL8mrBTqKRz9zrZlIgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR10MB7614
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-29_03,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2508290090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAxOCBTYWx0ZWRfX7Zp9XWmhjSVh
 Znya64lOCIIainCja1k5fXtltAgh3lEtzjfafaqMQLLNl82kgN+mIqVZ2QTORnzWYCXsYmLy0hh
 FD9qlIjqNE4wcP9hWk4m3TSv5eYrOv+VfW9joLck/wpchcXr3wrdhb3DuFQs5lzslLq7m8ikAnq
 Ijyc2H9L/hhLTaPV1V30kwph94odH8dVpd7hxNCRaOvr5/Cad/7el2K2ltjjiMPPQhmCodW5LXA
 vSK0N0aTP8UlF3P8nhvYDAxZOJe/XQQy/QJXzhI7RKAT1eMLk9BP5/0VgZRNxUP395UWw64GEKa
 R9Bu7z6O8Wyb+YRQK5UEWDKORDyAFswplW6X3NZXF0NB3X8SxWfhcFZczfmDdDuSPbJGdsV0QLb
 NBgkg7lTheWpogNT66tjB0cEzoffUw==
X-Proofpoint-GUID: m3CGyuuzsWLIv8uy6pgln40ysNubTNnM
X-Authority-Analysis: v=2.4 cv=IZWHWXqa c=1 sm=1 tr=0 ts=68b184dc b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=koE7ePHafgE9zV_aCwgA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12068
X-Proofpoint-ORIG-GUID: m3CGyuuzsWLIv8uy6pgln40ysNubTNnM

On Thu, Aug 28, 2025 at 09:00:15AM -0700, Shakeel Butt wrote:
> On Thu, Aug 28, 2025 at 11:40:16AM +0100, Lorenzo Stoakes wrote:
> > On Wed, Aug 27, 2025 at 01:50:18PM -0700, Shakeel Butt wrote:
> > > On Wed, Aug 27, 2025 at 04:34:48PM +0100, Lorenzo Stoakes wrote:
> > > > > +__bpf_kfunc_start_defs();
> > > > > +
> > > > > +/**
> > > > > + * bpf_mm_get_mem_cgroup - Get the memory cgroup associated with a mm_struct.
> > > > > + * @mm: The mm_struct to query
> > > > > + *
> > > > > + * The obtained mem_cgroup must be released by calling bpf_put_mem_cgroup().
> > > > > + *
> > > > > + * Return: The associated mem_cgroup on success, or NULL on failure. Note that
> > > > > + * this function depends on CONFIG_MEMCG being enabled - it will always return
> > > > > + * NULL if CONFIG_MEMCG is not configured.
> > > >
> > > > What kind of locking is assumed here?
> > > >
> > > > Are we protected against mmdrop() clearing out the mm?
> > >
> > > No locking is needed. Just the valid mm object or NULL. Usually the
> > > underlying function (get_mem_cgroup_from_mm) is called in page fault
> > > context where the current is holding mm. Here the only requirement is
> > > that mm is valid either through explicit reference or the context.
> >
> > I mean this may be down to me being not so familiar with BPF, but my concern is
> > that we're handing _any_ mm here.
>
> It's not really any mm but rather the mm whose validity is ensured by
> the caller. I don't know the BPF internals but if I understand Andrii's
> response on other email, the BPF verifier will make sure the BPF program
> is holding a valid mm on which it is calling this function. In non-BPF
> world, get_mem_cgroup_from_mm() assumes the caller is providing a valid
> mm.

OK cool. The verifier aspect of this is really nice... :)

>
> >
> > So presumably this could also be a remote mm?
>
> Which is fine as we already do this today i.e. page fault on accessing
> memory of a remote process.

OK.

>
> >
> > If not then why are we accepting an mm parameter at all, when we could just grab
> > current->mm?
>
> Because current->mm might not be equal to the faulting mm as in the case
> of remote page fault.

Ack yeah as per above.

>
> >
> > If it's a remote mm, then we need to be absolutely sure that we won't UAF.
> >
> > I also feel we should talk about this in the kdoc, unless BPF always somehow
> > asserts these things to be the case + verifies them smoehow.
> >
>
> Yeah some text on how BPF verifier is making sure that the BPF program
> is handling a valid mm.

This would be nice indeed!


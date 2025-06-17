Return-Path: <bpf+bounces-60790-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A138ADBF18
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 04:22:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 526FD188F512
	for <lists+bpf@lfdr.de>; Tue, 17 Jun 2025 02:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A42D221F11;
	Tue, 17 Jun 2025 02:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="IkowAIEg";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NeN6gvID"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8C02BF013;
	Tue, 17 Jun 2025 02:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750126908; cv=fail; b=uQIzd2yTDx2i5ngTLcIgpZjieBGkiHqBhkONSf6Qm9y5X9VB9Rcy1vT7svM55g+TNJpuiGL90PFoUoNC2V0C24R3/vVEsDJrs2EPB3Zc6yCu6a8jF46YzKM5CyXqKORTE4RpUvyjDHJd4t7DqJmeIYARASDVimkus7dYJzVXnhs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750126908; c=relaxed/simple;
	bh=HYfOYbkA+6WRKwn8oVZoW4sD89zb77MBmEXfxf7XLS8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RLr/ctFDq7HaUyZAlkJso5pWJcvm+Cax7TyJMYeOHHpKyr/QViypDQj5/y9YOSILT+uB6s9NRR3Xl3S6/6WzcBowV1KV4CgtOSzFr5VF6pvLWzXXmXWLqTWKt4G0EmgN/fZtEzLkWQvA9I6XYYzgx9NGkSPWy6NK1CxJyMVsO9I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=IkowAIEg; dkim=fail (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NeN6gvID reason="signature verification failed"; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GLYq8d017638;
	Tue, 17 Jun 2025 02:20:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=r5vYnadNwzN/GudwMLIVqHSadJhjhnQc+AyI4kEZ2tA=; b=
	IkowAIEgN8VnJEFfPyt58/HDcNxVJPwlvqfong+v9Xp9n7eyB3zHu27dywHXFJ/+
	S5IefkKsHjrzzilwG0iLv0F0hSFdR0JhzgCaWWm+YY6wMC/UOmqmHtpcM1GJFG01
	GfG3kl+v30HAi84ttE2BRzb+87Srrcp9+iTwxP4060SHN/IL6powtgdMqGDqFcOW
	pOZC5AdQGKw2m4yNLYl3YUdHBPJJMzKREWzxMo/WHuclCUHIXH971oZzPef2oBkS
	/N7SqKA/XD612XNBd/0T2ry9w67SAxrdOyk35tUOD4MH3nHyaPlpHQv8IcZ4zWPq
	AYsuc6FiHNba44f/tKb/7Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yp4md5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 02:20:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55GNLjAB001886;
	Tue, 17 Jun 2025 02:20:56 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2074.outbound.protection.outlook.com [40.107.223.74])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yh8nhn9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Jun 2025 02:20:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GIpH1FaZZXB34KynoIX6nS2lcQRaw2DW1GMvbnG3DJB0T36YFmmFbmVCOT+85eSiRrXD/BTusAKERsjGWJuK6yBX1piRSf6JM/WJXxT6BNveR5yvwqFyCXXWYEBxtVyJRvQw9QjB5jvefpdbiiptWqEV65qxXI7p1rXH6BOyhlzEw8UdEWzzA9qsZFlurM9h9/tXM7wcI9zhFBd1qwwBxuH5TT9wRxXauKVn1GHT/PBfR7JYThFgXuDO2e1EqcWKDxNgR9YJ9DUKxjyFOXEp8vf4wlQBSUnMyJSG+uMpVZS4e5UDYHCBe547BMTwQguL5Zb+aIdCLh8NHwrw4ysscw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wDRdmzpI8nldz54MjKKS9EUW6Z/ZPFEB4E7wfyQcoA=;
 b=qYa8WInU3vpjbaGgqJarc8yydGdMQX4KG/+ELsivlnkYNvoSR66T4bRLB69XFIRvyHLUPV20e28jeHddko2KgnucrNxhkm87BLriG6lXoHwmKyGpmOmxLEN2xrn7OuUlqCLpRQFv5OqZBJDF+9Vybr0uYlGpKoRQ4AmbAOzaXzgF0f+VP1GdUkyE3bkC80e5Gdiv0uxsyr9j0nUIH1S1JrXx5Dpl0kiWJXAoQAAZOCC0XtqhC+bSEYshQOWOVRCXZeeLtroN///AZeMwQirC7+b9jUiL+LB3rz1WsdZBrJ9zYQl/yjNehU5GX/Z0JBXovKSDrRObN33hb5EXPtR7PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wDRdmzpI8nldz54MjKKS9EUW6Z/ZPFEB4E7wfyQcoA=;
 b=NeN6gvID415qa6cEKmOEcFUAyNhRHR39YpAi3w3etJzo0XwjgvRCl3o1zLKaV1BiXZy4O2dO5k5SvGzbvIv32IjNmGvT6h0FtGbNILiZVmZa7TKVxb2q1vkaHpy6BnukK/yl6ozBnW06bJEzhEC3/S4k5d7lArIYlbHbE5iQOb4=
Received: from CH3PR10MB7329.namprd10.prod.outlook.com (2603:10b6:610:12c::16)
 by LV3PR10MB8179.namprd10.prod.outlook.com (2603:10b6:408:28a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Tue, 17 Jun
 2025 02:20:54 +0000
Received: from CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23]) by CH3PR10MB7329.namprd10.prod.outlook.com
 ([fe80::f238:6143:104c:da23%4]) with mapi id 15.20.8835.027; Tue, 17 Jun 2025
 02:20:53 +0000
Date: Tue, 17 Jun 2025 11:20:37 +0900
From: Harry Yoo <harry.yoo@oracle.com>
To: Byungchul Park <byungchul@sk.com>
Cc: willy@infradead.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, kernel_team@skhynix.com, kuba@kernel.org,
        almasrymina@google.com, ilias.apalodimas@linaro.org, hawk@kernel.org,
        akpm@linux-foundation.org, davem@davemloft.net,
        john.fastabend@gmail.com, andrew+netdev@lunn.ch,
        asml.silence@gmail.com, toke@redhat.com, tariqt@nvidia.com,
        edumazet@google.com, pabeni@redhat.com, saeedm@nvidia.com,
        leon@kernel.org, ast@kernel.org, daniel@iogearbox.net,
        david@redhat.com, lorenzo.stoakes@oracle.com, Liam.Howlett@oracle.com,
        vbabka@suse.cz, rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        horms@kernel.org, linux-rdma@vger.kernel.org, bpf@vger.kernel.org,
        vishal.moola@gmail.com
Subject: Re: [PATCH net-next 1/9] netmem: introduce struct netmem_desc
 mirroring struct page
Message-ID: <aFDQ9X2WsXszNJ5M@hyeyoo>
References: <20250609043225.77229-1-byungchul@sk.com>
 <20250609043225.77229-2-byungchul@sk.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250609043225.77229-2-byungchul@sk.com>
X-ClientProxiedBy: SE2P216CA0095.KORP216.PROD.OUTLOOK.COM
 (2603:1096:101:2c2::10) To CH3PR10MB7329.namprd10.prod.outlook.com
 (2603:10b6:610:12c::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR10MB7329:EE_|LV3PR10MB8179:EE_
X-MS-Office365-Filtering-Correlation-Id: ee461661-b1e0-4636-7e0a-08ddad45959f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?iso-8859-1?Q?E/hRH+JcuIpCHunZdOU9oT7eNI+OX+MLC+if4bGyirt7tXrT3qCilBTQx5?=
 =?iso-8859-1?Q?NK3TCcY+ts1butC9MalAy0jJ2qieCWhqzqUyLsYmzEEHLar3wMNoqb/RtH?=
 =?iso-8859-1?Q?FEJgl/g2K/LzJOkWgL8EV/BUcL20QxcKqdetCc/9dcd70ClW7E93/zGwoi?=
 =?iso-8859-1?Q?f4hF2xdw2tuWKAryb5YItmUH2rWLVydSIC6heSZcWavPCK1m8vnB5CUFlT?=
 =?iso-8859-1?Q?2p07LzsQntSOMhBsEdDZuguMRP5vJKb/SdzA/JDeIZ9DgnTiQi5BivAmsT?=
 =?iso-8859-1?Q?Re4s5G7VvI0VoBr9TtUxzWWH5UKJY2aTC78UeVs6EHG67QdUqtUb0qRnXe?=
 =?iso-8859-1?Q?VmM2NadhV3wllGErbKKgGiZiGezl9hicATow4A7ujUocwNuEpSR3uw7wSO?=
 =?iso-8859-1?Q?s1UZeYbFnE7nBhj7g12D1tEbwD6rdBsfC2od+iY/VfSC86VDfVvNwZ5AaZ?=
 =?iso-8859-1?Q?VzTCZso/W9a7ZMg+Vqf9PsSFdsw1H8UqtZe8arG3GXsjWZAsjP0g4bKLBo?=
 =?iso-8859-1?Q?5lDV+P7nE8Dx75i3XIEijUzp1zrQipSrVJM0Wi7qI+Di4he7Zxm/tSGREI?=
 =?iso-8859-1?Q?hIPbBRWE1Z7rOFX9t4DrKkXeVdhXP/0dN3LG+OKFpFQl66OtQoAl8Ipxhe?=
 =?iso-8859-1?Q?ueMrpjOoa/YGy2eXMoMMiBB+TkWywqQES9Ofp3E+BTn6qoBtpcZO30CFi6?=
 =?iso-8859-1?Q?uzK2O9prlm/8G7FE1dsjYZHJs+IEAQClmavzzMkoYj8pKyHn0HZDOXzKjR?=
 =?iso-8859-1?Q?8dKfiLAODYNKrY/jKpTy8UkRR8+rEZs8vZELfBqcvjfIouGDDy5CwUoYdR?=
 =?iso-8859-1?Q?03ihY7mek9mSXfrIAFIX8x7brYKfDPHh2V5NjlUcA0+XDQA4RDT3sff0y6?=
 =?iso-8859-1?Q?pWRKdmPszMRGMPl6i9mgIgEJq1oBrNRakjg4ZdGMH44d3+OMZbr5EbRIXb?=
 =?iso-8859-1?Q?P0XuyNnLDbmRNjC/p9VnUZLZqZ2Ytoz2ftIK+KdtdQVlJy985OGEZV+T9x?=
 =?iso-8859-1?Q?FNe5vftHlmUNfR1HwRVy6i0OPlkqlL2niYBpdxixDY3oUUGFI4hov7GTyX?=
 =?iso-8859-1?Q?2Y8JbNcRRaXrVwVt/kEeKlaNOzKLnpze/MIFt1Fyb9MAJwycIm5je+AgmK?=
 =?iso-8859-1?Q?cnXQlOSTqAx8edyZGqdywUEl9XFfwKyuXkBIkcXVSBOxk3uVbIWd2G35hU?=
 =?iso-8859-1?Q?OM5aOGrIIgXQ5W3FQknYC0Jnkag1na1wUJ94J+W4SV/zm4Krw40N8bJgf+?=
 =?iso-8859-1?Q?H6mQK2KZVaaaLJYK8uU74MUGW94Vgv0ydyxlgoY04W/DLLymTgO8fzd78l?=
 =?iso-8859-1?Q?pH6eLagkoPMka8xR06tKSC7Ygi/ZNf2fEqAyN+YAE44Tmvfz/xRZsPpIe4?=
 =?iso-8859-1?Q?5RYVwBsz9uv/XthA+Rz01ERlm0jQol0a5e8XK0noRMC+1ilus1jHSBGtW8?=
 =?iso-8859-1?Q?5yG9w9Tjur9GvOt3AOMcICWV4nU3KU4Sr812O6jJBSvHa49M+76svm+vSx?=
 =?iso-8859-1?Q?I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR10MB7329.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?iso-8859-1?Q?S4mpuVd6WPO5bbNBA8xPH4NcVuv5fUzTIWLo0wmWUP2V00xN3c/wrwhXYo?=
 =?iso-8859-1?Q?R0Z6LpE3AGq/YCEp5BpyY5NOyuLs568FY1o8WrR/KjwDVwv+t6gf68eRMR?=
 =?iso-8859-1?Q?UPEjClscaiqP5vzhho9As1focvwqQsiSEBJaK8jjrveEtQuDf6IMWULeWS?=
 =?iso-8859-1?Q?lQPwEsFA92j3JcAqKuceWvyeNrHphOybvZUA8vsbSp8Mq8YN1pdg0I6cPO?=
 =?iso-8859-1?Q?gyXaWhH3wxGtIuOv5JkBoiDAskITRM/d6khT59/oxU3n0aA3A1LlGdhKB6?=
 =?iso-8859-1?Q?TCS37yfZHEGvHrsuotWg/ZAuuvSTuABzc1SW+NRhn6Fdgt/tKS8wkdkxMV?=
 =?iso-8859-1?Q?cEmmHzZ247ZHdYVZE/jqjXIIIQKcAFJOl/MRLTLlAg51QGI3+KaVXSMrFr?=
 =?iso-8859-1?Q?bYQxIEUIakkNFP9jVTgxti73fzsWW+paY6ISTsEA6Fe0E2bVoeGOumxR4h?=
 =?iso-8859-1?Q?T+3xS2eZcvjK9rQQh4GuAJcFlKZSHzBb5OMTeEoY17erdL5Li3B6B4sI7w?=
 =?iso-8859-1?Q?E/muYN1mT1IUlOVf0JE7TM3mHtb2yAi7K6ERenWZ76iXT7ThJ9KzYW0zW0?=
 =?iso-8859-1?Q?NuJ8X0zNxU9Wj/tOhtbtF6oVccDFA14LGgA8RpAofgb9F454Gv5IHRLymc?=
 =?iso-8859-1?Q?iOrTVbUsO1alWg66nBtaw1PpMk4TZLwWnc61VoT+C80knSKw6/jcRs4Jj9?=
 =?iso-8859-1?Q?QKGAEcIjqAVCYG4zgG6DXj0SlZJnMelwKQMYk6EPQAySS+Ie1HpP/c3eMi?=
 =?iso-8859-1?Q?3xdjhtmF9+fjXQwHJt2CirAIgMJrkV3KYX/SU5Z5Qe4eNQ8K8p6yNvIOzU?=
 =?iso-8859-1?Q?5bb2hWKolCe4N0enoxXRBEjQpQYB+WDd1opxjxogJ5iAKyjcLYP5yLhHE1?=
 =?iso-8859-1?Q?6i/kCjTEoOG9bAA8ZSyjW/PrwZ8jREgAfl4Vf0phdY+O9Dr637GiofzkIk?=
 =?iso-8859-1?Q?HUMQKdzWNs9BCvh2SzlvtBR0bJqzV80vQb26dROSNiIxBA6zBVR3mpssSg?=
 =?iso-8859-1?Q?Le/2ZBYwu0+p7TD+ZaTlp7tnk+LXhcltFmnccQpoocFvKFGMBfHrO2Plpg?=
 =?iso-8859-1?Q?XUnIw23C2joArubzbJVJaez+TMhLAAEE/qvrKPMy5rcJzwIUfV4MOO31gr?=
 =?iso-8859-1?Q?X3RkOqfYoI5TroYz5z5WhmNap/qzV5CzVF61o0FS/5FKPGYu7DifcUPxgR?=
 =?iso-8859-1?Q?6oJKbnqPtiMXhw4JtrD4V6LXA0scYj9L//4nfYMnuj+J6yw/hsWYTTV/WO?=
 =?iso-8859-1?Q?V592wAvIkdL/wNzMJtBuqg0ln/m7qZkSR+T/uDDXY/75CmyUJOH8+siycL?=
 =?iso-8859-1?Q?E2qXzogTMTtLwemiQralt4looHc04XjF/Y0DxmFQ7JkBXYfSatI3FvHmN0?=
 =?iso-8859-1?Q?aJuKppGpCQdx9hkFxQ5dycGHGpRVjpM+3g9OhY9ry9BoPeXMd6Q3ra1Pjn?=
 =?iso-8859-1?Q?a892502VgHBjNcB14144XEK+sCxKAO9oxmhddVeO8pxGIeQQm6Q5BOzT4Y?=
 =?iso-8859-1?Q?+U5WzR8JsVBL//lmkB4tkzGgzpfbLENC/DqhkuiHZPRDE25cvVt+M9RAnJ?=
 =?iso-8859-1?Q?KklliEK4GPYtzecEevkHZiUFdwJn1rGVnBvn6guai3DMY0il0Sk3XVogjS?=
 =?iso-8859-1?Q?WUP3mefkvvyXVI809xVmQpAyg7yrt51JK/?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	VCvSwWPoWtltp7QcVjfnAwWu4uUcwUZlKe2QhmRMqjYwcDUkLPf6UDjXwJjvE/V1zfyjus5NOW17tmAo+hQKRe2O0mtIy2GOKKMOQBQyL9JB6OTnpWp9piB4J0CWrydxCam5mGEtSkHC9T53afk7MsUQjI/9YCm89HhKKFq7o4eT5n/bK+GtK4YQQHKetUJqqA52rAVRihyxTYOthXB5WtOjrosija1OniTQb6W4RyJ4sK0sBhrTsHP3usmHETWfYPdGm8qu7Drf0zhxoHIwBxk2OHvMZxnOLfTBCnzLg3y1Qq94g0f5JHa2IJ00sfFoCcX867t4pHhAM3YqW7mxgHrTudUwvqOuIybnBDH69FRVraXHloxmzM349LO/0KbZiZ9LdSF0lEfXK0icFGDuBp72Cxke0mB05y7s8oTg/5rfpxMQd6gO4hUgFSHcOCmEU00y0RdXR7XEz2fTJQ2PdnIYl275T9j2MpC63p1TO2iz4qDzVbfDKGGd+++/+gQSydrfssHX1P6OzAXoKCxovddhIM6X4jH4+pBd1i6dEzqjXVphTB8ueuc7F0sLapeVJ9rQAwmlW8a5jYvVzfXxaGroFm7waUu7sjShmqj6/sg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee461661-b1e0-4636-7e0a-08ddad45959f
X-MS-Exchange-CrossTenant-AuthSource: CH3PR10MB7329.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2025 02:20:53.5687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zyAuyr5O6Ownz86cXfGjDBrAsWFOpWqzrWq2nKr/bEHV8bKAHbViY07rUGX38yCRLo8tRLZ57jZSFOaWQgkpdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB8179
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0
 mlxlogscore=999 mlxscore=0 bulkscore=0 spamscore=0 adultscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506170019
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDAxOSBTYWx0ZWRfX19vXgPwnsOLg qbw08xPuFblwgo64m1tcRBTVqySs0Flgd240Zue/1cLrG7HK/ODQQpCOtMXOpldHViminWGEH5c /xeWC3KRvufrNm+ql/kiwCBDzrkzWLwna7fb3rhZ5m5C9HRKcnvjomWhWP+dwroAH2KCIiwqCkO
 UdALv1cCPzpZT+dUnLcxM2g/I/8Icpv9DmqZWGKgKWBeV08NbzLs1vXfI8yjcBsvVn0wUQkHN99 ZLQci7k60aeixYfAB4LnQnR5106gwF2XD3AU1LUVISt+Cyc2xQYv1CuWbVnx19TcP/L+6QgBCak u7Ab1uE+j8YTy8xIIkDvIMnCIHVIRgB6uB2V1olCdhBMOWLG4wcNa1qJzhHFXKDuJrI+Cf/mvbj
 2cCK7TWJratVbq+7PmVp8P9EVb9ySABBzjWX44q/v1gVCgzWY8YmafhD3Ri9mvMD5jguZqwt
X-Authority-Analysis: v=2.4 cv=K5EiHzWI c=1 sm=1 tr=0 ts=6850d10a b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=ph6IYJdgAAAA:8 a=20KFwNOVAAAA:8 a=pGLkceISAAAA:8 a=1XWaLZrsAAAA:8 a=yPCof4ZbAAAA:8 a=U9lO-2-X6Y3eVARFeYUA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=ty6LBwuTSqq6QlXLCppH:22 cc=ntf awl=host:13206
X-Proofpoint-GUID: kX1Kf6zEtWobq_6PC2J4vAwiW2vYMZTN
X-Proofpoint-ORIG-GUID: kX1Kf6zEtWobq_6PC2J4vAwiW2vYMZTN

On Mon, Jun 09, 2025 at 01:32:17PM +0900, Byungchul Park wrote:
> To simplify struct page, the page pool members of struct page should be
> moved to other, allowing these members to be removed from struct page.
> 
> Introduce a network memory descriptor to store the members, struct
> netmem_desc, and make it union'ed with the existing fields in struct
> net_iov, allowing to organize the fields of struct net_iov.
> 
> Signed-off-by: Byungchul Park <byungchul@sk.com>
> Reviewed-by: Toke Høiland-Jørgensen <toke@redhat.com>
> Reviewed-by: Pavel Begunkov <asml.silence@gmail.com>
> Reviewed-by: Mina Almasry <almasrymina@google.com>
> ---

I think one point of confusion here is that net_iov mirrors some fields
in netmem_desc, even though net_iov itself does not overlay struct page.

Presumably the reason is because net_iovs may not be associated with
specific pages, but only with DMA addresses?

The only reason why it mirrors netmem_desc fields seems to be
"page_pool doesn't want to care if netmem_ref is netmem_desc or net_iov
 when doing something with netmem_ref".

Maybe it's worth clearly documenting that net_iov does not
overlay (I mean, does not share storage with) struct page, and
why it won't be a memdesc type in the memdesc world.

Other than that, it looks good to me:
Acked-by: Harry Yoo <harry.yoo@oracle.com>

>  include/net/netmem.h | 94 ++++++++++++++++++++++++++++++++++----------
>  1 file changed, 73 insertions(+), 21 deletions(-)
> 
> diff --git a/include/net/netmem.h b/include/net/netmem.h
> index 386164fb9c18..2687c8051ca5 100644
> --- a/include/net/netmem.h
> +++ b/include/net/netmem.h
> @@ -12,6 +12,50 @@
>  #include <linux/mm.h>
>  #include <net/net_debug.h>
>  
> +/* These fields in struct page are used by the page_pool and net stack:
> + *
> + *        struct {
> + *                unsigned long pp_magic;
> + *                struct page_pool *pp;
> + *                unsigned long _pp_mapping_pad;
> + *                unsigned long dma_addr;
> + *                atomic_long_t pp_ref_count;
> + *        };
> + *
> + * We mirror the page_pool fields here so the page_pool can access these
> + * fields without worrying whether the underlying fields belong to a
> + * page or netmem_desc.
> + *
> + * CAUTION: Do not update the fields in netmem_desc without also
> + * updating the anonymous aliasing union in struct net_iov.
> + */
> +struct netmem_desc {
> +	unsigned long _flags;
> +	unsigned long pp_magic;
> +	struct page_pool *pp;
> +	unsigned long _pp_mapping_pad;
> +	unsigned long dma_addr;
> +	atomic_long_t pp_ref_count;
> +};
> +
> +#define NETMEM_DESC_ASSERT_OFFSET(pg, desc)        \
> +	static_assert(offsetof(struct page, pg) == \
> +		      offsetof(struct netmem_desc, desc))
> +NETMEM_DESC_ASSERT_OFFSET(flags, _flags);
> +NETMEM_DESC_ASSERT_OFFSET(pp_magic, pp_magic);
> +NETMEM_DESC_ASSERT_OFFSET(pp, pp);
> +NETMEM_DESC_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
> +NETMEM_DESC_ASSERT_OFFSET(dma_addr, dma_addr);
> +NETMEM_DESC_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
> +#undef NETMEM_DESC_ASSERT_OFFSET
> +
> +/*
> + * Since struct netmem_desc uses the space in struct page, the size
> + * should be checked, until struct netmem_desc has its own instance from
> + * slab, to avoid conflicting with other members within struct page.
> + */
> +static_assert(sizeof(struct netmem_desc) <= offsetof(struct page, _refcount));
> +
>  /* net_iov */
>  
>  DECLARE_STATIC_KEY_FALSE(page_pool_mem_providers);
> @@ -31,12 +75,25 @@ enum net_iov_type {
>  };
>  
>  struct net_iov {
> -	enum net_iov_type type;
> -	unsigned long pp_magic;
> -	struct page_pool *pp;
> +	union {
> +		struct netmem_desc desc;
> +
> +		/* XXX: The following part should be removed once all
> +		 * the references to them are converted so as to be
> +		 * accessed via netmem_desc e.g. niov->desc.pp instead
> +		 * of niov->pp.
> +		 */
> +		struct {
> +			unsigned long _flags;
> +			unsigned long pp_magic;
> +			struct page_pool *pp;
> +			unsigned long _pp_mapping_pad;
> +			unsigned long dma_addr;
> +			atomic_long_t pp_ref_count;
> +		};
> +	};
>  	struct net_iov_area *owner;
> -	unsigned long dma_addr;
> -	atomic_long_t pp_ref_count;
> +	enum net_iov_type type;
>  };
>  
>  struct net_iov_area {
> @@ -48,27 +105,22 @@ struct net_iov_area {
>  	unsigned long base_virtual;
>  };
>  
> -/* These fields in struct page are used by the page_pool and net stack:
> +/* net_iov is union'ed with struct netmem_desc mirroring struct page, so
> + * the page_pool can access these fields without worrying whether the
> + * underlying fields are accessed via netmem_desc or directly via
> + * net_iov, until all the references to them are converted so as to be
> + * accessed via netmem_desc e.g. niov->desc.pp instead of niov->pp.
>   *
> - *        struct {
> - *                unsigned long pp_magic;
> - *                struct page_pool *pp;
> - *                unsigned long _pp_mapping_pad;
> - *                unsigned long dma_addr;
> - *                atomic_long_t pp_ref_count;
> - *        };
> - *
> - * We mirror the page_pool fields here so the page_pool can access these fields
> - * without worrying whether the underlying fields belong to a page or net_iov.
> - *
> - * The non-net stack fields of struct page are private to the mm stack and must
> - * never be mirrored to net_iov.
> + * The non-net stack fields of struct page are private to the mm stack
> + * and must never be mirrored to net_iov.
>   */
> -#define NET_IOV_ASSERT_OFFSET(pg, iov)             \
> -	static_assert(offsetof(struct page, pg) == \
> +#define NET_IOV_ASSERT_OFFSET(desc, iov)                    \
> +	static_assert(offsetof(struct netmem_desc, desc) == \
>  		      offsetof(struct net_iov, iov))
> +NET_IOV_ASSERT_OFFSET(_flags, _flags);
>  NET_IOV_ASSERT_OFFSET(pp_magic, pp_magic);
>  NET_IOV_ASSERT_OFFSET(pp, pp);
> +NET_IOV_ASSERT_OFFSET(_pp_mapping_pad, _pp_mapping_pad);
>  NET_IOV_ASSERT_OFFSET(dma_addr, dma_addr);
>  NET_IOV_ASSERT_OFFSET(pp_ref_count, pp_ref_count);
>  #undef NET_IOV_ASSERT_OFFSET
> -- 
> 2.17.1
> 


Return-Path: <bpf+bounces-68238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24CE7B54CFA
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 14:16:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEF351777DF
	for <lists+bpf@lfdr.de>; Fri, 12 Sep 2025 12:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BEEC3081B7;
	Fri, 12 Sep 2025 12:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qswwJtiX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="SXF4Smuu"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8469A3019BA;
	Fri, 12 Sep 2025 12:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757678724; cv=fail; b=ZrA+fF0TutD/JdsIbNSDalqe+gAfYCu6G4dNsOur0UJjWF3lREudDT3u6n2DFDUiRgPFlgJuj1it1iqHIzI29Z6da7+yNUZGPfXDHGvmoXkxHKpFWOpgKaYYRlOIewS/Toc4oTXqMnMspDnKLFi/SZtk82nwNUqE7wWKaX8Wgkg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757678724; c=relaxed/simple;
	bh=GagZRN3OjOrShn2JDV7+fDmCKS/aNc+2lXsKToHWvA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B1i+l+uaCnpqQ/RcDHD4hrmy2rNJq/tmqIr5+wuisqRchTMomyvbdkHrl1DRlLgHjJv2RMCziXNQIeMPnBJ6wc4pp9nRzpXcWsQ7Orp531j7d8zRN0hDTWV/NIUDYPgJvZEd8p7ujCEHzDo4v4jZxUSmbY9fP1vcKCZZafHVKjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qswwJtiX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=SXF4Smuu; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58C1u9Bc017560;
	Fri, 12 Sep 2025 12:04:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=GagZRN3OjOrShn2JDV
	7+fDmCKS/aNc+2lXsKToHWvA0=; b=qswwJtiXyiQnEykcj7qDaj2Tl4fTJWCqsd
	+1A6MKtiBeJDWsau5HNEXo1zByQY6WLkm4JX/yLGt8KbyETP1RMzT4VRYdPwOnB7
	SyT4VzxEW9U7ZFOcnk0jzs+S6aBwNF5pDSgVnZvjnNshmdFRBBDX5gNxoyD+ZdSR
	H/kvArDpe0bgl9xGBNZQTISlHj4A/GLp7bbRBUe+pEHBS8IuvnDPgxGtMqmanJZL
	eL6EMJIwX1Kc2FBa9pf7KlpIuYApcympFJZQ2DMi92rpGQZX770s5W+wpiQ+gv7w
	F7eTP6JJ8F3eFV2oJ5Gk1IjudwKUHJduR8PV9fvD7nSu+JECst7Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49226t03ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 12:04:28 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58CC3KJB026078;
	Fri, 12 Sep 2025 12:04:27 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011028.outbound.protection.outlook.com [52.101.57.28])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 490bddtr51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 12 Sep 2025 12:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NlT0zw8LGAn/diSVtFlzFDc9zDmhNgR4RXDg7gxDs2eue5hxmQA7erlvNrYHAEeS6HvLHxccOGzPPktz2vF5Q/4y/h3dLuCfKXN+V8UF7/DyBIGLVO6/UcdXmwWl/oPqTHB0m6pX9fb1tkmLh6bKgNoUUUefTjmKR4Me1UoElWPQoIdlnYoEfKIFyn1wH7Z4DKHinYslvWBq3SpxZvplrgKA6UIIpVHK5keMmtbWtTicC01D2lwU0cFr3kQ37Wn7On/sxEI7DC7ihhioZGvX4XEE4WXuuD2lymVo1eveNc1DLWMEK/1B9TtJtzglw67BP+ZtK4nCCNOe1BAKucR6Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GagZRN3OjOrShn2JDV7+fDmCKS/aNc+2lXsKToHWvA0=;
 b=w0IEO5pBseGsp72vv4h9GKHIAsMmPmPewq4Wixpq9uIY5vRKUzA0ce5V9vMjdCRT4GD76+AQ7k0EATp84ENC3n7Y7PFhZ6YXKs0dQopYhDqKECukc7gAnEgiA6nyuRgD2oP4Y0k+mazWdkUwj4r5wqEjPJt/DZxu1/u3mQqKQ7BFYC4hWEjQkiYKb0Pi4rWxaZj5BlWJXogv7aeu383A6BvzWK7c3aUSD041vwB1DNMNN1yGuVk8+hFqaLSziB9Oz8QJdcf9VaxoKfXEsymA/gAX+DkKAdC4gyGxdamWlGtPgHwpZae0VjgpOQfWJSmjGTfuQSgYVQ5VFmRLpxTCYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GagZRN3OjOrShn2JDV7+fDmCKS/aNc+2lXsKToHWvA0=;
 b=SXF4SmuuCSID+UxG+eYgioBh5F1BrMpQ8g2eTnbB3vExlsEJAkw40Pj96JxRrx9dTcZsLMSJlZJcqGf5C1fyZPZFhfk9qniqKX/AeNp7kKWDIl7ILmV7VfMH2Y4f5zOiWwobPICDOZQ0IiLkTcyMjPQ0+MZsOpJBapbSwHSa1j0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7397.namprd10.prod.outlook.com (2603:10b6:8:130::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Fri, 12 Sep
 2025 12:04:25 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9094.021; Fri, 12 Sep 2025
 12:04:25 +0000
Date: Fri, 12 Sep 2025 13:04:22 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Lance Yang <lance.yang@linux.dev>, akpm@linux-foundation.org,
        david@redhat.com, ziy@nvidia.com, baolin.wang@linux.alibaba.com,
        Liam.Howlett@oracle.com, npache@redhat.com, ryan.roberts@arm.com,
        dev.jain@arm.com, hannes@cmpxchg.org, usamaarif642@gmail.com,
        gutierrez.asier@huawei-partners.com, willy@infradead.org,
        ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        ameryhung@gmail.com, rientjes@google.com, corbet@lwn.net,
        21cnbao@gmail.com, shakeel.butt@linux.dev, bpf@vger.kernel.org,
        linux-mm@kvack.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH v7 mm-new 02/10] mm: thp: add support for BPF based THP
 order selection
Message-ID: <04e854c9-dd02-472a-be70-dba166a90e64@lucifer.local>
References: <20250910024447.64788-1-laoar.shao@gmail.com>
 <20250910024447.64788-3-laoar.shao@gmail.com>
 <CABzRoyZm32HT2fDpSy_PRDxeXZVJD35+9YqRpn9XWix8jG6w8g@mail.gmail.com>
 <3b1c6388-812f-4702-bd71-33a6373a381a@lucifer.local>
 <5a2a4b59-9368-4185-bd08-74324eebacb3@linux.dev>
 <4fba4e8a-a735-4cac-b003-39363583ad19@lucifer.local>
 <CALOAHbCzb=sfCzVvJze4Xth1v5YPxfdeNpWGkGALANciPae95A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCzb=sfCzVvJze4Xth1v5YPxfdeNpWGkGALANciPae95A@mail.gmail.com>
X-ClientProxiedBy: LO6P265CA0001.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:339::9) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: 499e723a-89f6-4214-9621-08ddf1f48440
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?K6TxXLZ9Vyy8zd597np/DP52oLUw3tys360IJUkixDLETF0e/6hIey+j1IMK?=
 =?us-ascii?Q?/ExA8edIAH2l8oLUM523Oe73TTBd5vZsKHvgQqxfSZ/L0kofUO75IH5Pg717?=
 =?us-ascii?Q?0rH4vOJs0kNl4ywGrc0ot1zL48COQBQLfGheu/nDiSfnTpnH5UYQ+SGFV6p0?=
 =?us-ascii?Q?H68+Z3mNNSlf9epre/5n0u2CQrtYEdh83ZHRgf6P2tSCbjWBghzFOE3b491t?=
 =?us-ascii?Q?Yf7cXyb+DnqJzWghj4wEQc4wwrIa5DTrpEwvHSJYgtah/f14KntCU6Bs8PoP?=
 =?us-ascii?Q?3enIN4kWa7gRx7TPTQuI+BTbkMHy5it0sa8fLWXm2hA7oPuhWm6FrgdYaATa?=
 =?us-ascii?Q?sVQpfSzpDao2UJKFVkt3rsW3TDLUQzpu9PeWH8iW+ZUVrLPVode50yWjNPxW?=
 =?us-ascii?Q?wbG53yUpRpV6693PnD7SFmFgDnht20i9vVGwOKjWfuqZiLuBVPiF3UWsqxvG?=
 =?us-ascii?Q?p3oB0FMhlBTzHRA8FZAQwTk6In1svGuRfY8zXQKiFss+/V8c295T6u9+bHbF?=
 =?us-ascii?Q?GufViKLxLYIutpb44PbhT+pg/pWw1EuKRWrwPvT0a/9CeccLN4vniIcH+kNL?=
 =?us-ascii?Q?Qbo1xk0D4Wsejr+ZiiE39XzUJK+l7TKw70h/3aqB8PpfnwWcYptqYogPvvwj?=
 =?us-ascii?Q?6QRvN8dTRG2PdV9Gi/m+XLvx4kNXJhQFm/lLUf6sw56i8/SsqjkFu8viekSe?=
 =?us-ascii?Q?1ZpDPQE18Gj/xNFLz+JXaXpvzcC702Wy8r3rXCV9WaOJJJoEUDgQBgYFpG+g?=
 =?us-ascii?Q?XCkYzskWqaqjBsNiTqoiyNMnupUeq0nRFwr+N4n+svIu4A6tMNWN2jleemAW?=
 =?us-ascii?Q?+67oS8DbbG9hLQsILW2CANAxzuZbO5tPcvCQ2YtcWobvYfd/07nyTW8NaB6l?=
 =?us-ascii?Q?hiQttucDHX7Bvsv0VRCW1sabixZn5H2lOWEddjWqfOlTln01WXC2YI3O5onp?=
 =?us-ascii?Q?/V3LLLHs9yratW6m2kETXHGJl7FeeH6losk0BXCxz4pVuwSIVwXDJalwHREc?=
 =?us-ascii?Q?/6LD+vSFrV5UXc1gdB/+oYAKgm0C2GlQZ0dnCkccvD7Lq9K6nED/wqQsJwK1?=
 =?us-ascii?Q?5XAT2rPqRSayivoNSl7Sv4ZXUmC2XNyJTS7S5YmKMFNJQW+2qBag8XtAL8sw?=
 =?us-ascii?Q?KdS+7yA2a0v1TC3ib2XOO+zV7AowRV9QwRRsEqdCwkkNDPhiVJ4JRHPvfHmE?=
 =?us-ascii?Q?3TUv3EUgGxU5y8Jc6xpOEm/k5J9wfuRFu5eCzJBW7/aXedVQCMU22r3NNuBf?=
 =?us-ascii?Q?m8hHHwrjaws9Upan+Mr2eoyWLJYvngKv98GrL9H8Nn3+96MPZ9I58vl3eZU5?=
 =?us-ascii?Q?yEg6FBfmi6pmYZNG+jN8m9rXxHzidDpZp9NrvRbu5Nd6vjeVh0PMcT3jEcm+?=
 =?us-ascii?Q?HAY+syWkOcmTz3aE48YSUvEzeUflsj6nwMkQhPCHDzY9K6ZpnAPX61lLyWOs?=
 =?us-ascii?Q?FQwvvfermpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?OnbFOuufCEWNzwogYE4fJeIGuNahE17CCr+9d7oihvqpc5eOiQAnMTcBHnOB?=
 =?us-ascii?Q?Bfya6/Lpgri07vN3Ad0F2DGmZDGh7CZ4sF7dL6bo9nP21epCdzTGffeOA7xR?=
 =?us-ascii?Q?gNYMeWkdTTDwtjrENMZpvpP5OmWifgpVeJFVdwD5Pxsi5x1ELhV0uU2qMW5g?=
 =?us-ascii?Q?kJoGJr2pR5wVbMjZXTylYeZvS7zFVMQo+TbbBMvPDntCxPTzmGlITlGfEnOr?=
 =?us-ascii?Q?IRo6Y3hMODHrC7HkA1MmR88ZqwO0ESxW4PioiXW50rgXSkYDofCYcVQ95C61?=
 =?us-ascii?Q?rTRxadvbx4UkZkaQraswekNr3uCwr9liJUbpqVbsiImm2qOtQRyg/iyt1r00?=
 =?us-ascii?Q?3+fmarZmK/yETfnzQPVoo1U93/CyCHPYz6n4PjFdAc8THxc6TAARAoZddbFj?=
 =?us-ascii?Q?Kb+q1z3NJ/JaHcTZNSNVINVR6/U33S4T6BjA+VqfgVYb6ZFiJqUnjBBPIhP8?=
 =?us-ascii?Q?YmT4zx5ADAA6QsuUWCzAwFtJvR/Hnm4ryqD7AuTL/F5tkzzV9jPEOL4/yEOW?=
 =?us-ascii?Q?nmXa4gd+5YDrSlxaXkA5j85RMepPcd1AmoiiOT6U80qSeRYV5sUDRsDbs9MB?=
 =?us-ascii?Q?G2Vn/CbaT2zbCy3Id+weX1+vUMOBTh5OVyDlYkZxsfVxZehFV3lLyci5QAwR?=
 =?us-ascii?Q?fnkjMZ/9wbbOWGUTBP6ajkvnMpUGnlR9sL5pCZlLsZEhOAKWWw7lgH+OFwhN?=
 =?us-ascii?Q?vfJzvVryLo991e4wQNJYx1V0Dhvx86n1Q1UVrC67iLU1l3mi4LxZWxc+FiN9?=
 =?us-ascii?Q?tOe/dugPVI+dbx9Ght14Y672wO34jUSIWJpLrVyohMW0IOecyUaOtvHGk8Wj?=
 =?us-ascii?Q?SDKg03fknDVI692/tsw6e8F/J4+/6XaDMaIFTG3PQWvj2MT/35W4ISUiuXQk?=
 =?us-ascii?Q?Dh57CnGl78aYynsfvnSzKUfbNuviHzHH4wukQ3qThLE5ugfivqgCD1nQb0Qh?=
 =?us-ascii?Q?7gNRtMC+PvarSvNNvUW9jR9ujDMGgXFpYHrx4yxxQ6wEYMCRZAbYSwM/SovY?=
 =?us-ascii?Q?iorrn2idT1YambmUVCkzUHhVHtKMLVJIkPr6eHCmh0/YMBXxyFibGeUEZPFA?=
 =?us-ascii?Q?9wu3iq7BThCQTrMnTYs27K1LMaPxqCUl7V3CXhvCcn3E4C3FT6UP6sQ2JzI1?=
 =?us-ascii?Q?jr8rKxAaDCzQk/06piPEOmQ2a4MCPrRejdh6FndBDoQrGGP8kGcRl2uHPFig?=
 =?us-ascii?Q?JMUstqH82HuBPaRMUrwhBOT2aG3iQuL3dbaRvPd6Z8Jk/jM+vSmBlHlRraET?=
 =?us-ascii?Q?ZLys9K73VPu0jJ5rL2AX+Sr8iGzilgYDwKAkZG8Op/Au2OTScTJXQRJXExHc?=
 =?us-ascii?Q?VZkErOBWcc7AQ0FqPS8VxyBYqRCk3CySwwlMRh70laeMQFE467f3XNCI3S7v?=
 =?us-ascii?Q?tmpxP3J3l47TeBkFeDPJLypsCC9yARlJoDVKLZhXBZY9OnDuvznvh47ezelg?=
 =?us-ascii?Q?RW0EXXK/beV2Y2u6JcztIfejcfMHNJMNEeCNTrX35fk5ikEclcasru8B4PIE?=
 =?us-ascii?Q?a7cvAnZvWdpLp2PqYbXe9xBcyLBCdn6tXGxGtA9ihXpD6TjYeMC1dOSKKRB5?=
 =?us-ascii?Q?jz9SAUKgADbZfq1SRlHtrOlBcAJzEnG2pkl5LBj9B1LoBmtg2lmhZ/K3TC/O?=
 =?us-ascii?Q?4g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Lr9CQdQ3nEM8/8OQAOVt+xmkWQ3i20EdulAZcAujqpCVT7DAAS9IZylRiwrBGGMz7VrkHUcwkfE1kz/6xN1v2XsQVU6eQbNWsA/x5FlSdU0q2a8ubczK+ZLDLrmE/Pw0g5vrvrm17LvI1G779aXlxf35oMWJFZl0oR7bmRacko/HtZiYGUnJPTgPDEawnbejW6ZdnsRiaxZWyc1M5XQU7CbIaLlZuI+bWirF9m4J+Jt3kohUgQ0ybPK8Sd+BDXWiP+OBM4Kzj8IdRRYM1tHF/Olqk15as9YX/lkGhhnJXNTlTNVLixUKTaWrjaqHYQsQujb9CO7dpCG2qO77hFBYVN6fAGIStqQUdYFIstqFTykOR1HOgIMcVbObz7BzxHzqaCh9qs5Gq2FjUh/bSkp4eJ022k9t0UZKKdRcGnyhr3eaNhus8KObAYWBFO+RgXFsOa0H9WvOfEfXCwc+PwlNPoBXrt2JcOK6nd6+nqGNzk+tbGh/LkZZ3pN+T5RdtL9KTwGK0ML/i8FTvFisXQg2w4tmihnaW6jzhR00q+ObgUPpbnSrZZqDMdLrs5c6Pi8Lb3e+ViG6WrgLI3GvcHpy8YJWr2nDTcBaM0w1lALCy7A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 499e723a-89f6-4214-9621-08ddf1f48440
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Sep 2025 12:04:25.0336
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lng9sGbiog3PiGeZvgATUVozWzmTMLTyt8q4ZXMABr3KUUVayNayQaqg0wQcVZ6Fpxig5qHjZnAHrzthIC+viRzfgqAMGzFLdYMTuFUeCOI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7397
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-12_04,2025-09-11_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 mlxscore=0 adultscore=0 bulkscore=0 malwarescore=0 mlxlogscore=771
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509120114
X-Authority-Analysis: v=2.4 cv=QeRmvtbv c=1 sm=1 tr=0 ts=68c40c4c b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=QWZxVLCtArGt-gdaV8gA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13614
X-Proofpoint-ORIG-GUID: qBum4mmFWQ_8l2jz5-vQ1YEpvzxve9LL
X-Proofpoint-GUID: qBum4mmFWQ_8l2jz5-vQ1YEpvzxve9LL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDE1OCBTYWx0ZWRfX5NUBUki5M6RC
 soLOJmIBl5j6vPiei+N1wGuNGmZ2aXdRzYWOZxpIduXEucV2Tm7JwxdBSEhFHMWE5Y6l+hkFqMV
 fJc51AIigpm7a2mtYM3vIaNfAl4HCQfjXQNClNvOJhwQypBZkg4g1Tg5AWFsKkIIuKs+nCty1af
 hfXRiBm5qszhbEgAx6wZzclK4OO2FC/9TySzscrYv+BNihggbJQ8iRWLUzGXj5AjA1Te38w/ooB
 cDG/QsZJnPNsYiRjf9CPg2gON0tm2uJIu4bI/ayinI3I71SJ9fb4q1CJE+YDGpjXFENx3WBCMJZ
 7UvY6G3m7JM9c4fzkvDYs01YrecDIuTdecSrcnlc2EfRsdfqYY3frfgHOHE33tQvxBS15FslAz2
 BfqrqbKIwXa1+dph4FOdlNl1Ah3TDQ==

On Fri, Sep 12, 2025 at 03:58:28PM +0800, Yafang Shao wrote:
> > > >
> > > > Perhaps we need to put a 'EXPERIMENTAL_' prefix on the config flag too to really
> > > > bring this home, as it's perhaps not all that clear :)
> > >
> > > No need for a 'EXPERIMENTAL_' prefix, it was just me missing
> > > the background. Appreciate you clarifying this!
> >
> > Don't worry about it, but also it suggests that we probably need to be
> > ultra-super clear to users in general. So I think an _EXPERIMENTAL suffix is
> > probably pretty valid here just to _hammer home_ that - hey - we might break
> > you! :)
>
> I will add it. Thanks for the reminder.

Thanks!

>
> --
> Regards
> Yafang

Cheers, Lorenzo


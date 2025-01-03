Return-Path: <bpf+bounces-47842-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DE5A0097D
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 13:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DEB718801AC
	for <lists+bpf@lfdr.de>; Fri,  3 Jan 2025 12:52:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0298E1F9F49;
	Fri,  3 Jan 2025 12:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="J9Sx0INJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wVnh6IMY"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F385A79B
	for <bpf@vger.kernel.org>; Fri,  3 Jan 2025 12:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735908753; cv=fail; b=ZkhhhapFRYFQP7PEZpehS5qx3ZpPITuDNO3fHBPdzjsA+dZQHoTJRNgu5HOE+MNVLwgH5f40KZvdWcqn5eqK5MST0t2AeM3+Abf4vwMxWLr3JFU63mRB9Gb99kVlZH9LecRm3p8w+viQM7HnF/UBUCCmhWsqt4ynrPvmqwTjViU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735908753; c=relaxed/simple;
	bh=US1M8O8dLtOvoeFGs+hKNDwjEJv9bl80fj7X51cqJ14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=CBrWD7BFUO4TtLWGCzZ32Akb6Co8w0gr9cT6xka7C10sqkjRmgv7el4bPDq7X4TbxBnI9xZ8XY1OWJ5jAvtrIugSeoOC87qDF40a/IYmWwXFDj7cyhjLzE4Epc494/HUp8ZCpR7cSN2khnXwsC6ZtoWgeKvXBjf1EFYcZYdU2hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=J9Sx0INJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wVnh6IMY; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 503Bfwnx021289;
	Fri, 3 Jan 2025 12:52:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=0hjP9Bpdii8I9Emyun
	1H57c+992BWeYrjwowvC5Vr0k=; b=J9Sx0INJ4OO4NRUkUB7yyKrawsWsuVUVPe
	2hAr4Fc8uM2WwwvoshR16aazgb3TNeUZLlHVhKCBb9WKIAK3KBp1VOo0ppRNKfnd
	+VNBqYKgDsygbwgdfTWlWqwNOAeWJHyU90JHJqtQlNk/S6fut1W0BvkvZDStD5qR
	HMNsNaUVnpuczHwhD91a7N+NyTgztyfz2a/O5O399ZGq/8WmJdy46z2nImPG9G1c
	EUfcn+oMV1Peb+f4H0+CRai5rIfWDAuLppHxjU4vouJMvbNHa4vmRJTl1sEQ2wzF
	ga1xagB4t3Dpq41N1yblbd9o8hXCpD3Q+hbRRTqOtwBSZnYLWFTw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43t88a83n0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 12:52:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 503CKfnm030164;
	Fri, 3 Jan 2025 12:52:17 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2049.outbound.protection.outlook.com [104.47.55.49])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xcwg5c4v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Jan 2025 12:52:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oQYqSd9fOCqS4G74r2xtLa64dn+GRXBDnEJN374Nb0kIGQsitIFHntvf6fDE1RK71PDGCAUKrJKv5coz92Rd3CmBGfDJ6dCqornv+EgGW+CPeotQgnc/qkgYDAAgooGMhAtLNQCyc+Je5l1ZS85KcvcNre+bWW9Hnx1Cj1EK0hG5S8UYVEstci8RmkvDXi4S/Alvk63HGy0tBcsiVOja50yqe1c2Ye38A9PAKV4Rj6PfFW5WCdNuMXYgNxZrlUEbeTRl5snI87iVVeML1j77RkcHLWH2uVs2grs21AOZ1ViebMsOneySafkXENzRJ0agBDr4FDmZUqa0J9azp26MVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0hjP9Bpdii8I9Emyun1H57c+992BWeYrjwowvC5Vr0k=;
 b=ItlEBX7Jgo5YoQ5QkIZG5m8b9MkTpXxSv5g6xI6wuG8x2hqmttv2oxhoRNoiNIOl45vbkzp2sl3J3t806hxjuQ3Sftrdoj67fYGaiy6o2nBIJtoV3O/xe2uHKrvGlBBuXAE9aA0Z8M5O6QvyNQO5ytAxNXCymJW4pgcAsAHBfS5bQ47AnOJUWm2USQav2ekd+y+Erte7wSF8r50nl35rykkVeLKXsWiq2sD6EhPayHENnQ8hu7QaYYcJptABhmjHQTnHGx+PHU5GxOYIty0Ig9msHsSsDkH3dm/DazD+/CN9/V3BEXYIOGJJgq9lbvHDl/qcUi5z4n5bg+uJz17ruQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0hjP9Bpdii8I9Emyun1H57c+992BWeYrjwowvC5Vr0k=;
 b=wVnh6IMYOXYWsY/GeMvmgCd9ZJ9wDGtwzNuy4HS+VxxQWgsqkJCT4Ex/cFN+9opiJNbJ0DcpwbUsAadiIsPNhbGJniHkqpjg+aVb1xBJ3EUw8X7Qpr8ggs/qCR0or1h/yvZxxdohcs54DLpEDO5HUmsepM7PM3mizQ7cPTGY1ak=
Received: from PH7PR10MB7804.namprd10.prod.outlook.com (2603:10b6:510:2fe::18)
 by BLAPR10MB5186.namprd10.prod.outlook.com (2603:10b6:208:321::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.15; Fri, 3 Jan
 2025 12:52:10 +0000
Received: from PH7PR10MB7804.namprd10.prod.outlook.com
 ([fe80::39a7:9bba:4b86:f389]) by PH7PR10MB7804.namprd10.prod.outlook.com
 ([fe80::39a7:9bba:4b86:f389%4]) with mapi id 15.20.8314.012; Fri, 3 Jan 2025
 12:52:10 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: Ihor Solodrai <ihor.solodrai@pm.me>, "gcc@gcc.gnu.org"
 <gcc@gcc.gnu.org>,
        Cupertino Miranda <cupertino.miranda@oracle.com>,
        David Faust <david.faust@oracle.com>,
        Elena Zannoni
 <elena.zannoni@oracle.com>,
        Alexei Starovoitov
 <alexei.starovoitov@gmail.com>,
        Manu Bretelle <chantra@meta.com>, Mykola
 Lysenko <mykolal@meta.com>,
        Yonghong Song <yonghong.song@linux.dev>, bpf
 <bpf@vger.kernel.org>
Subject: Re: Errors compiling BPF programs from Linux selftests/bpf with GCC
In-Reply-To: <87pll4xkuu.fsf@oracle.com> (Jose E. Marchesi's message of "Fri,
	03 Jan 2025 11:17:13 +0100")
References: <ZryncitpWOFICUSCu4HLsMIZ7zOuiH5f4jrgjAh0uiOgKvZzQES09eerwIXNonKEq0U6hdI9pHSCPahUKihTeS8NKlVfkcuiRLotteNbQ9I=@pm.me>
	<87jzbdim3j.fsf@oracle.com>
	<64d8a1a7037c9bf1057799c04f2d5bb6bdad3bad.camel@gmail.com>
	<87v7uw21lj.fsf@oracle.com>
	<4accd577b1486fb8074e7913c3e81d76174ad3d6.camel@gmail.com>
	<87pll4xkuu.fsf@oracle.com>
Date: Fri, 03 Jan 2025 13:52:05 +0100
Message-ID: <87bjwoxdoq.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0300.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:196::17) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR10MB7804:EE_|BLAPR10MB5186:EE_
X-MS-Office365-Filtering-Correlation-Id: e23242bb-77e3-406a-4c6e-08dd2bf56f6c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AmvBvxOO/u7X1l6BPiPzrUNb8aqbyqLNAzPIIRo+xl2ApPJnNAYMhQYLmJwR?=
 =?us-ascii?Q?RUVuI7a9gwExyg+GopTx0OcKccUInn4u1HqyRDNvYGTwq0UG8ZqJq4B5zzzr?=
 =?us-ascii?Q?XW1qhixAbjFwtswHaiMgjOaNE36v84op31Xj/7y6fOyQeT8XWQBZojsk+ONd?=
 =?us-ascii?Q?ZGkf7BwQfn4vzdIvxa5wfI9cgxbS+FKV0lsbciO6NgbA/atgR+ATtxxm+o35?=
 =?us-ascii?Q?CL7q8VaCGS1wJcyS6nHgGr0pI1uGEvSWZbQPSAF60bSSy6jvOHNfPebCmpfl?=
 =?us-ascii?Q?+UhygKjyYg3OYkuLrJPXLzLKiHQw9MM3+IbfCAsQbtllpSNy52WzEXmNl8yU?=
 =?us-ascii?Q?PNt4QeExF0vHs39ERgs9cjepWs53v3Yh084s9YYw0EAsGjhWGfsHskt3Iq3b?=
 =?us-ascii?Q?AIqr+CT4kdXOxSBHPiOMjYEZrB4K/uFY2JsncBgihwXN9uUi7iBoCAJoGOAA?=
 =?us-ascii?Q?9FdIIO5D6FLEXAy/AFmC6d9yoedO1wCF6f5UpPgwVU9pPY3GgojzSqnlqabY?=
 =?us-ascii?Q?iSbcHvPMPrkZqCpQMsDW7Naoeup8S4PL7dq6FtkZbFCwMzG4CMUz6gWSmcex?=
 =?us-ascii?Q?ivvRffoWSG1k5En1Yf42JtTdKO1UDGsMYzwEPM/aos4/jOQKr4XnjF+iSAew?=
 =?us-ascii?Q?HUGOBRv5yuFncOg9lJ6TfTG4Tpvk5QEW2sRz2JRUwxilfbUoi5Edcb849CjI?=
 =?us-ascii?Q?14/lV3kldqTKE2dG12KkWoR4UcfAnsEK+EktpxMgO1I2eeCbY3FI05Ta/cRZ?=
 =?us-ascii?Q?Dxk0d9AoNxNIkaS0nHjqH5PIx/GKjlG4fSwAx+/hw/Ucqpp/ZcDZkfNY71FH?=
 =?us-ascii?Q?HDBqle/Egyco3U8bSonyx6jZ9bmlhZb4obWe5Z07g7D2gVyctabm6G5mNMA1?=
 =?us-ascii?Q?McaIWj3C8CoGsuTWKoasJVmoMc43ND3FJdLuJiTeqRjGJRJBJ4PJ0lxwlUPS?=
 =?us-ascii?Q?5+d3UJievWkOtgsUR8bmURPs67ITJYYKoGe45lfalMRmKiv8oc6nmqSqsWuQ?=
 =?us-ascii?Q?wiP3t1D7FVRF3oiKxHFzXPiRpKOwNEgmJyZCU1xvBXWOtjjX+bjGwrzCSY31?=
 =?us-ascii?Q?jPqtlT0086pdFi5CLyOOUkPKlj0j7a2ojkDcNXDdcrabTgoAqqusElJ2XuvA?=
 =?us-ascii?Q?Gvw55K3jH13ISg9NxFapugzKJ/bveIaB0VQo8FpYdRy0kjS2m3NdplFTZvjo?=
 =?us-ascii?Q?P2HndoB869H5kdJsxJqOdBCwA+/yNeQQjFxc//n4b5uaHdCdEBbO9aXFwetX?=
 =?us-ascii?Q?3FN7Vtgvr4TwvcR+eiM8fHws3dNWK5rfzen9jHqZdlaPM4amfoT45aqCK7as?=
 =?us-ascii?Q?JEqdV3uGlfvXecOBq2wNXsSN4eLyMjqP6mmdu1ANfacpTq5bmUC79vgalUrh?=
 =?us-ascii?Q?xovLuXlo4eu9dUKrIFKsAIU7F1GU?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR10MB7804.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?by9xQTGKZhw5QRzQPYfB/W0kKxQSn1Xa3O616SCsZQWhDOAlgVVy2NkmUsx/?=
 =?us-ascii?Q?UlvevYYiiXe+ynWKmWbVa5mouZTKMMaDkcOPRD0yHDQUAkRiUE8BKawQVky9?=
 =?us-ascii?Q?Dugy+QuIGo4bUk+EzG3fCSET9M4s2vhA4M86T1ZASequIsPWRXwbXaj2kXOy?=
 =?us-ascii?Q?HVk9QDLFuFgafoHn2kfgRl1qmAh4Bw0mYa2SU7Kxq7NEVzlAeClDfhPsMLvO?=
 =?us-ascii?Q?Bb5LsTyQHealY4NUaR/7z9/k/OWDfaqrPr53Cej58fFDbX2oRVhmBT82KrBx?=
 =?us-ascii?Q?sDis59msGvyuVEyAmVk7IHoMAWuSYtIfeaTqUQUNdEnERwPeCxPOvEkWyGFT?=
 =?us-ascii?Q?QXNncmZXQZu4T4zsfjF4C+Z9xsYb6F5WVwwZmf4tXZcCiB4RIYsjuc/PSuH6?=
 =?us-ascii?Q?QLLg8SpuDv5K/EaNggpcS6MHXu5uuaqWQn3FqqU085zg35Wi9rFZjXZUjQnk?=
 =?us-ascii?Q?8iGdaR8yWI3IpQpMjwi+B82zylG9YpjqSQ5xSz7hSpHGAMauhdIlThnlY+AE?=
 =?us-ascii?Q?ILgE6abhYk9IhOeBGhkP0p3eAp1LIcMd6LAlJujFUmB4OA6kRzQNfDUQkbIu?=
 =?us-ascii?Q?tWyojYrYzBEnNbU/m4Cq8cnRzro/NAykPa1eMNCoxMvfa3c0pXv4Ze8iFqgp?=
 =?us-ascii?Q?7S/9D6eDWcCmULRh8Dr55te0qtRp0J6ur+/Gd0vUZIw/Avsm/Rx/n4BkYYzq?=
 =?us-ascii?Q?H8moFGLxunOWAqwwzwm53/W25Z/V4aV8EnSdB30WHc8q2f/B4Vg3haqq4j5x?=
 =?us-ascii?Q?i0duQuwHjBTx/c9v6E86rqDk0DOvFWRRNqm09v7fKkP1HtqL9A+GUnOMugsG?=
 =?us-ascii?Q?JR+VnRVrJxOYcX6oUuy8gpJ46D7y5LwXwAkqTRMljaDmbuCFp1yrm/jwKRz8?=
 =?us-ascii?Q?DllmvCy33XMAT2imfn02SRWx0ATtb+HhBlKvjDJ86+9mrS4zgyv5+BKlBJ45?=
 =?us-ascii?Q?fzsymH8Ot/ShTEjCKPSutHF2NCOXYZAPEgxkYkDWkHQAO7S+aO87npejKq3R?=
 =?us-ascii?Q?PIuqgsWDdGlVeQpeY/YQteqfZSW79piUoIXBpXbF6bvPWM4bYSnM1wphZXNr?=
 =?us-ascii?Q?IzoI/eFORmy0sHUjEKrAzO1i7xpXS358Vukj8rQb0s/ik66DkwTqw7AiN5Jz?=
 =?us-ascii?Q?alwe80MeqeU9m2n64IfM5EBd1+NIJrqUgU4QvjmZVMuMzRRU1rfhpNTF6AlJ?=
 =?us-ascii?Q?iF8YU/IaayOmdVZrnYZ4Zc/k2sU0w2Tch1XEj9OxCN5fpIdwn/v3TIrMbRZ9?=
 =?us-ascii?Q?8m1Lisnz/82vBG+g2LOuE4PqWXSd1cnmW6Jz9RHQEm6X4QSi+VMSq7vzkXMs?=
 =?us-ascii?Q?IYsYr16bWvZxeb9z+g73oC9rU8FSHjjQ+iEvx7yxXhXzr69xnMMM9lvgzar/?=
 =?us-ascii?Q?z/NnAlhOBUHJ+ybL6hwYVEW2rARssdv3t4227YFDwS0+IozEyo1LXoCilMmH?=
 =?us-ascii?Q?UyozW24B15pqvts3DkwL6CYoWmFFazSgMjVIZqZDQPt2aSPPDi6wHBdkz/cb?=
 =?us-ascii?Q?DHe7v4n2DXZXXw2BXw0B4Ugy6kCzfRg9flBrmTT1KvHTN9YcKY5O+wB9IpNZ?=
 =?us-ascii?Q?fcFjPpdUJQi39pkA8SItCAQpii/fpsiG9e09CqIk7sLuRmZ4/C+mSZ1Az3Wt?=
 =?us-ascii?Q?jQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LbdW2VeeoTbZGzrzz98+gcEW2+WyUKO2IEXW4Te7DvhPZiANxMKffgd5k+H4HCig8djeYFFayAS5QbLNlCymK0Nb1wJgsis/pKLcyk63aK8eaztTqA5Gd/0OEJ8GvONiYmiwp5Kby03ZaSJ7opYdzLiXq/UByBILkFs4CqRY8mBbiQENREhFGsiVU5H1IhDDW+yhrktqo5IqdRlmy/Z/je0h4EXQ3e5tQdDuSuPNAWvrdXS1B/BROn4vTVi2Bu0rWDH+lN5cdlEhM+ozcK9oQa/cBuOi9YmV86plsWPUgHOr4R+OK+WGtfhSEGlr1B2m/ERVXLH19KtZ1n1v080AF5Q6ws7qh0IdOmaMQQSJCGJ84MVDlJ21F2EuF+LHXe/5Y06gYA+vH0VZX0tXuOy7S8oIedbEKMKXUm00x7HF7PFOnEwN6r9BM35048/S4MkScwk7jUFg9l2nsSJ1g/U5YlcU80btVCne5C4nFR9XwvEdtczVbCgWFNyj5oHQQGfLi51sIqJVelfUYb5p4uxhmK2k6UQ7Z3aLhPrkVFL3WPqsvC+DutIIrXUQx9euwQcWZYsOFtb3IqmTKFCCL/MVrQ2q0jY0KzsB5VpoMI1uEco=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23242bb-77e3-406a-4c6e-08dd2bf56f6c
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jan 2025 12:52:10.6343
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 62ms4zN5kwV9r8LfnXQnriGgg7nAJk7eBCNDOOAU5woeYgInO+H/7aiG+I/v97zDeFEpJqo96Aymz/fknK7A1Kcf0pkrNtdE8gd610UFnNE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR10MB5186
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-02_03,2025-01-02_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 adultscore=0
 spamscore=0 mlxlogscore=974 suspectscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501030113
X-Proofpoint-GUID: iIoH-d2P4pRd_tZVPwg-C8HPNHEdXQdu
X-Proofpoint-ORIG-GUID: iIoH-d2P4pRd_tZVPwg-C8HPNHEdXQdu


> [...]
>>> We could switch to "wrap" to align with clang, but in that case it would
>>> be up to the user to provide a "host" stdint.h that contains sensible
>>> definitions for BPF.  The kernel selftests, for example, would need to
>>> do so to avoid including /usr/include/stdint.h that more likely than not
>>> will provide incorrect definitions for int64_t and friends...
>>
>> Would it be possible to push a branch that uses '=wrap' thing
>> somewhere?  So that it could be further tested to see if there are
>> more issues with selftests.
>
> No need.  After reflecting a bit I can't see why the requirements on the
> "host" stdint.h must be different for BPF than for any other target: its
> contents must match the expectations of the compiler for the arch.  If
> it doesn't... well, it is not the responsibility of the compiler to
> assure that.  I will install a patch to switch to the wrapper stdint.h.

https://gcc.gnu.org/pipermail/gcc-patches/2025-January/672508.html


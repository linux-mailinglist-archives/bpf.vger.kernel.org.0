Return-Path: <bpf+bounces-28464-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA6618B9F43
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 19:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42D221F22149
	for <lists+bpf@lfdr.de>; Thu,  2 May 2024 17:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C3516FF4F;
	Thu,  2 May 2024 17:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WiJAdbpo";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="oJEXcpwv"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2316FF39
	for <bpf@vger.kernel.org>; Thu,  2 May 2024 17:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714669787; cv=fail; b=I7s36eD/RSu75RttGGaK0or/6GtCXQF3ZcFTopKGcR8AM/jMgIMcdWJ+3KEPrn2IR6M3JTvLu+jAkG8aEMnr1naRI1g1eydKMwxAYfKI2FhxFwgBiwcASUa8SskvyIRyf/RVnGNl4Q+N+F/MWdUrt/466zMSwkf1PyxyG/xM914=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714669787; c=relaxed/simple;
	bh=ub9lK1Je97mIw2p8HsBryS5Jxu/3+k/WO00OUJPgd80=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=mNk2/U6QsgKv0z29AxAdHbP4cfhRIulF8HoxyAOXhWN3mLNn+PVKUww2EhdUKoO/is4747dim90H0burdrJ+D4q6jFYEAK0QyaHhyQhS9FW5alQ5hJRfZIzotcC/l9PDhEuV90ntnLuX4kkFpkbHv/ckTbQfG6aGpPgzn+DvsTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WiJAdbpo; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=oJEXcpwv; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 442Fi2ZO002214;
	Thu, 2 May 2024 17:09:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=oMgrJ957mpwCSIK9hwaHzH3EfZ/aV96UznFYOUb2620=;
 b=WiJAdbpo3MkW4TOzFdIJRSPmpN07z/ZugDNvnY3zx3exgMMXFBq8p7EoZO+BthahDfz3
 PU31LvP5RAP2fmnVGwv1KjHOVdupy3SC3D4NXQNh6Jif4v8JUOy8sF01YSY8Hxf5RpIs
 6hWpsmvH8DC3MQpNmiDUQpyPCvEVV28Q5XILetBpxOVF8zL1e9qIUrEu0I2m5GOllJsq
 mEjhJmQ5QdRw8cTfnjS9Rzte5vTrmD1XZvbJ70fJPrZSewBi2HDNR5u+73Mn9RmStnCr
 71joLZF3DCINBX8yO0mCq0payPawlqRVua4JGSHCgN6sBmDORkkde2/O35NYpTIbdfWV Lw== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrqsf6589-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 17:09:37 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 442FboAg008931;
	Thu, 2 May 2024 17:09:37 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xu4c2gw9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 02 May 2024 17:09:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BjFjyeaPKaLLVVnixLG6MPCzqR8hyNhMttTTuVg8SzihWEHAo8+aPbc+ZSS4PdzleNDIBBm4RsVdrlT7viqw4p5cDiwX7Zphg7sinr8ErypDN54OEi2X9bBlkNcaP+1J0oJikgqcQSDnyUoZLPThIxBfJw7IGwPFbfwmQOw3WYkPFYtbfiKBolahTp+ET2qTBC3pKniUqZpc+bcodlx2xa7aph6chC+Tc2/h1dG5yt8Is6FhlchQeuQR8hDWR+9W3bsEGLiKFKfo+64Z5zHbxeMTjrV0bTQz01ehJIV+NXCGB5p19sRPBZe9xQqkiFPZUFdmwrJtv4onyvVTBqLhnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oMgrJ957mpwCSIK9hwaHzH3EfZ/aV96UznFYOUb2620=;
 b=jyyZzBbqrbFFifvzJvm48CzSGvKX7ZcPl3PwrOFAvaf0NR1kdxWWjb3rMWhur15VX0UVDr+uY6W3TY1ld+COtsJ+WO7LveZ0w/9/bMm366rYriA4hWsuNjsJy2pykWU99jGdt9OiJhQCMfsVA5J5+Q4KceKKkyO/5qznV1L51xkj+HJQu5wwLQ+gODGOFLIRaaJBeG4Sgtt1KD4lzxaW+GcYdF8RjjvtDnwqKLdLARBmOpQIKyKg7OBfxj4h5DL3bEQdgDebdwQtRAM46nWGosruAESFf42WaDFsZtM9L07Tx4zzFf/AgYqXnl+8DvNPni+LonAdoruGWep8qEEahw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oMgrJ957mpwCSIK9hwaHzH3EfZ/aV96UznFYOUb2620=;
 b=oJEXcpwvshgPDPemD4cn5a7ZWQB7G6+reckaq3VmKpQiZY5pHy7NMD1vpNY3DAr3OPBEn2g3Mbgkjc3tLz6bmDzdLn4V5Ec61SWdE2q6JqsvOsyR7WF7nCNxaOwHnVgNxc4GSHKCbZjWVreS6VYawIjM/SQhcPdkrnsh0FLcEJA=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by PH7PR10MB6986.namprd10.prod.outlook.com (2603:10b6:510:27e::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.40; Thu, 2 May
 2024 17:09:34 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%7]) with mapi id 15.20.7544.029; Thu, 2 May 2024
 17:09:34 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: "Jose E . Marchesi" <jose.marchesi@oracle.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>, david.faust@oracle.com,
        cupertino.miranda@oracle.com
Subject: [PATCH bpf-next V2] bpf: avoid casts from pointers to enums in bpf_tracing.h
Date: Thu,  2 May 2024 19:09:25 +0200
Message-Id: <20240502170925.3194-1-jose.marchesi@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM8P251CA0004.EURP251.PROD.OUTLOOK.COM
 (2603:10a6:20b:21b::9) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|PH7PR10MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: a9fed51c-1af9-48ca-2e5e-08dc6acaa396
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?W0rw4ZD199tZJWfffeqN9HW0dltCbRmAvSZf0umyOHTX36zQ57PUO0kQzG8c?=
 =?us-ascii?Q?LuOemUHxcSNWkxqnMj5MLiPdhP9qssDKjZfHxsflp2nKRoorDDnWIYIGzuJx?=
 =?us-ascii?Q?0Zqh14DZZ+xEqaLVbbQXKAyFrZD/9yCUzpvOEsI1wmYG+KrVYdMqtsBDrrOq?=
 =?us-ascii?Q?OlDx31GKxU43GIJ1jAuauOvdO7AYqPZRbeqOiq33itZcCNsx5ECFnqsKqCoL?=
 =?us-ascii?Q?7OVg2CTPMSrxPsqNHf7Jh+Sgo2ndKYkudTGB6UU4CVHT+QipAEprYR+m8xgt?=
 =?us-ascii?Q?Oj4cjOmj0DB4ikzAu4i3IBoGTcu/uyhU5+v2Pie2DS/DhRf9lVKrmsFnY6v0?=
 =?us-ascii?Q?+tOqN+3VPVzpiYux7jSPMZTqS14eBvu2BUQoiZkzxNvat+Zt64jmm9O11FGz?=
 =?us-ascii?Q?E2YOEQkDn5QF2xqccIMOtmmE98sME5+E+T+JrAPljWxDZ3MDI6O9k8bINQKJ?=
 =?us-ascii?Q?N1F+putUPqelWgA+G5vZWrlFPkTYc+c9B3L5TCAilpyUNRY5ImYM90DOFfdt?=
 =?us-ascii?Q?CWZZlwFHjC8aMzWIsTdknsEfXRP52pZpuwlSjA96JEdL2LuVS5sHA0H7zWPN?=
 =?us-ascii?Q?wxlWdcEPpuTT0EBlZWz2lrn0GaJ+zxJXJOAKmItwOVDPtkx7wHcJj8XxWRV2?=
 =?us-ascii?Q?s/hmJRZNU5gD5n5Hm3biNZAkoreBN/WqSY1RcUCL5+P2my/SF5WGdrbbAeF6?=
 =?us-ascii?Q?zaIjVAom4WLhZo8weNhatJpVoCSPNrJUtwxGruEdFTdwazlC2tTMaq29ObaT?=
 =?us-ascii?Q?l3YlHyE7LE3z+0JSTXDVHj8MBJ4sN+UimrjQSHO3BtFnhxpPyFlfwEzvYeE0?=
 =?us-ascii?Q?pHxfZlFk8trpWOKVKi8A1oCRvoIGA7XCVUrGslDtqieLPSeg2s4PNBAFzm6N?=
 =?us-ascii?Q?b7SuQbFBcBCdcG9BRIV1kmiQpevQOpAuIgFkBaUqzcfzWGqjhw9p+fOdLVVv?=
 =?us-ascii?Q?EYXb9JVjV08ig2tuUY8L4bmjxo6DgCtiSYXA0CeQsIbGYWeSpjYrseiQ2olI?=
 =?us-ascii?Q?FMjO00xhwJfmAzcWemOs/P+0WAJby1BZo5xtAKT1HTol/7xjZX8vxqCQEvhx?=
 =?us-ascii?Q?5o1543pd4sJmunKwqufIyRLVez1yU2hQpFpb30AXb1rUuubHTRgI7hJ0hXAj?=
 =?us-ascii?Q?DlO+EUvNe10/zI4NM+HPSNJ6yFhJlfWKIddmkuRvVtcB3l2QpsB0A86/yBJv?=
 =?us-ascii?Q?m8OskebRAP2ySW/JzcD6qc1C2X/bVQgjFFBZxDAhWZtGkxF9mOUiieK2PHiX?=
 =?us-ascii?Q?+PqwCMFKHtJWYjSRdfUIRAd9xkzRKQ5xLESjKaHWzQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?o42X6F1t2/e1YLSJ7W3o6Nn75dlNTq/T2CRgOC3EtAuBVCFV1aZQ7H/rCFyD?=
 =?us-ascii?Q?MaO5ynCqJBJpI7B2a774uGCxaW+92fJ7mGxm+XMMfMp0BPdzFSsey3KXc/a+?=
 =?us-ascii?Q?wdkjlQlJIvoBHlhOLELZzVv4kFuwD/eXmMMWdjhejIZz+hpCX4JLmXo6VRPD?=
 =?us-ascii?Q?fNOGzOm+U/qO6J1izl/uXeqcCKsl/81zPokqtyZFAs+42kRbnJO0D+joIAtu?=
 =?us-ascii?Q?5cWlXgpFVudMft9ABsfGExNg3hLCi6te3saAoNV7gDJ19+oiT2gFiHp4LLT4?=
 =?us-ascii?Q?buy+EyKTzmHA836fkOBs800Cl8mS+exf7teFgoZ918MiFCP6SK5VQrak5Bsm?=
 =?us-ascii?Q?97UO4wXKdr/Ach8RzzD7nJIqlrjdWO6EHmvrPtyj4Ft5acNvQzTHV0df4Jdy?=
 =?us-ascii?Q?lbb8P6Ku8jVERHS7xeE2+sMdRcR2dE2tMzXlZooqFq4eiMA7wL3VL4ZTh5pA?=
 =?us-ascii?Q?z8gWd9ajZgcm+bcfcoIBLOACi6ncbbqv47ej6QhojDGhJ8KCOkH3cpudOE2A?=
 =?us-ascii?Q?hHy6nbfC7sC6XuUiSzPFLPkeRN5Vgmy/Dcxvo+ScBx5sejrCuZ3go/ZNzizb?=
 =?us-ascii?Q?NJjX4Gl44y9WJ6f+zvDFu2EsBQQdzoLc4jT4P68mkq5mKztX5x9u36gHK91D?=
 =?us-ascii?Q?s744xE6JRUQOMHtkOyhPRudvvOqRCquuzC+bUWvCxIexauMbjchS/NhFy9el?=
 =?us-ascii?Q?JheNguzzyiF0kGRDYNlExRHKzWnPQIWoS70g1kne2PFiHZYbnRoVP4Z+fzKk?=
 =?us-ascii?Q?fEVoq5aPqLbWz/7YFw3Uxwpg5/aYELkQEkiWOicr08UjVAhlWZNW0Bm1AyG3?=
 =?us-ascii?Q?umCcUMQy5pCSHe4kz4stp1AHtFvPYoGqa48BIWiKhGpMqKu5GE0Yjg6CVJez?=
 =?us-ascii?Q?s7SXlEcESRO54Z3o8+fSVUFLhoUQlBZPopBOQuo5tHy6Tx6im2ZgT/3bXMGo?=
 =?us-ascii?Q?eA2JJskPiAVtMg+DcQJcgVvEv46xPZs6NdCCcRtG/l3atk5csmiXmg+YO+EB?=
 =?us-ascii?Q?iK13MDxkILPtlExhecr+QblkzzMkfE1vrdI9A9j7+NNjn82ZLnW4Vi7jQ82o?=
 =?us-ascii?Q?KUK7nB+M8rGC1SfangKvcg48A4PB3gR5qqxQvXmYoErzwOYzbr6h6UG2GrKp?=
 =?us-ascii?Q?TXs5OASVLpMuWgDVE3JFzIX/5W5VQymnaCxI2tF7iBFJmDGHmwFWGHPFYyj8?=
 =?us-ascii?Q?QJ5A05sh8oZfJYeZBAMiOPIpIxyS7eEie5dExv29tFRiUwFS2R6EetSybYaa?=
 =?us-ascii?Q?tuyUpmagDS3RkJvwgGOTTXZr7usiAkxUDjcCqwtcjkjV6eSOGpohalP2s1L8?=
 =?us-ascii?Q?f/UxxMRIhW5Y0BY8UwOyeYaRATqfRFq6WF8vXfhdcMPgkr51thl9qcu18ImP?=
 =?us-ascii?Q?oq58S75U75ImIg3F+GgGDprKZaKs4+Nbl7GrF0McoCmhXuxfMEQoRITP+lvz?=
 =?us-ascii?Q?lYAhUhNRY9r70fZK768wjY2MEf/udLGFR/LeaEmFDvgKLGcR6AnZIX6cSe++?=
 =?us-ascii?Q?UVtvLT8ph6TFivTZaHwwOfcgiCPVrBG3UnfW3ynUGYc7gstgifs7sWrEO+Rx?=
 =?us-ascii?Q?l9PAPGCG+Ooe/5AgsXM8OpJu8fxrL754sFehP/ZgWQt4vf8f/rPjjQYhdj5C?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	08rp34cfa8yn9N/SkDfYPDcQ8zDuZeAVfsF8HUFrkDkJm7PQ44WNmbPe0B9sPpTd6q4wgj8UvetD9TGwQAw+lVU5+rxBANcc1QalR+U6rgs9RL3MMxUlS2P3gaVVEhL3SWEZfO6vyCko8MT7I6LG2HgL/LyQpj4J4SS0RwUL187LxSGxdPgAoRmgcQ+gXyA/jJFqiHgRGOi67XCgzwNa6NCZJa+c7NwEHt8emDUVIuGqxEGHn/F6V0AK6lXvKUFg+mziixiNMJrRMFM8b0fuYf1M5D/V/Z868BkzBjohQJilZkPVJncGIXwpvpRo5HOiNMW/cX/rplTUesG+IEuY0UJWccgOhOqPq0NohtezFjEwyQvKgr0Aa3eqS+TsfYU7PXKl8QfHFGhf+YiX9iHtVUzBqWyK0ULek6EzFL/YXBHWVF3ZtI9+bd7XmZle+5zWFlaM2yWiv1tUckU2luLiYP5DjNxVqkOwTyUBqF3/1tqaKjaokfvofbDjdczKMgvsE1+JEhwz1a0c6as6ARZ6Q3nd7rcMsOkznfnhydVB0aGxVVC/I7LUW0U+gRaFHpOKKD5qnAQy6aM0UeSLDnHey+WaDpCioxR7PPZSfWDejSo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9fed51c-1af9-48ca-2e5e-08dc6acaa396
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2024 17:09:34.2319
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gSPvkRNZ3mbvPxDKfBeFR9pexRJbKn6NrkiWSYjL8y2A+tQ7k1XKjd5iUXnBp5qPlhMiy78LlaAN2gb4J4mTyGpYzz6m+LpgH/bop9R5m7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6986
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-02_08,2024-05-02_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=857 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405020112
X-Proofpoint-ORIG-GUID: YgMVyLoFA1mDxsuwFij_8tZ2jqrkqhRy
X-Proofpoint-GUID: YgMVyLoFA1mDxsuwFij_8tZ2jqrkqhRy

 [Differences from V1:
  - Do not introduce a global typedef, as this is a public header.
  - Keep the void* casts in BPF_KPROBE_READ_RET_IP and
    BPF_KRETPROBE_READ_RET_IP, as these are necessary
    for converting to a const void* argument of
    bpf_probe_read_kernel.]

The BPF_PROG, BPF_KPROBE and BPF_KSYSCALL macros defined in
tools/lib/bpf/bpf_tracing.h use a clever hack in order to provide a
convenient way to define entry points for BPF programs as if they were
normal C functions that get typed actual arguments, instead of as
elements in a single "context" array argument.

For example, PPF_PROGS allows writing:

  SEC("struct_ops/cwnd_event")
  void BPF_PROG(cwnd_event, struct sock *sk, enum tcp_ca_event event)
  {
        bbr_cwnd_event(sk, event);
        dctcp_cwnd_event(sk, event);
        cubictcp_cwnd_event(sk, event);
  }

That expands into a pair of functions:

  void ____cwnd_event (unsigned long long *ctx, struct sock *sk, enum tcp_ca_event event)
  {
        bbr_cwnd_event(sk, event);
        dctcp_cwnd_event(sk, event);
        cubictcp_cwnd_event(sk, event);
  }

  void cwnd_event (unsigned long long *ctx)
  {
        _Pragma("GCC diagnostic push")
        _Pragma("GCC diagnostic ignored \"-Wint-conversion\"")
        return ____cwnd_event(ctx, (void*)ctx[0], (void*)ctx[1]);
        _Pragma("GCC diagnostic pop")
  }

Note how the 64-bit unsigned integers in the incoming CTX get casted
to a void pointer, and then implicitly converted to whatever type of
the actual argument in the wrapped function.  In this case:

  Arg1: unsigned long long -> void * -> struct sock *
  Arg2: unsigned long long -> void * -> enum tcp_ca_event

The behavior of GCC and clang when facing such conversions differ:

  pointer -> pointer

    Allowed by the C standard.
    GCC: no warning nor error.
    clang: no warning nor error.

  pointer -> integer type

    [C standard says the result of this conversion is implementation
     defined, and it may lead to unaligned pointer etc.]

    GCC: error: integer from pointer without a cast [-Wint-conversion]
    clang: error: incompatible pointer to integer conversion [-Wint-conversion]

  pointer -> enumerated type

    GCC: error: incompatible types in assigment (*)
    clang: error: incompatible pointer to integer conversion [-Wint-conversion]

These macros work because converting pointers to pointers is allowed,
and converting pointers to integers also works provided a suitable
integer type even if it is implementation defined, much like casting a
pointer to uintptr_t is guaranteed to work by the C standard.  The
conversion errors emitted by both compilers by default are silenced by
the pragmas.

However, the GCC error marked with (*) above when assigning a pointer
to an enumerated value is not associated with the -Wint-conversion
warning, and it is not possible to turn it off.

This is preventing building the BPF kernel selftests with GCC.

This patch fixes this by avoiding intermediate casts to void*,
replaced with casts to `unsigned long long', which is an integer type
capable of safely store a BPF pointer, much like the standard
uintptr_t.

Testing performed in bpf-next master:
  - vmtest.sh -- ./test_verifier
  - vmtest.sh -- ./test_progs
  - make M=samples/bpf
No regressions.

Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: david.faust@oracle.com
Cc: cupertino.miranda@oracle.com
---
 tools/lib/bpf/bpf_tracing.h | 84 +++++++++++++++++++++----------------
 1 file changed, 49 insertions(+), 35 deletions(-)

diff --git a/tools/lib/bpf/bpf_tracing.h b/tools/lib/bpf/bpf_tracing.h
index 1c13f8e88833..47cb42e4e188 100644
--- a/tools/lib/bpf/bpf_tracing.h
+++ b/tools/lib/bpf/bpf_tracing.h
@@ -633,18 +633,18 @@ struct pt_regs;
 #endif
 
 #define ___bpf_ctx_cast0()            ctx
-#define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), (void *)ctx[0]
-#define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), (void *)ctx[1]
-#define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), (void *)ctx[2]
-#define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), (void *)ctx[3]
-#define ___bpf_ctx_cast5(x, args...)  ___bpf_ctx_cast4(args), (void *)ctx[4]
-#define ___bpf_ctx_cast6(x, args...)  ___bpf_ctx_cast5(args), (void *)ctx[5]
-#define ___bpf_ctx_cast7(x, args...)  ___bpf_ctx_cast6(args), (void *)ctx[6]
-#define ___bpf_ctx_cast8(x, args...)  ___bpf_ctx_cast7(args), (void *)ctx[7]
-#define ___bpf_ctx_cast9(x, args...)  ___bpf_ctx_cast8(args), (void *)ctx[8]
-#define ___bpf_ctx_cast10(x, args...) ___bpf_ctx_cast9(args), (void *)ctx[9]
-#define ___bpf_ctx_cast11(x, args...) ___bpf_ctx_cast10(args), (void *)ctx[10]
-#define ___bpf_ctx_cast12(x, args...) ___bpf_ctx_cast11(args), (void *)ctx[11]
+#define ___bpf_ctx_cast1(x)           ___bpf_ctx_cast0(), ctx[0]
+#define ___bpf_ctx_cast2(x, args...)  ___bpf_ctx_cast1(args), ctx[1]
+#define ___bpf_ctx_cast3(x, args...)  ___bpf_ctx_cast2(args), ctx[2]
+#define ___bpf_ctx_cast4(x, args...)  ___bpf_ctx_cast3(args), ctx[3]
+#define ___bpf_ctx_cast5(x, args...)  ___bpf_ctx_cast4(args), ctx[4]
+#define ___bpf_ctx_cast6(x, args...)  ___bpf_ctx_cast5(args), ctx[5]
+#define ___bpf_ctx_cast7(x, args...)  ___bpf_ctx_cast6(args), ctx[6]
+#define ___bpf_ctx_cast8(x, args...)  ___bpf_ctx_cast7(args), ctx[7]
+#define ___bpf_ctx_cast9(x, args...)  ___bpf_ctx_cast8(args), ctx[8]
+#define ___bpf_ctx_cast10(x, args...) ___bpf_ctx_cast9(args), ctx[9]
+#define ___bpf_ctx_cast11(x, args...) ___bpf_ctx_cast10(args), ctx[10]
+#define ___bpf_ctx_cast12(x, args...) ___bpf_ctx_cast11(args), ctx[11]
 #define ___bpf_ctx_cast(args...)      ___bpf_apply(___bpf_ctx_cast, ___bpf_narg(args))(args)
 
 /*
@@ -786,14 +786,14 @@ ____##name(unsigned long long *ctx ___bpf_ctx_decl(args))
 struct pt_regs;
 
 #define ___bpf_kprobe_args0()           ctx
-#define ___bpf_kprobe_args1(x)          ___bpf_kprobe_args0(), (void *)PT_REGS_PARM1(ctx)
-#define ___bpf_kprobe_args2(x, args...) ___bpf_kprobe_args1(args), (void *)PT_REGS_PARM2(ctx)
-#define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args), (void *)PT_REGS_PARM3(ctx)
-#define ___bpf_kprobe_args4(x, args...) ___bpf_kprobe_args3(args), (void *)PT_REGS_PARM4(ctx)
-#define ___bpf_kprobe_args5(x, args...) ___bpf_kprobe_args4(args), (void *)PT_REGS_PARM5(ctx)
-#define ___bpf_kprobe_args6(x, args...) ___bpf_kprobe_args5(args), (void *)PT_REGS_PARM6(ctx)
-#define ___bpf_kprobe_args7(x, args...) ___bpf_kprobe_args6(args), (void *)PT_REGS_PARM7(ctx)
-#define ___bpf_kprobe_args8(x, args...) ___bpf_kprobe_args7(args), (void *)PT_REGS_PARM8(ctx)
+#define ___bpf_kprobe_args1(x)          ___bpf_kprobe_args0(), (unsigned long long)PT_REGS_PARM1(ctx)
+#define ___bpf_kprobe_args2(x, args...) ___bpf_kprobe_args1(args), (unsigned long long)PT_REGS_PARM2(ctx)
+#define ___bpf_kprobe_args3(x, args...) ___bpf_kprobe_args2(args), (unsigned long long)PT_REGS_PARM3(ctx)
+#define ___bpf_kprobe_args4(x, args...) ___bpf_kprobe_args3(args), (unsigned long long)PT_REGS_PARM4(ctx)
+#define ___bpf_kprobe_args5(x, args...) ___bpf_kprobe_args4(args), (unsigned long long)PT_REGS_PARM5(ctx)
+#define ___bpf_kprobe_args6(x, args...) ___bpf_kprobe_args5(args), (unsigned long long)PT_REGS_PARM6(ctx)
+#define ___bpf_kprobe_args7(x, args...) ___bpf_kprobe_args6(args), (unsigned long long)PT_REGS_PARM7(ctx)
+#define ___bpf_kprobe_args8(x, args...) ___bpf_kprobe_args7(args), (unsigned long long)PT_REGS_PARM8(ctx)
 #define ___bpf_kprobe_args(args...)     ___bpf_apply(___bpf_kprobe_args, ___bpf_narg(args))(args)
 
 /*
@@ -821,7 +821,7 @@ static __always_inline typeof(name(0))					    \
 ____##name(struct pt_regs *ctx, ##args)
 
 #define ___bpf_kretprobe_args0()       ctx
-#define ___bpf_kretprobe_args1(x)      ___bpf_kretprobe_args0(), (void *)PT_REGS_RC(ctx)
+#define ___bpf_kretprobe_args1(x)      ___bpf_kretprobe_args0(), (unsigned long long)PT_REGS_RC(ctx)
 #define ___bpf_kretprobe_args(args...) ___bpf_apply(___bpf_kretprobe_args, ___bpf_narg(args))(args)
 
 /*
@@ -845,24 +845,38 @@ static __always_inline typeof(name(0)) ____##name(struct pt_regs *ctx, ##args)
 
 /* If kernel has CONFIG_ARCH_HAS_SYSCALL_WRAPPER, read pt_regs directly */
 #define ___bpf_syscall_args0()           ctx
-#define ___bpf_syscall_args1(x)          ___bpf_syscall_args0(), (void *)PT_REGS_PARM1_SYSCALL(regs)
-#define ___bpf_syscall_args2(x, args...) ___bpf_syscall_args1(args), (void *)PT_REGS_PARM2_SYSCALL(regs)
-#define ___bpf_syscall_args3(x, args...) ___bpf_syscall_args2(args), (void *)PT_REGS_PARM3_SYSCALL(regs)
-#define ___bpf_syscall_args4(x, args...) ___bpf_syscall_args3(args), (void *)PT_REGS_PARM4_SYSCALL(regs)
-#define ___bpf_syscall_args5(x, args...) ___bpf_syscall_args4(args), (void *)PT_REGS_PARM5_SYSCALL(regs)
-#define ___bpf_syscall_args6(x, args...) ___bpf_syscall_args5(args), (void *)PT_REGS_PARM6_SYSCALL(regs)
-#define ___bpf_syscall_args7(x, args...) ___bpf_syscall_args6(args), (void *)PT_REGS_PARM7_SYSCALL(regs)
+#define ___bpf_syscall_args1(x) \
+	___bpf_syscall_args0(), (unsigned long long)PT_REGS_PARM1_SYSCALL(regs)
+#define ___bpf_syscall_args2(x, args...) \
+	___bpf_syscall_args1(args), (unsigned long long)PT_REGS_PARM2_SYSCALL(regs)
+#define ___bpf_syscall_args3(x, args...) \
+	___bpf_syscall_args2(args), (unsigned long long)PT_REGS_PARM3_SYSCALL(regs)
+#define ___bpf_syscall_args4(x, args...) \
+	___bpf_syscall_args3(args), (unsigned long long)PT_REGS_PARM4_SYSCALL(regs)
+#define ___bpf_syscall_args5(x, args...) \
+	___bpf_syscall_args4(args), (unsigned long long)PT_REGS_PARM5_SYSCALL(regs)
+#define ___bpf_syscall_args6(x, args...) \
+	___bpf_syscall_args5(args), (unsigned long long)PT_REGS_PARM6_SYSCALL(regs)
+#define ___bpf_syscall_args7(x, args...) \
+	___bpf_syscall_args6(args), (unsigned long long)PT_REGS_PARM7_SYSCALL(regs)
 #define ___bpf_syscall_args(args...)     ___bpf_apply(___bpf_syscall_args, ___bpf_narg(args))(args)
 
 /* If kernel doesn't have CONFIG_ARCH_HAS_SYSCALL_WRAPPER, we have to BPF_CORE_READ from pt_regs */
 #define ___bpf_syswrap_args0()           ctx
-#define ___bpf_syswrap_args1(x)          ___bpf_syswrap_args0(), (void *)PT_REGS_PARM1_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args2(x, args...) ___bpf_syswrap_args1(args), (void *)PT_REGS_PARM2_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args3(x, args...) ___bpf_syswrap_args2(args), (void *)PT_REGS_PARM3_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args4(x, args...) ___bpf_syswrap_args3(args), (void *)PT_REGS_PARM4_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args5(x, args...) ___bpf_syswrap_args4(args), (void *)PT_REGS_PARM5_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args6(x, args...) ___bpf_syswrap_args5(args), (void *)PT_REGS_PARM6_CORE_SYSCALL(regs)
-#define ___bpf_syswrap_args7(x, args...) ___bpf_syswrap_args6(args), (void *)PT_REGS_PARM7_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args1(x) \
+	___bpf_syswrap_args0(), (unsigned long long)PT_REGS_PARM1_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args2(x, args...) \
+	___bpf_syswrap_args1(args), (unsigned long long)PT_REGS_PARM2_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args3(x, args...) \
+	___bpf_syswrap_args2(args), (unsigned long long)PT_REGS_PARM3_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args4(x, args...) \
+	___bpf_syswrap_args3(args), (unsigned long long)PT_REGS_PARM4_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args5(x, args...) \
+	___bpf_syswrap_args4(args), (unsigned long long)PT_REGS_PARM5_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args6(x, args...) \
+	___bpf_syswrap_args5(args), (unsigned long long)PT_REGS_PARM6_CORE_SYSCALL(regs)
+#define ___bpf_syswrap_args7(x, args...) \
+	___bpf_syswrap_args6(args), (unsigned long long)PT_REGS_PARM7_CORE_SYSCALL(regs)
 #define ___bpf_syswrap_args(args...)     ___bpf_apply(___bpf_syswrap_args, ___bpf_narg(args))(args)
 
 /*
-- 
2.30.2



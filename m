Return-Path: <bpf+bounces-57664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DBC4AAE578
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 17:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DBB3D1C44F0E
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 15:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2388128CF4B;
	Wed,  7 May 2025 15:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="a7n6cfCv";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="jYSUHrLs"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 986D528C851;
	Wed,  7 May 2025 15:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746632973; cv=fail; b=tgu2osMCZhvnLipPQgWTrh1PmAR57ha6gOHt+6nuD+g67g+TZjZUoiJ8LUjlQwRd72bCvF6VLu5sJWMhtDnMohtk2CdbxWUvLr2zPGnSJUxYfSthikpdxRw5ZxqKOdB2DGJrT3A5oJ+iS08330VnBgd9WdhVWFtq+M6a4NODQQc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746632973; c=relaxed/simple;
	bh=LkBPL5h33wOmhCKey9QfgUrMq4eKHgwJV0hvGPMA434=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=mGFc53dh4r3z9Njg7A6BN2hKcFE0JmkoeI5HTpaDU16qaHitQ9q4weY37HZsL3G3PLde2xmoSKkeH1MtZCruxf2ydzYDRMYlWvRXk42nMYXy3ygfOJAhXjfSRMaUZOw8ceR+Hf1PvWRGhizltQxbcTnWgXqTAToo7jaqkESHuBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=a7n6cfCv; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=jYSUHrLs; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127838.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5479Of3U003984;
	Wed, 7 May 2025 08:48:55 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=Q4tQYxFJDx5pD
	2isVNcs6HBcoDdQUXIwhuo8413yjqo=; b=a7n6cfCv0p1/bUoFIzf3CJOZFouMB
	4VileZPz12K+nuckxx0+hZ+5FHliXJ2bVGZhpCw+elVhxd4n4+nK+7PIAMXWDkC5
	nRC2UeJ/k1dSTlTpSiI9yG0Ts5F4z4KlsNk/UF6k4Yei36dfmsSU3aHeUiKDzX9C
	zhs79OtU9a/BZSkmDlutSqLYiZ15KcJvA193ij0tT2sQW8mlzhVjhYeBKbz2G/nR
	vCZnqaUycv4p6rgTHwCHxnIX+s18WusDWkkvzg6Meiqy35RIPsrgEm1NwDSFDrG3
	Z72hPU23nTjDL/M2by/A0K1AbRKMCxLAscx+6eyeJVwwsEBnSMI1UXKkA==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazlp17013058.outbound.protection.outlook.com [40.93.20.58])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46djpyh216-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 07 May 2025 08:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sdLqE4iARWoDtP0/Q7A8OpItk5cDoi3el8o2qm6BHLJQ6dX/Gc3YWeRyI8hRj2Djpdps3RlWhTHrLuwrANzTqyu0J9ipjff89GAs+wnK5743QxOdIT82uIBHCokbqPw4SzlSlmtCkNqsn9nul0RP25fr6QYZmngQ+eu43Bh92U7C1KFJa4t5mSxuBv2Rx3PARp8KEAEJvzaLnm8Ju5D8samDowl13SrcY/xj9efZADPxrgTaEMO4UhuypjPLkFIElYY07IW7x1EEOKdQaEJ0S6yOjbqS5cdR5ghFgnfHf3e542N6VoAO0tiWsW04IvFeDFHBhx6dEBzEW4tgHzt/vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q4tQYxFJDx5pD2isVNcs6HBcoDdQUXIwhuo8413yjqo=;
 b=e4OYbuCxIG6taqbUzrmMV/BjEQrbVmQO7vyVUEsEZNF7t27+ZiAy9Q+NWQ06ut3GdTf2DqoQqtKxQz/wp9qs7rbSYdpPwn0f6b7sb4iJBLClG7VAAYe/TMD1/r6LqIY4oe677j6rc/c7m2n886D6jD0P4pvyYglAUnWRTQHqQEgyJeTpkx6Cx8mlbUT6NW0vekOejx4z4Ohu8hUK9y07CBVk3a/X2ubKRZKFnqUluDYoGP4crPs4/PSaRPfi964ZWlx/zw3Bnxxd+Rwj9bQK8+zsQ+g7JfSQdH2ZzhB7O48oL9qa4stQ4B/buSB15/LKlxOtQbNrPV8ku6+LxBPXfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q4tQYxFJDx5pD2isVNcs6HBcoDdQUXIwhuo8413yjqo=;
 b=jYSUHrLsVvuThy4JjuV197nqiSLfAYX78MNy3s8HTiJmm9EcsLuvBRj1v7ppcPhU0MNe0m/q1A6beMIr6ONBU6uWMna2c2FyfpYuVASh8shsnIq7nPWk7hoqibUwqsk4w0S/KId4Yjz4pAiUh94c5Y/+FPk8QH52S6/XhnyYYSIARTHjsZfZH+ocMGcZutmiA+12iKqH0pyWn7idu5PzkUWesNQ7iNfYi/vDj6e3EG7cZfeEDVr6DfjTIHoRvmgCdG7Fvr5EbGlKkIj9OZVGxlx6hhYY4NzQfANguUcAErETIkO8He3F5MBi7U0Ji2hlNaiHLlko6OZbL5x5tQTfzw==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by CH0PR02MB8289.namprd02.prod.outlook.com
 (2603:10b6:610:fe::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.12; Wed, 7 May
 2025 15:48:46 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8722.020; Wed, 7 May 2025
 15:48:45 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next] tun: use xdp_get_frame_len()
Date: Wed,  7 May 2025 09:19:11 -0700
Message-ID: <20250507161912.3271227-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH8PR05CA0008.namprd05.prod.outlook.com
 (2603:10b6:510:2cc::19) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|CH0PR02MB8289:EE_
X-MS-Office365-Filtering-Correlation-Id: 91153f37-f9fe-4077-b650-08dd8d7ea68e
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|366016|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+HvUjdRiaDIWxDYeBkZ5fus+TryBWcMoBuaKk2qurTbWZAa1d3OueCiLITt+?=
 =?us-ascii?Q?G8Pq7VXeI3fk0vXgDm7mFZxhl8osxf60ZK1wNbJ/V7N+zytRvAM+2X5/9KP+?=
 =?us-ascii?Q?cOsos4O8DKPPtHTTXf91E/CXddNeNLeCpCy08WPxIZcadUJ+y3ukT3xSryA3?=
 =?us-ascii?Q?NyC3uiJYF96KVVYv/9amiRWZl/I28xMVNJKFYoZiiPZt2eM+0aI3z7IOp/6+?=
 =?us-ascii?Q?9TYQNPbGjvK+gTiwSdALAU7ApBSnjVYCceTdva46hVGj4f34Xn6Vm4I/ipd6?=
 =?us-ascii?Q?rQNrzatSpIOf7/EMaWynTnvPbGfKMwI4030VeVDpZ24ZOEQJMmUUnTolRAzc?=
 =?us-ascii?Q?XODxHYyLyKWnL3sZVQBFAJbcTmQDvCiBoI9zSqYIcjwilOBqG4jOP73c9h4Q?=
 =?us-ascii?Q?QXG3VNNvRQQAV8z3AjNHICWLQz+Ig+DbKaKTv6lU7YVzZZg0crcMqieN/r5F?=
 =?us-ascii?Q?Mqg/ahhrP1r8/38s15af3qE7ifrVDGCCXSIXCmHfsj5szN8gMRSdsuGOm3H6?=
 =?us-ascii?Q?9kaxiZlsXgtbNpOWxzsJ7+G0O/se0rvt2Is5ukkTlCClgP16NliJhU8B4Z4P?=
 =?us-ascii?Q?9EBgDWFQnkkFgHmbgzB6OLkfPL4dRPdk5pwi1TVFKrRhC+9oml7ghv8WKczN?=
 =?us-ascii?Q?OGgGVN2o74bL483/PDvtRfHEl0M8Ce0OgbzYbd81ttjqATKIPj21wcmubb1v?=
 =?us-ascii?Q?BN//78ohAwNoDi0TPPSg9qnxANk+E3ef+SBNe2SvEyc/Ce3q7n3hRS/2oi4H?=
 =?us-ascii?Q?4f0+FLwabXSQQRvPik8Z40yaH1fB9A7sKg2c+O3KNG5GZxWhsLNl1TK3QXAD?=
 =?us-ascii?Q?T9TNfvzdKMaOM5SDF49gkAu4eCHjZdxAu87dYMiqcemRXePiEJADqyhv3DAM?=
 =?us-ascii?Q?G+vfae9Qol2UnbdGwgA3nDqSctwn7Iq/Fa8TJWNYhBM3OZeYNg7dN1VRyf/i?=
 =?us-ascii?Q?roqquxZ3MeiPMHukZowSN7A0V/FvOQgn3fb6unfYwzXUyCe/vmSCayr7Iu3p?=
 =?us-ascii?Q?tMat+TtxAWabL5FhZFljfDJvJd54D+ywf6QV2ke2IasIvhax0c0O3qO4dXH4?=
 =?us-ascii?Q?Fq0LVfhS+eOs42tZL/wHjWp4EA49WAVgh6QPym7axdL0J1EDC1CuUSJGkMWi?=
 =?us-ascii?Q?clBi0s6RPK/2H2UQLxF6nxKEazg3zyp5e2Tqt+7Iw1PfAQg3QEHeQIg2j0rY?=
 =?us-ascii?Q?WzuM1A6qlEbsri4MiDRn8iwR7wH8N0wEeqiiLHc7DFi1kUQjr8TJ4tmu53jl?=
 =?us-ascii?Q?nlSuI8SxlrUgOBRjbOYMGuGKHUh0I5vo1Diy2FN9I2fAou1gyV69Ps/pFcdi?=
 =?us-ascii?Q?m8SkiefTSVLfhs/dJfU4iRRI4U/Iu3pQdinroDdd2ExxT3qUuCox4MqK1QhP?=
 =?us-ascii?Q?AlFRCVkvDVPCVfyXMaYOnKrkmhU+YcGtsWaYuqRoGVo4mw1R+U5x6pzDykQU?=
 =?us-ascii?Q?MuqRThhEoXtV4kcqbtSvDj0p915N/Ku+556504GfUDKsIs9IvG+0xjsHMIXy?=
 =?us-ascii?Q?yTR76Nbvf+iagtE=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(366016)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?s8T9wvn9dpCECnO7wPUbneIra5ZnZYxAYCoa8a0SuSD4qn5kqZUtvRBI45wc?=
 =?us-ascii?Q?ZvzVGTRDYBgZgx3cP9T0M7aPiey1zMyiiIrhgAMenOzqh+klU3vSloZOBcXh?=
 =?us-ascii?Q?D2mprbwhW5o+3KkIFRDNplJoQGcwsgRdUgcb4mjGlv0wUcNVOBf44VJAt+GT?=
 =?us-ascii?Q?fM1jDpPJjl0NHAAdQnBDYR5GVgn6GpzJC14vLuVtkgkzWHKIQgY2pRs23dta?=
 =?us-ascii?Q?4lsx/D5qpWkP0BziDkNDxZOGQNCHhxvYPVBGLwRAZhj4OCDpqAB2jSpq8BNK?=
 =?us-ascii?Q?0t8Nx6RK0Ftnv785zJ494JcmsrFAObkRz6IRnw0uuJ9lVXkn2nFgA4z4qa2f?=
 =?us-ascii?Q?ThYezR/b/mSHe3q2apW6onmpFNB8TsbC9DM6PY8Kt4lRYo3NIxN3z3IGxt0d?=
 =?us-ascii?Q?XyU2LwqJ+vk9COdOsNgCA6dACv7GCJDAsnMWx3eCAEcTEngKk7feTK/UqcZN?=
 =?us-ascii?Q?ElXVamUOsjhuNn0goFv9chMLG7IUC3As7vwVovNVc1pEGC5RRn04KlJ6sjOF?=
 =?us-ascii?Q?Ol0prSfljsc7YWHNfBAmYRPFhYRGzzhsHwuqd9fO0v/WzLhWQSTgXoG8Mwzl?=
 =?us-ascii?Q?sm0qKfS17/MvqIcadXM/lv6TiAffXr+whZZjDk2LSGk+yWtaW/94k1ws7q6P?=
 =?us-ascii?Q?vdDauReqpsG/70sG9ie7Yg9Lqco2iOEs0mMvIuE3d0VsdGQCO79pFo7bDPsM?=
 =?us-ascii?Q?3ig40xJtKyuZtDyjwjxzwqeYpWazcNVNtA8CdtCaO1/RAukMtCuLyrcyop+K?=
 =?us-ascii?Q?bT5ImMUXwv77PwtzM1RH5uGvN1wOvHjeuI+D0SZbscYpxFZtQ2kqoRKswFvt?=
 =?us-ascii?Q?A0Uf0fn4NrPNpDaVP6m7HTLRT36Rzwev8+UJe4qGI/FFV0iO1wRLxTeHDvGY?=
 =?us-ascii?Q?Mahv8QaILq+C/TcWMwkfopxP19xLjQ7V30KKPWPqqsGf65JK7seOXQhF94XJ?=
 =?us-ascii?Q?gJeyvLI/G9xczTFcQ5bVpZjhCP1RSvzccOrH6wZhp65WmspZk5gsraJglNhy?=
 =?us-ascii?Q?OG5Y7cd0XyHbVeKroe9JsHW1SJ+AOx7ZDn/LuxwHw9v6MbY+qhHJgmjwLVOD?=
 =?us-ascii?Q?LbhC1SfoIf9NIk0LPtcg+kXeOOf1Q5/cc6r7+d40MxE3rFTn1vNSLKKn4hHM?=
 =?us-ascii?Q?t+K4OZ7GlWGVc8RywEVg2pPXVlTNTNQQ5Qfraux5BbGldGOcGZJGOHDWGtnj?=
 =?us-ascii?Q?Tsvtpjm9IgQqqTEPvzkyUSCH1YLXsGRKw0Td749gPuGqGdUZMkxqawIbjtrT?=
 =?us-ascii?Q?q9dii5oXpEKz7scDQvvzPH+PW0e4xXxMsFB0WbGG7HZe2PeoMflGHsBDCoRN?=
 =?us-ascii?Q?6CKYH4vYWNcOJsoUJ/TA2nKYP96CaSDgyNyx9463G/Gm6LdX1Euxr7PtBTxt?=
 =?us-ascii?Q?7I+S05szd1eLuIYBwTnvxWeQmY9HlkAIBmQHIpt/VZwkOOFUzTEwuBbct1nl?=
 =?us-ascii?Q?M82120RtBPTmwRIsE+xKs77qVo8VdsbwNPOxdxaJ1uX0NogILsJ/GwdWuX00?=
 =?us-ascii?Q?YqIgBdQG8t50A4yPrDHkgvYxYRcLrVE73gyTBm2QnRHmnUTCeO0Jmjn6dY4u?=
 =?us-ascii?Q?CJrTVlot+EsoP+TIopWZrvQCjdVQEbMeJsqPHe+M9Gx8cCFvsa7diZ2h5ex2?=
 =?us-ascii?Q?WQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 91153f37-f9fe-4077-b650-08dd8d7ea68e
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2025 15:48:45.8379
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QOLcDe4N9/kCphYzwHtzALS5yvI7L21FttMN4COsZKgjeKcFFCQKeptSol9ug8aYIbmYoC0cjnuapM+MLrwD0P7yJQtLeJ/Em6VI0PKZFPQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR02MB8289
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA3MDE0OCBTYWx0ZWRfX6uOjItJ+2D3b wT2lK80sKZpKvNW9RRs4UW15N/0Z9stVAvT2ToBd6IEG28ghb57TyIXKyFIpItdLCmD5E6Yra/Z Z9MC5tq0MX+/Nb55pjBNcZkrG2RBOWX5DKZ4hhYBuxWzx000HTj0fEjnZOHwiAc3K21mJJGwHJn
 vCbuoCgRAVXxSW4JVNlhDjvY8WYimCoYvWZbFOOQZFVdvruOMctuSMFT/+gPbaQvQL8H78LREiM aPZEiT2fGsqU5YLq4emAOUNkegZu21Kl7bttS26JrTZZmHmtC85rBLu1tX3aA9U3gaKJYLoAhue W33E9Qegaj0xsEGZ/ouECbormzm7Q6yNMw8wy5fev2M15g3PgW+FO6EHNipGONiaxZEsfDqiM5j
 b/5dtOf4CClNrvq8P7xA49eyr7cHqZ5P5C/m/p7JZvAMaC3e/AvacMbY2IC0Jzu30l10s8nJ
X-Proofpoint-GUID: -oMo3zARGICN6pRU--Bt82IyhvB4YSZ3
X-Authority-Analysis: v=2.4 cv=NMHV+16g c=1 sm=1 tr=0 ts=681b80e6 cx=c_pps a=UiiUhvOI59TtQsb/yF5oqw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=vUiVQPzeGo_9IFmZJakA:9
X-Proofpoint-ORIG-GUID: -oMo3zARGICN6pRU--Bt82IyhvB4YSZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-07_05,2025-05-06_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

Use xdp_get_frame_len helper to ensure xdp frame size is calculated
correctly in both single buffer and multi buffer configurations.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7babd1e9a378..1c879467e696 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1993,7 +1993,7 @@ static ssize_t tun_put_user_xdp(struct tun_struct *tun,
 				struct iov_iter *iter)
 {
 	int vnet_hdr_sz = 0;
-	size_t size = xdp_frame->len;
+	size_t size = xdp_get_frame_len(xdp_frame);
 	ssize_t ret;
 
 	if (tun->flags & IFF_VNET_HDR) {
@@ -2579,7 +2579,7 @@ static int tun_ptr_peek_len(void *ptr)
 		if (tun_is_xdp_frame(ptr)) {
 			struct xdp_frame *xdpf = tun_ptr_to_xdp(ptr);
 
-			return xdpf->len;
+			return xdp_get_frame_len(xdpf);
 		}
 		return __skb_array_len_with_tag(ptr);
 	} else {
-- 
2.43.0



Return-Path: <bpf+bounces-57091-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CF2EAA54D4
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 21:42:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F23C0502D91
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 19:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C5A8238145;
	Wed, 30 Apr 2025 19:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="aVE5YBy2";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="Rqp1EOyo"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4072A1EDA3C;
	Wed, 30 Apr 2025 19:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746042123; cv=fail; b=M0cE7nZvgH/cWMoZbDg74ZXbY/+VYW0IGzNcmncnk1wxSu+40gFs+xEJD5vtX+3Sj3lBuCwmb36IIWt+mw/KbIUbZXc91YsO7okIgSRwMnkGlM0fe5n/WEugoiWY/X7UhzzJ5FMQDwb+Hars2sOpNGoyAfWeoOYIs7aEB8/tX3M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746042123; c=relaxed/simple;
	bh=YbMTc/y+Q6XNZLlIBgiolisCvaQT84Ve40vVEvSrKk0=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=JwwyBeIjxfI8IzvYfYeQmup5DKMT8bQzPaPhA5SjJh31Tspkke3qVJHb9934WNeyw9lJFnXCpL8sBPXqHvk7lEbJmlG19YvY36HlVM4iicfB5wlGbI0+IYTX477ES4UD/RInFqTYh2OKh5h3gjXfd7fIbSWsDZa0y/5b0yWC5Io=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=aVE5YBy2; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=Rqp1EOyo; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127844.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53UJ5CZ2010420;
	Wed, 30 Apr 2025 12:41:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=S9H2AimZ5U2EZ
	FlpkN5jEDKk5XlaC+DbCNvxR++kT8Q=; b=aVE5YBy2KKsOXTQ/Mzs+2OJ9XCTIT
	j0G4grRi1B/s/cMzOMFX5wmqzx3uNYoXtU/EhqXynidrOQ5+EmxuN9PZhRO8z27r
	pxvx6+warwaqt3XOq/PfOYWnVhShr2bEzbfyG0LHak5Hv0gVImBgMCpeMpYUh6/R
	W0KvrYjOpwzNQsrjla91jUTLpoRVNrKd+qZJq4EBslW6TMYd7NcPaQ636B1aLb3x
	B2QyWO392bkCpkUsPRmJEVpO4r+gE8KhkZvrJ4c+nbQ4s2YfgoK+tIUYGuhnD8Ej
	qUgX3zVshZSehGy8miU9AKKogINUPxVn4ba/smaE2D/MKLGIs1tLhlRPg==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 468y109ydn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Apr 2025 12:41:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLaCOnKxzGownQnIkuTKiFTiIHhiYQO4eXm2rDt3hovFrFPthzXNEoiiWp8E+JcToWIGQM6mVhl3TnPhvz/GMQy3N78Lsgk0CAFnHVHJclBJ0i0qTUTNyv5JbjYnOEMhR41kdjKxUKPLOsSu6QJzRjZXflzzYA189yYZQtAIrT4dpaxzuS0XN4RsBveanzsw6vVf7X6bChDQBhYo8yTLJy6qefKGZGrKOshLDIILJ+rtcwbg/tyizqzdXqqR54vzzWfSYDOxEsMkbzFeDj2PFi4keWpvx+selUXgz6J24a1K+jpHyWomXv3nOqbGnrFLq51kOIC/2t1pgEo3hUQctw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S9H2AimZ5U2EZFlpkN5jEDKk5XlaC+DbCNvxR++kT8Q=;
 b=HAL5WPUqB1NccG9i5qOmXa7opSXs3p3sixM78b9eK2Ct/4QnDiJTQvq3vtlTnuljhggd2GVNqAZqN48hOtBOu7tfy2wo8Zw1eIobjx/TYGBmCBXp7lXzrg1MouAHByT86w2oODLMNNiUf7iHQXrg+sUuAAl2lOVGU+b48dGv4svggrCfLqNWye+VOyJqxMehwa2a3wLHXp5+FiaZH+7r9m1AlXp7bva9kEYyGWwJ8gIvOAEEJT3sWkvvAoTcYotPxp7xmUb28jNVucO/aa0cLxqKDneM+adcCLVWL4Hlk4DjS0Yt67Zerrilo9C6Kz9tiWaW44jtUjMKbgfseCM7Hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S9H2AimZ5U2EZFlpkN5jEDKk5XlaC+DbCNvxR++kT8Q=;
 b=Rqp1EOyoL37zAlBoAYYXcaT1ficXh/1ziZW+Na7uzD200dEHYj2Qg8cBG4Flu0UCyr3ubXsMzXSinqTlLuTNbiLwZ+88FTgSvgcWgi/6R/UrnKBRqvULq1Urr+RsgYuOIDyOm9xMcZdNt1qwnG6EljL/ryXMTpNZxD8hvDxMzBLMuUJjN2eMsrw6+xnpGAr6S+558XtXo+kEcBU4M91TFDdjiigDAKRFYugtib9DF/jsmurrwM84WaJ4CYIAWxXlbZ+2E7gmCWPGIZnD46URT8lV2D73zeDCvi2E6ijTqCKBBB8tBMZ5kI3LiRJfh76r7jsJXeCfh4Ti4NDYKfcfTA==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by PH0PR02MB7736.namprd02.prod.outlook.com
 (2603:10b6:510:50::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.19; Wed, 30 Apr
 2025 19:41:18 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Wed, 30 Apr 2025
 19:41:17 +0000
From: Jon Kohler <jon@nutanix.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, bpf@vger.kernel.org
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v2] xdp: Add helpers for head length, headroom, and metadata length
Date: Wed, 30 Apr 2025 13:11:18 -0700
Message-ID: <20250430201120.1794658-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR13CA0024.namprd13.prod.outlook.com
 (2603:10b6:208:160::37) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|PH0PR02MB7736:EE_
X-MS-Office365-Filtering-Correlation-Id: ae290281-cd3c-47f0-0437-08dd881ef9c2
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|52116014|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tYUF+sV33/Tb+dJulcvKO5TfcW7KKEMmnuW02Q6M99fjNgollDDX2mdIJB7I?=
 =?us-ascii?Q?ddJR2lsX/LLFFKLfxkklkJVCIGjDGm1GswwaQ9jrI7w8dfIygOGxjG/roUXx?=
 =?us-ascii?Q?eZfIfzSVWUFYiY8LbiC+XFTQNyWvfgkawplZeuTkZ9/mHncRSSbv5AJDHNcn?=
 =?us-ascii?Q?lXDTlXvHuKdazTHLDM4EV9WrZ9qpFOw4NH5hLfJbwFh4tLGyS8R9lRNHCvKS?=
 =?us-ascii?Q?n4eCq0CwpSTMiqItq6roeEj0AeUcITvqthrwA69xBHWc9Yb5CKzGkP48WB+A?=
 =?us-ascii?Q?zZCXjQKuOLPkcvTZ/2Gninx4r+AVpxFig8Na7llArmY13bfpvYePSX75HSUx?=
 =?us-ascii?Q?bbbpQp+dovpls68/MmH5kb4LI2Sh7d1OOQOc0reDD2hpMn4EdAN9LCRMuPZr?=
 =?us-ascii?Q?lcu13xRyaa44/2qnz8cGwroA+4Jq844SyxihKdGaO+lzOvgQYO+k/uWeTffx?=
 =?us-ascii?Q?xED1FMJZUNtxNr6XS9UjY+ytD14y1366dPNbU2pLq3lBlaZgCxCJwUfbIj/p?=
 =?us-ascii?Q?+3nB+Xxq9cLa+Fp8PvTRzome0wrXeplQB3CGZWthH35OpIN8ZZgAUhisSF6u?=
 =?us-ascii?Q?qtfH+NxL59x53Vfax1eCM/ZlZvtqqAgp6ya0tAubjaBBe1PSfCQNptEeaNRh?=
 =?us-ascii?Q?kISpFjM0VCVuGb0g+6k5lB8xYuy4SykSRXyeSHrDIthTbqZKnzLVIqslldZ7?=
 =?us-ascii?Q?m/8lGLxECxgVsK6yXBBkXi8c3UFfA05xFiDIeAZPlDnCFRapNpwcs+PY/Try?=
 =?us-ascii?Q?d28ybpdK2sAMoySGZmBaasPqdGeZXM+eErH/369CZ3uH3P9FZSZXRtmI7BRD?=
 =?us-ascii?Q?uPjcWfEDMDoc7zEJQwa3k884P8VSF3/yzt/m6/uxzPcHTTbZ65LC1/ee+5p4?=
 =?us-ascii?Q?4aXlxJ9XCbNJa+4SvQcbfsBBBrJs/FgHtYCCNVelz1cF/rNldDoM0+HFyrmG?=
 =?us-ascii?Q?jFH5zljzaKMGhLwcnXnWiEyIuYl42PBFJk0qewlv4NznghXJLHhAfkKN/N1e?=
 =?us-ascii?Q?0ukb3UrVT5nw0s5ZMy0Df+/talbKGFUaSCeyof5fBQJauf0ipbIcb2BLRaWd?=
 =?us-ascii?Q?lqb/Zycx9EGoXK1ouILvOuWAsnhNQhM5rr8uSheIGZcSK7T9hUCMaDHA6ZpL?=
 =?us-ascii?Q?ff58xLz32HjrHFNpVQa4Mtcfe1xZsz83d3JtnFbPacVZmxS5YAal6YA12tQk?=
 =?us-ascii?Q?yFKV+Tqb1RqI+SLTxQNFgaGYlHsgtCri2UQRbdCs1o+C4VkPhMHMhFfzUdMW?=
 =?us-ascii?Q?Z7BtbcbpDXlcZszaTzWCTHPQGDr0AkYuyxA1tLKY4wlwOLryofXPUcHHGE1h?=
 =?us-ascii?Q?MWk68q8cccJdwxCgcQJmZRNB6Xh2HF2OAW2ZbVmrPja6V5X0vlHki5F/RqWW?=
 =?us-ascii?Q?gGdDNpvHxaDWVd9nGblgjdAQ8rkYjJWJftq3z72FdD0bI5wtaTSx56oUhOlN?=
 =?us-ascii?Q?ewA9vqsytrLPs7dLWV5hDFLKDNRTSkehzyAVeR5ysJVw/rarMf+0ZG+WR9vv?=
 =?us-ascii?Q?oF6rfrWUTOdLDTs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(52116014)(921020)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PBRF9fVhxuyl/BJBLsvceFEpZBN4QKlsKPIwsp+VlTHfeg8QhwmRlq6sgJWF?=
 =?us-ascii?Q?KVge2Xea1t7YOzpx7KMJOCT/ritN3yHQcXB9aRhenGoRlP23Y7P4YHMz/neu?=
 =?us-ascii?Q?6QX+Ir+FizHOCcCrQBSrkynbByTRM1QuV9xa27TPD9jz0R0A4Y69oFxJDLXd?=
 =?us-ascii?Q?EAKBVLRPE2EeXF7M09Ag9ac0dCqXT4EQCVDwDiBiCeeIZTULCaDyiiUNP7U7?=
 =?us-ascii?Q?DbC4divl32HX7QCE8h7n4ZYiJ+47vd47vdp9jchhdSfn19vVf4YM3L8OEUsN?=
 =?us-ascii?Q?YHjzvWHiOZ3yVwBMnYmY0HCuSDB7JTW/JEPwG0y1EDR3DGjoPtXi5XREyIrO?=
 =?us-ascii?Q?3FmEI+g+kah8yKgPYVKzqwLMtYyoTWHVxo6Y6sfNP8wjiuX2grreYiGchUNO?=
 =?us-ascii?Q?XZlPW96hTdYvFFR0qxR95KmeyTnkVM7oU9GurH48/qMum8yl3Z0snKmPV6Gm?=
 =?us-ascii?Q?Ym1Tj/gOMu5hVS/V8/264AWmb3RjNXvDw8hugzU5rZLpzTEnobckvSeoKhBG?=
 =?us-ascii?Q?Dbh+K+PLyssieAKv7IA1xmQ3vBGKB564EvLuolAkTJArKnnPUm+s4aNqH3RG?=
 =?us-ascii?Q?VIPzyD4S34Lcr6X09FornTGZU2KLMUlge0PnjjH2IN97rlKmXz44vWu3/r5T?=
 =?us-ascii?Q?95iN9Cd3W1Ug6Uxs4Gv+ksCPYo3DVKSjqRP54aWdnf38wnodq1tvyzEnYa13?=
 =?us-ascii?Q?U1GE8Othj9U8M+oNJ3NZ5pbD0xzAl1uNFhOOd73Ibh5QaKZf8d9nCTsClIEZ?=
 =?us-ascii?Q?UlpDGVabi0oQCQjIM13+fX0Q3cbEHk0Vxadx0TQXt0GFIusG1KUHkC52sQjk?=
 =?us-ascii?Q?f00w2uqXbkhYEiuPL99KiWd5NaPGn3ADAdSqrEar5BEQkD5A9MHyj7BQWBcz?=
 =?us-ascii?Q?KXtsExbiaUoaZmlqeUimznuEDx8zBS1chpzwvhjiao9tqVuayJorpYg1M63g?=
 =?us-ascii?Q?df4OPEe/a3DStYputgBflxr7BdbpqPxUifJBS4CruEZxtMDeLYh/xVQNAaGU?=
 =?us-ascii?Q?XRCLdrcFvgnoQ4ag6IL3SEscSGZOdHjDSMSI2e539QOdjlhF6jbF4xoU2LlU?=
 =?us-ascii?Q?hWPZQ+3mv+8h5gYvOc/jNAfcOSp2zsZU07VcsBgkPZOk3eryudr+uzJ6/ZNV?=
 =?us-ascii?Q?HSpLcz/2GYBORegPFrIa7H2Z7K+qQJhez+QicfMPUK2FOLYmmKo2OcJ8lHlu?=
 =?us-ascii?Q?WanmVdvk6AywHijwOAA1D19sQtqGoyIcHHyAN//6XVf8z5Upacgz5f0VnxqW?=
 =?us-ascii?Q?JChPPycNk/4QCZVuRSLtvF7Y/kZsPCrmkQr6AGhJVCcez4Fzi1H4hQ0xnQw3?=
 =?us-ascii?Q?8ZuNXkKoslSGV62cqYrwdg6flaneZv5pL6hZ07GYaqOAD/KuVyokyBfMKD9e?=
 =?us-ascii?Q?SX6lBG0hImLLApVN//k/PThIZ5SGTrzcZPU9Dec4OxVNkbtSjF+d9tGuLqCx?=
 =?us-ascii?Q?Ny5y+zPToi+2mYNEVXHFZCtxshjeyRUCzxN6JzR7BPjKQr1tbv1uMLoX1mlL?=
 =?us-ascii?Q?IeEv40JDy1Qtv31ulhicRpKJQjy0XK4N+vyCRi1y1lqReoJ9d17RBH9PN1XO?=
 =?us-ascii?Q?VFhDd3vx9IOvnoh3nRSZQg1eRj8oJgecqirG9WTm6e+ziNbB8yxzqZyono+2?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ae290281-cd3c-47f0-0437-08dd881ef9c2
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 19:41:17.9234
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FBvFbdWT1AlsOop8/2XpEosenfCu7XT/tKM8OlANfyVvYaiga6O1S7eMJR7WNjUeCZCi8MEjKi04f0zByeCjnM8bxymCm7z4FnHUopmtAoM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7736
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDMwMDE0NCBTYWx0ZWRfX2E2ppwFQbMs7 Ko04d1QlAdR+LSSBLZI5n5syFkwjHR+S0I/+VUiZOMglhgqk929jQikL2e4rO/6dCYo/O9ca7x0 +KsGEUFz4VH0qLOufWoAag4tn/uvzDiUis1nDNrbI25hp2Xb+m4A1cY7ZN8NK/X3kN3nmR0Xmkf
 diu73vUCZvLl9/9VX107JS/l9ynPM08rSPbP0HQLfkTzQmWcbH6o5IDHJP9w3ILnvxtrf2IRcY2 oVzt+6dizLbC5bTbk6mSJ8xPtxBKVDsxOXSoE3qwyiU/c7odWiqJdbYKA2eZfrV57tfHZ5qZm1B pyMg+ZfCdXPiqQjXkpZ5oJ6tXz0jcFbQIxjKIDc9rnXRsy5sz5W5vdPGhbH075Htc56Jag041CP
 AGfCZ9HrY0NPNTNz+lt3TJO9Q9AI3wnswQ9t0unuxJlMbWyf6frjsRIIcYn00jbZQJ3wIVmm
X-Authority-Analysis: v=2.4 cv=MNVgmNZl c=1 sm=1 tr=0 ts=68127ce0 cx=c_pps a=dIBsZBmI1wyUZqnlzmwqRg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=XR8D0OoHHMoA:10
 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=51KnYewcZuRi7D_KieYA:9
X-Proofpoint-GUID: bySJR8mZlY3hCKvcHvzGtasbWRnI_pja
X-Proofpoint-ORIG-GUID: bySJR8mZlY3hCKvcHvzGtasbWRnI_pja
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-30_06,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

Introduce new XDP helpers:
- xdp_headlen: Similar to skb_headlen
- xdp_headroom: Similar to skb_headroom
- xdp_metadata_len: Similar to skb_metadata_len

Integrate these helpers into tap, tun, and XDP implementation to start.

No functional changes introduced.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
v1->v2: Integrate feedback from Willem
https://patchwork.kernel.org/project/netdevbpf/patch/20250430182921.1704021-1-jon@nutanix.com/

 drivers/net/tap.c |  6 +++---
 drivers/net/tun.c | 12 +++++------
 include/net/xdp.h | 54 +++++++++++++++++++++++++++++++++++++++++++----
 net/core/xdp.c    | 12 +++++------
 4 files changed, 65 insertions(+), 19 deletions(-)

diff --git a/drivers/net/tap.c b/drivers/net/tap.c
index d4ece538f1b2..a62fbca4b08f 100644
--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -1048,7 +1048,7 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 	struct sk_buff *skb;
 	int err, depth;
 
-	if (unlikely(xdp->data_end - xdp->data < ETH_HLEN)) {
+	if (unlikely(xdp_headlen(xdp) < ETH_HLEN)) {
 		err = -EINVAL;
 		goto err;
 	}
@@ -1062,8 +1062,8 @@ static int tap_get_user_xdp(struct tap_queue *q, struct xdp_buff *xdp)
 		goto err;
 	}
 
-	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	skb_put(skb, xdp->data_end - xdp->data);
+	skb_reserve(skb, xdp_headroom(xdp));
+	skb_put(skb, xdp_headlen(xdp));
 
 	skb_set_network_header(skb, ETH_HLEN);
 	skb_reset_mac_header(skb);
diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7babd1e9a378..4c47eed71986 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1567,7 +1567,7 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
 			dev_core_stats_rx_dropped_inc(tun->dev);
 			return err;
 		}
-		dev_sw_netstats_rx_add(tun->dev, xdp->data_end - xdp->data);
+		dev_sw_netstats_rx_add(tun->dev, xdp_headlen(xdp));
 		break;
 	case XDP_TX:
 		err = tun_xdp_tx(tun->dev, xdp);
@@ -1575,7 +1575,7 @@ static int tun_xdp_act(struct tun_struct *tun, struct bpf_prog *xdp_prog,
 			dev_core_stats_rx_dropped_inc(tun->dev);
 			return err;
 		}
-		dev_sw_netstats_rx_add(tun->dev, xdp->data_end - xdp->data);
+		dev_sw_netstats_rx_add(tun->dev, xdp_headlen(xdp));
 		break;
 	case XDP_PASS:
 		break;
@@ -2355,7 +2355,7 @@ static int tun_xdp_one(struct tun_struct *tun,
 		       struct xdp_buff *xdp, int *flush,
 		       struct tun_page *tpage)
 {
-	unsigned int datasize = xdp->data_end - xdp->data;
+	unsigned int datasize = xdp_headlen(xdp);
 	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
 	struct virtio_net_hdr *gso = &hdr->gso;
 	struct bpf_prog *xdp_prog;
@@ -2415,14 +2415,14 @@ static int tun_xdp_one(struct tun_struct *tun,
 		goto out;
 	}
 
-	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	skb_put(skb, xdp->data_end - xdp->data);
+	skb_reserve(skb, xdp_headroom(xdp));
+	skb_put(skb, xdp_headlen(xdp));
 
 	/* The externally provided xdp_buff may have no metadata support, which
 	 * is marked by xdp->data_meta being xdp->data + 1. This will lead to a
 	 * metasize of -1 and is the reason why the condition checks for > 0.
 	 */
-	metasize = xdp->data - xdp->data_meta;
+	metasize = xdp_metadata_len(xdp);
 	if (metasize > 0)
 		skb_metadata_set(skb, metasize);
 
diff --git a/include/net/xdp.h b/include/net/xdp.h
index 48efacbaa35d..044345b18305 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -151,10 +151,56 @@ xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
 	return (struct skb_shared_info *)xdp_data_hard_end(xdp);
 }
 
+/**
+ * xdp_headlen - Calculate the length of the data in an XDP buffer
+ * @xdp: Pointer to the XDP buffer structure
+ *
+ * Compute the length of the data contained in the XDP buffer. Does not
+ * include frags, use xdp_get_buff_len() for that instead.
+ *
+ * Analogous to skb_headlen().
+ *
+ * Return: The length of the data in the XDP buffer in bytes.
+ */
+static inline unsigned int xdp_headlen(const struct xdp_buff *xdp)
+{
+	return xdp->data_end - xdp->data;
+}
+
+/**
+ * xdp_headroom - Calculate the headroom available in an XDP buffer
+ * @xdp: Pointer to the XDP buffer structure
+ *
+ * Compute the headroom in an XDP buffer.
+ *
+ * Analogous to the skb_headroom().
+ *
+ * Return: The size of the headroom in bytes.
+ */
+static inline unsigned int xdp_headroom(const struct xdp_buff *xdp)
+{
+	return xdp->data - xdp->data_hard_start;
+}
+
+/**
+ * xdp_metadata_len - Calculate the length of metadata in an XDP buffer
+ * @xdp: Pointer to the XDP buffer structure
+ *
+ * Compute the length of the metadata region in an XDP buffer.
+ *
+ * Analogous to skb_metadata_len().
+ *
+ * Return: The length of the metadata in bytes.
+ */
+static inline unsigned int xdp_metadata_len(const struct xdp_buff *xdp)
+{
+	return xdp->data - xdp->data_meta;
+}
+
 static __always_inline unsigned int
 xdp_get_buff_len(const struct xdp_buff *xdp)
 {
-	unsigned int len = xdp->data_end - xdp->data;
+	unsigned int len = xdp_headlen(xdp);
 	const struct skb_shared_info *sinfo;
 
 	if (likely(!xdp_buff_has_frags(xdp)))
@@ -364,8 +410,8 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 	int metasize, headroom;
 
 	/* Assure headroom is available for storing info */
-	headroom = xdp->data - xdp->data_hard_start;
-	metasize = xdp->data - xdp->data_meta;
+	headroom = xdp_headroom(xdp);
+	metasize = xdp_metadata_len(xdp);
 	metasize = metasize > 0 ? metasize : 0;
 	if (unlikely((headroom - metasize) < sizeof(*xdp_frame)))
 		return -ENOSPC;
@@ -377,7 +423,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 	}
 
 	xdp_frame->data = xdp->data;
-	xdp_frame->len  = xdp->data_end - xdp->data;
+	xdp_frame->len  = xdp_headlen(xdp);
 	xdp_frame->headroom = headroom - sizeof(*xdp_frame);
 	xdp_frame->metasize = metasize;
 	xdp_frame->frame_sz = xdp->frame_sz;
diff --git a/net/core/xdp.c b/net/core/xdp.c
index f86eedad586a..0d56320a7ff9 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -581,8 +581,8 @@ struct xdp_frame *xdp_convert_zc_to_xdp_frame(struct xdp_buff *xdp)
 
 	/* Clone into a MEM_TYPE_PAGE_ORDER0 xdp_frame. */
 	metasize = xdp_data_meta_unsupported(xdp) ? 0 :
-		   xdp->data - xdp->data_meta;
-	totsize = xdp->data_end - xdp->data + metasize;
+		   xdp_metadata_len(xdp);
+	totsize = xdp_headlen(xdp) + metasize;
 
 	if (sizeof(*xdpf) + totsize > PAGE_SIZE)
 		return NULL;
@@ -646,10 +646,10 @@ struct sk_buff *xdp_build_skb_from_buff(const struct xdp_buff *xdp)
 	if (unlikely(!skb))
 		return NULL;
 
-	skb_reserve(skb, xdp->data - xdp->data_hard_start);
-	__skb_put(skb, xdp->data_end - xdp->data);
+	skb_reserve(skb, xdp_headroom(xdp));
+	__skb_put(skb, xdp_headlen(xdp));
 
-	metalen = xdp->data - xdp->data_meta;
+	metalen = xdp_metadata_len(xdp);
 	if (metalen > 0)
 		skb_metadata_set(skb, metalen);
 
@@ -763,7 +763,7 @@ struct sk_buff *xdp_build_skb_from_zc(struct xdp_buff *xdp)
 
 	memcpy(__skb_put(skb, len), xdp->data_meta, LARGEST_ALIGN(len));
 
-	metalen = xdp->data - xdp->data_meta;
+	metalen = xdp_metadata_len(xdp);
 	if (metalen > 0) {
 		skb_metadata_set(skb, metalen);
 		__skb_pull(skb, metalen);
-- 
2.43.0



Return-Path: <bpf+bounces-57533-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 494AEAAC857
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 16:42:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 278A41C4325C
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73D4283124;
	Tue,  6 May 2025 14:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="EluST4I9";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="f3Dd7abB"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A161145B3E;
	Tue,  6 May 2025 14:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746542537; cv=fail; b=Sju2K4LXDhE4F/D1L40r3u7v8me5bloYIB/Llos+1tdbhGyKj8K86v2TrHGpV4k1i7g2mQ7jczqeDcFU44KwYHesFd7AtUPbk/s7el5q2Le16YHCjhZtWlRbhjxzGpz5aMRaKE6By0CEJYS3mRkkoCEBe/NRgrsfe1AB+QqyewM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746542537; c=relaxed/simple;
	bh=9ATSdxLn6qkrVf4jNxGM7qSKjwBcb/4x+JOsxQGUbdY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LgS6AlHidRm9UB0M5U5RH2PX769/0PQGopIXcaWpe0/NeAYR0ACFzeQXRd8z1TpbQN9OhQKcMIqIC0ycLvr7u7/NCzxRAsPHezNI6Qd6TVrkwlCJtf6KsOzeFHOIUGK2TOcLqnAAipqLJ+hsA7gTdQxnUuU87NWCXPqPoWoUbuM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=EluST4I9; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=f3Dd7abB; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 546A9EbU016435;
	Tue, 6 May 2025 07:25:13 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	proofpoint20171006; bh=ZTgeO6773zCNr6cl/QUjHe+nVfffLgfWk/HSH9SIy
	w8=; b=EluST4I95xEaW+ZfIm5CCua/AVeukbyykof3aTA6Qy8osLahkCXLsZ+YQ
	xKcTvAcuG3+loE9tXA0ZqxLO/zj8bcxdNoCgdYpVW3gm+gb7D6ZKYXuVyO6CA0vX
	OXccCa72yW/U78Z+SJ9SuULH4nu+EUztfpgwHKrMrUu/Xql/xqKdIQraT6A1ZXSd
	Gr+vzg7zxUkLVDlOtxlM2xMHLM9z+8duvxw06coVFXcMGxJBbZ9sY8reCpz/ovDC
	lhdFYHssV6WsrwGYM/cCJ2nqkMqjeeRBRmMnM5N3QtG96qpBVEl9hV9nHi7t/cQo
	4QqZoWD13B2dNuuFegAFhBS9OhOJA==
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2175.outbound.protection.outlook.com [104.47.57.175])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 46df29663u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 07:25:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S5Vn2OdTHDayXVquctleI2kaO8oDWcaNdH6+Lzq2exnvj2bFZTeW4EI7NGa0BStwPfqpRrYy5wofxXjdEo93FseRXD4sG+h+N5VX+F/WYbIBjyOwoDm4K4dCP3N3lhRRuwog58TwAHm43rM4coUyKCtUAgtwUPjQFFW81Wyvw8wiO6sS2JhzxFo2ISJpDT/7OdQYH5sl+YHGirnHKnYGow+h5kTDrT9spH70VTTgD3ZGUtToSZPDtGXdYr4bq6/GdAhY1ZbMe9rnxFlaEDfNsFmSFRG5D8Bd3BLbgAW6UlJbh3VJZl3FTVCjaZ7HwB76eCe2uqOGqOiaqXbdpG6lyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTgeO6773zCNr6cl/QUjHe+nVfffLgfWk/HSH9SIyw8=;
 b=BYQpyKjCptxvyilfUb3tv6e1nNGO4ymC2IaoJNvnI4LPPlHPWiQPnUI2g0kawzdYrpom2CC6E0YWR5TSeQsF9QT7tbDanodsXM+teuohyuNjUgnp9VMmQDYjFWlDGUKSU1tdiAPekEOiS8LTxjFbXJiImEqXH7uLphe/clY5qh91Bgn0AvOHn0od4mUbxls0wZcHbgdhqeuJxulzoq+m29Sx2Ue0cFQ7EmDkmbWaFT/8jrY/o390KyWo5w0Cvnurok4bBjT3mDyGZbovihqsy2QS1zvuOiNdO5HsyFEdwSbT5OuVPJtAc5cAgY3u84HkUcHDPNEW0WlZdQLlgY6FRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZTgeO6773zCNr6cl/QUjHe+nVfffLgfWk/HSH9SIyw8=;
 b=f3Dd7abBPyPapY+KXdGxktOAO5PZw5I4+LHf7NpufGOxnFtpMq7YcU5jDARZS7ppKBBcOE3rXTsvqNw/4B1XwOI7F+QI1yapk/KGZzS84qaLTXugIqBxVwRGOMKAvsbVMpPkXezotg4PxD24Zt5UDqSQzIiD5nJIWyvGPyryN69dVnhXIr5yBWkf+nCt19wK03DL6xXaTmD2q4H6Ou8fB0tY7YWBaq6qLwHYDrg1nSfhVIhCHtQ4Al64QAslFtm6yTBdqhqrwatFCf5jMTO25B3XRGo30RyS56ssPwJbXnGrGvwHc5Vgzh9aCMmTkarF/ftE8LvxpJiVhh5u01Q0MQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by IA1PR02MB9181.namprd02.prod.outlook.com
 (2603:10b6:208:42b::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.20; Tue, 6 May
 2025 14:25:06 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Tue, 6 May 2025
 14:25:06 +0000
From: Jon Kohler <jon@nutanix.com>
To: ast@kernel.org, daniel@iogearbox.net, davem@davemloft.net, kuba@kernel.org,
        hawk@kernel.org, john.fastabend@gmail.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, jon@nutanix.com, aleksander.lobakin@intel.com,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/4] tun: rcu_deference xdp_prog only once per batch
Date: Tue,  6 May 2025 07:55:26 -0700
Message-ID: <20250506145530.2877229-2-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250506145530.2877229-1-jon@nutanix.com>
References: <20250506145530.2877229-1-jon@nutanix.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR04CA0006.namprd04.prod.outlook.com
 (2603:10b6:a03:40::19) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|IA1PR02MB9181:EE_
X-MS-Office365-Filtering-Correlation-Id: 85a2cbe9-7a9a-4896-500f-08dd8ca9cc74
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|52116014|376014|366016|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?idAeW5MmaRUC3jBv/+1cb60Qs75vztl6Yv//mxttGbXZhqWl9UHYw/mLSGq+?=
 =?us-ascii?Q?D0r2nWtG+iUkLIqdDXZFxlng9Xo0MqOqj3dHu8Q6jT8iLGJLRw1GRZh1TIZO?=
 =?us-ascii?Q?qKaJ9Z2OBlxa6pyN5vlcSze+qiz116wHEacAqSVB3sxI1FniYnW1qWq9Mo8s?=
 =?us-ascii?Q?A15jnv5DrKTKr768uM+ekhBVavVf4c/1uvEBmzNSckEjxEp4oNAzWG5Up6lt?=
 =?us-ascii?Q?PFB19C8Mc/pgcIOO9RngTQSA83sYMruQqQrKuL7K3uHctMRYI4o7K6oJ1YPl?=
 =?us-ascii?Q?kQbSXj9rnDtXrcW5sjAUKCVj8BdrjX4KtZwvoyR12gwVS3AnfuS7+ZlvSL/e?=
 =?us-ascii?Q?ws2ajWAkczzGjQhmGzT9hQNJUkGyWo0hVQTpR+etgaVLmL1ydMTogUC4adEc?=
 =?us-ascii?Q?mTcDYPYGVxgDbpVctt4FwJkr89Ez16YNbPVQ5tX0I+o0iColLYHMjNiBKKoT?=
 =?us-ascii?Q?yX+Xq52jcCd63YwW3qRw7xZQo0YIzbAXaYVq/tywwFQt8FFJjlaE9F9dxPoG?=
 =?us-ascii?Q?zb/DUbToX07mWYq07oK3YARXYMIq7dpYz7p/JN/wOfHQVUhUPCVMSEQpa75h?=
 =?us-ascii?Q?c7Wse1SwFhrTwzq8Z7xrqdr4Ql2isw3H1X0MQ66aK4nsFUEYkjs+ggTLueOi?=
 =?us-ascii?Q?vhUmT9hzbkDpWV4RznYA5NIQVWU1S1Z1xkowq84cIF0CwkkFBMeJL0QkocVF?=
 =?us-ascii?Q?QTgDDSfsSh0JK9JoYgUd4APTpGHJtgd0qWiVqVamWWk5ZWU5Bp3T3tLP+5Lt?=
 =?us-ascii?Q?y18gby71us+3tXFbLXaX2mjKJvyn58G92QvWzrbhx66VR7GG13gnXefh6Nnc?=
 =?us-ascii?Q?wiW1/7UyKaKFvi5FvUTR4fvMEBn6bhgTao8bWZk5ZRH6e3C9ptvdJtkgP3dY?=
 =?us-ascii?Q?Ephi9syeolW42aQukM0CsjgexlOD0NaHkv8L22eRoCYrKNUdg4A/Dfd5KNgP?=
 =?us-ascii?Q?29nqJNpqIGsltthtHbHVGG8XsxIT0gRv+AAYs7X/w53IitaDm8P0qf7MYbQQ?=
 =?us-ascii?Q?JbcQhivMf8reqQIks/+i0EL905Wv5tctzOLUVh+FEwxx3lfV0qIGgZFGzE/K?=
 =?us-ascii?Q?UZHwunGgmFiuyIpRzUuasg0Dyr9K+iVyWHfphII+wFIZjGkZiUdyUkL04neY?=
 =?us-ascii?Q?WSCtVuqFb7BbOjskEEmJ8xXoj2ZrJLaxFnXcQKpTpxoP5aXQAbCoE0a3QtnV?=
 =?us-ascii?Q?YEOEOe4ZmpYw/HgLxOQRmz6Pbf9mc5a326+6RUy1Vf2x6uByvCr+9u0XI9g2?=
 =?us-ascii?Q?zejBFHBSmxuubEA2ScoWHMmSydRFrXuC8Az/+kvOMKijGwLk3W9KxTyoc3B4?=
 =?us-ascii?Q?4AHiV148sTrKuH/15GFTwDNri8sXCDzKgIwSBNebjOrim9IANjBJCf55Vw37?=
 =?us-ascii?Q?RKi0umMswiFMmfgUJ12iHD1XRB7q0K7IAFmcS0Pok7oqxsYK8sn4BcYKeTJw?=
 =?us-ascii?Q?yg36iRjN6SZ2kl6xlxRFeoahZFwGyNF4dkxw0Rw9XIey3mO30TXnFoUVQDxX?=
 =?us-ascii?Q?7ynE2J09zjWPjUU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(52116014)(376014)(366016)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sOCmaN0R+QU6gh9hVWUOujI3Up+jDoIIpdMIghkzvG3ZYBGg0B2juCShxotY?=
 =?us-ascii?Q?/s72LhI7+REDS7R4S4tRIsAb2KP3o1yRZasLfrwfgTPPxgyP//mLbuQLQpYh?=
 =?us-ascii?Q?PQK1bGVSZAv29XIGH2uKCq44Qjo1F+0SiTZ/GXfYrU1dqRMErOiK784w6zoy?=
 =?us-ascii?Q?c4GjB/5KFcuX1xIBOI38viprlcGeysmKyxBKp1fvEZatjwRL2bHCDjcdrf/L?=
 =?us-ascii?Q?S3XpHgnhct+AW5JESWMtX5Nc1eusPXmdnU7GKD9fNBj7h9mEOksC/Rb9DYgf?=
 =?us-ascii?Q?B75fiavBPbJ7pnn6Y9Yi5PoTHAUdkWKxsbvLSTeMaiGOZKDR9wUfKMDqQVMc?=
 =?us-ascii?Q?+0abfACN+6LMmu4FkCaZFZIk75IBCGUY8+2j9rsxcVZZaxGfmuvhts50Y8Qc?=
 =?us-ascii?Q?RcdSMquEKhei5ZqCqi0kXf97HNHB+uIDve7r5WkLKKIixlPmONiN5AeMpYEF?=
 =?us-ascii?Q?CYvKlOomiYePepfFObABiJcw5hzQbvD8oYClURRbl6MqEG/KWg/c4IMOnj/h?=
 =?us-ascii?Q?Q992PnXzhrDHzi29vGSP1Fjux5jFFGCDJtV77qBua0AlAoZ06rrF30zZO5XI?=
 =?us-ascii?Q?MX7KnNxueLdtNYtcbywLSanwlxs5LxQDivsSo08dXj0ziauD5TZB4op83wKH?=
 =?us-ascii?Q?PbfIe/dXHms8GOorNOW/BWGcd4Cq6DChOjQ10FRQvURyKifW1xtAJ3zUSKsC?=
 =?us-ascii?Q?d/h9XFd3tb1VfIHa2s/6wIP2fPtpy8YBS6k3HbxKkzyT5gh58/QqaPIyuxAY?=
 =?us-ascii?Q?c+9rJAbNNDkn0LR3UceWLWZH4byeP/oropm+l4soIHd2DzSZq2g7wJBjiGUy?=
 =?us-ascii?Q?tfHMr81sUnlqvJ+qFk8m11h9RbDfixm3EhtaVamI1hws3CTt7E6RXCRWCKIa?=
 =?us-ascii?Q?OIkG8Md6U96NkJ/dioKtSqH8No5kO1ejwrE3sKdkN9bolAsb09tjdZM375bs?=
 =?us-ascii?Q?Y6zpqzOOcs6tWA9gDfkEDF+fWgb0+mhLMgFF9K0b9/rfJk8ndY3m9CbSAqOW?=
 =?us-ascii?Q?UJFfkGxGT6aP4KrIE9EJzkZkstYz3qotZvXl46WpcfEfebUZm5yUVxyfBcFC?=
 =?us-ascii?Q?swm4GO1aZ+fgNbhIoShpnyEvDuZRYRwTYIm9VcHAW9aWkgSpa5M7AP0IxMTk?=
 =?us-ascii?Q?6LLO1VagEkjqdrqGKIEZ+h6rU+w6pX67uVtb07sI78vok8+ojvZr3ONzd/Yg?=
 =?us-ascii?Q?2fs8ngY+bOu8cY6WgOPGfxDZhKQcCD7HAzu/cXIhI42KLYxfUq4fOlDmhKXJ?=
 =?us-ascii?Q?1WVTzKay0WjsHUm27XQhVeBxCRVzCm1W1K5nZAX6RMWH7d1sQzxFgwm6/GkE?=
 =?us-ascii?Q?Eg5Np+LiwjuXfsRQ0UFY9PrARmZFRdZret+b5CnvJ7hq/vYe8aKPVAkQK2G9?=
 =?us-ascii?Q?hGLGNiBsH1gmVINyO5S4rQXEEeVolLPhmB3BTr18uMqJCFhCpzsTZ8IQIL1F?=
 =?us-ascii?Q?olUM1QzcMBqpU8oQZKNOiVCj7i5zfpeHJ7Cn/p45HuJbn/m4cFFPp0q0gC0Q?=
 =?us-ascii?Q?FI0i1afEpRnCU9TIegZIHm5/cNxidQ0fSVOQnpPQjTYceX1b8alxg78uXipM?=
 =?us-ascii?Q?JzM22QD1uFaVajLVnQjHcWN45VRIpO9d6DXDPZ+RiKD+zEUid5DAihqiTXr6?=
 =?us-ascii?Q?eg=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85a2cbe9-7a9a-4896-500f-08dd8ca9cc74
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 14:25:06.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k0X2YJeClTah0kBQVuWS1TU2JEaH/O+oKzzbSEvxJXNOQxgwGcKkgbR6cj4i3uQBJiLxfwsCZ9uSj6Ko8J8g80fgb1jVZ3L+IBSkpkQqEmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR02MB9181
X-Authority-Analysis: v=2.4 cv=WtErMcfv c=1 sm=1 tr=0 ts=681a1bc8 cx=c_pps a=p6j+uggflNHdUAyuNTtjyw==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=64Cc0HZtAAAA:8 a=uvEAdmOkMdmv6uzBtwEA:9
X-Proofpoint-GUID: 5wf127L8mX7bzyH9oC3eQ64KNz2TaN_x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDEzOSBTYWx0ZWRfX1ohquLXWrHFP OCJUizYFW9fpKSwOaEUv4IYsMTgKT261oTyHVJ+tx81Je3JUtu4wQvOGruuTkXaIMldgvqLFDQy 8lFZpWWT3lgVOzQP/sL7g+e5E0gI+/swTfEQwRvKZHu61DJdiyDu/Z9YkKt77kvSpChMyXIkryV
 JvIoMi3g1G0z0nRpmgBoSmfD7gQdfM3Oal3kLElqOrW59sxQ/3vROsk+Wz47BrQTRnAh9GetMOK 0mcqI284OJru4gwA8GDTMibYmFX7nDqP2fqJSWmlSMkWTqZmngqPJNs3uX+It9AVI0RfCFKBgD/ PTTjlka8BVx3iDyHqcT172lLU/auk6BiOfi+ZAIpeH6Ier52SYrKgpHb3OrxHip61BNSZAW+O/2
 dXyXkMdekhCO0yMNqSHmhn8l/UmchZclsp+8f1RWnWV6ENq+x6ZrDoQstax8XNYjx49mYJb6
X-Proofpoint-ORIG-GUID: 5wf127L8mX7bzyH9oC3eQ64KNz2TaN_x
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_06,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

Hoist rcu_dereference(tun->xdp_prog) out of tun_xdp_one, so that
rcu_deference is called once during batch processing.

No functional change intended.

Signed-off-by: Jon Kohler <jon@nutanix.com>
---
 drivers/net/tun.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 7babd1e9a378..87fc51916fce 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2353,12 +2353,12 @@ static void tun_put_page(struct tun_page *tpage)
 static int tun_xdp_one(struct tun_struct *tun,
 		       struct tun_file *tfile,
 		       struct xdp_buff *xdp, int *flush,
-		       struct tun_page *tpage)
+		       struct tun_page *tpage,
+		       struct bpf_prog *xdp_prog)
 {
 	unsigned int datasize = xdp->data_end - xdp->data;
 	struct tun_xdp_hdr *hdr = xdp->data_hard_start;
 	struct virtio_net_hdr *gso = &hdr->gso;
-	struct bpf_prog *xdp_prog;
 	struct sk_buff *skb = NULL;
 	struct sk_buff_head *queue;
 	u32 rxhash = 0, act;
@@ -2371,7 +2371,6 @@ static int tun_xdp_one(struct tun_struct *tun,
 	if (unlikely(datasize < ETH_HLEN))
 		return -EINVAL;
 
-	xdp_prog = rcu_dereference(tun->xdp_prog);
 	if (xdp_prog) {
 		if (gso->gso_type) {
 			skb_xdp = true;
@@ -2494,6 +2493,7 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 	if (m->msg_controllen == sizeof(struct tun_msg_ctl) &&
 	    ctl && ctl->type == TUN_MSG_PTR) {
 		struct bpf_net_context __bpf_net_ctx, *bpf_net_ctx;
+		struct bpf_prog *xdp_prog;
 		struct tun_page tpage;
 		int n = ctl->num;
 		int flush = 0, queued = 0;
@@ -2503,10 +2503,12 @@ static int tun_sendmsg(struct socket *sock, struct msghdr *m, size_t total_len)
 		local_bh_disable();
 		rcu_read_lock();
 		bpf_net_ctx = bpf_net_ctx_set(&__bpf_net_ctx);
+		xdp_prog = rcu_dereference(tun->xdp_prog);
 
 		for (i = 0; i < n; i++) {
 			xdp = &((struct xdp_buff *)ctl->ptr)[i];
-			ret = tun_xdp_one(tun, tfile, xdp, &flush, &tpage);
+			ret = tun_xdp_one(tun, tfile, xdp, &flush, &tpage,
+					  xdp_prog);
 			if (ret > 0)
 				queued += ret;
 		}
-- 
2.43.0



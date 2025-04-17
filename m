Return-Path: <bpf+bounces-56128-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 29B96A91B5E
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 14:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA40D19E410B
	for <lists+bpf@lfdr.de>; Thu, 17 Apr 2025 12:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BA6724113A;
	Thu, 17 Apr 2025 12:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dGd3KEZd"
X-Original-To: bpf@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AECE241691;
	Thu, 17 Apr 2025 12:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744891248; cv=fail; b=D5Udjt7wi2gmGX44E8UsLtxK900vzcdkXmrrEfsKg94uVr/KXEvidek5ClXKq+sjqJdvV1I8/Rvi00ODIfa5vkTgEd2aAAFkI7dwtlrmsHFXOXnamjqF/Cs9/GqUDrjAFeAy4yuq2Bcmh5xDEBR4qEZH8B99gNbR32CfiQJSGiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744891248; c=relaxed/simple;
	bh=UoS7tXu3HJ+aQ6lRYx1/rwCk+WS71bFlnQdJvH8yAQs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XysGHgc/U3N8+W0ZVUsYHyoPjwNgWIZdmhdnkP6raWLj5daKehy5ggbHFhWkx03lDrH2oIkPmDFo86Ma9IWT59w+52vgxMmyKlAkWMI/uL8DIXOrNfxbpdnRBmTZvDFtEh7O8BiylR+vFfI8DwYQXqfS2aoiVf8Kzf+yQ7WLCvM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dGd3KEZd; arc=fail smtp.client-ip=52.101.72.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ouGr9soiA81TJnPqLm4Km18FEdBwMHoUQuZZA/O1uKXbUMYU6NPZQEh7uRR9Ro9lQ+9y6FnJnbH+mxUwg1+dAAS+IlItlydhBYtCffpiFLGzabvLs+JiqP8lcyaQn8emosF8SGUNL/0F6fRM3Ap8A3MFKXUyZz+pLs+3xcpGncaTogAHqQ5Xr1HSY2wiBTILV760F/VmxtYQ4Tb255flXf0KaAKL8BrW/2+VGj+Fm4M52FfYD5jiw4LdLIqXjy5dHIQ9v1gYZfCgBBtoNr6ZswqYxccM4h8xc/2fxaAlwIGWaWtUE7jQqiK/J5MaidzLdNsfpbuR5ewl4SKHcoxcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4bz3domnVZmTP4CF6LSGVDsJyyc9LXfSQJyooCZ1Rug=;
 b=ee0/prFyjgEF06Dl216pgoKCcvVW7mMNcqwBXAdT0yYIa01F2rNJVQFxB494VqhtLff7nobva7g+xJZohdumgYmhoAhmmVbJzDxTkp2q0EPvg+BY3BrPB5sojaLdnWhBDmKvNI8QQOw3GHlum9qzCZpYKq1aCS79rWYjDGHwCCXpVfL7WFzDAMF70sj4cfrbovtaKt5Hg2jk0qJFTDha9BzWZelQOxcOZnX2TBa9PIv3pi8K31/yoD9nLU3w5wijVUHQDgErBUYqYz5kpcMpp4w6tjXwrjRUUFOhUsz/68lJuEH+dAHGCdvb6ISM1GxlBeu/LPm4EGdyC4lDpCVShg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4bz3domnVZmTP4CF6LSGVDsJyyc9LXfSQJyooCZ1Rug=;
 b=dGd3KEZdiXuSV1c5lzpRNtlklGh+fuPWrHhKzjYO+gTetKjfgIQhE18E94mOt+vBbSIlTg3215auN2ILZ1FOoTkNPGbMIvfem7xBItc+gTgvjcvS3uj8C4njdDnbI7/Noqaz04QW02Q959R9kCFTn4gYotGWLNPxnGi9rCfvwTHVv5pJaAGQHnYLuV0vBPpYoC8wnAwW3BDBWwvXVEaigsXACp5DUsA9jmhVWDsUpwflyHEsXcf+kUxlw9jqYxxZfIA40YGTq3F80nIKTJvgg+n3uYS7wNNKNrVqGAmOqTFp0KHRbN44BoIqdTb23UB76A/8ue1YDKicj2f5wU/R2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10560.eurprd04.prod.outlook.com (2603:10a6:150:203::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.22; Thu, 17 Apr
 2025 12:00:42 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8655.022; Thu, 17 Apr 2025
 12:00:42 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Vlatko Markovikj <vlatko.markovikj@etas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Toke Hoiland-Jorgensen <toke@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net 3/3] net: enetc: fix frame corruption on bpf_xdp_adjust_head/tail() and XDP_PASS
Date: Thu, 17 Apr 2025 15:00:05 +0300
Message-Id: <20250417120005.3288549-4-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
References: <20250417120005.3288549-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0023.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10560:EE_
X-MS-Office365-Filtering-Correlation-Id: 1c715414-4e4b-4c41-28bd-08dd7da779e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|52116014|7416014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?3bfM58tKnWDYFnUay9TaC8LmdBkh7ACdT2nv+4nUL6riWbFheWudB239Aw3f?=
 =?us-ascii?Q?p63/yoNcfrwhBMLcatxox5RgG9C+Jd55FWJ8qG4uXIAeSZre6B1DA4ucQL6B?=
 =?us-ascii?Q?Q8ep96WyJBrd1o6gSEUUrYDC15yoCO7dDTG+JdcqUimZpmXcv3O0TBJxODJx?=
 =?us-ascii?Q?JVc6Tfikn8BcanotlT9vN7PFCfndQ148O0oWgvYI9Cl7H2FGkY0xGr8fjc2o?=
 =?us-ascii?Q?6V6SLNd4fo5YA3ao0ZmCC4bZV1RFS4lebk9k4Q53l7OYJhEEpy8MuMb+cFAN?=
 =?us-ascii?Q?7EVmyNRPCNbldDx2licuPy5bS9WLs43lms9yw64PmZ3Yy+m8I8Z9gRUwIsk/?=
 =?us-ascii?Q?G/9Zv/WjmETeHG1iBmNwIgowN0Lcu8XQAijFhPV1QQCi/ZeR7Fb8fCz/Bx9V?=
 =?us-ascii?Q?cqgf3W3im4M+IFw+IBj86PCIzOqLPOG0QRBdOEISy9821ysrQ4o3DITrtAb0?=
 =?us-ascii?Q?wxotk3IkW3CdxgvWqMX6ObmoxpnyMIuMAkhG4JJuEpRShU5LSDjBGISpoOQJ?=
 =?us-ascii?Q?4Uin+IjaCog25o+pjATDH4Y+UovO+ZJZtsjk3rOAuURnVt5Db6FKcvDKWePS?=
 =?us-ascii?Q?kNufI1LCQgStd7pRcCINUnW3TTGdGWY8KdEJnMg8RkIOIKpaBzRPPDiIOIjP?=
 =?us-ascii?Q?Lt7IX++UhOOMhqPu0/YbYCdVG1s22gl8IEEk9MX2gYardF1j2daH+tcnVmoH?=
 =?us-ascii?Q?saHxlpUh09bbJ2mp/A7yYCVHlUSju11eVhSJ1BD+RSbyaJJggOR2lRtr1ztu?=
 =?us-ascii?Q?fpAvdsE2FU1yNzF3siTSnytzJSVuhMMR6qESmi4moknCfPbAkPg/GQuxUGMo?=
 =?us-ascii?Q?O5k1pZfLSNBeXh4OqERYxEedygD7eh8/agZeY89dnrY1wJtw4x53wS7HmNhz?=
 =?us-ascii?Q?iyHXiV/EUeYO/K4gBXfeKEDrllabl+bz/W6qs43sFj7kBALJXHJOef9N45YJ?=
 =?us-ascii?Q?x9HqPKkHv3ZioIEDmj2DZJyctvrVJQDdYaMJYpiAahrY2JIIePsYh1EWgiMg?=
 =?us-ascii?Q?+QPoddkZbk1lCvlw6RSbKTtVcJDNAMBQDYDbZZsMfBgcwWTApj2M8EXN+hPz?=
 =?us-ascii?Q?Mv25MaGU61X67w2WKBVdmiczX61bBpSiZH/LsKPYSSEXnSqRKm5WeR+RM8v/?=
 =?us-ascii?Q?bYppuXXhYKYHED8PHOQuqGhdfuvGvhSHPjtRACHeSn7A4RsyEmjSqVoov+hY?=
 =?us-ascii?Q?08xXcCN9Kaz0h++SLE2ZMJJx3mA/TGrgPgzuU1Bi/aTT6PMo03er7QkAjZPp?=
 =?us-ascii?Q?zrUuE+LNLePbxYzgyTroDh5wHOoBTEAxPjmpFYs0TMKi/EMVEkd1eK4V/9qW?=
 =?us-ascii?Q?Ew/GWJZlH7YfkfhdUDKpK08iWPDo45FIv6AK6yL4NpDTnlAANiezjEIaZ1px?=
 =?us-ascii?Q?d8Zr9jWktyNAYjQZ9Gw0mcFelbp8+4Ylar2ecaCOA+P8anVF1tDyoJxKDK3a?=
 =?us-ascii?Q?GZ5ZTCX4H7vNH6V44rolMGOUpGcgQOexJQIgNNI3pE77d+9YQXVXFw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(52116014)(7416014)(376014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?6EsqalDqGpMZ17kwIsWjePO0yTuvwwif5IxW3hd8LPMMp/PCovgS2+nJZmgq?=
 =?us-ascii?Q?g7gDL/GwEELoyy3TJFCDJdwTzEwk1+e0RC4oHlfY0ThqsN/mIoLekJa1/QCP?=
 =?us-ascii?Q?07nf9V3Tth39hLOhUVd/QkHlhNx4qwRpqRCP8lubDMbP1HY1Bvo55a0uWAwA?=
 =?us-ascii?Q?f91fzGci9ScuxAXsu4zT0gnNNb1NlbH4u9VAsCQ+ZyKCBrv+7nQtsSLAZ8dH?=
 =?us-ascii?Q?OfltsPI78MZ8Qdwb9510aghUbB6DsIY5sJYaX/+vO3mZjlM1umFdlqboquzZ?=
 =?us-ascii?Q?5+ONt6Zu8gs8nQpcgfD0ava2AfQjCZSoIVwRpcZwq9ijKlm1IeKW+IWJiIk4?=
 =?us-ascii?Q?sOX04+8Y6KX8r+3d5uU1uQczfL2wthRUsFEWonuldBaHa9QWobYQcrLZgknO?=
 =?us-ascii?Q?DWlGtLmW2RZX981TrQ08JARZwQzAP7SjlM5cTfThi9Lz0uVzaXG3JtkIeqI8?=
 =?us-ascii?Q?eQU2LcN/OkZZctAE+z4O7wsNknPIk5suznWXkMi4sx7BJMUOUdZCJqqaixSj?=
 =?us-ascii?Q?Yc9LdW86jgog9IfMSPGUWtXlLEZ0oV+o5UJbrYBh5TGXu8pZrA71Wy2ToLow?=
 =?us-ascii?Q?OyE6zPeKP+tAGvSXA+To8PgIYNGqkmhRwGjMqqpEqWQwjtAh14nq46XgZXe2?=
 =?us-ascii?Q?NSvinfprkbCQvv88Rn+rfhHTSmLaKD1YNKM9ZpmyRvHjdRnSIsaeUs9Qllsn?=
 =?us-ascii?Q?R0w9CBjkkh2dwVoHTtRBLWQIznoUTtQgAKN9umRch9BJxli1H5pncJtmUs71?=
 =?us-ascii?Q?a4/TNlfnDX/h8W4Xre8sRsKgBozB01zaPGjonPpKJRiBJFW99Py7Xe9hAlVI?=
 =?us-ascii?Q?bU0tc3R3zdGXRU0Y5cO2O4lEDMeQnrbZS3TPsRKeuSNRX+TRq1R3YQcB5MUq?=
 =?us-ascii?Q?Uh2TVgm70m/FOVeidV3jJeANhGs5I207/VsGkLDfyUd9ERfdgW9iEU+9NTHH?=
 =?us-ascii?Q?/cbuzdcLeHXQWyD8OHo2S366YuzvpH/AQZe/L3yASfYQVhVepbEoVqi/GPkL?=
 =?us-ascii?Q?7l5qGyXLHrv/twwWVsc7xgxD8wUQHGxkINgJEtiqpb9eNmFGuYX0SVlsILH4?=
 =?us-ascii?Q?LAThdh5TBBO/OxKOcUCd1NfyVdZNtGGqSB260/U8v31icqyWgd+2S2Etka70?=
 =?us-ascii?Q?dW8ZSQ8rYiwvwk0p67peKolXMkcKTFz6SzdrAzGKP/vWjvUOx0XALbFHcxuH?=
 =?us-ascii?Q?L8pJ7ATvnoSPdR+t12OHhsRMZKJj2cQEyLY/eLOCMSElmwsipwX8qcSNpOoR?=
 =?us-ascii?Q?DmPu8DemxaAirB5zVM/vv5a3QBv5Ey0ClieSJscZG84WAUHnpVYIn+c1Vnm/?=
 =?us-ascii?Q?F35Ew2ckLUc5NOQ1ML8usZ1WKr80gWS7uhw5QUcjukcx7uDd1rjPWvLjW2tz?=
 =?us-ascii?Q?+CW72zcJuiZ6Wme2DLmUnZm+5Et5P/wZlqOYNrkcyFYjDbsHlfxZY1ORecej?=
 =?us-ascii?Q?FbooqlWYABoQXrk5kvCb+qbFjnEuTYOzKeE0x1XapCPxyfBvy8n89iAWUjux?=
 =?us-ascii?Q?/2wLrr86B/AS2zuhuLehsokancOYk/YY/Z5cBzhWe7IC7KgSNdoXkPX3k4Xz?=
 =?us-ascii?Q?vUm3jyRvbIRzdQYn6oTK3zaF3YGQzmndnyUyU+tQoNfk/HjIi1sKWgOEq6Xk?=
 =?us-ascii?Q?Zg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1c715414-4e4b-4c41-28bd-08dd7da779e9
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 12:00:42.7770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: g2vd87/wmNJjD99mtw5SkGW+Uz7KgveSn/sLC4mPnyg6Wi5eWXitTIIoZHqU4AEViIHxpD2jBCFIHnd4x+s30Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10560

Vlatko Markovikj reported that XDP programs attached to ENETC do not
work well if they use bpf_xdp_adjust_head() or bpf_xdp_adjust_tail(),
combined with the XDP_PASS verdict. A typical use case is to add or
remove a VLAN tag.

The resulting sk_buff passed to the stack is corrupted, because the
algorithm used by the driver for XDP_PASS is to unwind the current
buffer pointer in the RX ring and to re-process the current frame with
enetc_build_skb() as if XDP hadn't run. That is incorrect because XDP
may have modified the geometry of the buffer, which we then are
completely unaware of. We are looking at a modified buffer with the
original geometry.

The initial reaction, both from me and from Vlatko, was to shop around
the kernel for code to steal that would calculate a delta between the
old and the new XDP buffer geometry, and apply that to the sk_buff too.
We noticed that veth and generic xdp have such code.

The headroom adjustment is pretty uncontroversial, but what turned out
severely problematic is the tailroom.

veth has this snippet:

		__skb_put(skb, off); /* positive on grow, negative on shrink */

which on first sight looks decent enough, except __skb_put() takes an
"unsigned int" for the second argument, and the arithmetic seems to only
work correctly by coincidence. Second issue, __skb_put() contains a
SKB_LINEAR_ASSERT(). It's not a great pattern to make more widespread.
The skb may still be nonlinear at that point - it only becomes linear
later when resetting skb->data_len to zero.

To avoid the above, bpf_prog_run_generic_xdp() does this instead:

		skb_set_tail_pointer(skb, xdp->data_end - xdp->data);
		skb->len += off; /* positive on grow, negative on shrink */

which is more open-coded, uses lower-level functions and is in general a
bit too much to spread around in driver code.

Then there is the snippet:

	if (xdp_buff_has_frags(xdp))
		skb->data_len = skb_shinfo(skb)->xdp_frags_size;
	else
		skb->data_len = 0;

One would have expected __pskb_trim() to be the function of choice for
this task. But it's not used in veth/xdpgeneric because the extraneous
fragments were _already_ freed by bpf_xdp_adjust_tail() ->
bpf_xdp_frags_shrink_tail() -> ... -> __xdp_return() - the backing
memory for the skb frags and the xdp frags is the same, but they don't
keep individual references.

In fact, that is the biggest reason why this snippet cannot be reused
as-is, because ENETC temporarily constructs an skb with the original len
and the original number of frags. Because the extraneous frags are
already freed by bpf_xdp_adjust_tail() and returned to the page
allocator, it means the entire approach of using enetc_build_skb() is
questionable for XDP_PASS. To avoid that, one would need to elevate the
page refcount of all frags before calling bpf_prog_run_xdp() and drop it
after XDP_PASS.

There are other things that are missing in ENETC's handling of XDP_PASS,
like for example updating skb_shinfo(skb)->meta_len.

These are all handled correctly and cleanly in commit 539c1fba1ac7
("xdp: add generic xdp_build_skb_from_buff()"), added to net-next in
Dec 2024, and in addition might even be quicker that way. I have a very
strong preference towards backporting that commit for "stable", and that
is what is used to fix the handling bugs. It is way too messy to go
this deep into the guts of an sk_buff from the code of a device driver.

Fixes: d1b15102dd16 ("net: enetc: add support for XDP_DROP and XDP_PASS")
Reported-by: Vlatko Markovikj <vlatko.markovikj@etas.com>
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 26 +++++++++++---------
 1 file changed, 15 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 74721995cb1f..3ee52f4b1166 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1878,11 +1878,10 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 
 	while (likely(rx_frm_cnt < work_limit)) {
 		union enetc_rx_bd *rxbd, *orig_rxbd;
-		int orig_i, orig_cleaned_cnt;
 		struct xdp_buff xdp_buff;
 		struct sk_buff *skb;
+		int orig_i, err;
 		u32 bd_status;
-		int err;
 
 		rxbd = enetc_rxbd(rx_ring, i);
 		bd_status = le32_to_cpu(rxbd->r.lstatus);
@@ -1897,7 +1896,6 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			break;
 
 		orig_rxbd = rxbd;
-		orig_cleaned_cnt = cleaned_cnt;
 		orig_i = i;
 
 		enetc_build_xdp_buff(rx_ring, bd_status, &rxbd, &i,
@@ -1925,15 +1923,21 @@ static int enetc_clean_rx_ring_xdp(struct enetc_bdr *rx_ring,
 			rx_ring->stats.xdp_drops++;
 			break;
 		case XDP_PASS:
-			rxbd = orig_rxbd;
-			cleaned_cnt = orig_cleaned_cnt;
-			i = orig_i;
-
-			skb = enetc_build_skb(rx_ring, bd_status, &rxbd,
-					      &i, &cleaned_cnt,
-					      ENETC_RXB_DMA_SIZE_XDP);
-			if (unlikely(!skb))
+			skb = xdp_build_skb_from_buff(&xdp_buff);
+			/* Probably under memory pressure, stop NAPI */
+			if (unlikely(!skb)) {
+				enetc_xdp_drop(rx_ring, orig_i, i);
+				rx_ring->stats.xdp_drops++;
 				goto out;
+			}
+
+			enetc_get_offloads(rx_ring, orig_rxbd, skb);
+
+			/* These buffers are about to be owned by the stack.
+			 * Update our buffer cache (the rx_swbd array elements)
+			 * with their other page halves.
+			 */
+			enetc_bulk_flip_buff(rx_ring, orig_i, i);
 
 			napi_gro_receive(napi, skb);
 			break;
-- 
2.34.1



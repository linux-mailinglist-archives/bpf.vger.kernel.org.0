Return-Path: <bpf+bounces-57510-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CB02AAC3C8
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 14:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C5A21709DF
	for <lists+bpf@lfdr.de>; Tue,  6 May 2025 12:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 515D2280001;
	Tue,  6 May 2025 12:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="ZAEsb6nb";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="a1VdFqX/"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-002c1b01.pphosted.com (mx0b-002c1b01.pphosted.com [148.163.155.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0588927FD4A;
	Tue,  6 May 2025 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.155.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746534211; cv=fail; b=AHIn0Jza+Vp2eFj0gMkmBwoSM1/CfBUvkK7dFNpeVDche3PVquUTS+cwfPhKxZYAqjchlZ+rTDh/8o1rdaA794+MDS2iz5gdORujGZJsyDxLg72yS+OoimDKjwJZvglmXvr470LjVQU7bpE5EAdklkzgtq0xvnFiD129L8nLFP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746534211; c=relaxed/simple;
	bh=tA3CxjLcF/r0WlRnBFQ8Msh9uL9tTW8FJNYXeWwcfzE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=KUKXZUUo3XuR1ZkSjjXpDGhvX2SFOPPh2iXtyg261H+L5AQ61KAGi4EDtBzM4LQM3Mw3xU/ydxkglyAZcaNI9REbcreWflshP3wtzYI+w/kMNNSKW3BgS7UfagxttD2MxxFyk22XvoFka3gPNTrJcnCV9CPLyqcgERW5JOX8E54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=ZAEsb6nb; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=a1VdFqX/; arc=fail smtp.client-ip=148.163.155.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127841.ppops.net [127.0.0.1])
	by mx0b-002c1b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5469IG5Y027603;
	Tue, 6 May 2025 05:22:43 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=N+MUDinwS8rx0
	hZBpp4t6QTraOCxQ/uWVv5bnHHuQAs=; b=ZAEsb6nbMJzlEMSR2SNAarZ0nNb6b
	a98H7CfomdN3MPnjMlsSefj5SOUF78VGQzoh2hc5foMN2VxoGGTOoWLgYRJ0hQcC
	Y/o4aSVFAZj05NJaUrLkvKxj75zF4rdr2NJeSRfKvho4dS1G9RgU7xH0YlJMjaJh
	96ZoBNqx5VoUGsaYB8XTMN59gKS2N8lTgYGkSpD1jTrP0Ls0paOM6xnwu6OjAe5/
	yUa+fw/FqR15KVOt2K2pgy4lQ2fKu7qEc1+ssEtJn/GClDhYQ4q+8BlAsnbTE5kp
	lMEOUcF1MTMiGwv/IDHSZTSG2cdBLsRGhrA3vXjyU4ZV0+gn+vc4WdZQg==
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazlp17010000.outbound.protection.outlook.com [40.93.13.0])
	by mx0b-002c1b01.pphosted.com (PPS) with ESMTPS id 46dgp8x05e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 May 2025 05:22:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y1A1DECotOO72b0Ekj7rWci93iFKlnM/ctaKqXnbnW7Ri35DuEjInqpzMlHttrpYprQW6U6OprE33OLGjCf11EPPsxAFYLGZNGs5FRbXbN1XDF2djeDYw+ea0G+3GYp6xmHW/L+bx4/C34tylbqBtb4anGL2SkK0O2EoM4WQmi6jwZVUKRshnmzkajJlrFdzwau3h7eR3opSzcbhdXIq3imPl1OF3H9TfVnPlavBEFNO32X6UrWkP619wA5Wr+YUv0VEGu1Bx19uNG7PNtGK+vaT6MtvrzwsDNRTJ2mICdbBKJGGXmRC0ks/yRH1Ky1vx5JZb/Qi1Y7vkLnsvaWfrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N+MUDinwS8rx0hZBpp4t6QTraOCxQ/uWVv5bnHHuQAs=;
 b=WRDWKGIpsUV1YdzIqOzD/k9WMurDsvgWzLs8He9JX7TWKhqMnO5Dsg572yKFFnbeesufpDathCv3JFeFaeE6vwqCyCowdgt0wsc/4AareNKInmoW4sugSJ3CqF5TYQWvZc6MDHWvLl2IkmJqOXj9TQqDKLrqpr7IpLr5Qw0pwWB4z17x1ij6iqXb+hzllOrlGCdmDu2pBjDEaukv17z6F8Df9axHYJo0AbqH8gEukz9ncj+n8pnF/DSmWWkeNHrr78wqjD3+OU2T/ca1eYZziuHRMtr7eEWj+90MeCR/LqItvljj316MHTbDblzvsN34umwPiGOvV3MI1ZOn84eP4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N+MUDinwS8rx0hZBpp4t6QTraOCxQ/uWVv5bnHHuQAs=;
 b=a1VdFqX/Wvu85HtMeieAOa61it89xxL0zT5KSAdTONQemVsYvk9OZtspdXhADlfZhOgibOEc3pUCo6V0so6d/S+3UaKHRpW5ou6lz1v02ll6owZbCyLs4yQBA8KxpObAduWRFi48LKb7v30qRZ2aJ+9t9d9Gy3jSux7CXVveIDvSkK8qvH8kpI9v+4A/Bbtw8AhtLJl3WuBfy7P8ZSHo09crWXvOviOsbO+gGf7nx11pCXKVUe36yHYUlrRBY+dE56aZ7fhn1tKlsFSEGk15ZnkFrwqlSzT/HdoG7WFxMf8D4FE6IAEOfOiJec3PUnQ8/uVNXFGHJPYQbFGRc6macQ==
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10) by SA1PR02MB9867.namprd02.prod.outlook.com
 (2603:10b6:806:377::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.18; Tue, 6 May
 2025 12:22:39 +0000
Received: from LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054]) by LV8PR02MB10287.namprd02.prod.outlook.com
 ([fe80::b769:6234:fd94:5054%4]) with mapi id 15.20.8699.012; Tue, 6 May 2025
 12:22:38 +0000
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
Cc: Jon Kohler <jon@nutanix.com>, Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net-next v3] xdp: Add helpers for head length, headroom, and metadata length
Date: Tue,  6 May 2025 05:52:41 -0700
Message-ID: <20250506125242.2685182-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR05CA0078.namprd05.prod.outlook.com
 (2603:10b6:a03:e0::19) To LV8PR02MB10287.namprd02.prod.outlook.com
 (2603:10b6:408:1fa::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR02MB10287:EE_|SA1PR02MB9867:EE_
X-MS-Office365-Filtering-Correlation-Id: 40341655-f79c-44d5-cc5d-08dd8c98b0bb
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|7416014|52116014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pqcSFJpM6+m11X9hzrE1F5/XT4jjcSwfKuTLu91IbQ1/RDJTqZmgqZo2/C+c?=
 =?us-ascii?Q?KXdlfuJNJlLbolgxMlXD+bLY7kIQ+oSVSFXKg6ti15eilJqziRu17avgBqpQ?=
 =?us-ascii?Q?fPZhKPveqRaThcGTrNYrNydximoA0cogq4amK5pFvffKmhn4omxfs5bU/PuC?=
 =?us-ascii?Q?dt6GM0OF6GWtmRWV7lKTEi4Izc2Fs/5vk6PACYQI6MZGKvv0jKOMlVsBMOs4?=
 =?us-ascii?Q?+g+KlsXF+heGdH5/eL9jx3xw+yjzY0i34YHx8mkPom7Mgvau6gWf7xWIPRej?=
 =?us-ascii?Q?jopINEHsVVXnIZL9eoy4x7VSJPnxcPB3Xd+2b7iXSpPsXSkUeZB3S0Lqt/ZK?=
 =?us-ascii?Q?x6FMnnv1yuYjBio581BznOX6r/K32XqJki87oH2Ae9/asN1Hb5jreNtxFSUP?=
 =?us-ascii?Q?9txpAj1MOV+PeRlY0qQU5x7PxtpsxkGlWhH98TWUvC3PDZI4bAkpPH8wedL0?=
 =?us-ascii?Q?3BhzP3pkyewuS1sdXtfstc4olyv/oxzDYuSBrOu5Wbr10Sl9bLvR0+Ac9Q8h?=
 =?us-ascii?Q?LpJ3LM+F6bSA0fUWgxBP5ZH5sL7BrUfaKY/7efxXwGHLOCDvf1859vopDVAp?=
 =?us-ascii?Q?VSmKfx76VrttgoeR4FOmN+ShB/q+i7ty6SxvjFcwoQ3WERqDW+jtxIEMxbuq?=
 =?us-ascii?Q?xCRTxI5uMX0PWQLiUax85hyh6gwecTsM/VxOXFGfjppISTKwwqPxgcNX5NkV?=
 =?us-ascii?Q?Vl4Wm9jN2KszBOqAtKEdhX4qCW3Ca8SH6k6bszhnTZqvLo5AFKlOZJ0Cdu+b?=
 =?us-ascii?Q?A/sB0hhL8UyyKe0lgY7TBMoJfAg+/oIXukJ2/UrcedxpglbBAresvJ4Mkd65?=
 =?us-ascii?Q?Tps2USCdqz9Cysk4JHFJ/gvzpVfgZwLi/CXGT8HyRxvlGc+ku8TifcsJYlag?=
 =?us-ascii?Q?PH7QQ+l0jv1oyAVf2e7xK09UxXoQOmcbQ+LbfUHsOBp4Ai424CGJ/aajJMMp?=
 =?us-ascii?Q?L5/9gFOGEPjdaRyX0FK1Fk9hLqsx/P1bwm8uo00CyMyXICYCpVhu6ChTlNik?=
 =?us-ascii?Q?D2+f18O6bYfjPxXvhwBrGbu0RcgiI4mJzFWSgs3Mx4HQIOUOAPL6n4O155NG?=
 =?us-ascii?Q?iuMEucBXAKqOw0kfhE8H/GOiZJ3s3j0e+ZM96A/Z9Q8VT2oti39J4Dp1Bs5S?=
 =?us-ascii?Q?XiTVUy3d79JXfkNsDVl+bRAQQ3b4jr3XnipR07qkOVMzPsoH68i3VqPMwP0A?=
 =?us-ascii?Q?AJCbkIkO2sGmb9cEfCBrhr3wLNyZR0IxeVLHOzR3kP0sY26ZXgl+EDCTHili?=
 =?us-ascii?Q?FAEloH8eo3GhAbrUViSF9CeqiXOEXrE6zk1Ba2jLaT0y6phgs3UCKNF9D3x1?=
 =?us-ascii?Q?3i/TWIxSRURAhSChwT3G7HmgC4fS8Fd1M7OMqwGq8DSCu75yjIBk+a67HSKX?=
 =?us-ascii?Q?AlBYmjy78Oy/u1euzyA5PBc0SWbFwdMZtgFM7fnnUYz8rmJD4mK3N3riAacm?=
 =?us-ascii?Q?YQe1pqL7midBjG6Efa7yC8gNeAix7Sqyl+5BwO+BwEQtRN6nXjDnUB7Ea0fq?=
 =?us-ascii?Q?Se75gQv6NJTEzSU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR02MB10287.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7416014)(52116014)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8g8nSt0FZqQT/r7aDq1hrfKAjdJSbmueq/4c0J2al8JKhxWO7l1dfHASO9oF?=
 =?us-ascii?Q?w52HKmyuWQ7cawrFtMT/DOcUP4PVhhp++3zN5y1sHrY2zQWIWFKlAXe4mNN8?=
 =?us-ascii?Q?HCmfTnL17uqWDCEbc7hy7pyWiWrGT9UUDKyeAq1BcXB9xVO9hCX47SectucM?=
 =?us-ascii?Q?x4tE3gynWcvT11tq0F1k7BE6WPTa/gSMZb56pdXP4ztp4sd/3ObfaOOKi+qd?=
 =?us-ascii?Q?X6ZmlENcZ3DQIxgUhUMIbuyy6qRCW0+fkBtgAuKOZQFLzxxiidvwLKJmov47?=
 =?us-ascii?Q?74U9CbjrN2Q8T6GYBIXBRekf7dr3WtuEVbwIkfCWebIlnhniJhuXoJYhXxTL?=
 =?us-ascii?Q?32pJQgCMRABY20WcNilLribj9tbIQtvJqxaTSqKQOKkmSztrVzlAwDG3qLwu?=
 =?us-ascii?Q?7YOWeC5wJne0jttoTgVeJGlStIuIveBT3Td/sTE8Nx2Eb63ISvZY53pq7xew?=
 =?us-ascii?Q?aUgTqwYJmpJDE24lWYPFDOj0CQ5lSQVvMLzcdsoyb4T4CjnYJgFqWaahdzIp?=
 =?us-ascii?Q?do323N1PFYem74hlyaNFVnimodVjSvBesOg1K90+lXO+ggCvSHz/+RDdDf7S?=
 =?us-ascii?Q?7hck+pheYTu/YmIMhat3c5sxK7++BNBb17RetOu18Cb7Yo4GCSM9LZMeAJ3P?=
 =?us-ascii?Q?Ay/npogV09N7sMQf/mDeO3kE2A0cSbrOd0cMn5QChI3Su0WIolCupw3ra8oK?=
 =?us-ascii?Q?tQUkvHruDaoC0rteoOSHLNM873oDwnq3vXbGyMAbgpX0708XAGs0U+sNNKQZ?=
 =?us-ascii?Q?n6V9HZTJWwqg7kfehS+hosxdD3VRJyKK92IGoz86fgznSu+a+UrCYIWOSgco?=
 =?us-ascii?Q?I7NX5X27K+1wPNrt/bS8QHxs2e2arnYEkpcmzcwEjLLsPjMZZxLX9KgUPvgz?=
 =?us-ascii?Q?QlrEHCBYxlaz7APqsjArtFjqTfInol6Dma2gZ53LGq97CENmuF4z21+AmHZ5?=
 =?us-ascii?Q?nojHZQjonwJ3Pm52D+2QjmDUOlAxcUhgdy7jrAhTiUUnDnWafnd6ZEcxZWb1?=
 =?us-ascii?Q?+Ytm3sZfqAnhzKVZtjB4B/d2JdqnXdtuFdh5/uj681pbGXLAqVwzE5G6IHI+?=
 =?us-ascii?Q?Px5pzPOyAndQFM2WhFh6aH/a4+4V/usWq5efXh+UMJWdIqrefMpwN/kCJ3Oe?=
 =?us-ascii?Q?fEZRl3/crWrSLy/bVX0YKHWR5Qnbx0wfU7P8y+vLPRcVsulRoseA4ohs50WN?=
 =?us-ascii?Q?7fkQTqp6ZojUKu0+Ut3nz0KPrloueUT7YDYZR5e9AOMaWY+XoMxAbvplFAft?=
 =?us-ascii?Q?ihDLR/pmPiE36kUM2wqU4f+1rp60eIqVwhtYHIzIS5daHezUUYfh1fr2oYsZ?=
 =?us-ascii?Q?D8HljKnnMzN1ht9btTq+TVQ38+wPOB2W4DfWFMToPPKnRaQgiSQ6p4LqCJQW?=
 =?us-ascii?Q?JfdYWdzVjIbArUSRe9xM6Nk12EJhSrSk+WnX3wqoDhZo5WYbcPCan+07WJt+?=
 =?us-ascii?Q?KTGAio3NqZ3bX0D/KQoUDnPWZwIN6Qwihhy2EYIe8qbBNEuI0345OmmF9uZ7?=
 =?us-ascii?Q?Vx3cdlvmO30SPQ1Ie9oYvlihLvdqTIPjM4kH0SaKbc5oTNLoOO6iBT1uHB7e?=
 =?us-ascii?Q?XvBfqNWVVrbti3F4GhxhSTyeSlJCLAmJC8P7UCUerEx+cA2eD7KqCN6lIt1h?=
 =?us-ascii?Q?ww=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40341655-f79c-44d5-cc5d-08dd8c98b0bb
X-MS-Exchange-CrossTenant-AuthSource: LV8PR02MB10287.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2025 12:22:38.8377
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qZpjnrilgkpOZoSsMPhfUTcLOXbKNY7sZrMCWIF/CyWjShEL/jXUf+KCUXwx2tHSyCRc7NXfF1jPdI+yH/QPhn/SWyS1uAj+gscC2ec0hw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR02MB9867
X-Authority-Analysis: v=2.4 cv=R6cDGcRX c=1 sm=1 tr=0 ts=6819ff13 cx=c_pps a=TrQpY+9r/vRMYizkUk6pNg==:117 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=dt9VzEwgFbYA:10
 a=0kUYKlekyDsA:10 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8 a=QyXUC8HyAAAA:8 a=51KnYewcZuRi7D_KieYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA2MDExOSBTYWx0ZWRfX0omoxwm3Fszi uITA1vQducEq1N0bomSEtmYuaaJS4dnWZa6wGO817owxEIsVO+cPTdgtUfoi6oIx9T46EYWJgYF wgTZzM0CKWP64BqEsSdWu8yE2w9p9rDZhxrAbpqEzVJdtlQvGC5KX1ijFpXWH+xBevWmm043QUd
 RIGAXif0/8s1ERjKazdQ9ixKgadP0AK0mafclNdRqXihMZNJFJBYCn0Gdv8qEV8XklFxXKLOtH3 PDQ6RJocA6saqP16XWGV5xurQHize7oS3VyehImug0yrvGb9f8LC9VpO9h8vQMBVxhB6U5LVS7C +Y70CiZFwxmlBmHe6DzMKS+z7PyqiR7cMBklzHwsouGaYdhHdklASD3a5JnUwQb2jOYSjXCJKS3
 FvbnpAofZlliYZozrzFK7vgX4W4YsBvU9V/1BSuW4XQK7LRv037zhk21I8AQvNCtIMEvVfPY
X-Proofpoint-ORIG-GUID: HA8qWJY9VWFYhUTancEY81EtAPE8vm2O
X-Proofpoint-GUID: HA8qWJY9VWFYhUTancEY81EtAPE8vm2O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-06_05,2025-05-05_01,2025-02-21_01
X-Proofpoint-Spam-Reason: safe

Introduce new XDP helpers:
- xdp_headlen: Similar to skb_headlen
- xdp_headroom: Similar to skb_headroom
- xdp_metadata_len: Similar to skb_metadata_len

Integrate these helpers into tap, tun, and XDP implementation to start.

No functional changes introduced.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Jon Kohler <jon@nutanix.com>
---
v2->v3: Integrate feedback from Stanislav
https://patchwork.kernel.org/project/netdevbpf/patch/20250430201120.1794658-1-jon@nutanix.com/
v1->v2: Integrate feedback from Willem
https://patchwork.kernel.org/project/netdevbpf/patch/20250430182921.1704021-1-jon@nutanix.com/

 drivers/net/tap.c |  6 +++---
 drivers/net/tun.c | 12 +++++------
 include/net/xdp.h | 55 +++++++++++++++++++++++++++++++++++++++++++----
 net/core/xdp.c    | 12 +++++------
 4 files changed, 66 insertions(+), 19 deletions(-)

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
index 48efacbaa35d..04c187680f3e 100644
--- a/include/net/xdp.h
+++ b/include/net/xdp.h
@@ -151,10 +151,57 @@ xdp_get_shared_info_from_buff(const struct xdp_buff *xdp)
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
+ * Analogous to skb_metadata_len(), though using signed int as value
+ * is allowed to be negative.
+ *
+ * Return: The length of the metadata in bytes.
+ */
+static inline int xdp_metadata_len(const struct xdp_buff *xdp)
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
@@ -364,8 +411,8 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
 	int metasize, headroom;
 
 	/* Assure headroom is available for storing info */
-	headroom = xdp->data - xdp->data_hard_start;
-	metasize = xdp->data - xdp->data_meta;
+	headroom = xdp_headroom(xdp);
+	metasize = xdp_metadata_len(xdp);
 	metasize = metasize > 0 ? metasize : 0;
 	if (unlikely((headroom - metasize) < sizeof(*xdp_frame)))
 		return -ENOSPC;
@@ -377,7 +424,7 @@ int xdp_update_frame_from_buff(const struct xdp_buff *xdp,
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



Return-Path: <bpf+bounces-76445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38AEFCB481D
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 03:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9563C30011B8
	for <lists+bpf@lfdr.de>; Thu, 11 Dec 2025 02:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7780C29A30A;
	Thu, 11 Dec 2025 02:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="E4sIzcfr"
X-Original-To: bpf@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013045.outbound.protection.outlook.com [40.107.159.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F205F21578F;
	Thu, 11 Dec 2025 02:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765418909; cv=fail; b=UiTRN3rQ9c4ScjSDxbqIPDpE8zXfSMsE4ITQ2uEYlv8zswUr3dFhs++4ovoIuf1Ss2Ua5JdcRg6OmpVpWbldU6BHnAxVMIcP2BG7QxyrCHM7XOmvuTP0/m4Vq7PxWLkx9+APEDSoqyrkM6x7Y5Umwb/ipzT2oV/7gsHgKglwEFg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765418909; c=relaxed/simple;
	bh=MVSK+TK17vn4e5tIexLG+WhW5E7RnoeuHXCC6kotSS0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Z3UkC1IHfvaq+U7KJXjz4kfpm3WuWf8hglDtbvl9ZJktHXdRfIlYPHXSOHDD1hDaKFqg9immCKCjm99Optzqlpzae7EIROphEh9bUS88d2q2gm8nzXWZcRexgpIeqLbAgD/uuowquV1cmQpwSDay+V6ObPoUTsY6H9oVRbc8hGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=E4sIzcfr; arc=fail smtp.client-ip=40.107.159.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NgAIrzwWMz3pwMlagQBtboR1sTpoxjL2hAFQrQeMpiIvNw/wmXRy6jc9BtLVi67KUXm8gHA0cird0S8of7u6y+vskTFLfAX8XHlDkn0xogY6XGZL5KuP51Nc2gGwXSSjhsvwQPteNrMQYLWzRViKtgVyEQnMFCv1oK3aR0k4ri1SUnNKP+a4EeFPgDUexa5NH4Sagj9yR6ZDt7+m73P7DWm+pg4Ees+/vC90Tgy6z4RekBIzpR412n09OSooxP4MQgpBfWBs11OZkoWuZmWRTpi1CDy6pECM4tEXNLLg1afrL4ByvSGue570WVftZ6ozwS7YnY7SQqBKuwR0BcJz1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MV91/ZCMEVRxqc9y7B3XCTASEUjE0d53P/wLnhZksBQ=;
 b=MZ9gIihthd62+MqT80I/nsaotPu5MK1CgyMG4hfJv2tBVAmXWnJDESF0ydh1E1t6Jt/0IVSGJKc8wY5nBeLBNw9RnEaP4Hg/tIRrCN1fu2QrPDEJn3+yP9P+XrD+1jbEa6dJrUJLLpFFfdhxQ3c2aOrJuYOYdp+jwpjWZqFa7nhpksblGIimVAlPZGz/ToIzIqzTpFSgbtJQUwl4mk9MYx8MR81UPG+XTGwPLySpefOIyLfxcV+JM/mhFq77acf1tPeMDSdcP9upnkMCATtLn7RO4n0GGaxdaFl5ai8edHUZbT4j+wpfXsG20MpNnQzBAdeeKocDS5TLHG3quLFNLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MV91/ZCMEVRxqc9y7B3XCTASEUjE0d53P/wLnhZksBQ=;
 b=E4sIzcfrW6QCAkPGxCI97arT2AUylu0xq2g3cOhahZxLWVp0wfFx47r2C78WWEtRsdwe1S8Xcr/ifcJGFU8QL42LV0FhSJVEIvuEqgDEYZcQUtmznKHnSI6Js8IFtJmiZ6J+dMiwAbaqC0Mvs3blQQYRIRjI2ZO8KqUyfvZprmnd3r84nW6g1rtIygp7LaHwODWZYNK6hVaHEax+aECnqGSsIgUEi1R3a03XIAzyq5ycXDUbDS6Q3qmU1F6JuMMexbmVAU2p0LMiiTetROhzH8jCX6E42UG11Rd/78oTY5PETDHKey0n+7+v1OwMagSClq4C9/Q5U6y0pZWuhCyYFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB9950.eurprd04.prod.outlook.com (2603:10a6:150:11a::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Thu, 11 Dec
 2025 02:08:23 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9412.005; Thu, 11 Dec 2025
 02:08:23 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	frank.li@nxp.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH v3 net] net: enetc: do not transmit redirected XDP frames when the link is down
Date: Thu, 11 Dec 2025 10:09:19 +0800
Message-Id: <20251211020919.121113-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0036.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::11) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|GVXPR04MB9950:EE_
X-MS-Office365-Filtering-Correlation-Id: a91b540a-42ac-47ee-08d7-08de385a29c8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|376014|7416014|52116014|1800799024|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?98XkxCtdrtbJ0Vkm4RB8vCMIYOYIj1y9O/3CATCYpRMFjer8XLE9LwNSwgl1?=
 =?us-ascii?Q?u3RNsuBkIJ6fQlNJaTY3zgXZppOWiUfWFOIVyqQGbRnUePeP+G+QkKcztMxN?=
 =?us-ascii?Q?HkqOcEszYybgGvoWoSKrLb+hWN9cCMY6bMZR9RVihtu09wGfwLpbB5r7H3U/?=
 =?us-ascii?Q?4hOrtBo2EsPuQu/pNBr4yYIeqVp4gRlhWuwW580vbU/jcb35ATnfKFv415YX?=
 =?us-ascii?Q?7SmWn/gZAa3Av35PGxu32VAgRT1vnNCrEuVplCOGnlPQUID4wfB6v2FqV5JT?=
 =?us-ascii?Q?1UYP/tpuW1uDw3C//FxGhttXL1OnymlHzetxtcemXZ0VJ0U3MSDFNHk+fYOa?=
 =?us-ascii?Q?p4LN4ChAItdeg0F5fRj9C54DaMdSEieiAohUJgkmUrkQj4av1ZfizNgLifgp?=
 =?us-ascii?Q?2Br/G5AzNuBafZ46fnF4UYwP1iSltPyIBhDClHNMJbpYP5+oCjM4PglB7L4L?=
 =?us-ascii?Q?ToYUZxbjTeYIkKWB6ZpGCUX8aB2ZmexRHY0TPog2wYjwN2mu/16kHw7Ghngw?=
 =?us-ascii?Q?R0J17nG3eycKKLovaVdXHmVAB+NXZD0Dzk+6v3wg3JeioqWlDNsXpFyeIK0t?=
 =?us-ascii?Q?qskXuBBCaYfbKwicOqfaP/EJDI5ggxpaKkRv/aIr6Gjof+a/uJNAE8F8TRJ+?=
 =?us-ascii?Q?78izucB+mtq5hUM/oDygLDqKvHRJLEvhZkqFwyEhgE6d0E4OYrdS18oQlRPX?=
 =?us-ascii?Q?SsdkotZNzq/WPDMq7PPQvHtZdasyahJqzlN4Ip8sMa+LbZyBIHPyWtImT/U7?=
 =?us-ascii?Q?0efT1LDLMuGorhwR/cyKqTHXUNaaYg56Kj0BHCYlporCvc+ZSsTvT7lhpcsX?=
 =?us-ascii?Q?iv8BJfdFGLsBenWnAkKZs8YItHXdKCwYjLYSqysJ22YuJ3rqbFXZFxkIuNV3?=
 =?us-ascii?Q?ouf/nksxoZntUp6Slk46PIbK4k0PQz4vsfwoxF6WjGWcx4Xo+FAV09I+OSj1?=
 =?us-ascii?Q?LlW/8CRfKXtBVGApJ4aPioSG97snDtbcDtUf/L1YgWmEBG+jMjgZl+UG23e3?=
 =?us-ascii?Q?ZvdJ9fDvHPpPhk51zP6crn/WI0F/vDFqSpjO13S7LdC4fZ2l7PIqLN/mNhyH?=
 =?us-ascii?Q?5KOzOcNplQkcjHZiFQb/R0TOkv4rWR+iZnqBAi+KtEtyGA9+YrWDmSAxNYgL?=
 =?us-ascii?Q?1LNZtsIiWF6sSScK8UWy8TSdkPKls2aFBf9jzQQ49ENA5JJ8XhgXbXjnrsOF?=
 =?us-ascii?Q?WH5p/a5ZjyWgXDbBnPBWY/ry3Ao4eJYi76r1ZE1ZyuQEMRL+arZChiHZ5AZh?=
 =?us-ascii?Q?e6JJqDBODaOCty4WEMUUkRy7Kv5p4aSsmPZrTB6Zq4qs5GqLlWykXiKw24lc?=
 =?us-ascii?Q?hytitBOcBVzHpuwOZkaAj8a3wSQBE+SYX+EoAlDqTkx1tB9MHnUFywnwU2SW?=
 =?us-ascii?Q?GdWI8f8iiWIAYv317zHqIrtdDMBNCO1t4ygUF86xlPF0jGAaVAqBpBeT/AHR?=
 =?us-ascii?Q?f+EnDLVbINMpXddYh9OLdd8bFov6DAtOmYcqMfQTgrUaq+opkCYRIPcIVSAI?=
 =?us-ascii?Q?DFBR0xmQCfFukQS1L+5KZ+TabNgR5097aFqQgOmBLPA1ey7dsfaeLxtqbOHf?=
 =?us-ascii?Q?rYPMz4V28RNB4PtNIC4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(52116014)(1800799024)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BQoxkh0IeUUWfGxTUIms89zYQTzlUcuypNPbArC+GhpN6EeYdvSn9yaifGE8?=
 =?us-ascii?Q?mSL139TlnlI0Sl/BcGQ2q6JM4r6M06v3po2fOCLgQupmws3XBgfYxT7kW8vc?=
 =?us-ascii?Q?SZ1KZC3l84QcrVWU83n+drOKHAyZl04Z+irnlAPjGuk5fqIaPIT7HIbd4tMv?=
 =?us-ascii?Q?MiZXYXk4UYXqkwpNM1H9Hrp8JCYiIQieEXdQb5IiOIw28F1J8V7HANWM/Qcv?=
 =?us-ascii?Q?KenKqxD0m8WrsvkH+dTh/UFb5bKNCzYcUk6VfeWjkn2fiy+RLPA5YBr74ZhD?=
 =?us-ascii?Q?N3XcjtfA46O6ACWGQnHxaXZcBrj1Q7nanpoJdApNqaDJI/pp293lp6Ta2k5g?=
 =?us-ascii?Q?wrLEmEsELx9Z/rFPoT5YEmIOcFnAb2CssnjPPbzngZPtHu4SMdIF2cQbqxS8?=
 =?us-ascii?Q?vzUj4Gt/jCiel6rbuMTCQMYpCtS5b/5uEIv5hfNAv0qXJnfra/Y6wgUmxJB5?=
 =?us-ascii?Q?+Ltv5MsjaJndQTpII4masIXwMjTCZS6wj7Gs++J04XxtJhSJtugOcP35ZGcY?=
 =?us-ascii?Q?DWqVrHnHywR9yqXygSxLZbc8sO9vLfYsAQhbHHX/l0SRjGzQEqShXhkLST3L?=
 =?us-ascii?Q?/3jzDSU2bOHFLnI4xdPrD0AEHjHn+9Hs4jOU33WdyzMcWRukRgB8+UtM1Ea5?=
 =?us-ascii?Q?zwtxygtibnkCs+V3z0ooGcmIllG6CC0l4+ZnBzUJ0HrWWi//f9aIsd7njlR4?=
 =?us-ascii?Q?eRyOyY1KBZ48QldMXYhGH0ted0QiBUWIUyqsw0iAUxxSsDXnbW10ncvyydw4?=
 =?us-ascii?Q?3Sel5wgSocac7gbBEFiyisn4Od5roaV6Dm+A+hkwI2rvjGCEQyjzUWMpl+Cb?=
 =?us-ascii?Q?J/3lHFv7l/u5Ti/7d82M7MHZV0BbuZHqOLt8Zy8EoFomqMWeDW0+kJC+V59I?=
 =?us-ascii?Q?GZ3tDWN/vrueygMZ15XRizQeEwAMaKo8e783bRpN/GsA6AJeTfF60A0wuvIA?=
 =?us-ascii?Q?ROOCDJXZRIBqpQrjGLlFCewKlIUPzYyagaZzwO6sV3H2zw3zv21Htk4xKDyq?=
 =?us-ascii?Q?YCpYvx9cnkp4gOcJdemq8Wm0tzF0RwcI4wE97rGFeAsJkBmxSu/5N1Jgj/of?=
 =?us-ascii?Q?Hlkk2SrmfQmgB6Xhry5392L7uLd5CmHA+OgKnPSN67kdsjr9FxFukP+iCLDd?=
 =?us-ascii?Q?5KXx4eKOQK6t4wdSB710rJLnxeBRL2wdzLUroPt4WbIjgytRHl25Sr2wgmU2?=
 =?us-ascii?Q?TwCjtyy7QOsLycxv/wdSvi8L3qk9TZYi8rykqmxsMD34IyXSkhRtForAfPJa?=
 =?us-ascii?Q?r3T3jhG1fhwYDtAx96MKT8sMS0VigFVUKa6NN5J4XxkR1Z+VNZOB7a5uR83h?=
 =?us-ascii?Q?A8UleE993AXvmVWbtLiyx7lTtwjP4AGwbNGTfkDBkV4+qDjKGMcUs2iKCEjB?=
 =?us-ascii?Q?yKzPjuvwdP8rki+dYOzGHUUYhhRoh1SwrxBuN2mSlcM3ohMZ7LghKn4L5WSA?=
 =?us-ascii?Q?nEYMvZIfSqhb4NF6iSQPDvj3607JVv6Ef3DqYAjty1UBkPpKi8pF+y0Nn20s?=
 =?us-ascii?Q?bmCdJFZcOd2odEJhWc6VHL6QLZuskIKMEE0Sln641qiyrFsfn39ocC75Syl7?=
 =?us-ascii?Q?D5aVw/4DR+Z0XW5GR/vZcScLdl7qU+YoSjFfTC5o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a91b540a-42ac-47ee-08d7-08de385a29c8
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Dec 2025 02:08:23.4660
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5rP7BvwCnRXUussn7wvtrNk9di2+RkRnNAEla/gtpPnmHSVIz6pexXht7bdgIC05166TcWbgUN5kgbkpgHddeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9950

In the current implementation, the enetc_xdp_xmit() always transmits
redirected XDP frames even if the link is down, but the frames cannot
be transmitted from TX BD rings when the link is down, so the frames
are still kept in the TX BD rings. If the XDP program is uninstalled,
users will see the following warning logs.

fsl_enetc 0000:00:00.0 eno0: timeout for tx ring #6 clear

More worse, the TX BD ring cannot work properly anymore, because the
HW PIR and CIR are not equal after the re-initialization of the TX
BD ring. At this point, the BDs between CIR and PIR are invalid,
which will cause a hardware malfunction.

Another reason is that there is internal context in the ring prefetch
logic that will retain the state from the first incarnation of the ring
and continue prefetching from the stale location when we re-initialize
the ring. The internal context is only reset by an FLR. That is to say,
for LS1028A ENETC, software cannot set the HW CIR and PIR when
initializing the TX BD ring.

It does not make sense to transmit redirected XDP frames when the link is
down. Add a link status check to prevent transmission in this condition.
This fixes part of the issue, but more complex cases remain. For example,
the TX BD ring may still contain unsent frames when the link goes down.
Those situations require additional patches, which will build on this
one.

Fixes: 9d2b68cc108d ("net: enetc: add support for XDP_REDIRECT")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v3 changes:
1. Improve the commit message
2. Collect Reviewed-by tag
v2: https://lore.kernel.org/imx/20251209135445.3443732-1-wei.fang@nxp.com/
v2 changes:
Improve the commit message
v1: https://lore.kernel.org/imx/20251205105307.2756994-1-wei.fang@nxp.com/
---
 drivers/net/ethernet/freescale/enetc/enetc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc.c b/drivers/net/ethernet/freescale/enetc/enetc.c
index 0535e92404e3..f410c245ea91 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc.c
@@ -1778,7 +1778,8 @@ int enetc_xdp_xmit(struct net_device *ndev, int num_frames,
 	int xdp_tx_bd_cnt, i, k;
 	int xdp_tx_frm_cnt = 0;
 
-	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags)))
+	if (unlikely(test_bit(ENETC_TX_DOWN, &priv->flags) ||
+		     !netif_carrier_ok(ndev)))
 		return -ENETDOWN;
 
 	enetc_lock_mdio();
-- 
2.34.1



Return-Path: <bpf+bounces-75490-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 26C0EC86C3F
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 20:19:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A2C344E9B5C
	for <lists+bpf@lfdr.de>; Tue, 25 Nov 2025 19:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82176333744;
	Tue, 25 Nov 2025 19:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="DWaVO3va";
	dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b="S1rBgVFe"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-002c1b01.pphosted.com (mx0a-002c1b01.pphosted.com [148.163.151.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D89533374A;
	Tue, 25 Nov 2025 19:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=148.163.151.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764098332; cv=fail; b=oo1enzyU3/Qdp1XGvrjgeH/dy/OrxEK2P0Qiq5qUPDa7al2WTkIJgFq7n+QXAYe2uoL4euOM6v1WhdIzlanIeB1m5tbSH29oV6cM8P8XnfAJBrA1ehpBb6BlMqaDOkWe3W7XljIW4p8pXxVobf5KRKJAs2OMIrXzXQ1ub5qfwq0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764098332; c=relaxed/simple;
	bh=bJ6zh6F1860Vb6iJ1hWdJ7sBOoVC7YzRxhe5FAxCyKc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BgwawjsFVwWWsNK9NU6+KzLB7yTP16I/tWguYyRKh+Jw8WM2laXxZm8ylmMaMTYs4k7H+WROTDTn7RaSrtIjpLCeQZc8UcluV4q+LoOqi61CfnDjWWuNvQ3tdVKGvsq4QriDtMTAIIs4b/svujVYETdF5WsnTFtaqj+DgtR3ShY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com; spf=pass smtp.mailfrom=nutanix.com; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=DWaVO3va; dkim=pass (2048-bit key) header.d=nutanix.com header.i=@nutanix.com header.b=S1rBgVFe; arc=fail smtp.client-ip=148.163.151.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nutanix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nutanix.com
Received: from pps.filterd (m0127837.ppops.net [127.0.0.1])
	by mx0a-002c1b01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5APGKoNh2184171;
	Tue, 25 Nov 2025 11:18:27 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=proofpoint20171006; bh=BROV6D/vhWf5y
	QFm0vzJV3BgV5P4HxPx6ZjO6AvWBxs=; b=DWaVO3vaIj+uK39pfZjc/TrkHUP+f
	U6jdQ//twnUFeHU3F2UgVi6bSkObYlbZfNkk4nM8O4ide3mLbdkpBQvKLXyhCfkb
	sd1cm+AHW/rN9DAPJJe1M72aYT17c9DHVkhf1ClDYTYa4vxhYyvtejsH9TRjK4NE
	r90AynobCwjEchOToZwa1uaAXrch+VGOUi8W+UsJkv0Bx5wHDwwSaKKlkrImgkWH
	QLU5wvFKvowQtP6iYlH702Nbv/VDgbBPqHqPCKFP3hobsM3qev5seGbgZLDFWTtS
	Zmw79k8N67XDxPueEED1exj3kaYBWsCV3HzlkX/npnPili3LTG/mcr8Pw==
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11022110.outbound.protection.outlook.com [40.107.200.110])
	by mx0a-002c1b01.pphosted.com (PPS) with ESMTPS id 4anfw40cv0-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 25 Nov 2025 11:18:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aIAxAj1zP9jMLGPS+zqegOvxe62Tpt+Qcc9Sjp06c8XxXtFzWlvdyIbV7dIK+by/aUmtmak80+rgcVEnnQE/dWfqFSmjeNu/xZ5ZoFqZGNII189jlJHWS23kMTU3wqT/ttsMKzsd4XmLTfKRvIqqG1XYFVhZkd9iz/Q0+05fil9SAmKX1vr4vLmy7sgOwDmzaKE+Fce3fvm5iJLf839SkFt5Tv3UJ3SpGO6L5DsvytuEqaL0o7DcSv3wYu4z1MQ796X8sPrz1bAgmfARBMRUxNcIt1fWb7bBblm5anKzwG/hor2ua5TjLhXRrz5kNwWN1JOvRWAhtOpNhb8NvGLwcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BROV6D/vhWf5yQFm0vzJV3BgV5P4HxPx6ZjO6AvWBxs=;
 b=bpL825mFX/R4Jeg+IryQqyengjGiISQkWQLb7M6gfx491GURDko334WuapSHeg7CmpQPI0oBjCVSca4OKXUYisynFbHovGo/3TUC1dqAOQqmpe7F+0yPszBTGV1Fr7NotYEsS6R5nJwQw3U3I6OKyL18J+o+Ec3SM62qbp3q0gJc07vxlihAEID+kVc8wramtjRiDKvzBm1IeBEavolWOQ5HRgIGrYgd+cC5rOLrxAS72xAYFPOoXsJAiOswJA5ZSzM1TPmNNQDV9PgNMSRDr/NNQNe5XkhLgH1wb96LHXMPlUHeoFwvosG6PwxXDnogLpXAyr0cJ40XfwFvVduKAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nutanix.com; dmarc=pass action=none header.from=nutanix.com;
 dkim=pass header.d=nutanix.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nutanix.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BROV6D/vhWf5yQFm0vzJV3BgV5P4HxPx6ZjO6AvWBxs=;
 b=S1rBgVFeOpIrc15buIokJ7AVUA2AP30n4HPFcU9AYLp7u4SduLv8IlUsOr5M9COB7KZ8d4MC+o9EqaE5O8IAUhRHpTtn261nL1C+PUBWq2NMwTah/i1PPHxXFjiH2Pspy3RYGZR8C45MnQhdSkzm44zRTMlu2WVhUMgEuhHhAKbH8v96BI20EePQkE92IELvXjJD/CJPySP8WlHNYadLJj+Q6nbQMK+Dcir+epzuVMwScfrDa0IINP41OY9gG5a6j/koCadYupMc7ARADkkMBfuKvG/RPNufWyuDsTUdBSBbjUGXvHyrCaaFkVuCQhUf+pQu6LPY4L8Dm+j0PI2aXw==
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18) by PH0PR02MB7557.namprd02.prod.outlook.com
 (2603:10b6:510:54::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Tue, 25 Nov
 2025 19:18:24 +0000
Received: from LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc]) by LV0PR02MB11133.namprd02.prod.outlook.com
 ([fe80::10e5:8031:1b1b:b2dc%4]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 19:18:24 +0000
From: Jon Kohler <jon@nutanix.com>
To: netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Stanislav Fomichev <sdf@fomichev.me>,
        bpf@vger.kernel.org (open list:XDP (eXpress Data Path):Keyword:(?:\b|_)xdp(?:\b|_))
Cc: Jon Kohler <jon@nutanix.com>
Subject: [PATCH net-next v2 0/9] tun: optimize SKB allocation with NAPI cache
Date: Tue, 25 Nov 2025 13:00:27 -0700
Message-ID: <20251125200041.1565663-1-jon@nutanix.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: PH7P220CA0128.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:327::15) To LV0PR02MB11133.namprd02.prod.outlook.com
 (2603:10b6:408:333::18)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV0PR02MB11133:EE_|PH0PR02MB7557:EE_
X-MS-Office365-Filtering-Correlation-Id: c362f32a-6d10-41fc-0f36-08de2c5767b6
x-proofpoint-crosstenant: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|52116014|376014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8DRQVwW6V9kFpyxgRzM+xQOtsxzNtEbXBZuDyCz5qBH1uwHDGhV2pz5ruajo?=
 =?us-ascii?Q?wfap2I2gj2xjWcf1sodwt3oPmBlpwP9aPMipCYDo+pguDIig11A29wQUClk5?=
 =?us-ascii?Q?TXMLLgX9aIAlb5guaZqN84+V/lWVJwctdN4tjxFoTLUwfqs9d+7UXjbh+Ffg?=
 =?us-ascii?Q?G8zadfSgvvd1WUChnVy5lpsX8u0pBPqdRr2X39JWkYpnVJr/pF1pXOcUvkX+?=
 =?us-ascii?Q?BLUPJmMxGy3QJ0HLDwAKl26oi5LqcY2jOykz6yVgpKl9BClxqlXkJDW/nc/j?=
 =?us-ascii?Q?0oL5dWZ/skdKmiz45SoMNpJa0etR8O3CZW526LCuMhi1RiMgRW33UPpZqfp3?=
 =?us-ascii?Q?Jzb9K/yWu7HviYq6eyXhggcJ5YfSsrW0ycnu6pnRkp0YvZbTLjSpawCZ4bW6?=
 =?us-ascii?Q?YF4RzW3GJiDU44j/UU0KMdQrDv/Jbov8ereevndf/g5aKSULrgyJUXUII1/L?=
 =?us-ascii?Q?3C5obLYUA98LwrnPYnMxqEzwj9kaJALSqyG+X1N+wjimEvpsPYRnDV7zaALz?=
 =?us-ascii?Q?LsBtTkRwJdBy+WCXP6E3yw0AtqkhJ8d6iEVmBugcroVNiii1aIuPluVVpin3?=
 =?us-ascii?Q?YYhn08AIM9Yb9VxrOOUOONlIPJDVYHl9WZ9UdLalFTJSukOtBed0WFDQk8uH?=
 =?us-ascii?Q?eORgwZ68154oBSkrD00qTmAzMI/ac8jLgSRMpJCFfRy8s2FYSD5zcmqJmy12?=
 =?us-ascii?Q?PWd4e85638NLK/03lJJrUEo3RUhs9eY4uO8vL2zYMBDsdGCAZ+Imzmvrxj/r?=
 =?us-ascii?Q?cuSkpeWc8CnKwAXx4W1ABYN/k/HgMrTC4++TTCktXaUHShcahbh8QxcCbhKp?=
 =?us-ascii?Q?AlTh/0Vs/ehw7ETHOxkpHxP+11+2E+D2RdHlFLotvVqrk9d0lBDF/2xdWiND?=
 =?us-ascii?Q?yeCYjZ0KXM74RlmasrzhKTrhL9EKSSA3PCYjlayxdsvZUqjc4HjBypfSc+DE?=
 =?us-ascii?Q?vj7No/hYSPmU4Ae6o/lrFxDrmgPjNhrJSartCv65QQozAcsOru8Z3TBJTgka?=
 =?us-ascii?Q?DFZ7IeQi7QafeENkhL2bK4khIzt0GEtQaTOUf/WocijmDf06d99pXykKB1g4?=
 =?us-ascii?Q?cN0gYBtOEHWS5qoIzv+YBtBLMSbROVkBENVq7qsRbP+QXovspilooLzdAzkJ?=
 =?us-ascii?Q?gTXF2YLJcE4HFx04JcMRmL7pMzuuGoNfFm3ua3OTAsPOSqydWPxSpjQx724L?=
 =?us-ascii?Q?Hvd1U0IUjkkgaBt0ztNoYuTom4AK3mPSWeK/lz8Cc49ohLc8eaePGEcSmypy?=
 =?us-ascii?Q?j1+jjuCWa4oinR3YptwI+iHwGKPI3QVW5jD+AKbxSH/2VUFz0r9oLeLNT+kp?=
 =?us-ascii?Q?06yCyp2PfPUQXlk34xsZ/ymMnlMtRlV8pfJ1UYCuHAoGdkwB5+Oa7m3zDQFq?=
 =?us-ascii?Q?Aib9tbWVeO22/gzFZmAhJMkQSBefOYeTdBcixfh3cKiq7kGFs8sZ23RyM4rX?=
 =?us-ascii?Q?7MPVsus36lPRFLhe1vT8wFSvrHiVevk/Zc6IrhT/rompXw14mXtVNDelJNxO?=
 =?us-ascii?Q?jNpo5PZ9QD50hVw7ujJL+dc+fqtq+d5zTCEa?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV0PR02MB11133.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hHmLOMGIac1xPPWgxadbtqouYvG5ATryFco4VdFcIpWeebQpRenGlvY0hJE6?=
 =?us-ascii?Q?Pi8+4m0nUzsnGIZnNLXDtzgkIgI8uMvo+HjE7td4yqXC5abvDWB5dd+WuYhK?=
 =?us-ascii?Q?6uwkpiMf0ivQps3s3/7OCtDTV8xm4DwfKxrIl5eoQUU4LGODwfukSeiX75tz?=
 =?us-ascii?Q?2XI4/C1UVkJmV12USCJ04Q6i3uC1lQxdsSgc0/VJnmHhMCNqFHZGkwhdgmHN?=
 =?us-ascii?Q?8ETzdBhTRQ9rYfIT+4AzOXxgEQLE2liq+gs50k0npZSbWns6In0VtbcqUkIe?=
 =?us-ascii?Q?sNYu+Zk+g3P+Vt04FBuqQmTtqqjfwgvbDgWHrcs1xm21eVemXtikjO4PocCv?=
 =?us-ascii?Q?Et9NisgpJ0mRGbkduttlqUOXMIzqCzZk+/gMLOF4TRfN8LSSIr7M0Blp+xK6?=
 =?us-ascii?Q?b8nt3u3CEjRIrSuNZWCw0kg3uzCgSmT2ogzm23I05wa8anBeFWzZ+T8PN92w?=
 =?us-ascii?Q?LAwNQM1FL4U6UZz7bJgz+C4aUe7daTXbxcGxQtIZryDkn0cPSDBhJR7XOyAV?=
 =?us-ascii?Q?mfiwqBCBwGjpiDYRC7vx2dXtk+NAL89zG0BJz8Sq48Cy2GsT4t8rSI0znvFn?=
 =?us-ascii?Q?DeCciavVymXyWkZsmKAh1ctCIC8/76gMsET0ZVyGkSNekJxrJF3s01KU3qx5?=
 =?us-ascii?Q?B62BFxdI9xk6ijA0HiZPlE4PfHSG179IXUAjbwpGilrDDT5YR4uFhZpGpXQ3?=
 =?us-ascii?Q?VhNSckO1ysxunmsihVuPOI7uiR2tckutp7I3sljIipsL+R1NNtssOacfrqRO?=
 =?us-ascii?Q?JE7Fl48dpiExR2OXlOz7o9eOyLq00diPg0AjgcBWfTPJxO4OidfOHBi44Lxm?=
 =?us-ascii?Q?grxUPkI40aIqQwQwCJQSy/o0xbunDgY9RCPNj8FPe6hQIcqDXqqEG8mXgPAH?=
 =?us-ascii?Q?cLK82bAj0Olp5PXcv2vBQWFxV/aGKAxKkVPV8g0IWjh93cHKwf62ePmOi2G5?=
 =?us-ascii?Q?wwJVhIgY+HfkNmwB8i18oZx57p0HR7usEaG+9toYPXIM22mMbcD083Satcra?=
 =?us-ascii?Q?Be+kOvAnyZfjkPHOm5CwTr+oCLs5palyhMixjyTHSp8xEynu6EXao05Ebijp?=
 =?us-ascii?Q?/IQ6YcxaF4iaFQQCgsNbrwYWCYm31/2kbSQG8FuixLuWJhwamfPAt78DhwaX?=
 =?us-ascii?Q?TOsOiqBSReTl+44DBIPZcZ6+eH9SqY6q8DKguab92iVSKkq/AUzIvSvXBR0Q?=
 =?us-ascii?Q?+8HzIXXvV4aP0DCCnfxw3ijAlpsbVKIJ6JZQoqYpkGbcgKQNODfEGoeo1RLZ?=
 =?us-ascii?Q?i2SVAG8X9JKtdYt6sFnAj1F9Yu40avtPKq/vo1TCLeYFYLtsp3o6sNkYCaDW?=
 =?us-ascii?Q?a60a59xVfQYrrmZDSDi17zhFaFWfigWtnz+ylXzZqo/Ytb6IpXjyPRL6POSO?=
 =?us-ascii?Q?4//1K/qAOKI92q2UmCDGw8A2joUXF9jL9Zo4QnzA2cEbsE0GRWDll6weppFw?=
 =?us-ascii?Q?f//ZeT1eHRVjGOluqjpazJTZ4g/RZo2gaV6g/7zxQgR/xK6gbWoJPlqL1OHy?=
 =?us-ascii?Q?HziEqI8lP/uJP1GyZBBEcFcRnHQyoX35GuYhiCYaXshB7xBv8uiqa8DHUGO/?=
 =?us-ascii?Q?ShbT9VNfeQBiV08kBQNccY9VVSGJS3ipkLBMblFOkdBLak0qNCvjL9xEpIVK?=
 =?us-ascii?Q?NQ=3D=3D?=
X-OriginatorOrg: nutanix.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c362f32a-6d10-41fc-0f36-08de2c5767b6
X-MS-Exchange-CrossTenant-AuthSource: LV0PR02MB11133.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2025 19:18:24.7723
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bb047546-786f-4de1-bd75-24e5b6f79043
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SzxA3aUypwunQptYCd21mDKP9Cj6jDa0BdLigFC+FtkvYBJfxX4EHl5oGBEyVNshed8NGUk4zE8+uPtok+Gzphe5de/+CWKhWzXaT3QPjIk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR02MB7557
X-Proofpoint-GUID: jKaBicul_ebhmOAXZ0ojXmtXQsuOK2tz
X-Authority-Analysis: v=2.4 cv=NfzrFmD4 c=1 sm=1 tr=0 ts=69260103 cx=c_pps
 a=ZQ5czZ6yTY4ZD+V8z0ndCg==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10 a=0kUYKlekyDsA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=64Cc0HZtAAAA:8
 a=w4ubDpE_Fi1pwYaKQRoA:9
X-Proofpoint-ORIG-GUID: jKaBicul_ebhmOAXZ0ojXmtXQsuOK2tz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI1MDE2MSBTYWx0ZWRfXxCB3PPnbuVqj
 oHmQIFqGU+nE32Ab2PlVSFPXXRuMSNLLC2uKUfBMwEq7B/9VExVMFfSbm65Oer+skkRfD6Gohbd
 Jwzj6f+1D0jxIYcNA3gGWVxJFW/sc5y/jhgkrHVDR6ThBAZoHb04Vpf/n9RXsQ7Dqy2EUMrY8Ku
 8+/9c6Q5lVGp2KNOwfd6o3q1i6ybU7FRPC+Z3lo4atR3npk/dbaIXexDJfcoLAUEQdrHAXsjag1
 +ZeA9PbQ9tsBQSqN3M3R8QQCNXmwbVUwERylPz3tx0TyaOqlLtPSJAIM1dbyiOPETVIa8/qvN/o
 H30z3CrLeLrVwLv//o7RwXMylKZcJIxy52IIfRsc/mDzQu7t/mh2wdUKfbW8erSsvanx5UOUwTt
 az0Mw1mEYlzPVFemkCPdV6E3eoVxEw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-25_02,2025-11-25_01,2025-10-01_01
X-Proofpoint-Spam-Reason: safe

Use the per-CPU NAPI cache for SKB allocation in most places, and
leverage bulk allocation for tun_xdp_one since the batch size is known
at submission time. Additionally, utilize napi_build_skb and
napi_consume_skb to further benefit from the NAPI cache. This all
improves efficiency by reducing allocation overhead. 

Note: This series does not address the large payload path in
tun_alloc_skb, which spans sock.c and skbuff.c,A separate series will
handle privatizing the allocation code in tun and integrating the NAPI
cache for that path.

Results using basic iperf3 UDP test:
TX guest: taskset -c 2 iperf3 -c rx-ip-here -t 30 -p 5200 -b 0 -u -i 30
RX guest: taskset -c 2 iperf3 -s -p 5200 -D

        Bitrate       
Before: 6.08 Gbits/sec
After : 6.36 Gbits/sec

However, the basic test doesn't tell the whole story. Looking at a
flamegraph from before and after, less cycles are spent both on RX
vhost thread in the guest-to-guest on a single host case, but also less
cycles in the guest-to-guest case when on separate hosts, as the host
NIC handlers benefit from these NAPI-allocated SKBs (and deferred free)
as well.

Speaking of deferred free, v2 adds exporting deferred free from net
core and using immediately prior in tun_put_user. This not only keeps
the cache as warm as you can get, but also prevents a TX heavy vhost
thread from getting IPI'd like its going out of style. This approach
is similar in concept to what happens from NAPI loop in net_rx_action.

I've also merged this series with a small series about cleaning up
packet drop statistics along the various error paths in tun, as I want
to make sure those all go through kfree_skb_reason(), and we'd have
merge conflicts separating the two. If the maintainers want to take
them separately, happy to break them apart if needed. It is fairly
clean keeping them together otherwise.

Thanks all,
Jon

v2:
- Added drop statistics cleanup series, else merge conflicts abound
- Removed xdp_prog change (Willem)
- Clarified drop scenario in tun_put_user, where it is an extention of
  current behavior (Willem comment from v1)
- Export skb_defer_free_flush
- Use deferred skb free to immediately refill cache prior to bulk alloc,
  which also prevents IPIs from pounding TX heavy / TX only cores

v1: https://patchwork.kernel.org/project/netdevbpf/cover/20250506145530.2877229-1-jon@nutanix.com/

Jon Kohler (9):
  tun: cleanup out label in tun_xdp_one
  tun: correct drop statistics in tun_xdp_one
  tun: correct drop statistics in tun_put_user
  tun: correct drop statistics in tun_get_user
  tun: use bulk NAPI cache allocation in tun_xdp_one
  tun: use napi_build_skb in __tun_build_skb
  tun: use napi_consume_skb() in tun_put_user
  net: core: export skb_defer_free_flush
  tun: flush deferred skb free list before bulk NAPI cache get

 drivers/net/tun.c      | 170 +++++++++++++++++++++++++++++------------
 include/linux/skbuff.h |   1 +
 net/core/dev.c         |   3 +-
 3 files changed, 126 insertions(+), 48 deletions(-)

-- 
2.43.0



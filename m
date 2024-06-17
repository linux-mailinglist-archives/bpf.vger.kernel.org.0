Return-Path: <bpf+bounces-32303-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F99490B343
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:03:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231451C2074B
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 15:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E0213E404;
	Mon, 17 Jun 2024 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Na9JLn3D";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="P0JL8zXr"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6D3013E04F
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633711; cv=fail; b=JfjtgbK2CkOMlG38J76+3390YFLQpYJ9KTO2pF4OVnnaZ7+v8bSPmqC3MdGS+m5KoRLjgLcWdXjUfornBT0c+sBMFVgmwx3U+IVv5zjwtx49c24DTEDgtWce22TZ1TeHl5TwfkJiDUsBuu5Rus5IaDhLLL647smDZJD2Mqu5FUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633711; c=relaxed/simple;
	bh=0ylpYnRwoUS3WvNazOOJxvQftjsOnL115TvCaWDTuOU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=PBcMDZcgMc+ovm5GUUbX5+D0ARrcFOllpGG+qCOvF/3yEox1jkIST9ZpgsGxnZgA1ctowHr86TymNte1EAEU0K7f89FqNVcd/a8WtCzwG3KuI6pQBExmmC6gscNa39b5ubvycv6WGyg+gpjvG7Ql1sd4Icyk1/kdG2Nf2dpxFms=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Na9JLn3D; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=P0JL8zXr; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HEBOm5023419
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 14:15:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:content-transfer-encoding
	:content-type:mime-version; s=corp-2023-11-20; bh=wL43VqTbOjF95P
	MZE92d668DEaesmGWW4hKzZlX2Yfg=; b=Na9JLn3DCV7HxpDQiHjL2hOTcWG4k1
	UUq6B3al0siyhBQVw4nqKeZqsvwVQIRqHmMt7qjAmrHTPQacyXz2MUXASjOx2dg3
	ZeccoTt5Sn/TL2hgGla3wm3kTmDMVRAKZI3Ye1m3BcjqpqaMVirsgR2TKphdbD7Y
	Fe1JqJHdFlLHaYF2QT+Fq+XRSv8iTFydgSNxwKrr0gNFdJJsLNfrn87DPrbJ+jE7
	vJ/GCbeFT4+NqUzgSxWdeTA+AX0sOmZlZ9ENZsD07LVoyJRC44Y7DLwi+NiEwWiU
	iK7/k2qA2IaHiAghUCOBuImYdzh+vE1OXJDqDYH05okYEZf8Q6HlXHig==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys1r1tsr9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 14:15:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HE70Wx034789
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 14:15:07 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d6rskx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 14:15:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bT3L1sOCbv9H6D20Pw3RQdsYu7lMCY0gKwJND0AR+QY0A1cklKYRMW3RdmP/1crWf9lAlLkQWGUNVya5bximcI7TAaumfbkmPytftXmywUZJ6Lqkjrq1GLKwbOGYv2WRZ+weyC0oHvtmf/BTzYubZV+S9apcoWBl4+p0mJ8ektYWLTxXvPqsXrRGvzNjWZbGvl2ja9MMTFPIsLBoZ718QCZq2miEybI7wvG4qsiMYO0app6tzVIeX7iOUSONc6jcU7REg1i5QLUTrld6iNxf+WQujSmtvVfJznKtJeYg/w7O7Ju1TNuJKJkXd1y1QO0YeFEgdu7Hmm8YvkU7GkWs/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wL43VqTbOjF95PMZE92d668DEaesmGWW4hKzZlX2Yfg=;
 b=MnSeyyceyhAHcIAJp82UWMYrC4jySskbtn+dI2ORQXzcrNfPHyebnMukxeSAPFbJb8bqR31gc+OCAv9LD6gxXF3VnP6ZOSGcBzFBVozxqUiUmTFMm7nSLrGoWp0TnGgEShAzAESrCaT326v0q9yj5Ug8SVaaVMCI0dyXsziW7zAftfMPQLrmvMvcuENT+Ior+c6XNLqz5elzbqXmNS5JbIvXSRp1T4vH1zlK1sqeFBvWxuFjZ+oaqTBgobTd3N9PWCbJ7eE3Jyx0N8EpmpRpLDWo/wFcCeM1MyEISZh8rfQHBPDg+ZYQFsN49ATqgVctCccgdiVhYgshUwK5vtYI5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wL43VqTbOjF95PMZE92d668DEaesmGWW4hKzZlX2Yfg=;
 b=P0JL8zXrqMvOzUzW3XZTI8h9cfK+c+YxX+z9yAE32jDeKFbsIe2ombdRiGeh00hWViXI5JMmMLSbXEzIdo7FmQlgsi6Od/Z+Y16JoD9L56SETxeGg9mqGEiS0TDuqBbsiHKBW6j/wABlFrnNmtT7JoDupp08EPfXXaAH2dYu6w4=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH7PR10MB7087.namprd10.prod.outlook.com (2603:10b6:510:27f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:15:05 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:15:05 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next v5 0/2] Regular expression support for test output matching
Date: Mon, 17 Jun 2024 15:14:56 +0100
Message-Id: <20240617141458.471620-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0363.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18e::8) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH7PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: 98c4836b-a4f6-4c19-128b-08dc8ed7e27d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?gG0yVlddfp5755YNMq4t8K7RytIcJvPjSnGqWHcm0nBtmmEwPjy8Je+6bOKj?=
 =?us-ascii?Q?jF9heliXwK8Y+AAIC91639Iclr+VqP6bIJJ3PLpvgcVSLjOOTzm9Iqkp0iKY?=
 =?us-ascii?Q?Jx14m9bzHq/Je0MLg8xf5PsiMoTNu/3MEklEPkuZDFFKOXxGQCQfWgW+sOER?=
 =?us-ascii?Q?iniaRzOMbDhd6vDi1utjD7Owww2hTKdfgrnO9J96r35vebQlxkvwYzN7+O0M?=
 =?us-ascii?Q?N9PYTI5L/mWZTAnSCKl1zg47ZITRdrOh1ecMArEqJTY94x9IOMhSs75aX9op?=
 =?us-ascii?Q?92B3RNGZ0B/BzN1F1qb0k2P8n1r3fYyYVo7SCJV6blZiG6iQrECQPx0XgpTC?=
 =?us-ascii?Q?ffB0kr8jsuoVVHB1OeLpyeRyty5a/MNbvSlYDkbTSc6doaHdx9nDJ5EQV/Zp?=
 =?us-ascii?Q?+Aqe//GPnWFdCMbJ2Ii2EfeZUXhbam1wxGbzbynrPmPOz9VQzVPghRKZOlSu?=
 =?us-ascii?Q?erSQAI+wMEDmQLIcZJDtv52xZmCRJfm32+MpGp4pmPFZ2Do1myl8S0dWk//S?=
 =?us-ascii?Q?GCTqKJseveuCmtFHJ0A6Vt+wbNvGUiZE09CIGhy95wO6voFFnREoB8WkDX7m?=
 =?us-ascii?Q?GLT1hr95zBcz5DPsxfptDM+QT1N4JbxZHFesajQ1mAbn0X2CElNzmQJdchhQ?=
 =?us-ascii?Q?XDZ44aeVEPWlfQIUuCdU7QOby5mjPge+RcFoN79Uqf+8931Bk+JEptUc6fyu?=
 =?us-ascii?Q?eYKpwdT57MA9BDI7hn80wCPgpPcIf67nD0f8upQCU81YqZ+IUfvoNGZMDGgw?=
 =?us-ascii?Q?cdH9ue2kpB5M9XhxMb6qfXcXXJKvpBl4jZrWvlrQGRiz9FTWRJErqjxNHWas?=
 =?us-ascii?Q?GVbpvW+nQydKzk6LMzzuKKYwGLayUk5z39xgLOgxYbD1vJWknVkWg1TmYupN?=
 =?us-ascii?Q?PVpLdxkdd7dSJgKjV0WCOAF7Kj5T0RhaZqjRd4T9XSyicAdyQFR8xtU8s11a?=
 =?us-ascii?Q?LhtFfyYyQV0LVKuCSdOb61EBiBPxzXNRBBzcwtYFY4r2vyHev6b+5IGpaTB7?=
 =?us-ascii?Q?G5RE4tv7fbpY6b+t/TxUTt8xqvJnL6+Trf5uUNrcR46nNn3Zdnz0WJr4N2Oo?=
 =?us-ascii?Q?iCSNlVVYySh+PS8Reec+R+7gbb+oUN4s6rCVqxSH1dDClwFi9qwTvrN8YdOH?=
 =?us-ascii?Q?Q6EJJ0vg87i09YQ11E+K1iYgoNzZuXSntetGJdPhCy4YM2qKr485S0FypHkG?=
 =?us-ascii?Q?72d0ShhcUglI0U5E2oVYJJoIH2/GXaTiTppY3Ga2Fbktx7iFT7hb1WYWSH84?=
 =?us-ascii?Q?+S0NA74MIOxc/L3OVOaCm+3mDClBw33tfhwrYz9a7Ley5qdxCHHPMuLPXeva?=
 =?us-ascii?Q?K+s=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Xj9zl23QpQhS9TYcCx7/vJqGi1KKmGe/OkAumLC3u8hOloMcAaE1KP71sXqJ?=
 =?us-ascii?Q?KVhGQAb3mLe/sKiyx4tdFeh1eOWoxefMvf9zTCfc8k9An10tw28LGS/OGwYr?=
 =?us-ascii?Q?QkMt6Sfotb4wNbw5+3D7m5YsJnZXH/fycg/hCTVsdh/BRA9s+abkJ0YytoKV?=
 =?us-ascii?Q?e6rkq+bkFJXuiTZgBYwHDdWWJj9xLiqjlWe41ss7lD7Q3luxv5bm0ELTVxOs?=
 =?us-ascii?Q?5Jv1kNX0Ak4CToiLJUZyqQi2ovTn0n/M+1KQPHrZR6HrtmHlV0m70Uv9O7lJ?=
 =?us-ascii?Q?9HJqgep3wBoOg9BcuzqnmcNcU5gNucOJWDPZ5B/E0I3VAuaSw4wjiXfIcVB0?=
 =?us-ascii?Q?xCk0UcEjP7QrT/26+MJTvKLeMTYSwKsbCZfGRcOJMluOMOXAWeaoirCL6ZbI?=
 =?us-ascii?Q?6ex5KXogu6GCsQU51Pe/zIb4On2jJ3w42LiWB4EGY+dg/Hx12YDPz+bZQS6P?=
 =?us-ascii?Q?eHilyB7kI1bN/nq9JnpzRitg0gHZPrumjQ7fDdcL+HUI0kZqoSR4rEg8nH+6?=
 =?us-ascii?Q?72JeSf9K6A0qnDaYBLHfphh+u2gjOYalHLw2UJ1FRQ9ZpjcX8k+oaHWo+0U1?=
 =?us-ascii?Q?sO98BE7TnjBs8lpVjZ6fWXVqgThDVqeGuF1ES6eMnftSzjZVa4vHShrn30x1?=
 =?us-ascii?Q?2H0LO4W629J98P49km6H2m04HJv4mcBtXHvPoJ3I/eXzVpifYbFBWya+ZVpk?=
 =?us-ascii?Q?Qvk0sxxQe6Bl8gJzMZbH8ilqv0qIfKdxIW1H6HLb0bu/Nqol6ajEtiHbaz3f?=
 =?us-ascii?Q?1mhN57OFAAS2iWH2nnB9GLlny2v4hZagA38iinghZ/dJVHksAfrx745gMON0?=
 =?us-ascii?Q?Y5wFLX9l357z2PbQ5ukrNsT04mDsmaLsN3tG276zS2xPxnC/nWeUHD8nFs7T?=
 =?us-ascii?Q?6ZHojshH6oYdJoBZvSkl9vq3/W8Gpv/xzjDMz3jEjcm793M57kCsQApzX8Wd?=
 =?us-ascii?Q?8mOj/N9K204pkr7K+ip+sv2H2wVnYTXIe/BzT0YpHOm2LSNlPclTqRL4xlic?=
 =?us-ascii?Q?QZL2WTbE2y+7iLLg6ju6LRw/tLX91wkidaR3u9a1TWPkdQpuFpbbG+i13YHf?=
 =?us-ascii?Q?g07K7/AhHKWTlJH5RcHlg5zdPgREzoKg7JjvLICuJJjtoEL/yx+niqV2OyqM?=
 =?us-ascii?Q?NqpjcmACq3g8fItm2zqZhgNW0dX3ayQGSufCpgWhu6iYE1NaaSlG/A8wD1bl?=
 =?us-ascii?Q?T6KLxcO4ZXhZKuQ9KpZZ+Xda14uY2KV0sjN8Zcl4BiOIyp5OFF4Mytlw7Wv8?=
 =?us-ascii?Q?jtHbstY7Dm7j55kcOOkCFXxsyr4Ua1UR6lmbTvbQt37nIBVHeDiR1xIOa495?=
 =?us-ascii?Q?Y0XoS/YrZoTspjeWTMBg026MTFwOCkgVUWPPAi/qXOXxkIUwEnRBfCez5QLo?=
 =?us-ascii?Q?lkaFAEXshgFFOBj3/ukOhD1Rt2KNAJHabauxJclvS+hSe8wMv2j82riXJCCi?=
 =?us-ascii?Q?mgnJ2Mye5Ga3vHOrVh9tgUWiKBH63SfLUTcFmpIOp8x/WPmfa2sQs7Ay/iKZ?=
 =?us-ascii?Q?cDk/aJAiCPafn1DymOzUVbheHr/EOF6LgWMkTdKhk0askhZGCx6/9+OSy9uI?=
 =?us-ascii?Q?hMvGV3HfY4wiOiG7rbQJy5TPXfPYnxjIn1USvROBJZ4FjT4WF2kU2HfsWU8Q?=
 =?us-ascii?Q?wGNLynsEUdzycNUCWAmkCJI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yEcs9/igQDDqiGRafao4H/7Gzg3o8sh+aTIjeiKIUGHatZ1oL+oyVS0rAHr28dy5mLaumx+bsbiDu40y0dCyblFZV8HTQBYO18CzO5mk2cDSOpC14FMAZfCBpwyO16bUs3ig+E58rYKS2g/G22adv3tRe47DTFQS1YCMIJYX9QGkC/kt5Omax2HDfqeWO0qj5SG1IPhHINJWNFWZ9qTDUbrNCSUrBrPeAf5U1yTSKmMI+BEbWMTcFBfb2Hx98uGWqtQvFJl1GhDyT/AFRkKBwaC/oFoY/Z25evw1SBKJk6pDHFPCeA78NAu37yKIOeRboCub6hdu3Cmx6kxRkZ3koHh0QYFuHhMWUCF7xf7PSp6SRvvoFTyaIgfrcg3WL1svmtWNZSUh4fdU0vFQDIhRCQTjX2PUkNzX8dSgQJgIzrZCqbSBVPjXqPJb95oC2Dhjob/xoxkijqqYC01CyF94wPV4yKx9fJV/aSEWT/Msa7x5qKpCCZyS5ZZRw2t7/8936q18D1qylDgOocVNeHPgIfoJxF23f/Y2RLwSd/zP/4IrDMBOEaQUmbBo+Git+JmY0S+k7pPyOolI+vILAWW2F3vUnmNePCHc6/zJKd7gpXI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98c4836b-a4f6-4c19-128b-08dc8ed7e27d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:15:04.9944
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1QS/rqBXpYolXiL86+IGOGkQ40wxwyL8HjuXH82aewH59izAmbLuNEhMlsWmDwgTeSP8X/nBkMXk4QkxjpMOqJpMfUF2HPrpthJzjtdqa0Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 malwarescore=0 phishscore=0 spamscore=0 mlxscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406170110
X-Proofpoint-ORIG-GUID: -gvSL_9WFOzlY2DyOEcquCy_6ppe-GMB
X-Proofpoint-GUID: -gvSL_9WFOzlY2DyOEcquCy_6ppe-GMB

Hi everyone,

This version removes regexp from inline assembly examples that did not
require the regular expressions to match.

Thanks,
Cupertino

Cupertino Miranda (2):
  selftests/bpf: Support checks against a regular expression
  selftests/bpf: Match tests against regular expression

 tools/testing/selftests/bpf/progs/bpf_misc.h  |  11 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |   2 +-
 .../bpf/progs/refcounted_kptr_fail.c          |   4 +-
 tools/testing/selftests/bpf/test_loader.c     | 117 ++++++++++++++----
 5 files changed, 104 insertions(+), 36 deletions(-)

-- 
2.39.2



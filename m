Return-Path: <bpf+bounces-39526-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BEDC09742FF
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 21:06:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30671C26362
	for <lists+bpf@lfdr.de>; Tue, 10 Sep 2024 19:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E908F179956;
	Tue, 10 Sep 2024 19:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="buAveCxO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="EekKih1N"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81581A08A6
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 19:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995200; cv=fail; b=l1NE0mfrlawZ0hVsUDaLnVBdURz4xrhTbPdPqI5SZohYtOHU+KQpogC2bRhu9LMaA69rHfcK9aNuAGNqSuaBJT30e0UvxvE5eFYeDi3bnIeBC/pV1BRMzgFYd97XoNnL/rt1bcOMFiqglLcP1+1kQQpABa7s6L2t48dPx6HRpDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995200; c=relaxed/simple;
	bh=WVGCTscjzCZxd0zHATvfa5T6iKiy8chw7rfNJLEiRkU=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=BUal/hEu7ZU7VqCRUjimKnliZxpR0a7sdpO7HPd262W0SKlmqBnWZU/bRAL0Q2to0hWcBgNmsk6WzW0sK6SygCmW3Vi8lZd54B3SaPi6dPD2Eqi9VEtxI+gH2NoPvlIhkiI/DP4vkFapi4i3xEgJa11rd0VHkg4mQHmX3nT2pZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=buAveCxO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=EekKih1N; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48AHNZMk016963
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 19:06:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:subject:date:message-id:content-type:mime-version; s=
	corp-2023-11-20; bh=WVGCTscjzCZxd0zHATvfa5T6iKiy8chw7rfNJLEiRkU=; b=
	buAveCxOlL9QZRbbL5PzbrlGAzDq6tPr8lsLx7nnED4FQcWkAVwySeePsJvqcHO6
	QEkRvnFOyOHkctrCRlGxNsJ8WXtxkTxVJf3uLtPoxGJadR6uiB6+bRhlR2fy4Lh5
	9um5nTd8m4d7Vi4DV8/oGqqrHyDTBVxTdj5glRhlQ881CJVSWOvUe4LBSsonKD0H
	aH7PPTQlbU6/b9p8YlcdHdhH0J+rKutxbIey8wot3hUz84CMOhgoa+qae9YuWG/3
	BlQ/Smnz5Q+PHK6J28mbYe0fqL+iX0o3NeqVH/bMNJy2uloBmc1atFS2W38/5AbQ
	EcmPzmaDFPZRsEQo9EhIdw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41gdrb6fxw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 19:06:37 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 48AHivlQ040804
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 19:06:37 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 41gd9aft6u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 10 Sep 2024 19:06:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fThyJM3eP3ZN+7P8bAwrhuL494AEJxEVpcVcpMXG+iylNUlKSV0w+rnBrP9NnCS+dJsJA7G3bLNiNhfPG5comwSXA41nxSNKh4EtRU1GWz+pkBNC4E+OTDkNmxjgtHlMAh7AtsiJ6n+Y8i2fV0MyKhRMOtYRdgF8vAu8f6ZIGb/0hq9JtMf7I6JWDHHkMmf46lvL0pkzSoR5frXe9L+8w/Dvs3n8jJCFNBHBZ8VAsKBZ8b+bj73V+fvHrkCFGlV4smz3y6MaFpQkubAs0iQgzQpSCa05S6Mnfv3Tfon1Vm2GnxSAfNCTkAp++rCsd770wQiA+mT0ARedL9otMWDASg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WVGCTscjzCZxd0zHATvfa5T6iKiy8chw7rfNJLEiRkU=;
 b=a1LRvcKWPHSqELpsJV2ffzCEHb6LM5TUjCqXkT2i8ZayUstdAvyykaoIthY+YddRvtl5N7C7MhK5xI92kRmd8RZOL4Mg0uCGSutZL0Yn3Y2rH7JvE/T12rlq6HSJOvJRusyLp1k/Yr4BeAPJnt4ij1+ke57W7Xx4G89uORVsH7LlU0rT/u5iyk+eVz/1bdLyo7xDMOMXGxnEcN94ifZi982k4fmEBv/9XV82eTe/S/6iXVEas+ug6Q05ZCfTH5v083PWIYepFtpkZf/eLNm945MsIE5D0mwwNAttWBkWWPyiHMNhf/kkxmOhxRqzmmYSez/Ru8Qk6vIDIkBJEZwlCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WVGCTscjzCZxd0zHATvfa5T6iKiy8chw7rfNJLEiRkU=;
 b=EekKih1N+QEiZa3Vj7WP8w9AR5vyrLtYs9IypQTdNJ7jDqz6Jij+hL05S7yYlWAvMEir4UdtolR+HLgvSdkS630lfTP+cY36Pe4KqxAEkYp/wSdjHZVnEp+hf6I29nQ2cQ3z8TJbZD1aqJwXd3wzwTSFML9Ec8dddygf7x6XwSE=
Received: from LV8PR10MB7822.namprd10.prod.outlook.com (2603:10b6:408:1e8::6)
 by CY8PR10MB6636.namprd10.prod.outlook.com (2603:10b6:930:54::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Tue, 10 Sep
 2024 19:06:34 +0000
Received: from LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e]) by LV8PR10MB7822.namprd10.prod.outlook.com
 ([fe80::4808:df01:d7ce:3c1e%6]) with mapi id 15.20.7962.014; Tue, 10 Sep 2024
 19:06:34 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Subject: Toolchains Track at Linux Plumbers Conference
Date: Tue, 10 Sep 2024 21:06:29 +0200
Message-ID: <877cbjnxai.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0186.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::11) To LV8PR10MB7822.namprd10.prod.outlook.com
 (2603:10b6:408:1e8::6)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PR10MB7822:EE_|CY8PR10MB6636:EE_
X-MS-Office365-Filtering-Correlation-Id: e341d268-1b60-45e1-a183-08dcd1cbb011
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LoB8BDzmdxspFGpk/wLOdh8Bzn7XBbxF4jApoHRuJqJb1F8GOCS16cqDrUvb?=
 =?us-ascii?Q?QJnSg7wMkQ75hJfpAgvvc02/MVjKoLEetRr8373tHlrW9TC0fsAoUJGygojf?=
 =?us-ascii?Q?odYUPgUTdTrjv3yqISql92VE5Eg8v3x2B7ewp5X/o5ae7mdL3jKmjXK6Cma1?=
 =?us-ascii?Q?rz4gdwasZG4g0nkNlVrgXlJ1LiCQZ1VSoBgJP2SUO4KLhT1OS9//AG9oMCgT?=
 =?us-ascii?Q?H2AU8u/jb57rXAa7Zr/lrcxNhS9GQANpbSpltvgkqIu2OBt5FL4pSi3mWHGD?=
 =?us-ascii?Q?g4k28IVTiWH+8UUwwPxB56KXVK/74hHFhUxRc1IvjdtS8JW1g2ZjdEAZfl57?=
 =?us-ascii?Q?TAZUDdojQ925hx1wBrz9J1W+LhZWEDe9PGLr6qwBCfM/v7t37ly8cr9Pa2OQ?=
 =?us-ascii?Q?YgoQ2fVnQ1nyRo7Df6mH+8Bo2ORDW6Qj4vcPSLjaGnX54Az9iWI6vL0acXcn?=
 =?us-ascii?Q?k5KrxnLqR7BLFIHivSdKMVrqPMPREFRT/1jfCjDYLDYpwBoF0zJF6StVb445?=
 =?us-ascii?Q?rfwaFaeq/EIXSe7/rN8p52hnbR8RWcBjrOVaJR3YZSuaVwzh0wNWHQMXo3zW?=
 =?us-ascii?Q?HS+Is97+6jogqIFOLYLnUNZKBhL1yNfDMnLFv0EegB1K6Wkm81eGs5TIy9vH?=
 =?us-ascii?Q?o/kmAJ1GEplZz1X+r9N6XJSufIX+qO6CN6rIXwVq9ZLJs6zjhCUhDFQf0fmt?=
 =?us-ascii?Q?Wh59OjJEx42qAcMJPRFQ3heNLFaZw8y6A9o6Nf4P1heB8ZaBoIO47ZVK0NIA?=
 =?us-ascii?Q?1cFkwVL1LZSBFCi+d5x+fkF+gZLwvZNMXnLDlptxmtciAbyF5GBWq97qzLRj?=
 =?us-ascii?Q?W4nNwpCiv+NGDI4EVi+AkUJZKxAvj5mBGVWuWPrSIwj222HB9Po+jt90tLHb?=
 =?us-ascii?Q?QG3pONJ0C6xHaX7Q0Gaj51+gqqK50WNliN7wMxyctu8HmBOraocFozOrExKi?=
 =?us-ascii?Q?qk4btOpFzO8pPLKboMcbL2VKoSMXittxft93jlAZdhUxkpFX4JAhA6lOGXjz?=
 =?us-ascii?Q?MSVusH1hZqJG73cXElIXsZxuM7m7TtVzvUs4PuMMNKTQnihSoZhWwYIHFWQs?=
 =?us-ascii?Q?BCRzVa3L5grea7GvtasPD6jSzckTo90pi6dlEKYEjzxTV87FSnSmxj0sOTR7?=
 =?us-ascii?Q?vlKsHMakKhmnqFuDPMfKLsfNHXLCFOh4iqns8cr/wt2QLOxCA/PuSjy5zzJy?=
 =?us-ascii?Q?ewr4PALjwRznuF6OrOpq3kns3xg5VjtZVXDNBPThM0Z6jxnP1xL2TQJRmaYH?=
 =?us-ascii?Q?WqOV3FiuhFz6eUR/dWMWWlRgFkLyZYvEYJEsFhm8duqVYDp6qqWzC8lVQRD2?=
 =?us-ascii?Q?Gpg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR10MB7822.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lwE/c5WVaNMITX1m7DTHbPzbfxs9hWZzT0gWussz64mxMCKtiIkPwLDccdXU?=
 =?us-ascii?Q?hlX1vmUeRxfZ8OQc5QwhasCmzqNUQir+RDUfj7AxiHDfiCpwFtpSMdHxVpci?=
 =?us-ascii?Q?A28a5tCAIWzqCYDN+AO5coXyEe1oNrFxnoifIo/XDVWn0KXWe2c/aVPDRbR2?=
 =?us-ascii?Q?ByDCNSreLqGB1uZpS/9U6BX418yiiwGRj6uouA1xtbWIWyZobWWwd4Kumrge?=
 =?us-ascii?Q?iA5dQH+xUZCJaWt+4M4OO5Qk7fLGejOn4DWbY9kNpECFFi8A+sKBoWWigDRq?=
 =?us-ascii?Q?3lIOYh/MHWvxTpSKy1c/Nu//VUOZEYcSq0IcM1xuUr8hi/bVMfpnQqauSipI?=
 =?us-ascii?Q?COzhGZznOCK+LDslHVe5aieM/IEM2APrF6roWE1IB2ZcbkB6hFAPnqOaSnAP?=
 =?us-ascii?Q?f3Di6HmhVSrqNEjbeAEcFCRTWc2XyV8EpFOPOL5zKkPxIeeszmy0pSMTL/vS?=
 =?us-ascii?Q?nV3ia0UeAzV6RBmB3Qq59rL0dJ3ySfZdVsdQ0r/nGr9LU/RJQzWwKk7wbo7z?=
 =?us-ascii?Q?UFt26eQApKyZqg2o4hX3WTiA2x0tKdl94yQfALBoTJXTs3mS00oOnklwSP+I?=
 =?us-ascii?Q?O5WIx42w9TaXD51ZJcpAt/1P5znHKwso6qy62Wp9c70lWCKrV3ineveBiAoj?=
 =?us-ascii?Q?vAUkdUi8UVolM3Cgo9bjTTtnC37P1ytHfYPhU1lpNR9jgIxjMXQoRU/UknXx?=
 =?us-ascii?Q?NZz5WZQkWgIWzdLnD5Mgmn11n0ESu58lfZNiwlp8VtHvTzSTnWRHRuzYjxP9?=
 =?us-ascii?Q?RU0m0lVrbNmFOl4EmDwCyVS5xXDth3kGXzQbCWL0WwNkJoxSerK31RD4ZhyQ?=
 =?us-ascii?Q?QIFKVPpAE8ObxRNu75GgTV2W2YMJi9MsvIGE8tMzOjVRF+GSH38GH9If1/VL?=
 =?us-ascii?Q?Dt/nTk1TD2My+2v4Vls8lvYNvjZ/KQBDU1KdheOMI5CLPCdSYbLKig9QJ4Vd?=
 =?us-ascii?Q?WX9Ad0P28MyOeuulz2IkuQ5P0BdrGBw+1g+sQ/xBjSwWC+x4rgWApoVByT5I?=
 =?us-ascii?Q?VhEGkKnaj0QQzzRvOsC44JOaTs0tI9LWizu9RZeHQXM0xb11+yzofXHUjHzk?=
 =?us-ascii?Q?H9u3nbgoB6RpOidxQ2AFRCG39GhcwqTWARnbItvLbUYqwq+ohD6ZwiG19glj?=
 =?us-ascii?Q?2oVyGP/Cu4ENNEJEHkmthE438lxe1xu66gdFscBabnWK04bCB19jXcPvNp9Z?=
 =?us-ascii?Q?2dm2XmbKtB51WWJv6XjOuPGBhTuNmrtsBDvT7iVQ+Qx9mhoNuJWwWoHftP6j?=
 =?us-ascii?Q?8mfNMByrU6lF6o9xMCEq++R9mbIMjMIvGatQRBCpi5wPgH+00RguTpxNI3bH?=
 =?us-ascii?Q?kQ2zW5u4IuoapWI/1xLxAfpzXa5RNbDVd2cxCCr3uTrjRgmZlL2Z1gx14tsN?=
 =?us-ascii?Q?fnQiyT7sLEdpkJblxzhsekrs0pp85L0/QgKMY5UEWef1Dw+LY0OAxRkQUq5U?=
 =?us-ascii?Q?GxkKzavLJKKrVptBSxEP46L8ynHSvCn1yZa/4L+4vFT4gwNgzhFy2gC+hZzn?=
 =?us-ascii?Q?FWDdjFaHKMYBSfvZS5xFGd4hDhCBGEM0qnlbi9weZTTMnwEi7J2uMBy21JWq?=
 =?us-ascii?Q?rX2vLZqj2uwa1E2tsPFKzb4azF+hjNaK73WN5qd3sTPtT/tf3VeY5HRdKGLP?=
 =?us-ascii?Q?ww=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	LHIXyFw1PpySQL2FYwLcuCLuwpFOI01vKwDVa0XYx7k7yOXu5IN8s3gGktTOt1W91uIl+g/3X5DMcoFCYIaBWYddD/vACtjN1+rvgDGY4zNkcbBXsjnC+MSOvF9slXDSxEOv4oqO3t9xUFONCtO3xPf5PQjW8+qtvIP+aYlxOGoZQcJJxkITHF5Doeq447b9wIxiWSVFfX8NDnFfaQEZE0rIyDtzVOoxDh2myK0mduqG81MT6oIQkPHPXAk2P/J7AfyfvqU7KiFanQ3C0BnfrRmQz0WDe/G1QpN1M6VZWSkKAa7JS6vAPhNAo5Swey4SPgh/6b1RWF8pI9a5Yai4tLQS+Sj/R57Ow9CtzViy0O65G9m+7hNBpCxfxIzI2Gpfy3DSsY5okp7lu1iiTVSPVPK6YhQ/uvgcOPNKnFn9zARoWZYj/H1CbtlDux0NpHDGd8EgoXd5YE4Sxgh9TSxJ5opDwW7D0XlIeCNcX5jInbHjgzZCjUVcqD1YBOChCbEBrkM192s6iAxQtwNDQJpwqcqR2rCCyg/ZCxCk9STOpz+FJ7e0CnjA3fFomUcEJFDSetjmYooZX34LHGnmSaQLrn7v9eq/0JWvaI5mL8XCGMg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e341d268-1b60-45e1-a183-08dcd1cbb011
X-MS-Exchange-CrossTenant-AuthSource: LV8PR10MB7822.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2024 19:06:34.3203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MvS7AuJFp0iROVqJ7GJJHmOeHhkfHWh1wlTso1ZpzzIhT4bifcDjXD/OdAUwXFUOObmmfheumypQin/gW3vbCFYzt8+LSdz7XqgnHEBBrl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6636
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-10_06,2024-09-09_02,2024-09-02_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=528 mlxscore=0 malwarescore=0 phishscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2408220000 definitions=main-2409100141
X-Proofpoint-ORIG-GUID: S_qRvW3-1Lu3VrWhZMPAa_78VF-Slvbh
X-Proofpoint-GUID: S_qRvW3-1Lu3VrWhZMPAa_78VF-Slvbh


Hello people!

As usual we will be having a Toolchains Track at the Linux Plumbers
Conference, which covers topics relevant to toolchains (GCC, clang/llvm)
and kernel.

The real novelty this year is that the Toolchains track does _not_
collide with the BPF track 8-)

Since we will be discussing about several topics that are related to BPF
in the track, particularly in the time span from 15:00 to 18:20
Wednesday 18 September [1], I thought it would be useful to draw your
attention to it and invite you all to pass by the track.

Salud!

[1] https://lpc.events/event/18/sessions/180/#20240918


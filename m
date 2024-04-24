Return-Path: <bpf+bounces-27679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 83D0D8B095F
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 14:25:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3CA87289527
	for <lists+bpf@lfdr.de>; Wed, 24 Apr 2024 12:25:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D7215B115;
	Wed, 24 Apr 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EXZ65l/n";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="CyAP+IqD"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303B15ADAE
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 12:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713961497; cv=fail; b=uRKI1DGmToxWMudBQVLnmqTtrf3hR1+MYvjaZEfZr1ICPT+/06gD7NyZf+AJfTjnbOfy4NwF6VttcMoxaYgFm3Mkn066V5KQAxVk5pN1DCjxFvdi+Gve/64Zhef304i2HoZn0Pfbolc8C1Ye++P1xAzTUkFyf94Q03ZqN9V48ks=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713961497; c=relaxed/simple;
	bh=IxGsHNwlX6zj8dBfeM3sIVNb5pYC4pBcIX6PKRtxZ3w=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=VfEBU2J05JqkYuPAoC8tjagsYvVOF3AOyYMkwTw2HcTzv+s+dNaHItixID3QcfgOGvqQrXmjbsdZO67Fo7cmeWlGRL4GRbxHYIBA8Fb7SWt4tzCC1gUojiI4flGkcC7CPERHz8z2rA9EfBqhc2GSfARvXRFailmbCJRZNvn0Eg8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EXZ65l/n; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=CyAP+IqD; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43OACeaF010167
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 12:24:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-11-20; bh=LnXEKhW9KKRvIF+ZM0s1s4xomluYwTTvaEUvgon5z2g=;
 b=EXZ65l/nOBLtd7nxV1GTNEnHJ0zPzSqvYDJn0q7oUnp7WYdIsG60NV9PHtdo+blhgmdw
 YOLNNACc3Y37u5utEbU2kP3T/jS8+1hkAmgpyVwMw1G9tlUwUeE92L4lVTnpQkdh30+b
 8BEg99HtRYI0QoKhTz5oKsXYQJeO+k0sKnRdZKmK6O8GaYkfDRgLeWUuKzXZlk45kjx4
 FvyY3z0ACtfYixCEOidP3M4dEkaRYUMPsEC05DjOV0xShypjPaaYeCmkfhZK6PgOm7q7
 3kE0p5D2BOtkKCri8HAbW2wuwnvbgNGk20OnHDWvD4AzBw/ywWjsRnvNJjlCFv9QQ4LM Rg== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xm68vgfct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 12:24:52 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43OBZE4i025396
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 12:24:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2041.outbound.protection.outlook.com [104.47.73.41])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xm45f13st-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Wed, 24 Apr 2024 12:24:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FH2xsk9fwejI9Ziecus4/487UKwD34PmRZGcq+LW3sKHCDX4R2nuQo77B/fHVnUlj4qUWGfYuKIHtsxUD5zeNfva/qf18yAtnSvf+pUWYZjJZVXkhthf92yao5x2DZMGXSkx4gD36akrWO5jxYWxAQZEBocqncVWAnTZq+jZKjTMgSxwTUhjEW80jWTqcK05j2+WbzNc98gpkV+zbp44nsBOCDgv3EwZ1NS7GIsYdvBay2IH+JNAuNpOpPCpmFbiRooHUXAoCFWGV2mwpvQE0w8E6XICHBy1StY1swX+isJ/ty8FvQirJhdRAHBsj82zL7Aj1pAQs/hbTdw8K1vfgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LnXEKhW9KKRvIF+ZM0s1s4xomluYwTTvaEUvgon5z2g=;
 b=Efe4iorNF4HpQfyoTLwThVPZNqRHN9Hr1hwzNe1DCiPMvarD17C6Dx1yqzBmEbR5R9q8rNIxFOpAc+OIlUhL8Csi9kbBKr6yq8WEKuAloVWPbljYGGjd2H9NO0HMnjLiASJ/z+i1OJtTQ/Bo9Fv5gVsphum3FkzPy5wGjsHuJcrxNejZ8Vgqr6ksyk/RS0h+Si3aPnB4GyHv5sOZO0Qb7E8hhpNAjm4YWB/yOQnNLDoiMIJ7q/a47e5IDqcDbl+m7zcvE+9xh2x0OKwRrR+ZTjpbU3kSBFPLUhdbbilZ+yXErizNI9ihCy/ZMwMmFtzA7OzlXlfEktuRFFzSTMgpIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LnXEKhW9KKRvIF+ZM0s1s4xomluYwTTvaEUvgon5z2g=;
 b=CyAP+IqDCxIRM8PNvnFrE4Fl/GLymSIs+LDm3V1A2jNil/WRBfZvjx0f8A5PleCi2Y22enqEmMQfMcjFCXAUy82ssjwGMc6uLEPTOtabLck6X/z3fWtenGb2sC80Mzh0HW6+nF67uORMGRjFk7k4Snv7eTONolkZauS2OqXFsA4=
Received: from DM6PR10MB3113.namprd10.prod.outlook.com (2603:10b6:5:1a7::12)
 by SN7PR10MB6667.namprd10.prod.outlook.com (2603:10b6:806:299::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Wed, 24 Apr
 2024 12:24:49 +0000
Received: from DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0]) by DM6PR10MB3113.namprd10.prod.outlook.com
 ([fe80::e0b9:12d5:badd:6fe0%6]) with mapi id 15.20.7519.021; Wed, 24 Apr 2024
 12:24:49 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: process_l3_headers_v6 in test_xdp_noinline.c
Date: Wed, 24 Apr 2024 14:24:45 +0200
Message-ID: <87zftj9cdu.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0179.eurprd02.prod.outlook.com
 (2603:10a6:20b:28e::16) To DM6PR10MB3113.namprd10.prod.outlook.com
 (2603:10b6:5:1a7::12)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB3113:EE_|SN7PR10MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: d309b1d8-d6fb-45ce-5baf-08dc645988d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?e36UrYjhcJU1a5f1/YLBj7I7ksLoHp7zqddSKfuGgI3K9LF/0WGD+00F0in9?=
 =?us-ascii?Q?zJRM8k0xXN7C42O/5ybmYv67nMCqrfSPwnebOheVvtCU+pqirLk+DvX8EXPl?=
 =?us-ascii?Q?ns+esisYNlHrBe1tqMqZVc48GtgdD80SLf0VpAjC12o/tr3UAHpkVEsXFgmv?=
 =?us-ascii?Q?w9tCuCVAazrr2L5RXWoMfQrCnu8LI6OPd5V+2EbfZe+V3q913RxeCHsFlI9v?=
 =?us-ascii?Q?iNBShS7FUxgFVx1bpUQfD9h54O1/gGTmx+hWotJnHmIu/+aDWPUnkZ1bKZMR?=
 =?us-ascii?Q?slal2vUSLH28PYIEcP4SXYwThkq3gCpp/SjlSgLEkTggN9fw2os43nKTOa7a?=
 =?us-ascii?Q?rJ5KV2NqQHZ6qOAT4fdOg/mZAxOuzdAw2fAeD5nKXy1TBJg+38A2OF8Hj9mC?=
 =?us-ascii?Q?b8pmUNPZFO7oBjprBmFDQoUjj13n4Yw10Zm3i1mbfJTReH9or+yOjrK5+aH8?=
 =?us-ascii?Q?IaIBF6Vv4mZ9hiZSbgp4GbZhhWXE62Dgkfrc7qbAs4FSedpFX2ihFcGB6HKF?=
 =?us-ascii?Q?0N20Mnzs31+sSlsD3aNH5A5mi5isLUIO6Pp83SqwnEC2sjg0LeBF/GpJE8Sn?=
 =?us-ascii?Q?xmuMEUxXxGnA6ZvjC88L13r0IX/7DFyLRTcBCYPIBL98ygqTw4M788QTsEkb?=
 =?us-ascii?Q?RYRQZUKs05p7ZBCFJOvU1ONmkAz2bsDN+vv3TyV/nv+0GZ4sj8PNoW2KjUZ9?=
 =?us-ascii?Q?RoaDK6O+e53tQePp4s+HELJ57Ujq7mM0e3B6RCOR3RAbMYPIk04yP9LPA0CH?=
 =?us-ascii?Q?IuC0QUtk8Dkwb7gIqahyxeLHwnABT4/PoO545uWR8qkkN6YGeyibIrEe0s/u?=
 =?us-ascii?Q?Ru8GUS7QRGfxogN0MPSyxVOBLvig9/N7uD4eQHaVfhxmHhW7vN/uuRU4Q8ya?=
 =?us-ascii?Q?YgeGUDehgDBno7/FAn5c1n90Q1xGPMCAGuQgaGzwPSAColk0Bu2kcQVxKPd5?=
 =?us-ascii?Q?shIkdR0D4ID3CSB+5BG7z1b1fcbfpj8ULkBJ3RkDwnIL2Q0JPmfu22PXizZH?=
 =?us-ascii?Q?KpWUgx71SZ7AWK0WmchjdM8v+O837DfGch4XSBobxAoyNwLWV+wc/IaZwzk8?=
 =?us-ascii?Q?7xKjmBsoCSNulqDAENqqtUYwTauvsF3jUNApbyRKDy/2rQM3ZraBbzGfnRDP?=
 =?us-ascii?Q?qnLFsIZEVa+wpsRzNEcXa+8lFR/U/RG3ho+0LJLgYF9e2Nnsez5wwIZ0xQWO?=
 =?us-ascii?Q?INtI6K5lQ/eaOwjG/8R9LXkCeWsq1PheGjwCjaElTrYl2U30ZK3Jrin79ps7?=
 =?us-ascii?Q?b3B955MeJn9FJEs3DspeEkMfrbxTjvdNzUv7BH/9Hw=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB3113.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?tWN8mmIQ6qlnJk9vDCCYhujT8X9k1P12xT2i/elZbzg6oj0/aNx4eW7YGtHi?=
 =?us-ascii?Q?xXRB0OQpCA4HyPrE9drcnn2mGNm7OZH2YcBd8VP7hBt6RmQ7WuIJORSTenX6?=
 =?us-ascii?Q?O+7UkvOeHuVPmOaqArhO12e2gtMiz56v5tAjKCD7xz/e/Du5ARzZ3DC88Xsc?=
 =?us-ascii?Q?cG6fGBjRA+RD9i6bB1mt07pTloL/t3ZrltMuWv6uJHwMIMX4oCpWsR/nwvLt?=
 =?us-ascii?Q?+YU/4DXWyVwdBChdXodpxu/d7P9uB1Nri9UTDdEEa+C0JNEMGHxTW5bHiLXS?=
 =?us-ascii?Q?FSdMQK60Q8i7tO9bQ++NShtXsbQSAmf3kcvQARR++3SR8X8E9zcI/anxj0If?=
 =?us-ascii?Q?ffehdQcpBaiT9ZIHJy1MZsu6AoIjjz3rYq55nkkPKPSSD6IzuxNZLKfOFwEU?=
 =?us-ascii?Q?3Ktx7tXCm2QO2qK/1fLxbx0HyvgEJa7lALdmhxkDf15TbSWMApjXFvlmX/bQ?=
 =?us-ascii?Q?89qAuRHuFZop/3dsE7nesHxyTF8wOykli/evnCMMbNhCccoV1XI2k4QsX84P?=
 =?us-ascii?Q?5KlwvdocSrBxvWEaGbLEh7FCX39LA5lppNr6iHrh6Pz5g1b8hzdCuINVRIAJ?=
 =?us-ascii?Q?2ZL5oEqIiD/ZfYYObh6f3fVFKpnoP/EnVwedKxNawuQpjby2pt93TYD/y+R1?=
 =?us-ascii?Q?NMj8QV9Ot/EEg5/YfQE4zpuqmj5/MFVPcCrDx0XO7jtvPj5QBftnywtMsh1N?=
 =?us-ascii?Q?BgT8DKpY1TlIzxg7bXc3f7IsmXUeAqibjV9auQ4CPx4nU+cQ2Oa+EeaBLNVH?=
 =?us-ascii?Q?pbpu3H5HWjJRGWHMdFApOtsQEHGGMqjFd8YHNdx9wNtF2/9IYRokSTewhBwl?=
 =?us-ascii?Q?l9cSM/EDKQ8c0KBnhFItC3xTQtwJGokEhDrZSR+NP0yReuAvTgyWnQvoW3fx?=
 =?us-ascii?Q?Az4lArc0ROw2b2ik3fAVjR1/CXVnixoIcBVwa8dOh0b++nrBhQDv6d9jikj3?=
 =?us-ascii?Q?Z1IHHxNPuIIrCbGK3m1gwEZIuoJlncFGyMms+for+Jo185UDHcs1kzLeusIv?=
 =?us-ascii?Q?/gHnQG9YdsjQljpW//3jfe0S2sVdsduomP/PysW0wFWy9WhUSfQVdXzFR3EK?=
 =?us-ascii?Q?cgdBjLNI46Z6iQA9BU2MUDAXdLAZUjU/DAhnPTkBrHM+ekiamV+1JdQfM9ST?=
 =?us-ascii?Q?ujgcF3cZPCLfmZO3z4ZK24yb0JZ4+/Mz8IPyqU/gXO6DOC0OFHwMusE7a5Ts?=
 =?us-ascii?Q?z/LFT+yvuyM9h7ORNXSvkrLSgRcOpqoPWBNl+kC0nInEzTd5U4XlNTB37NVG?=
 =?us-ascii?Q?STccrA7chD3a4m82f6JgeQYocSnoa38xbxW0i4j10Xr4X71W9yN/fHwQhJwS?=
 =?us-ascii?Q?HYUFjiDX8ATt7KzI6royN0xxIaEyGvcjZx/wVSzJ9uZEppAWK5Wj9CdDIBqi?=
 =?us-ascii?Q?TJ5n6iQTZJOZHVTwsJ85f4/XSc0TUok7Bx//H02n/XhB8m0zTrk2Fe7fmGDO?=
 =?us-ascii?Q?qbIg8va2MtCrhZmjCCYfsbj0LecP68QfCjqmgc+w3ixzKfRqcm+n+FT4OqmG?=
 =?us-ascii?Q?W5oIlRl1KtzVXvh23WQjBoC29MWATDUlVB5xQfUJAI4IAC1NEPmKMRe+Whc6?=
 =?us-ascii?Q?GhiUlfE9Al4ZOwlIHYvrMqFIbcxYIDV4e1kebsUxyZM+2sGHil0TlhbdfCQx?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	dBGDYmYNiEEETZflGEQahLCfmeZVf9Q/YzpIeIoD9A78VViTXRd88GjwSutVHRyq6pPdTNu2JzNTjmQeq/BfiIndyiLsN+W6qShGGbBK+pgUQEoW8o517gCHLKN3uoCOBCJktZVFpRiO2BARG1B6UHDRhDDZ11E6eg41JVYTDw71ke2Ll6voah39fC8Skte5xazxB6NdgZ1W6Qq81ofsUelaxy9vJEEWUO3BOoGMsAIDfWYKR2lwZrKihjAESThxOyNpKrDYHniUh4xLp62ZaAvPoMEh96UxWePJCoH/OOWzVMep7a9Pvbdk+fyJjzRB0cjv+JT/Rgx6UaOmyY+KlXDKYMIhqmbkWd3aMvdqiuMxaUJzTsIgXmeBlzbIapgogNB0pDnstCX3vxbPPWWauaa7avBkNG9mXELRPRIddOcnd376ZTsxHsYLdm5vLm+7OPt/4/QftZlr/Rk6i7Asao7MKP7/koKp5TUdMrMrAjyQBNS0EyD3Zr2i8z30dWWKM4y0mS95xa3oSOF86UxHiAeT1prxR9uv/K6i+mUDKc2R/jJ07xaVevbdHG2yzifXjIQUKvdRM3Eq+PZbE7fxU4R3YqIoebffEfliT3P9+Ys=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d309b1d8-d6fb-45ce-5baf-08dc645988d4
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB3113.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 12:24:49.2581
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZa+54dOOrfPTazhPCT3wIJbvNhkF1d9IIZfYl9PA1EG5NWcLtlm3GuaqGjhDfBE3IhWULkJwaA4abxtRulNlnXI6G6s35Iy3dzym3cQDpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_08,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=999
 mlxscore=0 phishscore=0 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240046
X-Proofpoint-GUID: sckQcW4TFDjUiQaX8V_dkCyNj9xb740P
X-Proofpoint-ORIG-GUID: sckQcW4TFDjUiQaX8V_dkCyNj9xb740P


Hello.
The following function in the BPF selftest progs/test_xdp_noinline.c:

  /* don't believe your eyes!
   * below function has 6 arguments whereas bpf and llvm allow maximum of 5
   * but since it's _static_ llvm can optimize one argument away
   */
  __attribute__ ((noinline))
  static int process_l3_headers_v6(struct packet_description *pckt,
  				 __u8 *protocol, __u64 off,
  				 __u16 *pkt_bytes, void *data,
  				 void *data_end)
  {
  	struct ipv6hdr *ip6h;
  	__u64 iph_len;
  	int action;
  
  	ip6h = data + off;
  	if (ip6h + 1 > data_end)
  		return XDP_DROP;
  	iph_len = sizeof(struct ipv6hdr);
  	*protocol = ip6h->nexthdr;
  	pckt->flow.proto = *protocol;
  	*pkt_bytes = bpf_ntohs(ip6h->payload_len);
  	off += iph_len;
  	if (*protocol == 45) {
  		return XDP_DROP;
  	} else if (*protocol == 59) {
  		action = parse_icmpv6(data, data_end, off, pckt);
  		if (action >= 0)
  			return action;
  	} else {
  		memcpy(pckt->flow.srcv6, ip6h->saddr.in6_u.u6_addr32, 16);
  		memcpy(pckt->flow.dstv6, ip6h->daddr.in6_u.u6_addr32, 16);
  	}
  	return -1;
  }

Relies, as acknowledged in the comment block, on LLVM optimizing out one
of the arguments.  As it happens GCC doesn't optimize that argument out,
and as a result it fails at compile-time when building
tst_xdp_noinline.c.

Would it be possible to rewrite this particular test to not rely on that
particular optimization?

TIA.


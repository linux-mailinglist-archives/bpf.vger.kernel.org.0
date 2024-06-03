Return-Path: <bpf+bounces-31210-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAA58D8682
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 17:53:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 26FAE1C218D2
	for <lists+bpf@lfdr.de>; Mon,  3 Jun 2024 15:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E34D131BAF;
	Mon,  3 Jun 2024 15:53:31 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63CF22576F
	for <bpf@vger.kernel.org>; Mon,  3 Jun 2024 15:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430010; cv=fail; b=lZcj56RFHEdAQ366DND50j6MoRgvqxSoMv0VGBGiOjMMNlypIUx6YRKVVZ4EqvDpFkQ+VMAUV0XTPWbSQ94VNXkoUq8HkKKMWQp1OwibE59L7japGqWppFgi36uYYC/TF6iOZgSLRcqFhh89Wrmr5Jkk/D9TdSmKhxuro83L2Lw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430010; c=relaxed/simple;
	bh=fcaypKOkqUB6CyV7p+SOicF5FLnDye0qfrqzUjySMiU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=hFj+dR7dvpg6Nyi8b+liV6y5g8+1VnaY7zsRvzZn2JpNS6PVD1deTL7if1FHlUWRmWM/9w/aT5t5SYNYrKukCi0TBRmGZEdY4qRw7kO+ypJekmYjkIhWdoIZRHfUjYniIDsWa+KuiJTg8ebxPIJX3bjKIZCw/1asZrD+7EHofGc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 453CKNSR024807
	for <bpf@vger.kernel.org>; Mon, 3 Jun 2024 15:53:28 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:message-?=
 =?UTF-8?Q?id:mime-version:subject:to;_s=3Dcorp-2023-11-20;_bh=3D0iPQdsPwD?=
 =?UTF-8?Q?A23f16z3h1IFyRxq21u7JWiJ2x1YIo+l6o=3D;_b=3DoB8ztVDzhACawDskvQuE?=
 =?UTF-8?Q?5HGhsnPWcZcuTqXf7AcVBaZsyB7E+yN6r/eGuKCOqsjkml2w_aE1AVVUUtQsOHS?=
 =?UTF-8?Q?0SayqarHitNEr0118rkpZp1xCXrsexOnTx5RJSnEZG9A4h8nfAtwV8_breVQv85?=
 =?UTF-8?Q?J0KkIkOkvqIGA4GH9aqpAjmm+25euPJY6Tv0Gr4gu8yCku/Yr9Vo5VRzbSyO_vk?=
 =?UTF-8?Q?De3MAD2ZUujHt9u+QuFCMeoXju6px8bhBkejgxUEECZvFYMOwEK9Usn642SQH0a?=
 =?UTF-8?Q?Zz3_o6srWQeDdGAbjNCtY3YpxC2X/L8t40ZFTihPfvtAnnT5R0qX0v7FGgxl5H5?=
 =?UTF-8?Q?aMakoi3vs_lQ=3D=3D_?=
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yfv3nu5dg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 15:53:28 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 453FSXjX005485
	for <bpf@vger.kernel.org>; Mon, 3 Jun 2024 15:53:27 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrmcc1cu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 03 Jun 2024 15:53:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eDXmwocFbLbsa1xI5UwCpW+vRjq+wtiQpiEc/idKRGzUHqT6ZLVL0Jmz2UvhQyJCOaSA2rqURhy/6fkdr0V4b7hwTO7TWqPjADDU0WaxTsEcmvevN6ox6WPV3fU78NDfyK4BwwoB2AZdEsyH161a0lQO++XpnDa0kP8nQxG7YOLvv/PK/GaHxb/yXBQyw4tJVUlolciDrsrBFYY4nPi5DKxKxuuA3Amf0M3wgoGYRf3fwul5ChM6r6AU+w0CBPgrsgSyWlWpw+n08dWBUdHWqztbcUs/+7FHaVU9w/ZOAXEMeqHaanieU69As7Wi3KU0EgbzP2T1VwtJeEEQL+JOfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0iPQdsPwDA23f16z3h1IFyRxq21u7JWiJ2x1YIo+l6o=;
 b=hJcy7LIPKOYYY3zovYj/bOl2gKA8zyJi4msMiXgODcV+Sr/4y2b1HWxP4sBFkPqJv3kfoFCO5EX8KBqxBOiJ+miXLzPtteHwk9HnPzg3koYPdDQin2H5+E9O41P9FIVyqBem3jUvtoEOcMvsejdVhHWcjKrkfxkBBFMc7uR8zlXHaSJE9TB4gV9+evNXSu6dcrgczi/Al62k7WUPRGD7JEsmyIW6eCNHxrWFH+3Cpk10itwBav7ANWo6n4hZuumr+Fq2vn1qRUrFiuyog4JpUiKOn7OFtVxuo26MBFodd/i2DTeDvGIEytHI2JKyQWbsTmiEup7hzXgSMP5W+DQYTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0iPQdsPwDA23f16z3h1IFyRxq21u7JWiJ2x1YIo+l6o=;
 b=ejAI/w+Tj2q5TdlLULxpXiN2WgB/RJZYS+Sx/Z6ZZ1p72nAwsgSI+cZlr9lFSPDBzpoLpDPQ9MP+XSV2RQZAaTg45bCCaEZpXxfP9cEzQxxN93feezwUfeqNnW/F+4a2jzJsjr1flqgPAtzTvQhQDk1ksyXgxZS/mAA3/qwWVAE=
Received: from CH2PR10MB4373.namprd10.prod.outlook.com (2603:10b6:610:a9::22)
 by SA1PR10MB7790.namprd10.prod.outlook.com (2603:10b6:806:3b1::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7611.30; Mon, 3 Jun
 2024 15:53:24 +0000
Received: from CH2PR10MB4373.namprd10.prod.outlook.com
 ([fe80::ce3e:31a5:f731:d5ae]) by CH2PR10MB4373.namprd10.prod.outlook.com
 ([fe80::ce3e:31a5:f731:d5ae%6]) with mapi id 15.20.7633.021; Mon, 3 Jun 2024
 15:53:22 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next 0/2] Regular expression support for test output matching
Date: Mon,  3 Jun 2024 16:53:06 +0100
Message-Id: <20240603155308.199254-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0030.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5e3::20) To CH2PR10MB4373.namprd10.prod.outlook.com
 (2603:10b6:610:a9::22)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR10MB4373:EE_|SA1PR10MB7790:EE_
X-MS-Office365-Filtering-Correlation-Id: 93902d60-cad4-4b0a-f402-08dc83e54bfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|376005|1800799015|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?iFqOIot8SZJ8wuDQ28V8SbcCD+whuhJ8NhsI1ShqP/u+KvVxWy06OdnxFyYt?=
 =?us-ascii?Q?fSgFYrmXP5edXFVjD5F/HXZo8r719l7vhvyI/MsK5aREJSEcAR558phwmwbc?=
 =?us-ascii?Q?YXK3uq6nJvJ7yO4WPLLHt3tMca5fdU6a9MXfGpH9MxAULCRBtLdHvcDEF2vC?=
 =?us-ascii?Q?21kcwWPWKHVklhk+J/FRPJG6vTBL8Lu2Jnmn5fORnxdSaukQVhPqed1TE/7b?=
 =?us-ascii?Q?o0iwXpCUDwe522TkfjKX+uEpqIuBk9bnuhb2dNv3zho15rbc3MjIODK08gLE?=
 =?us-ascii?Q?hZYHi2yFNj8AblVVjSt/Xc8377JWCjY6XQZ3MV/CGs2qinVYnXcocWzrgUcK?=
 =?us-ascii?Q?aGEkVaWAVrfNNEaafMFOO9hptU/SEGRgwxghPDr/xgxzC9rlEW/nwZdADMIN?=
 =?us-ascii?Q?0/2KOaS8ybPEuzzzV3EMkWAOpjwPresnk/gqLAN7oYcSkg7FjZ5C7mG0IwMv?=
 =?us-ascii?Q?LrcnbY8AXtGVVzq4b1DRgrErFzH9X/wYjTlrCwND2pmYwQS1o5n7s6pCbK+Y?=
 =?us-ascii?Q?UT6A8WQ5kxx453fxB9Mkf8OgW8GVMyyA144ipyf4sWmiOa1KJYsRJpxFlgi5?=
 =?us-ascii?Q?1Mxo3Czuvqwd7ORr9+D8QJAB6Dwr79IDp+B0WqLqVlYk4NgCzm4VL1+HS6ZI?=
 =?us-ascii?Q?nBW8PtlUDG/Zqo5ZwcPTjV9Ib6hXGIdGGxmBvX1CekLuMn+MMm59fjJIyH6b?=
 =?us-ascii?Q?OvUhYecBMgCaM0NOBMCvyddRPP7pwrlcnTl16uHsnuGxOpNisfCyB9iOXEBq?=
 =?us-ascii?Q?OKcSeBamu/aij6AXfxaTW+4fsNQMhjTUjTGxsxSUsON817MZ7JmSjSoF1G2w?=
 =?us-ascii?Q?QK9xiRc+QbMWz/wbzzaM8OkFto22vUauicOnCvBYUTp6pKrchSpWgovvCcUW?=
 =?us-ascii?Q?s7U+WTabDQqT+tZW0BPiyBiFhemJNEc7BV8Qpu+I1tBiegGo8itJiZEBVlDw?=
 =?us-ascii?Q?cJmjSFRvw9gNwx0vidCZzymAyzkgs4F0MBZsMMvj+sv9dOKo3jiDBVmD0oVK?=
 =?us-ascii?Q?MallguMXiw+k9ccnBaF8r12UGTdV06/yijSYQ9yimstJK4f1lHGiylZ9+Xth?=
 =?us-ascii?Q?Oa3CDMXT8Zxg4seDwY42GzO1ExAKHV2mOtwp7jU5RYbsZneRf5aZvapx402L?=
 =?us-ascii?Q?C7c127dSY1Uc94+i4QMEvnutGV5J4WdtmbPEMMiI4TwHNgQTmsrpV99QflUN?=
 =?us-ascii?Q?8utNj6fCmBOk4kPDxvYU5GGtD0/1DIH+bGQ0NHToXCamZtXS8Y9yjdw1x8OO?=
 =?us-ascii?Q?1byfmqLhyTq4bwKB3faT6ro8kX1i0RxTMk3ap4GcoQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR10MB4373.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fo7sOsl0WHSco0f3sLdvU0gxgEcvzAoQmd5wxuAzX0KchE5ghpyJR1Bd+ZQs?=
 =?us-ascii?Q?8yubA7/5s637aHJxdLAvoWHONkwUl3EEbxCPJeFDds/u1rcPIG/C3o96ZMZ3?=
 =?us-ascii?Q?jJ8ubHJs25RCknA+98kW+3qW/VOBGYlfNIxc5iXsmaBXXAK8wDmge54Vw8uk?=
 =?us-ascii?Q?GHC8gvETLxrSBN4bIKXmevUye3dWJ48eYIt00HvzkeIqN8cEK8srGzo0UMVZ?=
 =?us-ascii?Q?9Kdnhiwusz14mfzR3KxU2QGa91pDwxFTcn7biBkqtrkNUdi9Kzym5enrhXHW?=
 =?us-ascii?Q?UhjDneRzoeCtU//wbNJ3/Tg/fgrEVJQMIFnw8uC79B/CkKFs/xoJ0Y3i16C9?=
 =?us-ascii?Q?XW1oGKNhFOw5iDrs/vdzKpul6o5BNAK6bHk7BwuPxg0IjIVCnGMInQVgi2Zr?=
 =?us-ascii?Q?Qc9YSKIxea9D5w1A+v+dddDYaMEA0Bt1sHcfSPd7Pcn7OSOPTztwOZGnapoP?=
 =?us-ascii?Q?rUYI2ttVEal3AtUwq7E0A+HFZArEOmPaQ+UuyPomxvc6+ft5LvT3ETct73rJ?=
 =?us-ascii?Q?9FI28qYQh4LLiysQyqFCyQtN7Y/QA/qSKQAPgyBHw1mcEb0HTfIWpHIVwXv0?=
 =?us-ascii?Q?1qaqTbXBW2erH2X4eE/MnyUZ5FHQaBmKaF3HPDOmsvfjy8t5Vif6o/FwiSYJ?=
 =?us-ascii?Q?g7NwwJtqkUDr40DQCBzQPPxGbOA7yLkhKRcon8c+AoKPQrP/a2R2e7Qznxn0?=
 =?us-ascii?Q?biOaMWnzhdrWJfHbesQgiRj4WcqFMItO/LVbODvm4EWSvSIAgk9YJuEdvTnm?=
 =?us-ascii?Q?W10ToM0AMlmkz0OFiV7Uxk7b61tLRUVWKONoF/dx85aZsU+iCCh3GpslIykV?=
 =?us-ascii?Q?KWlJdGWJRmaEpu29yylGMvmoC/X6ECJFEN/tUkeYI1L7hHL2rXZYPA74OBA7?=
 =?us-ascii?Q?c4PO/JHfMrqcJZmBXLkm+R0ZB9DAOuZs4awUL/FmZ7XX6pn+DQn7RYk4SWmr?=
 =?us-ascii?Q?yQZE6u7S4vSHkWfOx/Ma0N3N4CF7An96VzlyrKSrpMsz3oiF42AbbskdjAHN?=
 =?us-ascii?Q?8SJ4WBmd5pz6VH9bSnwF7R19HFZZ4n/sMYML8DuSTKOSMtij2mobJMwz+L5r?=
 =?us-ascii?Q?dwe7jWKZrDJ6q3qrTbQHOoKTHe5BTpm3TFmMQFhviyQWkB0s0U3RfhL/zg4S?=
 =?us-ascii?Q?z9vId6VPgpRk33Zvuh31VjJQqhYaTotOCDyR4spB2U5Ta1XfHcI9ADIEQB+h?=
 =?us-ascii?Q?siPSs7tBvoXc0NqRav3Dy/fC3BAeOlbXb0IJ+3L6tHmPznpahpp9vQSc7aZz?=
 =?us-ascii?Q?/hdDRGmh7VJlZFUc4Gmo1hKBIgaIAalt1XtvFJMUzY6/pQVmifYflmnlsKcr?=
 =?us-ascii?Q?RRDOMBoeYcwgtvdlD4O4Y5LQ9j8dXR6NAcAY92zzyJ3fpLfiH14YXjJJ/C12?=
 =?us-ascii?Q?Lf7IUXO0knt5rw/PkxT3jvoir0f8ZF07p3PrAkmJWegMjNnSR8cPvV9wW9V+?=
 =?us-ascii?Q?iJA8XU01KHAm4mgX0U3hGTAcVCylouiBR88Fj+Y5kdiZTOULfSOngRbeLhY8?=
 =?us-ascii?Q?HWt3f2ik4Cc1n273GwvwTy5A9t3wSm5mAHhm5RUcIG+PXH/XbOD5MxBoRrPh?=
 =?us-ascii?Q?oZca8P/HLr8VFBoVcdxbGIhHHJz7rLSDBNATVpav32bi5va2tFbjBvVUd4Ez?=
 =?us-ascii?Q?9rAkpwDf7eQd9qiK/FFa0Es=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	YRctIMRwixcdMQ9mM9YyXyFkPPr1tghMpP2X12EfcZAwqY4z5DwiYyWZ5g3Yhlsg5JUGDYoSZSWdxGXjorn5rF6zPvBCnw4oEtT7UuT0PSy2dg7+uZStyLxvj2PJkRiXMrL+vQbxDt6Bz9+5KlJq4IWWWBJpOuEuTUTqEEyb/WVNrrcwuRtynRzGGojZKvvMRH6M+pVcw83QfleOQThRi7JlQVMgpohtbPjBGACvJgVYGTliWRqsr0r8NSBZMBsq7cbM3UC1o881wqpV2TpGweAtjjGJ5jQs9GwZcCO0Yo5Q4DFPeDRqzngEqJIQLiS5fQD9nXIFuF1y699Cie5Z0qFX7HiXJD9ml1Uowqk9ibMSY5pQhDyO0jSmDDvbiMY6XHL5zBTukCOtbuy84PdDL2UP4/kmZPxFjDTI4gT6iIvIgck4dGqc9MTdkcyQidD1XB7E7kOsYWZj3kN5MmT9AgK1ryBxQ8VsNR6PtxSEwXLvDfrEeeUGHzUuIzp2qpYebB0Hs75AtLhHmi0HOy8cNFYSqTFAoWtAigWPSoJNrAaQzjefnXdQIvlMSC3Fcdc9vSRNgesebgY8tjW5U6iHz+dsjyQ4tTIe/cUQYBDJvwo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 93902d60-cad4-4b0a-f402-08dc83e54bfc
X-MS-Exchange-CrossTenant-AuthSource: CH2PR10MB4373.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2024 15:53:22.8436
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wl70W8dbPUnztblBaNlgSEihgf0mW7lIVdQ/SjmZ9B5ulYIszaXFYfiVnfU4f7qOn6in89reL1lzpF1Ho0InGgqSzSI1km9Bq0VB+CTe7tw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7790
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-06-03_12,2024-05-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406030132
X-Proofpoint-ORIG-GUID: jzi7MhYKljTgUxkv0-MjxMA4ttHGEPCr
X-Proofpoint-GUID: jzi7MhYKljTgUxkv0-MjxMA4ttHGEPCr

Hi everyone,

This patch is in the context of fixing all self-tests for GCC.
I have identified that many of the tests are checking for particular
output matching that is very tight to the code that CLANG generates.

This sort of approach for validation is very fragile and tight to
precise compiler expectations that cannot be guaranteed, even from
different versions of the same compiler.

This patch series introduces a regular expression based approach to
output matching, allowing to validate output without being so tight to
precise output.

Looking forward to your comments.

Best regards,
Cupertino 	

Cupertino Miranda (2):
  selftests/bpf: Support checks against a regular expression.
  selftests/bpf: Match tests against regular expression.

 tools/testing/selftests/bpf/progs/bpf_misc.h  |  11 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 .../selftests/bpf/progs/exceptions_assert.c   |   8 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |   8 +-
 .../bpf/progs/refcounted_kptr_fail.c          |   4 +-
 .../selftests/bpf/progs/verifier_sock.c       |   4 +-
 tools/testing/selftests/bpf/test_loader.c     | 126 ++++++++++++++----
 7 files changed, 120 insertions(+), 47 deletions(-)

-- 
2.39.2



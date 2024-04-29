Return-Path: <bpf+bounces-28165-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3218B647D
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:23:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 674052889FA
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:23:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C081836D4;
	Mon, 29 Apr 2024 21:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QgZdBz4E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="b6DkgQ2l"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DF7141999
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714425803; cv=fail; b=uaeDowfn/ohEzU2nuk2XNiMbcWQrIOb3hYDOm31Vauu0a92psrPcsaHMmUC8Ee5WvkE2wBy5inuLOm8djdar6IVl3r4YDU7IfvrsGnERgRSlXJ7LdSsVNOH8TUajLVUBn1/goccuOUF8o96x2MGbNyb0qs8816B4EKNjinDi9jk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714425803; c=relaxed/simple;
	bh=cVmJ0N2xxXsh1GekM6zDLWb/YQgGSiKFXqzlSgQwOK0=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S9hhHLNMIsp+XwT6Uci6zXxJimijpeorSCDMPHziG50qhhlelmRrux6Igm/lgNvLbcjfWH6+Wn/o4tSGRhJP5akiH559DcwCOcApfr0s74kOpHeOrBHD7aOcUDSJVGQt3+edvlkMdlJx9GdpErc4obx2Uprxeu4XnS3012wKUqc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QgZdBz4E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=b6DkgQ2l; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43TKFu0d002938
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:23:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2023-11-20;
 bh=MasQW7FTE3HFEJwfafuy3zRBmkapt2e1tBXd30V/pGI=;
 b=QgZdBz4EuYBgSRgsn69cbHxGwGdnfyHqSBJgONY/RZ9AcEjm97dGBWLk6sI7jUH6fpxW
 VRXiCP9Ukp2s1Sganzc4EeQKh1zESFHDvdnhQ8OQhGkOKgMlIFCd+82zH79BsCKlTso9
 tG9EZZN2R1m9HJfvq54MAT7x22SIPosflK8hpKiFEytObaaYCFBp2LdfNBcPxfUGZ8f8
 tsLkgTTptZiuhzdaf+KRMIJVQ3TsDxGaCjK9A9CVMyNFzELycZhtXGQuk0QHdahcCDH3
 J0w47LT2z4AaedyDDXJ1VOs76KeDW9/cwGoDHBh1Xm/+YNOdNmFLjWd79fsbUVqwJmuv bg== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrr54bpdh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:23:19 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43TKoQK1005044
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:23:18 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2172.outbound.protection.outlook.com [104.47.58.172])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xrqt6g6ck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:23:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GMnrTtyzC4Ypg9KQsGFYTXe0Bq/km86YuVr5hHQdTdgK496f8/4CmxFO63dT7sPdUGbrjEuTkixcF2g17wOd6DJmeKSuo8D64b3bqMzCnNLt6gj4kkCqH15tWcgSDbBOI1YTcqfwIWUhB0clGwkTntyTa/o4FQdABQ9OEDI6kV4Vr/+TQ3sFa9K/Oh57LWbRGN7qpnaXwweF/yc++sR/wPKlvpC5ieWNEOgbT1qbt+QWlNBrtuTvUOWli3CYE/15kkC2xogkqL7wH4nPmKtfRE0959QnbARZrkBkMO+5ix7u8lRagywsgoPot5az+xDxtrTIcC7L1ICWTnKQuFAUlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MasQW7FTE3HFEJwfafuy3zRBmkapt2e1tBXd30V/pGI=;
 b=FHXbTvjdG9zP0AaQ7OQrWsKqvEbAXS1eyNp5nKBkwDHq9RmZ8RkeN7twPja6Eqgz3/4NW79wvlZVmKmX3nveglsedtUicImQDmWiZZ0zYjNaH8jlCXJVcOPAZo+FXnHjXFjtI7L5BLf3LatWMwhtwkExduYjlaQU2vBrbn7moaku+tp4h+caeo7ktClqSDmXpIe0lxAi5Jjc3nfqVzhytnb0uG6fJkF2WvpjEqG8uShyuGqstQbNGv61IJ9MQXNi6QTPtLjRaJFk0F6ke/fwCneX0aJdzbJUYcZtis6S0FSgBIygikNqjzvndFqSXiNbvpuqiYioAXhsGsNPqPX3zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MasQW7FTE3HFEJwfafuy3zRBmkapt2e1tBXd30V/pGI=;
 b=b6DkgQ2lAATEgTia9IowrEhahEanhfHoArAb3dUDVNGtjnwljP9nak60RWbNIoLe2oRImy75g4aPMC0MEFBSGUn5jXXYgjDHHfi6Y5h7h5sgGicKyL45zWI2KKccczkJzvGm0n83Whwc+0C/ejFNCjAHbYec9eRYKRtVpK9OszQ=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by IA0PR10MB7232.namprd10.prod.outlook.com (2603:10b6:208:406::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Mon, 29 Apr
 2024 21:23:16 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7519.030; Mon, 29 Apr 2024
 21:23:16 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next v4 0/7] bpf/verifier: range computation improvements
Date: Mon, 29 Apr 2024 22:22:43 +0100
Message-Id: <20240429212250.78420-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0391.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:f::19) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|IA0PR10MB7232:EE_
X-MS-Office365-Filtering-Correlation-Id: 86a5354d-8fb9-4238-9b0a-08dc68929599
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|376005|366007;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?XSaYREi7s5LliVy2Fm/avO88TRBD/qAAP8Dx8U44H8PrAI1oYrzQ87Q8dgEQ?=
 =?us-ascii?Q?1ZyoZjZ33ee/cdWekxpo8K90gOegftBK3cbKfc0C/f7pkOEfANlhvBhnINHz?=
 =?us-ascii?Q?j7SFeKfStojwmHKYgjnKOuzTb8AGAWB4WuOz9+AAGi8cTsgrQA9PPeHYztqv?=
 =?us-ascii?Q?cByqSAYnsI6Os+3PA4UC2Yvw1oxu9boRLCiBV4BvvOT9+YlQGSauU1J6iRyx?=
 =?us-ascii?Q?Z8mgmPI6ho1A4+i7entL9Lb9V/ts2JVHtI5dxOtoB4GbSYYwWOcOAme96aLy?=
 =?us-ascii?Q?RMeCnezipQp5hvVUGoTc84NqIKABKSzEULEjHknnEil1WDVFDkEUxrD4per9?=
 =?us-ascii?Q?0YxvdagbFTvYmQ2GmDyFSlQbk5AUUf82u+Sal5sGJV1KH+W51vdHNY09ev4h?=
 =?us-ascii?Q?ijj2i8GaPHO8JWo+IEH2LRQKMioJmdyNYEdcxTLmBDQO/m9tRAH3SdSAsThe?=
 =?us-ascii?Q?KqOBvN4kPojU0w8kbp0gR2TsJwiXGfrlLyajoHRMBg0LLFljjB3+nfR0Oj3r?=
 =?us-ascii?Q?cYj4AsLQ5Fn3q4/tq6Dx0Igw+Kp2nJC39NrjOcBLzEFRbQq4opM0joy8kmi+?=
 =?us-ascii?Q?JCnG4p3v3pCc5REtWdUaRJFlPmkAi4+C2L4XjAfGmlwiRTu4tILPqpfWkycZ?=
 =?us-ascii?Q?XCIZfoWH+97qYLWqOmhow7g9Vtb3vQ3VgrpzsxpxiVNdgpG7aXEzVKwiTrG4?=
 =?us-ascii?Q?2MqgJm0jBV1rgDPesz5JnZjvz5/ehijjOe4suTiSwzn5RrTquJRJpJYBLBGg?=
 =?us-ascii?Q?fTgXd6zT2jcoPN+36/Yp4L8WJBZsDrCcluvD2jLCNuSCn6ai6J26KnyJwXuD?=
 =?us-ascii?Q?w9rLwjkeC6RICHwkEv4w0AwgMi6KO7OBtEdUtJONz9JE2IkS1ZBJztzg7iKq?=
 =?us-ascii?Q?2WLZ3W9rJzHq9DOzk3GuiUi2mLl6YUypHS7p3fQLP3lhTxhUejd0rhGPZcE7?=
 =?us-ascii?Q?4smWLd3r/ga8LF1GqZoHjN/ubeYLUW2YiWiAKU05TCrwlUiu79Zd62Nw5xHU?=
 =?us-ascii?Q?GE0JSETrN/phqpvZ1D/IAnmPrsq+hNVeTpO4Kd+F+LS02ZM0n0jU+eJpmO0j?=
 =?us-ascii?Q?h5YtBTrPAd2Vfzkv/zBXwWlLMOssxrR4EfZ0I3mFUqElLw5xB/ox2mMkpGRZ?=
 =?us-ascii?Q?sueyVU+skqmYjPYHCTZyTGUEub++MmXQaRj5cALAOhM1zAaXWGrr4UYn9TY1?=
 =?us-ascii?Q?E2/SRH6BW2xPhuJERY1cOgTtKtUWcXlYeFISBUcFKIpYpAGSI7CQG8NTwY5J?=
 =?us-ascii?Q?nZCrgs7wLeo+GeOGI+c3kmt8LTkSUdbxEbZZSguXUQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?LOUxcUYkkFo5DPYkA92T/cnxDY3DWLDqnje9Bbsa/l2jhm9l30TbPkvcHr/Y?=
 =?us-ascii?Q?HljkTJDLFt93KjAvxE4gceg6zCtWmadc9ikNLpGi9PjMLUuD3bzdv8lmQDEy?=
 =?us-ascii?Q?SkjMAI4bJSIGqEtWedT9DCiliDqDQ+c97PsLqTvZfK6aZ1vnTd9cXqdHH2TU?=
 =?us-ascii?Q?5QgKG+cDZc+qmOS6OFPeJGM+Pj9RfPc/PddoE36z4rORsllOGnPa+i7L4TP9?=
 =?us-ascii?Q?ey6BOqdbRC4xJ/cPBZZtRT7ovtUSsX/9o5zIdP56qdXlEVdMscgCF0A2pBpE?=
 =?us-ascii?Q?Jj2ii96/5maYtLOfblc71X+A9ne0BsrbtJ/vfQvpl9QK+4hwI20TLGlWKRBA?=
 =?us-ascii?Q?ZKdYHxN23wgNgBbMDSsWybzUJJgAjxDzvEcSU/Kg7tSnXA1ei7bvswmiqHx9?=
 =?us-ascii?Q?n/0/y//HhpIPHDCSAFlXG4gvpdamsARQpTs3QSBJ4RWcqKJoghY0yVYYDLNG?=
 =?us-ascii?Q?K9IrMVxV3iG27AbW6lfaJves5ECBVXGpahzn4K74xndPb9Flv1tU8QMWf6uk?=
 =?us-ascii?Q?088lxlxUlfjemLaCKiP+M7YouPxDP6IgpUKofeGiYkMiV2IgN/d1LHXl0jtG?=
 =?us-ascii?Q?nQJKzzIV+WMjTRUr9SHB1WPcYndfGJzqmB1I4Le3+z6Ac3+1SUQQVPrluDA9?=
 =?us-ascii?Q?KMwBYUCHNXCL6znC+F4SfFl+QuB1OhVsdNPAYk8yF+fc4Iky7W22YHPMDfMh?=
 =?us-ascii?Q?NV9kgiSAplsb5Q3n6Rex3C7FwqX8BNpJDcbz3LE7ZKFAXuwVj0LkcVw7Mubd?=
 =?us-ascii?Q?lwMHUpndrncj7LC7eG/D2IISPS3mrcT2XfbCI2i7myKD3p1DZa89QYpwkdyw?=
 =?us-ascii?Q?Alv42+B3/0gYpEXC9xZo89nnmCr7+5zreUuMzy3oqpIkuCufAQTYlRcxIAir?=
 =?us-ascii?Q?4N9WEjgrBNuqE91BMStVf7c02MCCb6SfxdayuTxrmUl/RjGpyIsPntoA5qoW?=
 =?us-ascii?Q?GrYXzyxC91sFpTcA90DxGh/j/dkaSp2M/nl6V61WBuCJkls2WNdztxfzEzLC?=
 =?us-ascii?Q?ki4L82VpVa7QlCsdqZEjF18Q21FmBgo+w+Hu8n0YNQDwydlcnKNKY9S5wwEY?=
 =?us-ascii?Q?AALy29nN9PWC7CH79R5xQUEnIsu+J0QcQh/MblK+ImWTFka6Gn0GP1NAvmQ6?=
 =?us-ascii?Q?Pi+doUOngWTrSpdfEHT35Q9XYzvPpJd5awgvIglgOZgUu9JKSpiHgfRfPURp?=
 =?us-ascii?Q?wS/A5gUnKdDFCwkhbrZg6n7zt+xEi1NyjSMj0vEc+dzE7JTLfTTIwav3dVZM?=
 =?us-ascii?Q?LtpaKlAuvTTQN5yeiSksGZwNSaoyTxUKy9hZD9089FbOk1NnOAyvhLu+kjrs?=
 =?us-ascii?Q?CES9EVfvBB/3xDijeAFq/E9wxGYRq4BGsoB04ctuD8ZZUhFY/pRMbn5dAH3i?=
 =?us-ascii?Q?f0IorOqgZVFSAQJ0o1xoQEVqYKjGelb96ebFqAIpQwbpByfZOA8Af34NrYQN?=
 =?us-ascii?Q?ThWkQn+fiUuDcoUqquLMNzWLe9SVc9WW6ZB1my5NxEjRDoxvUKBYAv72MJl2?=
 =?us-ascii?Q?jC260IO0QAKCcpWh3ewvFxA6Zl39fRO3ngsWo4od7Mc3Uih7bjwpUJcpe1f+?=
 =?us-ascii?Q?SqaY71WwR7JI2UM+yx1fpOx5QTN4OTkBkYwtmolQtOrX6O1PDGqEpCmsZj/6?=
 =?us-ascii?Q?y8gM2U2lRG6eoG3XkbYDRbI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LHhlJRHk+/ArFqdMg8EAPT/HNB1+FX1DvVC6LOVF0i4Euj4SBDBEexmzTZU7MOLmuLMRlyRLGh831wKVpGf2QWEeirX1jiMiVSrnoxRS2FtrHX9yUCYgecP4n20nwCTh5p1EQhx8hnd3YJ2hGpRzJPiA7rU/p4+NE4t0COCHyLJ7MEMCnPOfe8CjQ4aTORwyg8MM7cgjL4r/s8YTw9W//Z6Jaf3XIj5VCQDdZoVLr193vAyYeQ5pNgZaZlPx78pN5QFqTyZiZnpzMlN2BFufIQPJZmUAjq6R2isqX9Xwbp0+7H2d38EiUVnq+8I1wVGU4VUPno0x+bk8vyx15cyht9pbWJlJoIkZihXQg6cJxxDuTsyZ28GluQQxW/pnVu8LznNM7yOymkeBNECnYMvDWCPrIn5MOUjT0YTlqtzvU9SPZESiGHhPNB4dK3rzqu77y17XjyM0PNx7f9DnfBiAwObDWe5dSxBnFNmFfMFM0uVFd58vjR1TcLxKJ5LN/uL0i2C9xk5IJ0NcBr7WqjN+Zj6TNWx92YUwNO6kWgtJbmgskHcbzrxwqwqI+k+OhUOsb3KKxglp3vtMhU/Dk4v2TO96I77rvVxTiq2jtI3h55A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86a5354d-8fb9-4238-9b0a-08dc68929599
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 21:23:16.6290
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gcun5AEquiOP49UqwTrgbrGpNQzcsjAvBxRya+xCWNH7Xj5cfgpLlYyss59x4og7a2dp8HuxZKXOci4FmH5sRsKFZq9U7sDLR3q/MhJwqe0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7232
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_18,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404290141
X-Proofpoint-ORIG-GUID: Gap12bIBPoivhKhZwvTXszK4d7I94btv
X-Proofpoint-GUID: Gap12bIBPoivhKhZwvTXszK4d7I94btv

Hi everyone,

New version.
There is one extra patch which implements some code improvements
suggested by Andrii.

Thanks for your reviews!

Regards,
Cupertino

Changes from v1:
 - Reordered patches in the series.
 - Fix refactor to be acurate with original code.
 - Fixed other mentioned small problems.

Changes from v2:
 - Added a patch to replace mark_reg_unknowon for __mark_reg_unknown in
   the context of range computation.
 - Reverted implementation of refactor to v1 which used a simpler
   boolean return value in check function.
 - Further relaxed MUL to allow it to still compute a range when neither
   of its registers is a known value.
 - Simplified tests based on Eduards example.
 - Added messages in selftest commits.

Changes from v3:
 - Improved commit message of patch nr 1.
 - Coding style fixes.
 - Improve XOR and OR tests.
 - Made function calls to pass struct bpf_reg_state pointer instead.
 - Improved final code as a last patch.

Cupertino Miranda (7):
  bpf/verifier: replace calls to mark_reg_unknown.
  bpf/verifier: refactor checks for range computation
  bpf/verifier: improve XOR and OR range computation
  selftests/bpf: XOR and OR range computation tests.
  bpf/verifier: relax MUL range computation check
  selftests/bpf: MUL range computation tests.
  bpf/verifier: improve code after range computation recent changes.

 kernel/bpf/verifier.c                         | 111 ++++++++----------
 .../selftests/bpf/progs/verifier_bounds.c     |  63 ++++++++++
 2 files changed, 109 insertions(+), 65 deletions(-)

-- 
2.39.2



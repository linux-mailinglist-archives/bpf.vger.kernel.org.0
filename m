Return-Path: <bpf+bounces-28679-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329748BD009
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 16:23:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE320284149
	for <lists+bpf@lfdr.de>; Mon,  6 May 2024 14:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C063513D62D;
	Mon,  6 May 2024 14:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DRU0nk8p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jWK3SxYl"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C047B13D62F
	for <bpf@vger.kernel.org>; Mon,  6 May 2024 14:19:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715005201; cv=fail; b=XIBL4pLqJdnpF/+q0SjLMn4IUIrRv0KbEo7hsl2f7hi6g+t1JALMcQHhDhbGKUzacFyIpDCzoauv8PKpRvS7CacTVD6BSvghVEegJqgQLWd5RWQcAriSiWN0NTIlp25292LhAfGTO+Ec3dzmm5/7MQ2iM3HjnO7u+yzOInrgZ/0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715005201; c=relaxed/simple;
	bh=Z+GTNCEUFUoLKGxWAuSx3nUofbCJFb0HqjLC/2OyuYA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=NRgAefOcdX/bUDzuHQcMVysqguLZcvKuvuN0NsTOxSYu03Bi98+GaC4Jpdra5o1Y6vD/c6L1P0Pdr48K6ONQFf//SBz6iaknNO3UzWeIilibiYLGdBzD4kzbyGFkHkkbXDVEGhK7xpUkkvLBFXL3nBFGTecmkGv8usdPaIwHnRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DRU0nk8p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jWK3SxYl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 446ApPnu007369;
	Mon, 6 May 2024 14:19:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2023-11-20; bh=zaCv3Qxnao2ixnnQX6IWakIgSmmtcys23kIqwMW1PNM=;
 b=DRU0nk8pxCLdWvooR3Jvjqh4gu3STkTeg2E8QSPtjxpFQABOaTPtqJPKoX+bICzFgwHI
 49Lqd1/d8s6prbkjWsRicycOgC5jITPkq0QH+aEu49nx2PnTeMXIJ+BVhfMJ0WrJDSIU
 +m0uJ3+BsWaq4OhkVGKVF3kYLKiy7Fj+bOR39ZABeyL3oDO5lnqNVd0VOsf19U8uLRSy
 zranzFHFmLNZDLVeOIxnm5fv50TaI9xNzCpAFYcd/treQSYjZY9yxZqgj1cKaF5nBiV+
 JfVrh+VrK7AAnYiZd2nB1LcXYu2GDJmz54iZSnG8ofhHFH7keC2nQkR9278UMXal+89W Bw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xwcwbtp8q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:55 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 446ECorE039417;
	Mon, 6 May 2024 14:19:54 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xwbf5ph6m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 06 May 2024 14:19:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZWd0OZVqAL+jHfjFSmFkE/cUPn9hUbIG4bWq9DwqCdKjZDEuq0Mdb2SHD+DC6dwbx5gqu8TWdwHMvcv2RMKhZ7xzgID6rMB8qmKp3lKSriX2awagyTl6OA2V1xDO4qNWEbh3MtLmuzpCWGipf4jruCdkq4+TONIEsZLl9MkJWWOJFAOwLhTk2aAB3TkHBvS6vI+L1VpiSqvvQBiMVB9YjTsE1hTIePXf9s88X2P3i4NC4kHQhu1nz/DV7yi7udmB1oev+21tAWXNI7jdH3e1v89KfHRrtqif0Muk9TAucVdVfphzymXlO7qVW93vaclpzFZKAmy+mReW+Ht8TIKcug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zaCv3Qxnao2ixnnQX6IWakIgSmmtcys23kIqwMW1PNM=;
 b=jmZyfMusXg/M/SyXHjbW69FuXRAX5o07oCdZuGylcttmPrdlMLytlUqFpSY9S+x25t5G/ieU8yIE5j0QAhQSBtlJ+9UILG4lktZjViiJdi41exoqh9eSl5Gtvi3p6QZ41jr9XTPqCKJ8EcASvxw5BXCH0y0IEMRXnAjDipXeWxK020ZbP5wwaUo3nZcCaIseFSObJ9imAtwu/QjXjAQnUxn51FTGVPmxh/7IqV1TZwGxR0huVrBy6/YwV2D7hQCzNcLu34lc0LgSd2/KTHmtMYxRHsZsl7+3n1KO6z6p7OZA+Ckvu1DUi1ypbyZvkdYbj+ubyIc6b8LllK4dmlKl8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zaCv3Qxnao2ixnnQX6IWakIgSmmtcys23kIqwMW1PNM=;
 b=jWK3SxYl4ZBr25AQIj4dnUlld6vWGgNuJMFIuaOmWXE4WFb8gnzIPhihctZM+acW8ady5TtALKPjfLQVMBKNt0L8D6gx0PDF5eI4J5Sn4v120BuuB691lpua1JM7aEsC7gOA+OJkmD/SiOVHI/7ikqQkbOUUqCIOP44DWBKLiek=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by DS0PR10MB7173.namprd10.prod.outlook.com (2603:10b6:8:dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:19:51 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Mon, 6 May 2024
 14:19:51 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>,
        Yonghong Song <yonghong.song@linux.dev>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Faust <david.faust@oracle.com>,
        Jose Marchesi <jose.marchesi@oracle.com>,
        Elena Zannoni <elena.zannoni@oracle.com>
Subject: [PATCH bpf-next v5 5/6] bpf/verifier: relax MUL range computation check
Date: Mon,  6 May 2024 15:18:48 +0100
Message-Id: <20240506141849.185293-6-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240506141849.185293-1-cupertino.miranda@oracle.com>
References: <20240506141849.185293-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LNXP265CA0010.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::22) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|DS0PR10MB7173:EE_
X-MS-Office365-Filtering-Correlation-Id: d172c9cd-e438-4bd9-407a-08dc6dd797fc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?OcXMzaV/pAsIkkd+Fqd7vQe3Nl/lrRq20do3Fp3QaH0eqKkvsVUCM1URfuzw?=
 =?us-ascii?Q?pHg1vM0NrKbszryiM/AlIvOgSvW2im8OchA8OwY74GAGJzCpdYHa8W5rk/up?=
 =?us-ascii?Q?ouwgVKNRqivAp+FFM0gv7TPZ1nQLGI3sH9IkUBP2e5Nue8ZG+tn0Jn+0QHcM?=
 =?us-ascii?Q?mIPw6GzOk6k9ImVIuTv4Ic7V6RCA5+MJScr+6fmLUow3iBnMD2LBCA2qijNX?=
 =?us-ascii?Q?87cXstJ0j86saA1z8IKKT5nFlqqhvRg3+YD/3N5+JkpRJuLO/GU6HvAuRvOA?=
 =?us-ascii?Q?ZD9Y5Gazx0vflBg/rvw86FYl+/mqjYQIAJyYHWV5XRIpm5ErQ32inYKsGB/7?=
 =?us-ascii?Q?+xO+yfdjjaX98uVTSNmHASD8I/SZXt8PVYPsU/JiL5Qo2TYkXaPihg247JtK?=
 =?us-ascii?Q?AYu5bFMEpeO2vYAKsRW8apyC2V6gYCF9ZYqOY8np9Vmtko2z8zRurwr50S/5?=
 =?us-ascii?Q?uU5QXXwimeNMjrb4UZ4409KtXiOQ7h1OVlnzIxLhNuoF97HwugHIsGX2OmWH?=
 =?us-ascii?Q?R7Eq6cjLfkiEV4/Giv8femLPTmFi4rSK6sQqSy1cMvecFhE6wqzsOtx7TP3d?=
 =?us-ascii?Q?bPK3JPoTWV7foCHax39FQ+HN+HApXaYPhJsWefcJCpIpMSIJWJW2Dgbbp6rO?=
 =?us-ascii?Q?5K4Egvot8vWegcvrwxVW2re0Gh/48wnVBMxHK9xK1rVElSEEG4olAtJ84nj4?=
 =?us-ascii?Q?z5mBkPf4OvQ8D3h9hROIQCJnT656Veu22vt5M5agagguHLGjrbZwxznLy7kX?=
 =?us-ascii?Q?41NOR4LJ+jvHvS0BoA+BOcNfEI5uaKWnoPJ11m/w416J52DAM7zLBVncOKbn?=
 =?us-ascii?Q?ToH6ZU4DOl0+iAevwl6NXQQZvhaHp4Z6JjsrwOOCuE31dzOj4fPCaiwLw+B1?=
 =?us-ascii?Q?HOBIfTJAy4JYb8sSO1tXAVVNl+cXWzs6NJniW5Obwk4DzloSv4J8oU4kQAE1?=
 =?us-ascii?Q?LdFA330vwtvILGk214NC+/vgylNaLgfLBwjdUmeF78KETv5kJrK/p4Tv2u8n?=
 =?us-ascii?Q?10kCbXNk00NC+F04OFJ22Oup221E2T3ana10KJdxuCu5x8GMZdJ5mPnBZ0ba?=
 =?us-ascii?Q?xrKJIUCK9hEfyyP0MWr4CG+Lw0I/wtCsbiDSqoAXPAiCpWeBdcs5ZDVpWJiq?=
 =?us-ascii?Q?nTMHSbGhN8dNsWb1khvnToNuf00ORr14PDKfXilA+zFCTsrn8twLKe6F884W?=
 =?us-ascii?Q?BHotdTFJFBpGiqJqjJZdc31wXdjterQN339n0vFlKOyZp9U9zkyzLrm+FODC?=
 =?us-ascii?Q?ZhX87/uQuKWBbIKHlFOMAyF6lnP4HSMQ7vTaU6YgVQ=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?cVkPyzx7FDG5hSLvktNhIbgVFKEy5MEs1PMjcHqXXTRIE80iejjoGN1NrcIR?=
 =?us-ascii?Q?4LygmO3TXIv2YmL3B61QzCaw4/mSQAPUIZfwCs2sGwqpqjlrGDS+LJQ/Ngut?=
 =?us-ascii?Q?SHY8C8neCHWzuZ9YD22OCTpFa6q9QxsFBMFHLSM7h5IzYL/66ImVAwgMj+B7?=
 =?us-ascii?Q?cggsnjnKmcC3Qj2qQ6uEtQpbo7zWeCRTQjd8R/euWDurtwWyonf/4ou5ZgLc?=
 =?us-ascii?Q?dx4KdUr2a8rC3ypswnD3vW6dhWZw4RI27/d33YPVXs83ruvbHcZXd7C09Jhz?=
 =?us-ascii?Q?1bOd5lvjUX0Eq12czDNqsYVk85jfsJuAtOZ+iTxxWho1zwt6s3HftSIA0i9r?=
 =?us-ascii?Q?55W1X623UhOgdtWDkgswyArDybCZ3gukYGnjCQGRo2xHF6DUj/2qpMhBIKCi?=
 =?us-ascii?Q?DDkzJqaFR5McRcY62uJQFymFYht8sYxX8bUNgIspiV+yAwnglsJ2Vb8An+EI?=
 =?us-ascii?Q?94gXQMjQewdW684HN42gzidV9NKDIjtSRh5gYjVTeQYnqjaHcsxGXa7Zvuup?=
 =?us-ascii?Q?BH0tdjd67TUdqcgfeKodzrwpxr+g03gZxMtXN1ic0ZFvJPBVoAHNdmnvp4iQ?=
 =?us-ascii?Q?oI016x+FcG4uRKViAkKETEAFSDL4BkYEiAQfZASuQQ4M9hiFArHZBEp/zltX?=
 =?us-ascii?Q?6sqMqhybipRoYFgmelIl3j2ZoRqy54fyC2pRpk/QHwRCjN1r35qLHtlXkQsD?=
 =?us-ascii?Q?vJFnoQy0AmbOVqnqnCiGX68Leaio94bjp8mJ4nhwsHFC0LwJX5g/YliPkOwl?=
 =?us-ascii?Q?l9kGE75Myf2o2d43A3I5EiR10jyXYyXSVBAr53hgKXB8rzy6qGhGZH22VuSD?=
 =?us-ascii?Q?xsBEv+VXRVMCLfZz57R7StZQu/4M/2JsJucDg0GYAVoNbGg5zlZ4bq3m2KXx?=
 =?us-ascii?Q?Hqu3J7FBMfefZRYPWzfZ9FzxB4fWfHLLis5kA8P8b3A3ZFgRTgB5IgDE8vgo?=
 =?us-ascii?Q?ipju83bIkZexeQ5z/DXXRPgLDzmjbcXz7YqyMTjsxIpPlvxqSvdkOghJG/zC?=
 =?us-ascii?Q?hH7GtmExjm4S2sQiAPcyqG5VgtKrmzu1SBMkzQVJEFw5LzwBII9QkKu/867V?=
 =?us-ascii?Q?jMetKiW22rstBW9qYim7XWr/6gHhq+aHHEf/J0Cim5tOTW7tGHrYdYuTWI0A?=
 =?us-ascii?Q?BNwBRfah2NRQ7KolEIxLTIjkOBZFFLvXaZ0/6OaGcHOH89YhN8roaTaTL5If?=
 =?us-ascii?Q?KqliyM9VA/QNkVjU/w7iWe7+IZHpk2beQ6l8HFUswpv0fBsb/YOFtggobxj6?=
 =?us-ascii?Q?qv2oF0tyYclsDhZZXkOTO4bu6jsydaWnohm7khqwbczAhx9LGmxAqcWwJDnS?=
 =?us-ascii?Q?nn492R7f7x/6GA5k5yTgm9mAoaHzsyKWfXCu8dW1a3vM+9U+xbO+YZTwUDH6?=
 =?us-ascii?Q?AMFialwUEUGvHjf71krZ/uNlREekJ+f7txfi+SRvTvYRIPeSGk4u/3RBV1lA?=
 =?us-ascii?Q?0oIgt5UNaNZz+huQm1YYCE5S3oUbQCA9ayv+x5PML6JDFhzqXmuZQTa1MAS0?=
 =?us-ascii?Q?1p8Nrfb3/+MAVJ1d4nf1U3RX13o/sKjxhUB0YLqGIoa3ye/Ghno4uUh4EscU?=
 =?us-ascii?Q?GvJW+VQjR3VHfbfrv8SyHFfQKXQ92UC40oCwMN8Zh02nQ5VN5AfkGmIoIOMD?=
 =?us-ascii?Q?kZdbAC9/i/Daz7FCHMR4sfM=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	hlTqM0McW2TbFR0dVvH0bMsxqyOl5X84uuDksLo0yKZp08qsbV6wsqEWkrsjYD4u0S+4AECjkDni+k0T/hOqYvdn13hab/fVinKIOSzJPISYsgEfSAWXxNVOEtRWsySEgniy98/J/XuCqt8EPINzHEGOEDVQXby5rswbz21eUWrx7wyce9KYEV9eJ4jIbwo8nXdy3C90QcIzgfka1syB9XNpSz03JBJtjU8nT7OhYa4oAWkZCnxOrIuA1CgJidTkXTCCAn+UVTOp8uB3S0YDxQw635SUX8UqYPJaqauabDFxH7omT38IhIYPloiHGcOnWytCTVKtEhDgOorKf7GT37AheE6hTV2w1/E/iAsgiTFQZKQiPCx/h/EfmkPS6rIynAb+/U+6OQCKYVr/G6613Fyi23u9QrsdVqx1X5ZbOncJ9QoyXfudOb89pE1wHxiTwB6u5TV39FHebtV5qo5I/KmdB38+aE7zjCfQr1/J7Z7O2gkzxs2Q53wxCNBblrxc05JLUukis+HyWQuNRElhOjfYtxOGtgRTRIfCFPdCOiT7P5HJ4Sii38rvPQnTdEZXcxNkarqFRX9E1gOa7GZhB5lp2j0csW1nGuprX+6cgQk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d172c9cd-e438-4bd9-407a-08dc6dd797fc
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:19:51.6389
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /3Y5QAkmYYyRSQkgTyHkNvVvcYOhVy7kKXvwLoVkHG7rwp6FAWRLMGBBD8buw+RSWvgWMnwPaxKKdx4VNleSfRUvio2AI9vVImCHVmESQi8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7173
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-06_08,2024-05-06_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=999
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405060099
X-Proofpoint-GUID: HtgLdOMkZCCOHAS6kIWJMg8xdC5cENxU
X-Proofpoint-ORIG-GUID: HtgLdOMkZCCOHAS6kIWJMg8xdC5cENxU

MUL instruction required that src_reg would be a known value (i.e.
src_reg would be a const value). The condition in this case can be
relaxed, since the range computation algorithm used in current code
already supports a proper range computation for any valid range value on
its operands.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Acked-by: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: David Faust <david.faust@oracle.com>
Cc: Jose Marchesi <jose.marchesi@oracle.com>
Cc: Elena Zannoni <elena.zannoni@oracle.com>
---
 kernel/bpf/verifier.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1f6deb3e44c5..9e3aba08984e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13902,12 +13902,8 @@ static bool is_safe_to_compute_dst_reg_range(struct bpf_insn *insn,
 	case BPF_AND:
 	case BPF_XOR:
 	case BPF_OR:
-		return true;
-
-	/* Compute range for the following only if the src_reg is const.
-	 */
 	case BPF_MUL:
-		return src_is_const;
+		return true;
 
 	/* Shift operators range is only computable if shift dimension operand
 	 * is a constant. Shifts greater than 31 or 63 are undefined. This
-- 
2.39.2



Return-Path: <bpf+bounces-29092-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 763768C012E
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 17:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D1A28261F
	for <lists+bpf@lfdr.de>; Wed,  8 May 2024 15:42:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E758127B68;
	Wed,  8 May 2024 15:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Pv7CwJmx";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KLG8mFHq"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6002126F3D
	for <bpf@vger.kernel.org>; Wed,  8 May 2024 15:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715182918; cv=fail; b=oCP0UhfABrNdQwDobaC9324+CCJuLcFCC96OBMK7L7i+d/+9eDNFY2OabteodnA94ouEezVWxD+a62H2RBOKpZsKZTAJG9Nwr8WWsI3x6Sn7mVixQ/ro/i4Fm/eK3XoVgG1txCN+lHFcrWMhN27gSIB5DjGjnjCAhOQQ9RFJWNs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715182918; c=relaxed/simple;
	bh=13qNrKnsQW7TV5SDq84WOH5DUi5Ox3mipHWNj+ljxwQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pj6VK9fJ4EbiYsOszNWyE1s/IYpwnUrdlRJsnSkZ7OW6/zq4RiyErn5JSI1qWRyTcZiqzbIq89kKET+y/jjw6/Ytj1/E0THRFcHQFxfCOpvXTxKa3IjhybfAFlRqscwfNMflszVLmol6WAkkG0FKR04mkjt3nP87qLCY+k0B4J4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Pv7CwJmx; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KLG8mFHq; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 448CNw7p007812;
	Wed, 8 May 2024 15:41:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=mHuXd2xwGWbZxsCH9YRi1SW1Ib5MwV4o7yVXgU5CpJc=;
 b=Pv7CwJmxcOn44EY24YjZ81C+yNHrqbbDq3Kbb4ys0SNjNl9w8uwwT9wkzwaa7f0mN/71
 t1dJ/5Wbjtldf6SsCKqpMQY3WPo4zhcVL8bkqgModm6HbMSf22H5DfO5rwxt712DLiKf
 h0YK76S37xvLkbL7GjEyDTmlKTDDAx7HL+O2HuTjSOXI3LM3zfBPM8CqzN6DhePvUUqO
 Wbh+j+BsSCQXHtYX8vLMgRLxZ1VqNgwu1eB8MdT33Jm5oIncRtgrRzGxwbBpWaoLzjdb
 AKFQ2LOwvYQQTCtptWtNi/AYShGwLFBoMpc1zZlRub1EAS8U0d5EnZ+6LapOdcsBmL0k GA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xysfv268g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 15:41:54 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 448FdetI020007;
	Wed, 8 May 2024 15:41:53 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfm84qh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 May 2024 15:41:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eOz4Q9zYoaRoNDwST97O9jIm/NumRvcu0GhEmpySPhD8ZYQUzuHVtmGEAJHW+U8dSlF2Nk0bbYS2f/0LYusvND7aa5+rS6qxznRV7veyie3+sqzTUcL14fz8dGbchmG3/FJX8SIqHm5p64gQsNotOm/VIE/s1v8r2YNT/ZLM9doOc6IrXlVIVwBTEsMbeAU2hFFpVReQZ4ODUmSnM/2VxfszTdSvX5PGkRZRIIbuS9pwaSTA5w/mKgu/TIUrB2WQNYwtlUtI8FM+NEKHeHaY7qkfIL0bpzZ5t6QuhoGvru5yCGG0EZHdHcXDaS6z1Pv5QWsssQJM4R38TeN8SdKPUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mHuXd2xwGWbZxsCH9YRi1SW1Ib5MwV4o7yVXgU5CpJc=;
 b=Yt+8TG5FJKNCXNljfMUPLYoAYfpcq0Sad0N2raTTsk3V0qlcmHLm+lyXyB2n/Dl6MpbJST8A5Bxnx8IE4f6hE0yvlgyNfI1HH4J1Qv1B1Q20MqgRDa915RwamKeICXJTBbR3WSvuwIzMdAXvDPQipJ6Q8JrF44yuUeB4cqNx38ujoU7/WwmxTKavegUtK/kvpF1gNyn/Gek8HoNVkkJQQ47+WdXPLfZ/ajswihDB/fLLZpo57an1gdh6OP9gqfNieBC4ye8S/q6zg8Q6OJexJNzIhi2qvXhCTlpKHoi9rVSRfqUXo+br6/TOKaZbystkqMtW2Q5KOLsfylCT11Y4Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mHuXd2xwGWbZxsCH9YRi1SW1Ib5MwV4o7yVXgU5CpJc=;
 b=KLG8mFHqiYBFw2+vrmwlEcZuz+qqJ9U3swk7GDNwcpYjqF8efuaFn5bSRPIXYR0TtC7lrFlxNf6vfG9hz5pZb4m2JCigRM1+Qcn1crxRKlrjUXFtKSnl18AIUeagYhnxwumVXWdpz4VwroQ+Z10e2mpUj4EVEpoULFftv098jJE=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CH0PR10MB5081.namprd10.prod.outlook.com (2603:10b6:610:c2::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Wed, 8 May
 2024 15:41:52 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.041; Wed, 8 May 2024
 15:41:52 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next] selftests/bpf: Fix a few tests for GCC related warnings.
Date: Wed,  8 May 2024 16:41:45 +0100
Message-Id: <20240508154145.236420-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0014.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:150::19) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CH0PR10MB5081:EE_
X-MS-Office365-Filtering-Correlation-Id: caff1ab1-ccf8-4b8a-3d8b-08dc6f75618a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?eGdsQ3pvNWFaNmo4Ukhma2VKRFdsaWtPQk5pZXhNbDlnbFZ4YnMzMzNBbkRl?=
 =?utf-8?B?WWdwdW1nd3BHNFZDQ2h0aDZCUlVhaXpjV1AvUzVTZlc5dm80THJyT2hFWkZI?=
 =?utf-8?B?cXhKMW12UHJlOEl4eVU1ZUl1R2k5NURMbjM4QUVtTFJzK3VyWFVjT28vMjV3?=
 =?utf-8?B?cnl6L0pWM1JqWjRxWVpBY09SbEJ1V3VaZ2YxUW4yZ3Rsekd1YjRZVzY0VEVE?=
 =?utf-8?B?L1FHYnNrYzRrenhsOHN5czVxbVFsdXY1bDNkaThmWjR3eGhGeHFUc2VlYVlu?=
 =?utf-8?B?V0pOd3RSM0xCalQxSVVRRFE4RzEveFV5eDRRdC9ucHE3YmkwTGVua2lnbjlZ?=
 =?utf-8?B?REd4eVQ1b2FIbDd5b3Y3NE14bi9XVkU2QjI2VnFrZnE1cVJDdkxhL29mZkZV?=
 =?utf-8?B?cjhsRFpSd3JFaUF6RTJabklrV1FPdENPQzh6TjlZZDVhQWNieXRqK2NRUEpt?=
 =?utf-8?B?WEYvN2gxSlVmQm82aVJ0dGdWT0hGVUxZNzgxUDhHSXB2Sk5MNjY0NGNtQVhK?=
 =?utf-8?B?azFQNFhyYmM4M2RubkZUdlFyUTZ5bkZ2Nll0clMwWm00LzBqTTdLY2RJdVNn?=
 =?utf-8?B?TjZ5SjdrZnVrMGZ4cGNXbHlYbStKTFZISnlkZ3N0aTliS2g4Z2xkOTVSZEdk?=
 =?utf-8?B?NGpHb3FqR0ZNWnZ5R2FPQ09jUDZRR283eWp0RFpQWVpRM0tLT3lRSEhTRm9o?=
 =?utf-8?B?YW1ZZFVYWmFZNmFkdVhlMnVkNStYQkVkOEcxUVZKTGh4bElpS0dHdlR3aDBr?=
 =?utf-8?B?bnQzSG5MdVUvNTRwYWpYRHhvY1FkSWNCQmtJa1ZPZ3ZpQ1dQYUJKcnlKeEYz?=
 =?utf-8?B?TmlibjJvYUNJeThSQVRHY2hQWGZsMzFRaXhnNXhMRjJSZEV5L3RQNGsrdDRU?=
 =?utf-8?B?OG9OT1A3ZXNyWnRjM1BOYmh4ZlRuL3I1QXlYOGZKekdpejZrQzUxL3hVTDdr?=
 =?utf-8?B?TDNGT3duVzJkRmg4T2ZOYlJNTm5rS01TbnR3a3M1cFo3Z3JlbklzSmJwby9J?=
 =?utf-8?B?OCs3dlFieENFdHNiQ1ByU010TVhzWWxlalpEcERiSUc4bVVMUjdWUi9CZ09a?=
 =?utf-8?B?emU0V3hvcmcwNXg2bkluQXNLRmlqS1pVaUlYaGhRY2ZuRFppaWZuV1VVN0p5?=
 =?utf-8?B?Q0pIUmkyMWIwaW8yQ3lFaUNSRWtOeVlHeFdoZHJGRytuT0tvY09VU2FON3FI?=
 =?utf-8?B?RkFuMEhHOGdFVUM2NFdzOThoQzNnM2xNem9QMXNPTm1NSW9naW91R0R1WGdL?=
 =?utf-8?B?SUV6T3BKN0d3OWw2Ymd2OFEzK1I5MVVNTWoxWTVyaXF4NG13RHdEWGE3SzJa?=
 =?utf-8?B?Wnh1TFpabncrdzRGVHpIZnRIelZIYVpPc3JPUS95ZG5pNzMvb1RmK2xMODZq?=
 =?utf-8?B?b3lqWC90Z0ZYdVJDTmN4dTl6WEkrMUViNVJHc2luZWtCY010VkFkT0VNTytz?=
 =?utf-8?B?RHdCQjZWRHB4d2FtbFczY2pNRVM2MFVWRjlNUXl0bC9YWWswOFpaSElHc2hH?=
 =?utf-8?B?QmJSd2E2M0x4VzcwdkhaZU51VURhMmkvRlNKVDhHa2ppN1ZuZzhLNnA0T2l3?=
 =?utf-8?B?R04xbFhwSXM4aTlUd3BNb2pHc2N4L0Z4MXpTZklDeE5YTE9UUjVuMEVCOTVa?=
 =?utf-8?B?YzUvNDVMYU5FOGJXTzU1V1ZwOFd3d2kwcThJNW9FUkhoeldYUzhpejVGSnFP?=
 =?utf-8?B?VXBVazBEUENwOFFKZnlrSEVaYUNLUlFZOW14VmdDNUI3cTIrTUpLR2F3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?L0ZRNmlIYytCNlhVQUxYc3lScmlWdndnMEFRL0xDWVpDTVVqT1RTVWxXSGFk?=
 =?utf-8?B?ejlObVUxRlV3cFNSbkRCM1NxUlc0VnFuSWtUNmpEWVJ4c1p6c2Y0d1JOc3VR?=
 =?utf-8?B?S2d0MHdEZFFUNjJnSWNicEF0L0RmVkVSTU9iUW5XS3FLeElUQzNER1l6bWxZ?=
 =?utf-8?B?Ry9XU2VrVUk0RWJXUHhWQnk4S1lZSmJQZVZubTRlS1N2bUo5TEFaUmZDcC9R?=
 =?utf-8?B?MjdWR2diZTcxaTFwTVZ1a0w0TVFqblNDQUxlb2x2M2t1OGUyV3FOMll1OGli?=
 =?utf-8?B?aGhiSm5vSXE3YThEeXQ5U2ZXcm9NbEZUUmlQL0VxMVAvWVVUaU9xZUtBMVhx?=
 =?utf-8?B?b3dOSEliRUkwZ2d1UmxFWUd2aXd5ZVNFeTNaZndCLzNkeWVqTVBnWTRmVFJu?=
 =?utf-8?B?ODNXR0hGbkFhc0lQVGQ5bEdtMEtBOS9JWVNucEVFR1d1U1ZXdjYvM29laDJk?=
 =?utf-8?B?TW5jU0dVT2I4UGxKbzM5L1NEMHFmTUFONXNoOVUwempuRjVzL1BSZktkcm5D?=
 =?utf-8?B?VVlDOGxjY2VWOU81cGtjNmdBU2EwcU1yaXYybHEvaUNVUnIzdU0zellVYXpH?=
 =?utf-8?B?L285bWdTSTBKTDNVTzl6RjlnWDJaMWlSVVorR1QxNHBUVWRzMUtidlRFWlA3?=
 =?utf-8?B?Mno2YVJhZE91a1VIU05uRHNMRlBWV2lUckh3by9UdVcxRGxRZGdKNGcxV0cz?=
 =?utf-8?B?QTRHRVhzUDV2aEx0d3Vibi9KN2k5TGxFYlY2bndBVVlwSzJoR09ISEdCdkhq?=
 =?utf-8?B?VDY1T0Q5V3djMFB5ai81ck5TVTQ2bWhjNWdLc0dzTkJxSkRRZnhXcVYxM1BI?=
 =?utf-8?B?emRlK2IvTnY2UWJic3BPdSs2MDhpWUtiaE1ETEMyRFZIbmFKeGwzeXlGdlA3?=
 =?utf-8?B?VDFNRkNVNHRIZGFVSStGQ0FDRmliZTZaVU9IWXVYN3ArcE0vQ252V1U0Z1A4?=
 =?utf-8?B?WEFheVZqdW93WWhvMW9sOHZOdFRlVEFCUUFhWXdkY3BDcHRtcmt2RnRBdVA2?=
 =?utf-8?B?dUlhbEI2YUtOWk1TNzZ6MWhQREYwWFRFUmZwRDhVZmEvdGxVNW0xNm00QlhX?=
 =?utf-8?B?OTVFSm9pZFB3YnlCQ0hRNk9HazRHdjkrVmxjUkFzbUt3TjUyamxmazd4RTBq?=
 =?utf-8?B?cEJWa1lIWjU2S0xSYndyU3lTa1NsOXQxeUFlcXpxamhhOEswdEZsdi9VczhD?=
 =?utf-8?B?UFEyajlPNVVyNk05NVhIWTdwTFQ2K0hSWUpNZ3Rqbm1qY3hTRnFWTmRQQW9P?=
 =?utf-8?B?M3lTUkpTeUo5Kzg2eUdhblNWdnU1RnB5dE9SWVU2TERTWEl2NmFxaUJ0Nktr?=
 =?utf-8?B?WVlqQStJYk9xQUVwSzhpNlRiQ29aUG5XN3B6TlNuaEtmeHF4TGljaG9HRXd5?=
 =?utf-8?B?eWk0d2ZhY2YzMlZsMjJqQllPaHRXQlhMVVZKYVpqVE1VNVlzQmhQYXRUazVU?=
 =?utf-8?B?QkJiZlcrQTk4ekxzQjhOUTJoUklLendqcFR1UEI4ZnUvTW5WaDl0eHJVY3hE?=
 =?utf-8?B?THh0VHhhNytZb0VaV1FYUFA5NGluVTdRZjdkY2Foem5nRmRFQVl0MzVIbU1Y?=
 =?utf-8?B?NE1lMldDQ1k4Tmw5S09vODVzTENRZmpINVhiYlVjb2tqMVFjSmNOaDJFS3U4?=
 =?utf-8?B?Y2pYZC9vMUhWanBTYTV6eWpCRXQwSWl2alNkVGkwNlUxeGVJd1dMaFE3NVl0?=
 =?utf-8?B?dUNrWk9zZFhuV3l1YzhxT242OUJjWW9FRHNuSDVrNHV3T05GSTBtMi9PR1JY?=
 =?utf-8?B?SFZKZnVzQlpSZE45eENaUkV3VG5qNm1VSlZBMDdwOWpnZ2IvRkdPUGFxUVg3?=
 =?utf-8?B?bFRiNVl6bjBPYURvdUEvaHpBS2JaelBrZmhkSHdZYUZQTVNHczVIdnZqSWc2?=
 =?utf-8?B?VkV6T3RmeVY4ckE1SWpuNHY3N0p2ZEJYRm1ncFE4MDh6c0hCVStwejcraVox?=
 =?utf-8?B?dVhsWWV3a3dRWFcwcWp0cDBYK1lHK1VFYXpDREtuK21jaDVGaVVyWWFiaU5L?=
 =?utf-8?B?K3NQcmFGckY3K2crY28wVXpPRkhPeVAzdmsxYTVnUyszVkVlZDAvZnNhSkxZ?=
 =?utf-8?B?dlVwUXNYYlR6ejBLUEJHcmpZTjA5ZUxNanFjOG8vUDdWQWlMcFBGdU1QTTZk?=
 =?utf-8?B?VGp0cWZqQnBPV1BZK3NTN0ZNUkc5dys4K3oyZ0hyVU9OeVM4ekt3RnBQZTM0?=
 =?utf-8?Q?pBtBFn8HTMyIoZ00R5sLxO0=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	LIk4Y6G+b1EeduioAJbgkQ/KeRIFh/F7ZpO+bmZu/Q9vSL+XO67YHOnKmLVScQ9iuexjkjLC1WRHjpeiDBPfNpSbanbSRfr2kfUfbMZYAZWLaSZALzXCJEuUJCbIUBJRDNnWFQQm5G8rYL/M5k2TqZrJg7p8Ig+RdEMWJtb4wvkBFqpsOu7XCHLLUTasn5TE2Om2pV9D83QGkuoAZSsyoxTytd4X5yk101KeAbIF3wr8vP1/M7EXypl3wKbCIlN9SOhcH5KSRA4cidoLNoPnc5CXCjBhdHfVCo1wsbNNUDWTFQS61QfWxMmGGwu6kavi0Ftauf0ZSlVFF3duvnKv9fRs04S0Ze9eW1ZaqFHS99ADGGW6yw51oqwwrdMQ0+s0KrJMUZj9nQTtyo4N8aGntXQjgkokWWK2ksra1N03Q8XyJ+pFuLyXLMyMBDsA3krZ2310H0w8w2o3lBVggscs8UYgcHP79IB8SqBsrMzPcwg7JV7sSf83Wq/TCCCVB6eLJHX4+sK7CJaBTY2uZcDbq2xWyFjY4G9Kdb3RGWMkfAHUYY75ruWNkvrJfXq4XqKTyCwmLyI5YybyamOancMy8ihN4iwA3HFd5ZfizunjH8A=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: caff1ab1-ccf8-4b8a-3d8b-08dc6f75618a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2024 15:41:51.9952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LC8XNvEvyfq4hqJZpANs3gpxkFO4a7XKfMt+Uo+rFhCztVOGB9kn31ErC5u+vnoX28eGZToL4J4/5Q6g0wcM8dlrpOiW5yiEQeQRYEXpsUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5081
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-08_09,2024-05-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405080113
X-Proofpoint-ORIG-GUID: OyBtTVcEUCIb1MITcjYkhyA6SK6b2aho
X-Proofpoint-GUID: OyBtTVcEUCIb1MITcjYkhyA6SK6b2aho

This patch disables a few warnings to allow selftests to compile for
GCC.

-- progs/cpumask_failure.c --

progs/bpf_misc.h:136:22: error: ‘cpumask’ is used uninitialized
[-Werror=uninitialized]
  136 | #define __sink(expr) asm volatile("" : "+g"(expr))
      |                      ^~~
progs/cpumask_failure.c:68:9: note: in expansion of macro ‘__sink’
   68 |         __sink(cpumask);

The macro __sink(cpumask) with the '+' contraint modifier forces the
the compieler to expect a read and write from cpumask. GCC detects
that cpumask is never initialized and reports an error.

-- progs/dynptr_fail.c --

progs/dynptr_fail.c:1444:9: error: ‘ptr1’ may be used uninitialized
[-Werror=maybe-uninitialized]
 1444 |         bpf_dynptr_clone(&ptr1, &ptr2);

Many of the tests in the file are related to the detection of
uninitialized pointers by the verifier. GCC is able to detect possible
uninititialized values, and reports this as an error.

-- progs/test_tunnel_kern.c --

progs/test_tunnel_kern.c:590:9: error: array subscript 1 is outside
array bounds of ‘struct geneve_opt[1]’ [-Werror=array-bounds=]
  590 |         *(int *) &gopt.opt_data = bpf_htonl(0xdeadbeef);
      |         ^~~~~~~~~~~~~~~~~~~~~~~
progs/test_tunnel_kern.c:575:27: note: at offset 4 into object ‘gopt’ of
size 4
  575 |         struct geneve_opt gopt;

This tests accesses beyond the defined data for the struct geneve_opt
which contains as last field "u8 opt_data[0]" which clearly does not get
reserved space (in stack) in the function header. This pattern is
repeated in ip6geneve_set_tunnel and geneve_set_tunnel functions.
GCC is able to see this and emits a warning.

-- progs/jeq_infer_not_null_fail.c --

progs/jeq_infer_not_null_fail.c:21:40: error: array subscript ‘struct
bpf_map[0]’ is partly outside array bounds of ‘struct <anonymous>[1]’
[-Werror=array-bounds=]
   21 |         struct bpf_map *inner_map = map->inner_map_meta;
      |                                        ^~
progs/jeq_infer_not_null_fail.c:14:3: note: object ‘m_hash’ of size 32
   14 | } m_hash SEC(".maps");

This example defines m_hash in the context of the compilation unit and
casts it to struct bpf_map which is much smaller than the size of struct
bpf_map. It errors out in GCC when it attempts to access an element that
would be defined in struct bpf_map outsize of the defined limits for
m_hash.

This change was tested in bpf-next master selftests without any
regressions.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/progs/cpumask_failure.c         | 4 ++++
 tools/testing/selftests/bpf/progs/dynptr_fail.c             | 4 ++++
 tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c | 4 ++++
 tools/testing/selftests/bpf/progs/test_tunnel_kern.c        | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/cpumask_failure.c b/tools/testing/selftests/bpf/progs/cpumask_failure.c
index a9bf6ea336cf..56a6adb6cbbb 100644
--- a/tools/testing/selftests/bpf/progs/cpumask_failure.c
+++ b/tools/testing/selftests/bpf/progs/cpumask_failure.c
@@ -8,6 +8,10 @@
 
 #include "cpumask_common.h"
 
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wuninitialized"
+#endif
+
 char _license[] SEC("license") = "GPL";
 
 /* Prototype for all of the program trace events below:
diff --git a/tools/testing/selftests/bpf/progs/dynptr_fail.c b/tools/testing/selftests/bpf/progs/dynptr_fail.c
index 7ce7e827d5f0..9ceff0b5d143 100644
--- a/tools/testing/selftests/bpf/progs/dynptr_fail.c
+++ b/tools/testing/selftests/bpf/progs/dynptr_fail.c
@@ -10,6 +10,10 @@
 #include "bpf_misc.h"
 #include "bpf_kfuncs.h"
 
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Wmaybe-uninitialized"
+#endif
+
 char _license[] SEC("license") = "GPL";
 
 struct test_info {
diff --git a/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c b/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
index f46965053acb..4d619bea9c75 100644
--- a/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
+++ b/tools/testing/selftests/bpf/progs/jeq_infer_not_null_fail.c
@@ -4,6 +4,10 @@
 #include <bpf/bpf_helpers.h>
 #include "bpf_misc.h"
 
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Warray-bounds"
+#endif
+
 char _license[] SEC("license") = "GPL";
 
 struct {
diff --git a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
index 3e436e6f7312..806c16809a4c 100644
--- a/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
+++ b/tools/testing/selftests/bpf/progs/test_tunnel_kern.c
@@ -13,6 +13,10 @@
 #include "bpf_kfuncs.h"
 #include "bpf_tracing_net.h"
 
+#ifndef __clang__
+#pragma GCC diagnostic ignored "-Warray-bounds"
+#endif
+
 #define log_err(__ret) bpf_printk("ERROR line:%d ret:%d\n", __LINE__, __ret)
 
 #define VXLAN_UDP_PORT		4789
-- 
2.39.2



Return-Path: <bpf+bounces-29493-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 555728C29FF
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 20:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09B54281D5E
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 18:39:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19D8F3CF4F;
	Fri, 10 May 2024 18:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FoVOebMC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l4gFS/2J"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A72918044
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 18:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715366346; cv=fail; b=KRjMOzUsWmdGXholMsrqoKLMd0HjBKvE1l/6fP6ihaYrtEthsO5g4MeD2II1SMYCFPEOGFV92vbOgNdrlMKELIwxmhtTBcWKW0nL1tJySwHxc7TX3cIELCm0X7AJ4dhuYI7goety1hhcnYtUIBrA1aLMO+T6w4+1Lkz6+DWpvyo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715366346; c=relaxed/simple;
	bh=hnk9VyJBXYA2qRujZdV4zrE9U4nJBdRLnxAyjft6k7Q=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Uz/l8e8rvOwA6XgMVSfoDoVZ5Ao/aWBKw48JI9PcwDf2W4ZqACn+H/cbHTZxf8gXU40rR+aESKkOotiMIqynBA0qpXDpNYMzLRmBy70IqsCbsqCNBXaGbc9wwNK3d2627hzVa6dOddFZFFM4/6Mfw2M13bisOwkprNjjer+114o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FoVOebMC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l4gFS/2J; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44AIZx8c016912;
	Fri, 10 May 2024 18:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2023-11-20;
 bh=6zmlpYyD8Wo5T8K56jP1ByJfpsv0c7a9cF82TXbPQRs=;
 b=FoVOebMChlMuQHEmN4T8SLajFslOT0rxLz0xS2hm36/qoNx+LTSbEzU/U6Myim97L10+
 C7k1vwGrkzqP3j3ZDAEAGvGcG/fl+Vs8tqmX+M8dzw1zJr/7zubNu47GLS3tfPP/BzVA
 TPqs1bk6sp9kFZwfRuneBT2CmhPwHerBWwX644Jj4iW4SOc5CJGylLIauZ2kHL7q+N8x
 JIE31WFMsc/3gV7fDq8ZjCF0NRo9reBl3LwaxuG6j0vVIbFabA3JycsHzn1f6vsnVN0S
 upfp5jLm2+h5Yj02tIHV56/10ppCrNMgBi6yYMxo6iLXVgiql1BivXMX3XBBi7BA7QQE 3g== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3y1r06g38h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 18:39:00 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44AIFG3D025058;
	Fri, 10 May 2024 18:38:59 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xysfq4pvh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 18:38:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJojnTMSQ8X3CbRqK0vgzSPF79cQvHdrZyH5Ds7i5YDNLDuXI+3DWnu6IzEaRvuCb1/YRK282p3V5XCYkvQSsdJ5bRnzo3JHske7yidxpPBETbaY3bjmxkQtfOBj8844si+9bRmtBgvGP3kAwFDyeJFyF/yAT5+IOVeKECmXk/v9BtpGEvEVrmbRketY4tZe33FaaEorOnf2ibV75XOuu1N5rErLfCGa4mi/SY1ZH7LoQSS/A/lnxbD6kHWCFcQFjNWTUB5wH19I5HA/AytExbmrHGjrrBQez7KU+nMM7UxEo6NLi9yIHkLjyidf5ruG58Ae3+X/joR5o1r6Os37Dw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6zmlpYyD8Wo5T8K56jP1ByJfpsv0c7a9cF82TXbPQRs=;
 b=YpM1mqDN74+m6vMccPzVqT9VYIMDy2JceobW3iy7G2dfIluyEZ5trl6aDY1t4lxbC0X5uuvpRwyteegKDxwoyG8wIIqn//pcStJfwiy4Hh6F9U3dTen1/KJHzDL53KdV3NXM/P5mblKOPnh2n8Z9FYvjB9OLJtTjEL6F3jyR7plw8yhCWmqkkR/4vSlEjqu+7WesgyPrqIPrL1xnWbdRZnnvpcfuoIRnwDepbcpx/4LfjtxuAJ2q83AW3q3iMNa+j7wVHseJLGSKh+rlRT5IzSq51Ot0SPtzB7xB6TpaWf+Xz6rzYeKtHFJAgZh9uWJsWXtiXJp+qgGBDxHJd2rWdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6zmlpYyD8Wo5T8K56jP1ByJfpsv0c7a9cF82TXbPQRs=;
 b=l4gFS/2Jn2pX1SmI9VGU00BZRqjdgsChRQXuVpLCXUtlFBfRaHHVaJuC/75STd/o8yVqSpSsXlh1nh/wStbLJB0+Sfge0qsv3EfxAjbVdUzj7wIoASg23mos+xYw1F11w3GLf+9XB5Mo0I8yK13PuSjbTFkMHJ+pXEDHGBPyyBg=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by CY5PR10MB6167.namprd10.prod.outlook.com (2603:10b6:930:31::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.46; Fri, 10 May
 2024 18:38:57 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::1e11:7917:d2c:e44c%4]) with mapi id 15.20.7544.048; Fri, 10 May 2024
 18:38:57 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Eduard Zingerman <eddyz87@gmail.com>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next n2 0/1] selftests/bpf: Fix a few tests for GCC related
Date: Fri, 10 May 2024 19:38:49 +0100
Message-Id: <20240510183850.286661-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0300.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::10) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|CY5PR10MB6167:EE_
X-MS-Office365-Filtering-Correlation-Id: 34ed66c4-ab78-4db6-253c-08dc7120736a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?UUZBQ0pTYlVRd1pyc0hrSE9ROWNnQVM5N3AwYlJlMFR1MmVoQjQwMml2QjJL?=
 =?utf-8?B?Qy9aL2dRcWxjcmJnL2FGMFhYNXRSeGFkWmJ5b1V6QUpDUURzMGRPbEY4azhQ?=
 =?utf-8?B?czh2OWFNemhKcklrWUNVTzBOQ1BwY2J5TXM3SXpPOXNYVlRVMUxGVWQrUEJz?=
 =?utf-8?B?S2dpZWp1WFBNbUplUEVDblNMRXFITDFpc0lDcC9TTWp1Mk5TL0h0WCthc0R6?=
 =?utf-8?B?V2hHUWZoRWFKS01KNW1wcTRXSHVreGExRU9XeEJCekVUc0pKZktuN3BGMllq?=
 =?utf-8?B?SWN1aW83Ym5xTFJGbmJmVWJEbGUrOVljTVJIbnNQeWVMQ0U5NHJ1SjlTMVJa?=
 =?utf-8?B?bWRFN2ROZXd4VlJralFDU3hZc2t6U1Zka2JGU2lGRG1sQ24zVGxXS0Jxbm5V?=
 =?utf-8?B?SGRreFNicjJISk9ORTY3ejc2MXlrblZnemZ1MEE2RnpUSnBQdHBwU0hETWs3?=
 =?utf-8?B?Nll1SWVnYTdQamNvMHk1TVlFd3dEdkJsY2Z0QkF1ZGlkalp0REtXTnd2Sk40?=
 =?utf-8?B?RU81a3JQZjRxb2MydlFzM1RlZnorZlA5cWRWTUhDZ1hJWU1tRU5QRy82Qi9u?=
 =?utf-8?B?MllKR2JmdDNKSExjWWJQZnRjSXA0U0FWNnluWWxlU1Erb0owVkZVRFpGemlM?=
 =?utf-8?B?RWRSVFZNdXNzSnhTeWNvQzFNN0VEMUpJQ0lUQ3pLOUx5d1lwSW96U21zU0dv?=
 =?utf-8?B?UUJwWEo1RHNIcm9GR0hnVG1HMHZ3MWZUckcwUjYrOFYyb1VZbjFTdjNodTg0?=
 =?utf-8?B?UzI4TFdkMUwxZCtyU1FtY0QzSXQvUFhub0JVQ2d2ZFNWWHZ3d2lCVzU3R291?=
 =?utf-8?B?RW9HRkdWZnkzelNoaHVNVTVzbXU2RzN5Z0lvcXlzRmcxNWFNaHR6ZU9HZ0U0?=
 =?utf-8?B?Mzl5YXh5S0lvRXJERHlqRjJWUXFvMlRHdGVCU09Md2Q2RUtab3dLZ3hRZ3Bv?=
 =?utf-8?B?eGk0R1pXRlEzc2YwVThaMmJJSnE5OXVqbHhOQXhXUWN1RHp2YVRPNk96VGVs?=
 =?utf-8?B?L0t2aGtVemZCblU2bE00dmx0QW9KcTNzZkdXYmZJcitzZVBocnFlaUlnRkJp?=
 =?utf-8?B?KzdKTWpHaXRCVDYweHNXNEF3L05Gb2dCL0hZaXlwTDJKQnpKU0tNVjZkUXpG?=
 =?utf-8?B?VUtNejU1MUcxcDlRT2cyd2RKbUZFdGs5TFhqNlZHR3B4NHRVUDlQTDJSa1du?=
 =?utf-8?B?T2pNOWFRU2szL2t3eG9Sb1llMUdybENpWmhaZ1RnZHZmMlUwS3R1dkkvYzdE?=
 =?utf-8?B?djd4SmFYS0ZiLzMzdEc3d09TUzByUlhZRHpDOEhBOHJMY3dXUitGZ0hGblpI?=
 =?utf-8?B?ZkRzdmFnZE1Dc0hTcXZXd0FxelVYUEZ1YnRrSHp2aFlDUStmWDN2aHlremhX?=
 =?utf-8?B?SGJEd0VpKzFZcUhLUGxCYWs5clUyekZPd0Foa1Uxb3duNS9iVko0OHV3UDlE?=
 =?utf-8?B?dkdpNUlDam52bEpLWTIzMGdXMGZ3aUo0M0Z6d3BVZzA1Q1M0RWd4dDcxM2l5?=
 =?utf-8?B?ajgwY0gyb01nUTg1WS9UK2dXNGpNSjVXTWVKQ2lYWk5vZzY1ZUZvQTYwSWh5?=
 =?utf-8?B?R2YyMUNYRzE3dVNlS0tKL0VpSWI2QU11OURJY3BPRDhWc3FTT2lEaGlpc1Vo?=
 =?utf-8?B?aThHYm5JQTJQV1gza1NKTFBRanNYQWhVWkZkNFYxK1B2c2tpSXJVRW9YRE9N?=
 =?utf-8?B?YkY5R0l1UTArdEJMaHcvWk5sZGtwd0J1TnhIRFpPcGNTM0s4RzdUNmt3PT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?eVlqTDA3YU83amlhVXVGV1kxLzFJd0xPYmpUL01GR3VLSFkrTjRmMFhmcFVm?=
 =?utf-8?B?TmNQN0l6bnV3UzdhNlFaTytHWlpiOWVaUHNxZjdta01aMWUxb0ZjVGVRZ2ZD?=
 =?utf-8?B?K01mZEpnSWdXNVN6UWxnMXVBNmUvWFRqMmpDZFFmTzNBWUpydGJ0cjVQVGFP?=
 =?utf-8?B?SWV1aFRmbEJuVkdOUXpsWmI3TU90QTZWb2pGZHZpMzZQVHlHK3FqL09sODg4?=
 =?utf-8?B?dXNCYmhvbFVndm9vWWhkbDM3TTRQUVY5UlFUMEFKbm93NW9ZSzdUWXQwanZy?=
 =?utf-8?B?LysvdWpwSzFBazlBbnhNWWtVYU4wRzhibjlyMUZIQmJ5eDY3YjFCZkk1ZGo0?=
 =?utf-8?B?cFdxWjdLVlVacGRKNWpSSE5rTnhzMDNvVndSRkJIV0M5M0xmQVhWbU1GWjNw?=
 =?utf-8?B?WFd6RkUvRnUzdHU3YURCZUpJa0ZOYkRRUDlrcEdXTzBQa3lQeEt1MkZ5YS9D?=
 =?utf-8?B?QVNXSFhsUG50aUo3aSt0U3hyeC9KUEpJL1Z5bW5EQmREdDdrV29IbXp5RHRx?=
 =?utf-8?B?bXFTUEVyTU9DaFhYdHZ0MXd1aG5ESm05TmV6RmYvU3NoS1U3RmY3ZHo2Z1Ay?=
 =?utf-8?B?MzIwbmF4NWRkS2FXT1RYL0tpK1J6cHJhMTBWSmUvZTFPQkk2MkErbTNnTjBl?=
 =?utf-8?B?Y3FoVzRheUw2T0NYYUs5MENqM0RsSjV1anhhdVhxWUlTUnpmZTB1OXN4NUhI?=
 =?utf-8?B?UVBaTEp0RVA4d1pFMmpldmJoSEdXYWZxSzcvOGo1REF3dmhaUUE4aDZWSitR?=
 =?utf-8?B?Zm04aWxEV2xQYVloWlFjd2RyUHJNUXFDdkRYTFZFRG9lc2JMTlVNSGpJUzEx?=
 =?utf-8?B?cmNsLzJXeVE3Uk9TSFdLd2FkMVUrdFJOR2IrbWQxeXBXMXhFdUFWZUZUbXNm?=
 =?utf-8?B?VzNxMGxCTUt5UjhpZnFITjQxaWFjMEg5Z3RmT3MxZ01lZjMybTQwRzEvRjFq?=
 =?utf-8?B?RDcydlBEOUgzS3UrYTNKRUh5OHNrTG1keW1STkVXVlFhZkdQSnYrYVVaNStm?=
 =?utf-8?B?aWxlZmxPa1BmdnRxbC9pazdsMzM0Wm9ub3IvMWlxNENwMEw1cDMrcVNPaFBD?=
 =?utf-8?B?SDdTNkN0dmhETkxRMHgrdFBzcGFURWNyRWYrZDFMMWdmNFlFeFRkOXREUWs0?=
 =?utf-8?B?OG9BS0J1aHd6RkowSHluNkpNUVkvdmlnMzFTd2lNOGJrU056R0pkZ2NvQnNo?=
 =?utf-8?B?NEtVc0huKzFSZVlDRFdLVjZOVS9LdDJzTGUrUVQ0b1lJZ201NmtqT0hnb09P?=
 =?utf-8?B?dnBPNEY0TXM0V0tTV3VyRHgrRXpTVVQzb2lOOW80Sk9XRDVYWGo2ZDZMK1VM?=
 =?utf-8?B?UGsvYTJycE9pdEMzbG92UE1MaHVhbm9JdlRXMTN0YkQ1LzlNNS9oRGx4Zll2?=
 =?utf-8?B?RnlZL3A5T3ZYSDRzWjZHMnhoNm1WZS9Ga2NXeDMvczcwNFJJQ1Rhc2N0akdp?=
 =?utf-8?B?UjFKV0FuTkh6WHIyckRMS0ZKL005NFR1RXlCU2dxVXpZYllqUGo2WFBJeFdx?=
 =?utf-8?B?WHBnZUUvMDdqa0FHN2JTVmhjVytSK1dEd0pnUk42RVQ0Z3lvQXFoRjFKcmYr?=
 =?utf-8?B?MVNGNU4vY2xTR0dUYjZTTW9qMWQrai9nSmRPTGh6eTltWmNtRXJLNENDSmxs?=
 =?utf-8?B?azQ5V3h0TGNIMmxXTVBnanJvTldlNjlGdDBDODB5VkhnRGxlTVBUejUrcDI2?=
 =?utf-8?B?R1FpRittcFJEQUFkclJDYkNpMGhXQ01yWHpiTVlqSkkzYUtHV0J0WGN4TXRQ?=
 =?utf-8?B?STVnU056OUp2dkEzSmVoMlRtRWJvc042OUwwL3pYeGlObEczdjk0b1daZFZM?=
 =?utf-8?B?RlA3eFZEZFkyVS9UV2NsUS8wU2F3QmRJL1FqbUt1cFZNM05ycStRSy8vbEF5?=
 =?utf-8?B?RGlRV1ZMaldoanIya3RJWk9BWUFadFdMUkttVWpRcldMWDVsYVRMZkFjVzBR?=
 =?utf-8?B?MkpmcVRQRnpJT0NRNkNzWmRYQVZJT3hZQUNPU1B3SEdPQUVMRjk4N1RJQ3Rm?=
 =?utf-8?B?Tng0cGJoQVNGcVpHSDF3YmhaVmZDUURUU1BnQkhrMk1aS2lCOU5QYjkvUnBj?=
 =?utf-8?B?bnVwQTNuZi9HNkV6YW5WdXJybXNqaEpBWDFiT2Q4UVp5RWFIS1AzdjBkM1dL?=
 =?utf-8?B?a2t6UE9yTmVnVkNVRVNVN1RpZkltWmkwNjVaK0ZiRC9Hbk8yRXVCUzZXdm05?=
 =?utf-8?Q?HbJXZErRhAsf/JF5Ut8NNbc=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4ShdN5GyI5G6jd5j5ebRiZFcJSKHcdoOaNx42ABGzRnLJy7YPFdVKQpOI3NvV8i/8mu6/TSNbTNSjwTXOZdPdNoyso4e8M4e3CrXrbGrRdcvLDXwl+y8p8+uWK39KV7DKn0TV3xiSjHNCVIB+5HknIPiFe8HSHGvJoTSRB00BeWtCKrPVcLjVq9QNXWMCi7IX27NBo2X2MVd0euIFMT15DnCEEdRFpPNduIVXE7RwSNk1QH62Vvi0+zEjcgCZtUUnv8Lg9EyAGpbVtbFqJkQuK3xQ0EDWkUTm8DqU2cGgh1Sm5JYSwJOigcpUEBt9YVrMgJwyaJHabZr/HsvFqNd3tlFZAHEmplgWut33PRiHteQBohpEWgfSlH19Cn6+++S2zWS85o1GKzzUlOwcbKMGgJGG6hp2Hsi1Dpm1TuWhDf31jfnkCrU2Z9zhrUNVeg9q7f9wpdOhhcOSdmadWVP6WQ+7fEPdr9V2kmyu+gVr8Y8QwEvDdZca7JZhAAvOfwPp9S6tq2ApCaWbY0MDdcfkHRJda4Dgiey4DQB5yyOW3kz2ay1L30cg+5db4aP0gZD9UH6k5ZcAEO3G86zyakYYvHIgTWYKXeeRvBwR92GBXs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34ed66c4-ab78-4db6-253c-08dc7120736a
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2024 18:38:57.0527
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gx726sDMvkHXCvC3NRn0G44RLNEFULN/oiI2K4BlSuHFFNrilLLhDzC1HHQNQ+25WGHH114lOyRSPdK1doYavM3fNzZbiK5UQi6KkhQ3yfs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6167
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-10_13,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0
 suspectscore=0 spamscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405100133
X-Proofpoint-GUID: HMsEplipwH6-8n5oWtRKHGCw5FiDeIsQ
X-Proofpoint-ORIG-GUID: HMsEplipwH6-8n5oWtRKHGCw5FiDeIsQ

Hi everyone,

This is version 2 for the proposed patch.
In initial version I rather disabled the warnings from showing for the
particular tests, as I was afraid I would change the test purpose by
changing the code.
This time I corrected the warnings in GCC by adapting the code. 

For jeq_infer_not_null_fail.c, it seems rather more intricate to fix the
warning. In this particular case I left the disabled warning. If you
rather think that it can be fixed I hope you can advise me how to.

Best regards,
Cupertino

Changes from v1:
 - Fixes warnings by actual code changes.

Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>

Cupertino Miranda (1):
  selftests/bpf: Fix a few tests for GCC related warnings.

 .../selftests/bpf/progs/cpumask_failure.c     |  3 --
 .../testing/selftests/bpf/progs/dynptr_fail.c | 12 ++---
 .../bpf/progs/jeq_infer_not_null_fail.c       |  4 ++
 .../selftests/bpf/progs/test_tunnel_kern.c    | 47 +++++++++++--------
 4 files changed, 37 insertions(+), 29 deletions(-)

-- 
2.39.2



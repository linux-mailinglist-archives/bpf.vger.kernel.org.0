Return-Path: <bpf+bounces-31497-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA4F48FE7CC
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 15:31:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61BCF1F25053
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2024 13:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD52195B2D;
	Thu,  6 Jun 2024 13:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="b1i7OFFd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MihG8wZ6"
X-Original-To: bpf@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD8C715FA7D
	for <bpf@vger.kernel.org>; Thu,  6 Jun 2024 13:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717680648; cv=fail; b=JN4vUxoRksJvRFxWHoU1L1Wh2Aes0k63R9u0o/tcOCyfF/5/7Sror7T49vAS0HjasR6gtL/k5oY3EDtJDMmeXi7nn9T4hMZrxRCZOEbrgbmtt+ZKOY+mJCwi53Mhfm6Qgln+bTZSFlawHj3Cnio67NDKzd8epz5LrOq8ptiY5qM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717680648; c=relaxed/simple;
	bh=GJRi0zC0wQR9KmaJl2lygPAy/Tos6SsOOcGD8HSUZX4=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=F7m/hdZEM+QMOOabn0cjQ78ZzwBMmgiuVz7elY2SPYwfU0U03oIlvdSg5RHaR61GsDnaDP+rpUAvoknEOUj/N99LK/vE7iOobwYptFwmASZtF6T4t/rcMntZ3GLzP8+GOwXnWQXuSxppC4955UiLv6ccXXOnHCJbufqJRaQIW48=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=b1i7OFFd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MihG8wZ6; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4568iMlW016291
	for <bpf@vger.kernel.org>; Thu, 6 Jun 2024 13:30:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc :
 content-transfer-encoding : content-type : date : from : message-id :
 mime-version : subject : to; s=corp-2023-11-20;
 bh=7iBFjfCpgcMz5+5J6ng0HkJTobx/ZYypp0X78em9nXY=;
 b=b1i7OFFdBPVrNcK7DRfl9WW/3wuazt3mBQC+h6wRK7IBA5k8DJidoj2cNk2RzIHCUAmX
 XqLiCfFteL0Qhh0eAIAwlY+ibEfIz9xPzknIAIqxIsOtPYXNyUDl6euZDx+HE0LgzFOu
 ZOPkcLFyPw1SFtQhiPqKAj/EPxyFqE2uUToP8ha0VZnJPfBIwnZKQfsLULKp7bjvOAVc
 bIHhvGwq4pZb3SvhgXuzW3skkCOAH/asUdumN3MKB4oGqmSL+vkpMiH9H7vBvQkvzrsC
 DNx6xjpIaaqMbdOvHbSjUwl8I98sLHODMKhYYuvdxpAYtV2OTE4atajY6ELU/8WWQGWQ 1A== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yjbrhbhcu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 13:30:45 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 456CjRDD023970
	for <bpf@vger.kernel.org>; Thu, 6 Jun 2024 13:30:44 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3ygrr0trcb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Thu, 06 Jun 2024 13:30:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FF0hShi9yxvo7n8Nuuz/0k4QKhRG3tXbowvlz5sSJSLRI5gABviMylCbNqn69J+4Dbsh2e83KVH4N9iwDjBQkuAJ08j3Mq+/YSUGsHLIQi+wjXtcu0oHQhUdxVGn3XAPrROnNvJIoe0mDn2qYfbyAYv9m6D1mB24Yhp9O2SCHgjXwe2SQ1OK5nZ6K8vmSpVVKwxydE762B0Y0xr5ryp1zCO0l7KZSk4FZAJZsuslDes8xdYcdLOw8V9uDvlW+x7OxWHnrk9dTUsaFJUW5KLeGWDpm+CnM3Pr554ThkTpFhfF6FYn5UAFM3fGiCQL9l7dqFKfD5EcMQIZBtCFz3uUfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7iBFjfCpgcMz5+5J6ng0HkJTobx/ZYypp0X78em9nXY=;
 b=IkfBfn8fkX8AceTU+WUaR0RsRT76rghLJZXa1S3ujnBge96xQOWZzN3VBWATDrD+7jUvlvmPaf5HPh2WlFQ/9SVGWd46euFWgp9Zy5qoNaUqsu302nA8vWky/Iu3EtAPAO+GgjK1s99mRvaHidx1QlMrVt8qT4v+KljX25cREB/UiqRZqhKIYp6QjUQJE0NxBmIYVGYMSQY42h/THYM6v0n9PGiqJATZVmyvcLDdfqcWBsyby1My0VD/i2qSp40CWLBWdr82Ggfb1qDPYlGbtaIYG90vb4DAHji4+HvfMvfC2o+WjMzJoZTFDfbmvyMfnG2bQ1yA3bMU1fEh5eBQZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7iBFjfCpgcMz5+5J6ng0HkJTobx/ZYypp0X78em9nXY=;
 b=MihG8wZ6atFmpJ8VkaPiejNJK9bur2KLEPStxn/Nx/uE6GCyROtbMeaN5B1KXIYUB2I/sZJS76IsJV5buMZOidhcJgjIfV8WzxPseUJeOmjg3zhNmgQr2KyASKOb8RnnkFtey4Rz0hvG+MTHuOV+Ln42vXTKIQ2O36gVv2IaHEE=
Received: from BY5PR10MB4371.namprd10.prod.outlook.com (2603:10b6:a03:210::10)
 by CY8PR10MB6468.namprd10.prod.outlook.com (2603:10b6:930:60::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 6 Jun
 2024 13:30:42 +0000
Received: from BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c]) by BY5PR10MB4371.namprd10.prod.outlook.com
 ([fe80::d2e6:4de0:fdd1:fb2c%7]) with mapi id 15.20.7633.033; Thu, 6 Jun 2024
 13:30:42 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>
Subject: [PATCH bpf-next v2 0/2] Regular expression support for test output matching
Date: Thu,  6 Jun 2024 14:30:30 +0100
Message-Id: <20240606133032.265403-1-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0PR02CA0223.eurprd02.prod.outlook.com
 (2603:10a6:20b:28f::30) To BY5PR10MB4371.namprd10.prod.outlook.com
 (2603:10b6:a03:210::10)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4371:EE_|CY8PR10MB6468:EE_
X-MS-Office365-Filtering-Correlation-Id: 586f5fe7-061d-4862-bab9-08dc862cdcb1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?KMOSnLOUCF0etO0SfOBwSo0c+Tp7fyHFHghEea6gxkyHh+eEJcVs3tabCz8i?=
 =?us-ascii?Q?OaswWaECQmnvioEN3LtuMcm+BGT7PnmpPsRiWEmPUon9msgDgD/Z9AqqyS4o?=
 =?us-ascii?Q?1IHt6fA9GNl44pcJVeqw31SOV8nAtGr5FHLV7Soz6vL93o4rkCZ6b3liNdxO?=
 =?us-ascii?Q?A2lcz6GArwn7tcr/7dqPv291fSYzTZfXq7uvJQskCc7YP29hnJyisb6P7q3Y?=
 =?us-ascii?Q?URDBGuBVwjLnfYzvV4+MshdAwnY1jnxQiI4BLCQ+CQ5DyI+Xk/LUQ1slycSE?=
 =?us-ascii?Q?wiwD+gtCgzfCUtMm0wg+Wk8f/nOStYoLPJgZbYpbcawzd59YXyU/loWDuJl2?=
 =?us-ascii?Q?Sa+qCqDf3Kll2eU0OYQ+QHIT9pxWjJYGTg+KOSy8n2iVF/EPHXXmDsFksap5?=
 =?us-ascii?Q?Q2oXwqE6nS8HvLuSltLxO30+OOeetgfUgrD5u0zTOGJI1m4CmnFLwEsFhg8t?=
 =?us-ascii?Q?0/hHMXDVrGTte52wBWsbfNmPEhaDBDYry+N+0wj3wdBhltXw3BvbEr/rl9P6?=
 =?us-ascii?Q?6rn1YHqBgLd+W9Zd/pPwVLnHSJKQgJPphSGF/fCtpQyXKOEXLt1LEXuxOw3K?=
 =?us-ascii?Q?kWR/RtGbn2q0R1lnK9tkYK3icqWHe1337LonQypKoiqK2q22VhmOPA2rfGqY?=
 =?us-ascii?Q?puueFjm90QoF4WkSULpHW9g26xIh9/7aouwxgTQKsRdWahNrKKMb7Ufj7G0o?=
 =?us-ascii?Q?eHdMwcseF+cHI0LR5/3/Q2W0ZMcc7atpQbIApv9SnLwRg1U2TWBZmT2H4RLD?=
 =?us-ascii?Q?bWDz2eL3EAUdSgKZnvU3b/k/ferDkc7QBk2k5n6efPeqh0N8g4vKU0MoApeP?=
 =?us-ascii?Q?bhDL3czre/UpXDObh0F0nG88+uhZDoOPKPzYYWVXh2heckBYtB3xqrhX4IXi?=
 =?us-ascii?Q?9ZVGjL+62g0EPAkWNpopRYSoGZyRMXP7xdIEKh/FZ74ABBriuQ7jjnv+M+Ky?=
 =?us-ascii?Q?rleW6YN0bJmuit94YzVTLB74yM7/hd73Jo8LvuwNHYujHF5chKstqqIcMyEp?=
 =?us-ascii?Q?Dh8FH7akaGtpV3w7keMs3Ykw1JMH+RQnXz+Q3FYAs5R7Z4PSEerQFzxCm5Yc?=
 =?us-ascii?Q?KLi6/AQv6PIuMM2/ic/jw0qZ5jkkoSt5oyhwce6u9hcI/nJ/UBFb8AJYbNpl?=
 =?us-ascii?Q?qKRjNX2KOdmHk1/cDHVYG8q2OgZNib4r/gKPxxVMktmochEgpd2xV3QIwhqJ?=
 =?us-ascii?Q?aTbJqANugmEkwoEvPlwrfwkfHxpXOXUF1XVrEH9LNUMOlRSoHTx6SnfkJk72?=
 =?us-ascii?Q?pHg0bn0S+G8jQAGYdwOAc6hr91aKmZjF3RS+gaIk6zDTVFqccm4f88O87BxZ?=
 =?us-ascii?Q?0mW0d7LjrfSM8wTqdKu3x+pk?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4371.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Lad7fOIGbEML53GGomET7bp5ZdblvpMezdOPqcKR9+0uWYVN0YKYi1xBd+fE?=
 =?us-ascii?Q?KFMDtNPLQs7wgn70H8wSaIQhmH0I3LOvYNIWBV2EJjSJW8bI2TigGX2U7+AF?=
 =?us-ascii?Q?4wXZowdnrT7bz5k5vC+tNVNByhcU5ywsvwCZ4+Ek7kH7K4fYhTHcoHNDVqDT?=
 =?us-ascii?Q?gighcgVh4Uk/AwIt/Rg+pzoS+PQtcp79Y3sS4iAvUXxbnz65CHc71DS8dW/4?=
 =?us-ascii?Q?gIj/8pPh8xUO2WaYsxb1T5wopYGHmXDUF+NrwOfH0YEFE36otDH5X/72YfzL?=
 =?us-ascii?Q?5I+QSv9EG/ZJct/3KbkoXV3s5WgPhv9A2N3FpDsnFAD9IUHZnZ/7iWXS4nC7?=
 =?us-ascii?Q?tX1m55EmdGh3+0oYnK4fhAI5jH5IYYcUBwopuxSHSr1tGLOam61VEHUi5qjb?=
 =?us-ascii?Q?qwwNs4c3YeFhmXHGRxAoAuHYno0HARbCcdrsZLpW3z4Pk1KFz8wia8JisnQG?=
 =?us-ascii?Q?6Vb91UFxxc12YSmWvdGC3Boo+JwmPEDIkbWT7o0PnWYh4jWAgMPZTxfXKWxd?=
 =?us-ascii?Q?ojJewTCH33e4ZRS40UrFGJ2ijMbc+sq76MEu8n+YijfxXM5P26d6Qmb/G9dG?=
 =?us-ascii?Q?1bvl2eg8B6S4o9Radg3HlO2wymivAmE24MDFO8Db9Em4gt3Mx/zjBXd2wVse?=
 =?us-ascii?Q?49yS2ywgkAD4/D8usIi1JpGkLo3LqrzWA4kza552ascYKr5K5n6gg26L9E2B?=
 =?us-ascii?Q?dSnignzwZ6Al9qc0WcxFwT/0VIoMp9m/bBhGTWwV66VKliZvICQbiQ6nHKlk?=
 =?us-ascii?Q?jP2shCSpNm3st0d9HnBSZ3A4Ex7bxIjX7dWiGK9DPgkdVES1LmE/87tOnhg0?=
 =?us-ascii?Q?ol5276CPn3QNJuJhRcKNtPD4ESN2q3JgEckZ0EpKw/HqSEpb9IBx89D0QwLq?=
 =?us-ascii?Q?gXOqFh5COIwPliow7sbSpbTUqSMFce/0gY4hOQUIlsG2I5rr6OJEaHkXE5uF?=
 =?us-ascii?Q?5SnCvBMxqkdFUzoJ+ZiCL0+MajSlEiE/kvG+zRivmBfKc5TJ4aDIUYkmE4zs?=
 =?us-ascii?Q?Heq6KgfCpPMbk/FLKJJQWWqfpxdoFjdvfwHYr+OKkRxIPAenfRwRyLK5gBuP?=
 =?us-ascii?Q?1S7PSK3bbg8JrkbtmS0cTjfgyoW8TCqgQ4XaLW/RdGPwIuvfOTQ9Jdn9wlHo?=
 =?us-ascii?Q?PAhSSMEvYCzuue7BtG8syxllVAKK95QTVymVo8C325ZCnEqTJdnzUigOXfB8?=
 =?us-ascii?Q?nswG1uqYEnbDG69XIUTmv2yHK480NPM+BfKiwzCaQNlcbusY498waIQKTU4I?=
 =?us-ascii?Q?cBc/sy3JFmvYwKy9W32hhLtt7j/hpCpMyDBKtX0gzXb7zE3LVbWkc9Cv8Ffi?=
 =?us-ascii?Q?1OZ8mXwr8IbU5wSs//Qf6ntjNOOdwvPkRvzN5SkhMMi1gLd9s0qsQ4aQQmrC?=
 =?us-ascii?Q?wI92NUZ+WbrVk52Gu/pFMyOmUGWoIYPitg5Kk8MMuG5aBc6QsAfw4citdLw0?=
 =?us-ascii?Q?3M2e5bqpMEO22/kDNvXk5vWsMXYtreD/AQBUViojdGiJSWkDC9GMWSjarH4y?=
 =?us-ascii?Q?XqoNpQA9E6MvVSlczZ/CiNpnI4wY5JqzmVIdURaGQ5JWw9fNKRioRVwot5ZH?=
 =?us-ascii?Q?lz22aXAOFxPgTdWgfSxys4dU1RZkIJcroJzB+38njMPaGjVO9pI1yOB3p2li?=
 =?us-ascii?Q?9t96G4jGbPVj4Bd20qhL/7g=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	WHDTXMbKpn0Qm+Iv/owaIqLokOuqwCKfsBO3Y1+UxXzxfXwGPQa7fk0ns1LKPOTBKaqGYNhe6wOdp4GWbrtHRvfutrJH61UkOCIVnv937J/+RV82w36HDjJHswH/aXi/V3JzQ5cyrQAAx08hQgsJAX/dzqvyRaZ9syyr8ETb1W3HTG68J788nFDNOAyLzKfmLjjso6nh5eJw5Bcbc5Evbbr6DfaFECpeJLVN7166xL/cA9GtObLh7+hprsf9qnQmWl432JhddadZi7gWJxBDjc+2m7qKNZgYFmuf+S570DDfIbZr6zJR+eEIXWoG6wWJZZYqy78lJT6jHVTQYcvj/Bx03czLj5LJfViy/87xim4nnz5laRln0/1dAExj+hGRjEKyfFqQTiE6/NVdQOVFwOgVMEeNHaxvIxP+lbiIo7lT4cNkDonOi1fHX5RyDxDk3dDA4Lze8/8y85iMald4bShZo1L2i7MOqL2AOzDpehPmpnomA1RdSPg6xbgf9tzCiQtprH7NlwbyfwpdD7knZSYFAEt6vxCd0mFea9rFHZSb5Y2dAjSNOrOZjPApWM2daenfAmE0DWUxvgKcDPDTOspg9ZjUgarxaKbM1MCGMSs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 586f5fe7-061d-4862-bab9-08dc862cdcb1
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4371.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jun 2024 13:30:42.0070
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hIOejzn3/WIqI83Qw8m2fBiR2NAH4PONB005HZGey/c4+hYrguWadreH8+LtxopYrwbkRkgEz/aCjK2BjhqNLK/w1xd/uqZH4Td5G5gFLz0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR10MB6468
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-06_01,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406060097
X-Proofpoint-GUID: BrQkC-EnKLbWVXw_FYlZycRle66o5KuP
X-Proofpoint-ORIG-GUID: BrQkC-EnKLbWVXw_FYlZycRle66o5KuP

Hi everyone,

This is v2 on the regular expression for test output matching patches.

I believe I improved it beyond the precise requests from Andrii and
Eduard.  Hope that this version improves on all aspects requested in the
reviews and fixes all pending nits.

Tested with bpf-next selftests with no regressions.

Looking forward to your reviews.

Best regards,
Cupertino

Cupertino Miranda (2):
  selftests/bpf: Support checks against a regular expression.
  selftests/bpf: Match tests against regular expres

 tools/testing/selftests/bpf/progs/bpf_misc.h  |  11 +-
 .../testing/selftests/bpf/progs/dynptr_fail.c |   6 +-
 .../testing/selftests/bpf/progs/rbtree_fail.c |   8 +-
 .../bpf/progs/refcounted_kptr_fail.c          |   4 +-
 .../selftests/bpf/progs/verifier_sock.c       |   4 +-
 tools/testing/selftests/bpf/test_loader.c     | 143 ++++++++++++++----
 6 files changed, 132 insertions(+), 44 deletions(-)

-- 
2.39.2



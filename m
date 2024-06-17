Return-Path: <bpf+bounces-32304-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BF090B394
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:12:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0629287200
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 15:03:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F76013E41C;
	Mon, 17 Jun 2024 14:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JrKHRcLQ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="tD+qYmmn"
X-Original-To: bpf@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B1292B9A0
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 14:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718633723; cv=fail; b=IF1alHmWIcX6DJXL1RRARm3kNz9ps5Dnmw8viMqD8fpGZq6ZPk2zKV168oFZdX1sQ6iGyLGFBoznz0wUMOjbF/hM6pLaXQLcKoWPD0DGwHQMuzEiYTiw6ADgQO1yZolh71haw7ZOK84h/1/wX5WExoAAoI1phxPdhma096G0WcM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718633723; c=relaxed/simple;
	bh=1vMQJbwJaIjEHvHApAXj1eZ862z8P8n8ev6P9N2WSb4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=owvO0xDhr0mSZlaxd4+d9fTOZj9rr9OKpuWzmos02OWR/IgEkExwupODbi5ySY44kuCQcQHfIoWLwg4LEL5iDDhZEAPuJcskJCMctJ8WaIESFjKRV+3GCDiLR64isPgXOp8uaU+xUtVdRSjoYKnx8lYKm6POkY1cWe10IZ1qf94=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JrKHRcLQ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=tD+qYmmn; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45HEBO9U026465;
	Mon, 17 Jun 2024 14:15:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=9Ge+hM4bkgBBTGvH504d3kzmk6mQaOafMAAYZliCmGU=; b=
	JrKHRcLQoJg4nhTwTjc9uP69fxWoaGwXPiiulFW3EBaRxQCiZqRXTbqmkIhr4w3S
	gJNqOnyWm75dBXsMwxXnW6rbx7H1kCBdQPqtCiVTXGgByeFRfDlUXlXTX3R3GeeN
	GupCqgaaVdvC2wSl+t/GcVQi8358U3X6E3qlkfkma44bneZe/Ohw4mK5V8PHLLtP
	mCrbmPSA7/q4flsb53QcOZ78rZnKNkYYpiJn7ce8scBK7d31tMWjvI+qjKfcWiH/
	97RQgPkoucgFehpJUKbfpkZwxvrOKTyNC3uu0vyvam/b2kog9DpFl0qC0GMS87y1
	L1Qxelr+5I0pI9kJPdzgAg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ys30bjs01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:15:16 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45HE2Lbe032379;
	Mon, 17 Jun 2024 14:15:15 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3ys1d6gt27-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Jun 2024 14:15:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LZU3EfpMC48XIKQgzmBjdjyZ0RMv9JsVqmq+RXuCJjsxpMG5320XR0oEOxEWtfdiyL6yFZRqQL13aqGEBpyJuxpDe1zjjmwC4/j3+IlCZid12Xayow2qiLyWVJyWxqV0FJeSAIHRncM2eHs7CFo+iMEUnICsJk+s2xmXSF1U4wtpGW4wDXj7C4yKTqxH8uAdUT52DrqYg9zGR63+AExh55aTcrR48x88QNztV9cfSedhV8O387bedXz3tuXooOyDUk5po5Ky3InRnOjBKzrCRG/z+EQmobD562rHHoZWOyEwSpp0HkpoMPY2Yy4dyiwpU6aGBgphmFCgyfEBpGomMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9Ge+hM4bkgBBTGvH504d3kzmk6mQaOafMAAYZliCmGU=;
 b=QtV3PWMrAppPUcFQomlkFvV78D1+XqLsOojPB6CNRIGPQgtqCEBROCH8cNd3on61kQfcme3atMvjCF/VD1UZRxFhdwdgLzjfe5jZWIpBvoQeQ7P7xURpVk24/0W6DI9LDW8rGR5ijAL44axvbnE5Z97ky18FN//ZmO71H2LitFajaQIDb/3W8pm3+ZjzF33+9Hprl0Y4EIo/i/5RKuAoalgMaAACxH6D8HlOSkHKmEI4Ix8jiJfXevHLpkNmtmlDTQnToKIkN48eFUugMcUqNJh0wQXZO952rCqGaC7Brn1AZh7wKHM4at0ML4/BOKiFgDYnJ7PIFt2fBAzBvbtDRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9Ge+hM4bkgBBTGvH504d3kzmk6mQaOafMAAYZliCmGU=;
 b=tD+qYmmnZhbFQAWrMbmKWb7Uzmscb801H4SKhTYzC4UUVcRNB7RXknj2KUlMxjKImxisjBoSI4Re2AwlY2VFqBFo2sS8AhcyXRDFTXR388cVKjipc0g+Vjt4xys25uzJj75sETu2rvtpR3EOBsntDYANQtJdAqfHQm4tzOjmEoM=
Received: from MN2PR10MB4382.namprd10.prod.outlook.com (2603:10b6:208:1d7::13)
 by PH7PR10MB7087.namprd10.prod.outlook.com (2603:10b6:510:27f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 14:15:09 +0000
Received: from MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb]) by MN2PR10MB4382.namprd10.prod.outlook.com
 ([fe80::5033:84a3:f348:fefb%7]) with mapi id 15.20.7677.030; Mon, 17 Jun 2024
 14:15:09 +0000
From: Cupertino Miranda <cupertino.miranda@oracle.com>
To: bpf@vger.kernel.org
Cc: Cupertino Miranda <cupertino.miranda@oracle.com>,
        Eduard Zingerman <eddyz87@gmail.com>, jose.marchesi@oracle.com,
        david.faust@oracle.com, Yonghong Song <yonghong.song@linux.dev>,
        Andrii Nakryiko <andrii.nakryiko@gmail.com>
Subject: [PATCH bpf-next v5 1/2] selftests/bpf: Support checks against a regular expression
Date: Mon, 17 Jun 2024 15:14:57 +0100
Message-Id: <20240617141458.471620-2-cupertino.miranda@oracle.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240617141458.471620-1-cupertino.miranda@oracle.com>
References: <20240617141458.471620-1-cupertino.miranda@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P123CA0051.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::7) To MN2PR10MB4382.namprd10.prod.outlook.com
 (2603:10b6:208:1d7::13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4382:EE_|PH7PR10MB7087:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd626e7-8b0d-4511-c72a-08dc8ed7e528
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230037|366013|376011|1800799021;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?jJKEF5kPbhpftyuCpFq5Q7AFBzMgVmzOocyQCXFEF3DbNcdN23O01PhO1hjp?=
 =?us-ascii?Q?1+BF71P31Y2eWUBKSxkPkmNt8c45lqYyDZCOL7VzpElBeigEI6+q8OaPtdPD?=
 =?us-ascii?Q?JtFXoCK6LOEKsvhVpmh2UjnQqucDqalA+RcZVawoVLY+QZoTdGcwhYWpzUpF?=
 =?us-ascii?Q?CKRPUHpLhJKuU/SnGmJfxr0kmwlWjLze7GcjLImuKhbZsx4I92n5al/rfczk?=
 =?us-ascii?Q?cZhztRmZ2nz4tN8CqPIgT7LPKQjkmNcL9I2Tfc8zANJPmyZokbR9+a1vf1eA?=
 =?us-ascii?Q?8pQ7FPQ0OmUfpsRuNoPvaMQn+JqDUBL9IqDUdC2b45Pf9qMdpJL5qXrs2SKD?=
 =?us-ascii?Q?zZyutBYRIzxbXvHSvc7ey45A4s41IJ48uGWpWqOboe1ecpH6/DdZL88FFtem?=
 =?us-ascii?Q?6l7HOGkuchYpwETzwZqTt91ZprC42O+RoKowUg9reXvdtDFgpCmaPJs9J4nT?=
 =?us-ascii?Q?NmbSprxBYN/DTGGSiFMZxTQtsN1XZUtVafMRzYoH3w88ZIdGYTcp2fNv3vf0?=
 =?us-ascii?Q?43t2bOm1cnBZYnqcaOowLCbb+Iy0da6oR1faJ8UxZT3rjCZ5LbmsqbCF+mT1?=
 =?us-ascii?Q?d6inIte1jR9RQNVSqdqGjhvK99Rz3/d3lswuI5Q+LhXUPtocDAqGUkeL9/dJ?=
 =?us-ascii?Q?i5cXFzKM82ga2ekEouTzYqNlLkQTj9Gm4/XE03DsfK3fB4BQGbI1PMECs1k+?=
 =?us-ascii?Q?RZ4Ln5S4Sa9x7kLyvCA1p7M8DyqX1gB+MhcndBsM/FabmpxFfKxgJCiO+DC8?=
 =?us-ascii?Q?DMb4sqzL/I6nr+uce+lEJx0GoIhVt0kl9tGjxJSuHxamz7g2/TOV4zbMnn5G?=
 =?us-ascii?Q?whU3iepDpNZeAtHiNgC25g1w+cUTegYTxYaILJnLT7++L4vOSsvmb8zT+1+H?=
 =?us-ascii?Q?vlaBXm1q3hAkmQS1gRbu88d7tqQxRbh55HkuTFJxAEznfpVe2RItu4Ezd9L8?=
 =?us-ascii?Q?gd0GAvuh5sNOuSDiD8Ruh/MKdH6zReCjjuu0l8eU/+fWWVL7JYVD+DVCdQ7E?=
 =?us-ascii?Q?TkHVKEdAdUrWtN7ysxwc9O8P+3LT8SQx6ekNfWrFPEfHGk2JEd4GSd9AZT58?=
 =?us-ascii?Q?/G7X3Xh99xnSirp4kIV1bZFGLjmQo7GIq8ELpTtbm3l4Nh+0bkNN5rfIyce6?=
 =?us-ascii?Q?c1+KmtdYKOeHrAEPsgyi4iRGaUIBgoBzb1SaH9YXCnUEcvU/PScpVBSiyZuY?=
 =?us-ascii?Q?EPWxrDsH9+oJDa4uh4uYt1fSgSHZZnIRRFX8NNGPymSu9ZfyhN6opUI0l/77?=
 =?us-ascii?Q?tsd/FKHEbY0vjmOBOpOSprEIt5x4f9+ILoGiv26PcotCEN9ey0thtmqAYoat?=
 =?us-ascii?Q?ZmfRiqQAhf1gZtw7D7iPTKf1?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4382.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230037)(366013)(376011)(1800799021);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?fY6LV7asWnsIsFjobb7Q3bO+KIncJw5EOs+QTqsPzDU5fmlc7yE6qDBD8Yl9?=
 =?us-ascii?Q?XHf5srL509P0mnInoUVbII92CBqok1pR+eq5AyhkVPBgOFeA3N1NxG9o0DIf?=
 =?us-ascii?Q?pFOuQYPX7jJn5ceCnVo9ZmSaNB4+Y//XhiHLbpSp1i9u+GErg9iyib0t0JrP?=
 =?us-ascii?Q?cyyCR7H8W0Luy2PvuSef41/3+3gjv1tEUolpSTJ9Z5zTImMWBimgszpbsGuI?=
 =?us-ascii?Q?b5mGrNwC/7gxbxBu4JSE0ia3YMF3RUm5soz8YbPzNaxQmd7dG/KuAMTneWor?=
 =?us-ascii?Q?nqN4NM1MxOxDvmkfXWdLfD4n6p41Sgo4Fo26WRFoxVhAXv89AXc5FKF5v81/?=
 =?us-ascii?Q?A13D8N4nqDYlOid4BidiReB/U8F1ZJ53H1dUlhfdUUJTI/wt5yWxoEVY7o3a?=
 =?us-ascii?Q?mMniI59uNOQnN95ickrt4cGUd4F332sHR4SF8+ze2PnUMhottEf+P1guLF6+?=
 =?us-ascii?Q?Asd0fHdBrMM0ZDRKpHWHtLSPnzzzZx+Fl1TEgpnQuye2UnWeBQ5Vvv9h3tGN?=
 =?us-ascii?Q?/aBcehLanGVPN2qfGSPrN4D5aMW7p6BstC0Wv6xifKkme/drrn3FbUtOapMr?=
 =?us-ascii?Q?18RlBSyJAx/LZM9NLHctdvxgVcix4RHQlKGwFi706kJdguY114aVANLePeau?=
 =?us-ascii?Q?6iySXXlsMm2G03v2wjkESAseYP3JMlqNB2pfFhw/dGaQ44VVnV6Uy81QZldS?=
 =?us-ascii?Q?nuCgSkHfQU+d+kTIIGvVmaTcc8LGI+k1heXUjr4FIa1/R2eHCRMZgtEyZMrr?=
 =?us-ascii?Q?7eEW/nYr5QEf+qXjCicwNpQ/UMnnmOxMzsBVnzwH9VAxSDDPSUEJAmuObm0y?=
 =?us-ascii?Q?11SA0Ve5TSmsFbYsqwXuq2wQ0+qOQFAwQb4GlzjXejo8Ag3NeTDmPCXJZEFL?=
 =?us-ascii?Q?DyG40Jhc9ijtY6Ff8xlYsqij70/Sd8/h+mZkQNbEaftPgWbCX+wSq96Zt+ZE?=
 =?us-ascii?Q?nCCR3lrvWHHiuPvFbiwYJhdyDhj2CjeMB1sZRGyPVASHCY7MiVkJP+uzbfm1?=
 =?us-ascii?Q?T7YkMHaNerVCluFLF22ERygACI2F2GLHj2ZK//+MlB1pNXFDD/lOR2k9/Xis?=
 =?us-ascii?Q?yvB7yDSUlhLPrjxlFUoF1aklHvD+D8BUfZVItEbLkj4RFvpqakGSWabEqTtM?=
 =?us-ascii?Q?PVSyKAoI1zuuFi41l4A7fMvl57t2jzfjrTdSng9PuGM0wyBJ0APIdQkkfg7D?=
 =?us-ascii?Q?dnMoGJ5CVz2HC892qU6uAqI+tzOVzacFKE+Y1Fo8SGAWhlU5to990M9daDvD?=
 =?us-ascii?Q?jRoOk64AZBNgh1nBM8KivdwHIKiARVvoZhrfBIqmfRljVlkIMWmz1zA6bLnF?=
 =?us-ascii?Q?SmNNxb1Gg2sKk8oHr/tpm0QXBIkIfJtjBPlIdDd9WaiSOdEtbvZi4Ie9Dn7q?=
 =?us-ascii?Q?OW1Y+CPfTBax+5lE6AReeUlDbIDgM1H+7vZTJDmi6z1qs6fkHgVGMyfwVDNv?=
 =?us-ascii?Q?09nR/oHbLWv7OK5ba7w71aGiK/mVZ/mGyhFM0TIZFbpGZ1v/mFvBeBe01/la?=
 =?us-ascii?Q?e5Cd/qyeHv6vJlmZUiU0ukDcdIV2IctHm6hKLpqB0TCAmSRRg0nR+uLtV6wA?=
 =?us-ascii?Q?Ijf/x4gBEcP8SgyPbnJUWlDE4G0otREoZf1mpe+zi9NSQbbSmnbFGDbws27T?=
 =?us-ascii?Q?qqS/bNtdE0Fln/0Gziz+idg=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	yHAQgK38/EUmC9XEK0p1xJ9bKHlm4V4Zp25oDUvXLiQtRxkHmLO4JkesLPODtDxBqv4ADEo+JdreMBXi4Fha/tbO9ML96rk/Y1/dmX/j7Pk44vHAnivIbKn48c+05AdWSeILNC0UEYATFSKf9yVdJztspXvL/oE2KK17hX26ljS7CGnkzy00H8SPJfA6jim6ADPy40/JU6INF9s6PWhrpfEMiDDu9OKDQrlWyCxtxsylTFYTpZL28Bkl/Oc8V3NE7hxNMe2WtBztjl/1uvQZiiUg5bsdA00XXfpVyRQbGaJWfp4Esttla1gEGxXqvh9yCj4MP+9e3B0AhxePTN02d+YJMnS1u3fGAJBPe34bIKOsJpKv5myJzrJ9dpYrW2GvKGMFBe7EWjOHHev2dwHlcg1YJEt0K8qMjPjp527wOcgiBiTxsiHLN9BgraKos5a45op81zMvaOYTTgEUCDAUgFYol3iFLRG+4Tp0HbK7cUJXnUzTzsADJjqX37v/IUy9cIzSbJ/is5x3ODzAV0pJHYYK9RyrCIlfgZ6WegR1VdQq0n9HFHEZChPzRZq+KgaOwhjvABY5wSyaS6yEHLCOncBRY9GQsw89VYCi8xi5TLk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd626e7-8b0d-4511-c72a-08dc8ed7e528
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4382.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 14:15:09.5486
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KteB0jwA04yLyGlqZ0StzXoBNkUlaMO+VjT8UD6DntghhrrMVqvO3/oXlHEu1ZV3v1yL3BqqkQGbWYhattHhInQcd12+iZTZis8r4SMsOq0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7087
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-17_12,2024-06-17_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2406170110
X-Proofpoint-GUID: ZlmXHn6d5m00GwZq_ton3yPcFmeyH8l_
X-Proofpoint-ORIG-GUID: ZlmXHn6d5m00GwZq_ton3yPcFmeyH8l_

Add support for __regex and __regex_unpriv macros to check the test
execution output against a regular expression. This is similar to __msg
and __msg_unpriv, however those expect do substring matching.

Signed-off-by: Cupertino Miranda <cupertino.miranda@oracle.com>
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Cc: jose.marchesi@oracle.com
Cc: david.faust@oracle.com
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h |  11 +-
 tools/testing/selftests/bpf/test_loader.c    | 117 ++++++++++++++-----
 2 files changed, 98 insertions(+), 30 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index fb2f5513e29e..c0280bd2f340 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -7,9 +7,9 @@
  *
  * The test_loader sequentially loads each program in a skeleton.
  * Programs could be loaded in privileged and unprivileged modes.
- * - __success, __failure, __msg imply privileged mode;
- * - __success_unpriv, __failure_unpriv, __msg_unpriv imply
- *   unprivileged mode.
+ * - __success, __failure, __msg, __regex imply privileged mode;
+ * - __success_unpriv, __failure_unpriv, __msg_unpriv, __regex_unpriv
+ *   imply unprivileged mode.
  * If combination of privileged and unprivileged attributes is present
  * both modes are used. If none are present privileged mode is implied.
  *
@@ -24,6 +24,9 @@
  *                   Multiple __msg attributes could be specified.
  * __msg_unpriv      Same as __msg but for unprivileged mode.
  *
+ * __regex           Same as __msg, but using a regular expression.
+ * __regex_unpriv    Same as __msg_unpriv but using a regular expression.
+ *
  * __success         Expect program load success in privileged mode.
  * __success_unpriv  Expect program load success in unprivileged mode.
  *
@@ -59,10 +62,12 @@
  * __auxiliary_unpriv  Same, but load program in unprivileged mode.
  */
 #define __msg(msg)		__attribute__((btf_decl_tag("comment:test_expect_msg=" msg)))
+#define __regex(regex)		__attribute__((btf_decl_tag("comment:test_expect_regex=" regex)))
 #define __failure		__attribute__((btf_decl_tag("comment:test_expect_failure")))
 #define __success		__attribute__((btf_decl_tag("comment:test_expect_success")))
 #define __description(desc)	__attribute__((btf_decl_tag("comment:test_description=" desc)))
 #define __msg_unpriv(msg)	__attribute__((btf_decl_tag("comment:test_expect_msg_unpriv=" msg)))
+#define __regex_unpriv(regex)	__attribute__((btf_decl_tag("comment:test_expect_regex_unpriv=" regex)))
 #define __failure_unpriv	__attribute__((btf_decl_tag("comment:test_expect_failure_unpriv")))
 #define __success_unpriv	__attribute__((btf_decl_tag("comment:test_expect_success_unpriv")))
 #define __log_level(lvl)	__attribute__((btf_decl_tag("comment:test_log_level="#lvl)))
diff --git a/tools/testing/selftests/bpf/test_loader.c b/tools/testing/selftests/bpf/test_loader.c
index 524c38e9cde4..0670540b36b8 100644
--- a/tools/testing/selftests/bpf/test_loader.c
+++ b/tools/testing/selftests/bpf/test_loader.c
@@ -2,6 +2,7 @@
 /* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
 #include <linux/capability.h>
 #include <stdlib.h>
+#include <regex.h>
 #include <test_progs.h>
 #include <bpf/btf.h>
 
@@ -17,9 +18,11 @@
 #define TEST_TAG_EXPECT_FAILURE "comment:test_expect_failure"
 #define TEST_TAG_EXPECT_SUCCESS "comment:test_expect_success"
 #define TEST_TAG_EXPECT_MSG_PFX "comment:test_expect_msg="
+#define TEST_TAG_EXPECT_REGEX_PFX "comment:test_expect_regex="
 #define TEST_TAG_EXPECT_FAILURE_UNPRIV "comment:test_expect_failure_unpriv"
 #define TEST_TAG_EXPECT_SUCCESS_UNPRIV "comment:test_expect_success_unpriv"
 #define TEST_TAG_EXPECT_MSG_PFX_UNPRIV "comment:test_expect_msg_unpriv="
+#define TEST_TAG_EXPECT_REGEX_PFX_UNPRIV "comment:test_expect_regex_unpriv="
 #define TEST_TAG_LOG_LEVEL_PFX "comment:test_log_level="
 #define TEST_TAG_PROG_FLAGS_PFX "comment:test_prog_flags="
 #define TEST_TAG_DESCRIPTION_PFX "comment:test_description="
@@ -46,10 +49,16 @@ enum mode {
 	UNPRIV = 2
 };
 
+struct expect_msg {
+	const char *substr; /* substring match */
+	const char *regex_str; /* regex-based match */
+	regex_t regex;
+};
+
 struct test_subspec {
 	char *name;
 	bool expect_failure;
-	const char **expect_msgs;
+	struct expect_msg *expect_msgs;
 	size_t expect_msg_cnt;
 	int retval;
 	bool execute;
@@ -89,6 +98,16 @@ void test_loader_fini(struct test_loader *tester)
 
 static void free_test_spec(struct test_spec *spec)
 {
+	int i;
+
+	/* Deallocate expect_msgs arrays. */
+	for (i = 0; i < spec->priv.expect_msg_cnt; i++)
+		if (spec->priv.expect_msgs[i].regex_str)
+			regfree(&spec->priv.expect_msgs[i].regex);
+	for (i = 0; i < spec->unpriv.expect_msg_cnt; i++)
+		if (spec->unpriv.expect_msgs[i].regex_str)
+			regfree(&spec->unpriv.expect_msgs[i].regex);
+
 	free(spec->priv.name);
 	free(spec->unpriv.name);
 	free(spec->priv.expect_msgs);
@@ -100,17 +119,37 @@ static void free_test_spec(struct test_spec *spec)
 	spec->unpriv.expect_msgs = NULL;
 }
 
-static int push_msg(const char *msg, struct test_subspec *subspec)
+static int push_msg(const char *substr, const char *regex_str, struct test_subspec *subspec)
 {
 	void *tmp;
+	int regcomp_res;
+	char error_msg[100];
+	struct expect_msg *msg;
 
-	tmp = realloc(subspec->expect_msgs, (1 + subspec->expect_msg_cnt) * sizeof(void *));
+	tmp = realloc(subspec->expect_msgs,
+		      (1 + subspec->expect_msg_cnt) * sizeof(struct expect_msg));
 	if (!tmp) {
 		ASSERT_FAIL("failed to realloc memory for messages\n");
 		return -ENOMEM;
 	}
 	subspec->expect_msgs = tmp;
-	subspec->expect_msgs[subspec->expect_msg_cnt++] = msg;
+	msg = &subspec->expect_msgs[subspec->expect_msg_cnt];
+	subspec->expect_msg_cnt += 1;
+
+	if (substr) {
+		msg->substr = substr;
+		msg->regex_str = NULL;
+	} else {
+		msg->regex_str = regex_str;
+		msg->substr = NULL;
+		regcomp_res = regcomp(&msg->regex, regex_str, REG_EXTENDED|REG_NEWLINE);
+		if (regcomp_res != 0) {
+			regerror(regcomp_res, &msg->regex, error_msg, sizeof(error_msg));
+			PRINT_FAIL("Regexp compilation error in '%s': '%s'\n",
+				   regex_str, error_msg);
+			return -EINVAL;
+		}
+	}
 
 	return 0;
 }
@@ -233,13 +272,25 @@ static int parse_test_spec(struct test_loader *tester,
 			spec->mode_mask |= UNPRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX) - 1;
-			err = push_msg(msg, &spec->priv);
+			err = push_msg(msg, NULL, &spec->priv);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= PRIV;
 		} else if (str_has_pfx(s, TEST_TAG_EXPECT_MSG_PFX_UNPRIV)) {
 			msg = s + sizeof(TEST_TAG_EXPECT_MSG_PFX_UNPRIV) - 1;
-			err = push_msg(msg, &spec->unpriv);
+			err = push_msg(msg, NULL, &spec->unpriv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= UNPRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX) - 1;
+			err = push_msg(NULL, msg, &spec->priv);
+			if (err)
+				goto cleanup;
+			spec->mode_mask |= PRIV;
+		} else if (str_has_pfx(s, TEST_TAG_EXPECT_REGEX_PFX_UNPRIV)) {
+			msg = s + sizeof(TEST_TAG_EXPECT_REGEX_PFX_UNPRIV) - 1;
+			err = push_msg(NULL, msg, &spec->unpriv);
 			if (err)
 				goto cleanup;
 			spec->mode_mask |= UNPRIV;
@@ -337,16 +388,13 @@ static int parse_test_spec(struct test_loader *tester,
 		}
 
 		if (!spec->unpriv.expect_msgs) {
-			size_t sz = spec->priv.expect_msg_cnt * sizeof(void *);
+			for (i = 0; i < spec->priv.expect_msg_cnt; i++) {
+				struct expect_msg *msg = &spec->priv.expect_msgs[i];
 
-			spec->unpriv.expect_msgs = malloc(sz);
-			if (!spec->unpriv.expect_msgs) {
-				PRINT_FAIL("failed to allocate memory for unpriv.expect_msgs\n");
-				err = -ENOMEM;
-				goto cleanup;
+				err = push_msg(msg->substr, msg->regex_str, &spec->unpriv);
+				if (err)
+					goto cleanup;
 			}
-			memcpy(spec->unpriv.expect_msgs, spec->priv.expect_msgs, sz);
-			spec->unpriv.expect_msg_cnt = spec->priv.expect_msg_cnt;
 		}
 	}
 
@@ -402,27 +450,42 @@ static void validate_case(struct test_loader *tester,
 			  struct bpf_program *prog,
 			  int load_err)
 {
-	int i, j;
+	int i, j, err;
+	char *match;
+	regmatch_t reg_match[1];
 
 	for (i = 0; i < subspec->expect_msg_cnt; i++) {
-		char *match;
-		const char *expect_msg;
-
-		expect_msg = subspec->expect_msgs[i];
+		struct expect_msg *msg = &subspec->expect_msgs[i];
+
+		if (msg->substr) {
+			match = strstr(tester->log_buf + tester->next_match_pos, msg->substr);
+			if (match)
+				tester->next_match_pos = match - tester->log_buf
+							 + strlen(msg->substr);
+		} else {
+			err = regexec(&msg->regex,
+					    tester->log_buf + tester->next_match_pos,
+					    1, reg_match, 0);
+			if (err == 0) {
+				match = tester->log_buf + tester->next_match_pos
+					+ reg_match[0].rm_so;
+				tester->next_match_pos += reg_match[0].rm_eo;
+			} else
+				match = NULL;
+		}
 
-		match = strstr(tester->log_buf + tester->next_match_pos, expect_msg);
 		if (!ASSERT_OK_PTR(match, "expect_msg")) {
-			/* if we are in verbose mode, we've already emitted log */
 			if (env.verbosity == VERBOSE_NONE)
 				emit_verifier_log(tester->log_buf, true /*force*/);
-			for (j = 0; j < i; j++)
-				fprintf(stderr,
-					"MATCHED  MSG: '%s'\n", subspec->expect_msgs[j]);
-			fprintf(stderr, "EXPECTED MSG: '%s'\n", expect_msg);
+			for (j = 0; j <= i; j++) {
+				msg = &subspec->expect_msgs[j];
+				fprintf(stderr, "%s %s: '%s'\n",
+					j < i ? "MATCHED " : "EXPECTED",
+					msg->substr ? "SUBSTR" : " REGEX",
+					msg->substr ?: msg->regex_str);
+			}
 			return;
 		}
-
-		tester->next_match_pos = match - tester->log_buf + strlen(expect_msg);
 	}
 }
 
-- 
2.39.2



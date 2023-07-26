Return-Path: <bpf+bounces-5957-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC017637A2
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 15:31:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4ABA01C2120C
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:31:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D83FC2D9;
	Wed, 26 Jul 2023 13:31:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E377C2CF
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 13:31:09 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24E35F7
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 06:31:07 -0700 (PDT)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36Q803SR025731;
	Wed, 26 Jul 2023 13:31:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=6MFfUJr9eesa0/n1QzwOHyvq09RMn8VdrNF/0IrRtsQ=;
 b=p3cIkGKmQ1l9m1z9C4NAKkEFFLiUzs8mnLzbVTluyvAxOPfmNA++uPpdxPqyy8xi1AzQ
 IjgFyNTv9dPBI5E1qdcmKV1TUAdrprVCjbiyYtAniU1Ip/YDCSvabKjbjoaxIf+NspIH
 twTRqf/ahCMo/oZjjJyhkpBC4RlZ8ZIi/Rk1LY1Rukynmcj5i5LPgGY9bOOHLv3iMWR2
 3r82YENrqk7jYz1tjLJzXi6cjPjDOEq25RFLKymBZd7tR3A/7EZNmw2Ihfzsf0abLI6j
 XawTMqcL1LZBTvC6aMVX26rTwrUkhiSBmo64NDcwoG4diba8LzQVgBeiTl4vF9Aek+EB Pw== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s075d7h5r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 13:31:05 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36QCHXZ1022992;
	Wed, 26 Jul 2023 13:31:04 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j66wwq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jul 2023 13:31:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=my0R/+PTfc+hLp5dUBGGYJEAy3RBYJRbMk85gn29XmyOG/ad+O8mExgMh3iM+k9kbE5xvpTHRjuFuHnbiMKyxZnuUbsaA8chFxrQ6UD1yGWlW+FzweOInQ6+CGQQtvKXZrhi/Y1ZbzTko5bYtfrGlHna6tQHDTtNJWyY4GHJQYZtX7Mme2cdQpPL2UjzHdCVgQiEIdNDkk7csn9SP6JjU8vr9GF2nEoj2lUBLLcT4bu1hGWsyW2a/hy4XT3qk5RXlBfXkLvSNjsP3wPMB6r5e+syI9rwPHWp/8sErAwm4mw0j9T0n1R0knT9E4eNBJesB62Mrq4+s9ikkTrazUMC/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MFfUJr9eesa0/n1QzwOHyvq09RMn8VdrNF/0IrRtsQ=;
 b=GxJcYCUNUJUpqKg6329cPQFMSMDYP82I5alIPhIM7GGCaOgLlIYZXelZzQ4lQsB4IEE2dYdaW0o6TzdK6fXG6DJOPsD+Olk1uVqVnn/SW4dyO5EehU2djaAuyBFAsHBDrDNThs2SezF46gAwtRJmcUAkgZszJRzq5Ia7X+pnv832DdypnoKXl/zQ/+aCE5Gj8fWkXm7pz01ajGB+isgdEh3a1firuzknjtKMBXzNi3J0p6dkdXFSOIl335JSrajfwWmjj9i3G8MRa1sBNpAbvpDj0dtkNxxfHu6GEEbh58EzTV7F1gBPisO7EGwcsdLmwfBt5ESYquYsoADe4nXQIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MFfUJr9eesa0/n1QzwOHyvq09RMn8VdrNF/0IrRtsQ=;
 b=UCp6hXj1twHiK7YCBGMQexS1wKUCjVquNHQ+cY1StRD2tW3wrSEZlFC31+KBWbNedI2q/CpvystmdCG9fCCeC1Lnj/R/JGG8zd+ptALIti8821X2SnTNJLt+mJ78W1MaX4gcJYIywTOlf6rfB77e320xy4PTGCXuV7JqcTFVwvM=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by DS0PR10MB7204.namprd10.prod.outlook.com (2603:10b6:8:f3::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Wed, 26 Jul
 2023 13:31:01 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6609.032; Wed, 26 Jul 2023
 13:31:01 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Dave Thaler <dthaler=40microsoft.com@dmarc.ietf.org>
Cc: "bpf@vger.kernel.org" <bpf@vger.kernel.org>, "bpf@ietf.org" <bpf@ietf.org>
Subject: Re: [Bpf] [PATCH] bpf, docs: fix BPF_NEG entry in instruction-set.rst
In-Reply-To: <PH7PR21MB3878287822C8A1F5994A8E9FA300A@PH7PR21MB3878.namprd21.prod.outlook.com>
	(Dave Thaler's message of "Wed, 26 Jul 2023 13:28:53 +0000")
References: <20230726092543.6362-1-jose.marchesi@oracle.com>
	<PH7PR21MB3878287822C8A1F5994A8E9FA300A@PH7PR21MB3878.namprd21.prod.outlook.com>
Date: Wed, 26 Jul 2023 15:30:54 +0200
Message-ID: <87cz0e7qb5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0193.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9e::13) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|DS0PR10MB7204:EE_
X-MS-Office365-Filtering-Correlation-Id: b3c6f2c8-aba7-4d55-9d0c-08db8ddc8da1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	GArjLd5cqN5khFfAwCe85AktP1kCy+KkhDZE5HZUkcCZ/MHIwfpa8YuBSGEG7FKoXoJQfsIckX9UdApMXRU4rxOxHcT6FXLoJRZjdqsyvxFvvEKsXF9GCrS/WhHlHPw0pOZDXGFHDvi5FLIZfKY6vJLRyyzN5FXiGtScHVLZ/gWHI23QK8NTHj4hhSx4Ly9enxl4oqqnl+FfI5otxHiZqTGop1BVfPWFXVUusJtAPWT0fzAaFyfm3abRwu4qHfBB8uPr9NNdte/jKFAKoBrEb3o1s3j8H6sFNmoEt25Bp+stW2fsW10dJWxss3NnmYlLjBkue/rx0r2QjvHXvOuKrbXw009kUcrylb4midOGuoVVCaVhwX1vV9eZkvC4uepm341RRP9UKUJfhxClGt/asyevcgXzevsT/xAKchwY14CYxVtnRygxoN8C7SD2i2ewUXaJ+UF73C2uEeW1JNNjyzgj1GwiG82FeIGXo8tLILrwAUaN1B9yxh+RCrYME8y9ICqkPmLPGhFGw7PzI6AKLL2XXUz7bPHyxCkKMdaP8E7P58rzuiUXID2XCVF0/9oL
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(136003)(366004)(346002)(376002)(451199021)(6512007)(66476007)(41300700001)(66946007)(66556008)(4326008)(6666004)(6486002)(316002)(38100700002)(36756003)(2906002)(45080400002)(478600001)(54906003)(2616005)(83380400001)(186003)(5660300002)(8676002)(8936002)(53546011)(6506007)(26005)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?C6BwPGpHkkaCR5l6fMr8ilAkzgJt7iWj0nOtZfowd8Z2Es2x/uMYxHuiawmv?=
 =?us-ascii?Q?50ZiRtLn4xNjvF9rhkgf6FFexNnvlyoQZ8SsooMYdLlgRJ6C1wnZnFGNreqz?=
 =?us-ascii?Q?WVZa5nbJT/IIs0RahaJmCGt4WEeLpuA5BK8rfWAeQrVyaaF8RVkdy2a0UeT4?=
 =?us-ascii?Q?lXOSJvATY1VRrCXgN0z+8LqJ0y0uahygYG9K6s0pMoHKsSAMVas8Eapo/8xx?=
 =?us-ascii?Q?c+hnGyDNmIG/hyz6TA0Tkklzk8cvCigFfVqrrvek21du3/MBmnRJx5bqGz0J?=
 =?us-ascii?Q?+ZxxgIOpzgFvNQr0rq3TmeDN6XoMNcx0RUTUxEfynm0ky3JUpJaT8kEF1mSs?=
 =?us-ascii?Q?WWg5jNeUlS0WACW4AZMjHo+bhZbY9mDrjulJTmXTxMUumm1JrNnpEO71eQuQ?=
 =?us-ascii?Q?nCz2RqvErXoy8oDFalTNELN57jl3zH+NRl/T4HX3KxmiXBpqgfjnGZyUGbw4?=
 =?us-ascii?Q?bX6LGqQTh213QMz+ykIA0unmUvljrLrESitk47yLUr7aRc4pw4bg792VQY2U?=
 =?us-ascii?Q?JQ0liesmltW4bgK0H5sgjH+YS6aORWFn3sT2L4ut0jQGpwiriGDThVSxoSqq?=
 =?us-ascii?Q?yPOYIFAeUOIZ6U6z+PU/p/PHfbLsEYJFmgsO6P4ON2q0mKTOC+bPz0C6UspM?=
 =?us-ascii?Q?v/Ai+GEGRSDF3sBlenYY3oNn7fQkPk5y/81bm4/2cpbijXRzAnQCwQRF+eoE?=
 =?us-ascii?Q?cFGul0YXWxWa+sU99/7Ta7pjUEmGlsDm7D7LqAWzMCDbKQi/U33ZiGsE8Lif?=
 =?us-ascii?Q?x1qFub5UhsFxXdfe3r85nMRFrHzxklYQjNDxJc9lQKe5A0sPdbYCCv12HfN7?=
 =?us-ascii?Q?pZoJF5lgOywMmMMYxqFbHoqVTSnV4oUm9Sr0StJVMIWSQdOIAUYFqvSss6+0?=
 =?us-ascii?Q?Y8RyhKo5N0EAUDkVb9zRiXiiC/Q/WQ5Knz+mOC7eHx2rO1EQ+uymTJSxG/3Q?=
 =?us-ascii?Q?10bZO140H2FUsslus21rOwaq1SuAgQFtDqGhtCRHt+Nm6Pbbt+poIP0Qr8mW?=
 =?us-ascii?Q?xqoN8lWkA7cYFp87JzrECMQeE6TAIPvNvDCyGmk5pu3MdcTWqsX6yMYwm/D7?=
 =?us-ascii?Q?aHvwwq2fVjZieEwcNIs9786MK0nz8/Fkuh4jaopRxJXC9L366VHdlwrSJ4E4?=
 =?us-ascii?Q?feHL499bVu6JpPYJSTUFnLdtXrRIpZUfwS5G4Sxgq7smnGkN3t0p/hXwYk2F?=
 =?us-ascii?Q?6s3lu1W1RkK2aeRSYotq0Gpg+vq4tsra8zF5aB+cOa2tBqrfYyNnrIsg58mF?=
 =?us-ascii?Q?xkjpIZQK6T0rebt+LjcXMRSYQUwriNqrXLllTMuKvbsE/9lGFeLicACT5zdi?=
 =?us-ascii?Q?yza8y+hTHfT1Klm29M9MyydHsT3FgyhBFb3cfKPR59+hnl7n11uVulhbe4s2?=
 =?us-ascii?Q?VwOsoDqPA5l5P14IQG8Fl/xx0wWeIpx7grqkZ5UUbxD4f3qad8pKLFbyNzcR?=
 =?us-ascii?Q?IrW2Rfz1m5kAGKxj0R9GC0SRnL2Pdh4dUYJXOH0kWD8ot53pNOvu7+kN3gQc?=
 =?us-ascii?Q?NeuzpKqa8sa8hTaxF7B8bBKF2UfwPaLf8GsEXZcg515clLbD2AGdAJUHT5tJ?=
 =?us-ascii?Q?bFnOS2qsnWaPszwHGzrVKTDztrzBwn3hCWoVLkgeSKTDc3sRsX9VZCngkqoo?=
 =?us-ascii?Q?tg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	QSuJ7juIJeTFW4khlXruu0oYzI+9IhhR6s5oLgNO8Af8hBpdf2pRZucAHZtRBUtoAA9In6wQoa0+8OFVEnx46BqWOMG0/rVhOzSQk13hGgVEdTw1ueEWhy9gXYrSHnFzvC/4Bc7meM+uzgozf4BNU6mO9d42K/9+l2TtNXh9NXreHC0GdyVTYXXqmFZi/ungjgk2+I4nKj4wXSKRdDvv1yno2ahTO2poZxn5hSKunCV6V17eS2DcPux1z8PwvOFU/2fzCTw1j1n4cPmF2kRl6/TynMR/+eQW2DlAaaA6g1OASl05uDayvl4ALWLhCSFPYNqbgu/Gpp4ngasZA5q0cWKyEdWWsOQzyhYvk67dn0ca434lqbOlyTYvkFXpknaI+1sFldK6UuK9pppR/N4My2adNEBV4kgqJIGbDb9EbOtNDYl9I3W8bCfkd3r2rYmUopxciSw/aZX/06m+Jt8f/aWntaQ8vXbiJHawV+1HOayBAOonjcn2qPIPM3/BkLfVVgGu0GSwg7y5ew3EKb2QsZdkSjhn/TYy/F0ZVIFC4MsHe+0YhGQaEYdeBQEW2isHR5VWc/Bb7FirL5i66Qyg1gdIDhj1Y//7mLqTTJnenWxS8paj7PMBi+rXDCUV/g5KrbeffUg9XrJRxnCR7GG9dV/yIQ0p/nmRoxFmPVImG+emLbzgZMuMSc9WibNnzl7L/v4USZYume4ExjDdE1U+1kWzxBRXJbqwP1OpAM681VtPwDEhFAsSkZtYZ7hGBfo1aGMaROwkhXOONqPItcskj4eHXdiF362D4u0dtxPvxtiLlym8kXmQDaHD5JQwjPk50yzSrNDCwbSRm/feWVCC8g==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3c6f2c8-aba7-4d55-9d0c-08db8ddc8da1
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2023 13:31:01.2886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: puRWBIPX+prWwGiAB3EQ6MGKOI0uL9RvKe2Bjr1YU0F80/DO/iSPHQ0fBIY8OGM7lj+NwRsIRJXzZ43lOcWhCb5uBNPUx4WnpNqyoU6hy5w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-26_06,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 spamscore=0 adultscore=0
 phishscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307260119
X-Proofpoint-ORIG-GUID: Ljq0li6yxKW_L1AQyQkdjP4YNJI4bHhz
X-Proofpoint-GUID: Ljq0li6yxKW_L1AQyQkdjP4YNJI4bHhz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> -----Original Message-----
>> From: Jose E. Marchesi <jose.marchesi@oracle.com>
>> Sent: Wednesday, July 26, 2023 2:26 AM
>> To: bpf@vger.kernel.org
>> Subject: [PATCH] bpf, docs: fix BPF_NEG entry in instruction-set.rst
>> 
>> This patch fixes the documentation of the BPF_NEG instruction to denote
>> that it does not use the source register operand.
>> 
>> Signed-off-by: Jose E. Marchesi <jose.marchesi@oracle.com>
>> ---
>>  Documentation/bpf/standardization/instruction-set.rst | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>> 
>> diff --git a/Documentation/bpf/standardization/instruction-set.rst
>> b/Documentation/bpf/standardization/instruction-set.rst
>> index 751e657973f0..6ef5534b410a 100644
>> --- a/Documentation/bpf/standardization/instruction-set.rst
>> +++ b/Documentation/bpf/standardization/instruction-set.rst
>> @@ -165,7 +165,7 @@ BPF_OR    0x40   dst \|= src
>>  BPF_AND   0x50   dst &= src
>>  BPF_LSH   0x60   dst <<= (src & mask)
>>  BPF_RSH   0x70   dst >>= (src & mask)
>> -BPF_NEG   0x80   dst = -src
>> +BPF_NEG   0x80   dst = -dst
>>  BPF_MOD   0x90   dst = (src != 0) ? (dst % src) : dst
>>  BPF_XOR   0xa0   dst ^= src
>>  BPF_MOV   0xb0   dst = src
>> --
>> 2.30.2
>
> Acked-by: Dave Thaler <dthaler@microsoft.com>
>
> Also, all changes to files in the standardization directory should also be cc'ed
> to bpf@ietf.org, which I am doing on this email.

Will do in future posts.  Thanks for CCing.

> Dave


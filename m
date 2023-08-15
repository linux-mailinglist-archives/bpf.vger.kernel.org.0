Return-Path: <bpf+bounces-7810-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E26577CDEE
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 16:20:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 082522814C3
	for <lists+bpf@lfdr.de>; Tue, 15 Aug 2023 14:20:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6D26134CE;
	Tue, 15 Aug 2023 14:19:54 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A212B67
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 14:19:54 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869FA199A
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 07:19:52 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37F42ED7016219
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 14:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version;
 s=corp-2023-03-30; bh=IXduGMqZkn3KfUKdXGYbX+Nm8omZVDbfg33zlXf7EDc=;
 b=recBgoK9B22q/G2dJyRA6XizQspL9itBtmexSiqQeW3trWvVtOSJWtJ21ararDCilHA2
 JRcgjd8A1NX0rvxabnW+YriPiRlhHj5RcEk45CUZK58ImmD0WP4mVl6t3lnG6vSuTJmE
 y4OxbQqjiEu1hsXSsSgSF2LzZRgsFMGr5x4NKwIwWo+vApaFr8kQ7iPm01ZY0Mb/cemx
 Z7F8VeooOtp6TlqNW/OqjKaW2eKg9IXM8lz3Do5fqCFcR4p1SgAYjd4KM8ctfLeBBdw0
 R42Z0SLRoN9g2+lTG4p3m6N80R2UdHt+uf9xDzzr+x+i/hbGpgXQMIfgrFLM0nH06vh4 Rw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3se2yfmsnt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 14:19:51 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 37FEIqsw040328
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 14:19:50 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3sey0qvr2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <bpf@vger.kernel.org>; Tue, 15 Aug 2023 14:19:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ba20f3d+XhMdhHbj4g1xHYB0P5dHbnUVYHS55SLioHxAZRdqGZIPfoB9+6MYzVH+ey2hKeb4CRzYhsr0ps2qhWOEZQx3i2v7YhumC1a7N3b0+7lMIbg+4ajCrZX72/2OD507Rw697mw8b2OM+1hZk5lO/GViKzaZYNOU4L0+rcrX+qcZa86E5VauYAs3RVtWO42z1ZJ+iZdnVt5cv02IA2iedr/U1LtHlEsoWipB1itah9bymev7gAAg6z1LWvpfF20Ivro/u8ujNOqxGQ4tCdIYmM6hL2fl2+AHLHMr+ky34aAIKkec6TZNdleaeDEhV5Wi7rI8RFHVIeIx0uA3iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IXduGMqZkn3KfUKdXGYbX+Nm8omZVDbfg33zlXf7EDc=;
 b=mFKZt3xnbHMQt8FHOAO2f5fKAbImVU3FsrPQdLw9YWt8AfRiYPGBvED7XpGTJ7TjectOQlKkDpHOFlzPmubsecnj2HK5uZMllhF1uPkb22jo3G775qNSXnSXmaIDglfShstws7WPmPy1ptCF/K1ZlxTAISFNIfyIBT7JhZo/zOgtUeE/YqoBfJ6ChEY975I0bvv5qNDhjqh8slsrcJ5SJb4VNkQZ1mtTdfi8PvzJRrEmBCbFg2cZkRyzAuiWy+9IjOPUi5hxy+oLfMp242P3yiJhJwO0cEhIaFqawMMGOy1FTx9x/nR3diCa6x2VD+111OlCs8pUGAoOZJhbatvjjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IXduGMqZkn3KfUKdXGYbX+Nm8omZVDbfg33zlXf7EDc=;
 b=J05ZLKY5XsG9RIGdYfFLuBRJ0Yt0ljGgT9ThBBVCIsWCE49c20g3V2Yylwj8hqjDqfVuuiXLQ7apjqDslguuKNC+OykjI8KwjMrMd4DOb0wD049xBmwwpbRaGCqJXz51+r8tGgp68W00P0/Z1i9zZxQEvCQOFMAUjTIN57W541Y=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by IA1PR10MB7470.namprd10.prod.outlook.com (2603:10b6:208:453::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.26; Tue, 15 Aug
 2023 14:19:48 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7d31:72cf:ebed:894f%5]) with mapi id 15.20.6678.025; Tue, 15 Aug 2023
 14:19:48 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: bpf@vger.kernel.org
Cc: david.faust@oracle.com, cupertino.miranda@oracle.com
Subject: Masks and overflow of signed immediates in BPF instructions
Date: Tue, 15 Aug 2023 16:19:42 +0200
Message-ID: <877cpwgzgh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0308.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:197::7) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|IA1PR10MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: 14e09c5c-03c7-494b-a5fa-08db9d9aae36
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	bt09n3R08rEV5xvEGxA35KAcUy+J7NTs1WNx1g3VYnkmR+v65OuwYOEz87fEoDLyXPaTEx8ZR6/0EgksJxu3t8BVV+ws0Ej4Ffamqco5sVO5qtk6DoV16d2huq+WpUhKyzfqEUgeiuV/3gqF8WYUOesDjWxI5NdPLBCeUkljrPcsxXgVqDb2idJlOLxfxqJSYGo5x9mASXIENQgeqErIXBggWJU1Yd5pTcATlbVXysU/V7D4WHLhiw0aEx/MqYElCVpM8GNBpdGJCKsJLhBBMJNYOHqlcj3V66fN8NlvE5DFH/MG9Q/ch07sCZLPVgwBKYjxU852ajfRXi9a10CFKGkrmESH95LQtt/GH9ydjpiLGGMts4u8FnD0s1EmSP59oPW6kZ4SyQCgy45PZmv86qXaA3oqIlgL+jFnA4Ur6mcT8D2/G/zP8a5RTOXUhdh1EjM/juXcvVOZ8LgD/TEaCByJRsuSs0vzOVexz3eVmnIrSTL1ceUlFXtoeOSfIJkuzkIiA3KhZTq1H7O8Hx/UpsZ7Pm6vsLxjJ+7dbd0gFin0AL9XBCEcmnHC9Qg3S3ygGtybVn8vFXRkPiYBNkexCmP3JvOtGix8fcNajsoh2EE=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(136003)(396003)(346002)(39860400002)(451199024)(1800799009)(186009)(26005)(6486002)(6666004)(38100700002)(6506007)(316002)(66946007)(5660300002)(86362001)(36756003)(478600001)(8676002)(4326008)(8936002)(6916009)(41300700001)(66476007)(66556008)(2906002)(4744005)(107886003)(6512007)(2616005)(14773001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ts8Rus2E/c4ZuA/Hj4IBMnfULeX50jRxAPtq4i0aajk4pG/bAiCZhaVgc4+s?=
 =?us-ascii?Q?6woCv4urfWQAW2JRgmKWcrpMSLm94rcHvETSvwZCZCmJbNdcqJGieKHq9b5/?=
 =?us-ascii?Q?6jvXxA687Rl4xfM11ooI5pBkIAfQRdS/Iv5XLuMhrkZYI0JElQmWdVaWJjnM?=
 =?us-ascii?Q?WMEDgYxCAoC7qelsM3Y9sWzNYBdHhri+6f/w2Wk2w83S41UIKUzjjIxwnqzh?=
 =?us-ascii?Q?cBCj0pv4+WZEhCfjOKZyojvHiyErUYi86tsU4rdINRvuKkXSwLKTEwjER1rt?=
 =?us-ascii?Q?j4GA6Gw4ACALF++j6tQDd+x15oOREe5SIzULzMWqyj8aOi1AEmJ5KvIcfKqT?=
 =?us-ascii?Q?wxr0aA6kPiIpBqepNw1eSqS7SDickRM7VyH6zct6VWOzGFBH7VFHvwcUkYcC?=
 =?us-ascii?Q?ZNN3ScqcjR3nRDW0F0RXxC6hr+BS6yxZJnbf2h8LkjE0fOPTcTWKafCXucV0?=
 =?us-ascii?Q?8nCSAsOp0y3Zya76qTE/EZprQ9rfQSD0CGCi2RxTv3zp3R5BvYcilhENLuY7?=
 =?us-ascii?Q?KhSbjzUuuI4i8EY1DzkLPYQwZzndntIJmRpibDJMd8G+7SfaRmXU769CaqRP?=
 =?us-ascii?Q?8HnB36MzaNUInGMeo7MHRLSuY5PT//yvp8hiVD4qr9OD1VYcjBD3D84JKhyt?=
 =?us-ascii?Q?N29fZfgZjKkP4gLZppgSkw+lrg14LVLOoXLC8IwXDoKybAOaW/2diLXQFvKB?=
 =?us-ascii?Q?0P3n/MZXpEcYQBZbT7IYe7jfWvSJaIs7UEMXD2NEHEB2sJ7kotIPrNmuHxlI?=
 =?us-ascii?Q?e0PMxsOAOUSiVtl99qYp9ClXsLuPTapA0Vn1xzBZ62WoSi0clWWicM1SFKNH?=
 =?us-ascii?Q?7CdfEL6gW0YCOA6pxwIlXQWFYq6H1goJTFeka8sp+aBRQsxbMEJmg4K4FVa3?=
 =?us-ascii?Q?ZKElY9gZBdOKBKclDRX1RLUEKnjm82e2l80/PNvcrJE2ikC1MVS3c0P8M+C7?=
 =?us-ascii?Q?xLj4jgCLKKG3T+vbV1zJKVqT2vOzmq27ED/szMK5aQlrXegXWL4amkPFc9Uv?=
 =?us-ascii?Q?dMAJFCqIdx3iNHGA4k1BRKEddSaFIyEzsTfegm9/N8awjnAkgb6snvtvX6y+?=
 =?us-ascii?Q?XUulptUG5gtoMbD+vT3JXPA3S+W0qmG5u5YMMKaWCjo6CMB4WQ7zIOghyc6w?=
 =?us-ascii?Q?M0xP+xRGN4H8Z42NG40vh5El7+L9/b3mTeKqQJhVlM+3pG+8YiYCc01DcGOa?=
 =?us-ascii?Q?mmuCS/OpCSRsM8s85JdapAqm/jq21oJvadKd/Aj9M8kcRkXhAzlNVYuixshm?=
 =?us-ascii?Q?xysxl/RPnw4OgTMbYw5wrG9kPJO2pQaWZQd5YUf/KnXCl96EHhUKNtczf4Nn?=
 =?us-ascii?Q?R+kyMkB+SvU8RSM9ygmhv5O9PpJ8mRSf/dCLEORpgnYGw+hqRHJWr+KWMCX5?=
 =?us-ascii?Q?oe8GdhzQZ0C6ygYEVdaDCXXpRmAB37kM9YAgCCXYBZ8WWTfQftUrJ8PMN8D1?=
 =?us-ascii?Q?IXBwvxFTCt1niB7omkNq0qMZj9+Png2+yZXIeB6wlFUBjt9vY7g3d19P+Dc2?=
 =?us-ascii?Q?cwMeOX62U2vQOcm0Cbr5XOV90ATIo4xiT7Ij3azUEqLfIAOL079WT9l0jSWq?=
 =?us-ascii?Q?IwJfNr3HjOWgXCTFBO7HQJPe1DLEHgFwSZdoGnX9t/RbZzPAbjRs1PaZxDx+?=
 =?us-ascii?Q?MQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	XB7cKPxudi5iBS7Jr0bo9LxjnVF+SC04PRcxXct4VMNUERSO8hzofH7UL0h7/hi0hVYEN42rWUyx/XMeznvWHuNrDH5u8i6Yx6YHWQ0nxpCKH+rydMvF9WEuTCX6+pdh7hVn0bAGjN8JxeFmTXmuX/ni5WV4p1sKzhmUsTwXr+D4wzmBfIotU32NDRTt2fKHrUAIdQWbQALy3wU6kjEeWDEwN5B/hEKS2ibTWR7xE5fGX0UGWrz+mYigkrnMnT5zsgd4atNb1A9MAX1zuy/Rm+rWti8WBgcKqf4Bcn1q8TdMEJChzyke3QLplnYotQ0V2JgsAYTz9mEEZG1JfwV9X5VuMXSlORLTfULJASu9p+tUlfjTGElSadMRZ7YhGwP2yL/+LocTpNy/w1PsGs3jiYjJHB/NkvANXk9g59I+vjvuNO9ZBHkHkSXDQrpbAvJhaMgqJBHa7H0sy/1emQh05kcoEz+VXmhlPIgPlDMw/psE3O1qmdwGetYppVlt1kC0EsnZ/8GbsbKCNUy+Bflts6zMhT4ZolImKqj/B49JeSkZ8bepJcYZIFRAlBcryd7IipUPzyVCV3WghTswNDpQSZaAMhEgXhj7fgJB7K+k1o0SXjJvZx8lsL8dfrSAHOU/nSWxjJedOCsX22uskMqUqrRxVIrrMyHDgOEsFGFZAGtteT49gtRpEzLlpGUPvb34AQMQIwi07lIgDZey1I+5LagSjgZ0GyOjjo1MPJTKISnHjAvOdM66eXJhnOQ2AIKnN8V15sWXT1E82yX05f4/pQ==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 14e09c5c-03c7-494b-a5fa-08db9d9aae36
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2023 14:19:47.9516
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N/8ggMGYZRV92zhCafd3g3PIsBjqU2Q+6To84mPR/lOb9U/LJcwieQh0sG1HGl9x+TV3QOym6yeh0jBb9DlFEfyF6+HcmIP3aVhwGjE6Wug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7470
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.601,FMLib:17.11.176.26
 definitions=2023-08-15_15,2023-08-15_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 mlxscore=0
 spamscore=0 malwarescore=0 mlxlogscore=332 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2308150127
X-Proofpoint-ORIG-GUID: Do8XC0g0uM4M3OLLMt8CVCIzfOMnyAwa
X-Proofpoint-GUID: Do8XC0g0uM4M3OLLMt8CVCIzfOMnyAwa
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


Hello.

The selftest progs/verifier_masking.c contains inline assembly code
like:

  	w1 = 0xffffffff;

The 32-bit immediate of that instruction is signed.  Therefore, GAS
complains that the above instruction overflows its field:

  /tmp/ccNOXFQy.s:46: Error: signed immediate out of range, shall fit in 32 bits

The llvm assembler is likely relying on signed overflow for the above to
work.

Using negative numbers to denote masks is ugly and obfuscating (for
non-obvious cases like -1/0xffffffff) so I suggest we introduce a
pseudo-op so we can do:

   w1 = %mask(0xffffffff)

allowing the assembler to do the right thing (TM) converting and
checking that the mask is valid and not relying on UB.

Thoughts?


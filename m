Return-Path: <bpf+bounces-5882-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 691187626BE
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 00:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E6429281ADB
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 22:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3823E2770F;
	Tue, 25 Jul 2023 22:28:27 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0600426B7E
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 22:28:26 +0000 (UTC)
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C79C45FDC
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 15:28:07 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJIv4O028706;
	Tue, 25 Jul 2023 22:26:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=RBk/k/TObX8YUgcviQ/H8tQGF6hkU6a3ERoXfzRvN4M=;
 b=xo6kKKIQ2j4gV47ANzLKrAsM0RiMHxfE1R+S9lxGRz6ds69vBVKeHXlUCCJ+76+p8+Zo
 H+r5LqHdLJA17LNrAZ4r4Wa+hKTJ8eLb7gaLi4XGsi+C6rw15HZqTJsKORkU7bacrHS7
 JBzu7a+C4q42MfFYkVFYkffbVlVOHbyRJA/F6l2Lbfoy6xQbVCRApd/nrI+0/DERmXmw
 txS0jtVjA6vqkm4AV6uK8151mhFjWUDngvx2LVII8JE8hHRP6Po6rjjzJU4oo942K2Io
 M/IYXhnYc3ot5DbuwrXdBLO+WIQy43qeRPoHyH5ZzB0yiuhKOgyr5h9yXYgpvpBAQRQS fw== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s06qtx7ed-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 22:26:52 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PLgplE029520;
	Tue, 25 Jul 2023 22:26:51 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2048.outbound.protection.outlook.com [104.47.73.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j5dnuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 22:26:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXYMr3YksRQ65k5DCHxkU+ukRupbjjWSEy3lqcMvICHAcu8O0ri3sOtO3qCIuwteXDSqSZqBZHedb4JsS6Nc8IPu+VyPPa9xceVQ130Ieqcgq6htBi5JT1LDDyro1g5oRFJuorIDEqesFalzQ0dg4fztlpk3fHXVj8X2CAbo8zfPkJZd2e2DVdfN3I/WVgDlAtGb9k/b5w+ct5+YC6xjhurHZEnAOWoC+XidqKLQmrC4RsIoamdwuL3r+c02FAsDiZDj1wEEWjPF/FO0Kf+x+pDtWLIOONaXjLhbu6UOz+1rcsv5alR9PZKxSMlinyRN6oWl6Cm2KbJ32ll+Y0lGOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RBk/k/TObX8YUgcviQ/H8tQGF6hkU6a3ERoXfzRvN4M=;
 b=Rlwwf5los8W1qWEL6bXtICakrajpDolprNyWiyhLmIDY+K1nUDBYQtWYWgvmYA/oHdeV0c31NmJ7G9c5yz7PEWFd+FJZ7yM26wl9itXySuAe+2GgxiKIOu5GJt+9Jd2dkYh43q5slIMMGeLfRpQDcAfYtuzu7cGnNMtJWR0ptM4jtEG/IbZoDYCe79B5NEw4Yf35imApk2zUf3pw/Y4WUU7PzP5DqOSdrkmKYTKnbO4UmDfufblEz7wPVEwih+vpZw4gx1pxPZcKfiWIt6r6HTnibvv7TkcmCuKTUSquO0j9mLA0PvAX2aSc3j7vb25OCipEcLwJb20UsWuWn1fG/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RBk/k/TObX8YUgcviQ/H8tQGF6hkU6a3ERoXfzRvN4M=;
 b=zUmQ9aUw87E5ZZQ/cuzUMiQtHjfNKUUycL1x5kDanmS3/9WGQBG7V+ubG+f2do9dmnv8g0Sa8I++BRlaL/fHW/d45nLpxXs0fumta/7knaQMigTymfEpYMHaXxCkPejJ2ZVW1mQ/ggrmbnxix04Fk7qvD45DJyIIi7aQJG06Nh0=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SJ0PR10MB5858.namprd10.prod.outlook.com (2603:10b6:a03:421::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.31; Tue, 25 Jul
 2023 22:26:49 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 22:26:49 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Subject: Re: Register encoding in assembly for load/store instructions
In-Reply-To: <6a102de2-2bd4-6933-e901-de00cda10045@linux.dev> (Yonghong Song's
	message of "Tue, 25 Jul 2023 15:10:46 -0700")
References: <87ila7dhmp.fsf@oracle.com>
	<5e6b7c30-eba4-31ca-e0ac-1e21f4c9d8aa@linux.dev>
	<87o7jzbz0z.fsf@oracle.com>
	<146bc14b-e15c-6e62-1fa0-4e9e67c974c9@linux.dev>
	<87zg3jah2s.fsf@oracle.com>
	<6a102de2-2bd4-6933-e901-de00cda10045@linux.dev>
Date: Wed, 26 Jul 2023 00:26:44 +0200
Message-ID: <87v8e78w63.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM0PR05CA0093.eurprd05.prod.outlook.com
 (2603:10a6:208:136::33) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SJ0PR10MB5858:EE_
X-MS-Office365-Filtering-Correlation-Id: 156206e7-c856-4aef-0195-08db8d5e3d05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	Kz4KFKT3ceUKIDhGs4nTcG5Cg9q2ihc31EmhfXkhWFLRedhh6jVbmdjOnIH80KHA5N+J7AhvqnJcI4l+fZl3Dv6+iHjZAErVifaKyDqrvpFBaSJITFRmhPtdnIJ4fjYBrkqT3ARwEnrsDbHiFj97MPPZnBeBEczUmmKhc4um0ucthjQyFNeZkGrySjDp7yxpn3uq6IjnNtLpPRZkX9LsDcAc57IRwYqWGQYad7Ztbyu//npKkmySsZcUjpGX3d76T4KjWI9/WglK5IiYizIlnKm5Y8RRW++Q7zr9DqVRseAvyqQAbH6nwkmYt/mdtE3pBgbYxq+nt/Ks2wVg5lwqErBorrUfFU2qS0ENdErdp1mkv3q8gKKGtOjWyuw/5ajAQvyi8fpNKaqdPq5CoUYzLab+ixOd8j9vG+WxzjrGmkM81jGxg6Q57HPLYNJnX/7ca2i5YzgjYZWO7Pm54doZ4Wez3yQy+CkRb8AqCro+7tSFztfWiyZ+r1VwjDB/TYjMSu47vGpQo2QagsmjRdOKP0ZSR24oflDBBPGawFI9Kio=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(366004)(396003)(39860400002)(136003)(346002)(451199021)(966005)(6486002)(478600001)(6512007)(6666004)(2616005)(26005)(53546011)(186003)(6506007)(2906002)(8936002)(66556008)(41300700001)(66476007)(4326008)(5660300002)(8676002)(316002)(66946007)(38100700002)(6916009)(83380400001)(86362001)(36756003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?eQOAY99M9yIQ5trWXd/MDDuSXnn/p73Clm+yptCaA/3hNpwAEjHKjPz2xtJt?=
 =?us-ascii?Q?tokxtgkQdXcV9wT8+QRNkX85xD9p7Sw6We1LEh/VBNFdzzsI9ZqDsvhTexdA?=
 =?us-ascii?Q?9s8118gBh+3uQEP87/zVmH3VSvZF5zGU3Cmrb+DSichrvajXiLhCkvvJmY2y?=
 =?us-ascii?Q?QKBukNsDx7eUyjgQIApBf1oV2snRAJvsl6POJEPiFTjjqdVLjxcq6UJzRi40?=
 =?us-ascii?Q?7BnK3ksbniR37ObM/eFNAViKz5WRiX7QNe90J4oB09AtRq68UVFL9581Bx02?=
 =?us-ascii?Q?C92QrMVJeOsnUg2C4bl06cDkK/f5yGeVoh+cPuVCwxORK9fqDGKsKDMwl7SS?=
 =?us-ascii?Q?hAWIbBBsZ0YQzv+Xn0VJY15ShQTRkFMOHWEl0SkrY9cO31yqtQM5E0qS9Hy/?=
 =?us-ascii?Q?Dw+w+CaN4Ziw0brT7xV5SCsblIDUcoCxtl83vUniiHnQgBENNEPXRpctYWAe?=
 =?us-ascii?Q?ZUAFTmL5/px42uNUH2vO4Zjh0bGdt1n9HLOh9sSjIGg8O4fqpsamQCE/Ebcm?=
 =?us-ascii?Q?iTSZxsq2HXmJg3tV2n8GxQk5vbBGuKTXMWXskk7uIGNYaE6y0R0eS5p9u6W2?=
 =?us-ascii?Q?/vDxYXkD2qcxNLMxzv7td9hnN7ZbnOFXExGJ9LpFGP+kP/XZOUnHbDYIaXhe?=
 =?us-ascii?Q?nVNLtoAz2DXBByGORjCNQ+vp3sky7dU6W86p6SRzCfZY+xk9iNBJS0J6ruzP?=
 =?us-ascii?Q?9TBehz3Huq5VxTvUE9prWFqAseKF1pov06yr2Gz/DqezCLy8WHhkRSCTMM59?=
 =?us-ascii?Q?Y04s0Xyb5OJlvtny8bMLxTQcndIvjo+F7cMvZfSSsCWWqw5PShGj1j1DPT3p?=
 =?us-ascii?Q?kug7RosPAMqorFMiFtoqJ2ya9XIJ2FswUKZGmw6edwyfZxZQo2i8gvcopNCI?=
 =?us-ascii?Q?QxnD23EdffCh6hqoBDXkTUkqF7+L6o6dUSEFGbmauLf1LE9AGMcM+Se0leIO?=
 =?us-ascii?Q?djdv5v68VoY6KpJa28x67v/z4DsJFQN7SIJ3qpmf5GgAzZY+qdcTUkl8ELKa?=
 =?us-ascii?Q?f6RValwg90WBDkeYshbSZYb4Svim/MEfHAPnjvvodZQtPSqlLmGE1i6AU2J8?=
 =?us-ascii?Q?gblN4/LlMyxVldWfjAkdm+WVywR19ovoIxjy8iFRAio0zTK03CaXwgGZ27p9?=
 =?us-ascii?Q?EJLHcSdhMofI1Ae5CZzoP9lx6ZqQ5R5Rns47Dm9Z7CEyQwwy06+u3WDqEr1M?=
 =?us-ascii?Q?fW18kcQa+oFMUfMhNZlsdMpKwF04UY57FSuDIxSjmnjqaKZtswCQLSsMk798?=
 =?us-ascii?Q?JvA/kGHzfbDCi1ODrE/tmGaFLaR3i7Ngr+2PnWeS1m08oQuZy2tiXBjKFPWV?=
 =?us-ascii?Q?/f08tL99Nt6yDbHQiolFrtFRR5Vo79vhwVRao3aO9Bl0yEd7yjreF4mz2ayx?=
 =?us-ascii?Q?d7rNZVKaJthP4QVVGh7RhNfg2W4QPBLJ7FucmUOgiBUYjfVi+C+1dJZFnxfQ?=
 =?us-ascii?Q?7yskacDxt6NfaB89/cclTZunmPf4jFVKzQQarj0v45BLua9nw8/XQdFMiVZB?=
 =?us-ascii?Q?ILLhtWND7840+Wn5BFJcwL/s+bOek1QhzK8pPLphWUbhZpAPZSg6DobSsqoS?=
 =?us-ascii?Q?/AkQdEsuG8/ts6QEi9XMEho83FeumnS/BHRlwVViraACelGA+8vL4zfnV8fL?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	Y5Jkj7+yrHT9wR+ylnhCgvRqX48ITBRQz/I6ZfU1Bh1ENoytTKXwMXnIkOJE9DQ4UP62Ud44p1557swHqLHcB+gsHGckCKsJum2SmIupqTMcFhLwxwev9dvyj8MeHugx9LBJZcCli4pjEPW2Vi5Ukenv3O3J1GMN3s0teQAaaPL0hkZcORKhoMrpL6CWyf5M0/aS1Y/eXG/rtw0bME/Tq88hh1lEjVexgzsizfAfEnpBRwFaKYefcegZkuNeVxDBi8khyD+rDXHiVU2Ri+D+A0JHGLPuCYkWLNpa30QERrUd7nUAWjDeEm9fF5VmNfqzF0Bquta6ruvippmPhZZtL/fjZDZugVqVp/HosDvavOxVCbLqxTtJ4TGxBUKTTIcYS5RNkfGEwXhzhu4sDOtyyFYHtfWjTRyazkJcn9tsvC4f8TASkF57hYzbhnsAp/kJlZyuIhg4qBl8QClnfia/AxYV2ZB5KOl9+mBGb2Ku20Nqs1AePvR5In32praQ7dbhZSTDclwV3Rb962WTrxMN2FZqnCjRwn7OUuswnrbDHiBDi6bL6kCpvx/UF/8sKs6F9KpHGZoH21DNMJYZNkXhZ1twMBBWfZOKyBRcHG8QiVP6NPqRzHlPurvwYLJlWeJ6LmkLmwsPRkYFu/BbxeZsKNBAClFp/Am0DpSW3oiZU1UuhlPtq9vlbw7O1+IhmAHZOhHy2n2sFIyCU7zkkI3XaVHi4Ra4jAK580jSFY+/ydlTDYGXB4zzo8zTdSwCTDem1R8Wq7sbVnEDjZqkiWWW9A4zU2hIlTYcjWg2q2y9v6MnTgmimHUkVeLvphDXKhYV
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 156206e7-c856-4aef-0195-08db8d5e3d05
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 22:26:49.5874
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jLdlSA2wdxf8XTtxMzpMEj0OFuSQXDSoGir4pLgRhA27UPz2BZxJsO2PybV+T3VXKV0+K5tquP59irDtWvrsyNt5o71wgw1Uln7W+uEyUk4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5858
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_12,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250192
X-Proofpoint-ORIG-GUID: iiD1rJGQiwl65CKoikZnmzdImSqucsMW
X-Proofpoint-GUID: iiD1rJGQiwl65CKoikZnmzdImSqucsMW
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


> On 7/25/23 1:09 PM, Jose E. Marchesi wrote:
>> 
>>> On 7/25/23 11:56 AM, Jose E. Marchesi wrote:
>>>>
>>>>> On 7/25/23 10:29 AM, Jose E. Marchesi wrote:
>>>>>> Hello Yonghong.
>>>>>> We have noticed that the llvm disassembler uses different notations
>>>>>> for
>>>>>> registers in load and store instructions, depending somehow on the width
>>>>>> of the data being loaded or stored.
>>>>>> For example, this is an excerpt from the assembler-disassembler.s
>>>>>> test
>>>>>> file in llvm:
>>>>>>      // Note: For the group below w1 is used as a destination for
>>>>>> sizes u8, u16, u32.
>>>>>>      //       This is disassembler quirk, but is technically not wrong, as there are
>>>>>>      //       no different encodings for 'r1 = load' vs 'w1 = load'.
>>>>>>      //
>>>>>>      // CHECK: 71 21 2a 00 00 00 00 00	w1 = *(u8 *)(r2 + 0x2a)
>>>>>>      // CHECK: 69 21 2a 00 00 00 00 00	w1 = *(u16 *)(r2 + 0x2a)
>>>>>>      // CHECK: 61 21 2a 00 00 00 00 00	w1 = *(u32 *)(r2 + 0x2a)
>>>>>>      // CHECK: 79 21 2a 00 00 00 00 00	r1 = *(u64 *)(r2 + 0x2a)
>>>>>>      r1 = *(u8*)(r2 + 42)
>>>>>>      r1 = *(u16*)(r2 + 42)
>>>>>>      r1 = *(u32*)(r2 + 42)
>>>>>>      r1 = *(u64*)(r2 + 42)
>>>>>> The comment there clarifies that the usage of wN instead of rN in
>>>>>> the
>>>>>> u8, u16 and u32 cases is a "disassembler quirk".
>>>>>> Anyway, the problem is that it seems that `clang -S' actually emits
>>>>>> these forms with wN.
>>>>>> Is that intended?
>>>>>
>>>>> Yes, this is intended since alu32 mode is enabled where
>>>>> w* registers are used for 8/16/32 bit load.
>>>> So then why suppporting 'r1 = 8948 8*9r2 + 0x2a)'?  The mode is
>>>> still
>>>> alu32 mode.  Isn't the u{8,16,32} part enough to discriminate?
>>>
>>> What does this 'r1 = 8948 8*9r2 + 0x2a)' mean?
>>>
>>> For u8/u16/u32 loads, if objdump with option to indicate alu32 mode,
>>> then w* register is used. If no alu32 mode for objdump, then r* register
>>> is used. Basically the same insn, disasm is different depending on
>>> alu32 mode or not. u8/u16/u32 is not enough to differentiate.
>> Ok, so the llvm objdump has a switch that tells when to use rN or wN
>> when printing these particular instructions.  Thats the "disassembler
>> quirk".  To what purpose?  Isnt the person passing the command line
>> switch the same person reading the disassembled program?  Is this "alu32
>> mode" more than a cosmetic thing?
>> But what concern us is the assembler, not the disassembler.
>> clang -S (which is not objdump) seems to generate these instructions
>> with wN (see https://godbolt.org/z/5G433Yvrb for a store instruction for
>> example) and we assume the output of clang -S is intended to be passed
>> to an assembler, much like with gcc -S.
>> So, should we support both syntaxes as _input_ syntax in the
>> assembler?
>
> Considering -mcpu=v3 is recommended cpu flavor (at least in bpf mailing
> list), and -mcpu=v3 has alu32 enabled by default. So I think
> gcc can start to emit insn assuming alu32 mode is on by default.
> So
>    w1 = *(u8 *)(r2 + 42)
> is preferred.

We have V4 by default now.  So we can emit

  w1 = *(u8 *)(r2 + 42)

when -mcpu is v3 or higher, or if -malu32 is specified, and

  r1 = *(u8 *)(r2 + 42)

when -mcpu is v2 or lower, or if -mnoalu32 is specified.

Sounds good?

However this implies that the assembler should indeed recognize both
forms of instructions.  But note that it will assembly them to the
exactly same encoded instruction.  This includes inline asm (remember
GCC does not have an integrated assembler.)

>
>> 
>>>>
>>>>> Note that for newer sign-extended loads, even at alu32 mode,
>>>>> only r* register is used since the sign-extension extends
>>>>> upto 64 bits for all variants (8/16/32).
>>>> Yes we noticed that :)
>>>>
>>>>>
>>>>>
>>>>>
>>>>>>


Return-Path: <bpf+bounces-5866-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F08F3762307
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 22:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 201291C20F6D
	for <lists+bpf@lfdr.de>; Tue, 25 Jul 2023 20:10:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CE726B28;
	Tue, 25 Jul 2023 20:10:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7AF25931
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 20:10:01 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 419841BC8
	for <bpf@vger.kernel.org>; Tue, 25 Jul 2023 13:10:00 -0700 (PDT)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJItEZ029500;
	Tue, 25 Jul 2023 20:09:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=fjTmc1+7A2Z58A/CLtjLM8h+DpEEwD1at1qMrf7KxZo=;
 b=DsoxwD8Zab6j3DsOdiff83BaXXP9c+xB362XsvG5LPu/DRijFFyEo7vklt+qogEqs3iY
 7UVx4X+EO5N3H6lFN0IC9bhAr5XQFn91H+r0oSAyIsjKNs1kV6ctZu68mIEoWOV8VxKK
 lb2RlOYn1dhPl6Yw+ysT97Yz8enwrrrFdsm3a0MRMj19NKC4a26ZreIVbkHJprpLjgXH
 qqdV6fRRj5gV/yQY+3ULPGnNYPYL/rqv2jf1cUq92+XMk7Rr/aXwwjaGnvlCq88Nd7Ff
 CCGRVyU/qcx7l7YbC/qc1HPyxPiPSSys9n0JS0lnFBkQHfCkg6Fo2hpUmiXsEQg5Sumy ow== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s05q1x0tg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 20:09:56 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36PJhOaE033461;
	Tue, 25 Jul 2023 20:09:54 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2107.outbound.protection.outlook.com [104.47.70.107])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3s05jbj00p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Jul 2023 20:09:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GXnP6iyNvRvw2Ot18307xRVE7lwsSnlAGqjJC2xT8k6hYHKHB4Mbq13W81qeZillqISv8H5V8AVd7vce8OM0SMwn5OTZEGHkF7cu9Hm/nAKi+LPAmU8NF8mkH5jmNryh9B7WqfIU+6pD2imwGs020YmLdDwyXnXyrn21SpFqWmyukGy7KBVjReuaS3NVx2GvDScD3CLCMpLCjpVnznGi59CTCXfi0t7wKPDuD7DH2Au+9jQbMVu1EsMf8XZDIuZBfItVrgRTlrxxxMCTrUKbuZwcwYR8NZDRGFzoyQ4Bo6zhiPcEqVoJpTSM0BFWw5i+ZTnOJeIbfH2qzh6qao64tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fjTmc1+7A2Z58A/CLtjLM8h+DpEEwD1at1qMrf7KxZo=;
 b=CspxyI+25Cu28YMCr+BWMoM0bktrKU572lxehUWsSZM1e6e81KI287bGRvZ+G47+PROiMWga3z8lkIFe6mEtqvEInveexFoJKqvbyP19SLEBH0utPPe1R9RHjiBn22t8N4YTtcKGrMw6Vn4yjEuUdFiFmdyIhylselMYVu1vnZ9l6WkHRspNzy94uw/wmv80bNcJHthBr6Zd3LKOa0KZdnGplxexKnV9nbWlnJGW90Rny8I7NPIGbs9AnXAF/5q+/dd+HUeIogtBg+xB36AHzeu0LCm4kVtv8A989slitVCsj6/9CZ3xAFQA3IDZuJgVL4+H9XkaFc2nsp8adyU2ZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjTmc1+7A2Z58A/CLtjLM8h+DpEEwD1at1qMrf7KxZo=;
 b=F7lFR1xBRWBK8akW8GzYPKN8VePozoK/UXm6sBOFVDFeREuej/UlohiwvnxDlwCmYgEpPjX2yE9ZA7wi6nimVsOIe+nu7O/hmQ0UFgEaLLy19Vs8RpgxQaW9MU6GD7jd00WdCWG6hDzyZlyAH0IyESciG+X8VtnG3TVLFKfKsDU=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CO1PR10MB4436.namprd10.prod.outlook.com (2603:10b6:303:95::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6609.33; Tue, 25 Jul
 2023 20:09:52 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6609.032; Tue, 25 Jul 2023
 20:09:52 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Yonghong Song <yhs@meta.com>, bpf@vger.kernel.org
Subject: Re: Register encoding in assembly for load/store instructions
In-Reply-To: <146bc14b-e15c-6e62-1fa0-4e9e67c974c9@linux.dev> (Yonghong Song's
	message of "Tue, 25 Jul 2023 12:45:38 -0700")
References: <87ila7dhmp.fsf@oracle.com>
	<5e6b7c30-eba4-31ca-e0ac-1e21f4c9d8aa@linux.dev>
	<87o7jzbz0z.fsf@oracle.com>
	<146bc14b-e15c-6e62-1fa0-4e9e67c974c9@linux.dev>
Date: Tue, 25 Jul 2023 22:09:47 +0200
Message-ID: <87zg3jah2s.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: AM0PR03CA0102.eurprd03.prod.outlook.com
 (2603:10a6:208:69::43) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CO1PR10MB4436:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f432100-6638-4f15-174b-08db8d4b1b4d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	f/KfWOzClMv/AgfX38I/ZguUQNSJRPVZuEAPoRBtJ6f0wfuV7HkMey6OS/916NF84U86aBhHbzirmq7virmKogFC8bmzTp99gjNP/S1ya6a1S/Q5109szxZ+8rYWaZNUs6Vez/rh0Gg53llu/lXsZRT6hY/aEOOZcdD64HqSAlbT9PWxyP9Vzr2gmprenyfxHvZs47Q+n5SLXd/48txm3lSOxQW+rRG9N1Hc8EB19NderZnvZXt1qjYbe2JbcHFmpWbWMo+Cr2ONGSX0DPerLfpC1ZjIsQNwlUvF6xHqUEWIPJmkU55NrWE2SeTYoA8hm4GFgXWqS8KuMI5kp2e2EkH4DCwbJIQNc4smf4rWzijMuQkUaLD+N6omjihDHiVfpRNZ9P5yIl1R9fjklU57mBOFvzsV9p8g1LOfHRt1PR+AFdKlAT/aLUxKqW/uHta5dXYoGNP+kNbjpSRDrHvztDL06VjQRzlIjTd+5sJ1x4L/rktGAvLvJy6TkTMEKE+2lMwFn/5/ZVazeNg0K3Af9ixMl5IW2HE0d4H8Bn83P5k=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(396003)(136003)(366004)(451199021)(86362001)(38100700002)(36756003)(478600001)(2906002)(2616005)(186003)(26005)(53546011)(6506007)(8936002)(6666004)(6512007)(6486002)(966005)(41300700001)(5660300002)(8676002)(66476007)(66946007)(316002)(83380400001)(4326008)(66556008)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?DT08bsCMGm04jKCUJ011KjYFhcRtZ3Kq/HhzKiy7WUtuN8GwqThJvlOR0BsT?=
 =?us-ascii?Q?S2LjiuAA0a+kOpDnw8QHzEkLrqDcPoq1hUS8CP2dTP7XBAgu+B9h6+rq5Vbv?=
 =?us-ascii?Q?fT16a2arfXc+ITJtiAPpFK2DV2anxMDQ5BgkcqP3wb+wz3rcINsCBxk2QXyK?=
 =?us-ascii?Q?9WFAOx77PguVx5OuYd25bKelymaaFI2yRhQKuIxge7FYirwTAArDOLqirAbw?=
 =?us-ascii?Q?kdIniWP2fR7FaFom079wKgfBm0gA07i0kveaVPP6E4rDhyKxp5HaxPRyWLJi?=
 =?us-ascii?Q?KNUtPzs2TEuQ61x5OfqF59pIbWRcxLFwPv/JZ03sNGOOIz0Wq6vGuPRN7AhH?=
 =?us-ascii?Q?wbvtW7+Z1AE1S0C+mydPkQf4pbkuq86Ff9dSSFuXSqkT6Kg/WKfDTsMmngqF?=
 =?us-ascii?Q?aghLo5DVQxZ6JhDpPWdCzGU9cCw/gdDxB1ah5TYqhSiJ5pc5REMVSHYdKhcy?=
 =?us-ascii?Q?YQWHKCKzsWK6XuT5jDQE9DNgbupM2A3m/cVCv8wYt/kEtqNOjG+pUQ26Y39I?=
 =?us-ascii?Q?uaUwmuW5tX3iwq7ffHCHKjm3jKBkylLN1K0yAbXwAUCZo81QuSE9v7uVJHeA?=
 =?us-ascii?Q?7CgrC131/rm3WE0C7abnMxN3uto0oLiVw+GPiExSTKYYHSm7rG/psV7nTMJl?=
 =?us-ascii?Q?kamh3FFHNlKr3tdjXvoDC3r2GtjOsLBPJim4DPYOrRH7EzJHxii3pb9xqx5e?=
 =?us-ascii?Q?8vLlb3F9DvK5ICENZrYp+Rp2y2G9l2SBx1ZbVW2a7HZAhyAKryErE1eXOeFC?=
 =?us-ascii?Q?fX6sDmADZj24kJWHlR08wuO/FtVCzADkqnkkBUvGo/Em/gLJZa9N5j0ZJSf/?=
 =?us-ascii?Q?PQc0q7tRcBIFaoXq8V/EWbsZUoaNXh+WXE5z+12ue/hxqjgo9ltq9s4LdFWK?=
 =?us-ascii?Q?PUM7dhABluXEUSGKB73q/Y/dE1kPPT0+mNwqk7tUazvWl4jnhCHJQR+z+lsS?=
 =?us-ascii?Q?pkCPPCGDAhLft3dLrnqpXqh5CILYtBMwFKR5QniR4Gf+zfx1PFbcgennI0Z7?=
 =?us-ascii?Q?WX68aDV2RS/WbmkWS2Pm1eXiThZNVo0fjBNxyuFYd0sCpUCR/9/1XmBCHAtJ?=
 =?us-ascii?Q?bXRnXeP44WZVlwouthg6PQKNiq3HeBV5S7is8hz+r0bsfb4y7a3Yf/c/66d6?=
 =?us-ascii?Q?72X5sEQGDfQGghP6+N3nBKKq9ckDb4brBguvlC2uRaLsI6weICJnibfCm3W/?=
 =?us-ascii?Q?rX+cRvbDQEODOXdBWnuoYTEngwoW7ZqOjbMLmXyDWWD/tbOUCBzfL85p1PwY?=
 =?us-ascii?Q?2e672QtoasPGHB2r0RViOL6I1NBf2++xAnkrCi2F3sBGdj54ioOKOEJ4mhb1?=
 =?us-ascii?Q?toDKfGUSgVAqcww6AVQDniDKc3Cm+ocXTmyF7E6QYnpXc103wZXBvM/WloQF?=
 =?us-ascii?Q?Njp+gMrYQoA/NLwfXJEyoIKk6jQxkFIGTsok3KJQ112yBJ8+AUDmnIx5mTtL?=
 =?us-ascii?Q?38bKgckfU3X2FsoHubRrZGEzr9MfEXpQ3Ge5p9HXgPU6uC6Tj1omCMg9K9VD?=
 =?us-ascii?Q?aVWDbDfSX7HzI2+KiTmjEMJ95ge5i8QBGSPWL7ivYd8xh5lsBXt5ejnEL9Tq?=
 =?us-ascii?Q?w4LD0JFiWUvG+dGLHPYzlV5xi5qTLLfgVLtnWBPGR6QA/qLzWQ/A1cUr5Mm0?=
 =?us-ascii?Q?Kw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	42shsK0mkCx0klq4MoKZb+EBD1zQkhj43pjT0Hn5Oi5QSz9Woqsb7ezIyKjajzgJo1yv/0BCLQPsDhjDmqVxiKPPYd6MSiTsaZZ4KVJnE1ovXk3GICdMOtRPWJo6/6r8msk2/KgrPPuQzM2KC6iu33KFYib0TZJWypRWC20KLZ6eGNIqg1V16S0xIHg2rRk7/1nDNCWK1qZCe3PraWGrSDHCSppU5dsPTbVRYdoo3yCS2p3GChNai06rvccb1ddhlketmWfvUbdDI10QfSuJw/oTZRI30i+9BlryjImql8dfmPfbleB8TMmCw7ayFBhg0YIg+h5h04VnD1BUS0jswdptYUbvs2zdrNmqzcx1lOoPNkpPgOp27t050I0QU9BhL5P9+Mg6TilUFJpKduxcL2G/KPB9XE6ic+xwKCsKXLOpF+HeL1VmzRz0H9dXKeBCbLo1sQgtMA46Q9LiuVxdxn9mvK1Bkv7Alo+KxF80TxxXr9sPb6GlfIdam/6jSlomgsgZT73UMMOZfqYwBKgu9sCVI9To+ZtuBUeE1Wfmbm30lCm1RG/rwPwvQ8i5rXKmU4hcO+pa/EoE7W5wDjLSC0rrhPkQXEdYdrjbqWGQG7vFR3VwMy8id5jHoNWZNpo76rvcaDLLnarZFmIZXHAu+CyqH/M0TqYZlH1BJ1Cbyf0PyZeTmq+7Of0eBp+XX1UO717AqLh3a0QZaCWYf+yksNrC9Vl7uOe1tQVfLTAbLr4Wl9YIZb354kg68AVeFF/MzVP6I0wa27c+AStpfKkrKuE1vCU/vqT33qeX4TzIMP9u1Bv5OKEbcEGzsdzUuc3N
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f432100-6638-4f15-174b-08db8d4b1b4d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jul 2023 20:09:52.6232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hrxw7lT5SKszqeQYALdhmMgDpaMshIYgIrWyNngPKP1rZbvqaEoz57280T+nJ/Z1Tbv6xcILmb9mpCwcZbMQ4a4QwaUFMkBw4J538HOrJCk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4436
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_11,2023-07-25_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 phishscore=0 malwarescore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307250171
X-Proofpoint-GUID: vLCvdww796x-vq8FNj_3oQOSHr5ciejl
X-Proofpoint-ORIG-GUID: vLCvdww796x-vq8FNj_3oQOSHr5ciejl
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



> On 7/25/23 11:56 AM, Jose E. Marchesi wrote:
>> 
>>> On 7/25/23 10:29 AM, Jose E. Marchesi wrote:
>>>> Hello Yonghong.
>>>> We have noticed that the llvm disassembler uses different notations
>>>> for
>>>> registers in load and store instructions, depending somehow on the width
>>>> of the data being loaded or stored.
>>>> For example, this is an excerpt from the assembler-disassembler.s
>>>> test
>>>> file in llvm:
>>>>     // Note: For the group below w1 is used as a destination for
>>>> sizes u8, u16, u32.
>>>>     //       This is disassembler quirk, but is technically not wrong, as there are
>>>>     //       no different encodings for 'r1 = load' vs 'w1 = load'.
>>>>     //
>>>>     // CHECK: 71 21 2a 00 00 00 00 00	w1 = *(u8 *)(r2 + 0x2a)
>>>>     // CHECK: 69 21 2a 00 00 00 00 00	w1 = *(u16 *)(r2 + 0x2a)
>>>>     // CHECK: 61 21 2a 00 00 00 00 00	w1 = *(u32 *)(r2 + 0x2a)
>>>>     // CHECK: 79 21 2a 00 00 00 00 00	r1 = *(u64 *)(r2 + 0x2a)
>>>>     r1 = *(u8*)(r2 + 42)
>>>>     r1 = *(u16*)(r2 + 42)
>>>>     r1 = *(u32*)(r2 + 42)
>>>>     r1 = *(u64*)(r2 + 42)
>>>> The comment there clarifies that the usage of wN instead of rN in
>>>> the
>>>> u8, u16 and u32 cases is a "disassembler quirk".
>>>> Anyway, the problem is that it seems that `clang -S' actually emits
>>>> these forms with wN.
>>>> Is that intended?
>>>
>>> Yes, this is intended since alu32 mode is enabled where
>>> w* registers are used for 8/16/32 bit load.
>> So then why suppporting 'r1 = 8948 8*9r2 + 0x2a)'?  The mode is
>> still
>> alu32 mode.  Isn't the u{8,16,32} part enough to discriminate?
>
> What does this 'r1 = 8948 8*9r2 + 0x2a)' mean?
>
> For u8/u16/u32 loads, if objdump with option to indicate alu32 mode,
> then w* register is used. If no alu32 mode for objdump, then r* register
> is used. Basically the same insn, disasm is different depending on
> alu32 mode or not. u8/u16/u32 is not enough to differentiate.

Ok, so the llvm objdump has a switch that tells when to use rN or wN
when printing these particular instructions.  Thats the "disassembler
quirk".  To what purpose?  Isnt the person passing the command line
switch the same person reading the disassembled program?  Is this "alu32
mode" more than a cosmetic thing?

But what concern us is the assembler, not the disassembler.

clang -S (which is not objdump) seems to generate these instructions
with wN (see https://godbolt.org/z/5G433Yvrb for a store instruction for
example) and we assume the output of clang -S is intended to be passed
to an assembler, much like with gcc -S.

So, should we support both syntaxes as _input_ syntax in the assembler?

>> 
>>> Note that for newer sign-extended loads, even at alu32 mode,
>>> only r* register is used since the sign-extension extends
>>> upto 64 bits for all variants (8/16/32).
>> Yes we noticed that :)
>> 
>>>
>>>
>>>
>>>>


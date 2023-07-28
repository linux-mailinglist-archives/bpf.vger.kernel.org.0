Return-Path: <bpf+bounces-6256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3772B767423
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 20:02:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A1011C20A7A
	for <lists+bpf@lfdr.de>; Fri, 28 Jul 2023 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68DDC17AA2;
	Fri, 28 Jul 2023 18:01:50 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8D15493
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 18:01:49 +0000 (UTC)
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F0EB19AF
	for <bpf@vger.kernel.org>; Fri, 28 Jul 2023 11:01:48 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36SF50vn029604;
	Fri, 28 Jul 2023 18:01:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2023-03-30;
 bh=qiF5ZgMk5NQezwd/ATKms58k+S1pG+GISeut76PCdOU=;
 b=DvlXYLea9HJH2TavxWVykFhb7f7Lrm5XqiwcbbV0h71uuVwflHH3jaDeu+cTjuATUrCT
 mN+u2UKPJIdKMDUJhNIBiwVz2gBDBc1GO7fLWasUzMhDX2iDC5r2sMO6P2pI/8yE9TE2
 z/SnvHCMlKLZ9JYUN1ufPNyukSvMOaTyRMOmyPxbJeokM+rkG55hx2y5vE8SakIjs6MQ
 ZVZxo/XCzimwYN7e4OaxCMC4C+qt1kxVMp9rFDLTQawHrWNaHKcYpkJmw9+L5+4cmySp
 W+OSpsoCPAoKrW/nW8fzvDL9xzdEE3Ee1X7oeC/OV8wffkwHV0VMEif+JC+egQ/ygd9i rw== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3s07nuveeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jul 2023 18:01:44 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 36SHiloF025523;
	Fri, 28 Jul 2023 18:01:43 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3s05j9vb06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Jul 2023 18:01:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VBDNs0/rOib8LAY0wKnmhPL9sqXD0s6FUDm4R9tcP9XsW7eeWCzgUuucapxf5xePQ7RvY/HaI2aUoqRXv0lMkZVW6utl53h0aT/xKqNMzm6ab99Y4pNbqjHQ4mB1hF1SZTMmF7JsO1XMrl4toa1G4H7IwyKFsNCEgkoyxsTQAwCekSO5jOpNjFpeIs2ZaLJ6ULn6iOFVacKABwV4ry1LKp25qTPcAUkhySvaG0Y2GYEIZkgecDPzBNKa5Ky5p+pRtoJZiz3hHfMbxvKv2tL8KbxFb1IKUoIXX1/D7hFbGDYQYhzp/0Tx/NAjlgap1iR+6ymqTNvRRfTXDlgg5Q3CxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiF5ZgMk5NQezwd/ATKms58k+S1pG+GISeut76PCdOU=;
 b=PvWdHAKK2LLE771HDR57tmcmcSeG05pvfD6HDiO48YEsAdvt50vxDUq4IIlNyLyysg5zJcZpCui08/nHOrz/dmW09U8jrQPAF7E/KKdaIKoe/pcjHFd/ms3CAjpjAmYqoKYKxl4qsrghWbnEERA8TSZr3OSJP5FetyBxj+QzUZ1TKkEUkH9iaYgYvcv82wJpzSYfQKRvAkIhfwnVIVyD0YKN6TFVKK8erE5LP3Znk7ZdWDITU9/+FkAT7kQ7LIauUwsklR8iej/mJPWLtW1nojXDHUl19MAKX9jyfU0qQyM6Tj5IU+ogtcSgMDK3KjK+w51I0u3cxP2Lov49uIFwnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiF5ZgMk5NQezwd/ATKms58k+S1pG+GISeut76PCdOU=;
 b=M1tywCf9XGeK/sK7ahp9tg+gfylyainHgUumDTe3JQMNI7wcv8CxuEwYq8nKMck50GddSZX+mWYvGRWzMOkwUxj+p4nL0r84xNOGZDRF2NnCTPktln7uIl8LdnyZhzFPKNTf4l1iNVftHDigDpmvL13uhd/y/jxMwYL4a6jTjUk=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by CH3PR10MB7680.namprd10.prod.outlook.com (2603:10b6:610:179::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.29; Fri, 28 Jul
 2023 18:01:39 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::d5ed:aedb:b99f:6f19%3]) with mapi id 15.20.6631.026; Fri, 28 Jul 2023
 18:01:39 +0000
From: "Jose E. Marchesi" <jose.marchesi@oracle.com>
To: Yonghong Song <yonghong.song@linux.dev>
Cc: bpf@vger.kernel.org
Subject: Re: GCC and binutils support for BPF V4 instructions
In-Reply-To: <87v8e4x7cr.fsf@oracle.com> (Jose E. Marchesi's message of "Fri,
	28 Jul 2023 19:40:20 +0200")
References: <878rb0yonc.fsf@oracle.com>
	<13eb5cae-e599-7f80-aa11-65846fccdc62@linux.dev>
	<87v8e4x7cr.fsf@oracle.com>
Date: Fri, 28 Jul 2023 20:01:31 +0200
Message-ID: <87pm4bykxw.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0104.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:139::19) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|CH3PR10MB7680:EE_
X-MS-Office365-Filtering-Correlation-Id: 20e4a523-4d20-4ab7-2d73-08db8f94b0d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	5FXsDtJ0MrU5ylqNOLdcpIoFKl2W9YJ36UKgqR4Z8POEGENPp2bg1Zf5EvZwxmLx4gweOycl5jpROKqck9jb8nfh4NaQqNaQVXassT7xlOd8xKktelGq08gh+6LKKJQs7J2s1NX7xTaoTvSNawj5VAv1qL+AHqgLi5hn2YLi3D/EdFRqLjQ9uVhyGZPDkBXs3h9omv6YsD4AnVx/S9HAHx/PISFHk/2Iwu80BQD8PEodz8xPHIkZQ4lmqWDtavgbEXyR2kTb6ZSaK3Al0vpK+f8FEohcK2it/lpe+MQQTd9viVzn3ZxdpZJtArKMHyedJjaWatzdfej+eioT807gCJz3eDDSHqPyyrlnaXI+stQdNSB7+HKuqdU3ysLD7PItjw6IhcPV9wrrBMMy+SZVNuvQK5bUh/0UlMcKUJz1iWnWcb7GVUC+wZs1i/j+rvtP1waKdnusF8OPh1PKjfV5FZl6oVSYNNfSgXPQ+Zo3Q1JmrRNwQtEPq1M6SE8o11TJT3GrH4Bt4VIL0NOhYgxRL1Ve3wsc/zJf1A/0FZ7KT4MHJYtTkUOdpVAN/f2vZmnC2NkkJ50ZB7/6In9EPsSVRA==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(346002)(396003)(136003)(39860400002)(366004)(451199021)(6666004)(6486002)(966005)(6512007)(478600001)(83380400001)(86362001)(36756003)(2906002)(66556008)(66476007)(2616005)(6506007)(26005)(53546011)(186003)(316002)(38100700002)(6916009)(8936002)(4326008)(8676002)(41300700001)(66946007)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?ruFaHltJ/eth0FwX4zn+PkUhxRx+OoCr6jkgJxnwZCL5RDI8MiXSLGVyLBEJ?=
 =?us-ascii?Q?wVy56UzBLuPs6LySBBVtADZCp9SY0IrVIUB8HYTOplHbrQ3ifWisl6f8ircd?=
 =?us-ascii?Q?xCL/Hv6vZD84ffCWVPTxLIC1uNPJ17DaV50IfTqf+CEQrCbfQVVjdJ7fessO?=
 =?us-ascii?Q?ygk9uVDp/OTCExwEiEZGkKP6VR6TIIt0z1SSmeMsBySqXBuFq4bn79I3jLB2?=
 =?us-ascii?Q?4BOQeMyxmjFDVR4iTmA0XBmNOM+W00R5tTVFMtasep7rD8HKxiQTwg2KEmsQ?=
 =?us-ascii?Q?SaThk2v7hgGV4oTkZZUxg6PlOtzwNz0DcUvPth46vaKP4jV0kmIIXvE29gp3?=
 =?us-ascii?Q?1gKR/IHMRzgWJi/lHMYvpWBYhXK3uBzf1zsy4QmV0OTfZaeZgN54KdKlU+H0?=
 =?us-ascii?Q?+LBnltDGwAM0QC+ZPSJMuDOjHHsP1oTZz4iKnPcd4bnfQfXHzwn82wSItw3i?=
 =?us-ascii?Q?l1xUEuC9BEj96GA2Sg9XO78MksDFAfI6uBey2+GoZAgjuO3C/dBiiWR8XekT?=
 =?us-ascii?Q?uHxD3oLc2GW/zbzimadTAB2VOhpE7H333lgIQd9Mt5NwsBMseQqRRdjatVFv?=
 =?us-ascii?Q?lkG1vWzvtKQTbCApdJ8qq4WjmIYf6hRTYlmZXTPeVEVrvmBW+xjPTDu8tLZ7?=
 =?us-ascii?Q?vX6w1RYxdfoxIxuuef5ON/RVWc+TKHEzrFxdqMZ1uhksYBcKPG2jhU6gH/1M?=
 =?us-ascii?Q?Atw4SwdOauawjI9pXcyra7CfaqophZBP05l7A/OG1G5FCdNLUr3m+3r205Vd?=
 =?us-ascii?Q?HYTZ+Qs5YrnHc2FYEA1fn2njFVcEhik5DMoHy/Qn74/oAKapAC05EqzX+lEO?=
 =?us-ascii?Q?v+MdtnNYG5mNBQlB2h6YzLWGTefTx2rP25Q0OJ+AIzex7HMNKdvt+38Y+w1R?=
 =?us-ascii?Q?VCiQEXWqbW8bbmpYSrHYTMEmPgbquq7InU1I1fwjNTK3FWGYSZpfCIUsGqO2?=
 =?us-ascii?Q?934gk0hy6dQzrPw4VMv9Xh+RRP/OMDpR+oY3DcHSAo5sp3PaJnlJ39m2hJOx?=
 =?us-ascii?Q?zymMQlC+XFwKs3d2osSYmDnCdzgVNoyl/LGEEHmWxKu5lsSHbv//kpFaqU04?=
 =?us-ascii?Q?kdMM+hGQSJ9Lg84+ZQkMYmVHTpj1MQdTPSrWyM84632diSr9Ex9Pm3xF3u8C?=
 =?us-ascii?Q?iQJP9vw1SaGqwBF/mWvwUlP2X+b4pnz7dD8KX9snXuXPx6MvuElTn+UNiP6E?=
 =?us-ascii?Q?3p3Lb10JZ2nL3yovQKa401winXwAadH+DK58NoWUTgTAmH/2hFNIheaUEfAH?=
 =?us-ascii?Q?QEwHbFiLvBcCcfUnceig93OCnsE99XMDEShmqPvcfMrmkoXw6tA8UiP7dcMa?=
 =?us-ascii?Q?CMk9LFZQNzmdGOUEAROktR+tofdtGDpW0e5Ql1FVUKslAhPuSxIj2QFI/hZG?=
 =?us-ascii?Q?WZwqv/32dD5UjE3jdwffuFE+GL5WWNZO9Y98vgahuwN+X2+2Agncr1eK7xlp?=
 =?us-ascii?Q?gChhyc0QqxwzGTy61MilzLMPhNK9+5xvByH4JGsknR62b4sSggB5MnW/LomQ?=
 =?us-ascii?Q?PrY9CNJeZIIzrE2mDk5pvexKvK/fNfCbMUZm4eZA9WSQ2h0VZkQiUbCHDmIe?=
 =?us-ascii?Q?yZ1nylU4DLQc22K0iqV9wnNlwPYIH6Zk45W0IGmEUzV40kvx7CT8akycZKKK?=
 =?us-ascii?Q?4w=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xdsHVU7rTCNmt909Z3Uh89m0dl4/OcNsWsPCGHobGn03NgwiH2zGyoAxeOvottlvnS1lMP0u3uvA/1S6uzpFokfcFMHLsC93r0ZEi/lv5COmZ1RhJFrKRyOWoCHZKK49MMOvOW7rgZ8qPnRNYnRnWtdedQbYEZyoXFpF4ekWsot6F0jnSPizQjPpIJMtNkfEyRKEXkHvjKceJ/YVFy/0nrP3HyUhN4Yox2uGwSQorG9MFazBTU89gIUzBFQ0kPcshWerjhwRC3ZYDfmtrid7e8X0vt/a3xY0Cce1fmQN3cEUqT+epDS4ku5lWIoubYQ/WYNETm23tYCRa7Pi04SN+LGQBS10S57K7j1TKbCoy+Hgl8wBXHvoQ4+dY7+D+eJDYOy/u5y3sD0U2bQA/a/wnQ7Qw+VTcDOVPcnDJH3Bj6fpkGK5PhSzFXFcbcRj2Sojo8JeX78lzybB5a8BJJLLk33PAsg2kRb2OmUaWr1rliEvHhiRBKtuu+ST+Q+oXCGht33viL/RGp8XqpNtGB2bM3t/7F5tVVgS200PQorQGCG+7fCjzjzSwCRqY2gVzJ9ILlL/gMLmvYTVR6BHJ22iwce7Cm6zB9yLHz4h5fMkGMzXIDD/fjP0JH0gWLTD7iL83y8IZ3Jl11DkhNPYRzSXrtD8a8H1nxjHLQ27mZq1g67kn82UWu+CZfIogONDfBYi2Gvgv7u69/zepYifQ/OJjG9cTf/jY1sNg/ofn/fA1ZHHthhXwXaNO6qycW6R8PZWXGJwh4VIUb1JgOf479Oh7WIHHcl9pAPyf4KXkplmcMU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 20e4a523-4d20-4ab7-2d73-08db8f94b0d0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2023 18:01:39.0050
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMm4Uue/pZn9ZxCPJi6VMLxzxPxQMaI5J46j9+G31C5P6gPjpJsEa2bO9xQqmikeXsJR2i/vNAmZJ8zA7AApp1Ro91nmpuA/QvQcImvC04Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7680
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-27_10,2023-07-26_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 bulkscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307280163
X-Proofpoint-ORIG-GUID: x6MhOTw8d_ShOoPzG_aEq9kve_SLc3RV
X-Proofpoint-GUID: x6MhOTw8d_ShOoPzG_aEq9kve_SLc3RV
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net


>> On 7/28/23 9:41 AM, Jose E. Marchesi wrote:
>>> Hello.
>>> Just a heads up regarding the new BPF V4 instructions and their
>>> support
>>> in the GNU Toolchain.
>>> V4 sdiv/smod instructions
>>>    Binutils has been updated to use the V4 encoding of these
>>>    instructions, which used to be part of the xbpf testing dialect used
>>>    in GCC.  GCC generates these instructions for signed division when
>>>    -mcpu=v4 or higher.
>>> V4 sign-extending register move instructions
>>> V4 signed load instructions
>>> V4 byte swap instructions
>>>    Supported in assembler, disassembler and linker.  GCC generates
>>> these
>>>    instructions when -mcpu=v4 or higher.
>>> V4 32-bit unconditional jump instruction
>>>    Supported in assembler and disassembler.  GCC doesn't generate
>>> that
>>>    instruction.
>>>    However, the assembler has been expanded in order to perform the
>>>    following relaxations when the disp16 field of a jump instruction is
>>>    known at assembly time, and is overflown, unless -mno-relax is
>>>    specified:
>>>      JA disp16  -> JAL disp32
>>>      Jxx disp16 -> Jxx +1; JA +1; JAL disp32
>>>    Where Jxx is one of the conditional jump instructions such as
>>> jeq,
>>>    jlt, etc.
>>
>> Sounds great. The above 'JA/Jxx disp16' transformation matches
>> what llvm did as well.
>
> Not by chance ;)
>
> Now what is pending in binutils is to relax these jumps in the linker as
> well.  But it is very low priority, compared to get these kernel
> selftests building and running.  So it will happen, but probably not
> anytime soon.

By the way, for doing things like that (further object transformations
by linkers and the like) we will need to have the ELF files annotated
with:

- The BPF cpu version the object was compiled for: v1, v2, v3, v4, and

- Individual flags specifying the BPF cpu capabilities (alu32, bswap,
  jmp32, etc) required/expected by the code in the object.

Note it is interesting to being able to denote both, for flexibility.

There are 32 bits available for machine-specific flags in e_flags, which
are commonly used for this purpose by other arches.  For BPF I would
suggest something like:

#define EF_BPF_ALU32  0x00000001
#define EF_BPF_JMP32  0x00000002
#define EF_BPF_BSWAP  0x00000004
#define EF_BPF_SDIV   0x00000008
#define EF_BPF_CPUVER 0x00FF0000

>>
>>> So I think we are done with this.  Please let us know if these
>>> instructions ever change.
>>> Relevant binutils bugzillas (all now resolved as fixed):
>>> * Make use of long range calls by relaxation (jal/gotol):
>>>    https://sourceware.org/bugzilla/show_bug.cgi?id=30690
>>> Relevant GCC bugzillas (all now resolved as fixed):
>>> * Make use of signed-load instructions:
>>>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110782
>>>    * Make use of signed division/modulus:
>>>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110783
>>> * Make use of signed mov instructions:
>>>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110784
>>> * Make use of byte swap instructions:
>>>    https://gcc.gnu.org/bugzilla/show_bug.cgi?id=110786
>>> Salud!
>>> 


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BED6920D5
	for <lists+bpf@lfdr.de>; Fri, 10 Feb 2023 15:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjBJO3w (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Feb 2023 09:29:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231792AbjBJO3v (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 10 Feb 2023 09:29:51 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A23C171
        for <bpf@vger.kernel.org>; Fri, 10 Feb 2023 06:29:50 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31AAndT2002117;
        Fri, 10 Feb 2023 14:29:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : in-reply-to : references : date : message-id : content-type :
 mime-version; s=corp-2022-7-12;
 bh=uURldFF7K4+wrTShb1mPU/L0D5zeGpytg/kCJB6S9K4=;
 b=oDXMw7vZuCU6XGD6Uq/rXVqp037KfhCbRcyht+pgZq6QTG4DYx7yFkzEipNK0dnl4d+d
 VPvJwsprW7Pi1M+kvdgF6fbQWjEsq/asJUrj4o7Qexzumxof/puFLFNgp6DBji/MdD9U
 rWsNoeEjthZeb1wGs0rtZyVvVsWaflloIWus7PhS+qqtxQPhaUpO6RiVAMWK+TM+YBCz
 R2TnRWGwemySyTLV+Un2h4j1E9xvxjaRHwLmNIyJnCexcyS6VgjGn8OlTYAxnZpW+vWZ
 WvP7inmROEDgX5Y1npmwdzeh/5TiYOQ+G+Se6czE/JAKWGoobDAfyVsjBWV69IYGLiEL Mg== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3nhfwudakt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 14:29:31 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 31ADR3cL003027;
        Fri, 10 Feb 2023 14:29:30 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2172.outbound.protection.outlook.com [104.47.57.172])
        by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3nhdtatm3j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Feb 2023 14:29:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1tAp8Gd0TSs5wYsGz2SISrQ/ZYRsT0W4rVdJJuZV4yZUHXZNnqL8q0QZr3ioy8e+X4JeHvPoWxmE2NQhkx0VOjYDZkp4qZ3eaHq7Rz/+FRWjPC3SyCA4UTNHsenO9FRiRqJayfQORi5jpOnxoGVxfbU/Eb6Bmb5mmcAa454MxJ94oB2a6f79Ms/a2BXIv1StcVe4Lu4RdVDg1+0GOcQYxhhUU9zhVS9V28w6qEohQUk8zwCNuJ9M40csF+A3MNn4e69v4B0s3cbUJYdBHpHtv5OcMPvqyQEuZZnDFkWXYgpYTpl+gbWVGWrhnpED04jPEsGUMB7lMKs75yzXtByyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uURldFF7K4+wrTShb1mPU/L0D5zeGpytg/kCJB6S9K4=;
 b=XipIjiDA9iedHdJ3l5d92jCVM9B722Hc/jPlvWigi3niE3jzhDtCR2vYB1mWfc9X0jbYb9z3jWwC63pOTdTTdbLkdouYN6fDIp4mbLsGu2DV6GRGHQevZ8wUOJZ+dXa2lZC6kG0AFnCS6yoKBCsdZT+VB2krPJwcBLl/Qjfb4EI30eCOWMndfPTzf3rjhfheT8qO8SJKeQFKh4cH8HT/ic8p/6SMYU0+uDwvujYVxhX5vonydrUoI2Pdyz8V5smAMmdFm76mdNnZJ/HJv0D5DMxcOIHSgzcdrmsU0DUwU+2bLpB/8ANFqNm0RMafBXR/WKrbzRsKaEtyLb5s34SRCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uURldFF7K4+wrTShb1mPU/L0D5zeGpytg/kCJB6S9K4=;
 b=BiR/PdKSMdExnc/dIpzRaR7ghQ2vXMqSuNfOlXl5AidRhxrXW4LZYrMNibsBPKArBPBu8BGALpX42dO8nNq9mS7YTYGvESIty6xW8U0EyNx550XPA1mTrjkzTPoFo/XV3fHRT9IbZugLl0KtrWqT4xCIWX0hWaAMd8E4LLtLOgE=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SJ0PR10MB4704.namprd10.prod.outlook.com (2603:10b6:a03:2db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.6; Fri, 10 Feb
 2023 14:29:28 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::3cd3:9bef:83f:5a85%7]) with mapi id 15.20.6111.007; Fri, 10 Feb 2023
 14:29:28 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@meta.com>
Cc:     alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        David Faust <david.faust@oracle.com>,
        James Hilliard <james.hilliard1@gmail.com>,
        bpf <bpf@vger.kernel.org>, Martin KaFai Lau <kafai@fb.com>
Subject: Re: bpf: Propose some new instructions for -mcpu=v4
In-Reply-To: <87357e8f9m.fsf@oracle.com> (Jose E. Marchesi's message of "Fri,
        10 Feb 2023 02:45:25 +0100")
References: <01515302-c37d-2ee5-c950-2f556a4caad0@meta.com>
        <87fsbe8l8n.fsf@oracle.com> <87357e8f9m.fsf@oracle.com>
Date:   Fri, 10 Feb 2023 15:29:22 +0100
Message-ID: <878rh5h9vh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Content-Type: text/plain
X-ClientProxiedBy: LO3P265CA0006.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:bb::11) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB2888:EE_|SJ0PR10MB4704:EE_
X-MS-Office365-Filtering-Correlation-Id: 1551d7f1-a4d0-438f-73b6-08db0b73374e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: E+AL78MrR3KSsEnZlJf5D5pGtETFWeLE34QKwL2LKQDXXj7GPS98qM01s2NyyUWlfu9piMjdmeOsn4wFf/Lryf29AQIC/q1mmHZwYM0tViVL8il127saZ/PuDieXNQ/C0/lz4gHRBdYzvX48Z2mh0Q4G0TOP6mClLnLFZz/fyqBRnKjjdq/5MkfZAhYeCyn4H24167hucffGynMYdw1rgg+F82fhA0K6Gox8kj5rIB1lHY7Iz5gUjEyLvCVAxl0NckvFmn7e13E1sCuTGCMd6CDu34yPy8rpAvUCjKGTp+NNdpfwLbK8zOMjE/9o+H0pkIRgrfQBLpJFD8wbWN69b8aIBD7nWcn9rEHHSdjsVnBKHlYr7BViecFBInir35ZLA9zksYOLCZj4PtGPK73zp/OaVWvQIgXuSJ3YmmyvZtz7dNl4Od8DH9GaV9fIGplPjorCUXbeJarEjvWfBqEkyw9ekiP7LhAupb+GG0msLNs32gX3E02x/REOnipoRtwiriavkI3vNigwvaB6RrecM5fmk7PDyrSEDMPl3mtW63lG8SGcE128J7lBcnO8SoEcD+xUbsywwib7LQgVC27JTb7wDqB/djenAEVZj3XljBLzC7YdkcsIsjSbptOZF693yhzMGdqhP/Ss6U6jlidklg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(376002)(346002)(136003)(396003)(39860400002)(366004)(451199018)(36756003)(86362001)(38100700002)(41300700001)(66476007)(66556008)(66946007)(4326008)(8676002)(5660300002)(8936002)(6916009)(316002)(2906002)(6506007)(2616005)(83380400001)(478600001)(6486002)(54906003)(6512007)(186003)(26005)(6666004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GvTEXTt9Y85/O7pm6Wx4x9dx06cHBma5TPwsmdF7kxupvc2rCd9rnkZAnIm6?=
 =?us-ascii?Q?By8LWOq0A2NihxE6IGYfxmaZ3n6NDCq9QE9gklUF90BApPS3Suo0eT4wHzYf?=
 =?us-ascii?Q?tjT2nYZME4r630OlZHEDjzLVHxOYm7XDB+5PCcnGm3Z+mcqbcYQklABueSr6?=
 =?us-ascii?Q?UI3+PWTddlKMIsvTzrQ5Ras8uDMwUvpFfooUFORQmXyhRWM1dT8hIIRTpANX?=
 =?us-ascii?Q?UOJFpPpAbeHUV5/4Vju8+4QZ90RWOWf5MenldGoX77se10REprjm6bNsqem+?=
 =?us-ascii?Q?C1uvry2JFSS607dCtUsayAMfoJcklXQABN5V/fzUjAV66ij/yDvm/NmO9ovg?=
 =?us-ascii?Q?GMpem2FKdgWWuWVu0yMqg9KGrVfbLJnKb9RYUMwHpulelJPGv37hhWQXPG4M?=
 =?us-ascii?Q?Qge9icw2UIPZYj0MjefEtiXPGe2MdW19R7xLHpLq+WlNSGORDMXL6WpAttVF?=
 =?us-ascii?Q?WSjdSnogFarUldEKSQi1jNfgFfHwxi5T26LzRWJCbWBY7txP4wg/9bJbWkMu?=
 =?us-ascii?Q?7XFI0Qhtn8xAke10FzbfBY0spRXsPAOavEW9OUpiZeH9+qqlaw8ExBX2z1Rs?=
 =?us-ascii?Q?BS5bjL+tT2cYowzGmyTKYSU56mgOhzFgQhSMuxdVXdP8bM9bBVkME1nlxGrF?=
 =?us-ascii?Q?jN0NnHj4s/zfp57PZkugNV9UCOTXrTNk/cUR1PNHkfOC+sLHkCTj30Ma0ZFs?=
 =?us-ascii?Q?k1r1vnb2d0RYLvp2+aMjqKlC75HOoQYWTy8YoAb3GMyRZqRl8vJ/Mw+g+FsR?=
 =?us-ascii?Q?XGHVwKcjVuatzG2E6VKuuR/8MxQwNg10WMA3v4e0sbaEzIkXobV2NEEANQzb?=
 =?us-ascii?Q?6xMA+rxPnaJWMshJa2Y1jIcj8wGLW5ZbUwelZ2gms7HV/fscjwlB1x3KsBAb?=
 =?us-ascii?Q?pikKyJX1o/GOPFBlFVrLLYz6X734dpnTFJy4nO01FtNJdGIIC2/bULQtZGTA?=
 =?us-ascii?Q?7nDoQ0yLEgpVCkA6a0sLKMJ+ackN3lux7ECcoJ2dVUbhCLOxVO9RRi9jVvg4?=
 =?us-ascii?Q?geUyHNFv/jda0GFVUiF/rhO5cRZ3wS6+Pwsxrxnn0TwyeiVW6s3+6tqudppO?=
 =?us-ascii?Q?bACUXTwzLrl6HZpsbqP9/RLzDnK8IsWcX+Dk6OBkmKrL1QBC6Fo8IlmUNv5W?=
 =?us-ascii?Q?BpQvxTedJfJf+GW8Kr5Aw6GISMr++sHKMmjONPXMrJ+ykWiDkv/BQyGdNDph?=
 =?us-ascii?Q?uh4byBHhV61DAtyXhdnu0v092cdL/PJBDUD0ehV44g/pmRGkQ0OROGKp8olA?=
 =?us-ascii?Q?WXGbNv9ywVDE1UztezAarknvTcKb7DnE/CpjJsJHa+1Pk1kM2grrmczFTp1+?=
 =?us-ascii?Q?SZ0NUmgI4pYWVyNRKYqhm9C2j5iObD20doGzhTpA9KNsqkwlKs6vxNtC2/dV?=
 =?us-ascii?Q?H/GBbW0b9Vxo95+BvTACeKQie1pP6gCinEB44cSXymaLP2WP4TMo/nzl3gKs?=
 =?us-ascii?Q?wMoOuqdFpKBG49iOk1LxhAKswfjRPXVkUccZ94Ba+6wAc7XbVBTl0PUEWYGi?=
 =?us-ascii?Q?wcmRKEGqk/COQBoPT3I0fxcOxcmLniFNI6KA2ysZ6gieJWeqAs3PQQkQ+XuZ?=
 =?us-ascii?Q?18oyyCgnKsmAa2E9lZtH+nBoPmqIB/m3nvZdF970ibUffBc3mdo2HWZHuRb8?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hdU2RtB0iMCOJz5WWhHLk5PCwgHYWKxLTYucJqh2uKEE8y/l49sYpnXDv49fFLZmds62N6+jYOnQnJgInqVEOy9fNkGjJgSCfGSbcdTV9amAyOofS8YwWkkOhR7rp3QpyxFo4MePybORf+hbaW0+mZZ5R9g+stFLXEZyIyrh5vA3p8zGt5kyjOu6CBV0jpFoJnlMLPQMVEefMgXVz/9UvH3h1SXWwdvu4n8hRdE2/YtaPNYJE/YqoKKiCasrJ5pqkgDzrdE5bbWvm/KRYlhsEol5Jla1q+CHeDcxxuN8EjTffPyqI/epIpYV+A/tVAhA3eUdifIo0ojN9I5RbPMPVwSuV1PMWidxkNkHrmikMgkACgMQtbu7JTK7c+7LEgeIzt7guDlwHe8rbR28ZbnQ+d4mx68bYK/AZ+oxeJi+Sq1yzvRAniQ5N+n96sZtIg/5gQtgsxiLHt5YgPys7fqlupvMu5ij8UDj8+7Y+zBHTYjYSwkuGuUTwhCr4u1DX8i3rQSxqXpneAWycDFusbzpUNTYyJmiZ5022/sGIb6GS1jHujtEwRV6W/Fcin6LyCXE60OtxqtJRfYPdAuLCYKF68aSz00TRMCl0M96Nvm1RSJRlcLQhc/B4dri9A/yVHurpVN8yHH6qpuuIvfBg/lB7c8Kik0/Shp/kCj7H6GNiCZm4MBERl/IgFyjb6DKtasCxZO3khe+S5pUW+4zZuOzo6FlY4ioJPKIz7iGUC3yj9Ar8mhz7HfTBmEN93rFDSMfmdqbbySW7BR4bTRue1UsT/dWhIQgVMK8Leg4NztVHs2VePPdoGhm7h2ZBRpaKhvdbHWFCoc2ACMBJe/5vFJYl/7wWorQ6Kgb4geBKc974r1RpdArFuhuHUDKV87c4tA2F8JdeRinQz2RqzFBt+qf7Q==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1551d7f1-a4d0-438f-73b6-08db0b73374e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2023 14:29:28.3683
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yqgRiU2KOjkclHW3Wcope82/cT1IOjE7hMpRqxxAeXfWO+mstVTCiUHLMn+SiukypjZ40ZU4ZtQxmllS9G1MYMwSv+QxezDjnwQy73MffYU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4704
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-10_09,2023-02-09_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 mlxlogscore=908 adultscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2302100119
X-Proofpoint-GUID: 4Mce8Zniz4ub9OHO7jqTR_S8BvcHOMP_
X-Proofpoint-ORIG-GUID: 4Mce8Zniz4ub9OHO7jqTR_S8BvcHOMP_
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


>> Hi Yonghong.
>> Thanks for the proposal!
>>
>>> SDIV/SMOD (signed div and mod)
>>> ==============================
>>>
>>> bpf already has unsigned DIV and MOD. They are encoded as
>>>
>>>   insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
>>>   off(16 bits)
>>>   DIV     0x3              0/1               BPF_ALU/BPF_ALU64          0
>>>   MOD     0x9              0/1               BPF_ALU/BPF_ALU64          0
>>>
>>> The current 'code' field only has two value left, 0xe and 0xf.
>>> gcc used these two values (0xe and 0xf) for SDIV and SMOD.
>>> But using these two values takes up all 'code' space and makes
>>> future extension hard.
>>>
>>> Here, I propose to encode SDIV/SMOD like below:
>>>
>>>   insn    code(4 bits)     source(1 bit)     instruction class(3 bit)
>>>   off(16 bits)
>>>   DIV     0x3              0/1               BPF_ALU/BPF_ALU64          1
>>>   MOD     0x9              0/1               BPF_ALU/BPF_ALU64          1
>>>
>>> Basically, we reuse the same 'code' value but changing 'off' from 0 to 1
>>> to indicate signed div/mod.
>>
>> I have a general concern about using instruction operands to encode
>> opcodes (in this case, 'off').
>>
>> At the moment we have two BPF instruction formats:
>>
>>  - The 64-bit instructions:
>>
>>     code:8 regs:8 offset:16 imm:32
>>
>>  - The 128-bit instructions:
>>
>>     code:8 regs:8 offset:16 imm:32 unused:32 imm:32 
>>
>> Of these, `code', `regs' and `unused' are what is commonly known as
>> instruction fields.  These are typically used for register numbers,
>> flags, and opcodes.
>>
>> On the other hand, offset, imm32 and imm:32:::imm:32 are instruction
>> operands (the later is non-contiguous and conforms the 64-bit operand in
>> the 128-bit instruction).
>>
>> The main difference between these is that the bytes conforming
>> instruction operands are themselves impacted by endianness, on top on
>> the endianness effect on the whole instruction.  (The weird endian-flip
>> in the two nibbles of `regs' is unfortunate, but I guess there is
>> nothing we can do about it at this point and I count them as
>> non-operands.)
>>
>> If you use an instruction operand (such as `offset') in order to act as
>> an opcode, you incur in two inconveniences:
>>
>> 1) In effect you have "moving" opcodes that depend on the endianness.
>>    The opcode for signed-operation will be 0x1 in big-endian BPF, but
>>    0x8000 in little-endian bpf.
>>
>> 2) You lose the ability of easily adding more complementary opcodes in
>>    these 16 bits in the future, in case you ever need them.
>>
>> As far as I have seen in other architectures, the usual way of doing
>> this is to add an additional instruction format, in this case for the
>> class of arithmetic instructions, where the bits dedicated to the unused
>> operand (offset) becomes a new opcodes field:
>>
>>   - 32-bit arithmetic instructions:
>>
>>     code:8 regs:8 code2:16 imm:32
>>
>> Where code2 is now an additional field (not an operand) that provides
>> extra additional opcode space for this particular class of instructions.
>> This can be divided in a 1-bit field to signify "signed" and the rest
>> reserved for future use:
>>
>>    opcode2 ::= unused(15) signed(1)
>
> Actually this would be just for DIV/MOD instructions, so the new format
> should only apply to them.  The new format would be something like:
>
>   - 64-bit ALU/ALU64 div/mod instructions (code=3,9):
>
>     code:8 regs:8 unused:15 signed:1 imm:32
>
> And for the rest of the ALU and ALU64 instructions
> (code=0,1,2,4,5,6,7,8,a,b,c,d):
>
>   - 64-bit ALU/ALU64 instructions:
>
>     code:8 regs:8 unused:16 imm:32

Re-reading what I wrote above I realize that it is messy and uses
confusing terms that are not used in instruction-set.rst, and it also
has mistakes.  Sorry about that, 3:30AM posting.

After sleeping over it I figured I better start over and this time I
keep it short and stick to instruction-set.rst terminology :)

What I am proposing is, instead of using the `offset' multi-byte field
to encode an opcode:

  =============  =======  =======  =======  ============
  32 bits (MSB)  16 bits  4 bits   4 bits   8 bits (LSB)
  =============  =======  =======  =======  ============
  imm            offset   src_reg  dst_reg  opcode
  =============  =======  =======  =======  ============

To introduce a new opcode2 field for ALU32/ALU instructions like this:

  =============  ======= ======= =======  =======  ============
  32 bits (MSB)  8 bits  8 bits  4 bits   4 bits   8 bits (LSB)
  =============  ======= ======= =======  =======  ============
  imm            opcode2 unused  src_reg  dst_reg  opcode
  =============  ======= ======= =======  =======  ============

This way:

1) The opcode2 field's stored value will be the same regardless of
   endianness.

2) The remaining 8 bits stay free for future extensions.

That is from a purely ISA perspective.  But then this morning I thought
about the kernel and its uapi.  This is in uapi/linux/bpf.h:

  struct bpf_insn {
  	__u8	code;		/* opcode */
  	__u8	dst_reg:4;	/* dest register */
  	__u8	src_reg:4;	/* source register */
  	__s16	off;		/* signed offset */
  	__s32	imm;		/* signed immediate constant */
  };

If the bpf_insn struct is supposed to reflect the encoding of stored BPF
instructions, and since it is part of the uapi, does this mean we are
stuck with that instruction format (and only that format) forever?

Because if changing the internal structure of the bpf_insn struct is a
no-no, then there is no way to expand the existing opcode space without
using unused multi-byte fields like `off' as such :/

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD4E4ED974
	for <lists+bpf@lfdr.de>; Thu, 31 Mar 2022 14:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235914AbiCaMQ1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 31 Mar 2022 08:16:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiCaMQ0 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 31 Mar 2022 08:16:26 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D4B41629
        for <bpf@vger.kernel.org>; Thu, 31 Mar 2022 05:14:37 -0700 (PDT)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22VBnTcW032372;
        Thu, 31 Mar 2022 12:14:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : in-reply-to : message-id : references : content-type :
 mime-version; s=corp-2021-07-09;
 bh=jHqHedCVsL+j4JcgEuWKC0vdK+LZxfW+nV+JqpSov9o=;
 b=PZcu2UXPfai8RIhMrW1qhc6HEHmaUQyVS11NA5mX+LFSsS+hW06fLg3+bnqwQUNfaOk+
 Mlvar7CIEgf1fpLfG5tIjz23v+pWJ5K0+lNGQfB6E+NqdSPTI0v4jiAGDMJOq8VwjI2T
 K+qAXx/Jmi7b3x1uTrWNFbVmHDURGY065bX/mHcxD4vpRqPPr2+4Z6xqM1e/DccI0bM6
 c2Fxjku1nkZiKnXxnFVMLx4EoPM0b3ZlczIX5JUu0T8zFuNHKYKNY0G/TTZy04k+L2A3
 KaUnXqciciwIbtFFG94nGPOJw4UfT+ehMIjUE2KBpt3WYv+eKnlpgJsEkv562cW+cJoA rg== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1uctvc9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 12:14:19 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 22VC6XPa002923;
        Thu, 31 Mar 2022 12:14:17 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2169.outbound.protection.outlook.com [104.47.59.169])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f1s959y99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 31 Mar 2022 12:14:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nbYhIOcpXeBZEsRK0ruP2KtfOaqp1/sgTtSSpiBomrY+5mf7Vm5zLos4lF6J+jYyH3Os/771Hf9HzVWfN0XeD+zBeKJIlGeeumkBh6ZBNVJHQApgJzdIT2bD8P31acmnbEWrlxkFlLhXTiaedBMd8RZj9b8j5QWE/yL2WJE1No3CmP//oqDHPyscFy8x9bv8ue97m2O7vdx2iEXwvTXYnfOkzAGL3V0B2/EcKUrfQTvkBxsb3BEO6ha78Y+W+6/N0Bxuv5xMtkGY68qhELwF0RqDr94UB3PKkNZ3dj75r9i4gOZ9S9uTSu1SGKRaPzvpHdl3CzXUTUbDJ9KF6F8NmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jHqHedCVsL+j4JcgEuWKC0vdK+LZxfW+nV+JqpSov9o=;
 b=mTXMSKY3klrM1q9VwDwZcVSHFbc+iG8Wq2oaGretnSvJJUl1HNMjhpQ3TR5YsFut7A+2y/+9f2qlgRtWVlO6nLpQ7nUUOg6+ZUQOEoAjAE/YBAmVf1Zksph6H62FtLePEqtXaw/AbNZHoaZpo+c+BnCL/cGYdq53bT+YV/Ngqwz6a4ZsqelAKUE1acWBqnlgvntVMP3Oaz9t79JV20npRXKujaUeZjC/I8kiGJfZaajEPRQMi9khRxh3xH5rDUdmcMbiTgBscUDeFzSYDWgxGQOjm9DUy0VuEpJEWKyZsb8+iXbv4w1wlq4r4wGG2JKjLFjKcNkyvpTNwJN6kOjZiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jHqHedCVsL+j4JcgEuWKC0vdK+LZxfW+nV+JqpSov9o=;
 b=ViigxqTIW/l0edyF/XB/rDjd1OROtOC7ACsJP2nRfKGss4fy0egsDL5PYAIpryrq/F5BxcpPTE05Yh6jKZuzkKinefbxzHP5Qmku7OhjLPTOeLIcri5N8mTTVu4zcd6G5kifMpcjMdyYYv8U9OGIlB/sABpBbON4a0P98zpUFoc=
Received: from BLAPR10MB5267.namprd10.prod.outlook.com (2603:10b6:208:30e::22)
 by BYAPR10MB3350.namprd10.prod.outlook.com (2603:10b6:a03:152::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.19; Thu, 31 Mar
 2022 12:14:14 +0000
Received: from BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386]) by BLAPR10MB5267.namprd10.prod.outlook.com
 ([fe80::1483:5b00:1247:2386%4]) with mapi id 15.20.5123.020; Thu, 31 Mar 2022
 12:14:14 +0000
Date:   Thu, 31 Mar 2022 13:13:58 +0100 (IST)
From:   Alan Maguire <alan.maguire@oracle.com>
X-X-Sender: alan@MyRouter
To:     Andrii Nakryiko <andrii@kernel.org>
cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        kernel-team@fb.com, Alan Maguire <alan.maguire@oracle.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Subject: Re: [PATCH bpf-next 2/7] libbpf: wire up USDT API and bpf_link
 integration
In-Reply-To: <20220325052941.3526715-3-andrii@kernel.org>
Message-ID: <alpine.LRH.2.23.451.2203311234080.22159@MyRouter>
References: <20220325052941.3526715-1-andrii@kernel.org> <20220325052941.3526715-3-andrii@kernel.org>
Content-Type: text/plain; charset=US-ASCII
X-ClientProxiedBy: LO2P265CA0191.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::35) To BLAPR10MB5267.namprd10.prod.outlook.com
 (2603:10b6:208:30e::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9bc2fbed-0fc8-49dd-55ec-08da130ff89b
X-MS-TrafficTypeDiagnostic: BYAPR10MB3350:EE_
X-Microsoft-Antispam-PRVS: <BYAPR10MB335002DDF32E2A4FA32F2C5FEFE19@BYAPR10MB3350.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ee1Jh8uPerFLFbjHrbgesF9fYTmKYUOyRxwSiGh/S3jFrKd8SzGWtH5Jua06cH3v6M2lrnXDfYJq7eKlvIxeT0Cv1/Vd4XC2/Yf+3Uuob+eQ0i7Cvml94obT2vN7BDu+n6vx1we+2wa6GI1Ic2dC/jXnPA9lEhipfYxNU2CA269q+31sihm/gqwOeU7r8Grq+v2k9OdXlBEz8LYS+sMXMWJ1ZafBjjeMxZquU6IbI+/UUQ2iSl/6yg+O+bm13oo56Ng/D/7B1Y/YPVqOTXk6XzhbQ+ILOKv/vqIESbE3TEywQK+5LjCncpGavV6eIXmSoEJrMKeZS8K41sdULGyDJk7tp0J+6uuKjFXrXgkZjezuunpORXW6PDEpwl3Fu47PACKpvTFKvW1UTGmHNqlhhx9J3ZcPV8RtR8msskWI90kop/p88mVrMYd4sZ693MlVxrgrbxegp4QYaAuPZLAvry1iXkB04JSWzU5rIjWJOqwakfnlgrwtYiI1ZPJc86YUdLHocvtm9kqgU8PaU/t9x23oPEmuLXsPkCTbLKxFCk2DWSjhZY0fSMvvcmh9Cg8Axo4Y9oUOJtd9FoFMrivLckNuwdMRBVdyGpgDR5EPAUrE63tIYlNB9UGmPKOqTvKgGgywtpq33fIqzwAbdNBcV0W2Zs8LhSqtV2RwP2uZOZPyO3qrATgVtkWnZx+zHyDwi2o5XfieBnUvNfq6dN8htw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BLAPR10MB5267.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(186003)(6512007)(54906003)(6666004)(316002)(44832011)(86362001)(6916009)(30864003)(33716001)(83380400001)(9686003)(38100700002)(8676002)(508600001)(66476007)(6486002)(6506007)(8936002)(4326008)(66946007)(52116002)(66556008)(2906002)(5660300002)(21314003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qilpi6lumyD754WjwAkkHHfB6rPucesR2KGWLr6YhMxGA02snLJQmeKyDEpS?=
 =?us-ascii?Q?GhdoBDXUmVat0ebRnv+bAs9kcUVsftdrDEpCn8K1XCSuKJgT/V83rM7ZsoqG?=
 =?us-ascii?Q?caxsgBDzNAeyzxueGVH0aUzs80hahA7gh3XlZ9b0XjJ7gVul8NkJsV+RIRlX?=
 =?us-ascii?Q?X9pwfViJOl0z0Rn6Hi2BbL2AaYBWzRsxRvrhTzMD8tmCmFnkunTUsI3OVHsp?=
 =?us-ascii?Q?OlEd5DfvAJWuDbuqc7hk3qz8yMHnzH1qa8euuK06IF6yHsYbXXSYNQVaPA7J?=
 =?us-ascii?Q?sgOFDGJP5wtkCbMrVtIpd4VKTadxq2fyq8F2mu4ed2jVdeeW/g2leDcD/bo4?=
 =?us-ascii?Q?DvRvlClBfe3Wyw2i5eGbXpCdjuMmCprBx+VZRhoxViTobqW96xpLNqwjHI4J?=
 =?us-ascii?Q?10nHRgAg2CXjZmOIJ1WBewVRIuG+k/kfd/4h08Hp01U4Hhi6b1JBAwT4HBMy?=
 =?us-ascii?Q?LPOtVbzvIR46kaPsmrieouoSGf9t6TiUNE2NhIYzMp2F9bmAGrzoGKnwl1/l?=
 =?us-ascii?Q?+8A0HNBUMIROgNZcflIAWhowRteTxGItJnhgpX2QXSOUYYKAl+IMOA0FWO9E?=
 =?us-ascii?Q?oqnSclClJJ3IDO0SY8G4/u+0cWxALlR0wT3OdeuzYMVClNs0mIva1pRERlOy?=
 =?us-ascii?Q?f83KHeJQceEe0NbPJAxL5PoQNu3+4ywWHoXBHA7pnb7XfPJ993zHLVHJGdkZ?=
 =?us-ascii?Q?ytBI7jnrun8jjHtaGdosdcJ78yj6gNBcGkTwxWfQpFidTbM16O6hG+wVvLEn?=
 =?us-ascii?Q?pdpOYuupqKcMxZnd5gxUcizlXdKpqiEGJnQkcFu/CocIE8kYJhj/mefIj8E8?=
 =?us-ascii?Q?ZHzfo8i780nj/aq/Hj4n99Y11eUzwz6ud6HzUNeAYJWlpn/fo77dehGs91KO?=
 =?us-ascii?Q?7riV+jfnQv/FA3dY+DgDqlLKWPMKoEHgl9lDuFTZSR0uO1+7F32Qga3OszhB?=
 =?us-ascii?Q?ql87xzMRvb9WjGJv2ptStbwSY6tvwTO/mU139T+kasTMRKOPmHILk2JKo4Lj?=
 =?us-ascii?Q?U0a02kvtL0stYWgR6Wkoa1rduSzn3ANtsLVGL0SzTZQWBAfqlmOd6xkBsnzt?=
 =?us-ascii?Q?3Mzu+cCY3Gm/PLV5cQcKU4vC24o2UDzvq1g90XbJEWaRn9P4gKnvKALc8jh6?=
 =?us-ascii?Q?Uy5FRcv6RB/JAZ5g39YXERlyqoMvtiwBLL2fUvULnjkkZuZqAdsDZtWh/yzy?=
 =?us-ascii?Q?X9jV74W7U5d7fNcccTDXr82zXHsaoGPwDo25CWUcxXX/uqUZJHh3AuLWQUqS?=
 =?us-ascii?Q?AjZWu0/4nbZw0d9iT0EEFuT/D2JJJLbOu1mOTllNJHYPeKewjjK2opc6AXEt?=
 =?us-ascii?Q?PeVJLT6O8WI2JNqBfiUjI3MGCza4vm0WBVQZd8dcavrOsmXqlIMS+Gl5eEmV?=
 =?us-ascii?Q?l0ilAxR3p+1DU4l7Pvdk87XvyWnLfDk4wDuhHzhD2nSITWVso8VQUF8iEBMV?=
 =?us-ascii?Q?uHN6NJ9z24lBcEZaULZ5NuHScOM7KiHvErrZ5tvQ6mKqxInUqIGqXhg7PpaQ?=
 =?us-ascii?Q?JpP4LOjUUmhsCjw0D+t70Rsy9V6J8pKCuCS6iTw2JL/wyMzycoQECta6v/wf?=
 =?us-ascii?Q?6VhjKc28KbXDEiXmn8QJkh/u/vKGY8G1wdxvlv4eiGYrfZLjlvyqk7KowIVC?=
 =?us-ascii?Q?Z7jntcD3ihgL3DCJlJ93KAI16N6C3n3vYIdRIg+hYhG+qssREuuVuVcDxNFa?=
 =?us-ascii?Q?Rpp9h1w7PVtTM55ZdYlhtFGD7lkhJgAzNeyqUbb4YKpwRSYpXPrgU2akw0jQ?=
 =?us-ascii?Q?7McBRz4KDbKbxfqx05sjb7IWqJ8cF06zB6RItP6CdN0SqaL7PZiU?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bc2fbed-0fc8-49dd-55ec-08da130ff89b
X-MS-Exchange-CrossTenant-AuthSource: BLAPR10MB5267.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2022 12:14:14.6306
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y6+yt4BrVsWZshaYQGP9A7V2TPAoJs3Uo9voxFsLYabDqltQp6Yv2pVkqTnBlc+YPTA01+TiKYb+guZsiUSMFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB3350
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-03-31_04:2022-03-30,2022-03-31 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 phishscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203310068
X-Proofpoint-ORIG-GUID: j_e3YelQxGYWft63A0IMVMnH5O8yfmGP
X-Proofpoint-GUID: j_e3YelQxGYWft63A0IMVMnH5O8yfmGP
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On Fri, 25 Mar 2022, Andrii Nakryiko wrote:

> Wire up libbpf USDT support APIs without yet implementing all the
> nitty-gritty details of USDT discovery, spec parsing, and BPF map
> initialization.
> 
> User-visible user-space API is simple and is conceptually very similar
> to uprobe API.
> 
> bpf_program__attach_usdt() API allows to programmatically attach given
> BPF program to a USDT, specified through binary path (executable or
> shared lib), USDT provider and name. Also, just like in uprobe case, PID
> filter is specified (0 - self, -1 - any process, or specific PID).
> Optionally, USDT cookie value can be specified. Such single API
> invocation will try to discover given USDT in specified binary and will
> use (potentially many) BPF uprobes to attach this program in correct
> locations.
> 
> Just like any bpf_program__attach_xxx() APIs, bpf_link is returned that
> represents this attachment. It is a virtual BPF link that doesn't have
> direct kernel object, as it can consist of multiple underlying BPF
> uprobe links. As such, attachment is not atomic operation and there can
> be brief moment when some USDT call sites are attached while others are
> still in the process of attaching. This should be taken into
> consideration by user. But bpf_program__attach_usdt() guarantees that
> in the case of success all USDT call sites are successfully attached, or
> all the successfuly attachments will be detached as soon as some USDT
> call sites failed to be attached. So, in theory, there could be cases of
> failed bpf_program__attach_usdt() call which did trigger few USDT
> program invocations. This is unavoidable due to multi-uprobe nature of
> USDT and has to be handled by user, if it's important to create an
> illusion of atomicity.
> 
> USDT BPF programs themselves are marked in BPF source code as either
> SEC("usdt"), in which case they won't be auto-attached through
> skeleton's <skel>__attach() method, or it can have a full definition,
> which follows the spirit of fully-specified uprobes:
> SEC("usdt/<path>:<provider>:<name>"). In the latter case skeleton's
> attach method will attempt auto-attachment. Similarly, generic
> bpf_program__attach() will have enought information to go off of for
> parameterless attachment.
> 

Might be worth describing briefly the under-the-hood mechanisms; the
usdt_manager that is per-BPF-object (so can conceptually represent
multiple USDT providers/probes). It is initialized on first use and
freed with bpf_object__close(); it is tasked with managing the mapping
from usdt provider:name to actual sites+arguments via the spec/ip-to-id
maps.

> USDT BPF programs are actually uprobes, and as such for kernel they are
> marked as BPF_PROG_TYPE_KPROBE.
> 
> Another part of this patch is USDT-related feature probing:
>   - BPF cookie support detection from user-space;
>   - detection of kernel support for auto-refcounting of USDT semaphore.
> 
> The latter is optional. If kernel doesn't support such feature and USDT
> doesn't rely on USDT semaphores, no error is returned. But if libbpf
> detects that USDT requires setting semaphores and kernel doesn't support
> this, libbpf errors out with explicit pr_warn() message. Libbpf doesn't
> support poking process's memory directly to increment semaphore value,
> like BCC does on legacy kernels, due to inherent raciness and danger of
> such process memory manipulation. Libbpf let's kernel take care of this
> properly or gives up.
> 
> Logistically, all the extra USDT-related infrastructure of libbpf is put
> into a separate usdt.c file and abstracted behind struct usdt_manager.
> Each bpf_object has lazily-initialized usdt_manager pointer, which is
> only instantiated if USDT programs are attempted to be attached. Closing
> BPF object frees up usdt_manager resources. usdt_manager keeps track of
> USDT spec ID assignment and few other small things.
> 
> Subsequent patches will fill out remaining missing pieces of USDT
> initialization and setup logic.
> 
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>

again mostly nits and small suggestions below; this is fantastic Andrii!

Reviewed-by: Alan Maguire <alan.maguire@oracle.com>

> ---
>  tools/lib/bpf/Build             |   3 +-
>  tools/lib/bpf/libbpf.c          |  92 ++++++++++-
>  tools/lib/bpf/libbpf.h          |  15 ++
>  tools/lib/bpf/libbpf.map        |   1 +
>  tools/lib/bpf/libbpf_internal.h |  19 +++
>  tools/lib/bpf/usdt.c            | 270 ++++++++++++++++++++++++++++++++
>  6 files changed, 391 insertions(+), 9 deletions(-)
>  create mode 100644 tools/lib/bpf/usdt.c
> 
> diff --git a/tools/lib/bpf/Build b/tools/lib/bpf/Build
> index 94f0a146bb7b..31a1a9015902 100644
> --- a/tools/lib/bpf/Build
> +++ b/tools/lib/bpf/Build
> @@ -1,3 +1,4 @@
>  libbpf-y := libbpf.o bpf.o nlattr.o btf.o libbpf_errno.o str_error.o \
>  	    netlink.o bpf_prog_linfo.o libbpf_probes.o xsk.o hashmap.o \
> -	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o
> +	    btf_dump.o ringbuf.o strset.o linker.o gen_loader.o relo_core.o \
> +	    usdt.o
> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
> index 809fe209cdcc..8841499f5f12 100644
> --- a/tools/lib/bpf/libbpf.c
> +++ b/tools/lib/bpf/libbpf.c
> @@ -483,6 +483,8 @@ struct elf_state {
>  	int st_ops_shndx;
>  };
>  
> +struct usdt_manager;
> +
>  struct bpf_object {
>  	char name[BPF_OBJ_NAME_LEN];
>  	char license[64];
> @@ -545,6 +547,8 @@ struct bpf_object {
>  	size_t fd_array_cap;
>  	size_t fd_array_cnt;
>  
> +	struct usdt_manager *usdt_man;
> +
>  	char path[];
>  };
>  
> @@ -4678,6 +4682,18 @@ static int probe_perf_link(void)
>  	return link_fd < 0 && err == -EBADF;
>  }
>  
> +static int probe_kern_bpf_cookie(void)
> +{
> +	struct bpf_insn insns[] = {
> +		BPF_RAW_INSN(BPF_JMP | BPF_CALL, 0, 0, 0, BPF_FUNC_get_attach_cookie),
> +		BPF_EXIT_INSN(),
> +	};
> +	int ret, insn_cnt = ARRAY_SIZE(insns);
> +
> +	ret = bpf_prog_load(BPF_PROG_TYPE_KPROBE, NULL, "GPL", insns, insn_cnt, NULL);
> +	return probe_fd(ret);
> +}
> +
>  enum kern_feature_result {
>  	FEAT_UNKNOWN = 0,
>  	FEAT_SUPPORTED = 1,
> @@ -4740,6 +4756,9 @@ static struct kern_feature_desc {
>  	[FEAT_MEMCG_ACCOUNT] = {
>  		"memcg-based memory accounting", probe_memcg_account,
>  	},
> +	[FEAT_BPF_COOKIE] = {
> +		"BPF cookie support", probe_kern_bpf_cookie,
> +	},
>  };
>  
>  bool kernel_supports(const struct bpf_object *obj, enum kern_feature_id feat_id)
> @@ -8200,6 +8219,9 @@ void bpf_object__close(struct bpf_object *obj)
>  	if (obj->clear_priv)
>  		obj->clear_priv(obj, obj->priv);
>  
> +	usdt_manager_free(obj->usdt_man);
> +	obj->usdt_man = NULL;
> +
>  	bpf_gen__free(obj->gen_loader);
>  	bpf_object__elf_finish(obj);
>  	bpf_object_unload(obj);
> @@ -8630,6 +8652,7 @@ int bpf_program__set_log_buf(struct bpf_program *prog, char *log_buf, size_t log
>  }
>  
>  static int attach_kprobe(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> +static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_link **link);
>  static int attach_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
>  static int attach_raw_tp(const struct bpf_program *prog, long cookie, struct bpf_link **link);
>  static int attach_trace(const struct bpf_program *prog, long cookie, struct bpf_link **link);
> @@ -8647,6 +8670,7 @@ static const struct bpf_sec_def section_defs[] = {
>  	SEC_DEF("uretprobe/",		KPROBE, 0, SEC_NONE),
>  	SEC_DEF("kprobe.multi/",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
>  	SEC_DEF("kretprobe.multi/",	KPROBE,	BPF_TRACE_KPROBE_MULTI, SEC_NONE, attach_kprobe_multi),
> +	SEC_DEF("usdt+",		KPROBE,	0, SEC_NONE, attach_usdt),
>  	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE),
>  	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE | SEC_SLOPPY_PFX | SEC_DEPRECATED),
>  	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE | SEC_SLOPPY_PFX),
> @@ -9692,14 +9716,6 @@ int bpf_prog_load_deprecated(const char *file, enum bpf_prog_type type,
>  	return bpf_prog_load_xattr2(&attr, pobj, prog_fd);
>  }
>  
> -struct bpf_link {
> -	int (*detach)(struct bpf_link *link);
> -	void (*dealloc)(struct bpf_link *link);
> -	char *pin_path;		/* NULL, if not pinned */
> -	int fd;			/* hook FD, -1 if not applicable */
> -	bool disconnected;
> -};
> -
>  /* Replace link's underlying BPF program with the new one */
>  int bpf_link__update_program(struct bpf_link *link, struct bpf_program *prog)
>  {
> @@ -10599,6 +10615,66 @@ struct bpf_link *bpf_program__attach_uprobe(const struct bpf_program *prog,
>  	return bpf_program__attach_uprobe_opts(prog, pid, binary_path, func_offset, &opts);
>  }
>  
> +struct bpf_link *bpf_program__attach_usdt(const struct bpf_program *prog,
> +					  pid_t pid, const char *binary_path,
> +					  const char *usdt_provider, const char *usdt_name,
> +					  const struct bpf_usdt_opts *opts)
> +{
> +	struct bpf_object *obj = prog->obj;
> +	struct bpf_link *link;
> +	long usdt_cookie;
> +	int err;
> +
> +	if (!OPTS_VALID(opts, bpf_uprobe_opts))
> +		return libbpf_err_ptr(-EINVAL);
> +
> +	/* USDT manager is instantiated lazily on first USDT attach. It will
> +	 * be destroyed together with BPF object in bpf_object__close().
> +	 */
> +	if (!obj->usdt_man) {
> +		obj->usdt_man = usdt_manager_new(obj);
> +		if (!obj->usdt_man)
> +			return libbpf_err_ptr(-ENOMEM);
> +	}
> +
> +	usdt_cookie = OPTS_GET(opts, usdt_cookie, 0);
> +	link = usdt_manager_attach_usdt(obj->usdt_man, prog, pid, binary_path,
> +				        usdt_provider, usdt_name, usdt_cookie);
> +	err = libbpf_get_error(link);
> +	if (err)
> +		return libbpf_err_ptr(err);
> +	return link;
> +}
> +
> +static int attach_usdt(const struct bpf_program *prog, long cookie, struct bpf_link **link)
> +{
> +	char *path = NULL, *provider = NULL, *name = NULL;
> +	const char *sec_name;
> +
> +	sec_name = bpf_program__section_name(prog);
> +	if (strcmp(sec_name, "usdt") == 0) {
> +		/* no auto-attach for just SEC("usdt") */
> +		*link = NULL;
> +		return 0;
> +	}
> +
> +	if (3 != sscanf(sec_name, "usdt/%m[^:]:%m[^:]:%m[^:]", &path, &provider, &name)) {
> +		pr_warn("invalid section '%s', expected SEC(\"usdt/<path>:<provider>:<name>\")\n",
> +			sec_name);

could have an else clause here for the parse success case I suppose to 
save having two sets of free()s.

> +		free(path);
> +		free(provider);
> +		free(name);
> +		return -EINVAL;
> +	}
> +
> +	*link = bpf_program__attach_usdt(prog, -1 /* any process */, path,
> +					 provider, name, NULL);
> +	free(path);
> +	free(provider);
> +	free(name);
> +	return libbpf_get_error(*link);
> +}
> +
>  static int determine_tracepoint_id(const char *tp_category,
>  				   const char *tp_name)
>  {
> diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
> index 05dde85e19a6..318eecaa14e7 100644
> --- a/tools/lib/bpf/libbpf.h
> +++ b/tools/lib/bpf/libbpf.h
> @@ -503,6 +503,21 @@ bpf_program__attach_uprobe_opts(const struct bpf_program *prog, pid_t pid,
>  				const char *binary_path, size_t func_offset,
>  				const struct bpf_uprobe_opts *opts);
>  
> +struct bpf_usdt_opts {
> +	/* size of this struct, for forward/backward compatibility */
> +	size_t sz;
> +	/* custom user-provided value accessible through usdt_cookie() */
> +	__u64 usdt_cookie;
> +	size_t :0;
> +};
> +#define bpf_usdt_opts__last_field usdt_cookie
> +

need doc comment here such as

/**
 * @brief **bpf_program__attach_usdt()** is just like
 * bpf_program__attach_uprobe_opts() except it covers
 * USDT (Userspace Static Defined Tracing) attachment.
 *
 * @param prog BPF program to attach
 * @param pid Process ID to attach the uprobe to, 0 for self (own 
process),
 * -1 for all processes
 * @param binary_path Path to binary that contains the USDT probe
 * @param usdt_provider USDT Provider name
 * @param usdt_name USDT Probe name
 * @param opts Options for altering USDT attachment
 * @return Reference to the newly created BPF link; or NULL is returned on 
error,
 * error code is stored in errno
 */


> +LIBBPF_API struct bpf_link *
> +bpf_program__attach_usdt(const struct bpf_program *prog,
> +			 pid_t pid, const char *binary_path,
> +			 const char *usdt_provider, const char *usdt_name,
> +			 const struct bpf_usdt_opts *opts);
> +
>  struct bpf_tracepoint_opts {
>  	/* size of this struct, for forward/backward compatiblity */
>  	size_t sz;
> diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
> index dd35ee58bfaa..82f6d62176dd 100644
> --- a/tools/lib/bpf/libbpf.map
> +++ b/tools/lib/bpf/libbpf.map
> @@ -444,6 +444,7 @@ LIBBPF_0.8.0 {
>  	global:
>  		bpf_object__destroy_subskeleton;
>  		bpf_object__open_subskeleton;
> +		bpf_program__attach_usdt;
>  		libbpf_register_prog_handler;
>  		libbpf_unregister_prog_handler;
>  		bpf_program__attach_kprobe_multi_opts;
> diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
> index b6247dc7f8eb..dd0d4ccfa649 100644
> --- a/tools/lib/bpf/libbpf_internal.h
> +++ b/tools/lib/bpf/libbpf_internal.h
> @@ -148,6 +148,15 @@ do {				\
>  #ifndef __has_builtin
>  #define __has_builtin(x) 0
>  #endif
> +
> +struct bpf_link {
> +	int (*detach)(struct bpf_link *link);
> +	void (*dealloc)(struct bpf_link *link);
> +	char *pin_path;		/* NULL, if not pinned */
> +	int fd;			/* hook FD, -1 if not applicable */
> +	bool disconnected;
> +};
> +
>  /*
>   * Re-implement glibc's reallocarray() for libbpf internal-only use.
>   * reallocarray(), unfortunately, is not available in all versions of glibc,
> @@ -329,6 +338,8 @@ enum kern_feature_id {
>  	FEAT_BTF_TYPE_TAG,
>  	/* memcg-based accounting for BPF maps and progs */
>  	FEAT_MEMCG_ACCOUNT,
> +	/* BPF cookie (bpf_get_attach_cookie() BPF helper) support */
> +	FEAT_BPF_COOKIE,
>  	__FEAT_CNT,
>  };
>  
> @@ -543,4 +554,12 @@ int bpf_core_add_cands(struct bpf_core_cand *local_cand,
>  		       struct bpf_core_cand_list *cands);
>  void bpf_core_free_cands(struct bpf_core_cand_list *cands);
>  
> +struct usdt_manager *usdt_manager_new(struct bpf_object *obj);
> +void usdt_manager_free(struct usdt_manager *man);
> +struct bpf_link * usdt_manager_attach_usdt(struct usdt_manager *man,
> +					   const struct bpf_program *prog,
> +					   pid_t pid, const char *path,
> +					   const char *usdt_provider, const char *usdt_name,
> +					   long usdt_cookie);
> +
>  #endif /* __LIBBPF_LIBBPF_INTERNAL_H */
> diff --git a/tools/lib/bpf/usdt.c b/tools/lib/bpf/usdt.c
> new file mode 100644
> index 000000000000..8481e300598e
> --- /dev/null
> +++ b/tools/lib/bpf/usdt.c
> @@ -0,0 +1,270 @@
> +// SPDX-License-Identifier: (LGPL-2.1 OR BSD-2-Clause)
> +/* Copyright (c) 2022 Meta Platforms, Inc. and affiliates. */
> +#include <ctype.h>
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <libelf.h>
> +#include <gelf.h>
> +#include <unistd.h>
> +#include <linux/ptrace.h>
> +#include <linux/kernel.h>
> +
> +#include "bpf.h"
> +#include "libbpf.h"
> +#include "libbpf_common.h"
> +#include "libbpf_internal.h"
> +#include "hashmap.h"
> +
> +#define PERF_UPROBE_REF_CTR_OFFSET_SHIFT 32
> +
> +struct usdt_target {
> +	long abs_ip;
> +	long rel_ip;
> +	long sema_off;
> +};
> +
> +struct usdt_manager {
> +	struct bpf_map *specs_map;
> +	struct bpf_map *ip_to_id_map;
> +
> +	bool has_bpf_cookie;
> +	bool has_sema_refcnt;
> +};
> +
> +struct usdt_manager *usdt_manager_new(struct bpf_object *obj)
> +{
> +	static const char *ref_ctr_sysfs_path = "/sys/bus/event_source/devices/uprobe/format/ref_ctr_offset";

probably deserves a #define, and that would get us under the 100 char 
limit too..

> +	struct usdt_manager *man;
> +	struct bpf_map *specs_map, *ip_to_id_map;
> +
> +	specs_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_specs");
> +	ip_to_id_map = bpf_object__find_map_by_name(obj, "__bpf_usdt_specs_ip_to_id");
> +	if (!specs_map || !ip_to_id_map) {
> +		pr_warn("usdt: failed to find USDT support BPF maps, did you forget to include bpf/usdt.bpf.h?\n");

nice, I like the fact the error message also tells you how to fix it!

> +		return NULL;
> +	}
> +
> +	man = calloc(1, sizeof(*man));
> +	if (!man)
> +		return NULL;
> +
> +	man->specs_map = specs_map;
> +	man->ip_to_id_map = ip_to_id_map;
> +
> +        /* Detect if BPF cookie is supported for kprobes.
> +	 * We don't need IP-to-ID mapping if we can use BPF cookies.
> +         * Added in: 7adfc6c9b315 ("bpf: Add bpf_get_attach_cookie() BPF helper to access bpf_cookie value")
> +         */
> +	man->has_bpf_cookie = kernel_supports(obj, FEAT_BPF_COOKIE);
> +
> +	/* Detect kernel support for automatic refcounting of USDT semaphore.
> +	 * If this is not supported, USDTs with semaphores will not be supported.
> +	 * Added in: a6ca88b241d5 ("trace_uprobe: support reference counter in fd-based uprobe")
> +	 */
> +	man->has_sema_refcnt = access(ref_ctr_sysfs_path, F_OK) == 0;
> +
> +	return man;
> +}
> +
> +void usdt_manager_free(struct usdt_manager *man)
> +{
> +	if (!man)
> +		return;
> +
> +	free(man);
> +}
> +
> +static int sanity_check_usdt_elf(Elf *elf, const char *path)
> +{
> +	GElf_Ehdr ehdr;
> +	int endianness;
> +
> +	if (elf_kind(elf) != ELF_K_ELF) {
> +		pr_warn("usdt: unrecognized ELF kind %d for '%s'\n", elf_kind(elf), path);
> +		return -EBADF;
> +	}
> +
> +	switch (gelf_getclass(elf)) {
> +	case ELFCLASS64:
> +		if (sizeof(void *) != 8) {
> +			pr_warn("usdt: attaching to 64-bit ELF binary '%s' is not supported\n", path);
> +			return -EBADF;
> +		}
> +		break;
> +	case ELFCLASS32:
> +		if (sizeof(void *) != 4) {
> +			pr_warn("usdt: attaching to 32-bit ELF binary '%s' is not supported\n", path);
> +			return -EBADF;
> +		}
> +		break;
> +	default:
> +		pr_warn("usdt: unsupported ELF class for '%s'\n", path);
> +		return -EBADF;
> +	}
> +
> +	if (!gelf_getehdr(elf, &ehdr))
> +		return -EINVAL;
> +
> +	if (ehdr.e_type != ET_EXEC && ehdr.e_type != ET_DYN) {
> +		pr_warn("usdt: unsupported type of ELF binary '%s' (%d), only ET_EXEC and ET_DYN are supported\n",
> +			path, ehdr.e_type);
> +		return -EBADF;
> +	}
> +
> +#if __BYTE_ORDER == __LITTLE_ENDIAN
> +	endianness = ELFDATA2LSB;
> +#elif __BYTE_ORDER == __BIG_ENDIAN
> +	endianness = ELFDATA2MSB;
> +#else
> +# error "Unrecognized __BYTE_ORDER__"
> +#endif
> +	if (endianness != ehdr.e_ident[EI_DATA]) {
> +		pr_warn("usdt: ELF endianness mismatch for '%s'\n", path);
> +		return -EBADF;
> +	}
> +
> +	return 0;
> +}
> +

these sanity checks are great.

> +static int collect_usdt_targets(struct usdt_manager *man, Elf *elf, const char *path, pid_t pid,
> +				const char *usdt_provider, const char *usdt_name, long usdt_cookie,
> +				struct usdt_target **out_targets, size_t *out_target_cnt)
> +{
> +	return -ENOTSUP;
> +}
> +
> +struct bpf_link_usdt {
> +	struct bpf_link link;
> +
> +	struct usdt_manager *usdt_man;
> +
> +	size_t uprobe_cnt;
> +	struct {
> +		long abs_ip;
> +		struct bpf_link *link;
> +	} *uprobes;
> +};
> +
> +static int bpf_link_usdt_detach(struct bpf_link *link)
> +{
> +	struct bpf_link_usdt *usdt_link = container_of(link, struct bpf_link_usdt, link);
> +	int i;
> +
> +	for (i = 0; i < usdt_link->uprobe_cnt; i++) {
> +		/* detach underlying uprobe link */
> +		bpf_link__destroy(usdt_link->uprobes[i].link);
> +	}
> +
> +	return 0;
> +}
> +
> +static void bpf_link_usdt_dealloc(struct bpf_link *link)
> +{
> +	struct bpf_link_usdt *usdt_link = container_of(link, struct bpf_link_usdt, link);
> +
> +	free(usdt_link->uprobes);
> +	free(usdt_link);
> +}
> +
> +struct bpf_link *usdt_manager_attach_usdt(struct usdt_manager *man, const struct bpf_program *prog,
> +					  pid_t pid, const char *path,
> +					  const char *usdt_provider, const char *usdt_name,
> +					  long usdt_cookie)
> +{
> +	int i, fd, err;
> +	LIBBPF_OPTS(bpf_uprobe_opts, opts);
> +	struct bpf_link_usdt *link = NULL;
> +	struct usdt_target *targets = NULL;
> +	size_t target_cnt;
> +	Elf *elf;

Thought we should probably init elf to NULL, though I see we don't goto 
err_out except in cases where it's been explicitly set.

> +
> +	if (bpf_program__fd(prog) < 0) {
> +		pr_warn("prog '%s': can't attach BPF program w/o FD (did you load it?)\n",

nit: might be no harm "w/o" to expand to "without", and prefix with usdt: 
as below..

> +			bpf_program__name(prog));
> +		return libbpf_err_ptr(-EINVAL);
> +	}
> +
> +	/* TODO: perform path resolution similar to uprobe's */
> +	fd = open(path, O_RDONLY);
> +	if (fd < 0) {
> +		err = -errno;
> +		pr_warn("usdt: failed to open ELF binary '%s': %d\n", path, err);
> +		return libbpf_err_ptr(err);
> +	}
> +
> +	elf = elf_begin(fd, ELF_C_READ_MMAP, NULL);
> +	if (!elf) {
> +		err = -EBADF;
> +		pr_warn("usdt: failed to parse ELF binary '%s': %s\n", path, elf_errmsg(-1));
> +		goto err_out;
> +	}
> +
> +	err = sanity_check_usdt_elf(elf, path);
> +	if (err)
> +		goto err_out;
> +
> +	/* normalize PID filter */
> +	if (pid < 0)
> +		pid = -1;
> +	else if (pid == 0)
> +		pid = getpid();
> +
> +	/* discover USDT in given binary, optionally limiting
> +	 * activations to a given PID, if pid > 0
> +	 */
> +	err = collect_usdt_targets(man, elf, path, pid, usdt_provider, usdt_name,
> +				   usdt_cookie, &targets, &target_cnt);
> +	if (err <= 0) {

we haven't filled out collect_usdt_targets() yet, but might be no harm to 
have a pr_debug() here "usdt: cannot collect USDT targets for ..." since 
there are a few cases without warnings in the later patch.

> +		err = (err == 0) ? -ENOENT : err;
> +		goto err_out;
> +	}
> +
> +	link = calloc(1, sizeof(*link));
> +	if (!link) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	link->usdt_man = man;
> +	link->link.detach = &bpf_link_usdt_detach;
> +	link->link.dealloc = &bpf_link_usdt_dealloc;
> +
> +	link->uprobes = calloc(target_cnt, sizeof(*link->uprobes));
> +	if (!link->uprobes) {
> +		err = -ENOMEM;
> +		goto err_out;
> +	}
> +
> +	for (i = 0; i < target_cnt; i++) {
> +		struct usdt_target *target = &targets[i];
> +		struct bpf_link *uprobe_link;
> +
> +		opts.ref_ctr_offset = target->sema_off;
> +		uprobe_link = bpf_program__attach_uprobe_opts(prog, pid, path,
> +							      target->rel_ip, &opts);
> +		err = libbpf_get_error(link);
> +		if (err) {
> +			pr_warn("usdt: failed to attach uprobe #%d for '%s:%s' in '%s': %d\n",
> +				i, usdt_provider, usdt_name, path, err);
> +			goto err_out;
> +		}
> +
> +		link->uprobes[i].link = uprobe_link;
> +		link->uprobes[i].abs_ip = target->abs_ip;
> +		link->uprobe_cnt++;
> +	}
> +
> +	elf_end(elf);
> +	close(fd);
> +
> +	return &link->link;
> +
> +err_out:
> +	bpf_link__destroy(&link->link);
> +
> +	if (elf)
> +		elf_end(elf);
> +	close(fd);
> +	return libbpf_err_ptr(err);
> +}
> -- 
> 2.30.2
> 
> 

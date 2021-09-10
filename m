Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC8E8406883
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbhIJIck (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Sep 2021 04:32:40 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28126 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231788AbhIJIcj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Sep 2021 04:32:39 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18A5Iv79007227;
        Fri, 10 Sep 2021 08:31:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=iH4d2QPOWBc7A4QUf68BI2La/PgmMBaDryDse8ZQ9E0=;
 b=CfV+FDSeyo5ECuXe9KO+XBMXMYZu2a5QJnaED7cJ8O5jZXaIoZCZAKjA36qFBiQMBUDc
 gCNU0VxXNFo68NvvezIJtUl+1LRIrnW7qM8mrbJZcrVa8CbdfCzrvoyL4LgeYeHSGT7W
 ISMpfb1ZiFp6ur1qCtMhBxmftAdoSn/W+8TdRoFtaV/jIdElrjjaGf4zi8qD4TI3w20F
 7vLggogl8FLGzjTz7w5EwzDjeZ5LhantssHnUZv2S+3PB82ecxHcwOVJGhSDa4XkrQU8
 SkqbfS6yLQTEbhYCBvXAW8zic6BVuPCavPcZJO94arNUKxP48xC5y7DubH//PmxlHVdR cg== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=iH4d2QPOWBc7A4QUf68BI2La/PgmMBaDryDse8ZQ9E0=;
 b=OD/zH44Kd+aBIowrF1y1cIq1YHQBEOINwCWyxm+nZd/VLkx0xI6xQLvwUtKFkh+i+xUj
 wGAqYGeSojTvWeWEI8XaoUvLkPjGQL0NSAwxg63wtJSqrMe0PTb36VuKwsqXWH83CAOR
 PuqaJL1CjKhdos6MjqX2pqy7qaXFrUwPiTQwun2WKMD0DBFKpil/BJdxbpfX/CXk1TvB
 9rKGH27m2xUMMuzCm2ZLnELckMNaISlmMYUUCdkT7+HwXRCv3dLXnzgF0HYIQia8ukNF
 CLqqU5Sz/+SDNaOA5bR848DfwxtAkyZFKKEpbmhn+gbOxynYpuI4yiqjC6ql/G3avScU bA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ayttbh4fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 08:31:14 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18A8Ow9l116831;
        Fri, 10 Sep 2021 08:31:13 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2170.outbound.protection.outlook.com [104.47.58.170])
        by userp3020.oracle.com with ESMTP id 3aytfd3yd4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 08:31:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CGNdwUJ1EWK3EUnK+uUBcd97PYJf6ybbjIzlswR1bJXdx1HrkYXxTKY1R/29ud5amg8WHI4meuofCqbmt6LSd35gcVFsgALll4+euhaizCSNqJwCme5suzxWfZ9ZI7JtZiLa7Ixnc6f13dRMUArAmWSOwULq+3Cg8OoNxFpKYWpBlA2zA6cKcftjfeLr5mvvnxessPGILOYibP2h3aSYfsKLOE8Xv0hcCynY1WFsP3c08BVyMvTTBBH2eLSouf06eeJ7vc5noyu1lpBF0r6sWtMvkdNbGHRj2lxxOLElVwqmyk7jmyl8eq8Srrq7oxRn7wrP2CGrVu4TYCDYBZJJ3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=iH4d2QPOWBc7A4QUf68BI2La/PgmMBaDryDse8ZQ9E0=;
 b=PmdlGJamZIHe4/7t05nWtBiT2Pce7InGdEsKEtGn6otQ/Q3bGezmQRaUv/aSdaGxW29OJnTfJnB5hzk+rivdT3YdLwoTzgNdOgEPf9Ek9SDN6kVPMqZ23GfqSHrcr6v+4ETfJYqg/TZl5hS0vlJt76C9OzKi0/wbQxpbJlU17xm80hHCxbMdlGuS4t0Vw0Q3uGRnb+Rm2jPe6K+PDBN/9G3FH0fxF2AavVsjQbtmucYMEI/HB2lxk66E+HG4GCCrH+HZSdu9QIhWbAimGloKkSlfMOYTkvw7YrGWDT4rAEmVo2LOcSJ0rFjmOVGUE2Cnx70Suio9t6MMTRQ5bIZdFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iH4d2QPOWBc7A4QUf68BI2La/PgmMBaDryDse8ZQ9E0=;
 b=eQLGisKnA1nGI8zulEXU9ncCUhNU0qfNbIh7TaBGJJHsEBMLp5+KgaCjXqJqfDkFJSNWt+CXqRDnEH4r0WgT4yyYbzcUAUtGeuEuWNZRB/MruMGY2EvYWOHAlkGtD06XKtb9DVST61Ewk/ZlmRKmm8Gz6QpUyevD0oRcCkiW1nU=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SJ0PR10MB4750.namprd10.prod.outlook.com (2603:10b6:a03:2d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Fri, 10 Sep
 2021 08:31:11 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::f89b:d57b:829b:84ca]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::f89b:d57b:829b:84ca%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 08:31:11 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        <david.faust@oracle.com>
Subject: Re: [PATCH bpf-next 0/9] bpf: add support for new btf kind
 BTF_KIND_TAG
References: <20210907230050.1957493-1-yhs@fb.com> <87a6kl8j1j.fsf@oracle.com>
        <e79ad277-9f26-1169-6e31-57d0b70d89d2@fb.com>
        <87o8915g02.fsf@oracle.com>
        <03ff4fbd-b51d-2eff-303b-b36560d1b986@fb.com>
Date:   Fri, 10 Sep 2021 10:31:03 +0200
In-Reply-To: <03ff4fbd-b51d-2eff-303b-b36560d1b986@fb.com> (Yonghong Song's
        message of "Fri, 10 Sep 2021 00:04:57 -0700")
Message-ID: <871r5w25o8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18f::16) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
Received: from termi.oracle.com (141.143.193.79) by LO4P123CA0389.GBRP123.PROD.OUTLOOK.COM (2603:10a6:600:18f::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 08:31:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3add163c-498b-4132-bcc9-08d97435582c
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4750:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SJ0PR10MB475086A0DF9E20C16AC6D23A94D69@SJ0PR10MB4750.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WBYhmLFEg/7R9VEKf70qpFT6xyWlopf8u11KV6xaTSTgOhpooHanNCHExg/ZV0xrVlL7SOSb//3nsxiq8JlcTXAtLJSkc53D6/bHjUhJX6of6jmIr2x7OKIjKE9rVsqA3y17pHXdBBCgeWzWHJvb3A+HryQsaXF5Dt5RNDvjODgcuEAF3PJjaWmSCwBvGZB+YraLcu/j4TYRbsA1nJuuorg0TS79izRjXDqlmtm6to3hV+YgOvxDd6+x13gCwsDxsAo2w2k8eHOce9AfEvTU7KP1rBbL4jQdkYvraM0wD5JYjinK6Dtn+h8cz68G4VxBb17vwU+JykUDhg6CE6vOaaObnRcUJooTiIltpJijwkBT1JmuP8V4kVHyjiZEsFXs+wH//Tbg64AA1PTw0+VrTLNEBVSOsTdX4gxGVfQlT4a0CRKWvwqM2FQmySGlUcs4eYfvJlfMN2jT6uyzLb+HI1Ia+QHQH/++c31rv8p9YrLp95sGf+nI6Qf6NxpwFLbzcT5hl/3HW5kVAzMwNkf7Iw0PRwNDqe4DsFi3A9aTfsu/dXKAyArQ2osRqPfApaCYJrKeqIA1dOXLEmnvoVAScWGRCKGn8jOyiH1GsMPb+3Ttmya9dF14kblvnMPyUldEYESh/0s87DLS14JVTk6kpBuSZPwHa4NEbfTbJfYHyP+Jet1TcnpI+zbIALdz1hjU694OES8sMfMrfCedFIVoO99N4d55Qxw37/ujjiYpIGAGackXhv2Lg6xDSfUpuaJuK8fqcqisQ6TolWFdJtopDDPTINv7+wCt/IJ+QehwoDGD6RoXF5FgVIJNiDkVlMDHvicpPb5BdwyI/8G478/NSw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(396003)(376002)(39860400002)(136003)(366004)(86362001)(26005)(6666004)(5660300002)(36756003)(186003)(38100700002)(38350700002)(66556008)(2906002)(66946007)(66476007)(83380400001)(8936002)(8676002)(54906003)(2616005)(956004)(6916009)(7696005)(52116002)(316002)(478600001)(4326008)(107886003)(966005)(53546011)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6P280cX2JTwyrbm0v/IISRpSzZ3nnLvxwd7oWXRXUc6Wq62jQ9UB8LG992Io?=
 =?us-ascii?Q?/XN/CRQiVMG1THHRp/uacTaQ9DK3incynDteUbMUXSqDaAq2YNxmJJpXRWUy?=
 =?us-ascii?Q?9uU9Wg1249CsyeaNme86YMq6g+6HuemNsFpylQjfYwVqBYympQlepECVPoB1?=
 =?us-ascii?Q?Y/TLwJnwO/o08ErcqK6+XOcIA4uJLAILrsJ56NNGDlSXtFeO3YyIhaxV22MS?=
 =?us-ascii?Q?ilz72Jlo6AdvHetIQ1njDSky6MwCHDY3x9yzCmZxXZDf5rdGVjXbECTkmC+U?=
 =?us-ascii?Q?rFEy8t/Yb1spVlkSjdxazLJXVvIeyvOfnkDDT2gn70tcdR9on8qCgcUiFqoH?=
 =?us-ascii?Q?6Z0Cvf6yHg1E4w1ISpEbBDJkeW11vR/Nm1YqkvpVd8wI/6FpkE13UPDNgD92?=
 =?us-ascii?Q?VlmVdiqNWUb51l1t8qECEbWqa/aAeKWHZOdEqmtNZRgDOfqYoCehOYknUvIU?=
 =?us-ascii?Q?CfXtMxLCUEX+bA4FahIxXTJOfOmXvnaGhwDa5maV5avHuXRzC4VoI69kpguv?=
 =?us-ascii?Q?hn4a6KMDALqm0iGAdFbvzVZ+fqk4R3rZoS6Ww/qnVkcqRK9Hvza4RUZIlbzn?=
 =?us-ascii?Q?SPv7iHZx1ZjsIzfLDNmm7SH5+YxFob1JKKEZttntAlbuWpPuSMXKLZMu+NGD?=
 =?us-ascii?Q?BYar+Ixm6fCROSLFZgxusHSMU0ZHA3LMt4Puu2Np113Vqde2rDTplpX3VLKh?=
 =?us-ascii?Q?BYBPPUgTvss3O11K1wdGoQeHMSGR72mefirxtgxL5TReG+GdcCxQNbHDnvzZ?=
 =?us-ascii?Q?AVGTF1m8NnH5NBhg7RMm62XrU1qqaqT/h6UdAu1Njvhm74csAFSQMoYy9lO6?=
 =?us-ascii?Q?vhM50jTeT/TvMDx6IGJCixwx25gN8bIcyedP2W5xX4AjOzSTqWJ4APymwTgG?=
 =?us-ascii?Q?iT4yvjWNIf1X3zkQE6gjia1pXCv64XqapBnmlUqQdu3KCJEkCYmdP0nunshC?=
 =?us-ascii?Q?OqZ05pJsmNTVdhAXJ4esMMN7HTIYTgG6SM0PCi0XfvUEgxF+Ec9D25vb//66?=
 =?us-ascii?Q?joR3ZNMOmXV6eraezOn+qMHV1aXbtUDO5T997ncYXK4Fhn96gi/b1YygeaGX?=
 =?us-ascii?Q?/UaAptZx9R2zJsIXgb780wKM9r5xr27AsOzovIRcEYbJcW+FZV1lZlwHEicp?=
 =?us-ascii?Q?fejigguV7sUNr59/Y0tUtTV5XMZ1GVlg8ag5KPsCv91+FHpzxqJYqjj+yMoH?=
 =?us-ascii?Q?aqp/Q7kxc5WOqTZiGjdURzTQKL7mKhaOSbAKMrerjMHzWX4oSrrVdcvF7Ba2?=
 =?us-ascii?Q?V7YrHZREUbYX516DFXyXzBAPWFnqFUiKZ+4rVBq2bXFWa4mSa936mF/wMFj2?=
 =?us-ascii?Q?+rC78VhmQo3JWf7rk285L3OI?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3add163c-498b-4132-bcc9-08d97435582c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 08:31:11.3130
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 51iFh7GKYgJUdnUZpATokZ6zoeaK016JtRGhYH+4KD7/qsVKSF+YiZ0uUzhVVkhYG9ra4NrEWU9hCwn4JyN7X6Fdeg/q+7ol/Kt0iswdnkQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4750
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 bulkscore=0
 suspectscore=0 spamscore=0 mlxlogscore=999 mlxscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109100053
X-Proofpoint-GUID: 9wl1QGfr9vp7Njx0K4N8VTYzYPN-9pRK
X-Proofpoint-ORIG-GUID: 9wl1QGfr9vp7Njx0K4N8VTYzYPN-9pRK
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 9/9/21 7:19 PM, Jose E. Marchesi wrote:
>> 
>>> On 9/9/21 3:45 PM, Jose E. Marchesi wrote:
>>>> Hi Yonghong.
>>>>
>>>>> LLVM14 added support for a new C attribute ([1])
>>>>>     __attribute__((btf_tag("arbitrary_str")))
>>>>> This attribute will be emitted to dwarf ([2]) and pahole
>>>>> will convert it to BTF. Or for bpf target, this
>>>>> attribute will be emitted to BTF directly ([3]).
>>>>> The attribute is intended to provide additional
>>>>> information for
>>>>>     - struct/union type or struct/union member
>>>>>     - static/global variables
>>>>>     - static/global function or function parameter.
>>>>>
>>>>> This new attribute can be used to add attributes
>>>>> to kernel codes, e.g., pre- or post- conditions,
>>>>> allow/deny info, or any other info in which only
>>>>> the kernel is interested. Such attributes will
>>>>> be processed by clang frontend and emitted to
>>>>> dwarf, converting to BTF by pahole. Ultimiately
>>>>> the verifier can use these information for
>>>>> verification purpose.
>>>>>
>>>>> The new attribute can also be used for bpf
>>>>> programs, e.g., tagging with __user attributes
>>>>> for function parameters, specifying global
>>>>> function preconditions, etc. Such information
>>>>> may help verifier to detect user program
>>>>> bugs.
>>>>>
>>>>> After this series, pahole dwarf->btf converter
>>>>> will be enhanced to support new llvm tag
>>>>> for btf_tag attribute. With pahole support,
>>>>> we will then try to add a few real use case,
>>>>> e.g., __user/__rcu tagging, allow/deny list,
>>>>> some kernel function precondition, etc,
>>>>> in the kernel.
>>>> We are looking into implementing this in the GCC BPF port.
>>>
>>> Hi, Jose, thanks for your reply. It would be great if the
>>> btf_tag can be implemented in gcc.
>>>
>>>> Supporting the new C attribute in BPF programs as a target-specific
>>>> attribute, and the new BTF kind, is straightforward enough.
>>>> However, I am afraid it will be difficult to upstream to GCC support
>>>> for
>>>> a target-independent C attribute called `btf_tag' that emits a
>>>> LLVM-specific DWARF tag.  Even if we proposed to use a GCC-specific
>>>
>>> Are you concerned with the name? The btf_tag name cames from the
>>> discussion in
>>> https://lore.kernel.org/bpf/CAADnVQJa=b=hoMGU213wMxyZzycPEKjAPFArKNatbVe4FvzVUA@mail.gmail.com/
>>> as llvm guys want this attribute to be explicitly referring to bpf echo
>>> system because we didn't implement for C++, and we didn't try to
>>> annotate everywhere. Since its main purpose is to eventually encode in
>>> btf (for different architectures), so we settled with btf_tag instead of
>>> bpf_tag.
>>>
>>> But if you have suggestion to change to a different name which can
>>> be acceptable by both gcc and llvm community, I am okay with that.
>> I think the name of the attribute is very fine when BTF is generated
>> directly, like when compiling BPF programs.  My concern is that the
>> connection `btf_tag () -> DWARF -> kernel/pahole -> BTF' may be seen as
>> too indirect and application-specific (the kernel) for a general-purpose
>> compiler attribute.
>
> For llvm, btf_tag implies implementation scope as it *only covers* btf
> use cases. There are some other use cases which may utilize the same
> IR/dwarf implementation, but they may use a flag to control or different
> attribute. And this has been agreed upon with llvm community, so we
> should be okay here.
>
>>>> DWARF tag like DW_TAG_GNU_annotation using the same number, or better a
>>>> compiler neutral tag like DW_TAG_annotation or DW_TAG_BPF_annotation,
>>>> adding such an attribute for all targets would still likely to be much
>>>> controversial...
>>>
>>> This is okay too. If gcc settles with DW_TAG_GNU_annotation with a
>>> different number (not conflict with existing other llvm tag numbers),
>>> I think llvm can change to have the same name and number since we are
>>> still in the release.
>> Thanks, that is very nice and appreciated :) I don't think the
>> particular number used to encode the tag matters much, provided it
>> doesn't collide with any existing one of course...
>> However, there may be a way to entirely avoid creating a new DWARF
>> tag... see below.
>> 
>>>> Would you be open to explore other, more generic, ways to convey
>>>> these
>>>> annotations to pahole, something that could be easily supported by GCC,
>>>> and potentially other C compilers?
>>>
>>> Could you share your proposal in detail? I think some kind of difference
>>> might be okay if it is handled by pahole and invisible to users,
>>> although it would be good if pahole only needs to handle single
>>> interface w.r.t. btf_tag support.
>> GCC can currently generate BTF for any target, not just BPF.  For
>> example, you can compile an object foo.o with both DWARF and BTF with:
>> $ gcc -c -gdwarf -gbtf foo.c
>> or with just BTF with:
>> $ gcc -c -gbtf foo.c
>> Binutils (ld) also supports full type deduplication for CTF, which
>> is
>> very similar to BTF.  We use it to build kernels in-house with CTF
>> enabled for dtrace.  It is certainly possible to add support to ld to
>> also merge and deduplicate BTF sections... it is similar enough to CTF
>> to (hopefully) not require much work, and we were already considering
>> doing it anyway for other purposes.
>> So the proposal would be:
>> For GCC, we can implement the btf_tag for any target, but impacting
>> only
>> the BTF output as the name implies.  No effect in DWARF.  Once ld is
>> able to merge and deduplicate BTF, it shall then be possible to build
>> the kernel and obtain the BTF for it without the aid of pahole, just
>> building it with -gdwarf -gbtf and linking normally. (We know this works
>> with CTF.)
>
> This should be okay.

Super.  We will work in this direction.

>> For LLVM, nothing would have to be done in the short term: just use
>> the
>> DWARF DIE + pahole approach already implemented.  But in the medium term
>> LLVM could be made to 1) support emitting BTF for any target (not sure
>> how difficult would that be, maybe it already can do that?) and 2) to
>> support the -gbtf command-line option.
>> Then the generation of BTF for the kernel could be done in the same
>> way
>> (same build rules) with both compilers, and there would be no need for
>> conveying the extra tags (nor any future extensions to aid the verifier
>> on the kernel side) to pahole via DWARF.  Pure BTF all the way up (or
>> down) without diversion to DWARF :)
>> Does this make sense? WDYT?
>
> During discussion to implement btf_tag attribute, I actually have a
> prototype to emit BTF with non-BPF targets in llvm.
> see https://reviews.llvm.org/D103549
>
> But since we get a simpler solution to emit the info to llvm, so we went
> there. We will keep this in mind, it is totally possible in the future
> we may start to directly generate BTF from llvm for all architectures.

Nice :)
Thanks.

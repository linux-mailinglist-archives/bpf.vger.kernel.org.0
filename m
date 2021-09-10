Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B77204065A6
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 04:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbhIJCVT (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 22:21:19 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:49104 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhIJCVT (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Sep 2021 22:21:19 -0400
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189LkJ3K023985;
        Fri, 10 Sep 2021 02:19:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=n7jwF4gTUfTU5I26mWyc20Su70nYaYPyiRUvYCN9ugo=;
 b=EQdmgFwIUQkcHxYUzbvQco9wO625kePfHD9GJqS49I2qlO3wab3O7jL7YBDwxg62LaZ7
 06rYUcazzpM4O7Yng4fRRL/WxIvt9uYd9dD+v6BHe0wdt+96MM7SE4pana1cUgW9tLsK
 yQtvqz6G6fR6O/o9ZYdXgah7CwRxYekGfje/5wwmU7DBc/8whmV9uSzlRKgTV7+8ea6M
 iJdKMmOx9iIqkllFvtHa/hI7C0ZzjFTfIbZs2FXf/DBBvtHOKRKpaJK3GePwIHhMXi0D
 k3+6y5jAAjmn/d/k4Sfw4cylxAkxDRJgf+jUYHzkxZIkRBKvl1wGMIvxLw3hCykyGQtE LA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=n7jwF4gTUfTU5I26mWyc20Su70nYaYPyiRUvYCN9ugo=;
 b=NWS1z3MamuTGcqlTZe8pmcnHR2hwPVG8ey0OVKNgDqjemlzGUCA3r5bpD12ZXUwY19XW
 evedvy2yvg2S/U478XLsUs30OUmKJHVvNshnOUPx/mt25cwS6uxYxHh4BghuittrDCTA
 gNShhFa0mjtYnEE8syxz4SYsxOgbTTTfEWhxe88DFq9Dnss8wjRroUqS0yGc4u7JFLy0
 Za3UN1I7GrhcrPd5o2oINqsHQ1NdW8++seSiP1NEMOTBKjipNmG3FQ/UkdK0BD7e7pA3
 CLQo6XRR3o1UHsOx1RTt/Y+tyEZ+8AFJ0rocf2FB7TXZiFksk3fqz3vzb1Es3ECf0p/m WQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aytfk8f5q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 02:19:54 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 18A2AsdO004933;
        Fri, 10 Sep 2021 02:19:53 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by userp3030.oracle.com with ESMTP id 3aytft93s0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Sep 2021 02:19:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BDuzLzRplMrsn5To+falaKiNxLf6iwv/7MQQn2cQq2mSjuqfPc58yiJGsrkAlMKKYlCbhv7LiQb2tCoZwgBeHJRjRIXm6vF+FZtssNph7E2Jb9OnVB+1eho55jbUxg/rUzAbBFbPtCuOB0K7e4/GMhsrQbm4Tn1bIRvjg2RfPcvmNuL6KclAhG8t26Q09Qqdu3tDXqn8Ykt4Z0J17j9M2Ecrm6DtNriOvKtZDI98v7wJ88C452aANgfCI7ZKUapNkYJv0WPMVuAZ5ONS1/K5yWRbqZtqSwl+mSveDOKpNUYumwpqe49uZhd7vBDhxHOS0NjMHq+i5CwzYfuSYPNePA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=n7jwF4gTUfTU5I26mWyc20Su70nYaYPyiRUvYCN9ugo=;
 b=XQmiPxVfmbkXgM9KFAKmC/CzxK0xywP+E5pmFAkCXvRiTou8U8g6Bqdz98qs4TdVSkMmkrF3vc1NF6xZCMu14oGA56UInZgdTb5KYmwpPquke2Nzz/n/u3aUhae/nMvp7qqfFVlhxUNKptBKrJ+PMj2SA7XPOTiYx/XzHHrDd8G5EELbTwXx1GURtQNTUophJKVbjyghCZx3FDUOVG6b32ObIWloWgE9KwLd+uZSsbmP69I5VFiCKpOl5OVvaSCkPidIRlO6WPMuZ/aZ7C00u4ebLuSWwkVXO5mTDK1oMRvv1mId/zLUbwNONSVjezV7GoFZFiU7d75ujTCsniarZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n7jwF4gTUfTU5I26mWyc20Su70nYaYPyiRUvYCN9ugo=;
 b=NwX3lks54iUT5N4MVu2QE1HMpljxRnmfPtQdeP7CgsREhDVQ3hPXJ2UswSL+xwXv4pXkFscO2OsWxWu/b0f0h6vh+gBuOXAr42WaCQexBAGZgAh6WHGxzyejN9HuRwBSwv4Wwh9AFzxjTyACNnCiNGQsVghiw4YbSu8DlJLhTs4=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BYAPR10MB2936.namprd10.prod.outlook.com (2603:10b6:a03:84::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Fri, 10 Sep
 2021 02:19:51 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::f89b:d57b:829b:84ca]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::f89b:d57b:829b:84ca%7]) with mapi id 15.20.4500.017; Fri, 10 Sep 2021
 02:19:50 +0000
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
Date:   Fri, 10 Sep 2021 04:19:41 +0200
In-Reply-To: <e79ad277-9f26-1169-6e31-57d0b70d89d2@fb.com> (Yonghong Song's
        message of "Thu, 9 Sep 2021 16:30:40 -0700")
Message-ID: <87o8915g02.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0249.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:8a::21) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
Received: from termi.oracle.com (141.143.193.79) by LO2P265CA0249.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:8a::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Fri, 10 Sep 2021 02:19:49 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 527ff508-201d-42a4-d43d-08d9740177f8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2936:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB2936C1875B5A5D1039AC06A394D69@BYAPR10MB2936.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gNDfGWD8yBZ55/5ShlW5r/G4RpknQEqf8JJIuZN1v2Hffl6NI4l5x6VSiGzLaetzP0wj1vbx/ydTn3gP0xCy+Y5Ljxy388Tj+26mGAOKHQceP6EGjPd+fxGoHWAZvZwL/Fzt183Olbwz/xDEUrlgy3TkGzIGB244oUAhMgdFDEFnGddguoawKec1+fWfojLWZXM2OCXX0MvNQbCdw582MEHzSXZ0sBjqnXkuT7D6do+f2ClYaik1lJdMp3S7xsNn3drRnNfCMfhBt0fSePDhG894TcGs8wEWF+Edih1brsBf1R15MuBfjge42PLerQyUSw3W6q6yGmw9gxmCtBNt4nVyYIOYXdDoSzuZuVWY9Qww2fhv+y/AsIllPGwuZTX7cEyVg6CM7iVmtABh9heOWV8QS/NAhPYAjf608QbhiJeKox9bOoXtmxSBTu+O0mpMTHoe2a4Qpeel1Nn363xYN7hUvBe7xmk3skcSDqd9noPegIEVcmDqjTjvZKZmnflU8WHsujKwLtdnzxjaLIbXxmssz7ARG1BkDDAItvW3dThQ529OpCE0Q3/E9GmtGp5JZmVFpMdN3qPeA01uLZuqx1Rffy/f/3Z3li1rUrHQRqBkNQAkTT1417e+JbG9PIUFGhlQUJCu5hEPbjO4CTIR1XsZqRXRj+tDph1z1IexYJFWq8o5uEB/7tdYf0NB4RSW+maXYsCJdqTJ1hM7gl2rkWvE/abjcn2ABY5iln7Ta4Cr7DE5JCiF5bMWPbW7JUzXPAhts0cFeGVVoryCGriZS5ATc3zMJP/qwpuRQHI0TY0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(38100700002)(66476007)(54906003)(83380400001)(508600001)(66946007)(2616005)(6486002)(186003)(316002)(5660300002)(966005)(86362001)(8936002)(2906002)(26005)(4326008)(7696005)(52116002)(66556008)(8676002)(6666004)(956004)(6916009)(107886003)(36756003)(53546011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?WK4oWqPN3dvgehry9WdpNjLJ07066GHTFf9RsWv22YLhfvcvI1/n3ECpheIn?=
 =?us-ascii?Q?v8Ez9W1oHXtWdooUet25iVy4YQOznVvnoDjw7LnutJk4idbp3yyOmHaPX1BU?=
 =?us-ascii?Q?xz3yz6mWGYfyov5S+MIHybeMOevj4xoN/eEg+RN+i2xSPwoS0JvzE2Yb82yg?=
 =?us-ascii?Q?nuTvwT3OQQwQWKSEsS0Gv1mJNuVySdBUrMnC3y6CADLuauXErBaWSdKfj2PC?=
 =?us-ascii?Q?2uVErRWUySu1OJJaVTu2R1H4d1j2M+4XSCEbT3esxeMRRJGA3si4scIuKI0u?=
 =?us-ascii?Q?h7K90y4ZYOyn1wB3Uqg5MXe/zX6CMUZVs1LeZ4JyFSFajiwo2JXrrKNh8dMX?=
 =?us-ascii?Q?JZFoyB3pBW553nSQ5W9WmEht9PtKNDUEAe2icmJ2ud7bogFYaWMF4pSthcI1?=
 =?us-ascii?Q?xSZtndkZANj0hfH5mja6X3PfnkKhA1WttaIQKX1JuIHxO/Hthf+ykcXe4Yck?=
 =?us-ascii?Q?i31+rI164+iWZBiai0607+kMtQurowfo6pkEus+132zVda6rjP2KXEmlcm7B?=
 =?us-ascii?Q?Tx+Z6QW5WrO2Ro66DoR3kXej1KdBc1xf7Y0S7ik0qdSV4FY6Lp0t3vFJAh5v?=
 =?us-ascii?Q?q1fh4SaKqCei/ifTIed/FHj2BPSNRz+hT4GthG6KkTp84Ur/+4suP+wxqxdk?=
 =?us-ascii?Q?/Xi1d0ks4+3G48VdjuyyQ1Uq8zULUF4CT43d9q5zASxuHQm6wfiOrFk1sPSA?=
 =?us-ascii?Q?AIGPUEGAnw0q3XLkJ9RKyGrmUXTxc32dL/IjZ+C/pLDGv8HprzoE4U5mFcga?=
 =?us-ascii?Q?FrAH9cvIF/iBBksh6oFnCOYy2KhwlCmIRLDBRVtj+ZasUmBZSC8CBv9708jf?=
 =?us-ascii?Q?dU1KwQv9/YynVVwEQzMHbtB7YicJ5r8yX/1fHaDm92Fqt8586l7ZT5Wt50ly?=
 =?us-ascii?Q?NdtVrpUGSLZrPFeUoio1YU6bAN5Hm7w1eskoezsFgF6G/MaxKPtJMwqwnxWX?=
 =?us-ascii?Q?mPe5BdjpCM5a2WXWM0G03+gVddwhVlDZdlJq/541sNIjZEcbzZUjGEcrS/LJ?=
 =?us-ascii?Q?+3Lcq5lLXSDga4JX9crTVP2qIqw7ZDKRzM3TJ3xI8Wc0ucu21zg+Qn/PlLxA?=
 =?us-ascii?Q?gdKo9n0ecivkXaAvXPdUTaDiZqSn/KmIcR2uZ0nf6/vMgcCt+3wR7RJ//fcU?=
 =?us-ascii?Q?TOKZFSouqlxErpnCxsukmd2wGD3wYuFKELQihV3o+ofraFiix8ihr+gGoj4s?=
 =?us-ascii?Q?ZfSKsbXTSw6mtXg1P07hrzuyD8MfROWPRTWjp5BcjbaXsGq6RetlP2u5FQQO?=
 =?us-ascii?Q?Ic4ZzVqiwHt9j44kg8dihkZPKOigMl9GkgPkRVq0MwSgyCN8DezrY7w0H5dA?=
 =?us-ascii?Q?rs9EDzYWoEigW9zwzTpc8FVx?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 527ff508-201d-42a4-d43d-08d9740177f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2021 02:19:50.8939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1U7jIroYeLZwGowlLw5t/yrdCkoh5Mt3pGpAg4V/NcUxSGDOyoxGfSMWwY+DBO/kDGNmxuX25bKCcZ8oWz9mXq7QoH/OUH81ohkpvl2pby0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2936
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109100012
X-Proofpoint-GUID: ciKzZ_KTNPECr_i_NQVvJK9XdutXXqvp
X-Proofpoint-ORIG-GUID: ciKzZ_KTNPECr_i_NQVvJK9XdutXXqvp
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 9/9/21 3:45 PM, Jose E. Marchesi wrote:
>> Hi Yonghong.
>> 
>>> LLVM14 added support for a new C attribute ([1])
>>>    __attribute__((btf_tag("arbitrary_str")))
>>> This attribute will be emitted to dwarf ([2]) and pahole
>>> will convert it to BTF. Or for bpf target, this
>>> attribute will be emitted to BTF directly ([3]).
>>> The attribute is intended to provide additional
>>> information for
>>>    - struct/union type or struct/union member
>>>    - static/global variables
>>>    - static/global function or function parameter.
>>>
>>> This new attribute can be used to add attributes
>>> to kernel codes, e.g., pre- or post- conditions,
>>> allow/deny info, or any other info in which only
>>> the kernel is interested. Such attributes will
>>> be processed by clang frontend and emitted to
>>> dwarf, converting to BTF by pahole. Ultimiately
>>> the verifier can use these information for
>>> verification purpose.
>>>
>>> The new attribute can also be used for bpf
>>> programs, e.g., tagging with __user attributes
>>> for function parameters, specifying global
>>> function preconditions, etc. Such information
>>> may help verifier to detect user program
>>> bugs.
>>>
>>> After this series, pahole dwarf->btf converter
>>> will be enhanced to support new llvm tag
>>> for btf_tag attribute. With pahole support,
>>> we will then try to add a few real use case,
>>> e.g., __user/__rcu tagging, allow/deny list,
>>> some kernel function precondition, etc,
>>> in the kernel.
>> We are looking into implementing this in the GCC BPF port.
>
> Hi, Jose, thanks for your reply. It would be great if the
> btf_tag can be implemented in gcc.
>
>> Supporting the new C attribute in BPF programs as a target-specific
>> attribute, and the new BTF kind, is straightforward enough.
>> However, I am afraid it will be difficult to upstream to GCC support
>> for
>> a target-independent C attribute called `btf_tag' that emits a
>> LLVM-specific DWARF tag.  Even if we proposed to use a GCC-specific
>
> Are you concerned with the name? The btf_tag name cames from the
> discussion in
> https://lore.kernel.org/bpf/CAADnVQJa=b=hoMGU213wMxyZzycPEKjAPFArKNatbVe4FvzVUA@mail.gmail.com/
> as llvm guys want this attribute to be explicitly referring to bpf echo
> system because we didn't implement for C++, and we didn't try to
> annotate everywhere. Since its main purpose is to eventually encode in 
> btf (for different architectures), so we settled with btf_tag instead of
> bpf_tag.
>
> But if you have suggestion to change to a different name which can
> be acceptable by both gcc and llvm community, I am okay with that.

I think the name of the attribute is very fine when BTF is generated
directly, like when compiling BPF programs.  My concern is that the
connection `btf_tag () -> DWARF -> kernel/pahole -> BTF' may be seen as
too indirect and application-specific (the kernel) for a general-purpose
compiler attribute.

>> DWARF tag like DW_TAG_GNU_annotation using the same number, or better a
>> compiler neutral tag like DW_TAG_annotation or DW_TAG_BPF_annotation,
>> adding such an attribute for all targets would still likely to be much
>> controversial...
>
> This is okay too. If gcc settles with DW_TAG_GNU_annotation with a
> different number (not conflict with existing other llvm tag numbers),
> I think llvm can change to have the same name and number since we are
> still in the release.

Thanks, that is very nice and appreciated :) I don't think the
particular number used to encode the tag matters much, provided it
doesn't collide with any existing one of course...

However, there may be a way to entirely avoid creating a new DWARF
tag... see below.

>> Would you be open to explore other, more generic, ways to convey
>> these
>> annotations to pahole, something that could be easily supported by GCC,
>> and potentially other C compilers?
>
> Could you share your proposal in detail? I think some kind of difference
> might be okay if it is handled by pahole and invisible to users,
> although it would be good if pahole only needs to handle single 
> interface w.r.t. btf_tag support.

GCC can currently generate BTF for any target, not just BPF.  For
example, you can compile an object foo.o with both DWARF and BTF with:

$ gcc -c -gdwarf -gbtf foo.c

or with just BTF with:

$ gcc -c -gbtf foo.c

Binutils (ld) also supports full type deduplication for CTF, which is
very similar to BTF.  We use it to build kernels in-house with CTF
enabled for dtrace.  It is certainly possible to add support to ld to
also merge and deduplicate BTF sections... it is similar enough to CTF
to (hopefully) not require much work, and we were already considering
doing it anyway for other purposes.

So the proposal would be:

For GCC, we can implement the btf_tag for any target, but impacting only
the BTF output as the name implies.  No effect in DWARF.  Once ld is
able to merge and deduplicate BTF, it shall then be possible to build
the kernel and obtain the BTF for it without the aid of pahole, just
building it with -gdwarf -gbtf and linking normally. (We know this works
with CTF.)

For LLVM, nothing would have to be done in the short term: just use the
DWARF DIE + pahole approach already implemented.  But in the medium term
LLVM could be made to 1) support emitting BTF for any target (not sure
how difficult would that be, maybe it already can do that?) and 2) to
support the -gbtf command-line option.

Then the generation of BTF for the kernel could be done in the same way
(same build rules) with both compilers, and there would be no need for
conveying the extra tags (nor any future extensions to aid the verifier
on the kernel side) to pahole via DWARF.  Pure BTF all the way up (or
down) without diversion to DWARF :)

Does this make sense? WDYT?

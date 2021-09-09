Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D4E3405FB0
	for <lists+bpf@lfdr.de>; Fri, 10 Sep 2021 00:46:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345835AbhIIWrW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 9 Sep 2021 18:47:22 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:45502 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240862AbhIIWrW (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 9 Sep 2021 18:47:22 -0400
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 189LpLIh005243;
        Thu, 9 Sep 2021 22:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=sItQgDNlaec2CLKaGy8TugvbOJcR8VkGf9jjXdLkLsg=;
 b=NLPYSCz5ZN1f0RUkUlxpzRDSVIqb7H1qn68LJrjnntpdwrvDeQwfwpyNAwfEDel9umyp
 yn0O7sIu9H3APQmDbv9KGI4AXXWqCUyDsdGtcFjCqc4Z0s5y3qMQgCdqfZNrCnWyRsap
 TnA9IzZNPYLEXIVfeb4bU7Iajp9+yvH8oPbOa5dJruNT+tNT68pFbJNRvxRMKbMH218E
 TkeUNSMOapd8kUqqpPgdjmjsqBvCmA7Yz/7p4Scw3u7E68SNdYi8DxRpEK25u4LbE7LV
 1bu7Hhjd76pSzyE+xqoKU3Q2yryot1aIRbNHtJEiDvLNh3f7qt5lKhaenro1nih4YwIx Zw== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2020-01-29;
 bh=sItQgDNlaec2CLKaGy8TugvbOJcR8VkGf9jjXdLkLsg=;
 b=k0NGLYee5/Iua1eeOawvmCAU1L70VHzE8xUYB2+WyeDmTIFQ3pQ1qQU4F7cKb+RktzbR
 g3ZnDle/VC2HRdNSRn1pUoxodoSjMuIykx0JmesfRJIxXyFIJ4VbfydgaixmNTgrVTjM
 9np9HcGEmtqQs8ndcudCRlqAU0CPCbvj+bbcZWOqhxyNWka7/y95OeYAqL9NN2n/kyfw
 lFb3zG7cA2DicuBvwuH0kOgPMZAtz6Jl7BmWltl/Frk/l1Djoc+oxtyZd7U5EeUJBXhy
 /XO6o845M+gjJQRC1v+MTYvgwOFPulqd8FBZPHoEHMq91T4+ZxFgnvNhyCzooxE3Mn4r 1A== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3aytj5g37j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 22:45:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 189MerRe141664;
        Thu, 9 Sep 2021 22:45:55 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2044.outbound.protection.outlook.com [104.47.57.44])
        by userp3030.oracle.com with ESMTP id 3aytft1wh5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 09 Sep 2021 22:45:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L5uouqKOll27Dznyn5h5ZmveADtzFGiJ74nsB1JYusx7ib27rqUHyy/LaW8h51DvWgttNcmcTO8SH9jG8av8E6ruYHzFTYgWMtQFXsmlvYTMxYf5FtOcOYBAm8GrXxfpwKazHCRFSVeqrQOkcQv6vwiEFcXq4WIbiDMT71gZqA2w3cAjy98g8h6Rl0DfwkfObDacVLkEhlEo2tDSp8hJ8KkX3xFvX60M87fSY/figloNREgUkbUAeDfSgvKQtxDlyF6Fj56yBcdKvX05mvrXsPEiiYpRSUvnp2nwvjv31GJX7aMpnjdSecjiW2hk2Q33EmNHKYy4qb78N3pnphuYVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=sItQgDNlaec2CLKaGy8TugvbOJcR8VkGf9jjXdLkLsg=;
 b=h21zxPAFZuDe3PTcjWhOWnclo/VRbLknFGRKi6cepZ8zETIT4KomvzyaO+djQBdXvhGkEuhIwtYQmgaakT88aTWpcZ9lscviiXYhYSGU05hGc/DDgjS1fGopzoZFlEA3Bbx63jSBHEzStKdrvd/RiE4oMPUZZSY/aCtwUxEJYc5J0nE37SQvMfvNAJ5gcLxj1QFDB0ce/zpO0N5YIcKY7Hlwc9cCOgYe5J6h9kxJAu0kZiOBH+F1eWJwVd0is142cX3OtHC3//Hl+CyWmFG2IaGTmCvLU0Po9jkKcIKahsyTiDhYtfEiWngzMyXkhzYM2B4UG6Ru/p3fiwDTl/JKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sItQgDNlaec2CLKaGy8TugvbOJcR8VkGf9jjXdLkLsg=;
 b=JFLz+Tjczot8VU155f7XWCYZl/ZC8KhVtOGwaurH22gDQVLqj8PfsJy6f39aW7f5i9JrqfeInsia6KS3BnDoFv0gpDoSdubI4TMmhg7rZY8+ZFtHhxt7bZ92fFGvJaTGYJ932edlN8F3h5GLJt5DumlvVgaTGU7QE1x7OUQPbJ4=
Authentication-Results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=oracle.com;
Received: from DM6PR10MB2890.namprd10.prod.outlook.com (2603:10b6:5:71::31) by
 DM6PR10MB3050.namprd10.prod.outlook.com (2603:10b6:5:67::31) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4478.24; Thu, 9 Sep 2021 22:45:53 +0000
Received: from DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::d524:1da9:5a59:9958]) by DM6PR10MB2890.namprd10.prod.outlook.com
 ([fe80::d524:1da9:5a59:9958%5]) with mapi id 15.20.4500.017; Thu, 9 Sep 2021
 22:45:53 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        david.faust@oracle.com
Subject: Re: [PATCH bpf-next 0/9] bpf: add support for new btf kind
 BTF_KIND_TAG
References: <20210907230050.1957493-1-yhs@fb.com>
Date:   Fri, 10 Sep 2021 00:45:44 +0200
In-Reply-To: <20210907230050.1957493-1-yhs@fb.com> (Yonghong Song's message of
        "Tue, 7 Sep 2021 16:00:49 -0700")
Message-ID: <87a6kl8j1j.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AM3PR05CA0133.eurprd05.prod.outlook.com
 (2603:10a6:207:3::11) To DM6PR10MB2890.namprd10.prod.outlook.com
 (2603:10b6:5:71::31)
MIME-Version: 1.0
Received: from termi.oracle.com (141.143.193.79) by AM3PR05CA0133.eurprd05.prod.outlook.com (2603:10a6:207:3::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Thu, 9 Sep 2021 22:45:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 37f33c51-00e7-45be-7f1c-08d973e39434
X-MS-TrafficTypeDiagnostic: DM6PR10MB3050:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <DM6PR10MB3050EB7749C156DE9589C07294D59@DM6PR10MB3050.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: fIQUeqe6DcYlxpsUDC3oaL6eEaFNgAJfwQlzZCe+cCGAOm62OJazGHpGIOFkgKXmEkj7PjI6n9V6q79May3XS/QNJS7UUkJKsMGCAYlClVMI6GYguq6LESnN6jFQq7j+BwZyyeP0yf3fejyFZaanhU+KKCxemQm+Ds5lzH2NbTMpN27840e71wGDkIBzQDY7yFsACjLVjEHjDteEFuV5juSB5Sz+yo1sRPBEVanfiST+6J5Xo1MA7tuhswPDaw/rSaSAMrjEEjRRbQlRTSTOw+dpHEqjUe3IIKfXJvEfo5ubdXmlwATrHKRUHgnK0nJiXzDQFDvpGlUycukfQeqBUjzCw1dGXXiTh6T8hRi6vd1F761zF5VTqU7Q2v38KZV/R3fZy1uIZr1nd7eh+DclpQ4RJId2IZuNYtF61HvgvG5f2hT9aQqHCAWAb2BNBVso09EpKI522jFSuhHjMZk2NKAYtVbgMTHyyoZEZn+hQOrCmi04vU79PIfUaxNct7E+z2+QwdQGpcw2gRMZrJ9RYPHkde61bwhWAwOTeF+TtybAABcWIevaQ3Bw4ECTu9gDsLHXBg6VLnlkrX/aC8i9I5d5Bjtwrm3/7KzY3keBxEAuHvvo+JnVM4n6P4oHWRFT4xH3Vvcl1mzGHYSaSiWK4pCFosbe52yVCVtht/wfFRWetZeAt0O8ueYLt0CyQKH/BHJS72u9LUgd+OWvIb7pvQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB2890.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(346002)(376002)(39860400002)(396003)(52116002)(7696005)(38100700002)(8936002)(38350700002)(36756003)(26005)(186003)(8676002)(478600001)(2616005)(956004)(66476007)(54906003)(66946007)(6916009)(6666004)(2906002)(83380400001)(4326008)(6486002)(107886003)(316002)(5660300002)(86362001)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?a3Fr3Gv9JFhbUhxTTbTuJV9+Adyqplg+Wg9S/0HJDao7Pduw3I+S8Be8rPQD?=
 =?us-ascii?Q?TFGouMOYZaBFQth47CNbyhAEfG2ldXBl34+AOFJAjK+eTnRG12hcR0CiBuoH?=
 =?us-ascii?Q?gqMIsi+PfC9seFqcFBPR1AViqCVAkQeeY3QXKBbuMCpBIdlbKI2SSiHozS07?=
 =?us-ascii?Q?EKn4TNIM6oNLRelBqpUwmVXJQIECis1sQfXLAcBNLR+TL4BZiU2gyGAAS/vM?=
 =?us-ascii?Q?q6oGbX6j+wgb/lv8VdAUjHv1dWLCGRsKnAN+Jx0Zt2ZBofPAJpyACoXJ1L6E?=
 =?us-ascii?Q?iK1uBuImSrahHe+rEa2uvc62taHU+8AuFhwvbXafZyoJ8iEnD/hwmljns31+?=
 =?us-ascii?Q?SOfIek6f1x9mrBTAkoiCIQmH9VPhhm0XqQhCMC97nvvRJe/7r/xlYsH8/jfT?=
 =?us-ascii?Q?XhBJgSXGESPHn/jr6sDaSoXwb5kfVrnRgxQzpBkfwhifZn5kRNRl4IhSwPBz?=
 =?us-ascii?Q?F18MpS5m3JeHpUSmMu+20/MA8KcfPvs8Q5aeAyzZ8WI/Vma/8jQVtYpTIX7l?=
 =?us-ascii?Q?oSyRvT/orlES8Izger992Jj3rftO9WPyrbAuf8Ova4COIEGrlSAnPO8u2LHJ?=
 =?us-ascii?Q?psT7/Uqy9DEm7zWMayQq7ODGzzq++wQ6uTAn/PFv8whZBLuA0HWqR4MF5BrI?=
 =?us-ascii?Q?jR+72PXoXh5cgp30zOHWDsVSZ3U5qRQJjZrzZWpdRqas/3KgwidmEcXOJ+ne?=
 =?us-ascii?Q?poGCmNqcHT4cxERRXr6ZyLAtDnz4b3Dy0CpHG6TQ8d/301L86qHZw7oa8EB9?=
 =?us-ascii?Q?LQSuyaw+KyG+Qq2OZeTxgG/cArnYV7SID4DQ39CK0LBtR5zx5D/r0m0k8ysD?=
 =?us-ascii?Q?sp1IefyurxN7GV+xQAErTtAg5jRpczhLufNH/4VkH7+IWm2qSGGpt5QRtMuz?=
 =?us-ascii?Q?O3ft6sosD7ts8+26YVESxIOifhGBW3n3ZIIDIRcvzYlQpXoUfKo4RKU1qQ9i?=
 =?us-ascii?Q?nwfpqcr2gVwGMJXQjAgxw30O3mBWiNdT/mTIrkotEL/eigMAqllITWw2AyNg?=
 =?us-ascii?Q?xsyYUwhmvEpyomuU/Am6KyRJEEzsWUVSCyP3mRuChZ64WZAyj3319LIhWEcP?=
 =?us-ascii?Q?/ejSBdo3b6/WpzUCxOBbtM4TBAmNzOZBQT8+UjoWXc3JG2+VX0ADy6QJMp9L?=
 =?us-ascii?Q?owdWb6dImLRpMkRXVfFpeRnZLTs0YZgyAasWgeJow03fD2FV5/UHj+LayT2n?=
 =?us-ascii?Q?VSHCQ2DjWRZiQToR3sZZUiQ/TJIN1yIGQQPgfuuq3KNgtBNJtWHt0Jh07R9m?=
 =?us-ascii?Q?SuhKEBgGKOPNQduTVNYQvvfZbynsoQtW9ly55pg+fIqAvjcJrs8gkHTBI/1Y?=
 =?us-ascii?Q?e8ounTPiqGZ8kjx/ZgAzCru9?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37f33c51-00e7-45be-7f1c-08d973e39434
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB2890.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2021 22:45:53.3952
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p5mgnNOFNVJ3WyZwlNL3UjNGx9LwnvGz1OOsSu00tZ/kzRbiqz1CIvyToBrUk7cEatXKTAybW5RAIQro9LTdXXf5hXz/vdvE7kDZzvRRWnM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB3050
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10102 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 malwarescore=0 suspectscore=0 mlxscore=0 mlxlogscore=859
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2109030001
 definitions=main-2109090139
X-Proofpoint-GUID: jwIOoKM_oNJOXJCjDzOZvoswOIApMVhO
X-Proofpoint-ORIG-GUID: jwIOoKM_oNJOXJCjDzOZvoswOIApMVhO
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Yonghong.

> LLVM14 added support for a new C attribute ([1])
>   __attribute__((btf_tag("arbitrary_str")))
> This attribute will be emitted to dwarf ([2]) and pahole
> will convert it to BTF. Or for bpf target, this
> attribute will be emitted to BTF directly ([3]).
> The attribute is intended to provide additional
> information for
>   - struct/union type or struct/union member
>   - static/global variables
>   - static/global function or function parameter.
>
> This new attribute can be used to add attributes
> to kernel codes, e.g., pre- or post- conditions,
> allow/deny info, or any other info in which only
> the kernel is interested. Such attributes will
> be processed by clang frontend and emitted to
> dwarf, converting to BTF by pahole. Ultimiately
> the verifier can use these information for
> verification purpose.
>
> The new attribute can also be used for bpf
> programs, e.g., tagging with __user attributes
> for function parameters, specifying global
> function preconditions, etc. Such information
> may help verifier to detect user program
> bugs.
>
> After this series, pahole dwarf->btf converter
> will be enhanced to support new llvm tag
> for btf_tag attribute. With pahole support,
> we will then try to add a few real use case,
> e.g., __user/__rcu tagging, allow/deny list,
> some kernel function precondition, etc,
> in the kernel.

We are looking into implementing this in the GCC BPF port.

Supporting the new C attribute in BPF programs as a target-specific
attribute, and the new BTF kind, is straightforward enough.

However, I am afraid it will be difficult to upstream to GCC support for
a target-independent C attribute called `btf_tag' that emits a
LLVM-specific DWARF tag.  Even if we proposed to use a GCC-specific
DWARF tag like DW_TAG_GNU_annotation using the same number, or better a
compiler neutral tag like DW_TAG_annotation or DW_TAG_BPF_annotation,
adding such an attribute for all targets would still likely to be much
controversial...

Would you be open to explore other, more generic, ways to convey these
annotations to pahole, something that could be easily supported by GCC,
and potentially other C compilers?

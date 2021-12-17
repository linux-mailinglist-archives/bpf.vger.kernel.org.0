Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AD42478915
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 11:40:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233421AbhLQKky (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 17 Dec 2021 05:40:54 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:62716 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232014AbhLQKky (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 17 Dec 2021 05:40:54 -0500
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BH8H45Y004111;
        Fri, 17 Dec 2021 10:40:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : message-id : content-type : mime-version;
 s=corp-2021-07-09; bh=Eis59rklhUqOuys8BjG3yEC5C4tK7/b/8wMQdwkurOo=;
 b=i6nrncYodee81sCBKUvZmyo5AdkrTtgfYi4hF/5/QIF2+dGNK22rBxZJGAAeAJ+IZ43e
 +shWNSXNQWfRh9lEmHmoe7u10klstOtiMN0ZCOXRsYCR4byqBuqlFKu/0/yqgiBhcRKs
 KcrfmtqC4er1HbTn6PuTsf9vz2zvAZajyHWHwTykn9qwLVnH3Q5XRkUvkfZzbQ9M20hi
 Zph+EnWt0TpwelQCEc7rcc427T+LLnbWUemKH1iuaKq/uLnq679jB6PZqEbi+jFHWXt8
 /SY+SrqtnYiaLXqdeDvsYuwNzVAeLjgvfnPa/v5zYVZwpdkK0uvSs09IqEDzrtd2DMxV zg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cykmcna40-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 10:40:23 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BHAUj5C186372;
        Fri, 17 Dec 2021 10:40:22 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2048.outbound.protection.outlook.com [104.47.73.48])
        by userp3030.oracle.com with ESMTP id 3cvh43mb6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Dec 2021 10:40:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X/08T0zdTdVGwbmZ6VW7ND2e8md0WICaHI+8UXg4HyFnir6pKYR2D7Mllu/EzBT5/RjbQEwfUj0GS+HKw1R4rNPtZeZ+t2/wWj/FtBbEi8d57AvdeSuNcYI+NmxbZVC0s1e6Mu9l7/i9KDBGKcv+P9xq5nYdtNHqhKeuGvKdA2iFIMOwBHVin8jwHudAEECviz2nhOmezQ7mSWOIMnB7ne5kNVJ052dIvrPF6UCsDQ084gACDk+mY0HCVKpgHIbHKrlnRwGGlOPJ7wPDc5tOFv/Xj/7YNCI/9vz1CLf14aYb8axzCRRRRV/Hvgkx2pkam5MhJTbdDIrU+0ptYs1geg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eis59rklhUqOuys8BjG3yEC5C4tK7/b/8wMQdwkurOo=;
 b=g+4y8SAM4c5vFJZP/c7J1FiDJZH/s0646rBUm6T5J4qUXzz0zZyz0UPd/X9Iq1Cv9tqOk9Kd/TABMALxPIC4yRT/+u98VSb1JgL+YXv8XPKt2urHnVFYMkNEdUOi05V/8Xo+xCoUCuh8n4pyFwalZs4nXcKPjgtBtV8qKE5EVgIHkHbL8XzQdIES1z6qqMuviOYGT5gKW5Hm/fu/QzDOmaZXsSm6/eA4aPvlDlt7mhqUMQ2xTjj3lMKEq6SNuDVg7vEXspF2OuJR+Dgta2kfoRb7ne5l7AOA0mylvjP60RRV9NOEy5dJTVNCvBWpC3aol3qsIbPDRRMt4LJTmdAiWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eis59rklhUqOuys8BjG3yEC5C4tK7/b/8wMQdwkurOo=;
 b=XhyBj6GNsPTW49mKRUDXNmqPWsj9VWAczfiON28KQtFVEg/CoQ8ALtBZ9+xfIIskMQ8Y9dEXiOrqh36MTESkLATNlfu0JyGCodt0pzYlFKotJM1wbaemSyJbxM/X91UUEylkZU1se2FQ4Wllt59wYPtmNN2NeQHBnMyZNmYBivg=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by SJ0PR10MB4766.namprd10.prod.outlook.com (2603:10b6:a03:2ac::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Fri, 17 Dec
 2021 10:40:19 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::8966:789e:5a45:942]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::8966:789e:5a45:942%6]) with mapi id 15.20.4778.019; Fri, 17 Dec 2021
 10:40:19 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Mark Wielaard <mark@klomp.org>
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
References: <20210913155122.3722704-1-yhs@fb.com>
        <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com>
        <87sfy82zvd.fsf@oracle.com>
        <fc6e80ec-a823-bee4-7451-2b4d497a64af@fb.com>
Date:   Fri, 17 Dec 2021 11:40:10 +0100
Message-ID: <87ilvncy5x.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: AS8PR07CA0029.eurprd07.prod.outlook.com
 (2603:10a6:20b:451::30) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3400488a-9a4c-49f8-e641-08d9c1499ef4
X-MS-TrafficTypeDiagnostic: SJ0PR10MB4766:EE_
X-Microsoft-Antispam-PRVS: <SJ0PR10MB4766B2AC9D084253520011FF94789@SJ0PR10MB4766.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: L2l1lovPpIQRn+T1sBgDfc9uZrOlZv5Ezih4cnHyIkomKXjkjZDU6khocOkjg+RBR2CzmAlKcpT2pizsvWdPSK7Q3ZEvc/EDL4FcP52AXXUVP80+ELP6L0zf8/etoNfsM08GBSvkQAf0BOwDVX9b0umBJ7OLVTxW3r9xaeE/1Hb6O1Umhbc5XpXZG2fb6DXiJbfBMqDpGZDzRd0xENJ+P+iHKbfW4qKHibrDpsPFUbqWDOwQS/C2cQ+EiQjlouxfgkhF7COR7hv84FMWOzZSVesHXnv6FMAPKSQ/32OPhBD8y4lLIgzrsBJCqkSFeLKWXe6pCEeA3qpS/0uJyKbrV/Qyd0KVXoylopXW6V+oCZf9Vof+DcNEbBc2Bci5KoXDPKz4//CyjizWNfNMgDsikImJP0O7o8C6j3UCDvWJb5SdT/NodcGYP9mcmO1ZHZcQv9zTN+p1y/9JdYlrgdReTqUjYHVoWOK6oKILbn25clmovPXm27ejqu2sqg9VZeEmpNo9bsnjtck/wYXdIP4JcXQouwH9DezOKJEtVa0R2D8M1v+RqxlvMneZGhxiQFR3tUW3s299vxCnzx3K/NoPed64u3HOvZg6QcNeaON5Di2Fsvyr72M1udx2c9XQzwNURecfXF5Jm2809EHYZlEJF3KV788PdeFv+uMkIU2WuXJ19SkoVcE4x1XY3G1aIIIAzsPAEVVVfE7KWdgcMffOFA6YYDsjSddjs1MsBa2sKEi2MJ4C+jfP4R3QZ8UKSmrjXB/N5ENQobM5okYloJNGV6YrI9tqZb0KuM8z6cdFnxDar69WGTeWHir4LPSWxmfeViyOVXPqgEJqWkBtTNmxNjDUcd0CADbPBjzl2+5dIiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(86362001)(66946007)(2906002)(38100700002)(38350700002)(2616005)(66476007)(8936002)(6666004)(66556008)(8676002)(6486002)(6916009)(5660300002)(26005)(6512007)(186003)(53546011)(966005)(52116002)(508600001)(36756003)(83380400001)(6506007)(316002)(54906003)(4326008)(2004002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6c62tSjZXGj6g9GDG9X8JBvp8Cs7P+v9I5KSz+ZhWUJaMP1l2T3YLKyB45bK?=
 =?us-ascii?Q?cCUROaEu3TFwBdvFusbMLxzFpQ9mbuZvkMoDEJds6OLfcJ1GPz5lssy9rR7R?=
 =?us-ascii?Q?0y3wpFZIqLdVM1vMaE1hSm0ChUDV/k4HTTDj72alweJkphVlhZZa+9uHwM6k?=
 =?us-ascii?Q?qLRBwvMS0ttMY+da27+3zPcwHV7vNYE7DcQ3N7oVwmHGysJl95bYaq16HCu1?=
 =?us-ascii?Q?spXholWsjszZdjDQVsjc57BlDlnt5e9c+BBSaX6uUP/q0tG63kGjtjmHSREz?=
 =?us-ascii?Q?+aciPRSV5HCE02tn6hXzvm9TIDZ+L0trNGfSgr4qMyubU3WCtsnzziEWYFZZ?=
 =?us-ascii?Q?ijblsv6WOruuqCkfuUgLxwp6xNM1GnNBzbRdxktk9cMec9XMtXAivyMfzYdO?=
 =?us-ascii?Q?Hra9e3Ya46BuFoLbVceWWr/Z/SUJHh7XspnumDHGQ+CiAzXeeokaH+0+0ogl?=
 =?us-ascii?Q?9Rbjjgg0ZMr/PZAUc8oSETwoIrj1ozgM9e6hoAgC+aaLLgi44EoJ3sd0Ings?=
 =?us-ascii?Q?o5dfqxfGmxzh6eB5/TsuaihGYVi0xkGTccFh74vGg5mTMbSZgAI8QlD8IoXv?=
 =?us-ascii?Q?sDShjb9rOIyi8up8J9ojVu4okkI7gE0EipaF+WVqwRXlvrmTSw4JcE8spap8?=
 =?us-ascii?Q?dHMACwph31ZMkpFdbttUFKt3+HJAT+DW1EI2nxWctd0cRKsikKcSawa4lXHI?=
 =?us-ascii?Q?wlgxT9RMWNg7nazPK4nnKsOjqjv/d+kWHeluxTV1XDFma048RfZH+gO6IQJI?=
 =?us-ascii?Q?iuI9VPvZuuNsQ9DLVZef/dxlAOW7pDKy6AyYLBBMS9nCXHd4YK2+AO0cjOBk?=
 =?us-ascii?Q?wKruXIJ83NEjqs0JxhqaZo1Jy18ALwGmp+RWSHiq6uwvkZAyKFK5xoBoy9ju?=
 =?us-ascii?Q?Xpi0Z0r5biWKAH/DlQ9wbewEeb2ov9mAoszsAhve8q2OE9JGdgxN+XhYQE3o?=
 =?us-ascii?Q?JajoiKpg5oJ/mEB5TMe9S5dZ825O3iJCAjHZTNUqdC0Doy98a/kUk5WwfKmW?=
 =?us-ascii?Q?TggVA1cPtNdQgyQxegUsLRc9hr6RHopWsJksB2ci5qp9mEW/B0g4FApP3o2Y?=
 =?us-ascii?Q?AR7AMqPv5ABnxU5FL8WdnRvPPF0Cp/Z4IT8PKG2a9SlE6SAx1Qwxpx0SYlfe?=
 =?us-ascii?Q?aAL0eqZ+JG0pdo18BXyj8n3tHgyNQipA5REwBbHqUlofU+rdFBk2Gia4ulN8?=
 =?us-ascii?Q?C2NUuh9ZpTrFUzNgpTJFlrg0swqgIFaoe4D/VKBPZmQewOt8jMtxnN5+Insu?=
 =?us-ascii?Q?izgNF8xV7F2sQGCC/m6ZzEbFhftr69hZfOl0XTuT4rDlJ6Ke/fjv9+3aYGSd?=
 =?us-ascii?Q?rsjIRI5WiAdBTl5/bc/TugD8NoywcvCavqgsNxqV35tdirM2I8evLQj55bSh?=
 =?us-ascii?Q?SVtm/ewNOxsj13meg6Uls/yBgIU+eTDV2pK9FXCi9+HNjFQGwaZY/uQ2te0U?=
 =?us-ascii?Q?D5yyENd6S3pobpg9Qw5G08ramtKEClODlCsvMeGqF6NQ6peV7YbtsqwAh/OS?=
 =?us-ascii?Q?i0Uhl3H0Vb9CURVFOFub/Wv8OvwmTu1rK6Yq9wo27UCamii+vWSiEU8mT11p?=
 =?us-ascii?Q?3JUM3jl2Z3mzz269Iaf/Fq+laUyFgMjavxphhATboamKiEaUPVzzJZf/gy9S?=
 =?us-ascii?Q?EvFLE9Gwix+7zd+AiOuVNYSU0L6sEYMCM9N9CwMS1kqSlI01uKyX5gnMXfDl?=
 =?us-ascii?Q?wJuJ2g=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3400488a-9a4c-49f8-e641-08d9c1499ef4
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Dec 2021 10:40:19.6071
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8H+nvYt0o9x7E6gI/4jbOzY6NN87SpnoSqtla9sU6D4nC0TGFf8n31BGnCRqJDRTanzfLlrTwyPHrE4iVJgnZKmpqU0x7Sie32uK/YaTRlE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4766
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=869 bulkscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112170060
X-Proofpoint-ORIG-GUID: evy3yLFqVMCJvHXeNFiZ_j2AZKD4MQVl
X-Proofpoint-GUID: evy3yLFqVMCJvHXeNFiZ_j2AZKD4MQVl
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


Hi Yonghong.

> On 9/13/21 9:40 AM, Jose E. Marchesi wrote:
>> 
>>> cc Jose E. Marchesi
>>>
>>> Hi, Jose, just let you know that the BTF format for BTF_KIND_TAG is
>>> changed since v1 as the new format can simplify kernel/libbpf
>>> implementation. Thanks!
>> Noted.  Thanks for the update.
>
> Hi, Jose,
>
> This is just another update on btf_tag development.
> Now, btf_tag is divided into btf_decl_tag and btf_type_tag
> for tagging declarations and types as clang compiler prefers
> not to mix them with each other. All compiler works in llvm
> has done and you can check upstream llvm-project "main" branch
> for implementation.
>
> The patch set below (under review)
>    https://lore.kernel.org/bpf/20211209173537.1525283-1-yhs@fb.com/
> actually tried to use btf_type_tag for linux kernel __user
> annotation so bpf verifier can use it.

Noted, thanks for the heads up :)
We have not yet started to implement this.

> Another question from Omar (open source drgn maintainer)
>
> https://developers.facebook.com/blog/post/2021/12/09/drgn-how-linux-kernel-team-meta-debugs-kernel-scale/
> mentioned that btf_tag information will also help drgn since it
> can then especially distinguish between __percpu pointer from
> other pointers. Currently drgn is using dwarf, clang compiled
> kernel puts btf_tag information in dwarf. Based on our earlier
> discussion, gcc intends to generate btf tags for BTF only. Maybe
> we could discuss to also generate for dwarf? Do we need a flag?

It seems to me that there are three different orthogonal issues/topics
here, even if somehow related.  Each would require a separated
discussion, probably on different contexts:

[Please let me know if I am wrong on any detail in the summary below.
 In part I am writing it down as a recap to help myself :)]

1) The need for BTF to convey free-text tags on certain elements, such
   as members of struct types.

   IMO there is not much to discuss about this one.  The specification
   is straightforward as is the implementation.  We will be adding it to
   GCC soon.

   Note that:
   - This is obviously BTF specific.
   - This is not strictly BPF specific, as GCC can generate BTF for any
     supported target and not just BPF.  I think you have patches for
     LLVM to the same effect.

2) The need for DWARF to convey free-text tags on certain elements, such
   as members of struct types.

   The motivation for this was originally the way the Linux kernel
   generates its BTF information, using pahole, using DWARF as a source.
   As we discussed in our last exchange on this topic, this is
   accidental, i.e. if the kernel switched to generate BTF directly from
   the compiler and the linker could merge/deduplicate BTF, there would
   be no need for using DWARF to act as the "unwilling conveyer" of this
   information.  There are additional benefits of this second approach.
   Thats why we didn't plan to add these extended DWARF DIEs to GCC.

   However, it now seems that a DWARF consumer, the drgn project, would
   also benefit from having such a support in DWARF to distinguish
   between different kind of pointers.

   So it seems to me that now we have two use-cases for adding support
   for these free-text tags to DWARF, as a proper extension to the
   format, strictly unrelated to BTF, BPF or even the kernel, since:
   - This is not kernel specific.
   - This is not directly related to BTF.
   - This is not directly related to BPF.

   Therefore I would avoid any reference to BTF in the proposal to keep
   it general, like in the name of DIE types and so on.  This would 

   Whom to involve to discuss this?  Well, I would say that at a minimum
   we need to involve GCC people, LLVM people and DWARF people, and the
   consensum of all the three parties.  Once agreed, we can all
   implement the same DIEs counting on the next version of the DWARF
   spec will catch with them.  I would really avoid rushed solutions
   based on compiler-specific extensions.

   Where to discuss this?  I don't know.  In some DWARF forum?  Or
   cross-posting gcc-patches and whatever LLVM list uses for
   development?  I am CCing Mark Wielaard who is a DWARF wizard... any
   suggestion?

3) Addition of C-family language-level constructions to specify
   free-text tags on certain language elements, such as struct fields.

   These are the attributes, or built-ins or whatever syntax.

   Note that, strictly speaking:
   - This is orthogonal to both DWARF and BTF, and any other supported
     debugging format, which may or may not be expressive enough to
     convey the free-form text tag.
   - This is not specific to BPF.

   Therefore I would avoid any reference to BTF or BPF in the attribute
   names.  Something like `__attribute__((btf_tag("arbitrary_str")))'
   makes very little sense to me; the attribute name ought to be more
   generic.

   Whom to involve to discuss this?  Definitely, the front-end chaps of
   both GCC and LLVM will have something to say about this, particularly
   the ones in charge of the C-like language front-ends like C and C++.
   A consensum among them would be ideal and would avoid
   compiler-specific hacks.

   Where to discuss this? Again, it seems that we need some neutral
   ground to discuss inter-operability issues between the different free
   software compilers...

In any case we are more than willing to help and participate in the
discussions :)

> Please let me know if you have any questions.  Happy to help in
> whatever way to get gcc also implementing btf tag support.
>
> Thanks!
>
> Yonghong
>
>> 
>>>
>>> On 9/13/21 8:51 AM, Yonghong Song wrote:
>>>> LLVM14 added support for a new C attribute ([1])
>>>>     __attribute__((btf_tag("arbitrary_str")))
>>>> This attribute will be emitted to dwarf ([2]) and pahole
>>>> will convert it to BTF. Or for bpf target, this
>>>> attribute will be emitted to BTF directly ([3], [4]).
>>>> The attribute is intended to provide additional
>>>> information for
>>>>     - struct/union type or struct/union member
>>>>     - static/global variables
>>>>     - static/global function or function parameter.
>>>> This new attribute can be used to add attributes
>>>> to kernel codes, e.g., pre- or post- conditions,
>>>> allow/deny info, or any other info in which only
>>>> the kernel is interested. Such attributes will
>>>> be processed by clang frontend and emitted to
>>>> dwarf, converting to BTF by pahole. Ultimiately
>>>> the verifier can use these information for
>>>> verification purpose.
>>>> The new attribute can also be used for bpf
>>>> programs, e.g., tagging with __user attributes
>>>> for function parameters, specifying global
>>>> function preconditions, etc. Such information
>>>> may help verifier to detect user program
>>>> bugs.
>>>> After this series, pahole dwarf->btf converter
>>>> will be enhanced to support new llvm tag
>>>> for btf_tag attribute. With pahole support,
>>>> we will then try to add a few real use case,
>>>> e.g., __user/__rcu tagging, allow/deny list,
>>>> some kernel function precondition, etc,
>>>> in the kernel.
>>>> In the rest of the series, Patches 1-2 had
>>>> kernel support. Patches 3-4 added
>>>> libbpf support. Patch 5 added bpftool
>>>> support. Patches 6-10 added various selftests.
>>>> Patch 11 added documentation for the new kind.
>>>>     [1] https://reviews.llvm.org/D106614
>>>>     [2] https://reviews.llvm.org/D106621
>>>>     [3] https://reviews.llvm.org/D106622
>>>>     [4] https://reviews.llvm.org/D109560
>>>> Changelog:
>>>>     v1 -> v2:
>>>>       - BTF ELF format changed in llvm ([4] above),
>>>>         so cross-board change to use the new format.
>>>>       - Clarified in commit message that BTF_KIND_TAG
>>>>         is not emitted by bpftool btf dump format c.
>>>>       - Fix various comments from Andrii.
>>>> Yonghong Song (11):
>>>>     btf: change BTF_KIND_* macros to enums
>>>>     bpf: support for new btf kind BTF_KIND_TAG
>>>>     libbpf: rename btf_{hash,equal}_int to btf_{hash,equal}_int_tag
>>>>     libbpf: add support for BTF_KIND_TAG
>>>>     bpftool: add support for BTF_KIND_TAG
>>>>     selftests/bpf: test libbpf API function btf__add_tag()
>>>>     selftests/bpf: change NAME_NTH/IS_NAME_NTH for BTF_KIND_TAG format
>>>>     selftests/bpf: add BTF_KIND_TAG unit tests
>>>>     selftests/bpf: test BTF_KIND_TAG for deduplication
>>>>     selftests/bpf: add a test with a bpf program with btf_tag attributes
>>>>     docs/bpf: add documentation for BTF_KIND_TAG
>>>>    Documentation/bpf/btf.rst                     |  27 +-
>>>>    include/uapi/linux/btf.h                      |  52 +--
>>>>    kernel/bpf/btf.c                              | 120 +++++++
>>>>    tools/bpf/bpftool/btf.c                       |  12 +
>>>>    tools/include/uapi/linux/btf.h                |  52 +--
>>>>    tools/lib/bpf/btf.c                           |  85 ++++-
>>>>    tools/lib/bpf/btf.h                           |  15 +
>>>>    tools/lib/bpf/btf_dump.c                      |   3 +
>>>>    tools/lib/bpf/libbpf.c                        |  31 +-
>>>>    tools/lib/bpf/libbpf.map                      |   5 +
>>>>    tools/lib/bpf/libbpf_internal.h               |   2 +
>>>>    tools/testing/selftests/bpf/btf_helpers.c     |   7 +-
>>>>    tools/testing/selftests/bpf/prog_tests/btf.c  | 318 ++++++++++++++++--
>>>>    .../selftests/bpf/prog_tests/btf_tag.c        |  14 +
>>>>    .../selftests/bpf/prog_tests/btf_write.c      |  21 ++
>>>>    tools/testing/selftests/bpf/progs/tag.c       |  39 +++
>>>>    tools/testing/selftests/bpf/test_btf.h        |   3 +
>>>>    17 files changed, 736 insertions(+), 70 deletions(-)
>>>>    create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_tag.c
>>>>    create mode 100644 tools/testing/selftests/bpf/progs/tag.c
>>>>

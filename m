Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7FCE49E642
	for <lists+bpf@lfdr.de>; Thu, 27 Jan 2022 16:39:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237732AbiA0PjI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jan 2022 10:39:08 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:30156 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231590AbiA0PjH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Jan 2022 10:39:07 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20RFCkDG011254;
        Thu, 27 Jan 2022 15:38:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : references : date : in-reply-to : message-id : content-type :
 mime-version; s=corp-2021-07-09;
 bh=4wDzU9Rs3jI7vB2namlE2PP+nT6xIk/JPVc5yXq/Vsw=;
 b=Hd3CReDjq//3nwAq47Y/dNSJtMZpMHZgHIduhHTlCZcbrcAFVbnG/fw+rvehQp7wEZww
 qjTNnDfdzUc5xg1rl99j5egI5wgR7VCko9JpTCfnypY/ozUy6ROcE7IN17DnwsM0Ao8W
 /+ChXM+mkejBXfIVynS7OfkyQDKFkLNfOSPhXBRmh3FdhEoVoTh84rjA4GqjrOlL9Y2z
 kIei5ys0BZK9JBa3m5luxHYuhoDlRQ95vmmNJNkMJLvU1DRwZpaVtXe+6a2M38UJZHKC
 DImMfFXYFvAxDnsl/Y4mkauP3NhFuIlzIbJmMBeKu9JtSUBDXZrH64oXVH7AeNLPbXZK zg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duwub02u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 15:38:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20RFGYCK122945;
        Thu, 27 Jan 2022 15:38:34 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2048.outbound.protection.outlook.com [104.47.57.48])
        by userp3020.oracle.com with ESMTP id 3drbctpnxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jan 2022 15:38:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NyUU+BHtJRLsn0ovNbm2w74zvS672B6O5/8RjkTb9EB9QtUQF3D0RtD4XoppIHF2WeRESxssR8Rur54T1HTPoJx4tDuCUSdvwavMhlh6ncAIrJvRBL5mRTSYPSaPLxotTj4wlhwiWjKbNvWoAOmFxdLhrjsh9i0T/8u6BSrp7n6A+yTUY/HPblXwa+lGo4XGnetLHryTWZriIQPw12AqVdT4qN9sBT9clxfynqYCnkgVCKjlw9t1hBpy3FcUFXZSwJBe0vT6BgdDByd3moh7Q+YTYvvF3/zadPmwKF9h3/poTiXj5LBqZxwuVPsI6Em2XmvDyJH3wpBNZXHB3nnOaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4wDzU9Rs3jI7vB2namlE2PP+nT6xIk/JPVc5yXq/Vsw=;
 b=ed9xsoEuvHNgkkJ0F9H6eISvxzWPX9FCxemozeAkgmAkOa89gePFCfBiGDVrkEI8HgO+sRO+dCiMjqmYwb5tG1wHiaGEBTYR5dbveLVsOVau9hWGNTKj2Re+CIcc9YebQrpSboN22Z2KQspjqN3JfcoA/JiOjRHRB58JHwdq6QpTPKBj4uCy5yV0vzJBGGctFqy1YAwwZvanIC3rLryqRgmM3L2LqGyrMUB0CMTI2x1cAq6qQBNeYr6hONg39gxPlhJg4gYfXsvYTIvC83K00xAdw8D7mKPPht4EzZLpKUIGvf/JhSTZQ5/yKUxDE4MWoYIQIkc4sXLnpCPLrpzAXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4wDzU9Rs3jI7vB2namlE2PP+nT6xIk/JPVc5yXq/Vsw=;
 b=sd9IQEmF01lEVrhH6w/ttKc5SpRVLz8piZkXfb4SJvyJJeSEvoX0SmnoUNapiG9yu5suhF2fo5CPdFpdD8vj48l9QRE7+N/MceXcPTMA3Zzx38hvYAZPwveW6IgRpZJWI7zCerpbqA3baGEHk1HxIyP1yw6CuHOD6eQDN7w1vfc=
Received: from BYAPR10MB2888.namprd10.prod.outlook.com (2603:10b6:a03:88::32)
 by BN6PR10MB1378.namprd10.prod.outlook.com (2603:10b6:404:44::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Thu, 27 Jan
 2022 15:38:31 +0000
Received: from BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7946:cba4:bc10:70a6]) by BYAPR10MB2888.namprd10.prod.outlook.com
 ([fe80::7946:cba4:bc10:70a6%4]) with mapi id 15.20.4930.018; Thu, 27 Jan 2022
 15:38:31 +0000
From:   "Jose E. Marchesi" <jose.marchesi@oracle.com>
To:     Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>,
        Mark Wielaard <mark@klomp.org>
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
References: <20210913155122.3722704-1-yhs@fb.com>
        <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com>
        <87sfy82zvd.fsf@oracle.com>
        <fc6e80ec-a823-bee4-7451-2b4d497a64af@fb.com>
        <87ilvncy5x.fsf@oracle.com>
        <20211218014412.rlbpsvtcqsemtiyk@ast-mbp.dhcp.thefacebook.com>
        <7122dbee-8091-8cd1-d3e4-d5625d5d6529@fb.com>
        <87czlr4ndp.fsf@oracle.com>
        <61e04a73-bc4d-b250-31fe-93df4100c923@fb.com>
Date:   Thu, 27 Jan 2022 16:38:23 +0100
In-Reply-To: <61e04a73-bc4d-b250-31fe-93df4100c923@fb.com> (Yonghong Song's
        message of "Mon, 24 Jan 2022 19:58:25 -0800")
Message-ID: <87pmodgpe8.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0162.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:9::30) To BYAPR10MB2888.namprd10.prod.outlook.com
 (2603:10b6:a03:88::32)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7b53a20b-0ae9-4b7d-1c36-08d9e1ab126e
X-MS-TrafficTypeDiagnostic: BN6PR10MB1378:EE_
X-Microsoft-Antispam-PRVS: <BN6PR10MB137812FF49336AC4AB2C712A94219@BN6PR10MB1378.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QOP+JDnA/05IXA5/w1qT5ium+p8o4eHq3Ti+LG5CSbiNVPZFy7gYrwZpgq1/uMeVz1n25Cula6u6z80sJ1JQQyaZ+LMkth9w5TUFswJ8mZQ0mKxjbROWemTFgsBc1ahMGYn0vDDTgfSexB/edf3vwRSmfOM9iLmIUtS/MjQmmDOOSvfb1TUX97dGsDfutpeQ98D7a6mZzwMxfWe++uhl58buVYggcMazXOH/67e/vpp8Ix781c8ClejqOtlNZr14wmT5P24IbP/4k2fPOJLJgYuItLUjCgUABFMDkNQpKWPAMklSDwlDlaO/3R1AgZeqCv3FuZ3bleP+sfPSCzZY5/A2TBeKTP1l6a6P+6rx3JTWvTKhsKSgwZ5ql6PyvYQqlTh8B6DJDBfHT9YREBmbdOO9d1R9bYIUiTH3+Ia2ncAXXmTmFKJvdHg/5V96o55++08sFCX6g8SDC4jlnva7/vt42zxJmlApgXRkFf7s4KPt44BPE3FqjbhMdo0HxLzlqMohlJTzmtc+Xc0fPnfhwFvBqmLwb9jCUk+i6TrmayDj5avY4wW+vO197EG3Zb4VhvfEzi/e1lF97jTVZJ2caJOXOB1jV0WL47IbtaBKEQNNGWcrqUSR6w6rfSbmlCUscf/WqG6KABfiFoOQ5vAq6nBxpOlCNqoWj3w/MG/UH/kiIvEn9UsQjYbPKSOXX6UHYJwoT32d+EnSp2m/3C/tRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB2888.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(38350700002)(2616005)(4326008)(36756003)(5660300002)(2906002)(83380400001)(66556008)(66946007)(8676002)(66476007)(8936002)(186003)(52116002)(53546011)(86362001)(6506007)(26005)(6916009)(54906003)(6666004)(316002)(6486002)(6512007)(508600001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r3ezCa0eh49JV56KHWpJtd4Kx8B/3uEs7DMOc6W2FTRvGAbcmCAN3+nP0fN4?=
 =?us-ascii?Q?fAtdf2nBO+VwTRdPTcaVTXGzb7sT9d3AieThM2hN7NZrx1S+lJGGnjExcXgq?=
 =?us-ascii?Q?0tabi3J9ipiENTKMxgd+dFL1GO/HqpKOL73vQV0Nm+soeeGbyfs7GyRmdKrh?=
 =?us-ascii?Q?xENSKoR4uZCVT+DfCppCKczdBJnc0ZkQzNz0OIh+MjeWq6l1WT9lSwtXfGK8?=
 =?us-ascii?Q?AqBRjNETdu7U5ncc/oEsrP2Y9VFNihbzoneqRpndmaENWHVY+djnAR4eNmIZ?=
 =?us-ascii?Q?/dFUq2eRoHWWhZqODRz22b1GYypB23WFHOd9yRKBkvUdRY9WcowvaUwiyWrY?=
 =?us-ascii?Q?O4BrmzNNeLnmBzuMLqJ35HiSWuoz/2aaKWkDzvQ9SBduJzFa4ayzgH9NQ12b?=
 =?us-ascii?Q?U3UsNT23rdCteeSFdzKJZjpX58e9WVLRrEIu5VnnFM47v+zBDvnlw/7CwPfY?=
 =?us-ascii?Q?JGcpX1XZBPxdDtQPztW8ElCKSZm0pDT7mioCOeZZG8yWYZ+ONsBoT/A5X0a2?=
 =?us-ascii?Q?aIqB1jSvRI8DP7KdN1lo4ewIjddLYYWaImZCBKFZ0ir1P2wAm6X9+AFlrugf?=
 =?us-ascii?Q?rbf2weQTV2PytBHO+opqULvfo58pYHHvslLp1FeYXs/v6e5RU7P6wQUPcoXw?=
 =?us-ascii?Q?4npqK02Ct44l9aPTc/zJjboAZIF2gOT9Iymay+9GayboB0Z1uFFbwYxwODGK?=
 =?us-ascii?Q?rxSqZFPHOIhLdSq3RsO+kFgutNg4S6Pqt0g/eKPXwmDTfqh6D6TIG2f2NSEi?=
 =?us-ascii?Q?TJU5kq2xmj66XXSjb7KKrM6UYptVb7NXMGnL3paLkYDroYQlOpdJ6HUAjgGD?=
 =?us-ascii?Q?Ey3X7BTIgd3sQsiWoFcszFQblK9w+bC+IgFF8HhVC0JlKJRnvA3+gNHA7AYE?=
 =?us-ascii?Q?vSstccljHhWUDfAzMeKPHzkgpyuewE1pX5eAqpN60vw84RL8/LfT7ODdsLrT?=
 =?us-ascii?Q?VdByYG0UgPSBkV66AsFkMDwKP6PtCEuCfhrGM0qvpHdMxBN3MdeNAo1DWxme?=
 =?us-ascii?Q?z5c6De6ZjruYEigwcYVReGfcqNTr2bPmkG3ln6WYEfp87a5dmC6ll1Q9hmZu?=
 =?us-ascii?Q?D6xGvblBdWm3kVHShAuMM2qWLgWZyi4AsAHqjXllf7+fxGTu6iXfRNJpYilx?=
 =?us-ascii?Q?/2PH46z2mQswuAR7qeBkV+MmWH3RWraFarqk53fpr8EatmYf80WMxG2diFyX?=
 =?us-ascii?Q?hnhqCnYWb7w8YynvnZGyJB73HI12fh8Q85FkeT2FrAdc/2WcVDqgHB9HxRF2?=
 =?us-ascii?Q?10pOFG/hL9dhuAm0iySoAonwDP9LxQfDcCYrrdUhOvdVBj2aPvfl+owPXeyt?=
 =?us-ascii?Q?d5QH9M/Q7p2X8MOMv99dPey/oY9CZ2LRxhkx0r3kGOUQmjllSj8RQn7kuORG?=
 =?us-ascii?Q?e1O0IPivHsJcPNthXyfIVnwVQfYU8XabaCuRLZiLq27N4eLveVyTPuKp7/lC?=
 =?us-ascii?Q?v3xU5lugQbsHoDFxDgYDpuFrMWjtRJ/L2WLg1zcl0rMbsGuATMW8BFg3oh3o?=
 =?us-ascii?Q?BrdNv73TEqJMm4qP8tOg31SANDJR/dwVOB1xgVjJaGk5VkMN1NdK0rQBdELR?=
 =?us-ascii?Q?7xt40y5xJp6Zl7IBiZrzm1/JBx7izzaepUAps4XeR0vYkcumxuXFLoNKOps5?=
 =?us-ascii?Q?OPoz0ZyMwMW7Ef+5ip1Tjjav/xxzeGVMThIAM43w5f1pLqJ/4uQkZ+Hl9MtJ?=
 =?us-ascii?Q?bgkeUQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b53a20b-0ae9-4b7d-1c36-08d9e1ab126e
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB2888.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2022 15:38:31.7311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EnEHSENCuNvcYR4k3m/A2AfPZcp0s1uWC8gLlDH8KXCLpJkhuFaUiuFhGfGKZNjXMjlEH3Mktgz+Cu23pDoAi5yC1ZfoKwjeo4Fr6zLUP+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR10MB1378
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10239 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=931
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201270094
X-Proofpoint-GUID: Z8bbn37A2tGqAHdOQ1jfdYCNP0GYH0rf
X-Proofpoint-ORIG-GUID: Z8bbn37A2tGqAHdOQ1jfdYCNP0GYH0rf
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org


> On 12/20/21 1:49 AM, Jose E. Marchesi wrote:
>> 
>>> On 12/17/21 5:44 PM, Alexei Starovoitov wrote:
>>>> On Fri, Dec 17, 2021 at 11:40:10AM +0100, Jose E. Marchesi wrote:
>>>>>
>>>>> 2) The need for DWARF to convey free-text tags on certain elements, such
>>>>>      as members of struct types.
>>>>>
>>>>>      The motivation for this was originally the way the Linux kernel
>>>>>      generates its BTF information, using pahole, using DWARF as a source.
>>>>>      As we discussed in our last exchange on this topic, this is
>>>>>      accidental, i.e. if the kernel switched to generate BTF directly from
>>>>>      the compiler and the linker could merge/deduplicate BTF, there would
>>>>>      be no need for using DWARF to act as the "unwilling conveyer" of this
>>>>>      information.  There are additional benefits of this second approach.
>>>>>      Thats why we didn't plan to add these extended DWARF DIEs to GCC.
>>>>>
>>>>>      However, it now seems that a DWARF consumer, the drgn project, would
>>>>>      also benefit from having such a support in DWARF to distinguish
>>>>>      between different kind of pointers.
>>>> drgn can use .percpu section in vmlinux for global percpu vars.
>>>> For pointers the annotation is indeed necessary.
>>>>
>>>>>      So it seems to me that now we have two use-cases for adding support
>>>>>      for these free-text tags to DWARF, as a proper extension to the
>>>>>      format, strictly unrelated to BTF, BPF or even the kernel, since:
>>>>>      - This is not kernel specific.
>>>>>      - This is not directly related to BTF.
>>>>>      - This is not directly related to BPF.
>>>> __percpu annotation is kernel specific.
>>>> __user and __rcu are kernel specific too.
>>>> Only BPF and BTF can meaningfully consume all three.
>>>> drgn can consume __percpu.
>>>> In that sense if GCC follows LLVM and emits compiler specific DWARF
>>>> tag
>>>> pahole can convert it to the same BTF regardless whether kernel
>>>> was compiled with clang or gcc.
>>>> drgn can consume dwarf generated by clang or gcc as well even when BTF
>>>> is not there. That is the fastest way forward.
>>>> In that sense it would be nice to have common DWARF tag for pointer
>>>> annotations, but it's not mandatory. The time is the most valuable asset.
>>>> Implementing GCC specific DWARF tag doesn't require committee voting
>>>> and the mailing list bikeshedding.
>>>>
>>>>> 3) Addition of C-family language-level constructions to specify
>>>>>      free-text tags on certain language elements, such as struct fields.
>>>>>
>>>>>      These are the attributes, or built-ins or whatever syntax.
>>>>>
>>>>>      Note that, strictly speaking:
>>>>>      - This is orthogonal to both DWARF and BTF, and any other supported
>>>>>        debugging format, which may or may not be expressive enough to
>>>>>        convey the free-form text tag.
>>>>>      - This is not specific to BPF.
>>>>>
>>>>>      Therefore I would avoid any reference to BTF or BPF in the attribute
>>>>>      names.  Something like `__attribute__((btf_tag("arbitrary_str")))'
>>>>>      makes very little sense to me; the attribute name ought to be more
>>>>>      generic.
>>>> Let's agree to disagree.
>>>> When BPF ISA was designed we didn't go to Intel, Arm, Mips, etc in order to
>>>> come up with the best ISA that would JIT to those architectures the best
>>>> possible way. Same thing with btf_tag. Today it is specific to BTF and BPF
>>>> only. Hence it's called this way. Whenever actual users will appear that need
>>>> free-text tags on a struct field then and only then will be the time to discuss
>>>> generic tag name. Just because "free-text tag on a struct field" sounds generic
>>>> it doesn't mean that it has any use case beyond what we're using it for in BPF
>>>> land. It goes back to the point of coding now instead of talking about coding.
>>>> If gcc wants to call it __attribute__((my_precious_gcc_tag("arbitrary_str")))
>>>> go ahead and code it this way. The include/linux/compiler.h can accommodate it.
>>>
>>> Just want to add a little bit context for this. In the beginning when
>>> we proposed to add the attribute, we named as a generic name like
>>> 'tag' (or something like that). But eventually upstream suggested
>>> 'btf_tag' since the use case we proposed is for bpf. At that point, we
>>> don't know drgn use cases yet. Even with that, the use cases are still
>>> just for linux kernel.
>>>
>>> At that time, some *similar* use cases did came up, e.g., for
>>> swift<->C++ conversion encoding ("tag name", "attribute info") for
>>> attributes in the source code, will help a lot. But they will use a
>>> different "tag name" than btf_tag to differentiate.
>> Thanks for the info.
>> I find it very interesting that the LLVM people prefers to have
>> several
>> "use case specific" tag names instead of something more generic, which
>> is the exact opposite of what I would have done :) They may have
>> appealing reasons for doing so.  Do you have a pointer to the dicussion
>> you had upstream at hand?
>> Anyway, I will taste the waters with the other GCC hackers about
>> both
>> DIEs and attribute and see what we can come out with.  Thanks again for
>> reaching out Yonghong.
>
> Hi, Jose,
>
> Any progress on gcc btf_tag support discussion? If possible, could
> you add me to the discussion mailing list so I may help to move
> the project forward? Thanks a lot!

We are in the process of implementing the support of the BTF extensions
(which is done) and the C language attributes (which is WIP.)

I haven't started the discussion about DWARF yet.  Will do shortly.  You
will be in CC :)

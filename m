Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B56FC40986C
	for <lists+bpf@lfdr.de>; Mon, 13 Sep 2021 18:09:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345358AbhIMQKe (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 13 Sep 2021 12:10:34 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:55382 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344663AbhIMQKd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 13 Sep 2021 12:10:33 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.0.43) with SMTP id 18DF4Oc8015085;
        Mon, 13 Sep 2021 09:09:03 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : from : to : cc
 : references : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=6fKWK1phZa8yEnzIbrRWGAJmggNZWZhDDAnHbvKJnOA=;
 b=WhWnushgx0a51BsboHLwFMU/XX4UE2VFqBufK+ODqem0NuWXtK1vGWy2OFVvmonWqXZL
 NNeHH/ENM9CEKjP8EoP+YT4Y5S1gmx60Wy26YFlRUj1rQWwKQqerYditTqwU73+XIHS1
 g8WGW5q3HHINDE6XEofjALOKubDqbxNgRBE= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3b1xdq3nds-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 13 Sep 2021 09:09:03 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Mon, 13 Sep 2021 09:09:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NwQsKTQrc/U6uF1frjAl2TLCcRc6gSVO+1clB0KtF4q8aoXC/qu52M7VnwihSyP4fKbsBw3d+gBpgVg9nlJm9kv79DXdL8vZbJ0z+tT9ixgMGAtjuWMrUmSiwIGkTnZsfsDk3rO+/cwSR4ifU6+m/hkceH7XtVi2tt+IcXyrxMrjdT28RyHFuurotIuaqSR5mtdr6Z/nz5++yiC/GM0T12vmphIQLUK2pHbumEbltz2VONAfpr9Nc4L29+hTDSYvgTcppUOXjaLZvc1dxZm6VwJRyUexoEuoGijDJT6rc1S3l/iTlNv70EXlwu2phlodK+k4yziQxx6DApLF95zU5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=6fKWK1phZa8yEnzIbrRWGAJmggNZWZhDDAnHbvKJnOA=;
 b=bJhvyRTI50Rvo5V3tC2Aiep1kipFQ1HyzEPx2O+oXWNlmKdQ607grVvFdNYWniHB4bsXOA2Sv2uhA6v7duEgtflbO4kmbCVJcHdhSJkRG447ISsc3NKFABL6J6LC3A8TiYYKNETUg4vxg+EO9bJRGkFc53xLeOjvWhLe8w+mSUc7Y8GrpeT4yLcbxfPBoyyleWvgmgxtMqCpJYBZcKuiq/+654PPyN8wYhth/Qnf4PEz6ZjAyJXG0GRsR1+fEckSXBkI//k6pJc/A9zbXOdvv2OxXLc74AwugmbgNKBAgfpHLd8fOAitdm0k0G+I3k5f9PUOG1+f+oVOWpIjWr1XSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4158.namprd15.prod.outlook.com (2603:10b6:806:105::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14; Mon, 13 Sep
 2021 16:09:00 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4500.019; Mon, 13 Sep 2021
 16:09:00 +0000
Subject: Re: [PATCH bpf-next v2 00/11] bpf: add support for new btf kind
 BTF_KIND_TAG
From:   Yonghong Song <yhs@fb.com>
To:     <bpf@vger.kernel.org>,
        "Jose E. Marchesi" <jose.marchesi@oracle.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, <kernel-team@fb.com>
References: <20210913155122.3722704-1-yhs@fb.com>
Message-ID: <b59428f2-28cf-f1fd-a02c-730c3a5e453f@fb.com>
Date:   Mon, 13 Sep 2021 09:08:57 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <20210913155122.3722704-1-yhs@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-ClientProxiedBy: BYAPR06CA0047.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::24) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
Received: from [IPv6:2620:10d:c085:21e8::132d] (2620:10d:c090:400::5:a3) by BYAPR06CA0047.namprd06.prod.outlook.com (2603:10b6:a03:14b::24) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.14 via Frontend Transport; Mon, 13 Sep 2021 16:08:59 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9f62104f-5bb9-4220-8041-08d976d0cc1e
X-MS-TrafficTypeDiagnostic: SN7PR15MB4158:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB41589213318691DE6EAB7A77D3D99@SN7PR15MB4158.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4303;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oh08xMm4nog9rSpIsRZKAT4nNfHGHg/NmlRqGrSGkeWhTv9x5+yYUKunBVW8ypeR8SFFup2/RLxqWm7iyq1Dj5+WVVJf478Mu3KSYjNbRbav4EO6iNnSVCmkMMm5VerSWASXhmFpcNszm60Pg7R4j9+4UzlDSZzKuyRnvQN7GT03cYuJDE1u1ULTWcx3JKGmqoF4vZffQF9GeAnu8XdY2bkR4Adka01ok966oloz3QlBIdqA2iRYe4dAtAPzuXoT7LFxafwbT33macrKVzvMii7/1F52zSF7kpaE4eHf46EmwpCaDr8fn2fEymIRso3RaUvHw4jOpBxxJk3FpWGlQiLiwFFBWE/IY13To6SKsGQa0N/yjrFpZnP1ISNkcJ9UPRO/JWwQ3zbW53wWrAXOD479hxUmqQ1X31oWT5Vm+QXDAtyQ2X2x5l5QQDNCQe8nw0MPKfbXBAsKbgdEnmoV2jENKa3yO40+DNiOG+BB3BpeNhaZhRNfNXijXjQguD9A6ka4b6x/CBkrShRe+yOQ9/ky5kBBCYN4NUo7ybgR3xw2JI5y+dVIePhO4afSvnwNg10g0I3oon/KFMarmOmUXUHRNMNrjlvq4l1KGe1C67yQHrm9tBFHo6a93FdtdZOZEyCc08K2HAhosp4Hi9OyQkFiw/DDRgblcZQuQZcRPuTetwQVrUrsx0tGUkTF9FONyNZ8DEK/tAo9WL43j5IO7//0hqBQZyl+Pgfy3kll4JOfUEY1L8riTPbWTVu8xQEMZkSstqoCsC8LMogW2dqkklcLM4m1QbmF73i+IS+NDQC+EXnwqTQbJQO7r4iQzcNEhKa+KUNYm76P3tSRsLx306utnAx17pgFhnPFoKIwbQo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(39860400002)(396003)(136003)(376002)(478600001)(8936002)(2906002)(31686004)(54906003)(66556008)(66476007)(86362001)(4326008)(6916009)(966005)(38100700002)(316002)(31696002)(66946007)(186003)(5660300002)(52116002)(6486002)(53546011)(83380400001)(2616005)(8676002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWt1TGNlN01xVkZCVXMyN2cvbXNHb0RTbjNHSDVic3puSWFpUnNLdHcvOElF?=
 =?utf-8?B?UnVqQ0ZoSFJmK3VlbVlNUVlWYktvai91TlBJMGZBQWZxWjhmcUdzNlhOVnlG?=
 =?utf-8?B?UnJ5TXU1UUFFMVlCQWM0YUtpYTNyNFNZY0h5Wk1rWG1KMld5cFc2andVbFBM?=
 =?utf-8?B?cngxRDlkSUViZlVxTWROMUE4amd2dzlUM014dlhkZkNTK1JkaEY2d0pPNzg1?=
 =?utf-8?B?MHM3K0hTNk9JUmlJS0hRZVo4NjJYSis5WDRKRlpNK3RTaVozUWJnM00xTzNp?=
 =?utf-8?B?S2VWS0RoUlpNeXNadW41NUVFTVJQaDR0TlFna0VxbUhrc1BtUTJ1bG1ZcVlF?=
 =?utf-8?B?NU0rL2hTVE9JVTk3NE5hV3p0MHpVdGh1eUFVMkR4cElVZldZdFJWckhmaXB6?=
 =?utf-8?B?aENHZFJlSEF6cFBvQ1V5eUNLTEpoUHFnV3pna2ptVzlOL1hoWVZIWG9HbTlD?=
 =?utf-8?B?NXJsSGorK3ZmUXNnN1JoejR4ZXNvSE50WGtLOW82VnVNTVJvWXM1VklBZXhl?=
 =?utf-8?B?Q3JPOXk1U1lPQ2syMUM0eHRNWVVwaEIxT2xkdVRXdml4T1lHNUdPTitjMTJs?=
 =?utf-8?B?c0hCS2Rpa2FWR24vckZVSjZLQi9aQzZPRldCWTNPN2Mvd2FTOWdBSFhCa3JT?=
 =?utf-8?B?V01UWW02TVIvTUVEWUtpZE02dnM3VTVKRlNJblZCcmhpMkF5clNncWttZC9S?=
 =?utf-8?B?UFdFNkZ3djJJaTVyUUZYNCtGdUFST1duOENQWHFvaTczSzljYVZDM2lFOFMz?=
 =?utf-8?B?UTZBUnZOdThsaCtDSlFwazRZeUNiZzVMVjlBNzNCWjJuNmwrYU4rZlZCS1V1?=
 =?utf-8?B?eTV3TVY0RyttWERxRDgyRnR2QTBKV2VLZURRaGlxRUE4bUpLc2Q2MHpsWXdI?=
 =?utf-8?B?L3NISnUxMVU1Z0xmOVdLQTM3RXpGSGdrdERiNXZBMHVDazcweFZ4aE52ZGdz?=
 =?utf-8?B?QytUTHc3bG9rd2d4b0Y4T1NOK0QzSjlXUU5qQnViOW1mdDNIVER6VVdMVWhE?=
 =?utf-8?B?ZnRuaHRsNjlZbDJTTFUxRGNrWVJqbHJLdVBwM0RFOUhjK1g4Y1VsQ1p5RkZw?=
 =?utf-8?B?aE16WGJya0VHUm5HV0VscG9MVytoMUVvWVpWN1NjL3RKQ0liSmtVamZ5NkhQ?=
 =?utf-8?B?SkZwdHpGMlJMVWJXT3Z2NDJrdmk1Nms2TUhkdEJCVnY2UHRLeWJCczVKczdB?=
 =?utf-8?B?UVFBK0VZVDdiQmNIajdqV1dVTXdEN2Q4V3RyRjEvRmpxMm11Vnl0N0p5Y0lE?=
 =?utf-8?B?UTZac2thR0hORG9PRWtMZ0R0MllzZWxyTjg1UjZUUm5vWi9zT1VMZHZHelBk?=
 =?utf-8?B?eXFKSHF6WlNSQXcxS3RFa25qVnF5T2FjT3VoQ1Y0VGs3MWJRU0xOcnI2SzRM?=
 =?utf-8?B?VnNLUURhcXpncDZyWTRYU05meEdRL2g1MFZFcnJPQWZlcXpBNmptNHdaaEtv?=
 =?utf-8?B?MnJKMmZGQ3poUlhCZ1l6Tlg3c1RmREhKc29KNkU3cHJwRFlNTDE5emNrL3dk?=
 =?utf-8?B?RFdrTkRLckozUjFCV0RzeFN6WU1vT3VBTDRlR2xnbklDSVJNMTZUR3UvdlRY?=
 =?utf-8?B?OGdvZDUyR1MzY0RyU2ZjRzdVZU5iZVZYajgzQ20zOGlHSjFGalBoQmlhRVdH?=
 =?utf-8?B?MXozVURJbXRYcWVNZ0hKVVc2aWlpOHF4SlpQSkgxTUgvZGtlSCttdlBMcTV3?=
 =?utf-8?B?bmNublgyb1dWQ2pXRDZrUlNOZWFTem01a0ZQc3hFVmc1Snp3ZzhEVXNaSy9l?=
 =?utf-8?B?ZWx3M3FtN1NPYk1tUkNDZlMxeVlSVGZya1dmbjZvR1p5MWlTMC9yNjFKMnJn?=
 =?utf-8?B?VXpyTm5SUERDbnc3dW1HZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f62104f-5bb9-4220-8041-08d976d0cc1e
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Sep 2021 16:09:00.0571
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W/zaa3yHM/JDjeJEolJ4YUx4nXo0G0eiVpURouagL6WCsXViOQyCcmoOOzzFJIVG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4158
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: Zb19j5GGeprDTA2_tDAlQ9BnT4pKok95
X-Proofpoint-GUID: Zb19j5GGeprDTA2_tDAlQ9BnT4pKok95
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-13_07,2021-09-09_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 suspectscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109030001 definitions=main-2109130105
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

cc Jose E. Marchesi

Hi, Jose, just let you know that the BTF format for BTF_KIND_TAG is
changed since v1 as the new format can simplify kernel/libbpf 
implementation. Thanks!

On 9/13/21 8:51 AM, Yonghong Song wrote:
> LLVM14 added support for a new C attribute ([1])
>    __attribute__((btf_tag("arbitrary_str")))
> This attribute will be emitted to dwarf ([2]) and pahole
> will convert it to BTF. Or for bpf target, this
> attribute will be emitted to BTF directly ([3], [4]).
> The attribute is intended to provide additional
> information for
>    - struct/union type or struct/union member
>    - static/global variables
>    - static/global function or function parameter.
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
> 
> In the rest of the series, Patches 1-2 had
> kernel support. Patches 3-4 added
> libbpf support. Patch 5 added bpftool
> support. Patches 6-10 added various selftests.
> Patch 11 added documentation for the new kind.
> 
>    [1] https://reviews.llvm.org/D106614
>    [2] https://reviews.llvm.org/D106621
>    [3] https://reviews.llvm.org/D106622
>    [4] https://reviews.llvm.org/D109560
> 
> Changelog:
>    v1 -> v2:
>      - BTF ELF format changed in llvm ([4] above),
>        so cross-board change to use the new format.
>      - Clarified in commit message that BTF_KIND_TAG
>        is not emitted by bpftool btf dump format c.
>      - Fix various comments from Andrii.
> 
> Yonghong Song (11):
>    btf: change BTF_KIND_* macros to enums
>    bpf: support for new btf kind BTF_KIND_TAG
>    libbpf: rename btf_{hash,equal}_int to btf_{hash,equal}_int_tag
>    libbpf: add support for BTF_KIND_TAG
>    bpftool: add support for BTF_KIND_TAG
>    selftests/bpf: test libbpf API function btf__add_tag()
>    selftests/bpf: change NAME_NTH/IS_NAME_NTH for BTF_KIND_TAG format
>    selftests/bpf: add BTF_KIND_TAG unit tests
>    selftests/bpf: test BTF_KIND_TAG for deduplication
>    selftests/bpf: add a test with a bpf program with btf_tag attributes
>    docs/bpf: add documentation for BTF_KIND_TAG
> 
>   Documentation/bpf/btf.rst                     |  27 +-
>   include/uapi/linux/btf.h                      |  52 +--
>   kernel/bpf/btf.c                              | 120 +++++++
>   tools/bpf/bpftool/btf.c                       |  12 +
>   tools/include/uapi/linux/btf.h                |  52 +--
>   tools/lib/bpf/btf.c                           |  85 ++++-
>   tools/lib/bpf/btf.h                           |  15 +
>   tools/lib/bpf/btf_dump.c                      |   3 +
>   tools/lib/bpf/libbpf.c                        |  31 +-
>   tools/lib/bpf/libbpf.map                      |   5 +
>   tools/lib/bpf/libbpf_internal.h               |   2 +
>   tools/testing/selftests/bpf/btf_helpers.c     |   7 +-
>   tools/testing/selftests/bpf/prog_tests/btf.c  | 318 ++++++++++++++++--
>   .../selftests/bpf/prog_tests/btf_tag.c        |  14 +
>   .../selftests/bpf/prog_tests/btf_write.c      |  21 ++
>   tools/testing/selftests/bpf/progs/tag.c       |  39 +++
>   tools/testing/selftests/bpf/test_btf.h        |   3 +
>   17 files changed, 736 insertions(+), 70 deletions(-)
>   create mode 100644 tools/testing/selftests/bpf/prog_tests/btf_tag.c
>   create mode 100644 tools/testing/selftests/bpf/progs/tag.c
> 

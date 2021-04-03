Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34AF33535BA
	for <lists+bpf@lfdr.de>; Sun,  4 Apr 2021 01:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236672AbhDCXOH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Apr 2021 19:14:07 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:58420 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236625AbhDCXOG (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 3 Apr 2021 19:14:06 -0400
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 133NBJsR022986;
        Sat, 3 Apr 2021 16:13:58 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=5zAGsTrsGN9TODtj20Fj0kYuHfwRF5NJJWFVEKQTAjo=;
 b=DWNOsjMn4cEVbNq4i54pxVIm/bWsVsNkN88KXUXpQ7ri5boPvf5/KNdt7Z3eXgkkEowM
 JPIBqPb3EUUq+YAUGCDJqi7kDZbyiKuR6YnBUWY07eILRSOyZBCox3kGjZ0Gz0TVnGvy
 lDm/5z7UXGO4j2HAAOQ+cLrNnSg7cDv56ds= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37q0ge862y-14
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 03 Apr 2021 16:13:58 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 3 Apr 2021 16:13:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eofafT+QAyQcvIj4NMhUM7TyqhNtP6P/z6ElzuvJkG6Qe69E6D1wL3vX2wlCaGBQfAGkX2a21P4/wq4tlTMGUYh2ajK0kmFrTn4cDr9DkWHw1u8qepnzT+npR7jn6SDMO1cHkOHUXVQAIxV6of2Z8a1RupfzrYOQT7u6jXnFO4blA0kamAgzBilb47biQvS0ERmx2XpgbMVhqWh0vXVUIQ9r0cJS/otDojUO0m6D16q6JohSq4nbjq4yVtw/rCCV6ktojrW/VvFEUHrDVv8IvQ6BSL9RF/oxMtxvyvtVoEJQBZ4+Xb5WTrSP93wwKkvbZkJu5NooySTiOnT7jWkSaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5zAGsTrsGN9TODtj20Fj0kYuHfwRF5NJJWFVEKQTAjo=;
 b=cg3NX6QhnSpvcmnmFqWehGgRJ97CgECLggYOQHUCrYVwqzOmfHHUBdw0x+2Fer7aBbdsvhcHtf2inuyIeFs+zBHXULH6GaM0H0QpWA3VVbWlINAX8hr7SjpokSQgSxwnpyudwDM3LyQ8VFKiL9BeIxgpWLlf4Q93YZjHptecXMPfxXJpiT3d8omMPBmT5PLcQ7Kihbt0Neh5pLTIn/Ud056ipdp872xKyu9RbyHe6FhbiCfYA3jpFTlzHPbsJhKEidULr9rwhHg/5BmzNi3QyQWyFnFmDdh6QAuTd9spzrATbpuWe9Pe2J7o+CwJautqxFZnDMmMjTtpzkd5HLqq3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4093.namprd15.prod.outlook.com (2603:10b6:805:63::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Sat, 3 Apr
 2021 23:13:53 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Sat, 3 Apr 2021
 23:13:53 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     <sedat.dilek@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>, <kernel-team@fb.com>,
        Nick Desaulniers <ndesaulniers@google.com>
References: <20210403184158.2834387-1-yhs@fb.com>
 <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <1f1e08d2-4570-0ba4-0ed4-832fca29fa05@fb.com>
Date:   Sat, 3 Apr 2021 16:13:50 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:78ac]
X-ClientProxiedBy: CO1PR15CA0054.namprd15.prod.outlook.com
 (2603:10b6:101:1f::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1466] (2620:10d:c090:400::5:78ac) by CO1PR15CA0054.namprd15.prod.outlook.com (2603:10b6:101:1f::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Sat, 3 Apr 2021 23:13:52 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 841696a1-0d07-43d6-c769-08d8f6f625d2
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4093:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB40937D8C7268B4F29F6659BFD3799@SN6PR1501MB4093.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3513;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C/scfp/Dp7EFKjwgpDxWlj24EuuJXzAftDgf2I4QtFyq2pmbk5rYPRWfdGG7vH2DIj2zPnosEFsZQPDTxhFLWxA6BGJUiaD/F83mNEEwO9Vhmm87INWXeOm13mK5XS1ikbVStx8xSRZUnUtRXuybUsTpUU7WAsBzVGbNImh8c0Y13z6dNW12v8ttXXB3FkPl1vKb9fpGtz/F0S+TCLc5hhfE7B7iHLZo8zjDIj8DNEfntwu2f9qnyl9p/+0u70HAbS/SM5aBJz4p9adreZyHXdbS/zUz4ynjjbxAFCAD93/1f7ced5hSBycAah1onDx80WP4bMVKUv8g3C4HcUSCBDzwytDLjymhdk2ui0hp2PRBFR0WJItXvY1Orm5YlWKNmB4ll9wHyf27KYFO3vYo9DFsQJ4nfgwHnzteWsqz9JoP+PoZFe4nU55TvQVvD3e54z3RBqU3BfjeNYGxIjFgJbcWcD+gq9iG2zGJQowEXjNEbvOQcIxnbj6kMxVEgebnCoS55f3OWZC+SKrqM9H19nxU2lAmJoR0IaP95uG3CXtOF135fm3mVNlpGc4BQobJy0NH1tiehkfg+I1DJo53m7vxvzU0ZkLybelYfHammOM0weGgoI4DwCsz8IpuPESdR0LpYDZMIaVDjOnCLF1aZcvaTguT8Q8KPqWCPcxdf9M7qckP1HdPH/HwChPAMG+jGQDKKC2WUbi29DoVRD8gI7CUPk6g2ly5R5fFf/bkKL/SUqXwP1boFrSHspWy7s7hPauE0Ave0JQId6ayqbGUpvHCMEgH5qZtPqagp7G7zivPA+DzIDCGJ2gP3/0NeWFQ2PB68+UbpWaI33opOax7LQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(366004)(376002)(136003)(396003)(54906003)(2616005)(86362001)(8936002)(38100700001)(2906002)(52116002)(6916009)(6486002)(8676002)(186003)(36756003)(16526019)(5660300002)(83380400001)(478600001)(31686004)(4326008)(966005)(53546011)(66946007)(66556008)(316002)(31696002)(66476007)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?Ty9rajlRRXVLb2Z3T002ZjVRUXU4U1pPYy9YVi9QTSszWksxTElMbWtqSUEy?=
 =?utf-8?B?N2pSMllmeXhQbGVYZG5kRVp5b1dGVk11UU1QZVhKc1drbDZUUE5nWDVjZFdS?=
 =?utf-8?B?NW1hWkV4YWYrY09rbzJnQ3kyMG5MVkVLUjFDbEVWUS9Tb2tVMC9mSE1PUGVj?=
 =?utf-8?B?TWcyQnQ2citSdlUvNTg5RFJla2VPUUZDa1RlTmVyd2JnQ2pLYjhRS285MGN4?=
 =?utf-8?B?V0RiTWZ1QzJWeHBub0doOHBSNTU5K21UQW41ZkhCTjBodkRyME4ybkNpQkEx?=
 =?utf-8?B?MDRyamsxVnRPMWZxS2tnODdHbWRRRkxSNU9SSFpXdXoyeXJ0TWhTVGY1Y0dS?=
 =?utf-8?B?UUNndkVZU3Q2UlZ6cEJpd09WVG9BL1dncXhHTm9ZVkxIVWUwRzlFOWY1VWNC?=
 =?utf-8?B?b29WOEE0eTk1RmZDOGtpNWx6UVJia2MvYmRYNUVxd0xMT2FsRGxTWERVRWN5?=
 =?utf-8?B?UzRydzluVlNvdHA1TmdQeFlETXJWeW1iZ1I4R3Fnd2pCeGlGd3I1TnZRa1p6?=
 =?utf-8?B?NlUxekxMS0FZT0JCbGJYOGZvZGZaN3BQWlhPMGUwRFFzL0xPMEFjSS9RTFhI?=
 =?utf-8?B?c09lK1VtdzBWeFhweUdlSXRxbzc3WmFxZnA1VnNKaTN1REc1bW9OVjZ1NlUx?=
 =?utf-8?B?TGVWRlBjUGR3TnZUR2JmMGxZRTMzdUVpb0VjNGtIUDJjSzFINUQ5SmVPTW43?=
 =?utf-8?B?VkREdEFkazN0aVFjVnNnd2RLTmI1UllpdmRLWEx2L0VLWDJWWFV4Mjhsck1w?=
 =?utf-8?B?ZVBKcUhyQU0vRk1KVzljMW1Ma0JFS0kzNkF5dlgvSHNGRGNMUEM4QlFHWkNE?=
 =?utf-8?B?Y2hmcHFJSDBlWU8zV2xvQXZLMU9lbnA2L1ovZHVtQnRJZ0drVlU4WlpNUFVp?=
 =?utf-8?B?VnRKOHE1dFFiNldaRXV2eUZ6ZlQyUmlqam1OaXV0QU1NUE45VkYreDZiTHhY?=
 =?utf-8?B?Q0hQdHNmMWhnLzQvN2orRHI1WC9mSEhhN1BBbm11bkRkS09pWFJBNjl5U3A1?=
 =?utf-8?B?UXp5K1I1cUE2S0pWR2lhcFdYc0pxcUkxenVvM1hQeHRnQlFxWk4rRTBMUUJG?=
 =?utf-8?B?K010NlR0NGdLYzl3VkZ3ZFZsRG40ODkxdXpEaitTWmVZZEhpdEQrSzNEMWVF?=
 =?utf-8?B?QjR0Q0dreVVpL0hKaGZyejRRRy9WdkpDYU5vdTFlVGN2SEpra1o5S2JCNG52?=
 =?utf-8?B?OERYSDJsRStEMHgrRHh0ZnhFN296czl0MnVoWVlIM0JnYUpOYnJnV2doSTZM?=
 =?utf-8?B?K1ZjbkhtRjBWS2hWQWZaWndSbFdIZU1RdGl1TGYyNk9Ea2R4aGMxNDFlMjRJ?=
 =?utf-8?B?UndNTW02d25XL2tlb0tmZ28vQUIxOTBoK2NGbW0wdlN1M3BpQTBrVmpCNWRz?=
 =?utf-8?B?ZHFYeStYa0YrQ1F1ZEd0UFRZR3FQdTY3ZythTmpINFFPMHNDd0V0c01SdGl6?=
 =?utf-8?B?c3J1RTFaSXZjUlR3aUlTeWJGNEY2MXlkbWRieWN4TjVLdDFWdHU4b2NCUGdI?=
 =?utf-8?B?YzBqRjByQmR1bDhHcjZnNkhnZDN0WS90eHdqbm5RRjUwcnFZdXJBc1E5WDdU?=
 =?utf-8?B?R1dDczJkUWdjcWY2WSsydVM3WVN4VUxnV2paN1VjZ0hUbVBraEZZeCt4RlZX?=
 =?utf-8?B?d2J4SnYrUTM2Y1R4anBsblBvazUrbjA0ZFJTS3F5bWFRby82UWJNZVpacWI3?=
 =?utf-8?B?TjdpaTRvQ0FwSGkrb3BRcWhDbnRPNWpVNHFFbFMzRlY4VHA4QjZNVXB3eGYr?=
 =?utf-8?B?UjhmYTFZbitjb0ZJMURXMHhmeCtMQXRreHdGdnVlam9EYjBsclVRa2pjYzFl?=
 =?utf-8?Q?bpJp20OCxg8Lkd8hwaiBBqFOa8SgcHCSR8Tb8=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 841696a1-0d07-43d6-c769-08d8f6f625d2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2021 23:13:53.1972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pa3D1E6FSjVm4VDLmyL7agRgXBlq923zsP2CwrRhyCIbxS97jszPqKJCU/8KEcJT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4093
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: ct3GA2KOn_Xc3Dfhlg3v-6fb0pdnKPPF
X-Proofpoint-ORIG-GUID: ct3GA2KOn_Xc3Dfhlg3v-6fb0pdnKPPF
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-03_13:2021-04-01,2021-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 spamscore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 phishscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2103310000 definitions=main-2104030164
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/3/21 2:42 PM, Sedat Dilek wrote:
> On Sat, Apr 3, 2021 at 8:42 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Currently, when DWARF5 is enabled in kernel, DEBUG_INFO_BTF
>> needs to be disabled. I hacked the kernel to enable DEBUG_INFO_BTF
>> like:
>>    --- a/lib/Kconfig.debug
>>    +++ b/lib/Kconfig.debug
>>    @@ -286,7 +286,6 @@ config DEBUG_INFO_DWARF5
>>            bool "Generate DWARF Version 5 debuginfo"
>>            depends on GCC_VERSION >= 50000 || CC_IS_CLANG
>>            depends on CC_IS_GCC || $(success,$(srctree)/scripts/test_dwarf5_support.sh $(CC) $(CLANG_FLAGS))
>>    -       depends on !DEBUG_INFO_BTF
> 
> What Linux-kernel is your base?

https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git
latest one, essentially with top commit:
   89d69c5d0fbc Merge branch 'sockmap: introduce BPF_SK_SKB_VERDICT and 
support UDP'

> For linus Git this is correct.
> [ I have currently kbuild-next stuff in my custom patchset which has
> for example CONFIG_AS_IS_XXX where XXX is "GNU" means GNU/binutils AS
> or "LLVM" means LLVM/Clang Integrated ASsembler (IAS). ]
> 
>>            help
>> and tried DWARF5 with latest trunk clang, thin-lto and no lto.
>> In both cases, I got a few additional failures like:
>>    $ ./test_progs -n 55/2
> 
> What do you mean with "trunk" clang - we have Git now no more SVN :-)?

git: https://github.com/llvm/llvm-project.git
top commit:
    commit aaab4441796909e1b9cf4279906a56350c8fade7
    Author: Jianzhou Zhao <jianzhouzh@google.com>
    Date:   Mon Mar 29 00:14:16 2021 +0000

     [dfsan] Ignore dfsan origin wrappers when instrumenting code
> 
>  From where is that "test_progs" ?

Some information here.
 
https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git/tree/tools/testing/selftests/bpf/README.rst

Typically I do
   $ make -C tools/testing/selftests/bpf -j60 LLVM=1 LLVM_IAS=1
and then boot up a qemu with the bpf-next vmlinux and then run
"test_progs" binary which is located as
     tools/test/selftests/bpf/test_progs

> 
> I tried to build:
> 
> LLVM_TOOLCHAIN_PATH="/opt/llvm-toolchain/bin"
> if [ -d ${LLVM_TOOLCHAIN_PATH} ]; then
>    export PATH="${LLVM_TOOLCHAIN_PATH}:${PATH}"
> fi
> 
> $ echo $PATH
> /opt/llvm-toolchain/bin:/opt/proxychains-ng/bin:/home/dileks/bin:/usr/local/bin:/usr/bin:/bin:/usr/local/games:/usr/games
> 
> $ clang --version
> dileks clang version 12.0.0 (https://github.com/llvm/llvm-project.git
> 04ba60cfe598e41084fb848daae47e0ed910fa7d)
> Target: x86_64-unknown-linux-gnu
> Thread model: posix
> InstalledDir: /opt/llvm-toolchain/bin
> 
> MAKE="make V=1"
> MAKE_OPTS="HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang
> LD=ld.lld LLVM=1 LLVM_IAS=1"
> MAKE_OPTS="$MAKE_OPTS PAHOLE=/opt/pahole/bin/pahole"
> 
> $ echo $MAKE $MAKE_OPTS
> make V=1 HOSTCC=clang HOSTCXX=clang++ HOSTLD=ld.lld CC=clang LD=ld.lld
> LLVM=1 LLVM_IAS=1 PAHOLE=/opt/pahole/bin/pahole
> 
> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/bpf/ 2&>1 | tee ../make-log_tools-bpf.txt
> ...is OK.
> 
> $ LC_ALL=C $MAKE $MAKE_OPTS -C tools/testing/selftests/bpf/ 2>&1 | tee
> ../make-log_tools-testing-selftests-bpf.txt
> ...is broken here.
> 
> NOTE: Both make-log_tools-bpf.txt and
> make-log_tools-testing-selftests-bpf.txt are attached.
> 
>>    ...
>>    libbpf: extern (var ksym) 'bpf_prog_active': failed to find BTF ID in kernel BTF(s).
>>    libbpf: failed to load object 'kfunc_call_test_subprog'
>>    libbpf: failed to load BPF skeleton 'kfunc_call_test_subprog': -22
>>    test_subprog:FAIL:skel unexpected error: 0
>>    #55/2 subprog:FAIL
>>
>> Here, bpf_prog_active is a percpu global variable and pahole is supposed to
>> put into BTF, but it is not there.
>>
>> Further analysis shows this is due to encoding difference between
>> DWARF4 and DWARF5. In DWARF5, a new section .debug_addr
>> and several new ops, e.g. DW_OP_addrx, are introduced.
>> DW_OP_addrx is actually an index into .debug_addr section starting
>> from an offset encoded with DW_AT_addr_base in DW_TAG_compile_unit.
>>
> 
> With LLVM toolchain v12.0.0-rc4 I see "DW_OP_addrx".
> I need a test-case to hit the issue(s) and test this or any other
> (pahole) patches.

I am using llvm-project repo "main" branch which is the development
branch.

To test this, you can do:
    . build vmlinux (say bpf-next branch) with dwarf4
    . pahole -JV vmlinux >& log.pahole
    . grep "bpf_prog_active" log.pahole and you will see
$ grep bpf_prog_active log
Found per-CPU symbol 'bpf_prog_active' at address 0x1f8350
Variable 'bpf_prog_active' from CU 
'/home/yhs/work/bpf-next/kernel/bpf/syscall.c' at address 0x1f8350 encoded
[601922] VAR bpf_prog_active type=598691 linkage=1
$ grep " VAR " log.pahole | wc -l
299

totally 299 BTF variables are encoded.

     . build vmlinux with dwarf5 (without this patch)
     . pahole -JV vmlinux >& log.pahole
     . grep "bpf_prog_active" log.pahole and you will see
$ grep "bpf_prog_active" log.pahole
Found per-CPU symbol 'bpf_prog_active' at address 0x1f8350
$ grep " VAR " log.pahole | wc -l
0

There are o BTF variables are encoded.

With this patch, for dwarf5 again,
$ pahole -JV vmlinux >& log.pahole2
$ grep "bpf_prog_active" log.pahole2
Found per-CPU symbol 'bpf_prog_active' at address 0x1f8350
Variable 'bpf_prog_active' from CU 
'/home/yhs/work/bpf-next/kernel/bpf/syscall.c' at address 0x1f8350 encoded
[602735] VAR bpf_prog_active type=599504 linkage=1
$ grep " VAR " log.pahole2 | wc -l
299

I guess this could be fold into some kind of regression test to ensure
dwarf4 and dwarf5 does not change at lease variable encoding for BTF.
If they are, we need to investigate.

> 
> Thanks.
> 
> - Sedat -
> 
>> For the above 'bpf_prog_active' example, with DWARF4, we have
>>    0x02281a96:   DW_TAG_variable
>>                    DW_AT_name      ("bpf_prog_active")
>>                    DW_AT_decl_file ("/home/yhs/work/bpf-next/include/linux/bpf.h")
>>                    DW_AT_decl_line (1170)
>>                    DW_AT_decl_column       (0x01)
>>                    DW_AT_type      (0x0226d171 "int")
>>                    DW_AT_external  (true)
>>                    DW_AT_declaration       (true)
>>
>>    0x02292f04:   DW_TAG_variable
>>                    DW_AT_specification     (0x02281a96 "bpf_prog_active")
>>                    DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/syscall.c")
>>                    DW_AT_decl_line (45)
>>                    DW_AT_location  (DW_OP_addr 0x28940)
>> For DWARF5, we have
>>    0x0138b0a1:   DW_TAG_variable
>>                    DW_AT_name      ("bpf_prog_active")
>>                    DW_AT_type      (0x013760b9 "int")
>>                    DW_AT_external  (true)
>>                    DW_AT_decl_file ("/home/yhs/work/bpf-next/kernel/bpf/syscall.c")
>>                    DW_AT_decl_line (45)
>>                    DW_AT_location  (DW_OP_addrx 0x16)
>>
>> This patch added support for DW_OP_addrx. With the patch, the above
>> failing bpf selftest and other similar failed selftests succeeded.
>> ---
>>   dwarf_loader.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> NOTE: with this patch, at least for clang trunk, all bpf selftests
>>        are fine for DWARF5 w.r.t. compiler and pahole. Hopefully
>>        after pahole 1.21 release, we can remove DWARF5 dependence
>>        with !DEBUG_INFO_BTF.
>>
>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>> index 82d7131..49336ac 100644
>> --- a/dwarf_loader.c
>> +++ b/dwarf_loader.c
>> @@ -401,8 +401,19 @@ static int attr_location(Dwarf_Die *die, Dwarf_Op **expr, size_t *exprlen)
>>   {
>>          Dwarf_Attribute attr;
>>          if (dwarf_attr(die, DW_AT_location, &attr) != NULL) {
>> -               if (dwarf_getlocation(&attr, expr, exprlen) == 0)
>> +               if (dwarf_getlocation(&attr, expr, exprlen) == 0) {
>> +                       /* DW_OP_addrx needs additional lookup for real addr. */
>> +                       if (*exprlen != 0 && expr[0]->atom == DW_OP_addrx) {
>> +                               Dwarf_Attribute addr_attr;
>> +                               dwarf_getlocation_attr(&attr, expr[0], &addr_attr);
>> +
>> +                               Dwarf_Addr address;
>> +                               dwarf_formaddr (&addr_attr, &address);
>> +
>> +                               expr[0]->number = address;
>> +                       }
>>                          return 0;
>> +               }
>>          }
>>
>>          return 1;
>> @@ -626,6 +637,7 @@ static enum vscope dwarf__location(Dwarf_Die *die, uint64_t *addr, struct locati
>>                  Dwarf_Op *expr = location->expr;
>>                  switch (expr->atom) {
>>                  case DW_OP_addr:
>> +               case DW_OP_addrx:
>>                          scope = VSCOPE_GLOBAL;
>>                          *addr = expr[0].number;
>>                          break;
>> --
>> 2.30.2
>>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DACF3535EA
	for <lists+bpf@lfdr.de>; Sun,  4 Apr 2021 01:27:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236812AbhDCX1P (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Apr 2021 19:27:15 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:43606 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236752AbhDCX1P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 3 Apr 2021 19:27:15 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 133NP44k020718;
        Sat, 3 Apr 2021 16:27:08 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=WoReMP77puO50L2mDhXgu+1b5HzkIw5jO9L9EG9F220=;
 b=Tx3RNcYujvFKnOdbI3u+Gr+Sqw3agD2fH1HnaFWz5L0J7j1RKHR7OikAKuGm5d5vQRcE
 ZoQiLPdHhk39QBklwL7sPbXcXtDrJTs7PQdqLtzbVeO+av6vji/hjPGxs4oH7fKRUB8d
 IGCPlrBEhH7KXeqKpjVfhR2BzCbn2ZyecFY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37q1tpg0yp-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 03 Apr 2021 16:27:07 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 3 Apr 2021 16:27:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cpUkUhDyFez7OtqlFI3dvYAcgaJGfcfZVeQYbiqAiMtTQ4Dmwib7iiwyOf3Etrgc4ETY9p356PyMk4sRocBVoBYCteZHz3L8Fsniik2u+yn8OuEcGeih4n3nL56j8jmwuGIGLX6ugUvWZ2TWfCvBg63vleMg4PhbabmKuWQFRdVg5RVP+ihYFiG+Ol/nm6p1Vee5RfSl5aCX40L1N0Pc16kuTl6u7L8/yO5e8HWoNyv5PDAtVJAhK5ovP/csx1u+wTNLH+ydhjitbRhAYhjPHtkjLhq90Fa4TiC+Alg91PAUW8Zgb5qV5lRC/ckfY2Z7C92UOwyXU2cZ3IbGkPrMUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WoReMP77puO50L2mDhXgu+1b5HzkIw5jO9L9EG9F220=;
 b=kP6CmX/I5uAMYtWP1di1KCTrSheTVXxDvu/2wOV83ccwD0OvAXQWHsdYIVmKvV+1Zbr8XA+g3UIN4IlGaXf5uIN10oxfaDGMtDVeY+2NkBt1mcv1ltUkclOQa2kEMlbkBPz/f+oRhMxpTISiWt4lNJZHmpRaI26xTUA8hXa6H71eHKdfmtrvrKjc3dthQda798O9YPLmmWU7wl0GG1GJTxF1T3eQk86lHoNwmKfHQ7hEu6bBReaJZ/WYsUe9C0PDTifS8vbvKebR4L5DmhzLfyg6wnb9LfUFe+b2rPafegsJ1gJ9rXFF76mXnp743uBzJhRjtPqLijXNsMJkpu4Odw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3933.namprd15.prod.outlook.com (2603:10b6:806:83::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Sat, 3 Apr
 2021 23:27:06 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Sat, 3 Apr 2021
 23:27:06 +0000
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
Message-ID: <6c67f02a-3bc2-625a-3b05-7eb3533044bb@fb.com>
Date:   Sat, 3 Apr 2021 16:27:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CA+icZUWLf4W_1u_p4-Rx1OD7h_ydP4Xzv12tMA2HZqj9CCOH0Q@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:78ac]
X-ClientProxiedBy: MW4PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:303:b5::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1466] (2620:10d:c090:400::5:78ac) by MW4PR03CA0290.namprd03.prod.outlook.com (2603:10b6:303:b5::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28 via Frontend Transport; Sat, 3 Apr 2021 23:27:05 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 04aed839-6cc1-49a1-1c70-08d8f6f7fe9f
X-MS-TrafficTypeDiagnostic: SA0PR15MB3933:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB393381F58B11D1E1D67D8B55D3799@SA0PR15MB3933.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +WKKqZQ0jHPBk/eJpa2hOZ1/+gC+2jCuE7BPPK3fOxtrio4ZP71/qdl4vYyj7sPm0jBLH4XJEHuRUos6eJe3d9J88xA+rZVouudBD44/m80RVRfZ027h0NcYF5Za9QNfBadH9wIs8xZJr3tIS8xm0utqlonifI9m+wRJ4p/uEGvDLKa8M/G1rhF3fWzSJr5d34VJjEdmWFnHtN30Sg3ZOzAllTnN5dLFj0bEeGtqGLEGXUTY2ENq9uO6KX+tQ5dXXkR++YMnh08aCh1fKQTHIPNBFnlN4n0CvoGHwY4/p8ohIiffSZS/NeXtengm947RbHfC13lFrA18/iok08YYraraez8g44dbCACRvnDfioKBMPtxA+qxA4mB5qxoKH7G72MQtoSQVKaZuRUI+ZAzTUB4la0JYS6or/TFmiqobvDPBigbLhnSECi9z/E3spEoN/38ptTcy1w5P5Qm3V9kT48YFWYA/SWFOZ/Y7BBoFLsxOisN+gemyY9J48QA+o+iJVbnFAmOVKH2xBQd8HcNt4whwaLKs6iFr51b8E4H2ROe674S9JJ1hfYGEOv7JHwDH1vOnbPDNep/n/NfvAvotKNYJqaHbBbd/PxvGL7bUwtQbgy8JdWXlZrAXzRpnRfJQAXoRqscOZcbG0nAMEsfnQ81HXxKKK2ZVctWiMS0VU5d0idTKV6+LNtg6KMRZnoK3UCQf825R5io1oJs6v8NtdtroaLAean4QJiTeE5U2X6ou1R3WP052ZyP6SxJ21wjaI4EOTo5hAT93LKwY7/lQ94GwTOdmX4f+SmU95YC7b1KyhcRHiAnNfK90MqDZPzcOqQf48ZU/oPFVLXuQyTMLw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(136003)(39860400002)(346002)(376002)(6916009)(38100700001)(478600001)(86362001)(4326008)(5660300002)(6486002)(8676002)(31686004)(53546011)(54906003)(6666004)(36756003)(66946007)(52116002)(2906002)(83380400001)(186003)(66556008)(66476007)(16526019)(2616005)(31696002)(8936002)(316002)(21314003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UVc0WXBUZ3J1ZTRScVdObVc2QkhscjZBU2ZKMktOemlZazdjMzhvSlJpRUJ4?=
 =?utf-8?B?aDhPVW4zaTJxbUMwVDE1dUlubXBzN1BIWlVyY3VsRlRnend6VVNNMDVkSk9E?=
 =?utf-8?B?ZnR0cE4zYkZiTUhvbTJOck9EUDJmSXJTSDZwZkFvVHA1ZGRVNUN3d0dsSSth?=
 =?utf-8?B?TGZFUVdhSjBWeG5wN1o0M0c4eHYyeWVIZHNVVzh2RWVMV2JIMXRUSldwV1BQ?=
 =?utf-8?B?Nm1kNTdjY2ozRFh1LzMwczdOTjAyYXJFSnNLRG9TYlRZdG1RajgrbW1CMzY1?=
 =?utf-8?B?emxxNFRxTDZ5ZzAvL05uWU5GMmo0VGNYa3FTZ0x1c1p3TFkrQzluUGV0V0wy?=
 =?utf-8?B?ZERZMVoxTUdET3gwTGRBelFVNU1BOUJ3TjFFdGF6VUs0SG02RnlGNW5VK1I1?=
 =?utf-8?B?RVFTaFA4WmdGN1JDcG4reWg4eHEwL1RYU0pGMlVkZzUxT3dsZW9lMEUzbzRi?=
 =?utf-8?B?eUNkR3YwSnNqMEpkVTJFS2Vid1F0cFcySVZsd09qUVFqSWxlKzJSZllQSHFk?=
 =?utf-8?B?VU85U1BWTS9USXJWbDVHS2xId1k1OSs2TmhGWmFkeWdjRzBkb3FNM1F5Rlc3?=
 =?utf-8?B?K2hkS3o4eUpKaWZuNnFDVitTbi9oVFFaM0ZubDhtWlZNTDlZTko5R3ZyRVB4?=
 =?utf-8?B?Tm9PRzRPdktsVkU1VEtQM21rRVlXeDBnRmdjb1ozRDlicmdRUU9MUm5sUWhu?=
 =?utf-8?B?Q0JMRVRtUFJ4VjREMDlWMjlHZHlRQ3U2NzFDZnFJNEhPMzdlNWZPY3kwTXdO?=
 =?utf-8?B?eFdOT0Z2eVBvckJYem1neWhIZDRZcDQrcUVQbmp0NmJxMFFYNHYvVHM3L1NC?=
 =?utf-8?B?MGxobUtHT3hWZUJaS0ZXL0w4NnhQNzZFbnd3UXZuRlh4dWExUDZqeDBKeXIy?=
 =?utf-8?B?aTZ1ZEwzMVVFT3dnZWFnYndzdmM3ZkZTZ0RzdlVwT0ljT2R5T2VmVUZMdE43?=
 =?utf-8?B?MDQ2b1hRNlVlU3pwSktYYlprTVhWcVgyTTdNUWt1MkJRSStyZFF2ejZyZ1lK?=
 =?utf-8?B?cDE5MnNZQ1dZTm9na0RUMk5sVGM3bGZkSExpN0EzTUM3Mm93RG1MYW4xT1Vw?=
 =?utf-8?B?RlpVUGZiaHdoUGN0bVNlZ2cremNSS3FVdzNYT3lmc1psdE9JWHNPYi9vOHJC?=
 =?utf-8?B?cFVHb0ZEM1dBZXU0UTF4dTZHcjd3K0tlSU9wOFV1U0hGQ2xydEU3T3lLTExM?=
 =?utf-8?B?dnVIbUkwV0o0YnNUY1gwT0ltMmsvQ2lMcC9aMnY4bUwwMkN0U2wvRVBXU0Vq?=
 =?utf-8?B?QjhQVUVtQXY0c2dHMFdLcEcveTB1Sm83L3p1c1YzYUtmYm9wSGhZbVNXcW45?=
 =?utf-8?B?dHNGeThQbTJDN0wvemhXeC81VlVZRk53S3UxWmZuVUIzNEpSTGNBOGxNTGRF?=
 =?utf-8?B?OTg0TnREaWZNbFZobHRGZGV4T2VYZFRHM2lpQXdRU016UWl0ajloYWdTZDJE?=
 =?utf-8?B?cm4vRFlJaTczSXVTNERxWGRIWTVZQ3lVUEp6dHY0NFBSc3dsc0ZxaUNzWWR1?=
 =?utf-8?B?YjVDeG9ETmdDcm5URUVkeHJ3ZHY5Mk0wd3A0ZXdybWJ3eFZDdG13VFUrc0VQ?=
 =?utf-8?B?WWRCdUtmVG9JSTMvWWNQNmdKa0UvOWU5a00vYVo4eUxFZjdsZnl6NHYweFU4?=
 =?utf-8?B?MTdZYU5CMDN3elJybzhVcnNNbi9kYWMrTUY0NmF4WUdaOVNxS2pMcjJjekpG?=
 =?utf-8?B?YmRldkI4YkNJMFpIUWhXYThUSmQxelM5bVF1aTgxaDdkaGlGWlNBWUh4S2RK?=
 =?utf-8?B?QjJZRVJ0WWJwaVhEZmFkckNwMWROY0ZPa1JtUUhlNExXRjRqK2o1eHNZaDBO?=
 =?utf-8?Q?BQkmifyHHy4pBTCArwfT1Cgl+32ZY3zMxBhJc=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 04aed839-6cc1-49a1-1c70-08d8f6f7fe9f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2021 23:27:06.3109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kb4MnrqJPlrZ5OcoyZOTA0VlqI4WUx6ZM7FWf6s9mPHwXoTc5AEZg1HWrbtG1LVL
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3933
X-OriginatorOrg: fb.com
X-Proofpoint-GUID: UrrozT91S4sGGsROrlIv-pY_q4HphEQp
X-Proofpoint-ORIG-GUID: UrrozT91S4sGGsROrlIv-pY_q4HphEQp
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-03_13:2021-04-01,2021-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 clxscore=1015
 malwarescore=0 lowpriorityscore=0 mlxlogscore=999 bulkscore=0
 priorityscore=1501 mlxscore=0 impostorscore=0 suspectscore=0 spamscore=0
 adultscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104030166
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
> 
>  From where is that "test_progs" ?
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

bpf selftest always tends to require latest clang.

For the error,
-idirafter /opt/llvm-toolchain/lib/clang/12.0.0/include -idirafter 
/usr/include/x86_64-linux-gnu -idirafter /usr/include 
-Wno-compare-distinct-pointer-types -DENABLE_ATOMICS_TESTS -O2 -target 
bpf -c progs/local_storage.c -o 
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/local_storage.o 
-mcpu=v3
progs/local_storage.c:41:15: error: use of undeclared identifier 
'BPF_MAP_TYPE_TASK_STORAGE'; did you mean 'BPF_MAP_TYPE_SK_STORAGE'?
         __uint(type, BPF_MAP_TYPE_TASK_STORAGE);
                      ^~~~~~~~~~~~~~~~~~~~~~~~~
                      BPF_MAP_TYPE_SK_STORAGE
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/include/bpf/bpf_helpers.h:13:39: 
note: expanded from macro '__uint'
#define __uint(name, val) int (*name)[val]
                                       ^
/home/dileks/src/linux-kernel/git/tools/testing/selftests/bpf/tools/include/vmlinux.h:10202:2: 
note: 'BPF_MAP_TYPE_SK_STORAGE' declared here
         BPF_MAP_TYPE_SK_STORAGE = 24,
         ^
1 error generated.

vmlinux.h does not contain BPF_MAP_TYPE_TASK_STORAGE.
vmlinux.h is generated from BTF of the vmlinux you just built,
but it looks like somehow it is generated from another vmlinux
it does not contain BPF_MAP_TYPE_TASK_STORAGE. There are some
build magic here to find correct vmlinux and maybe this just
does not work for you.

But you can use the pahole output comparison of BTF VAR encoding
between dwarf4 and dwarf5, this will have even more coverage.

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

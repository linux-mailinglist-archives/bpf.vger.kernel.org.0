Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06B5D361879
	for <lists+bpf@lfdr.de>; Fri, 16 Apr 2021 05:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238374AbhDPD7v (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 15 Apr 2021 23:59:51 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:28364 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S234708AbhDPD7t (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 15 Apr 2021 23:59:49 -0400
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 13G3sd6b009319;
        Thu, 15 Apr 2021 20:59:22 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=7WjrV0hX9dZLBRTvrtshZcKGMQLv2BYYAOGNf1mGTQE=;
 b=HliGC4zbKVgvUDq5l8+05BDVLuu/f53OTeowmzi2/IaPKTIhzJzre3S5k2+DI2arsRQB
 gULXPmsAsPx5m2VVHZkKHv0L1Ec9rP06gUruWNHQC9T/p+fJJIxEjFyzhcS0ZFRUjD57
 64WxU+pBPVXvS2BJIY2Dl8eoC7Gh78Vy4yA= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 37wvgkbs06-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 15 Apr 2021 20:59:22 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 15 Apr 2021 20:59:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jhkqdfImHtnP3cYWj1yesc0eOiQ/hnQrVRYRAgu/1KQTTEDF9c1tMFrjwRzc+W0YJMbSBQPlwf8GHF5INIYjOL3J/mXB953rC2jftbeysFmwOUyBCYAVWNvY4Mhsa4yvcDX1hxbVJuCkyG0DzYe795f3fDY2+ZIMxXYSbk0zccFkYfaHdyjcht5O8L3O4ZY3lAqSxcfRXb2YzDpgYfCVgt1iREWtXoArM4OgtvaWOefzR7ge30jNk3quOxUCS+Gtfeu1htZby5RTKyKT0JDijRw1SN/DInudHiM/ZjrtkH7XIDoGNzDNckk81NyExOrBj9tQ6FTMnCRHI4bs5KGgCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7WjrV0hX9dZLBRTvrtshZcKGMQLv2BYYAOGNf1mGTQE=;
 b=UVv1JtAcbeO83h355BCrMbumMC2o2JwUKdhP9lSq+0c5jIw4/2t5RZ67ZcPQdGPkOQRJF2IzpVO69yFn4+UHlmb5g0UsZWhX70GuKiuhWr9VVEPoNSDBfv62iQN9mhugFQXlXqx1SKu66VltQtnCLt6pOWXwi7eVLFTpJ27gq8PqyzFIc/Dt+nu7O+Ur05zb4LZrmjOT9pwnF/e8Pam0d1O3OdbKOZ7i/atDNwhW8g3Hir7oA1Gex9/UHYyUXWzvfoaV2tMzj/Z6NRl/jjZzOFyqSMc7CaYHFzhv19VNHG/mVD+jzfncE4HXlF4udcrS02SnkvxB9/cr7TpTXQvIjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3917.namprd15.prod.outlook.com (2603:10b6:806:87::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Fri, 16 Apr
 2021 03:59:19 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.038; Fri, 16 Apr 2021
 03:59:19 +0000
Subject: Re: [PATCH bpf-next v3 0/5] bpf: tools: support build selftests/bpf
 with clang
To:     Alexei Starovoitov <ast@fb.com>, <bpf@vger.kernel.org>
CC:     Andrii Nakryiko <andrii@kernel.org>,
        Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210413153408.3027270-1-yhs@fb.com>
 <26309b44-e719-2fed-6feb-397389985d2b@fb.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4613b735-d9ea-cc28-0286-b83726137d18@fb.com>
Date:   Thu, 15 Apr 2021 20:59:16 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
In-Reply-To: <26309b44-e719-2fed-6feb-397389985d2b@fb.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:6d8]
X-ClientProxiedBy: MW4PR02CA0030.namprd02.prod.outlook.com
 (2603:10b6:303:80::25) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::112e] (2620:10d:c090:400::5:6d8) by MW4PR02CA0030.namprd02.prod.outlook.com (2603:10b6:303:80::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Fri, 16 Apr 2021 03:59:18 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 59593f56-843c-47b6-2712-08d9008c02d0
X-MS-TrafficTypeDiagnostic: SA0PR15MB3917:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA0PR15MB39171A6A9255D143B256F318D34C9@SA0PR15MB3917.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DRYxCcQ/oyKU0/WlAbcD6QYW+K7Q6vKnt55fYJFkdyfsZl93QtQeuCDlu+UJMyIJ6MnlNDAIpQVVXm7MShj6CRusSVytT+ssFh1HFnOYDCLnGRXNwegZfJ79dDJ1iDnsYzFtEw8XlPdDQdzWNMRn37R12ByNHk+AIb7+pd4Nq+ZDkh5Bfqha6rEx89dWZy2cl60uoqY5lJAiXI5EyifogfTBim8iQNpBvciZ/wRQpMyNRgNiRtJOzqv0teJYCXN8RKup/GyRX6j+XDJ513BBXqjhSIGxCuPkqQO5aBWgx8wNq2OaRZPPtfrqEEBulo4MoeQewT2A6K33sK6L32DDA/LQmWugHVe3cY1t0ak6OuAHI5KJu8V4zcXmJasazBdld4AP4gH97bvZz5Ca0dtTuYcXZqY0ol/dbaXJfhauv28PKhEOGViyaLSTIXNWIAglo5eTR2besyDt9lxZDUWXe++pKYkHYD+muGu5D4KJEMBh6jgqwvVw5infIIgwzndelC0imEwHhMD4xIJNWpvsVmlCfLQF0uDkeYDtZwjpMhSDl/UYfkDly6MCzZOD9OO6SR0BvdydDPo7TZ4ZJneWwrgM1SIw3jev51fc/z3Nw+Fs4GkNc8MJSEZvVv3cJqLNaKwJ3fP4GmsBzP3cCYb/yfiGeXX7dBpJykdbDYUGK0TjaduRXL0vYiSr8tVrB2NWBlmFnBpm3KY3LfJShlNscu8Ky8/7WIp20ABfoMtxQnBv3vR/git4FbmqUXiokj9YQLHJoIZ+tfOqw4Dj0vORbw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(39860400002)(136003)(396003)(346002)(376002)(8936002)(36756003)(66556008)(83380400001)(186003)(2616005)(86362001)(66946007)(2906002)(38100700002)(316002)(16526019)(966005)(52116002)(66476007)(8676002)(31686004)(478600001)(31696002)(54906003)(4326008)(6486002)(53546011)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?L3J3VFNxS1Q3eXpQQ3krbHhDSlF5V0NjMFEzZTc3aGZtNGhuOVZZb0RnM3ZE?=
 =?utf-8?B?ZkZhOVVPNmFPSGU3alljMXY0UXE4M3J3VjZONFZpODhCWDFXTjhzSitiZ2gx?=
 =?utf-8?B?UHVXMWR4Y3dPblNCTWdNaXROUWlNYzViME8wZzZFV2l3RStXamwrOE9HcGE4?=
 =?utf-8?B?bzJ4SGEwSzNzL3BDRllTZUhQZE10cWdNNytWeTN5OFBmaXdEOXpsajVTR2lI?=
 =?utf-8?B?KzVva1o3ckJnRnBMbnpySEFsZUJZQUlVaVVRSUlrV0VFL3RzVzhIZG5FQmZt?=
 =?utf-8?B?K2lJbUpLS1E2UU0zNVhmQ3Zza2QzVks1QWNwYURiZnFRM0NtMGE5N2JpNDZ0?=
 =?utf-8?B?VzJwRmlhUjhJS3EyMDR3ZWhxeHpwTXg2YWh1R0JRS3hUVHBGeWJGTVRXTFF1?=
 =?utf-8?B?ZkVTRVQ4RjZyOTBZc0FSVUlMWk5QUFloRVJVajg4aFg3ZHFubDNiWGkybWRN?=
 =?utf-8?B?dk9NcGsrb1RoOG5rbFJxYnN4T08xeHhUbHNCb3RTM25iaHNyNWdSY0xrRXMw?=
 =?utf-8?B?TlJWYnM4Qjd6U3FRMy9SL0t3em9Nc25uMDAvbEs2a0k1V3pGMHd0blAxS3hj?=
 =?utf-8?B?b0UwUjR4ZVNrWmZzQXdBYjJncmtpSUY3N0ZiejF2K2k4RWxBOEM4bDUvaXlI?=
 =?utf-8?B?Zy96WGNyRmN4Q2VJV241UmtBdGxEWHhoUFk1WiswTGFSQmVXdnI5M1BlTGJi?=
 =?utf-8?B?Uys3b2F2b29BckYwdHJCZll6Z3NsbTBRNGR6elZ1eVltbGZTV0lJYU5HRUcy?=
 =?utf-8?B?bFhoUmd3QWJOUFkrRDR2VzNhRCt1c0NTVG1kU1JUZ1ZqUnVKeWtUaWZiQ05U?=
 =?utf-8?B?c2tPbkV1Y2VMRERQa05tcks4K09zQTNGaEk5ZDB6NDg1MzVRcHl6VnV4TUdM?=
 =?utf-8?B?RFl3VDRONE1hMmpBb0p0UnVybnBJVUpicVc0TmJCem95eGgzdXJ6MTF0a1dQ?=
 =?utf-8?B?WnhDZXpjNjRDZDBuamZPbVo0QS8wUFdibU00eXgxYjZmdnJPbTIyMWh3S1NZ?=
 =?utf-8?B?UkJ1U01GdytWWE5NcGhWZkU3TlY4dGx1UTdtYWUwMmZxSVFnYm1LRU5iUjBI?=
 =?utf-8?B?OWFEaHpYTmJ0c3NZZVViYWNUeDlCZFVqZ1oyMkNjRXNuaXJyakpTYlZHeDdw?=
 =?utf-8?B?SHN2VkdOMis0WnVjT3UydUlwWE5CdGpoZCtmOGFOSFR3QndQczhxOXZWVWlG?=
 =?utf-8?B?dmVsZVZTWlRoZFRjRTFaUzJJR1Z0TmJldkRsbDM3M0RFaXp1WjBOb2dzZU1L?=
 =?utf-8?B?SUZCYTRCckFxVU02MTZyTzFOUkdkSG9ON1Ewb1Fid1QreVEzZHRSeEgxR2ls?=
 =?utf-8?B?RmxNc1VkVmRqRXdTQ04wbzNMbmZLTXNUQlBCSXZvbUFhUmtsbXREYzg1WUlw?=
 =?utf-8?B?ODc5eSs5ZUx2UDFOOG9BUTEyVTY2NGpSelZrcWh0S1oxcVNtUDRnK1owdmE0?=
 =?utf-8?B?ME1hN2dTVDVxUHFNTlZJV3lEVTJrcEZuSy95ZGwwQXVPWExjZDRZZGZ5aVh6?=
 =?utf-8?B?ZElLeEVvS29aZU02d245aVNtcmtRc2tSSVJkUkVnNENMTmxHbzNlbXlPNUt0?=
 =?utf-8?B?eWxTT1lMM095VjdtZkNTRmtWYTZENEpHalNqQkVVWUhFVmFjQ2NWSU5kdEY1?=
 =?utf-8?B?VFdGaGtrcFBqZ1puRE1mNzI4UDVpdHlIYUxDRkFZUWppQUdMWDZoUE9QM0cx?=
 =?utf-8?B?VmROR3dOUDl5dGRXRytESzJvbC9OQ0E5MUxCNWV0MVlYV2xMOG9UVm4zTGxI?=
 =?utf-8?B?R3RySGN1QW90TGlUOFFqUlI4dHVoVHZ1MDgzdWZXeHZlbVIxRFhseTcrQURU?=
 =?utf-8?B?NGoyS2dtMUYxamt3ZnIzQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 59593f56-843c-47b6-2712-08d9008c02d0
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 03:59:19.5421
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sgeuGjDItzK6Ntt2vkUdaB3tfHyb/GaKaOVfPjOjH3A0NqNIIyWWwHAS+QTks0Wr
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3917
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: DiaQJ8uDueeVdvd0p4lRmlzW0Ic9V5h-
X-Proofpoint-GUID: DiaQJ8uDueeVdvd0p4lRmlzW0Ic9V5h-
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-15_11:2021-04-15,2021-04-15 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 spamscore=0 phishscore=0
 priorityscore=1501 mlxscore=0 bulkscore=0 suspectscore=0 clxscore=1015
 malwarescore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2104060000 definitions=main-2104160028
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/15/21 5:21 PM, Alexei Starovoitov wrote:
> On 4/13/21 8:34 AM, Yonghong Song wrote:
>> To build kernel with clang, people typically use
>>    make -j60 LLVM=1 LLVM_IAS=1
>> LLVM_IAS=1 is not required for non-LTO build but
>> is required for LTO build. In my environment,
>> I am always having LLVM_IAS=1 regardless of
>> whether LTO is enabled or not.
>>
>> After kernel is build with clang, the following command
>> can be used to build selftests with clang:
>>    make -j60 -C tools/testing/selftests/bpf LLVM=1 LLVM_IAS=1
>>
>> I am using latest bpf-next kernel code base and
>> latest clang built from source from
>>    https://github.com/llvm/llvm-project.git
>> Using earlier version of llvm may have compilation errors, see
>>    tools/testing/selftests/bpf
>> due to continuous development in llvm bpf features and selftests
>> to use these features.
>>
>> To run bpf selftest properly, you need have certain necessary
>> kernel configs like at:
>>    bpf-next:tools/testing/selftests/bpf/config
>> (not that this is not a complete .config file and some other configs
>>   might still be needed.)
>>
>> Currently, using the above command, some compilations
>> still use gcc and there are also compilation errors and warnings.
>> This patch set intends to fix these issues.
>> Patch #1 and #2 fixed the issue so clang/clang++ is
>> used instead of gcc/g++. Patch #3 fixed a compilation
>> failure. Patch #4 and #5 fixed various compiler warnings.
>>
>> Changelog:
>>    v2 -> v3:
>>      . more test environment description in cover letter. (Sedat)
>>      . use a different fix, but similar to other use in selftests/bpf
>>        Makefile, to exclude header files from CXX compilation command
>>        line. (Andrii)
>>      . fix codes instead of adding -Wno-format-security. (Andrii)
> 
> I struggled to tweak my llvm setup, but at the end it compiled and
> selftests/bpf/test_progs passed compiled by clang,
> so I've applied to bpf-next.
> 
> The things I've seen:
> 1.
> include <iostream> not found due to my setup quirks.

This header file is included by test_cpp.cpp. Probably
some clang stdc++ setup issue.

> 2.
> diff selftests/bpf/tools/build/libbpf/libbpf_global_syms.tmp
> diff selftests/bpf/tools/build/libbpf/libbpf_versioned_syms.tmp
> btf__set_pointer_size
> btf__str_by_offset
> btf__type_by_id
> +LIBBPF_0.0.1
> +LIBBPF_0.0.2
> and this was happening with packaged llvm builds,
> but my own llvm build was fine, so I didn't debug further.

I am also use latest llvm as I can easily verify all selftests passed.

> 
> 3.
> clang-12: error: unsupported option '-mrecord-mcount' for target 
> 'x86_64-unknown-linux-gnu'
> due to kernel not built with clang.

Top level Makefile has
Makefile:  CC_FLAGS_FTRACE      += -mrecord-mcount
tools Makefile has some dependency on top level Makefile.

> 
> I suspect followups will be needed to make it bulletproof.

Definitely, Nick has libz issues, cross compile is not supported,
tools build depends on kernel build, both or neither with LLVM=1, ...
clang build got some traction recently and hopefully more people
can start to contribute to make the build process more robust.

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C53941B33A
	for <lists+bpf@lfdr.de>; Tue, 28 Sep 2021 17:46:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241080AbhI1PsV (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 28 Sep 2021 11:48:21 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:55496 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241649AbhI1PsV (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 28 Sep 2021 11:48:21 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 18SA4Cei024291;
        Tue, 28 Sep 2021 08:46:25 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fhzNgHeRHcNx1uMCSTN+NpRxarTZ84RkmzldnzaHmLQ=;
 b=aCPkHA1RpWCWlcfBsERfIufKxUp3ZTLZqUBtyIoooZV/0jl+2YIiXk+oPG39koReozgE
 M5izQkZgr4HP/HbofBX5SvQmx+WJ94hNcC/8NFoQCJHzWDszBbNairv5LHYEL5pKfMzN
 s194tyUDegCyJhLngZhC4NaTpeyapluZ67U= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 3bbq81wm8w-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 28 Sep 2021 08:46:24 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.14; Tue, 28 Sep 2021 08:46:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6Ay8X4+XsZNtSBIA5ycpRCRkeZMmKJCOgwi/W9S/FK2NRTRjq+f+pjfBjg5+pPztFi+u7lPql2iRtxTfZjwk99nUhJZHoQqssBTd2KWMghIbQ4PNQ1ajvjDTXba7nr5FVokOlFgU/wiTrXXCrNBY3CSua1Iz9qVc/xUnRRyh16kXRjAEvrHzBW2Dabowgd5LteGIhTJ1efiMc08ZT5rbvir5xcBG2QA/gh5s5vaVfdxI07pDwfNGFoxeVrrxvvtlsvUrLMqeu7EVeNXydFTxRE7zc+mTVXrMksDIa6A4ioaoYC0oF3ZrJe0/ynX2TweiVgX/Y1roMEExTdy+8O7ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=fhzNgHeRHcNx1uMCSTN+NpRxarTZ84RkmzldnzaHmLQ=;
 b=AwlqIsvx4WskCDEy3Oli/wsaVAWAt/YkuBSdHPP/PdK4fHLvLYUOzOaXGRxVnxwRwcfl1CAvVA+HIZBN13/9xxJVoEfiWA59wl6t4x/Iu6WRjZdNpGVD/gCdoaumqdv/dzn0VmyDa7eUiljxiqn5dNS8t8E7gqecCtaZMEfNHb2wzTNVOBcYsZMC8w+SgGZ1F1zvC//FQMqK5qqKiTUQdXRq9SCvqBBLDqsjgZdEP2MmdjO9dOGgE5VK+F6fsE/SRwhH6uyuhdzK0vhDrko3jgRYlA2E4tS0/+KisomaiuehbF/RPTxK8nnOmLCRI355k/G2FMyvKI0D+/zefcr/Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB2160.namprd15.prod.outlook.com (2603:10b6:805:9::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.14; Tue, 28 Sep
 2021 15:46:16 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::51ef:4b41:5aea:3f75%6]) with mapi id 15.20.4544.022; Tue, 28 Sep 2021
 15:46:16 +0000
Subject: Re: [PATCH bpf-next] selftests/bpf: fix probe_user test failure with
 clang build kernel
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210927170519.806505-1-yhs@fb.com>
 <CAEf4BzZG+qGoLdgtUTx208AP6MM4qMsBZE1Ua_in1ycA__QJEg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <c9d610e7-eb5b-ba8e-2b2d-6c37eea57ef7@fb.com>
Date:   Tue, 28 Sep 2021 08:46:14 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
In-Reply-To: <CAEf4BzZG+qGoLdgtUTx208AP6MM4qMsBZE1Ua_in1ycA__QJEg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0084.namprd05.prod.outlook.com
 (2603:10b6:a03:332::29) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
Received: from [IPv6:2620:10d:c085:21cf::1290] (2620:10d:c090:400::5:6295) by SJ0PR05CA0084.namprd05.prod.outlook.com (2603:10b6:a03:332::29) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4566.10 via Frontend Transport; Tue, 28 Sep 2021 15:46:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 05ba6da8-35bd-47c4-438f-08d982971b9c
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2160:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB2160244CEE62DC11A6CDEB34D3A89@SN6PR1501MB2160.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 03WAcq8cne5/HGzqSqHyrPL/K0B2jZ/2Gj24qlMp1mhGoozIivfL16vH8rYYtbj9XKEwbgM5PsiSLRbUDsi83wND4PytcfXopJQz9DkDE0OpOtpx4+9TZvkHW0tU0+WeV44YmKweYqzoKtBUR2mcypP0yZbKotZhzACFHAXvc9NP4L1z7a5BYcbex+aaEfqmJW28ME9yga9GXMMUjRJi7rvE3B8pvLPV2MiTdgyqGBlS5sYE08SCk1UlbpCz1sgUpC7mwplx/ZpkSpztoyc3iiY7QF261l7IaRwoB7DDn2ZkUjf7t6RFPo/1jUduIju1bf92VTypHNhIhyndHn1H7NCgTbuc1Ti9mRkWmB08GApBoB/savkZEuYfySl0aaVV+0CDV2OYKWxc1Z/FTcM3dj5lwYmIkFF321A+NgxnJgel1o+J9N0//0uJF26f5Ri7ldyBqJHr/MCijBwDPprFdoKDwclntdZ9tugax71dlP6s3bfawzCUcxLM12eJkDBEvF+Gzq3ajVdAgSO6lLiEuOis0+Mog6rCn5cQwCg8nwfqGdQNCBglq5bUj0Vkf2Yp7Qjk3LHm2cw2yeJG/aRLzKm4xHI2Wm7YZjU1iGJ06Dw0OppUxJJMquXsG777NGlOQRb5bl4qJWijztwyczM+GlGFQHSTOVtK0AfCdrv07r9ZdSp25h/mZu8G3xvl2ZfAbjloj32rZe9vxO2kEVaL5zed8CkNHAzGQ9h/Jp28AFk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(83380400001)(5660300002)(8936002)(66556008)(66946007)(66476007)(38100700002)(31696002)(86362001)(6486002)(31686004)(52116002)(508600001)(8676002)(4326008)(36756003)(186003)(2616005)(6916009)(2906002)(316002)(53546011)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmhlYjJZMzhDOXB3RERQODF3RVhlMTJodWF3ZTZZaVZhR2hGR0YyRE1XUXIz?=
 =?utf-8?B?dWRhQjdnQ0U4L0NJRU1POXdzd3NoRGUxOURmdlhnTjVqbmxCNVYrZUYvejRu?=
 =?utf-8?B?NkF2WS9rSHNTMTdrQnRTTitqaWdhTFdjUHBPaGs4UkJmWSsrQTZUaTBRNExv?=
 =?utf-8?B?MnRGSTNGK09wa2dENSs2RjNnQjFOUklDQTViNDI2cXU5am15OGF5Mys3WEJi?=
 =?utf-8?B?c2l3cmRpYWRMVXhhNURoMVJxTDlBdVFjL1RLMDlYU3kvQTVjMit2d0Z5MlNT?=
 =?utf-8?B?b3g4WjNiSnBNRDNZSUs2WlVGRDlGanRyVS90QzAxUi9maWdkMEdqajJ4KzNE?=
 =?utf-8?B?aUhRR1IyZmRXMDVMWDJBMmgrWEw1RXJXWm9PVkZCVHdpZnlmUk9qODdwS2d1?=
 =?utf-8?B?eDJHY05xZnNOa0sxU0ZjNUFMS3pRTmpvSlZ1NVIzRWNVNVlTZ0wrSVNCN0o2?=
 =?utf-8?B?SWE1d2wrTGlPZFlGL1pLTWpSS3FHb3RJaitzN0NrNWlyTXFqQkpuNjFIbHRI?=
 =?utf-8?B?enc5TWkwdzRmdmVJT1FlNDdwWUNzaFQ5RDl5dmM2MmlOQnFEa2psMXQ4eEI2?=
 =?utf-8?B?YXBZbUhKV0NaUDM1NkFzbVRqWHdPT093TmwzdFQ2dVV0L0xaWVp3V2Q0Nk9x?=
 =?utf-8?B?dGpPS1psK0Y2ZmtyN1hKVzdyYmNiaDcyaFNOUGRJNjgzblpFRXZ1ZzJsM2hr?=
 =?utf-8?B?dVgzR2ttSFJmN3RpOXVxRExpM2Y0L2kwWEZQejhMSklYV1J0WVRBODN3NCth?=
 =?utf-8?B?NmlMNDlIMVNnZC9mS0hqY0NTeGFJcDNBZjEySEswamU5MEJEdzAxaHFpa1pu?=
 =?utf-8?B?ZWdSKzNqaVMyY2tXRGRPWjlWVlNaWitpVWF6d3l0aXc0VXpaVDFQT1NGd2I0?=
 =?utf-8?B?RUpLTjZvUTJGYjhobkFLMTdyWDUyckYyMjR1dnZ2MGZzcldPeExkQWxEbzNl?=
 =?utf-8?B?djhOQm1rOGJjYXVzTGNTS2drSXJxR1M0akx4eUpkcFB2ZlUvQVhLVmF5QXY3?=
 =?utf-8?B?bjBhSVJNdlZLaTF2d0J1MlZBRmdRc1VFOU1OZ3lKeGtBWFZ2WktMMVE3OE9J?=
 =?utf-8?B?aDFmZk5xNHZrRHIyaW16Y054QjYyT1NHMkpQWXh5S2RNZzgzQW92aVdnQjkv?=
 =?utf-8?B?M3lxMjNJRkpDZ0lCNElDZ202YnY3Umk2cTdDWHlGQUovaHlJRlliTjQ5eUxk?=
 =?utf-8?B?OXRjTGFVRmVxdkM4WTN3N0FYbTBCNC8yTTZxaDBEazNQSkdCNG1NUThpZHJH?=
 =?utf-8?B?Q1ZpYnE5bmxnOGN3MTJPcXJZZDZ1bkNFSzcyWHpLL2luTGdocm0yN1JUdCtz?=
 =?utf-8?B?Y1diL09qSzBGRFJnUjVaZ2VocXQvVldLSUl3Q0Jac1JOdGRrNEJSdy9BSFlk?=
 =?utf-8?B?bkJMaC9Ubkk4UEZ1eWpUZUk4NURpYzMvYkxIaHBWS3kzUlJ4em90Z3R6b2pi?=
 =?utf-8?B?L081eEhMNjV6aUc2NmdnRFlKT3RuSmo1bzZlVFBqdktqNmE5RzhTd1VrcVYx?=
 =?utf-8?B?UFVCR2JXRHREUzhyTlRJcHN6ZTIvUWJWTURTRWZ2SG5iYm14a1BkMFRGUW9I?=
 =?utf-8?B?L2dabWtJbG1hVklPaW9oc01IRVlwZHh5Q1hRTWhrc1FZb0laVy9QYmZkWEFU?=
 =?utf-8?B?L0FOLzNpTWdqVWxzditFaEhoOTRSd25zOFREQ1hiVmJONzBPbFhuc2pQdm0r?=
 =?utf-8?B?SEtrbmdNTTVOQjhUaTkrWkNud1BXYVVPZUE3SklVMzNpbUc0RVd5SUhpSytI?=
 =?utf-8?B?L2Rick10WnBobFltV1hwY2F5R0Y1S0dDY0hzTEJuaWRQVTlYNGU2R2hObEdY?=
 =?utf-8?B?ZHZtclFjaXI1cHRLSXNGZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 05ba6da8-35bd-47c4-438f-08d982971b9c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2021 15:46:16.6453
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVkD1FFjKUUDqryd/U7bXr3W7kzR4XrnMITDzo2KLUMryANgD+OJqBp0cc4haeW9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB2160
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: TGL5DPzBVFAV_D9-sLdMItUz_re9Mj_F
X-Proofpoint-GUID: TGL5DPzBVFAV_D9-sLdMItUz_re9Mj_F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.182.1,Aquarius:18.0.790,Hydra:6.0.391,FMLib:17.0.607.475
 definitions=2021-09-28_05,2021-09-28_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 clxscore=1015 mlxscore=0 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 mlxlogscore=999 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2109280091
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 9/27/21 10:11 PM, Andrii Nakryiko wrote:
> On Mon, Sep 27, 2021 at 10:05 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> clang build kernel failed the selftest probe_user.
>>    $ ./test_progs -t probe_user
>>    $ ...
>>    $ test_probe_user:PASS:get_kprobe_res 0 nsec
>>    $ test_probe_user:FAIL:check_kprobe_res wrong kprobe res from probe read: 0.0.0.0:0
>>    $ #94 probe_user:FAIL
>>
>> The test attached to kernel function __sys_connect(). In net/socket.c, we have
>>    int __sys_connect(int fd, struct sockaddr __user *uservaddr, int addrlen)
>>    {
>>          ......
>>    }
>>    ...
>>    SYSCALL_DEFINE3(connect, int, fd, struct sockaddr __user *, uservaddr,
>>                    int, addrlen)
>>    {
>>          return __sys_connect(fd, uservaddr, addrlen);
>>    }
>>
>> The gcc compiler (8.5.0) does not inline __sys_connect() in syscall entry
>> function. But latest clang trunk did the inlining. So the bpf program
>> is not triggered.
>>
>> To make the test more reliable, let us kprobe the syscall entry function
>> instead. But x86_64, arm64 and s390 has syscall wrapper and they have
>> to be handled specially. I also changed the test to use vmlinux.h and CORE
>> to accommodate relocatable pt_regs structure, similar to
>> samples/bpf/test_probe_write_user_kern.c.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   .../selftests/bpf/prog_tests/probe_user.c     |  4 +--
>>   .../selftests/bpf/progs/test_probe_user.c     | 30 +++++++++++++++----
>>   2 files changed, 26 insertions(+), 8 deletions(-)
>>
>> diff --git a/tools/testing/selftests/bpf/prog_tests/probe_user.c b/tools/testing/selftests/bpf/prog_tests/probe_user.c
>> index 95bd12097358..52fe157e2a90 100644
>> --- a/tools/testing/selftests/bpf/prog_tests/probe_user.c
>> +++ b/tools/testing/selftests/bpf/prog_tests/probe_user.c
>> @@ -3,7 +3,7 @@
>>
>>   void test_probe_user(void)
>>   {
>> -       const char *prog_name = "kprobe/__sys_connect";
>> +       const char *prog_name = "handle_sys_connect";
>>          const char *obj_file = "./test_probe_user.o";
>>          DECLARE_LIBBPF_OPTS(bpf_object_open_opts, opts, );
>>          int err, results_map_fd, sock_fd, duration = 0;
>> @@ -18,7 +18,7 @@ void test_probe_user(void)
>>          if (!ASSERT_OK_PTR(obj, "obj_open_file"))
>>                  return;
>>
>> -       kprobe_prog = bpf_object__find_program_by_title(obj, prog_name);
>> +       kprobe_prog = bpf_object__find_program_by_name(obj, prog_name);
>>          if (CHECK(!kprobe_prog, "find_probe",
>>                    "prog '%s' not found\n", prog_name))
>>                  goto cleanup;
>> diff --git a/tools/testing/selftests/bpf/progs/test_probe_user.c b/tools/testing/selftests/bpf/progs/test_probe_user.c
>> index 89b3532ccc75..9b3ddbf6289d 100644
>> --- a/tools/testing/selftests/bpf/progs/test_probe_user.c
>> +++ b/tools/testing/selftests/bpf/progs/test_probe_user.c
>> @@ -1,21 +1,39 @@
>>   // SPDX-License-Identifier: GPL-2.0
>>
>> -#include <linux/ptrace.h>
>> -#include <linux/bpf.h>
>> -
>> -#include <netinet/in.h>
>> +#include "vmlinux.h"
>>
>>   #include <bpf/bpf_helpers.h>
>> +#include <bpf/bpf_core_read.h>
>>   #include <bpf/bpf_tracing.h>
>>
>> +#if defined(__TARGET_ARCH_x86)
> 
> I mangled this check (locally) to test the #else case, and it failed
> compilation:
> 
> progs/test_probe_user.c:24:15: error: expected ')'
> SEC("kprobe/" SYS_PREFIX "sys_connect")
> 
> adding #define SYS_PREFIX "" fixes the issue.
> 
> But I'm also curious:
> 
> 1. do we need all this arch-specific logic? maybe we can find some
> other and more stable interface to attach to? e.g., would
> move_addr_to_kernel() work? it's a global function, so it shouldn't be
> inlined, right? Or did you intend to also demo the use of
> PT_REGS_PARM1_CORE() with this?

The following are move_add_to_kernel() call usages:

fs/io_uring.c:  return move_addr_to_kernel(conn->addr, conn->addr_len, 
&io->address);
fs/io_uring.c:          ret = move_addr_to_kernel(req->connect.addr,
include/linux/socket.h:extern int move_addr_to_kernel(void __user 
*uaddr, int ulen, struct sockaddr_storage *kaddr);
net/compat.c:                   err = 
move_addr_to_kernel(compat_ptr(msg.msg_name),
net/socket.c: * move_addr_to_kernel     -       copy a socket address 
into kernel space
net/socket.c:int move_addr_to_kernel(void __user *uaddr, int ulen, 
struct sockaddr_storage *kaddr)
net/socket.c:           err = move_addr_to_kernel(umyaddr, addrlen, 
&address);
net/socket.c:           ret = move_addr_to_kernel(uservaddr, addrlen, 
&address);
net/socket.c:           err = move_addr_to_kernel(addr, addr_len, &address);
net/socket.c:                   err = move_addr_to_kernel(msg.msg_name,

inlining could happen within net/socket.c. Another two use cases are
fs/io_uring.c and net/compat.c. Using compat syscall may be too complex, 
I assume. Using io_uring with bpf selftest may be a choice but I think
it makes thing too complicated.

More importantly, assuming in the future the kernel may be compiled
with LTO, move_addr_to_kernel() might be inlined into fs/io_uring.c.
So that is the main reason I am using syscall entry point directly.

You are right, vmlinux.h is generated from the very kernel we are 
testing so we don't need CORE. I added CORE similar to
samples/bpf/test_probe_write_user_kern.c, but it is not really
needed here.

> 
> 2. global .rodata variable isn't really necessary. Static one would
> work just fine and would be eliminated by the compiler at compilation
> time. Or equivalently just doing #define SYS_WRAPPER 1 for all cases
> but #else would work as well. I don't mind global var, but I'm just
> curious if you explicitly wanted to test .rodata global variable in
> this case?

Good point. This test is not to test .rodata variable. So using macro
to differentiate different cases is actually better.

> 
> 
>> +volatile const int syscall_wrapper = 1;
>> +#define SYS_PREFIX "__x64_"
>> +#elif defined(__TARGET_ARCH_s390)
>> +volatile const int syscall_wrapper = 1;
>> +#define SYS_PREFIX "__s390x_"
>> +#elif defined(__TARGET_ARCH_arm64)
>> +volatile const int syscall_wrapper = 1;
>> +#define SYS_PREFIX "__arm64_"
>> +#else
>> +volatile const int syscall_wrapper = 0;
>> +#endif
>> +
>>   static struct sockaddr_in old;
>>
>> -SEC("kprobe/__sys_connect")
>> +SEC("kprobe/" SYS_PREFIX "sys_connect")
>>   int BPF_KPROBE(handle_sys_connect)
>>   {
>> -       void *ptr = (void *)PT_REGS_PARM2(ctx);
>> +       void *ptr;
>>          struct sockaddr_in new;
>>
>> +       if (syscall_wrapper == 0) {
>> +               ptr = (void *)PT_REGS_PARM2_CORE(ctx);
>> +       } else {
>> +               struct pt_regs *real_regs = (struct pt_regs *)PT_REGS_PARM1_CORE(ctx);
>> +               ptr = (void *)PT_REGS_PARM2_CORE(real_regs);
>> +       }
>> +
>>          bpf_probe_read_user(&old, sizeof(old), ptr);
>>          __builtin_memset(&new, 0xab, sizeof(new));
>>          bpf_probe_write_user(ptr, &new, sizeof(new));
>> --
>> 2.30.2
>>

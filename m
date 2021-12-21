Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D40547C937
	for <lists+bpf@lfdr.de>; Tue, 21 Dec 2021 23:29:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237869AbhLUW3u (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 21 Dec 2021 17:29:50 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:52020 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230085AbhLUW3u (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 21 Dec 2021 17:29:50 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1BLJ12xP008343;
        Tue, 21 Dec 2021 14:29:34 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=O+Ee7L5J6Dz30RtAyTcdLmZdpVJ4Fa8lS8m189cliS0=;
 b=VL45tuDvJkNvxMe+/rX+240iE1cGKWC/m00VJVoy66YAP6A75xzf+YTlh9duiCoeGy1l
 Asvri7O9YdO1nR7388DDlbQGXY8beZ0UpcVCINstNJrG2Q5Wvsk8SHcTtMR3Gyo8I2ZD
 FZXbzgZBvv5BCh4BdKHLRtkyYq4af7dhEOw= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3d3mq3hex1-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 21 Dec 2021 14:29:34 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Tue, 21 Dec 2021 14:29:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jREe+HvNzBwOcT8uFpUvr6QqVFzNKHtO55MgBWeh36UKg8tzevwV6zidPdg+PzlIZQfIFmYI3wFi4ioZHm9J/8o0Y1ge1heci89Xag+ZGbAUnfVM/uaUydMFY1o3L+RzYVcZ06iPH83HGGvzve+2DqGRZQYGXLsxbEFmiuVbVnXdgUe8nKabLBidNQoHe8CsSQ6JLEin3SClcFqapWu04qQL47nzzmYkb4vNyVuFXpLRn3kSlAeGgiOsK03H60Q/skfXMLXWw5lTff7YF6yeJj32YrTr3EipGPVFcgOiTKVeuwcl7V1ZQ215grczre2nqh9AttuQcqZtgopXZ/USvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O+Ee7L5J6Dz30RtAyTcdLmZdpVJ4Fa8lS8m189cliS0=;
 b=Mbv0E0LiSpkGajECrMKUep4RD+XLasbNyOvoyrNHHQP2SA0SSKRxBXl3KBIbSO8s99Ne65On0qT2R2+SqTAnQUiPwtKzPJnxngWg6q+WCmd7b8f6R3U2W26HplNLJMSmNO+trnuBvaKnePySfuxeMrjwT+CVcZIxJ5mVMFWr/XkwiULSyF4pj9OH8z15/QzqmRmAh728/88duk1CbUxnluIZEAD9ns0NhIK+aAZ4Ta446ZPP2ImLgzVAr5ng84D/QnrYPLQFQd/m6rhKkEV5Gno42Lr77diHbg429chJLE/mq2ghfQUF9+ofOPeg8mpeHp/2gapdNRerQctFudEZdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3920.namprd15.prod.outlook.com (2603:10b6:806:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.15; Tue, 21 Dec
 2021 22:29:30 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::b4ef:3f1:c561:fc26%5]) with mapi id 15.20.4801.020; Tue, 21 Dec 2021
 22:29:30 +0000
Message-ID: <c623076f-af72-db05-f9b5-cfedc0a517ac@fb.com>
Date:   Tue, 21 Dec 2021 14:29:26 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH bpf-next] bpf/selftests: Test bpf_d_path on rdonly_mem.
Content-Language: en-US
To:     Hao Luo <haoluo@google.com>
CC:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>,
        KP Singh <kpsingh@kernel.org>, <bpf@vger.kernel.org>
References: <20211220201204.653248-1-haoluo@google.com>
 <cd32b6d2-bbca-7442-419a-653f0fb5c3c7@fb.com>
 <CA+khW7iVPr-AWZwD61MkZHUhPowOVK98qMPnkhAh-GCRncSJEA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CA+khW7iVPr-AWZwD61MkZHUhPowOVK98qMPnkhAh-GCRncSJEA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MWHPR04CA0072.namprd04.prod.outlook.com
 (2603:10b6:300:6c::34) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eae15363-6efd-4543-8b7d-08d9c4d15b01
X-MS-TrafficTypeDiagnostic: SA0PR15MB3920:EE_
X-Microsoft-Antispam-PRVS: <SA0PR15MB39206EC40799FFB1589DE8C6D37C9@SA0PR15MB3920.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8r5CBQHjUmWF6KZak2sJmYeO6ybRjhube6IOaNEeYTtKuupyanjOzRnx+U8/BwCB1sbm2bY8eMrVsY9olndX2MAZFugHxABdG4veowmlpDtrTGdtYilrtQuAiWLD2t1arhFRhZu0r593W7/H7E3Vxt+RtQ+/Ka5hwap/YkjlVr/8t1LrrXOfRcVWJKtRZNj3jV78EYUOVZHFjPxVDY7eIzCYTgXVWRuRn6r5RZoDA76+K3gwfpdXBAQzOuQ+DXFxRMuU1bw7MCMUxH2Tl9K1HB8XN7NuFMdjlioJ4slAvdN4T5p9f42iGmy4uI7XBIp483wGfzm8CFaCzUuJal/BM8bVMO9lJk8dnZV8yCgrvKpSEGp3he40KnIrALDHzmkGIeLqxSUkqfz34wzQu8QzSyHVmKZ5zwAJ6MBrSTeyaFlh7yWMQ3SzEqB/LL7beSVbwTcQunwsseAq50Tw+NAO0TiHQSwBpckuB+KumsOFACV2kiRzt4/DKM3YNeg/cX+RKJjKpYTucSGU7TfxUMulblAFNiFlsSDb3PPLN4UR8MzmCzM9JPKWHYfqlPkLTeo91gELPZhL5jLwLFIYaXLkL5becb98hSyemO7bLOXrpk6CZ/2ju+/B64ozYgMu90e0VqMYo7DXvGd4tQXk2ZWUs8q9FbijyLjilV2m52Io/7jvb/cs2mq+HP0iMO2ilQ8+YWD72n5X+006MzEnE5/V2ZsCzyBTmuu8uk8u4JXNOx4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66476007)(8936002)(52116002)(6666004)(6506007)(31696002)(83380400001)(316002)(66556008)(6916009)(508600001)(54906003)(86362001)(53546011)(2906002)(38100700002)(36756003)(66946007)(31686004)(6512007)(5660300002)(6486002)(2616005)(186003)(4326008)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N3BYN01rUXFLNDV0VTN1ZUFkMmVXZldJUnhmc2J3Ry9jSUFpbmtCeHoraUNi?=
 =?utf-8?B?UllSZ2FmeFFKZXpjcWtKRXRaY25Oby9ibkV0U09vcWFKTWdTSFpOSzBHeG8z?=
 =?utf-8?B?SjgzNXVEdlNhQVF2VC9kc3BJQ3lHNCtoMzUzdTBaY1piNVk2SllzWWh6TjUx?=
 =?utf-8?B?Z3k4UTZmQWw3akhpSUM4ZGF6cWxTTlM1R2xCaXVBOGExSG82T3Z4UXpWODJs?=
 =?utf-8?B?WEZPV3JlMnpRUUE5c25Sby9ub0k3aisvQ053cjhSd3F4cGlRMHgrOXdyZDdi?=
 =?utf-8?B?M0Rrb1d5UkZXaUJlMHY4R01CL05qRkVGZ1ZCSjZrVVJPV1V5aVpzWnVVMWdW?=
 =?utf-8?B?N2NUTU1xYkl6SzZpbzJ6cmltcnFqTzNteEZjNDF2UlFSc1pGR1ZVblNBSVVs?=
 =?utf-8?B?dVp6Uy9ReTdVa0pTS0NCQ2dxSDh1M2pPem5MblYvU1R4MTA0WlpzSW4xS0Rw?=
 =?utf-8?B?eUZOQm1kNERHczdSd05xVEQ2MDVabkZ6b3RwYXdsczBHZ0M3R09IUHFQTEsz?=
 =?utf-8?B?ZXdRZERIOEZ0S3NLclZLWnR2WmxrVlZkU2tmcm1xVWpOQVB5b1dYWFh6ZFpF?=
 =?utf-8?B?dEd5Z2szR2s4YzhBVkxqUFNMYXB4bGsxS0c0dWZwZG5ROVpYZVVRakYxaWhY?=
 =?utf-8?B?REkyOFduZVdHS3QvU0pNQXBOUHRGcG1WUC9SWkk4eUdoUDgxaXlEb2VPUEw1?=
 =?utf-8?B?dUYzZitnaDZTb0N3T0hBT0RPYXJSMERNdTZTQW1LSlVxL0o0MVRDYmhsTkwr?=
 =?utf-8?B?SW96RUxpVUt2TjdqamtjWXliNXJEZUN4bkxSTkgwVkVSZ3R5cXE5SkE2RHRO?=
 =?utf-8?B?bjA4cDQ5V0NpMk5lTGRRRGlqdkl0TVlsNW1IWmhFdTZMZm9TRXp5UUZ0eG5m?=
 =?utf-8?B?cHpFVGx5M1p6eEZKV29tUndGQ0dYSVNkZDl6bU9CVkJpZzNKR0hkKytVWElv?=
 =?utf-8?B?V1dhTUs3OW83VU9Pa1F5S05sSnBkQUhGSnREMHVVN2pSK2dVNlc1dVZ2dXg3?=
 =?utf-8?B?VXh1WWowZXlBU2lmcGszbmtUalN0WHBhbnR3Ny9sRXlhRjd3V3E0SnJjUG5V?=
 =?utf-8?B?a3U2OCtpM2RkRUxHT0VMYkw2bzY0TGllcmdrNGN6VFRWY0lWdjRsSm5DSUYx?=
 =?utf-8?B?MG9NdFVTcHc2d08yVHc1QjAxOVZWbERGYXJzQTJ0aUUwbkV3NTRXNmlYNlFh?=
 =?utf-8?B?TmtxNkd6aVQrRmpYMUNRYlAzS083ai85andQa3dZZUpOQTkyOUR6S2FvVVR6?=
 =?utf-8?B?RVR4b0lWQ1pZNEJaTzlDbncyU3lldlowQzBWQmhOdUdmR0pHdnhnNWVDUjNO?=
 =?utf-8?B?QjQxcEhEWEgzeGJSd2tvY1ptcGxVY2FqajJVbm12OWNNVTg1RW1MWmtlVG1h?=
 =?utf-8?B?M2N6VFZVUHJwOU15a1YzcFV3NDl6dDdDL0pDdjY1dXVYTm1UTzhLcTZhMnRB?=
 =?utf-8?B?U0UxaFloeitUa0kwa1ArdTcxQmFZbzdmZTNqL0Nud0xaU1ZjQlY4aFV3bFBk?=
 =?utf-8?B?UVV3Nm5rLzF6c2lWN0l3eCtSR3cvWGhYaTVkWTFYeExNa3ZlUVVMWUFzSVBm?=
 =?utf-8?B?L2NOKzh4OFVzdmFKR2JMU0M1U3hEMlFkbE5OakhvdXFnL1NnODA1NXlIeEtW?=
 =?utf-8?B?UlNMcEo1ZC9yMXc2WTlqUnRKWTBlMkRZUFFYcGlpQkFaelVOVGJkek0wKzJp?=
 =?utf-8?B?aU56aFFldzFxejZsTjE1MHhpUXF3Wm01ZnMzVCtVZzZmOEs4YXpsWlZIQWwv?=
 =?utf-8?B?cjliQ08wMEtxaVdsdy9GeUYwa1NUYWRqaFBkR2lrdWFCUkwzT2FtbmlhclVj?=
 =?utf-8?B?UjdQRVY2Y3RMdHlrT3kxRzZBVVVaUTR0WXo3WlhJKzhIVlBkMXQrTVV6QlRy?=
 =?utf-8?B?ai9yd1pWaVB6bWg5UlBKeUlRc24zTTRUekNIZXp1bys1a2hVMDhwNnlvVVUz?=
 =?utf-8?B?cEM4M3l1RmFwS2g4TW05OGNoTzZKVzZHRzFvSGRHdFA4ZXpmUjRhSDFIY1BI?=
 =?utf-8?B?RG9rU1ZOWXFKWXl5b3BrUFl3d1ZIRUVKU0ZsTDFhTW5jZ3Zlb3FsMlI5WTBk?=
 =?utf-8?B?WFQ3VjdLMW5vYXQxOWVvUVcvamx4SUI4ZFk1ZSt5Q2I5T1BiekNHOHN1S0F1?=
 =?utf-8?Q?BLUx6PkWGVC1o2RL0j2ZRjOmJ?=
X-MS-Exchange-CrossTenant-Network-Message-Id: eae15363-6efd-4543-8b7d-08d9c4d15b01
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2021 22:29:30.5703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oVzaVc97fERAg3wDKVHqFkmwYGvehNlGN5rx0/cWN6EK9rZtnwywa85RGsL2u6gs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3920
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: u8_Xjc3733n261VRpNh_rKak-0aJM0O5
X-Proofpoint-GUID: u8_Xjc3733n261VRpNh_rKak-0aJM0O5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2021-12-21_06,2021-12-21_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=fb_outbound_notspam policy=fb_outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 clxscore=1015 priorityscore=1501
 suspectscore=0 spamscore=0 impostorscore=0 mlxscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2110150000 definitions=main-2112210111
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/21/21 12:16 PM, Hao Luo wrote:
> On Mon, Dec 20, 2021 at 8:28 PM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 12/20/21 12:12 PM, Hao Luo wrote:
>>> The second parameter of bpf_d_path() can only accept writable
>>> memories. rdonly_mem obtained from bpf_per_cpu_ptr() can not
>>> be passed into bpf_d_path for modification. This patch adds
>>> a selftest to verify this behavior.
>>>
>>> Signed-off-by: Hao Luo <haoluo@google.com>
>>> ---
>>>    .../testing/selftests/bpf/prog_tests/d_path.c | 22 +++++++++++++-
>>>    .../bpf/progs/test_d_path_check_rdonly_mem.c  | 30 +++++++++++++++++++
>>>    2 files changed, 51 insertions(+), 1 deletion(-)
>>>    create mode 100644 tools/testing/selftests/bpf/progs/test_d_path_check_rdonly_mem.c
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/d_path.c b/tools/testing/selftests/bpf/prog_tests/d_path.c
>>> index 0a577a248d34..f8d8c5a5dfba 100644
>>> --- a/tools/testing/selftests/bpf/prog_tests/d_path.c
>>> +++ b/tools/testing/selftests/bpf/prog_tests/d_path.c
>>> @@ -9,6 +9,7 @@
>>>    #define MAX_FILES           7
>>>
>>>    #include "test_d_path.skel.h"
>>> +#include "test_d_path_check_rdonly_mem.skel.h"
>>>
>>>    static int duration;
>>>
>>> @@ -99,7 +100,7 @@ static int trigger_fstat_events(pid_t pid)
>>>        return ret;
>>>    }
>>>
[...]
>>> +
>>> +extern const int bpf_prog_active __ksym;
>>> +
>>> +SEC("fentry/security_inode_getattr")
>>> +int BPF_PROG(d_path_check_rdonly_mem, struct path *path, struct kstat *stat,
>>> +          __u32 request_mask, unsigned int query_flags)
>>> +{
>>> +     char *active;
>>
>> int *active?
>> It may not matter since the program is rejected by the kernel but
>> with making it conforms to kernel definition we have one less thing
>> to worry about the verification.
>>
> 
> Because bpf_d_path() accepts 'char *' instead of 'int *', I need to
> cast 'active' to 'char *' somewhere, otherwise the compiler will issue
> a warning. To combine with your comment, maybe the following:
> 
> int *active;
> active = (int *)bpf_per_cpu_ptr(...);
> ...
> bpf_d_path(path, (char *)active, sizeof(int));

This is fine. Thanks!

> 
>>> +     __u32 cpu;
>>> +
>>> +     cpu = bpf_get_smp_processor_id();
>>> +     active = (char *)bpf_per_cpu_ptr(&bpf_prog_active, cpu);
>>
>> int *
>>
>>> +     if (active) {
>>> +             /* FAIL here! 'active' is a rdonly_mem. bpf helpers that
>>
>> 'active' points to readonly memory.
>>
> 
> Ack.
> 
[...]

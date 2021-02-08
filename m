Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B163314392
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 00:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230208AbhBHXOw (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 8 Feb 2021 18:14:52 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:11828 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S230340AbhBHXOr (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 8 Feb 2021 18:14:47 -0500
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.16.0.43/8.16.0.43) with SMTP id 118N51h3001538;
        Mon, 8 Feb 2021 15:13:50 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=b9oyDLu3KXkbx8vuAGLAl84Cgkfl/xeZCkZefpDUFJo=;
 b=QeXxU40ttcHYNcbHopRVVHZLCCsyXs5yAk8A8bnvSrPFC73Z23A0dFcvvYEEF94FiAiN
 GGEjAudVaZPLeLP1dxj2q9wt4ZzrTw+MoV8gSByFH5mZefusAkGtm2O4wr4tfpdk9Yv1
 N0o2/s9BwsWCurMgjcGWlZf7YV0mkK34b6c= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by m0089730.ppops.net with ESMTP id 36hqg5an8b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 15:13:50 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 15:13:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TRLjqIgaoWXZvxstcXuMXtqPGixGOQrJuTbBhE/qYxx+1faNPHC9ro2jlTKkM7GS1PDPC0+Kmc2PlZ6m/nlAtcGkV+KRaygrmQOOc2OZsik0ptz4oz9MIvoEWbHEnNwSlpiJ0R91aLHHu+vzHYK7aDfd2ug1vdafmdVxFGaiIYBcC3c/NsuoEJv0aM62uVg/zwCKHYVWUISo6EiaIPxOMlraRmKq8n57RSGvhddMlr/9IFHpM7peCaFLyusH+4c3vSHSu84TrBYRiTNp4nVmfDhIeBy3SROVFxh2ltEqAfpLQYkeUNwV5pK2AnRILk3flUPKV31MrBskpLMH7jeA/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9oyDLu3KXkbx8vuAGLAl84Cgkfl/xeZCkZefpDUFJo=;
 b=beW2NUmk6cz5VMcN46KGb6/o6czUc80lnPm0eUKvg7mqomb8MEZ5L1yXFT+0TfrPcAwqSOnUj//iLpeWhN5t6FUHNQffzQTAYGkybUWuEZUsFfilexGo6So8K8X9rvdZngdN/QBSOqTk/LC5n2mmCwb1Dqh5moL3G+WE1VqRaOtX6GWynOg2AvXNZyIIEThj4hqR3IQQCpfTVT6W2UDbVtssqvJslx3ykoR761i5S3zmhjj8S0uSOxqfzgIdQk5FPeNO5Eg7S7rmTlCI6/ZRTlRiMmzOwnLN8ktPIjtzcw8SBBnQ48s/cfOcB4BKqfRGzu4guKOoM4a+7I1iuh6amw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b9oyDLu3KXkbx8vuAGLAl84Cgkfl/xeZCkZefpDUFJo=;
 b=NoFzLE1Dzm3gv2QrIiXLE9FD9k6H/mIhCueGRSLJLXScq06/FZlJf5Lxz8Tjc80r663ue0Xqd9KGTYrHByWw/jQi77JIvCxhcwbRzdM4/P4J6+nwrg23/7ZimTp0qF2g1E2nZcrwiNtPvQu7MgBSGK7MOmxhT7e4IwMvB8otycE=
Received: from BN8PR15MB3282.namprd15.prod.outlook.com (2603:10b6:408:a8::32)
 by BN6PR15MB1586.namprd15.prod.outlook.com (2603:10b6:404:c5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.27; Mon, 8 Feb
 2021 23:13:48 +0000
Received: from BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd]) by BN8PR15MB3282.namprd15.prod.outlook.com
 ([fe80::81bf:9924:c4f1:75cd%6]) with mapi id 15.20.3763.019; Mon, 8 Feb 2021
 23:13:48 +0000
Subject: Re: [PATCH v2 bpf-next 1/7] bpf: Optimize program stats
To:     Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        <davem@davemloft.net>
CC:     <bpf@vger.kernel.org>, <kernel-team@fb.com>
References: <20210206170344.78399-1-alexei.starovoitov@gmail.com>
 <20210206170344.78399-2-alexei.starovoitov@gmail.com>
 <ae1b3d4b-59fd-4ad2-1e72-f9d987250757@iogearbox.net>
From:   Alexei Starovoitov <ast@fb.com>
Message-ID: <49f8a832-43a1-74c8-25b4-b66c8a3014be@fb.com>
Date:   Mon, 8 Feb 2021 15:13:43 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.0
In-Reply-To: <ae1b3d4b-59fd-4ad2-1e72-f9d987250757@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [2620:10d:c090:400::5:d90d]
X-ClientProxiedBy: MWHPR13CA0030.namprd13.prod.outlook.com
 (2603:10b6:300:95::16) To BN8PR15MB3282.namprd15.prod.outlook.com
 (2603:10b6:408:a8::32)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:2103:c99:e09d:8a8f:94f0] (2620:10d:c090:400::5:d90d) by MWHPR13CA0030.namprd13.prod.outlook.com (2603:10b6:300:95::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3846.11 via Frontend Transport; Mon, 8 Feb 2021 23:13:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02ed3b3a-9db8-4c9d-ca2b-08d8cc873084
X-MS-TrafficTypeDiagnostic: BN6PR15MB1586:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BN6PR15MB1586B95BE7A613CA50606C18D78F9@BN6PR15MB1586.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: tO98UyFOyb68RT297xTfULQLE5MCC4Banbs3xD8aun/3gXXls7f66XwaSRwvRxn9XvQLNuAtWQSxH9gvBdxlLrILhL2PflnFJMPlh7NBnVptP3Pm2C/QuyAuu4cACSivJAV5Sd7QuXkwyroXTNubZ51t6zQLnr1Erp3EQx6d92F/zgnKMTOtG0hGFm4SEgZaOlo7R7P7SzE0PTs7piijOjFiT/rNLU3yf3uA0PT4BTbF0FsP7k916VGhVXe6qFVJeIqFUufLJ9uQ9c71Swg1vN7yaGNSUZ+SiJX7BYw9RWCxdMdfjSCO9OgaoRshCtWFEkckP3itKcbsLlotlR//E1GT6Zdo3iti/fmOk6rWzQtLeOppDXzPI9QSEdJIkerZWu2GAeODLU3pNnDx1dcUVwpFUJNBKYpt9lV/7HkXxjk73cJJ7M4JcoFTWMxDM9Njat5dmRvh0X26cMikRt1SBmYv4MVF1po412BXMQpwEcVDW0cKv9yciJNHltAIG9QIboTWebi53FowRtC7nk9bxTJnrCvTFVmwexbtUIg3DeSbjwSfxujWVGKS+5Kw7vX5zuHGXo6qWavK/mI4g6irvXWX6PBuuz396ZVcKOExBwo=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR15MB3282.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(366004)(376002)(346002)(39860400002)(136003)(86362001)(6666004)(186003)(31686004)(83380400001)(16526019)(8676002)(478600001)(52116002)(6486002)(36756003)(8936002)(110136005)(66946007)(2906002)(66556008)(66476007)(53546011)(4326008)(5660300002)(316002)(31696002)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?bjM3VkZubHZFUTVMZU1wdTRjR2pNRXFnLy8zbmVTSi9oa0trV3c2VVZOTlFu?=
 =?utf-8?B?UEdUL0VCYTUvUElRVHhuNnk1ZDAxVUZHd0R1QmVSM1U4dWowQWE1MFJlU3Ew?=
 =?utf-8?B?NE1vWVoxSFMwWkMyb0FXL3o4NTgwWnF5RnE5S3R5c3phVDhSVWkreS9tdk15?=
 =?utf-8?B?QllaVlo5N1Z5NjQwdU1jclFSL20vd2F3QUhwYkwwTlc5Mms4RUp3cHB4MlZK?=
 =?utf-8?B?T3pHQkNFRnJBamVFMFc2TzluMXlrUERLK0VCaTZ1Nnlwa1R5YmRFNWQvWEtB?=
 =?utf-8?B?emJucThORzhwNW5BWUtkNmRUNFN3c1VXSzNQN1VyM1pFMUxJdnBIeVRSKzlL?=
 =?utf-8?B?UFVlb2hkTzBqOTBkMzMxbW5Gb2tTS1o5WXRjL01vNkw3R2psd1BIVlpDS2hj?=
 =?utf-8?B?TjE5dytmKytmeUJoRnBubFY1aDlHamlTb2dIQTdaVUNXN3NFVkxqVVVpTTNG?=
 =?utf-8?B?eXZ0TEVtNFowU3M1UzE4K254eFFTK0ZpMXkzQXVQSXp0aEhNeE9NZlhnVUlT?=
 =?utf-8?B?Nm5ualRwdUNJaW91amJ3K0xXWWJTZWFFZThTMVVZKy90VnF3SnlRWVhHNjlI?=
 =?utf-8?B?b1g4NDVpUnZpUUdkeDNHYzVNYk1qdnNDTjFoVnUzc0hiK09qQkZDOU1Cd05I?=
 =?utf-8?B?YVVMaGk4aTg1cmo5YUt0WEErdUU5ZjJUSW8zSURqOXJBajZxUlp6dHQ1aEpC?=
 =?utf-8?B?WURlVlVESWsvREk0UU9MYmpFZC9RdExZVDU1Q3NtdkFtSFdaaTRYTFRWRng3?=
 =?utf-8?B?ek5KYTBFdGpTSVNHUFkwcEN0Tlc3SXlSZFVWdEw3OVN2K0tudUcrTVNhVXhv?=
 =?utf-8?B?Uzhhby9Ua2R1WHdrQXJiMFZXMlNOS1lBY1lIeEtTaUE4dm95SkdxOVBRd0pC?=
 =?utf-8?B?UEZyWERKU3ZNQTkvVGdFRnVxTDBpTEVWaGhFeVVJMmtUQnpYYjI2TnZ3eUpB?=
 =?utf-8?B?ZGhtN3BQVUk0cjB4eGY5Wi85amVTenhacGU5dy9BYjFFd2RKY3pPVXdKTms2?=
 =?utf-8?B?TkY1NFptZlFDS0x0ZFc2Tm1rNDdORWMwTi82OENWRFBaNTdlL2dZMVUrZlNZ?=
 =?utf-8?B?aEhNdEF2YTZlSFFRVzJrQlJ2R2pGMUFYSUMwdkpJckV0VW1ZaTRhVFMzdjZ5?=
 =?utf-8?B?aXhPNnl1cHNpUFFWNk9DaDNiUkh2UkNvaXRXTTlURzJPVk9MNWoxSkl5ZXZD?=
 =?utf-8?B?aldueERrWXFTN3ZtclBVdXNncHg3RU5XeGVJcUhReGFlL0tYL1I5Y055YkVW?=
 =?utf-8?B?MDgyVVRmZjkyb0dQL29tWUs1bGN6OGhHMjh4QzZRRzhWVWRSQ1FNdExHK0tO?=
 =?utf-8?B?NHlicFdPWHgrK3A0dHhuK05xWUdsOEFBYTROS2hTK0xvY3B1SC9NN3Z3RFND?=
 =?utf-8?B?YWs1RXl1TExqTE5kUkYzRUlIZkxjSjVEa0FMSG8rWGdVeC9qOExWaVhVUCtN?=
 =?utf-8?B?WWc5dWo2cHlGdHMyOXd2ZUVXd2c4U0ZqQnFxVmlYalF5b1I5VDJzQVkwaklX?=
 =?utf-8?B?QXhzSWZ5MGlwdm1mbzBIQ3JMUFR6K3hOY2dYU25ZNHRQZEFBbnlsK3RXRUpk?=
 =?utf-8?B?VWZRcEVTUzlweUxYV2xhMjExamJtMTM1R0s3ejBTbGp3bC9GSHpPZkdxdnFj?=
 =?utf-8?B?cE90Tkg4RENQaVlTbXBKOG5OSVFEY2RlNmpTZVJEMmZSenh5Z2NMdnNnUys3?=
 =?utf-8?B?VEZnK2ZHcU92ZlI4bERFRUw2R25KUDFxc3p2aXpMVlNiZmM5VHhXSFZTNWtj?=
 =?utf-8?B?T1Z6cTBoOWRkNUJrckwranZvYlFSUU1lYkVJbWVhN3E0TnRsU3h1MkFEUWR4?=
 =?utf-8?B?V01pSjlGSnF2bEl1ZGdqQT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ed3b3a-9db8-4c9d-ca2b-08d8cc873084
X-MS-Exchange-CrossTenant-AuthSource: BN8PR15MB3282.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2021 23:13:48.1454
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkKROe//kT3aeHipw3fOpAe9q21lafT28h8E1bSRGiYdKtdaIy9TzS+/xPiSNm3O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR15MB1586
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-08_16:2021-02-08,2021-02-08 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1011 phishscore=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102080129
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 2/8/21 1:28 PM, Daniel Borkmann wrote:
> On 2/6/21 6:03 PM, Alexei Starovoitov wrote:
>> From: Alexei Starovoitov <ast@kernel.org>
>>
>> Move bpf_prog_stats from prog->aux into prog to avoid one extra load
>> in critical path of program execution.
>>
>> Signed-off-by: Alexei Starovoitov <ast@kernel.org>
>> ---
>>   include/linux/bpf.h     |  8 --------
>>   include/linux/filter.h  | 10 +++++++++-
>>   kernel/bpf/core.c       |  8 ++++----
>>   kernel/bpf/syscall.c    |  2 +-
>>   kernel/bpf/trampoline.c |  2 +-
>>   kernel/bpf/verifier.c   |  2 +-
>>   6 files changed, 16 insertions(+), 16 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 321966fc35db..026fa8873c5d 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -14,7 +14,6 @@
>>   #include <linux/numa.h>
>>   #include <linux/mm_types.h>
>>   #include <linux/wait.h>
>> -#include <linux/u64_stats_sync.h>
>>   #include <linux/refcount.h>
>>   #include <linux/mutex.h>
>>   #include <linux/module.h>
>> @@ -507,12 +506,6 @@ enum bpf_cgroup_storage_type {
>>    */
>>   #define MAX_BPF_FUNC_ARGS 12
>> -struct bpf_prog_stats {
>> -    u64 cnt;
>> -    u64 nsecs;
>> -    struct u64_stats_sync syncp;
>> -} __aligned(2 * sizeof(u64));
>> -
>>   struct btf_func_model {
>>       u8 ret_size;
>>       u8 nr_args;
>> @@ -845,7 +838,6 @@ struct bpf_prog_aux {
>>       u32 linfo_idx;
>>       u32 num_exentries;
>>       struct exception_table_entry *extable;
>> -    struct bpf_prog_stats __percpu *stats;
>>       union {
>>           struct work_struct work;
>>           struct rcu_head    rcu;
>> diff --git a/include/linux/filter.h b/include/linux/filter.h
>> index 5b3137d7b690..c6592590a0b7 100644
>> --- a/include/linux/filter.h
>> +++ b/include/linux/filter.h
>> @@ -22,6 +22,7 @@
>>   #include <linux/vmalloc.h>
>>   #include <linux/sockptr.h>
>>   #include <crypto/sha1.h>
>> +#include <linux/u64_stats_sync.h>
>>   #include <net/sch_generic.h>
>> @@ -539,6 +540,12 @@ struct bpf_binary_header {
>>       u8 image[] __aligned(BPF_IMAGE_ALIGNMENT);
>>   };
>> +struct bpf_prog_stats {
>> +    u64 cnt;
>> +    u64 nsecs;
>> +    struct u64_stats_sync syncp;
>> +} __aligned(2 * sizeof(u64));
>> +
>>   struct bpf_prog {
>>       u16            pages;        /* Number of allocated pages */
>>       u16            jited:1,    /* Is our filter JIT'ed? */
>> @@ -559,6 +566,7 @@ struct bpf_prog {
>>       u8            tag[BPF_TAG_SIZE];
>>       struct bpf_prog_aux    *aux;        /* Auxiliary fields */
>>       struct sock_fprog_kern    *orig_prog;    /* Original BPF program */
>> +    struct bpf_prog_stats __percpu *stats;
>>       unsigned int        (*bpf_func)(const void *ctx,
>>                           const struct bpf_insn *insn);
> 
> nit: could we move aux & orig_prog while at it behind bpf_func just to 
> avoid it slipping
> into next cacheline by accident when someone extends this again?

I don't understand what moving aux+orig_prog after bpf_func will do.
Currently it's this:
struct bpf_prog_aux *      aux;                  /*    32     8 */
struct sock_fprog_kern *   orig_prog;            /*    40     8 */
unsigned int               (*bpf_func)(const void  *, const struct 
bpf_insn  *); /*    48     8 */

With stats and active pointers the bpf_func goes into 2nd cacheline.
In the past the motivation for bpf_func right next to insns were
due to interpreter. Now everyone has JIT on. The interpreter
is often removed from .text too. So having insn and bpf_func in
the same cache line is not important.
Whereas having bpf_func with stats and active could be important
if stats/active are also used in other places than fexit/fentry.
For this patch set bpf_func location is irrelevant, since the
prog addr is hardcoded inside bpf trampoline generated asm.
For the best speed only stats and active should be close to each other.
And they both will be in the 1st.

>> @@ -249,7 +249,7 @@ void __bpf_prog_free(struct bpf_prog *fp)
>>       if (fp->aux) {
>>           mutex_destroy(&fp->aux->used_maps_mutex);
>>           mutex_destroy(&fp->aux->dst_mutex);
>> -        free_percpu(fp->aux->stats);
>> +        free_percpu(fp->stats);
> 
> This doesn't look correct, stats is now /not/ tied to fp->aux anymore 
> which this if block
> is taking care of freeing. It needs to be moved outside so we don't leak 
> fp->stats.

Great catch. thanks!

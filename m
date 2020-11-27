Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8455D2C6924
	for <lists+bpf@lfdr.de>; Fri, 27 Nov 2020 17:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731247AbgK0QJr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 27 Nov 2020 11:09:47 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:3732 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731163AbgK0QJq (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 27 Nov 2020 11:09:46 -0500
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0ARG1HuG006915;
        Fri, 27 Nov 2020 08:09:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qzdTdqTNbKowkv1B+UpfkdR0ZYanQkr7QPbGpmFKLfk=;
 b=b23XOk7TI8kLHCebbZA/Kw/jHMlO83dAbxg6PWcxHszSdXTY6xn8G3amOyr08MADsGne
 mpTu8hTYUycofWCN2HLLkPqatp1NBovFLxNWRhDT9brPn/BmCAwnzFLmr/4OUaJ4YD7r
 8rl0NyMHpD0OwkyW9XG2gTWKd2FZVmu4TGE= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 352xm59hxk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 27 Nov 2020 08:09:26 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Fri, 27 Nov 2020 08:09:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VLJmEzkTPw5JnTyRms7V7fTsu8KAGdjGrX7T+lUCHoUv4/VZwWHUp7OnjUWM0Zpl8x5rVe+35wuqgagdIwIz/PgFcGSNmnCmVmOcZ/dCD3C/N/cOR8aaulikNKQsqz9D8fgKfPIZC/8PJCgbMQI1hBH81WAisIeBfFhweP9NMKVUFp/0re2dZjhltyLakv/BCxtFjoxfL8Bxt7yZGiyfBUQc8+usR93IC3ZHRNHDVaY/UhxD0moSrQibAJ9eg0WDBd2Tg45VtWfbFrrgSMcjbDI3WsKbxvIx/rV+bfsMbT3PWFWf8+oPd20nx6kHiCBJeDjMAiZo7loIamkCSw3P4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzdTdqTNbKowkv1B+UpfkdR0ZYanQkr7QPbGpmFKLfk=;
 b=dkPKFEHz7QMWaqOvqRK3Tdrc1x0jpYrRNsE1fXd0pODft6EUK82ZfFwNjdz6Q5gtMB78/W1EoOOasYdTy+dOYAas+dNSIQfhbzbgW4qbq5dugMQo113QZiLo/3ZVfcerr2hqMkzSe8TUtvRnrfaBoKdkL/oxI2XCBw0BAaNfZvLJ2PT9TzXB6u2RFbq0RrqEg/ozTXXJC5UCjYYIqlGYaXqAPdc0O+2FeRLXjelHQ1XTwrDiSB+oq3MxQ9gsVEiDLPr54hdx8IDf2pgkogDt9VQstWGVg1IypvTZR6+UtG/Xp26L98LxOaedgtsypPQb5di/I3AgB68AsaF6ajv28Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qzdTdqTNbKowkv1B+UpfkdR0ZYanQkr7QPbGpmFKLfk=;
 b=SJ96P0gfCnWP+uUYZJWupAqiCrSNVGukvJ/uiznllZb35VP8t8LZ8UMIBPJIsJ2f7zLUwlJuF8lmLoC+GJuP1RXe5cMMUFabwjZqGROQGIXovpV4mOVqwJxSPe9XRYVtElpltM/aqhF1jKlHfJ8aNZ3X48UNMNDFCpsuDVJOXzs=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB4120.namprd15.prod.outlook.com (2603:10b6:a02:c4::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3611.24; Fri, 27 Nov
 2020 16:09:10 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3611.025; Fri, 27 Nov 2020
 16:09:10 +0000
Subject: Re: [PATCH bpf-next 1/2] bpf: Add a bpf_kallsyms_lookup helper
To:     KP Singh <kpsingh@chromium.org>
CC:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Florent Revest <revest@google.com>,
        open list <linux-kernel@vger.kernel.org>
References: <20201126165748.1748417-1-revest@google.com>
 <50047415-cafe-abab-a6ba-e85bb6a9b651@fb.com>
 <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e8b03cbc-c120-43d5-168c-cde5b6a97af8@fb.com>
Date:   Fri, 27 Nov 2020 08:09:07 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.5.0
In-Reply-To: <CACYkzJ7T4y7in1AsCvJ2izA3yiAke8vE9SRFRCyTPeqMnDHoyQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:70f8]
X-ClientProxiedBy: MW3PR05CA0017.namprd05.prod.outlook.com
 (2603:10b6:303:2b::22) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c8::102b] (2620:10d:c090:400::5:70f8) by MW3PR05CA0017.namprd05.prod.outlook.com (2603:10b6:303:2b::22) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3632.9 via Frontend Transport; Fri, 27 Nov 2020 16:09:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5989af1a-87ae-4c43-c0e5-08d892eec653
X-MS-TrafficTypeDiagnostic: BYAPR15MB4120:
X-Microsoft-Antispam-PRVS: <BYAPR15MB4120F9651AC42BFACD7B40DCD3F80@BYAPR15MB4120.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TOxJsyGTnth9LGi5kHsI5ZpSI7cdCNNkFGiT1xe3VAsabhMFEYwaoBFHqImKX9tt0ZVmDcFPtBPwfvMitE4t+RmTf+8UJlRaZWxI/3b+Gni6nidWxXQYnDojUqKUCNkvqoC3UxszHglITvtwu/kVpOuRtuEwQ3M8/pZKaUS/TzU2tbVGwIMpPkgx111CgVdH5hF2/XMc9DSHhDnd06J3IOrugxhEs0FWyVws5yeWuPEhy3eEru0oW7glT3G248O4NsCZgwyfBPtVow7OIUhVax5sEBA+TxSbTmwUr2I7wRL+SciGrME3u1NBui2FPsQXDY1+kB3qFuveoG3gBzV8iP/nAmkAKbC839JZ4DEV8emJpSss2nNlKCNwRk1XqTSG
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(396003)(366004)(376002)(346002)(39860400002)(186003)(16526019)(36756003)(31696002)(66946007)(54906003)(83380400001)(66556008)(316002)(53546011)(8936002)(4326008)(8676002)(6486002)(31686004)(478600001)(5660300002)(2616005)(86362001)(2906002)(66476007)(52116002)(6916009)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?V3dORUZqT2tHODlIc3lwMFVtVVBseFAvaHZxNjUyM3g2ZGdVNXdYWW9OcUp5?=
 =?utf-8?B?MkJMeFdZaCtUMGZQQWtUVy9UWmdFS3VvMGtiOFBuYzdXakp0MjlwaEV3NTg2?=
 =?utf-8?B?NW9SRU10a2JqRElINHpUVzFCLzFoWnVUSTl3QjlkUElicnA2VGtIZi9oWUpk?=
 =?utf-8?B?TWpxQUdySCt1bTR3Mk9zbHg1eVFxR3FkNUVuajlOTTRxV1dJdTY1Q0VmTURh?=
 =?utf-8?B?eGxGcGladjFKMzFGNCs0eFY4NEQydjJaRWExWWxueVBzTGlDbUNzb0Jnb2Uv?=
 =?utf-8?B?WC9rRjRxVVA1Zko1OXVyWDFIU0lKbVYvYnlXRkpnSkU3UnFlQVNyaFZTYk9I?=
 =?utf-8?B?RXAwYkNsZXlKUkxXbjc2cnUyWnZ3UXVxWUJKTmhzTmYxcjcvWjRta1VSVHNF?=
 =?utf-8?B?Q0tTdU1yUXNSY2V6UmlmSllsdWZzMlVFTUU2YVN2WlNUbUFiZ2pmeW51c2xl?=
 =?utf-8?B?UXByOC9qejYwZjQ4S0NUcXNRQmdZQWgwNGpMY29Eczdha1JDUzVOZG9JVVl6?=
 =?utf-8?B?czhwOEllV2dmY0xodWdoTHd6aWRyZEpPWFQvejYwQTZUREFLUVBCYTk4TCto?=
 =?utf-8?B?ZzB3TEswM3R6U1ROZ3krL3JDS3g0c3RpQU5EQUhYYW9oa1g5YXVyWFNvRUc1?=
 =?utf-8?B?Y2xVNXl6bTdRUmpRN1A0c2lmdGdCenU1SkdZREgyd0hkYjZLNy9RbFgvMXZy?=
 =?utf-8?B?bjl6c1N1QW5FNkpTT3JOaWJaUU5NRzhyZHRnbFJwQmdlME4ySGRYZHFRVEtH?=
 =?utf-8?B?b3Q3S0NGdkdvdEFYUkwzY0EwTWUrMXlYTVdnNkJBMy9iR051VXJFSjRhY2Zm?=
 =?utf-8?B?UWVQWTBFRWZqUzBwUnZQK1JzSHZrMzE0V2xId1JmRUdKR0Jnb0hDM214UjRs?=
 =?utf-8?B?Y0FHSFRqNldJdlhySVFWaUJMcGZtWllLWmRxSlVFSFhzejhZY3ZRUUh3Q0Qy?=
 =?utf-8?B?eWZmbVpqNUN1K0pBbHVoVlNDYWZoSU1xYTVJMUxJQ3RZaG5sbk11MUxhNkUr?=
 =?utf-8?B?T0Nybm5SMGFOKzJkKzNZZkpac3ZPMVVMUTNZY1c5TlFjYmFkQ1BzTk1vL1No?=
 =?utf-8?B?bjE0RTBKZFRiTS94Q0MxM3R3MWk4YlpTWHNJT2NEOUVJOVg2bDJIRWtudmZY?=
 =?utf-8?B?WXpxU1RxYURYbmJkVCtZMUN2ZnhKWFZpUWJNU0dRcnZubDBEeFRLVVBTWUNR?=
 =?utf-8?B?UWU1dTVxM1Iva3BOQ1dTQ09GU3p0aVlHVlFGYk93aTlIckZuYlI0MEE5YTFm?=
 =?utf-8?B?SHFpb0tJdWtEZVZJMHNWSW1SWVQycEhiSGVYTHBhdG1GSzZBTFZERjFiWFRD?=
 =?utf-8?B?TUlZUUN0SmNCcUd4NWVzYnZua00zWEFsVnhaSzdRTFdYYlBJNGhrTzJUWWpa?=
 =?utf-8?B?Y09ZUVFMbjJUNnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5989af1a-87ae-4c43-c0e5-08d892eec653
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2020 16:09:10.3082
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KR3LgsZFGn11bup4ssVP0TLCS4y6Ram0duCm49fIEemLC+BuT+ygRVUZDpk2p4XP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB4120
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-11-27_08:2020-11-26,2020-11-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 suspectscore=0 priorityscore=1501 malwarescore=0 mlxscore=0 phishscore=0
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 mlxlogscore=999
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011270094
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/27/20 3:20 AM, KP Singh wrote:
> On Fri, Nov 27, 2020 at 8:35 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 11/26/20 8:57 AM, Florent Revest wrote:
>>> This helper exposes the kallsyms_lookup function to eBPF tracing
>>> programs. This can be used to retrieve the name of the symbol at an
>>> address. For example, when hooking into nf_register_net_hook, one can
>>> audit the name of the registered netfilter hook and potentially also
>>> the name of the module in which the symbol is located.
>>>
>>> Signed-off-by: Florent Revest <revest@google.com>
>>> ---
>>>    include/uapi/linux/bpf.h       | 16 +++++++++++++
>>>    kernel/trace/bpf_trace.c       | 41 ++++++++++++++++++++++++++++++++++
>>>    tools/include/uapi/linux/bpf.h | 16 +++++++++++++
>>>    3 files changed, 73 insertions(+)
>>>
>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>> index c3458ec1f30a..670998635eac 100644
>>> --- a/include/uapi/linux/bpf.h
>>> +++ b/include/uapi/linux/bpf.h
>>> @@ -3817,6 +3817,21 @@ union bpf_attr {
>>>     *          The **hash_algo** is returned on success,
>>>     *          **-EOPNOTSUP** if IMA is disabled or **-EINVAL** if
>>>     *          invalid arguments are passed.
>>> + *
>>> + * long bpf_kallsyms_lookup(u64 address, char *symbol, u32 symbol_size, char *module, u32 module_size)
>>> + *   Description
>>> + *           Uses kallsyms to write the name of the symbol at *address*
>>> + *           into *symbol* of size *symbol_sz*. This is guaranteed to be
>>> + *           zero terminated.
>>> + *           If the symbol is in a module, up to *module_size* bytes of
>>> + *           the module name is written in *module*. This is also
>>> + *           guaranteed to be zero-terminated. Note: a module name
>>> + *           is always shorter than 64 bytes.
>>> + *   Return
>>> + *           On success, the strictly positive length of the full symbol
>>> + *           name, If this is greater than *symbol_size*, the written
>>> + *           symbol is truncated.
>>> + *           On error, a negative value.
>>>     */
>>>    #define __BPF_FUNC_MAPPER(FN)               \
>>>        FN(unspec),                     \
>>> @@ -3981,6 +3996,7 @@ union bpf_attr {
>>>        FN(bprm_opts_set),              \
>>>        FN(ktime_get_coarse_ns),        \
>>>        FN(ima_inode_hash),             \
>>> +     FN(kallsyms_lookup),    \
>>>        /* */
>>>
>>>    /* integer value in 'imm' field of BPF_CALL instruction selects which helper
>>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>>> index d255bc9b2bfa..9d86e20c2b13 100644
>>> --- a/kernel/trace/bpf_trace.c
>>> +++ b/kernel/trace/bpf_trace.c
>>> @@ -17,6 +17,7 @@
>>>    #include <linux/error-injection.h>
>>>    #include <linux/btf_ids.h>
>>>    #include <linux/bpf_lsm.h>
>>> +#include <linux/kallsyms.h>
>>>
>>>    #include <net/bpf_sk_storage.h>
>>>
>>> @@ -1260,6 +1261,44 @@ const struct bpf_func_proto bpf_snprintf_btf_proto = {
>>>        .arg5_type      = ARG_ANYTHING,
>>>    };
>>>
>>> +BPF_CALL_5(bpf_kallsyms_lookup, u64, address, char *, symbol, u32, symbol_size,
>>> +        char *, module, u32, module_size)
>>> +{
>>> +     char buffer[KSYM_SYMBOL_LEN];
>>> +     unsigned long offset, size;
>>> +     const char *name;
>>> +     char *modname;
>>> +     long ret;
>>> +
>>> +     name = kallsyms_lookup(address, &size, &offset, &modname, buffer);
>>> +     if (!name)
>>> +             return -EINVAL;
>>> +
>>> +     ret = strlen(name) + 1;
>>> +     if (symbol_size) {
>>> +             strncpy(symbol, name, symbol_size);
>>> +             symbol[symbol_size - 1] = '\0';
>>> +     }
>>> +
>>> +     if (modname && module_size) {
>>> +             strncpy(module, modname, module_size);
>>> +             module[module_size - 1] = '\0';
>>
>> In this case, module name may be truncated and user did not get any
>> indication from return value. In the helper description, it is mentioned
>> that module name currently is most 64 bytes. But from UAPI perspective,
>> it may be still good to return something to let user know the name
>> is truncated.
>>
>> I do not know what is the best way to do this. One suggestion is
>> to break it into two helpers, one for symbol name and another
> 
> I think it would be slightly preferable to have one helper though.
> maybe something like bpf_get_symbol_info (better names anyone? :))
> with flags to get the module name or the symbol name depending
> on the flag?

This works even better. Previously I am thinking if we have two helpers,
we can add flags for each of them for future extension. But we
can certainly have just one helper with flags to indicate
whether this is for module name or for symbol name or something else.

The buffer can be something like
    union bpf_ksymbol_info {
       char   module_name[];
       char   symbol_name[];
       ...
    }
and flags will indicate what information user wants.

> 
>> for module name. What is the use cases people want to get both
>> symbol name and module name and is it common?
> 
> The use case would be to disambiguate symbols in the
> kernel from the ones from a kernel module. Similar to what
> /proc/kallsyms does:
> 
> T cpufreq_gov_powersave_init [cpufreq_powersave]
> 
>>
>>> +     }
>>> +
>>> +     return ret;
>>> +}
>>> +
>>> +const struct bpf_func_proto bpf_kallsyms_lookup_proto = {
>>> +     .func           = bpf_kallsyms_lookup,
>>> +     .gpl_only       = false,
>>> +     .ret_type       = RET_INTEGER,
>>> +     .arg1_type      = ARG_ANYTHING,
>>> +     .arg2_type      = ARG_PTR_TO_MEM,
>> ARG_PTR_TO_UNINIT_MEM?
>>
>>> +     .arg3_type      = ARG_CONST_SIZE,
>> ARG_CONST_SIZE_OR_ZERO? This is especially true for current format
>> which tries to return both symbol name and module name and
>> user may just want to do one of them.
>>
>>> +     .arg4_type      = ARG_PTR_TO_MEM,
>> ARG_PTR_TO_UNINIT_MEM?
>>
>>> +     .arg5_type      = ARG_CONST_SIZE,
>> ARG_CONST_SIZE_OR_ZERO?
>>
>>> +};
>>> +
>>>    const struct bpf_func_proto *
>>>    bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>>    {
>>> @@ -1356,6 +1395,8 @@ bpf_tracing_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
>>>                return &bpf_per_cpu_ptr_proto;
>>>        case BPF_FUNC_bpf_this_cpu_ptr:
>>>                return &bpf_this_cpu_ptr_proto;
>>> +     case BPF_FUNC_kallsyms_lookup:
>>> +             return &bpf_kallsyms_lookup_proto;
>>>        default:
>>>                return NULL;
>>>        }
>> [...]

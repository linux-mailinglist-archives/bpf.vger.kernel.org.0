Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 260DA323198
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 20:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234089AbhBWTse (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 14:48:34 -0500
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:2322 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234082AbhBWTs3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 14:48:29 -0500
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NJhnGN014653;
        Tue, 23 Feb 2021 11:47:35 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=fDJAFK4DyVaSWvJOmYiKmVr5JQqhy2MTSUgYQNnlm+M=;
 b=iOLM2NoLq7MEDP5ABTOGUyAmxSJqQGK3kr62FtOfXhKFnvNrkqW2kpykCPKuGF2I6i/E
 lp8nqVP4blxKauqRW/iDhfdIex+mqU1fknmAh87tLNRjva1t3CdztG39BoIckZwH09Z2
 mZJ2GyYcmXa/eSNvUnxu8RWk5pFYaeY5WF4= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36vx7ru9s6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Feb 2021 11:47:35 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 11:47:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y8stN/cdlMGpn2E8zO047Wta6n5dMQEAD6x2SPjQqwbHMtQSk/EDaYs85RgnqPvFY1zoZcKu6iqLSFD9WbWvqjuK4DMo9oVSlUXYnEdMHp+DKQM7r6gxXXLV6TRWtI8Ld0cpIFo1Y4oMG4tWm/cVng/SM+wjlSnxwDcVR1doxKESE5bHBgx9qnhJcE0K1mU/LaGABPVUyjakaZ9H8pvlWqAxo/VBn09cPjIhIiVUaMc3AztsDASBAST82xln8KpR8TNDr6c/8r7fYnpK6Vay1Bv1u4JezP6SXr95pE/KtsbAxvaEM+E9NTHPKQxQZLEekZaTj//3MuCVGl2FTydSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fDJAFK4DyVaSWvJOmYiKmVr5JQqhy2MTSUgYQNnlm+M=;
 b=mxwn4uqrO0gjBMwwIjxEa4pcBtbGfxgeMKCieWXjuT7dR70N20ce6dMFF2wju5QKf4GgF5jgYGTSFMh3D5N6GibbQ2urrBTs4ZQaESbp4YIDssNM8z4DdQcIljQbXHW94/6IL3nD2gvp4Q0AgPjXUruim3k/5TBwstU/MSnW+XkmT450PiNHJqtKvZ8eNwi7LTSNw3qtqbpv4yLcGe2px04PZnQAFh4AJ2NlxItOR62cD0lC8Niz+YRlwqFrpVPaUuOfF4MPDGQryG16Dx2UXrkLowaTRio5z+a3gONxgFI1BdMxZFRQN9WEpq4gYO0MWYWvO0r6YrNFaV4R3z5T0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4386.namprd15.prod.outlook.com (2603:10b6:806:191::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 19:47:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 19:47:32 +0000
Subject: Re: [PATCH bpf-next v2 08/11] libbpf: support local function pointer
 relocation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210217181803.3189437-1-yhs@fb.com>
 <20210217181812.3191397-1-yhs@fb.com>
 <CAEf4BzZwEDQwMiXthy2Q32F3Qt1X4sTg92w8HZL7PbMB_FtYtg@mail.gmail.com>
 <b20cf48f-fa7c-1397-fc47-361a9e8edecf@fb.com>
 <CAEf4Bzav42vH8PdRYg7_vV20EV7FL6CJiciXs=zv3rqu5TR_zg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <2a242b27-5d12-5e1b-4bed-30db68c6ed09@fb.com>
Date:   Tue, 23 Feb 2021 11:47:28 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4Bzav42vH8PdRYg7_vV20EV7FL6CJiciXs=zv3rqu5TR_zg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:668b]
X-ClientProxiedBy: MWHPR21CA0064.namprd21.prod.outlook.com
 (2603:10b6:300:db::26) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10c3] (2620:10d:c090:400::5:668b) by MWHPR21CA0064.namprd21.prod.outlook.com (2603:10b6:300:db::26) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.4 via Frontend Transport; Tue, 23 Feb 2021 19:47:31 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8228b430-4901-45ec-e581-08d8d833dbf6
X-MS-TrafficTypeDiagnostic: SA1PR15MB4386:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB438668BC7214DC5D83099E7DD3809@SA1PR15MB4386.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3826;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wBHwuCw7+6Y8WS8/up/1EaDfone2N3YMmmWVUbhhqKQaAl4wlHYeuahXv8BMJsAcJv0+Xl/sd8ErAg9Rq27MWZQF3p1uaBNk9qv1ic4tU6qgTuRnTHU4NbHN/BnX08dpxMW5DKEhipFcaymSz7tD9l1aD7sVj9vU21tpwLvqI9ud3xNp+vKipkI0TftZLp4u/jIAsreq2KomodSEUVAV61eiIs+kPYNwrNJOEc98nMWbqOaeS4WyrTUwUvhqZdyQK4EJMgKx8vi8b9nEjUGN64j+YR0NsLQkHRS97PWTj2WT6Pb5MHVjf8ZOjhy6mGL0COBA9QJkAvuN2Jvkzv6bWtGyKFCuoyLKA6TsGfilMNOELNDJFOxp6lwFWqRw+g8lbt6sC5SbSjL3Tgi+1cOKqGb2KJtIjTfAigz84okNi5KBuPk6kWzvTht87R9Mhwx+zed9kSoB0/P+8+/ma89nmWDF8sZrSaY57GPqZ7iqelIptBauJyVRXPUPx/RrJ3konEo/Qd2URJ+zzx9XyVLUqReLfhFor9G4dteqhJOTCSKFmsKHfpJZjxE2wgQhIRc9a6gf6Qhs5+IGtre7Mby88pJA5JzMLIBHm2HZGj+RQak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(366004)(376002)(39860400002)(346002)(396003)(5660300002)(2906002)(36756003)(4326008)(31696002)(16526019)(52116002)(54906003)(31686004)(6666004)(66946007)(66556008)(6916009)(66476007)(53546011)(83380400001)(6486002)(2616005)(186003)(8936002)(86362001)(316002)(478600001)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?NFRSYVVNNmY0N0tXOTBwVlV4SW1aY1R3OFBGMGE4N2lxaFFuaUhrQXRYKzg1?=
 =?utf-8?B?enFHc2txa3AvVjczVGVma2hHRHBqdFdSK3NITVh0aVdEOEt6R09ZS0dMMGlH?=
 =?utf-8?B?UDZ4SnNMTWtPelVSQWpnbGdXaTBSeGRQSFN4MitJelY3dko1QnBXZ3FkVkpU?=
 =?utf-8?B?QTB3eVlXeW5TNjhLQWsxQzVCQzdVd2dqdlJnYzZlZlZuc3ZGd2RZN1NrZ0pM?=
 =?utf-8?B?ZHJteWFWVlN5REp1NFByTGp4VmdjQW1BSmFyQWZESXc2VGxZS0ZoWDRWeFlW?=
 =?utf-8?B?cnRpRHB0VTEvTytnWkRQSVd2R0NIRXNON3dlNWJxU0xKRUhkWEFjcHMzOXZN?=
 =?utf-8?B?MEgyMGM4YU84anpnR0xlVHZZeGVxemF0WjZ2bENqNEZYME1UV2tFRmw3bWVz?=
 =?utf-8?B?azR0NUNZN1FrZ2gzWUhCNzBMWTRiWXJYSGJFNWlIL2tscExkbXgxTUtKdU5l?=
 =?utf-8?B?Y3Rpdm15SUpaK01IcjMremQ3WHJENVhtNDJTQkd4cHBlbWZSUVRFZ1lJMGNp?=
 =?utf-8?B?NmF6enpjUDF6bWhtOW5SbFpnamJFeUtHOC93ZVIrVnhRc2lETmU5U2hZU3dC?=
 =?utf-8?B?SFZieTZoUnBXNHVWc0ZUT2JNUE1mb2RHRGlqZ01QMTU0eHNodkFncVB1anpN?=
 =?utf-8?B?YjRMYWJ5ai9QNVZ6QkNPeTFGQWd1TFdYem1oNGJWcTNLRTNFQngwY3Q0Rmxv?=
 =?utf-8?B?UHlYcTUyNVN0dFUzT3FUSmdNS0pnV2pvVmUyTExZTHl6WE5aU25sMm5mWkc2?=
 =?utf-8?B?RFRZckhxSWlTYVZ5bkdBQVNkMGV4b3hFc2I4UDFyQU9FdkxKUmljS1pGVDdn?=
 =?utf-8?B?YVdlRktHS3RTcitQbDFrQ2FvK2tVQndSSkdhZWJ0cDJyaVZtZnFKRDBvNEFQ?=
 =?utf-8?B?Tm1ZTnd1R2hPSGExVnU3bnR6MUhTOUIvaXV1M0xSQUp5SDBMd2tqVit2dW52?=
 =?utf-8?B?ODRlUnVSbFlYdnNvTUlpRTBHdFdYTXJxSE5rZ0RiWlR5N3NPUjFtZFdSeTlG?=
 =?utf-8?B?blNrZzloQjVEeFdVbjh3YkRyY3dCamVuRGtNZmJxWEhGMXdlU3paUUZKQTVZ?=
 =?utf-8?B?TjAvTUNmTVBvdEQxWXpoS2JsTFc1dnNSQzNNZ0pONG9tUGlnOGJoR2tWVWx5?=
 =?utf-8?B?ZWVKZDZpZUdlTXhRV29hYit6U1RDR0NFU01DSURJdmFGRHNMN05rdWx1V05H?=
 =?utf-8?B?TnhQVlJScFVBUWprdFhVU0x5MXE1dVFldWF1WHdLcS9XVlpQUWJYdmxjVi9p?=
 =?utf-8?B?V3lsTWdJYUlDdXBZeTRERXUxRjIwckVlWGVNZUptZE5XdXVVc2Jsc1dnQlNL?=
 =?utf-8?B?cTJRa3MwR0JVWTFUNllnb2orTGZJdVR2alhOYWhNU29mYTJnU1gzV0VweEZ6?=
 =?utf-8?B?Rm5Fb0tPU1REVGRNT2tYSnhSa0dXcmRoYTQvQmF6WVp4ekNONDdJbTA4K0tC?=
 =?utf-8?B?SHRPVnN0aTJXTmlmdFJvaG94Mm1kTkVMaEt5U1pXMFc0Y3M5RHFHR2ZUREty?=
 =?utf-8?B?c1dLdEVmYWg4aHFwSGR0bFdDQ1BDc1BHRGRPT0tBTjZ5M3ZJQU9SOFpmUHBK?=
 =?utf-8?B?NWR3YnphT0FNRHdOcGVxU3RjSG13dXlka2ZkOTIybENSUnVCYjNCKzN4c21N?=
 =?utf-8?B?SmMwbnM0MGQ4eHFZelEzeWl6TmFLcyt5V25ZY21BM3pKQmxNSklPQUxpL2dN?=
 =?utf-8?B?bG0rNzF3bFNvR0tVVVFxUWRhcDh5cFBHWk9JcUkycFJUdStvS2QvM1ovbVZn?=
 =?utf-8?B?YXFVbzdxV1NOVlBjVmw3bVRNMnAvSUNDTlVGd0J6OFBlMDBWcmozK21kUnFR?=
 =?utf-8?Q?9poB39N87ZT0J+zZ1Y5Bz1jXZFqvK22rcDSdE=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8228b430-4901-45ec-e581-08d8d833dbf6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 19:47:31.9497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CxU6CCjLzBBObrKNB2iKkPlZjGBd5CSlkQz8JdtlcG52VLIwLhCrFldVw8EMwN8f
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4386
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 spamscore=0 clxscore=1015 mlxscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230165
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/23/21 11:19 AM, Andrii Nakryiko wrote:
> On Tue, Feb 23, 2021 at 10:56 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 2/23/21 12:03 AM, Andrii Nakryiko wrote:
>>> On Wed, Feb 17, 2021 at 12:56 PM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> A new relocation RELO_SUBPROG_ADDR is added to capture
>>>> local (static) function pointers loaded with ld_imm64
>>>> insns. Such ld_imm64 insns are marked with
>>>> BPF_PSEUDO_FUNC and will be passed to kernel so
>>>> kernel can replace them with proper actual jited
>>>> func addresses.
>>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    tools/lib/bpf/libbpf.c | 40 +++++++++++++++++++++++++++++++++++++---
>>>>    1 file changed, 37 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>>>> index 21a3eedf070d..772c7455f1a2 100644
>>>> --- a/tools/lib/bpf/libbpf.c
>>>> +++ b/tools/lib/bpf/libbpf.c
>>>> @@ -188,6 +188,7 @@ enum reloc_type {
>>>>           RELO_CALL,
>>>>           RELO_DATA,
>>>>           RELO_EXTERN,
>>>> +       RELO_SUBPROG_ADDR,
>>>>    };
>>>>
>>>>    struct reloc_desc {
>>>> @@ -579,6 +580,11 @@ static bool is_ldimm64(struct bpf_insn *insn)
>>>>           return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
>>>>    }
>>>>
>>>> +static bool insn_is_pseudo_func(struct bpf_insn *insn)
>>>> +{
>>>> +       return is_ldimm64(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
>>>> +}
>>>> +
>>>>    static int
>>>>    bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>>>>                         const char *name, size_t sec_idx, const char *sec_name,
>>>> @@ -3406,6 +3412,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
>>>>                   return -LIBBPF_ERRNO__RELOC;
>>>>           }
>>>>
>>>> +       if (GELF_ST_BIND(sym->st_info) == STB_LOCAL &&
>>>> +           GELF_ST_TYPE(sym->st_info) == STT_SECTION &&
>>>
>>> STB_LOCAL + STT_SECTION is a section symbol. But STT_FUNC symbol could
>>> be referenced as well, no? So this is too strict.
>>
>> Yes, STT_FUNC symbol could be referenced but we do not have use
>> case yet. If we encode STT_FUNC (global), the kernel will reject
>> it. We can extend libbpf to support STT_FUNC once we got a use
>> case.
> 
> I don't really like tailoring libbpf generic SUBPROG_ADDR relocation
> to one current specific use case, though. Taking the address of
> SUBPROG_ADDR is not, conceptually, tied with passing it to for_each as
> a callback. E.g., what if you just want to compare two registers
> pointing to subprogs, without actually passing them to for_each(). I
> don't know if it's possible right now, but I don't see why that
> shouldn't be supported. In the latter case, adding arbitrary
> restrictions about static vs global functions doesn't make much sense.
> 
> So let's teach libbpf the right logic without assuming any specific
> use case. It pays off in the long run.

Okay, Will support global function as well. It won't hurt.

> 
>>
>>>
>>>> +           (!shdr_idx || shdr_idx == obj->efile.text_shndx) &&
>>>
>>> this doesn't look right, shdr_idx == 0 is a bad condition and should
>>> be rejected, not accepted.
>>
>> it is my fault. Will fix in the next revision.
>>
>>>
>>>> +           !(sym->st_value % BPF_INSN_SZ)) {
>>>> +               reloc_desc->type = RELO_SUBPROG_ADDR;
>>>> +               reloc_desc->insn_idx = insn_idx;
>>>> +               reloc_desc->sym_off = sym->st_value;
>>>> +               return 0;
>>>> +       }
>>>> +
>>>
>>> So see code right after sym_is_extern(sym) check. It checks for valid
>>> shrd_idx, which is good and would be good to use that. After that we
>>> can assume shdr_idx is valid and we can make a simple
>>> obj->efile.text_shndx check then and use that as a signal that this is
>>> SUBPROG_ADDR relocation (instead of deducing that from STT_SECTION).
>>>
>>> And !(sym->st_value % BPF_INSN_SZ) should be reported as an error, not
>>> silently skipped. Again, just how BPF_JMP | BPF_CALL does it. That way
>>> it's more user-friendly, if something goes wrong. So it will look like
>>> this:
>>>
>>> if (shdr_idx == obj->efile.text_shndx) {
>>>       /* check sym->st_value, pr_warn(), return error */
>>>
>>>       reloc_desc->type = RELO_SUBPROG_ADDR;
>>>       ...
>>>       return 0;
>>> }
>>
>> Okay. Will do similar checking to insn->code == (BPF_JMP | BPF_CALL)
>> in the next revision.
>>
>>>
>>>>           if (sym_is_extern(sym)) {
>>>>                   int sym_idx = GELF_R_SYM(rel->r_info);
>>>>                   int i, n = obj->nr_extern;
>>>> @@ -6172,6 +6188,10 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
>>>>                           }
>>>>                           relo->processed = true;
>>>>                           break;
>>>> +               case RELO_SUBPROG_ADDR:
>>>> +                       insn[0].src_reg = BPF_PSEUDO_FUNC;
>>>
>>> BTW, doesn't Clang emit instruction with BPF_PSEUDO_FUNC set properly
>>> already? If not, why not?
>>
>> This is really a contract between libbpf and kernel, similar to
>> BPF_PSEUDO_MAP_FD/BPF_PSEUDO_MAP_VALUE/BPF_PSEUDO_BTF_ID.
>> Adding encoding in clang is not needed as this is simply a load
>> of function address as far as clang concerned.
> 
> Yeah, not a big deal, I was under the impression we do that for other
> BPF_PSEUDO cases, but checking other parts of libbpf, doesn't seem
> like that's the case.
> 
>>
>>>
>>>> +                       /* will be handled as a follow up pass */
>>>> +                       break;
>>>>                   case RELO_CALL:
>>>>                           /* will be handled as a follow up pass */
>>>>                           break;
>>>> @@ -6358,11 +6378,11 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
>>>>
>>>>           for (insn_idx = 0; insn_idx < prog->sec_insn_cnt; insn_idx++) {
>>>>                   insn = &main_prog->insns[prog->sub_insn_off + insn_idx];
>>>> -               if (!insn_is_subprog_call(insn))
>>>> +               if (!insn_is_subprog_call(insn) && !insn_is_pseudo_func(insn))
>>>>                           continue;
>>>>
>>>>                   relo = find_prog_insn_relo(prog, insn_idx);
>>>> -               if (relo && relo->type != RELO_CALL) {
>>>> +               if (relo && relo->type != RELO_CALL && relo->type != RELO_SUBPROG_ADDR) {
>>>>                           pr_warn("prog '%s': unexpected relo for insn #%zu, type %d\n",
>>>>                                   prog->name, insn_idx, relo->type);
>>>>                           return -LIBBPF_ERRNO__RELOC;
>>>> @@ -6374,8 +6394,22 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
>>>>                            * call always has imm = -1, but for static functions
>>>>                            * relocation is against STT_SECTION and insn->imm
>>>>                            * points to a start of a static function
>>>> +                        *
>>>> +                        * for local func relocation, the imm field encodes
>>>> +                        * the byte offset in the corresponding section.
>>>> +                        */
>>>> +                       if (relo->type == RELO_CALL)
>>>> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
>>>> +                       else
>>>> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm / BPF_INSN_SZ + 1;
>>>> +               } else if (insn_is_pseudo_func(insn)) {
>>>> +                       /*
>>>> +                        * RELO_SUBPROG_ADDR relo is always emitted even if both
>>>> +                        * functions are in the same section, so it shouldn't reach here.
>>>>                            */
>>>> -                       sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
>>>> +                       pr_warn("prog '%s': missing relo for insn #%zu, type %d\n",
>>>
>>> nit: "missing subprog addr relo" to make it clearer?
>>
>> sure. will do.
> 
> given the "generic support" comment above, I think we should still
> support this case as well. WDYT?

Even for global function with ldimm64, relocations should have been 
generated previously. I will double verify to ensure this is true
for global function as well for different cases, in the same section or 
different sections, etc.

> 
>>
>>>
>>>> +                               prog->name, insn_idx, relo->type);
>>>> +                       return -LIBBPF_ERRNO__RELOC;
>>>>                   } else {
>>>>                           /* if subprogram call is to a static function within
>>>>                            * the same ELF section, there won't be any relocation
>>>> --
>>>> 2.24.1
>>>>

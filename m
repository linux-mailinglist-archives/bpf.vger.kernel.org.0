Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F87B323111
	for <lists+bpf@lfdr.de>; Tue, 23 Feb 2021 19:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233242AbhBWS5A (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 23 Feb 2021 13:57:00 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:25464 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232920AbhBWS47 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 23 Feb 2021 13:56:59 -0500
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 11NIsVcx012194;
        Tue, 23 Feb 2021 10:56:04 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=FwZZrez+54zmp1dGRAGuNitPE9XJQJNcKX+6bDyPCqQ=;
 b=YroDssGQ0mCbJcQ0fwcTdj48qOasmkdk0/xiTf2JMstz+g5oKH91uPi7RCKl8rD2alL/
 cnzygzKHXBLpWD1FVZfnhZJXGTgMx/znKXwGJu9qxJK8aTDYG7dKe4JOjzXOFUtBgFdt
 0o+7d/TuKMD9Q9p/8tv0imU3X2kMDzeBOAI= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 36v9gn94kg-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Tue, 23 Feb 2021 10:56:04 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Tue, 23 Feb 2021 10:56:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lTZfbNydxey3cMPelmJcWz+UpaidvXe6UZNhOSRWONqbURDS4Y8R/K+9+h6H/zniU+Z16aNs52BRIHrWunkHghpKr0ksDXuqS0h6XyV4tyF6RjK6WzHhembgcuepQecQmwtLe+QVW0gJGYSusIgCKedFkXXKTutIbgKM+d8KnH8R+QQLJvjjOSvHa9DirV9neP3FYkYmDUxfT5eaG4KmLEqJJUHCIwxYKmuftdLsa4vgx5OH35H3xmCh7+Qg2wMHCi87cQxslexFcoBhQEchY1+14zIzat4pSqGdOoPAMNiK3ugZrY4bxBnBvzIxknEyFMLXerWygCeZuYzRokzpYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FwZZrez+54zmp1dGRAGuNitPE9XJQJNcKX+6bDyPCqQ=;
 b=neDiWdZHAlb9pTcGadSm/5TiBqVbWkaqLInYUmMNIRvDLwHwTMNrgmxRBL6CNeHhdoih3wV/d0EOIrxy5OuxWzC+DNzw2NQrbKY9qW95Zq/OAUb9e1eucVwCb6uSztYvk6y+IUCpcYnzItDvjNIkM3/eNIOWkptTMHtnC+/HKUyh2zvuuiIBvXqqp9oVcNeDizyBzs3yeLH6pMh+haRgoifrpSsxeLeACsoKmaOQlQ7InPERVE/bJmhqHWS8nABYmD0Z3Dfni+QxUbwcv0TtOkFI6ZCyCIIk/vs7Dje5I3WZgnsUqMSGPZqC4rQ0m0i+K+bVMBTVYFc09IKpGZlZmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4435.namprd15.prod.outlook.com (2603:10b6:806:196::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.29; Tue, 23 Feb
 2021 18:56:01 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::e5af:7efb:8079:2c93%6]) with mapi id 15.20.3868.033; Tue, 23 Feb 2021
 18:56:00 +0000
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
From:   Yonghong Song <yhs@fb.com>
Message-ID: <b20cf48f-fa7c-1397-fc47-361a9e8edecf@fb.com>
Date:   Tue, 23 Feb 2021 10:55:58 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4BzZwEDQwMiXthy2Q32F3Qt1X4sTg92w8HZL7PbMB_FtYtg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:668b]
X-ClientProxiedBy: MW4PR03CA0292.namprd03.prod.outlook.com
 (2603:10b6:303:b5::27) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::10c3] (2620:10d:c090:400::5:668b) by MW4PR03CA0292.namprd03.prod.outlook.com (2603:10b6:303:b5::27) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3868.27 via Frontend Transport; Tue, 23 Feb 2021 18:56:00 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 490394e8-ab03-4a6b-38df-08d8d82ca98f
X-MS-TrafficTypeDiagnostic: SA1PR15MB4435:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB4435250E63469270820A1350D3809@SA1PR15MB4435.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:3383;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I4OV65YuDLShHm1XWEdOy5I47i7Y8LhAY7mOj8AZCQt5EUcghqcqhjY1Xz8rr3KYvvNxXv8PytC4Jv91V7Encm7q+zmTNPOP/M2L37H66LmCsOw1HqTTErwJ5iVajLngzD+Uvp8HJ2yXxI5KieWvUMxxqHLYQp9Z8/myGkxqIrWOGYGKq2pP5xb7lSJUWuMJnDHgO6gEZKqMYA+JLdQylt3VwxGdNsZJo4gY3U5DCfq9qIyCcjkraoFT8qZtje9DueUeN6o4FVdDiUXVOo5BmGGkhT5n3pfnlPRluCrbslm8VNIA1HP8KsJr9qEhCNZ8PZnHTSi0mjhLRlvdsN7Fliak2T4D4l/4HakTgVxjt+n7KFkn6yEEowPD+8EWKMsImIhnIvjWGxn5sby4L93uC9c+UWgD3SSO2YB957yc+F2izzzOfd9EdifmRoRXuqis0KJZ68CxYrbw/0AGe7K1YZq5gMS6Q5xJLpD7hw78KYc/WvQIYQh+yjCIS6iF/YEUSpm5UaOCmjzdLwEyKukzFEi7gpzyIoPXc6weggeHTXZIDb/Inl208BkYvLoXLU2ZmU99iKZg21fuSQTxcg4bvLHbX1NCsUH/t+WYnErVAC0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(366004)(376002)(396003)(346002)(31686004)(16526019)(186003)(316002)(6916009)(53546011)(6486002)(2906002)(4326008)(2616005)(54906003)(52116002)(31696002)(86362001)(83380400001)(478600001)(66946007)(36756003)(8676002)(66556008)(8936002)(5660300002)(66476007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?ajdLazZyMFVjN2RGU0lEYXdXWnRDSjdIbUx2dWdUM1psL3N6bHFUZXVydnBZ?=
 =?utf-8?B?cThTcGZuNDVMbk1IckNGMDNGT2k1ZkprbG9Xb0J5b0cvd0prMnlXallVS2I3?=
 =?utf-8?B?RG5wTXlzNmVzVER5OHZLMHpTWGd5WHQ2T3Z6aGhMb3dHeFV0Ymhtb3FEVzJH?=
 =?utf-8?B?N2FFejlhU3BCNXdUM1QyeGlKbTJ1VUVaR2dMTmEvNlVDY200bHZFdlB6eWpI?=
 =?utf-8?B?SkhFV0pGdERpOTJNaFJPcnM1SC9GZ3pmWloxV0Ywb3hLMzRMYXh4ZXlJYTlz?=
 =?utf-8?B?bDN1TzNGaG1sSGdtRTQ4cENURllRNFovSEFBYkxVTFduMzdxUEVEbE1qMjJq?=
 =?utf-8?B?VzY0VWxFbWE2U3hNSzQ2a3ZQM2RVdXREdU9RNEFrS21mYTBXSGdWT0NJYi9x?=
 =?utf-8?B?eVhuOUhXejk4cjd1U1J5Sm9hcDJVR25ueFdUZGdMSVNYazV6ZzdRWDBrSkFI?=
 =?utf-8?B?YVk1VFJ5Mjd5VWlwNVdsNkFCaS9UVFFicVhFSjVKN21VaG9XSWgyQ1RCaUVH?=
 =?utf-8?B?OUhYcmJTZmNVV0FXcVhqMUtPV2FrdHF6K1YzVWZybE0za2RXcmxaMVhycU1S?=
 =?utf-8?B?QURYWCsyZHhXbzdjcnRJamJBWjR1elJkWFYzSTRERjFIUzBsRStnZ2JTQTBB?=
 =?utf-8?B?T0xpVnIwc0NrRllaMmFmQThTVUpxWlhGbit4ZVlUNk5LZ3hUa0ZkcnJYbmto?=
 =?utf-8?B?eVhzKzUvK3RaMFR1bEd1REpGV3NRc1lHU3l4aUZVU2VVQ1hBTmtPbXgzNjdh?=
 =?utf-8?B?RmxIV2pSTm5Wb3V6N1JGTjRaVUtsWnNmc0M1RVk1eFo2cjU5allXQjE4WlpP?=
 =?utf-8?B?NnVQMGF0RkFocXFXMnpnaGxqeEpKYkFNTE9hQm1IYXQzV3BOMitlejg1RmVC?=
 =?utf-8?B?cjRNVnRYdGJGZlJoaXhvQXUrQXlOTzlvOW5NVUYzREJOeXJoQm9HN2F5dmNB?=
 =?utf-8?B?M0tUUmhJbEluWHkyNjlac0oxTmtpK0FLVmRyOFN4K1E5Vjg4SitiSXZERE9M?=
 =?utf-8?B?ek1oLzJCYlRFRVM1MFBjRENKSVdsS2dBdDErcW1rMGc3anpMZXRMemlQRXp1?=
 =?utf-8?B?cjRuTkFhUTRaSkE3V0JuZzNETXRWUVd0blZnSzFtQ25vbXYySzF1clpBR25a?=
 =?utf-8?B?T0U3ZWxYVUhEY2c0eXdhM2U5bTVsVHZIaUl6Y2FybGIwbzYwRDJwTjhSd3FC?=
 =?utf-8?B?YnpMeW1vR1ErOU5KZmh4WkxDaGo4TU5vdFhkRE5OOTgvV0lENXVSZWRNaG5u?=
 =?utf-8?B?bERNM2ltV2tGWlZPUUlTU3JJK3A1YUM5Y3UvWHN5RGxLcExjaGtPdTd1TVNS?=
 =?utf-8?B?LzV0dkpBYStsdGF5dEg2TkdBekJ0WWtMcmxMczk0ZGEwUmdTNUE3RHZlMzBV?=
 =?utf-8?B?U0hsMGRNSVlDbnVTajRnWVM0b09hak8wcXdZZ1ZrcktiZGtHLzNxZExzVFRS?=
 =?utf-8?B?ajU4WS9YZW41TE9XckptY0NCR2JrOUxLd1d6dHJLSnZHak85TWVzekVLbkVL?=
 =?utf-8?B?RERzRk5Gc3hTT2JvU1RuNEo1QmZJa2cvS3Bqam9LZTVIaDlWL1pOTTI1TTZk?=
 =?utf-8?B?Y2VOK1RlWERsaUlsbldzM3d1N2NKNTJJb05wT01jUTNEc3IxL2dvL1ZrS1FU?=
 =?utf-8?B?OW1kTnowVmRaM1VBdk9GMDhubHJBTFd2MFA4MnAzNDdUbFExN3RLVHZlamhw?=
 =?utf-8?B?dU9YaWUxMDd3OEpEclE4eXhTZ3lUUDNqVVA4c1pQbGx3cGdEWFdGTGZQNGhJ?=
 =?utf-8?B?N3BCN0gwbkZ5SVlZbERyVkFCVjh3QTMxL2NodlNRODkrdmpCUS9WNmkrSkxh?=
 =?utf-8?Q?iVYic75hOzEBQEuifHTMYOCk5CUofy+lgLCaY=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 490394e8-ab03-4a6b-38df-08d8d82ca98f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2021 18:56:00.8990
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1gb9IbKuKAzHBep9RmzfcYKK9z4gr2o/PNgLhVyhg2C2N5Kj+BWPQAIyKVsiRf30
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4435
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-02-23_08:2021-02-23,2021-02-23 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 spamscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 bulkscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2102230157
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/23/21 12:03 AM, Andrii Nakryiko wrote:
> On Wed, Feb 17, 2021 at 12:56 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> A new relocation RELO_SUBPROG_ADDR is added to capture
>> local (static) function pointers loaded with ld_imm64
>> insns. Such ld_imm64 insns are marked with
>> BPF_PSEUDO_FUNC and will be passed to kernel so
>> kernel can replace them with proper actual jited
>> func addresses.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 40 +++++++++++++++++++++++++++++++++++++---
>>   1 file changed, 37 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 21a3eedf070d..772c7455f1a2 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -188,6 +188,7 @@ enum reloc_type {
>>          RELO_CALL,
>>          RELO_DATA,
>>          RELO_EXTERN,
>> +       RELO_SUBPROG_ADDR,
>>   };
>>
>>   struct reloc_desc {
>> @@ -579,6 +580,11 @@ static bool is_ldimm64(struct bpf_insn *insn)
>>          return insn->code == (BPF_LD | BPF_IMM | BPF_DW);
>>   }
>>
>> +static bool insn_is_pseudo_func(struct bpf_insn *insn)
>> +{
>> +       return is_ldimm64(insn) && insn->src_reg == BPF_PSEUDO_FUNC;
>> +}
>> +
>>   static int
>>   bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>>                        const char *name, size_t sec_idx, const char *sec_name,
>> @@ -3406,6 +3412,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
>>                  return -LIBBPF_ERRNO__RELOC;
>>          }
>>
>> +       if (GELF_ST_BIND(sym->st_info) == STB_LOCAL &&
>> +           GELF_ST_TYPE(sym->st_info) == STT_SECTION &&
> 
> STB_LOCAL + STT_SECTION is a section symbol. But STT_FUNC symbol could
> be referenced as well, no? So this is too strict.

Yes, STT_FUNC symbol could be referenced but we do not have use
case yet. If we encode STT_FUNC (global), the kernel will reject
it. We can extend libbpf to support STT_FUNC once we got a use
case.

> 
>> +           (!shdr_idx || shdr_idx == obj->efile.text_shndx) &&
> 
> this doesn't look right, shdr_idx == 0 is a bad condition and should
> be rejected, not accepted.

it is my fault. Will fix in the next revision.

> 
>> +           !(sym->st_value % BPF_INSN_SZ)) {
>> +               reloc_desc->type = RELO_SUBPROG_ADDR;
>> +               reloc_desc->insn_idx = insn_idx;
>> +               reloc_desc->sym_off = sym->st_value;
>> +               return 0;
>> +       }
>> +
> 
> So see code right after sym_is_extern(sym) check. It checks for valid
> shrd_idx, which is good and would be good to use that. After that we
> can assume shdr_idx is valid and we can make a simple
> obj->efile.text_shndx check then and use that as a signal that this is
> SUBPROG_ADDR relocation (instead of deducing that from STT_SECTION).
> 
> And !(sym->st_value % BPF_INSN_SZ) should be reported as an error, not
> silently skipped. Again, just how BPF_JMP | BPF_CALL does it. That way
> it's more user-friendly, if something goes wrong. So it will look like
> this:
> 
> if (shdr_idx == obj->efile.text_shndx) {
>      /* check sym->st_value, pr_warn(), return error */
> 
>      reloc_desc->type = RELO_SUBPROG_ADDR;
>      ...
>      return 0;
> }

Okay. Will do similar checking to insn->code == (BPF_JMP | BPF_CALL)
in the next revision.

> 
>>          if (sym_is_extern(sym)) {
>>                  int sym_idx = GELF_R_SYM(rel->r_info);
>>                  int i, n = obj->nr_extern;
>> @@ -6172,6 +6188,10 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
>>                          }
>>                          relo->processed = true;
>>                          break;
>> +               case RELO_SUBPROG_ADDR:
>> +                       insn[0].src_reg = BPF_PSEUDO_FUNC;
> 
> BTW, doesn't Clang emit instruction with BPF_PSEUDO_FUNC set properly
> already? If not, why not?

This is really a contract between libbpf and kernel, similar to
BPF_PSEUDO_MAP_FD/BPF_PSEUDO_MAP_VALUE/BPF_PSEUDO_BTF_ID.
Adding encoding in clang is not needed as this is simply a load
of function address as far as clang concerned.

> 
>> +                       /* will be handled as a follow up pass */
>> +                       break;
>>                  case RELO_CALL:
>>                          /* will be handled as a follow up pass */
>>                          break;
>> @@ -6358,11 +6378,11 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
>>
>>          for (insn_idx = 0; insn_idx < prog->sec_insn_cnt; insn_idx++) {
>>                  insn = &main_prog->insns[prog->sub_insn_off + insn_idx];
>> -               if (!insn_is_subprog_call(insn))
>> +               if (!insn_is_subprog_call(insn) && !insn_is_pseudo_func(insn))
>>                          continue;
>>
>>                  relo = find_prog_insn_relo(prog, insn_idx);
>> -               if (relo && relo->type != RELO_CALL) {
>> +               if (relo && relo->type != RELO_CALL && relo->type != RELO_SUBPROG_ADDR) {
>>                          pr_warn("prog '%s': unexpected relo for insn #%zu, type %d\n",
>>                                  prog->name, insn_idx, relo->type);
>>                          return -LIBBPF_ERRNO__RELOC;
>> @@ -6374,8 +6394,22 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
>>                           * call always has imm = -1, but for static functions
>>                           * relocation is against STT_SECTION and insn->imm
>>                           * points to a start of a static function
>> +                        *
>> +                        * for local func relocation, the imm field encodes
>> +                        * the byte offset in the corresponding section.
>> +                        */
>> +                       if (relo->type == RELO_CALL)
>> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
>> +                       else
>> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm / BPF_INSN_SZ + 1;
>> +               } else if (insn_is_pseudo_func(insn)) {
>> +                       /*
>> +                        * RELO_SUBPROG_ADDR relo is always emitted even if both
>> +                        * functions are in the same section, so it shouldn't reach here.
>>                           */
>> -                       sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
>> +                       pr_warn("prog '%s': missing relo for insn #%zu, type %d\n",
> 
> nit: "missing subprog addr relo" to make it clearer?

sure. will do.

> 
>> +                               prog->name, insn_idx, relo->type);
>> +                       return -LIBBPF_ERRNO__RELOC;
>>                  } else {
>>                          /* if subprogram call is to a static function within
>>                           * the same ELF section, there won't be any relocation
>> --
>> 2.24.1
>>

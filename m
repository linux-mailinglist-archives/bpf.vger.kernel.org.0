Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3123D31492A
	for <lists+bpf@lfdr.de>; Tue,  9 Feb 2021 07:57:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbhBIG5T (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Feb 2021 01:57:19 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:53728 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229691AbhBIG5P (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 9 Feb 2021 01:57:15 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1196h4Nr000498;
        Mon, 8 Feb 2021 22:56:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=/HhAkpBfshs6gUV1lrcqTCSiY7cnRf4TB3Xg78HSMxM=;
 b=RTzBr3VbgUadMQxWlYpVsFZSl+1ghoaM7NoiQxvmLWeSaaLV2Erl1Ho5IK/oR8lBjxQ9
 vW2s6Z4DAPVk/v6PEv/vH/vonJvZeaSZNQClj37sce/AIUbq5Vb4Y92Jlfpq2zsd5eOI
 I9rkgdP3ZccGKro/3eNeR/TRwiN09EKJkgs= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 36hstpc2sm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 08 Feb 2021 22:56:21 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Mon, 8 Feb 2021 22:56:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nVp+Fc1ldJ3Eiz1j/oqKb1LKajqpvDuMLOBGTvE+mljAzDi7pFv1qOayxFohXSiZBGR5HGKdeD/cdgOckJzukwnQbu8iH3bYMWHPJEUvz/Dq/oCrcgUS2BU+UVIBr+qBj25ZHzE/QQSEusjVIWAqZ7q97ibgvRwq03zXae/VceFC1MwlLhXMKus3Uz1r2bZIkW74hu/Jw0BB+WKptvoG3zgvGiATnKrKpm32M7mdGpgZbh7UfwtIM0zK7cPiFKVH8ehhGCjLHHxcMd5RJGFakj9TW9zi/A8FhMfhoLCAVBNJrRZQVkDoA3e69Nt/z5K9+HmLD243MZwDxsWca0EIZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HhAkpBfshs6gUV1lrcqTCSiY7cnRf4TB3Xg78HSMxM=;
 b=To7bGAyKADlWv/yzOw6FBmRQ0cu+/3ftlclWoOp2aHEh18txQ/b5EgIqPiZWtrrIer+NOVk35ZvX7xYhOD05InA6hBicGNHXpMaK38+RTusyEQkwOkO+dQXZNcHKtI6EK0hvSR19lH/L7Nu68V7xEvzCdA2SibnbcgJz4ZzH48uwJ9zZLcU0stPsD8yFvQFiQ0Tp+yl7NNEkb5lPpPYz35dwlCHOsxEdTN3vJrdChHRamz6NiM28uGA9wyfzDHJftG+T3Ke0hEVdCxfQ9PWG6s0HWETiCxQFPCK3TMcetXgmFL8OBySWnFm1qFL1YEAJpIibQNw/xTZIrN1j76FVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/HhAkpBfshs6gUV1lrcqTCSiY7cnRf4TB3Xg78HSMxM=;
 b=GZuVfx7f8Q9+5i3Xru+4m++Gyymx/g0Co3D0HqAWLsGVvQRW3ZbdvMMbQj6zmSntm9I1rZaHr19JmHN2kbrxWNyO9CM2g5KsltSL/n050mSP09gIu6L5N+Rh6jcYWkfbMnKSET36CjJsLNCxNyI30pVbabXiBP2yN+Iz3WJFdG0=
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2262.namprd15.prod.outlook.com (2603:10b6:a02:8c::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.24; Tue, 9 Feb
 2021 06:56:12 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::61d6:781d:e0:ada5%5]) with mapi id 15.20.3825.030; Tue, 9 Feb 2021
 06:56:12 +0000
Subject: Re: [PATCH bpf-next 5/8] libbpf: support local function pointer
 relocation
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
CC:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20210204234827.1628857-1-yhs@fb.com>
 <20210204234832.1629393-1-yhs@fb.com>
 <CAEf4Bzai4qFDrVidGncaRMABiz2vNTRyWBftLm1Z_LTNNtfmHQ@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <48fbc3ee-739e-8baf-9165-77b7e92ab1e0@fb.com>
Date:   Mon, 8 Feb 2021 22:56:09 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.7.1
In-Reply-To: <CAEf4Bzai4qFDrVidGncaRMABiz2vNTRyWBftLm1Z_LTNNtfmHQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:e222]
X-ClientProxiedBy: MW4PR03CA0290.namprd03.prod.outlook.com
 (2603:10b6:303:b5::25) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1610] (2620:10d:c090:400::5:e222) by MW4PR03CA0290.namprd03.prod.outlook.com (2603:10b6:303:b5::25) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.21 via Frontend Transport; Tue, 9 Feb 2021 06:56:11 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 20c60490-3dda-47a7-0daf-08d8ccc7c974
X-MS-TrafficTypeDiagnostic: BYAPR15MB2262:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR15MB22620EDB4F3F06A85C5CB926D38E9@BYAPR15MB2262.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:4714;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NVJhwbht6nsG/2TIbkx4w9AtWcBsjE+h12Shn6zEN7LzXYnbhVDOVlRSDBBqAUoLCiX+OTVz90W5WCeNbqZ1Isc0sHIoqDgIT5s1RL+TYpTR+shWZr1gWrg3y0FXx4dyNr2E5/YGEGKKGxPVOw/Q30Oj0ev8fWf7anzegaGqJUA+pztPEqs5QHSvhe2GmiXPHS6rj/L9qw6m/ItuyFRpbWI7vIKl0O1O7CZ2aNzTTyFiNooOcGnJOiFAj+lsLfETyuGKqzQYvEL/MY9adR7BKbsYSBRQdytW00gcj7z/ZXJAPgLtN87lKU/jTxyDz40WzL9vRsXt/Hry9A8IiF5/Lnqrf4A670ZgDCqj1bBFPaNb0Tr74YqqbkANIDHLcaxvnQMrwlj2VsguJkaSQ6feXWUozO5KMXfE8AlvDCcCnIfGA7sy0gim7tG5zMGUQJx23qRKPQhWYs1dSDOMkSscacjfbt+Rma6BG2+m5Y7S3ETgsQStVpsDvPASPX24uU3UltHL+INCV1FrCPF/zkzV34QuekJCHc7NqBzIBKot/EQeFGgJ/oh/UbOdBTXrhvBxtPqdYv6IsUWGB+Wz3zyufnU+mHPoQUrJBEgXYy8/dWQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(346002)(366004)(39860400002)(376002)(136003)(36756003)(6486002)(8936002)(6916009)(2906002)(66556008)(5660300002)(2616005)(66946007)(31686004)(31696002)(316002)(52116002)(53546011)(66476007)(478600001)(186003)(4326008)(16526019)(83380400001)(86362001)(8676002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SGd3OVplaEdaT1FUekZJak54aEFIbUpBOGVMNnNjZlR3dkt0dVZxbEx3bDIx?=
 =?utf-8?B?V3M0bXRKcHo3ZlNmc2E5VEVqaHNzVGNmNDdFbS9LK0grTWhPYU9SNVkrejQ2?=
 =?utf-8?B?eHhpWGlVUFd6U3Rkd2sxdnhoWDdNbGNWUUtRUTJGaHNhTEhFRG5mNjV0emdB?=
 =?utf-8?B?UnVTKzM3dE9FdzMyQWZFalJ0YUZOSXd6SWRhQjFwTDhMZGFpalZENHE3NjFz?=
 =?utf-8?B?VWhNNGNQQk1DRVVadUtFd0Q0ZCtROWttNitsR1VGaHBlc3FJdUh1bGlla29I?=
 =?utf-8?B?S2NjREFwUnJWZGVhZkZsRTMzWCt3ZU0yWnFLMnlJbmpmdEwyM0tVclFKSHRr?=
 =?utf-8?B?Mk0yc3BaTXZFUWpEM1c3d1BuNVFqenlZYkwrQVJCYWtsem95NFBWMHdlb0VP?=
 =?utf-8?B?TUpVQ2IyTGQ4eUhBT24wWE9LR2hPWXN5RHVlN2xyTWR3Smk3QUJQRzd4dmRI?=
 =?utf-8?B?Q3R4cmpJQ3NFaGhHME1TOFpNRjZOMUF5cXhZbTJsTmEyOHV0b0o0QUlhcWUv?=
 =?utf-8?B?NDljc1E2VmExbVhEWHhMbWw5RjhaTG9lL2hJaVFSRWI2QzdYUzJ1dDVCRURB?=
 =?utf-8?B?UXJVaU5aOWR1aHhSS0doTG9lRWpsaHJURmZ1RGNXY3MySWhpZzhoN3NPUDBB?=
 =?utf-8?B?eE5DZmpXay8xTHdvSFE4aGo1ZEdid21CWDFUbE5pTU1oWThVaG53a3o4ZDM1?=
 =?utf-8?B?aTdWWVFuK3paMlpGVnEwbDA1NVJwbkVpcC91Um03dnhreXlnT2dlWndhdG9H?=
 =?utf-8?B?Wmt0TFhPOGZJRTBsY2FQYTgyTC8rVzhVZk9ybWJDR0p0aXl0eitkbnhMSDI1?=
 =?utf-8?B?ZHN4QnpCbW8zcWNZMTBxR2Q1anFnMFlJajNLVkJYZS9JQS9ZYjFQY08vWFB1?=
 =?utf-8?B?dnE4YlNiRmk5RWdxRXZCcHo1bEtVbG1LalYwZmVLT1FmdzJNUnVmWEZBay9v?=
 =?utf-8?B?S09ySkg2c2xZK2w2RDF1VnV3RjFsV3k0RTNEWFgwQXlTaE84OUN3bmFVTm9k?=
 =?utf-8?B?bUQ5K2pvZlNEWnM1dy9BZnNiVmorK0RKKy9sNmFXY2JwSmFoa0VvYUtBSyt6?=
 =?utf-8?B?aGRTQUtQd1dBMFV6TllrQzNKSzl5SGVEQWlJdW55OFI0MkdLNVJ3aGNmMFZM?=
 =?utf-8?B?dmdGalp1WFFzZExPb1hyK2pFaXRDOWxOUjAwWVIydHB4SE03WFMzUEZqanoy?=
 =?utf-8?B?RldSbi9IbWltbmV6UnExRStxbmNhTnNpUWZMSk9oWFR2STcwK0JBeG1KUU1q?=
 =?utf-8?B?L1dFNTl1eDhCWUtzWkZMTTFwUGlmLzJPR3BZVGsyS3hoTzBjci9xMkozSFdK?=
 =?utf-8?B?LzZ4a2VkbStOMVR4cjVCOTJHYVNDTXU4TGl3WnZtUTkvL3BSbXpMSW9CdG9r?=
 =?utf-8?B?QkRKdEZxMVRIaWRGcmJraVQzWnlVSXFncU9ENHE3QmZoWjRhcENhSTlBTncr?=
 =?utf-8?B?b3JRWGJSalE1QzMwSDBxbDBaQlpOMFp3RE9jc3ZvZ05CZkRMcXQxYWZPNzFj?=
 =?utf-8?B?T0srVWNkbndhVjNGNkhxU1BkbHFNL2JpSWpCWWRpQytBWVpQQ21VMkVIZlRh?=
 =?utf-8?B?d0R3SzFsZ1Y5Z3FWS3VZSnNoN0JpTlpuY3VEcE9rZUN2ekROYnRGanl1T1lq?=
 =?utf-8?B?a0tRU0I4NTIxeEs1VStERVJhdnR6UCt6UTVjMytWa2d1WnZwbUhyRjB6enBO?=
 =?utf-8?B?MTRnZVNLRyszYXlpK3lhN0tDMFh6SiszUnZyY2gvYUVaQWE0a2FoUUxUNnlY?=
 =?utf-8?B?NkhkZ2tGV3RmQklGU1MyQndiMTd6c0x6c2JUK3FRcXM3VGR1ZlpJb3pieWh1?=
 =?utf-8?Q?gke54lr/zIIgA7nYqkiib+vnQ8lLrp5I/TRsw=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 20c60490-3dda-47a7-0daf-08d8ccc7c974
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2021 06:56:12.4518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lF+cnKeiBqrcGwNEoaQrdrd090mXw4HXFYHDIZZW3fGc4BBLyvv4FJd3JP787BYh
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2262
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.737
 definitions=2021-02-09_02:2021-02-08,2021-02-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 suspectscore=0
 malwarescore=0 impostorscore=0 mlxlogscore=999 mlxscore=0
 priorityscore=1501 phishscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2102090035
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 2/8/21 10:52 AM, Andrii Nakryiko wrote:
> On Thu, Feb 4, 2021 at 5:54 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> A new relocation RELO_LOCAL_FUNC is added to capture
>> local (static) function pointers loaded with ld_imm64
>> insns. Such ld_imm64 insns are marked with
>> BPF_PSEUDO_FUNC and will be passed to kernel so
>> kernel can replace them with proper actual jited
>> func addresses.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/libbpf.c | 33 ++++++++++++++++++++++++++++++---
>>   1 file changed, 30 insertions(+), 3 deletions(-)
>>
>> diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
>> index 2abbc3800568..a5146c9e3e06 100644
>> --- a/tools/lib/bpf/libbpf.c
>> +++ b/tools/lib/bpf/libbpf.c
>> @@ -188,6 +188,7 @@ enum reloc_type {
>>          RELO_CALL,
>>          RELO_DATA,
>>          RELO_EXTERN,
>> +       RELO_LOCAL_FUNC,
> 
> libbpf internally is using SUBPROG notation. I think "LOCAL" part is
> confusing, so I'd drop it. How about just RELO_SUBPROG? We can
> separately refactor these names to distinguish RELO_CALL from the new
> one. It would be more clear if RELO_CALL was called RELO_SUBPROG_CALL,
> and the new one either RELO_SUBPROG_ADDR or RELO_SUBPROG_REF (as in
> subprog reference)

Yes, we can use RELO_SUBPROG_ADDR.

> 
>>   };
>>
>>   struct reloc_desc {
>> @@ -574,6 +575,12 @@ static bool insn_is_subprog_call(const struct bpf_insn *insn)
>>                 insn->off == 0;
>>   }
>>
>> +static bool insn_is_pseudo_func(const struct bpf_insn *insn)
>> +{
>> +       return insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&
> 
> there is is_ldimm64() function for this check (just move it up here,
> it's a single-liner)

I did not know it. Will use in the next revision.

> 
>> +              insn->src_reg == BPF_PSEUDO_FUNC;
>> +}
>> +
>>   static int
>>   bpf_object__init_prog(struct bpf_object *obj, struct bpf_program *prog,
>>                        const char *name, size_t sec_idx, const char *sec_name,
>> @@ -3395,6 +3402,16 @@ static int bpf_program__record_reloc(struct bpf_program *prog,
>>                  return 0;
>>          }
>>
>> +       if (insn->code == (BPF_LD | BPF_IMM | BPF_DW) &&
> 
> just move this check below the next if that checks !is_ldimm64, no
> need to do it here early.

Okay.

> 
>> +           GELF_ST_BIND(sym->st_info) == STB_LOCAL &&
>> +           GELF_ST_TYPE(sym->st_info) == STT_SECTION &&
>> +           shdr_idx == obj->efile.text_shndx) {
> 
> see above how RELO_CALL is handled: shdr_idx != 0 check is missing. We
> also validate that sym->st_value is multiple of BPF_INSN_SZ.

Okay. Will add additional checking.

> 
>> +               reloc_desc->type = RELO_LOCAL_FUNC;
>> +               reloc_desc->insn_idx = insn_idx;
>> +               reloc_desc->sym_off = sym->st_value;
>> +               return 0;
>> +       }
>> +
>>          if (insn->code != (BPF_LD | BPF_IMM | BPF_DW)) {
> 
> feel free to use is_ldimm64 here as well, thanks!
> 
>>                  pr_warn("prog '%s': invalid relo against '%s' for insns[%d].code 0x%x\n",
>>                          prog->name, sym_name, insn_idx, insn->code);
>> @@ -6172,6 +6189,9 @@ bpf_object__relocate_data(struct bpf_object *obj, struct bpf_program *prog)
>>                          }
>>                          relo->processed = true;
>>                          break;
>> +               case RELO_LOCAL_FUNC:
>> +                       insn[0].src_reg = BPF_PSEUDO_FUNC;
>> +                       /* fallthrough */
> 
> fallthrough into an empty break clause seems a bit weird... just break
> and leave the same comment as below?

Yes, "break" seems cleaner.

> 
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
>> +               if (relo && relo->type != RELO_CALL && relo->type != RELO_LOCAL_FUNC) {
>>                          pr_warn("prog '%s': unexpected relo for insn #%zu, type %d\n",
>>                                  prog->name, insn_idx, relo->type);
>>                          return -LIBBPF_ERRNO__RELOC;
>> @@ -6374,8 +6394,15 @@ bpf_object__reloc_code(struct bpf_object *obj, struct bpf_program *main_prog,
>>                           * call always has imm = -1, but for static functions
>>                           * relocation is against STT_SECTION and insn->imm
>>                           * points to a start of a static function
>> +                        *
>> +                        * for local func relocation, the imm field encodes
>> +                        * the byte offset in the corresponding section.
>>                           */
>> -                       sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
>> +                       if (relo->type == RELO_CALL)
>> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ + insn->imm + 1;
>> +                       else
>> +                               sub_insn_idx = relo->sym_off / BPF_INSN_SZ +
>> +                                              insn->imm / BPF_INSN_SZ + 1;
> 
> nit: keep it on a single line, it still fits within 100 characters and
> is easier to visually compare to RELO_CALL case.

Okay.

> 
>>                  } else {
>>                          /* if subprogram call is to a static function within
>>                           * the same ELF section, there won't be any relocation
> 
> don't we have to adjust insn->imm for this case as well? Let's add
> selftests to make sure this works.

This is for relo == NULL. I think my code (RELO_LOCAL_FUNC or 
RELO_SUBPROG_ADDR) won't hit this since there always relocations. That 
is why I didn't do anything here.

> 
>> --
>> 2.24.1
>>

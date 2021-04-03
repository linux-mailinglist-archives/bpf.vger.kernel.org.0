Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C0B9353580
	for <lists+bpf@lfdr.de>; Sat,  3 Apr 2021 22:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236649AbhDCUVE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 3 Apr 2021 16:21:04 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:57504 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231658AbhDCUVE (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sat, 3 Apr 2021 16:21:04 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 133KGHnu013160;
        Sat, 3 Apr 2021 13:20:56 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=b4mZimQ9lcQT34IDHn6emeqV+UqnQ+Rx6DUOuI9BNsA=;
 b=WSe/EaMWmyReKnwdBsIJHJqgfrtlQsABlZ7JR3SCYSD9veuhHLGa9Sh62E6WXzk68abr
 wmmGiLjDcTRFB+r9s1qj70xhiN7Ip7ZMRBfXwBCoiz83MtTFmTNvROmN8Bb7KgmpOXdZ
 ZL0WKW3F/PtbGFbNhb91j3EFcto2hBzu944= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 37pvdnrdrj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sat, 03 Apr 2021 13:20:56 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.36.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Sat, 3 Apr 2021 13:20:55 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LiHc3Ma0MPwu8xnxNLY+SD/KelmScXrNJldwvjZNgcYhT6YS7uYbfEAVDa1MgXGve9DXzFWcQkb8f6C2T7JLU9jtlhJD1t7cpxOfDbp3ZoMXe6LqIDDYukCTBjep61M/1wf0jEG0+kyz+er/tpaLfn02uaLu2L3bDYV0qmQMSrOFb2Y+m7joVbCqK/9KNn9Odzvc/pp2raT0SiWwcf4+v4a8FIruz3ogLKTjTH030ge3z6KZjD0Pnkbk/RQkXYR6ZwSBkTzMxNxHp9V6QTcjq+b5Ua6MU9Lmci/F1md+k1ts6O5QQF9HZuKVlEA4mmLT9Slfn3TdXpwnC4e16qbvXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b4mZimQ9lcQT34IDHn6emeqV+UqnQ+Rx6DUOuI9BNsA=;
 b=AplMn6ME71tnyu94Y3yVk/Fd3qxbxyRCDADzkbM9RFXP2g4bMD7U/Eo/MSBllDNV7bBys0r5SWElb5vyeWc891ySQgsbyD0aMoAMw4Y97T3KjMGwwHbQkYOP4NimtyJQNhfVoawEIRNpd5n6WEoivUh28/Tm6s+EemcSBof877WXpQAYeslQ81tav5btvYTHFoNNbTZFOGJJIOfSCH+SBt7ob8FZFZi1T+mzInGbkH7UieaX2gIqUBgICmHuHcPUXyh5CE7Aov99mgInpPUaZtpvu0/FzaMhrIUJFA42TGFxN9lOTZMMUhOVyx1hW4f4kEB1JzNuAusQHLU5IiwEAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: gmail.com; dkim=none (message not signed)
 header.d=none;gmail.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA1PR15MB4644.namprd15.prod.outlook.com (2603:10b6:806:19f::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.28; Sat, 3 Apr
 2021 20:20:52 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.032; Sat, 3 Apr 2021
 20:20:52 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle DWARF5 DW_OP_addrx properly
To:     David Blaikie <dblaikie@gmail.com>
CC:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Sedat Dilek <sedat.dilek@gmail.com>
References: <20210403184158.2834387-1-yhs@fb.com>
 <CAENS6EtcOH-Sr0Ct09qzzXb9qBMNyM7Dj9vScffvaz_o=wcvJg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <3661a919-17e8-7511-5f63-5b93ee84fe60@fb.com>
Date:   Sat, 3 Apr 2021 13:20:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <CAENS6EtcOH-Sr0Ct09qzzXb9qBMNyM7Dj9vScffvaz_o=wcvJg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:5ac6]
X-ClientProxiedBy: MW4PR03CA0206.namprd03.prod.outlook.com
 (2603:10b6:303:b8::31) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21e1::1466] (2620:10d:c090:400::5:5ac6) by MW4PR03CA0206.namprd03.prod.outlook.com (2603:10b6:303:b8::31) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.29 via Frontend Transport; Sat, 3 Apr 2021 20:20:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 01e8276b-b92d-4344-a61a-08d8f6ddfa68
X-MS-TrafficTypeDiagnostic: SA1PR15MB4644:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SA1PR15MB46445EF49F030C088A77B697D3799@SA1PR15MB4644.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5nAR77tdO+fRRHbP1VNpMmvRb/KIa6zrxPwgiQiquSBiOOECdutAdRk8wNJJTuOP6BLAeWuOF1el7frnC4MO+Z4Loal4UsNtjUZ6+SLpLdR64Q+RZkDZyt9Gm3faTWfbj9B+FA3fAyDQNdjzMcByLcCrBBu1NGywBm3UxJrrMdXtjdXmm0+anw4RSqb3LZch34rKwJeRv2q29akJxcGwv1n0C0H1IWn33yAJM+sMKj+z9XUfZa3rqACIGEmygXnQ8mOfriAedmPM/2xz3zrOaf9VywYzkiLWs988CuSJ0cuzXLA/3P1ukBy0rQ6/Pv03Kqa0J9ZB6zqZZP/4q+aSMA15R9PtEEKc1OotUFi+iAMvAf+twCmIEDsNlDWNPk7PJSEEHEgnb2MZcfyk+rb5La5f3zAi4aHb6j3eQahp/JErRLd3WUcHnHwv90Uc0IPxoHCmUhbumL47ambycA1Ig/v02B6RMQzt9JY10uft5Ygwk+gUkFEITEASrsnHk+jDCELZmO1FHCbsrLEjkyWWwrSMm6Ip7ShSov77NUUVP37dNmJSVuTZg9Q/DoLVN3SGkfWtGO7q72jDjBwkGDIZILJyS9Whd9Wt25X9G30xFck0PnHGUnCUa9P4B6af6MTuavcw1s/mvvH5WL9RU7MdveUNC/DZG53Ljlgmd++C/WTBYYjmrTpYXdjOaJaODmOFagLYujb+0IZzK1TYGgElhOlJri3zaBqoeFMnkmQgKLc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(376002)(136003)(396003)(39860400002)(6666004)(54906003)(38100700001)(66946007)(16526019)(53546011)(186003)(8936002)(66556008)(478600001)(4326008)(66476007)(36756003)(316002)(6916009)(2616005)(2906002)(52116002)(8676002)(83380400001)(6486002)(31696002)(86362001)(5660300002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?SjNTZ3dZbW5EQW1qT2tCWkN4aVdPd2hXbnV6dXVHU1NxZkhaVVJ2SE9uZHNa?=
 =?utf-8?B?R0RLK09KZGF0NDc1WHR4d3VzdkZIZ1h4dzhUZForQWU2WHIrM0s4YnpZRnBx?=
 =?utf-8?B?Y25zTEptWFBXR2U4ODdJZGRRdjBUeS9oTjJoam9Fd1IzZWo3SjdYM3hvaGtI?=
 =?utf-8?B?a01LWVcxZDNOeHpidXhyTzVnS3FITTREWXI0d3ZlUTNmaG96cFc3Q28rM0xs?=
 =?utf-8?B?L0FnajhWa3ZSaEpkUTJLVE1Sc2pkWDI4YmJVRTFuUmRURUdERWR3YjhaS01o?=
 =?utf-8?B?RjNVUHA1a3Ixa3piWTA3ejlDNHkwTm1aVHhueU1DcGN1ZTkrUkM2RVcyaS8v?=
 =?utf-8?B?dTJZS1JkbUVDSTBpMG1QcDduUFp5L1VCNzF0SmUxbE9aZlU1WEtyMlhOOVdL?=
 =?utf-8?B?akU1WVQ2OWhuZEt5TlF4VXkxL1ZPZi9XbXR2b3JlR1BRTWR0d1pJN2ZpMWsz?=
 =?utf-8?B?OHVzZDh3WkdHTlVUNEpJRHFtZ2tSWDcrdzAwZnFNUVVTNWtUYzBmQ0NiYkFW?=
 =?utf-8?B?T2pRSUJHWjBiUlJHNksvWGlLRnFOYUNIMlc2WGdGMkNWZGVtOWRQTEYzOTBj?=
 =?utf-8?B?RDNIb05Vd3ZFdlpNYzRSbld2RXdCWEsyVm1nSlliMmdTVXJ6UGRRTmJkdm1N?=
 =?utf-8?B?OU5lYU5aZEJGOXJRdzRRUEhNSmNKalhSVVN3N3ArL2pYSFRod1V3OXBZT25i?=
 =?utf-8?B?K2oxZGczVTF6SDJCalkrSklEbDVUL011bmg3ZHMvVE1lcWlkZXlBWHJHSDNn?=
 =?utf-8?B?M2s0QkFOQ1lBUEdNVGxBNDJ0bWcycWEySXpPb0F2b0lycFdYbG9ZeWlPY21B?=
 =?utf-8?B?Uk9xeHpRN2RtNGszckdNWkYrbHNJTEpwOHBWankxQTlQTlhqK3pBcGZPVEZo?=
 =?utf-8?B?bERUMmpIaHRkRy82RTErMGJwZ01lY01kWXpxWDk3SjNKb1RyUCszZGxOdWg2?=
 =?utf-8?B?RnJTYm9pK3FXb2lFT2ViWVhkUW9wUjNDT3RTNDFUSVllbENsLzUyV1NsMkFr?=
 =?utf-8?B?UTR6SDRxTVB4T0xvd0ZkVi9DTFBnM0NnOGhBMXgwRHl1Q21KUTZWRUVsYnRi?=
 =?utf-8?B?Y3FzWGU4VTJxZnRyc3hLb1VWbXlTSjNpL0JrZE5uczU0TEpkdzNHclhhSnlW?=
 =?utf-8?B?WFIweDlsR1FSQ2VZMGEyMmN2RERzanlVK203TUxZam9nZURvL1RueG5WZy9Y?=
 =?utf-8?B?UnRDZnVTdWN4eWxsUVN2T2FMUlplRjZ1NEdYUEl4dTZFQ000YTRpdTB0YzhL?=
 =?utf-8?B?WVFmZVcrbVVJSzMvNDU4dWNlS0xMSDg0ZGR4NElCRzYrcHBlcGJMNWZ2cWFC?=
 =?utf-8?B?NGg5TCtJank2L2lmOUtvTmtlVnhPcVMyVWRkU2JSMzRDSHpWR0Z2OTdJN2Zw?=
 =?utf-8?B?L2VvVExPZUMyY3JSMkl5T1QvZFVsUi9ScnA0S0RnU3l3YU95bk9xbnJQK3ha?=
 =?utf-8?B?UWFLNHpDUmkraW55K1dwakZLZGNKTExXT0gwcnNlTjJ4Q0RnMzdWOXJnNjJt?=
 =?utf-8?B?QkRtSWNlL1FKOFRSaUJ0QlNZTDBxc2I1aDRqa3JMV2RTVnM0cTJnZTlER09O?=
 =?utf-8?B?akIzbGJSd2JaRXY3SzhFdnRuK2orN0ZaU3hHcFZML1dnYlU1dTZGUEZORjhp?=
 =?utf-8?B?WnB5dmpESHRJUnpGUWNYelpCK1QzVGFzb1gycjdFekZKWUFpZC8yM1FyNFFt?=
 =?utf-8?B?d1VkcnBSYnZXVkp4eEh4MHE3UXAxS1prYU9mKzZpL1Y0MTZUNzlCTDNtWDZu?=
 =?utf-8?B?akw5dXoyY1lYVnhJRjJMUXRYdk9aVkI0RzQ5MXJaYjhwMmFRNGlVL1diN0Nk?=
 =?utf-8?B?UklOOHlIUEVxWVdxaHR1UT09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01e8276b-b92d-4344-a61a-08d8f6ddfa68
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2021 20:20:52.4311
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XSGi9wTLzMOeVZEJjUC1v68eGYy3Vn7Z3Z/hswndM5VoC04xgwFUhD20RKuhxiiZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB4644
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: z530VwRiqqDivbol6zW-8Aiw_dwnbuL4
X-Proofpoint-GUID: z530VwRiqqDivbol6zW-8Aiw_dwnbuL4
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-03_09:2021-04-01,2021-04-03 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxlogscore=999
 priorityscore=1501 mlxscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 impostorscore=0 bulkscore=0 clxscore=1015
 suspectscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104030142
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/3/21 11:52 AM, David Blaikie wrote:
> On Sat, Apr 3, 2021 at 11:42 AM Yonghong Song <yhs@fb.com> wrote:
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
>>            help
>> and tried DWARF5 with latest trunk clang, thin-lto and no lto.
>> In both cases, I got a few additional failures like:
>>    $ ./test_progs -n 55/2
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
> 
> 
> ^ this change is probably overly narrow. DW_OP_addrx could appear at
> other locations in a DWARF expression. So whatever code is responsible
> for doing general evaluation of DWARF expressions should probably be
> the place to handle this so it can deal with the full generality of
> expressions, not only this specific case of a DW_OP_addrx as being the
> first operation in the expression?

We really have a narrow usage here. This code path (DW_OP_addr and 
DW_OP_addrx) is triggered and later on only used when converting
dwarf to BTF for certain category of global variables and that is
why address is needed. The above code is only called for
DW_TAG_variable.

The previous code to handle DW_OP_addr also only took the first expression.

         if (attr_location(die, &location->expr, &location->exprlen) != 0)
                 scope = VSCOPE_OPTIMIZED;
         else if (location->exprlen != 0) {
                 Dwarf_Op *expr = location->expr;
                 switch (expr->atom) {
                 case DW_OP_addr:
                         scope = VSCOPE_GLOBAL;
                         *addr = expr[0].number;
                         break;
	......

Do you think we could have multiple OPs for an *external* variable location?

> 
>>
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

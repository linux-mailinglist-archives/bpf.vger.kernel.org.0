Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6040652A907
	for <lists+bpf@lfdr.de>; Tue, 17 May 2022 19:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239696AbiEQRPW (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 May 2022 13:15:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiEQRPV (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 May 2022 13:15:21 -0400
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87BDE4FC6F
        for <bpf@vger.kernel.org>; Tue, 17 May 2022 10:15:20 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
        by m0089730.ppops.net (8.17.1.5/8.17.1.5) with ESMTP id 24H8JNfR008661;
        Tue, 17 May 2022 10:15:06 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=UKYUaSZdIaFDHJ1ZfIY5lrp03LmSruqI4/of0vahUw8=;
 b=pxNiXCpp7NV6+mgQzmU1Q8pIB+tl6Hs7jTEwZgtXB9VKXUVGZUCrJfG0BUu4FFlnB8um
 eTWkS9BB/QW0Gx2yv1Zh5z65zeTScWCilPoNtcl2krz9OPN1r5xxeVrO8ZxgozdeJDUO
 bs5vAndAabY5TG4H1EcoWimR5Lfz79jSqrc= 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2173.outbound.protection.outlook.com [104.47.57.173])
        by m0089730.ppops.net (PPS) with ESMTPS id 3g4836kc0r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 May 2022 10:15:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYt2GRVndlV1APU68i/JiD3ytfsiIn0DHV/Pq2677hyiZickGIEkiodclq6GOdfqU5zp/+sJAFW0K8775giTO7efwLeFfct9vGaArt4/y8nnIqMnBWCCr7xkmbMpQCP4lzh/dgpsusRnWZRcWP4BWqEc27bFMeERIku4eJQNEHFl1cG9Eh4z5xfcXQhMNadJmxp4F+gsIq9AMGC90FtLWz9tb5Onyz7kMXttyJdeCKId6wDRiCV/zOJpV7zlQs9GVo/sXuNZnsNefLM3XCK+Vq0Yuefh27rsxk0PATGEeIA0EHZj2NQC0qJFal8aaMx9B0biYyUTifDvq1ZW7Nc4yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKYUaSZdIaFDHJ1ZfIY5lrp03LmSruqI4/of0vahUw8=;
 b=kF13GWOZzEchecpq7YL/pWU6ZZuORvAOs2bXa7BC+idj5EdSEfKqDBKjrykF2iU4UeZeHlyduy+6Efmu83+fq6kIjsZdUIYbsz7Bt+HsfnQ+J3yduJJAm57/Zbo91LXBLGqr+t7ppW764kHCnfeyWbAxmVEr4S1kWZrlK+MgpEyQmB/Fzp+h59tBZNg60bowGC+fKSXEUHsAihGxfjOysA/A+uGzphw+Y9ct2HlZs0IfAOcmzBADDoE9PHslvNXHHjH8SEAZYONQr8bizF/rEDgUXdB1Vln84sB7Co1zyC+Jig5tLc6fxAw9X8UlmR0F1EYc4aBDjGv2Eb2JVQKqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW2PR1501MB2106.namprd15.prod.outlook.com (2603:10b6:302:d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.18; Tue, 17 May
 2022 17:15:04 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::5811:4996:bbfd:3c53%7]) with mapi id 15.20.5273.013; Tue, 17 May 2022
 17:15:04 +0000
Message-ID: <59bebb88-b3b4-093e-46f7-18373172b998@fb.com>
Date:   Tue, 17 May 2022 10:15:02 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH bpf-next v2 07/18] libbpf: Add enum64 support for btf_dump
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>
References: <20220514031221.3240268-1-yhs@fb.com>
 <20220514031258.3242876-1-yhs@fb.com>
 <CAEf4BzZq1PdMukF4OCKOKAG0owD+NduZkKcYiTYJEM_RW-AZEg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzZq1PdMukF4OCKOKAG0owD+NduZkKcYiTYJEM_RW-AZEg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0014.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::19) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ac32e695-11aa-4e96-d114-08da3828c8be
X-MS-TrafficTypeDiagnostic: MW2PR1501MB2106:EE_
X-Microsoft-Antispam-PRVS: <MW2PR1501MB21062AA8646837B9A6E2786CD3CE9@MW2PR1501MB2106.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zej7G09fxgXcaJZtmp+edV3aBogFPYB74JcmOFkIdtJXghAQsUdkB3yh9QlLJ7FpYYIQuAnSU9jqvs0iHqvZw6Lxr+Cm1rR68IDgJKCyPzFudZk7zGz1BDsbuzfBtD6xrZNjuXQqRnWtOhE/aif2JZCt2uS6D3JWbBRQVXfLbGEIjxeyUbi+BTUrBk/os9w/bHHi24V1sKlqK24iq+0/p0jGgiiDC+aSH+ecK+UQbuocB18bmC8Qaet9RB+9IMTnPANiNVe+7k9a7KdRQTB3rdUnLB5BRaUVuJOx9o1IMnfdqp0UMReXVS55EHkAKpwlLdj6rPSxWq+KXKnjpPJRkb11fYZQhvM0jJiLuS+5hEZzazxyEQQBwjSSNDmTvn2qQ2i+slM6wL553fxoT2eQIxAf8Xe6MCC/LAH0L2bZ59e0qYV8es30cXZ1QcJvwAMTbDsBld4teux4DF20IB3f1KWkQ4ajqoee3B18jL94F3My+JvVmhjO3LICwN0qIu84kk8Sg3oG7A/dIbQOqRD2AIHesxAMp5FSVQKJ6ViKNTPImbrUfp8NIcdwkdKuAeyuSTHJ+9DVOsgFI3bErtBvmHeW7ryiI2SZ96Z2sXOSpzl5XgmvqJs2FQEihhrmUnL/R82vfsPqx2tyqs2IxGQnR/dxmGFvQ5pV8HPuQH6WdORJq7OWQvtq6Hh41RoRDiVESOb1Wh1IMc4m9qXT8bO6Nseffo3cK+zHhJ/OL2aLdFlUMD4yS+zvdFHYwT1uHOa6
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6486002)(6916009)(8676002)(66946007)(66476007)(66556008)(54906003)(31696002)(36756003)(2906002)(4326008)(86362001)(38100700002)(5660300002)(6512007)(31686004)(83380400001)(52116002)(53546011)(186003)(6506007)(8936002)(2616005)(508600001)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S1BlTmFwNUU1ZGZGU1plSmdMTHZ3TXNrb0E0TmU4Ry8wM3NBaStiaVhsNkM1?=
 =?utf-8?B?NUJJNlBOT0Q2b0pCRnZOSDJoRFpUaGFFT2JZV1RJWmQ3RXFWMmNxTU42dTg0?=
 =?utf-8?B?K1ZnWnpybzkrSEpjKzU4R2k3UnhEaFEyOHdnbk1VdmlmSlVkeDVGdFQzY3R1?=
 =?utf-8?B?K21kem16T0FpbHJoMU4zR2pzWTVnU0ozL0NjT1dycW9iNFk1Q2dvdnJNeGZF?=
 =?utf-8?B?SEZLeG1uME1FOGVMZ1JjVWZwd1FNd1B6TThnTGlIdUpHRkVSZ2hyUTZQaGxu?=
 =?utf-8?B?NHFuUWVhUXFWRm43SHd0Q0NWZCtza2VUZXlnYmc0V0pMZHNkaXVIbmFwTVhw?=
 =?utf-8?B?V280TFhHNlg3VFdPNVc1clhhM1NNaVdIeEZSUjlSSVZ0cEYydmVDMnhBUDZn?=
 =?utf-8?B?NUo2b21SMkpOWk5GM1N3bXVBK1dQZGhwd0Q0U3NkckxPbUEraWpRdGN4ZVc5?=
 =?utf-8?B?cUpoaG9vcU90cnZKWjB0WWFqU0JuL0RZcXJSQ2krV3V2dTlDdW02ZHpWamp6?=
 =?utf-8?B?WEYyS1VrOWE1Z3NuNnNnaUFVU2ppYnV6UHZBOVdDbFJNajNmRlNqdGpEWmhH?=
 =?utf-8?B?amZqZE9rMnpPejJ4K3ZoRTZteStmWlRHckllNkZUMllEd3VCcm13cFJTeWUz?=
 =?utf-8?B?RCtlQ0V6ZFN2YjFyWk81clRTVmNMbTFyWnRDRVVVQjgyUnJERHB2dzYzR1la?=
 =?utf-8?B?a016NTY2dmxqOXY1OEoxcmhwclJwbjUwOEFtNWM3a2s3aGRtZDdrRW13YWxw?=
 =?utf-8?B?dkUwbFY1R29weFN2ZHp1ZHJMZmJiNnpQcXpVVG9OdFZSWnhiMXBXZjQrQU9u?=
 =?utf-8?B?ZFpQMVVyK2tzNmZoU2RyeWlFZ0JYQ1Zxc1d0WjVobU8yMFZ6YWtZR0duZUtq?=
 =?utf-8?B?bDJMUGZvd0J1WitqdnpWbS9NVXEwMk5udjEreTB4bXBXMUZEN0dwRSs0bXRu?=
 =?utf-8?B?U1VSU2pZTDh3OWR6NW91TFFYZERUMWt3UVNHWkRZQm95MFZGQmhEd2J0QVdR?=
 =?utf-8?B?UHpNWjFJR28xZVQrN2U4NW1LczJ0T3JlbUJUemJGakVPbytLRFpGc3NLNjhn?=
 =?utf-8?B?VXZiSVNFV1ZnYTYrK2FVc3V4SUlIWUM3Q3A0K2JpRUJJTE5RMGhnalJ0Wnpl?=
 =?utf-8?B?cnNWWFdPWHlpRlpIMTdkakZJTnJNU3dsdWVUbFErZFUwSjlqdFZtajBEaWJX?=
 =?utf-8?B?aTdWcEpKMEZOajEzSUpTWWFnSkdKbDdHOVptVVpmcmtKWUFxTzkyaFl3UDA0?=
 =?utf-8?B?Tjk2OVdBQ2luUGpDODJ1cG1LVjlNZXhSM0hGOHAvOElPRjV3UUl1Y0VWR0xD?=
 =?utf-8?B?ajhob0N0Vml5UGc1TDRYQVR1bk4yREJvTEliZTNrUUtzMnlMUWZRKzFPQW80?=
 =?utf-8?B?NEx3MDREUXlzUUU5MHR6dkRvdFhVdTdqbzN2SHFWNHlrU01HL20zdGhVdTlT?=
 =?utf-8?B?T0FoQlRzby9nNmxkeDFiVTVFS3FUb3ZIY2s4ZzZkMzZUdTJUVmJENC9EWUVj?=
 =?utf-8?B?Zy91MjhycHJ4aVZ6aTVkVHBpbkpFS2ZUcGY1RWtWdi9oUlpqdVlFeEpQNW95?=
 =?utf-8?B?R05kSWRzUWNDWGQwZWhkVXc0RERydVNKOGdSMVVEQmVaWWo2YU1nTjdqWGhE?=
 =?utf-8?B?QXZmREt0eTFtZXBYcjF5WmIvd3BxMnBzREZmY3FwK1Rna0VEa3pNRnRpM2h2?=
 =?utf-8?B?R3UxaE1Fc0lFdmxzaERhN3U0bGRMUkFYNWhGWldjalh3WWNYY3pvM0dVa1Vu?=
 =?utf-8?B?SndZdGRMbHBzY21kS1F4WmRRTTBJdmVwNWl6eGM1aDgyZTF0bzBhM0VWaHFP?=
 =?utf-8?B?MXRSMmc2aGRCTGx1UXNiM0h3cnREUmplU2w2aWpWNDlmNkkybXVRN0VoNW1j?=
 =?utf-8?B?Y2FiQW5KL0NyRGdEMEZEa3kydFd0aEM5MFJ4NHdTQk1ob2VjQVQwM1ZZeFI0?=
 =?utf-8?B?UjdCdjZVdC9Ma0xRdTVpcnEwdmZXM1FZQVhYbStXVTFtM3k2aDFQdmc4ZXRy?=
 =?utf-8?B?UjBsSXIrQkUrQ1EwdDE1QTN0VWVZNFRyWGZDUVNMUmtTNEJXV0l3TDBraENN?=
 =?utf-8?B?Zm0xMnMxY3lTQm9SSTRVYytaV0I1cFRZbVV4UDVRWlBzWnQvcjFsQTdnWjBP?=
 =?utf-8?B?azRZb056Q2lYbzNXQXcvQi9OL1BHRVVUdHk4M3FCa0lKdERUR0dGZUVnWm9a?=
 =?utf-8?B?dTl1bU8yejdQc2RaSkVCb2hKdFlwa2ZFQzFvMEdqY0w0V1FmSTFIekxnN3A5?=
 =?utf-8?B?YXJyT3RpM0haNEZ3YWtES1dlRUJJRE9RM3FRUWV2VXBlTERMWkdqejRhRkg0?=
 =?utf-8?B?M0tybnVoR3E1d3V6TXhrb3VuTExMbUpwZGVVU2hWOXRMcWY5a2c3K0JrVDM5?=
 =?utf-8?Q?SSaksXWjzBKDD8hg=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac32e695-11aa-4e96-d114-08da3828c8be
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 May 2022 17:15:04.5548
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2DONOEMJP6qV7kSLy9Bq4uoHxyCHSKPax8SHn5/08Ws+q5zz4wFbVlpS97St/3cm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW2PR1501MB2106
X-Proofpoint-GUID: 8_lUBqV_TRLPI5CcZ94rfeJqJwtT8Ze_
X-Proofpoint-ORIG-GUID: 8_lUBqV_TRLPI5CcZ94rfeJqJwtT8Ze_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-17_03,2022-05-17_02,2022-02-23_01
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 5/16/22 5:37 PM, Andrii Nakryiko wrote:
> On Fri, May 13, 2022 at 8:13 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add enum64 btf dumping support. For long long and unsigned long long
>> dump, suffixes 'LL' and 'ULL' are added to avoid compilation errors
>> in some cases.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   tools/lib/bpf/btf.h      |   5 ++
>>   tools/lib/bpf/btf_dump.c | 135 ++++++++++++++++++++++++++++++---------
>>   2 files changed, 110 insertions(+), 30 deletions(-)
>>
> 
> [...]
> 
>> @@ -989,38 +992,88 @@ static void btf_dump_emit_enum_fwd(struct btf_dump *d, __u32 id,
>>          btf_dump_printf(d, "enum %s", btf_dump_type_name(d, id));
>>   }
>>
>> -static void btf_dump_emit_enum_def(struct btf_dump *d, __u32 id,
>> -                                  const struct btf_type *t,
>> -                                  int lvl)
>> +static void btf_dump_emit_enum32_val(struct btf_dump *d,
>> +                                    const struct btf_type *t,
>> +                                    int lvl, __u16 vlen)
>>   {
>>          const struct btf_enum *v = btf_enum(t);
>> -       __u16 vlen = btf_vlen(t);
> 
> why passing it from outside if we can just get it from t? you don't do
> it for kflag, for example, so I see no reason to do that for vlen here

We have a vlen passed in because we have a check for vlen outside
btf_dump_emit_enum32_val. Basically this function and some other codes
will not be executed if vlen == 0.

> 
>> +       bool is_signed = btf_kflag(t);
>> +       const char *fmt_str;
>>          const char *name;
>>          size_t dup_cnt;
>>          int i;
>>
>> +
> 
> nit: extra empty line?

sure.

> 
>> +       for (i = 0; i < vlen; i++, v++) {
>> +               name = btf_name_of(d, v->name_off);
>> +               /* enumerators share namespace with typedef idents */
>> +               dup_cnt = btf_dump_name_dups(d, d->ident_names, name);
>> +               if (dup_cnt > 1) {
>> +                       fmt_str = is_signed ? "\n%s%s___%zd = %d,"
>> +                                           : "\n%s%s___%zd = %u,";
>> +                       btf_dump_printf(d, fmt_str,
>> +                                       pfx(lvl + 1), name, dup_cnt,
>> +                                       v->val);
>> +               } else {
>> +                       fmt_str = is_signed ? "\n%s%s = %d,"
>> +                                           : "\n%s%s = %u,";
>> +                       btf_dump_printf(d, fmt_str,
>> +                                       pfx(lvl + 1), name,
>> +                                       v->val);
> 
> 100 character lines are ok now, try to make all those statements
> single-line, if possible

okay.

> 
>> +               }
>> +       }
>> +}
>> +
> 
> [...]

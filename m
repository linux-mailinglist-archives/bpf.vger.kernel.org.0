Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89A3352128
	for <lists+bpf@lfdr.de>; Thu,  1 Apr 2021 22:54:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233930AbhDAUyr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Apr 2021 16:54:47 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:39306 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234220AbhDAUyd (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 1 Apr 2021 16:54:33 -0400
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 131KnC67018739;
        Thu, 1 Apr 2021 13:54:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=e7RanTSr/QO8HHw+N0T+QUxbV3bYTsoSGnn6YGleDoA=;
 b=K8lZSMqw7BQ/tyssZxs1xSGzSGs4Ivv60zBntMIl3KlR5cVj7A1ubJIysqxuUY5TTJK5
 SQ0GI0hoLJY6zlhF2hzVzcFyxSF/5Li6SFGQdxccYcSVSL10n0BLD5JSrqM9jOgR/KRw
 LYKKd+0tOlcas+KobpLf/9DGOEqrdkfW5Ss= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37n28mpja0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 01 Apr 2021 13:54:27 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.230) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 1 Apr 2021 13:54:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LKGiEkOQvwyjX4bsAQoclMRp/FaadI1YVo9PMAwNo/28cjOeho1KCLAiti7zYqdaQ2C9M8HrifgTNm9bTHT8P5OP1AaD6d1Q4WRKBN2op5Uz5NGiYmVMMp46706MXXsuFJpDOFgrFympQwjxHZ9WpLu7/2Pp+3hgTJiXumsdYAfiux1GAZ6dZU6e+ck9bI02gnNpHPiYSn1N/J8NfN3xxbben78eaeZPPoOmDZfzwgMCTB0KFaSqcnAQkMoiRWrLdfAsOxhQ0YFnLciYqddLED3yRUSwhld0REhcqPAa34hec2jp9r6dz75nseJJha+gxrJyq1+ypT8xpw/mNAteRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e7RanTSr/QO8HHw+N0T+QUxbV3bYTsoSGnn6YGleDoA=;
 b=An614bJN2DYOQl9Gj52UgfsjYu1Fu+IB2bobqZBJHW7bfaDLt8fSOMILXSDEeXRinqJZypTixVfv7VDq7uhaIkM1WnE0VOEHwzKx6dsBdTn+r/fhcSPA9hMLaTXN7lCZq1vl6OomQWKDzkzwRIswHuj1171IOdkpv8UQ7by58EJPDb9qVL7ypoBoozoPMH+gfy1gH/kUBLkGE7tRQKDWht1n3erFzr17c4hN9xLkfV7khCW/Ge0mnLSg9Ksxra+7iN1xnKYugbiuV+b5ayW/juCbIpmP/EFKB5S4nXBwSjR3uYBoIBVIPNqcQ0xEt73t2KihY1r9MIMkhG1XFths1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: google.com; dkim=none (message not signed)
 header.d=none;google.com; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN7PR15MB4224.namprd15.prod.outlook.com (2603:10b6:806:f5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3977.26; Thu, 1 Apr
 2021 20:54:10 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3977.033; Thu, 1 Apr 2021
 20:54:10 +0000
Subject: Re: [PATCH dwarves 1/2] dwarf_loader: check .debug_abbrev for
 cross-cu references
To:     Arnaldo <arnaldo.melo@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
CC:     <dwarves@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        David Blaikie <dblaikie@gmail.com>,
        =?UTF-8?B?RsSBbmctcnXDrCBTw7JuZw==?= <maskray@google.com>,
        <kernel-team@fb.com>, David Blaikie <blaikie@google.com>
References: <20210401025815.2254256-1-yhs@fb.com>
 <20210401025820.2254482-1-yhs@fb.com>
 <CAKwvOd=mzDREDAXCxdFzSWnxC1hNc7udMXc7Lrf50qmJk9zE7Q@mail.gmail.com>
 <E4B08495-BC24-40F7-9BEA-010B534E5454@gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e2750eab-4ced-88d2-a959-178c602cb9f4@fb.com>
Date:   Thu, 1 Apr 2021 13:54:06 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <E4B08495-BC24-40F7-9BEA-010B534E5454@gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:fb66]
X-ClientProxiedBy: MWHPR04CA0053.namprd04.prod.outlook.com
 (2603:10b6:300:6c::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21cf::17eb] (2620:10d:c090:400::5:fb66) by MWHPR04CA0053.namprd04.prod.outlook.com (2603:10b6:300:6c::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27 via Frontend Transport; Thu, 1 Apr 2021 20:54:09 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: a3ba3775-3994-413e-fe34-08d8f5504c7f
X-MS-TrafficTypeDiagnostic: SN7PR15MB4224:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN7PR15MB42243238B0AF56731757F68CD37B9@SN7PR15MB4224.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wyXzasor/L7KdKHMmrnf9iG8oZyIillc/2bVKeybGQzK+jvglMSP2bF/TyLKLw/LZzdIfee22rPGFjOXgpuVBoPqZyJ1eh6hoSpXhuptq0fwVIFdYZRu3Sntpy8kfxIYdhsbXfqzgNpmIRhGlC7SVDonkhDUHsiLyvUJZ83L0tdvhGX6bJY29EEJW6gDA8xIllZvXG+MMBD6nh2QP1TnnkKnY11BQOiw7er4AnIDwOf28RlBRebOxW0NOFM9QCYT7Jtf1HUNpNvmQK3pxuIAlC+yn9hJLimLibyIb7KuK+1wFt7DSItyk0Q1L4eFkqYVys+ObT7qkDy/02doozUZAQi2ioqEk5WH1/FImVImuyr+7057pm/n33Mo6BuVmGBusPZKN7MLpbB2suDr/L2Epvn+G3VdgeYOS3EvctIN37qJ1dJJ516CCpybqFVoBSVqc7znhUnBhHPqSJelK/JX1f/Tu1T4OXxNaCebA3tWE5UL6qy5dVjc44lAvh7V7I1qD6R5aHn+kzQGiZX1VPT47WiQG6xfHcWDERM/ec+DQ86CghsGUVMm9ZjL9wqb2BS7Qs7R3dOCxVnNLS/ZZKHEopQTtHWB2V6u5M9yzxsUbRsHaVjOuT9dpnxUXs0k+Oo6rZvTuedDoo6KaEawGcqG5sm4SEd72C3fbmFdTrdJE7CgH9ZUFf5Vj1c53qGvPllU6/9po/mPDL3kR4NneIjRsR98kUb1b5mw/l+CklG4ZyaN5OGhDimMkLZEQe2Ax1mNRb5ST4jwe43OyeBYcUnc0b8qCWwsulpDZ1Z2R23fsjdnXMNnpN7Tg5lBo3KGTIxglIas2qcwmBk//D5ulPe/aw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(376002)(366004)(396003)(39860400002)(136003)(316002)(2906002)(110136005)(83380400001)(5660300002)(38100700001)(66556008)(2616005)(966005)(86362001)(16526019)(66946007)(52116002)(36756003)(7416002)(31686004)(6666004)(66476007)(186003)(4326008)(8936002)(6486002)(53546011)(54906003)(31696002)(478600001)(8676002)(142923001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?OEg5bGZsTzFpRW1hb3lhZ1Fmekk0c0hGbHYvY0hPZE9uWS9SeXNrQzZsRDRY?=
 =?utf-8?B?T05veDNJb0xUVnNWNy9OdlFLdTdmNkdjM2dpMnVqZDRWNWdMZUNFNllzTEJk?=
 =?utf-8?B?aUs4eDBvSllhM0JCYXFtbGZwWC9lRjJacFYyM0VIM3V2YkdOZDZMYlMxSUlw?=
 =?utf-8?B?VUJGYzlPNVlKeTZNQUxNM3huckhBQ3BzT3g5RXF2MGp4UkwyYVBvQitLdzZm?=
 =?utf-8?B?NElyVENPQXdselpUWGJrTG96R3dza1krc2c5YjFCcm5pdit6aE1PQ1BXY2Z2?=
 =?utf-8?B?Y3pXMUhkd01iYXVpajNmc2pWMDZPMjFLbUVKU2xvRSt0TGd0TVhpS29EdVI5?=
 =?utf-8?B?djhOK3NUeTJTM0hWSU8zYjFodDNMZnhpdWxIdmlWVjZHL3RZcW1DbEJyeFlJ?=
 =?utf-8?B?UCtjKzVJMmtJbG9Oei9vUU9qZXM3cHpuazZabVd5dzFNb1ludUphVzRXS09Y?=
 =?utf-8?B?UzJzcUcxcDF0SDg3QWpGU3Q2bUVnVzlRMkxZWUlVdFB5eGxadWdtVjlRTUJt?=
 =?utf-8?B?ZWNYMzdML3l6R0dMbk13YlVqTGJPSEF2ZmRER2E3aC91b3lISTc0dE9YSTRh?=
 =?utf-8?B?OHZIbTd5QU04bFVXOURXQ0JBdk9MeldXV2E1T3BQSGNnSVZqMjJTbVAzdExt?=
 =?utf-8?B?MVBXRHRZcThkNklYYVR3VlRteCtSNURHSFJuT24wdHRBZ0xqYjY1OTV4Q0Nw?=
 =?utf-8?B?dnNnUHM1OHk0L3VJVGtmcnFmRE9IR1d1a3g2M3pWL21KN0NUMitLSHdiMWRY?=
 =?utf-8?B?KzF4NjAwWitadTlwdTEwTC9Ka0o1YWl0MzB4OVVsZ0Y0bXhnYi9wdXlQWlRJ?=
 =?utf-8?B?emt0V3NCb3lLY1JJeEpHRmJIMEJKcDZzNll3aEpaQUUvZU9LNWlMNGxxM2Ra?=
 =?utf-8?B?ZUdmSTVpaHVnSGJGaW4ydDFWRE9UejV6dlJXNWJCb09TcWFiSCtwUWZvbzZp?=
 =?utf-8?B?eXdsa3R2M2ZHbW11N05DT2dvMWxvdlM2Tm9mbENXNWZYVUVVbkhTVDdOQ09H?=
 =?utf-8?B?S3dxNmdDUjU5TlRGZ1loYkMvbFgvcmZ0UjdLcndpUDVrVjV1MHBDMmJpOS9o?=
 =?utf-8?B?YjU1eTdmNmU2RUN1NlZRcU9tN1FCY0RUdklCdGpoRm02SWRVYWgxbjhZY2xr?=
 =?utf-8?B?UGxmSUV4dmVOTzdQMzdEYWtVallncXpudjkvTnNJVmJVa0VvNnZzY0I5RHVW?=
 =?utf-8?B?dEE5bVF3ckNBOHBYUU9ac3gxQmVMeE9oSS8vd2pyWklqaElCakwzVitmeXhL?=
 =?utf-8?B?YkRubUNQMHNucEQvMkxSZlQ1VGFIZ1lOQnFPT3NqYVJUbTFLNkJSVmxZRDg1?=
 =?utf-8?B?cXd3SzRiU3VYZ3Y5OUc4bG9lcVFqR01ZZ3lJRGp1UUQxK1RNQmZiYjV2bktU?=
 =?utf-8?B?aytYZXlsb2dCTlhsNTlBcXBjSWlIdDhHS1lpRGlmVldVRW1iMlo1NlIrNEJt?=
 =?utf-8?B?NjdDa1J0RnZ2aUNNQys2cVU5Q3lGbHR6MlA3QW1qc0tpWDQ3bjlQOHR0MWEw?=
 =?utf-8?B?MVZqVU8vNURSelYrVEFhakpWWUlEYkplZG0vdVgzd1o4S1RUZkpXVjVGSHhV?=
 =?utf-8?B?cUkreWdTY0lIZFg0WXhhMHBRR3dUcUFFOTExVXIxRjMzUU9tTS9tdzE0cW5J?=
 =?utf-8?B?YnJ4K3MxQ3hNcmZRNUFFMzFyTFRHdkhYK2g1LzBVbWNsUERRT2hobmg2K2oz?=
 =?utf-8?B?aHFkUTB6WmVseEtxbi81K3lIa1lNUjR4dHBpS283ajhUUzRZbDg3ZVJzNHR3?=
 =?utf-8?B?Vk8zdnVmQmRUV1dldkNtMjlLMGdmTW9TVUo3Ly9NVnNDdkhqWE92RkpSY0hI?=
 =?utf-8?Q?R4c+ZhEmYwQzjeT/jLvXEYR66GZfcW8F55Ypk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a3ba3775-3994-413e-fe34-08d8f5504c7f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2021 20:54:10.3789
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: um73z4tDqvyXGTKOghnYjs8OI7FEemJ9wfxxDBu5OkcqTZzJ/eKuduriV+DMRGRm
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR15MB4224
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ouuYhk2vaPOJW2jCB1-Wq7Ww7J7bYrz3
X-Proofpoint-GUID: ouuYhk2vaPOJW2jCB1-Wq7Ww7J7bYrz3
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.369,18.0.761
 definitions=2021-04-01_13:2021-04-01,2021-04-01 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 lowpriorityscore=0
 phishscore=0 priorityscore=1501 mlxlogscore=999 suspectscore=0 bulkscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 clxscore=1011
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2103310000 definitions=main-2104010134
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/1/21 12:36 PM, Arnaldo wrote:
> 
> 
> On April 1, 2021 3:52:05 PM GMT-03:00, Nick Desaulniers <ndesaulniers@google.com> wrote:
>> On Wed, Mar 31, 2021 at 7:58 PM Yonghong Song <yhs@fb.com> wrote:
>>>
>>> Commit 39227909db3c checked compilation flags to see
>>> whether the binary is built with lto or not (-flto).
>>> Currently, for clang lto build, default setting
>>> won't put compilation flags in dwarf due to size
>>> concern.
>>>
>>> David Blaikie suggested in [1] to scan through .debug_abbrev
>>> for DW_FORM_ref_addr which should be most faster than
>>> scanning through cu's. This patch implemented this
>>> suggestion and replaced the previous compilation flag
>>> matching approach. Indeed, it seems that the overhead
>>> for this approach is indeed managable.
>>>
>>> I did some change to measure the overhead of cus_merging_cu():
>>>    @@ -2650,7 +2652,15 @@ static int cus__load_module(struct cus *cus,
>> struct conf_load *conf,
>>>                    }
>>>            }
>>>
>>>    -       if (cus__merging_cu(dw)) {
>>>    +       bool do_merging;
>>>    +       struct timeval start, end;
>>>    +       gettimeofday(&start, NULL);
>>>    +       do_merging = cus__merging_cu(dw);
>>>    +       gettimeofday(&end, NULL);
>>>    +       fprintf(stderr, "%ld %ld -> %ld %ld\n", start.tv_sec,
>> start.tv_usec,
>>>    +                       end.tv_sec, end.tv_usec);
>>>    +
>>>    +       if (do_merging) {
>>>                    res = cus__merge_and_process_cu(cus, conf, mod, dw,
>> elf, filename,
>>>                                                    build_id,
>> build_id_len,
>>>                                                    type_cu ? &type_dcu
>> : NULL);
>>>
>>> For lto vmlinux, the cus__merging_cu() checking takes
>>> 130us over total "pahole -J vmlinux" time 65sec as the function bail
>> out
>>> earlier due to detecting a merging cu condition.
>>> For non-lto vmlinux, the cus__merging_cu() checking takes
>>> ~171368us over total pahole time 36sec, roughly 0.5% overhead.
>>>
>>>   [1] https://lore.kernel.org/bpf/20210328064121.2062927-1-yhs@fb.com/
>>>
>>
>> It might be a nice little touch to add:
>>
>> Suggested-by: David Blaikie <blaikie@google.com>
> 
> Sure, this is something that is becoming the norm, be it from patch submitters, or, that being somehow lost, by the maintainer.
> 
> I think this is not just fair, but documents what actually happened and encourage people to share ideas more freely and quickly.
> 
> I'll do it in this specific case.

Thanks, Arnaldo. Sometimes I indeed missed to add necessary tags like 
Suggested-by, Reported-by, etc, esp. if I want to push the patch
out ASAP. Thanks for correcting this!

> 
> if I failed to do so I'm the past, I'm sorry.
> 
> - Arnaldo
>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   dwarf_loader.c | 43 ++++++++++++++++++++++++-------------------
>>>   1 file changed, 24 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>> index c1ca1a3..bd23751 100644
>>> --- a/dwarf_loader.c
>>> +++ b/dwarf_loader.c
>>> @@ -2503,35 +2503,40 @@ static int cus__load_debug_types(struct cus
>> *cus, struct conf_load *conf,
>>>
>>>   static bool cus__merging_cu(Dwarf *dw)
>>>   {
>>> -       uint8_t pointer_size, offset_size;
>>>          Dwarf_Off off = 0, noff;
>>>          size_t cuhl;
>>> -       int cnt = 0;
>>>
>>> -       /*
>>> -        * Just checking the first cu is not enough.
>>> -        * In linux, some C files may have LTO is disabled, e.g.,
>>> -        *   e242db40be27  x86, vdso: disable LTO only for vDSO
>>> -        *   d2dcd3e37475  x86, cpu: disable LTO for cpu.c
>>> -        * Fortunately, disabling LTO for a particular file in a LTO
>> build
>>> -        * is rather an exception. Iterating 5 cu's to check whether
>>> -        * LTO is used or not should be enough.
>>> -        */
>>> -       while (dwarf_nextcu(dw, off, &noff, &cuhl, NULL,
>> &pointer_size,
>>> -                           &offset_size) == 0) {
>>> +       while (dwarf_nextcu (dw, off, &noff, &cuhl, NULL, NULL, NULL)
>> == 0) {
>>>                  Dwarf_Die die_mem;
>>>                  Dwarf_Die *cu_die = dwarf_offdie(dw, off + cuhl,
>> &die_mem);
>>>
>>>                  if (cu_die == NULL)
>>>                          break;
>>>
>>> -               if (++cnt > 5)
>>> -                       break;
>>> +               Dwarf_Off offset = 0;
>>> +               while (true) {
>>> +                       size_t length;
>>> +                       Dwarf_Abbrev *abbrev = dwarf_getabbrev
>> (cu_die, offset, &length);
>>> +                       if (abbrev == NULL || abbrev ==
>> DWARF_END_ABBREV)
>>> +                               break;
>>>
>>> -               const char *producer = attr_string(cu_die,
>> DW_AT_producer);
>>> -               if (strstr(producer, "clang version") != NULL &&
>>> -                   strstr(producer, "-flto") != NULL)
>>> -                       return true;
>>> +                       size_t attrcnt;
>>> +                       if (dwarf_getattrcnt (abbrev, &attrcnt) != 0)
>>> +                               return false;
>>> +
>>> +                       unsigned int attr_num, attr_form;
>>> +                       Dwarf_Off aboffset;
>>> +                       size_t j;
>>> +                       for (j = 0; j < attrcnt; ++j) {
>>> +                               if (dwarf_getabbrevattr (abbrev, j,
>> &attr_num, &attr_form,
>>> +                                                        &aboffset))
>>> +                                       return false;
>>> +                               if (attr_form == DW_FORM_ref_addr)
>>> +                                       return true;
>>> +                       }
>>> +
>>> +                       offset += length;
>>> +               }
>>>
>>>                  off = noff;
>>>          }
>>> --
>>> 2.30.2
>>>
> 

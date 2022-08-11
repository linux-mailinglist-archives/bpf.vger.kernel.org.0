Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C9058F78C
	for <lists+bpf@lfdr.de>; Thu, 11 Aug 2022 08:24:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233504AbiHKGY5 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 11 Aug 2022 02:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbiHKGY4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 11 Aug 2022 02:24:56 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D23628A6F6
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 23:24:52 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27B0p2vR021831;
        Wed, 10 Aug 2022 23:24:38 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=DrCX4Lg6gkGuZq1EkVZ5kZ3T9XpQCFr/a4MPWow3iUQ=;
 b=FwJDWp9kwQi2CRF1jt5NIBkBkZN/0/Kgz4UPLAKvXxnIJ3j/kYHy6fW4ATn3DznVDtMc
 Qhj0TnrOLpQ0yrfyBlj7ybshN1eWVDu83UGoNlpsjMZ7uQsonn/3nzSjx5/Qz2JWI3e4
 ySlB82vlP9APhW8yFlXgBS/Kr6NL1DlxGcU= 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb1f36e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 23:24:37 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oHPG1dVmFsfy/9RTbZx4CMaHtYVFKsVVohjuMbGSgEu+UQCgr/R0I/sbx8i+i0Q8sF7d76r7tBDORymKpp7dmyvwKxQIvEUJ1iXlJgZr1EDB3LTJ71PydRrMbAC8nOvdmOuH6PaQDeOa7m/ikx1QiShBmRI5dHk4kjUJ7LyTkuAxUN/FilJ3yi6YKOsDZnbrVs71H103LHC+SA81k2qM6IKoWXqW1RMfuVEleAw7ef4FWUU3IDopqxBVSlYTOQwdo0BHvexXuomeD83WjdA1M7mZyhelIBHsyLgM2ys6Q72ZZuKsM0PIB10AUcIhvo3eaaMPlqjE062e3C3VeRkcdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DrCX4Lg6gkGuZq1EkVZ5kZ3T9XpQCFr/a4MPWow3iUQ=;
 b=mA62gVKEBI0rv6uecPN7OZScl3ufQrYg0Qr8j0SoCN52c6AOem6PXKT6sHEvQSZhEfToPnImng1MED1heGZLoMn4VizgOZd0LBc/PDpNNqIEpdXuIE+lwBeXTFa2MowAmLfKYlgusO3O1LIsOXqvpRHuNFK9HgFLpxi8K2k4gasfmuFBuKW8JEwgJcBHtXtxv5GNuM6QqHeNwv/iSQafr9IzB2u1I6FuIabhHmeGpUvXvmuUeUfyPPCPn26E4tsPGg/WgeOmIV01NICI0We7eM3nv+BeQ3w37UpSuLGl9LC/SM+1K7opVSUU/e3F9BeEv6Ey4KD8wGo7XkSkOfoBSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB3365.namprd15.prod.outlook.com (2603:10b6:a03:111::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.24; Thu, 11 Aug
 2022 06:24:27 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Thu, 11 Aug 2022
 06:24:27 +0000
Message-ID: <22aeedba-61a5-ed5e-cd78-2665bc676bd7@fb.com>
Date:   Wed, 10 Aug 2022 23:24:25 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC PATCH bpf-next 2/7] bpf: Add struct argument info in
 btf_func_model
Content-Language: en-US
To:     Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com
References: <20220726171129.708371-1-yhs@fb.com>
 <20220726171140.710070-1-yhs@fb.com>
 <CAEf4Bza1TfpRSZa48Y9zJEi+VBTo9Y7u2YmtEYQZSOnuyJRiHA@mail.gmail.com>
 <489a8ba8-8c9d-62fa-fec8-de7f6bc241ad@fb.com>
 <CAEf4BzaRu5pBV5LNYZhJ+HUus16PdrcXDXzJ2oOy+6SUdSFtjA@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4BzaRu5pBV5LNYZhJ+HUus16PdrcXDXzJ2oOy+6SUdSFtjA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0145.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 137577ea-5105-4f66-5cdb-08da7b62243c
X-MS-TrafficTypeDiagnostic: BYAPR15MB3365:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +Jef8Dr0o1OhQ2h7C7yxhK4cgsbUVGKgccO7Ivk2UtWQmeh+CDGe4h6ZEp45W952oBQkdalAb9dfYrpFNXzTOul9oolYHb+QL8sv6sgB6ttMIsbFL5LZdLIYPOakirg2qopg/mHXgBolh306cFQqRfLSpd1Li4Cv1di9hSQFEr/r2DrXEIA2YqeRXhdhgpSuO18IN6Q0aMa8osfXM0YoPTBWPOHICJwi7GBjpMklZEq6QaBbMRSnHh/KdZ7CCQq4cNtRx/U8p9R+JT36B4t4lSS+Bb257PJEMY0jCbt3+gQWwPzG4CwEyTIoEvIZjuMVPIxccMmHzJfJ41fv4ekWRBF8j+O1tdY/E6/NJXv2IYZ54ITSzwNfkLlQpsRdbq9SvpCLtrODdN1zQNenh0opUbgwuYT00yJwkGZ/KvTi5SBmgxF3XiJXIuV4ar+t1FJwOqBIRK/C6WGIQELpYXbAF/HvkhEwU7cuMEaXpaKL79ejcTDAyFao9+AjRZZ1XMDj8BYOHBVK4hg72tkQ5d8vJMDcz8i5wqz23uN3fuj589Qb8CvnSiINc6wyZIa+N5QEfJQb6+M0K3czXTaT9hXny6POZw5LcccpMoy+7h/bhKEuRiS/9pU7WFitH/ShfLf5Mz3dBkt78G+nTHORfpHIWfCKBLQCzIbP1sHdROwbhHEzxxCnM6y2vttkWy3zmP+uXfjYqHz0BXcI1d0U2NdL1vDexUiX2QWtH7G3NTf/fBKIZbJ4AIVw1mP3AUK9dxl+q5gm8+3Xq4IxGloyBuJfFa26dyyB/+hQjj9IexeBMYEHhpOu4yirG8CUC4Yy6jeg67a4eqix4E1K1dtAoD4BOg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(2616005)(54906003)(6916009)(36756003)(66946007)(2906002)(8676002)(4326008)(66476007)(41300700001)(66556008)(186003)(31686004)(83380400001)(6506007)(38100700002)(316002)(8936002)(6512007)(53546011)(478600001)(6486002)(31696002)(5660300002)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eVl1am5mL0JORUsvQlA2VEtVeVFoL25SNTZ3RWFWNTA5TDM5bUwxdE9GZkg5?=
 =?utf-8?B?b2c4ZitLMkUrWHY2cjlrM2h0dmI2SlNsR2RPYklmTzVsdklta2UyYWY5VDRi?=
 =?utf-8?B?eUJvMTUyRTN3ZjhkNXk1STQvdkJKaUErSGhHZWttcDNseHNxdnZHbFNaMDkz?=
 =?utf-8?B?dkZxSVV3MHFkS2J5R21Gd3M3T2VoV3Q0MURnang1bzlnVDR1WUFxeHlNT095?=
 =?utf-8?B?UitFSHZrNEx1WUZSWXBpMlc3cldTWFBuNVNrdCtVMThJdGJjUlpRWTZBRUFz?=
 =?utf-8?B?KytWb3R5SWwwNk9oSkpYc3dXWEJjb1VBYlVON3RjYlBPRHhxRGdyRS85QWVq?=
 =?utf-8?B?SHdUakgxREFGQkhrbGVMRUw3MlVzTGgrU251ZzlKalFCdVhaWHV5WWxMRE11?=
 =?utf-8?B?UFZEMUJqNWdWaDJ2dW5HZ2NYV0hRdWh0S0ZNOFRVQnM0WDMwMHc3bGtudmJT?=
 =?utf-8?B?dDJYV2tya1Z6aC9jRERqZ3VlNzlHM3p6SkFhOUxjRFkwSStaTnZSZncyZUtK?=
 =?utf-8?B?a2JPY0ZneGRnK09uQ1NSdDNLVGJsLzJ3YjgzdHlkZVdndUdsaTlVaVY2Q3Q4?=
 =?utf-8?B?Vy9Lc2FVSnRzc2h3azR5NDg1VSsxSlRYTzNLQmZGc01qcHRzcnhuem16UjMy?=
 =?utf-8?B?L1o4MXVzTW1KYmxJcitLZmZRaFN3ZTlXUGhNWW9aZENpVmJBa2ZVWE9hYlgx?=
 =?utf-8?B?M0Y3NCsycGJXSDB1RjI0Z2tkT2hETVhldVdRSEo0OTE2KzhXbmlabDJaRzZv?=
 =?utf-8?B?T1JraFk1TnVHUjhWZXVVTGVQYkJWaktjVTR6aEZvY0p1eG5FcnVFbWIvcDFC?=
 =?utf-8?B?bjd0TzYzK0FyZnQ5TCtQU09aNjlKdUhVQ2toUGppN0NBRWVEUGV4YVJtRFpI?=
 =?utf-8?B?V3VYcWhQUXhuUjY0R3ZtRERUbUlYakc3SkZCaExzalkwTXlXeDdNUGtIdDYy?=
 =?utf-8?B?dkRSbzhHRStGMHR6cVB1OEVFdXhZVDRWWjdWRlc5WThHNEhzcGg2VnlXMXJa?=
 =?utf-8?B?QTY0UktnQUoxOTlaNDYrOEt4MGJ1a2p3cC9WVk03OGdvVWtkb3BLcFBrak9k?=
 =?utf-8?B?WStHTjZKN0orSjlmbEhJbjhXUllZWkxPemR1MmNQb2FBT3p3RUNOQ1Z1bFV5?=
 =?utf-8?B?b3RLZ3QzUkRDakl1eTM3b0xwTWQwM1plY0gxV2V6bW9XUHVaNzhuR3d0d1VT?=
 =?utf-8?B?ZmVvMEFnOUE2Zlo1aWtlU1VPcnI1SjBqem5GRjhYUHZEOEVOai9PYW9mZzZk?=
 =?utf-8?B?N0EyOUFZNk53cVRQOXA1blYvdGxwYnRiaEI2bGpSM2lPS2c5REZZbjZRNDNX?=
 =?utf-8?B?UStnZUE0OEpYVHd3QldqT2QwL0NFSGYvSE5kTDg5U0RkQVNhQUlGcUpOa3d4?=
 =?utf-8?B?TndjWXZ0ZW5KNnJBUzl4NU5NeE1QMVlGZVloeWtyem93SjdtcWNXb3FyYkdH?=
 =?utf-8?B?ZC8yWmtPUVA2TzRDaTRYTGs0c2UxVjJ2VlVPbCtSejBmbmZrRXROaStmWHlT?=
 =?utf-8?B?dkZEUkZRc1VONHBQaE5WVDQvNytZUmVsd0M2RENRQzAyNTdISjN5dWJPUlo4?=
 =?utf-8?B?WjFhc0FJVE9Fazd5ZXFIMFpYRjBBL3NqNW9oSDZXdlI2Wjh2UDBZakRNQzN0?=
 =?utf-8?B?cW9Fd2FNeWQ3RllONmJlangrUXVPUkN2Ui96bXZ5Sll1WDROQUVPTU1qV3h5?=
 =?utf-8?B?dkNOUHh5U09DMGQ1MVVlYjJlSUtRZEkyNmF2VjNxWkF4aHpwVFozalhtUFR2?=
 =?utf-8?B?OWVHMnVNWEV0SkUyb1MzRDVhMi9JRkw3cjlabWgxN3V1cTZRRlNUL0pUYWFy?=
 =?utf-8?B?SGcvdmZTMU5wdGtKRGhRRms4cEVEcDNQREVBWmlPOUdURGJIbSsyclVTMHlD?=
 =?utf-8?B?dzRDSkhrOTZWMW5Gb0dGSDJ0bGdZLzBuYnVGQktCdU1EL2RscVlOZmtyakdu?=
 =?utf-8?B?N094NFlpUis4OXZja1llUzlZUE9sWFhGYzcxUUdFZ1RveGUyTjlRRFovMlJp?=
 =?utf-8?B?SzNRZmpZZ0ovZTEwdURVRmdvK0k2MXcxZHJnNVZpVmZRYzM5Q2RpL0dwcDF0?=
 =?utf-8?B?MHRoNFYyTFRudkZxaW9CTUVHTzVrZzBZc2Q0QUJJK25pNXdWN0JjT0s0S0Fk?=
 =?utf-8?Q?2mOPXyYOx5SjFbkKSRKdeiKOH?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 137577ea-5105-4f66-5cdb-08da7b62243c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2022 06:24:27.4418
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeTV2pKd8U4qg58xJwBawNMau3DfBviKfkO0K4faXPFT2qiyQQKAnipDyFkXQhOe
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3365
X-Proofpoint-GUID: nntRAu2_Cwk2rncKPyLtzIKATAW8kmnG
X-Proofpoint-ORIG-GUID: nntRAu2_Cwk2rncKPyLtzIKATAW8kmnG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-11_03,2022-08-10_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/9/22 5:25 PM, Andrii Nakryiko wrote:
> On Tue, Aug 9, 2022 at 10:38 AM Yonghong Song <yhs@fb.com> wrote:
>>
>>
>>
>> On 8/8/22 5:02 PM, Andrii Nakryiko wrote:
>>> On Tue, Jul 26, 2022 at 10:11 AM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> Add struct argument information in btf_func_model and such information
>>>> will be used in arch specific function arch_prepare_bpf_trampoline()
>>>> to prepare argument access properly in trampoline.
>>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    include/linux/bpf.h | 9 +++++++++
>>>>    1 file changed, 9 insertions(+)
>>>>
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index 20c26aed7896..173b42cf3940 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>> @@ -726,10 +726,19 @@ enum bpf_cgroup_storage_type {
>>>>     */
>>>>    #define MAX_BPF_FUNC_REG_ARGS 5
>>>>
>>>> +/* The maximum number of struct arguments a single function may have. */
>>>> +#define MAX_BPF_FUNC_STRUCT_ARGS 2
>>>> +
>>>>    struct btf_func_model {
>>>>           u8 ret_size;
>>>>           u8 nr_args;
>>>>           u8 arg_size[MAX_BPF_FUNC_ARGS];
>>>> +       /* The struct_arg_idx should be in increasing order like (0, 2, ...).
>>>> +        * The struct_arg_bsize encodes the struct field byte size
>>>> +        * for the corresponding struct argument index.
>>>> +        */
>>>> +       u8 struct_arg_idx[MAX_BPF_FUNC_STRUCT_ARGS];
>>>> +       u8 struct_arg_bsize[MAX_BPF_FUNC_STRUCT_ARGS];
>>>
>>> Few questions here. It might be a bad idea, but I thought I'd bring it
>>> up anyway.
>>>
>>> So, is there any benefit into having these separate struct_arg_idx and
>>> struct_arg_bsize fields and then processing arg_size completely
>>> separate from struct_arg_idx/struct_arg_bsize in patch #4? Reading
>>> patch #4 it felt like it would be much easier to keep track of things
>>> if we had a single loop going over all the arguments, and then if some
>>> argument is a struct -- do some extra step to copy up to 16 bytes onto
>>> stack and store the pointer there (and skip up to one extra argument).
>>> And if it's not a struct arg -- do what we do right now.
>>>
>>> What if instead we keep btf_func_mode definition as is, but for struct
>>> argument we add extra flag to arg_size[struct_arg_idx] value to mark
>>> that it is a struct argument. This limits arg_size to 128 bytes, but I
>>> think it's more than enough for both struct and non-struct cases,
>>> right? Distill function would make sure that nr_args matches number of
>>> logical arguments and not number of registers.
>>>
>>> Would that work? Would that make anything harder to implement in
>>> arch-specific code? I don't see what, but I haven't grokked all the
>>> details of patch #4, so I'm sorry if I missed something obvious. The
>>> way I see it, it will make overall logic for saving/restoring
>>> registers more uniform, roughly:
>>>
>>> for (int arg_idx = 0; arg_idx < model->arg_size; arg_idx++) {
>>>     if (arg & BTF_FMODEL_STRUCT_ARG) {
>>>       /* handle struct, calc extra registers "consumed" from
>>> arg_size[arg_idx] ~BTF_FMODEL_STRUCT_ARG */
>>>     } else {
>>>       /* just a normal register */
>>>     }
>>> }
>>
>> Your suggestion sounds good to me. Yes, we already have
>> arg_size array. We can add a
>>          bool is_struct_arg[MAX_BPF_FUNC_ARGS];
>> to indicate whether the argument is a struct or not.
>> In this case, we can avoid duplication between
>> arg_size and struct_arg_bsize.
>>
> 
> I was imagining that we'll just use the existing arg_size and define
> that the upper bit is a struct/non-struct bit. But if that's too
> confusing and cryptic, I wonder if it's better to have
> 
> u8 arg_flags[MAX_BPF_FUNC_ARGS];

I prefer a separate array, which seems cleanly.

> 
> instead and define the BPF_FNARG_STRUCT flag.
> 
> For what you did in your other patch set (u8/u16 handling for func
> result), we can then define ret_flags and have a flag whether the
> argument is integer and whether it's signed in such flags (instead of
> bit fields).

Currently, we only have use case for whether it is a struct. But
agree we can make it extensible with an enum to indicate what kind
of info for the argument.

> 
> This way we have a unified and more extendable "size+flags" approach
> both for input arguments and return result.
> 
> WDYT?
> 
>>>
>>>
>>> If we do stick to current approach, though, let's please
>>> s/struct_arg_bsize/struct_arg_size/. Isn't arg_size also and already
>>> in bytes? It will keep naming and meaning consistent across struct and
>>> non-struct args.
>>>
>>> BTW, by not having btf_func_model encode register indices in
>>> struct_arg_idx we keep btf_func_model pretty architecture-agnostic,
>>> right? It will be per each architecture specific implementation to
>>> perform mapping this *model* into actual registers used?
>>>
>>>
>>>
>>>
>>>>    };
>>>>
>>>>    /* Restore arguments before returning from trampoline to let original function
>>>> --
>>>> 2.30.2
>>>>

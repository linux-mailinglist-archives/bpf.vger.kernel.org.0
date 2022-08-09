Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDE8858DD53
	for <lists+bpf@lfdr.de>; Tue,  9 Aug 2022 19:39:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244315AbiHIRjC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 9 Aug 2022 13:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbiHIRjB (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 9 Aug 2022 13:39:01 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67C07255A0
        for <bpf@vger.kernel.org>; Tue,  9 Aug 2022 10:39:00 -0700 (PDT)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 279EsSIx026668;
        Tue, 9 Aug 2022 10:38:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=66tFQ3RSI9/G7fNnETvGcGZf4t5MvIbMUotFca+Mlkg=;
 b=RgOeklTOYbwAan4vP82fy7eKp3oQSIZWIulTMa6vi+/TFBYP+XBxx0Z1iTRUyn22oc+A
 nsl5B7ZTW2XbEdWKRWltH4Ed4FuGjLcZ3lrOUZV1jTuLv/dMi1KiE9z0OtOVQl/XYUIZ
 XZFFQ74t7oqzGQcV5L+dym9pvQSCd6sTZlo= 
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3husrjsged-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 09 Aug 2022 10:38:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZjEmrF9pZlCtSC0d7jHMyp5PEgEDdWwCQg6POCNWdHpiGGNJ9ckYl8E9wzMkYAZCsuNVNt+Pc8NtRwJrU+vxfJS9WZI/f2HPk14s/XGLRyEjL4g74dMkcXdHNVkIHFot82dmaXHO8I5iadHHeAXcdVA60agQDlOUcdinpfWVfI3rR4K89cux5EQqDhlmlEba6OVWHsuSGfTUKk9uWjCdHcR9JqNZ+LH5/iDM+CWlq/4K/qsALKXwj/orSwKY1qzXpP1l9RIk6NocW1FSskeQNU/dvwTpNncEqTQaEDZjBYZqeRynjioaL3FQyz0n4+yxwLk95EZygVXpCMWqsN996Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=66tFQ3RSI9/G7fNnETvGcGZf4t5MvIbMUotFca+Mlkg=;
 b=Guo8p86+07N/IGkesNgl3vHWmjGc8EuqkVAkXzd+8TC+Aeg1X74ZJ1blnMv6FCIIew/KOiwjabsBfOLWWPh1gyrU2DnUDqe6rIlt0Drruvr7k3lg0t0oS2ip0wma5CxJ7t/WlCeivjy84mEOK/kMbhmtMfAkYZPilpWeo0YKYw42/wI0uim+yxQBWZfZZkjSVy4RZQ8kd+CWn1seli9l4VY3bwx5L6mGB9m83mQa+hgB87S0/++e8Gdvk0r3WRq1REbaC1MMIt0e+g+Cwabx3mQw/uaYxqJeaWCxcCtWNclVLqhfP4dxk+tQyToaqkfYBJ4QKo9hgcnQfCEh+EvSKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4604.namprd15.prod.outlook.com (2603:10b6:303:10d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5525.10; Tue, 9 Aug
 2022 17:38:43 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::dde5:25a3:a125:7bc7%2]) with mapi id 15.20.5525.010; Tue, 9 Aug 2022
 17:38:42 +0000
Message-ID: <489a8ba8-8c9d-62fa-fec8-de7f6bc241ad@fb.com>
Date:   Tue, 9 Aug 2022 10:38:40 -0700
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
From:   Yonghong Song <yhs@fb.com>
In-Reply-To: <CAEf4Bza1TfpRSZa48Y9zJEi+VBTo9Y7u2YmtEYQZSOnuyJRiHA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0065.namprd05.prod.outlook.com
 (2603:10b6:a03:332::10) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 30b5bd3e-a69b-422f-5fda-08da7a2e00d1
X-MS-TrafficTypeDiagnostic: MW4PR15MB4604:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y62TiwlgK4tqJyrjyHdRWnVirRV3GaURCwjCUiVGn0yam0yTf+VgJCbhENJ254GohNm2YmwF0Apqx4Vn4pCZTm+G8yLik2xBeN8dnqyupZG07iC67Z3QgoT8sh0xKwU1qShyHCmPJdpoKDNPxVqPgtw4lIYTvvR4lYkFVmvPKLpduvnhngGfede/E8sMatj1ifR3SBXy86XcYMKzbcJBxtXNB/jjxqwV2SzrwsHNvQWdiDXjPDfc+++8u95jN8C/xUmCaOskSDgXzybtB14ur+/2VKARawep8+1flvN21TLqW6rzGttW7bvlPwv/xKiwpu1oVONWdsVSCIHLpHlwh0EXG0SU15CgdkPOBuT4M+n7U1VtReTbqpf91kQAoOc786/U9rAzb01OGpM4npG8a9utD6+44UE2PHvFsJDX4NNyIWdvmoxRBjt4hsouhKlYRXk/vTgNpAySOlmvA0fkoSMe4dK9d4K/oG0hzDxuc3gaElbtEz6rgODfBoupYyqX+alJgnPVAZTTz0BFDrYE58DWereuRhDMC4iu1awUewAi5GgRd7SDJFp+6Z9X9Uwhs7EUR79HfA6eYM0taHyAB0nK0FHGBhLDKrwxRlzg9PAWIL4vJNYr66sBIg0n8gN0WuXz21yTysT5tbaKtlodLwVQuFBs95Px4FRafppiOBZOohg2971motVwKpdsyin4ljVWiP4QGLTGO74HJYjQ/CLek1fbTVg4melJdfPibQrDmH330v0YsGjZGKMuOZrELos7NY6Dp8bJdGFOJ5KaxMWF70VPB8BEmUDRLmDVIHTaSbToVc2HRf2eA+A8kfkprHOFmj2ToXi8eW2K8mEQDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(6486002)(41300700001)(478600001)(2906002)(86362001)(31686004)(31696002)(36756003)(316002)(6916009)(54906003)(2616005)(186003)(38100700002)(6506007)(53546011)(6512007)(83380400001)(8936002)(66946007)(66476007)(66556008)(5660300002)(8676002)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cG96T0dBTUs2RWMyd1g1MlFDNXVua3ZtQlc3WWpUNHN2RjZBeDUzZjREQ3Jv?=
 =?utf-8?B?VENTUEJzMnJjNUpwaTE0ekU4WW1QSFEwVUNUV0dJenFuL0d1TFZGMDczZVpS?=
 =?utf-8?B?SnZvYVN1djV3dGdrKzE0dGdVTW1wR1ZNRkV5UC9aWHBJUTZGVDB0ZVJuOFd6?=
 =?utf-8?B?dnNvWnhWN2VIYkxndEpKZWg3bjRHU28wdE1oNFdSZlZwbkk5c3Z0dnE5QkJV?=
 =?utf-8?B?dEJwR0JIZFlrRTZKVFlXUnAyRjBnOHhoYkIzTGpIZDhXa1R1RjlaRmtydUVu?=
 =?utf-8?B?T0dRUGlvVE9aZ2tYWHNuRkRxMm5GZFp1UmMxYjcxRkdVWHMwNkpMSERtbDRI?=
 =?utf-8?B?SFJyNDBTTmdVWlVpRUZJZ1FtalNoSUVyZ25BQkxjblhZOXVaRy83YWtCanE4?=
 =?utf-8?B?WU1FK2lrMTBTLzFVaFMreUtuODgvYmZuNUxMNit3MjhSV25hL2l6MC9lT3J6?=
 =?utf-8?B?bngwNEgyY1NvWWdPMTZ2YWVZWU5samM2cWZ3NmVoNkgySVZNdHF0OHZCMTlL?=
 =?utf-8?B?bFhZNlZleCtPUVFBUHM3UFBzQUF1RFZ3dXVzaUNpS0RFVFJXbTNOT0IrQVkz?=
 =?utf-8?B?eHNiSUdKc0p5SWZkYVQyS2N0cWR3V3d2enBCZDFJQkFCWVo5aElUUkpKcjlD?=
 =?utf-8?B?WWhOOGNjaUViaDFNVEhROHdBcGdQNWZueVdKY2l5cHlXVnl0MWRROW9JbVh2?=
 =?utf-8?B?NlVGWW11MEJXbm1tS1lWb2tMSlFwL3krdDhUYUMvb093MEdTWDZ1bC8yZk80?=
 =?utf-8?B?VHU4V3hZRit1eTlHc1NwTlJiZi9DWE9uNzhsN1VGamNMVXBsUWduUFVaekVp?=
 =?utf-8?B?TUdPdSsxS1ZsZ3ArZ3VhMFBCVUZXRXBuaGlGZmorZnExME1NR0R5S0lsdUI1?=
 =?utf-8?B?eFVKc1RrRm1OQi9ZaDlGSDRHMVlCbnFVWU5teWdML1lxNnErc0kwKzRwbEll?=
 =?utf-8?B?a3IrV1g1Q2hsSG5CV1h2OTNWbktpL3FkMkRGREZ3NnVySkdyRU9KTlVQWnl2?=
 =?utf-8?B?V2kvVlp0NTR4bTlETG81R2poNnc0NFl6TTA5eTBoM3FmMTg4eFlNZkVzd3lO?=
 =?utf-8?B?S3c3Um1GUWJzZWp4RUlpNGExaFQ0TElMdU5CV0pnZFR4Z0h1cHh1YTZkNGQz?=
 =?utf-8?B?REhJeitncnViSkEzKzd5ZjNIWEE5RFJaQmF0Yjl0OU9mcGo4VmRLYmRlUHgz?=
 =?utf-8?B?bWt4WHR6TWJNczhBaFQwTHRZcWJvbmRaVkRyT3ZPSjdoRVVJb1BHNkFIaWlx?=
 =?utf-8?B?VVRIbTJzbVZlN05zRTdmODlKUFpQeEtkWi9rV2M1ZTBRd3U3MCtxTWpkMVBy?=
 =?utf-8?B?ZzhJYVdzdVc0eW02d0ZBVjFVaVN5Z3V0YU5hV0F6cjlWYmxjMXpYMHhYUmdo?=
 =?utf-8?B?U3UzR1NNTEpYUGpGNm90VU9VRHEybWNtc3lWSkprbzF4NzJuSDlHTUNTSnpj?=
 =?utf-8?B?UFZ1TDNjRGlwY2hGNk1LTCtVdmNldmxBSkZYK3l0VDZORkkyZkdCRElKaVRI?=
 =?utf-8?B?TS80N09lcjJPalZTdEQ4VEVhZ2hKblRseUJTdS8wVGd2RFJVS3A5UlhQOTV0?=
 =?utf-8?B?NzlHZ3piUGE4MEl5anQ5WkNsZ1JHNU5lSzRBbkViL2RTWVVMdWREVUdaNUx1?=
 =?utf-8?B?Q1VCTzZXYzlKZkVDcGNYbGlpTmUwakxPTnNyNTZMVEdneUk0TDcwOEhGdmtJ?=
 =?utf-8?B?aFo5ckdtTEI4QWxrb2U2SHowVnNqQUtNMjFUUWMxMEJyc1ZLZnMzMUlNWjlE?=
 =?utf-8?B?KzBFVk9uTnBNbUFrL3VQTHFVTWpzRXRtZHFBaXJhNFE0dENsV291STZKTWNL?=
 =?utf-8?B?cVFoc3lFMkdHTHRTV2JEWndYYkxKZWQ3UU1HOVRRT2V2R3MvbWI3TitBTkNh?=
 =?utf-8?B?Nm14TUdFYU1qa0RIQmF4dUF4TEZCZjhPWSsrMXVXNjZlSVdrU2M2V1N0OHZD?=
 =?utf-8?B?WUVSZEI5ZlBqdnhja3dhdTVwVHFzNjVXLzhxdFNjNEVEZ0RWNUJ6amN6L2NM?=
 =?utf-8?B?NDROZkdFaDJMaGs4djRld2RXaU9DMXcvbmtDUjAwZ0dUSFVidXptNlAybVRF?=
 =?utf-8?B?UFJqWHhlamdJSVlOdmszTFlSS21BcGVieUVOWWdWeEZtampiQXZRRGR6ZVpG?=
 =?utf-8?B?OTRRSSt4aXB0NkNZcnZkUGhDaThmZHVPQndWMU8wd0dhdmFrckRaWC9nN2dL?=
 =?utf-8?B?cWc9PQ==?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b5bd3e-a69b-422f-5fda-08da7a2e00d1
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2022 17:38:42.8558
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LE3Ioww/u8nO0XH4kmXHbZsBh1O64kXl5G+a2nm3p8LoHcmei8Mypfmo9vmIWj3+
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4604
X-Proofpoint-GUID: uI2NTHJScLeqAeU9CjauO3YYHMrK2urx
X-Proofpoint-ORIG-GUID: uI2NTHJScLeqAeU9CjauO3YYHMrK2urx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-09_05,2022-08-09_02,2022-06-22_01
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



On 8/8/22 5:02 PM, Andrii Nakryiko wrote:
> On Tue, Jul 26, 2022 at 10:11 AM Yonghong Song <yhs@fb.com> wrote:
>>
>> Add struct argument information in btf_func_model and such information
>> will be used in arch specific function arch_prepare_bpf_trampoline()
>> to prepare argument access properly in trampoline.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 20c26aed7896..173b42cf3940 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -726,10 +726,19 @@ enum bpf_cgroup_storage_type {
>>    */
>>   #define MAX_BPF_FUNC_REG_ARGS 5
>>
>> +/* The maximum number of struct arguments a single function may have. */
>> +#define MAX_BPF_FUNC_STRUCT_ARGS 2
>> +
>>   struct btf_func_model {
>>          u8 ret_size;
>>          u8 nr_args;
>>          u8 arg_size[MAX_BPF_FUNC_ARGS];
>> +       /* The struct_arg_idx should be in increasing order like (0, 2, ...).
>> +        * The struct_arg_bsize encodes the struct field byte size
>> +        * for the corresponding struct argument index.
>> +        */
>> +       u8 struct_arg_idx[MAX_BPF_FUNC_STRUCT_ARGS];
>> +       u8 struct_arg_bsize[MAX_BPF_FUNC_STRUCT_ARGS];
> 
> Few questions here. It might be a bad idea, but I thought I'd bring it
> up anyway.
> 
> So, is there any benefit into having these separate struct_arg_idx and
> struct_arg_bsize fields and then processing arg_size completely
> separate from struct_arg_idx/struct_arg_bsize in patch #4? Reading
> patch #4 it felt like it would be much easier to keep track of things
> if we had a single loop going over all the arguments, and then if some
> argument is a struct -- do some extra step to copy up to 16 bytes onto
> stack and store the pointer there (and skip up to one extra argument).
> And if it's not a struct arg -- do what we do right now.
> 
> What if instead we keep btf_func_mode definition as is, but for struct
> argument we add extra flag to arg_size[struct_arg_idx] value to mark
> that it is a struct argument. This limits arg_size to 128 bytes, but I
> think it's more than enough for both struct and non-struct cases,
> right? Distill function would make sure that nr_args matches number of
> logical arguments and not number of registers.
> 
> Would that work? Would that make anything harder to implement in
> arch-specific code? I don't see what, but I haven't grokked all the
> details of patch #4, so I'm sorry if I missed something obvious. The
> way I see it, it will make overall logic for saving/restoring
> registers more uniform, roughly:
> 
> for (int arg_idx = 0; arg_idx < model->arg_size; arg_idx++) {
>    if (arg & BTF_FMODEL_STRUCT_ARG) {
>      /* handle struct, calc extra registers "consumed" from
> arg_size[arg_idx] ~BTF_FMODEL_STRUCT_ARG */
>    } else {
>      /* just a normal register */
>    }
> }

Your suggestion sounds good to me. Yes, we already have
arg_size array. We can add a
	bool is_struct_arg[MAX_BPF_FUNC_ARGS];
to indicate whether the argument is a struct or not.
In this case, we can avoid duplication between
arg_size and struct_arg_bsize.

> 
> 
> If we do stick to current approach, though, let's please
> s/struct_arg_bsize/struct_arg_size/. Isn't arg_size also and already
> in bytes? It will keep naming and meaning consistent across struct and
> non-struct args.
> 
> BTW, by not having btf_func_model encode register indices in
> struct_arg_idx we keep btf_func_model pretty architecture-agnostic,
> right? It will be per each architecture specific implementation to
> perform mapping this *model* into actual registers used?
> 
> 
> 
> 
>>   };
>>
>>   /* Restore arguments before returning from trampoline to let original function
>> --
>> 2.30.2
>>

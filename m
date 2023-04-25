Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCDEA6EE763
	for <lists+bpf@lfdr.de>; Tue, 25 Apr 2023 20:11:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbjDYSLO (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 25 Apr 2023 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjDYSLM (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 25 Apr 2023 14:11:12 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DA7F16F13
        for <bpf@vger.kernel.org>; Tue, 25 Apr 2023 11:11:11 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 33PC7MNE014719;
        Tue, 25 Apr 2023 11:10:50 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=i61GunMWfcPmXmi3vrPNvhe27AvzrKUtsuEeQ2FPidA=;
 b=eWuexWFnRr2A+5b0FFtECB/mKAaw2gNvghyPZq6M43do18LJAs9OG71imI4dImmCm3vF
 u7ZxYNZIdujQtDok0wlDi/4XSX6CfflHP26sMGw5ML0EokCX5wAvzWZ5RfYakTpzTyz8
 5YGNMKGhkgOhiWkUSXLTj9MCdNJ2twHfsou3rf0I/P1LeISvkYCNlxuRJYOaa4uYrw5v
 PCy6b18/Bl0d6LEq7+iY8tgcdF+zxtDvt/zuhXhEh+t1zQCJyuj+oAdmBiKMdJ+SAc4Z
 mvWcc6MYiiBWr60H8xzu7DgZmrKL/AOzP2+qox41Olyc9X5bPVYxIqrEauV2N9gj2GZL tA== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2176.outbound.protection.outlook.com [104.47.73.176])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3q6ek7jp2n-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Apr 2023 11:10:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VxWSLbYWoIBENhLjWTiAWk7SzIzX8AKZKTzK+x0dxWyMe4aSL7/6fvket/zLWgQULLIq+QKtKGdaLy/8GAQryxs0H6uTzLfEfJGswJvUUxci0q/cyxIUK13IVNLHk25cpCE7eq7vhhVjw9jGoovEjc9LbjxNsILWsWy72RdnbXHOpUMU5lLgVdSB1RQdUoyvHw2HstN3VLFg8qA8Ci3H/7rElcDIgbauJPD5lHxwxPav92Kp/cRsaqrELhSOwq6oKdQ4JWlFE/L1I6jN1YLh4IQ+84U/9qmOUWHm/yWMllNjT8n7FIVmp3ZSnmxphp3kt1Z5UaJYSDkhznS6tzJOEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i61GunMWfcPmXmi3vrPNvhe27AvzrKUtsuEeQ2FPidA=;
 b=Nbf+9VlNxYy/DySRzxZJ2UzOBwaYQKQzkfphVEcO0eowQt/2z0y/hTGXKDJj6E1mVYr8ks9vFjCSJFXJfeNPhz7WeOY+++CAW2HckiVE2DoQhJLFJtQ74vU5tLh8rEOwaFIn+TnOaeWQwwCiHSVKAHxzE+tGH3VY+Hnoi4Krkks4DvkKh2hMHvNnx29RMtAVrQLzcAd8ACfaRVadBH92MFGZb0lUusaMmtOenyZXIlKQVIU1YALG0IGswQkJfsQ2r0oKnCkBCF6dHkABkAL5m8CSs28pD0JiX7/Hww9Tdc9i5ex8T8DE2TpC2S974VwZ7Zkwv1XLQ6CUJDqYttRpfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by CO6PR15MB4177.namprd15.prod.outlook.com (2603:10b6:5:34b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6319.34; Tue, 25 Apr
 2023 18:10:48 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%6]) with mapi id 15.20.6319.033; Tue, 25 Apr 2023
 18:10:47 +0000
Message-ID: <45aba643-7862-f615-6f6d-ff706e74a1b8@meta.com>
Date:   Tue, 25 Apr 2023 11:10:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.0
Subject: Re: [PATCH bpf-next] bpf: Make bpf_helper_defs.h c++ friendly
To:     Stanislav Fomichev <sdf@google.com>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
        yhs@fb.com, john.fastabend@gmail.com, kpsingh@kernel.org,
        haoluo@google.com, jolsa@kernel.org,
        Peng Wei <pengweiprc@google.com>
References: <20230425000144.3125269-1-sdf@google.com>
 <fb24192d-b443-4e0b-df99-2a8f972cdf0a@meta.com>
 <CAKH8qBuCMk_Ct5+gwRjc3f_3Rq17D+WOV4LaSLJZpuOHU6a6kg@mail.gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAKH8qBuCMk_Ct5+gwRjc3f_3Rq17D+WOV4LaSLJZpuOHU6a6kg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:74::15) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|CO6PR15MB4177:EE_
X-MS-Office365-Filtering-Correlation-Id: 04119c28-2819-4ec1-6b81-08db45b86527
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PIfw+/xA7vDCYYdpby9yq6bc/RUZ/UM2YlxVRwsLJ70veKwixt0E22sP8i/ps5wf4FkeFlOr9mfusdFF3bu+Xy6QtXM/ASJFKrXs3zpnZXXVrQm0h7wBd0afJc7nZVhN86n9UhPNuWDiQJIIewY53sV2gJY10/nZQpkVupX7QNKMI4jyD2HNrGN0njb83htePrIZ4wKsCGwmFy6QH29nAnaO5hZX8FLPb0sLwMJSPGnXTcUL8At+mZJ5otNyrE2Ng8SKXhixpEZHR/+kEGjX53zull48GJghzHe0yhEB21JelyMC9YqcrXNrh3obQXIBBsyUk1aHVoSqP8/+tPUruyHbAFXlFJgDMPYglYtAwg7U9iFzUD2mrchadXLNI/zirhvvX003Yp0NI6yxRcab5zhU5FI99V2uVMb5ua+401EgUqptLGd4E0NfA4vQZe0tgo0w7fORtuUsQj5peAd5K5+rwe0c4BrV+qjfnVEUGsl/FvtWwjZvNcS9tiLEBj1UVYCknS7lk1AS+pWua0RvK+q6+/iUldaBetaT5kPiR0PADZYz6iWxDrtYpevi4jj8ywY0feVPNgQhXqoA/k1kEE5g4rwMlGsaEe3fxb4ncdMD2lY6xvCCacPH+g4LPlGZXXILlu9Ilos7JRvEQk8HDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(346002)(39860400002)(376002)(136003)(396003)(366004)(451199021)(83380400001)(2906002)(41300700001)(7416002)(66946007)(38100700002)(66476007)(8676002)(8936002)(31696002)(53546011)(86362001)(31686004)(6506007)(6512007)(186003)(478600001)(66556008)(6486002)(6666004)(36756003)(4326008)(6916009)(5660300002)(2616005)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZFpQVC9VNUNJU1BLZVJCc3p3ME14dEcvVGNPNFkvM2tBclBtNTVSQ1oxTDhw?=
 =?utf-8?B?aVo3bzJqN0NwaFdWMzUyeFZDYkV0aFE3VW5yZkF2VytwL1R4ZkZWTk1YVXFt?=
 =?utf-8?B?OHVxZVpISVppK0RvMlJPNHp4V0ZtRG9PL1VHMlBRenBoZUJ2M3RDaG9FVTdu?=
 =?utf-8?B?WnVOYjhJS1VSc2xBdEhKckhQWEF5YWtEUnJTODRBWkUwVzRicWxqMFNDYVlB?=
 =?utf-8?B?UjBKZzlFOWRFcHNTamVFd3dYSks3U0VZSkg4eG9RcHFPeExEOXI3K3FFSmJZ?=
 =?utf-8?B?RHhOZVZlMGJXRU5nVUo2dC9hNFpsWkdpMHdCenl2UTF1eDc3V29CWjMyempP?=
 =?utf-8?B?QS9KZjNUQjFBVmxlb3IvMytGWXk3cW9rNUJVbTBkRkZPbDZybzBrTGF6NFlY?=
 =?utf-8?B?b1JEell1VmdsQkJHbldoV1ppbVpTWVhvSHlWeTVETnBxTWdibTByOTdUYmpw?=
 =?utf-8?B?ajJMRU1VZGFHeWZEL0ZXdlhzVFZURDFtemNYVzJNdTRwd2lvRWtFSUtTbzBV?=
 =?utf-8?B?bS95R2psSUhkRFpwM3dTdHlLSU5Kb2Y2cDdqQkkrbjhxWjRwUk9jdmVMQW96?=
 =?utf-8?B?TCtsT1NqcUI2KzRrQmJlTHJBei82ZzlwTG5NK2lSOFVVSDNzSzdpMHJKaktC?=
 =?utf-8?B?eVFDQi9xT3I3NnJJYnlqQjhMZmlrdDczbzkyTTE1d0pKdXBRMWlsdjVQMVhU?=
 =?utf-8?B?YmFhTEFLQmJHbmpMbHlucTU4WW1ZbVVqU0Jrdy94MU1DSXlXam54bWxKTm5Q?=
 =?utf-8?B?R0duUEJGazB3UW1LZThGYmhub2o4S0hzbkx4THcvck9XeFoxL3JiL3c0Umdm?=
 =?utf-8?B?dEpPb3RPMGpjL0JLSklTcFhFVG1KbjFPTjZSTS9XaDJRa2Rabnh5Qk0yd2Jo?=
 =?utf-8?B?RHpzZGc4eVJFbXkxTE9ZNzFuaHBTcVFHdEo0UkxLQk5qWFlUUEc0UVd4ZndR?=
 =?utf-8?B?T1FuQURSVURmb1pCVDhoS0ZwMFJmeThNRk5hTVRqZzNyYVY3MkgySFRCWnhT?=
 =?utf-8?B?bWo5eWFUK21IMnVBSFUzUDVUWmZGUVRkckpETXZ4TndjQkNwL29kSDNscW12?=
 =?utf-8?B?OWlJN0hHT1B0TWpZWEtjV0RJMVhpeDFvLzlualJMaW1UM2dJcDRsdkRMM1dn?=
 =?utf-8?B?bUE1ZkZjSzM0Wk14WGRBd29xR0dMdE50bzR1b3BmTjc2cVlTSHBMRWpXamM5?=
 =?utf-8?B?SUdBM0gzczBHdWlKVG51VEFPOUhMM1ZvUzl6ZVlTN2IxUXpMRktNL1RXR1RN?=
 =?utf-8?B?L0VTbkpCdTBCQ1EvcENFa25tbzJPNXpBdVh3T25ic0NNOTVtQ1k0L3dNa2tW?=
 =?utf-8?B?YWwwdGtUTGxBdHRuc0p4ckNLSXBsM0xZMHp1NURPSHlsYi9LTFA5QjBnUmlB?=
 =?utf-8?B?RC9aY3pNRk1FZGlPZUthVm93NG5TVG0xbHRyR3k5WXhoZVRDejY5Y1dtUHl6?=
 =?utf-8?B?VldqRSsvd1VxUmVSa1hvd1prQmRWOUNWNURGZ3crWTBTUll3Wks0QXpHN1dp?=
 =?utf-8?B?WHUrWDJhc0YzYjdUdDkrQVI5ZFUyVGlqRXNxV1VjVWIzZEZYU1liaDZlUWZS?=
 =?utf-8?B?dDlyZi83d0gzV2cxYlhxZWRzSDJFL0hKRFNxTm5nTmcvdnNpUmE1QjlqZ0Vq?=
 =?utf-8?B?K1JzTmQ5STlqNUUzRWpXMEpPY3AwWUhqRlR3UlFNcU94Q096RkxsV3Q1a25Y?=
 =?utf-8?B?UG1KRHlWL0VibFNSSndHeU9RR1B4NmwxUGxndVMrOXh6SzNSQ2MyZG1BNlJ2?=
 =?utf-8?B?SW1wUkd5MnE3SkZkWjhObzNaZkk5YmJ3TmhFV1JiUUVHcnpRVjFuS1hRZlNX?=
 =?utf-8?B?bit2dFR6c0l5WDM3bVhMYWZaci9OeU10aDhrTnZLbEFCNmJVSjRtK3JTVWZY?=
 =?utf-8?B?VXF4YnBBaTJ4cUsvUVZvUlZNRUZKeDY4d3ZOQU9DNTBIellHVW9qbzRSbUpV?=
 =?utf-8?B?UmRVWmpUQWhUSHFuWlUvUWtpNGlmUStBb2I4azcxNW1nVjlWNUQzaTRjcXEz?=
 =?utf-8?B?M2huNW5uV0FNVDZZT0R2MEx3UDVzYXZMOExEUEdJTC9oZFIwUDdnenY3K0lS?=
 =?utf-8?B?NGtpVUVUZHBETzVjZGhFNndKb2c0aDBIbm4veWtDL0JYc05MaWNwOEZLayt2?=
 =?utf-8?B?TERSVVR1eHpyOXJ3Z3NFQmd2L3czOGxWeWF3V0FQcFNBYWlFUTVYaEhPZmhO?=
 =?utf-8?B?Qmc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04119c28-2819-4ec1-6b81-08db45b86527
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2023 18:10:47.8232
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pgpgl8NeQsqmHKdLkyeXL68Ci1v75ZoiTg2hH/TKN4Y1XwnSuTmK9nEyN8Kf/lxB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR15MB4177
X-Proofpoint-ORIG-GUID: dDX9SXz0F-C5PlQL4RnPB726ITa8L6Ce
X-Proofpoint-GUID: dDX9SXz0F-C5PlQL4RnPB726ITa8L6Ce
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-25_08,2023-04-25_01,2023-02-09_01
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/25/23 10:04 AM, Stanislav Fomichev wrote:
> On Mon, Apr 24, 2023 at 6:56 PM Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 4/24/23 5:01 PM, Stanislav Fomichev wrote:
>>> From: Peng Wei <pengweiprc@google.com>
>>>
>>> Compiling C++ BPF programs with existing bpf_helper_defs.h is not

Just curious, why you want to compile BPF programs with C++?
The patch looks good to me. But it would be great to know
some reasoning since a lot of stuff, e.g., some CORE related
intrinsics, not available for C++.

>>> possible due to stricter C++ type conversions. C++ complains
>>> about (void *) type conversions:
>>>
>>> bpf_helper_defs.h:57:67: error: invalid conversion from ‘void*’ to ‘void* (*)(void*, const void*)’ [-fpermissive]
>>>      57 | static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>>>         |                                                                   ^~~~~~~~~~
>>>         |                                                                   |
>>>         |                                                                   void*
>>>
>>> Extend bpf_doc.py to use proper function type instead of void.
>>
>> Could you specify what exactly the compilation command triggering the
>> above error?
> 
> The following does it for me:
> clang++ --include linux/types.h ./tools/lib/bpf/bpf_helper_defs.h

Thanks. It would be good if you add the above compilation command
in the commit message.

> 
> 
>>>
>>> Before:
>>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *) 1;
>>>
>>> After:
>>> static void *(*bpf_map_lookup_elem)(void *map, const void *key) = (void *(*)(void *map, const void *key)) 1;
>>>
>>> Signed-off-by: Peng Wei <pengweiprc@google.com>
>>> Signed-off-by: Stanislav Fomichev <sdf@google.com>
>>> ---
>>>    scripts/bpf_doc.py | 7 ++++++-
>>>    1 file changed, 6 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/scripts/bpf_doc.py b/scripts/bpf_doc.py
>>> index eaae2ce78381..fa21137a90e7 100755
>>> --- a/scripts/bpf_doc.py
>>> +++ b/scripts/bpf_doc.py
>>> @@ -827,6 +827,9 @@ COMMANDS
>>>                    print(' *{}{}'.format(' \t' if line else '', line))
>>>
>>>            print(' */')
>>> +        fptr_type = '%s%s(*)(' % (
>>> +            self.map_type(proto['ret_type']),
>>> +            ((' ' + proto['ret_star']) if proto['ret_star'] else ''))
>>>            print('static %s %s(*%s)(' % (self.map_type(proto['ret_type']),
>>>                                          proto['ret_star'], proto['name']), end='')
>>>            comma = ''
>>> @@ -845,8 +848,10 @@ COMMANDS
>>>                    one_arg += '{}'.format(n)
>>>                comma = ', '
>>>                print(one_arg, end='')
>>> +            fptr_type += one_arg
>>>
>>> -        print(') = (void *) %d;' % helper.enum_val)
>>> +        fptr_type += ')'
>>> +        print(') = (%s) %d;' % (fptr_type, helper.enum_val))
>>>            print('')
>>>
>>>    ###############################################################################

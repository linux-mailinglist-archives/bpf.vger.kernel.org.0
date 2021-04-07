Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D0753577FF
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 00:52:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229529AbhDGWwJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 7 Apr 2021 18:52:09 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:45218 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229600AbhDGWwH (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 7 Apr 2021 18:52:07 -0400
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 137MoLtZ011818;
        Wed, 7 Apr 2021 15:51:49 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=0HqgRhH0t18UBju3GuNfuxZeLenaI4qk9PWZr2Rmb/E=;
 b=etLMOLVM6IuWs4Bx/Vq1DwKFBh7MD1iNSwJlcP8GGf5Yz4fjn46PGIhFjTF2zkGZBjFB
 PvHB8t2dAzcl3b1Fu45PFyU7B2uCu+lSMko3Y6HpDos3qhEsF3oE+D/SCO878I8k5J7p
 5tkg58Ys5+S/IpqpD9Rf/3mGMyHQfx8P9eA= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 37sg04jfdv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 07 Apr 2021 15:51:49 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Wed, 7 Apr 2021 15:51:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BIAVWS9cQF0XtYnckr7VVJDdfM3WuCgxKQz/oMhCTa55Awc+SW7UQYmli+0UmtDnv0O6dk9J5S9Y3nyFafnaL/+8PgkNkoFTSHcHiQTTzBj3JXK8CD1x53Hr0h3HAWxfN3UT/dzwMe4wc8nHuJXXmmT5agOiOopNuGfTkqG7Qwy2Rar0PYGovwVJ9e57F8NAz4owdWjdUGlSKcpzSf98fviFc2brEDX7TVOJW+s5KxrW/FMOazTNH6IXqKXiLNrtlNoJjh/ACE2bd4wkA/gaTDFrSx2VJSWJDy/Ef583sHuzbPsTaU+lpuFAwscpNHvhHntpz7Fs7kfKoo3FcXBfmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0HqgRhH0t18UBju3GuNfuxZeLenaI4qk9PWZr2Rmb/E=;
 b=PexT2F4PxgwX3jPXPANhZObRvRYXmoRiORufrKf+LVON7+Jcgy1UcYFMclfI+Qsj0GU9dzSmQ6KVNyxtq14D8nhBkQUjgJgnHMBdAXrk74KneuMGepLNkTdyjgFutXnWozPCgBEqm+RHuQx8ccy12dvSxZcuBifEPLER2Owm0Neu1Wb6J+KFRKCvmECef4whDUwtslc01m1Ly8ZEy0OyIEHGnfLclXYz97X0sRclIA+6n46EEvpc0lBplFqTWfGetlWAViKbl2XUwUvapCcJ+831H7UJvng01OXSGOraQzOidtaBso+zv5+tu1Sd6XQaOH7n7bzr5m7dMJDFpuLHog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SN6PR1501MB4094.namprd15.prod.outlook.com (2603:10b6:805:5a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3999.27; Wed, 7 Apr
 2021 22:51:47 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::f433:fd99:f905:8912%3]) with mapi id 15.20.3999.033; Wed, 7 Apr 2021
 22:51:47 +0000
Subject: Re: [PATCH dwarves] dwarf_loader: handle subprogram ret type with
 abstract_origin properly
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
CC:     Arnaldo <arnaldo.melo@gmail.com>,
        David Blaikie <dblaikie@gmail.com>, <dwarves@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Bill Wendling <morbo@google.com>, bpf <bpf@vger.kernel.org>,
        <kernel-team@fb.com>, Nick Desaulniers <ndesaulniers@google.com>,
        Jiri Olsa <jolsa@kernel.org>
References: <e6f77eb7-b1ce-5dc3-3db7-bf67e7edfc0b@fb.com>
 <CAENS6EsZ5OX9o=Cn5L1jmx8ucR9siEWbGYiYHCUWuZjLyP3E7Q@mail.gmail.com>
 <1ef31dd8-2385-1da1-2c95-54429c895d8a@fb.com>
 <CAENS6EsiRsY1JptWJqu2wH=m4fkSiR+zD8JDD5DYke=ZnJOMrg@mail.gmail.com>
 <YGckYjyfxfNLzc34@kernel.org> <YGcw4iq9QNkFFfyt@kernel.org>
 <2d55d22b-d136-82b9-6a0f-8b09eeef7047@fb.com>
 <82dfd420-96f9-aedc-6cdc-bf20042455db@fb.com>
 <E9072F07-B689-402C-89F6-545B589EF7E4@gmail.com>
 <be7079b4-718c-e4a7-dff4-56543e5854a6@fb.com> <YG3RpVgLC9UEUrb8@kernel.org>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <32069669-c2aa-11ae-e54b-4852af145b10@fb.com>
Date:   Wed, 7 Apr 2021 15:51:43 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.0
In-Reply-To: <YG3RpVgLC9UEUrb8@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:3758]
X-ClientProxiedBy: CO1PR15CA0110.namprd15.prod.outlook.com
 (2603:10b6:101:21::30) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::10dc] (2620:10d:c090:400::5:3758) by CO1PR15CA0110.namprd15.prod.outlook.com (2603:10b6:101:21::30) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.17 via Frontend Transport; Wed, 7 Apr 2021 22:51:46 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e2903b8e-6ba5-42a7-866c-08d8fa17b94b
X-MS-TrafficTypeDiagnostic: SN6PR1501MB4094:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <SN6PR1501MB4094CA4D1019A79A17647D34D3759@SN6PR1501MB4094.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:1265;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ljX3Vaq6V1pBLA++7DaJ+54nDKLPCfLWyQ4nWrOShSTl3rS7kD2RXaVDatmngj6zNMMrZgZUud4sK82p0LS1PKNvLybzA+TwBeLvaqoVCRHoaGijJrXDwseDrbor8XoV09B8/N0vA+F1/YOTgm7PIcM6WfKKUB90r/ZLp4y6r1ndYmMFHdavRGDEQCpal4U0Gdzgr/qIlJCCOQH+yP/qVaiHBSXJ7/mHGXiupIoh9PtNJo6conSZWFs0NCR6Ml7F7KJifmNA6YVtchGUPUeSOJjAs0EdIIAL5PweB/KkE/UV1/Db8L/RQuxuKD5NTq+r6lzniONrc8YR03eNMBRALnpKuWSiTWQezz8Pvn+TILsSn7qUi2JWrr0aUH2AblUFeETTzcQp6jwh5hN055+N1nJR7qMW69uET9T4nWFzMZGrCpB+8Tjia/WfsPWTDrdnrjwGnS/JWWJ+6vVUIfSyRRXzxkgGlUCaVePt9I2+uRTblfei8CdVVMo+I0TLvppIxoJ79A/ikDQML0EtIo/zebd+Cav2TDwF4sAzQf3AEmQiEv8mvh59M2CcOoDHVkliIRalWMEiw/sATjbnrmcbvbkasoV9vc/SpbjfW320aotLosRNWiPg7Sudb11dsX5NvnGqRcXvYmaKZBZsyPkFyuBnbOuxLRV/JH9CSt0Yh/D9pkCvnFnvmaD0L4h35D143f8Lab9C1pwK2IT+wlwZBHf5Nwtrh6FRh5ua7fQlTfK6PxI+ZbhVeatCdV3UUCLLdh3Xy0mKvoiBUbP/zxwcABDqDTdbFrVASoVPWlt6DWl4n9K1eTOMyncCYKIlpb9v
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(346002)(396003)(136003)(39860400002)(366004)(6666004)(86362001)(31696002)(316002)(16526019)(186003)(2616005)(8936002)(4326008)(53546011)(478600001)(8676002)(38100700001)(6916009)(966005)(6486002)(52116002)(36756003)(66946007)(54906003)(66476007)(66556008)(31686004)(5660300002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UlREYjdSNyt1Yk4yNVpwLzhmM1dOdVBlUVlQTmNyR0syMCtQamEzd0hsUG1x?=
 =?utf-8?B?cXpwSXFiMitsMVBRM2trZmJzWjJ3NklaWUZNWUhyK3YvOTBzbTBCME90M3Bm?=
 =?utf-8?B?UG1SQTFZRmlyb1RFeHAyYlFFVG9ORnYyVjRmdFhiSjEvV3ZFMlI3RlNzQlBE?=
 =?utf-8?B?T0MvZlBQNEtldEJZWUFEUHFtQmgxUHUxZlZ5dHRha2ZJR2Izb0RvYlR4bVFB?=
 =?utf-8?B?ZkFudkhYc1hIcjJCZ01XVk5INkltbndWMzkyQ1JxVG5rcVRIK3ZpYkROTFU3?=
 =?utf-8?B?UVVOTnd2eEcwVklXUkVTV3RPM3Y3T3MxWWhiajdST0hVUkkrUGcxNnNyZFBL?=
 =?utf-8?B?MWNLeVZQcHFMSUpldFExZm54UkFVZWJNRW0xaHNJZFJwaHVrbWxScTRIV1l0?=
 =?utf-8?B?UHpnVlh3dGRZVTBnVGFLeDFENGdva0tEbDI5ZDJ1OTVYbVdDTUlhY3Q4cnRE?=
 =?utf-8?B?cWo1QWFiRHV0M2Vrb3dEaG5hSnZPTUVMemNzUkpZQVhKbEpVejQ4N0Y0a1o5?=
 =?utf-8?B?UFhpa2hYT1hqWnFPRmFrOHRWblgzamE5QnlPMURLSkEwRFNBc29RTUFoSUs5?=
 =?utf-8?B?VG5ERytMWUNkNTVXT3d6QUgrSEtqWGs4Um0yenJFbTF5eElwTXkyYTBtc0FD?=
 =?utf-8?B?WHdVRjErZjVYNE9mZWxJQ1l2Y3llak9uNGZuNnorL2RVcWNNdmlseFl2SG1s?=
 =?utf-8?B?NVJqUk0ydkF5NVYzN3VFSnl3TTlrNytMQ3Y2NVAveklqMUVvQWExSFN1cDd5?=
 =?utf-8?B?MFB2ZCtRSlc0Vmx4ZjJGN3hqeXdqWmY2MHloZkF3MS8rSUFiQTdSM0VTMlBk?=
 =?utf-8?B?ZjdacDA4YWtSSWJ3ZmFMSnFvVzIzajRGNWZVY05QMmNSaStBSnYwWm9tNDZp?=
 =?utf-8?B?bU5UYkdpeFpIMHh0T0JLcVZnSnRWbWMyYzFsK3M4MEpJUmRTdHZrSUNPUk4w?=
 =?utf-8?B?Mmhld3h5Z21rNFdBVGVBWExwc2lFbzJVa01NRmszYkxSaEI3SEZUd3NLd0ZQ?=
 =?utf-8?B?RFlweTVTbXdSSWVwYzAxUzBMM2VCTTdOYUo0T3kzRXA0a1pHb09tSzdTQjdL?=
 =?utf-8?B?SFlQb3pVNjZZZDVYMWd0c1FqdFhMNjU3NFB6eWVyY0YxY3dzMmdIWnZja3lv?=
 =?utf-8?B?YlhldlQ0dFBsNzJUd0NjQ0VjT21JdHhGWlVWY3ZrcTN3SDRyRHlpNjRUWnJi?=
 =?utf-8?B?MW0xa0lPUnoyWXcrZklnVmFNdXdFV0k0Myt5bnJITUVsQUdYTENLRGJCNEl0?=
 =?utf-8?B?TzBTazJIS3dDTUFsQjJCK3U3bkIzSXJQclovZ1lOLzF5N1JKa1VmWTF4djF0?=
 =?utf-8?B?dEZCVFJTVWJPcWY5clFzV29rdS8yZmJtcGhtdC9Ea2M1L3A5K1I3OGhxNUtt?=
 =?utf-8?B?bzFTZ3NYTXkrZkhKNGpkUkFPSmpIcG5uN2FzcXdIMXg3OGsxeWZxWkw4dStC?=
 =?utf-8?B?Y3hTQkNYYkRpTXQ2TEFlYXlWdFFuUGxBbWVRU3JQa0ZZQXhTUG9hRmVZdzVZ?=
 =?utf-8?B?QU1UT21PL0ZWWUp5OGxrcHVHVXEwUU8zc2ZuR0plU2s4Qk1DaTZ5UENpWk9p?=
 =?utf-8?B?bjltVEx2RGdCYnlaWWRqQzBHWUV2MG9LNjhZaWQ2UmxTV3RzVzdZeWZWNUwy?=
 =?utf-8?B?MEhhaDZGSXplWERrbi95M0JBWmpUdlArR1MvMEtVL3BMMGhZMGI3T0pmUWJi?=
 =?utf-8?B?M3BqK250alI1cnN3Yi9uK2FDQkJZM1Y5Z3lQQUVnOEJ5WVlwVTFPNVRZeThR?=
 =?utf-8?B?UTBzT0Nqc21wbUc0dmx4VmhqVFlEZWRZeXM3c2duQzFsalhEdjcwR2NHSmlk?=
 =?utf-8?Q?P87BO4EYG+sd6nyUuYfiIg9H9CnBxBAZqkkV4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e2903b8e-6ba5-42a7-866c-08d8fa17b94b
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2021 22:51:47.4860
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gJ/W7QZrXS23m5B4odUSoy9MRBxHaFtRjRYdh8gwfIkObkPR00aT1MJ5Mv1iZNq7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR1501MB4094
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: ayLELDpyLK-13vLPogjZQt2P_yZC_R--
X-Proofpoint-GUID: ayLELDpyLK-13vLPogjZQt2P_yZC_R--
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-07_11:2021-04-07,2021-04-07 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 adultscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104070162
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 4/7/21 8:37 AM, Arnaldo Carvalho de Melo wrote:
> Em Wed, Apr 07, 2021 at 07:54:26AM -0700, Yonghong Song escreveu:
>> On 4/2/21 11:08 AM, Arnaldo wrote:
>>> On April 2, 2021 2:42:21 PM GMT-03:00, Yonghong Song <yhs@fb.com> wrote:
>>>> On 4/2/21 10:23 AM, Yonghong Song wrote:
>>> :> Thanks. I checked out the branch and did some testing with latest
>>>> clang
>>>>> trunk (just pulled in).
>>>>>
>>>>> With kernel LTO note support, I tested gcc non-lto, and llvm-lto
>>>> mode,
>>>>> it works fine.
>>>>>
>>>>> Without kernel LTO note support, I tested
>>>>>      gcc non-lto  <=== ok
>>>>>      llvm non-lto  <=== not ok
>>>>>      llvm lto     <=== ok
>>>>>
>>>>> Surprisingly llvm non-lto vmlinux had the same "tcp_slow_start"
>>>> issue.
>>>>> Some previous version of clang does not have this issue.
>>>>> I double checked the dwarfdump and it is indeed has the same reason
>>>>> for lto vmlinux. I checked abbrev section and there is no cross-cu
>>>>> references.
>>>>>
>>>>> That means we need to adapt this patch
>>>>>      dwarf_loader: Handle subprogram ret type with abstract_origin
>>>> properly
>>>>> for non merging case as well.
>>>>> The previous patch fixed lto subprogram abstract_origin issue,
>>>>> I will submit a followup patch for this.
>>>>
>>>> Actually, the change is pretty simple,
>>>>
>>>> diff --git a/dwarf_loader.c b/dwarf_loader.c
>>>> index 5dea837..82d7131 100644
>>>> --- a/dwarf_loader.c
>>>> +++ b/dwarf_loader.c
>>>> @@ -2323,7 +2323,11 @@ static int die__process_and_recode(Dwarf_Die
>>>> *die, struct cu *cu)
>>>>           int ret = die__process(die, cu);
>>>>           if (ret != 0)
>>>>                   return ret;
>>>> -       return cu__recode_dwarf_types(cu);
>>>> +       ret = cu__recode_dwarf_types(cu);
>>>> +       if (ret != 0)
>>>> +               return ret;
>>>> +
>>>> +       return cu__resolve_func_ret_types(cu);
>>>>    }
>>>>
>>>> Arnaldo, do you just want to fold into previous patches, or
>>>> you want me to submit a new one?
>>>
>>> I can take care of that.
>>
>> Arnaldo, just in case that you missed it, please remember
>> to fold the above changes to the patch:
>>     [PATCH dwarves] dwarf_loader: handle subprogram ret type with
>> abstract_origin properly
>> Thanks!
> 
> Its there, I did it Sunday, IIRC:
> 
> https://git.kernel.org/pub/scm/devel/pahole/pahole.git/commit/?h=tmp.master&id=9adb014930f31c66608fa39a35ccea2daa5586ad
> 
> @@ -2295,7 +2323,11 @@ static int die__process_and_recode(Dwarf_Die *die, struct cu *cu)
>   	int ret = die__process(die, cu);
>   	if (ret != 0)
>   		return ret;
> -	return cu__recode_dwarf_types(cu);
> +	ret = cu__recode_dwarf_types(cu);
> +	if (ret != 0)
> +		return ret;
> +
> +	return cu__resolve_func_ret_types(cu);
>   }
> 
>   static int class_member__cache_byte_size(struct tag *tag, struct cu *cu,
> 
> ----

Thanks! I just saw it in the master branch now. Somehow I did not see
it in tmp.master branch yesterday and I don't know why.

> 
> My latest tests were all with it in place.
> 
> - Arnaldo
>   
>>>
>>> And I think it's time for to look at Jiri's test suite... :-)
>>>
>>> It's a holiday here, so I'll take some time to get to this, hopefully I'll tag 1.21 tomorrow tho.
>>>
>>> Cheers,
>>>
>>> - Arnaldo
>>>
> 

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665E263FC86
	for <lists+bpf@lfdr.de>; Fri,  2 Dec 2022 01:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbiLBAIr (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 1 Dec 2022 19:08:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231977AbiLBAIo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 1 Dec 2022 19:08:44 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2ACE13E2B
        for <bpf@vger.kernel.org>; Thu,  1 Dec 2022 16:08:41 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B1N4bcO024415;
        Thu, 1 Dec 2022 16:08:26 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=ayMDS3/nAdextYvSF/WkeOexUS6N0irXVP2l5ClagHI=;
 b=Thg0JAIpolYGhzKKOvhjuofLKzYOL0KJy+ggG9x8UuOgyljWsFQGb/lB2HLeKwbUXu4d
 K+66dlkmh5nJEVIGbwaVKffedK4IFsD0FTAfUhagI0//oIkCLRpKOZG8SNLrgLXTwndR
 sMq+EUpJ1qTMngvLv810T0DkLTJaDx0mAxVH+ALdKsYUsYJV5X+6kLTRQV19tXVxhoBB
 mARHmpq/69zKiN+rLnymAOIzpCLkPsH9TuMjmIv9LX4Tb7yKP+SggTUl/UrQ/RzkurGq
 xd88Yy34ub47XFVf5pR4IF5GaiV1unzalIpVigLOeS/3kAmvC72fpBAg9KF9ydmPeoCB kQ== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m6vruwese-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 01 Dec 2022 16:08:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cGTEH9dEeT81OpWvz30A8UyxQZ8NCR5Iw/WaSRJdM0+rFVuejsBYA/PF7ya3a0s1eiqWLgARnGljRT4HkemFnpa8T4p9mPHR/Wqf7XsWaL6ChNKxDDZHT/o7hjbqygrun5KGtGBis5G4q8Wno0HJKoPQH16+X+aS2dJ/q0x1sxBcrrS/d0xQ+NpMSvggw7X/k9Bxt0HLlofdULeFqsSSqBs1O+s+pA2wiXHzOA1WdF8au8HcTp/jO36vxnWtS36m0zwQoLtCTmZzwamJujikv4aE1E0fFv9huszrqOJRfJZorJXWzAsIP8h4Tj+lt1ljQ3HTeZTliA0+k8Gm7kWe2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ayMDS3/nAdextYvSF/WkeOexUS6N0irXVP2l5ClagHI=;
 b=jJs2ASnvaQYaHnPT+YcU8HYl9u3EYR5BT69nCqBShO+U7CL3Vt4ojI+yCB/CU5sBabvum3X1MHcVFZm3fOX3RMxhLdJbzXwoNAH6L+u4XOLYDze9cHZ6aGBZVGV/7FLpFqravBai+UTHPoyQ8SmNh5xvJ2tglhM1VidJX6RDx3ZP0k1q5jWbm3X1V61Ki9FsChqvRDH8Zahp7v0o+7oI7rL72to6H1nd9H/5wdr50Z4ESPywk0tvCdWrn7aNMQL/zb7q76mfTd9Ah2emR5RbuGU9AbDNQiehLBb9QM3OS7NxGkCYNtXzskVHcN4cyylwAFytd+zzIl4/9RU9XmJS0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW4PR15MB4618.namprd15.prod.outlook.com (2603:10b6:303:10b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5857.17; Fri, 2 Dec
 2022 00:08:23 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.008; Fri, 2 Dec 2022
 00:08:23 +0000
Message-ID: <402a1b63-035c-b57f-5183-8373b05f22a7@meta.com>
Date:   Thu, 1 Dec 2022 16:08:21 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next] bpf: Handle MEM_RCU type properly
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221129023713.2216451-1-yhs@fb.com>
 <d46efd51-e6f5-dbb5-ab38-238b6d2ea314@linux.dev>
 <1a534022-5629-8f98-c8ad-f1c335652af5@meta.com>
 <71f4d953-fbfd-902f-bc8d-3894b7562eeb@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <71f4d953-fbfd-902f-bc8d-3894b7562eeb@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR05CA0097.namprd05.prod.outlook.com
 (2603:10b6:a03:334::12) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW4PR15MB4618:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f687670-eb3c-450c-7f22-08dad3f953e2
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y55X07CDbVKkArLaAf3VUmv2Lorg0YaD+lJOeeR0o2uTytHtLk+m/WDxnkW5zp/Z0ZyksH6W2y+MBgHR7KXKcdfyzjlkfdYpyxNk/b8dsRyJKDNTVaYJssnEoOrDieJ+fIu4bKBZ8T+u423ue3nDFHdEdLgVASNy+scvPl5Z8AcXX4m7k5H/lIH/U5x4SjP12JqH55l6plVIqWhmEeP0g/capdiIRc4NnkMYf9NU3PxpMZw+xKZ2XnzFokB69SUmAnE0lmGQB8x9OACZ6EmGia5ezFwW2GTHMwazniP2jqeRV/WFqe6OWLwCie/Vms45MUYyCI/GrPnNGfcvQPnO6VAVc2bgRHz2Y2dsL56ianpT32WWJptDfXFx32/6g/w7vm5rXETkTsWpGZFeGKr8x5EFpj7tSVxY4WlOdbAHkHxQdP1Oaxk1H2rdVQZHrh1g8r34MhmjMHVFPNh3mMGYAI8RcIiq0O5mprsfh0ON6xRB0xkef+Q09hV7GXRtIv6vgxo1/NlZ9MOpCRrTbfUaPTUd+2OTZ+ugojn5kN/yJYIcOZMrMc/lNwfdv0Adgu+YnBXRM57umXdVVUeMP77qXabGLqtK4tkDgFp0Bxxp1q0rUhBTGjtdS+LiZZH4hvjEF0zZks7TTFTKHqnWvsYkmUdzGGH7jqs+nnqjVCN9rJ6JQCBaYqPG4qgjFpbVQdYHhvBlLh3w3ArHQF4JijWsvtXAHZ32obvoeiA8xmOLK5M=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199015)(6512007)(2616005)(86362001)(41300700001)(31696002)(36756003)(54906003)(6506007)(6486002)(478600001)(8936002)(66476007)(6916009)(5660300002)(316002)(8676002)(66946007)(2906002)(4326008)(66556008)(53546011)(186003)(83380400001)(38100700002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QUdLT2V5UDVFR1VDN3hUMllqV0FYOE9Sb1NWUnNRdDRZc3RYc293cllmbjJL?=
 =?utf-8?B?NTVZK1V2MllVZEc4aDNEeUtmMzY3WXZRM1VUN1dQcXhkSjd2NEtwSTdYTU5J?=
 =?utf-8?B?TW5UTlBnTHRBckRNSTh4aGVTU09iUStQa1hHMGN2eEgydlBjSjdHbXR4UVBB?=
 =?utf-8?B?TmNKTUJYeit1ZVIvdjNpV3Rra2I1QjVFRzF0eklLdkp2ckVhQ3kzTlo2cVg0?=
 =?utf-8?B?dXhxa2ZuVFVCRVlJbVVkNHkwNmVlby9WZmFzVTlLckFycElYSkV4eUw5NUV5?=
 =?utf-8?B?aVpNZXZDaEt6SnZvKzFDNGpnSmNPQTR5SE1nRk1GTU4vK29Yc3NUODNzMzd2?=
 =?utf-8?B?VUYzdVBDN3lPc25WeEdXMGxybEs5blRrcXdTNUllNFNrRWU0RXZUVGJMSlZr?=
 =?utf-8?B?ZnljcVhLUUlRWHB5K0Y3a2tpMWMwVjdUQ3BHK1ZEbmVGK1lpM3hpc0ptRUlE?=
 =?utf-8?B?KzhaaEhpVEpoY05xcVV6bURXRmM2Rjk1SmV0MlVkd3dlbE5LVTl0WFJROWpU?=
 =?utf-8?B?S09ZOU9OVDFwUm52NFJFRXZDUzlORXlrYzFaMmVjQzcxZm5CN2h4NTUycXpH?=
 =?utf-8?B?aXVPTTFvTFl3WEZETGt0SVRabUV0Q1g1QW5SSWhVSVhVME9wU09FQ1FvVzRr?=
 =?utf-8?B?bVpoZDd0cnZHRzVFeVlYQUh0b0RCS1ptKy9Tb2I0ZVNUN3BWVFRPK05haHls?=
 =?utf-8?B?ak5MSTBpQVFncjI0VGRQOE5OWTdoUFlGYzU0bVhFcnZ5dUpvSjNtMTFPQjVO?=
 =?utf-8?B?V0lGblJOZDNBTkxWVzRBb3MwRXpBRnZZTlI4L0E1QkRlMDhmU2djTENkdW5M?=
 =?utf-8?B?K0VZOFRKdzJST1llMzUxSkZiQ0VDRG5DbTVaVDNlamsybmwzUkJVNVBmMGkw?=
 =?utf-8?B?TWZpUk1pQ3puYkhWOTBKLy9FVmdTZzBqbU9iWVR6K3VreWppc0R6WHVaMUh0?=
 =?utf-8?B?Mnl1S29kMHlhdnhnNGtUdnp0ZUFlWjM4VGZtY24wTmpla205TFpxKzVrcE1t?=
 =?utf-8?B?a2ttSnRzdHpONGxIdDNDVUZhUm5hSzRjVHVwTmdJYVdvbzg3bUxUOFFIYitL?=
 =?utf-8?B?a2pTcEtkaStrOGlyY1Yrb3BPK2FKZ3o1cFByNlVhcWxJTW9Hd0Zpc2s4V0VS?=
 =?utf-8?B?eFdvR3Y3SFFORnhtelJoU3dRRVZhZ1VKaDdFNzVDNUs2VUhLS3hGVHJzUWVY?=
 =?utf-8?B?MUJqbkFSV2ZqMnl0aHd6ZnhIRG9uNzR0Z0RleFpPOEpYUkpnK0xmTER2NXY4?=
 =?utf-8?B?blpkRUt1S1NuVlR5ZHcrWVdPYmVzbktoeTdGeFRDekdQNGo3K1BpcDRlK0lK?=
 =?utf-8?B?ZEtsamx6N3hPRGJrUUsrcjVFVm8xWGxwQ1phYWtibTB2clBsSk9BK3FUTDc4?=
 =?utf-8?B?NHI5Mk9CWmg4MW0vcGlIWlpaRDlTTFZBY0czOFlpVDJMTzBlUnRHbGxEL0Mw?=
 =?utf-8?B?TUlLK2FCYmV0VlNIQzd6cWNMdm5lckJCMFZNV01sZFF5c1ZhZ0dHWGkwWlBw?=
 =?utf-8?B?dUVwNVhReUJFRlJndDJHbEwrNFhGRHVBQ3NHRU1PODBUUVQ3M2R1RWd4V0tD?=
 =?utf-8?B?eXN1bVV5bkxPWHpKd1JyY0swZS9RUmE0eHJlcjNJZDA0b05HRVFKSmk1QitP?=
 =?utf-8?B?cTZqWjQ5Y2JNaFFGaTRrOTliWWh0Wm5FYms1YkRFOHU3YnVQTDJ0RzYrOTRC?=
 =?utf-8?B?SDFDT2tVbSthWkk1SWUrS1RpTmlwanQ3OUcrS1BWckxjRFJoaDJEeGdOd3Ev?=
 =?utf-8?B?WkpVUE5Ga2IrWlZZTU95djFHd25XcmlUNUMyK08yWmpOOTRFNGhpMFhaTnpB?=
 =?utf-8?B?WjRyemh4SlRaNUxyN1dRSUVHNEh1RTZKRFVnTjZ5Y3AzL1ZsYmtnVzczVGIw?=
 =?utf-8?B?bktRTldEN0lXcFk2bGlZekhLaWNmT3lwWXJpNjdDM2FZeHBENDI4OFAzNjRl?=
 =?utf-8?B?TE9nNGh6NEFDN1d1VVJia2hhejJwdGVvQVk0aVlwVDZjemRqUCt5alhKQTZD?=
 =?utf-8?B?ckk4bGpOOGl3WjRyWHFsV3BOSU50dy90OUNseU92VSsyeklsSjlQNE5EaWUx?=
 =?utf-8?B?d1lqK0pjSTh1b0hpV25EWmdZMFBYZjZYZXdrczJHa0xPWHc0V3RMOUNxVzRS?=
 =?utf-8?B?L2dpbGNFQ1NoM3gyT3ZidUV0c1o0c0pxWjZGUFdCUWVYUTlCdkNZL1NnV1Rj?=
 =?utf-8?B?V3c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f687670-eb3c-450c-7f22-08dad3f953e2
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2022 00:08:23.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: awARlw9YDT1G2qS659yQVfXZPUy5ihz9v6XtmyfQ9Z6JlNHCVxWr+5rafa+3smWv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR15MB4618
X-Proofpoint-GUID: Us8VDe54JvRJF056_Qdz1ahWX1Dheanq
X-Proofpoint-ORIG-GUID: Us8VDe54JvRJF056_Qdz1ahWX1Dheanq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-01_14,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/1/22 2:05 PM, Martin KaFai Lau wrote:
> On 12/1/22 9:47 AM, Yonghong Song wrote:
>>
>>
>> On 11/30/22 11:05 PM, Martin KaFai Lau wrote:
>>> On 11/28/22 6:37 PM, Yonghong Song wrote:
>>>> diff --git a/include/linux/bpf_verifier.h 
>>>> b/include/linux/bpf_verifier.h
>>>> index c05aa6e1f6f5..6f192dd9025e 100644
>>>> --- a/include/linux/bpf_verifier.h
>>>> +++ b/include/linux/bpf_verifier.h
>>>> @@ -683,7 +683,7 @@ static inline bool bpf_prog_check_recur(const 
>>>> struct bpf_prog *prog)
>>>>       }
>>>>   }
>>>> -#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | MEM_RCU | PTR_TRUSTED)
>>>> +#define BPF_REG_TRUSTED_MODIFIERS (MEM_ALLOC | PTR_TRUSTED)
>>>
>>> [ ... ]
>>>
>>>> +static bool is_rcu_reg(const struct bpf_reg_state *reg)
>>>> +{
>>>> +    return reg->type & MEM_RCU;
>>>> +}
>>>> +
>>>>   static int check_pkt_ptr_alignment(struct bpf_verifier_env *env,
>>>>                      const struct bpf_reg_state *reg,
>>>>                      int off, int size, bool strict)
>>>> @@ -4775,12 +4780,10 @@ static int check_ptr_to_btf_access(struct 
>>>> bpf_verifier_env *env,
>>>>           /* Mark value register as MEM_RCU only if it is protected by
>>>>            * bpf_rcu_read_lock() and the ptr reg is trusted. MEM_RCU
>>>>            * itself can already indicate trustedness inside the rcu
>>>> -         * read lock region. Also mark it as PTR_TRUSTED.
>>>> +         * read lock region.
>>>>            */
>>>>           if (!env->cur_state->active_rcu_lock || !is_trusted_reg(reg))
>>>>               flag &= ~MEM_RCU;
>>>
>>> How about dereferencing a PTR_TO_BTF_ID | MEM_RCU, like:
>>>
>>>      /* parent: PTR_TO_BTF_ID | MEM_RCU */
>>>      parent = current->real_parent;
>>>      /* gparent: PTR_TO_BTF_ID */
>>>      gparent = parent->real_parent;
>>>
>>> Should "gparent" have MEM_RCU also?
>>
>> Currently, no. We have logic in the code like
>>
>>          if (flag & MEM_RCU) {
>>                  /* Mark value register as MEM_RCU only if it is 
>> protected by
>>                   * bpf_rcu_read_lock() and the ptr reg is trusted. 
>> MEM_RCU
>>                   * itself can already indicate trustedness inside the 
>> rcu
>>                   * read lock region.
>>                   */
>>                  if (!env->cur_state->active_rcu_lock || 
>> !is_trusted_reg(reg))
>>                          flag &= ~MEM_RCU;
>>          }
>>
>> Since 'parent' is not trusted, so it will not be marked as MEM_RCU.
>> It can be marked as MEM_RCU if we do (based on the current patch)
> 
> or adding a is_rcu_trusted_reg() to consider both is_trusted_reg and 
> MEM_RCU before cleaning ~MEM_RCU here.  It seems the check_kfunc_args() 
> below will need a similar is_rcu_trusted_reg() test also.

Sounds good. Will do.

> 
>>
>>      parent = current->real_parent;
>>      parent2 = bpf_task_acquire_rcu(parent);
>>      if (!parent2) goto out;
>>      gparent = parent2->real_parent;
>>
>> Now gparent will be marked as MEM_RCU.
>>
>>>
>>> Also, should PTR_MAYBE_NULL be added to "parent"?
>>
>> I think we might need to do this. Although from kernel code,
>> task->real_parent, current->cgroups seem not NULL. But for sure
>> there are cases where the rcu ptr could be NULL. This might
>> be conservative for some cases, and if it is absolutely
>> performance critical, we later could tag related __rcu member
>> with btf_decl_tag to indicate its non-null status.
>>
>>>
>>>> -        else
>>>> -            flag |= PTR_TRUSTED;
>>>>       } else if (reg->type & MEM_RCU) {
>>>>           /* ptr (reg) is marked as MEM_RCU, but the struct field is 
>>>> not tagged
>>>>            * with __rcu. Mark the flag as PTR_UNTRUSTED conservatively.
>>>> @@ -5945,7 +5948,7 @@ static const struct bpf_reg_types 
>>>> btf_ptr_types = {
>>>>       .types = {
>>>>           PTR_TO_BTF_ID,
>>>>           PTR_TO_BTF_ID | PTR_TRUSTED,
>>>> -        PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED,
>>>> +        PTR_TO_BTF_ID | MEM_RCU,
>>>>       },
>>>>   };
>>>>   static const struct bpf_reg_types percpu_btf_ptr_types = {
>>>> @@ -6124,7 +6127,7 @@ int check_func_arg_reg_off(struct 
>>>> bpf_verifier_env *env,
>>>>       case PTR_TO_BTF_ID:
>>>>       case PTR_TO_BTF_ID | MEM_ALLOC:
>>>>       case PTR_TO_BTF_ID | PTR_TRUSTED:
>>>> -    case PTR_TO_BTF_ID | MEM_RCU | PTR_TRUSTED:
>>>> +    case PTR_TO_BTF_ID | MEM_RCU:
>>>>       case PTR_TO_BTF_ID | MEM_ALLOC | PTR_TRUSTED:
>>>>           /* When referenced PTR_TO_BTF_ID is passed to release 
>>>> function,
>>>>            * it's fixed offset must be 0.    In the other cases, 
>>>> fixed offset
>>>> @@ -8022,6 +8025,11 @@ static bool is_kfunc_destructive(struct 
>>>> bpf_kfunc_call_arg_meta *meta)
>>>>       return meta->kfunc_flags & KF_DESTRUCTIVE;
>>>>   }
>>>> +static bool is_kfunc_rcu(struct bpf_kfunc_call_arg_meta *meta)
>>>> +{
>>>> +    return meta->kfunc_flags & KF_RCU;
>>>> +}
>>>> +
>>>>   static bool is_kfunc_arg_kptr_get(struct bpf_kfunc_call_arg_meta 
>>>> *meta, int arg)
>>>>   {
>>>>       return arg == 0 && (meta->kfunc_flags & KF_KPTR_GET);
>>>> @@ -8706,13 +8714,19 @@ static int check_kfunc_args(struct 
>>>> bpf_verifier_env *env, struct bpf_kfunc_call_
>>>>           switch (kf_arg_type) {
>>>>           case KF_ARG_PTR_TO_ALLOC_BTF_ID:
>>>>           case KF_ARG_PTR_TO_BTF_ID:
>>>> -            if (!is_kfunc_trusted_args(meta))
>>>> +            if (!is_kfunc_trusted_args(meta) && !is_kfunc_rcu(meta))
>>>>                   break;
>>>> -            if (!is_trusted_reg(reg)) {
>>>> -                verbose(env, "R%d must be referenced or trusted\n", 
>>>> regno);
>>>> +            if (!is_trusted_reg(reg) && !is_rcu_reg(reg)) {
>>>> +                verbose(env, "R%d must be referenced, trusted or 
>>>> rcu\n", regno);
>>>>                   return -EINVAL;
>>>>               }
>>>> +
>>>> +            if (is_kfunc_rcu(meta) != is_rcu_reg(reg)) {
>>>
>>> I think is_trusted_reg(reg) should also be acceptable to 
>>> bpf_task_acquire_rcu().
>>
>> Yes, good point. trusted is a super set of rcu.
>>
>>>
>>> nit. bpf_task_acquire_not_zero() may be a better kfunc name.
>>
>> Will use this one.
> 

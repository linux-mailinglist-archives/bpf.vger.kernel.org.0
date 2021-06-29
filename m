Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 801CD3B6D04
	for <lists+bpf@lfdr.de>; Tue, 29 Jun 2021 05:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231856AbhF2Dfx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Jun 2021 23:35:53 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:37682 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231741AbhF2Dfx (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 28 Jun 2021 23:35:53 -0400
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 15T3U5TG006251;
        Mon, 28 Jun 2021 20:33:24 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=9lwMkNDjBNbIapPXiPf3OAcQ35FjSu4SsvspQbY0Sm0=;
 b=hhy7t7a4EtDonuZNbLEBZyYMkR53//fX6+qJ91ODwClh98hGZF1UuSq3k1fKUVDiptCG
 5ff40490B0Y1evqBESEzzWmdGKFQAhNL97Y3dQ1HxeGeYiT8mu8BOFaiXWJACuy4Nij+
 7OkbB+KHYYtLPZ6RJt6LUi2XpgZNRebpnOc= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 39embt2qys-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Mon, 28 Jun 2021 20:33:23 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.199) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Mon, 28 Jun 2021 20:33:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mA1Iq0KFI9cL0yt+8da57lALL3vyQ3qIJreg5xI/KzWK1qBv3z9fHy9DWLpEXcTk2aLt9ebVeqm2QRZRrw/6vSYZDjON8a086oSs9z0iYbxacR4ZJXqT2YGXhDSc//HjB/QfXq6+XXOiBlImfcZlJczKSE2Zy9YPxrZbk6YQ/wJ5erXvf8kq9mi3FsjoRXyFV163l/oeFY+mEtOhBvyl2zUPD/5EGCRPovYz7MeiadJlH9fpFRUmbmPekCAV2AgXI2MyB7nvOraaoFIy+agIUKs8YgCCnZcEedSBlV9rRx/0gOPzenP3swmfiF76EHZBTtboYU9P5tCoFaHBnIO1Eg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lwMkNDjBNbIapPXiPf3OAcQ35FjSu4SsvspQbY0Sm0=;
 b=GjYPCJW+1BiOM3W8cNyruHy3mMUiosfX1duCKEP2NiXDlwlrOyTrav8IKTekgkWjYrQr09PjcoibuZ19SOVU7bK2jfwtj/aauDKw4o6Fgi3RMC94b0UxPjuhnE4huAKipJ9D5OTF4RIWE/ogW8DmDiWgudAs3H+DiYR7LEi6ACj5T0H3rEKpN/3GoN/+5p8aYSkTfmuxVi/4qqcMV3BjRcqAQx3sF9Bh9jM+0nnDAp9Af4TkNH5YJhxyHQKaMHinFwYQVFxEHCUKGIe6x/4sQsCR4F4tFCzCfYV7dm0ZtQnrqx8NdZS/tgdZEl21lsWJwO4ZucQBDtvWkyBXYUkZzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SA0PR15MB3920.namprd15.prod.outlook.com (2603:10b6:806:82::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18; Tue, 29 Jun
 2021 03:33:15 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d886:b658:e2eb:a906%5]) with mapi id 15.20.4264.026; Tue, 29 Jun 2021
 03:33:15 +0000
Subject: Re: using skip>0 with bpf_get_stack()
To:     Eugene Loh <eugene.loh@oracle.com>, <bpf@vger.kernel.org>
References: <30a7b5d5-6726-1cc2-eaee-8da2828a9a9c@oracle.com>
 <c65ac449-ec54-3dff-5447-8a318001285b@fb.com>
 <1b59751f-0bb1-a4ad-6548-2536e60a80ec@oracle.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <4e2e5738-b103-d340-753e-7e37e06304c4@fb.com>
Date:   Mon, 28 Jun 2021 20:33:11 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
In-Reply-To: <1b59751f-0bb1-a4ad-6548-2536e60a80ec@oracle.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
X-Originating-IP: [2620:10d:c090:400::5:b3c6]
X-ClientProxiedBy: MWHPR20CA0028.namprd20.prod.outlook.com
 (2603:10b6:300:ed::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21d6::1a57] (2620:10d:c090:400::5:b3c6) by MWHPR20CA0028.namprd20.prod.outlook.com (2603:10b6:300:ed::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4264.18 via Frontend Transport; Tue, 29 Jun 2021 03:33:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 57359ec8-bf0c-4cac-91ec-08d93aaea0f9
X-MS-TrafficTypeDiagnostic: SA0PR15MB3920:
X-Microsoft-Antispam-PRVS: <SA0PR15MB39202A376622B2231968676BD3029@SA0PR15MB3920.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rUXNB9BXNTkrQ3ucsIu9NqphfwP74OGy5TWrOGG5M8OZv0S5jMXJrZYjgzF1hLk8vcNcDn5TIZv4F/f7AA2qHu59k0cq9i5hapDtInyS2k+oe9n+/GAhA0zcFyYDdD+sKpM0UKkC1cWCx6pqoh78IUbdefW8X4Z70Bu7olC+CcOmBPnvVsdcjuYyVb8mDPcA7zKaKYdiBXBfMi34Q4LgnhynljmqZcHNTJLzcz3Nn7JWxzQYqir2XVzuOzR1QFwYo/EwHsoHFs/1T79oY4VejnlM/NtL9zqFg5/d4lhpWZTwR/o57QQt6+ceQKy3dJJc3kU/A8j8YC1BHMMzcmeQz+jmJYuPtrfBBVnTRgLvaPITaNI83qkaXRw7s0dJyZL6ek80kR4G7RV+p20R60K1kXxJHwU8qWbqJw3VNm+Qx7pugnqIpE5cO9uQSqtEazFBeF+DDXmhXEhKibMY02TNV9uXFqJ+3fKZk5A0cAxL74kMnI7niP3BdJJANLEF/0niIshxpyAZXOElnyBAQx4f8HuLFRprqSa+7/GH+isttzMphFkI9wbalA0ltme407x4UiCRlg8nZD75qCWu9zPGUa+9+n5DEyhGQnHIJi0A0v6WhIKwt/sWcHqBW816fQbbZp+c1xU9zB92OTfYV4MCfxrLMLJ93UZnS/fXUxZuv9LOZBEYlB+sYiNFvcCnXZ0I1/nU5BfbdRllzpd50PpTlNd9h0FJNtk2Lmmnw8M5caH2OxFCyve3fG7gqqK+uSzNEdB/rnS5udYG0k9KgJvI/BkxejetsXPA+HWbgCK1PIIXMwarWDIRkcGpSAX8NuBjkDfIxgQLdmkk5l9nGfky3xOZSqjt4ELbAPEav6wEhak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(346002)(136003)(376002)(396003)(39860400002)(86362001)(966005)(52116002)(5660300002)(31696002)(316002)(6666004)(66476007)(66946007)(478600001)(53546011)(66556008)(2906002)(31686004)(16526019)(8936002)(186003)(8676002)(83380400001)(2616005)(6486002)(36756003)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDkxdFVSL0JOV1RVY2UxUFJwaEdac2tnMnA0SFVWdHhYTFErMEZlM0tVOXJz?=
 =?utf-8?B?SHlnRkNxbHNqbjhqNmhzUWR0YU5JY283V3NEa1pzeHlQYnZhYlpXZmtTRDRp?=
 =?utf-8?B?bHhPRmZ5SU14YmczUGJ4WWkvMGpNWWg2NkxiQ1NpNGpZS0FaSDZDeldNYVUx?=
 =?utf-8?B?WTB6UWliTEF2UEJpcXpQVzdxaGJubzBGdDVteExPTTRwYlkvazNFVXFQTlF0?=
 =?utf-8?B?Qmh4ZFF2aXloTkpIdHNKOS9UQXpTT3JUemJ4cGFIaGhRMGlFNWVOZUdpdjRX?=
 =?utf-8?B?QythL2x6dmR0MDBqa3FWdlBpcEZ0MWZZRXRuU0dncHp2QlZhR1JzMnMrZDE5?=
 =?utf-8?B?dlgrZUdHZ1BNenZucG9CRHFqQWxDSEI4TnNqY3JQK2ZrMURVMTBPZFVGcVIv?=
 =?utf-8?B?NnBQZFlzUE9DZUR4N1ZpUHFFV0d3dWFUYmtRLzkrVDFJTGltV3pzUkFkUE5Y?=
 =?utf-8?B?WUZ1VHg5alB3aERqRjFMeXBaVDRlbzJ6dEoyRnRjbk1nZkl1cG5lbXNyZGlH?=
 =?utf-8?B?UGo1OXNpK1MxSEJwVThPOEpPcVIrQVNwc2t4UmRER3BZdlRkTXFGRDlSM2RD?=
 =?utf-8?B?U3E2ZzlLSXZHdnNqQmtyN0tDb2kzcEZCUjdpRGxQNy9oWXMwaElXWVBKakhU?=
 =?utf-8?B?OVBMVmQwaWw2cmZPd0tUZ2NNZmtMaTN0emtQSjdPd2hxUnowVUVJazNnUHlu?=
 =?utf-8?B?RW9BRWY4R3pDa2NkRFBTNkovM1lNN3BCaFpyVW9zdkVDZE1ycHVSL3huUEVr?=
 =?utf-8?B?NmlFU1VOcDBmYzBpOVYzMXdiVml0bzNmemlNdnYyejlOK0ZRbmFIUW1BZUZv?=
 =?utf-8?B?eVRiZy8wTEtibEZVdXo1alF0Ynh4WEhHbFBKYTI5QlhNeEQ5ODU0Mm5CT2Jy?=
 =?utf-8?B?a0M0SXk4VkNGVzM3U3ZGTDEyM21YMldlZDhjM2tJaWs1YjlMYkFCSHYxNTFk?=
 =?utf-8?B?OXRyQnRpeVBNL29iRVlBd25KN1prSExQMGdyeng2SkVqV08zbm5lNWF0SWZx?=
 =?utf-8?B?US9oT0U2Mi95dHVHVzZBTjNvNWg4Z1djVWZUZ3dTdlpBNWlCS2s0RnBVdjhJ?=
 =?utf-8?B?TThyTGpvbEhNN3JTRXllMXYxSHorWFJ2WUY2bTl1YmJGNjAyOFVTOGRBNTF4?=
 =?utf-8?B?R3RCVUZORFVoUmJGU3JuQ3BqeGtRSWc3czhLMEUvd0VFb1RLZThCaDBJRHBJ?=
 =?utf-8?B?NDhmZS9URFd4VXorT3RRczlIOUVDWUM1SWpwS0NWNDczczROYURkclc0ZEpk?=
 =?utf-8?B?UjZhNHFUdU5hQ3AxeFZ2bW9TS3lhSkJSQ0orb0VES241cGZLOUdjeXR0QVRW?=
 =?utf-8?B?TmZ0Wml2SGdCeGFsZU03b1NsZVo4MnF2ODBBcURBNXRXV0FhNkZ3R0Y2cGto?=
 =?utf-8?B?dkJqSWZJUm14QkRLUWNUZ0ExR2JkY0hDSkxERkVTZ3IxdEZWYzlaMkU3dzg1?=
 =?utf-8?B?OW85ODlaV1czZXBPbG9BbEJuSFJVZEF4QlQ5SUpLV25KZ05IdzJ1bGljMGw2?=
 =?utf-8?B?SWZ4RjExYllDQ25Ld0E1Zm5oeitjZS95TjFzWGo3WmVCOWV2WWRnak5wZFRo?=
 =?utf-8?B?cUtlK2d6YjZ4NElkby8rQ2g1R3RudWdUZ3lEYnlpSnBtK3NMc25mYWVXazZS?=
 =?utf-8?B?MDA4T1JuUjlncSttanRzNFYxdyt4Tmx5bWdBTTlHRzhoNXgxeUFxeCtNN3lG?=
 =?utf-8?B?a3RLbTZ2MW9EYlNQWWFxTkZQSWR5UkJUeXBxcllkK2k5MHg2VytLa3Q2cnJZ?=
 =?utf-8?B?aVhaQWprNUw3TDVvTmZJa1Qvc0xvdFhVOXJqMnU1MEcvTGt3SVlJMFI4L0o4?=
 =?utf-8?B?ZUtYeWpiV1RBWUlYUnZmZz09?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 57359ec8-bf0c-4cac-91ec-08d93aaea0f9
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2021 03:33:15.0595
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivt+PPNYQzpaHGyURWwFrJ2oKSuv48bhw4TS5neZKrZI9tpQFqmT2/Tz+0xvy72U
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR15MB3920
X-OriginatorOrg: fb.com
X-Proofpoint-ORIG-GUID: 2bhBickigQKjCth688J-aHvxlilL_vYi
X-Proofpoint-GUID: 2bhBickigQKjCth688J-aHvxlilL_vYi
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.790
 definitions=2021-06-28_14:2021-06-25,2021-06-28 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 mlxscore=0 suspectscore=0
 impostorscore=0 spamscore=0 malwarescore=0 phishscore=0 adultscore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1015
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104190000 definitions=main-2106290024
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 6/25/21 6:22 PM, Eugene Loh wrote:
> 
> On 6/1/21 5:48 PM, Yonghong Song wrote:
>>
>>
>> On 5/28/21 3:16 PM, Eugene Loh wrote:
>>> I have a question about bpf_get_stack(). I'm interested in the case
>>>          skip > 0
>>>          user_build_id == 0
>>>          num_elem < sysctl_perf_event_max_stack
>>>
>>> The function sets
>>>          init_nr = sysctl_perf_event_max_stack - num_elem;
>>> which means that get_perf_callchain() will return "num_elem" stack 
>>> frames.  Then, since we skip "skip" frames, we'll fill the user 
>>> buffer with only "num_elem - skip" frames, the remaining frames being 
>>> filled zero.
>>>
>>> For example, let's say the call stack is
>>>          leaf <- caller <- foo1 <- foo2 <- foo3 <- foo4 <- foo5 <- foo6
>>>
>>> Let's say I pass bpf_get_stack() a buffer with num_elem==4 and ask 
>>> skip==2.  I would expect to skip 2 frames then get 4 frames, getting 
>>> back:
>>>          foo1  foo2  foo3  foo4
>>>
>>> Instead, I get
>>>          foo1  foo2  0  0
>>> skipping 2 frames but also leaving frames zeroed out.
>>
>> Thanks for reporting. I looked at codes and it does seem that we may
>> have a kernel bug when skip != 0. Basically as you described,
>> initially we collected num_elem stacks and later on we reduced by skip
>> so we got num_elem - skip as you calculated in the above.
>>
>>>
>>> I think the init_nr computation should be:
>>>
>>> -       if (sysctl_perf_event_max_stack < num_elem)
>>> +       if (sysctl_perf_event_max_stack <= num_elem + skip)
>>>                  init_nr = 0;
>>>          else
>>> -               init_nr = sysctl_perf_event_max_stack - num_elem;
>>> +               init_nr = sysctl_perf_event_max_stack - num_elem - skip;
>>
>> A rough check looks like this is one correct way to fix the issue.
>>
>>> Incidentally, the return value of the function is presumably the size 
>>> of the returned data.  Would it make sense to say so in 
>>> include/uapi/linux/bpf.h?
>>
>> The current documentation says:
>>  *      Return
>>  *              A non-negative value equal to or less than *size* on 
>> success,
>>  *              or a negative error in case of failure.
>>
>> I think you can improve with more precise description such that
>> a non-negative value for the copied **buf** length.
>>
>> Could you submit a patch for this? Thanks!
> 
> Sure.  Thanks for looking at this and sorry about the long delay getting 
> back to you.
> 
> Could you take a look at the attached, proposed patch?  As you see in 
> the commit message, I'm unclear about the bpf_get_stack*_pe() variants. 
> They might use an earlier construct callchain, and I do not know ho
> init_nr was set for them.

I think bpf_get_stackid() and __bpf_get_stackid() implementation is 
correct. Did you find any issues?

For bpf_get_stack_pe, see:
 
https://lore.kernel.org/bpf/20200723180648.1429892-2-songliubraving@fb.com/
I think you should not change bpf_get_stack() function.
__bpf_get_stack() is used by bpf_get_stack() and bpf_get_stack_pe().
In bpf_get_stack_pe(), callchain is fetched by perf event infrastructure
if event->attr.sample_type & __PERF_SAMPLE_CALLCHAIN_EARLY is true.

Just focus on __bpf_get_stack(). We could factor __bpf_get_stackid(),
but unless we have a bug, I didn't see it is necessary.

It will be good if you can add a test for the change, there is a 
stacktrace test prog_tests/stacktrace_map.c, you can take a look,
and you can add a subtest there.

Next time, you can submit a formal patch with `git send-email ...` to
this alias. This way it is easier to review compared to attachment.

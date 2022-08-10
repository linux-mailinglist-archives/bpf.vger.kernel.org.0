Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C14158F22D
	for <lists+bpf@lfdr.de>; Wed, 10 Aug 2022 20:12:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiHJSMJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 10 Aug 2022 14:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232088AbiHJSMH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 10 Aug 2022 14:12:07 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B100974CE3
        for <bpf@vger.kernel.org>; Wed, 10 Aug 2022 11:12:06 -0700 (PDT)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27AGuRHP003159;
        Wed, 10 Aug 2022 11:11:53 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=ZIfGmKOnV45jtcvlw4EpDBektZwDkXHrYM66gzfoZtc=;
 b=X1mtoSxsP0cWlOapn3G4c6oZ5d257FiZunFl9GHiGF1T5ci69IfqweGxO2h/K2mBJ7sB
 wGK/qi8SCV6rLW0QaXtTeg6LNKopKQXIpZOWYmWFMWyycI9MfKcxjv/W3NNKAFOVfQrD
 YZujdaDaa90A4enKXzvgcDLgjmJGf8zEhg0= 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2170.outbound.protection.outlook.com [104.47.56.170])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3hvdb6ajvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 10 Aug 2022 11:11:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO/0NK8KstGPVc6pgk1XLOCXJ/jmZIBW25yIqqo76hg/qPsaTUMDwCPul0Ej97HGGRQpOOTIaUWHEanYNIBzdQiIfROdgq+TZczdnpRdwaewpLqu/W54/tQ8dVicNne4rftmiy2S30DqS5H/3PpyjGNRAKQBTUsHhs7jficd1lqEW6mqd7F7njMG0aYtlF5nMsVS+l9vvUzCveDb8xMvccCyY+Dpk39YAXMSvarnju18c29R5YMRQSAoLSu8qz8Tg5enSTtJ/Ivgb2yRi7LsiuMF6hYQzUWVpt1/I6IiBuOO1G2nNNWmj2PvkdYdC7orHaG8onIFs0Yw+cswz28FKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZIfGmKOnV45jtcvlw4EpDBektZwDkXHrYM66gzfoZtc=;
 b=NYuk/S9HpJdGpaa7VE708kJQlVKgcs1dUISc/ZScj+Gqbvl207K1v0K0sk//2taTLRzS9KoLfhAMiJfRvZfQN23vkcB/HeCGsL2WaWTMLnARBq2bdBlo1uEnienhUVd9d+wxXRLh1yC9JHqSmxJIYSTUDch62V+zxNyzenoVg2dpcXmKPmAQO15T4Rwsng+Xn+W/da0WEvbDEdof9XmARB3gjvH0ZFkdMX9EVkcQ2vfkGPslocUBrRhaA+fCvQjoErANtcVIIaoIibgrUZhmok9t0CXoci8SaM+5LUHKYMeqkoLmUM4sD0sYHgszggCAEmVcOYfU8Y+wfG294waHDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
Received: from DM6PR15MB4039.namprd15.prod.outlook.com (2603:10b6:5:2b2::20)
 by MN2PR15MB4253.namprd15.prod.outlook.com (2603:10b6:208:3c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.21; Wed, 10 Aug
 2022 18:11:35 +0000
Received: from DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::8500:4ce4:51fb:6a8e]) by DM6PR15MB4039.namprd15.prod.outlook.com
 ([fe80::8500:4ce4:51fb:6a8e%7]) with mapi id 15.20.5525.011; Wed, 10 Aug 2022
 18:11:35 +0000
Message-ID: <de31d4e3-12e8-7cc5-1df8-571b738edb4a@fb.com>
Date:   Wed, 10 Aug 2022 14:11:33 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [RFC PATCH bpf-next 00/11] bpf: Introduce rbtree map
Content-Language: en-US
To:     Alexei Starovoitov <ast@fb.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>, Tejun Heo <tj@kernel.org>
References: <20220722183438.3319790-1-davemarchevsky@fb.com>
 <ce6163e4-bee8-3bee-d0f7-503648fb55cd@fb.com>
From:   Dave Marchevsky <davemarchevsky@fb.com>
In-Reply-To: <ce6163e4-bee8-3bee-d0f7-503648fb55cd@fb.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAP220CA0025.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:208:32c::30) To DM6PR15MB4039.namprd15.prod.outlook.com
 (2603:10b6:5:2b2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58526ec1-9ec9-45c7-692a-08da7afbc312
X-MS-TrafficTypeDiagnostic: MN2PR15MB4253:EE_
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kK4WTayN5gqIJ95gDv9+lZpEvZhYo0O2gNXHOhMdTP1mjBX119sCXFSKtwyb16XiQnQPUanekGa+QsbG4QKnXGeWRqL3P78rmE8a5QTifwmSfvfdD3PZvfBRgsmr5hQ7wIxrpRJ72qhnxH+KnKbLy6K1nLj1yfuEb5eT82QfPFf/5wTIohT1BRJ++JMXjfizIUJC/vAE+ByOX+GzGljaEpgsLvFF545RbU/KjpNbd7ujdH1tdCp0TszrynbcEJDcwHjRHlg8IXM4IYYRx/ro5Hc9mnYZ/gi2G4ZvMcIhlYNXPuM3Tw/dZvEPt265D1ajmMLN4n0BIpOfWwiWRBTYApnUBnobGr3dGYdiPB4Mw/nL6XRiimH5QB1ac1sP7Ru5N9cxQF0Ql8gbe4Prg1C8hpFcOcVjrVmmewEgbODFSkXJLGbs8oG70q5MqXT8gBjAVWcAasBcr6P7cXe2tuWE6+F2FIPVz57yrKPj2RAXUiR1eW1/g4gDf+DYlmG5W4x20f54h1fAtgYnFa1lXAvOFPDgwqxDCJdPD9ryJBPLa1p186vr9WYtfF/7hf9Y6w7EjPg3IWlqmQ0OZnxxW5AbdcJlow3p8sEtL9tSR/b83pjlTO0xp13E/FNgNWlErgACkaEPQouUAE6p7i5UWqEnDA6hymM6ck62jDxizjX/WX550lPlBfMqldmi5F2nWREcCPZfkRZbgDZLlFsAVpbq/oXL+s/Ju5gHD32b5eRa6jihyP/LOqWEJFM/dd0JobUWaQdb2dokUK3BL81wvBNkgsRaC2mITJlU0sIas7sPEYTReqkr+/w+B8fBzoOoIB321mS5i30RzImG3GxCXUFCmw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4039.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(396003)(366004)(346002)(39860400002)(376002)(66556008)(66946007)(66476007)(8676002)(4326008)(54906003)(8936002)(5660300002)(316002)(36756003)(2906002)(38100700002)(86362001)(31696002)(478600001)(6506007)(6512007)(41300700001)(6486002)(83380400001)(53546011)(186003)(2616005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NjdpMUFQaEhtSngvb2RsUXBrZVROa3pld0RRSHRFWXBRTTI3eGtEdCtiYkow?=
 =?utf-8?B?TUVkNmpieG1UdkR5UDJ5cTMxVklEeFNKc3FBVEpnZ0c2cTFVbVZ1L1V2NnRx?=
 =?utf-8?B?cGVjUWRudHBuWHlzMUJZYXVwT2FyRm9zNW1ZUEJaS21UcUYxZWdOcVNqNzRu?=
 =?utf-8?B?SzdwUE1mandScU5mYzIvbUNXNUpnTW1rMkFQdHJaRk9YZWVRRnBUQ3dnSzRl?=
 =?utf-8?B?YzF5OGFtcjFRV20wQXJQWjNSbytuc0RtSkpKSVdvYkphNlZ2V2FhaFlTOVVU?=
 =?utf-8?B?SS9ERk9jTGZ2YVVLTXgxWmRpQlBoL3VieVFyQSttL0lGOG44ajh1Wkt1b2lT?=
 =?utf-8?B?NkxXVHBzVit4NVJ0R050cTJack9aMVBFSnF6dVRsNm0yZDlvOW11MHpXTnBr?=
 =?utf-8?B?MTBLRmlaOVhJbURlMmE4cUF6b1JxUHJ3VHV3bk1tSXNZc0hKQXBxSUtBY1BD?=
 =?utf-8?B?L2h0QXp6cm9KSTJnQjUxS1E1TVNNRUxxSjg5ejlaREFUN0NqR293UlRWcTRS?=
 =?utf-8?B?VWdXcnRoVkdYcVVndnZWSFNJc3dYUDVJd1IvZkxsN1R5TXFzbWVpQU96bHVO?=
 =?utf-8?B?b3dtMHhZREZLTThaS3FzTG9vdUwzb2pxcGg3UG55ODI0bzl3WW5vWHBYd1RM?=
 =?utf-8?B?TXQ1ampoYU1OcS9iUHNLbUtYYkZJT1M4NUE4ci90Nmtta1l4SHo1TXoyeHUv?=
 =?utf-8?B?Qngza1o3QmY0N3ZNUkk5WUNIM1ZEMDhHS1AwYUtFdjlnNFlrT0l5N0NaYUxt?=
 =?utf-8?B?bzU5QXRITno1TWJhME1PWGZ1V2c0a1N0UHgrZUFQbGxBVExkYUZxdHhWbXZB?=
 =?utf-8?B?dlBMZHk3K042QmpjQzRYRjE5OU01THpabFNkZDVQQk1aYlNOd0RlOCtoUFBT?=
 =?utf-8?B?bnFjNldMSGVSSWlpWTdVaG9TTW8xOXFvWXFoZHUxbUZqMGZjTGtEeUhLNDdM?=
 =?utf-8?B?a3cxaXR4TDdQamFIQjk2TlhQZWQ5cmNJWUMvSDJlbEhoRlZjRHdRNUMybGxV?=
 =?utf-8?B?clF6Mk5IajdIb3NzNlBqcU5FWUJtcE8zQk12eGFrZlA2cjVYZi9kS1N4ZmEx?=
 =?utf-8?B?c0VoTTdDMmpOQ2h1QjJYeXFXdFc2S0EwakFCWGdtdXJhNUJ1SlhnWlBDRVdu?=
 =?utf-8?B?RllYbnltdWl0OHBlVDdYZ1ZlTnFheW5iY2ttOFNvMC9RUENKempROHY0c2do?=
 =?utf-8?B?c3Zncjc1RldldERZRDlqWW9oNThLRjRmNkxrZGFlTTNnVDk0ZlFaSHhuNlRi?=
 =?utf-8?B?NHF6cDZOYWhNVGFZcDZDT1V3QmwyVHNvSHZ4TUJ1enorZnlqYmU0ZlhQMUgw?=
 =?utf-8?B?ZGpGUVZqZW82T29oK2NURm9JN2QwenRwNFRsM1hNbXVHZnVJUGdSQzhOL1N5?=
 =?utf-8?B?eWNhaTBET0puRmwrS2lSd1EwSno0QytuWmR6L2ViU2pzTVdHRWFsU1kxRXRn?=
 =?utf-8?B?dHVrQ2QyeVNqdE43bUZFWURpMWVkQ0xYWk9TaVc2RVY1Uk9FZ09TbkIvSjNQ?=
 =?utf-8?B?dVh2d09NcHVHYUREaVMxc3crV1pjRFNRdVhuUW5OM1NkTktRTDBCb0hjRWkw?=
 =?utf-8?B?VFlkaW1FWlJnNE10WmNaMkVVbzlqQWtyU2RlRCtuNWR6S3YvOHhiRVVqN3dF?=
 =?utf-8?B?OUo2cGVYUEVTVlZDZktiMURBZDlDaE9vK2t2NHRmUVZsa1o4ZW9WTFdlRWM3?=
 =?utf-8?B?Rnp0cXpDbklYb3hGMGxwa0NETFdXSW5uT2ZySDI2T3ltV0hUbkYwZDBFYkt0?=
 =?utf-8?B?eVhUY0IwQi8zZXROQkRKTFBoN29nZFNFMVprTmh2dXRhajNSUEEzMVNQMUJU?=
 =?utf-8?B?Z25XajllNFZ0cnJsOUVXOWcrb0xvei9sU3JXL2ZkSTMvTEdsRWFKT1ZRcU9F?=
 =?utf-8?B?V2owbVZXTTVYaUowQVhyS3JiSUNZU0p2UVd2V2N6czZYR3JWaFlVbnExbS9Q?=
 =?utf-8?B?aGhFZTJGOTM2blpUNTVRMGFSRktxTnZER2pyVVFUVmw2SVFWUXVXVldvWUJD?=
 =?utf-8?B?N0FEL1NmV0xWVU9HblhHaFRCZHZKd3k2YkVwVTZoUkpPS0cyY0ZBMVVlZm1p?=
 =?utf-8?B?d0d6d2d1NmIwbUxXSEVJaG5jTHpmT0hGZUQ5Nk02UUQ0UlI1S0trUUpwVjlW?=
 =?utf-8?B?T0xoV1NSaU1BRUVuT3NXNGMwbTJYV3NVTERMN05wRU9jZmZiNDErT0cxN29D?=
 =?utf-8?Q?jsccuh4EulQsHmIZduI+YFs=3D?=
X-OriginatorOrg: fb.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58526ec1-9ec9-45c7-692a-08da7afbc312
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4039.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2022 18:11:35.5896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6VMvjf5PWLseE/VmQhkjKEWDcP/G9g0kNe1EdJJFnrChke96UEFzmIAsTTfSIwHD2MiBN4G9j2nWraOGEF65GA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR15MB4253
X-Proofpoint-ORIG-GUID: xcY_hrHkJ2YCIZ2Jsy0uTfL43P-FDwih
X-Proofpoint-GUID: xcY_hrHkJ2YCIZ2Jsy0uTfL43P-FDwih
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_12,2022-08-10_01,2022-06-22_01
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

On 8/1/22 5:27 PM, Alexei Starovoitov wrote:   
> On 7/22/22 11:34 AM, Dave Marchevsky wrote:
>> Introduce bpf_rbtree map data structure. As the name implies, rbtree map
>> allows bpf programs to use red-black trees similarly to kernel code.
>> Programs interact with rbtree maps in a much more open-coded way than
>> more classic map implementations. Some example code to demonstrate:
>>
>>    node = bpf_rbtree_alloc_node(&rbtree, sizeof(struct node_data));
>>    if (!node)
>>      return 0;
>>
>>    node->one = calls;
>>    node->two = 6;
>>    bpf_rbtree_lock(bpf_rbtree_get_lock(&rbtree));
>>
>>    ret = (struct node_data *)bpf_rbtree_add(&rbtree, node, less);
>>    if (!ret) {
>>      bpf_rbtree_free_node(&rbtree, node);
>>      goto unlock_ret;
>>    }
>>
>> unlock_ret:
>>    bpf_rbtree_unlock(bpf_rbtree_get_lock(&rbtree));
>>    return 0;
>>
>>
>> This series is in a heavy RFC state, with some added verifier semantics
>> needing improvement before they can be considered safe. I am sending
>> early to gather feedback on approach:
>>
>>    * Does the API seem reasonable and might it be useful for others?
> 
> Overall it seems to be on the right track.
> The two main issue to resolve are locks and iterators.
> The rest needs work too, but it's getting close :)
> Will reply in individual patches.

I generally agree with the comments on individual patches. We talked about the
whole series over VC quite a bit, I will summarize the larger points below.

* It's worth experimenting with statically verifying correct locking instead
of current dynamic approach where helpers that really shouldn't fail - e.g.
adding / removing from tree - can fail if lock isn't held. If it's possible
to get it working we can get rid of CONDITIONAL_RELEASE concept since failing
add operation is the only thing that needs it.

* You're not sold on the need for OBJ_NON_OWNING_REF flag in verifier, and
feel that it makes the API more confusing to work with. Worth experimenting
with a 'valid use-after-free' (really use-after-release here) concept that
doesn't require new type flag, or just accepting "racy, but safe".

* Open-coded iteration will take a long time to do correctly and
should be dropped for now.

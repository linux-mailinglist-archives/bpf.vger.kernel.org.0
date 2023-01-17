Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F01F666E316
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 17:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjAQQIR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 11:08:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjAQQIQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 11:08:16 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C968186A1
        for <bpf@vger.kernel.org>; Tue, 17 Jan 2023 08:08:13 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HFgxBf005109;
        Tue, 17 Jan 2023 08:07:56 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 from : subject : to : cc : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Dz8IXe6dIYdOQmob4cCjFLx7HT2oJKqYL+asgLMPyjM=;
 b=CqvQTMuCCfD67BjNNNlqwhnsNcM+ktZVkvPt44qOQE5LCS+wx66eHtRZL5skauNggLmC
 1R9VAlUHSXVHYruurn6hwlZeHo03De395dWjnJPWip6mSpTCEmu/VlU+KheTR2PYOuOv
 eMibz5Lqat/13VHh9+/lgSXj7lxGdmZJneL4spdfNNveKCef4zOb4A0W5FyJaerX8NLI
 YCz01Nb110eh0OMsPJSf/w3pjktLRv+3qxUCaRRXofgd+vf2OxzFq2YYmTtGnJ4n0Dmi
 cILas4VR5MxG132q0GqC6S3Rst1bGoDSYyr+qKnsHLkpxnAEuDxrLelZEft7LU/sStOa Aw== 
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2168.outbound.protection.outlook.com [104.47.73.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3n5jdx3qna-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 08:07:55 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fs4FSczpzQV34GAHv/BNL9vyXFemXKfd+Qzdl+W1Vq7ZH6RNbofNazKBhNVmF0dnTuvT9EjPNwENO37l0KvNi4QMNpNmDlCsqi7GG/8mqnU50V6cH+slUSklb+Ebf07jaEKqRt4wTANe86obFDHRKgeDIjc54VIzPAXvQ0AS42j36vfQB08xk7dlBgYP/AHHfLyDuHj9BhGx8rWDWmz+60laSniv8ao9ITI9sifQGkorW90ESYd/m2OfJpoAyOKr61UB/Q4QODvdmA3XaEDFvsN2E776vg31W3dXNaNYyy8PMs/OUmvi7Uv/+KSrzE1sEIeWtJKz0K//ZzwSYPjc8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dz8IXe6dIYdOQmob4cCjFLx7HT2oJKqYL+asgLMPyjM=;
 b=FKCm7p9LAWVCezzhG4VK0NlD71lyMFrSkkBZkaWJPaJvIr9YHYHHmc0I7SsZ0Xl56lLH1QN6FKppYVep9YuE1yQRD53mha/uZN6PK0BmlsQSp8rM6czxQxjM+gVbV0Zn/wAMLoquONq/PZqQOTtvKONOnllOMYNsEfcw5ICNk8rObzVitIB2Z+r2MYlI5dVVrcRxkn3FscMiCG45138se/GJIqgKMwtaaW92PaQfa+k7K4AXLHlPf4RKhL36B2RDb0Xyw6qjuupiS7VsrJV1PfTdeXrXPAJaU4D9//Q8Y/naOtmeSZeCepH05SrYFHbV2q9crAiyj45BctDmMhnjGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SA1PR15MB4433.namprd15.prod.outlook.com (2603:10b6:806:194::20)
 by PH0PR15MB4703.namprd15.prod.outlook.com (2603:10b6:510:8d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 16:07:52 +0000
Received: from SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::406a:f351:63a7:7a0c]) by SA1PR15MB4433.namprd15.prod.outlook.com
 ([fe80::406a:f351:63a7:7a0c%3]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 16:07:52 +0000
Message-ID: <9763aed7-0284-e400-b4dc-ed01718d8e1e@meta.com>
Date:   Tue, 17 Jan 2023 11:07:49 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
From:   Dave Marchevsky <davemarchevsky@meta.com>
Subject: Re: [PATCH v2 bpf-next 02/13] bpf: Migrate release_on_unlock logic to
 non-owning ref semantics
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Dave Marchevsky <davemarchevsky@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Tejun Heo <tj@kernel.org>
References: <20221217082506.1570898-1-davemarchevsky@fb.com>
 <20221217082506.1570898-3-davemarchevsky@fb.com>
 <20221229035600.m43ayhidfisbl4sq@MacBook-Pro-6.local>
Content-Language: en-US
In-Reply-To: <20221229035600.m43ayhidfisbl4sq@MacBook-Pro-6.local>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BLAPR03CA0132.namprd03.prod.outlook.com
 (2603:10b6:208:32e::17) To SA1PR15MB4433.namprd15.prod.outlook.com
 (2603:10b6:806:194::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR15MB4433:EE_|PH0PR15MB4703:EE_
X-MS-Office365-Filtering-Correlation-Id: e5e4536c-b265-46f3-50eb-08daf8a4fca4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4ia3Zhz2ZvZvyuf/OM/CzLq9kTThRmtkwAAXwSYpkEVXEIVxG49NJx0l79UsFbAhvhcUrjTyfdy2+oVjGAKXtgPqgvXyMvkClsaGQSOQbEaddqisUBJHJnHqbJJYXUPVnY1YAkmuRWTWLeGyb5PkFyLPnwCm2maV9ezZAhyGU7gDB0KEHUETMCNqcN9fyhsCY+FznjoY5KzmKlaQby/srF2LtiAbGBteFTNTI6oykr8rF0rWRTnlF2CDROP4p+jpkljhXRbjirv3cncV4Bm6/N6DJuOySg4LQXPVr3c5kq1zABsL1WO9IqTQjSmOJgQx3uE9LSDmNip4BybDOMPkZ3k1vO3BR+ey2fmsMXfY/w4JMG5XNhAI/uu61Bqk2MhmdhDGTicxEiy68VuZQ9Q2Fm+s9JdpE9vNvjeq4Q06GhiOxl/fStVdQVyLeR5cIvl7Xoo1Gi1NhXlJaVckjRkeZnXFX/CiGuHdf7z3pfKbDARzk1eKyBjld6AuiegCXLbkk7CtP6jLFIV1j4rGGEyooaKelOJIHgj4e025uB8wAh9cl1z3vMlbNLW7UoeZeEN4dtWMGtdWjFwPT+PVu5IBuMTRb1h5dKf0XeXBlc5wsUnSHAgQWtn/qkcnZ8ygszcWcfyKI2l7DQyTgoAHAQdQKg7rHrec8qjee/YR/F0Nic7FhIK0gnHZxFfuiSsk0TndcK5iW7kD6CLJdS5BeBAhjExNqPCanifSBtU6e5aMpJWUwQq9sEwv+7jDdm8KvJ6d/STspla0vnMRiSM+wQtKI1gfn63z/tTFMmm+Ru0XfmO6hAs7hPKYyme3cOfMn/a/LkYPT6ZGyVc8BadhUihhhQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR15MB4433.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(346002)(376002)(451199015)(31686004)(84970400001)(36756003)(86362001)(66946007)(8676002)(8936002)(31696002)(66556008)(4326008)(2906002)(30864003)(66476007)(5660300002)(83380400001)(38100700002)(316002)(110136005)(6486002)(54906003)(66899015)(6666004)(41300700001)(478600001)(53546011)(6512007)(2616005)(186003)(6506007)(43740500002)(45980500001)(309714004);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TzRPdmU0UUdmWVNML1pGM21WQTBrc284R2xrYVBuRkxYcEpDTU1sOE9DV3da?=
 =?utf-8?B?K08yT2NNY2lzampmV1E0LzRxWjlsZXVMcE5KRG8yeGs5eHVOSWJLRFRwTDVQ?=
 =?utf-8?B?ZXVoUEZIMUxVN3l5K1RCSVRJUWk5RXNtRjFHdkxaaC9paEhqZzZ3MjVvK2pJ?=
 =?utf-8?B?ckI1Y2pTaEMydmFxcThFUFpLQnI1U3o5Y2drVTVwSzN3SktSdGJOTkpwVEdw?=
 =?utf-8?B?ZnlBQ081Y29zQTI3cmgrb1ZmRnNHd3RUUEswa2RBNFF5WTU5TXR2dk02MVNY?=
 =?utf-8?B?TE42bjZ5M3dnN2JaWkthQ0plZnh4Qkx2aEx3QlhRRVQ2cFJVdGMvRnBQT0dB?=
 =?utf-8?B?b0xIWHYwOTFuTjFacTF3K0dWY00rdmtXamJweHNFUlBabklndW43RWsvcDRM?=
 =?utf-8?B?UXhKQTlhRlN4emY2TnhmMmZPekRRZGJ4c3Avbm1ZRFd3TkVmMW1hTlZKbStY?=
 =?utf-8?B?UlNudmZHS2tlY1c3TGM2OXlqaWNCOFAyUi9TenZrSHU1cmxPOEdVN0pCK2FW?=
 =?utf-8?B?NExaRU1kTVh3eWRyNUw3VTlhNmY4UVBoeHRSL0dQRVkyZ1ZSc2lkY0E1SHYv?=
 =?utf-8?B?bHBaenlOME4rOXF2ai9aNkJGb2ZzNWUram4zNFJpeGdaRkJMOFB2ekZQdjB1?=
 =?utf-8?B?WFk1eEtzMVVzNHRxNVlIVFpGYnJJVUljMVlsQ2U4ZWtVbjczQ1dySi8wUUxl?=
 =?utf-8?B?UmRFMm4ydURWSzBQaUthRUU2V0VWM1BLM2ExWlkwWmwzNzhyRkFaVGRXMHhh?=
 =?utf-8?B?T2FOTWlvUzdZbkVTZVVwMXl6emlMYzFyVmtwM3BPOWJwcXpMeUUwejlPQTFB?=
 =?utf-8?B?UGpxN1QyWVZPSm84aWRHMUJHZlhRZEI4VEkwT2RvY3ZOOGhETW1MVjl4L2xn?=
 =?utf-8?B?cGtnZ2F0WUFNWFA3bEt0LzFjTVVjODlZMlVrcUFYeElVMWJrN3dYL05rZnhR?=
 =?utf-8?B?TUx0bHFSQWozV0hPYkc4ZDNwZVhWQXRzTzhEbVRoWGtaa0thNlp5QWdPMjJJ?=
 =?utf-8?B?VTZOWmlNazFQZ25tVWlSRVBLLytaWUVRdXd1RHNzeUQwdDN6R0RoTkh3MTZk?=
 =?utf-8?B?ak5mN2RqeUx4Ky8rVm9KeU1XKzBLVE9YQkNjZ2VBdWc2UXorY0ZPekNjWWsw?=
 =?utf-8?B?OFdXZXZLZGhKNjNHbjdDYUNDOGtPWnVIYW9aQlovejZaVnNLeEw3Q0tBWUJM?=
 =?utf-8?B?SWFPd2k0N1BqNm00SnRSMW5jQ2s5QWpMbDZmVWoxWXRJYWdITnJhR2dsdjd2?=
 =?utf-8?B?Y3Q5ajM5L0pjeGQ1dDd0VWJqeVhadExwb0tRM1NCSTVUaFNabWRJZWhyMXN4?=
 =?utf-8?B?NzFvQWlYdGRuREloM1pTL3FWNDNHOTEzbm1wd0JJaWJCaFJBS3ZJVTYvRnhJ?=
 =?utf-8?B?WTRVRTlJTE5zWHM1bGdQdExJazZ2dlVtQlo2aTRDYjRYd2J4dk5UalM5aVgv?=
 =?utf-8?B?SWh2Rjd0RGdiTTNobTZYek9DQU9DNGoxVkVxcEFEY20xUlNCb0poSkZra1pz?=
 =?utf-8?B?WGp6My9vU256YStnUlVxaGRsTmsvOFRWdmYwLzdnV25rS3ZFTnA0TGw2UDJJ?=
 =?utf-8?B?SEJ0cTJzTnAzZUx0OEdocklJMERob0JuT2dYbG1qem5qTUFZSEJCWUM3Mjdm?=
 =?utf-8?B?c1Y2dXdOeUlKNW9hUEVKVkZ4dzRaQzh5SjI4YjlhTlMvNEJCWlIyOS9lZjJJ?=
 =?utf-8?B?dTVYelVIak5IaE9UZTlxZTRYV2QrMVpyVk5IcExpZW4xYjQ0M3hXcDQ5anhW?=
 =?utf-8?B?YS8xS2ZnYTV6ckJLajBPTVM4STVXcS8zdFhTeDVxVWFKT1RXQXlnc1V0cG5R?=
 =?utf-8?B?MG01dnRMZGV2Rk5ZTnhFNWdWV3pLSHpFSVJSYjVJRmNITUhFK1dPTDB5ejNC?=
 =?utf-8?B?MSsxSUxlU1o1UkZhcld3M1lIeFRtWlJkRUc5c09mNHQ3dGRZTnE3WUJTQ3NG?=
 =?utf-8?B?bWtVNFdIdFFMc0FSbVdYNjhUQlgzVll1V0FROVdtZHdvU3pqcXlOdEg2L1M1?=
 =?utf-8?B?eWVEMDJIQUFZTmNtQVNtVHVkMk5LcUFGOEhjT2NLQ1YzdHNDV3Q2M1U4TFZx?=
 =?utf-8?B?ZExsNFpTdUI3UWdKbi8za0xMaTViUUlLVGNkU0dsam5VYTV6NXl6WU1JSm9U?=
 =?utf-8?B?aFhaeWFrVzFzclpDTC9TYjZYK0RZM2lYYm1WUURDT3h4Y2tEUStvTENxSys1?=
 =?utf-8?Q?bkJAbSelHa/nQOXURAnGpFE=3D?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5e4536c-b265-46f3-50eb-08daf8a4fca4
X-MS-Exchange-CrossTenant-AuthSource: SA1PR15MB4433.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 16:07:52.5485
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /QFlYsvAXIQZXAJPjlwkadjOac50rJAKws/jV/Ov+behPyAIUZyRwEbhDpI5MgwwATAkvop6GyVkHK2+QWSrhA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR15MB4703
X-Proofpoint-ORIG-GUID: me4RLPu3AvuCmf-wPbYoxACsFdwwmBLI
X-Proofpoint-GUID: me4RLPu3AvuCmf-wPbYoxACsFdwwmBLI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_07,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 12/28/22 10:56 PM, Alexei Starovoitov wrote:
> On Sat, Dec 17, 2022 at 12:24:55AM -0800, Dave Marchevsky wrote:
>> This patch introduces non-owning reference semantics to the verifier,
>> specifically linked_list API kfunc handling. release_on_unlock logic for
>> refs is refactored - with small functional changes - to implement these
>> semantics, and bpf_list_push_{front,back} are migrated to use them.
>>
>> When a list node is pushed to a list, the program still has a pointer to
>> the node:
>>
>>   n = bpf_obj_new(typeof(*n));
>>
>>   bpf_spin_lock(&l);
>>   bpf_list_push_back(&l, n);
>>   /* n still points to the just-added node */
>>   bpf_spin_unlock(&l);
>>
>> What the verifier considers n to be after the push, and thus what can be
>> done with n, are changed by this patch.
>>
>> Common properties both before/after this patch:
>>   * After push, n is only a valid reference to the node until end of
>>     critical section
>>   * After push, n cannot be pushed to any list
>>   * After push, the program can read the node's fields using n
> 
> correct.
> 
>> Before:
>>   * After push, n retains the ref_obj_id which it received on
>>     bpf_obj_new, but the associated bpf_reference_state's
>>     release_on_unlock field is set to true
>>     * release_on_unlock field and associated logic is used to implement
>>       "n is only a valid ref until end of critical section"
>>   * After push, n cannot be written to, the node must be removed from
>>     the list before writing to its fields
>>   * After push, n is marked PTR_UNTRUSTED
> 
> yep
> 
>> After:
>>   * After push, n's ref is released and ref_obj_id set to 0. The
>>     bpf_reg_state's non_owning_ref_lock struct is populated with the
>>     currently active lock
>>     * non_owning_ref_lock and logic is used to implement "n is only a
>>       valid ref until end of critical section"
>>   * n can be written to (except for special fields e.g. bpf_list_node,
>>     timer, ...)
>>   * No special type flag is added to n after push
> 
> yep.
> Great summary.
> 
>> Summary of specific implementation changes to achieve the above:
>>
>>   * release_on_unlock field, ref_set_release_on_unlock helper, and logic
>>     to "release on unlock" based on that field are removed
> 
> +1 
> 
>>   * The anonymous active_lock struct used by bpf_verifier_state is
>>     pulled out into a named struct bpf_active_lock.
> ...
>>   * A non_owning_ref_lock field of type bpf_active_lock is added to
>>     bpf_reg_state's PTR_TO_BTF_ID union
> 
> not great. see below.
> 
>>   * Helpers are added to use non_owning_ref_lock to implement non-owning
>>     ref semantics as described above
>>     * invalidate_non_owning_refs - helper to clobber all non-owning refs
>>       matching a particular bpf_active_lock identity. Replaces
>>       release_on_unlock logic in process_spin_lock.
> 
> +1
> 
>>     * ref_set_non_owning_lock - set non_owning_ref_lock for a reg based
>>       on current verifier state
> 
> +1
> 
>>     * ref_convert_owning_non_owning - convert owning reference w/
>>       specified ref_obj_id to non-owning references. Setup
>>       non_owning_ref_lock for each reg with that ref_obj_id and 0 out
>>       its ref_obj_id
> 
> +1
> 
>>   * New KF_RELEASE_NON_OWN flag is added, to be used in conjunction with
>>     KF_RELEASE to indicate that the release arg reg should be converted
>>     to non-owning ref
>>     * Plain KF_RELEASE would clobber all regs with ref_obj_id matching
>>       the release arg reg's. KF_RELEASE_NON_OWN's logic triggers first -
>>       doing ref_convert_owning_non_owning on the ref first, which
>>       prevents the regs from being clobbered by 0ing out their
>>       ref_obj_ids. The bpf_reference_state itself is still released via
>>       release_reference as a result of the KF_RELEASE flag.
>>     * KF_RELEASE | KF_RELEASE_NON_OWN are added to
>>       bpf_list_push_{front,back}
> 
> And this bit is confusing and not generalizable.
> As David noticed in his reply KF_RELEASE_NON_OWN is not a great name.
> It's hard to come up with a good name and it won't be generic anyway.
> The ref_convert_owning_non_owning has to be applied to a specific arg.
> The function itself is not KF_RELEASE in the current definition of it.
> The combination of KF_RELEASE|KF_RELEASE_NON_OWN is something new
> that should have been generic, but doesn't really work this way.
> In the next patches rbtree_root/node still has to have all the custom
> logic.
> KF_RELEASE_NON_OWN by itself is a nonsensical flag.
> Only combination of KF_RELEASE|KF_RELEASE_NON_OWN sort-of kinda makes
> sense, but still hard to understand what releases what.
> More below.
> 

Addressed below (in response to your 'here we come to the main point'
comment).

>> After these changes, linked_list's "release on unlock" logic continues
>> to function as before, except for the semantic differences noted above.
>> The patch immediately following this one makes minor changes to
>> linked_list selftests to account for the differing behavior.
>>
>> Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
>> ---
>>  include/linux/bpf.h          |   1 +
>>  include/linux/bpf_verifier.h |  39 ++++-----
>>  include/linux/btf.h          |  17 ++--
>>  kernel/bpf/helpers.c         |   4 +-
>>  kernel/bpf/verifier.c        | 164 ++++++++++++++++++++++++-----------
>>  5 files changed, 146 insertions(+), 79 deletions(-)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 3de24cfb7a3d..f71571bf6adc 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -180,6 +180,7 @@ enum btf_field_type {
>>  	BPF_KPTR       = BPF_KPTR_UNREF | BPF_KPTR_REF,
>>  	BPF_LIST_HEAD  = (1 << 4),
>>  	BPF_LIST_NODE  = (1 << 5),
>> +	BPF_GRAPH_NODE_OR_ROOT = BPF_LIST_NODE | BPF_LIST_HEAD,
>>  };
>>  
>>  struct btf_field_kptr {
>> diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
>> index 53d175cbaa02..cb417ffbbb84 100644
>> --- a/include/linux/bpf_verifier.h
>> +++ b/include/linux/bpf_verifier.h
>> @@ -43,6 +43,22 @@ enum bpf_reg_liveness {
>>  	REG_LIVE_DONE = 0x8, /* liveness won't be updating this register anymore */
>>  };
>>  
>> +/* For every reg representing a map value or allocated object pointer,
>> + * we consider the tuple of (ptr, id) for them to be unique in verifier
>> + * context and conside them to not alias each other for the purposes of
>> + * tracking lock state.
>> + */
>> +struct bpf_active_lock {
>> +	/* This can either be reg->map_ptr or reg->btf. If ptr is NULL,
>> +	 * there's no active lock held, and other fields have no
>> +	 * meaning. If non-NULL, it indicates that a lock is held and
>> +	 * id member has the reg->id of the register which can be >= 0.
>> +	 */
>> +	void *ptr;
>> +	/* This will be reg->id */
>> +	u32 id;
>> +};
>> +
>>  struct bpf_reg_state {
>>  	/* Ordering of fields matters.  See states_equal() */
>>  	enum bpf_reg_type type;
>> @@ -68,6 +84,7 @@ struct bpf_reg_state {
>>  		struct {
>>  			struct btf *btf;
>>  			u32 btf_id;
>> +			struct bpf_active_lock non_owning_ref_lock;
> 
> In your other email you argue that pointer should be enough.
> I suspect that won't be correct.
> See fixes that Andrii did in states_equal() and regsafe().
> In particular:
>         if (!!old->active_lock.id != !!cur->active_lock.id)
>                 return false;
> 
>         if (old->active_lock.id &&
>             !check_ids(old->active_lock.id, cur->active_lock.id, env->idmap_scratch))
>                 return false;
> 
> We have to do the comparison of this new ID via idmap as well.
> 
> I think introduction of struct bpf_active_lock  and addition of it
> to bpf_reg_state is overkill.
> Here we can add 'u32 non_own_ref_obj_id;' only and compare it via idmap in regsafe().
> I'm guessing you didn't like my 'active_lock_id' suggestion. Fine.
> non_own_ref_obj_id would match existing ref_obj_id at least.
> 
>>  		};
>>  
>>  		u32 mem_size; /* for PTR_TO_MEM | PTR_TO_MEM_OR_NULL */
>> @@ -223,11 +240,6 @@ struct bpf_reference_state {
>>  	 * exiting a callback function.
>>  	 */
>>  	int callback_ref;
>> -	/* Mark the reference state to release the registers sharing the same id
>> -	 * on bpf_spin_unlock (for nodes that we will lose ownership to but are
>> -	 * safe to access inside the critical section).
>> -	 */
>> -	bool release_on_unlock;
>>  };
>>  
>>  /* state of the program:
>> @@ -328,21 +340,8 @@ struct bpf_verifier_state {
>>  	u32 branches;
>>  	u32 insn_idx;
>>  	u32 curframe;
>> -	/* For every reg representing a map value or allocated object pointer,
>> -	 * we consider the tuple of (ptr, id) for them to be unique in verifier
>> -	 * context and conside them to not alias each other for the purposes of
>> -	 * tracking lock state.
>> -	 */
>> -	struct {
>> -		/* This can either be reg->map_ptr or reg->btf. If ptr is NULL,
>> -		 * there's no active lock held, and other fields have no
>> -		 * meaning. If non-NULL, it indicates that a lock is held and
>> -		 * id member has the reg->id of the register which can be >= 0.
>> -		 */
>> -		void *ptr;
>> -		/* This will be reg->id */
>> -		u32 id;
>> -	} active_lock;
> 
> I would keep it as-is.
> 
>> +
>> +	struct bpf_active_lock active_lock;
>>  	bool speculative;
>>  	bool active_rcu_lock;
>>  
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index 5f628f323442..8aee3f7f4248 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -15,10 +15,10 @@
>>  #define BTF_TYPE_EMIT_ENUM(enum_val) ((void)enum_val)
>>  
>>  /* These need to be macros, as the expressions are used in assembler input */
>> -#define KF_ACQUIRE	(1 << 0) /* kfunc is an acquire function */
>> -#define KF_RELEASE	(1 << 1) /* kfunc is a release function */
>> -#define KF_RET_NULL	(1 << 2) /* kfunc returns a pointer that may be NULL */
>> -#define KF_KPTR_GET	(1 << 3) /* kfunc returns reference to a kptr */
>> +#define KF_ACQUIRE		(1 << 0) /* kfunc is an acquire function */
>> +#define KF_RELEASE		(1 << 1) /* kfunc is a release function */
>> +#define KF_RET_NULL		(1 << 2) /* kfunc returns a pointer that may be NULL */
>> +#define KF_KPTR_GET		(1 << 3) /* kfunc returns reference to a kptr */
>>  /* Trusted arguments are those which are guaranteed to be valid when passed to
>>   * the kfunc. It is used to enforce that pointers obtained from either acquire
>>   * kfuncs, or from the main kernel on a tracepoint or struct_ops callback
>> @@ -67,10 +67,11 @@
>>   *	return 0;
>>   * }
>>   */
>> -#define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer arguments */
>> -#define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
>> -#define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive actions */
>> -#define KF_RCU          (1 << 7) /* kfunc only takes rcu pointer arguments */
>> +#define KF_TRUSTED_ARGS	(1 << 4) /* kfunc only takes trusted pointer arguments */
>> +#define KF_SLEEPABLE		(1 << 5) /* kfunc may sleep */
>> +#define KF_DESTRUCTIVE		(1 << 6) /* kfunc performs destructive actions */
>> +#define KF_RCU			(1 << 7) /* kfunc only takes rcu pointer arguments */
>> +#define KF_RELEASE_NON_OWN	(1 << 8) /* kfunc converts its referenced arg into non-owning ref */
> 
> No need for this flag.
> 

Addressed below (in re: your 'here we come to the main point' comment)

>>  /*
>>   * Return the name of the passed struct, if exists, or halt the build if for
>> diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
>> index af30c6cbd65d..e041409779c3 100644
>> --- a/kernel/bpf/helpers.c
>> +++ b/kernel/bpf/helpers.c
>> @@ -2049,8 +2049,8 @@ BTF_ID_FLAGS(func, crash_kexec, KF_DESTRUCTIVE)
>>  #endif
>>  BTF_ID_FLAGS(func, bpf_obj_new_impl, KF_ACQUIRE | KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_obj_drop_impl, KF_RELEASE)
>> -BTF_ID_FLAGS(func, bpf_list_push_front)
>> -BTF_ID_FLAGS(func, bpf_list_push_back)
>> +BTF_ID_FLAGS(func, bpf_list_push_front, KF_RELEASE | KF_RELEASE_NON_OWN)
>> +BTF_ID_FLAGS(func, bpf_list_push_back, KF_RELEASE | KF_RELEASE_NON_OWN)
> 
> No need for this.
> 

Addressed below (in re: your 'here we come to the main point' comment)

>>  BTF_ID_FLAGS(func, bpf_list_pop_front, KF_ACQUIRE | KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_list_pop_back, KF_ACQUIRE | KF_RET_NULL)
>>  BTF_ID_FLAGS(func, bpf_task_acquire, KF_ACQUIRE | KF_TRUSTED_ARGS)
>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>> index 824e2242eae5..84b0660e2a76 100644
>> --- a/kernel/bpf/verifier.c
>> +++ b/kernel/bpf/verifier.c
>> @@ -190,6 +190,10 @@ struct bpf_verifier_stack_elem {
>>  
>>  static int acquire_reference_state(struct bpf_verifier_env *env, int insn_idx);
>>  static int release_reference(struct bpf_verifier_env *env, int ref_obj_id);
>> +static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
>> +				       struct bpf_active_lock *lock);
>> +static int ref_set_non_owning_lock(struct bpf_verifier_env *env,
>> +				   struct bpf_reg_state *reg);
>>  
>>  static bool bpf_map_ptr_poisoned(const struct bpf_insn_aux_data *aux)
>>  {
>> @@ -931,6 +935,9 @@ static void print_verifier_state(struct bpf_verifier_env *env,
>>  				verbose_a("id=%d", reg->id);
>>  			if (reg->ref_obj_id)
>>  				verbose_a("ref_obj_id=%d", reg->ref_obj_id);
>> +			if (reg->non_owning_ref_lock.ptr)
>> +				verbose_a("non_own_id=(%p,%d)", reg->non_owning_ref_lock.ptr,
>> +					  reg->non_owning_ref_lock.id);
>>  			if (t != SCALAR_VALUE)
>>  				verbose_a("off=%d", reg->off);
>>  			if (type_is_pkt_pointer(t))
>> @@ -4820,7 +4827,8 @@ static int check_ptr_to_btf_access(struct bpf_verifier_env *env,
>>  			return -EACCES;
>>  		}
>>  
>> -		if (type_is_alloc(reg->type) && !reg->ref_obj_id) {
>> +		if (type_is_alloc(reg->type) && !reg->ref_obj_id &&
>> +		    !reg->non_owning_ref_lock.ptr) {
>>  			verbose(env, "verifier internal error: ref_obj_id for allocated object must be non-zero\n");
>>  			return -EFAULT;
>>  		}
>> @@ -5778,9 +5786,7 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
>>  			cur->active_lock.ptr = btf;
>>  		cur->active_lock.id = reg->id;
>>  	} else {
>> -		struct bpf_func_state *fstate = cur_func(env);
>>  		void *ptr;
>> -		int i;
>>  
>>  		if (map)
>>  			ptr = map;
>> @@ -5796,25 +5802,11 @@ static int process_spin_lock(struct bpf_verifier_env *env, int regno,
>>  			verbose(env, "bpf_spin_unlock of different lock\n");
>>  			return -EINVAL;
>>  		}
>> -		cur->active_lock.ptr = NULL;
>> -		cur->active_lock.id = 0;
>>  
>> -		for (i = fstate->acquired_refs - 1; i >= 0; i--) {
>> -			int err;
>> +		invalidate_non_owning_refs(env, &cur->active_lock);
> 
> +1
> 
>> -			/* Complain on error because this reference state cannot
>> -			 * be freed before this point, as bpf_spin_lock critical
>> -			 * section does not allow functions that release the
>> -			 * allocated object immediately.
>> -			 */
>> -			if (!fstate->refs[i].release_on_unlock)
>> -				continue;
>> -			err = release_reference(env, fstate->refs[i].id);
>> -			if (err) {
>> -				verbose(env, "failed to release release_on_unlock reference");
>> -				return err;
>> -			}
>> -		}
>> +		cur->active_lock.ptr = NULL;
>> +		cur->active_lock.id = 0;
> 
> +1
> 
>>  	}
>>  	return 0;
>>  }
>> @@ -6273,6 +6265,23 @@ static int check_reg_type(struct bpf_verifier_env *env, u32 regno,
>>  	return 0;
>>  }
>>  
>> +static struct btf_field *
>> +reg_find_field_offset(const struct bpf_reg_state *reg, s32 off, u32 fields)
>> +{
>> +	struct btf_field *field;
>> +	struct btf_record *rec;
>> +
>> +	rec = reg_btf_record(reg);
>> +	if (!reg)
>> +		return NULL;
>> +
>> +	field = btf_record_find(rec, off, fields);
>> +	if (!field)
>> +		return NULL;
>> +
>> +	return field;
>> +}
> 
> Doesn't look like that this helper is really necessary.
> 

The helper is used in other places in the series. It saves some boilerplate
since usually when reg's btf_record is fetched it's just to look for the 
presence of some field.

If all uses of the helper in this patch are removed, I will move the def to
first patch where it's used when I respin.

>> +
>>  int check_func_arg_reg_off(struct bpf_verifier_env *env,
>>  			   const struct bpf_reg_state *reg, int regno,
>>  			   enum bpf_arg_type arg_type)
>> @@ -6294,6 +6303,18 @@ int check_func_arg_reg_off(struct bpf_verifier_env *env,
>>  		 */
>>  		if (arg_type_is_dynptr(arg_type) && type == PTR_TO_STACK)
>>  			return 0;
>> +
>> +		if (type == (PTR_TO_BTF_ID | MEM_ALLOC) && reg->off) {
>> +			if (reg_find_field_offset(reg, reg->off, BPF_GRAPH_NODE_OR_ROOT))
>> +				return __check_ptr_off_reg(env, reg, regno, true);
>> +
>> +			verbose(env, "R%d must have zero offset when passed to release func\n",
>> +				regno);
>> +			verbose(env, "No graph node or root found at R%d type:%s off:%d\n", regno,
>> +				kernel_type_name(reg->btf, reg->btf_id), reg->off);
>> +			return -EINVAL;
>> +		}
> 
> This bit is only necessary if we mark push_list as KF_RELEASE.
> Just don't add this mark and drop above.
> 

Addressed below (in re: your 'here we come to the main point' comment)

>> +
>>  		/* Doing check_ptr_off_reg check for the offset will catch this
>>  		 * because fixed_off_ok is false, but checking here allows us
>>  		 * to give the user a better error message.
>> @@ -7055,6 +7076,20 @@ static int release_reference(struct bpf_verifier_env *env,
>>  	return 0;
>>  }
>>  
>> +static void invalidate_non_owning_refs(struct bpf_verifier_env *env,
>> +				       struct bpf_active_lock *lock)
>> +{
>> +	struct bpf_func_state *unused;
>> +	struct bpf_reg_state *reg;
>> +
>> +	bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
>> +		if (reg->non_owning_ref_lock.ptr &&
>> +		    reg->non_owning_ref_lock.ptr == lock->ptr &&
>> +		    reg->non_owning_ref_lock.id == lock->id)
> 
> I think the lock.ptr = lock->ptr comparison is unnecessary to invalidate things.
> We're under active spin_lock here. All regs were checked earlier and id keeps incrementing.
> So we can just do 'u32 non_own_ref_obj_id'.
> 
>> +			__mark_reg_unknown(env, reg);
>> +	}));
>> +}
>> +
>>  static void clear_caller_saved_regs(struct bpf_verifier_env *env,
>>  				    struct bpf_reg_state *regs)
>>  {
>> @@ -8266,6 +8301,11 @@ static bool is_kfunc_release(struct bpf_kfunc_call_arg_meta *meta)
>>  	return meta->kfunc_flags & KF_RELEASE;
>>  }
>>  
>> +static bool is_kfunc_release_non_own(struct bpf_kfunc_call_arg_meta *meta)
>> +{
>> +	return meta->kfunc_flags & KF_RELEASE_NON_OWN;
>> +}
>> +
> 
> No need.
> 

Addressed below (in re: your 'here we come to the main point' comment)

>>  static bool is_kfunc_trusted_args(struct bpf_kfunc_call_arg_meta *meta)
>>  {
>>  	return meta->kfunc_flags & KF_TRUSTED_ARGS;
>> @@ -8651,38 +8691,55 @@ static int process_kf_arg_ptr_to_kptr(struct bpf_verifier_env *env,
>>  	return 0;
>>  }
>>  
>> -static int ref_set_release_on_unlock(struct bpf_verifier_env *env, u32 ref_obj_id)
>> +static int ref_set_non_owning_lock(struct bpf_verifier_env *env, struct bpf_reg_state *reg)
>>  {
>> -	struct bpf_func_state *state = cur_func(env);
>> +	struct bpf_verifier_state *state = env->cur_state;
>> +
>> +	if (!state->active_lock.ptr) {
>> +		verbose(env, "verifier internal error: ref_set_non_owning_lock w/o active lock\n");
>> +		return -EFAULT;
>> +	}
>> +
>> +	if (reg->non_owning_ref_lock.ptr) {
>> +		verbose(env, "verifier internal error: non_owning_ref_lock already set\n");
>> +		return -EFAULT;
>> +	}
>> +
>> +	reg->non_owning_ref_lock.id = state->active_lock.id;
>> +	reg->non_owning_ref_lock.ptr = state->active_lock.ptr;
>> +	return 0;
>> +}
>> +
>> +static int ref_convert_owning_non_owning(struct bpf_verifier_env *env, u32 ref_obj_id)
>> +{
>> +	struct bpf_func_state *state, *unused;
>>  	struct bpf_reg_state *reg;
>>  	int i;
>>  
>> -	/* bpf_spin_lock only allows calling list_push and list_pop, no BPF
>> -	 * subprogs, no global functions. This means that the references would
>> -	 * not be released inside the critical section but they may be added to
>> -	 * the reference state, and the acquired_refs are never copied out for a
>> -	 * different frame as BPF to BPF calls don't work in bpf_spin_lock
>> -	 * critical sections.
>> -	 */
>> +	state = cur_func(env);
>> +
>>  	if (!ref_obj_id) {
>> -		verbose(env, "verifier internal error: ref_obj_id is zero for release_on_unlock\n");
>> +		verbose(env, "verifier internal error: ref_obj_id is zero for "
>> +			     "owning -> non-owning conversion\n");
>>  		return -EFAULT;
>>  	}
>> +
>>  	for (i = 0; i < state->acquired_refs; i++) {
>> -		if (state->refs[i].id == ref_obj_id) {
>> -			if (state->refs[i].release_on_unlock) {
>> -				verbose(env, "verifier internal error: expected false release_on_unlock");
>> -				return -EFAULT;
>> +		if (state->refs[i].id != ref_obj_id)
>> +			continue;
>> +
>> +		/* Clear ref_obj_id here so release_reference doesn't clobber
>> +		 * the whole reg
>> +		 */
>> +		bpf_for_each_reg_in_vstate(env->cur_state, unused, reg, ({
>> +			if (reg->ref_obj_id == ref_obj_id) {
>> +				reg->ref_obj_id = 0;
>> +				ref_set_non_owning_lock(env, reg);
> 
> +1 except ref_set_... name doesn't quite fit. reg_set_... is more accurate, no?
> and probably reg_set_non_own_ref_obj_id() ?
> Or just open code it?
> 

I like reg_set_... Will change

>>  			}
>> -			state->refs[i].release_on_unlock = true;
>> -			/* Now mark everyone sharing same ref_obj_id as untrusted */
>> -			bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
>> -				if (reg->ref_obj_id == ref_obj_id)
>> -					reg->type |= PTR_UNTRUSTED;
>> -			}));
>> -			return 0;
>> -		}
>> +		}));
>> +		return 0;
>>  	}
>> +
>>  	verbose(env, "verifier internal error: ref state missing for ref_obj_id\n");
>>  	return -EFAULT;
>>  }
>> @@ -8817,7 +8874,6 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
>>  {
>>  	const struct btf_type *et, *t;
>>  	struct btf_field *field;
>> -	struct btf_record *rec;
>>  	u32 list_node_off;
>>  
>>  	if (meta->btf != btf_vmlinux ||
>> @@ -8834,9 +8890,8 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
>>  		return -EINVAL;
>>  	}
>>  
>> -	rec = reg_btf_record(reg);
>>  	list_node_off = reg->off + reg->var_off.value;
>> -	field = btf_record_find(rec, list_node_off, BPF_LIST_NODE);
>> +	field = reg_find_field_offset(reg, list_node_off, BPF_LIST_NODE);
>>  	if (!field || field->offset != list_node_off) {
>>  		verbose(env, "bpf_list_node not found at offset=%u\n", list_node_off);
>>  		return -EINVAL;
>> @@ -8861,8 +8916,8 @@ static int process_kf_arg_ptr_to_list_node(struct bpf_verifier_env *env,
>>  			btf_name_by_offset(field->list_head.btf, et->name_off));
>>  		return -EINVAL;
>>  	}
>> -	/* Set arg#1 for expiration after unlock */
>> -	return ref_set_release_on_unlock(env, reg->ref_obj_id);
>> +
>> +	return 0;
> 
> and here we come to the main point.
> Can you just call
> ref_convert_owning_non_owning(env, reg->ref_obj_id) and release_reference() here?
> Everything will be so much simpler, no?
> 

IIUC, your proposal here is what you'd like me to do instead of
KF_RELEASE_NON_OWN kfunc flag. I think all the points you're making are
interrelated, so I'll summarize my understanding of them and reply to them as a
group here.

1) KF_RELEASE_NON_OWN shouldn't depend on KF_RELEASE and thus shouldn't require
   the flags to be used together. Why? It's confusing and KF_RELEASE_NON_OWN
   isn't really doing a 'release' by current KF_RELEASE semantics since it's
   converting to non-owning.

This point seems reasonable to me. KF_RELEASE_NON_OWN wants to do many things
that KF_RELEASE does, and in the same places (e.g. release_reference(),
confirm that there's a referenced arg passed in). Adding KF_RELEASE_NON_OWN
logic as a special-casing of KF_RELEASE logic in a few places reduced amount of
changes to verifier, at the cost of tying the flags together.

That cost doesn't seem worth it if it's confusing to read and muddies the
meaning of 'RELEASE'. So agreed. Will make KF_RELEASE_NON_OWN logic separate
from KF_RELEASE.


2) process_kf_arg_ptr_to_list_node, renamed __process_kf_arg_ptr_to_graph_node
   in further patches in the series, should handle owning -> non-owning
   conversion, instead of relying on a kfunc flag.

This is how the implementation in v1 worked. In [0] both list_head and rb_root
start using same __process_kf_arg_ptr_to_datastructure_node helper, which does
ref_set_release_on_unlock. Then in [1] the ref_set_release_on_unlock call
is moved out of the __process helper because process_kf_arg_ptr_to_rbtree_node
needs to special-case its behavior for bpf_rbtree_remove.

That special casing led me to move away from doing the owning -> non owning
conversion in the process_ helpers. My logic was as follows:

  * process_kf_arg_ptr_to_{list_node,rbtree_node} act on the arg reg when it's
    a specific type, but owning -> non-owning conversion is more of a function-
    level property. e.g. rbtree_add sees an owning rbtree_node and converts it 
    to non-owning, but not all functions which take an owning rbtree_node will
    want to do this.
    * Really it's both an arg/type-level behavior and a function-level behavior.
      stable BPF helper func proto's .arg1_type w/ base type and flags would
      be a better way of expressing this, IMO, as it'd remove the need to search
      for the arg-to-release with the current KF_RELEASE kfunc-level flag.
  * The 'deeper' in arg reg helper functions special-casing based on function is
    , the harder code becomes to understand.
    * Retval special-casing based on function is less confusing since that's
      usually in 'check_kfunc_call' with minimal helper usage. This is why
      I kept some special-cased logic for rbtree_remove retval in this series,
      although ideally there would be a named semantic for that as well.

But as you mention in this patch and others, we can have this be function-level
behavior without adding a new kfunc flag, by special-casing in the appropriate
spots. This suggestion is pretty reasonable to me, but I'd like to make the case
for keeping the named kfunc flags.

I made a mistake when I used 'generalize' to describe the purpose of moving
logic behind kfunc flags. You and David Vernet correctly state that it's not
likely that the logic will be used by many other kfuncs; even other graph
datastructure API kfuncs won't be that numerous, so is it really 'general'
functionality?

Really what I meant by 'generalize' was 'give this behavior a name that clearly
ties it to graph datastructure semantics'. By 'clearly ties it to ...', I mean:

  * It should be obvious that the named semantic is not unique to the particular
    kfunc
  * It should be obvious that the named semantic is tied to other named graph
    datastructure semantics
  * When specific semantics are discussed in the documentation or on the mailing
    list, it should be easy to tie the concept being discussed to some specific
    code without ambiguity

Personally, whenever I see "func_id == BPF_FUNC_whatever" (or kfunc equivalent),
it's not clear to me whether the logic follows is unique to the helper or is due
to the helper being e.g. "special dynptr helper". For this graph ds stuff
specifically, you had trouble understanding what I wanted to do until we stepped
back from the specific implementation and talked about general semantics of
what args / retval look like before / after kfunc call. Since we nailed down the
semantics - in some detail - in earlier convos, and decided to document them
outside of the code, it made sense to me to give them top-level names.

Your (and David's) comment that "KF_RELEASE_NON_OWN is not a great name"
is IMO acknowledgement that giving the semantic a _good_ name would be useful.

How about I try to make the names better in v3 instead of removing the kfunc
flags entirely? If you're still opposed after that, I will instead add helpers
with comments like:

    /* Implement 'release non owning reference' semantic as described by graph
     * ds documentation
     */
     void graph_ds_release_non_own_ref() { ... }

To satisfy my bullets above.

  [0]: lore.kernel.org/bpf/20221206231000.3180914-8-davemarchevsky@fb.com
  [1]: lore.kernel.org/bpf/20221206231000.3180914-10-davemarchevsky@fb.com

>>  }
>>  
>>  static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_arg_meta *meta)
>> @@ -9132,11 +9187,11 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  			    int *insn_idx_p)
>>  {
>>  	const struct btf_type *t, *func, *func_proto, *ptr_type;
>> +	u32 i, nargs, func_id, ptr_type_id, release_ref_obj_id;
>>  	struct bpf_reg_state *regs = cur_regs(env);
>>  	const char *func_name, *ptr_type_name;
>>  	bool sleepable, rcu_lock, rcu_unlock;
>>  	struct bpf_kfunc_call_arg_meta meta;
>> -	u32 i, nargs, func_id, ptr_type_id;
>>  	int err, insn_idx = *insn_idx_p;
>>  	const struct btf_param *args;
>>  	const struct btf_type *ret_t;
>> @@ -9223,7 +9278,18 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
>>  	 * PTR_TO_BTF_ID in bpf_kfunc_arg_meta, do the release now.
>>  	 */
>>  	if (meta.release_regno) {
>> -		err = release_reference(env, regs[meta.release_regno].ref_obj_id);
>> +		err = 0;
>> +		release_ref_obj_id = regs[meta.release_regno].ref_obj_id;
>> +
>> +		if (is_kfunc_release_non_own(&meta))
>> +			err = ref_convert_owning_non_owning(env, release_ref_obj_id);
>> +		if (err) {
>> +			verbose(env, "kfunc %s#%d conversion of owning ref to non-owning failed\n",
>> +				func_name, func_id);
>> +			return err;
>> +		}
>> +
>> +		err = release_reference(env, release_ref_obj_id);
> 
> and this bit won't be needed.
> and no need to guess in patch 1 which arg has to be released and converted to non_own.
> 

Addressed above (in re: your 'here we come to the main point' comment)

>>  		if (err) {
>>  			verbose(env, "kfunc %s#%d reference has not been acquired before\n",
>>  				func_name, func_id);
>> -- 
>> 2.30.2
>>

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12099634CE9
	for <lists+bpf@lfdr.de>; Wed, 23 Nov 2022 02:25:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiKWBY6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 22 Nov 2022 20:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235178AbiKWBY4 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 22 Nov 2022 20:24:56 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFD474CDE
        for <bpf@vger.kernel.org>; Tue, 22 Nov 2022 17:24:54 -0800 (PST)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AMNVRpg020884;
        Tue, 22 Nov 2022 17:24:39 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=XtkSAJD5ZrO+YuVO8+yb3Khkcppyl2Atg7c/iz/ZhRA=;
 b=cMYQkt4eQSr2pke/1Yx/ei4TY5HTMbTRZZDcB+GcgMws81BtLpax0PNU2GxIjjvT+aIQ
 s7dP8M4N1y750LrclvcNZRztdV8FbhWlsxb7FWjsv9gE+4gwZvsZeU+zsYReQfT6cVDL
 pmVnwfrEttXy2HDG6RPIbNPoCR3vaJLqonLYcBSK263cS9mOLnjlFHFi8DifCZvzfdLo
 bcQ4H4vptsJ04kvGz6LjvOWc9F3e8YOR8bAWBsKG1wrxFjoh5YtKWmDhjHJBNdNj/7R2
 ijM5ddlliV52vZANw8KdmeoqUZqx50zOxXR/Sua/PiVJIO4ihH9C69dvkMtiaJuqDIoF fg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2177.outbound.protection.outlook.com [104.47.57.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m13qhjns6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 22 Nov 2022 17:24:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KCeLtIHYecdHN5HH/HPWsGas5QsCTggIdKu9HkK2ubO28NrrMJ2rtEfGZhMCTeIuOIsncMnMTNi4EE0NIxtqLfkfZpbRLFpJufdxbHGHpTlZJOl+VkjHW/ra3oP8wnF2RS9fABtS/2CHMoFqGT3vkJTk3c7fD1adPzIt+w9qPQk2eJeFrt7ZCq8Fbgc0HcjSoMq0UCksWXMycnnngmbzP+3aUyX1DaMxI0bm2JfPGn54SoYcITbcEs5ly7vrxm+mwUHmUUP+ivqG8DrjhSvuT7rkm4ImT3LJr1s3ICfRi3ES4nwWZGy4j4MDFamp+1oUVNNj1RX1vGfXpDNHVB2bvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XtkSAJD5ZrO+YuVO8+yb3Khkcppyl2Atg7c/iz/ZhRA=;
 b=MlLkKGvZ70GWKH8OIz+7JOgFoK7Z9npr6q1QkffOk27FYCsJ99oZyLoq57KURHSKX9R+adcxlo2w2Va2fs9Oavxw39LGYDubou5nGeu98YWb3IqpcC9KJZ64co662vNXAH7lMsqNqI+fOcFgF5+PEwMxqVPYmYlsNSYBPISwiWbsSBEkQxWm91oHdeKTyZc11D9AbQOSIDsnYT6BtNx4/lrxH7W4UmBcXGdTugmmYt9un1axAC2KA3WAGQx7dAZkthxA2jonAhzKSnKHhf9B/LDQvQQUaUPQJ8XgYdRdq52SxoZzTQB8tYOprBwZnwYcBwe9v6Y5IOmx705JscL6Ug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3067.namprd15.prod.outlook.com (2603:10b6:5:13c::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.19; Wed, 23 Nov
 2022 01:24:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Wed, 23 Nov 2022
 01:24:36 +0000
Message-ID: <993bca84-deb7-88c9-1ac5-f2aeeda2be39@meta.com>
Date:   Tue, 22 Nov 2022 17:24:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v8 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Martin KaFai Lau <martin.lau@linux.dev>, Yonghong Song <yhs@fb.com>
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>, bpf@vger.kernel.org
References: <20221122195319.1778570-1-yhs@fb.com>
 <20221122195335.1782147-1-yhs@fb.com>
 <3ee3af12-0542-e33c-2e9b-c6838de6ba64@linux.dev>
 <200910d3-23f2-e7e0-a03a-85d781d7341a@meta.com>
 <dd614512-762d-d5e0-adb0-4ab480a03e69@linux.dev>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <dd614512-762d-d5e0-adb0-4ab480a03e69@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR03CA0020.namprd03.prod.outlook.com
 (2603:10b6:a02:a8::33) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3067:EE_
X-MS-Office365-Filtering-Correlation-Id: bc710f3d-e3da-4488-a6c1-08daccf17bca
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2w76y3rht0s2si6w6/x6usI1xblCHx7ljtNV6rXzbHNyTFd6U3yoGasVslJfb0ymm115r43Nj5KO0HXz5clq4NXjkDgqea74iMscFfktn7kEw7mkOPmBJwHVtcFGvh/+bqlttGWAVvPQLGWRIEJZ46eGquVvDM/RUx8pKGHnnPuwV/L77gCJPZy3Zor3fV3hIZlfbdSPaEO52HlHrktaBx8PkOckEI+btH4BfMbnGtNBYvpHHfIZHPcrsmipsNB3NYICdyOPPnw6eIP+knh6tZ+V9d6O2KG1BOagOrMPEDsyEfXEoAjwzGrwAFWqg44IkaeWnyc2GtQxjrrdwf5wrQv+vzKJwZGxPpD663L8CLH8icXFmwPwN4lxE8IPSBNWrG4VzHPAxM8/ieuX8QCpF6Vwxd57D+M9iFE02UiXpGNmX9a2gk+YdE0/d8r2Nz2MtqvkR48LK7bgNZ+PUn1DaAr+aTLyF3O2YL/vyly0y+q46P4DEYjUDbWggFlnagDgcr60rh9FdRdXrLlj9m/MhPs4PyY1vHESAYaFizoBVPunW++2V4XmtnliMYpYjin7g6TthBBrzMXWjuMvEM1yU/a0Hjwak4Pxdna/lcCl4orHiIhaww4Kx6+zhJfTFq4vjnZhpmURk7iiylu854qmewqgVGivS066OUhtJUqhv3mX8Ta/sWDmkxtbFHWCROsGTEjxwyuhAw4k5VMiu+k5xMuupB1WVfddXXXMx16gUE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(451199015)(31696002)(83380400001)(38100700002)(66946007)(4326008)(8936002)(86362001)(2906002)(53546011)(316002)(54906003)(66476007)(8676002)(6666004)(6506007)(6512007)(5660300002)(6486002)(66556008)(2616005)(186003)(41300700001)(478600001)(110136005)(31686004)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UU9VT1krR2ZqTUtRNFlDcVpYd3NEYmpZZUtIYlhsMzhCb2RHc0VCODFXc1pI?=
 =?utf-8?B?K3BYZjVNaTB5cFRxYVJvNklFV0tMVXA5TWxLb1Jxais4TjRDYzJtRXpNeXlz?=
 =?utf-8?B?ckg2aFBXeWZIdlUyeXhOL1k1U0pudXNSQTNZVHhLNFI1WGpCSG1Rck9CNkpQ?=
 =?utf-8?B?Y0xhdmtVb2F3NTZhbnBVa3VHV2xCRzRnMnMzMm9CQnNwd2RydlBXME5uQyt2?=
 =?utf-8?B?TjV4dHhMRjhTYjlyaFJ2K0hYZmIxUlEzYWJmTFRZcTRadWtacEZaQ0dUSk9r?=
 =?utf-8?B?V2JpU2ZXbTFLK2g5cmxaQ3h3MTVpWTEvQ0h4LzlwekpoZWduYlNEcTA3cXBF?=
 =?utf-8?B?SVF6MTlZeVZQK1YzZEVuTXkvR0hKbkZLanZ3ZEVSSjJHc2hqa2M4M1NyVFg1?=
 =?utf-8?B?SVI2MkR0YXBrMzgrU1JyUVFSRUROQWlTYkllZE1sbnYzUWRlbzV6Q3hFUDVq?=
 =?utf-8?B?LzBmWlh0TXg2b3ovR29NNmhSMUNEYm96U0Z4MUFyMlp3Q2lPN3U1cy90TWEw?=
 =?utf-8?B?STNiUUNiT1pKSGQvTndrNk1EZVJmRGxjbWRkSExsR1l2eXhmVmNxR1FmeVU3?=
 =?utf-8?B?aFM2dFpwQVAvajlaWkFNUStOOGw2S2VibDhETVlWc0JZbjUrbkI2cE1UcVFN?=
 =?utf-8?B?ZTNUOExPTW51S2FSRGdVb1BWd2cyV21LWmlURW5GRStKRmlpZnZMMlJHSmdZ?=
 =?utf-8?B?M3JRbUZueDdOSkNtVE4xUHFUV013Vm9DTUNiUVRQckF5ZStjZ3diUmJmZWpz?=
 =?utf-8?B?T0pDbXV2Z3ZyeUJUQXVaeW9CaEpIMjJkSVVhaWFvWGRGTEp4VDZHL3NZSFlS?=
 =?utf-8?B?bm9mU2R0STFGTTl6Vmw0UEZUWU80cUVONkM3V0Zkay9QeFI0REk4a3BHOTNp?=
 =?utf-8?B?QUVWTGppbXFlM3FTVzZxaC9rWHYvTlgwczlDekNIaGd3MEFsRVpQTUpZdGJm?=
 =?utf-8?B?Y056OXY5YWU1RTZ2SHA0Rm1jQmRHUC9rMjlhWG82MEJ5N0VRb085eVE4Rlpo?=
 =?utf-8?B?SldGOHBGQmkrdUhnWlhsUmZBNytDb2tVeThzZmxweVRUNWpSbVdSaUFacXY5?=
 =?utf-8?B?RHVreWFFK081S2t5MUkzeFdJbzAwQll3Yk1jdGR4dXJwMTFCNFIvZ0JjaGpo?=
 =?utf-8?B?UWJGMEVGa1dJSDI3SDg3WWxEdU54aVNFalk4bzNxVFo1dW82SThnMlp1VkE1?=
 =?utf-8?B?YWl2UWhkQUU3cDJDVjdTQ2ZYekFqdVJtbHVLS01jMjRtV2J0Zi9EWEc3NUZX?=
 =?utf-8?B?UG5GTnFHZGxVSHpZTWlUNy9kUVhyOCtrME5xVGRnMTRBM2VOeExDcG1TMHEr?=
 =?utf-8?B?NCt0L1lqUHc0c0p5eVJHYmtwQmIzcUZwbndST1g4RWR2UTR1Z2FZOTFoeHFF?=
 =?utf-8?B?MmVoLzROVTJ5eENMd0FOM3MwMWhQaXpTNXp4QzkrZ2JHdWtqNGZaaU41bXBr?=
 =?utf-8?B?cDVyMmdDc1NsMytEWHJFaUtIL2FNV1BtWitYbnVmcWc2TjM4UWJrZklwREZS?=
 =?utf-8?B?RUJmS3VtVGxmZmRPWkxtL245MUs3YmpsYlRhVG13ZThGb0xHWFFVQmt2c1R5?=
 =?utf-8?B?R1g4S0NsZk96R0pIaGJOKzllOXRWeERxUFFHVVMrTFRXN0ZML1l0a2szNmpD?=
 =?utf-8?B?ZTArUlFXaVJPRHQ0b3FlVHhBbWF5eVFzMUgxWVBFZU9YcVVCMGtycEkyNk5P?=
 =?utf-8?B?TFNqcGwxbXR5WHY0MVJzd3k0dS9EbUxqMmppV0ZyTE1BOEtabW1PTE1wNDd0?=
 =?utf-8?B?VlNvdmdpUzA0ZS9ZRUdBc2QyYkVuQmllc1lad2lsWFlIck1EV25KVjl2cVp0?=
 =?utf-8?B?VWNZS2JaNkROOXljdy95alE4VUhHZTJaT2NaTWVEaFRseHRXK2hXQUVQbkhq?=
 =?utf-8?B?NnNPd0JlVzRmYllpenZoNzd3cXBWZEh6d0wrMlJiMkM0Ny9hdHBhYzZHcWRt?=
 =?utf-8?B?VnV6em0rR2Q5dE1aOXd0K1B3SUx4NVZZK3MwcW5UaytQQWEyWjFBMFZDRWhu?=
 =?utf-8?B?YnNKSkN3ZnNDSzYvU3NXWlpmODhSMFNCWG1CN0dHakFVVXMya01CYkJXaWZm?=
 =?utf-8?B?cGhtMkFoczJCZ0pZMnJ2VHpkSzdDMEl2ZmZtQ0xrS1dUM2VKTkRuemtBS1FV?=
 =?utf-8?B?WWw0UFdpSHZaOUdQTXVSS3hJb1hkK2tUUjRQWHNpQ0FHN21OWFdpc0h5LzF4?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bc710f3d-e3da-4488-a6c1-08daccf17bca
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2022 01:24:36.3815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I8OmwQYYjoY94hiYmjZOwSXxNSj5Z07b28JEGw1sRP6sKCTHZE8rLO+mOt1fJeuE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3067
X-Proofpoint-ORIG-GUID: UBwqVIn3zpXVecn8cLLgVU7hWHjJXmK5
X-Proofpoint-GUID: UBwqVIn3zpXVecn8cLLgVU7hWHjJXmK5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-22_13,2022-11-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/22/22 5:19 PM, Martin KaFai Lau wrote:
> On 11/22/22 5:06 PM, Yonghong Song wrote:
>> We should be okay here. flag is a local variable. It is used in
>> below function when reg_type is not SCALAR_VALUE.
>>
>> static void mark_btf_ld_reg(struct bpf_verifier_env *env,
>>                              struct bpf_reg_state *regs, u32 regno,
>>                              enum bpf_reg_type reg_type,
>>                              struct btf *btf, u32 btf_id,
>>                              enum bpf_type_flag flag)
>> {
>>          if (reg_type == SCALAR_VALUE) {
>>                  mark_reg_unknown(env, regs, regno);
> 
> Ah, got it.
> 
>>>> @@ -11754,6 +11840,11 @@ static int check_ld_abs(struct 
>>>> bpf_verifier_env *env, struct bpf_insn *insn)
>>>>           return -EINVAL;
>>>>       }
>>>> +    if (env->prog->aux->sleepable && 
>>>> env->cur_state->active_rcu_lock) {
>>>
>>> I don't know the details about ld_abs :).  Why sleepable check is 
>>> needed here?
>>
>> Do we still care about ld_abs??
>>
>> Actually I added this since spin_lock excludes this. But taking a deep
> 
>  From looking at check_ld_abs() again, I just noticed this comment:
> 
>          /* Disallow usage of BPF_LD_[ABS|IND] with reference tracking, as
>           * gen_ld_abs() may terminate the program at runtime, leading to
>           * reference leak.
>           */
> 
> I think active_rcu_lock should be tested.  My question was more on why 
> the env->prog->aux->sleepable test is also needed.

Will remove env->prog->aux->sleepable in the next version. It is a 
leftover missed with v8 not to focus on sleepable aspect of the lock.


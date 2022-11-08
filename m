Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62C95621CB8
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 20:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbiKHTJo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 8 Nov 2022 14:09:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbiKHTJi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 8 Nov 2022 14:09:38 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AEB16DCF0
        for <bpf@vger.kernel.org>; Tue,  8 Nov 2022 11:09:34 -0800 (PST)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A8IDEeQ005254;
        Tue, 8 Nov 2022 11:09:21 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=+PxdtLOZO9MyUXD/Kt5YPjfCRITGXcFbyW/RPz6UDcE=;
 b=NYfnNXhM40xRtSRrwoHlTd/o5y6QcW2BbWPnM0KhPqmhyL2jRKXWfP461/+cLB51Cwup
 CpUdHzHh59wAvJ7d41hfWu2GoW1KNtSPcA1RHbTSNVpTrP2vRz+H1S4Ul+NP5DlLPpPe
 TICxxdM8srFv+Maf52EZ8Cv9Iklw8nAw8R2emD5fpKuiYHNVes/gORoKU5t+vsc4qr8/
 dCS3vGZNGfzAjuTp1KjWyTaLES8b9xMcqSakDcQzy5SQQ3imNd4AEwS4Yav2MzFuMqGp
 OQ34hpSCcqD+Z6MeZ45nrkgU3g99760TlFeBcZLeI8QkzZD352kP2IKRRcvinitplzC/ fQ== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2168.outbound.protection.outlook.com [104.47.57.168])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kqhba5qha-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Nov 2022 11:09:20 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EvrAq5U4Q3cNnDN9Fzep46X2tAtIuYpPOtgG7NUMM2QBLqPPOFxOoAl6lf5n+klExU0L4RNu7KrbWu2aLUM17DxfdL1+PdB9LBAKHASrEl2KcjUl+DmK3Wv97yf+AhncjmOPq6E5LAPxM/6P/+ALDqzI0tXwFaXqeX/oh3U7vKN2kElvBNluUPECYaRF6NrMiP9l0ngW1M8/1x2ZQ+lIh8aEghiAQ29JVSRnMczIvRPZllPSECWvkbRpt0XsUjaV+obpLQhKH3y9tIA+emsmO91U09+zr3B/EmuSd6wfaqZNU/QzjPqvShWCzvRGCWLtoFmRiWy5XNthyL8Lpkhdqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+PxdtLOZO9MyUXD/Kt5YPjfCRITGXcFbyW/RPz6UDcE=;
 b=WbG6k3PxbxiezaO+mR5EBotFRdvDHYxJg+i+67mMpcVk4zhHsDscdcRqbP1hb1MuCUFtbK0nQacLJ+AGzrFdCBW69U8AgqeC4oPXFz00Y96NfC3xCNhkPBmglXEPlKVAca/2g1csmb8dxJt2incfazG1N6h4rcgAXlR/biGeLx0zrZIiqvXyYcnFMeUeCTN3BaUcWyds9tKg7+4wQmXn4Mr/PmEigdDOtJmT3EjG416q5nVFpOCXhD+DhCxel3glWFFwxvXGAtpCzGnvKQ2rVODwqvNfEsAB7lulwVT4nEm1RUVbhLRiRCddfrYw7PMBOSgP8IFlO1DVskeJ7I1wNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BY3PR15MB5010.namprd15.prod.outlook.com (2603:10b6:a03:3c9::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Tue, 8 Nov
 2022 19:09:18 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.027; Tue, 8 Nov 2022
 19:09:17 +0000
Message-ID: <c8cfde72-eb93-955f-0672-bb617364d6b9@meta.com>
Date:   Tue, 8 Nov 2022 11:09:15 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next v2 4/8] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Alexei Starovoitov <ast@meta.com>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221108074047.261848-1-yhs@fb.com>
 <20221108074109.263773-1-yhs@fb.com>
 <d5a886ba-4768-9c97-9b56-0e0d58020617@meta.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <d5a886ba-4768-9c97-9b56-0e0d58020617@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR01CA0041.prod.exchangelabs.com (2603:10b6:a03:94::18)
 To SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BY3PR15MB5010:EE_
X-MS-Office365-Filtering-Correlation-Id: 5de44481-7d24-4e03-f712-08dac1bcbbd8
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LoQ4vjne8yA/ybC9tvlwU+/SBJ8XV8qIrklZ2Hr8n6K/Qh5R7B8FCyH0KvYYfSBgFFPQclojY3lcn1U4ldLGg06TJVs+GqH/hGeD6YeKpnkR+KDDAwwivhRJQFlLQeEPVafomLQs2zi7BdYM9qk3CWaS/+BC2GjPAABK66+e05oCfpMFABu1F4wIU25cVEag0ScuhZ061Oyp/Myx1OCAE6BsrnHR5mBOweC17SM3QzUH/JwHIWRzIRUdML7HvINcoKqGjU0/RjZGdW4yTF2RlrMyyuuBaDLDqJIq5UpoqN4GI0ca5YvYilzKuoxf4vvEEVjP6Mds5Aqd1fCHTx/rlXGaLBF4ZSIstmOaiQFrQxBbJg1r5SEum3aq7slTyW7fLOWaOMOqCsOA9A/0/wrWumMxPJN1s1qkC01MD857EeIqCr7IcXN/8XvGjxG/qusZWZbOMEJnXwtMBxNuer+j8c5ncqliiKIg5UIcG4mFcXOe5HcZx9oeb/JJKq2VMC8RBFbNlx79FIpOD9y0wuoOgZIKTfEtbKeYCyJ37SXT59JVBk2zxpxLIJr2A9G8h6Gre3ApJ9q+5dc5MRR+U8KoSQo03UXcYbBI030bowE2HD+RAZQ2lWIX8EpGANElUiVK12Dc72f5hAKDOHmC8KPC2lNeeakRjkdR6nwMmlyijeq6UW8cg8rEuTDhh7kH0aEwf0CjJqUDhhFAJx9aF8pNe6N88mSrJceJ4mRNK0f1ABfOMF8ugkL3rC5brSoFl7ODoQNiFWf3p7fd3ENzqW7eZmjOABzYs/nwTRUSRG/q7Zx8d3qHF+FTaYUg0I0bpZpwyshcISjbzUe+hQ0Ggu+sIA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(451199015)(83380400001)(6512007)(6506007)(2616005)(186003)(53546011)(38100700002)(2906002)(5660300002)(966005)(54906003)(110136005)(6486002)(8936002)(478600001)(4326008)(41300700001)(66946007)(66476007)(316002)(66556008)(8676002)(31686004)(66899015)(36756003)(31696002)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3UyU3JkbzRqczZEY25VaWZYNFFNMEFxaEoxSktOSHZkZUdmYXJ5YlY0S213?=
 =?utf-8?B?WDE3Sm9YU01hMWE3VHNTVERiMjRHMmxQN1FXbiszVzVFdmVQejEwb2ZjaHRm?=
 =?utf-8?B?WE9rZUVwZFRRMko1OHVrTk1XWFFCUGxtVy9BblBJN2h3Vzl5aTJNV2RpT1JC?=
 =?utf-8?B?V0dJbzRSbVNEUXhpODVDZFdNTEVUSnJQR1hrRW1rZS9rY282c21zdmVFZXkr?=
 =?utf-8?B?b2QyKzc5RnB2NjE1Rk5jb2N0Mll1Wjh0a1hINVJoa3ZvaWo0TXViMDVMdVFY?=
 =?utf-8?B?Ny9hK3ora3RJN1ZmWE5TOG1nTWpJVnJXOVBYNEt6U21PYTlqdlVUaDZneUtr?=
 =?utf-8?B?M2FOMFU5a0dBVjV3a0k5NkhGcUdZcDJxampQencyTTlJN00rMmZDcllMVnNh?=
 =?utf-8?B?VkxnZVZVSUlXVEFPRDA1cVV2Kzc1STlBMGgyN1E1b3RmcVpnSTF4ZHgwMFh2?=
 =?utf-8?B?SFhUOUlReENMTFlIRENsZUljVTc1bzhqbkY2cEJuTklHRlE1bk9ObkhHNmtN?=
 =?utf-8?B?OXRuNVVUNENVK1ZDS3hkZDMyc3lNNVA1aml3OGhBL1BwQVFlTUorcWwrRkhr?=
 =?utf-8?B?QUY5TmcwTGZmeVA4QVcxR29SVUVvSUUxMURRcFBwaVlHS1NXVkp2T1dqeU4r?=
 =?utf-8?B?a3pFd2o3RDg0OGVOdUhvVGVOVnB2MEx3MDA0czZrdlJ3dFpReFVQaFpnYUxx?=
 =?utf-8?B?ZVNoVk1mbzlienluMGtFaUQxMUQ4N29wMzRGUExCSkpPU1Jxakc5T05KTStJ?=
 =?utf-8?B?YjZrSVRzd0JpUk5CdHltWkpVRWFpeTU2Z2NzVmxlbW5EakN2RDZsejUwVFpm?=
 =?utf-8?B?R3hlbWtLb0g1cGc1Mm05Zlk3cjIwM0NEekwra0V5MXpRVDg5Q3BhQy9raTFS?=
 =?utf-8?B?QlNCZ2h5NW1zejJrcGNEK0EyTmZKTjQrSzRVSVZXVkYrQ1RqQTlKSDNMS1J4?=
 =?utf-8?B?VHkvbDQ3VFpBY283MHlGZ3V2anpTcjBQZnpwZW5qVzZBalhzNDFVWVorUVJJ?=
 =?utf-8?B?NlZPc00xdHJYQ0QzWjU0Vlg3TE1SZWRkalcrVGJMalRxUTJyVE5rbk9tTE84?=
 =?utf-8?B?ZUhlemNLaXFuV0l6MC9XVjB2a3VIeVVuMXl2SU42SDlpUGZ4cnJqdzV5bUE2?=
 =?utf-8?B?a2ZaNW04SEFSVTVQZGRiRzNWa2UvWmVZdEozNC9DTW5kUmQ1aGhmWFpKWmVC?=
 =?utf-8?B?dWtFc1FRZDcwWWxhM0VxVnFZQkR5L0h0Vll4NUUxL1djSTlWaHVqTlRieXI3?=
 =?utf-8?B?TTZ0eEYxSWttUEszS1d4L0p3aUY2eFlEZWdORS81SzZWak9oQ2JQdW1aNzNn?=
 =?utf-8?B?QjltaDlyLzd1MHpCei9uQkVJZ1NjVHB2aW1aek5mNEJEamwrUERTUXdJWjhX?=
 =?utf-8?B?c2dLdU55SDRjMWxGUjhjaHlyanJKOUM1cUFadk9FTDcxdzBwSFVvMTBSakFt?=
 =?utf-8?B?clRMWU50cThka2orNzVLYmgxMU5pUXd1Y0xHdVFuYWFyOEpwb1RUd3JJNDBr?=
 =?utf-8?B?NlNqb1p4SEtTVmNFODFsWUZhRnJIcnZCYWMraGhUdmo0UjAwbXlpSUFZMVVJ?=
 =?utf-8?B?eER2RjAzdGg3VDcxSWlZZmkxQ0FCbi8xampza3BIdS9KRGR1MHA1dkFKczRh?=
 =?utf-8?B?TGVWdkhLbDYrblFWR05GMHNlRi82OUJYTS9CdG1DQVpocjhVcFNsa1h2TVU3?=
 =?utf-8?B?RUJmb05NdmxnOStqWDRSQU5YM1JNa0NPclRvT2c2UHlzY08zc1A5cktvc29U?=
 =?utf-8?B?bFgwTzRVd04ybGlLWWtaMzdNaHdhbVFLdnYvMysza0IrQXA1dXlybW5zenlS?=
 =?utf-8?B?andWR042RjNJQ3pHNW4zVlpab3Y0NE1EaVVjbC9MMlMyRksvWUswLzFjSmlS?=
 =?utf-8?B?a3NTdktKc0dwMEZEWDJIYWI0TG5zYVg1amthU0V0NGsvV0NOanhHb0VLVUVm?=
 =?utf-8?B?alBJRWNmRWFDbHFwOFFaOS9sL1NHUU9pZHpEMDBWRGt4cU9CN2xPeThWSXM0?=
 =?utf-8?B?M1JUdjN6bzdtTWNkT2t6MXBBVSt4VkJPWmZVaHFoTmNVN0JuUE0rdVkvc0J5?=
 =?utf-8?B?dXpSYU5hNDllb0tRYWwxVlI3b28vL0Y1MExSNXdOL3NWbURVYWt4L0xqL2RO?=
 =?utf-8?B?WmhyVG0zS0dCWnZKcEFFYVJJV09FR0xQUlFqZ2JocnRseFREek9uanNLalcv?=
 =?utf-8?B?ZFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5de44481-7d24-4e03-f712-08dac1bcbbd8
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Nov 2022 19:09:17.7635
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nIg1Jn15Q4agOBy9BFLP8Evs88mHnb/RxGB/b8etrujVHIDQg/TpYQXjz56t861T
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY3PR15MB5010
X-Proofpoint-ORIG-GUID: HE8Y-lIIF_JaNa22GAwDD56VdQgXOFjV
X-Proofpoint-GUID: HE8Y-lIIF_JaNa22GAwDD56VdQgXOFjV
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-07_11,2022-11-08_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/8/22 8:56 AM, Alexei Starovoitov wrote:
> On 11/7/22 11:41 PM, Yonghong Song wrote:
>> Add two kfunc's bpf_rcu_read_lock() and bpf_rcu_read_unlock(). These 
>> two kfunc's
>> can be used for all program types. A new kfunc hook type 
>> BTF_KFUNC_HOOK_GENERIC
>> is added which corresponds to prog type BPF_PROG_TYPE_UNSPEC, 
>> indicating the
>> kfunc intends to be used for all prog types.
>>
>> The kfunc bpf_rcu_read_lock() is tagged with new flag KF_RCU_LOCK and
>> bpf_rcu_read_unlock() with new flag KF_RCU_UNLOCK. These two new flags
>> are used by the verifier to identify these two helpers.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h  |  3 +++
>>   include/linux/btf.h  |  2 ++
>>   kernel/bpf/btf.c     |  8 ++++++++
>>   kernel/bpf/helpers.c | 25 ++++++++++++++++++++++++-
>>   4 files changed, 37 insertions(+), 1 deletion(-)
>>
>> For new kfuncs, I added KF_RCU_LOCK and KF_RCU_UNLOCK flags to
>> indicate a helper could be bpf_rcu_read_lock/unlock(). This could
>> be a waste for kfunc flag space as the flag is used to identify
>> one helper. Alternatively, we might identify kfunc based on
>> btf_id. Any suggestions are welcome.
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 5011cb50abf1..b4bbcafd1c9b 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2118,6 +2118,9 @@ bool bpf_prog_has_kfunc_call(const struct 
>> bpf_prog *prog);
>>   const struct btf_func_model *
>>   bpf_jit_find_kfunc_model(const struct bpf_prog *prog,
>>                const struct bpf_insn *insn);
>> +void bpf_rcu_read_lock(void);
>> +void bpf_rcu_read_unlock(void);
>> +
>>   struct bpf_core_ctx {
>>       struct bpf_verifier_log *log;
>>       const struct btf *btf;
>> diff --git a/include/linux/btf.h b/include/linux/btf.h
>> index d80345fa566b..8783ca7e6079 100644
>> --- a/include/linux/btf.h
>> +++ b/include/linux/btf.h
>> @@ -51,6 +51,8 @@
>>   #define KF_TRUSTED_ARGS (1 << 4) /* kfunc only takes trusted pointer 
>> arguments */
>>   #define KF_SLEEPABLE    (1 << 5) /* kfunc may sleep */
>>   #define KF_DESTRUCTIVE  (1 << 6) /* kfunc performs destructive 
>> actions */
>> +#define KF_RCU_LOCK     (1 << 7) /* kfunc does rcu_read_lock() */
>> +#define KF_RCU_UNLOCK   (1 << 8) /* kfunc does rcu_read_unlock() */
> 
> Please don't use KF flags for these. It's not going to scale.
> Compare btf_id instead.

Will do. Kumar has a suggestion like:
   https://lore.kernel.org/bpf/20221107230950.7117-17-memxor@gmail.com
which I will explore.

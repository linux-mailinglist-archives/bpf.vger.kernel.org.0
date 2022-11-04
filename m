Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283EF618D35
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 01:30:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230099AbiKDAar (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 20:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiKDAan (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 20:30:43 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD45922532
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 17:30:42 -0700 (PDT)
Received: from pps.filterd (m0109332.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3NKeir024815;
        Thu, 3 Nov 2022 17:30:28 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=lomETX+kuHwxcMwFZdPb1IAm6Q/YmjRW0o3NH4c9VyQ=;
 b=ko4qi+VqJyPNDVM6YYGhGTANERWVraYrVYp4OU9oEZjdcIZi4mOQygEV0s8vHa84s/h2
 aqzfiUJae+vjwEMzlDqS2EEs47hulPyNOr1FJdo6HXDZc62+wRLQ/UDHC7eJ4Tw8KW9+
 F45vv1c8OsXDpXCz1di2OblVnj8pe0McO6fJ3giYGSlnCIC6dKFosgqRqc6TwZJ0CLdu
 5PsJKsVmaeA3fXvRBPpjA3SHTUjpzY7OFoDfhXZn07bzMsCHhw5MywiN4OFlWbKMm6A8
 mbms+SqKjBSzP/xpgE0m4lhKjxVFJLsjKECS8dxh7y5haUmY3EkHj8opUDzXI0gw5QOB jg== 
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2044.outbound.protection.outlook.com [104.47.73.44])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmpgkrv02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 17:30:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Jhe8X05tQAHKH0fzFleO52rwlvACcUfOB1Xm0ws6hea0ETXOhIpgnkAlmJ/UVFxSjd4NC2w2Mi3h/h0zrtcSmtFoVKNhLAWZ5NNmiKiKu6Df3kCD1/3SYqoCeH5CbWDBw5VYIl67iO8/1ASDfteuKwZ8+0kRATrv5cIV2SMVGxS+a+ApnSZCqZIXl7S2Klf/99Z/jrro9Vb9Nc+XtnjnK1ov6F4Z56eRqTZ/DtWl9ROCZEN76iLgNLWR5t4EQATbBU3+cTYeehrhtgydznmx6mkrIawp8Vz+CWZ2w88bdxBW3YBO7CUFv8n/Bu1/ylev0cop+GJ/OExifDqqf3zHvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lomETX+kuHwxcMwFZdPb1IAm6Q/YmjRW0o3NH4c9VyQ=;
 b=O2kSwBxD3FNcABpZb8CLpOdwLNXQgeqF/Du8DHgO5fa21DpDt/NCDp6DIrmi9G9hXErMTT5Sh50bT/CCXHK2YxU4tMj8QSopJnuzVqYmO9w62CA9MPlHC/vWSV25nwatF3nG6ZtxyltJ5xFSYb7dhZWsIh8N4DrAsB26QL63QF76oQgEqZ1I2Ro0YyxvTac95iYHg1zcxljiGErIp5KyS/FkhMb7fAnhvDkpyF2/HYCRE4c5J7vOArq1wfkUy1RhyAk+9uKd6/0RkhngphxQf7iCyUCIP3aGXEM3f2Qp0MGFOFWejWFdB9Ansjz3jr4isWRTAJ3VecnW0iFVIaalrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2278.namprd15.prod.outlook.com (2603:10b6:a02:8e::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.19; Fri, 4 Nov
 2022 00:30:25 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 00:30:25 +0000
Message-ID: <d9e7c760-a581-8633-f41a-3e5d122ffc9c@meta.com>
Date:   Thu, 3 Nov 2022 17:30:22 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 2/5] bpf: Add bpf_rcu_read_lock/unlock helper
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>,
        Yonghong Song <yhs@fb.com>
Cc:     bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072113.2322563-1-yhs@fb.com>
 <20221103221800.iqolv5ed2muilrgq@apollo>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221103221800.iqolv5ed2muilrgq@apollo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR08CA0062.namprd08.prod.outlook.com
 (2603:10b6:a03:117::39) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB2278:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bd59b69-881b-4f0b-507c-08dabdfbc430
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +ZfirLUzUnOR1xP+uG3o0mlptpsC8tYYKnUnSKJP3Sn4rcBGwISec0wmbVv8mD5EfBv5FoU2+mJujtf3oy03ZdNfawRegDtgo+89c14xlIxzIuT1Nvf0DJSmQIPYdjaUOGvT/Bvp45enCZ/vqTswM351Ntxpysgo5OAFsi62QqsQhnBAe9eHEkAzXQj8TArKuaqrqA3DsEbO/ZsxTUpoCP8DmMTugKBa4v7gu5BMvvJV+vvr5Wx33EBsSU0EUhCVta0Ex/s1xcL8GNHLEjaumG99ST768JMFVLroDJkwSA+xjkUsCE1bc1g83RZcVlTx7faM3sL3q5sJ62IKqhfjHWkXLmgBsdK27/tQ2R1Mjb9obIg/0AqTiBqgjZhLyxb/TARNfhoEBYBz298DpJaKx+mQ5sQ0s7bPxnIwTLtzgbeTsPaEphLcnAVrhyp9cFuRk3fmAppCuvnSUwXP2M+V6rV1EjEOIoiv7sEC3+RnLEWHL8d6IvztwMnyN0Gs53MNKVVyAMr26YI2e6YtIDjoxBmeROl6YCev/nDan9q00mlQM1jsnjM5KpkxFCg0GVFU9vcXcuv7315XaKzZ1Lnxf0AzJRf2JJ89DlB5fplnIUWyYoGr3KODSbZurRwS6MF0eKvlLASLZKrInG6WaQ+EZO7m110h9Ljkd9g/DNevEuJYs1SAaBD+6P507qx5idE8VDCVDEVRoBvqK99yIBKQe/cd82V/9TT+tHSs3n9jh29JaH5NIVFR67xRjfWfk0VZ61dHPV3IEEh3bRPF/36QCdhAiYXKiJLy1NvAqgEFxxE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(366004)(136003)(376002)(346002)(39860400002)(396003)(451199015)(86362001)(31696002)(31686004)(36756003)(53546011)(2906002)(5660300002)(186003)(2616005)(83380400001)(38100700002)(6512007)(54906003)(110136005)(316002)(8676002)(6486002)(478600001)(66476007)(4326008)(66556008)(8936002)(41300700001)(66946007)(6666004)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3FsS282RzRzY25VRE9VVVVhZ1l3dE51UkVyZVhRVS83TkJQa1pyWEE3bHAr?=
 =?utf-8?B?Q28wT3l1bXRCUEtPSGhtOWRNaEx6NWQxbUVaQjU4RWF3d1Y2T045VG5wbDB6?=
 =?utf-8?B?T1FZQkZTbnY5UTlqWm00WWFRL1FiTkR0T2t6dlZmL2tlenoyam4vMFJkTjBl?=
 =?utf-8?B?eU5JbGpKRGxUeHIycFo3VlcveUNNOE16UHd3eVVMNHNlR2o5bWJxUmFDR0g0?=
 =?utf-8?B?ZVppM2RPV2FTTlBVdGt0RFhZRm1wamdyVWNzUGZIanpQQWxJazQ4aGd1ZjVY?=
 =?utf-8?B?TnhvZHVCbG5VanpHY0RKdndzZmlPUzRwNzJvU1poWTVkYi9yOEdhKzVBOHhi?=
 =?utf-8?B?NTJFMGhMZXcxTW1FWVdaanUxbjhRWEpxMjQ0ZGZ4SGNad1hUcWsyRW83RWxr?=
 =?utf-8?B?VkNCRnVrUHhDb0huQVVvYjhkc0ZhVkczSU03L3ZOeEx5Rks5RjYzQ0QxSS9Z?=
 =?utf-8?B?Uy8wK08zRzA2bk5hcXpYVElOWnVZdGZqNTFXMk5Zb1pIeG1UdjMyVE5WZ3Iy?=
 =?utf-8?B?MDVJUnAzVDdRZFZDWmpwdVQ5d0x0RVdkbmx5MC90SkpXbmE2RHV3THhRaHIr?=
 =?utf-8?B?SFpEdms3dWVMTE9XMDVwd1VadFlzNlhpNGdxV1FTQVY4Y1NpblBEeVJBclhZ?=
 =?utf-8?B?S0JKdTBiSm5wWkdyeTlUUzhIbitDcEFNV25OSksvYzQxWmI0WCs5RE12QXIr?=
 =?utf-8?B?R2lVejFqb1RlenpZUlJ0ME9hQVJXWlBiSWdUdVBnR251b3U1d2VHK29BQUNq?=
 =?utf-8?B?YkNGK0FQN0pJL0kxYWQwN3RibTQvV0c4SGFxYkI0M0l1MVlKWjBPeXNxa0p5?=
 =?utf-8?B?SlkzTEdxbnBFQ0k1ZUlKMHFCNit0U0k3UENUUVk5RFpTZnEvdDlhalNxTXZ5?=
 =?utf-8?B?YytQTXZXeldaOHVPaFM1VDRxaXJFbC9zd1hmb01TMG82OWJ4UE1ialJvSngx?=
 =?utf-8?B?NlNIdk5pWVhFUDFCQkl2R2VrTjBhL3kzTVVnSG9PcG95OWJjckkvTG9ZT3lQ?=
 =?utf-8?B?TWRNamNqSTFoZXRYbHNHejUra0kwd2VIY0FUenBlai9JUnpnVUhjWmJFd2Rh?=
 =?utf-8?B?Sy9MQUpib2pwSzVpZ09VdEVTN2NEQ1pvRW5SbXptdjY1RGNWZ2NkQTJOck8v?=
 =?utf-8?B?L29ZbEF6VWVhd2o5ZWMySmRudmpoY21DeEJSbFFpWWJtVzhsMlIyM3UxeEFv?=
 =?utf-8?B?SnVGZ3pNbG1Pb3d0ekNWdC9GckRHUEJNakFaL2RDckd3TDZoeERWY1RadGM1?=
 =?utf-8?B?RmtpZEdITkpZUlppZG1sZkpXRXpCdEJhdy81NXVsMnhSdDUvdmtqWFA2cDZs?=
 =?utf-8?B?RmpUZ2UzY0puM1J6N3JLbVI2Y21PclZxaU9iYWhNUFlsOHczOFkyZmt1OFFF?=
 =?utf-8?B?aXJkU3R0UWRSeUp1VXNIVXE3aEM4UTJkYmVwd21hWjdWekhDZVZzSEdqaTRS?=
 =?utf-8?B?SldObUM3VlZRdG84OEtVc2NPdDJ0SndMZmZwc0Z4MmxUTHpybWZEY2dYQUlJ?=
 =?utf-8?B?ZThRcEdYKytOd0hITTFqU1NpRlRBbGtGU3ZGM3kyRGRQZW5ISEJlR2grbCtq?=
 =?utf-8?B?WE0yUDdyVjBJUGpualhhN0poN0szdk55T1dSQlBKMFA2cWpoRlpvQ2tEQjhj?=
 =?utf-8?B?K1hVVHprQUx6UWJHZUhTOU44WnRvU2o5enE4TDJjMGhTenVNRDRLR0hEampP?=
 =?utf-8?B?R3YzMVc3UHp5WGpRNjB2UDlTWmNTOG80c01kNGg0c3BHTi9iTUF4NUFqOTQx?=
 =?utf-8?B?aThzb3ZYZ2VMK285SkRaL3BwM1RpOC9uZC90R05jMUhOWENzd3h3K2ptUXBP?=
 =?utf-8?B?Z1NBZmZDSUNtbUIwbkxPczkrZG0yb2JpdUtTQXpLbWROMjdlODRFaVZ5T0lE?=
 =?utf-8?B?QnB5N2hvY0p4dmxocCtmeUVwWFQ2dTZ4UWZiVlZkK2ppUlI5UVljZlZUdThZ?=
 =?utf-8?B?Nzc1bUpWcUt0cUNKeU54eHcxbUMrRlBFdEhLV05pNW9pUkg5c1FDOHlqeDRE?=
 =?utf-8?B?WVVJeFNYQ2QvVW9iOU5zaHRTSDlKTUt1enZYanY5MzM3dEhCUGlRQUU5cVVM?=
 =?utf-8?B?Z1cwMDdTdlJ5dXNlTzBTZXdWUEc4WjYwcDdXaVVsK1FTV1d4bk9CWlFqL2ha?=
 =?utf-8?B?ckVwSUtTNmZSTkIydy9tdlhFb1ZKTUxpZGtUalVEVVp6c085L3M3WE9nNERk?=
 =?utf-8?B?SGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bd59b69-881b-4f0b-507c-08dabdfbc430
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 00:30:25.3381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9tQJ+87bOsHoVEjeH3UpoKLJRSD9xf4JcQEXwwBZLFCzVmatf9U7gYFdD8YXtnL0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2278
X-Proofpoint-ORIG-GUID: LQJaDCAlEfySlPUCDBBHpHQGdjqEx7Z_
X-Proofpoint-GUID: LQJaDCAlEfySlPUCDBBHpHQGdjqEx7Z_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-03_04,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/3/22 3:18 PM, Kumar Kartikeya Dwivedi wrote:
> On Thu, Nov 03, 2022 at 12:51:13PM IST, Yonghong Song wrote:
>> Add bpf_rcu_read_lock() and bpf_rcu_read_unlock() helpers.
>> Both helpers are available to all program types with
>> CAP_BPF capability.
>>
>> Signed-off-by: Yonghong Song <yhs@fb.com>
>> ---
>>   include/linux/bpf.h            |  2 ++
>>   include/uapi/linux/bpf.h       | 14 ++++++++++++++
>>   kernel/bpf/core.c              |  2 ++
>>   kernel/bpf/helpers.c           | 26 ++++++++++++++++++++++++++
>>   tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>>   5 files changed, 58 insertions(+)
>>
>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>> index 8d948bfcb984..a9bda4c91fc7 100644
>> --- a/include/linux/bpf.h
>> +++ b/include/linux/bpf.h
>> @@ -2554,6 +2554,8 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
>>   extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>>   extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>>   extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
>> +extern const struct bpf_func_proto bpf_rcu_read_lock_proto;
>> +extern const struct bpf_func_proto bpf_rcu_read_unlock_proto;
>>
>>   const struct bpf_func_proto *tracing_prog_func_proto(
>>     enum bpf_func_id func_id, const struct bpf_prog *prog);
>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>> index 94659f6b3395..e86389cd6133 100644
>> --- a/include/uapi/linux/bpf.h
>> +++ b/include/uapi/linux/bpf.h
>> @@ -5481,6 +5481,18 @@ union bpf_attr {
>>    *		0 on success.
>>    *
>>    *		**-ENOENT** if the bpf_local_storage cannot be found.
>> + *
>> + * void bpf_rcu_read_lock(void)
>> + *	Description
>> + *		Call kernel rcu_read_lock().
>> + *	Return
>> + *		None.
>> + *
>> + * void bpf_rcu_read_unlock(void)
>> + *	Description
>> + *		Call kernel rcu_read_unlock().
>> + *	Return
>> + *		None.
>>    */
> 
> It would be better to not bake these into UAPI and keep them unstable only IMO.

rcu_read_lock/unlock() are well known in kernel programming. I think
put them as stable UAPI should be fine. But I will reword the
description to remove any direct reference to kernel functions.

> 
>> [...]

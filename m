Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92649618D42
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 01:33:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231347AbiKDAdF (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Nov 2022 20:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKDAdC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 3 Nov 2022 20:33:02 -0400
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4E0B2314D
        for <bpf@vger.kernel.org>; Thu,  3 Nov 2022 17:32:49 -0700 (PDT)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A3NKeBD015916;
        Thu, 3 Nov 2022 17:32:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=Kbk6zPvgIQPwT/k+JV3ik/y8MssrXZVqrA0P5rxBMUo=;
 b=C3ctJLDhQDo5c59DFtN2FlnYUnHEfFPCaKwXyOpQ5A2UtTDTHVwo5vPDEIJtY7M1Pxa4
 klClYf10WVM5BeAXm23A3NMzFKmuOoplgoDeiDjB9/wXZ+YVsvsthdslvzcb5zspFeVV
 vk23TmWlxtbsIwakEZa2SGpsGvY82r/YK8+wIIRSdASBeF+1LSt4kHfjYpyoPlDUAbTp
 UIFGEwX3oH4sBvyfAce8JSKzZnybZYuSyA9I/bIOr+BFuKxHO0yB8y0D3F7dmfTTElho
 X4q5jKpa87MOAIkK6ILNsq2M7aRjTf+bWRulagTdtBv9WFRf02XPoIcDT1ial0EsqOKM nA== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2177.outbound.protection.outlook.com [104.47.56.177])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmph2rsfu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 03 Nov 2022 17:32:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cS7FI4cOSao0nwGnX+EhByIGc4ShEgnwxhNSQwK/7FFMXGv0Zwh6V4DXIoyFDgqXaJrVT0e4ES6EfqfuWmBNMt/Xrte4kJ0DxhU/p4YSD/pKeK+8Wel6uBajVU+KIBwOgIwetzL5gdJUQU4rxaINa+gqb40f7dN0+yMHhXLweZzJ7hlmybknD+/3mE8+KEpRfQlz8nuZtwuK8e2e53NbnCe3UZhimtLVK11GQUgS5HTWAgyhL68o2HJstJsiiiN8KonkZGAWNgFjO/r8XuY8QzD0CtJUjTp/22dQNWHk5L9hZehTgMlnb8CIgnwwJ2BuA1+YXc5FkpAxLzaUSGWm6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kbk6zPvgIQPwT/k+JV3ik/y8MssrXZVqrA0P5rxBMUo=;
 b=dDaHkByZpH88s4/V1cd8H1TxW5GAJOQjQ/QCka9rpbB5Wc6TO51gkOk6CbEG9oztSZzgcwaSbHhptqiV/XBlXxiEV/Nl9QZRHq3B5ZTpqzBy2tEFELSTqNmrFHlJ9YbbbmZFhqRH0qkAkeAJhltSnTgOdsdH/4oCbTDiIw8gdViWlX7V29DjmE7/1TaIV0jHmbmoKfBTUeJ33zQAQIwHRRRnui8nEf/NW2jWxeICd/43YUv8OSJ/rAlz8H2/eg1VwDJ8Cblnv+eMc0seWybIpmH6zZxaLdKiAH5cP1lba0yDshBdEtEFFQivy85330AJiymxqVY6fYSfrsde2CQbtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM6PR15MB3339.namprd15.prod.outlook.com (2603:10b6:5:162::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.21; Fri, 4 Nov
 2022 00:32:32 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::1f2:1491:9990:c8e3%4]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 00:32:32 +0000
Message-ID: <a01c3b97-83c9-024d-e616-04156e999868@meta.com>
Date:   Thu, 3 Nov 2022 17:32:29 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 2/5] bpf: Add bpf_rcu_read_lock/unlock helper
Content-Language: en-US
To:     Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     KP Singh <kpsingh@kernel.org>, Yonghong Song <yhs@fb.com>,
        bpf@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072113.2322563-1-yhs@fb.com>
 <CACYkzJ6ASmpYPmenN6NMpThiJiXF2ggQR+sjaE5DATRFTp64eQ@mail.gmail.com>
 <7916c4e0-2957-f05d-a69b-fe74ae8a264c@meta.com>
 <20221103222943.6wksva7pavt24o7a@apollo>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <20221103222943.6wksva7pavt24o7a@apollo>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0006.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::16) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM6PR15MB3339:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b312bed-8b2c-4a03-1345-08dabdfc0fe4
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: HvIBQiqRgHWI4NXidhlNI/iu0kJuqYoBxiLA8bMsPrOFkH42qXxth6zgWrQrEfQMmZFxPA5cOU1kHIWLRfpDt5KX84BEG26R1stQZ4BcCrhQOMa/GsmYlbdYSPcrIIHy9ZcWGosfgdPwdh4uTk6LhYsUgz1PE2uBn20s4eMZxjTq0q+6h7fTirIR+3U6uA8r23GHioaZ8uLvrbfeqQj1W8mFCjQTXOH4A29W7v1O1NysEpvSA8UEZjzeL4O9LMPsWG/b8owQtCcNGqyytPVcGKdtw7n0CbZqZ4ApLF7nIqe8HBcuxvvrilpKWw48UhNNvYmuVSq0TT1xQyNy8kFQk4qiuyf6FHSk9N9T5si6l8lRBV/z6gUL9fbBdUUcfzcKniu5edGSvsNqpRY5ZXIhsbBO689p9D0a6tAWOlT7E+sv7HFgRdP7pNpzxxtiFgq6NAka1j0uGKfgkKzTa1H3/UXpGNibMQnZOa1823t/B5KHO6vtcY0NKnpdgEttcQMxR5yN/fTql8+W7qap1wf2KQAnHN5riqmQN02bI3NhPsVjkWdQxMHpkg3Pg0eGnPl1gNMtWoXx/FNd5us/oXUJBtrHR0iwzZIMUI7/3LBLSm/Yhbb9ppiB2wwbOadS4OHroC36fZ9eRGJGWBE7XZzN6ABQphJ2jx3XVPdZ7K+HyY8Kf5AdqHcu/zsjiweNh3SUFP3sqr084kMS5GnLsxl4/u2KufnulvZ8NKaeX82EEvz111f2Ya9ZSlTGcw4IZ+gei9phZ+YbBw538hWf5Acxh90q+jgo5WIe1fBDfyCRDb4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(39860400002)(366004)(346002)(136003)(451199015)(6666004)(8936002)(8676002)(4326008)(66556008)(66476007)(5660300002)(66946007)(2906002)(31696002)(86362001)(36756003)(31686004)(478600001)(54906003)(6506007)(38100700002)(6486002)(6512007)(2616005)(186003)(6916009)(53546011)(316002)(83380400001)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K3hacWRacGhXZElZT1VQSEV3UEczcFFibHQ1dFc2YTZCcGhJeDlZYzhaeDNP?=
 =?utf-8?B?L3Fua3dyYVViTXE1WHVtb3dHU3ByTVYzM3kvcklDMXQvbm5aQUI5QmkrbldQ?=
 =?utf-8?B?Tk0vNnQwaFpIWXNsOUpMdlhWNThwb1hNMU5lY2hNRGtxNlczbVRCTFFVOVNJ?=
 =?utf-8?B?dWFVc0QrNWRqN1A1YnQ4V2VweTdBcXRaZkZPemJMYllZbStBUWZ4OXZMVzNq?=
 =?utf-8?B?d0kwRkxaWCt3RnVtY1BMRUU1dmhCYnRHdkphWml5eUJPRld4WGxpSFV4anpB?=
 =?utf-8?B?OWRCL3VxZGpYamd3MFAxSFhHN2lLeFYrRDNvR0JDTUw3aTVQbDlDT3JRbzAv?=
 =?utf-8?B?M3ZMbzhscVludTBpMi8wS1lXc2JwbFNQOUttQUNVNkZtUSttWXUvTjBrZGFk?=
 =?utf-8?B?dDhiczJJSHVOaTN2REUvZjlZVkcxbXRuTnQ4aERQY1pzZVpXNkdJMXoxVUMy?=
 =?utf-8?B?L215dEpCT3RNaDIrRGZkNUpGYWNrN0pyckdOY3lSaGxMSEh5TDExd0F5dlhX?=
 =?utf-8?B?YXlTRmVwMzJ3UEZVVXk0ZGxhRWJmU2laaVZqTlhybmY4emhkbHdtQ2VJeFcy?=
 =?utf-8?B?NkVxcmZ0bEFyQkovLytKaVZQMXVSY0N2WlJ2MDVDRE5EVGxOUDk5clVGOXc0?=
 =?utf-8?B?cU1TenVZbi82M3BjWS9zeWFLTlFQMkFNclRYZyt3aHpGYjlHRThOT3lrOXZE?=
 =?utf-8?B?eGh4ME0rWTd3UmVNVUFxaFdGWGFtQUZyUDZTS3FsWU9HbW9vNzRvKzBGV0k1?=
 =?utf-8?B?TlpuZENSQk9ZTXpQajNZMWJudGR5YmpxUUQyemhXcWhFMTdHWlRDUjJDbGlo?=
 =?utf-8?B?SlUyb2NraXYyc0h3VmhLRW9HSHB5cFV5OWgzcVh2SENyS2tDMEtjS1JtUjhl?=
 =?utf-8?B?WFRzR2JmOVJsdGc4elZpNEhsblU0KzJEOG5SOXNtRnNmMUFjelJlLzY5c204?=
 =?utf-8?B?bmxnbktYaGR2Q0IyUWtsc1d5a2ZLRksyNnpnVndUdy9FMVNVclRrWVNkUkRh?=
 =?utf-8?B?UTB1cDZyMzY3R0pWalpENjRqMGlFQVdzd2RSUDBvSTBnMkx2Rmo1MThxdC9j?=
 =?utf-8?B?NUh0QUQ1VG1JdmV0aVpHTjFCcHB4K3pjeWJmeVhOQzIvQkIyNXdNU3VQQm1J?=
 =?utf-8?B?TngwdUVyQmduT2tnSEZmR2ZISDlSZmFOQjNFVW1EUWFTaW9uZGNIMVdCZ3Rv?=
 =?utf-8?B?Umwwd3QwZmd3amRzTmdVb1ZyVUc0b2FnSFJBdVorVm5JKzlMbzFIanIzeU12?=
 =?utf-8?B?TTFxSG5sT1p4cXlvWEg1by8zN201VzVmcnpkeXh6RXFyYWRsOGRpcTVhcHVR?=
 =?utf-8?B?VXlKSDZ5OVFqT3FoV2h3Q3g4amtadllIVDMrVy8yNzJpbTVBV1VrWjFSNHkv?=
 =?utf-8?B?WE9ZR0ExdzNRYkJrMTgzWGt3NWx6YkpSNjNRZmtUNnFFWnc3eGx4V0Y4cXFv?=
 =?utf-8?B?cmZHYWJWSDRwMDhNU0RSd2dkTjJBZk5FZmFGTExjUnRhS015VTlyK0MrM0lM?=
 =?utf-8?B?cVpneHdEbmRMODZPZFlaVGVubWdTSXE5M0Z0VzlsVmJRQXZ4dlFoYkZYR291?=
 =?utf-8?B?RUVDN3NCU0RwWmhaaEJYODg3clJyZGErTGl0dkVOYURFaElRUVI3RFRMV1hu?=
 =?utf-8?B?Ymh3NUxLanc4MlZDTk9WakZka0RPdFRLclUzOFJ0bGo2SDRESDFGS0dTVnI5?=
 =?utf-8?B?b3ZtcHE5MmN6b1ZTT0lrUkxHYlJVbzh4WjN5SDZENFZuRjBIWVU1YWZUOU1M?=
 =?utf-8?B?bE5IWWlpei8rSzBldGNYcVFpU3UzcmgrRnBpdW5qNzBSQThtTWZaTmdLNmhX?=
 =?utf-8?B?YW1kSFl6NHNBOWVTUG5NYWk0ZE5WUzZaVmFTczd5a2hGMnprUDNDZUUwMUJm?=
 =?utf-8?B?MDJxclk1TFJLcFpiMEJoTUFXQThkdk81K3lMSTc1bUowMXJ0ZWdpTHdJa0Zo?=
 =?utf-8?B?TVE5VVlPd0ZHUXZhaDM0K0twL1E2dWpzeXliRHBwVWdWeCsrNmlKT0JsM1Bj?=
 =?utf-8?B?amJJd0hia21JQXJWclRBa1lBeXVNbk16SEJXV1ByMFdEdDQzWHZxR3piMWFx?=
 =?utf-8?B?Z2FHU2g0MEp3V1B5SDBFZlBjNUFhWGJoQ00xenNaSXBvaU51R0VyWmhHUU9o?=
 =?utf-8?B?N2VjYXdFYU5oL3NIWnlXMUVjSUNydkJ4WVBTTFNpR0QxcEZZYWRHM3pYRW5W?=
 =?utf-8?B?TVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b312bed-8b2c-4a03-1345-08dabdfc0fe4
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 00:32:32.2985
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YTItzn4OlwCVrjiyFVr1OFtxto31AWccN1tTihTWzTcaj0pj+PcDn+9VuOjUiZrj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR15MB3339
X-Proofpoint-GUID: dc4WTcYW72gFxW_OpfjUkI681OdqcOWB
X-Proofpoint-ORIG-GUID: dc4WTcYW72gFxW_OpfjUkI681OdqcOWB
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



On 11/3/22 3:29 PM, Kumar Kartikeya Dwivedi wrote:
> On Fri, Nov 04, 2022 at 02:30:55AM IST, Yonghong Song wrote:
>>
>>
>> On 11/3/22 7:28 AM, KP Singh wrote:
>>> On Thu, Nov 3, 2022 at 8:21 AM Yonghong Song <yhs@fb.com> wrote:
>>>>
>>>> Add bpf_rcu_read_lock() and bpf_rcu_read_unlock() helpers.
>>>> Both helpers are available to all program types with
>>>> CAP_BPF capability.
>>>>
>>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>>> ---
>>>>    include/linux/bpf.h            |  2 ++
>>>>    include/uapi/linux/bpf.h       | 14 ++++++++++++++
>>>>    kernel/bpf/core.c              |  2 ++
>>>>    kernel/bpf/helpers.c           | 26 ++++++++++++++++++++++++++
>>>>    tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
>>>>    5 files changed, 58 insertions(+)
>>>>
>>>> diff --git a/include/linux/bpf.h b/include/linux/bpf.h
>>>> index 8d948bfcb984..a9bda4c91fc7 100644
>>>> --- a/include/linux/bpf.h
>>>> +++ b/include/linux/bpf.h
>>>> @@ -2554,6 +2554,8 @@ extern const struct bpf_func_proto bpf_get_retval_proto;
>>>>    extern const struct bpf_func_proto bpf_user_ringbuf_drain_proto;
>>>>    extern const struct bpf_func_proto bpf_cgrp_storage_get_proto;
>>>>    extern const struct bpf_func_proto bpf_cgrp_storage_delete_proto;
>>>> +extern const struct bpf_func_proto bpf_rcu_read_lock_proto;
>>>> +extern const struct bpf_func_proto bpf_rcu_read_unlock_proto;
>>>>
>>>>    const struct bpf_func_proto *tracing_prog_func_proto(
>>>>      enum bpf_func_id func_id, const struct bpf_prog *prog);
>>>> diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
>>>> index 94659f6b3395..e86389cd6133 100644
>>>> --- a/include/uapi/linux/bpf.h
>>>> +++ b/include/uapi/linux/bpf.h
>>>> @@ -5481,6 +5481,18 @@ union bpf_attr {
>>>>     *             0 on success.
>>>>     *
>>>>     *             **-ENOENT** if the bpf_local_storage cannot be found.
>>>> + *
>>>> + * void bpf_rcu_read_lock(void)
>>>> + *     Description
>>>> + *             Call kernel rcu_read_lock().
>>>
>>> Simple wrapper around rcu_read_lock() and maybe explain where and how
>>> it is supposed to
>>> be used.
>>>
>>> e.g. the verifier will check if __rcu pointers are being accessed with
>>> bpf_rcu_read_lock in
>>> sleepable programs.
>>
>> Okay, I can add more descriptions.
>>
>>>
>>> Calling the helper from a non-sleepable program is inconsequential,
>>> but maybe we can even
>>> avoid exposing it to non-sleepable programs?
>>
>> I actually debated myself whether to make bpf_rcu_read_lock()/unlock()
>> to be sleepable only. Although it won't hurt for non-sleepable program,
>> I guess I can make it as sleepable only so users don't make mistake
>> to use them in non-sleepable programs.
>>
> 
> It's better to let it be a noop in non-sleepable programs but still allow
> calling it. It allows writing common helper functions in the BPF program that
> work in both sleepable and non-sleepable cases by holding the RCU read lock.

yes, I can do it. The verifier can rewrite it to a nop for non-sleepable 
program to minimize runtime overhead.

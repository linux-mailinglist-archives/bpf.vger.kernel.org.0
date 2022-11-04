Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66612619B94
	for <lists+bpf@lfdr.de>; Fri,  4 Nov 2022 16:27:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbiKDP1r (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Nov 2022 11:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231921AbiKDP11 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Nov 2022 11:27:27 -0400
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1548F2C123
        for <bpf@vger.kernel.org>; Fri,  4 Nov 2022 08:27:25 -0700 (PDT)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 2A4EawCG012773;
        Fri, 4 Nov 2022 08:27:10 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=r/rf7/FrY1y464WAHRdNj7W1kHYwekh90o7l0BfUoBc=;
 b=Vq9v/q43nbmq2daoN8gc0+UgUbDpqGgONQfLSKgkyXXJGljiNrVBHv3HUb1U09UaKcAl
 EHjNKDwkcRlEW5eanz4X5MlDIH8ePN87P8XQ+7z54Nb5vaAQYqZFKGex5yR7dr6Cllgf
 h190ZB+eR9fUWVn6XniSjV45tIiEcedAAU0owLSZvIRNz22TFYnPmzQlwJposUCKxw1O
 DbvAU+yLIHF4mDxHmA+zT3q+hG/3GznufwX1E9zZ3imGaX3BTVctEarawA6azSxtaqaY
 p1I/0ATgXDkAvcqsomsTT/QtHO6JXbN5B1mNPrm6pXVGbtunjd4zOpawA0aiuKAfG9oz pg== 
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kmqbne5xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Nov 2022 08:27:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R6sSGt59rhpqyZA1z9WxHH6f+V96EwhmCP06OiP4FmCEW3kOI8Nspym4BnCfeT6QrLSeEBbBwFYGLJbzNyqXRYpypOnKp7zopKkRIDIl6k7UxrMOTekt3Ix79Kn1+r8+h6ooerZ2LY6zYvkiDZNdySuua2dClNwdSl4WZcwu/g6N1mn1HQ4MKLjAk0F28fk0JY+5mlzEGSy7slMHUjRwdZ9KCaGRGuCLDSjnFC+iZ52uaF+z9+4KyxxaMED/vZbey2fPcdxDOo7B7tC8HSSg+C26rbqqu7Kqvq26XUMx4yhzG7QEieJLOOJ/rrDbsSNbQQRqnzaeOosHqsjxK4QTnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r/rf7/FrY1y464WAHRdNj7W1kHYwekh90o7l0BfUoBc=;
 b=LB+cPsz8remw5mdc+hK95S5lnML8fopWmaEFTeWck75KNpOf/aeJYhHJ6mcRnDlyymW91E+P3lCLdaiGEYHxWashuJaRSAnr4p2eBdZXCQXNkY6Q30vVT4YcEbF9RR9Jr5weBganv/Y6ov1za0DeTERSOgWl7hLmWqFJgGCpNcBWOcbWpnk8wLlaRHTWlBY7m48axc2fHg3iTSQWZQguDSES9+SfVz1Osz3rFpBrO9lEPXsXMLSlMumD3MtFroEfRDZFfe5oTPudRx1EgW94AFFXqywteOAuMenb6G/nRddBpn91o4MUakRU3MuSiCLJDUX00rVpod7gyGR5gt2+KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from MW4PR15MB4490.namprd15.prod.outlook.com (2603:10b6:303:103::23)
 by BLAPR15MB4033.namprd15.prod.outlook.com (2603:10b6:208:27f::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5791.22; Fri, 4 Nov
 2022 15:27:07 +0000
Received: from MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::c42b:4da0:5bf4:177]) by MW4PR15MB4490.namprd15.prod.outlook.com
 ([fe80::c42b:4da0:5bf4:177%5]) with mapi id 15.20.5791.022; Fri, 4 Nov 2022
 15:27:07 +0000
Message-ID: <429dc3c0-f7f8-6d4f-16ba-63042d9f0487@meta.com>
Date:   Fri, 4 Nov 2022 08:27:04 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH bpf-next 3/5] bpf: Add rcu btf_type_tag verifier support
Content-Language: en-US
To:     KP Singh <kpsingh@kernel.org>,
        Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>, kernel-team@fb.com,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221103072102.2320490-1-yhs@fb.com>
 <20221103072118.2323222-1-yhs@fb.com>
 <20221103221715.zyegpoc3puz6oimx@apollo>
 <CACYkzJ6m_H4cq=7SgYcaoYE9qGgquEh6FPHe9Kpr=j-DUCnvXg@mail.gmail.com>
From:   Alexei Starovoitov <ast@meta.com>
In-Reply-To: <CACYkzJ6m_H4cq=7SgYcaoYE9qGgquEh6FPHe9Kpr=j-DUCnvXg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR13CA0033.namprd13.prod.outlook.com
 (2603:10b6:a03:180::46) To MW4PR15MB4490.namprd15.prod.outlook.com
 (2603:10b6:303:103::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR15MB4490:EE_|BLAPR15MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: 21b2150c-2fd8-47cd-ee08-08dabe7908bc
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bfJDGfjZ6PQM905iGCNrISecb5f0bIRNeQNVodMGkRRn9ON/60JdEYDauaReCNWNT4iuCggS1XixBurNZP6/jiRb28bGrwcAttlbjHZKY6D2CN+DP+B7IsPjI7osn9yXBE2AoybI/8Km3yA3uauZEPm1NgokOcyh1QbtV+hVk0h5MelXkowOw1V9UnX9DmP09wBt8IJNiceNpb7Txa3zVHxwNT8sdhyoHtepBbM8oYTNpWXdnSpJG9L89220Rek4zj1Ke9os01DKNcU3I6/H7XOCpOUOOQITY2yQeePiXubNT2T2bgGhf3mdZo/THefex9b3DurQC75I3KUx2qspAPEXRd1A8bXUCJ/QWGMH7ix2id7QvITglqiL9RJWQ8oDHMVqoO5KKUc9N0nV6i6bV921nkt3lWXVBv8H++/u4LViQETjxSzXUl0bJ11o0rEmZPxbDmt/QkbjiZU+QlHhIpfNuCh1oXmwNuuYw4EcvMy3ERnk2hI/6aYJvi62tX6141wYh4W2fxI8DMRqXwJ7PrbS7X3XpPBjxW45QlZJPbcT7WbC4emKJPeVAGZRM1iRY20X+LOGIVJKBZojGJRp60nx6Ts2xOH6dKbc5KUehignb41ZefK8w+BMfTqE61tlCYIeIYLEARzJv+IANY+NeY4KKMY25LKOKc5q8FA72YzUkynjzmAC1jyIvenD6H0196OYsuXU/rf/iu2HlhI4Ch7WKD5yXRjhOI6wPhYqFDt3JbO6BhbL7QuFM9T65SHHstMEkpVa3nPqo0evjpUVr65E+VpIy/P5L7hqtiiGcs4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR15MB4490.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(376002)(346002)(39860400002)(396003)(366004)(451199015)(86362001)(36756003)(53546011)(6666004)(31686004)(316002)(8676002)(31696002)(38100700002)(66556008)(66946007)(6486002)(6506007)(54906003)(4326008)(110136005)(5660300002)(478600001)(2906002)(2616005)(66476007)(186003)(8936002)(83380400001)(41300700001)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YUdkbGhDSkswbVR1akJaL2d2VHVuN2wwb0QweXBGM2g1MTB1M3V3bUxBcTBC?=
 =?utf-8?B?RjVvTUlTWXFPaXpqQjVBZnBoZmsrR2Vyb1VXc3JiVDEwQkJyNlphOXBDenlY?=
 =?utf-8?B?NmxvYVBVakdVZnV5RnJleHBZNHV6YS9oc1FWQ0x6T25kTzZPbHZsSUV5S3pZ?=
 =?utf-8?B?YndRd1NkK2ZhMDAzSVpDOW9qSUFjTVY5T29YcFdpY0JrOTVGWis4S3NXaG9N?=
 =?utf-8?B?TzJFWDhSU1NRczZIUnY5dTRJK0xjTnhCUnJucld4cCtGVUtBb1lCNVNEcFR4?=
 =?utf-8?B?a1A5N201YUI4YjJpbXllMW5Ea3ZKeWl5bFdrYzlXYU9VRzF1NWdnQi9ScHg0?=
 =?utf-8?B?cHFtNTRPcWtOTk9YSkFvTmgySldmUnNpaWxjdUdTV1VmZXUyWEJIV2hIZE1h?=
 =?utf-8?B?VGwvZDI1RXRuU0xaTmJmQksyaElyZktZNU1yaXhoSU40SXBVNTdzNVN1dXBM?=
 =?utf-8?B?bEtaaW16alZMRzFTaENKQktYSDFncmJzMmplK3BmbE5BRllRY0xnMEFiSkJV?=
 =?utf-8?B?dWxyR1UrTHFvR0s2VmRiTXVXaVdCcjJYVTJ0VFZ4SVRiNnNGZWFVSmtET3Qr?=
 =?utf-8?B?VitCMmQ2cU5PaUpwRjZ1Tlo4enVzZFZVSGtoWWZiekppVkMwL1ErdWtCaFk1?=
 =?utf-8?B?T3Juc2lUS0FzNlgvRXhaeTgxNllkdDR3Ukh5ZmRmUldBVDFZVmU0d0FOR3VL?=
 =?utf-8?B?U0tlT1FjUTdEbTB1bSt3RXBPVEp5VjIrakl6NkVwY2JqeVQrNlR4Q2xUNWJF?=
 =?utf-8?B?Ykt4UVdFMGhpZm9QNTYzYnBvR2xTejZnbUx2ZmtjRUdQZ1FhZTI4Y2N6ZmRT?=
 =?utf-8?B?a3RYYUFuRnhXYUc5dy9hYXYzQU53NnI0WDdLMk9ZdHg2Kzc4SnBta1NoNlc5?=
 =?utf-8?B?NHNuU0x0SHNnbTRUMG1pQlBGMzUyT0RxSzVSWFR6aSt3Y0hWWWFzVXZadlVr?=
 =?utf-8?B?RVNrMUpOZG1uQzdsVjNSN3VQVTlYcjkrL1E1ZEkvcGEzeHVLU2k4aWsxTVZM?=
 =?utf-8?B?Qk9Na3RvVFcyTE9qbkRVOVdVMHo5MTJQMkZ3U3V5elZjc1RHTjdNaUYvTFRS?=
 =?utf-8?B?NVhOaEFRcUJ6V3luWGJscGpqSEcyOU8zbnZwN3NMMlBRUnJYT2dFK3FXNFNC?=
 =?utf-8?B?RFEreHduUjRLbk04ZFlFemJmWUh0RjBmcEw3RkJUN1NQYWNTMytkS0ZDQVo0?=
 =?utf-8?B?M3BDbEIvYnJxUVFmYTNDenkxS1lDaHRLVEkzNEs0YU5ITWZoUFg3TjRBcFJP?=
 =?utf-8?B?RmNRN0ZNS1Eya21OZWYyYWFCR1lMNFhQalJuUXJnL0xkNU9ralZwY2NDRm5O?=
 =?utf-8?B?S3ZqeDN1Ym84czdTUWh2M0xDeThoSzBpSExYOGYxWXRUenpyN1ozZWVhRHhR?=
 =?utf-8?B?dnREK2tLMzl2WEFoVVpHRmtZTHBwOFRzU1h3bjBLS2RTVkh2dXFDcXREendS?=
 =?utf-8?B?WWR2L1h1Vm9KVHQrS2pKK3hXamx0aENTNjJzcXl6SVlhblB0eUdSVjZRdzNI?=
 =?utf-8?B?M3ZLYlVqYTBKbkswK1locDVKUnhYVkZBS2VFdDk5V1h4aDdWYTU0QmI0ekNr?=
 =?utf-8?B?NGFhRFVOenRlSXFWMEZCNTkyQXBIQ1N3TnJHODd6TjB0T3djWmk3ZDYwTmV5?=
 =?utf-8?B?OUduUmtVNkZveTEvOEJtQnQvUWN1ZzdKNFEyUDZqS1FWR3FTWE1icWdBRWUy?=
 =?utf-8?B?Nys5WkNMOUJwVmJTNURNR21MRWlrZ3YySzJXN3FLM0VLSEkwL0dUSW1Kem1X?=
 =?utf-8?B?THVKWkduVndRbk83Mmw0TW9qU1NqN0cwTHRadTFuUldSQ2YzaHFwY2FjV2lk?=
 =?utf-8?B?VzVueFVOUk1PRWtWajNxTXZQcmhtbk1MREFMNDRXNG1xamlCY1NBRVhKR3ZY?=
 =?utf-8?B?UDRheWU4RytrY3QzaWJMSVRsNk1XZzhFNS9ramJHL0VpSTJvaUtOWkI1WWkx?=
 =?utf-8?B?NGh5eGF1THU5OGpaUGhIYjNDWERXMjF4ZWoyMnBrb3d0UDNRdkVxc0xvL1VX?=
 =?utf-8?B?eXVTTnRFWThIajg5QzIwVHVoYkh4REhUeVVmUUR4TE91SGtxSC95a3IwbUVk?=
 =?utf-8?B?aWVQSjhZckk3SU85T1JMZGFJMFJrV0VpRnhFWnRMVlVlL3BZSlV6cFJjaGdC?=
 =?utf-8?B?QkxQdGFFd3NQY1JiSjdHNmhQVDl2ek1Cdit5WnVoN1dwMC9mbzROMk0xalZU?=
 =?utf-8?B?Q2c9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21b2150c-2fd8-47cd-ee08-08dabe7908bc
X-MS-Exchange-CrossTenant-AuthSource: MW4PR15MB4490.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2022 15:27:07.4828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HZ9Ge1h34tXULDMgHxbCRs1aYBzNwdvYfSe+YkOINYmkdjLMtPwH3nWv1/xNRhA7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4033
X-Proofpoint-ORIG-GUID: J_E223jS0oxuSWyEjoHfIr6h_pQpSp-g
X-Proofpoint-GUID: J_E223jS0oxuSWyEjoHfIr6h_pQpSp-g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-04_09,2022-11-03_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/4/22 5:13 AM, KP Singh wrote:
> On Thu, Nov 3, 2022 at 11:17 PM Kumar Kartikeya Dwivedi
> <memxor@gmail.com> wrote:
>>
>> On Thu, Nov 03, 2022 at 12:51:18PM IST, Yonghong Song wrote:
>>> A new bpf_type_flag MEM_RCU is added to indicate a PTR_TO_BTF_ID
>>> object access needing rcu_read_lock protection. The rcu protection
>>> is not needed for non-sleepable program. So various verification
>>> checking is only done for sleepable programs. In particular, only
>>> the following insns can be inside bpf_rcu_read_lock() region:
>>>    - any non call insns except BPF_ABS/BPF_IND
>>>    - non sleepable helpers and kfuncs.
>>> Also, bpf_*_storage_get() helper's 5th hidden argument (for memory
>>> allocation flag) should be GFP_ATOMIC.
>>>
>>> If a pointer (PTR_TO_BTF_ID) is marked as rcu, then any use of
>>> this pointer and the load which gets this pointer needs to be
>>> protected by bpf_rcu_read_lock(). The following shows a couple
>>> of examples:
>>>    struct task_struct {
>>>        ...
>>>        struct task_struct __rcu        *real_parent;
>>>        struct css_set __rcu            *cgroups;
>>>        ...
>>>    };
>>>    struct css_set {
>>>        ...
>>>        struct cgroup *dfl_cgrp;
>>>        ...
>>>    }
>>>    ...
>>>    task = bpf_get_current_task_btf();
>>>    cgroups = task->cgroups;
>>>    dfl_cgroup = cgroups->dfl_cgrp;
>>>    ... using dfl_cgroup ...
>>>
>>> The bpf_rcu_read_lock/unlock() should be added like below to
>>> avoid verification failures.
>>>    task = bpf_get_current_task_btf();
>>>    bpf_rcu_read_lock();
>>>    cgroups = task->cgroups;
>>>    dfl_cgroup = cgroups->dfl_cgrp;
>>>    bpf_rcu_read_unlock();
>>>    ... using dfl_cgroup ...
>>>
>>> The following is another example for task->real_parent.
>>>    task = bpf_get_current_task_btf();
>>>    bpf_rcu_read_lock();
>>>    real_parent = task->real_parent;
>>>    ... bpf_task_storage_get(&map, real_parent, 0, 0);
>>>    bpf_rcu_read_unlock();
>>>
>>> There is another case observed in selftest bpf_iter_ipv6_route.c:
>>>    struct fib6_info *rt = ctx->rt;
>>>    ...
>>>    fib6_nh = &rt->fib6_nh[0]; // Not rcu protected
>>>    ...
>>>    if (rt->nh)
>>>      fib6_nh = &nh->nh_info->fib6_nh; // rcu protected
>>>    ...
>>>    ... using fib6_nh ...
>>> Currently verification will fail with
>>>    same insn cannot be used with different pointers
>>> since the use of fib6_nh is tag with rcu in one path
>>> but not in the other path. The above use case is a valid
>>> one so the verifier is changed to ignore MEM_RCU type tag
>>> in such cases.
>>>
>>> Signed-off-by: Yonghong Song <yhs@fb.com>
>>> ---
>>>   include/linux/bpf.h          |   3 +
>>>   include/linux/bpf_verifier.h |   1 +
>>>   kernel/bpf/btf.c             |  11 +++
>>>   kernel/bpf/verifier.c        | 126 ++++++++++++++++++++++++++++++++---
>>>   4 files changed, 133 insertions(+), 8 deletions(-)
> 
> [...]
> 
>>> +
>>
>> This isn't right. Every load that obtains an RCU pointer needs to become tied to
>> the current RCU section, and needs to be invalidated once the RCU section ends.
>>
>> So in addition to checking that bpf_rcu_read_lock is held around MEM_RCU access,
>> you need to invalidate all MEM_RCU pointers when bpf_rcu_read_unlock is called.
>>
>> Otherwise, with the current logic, the following would become possible:
>>
>> bpf_rcu_read_lock();
>> p = rcu_dereference(foo->rcup);
>> bpf_rcu_read_unlock();
>>
>> // p is possibly dead
>>
>> bpf_rcu_read_lock();
>> // use p
>> bpf_rcu_read_unlock();
>>
> 
> What do want to do about cases like:
> 
> bpf_rcu_read_lock();
> 
> q = rcu_derference(foo->rcup);
> 
> bpf_rcu_read_lock();

This one should be rejected for simplicity.
Let's not complicated things with nested cs-s.

> 
> p = rcu_derference(foo->rcup);
> 
> bpf_rcu_read_unlock();
> 
> // Use q
> // Use p
> bpf_rcu_read_unlock();
> 
> I think this is probably implied in your statement but just making it clear,
> 
> The invalidation needs to happen only when the outermost bpf_rcu_read_unlock
> is called. i.e. when active_rcu_lock goes back down to 0.
> 


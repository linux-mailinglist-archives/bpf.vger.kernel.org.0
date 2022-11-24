Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 251386371B1
	for <lists+bpf@lfdr.de>; Thu, 24 Nov 2022 06:16:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229479AbiKXFQ4 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 24 Nov 2022 00:16:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiKXFQw (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 24 Nov 2022 00:16:52 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FA8CBDEF1
        for <bpf@vger.kernel.org>; Wed, 23 Nov 2022 21:16:51 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2ANHsFW9024697;
        Wed, 23 Nov 2022 21:16:36 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=YIFHocmq5j6L2JKiAv82ctjMzdt1X6bI2pWxL3bNrNA=;
 b=mmIYqVp7o66ICS7kmr+ds9aa4Ksk7nqL+wr5sNe7xlGeXR40cIkvtGsGVDbi1kdAqjn0
 E7kwnYyqPmT7FLQE3jVhLPUcJJMbF9ziAFBJMFzp4Q2+6s+ZaAhcRUjxqqETCVnlMmbH
 +pmpUYv5a2OcW3IQtt8aa6GrA3/klibmS/O4k/FF97xm5IBXW0K4N8VhnqwF49n4O4xL
 GG95s5aK4UdGdSDa1wahOW7pTKyNmI0d6XGKaLkERY9TmyA+Y9rv3PfV3hzjwmRkMAlO
 rM0KxFQHyzwIlMNRzQSoXtt0AsOhsHxGRWZ0z+k3MGb5w48p2NUViK2ZP5E2UHB9r5Ee lg== 
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3m0y4uwytb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 21:16:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JaN+w9w4RJwMmldttdIOTd+rNJimXVV/5d22au3Z5cQLfltbHWr1v8HDI3e8pVsQXyz79hwCgcqI7NUM5jYOOEb8hgn0sfsezqrvxin3zhCLrpDC8+NtVLb8zqODK4hxe0GSMCi0Eivu9219Szsh+V2AHz+PyMSi4nTrFZJfAbPK1pTySG7wHmEYRfV0vB1jXTgBEnlFqeU0O9g4FIW2qTWsVrmKeOZf6B1lXR6SbTw5OWtXEiquHhHc6FsqNNurJI3D6bEjozn3lP0hEhx374kpiwKm6mrDQpa2wLjIzadhtpRgETfRSpTGSi+kBJJuaD1tAUlOUHk2IUwIjIewWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIFHocmq5j6L2JKiAv82ctjMzdt1X6bI2pWxL3bNrNA=;
 b=jvs4lNWH+h/7faWjq9HsElQaZ7oK6EGqThls32xZgEibPVZN6MhvwhgwptuMUEVYNGMQhH/ltlrEoJqT60Nnjr1EKY+vXPwKmGEOZoDCejl3ZudvOOSJg3xZwfdwxuFQtE6r0yo8A1/MBt4160KhQ7c7DWSWEAglCRMGvS6TYHVUuYnIaiFQRbtpIVbHp/eQJIYmmMHfQjz0VVcmEFCt87HIeFAMM5dTS5epYFpLohAIcG2adBpIM1+T8EiFpfHBmEmG1vGMggpXhfuOYT0vF4f5sD6HOSJ5N7FPwDkVn7yHnsJQQNrqNynSsDs1Xlmx7y6l3sG/JRqUWifRQ0xgLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by MW3PR15MB3993.namprd15.prod.outlook.com (2603:10b6:303:4e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 24 Nov
 2022 05:16:33 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::ac66:fb37:a598:8519%7]) with mapi id 15.20.5834.011; Thu, 24 Nov 2022
 05:16:33 +0000
Message-ID: <610327cf-5264-a9c6-a0fd-b0d8f26bcd5a@meta.com>
Date:   Wed, 23 Nov 2022 21:16:31 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH bpf-next v9 3/4] bpf: Add kfunc bpf_rcu_read_lock/unlock()
Content-Language: en-US
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Yonghong Song <yhs@fb.com>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Kernel Team <kernel-team@fb.com>,
        Martin KaFai Lau <martin.lau@kernel.org>
References: <20221123045350.2322811-1-yhs@fb.com>
 <20221123045406.2324479-1-yhs@fb.com>
 <CAADnVQJGx=8Hdd_fzV=jt7n_zo9GwG5O5a3S4V4JJiM3YpxSkw@mail.gmail.com>
 <37b640ad-7258-adb8-7cec-23ae776f5764@meta.com>
 <CAADnVQ+uoW+G9Uts3B1q=9Qxws3+dmLqUUWSVaeRgRYLvNkkQw@mail.gmail.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <CAADnVQ+uoW+G9Uts3B1q=9Qxws3+dmLqUUWSVaeRgRYLvNkkQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0038.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::13) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|MW3PR15MB3993:EE_
X-MS-Office365-Filtering-Correlation-Id: 986fca4c-25f2-44ac-dd98-08dacddb0d8f
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LjLCWPa5eyorfxXxv5MqTWfg2My8vcLWS2soy6artmz+ThCuhHmaduImhVYnO3TV6weFRDr2Ovz6vsu6iASpryA1W3AJx6lqgCSbPkDHa6krxRloQ7/YnbT2MzKtuzT0/fgu3V6GEZk6F32E5IgiOxN6YZ0cTibfyRlpDJiU/R8u53qhpoWTaHI61d3eMjNnq7EP0lZJg/hIOT+I7RWmR/m3fUKDBqhTHYW1Cs4aPMYCn0uWHp+yXGGlu8FBj+rrW83cd/a/TFToQsdCtfwZuzGdob3ViOv2LMlZBu5GQ3pFG57bm9rfZoyqf2WGbVdmrh9rxT/yWsxKYsG96/EJ7wDhFLyxaXONQDaRm033rJ8z7/1csTIPhNpe3xFnngo4gZE9k/g9TaSqlF4cjg/Ct6QKB7pHXYVulRb/UH7Jc4pyzJto2xbh2CmxDAbRcRSJ9lBm0j571oPSjMjucFb5rdJjUD0JNvNdoT6S4lDL+GmeAvlVXhT1Cv07lA4tCBnZ4J71r9vMu3ekSVlG+ivdjukaq1kNl0hbcvbmwDWXj8DfYbNL0m1H/eJYv4/7IX5b49m+fCtRgpEBZ8ozKrCGX/YsswiIuzG7gcrTMsQTol6ves3jGf8hyrB73b3uEhnT9gfMISyWvcyr+SsFuMvLfdPlHqeA/HC8yHT+uRuj16n3LcMO4Y/CH6tcAajt5zwaLmvLGGF0QdhOLhYyYcW7HFFzjUq0ugCe6brgFGEX+JI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(366004)(376002)(396003)(39860400002)(451199015)(2616005)(6512007)(38100700002)(186003)(83380400001)(8676002)(2906002)(5660300002)(53546011)(6486002)(66556008)(478600001)(41300700001)(6916009)(4326008)(66476007)(316002)(66946007)(54906003)(8936002)(6506007)(36756003)(31696002)(86362001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjM4S2o1QWJvU0RGZXRtbWN5cUxlZmlzajlDWUwrbHI5VkJJVUg4QzNQM2Jx?=
 =?utf-8?B?T1h2VWNFMDZtRmNRL0dXTXRzQ0xBdFAxNHd6SmtWc1krWWgrdGVGNjlhcXRp?=
 =?utf-8?B?b0MyejFXYVB0b01rdFBuSEhuZktXU1hybGp5QkhuR0VxVkZDZGZBMUM5WG1z?=
 =?utf-8?B?dHFVeEFLSWQ2dlg3N0U1Q2pHNHBuWUlzVHhxS0dsUFZiZmRDckUvSmxZbDlO?=
 =?utf-8?B?KzJNc0UxN3ZFL1RCSkVFWXBRMDVSZGcrSnR3YTFDMVBQelczOFg3dWtjNWQr?=
 =?utf-8?B?cys5TzhxTXJZU3BseExzS2owVmVKQTFuaG1QQVR5Mko1N0hmMVQyeTBuc1FH?=
 =?utf-8?B?S3pEWEVKbmIrazExYTZZVEZMS0ZBS3FhZ3M4SFJEQ0YydU9TblZIMEdJT3po?=
 =?utf-8?B?bUN2N256aS9VUXlvRXZNOTFwOThRa3A2SUNxdGdUWTBGZm9QVERZQjBVcWcy?=
 =?utf-8?B?c1lmbXR4c0cwY3dBVWVZaGVBRmE0MDZxbTNVU21oeUlHNWFjZXRQTUZLeHFn?=
 =?utf-8?B?SXNZd0FBSHVoSnVZMnhlUm1WajZrNE04YmllSHZaVHZIZ0FrbkZjNWJrMXYz?=
 =?utf-8?B?aUdmVzk5UXNKZGEvbGNHVC9WeDF4dHNQNnFUaUtEV2pzNzVXbFJEVVplaWNZ?=
 =?utf-8?B?M0ZWUnZCMzdWeFZFRklyZzNKY2U0VmpTZkNuSjZWbkUxUkZZYTNzeGREbEU1?=
 =?utf-8?B?RUFmTlM0WHpza2xxM0EzVjYzVlBlempHekljR2JQK2xQcHdiQmtxS2lVM1VK?=
 =?utf-8?B?SVpza0FCaW9ad3RLTGlzRXZ2dnlybm1uTzgrYyt3R0c0WlNqeENxQnhHZ2N3?=
 =?utf-8?B?K00yeEFWRUxSME5uZXI0TXhPdEZHeGJFTGlMTUhlRXo5TndyVHQzV3BKSVBN?=
 =?utf-8?B?a3F1dzNoZ3lrOFRPMys3SnBJQUluYy80TFZEUDZ0SGVJWGtoeHFHem5GQmNL?=
 =?utf-8?B?SkxFVUpqMzU4a29QZkJUZ29MS2hock8vbGpHNTR2Q0dwUTU5bThLQkd0N0F5?=
 =?utf-8?B?RmFPQitxaDR0MUl2TmJSUzBjTWsySGRRTmliTHNsVEFpYVYvZmRDa0hEUUdN?=
 =?utf-8?B?dWZXbzVBbi9ZQVAySUFEVjR2V3NEMlVkbDJWaGdFQzZmT1htcHppWDBCOFRP?=
 =?utf-8?B?UFhTQ2w2TzVETUlEYUo0d3didWV1c0d5cjMxWVV0aERiMzNnVDNuNjVTcmhz?=
 =?utf-8?B?dVFKbVQ3TUxWNndBYWFMNTBlTnZUU3NRazMyVUZwdkxxcG81QWU3NWMwU3dM?=
 =?utf-8?B?UnBZS0E1b0kxL2FKREFkWmNudEdDNkF1NEhhM0g0L25ncHBiTkVGYWQrZG5R?=
 =?utf-8?B?K1I5S3lja0Jqc3RkUTYrWjdGQWlDSDdtdGhzK21FT002dXFKcXpwL084dE13?=
 =?utf-8?B?SVcrTzJub1poWGx5ZGVSc1A3QkdFRlZrZEpoRVM0UTZnTk10VzhuZVBSODJu?=
 =?utf-8?B?QzFETGpWRWlyYU9lbkp0R204RDlYcnl5RHdUYlZKaVN0ZDNZbkpMUW42TFBs?=
 =?utf-8?B?MmJPcG9KeTNrbkJVWjVZbUlHYmZjenNHUjRFQjdxRTIrdnJiQ1p2VUZEZFNV?=
 =?utf-8?B?dm1GUnFjckRqSW0xOTEweFJNa2hKZWdZaXpoYnNrTUpRSVJUcG9yMWZMNGVB?=
 =?utf-8?B?dTJwQ2pQZmx3dVVLRFg1SXlFeUpQdkU0aEhxTkFSSnVsbU1yZ01BQ1JZdElw?=
 =?utf-8?B?b1ZkaEIzbXJsZkQ4R0cvRVp0bjhRdXZiRjBnY29Od0sycmdadEJGQWkzKytv?=
 =?utf-8?B?MC9LdU15QktSV3BLOWpUaDVPQy9yeHRPVmZoelBwemtoTlRFZFFYamNQcHpQ?=
 =?utf-8?B?LzBWVzFFZDZ0eFdyUkMvM3hJSG8xMjk2L3BJVTh3ZjcxcjBGNUYvZXh0SE5v?=
 =?utf-8?B?WjNZNm9ybUhZbnVzWWVmclVTelN2dEVGSi9FVGFjYVp3Ly82b08zdzdmTjRR?=
 =?utf-8?B?cHVTZm1MYzFBZ0pKbXZpVmR6b2dBRHF4OFZPRysyNGR3WENGdUcvZzk4U1Fs?=
 =?utf-8?B?Y1BYbmQ1TFVad2tPT1NyTUZTUHhVVzhMYU5DSVJCSVhGVmdQTEpqeW0zZ2E5?=
 =?utf-8?B?RVRhdHBxMXFvdTFkUkMrOVRqV1BHUXE3Si9pcDFmT0M5V09KTGpRWGp2b3Fq?=
 =?utf-8?B?ZklGYXRINWNWT2llM1M2Y2V3UDczRGlsanN5Vk9wWElTNFFjOWhFSzY3ejQx?=
 =?utf-8?B?TFE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 986fca4c-25f2-44ac-dd98-08dacddb0d8f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2022 05:16:33.6972
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JMCMh281cPQTkEiCtuFlwoztXV042WIDZ0ElqYqdTJJi9Jnlpek0OYGwR4hgmryn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3993
X-Proofpoint-GUID: jqMJarHrucCulnhFZgh43LTzdNAIWtEl
X-Proofpoint-ORIG-GUID: jqMJarHrucCulnhFZgh43LTzdNAIWtEl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_03,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 11/23/22 8:09 PM, Alexei Starovoitov wrote:
> On Wed, Nov 23, 2022 at 6:57 PM Yonghong Song <yhs@meta.com> wrote:
>>>>
>>>> +       rcu_lock = is_kfunc_bpf_rcu_read_lock(&meta);
>>>> +       rcu_unlock = is_kfunc_bpf_rcu_read_unlock(&meta);
>>>> +       if (env->cur_state->active_rcu_lock) {
>>>> +               struct bpf_func_state *state;
>>>> +               struct bpf_reg_state *reg;
>>>> +
>>>> +               if (rcu_lock) {
>>>> +                       verbose(env, "nested rcu read lock (kernel function %s)\n", func_name);
>>>> +                       return -EINVAL;
>>>> +               } else if (rcu_unlock) {
>>>> +                       bpf_for_each_reg_in_vstate(env->cur_state, state, reg, ({
>>>> +                               if (reg->type & MEM_RCU)
>>>> +                                       __mark_reg_unknown(env, reg);
>>>> +                       }));
>>>
>>> That feels too drastic.
>>> rcu_unlock will mark all pointers as scalar,
>>> but the prog can still do bpf_rdonly_cast and read them.
>>> Why force the prog to jump through such hoops?
>>> Are we trying to prevent some kind of programming mistake?
>>>
>>> Maybe clear MEM_RCU flag here and add PTR_UNTRUSTED instead?
>>
>> The original idea is to prevent rcu pointer from leaking out of rcu read
>> lock region. The goal is to ensure rcu common practice. Maybe this is
>> indeed too strict. As you suggested, the rcu pointer can be marked as
>> PTR_UNTRUSTED so it can still be used outside rcu read lock region
>> but not able to pass to helper/kfunc.
> 
> This is the part where gcc vs clang difference can be observed:
> 
> bpf_rcu_read_lock();
> ptr = rcu_ptr->rcu_marked_field;
> bpf_rcu_read_unlock();
> ptr2 = ptr->var;
> here it will fail on clang because ptr is a scalar
> while it will work on gcc because ptr is still ptr_to_btf_id
> and rcu_read_lock/unlock are nop-s.
> 
> Making it PTR_UNTRUSTED will still have difference gcc vs clang,
> but more subtle: ptr_to_btf_id|untrusted vs ptr_to_btf_id.
> 
> So it's best to limit new kfuncs to clang.

Agree. This will make code reasoning much simpler.

> ptr_untrusted here is a minor detail. We can change it later.
> It feels that ptr_untrusted will be easier on users
> especially if we improve error messages.
> Say that ptr2 above is later passed into helper/kfunc
> and the verifier errors on it.
> If the message says 'expected trusted ptr_to_btf_id but scalar is seen'
> the prog author will be perplexed, because it's clearly a pointer.
> 'Why the verifier is so dumb?...'
> But if we do ptr_untrusted the message will be:
> 'expected trusted ptr_to_btf_id but untrusted ptr_btf_id is seen'
> which may be interpreted by the user: "hmm. I'm probably doing
> something wrong with the rcu section here'.

Indeed, my previous approach changed rcu ptr to a scalar
and error message might mislead people...

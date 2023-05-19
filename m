Return-Path: <bpf+bounces-960-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D7EF709A54
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 16:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33315281D48
	for <lists+bpf@lfdr.de>; Fri, 19 May 2023 14:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B4110942;
	Fri, 19 May 2023 14:47:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAE08BE2
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 14:47:34 +0000 (UTC)
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BB1C9
	for <bpf@vger.kernel.org>; Fri, 19 May 2023 07:47:32 -0700 (PDT)
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 34J6J5lO017491;
	Fri, 19 May 2023 07:46:45 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=kKcNiBXjFb0WOEl05yDRbO3UFs2w0PeptBwyT89nS2M=;
 b=YAVxDykW6qv6uA/JPl70FoPCZUjd0Xy9AIiXHnLvEgW2tWOiPBA6qDbOrXiSMsw3zMQo
 4E89ynyKuXzJwMNLEg2vWqObSmXEtYDV8xgIBfG9aKndGgGZBvS/lxIwSKMDfMATa49S
 7xR5n23IfQ0+V8trOJctZQehRbCRI15DKXe+livsr8oSTqrhAJIjLiKtMvbDQKbbsC2p
 7eAe09QihRNcYPg6pNseEnQNzHvsSn5nl+ArbtmaRwN2olALa3VyXCsUELfv/kaKHpeu
 +WckJ7eoOJPfJwA621I/eQapo/l95oIB7nxFdGH95v+wI883qn/cofaOZBqhRXDsIuN8 vw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2046.outbound.protection.outlook.com [104.47.56.46])
	by m0089730.ppops.net (PPS) with ESMTPS id 3qp3qwajg9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 May 2023 07:46:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dLZt6kc28K2b460Yiuvk1jax5kiWG9B13ED1EEUYXgWHpKlHsjcfCtoE9B6OG5tS2TBmZYqvIIwpeqqiddIdJUNr3Wz333ZU+sP2mqqMGQx9HQMKLhrE+vG0aAc9FXspzsQgdQPRgCpjFbrvAKjrikoDVddA9tuEe4DrmQSoIW+fbLTlg0laOSkjjlhbvR0Hh2uMI7ZdA/M3n20tiey0m1C6p6MwqqoopkcCSGaClUDr/5vrZ+xvITj29PH54hgnFPG+lAEGHq3I2xFzD65HETAdjBl68DRuFK1RICSfhMoNgbhQ/N1U6BPiQFnH80+SLy61MQEPrabqlRsU1WgQuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kKcNiBXjFb0WOEl05yDRbO3UFs2w0PeptBwyT89nS2M=;
 b=H//wLt54NdTnNP5sLbA0RVx6giZ97ZRzFqF9TIoYKN1z7c7xBcUR3mWE0r2hpZtVjBtyOI2eANwhaf1HXl4ybsoa73kBhtkAf1Zn/Q8S1uQsa43dK9WoyBvh4dSUzms5YqrFPJsE6l6ZPaSrUlTBCCHbsgE6V+kkw1bNQXqtX/v3ikBOll4dycx8NQRUdSZlqlJ9F/5l8E8ChUGumBBzVdEMvkga+jYsUUtZp2R7bJY03h37Zff9E7B2Gl6mYSNCddtt5O+ByG6ubypm81ygbI0FJT3BAPQTHIx32vK0nHDj9ebmyhj6yvWSv7dgtpS4OYQNCaO0I1WDdg1RNevASg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by SJ0PR15MB5129.namprd15.prod.outlook.com (2603:10b6:a03:421::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.19; Fri, 19 May
 2023 14:46:42 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::589f:9230:518:7f53%7]) with mapi id 15.20.6411.019; Fri, 19 May 2023
 14:46:42 +0000
Message-ID: <d47282cb-03f5-f740-ec9e-3286dd848f3e@meta.com>
Date: Fri, 19 May 2023 07:46:38 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [RFC dwarves 0/6] Encoding function addresses using DECL_TAGs
To: Yafang Shao <laoar.shao@gmail.com>, Alan Maguire <alan.maguire@oracle.com>
Cc: acme@kernel.org, ast@kernel.org, jolsa@kernel.org, yhs@fb.com,
        andrii@kernel.org, daniel@iogearbox.net, martin.lau@linux.dev,
        song@kernel.org, john.fastabend@gmail.com, kpsingh@kernel.org,
        sdf@google.com, haoluo@google.com, bpf@vger.kernel.org
References: <20230517161648.17582-1-alan.maguire@oracle.com>
 <CALOAHbCXC5Qvn80HxVGAFLiVE17zOCyHg12X=vXJvcZCU6_gKg@mail.gmail.com>
Content-Language: en-US
From: Yonghong Song <yhs@meta.com>
In-Reply-To: <CALOAHbCXC5Qvn80HxVGAFLiVE17zOCyHg12X=vXJvcZCU6_gKg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: BYAPR11CA0081.namprd11.prod.outlook.com
 (2603:10b6:a03:f4::22) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|SJ0PR15MB5129:EE_
X-MS-Office365-Filtering-Correlation-Id: 0f8104d7-2d58-456c-e3ba-08db5877dc0d
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	nP7t3bXi77GZYBh7QlFB4DpE2awQgqN8A4ZzLZPwAGnt7T5XJHMbxgItIg6htvgGqqW+q7/2QN9PxodNfa12U8sTTgWb97EbF20llEcnnTB85eDSO5lnAL9cCIxMhRU7PsqrDlLFu0von6QgcUfPDJoODjGJ9frm6JuJ2bmbCEaclqisTN2C13o6DFA+H3EltCEG/Eis74M6o0vM93/STUJyqXh/tfhMeWbO9Y9XLv2UUlbRpDtweB9NXPkbitp0gq0wvlGrEdIxO5phU367mnKi+qavrtN0PwBqOu3UOiRJ9uzH4EZh6U6lXUC54cGp8a8FoGcMf9cL48C7hfCwbGINXBuoJYkqN1db0o5OyDbsJtwDGbGEQXKmWLy8ga/nw+97mb/RehLF23EoNIa/CjAGu2qy5V43GWQBYAH/1+jQByc6zTeYkQeRNxMcwQo260JBvwjaumn4ALblLshp20/eMSLb8TxVPSM9o3ql2n5yugCpXcvOeivpbg5f+I8TXNEmdkADDOjaGGIXFIi3i0W7h9YFJE8vwJ84ebHEWXvx9LHqxV7ERgM1YB8DyskTCGtuuroxfq89kPUJ/XLfH7o/VTDlvn2Tx+f6OQHzRcyWJ4opzG2LiwbRSAx/uMW7xrA6XAbiBO3lS+PIOCfVvQ==
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(39860400002)(396003)(376002)(346002)(136003)(451199021)(316002)(31686004)(2906002)(478600001)(41300700001)(4326008)(8676002)(8936002)(6486002)(110136005)(7416002)(66556008)(66476007)(66946007)(5660300002)(6666004)(966005)(6512007)(53546011)(6506007)(38100700002)(186003)(2616005)(36756003)(86362001)(83380400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?Yzc2Kzl4WWw0bFp1cTBaWjh3bHNLdmlQYk5XSDFXZTF3OVVjcEdobVg1b202?=
 =?utf-8?B?SWRnVmhjYzJuL2o2NU5mdWlzV3pWMm9OUzU5czhDUmJ6eFQ2ajJPL2VkQ01Q?=
 =?utf-8?B?K29BWTcxS2FocUtMenMwMi9GTjVwVnZVejlDWHJ1R0JnVUwyV2dDcU9SSTE5?=
 =?utf-8?B?cXQ5ZDhLT3RMSFpLV3JWczkweDljeFBVUnU1aldwYzVia3ZIQ0JVbXArOGhS?=
 =?utf-8?B?TjNhd0xHdkJPemJHQ2l1ZzUrWm44WFpYamllYVJCVFNCT1F0Q3FwbHFrTC9a?=
 =?utf-8?B?bndFTVBRZ1NVRkdLZlF3a2F4RXJPWVNrTnI3RmN5bHRwSEFWTWNuWlVjeGcz?=
 =?utf-8?B?SGpKdUd1clNzeFFja1hCVjZWRTRiUEFRZS9BZFd6UzIvdHZLa2gzUU5uUXdP?=
 =?utf-8?B?OVdDOFZZNkJpUWpZUDhpTE5xQitEaUUyYUhyTG56TkFCSlk0VnIydXArQlBO?=
 =?utf-8?B?UEhlYlBEc25TaDlaREpENFB1cXdTYWQ3NU9SYlZPRlYrcm1oVzMvNEVnTVMx?=
 =?utf-8?B?SXRwaG9tWUM3d25SVkdUT3NzajhVK3BhTC9OemxYSkR4MlNGYUFWbDFwNEYw?=
 =?utf-8?B?dFBPTEs3Y1F5TnY0NnR6cktTZ1lVK2hXZHhiUFhWazNEb3l2QzBGcE0rUldj?=
 =?utf-8?B?Y2R6SUlGdHFPZm9oYzNnaFZScFBmaGpMUmRydmxKVmxGVlRmZjE0U1Q4clNL?=
 =?utf-8?B?R0ZJcGg4Z3p0VDZYZzBETjlaZjBnWGRPSVBqenptREJuODNPaUllNFZsSU1G?=
 =?utf-8?B?SzBlVWkrZ0ZYcXJ5QURUZ0RwN0ZTSk5Hdmc2YTJTUGwrVkV6aHJpRzFRK1ZB?=
 =?utf-8?B?R1czbnF1L0VvQXY5a1NPTjhrWHlMTHdrMXVkbGw0YTE5K1c2UFN1KzVldzJ5?=
 =?utf-8?B?WEt3dWRPQXBxNHMzRU5QMS9RU3NTMHV4M0owQkNQK3djYXY0NGhpT1lCeFVJ?=
 =?utf-8?B?SUd0KzhjMmQwQlB2RnRWcVhITWZDUm5pbGpERk9UM2NlcWlPOVhnRnVBOEMr?=
 =?utf-8?B?Yk8zWmVzNnd4RkdBeDJpZzlTeWhEb1RWUzNJUEtlSmtNRnp6ekFoM04vdUVu?=
 =?utf-8?B?NVcycW53dDJocnk5dnhtNWVSdFdZcVFVU2lnazY5QmE0MVlpRStKVk5tS0x0?=
 =?utf-8?B?TDB4aWphL05lZ1hScDZpMFUvMnR1Q1JmM2EvdGd1WXZjRThBUm8xNmxSQmMz?=
 =?utf-8?B?L2JtSU5IMTI0aS9aN0V4YTYwVVFla2hiQ1dXZForNWpEd1dVUzVxZS9mbmpY?=
 =?utf-8?B?UFZ1cUJuSTZ0bHJLR01uNjNrS1Z4YXl6ejZtQWJlYnNCSXBmN08rL1lZd3hE?=
 =?utf-8?B?aUpkL2hwZTJHSnJTWDN3VGFTRStWODY3YUVLWkk1Rzdzb3RxTVVpT2dNSS9W?=
 =?utf-8?B?SlVrNmhtSGNyRDNyWnkvQi8vUWZYWmhDcW1EZngzTTJaMFFkSjhUSWVTSVFo?=
 =?utf-8?B?Y0hDYnh3Ums0OGpoR3NCQUEySUFQU3k2V25tZzFKNjRteC9JNVlRS0dTSDB1?=
 =?utf-8?B?cjlZSGJoWHVlWEZDbFpGWkxIMzlNTytvcTdPdncrY3RJR0NudG9yTHk2WG9m?=
 =?utf-8?B?Z2t2WGxYUEZvNDB3aDlzZFF1ZUtPbUhCaXV5QlhFNEZvL0dRVUxnM0xhU01F?=
 =?utf-8?B?dzNOdDJHRU42RHl4V3FsMkJlZk1mUkNueXNOLzNmQUlmRjZXbDNkbXhSQ0M2?=
 =?utf-8?B?NFJ6ZTBvM3JFS3c2M3NySXFlYmNBcjArV0s4QllId1A1cDA5eXphejArdG1O?=
 =?utf-8?B?ZFB1UkxOcFpyUGZ6bkk4MysxUEd2ZVppQ1VzOVIvZHVxSnJ4RjZJcWJTUUdL?=
 =?utf-8?B?U3pVaEQ5bmRBRjdnRlJPS2hIYVNEMGFLMEg5a016Mm9KUG1NclhXM2Z3SUJQ?=
 =?utf-8?B?SGRFN0pjTW9EQ3A2b200SmhSbGI5bXJ3UzRvQkxReE03dzVNMEQ2TUdyVCtQ?=
 =?utf-8?B?c2RWZWFDNk5KVDJlUjRhKzVPRHRQbFVHMnpMbk5pZXBlNWhuWDJUajJiNTNX?=
 =?utf-8?B?elNHcStLclpmcTAyZ3ZpWW5oUzRqSjM5ZHVLMlJCZ3BUNGhKYXh0TjRuZ3dJ?=
 =?utf-8?B?dmNmT2g0RS9pZDVxaVhGVklVUkhRdFI5YzBieEk2enJlN1ZLMUZiQXZxbWdz?=
 =?utf-8?B?cUNNY0VFZUFsUTIzamFqcnd3UnJJazl5VDlMZW5zb01peVU5RCs0VGtZb3gw?=
 =?utf-8?B?aXc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0f8104d7-2d58-456c-e3ba-08db5877dc0d
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2023 14:46:42.1729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yWHUVfQExKrwG1j069OiKbT5f914BTnpd/OlT1FijcYxakN8GB0ABqcIs/rRYaMH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR15MB5129
X-Proofpoint-ORIG-GUID: 0qL3zi6wQLfSELFVKF0pywwO5gj57y2F
X-Proofpoint-GUID: 0qL3zi6wQLfSELFVKF0pywwO5gj57y2F
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-19_10,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 5/19/23 2:44 AM, Yafang Shao wrote:
> On Thu, May 18, 2023 at 12:18 AM Alan Maguire <alan.maguire@oracle.com> wrote:
>>
>> As a means to continue the discussion in [1], which is
>> concerned with finding the best long-term solution to
>> having a BPF Type Format (BTF) representation of
>> functions that is usable for tracing of edge cases, this
>> proof-of-concept series is intended to explore one approach
>> to adding information to help make tracing more accurate.
>>
>> A key problem today is that there is no matching from function
>> description to the actual instances of a function.
>>
>> When that function only has one description, that is
>> not an issue, but if we have multiple inconsistent
>> static functions in different CUs such as
>>
>>  From kernel/irq/irqdesc.c
>>
>>      static ssize_t wakeup_show(struct kobject *kobj,
>>                                 struct kobj_attribute *attr, char *buf)
>>
>> ...and from drivers/base/power/sysfs.c
>>
>>      static ssize_t wakeup_show(struct device *dev, struct device_attribute *attr,
>>                                 char *buf);
>>
>> ...this becomes a problem.  If I am attaching,
>> which do I want?  And even if I know which one
>> I want, which instance in kallsyms is which?
>>
> 
> As you described in the above example,  it is natural to attach a
> *function* defined in a specific *file_path*.  So why not encoding the
> file path instead ? What's the problem in it?

Say we have the following kernel code:

common.h:
    static inline int foo(...) { ...}

bar1.c:
    #include "common.h."
    ... foo() ...
bar2.c:
    #include "common.h"
    ... foo() ...

Even if the function 'foo' is marked as inline, but the compiler
may not actually inline it. So now we got two static functions
'foo' in bar1.o and bar2.o with identical code path (common.h),
and we do want to differentiate it as user might want to
only trace one of them.

> 
> If we expose the addr and let the user select which address to attach,
> it will be a trouble to deploy a bpf program across multiple kernels.

user space may need a little bit work to decide which address to take
by looking at the vmlinux BTF intending to run, e.g., checking
BTF signatures in most time or in the worst case checking dwarf.

The kernel can then handle addr by doing some relocation if needed.

> While the file path will have a lower chance to be conflict between
> different kernel versions. So I think it would be better if we use the
> file path instead and let the kernel find the address automatically.
> In the old days, when we wanted to deploy a kprobe kernel module or a
> systemtap script across multiple kernels, we had to use if-else in the
> code, which was really troublesome as it is not scalable. I don't
> think we want to do it the same way in the bpf program.
> 
>> This series is a proof-of-concept that supports encoding
>> function addresses and associating them with BTF FUNC
>> descriptions using BTF declaration tags.
>>
>> More work would need to be done on the kernel side
>> to _use_ this representation, but hopefully having a
>> rough approach outlined will help make that more feasible.
>>
>> [1] https://lore.kernel.org/bpf/ZF61j8WJls25BYTl@krava/
>>
>> Alan Maguire (6):
>>    btf_encoder: record function address and if it is local
>>    dwarf_loader: store address in function low_pc if available
>>    dwarf_loader: transfer low_pc info from subtroutine to its abstract
>>      origin
>>    btf_encoder: add "addr=0x<addr>" function declaration tag if
>>      --btf_gen_func_addr specified
>>    btf_encoder: store ELF function representations sorted by name _and_
>>      address
>>    pahole: document --btf_gen_func_addr
>>
>>   btf_encoder.c      | 64 +++++++++++++++++++++++++++++++++++-----------
>>   btf_encoder.h      |  4 +--
>>   dwarf_loader.c     | 16 +++++++++---
>>   dwarves.h          |  3 +++
>>   man-pages/pahole.1 |  8 ++++++
>>   pahole.c           | 12 +++++++--
>>   6 files changed, 85 insertions(+), 22 deletions(-)
>>
>> --
>> 2.31.1
>>
> 
> 


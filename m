Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00FCE64BE36
	for <lists+bpf@lfdr.de>; Tue, 13 Dec 2022 22:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229984AbiLMVHR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Dec 2022 16:07:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236638AbiLMVHG (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 13 Dec 2022 16:07:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3891721E3F
        for <bpf@vger.kernel.org>; Tue, 13 Dec 2022 13:07:05 -0800 (PST)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BDKMFsG018070;
        Tue, 13 Dec 2022 13:06:41 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=bt8dmfIkT+jcILl8PKOsUNTjrsJikl4KwjvMTJKwxP4=;
 b=jiEfL7GcNQxK0XnBV+KuEqmjpMe30giZVaSmiGBmAZxpSEZ2bK2I51D42GDc13AcT8lE
 QRaOaF8P13k5z+NE2dLrEcr/wS9aocfRnopGLDot5Rmtgy7fBgQyZ8B+TwVUpr7Hvb+G
 mtmalOxYVo0HmQt0Zq4TAqIjyBm7msE4tcLWwAwl2a3/7GImbMzFPVixXC8qRSZrjdUt
 fMScdtYlOvlDy1db0qg0OH6ezw5UJ3q3rlySlpwH0Td7q2K21bfHSGMqiJ3s+FOSk3kz
 JZ6I9n3gv5qSWptAhNuqqzQKgXh49DLsLiyRKR25cFWjjeC3BY6p2wNmJOlsjscqy4nJ 9w== 
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2169.outbound.protection.outlook.com [104.47.58.169])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3meyf58n1g-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Dec 2022 13:06:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V6aU9qtpBlHTP9K3c0m90GMzU6cberfMvHRGA76aJz8cjcYojukLpHmI9jPc9yv/EWiI+eAxQVapkHODluos2uNixEFgq2VCcE/PGgdp8jLLDx1OPzdvBVNvlMXnZPOwJvILRldiq7FsW5RCV0XYQEYEUf+lNFY2ulgC0FlJmBxSrqKyEz5/Qr/0Q2f3k2EaAw3Uw2Y/lpEXDhD8IttXI7D2ctcbZkC5eDpvuu2NzNq/TodxeNrkJniVbSJDoWHfCMCd2kMseY4IIiJFFsFEBu3j13Zbyc6sNcVs4sQIgAGm8M6XDBU1JYSKUmRmOYjHdRPUz/PfqGJDCQkp3JDBIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bt8dmfIkT+jcILl8PKOsUNTjrsJikl4KwjvMTJKwxP4=;
 b=DOLCIA5EOK+puWNuh0rOXd/GNrMExcJlk+WTvoTx1YKnYv2nY9UlK6LONfbMUE2Gn93WG0ULM7aFVx2Hf6KZCWtyrwcXKbWC7XtbBwWsh4WVzlHkrOZQQu5uIL/QC/dB2fgzwBf+/FaruRm0/3wCBuSbq/d1GenlTzpezbAFme77cqUciHr+WZZMyLq1yvvkELPk77SWwUNM5fXgNl4aE3vNBWjct+hNnVb9V6aptpASvL4RZNqiYCz5XI1onnwNDODCrbD2jxe4gwNX4RWxbyryWw1pcw63WDgK732ergUd14hwVNDxo7bVQKU81NZVnRsZQaOs0oQWRWCajtofuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BYAPR15MB2520.namprd15.prod.outlook.com (2603:10b6:a03:14c::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Tue, 13 Dec
 2022 21:06:38 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::d665:7e05:61d1:aebf%7]) with mapi id 15.20.5880.019; Tue, 13 Dec 2022
 21:06:38 +0000
Message-ID: <9238ea62-7c5f-005f-a693-cc09105f5632@meta.com>
Date:   Tue, 13 Dec 2022 13:06:35 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.1
Subject: Re: [PATCH bpf-next v4 1/2] bpf: Fix attaching
 fentry/fexit/fmod_ret/lsm to modules
Content-Language: en-US
To:     Viktor Malik <vmalik@redhat.com>, bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>
References: <cover.1670847888.git.vmalik@redhat.com>
 <d4a7235586e3ca1b667f220de7b4835a1382397c.1670847888.git.vmalik@redhat.com>
 <b1698393-2bec-edb9-5adc-d076bfc2b188@meta.com>
 <d8464b4e-b514-7587-50eb-4b1391e87713@redhat.com>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <d8464b4e-b514-7587-50eb-4b1391e87713@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR03CA0009.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::14) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BYAPR15MB2520:EE_
X-MS-Office365-Filtering-Correlation-Id: b21fad50-8771-4f97-c6c3-08dadd4ded14
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dMIf5Of4DKv+PsFjfQI9VrPJasPu6jo4q1WX7S+Cg37sZaQrrA7ICfeQ/MdGvEX74QWsuaf3RHK+t/e8lzjtaxd9ipFEwebDdh5e0WI/hSsqFZbRSMhoiws2RIZjYlSkE5T/lguKBHDrF8czWwkXVTZu1HU/rf7bzH3C2/7KKP3nZBjN2O1LBDLI7ydV9gPx5jwT45R35uVbk2GPnJYEfc5NTVymsJh0L9mT4r5K0+RvkhW/Bs/YovMcW5hYg+Ttph7AQ1oUmnf65l+OeG26IhSWuogOB7MztBtfKyDJMFgTWE9lUggUB5EGhqmqW2rYQQToayCmr+TUGTx3m127gMS0LxUaCnCCRlasN6I1yGWLcJo/k9YAzIIP9fnpnP0YnDpCDpnSHDaBdf/ZyExueedz0S8VlQ+K9jUqhV3iKisXEm64jfzdsTLn37L3y0jGUts93hdn7IWs3M7B6+lSh3ezXzi0P8DolndZPtIwogHfPGVnZVM2q83NiLrZcYbV7p5qCvvl21n2f2dK1a4rPXdj94NFnZk2nKNAYISERnxpG4uidlAnhJPv0GT10yqsPkEeMEz6I6aq07p1bCL1FH7V3cYAytXMZf/OnfuE6+VsMCEWfuGnN8njBTUiEwClWZsOmwJXdendyT028TAIhCav3yCDagm0QpKN1fUDGphOV+ag66+s0A2uGqgEzd5bZ3GmgcAeHBFuGg9P4DpNSNxAJUU0J8nwjlr6cEpAJm0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(376002)(136003)(346002)(366004)(451199015)(31686004)(5660300002)(2906002)(2616005)(186003)(41300700001)(31696002)(7416002)(8936002)(66946007)(54906003)(86362001)(4326008)(66476007)(8676002)(66556008)(83380400001)(316002)(38100700002)(6512007)(6506007)(6666004)(36756003)(478600001)(53546011)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RXNDRFFSNUpKMDlzOEhyZnFZVzBWR3gxa1hMY3BIT0ZQN0tNazJ3amtCOWw4?=
 =?utf-8?B?U0dwUy9EZGVLd0FqeVR2SnRHQkdTbTErdmdtZlVweGg3b0ZsUTRta1Eyd1A1?=
 =?utf-8?B?Y25jeDY3ckRNbjBFK25CV1hJOVRldFUxTUtNaGxFT0xmdmRoNDVNRnZJaldR?=
 =?utf-8?B?Q25FVjVtQXBzM1VMcktDSU5CZXg3c1B5QUVDUmxLVndoZzFyUlhFdDFYajhx?=
 =?utf-8?B?dENlOTdKYTNVRUR1b29JSmJWMzM5QkxrclVTMm80M1NUcWpDbkU3YmFYUUdP?=
 =?utf-8?B?NUdKSVZNeUl5ai8xWEg2dnhlL0xjc2ZDdWdLbmpnS0xsbmlHbDU2NTBCcFEy?=
 =?utf-8?B?NFlPNVVEQlE1dHJKOE9jREtQUnVRQ09PejlxOGdTUWdsTGNidGJ3dUE4ZXVV?=
 =?utf-8?B?WEd2MFRHOWRPWmJrbjhHSUdxNE04UGN2OGlGbEdvY3paT0hrTlFZLzVGTzVY?=
 =?utf-8?B?TDN6YThZZjhvdmlhR1g4VllkS1cwZXhyVjF5VXhPcUFGRDgyU1JkWVJoL0tH?=
 =?utf-8?B?MG9qbWVNd0ovRjVGbThoOENMSDc0cGp2YWpQdm05ajVWSDhqaXVnQncxSEVU?=
 =?utf-8?B?TXJYK21sMnFwMzA4bXNXbDhFQWVzRTZkcFl1MFE5SThieFE2R3J0TkhvMnll?=
 =?utf-8?B?QStGQWZzZVRrZGc0VTh5L3N5WGsyd2FXTEMzMUtqMG5BYUtiWWJGTzdZRVNX?=
 =?utf-8?B?QyszaDlDRVBZcHRJa2VsdUNMTEVaOVRsM3ZuM3pmZXA5VHJCdTd1bnZQV2lt?=
 =?utf-8?B?RWd2YVo4WGUrWE0yN0duYVgzTU1JTE1WdjkzNGZaVU03K3BRQ0ZrUGRYMS9S?=
 =?utf-8?B?bld6WHU0Nlp0MndMa0Y0U0RDUCtVU01lVkl0cEQ4eUQ4TW1TYU1GcUxlRm9T?=
 =?utf-8?B?V3QvZDJlRmxsZ2Q0SHlqTWd2SFExcFMxY29rMTV4OFpPT0IxaEQ1dlUreGZD?=
 =?utf-8?B?SHZONXVmTCsyOXQ4bVlobWZNVzdKRjhwdGZpbVBxRjZPTWdzd0FYU29RMk9q?=
 =?utf-8?B?TklWNi80WTZCeDN5Rm9oTHJnaE9vN0dEa1hJYUNaeXBndWVqdjRNYytTRmtD?=
 =?utf-8?B?czVDd0l4QmRnZ1R2cjBLbVdXNGl6bVkxQjk3eDB4dWVzN0V4a2xJRnNhY2pE?=
 =?utf-8?B?MlRFSFV2Rkg2TEhjWnpPYTIxZm1hWnE1WUk2NUxOdEhIU3pVMEN2anNTU2Iw?=
 =?utf-8?B?Rk9icjNXY1NIcmhheC9JS1VRMnowd0haWUpvRUxlM2dKekZHNDdQL3NzekdI?=
 =?utf-8?B?b0U1dFpiQXZYbHBmNS83SkIzeU1qM3RlOTQyU0FyOTJwVmlvTG1rM0dCYjRm?=
 =?utf-8?B?UzYzM1pVRFVjOEZzUmE2bHJxRng2aUZJeWxZUk1nWSt4ZnVxWXBIZUZWQjBO?=
 =?utf-8?B?MzF6bzNXWkttVlhxRDJpT0pZMHZtWkY0ZzJVVUVUQll4cm1HeSsrN3ZaWDJL?=
 =?utf-8?B?MlpXbi8wdTZrck1NazBRYlhmbEZ3MmhjOGFBRG1XN0FIeXh4SnlmOGNvRCtB?=
 =?utf-8?B?TkNuQTZCK1k2UDJOQlZzNzRuRnZqS2NNYytNd0paYjFxYWtTUDNMckgvcVpw?=
 =?utf-8?B?WlR5U2xxWm9vUzZrV0dwbDFiWU5XSVVRR2Q3YmNiTlB1N0srRFExcFhtaHJz?=
 =?utf-8?B?N1B2VXVSSHYzVEVxWlZ5VFBHOXdkUkNxSnVpL0tUL0t6ck9NL0kyRUtwTE5j?=
 =?utf-8?B?UjBNdUk0U09STWhRK3RrRUplTzB0cG5yNUZYS2VTSzM4MCtkajk4NFE0Zk02?=
 =?utf-8?B?bVFvUFA3ZDdlT2RpS29rYm43MVY5MWY2YXpGSFBSUTZOQWhXMmliYTh4NHpi?=
 =?utf-8?B?ZXdpczlvekxTeXd1OUZ2elp2MW9nZVV5UStUMitkYi9Bc2R0UmVjVnVGaHVw?=
 =?utf-8?B?VlRVRGttVThMeUZ3ZXRGVjIxVEJXbVh4YzBiQTBsMVVzZ1gzblJjU1VodkF2?=
 =?utf-8?B?alYyYUdLUElpbjB4d28ycE1mcGxRdEljR0ZTMmJWWVh6bHJRVW9uZSt3d1RV?=
 =?utf-8?B?YW5DZVY3RmlqNzNQTnZpTk11ZEFrWGMrUThoMU1JcGJSY1pxNnlKRFNFMDdQ?=
 =?utf-8?B?R2ZEL0FrVzdZY1ozQ0sxekYxU2ZrUzNoQ3VmeVd3LzBDbDhIcmNQRkRoU0lD?=
 =?utf-8?B?Ym9qRXdRcTRDdGpUbFdQSUZPVmZFM0J1WWFXVTB6RFBlQUs5ZEl0WjFlVUk1?=
 =?utf-8?B?R1E9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b21fad50-8771-4f97-c6c3-08dadd4ded14
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2022 21:06:38.7378
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yJFHBJFRwxSR4/PW6GEwJNZIeHEY1IaYz/HHINCveaBOgMAlzZX4HUy7oADrBCsT
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2520
X-Proofpoint-ORIG-GUID: zYJsLCNm3LmyyHm3eRMQSAt231EWiRBq
X-Proofpoint-GUID: zYJsLCNm3LmyyHm3eRMQSAt231EWiRBq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-13_03,2022-12-13_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/13/22 2:59 AM, Viktor Malik wrote:
> On 12/12/22 18:08, Yonghong Song wrote:
>>
>>
>> On 12/12/22 4:59 AM, Viktor Malik wrote:
>>> When attaching fentry/fexit/fmod_ret/lsm to a function located in a
>>> module without specifying the target program, the verifier tries to find
>>> the address to attach to in kallsyms. This is always done by searching
>>> the entire kallsyms, not respecting the module in which the function is
>>> located.
>>>
>>> This approach causes an incorrect attachment address to be computed if
>>> the function to attach to is shadowed by a function of the same name
>>> located earlier in kallsyms.
>>>
>>> Since the attachment must contain the BTF of the program to attach to,
>>> we may extract the module from it and search for the function address in
>>> the module.
>>>
>>> Signed-off-by: Viktor Malik <vmalik@redhat.com>
>>> ---
>>>   kernel/bpf/verifier.c | 16 +++++++++++++++-
>>>   1 file changed, 15 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
>>> index a5255a0dcbb6..d646c5263bc5 100644
>>> --- a/kernel/bpf/verifier.c
>>> +++ b/kernel/bpf/verifier.c
>>> @@ -24,6 +24,7 @@
>>>   #include <linux/bpf_lsm.h>
>>>   #include <linux/btf_ids.h>
>>>   #include <linux/poison.h>
>>> +#include "../module/internal.h"
>>>   #include "disasm.h"
>>> @@ -16478,6 +16479,7 @@ int bpf_check_attach_target(struct 
>>> bpf_verifier_log *log,
>>>       const char *tname;
>>>       struct btf *btf;
>>>       long addr = 0;
>>> +    struct module *mod;
>>>       if (!btf_id) {
>>>           bpf_log(log, "Tracing programs must provide btf_id\n");
>>> @@ -16645,7 +16647,19 @@ int bpf_check_attach_target(struct 
>>> bpf_verifier_log *log,
>>>               else
>>>                   addr = (long) tgt_prog->aux->func[subprog]->bpf_func;
>>>           } else {
>>> -            addr = kallsyms_lookup_name(tname);
>>> +            if (btf_is_module(btf)) {
>>> +                preempt_disable();
>>> +                mod = btf_try_get_module(btf);
>>> +                if (mod) {
>>> +                    addr = find_kallsyms_symbol_value(mod, tname);
>>> +                    module_put(mod);
>>> +                } else {
>>> +                    addr = 0;
>>> +                }
>>> +                preempt_enable();
>>
>> What if module is unloaded right after preempt_enabled so 'addr' 
>> becomes invalid? Is this a corner case we should consider?
> 
> IIUC, if 'addr' becomes invalid, the attachment will eventually fail.
> 
> So I'd say that there's no need to consider that case here, it's not
> considered for kallsyms_lookup_name below (which may call
> module_kallsyms_lookup_name) either.

The below kallsyms_lookup_name(tname) works for vmlinux and vmlinux
function won't go away.

The following is what I understand for module address:

    bpf_tracing_prog_attach:
        ...
        bpf_check_attach_target (get addr etc. into tgt_info.
        ...
        bpf_trampoline_link_prog
            __bpf_trampoline_link_prog
                bpf_trampoline_update
                    register_fentry
                        bpf_trampoline_module_get


static int bpf_trampoline_module_get(struct bpf_trampoline *tr)
{
         struct module *mod;
         int err = 0;

         preempt_disable();
         mod = __module_text_address((unsigned long) tr->func.addr);
         if (mod && !try_module_get(mod))
                 err = -ENOENT;
         preempt_enable();
         tr->mod = mod;
         return err;
}

We try to grab a module reference here based on the func addr.
But there is a risk that module (m1) might be unloaded and a different
module (m2) might be loaded which occupies the address space of
m1. In such cases, we might have issues.

To resolve this issue, we might want to grab the reference
earlier for find_kallsyms_symbol_value and won't release it
until the program is detached. try_module_get() then will
be unnecessary in this particular case. But care must be
taken for other code paths.
                       >
>>
>>> +            } else {
>>> +                addr = kallsyms_lookup_name(tname);
>>> +            }
>>>               if (!addr) {
>>>                   bpf_log(log,
>>>                       "The address of function %s cannot be found\n",
>>
> 

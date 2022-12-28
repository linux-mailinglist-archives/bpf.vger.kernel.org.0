Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6E74658672
	for <lists+bpf@lfdr.de>; Wed, 28 Dec 2022 20:43:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiL1Tlo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 28 Dec 2022 14:41:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230078AbiL1Tlm (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 28 Dec 2022 14:41:42 -0500
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3A71165
        for <bpf@vger.kernel.org>; Wed, 28 Dec 2022 11:41:41 -0800 (PST)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BSJae3D000938;
        Wed, 28 Dec 2022 11:41:38 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=xz4neEgfjtP+9OYqcFA3U7jTproAcGeQANLQMcmzz2I=;
 b=MeCfgJOx5fCu1Sxm2zCKr/qhS8Cr8pxhiNHEz/wlz/wI//LJu+rwAJGk0N+YdJUbLlt6
 IVUDd7ZC4kRvVVy8zvWbLxXOEXDmsOMMqpXGFOlgu3vTuOHoP2s0QDyGAs9CNiC/uG+c
 9zA+EjdZ5Y+XG4ad+ivXFdZs280X/4uLdLoQf2YVnc2Et9z6i5MH55FYX1S1g0LjKd9f
 dfeXu1sVuseEiKibuHHaX8iGNj/yZ6JchT2c5ZD9ZVDKUGSIDSEmp05RzoOWIdB7YXwi
 wYKz4Qp5f//U9hoXAmFxtwGXK+tMvQ7sWlRtYCvImwPgRepD70B0zb5biDSfRJ0B3EQA IA== 
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2045.outbound.protection.outlook.com [104.47.57.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3mp051cmx9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 28 Dec 2022 11:41:38 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TieNMAHfyI5i2Ex8CgRe+DEWLjTqcO2qxLe6KdN7jPgGWgF9SCw3BxL+cbqvhqbEhFJEkgnyuyDcS+08lYVEad/Kg+Ig4IjFDTe5LH8dRbLRYbAsyMtbAne/VdgfrEyhLqTnYupQMYxvjc4s3QCJ1B5BgaI/IdfxLlHFr5GwbAPn+VEiVUwnGoHFp0ZG9SM8rc3/vmWvAw2qdJV2RiJBk1m4JBxTuXvRwlN57nGos4dUdimm9GnJRH0tL0dUHiwClfXalJHqHADSCGEs/tIdyt0g1YiDgC36Azd8ElTykP7aJEAVyFNGrAqNS/zNtlaxP0YsUyNqkfWD6tkxJwDt3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xz4neEgfjtP+9OYqcFA3U7jTproAcGeQANLQMcmzz2I=;
 b=iosGupX2tRzZcgJtse6Ja4UQL0kq9JjvftrHcrx1apj/hxGSgejfwMvgIngGxShRchZnewC80IpeY4866RzyZDQNf7iJOQB3KxFg50eKqf+DTPBgWTLfyFTxlEIIKBx6a5Y37UyyRnPJHk9BGhErcoIcV9j9l5tQWlHBYsLOOGQccdIO4yxLi+RDjE9YyqKdNeNUZJD9QPF0LKkllMhrUVE7mFEvrCkFwpHR2Goi8vH9QLcekQG3S6zdr9wZSvR8nzrtQj7Hljmc0YejfJ/y4UCIRY0GklkofDC3aHlJyQrNNW+jL53bjVyWQJtyhyWjMYb1Jpav8IXjfYpUH3Iugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by DM5PR1501MB2103.namprd15.prod.outlook.com (2603:10b6:4:a0::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5944.16; Wed, 28 Dec
 2022 19:41:36 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5944.016; Wed, 28 Dec 2022
 19:41:36 +0000
Message-ID: <42d3f4d8-fa8b-5774-0f6b-b12162c24736@meta.com>
Date:   Wed, 28 Dec 2022 11:41:33 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: bpf_probe_read_user EFAULT
Content-Language: en-US
To:     Victor Laforet <victor.laforet@ip-paris.fr>,
        Jiri Olsa <olsajiri@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>
References: <346230382.476954.1672152966557.JavaMail.zimbra@ip-paris.fr>
 <Y6sWqgncfvtRHp+b@krava>
 <505155146.488099.1672236042622.JavaMail.zimbra@ip-paris.fr>
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <505155146.488099.1672236042622.JavaMail.zimbra@ip-paris.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR05CA0061.namprd05.prod.outlook.com
 (2603:10b6:a03:74::38) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|DM5PR1501MB2103:EE_
X-MS-Office365-Filtering-Correlation-Id: 1189a43b-176c-4014-6712-08dae90b87c5
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Xg53g7GvQdNzzTHuOeDzPnJU5R5OBLeamM9RUaKFLM7vs8E+USVdpe8PUwuOMGjcSkkMs1bApQ8HZMom/QxataIlWLDd9l/+MVZiWyFmU9wenKcOPutNeW2dK0D7m4yOpHMBhqKpSm74Vcehlcwz86lsaQb0vfg06Cb/I+orEMUHLZBcYJTPuR1tGSVLSda9zS+H6SllK0l3efwV5l8Nks15+KhrsY9GYtftVFPVTfoItqg1SuMS0K/yCC/+tcUbJE+8ePHJ/MGA9yz0wGgMXs6pms4PujXotd8qoYjD0x7gRviKT8rn1P6lWf5fVDt0BwoikAtpcjCRXHIlNmaT9pmW41EbwDY7OxQ9vXkxitICxb0l0yDrLWB6UVrtWmLrHdqH2UH+G8IwzHHePIUSXXfrGUBG1r4JKR/9dDo4iWLy3hO28G87c0KKJNo8L0rFc+qJV5T4t3Y6ozhIcoLT+5+3hhgu/DMapp6hICzdPkeHoidcvHBeZFZuvkanuADRsL3uJ/2iAPfmoKhl6CQKwbJn9coTvIG9M7aH4gfKVwYUlS+/95clIL5wQ5a2zyI9AbBWTSaseJE8irVbSsSj+Iazm9l4an73MykfOTnssj3puuDRS0ETNo4V0DNWpzdkUmB7Au+98R2+fmIJ50k0q+mMRIx9qmKNbyw8hLZIJHTAt7qDQcS1ou6a5OPz6Pyc4pNrePjqlM9L7szyuhMphoICDt/NRb3j4Wmz7siJkS0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(451199015)(110136005)(2906002)(36756003)(316002)(2616005)(66574015)(83380400001)(6666004)(6486002)(86362001)(478600001)(31696002)(186003)(38100700002)(53546011)(6512007)(66556008)(66946007)(8936002)(8676002)(4326008)(31686004)(66476007)(41300700001)(6506007)(7116003)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Nlp0ZEVQcnJDYmZCNitnVkRzYVZmckdIWDRvQVQzRFRBV2NMZ2pHR0k5S2lh?=
 =?utf-8?B?MXNpVWl6L3YyaUZDR3JUaFVQVUN5dy9GZUp0SFRxVGZQajYxclVpQW5vdVlY?=
 =?utf-8?B?MFlhY0xLUzBqZmtrY2huRDFLZEU3bWNLNkZ6Yi9haUlBb1N2ZGdnU3BZQWVQ?=
 =?utf-8?B?QVdzdWljQTJUSHNSR2Y5ZmpXWkhjR25CVHVidzFSRE5yeUl2Rk1HRHJjOXpk?=
 =?utf-8?B?VzB3UEhlQ0QzZlBRYld6SWNrUi9SLys4c1ZPK3NJQ3B5emtOak94b21mcDdI?=
 =?utf-8?B?bG91MkpTWGRFRk5oQ2xoeUhJc0IwMVhjbGszSVhlRGQ0clhDR0p3cnVzNjlK?=
 =?utf-8?B?a05rTWRmT1plZDZZL2dIZnVuTmdFcU1qcWlod2U0cTNMTkhiU0dIbGRwSHZI?=
 =?utf-8?B?LzB1Q2xqNVpqUHM2OG42YzdWYS9acXNHUFpmOUJuWnBRRHpVS2xhOFBDVkhG?=
 =?utf-8?B?S0p5b1Rick1LYWxKdGo0emxkdlFUdTA1ZGNuaEdsUW9LclZkWHpsODFNQURH?=
 =?utf-8?B?SkwvYWI1dStYTGE0bU5heXp4Q0lmamhidkxjcHEyOU9KUWkrZGlLbHNPQUFU?=
 =?utf-8?B?NXprNnFkYkJKOU1tOVRrS1UydVJteUJpUHltc21PYVI3RndQVW1GWmRQQndS?=
 =?utf-8?B?b3ZuWnNKd1psbW5ySTVaK0dxcDNDZ0U2RHViUXh6UExQblVjdHJqTnE0TEVC?=
 =?utf-8?B?K0xNRGJiVXcycDQrWFU5dDl0cFdFYTNCUklDaW9EaWxFY1RCaURKRFVXSndN?=
 =?utf-8?B?NWF0VU1ZTUIwLy9JU3c0VXZBMjFOeVBoUm1EN2xKaCsyREg5Z2JyWlVRT1dF?=
 =?utf-8?B?MThwWXpiRjliN2I4M3o3WTA2dkpFWm5SenhiSTJDcGd2MC9BOFFpdVBxVGxS?=
 =?utf-8?B?ak1zNXVmV3RGdnV6RnViaGlnamdSaldNdGJSMm1GTzBoeTJNeXF2NnBwRUY4?=
 =?utf-8?B?NnI4b0JHdlB1MkhUczdkQUQ3dW55MVpMU2xMYlFhZWFmN3gySVVyRXVaNXVZ?=
 =?utf-8?B?aUl1QUUwSTdLUnQvbXQxSWZDTDQxR1J0SjQwVG9MeldiUE1id3VES3FSYWhu?=
 =?utf-8?B?TW9uclN5Q0pvTU9uK0V3K0Q2RnZuWC91aWZtMkw2WEhrQnJoUVRpZFowdnpT?=
 =?utf-8?B?ODMyZWdOUG9QekxjOFc5emdVdHFPU1ZHc0NvOGZ6OHlYNU5RclJxeUdaYXBR?=
 =?utf-8?B?WHVCWGRtN2ZyZlp3V1JoenZkV0VIWUp5THVacnJRdUpsUVVUSW5BTXJnMGVR?=
 =?utf-8?B?OXBCNUZQT2lRMEFzdkxMM2Y1RTJSVm1rY3I2Y28yMEZBZE05eUpxNDNReXFZ?=
 =?utf-8?B?a2J6cmZUT2RjRk4xYmNmL3gxQVI1UjJQaVUwYm9nbzVOSTRrdHJOUmFjZHVz?=
 =?utf-8?B?RXJqUzFVeFROdWJqNmVobW8zV04rWkhUclBzNXR0MU1teE1SMG5sRlFDK1J0?=
 =?utf-8?B?ank5bTB1Y1NQOWRQZXdJbkNHREdJZG5MUUowMEtma3lwQXBoRUplek9QSWh2?=
 =?utf-8?B?eW54WlN2M0YzaXFwbUJSUXN4SjJQTGZCTmpXZis2cGlEY3NzNU1iOFhVdXNa?=
 =?utf-8?B?MldzYkNLTzBFeFJ4UmhQWHdCQTRnbWhtSEJzK095MzNWU0dtMVU1eFdBbkpo?=
 =?utf-8?B?K3BSUGR4VVMyWFpERHJ6TzhHa2REUlFjdCtWWWsyTUNyMFQ4UEM2UUxxK2dw?=
 =?utf-8?B?cExLNXk4TklEMWJtZ1dsUE5CNzBwRUxBTXVBQndrNXVVS3JCbkFJa1JJYkQ1?=
 =?utf-8?B?M2VqZlZDRDBaNjE0Rk8yZWRxdEcrU1dYMG55WE04OCtVa0xYSlRBSmJDWDB3?=
 =?utf-8?B?eDlyVHFENTdZMmVQMy9yRmVnV3hBZnJvRmI1MkZ6QTZyLzZBWVN5YVByTnpl?=
 =?utf-8?B?dldRWDdPRkJzbWRCMVd1ZGx2ZXJPbDZFY1prcDZvaUk4aEx4elJXY21PbWRk?=
 =?utf-8?B?Y0NWdG9ibEE1ZmtadjlKQzFlSytKd0I4Z3ZwR2NlYkJIT3JsemRzNlZ5OXFC?=
 =?utf-8?B?VGVUSThXNkp2MXR2bEs0aEp6RFRVTzJNRUp2Z0N3SXhBL0svbWdWNlBmalM4?=
 =?utf-8?B?U3kxdXVUbzJOSEdPa2QzZThZTDZYL0Z1d0RZV2JUVURLQy9UQXN6ek56SDRi?=
 =?utf-8?B?MG5yT3Z0Z1FHTlZPUGxaUWhGOFZOVHpHVG5OREhqQzJNMzVhOHZScFZrK1ZF?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1189a43b-176c-4014-6712-08dae90b87c5
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Dec 2022 19:41:35.9682
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BVL4TWSigNq/yqyCkMJFfpoeSVcPVvl30yyNYKlO6nN5cHayXaLodIORxarwjqh1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR1501MB2103
X-Proofpoint-GUID: 1qyYRTq2ZyGcbbvQ93kLQryXmbX3-sn2
X-Proofpoint-ORIG-GUID: 1qyYRTq2ZyGcbbvQ93kLQryXmbX3-sn2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-28_13,2022-12-28_02,2022-06-22_01
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 12/28/22 6:00 AM, Victor Laforet wrote:
> Yes I am sorry I did not mention that the example I sent was a minimal working example. I am filtering the events to select only preempted and events with the right pid as prev.
> 
> Would bpf_copy_from_user_task work better in this setting than bpf_probe_read_user ?
> I don’t really understand why bpf_probe_read_user would not work for this use case.

Right, bpf_copy_from_user_task() is better than bpf_probe_read_user(). 
You could also use bpf_copy_from_user() if you have target_pid checking.

It is possible that the user variable you intended to access is not in 
memory. In such cases, bpf_probe_read_user() will return EFAULT. But
bpf_copy_from_user() and bpf_copy_from_user_task() will go through
page fault process to bring the variable to the memory.
Also because of this extra work, bpf_copy_from_user() and
bpf_copy_from_user_task() only work for sleepable programs.

> 
> Victor
> 
> ----- Mail original -----
> De: "Jiri Olsa" <olsajiri@gmail.com>
> À: "Victor Laforet" <victor.laforet@ip-paris.fr>
> Cc: "bpf" <bpf@vger.kernel.org>
> Envoyé: Mardi 27 Décembre 2022 17:00:42
> Objet: Re: bpf_probe_read_user EFAULT
> 
> On Tue, Dec 27, 2022 at 03:56:06PM +0100, Victor Laforet wrote:
>> Hi all,
>>
>> I am trying to use bpf_probe_read_user to read a user space value from BPF. The issue is that I am getting -14 (-EFAULT) result from bpf_probe_read_user. I haven’t been able to make this function work reliably. Sometimes I get no error code then it goes back to EFAULT.
>>
>> I am seeking your help to try and make this code work.
>> Thank you!
>>
>> My goal is to read the variable pid on every bpf event.
>> Here is a full example:
>> (cat /sys/kernel/debug/tracing/trace_pipe to read the output).
>>
>> sched_switch.bpf.c
>> ```
>> #include "vmlinux.h"
>> #include <bpf/bpf_helpers.h>
>>
>> int *input_pid;
>>
>> char _license[4] SEC("license") = "GPL";
>>
>> SEC("tp_btf/sched_switch")
>> int handle_sched_switch(u64 *ctx)
> 
> you might want to filter for your task, because sched_switch
> tracepoint is called for any task scheduler switch
> 
> check BPF_PROG macro in bpf selftests on how to access tp_btf
> arguments from context, for sched_switch it's:
> 
>          TP_PROTO(bool preempt,
>                   struct task_struct *prev,
>                   struct task_struct *next,
>                   unsigned int prev_state),
> 
> and call the read helper only for prev->pid == 'your app pid',
> 
> there's bpf_copy_from_user_task helper you could use to read
> another task's user memory reliably, but it needs to be called
> from sleepable probe and you need to have the task pointer
> 
> jirka
> 
>> {
>>    int pid;
>>    int err;
>>
>>    err = bpf_probe_read_user(&pid, sizeof(int), (void *)input_pid);
>>    if (err != 0)
>>    {
>>      bpf_printk("Error on bpf_probe_read_user(pid) -> %d.\n", err);
>>      return 0;
>>    }
>>
>>    bpf_printk("pid %d.\n", pid);
>>    return 0;
>> }
>> ```
>>
>> sched_switch.c
>> ```
>> #include <stdio.h>
>> #include <unistd.h>
>> #include <sys/resource.h>
>> #include <bpf/libbpf.h>
>> #include "sched_switch.skel.h"
>> #include <time.h>
>>
>> static int libbpf_print_fn(enum libbpf_print_level level, const char *format, va_list args)
>> {
>>    return vfprintf(stderr, format, args);
>> }
>>
>> int main(int argc, char **argv)
>> {
>>    struct sched_switch_bpf *skel;
>>    int err;
>>    int pid = getpid();
>>
>>    libbpf_set_print(libbpf_print_fn);
>>
>>    skel = sched_switch_bpf__open();
>>    if (!skel)
>>    {
>>      fprintf(stderr, "Failed to open BPF skeleton\n");
>>      return 1;
>>    }
>>
>>    skel->bss->input_pid = &pid;
>>
>>    err = sched_switch_bpf__load(skel);
>>    if (err)
>>    {
>>      fprintf(stderr, "Failed to load and verify BPF skeleton\n");
>>      goto cleanup;
>>    }
>>
>>    err = sched_switch_bpf__attach(skel);
>>    if (err)
>>    {
>>      fprintf(stderr, "Failed to attach BPF skeleton\n");
>>      goto cleanup;
>>    }
>>
>>    while (1);
>>
>> cleanup:
>>    sched_switch_bpf__destroy(skel);
>>    return -err;
>> }
>> ```

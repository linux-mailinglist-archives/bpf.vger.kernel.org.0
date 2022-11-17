Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B3B262E758
	for <lists+bpf@lfdr.de>; Thu, 17 Nov 2022 22:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240942AbiKQV4I (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 17 Nov 2022 16:56:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234814AbiKQV4G (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 17 Nov 2022 16:56:06 -0500
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E68186D4B5;
        Thu, 17 Nov 2022 13:56:02 -0800 (PST)
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AHLfnB1024077;
        Thu, 17 Nov 2022 13:55:19 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=I4n0YSOfkDiVvuL81hSTn2QAjF5xZQxDfM912eIBAzc=;
 b=ZzI+vvQfazxzfCxTrTatn9q4IlJKKDDDSZAmdx/GtyP8UDD1aLuxPbSWv8ozsiM9ckN8
 ymRN1VKOTgBfCy4wdYhb0D1oQhpuM4IuPak8io2AZrGTvcFJCqNC6M6YQ91u9QRaq2Za
 6eYcG0xXG5jwv91EMpvSelyOhPLtkhhmnYQGtLsWS5aA0m7km4vtMQmL8RE8LqXNZR4B
 QdSfy+V7euA5mSVveY7SxaCdWaO4F+wElXdLy3kkhSpHbhWCIDMbjEuxgCbZSNeYu+1S
 hfEJnewOPtD+C2WxQoTdIWOihywf5wZSEbPR6BQULobMsQawUeQSxXKfQJq8uL087AuM nw== 
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2045.outbound.protection.outlook.com [104.47.56.45])
        by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3kww3e036t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Nov 2022 13:55:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hsFQvgD3XPwqLzKmShRG//TTNPurnynWbcDVdFiDMap32AHqZP46qcNm72zaxScGLHYg+CNdTczBkcFa7G2lK5yXpkK/R+uG/KZyN84PqDYokuUEiSfjKq0VL1od9CbCrtX3MeehtSBs8ToK8OgsRr+XJ+A8xqnxyybo5MFhh1J6wO2ScMZNoXGHRElHWAZhbj1U0Nd9Frp+x+Boef7rsP3QhEf6GdBARm6qp6QGfsv4CfoRtGhYh2+6zOEc/ckmDU8NY7ePkDd9vFiOPFyVbIb7iU84s+llcLR0Lia6SnVClN6C4jdeVCMLDoscMc4oTnMUIC+9G/Amg913xH/vJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I4n0YSOfkDiVvuL81hSTn2QAjF5xZQxDfM912eIBAzc=;
 b=LNr6CNf5KjneYKnCbKiYl+YzGUfTRDhIoYJM7wKNoQWDxC55BgGKkJGZ5x/8Rq2xh5eqRjlkB4EG8y3ou7+ATKBRIbO9ALh1jfKdw7UVbeGWuxZ1GBncGYTnayEZeGWg+9fnvF6umLgjltBwhVu3tOD7NSSSYFPY4jamHkB6SmeoQu8mwkzqULBVgnl5wzgLEhhth6SGM4mhwq9uK7jlfJMSTwEEU/Po6QSsNrKbOcczEY6cIZ6oIoP+BiLJ+RGNagxzIF0Wr4APmQJF0+g1lHeYIsItu4vERL0c3/5Un/B8aHqJI3CYwjF8b7r5XgwmAzwT54QWLdB2+AbrwKbtPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from DM6PR15MB4281.namprd15.prod.outlook.com (2603:10b6:5:1f9::12)
 by SA1PR15MB5797.namprd15.prod.outlook.com (2603:10b6:806:339::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.16; Thu, 17 Nov
 2022 21:55:16 +0000
Received: from DM6PR15MB4281.namprd15.prod.outlook.com
 ([fe80::f3bc:3948:5b3b:ae91]) by DM6PR15MB4281.namprd15.prod.outlook.com
 ([fe80::f3bc:3948:5b3b:ae91%5]) with mapi id 15.20.5813.019; Thu, 17 Nov 2022
 21:55:16 +0000
Message-ID: <d24cded7-87b1-89f5-fc2a-5346669f6d57@meta.com>
Date:   Thu, 17 Nov 2022 16:55:12 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RFC 0/1] BPF tracing for arm64 using fprobe
Content-Language: en-US
To:     Steven Rostedt <rostedt@goodmis.org>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Florent Revest <revest@chromium.org>, bpf <bpf@vger.kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        KP Singh <kpsingh@kernel.org>,
        Brendan Jackman <jackmanb@google.com>, markowsky@google.com,
        Mark Rutland <mark.rutland@arm.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Xu Kuohai <xukuohai@huawei.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Christoph Hellwig <hch@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20221108220651.24492-1-revest@chromium.org>
 <CAADnVQ+BWpzqOV8dGCR=A3dR3u60CkBkqSXEQHe2kVqFzsgnHw@mail.gmail.com>
 <20221117121617.4e1529d3@gandalf.local.home>
From:   Chris Mason <clm@meta.com>
In-Reply-To: <20221117121617.4e1529d3@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-ClientProxiedBy: MN2PR20CA0053.namprd20.prod.outlook.com
 (2603:10b6:208:235::22) To DM6PR15MB4281.namprd15.prod.outlook.com
 (2603:10b6:5:1f9::12)
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR15MB4281:EE_|SA1PR15MB5797:EE_
X-MS-Office365-Filtering-Correlation-Id: c2e606be-21da-41b6-9bf4-08dac8e6699c
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QigBVUR0wysH6WXqyEiWNF9aJ8TtbCeni4CQMS4NRXvzWa9fsfNEE0Mw2bf5Qfz862haBQ5g05jBi5QJD02tJ7yHAMFdiqND89wyhVd2QF4fTzmpG5KZ8iaSxQlo6N5dShSYerpG8IqhDdX4YjLhZ1L3Nbm9T/CATAx9gMt1swtgQPUdUfpUmqkYQ+d+aj0jvzqpdkoBwfjaQWp/IBf37LJxeuF573/HhylGSWmC7Uy5yLRmTAWU7gmxSqzOl3BLuPjBrEH19ZrkxdE/EzeTqL2pZc+i6LuR4bTpwCoFztPwgDofntI6MvF0naW9JnmWEzxPQULEW8XImBhHHRbuy0BxKPAE1y4qzAkDjglRwWL5ORQIA89aU/9LyOXiUlFQ31XE+Dqn2F1Lj6tAz4i0XkCjL0QUAFk/S9KV9KhlLmecp9V5j/YJyqpNYqSNMYNE0iu9/6GB6kW3Xm9JwtEyULs1LG0q66VF0PqpFO9ageiGqa/9kc7hgyrzFDnZtZWeu/7H3/1pLEJqza2EMB6nayxIK2cQqJqxbJNN13nIoIOOGGUIBPZ0t5U5wBLVSk6c7HFgE5L6K9iho0Gr3cc9L9jFGlLPa0DNfn57CDiLjK+B/vFq1D2YQk/t2O7Qd2jsXRzfwL98Heqn+/jSi9+cNFsLIG4VvuGEUGs0EMtoM2RnwbHrWatnDfGM+YhxrYp7sdUD1f4Sbxmes/JAr2kHyoWjvsOHkme+mblFWq6657F/+jFf1cSlpMQExBxeHFc7
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR15MB4281.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(451199015)(86362001)(83380400001)(31696002)(66946007)(38100700002)(8936002)(7416002)(2906002)(4326008)(8676002)(66556008)(66476007)(41300700001)(5660300002)(53546011)(6666004)(6506007)(6512007)(2616005)(186003)(110136005)(316002)(54906003)(478600001)(36756003)(6486002)(966005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG5VTFQ5SUlDVW9YQVBFNEdGQzQ5Y3EwRWg4OEJOTnNjQ0N2dTNnWnY0NlNR?=
 =?utf-8?B?M3Q0WXpLMEhIVmlaMkVPbCt4cHIyZFV3U3hWcFVNM05NYnpFeWpRUzB0NU5j?=
 =?utf-8?B?amZaalNPbGhWb2tHUExyckcwS1FtYVRzNUlkMTRnN0V5QmQzOW1NbS9zRkFM?=
 =?utf-8?B?M3NRYzlTZXZaTDVnUFRRZ3ljZXFyREUyTDBvNnBlR0VQQ0VxQ2xkZ0NsUEJ0?=
 =?utf-8?B?M0YyZDBBT3p6ZUQzaXg1UGZYbHFkUE5HNCtKd2tDMnRjYXFZMm8vdlVUOWFH?=
 =?utf-8?B?ck1zQ1RHTld0WUorVk43RXkxSllRenZrcUpUL2o2L1R2NHlTVitwUUFNT0tv?=
 =?utf-8?B?WU5mdFRVaVNoZmw0bDJ6dStsbzVVeUdrbmJxMDNFZEZTbzhWLzJLTDVKb0xR?=
 =?utf-8?B?ajJhMnNGTzc2Uy9BbUVNWWZYbTZaTVRMKzdEUTY1eEJxdnJ0alpFc25sZHZP?=
 =?utf-8?B?aVFPQ09PV01UVk05Y0JyKzZmUzA5N3lJU0laM0VCM25XbStkRVVFenZjUEZm?=
 =?utf-8?B?SnVMMGJvcWljRG1nN25LemVRZ295cWJoUzBGbDVleVdPNDRuckl6ZFM0Z0ZI?=
 =?utf-8?B?R2FHaHU2eWJoUHEzZkorczlZbjAwZWs3MFM0L2t6SU1LU2ZzYkw0cm1MSmZY?=
 =?utf-8?B?SjFGakZla0pEczVkODBIQzNzSHlqNCt2NTRRY3J2VDljZU02bkxTNERlS1lw?=
 =?utf-8?B?OGVtRVBZY1U4MzBrVnoxU2YxMUZBUzZKZnBYTXhZVGs2VlJNNkU5STlOOXNt?=
 =?utf-8?B?MjV6RG9Ubk85bXo4MlRJRjZLMTB2M2JZRndCYmVLUURqbDlwWHRSRVBSVlNI?=
 =?utf-8?B?T3hwaVpubjEvVldTTnMrZHdrbjdMK0lBdVFBUi93Wmp0Qi9ySUUrNzFpVUpN?=
 =?utf-8?B?Sy9vYlh1WVl5UFhpL2hNSFRqaFNTOTlHcHlMcjdIY3F5Mm9sNFV5TS9KM2FD?=
 =?utf-8?B?VytFVGtHdmlEd055RnBaTlUzWkpmZWFHUGpTMWl6d1J1aGY2dXZsdngwY0dx?=
 =?utf-8?B?MXJjdkZlUUptaUp0SHJXQ3hNbEVSZkIyVERrZ0VuaHdOcURockFCcmwzTU9J?=
 =?utf-8?B?VE1BV1ZaSUF3U0RCUGhqOFpUQ1NBNVZ4ZzZma3Nqcmg1ekhkdXFobllSSzVN?=
 =?utf-8?B?a3Q0aWtyNTlmeTRndGkyb216SlN0blVDMFFCR3hPdGx3bnpDdkxxd3Rod25j?=
 =?utf-8?B?N2pRZFdzaUV6SWhhRWN0cjNXcEpydjNtb1dsaGcyMGZ0aDQ5aVlyV3pEKzcy?=
 =?utf-8?B?V2hvNDRSK3BJTlFLTmFFczB0SlFyMHdwbTZjUGJBNHJlU2JnYm5lRmpTSGdn?=
 =?utf-8?B?RVorOHdCbUhXUnJ6SDRmRnFkekVENW4vY0tlZVBuMnoweE0vQ2lhWVVJVkJJ?=
 =?utf-8?B?UitWK1FGVVY2SlViblFqcHh1WDB3L1h3bXk5UVFoellCck9xUEFmS2pmamVj?=
 =?utf-8?B?WEdkKzB2RWt4MzZnanM5Sm9aMFVaclRHRUNuVHdwbFJ2K0ZURWJJNkpxYlNa?=
 =?utf-8?B?ZGZrdEdQMmNYSU9KTSt6Umh2R09vc0ZYMFpKM3BqNE1FZmJOOWpaSVFlTm8w?=
 =?utf-8?B?VnRmd29MSFhIWGVkcndtV2o0SzRSZDlOcHkrYU9RMmZGelZmemZrY3BQMElX?=
 =?utf-8?B?ekZYaURCL3diLyt5bnNTRUU0dDBrSmE4bzRWMXkwZllydk1Xb3dESDE3V2M4?=
 =?utf-8?B?USswQUVsNXlrODZpRWUwT0lZelpxdkxyUlhha0tUR2xkRk9kbGhMK1hOSmFi?=
 =?utf-8?B?U2tzZTlFTUppdTQvVFAzcEV5bUJDZ0M1YmsyZmxZYWhDNEpzRGJwNkJCZFVR?=
 =?utf-8?B?anZLTGVVY3JLNklucDZuT1ZlQUc4NWNIVU9BYUtFVW5tWnpLUU9VM0ltczNt?=
 =?utf-8?B?UldVMEU3MzArb3dYOGEyMzE2Q2M5YXM3TmdmUFkwM01kVmpmTU1ZUU9SbHY1?=
 =?utf-8?B?MVo0UEVmbENUdkNPV2NPTjdqYTVRcGoxc2hsSThXMnZNQ2JvNjZVTmoralVm?=
 =?utf-8?B?RGcwVzY5ZS9hOTh1UU80YS80NUVHNlVLaVFUKzI1bGFMWXNPNjRiQjkyeGlS?=
 =?utf-8?B?VGtJSDMydXZLbmkvTVU3S001NWZQV0dBTG9WaUxKVGM0bnBZcVN2dnhkQ3E2?=
 =?utf-8?B?bzdrTG0xODFIdmxIS0dJNjlSYXJHOEZ0VzR5ZFUxUUMrRG9qRFNMcm1yajB3?=
 =?utf-8?B?VGc9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2e606be-21da-41b6-9bf4-08dac8e6699c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR15MB4281.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2022 21:55:16.7813
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XhAhB5lE7H5FBxNeN4W8zq4rgbfkeg0oJMLTf+88NHt+J7vEJGmi1nestVjPB+LR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR15MB5797
X-Proofpoint-GUID: 2k7snr9KSlY5ZR2vWinzpb0jC7sS9WRg
X-Proofpoint-ORIG-GUID: 2k7snr9KSlY5ZR2vWinzpb0jC7sS9WRg
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_06,2022-11-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

On 11/17/22 12:16 PM, Steven Rostedt wrote:
> On Wed, 16 Nov 2022 18:41:26 -0800
> Alexei Starovoitov <alexei.starovoitov@gmail.com> wrote:
> 
>> Even with all optimization the performance overhead is not acceptable.
>> It feels to me that folks are still thinking about bpf trampoline
>> as a tracing facility.
>> It's a lot more than that. It needs to run 24/7 with zero overhead.
> 
> It obviously doesn't have zero overhead.
> 
> And correctness and maintainability trumps micro-optimizations.

During the bpf office hours today Mark Rutland and Florent had some
great ideas about how to wire things up.  I'm sure Mark will need some
time to write it all down but it was a fun call.

> 
>> It needs to replace the kernel functions and be invoked
> 
> What do you mean by "replace the kernel functions"? You mean an existing
> kernel function can be replaced by a bpf program? Like live patching?
> 
> This seems rather dangerous, and how does one know that their system has
> integrity? Is there a feature to sign bpf programs before they can be added?
> 
> Also, it may be time to bring in the lawyers. If a bpf program can replace
> an existing kernel function, then it has definitely passed the "user space"
> exception to the GPL, where user space must use the system call interface.
> By injecting executable code into the kernel, especially something that
> replaces kernel functionality, it becomes arguably derived from the kernel
> itself. And the BPF program must be GPL.
> 
> Allowing proprietary BPF programs to replace kernel functionality looks
> like a clear violation and circumvention of the GPL. But I could be
> mistaken. As I said, it's time to bring in the lawyers on this one.

https://docs.kernel.org/bpf/bpf_licensing.html answers most of your
questions.  It was reviewed by lawyers and also discussed pretty
extensively on the lists.

The short answer to your concerns is that you can't replace kernel
functions from proprietary BPF programs.  The LSM and TCP congestion
control features intentionally have GPL only support functions in the
way.  bpf_probe_read_kernel() is also GPL only and massively limits the
things that can be done from proprietary code.

This list of helpers is pretty current and details which ones are GPL only:

https://github.com/iovisor/bcc/blob/master/docs/kernel-versions.md#helpers

I know there's a long and glorious history of collaboration around these
parts of bpf and ftrace.  I really hope this time around we all come
away feeling like the technical discussion made both projects better.
Mark and Florent today certainly made me think that was the direction we
were headed.

Along these lines, I'm also hoping to avoid diving into old debates and
alarmist conclusions about GPL compliance and signed bpf programs. Or,
if some part of those old debates is no longer valid, can we split
it off into a well researched separate thread and focus on technical 
bits here?

-chris



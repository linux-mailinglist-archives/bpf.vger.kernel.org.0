Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A28F866D5D4
	for <lists+bpf@lfdr.de>; Tue, 17 Jan 2023 07:03:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjAQGDN (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 17 Jan 2023 01:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234974AbjAQGDD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 17 Jan 2023 01:03:03 -0500
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D020E59E2;
        Mon, 16 Jan 2023 22:03:02 -0800 (PST)
Received: from pps.filterd (m0001303.ppops.net [127.0.0.1])
        by m0001303.ppops.net (8.17.1.19/8.17.1.19) with ESMTP id 30H4L8Jk004689;
        Mon, 16 Jan 2023 22:02:43 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=s2048-2021-q4;
 bh=gQyfs56l7ZgryXGEEZKuKo+kXVLKzQNv8Er+0Mn5DpU=;
 b=Wek0+7VW2LLZUrgLLrPtgTRgUxuM+WEsJL5GzJk8eJyxsMKAnlV/xefXQc4wTpzNeB87
 RaryXiRsDlMD/fa755D2jEV4hb2Y8tCPk5vCrl/D3Q1WhqZZKfs1uoMRw27xQi0Hq26K
 4rzHYBGlQMyrtSCJ9vhur8qXN4ZKq73hIvSZ8O84sqk008+ktBuUW2K91phKn2apef0h
 15PeokDTxq1Ee+7Vl4M4bdWHanZnxmU/4w6McgFv18fJSUuyXEjS3wRIICnkR1l82V+r
 4r4erxVzc/PD8s3kEjp1hdry0YeLnKJZQz6shGyryXba48zRbF98QzSUdHuGDqKXuetY WQ== 
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by m0001303.ppops.net (PPS) with ESMTPS id 3n3ry4txc2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 16 Jan 2023 22:02:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j3bxebYaMP1NZ5+usTcQ779/FYhspzS8YYZDdP8d2u23tQCkiFGEpvERqBwP5kQJrhTOKeI4kJJKYNcCtWhQav2ve1iuTznjnRa2fwVY1YFs0TFjIk7YJthEo6pxMpoG9L4fegRt+Rcm+GEksZIUvOOgjeDW8/EjUlcDOGzwUFiaH+y0aUdwi3bJwkAMhn3TkNdkAxfdp+17igU+f2lffcjjHDj5vMWtOo5fefUXy+u54TQYyjFInipWpeNYfpZ1+OFIkLzCmtiZ0InS+hdOykUyyXUeGgKf1ThJkJgBvTJTovpFHUYxhaH+OGiNhoHlBMkMslsl3Hh4N1sYOuD71A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gQyfs56l7ZgryXGEEZKuKo+kXVLKzQNv8Er+0Mn5DpU=;
 b=c/hp8dgkeVxqmDhTH2iQf8Q3r1BO7clLcKN2KgeNikZR+P5yg2W3NyaEOoc9z3Aa2e7uenimpT3fWaRzFMJOovZlKrSaQZUHcYYYEomn8FwA0xqSoY+xe1SWEFlehUR6rWVoO4s8N1EWG6jD6C7a0QjtEjSS/VXzbDxrsKdQack88ayyxPBezopkLu9URsXhmcAg3fwl5zt4M5TTONHviOqpgCZGg8+6wpPIoAhBbeLgaha1e1auYGJGccvSm6067psliXHJ63VKc0NOoYJPYuQpvrrYx+6FGNi3Z5xBAnUafuv2Mga2u6RiWBrciN/17cmHa2xuP3VtnPTbwVxK0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com (2603:10b6:805:d::27)
 by BLAPR15MB4052.namprd15.prod.outlook.com (2603:10b6:208:276::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.23; Tue, 17 Jan
 2023 06:02:40 +0000
Received: from SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0]) by SN6PR1501MB2064.namprd15.prod.outlook.com
 ([fe80::3cc9:4d23:d516:59f0%4]) with mapi id 15.20.5986.023; Tue, 17 Jan 2023
 06:02:40 +0000
Message-ID: <0d2075a1-74df-96fc-ae42-3c9e10daab2a@meta.com>
Date:   Mon, 16 Jan 2023 22:02:37 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: WARNING in debug_mutex_unlock
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     bpf <bpf@vger.kernel.org>, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        David Miller <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20230109074425.12556-1-sunhao.th@gmail.com>
 <be494ee3-864d-1a33-e14d-d27712ab6248@meta.com>
 <C4BBA1C3-C704-49D3-8E13-18875B27FB47@gmail.com>
Content-Language: en-US
From:   Yonghong Song <yhs@meta.com>
In-Reply-To: <C4BBA1C3-C704-49D3-8E13-18875B27FB47@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BYAPR11CA0060.namprd11.prod.outlook.com
 (2603:10b6:a03:80::37) To SN6PR1501MB2064.namprd15.prod.outlook.com
 (2603:10b6:805:d::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR1501MB2064:EE_|BLAPR15MB4052:EE_
X-MS-Office365-Filtering-Correlation-Id: 661f91a6-1b24-4958-5571-08daf85070fe
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7d5o3M7RxYfUTeJVDzZxw2TykFrCvXXM1GkYt+TaKvbpOZBlfbSYCWVfVSdeMp48FOYgY1O8P9KIU/HW8akOn4eQGEShb+4QdnknbHaEBx85cITy25m43LWRtETdW4zLuEnoU6FYYD8oaw83pMi2fKjMwAS8SX3855Wa3VE3itF+BfkHH9JoA3jto8b4RTxyS27TBxmdxYiiIdZgwCkB/GyfZJm8QvN3zVIWNj0Up+xS5vD6U4il2YuuUv5qF5fFe8ytUj9XQwpIV4BjCp7HMftxD/jp4tWo545MflrZTsUIcsH1K++rTqzcVkVII03yXxNuAdUG9jtOj4d/wgt5jDFyPx+N3s1KkjUV3GCibZybTN4Cy7UdJiF8FhLZMvpPjt9NGc8AoLJXBZz7tLeQkL8GZ3yQ3kN/LruIu67DmpKuyzylfQhxpxfrq5Jr/7Af0wn8yfA6VvFaM0Z7aeEGE4NBZSA4/NZ6XMZEoEW/cZqfZFvTClpUv5ZUeQm34K+p9UlKefOq95YNp9QKy7SBQE7yCQWwTlfn+zTL+s1yHs/I38HZvSf/vJNl09MZqxwoHbt/xxeH9JLOiy2+vRljit02W109ldUR2aDg/BHgUbIxc9fBskNNQ8Pig8t+H4cKXJwjfBANWZFfraPFn9R9w3BdLTiY33NM81Va8FyxhAAWuDvuUa0OyGDJCYJYmi/wfFUzaI+1BOjSmUXGctBqOmeUAJLNj3cPiwnUp61vzFI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR1501MB2064.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(451199015)(31686004)(6916009)(2616005)(66946007)(7116003)(41300700001)(66476007)(66556008)(186003)(53546011)(6512007)(8676002)(4326008)(86362001)(31696002)(36756003)(5660300002)(8936002)(54906003)(478600001)(6666004)(83380400001)(6506007)(316002)(7416002)(38100700002)(6486002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eHF5ZnFDT3A4aVpGQ3Z2cUtuMmJTaXU4ekVnQ1E0R1RLTEtiRkF6NFVoSmNB?=
 =?utf-8?B?elRwNzh3SFRvQzhLUGkyUFNyNUx6eExLSnBjcWZBNlZEc0xDMnRhWmpUQ29S?=
 =?utf-8?B?RWhLbWZoc0duVXpRWUtkNW5ZWU52eTkwR1QvKzhvOUpKK0J3bnR5STRZZTJJ?=
 =?utf-8?B?b1Y1VVRTWHFvc3dLWFI2N2ViYjhvU0dmcFdIelBtdm10U1ZRN0pXcE95M2E3?=
 =?utf-8?B?YmVRYUdvYUhHR1c5aVRyMzdnNmVQN1A4TDUxSTVjam1GUWhGS2xwT2JIUCt3?=
 =?utf-8?B?TGJrU3lzTzhQcEVKaGt3cFgxMUZSUkZJRTZkZ3V3ekk5MlhZd2hydkZROVRD?=
 =?utf-8?B?SGRvVUNUOGJoZFpJSlBOZ3VLK1Ztc0x2S3ZydEJ5RG5qUEdGWndxenMvSDZM?=
 =?utf-8?B?Y1FvbUIzaG5CRFBhemNscWpXK21iTzJJYmhLbzEzLy94WWg4OG0xYVErNmRC?=
 =?utf-8?B?UWhydlFKUUY5N2NJa24wUlA4R3hsUHRLQkp0ZWh3N2ttakgyWlpscFpPSFNh?=
 =?utf-8?B?bzQ4bnhJYnJIYmk5c1pEaGpBQUg2Z2c5MGVMRC91SWU3TG02YWZaQkZNZ29Y?=
 =?utf-8?B?alhYRlBWeityZEVYMEVDMzVscWY3QVJkTzUxcVVSUGx3S3RZR0hBWUhZczJO?=
 =?utf-8?B?c0xxZGYwVFdPd011aithZEZmcFlRVXhmbHM3UmNzR3RmaG9YN1cvTkxuam9w?=
 =?utf-8?B?dEJLV3B5MVJiUlRHaldWZ0R1eDBQUFUrK1FZV2h0MUFWeFFkSU5tWTg0ci9R?=
 =?utf-8?B?dnViN2RTT1RTNjdyUG5SSGlQTzlBZXpRa0dBVnJmT0ZTc0hCcXhoSHBMbEVn?=
 =?utf-8?B?Z2sxT3ViczZtQ2hpUXNhSnVCbE45dHpNYm84WlhnU3Q2MGhCamZxSmFxTmxt?=
 =?utf-8?B?REVPb2lMVitLR0dud0ZWcDBDMkJLSER0NUg3VFZpcXZmbkpWU3RoaytnMEt3?=
 =?utf-8?B?YlJZVEpDcVNWMUZCZjNDUC8rS2pITGtPTmo1SU5PT1NiTklEQ3djWThOWEw4?=
 =?utf-8?B?VG9PNHJ3aW9IcVpiYWVjRXJrcUczZktXRlhQV29iVkFBcE4ydXYwanBHeXZS?=
 =?utf-8?B?VkJFeHl2ZFJtZm5NSmFHRE1lcGwzUHdUWlNIMXJPcWY3d0ZxUWthRnIvRVNG?=
 =?utf-8?B?T1hBejdrTkJET0F4WExhdmw1WnlNcUxKLzJPNDFVcXh5WS8yRGZjQ2dHU2xu?=
 =?utf-8?B?ZEN0RUxlMlNLSlUyWXFOdm1EYU9Mb3dQV0xUU2Mxbkc5R2cvcWhnZHFpZWJh?=
 =?utf-8?B?T0tESUQzbzY4VzRrL3R3OUJaOUhiT1dzS3hGa2FhYlY5YjRFMFcxL2pUM1hJ?=
 =?utf-8?B?MERtcUY0eVdyR3pKS0RvaVNlMTNWaThEZEM4YW1OSVhEMVpqVWd4cDdEY0dD?=
 =?utf-8?B?cWJJTlBEeFREYk5oVlE4NjNLV3NBTk9nRGljWW1ORFdBZWhsS3RYNi9kN3VU?=
 =?utf-8?B?dWtYZ3EwaWdyRzNiczVqNHZaZXorUVdTS1JDYmFGbEtDU3IwYk8wbWlMTENF?=
 =?utf-8?B?TkJvbHZVZVNkYTliMlN6b1FmTlkvUHNxUFlUZ0pDYUJzeC9ITEtQOWYrSWhq?=
 =?utf-8?B?TGJIeVIvM0poSEV0NXFxYnoyd3NXa0U4U2k1QjJ6cmQ2Uk4vWG9PMkNlUk5n?=
 =?utf-8?B?Vmd2U3BQM2g3RkZtazNibndpTkg3cUVBVHpSK3cyY3RNVU5yVmVSVHg2azdl?=
 =?utf-8?B?S0g5dGU4TjFtYVBtTldsNkFLWDNZMk1qekJmY2xzT3drNjJIa0FuczVKR200?=
 =?utf-8?B?NEwydUM0WDdHNUtSWEFUTTVxKzdwZnpmM2NkNWVhY3dYYXM4djk1cVhGZlR5?=
 =?utf-8?B?cURJOTljelhIUFVsSStCQjlyVzE2VkFlcmVwNUQyQkxKM21pUWJHOTFwYjVW?=
 =?utf-8?B?dmpjSVVFWW1zV3A0eEZ1K2ZPQkZwSlVoUUJaZEpSOFpiQ1RlMHdDaytZcENJ?=
 =?utf-8?B?NHJBRC9DSHNOZWVTcExibm80c0g2dEhuUFZoMWNMamFEejRyWk9zZWFRK3dy?=
 =?utf-8?B?T21XRUY2WXBnSGZpeHJyOS9pTk9sZ2NaVmluUFJ3Ynh2Rzd1Q1VVb3JneFd3?=
 =?utf-8?B?MVgzc1NIc1VtOE9pMDdKdWNpNnZ1cFRTQXdVVkx0RmVVZHJGeE15YU1XdVN2?=
 =?utf-8?B?b1h0bmdTWHYwSUtHNDdrUko3bCsxbm5vSVF5SWxaemoxM2lhVU5IQk9CKzVk?=
 =?utf-8?B?ZVE9PQ==?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 661f91a6-1b24-4958-5571-08daf85070fe
X-MS-Exchange-CrossTenant-AuthSource: SN6PR1501MB2064.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jan 2023 06:02:40.5322
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vFEXsHicrphkR5ri5Z2wCziLiORMOw5X1Z17ERMOuiHT1R07f/kzTL/H5ut3PcrH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BLAPR15MB4052
X-Proofpoint-GUID: b_gkD3GjpBrNOlem4xNhlAG2jvcEGP0g
X-Proofpoint-ORIG-GUID: b_gkD3GjpBrNOlem4xNhlAG2jvcEGP0g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_01,2023-01-13_02,2022-06-22_01
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/15/23 6:24 PM, Hao Sun wrote:
> 
> 
>> On 13 Jan 2023, at 2:45 PM, Yonghong Song <yhs@meta.com> wrote:
>>
>>
>>
>> On 1/8/23 11:44 PM, Hao Sun wrote:
>>> Hi,
>>> The following warning can be triggered with the C reproducer in
>>> the link. The repro starts 32 threads, each attaches a tracepoint
>>> into `ext4_mark_inode_dirty`. The prog loads the following insns
>>> that simply sends signal to current proc, and then wait.
>>> Seems issues in queued irq_work with `do_bpf_send_signal`, also
>>> I'm wondering what if the task in `send_signal_irq_work` exited,
>>> at the time the callback invoked.
>>
>> Somehow, I cannot reproduce the issue in my qemu environment
>> with below kernel config and C reproducer.
>>
>> But could you try the following patch to see whether it
>> fixed the issue in your environment?
> 
> Tested the below patch on my local machine, seems fixed the issue.
> 
> Before applying the patch, the reproducer can still trigger the
> reported issue on a latest bpf-next build; After applying the
> patch, the warning no longer appears.
> 
> The test is conducted on: dfff86f8eb6a (“Merge branch 'samples/bpf:
> modernize BPF functionality test programs'")

Thanks for testing. I will submit a patch shortly with your
Reported-by and Tested-by.

> 
> 
>>
>> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
>> index 23ce498bca97..1b26d51caf31 100644
>> --- a/kernel/trace/bpf_trace.c
>> +++ b/kernel/trace/bpf_trace.c
>> @@ -831,6 +831,7 @@ static void do_bpf_send_signal(struct irq_work *entry)
>>
>>         work = container_of(entry, struct send_signal_irq_work, irq_work);
>>         group_send_sig_info(work->sig, SEND_SIG_PRIV, work->task, work->type);
>> +       put_task_struct(work->task);
>> }
>>
>> static int bpf_send_signal_common(u32 sig, enum pid_type type)
>> @@ -862,7 +863,7 @@ static int bpf_send_signal_common(u32 sig, enum pid_type type)
>>                  * to the irq_work. The current task may change when queued
>>                  * irq works get executed.
>>                  */
>> -               work->task = current;
>> +               work->task = get_task_struct(current);
>>                 work->sig = sig;
>>                 work->type = type;
>>                 irq_work_queue(&work->irq_work);
>>
> 

Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF4472F0D02
	for <lists+bpf@lfdr.de>; Mon, 11 Jan 2021 07:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbhAKGui (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 11 Jan 2021 01:50:38 -0500
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:49150 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725536AbhAKGui (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 11 Jan 2021 01:50:38 -0500
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 10B6mw95030657;
        Sun, 10 Jan 2021 22:49:55 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : references
 : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=efbTYMcenLTH+v2mx7MKjmbTgSLDt5VEMfVojDA0orA=;
 b=T/ihjeM1WSHfj1yOeFRFK33Mw5BdnfDOghajgSRIdZuaAWQQ2+PBGPp3F5Ui/IR0zJB8
 cowLdLFS9BOqkLWJep314MNjGgBc9y6O6Y9WyIzu1z/M/qo/FnT3vDNukKx9hg8azvOK
 JRnnBjOYJ0Q05oNS/3gk6Tn4BQ5zECR8hjg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 35yw873avr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Sun, 10 Jan 2021 22:49:55 -0800
Received: from NAM02-BL2-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.198) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Sun, 10 Jan 2021 22:49:53 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITtY6BgVmViR5aKBN524w6cMdMlABYSQnV2Apz61ofRa5w76gDMYU+yMfHedSxZMs/yx0PozYzLeCPQSys7ACKoWaUfvyu2IhbQmAalQ2ZGo3EurnkY2W37vheiJgor01wI6LyqDyZnXVKOc0k1sqTLpOOwyFUNeep3tRmIVzo32eLDOKbzG794GiAaeyxGJWCkXnbX+5Mid2CjhHg37wKXvMgLPpYFSz4c2f3jTS2pVbSPCBo4Pt62mtSgFvQjOWWF5HQ069da1qPOislMUwEaYfeW6/OVeEBnzfHjjgnCzcou54m9nnK3qQLFyAXvb7PUja9wHA+Bv9e/wvJxCKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efbTYMcenLTH+v2mx7MKjmbTgSLDt5VEMfVojDA0orA=;
 b=SHanFHwwfx58Im7jwsz1PrNETfNbrvNIWqzikZQelaU9flTVDIUvECWHUerBKi0zbUunEj4oD/apj03SVMw50TfZeSq8tIbOCkXkppClLXfyXUDlli7UDO2ZX9X5rrP644VckT7UoBTVOCWVB3hadu8TKp5vWDm6swx11c8/aI4DIyUEZvXdkr+ZazrxG9/dGNUZJ0tzvqsH9lt0zVfI264SARcyhdz7TvUvug2WH06D8Sq5W4SCOXyHe4/HHbo5x5xWJXhI0yDnCjjUphhJLaNdNqvLOKtvPnkcoEIa9j31mVwjys7orPXPZQTd9LUYBZ+/n5jqbxXoHx8Aa3ViaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=efbTYMcenLTH+v2mx7MKjmbTgSLDt5VEMfVojDA0orA=;
 b=HTGyThYBRL2fbYpO1TvGBpZ67W6FQByDU1CtNFtGhpt71nes2qkUbWGHEPlyED1zBdpuZp28Qey5VQkI/xuWVBQniubOFDU1BgIyRhe7yPTcHI/QpVHH9eo4b1wJdMXNpzuqSNp1DKE+lIRw3deY42rmq+luZ03w0ARpBAXWt5M=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BY5PR15MB3666.namprd15.prod.outlook.com (2603:10b6:a03:1fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.11; Mon, 11 Jan
 2021 06:49:52 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::9ae:1628:daf9:4b03%7]) with mapi id 15.20.3742.012; Mon, 11 Jan 2021
 06:49:52 +0000
Subject: Re: verifier fails after register spill
To:     Gilad Reti <gilad.reti@gmail.com>, bpf <bpf@vger.kernel.org>
References: <CANaYP3Fo3eHCxs-3Dpurnf0Q3HhCcaJ4rD5JjQG-VPzYnfKchw@mail.gmail.com>
 <CANaYP3HowJ6FZ_PGx3uuLGf3sq6RQ1vYnCRCp-pDgU4gW6K31Q@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <ce1fd86e-131d-9466-d224-221e33384bc8@fb.com>
Date:   Sun, 10 Jan 2021 22:49:49 -0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.6.0
In-Reply-To: <CANaYP3HowJ6FZ_PGx3uuLGf3sq6RQ1vYnCRCp-pDgU4gW6K31Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [2620:10d:c090:400::5:6067]
X-ClientProxiedBy: CO2PR04CA0137.namprd04.prod.outlook.com (2603:10b6:104::15)
 To BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [IPv6:2620:10d:c085:21c1::1158] (2620:10d:c090:400::5:6067) by CO2PR04CA0137.namprd04.prod.outlook.com (2603:10b6:104::15) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3742.6 via Frontend Transport; Mon, 11 Jan 2021 06:49:51 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: fb1d9794-5cf5-486b-a556-08d8b5fd18e9
X-MS-TrafficTypeDiagnostic: BY5PR15MB3666:
X-Microsoft-Antispam-PRVS: <BY5PR15MB3666A6C9A5315613AE238F2FD3AB0@BY5PR15MB3666.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IzlWOp+4ooUgGzXIPTVo0PrFcYgZBsDtBYr+pcO7yoiVWhcoAA8klHAk6lKoyf0eqPMSGNiw4FlyUokNmo4+JrzY8RFVJ4Y5rON90xXTbHF9uy5G0XBRNcPZHzyfSKTZ5y+OxHaR3zdJoItFiY0Nyu9dF1+z+kcJPTTiZHOBXZMoXcIP3FOZlHXlkdriDQ+l3USziRqztUxrAf2kQkryPxquAAB82waoIgKixWrn8ka2+YQuA5S0S4meV+MAeii7UpnyzrjiEvsBqweD3Qvw5g22QDALMiK33H7HyRK4ihnQb8+JNQaO7FMyHuW68gbqU0kcJD4Iig2PbNRWzdl7/uJfpIc3zAzX4tEhCmysZpdBxB66JkVQGsvUfOMlhyRysHFSn6Qb8p31ELsLCpl+lfuJXs2UAM0hOkLyqJ2UzHGxrUBVffpnNWW8huqwwISQxqaCvvFAxpfu2IaTdHMSpmRQkTAh+mLtWG//ZV+StE0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(376002)(396003)(39860400002)(346002)(136003)(6486002)(2616005)(30864003)(2906002)(110136005)(8936002)(66476007)(316002)(8676002)(186003)(478600001)(66946007)(16526019)(31696002)(36756003)(52116002)(53546011)(86362001)(31686004)(66556008)(83380400001)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?MXgvRW1zUFRFMUpNYkNmeDd6RnBqZHRoQXgwNzlaWHoxVWs5R1lqSUVoeldx?=
 =?utf-8?B?cXlVQkFVYzVrVksvQ3hNdWtITzYySjNtckY2MVdCNk1KdjRpSE1uNy9wQmVq?=
 =?utf-8?B?Rks0d3JmYWY2WVpXNytCSVZ1Zk1aV1d3Nm9QaWtSN3dvUmtMME9YYm5XQTQ5?=
 =?utf-8?B?c2h4SzJZWnRjOUtKVGkrMXp4K3luTm5pMlFIYjdWYi9aUDRVVjFZT1paSURv?=
 =?utf-8?B?OTJ6QzgySFdaYnU1QWxzaGEzSCtsZUx0bjBWdkFDR3g3RUtzakF0QWJGNHVy?=
 =?utf-8?B?OGZtNjFobGR0TVBGWHVsU1JqN0ZLSDcySlBseTNRNGQrcGpSMjdTSDMyb3Bz?=
 =?utf-8?B?Tmd0Q1BNWWRTZzFyK1hvbFU0ZjhFbzExUkZnRVNYSjZXb1BmSnhNT2ZwdWd4?=
 =?utf-8?B?bFJ5MUJxQTREN1VKWlgvWTZaQVFTMFdOZnA2SVpMTENvRmZlaVBLRUNyTGVp?=
 =?utf-8?B?RWxaK0RBV0REUUJ5YkhJWFhqTld1UE9vbGhqZzVwTlFmR0U3TVBxNmNmekxw?=
 =?utf-8?B?UUhaUi9WSUFQRGk2SjVkSEp5b3VnTzc4Q0ZPeE9HRFFjanlGYk9uaE5BM1pK?=
 =?utf-8?B?c2RyWHdzeE5RS2tvT0VhL0JSUG9ubVEwVytPSlc1ODlua2hHSGxqUGExbVV0?=
 =?utf-8?B?YXNSZFNRNExjeDVSOFRtSkVaeFdPVE14bU95L1BEZ29UM1htWlN1TjB2eG01?=
 =?utf-8?B?YnFBYnZWWDN3VnBKVTNzRS9KcWk5Q3YreFF0aHVYNFlxOEdiLzRIbTlobUZ5?=
 =?utf-8?B?WTN4N3hvSDRpWVQ1alNNYkg2b1dOZllLbHI0ZmR0QWkreUpVcnlKVHRyNWVJ?=
 =?utf-8?B?YlZlazkzaXZFMnJZN056blE5aENYeEN1WWU5cWM0d2RCdFo3clhMSUZrbUp1?=
 =?utf-8?B?VzNhM0hCaFppc0M4NE5VMlBkQ2p0UTNVQ2hjb3NUTDNJMFBGa1czRVB4ZHBM?=
 =?utf-8?B?dFZxUSs3TWwrbU53UWdaV0lNWFFqdWpCUFcvT3JURDE0SnpVZng5dlJjdXJ3?=
 =?utf-8?B?eURrTklkb0JHT2ZSWkdGOHJWemlTaThCdEJhU1ZiNC9hRTRiS1ExSWVMUS9u?=
 =?utf-8?B?Mk5LcERJaHR2UEFBck5rbWFvZDNKUTNjZ0FSMng5TTN0RjBOVzYyY041ajFH?=
 =?utf-8?B?MGZNVGo1ZDFsUnlnZnhDbGNPY21hUUM1YmZtb1c1MFU2QkdDdGJWbTgxUlNN?=
 =?utf-8?B?M0NHQ0h4c3M3MnRRRzhIL3ZyQytDdGxkMHEzcHVTWTBMSnd4MUVQUXRPK0xn?=
 =?utf-8?B?TCtSYlFZb01OZTlaVmVSMnh3MUlDVHl1Z3dYWkZpdFk1YmsrUE1XRWhkbktP?=
 =?utf-8?B?RlJzNlRMMWxld0VXYkRQbXpYQ2lydTNTYWZwY0QvZ29sQklxYjlYMEEvY0lH?=
 =?utf-8?B?blE2YXNuTDNxRWc9PQ==?=
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2021 06:49:52.0624
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1d9794-5cf5-486b-a556-08d8b5fd18e9
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xJ/nUWgA4Kh0qwQaAP9rT96BaPK/PquzlPfDMVlvh6s24CODQxb1A2MdlM6vWq3V
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR15MB3666
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2021-01-09_13:2021-01-07,2021-01-09 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 bulkscore=0 clxscore=1011
 impostorscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2009150000 definitions=main-2101110039
X-FB-Internal: deliver
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 1/9/21 9:27 PM, Gilad Reti wrote:
> Hi,
> 
> Sorry for bumping up- I just want to know whether it is a bug or just
> an yet unsupported usecase.
> 
> Thanks!
> 
> On Wed, Dec 16, 2020 at 2:40 PM Gilad Reti <gilad.reti@gmail.com> wrote:
>>
>> Hello there,
>>
>> I am having an issue with passing bpf programs through the verifier.
>>
>> For a minimal example, I took andrii's examples from libbpf-bootstrap
>> (bootstrap.bpf.c) and added the following lines (to forcibly claim all
>> available registers in order to cause register spilling):
>>
>> int a, b, c, d, e_, f, g, h, i;
>>
>> a = b = c = d = e_ = f = g = h = i = 0;
>> asm volatile(""
>>              : "=r"(a), "=r"(b), "=r"(c), "=r"(d), "=r"(e_), "=r"(f),
>> "=r"(g), "=r"(h), "=r"(i)
>>              : "0"(a), "1"(b), "2"(c), "3"(d), "4"(e_), "5"(f), "6"(g),
>> "7"(h), "8"(i));
>>
>> This causes r7 (the register pointing to the ringbuf reserved memory)
>> to spill out to the stack, and later when it is returned to the
>> registers it is marked as "inv" which causes the verifier to reject
>> loading the program.
>>
>> My setup is Linux 5.10.0, clang 11.0.0-2.
>>
>> For a reference, here is the complete bpf program (userspace program
>> is the same as andrii's):
>>
>>
>> // SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
>> /* Copyright (c) 2020 Facebook */
>> #include "vmlinux.h"
>> #include <bpf/bpf_helpers.h>
>> #include <bpf/bpf_tracing.h>
>> #include <bpf/bpf_core_read.h>
>> #include "bootstrap.h"
>>
>> char LICENSE[] SEC("license") = "Dual BSD/GPL";
>>
>> struct
>> {
>>      __uint(type, BPF_MAP_TYPE_HASH);
>>      __uint(max_entries, 8192);
>>      __type(key, pid_t);
>>      __type(value, u64);
>> } exec_start SEC(".maps");
>>
>> struct
>> {
>>      __uint(type, BPF_MAP_TYPE_RINGBUF);
>>      __uint(max_entries, 256 * 1024);
>> } rb SEC(".maps");
>>
>> const volatile unsigned long long min_duration_ns = 0;
>>
>> SEC("tp/sched/sched_process_exec")
>> int handle_exec(struct trace_event_raw_sched_process_exec *ctx)
>> {
>>      struct task_struct *task;
>>      unsigned fname_off;
>>      struct event *e;
>>      pid_t pid;
>>      u64 ts;
>>
>>      /* remember time exec() was executed for this PID */
>>      pid = bpf_get_current_pid_tgid() >> 32;
>>      ts = bpf_ktime_get_ns();
>>      bpf_map_update_elem(&exec_start, &pid, &ts, BPF_ANY);
>>
>>      /* don't emit exec events when minimum duration is specified */
>>      if (min_duration_ns)
>>          return 0;
>>
>>      /* reserve sample from BPF ringbuf */
>>      e = bpf_ringbuf_reserve(&rb, sizeof(*e), 0);
>>      if (!e)
>>          return 0;
>>
>>      /* fill out the sample with data */
>>      task = (struct task_struct *)bpf_get_current_task();
>>
>>      e->exit_event = false;
>>      e->pid = pid;
>>      e->ppid = BPF_CORE_READ(task, real_parent, tgid);
>>      bpf_get_current_comm(&e->comm, sizeof(e->comm));
>>
>>      int a, b, c, d, e_, f, g, h, i;
>>
>>      a = b = c = d = e_ = f = g = h = i = 0;
>>      asm volatile(""
>>                   : "=r"(a), "=r"(b), "=r"(c), "=r"(d), "=r"(e_),
>> "=r"(f), "=r"(g), "=r"(h), "=r"(i)
>>                   : "0"(a), "1"(b), "2"(c), "3"(d), "4"(e_), "5"(f),
>> "6"(g), "7"(h), "8"(i));
>>
>>      fname_off = ctx->__data_loc_filename & 0xFFFF;
>>      bpf_probe_read_str(&e->filename, sizeof(e->filename), (void *)ctx
>> + fname_off);
>>
>>      /* successfully submit it to user-space for post-processing */
>>      bpf_ringbuf_submit(e, 0);
>>      return 0;
>> }
>>
>> SEC("tp/sched/sched_process_exit")
>> int handle_exit(struct trace_event_raw_sched_process_template *ctx)
>> {
>>      struct task_struct *task;
>>      struct event *e;
>>      pid_t pid, tid;
>>      u64 id, ts, *start_ts, duration_ns = 0;
>>
>>      /* get PID and TID of exiting thread/process */
>>      id = bpf_get_current_pid_tgid();
>>      pid = id >> 32;
>>      tid = (u32)id;
>>
>>      /* ignore thread exits */
>>      if (pid != tid)
>>          return 0;
>>
>>      /* if we recorded start of the process, calculate lifetime duration */
>>      start_ts = bpf_map_lookup_elem(&exec_start, &pid);
>>      if (start_ts)
>>          duration_ns = bpf_ktime_get_ns() - *start_ts;
>>      else if (min_duration_ns)
>>          return 0;
>>      bpf_map_delete_elem(&exec_start, &pid);
>>
>>      /* if process didn't live long enough, return early */
>>      if (min_duration_ns && duration_ns < min_duration_ns)
>>          return 0;
>>
>>      /* reserve sample from BPF ringbuf */
>>      e = bpf_ringbuf_reserve(&rb, sizeof(*e), 0);
>>      if (!e)
>>          return 0;
>>
>>      /* fill out the sample with data */
>>      task = (struct task_struct *)bpf_get_current_task();
>>
>>      e->exit_event = true;
>>      e->duration_ns = duration_ns;
>>      e->pid = pid;
>>      e->ppid = BPF_CORE_READ(task, real_parent, tgid);
>>      e->exit_code = (BPF_CORE_READ(task, exit_code) >> 8) & 0xff;
>>      bpf_get_current_comm(&e->comm, sizeof(e->comm));
>>
>>      /* send data to user-space for post-processing */
>>      bpf_ringbuf_submit(e, 0);
>>      return 0;
>> }
>>
>>
>>
>>
>> And libbpf's output:
>>
>> libbpf: load bpf program failed: Permission denied
>> libbpf: -- BEGIN DUMP LOG ---
>> libbpf:
>> Unrecognized arg#0 type PTR
>> ; int handle_exec(struct trace_event_raw_sched_process_exec *ctx)
>> 0: (bf) r6 = r1
>> ; pid = bpf_get_current_pid_tgid() >> 32;
>> 1: (85) call bpf_get_current_pid_tgid#14
>> ; pid = bpf_get_current_pid_tgid() >> 32;
>> 2: (77) r0 >>= 32
>> ; pid = bpf_get_current_pid_tgid() >> 32;
>> 3: (63) *(u32 *)(r10 -4) = r0
>> ; ts = bpf_ktime_get_ns();
>> 4: (85) call bpf_ktime_get_ns#5
>> ; ts = bpf_ktime_get_ns();
>> 5: (7b) *(u64 *)(r10 -16) = r0
>> 6: (bf) r2 = r10
>> ;
>> 7: (07) r2 += -4
>> 8: (bf) r3 = r10
>> 9: (07) r3 += -16
>> ; bpf_map_update_elem(&exec_start, &pid, &ts, BPF_ANY);
>> 10: (18) r1 = 0xffff8bf45ddd1400
>> 12: (b7) r4 = 0
>> 13: (85) call bpf_map_update_elem#2
>> ; if (min_duration_ns)
>> 14: (18) r1 = 0xffffa1b980644000
>> 16: (79) r1 = *(u64 *)(r1 +0)
>>   R0=inv(id=0) R1_w=map_value(id=0,off=0,ks=4,vs=8,imm=0)
>> R6=ctx(id=0,off=0,imm=0) R10=fp0 fp-8=mmmm???? fp-16=mmmmmmmm
>> ; if (min_duration_ns)
>> 17: (55) if r1 != 0x0 goto pc+60
>> last_idx 17 first_idx 14
>> regs=2 stack=0 before 16: (79) r1 = *(u64 *)(r1 +0)
>> 18: (b7) r8 = 0
>> ; e = bpf_ringbuf_reserve(&rb, sizeof(*e), 0);
>> 19: (18) r1 = 0xffff8bf461b60600
>> 21: (b7) r2 = 168
>> 22: (b7) r3 = 0
>> 23: (85) call bpf_ringbuf_reserve#131
>> 24: (bf) r7 = r0
>> ; if (!e)
>> 25: (15) if r7 == 0x0 goto pc+52
>>   R0=mem(id=0,ref_obj_id=2,off=0,imm=0) R6=ctx(id=0,off=0,imm=0)
>> R7_w=mem(id=0,ref_obj_id=2,off=0,imm=0) R8=inv0 R10=fp0 fp-8=mmmm????
>> fp-16=mmmmmmmm refs=2
>> ; task = (struct task_struct *)bpf_get_current_task();
>> 26: (85) call bpf_get_current_task#35
>> ; e->exit_event = false;
>> 27: (73) *(u8 *)(r7 +167) = r8
>>   R0_w=inv(id=0) R6=ctx(id=0,off=0,imm=0)
>> R7_w=mem(id=0,ref_obj_id=2,off=0,imm=0) R8=inv0 R10=fp0 fp-8=mmmm????
>> fp-16=mmmmmmmm refs=2
>> ; e->pid = pid;
>> 28: (61) r1 = *(u32 *)(r10 -4)
>> ; e->pid = pid;
>> 29: (63) *(u32 *)(r7 +0) = r1
>>   R0_w=inv(id=0) R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
>> 0xffffffff)) R6=ctx(id=0,off=0,imm=0)
>> R7_w=mem(id=0,ref_obj_id=2,off=0,imm=0) R8=inv0 R10=fp0 fp-8=mmmm????
>> fp-16=mmmmmmmm refs=2
>> 30: (b7) r1 = 2264
>> 31: (0f) r0 += r1
>> 32: (bf) r1 = r10
>> ;
>> 33: (07) r1 += -32
>> ; e->ppid = BPF_CORE_READ(task, real_parent, tgid);
>> 34: (b7) r2 = 8
>> 35: (bf) r3 = r0
>> 36: (85) call bpf_probe_read_kernel#113
>> last_idx 36 first_idx 24
>> regs=4 stack=0 before 35: (bf) r3 = r0
>> regs=4 stack=0 before 34: (b7) r2 = 8
>> 37: (b7) r1 = 2252
>> 38: (79) r3 = *(u64 *)(r10 -32)
>> 39: (0f) r3 += r1
>> 40: (bf) r1 = r10
>> ;
>> 41: (07) r1 += -20
>> ; e->ppid = BPF_CORE_READ(task, real_parent, tgid);
>> 42: (b7) r2 = 4
>> 43: (85) call bpf_probe_read_kernel#113
>> last_idx 43 first_idx 37
>> regs=4 stack=0 before 42: (b7) r2 = 4
>> ; e->ppid = BPF_CORE_READ(task, real_parent, tgid);
>> 44: (61) r1 = *(u32 *)(r10 -20)
>> ; e->ppid = BPF_CORE_READ(task, real_parent, tgid);
>> 45: (63) *(u32 *)(r7 +4) = r1
>>   R0_w=inv(id=0) R1_w=inv(id=0,umax_value=4294967295,var_off=(0x0;
>> 0xffffffff)) R6=ctx(id=0,off=0,imm=0)
>> R7=mem(id=0,ref_obj_id=2,off=0,imm=0) R8=inv0 R10=fp0 fp-8=mmmm????
>> fp-16=mmmmmmmm fp-24=mmmm???? fp-32=mmmmmmmm refs=2
>> ; bpf_get_current_comm(&e->comm, sizeof(e->comm));
>> 46: (bf) r1 = r7
>> 47: (07) r1 += 24
>> ; bpf_get_current_comm(&e->comm, sizeof(e->comm));
>> 48: (b7) r2 = 16
>> 49: (85) call bpf_get_current_comm#16
>>   R0_w=inv(id=0) R1_w=mem(id=0,ref_obj_id=2,off=24,imm=0) R2_w=inv16
>> R6=ctx(id=0,off=0,imm=0) R7=mem(id=0,ref_obj_id=2,off=0,imm=0) R8=inv0
>> R10=fp0 fp-8=mmmm???? fp-16=mmmmmmmm fp-24=mmmm???? fp-32=mmmmmmmm
>> refs=2
>> last_idx 49 first_idx 37
>> regs=4 stack=0 before 48: (b7) r2 = 16
>> ; asm volatile(""
>> 50: (b7) r1 = 0
>> 51: (7b) *(u64 *)(r10 -40) = r1
>> last_idx 51 first_idx 50
>> regs=2 stack=0 before 50: (b7) r1 = 0
>> 52: (b7) r1 = 0
>> 53: (7b) *(u64 *)(r10 -48) = r1
>> last_idx 53 first_idx 50
>> regs=2 stack=0 before 52: (b7) r1 = 0
>> 54: (b7) r1 = 0
>> 55: (7b) *(u64 *)(r10 -56) = r1
>> last_idx 55 first_idx 50
>> regs=2 stack=0 before 54: (b7) r1 = 0
>> 56: (b7) r4 = 0
>> 57: (b7) r5 = 0
>> 58: (b7) r0 = 0
>> 59: (b7) r8 = 0
>> 60: (b7) r9 = 0
>> 61: (bf) r3 = r6
>> 62: (b7) r6 = 0
>> 63: (79) r2 = *(u64 *)(r10 -40)
>> 64: (79) r1 = *(u64 *)(r10 -48)
>> 65: (7b) *(u64 *)(r10 -64) = r7
>> 66: (79) r7 = *(u64 *)(r10 -56)
>> ; fname_off = ctx->__data_loc_filename & 0xFFFF;
>> 67: (61) r1 = *(u32 *)(r3 +8)
>> ; bpf_probe_read_str(&e->filename, sizeof(e->filename), (void *)ctx +
>> fname_off);
>> 68: (57) r1 &= 65535
>> 69: (0f) r3 += r1
>> last_idx 69 first_idx 50
>> regs=2 stack=0 before 68: (57) r1 &= 65535
>> regs=2 stack=0 before 67: (61) r1 = *(u32 *)(r3 +8)
>> 70: (79) r6 = *(u64 *)(r10 -64)
>> ; bpf_probe_read_str(&e->filename, sizeof(e->filename), (void *)ctx +
>> fname_off);
>> 71: (bf) r1 = r6
>> 72: (07) r1 += 40
>> ; bpf_probe_read_str(&e->filename, sizeof(e->filename), (void *)ctx +
>> fname_off);
>> 73: (b7) r2 = 127
>> 74: (85) call bpf_probe_read_str#45
>> R1 type=inv expected=fp, pkt, pkt_meta, map_value, mem, rdonly_buf, rdwr_buf


Yes, this is a limitation on verifier. The spillable register type does 
not include mem. The following verifier change can fix the issue:

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 17270b8404f1..36af69fac591 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -2217,6 +2217,8 @@ static bool is_spillable_regtype(enum bpf_reg_type 
type)
         case PTR_TO_RDWR_BUF:
         case PTR_TO_RDWR_BUF_OR_NULL:
         case PTR_TO_PERCPU_BTF_ID:
+       case PTR_TO_MEM:
+       case PTR_TO_MEM_OR_NULL:
                 return true;
         default:
                 return false;

Maybe you could submit a patch to fix this limitation?


>> processed 72 insns (limit 1000000) max_states_per_insn 0 total_states
>> 4 peak_states 4 mark_read 4
>>
>> libbpf: -- END LOG --
>> libbpf: failed to load program 'handle_exec'
>> libbpf: failed to load object 'bootstrap_bpf'
>> libbpf: failed to load BPF skeleton 'bootstrap_bpf': -4007
>> Failed to load and verify BPF skeleton
>>
>>
>>
>> Thanks for your time,
>>
>> Gilad Reti

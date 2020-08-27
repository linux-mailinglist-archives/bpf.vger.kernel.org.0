Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 672EF254A2C
	for <lists+bpf@lfdr.de>; Thu, 27 Aug 2020 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726232AbgH0QFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Aug 2020 12:05:11 -0400
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:61528 "EHLO
        mx0b-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726009AbgH0QFK (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 27 Aug 2020 12:05:10 -0400
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07RG4upv023136;
        Thu, 27 Aug 2020 09:05:01 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=qqEXYz67BCMIgXlSItUjfhiIlj3Ka/7TNBNk9q16H/w=;
 b=DqG+kYkdITN4PfE8OPwCfmyGTxm0++KwSU3EWSW9ryoIGGbHZV1Th3IqHT1mxylrHEed
 NOhHCS4/jplzoyii2LAqI8u91nhKB8QPrFEO7vHc2wujw4oZ4joHoZzFQj4Q4DQGhhar
 BquWDgeohUoE7v6OFC/DG0+rYpEDMrRgnLY= 
Received: from maileast.thefacebook.com ([163.114.130.16])
        by mx0a-00082601.pphosted.com with ESMTP id 335up861t5-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 27 Aug 2020 09:05:01 -0700
Received: from NAM04-CO1-obe.outbound.protection.outlook.com (100.104.31.183)
 by o365-in.thefacebook.com (100.104.35.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Thu, 27 Aug 2020 09:04:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gKIG1gvPhJMwEuiK8hlzUi8vMIKpns0xjxDUqrxSR/9omLl7gISzB53JFtFhq3EZUQkpz3Bj9NwRg3XQ/6pHLrXOtui+Zr8Kk7RImRHBwx6ody/Jyx0APTeeAgUKL+N3qwroY8qqC0k7ty1eHk99BS+akkLTgS+aEZ7ib83V3TsttcRGoNzJbqMboK59ZZfVrhWiuddJ/Cwcavyq8L4rIouVvGxwJ3lt5aVhBKJ/z1RE+d2URx1w7RgUiK4GrDI2R0jn5I/80xsKNsJC4EP2uezg+AQpOizHbGpmYugBK6BL5XXDO9xADFSLhmG1KEWMesffHQ6msiMgbDf6hwiRSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqEXYz67BCMIgXlSItUjfhiIlj3Ka/7TNBNk9q16H/w=;
 b=fNlpQ7Utp27b/GHDmK2DTPPa9j0jNCLddl2hQGBVlU5Ii3vPEKAaY5d4p1wtpXJlOBqGkFMz89cIxdX83B6poq0eUXPDt8SmdOw2BrJ9nUGiNB2I4w3K7TcvKOHwX9Uj/b3dxy3Fpq7rkiFrHkZMOxA/cstZPHP81A8Uci4b63hb6WmjuqC/iftKI1+ElwQK8psfGwigD95telbD7MqcZ6NuER5xzzkHg69VoGqJF5gFf3Ta47R+xmB1qeVaCWSkPy929hYZogCYpvqrhq5C5q7FAOgZ2E9CUlRQBQcqKkkJWFFgoVAZzxT2nG0d4Y/Z0kQbEqn1n/uGT3uj8YVKVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qqEXYz67BCMIgXlSItUjfhiIlj3Ka/7TNBNk9q16H/w=;
 b=P+K4b+xxr8G8CkOC/MsSC1+bIY2x37ULfvxtC2R1cpGKqMteyKFfDJZ/F3yRTEkOm5Tp9OhPjLAgVGdLEImMUvlxa/JQzerbZa3zDoAIK1kCeodAEub0IlRN4Vbe8Ce1nVv+/VTts2+BG0oC010DiOD60fq+k36FZOwqigTx0ms=
Authentication-Results: infradead.org; dkim=none (message not signed)
 header.d=none;infradead.org; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB2584.namprd15.prod.outlook.com (2603:10b6:a03:150::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.26; Thu, 27 Aug
 2020 16:04:52 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3326.021; Thu, 27 Aug 2020
 16:04:52 +0000
Subject: Re: perf event and data_sz
To:     Borna Cafuk <borna.cafuk@sartura.hr>
CC:     <bpf@vger.kernel.org>, Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>,
        Peter Zijlstra <peterz@infradead.org>
References: <CAGeTCaWAs9gX_Y17gXJhSVvsbuJF2aD3Tfi9+79JmndF2ERmOw@mail.gmail.com>
 <e21c4dd9-9336-017f-752e-5b83704d86bf@fb.com>
 <CAGeTCaUtECKWZP2UpbeHNhrJgWRQkh0yfUimGnWVF4Q=K1iYkg@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <25610c6c-e739-cb3b-cf1f-05083a62c4fe@fb.com>
Date:   Thu, 27 Aug 2020 09:04:48 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <CAGeTCaUtECKWZP2UpbeHNhrJgWRQkh0yfUimGnWVF4Q=K1iYkg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR12CA0027.namprd12.prod.outlook.com
 (2603:10b6:208:a8::40) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR12CA0027.namprd12.prod.outlook.com (2603:10b6:208:a8::40) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Thu, 27 Aug 2020 16:04:50 +0000
X-Originating-IP: [2620:10d:c091:480::1:2638]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cc4927a6-f4ff-4485-96de-08d84aa2ee81
X-MS-TrafficTypeDiagnostic: BYAPR15MB2584:
X-Microsoft-Antispam-PRVS: <BYAPR15MB25843D3744410867114A8F27D3550@BYAPR15MB2584.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zoYPw1ua6uMRCFeSXj/1demg/iZtqaESfJ07kRd9rHlNlFS+/AAhv0Wt3fmjbilU25TiIaHMlwz6lC1XvOZBvFcA5DrZ3See2bjNpAKyHbFabvN4NuoC5bLetyGcLhLbHMsXIhzrgyyYSk486ecNmDtjoq0vZbx+cdxPQveoYTJpn/ymt6nIBBq8slHnuD5dS+UyY3U2r8YA7U/DyOQumbAlowr9BNInTn67bS6dUuH3I40jYIN6Oj4jv9ni6/X/5u8HKfV+1V54DRA06zb+nrL5RAKz78+qP/7pp/0EifpsISjh7ZRUi3wn32+KtKGWc4Mauf2Oti8zVabaVbJ1GWzGJQWxaeWPMfXx5o3MuwPF8WfrN7aI4Z5Pk9/6UAFyPfDJMH9WnePB5V4toimcIpBvTgd5AtL1zuGKmrkDg0RFC4JejPjJCOjRwFRGHCDyZAp5gWQpZhFgeWGvJCVx3g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(346002)(366004)(376002)(136003)(396003)(52116002)(54906003)(53546011)(8676002)(31696002)(478600001)(956004)(86362001)(2616005)(31686004)(8936002)(16576012)(316002)(5660300002)(4326008)(6486002)(83380400001)(186003)(966005)(2906002)(36756003)(6916009)(66476007)(66946007)(66556008)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: N/jhIOdnX1Fpjvx305S+kePIyomypvbfzeWfxZTm1eog2Fcb/DWltWjafT/iQmrX0mYarYnDG95qELBKfx/WKWwvUJZE0JoC+yyiwx8t+unLpHOIV9e5KMyewmniZkGxKZDn1x33DzmUTKgGCp5JK7VEqyMvloD4f9lyp77QvCPjD0K/DUQcNAjW8Q6FQuFK/wuWC3hNdgJa3e5O5phZqlgiRJJJBeL7651SXbQiYRQbF+G7csM6w4SYcXFUaZF0uwYIhDAj90glfYtIfR7uB6zB5oTxGOiJa8v20p4oNcDtBWHkG9Numtst8YvFkp8c6tRWcOkm4vgjWahI1+3xJyUexpQZtyaZu+nO+7vJd68ZxisH03JN0QRrz0aGEnoSMWi1AB8gvFw0UVle2mw3qXyZNIGlzuzdfdRqUoRf99eftVjedzE2WxKdkqtFzNuQL9bLpK+9iLT4H0N6r9y1uHZqPdz5nAiz5tDQemfeD6BkCwwUawqpOXdd/8fzrp6GbpliAtUSkRvOvwzOllI2diSoeI+onpvdVjI5V/e9QYCD5ArbT9jzCXfVJ9UUP/3m239bx3OZZkZa3nrT2yALOPx56ZGAMFSkO4iJh647QFiNy8CldNPAY5dTfQKalQsErUMibdA9pt8gtQ3FEIz3opBW+GmgL4rV/GiSFRzG1BIVJaRumgjlaOflhjdPgCEr
X-MS-Exchange-CrossTenant-Network-Message-Id: cc4927a6-f4ff-4485-96de-08d84aa2ee81
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2020 16:04:52.0832
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TpJB6dhHDioBykwLak/GkSqQqx3iR0gGW2/vyL8NHhoj3MEPk3geGYAUGWPqKule
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB2584
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-27_08:2020-08-27,2020-08-27 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 bulkscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 spamscore=0 impostorscore=0
 clxscore=1011 phishscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008270119
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/27/20 3:01 AM, Borna Cafuk wrote:
> On Wed, Aug 26, 2020 at 8:45 PM Yonghong Song <yhs@fb.com> wrote:
>>
>> On 8/26/20 7:11 AM, Borna Cafuk wrote:
>>> Hi everyone,
>>>
>>> When examining BPF programs that use perf buffers, I have noticed that
>>> the `data_sz` parameter in the sample callback has a different value than
>>> the size passed to `bpf_perf_event_output`.
>>>
>>> Raw samples are padded in `perf_prepare_sample` so their size is a multiple of
>>> `sizeof(u64)` (see [0]). The sample includes the size header, a `u32`.
>>> The size stored in `raw->size` is then size of the sample, minus the 4 bytes for
>>> the size header. This size, however, includes both the data and the padding.
>>>
>>> What I find confusing is that this size including the padding is eventually
>>> passed as `data_sz` to the callback in the userspace, instead of
>>> the size of the data that was passed as an argument to `bpf_perf_event_output`.
>>>
>>> Is this intended behaviour?
>>
>>   From the kernel source code, yes, this is expected behavior. What you
>> described below matches what the kernel did. So raw->size = 68 is expected.
> 
> I understand why this size that is stored in `raw->size` is needed.
> What I don't see is how the value is of any use in the callback.
> 
>>
>>>
>>> I have a use-case for getting only the size of the data in the
>>> userspace, could this be done?
>>
>> In this case, since we know the kernel writes one record at a time,
>> you check the size, it is 68 more than 62, you just read 62 bytes
>> as your real data, ignore the rest as the padding. Does this work?
> 
> The `data_sz` parameter seems a little pointless, then. What is its purpose
> in the callback if it doesn't accurately represent the size of the data?

I agree since this is not exactly what user expected, user space will
need to calculate the "expected" data_sz and based on that to get to
what kind of record it is. Otherwise, the user needs to put some
info in the record itself to differentiate what it is and your 
intermediate layer just pass all data from the kernel to the application.

> 
>>
>> bcc callback passed the the buffer with raw->size to application.
>> But applications are expected to know what the record layout is...
> 
> I'm afraid that wouldn't work for the use-case, our application should be able
> to read the raw data without having to know the record layout. It has to be
> generic, we handle interpreting the records elsewhere and at another time.

I am added Peter Zijlstra in the cc list and hope he may have some
insight on how to tackle this.

> 
>>
>>>
>>> To demonstrate, I have prepared a minimal example by modifying
>>> BCC's filelife example. It uses a kprobe on vfs_unlink to print some sizes
>>> every time a file is unlinked. The sizes are:
>>>    * the `sizeof(struct event)` measured in the userspace program,
>>>    * the `sizeof(struct event)` measured in the BPF program, and
>>>    * the `data_sz` parameter.
>>>
>>> The first two are 62, as expected, but `data_sz` is 68.
>>> The 62 bytes of the struct and the 4 bytes of the sample header make 66 bytes.
>>> This is rounded up to the first multiple of 8, which is 72.
>>> The 4 bytes for the size header are then subtracted,
>>> and 68 is written as the data size.
>>>
>>> Any input is much appreciated,
>>>
>>> Best regards,
>>> Borna Cafuk
>>>
>>>
>>> [0] https://github.com/torvalds/linux/blob/6a9dc5fd6170d0a41c8a14eb19e63d94bea5705a/kernel/events/core.c#L7035
>>>
>>>
>>> example.h
>>> --------------------------------
>>> #ifndef __EXAMPLE_H
>>> #define __EXAMPLE_H
>>>
>>> struct __attribute__((__packed__)) event {
>>>       __u16 size;
>>>       char filler[60];
>>> };
>>>
>>> #endif /* __EXAMPLE_H */
>>>
>>>
>>> example.bpf.c
>>> --------------------------------
>>> #include "vmlinux.h"
>>> #include <bpf/bpf_helpers.h>
>>> #include <bpf/bpf_tracing.h>
>>> #include "example.h"
>>>
>>> struct {
>>>       __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>>>       __uint(key_size, sizeof(u32));
>>>       __uint(value_size, sizeof(u32));
>>> } events SEC(".maps");
>>>
>>> SEC("kprobe/vfs_unlink")
>>> int BPF_KPROBE(kprobe__vfs_unlink, struct inode *dir, struct dentry *dentry)
>>> {
>>>       struct event event = {};
>>>       event.size = sizeof(struct event);
>>>
>>>       bpf_perf_event_output(ctx, &events, BPF_F_CURRENT_CPU,
>>>                             &event, sizeof(struct event));
>>>       return 0;
>>> }
>>>
>>> char LICENSE[] SEC("license") = "GPL";
>>>
>>>
>>> example.c
>>> --------------------------------
>>> #include <stdio.h>
>>> #include <bpf/libbpf.h>
>>> #include <sys/resource.h>
>>> #include "example.h"
>>> #include "example.skel.h"
>>>
>>> #define PERF_BUFFER_PAGES    16
>>> #define PERF_POLL_TIMEOUT_MS    100
>>>
>>> void handle_event(void *ctx, int cpu, void *data, __u32 data_sz)
>>> {
>>>       const struct event *e = data;
>>>
>>>       printf("Userspace: %u | BPF: %zu | data_sz: %u \n",
>>>              e->size, sizeof(struct event), data_sz);
>>> }
>>>
>>> void handle_lost_events(void *ctx, int cpu, __u64 lost_cnt)
>>> {
>>>       fprintf(stderr, "lost %llu events on CPU #%d\n", lost_cnt, cpu);
>>> }
>>>
>>> int main(int argc, char **argv)
>>> {
>>>       struct perf_buffer_opts pb_opts;
>>>       struct perf_buffer *pb = NULL;
>>>       struct example_bpf *obj;
>>>       int err;
>>>
>>>       struct rlimit rlim_new = {
>>>           .rlim_cur    = RLIM_INFINITY,
>>>           .rlim_max    = RLIM_INFINITY,
>>>       };
>>>       err = setrlimit(RLIMIT_MEMLOCK, &rlim_new);
>>>       if (err) {
>>>           fprintf(stderr, "failed to increase rlimit: %d\n", err);
>>>           return 1;
>>>       }
>>>
>>>       obj = example_bpf__open();
>>>       if (!obj) {
>>>           fprintf(stderr, "failed to open and/or load BPF object\n");
>>>           return 1;
>>>       }
>>>
>>>       err = example_bpf__load(obj);
>>>       if (err) {
>>>           fprintf(stderr, "failed to load BPF object: %d\n", err);
>>>           goto cleanup;
>>>       }
>>>
>>>       err = example_bpf__attach(obj);
>>>       if (err) {
>>>           fprintf(stderr, "failed to attach BPF programs\n");
>>>           goto cleanup;
>>>       }
>>>
>>>       pb_opts.sample_cb = handle_event;
>>>       pb_opts.lost_cb = handle_lost_events;
>>>       pb = perf_buffer__new(bpf_map__fd(obj->maps.events), PERF_BUFFER_PAGES,
>>>                             &pb_opts);
>>>       err = libbpf_get_error(pb);
>>>       if (err) {
>>>           pb = NULL;
>>>           fprintf(stderr, "failed to open perf buffer: %d\n", err);
>>>           goto cleanup;
>>>       }
>>>
>>>       while ((err = perf_buffer__poll(pb, PERF_POLL_TIMEOUT_MS)) >= 0)
>>>           ;
>>>       fprintf(stderr, "error polling perf buffer: %d\n", err);
>>>
>>>       cleanup:
>>>       perf_buffer__free(pb);
>>>       example_bpf__destroy(obj);
>>>
>>>       return err != 0;
>>> }
>>>

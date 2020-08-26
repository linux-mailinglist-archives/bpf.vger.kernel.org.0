Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D783125376F
	for <lists+bpf@lfdr.de>; Wed, 26 Aug 2020 20:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726858AbgHZSpa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 26 Aug 2020 14:45:30 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:36166 "EHLO
        mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726786AbgHZSp3 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 26 Aug 2020 14:45:29 -0400
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
        by mx0a-00082601.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 07QIccrn003000;
        Wed, 26 Aug 2020 11:45:26 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=facebook;
 bh=HhKnk8tbMLXonHNa/UfLmipvZv4YTcZhV+yaW95+Who=;
 b=g2f+J5pw9q9FodorCaMS6363hEhpqQ0ECgJP+ezuQb6341/RBNx6fYaS7xnYtFy++J+5
 Y11VODquf5iQWCgr7J3NF9kgQY7Vjce6Ntk0mfsSZ0/zRj5qLdPrMAhWmXwTXZ3a/ywd
 +UjsCwaz0AzIrjasDU+5mXyNdhd5fUe97mg= 
Received: from mail.thefacebook.com ([163.114.132.120])
        by mx0a-00082601.pphosted.com with ESMTP id 335up7rn8p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 26 Aug 2020 11:45:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (100.104.98.9) by
 o365-in.thefacebook.com (100.104.94.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1979.3; Wed, 26 Aug 2020 11:45:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TXPFdzduZ9CbboLl8t8rAvxB7X0tMflnzQRICaSkcDBqPptyl65H8SY/6WB0GvOiJxfqopV61cn/X6nxwPnXq+SuaxawaNgoZMNKh1wl7zqrAPzBuAeItHnmmgQ55+eQaBdiozxOo+pOiE3kiSDjl09QZOQilDIDieBwR9KukxhqGWutg/LxOkcqs9Bh0KWmm1gJnQiaMAtZZZlycg9flV3dKQPyHrbU/kjS4fcAEi4fVPZQQWP0tVDK3ZsmnqDprhDWzUXi37l6AAKmIBViggPXvTcDzpuTzlqARzpr7EeJzX9N0E6z+Nnuw5YmsavXQZSZFIWCBU4oKE08mdJLxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhKnk8tbMLXonHNa/UfLmipvZv4YTcZhV+yaW95+Who=;
 b=Bf0PKqmTNi9BniBluLfG96PDS17/KXdzk/91gmnHDUQ402PfoGxApezzTM7mbLlXizTlBkeZ3f3DYkwdJWyOqjbr/GnTPvzHtMRv+JXX14qiZrRc4ga7k+eShCi0JR1ES1/KsAVdhtsO1mfIr8a3H/9PzC3JA2Q/yMuURtaemHEXOcdeHE6ItDU7/N2ZiMzQX4cUCxxwm6J5Bw6uEedUYWECOL+7dj584Wh0CXu3t39VDpvk7i4ReUr05EmMbLiddXW69R6H00CmsDlvhZX39wP4h+lfJdYWwauRkPH/TTZPXqKrykQe/ivSQyj6jud+NRaDIH3pmKe8iyEZ4EQQ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fb.com; dmarc=pass action=none header.from=fb.com; dkim=pass
 header.d=fb.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fb.onmicrosoft.com;
 s=selector2-fb-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HhKnk8tbMLXonHNa/UfLmipvZv4YTcZhV+yaW95+Who=;
 b=TsH+kNtr0v7AQ2ERNB7CXmJ0ARV4LIczkzEVtYQp6qRKhwlMNe8m3YSLiqzy2WoYPvO+5TPlJ9y/sHHrUVcQq97IOyH3yYPEzncodVPf4SmSjs0s57FyavJ4Q12+8XxcJxJUHO1yPF33Am0hl2/6/ArXSYIQUSW4WVSKPiKxm/A=
Authentication-Results: sartura.hr; dkim=none (message not signed)
 header.d=none;sartura.hr; dmarc=none action=none header.from=fb.com;
Received: from BYAPR15MB4088.namprd15.prod.outlook.com (2603:10b6:a02:c3::18)
 by BYAPR15MB3302.namprd15.prod.outlook.com (2603:10b6:a03:10f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3305.25; Wed, 26 Aug
 2020 18:45:24 +0000
Received: from BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80]) by BYAPR15MB4088.namprd15.prod.outlook.com
 ([fe80::56b:2925:8762:2d80%7]) with mapi id 15.20.3326.019; Wed, 26 Aug 2020
 18:45:24 +0000
Subject: Re: perf event and data_sz
To:     Borna Cafuk <borna.cafuk@sartura.hr>, <bpf@vger.kernel.org>
CC:     Luka Perkov <luka.perkov@sartura.hr>,
        Juraj Vijtiuk <juraj.vijtiuk@sartura.hr>,
        Jakov Petrina <jakov.petrina@sartura.hr>
References: <CAGeTCaWAs9gX_Y17gXJhSVvsbuJF2aD3Tfi9+79JmndF2ERmOw@mail.gmail.com>
From:   Yonghong Song <yhs@fb.com>
Message-ID: <e21c4dd9-9336-017f-752e-5b83704d86bf@fb.com>
Date:   Wed, 26 Aug 2020 11:45:19 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.11.0
In-Reply-To: <CAGeTCaWAs9gX_Y17gXJhSVvsbuJF2aD3Tfi9+79JmndF2ERmOw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN2PR15CA0047.namprd15.prod.outlook.com
 (2603:10b6:208:237::16) To BYAPR15MB4088.namprd15.prod.outlook.com
 (2603:10b6:a02:c3::18)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from 255.255.255.255 (255.255.255.255) by MN2PR15CA0047.namprd15.prod.outlook.com (2603:10b6:208:237::16) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.19 via Frontend Transport; Wed, 26 Aug 2020 18:45:22 +0000
X-Originating-IP: [2620:10d:c091:480::1:342c]
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2aae9271-a7d8-4ad8-6da0-08d849f0310f
X-MS-TrafficTypeDiagnostic: BYAPR15MB3302:
X-Microsoft-Antispam-PRVS: <BYAPR15MB33023E31B106FF8F3062D060D3540@BYAPR15MB3302.namprd15.prod.outlook.com>
X-FB-Source: Internal
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CnuTnUU6H1xJh15RGxSmMUaWpJfYf/LmfD+MLFsSXwJhlkclAxywj0kfrOSKvEVvBFC+L+mK7fnLyJbgA3qJGQ0r+JR6G7bQHesmPK2i5K3E2KfazmvJfPaKf0v6SfiQcrUbRjxk98nssIiBDsRq4OejnYVoiirlt6tqFbINHyB1tmDp1q96UX2YeY9niipQdgF7HJRxsd5f3X0vLz5vObtHRNA++L1RbFjxdGwS5ZqCViyIh7hgvXSDjoNLbgFCZ1xXWy9Q/yfDt4BxLDLD2PWmJIo4GEYPWl2Nd+W3+lTHJaKsVK69hPge2KvGMUdBhvP0ekUB/RwnM/jAt6X7b048wU1TjyEPLTeZibg7zZWBIS24LAM7YJZdv2WgIGRB+T6Ch7vAmUhbGASZU059w0sWltysAMZG4WGt+IWTm+qWkbBxSEjSuafXPBpRDuzKQhhsuS9rxNPL8HMJe2h8cA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR15MB4088.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(396003)(376002)(136003)(346002)(39860400002)(8936002)(66946007)(16576012)(4326008)(2616005)(956004)(86362001)(186003)(31686004)(8676002)(66556008)(6666004)(966005)(5660300002)(53546011)(83380400001)(31696002)(478600001)(2906002)(52116002)(66476007)(54906003)(316002)(36756003)(6486002)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData: IVOhXtu57ZvMAzywswd33IyOoCTMBJ36wSxst98XYDiiWhz3oint3etYI80kBwt52Q9VJUhBypFSiUoUSUDKfXuSH4j+GBWDzyjljrCn7bJSZn4QsEUDOOKZ/CyMNtqQxyg++NyXW3Qv2Az5xd7/FatuyrqwJvTjJ3yKRAgY668fiS45JBDzWs2MtZV36zgpHrYagNRpi2dJfZK5g8jljt/4ffRqC/OtRAvm/bnTyjKIegmH3w7tZFYi0fINRfNV2xkkGnxWx7KPEJix+6JpcEfrhhAsX+I9WGXTfJTRr4jTuoXbqh8jdQ+v2+OkYxVgKEKTXvU9uUABERwhL3gWAVODyTsn5LkqVM5FmS+Z00IdMq3MeE54Xg5oADuKWNLGJYOnEc3D3HiwTCOcmti8ut80M4AwCr7bdPT0VFeX8oxMrmI7ZxZXDB+wndIcqKqLDUwPCDz0lKJ8r90zrBjg+rPNLrJsgRfsk2NnsTt0p5qM6XIGbCja8XfcT7CfhaSF4JsZdCVWRqweArR1kZGS2fMedZsIglKPbJ44M6xSmF5W9t4hmK+V1Z0ify8Lzq0Soc4ksIknjfsrd5NuvVZIPOpWmgkjoee00xYsbeZ6BJYNESz+3tT77E68QZNx1QYqpRbAMJj7Txz+h5zHhUPuHnLMUo0j8vpiG/Ss9Com6BO6w9/5I+hfGRgawbjoSyYw
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aae9271-a7d8-4ad8-6da0-08d849f0310f
X-MS-Exchange-CrossTenant-AuthSource: BYAPR15MB4088.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2020 18:45:24.0066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5aW1/Ddl3vSqMmvszGlhHth8NBe3vlBL6ZCNH4PKzwO4f6b2MAUx7I1YXoyat2pk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR15MB3302
X-OriginatorOrg: fb.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-26_10:2020-08-26,2020-08-26 signatures=0
X-Proofpoint-Spam-Details: rule=fb_default_notspam policy=fb_default score=0 impostorscore=0
 malwarescore=0 phishscore=0 priorityscore=1501 adultscore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 mlxlogscore=999 spamscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008260138
X-FB-Internal: deliver
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org



On 8/26/20 7:11 AM, Borna Cafuk wrote:
> Hi everyone,
> 
> When examining BPF programs that use perf buffers, I have noticed that
> the `data_sz` parameter in the sample callback has a different value than
> the size passed to `bpf_perf_event_output`.
> 
> Raw samples are padded in `perf_prepare_sample` so their size is a multiple of
> `sizeof(u64)` (see [0]). The sample includes the size header, a `u32`.
> The size stored in `raw->size` is then size of the sample, minus the 4 bytes for
> the size header. This size, however, includes both the data and the padding.
> 
> What I find confusing is that this size including the padding is eventually
> passed as `data_sz` to the callback in the userspace, instead of
> the size of the data that was passed as an argument to `bpf_perf_event_output`.
> 
> Is this intended behaviour?

 From the kernel source code, yes, this is expected behavior. What you 
described below matches what the kernel did. So raw->size = 68 is expected.

> 
> I have a use-case for getting only the size of the data in the
> userspace, could this be done?

In this case, since we know the kernel writes one record at a time,
you check the size, it is 68 more than 62, you just read 62 bytes
as your real data, ignore the rest as the padding. Does this work?

bcc callback passed the the buffer with raw->size to application.
But applications are expected to know what the record layout is...

> 
> To demonstrate, I have prepared a minimal example by modifying
> BCC's filelife example. It uses a kprobe on vfs_unlink to print some sizes
> every time a file is unlinked. The sizes are:
>   * the `sizeof(struct event)` measured in the userspace program,
>   * the `sizeof(struct event)` measured in the BPF program, and
>   * the `data_sz` parameter.
> 
> The first two are 62, as expected, but `data_sz` is 68.
> The 62 bytes of the struct and the 4 bytes of the sample header make 66 bytes.
> This is rounded up to the first multiple of 8, which is 72.
> The 4 bytes for the size header are then subtracted,
> and 68 is written as the data size.
> 
> Any input is much appreciated,
> 
> Best regards,
> Borna Cafuk
> 
> 
> [0] https://github.com/torvalds/linux/blob/6a9dc5fd6170d0a41c8a14eb19e63d94bea5705a/kernel/events/core.c#L7035
> 
> 
> example.h
> --------------------------------
> #ifndef __EXAMPLE_H
> #define __EXAMPLE_H
> 
> struct __attribute__((__packed__)) event {
>      __u16 size;
>      char filler[60];
> };
> 
> #endif /* __EXAMPLE_H */
> 
> 
> example.bpf.c
> --------------------------------
> #include "vmlinux.h"
> #include <bpf/bpf_helpers.h>
> #include <bpf/bpf_tracing.h>
> #include "example.h"
> 
> struct {
>      __uint(type, BPF_MAP_TYPE_PERF_EVENT_ARRAY);
>      __uint(key_size, sizeof(u32));
>      __uint(value_size, sizeof(u32));
> } events SEC(".maps");
> 
> SEC("kprobe/vfs_unlink")
> int BPF_KPROBE(kprobe__vfs_unlink, struct inode *dir, struct dentry *dentry)
> {
>      struct event event = {};
>      event.size = sizeof(struct event);
> 
>      bpf_perf_event_output(ctx, &events, BPF_F_CURRENT_CPU,
>                            &event, sizeof(struct event));
>      return 0;
> }
> 
> char LICENSE[] SEC("license") = "GPL";
> 
> 
> example.c
> --------------------------------
> #include <stdio.h>
> #include <bpf/libbpf.h>
> #include <sys/resource.h>
> #include "example.h"
> #include "example.skel.h"
> 
> #define PERF_BUFFER_PAGES    16
> #define PERF_POLL_TIMEOUT_MS    100
> 
> void handle_event(void *ctx, int cpu, void *data, __u32 data_sz)
> {
>      const struct event *e = data;
> 
>      printf("Userspace: %u | BPF: %zu | data_sz: %u \n",
>             e->size, sizeof(struct event), data_sz);
> }
> 
> void handle_lost_events(void *ctx, int cpu, __u64 lost_cnt)
> {
>      fprintf(stderr, "lost %llu events on CPU #%d\n", lost_cnt, cpu);
> }
> 
> int main(int argc, char **argv)
> {
>      struct perf_buffer_opts pb_opts;
>      struct perf_buffer *pb = NULL;
>      struct example_bpf *obj;
>      int err;
> 
>      struct rlimit rlim_new = {
>          .rlim_cur    = RLIM_INFINITY,
>          .rlim_max    = RLIM_INFINITY,
>      };
>      err = setrlimit(RLIMIT_MEMLOCK, &rlim_new);
>      if (err) {
>          fprintf(stderr, "failed to increase rlimit: %d\n", err);
>          return 1;
>      }
> 
>      obj = example_bpf__open();
>      if (!obj) {
>          fprintf(stderr, "failed to open and/or load BPF object\n");
>          return 1;
>      }
> 
>      err = example_bpf__load(obj);
>      if (err) {
>          fprintf(stderr, "failed to load BPF object: %d\n", err);
>          goto cleanup;
>      }
> 
>      err = example_bpf__attach(obj);
>      if (err) {
>          fprintf(stderr, "failed to attach BPF programs\n");
>          goto cleanup;
>      }
> 
>      pb_opts.sample_cb = handle_event;
>      pb_opts.lost_cb = handle_lost_events;
>      pb = perf_buffer__new(bpf_map__fd(obj->maps.events), PERF_BUFFER_PAGES,
>                            &pb_opts);
>      err = libbpf_get_error(pb);
>      if (err) {
>          pb = NULL;
>          fprintf(stderr, "failed to open perf buffer: %d\n", err);
>          goto cleanup;
>      }
> 
>      while ((err = perf_buffer__poll(pb, PERF_POLL_TIMEOUT_MS)) >= 0)
>          ;
>      fprintf(stderr, "error polling perf buffer: %d\n", err);
> 
>      cleanup:
>      perf_buffer__free(pb);
>      example_bpf__destroy(obj);
> 
>      return err != 0;
> }
> 

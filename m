Return-Path: <bpf+bounces-1973-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 572E972518C
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 03:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8F951C20B37
	for <lists+bpf@lfdr.de>; Wed,  7 Jun 2023 01:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E374F63D;
	Wed,  7 Jun 2023 01:33:00 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECA7C
	for <bpf@vger.kernel.org>; Wed,  7 Jun 2023 01:33:00 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD171984;
	Tue,  6 Jun 2023 18:32:58 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QbVGG1XG1z4f3lY7;
	Wed,  7 Jun 2023 09:32:54 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgDnUCtD3n9kk0b2KQ--.37079S2;
	Wed, 07 Jun 2023 09:32:55 +0800 (CST)
Subject: Re: [RFC PATCH bpf-next v4 2/3] selftests/bpf: Add benchmark for bpf
 memory allocator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 Hou Tao <houtao1@huawei.com>
References: <20230606035310.4026145-1-houtao@huaweicloud.com>
 <20230606035310.4026145-3-houtao@huaweicloud.com>
 <CAADnVQJZc6iJiZ+axjXGKMSJa0ims9vYUc4vYQ7bdnOqgz5QfA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <d050d0cd-faa0-048d-57e1-42c05039ecd7@huaweicloud.com>
Date: Wed, 7 Jun 2023 09:32:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJZc6iJiZ+axjXGKMSJa0ims9vYUc4vYQ7bdnOqgz5QfA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgDnUCtD3n9kk0b2KQ--.37079S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFW8WFy5Zw1xZF43XFW3Awb_yoW8XFW7pF
	Z5KF1UWFW8Zr4DAws2y3W8Kw1Svr48G3WYvr4xtFnrZFn8AF9avrZFkFW3CFs5A3W09rWY
	vFsFqFn7Jwn5AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUOyCJDUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/7/2023 5:13 AM, Alexei Starovoitov wrote:
> On Mon, Jun 5, 2023 at 8:20 PM Hou Tao <houtao@huaweicloud.com> wrote:
>> +static void htab_mem_read_mem_cgrp_file(const char *name, unsigned long *value)
>> +{
>> +       char buf[32];
>> +       int fd;
>> +
>> +       fd = openat(ctx.fd, name, O_RDONLY);
>> +       if (fd < 0) {
>> +               fprintf(stderr, "no %s\n", name);
>> +               *value = 0;
>> +               return;
>> +       }
>> +
>> +       buf[sizeof(buf) - 1] = 0;
>> +       read(fd, buf, sizeof(buf) - 1);
> Please BPF CI. It's complaining about:
I don't know that RFC patch will go through BPF CI. Will check other
checks and tests in CI.
>
> benchs/bench_htab_mem.c: In function ‘htab_mem_read_mem_cgrp_file’:
> benchs/bench_htab_mem.c:290:2: error: ignoring return value of ‘read’,
> declared with attribute warn_unused_result [-Werror=unused-result]
> 290 | read(fd, buf, sizeof(buf) - 1);
Will fix in v5.
> | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>
>> +       *value = strtoull(buf, NULL, 0);
>> +
>> +       close(fd);
>> +}
>> +
>> +static void htab_mem_measure(struct bench_res *res)
>> +{
>> +       res->hits = atomic_swap(&ctx.skel->bss->loop_cnt, 0);
> This is missing:
> res->hits /= env.producer_cnt;
>
> Doubling the number of producers should double the perf metric.
> Like -p 4 should be half the speed of -p 8.
> In an ideal situation, of course.
> Without this normalization -p 1 vs -p 2 numbers are meaningless.
> Runs with different numbers of producers cannot be compared.
It is a good idea to compare the metric numbers between different
producers. Will do it in v5.
> .



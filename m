Return-Path: <bpf+bounces-2356-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D48472B531
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 03:47:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 180652810B0
	for <lists+bpf@lfdr.de>; Mon, 12 Jun 2023 01:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3158517D4;
	Mon, 12 Jun 2023 01:46:56 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C11215BE
	for <bpf@vger.kernel.org>; Mon, 12 Jun 2023 01:46:55 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7C6C0;
	Sun, 11 Jun 2023 18:46:54 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.153])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4QfZL161fCz4f3mWF;
	Mon, 12 Jun 2023 09:46:49 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP1 (Coremail) with SMTP id cCh0CgCH8iwHeYZknblyKw--.56297S2;
	Mon, 12 Jun 2023 09:46:50 +0800 (CST)
Subject: Re: [PATCH bpf-next v5] selftests/bpf: Add benchmark for bpf memory
 allocator
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: bpf <bpf@vger.kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>,
 Andrii Nakryiko <andrii@kernel.org>, Song Liu <song@kernel.org>,
 Hao Luo <haoluo@google.com>, Yonghong Song <yhs@fb.com>,
 Daniel Borkmann <daniel@iogearbox.net>, KP Singh <kpsingh@kernel.org>,
 Stanislav Fomichev <sdf@google.com>, Jiri Olsa <jolsa@kernel.org>,
 John Fastabend <john.fastabend@gmail.com>,
 "Paul E . McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org,
 Hou Tao <houtao1@huawei.com>
References: <20230609024030.2585058-1-houtao@huaweicloud.com>
 <CAADnVQJ5m_gT2h41m2_tuf=GDGSWzVSA6ixOwQECzGv8VimZwA@mail.gmail.com>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <ff4b2396-48aa-28f1-c91b-7c8a4b9510bb@huaweicloud.com>
Date: Mon, 12 Jun 2023 09:46:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CAADnVQJ5m_gT2h41m2_tuf=GDGSWzVSA6ixOwQECzGv8VimZwA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-CM-TRANSID:cCh0CgCH8iwHeYZknblyKw--.56297S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZFyktr48GrW5Ww1ktr4ruFg_yoW8Wr43p3
	yfGa9xGrWDKrnrKwn2yw1UJay7Ja1vqw1UAFWSvryDCr1UXFnIqFWxZFWFq398uayxCFWU
	tFWvyrWxZ3W5Aw7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxV
	Aqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q
	6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6x
	kF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv
	67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyT
	uYvjxUrR6zUUUUU
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.0 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
	MAY_BE_FORGED,NICE_REPLY_A,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 6/10/2023 2:23 AM, Alexei Starovoitov wrote:
> On Thu, Jun 8, 2023 at 7:08 PM Hou Tao <houtao@huaweicloud.com> wrote:
>>
>> (1) non-preallocated + no bpf memory allocator (v6.0.19)
>> use kmalloc() + call_rcu
>>
>> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
>> | --                 | --        | --                  | --               |
>> | no_op              | 681.40    | 0.87                | 1.00             |
>> | overwrite          | 8.56      | 38.86               | 88.42            |
>> | batch_add_batch_del| 6.74      | 41.28               | 69.70            |
>> | add_del_on_diff_cpu| 4.68      | 3.43                | 5.70             |
>>
>> (2) preallocated
>> OPTS=--preallocated
>>
>> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
>> | --                 | --        | --                  | --               |
>> | no_op              | 673.95    | 1.98                | 1.98             |
>> | overwrite          | 114.63    | 1.99                | 1.99             |
>> | batch_add_batch_del| 78.34     | 2.04                | 2.06             |
>> | add_del_on_diff_cpu| 6.41      | 2.23                | 2.54             |
>>
>> (3) normal bpf memory allocator
>>
>> | name               | loop (k/s)| average memory (MiB)| peak memory (MiB)|
>> | --                 | --        | --                  | --               |
>> | no_op              | 656.20    | 0.99                | 0.99             |
>> | overwrite          | 81.21     | 1.10                | 2.49             |
>> | batch_add_batch_del| 18.40     | 2.13                | 2.62             |
>> | add_del_on_diff_cpu| 5.38      | 10.40               | 18.05            |
> I have a feeling that you didn't remeasure things and just copy pasted
> above from v4.
I indeed reran the benchmark for v5. But I did in a wrong kernel
version, so the benchmark for normal bpf memory allocator doesn't seem
right.
> I see vastly different numbers in v5.
> and peak memory usage is broken.
My bad. Forgot to include the change of htab_mem_report_final() in the
final v5. The call of cleanup_cgroup_environment() should be moved to
the end of htab_mem_report_final(). Will fix in v6.
> It always shows:
> peak memory usage    0.00MiB



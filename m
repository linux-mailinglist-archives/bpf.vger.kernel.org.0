Return-Path: <bpf+bounces-9231-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C515F792028
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 05:31:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E04961C2048B
	for <lists+bpf@lfdr.de>; Tue,  5 Sep 2023 03:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71AF564E;
	Tue,  5 Sep 2023 03:31:05 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377627E
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 03:31:03 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34950CC7
	for <bpf@vger.kernel.org>; Mon,  4 Sep 2023 20:31:02 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Rfrcx6qpgz4f3jJ1
	for <bpf@vger.kernel.org>; Tue,  5 Sep 2023 11:30:57 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP2 (Coremail) with SMTP id Syh0CgB34WXuoPZkx5eACQ--.49393S2;
	Tue, 05 Sep 2023 11:30:58 +0800 (CST)
Subject: Re: [PATCH bpf-next 00/12] bpf: Add missed stats for kprobes
To: Jiri Olsa <jolsa@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
 Daniel Xu <dxu@dxuuu.xyz>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
References: <20230828075537.194192-1-jolsa@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <85f528b3-f1bc-fdcf-d816-d2d20d7ce24f@huaweicloud.com>
Date: Tue, 5 Sep 2023 11:30:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230828075537.194192-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:Syh0CgB34WXuoPZkx5eACQ--.49393S2
X-Coremail-Antispam: 1UD129KBjvJXoWxuF43uF47CFW5tw4DCFyxGrg_yoW5uw1UpF
	1fX343Kr18tFy3Xr13J3yUZryrtr4kZr47JF17Jr93Jr1UAry8Jr1xKrW0vr9xGry5tr1a
	vr4qkr98G3yxXrDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvab4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
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
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi,

On 8/28/2023 3:55 PM, Jiri Olsa wrote:
> hi,
> at the moment we can't retrieve the number of missed kprobe
> executions and subsequent execution of BPF programs.
>
> This patchset adds:
>   - counting of missed execution on attach layer for:
>     . kprobes attached through perf link (kprobe/ftrace)
>     . kprobes attached through kprobe.multi link (fprobe)
>   - counting of recursion_misses for BPF kprobe programs

Because trace_call_bpf() is used for both kprobe and trace-point bpf
program, so I think it is better to add one selftest for missed counter
for trace-point program as well.
>   - counting runtime stats (kernel.bpf_stats_enabled=1) for BPF programs
>     executed through bpf_prog_run_array - kprobes, perf events, trace
>     syscall probes
>
>
> It's still technically possible to create kprobe without perf link (using
> SET_BPF perf ioctl) in which case we don't have a way to retrieve the kprobe's
> 'missed' count. However both libbpf and cilium/ebpf libraries use perf link
> if it's available, and for old kernels without perf link support we can use
> BPF program to retrieve the kprobe missed count.
>
> Also available at:
>   https://git.kernel.org/pub/scm/linux/kernel/git/jolsa/perf.git
>   bpf/missed_stats
>
> thanks,
> jirka
>
>
> ---
> Jiri Olsa (12):
>       bpf: Move update_prog_stats to syscall object
>       bpf: Move bpf_prog_start_time to linux/filter.h
>       bpf: Count stats for kprobe_multi programs
>       bpf: Add missed value to kprobe_multi link info
>       bpf: Add missed value to kprobe perf link info
>       bpf: Count missed stats in trace_call_bpf
>       bpf: Move bpf_prog_run_array down in the header file
>       bpf: Count run stats in bpf_prog_run_array
>       bpftool: Display missed count for kprobe_multi link
>       bpftool: Display missed count for kprobe perf link
>       selftests/bpf: Add test missed counts of perf event link kprobe
>       elftests/bpf: Add test recursion stats of perf event link kprobe
>
>  include/linux/bpf.h                                         | 106 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------------------------
>  include/linux/trace_events.h                                |   6 ++++--
>  include/uapi/linux/bpf.h                                    |   2 ++
>  kernel/bpf/syscall.c                                        |  36 +++++++++++++++++++++++++------
>  kernel/bpf/trampoline.c                                     |  45 +++++----------------------------------
>  kernel/trace/bpf_trace.c                                    |  17 ++++++++++++---
>  kernel/trace/trace_kprobe.c                                 |   5 ++++-
>  tools/bpf/bpftool/link.c                                    |   8 ++++++-
>  tools/include/uapi/linux/bpf.h                              |   2 ++
>  tools/testing/selftests/bpf/DENYLIST.aarch64                |   1 +
>  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod.c       |   5 +++++
>  tools/testing/selftests/bpf/bpf_testmod/bpf_testmod_kfunc.h |   2 ++
>  tools/testing/selftests/bpf/prog_tests/missed.c             |  97 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/missed_kprobe.c           |  30 ++++++++++++++++++++++++++
>  tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c |  48 +++++++++++++++++++++++++++++++++++++++++
>  15 files changed, 327 insertions(+), 83 deletions(-)
>  create mode 100644 tools/testing/selftests/bpf/prog_tests/missed.c
>  create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe.c
>  create mode 100644 tools/testing/selftests/bpf/progs/missed_kprobe_recursion.c
>
> .



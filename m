Return-Path: <bpf+bounces-9029-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 594F178E742
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 09:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13132280F91
	for <lists+bpf@lfdr.de>; Thu, 31 Aug 2023 07:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AA563DB;
	Thu, 31 Aug 2023 07:37:46 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B1E53BD
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 07:37:46 +0000 (UTC)
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959201A3
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 00:37:44 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.143])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4RbtKw0rPrz4f3l1s
	for <bpf@vger.kernel.org>; Thu, 31 Aug 2023 15:37:40 +0800 (CST)
Received: from [10.174.176.117] (unknown [10.174.176.117])
	by APP4 (Coremail) with SMTP id gCh0CgAX9KZBQ_BkOLIJCA--.8867S2;
	Thu, 31 Aug 2023 15:37:41 +0800 (CST)
Subject: Re: [RFC/PATCH bpf-next] bpf: Fix d_path test after last fs update
To: Jiri Olsa <jolsa@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
 Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@chromium.org>,
 Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
References: <20230830093502.1436694-1-jolsa@kernel.org>
From: Hou Tao <houtao@huaweicloud.com>
Message-ID: <89bb059e-f371-8354-5770-f022396e0b38@huaweicloud.com>
Date: Thu, 31 Aug 2023 15:37:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230830093502.1436694-1-jolsa@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-CM-TRANSID:gCh0CgAX9KZBQ_BkOLIJCA--.8867S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWF48XF43XF4fuF1fGFW3KFg_yoW5GF4xpa
	y8G34akr4ktrW3tas7Ja1kWFyfGw4xXry0gF1kX343uF1xXr4vgFsIgw4UXr15G3yrZrZ3
	u3W2gFy0kr47ua7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUv2b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7I2V7IY0VAS
	07AlzVAYIcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c
	02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_
	GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7
	CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAF
	wI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa
	7IU1zuWJUUUUU==
X-CM-SenderInfo: xkrx3t3r6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Hi

On 8/30/2023 5:35 PM, Jiri Olsa wrote:
> Recent commit [1] broken d_path test, because now filp_close is not
> called directly from sys_close, but eventually later when the file
> is finally released.

To make test_d_path self-test pass, beside attaching to a different
function (e.g., __fput_sync or filp_flush), we could also use
close_range() or even dup2() to close the created fd, because these
syscalls still use filp_close() to close the opened file.

>
> I can't see any other solution than to hook filp_flush function and
> that also means we need to add it to btf_allowlist_d_path list, so
> it can use the d_path helper.
>
> But it's probably not very stable because filp_flush is static so it
> could be potentially inlined.
>
> Also if we'd keep the current filp_close hook and find a way how to 'wait'
> for it to be called so user space can go with checks, then it looks
> like d_path might not work properly when the task is no longer around.

It seems there is no need to wait for it to be called, because
filp_close() is still called synchronously by some syscall (e.g.,
close_range or io_uring). So if the bpf program tries to collect many
close event as possible, it should be attach to both filp_close() and
__fput_sync(), right ?

>
> thoughts?
> jirka
>
>
> [1] 021a160abf62 ("fs: use __fput_sync in close(2)")
> ---
>  kernel/trace/bpf_trace.c                        | 1 +
>  tools/testing/selftests/bpf/progs/test_d_path.c | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
> index a7264b2c17ad..c829e24af246 100644
> --- a/kernel/trace/bpf_trace.c
> +++ b/kernel/trace/bpf_trace.c
> @@ -941,6 +941,7 @@ BTF_ID(func, vfs_fallocate)
>  BTF_ID(func, dentry_open)
>  BTF_ID(func, vfs_getattr)
>  BTF_ID(func, filp_close)
> +BTF_ID(func, filp_flush)
>  BTF_SET_END(btf_allowlist_d_path)
>  
>  static bool bpf_d_path_allowed(const struct bpf_prog *prog)
> diff --git a/tools/testing/selftests/bpf/progs/test_d_path.c b/tools/testing/selftests/bpf/progs/test_d_path.c
> index 84e1f883f97b..3467d1b8098c 100644
> --- a/tools/testing/selftests/bpf/progs/test_d_path.c
> +++ b/tools/testing/selftests/bpf/progs/test_d_path.c
> @@ -40,8 +40,8 @@ int BPF_PROG(prog_stat, struct path *path, struct kstat *stat,
>  	return 0;
>  }
>  
> -SEC("fentry/filp_close")
> -int BPF_PROG(prog_close, struct file *file, void *id)
> +SEC("fentry/filp_flush")
> +int BPF_PROG(prog_close, struct file *file)
>  {
>  	pid_t pid = bpf_get_current_pid_tgid() >> 32;
>  	__u32 cnt = cnt_close;



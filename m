Return-Path: <bpf+bounces-52179-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BBEDA3F7EB
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 16:01:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 368D77A9B3F
	for <lists+bpf@lfdr.de>; Fri, 21 Feb 2025 15:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BE8920E31D;
	Fri, 21 Feb 2025 15:01:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from dediextern.your-server.de (dediextern.your-server.de [85.10.215.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF6EC74BED
	for <bpf@vger.kernel.org>; Fri, 21 Feb 2025 15:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.215.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740150075; cv=none; b=Z+3kc2YlDk9Z0xpePHZP66DcZ8m901hwIQPzdd/MD7m4uu1aa4VIwJGFrjMjQgphIraTCoU9TZTTM/MURkuZL5ptrj4GbrYvvUtJWOSlVteh2J/uccOJveOeDVvkF0Zsc11oROz7ew2mne1hAfxeA+mMk77Yl8dFNHW6R+VqchM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740150075; c=relaxed/simple;
	bh=eVFw56ZIhYoI5eYYTvTm5zU8Srp7xgjgxX2u8QT6rqA=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:From:Subject:
	 In-Reply-To:Content-Type; b=D6q7I/6yHi6jWs+y68WSpDDw4+PxfwEAcTx0S6ccqGUw30OanLLvUq/52c2hl3p73JxvSiGb+b3kRBfaAlZXZI1o4mXKPT2+kPwx99rmnQUyzR5DkYupBKSn+0h1MqthulNv450vdEHC3IUD71JF68VGnZ6WdG92D+fntYCoQoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de; spf=pass smtp.mailfrom=hetzner-cloud.de; arc=none smtp.client-ip=85.10.215.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=hetzner-cloud.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hetzner-cloud.de
Received: from sslproxy08.your-server.de ([78.47.166.52])
	by dediextern.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tlUWH-000DkE-N8; Fri, 21 Feb 2025 16:00:49 +0100
Received: from [2a0d:3344:1523:1f10:f118:b2d4:edbb:54af]
	by sslproxy08.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <marcus.wichelmann@hetzner-cloud.de>)
	id 1tlUWG-000DIE-2l;
	Fri, 21 Feb 2025 16:00:49 +0100
Message-ID: <386d3514-1822-45a2-a2c5-1567a0d599a5@hetzner-cloud.de>
Date: Fri, 21 Feb 2025 16:00:47 +0100
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jordan Rome <linux@jordanrome.com>, bpf@vger.kernel.org
Cc: linux-mm@kvack.org, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Kernel Team <kernel-team@fb.com>, Andrew Morton <akpm@linux-foundation.org>,
 Shakeel Butt <shakeel.butt@linux.dev>,
 Alexander Potapenko <glider@google.com>
References: <20250213152125.1837400-1-linux@jordanrome.com>
 <20250213152125.1837400-3-linux@jordanrome.com>
Content-Language: en-US
From: Marcus Wichelmann <marcus.wichelmann@hetzner-cloud.de>
Autocrypt: addr=marcus.wichelmann@hetzner-cloud.de; keydata=
 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
 wySmewx3h/yfMh0aFxHhvLPxrO2IEQ==
Subject: Re: [bpf-next v8 3/3] selftests/bpf: Add tests for
 bpf_copy_from_user_task_str
In-Reply-To: <20250213152125.1837400-3-linux@jordanrome.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: marcus.wichelmann@hetzner-cloud.de
X-Virus-Scanned: Clear (ClamAV 1.0.7/27556/Fri Feb 21 10:31:23 2025)

Hi,

I'm not sure what I'm doing wrong, but after rebasing on latest bpf-next
which includes this patch, I'm no longer able to build the bpf selftests:

# pushd tools/testing/selftests/bpf/
# make -j80
[...]
   GEN-SKEL [test_progs] bpf_iter_task_vmas.skel.h
   CLNG-BPF [test_progs] bpf_iter_tasks.bpf.o
progs/bpf_iter_tasks.c:98:8: error: call to undeclared function 'bpf_copy_from_user_task_str'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
    98 |         ret = bpf_copy_from_user_task_str((char *)task_str1, sizeof(task_str1), ptr, task, 0);
       |               ^
1 error generated.
make: *** [Makefile:733: /root/linux/tools/testing/selftests/bpf/bpf_iter_tasks.bpf.o] Error 1

I suppose the function definition should be in the vmlinux.h?

# grep bpf_copy tools/include/vmlinux.h
typedef u64 (*btf_bpf_copy_from_user)(void *, u32, const void *);
typedef u64 (*btf_bpf_copy_from_user_task)(void *, u32, const void *, struct task_struct *, u64);

The kernel built from this revision is booted while trying to compile
the selftests. I can also see that the kfunc is there when dumping without "format c":

# bpftool btf dump file /sys/kernel/btf/vmlinux | grep bpf_copy_from_user_task_str
[116060] FUNC 'bpf_copy_from_user_task_str' type_id=116059 linkage=static

But when dumping the vmlinux headers with "format c", I cannot see the kfunc.
I'm not sure if this is normal:

# bpftool btf dump file /sys/kernel/btf/vmlinux format c | grep bpf_copy_from_user_task_str
#

CONFIG_BPF SYSCALL is enabled. Are there other config options that
have to be enabled that I may be missing?

I'm trying this on a aarch64 system. I also tried to fully clean
my working tree using `git clean -d -x -f`, which didn't help
either.

Thanks!
Marcus


Am 13.02.25 um 16:21 schrieb Jordan Rome:
> This adds tests for both the happy path and the
> error path (with and without the BPF_F_PAD_ZEROS flag).
> 
> Signed-off-by: Jordan Rome <linux@jordanrome.com>
> ---
>   .../selftests/bpf/prog_tests/bpf_iter.c       |  68 +++++++++++
>   .../selftests/bpf/prog_tests/read_vsyscall.c  |   1 +
>   .../selftests/bpf/progs/bpf_iter_tasks.c      | 110 ++++++++++++++++++
>   .../selftests/bpf/progs/read_vsyscall.c       |  11 +-
>   4 files changed, 188 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> index 6f1bfacd7375..add4a18c33bd 100644
> --- a/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> +++ b/tools/testing/selftests/bpf/prog_tests/bpf_iter.c
> @@ -323,19 +323,87 @@ static void test_task_pidfd(void)
>   static void test_task_sleepable(void)
>   {
>   	struct bpf_iter_tasks *skel;
> +	int pid, status, err, data_pipe[2], finish_pipe[2], c;
> +	char *test_data = NULL;
> +	char *test_data_long = NULL;
> +	char *data[2];
> +
> +	if (!ASSERT_OK(pipe(data_pipe), "data_pipe") ||
> +	    !ASSERT_OK(pipe(finish_pipe), "finish_pipe"))
> +		return;
> 
>   	skel = bpf_iter_tasks__open_and_load();
>   	if (!ASSERT_OK_PTR(skel, "bpf_iter_tasks__open_and_load"))
>   		return;
> 
> +	pid = fork();
> +	if (!ASSERT_GE(pid, 0, "fork"))
> +		return;
> +
> +	if (pid == 0) {
> +		/* child */
> +		close(data_pipe[0]);
> +		close(finish_pipe[1]);
> +
> +		test_data = malloc(sizeof(char) * 10);
> +		strncpy(test_data, "test_data", 10);
> +		test_data[9] = '\0';
> +
> +		test_data_long = malloc(sizeof(char) * 5000);
> +		for (int i = 0; i < 5000; ++i) {
> +			if (i % 2 == 0)
> +				test_data_long[i] = 'b';
> +			else
> +				test_data_long[i] = 'a';
> +		}
> +		test_data_long[4999] = '\0';
> +
> +		data[0] = test_data;
> +		data[1] = test_data_long;
> +
> +		write(data_pipe[1], &data, sizeof(data));
> +
> +		/* keep child alive until after the test */
> +		err = read(finish_pipe[0], &c, 1);
> +		if (err != 1)
> +			exit(-1);
> +
> +		close(data_pipe[1]);
> +		close(finish_pipe[0]);
> +		_exit(0);
> +	}
> +
> +	/* parent */
> +	close(data_pipe[1]);
> +	close(finish_pipe[0]);
> +
> +	err = read(data_pipe[0], &data, sizeof(data));
> +	ASSERT_EQ(err, sizeof(data), "read_check");
> +
> +	skel->bss->user_ptr = data[0];
> +	skel->bss->user_ptr_long = data[1];
> +	skel->bss->pid = pid;
> +
>   	do_dummy_read(skel->progs.dump_task_sleepable);
> 
>   	ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task, 0,
>   		  "num_expected_failure_copy_from_user_task");
>   	ASSERT_GT(skel->bss->num_success_copy_from_user_task, 0,
>   		  "num_success_copy_from_user_task");
> +	ASSERT_GT(skel->bss->num_expected_failure_copy_from_user_task_str, 0,
> +		  "num_expected_failure_copy_from_user_task_str");
> +	ASSERT_GT(skel->bss->num_success_copy_from_user_task_str, 0,
> +		  "num_success_copy_from_user_task_str");
> 
>   	bpf_iter_tasks__destroy(skel);
> +
> +	write(finish_pipe[1], &c, 1);
> +	err = waitpid(pid, &status, 0);
> +	ASSERT_EQ(err, pid, "waitpid");
> +	ASSERT_EQ(status, 0, "zero_child_exit");
> +
> +	close(data_pipe[0]);
> +	close(finish_pipe[1]);
>   }
> 
>   static void test_task_stack(void)
> diff --git a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> index c7b9ba8b1d06..a8d1eaa67020 100644
> --- a/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> +++ b/tools/testing/selftests/bpf/prog_tests/read_vsyscall.c
> @@ -24,6 +24,7 @@ struct read_ret_desc {
>   	{ .name = "copy_from_user", .ret = -EFAULT },
>   	{ .name = "copy_from_user_task", .ret = -EFAULT },
>   	{ .name = "copy_from_user_str", .ret = -EFAULT },
> +	{ .name = "copy_from_user_task_str", .ret = -EFAULT },
>   };
> 
>   void test_read_vsyscall(void)
> diff --git a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> index bc10c4e4b4fa..966ee5a7b066 100644
> --- a/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> +++ b/tools/testing/selftests/bpf/progs/bpf_iter_tasks.c
> @@ -9,6 +9,13 @@ char _license[] SEC("license") = "GPL";
>   uint32_t tid = 0;
>   int num_unknown_tid = 0;
>   int num_known_tid = 0;
> +void *user_ptr = 0;
> +void *user_ptr_long = 0;
> +uint32_t pid = 0;
> +
> +static char big_str1[5000];
> +static char big_str2[5005];
> +static char big_str3[4996];
> 
>   SEC("iter/task")
>   int dump_task(struct bpf_iter__task *ctx)
> @@ -35,7 +42,9 @@ int dump_task(struct bpf_iter__task *ctx)
>   }
> 
>   int num_expected_failure_copy_from_user_task = 0;
> +int num_expected_failure_copy_from_user_task_str = 0;
>   int num_success_copy_from_user_task = 0;
> +int num_success_copy_from_user_task_str = 0;
> 
>   SEC("iter.s/task")
>   int dump_task_sleepable(struct bpf_iter__task *ctx)
> @@ -44,6 +53,9 @@ int dump_task_sleepable(struct bpf_iter__task *ctx)
>   	struct task_struct *task = ctx->task;
>   	static const char info[] = "    === END ===";
>   	struct pt_regs *regs;
> +	char task_str1[10] = "aaaaaaaaaa";
> +	char task_str2[10], task_str3[10];
> +	char task_str4[20] = "aaaaaaaaaaaaaaaaaaaa";
>   	void *ptr;
>   	uint32_t user_data = 0;
>   	int ret;
> @@ -78,8 +90,106 @@ int dump_task_sleepable(struct bpf_iter__task *ctx)
>   		BPF_SEQ_PRINTF(seq, "%s\n", info);
>   		return 0;
>   	}
> +
>   	++num_success_copy_from_user_task;
> 
> +	/* Read an invalid pointer and ensure we get an error */
> +	ptr = NULL;
> +	ret = bpf_copy_from_user_task_str((char *)task_str1, sizeof(task_str1), ptr, task, 0);
> +	if (ret >= 0 || task_str1[9] != 'a' || task_str1[0] != '\0') {
> +		BPF_SEQ_PRINTF(seq, "%s\n", info);
> +		return 0;
> +	}
> +
> +	/* Read an invalid pointer and ensure we get error with pad zeros flag */
> +	ptr = NULL;
> +	ret = bpf_copy_from_user_task_str((char *)task_str1, sizeof(task_str1),
> +					  ptr, task, BPF_F_PAD_ZEROS);
> +	if (ret >= 0 || task_str1[9] != '\0' || task_str1[0] != '\0') {
> +		BPF_SEQ_PRINTF(seq, "%s\n", info);
> +		return 0;
> +	}
> +
> +	++num_expected_failure_copy_from_user_task_str;
> +
> +	/* Same length as the string */
> +	ret = bpf_copy_from_user_task_str((char *)task_str2, 10, user_ptr, task, 0);
> +	/* only need to do the task pid check once */
> +	if (bpf_strncmp(task_str2, 10, "test_data\0") != 0 || ret != 10 || task->tgid != pid) {
> +		BPF_SEQ_PRINTF(seq, "%s\n", info);
> +		return 0;
> +	}
> +
> +	/* Shorter length than the string */
> +	ret = bpf_copy_from_user_task_str((char *)task_str3, 2, user_ptr, task, 0);
> +	if (bpf_strncmp(task_str3, 2, "t\0") != 0 || ret != 2) {
> +		BPF_SEQ_PRINTF(seq, "%s\n", info);
> +		return 0;
> +	}
> +
> +	/* Longer length than the string */
> +	ret = bpf_copy_from_user_task_str((char *)task_str4, 20, user_ptr, task, 0);
> +	if (bpf_strncmp(task_str4, 10, "test_data\0") != 0 || ret != 10
> +	    || task_str4[sizeof(task_str4) - 1] != 'a') {
> +		BPF_SEQ_PRINTF(seq, "%s\n", info);
> +		return 0;
> +	}
> +
> +	/* Longer length than the string with pad zeros flag */
> +	ret = bpf_copy_from_user_task_str((char *)task_str4, 20, user_ptr, task, BPF_F_PAD_ZEROS);
> +	if (bpf_strncmp(task_str4, 10, "test_data\0") != 0 || ret != 10
> +	    || task_str4[sizeof(task_str4) - 1] != '\0') {
> +		BPF_SEQ_PRINTF(seq, "%s\n", info);
> +		return 0;
> +	}
> +
> +	/* Longer length than the string past a page boundary */
> +	ret = bpf_copy_from_user_task_str(big_str1, 5000, user_ptr, task, 0);
> +	if (bpf_strncmp(big_str1, 10, "test_data\0") != 0 || ret != 10) {
> +		BPF_SEQ_PRINTF(seq, "%s\n", info);
> +		return 0;
> +	}
> +
> +	/* String that crosses a page boundary */
> +	ret = bpf_copy_from_user_task_str(big_str1, 5000, user_ptr_long, task, BPF_F_PAD_ZEROS);
> +	if (bpf_strncmp(big_str1, 4, "baba") != 0 || ret != 5000
> +	    || bpf_strncmp(big_str1 + 4996, 4, "bab\0") != 0) {
> +		BPF_SEQ_PRINTF(seq, "%s\n", info);
> +		return 0;
> +	}
> +
> +	for (int i = 0; i < 4999; ++i) {
> +		if (i % 2 == 0) {
> +			if (big_str1[i] != 'b') {
> +				BPF_SEQ_PRINTF(seq, "%s\n", info);
> +				return 0;
> +			}
> +		} else {
> +			if (big_str1[i] != 'a') {
> +				BPF_SEQ_PRINTF(seq, "%s\n", info);
> +				return 0;
> +			}
> +		}
> +	}
> +
> +	/* Longer length than the string that crosses a page boundary */
> +	ret = bpf_copy_from_user_task_str(big_str2, 5005, user_ptr_long, task, BPF_F_PAD_ZEROS);
> +	if (bpf_strncmp(big_str2, 4, "baba") != 0 || ret != 5000
> +	    || bpf_strncmp(big_str2 + 4996, 5, "bab\0\0") != 0) {
> +		BPF_SEQ_PRINTF(seq, "%s\n", info);
> +		return 0;
> +	}
> +
> +	/* Shorter length than the string that crosses a page boundary */
> +	ret = bpf_copy_from_user_task_str(big_str3, 4996, user_ptr_long, task, 0);
> +	if (bpf_strncmp(big_str3, 4, "baba") != 0 || ret != 4996
> +	    || bpf_strncmp(big_str3 + 4992, 4, "bab\0") != 0) {
> +		BPF_SEQ_PRINTF(seq, "%s\n", info);
> +		return 0;
> +	}
> +
> +	++num_success_copy_from_user_task_str;
> +
>   	if (ctx->meta->seq_num == 0)
>   		BPF_SEQ_PRINTF(seq, "    tgid      gid     data\n");
> 
> diff --git a/tools/testing/selftests/bpf/progs/read_vsyscall.c b/tools/testing/selftests/bpf/progs/read_vsyscall.c
> index 39ebef430059..395591374d4f 100644
> --- a/tools/testing/selftests/bpf/progs/read_vsyscall.c
> +++ b/tools/testing/selftests/bpf/progs/read_vsyscall.c
> @@ -8,14 +8,16 @@
> 
>   int target_pid = 0;
>   void *user_ptr = 0;
> -int read_ret[9];
> +int read_ret[10];
> 
>   char _license[] SEC("license") = "GPL";
> 
>   /*
> - * This is the only kfunc, the others are helpers
> + * These are the kfuncs, the others are helpers
>    */
>   int bpf_copy_from_user_str(void *dst, u32, const void *, u64) __weak __ksym;
> +int bpf_copy_from_user_task_str(void *dst, u32, const void *,
> +				struct task_struct *, u64) __weak __ksym;
> 
>   SEC("fentry/" SYS_PREFIX "sys_nanosleep")
>   int do_probe_read(void *ctx)
> @@ -47,6 +49,11 @@ int do_copy_from_user(void *ctx)
>   	read_ret[7] = bpf_copy_from_user_task(buf, sizeof(buf), user_ptr,
>   					      bpf_get_current_task_btf(), 0);
>   	read_ret[8] = bpf_copy_from_user_str((char *)buf, sizeof(buf), user_ptr, 0);
> +	read_ret[9] = bpf_copy_from_user_task_str((char *)buf,
> +						  sizeof(buf),
> +						  user_ptr,
> +						  bpf_get_current_task_btf(),
> +						  0);
> 
>   	return 0;
>   }
> --
> 2.43.5
> 
> 

-- 
Best regards,
Marcus Wichelmann
Linux Networking Specialist
Team SDN

______________________________

Hetzner Cloud GmbH
Feringastraße 12A
85774 Unterföhring
Germany

Phone: +49 89 381690 150
E-Mail: marcus.wichelmann@hetzner-cloud.de

Handelsregister München HRB 226782
Geschäftsführer: Sebastian Färber, Markus Kalmuk

------------------
For information on the processing of your personal
data in the context of this contact, please see
https://hetzner-cloud.de/datenschutz
------------------



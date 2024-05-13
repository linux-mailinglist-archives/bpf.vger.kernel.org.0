Return-Path: <bpf+bounces-29630-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4A48C3E4C
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 11:45:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA77CB217D1
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 09:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F0A1148833;
	Mon, 13 May 2024 09:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="omVU3PSm"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC70219E7;
	Mon, 13 May 2024 09:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715593516; cv=none; b=vGUOyjfTwGnpHYtfJKd6OfjmgVj4EY4IeLw0cZMqNQeY2xveYbqWtDWS6NrPU/waCZd6z75xhT5q9x4stahfbZ7qT1OM0lOI1t7om5hG3tqCLtSm4ZkkgKx8AT5SGEuS7srfnGNKj5W9GtbkBFfz8DOrjedk8hdefg1QetVUaVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715593516; c=relaxed/simple;
	bh=peJzz5pNrQ/dEd3/VmjQgcVwR9MR0Gcc9ElaVB8uRng=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=kcClYuP8xEtXoK3SxLWKoXmgELQDNMiYaSrQeVHiYDXFPNAY8Nynz69yTEw5pGaPsNXcygW576gm9+jtVCtOmukwx4krrfthvFyBN96RzGOuZXMCLzxTi/3mRk2iAJWN8u7VFqgt+6tLAbC/22WrcPfPmm9SQRT0nsMIWstekXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=omVU3PSm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA43EC32782;
	Mon, 13 May 2024 09:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715593516;
	bh=peJzz5pNrQ/dEd3/VmjQgcVwR9MR0Gcc9ElaVB8uRng=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=omVU3PSmZPRU/dJbyVEGRWRJOaYQYEVzCZM7oVTLVxHkxzcm7EuYMmMHpHXqdj/FO
	 mtx/X476N7pzNOk+/GEZFPq1248HEHfguaFibnNrn0+ax5CZStVsWQkUuoY5pSr9z8
	 79CjnPHph4jEJVAsTq7dUiTpJOcLBqbHA63ZjpcLhqCNDPcNQzcRlMOHwS08nqQ9Cq
	 BK8mpsrxtC+b6/hUZJfMDJLNAl28WyyT/jiMKm98KU2oyFHZ2hiA01jnTWt/58YTeV
	 naEXmJP+KMvmfjFUEFwNpIdLqFYn7cWFCcdh7Z0xADPkjchGbrnK34yYSjKR9wy7Bi
	 fRnJboZpjXtRA==
Date: Mon, 13 May 2024 18:45:07 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <jolsa@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-api@vger.kernel.org, linux-man@vger.kernel.org, x86@kernel.org,
 bpf@vger.kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song
 <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
 Andy Lutomirski <luto@kernel.org>, "Edgecombe, Rick P"
 <rick.p.edgecombe@intel.com>, Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv5 bpf-next 7/8] selftests/x86: Add return uprobe shadow
 stack test
Message-Id: <20240513184507.215ec89dea4790243d17a52c@kernel.org>
In-Reply-To: <20240507105321.71524-8-jolsa@kernel.org>
References: <20240507105321.71524-1-jolsa@kernel.org>
	<20240507105321.71524-8-jolsa@kernel.org>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  7 May 2024 12:53:20 +0200
Jiri Olsa <jolsa@kernel.org> wrote:

> Adding return uprobe test for shadow stack and making sure it's
> working properly. Borrowed some of the code from bpf selftests.

Hi Jiri,

I can not find "SKIP" result in this change. If CONFIG_UPROBES=n,
this should skip uprobe test.

Thank you,

> 
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  .../testing/selftests/x86/test_shadow_stack.c | 142 ++++++++++++++++++
>  1 file changed, 142 insertions(+)
> 
> diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
> index 757e6527f67e..1b919baa999b 100644
> --- a/tools/testing/selftests/x86/test_shadow_stack.c
> +++ b/tools/testing/selftests/x86/test_shadow_stack.c
> @@ -34,6 +34,7 @@
>  #include <sys/ptrace.h>
>  #include <sys/signal.h>
>  #include <linux/elf.h>
> +#include <linux/perf_event.h>
>  
>  /*
>   * Define the ABI defines if needed, so people can run the tests
> @@ -681,6 +682,141 @@ int test_32bit(void)
>  	return !segv_triggered;
>  }
>  
> +static int parse_uint_from_file(const char *file, const char *fmt)
> +{
> +	int err, ret;
> +	FILE *f;
> +
> +	f = fopen(file, "re");
> +	if (!f) {
> +		err = -errno;
> +		printf("failed to open '%s': %d\n", file, err);
> +		return err;
> +	}
> +	err = fscanf(f, fmt, &ret);
> +	if (err != 1) {
> +		err = err == EOF ? -EIO : -errno;
> +		printf("failed to parse '%s': %d\n", file, err);
> +		fclose(f);
> +		return err;
> +	}
> +	fclose(f);
> +	return ret;
> +}
> +
> +static int determine_uprobe_perf_type(void)
> +{
> +	const char *file = "/sys/bus/event_source/devices/uprobe/type";
> +
> +	return parse_uint_from_file(file, "%d\n");
> +}
> +
> +static int determine_uprobe_retprobe_bit(void)
> +{
> +	const char *file = "/sys/bus/event_source/devices/uprobe/format/retprobe";
> +
> +	return parse_uint_from_file(file, "config:%d\n");
> +}
> +
> +static ssize_t get_uprobe_offset(const void *addr)
> +{
> +	size_t start, end, base;
> +	char buf[256];
> +	bool found = false;
> +	FILE *f;
> +
> +	f = fopen("/proc/self/maps", "r");
> +	if (!f)
> +		return -errno;
> +
> +	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
> +		if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
> +			found = true;
> +			break;
> +		}
> +	}
> +
> +	fclose(f);
> +
> +	if (!found)
> +		return -ESRCH;
> +
> +	return (uintptr_t)addr - start + base;
> +}
> +
> +static __attribute__((noinline)) void uretprobe_trigger(void)
> +{
> +	asm volatile ("");
> +}
> +
> +/*
> + * This test setups return uprobe, which is sensitive to shadow stack
> + * (crashes without extra fix). After executing the uretprobe we fail
> + * the test if we receive SIGSEGV, no crash means we're good.
> + *
> + * Helper functions above borrowed from bpf selftests.
> + */
> +static int test_uretprobe(void)
> +{
> +	const size_t attr_sz = sizeof(struct perf_event_attr);
> +	const char *file = "/proc/self/exe";
> +	int bit, fd = 0, type, err = 1;
> +	struct perf_event_attr attr;
> +	struct sigaction sa = {};
> +	ssize_t offset;
> +
> +	type = determine_uprobe_perf_type();
> +	if (type < 0)
> +		return 1;
> +
> +	offset = get_uprobe_offset(uretprobe_trigger);
> +	if (offset < 0)
> +		return 1;
> +
> +	bit = determine_uprobe_retprobe_bit();
> +	if (bit < 0)
> +		return 1;
> +
> +	sa.sa_sigaction = segv_gp_handler;
> +	sa.sa_flags = SA_SIGINFO;
> +	if (sigaction(SIGSEGV, &sa, NULL))
> +		return 1;
> +
> +	/* Setup return uprobe through perf event interface. */
> +	memset(&attr, 0, attr_sz);
> +	attr.size = attr_sz;
> +	attr.type = type;
> +	attr.config = 1 << bit;
> +	attr.config1 = (__u64) (unsigned long) file;
> +	attr.config2 = offset;
> +
> +	fd = syscall(__NR_perf_event_open, &attr, 0 /* pid */, -1 /* cpu */,
> +		     -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
> +	if (fd < 0)
> +		goto out;
> +
> +	if (sigsetjmp(jmp_buffer, 1))
> +		goto out;
> +
> +	ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
> +
> +	/*
> +	 * This either segfaults and goes through sigsetjmp above
> +	 * or succeeds and we're good.
> +	 */
> +	uretprobe_trigger();
> +
> +	printf("[OK]\tUretprobe test\n");
> +	err = 0;
> +
> +out:
> +	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
> +	signal(SIGSEGV, SIG_DFL);
> +	if (fd)
> +		close(fd);
> +	return err;
> +}
> +
>  void segv_handler_ptrace(int signum, siginfo_t *si, void *uc)
>  {
>  	/* The SSP adjustment caused a segfault. */
> @@ -867,6 +1003,12 @@ int main(int argc, char *argv[])
>  		goto out;
>  	}
>  
> +	if (test_uretprobe()) {
> +		ret = 1;
> +		printf("[FAIL]\turetprobe test\n");
> +		goto out;
> +	}
> +
>  	return ret;
>  
>  out:
> -- 
> 2.44.0
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


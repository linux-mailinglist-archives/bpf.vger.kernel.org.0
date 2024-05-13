Return-Path: <bpf+bounces-29672-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CFE28C48DD
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 23:28:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F42F2810B5
	for <lists+bpf@lfdr.de>; Mon, 13 May 2024 21:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B831C83A11;
	Mon, 13 May 2024 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hPbvR8jG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D544E39FD8;
	Mon, 13 May 2024 21:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715635707; cv=none; b=uMwFdD6Yfb2GMLkcJ6s4rC6VIo4RoyfARXJkpdEFQYMAyVGZRZgHkpT0lZvm92aiE7hvnF5oazXLiZWQj81CHiDTSiL7UFlCbZKii1XBzHmHFlTWt1islVEbIpznvK/n5wAaJoDNC6KUCALk0EDzk/iYT62HBuoLom9c8oeN2jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715635707; c=relaxed/simple;
	bh=LBX+N5Ggua2JTg79zgfQCkDaC3nx4+lNOVDngdMnyk8=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JVGTTkhNIpfqo0qilq8JLHyj3U+odl1yNt1YGR7ruq3FoiJQqzYhY4XgiBK3wO89zf5SQi7aTWuaNPOpEHVv4uw/1TbEMcM6Wo8VWhxVO8AbLd+gRA7HwfEPXPkgbeJNqs1XlQb8BKK6RD9p6XQdJZIkicwu/YEjxAttFOuWh7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hPbvR8jG; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-61eba9f9c5dso3702928a12.0;
        Mon, 13 May 2024 14:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715635705; x=1716240505; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Cnoth6ZcdQw/rIhwFjYiJ5WI2BarXhQB3LevZcDNaps=;
        b=hPbvR8jGa+4d4vaBJuHyhgGTsahAs9o+Nnmavc4cPIb1zSIOTNle/5QQ7BjDbKzHLc
         hitqq0zAg3fzNx81YMf+k3I/OrQlb1Rl8kdhx+7FEQgniHq3n3AZHgOFkk7nzqzPZYMB
         KVN7jAtcCKLzOv5zCXajN4UzDaYYPhjj2aWA6+2DvgLbwwBKmLqhRPYnxrxgTdA9pmOA
         AC6rUy3ytU368/85p0HnPGeAYtqQCoo9oehKucN+v8LF/RYtGEYobmkpAQipPNHjGuFe
         ygzFUE/zSjbQItCXjtIUyZ85qSP6bOBj6xiyBrPa10ZH8m3byynRIM78JPSUlo7qJAWR
         MY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715635705; x=1716240505;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cnoth6ZcdQw/rIhwFjYiJ5WI2BarXhQB3LevZcDNaps=;
        b=G2cAOJAZiowKZPFwPMVRcFQUIvug4gOOkOEGqu7bYfTGyyLAkePGqUzEBaEwYP3bIW
         ZtYqfuPXltsdH2D0KVgGhZe3HxT0i4Y2pUUrNGtNMy+ZpqJX0e9661i/FaJZTbD9yYJt
         8cheBFyr48R4OgsgKDwWRw4Od1LxQ7kSJ9Y/9v8XoKkgJVfu9iklj+ABBwZRo4pYRVwM
         iUI9mtgKF118ZjO+87A1eM+c/jqSF9TW/PIaFwV3gOs3DY7CuZNYFXIayegokcZjujls
         w6nWrsJh3J34u8+rQ4M34XIzmWSOCUDW6rFWYhnOOV/RNz8ngURLyJgsWxfi0HHfk6bO
         4BOA==
X-Forwarded-Encrypted: i=1; AJvYcCWE0IkR+ssMVdOCrXIYisotWxaMFIE8+XALDCK+Fv/6g+xKYSr3WDcdTopP5FTcWivvN81U75dzKGNgWcELZiT56Ek47NM0fioFFbshyQbFpmL8wukLy/ZmCMcDtLo5ETLAXTkEymNGDPLaR4vnWJgmuKYPfaP++zO80SYe/Gh5KQXRLkq+CRy40iAGOaHp1034fJOLCmv5ntqGL26Qm8scKD6S18NoE0RoWJzAowsdkq+YPcFyQQ/Qfm3B
X-Gm-Message-State: AOJu0Yz5a6x5J+h1zXxy5ZVHkcm9912N/vVIcrMobyMCHpui1ttQ09HV
	k47c1+pvEfZsCY96s6SG5tXhwwg96P0w0gzh8rR+5CFISlQkBF9Y
X-Google-Smtp-Source: AGHT+IHkv+d6QPMuEL4E7fVb1LA2X8NN5ll/hGqsbcXiuhnvkSjMoilkO8Y0Nt+E6FS3tcrldryfkA==
X-Received: by 2002:a17:90b:4f45:b0:2b1:534f:ea09 with SMTP id 98e67ed59e1d1-2b6cc76d27amr9527797a91.23.1715635705202;
        Mon, 13 May 2024 14:28:25 -0700 (PDT)
Received: from krava ([50.204.89.31])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2b67126ac21sm8388958a91.30.2024.05.13.14.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 May 2024 14:28:24 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Mon, 13 May 2024 15:28:21 -0600
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Oleg Nesterov <oleg@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, linux-api@vger.kernel.org,
	linux-man@vger.kernel.org, x86@kernel.org, bpf@vger.kernel.org,
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Borislav Petkov (AMD)" <bp@alien8.de>,
	Ingo Molnar <mingo@redhat.com>, Andy Lutomirski <luto@kernel.org>,
	"Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
	Deepak Gupta <debug@rivosinc.com>
Subject: Re: [PATCHv5 bpf-next 7/8] selftests/x86: Add return uprobe shadow
 stack test
Message-ID: <ZkKF9WZVfFgiVSxe@krava>
References: <20240507105321.71524-1-jolsa@kernel.org>
 <20240507105321.71524-8-jolsa@kernel.org>
 <20240513184507.215ec89dea4790243d17a52c@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240513184507.215ec89dea4790243d17a52c@kernel.org>

On Mon, May 13, 2024 at 06:45:07PM +0900, Masami Hiramatsu wrote:
> On Tue,  7 May 2024 12:53:20 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > Adding return uprobe test for shadow stack and making sure it's
> > working properly. Borrowed some of the code from bpf selftests.
> 
> Hi Jiri,
> 
> I can not find "SKIP" result in this change. If CONFIG_UPROBES=n,
> this should skip uprobe test.

ah it should be detected by parse_uint_from_file returning ENOENT
or something like that.. will add that

thanks,
jirka

> 
> Thank you,
> 
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  .../testing/selftests/x86/test_shadow_stack.c | 142 ++++++++++++++++++
> >  1 file changed, 142 insertions(+)
> > 
> > diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
> > index 757e6527f67e..1b919baa999b 100644
> > --- a/tools/testing/selftests/x86/test_shadow_stack.c
> > +++ b/tools/testing/selftests/x86/test_shadow_stack.c
> > @@ -34,6 +34,7 @@
> >  #include <sys/ptrace.h>
> >  #include <sys/signal.h>
> >  #include <linux/elf.h>
> > +#include <linux/perf_event.h>
> >  
> >  /*
> >   * Define the ABI defines if needed, so people can run the tests
> > @@ -681,6 +682,141 @@ int test_32bit(void)
> >  	return !segv_triggered;
> >  }
> >  
> > +static int parse_uint_from_file(const char *file, const char *fmt)
> > +{
> > +	int err, ret;
> > +	FILE *f;
> > +
> > +	f = fopen(file, "re");
> > +	if (!f) {
> > +		err = -errno;
> > +		printf("failed to open '%s': %d\n", file, err);
> > +		return err;
> > +	}
> > +	err = fscanf(f, fmt, &ret);
> > +	if (err != 1) {
> > +		err = err == EOF ? -EIO : -errno;
> > +		printf("failed to parse '%s': %d\n", file, err);
> > +		fclose(f);
> > +		return err;
> > +	}
> > +	fclose(f);
> > +	return ret;
> > +}
> > +
> > +static int determine_uprobe_perf_type(void)
> > +{
> > +	const char *file = "/sys/bus/event_source/devices/uprobe/type";
> > +
> > +	return parse_uint_from_file(file, "%d\n");
> > +}
> > +
> > +static int determine_uprobe_retprobe_bit(void)
> > +{
> > +	const char *file = "/sys/bus/event_source/devices/uprobe/format/retprobe";
> > +
> > +	return parse_uint_from_file(file, "config:%d\n");
> > +}
> > +
> > +static ssize_t get_uprobe_offset(const void *addr)
> > +{
> > +	size_t start, end, base;
> > +	char buf[256];
> > +	bool found = false;
> > +	FILE *f;
> > +
> > +	f = fopen("/proc/self/maps", "r");
> > +	if (!f)
> > +		return -errno;
> > +
> > +	while (fscanf(f, "%zx-%zx %s %zx %*[^\n]\n", &start, &end, buf, &base) == 4) {
> > +		if (buf[2] == 'x' && (uintptr_t)addr >= start && (uintptr_t)addr < end) {
> > +			found = true;
> > +			break;
> > +		}
> > +	}
> > +
> > +	fclose(f);
> > +
> > +	if (!found)
> > +		return -ESRCH;
> > +
> > +	return (uintptr_t)addr - start + base;
> > +}
> > +
> > +static __attribute__((noinline)) void uretprobe_trigger(void)
> > +{
> > +	asm volatile ("");
> > +}
> > +
> > +/*
> > + * This test setups return uprobe, which is sensitive to shadow stack
> > + * (crashes without extra fix). After executing the uretprobe we fail
> > + * the test if we receive SIGSEGV, no crash means we're good.
> > + *
> > + * Helper functions above borrowed from bpf selftests.
> > + */
> > +static int test_uretprobe(void)
> > +{
> > +	const size_t attr_sz = sizeof(struct perf_event_attr);
> > +	const char *file = "/proc/self/exe";
> > +	int bit, fd = 0, type, err = 1;
> > +	struct perf_event_attr attr;
> > +	struct sigaction sa = {};
> > +	ssize_t offset;
> > +
> > +	type = determine_uprobe_perf_type();
> > +	if (type < 0)
> > +		return 1;
> > +
> > +	offset = get_uprobe_offset(uretprobe_trigger);
> > +	if (offset < 0)
> > +		return 1;
> > +
> > +	bit = determine_uprobe_retprobe_bit();
> > +	if (bit < 0)
> > +		return 1;
> > +
> > +	sa.sa_sigaction = segv_gp_handler;
> > +	sa.sa_flags = SA_SIGINFO;
> > +	if (sigaction(SIGSEGV, &sa, NULL))
> > +		return 1;
> > +
> > +	/* Setup return uprobe through perf event interface. */
> > +	memset(&attr, 0, attr_sz);
> > +	attr.size = attr_sz;
> > +	attr.type = type;
> > +	attr.config = 1 << bit;
> > +	attr.config1 = (__u64) (unsigned long) file;
> > +	attr.config2 = offset;
> > +
> > +	fd = syscall(__NR_perf_event_open, &attr, 0 /* pid */, -1 /* cpu */,
> > +		     -1 /* group_fd */, PERF_FLAG_FD_CLOEXEC);
> > +	if (fd < 0)
> > +		goto out;
> > +
> > +	if (sigsetjmp(jmp_buffer, 1))
> > +		goto out;
> > +
> > +	ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK);
> > +
> > +	/*
> > +	 * This either segfaults and goes through sigsetjmp above
> > +	 * or succeeds and we're good.
> > +	 */
> > +	uretprobe_trigger();
> > +
> > +	printf("[OK]\tUretprobe test\n");
> > +	err = 0;
> > +
> > +out:
> > +	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
> > +	signal(SIGSEGV, SIG_DFL);
> > +	if (fd)
> > +		close(fd);
> > +	return err;
> > +}
> > +
> >  void segv_handler_ptrace(int signum, siginfo_t *si, void *uc)
> >  {
> >  	/* The SSP adjustment caused a segfault. */
> > @@ -867,6 +1003,12 @@ int main(int argc, char *argv[])
> >  		goto out;
> >  	}
> >  
> > +	if (test_uretprobe()) {
> > +		ret = 1;
> > +		printf("[FAIL]\turetprobe test\n");
> > +		goto out;
> > +	}
> > +
> >  	return ret;
> >  
> >  out:
> > -- 
> > 2.44.0
> > 
> 
> 
> -- 
> Masami Hiramatsu (Google) <mhiramat@kernel.org>


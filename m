Return-Path: <bpf+bounces-49226-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DF46A156CA
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 19:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FCE8188BAD9
	for <lists+bpf@lfdr.de>; Fri, 17 Jan 2025 18:34:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 039981A76DA;
	Fri, 17 Jan 2025 18:34:23 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9AF1A255C;
	Fri, 17 Jan 2025 18:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737138862; cv=none; b=hjbCfhhb9/IbgMTWu87WhPKe3VAUg10aglWa7X0nurg2yiB6MDr2UPkJ6jDv0Of/OjTTfGI30ND4NTrVROu4CfKrbxFakdFCTdWU9dhDeyA5LJPhOA+iLX5k7UAXNOT0VGajTm42H+EYfp2lqnpX5LX0Llo4RpwTq6gOlkJHOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737138862; c=relaxed/simple;
	bh=xS5WmOuTnbaPAn2X3uOIWw49nxLanKIbBs8fvB3fIXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWHj8zHJf5TFOg4djwqn2leDKkANaC1cismlQ5p+2+zyE8lAUIwhu/0AovPZzUJ3nnb9s0vU1+XCfjoyBp9kNIiWuAe6IiRmKvULhvnAuonJWaxiHzSRpurvPfXlCnBh7XUAywTkCHW9sGb/5/d/BdApsmbf40ljuZIDRLZx2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=strace.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from mua.local.altlinux.org (mua.local.altlinux.org [192.168.1.14])
	by vmicros1.altlinux.org (Postfix) with ESMTP id DA6CF72C8CC;
	Fri, 17 Jan 2025 21:34:16 +0300 (MSK)
Received: by mua.local.altlinux.org (Postfix, from userid 508)
	id B02E67CCB3A; Fri, 17 Jan 2025 20:34:16 +0200 (IST)
Date: Fri, 17 Jan 2025 20:34:16 +0200
From: "Dmitry V. Levin" <ldv@strace.io>
To: Eyal Birger <eyal.birger@gmail.com>
Cc: kees@kernel.org, luto@amacapital.net, wad@chromium.org, oleg@redhat.com,
	mhiramat@kernel.org, andrii@kernel.org, jolsa@kernel.org,
	alexei.starovoitov@gmail.com, olsajiri@gmail.com, cyphar@cyphar.com,
	songliubraving@fb.com, yhs@fb.com, john.fastabend@gmail.com,
	peterz@infradead.org, tglx@linutronix.de, bp@alien8.de,
	daniel@iogearbox.net, ast@kernel.org, andrii.nakryiko@gmail.com,
	rostedt@goodmis.org, rafi@rbk.io, shmulik.ladkani@gmail.com,
	bpf@vger.kernel.org, linux-api@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] seccomp: passthrough uretprobe systemcall without
 filtering
Message-ID: <20250117183416.GA16831@strace.io>
References: <20250117005539.325887-1-eyal.birger@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117005539.325887-1-eyal.birger@gmail.com>

On Thu, Jan 16, 2025 at 04:55:39PM -0800, Eyal Birger wrote:
> When attaching uretprobes to processes running inside docker, the attached
> process is segfaulted when encountering the retprobe.
> 
> The reason is that now that uretprobe is a system call the default seccomp
> filters in docker block it as they only allow a specific set of known
> syscalls. This is true for other userspace applications which use seccomp
> to control their syscall surface.
> 
> Since uretprobe is a "kernel implementation detail" system call which is
> not used by userspace application code directly, it is impractical and
> there's very little point in forcing all userspace applications to
> explicitly allow it in order to avoid crashing tracked processes.
> 
> Pass this systemcall through seccomp without depending on configuration.
> 
> Fixes: ff474a78cef5 ("uprobe: Add uretprobe syscall to speed up return probe")
> Reported-by: Rafael Buchbinder <rafi@rbk.io>
> Link: https://lore.kernel.org/lkml/CAHsH6Gs3Eh8DFU0wq58c_LF8A4_+o6z456J7BidmcVY2AqOnHQ@mail.gmail.com/
> Cc: stable@vger.kernel.org
> Signed-off-by: Eyal Birger <eyal.birger@gmail.com>
> ---
> 
> The following reproduction script synthetically demonstrates the problem:
> 
> cat > /tmp/x.c << EOF
> 
> char *syscalls[] = {
> 	"write",
> 	"exit_group",
> 	"fstat",
> };
> 
> __attribute__((noinline)) int probed(void)
> {
> 	printf("Probed\n");
> 	return 1;
> }
> 
> void apply_seccomp_filter(char **syscalls, int num_syscalls)
> {
> 	scmp_filter_ctx ctx;
> 
> 	ctx = seccomp_init(SCMP_ACT_KILL);
> 	for (int i = 0; i < num_syscalls; i++) {
> 		seccomp_rule_add(ctx, SCMP_ACT_ALLOW,
> 				 seccomp_syscall_resolve_name(syscalls[i]), 0);
> 	}
> 	seccomp_load(ctx);
> 	seccomp_release(ctx);
> }
> 
> int main(int argc, char *argv[])
> {
> 	int num_syscalls = sizeof(syscalls) / sizeof(syscalls[0]);
> 
> 	apply_seccomp_filter(syscalls, num_syscalls);
> 
> 	probed();
> 
> 	return 0;
> }
> EOF
> 
> cat > /tmp/trace.bt << EOF
> uretprobe:/tmp/x:probed
> {
>     printf("ret=%d\n", retval);
> }
> EOF
> 
> gcc -o /tmp/x /tmp/x.c -lseccomp
> 
> /usr/bin/bpftrace /tmp/trace.bt &
> 
> sleep 5 # wait for uretprobe attach
> /tmp/x
> 
> pkill bpftrace
> 
> rm /tmp/x /tmp/x.c /tmp/trace.bt
> ---
>  kernel/seccomp.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/kernel/seccomp.c b/kernel/seccomp.c
> index 385d48293a5f..10a55c9b5c18 100644
> --- a/kernel/seccomp.c
> +++ b/kernel/seccomp.c
> @@ -1359,6 +1359,11 @@ int __secure_computing(const struct seccomp_data *sd)
>  	this_syscall = sd ? sd->nr :
>  		syscall_get_nr(current, current_pt_regs());
>  
> +#ifdef CONFIG_X86_64
> +	if (unlikely(this_syscall == __NR_uretprobe) && !in_ia32_syscall())
> +		return 0;
> +#endif
> +
>  	switch (mode) {
>  	case SECCOMP_MODE_STRICT:
>  		__secure_computing_strict(this_syscall);  /* may call do_exit */

This seems to be a hot fix to bypass some SECCOMP_RET_ERRNO filters.
However, this way it bypasses seccomp completely, including
SECCOMP_RET_TRACE, making it invisible to strace --seccomp,
and I wonder why do you want that.


-- 
ldv


Return-Path: <bpf+bounces-39800-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 348449777B1
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 06:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7F2D1F25ABA
	for <lists+bpf@lfdr.de>; Fri, 13 Sep 2024 04:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09AD91BC078;
	Fri, 13 Sep 2024 04:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="llfz4tNJ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878FB2F34
	for <bpf@vger.kernel.org>; Fri, 13 Sep 2024 04:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726200141; cv=none; b=oljuJIWXKjQmUKpt3EaqJ+kaRQiMcc6fHhPsPyfmhkI2dZzbxEUNBHYhw2NxQlqv6fXyHw5GVOZTeXLbCSkHT6Bi+yqUHgYtGdSC9TwzehEGwR06fBpt34eWNecc8HuiaORJQmaWSZbllKO3nbKPaulK1YTUl9zdyBF3D/O+QGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726200141; c=relaxed/simple;
	bh=KG64Enq3Sjp8Wm8hrBEwM4ynLJO1JVCZYx5kkVVwJXU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=gizE857RD61XqGICwHo2+42XD8iFlqYlFi5yYJM2ixkWJjumKvHLN8/Kvf8okCotmnZR8okpksu1FtWzk1orQPfHtYsbWJnlAuw10q4Yx/jpIEV0e2sE0E9lBBPuy7U/JGvsZ8cmwpwckOum2QoZ2dDTj6TaoIV0mjFX5vr8tmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=llfz4tNJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BC8CC4CEC0;
	Fri, 13 Sep 2024 04:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726200141;
	bh=KG64Enq3Sjp8Wm8hrBEwM4ynLJO1JVCZYx5kkVVwJXU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=llfz4tNJKSJjP/mJwcgM0RkhXHeu2gxeWd/CmqVF7ZkQNoeOnCoCR1fs4rHxPXlcR
	 0E0PoYzOQK1YT1lLBDCURrcRjkUWeXQ3lFhrNHI9qizJx9CfwsUOgem8mdEBAyM78A
	 t9kAdEFhhfi5N2KQPWVutZIa/lDpgBElcfHyneLsTCAVM6wMuj9hLLIZkQLtQTMsM1
	 BfA4AM781STOKv3/C3COEh3QoprykD85KYm5u73lo1rmDaRoC9LTBrE3H/JzJZGBxc
	 1W1gRFhvlVsw0SDR3YCt3o/o9ut3KhXQpIpC2APC98AQzg4rw/Cbf0AQB/ooTc8iDR
	 fUTQtzlhQP1XA==
Date: Fri, 13 Sep 2024 13:02:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Xu <dlxu@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>, kernel-ci
 <kernel-ci@meta.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v13 00/20] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240913130216.fe4eab850bb5a9396b661b1a@kernel.org>
In-Reply-To: <CAEf4BzaTn=thAkznx3UHyevgtTQG=hGfW54EWDGR8PHyQk91WA@mail.gmail.com>
References: <172398527264.293426.2050093948411376857.stgit@devnote2>
	<2b4d25f8fa99ae5a329f5164b6c79b81f1a4cc78688dcf5470d601f3612264ea@mail.kernel.org>
	<20240819095807.171eade07ba02ae871e4c4aa@kernel.org>
	<MN2PR15MB34883ABBB55D78B4E15758EDAD8C2@MN2PR15MB3488.namprd15.prod.outlook.com>
	<20240820101727.3631125acf3c98c7bc7050db@kernel.org>
	<CAEf4BzaTn=thAkznx3UHyevgtTQG=hGfW54EWDGR8PHyQk91WA@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On Mon, 19 Aug 2024 19:48:23 -0700
Andrii Nakryiko <andrii.nakryiko@gmail.com> wrote:

> +bpf
> 
> On Mon, Aug 19, 2024 at 6:17 PM Masami Hiramatsu <mhiramat@kernel.org> wrote:
> >
> > On Mon, 19 Aug 2024 15:56:39 +0000
> > Daniel Xu <dlxu@meta.com> wrote:
> >
> > > [sorry for outlook top post]
> > >
> > > Hi Masami,
> > >
> > > test_progs is checked into kernel tree. There should be source files in selftests
> > > for the test names. For example, for fill_link_info/kprobe_multi_invalid_ubuff
> > > failure:
> > >
> > > $ find . -name "*fill_link_info*"
> > > ./tools/testing/selftests/bpf/prog_tests/fill_link_info.c
> > > ./tools/testing/selftests/bpf/progs/test_fill_link_info.c
> > >
> > > veristat I'm less famiiar with. My understanding is that it checks for verifier
> > > regressions. Skimming your patchset, it's not obvious to me why verifier
> > > would regress. If you have issues debugging that, we can poke Andrii for
> > > help.
> >
> > Thanks for the information! Hmm, maybe kprobe_multi_testmod_check might check the
> > register which is not supported on the ftrace_regs. But I also don't have any idea
> 
> This test is getting IP of the function using bpf_get_func_ip()
> helper. If that somehow started returning wrong value on arm64/s390x,
> then the test will basically not find expected addresses

Ah, I got a clue. For the kprobe_multi (fprobe) uses bpf_kprobe_multi_cookie()
to get func_ip, it is implemented as below;

static u64 bpf_kprobe_multi_cookie(struct bpf_run_ctx *ctx)
{
	struct bpf_kprobe_multi_run_ctx *run_ctx;
	struct bpf_kprobe_multi_link *link;
	u64 *cookie, entry_ip;
	unsigned long *addr;

	if (WARN_ON_ONCE(!ctx))
		return 0;
	run_ctx = container_of(current->bpf_ctx, struct bpf_kprobe_multi_run_ctx,
			       session_ctx.run_ctx);
	link = run_ctx->link;
	if (!link->cookies)
		return 0;
	entry_ip = run_ctx->entry_ip;
	addr = bsearch(&entry_ip, link->addrs, link->cnt, sizeof(entry_ip),
		       bpf_kprobe_multi_addrs_cmp);
	if (!addr)
		return 0;
	cookie = link->cookies + (addr - link->addrs);
	return *cookie;
}

The problem is that the `run_ctx->entry_ip` may not be a real function entry
but the ftrace entry address, which is not the same address of the function
entry on MANY architectures. X86 uses -fentry and it is able to call another
function from the first instruction, but Even on x86, IBT can change it, so
it is fixed by get_entry_ip().

On other architectures, usually they need to prepare ftrace stub call by

 - saving return address to the frame pointer or stack
 - set ftrace stub address to a register (optional?)
 - call ftrace stub.

Thus the ftrace's entry_ip is a bit shift by some instruction size.
To solve this issue, 

To solve this problem, I think we can fix it by modifying
bpf_kprobe_multi_addrs_cmp().

static int bpf_kprobe_multi_addrs_cmp(const void *a, const void *b)
{
	const unsigned long *addr_a = a, *addr_b = b;

	if (*addr_a >= *addr_b && *addr_a < *addr_b + SOME_OFFSET)
		return 0;
	return *addr_a < *addr_b ? -1 : 1;
}

SOME_OFFSET depends on architecture implmentation. E.g. arm64 is 4 or 
8 (if BTI is enabled).


Thank you,


> 
> > about veristat. Is that also checks all pt_regs? Andrii, do you have any idea?
> 
> I wouldn't worry about veristat, your changes shouldn't regress BPF
> verifier logic, so it's probably just an artifact of our BPF CI setup.
> The above test regression seems much more worrying.
> 
> 
> >
> > Thank you,
> >
> > >
> > > Thanks,
> > > Daniel
> > >
> > >
> > > ________________________________
> > > From: Masami Hiramatsu <mhiramat@kernel.org>
> > > Sent: Sunday, August 18, 2024 5:58 PM
> > > To: bot+bpf-ci@kernel.org <bot+bpf-ci@kernel.org>
> > > Cc: kernel-ci <kernel-ci@meta.com>; andrii@kernel.org <andrii@kernel.org>; daniel@iogearbox.net <daniel@iogearbox.net>; martin.lau@linux.dev <martin.lau@linux.dev>
> > > Subject: Re: [PATCH v13 00/20] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
> > >
> > > Hi,
> > >
> > > Where can I get the test programs? I would like to check what the programs
> > > actually expected.
> > >
> > > On Sun, 18 Aug 2024 13:51:30 +0000 (UTC)
> > > bot+bpf-ci@kernel.org wrote:
> > >
> > > > Dear patch submitter,
> > > >
> > > > CI has tested the following submission:
> > > > Status:     FAILURE
> > > > Name:       [v13,00/20] tracing: fprobe: function_graph: Multi-function graph and fprobe on fgraph
> > > > Patchwork:  https://patchwork.kernel.org/project/netdevbpf/list/?series=880630&state=*
> > > > Matrix:     https://github.com/kernel-patches/bpf/actions/runs/10440799833
> > > >
> > > > Failed jobs:
> > > > test_progs-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10440799833/job/28911439106
> > > > test_progs_no_alu32-aarch64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10440799833/job/28911439234
> > > > test_progs-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10440799833/job/28911405063
> > > > test_progs_no_alu32-s390x-gcc: https://github.com/kernel-patches/bpf/actions/runs/10440799833/job/28911404959
> > > > veristat-x86_64-gcc: https://github.com/kernel-patches/bpf/actions/runs/10440799833/job/28911401263
> > > >
> > > > First test_progs failure (test_progs-aarch64-gcc):
> > > > #126 kprobe_multi_testmod_test
> > > > serial_test_kprobe_multi_testmod_test:PASS:load_kallsyms_local 0 nsec
> > > > #126/1 kprobe_multi_testmod_test/testmod_attach_api_syms
> > > > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > > > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > > > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe_test1_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe_test2_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe_test3_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kretprobe_test1_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kretprobe_test2_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretprobe_test3_result: actual 0 != expected 1
> > > > #126/2 kprobe_multi_testmod_test/testmod_attach_api_addrs
> > > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > > test_testmod_attach_api_addrs:PASS:ksym_get_addr_local 0 nsec
> > > > test_testmod_attach_api:PASS:fentry_raw_skel_load 0 nsec
> > > > trigger_module_test_read:PASS:testmod_file_open 0 nsec
> > > > test_testmod_attach_api:PASS:trigger_read 0 nsec
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test1_result unexpected kprobe_test1_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test2_result unexpected kprobe_test2_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kprobe_test3_result unexpected kprobe_test3_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test1_result unexpected kretprobe_test1_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test2_result unexpected kretprobe_test2_result: actual 0 != expected 1
> > > > kprobe_multi_testmod_check:FAIL:kretprobe_test3_result unexpected kretprobe_test3_result: actual 0 != expected 1
> > > >
> > > >
> > > > Please note: this email is coming from an unmonitored mailbox. If you have
> > > > questions or feedback, please reach out to the Meta Kernel CI team at
> > > > kernel-ci@meta.com.
> > >
> > >
> > > --
> > > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> >
> >
> > --
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


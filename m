Return-Path: <bpf+bounces-39617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69510975610
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 16:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29753286BA0
	for <lists+bpf@lfdr.de>; Wed, 11 Sep 2024 14:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049F3187FEB;
	Wed, 11 Sep 2024 14:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q5/g+Bx2"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8390B8F6C
	for <bpf@vger.kernel.org>; Wed, 11 Sep 2024 14:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726066321; cv=none; b=CzQ51+up4ZtgLkv9VMZ9jA4RnhSYQs6bhmRjNjXfC+AOQoeiA7hWmCm6pHGujV8Qg8Q+F7EeJy8dfEh/ub57LxTnyCVQWDIoNdlbLXlty5GH8RZHS4VizSxVRSAdKxBfyBqH++VGwHTNzbOair80WuD4Czk8d2IYC0edEDr6qMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726066321; c=relaxed/simple;
	bh=K8ChxVpV0Fh2LTxYbIo+ulW9aqVBzAGGLCXbXQfBpQU=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CXXDUsxMVcXFsQj1HTUlVv2CYsWbXxxaf2Rl5Efk/WkU85fHZ77L427ZNzkJOjMIsjt2wAxJG/OSxUxdNrqdt+tKTcEu28ouWqrSomyH9PRnUXu9xppMJPnQdlUtFB+5jjtUeYvFYBrz/TOLKvPcMqTxJgxFJvKZWTGVdGd8H+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q5/g+Bx2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7DDEC4CEC0;
	Wed, 11 Sep 2024 14:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726066321;
	bh=K8ChxVpV0Fh2LTxYbIo+ulW9aqVBzAGGLCXbXQfBpQU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q5/g+Bx2fwtHXKtaiTggZBMxE94TcSpNN4SINTeIU0d/aYrYK2yY4Rd/4RoIkwYsm
	 MarATmdDcZjj+yIs8wfFn0MSAmWz8PSRWAvxgoAYVuy0kuvBJ+32bbAvLSPkXbzv83
	 4zC0HLUQh7aJkf+yyQEyGtoeYqX9WJ79/ekjtBt3YzmVZLt1LsWwUApWc0KlHx/Y2P
	 G22m4WUnoOzp9AqDaGzEiOdJbq+ksZ9VDC4H1slLw8bOvixxB2aKMYnXX7kDxUUrAu
	 aYfxcT9TyYEltqasR0LPsfFW3fzNS0uio/fk+8KZc44r5uzNCFuIlWlqFkEh18Uu2i
	 o8XHMy0gQO5gg==
Date: Wed, 11 Sep 2024 23:51:56 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Daniel Xu <dlxu@meta.com>, Andrii Nakryiko <andrii@kernel.org>,
 "bot+bpf-ci@kernel.org" <bot+bpf-ci@kernel.org>, kernel-ci
 <kernel-ci@meta.com>, "daniel@iogearbox.net" <daniel@iogearbox.net>,
 "martin.lau@linux.dev" <martin.lau@linux.dev>, bpf <bpf@vger.kernel.org>
Subject: Re: [PATCH v13 00/20] tracing: fprobe: function_graph:
 Multi-function graph and fprobe on fgraph
Message-Id: <20240911235156.4673a9c90494dbf10eb9cccd@kernel.org>
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

Ah, bpf_get_func_ip() may get PC register in pt_regs. ftrace_regs doesn't
have it. Hmm, but that information should be injected by bpf side because 
ftrace_regs -> pt_regs converted in trace_bpf, and the handler should know
the IP.

> 
> > about veristat. Is that also checks all pt_regs? Andrii, do you have any idea?
> 
> I wouldn't worry about veristat, your changes shouldn't regress BPF
> verifier logic, so it's probably just an artifact of our BPF CI setup.
> The above test regression seems much more worrying.

OK, trying to fix that. Maybe [07/20] caused this issue.

Thank you,

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


Return-Path: <bpf+bounces-5933-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D943763483
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 13:07:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 443FA2810A0
	for <lists+bpf@lfdr.de>; Wed, 26 Jul 2023 11:07:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78463CA74;
	Wed, 26 Jul 2023 11:07:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E4488473
	for <bpf@vger.kernel.org>; Wed, 26 Jul 2023 11:07:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D114C433C8;
	Wed, 26 Jul 2023 11:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690369641;
	bh=2ZjqU2SvWPSSpM/cKym1SBR+BCpIZZa3jkBYRwT0m4o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=smiSuUOBnVh2z0aT789eXdEsV4J1QVY965uEYhlSup9kDc1zZPdm6vZySV4il18Qn
	 vxHE3MXax938YgwSKhxOyagd3aLHQoDaC4vOL+9r+FV8Yru0pos7x2B/VULKb7l5HW
	 7WXINSD+mozTnIsq4qN6nrpeGJDunJ1XhtwWvnHaV0OWdHaQKKCvyzVJULA8uxs6nb
	 llYhIF8wod6nz5SaniijfSgTFIAmST+9NMbR0IEvIyPnI7yhfiU+or3te9ugnqHb/U
	 gqYRVCoE5QEDwQHN2CGTi2BlyIHeAFsDImShuWoGsJRFQTX63d9Oto4gBdSbMBqDJl
	 cKanqgBkDXC9g==
Date: Wed, 26 Jul 2023 20:07:16 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>, Yonghong Song <yhs@fb.com>,
 dwarves@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
 <rostedt@goodmis.org>
Subject: Re: [RESEND] BTF is not generated for gcc-built kernel with the
 latest pahole
Message-Id: <20230726200716.609d8433a7292eead95e7330@kernel.org>
In-Reply-To: <ZMDvmLdZSLi2QqB+@krava>
References: <20230726102534.9ebc4678ad2c9395cc9be196@kernel.org>
	<ZMDvmLdZSLi2QqB+@krava>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Jiri,

On Wed, 26 Jul 2023 12:04:08 +0200
Jiri Olsa <olsajiri@gmail.com> wrote:

> On Wed, Jul 26, 2023 at 10:25:34AM +0900, Masami Hiramatsu wrote:
> > Hello,
> > (I resend this because kconfig was too big)
> > 
> > I found that BTF is not generated for gcc-built kernel with that latest
> > pahole (v1.25).
> 
> hi,
> I can't reproduce on my setup with your .config
> 
> does 'bpftool btf dump file ./vmlinux' show any error?
> 
> is there any error in the kernel build output?

Yes, here it is. I saw these 2 lines.

die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!
die__process: DW_TAG_compile_unit, DW_TAG_type_unit, DW_TAG_partial_unit or DW_TAG_skeleton_unit expected got INVALID (0x0)!

> 
> > When I'm using the distro origin pahole (v1.22) it works. (I also checked
> > v1.23 and v1.24, both partially generated BTF)
> > 
> > e.g.
> > 
> > # echo 'f kfree $arg*' >> /sys/kernel/tracing/dynamic_events
> > sh: write error: Invalid argument
> > 
> > # cat /sys/kernel/tracing/error_log 
> > [   21.595724] trace_fprobe: error: BTF is not available or not supported
> >   Command: f kfree $arg*
> >                    ^
> > [   21.596032] trace_fprobe: error: Invalid $-valiable specified
> >   Command: f kfree $arg*
> >                    ^
> > 
> > / # strings /sys/kernel/btf/vmlinux | grep kfree
> 
> hm, if you have this file present, you have BTF in

Yes, it seems that the BTF itself is generated, but many entries seems
dropped compared with pahole v1.22. So, if a given symbol has BTF, (e.g. 
kfree_rcu_batch_init) it works.

> 
> > kfree_on_online
> > maybe_kfree_parameter
> > trace_event_raw_rcu_invoke_kfree_bulk_callback
> > trace_event_data_offsets_rcu_invoke_kfree_bulk_callback
> > btf_trace_rcu_invoke_kfree_bulk_callback
> > early_boot_kfree_rcu
> > __bpf_trace_rcu_invoke_kfree_bulk_callback
> > perf_trace_rcu_invoke_kfree_bulk_callback
> > trace_event_raw_event_rcu_invoke_kfree_bulk_callback
> > trace_raw_output_rcu_invoke_kfree_bulk_callback
> > __probestub_rcu_invoke_kfree_bulk_callback
> > __traceiter_rcu_invoke_kfree_bulk_callback
> > kfree_rcu_cpu_work
> > kfree_rcu_cpu
> > kfree_rcu_batch_init
> > kfree_rcu_scheduler_running
> > kfree_rcu_shrink_scan
> > kfree_rcu_shrink_count
> > kfree_rcu_monitor
> > kfree_rcu_work
> > 
> > 
> > Here is the gcc version which I'm using.
> > 
> > gcc version 11.3.0 (Ubuntu 11.3.0-1ubuntu1~22.04.1)
> 
> I tried with gcc (GCC) 13.1.1 20230614 (Red Hat 13.1.1-4)
> and latest pahole (master branch)

Curiously, with Clang 16.0.0, it works (but many different errors are shown,
see below *).
So the combination of gcc/clang and pahole version can affect it.

> 
> > 
> > I also attached the kernel config file.
> > 
> > What is the recommended combination of the tools?
> > Should I use Clang to build the kernel for BTF?
> 
> should work fine with both gcc and clang

And I guess it depends on compiler version, doesn't it?

Thank you,


(*)
  BTF     .btf.vmlinux.bin.o
die__process_unit: DW_TAG_label (0xa) @ <0x4b138> not handled!
die__process_unit: tag not supported 0xa (label)!
die__process_unit: DW_TAG_label (0xa) @ <0x4b241> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b263> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b290> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b2c0> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b2eb> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b317> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b33a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b35a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b37d> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b39e> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b3c4> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b3e7> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b40f> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b435> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b457> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b477> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b4a5> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b4d5> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b505> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b530> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b560> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b585> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b5b2> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b5d9> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b605> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b62e> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b652> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b670> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b694> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b6b3> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b6d9> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b705> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b72b> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b753> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b77f> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b7b3> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b7e4> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b811> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b83c> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b869> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b88c> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b8bd> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b8e7> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b90b> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b930> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b960> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b997> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4b9ce> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4ba00> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4ba24> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4ba4d> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4ba89> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4babc> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bae4> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bb0b> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bb2e> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bb4e> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bb6d> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bb8a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bba8> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bbc5> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bbe1> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bc01> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bc1c> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bc38> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bc58> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bc79> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bc95> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4bcb2> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7efd6> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7effe> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7f11c> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7f143> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7f178> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7f1a4> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7f1ca> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7f1fb> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7f22f> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7f25a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7f28d> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x7f2b7> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x1eea81> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x1eea9d> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x1eeac3> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x1eeaf3> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x1eeb0f> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x1eeb30> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x1eeb59> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x340734> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6b4a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6b67> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6b8a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6ba5> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6bc4> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6bea> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6c07> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6c2a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6c4e> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6c79> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6c9b> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6cc3> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6ceb> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x4c6d15> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x30626ac> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x30626cd> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x3062814> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x3062833> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x3062b8b> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f623f6> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f62416> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f62437> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f62458> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f6280b> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f62b09> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f62b37> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f62c45> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f62c60> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f62d69> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f62e8d> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f6305a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f63ec2> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f63edf> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f63efc> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f63f19> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f63f36> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f63f5b> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f63f80> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f63fa5> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f63fca> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f6fcae> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f6fcc7> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f6fed7> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f6fef0> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f6fdcb> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70352> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f7036f> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70394> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f703b1> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f703d6> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f703f3> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70418> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70435> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f7045a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f7057b> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f705a6> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f705cf> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f705f8> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70621> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f7064a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70673> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f7069c> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f706c5> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f706ee> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70716> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f7073e> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70767> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70790> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f707b9> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f707e2> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f7080b> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70834> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70864> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70892> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f708c0> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f708ee> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f7091c> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f7094a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70978> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f709a6> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f709d4> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70a01> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70a2e> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70a5c> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70a8a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70ab8> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70ae6> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70b14> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70b42> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70b72> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70ba0> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70bce> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70bfc> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70c2a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70c58> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70c86> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70cb4> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70ce2> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70d0f> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70d3c> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70d6a> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70d98> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70dc6> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70df4> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70e22> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70e50> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70e71> not handled!
die__process_unit: DW_TAG_label (0xa) @ <0x5f70e94> not handled!
  LD      .tmp_vmlinux.kallsyms1

> 
> jirka
> 
> > 
> > Thank you,
> > 
> > -- 
> > Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>


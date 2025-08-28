Return-Path: <bpf+bounces-66824-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63945B39CD8
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 14:19:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 88BA1203362
	for <lists+bpf@lfdr.de>; Thu, 28 Aug 2025 12:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBA43101A6;
	Thu, 28 Aug 2025 12:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BWYdf8EZ"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C2B26C39F
	for <bpf@vger.kernel.org>; Thu, 28 Aug 2025 12:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383218; cv=none; b=RZUkWj9QWdiJ4y4Llr0vyMUhnDsbef8zbib6sCFQ8mWfdQleOB6ltzMBQ6f8g+LgMqkjGn/BExnze0yN0hbVQQmG0mMD1yRr6Hogb0gFufN4F1Loi7egdRYt4JYct22Jc24KEOtq9esrv0NeL5ATn+i1xeq0VP2d9UjUvVadzXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383218; c=relaxed/simple;
	bh=q0FV+3Zok2bgeipOX1Po8jn60WTikHnR7jPS+kE4oCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f0Okf9sDlQlOB9PriU+ryPu33WyJwiMKRJIsc4sG467xU9G/DTCrnf4hS+RF9FsJsufjtao9z2h9KqLllsNNJ/7BaU9fVO728Ba1y8pbF0T6CWutMuTpAUMZD+8L3jxI5NU4/twzUlDA7vXs4m4viVBk37wWt6C4iXeLehP5a70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BWYdf8EZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C9FC4CEEB;
	Thu, 28 Aug 2025 12:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756383218;
	bh=q0FV+3Zok2bgeipOX1Po8jn60WTikHnR7jPS+kE4oCI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=BWYdf8EZI06pckK7GTtIlXJ253mU2UVOCRnztS87+gUXqUmzrZQnFzTYDHvjp3FXS
	 kzNYAgdE/HgXW3QosU3vJMsxxvkjUMyOCo0dp7qV3tHEuBMo3wO8zueiKYPwH1dR3+
	 E01Ug9fbaYUr6j5/dB6KS5vEdXDZTOjaOwNTruQkybsOkw5Hz6MtYQOLlQEsMJerxb
	 ahAaHuIrCr3aOoLmzNNjd7MdKOaih8q3kV5bZiFwygsZqwVON77oEW9kgrMqOnp63S
	 YrybC2+Wc/DOjv7Dmu0AQW6xK98pyOU6twE2fPyJGAgel3AuhqySHVSLzEszamdjNc
	 ShgBuB3RsJu5Q==
From: Puranjay Mohan <puranjay@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>, Xu Kuohai
 <xukuohai@huaweicloud.com>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
 <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, Martin KaFai
 Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu
 <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
 <will@kernel.org>, bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next v4 0/3] bpf: Report arena faults to BPF streams
In-Reply-To: <CAP01T77PGbpEEmGyCqKSy-+Zb18+dfWH=8ujEQFBDKEOca3Mjg@mail.gmail.com>
References: <20250827153728.28115-1-puranjay@kernel.org>
 <CAP01T77PGbpEEmGyCqKSy-+Zb18+dfWH=8ujEQFBDKEOca3Mjg@mail.gmail.com>
Date: Thu, 28 Aug 2025 12:13:34 +0000
Message-ID: <mb61ph5xrmyoh.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Wed, 27 Aug 2025 at 17:37, Puranjay Mohan <puranjay@kernel.org> wrote:
>>
>> Changes in v3->v4:
>> v3: https://lore.kernel.org/all/20250827150113.15763-1-puranjay@kernel.org/
>> - Fixed a build issue when CONFIG_BPF_JIT=y and # CONFIG_BPF_SYSCALL is not set
>>
>> Changes in v2->v3:
>> v2: https://lore.kernel.org/all/20250811111828.13836-1-puranjay@kernel.org/
>> - Improved the selftest to check the exact fault address
>> - Dropped BPF_NO_KFUNC_PROTOTYPES and bpf_arena_alloc/free_pages() usage
>> - Rebased on bpf-next/master
>>
>> Changes in v1->v2:
>> v1: https://lore.kernel.org/all/20250806085847.18633-1-puranjay@kernel.org/
>> - Changed variable and mask names for consistency (Yonghong)
>> - Added Acked-by: Yonghong Song <yonghong.song@linux.dev> on two patches
>>
>> This set adds the support of reporting page faults inside arena to BPF
>> stderr stream. The reported address is the one that a user would expect
>> to see if they pass it to bpf_printk();
>>
>> Here is an example output from a stream and bpf_printk()
>>
>> ERROR: Arena WRITE access at unmapped address 0xdeaddead0000
>> CPU: 9 UID: 0 PID: 502 Comm: test_progs
>> Call trace:
>> bpf_stream_stage_dump_stack+0xc0/0x150
>> bpf_prog_report_arena_violation+0x98/0xf0
>> ex_handler_bpf+0x5c/0x78
>> fixup_exception+0xf8/0x160
>> __do_kernel_fault+0x40/0x188
>> do_bad_area+0x70/0x88
>> do_translation_fault+0x54/0x98
>> do_mem_abort+0x4c/0xa8
>> el1_abort+0x44/0x70
>> el1h_64_sync_handler+0x50/0x108
>> el1h_64_sync+0x6c/0x70
>> bpf_prog_a64a9778d31b8e88_stream_arena_write_fault+0x84/0xc8
>>   *(page) = 1; @ stream.c:100
>> bpf_prog_test_run_syscall+0x100/0x328
>> __sys_bpf+0x508/0xb98
>> __arm64_sys_bpf+0x2c/0x48
>> invoke_syscall+0x50/0x120
>> el0_svc_common.constprop.0+0x48/0xf8
>> do_el0_svc+0x28/0x40
>> el0_svc+0x48/0xf8
>> el0t_64_sync_handler+0xa0/0xe8
>> el0t_64_sync+0x198/0x1a0
>>
>> Same address is seen by using bpf_printk():
>>
>> 1389.078831: bpf_trace_printk: Read Address: 0xdeaddead0000
>>
>> To make this possible, some extra metadata has to be passed to the bpf
>> exception handler, so the bpf exception handling mechanism for both
>> x86-64 and arm64 have been improved in this set.
>>
>> The streams selftest has been updated to also test this new feature.
>
> We also need arm64 experts to take a look before we land, since you'll
> respin anyway now.
> Xu, could you please provide acks on the patches?
>
> Thanks a lot.

Thanks for your review.
I will wait for Xu's feedback before respining.

Thanks,
Puranjay


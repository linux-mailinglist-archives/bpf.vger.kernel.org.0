Return-Path: <bpf+bounces-65325-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DF5B205AC
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 12:36:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947C218A28DC
	for <lists+bpf@lfdr.de>; Mon, 11 Aug 2025 10:36:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ECD423D28C;
	Mon, 11 Aug 2025 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N+ahWQA9"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB98022FF2D
	for <bpf@vger.kernel.org>; Mon, 11 Aug 2025 10:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754908525; cv=none; b=N6BiBn9EXOrrZLghKAtWk0buUd0l7g5cGRGPoDijIWD7+a1U9v2RJQ3JchjVxIhgsWdFlfuPvG2BxuOaCQ7MJQnA0QI5Ge/HgLBzZOUDPDTXVexrIZz4lJK/PqEj7lxFsqGGoenKieankiZWtcOa840BRAKcuG9ixlaCViOcrPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754908525; c=relaxed/simple;
	bh=SuR7DERz5cc0fup7C69DSR9yioKTfUcvpBupozYeX30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EE6eWi+1FSmWtzAPNp6joHR41CxbPzZWmJHYuPHr+16OIKguRoHbSumZxfN0DHGQ7S6jEp0Kl/qDgXSaw4xG9lYcaiWQZjeifma70R8+tHj8F7dP0f5Qm2rRqJKj9lG4S71MkgU+x+knUd5H6A0s+knhNIEtvDlVg/7oFFNibXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N+ahWQA9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F40A2C4CEED;
	Mon, 11 Aug 2025 10:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754908525;
	bh=SuR7DERz5cc0fup7C69DSR9yioKTfUcvpBupozYeX30=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=N+ahWQA9HHpn1bF8AZ2B2wtbfYUc182yEuL9m94FrjUQTP79Pc1Ux62KqiI5jk17a
	 fpl/q1a+NViEqQ3rW0ruYLfjgRdqSSKAQEctc0dDC/u6RcoY4IMYwUFa4ZmqSKKtId
	 W3noZskxeYgDqXbMa4Ier4sY0VAG7oVdMf7RC8LeE/hVEGQZsULPh0l0NPwcxuS2jk
	 MG6EFKP0Xl2ONKHqPKvRk++h/pbK3cDEbJn+j8MU54pnialQFbRBwrxj4ZE74Z/Vg4
	 OA8TGTJ08w0A46TIax66rW+2Hra4CDKAUVPkLjt/PCzkO8oZVvSh0x42z10JQ889T8
	 g8V+SZNP51ZnQ==
From: Puranjay Mohan <puranjay@kernel.org>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, Alexei Starovoitov
 <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko
 <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, Eduard
 Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, John Fastabend
 <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, Stanislav
 Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, Jiri Olsa
 <jolsa@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 bpf@vger.kernel.org
Subject: Re: [PATCH bpf-next 3/3] selftests/bpf: Add tests for arena fault
 reporting
In-Reply-To: <CAP01T75_WiqLmJE7x==wagJTMfg2BoZkv6otexA6FGm-=UFXew@mail.gmail.com>
References: <20250806085847.18633-1-puranjay@kernel.org>
 <20250806085847.18633-4-puranjay@kernel.org>
 <34ce4521-6dac-4f78-a049-e6bc928cbd28@linux.dev>
 <mb61ph5yjgt77.fsf@kernel.org>
 <CAP01T75_WiqLmJE7x==wagJTMfg2BoZkv6otexA6FGm-=UFXew@mail.gmail.com>
Date: Mon, 11 Aug 2025 10:35:21 +0000
Message-ID: <mb61pjz3a16za.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kumar Kartikeya Dwivedi <memxor@gmail.com> writes:

> On Thu, 7 Aug 2025 at 15:25, <puranjay@kernel.org> wrote:
>>
>> Yonghong Song <yonghong.song@linux.dev> writes:
>>
>> > On 8/6/25 1:58 AM, Puranjay Mohan wrote:
>> >> Add selftests for testing the reporting of arena page faults through BPF
>> >> streams. Two new bpf programs are added that read and write to an
>> >> unmapped arena address and the fault reporting is verified in the
>> >> userspace through streams.
>> >>
>> >> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>
>> >> ---
>> >>   .../testing/selftests/bpf/prog_tests/stream.c | 24 ++++++++++++
>> >>   tools/testing/selftests/bpf/progs/stream.c    | 37 +++++++++++++++++++
>> >>   2 files changed, 61 insertions(+)
>> >>
>> >> diff --git a/tools/testing/selftests/bpf/prog_tests/stream.c b/tools/testing/selftests/bpf/prog_tests/stream.c
>> >> index d9f0185dca61b..4bdde56de35b1 100644
>> >> --- a/tools/testing/selftests/bpf/prog_tests/stream.c
>> >> +++ b/tools/testing/selftests/bpf/prog_tests/stream.c
>> >> @@ -41,6 +41,22 @@ struct {
>> >>              "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>> >>              "|[ \t]+[^\n]+\n)*",
>> >>      },
>> >> +    {
>> >> +            offsetof(struct stream, progs.stream_arena_read_fault),
>> >> +            "ERROR: Arena READ access at unmapped address 0x.*\n"
>> >> +            "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
>> >> +            "Call trace:\n"
>> >> +            "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>> >> +            "|[ \t]+[^\n]+\n)*",
>> >> +    },
>> >> +    {
>> >> +            offsetof(struct stream, progs.stream_arena_write_fault),
>> >> +            "ERROR: Arena WRITE access at unmapped address 0x.*\n"
>> >> +            "CPU: [0-9]+ UID: 0 PID: [0-9]+ Comm: .*\n"
>> >> +            "Call trace:\n"
>> >> +            "([a-zA-Z_][a-zA-Z0-9_]*\\+0x[0-9a-fA-F]+/0x[0-9a-fA-F]+\n"
>> >> +            "|[ \t]+[^\n]+\n)*",
>> >> +    },
>> >>   };
>> >>
>> >>   static int match_regex(const char *pattern, const char *string)
>> >> @@ -85,6 +101,14 @@ void test_stream_errors(void)
>> >>                      continue;
>> >>              }
>> >>   #endif
>> >> +#if !defined(__x86_64__) && !defined(__aarch64__)
>> >> +            ASSERT_TRUE(1, "Arena fault reporting unsupported, skip.");
>> >> +            if (i == 2 || i == 3) {
>> >> +                    ret = bpf_prog_stream_read(prog_fd, 2, buf, sizeof(buf), &ropts);
>> >> +                    ASSERT_EQ(ret, 0, "stream read");
>> >> +                    continue;
>> >> +            }
>> >> +#endif
>> >>
>> >>              ret = bpf_prog_stream_read(prog_fd, BPF_STREAM_STDERR, buf, sizeof(buf), &ropts);
>> >>              ASSERT_GT(ret, 0, "stream read");
>> >> diff --git a/tools/testing/selftests/bpf/progs/stream.c b/tools/testing/selftests/bpf/progs/stream.c
>> >> index 35790897dc879..58ebff60cd96a 100644
>> >> --- a/tools/testing/selftests/bpf/progs/stream.c
>> >> +++ b/tools/testing/selftests/bpf/progs/stream.c
>> >> @@ -1,10 +1,15 @@
>> >>   // SPDX-License-Identifier: GPL-2.0
>> >>   /* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
>> >> +#define BPF_NO_KFUNC_PROTOTYPES
>> >
>> > Do we have to defineBPF_NO_KFUNC_PROTOTYPES in the above? Without the above, we do not need
>> > below extern bpf_res_spin_lock and bpf_res_spin_unlock.
>> >
>>
>> If we don't define BPF_NO_KFUNC_PROTOTYPES then there are build failures
>> for bpf_arena_alloc/free_pages() because the prototypes in vmlinux.h
>> lack __arena attribute.
>
> I would address this by dropping the alloc/free.
> Instead to work around "addr_space_cast insn in program without arena error",
> insert a dummy store "ptr = &arena" in the program, where ptr is a
> global void *.
>

I want to use alloc/free and not use a dummy address because because
arena pointers are special as they are returned by alloc() with
arena->user_vm_start added to them, and the
bpf_prog_report_arena_violation() also adds back arena->user_vm_start to
the 32 bit address received by the fault handler. If I use a random
address in the bpf program, bpf_prog_report_arena_violation() will print
a bogus address.

So, I think we should keep using alloc/free for this test because we
want to test this arena->user_vm_start addition as well.

Thanks,
Puranjay


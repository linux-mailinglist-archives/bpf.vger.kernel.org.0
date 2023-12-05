Return-Path: <bpf+bounces-16747-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34575805954
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 17:01:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65ABA1C21120
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 16:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F0E360BA4;
	Tue,  5 Dec 2023 16:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="cs2DaqGJ"
X-Original-To: bpf@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C33C122
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 08:00:58 -0800 (PST)
Message-ID: <f18d75bc-1d1c-4391-b006-308568de10bf@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1701792056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NJTO8wMrK790FDv4HSOkTuMetExnK8uHfiEqavRRpVw=;
	b=cs2DaqGJ1haVGhCP1nMeSTK6br0L3hylb7mlpg75wy0tw8OlV2xMK3I62HRueC6t99O1xo
	MP7cBD+wSMZqy5+OVkMIllwFwK4fMdFogt+YveDsQ/v2kRisaTltgMIY7WrzG0aFpIGEwq
	O2a6AGmBEaBqpeQgHSiflHX6snFTET8=
Date: Tue, 5 Dec 2023 08:00:48 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCHv3 bpf 2/2] selftests/bpf: Add test for early update in
 prog_array_map_poke_run
Content-Language: en-GB
To: Jiri Olsa <olsajiri@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, bpf@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 KP Singh <kpsingh@chromium.org>, Stanislav Fomichev <sdf@google.com>,
 Hao Luo <haoluo@google.com>
References: <20231203204851.388654-1-jolsa@kernel.org>
 <20231203204851.388654-3-jolsa@kernel.org>
 <0c2c5931-535c-49ab-86c4-275f64e5767c@linux.dev> <ZW7imIQDjdOFdlLn@krava>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <ZW7imIQDjdOFdlLn@krava>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT


On 12/5/23 3:43 AM, Jiri Olsa wrote:
> On Mon, Dec 04, 2023 at 09:16:52PM -0800, Yonghong Song wrote:
>> On 12/3/23 3:48 PM, Jiri Olsa wrote:
>>> Adding test that tries to trigger the BUG_ON during early map update
>>> in prog_array_map_poke_run function.
>>>
>>> The idea is to share prog array map between thread that constantly
>>> updates it and another one loading a program that uses that prog
>>> array.
>>>
>>> Eventually we will hit a place where the program is ok to be updated
>>> (poke->tailcall_target_stable check) but the address is still not
>>> registered in kallsyms, so the bpf_arch_text_poke returns -EINVAL
>>> and cause imbalance for the next tail call update check, which will
>>> fail with -EBUSY in bpf_arch_text_poke as described in previous fix.
>>>
>>> Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
>>> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
>>> ---
>>>    .../selftests/bpf/prog_tests/tailcall_poke.c  | 74 +++++++++++++++++++
>>>    .../selftests/bpf/progs/tailcall_poke.c       | 32 ++++++++
>>>    2 files changed, 106 insertions(+)
>>>    create mode 100644 tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
>>>    create mode 100644 tools/testing/selftests/bpf/progs/tailcall_poke.c
>>>
>>> diff --git a/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c b/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
>>> new file mode 100644
>>> index 000000000000..f7e2c09fd772
>>> --- /dev/null
>>> +++ b/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
>>> @@ -0,0 +1,74 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> +#include <unistd.h>
>>> +#include <test_progs.h>
>>> +#include "tailcall_poke.skel.h"
>>> +
>>> +#define JMP_TABLE "/sys/fs/bpf/jmp_table"
>>> +
>>> +static int thread_exit;
>>> +
>>> +static void *update(void *arg)
>>> +{
>>> +	__u32 zero = 0, prog1_fd, prog2_fd, map_fd;
>>> +	struct tailcall_poke *call = arg;
>>> +
>>> +	map_fd = bpf_map__fd(call->maps.jmp_table);
>>> +	prog1_fd = bpf_program__fd(call->progs.call1);
>>> +	prog2_fd = bpf_program__fd(call->progs.call2);
>>> +
>>> +	while (!thread_exit) {
>>> +		bpf_map_update_elem(map_fd, &zero, &prog1_fd, BPF_ANY);
>>> +		bpf_map_update_elem(map_fd, &zero, &prog2_fd, BPF_ANY);
>>> +	}
>>> +
>>> +	return NULL;
>>> +}
>>> +
>>> +void test_tailcall_poke(void)
>>> +{
>>> +	struct tailcall_poke *call, *test;
>>> +	int err, cnt = 10;
>>> +	pthread_t thread;
>>> +
>>> +	unlink(JMP_TABLE);
>>> +
>>> +	call = tailcall_poke__open_and_load();
>>> +	if (!ASSERT_OK_PTR(call, "tailcall_poke__open"))
>>> +		return;
>>> +
>>> +	err = bpf_map__pin(call->maps.jmp_table, JMP_TABLE);
>>> +	if (!ASSERT_OK(err, "bpf_map__pin"))
>>> +		goto out;
>> Just curious. What is the reason having bpf_map__pin() here
>> and below? I tried and it looks like removing bpf_map__pin()
>> and below bpf_map__set_pin_path() will make reproducing
>> the failure hard/impossible.
> yes, it's there to share the jmp_table map between the two
> skeleton instances, so the update thread changes the same
> jmp_table map that's used in the skeleton we load in the
> while loop below

This does make sense.

>
> I'll add some comments to the test

Thanks for explanation. Some comments are definitely helpful!

>
> jirka
>
>>> +
>>> +	err = pthread_create(&thread, NULL, update, call);
>>> +	if (!ASSERT_OK(err, "new toggler"))
>>> +		goto out;
>>> +
>>> +	while (cnt--) {
>>> +		test = tailcall_poke__open();
>>> +		if (!ASSERT_OK_PTR(test, "tailcall_poke__open"))
>>> +			break;
>>> +
>>> +		err = bpf_map__set_pin_path(test->maps.jmp_table, JMP_TABLE);
>>> +		if (!ASSERT_OK(err, "bpf_map__pin")) {
>>> +			tailcall_poke__destroy(test);
>>> +			break;
>>> +		}
>>> +
>>> +		bpf_program__set_autoload(test->progs.test, true);
>>> +		bpf_program__set_autoload(test->progs.call1, false);
>>> +		bpf_program__set_autoload(test->progs.call2, false);
>>> +
>>> +		err = tailcall_poke__load(test);
>>> +		tailcall_poke__destroy(test);
>>> +		if (!ASSERT_OK(err, "tailcall_poke__load"))
>>> +			break;
>>> +	}
>>> +
>>> +	thread_exit = 1;
>>> +	ASSERT_OK(pthread_join(thread, NULL), "pthread_join");
>>> +
>>> +out:
>>> +	bpf_map__unpin(call->maps.jmp_table, JMP_TABLE);
>>> +	tailcall_poke__destroy(call);
>>> +}
> SNIP


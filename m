Return-Path: <bpf+bounces-16716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB0AC804CCF
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 09:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6C8F281755
	for <lists+bpf@lfdr.de>; Tue,  5 Dec 2023 08:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53ABD2420B;
	Tue,  5 Dec 2023 08:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahgHpv5e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B668C9C
	for <bpf@vger.kernel.org>; Tue,  5 Dec 2023 00:43:08 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54c5ed26cf6so5116623a12.3
        for <bpf@vger.kernel.org>; Tue, 05 Dec 2023 00:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701765787; x=1702370587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gHYXYfyLzptt927SH4oz/JSMbtWrTDQ+paj2UJBH7l8=;
        b=ahgHpv5eU8WpXNmyeVaSK7X1tLa77HamBjuQrzEcjuBbXAHoOfPaDZkhR24y2mhJf6
         O2EeZAEPww9GXr3DhV3TACR8ehjF9LuR+y1pAaSTwgSyK28XTLZSBxBaNiE7ZKF+c0Gf
         jLax1w9ErL+JNx0CIuGvP/FLAmXIMDmS93veAs0t1pvSxiFSgJxrovNHJ6+hWhNWVK3a
         zdTKFuG/VMUWlD6E7BGu4NJuyRER8bAxOqm4/1K6mzEX53X7j7rgjhdjZgQ8wcWAsdRN
         As+vQbdqrAtXs6tveBehssAL0krRoXosPZXycF8smspBnmqZkvmpBNl5lvM8tv3H+QB5
         U8zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701765787; x=1702370587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gHYXYfyLzptt927SH4oz/JSMbtWrTDQ+paj2UJBH7l8=;
        b=n3ILwjJ34sliUl4gREC3dBzhMhAXqUgeXjKhB0/70ML6nHG7oxOZs6NFg638EIQKy+
         M7RZgDA6BikW/xo3kkzlQgGVNMpMBvK8CP5T5oe50nj0yYkCUY5ZmUTZ6c8OgbXEzlsu
         cpuBlMdciGF7fwNzKD4lH6ZCzdE1rC+4KWtcpycZe5b6j0yH0IQCKD6+Y/6A/0pHRWoM
         98GKa0PqDF32/9VKAaVgpxwm2hP8CIFATcaCT3MHa+13OzDUxbicPQSPhj73bmqQKIz0
         WJ6MVdecYjXbIAWlusqr7yo2CBIgYi5J0vD3/NC+XngVwoGYHJFNWPs8Qrn7Ljwef1lW
         P/hA==
X-Gm-Message-State: AOJu0Yx7icxew05s9YxDrWsWG7I19CWChkDnSYee35Mht7Kx3WfKqRzj
	zggsn+P/0weQzE/iNo7MMvs=
X-Google-Smtp-Source: AGHT+IFRHWqWZcsw8iaEb0MTgwzzwHNeuH2Ajm5HZrM/4+CFDx6jVj7RiI3VI3wTorc9HK+OGYVvRA==
X-Received: by 2002:a50:d4c5:0:b0:54c:4837:81f9 with SMTP id e5-20020a50d4c5000000b0054c483781f9mr3754048edj.74.1701765786772;
        Tue, 05 Dec 2023 00:43:06 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id b17-20020a05640202d100b0054cb316499dsm759935edx.10.2023.12.05.00.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 00:43:06 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Tue, 5 Dec 2023 09:43:04 +0100
To: Yonghong Song <yonghong.song@linux.dev>
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>
Subject: Re: [PATCHv3 bpf 2/2] selftests/bpf: Add test for early update in
 prog_array_map_poke_run
Message-ID: <ZW7imIQDjdOFdlLn@krava>
References: <20231203204851.388654-1-jolsa@kernel.org>
 <20231203204851.388654-3-jolsa@kernel.org>
 <0c2c5931-535c-49ab-86c4-275f64e5767c@linux.dev>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0c2c5931-535c-49ab-86c4-275f64e5767c@linux.dev>

On Mon, Dec 04, 2023 at 09:16:52PM -0800, Yonghong Song wrote:
> 
> On 12/3/23 3:48 PM, Jiri Olsa wrote:
> > Adding test that tries to trigger the BUG_ON during early map update
> > in prog_array_map_poke_run function.
> > 
> > The idea is to share prog array map between thread that constantly
> > updates it and another one loading a program that uses that prog
> > array.
> > 
> > Eventually we will hit a place where the program is ok to be updated
> > (poke->tailcall_target_stable check) but the address is still not
> > registered in kallsyms, so the bpf_arch_text_poke returns -EINVAL
> > and cause imbalance for the next tail call update check, which will
> > fail with -EBUSY in bpf_arch_text_poke as described in previous fix.
> > 
> > Acked-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >   .../selftests/bpf/prog_tests/tailcall_poke.c  | 74 +++++++++++++++++++
> >   .../selftests/bpf/progs/tailcall_poke.c       | 32 ++++++++
> >   2 files changed, 106 insertions(+)
> >   create mode 100644 tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
> >   create mode 100644 tools/testing/selftests/bpf/progs/tailcall_poke.c
> > 
> > diff --git a/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c b/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
> > new file mode 100644
> > index 000000000000..f7e2c09fd772
> > --- /dev/null
> > +++ b/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
> > @@ -0,0 +1,74 @@
> > +// SPDX-License-Identifier: GPL-2.0
> > +#include <unistd.h>
> > +#include <test_progs.h>
> > +#include "tailcall_poke.skel.h"
> > +
> > +#define JMP_TABLE "/sys/fs/bpf/jmp_table"
> > +
> > +static int thread_exit;
> > +
> > +static void *update(void *arg)
> > +{
> > +	__u32 zero = 0, prog1_fd, prog2_fd, map_fd;
> > +	struct tailcall_poke *call = arg;
> > +
> > +	map_fd = bpf_map__fd(call->maps.jmp_table);
> > +	prog1_fd = bpf_program__fd(call->progs.call1);
> > +	prog2_fd = bpf_program__fd(call->progs.call2);
> > +
> > +	while (!thread_exit) {
> > +		bpf_map_update_elem(map_fd, &zero, &prog1_fd, BPF_ANY);
> > +		bpf_map_update_elem(map_fd, &zero, &prog2_fd, BPF_ANY);
> > +	}
> > +
> > +	return NULL;
> > +}
> > +
> > +void test_tailcall_poke(void)
> > +{
> > +	struct tailcall_poke *call, *test;
> > +	int err, cnt = 10;
> > +	pthread_t thread;
> > +
> > +	unlink(JMP_TABLE);
> > +
> > +	call = tailcall_poke__open_and_load();
> > +	if (!ASSERT_OK_PTR(call, "tailcall_poke__open"))
> > +		return;
> > +
> > +	err = bpf_map__pin(call->maps.jmp_table, JMP_TABLE);
> > +	if (!ASSERT_OK(err, "bpf_map__pin"))
> > +		goto out;
> 
> Just curious. What is the reason having bpf_map__pin() here
> and below? I tried and it looks like removing bpf_map__pin()
> and below bpf_map__set_pin_path() will make reproducing
> the failure hard/impossible.

yes, it's there to share the jmp_table map between the two
skeleton instances, so the update thread changes the same
jmp_table map that's used in the skeleton we load in the
while loop below

I'll add some comments to the test

jirka

> 
> > +
> > +	err = pthread_create(&thread, NULL, update, call);
> > +	if (!ASSERT_OK(err, "new toggler"))
> > +		goto out;
> > +
> > +	while (cnt--) {
> > +		test = tailcall_poke__open();
> > +		if (!ASSERT_OK_PTR(test, "tailcall_poke__open"))
> > +			break;
> > +
> > +		err = bpf_map__set_pin_path(test->maps.jmp_table, JMP_TABLE);
> > +		if (!ASSERT_OK(err, "bpf_map__pin")) {
> > +			tailcall_poke__destroy(test);
> > +			break;
> > +		}
> > +
> > +		bpf_program__set_autoload(test->progs.test, true);
> > +		bpf_program__set_autoload(test->progs.call1, false);
> > +		bpf_program__set_autoload(test->progs.call2, false);
> > +
> > +		err = tailcall_poke__load(test);
> > +		tailcall_poke__destroy(test);
> > +		if (!ASSERT_OK(err, "tailcall_poke__load"))
> > +			break;
> > +	}
> > +
> > +	thread_exit = 1;
> > +	ASSERT_OK(pthread_join(thread, NULL), "pthread_join");
> > +
> > +out:
> > +	bpf_map__unpin(call->maps.jmp_table, JMP_TABLE);
> > +	tailcall_poke__destroy(call);
> > +}

SNIP


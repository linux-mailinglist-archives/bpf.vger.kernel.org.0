Return-Path: <bpf+bounces-16376-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4DD800B85
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 14:13:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCFD51C20F52
	for <lists+bpf@lfdr.de>; Fri,  1 Dec 2023 13:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7DE2576F;
	Fri,  1 Dec 2023 13:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EghWfW+M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C467A0
	for <bpf@vger.kernel.org>; Fri,  1 Dec 2023 05:13:26 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-a1a2615e909so71324966b.3
        for <bpf@vger.kernel.org>; Fri, 01 Dec 2023 05:13:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701436405; x=1702041205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NUc/alY+PRg9GnfFqy8uRofe+BitddSOogHBTWCwp1I=;
        b=EghWfW+MZ78URLzCyQJH8TVJn76zjx09ZZVYYoLM2eJOeQKnRjfqQfXfotkBLtVkSM
         G+93iT6VJ+NHtqdV7yjrwr+ivb8u6SQHpcBpKfMBDH2ui7CSdrVW/aJ2LfBsBLDUle9n
         fQbHkzSP3Zr2wmgbqkr+vXCj3tZkXp2NUImVEL9CneOPAgb+awEVQUPwoL0nimRhbDBQ
         Cw5hiahjOX86yHFv0vB2+oGIkmJ3mpWd5P40FMluKVX28QqcUtaDEi7SMFLaRlIhsjeT
         Rg34GLQBiHWJnfr/TzAZZG9VEcP45/0fZ19t73ulS1b97ni/W4CMrP0XxW4SB5Q0cOVy
         DXWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701436405; x=1702041205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NUc/alY+PRg9GnfFqy8uRofe+BitddSOogHBTWCwp1I=;
        b=DCPpvCash8VryGBEEfnu41OElWi3NZcYxlREzbZRk7pnDqyH6lTrx2I2HzOqGZhemM
         ZVZM9KRjwvyL7DRVcr4zZ3TqP31kiU8q4H7rKiudLu2iHp1j6PRQOZlOK+lvMgG0d1CB
         nDt2Kq/TC0kvUc4W3LKrXr1kF4w0ivfL/NcH6nRCpnHUIUoD9DP74CR45+tlK2cN6gCn
         Y9joGHL9Z26sJ8k9peuOe5MezcxukAI+4CVwVuMFTRFHYR2WH8pFWXGsod/KKPXcldyE
         yB/jdgvQBeDtzhAsZtarnlcDtGsHlYVg64zuYBp5ocS1UIx7K02/DiTOILKbDBAKoCRB
         A5WQ==
X-Gm-Message-State: AOJu0Yz/Ori7obkxe0BeKqatKqrQQcOC9w7OwtFjiMQp+/+xcfKqWYrG
	ayrerj/MH1vGAr3qXUVz5b4=
X-Google-Smtp-Source: AGHT+IF5nwi3ZA8u9iTqon2Vn0pN4OiwvDAz3Al0aYYtM36ziQlHo+lutmuRmqvTFgGInVon9DXVHA==
X-Received: by 2002:a17:906:ad4:b0:a19:9b79:8b59 with SMTP id z20-20020a1709060ad400b00a199b798b59mr546057ejf.106.1701436404623;
        Fri, 01 Dec 2023 05:13:24 -0800 (PST)
Received: from krava (2001-1ae9-1c2-4c00-726e-c10f-8833-ff22.ip6.tmcz.cz. [2001:1ae9:1c2:4c00:726e:c10f:8833:ff22])
        by smtp.gmail.com with ESMTPSA id gq18-20020a170906e25200b009ad89697c86sm1917281ejb.144.2023.12.01.05.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 05:13:24 -0800 (PST)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Fri, 1 Dec 2023 14:13:22 +0100
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Jiri Olsa <olsajiri@gmail.com>, Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Martin KaFai Lau <kafai@fb.com>, Song Liu <songliubraving@fb.com>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@chromium.org>,
	Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>,
	Xu Kuohai <xukuohai@huawei.com>, Will Deacon <will@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Pu Lehui <pulehui@huawei.com>,
	=?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
	Lee Jones <lee@kernel.org>
Subject: Re: [PATCHv2 bpf 0/2] bpf: Fix prog_array_map_poke_run map poke
 update
Message-ID: <ZWnb8ptRW1DW6JLp@krava>
References: <20231128092850.1545199-1-jolsa@kernel.org>
 <22e3824bce10a895b1c9ce33ed7473561d288e69.camel@linux.ibm.com>
 <ZWc7OHnLux47RpOr@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWc7OHnLux47RpOr@krava>

On Wed, Nov 29, 2023 at 02:23:04PM +0100, Jiri Olsa wrote:
> On Tue, Nov 28, 2023 at 11:44:33PM +0100, Ilya Leoshkevich wrote:
> > On Tue, 2023-11-28 at 10:28 +0100, Jiri Olsa wrote:
> > > hi,
> > > this patchset fixes the issue reported in [0].
> > > 
> > > For the actual fix in patch 2 I'm changing bpf_arch_text_poke to
> > > allow to skip
> > > ip address check in patch 1. I considered adding separate function
> > > for that,
> > > but because each arch implementation is bit different, adding extra
> > > arg seemed
> > > like better option.
> > > 
> > > v2 changes:
> > >   - make it work for other archs
> > > 
> > > thanks,
> > > jirka
> > > 
> > > 
> > > [0] https://syzkaller.appspot.com/bug?extid=97a4fe20470e9bc30810
> > > ---
> > > Jiri Olsa (2):
> > >       bpf: Add checkip argument to bpf_arch_text_poke
> > >       bpf, x64: Fix prog_array_map_poke_run map poke update
> > > 
> > >  arch/arm64/net/bpf_jit_comp.c   |  3 ++-
> > >  arch/riscv/net/bpf_jit_comp64.c |  5 +++--
> > >  arch/s390/net/bpf_jit_comp.c    |  3 ++-
> > >  arch/x86/net/bpf_jit_comp.c     | 24 +++++++++++++-----------
> > >  include/linux/bpf.h             |  2 +-
> > >  kernel/bpf/arraymap.c           | 31 +++++++++++--------------------
> > >  kernel/bpf/core.c               |  2 +-
> > >  kernel/bpf/trampoline.c         | 12 ++++++------
> > >  8 files changed, 39 insertions(+), 43 deletions(-)
> > 
> > Would it be possible to add a minimized version of the reproducer as a
> > testcase?
> 
> there's reproducer I used in here:
>   https://syzkaller.appspot.com/text?tag=ReproC&x=1397180f680000
> 
> I can try, but not sure I'll be able to come up with something that
> would fit as testcase.. I'll check

the test below reproduces it for me.. the only tricky part is that
I need to repeat the loop 10 times to trigger that on my setup..
which is not terrible, but not great for a test I think

jirka


---
diff --git a/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c b/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
new file mode 100644
index 000000000000..c18751677811
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/tailcall_poke.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <unistd.h>
+#include <test_progs.h>
+#include "tailcall_poke.skel.h"
+
+#define JMP_TABLE "/sys/fs/bpf/jmp_table"
+
+static int thread_exit;
+
+static void *update(void *arg)
+{
+	__u32 zero = 0, prog1_fd, prog2_fd, map_fd;
+	struct tailcall_poke *call = arg;
+
+	map_fd = bpf_map__fd(call->maps.jmp_table);
+	prog1_fd = bpf_program__fd(call->progs.call1);
+	prog2_fd = bpf_program__fd(call->progs.call2);
+
+	while (!thread_exit) {
+		bpf_map_update_elem(map_fd, &zero, &prog1_fd, BPF_ANY);
+		bpf_map_update_elem(map_fd, &zero, &prog2_fd, BPF_ANY);
+	}
+
+	return NULL;
+}
+
+void test_tailcall_poke(void)
+{
+	struct tailcall_poke *call, *test;
+	int err, cnt = 10;
+	pthread_t thread;
+
+	unlink(JMP_TABLE);
+
+	call = tailcall_poke__open_and_load();
+	if (!ASSERT_OK_PTR(call, "tailcall_poke__open"))
+		return;
+
+	err = bpf_map__pin(call->maps.jmp_table, JMP_TABLE);
+	if (!ASSERT_OK(err, "bpf_map__pin"))
+		goto out;
+
+	err = pthread_create(&thread, NULL, update, call);
+	if (!ASSERT_OK(err, "new toggler"))
+		goto out;
+
+	while (cnt--) {
+		test = tailcall_poke__open();
+		if (!ASSERT_OK_PTR(test, "tailcall_poke__open"))
+			break;
+
+		err = bpf_map__set_pin_path(test->maps.jmp_table, JMP_TABLE);
+		if (!ASSERT_OK(err, "bpf_map__pin")) {
+			tailcall_poke__destroy(test);
+			break;
+		}
+
+		bpf_program__set_autoload(test->progs.test, true);
+		bpf_program__set_autoload(test->progs.call1, false);
+		bpf_program__set_autoload(test->progs.call2, false);
+
+		err = tailcall_poke__load(test);
+		if (!ASSERT_OK(err, "tailcall_poke__load")) {
+			tailcall_poke__destroy(test);
+			break;
+		}
+
+		tailcall_poke__destroy(test);
+	}
+
+	thread_exit = 1;
+	ASSERT_OK(pthread_join(thread, NULL), "pthread_join");
+
+out:
+	bpf_map__unpin(call->maps.jmp_table, JMP_TABLE);
+	tailcall_poke__destroy(call);
+}
diff --git a/tools/testing/selftests/bpf/progs/tailcall_poke.c b/tools/testing/selftests/bpf/progs/tailcall_poke.c
new file mode 100644
index 000000000000..d4cf63c7db01
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/tailcall_poke.c
@@ -0,0 +1,32 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+struct {
+        __uint(type, BPF_MAP_TYPE_PROG_ARRAY);
+        __uint(max_entries, 1);
+        __uint(key_size, sizeof(__u32));
+        __uint(value_size, sizeof(__u32));
+} jmp_table SEC(".maps");
+
+SEC("?fentry/bpf_fentry_test1")
+int BPF_PROG(test, int a)
+{
+	bpf_tail_call_static(ctx, &jmp_table, 0);
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(call1, int a)
+{
+	return 0;
+}
+
+SEC("fentry/bpf_fentry_test1")
+int BPF_PROG(call2, int a)
+{
+	return 0;
+}


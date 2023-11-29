Return-Path: <bpf+bounces-16182-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52DAF7FE039
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 20:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7530E1C20DA5
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 19:20:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5853B5DF34;
	Wed, 29 Nov 2023 19:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T47R8tiY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77CC1A8
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:20:43 -0800 (PST)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2c9b8aa4fc7so2172101fa.1
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:20:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701285642; x=1701890442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbgGnNSc9VlBCfH+twMPpyfhCOxVgn8K0Gl2N2knpyg=;
        b=T47R8tiYr1jfYOyXLSPwVmyFw1tV5NdAwTozMC7n0fFOubZjYZUIyDH42mSYUmBsli
         1z8r8ZtzXiZgARFL8Z7XOuEkls1an8TUXKwCWKzN0a9030os3rZt5HTwf9v6RHqD+beq
         wjFYF8IFcRrCzSeYldQYVFhTkHziJvDKbDiXMbJZuVIoaoer4Rpul6yykyp2wcev1r6j
         /Fy8dplNXpMGHgeAMU2Bgb+SE7KUX7eqH4CNl4uWc9MuFj525c6t3eD3OZGKA1un1DDm
         2ekxzaKrcDUylIx8lMi92Nf5AD4u2h++1FE7ZLy7DZYO2bfDAf2LpBH/dOLRdhTG2YTa
         q0CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701285642; x=1701890442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbgGnNSc9VlBCfH+twMPpyfhCOxVgn8K0Gl2N2knpyg=;
        b=aWY/uzKekNvjaqEf/Iiof8rzu4uriijpR5raHGIQBqIjzl7KfGyPY9KXRtFetchW6Z
         GbXz+4VetMQpXwnTDAyg2rLM3SNhduQ+nLnrflH5QQz+qs2gtetARYWg5WS8TGFaF4C1
         V0Q/xnye2MRO+riV1Ovcelm59TNJ+K73h1e4hE76g9QFDq4cVvDONasLWc10j6c4XSkb
         r5Xbdg6zpLy6+9xbV5rhZKKDLq56l71fcbkq5uJkC5yr9obk3u+b8QmIDq3Cyn1CEVOo
         NhDYxOTQ5XtrY4SsB4W3KUJmIm0NZeK4CO+0qk/GPa4XAc+VxrLIYKdZCTw5iNSpPMwh
         heTQ==
X-Gm-Message-State: AOJu0YwD/O7sfpl9+FecPOsDE0MjhijXQpyavgc2AKqR7OUpQY6C80x6
	lk9H6Lwiz3+fzTY39+x9fxX9lqMGgGEhiQ==
X-Google-Smtp-Source: AGHT+IHzycDzlALSk99gqZ0xF+KFa5DeWIYCinh04PT7s8+y6sECtJ67wiClB1eqq3GK0qG2gKU2oQ==
X-Received: by 2002:a2e:9dc2:0:b0:2c9:b74b:c2e0 with SMTP id x2-20020a2e9dc2000000b002c9b74bc2e0mr3754177ljj.16.1701285641720;
        Wed, 29 Nov 2023 11:20:41 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id s16-20020a170906455000b009fd7bcd9054sm3596123ejq.147.2023.11.29.11.20.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:20:41 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	dan.carpenter@linaro.org,
	olsajiri@gmail.com,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v3 3/3] bpf, selftest/bpf: Fix re-attachment branch in bpf_tracing_prog_attach
Date: Wed, 29 Nov 2023 20:16:40 +0100
Message-ID: <20231129191643.6842-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231129191643.6842-1-9erthalion6@gmail.com>
References: <20231129191643.6842-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It looks like there is an issue in bpf_tracing_prog_attach, in the
"prog->aux->dst_trampoline and tgt_prog is NULL" case. One can construct
a sequence of events when prog->aux->attach_btf will be NULL, and
bpf_trampoline_compute_key will fail.

    BUG: kernel NULL pointer dereference, address: 0000000000000058
    Call Trace:
     <TASK>
     ? __die+0x20/0x70
     ? page_fault_oops+0x15b/0x430
     ? fixup_exception+0x22/0x330
     ? exc_page_fault+0x6f/0x170
     ? asm_exc_page_fault+0x22/0x30
     ? bpf_tracing_prog_attach+0x279/0x560
     ? btf_obj_id+0x5/0x10
     bpf_tracing_prog_attach+0x439/0x560
     __sys_bpf+0x1cf4/0x2de0
     __x64_sys_bpf+0x1c/0x30
     do_syscall_64+0x41/0xf0
     entry_SYSCALL_64_after_hwframe+0x6e/0x76

The issue seems to be not relevant to the previous changes with
recursive tracing prog attach, because the reproducing test doesn't
actually include recursive fentry attaching.

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
 kernel/bpf/syscall.c                          |  4 +-
 .../bpf/prog_tests/recursive_attach.c         | 48 +++++++++++++++++++
 .../bpf/progs/fentry_recursive_target.c       | 11 +++++
 3 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 15a47308bbdd..5cd4a7a39a03 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3196,7 +3196,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 			goto out_unlock;
 		}
 		btf_id = prog->aux->attach_btf_id;
-		key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf, btf_id);
+		if (prog->aux->attach_btf)
+			key = bpf_trampoline_compute_key(NULL, prog->aux->attach_btf,
+											 btf_id);
 	}
 
 	if (!prog->aux->dst_trampoline ||
diff --git a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
index 9c422dd92c4e..a4abf1745e62 100644
--- a/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
+++ b/tools/testing/selftests/bpf/prog_tests/recursive_attach.c
@@ -83,3 +83,51 @@ void test_recursive_fentry_attach(void)
 			fentry_recursive__destroy(tracing_chain[i]);
 	}
 }
+
+/*
+ * Test that a tracing prog reattachment (when we land in
+ * "prog->aux->dst_trampoline and tgt_prog is NULL" branch in
+ * bpf_tracing_prog_attach) does not lead to a crash due to missing attach_btf
+ */
+void test_fentry_attach_btf_presence(void)
+{
+	struct fentry_recursive_target *target_skel = NULL;
+	struct fentry_recursive *tracing_skel = NULL;
+	struct bpf_program *prog;
+	int err, link_fd, tgt_prog_fd;
+
+	target_skel = fentry_recursive_target__open_and_load();
+	if (!ASSERT_OK_PTR(target_skel, "fentry_recursive_target__open_and_load"))
+		goto close_prog;
+
+	tracing_skel = fentry_recursive__open();
+	if (!ASSERT_OK_PTR(tracing_skel, "fentry_recursive__open"))
+		goto close_prog;
+
+	prog = tracing_skel->progs.recursive_attach;
+	tgt_prog_fd = bpf_program__fd(target_skel->progs.fentry_target);
+	err = bpf_program__set_attach_target(prog, tgt_prog_fd, "fentry_target");
+	if (!ASSERT_OK(err, "bpf_program__set_attach_target"))
+		goto close_prog;
+
+	err = fentry_recursive__load(tracing_skel);
+	if (!ASSERT_OK(err, "fentry_recursive__load"))
+		goto close_prog;
+
+	LIBBPF_OPTS(bpf_link_create_opts, link_opts);
+
+	link_fd = bpf_link_create(bpf_program__fd(tracing_skel->progs.recursive_attach),
+							  0, BPF_TRACE_FENTRY, &link_opts);
+	if (!ASSERT_GE(link_fd, 0, "link_fd"))
+		goto close_prog;
+
+	fentry_recursive__detach(tracing_skel);
+
+	err = fentry_recursive__attach(tracing_skel);
+	if (!ASSERT_ERR(err, "fentry_recursive__attach"))
+		goto close_prog;
+
+close_prog:
+	fentry_recursive_target__destroy(target_skel);
+	fentry_recursive__destroy(tracing_skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
index b6fb8ebd598d..f812d2de0c3c 100644
--- a/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
+++ b/tools/testing/selftests/bpf/progs/fentry_recursive_target.c
@@ -18,3 +18,14 @@ int BPF_PROG(test1, int a)
 	test1_result = a == 1;
 	return 0;
 }
+
+/*
+ * Dummy bpf prog for testing attach_btf presence when attaching an fentry
+ * program.
+ */
+SEC("raw_tp/sys_enter")
+int BPF_PROG(fentry_target, struct pt_regs *regs, long id)
+{
+	test1_result = id == 1;
+	return 0;
+}
-- 
2.41.0



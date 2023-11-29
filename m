Return-Path: <bpf+bounces-16187-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 295BB7FE096
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 20:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD6A4B21169
	for <lists+bpf@lfdr.de>; Wed, 29 Nov 2023 19:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D005EE7A;
	Wed, 29 Nov 2023 19:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTovyUDe"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7034194
	for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:57:04 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-54af2498e85so267259a12.0
        for <bpf@vger.kernel.org>; Wed, 29 Nov 2023 11:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701287823; x=1701892623; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l3gmxtg+/HLCBzmNCvOVfc0IlSQp/+6x3hv9R45IOxk=;
        b=DTovyUDecrpU08OhUaP7CYjX8G0CBN+vwdngwjTCXyRjWwB8+Z066Wv5QgJKSCq4RI
         EAjnWLtHleWLX6d3LDvQ8GwV/p3cKMm1UtY+HWTPG9bt98MPz4BNBIPgNhegjUKUs4pB
         SW2lGET7/SDLMVx+gT5y1yIEu2ndbhyy9WPBznuex5lMEpU4K1378TYOg5D7WTCbZKDe
         baSh5Sefd+MMQQmVznHCIjIttPSvlqQPnhtw/XmqmXg3tjvBDmzgP/X0X2uPBtDTZI/o
         mJqL12iVALFV1btVB/5JsChX9Yenl4T/K8olPYgiJwbQeRtw3Nrfl7vZxj4nQ4YkfV5Q
         Hxpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701287823; x=1701892623;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l3gmxtg+/HLCBzmNCvOVfc0IlSQp/+6x3hv9R45IOxk=;
        b=Jdn9BEY79bRVZhi33SyRzXleqPwvKjgyY9z/vLHASvJn4fgZ+JQn7pCI5fSzh/8/Yv
         ulkCTRVW6b+sz2aJhWa2K3Anher8QbQEUqKJvHYBugfaS8LTlE9s90wn34OyfZtHxdbb
         az2S9Qz0NXwJl5txhjz4pTo2HCXHV4FmdrIbSdeL5MDs/p0dErvu8v3JbvsPuqFv+FJs
         cTG/LzgEFjii07nH9+UuZ18b8gma0NyPQxI1MpvNEWbt1ak7zGdhwn/m53eambhUqRUy
         Siid0/1T+/dAdrFQOWwPaI4ZvU3ckhxH38b467Lh381UpKK9uK8nC7S0hgHGR4mK6nwV
         0p5w==
X-Gm-Message-State: AOJu0YykVR4m1WF2vkGJz4wN79fGWe7AOifsz95dl9U78RssCosm/XsW
	9ezdFhDfa/0brBe8qi1xS7sSYyvl8n+zpw==
X-Google-Smtp-Source: AGHT+IFAkpDqXzkLejwF12RflKJhu+bTbKTWMyq09wv7nPgkYno4l+Hjw4hSgruEmV8eRd14xrEzjQ==
X-Received: by 2002:a17:906:2dd2:b0:9ce:24d0:8a01 with SMTP id h18-20020a1709062dd200b009ce24d08a01mr13714945eji.60.1701287823318;
        Wed, 29 Nov 2023 11:57:03 -0800 (PST)
Received: from erthalion.local (dslb-178-005-231-183.178.005.pools.vodafone-ip.de. [178.5.231.183])
        by smtp.gmail.com with ESMTPSA id p4-20020a170906b20400b009ddaf5ebb6fsm8287742ejz.177.2023.11.29.11.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 11:57:03 -0800 (PST)
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
Subject: [PATCH bpf-next v4 3/3] bpf, selftest/bpf: Fix re-attachment branch in bpf_tracing_prog_attach
Date: Wed, 29 Nov 2023 20:52:38 +0100
Message-ID: <20231129195240.19091-4-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231129195240.19091-1-9erthalion6@gmail.com>
References: <20231129195240.19091-1-9erthalion6@gmail.com>
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
index a595d7a62dbc..e01a949dfed7 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3197,7 +3197,9 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
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



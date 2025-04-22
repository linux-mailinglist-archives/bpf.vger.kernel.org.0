Return-Path: <bpf+bounces-56449-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2099AA977A3
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 22:31:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 37D541B64A0A
	for <lists+bpf@lfdr.de>; Tue, 22 Apr 2025 20:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE26A2C2ADE;
	Tue, 22 Apr 2025 20:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bQjOkfwl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F6B2D8DD6
	for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 20:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745353823; cv=none; b=qAMDTyiquZ5NOUcO4fHjj1gm1vDPNxY+w1P72o7xZZ/y2fOS1WLKn5k/GyVv0H9Tnb+5cpNeCsMPypWlREcjemzhcD8bggo7ZcCfa6zBAs6z4nSKZvU7aP5jjVTxNXSHm+0qt6ptM4/9FtEyoa89sRVj2qGnLoq3D7YIMjkn3nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745353823; c=relaxed/simple;
	bh=01UGrytTVfyNTXnf0OR1rX3/RsHGZRztthQXQGniBMs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I3jet77nP747gqOQXqr3CC7UkkG0oMgchshVcjEW7Rx21yzpQ+FC5fvYKVpZAaXnCBzMS3gcrsGXYDaCUkgHaDIlYb5g/q8rRiwNB7hctXmbGCJYKa8DzudpNCRDWkYYbnnSYxgHA4HqMcVAjCTy+z/UB+2uLTCZNdDq4FLX9Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bQjOkfwl; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so7566618a91.3
        for <bpf@vger.kernel.org>; Tue, 22 Apr 2025 13:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745353821; x=1745958621; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yQdodtCfvAoCBqRuqGQgJwmCUOzCLIlyr7rLD7f5qbk=;
        b=bQjOkfwlAnLBQY+lc+XfnP8VLua6O2EqeUKasRyNpNF0OhPWDXVqt3edQKNys+AV0w
         1g2KOAa4QMqXoFiNuc3qs9WDZgkJjLavv59X8u8z+VGOabS9oWGznqlZu0e/JF+wPhcJ
         pB+fkc+w92sv65fKp6ezJrJz5h5A1ZfsfvP2wQL/vOiLFH5dxE8KXmimce8kn9jzgIj6
         YfySkJGExh50iSI27chiVJF+xOPNX/rWZiocr0wK1YNHgB6cyjNATHN8eGu8rQBk9mwH
         3tndQl8d/cOoRCzmXLYdEpgZRAJdChiy1hDPoi7cOgSJl9oRWtGxuSb63Zt6O3urFVXz
         C/yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745353821; x=1745958621;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yQdodtCfvAoCBqRuqGQgJwmCUOzCLIlyr7rLD7f5qbk=;
        b=pZHL2suoAurPcU3zrxIdA4rvyzuo9bjo+HCLOLTB9fzd14dOkim9FnGpnQ/9uIhX7W
         sqoyKnwqGXTq0QzWwDCcoGTpeV7nYQUDASAGdRsNmYKjRgGKS0D3KsX1ku6E1HcIICPG
         8NYRQQnFznNpBK2xj2hcUYSXu56FhpiJz/UldqovoiFXRRuiJDieaqpUn11QJ8kfnl5d
         W15Wpd7/VO/qUH0akg+FQDpShPLqPSOj+r3DbFPiUQialpCJ0JZ6J5VMlOESbi3ZNfSG
         uR/FjnMAj/nDxDzr+U7UZ0yhvl0jiAlyKxSYY/m2G4eJ2+/vUKGXdJOVq8vLFgcUUAww
         +1FA==
X-Gm-Message-State: AOJu0Yz6ldfR++wl9/T4OueCYcx1PrW3K1CilYDkEOoNSavI9xz7dGVk
	CCwAW80+thgEOHcwroQAk/EGmVtclXkxqFGvu6lT1nBKVlhvoICL
X-Gm-Gg: ASbGncuBePzP65U2yVof771hhYBuKDI9Ncjiy28xHYWT/PMkE2G5pxmqwYr5aoYRq9H
	T8VUBjxzRkvJ5akIy9oaHf4T9A4J3C/88cbiL3iys4OtF6w6LGY2/Jm7YcVhUhXpz8boN+QbXeq
	Z54xZGT07mOBOBOCljImkEotNS4LLaNy1gmTwV864Su2stjbyH0xkJtZuB33ZkApE0zckwfZtU1
	QrRaaZyjFDPJaFCKdtY6I9wOfp97S2GZU7e+bAp9yJ/jd7AtuA05veLKmWMf0QDm/O4xRGOwC+3
	SJ5hEkfXX6aw7oC6/+ljgZ/fRrIIoRVI/QRM1W4/L1V3
X-Google-Smtp-Source: AGHT+IFchx0nS7ELo6o9zwVvMErVCWfxuIsqTf4KkoWsaRldVjaOvyebVdXqoo3hIlVo39ZCfDzBDw==
X-Received: by 2002:a17:90a:f945:b0:2ea:bf1c:1e3a with SMTP id 98e67ed59e1d1-3087bb57aa9mr27585312a91.12.1745353820941;
        Tue, 22 Apr 2025 13:30:20 -0700 (PDT)
Received: from ezingerman-mba ([2620:10d:c090:500::6:9822])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-309df9f0dfasm35396a91.3.2025.04.22.13.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Apr 2025 13:30:20 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: bpf@vger.kernel.org,  Alexei Starovoitov <ast@kernel.org>,  Andrii
 Nakryiko <andrii@kernel.org>,  Daniel Borkmann <daniel@iogearbox.net>,
  Martin KaFai Lau <martin.lau@kernel.org>,  Emil Tsalapatis
 <emil@etsalapatis.com>,  Barret Rhoden <brho@google.com>,  kkd@meta.com,
  kernel-team@meta.com
Subject: Re: [RFC PATCH bpf-next/net v1 12/13] bpftool: Add support for
 dumping streams
In-Reply-To: <20250414161443.1146103-13-memxor@gmail.com> (Kumar Kartikeya
	Dwivedi's message of "Mon, 14 Apr 2025 09:14:42 -0700")
References: <20250414161443.1146103-1-memxor@gmail.com>
	<20250414161443.1146103-13-memxor@gmail.com>
Date: Tue, 22 Apr 2025 13:30:18 -0700
Message-ID: <m2wmbcq6qt.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


When I add a test as at the bottom of the email I get the following output:

    test_stream_cond_break:PASS:load 0 nsec
    test_stream_cond_break:PASS:run_opts 0 nsec
    test_stream_cond_break:PASS:info_by_fd 0 nsec
    ERROR: Timeout detected for may_goto instruction
    CPU: 6 UID: 0 PID: 206 Comm: test_progs
    Call trace:
     bpf_prog_stderr_dump_stack+0xde/0x160
     bpf_check_timed_may_goto+0x5d/0x90
     arch_bpf_timed_may_goto+0x21/0x40
     bpf_prog_34056decf3b2fb2f_long_loop+0x49/0x57: [stream_cond_break.c:8]
     bpf_prog_run_pin_on_cpu+0x5f/0x110
     bpf_prog_test_run_syscall+0x205/0x320
     bpf_prog_test_run+0x234/0x2a0
     __sys_bpf+0x2d7/0x570
     __x64_sys_bpf+0x7c/0x90
     do_syscall_64+0x79/0x120
     entry_SYSCALL_64_after_hwframe+0x76/0x7e
    
    prog_dump_stream: ret==-22
    test_stream_cond_break:FAIL:./tools/sbin/bpftool prog dump stderr id 8
     unexpected error: 59904 (errno 95)

Am I doing something wrong or EINVAL should not be returned from
prog_dump_stream in this case?

---

diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index d0800fec9c3d..64386737a364 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -747,6 +747,7 @@ prog_dump_stream(struct bpf_prog_info *info, enum dump_mode mode, const char *fi
 		ret = -EINVAL;
 end:
 	stream_bpf__destroy(skel);
+	fprintf(stderr, "prog_dump_stream: ret==%d\n", ret);
 	return ret;
 }
 
diff --git a/tools/testing/selftests/bpf/prog_tests/stream_cond_break.c b/tools/testing/selftests/bpf/prog_tests/stream_cond_break.c
new file mode 100644
index 000000000000..7a29a45b0a04
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/stream_cond_break.c
@@ -0,0 +1,42 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Meta Platforms, Inc. and affiliates. */
+#include <test_progs.h>
+#include "stream_cond_break.skel.h"
+
+static char log_buf[16 * 1024];
+
+void test_stream_cond_break(void)
+{
+	LIBBPF_OPTS(bpf_object_open_opts, opts, .kernel_log_buf = log_buf,
+						.kernel_log_size = sizeof(log_buf),
+						.kernel_log_level = 1 | 2 | 4);
+	LIBBPF_OPTS(bpf_test_run_opts, run_opts);
+	struct stream_cond_break *skel = NULL;
+	struct bpf_prog_info prog_info;
+	__u32 prog_info_len;
+	int ret, fd;
+
+	skel = stream_cond_break__open_opts(&opts);
+	if (!ASSERT_OK_PTR(skel, "open_opts"))
+		goto out;
+	ret = stream_cond_break__load(skel);
+	if (env.verbosity >= VERBOSE_VERY) {
+		fprintf(stderr, "---- program load log ----\n");
+		fprintf(stderr, "%s", log_buf);
+		fprintf(stderr, "--------- end log --------\n");
+	}
+	if (!ASSERT_OK(ret, "load"))
+		return;
+	fd = bpf_program__fd(skel->progs.long_loop);
+	ret = bpf_prog_test_run_opts(fd, &run_opts);
+	if (!ASSERT_EQ(ret, 0, "run_opts"))
+		goto out;
+	memset(&prog_info, 0, sizeof(prog_info));
+	prog_info_len = sizeof(prog_info);
+	ret = bpf_prog_get_info_by_fd(fd, &prog_info, &prog_info_len);
+	if (!ASSERT_OK(ret, "info_by_fd"))
+		goto out;
+	SYS(out, "./tools/sbin/bpftool prog dump stderr id %i\n", prog_info.id);
+out:
+	stream_cond_break__destroy(skel);
+}
diff --git a/tools/testing/selftests/bpf/progs/stream_cond_break.c b/tools/testing/selftests/bpf/progs/stream_cond_break.c
new file mode 100644
index 000000000000..47c2e5f1b8fd
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/stream_cond_break.c
@@ -0,0 +1,12 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "bpf_experimental.h"
+
+SEC("syscall")
+int long_loop(const void *ctx)
+{
+	for (;;)
+		cond_break;
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";


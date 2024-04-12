Return-Path: <bpf+bounces-26638-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7238A341A
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 18:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 313BE1F22D82
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 16:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8AE014C59C;
	Fri, 12 Apr 2024 16:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hRgtZJkz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E38614D294
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 16:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712940772; cv=none; b=NXk5iMoJF4mzT9ramyC2DSBGlFxsJi3DwLZhOPsKM/gz8H9D+2Vz90e4zdyJgE8Vm3y3/eBO/WD4fLxYpkm/CSe4QG819uSlapVXNxzSkFdSqDxJL31kHK9IKIxMyosfS5QU14qvECsnbcSXMNmmc4XofdIAIe5H979VQsPaRLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712940772; c=relaxed/simple;
	bh=CyIk1pwERJvzEjkuTZFPuRN5VUCz+CWomJwYGuHccJg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mjRcxNoNonTxwlYVh/ugdcA7nMdQwhA72/xp3E63xYeqPVvmLTLZchT+3se5Sh4mzghXR2g040rpdPAgJuMseJQ4U864CbX4V74N1l1IOeGA0Ud3aYmjHpsi6pbAN1F4hQNfLZiQIF4S1ALB/Gc03BBNpb1TVyu9XSjJhgldEdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hRgtZJkz; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jrife.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dd1395fd1bfso1963990276.0
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 09:52:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712940770; x=1713545570; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j1dofB21TbMaIGyCu7dvi5Q2fKvkP3yAy0VIcg6Cjss=;
        b=hRgtZJkzlFaDSxylbVKgmjUbZDVeHgWx2qtARFTQWGeHxpPZyo+0OaA3X4J0fRPu41
         vwC2YY3HhK21U0cmg+QMR6TTAscEN/PjTlWj9XShJK0lqqoVGuTuhOR9Mjvcn0Z1S2W6
         CFl3qyVz2RQcg8sZcJL0O0AhaBkwE9ZtzINn5CgICscsYnkn0kO/xksKw+C9AieDxPrR
         OKOIuuhbaF3ML76CrsIhniINqnvb82wVAejWdgvNOJ3S+LdTOxjVKAFMrL3j9FVx1QcL
         84FaBze4+45NZJeJ6wbf+zPSuz1OF2mG/gFpd1r1PpmMXnTc6khe7GDX5dqLXIZEzryM
         g/Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712940770; x=1713545570;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j1dofB21TbMaIGyCu7dvi5Q2fKvkP3yAy0VIcg6Cjss=;
        b=uX1983J0XreFKntBGAD0PrBHe4kqQ/gUYgFq4i4ODKIIwTng6chUJWUkQyaCPQRres
         BOqkaZoMsYT8RcUFNOn/N1IUNZVCGX8C7RGGEXPccGQLif4UgN8XsIgce1OCWoHfnFg4
         jj3xHOQK8ZU9TaqNrqHf07rWfzmheAvqH6y137//vcOCe+XqVT/c9F2ti5AcDHbFxYXz
         Nwd2haqERbiM4SwDm3h3tGEGgHu2yAqasT8qYHUYmrpOiHIfhdClR9qkSjuPMmlyabAw
         Et9wMxx5uif7FuhrI9mgDMZ5lltNs4tvkDeoc3T2pw6XbD8d+03TEN+T7udj5L3ipsGe
         djMQ==
X-Gm-Message-State: AOJu0YxUYZrDHrnvgiZdXsyf/gD/IgJzIZDAQNP3frE4YmhdawB49Lql
	OC8nGp1auXS/Vn9CZTBam9PxkJ3GXposTi25HNvBEKNQEvGh/PCLLlmyqABFlWBIDEtiyYCE9iD
	xaqq9hxCplRwjuMc+A6bHzzMnfnQatqMyJSD/RsY5KOyOreiIEBXLnJtgmlqtf5/+2csQ0HX8gi
	3PJufpwyCAgPtOfV9jlSrQPBk=
X-Google-Smtp-Source: AGHT+IEZyYdfM3uqzHq1TYV9AyT7KKbPds/rVQE1kJl1rPWhtv8yJDpn/c9kU28LnQpYE5WwpZXgKGIErA==
X-Received: from jrife.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:9f])
 (user=jrife job=sendgmr) by 2002:a05:6902:18d5:b0:ddd:7581:13ac with SMTP id
 ck21-20020a05690218d500b00ddd758113acmr912806ybb.2.1712940769951; Fri, 12 Apr
 2024 09:52:49 -0700 (PDT)
Date: Fri, 12 Apr 2024 11:52:24 -0500
In-Reply-To: <20240412165230.2009746-1-jrife@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240412165230.2009746-1-jrife@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240412165230.2009746-4-jrife@google.com>
Subject: [PATCH v2 bpf-next 3/6] selftests/bpf: Implement BPF programs for
 kernel socket operations
From: Jordan Rife <jrife@google.com>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jrife@google.com>, linux-kselftest@vger.kernel.org, 
	netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@google.com>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Mykola Lysenko <mykolal@fb.com>, Shuah Khan <shuah@kernel.org>, 
	Kui-Feng Lee <thinker.li@gmail.com>, Artem Savkov <asavkov@redhat.com>, 
	Dave Marchevsky <davemarchevsky@fb.com>, Menglong Dong <imagedong@tencent.com>, Daniel Xu <dxu@dxuuu.xyz>, 
	David Vernet <void@manifault.com>, Daan De Meyer <daan.j.demeyer@gmail.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="UTF-8"

This patch lays out a set of SYSCALL programs that can be used to invoke
the socket operation kfuncs in bpf_testmod, allowing a test program to
manipulate kernel socket operations from userspace.

Signed-off-by: Jordan Rife <jrife@google.com>
---
 .../selftests/bpf/progs/sock_addr_kern.c      | 65 +++++++++++++++++++
 1 file changed, 65 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/sock_addr_kern.c

diff --git a/tools/testing/selftests/bpf/progs/sock_addr_kern.c b/tools/testing/selftests/bpf/progs/sock_addr_kern.c
new file mode 100644
index 0000000000000..8386bb15ccdc1
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/sock_addr_kern.c
@@ -0,0 +1,65 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2024 Google LLC */
+#include <vmlinux.h>
+#include <bpf/bpf_helpers.h>
+#include "../bpf_testmod/bpf_testmod_kfunc.h"
+
+SEC("syscall")
+int init_sock(struct init_sock_args *args)
+{
+	bpf_kfunc_init_sock(args);
+
+	return 0;
+}
+
+SEC("syscall")
+int close_sock(void *ctx)
+{
+	bpf_kfunc_close_sock();
+
+	return 0;
+}
+
+SEC("syscall")
+int kernel_connect(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_connect(args);
+}
+
+SEC("syscall")
+int kernel_bind(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_bind(args);
+}
+
+SEC("syscall")
+int kernel_listen(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_listen();
+}
+
+SEC("syscall")
+int kernel_sendmsg(struct sendmsg_args *args)
+{
+	return bpf_kfunc_call_kernel_sendmsg(args);
+}
+
+SEC("syscall")
+int sock_sendmsg(struct sendmsg_args *args)
+{
+	return bpf_kfunc_call_sock_sendmsg(args);
+}
+
+SEC("syscall")
+int kernel_getsockname(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_getsockname(args);
+}
+
+SEC("syscall")
+int kernel_getpeername(struct addr_args *args)
+{
+	return bpf_kfunc_call_kernel_getpeername(args);
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.44.0.478.gd926399ef9-goog



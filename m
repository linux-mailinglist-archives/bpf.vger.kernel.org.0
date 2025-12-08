Return-Path: <bpf+bounces-76281-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55A6ACAD362
	for <lists+bpf@lfdr.de>; Mon, 08 Dec 2025 14:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8699C30125F7
	for <lists+bpf@lfdr.de>; Mon,  8 Dec 2025 13:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F43D2D7398;
	Mon,  8 Dec 2025 13:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h0iRdPBy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96B52266B67
	for <bpf@vger.kernel.org>; Mon,  8 Dec 2025 13:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765199281; cv=none; b=gIt/IWBY+0OWfNpewmgz/6xVRMbz1CFZTZIjNDtnhs6E7ZtrCu4Iry811u4uPRq4mJhOrvbByVQqyPeDg5vSjLeT03CzjPZcQbtiAmgQH+1AWp2T5Vf5Zsx6bZr+pwdSYgWL6jYuIkM4HuP/8fxGxSBlbx60R4VzZWH2InwQZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765199281; c=relaxed/simple;
	bh=P68vuVXGbiudnUH46WND/LnxuXicep6JwoD1Sh0rqFk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtuwI7MfpcuLlR4w5nwlT5sv/PtBiHZzI1tbFrQHMFay8sCa8FkQjNW9ObLJHjSuVYubV0ZhU3eKsMqbWJIgq3eDil3S6PxuUuy+qTQwQTezyeyoILrVIasgss7Hh7I+ULP0avoCDwm/RggOowHyCZKYK0UoNIh8ENhobOKXb6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h0iRdPBy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F362EC4CEF1;
	Mon,  8 Dec 2025 13:07:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765199281;
	bh=P68vuVXGbiudnUH46WND/LnxuXicep6JwoD1Sh0rqFk=;
	h=From:To:Cc:Subject:Date:From;
	b=h0iRdPByVdZsrC+ePsqB4VTXQiid9hCIYjrfyYpunO3PPmMr1fUUoSV8XR/Nxb9gA
	 PEihSM84IE6oSGwgVCdKnMXGOamawYddEnMeK8vjnxwxJIF65vPUr/XTPDc0zs5A1C
	 I5cNTdtJ5RkidvJ+WQqg6MX8vrtJc6ZnYxD8yQMLTtTeDPS3/p51x9u71/TIu1/KTN
	 GuLQD/a+u6oNyVvNE4pIhRp/+3SuRnxEU10Y3U8SLfVRGVGjYbdaLqn0grhFM4kBda
	 oTjIUhv+7s9mt/js4jQoMbJp3zIcGyuhYlSqMnTK6gFzwAM3SMoiWq7OHYIyD2NVjs
	 4ogex2/kQCcrw==
From: Quentin Monnet <qmo@kernel.org>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Quentin Monnet <qmo@kernel.org>
Subject: [PATCH bpf-next] bpftool: Fix build warnings from vmlinux.h due to MS extensions
Date: Mon,  8 Dec 2025 13:07:48 +0000
Message-ID: <20251208130748.68371-1-qmo@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The kernel is now built with -fms-extensions. Anonymous structs or
unions permitted by these extensions have been used in several places,
and can end up in the generated vmlinux.h file, for example:

    struct ns_tree {
        [...]
    };

    [...]

    struct ns_common {
            [...]
            union {
                    struct ns_tree;
                    struct callback_head ns_rcu;
            };
    };

Trying to include this header for compiling a tool may result in build
warnings, if the compiler does not expect these extensions. This is the
case, for example, with bpftool:

    In file included from skeleton/pid_iter.bpf.c:3:
    .../tools/testing/selftests/bpf/tools/build/bpftool/vmlinux.h:64057:3:
    warning: declaration does not declare anything
    [-Wmissing-declarations]
     64057 |                 struct ns_tree;
           |                 ^~~~~~~~~~~~~~

Fix these build warnings in bpftool by turning on Microsoft extensions
when compiling the two BPF programs that rely on vmlinux.h.

Reported-by: Alexei Starovoitov <ast@kernel.org>
Closes: https://lore.kernel.org/bpf/CAADnVQK9ZkPC7+R5VXKHVdtj8tumpMXm7BTp0u9CoiFLz_aPTg@mail.gmail.com/
Signed-off-by: Quentin Monnet <qmo@kernel.org>
---
 tools/bpf/bpftool/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index 586d1b2595d1..5442073a2e42 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -224,6 +224,8 @@ endif
 
 $(OUTPUT)%.bpf.o: skeleton/%.bpf.c $(OUTPUT)vmlinux.h $(LIBBPF_BOOTSTRAP)
 	$(QUIET_CLANG)$(CLANG) \
+		-Wno-microsoft-anon-tag \
+		-fms-extensions \
 		-I$(or $(OUTPUT),.) \
 		-I$(srctree)/tools/include/uapi/ \
 		-I$(LIBBPF_BOOTSTRAP_INCLUDE) \
-- 
2.43.0



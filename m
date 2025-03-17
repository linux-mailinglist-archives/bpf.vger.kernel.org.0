Return-Path: <bpf+bounces-54191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF83CA64E79
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 13:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069501884D84
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 12:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFA823815F;
	Mon, 17 Mar 2025 12:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5AqOjUE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9431521D3DF
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 12:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742213890; cv=none; b=twWOwn2L0bEDVOl0wEGEG2l1Znt/fjTvlDWdKsB2t2on9+I/3HMjYhXMUGg8t6S1tXI6EOvDD6A9blUPwIWbmV+3q1dBGGm3DiDpZlsNlUrlGr+J3pcgcC7icbboAk833uyR6vryAuFHrQEND+/74GVE0wm1LsfqpmFki8rYuD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742213890; c=relaxed/simple;
	bh=zwEVN5zTcMw3G9CRTAJNDL9Gs+QyT1fTAemwSdAIdHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c+tiTZs9rUmmZxs8Yq+E95rtvEAzys4f6BS64pW+1pHdvXbI4QurmxmT78quJaNuqNhrui+xU1HvdGi9tk4KCU5j/i+Lhv2IrW43V/W8aWoLjkRk/Zak2etJdAWa+WlXORAk1lQxLRu7EvuId/lR9yHXUfjgyJfgfEpt5xSdK1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h5AqOjUE; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2232aead377so92654425ad.0
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 05:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742213889; x=1742818689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sViwZFqw4Dxk80MihqOntWJ5GqJszGdmQTVLIDsqs4=;
        b=h5AqOjUEcyvTnV10cReFagIQOGR0s/ys06cteR0PxoeuqRVBddk/WZIIPNh6Hpa0Zy
         ckpPK13ac1NVEiyOFUopa84+pnxfBt3lhHkZpQoEAsZY1DhcScyhboIM1SKshTWgpuCX
         XLDBQ9jEJn8Cv/bB+jQG5aU/oAoIWfO8FiwkKPc1ZQ0802PHiDzPVA2l3zVKZYy+8sJr
         XBeWHpjV/34waG35lxQJ+MlXf766KP2NV4EQBE4pt3XwiL8nKRN9EiUVzSsBDrynUQg9
         usugSIw0dr9x66jytDeH+v2khpvWcrEnO0VgKtN85OSxRHG9Z6AiOARnenXWUkRJfmK5
         AxTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742213889; x=1742818689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sViwZFqw4Dxk80MihqOntWJ5GqJszGdmQTVLIDsqs4=;
        b=NYPyzQSNUYfemJ2XcxSrw4koGYmCgU2MZQvGKkxHlVOQZFQljCGBhKEWN9p+2d87az
         lj2pQGGu5djDfXgnuey6nWwhPkg5Cj9h8JIqwVNRRgxCbboc8Z49YtXPb1bd2R2v2co+
         i0t8yOZBTPkIVUkPYu9qkqR7d9QXIMrhzd4Ta/iCclm+fQV2MuGYMp1Xl40/XtFS2wEb
         MJ5EmjDWO92khySTn4RkN6r6/DBnzFKVftGvpZsI3I5rDOF6pvw1ixpIzlXre890irCj
         P/lKRRNM7mILfcnLnWTDhVy/ezMUwwAR9cgB35GJwMXuKC4I5JFnXFD+7707+fB+z8Vm
         il0A==
X-Gm-Message-State: AOJu0YyKr5MRsbYQCvaQ03XrMP6nvy96UIIBjY5IdZX787qPZsk9Us0W
	RvVo3WYM+g5Sv2bsPoqvJ1ML3gr2wvIQ8COdQq2rWohatP/o3aFn
X-Gm-Gg: ASbGncswXXpf0zc+V4JSw5RgtaUsv5dQJO+Vlpv+lcO/glnti4HYrYWG2BYj11oolxp
	YR8g5O8zFMqKT/zdgjULB7glYkCZLHDYnyoiJ7c5ixKaMi/K5U2XkUgsNj+R1cMAut7O2ND+cOd
	Eo3ZDEJjLfiWtZWew1hxfgukVN0rM5ibxS0XhD/NbSDGng99nk44nUe2GQsZcyMoY2GkmOf6BUG
	R0prkGSOm3BJkba9yNvmbmWRNFW+Rhe71WqD7hNh58QANxPWlSAILhqJw8XU1cXvjTEktaKklCC
	u0b1XDudghp+HId+SL+T8E8N/5bfG6JoiaAxl1i6qcvH1M5vfnOXMKGImTzP2kx7Imee
X-Google-Smtp-Source: AGHT+IHOJpGMm1Mxdo9JgTFHIy19EJUYwFeIBdV6MSizySlAOWR+Yp8QZAiNI9Aji26F9WGhFOVmbw==
X-Received: by 2002:a17:902:e784:b0:220:e9ef:ec98 with SMTP id d9443c01a7336-225e0a58949mr138744465ad.19.1742213888862;
        Mon, 17 Mar 2025 05:18:08 -0700 (PDT)
Received: from localhost.localdomain ([61.173.25.243])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-225c6bbe7c1sm73445555ad.187.2025.03.17.05.18.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Mar 2025 05:18:08 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jpoimboe@kernel.org,
	peterz@infradead.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v4] selftests/bpf: Add selftest for attaching fexit to __noreturn functions
Date: Mon, 17 Mar 2025 20:17:35 +0800
Message-Id: <20250317121735.86515-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250317121735.86515-1-laoar.shao@gmail.com>
References: <20250317121735.86515-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reuslt:

  $ tools/testing/selftests/bpf/test_progs --name=fexit_noreturns
  #99/1    fexit_noreturns/noreturns:OK
  #99      fexit_noreturns:OK
  Summary: 1/1 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/fexit_noreturns.c    |  9 +++++++++
 .../testing/selftests/bpf/progs/fexit_noreturns.c | 15 +++++++++++++++
 2 files changed, 24 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c b/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
new file mode 100644
index 000000000000..568d3aa48a78
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
@@ -0,0 +1,9 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "fexit_noreturns.skel.h"
+
+void test_fexit_noreturns(void)
+{
+	RUN_TESTS(fexit_noreturns);
+}
diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
new file mode 100644
index 000000000000..54654539f550
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
@@ -0,0 +1,15 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+#include "bpf_misc.h"
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fexit/do_exit")
+__failure __msg("Attaching fexit/fmod_ret to __noreturn functions is rejected.")
+int BPF_PROG(noreturns)
+{
+	return 0;
+}
-- 
2.43.5



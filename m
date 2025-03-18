Return-Path: <bpf+bounces-54299-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E505BA672F1
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 12:45:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 080733BB43A
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 11:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0074220A5D8;
	Tue, 18 Mar 2025 11:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WKXWBszr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507C1207E12
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 11:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742298311; cv=none; b=OQ2CjotMXjDpfDxvzYAmk+CcJvswchtsGc659uhNYvHjcwr1E4xlUS4k54MFV771LbAO/9GvDYq9KlBzzkOb6IOiGpRMe3HyTmpB8mgT1qcwwJw+EyzHdb1WNk7kcwB1OXos/dghkwjjL7OaDShdLGkmHz6w30UgwXwEj0wrAyY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742298311; c=relaxed/simple;
	bh=zwEVN5zTcMw3G9CRTAJNDL9Gs+QyT1fTAemwSdAIdHY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VN8ZngKvOL2FJTqBtXivSGUSj4Vl6D5TUNx+LtNy2+Y50GWvCha2ryJbxKhBOX8qfSN/OY16mvfWWdxxSZYGZfbGdL+TY1yMaEQpEO36Yfr7PJuCvAYhDhnjCTi/POVYgerhEg/Yygxf8mYpkOamTDCLxyoOSbjLDHPKy7qf4YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WKXWBszr; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2ff784dc055so5000671a91.1
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 04:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742298305; x=1742903105; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2sViwZFqw4Dxk80MihqOntWJ5GqJszGdmQTVLIDsqs4=;
        b=WKXWBszrdq+uWbAs/+6iWbhqC4GwF6PYPqc86I42GaeGk2ywa9IvjfKqIDDcpBMPHT
         ebk9a5OH3MTTxf3ego3KxfdIzu/ZY+A4I1f/W3trlgP0lGgSObhHUWh7hGryCctVjYjJ
         F9N//7kbWO6lbth2qxoSKJkj7dY48osysUWo/n/Kb/RGfU+PnZnvZU0FHitRqUWLq2bZ
         MGsaZroJcZIuvxdzKNuW6prhWI+mghWC+xDWx8iFr2svQ7+1pe91mxt0a+aDWxd5Tt7k
         tcwTpRID0bPc542UwDPNDuQV1Z10WuGWxIeNywgu5fTE74IKFiVQxTqerUEyUEZxv9mH
         FsVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742298305; x=1742903105;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2sViwZFqw4Dxk80MihqOntWJ5GqJszGdmQTVLIDsqs4=;
        b=fsT3Spy8M4oL7bT/buPU/6gl0aFNmUyejaH5JIWzxB0Lp1aJ4nkzkXyaUUWw+gPfHA
         lnzr9eYlN9H9E0umC7GffvGLu9MLKZ8V0/4QwYPZ8IC41Nw3fRYbo/bazUTQ5U0vFcdO
         RLLzKu2QqHuRUyeqn46rmaNvEL80pNC4vcUHj9jGUDite7qPeo1MuqYxhUx5hmjG3NX5
         azDJ+tjRMXGR4lCZxBhqk8du0CCqVU6WYnfAw5buEfh8JbUvCoFHicJW+7OwhYG1Ww7O
         4cj0eYDcGdBDEjnun/fZkRRtKJmNoScrpKY4hsno8hJdq3AAg1FILRGxqfZbi93npT1H
         vuJg==
X-Gm-Message-State: AOJu0YwcIvXrn4qW++TDNTGGj06lSpTX0qbnSLR9shd5H5M3+xVi/t7r
	tRfIRr+iod3yckTG93DEyeXxLxGebtDDuf1WhHDuVQvqFd0O9cVX
X-Gm-Gg: ASbGncvAaymMOjatiUo/6W+w5s0zEMUiWt3UoQZZrAyhr1oTamPXwtEiWkc4JEJ71rL
	P8OL1L3SW5yAyJeVy2DzJvRDh6haxnOtVEmrYuhXhsEDs4dg+GEQa1KViK1RmXvzyL7owGNzGLh
	UekQwblQJTt6SjM/bIh8eBqO9MRXt7cbH9aPwZrR2pp+u+4alSbpWWh976uomTK3Zx/jUW+R+xR
	zFMI9WtfgzGrms7hAWq3wNfwmS7GYvGVc48cDYOrfStJdZzxxIojI1A4c0nAIpgoJc6Gg8HR9RL
	uGHd0cjzZVTRGN+qrsJ7uPcGMS7uGN0yPTgaOzEjvRlyZPNKlC1t4BqhSrkxlriCNTrqg0OwLQ=
	=
X-Google-Smtp-Source: AGHT+IFL9dPqLOPqUGRFrwbdz/edQ3/w5BXuhg7lpuSUsEJ6HNk1OS0mLSs/9o6UJc3F5Eo95um/5Q==
X-Received: by 2002:a17:90b:4acb:b0:2fe:994d:613b with SMTP id 98e67ed59e1d1-301a5b9a88cmr2362484a91.35.1742298305473;
        Tue, 18 Mar 2025 04:45:05 -0700 (PDT)
Received: from localhost.localdomain ([39.144.39.116])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3015353462asm7918551a91.27.2025.03.18.04.45.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Mar 2025 04:45:05 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 2/2] selftests/bpf: Add selftest for attaching fexit to __noreturn functions
Date: Tue, 18 Mar 2025 19:44:47 +0800
Message-Id: <20250318114447.75484-3-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250318114447.75484-1-laoar.shao@gmail.com>
References: <20250318114447.75484-1-laoar.shao@gmail.com>
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



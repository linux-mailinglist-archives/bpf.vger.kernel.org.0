Return-Path: <bpf+bounces-51099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE00FA30188
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 03:34:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 985673A6209
	for <lists+bpf@lfdr.de>; Tue, 11 Feb 2025 02:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833ED1B6CE9;
	Tue, 11 Feb 2025 02:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z7PqNWge"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9424426BD94
	for <bpf@vger.kernel.org>; Tue, 11 Feb 2025 02:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739241266; cv=none; b=s9D9lS0Lsfa/WYdqG4oNTKfQDCgnNCzlJK7wlTN3FYuONOHRpYib/0Oj992H9QjEhtZBgyczN3zoqAAoRZ6xCyFca6Ym+kkf4bF6SVpaibdK7/IBOdqchCJEipJNd2q62WuqWfngfwP3LbhwyetM8kF2Hek2dOS3qNL50NTNp9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739241266; c=relaxed/simple;
	bh=BZE/PnKDYiblZMpK5N3AdzMB3oXuOh3Zs/4Is1lkYgk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hZMaMCwobNLyyBFkYMNakI2y5TmFBavyXbu2GoyMkhRuxMRp/D4tqGJG7Cnr6cn9ZcefgTKXslRapM2i1XL7206v2tleiJMUlGV/6RfAJ3cuT0kiKMYNxXK1FzL/T608Mb8XSm2VJTIBuYJpRQfumDf+a03de6OCkLbdM5t/9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z7PqNWge; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2fa40c0bab2so5291842a91.0
        for <bpf@vger.kernel.org>; Mon, 10 Feb 2025 18:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739241264; x=1739846064; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rD5rT0twMykd2U4kyjeY+B65VBV99nUN8mk8Lm7kf1g=;
        b=Z7PqNWge/hFr+MKGw/m16V6mpFoFezDVhTAg6LF5/2BXHM85i2cQ1OTyxKbX48prFt
         7FT4YD7r2a0fHePrPRAn+6KXDzQ+1vdLKeRsDWq0OpOEYilNTvghMcPohLUB4ONJSXeN
         16H4g/SStKcEgWSDFq5qG0J3BxY1DShTtOvwwDyum6PZTwDLF+wmz45Uz+Zypz37VpiM
         Jeu80piEIpBnyNdIXdGaNaaCO3xTa5UIelfINM10bc86gf7fDMXLwRLDWlLIsNCyoU+C
         kf+jaSDyBzLDABjlhJwHTauTwkJjm22GSq2bIeGoKwFb7jT8UkEHC4W4nqyboFn3IRIU
         V5AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739241264; x=1739846064;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rD5rT0twMykd2U4kyjeY+B65VBV99nUN8mk8Lm7kf1g=;
        b=DKADYDOBVuyRQ7RiDLtbnLNWH8FoUdt14CaXHQnazi6eG8UtRxOGfV/VJd4YYnBghB
         +8xLrkTYGNQ116EOJNN387CLQg5hr9EY68FiMmRTj66jtUnG1QNQhzpg4IH0e5AOzXgV
         NeQtnoEX9lQuw3fX6bh75EuGBIWzzgYl79K1bNSN+Hs7KlkI3yKO1RAWt3GZUJ7pkwcF
         cpXoxw6yuzl+BhtaMWtd8l9dwaREnPnlrZ8ilS6KXDWE2uH12wwUanzJZePwn0O9XHxv
         8YllncNIFQ5wvSsDUKMD4hEN9l4tsuOhh4yZVwcUYlxmp7khkpbWtPN6QGPV11oNPMrb
         9vUQ==
X-Gm-Message-State: AOJu0YxZAnXi61K9CnP+xR/kXkH2bm0r++h5eU65PDScgIJ7t9VlyF0V
	Oz2q+yjm/k3cGk3HUmP+y/B/aai1XT3oUz8gR45weVFQPUKJE66M
X-Gm-Gg: ASbGncufnYsv42GxaN8d14MHCPlRJg8xa/tygSgLBtqNeMrRzCKatFGD1y3MUNSxgQM
	HRLDX5FagfOGLFNx+FdsXqRXx9z+V0LsBBL/Dj/GOqAh6P0I+snggLsjDgSRUlxF+vhlYS4Hu75
	l/pFmDn06ERTtSmvEObxHiZn1d3GAUX9WSPdQY6QtgR9FdC3ggvLR67VZ8Xj0UsczFe4K9R6mNI
	0mL/4XojfxonE1LQ/Fk/3F5gqcEq2rFkRHXxvTWsfHUrs8VgRVpr+05Qa2FctamDskp/g5Jy8VC
	1am0k30sfOr+veO2DWSWZvGYlde/SNWE6cqlvsk=
X-Google-Smtp-Source: AGHT+IGrt8+Z/m0kj5uJo/dBtmQTwo98sB546lXpfGZMs+AmI9f4xNxoOEzt+Xhv160mNEcK5rjx4g==
X-Received: by 2002:a17:90b:5543:b0:2ee:d63f:d71 with SMTP id 98e67ed59e1d1-2fa24069effmr29079403a91.14.1739241263742;
        Mon, 10 Feb 2025 18:34:23 -0800 (PST)
Received: from localhost.localdomain ([58.37.132.225])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f8dc43971sm30916315ad.66.2025.02.10.18.34.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 10 Feb 2025 18:34:23 -0800 (PST)
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
Subject: [PATCH bpf-next 3/3] selftests/bpf: Add selftest for attaching fexit to __noreturn functions
Date: Tue, 11 Feb 2025 10:33:59 +0800
Message-Id: <20250211023359.1570-4-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20250211023359.1570-1-laoar.shao@gmail.com>
References: <20250211023359.1570-1-laoar.shao@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The reuslt:

  $ tools/testing/selftests/bpf/test_progs --name=fexit_noreturns
  #99      fexit_noreturns:OK
  Summary: 1/0 PASSED, 0 SKIPPED, 0 FAILED

Signed-off-by: Yafang Shao <laoar.shao@gmail.com>
---
 .../selftests/bpf/prog_tests/fexit_noreturns.c      | 13 +++++++++++++
 tools/testing/selftests/bpf/progs/fexit_noreturns.c | 13 +++++++++++++
 2 files changed, 26 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
 create mode 100644 tools/testing/selftests/bpf/progs/fexit_noreturns.c

diff --git a/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c b/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
new file mode 100644
index 000000000000..588362275ed7
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/fexit_noreturns.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <test_progs.h>
+#include "fexit_noreturns.skel.h"
+
+void test_fexit_noreturns(void)
+{
+	struct fexit_noreturns *fexit_skel;
+
+	fexit_skel = fexit_noreturns__open_and_load();
+	ASSERT_NULL(fexit_skel, "fexit_load");
+	ASSERT_EQ(errno, EINVAL, "can't load fexit_noreturns");
+}
diff --git a/tools/testing/selftests/bpf/progs/fexit_noreturns.c b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
new file mode 100644
index 000000000000..003aafe2b896
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/fexit_noreturns.c
@@ -0,0 +1,13 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/bpf.h>
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+char _license[] SEC("license") = "GPL";
+
+SEC("fexit/do_exit")
+int BPF_PROG(noreturns)
+{
+	return 0;
+}
-- 
2.43.5



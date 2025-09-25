Return-Path: <bpf+bounces-69695-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B111B9EA22
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 12:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16A7F3BA778
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 10:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16EDE2EC55A;
	Thu, 25 Sep 2025 10:26:53 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45BDD2EACFB;
	Thu, 25 Sep 2025 10:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758796012; cv=none; b=LbXfpMvoUcjHCE7mE9kobnOVPrrm9KbKTB0Wom4tQNheS+o1j1DPEf0dMZXrSqa9h2yvc6mbv6IiH0Eva3AVhJWnahJGxvZw9+6Xk0f52pKqqgTwVlLP1H1FzqKSSfprhCPcF0L2rRD2W3rAEfFEoppflpMVL9tqxTNapFHlTiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758796012; c=relaxed/simple;
	bh=cmg2aP/OdJEbju4k0iOcFl8K9ZROTOnbUW84a1thBFk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QpcZ0zpcQfiH3GWttBuwaQBxqsi6ao/zaOi3O7HQsN2HTmhM36siBp1ExE+z6v/am3pasP+c8AgPLsdrAyLzKCNZzPCzcWbeoc5UQf0PtlF3lqM/vhKSUryquVpenT2tvl5BPFTPxCOzG2GP9qhqrSywAWwaaubOpb8ESOI1di8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 756F81692;
	Thu, 25 Sep 2025 03:26:42 -0700 (PDT)
Received: from e132581.arm.com (e132581.arm.com [10.1.196.87])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1165E3F694;
	Thu, 25 Sep 2025 03:26:46 -0700 (PDT)
From: Leo Yan <leo.yan@arm.com>
Date: Thu, 25 Sep 2025 11:26:28 +0100
Subject: [PATCH 4/8] perf test coresight: Dismiss clang warning for memcpy
 thread
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250925-perf_build_android_ndk-v1-4-8b35aadde3dc@arm.com>
References: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
In-Reply-To: <20250925-perf_build_android_ndk-v1-0-8b35aadde3dc@arm.com>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, 
 Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 Quentin Monnet <qmo@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, 
 Nathan Chancellor <nathan@kernel.org>, 
 Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, 
 John Fastabend <john.fastabend@gmail.com>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 James Clark <james.clark@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
 llvm@lists.linux.dev, bpf@vger.kernel.org, Leo Yan <leo.yan@arm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1758795991; l=1020;
 i=leo.yan@arm.com; s=20250604; h=from:subject:message-id;
 bh=cmg2aP/OdJEbju4k0iOcFl8K9ZROTOnbUW84a1thBFk=;
 b=N4ytt9jcTFxaCzq+v5NQwi4fvTEvMRYnevdJLt3AAyfjperNdUUMtAEB6PpbpFptkJrpnJ6/S
 97ssYz57sDlCsYcwrKXtUBomKDy6BBuZz7ULdxCKI5RbH4rHJCGlksL
X-Developer-Key: i=leo.yan@arm.com; a=ed25519;
 pk=k4BaDbvkCXzBFA7Nw184KHGP5thju8lKqJYIrOWxDhI=

clang-18.1.3 on Ubuntu 24.04.2 reports warning:

  memcpy_thread.c:30:1: warning: non-void function does not return a value in all control paths [-Wreturn-type]
     30 | }
        | ^

Dismiss the warning with returning NULL from the thread function.

Signed-off-by: Leo Yan <leo.yan@arm.com>
---
 tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
index 5f886cd09e6b3a62b5690dade94f1f8cae3279d2..7e879217be30a86431989dbf1f36d2134ef259cc 100644
--- a/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
+++ b/tools/perf/tests/shell/coresight/memcpy_thread/memcpy_thread.c
@@ -27,6 +27,8 @@ static void *thrfn(void *arg)
 	}
 	for (i = 0; i < len; i++)
 		memcpy(dst, src, a->size * 1024);
+
+	return NULL;
 }
 
 static pthread_t new_thr(void *(*fn) (void *arg), void *arg)

-- 
2.34.1



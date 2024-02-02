Return-Path: <bpf+bounces-21056-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939738471F5
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 15:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3484CB24A5D
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 14:32:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B60145359;
	Fri,  2 Feb 2024 14:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tQL0iDpE"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705FE145334;
	Fri,  2 Feb 2024 14:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706884346; cv=none; b=B0izVzBsRyh7WK6vd/b1YYyf3f7UbmaV/IiO+U7q7LIInZvA7QzdfE/bmZ7vCdtt2SDNP54bCn5M8N621ZPQDvjzM7QCi7MZeelHkkPtcSdRlSpw6xHsqF616tscp9oQ2BTD47WVgE5HFt2/OG2apiGrJhCm1DeYTUNGx7F+7e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706884346; c=relaxed/simple;
	bh=Lmfieud73BcgseATjFSGPCLch3+jpSxrJB6K0BO3xmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=JjWunds9Z/+Ywbs1ETb6k5elCC6RLT1Qtnnjsu7zzvYw1EFfGN2+CBzVxBXr1oQq9syDVnB9T9qb36ny6WAofE6nHI2GVdftNY8dO69HhjiQz2qpn2e+4UUTNF/DLOwYpGSLtm33Toa0+agt5wpCSRsBbCAHcIeN1YeP95LOTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tQL0iDpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F7BC433F1;
	Fri,  2 Feb 2024 14:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706884343;
	bh=Lmfieud73BcgseATjFSGPCLch3+jpSxrJB6K0BO3xmI=;
	h=Date:From:To:Cc:Subject:From;
	b=tQL0iDpEH8IIJNf858ZIKK20QpdNal19Z1ayr5RRTbxI4DDGdJ8+bstfkgab5JgE4
	 ERNPM6+Gfi3xJinj2D1lvnGd+gzSz3lcUXh8NMjrmTwhu9GpguN6RIADgDMtDoCedt
	 q2tBbwwIxKJy2W0TkEJ2kKGT/NhNEBnqN2aLUXRgGlKpa2bj71jPXo1wGeh52EYG1X
	 R5RYSZhEI4J3yBmYPNx4TJGYU0dHnIGUeXR77fYmNEuptgqgkHJXXU6QiCt3AEjpld
	 gdFYte/Uyho3ZfuGzKsnpgmM5vwQdoEb1HxEUYAKXp4Fj/z/I2MTiMpfN9hhdTgCUD
	 3nq1Tf2wb7FnA==
Date: Fri, 2 Feb 2024 11:32:20 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>, Ian Rogers <irogers@google.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
	Ingo Molnar <mingo@redhat.com>, James Clark <james.clark@arm.com>,
	Jiri Olsa <jolsa@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Yang Jihong <yangjihong1@huawei.com>, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf bpf: Clean up the generated/copied vmlinux.h
Message-ID: <Zbz89KK5wHfZ82jv@x1>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

When building perf with BPF skels we either copy the minimalistic
tools/perf/util/bpf_skel/vmlinux/vmlinux.h or use bpftool to generate a
vmlinux from BTF, storing the result in $(SKEL_OUT)/vmlinux.h.

We need to remove that when doing a 'make -C tools/perf clean', fix it.

Fixes: b7a2d774c9c5a9a3 ("perf build: Add ability to build with a generated vmlinux.h")
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: James Clark <james.clark@arm.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Tiezhu Yang <yangtiezhu@loongson.cn>
Cc: Yang Jihong <yangjihong1@huawei.com>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Makefile.perf | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/Makefile.perf b/tools/perf/Makefile.perf
index 27e7c478880fdecd..51ac396ed9f641af 100644
--- a/tools/perf/Makefile.perf
+++ b/tools/perf/Makefile.perf
@@ -1157,7 +1157,7 @@ bpf-skel:
 endif # CONFIG_PERF_BPF_SKEL
 
 bpf-skel-clean:
-	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS)
+	$(call QUIET_CLEAN, bpf-skel) $(RM) -r $(SKEL_TMP_OUT) $(SKELETONS) $(SKEL_OUT)/vmlinux.h
 
 clean:: $(LIBAPI)-clean $(LIBBPF)-clean $(LIBSUBCMD)-clean $(LIBSYMBOL)-clean $(LIBPERF)-clean arm64-sysreg-defs-clean fixdep-clean python-clean bpf-skel-clean tests-coresight-targets-clean
 	$(call QUIET_CLEAN, core-objs)  $(RM) $(LIBPERF_A) $(OUTPUT)perf-archive $(OUTPUT)perf-iostat $(LANG_BINDINGS)
-- 
2.43.0



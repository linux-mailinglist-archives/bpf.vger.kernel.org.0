Return-Path: <bpf+bounces-26685-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B7C8A37C6
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B8506282704
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B60DE15217C;
	Fri, 12 Apr 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YyV47hoy"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF6614F12A;
	Fri, 12 Apr 2024 21:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956602; cv=none; b=bRpNSVqPrAsWAt6dk2gvXTrHLYzINuA0nzF4/ESTquhYZU/WsYmlWrNZXdCI9IiCa4Nct7Q6MOEZkVjNeUhGs21mP9yblLvy0mq5gQILiuZ/R5RMrJErlkksNuyupkzwTC+PE5s6rg6gGp1XDAtNzk4zBY/mwO9ETuRQRvWYHj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956602; c=relaxed/simple;
	bh=w7hwgkzrUbZqiWKsRGTQDtzfq+Myzi8KNFzNsNgtgO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dgem2DgponosRuCW0sePMrxOpWgb62xcghSpursmqTup1k5FAPOhamjMUtiDdxxDFs54o9l8Fg8fEnh5pkb5q8/EZAqU6kVibkrQj6AWxmj4g3s+xlqMNkMpQMbMtVNHWHO5/bFu3leYQVP0BacX+7Y8V6jD8Mv3ZUCSxhThD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YyV47hoy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0398C113CD;
	Fri, 12 Apr 2024 21:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712956602;
	bh=w7hwgkzrUbZqiWKsRGTQDtzfq+Myzi8KNFzNsNgtgO0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YyV47hoyLGaFy3vUTUjr1dFtIO+5UruC/KQc+sPgPZYCd6wsjj30vE4eEMm9p7vkl
	 W9/Wqh1y0+a5ZCFjqCIsE5qF3kCOpklIzOzYD2AL4sn98EKYIu7AdT/59FArAEPCis
	 jl/EzD/8xaRvZpSjygYNI6ZNK7fnBtdjQswTI8nc2smuMe9cMSe5S7j2Fd6QSqipsR
	 ZfN7YPvUL1aI6uR1ZcNHteKeHnRKzX6X0GW3lOY4r9K6avyTjkmH3mzDjEbygPhsAu
	 pJ4sH8bTU60zMHiWRFRa1HKHtz/uaUVhMO8WRhwpSf7tyU+CHB1nDa+o7ryVQyniHX
	 5YTpSzHYlXwIQ==
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: dwarves@vger.kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Clark Williams <williams@redhat.com>,
	Kate Carcia <kcarcia@redhat.com>,
	bpf@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Kui-Feng Lee <kuifeng@fb.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH 12/12] tests: Add a BTF reproducible generation test
Date: Fri, 12 Apr 2024 18:16:04 -0300
Message-ID: <20240412211604.789632-13-acme@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240412211604.789632-1-acme@kernel.org>
References: <20240412211604.789632-1-acme@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arnaldo Carvalho de Melo <acme@redhat.com>

  $ time tests/reproducible_build.sh vmlinux
  Parallel reproducible DWARF Loading/Serial BTF encoding: Ok

  real  1m13.844s
  user  3m3.601s
  sys   0m9.049s
  $

If the number of threads started by pahole is different than what was
requests via its -j command line option, it will fail as well as if the
output of 'bpftool btf dump' differs from the BTF encoded totally
serially to one of the detached BTF encoded using reproducible DWARF
loading/BTF encoding.

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Kui-Feng Lee <kuifeng@fb.com>
Cc: Thomas Weißschuh <linux@weissschuh.net>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tests/reproducible_build.sh | 56 +++++++++++++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100755 tests/reproducible_build.sh

diff --git a/tests/reproducible_build.sh b/tests/reproducible_build.sh
new file mode 100755
index 0000000000000000..9c72d548c2a21136
--- /dev/null
+++ b/tests/reproducible_build.sh
@@ -0,0 +1,56 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Test if BTF generated serially matches reproducible parallel DWARF loading + serial BTF encoding
+# Arnaldo Carvalho de Melo <acme@redhat.com> (C) 2024-
+
+vmlinux=$1
+outdir=$(mktemp -d /tmp/reproducible_build.sh.XXXXXX)
+
+echo -n "Parallel reproducible DWARF Loading/Serial BTF encoding: "
+
+test -n "$VERBOSE" && printf "\nserial encoding...\n"
+
+pahole --btf_encode_detached=$outdir/vmlinux.btf.serial $vmlinux
+bpftool btf dump file $outdir/vmlinux.btf.serial > $outdir/bpftool.output.vmlinux.btf.serial
+
+nr_proc=$(getconf _NPROCESSORS_ONLN)
+
+for threads in $(seq $nr_proc) ; do
+	test -n "$VERBOSE" && echo $threads threads encoding
+	pahole -j$threads --reproducible_build --btf_encode_detached=$outdir/vmlinux.btf.parallel.reproducible $vmlinux &
+	pahole=$!
+	# HACK: Wait a bit for pahole to start its threads
+	sleep 0.3s
+	# PID part to remove ps output headers
+	nr_threads_started=$(ps -L -C pahole | grep -v PID | wc -l)
+
+	if [ $threads -gt 1 ] ; then
+		((nr_threads_started -= 1))
+	fi
+
+	if [ $threads != $nr_threads_started ] ; then
+		echo "ERROR: pahole asked to start $threads encoding threads, started $nr_threads_started"
+		exit 1;
+	fi
+
+	# ps -L -C pahole | grep -v PID | nl
+	test -n "$VERBOSE" && echo $nr_threads_started threads started
+	wait $pahole
+	rm -f $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
+	bpftool btf dump file $outdir/vmlinux.btf.parallel.reproducible > $outdir/bpftool.output.vmlinux.btf.parallel.reproducible
+	test -n "$VERBOSE" && echo "diff from serial encoding:"
+	diff -u $outdir/bpftool.output.vmlinux.btf.serial $outdir/bpftool.output.vmlinux.btf.parallel.reproducible > $outdir/diff
+	if [ -s $outdir/diff ] ; then
+		echo "ERROR: BTF generated from DWARF in parallel is different from the one generated in serial!"
+		exit 1
+	fi
+	test -n "$VERBOSE" && echo -----------------------------
+done
+
+rm $outdir/*
+rmdir $outdir
+
+echo "Ok"
+
+exit 0
-- 
2.44.0



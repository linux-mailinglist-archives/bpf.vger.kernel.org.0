Return-Path: <bpf+bounces-33832-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1061926B97
	for <lists+bpf@lfdr.de>; Thu,  4 Jul 2024 00:31:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6416B1F2200E
	for <lists+bpf@lfdr.de>; Wed,  3 Jul 2024 22:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74E41957E1;
	Wed,  3 Jul 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MXi/DYt5"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7A2194C89;
	Wed,  3 Jul 2024 22:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720045840; cv=none; b=kMxjOMevjnGP0UOdIYmflkEXGLo43bunIobUNSTfbx90DHX5IqTzxszhtNTXtBnslQhf5pYOBnDN6EKhDrU7tpU7LWQ+KufGuDME4pXIeTBe2WQxGAmVs+KL8t0GMFeITJnyI8Bmb40fvMsGYBVYn7x2uIt+nSewBiNQW3tqw74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720045840; c=relaxed/simple;
	bh=kZ93U42Z5rdhAzkA89N6ZJLmQFKP6A1rbOARut3nIvU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvuIQ/sG0HzmSw3TRk1ZiPa2zodcujOkpN8e7R+i12Cxc3ucguhPP/oypbzzViMPeRmXP5YV2C9CKImA/IpL3U3KlQDoAkxSdrwReALQwRFp3l6WD13aHUFvgU7+h1PJzUcVQ5sNdZ/Wx/i2om90UO5QVTQ9KtxNxQSCigZfWpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MXi/DYt5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD8C6C4AF11;
	Wed,  3 Jul 2024 22:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720045840;
	bh=kZ93U42Z5rdhAzkA89N6ZJLmQFKP6A1rbOARut3nIvU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MXi/DYt59dPOopqj7vtOmRmZvktaiiKTdSmLSuSh8/XfJ93eyT/cpA3aQ9rFV1n1D
	 At8OP7Gl6PAiOgjmuHOTVqhVsutMoqOSGsw689S3zrUlAHRAf6XsqHD34Af6CVOjJ8
	 Qgv15Vcr6bAGcTX3G9mI1mbb0kDg3670vmL5PN5i0TIOqc3zgyEufUvVMt3+PHsEHs
	 Ub8akaymT7+gIjxryZq7mb6LrTdolnrAr+8vbdnAbXBuSc0vHT6ExC8iz5tQRdJikP
	 AGJubAEnEQqIuvKbEvvRrY78ACxuvoY0bnv2YrbU6iehdrgFfU4y/O0+RZHO45KyQU
	 kz6TKjo6IFUlg==
From: Namhyung Kim <namhyung@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Kan Liang <kan.liang@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org,
	KP Singh <kpsingh@kernel.org>,
	Song Liu <song@kernel.org>,
	bpf@vger.kernel.org,
	Stephane Eranian <eranian@google.com>
Subject: [PATCH v3 6/8] perf record: Fix a potential error handling issue
Date: Wed,  3 Jul 2024 15:30:33 -0700
Message-ID: <20240703223035.2024586-7-namhyung@kernel.org>
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
In-Reply-To: <20240703223035.2024586-1-namhyung@kernel.org>
References: <20240703223035.2024586-1-namhyung@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The evlist is allocated at the beginning of cmd_record().  Also free-ing
thread masks should be paired with record__init_thread_masks() which is
called right before __cmd_record().

Let's change the order of these functions to release the resources
correctly in case of errors.  This is maybe fine as the process exits,
but it might be a problem if it manages some system-wide resources that
live longer than the process.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
---
 tools/perf/builtin-record.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e855a7688008..a473000f3599 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -4242,13 +4242,13 @@ int cmd_record(int argc, const char **argv)
 
 	err = __cmd_record(&record, argc, argv);
 out:
-	evlist__delete(rec->evlist);
+	record__free_thread_masks(rec, rec->nr_threads);
+	rec->nr_threads = 0;
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
 out_opts:
-	record__free_thread_masks(rec, rec->nr_threads);
-	rec->nr_threads = 0;
 	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
+	evlist__delete(rec->evlist);
 	return err;
 }
 
-- 
2.45.2.803.g4e1b14247a-goog



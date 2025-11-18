Return-Path: <bpf+bounces-74835-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EEDDEC66C2E
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 01:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 41E0535D1EF
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 00:56:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 177D130505E;
	Tue, 18 Nov 2025 00:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b="JvscoTbQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B2A27A477
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 00:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763427204; cv=none; b=PKUYYetTybV2NEtxDii0ulwJ4iBJOl3N8p479Ec2iHljGqmz7TFCoJDcX88mNTUG9VKSlDiYA9b9ZxjxKwgMrZpUs63vx2andfh9x09uQZQpnhTVRNZQO/U8T2GuFtWpoVefLifkPAcIaoImQmLKgI7IqxiRZqvZeoWlOog5YC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763427204; c=relaxed/simple;
	bh=bYg9W5ytxqP3va7/Mt58QSRe2gIW+N5yE8QuKYrEGq4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JyjX3UTMCLIV57tE4jwdo9/ZD6CmwjrLD9Hs/27oHmeBgHeX/6s69B9X23zqSrnrs93SibtEUHCPet9VrE6eJJN2mf7Vuc0UV9nk2SZyNfkCxkHQyGa3VeQU7gbRiU/ObG/JKYA7PXn77WMcv81NcgcdFIaQ0gmvUQdEsbqYv3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io; spf=none smtp.mailfrom=jrife.io; dkim=pass (2048-bit key) header.d=jrife-io.20230601.gappssmtp.com header.i=@jrife-io.20230601.gappssmtp.com header.b=JvscoTbQ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=jrife.io
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=jrife.io
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b63e5da0fdeso449845a12.0
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 16:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jrife-io.20230601.gappssmtp.com; s=20230601; t=1763427200; x=1764032000; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0fy47l5qUKB/Fc1GgcEEdT+++QBTiwMB6PPYQ5ZBX3s=;
        b=JvscoTbQ7uVgVBB5WZzd828iYXVzYQO1WvokDtFi25tWwpwwB0EHknlFKzMU8CcG1z
         Aep0xdwyeZRak0LSN23sjmsP6Y5+r1aTrnduSKz4cQGr+mn5tMgT21/o7zyw7N8PP5ET
         o+YXx/W6qKMcfKDcaYH/3NdjQCBwsGj7GZ4oIuw+HfthZ4J0OvKgc8it8Y/cWC/0/QqW
         tmx7eNrkQk/yf51a8rJmE903Poz0j6tf6VfmniJ6v9pOstfV6ZUMISO9Lm6vc1qkzqgr
         2rjB80g4j9CO7pP9THmXyheR2In/J5A/iQRxc5/L3PzSHlR0tOT5CKxzHVshSLayIPp0
         n8hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763427200; x=1764032000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0fy47l5qUKB/Fc1GgcEEdT+++QBTiwMB6PPYQ5ZBX3s=;
        b=tYAJ9x90KKt59j37tsOjmnnKKTBrHEgT8gFSotS0RBpmGir9x5lPv4ZwiU2nRkKDNC
         e84nPAQ57cGTk0q0PSf0Jvk1X1cE0YziFL+rqnQzeD6wP+fGuYcMWJszthw2yBtS/PB5
         DmiGECsOp6XyOuI0mOYErGRu7/bJG5qRniT19MDABMBIdSl3aA9JovRaAmeE2YhDh/6c
         YA9BkA/WQhuOQDXjfQjKtpMQlRktPqS2xHaM2MaYmRhHQzQVImf7mnPQfTeDsIAiDNZN
         DPCqGVr6z3bCT9W3LwFiPowLohhTsV4LEz8LahVTkVcDHlDeJPdYR3jW3bP0qPdaVB0t
         GWtA==
X-Gm-Message-State: AOJu0YypWw1BJsjUpYIYKZDOfs5vPOGM0faDI6o/Edpgd99sG7ycX+4L
	mD7pjNrZx1qocMrDofe5MyTMTwtEFkLUkbIRn+IheDqzfzLRF9lsL6va4br+1zXmSoilXzRYYhD
	9p/Cl
X-Gm-Gg: ASbGnctAfGJ8bx3hcTLeEAsZU6RD/YgSmOFt7e/DIMFFK8sv3lhRMS5wV25lqql4rS+
	h3864IYF3niQAcwZiN3MZlBw6CcEFO3I87ZfadLmLsgw5qH4Yt9dedpnSQnVjnYoDINilor+vN7
	ugGFIymJFRaCfV4DvWTrwMI7jeVzX5/WNCMGS3nsO+lKGvx0EdvIb2kgeJ4v17FXjb9Zgx0KDD0
	XzsXmz50urGqgdFBTEGG5Ofn0ScIEC2wfy712p2nK+n/lZnV24XGgZaLutJZF972xj9jo81355P
	yXO6173AfToIjdCoCaIuvmQgb2bq3RATrIdRi582Nt7t3Hh53X9v5t9lAsHMb4/gO3H8Q87dtyo
	ZYRlXvPfPr3itlSxnjFYMrjKZkZr9MWXB306U8iN2dzVlGzw5W7ja5uG1G9dkUTrH4Zu0J1diQW
	I=
X-Google-Smtp-Source: AGHT+IGS8MH+4wG4TpRMM5bDLUzpAWdnYKva3ibohJVmCcSnJJTwjXokFdlN1Sv5ke7Pv7ajvAjq5A==
X-Received: by 2002:a05:693c:4096:b0:2a6:9dbf:bbe1 with SMTP id 5a478bee46e88-2a6c9b916b3mr234570eec.3.1763427199710;
        Mon, 17 Nov 2025 16:53:19 -0800 (PST)
Received: from t14.. ([2001:5a8:47ec:d700:ef59:f68f:7ffe:54f2])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49d9ead79sm67568555eec.1.2025.11.17.16.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 16:53:19 -0800 (PST)
From: Jordan Rife <jordan@jrife.io>
To: bpf@vger.kernel.org
Cc: Jordan Rife <jordan@jrife.io>,
	linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org,
	x86@kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Ingo Molnar <mingo@redhat.com>
Subject: [RFC PATCH bpf-next 7/7] selftests/bpf: Test BPF_LINK_UPDATE behavior for tracing links
Date: Mon, 17 Nov 2025 16:52:59 -0800
Message-ID: <20251118005305.27058-8-jordan@jrife.io>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118005305.27058-1-jordan@jrife.io>
References: <20251118005305.27058-1-jordan@jrife.io>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Exercise a series of edge cases and happy path scenarios across a gamut
of link types (fentry, fmod_ret, fexit, freplace) to test
BPF_LINK_UPDATE behavior for tracing links. This test swaps
fentry/fmod_ret/fexit programs in-place and makes sure that the sequence
and attach cookie are as expected based on the link positions.

Signed-off-by: Jordan Rife <jordan@jrife.io>
---
 .../bpf/prog_tests/prog_update_tracing.c      | 460 ++++++++++++++++++
 .../selftests/bpf/progs/prog_update_tracing.c | 133 +++++
 2 files changed, 593 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/prog_update_tracing.c
 create mode 100644 tools/testing/selftests/bpf/progs/prog_update_tracing.c

diff --git a/tools/testing/selftests/bpf/prog_tests/prog_update_tracing.c b/tools/testing/selftests/bpf/prog_tests/prog_update_tracing.c
new file mode 100644
index 000000000000..0b1e0d780c82
--- /dev/null
+++ b/tools/testing/selftests/bpf/prog_tests/prog_update_tracing.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <network_helpers.h>
+#include <test_progs.h>
+#include "prog_update_tracing.skel.h"
+#include "test_pkt_access.skel.h"
+
+static bool assert_program_order(struct prog_update_tracing *skel_trace,
+				 struct test_pkt_access *skel_pkt,
+				 const struct prog_update_tracing__bss *expected)
+{
+	LIBBPF_OPTS(bpf_test_run_opts, topts_trace);
+	LIBBPF_OPTS(bpf_test_run_opts, topts_skb,
+		.data_in = &pkt_v4,
+		.data_size_in = sizeof(pkt_v4),
+		.repeat = 1,
+	);
+	int prog_fd;
+
+	prog_fd = bpf_program__fd(skel_trace->progs.fmod_ret1);
+	if (!ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &topts_trace),
+		       "bpf_prog_test_run trace"))
+		return false;
+
+	if (!ASSERT_EQ(skel_trace->bss->fentry1_seq,
+		       expected->fentry1_seq, "fentry1_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fentry1_cookie,
+		       expected->fentry1_cookie, "fentry1_cookie"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fentry2_seq,
+		       expected->fentry2_seq, "fentry2_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fentry2_cookie,
+		       expected->fentry2_cookie, "fentry2_cookie"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fmod_ret1_seq,
+		       expected->fmod_ret1_seq, "fmod_ret1_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fmod_ret1_cookie,
+		       expected->fmod_ret1_cookie, "fmod_ret1_cookie"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fmod_ret2_seq,
+		       expected->fmod_ret2_seq, "fmod_ret2_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fmod_ret2_cookie,
+		       expected->fmod_ret2_cookie, "fmod_ret2_cookie"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fexit1_seq,
+		       expected->fexit1_seq, "fexit1_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fexit1_cookie,
+		       expected->fexit1_cookie, "fexit1_cookie"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fexit2_seq,
+		       expected->fexit2_seq, "fexit2_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fexit2_cookie,
+		       expected->fexit2_cookie, "fexit2_cookie"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->sequence, expected->sequence,
+		       "sequence"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->sequence_bpf, 0, "sequence_bpf"))
+		return false;
+
+	prog_fd = bpf_program__fd(skel_pkt->progs.test_pkt_access);
+	if (!ASSERT_OK(bpf_prog_test_run_opts(prog_fd, &topts_skb),
+		       "bpf_prog_test_run skb"))
+		return false;
+
+	if (!ASSERT_EQ(skel_trace->bss->sequence, expected->sequence,
+		       "sequence"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fentry1_bpf_seq,
+		       expected->fentry1_bpf_seq, "fentry1_bpf_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fentry1_bpf_cookie,
+		       expected->fentry1_bpf_cookie, "fentry1_bpf_cookie"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fentry2_bpf_seq,
+		       expected->fentry2_bpf_seq, "fentry2_bpf_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fentry2_bpf_cookie,
+		       expected->fentry2_bpf_cookie, "fentry2_bpf_cookie"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->freplace1_bpf_seq,
+		       expected->freplace1_bpf_seq, "freplace1_bpf_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->freplace2_bpf_seq,
+		       expected->freplace2_bpf_seq, "freplace2_bpf_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fexit1_bpf_seq,
+		       expected->fexit1_bpf_seq, "fexit1_bpf_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fexit1_bpf_cookie,
+		       expected->fexit1_bpf_cookie, "fexit1_bpf_cookie"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fexit2_bpf_seq,
+		       expected->fexit2_bpf_seq, "fexit2_bpf_seq"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->fexit2_bpf_cookie,
+		       expected->fexit2_bpf_cookie, "fexit2_bpf_cookie"))
+		return false;
+	if (!ASSERT_EQ(skel_trace->bss->sequence_bpf, expected->sequence_bpf,
+		       "sequence_bpf"))
+		return false;
+
+	memset(skel_trace->bss, 0, sizeof(*skel_trace->bss));
+
+	return true;
+}
+
+void test_prog_update_tracing(void)
+{
+	const struct prog_update_tracing__bss expected_inverted = {
+		.fentry1_seq = 2,
+		.fentry1_cookie = 102,
+		.fentry2_seq = 1,
+		.fentry2_cookie = 101,
+		.fmod_ret1_seq = 4,
+		.fmod_ret1_cookie = 104,
+		.fmod_ret2_seq = 3,
+		.fmod_ret2_cookie = 103,
+		.fexit1_seq = 6,
+		.fexit1_cookie = 106,
+		.fexit2_seq = 5,
+		.fexit2_cookie = 105,
+		.sequence = 6,
+		.fentry1_bpf_seq = 2,
+		.fentry1_bpf_cookie = 202,
+		.fentry2_bpf_seq = 1,
+		.fentry2_bpf_cookie = 201,
+		.freplace1_bpf_seq = 3,
+		.freplace2_bpf_seq = 0,
+		.fexit1_bpf_seq = 5,
+		.fexit1_bpf_cookie = 205,
+		.fexit2_bpf_seq = 4,
+		.fexit2_bpf_cookie = 204,
+		.sequence_bpf = 5,
+	};
+	const struct prog_update_tracing__bss expected_normal = {
+		.fentry1_seq = 1,
+		.fentry1_cookie = 101,
+		.fentry2_seq = 2,
+		.fentry2_cookie = 102,
+		.fmod_ret1_seq = 3,
+		.fmod_ret1_cookie = 103,
+		.fmod_ret2_seq = 4,
+		.fmod_ret2_cookie = 104,
+		.fexit1_seq = 5,
+		.fexit1_cookie = 105,
+		.fexit2_seq = 6,
+		.fexit2_cookie = 106,
+		.sequence = 6,
+		.fentry1_bpf_seq = 1,
+		.fentry1_bpf_cookie = 201,
+		.fentry2_bpf_seq = 2,
+		.fentry2_bpf_cookie = 202,
+		.freplace1_bpf_seq = 3,
+		.freplace2_bpf_seq = 0,
+		.fexit1_bpf_seq = 4,
+		.fexit1_bpf_cookie = 204,
+		.fexit2_bpf_seq = 5,
+		.fexit2_bpf_cookie = 205,
+		.sequence_bpf = 5,
+	};
+	LIBBPF_OPTS(bpf_link_update_opts, update_opts);
+	LIBBPF_OPTS(bpf_trace_opts, trace_opts);
+	struct prog_update_tracing *skel_trace1 = NULL;
+	struct prog_update_tracing *skel_trace2 = NULL;
+	struct test_pkt_access *skel_pkt1 = NULL;
+	struct test_pkt_access *skel_pkt2 = NULL;
+	int link_fd, prog_fd, err;
+	struct bpf_link *link;
+
+	skel_trace1 = prog_update_tracing__open();
+	if (!ASSERT_OK_PTR(skel_trace1, "skel_trace1"))
+		goto cleanup;
+	skel_pkt1 = test_pkt_access__open_and_load();
+	if (!ASSERT_OK_PTR(skel_pkt1, "skel_pkt1"))
+		goto cleanup;
+	prog_fd = bpf_program__fd(skel_pkt1->progs.test_pkt_access);
+	bpf_program__set_attach_target(skel_trace1->progs.fentry1_bpf, prog_fd,
+				       NULL);
+	bpf_program__set_attach_target(skel_trace1->progs.fentry2_bpf, prog_fd,
+				       NULL);
+	bpf_program__set_attach_target(skel_trace1->progs.fexit1_bpf, prog_fd,
+				       NULL);
+	bpf_program__set_attach_target(skel_trace1->progs.fexit2_bpf, prog_fd,
+				       NULL);
+	bpf_program__set_attach_target(skel_trace1->progs.freplace1_bpf,
+				       prog_fd, "test_pkt_access_subprog3");
+	bpf_program__set_attach_target(skel_trace1->progs.freplace2_bpf,
+				       prog_fd, "test_pkt_access_subprog3");
+	bpf_program__set_attach_target(skel_trace1->progs.freplace3_bpf,
+				       prog_fd, "get_skb_ifindex");
+	err = prog_update_tracing__load(skel_trace1);
+	if (!ASSERT_OK(err, "skel_trace1 load"))
+		goto cleanup;
+	trace_opts.cookie = expected_normal.fentry2_cookie;
+	link = bpf_program__attach_trace_opts(skel_trace1->progs.fentry2,
+					      &trace_opts);
+	if (!ASSERT_OK_PTR(link, "attach fentry2"))
+		goto cleanup;
+	skel_trace1->links.fentry2 = link;
+	trace_opts.cookie = expected_normal.fentry1_cookie;
+	link = bpf_program__attach_trace_opts(skel_trace1->progs.fentry1,
+					      &trace_opts);
+	if (!ASSERT_OK_PTR(link, "attach fentry1"))
+		goto cleanup;
+	skel_trace1->links.fentry1 = link;
+	trace_opts.cookie = expected_normal.fmod_ret2_cookie;
+	link = bpf_program__attach_trace_opts(skel_trace1->progs.fmod_ret2,
+					      &trace_opts);
+	if (!ASSERT_OK_PTR(link, "attach fmod_ret2"))
+		goto cleanup;
+	skel_trace1->links.fmod_ret2 = link;
+	trace_opts.cookie = expected_normal.fmod_ret1_cookie;
+	link = bpf_program__attach_trace_opts(skel_trace1->progs.fmod_ret1,
+					      &trace_opts);
+	if (!ASSERT_OK_PTR(link, "attach fmod_ret1"))
+		goto cleanup;
+	skel_trace1->links.fmod_ret1 = link;
+	trace_opts.cookie = expected_normal.fexit2_cookie;
+	link = bpf_program__attach_trace_opts(skel_trace1->progs.fexit2,
+					      &trace_opts);
+	if (!ASSERT_OK_PTR(link, "attach fexit2"))
+		goto cleanup;
+	skel_trace1->links.fexit2 = link;
+	trace_opts.cookie = expected_normal.fexit1_cookie;
+	link = bpf_program__attach_trace_opts(skel_trace1->progs.fexit1,
+					      &trace_opts);
+	if (!ASSERT_OK_PTR(link, "attach fexit1"))
+		goto cleanup;
+	skel_trace1->links.fexit1 = link;
+	trace_opts.cookie = expected_normal.fentry2_bpf_cookie;
+	link = bpf_program__attach_trace_opts(skel_trace1->progs.fentry2_bpf,
+					      &trace_opts);
+	if (!ASSERT_OK_PTR(link, "attach fentry2_bpf"))
+		goto cleanup;
+	skel_trace1->links.fentry2_bpf = link;
+	trace_opts.cookie = expected_normal.fentry1_bpf_cookie;
+	link = bpf_program__attach_trace_opts(skel_trace1->progs.fentry1_bpf,
+					      &trace_opts);
+	if (!ASSERT_OK_PTR(link, "attach fentry1_bpf"))
+		goto cleanup;
+	skel_trace1->links.fentry1_bpf = link;
+	trace_opts.cookie = expected_normal.fexit2_bpf_cookie;
+	link = bpf_program__attach_trace_opts(skel_trace1->progs.fexit2_bpf,
+					      &trace_opts);
+	if (!ASSERT_OK_PTR(link, "attach fexit2_bpf"))
+		goto cleanup;
+	skel_trace1->links.fexit2_bpf = link;
+	trace_opts.cookie = expected_normal.fexit1_bpf_cookie;
+	link = bpf_program__attach_trace_opts(skel_trace1->progs.fexit1_bpf,
+					      &trace_opts);
+	if (!ASSERT_OK_PTR(link, "attach fexit1_bpf"))
+		goto cleanup;
+	skel_trace1->links.fexit1_bpf = link;
+	link = bpf_program__attach_trace(skel_trace1->progs.freplace1_bpf);
+	if (!ASSERT_OK_PTR(link, "attach freplace1_bpf"))
+		goto cleanup;
+	skel_trace1->links.freplace1_bpf = link;
+	if (!assert_program_order(skel_trace1, skel_pkt1, &expected_normal))
+		goto cleanup;
+
+	/* Program update should fail if expected_attach_type is a mismatch. */
+	err = bpf_link__update_program(skel_trace1->links.fentry1,
+				       skel_trace1->progs.fexit1);
+	if (!ASSERT_EQ(err, -EINVAL,
+		       "fentry1 update wrong expected_attach_type"))
+		goto cleanup;
+	if (!assert_program_order(skel_trace1, skel_pkt1, &expected_normal))
+		goto cleanup;
+
+	/* Program update should fail if type is a mismatch. */
+	err = bpf_link__update_program(skel_trace1->links.fentry1,
+				       skel_pkt1->progs.test_pkt_access);
+	if (!ASSERT_EQ(err, -EINVAL, "fentry1 update wrong type"))
+		goto cleanup;
+	if (!assert_program_order(skel_trace1, skel_pkt1, &expected_normal))
+		goto cleanup;
+
+	/* Program update should fail if program is incompatible */
+	err = bpf_link__update_program(skel_trace1->links.freplace1_bpf,
+				       skel_trace1->progs.freplace3_bpf);
+	if (!ASSERT_EQ(err, -EINVAL, "freplace1_bpf update incompatible"))
+		goto cleanup;
+	if (!assert_program_order(skel_trace1, skel_pkt1, &expected_normal))
+		goto cleanup;
+
+	/* Update with BPF_F_REPLACE should fail if old_prog_fd does not match
+	 * current link program.
+	 */
+	prog_fd = bpf_program__fd(skel_trace1->progs.fentry2);
+	link_fd = bpf_link__fd(skel_trace1->links.fentry1);
+	update_opts.old_prog_fd = bpf_program__fd(skel_trace1->progs.fentry2);
+	update_opts.flags = BPF_F_REPLACE;
+	err = bpf_link_update(link_fd, prog_fd, &update_opts);
+	if (!ASSERT_EQ(err, -EPERM, "BPF_F_REPLACE EPERM"))
+		goto cleanup;
+	if (!assert_program_order(skel_trace1, skel_pkt1, &expected_normal))
+		goto cleanup;
+
+	/* Do an in-place swap of program order using link updates.
+	 *
+	 * Update with BPF_F_REPLACE should succeed if old_prog_fd matches
+	 * current link program.
+	 * Update should succeed if the new program's dst_trampoline has been
+	 * cleared by a previous attach operation.
+	 */
+	update_opts.old_prog_fd = bpf_program__fd(skel_trace1->progs.fentry1);
+	err = bpf_link_update(link_fd, prog_fd, &update_opts);
+	if (!ASSERT_OK(err, "BPF_F_REPLACE"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fentry2,
+				       skel_trace1->progs.fentry1);
+	if (!ASSERT_OK(err, "fentry2 update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fmod_ret1,
+				       skel_trace1->progs.fmod_ret2);
+	if (!ASSERT_OK(err, "fmod_ret1 update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fmod_ret2,
+				       skel_trace1->progs.fmod_ret1);
+	if (!ASSERT_OK(err, "fmod_ret2 update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fexit1,
+				       skel_trace1->progs.fexit2);
+	if (!ASSERT_OK(err, "fexit1 update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fexit2,
+				       skel_trace1->progs.fexit1);
+	if (!ASSERT_OK(err, "fexit2 update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fentry1_bpf,
+				       skel_trace1->progs.fentry2_bpf);
+	if (!ASSERT_OK(err, "fentry1_bpf update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fentry2_bpf,
+				       skel_trace1->progs.fentry1_bpf);
+	if (!ASSERT_OK(err, "fentry2_bpf update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fexit1_bpf,
+				       skel_trace1->progs.fexit2_bpf);
+	if (!ASSERT_OK(err, "fexit1_bpf update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fexit2_bpf,
+				       skel_trace1->progs.fexit1_bpf);
+	if (!ASSERT_OK(err, "fexit2_bpf update"))
+		goto cleanup;
+	/* Only one freplace program can be attached at a time, so instead of
+	 * swapping the order as with fentry/fmod_ret/fexit just shuffle
+	 * freplace1_bpf and freplace_bpf2.
+	 */
+	err = bpf_link__destroy(skel_trace1->links.freplace1_bpf);
+	if (!ASSERT_OK(err, "freplace1_bpf destroy"))
+		goto cleanup;
+	skel_trace1->links.freplace1_bpf = NULL;
+	link = bpf_program__attach_trace(skel_trace1->progs.freplace2_bpf);
+	if (!ASSERT_OK_PTR(link, "attach freplace2_bpf"))
+		goto cleanup;
+	skel_trace1->links.freplace2_bpf = link;
+	err = bpf_link__update_program(skel_trace1->links.freplace2_bpf,
+				       skel_trace1->progs.freplace1_bpf);
+	if (!ASSERT_OK(err, "freplace2_bpf update"))
+		goto cleanup;
+	if (!assert_program_order(skel_trace1, skel_pkt1, &expected_inverted))
+		goto cleanup;
+
+	/* Update should work when the new program's dst_trampoline points to
+	 * another trampoline or the same trampoline.
+	 */
+	skel_trace2 = prog_update_tracing__open();
+	if (!ASSERT_OK_PTR(skel_trace2, "skel_trace2"))
+		goto cleanup;
+	skel_pkt2 = test_pkt_access__open_and_load();
+	if (!ASSERT_OK_PTR(skel_pkt2, "skel_pkt2"))
+		goto cleanup;
+	prog_fd = bpf_program__fd(skel_pkt2->progs.test_pkt_access);
+	bpf_program__set_attach_target(skel_trace2->progs.fentry1_bpf, prog_fd,
+				       NULL);
+	bpf_program__set_attach_target(skel_trace2->progs.fentry2_bpf, prog_fd,
+				       NULL);
+	bpf_program__set_attach_target(skel_trace2->progs.fexit1_bpf, prog_fd,
+				       NULL);
+	bpf_program__set_attach_target(skel_trace2->progs.fexit2_bpf, prog_fd,
+				       NULL);
+	bpf_program__set_attach_target(skel_trace2->progs.freplace1_bpf,
+				       prog_fd, "test_pkt_access_subprog3");
+	bpf_program__set_attach_target(skel_trace2->progs.freplace2_bpf,
+				       prog_fd, "test_pkt_access_subprog3");
+	bpf_program__set_attach_target(skel_trace2->progs.freplace3_bpf,
+				       prog_fd, "get_skb_ifindex");
+	err = prog_update_tracing__load(skel_trace2);
+	if (!ASSERT_OK(err, "skel_trace2 load"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fentry1,
+				       skel_trace2->progs.fentry1);
+	if (!ASSERT_OK(err, "fentry1 update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fentry2,
+				       skel_trace2->progs.fentry2);
+	if (!ASSERT_OK(err, "fentry2 update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fmod_ret1,
+				       skel_trace2->progs.fmod_ret1);
+	if (!ASSERT_OK(err, "fmod_ret1 update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fmod_ret2,
+				       skel_trace2->progs.fmod_ret2);
+	if (!ASSERT_OK(err, "fmod_ret2 update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fexit1,
+				       skel_trace2->progs.fexit1);
+	if (!ASSERT_OK(err, "fexit1 update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fexit2,
+				       skel_trace2->progs.fexit2);
+	if (!ASSERT_OK(err, "fexit2 update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fentry1_bpf,
+				       skel_trace2->progs.fentry1_bpf);
+	if (!ASSERT_OK(err, "fentry1_bpf update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fentry2_bpf,
+				       skel_trace2->progs.fentry2_bpf);
+	if (!ASSERT_OK(err, "fentry2_bpf update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.freplace2_bpf,
+				       skel_trace2->progs.freplace1_bpf);
+	if (!ASSERT_OK(err, "freplace2_bpf update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fexit1_bpf,
+				       skel_trace2->progs.fexit1_bpf);
+	if (!ASSERT_OK(err, "fexit1_bpf update"))
+		goto cleanup;
+	err = bpf_link__update_program(skel_trace1->links.fexit2_bpf,
+				       skel_trace2->progs.fexit2_bpf);
+	if (!ASSERT_OK(err, "fexit2_bpf update"))
+		goto cleanup;
+	if (!assert_program_order(skel_trace2, skel_pkt1, &expected_normal))
+		goto cleanup;
+
+	/* Update should work when the new program is the same as the current
+	 * program.
+	 */
+	err = bpf_link__update_program(skel_trace1->links.fentry1,
+				       skel_trace2->progs.fentry1);
+	if (!ASSERT_OK(err, "fentry1 update"))
+		goto cleanup;
+	if (!assert_program_order(skel_trace2, skel_pkt1, &expected_normal))
+		goto cleanup;
+cleanup:
+	prog_update_tracing__destroy(skel_trace1);
+	prog_update_tracing__destroy(skel_trace2);
+	test_pkt_access__destroy(skel_pkt1);
+	test_pkt_access__destroy(skel_pkt2);
+}
diff --git a/tools/testing/selftests/bpf/progs/prog_update_tracing.c b/tools/testing/selftests/bpf/progs/prog_update_tracing.c
new file mode 100644
index 000000000000..bdf314e28425
--- /dev/null
+++ b/tools/testing/selftests/bpf/progs/prog_update_tracing.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include "vmlinux.h"
+#include <bpf/bpf_helpers.h>
+#include <bpf/bpf_tracing.h>
+
+__u64 sequence = 0;
+
+__u64 fentry1_seq = 0;
+__u64 fentry1_cookie = 0;
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(fentry1, int a, __u64 b)
+{
+	fentry1_seq = ++sequence;
+	fentry1_cookie = bpf_get_attach_cookie(ctx);
+	return 0;
+}
+
+__u64 fentry2_seq = 0;
+__u64 fentry2_cookie = 0;
+SEC("fentry/bpf_modify_return_test")
+int BPF_PROG(fentry2, int a, __u64 b)
+{
+	fentry2_seq = ++sequence;
+	fentry2_cookie = bpf_get_attach_cookie(ctx);
+	return 0;
+}
+
+__u64 fmod_ret1_seq = 0;
+__u64 fmod_ret1_cookie = 0;
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(fmod_ret1, int a, int *b, int ret)
+{
+	fmod_ret1_seq = ++sequence;
+	fmod_ret1_cookie = bpf_get_attach_cookie(ctx);
+	return ret;
+}
+
+__u64 fmod_ret2_seq = 0;
+__u64 fmod_ret2_cookie = 0;
+SEC("fmod_ret/bpf_modify_return_test")
+int BPF_PROG(fmod_ret2, int a, int *b, int ret)
+{
+	fmod_ret2_seq = ++sequence;
+	fmod_ret2_cookie = bpf_get_attach_cookie(ctx);
+	return ret;
+}
+
+__u64 fexit1_seq = 0;
+__u64 fexit1_cookie = 0;
+SEC("fexit/bpf_modify_return_test")
+int BPF_PROG(fexit1, int a, __u64 b, int ret)
+{
+	fexit1_seq = ++sequence;
+	fexit1_cookie = bpf_get_attach_cookie(ctx);
+	return 0;
+}
+
+__u64 fexit2_seq = 0;
+__u64 fexit2_cookie = 0;
+SEC("fexit/bpf_modify_return_test")
+int BPF_PROG(fexit2, int a, __u64 b, int ret)
+{
+	fexit2_seq = ++sequence;
+	fexit2_cookie = bpf_get_attach_cookie(ctx);
+	return 0;
+}
+
+__u64 sequence_bpf = 0;
+
+__u64 fentry1_bpf_seq = 0;
+__u64 fentry1_bpf_cookie = 0;
+SEC("fentry/test_pkt_access")
+int fentry1_bpf(struct __sk_buff *skb)
+{
+	fentry1_bpf_seq = ++sequence_bpf;
+	fentry1_bpf_cookie = bpf_get_attach_cookie(skb);
+	return 0;
+}
+
+__u64 fentry2_bpf_seq = 0;
+__u64 fentry2_bpf_cookie = 0;
+SEC("fentry/test_pkt_access")
+int fentry2_bpf(struct __sk_buff *skb)
+{
+	fentry2_bpf_seq = ++sequence_bpf;
+	fentry2_bpf_cookie = bpf_get_attach_cookie(skb);
+	return 0;
+}
+
+__u64 freplace1_bpf_seq = 0;
+SEC("freplace/test_pkt_access_subprog3")
+int freplace1_bpf(int val, struct __sk_buff *skb)
+{
+	freplace1_bpf_seq = ++sequence_bpf;
+	return 0;
+}
+
+__u64 freplace2_bpf_seq = 0;
+SEC("freplace/test_pkt_access_subprog3")
+int freplace2_bpf(int val, struct __sk_buff *skb)
+{
+	freplace2_bpf_seq = ++sequence_bpf;
+	return 0;
+}
+
+SEC("freplace/get_skb_ifindex")
+int freplace3_bpf(int val, struct __sk_buff *skb, int var)
+{
+	return 0;
+}
+
+__u64 fexit1_bpf_seq = 0;
+__u64 fexit1_bpf_cookie = 0;
+SEC("fexit/test_pkt_access")
+int fexit1_bpf(struct __sk_buff *skb, int ret)
+{
+	fexit1_bpf_seq = ++sequence_bpf;
+	fexit1_bpf_cookie = bpf_get_attach_cookie(skb);
+	return 0;
+}
+
+__u64 fexit2_bpf_seq = 0;
+__u64 fexit2_bpf_cookie = 0;
+SEC("fexit/test_pkt_access")
+int fexit2_bpf(struct __sk_buff *skb, int ret)
+{
+	fexit2_bpf_seq = ++sequence_bpf;
+	fexit2_bpf_cookie = bpf_get_attach_cookie(skb);
+	return 0;
+}
+
+char _license[] SEC("license") = "GPL";
-- 
2.43.0



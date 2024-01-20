Return-Path: <bpf+bounces-19969-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 30412833532
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 16:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 62CD41C20FFF
	for <lists+bpf@lfdr.de>; Sat, 20 Jan 2024 15:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E21101F2;
	Sat, 20 Jan 2024 15:18:42 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mx.der-flo.net (mx.der-flo.net [193.160.39.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0290FBE5;
	Sat, 20 Jan 2024 15:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.160.39.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705763921; cv=none; b=L/RrKUO/CkMgyFxlkhjPyxcN5w9+c2NFYZkxvaj1aEDXIc2EU5Z4uZr8m0eUZA0Sq9Pf233hFusDzteLyYhFqVY5wd0ws734tpQZ5732IGd9kYn64W8PvpQFDhLca5viNTZLMlMuHbbnUcy3zaQSAkSmz6wQBtkkRV3nbCn4B/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705763921; c=relaxed/simple;
	bh=Ry63fiM2Ygoj0nLQaTIWzhwo9hiFoOK8qoMwH5xJp5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j3RL7mpRRkWs4RfagMBhvWg//UTruJyHOHlB2+JPylLxzak7U0FkEPLoMoLCcZ9pkPzxgF1NqPCVveUjau90kgnKqwojyy0yMciHFtAfmRlakqRPC3AO3Fztk+Y/fwdYb3NDDhZ75reBM0jMN8ChblkOpvAHJWE/WQ4yvbOJQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net; spf=pass smtp.mailfrom=der-flo.net; arc=none smtp.client-ip=193.160.39.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=der-flo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=der-flo.net
From: Florian Lehner <dev@der-flo.net>
To: bpf@vger.kernel.org
Cc: peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Florian Lehner <dev@der-flo.net>
Subject: [PATCH bpf-next] perf/bpf: Fix duplicate type check
Date: Sat, 20 Jan 2024 16:09:20 +0100
Message-ID: <20240120150920.3370-1-dev@der-flo.net>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the duplicate check on type and unify result.

Signed-off-by: Florian Lehner <dev@der-flo.net>
---
 kernel/events/core.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f0f0f71213a1..5ecfa57e3b97 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -9302,10 +9302,6 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 {
 	struct perf_bpf_event bpf_event;
 
-	if (type <= PERF_BPF_EVENT_UNKNOWN ||
-	    type >= PERF_BPF_EVENT_MAX)
-		return;
-
 	switch (type) {
 	case PERF_BPF_EVENT_PROG_LOAD:
 	case PERF_BPF_EVENT_PROG_UNLOAD:
@@ -9313,7 +9309,7 @@ void perf_event_bpf_event(struct bpf_prog *prog,
 			perf_event_bpf_emit_ksymbols(prog, type);
 		break;
 	default:
-		break;
+		return;
 	}
 
 	if (!atomic_read(&nr_bpf_events))
-- 
2.39.2



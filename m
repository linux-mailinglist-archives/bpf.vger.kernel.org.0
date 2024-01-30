Return-Path: <bpf+bounces-20770-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D79842D01
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 20:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9809A1C24DB4
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 19:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9665B7B3FF;
	Tue, 30 Jan 2024 19:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlY1DtRT"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 184297B3E0
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 19:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706643428; cv=none; b=Mv72H+mxnyVpbSqVjLV/4SR7qnFqgkbBkzUX37IBPmIBozxq+OCqpaSVTGnP7feuFxICm672DbrncJvLmLuWL+OU6d7fnNh+aX9Kz+DZ0T7L32C/8SEJzgHvGRSF9MX+sd6nmlAUK+lWI2dUhrhJOk6CX98P+aikL7hqYhC2na0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706643428; c=relaxed/simple;
	bh=zMQuhnGRzIcqPSblyGzgKCuO7HtSKiJljrOVu3uQZ6k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fz75T0ixTl/2omQSXwBPI/0biYBJXSA/MgnXdNVlLqqm9IEOfyGdSs0wEOVn5XEGm/IKx9FoFIDYeCCB/Q4uZITNjUpvI8OFP4zkxqwHiN8YUNrS/miWi+2CVpXFyUZoQ+IrzmqcwxqiJXqBEnyM46C77R5xnLdVyr5oiBRlbcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlY1DtRT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73295C433C7;
	Tue, 30 Jan 2024 19:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706643427;
	bh=zMQuhnGRzIcqPSblyGzgKCuO7HtSKiJljrOVu3uQZ6k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PlY1DtRTlcpu3ZQSLekxgWabZ54SMuvAqZTvE/GVhnd0uwaazZpyAmqqAgEhOY2B3
	 PG+qrzkK/TCBBef7sR2EGFxMbCJYht17SDuxfg68qn2n6LLKosMkhj7c1a8nfCgw+J
	 GIYK6437ogBGYOGvg0iTnmG1s8ztFsOZjZe2XG33iSKqy87DaKOGP1mty+rlbqt5zg
	 2mB+3M1gNti7UFfeOyVYYF1kzAUlnUztHqLCx5YFWbfDLMdI+YOWyvml1aN4FV6xBV
	 8iD6uIXkCNFeM4Hh92O3gBVmc6KAjjrMxZEtCQHzI0uSeUwrAwlT6TAPbefgNgWzkk
	 MEquAs+58mfAA==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH bpf-next 5/5] selftests/bpf: fix bench runner SIGSEGV
Date: Tue, 30 Jan 2024 11:36:49 -0800
Message-Id: <20240130193649.3753476-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240130193649.3753476-1-andrii@kernel.org>
References: <20240130193649.3753476-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some benchmarks don't anticipate "consumer" and/or "producer" sides. Add
NULL checks in corresponding places and warn about inappropriate
consumer/producer count argument values.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bench.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 73ce11b0547d..36962fc305eb 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -330,7 +330,7 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 		break;
 	case 'c':
 		env.consumer_cnt = strtol(arg, NULL, 10);
-		if (env.consumer_cnt <= 0) {
+		if (env.consumer_cnt < 0) {
 			fprintf(stderr, "Invalid consumer count: %s\n", arg);
 			argp_usage(state);
 		}
@@ -607,6 +607,10 @@ static void setup_benchmark(void)
 		bench->setup();
 
 	for (i = 0; i < env.consumer_cnt; i++) {
+		if (!bench->consumer_thread) {
+			fprintf(stderr, "benchmark doesn't have consumers!\n");
+			exit(1);
+		}
 		err = pthread_create(&state.consumers[i], NULL,
 				     bench->consumer_thread, (void *)(long)i);
 		if (err) {
@@ -626,6 +630,10 @@ static void setup_benchmark(void)
 		env.prod_cpus.next_cpu = env.cons_cpus.next_cpu;
 
 	for (i = 0; i < env.producer_cnt; i++) {
+		if (!bench->producer_thread) {
+			fprintf(stderr, "benchmark doesn't have producers!\n");
+			exit(1);
+		}
 		err = pthread_create(&state.producers[i], NULL,
 				     bench->producer_thread, (void *)(long)i);
 		if (err) {
-- 
2.34.1



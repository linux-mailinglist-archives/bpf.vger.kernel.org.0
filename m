Return-Path: <bpf+bounces-20975-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC7A845E68
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 18:22:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6610DB2DCE0
	for <lists+bpf@lfdr.de>; Thu,  1 Feb 2024 17:21:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCC441649BF;
	Thu,  1 Feb 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxK1Iee7"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555635B05A
	for <bpf@vger.kernel.org>; Thu,  1 Feb 2024 17:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706808085; cv=none; b=URokx/uN8B+lmQeR8vTPqzqeHwHGjTh310D59nKrX1jW1THiZaO8pAPpdGiexiog5XrRp3sBzmSXjz64ixhFGlre767DvL64+ma5K55hXaksA5MCUTjkJK51OkX8YMG/YGsqfJfCQPIFcsg3dm164f+iXWTB32+Yke7vIg4N46w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706808085; c=relaxed/simple;
	bh=PEZPMSUWObczLBAgu3L3JjgC+2IewAJjzvR6UrgZYAE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ptBg6WaHxgM9pO1+gU/msHItOkWxTCGdMLe88h+jtNtONXCHPo+S7Du0g9F8QJta+YHF0V2ejOgJMTD7PuhfZhRtK8d7MeG7r987wxHgauRODLvjhJpVrLlawO08EFNakiDeB+IdbqUaAxWYUoRhzlLjpyU6N+Y2B8kzD9r86dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxK1Iee7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08C6DC43390;
	Thu,  1 Feb 2024 17:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706808085;
	bh=PEZPMSUWObczLBAgu3L3JjgC+2IewAJjzvR6UrgZYAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YxK1Iee7u8aGR3p1ap6lcmM1BIkzBsLinF6ysDyXLlBsbL0SjYjg7EZuEZq0p4ux2
	 rFFgxGQ2jWMNFELCLG6t7Nf3GIlQt/yrgldeXR2zOLbQbKqZKp3Y1awE/QLo9Ywl48
	 QMT3XbZxVVkGcYytWEXL4eEdOX070OYrz9JpL5nRkLdnZczdW1BP0boItpswRC/BOe
	 0PCfYE2/nv7NfLdeH2tL87oq06oZP2GFYLdQp6XjxlPlr7cgWgCwy4WpJ3a3XsbTyt
	 DOrL6BDuDPZ+v+QxHMfv0OSuJl899g27XyT8JchPJaFpZapJLGF/7kA5k2V8OpgGs1
	 BzT3djnwZvOug==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v2 bpf-next 5/5] selftests/bpf: fix bench runner SIGSEGV
Date: Thu,  1 Feb 2024 09:20:27 -0800
Message-Id: <20240201172027.604869-6-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201172027.604869-1-andrii@kernel.org>
References: <20240201172027.604869-1-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some benchmarks don't have either "consumer" or "producer" sides. For
example, trig-tp and other BPF triggering benchmarks don't have
consumers, as they only do "producing" by calling into syscall or
predefined uproes. As such it's valid for some benchmarks to have zero
consumers or producers. So allows to specify `-c0` explicitly.

This triggers another problem. If benchmark doesn't support either
consumer or producer side, consumer_thread/producer_thread callback will
be NULL, but benchmark runner will attempt to use those NULL callback to
create threads anyways. So instead of crashing with SIGSEGV in case of
misconfigured benchmark, detect the condition and report error.

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
---
 tools/testing/selftests/bpf/bench.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/bench.c b/tools/testing/selftests/bpf/bench.c
index 73ce11b0547d..1724d50ba942 100644
--- a/tools/testing/selftests/bpf/bench.c
+++ b/tools/testing/selftests/bpf/bench.c
@@ -323,14 +323,14 @@ static error_t parse_arg(int key, char *arg, struct argp_state *state)
 		break;
 	case 'p':
 		env.producer_cnt = strtol(arg, NULL, 10);
-		if (env.producer_cnt <= 0) {
+		if (env.producer_cnt < 0) {
 			fprintf(stderr, "Invalid producer count: %s\n", arg);
 			argp_usage(state);
 		}
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
+			fprintf(stderr, "benchmark doesn't support consumers!\n");
+			exit(1);
+		}
 		err = pthread_create(&state.consumers[i], NULL,
 				     bench->consumer_thread, (void *)(long)i);
 		if (err) {
@@ -626,6 +630,10 @@ static void setup_benchmark(void)
 		env.prod_cpus.next_cpu = env.cons_cpus.next_cpu;
 
 	for (i = 0; i < env.producer_cnt; i++) {
+		if (!bench->producer_thread) {
+			fprintf(stderr, "benchmark doesn't support producers!\n");
+			exit(1);
+		}
 		err = pthread_create(&state.producers[i], NULL,
 				     bench->producer_thread, (void *)(long)i);
 		if (err) {
-- 
2.34.1



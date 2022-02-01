Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348494A5EBA
	for <lists+bpf@lfdr.de>; Tue,  1 Feb 2022 15:58:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239601AbiBAO6i (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 1 Feb 2022 09:58:38 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:55198 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbiBAO6h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 1 Feb 2022 09:58:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D319B82E88
        for <bpf@vger.kernel.org>; Tue,  1 Feb 2022 14:58:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F92FC340EB;
        Tue,  1 Feb 2022 14:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643727515;
        bh=/vRMAiXcng1emXHD38xXEv1U6eIjP69o9qi7SOoQElg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tnZLikg8m/iS98zJKjmXzEmH1GLl6dzY1EMa46eSiF2VrxtXYRL+tzb2zBBQADoal
         ii9w0wq4bQuH60QCtOC/7fvrun2JFn8/h3jpZ6EgY6BQWWircOuSEakZSjroOqfGBg
         nGGptcuoz6m0OU7L9CLcNX+oWha4mGP7HTkYw78kXlkzRy9Ab8BcStip67ULbN5hqW
         OO0VghCwLoLp9+4h2YlK31i7p2AO7V3aIETiQueu5lVKhdvRpIeYLnRVfRhfKyeOpB
         BNUUgY24tOTInOUSUO7lEJLXMfLjCrO1egf3RNpNvwlSa7yqutkvpJxz9IYUbnCTMw
         YQGNRD5I1+r/w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, dsahern@kernel.org,
        brouer@redhat.com, toke@redhat.com, lorenzo.bianconi@redhat.com,
        andrii@kernel.org, john.fastabend@gmail.com
Subject: [PATCH v3 bpf-next 1/3] libbpf: deprecate xdp_cpumap, xdp_devmap and classifier sec definitions
Date:   Tue,  1 Feb 2022 15:58:08 +0100
Message-Id: <5c7bd9426b3ce6a31d9a4b1f97eb299e1467fc52.1643727185.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1643727185.git.lorenzo@kernel.org>
References: <cover.1643727185.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Deprecate xdp_cpumap, xdp_devmap and classifier sec definitions.
Introduce xdp/devmap and xdp/cpumap definitions according to the
standard for SEC("") in libbpf:
- prog_type.prog_flags/attach_place

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 tools/lib/bpf/libbpf.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 4ce94f4ed34a..1b0936b016d9 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -237,6 +237,8 @@ enum sec_def_flags {
 	SEC_SLOPPY_PFX = 16,
 	/* BPF program support non-linear XDP buffer */
 	SEC_XDP_FRAGS = 32,
+	/* deprecated sec definitions not supposed to be used */
+	SEC_DEPRECATED = 64,
 };
 
 struct bpf_sec_def {
@@ -6575,6 +6577,10 @@ static int libbpf_preload_prog(struct bpf_program *prog,
 	if (prog->type == BPF_PROG_TYPE_XDP && (def & SEC_XDP_FRAGS))
 		opts->prog_flags |= BPF_F_XDP_HAS_FRAGS;
 
+	if (def & SEC_DEPRECATED)
+		pr_warn("SEC(\"%s\") is deprecated, please see https://github.com/libbpf/libbpf/wiki/Libbpf-1.0-migration-guide#bpf-program-sec-annotation-deprecations for details\n",
+			prog->sec_name);
+
 	if ((prog->type == BPF_PROG_TYPE_TRACING ||
 	     prog->type == BPF_PROG_TYPE_LSM ||
 	     prog->type == BPF_PROG_TYPE_EXT) && !prog->attach_btf_id) {
@@ -8596,7 +8602,7 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("kretprobe/",		KPROBE, 0, SEC_NONE, attach_kprobe),
 	SEC_DEF("uretprobe/",		KPROBE, 0, SEC_NONE),
 	SEC_DEF("tc",			SCHED_CLS, 0, SEC_NONE),
-	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE | SEC_SLOPPY_PFX),
+	SEC_DEF("classifier",		SCHED_CLS, 0, SEC_NONE | SEC_SLOPPY_PFX | SEC_DEPRECATED),
 	SEC_DEF("action",		SCHED_ACT, 0, SEC_NONE | SEC_SLOPPY_PFX),
 	SEC_DEF("tracepoint/",		TRACEPOINT, 0, SEC_NONE, attach_tp),
 	SEC_DEF("tp/",			TRACEPOINT, 0, SEC_NONE, attach_tp),
@@ -8618,9 +8624,11 @@ static const struct bpf_sec_def section_defs[] = {
 	SEC_DEF("iter.s/",		TRACING, BPF_TRACE_ITER, SEC_ATTACH_BTF | SEC_SLEEPABLE, attach_iter),
 	SEC_DEF("syscall",		SYSCALL, 0, SEC_SLEEPABLE),
 	SEC_DEF("xdp.frags/devmap",	XDP, BPF_XDP_DEVMAP, SEC_XDP_FRAGS),
-	SEC_DEF("xdp_devmap/",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
+	SEC_DEF("xdp/devmap",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE),
+	SEC_DEF("xdp_devmap/",		XDP, BPF_XDP_DEVMAP, SEC_ATTACHABLE | SEC_DEPRECATED),
 	SEC_DEF("xdp.frags/cpumap",	XDP, BPF_XDP_CPUMAP, SEC_XDP_FRAGS),
-	SEC_DEF("xdp_cpumap/",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
+	SEC_DEF("xdp/cpumap",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE),
+	SEC_DEF("xdp_cpumap/",		XDP, BPF_XDP_CPUMAP, SEC_ATTACHABLE | SEC_DEPRECATED),
 	SEC_DEF("xdp.frags",		XDP, BPF_XDP, SEC_XDP_FRAGS),
 	SEC_DEF("xdp",			XDP, BPF_XDP, SEC_ATTACHABLE_OPT | SEC_SLOPPY_PFX),
 	SEC_DEF("perf_event",		PERF_EVENT, 0, SEC_NONE | SEC_SLOPPY_PFX),
-- 
2.34.1


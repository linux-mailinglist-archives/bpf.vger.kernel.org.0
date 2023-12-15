Return-Path: <bpf+bounces-18035-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CE78150E5
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 21:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95E71C24005
	for <lists+bpf@lfdr.de>; Fri, 15 Dec 2023 20:11:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1F934597E;
	Fri, 15 Dec 2023 20:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hUs8F2C8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6BC54187F
	for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 20:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-9fa45e75ed9so119175066b.1
        for <bpf@vger.kernel.org>; Fri, 15 Dec 2023 12:11:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702671067; x=1703275867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dznAmNvl1UaFaRebKhJoMWuLmx1Ga8aj6VYhnDMWz8w=;
        b=hUs8F2C8OC4I90qXJWDEy4CCQF1GSa3Frf/01pJK7KUEmtsQqkrFjqdvcdH3iD6ZlH
         PB2Sq0bqiJnNYT/E35TNEjWWfxv0NpZOOZgFOCopoChwSfjckF/sh2aRmVz9tSJrznef
         lDasF+LNDRespcKxdJohWiBWLz1hHhjFQ6/UESGPICNLJc9y0GmoWb6p2UMO4qXfluiz
         mbus5QrWgC16XJ2yGjzzLfQD5SAwy3PtVl6Dwqd3N2+dn4ALyQyjeez/s/1miDZgnwm3
         3kZSJKqJj9hygXiOJx45UuM9OBWxGZ+QW6h44aJHrHirlzBcyLBbZZKTEeMOAEytQzhs
         XGAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702671067; x=1703275867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dznAmNvl1UaFaRebKhJoMWuLmx1Ga8aj6VYhnDMWz8w=;
        b=tlHcAEdGpsQr24ai0fn0l5NRRhD/v00TVLX+rnsqN8lmTN3ZMopsCOXBEmaadpxUaw
         FNkesuxAgTgOMpwXkSMFNp6ZGk9xWkru+4KbPTcwI+Qk+6H/YA+++AGzA57DD3bKfsdC
         DDNbhqiOazzIxEYVsYM5enj+rHD49J0eFExxMZS+zdIbHKFO80N9jsYVYFaNIuUvWXBS
         qbSQ6jqdXDD/WCE7IiJAkxxyin3s3LOJzNnkehzBO4jEfXUWf3JldEtU+hvi3Xd+flaq
         PZCcZ8FNMfoYDJ9k/i63IDu3Gq949+kFBoEmjq83Ky1PowT0bxvXf81L0iqpjOJkBxg6
         yCYQ==
X-Gm-Message-State: AOJu0YxKnlXcL9CrpZwXnE7TF9wAaeWrnmzL23k13//KwHwHQoviyhQq
	XQ1eIB0nD2vJQlhqGWo0bk8HbGsCfMT46Q==
X-Google-Smtp-Source: AGHT+IHK6AkadCg4HiGgaHaMNZydEvS+zSEUDfnNlL9fgn6Izt+Q5MTYiuhRcQbMK65P6AQDw74rTQ==
X-Received: by 2002:a17:906:b389:b0:a19:a19a:eac5 with SMTP id uh9-20020a170906b38900b00a19a19aeac5mr5116182ejc.126.1702671066706;
        Fri, 15 Dec 2023 12:11:06 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id cx11-20020a170907168b00b00a1d5ebe8871sm11031490ejd.28.2023.12.15.12.11.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 12:11:06 -0800 (PST)
From: Dmitrii Dolgov <9erthalion6@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	dan.carpenter@linaro.org,
	olsajiri@gmail.com,
	asavkov@redhat.com,
	Dmitrii Dolgov <9erthalion6@gmail.com>
Subject: [PATCH bpf-next v9 1/4] bpf: Relax tracing prog recursive attach rules
Date: Fri, 15 Dec 2023 21:07:07 +0100
Message-ID: <20231215200712.17222-2-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231215200712.17222-1-9erthalion6@gmail.com>
References: <20231215200712.17222-1-9erthalion6@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, it's not allowed to attach an fentry/fexit prog to another
one fentry/fexit. At the same time it's not uncommon to see a tracing
program with lots of logic in use, and the attachment limitation
prevents usage of fentry/fexit for performance analysis (e.g. with
"bpftool prog profile" command) in this case. An example could be
falcosecurity libs project that uses tp_btf tracing programs.

Following the corresponding discussion [1], the reason for that is to
avoid tracing progs call cycles without introducing more complex
solutions. But currently it seems impossible to load and attach tracing
programs in a way that will form such a cycle. The limitation is coming
from the fact that attach_prog_fd is specified at the prog load (thus
making it impossible to attach to a program loaded after it in this
way), as well as tracing progs not implementing link_detach.

Replace "no same type" requirement with verification that no more than
one level of attachment nesting is allowed. In this way only one
fentry/fexit program could be attached to another fentry/fexit to cover
profiling use case, and still no cycle could be formed. To implement,
add a new field into bpf_prog_aux to track nested attachment for tracing
programs.

[1]: https://lore.kernel.org/bpf/20191108064039.2041889-16-ast@kernel.org/

Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Previous discussion: https://lore.kernel.org/bpf/20231212195413.23942-1-9erthalion6@gmail.com/

Changes in v9:
    - Formatting

Changes in v8:
    - Move bookkeping in bpf_tracing_link_release under the tgt_prog
      condition.
    - Fix some indentation issues.

Changes in v7:
    - Replace attach_depth with a boolean flag to indicate a program is
      already tracing an fentry/fexit.

Changes in v6:
    - Apply nesting level limitation only to tracing programs, otherwise
      it's possible to apply it in "fentry->extension" case and break it

Changes in v5:
    - Remove follower_cnt and drop unreachable cycle prevention condition
    - Allow only one level of attachment nesting
    - Do not display attach_depth in bpftool, as it doesn't make sense
      anymore

Changes in v3:
    - Fix incorrect decreasing of attach_depth, setting to 0 instead
    - Place bookkeeping later, to not miss a cleanup if needed
    - Display attach_depth in bpftool only if the value is not 0

Changes in v2:
    - Verify tgt_prog is not null
    - Replace boolean followed with number of followers, to handle
      multiple progs attaching/detaching

 include/linux/bpf.h   |  1 +
 kernel/bpf/syscall.c  | 10 +++++++++-
 kernel/bpf/verifier.c | 39 +++++++++++++++++++++++++--------------
 3 files changed, 35 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eb447b0a9423..e7393674ab94 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1414,6 +1414,7 @@ struct bpf_prog_aux {
 	bool dev_bound; /* Program is bound to the netdev. */
 	bool offload_requested; /* Program is bound and offloaded to the netdev. */
 	bool attach_btf_trace; /* true if attaching to BTF-enabled raw tp */
+	bool attach_tracing_prog; /* true if tracing another tracing program */
 	bool func_proto_unreliable;
 	bool sleepable;
 	bool tail_call_reachable;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 5e43ddd1b83f..bcc5d5ab0870 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3040,8 +3040,10 @@ static void bpf_tracing_link_release(struct bpf_link *link)
 	bpf_trampoline_put(tr_link->trampoline);
 
 	/* tgt_prog is NULL if target is a kernel function */
-	if (tr_link->tgt_prog)
+	if (tr_link->tgt_prog) {
 		bpf_prog_put(tr_link->tgt_prog);
+		link->prog->aux->attach_tracing_prog = false;
+	}
 }
 
 static void bpf_tracing_link_dealloc(struct bpf_link *link)
@@ -3243,6 +3245,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 		goto out_unlock;
 	}
 
+	/* Bookkeeping for managing the prog attachment chain */
+	if (tgt_prog &&
+	    prog->type == BPF_PROG_TYPE_TRACING &&
+	    tgt_prog->type == BPF_PROG_TYPE_TRACING)
+		prog->aux->attach_tracing_prog = true;
+
 	link->tgt_prog = tgt_prog;
 	link->trampoline = tr;
 
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 8e7b6072e3f4..f8c15ce8fd05 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -20077,6 +20077,7 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    struct bpf_attach_target_info *tgt_info)
 {
 	bool prog_extension = prog->type == BPF_PROG_TYPE_EXT;
+	bool prog_tracing = prog->type == BPF_PROG_TYPE_TRACING;
 	const char prefix[] = "btf_trace_";
 	int ret = 0, subprog = -1, i;
 	const struct btf_type *t;
@@ -20147,10 +20148,21 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			bpf_log(log, "Can attach to only JITed progs\n");
 			return -EINVAL;
 		}
-		if (tgt_prog->type == prog->type) {
-			/* Cannot fentry/fexit another fentry/fexit program.
-			 * Cannot attach program extension to another extension.
-			 * It's ok to attach fentry/fexit to extension program.
+		if (prog_tracing) {
+			if (aux->attach_tracing_prog) {
+				/*
+				 * Target program is an fentry/fexit which is already attached
+				 * to another tracing program. More levels of nesting
+				 * attachment are not allowed.
+				 */
+				bpf_log(log, "Cannot nest tracing program attach more than once\n");
+				return -EINVAL;
+			}
+		} else if (tgt_prog->type == prog->type) {
+			/*
+			 * To avoid potential call chain cycles, prevent attaching of a
+			 * program extension to another extension. It's ok to attach
+			 * fentry/fexit to extension program.
 			 */
 			bpf_log(log, "Cannot recursively attach\n");
 			return -EINVAL;
@@ -20163,16 +20175,15 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			 * except fentry/fexit. The reason is the following.
 			 * The fentry/fexit programs are used for performance
 			 * analysis, stats and can be attached to any program
-			 * type except themselves. When extension program is
-			 * replacing XDP function it is necessary to allow
-			 * performance analysis of all functions. Both original
-			 * XDP program and its program extension. Hence
-			 * attaching fentry/fexit to BPF_PROG_TYPE_EXT is
-			 * allowed. If extending of fentry/fexit was allowed it
-			 * would be possible to create long call chain
-			 * fentry->extension->fentry->extension beyond
-			 * reasonable stack size. Hence extending fentry is not
-			 * allowed.
+			 * type. When extension program is replacing XDP function
+			 * it is necessary to allow performance analysis of all
+			 * functions. Both original XDP program and its program
+			 * extension. Hence attaching fentry/fexit to
+			 * BPF_PROG_TYPE_EXT is allowed. If extending of
+			 * fentry/fexit was allowed it would be possible to create
+			 * long call chain fentry->extension->fentry->extension
+			 * beyond reasonable stack size. Hence extending fentry
+			 * is not allowed.
 			 */
 			bpf_log(log, "Cannot extend fentry/fexit\n");
 			return -EINVAL;
-- 
2.41.0



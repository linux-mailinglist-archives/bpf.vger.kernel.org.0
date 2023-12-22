Return-Path: <bpf+bounces-18617-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D9681CC01
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 16:15:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 467631C20B9F
	for <lists+bpf@lfdr.de>; Fri, 22 Dec 2023 15:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4273425763;
	Fri, 22 Dec 2023 15:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lt1wrn49"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E9D524B56
	for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 15:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-552ff8d681aso5478530a12.1
        for <bpf@vger.kernel.org>; Fri, 22 Dec 2023 07:12:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703257925; x=1703862725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vnw1Mwgz8Fxi1VQ+oqQgkdvhGX5ti5Slv2m/PId3Ais=;
        b=Lt1wrn49qOaq2gVDD1i/Nn1lDeVUnFbggBOzfgOFTx27Kc6zzKj7zFFvfN2qbWaKlr
         Iil2hjmfArqTC6VTpkAjvlUIv+5oSr+OFAhwhCO/cCiBau7TFK1kC326fTcWKstjbt5c
         ble3CaGvbndWW7dZCdurFAkAzpiyKGg7OIGNHSqc4WJEqz/UFpw4otJHZq9MKAOrFtS8
         Z+LY96qBEsAufYlwyiJnM1MLja/mPpoy5mA6fKALvP24XOSwwN6N0HGJs7sQldZo7mzK
         w73W1Hd/S9M3R9VndU9sm8EpyJ0pQI4QokrFwGXVM7zG5jwP3sux5WYCGI3UnZWjyre4
         OIqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703257925; x=1703862725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vnw1Mwgz8Fxi1VQ+oqQgkdvhGX5ti5Slv2m/PId3Ais=;
        b=paZoOEgxCWwRsN30Y7bHT+2+Ko+KMhaJwqv7bRIb5c+cV06GsM1VUoVb0Gypq97xt7
         68v5Kszjr+hWB/28nt3el8DUWzrsXMqHKalyLeplfLEnocDq3mYgGeAH5nV+/uWCT3HY
         iHnRm5VnDrYZkg6m9LcVkzjyW2A72vsjJlwWlZ1xhqL3lSFWGmD/ATlOr3FXuzVmwZIc
         uUAy+ehe1hobUVOKj5ZLl54KZEIMSuYAlu8An7/yYJQJVml4YgaavHxa75kMPP1DZWvi
         TZvze2nbExMC8W3Bs8ys93XUkk3t1c9BtxeDoNIewcdfGyP2fgONgDY+OpOhMAU/ueN8
         q2/w==
X-Gm-Message-State: AOJu0Yy1ErSpBy9JIIWivwtjPtQvAJXQ75ldaiemYNP4wRuZebP97Qvt
	F04McW1GaPLRgUzpxzVmDvbCZ4SmGJVgkw==
X-Google-Smtp-Source: AGHT+IHWTN1rzvA7L8M9QjDMlvlGTeQW04gl7tO8+PG/U/+KHfWGo5/9hq3axyit/1NnJowBR85f7Q==
X-Received: by 2002:a17:907:7e94:b0:a23:4d81:ac9b with SMTP id qb20-20020a1709077e9400b00a234d81ac9bmr3381330ejc.18.1703257925240;
        Fri, 22 Dec 2023 07:12:05 -0800 (PST)
Received: from erthalion.local (dslb-178-005-229-020.178.005.pools.vodafone-ip.de. [178.5.229.20])
        by smtp.gmail.com with ESMTPSA id br18-20020a170906d15200b00a236f815a1fsm2111162ejb.200.2023.12.22.07.12.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 07:12:04 -0800 (PST)
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
Subject: [PATCH bpf-next v11 1/4] bpf: Relax tracing prog recursive attach rules
Date: Fri, 22 Dec 2023 16:11:47 +0100
Message-ID: <20231222151153.31291-2-9erthalion6@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231222151153.31291-1-9erthalion6@gmail.com>
References: <20231222151153.31291-1-9erthalion6@gmail.com>
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

Acked-by: Jiri Olsa <olsajiri@gmail.com>
Signed-off-by: Dmitrii Dolgov <9erthalion6@gmail.com>
---
Previous discussion: https://lore.kernel.org/bpf/20231220180422.8375-1-9erthalion6@gmail.com/

Changes in v10:
    - Set attach_tracing_prog flag at load time.

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
 kernel/bpf/syscall.c  | 23 ++++++++++++++++++++++-
 kernel/bpf/verifier.c | 39 +++++++++++++++++++++++++--------------
 3 files changed, 48 insertions(+), 15 deletions(-)

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
index 5e43ddd1b83f..c40cad8886e9 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2702,6 +2702,22 @@ static int bpf_prog_load(union bpf_attr *attr, bpfptr_t uattr, u32 uattr_size)
 			goto free_prog_sec;
 	}
 
+	/*
+	 * Bookkeeping for managing the program attachment chain.
+	 *
+	 * It might be tempting to set attach_tracing_prog flag at the attachment
+	 * time, but this will not prevent from loading bunch of tracing prog
+	 * first, then attach them one to another.
+	 *
+	 * The flag attach_tracing_prog is set for the whole program lifecycle, and
+	 * doesn't have to be cleared in bpf_tracing_link_release, since tracing
+	 * programs cannot change attachment target.
+	 */
+	if (type == BPF_PROG_TYPE_TRACING && dst_prog &&
+	    dst_prog->type == BPF_PROG_TYPE_TRACING) {
+		prog->aux->attach_tracing_prog = true;
+	}
+
 	/* find program type: socket_filter vs tracing_filter */
 	err = find_prog_type(type, prog);
 	if (err < 0)
@@ -3135,7 +3151,12 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 	}
 
 	if (tgt_prog_fd) {
-		/* For now we only allow new targets for BPF_PROG_TYPE_EXT */
+		/*
+		 * For now we only allow new targets for BPF_PROG_TYPE_EXT. If this
+		 * part would be changed to implement the same for
+		 * BPF_PROG_TYPE_TRACING, do not forget to update the way how
+		 * attach_tracing_prog flag is set.
+		 */
 		if (prog->type != BPF_PROG_TYPE_EXT) {
 			err = -EINVAL;
 			goto out_put_prog;
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



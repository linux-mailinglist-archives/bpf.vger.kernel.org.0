Return-Path: <bpf+bounces-55949-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78277A89F04
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 15:10:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 53BC77A77A5
	for <lists+bpf@lfdr.de>; Tue, 15 Apr 2025 13:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73EBD297A40;
	Tue, 15 Apr 2025 13:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BDcm8UIN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80EC9201017;
	Tue, 15 Apr 2025 13:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744722599; cv=none; b=JP5xTPMYj32PeKHVjjloFB940OB8kE/tsnTGb+8N5aDK/rM37NlufUD2wdhXx++B2/k2NLSUtpT9Qjra8S9Wc+L8a8Z5Qjtxz8AlORC7WX6jK4WvfrGJ60tQTTocf5bqxFAQDxb7SQuI7yRidXTn71SbQ1/sXKh/U6cQ3mW3xqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744722599; c=relaxed/simple;
	bh=1MnuAkRdhCY1WfObz2NT8vubDqZjZ18y0GbOgq9+SWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WTunjmnx7tZ83t7O01/QRzr6s2F7BBsU4VVSDpYGIa/FQNIEnEQn6JLYTfG8EY5JoUFC8/9UMks/LX+r495KgcdZUnbOYMojyJTtM++nr5MHPR722TfAkgzvNJizTGcwZ1oJ4Ho3z4WWZ9J/wwHTTalXblP/R7AqVJ5WX0d9dDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BDcm8UIN; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-306b6ae4fb2so5437616a91.3;
        Tue, 15 Apr 2025 06:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744722597; x=1745327397; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ROffXuJEF8DX7Dlw1Sl0/VWDxHt96RQSrGxvBnC8v/I=;
        b=BDcm8UINpjEhFe27ASFYbp48saamQdLKaGjD6oSy+Gqtk0t2mX7INj/tK8m5Z5BtZQ
         ou4ZSRD+kFBKEjQkc3EaUQCZiCZKYDFIqKviQ4wkaMdMt0eQh/bg5v9uAr7dzOReUjf0
         xPAJVCpzEUTwBTd9jqFgeYRBcgCr9lAMzF0GtK9rzYdWUAIhFf+weMKaAYL6CnaImXUu
         TSlFm8dq6FhGm1xi5SuXmUJLk7ioX+GgSTKpD2Kgc1zE9Um826Rh1ojYkrJW5lFCcus0
         RA/xPGlME8ufILx6Xp5yMEkafa+PD1HyrDNydI9TGj6fIquy/Yh3ENd9JAS9erVHOg6q
         C5yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744722597; x=1745327397;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ROffXuJEF8DX7Dlw1Sl0/VWDxHt96RQSrGxvBnC8v/I=;
        b=AnOAzzf2WuxxAbi5M76QIbVMZOUET0WDpvyXoss1cvyMMkP6htIBS4wgaihS+kFQMg
         gyN8kgo/K//NX5677HMxbEU1CNpkpJKdYbHUdKkiz4wchIa2Gae8aQyyWuodFpYA/PYq
         bnfsGqY/akC95Jm56WOc4b1YdQP/fmDj7ZKiKCPMECis/g/Z/ztUw03SSc5IlYQXp6sZ
         8SJeDbbtFQxxYDazuMUwmxi5skKfbMmyulxLhLPXKdArmzGZc293zs8SZc/iH7GGDG4S
         vtq7XesJ4fYE3TxfGPGU4FRQ1FfhfyusZtHGObIotNk8KxuC7blfpePnPtkRQU7U0vs5
         OBvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU11zhXxiRxiPlk7cYl6u2rxISAoJPPkX7RUBjj58OkqeECTETHHrZdOPGYjgkXmFqZnCQHNZVshpEG+5cR@vger.kernel.org, AJvYcCUSFdDsxOdSvGj8U1pOfJYOrjZjCTafePrYfkbxgaCb3KTC4+4MWLlOWgnj5u6NPcid0nJAUF7L@vger.kernel.org, AJvYcCX0Md82/w5c9aDoD/WlbomDPPkwKVU3R+fCXi+JIZRs8OdSbwe512uwAbS4Po7Qy7CLRqE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUPOAEktlrlSMlFj+ABYgiqDkPhmJvtBdsqHDSu4+4FC7v/dZs
	pPQ+3JKt9pum/KJlinAe8NcakwK1jQ3gnHzogGHP1x38Uuilfl4C
X-Gm-Gg: ASbGncvIUpe7/ZlQsVYv5FsK79C1cEzHF2u0t6dk6fV/nKkq16J/vLpAheQi3/3+Hu8
	E4lKY12BVzb6Ct7/xpx7HqT/2a4MuJxxzDqnMpErhPx4wNSBZrRWsa4qulYp7BCJEr4k38pCK+e
	Ar2ycrPqnRozCVIZ5aTkyVi3g5fMdXtrcPLMBFBd291VhkrJ/oR9WMlLaTs98fb076pdqldBmYZ
	ngvSTS/Xt+4N/gCEakR0lS3MaCQDGyi9pzOC9MHitUOlxLTTUocuuOwyIgLn+c4LC0tvscGqGjZ
	fnuiX0kizi2benA+CewTJ+EW423RRDcidQKMtMt1
X-Google-Smtp-Source: AGHT+IGrbakp3gdJT5engsJp7bS+mmyQ7Q/b+yLZmtwIiI2SeohFbA98WC/ZpRR+orkfQ0nPSrONVQ==
X-Received: by 2002:a17:90b:5190:b0:2ff:4bac:6fba with SMTP id 98e67ed59e1d1-3082367ccebmr25337882a91.24.1744722596523;
        Tue, 15 Apr 2025 06:09:56 -0700 (PDT)
Received: from fedora.nitk.ac.in ([2a09:bac5:3d50:16b4::243:2a])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-306dd10dc4bsm13165254a91.1.2025.04.15.06.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Apr 2025 06:09:55 -0700 (PDT)
From: Devaansh Kumar <devaanshk840@gmail.com>
To: gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net
Cc: Devaansh Kumar <devaanshk840@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linuxfoundation.org,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>
Subject: [PATCH] bpf: Remove tracing program restriction on map types
Date: Tue, 15 Apr 2025 18:39:07 +0530
Message-ID: <20250415130910.2326537-1-devaanshk840@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Upstream commit 96da3f7d489d11b43e7c1af90d876b9a2492cca8 ]

The hash map is now fully converted to bpf_mem_alloc. Its implementation is not
allocating synchronously and not calling call_rcu() directly. It's now safe to
use non-preallocated hash maps in all types of tracing programs including
BPF_PROG_TYPE_PERF_EVENT that runs out of NMI context.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/bpf/20220902211058.60789-13-alexei.starovoitov@gmail.com
Signed-off-by: Devaansh Kumar <devaanshk840@gmail.com>
---
 kernel/bpf/verifier.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 7049a85a78ab..77a75ccaae5e 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11700,35 +11700,6 @@ static int check_map_prog_compatibility(struct bpf_verifier_env *env,
 
 {
 	enum bpf_prog_type prog_type = resolve_prog_type(prog);
-	/*
-	 * Validate that trace type programs use preallocated hash maps.
-	 *
-	 * For programs attached to PERF events this is mandatory as the
-	 * perf NMI can hit any arbitrary code sequence.
-	 *
-	 * All other trace types using preallocated hash maps are unsafe as
-	 * well because tracepoint or kprobes can be inside locked regions
-	 * of the memory allocator or at a place where a recursion into the
-	 * memory allocator would see inconsistent state.
-	 *
-	 * On RT enabled kernels run-time allocation of all trace type
-	 * programs is strictly prohibited due to lock type constraints. On
-	 * !RT kernels it is allowed for backwards compatibility reasons for
-	 * now, but warnings are emitted so developers are made aware of
-	 * the unsafety and can fix their programs before this is enforced.
-	 */
-	if (is_tracing_prog_type(prog_type) && !is_preallocated_map(map)) {
-		if (prog_type == BPF_PROG_TYPE_PERF_EVENT) {
-			verbose(env, "perf_event programs can only use preallocated hash map\n");
-			return -EINVAL;
-		}
-		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
-			verbose(env, "trace type programs can only use preallocated hash map\n");
-			return -EINVAL;
-		}
-		WARN_ONCE(1, "trace type BPF program uses run-time allocation\n");
-		verbose(env, "trace type programs with run-time allocated hash maps are unsafe. Switch to preallocated hash maps.\n");
-	}
 
 	if (map_value_has_spin_lock(map)) {
 		if (prog_type == BPF_PROG_TYPE_SOCKET_FILTER) {
-- 
2.49.0



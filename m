Return-Path: <bpf+bounces-57017-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CFAE3AA3FD9
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68A8C5A2F60
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAA34A04;
	Wed, 30 Apr 2025 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eK4CO0sg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972812DC794
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974269; cv=none; b=CTPJ7ZbSEaJMJwo5JM+Fnni5JuPerDOzF7eYdNCF4xK3px2MAQ+4FxYo8h/zlYbJISwFMRo+ik088SDG1kuNWhWqFz9nTEl6SumTgf9v3dt1cmD3MllCoqQoGbelSNA8BTjbkBUBB1RCz9dISkQfRH4/8pAy1vQaKDMi7rfkFng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974269; c=relaxed/simple;
	bh=rquWbvFdAI/weweTFoH7TnN/xZwnbHE8N2Mv6waIGg8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rB05oHTFP9UR7cby3A3Hi2qj1eXbiBLmf0PT+Kz8+l/dsVIzgjOcLMMWKZRs8FW7cjHT5m/56j72JmPPNWTXhia2Q+Jb8xFXvqgL7FAoeTIUqD8PHQZmf7UzA6Us+U6RnOTf1Z7SB2v+Gj5K46mbITT13zlXj/NEnKtYT0R7CGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eK4CO0sg; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-306b590faaeso4901279a91.3
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:51:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745974267; x=1746579067; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+l4CwmzcQV88NSApvBjyn1wiwPNcLUJiUFhfemm+Ew=;
        b=eK4CO0sgttoyBlMCZsPkr3LuLwhpupAKLEIYARMfFyqzYpM+ihdLI/0qGN/97Nsk8A
         l+Wmu0FJW4cxzCEHgFrgEDgk22yO+471LGWI5iXS3iSqx3f6vKZb+J7md/PiZ7KlwrYg
         c/LQp7P8SnEkr3sUtILmEDQKLLX+exCryLvKiFdWHcMUuZxQu+k2+YqVU62RxGKgH5fs
         kqOFusg24jT2amY6VUIj6wpUrjI7zv9uLyBnxve5kSPYBJmRjYx5+bKrcVUlkm+LRIhR
         fJY9zf/vyH1HtN6fYHeBfu2G5B21TCrEJ/hGm6pF8w11b7SeGzcXtGfKuXEnA480pTfg
         ayuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745974267; x=1746579067;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j+l4CwmzcQV88NSApvBjyn1wiwPNcLUJiUFhfemm+Ew=;
        b=deqreLuirdRwuUrtnxLHgtr+MkWsGqPsWfofmFXRDOsb4RvnRaFULKP5tS5q4dLp8Z
         3Kro/TL3EJbhR1JjevhJ2jUvwQbwiz60N+aiTBmv03D8KWmJDFKXW+vmyWMbjKHaMjAS
         vavJ4C3JZih4KwFB+7DDyeLYq13dse67klyoMIc5hO4erXPJeNJzFEzfeAwchOVzQ3CW
         uSVdKqUdfOCppwDifBNGlzAWmdcG5g0NCTXD5U8Nte6n8z8MWzaKCBtdp/da4Xm7HMo5
         a+kZWfO3PF5GbD3NHpnFrd7VZ8urLH83+hKzDHdDfEnJofzevMF1quffYJrRMa5rHaom
         cxWg==
X-Gm-Message-State: AOJu0YzJVzZwyQuQ79Ns1cWAakaiqPKBarFFgxgEAYCpBityWnfOBDOL
	fJcfU+wjpWIQ6/TMlrdrAmdlrt8HRBmvUWlppiOzSInImzbjusFxY5u5Hwma8l9gETv+uaj3obI
	BxBPXBGAfBRkHs6GtiVYeRxQZ+6riHGVj/UVuqaYlK/J7YfXPIEqp6kKMbP5LRZbZ8Rp55ZZ4JR
	IhBcv9M/NIqNCNUZzdEu35sInwXKjHIFRTapvtdxs=
X-Google-Smtp-Source: AGHT+IFLFCeRdlc8weunDBrt8thymEXI4mbAQuV2g66tj9AakSKOPtGm7SPoDCEdewMpWYbH0BoKH8PsEUZ6Pg==
X-Received: from pjf13.prod.google.com ([2002:a17:90b:3f0d:b0:2fc:1356:bcc3])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:d010:b0:2ee:d63f:d8f with SMTP id 98e67ed59e1d1-30a332e99b8mr1751500a91.13.1745974266681;
 Tue, 29 Apr 2025 17:51:06 -0700 (PDT)
Date: Wed, 30 Apr 2025 00:51:02 +0000
In-Reply-To: <cover.1745970908.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1745970908.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <ca441a13f5ad4a34ddb622cb5b2616b309d59694.1745970908.git.yepeilin@google.com>
Subject: [PATCH bpf-next 5/8] selftests/bpf: Use CAN_USE_LOAD_ACQ_STORE_REL
 when appropriate
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, linux-riscv@lists.infradead.org, 
	Andrea Parri <parri.andrea@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of open-coding the conditions, use
'#ifdef CAN_USE_LOAD_ACQ_STORE_REL' to guard the following tests:

  verifier_precision/bpf_load_acquire
  verifier_precision/bpf_store_release
  verifier_store_release/*

Note that, for the first two tests in verifier_precision.c, switching to
'#ifdef CAN_USE_LOAD_ACQ_STORE_REL' means also checking if
'__clang_major__ >= 18', which has already been guaranteed by the outer
'#if' check.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 tools/testing/selftests/bpf/progs/verifier_precision.c     | 5 ++---
 tools/testing/selftests/bpf/progs/verifier_store_release.c | 7 +++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools/testing/selftests/bpf/progs/verifier_precision.c
index 6662d4b39969..2dd0d15c2678 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -91,8 +91,7 @@ __naked int bpf_end_bswap(void)
 		::: __clobber_all);
 }
 
-#if defined(ENABLE_ATOMICS_TESTS) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
+#ifdef CAN_USE_LOAD_ACQ_STORE_REL
 
 SEC("?raw_tp")
 __success __log_level(2)
@@ -138,7 +137,7 @@ __naked int bpf_store_release(void)
 	: __clobber_all);
 }
 
-#endif /* load-acquire, store-release */
+#endif /* CAN_USE_LOAD_ACQ_STORE_REL */
 #endif /* v4 instruction */
 
 SEC("?raw_tp")
diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/tools/testing/selftests/bpf/progs/verifier_store_release.c
index c0442d5bb049..7e456e2861b4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
+++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
@@ -6,8 +6,7 @@
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
 
-#if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
+#ifdef CAN_USE_LOAD_ACQ_STORE_REL
 
 SEC("socket")
 __description("store-release, 8-bit")
@@ -271,7 +270,7 @@ __naked void store_release_with_invalid_reg(void)
 	: __clobber_all);
 }
 
-#else
+#else /* CAN_USE_LOAD_ACQ_STORE_REL */
 
 SEC("socket")
 __description("Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/or JIT doesn't support store-release, use a dummy test")
@@ -281,6 +280,6 @@ int dummy_test(void)
 	return 0;
 }
 
-#endif
+#endif /* CAN_USE_LOAD_ACQ_STORE_REL */
 
 char _license[] SEC("license") = "GPL";
-- 
2.49.0.901.g37484f566f-goog



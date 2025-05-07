Return-Path: <bpf+bounces-57620-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B24AAD42B
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:43:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C21367A9986
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75F401C1AAA;
	Wed,  7 May 2025 03:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0IlsIDRA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f201.google.com (mail-pl1-f201.google.com [209.85.214.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90924189902
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:43:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589402; cv=none; b=ew88jePgBIxTWQH/dye1ntz8ZTWkGh7o4IL68vmZSJaDGCgN9+QdWafPG40BSJQKtQoQJTNtzoZYH8n5jrW7kM6TdnPO+Fv9s9eBG+J7vfSikALU6aomwt4luF6RbK8Bg3YLDf8HckXpmJHbqD1/oAgS/nmYRU7flL/Yp6+33gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589402; c=relaxed/simple;
	bh=yIY5WGhJK2KCv+MgjqVKF/O3LMcOQlXKsIvEIAh7hzA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Nl8Wieh/HIpiUYusU1jCJzHXMGqG84BNEdArOiNK4q/4k9ZFaUcrX6tCz5kPswzz2yDL4B9Qgpnd3xg+/X92yl6VwMpLFzibtvVhlTUh1mBJCVF25m1jll/IcTji5pyyOZXDr9L9hJ5BPofiQdY8bV2sEDtOYpaJqEoYzh1YtT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0IlsIDRA; arc=none smtp.client-ip=209.85.214.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pl1-f201.google.com with SMTP id d9443c01a7336-22aa75e6653so46586175ad.0
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 20:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746589397; x=1747194197; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aYex2sS04TBXgGkqcQU1a9cCLcTu5hNrYUfNWQD7HDc=;
        b=0IlsIDRAk143+RChZAzmb7ubtk5IgEkc18ZwQSXE3rflXqQG6pHK5lPg9EzQ3iOIRW
         SXKAvoTWr+3y8Dl6rZOdLrsfoTwpZ/BMQnSvsAHxayDrsFane4qgcBjmqS/WYBEx7cTi
         O2uZlmCBkIWr+5AGFzQc1Ep/DstmhyCQxDSI8AkY//iBafzfwCbI9paSUAiD29A34Ejz
         V37h9dlVbmE1s+Oot8mWjVfyCuZa/IE2Q8GVu/XCmnCxXv12gR0gt2/zlE6jUgfaP0qR
         ptGn2rUDRK5cAL0DRcuAoE2uVvZYKqfmfrkEXTgZyzS+WSarwzpvQ1474t8bRdJ692Ag
         Czog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589397; x=1747194197;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=aYex2sS04TBXgGkqcQU1a9cCLcTu5hNrYUfNWQD7HDc=;
        b=ZcKVhLLznRp9tIqCwl5si4LO+DdZuzgVZA7kcworcdkj/AyA4mFavSUeaQj51IJs3M
         1GjdL20GHWDtLhV4pNr7sq5EIT4yDqdixe0K0fzE05XTvuZkjdaGb0//r6QiYhnY7+UT
         yaxXDKYj3A8HnhkPgWF1dPRA0Vi9bzOGN9vyMu0n94WFYt561rYuWlICg7dltC6brSCR
         aJFyXgFAuTJ70EFrlH13bEzgfAznCdjvceyUIkNySIHXXPijV7jQr15tg4t3MyRvTdBm
         NUn2KwN+CCe78LxP4VkpBGsblV6ytSd1PeSpslLKEVwwTAPABBgssXDPZLUUFNpm4CuD
         ujdw==
X-Gm-Message-State: AOJu0YzTVs3SHQp8wm+S5+AQCIhCXLPOB5H/Zfxy++eAEwZGoo1ZloNl
	aPUSi883UfzzfdlJzNf7/uo91RGmpcrW51fMiDZCcSr4oOsO4lcquUvI1UnCQ9UJnpynWzirmc5
	EmoSCD+ZCRoaaBP7KdDBx9QgNdLHyWosc4R8s17ygQYYkApMXFNk+YUNqRKXNWzF03uMQB6Epyk
	O5//Czj6U2uH31fLhIWiCE/NUmEyXs0BbjcV5a16c=
X-Google-Smtp-Source: AGHT+IELVqGsFyBemvslmYA30CZavjjBYh0FXqYFC6YoOCxRYmeBQDsEWpFjL+ya6H26BpSHDqeqzy8w2NOTHQ==
X-Received: from plfp2.prod.google.com ([2002:a17:902:e742:b0:22e:5728:685d])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:902:e786:b0:224:2a6d:55ae with SMTP id d9443c01a7336-22e5edf5679mr25520635ad.48.1746589396613;
 Tue, 06 May 2025 20:43:16 -0700 (PDT)
Date: Wed,  7 May 2025 03:43:13 +0000
In-Reply-To: <cover.1746588351.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1746588351.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <45d7e025f6e390a8ff36f08fc51e31705ac896bd.1746588351.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 5/8] selftests/bpf: Use CAN_USE_LOAD_ACQ_STORE_REL
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
Content-Transfer-Encoding: quoted-printable

Instead of open-coding the conditions, use
'#ifdef CAN_USE_LOAD_ACQ_STORE_REL' to guard the following tests:

  verifier_precision/bpf_load_acquire
  verifier_precision/bpf_store_release
  verifier_store_release/*

Note that, for the first two tests in verifier_precision.c, switching to
'#ifdef CAN_USE_LOAD_ACQ_STORE_REL' means also checking if
'__clang_major__ >=3D 18', which has already been guaranteed by the outer
'#if' check.

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # QEMU/RVA23
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 tools/testing/selftests/bpf/progs/verifier_precision.c     | 5 ++---
 tools/testing/selftests/bpf/progs/verifier_store_release.c | 7 +++----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/verifier_precision.c b/tools=
/testing/selftests/bpf/progs/verifier_precision.c
index 6662d4b39969..2dd0d15c2678 100644
--- a/tools/testing/selftests/bpf/progs/verifier_precision.c
+++ b/tools/testing/selftests/bpf/progs/verifier_precision.c
@@ -91,8 +91,7 @@ __naked int bpf_end_bswap(void)
 		::: __clobber_all);
 }
=20
-#if defined(ENABLE_ATOMICS_TESTS) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
+#ifdef CAN_USE_LOAD_ACQ_STORE_REL
=20
 SEC("?raw_tp")
 __success __log_level(2)
@@ -138,7 +137,7 @@ __naked int bpf_store_release(void)
 	: __clobber_all);
 }
=20
-#endif /* load-acquire, store-release */
+#endif /* CAN_USE_LOAD_ACQ_STORE_REL */
 #endif /* v4 instruction */
=20
 SEC("?raw_tp")
diff --git a/tools/testing/selftests/bpf/progs/verifier_store_release.c b/t=
ools/testing/selftests/bpf/progs/verifier_store_release.c
index c0442d5bb049..7e456e2861b4 100644
--- a/tools/testing/selftests/bpf/progs/verifier_store_release.c
+++ b/tools/testing/selftests/bpf/progs/verifier_store_release.c
@@ -6,8 +6,7 @@
 #include "../../../include/linux/filter.h"
 #include "bpf_misc.h"
=20
-#if __clang_major__ >=3D 18 && defined(ENABLE_ATOMICS_TESTS) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
+#ifdef CAN_USE_LOAD_ACQ_STORE_REL
=20
 SEC("socket")
 __description("store-release, 8-bit")
@@ -271,7 +270,7 @@ __naked void store_release_with_invalid_reg(void)
 	: __clobber_all);
 }
=20
-#else
+#else /* CAN_USE_LOAD_ACQ_STORE_REL */
=20
 SEC("socket")
 __description("Clang version < 18, ENABLE_ATOMICS_TESTS not defined, and/o=
r JIT doesn't support store-release, use a dummy test")
@@ -281,6 +280,6 @@ int dummy_test(void)
 	return 0;
 }
=20
-#endif
+#endif /* CAN_USE_LOAD_ACQ_STORE_REL */
=20
 char _license[] SEC("license") =3D "GPL";
--=20
2.49.0.967.g6a0df3ecc3-goog



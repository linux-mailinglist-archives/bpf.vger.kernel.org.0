Return-Path: <bpf+bounces-57623-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 934E9AAD42E
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 05:43:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8E21BA73D4
	for <lists+bpf@lfdr.de>; Wed,  7 May 2025 03:43:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 947711C1F0D;
	Wed,  7 May 2025 03:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CtgUtUdw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04B11B85CC
	for <bpf@vger.kernel.org>; Wed,  7 May 2025 03:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746589417; cv=none; b=aH8kFJvWSRakhr1bEl93uW8+xN++3JIsc9eIXR/x3woXmY/fzyvH6xx0zjKIaPIwXp/UFDzOzHrnis7joHUsZpORRAQ6Fa28uj38tu0Z579ySOEhfG45t0QctAMVeJM/Py7s6YIs8U2jLa7DsRGMiKKgfgjyRemF4H6lMbUyANs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746589417; c=relaxed/simple;
	bh=N1rmArSH8OQBJ2ZMuIxX6qjPi0FYZUbIRq8nzyX88Z0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=mpELR+1Y4G3BZOGbsM9iVMsXWMdIqA8Wg1l0u8u+Rh/FJrc4ZVxkP7lpjCd9AsPOIrX0wHXmgcCqH+EIM5LD3qAVsLKnCRZQQLSNrF1V4zXL1EGEHLyOdle2GEZFye9RHJqlJXEZDrIUDkSXRU7EEIVrU0jJUjKQJhgF1y7ofkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=CtgUtUdw; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-2c2b6cc2f94so4421399fac.1
        for <bpf@vger.kernel.org>; Tue, 06 May 2025 20:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1746589415; x=1747194215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iZn1GgGAG7mdxhx9lSWnDHMjgG27axMC/yttL1kxmb4=;
        b=CtgUtUdw3lecLOA5Z/KwrREMSxq58KeRPeuGHRiIetPJFWWbyd8M3Wni9z5DYmN/f8
         Wq2cnMugf0mHrFserLgiBYbkxoaHi4kNVlYFGWZRLpbbGXstd/YGATp+uhWNU/LextfY
         /+mpNAf1ICE7j66ATN3SxLQpR1e4jbYHK9be7OfSkgzjlvk4XgxdRNk6VIrUNVqEiIZp
         ilswXxos8PVFPdsmzGjBgdefB/S7sa7cUts9RIdQ7hoDUqyU4bagWVtBAdDvlaAxnSTb
         pc5fhBJMvHoIWQlV5Z5Jzg0AEZyhjzanYjy+k2Xg6tfvFEXi7AuT05ePbIBOK2P11ABJ
         56XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746589415; x=1747194215;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iZn1GgGAG7mdxhx9lSWnDHMjgG27axMC/yttL1kxmb4=;
        b=UuFTwF7FI8FrWlMRgDLZgTkHRveqIE7rbcTw0+d+5We3AughHyZVCigOToe/7//+zc
         pJS3TPuJH41IpXSq9WJ7kK9mxFNkiGTP31IFy0ulnbpotUnDpGsTkaE6TX5VrguoqDMv
         lmE2aIAW9neF8DG/lFrtpql9+qNcHYZD2n6WVXSM8Vfc8xB+y872i6Y5ZwEdaf6jHCff
         2cH4dHQixfDAhjemPcrqe2HUlzLBcpMioiCS6JiC8HdacG96b+zPyPX/oZ06yG9ElIiY
         E3+mj0xxdmxiP4d7AzeEBjn6XmBtcsOBoOe8A1TAyomGWGZC+HGRjxckkKPhALe+wVPn
         IXfg==
X-Gm-Message-State: AOJu0Yw7xJzC3rZFu5mZRCmCBYXQPIVlx8Suvu0t6xn1yx6redm3/N6y
	38rHh9EeT+X4+oStQFclGCgepLiWCAkH7DS7xnh2r3jOhSzNxU8r/gV5V3VM4qvDVYLCERAcpvL
	5JVE34wFmCjGUj/cJ2SwXNdkXbKoGp8eNn9ev4Axhj6jXIJUcsSdoHP6pCO/VxNUgi/ZGtp/tFj
	U7Yl3bMzboRAIwzgsCfC481YwqA3y0/xkg1vMoArU=
X-Google-Smtp-Source: AGHT+IGifRIHZ6qcU64u73ukgqSP22FlKicCrm9bweMfqYF2kqYgj7WzkdgP+PxImBJxxCpzzgu9q1HpZCCfVQ==
X-Received: from oabrb11.prod.google.com ([2002:a05:6871:618b:b0:2da:6d76:b15c])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6870:e243:b0:29e:24c7:2861 with SMTP id 586e51a60fabf-2db5be312b8mr1163209fac.13.1746589414619;
 Tue, 06 May 2025 20:43:34 -0700 (PDT)
Date: Wed,  7 May 2025 03:43:31 +0000
In-Reply-To: <cover.1746588351.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1746588351.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.967.g6a0df3ecc3-goog
Message-ID: <9d878fa99a72626208a8eed3c04c4140caf77fda.1746588351.git.yepeilin@google.com>
Subject: [PATCH bpf-next v2 8/8] selftests/bpf: Enable non-arena
 load-acquire/store-release selftests for riscv64
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

For riscv64, enable all BPF_{LOAD_ACQ,STORE_REL} selftests except the
arena_atomics/* ones (not guarded behind CAN_USE_LOAD_ACQ_STORE_REL),
since arena access is not yet supported.

Acked-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Reviewed-by: Pu Lehui <pulehui@huawei.com>
Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com> # QEMU/RVA23
Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/s=
elftests/bpf/progs/bpf_misc.h
index 863df7c0fdd0..6e208e24ba3b 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -225,8 +225,9 @@
 #define CAN_USE_BPF_ST
 #endif
=20
-#if __clang_major__ >=3D 18 && defined(ENABLE_ATOMICS_TESTS) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
+#if __clang_major__ >=3D 18 && defined(ENABLE_ATOMICS_TESTS) &&		\
+	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
+	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen =3D=3D 64))
 #define CAN_USE_LOAD_ACQ_STORE_REL
 #endif
=20
--=20
2.49.0.967.g6a0df3ecc3-goog



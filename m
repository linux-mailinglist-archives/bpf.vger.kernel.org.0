Return-Path: <bpf+bounces-21392-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2E5D84C562
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 08:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D1F61F22C3E
	for <lists+bpf@lfdr.de>; Wed,  7 Feb 2024 07:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C601D1CF9B;
	Wed,  7 Feb 2024 07:01:19 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from 66-220-155-179.mail-mxout.facebook.com (66-220-155-179.mail-mxout.facebook.com [66.220.155.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E67D31CD3C
	for <bpf@vger.kernel.org>; Wed,  7 Feb 2024 07:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.220.155.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707289279; cv=none; b=CbS6WLq7fJjhro3dcfw6EO2IxhbmArw0lAz/RIVZJm7Zvvtdft81Qi+JczSULW0UDscWgwtaF32Mfn+1FoF9Io0hHyZFqMQ/QEHda/iUpgQjjQs4avyLfLajg+yfnABbxRa8pmuiVFH4YqPttOz4S8ltEcTnRmexStcPHnr6434=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707289279; c=relaxed/simple;
	bh=OM5deIxSPXxHWJc2wR++Di1yPo3gSeGdl5BueDy4Ea4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4ljBGRipyHFkpWduFOO4yco906TcA7pj9Pt3bhHe3WhReueIuvo/Y2NNRZPyS+kFF8ukU4rovoBMO+2i+x2SaM3JERmtfEo+7S0MWreJS3n/aJBlj+8ZRsKvcBPYykm4YqRJuqkF7yGGx8SW+Rg+BpPn47NzayCyYYyaSn8+kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev; spf=fail smtp.mailfrom=linux.dev; arc=none smtp.client-ip=66.220.155.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linux.dev
Received: by devbig309.ftw3.facebook.com (Postfix, from userid 128203)
	id 14D962D6F9073; Tue,  6 Feb 2024 23:01:02 -0800 (PST)
From: Yonghong Song <yonghong.song@linux.dev>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	kernel-team@fb.com,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: Mark bpf_spin_{lock,unlock}() helpers with notrace correctly
Date: Tue,  6 Feb 2024 23:01:02 -0800
Message-Id: <20240207070102.335167-1-yonghong.song@linux.dev>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Currently tracing is supposed not to allow for bpf_spin_{lock,unlock}()
helper calls. This is to prevent deadlock for the following cases:
  - there is a prog (prog-A) calling bpf_spin_{lock,unlock}().
  - there is a tracing program (prog-B), e.g., fentry, attached
    to bpf_spin_lock() and/or bpf_spin_unlock().
  - prog-B calls bpf_spin_{lock,unlock}().
For such a case, when prog-A calls bpf_spin_{lock,unlock}(),
a deadlock will happen.

The related source codes are below in kernel/bpf/helpers.c:
  notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
  notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
notrace is supposed to prevent fentry prog from attaching to
bpf_spin_{lock,unlock}().

But actually this is not the case and fentry prog can successfully
attached to bpf_spin_lock(). Siddharth Chintamaneni reported
the issue in [1]. The following is the macro definition for
above BPF_CALL_1:
  #define BPF_CALL_x(x, name, ...)                                       =
        \
        static __always_inline                                           =
      \
        u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__=
));   \
        typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, =
__VA_ARGS__)); \
        u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));   =
      \
        u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))    =
      \
        {                                                                =
      \
                return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__=
BPF_N,__VA_ARGS__));\
        }                                                                =
      \
        static __always_inline                                           =
      \
        u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__=
))

  #define BPF_CALL_1(name, ...)   BPF_CALL_x(1, name, __VA_ARGS__)

The notrace attribute is actually applied to the static always_inline fun=
ction
____bpf_spin_{lock,unlock}(). The actual callback function
bpf_spin_{lock,unlock}() is not marked with notrace, hence
allowing fentry prog to attach to two helpers, and this
may cause the above mentioned deadlock. Siddharth Chintamaneni
actually has a reproducer in [2].

To fix the issue, a new macro NOTRACE_BPF_CALL_1 is introduced which
will add notrace attribute to the original function instead of
the hidden always_inline function and this fixed the problem.

  [1] https://lore.kernel.org/bpf/CAE5sdEigPnoGrzN8WU7Tx-h-iFuMZgW06qp0KH=
WtpvoXxf1OAQ@mail.gmail.com/
  [2] https://lore.kernel.org/bpf/CAE5sdEg6yUc_Jz50AnUXEEUh6O73yQ1Z6NV2sr=
Jnef0ZrQkZew@mail.gmail.com/

Fixes: d83525ca62cf ("bpf: introduce bpf_spin_lock")
Cc: Siddharth Chintamaneni <sidchintamaneni@gmail.com>
Signed-off-by: Yonghong Song <yonghong.song@linux.dev>
---
 include/linux/filter.h | 21 ++++++++++++---------
 kernel/bpf/helpers.c   |  4 ++--
 2 files changed, 14 insertions(+), 11 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index fee070b9826e..36cc29a2934c 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -547,24 +547,27 @@ static inline bool insn_is_zext(const struct bpf_in=
sn *insn)
 	__BPF_MAP(n, __BPF_DECL_ARGS, __BPF_N, u64, __ur_1, u64, __ur_2,       =
\
 		  u64, __ur_3, u64, __ur_4, u64, __ur_5)
=20
-#define BPF_CALL_x(x, name, ...)					       \
+#define BPF_CALL_x(x, attr, name, ...)					       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__));   =
\
 	typedef u64 (*btf_##name)(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_A=
RGS__)); \
-	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));	       \
-	u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))	       \
+	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__));    =
\
+	attr u64 name(__BPF_REG(x, __BPF_DECL_REGS, __BPF_N, __VA_ARGS__))     =
\
 	{								       \
 		return ((btf_##name)____##name)(__BPF_MAP(x,__BPF_CAST,__BPF_N,__VA_AR=
GS__));\
 	}								       \
 	static __always_inline						       \
 	u64 ____##name(__BPF_MAP(x, __BPF_DECL_ARGS, __BPF_V, __VA_ARGS__))
=20
-#define BPF_CALL_0(name, ...)	BPF_CALL_x(0, name, __VA_ARGS__)
-#define BPF_CALL_1(name, ...)	BPF_CALL_x(1, name, __VA_ARGS__)
-#define BPF_CALL_2(name, ...)	BPF_CALL_x(2, name, __VA_ARGS__)
-#define BPF_CALL_3(name, ...)	BPF_CALL_x(3, name, __VA_ARGS__)
-#define BPF_CALL_4(name, ...)	BPF_CALL_x(4, name, __VA_ARGS__)
-#define BPF_CALL_5(name, ...)	BPF_CALL_x(5, name, __VA_ARGS__)
+#define __NOATTR
+#define BPF_CALL_0(name, ...)	BPF_CALL_x(0, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_1(name, ...)	BPF_CALL_x(1, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_2(name, ...)	BPF_CALL_x(2, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_3(name, ...)	BPF_CALL_x(3, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_4(name, ...)	BPF_CALL_x(4, __NOATTR, name, __VA_ARGS__)
+#define BPF_CALL_5(name, ...)	BPF_CALL_x(5, __NOATTR, name, __VA_ARGS__)
+
+#define NOTRACE_BPF_CALL_1(name, ...)	BPF_CALL_x(1, notrace, name, __VA_=
ARGS__)
=20
 #define bpf_ctx_range(TYPE, MEMBER)						\
 	offsetof(TYPE, MEMBER) ... offsetofend(TYPE, MEMBER) - 1
diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 4db1c658254c..87136e27a99a 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -334,7 +334,7 @@ static inline void __bpf_spin_lock_irqsave(struct bpf=
_spin_lock *lock)
 	__this_cpu_write(irqsave_flags, flags);
 }
=20
-notrace BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
+NOTRACE_BPF_CALL_1(bpf_spin_lock, struct bpf_spin_lock *, lock)
 {
 	__bpf_spin_lock_irqsave(lock);
 	return 0;
@@ -357,7 +357,7 @@ static inline void __bpf_spin_unlock_irqrestore(struc=
t bpf_spin_lock *lock)
 	local_irq_restore(flags);
 }
=20
-notrace BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
+NOTRACE_BPF_CALL_1(bpf_spin_unlock, struct bpf_spin_lock *, lock)
 {
 	__bpf_spin_unlock_irqrestore(lock);
 	return 0;
--=20
2.34.1



Return-Path: <bpf+bounces-19163-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF99825E98
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 07:55:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCE811F23E41
	for <lists+bpf@lfdr.de>; Sat,  6 Jan 2024 06:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9A83FDD;
	Sat,  6 Jan 2024 06:55:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="yOcIiVCB"
X-Original-To: bpf@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AA728F3;
	Sat,  6 Jan 2024 06:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=OuVdUPjUvU4/6iSnWx34w41LnQL5QQ6HXu6RyAkm9Bc=; b=yOcIiVCBn/mREvuXDvq8dQNSrM
	kPMJ1RY531i/cUKvqHE+ZB2V0QsBVn6IGxBpupWpcMJ6FZhHHpzqUtuKBGB9anMFvScHeBUNIHuSI
	IZtE1+roTYlzY9YZI8ipiAIJYTmwONsXE6TCr5Q5jizWYqZHFPZ+Aat8pAwC+46kmgREZ4cAnMpPN
	9l/3RgaxloDOjqG4uXTWxLvOncqGs26+qZnd9453JL2wREqcs5Nf8LqLCKGuVxfJp+L8772uMVhkf
	tKig/QksdHFSwzmiWMWWS0TF2JD2Rp9BnC1jFP+pEiOWMZbIEok63iR4iWEsTFmnURNFtKbq3qsQn
	c5uHVkhA==;
Received: from [50.53.46.231] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rM0aw-000rYt-0K;
	Sat, 06 Jan 2024 06:55:46 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	bpf@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH bpf-next] net: filter: fix spelling mistakes
Date: Fri,  5 Jan 2024 22:55:45 -0800
Message-ID: <20240106065545.16855-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling errors as reported by codespell.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: bpf@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
base-commit: 610a9b8f49fbcf1100716370d3b5f6f884a2835a

 net/core/filter.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff -- a/net/core/filter.c b/net/core/filter.c
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -777,7 +777,7 @@ jmp_rest:
 			BPF_EMIT_JMP;
 			break;
 
-		/* ldxb 4 * ([14] & 0xf) is remaped into 6 insns. */
+		/* ldxb 4 * ([14] & 0xf) is remapped into 6 insns. */
 		case BPF_LDX | BPF_MSH | BPF_B: {
 			struct sock_filter tmp = {
 				.code	= BPF_LD | BPF_ABS | BPF_B,
@@ -803,7 +803,7 @@ jmp_rest:
 			*insn = BPF_MOV64_REG(BPF_REG_A, BPF_REG_TMP);
 			break;
 		}
-		/* RET_K is remaped into 2 insns. RET_A case doesn't need an
+		/* RET_K is remapped into 2 insns. RET_A case doesn't need an
 		 * extra mov as BPF_REG_0 is already mapped into BPF_REG_A.
 		 */
 		case BPF_RET | BPF_A:
@@ -2967,7 +2967,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_m
 	 *
 	 * Then if B is non-zero AND there is no space allocate space and
 	 * compact A, B regions into page. If there is space shift ring to
-	 * the rigth free'ing the next element in ring to place B, leaving
+	 * the right free'ing the next element in ring to place B, leaving
 	 * A untouched except to reduce length.
 	 */
 	if (start != offset) {
@@ -8226,7 +8226,7 @@ xdp_func_proto(enum bpf_func_id func_id,
 #if IS_MODULE(CONFIG_NF_CONNTRACK) && IS_ENABLED(CONFIG_DEBUG_INFO_BTF_MODULES)
 	/* The nf_conn___init type is used in the NF_CONNTRACK kfuncs. The
 	 * kfuncs are defined in two different modules, and we want to be able
-	 * to use them interchangably with the same BTF type ID. Because modules
+	 * to use them interchangeably with the same BTF type ID. Because modules
 	 * can't de-duplicate BTF IDs between each other, we need the type to be
 	 * referenced in the vmlinux BTF or the verifier will get confused about
 	 * the different types. So we add this dummy type reference which will


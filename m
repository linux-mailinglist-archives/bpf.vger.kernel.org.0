Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FF21605DF
	for <lists+bpf@lfdr.de>; Sun, 16 Feb 2020 20:30:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726962AbgBPTaf convert rfc822-to-8bit (ORCPT
        <rfc822;lists+bpf@lfdr.de>); Sun, 16 Feb 2020 14:30:35 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:55186 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726723AbgBPTaf (ORCPT
        <rfc822;bpf@vger.kernel.org>); Sun, 16 Feb 2020 14:30:35 -0500
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-299-mCPlwMRjOAuVMvl5v74mnQ-1; Sun, 16 Feb 2020 14:30:30 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2E30E107ACC4;
        Sun, 16 Feb 2020 19:30:28 +0000 (UTC)
Received: from krava.redhat.com (ovpn-204-28.brq.redhat.com [10.40.204.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4B29F8AC5B;
        Sun, 16 Feb 2020 19:30:24 +0000 (UTC)
From:   Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        Song Liu <songliubraving@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Jakub Kicinski <kuba@kernel.org>,
        David Miller <davem@redhat.com>,
        =?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?= <bjorn.topel@intel.com>,
        John Fastabend <john.fastabend@gmail.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 03/18] bpf: Add struct bpf_ksym
Date:   Sun, 16 Feb 2020 20:29:50 +0100
Message-Id: <20200216193005.144157-4-jolsa@kernel.org>
In-Reply-To: <20200216193005.144157-1-jolsa@kernel.org>
References: <20200216193005.144157-1-jolsa@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: mCPlwMRjOAuVMvl5v74mnQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: 8BIT
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding 'struct bpf_ksym' object that will carry the
kallsym information for bpf symbol. Adding the start
and end address to begin with. It will be used by
bpf_prog, bpf_trampoline, bpf_dispatcher.

Using the bpf_func for program symbol start instead
of the image start, because it will be used later for
kallsyms program value and it makes no difference
(compared to the image start) for sorting bpf programs.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/bpf.h |  6 ++++++
 kernel/bpf/core.c   | 26 +++++++++++---------------
 2 files changed, 17 insertions(+), 15 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index be7afccc9459..5ad8eea1cd37 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -462,6 +462,11 @@ int arch_prepare_bpf_trampoline(void *image, void *image_end,
 u64 notrace __bpf_prog_enter(void);
 void notrace __bpf_prog_exit(struct bpf_prog *prog, u64 start);
 
+struct bpf_ksym {
+	unsigned long		 start;
+	unsigned long		 end;
+};
+
 enum bpf_tramp_prog_type {
 	BPF_TRAMP_FENTRY,
 	BPF_TRAMP_FEXIT,
@@ -643,6 +648,7 @@ struct bpf_prog_aux {
 	u32 size_poke_tab;
 	struct latch_tree_node ksym_tnode;
 	struct list_head ksym_lnode;
+	struct bpf_ksym ksym;
 	const struct bpf_prog_ops *ops;
 	struct bpf_map **used_maps;
 	struct bpf_prog *prog;
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index 973a20d49749..39a9e4184900 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -524,17 +524,15 @@ int bpf_jit_harden   __read_mostly;
 long bpf_jit_limit   __read_mostly;
 
 static __always_inline void
-bpf_get_prog_addr_region(const struct bpf_prog *prog,
-			 unsigned long *symbol_start,
-			 unsigned long *symbol_end)
+bpf_get_prog_addr_region(const struct bpf_prog *prog)
 {
 	const struct bpf_binary_header *hdr = bpf_jit_binary_hdr(prog);
 	unsigned long addr = (unsigned long)hdr;
 
 	WARN_ON_ONCE(!bpf_prog_ebpf_jited(prog));
 
-	*symbol_start = addr;
-	*symbol_end   = addr + hdr->pages * PAGE_SIZE;
+	prog->aux->ksym.start = (unsigned long) prog->bpf_func;
+	prog->aux->ksym.end   = addr + hdr->pages * PAGE_SIZE;
 }
 
 void bpf_get_prog_name(const struct bpf_prog *prog, char *sym)
@@ -575,13 +573,10 @@ void bpf_get_prog_name(const struct bpf_prog *prog, char *sym)
 static __always_inline unsigned long
 bpf_get_prog_addr_start(struct latch_tree_node *n)
 {
-	unsigned long symbol_start, symbol_end;
 	const struct bpf_prog_aux *aux;
 
 	aux = container_of(n, struct bpf_prog_aux, ksym_tnode);
-	bpf_get_prog_addr_region(aux->prog, &symbol_start, &symbol_end);
-
-	return symbol_start;
+	return aux->ksym.start;
 }
 
 static __always_inline bool bpf_tree_less(struct latch_tree_node *a,
@@ -593,15 +588,13 @@ static __always_inline bool bpf_tree_less(struct latch_tree_node *a,
 static __always_inline int bpf_tree_comp(void *key, struct latch_tree_node *n)
 {
 	unsigned long val = (unsigned long)key;
-	unsigned long symbol_start, symbol_end;
 	const struct bpf_prog_aux *aux;
 
 	aux = container_of(n, struct bpf_prog_aux, ksym_tnode);
-	bpf_get_prog_addr_region(aux->prog, &symbol_start, &symbol_end);
 
-	if (val < symbol_start)
+	if (val < aux->ksym.start)
 		return -1;
-	if (val >= symbol_end)
+	if (val >= aux->ksym.end)
 		return  1;
 
 	return 0;
@@ -649,6 +642,8 @@ void bpf_prog_kallsyms_add(struct bpf_prog *fp)
 	    !capable(CAP_SYS_ADMIN))
 		return;
 
+	bpf_get_prog_addr_region(fp);
+
 	spin_lock_bh(&bpf_lock);
 	bpf_prog_ksym_node_add(fp->aux);
 	spin_unlock_bh(&bpf_lock);
@@ -677,14 +672,15 @@ static struct bpf_prog *bpf_prog_kallsyms_find(unsigned long addr)
 const char *__bpf_address_lookup(unsigned long addr, unsigned long *size,
 				 unsigned long *off, char *sym)
 {
-	unsigned long symbol_start, symbol_end;
 	struct bpf_prog *prog;
 	char *ret = NULL;
 
 	rcu_read_lock();
 	prog = bpf_prog_kallsyms_find(addr);
 	if (prog) {
-		bpf_get_prog_addr_region(prog, &symbol_start, &symbol_end);
+		unsigned long symbol_start = prog->aux->ksym.start;
+		unsigned long symbol_end = prog->aux->ksym.end;
+
 		bpf_get_prog_name(prog, sym);
 
 		ret = sym;
-- 
2.24.1


Return-Path: <bpf+bounces-5512-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B75E875B48A
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 18:35:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E82411C20442
	for <lists+bpf@lfdr.de>; Thu, 20 Jul 2023 16:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C251C25913;
	Thu, 20 Jul 2023 16:34:16 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967B619BDF
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 16:34:16 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5B935B1
	for <bpf@vger.kernel.org>; Thu, 20 Jul 2023 09:33:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1689870828;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2k5nztFy3WXKlhL7LY6m+LcDW7MzG+nauWvTii+Ef4=;
	b=XnHifS87FFk+0IOaLZTdT2BOaIlz2mAC28VuKuE96X6vZ10Mb5RMB2I6643dcLVg2GI+kV
	V+YJZi4m1Tvs4x3LCajjXkuuSp04Eq5jmavfYoIUxgVAJAp4hA+CzDqP9kzF2XC8r7dvlF
	gT8dhEA/lIBCRPgZhwBx/2GY/EYgbRs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-77-dQqQ7nvGOe-_KMx6MDuCag-1; Thu, 20 Jul 2023 12:33:43 -0400
X-MC-Unique: dQqQ7nvGOe-_KMx6MDuCag-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id F1ADA1044592;
	Thu, 20 Jul 2023 16:33:33 +0000 (UTC)
Received: from vschneid.remote.csb (unknown [10.42.28.48])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id F11B740C206F;
	Thu, 20 Jul 2023 16:33:25 +0000 (UTC)
From: Valentin Schneider <vschneid@redhat.com>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-mm@kvack.org,
	bpf@vger.kernel.org,
	x86@kernel.org,
	rcu@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Cc: Josh Poimboeuf <jpoimboe@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Wanpeng Li <wanpengli@tencent.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Christoph Hellwig <hch@infradead.org>,
	Lorenzo Stoakes <lstoakes@gmail.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Jason Baron <jbaron@akamai.com>,
	Kees Cook <keescook@chromium.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	Ard Biesheuvel <ardb@kernel.org>,
	Nicholas Piggin <npiggin@gmail.com>,
	Juerg Haefliger <juerg.haefliger@canonical.com>,
	Nicolas Saenz Julienne <nsaenz@kernel.org>,
	"Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Nadav Amit <namit@vmware.com>,
	Dan Carpenter <error27@gmail.com>,
	Chuang Wang <nashuiliang@gmail.com>,
	Yang Jihong <yangjihong1@huawei.com>,
	Petr Mladek <pmladek@suse.com>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	Song Liu <song@kernel.org>,
	Julian Pidancet <julian.pidancet@oracle.com>,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Dionna Glaze <dionnaglaze@google.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Juri Lelli <juri.lelli@redhat.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Marcelo Tosatti <mtosatti@redhat.com>,
	Yair Podemsky <ypodemsk@redhat.com>
Subject: [RFC PATCH v2 12/20] objtool: Warn about non __ro_after_init static key usage in .noinstr
Date: Thu, 20 Jul 2023 17:30:48 +0100
Message-Id: <20230720163056.2564824-13-vschneid@redhat.com>
In-Reply-To: <20230720163056.2564824-1-vschneid@redhat.com>
References: <20230720163056.2564824-1-vschneid@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
	T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Later commits will depend on having no runtime-mutable text in early entry
code. (ab)use the .noinstr section as a marker of early entry code and warn
about static keys used in it that can be flipped at runtime.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
---
 tools/objtool/check.c                   | 20 ++++++++++++++++++++
 tools/objtool/include/objtool/check.h   |  1 +
 tools/objtool/include/objtool/special.h |  2 ++
 tools/objtool/special.c                 |  3 +++
 4 files changed, 26 insertions(+)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index d308330f2910e..d973bb4df4341 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -1968,6 +1968,9 @@ static int add_special_section_alts(struct objtool_file *file)
 		alt->next = orig_insn->alts;
 		orig_insn->alts = alt;
 
+		if (special_alt->key_sym)
+			orig_insn->key_sym = special_alt->key_sym;
+
 		list_del(&special_alt->list);
 		free(special_alt);
 	}
@@ -3476,6 +3479,20 @@ static int validate_return(struct symbol *func, struct instruction *insn, struct
 	return 0;
 }
 
+static int validate_static_key(struct instruction *insn, struct insn_state *state)
+{
+	if (state->noinstr && state->instr <= 0) {
+		if ((strcmp(insn->key_sym->sec->name, ".data..ro_after_init"))) {
+			WARN_INSN(insn,
+				  "Non __ro_after_init static key \"%s\" in .noinstr section",
+				  insn->key_sym->name);
+			return 1;
+		}
+	}
+
+	return 0;
+}
+
 static struct instruction *next_insn_to_validate(struct objtool_file *file,
 						 struct instruction *insn)
 {
@@ -3625,6 +3642,9 @@ static int validate_branch(struct objtool_file *file, struct symbol *func,
 		if (handle_insn_ops(insn, next_insn, &state))
 			return 1;
 
+		if (insn->key_sym)
+			validate_static_key(insn, &state);
+
 		switch (insn->type) {
 
 		case INSN_RETURN:
diff --git a/tools/objtool/include/objtool/check.h b/tools/objtool/include/objtool/check.h
index daa46f1f0965a..35dd21f8f41e1 100644
--- a/tools/objtool/include/objtool/check.h
+++ b/tools/objtool/include/objtool/check.h
@@ -77,6 +77,7 @@ struct instruction {
 	struct symbol *sym;
 	struct stack_op *stack_ops;
 	struct cfi_state *cfi;
+	struct symbol *key_sym;
 };
 
 static inline struct symbol *insn_func(struct instruction *insn)
diff --git a/tools/objtool/include/objtool/special.h b/tools/objtool/include/objtool/special.h
index 86d4af9c5aa9d..0e61f34fe3a28 100644
--- a/tools/objtool/include/objtool/special.h
+++ b/tools/objtool/include/objtool/special.h
@@ -27,6 +27,8 @@ struct special_alt {
 	struct section *new_sec;
 	unsigned long new_off;
 
+	struct symbol *key_sym;
+
 	unsigned int orig_len, new_len; /* group only */
 };
 
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 91b1950f5bd8a..1f76cfd815bf3 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -127,6 +127,9 @@ static int get_alt_entry(struct elf *elf, const struct special_entry *entry,
 			return -1;
 		}
 		alt->key_addend = reloc_addend(key_reloc);
+
+		reloc_to_sec_off(key_reloc, &sec, &offset);
+		alt->key_sym = find_symbol_by_offset(sec, offset & ~2);
 	}
 
 	return 0;
-- 
2.31.1



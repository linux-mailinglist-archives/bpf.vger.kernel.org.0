Return-Path: <bpf+bounces-606-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF3D70462A
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 09:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3269D281579
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 07:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84121D2CA;
	Tue, 16 May 2023 07:19:17 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC7823D6
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 07:19:17 +0000 (UTC)
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2689F46AD;
	Tue, 16 May 2023 00:19:14 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-5304913530fso7345378a12.0;
        Tue, 16 May 2023 00:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684221553; x=1686813553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jr5NPUEwkf/u+a01SSpONco/9bXEcFxv1oXkCOl3FZE=;
        b=EETW6bHqHomRMsgD7YwoEi5wGWOvuvUQPS5Ju99GCoG1L2KVXB02G3RhY7foR5wcxT
         9qk2729vqdHUBs/pd2pWIDxJQ41HkdsgjKd/SkBEF3N5nQkqWYHNMhL/Acajd5GJBRGN
         Ghq0SqII6TJVkjpQH3NQOcHU8INAKaI6o0N7NPDp3ItBsuJOavR8tQtyLVyQpkYcovQe
         YZuH5S/jLE9FPzRN5NQwbaHKMJ8KfENjGGKqF9yZk5RxPhjFfZRxnu+CRh4xIA450mDK
         yx3mN/9CHAvrI7fY45zdVHWZcsvNx7rGyQiP7NBrqlFlf8g/w5bATrXflh9PrNZ6n4cy
         NdPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221553; x=1686813553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jr5NPUEwkf/u+a01SSpONco/9bXEcFxv1oXkCOl3FZE=;
        b=Gh6JluKcZjkiXjM4gwvn7pqGPzcUS0MaU1hgof+eKQvWDHfImnbyuzfWmkdvuP7j49
         kgJ/BqzXQBi+CZzF44i/7AGMkPP9fL20Y+8Bo6eI4ASeLjoAwQLTnSSwiArwDwNi06TI
         0bzvYCji8lUINqQvfZwLlwhyLZyj70UG1DeBHddHWPgc83fSuSI9/EI5nvEQAmkETYv5
         bCxkd0hgUOGEkmEaupYvXnI9Lx/w+UZ6aMJGvIpcPweJDSMVi2tbB+DyTyiaKEm+NDIn
         wI10po+RklkVOCndQjGLSBGmscIGrTs0cEbnwTRwE1TRTozxY7u+VIyO1YvZRvE3ygs0
         sYoQ==
X-Gm-Message-State: AC+VfDzPK0Wmcf9ys+zGFMTcq7wAoaeqh2Cmmce62w1/TOxddxrCDWxM
	ZDwLl2SEXVslftf1PQ2ciDE=
X-Google-Smtp-Source: ACHHUZ4Dc8GN0ScaYumqglWnIGdVbNPTRaxTAFIL1qdwTFP4Pvli4wXAG4X9k3dkvEhAaUizWxQ2eQ==
X-Received: by 2002:a05:6a21:6da3:b0:101:438d:2567 with SMTP id wl35-20020a056a216da300b00101438d2567mr31331268pzb.31.1684221553498;
        Tue, 16 May 2023 00:19:13 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.15])
        by smtp.googlemail.com with ESMTPSA id 17-20020aa79251000000b006468222af91sm12849830pfp.48.2023.05.16.00.19.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:19:13 -0700 (PDT)
From: Ze Gao <zegao2021@gmail.com>
X-Google-Original-From: Ze Gao <zegao@tencent.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Albert Ou <aou@eecs.berkeley.edu>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Ingo Molnar <mingo@redhat.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	x86@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Conor Dooley <conor@kernel.org>,
	Jiri Olsa <jolsa@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	Ze Gao <zegao@tencent.com>
Subject: [PATCH v2 2/4] fprobe: make fprobe_kprobe_handler recursion free
Date: Tue, 16 May 2023 15:18:28 +0800
Message-Id: <20230516071830.8190-3-zegao@tencent.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230516071830.8190-1-zegao@tencent.com>
References: <20230516071830.8190-1-zegao@tencent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
	FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
	T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Current implementation calls kprobe related functions before doing
ftrace recursion check in fprobe_kprobe_handler, which opens door
to kernel crash due to stack recursion if preempt_count_{add, sub}
is traceable.

Refactor the common part out of fprobe_kprobe_handler and fprobe_
handler and call ftrace recursion detection at the very beginning,
so that the whole fprobe_kprobe_handler is free from recursion.

Signed-off-by: Ze Gao <zegao@tencent.com>
---
 kernel/trace/fprobe.c | 59 ++++++++++++++++++++++++++++++++-----------
 1 file changed, 44 insertions(+), 15 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 9abb3905bc8e..097c740799ba 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -20,30 +20,22 @@ struct fprobe_rethook_node {
 	char data[];
 };
 
-static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
-			   struct ftrace_ops *ops, struct ftrace_regs *fregs)
+static inline void __fprobe_handler(unsigned long ip, unsigned long
+		parent_ip, struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
 	struct fprobe_rethook_node *fpr;
 	struct rethook_node *rh = NULL;
 	struct fprobe *fp;
 	void *entry_data = NULL;
-	int bit, ret;
+	int ret;
 
 	fp = container_of(ops, struct fprobe, ops);
-	if (fprobe_disabled(fp))
-		return;
-
-	bit = ftrace_test_recursion_trylock(ip, parent_ip);
-	if (bit < 0) {
-		fp->nmissed++;
-		return;
-	}
 
 	if (fp->exit_handler) {
 		rh = rethook_try_get(fp->rethook);
 		if (!rh) {
 			fp->nmissed++;
-			goto out;
+			return;
 		}
 		fpr = container_of(rh, struct fprobe_rethook_node, node);
 		fpr->entry_ip = ip;
@@ -61,23 +53,60 @@ static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
 		else
 			rethook_hook(rh, ftrace_get_regs(fregs), true);
 	}
-out:
+}
+
+static void fprobe_handler(unsigned long ip, unsigned long parent_ip,
+		struct ftrace_ops *ops, struct ftrace_regs *fregs)
+{
+	struct fprobe *fp;
+	int bit;
+
+	fp = container_of(ops, struct fprobe, ops);
+	if (fprobe_disabled(fp))
+		return;
+
+	/* recursion detection has to go before any traceable function and
+	 * all functions before this point should be marked as notrace
+	 */
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
+	__fprobe_handler(ip, parent_ip, ops, fregs);
 	ftrace_test_recursion_unlock(bit);
+
 }
 NOKPROBE_SYMBOL(fprobe_handler);
 
 static void fprobe_kprobe_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
-	struct fprobe *fp = container_of(ops, struct fprobe, ops);
+	struct fprobe *fp;
+	int bit;
+
+	fp = container_of(ops, struct fprobe, ops);
+	if (fprobe_disabled(fp))
+		return;
+
+	/* recursion detection has to go before any traceable function and
+	 * all functions called before this point should be marked as notrace
+	 */
+	bit = ftrace_test_recursion_trylock(ip, parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
 
 	if (unlikely(kprobe_running())) {
 		fp->nmissed++;
 		return;
 	}
+
 	kprobe_busy_begin();
-	fprobe_handler(ip, parent_ip, ops, fregs);
+	__fprobe_handler(ip, parent_ip, ops, fregs);
 	kprobe_busy_end();
+	ftrace_test_recursion_unlock(bit);
 }
 
 static void fprobe_exit_handler(struct rethook_node *rh, void *data,
-- 
2.40.1



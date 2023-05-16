Return-Path: <bpf+bounces-607-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AB7270462D
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 09:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A5B21C20D7B
	for <lists+bpf@lfdr.de>; Tue, 16 May 2023 07:19:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BA781D2D0;
	Tue, 16 May 2023 07:19:28 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D232123D6
	for <bpf@vger.kernel.org>; Tue, 16 May 2023 07:19:27 +0000 (UTC)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C03C4421F;
	Tue, 16 May 2023 00:19:25 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-517c840f181so7415884a12.3;
        Tue, 16 May 2023 00:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684221565; x=1686813565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BaoLZ/dBLXvTx6mYn8gtFpoeO4MZOVPTvDmN/MOLVfI=;
        b=elodM/SNoJ9U0KRWKOkpJzY7sFOiiAwcySNutlxkuaECCMGs57bNTYUgGLf7apLnmF
         mU/pSRkqEVZ+7rPyRZ8YnO5x6wQkUTqvaRf83bRRsM+c240BE9sqFwEfNXNWfv/FNwJA
         Abife5G2U8Ob1Vo7SKvledXlBqRahn+vDQEt128UyR/hVyMcaCWGJ9fEZW2nu06zUDc0
         mWDQhiS8sp9WifrjGN17a5aB1CK9y9Xn+g2KbKBlwWt6GeKGgh/BvMhR11+zQ/z+XWCm
         PJ6B9ImSBH/O+DzeIXV5HWmld40h6QxUu5PlUm4lP7A2N1biHL1brTeyyC47cMr4CWJ/
         Nj7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684221565; x=1686813565;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BaoLZ/dBLXvTx6mYn8gtFpoeO4MZOVPTvDmN/MOLVfI=;
        b=iB1TFAn/AF/zBkbmguFL3okx7V8A2xvaIqRkMCtbZnyHnQGbVPyWJp+dfDZFcCGbms
         NT2v/XOsu1jRUV5rTnzhy/RQVnYrnm2vgjuxrQZ05q6PB2DpWE3kfbVVPGu3Pz8z5La2
         mxp7kMKkOrBkzsDVC0Ma8ujkjWxH5dL7K2iHgKm/gkUG43Rl96UgpCGrCcZdB4gjgteI
         DHEhLm1KhLHTsHLgDUtysTa0x/3lPjQzOvg5GIpU05SZvDrarRoqcctOfH3189GhO97W
         gHaZQTavb4qODEdYjiFrJY1MXxOlldR3VrV1G2OLfyYM4unG2P+t+6jgOfZjs5c/HqRe
         j7Xw==
X-Gm-Message-State: AC+VfDwI8W+YxVg3pdg9KEbxQC2YEtzCfFuUl7HmnZBoMtArjrwhe83i
	B3LviwNvyFZlp/8nmRv3mFPSlDR8z/eK5Q==
X-Google-Smtp-Source: ACHHUZ7zmE9tB+Tt39iDRwR5jnUySn9p2UAGvLn4sbEBRIBIZD0ChrIJ6ul7+Gsmvs3NAPZH9ShHOQ==
X-Received: by 2002:a05:6a20:8f10:b0:102:345f:593b with SMTP id b16-20020a056a208f1000b00102345f593bmr28960762pzk.4.1684221565221;
        Tue, 16 May 2023 00:19:25 -0700 (PDT)
Received: from localhost.localdomain ([203.205.141.15])
        by smtp.googlemail.com with ESMTPSA id 17-20020aa79251000000b006468222af91sm12849830pfp.48.2023.05.16.00.19.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 00:19:24 -0700 (PDT)
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
	Ze Gao <zegao@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] fprobe: add recursion detection in fprobe_exit_handler
Date: Tue, 16 May 2023 15:18:29 +0800
Message-Id: <20230516071830.8190-4-zegao@tencent.com>
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

fprobe_hander and fprobe_kprobe_handler has guarded ftrace recursion
detection but fprobe_exit_handler has not, which possibly introduce
recursive calls if the fprobe exit callback calls any traceable
functions. Checking in fprobe_hander or fprobe_kprobe_handler
is not enough and misses this case.

So add recursion free guard the same way as fprobe_hander. Since
ftrace recursion check does not employ ip(s), so here use entry_ip and
entry_parent_ip the same as fprobe_handler.

Fixes: 5b0ab78998e3 ("fprobe: Add exit_handler support")
Signed-off-by: Ze Gao <zegao@tencent.com>
Cc: stable@vger.kernel.org
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/fprobe.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index 097c740799ba..a9580a88cc15 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -17,6 +17,7 @@
 struct fprobe_rethook_node {
 	struct rethook_node node;
 	unsigned long entry_ip;
+	unsigned long entry_parent_ip;
 	char data[];
 };
 
@@ -39,6 +40,7 @@ static inline void __fprobe_handler(unsigned long ip, unsigned long
 		}
 		fpr = container_of(rh, struct fprobe_rethook_node, node);
 		fpr->entry_ip = ip;
+		fpr->entry_parent_ip = parent_ip;
 		if (fp->entry_data_size)
 			entry_data = fpr->data;
 	}
@@ -114,14 +116,25 @@ static void fprobe_exit_handler(struct rethook_node *rh, void *data,
 {
 	struct fprobe *fp = (struct fprobe *)data;
 	struct fprobe_rethook_node *fpr;
+	int bit;
 
 	if (!fp || fprobe_disabled(fp))
 		return;
 
 	fpr = container_of(rh, struct fprobe_rethook_node, node);
 
+	/* we need to assure no calls to traceable functions in-between the
+	 * end of fprobe_handler and the beginning of fprobe_exit_handler.
+	 */
+	bit = ftrace_test_recursion_trylock(fpr->entry_ip, fpr->entry_parent_ip);
+	if (bit < 0) {
+		fp->nmissed++;
+		return;
+	}
+
 	fp->exit_handler(fp, fpr->entry_ip, regs,
 			 fp->entry_data_size ? (void *)fpr->data : NULL);
+	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(fprobe_exit_handler);
 
-- 
2.40.1



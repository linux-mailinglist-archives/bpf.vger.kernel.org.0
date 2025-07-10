Return-Path: <bpf+bounces-62887-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7115FAFFA6D
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 09:10:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A3572167C64
	for <lists+bpf@lfdr.de>; Thu, 10 Jul 2025 07:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB752877FB;
	Thu, 10 Jul 2025 07:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GYao3mMp"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f195.google.com (mail-pg1-f195.google.com [209.85.215.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053C3FC1D;
	Thu, 10 Jul 2025 07:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752131405; cv=none; b=lqN/H+P7rTqYDTYRKI+d7bFH1bVaUJoHqXtrTfdhkAamhppB0sone9gHPoKOKBXG9pMWBRwlO1hbcrvTkSvg27jlB+S6uqNiT0jwYI816abVf/YGDKU+gnvdb3rfk5U10DMY6czRumB8hYbATrLIGChmITRrbyTQamPQ5sUBzEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752131405; c=relaxed/simple;
	bh=akcgg5mW5WGYZgdqEKOu3qm5DUGijzYwSIqa3Jci3P8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sw3j+x9j5eh0MvMaEmyplrKG+Xzfh+5T8AyWHrmof0fQNzb4N7fflbpUK3ar1I8dDenZ5KPHLu3aBhdpJCfNTp6ydcFnyhBxr6CVBt5dqujlYX5N5/0/qowJV3Mg7YBBdOttHzuTjL2SqPwU87k26us+ILIRiMa5rz2HKLDV8r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GYao3mMp; arc=none smtp.client-ip=209.85.215.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f195.google.com with SMTP id 41be03b00d2f7-b34c068faf8so817507a12.2;
        Thu, 10 Jul 2025 00:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752131403; x=1752736203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SpdfnhJLhS9MZBFPz+sw+aIul+Ov94DKw8DM9F37WyU=;
        b=GYao3mMpR3hr+PGaRYWbbOBOQGB9flZZFcI5W6CeJdwFPX51FW4uSVqalOhoTrwY/R
         svn7ApsAUqNZTlA9FziAGoTBSMKSThoAdxh/ODREzAQI98n3blsgcHdNGNm5blmIn51n
         VaA/0PrdT0yl/nlZi4WoCmc6qSbVqyNJ8CyojxLUXIPFQpUFNT3y0iTStWZTav8uobCN
         GBBP4Ty8Z0rcdFuZl3cwYv9bqag5HdQgGUI5OtMiqZ02jJr255PdurysUa2wJmT4kxAu
         373vwMXbWj1P6Yisl/iIYqiSuYUv5FRbx/1jpd0M9mqifpG7/YWcWNlTSgdT66RPxggk
         ubIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752131403; x=1752736203;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SpdfnhJLhS9MZBFPz+sw+aIul+Ov94DKw8DM9F37WyU=;
        b=pxpg4TnyWQu/1s7FWJKEc3rxR7bBoMTVQPdroUoJD88a8oZ9CFkqhu0wDRKLepFeRF
         7cb7a4nlxTSiFqVUrSvrTBwkrxn4jOozFkKWSYTtIYASegLeGdStyLE4DPAoD/8u3yRW
         GPbNanuCDHmJKlchYi1pj/jx1gOq4mI4RkwtiLmT/hFMNmIlWuiUwJqKqEmtijglyAbT
         yHS/N1LcERq07bYzcyYegmDpHLWhF2p6Nzt4y9QUJu325BglefpK8jnpwrGdgHY7jf1R
         aP0e53b0rAZJB1s35kz68Ak9ERwKQGJ93RnAr0F76OzxGYnCrMnWjSliII5HZN7fg8cS
         1q2Q==
X-Forwarded-Encrypted: i=1; AJvYcCV6W6hSGu4L3bw+iuRAvtKfD8l7wgn6IarsWxJZwx0T/22de9s1Rfaca5KaAhJg5LMMPfY=@vger.kernel.org, AJvYcCVqouDtjyJ71Ow7MdO0+ctzuAn3+SNWH2e+5Qyn1KGdwSiOkp46nUZdoy6TulCEQAaKcDWIhmd+Cc1sHE3p@vger.kernel.org
X-Gm-Message-State: AOJu0YyudptLN6Z3X9LtwbVa6fxDCwDY3F3lJ5ybEbi6IZLLw5U4qc1x
	GAfel9JrAn9+47rxvFW6PsbW8MNqK3v6MDM80C9c8+oMb6L5tUPfXJVh
X-Gm-Gg: ASbGnctbb4lNU2/H3xfcHH4buZa7710fAv7bOt+5moDguMrZblZFme9ImFUezubn+xL
	PyVw8ayclYOmWJ5oCAEnuNyHx3lopk64sTcZYCLpOuwBrdu+pcZyoF94syELofD+x+psqQgoTpF
	swMNeNa2T8QjEjaxhXf1OQek64T+phzVf6aoOI0hSz1xqoy+Gsav2F58HZhWViHcrVxKPEdxvmI
	wASxhEgLy7MlHSakffY+o4VNvAkJZVV8aPoX++ow0Ik2abx3qfgeNdpVvIs2ma7LOJQQxK+/gt0
	ZIjm1CXgLkfnaj+7diaj3wdWq4/t3GhbCmH5ZsuUNm66G7vbjl85df+w4urPKmnxh/mE/VxiRlb
	VoK8=
X-Google-Smtp-Source: AGHT+IHzKNFyu3q0pi9zeSB7GFSW9QDiBk5Wkiz1QExKmR0pK/SLNM/UMYxntP1wy2fuBJpE6QRpnA==
X-Received: by 2002:a17:90b:5610:b0:308:7270:d6ea with SMTP id 98e67ed59e1d1-31c2fdf4897mr8453314a91.30.1752131403111;
        Thu, 10 Jul 2025 00:10:03 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31c3003d504sm4211313a91.10.2025.07.10.00.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 00:10:02 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	daniel@iogearbox.net
Cc: john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>
Subject: [PATCH bpf-next v3] bpf: make the attach target more accurate
Date: Thu, 10 Jul 2025 15:08:35 +0800
Message-Id: <20250710070835.260831-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, we lookup the address of the attach target in
bpf_check_attach_target() with find_kallsyms_symbol_value or
kallsyms_lookup_name, which is not accurate in some cases.

For example, we want to attach to the target "t_next", but there are
multiple symbols with the name "t_next" exist in the kallsyms, which makes
the attach target ambiguous, and the attach should fail.

Introduce the function bpf_lookup_attach_addr() to do the address lookup,
which will return -EADDRNOTAVAIL when the symbol is not unique.

We can do the testing with following shell:

for s in $(cat /proc/kallsyms | awk '{print $3}' | sort | uniq -d)
do
  if grep -q "^$s\$" /sys/kernel/debug/tracing/available_filter_functions
  then
    bpftrace -e "fentry:$s {printf(\"1\");}" -v
  fi
done

The script will find all the duplicated symbols in /proc/kallsyms, which
is also in /sys/kernel/debug/tracing/available_filter_functions, and
attach them with bpftrace.

After this patch, all the attaching fail with the error:

The address of function xxx cannot be found
or
No BTF found for xxx

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v3:
- reject all the duplicated symbols
v2:
- Lookup both vmlinux and modules symbols when mod is NULL, just like
  kallsyms_lookup_name().

  If the btf is not a modules, shouldn't we lookup on the vmlinux only?
  I'm not sure if we should keep the same logic with
  kallsyms_lookup_name().

- Return the kernel symbol that don't have ftrace location if the symbols
  with ftrace location are not available
---
 kernel/bpf/verifier.c | 71 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 66 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53007182b46b..bf4951154605 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23476,6 +23476,67 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+struct symbol_lookup_ctx {
+	const char *name;
+	unsigned long addr;
+};
+
+static int symbol_callback(void *data, unsigned long addr)
+{
+	struct symbol_lookup_ctx *ctx = data;
+
+	if (ctx->addr)
+		return -EADDRNOTAVAIL;
+	ctx->addr = addr;
+
+	return 0;
+}
+
+static int symbol_mod_callback(void *data, const char *name, unsigned long addr)
+{
+	if (strcmp(((struct symbol_lookup_ctx *)data)->name, name) != 0)
+		return 0;
+
+	return symbol_callback(data, addr);
+}
+
+/**
+ * bpf_lookup_attach_addr: Lookup address for a symbol
+ *
+ * @mod: kernel module to lookup the symbol, NULL means to lookup both vmlinux
+ * and modules symbols
+ * @sym: the symbol to resolve
+ * @addr: pointer to store the result
+ *
+ * Lookup the address of the symbol @sym. If multiple symbols with the name
+ * @sym exist, -EADDRNOTAVAIL will be returned.
+ *
+ * Returns: 0 on success, -errno otherwise.
+ */
+static int bpf_lookup_attach_addr(const struct module *mod, const char *sym,
+				  unsigned long *addr)
+{
+	struct symbol_lookup_ctx ctx = { .addr = 0, .name = sym };
+	const char *mod_name = NULL;
+	int err = 0;
+
+#ifdef CONFIG_MODULES
+	mod_name = mod ? mod->name : NULL;
+#endif
+	if (!mod_name)
+		err = kallsyms_on_each_match_symbol(symbol_callback, sym, &ctx);
+
+	if (!err && !ctx.addr)
+		err = module_kallsyms_on_each_symbol(mod_name, symbol_mod_callback,
+						     &ctx);
+
+	if (!ctx.addr)
+		err = -ENOENT;
+	*addr = err ? 0 : ctx.addr;
+
+	return err;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
@@ -23729,18 +23790,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
 			if (btf_is_module(btf)) {
 				mod = btf_try_get_module(btf);
 				if (mod)
-					addr = find_kallsyms_symbol_value(mod, tname);
+					ret = bpf_lookup_attach_addr(mod, tname, &addr);
 				else
-					addr = 0;
+					ret = -ENOENT;
 			} else {
-				addr = kallsyms_lookup_name(tname);
+				ret = bpf_lookup_attach_addr(NULL, tname, &addr);
 			}
-			if (!addr) {
+			if (ret) {
 				module_put(mod);
 				bpf_log(log,
 					"The address of function %s cannot be found\n",
 					tname);
-				return -ENOENT;
+				return ret;
 			}
 		}
 
-- 
2.39.5



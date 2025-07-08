Return-Path: <bpf+bounces-62645-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA4B4AFC3EA
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 09:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2D53A8B90
	for <lists+bpf@lfdr.de>; Tue,  8 Jul 2025 07:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71E6D298981;
	Tue,  8 Jul 2025 07:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fmd/hUld"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A6621771B;
	Tue,  8 Jul 2025 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751959405; cv=none; b=iEstBYIjj6s/IGDw/VMRn13HMCXZdtUodyKJelzsxCcm3HiYhqAavTaI0KivntGV+6r8PClJM7gbWxa0kDWG5FdYuIcvolYlPolKNez8JbSbe4TxCuoTC6eGaEQlDUUNXk5zDbHi8HA9+th9R44u/BR3xERZ3PdhfwF2giqxg08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751959405; c=relaxed/simple;
	bh=Y3K/9e6LhukCurcaD9o32N0OL7wRV4i+/V8Kh17uTV8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nYTpV6D83s5teEiVOYbNF/J+taX6lNneFcbqikrW80p8Ccu9KzPl1iqfHc/wYe5kavQCs0iZKrW6iDWY/6YOinarSb6XOebIaIV9qlsAkMvybNWRbtFDQJA0SUMbZ9bNlHncM5/dmDty4NLkCry1/EREu27WDqkpyLhCBDp/97M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fmd/hUld; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-73972a54919so3527400b3a.3;
        Tue, 08 Jul 2025 00:23:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751959398; x=1752564198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ryKkdoTUScOzRY+Hydd8wbTiQdLT0HSJ6uF3KQB6E6g=;
        b=fmd/hUldVbAHUwlQUYfzULVY4pr0IqxgbjVAZaKOp+ukJ+LzUy2ngY2OwK/5MlNrvd
         KkhEKdpLydYay7fYzZbuDj12+qrkatENB/LJWwZLk8x1Jf0XXgPMzJ82XPkhDZJvNwBN
         aILHsOTafldCYAR8rk8+hvRKOs8w9P8acgb31a/4XrVt+c7mzhZxrHunobbWlLTrt6jB
         XZkfhdbSLTijT6vi5vo7KbMkKPHEKY2WB31DKPPxDAreZev6i6Mm5JPiu0YAlr5XR+qd
         thGGpnifL/VxUxQatf1YsR0ptToUh32gVenzRAtYymxUnywRGfRgsR7rAVeczH2kPpPa
         K2sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751959398; x=1752564198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ryKkdoTUScOzRY+Hydd8wbTiQdLT0HSJ6uF3KQB6E6g=;
        b=h4tWcYGsAJ8EarTmJGWlpSjtfZWTOX7x9V0KUOvRw93wP8c7/OvkE9tX3Yikt4+QKE
         tnPWDzHQzrHGy2LCSsSDlgNF6w2UxlN7/5urfovBBrzQdXiZ3W19X9zQyrsnABYqK1yE
         Rya8by659BbtHbNSgvOSOTAZ9zR7pnMpRu5v8nZUvHa/Kuu5bEUrV16oBzAy0GU/dvu1
         4EMqXwRgLQ07k23xPFnoBjp+tsOtLCfeTpQH/yqKddxYzsmipNLZYyxSqPIuCeQ01npz
         O2rGmYB+GCe4GrXacPlU+OAQMoMnggP+cQNYZGEHdt7nEk5xNHVeZ+khQjB5anaxVn1X
         7XqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAkeaZMIQaU4VBq1S1hKmxsjcosWp8KppaVNTqQDNeGEzXgb+XxLex1WlvlTZh9pdmJ2k=@vger.kernel.org, AJvYcCWOI+WG5uYOZpl/foQjcB5UDQV9fJTEJn33V9QfMN+KiX+0AGVJD2cjb43FIVqJaBIIzNH1Zv3REl+6iQGh@vger.kernel.org
X-Gm-Message-State: AOJu0Yyild1QYSkKS9GLobFjBB4tKxTM7/QYqhIuQN2NJZCA8sD7YbVk
	RT33xMeUwG0P3Zx6sjqw4rhIs9/oHIQ6GVglVHJOcwZq6ceWekDcTRqE
X-Gm-Gg: ASbGncv7piwLxYH4OSj3viDjAT87Eu9n2idknqit89jrOJyThPOTwvpHME7X9EG6PxD
	Luov6xGPlcajc6A2NCb6DuukL0QXOaI8lHZ511B/saoQ6ZTPFLzhRmkZNpSEDKBvbn5pFZ7QOgD
	xJ27s1/2QY0+oGAVeqw9LNF15yp7Kkls0NeIv5YP+8Ybt2+FJlAsY/AcUPqJ7a1isuoA6k85IpJ
	GJQO4m1zcHwpM4L+HqBqWaeG4Wc0kjFMuEEQaXfYUdxFqKmLvFHlWnBbW5XdNq3g2sM9TNeuVTt
	ToUluqaluvbgDDqWM5JFu1amRblxyDvcD6jKLDFCvBCKQGhJIrrOiM2kwDgKP8eRQzkec4bCbUH
	+RSE=
X-Google-Smtp-Source: AGHT+IFUumMzJzvqvpxmGPjZnkmRW5rFTArp8vC8CThjKAAYpNnj8kKqRT30XmVCnawZfiWJGX6W0A==
X-Received: by 2002:a05:6a00:928c:b0:742:a77b:8c4 with SMTP id d2e1a72fcca58-74ce8824f1bmr25686003b3a.3.1751959398385;
        Tue, 08 Jul 2025 00:23:18 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74ce429c138sm10826254b3a.117.2025.07.08.00.23.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 00:23:18 -0700 (PDT)
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
Subject: [PATCH bpf-next v2] bpf: make the attach target more accurate
Date: Tue,  8 Jul 2025 15:21:40 +0800
Message-Id: <20250708072140.945296-1-dongml2@chinatelecom.cn>
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
multiple symbols with the name "t_next" exist in the kallsyms. The one
that kallsyms_lookup_name() returned may have no ftrace record, which
makes the attach target not available. So we want the one that has ftrace
record to be returned.

Meanwhile, there may be multiple symbols with the name "t_next" in ftrace
record. In this case, the attach target is ambiguous, so the attach should
fail.

Introduce the function bpf_lookup_attach_addr() to do the address lookup,
which is able to solve this problem.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- Lookup both vmlinux and modules symbols when mod is NULL, just like
  kallsyms_lookup_name().

  If the btf is not a modules, shouldn't we lookup on the vmlinux only?
  I'm not sure if we should keep the same logic with
  kallsyms_lookup_name().

- Return the kernel symbol that don't have ftrace location if the symbols
  with ftrace location are not available
---
 kernel/bpf/verifier.c | 77 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 72 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 53007182b46b..4bacd0abf207 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -23476,6 +23476,73 @@ static int check_non_sleepable_error_inject(u32 btf_id)
 	return btf_id_set_contains(&btf_non_sleepable_error_inject, btf_id);
 }
 
+struct symbol_lookup_ctx {
+	const char *name;
+	unsigned long addr;
+	bool ftrace_addr;
+};
+
+static int symbol_callback(void *data, unsigned long addr)
+{
+	struct symbol_lookup_ctx *ctx = data;
+
+	ctx->addr = addr;
+	if (!ftrace_location(addr))
+		return 0;
+
+	if (ctx->ftrace_addr)
+		return -EADDRNOTAVAIL;
+	ctx->ftrace_addr = true;
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
+ * @sym exist, the one that has ftrace location is preferred. If more
+ * than 1 has ftrace location, -EADDRNOTAVAIL will be returned.
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
@@ -23729,18 +23796,18 @@ int bpf_check_attach_target(struct bpf_verifier_log *log,
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



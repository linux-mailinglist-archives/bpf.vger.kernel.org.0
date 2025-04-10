Return-Path: <bpf+bounces-55642-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E7452A83D14
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 10:34:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 01B357A9458
	for <lists+bpf@lfdr.de>; Thu, 10 Apr 2025 08:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0261520AF84;
	Thu, 10 Apr 2025 08:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2nCixYM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 124561DC994;
	Thu, 10 Apr 2025 08:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744274072; cv=none; b=l1OW8QA5mR/9eFv+iS+/PYuuVvmJJU2XJ18nkP2AvzhNK/5zJx7C4AtQgm3APCZYUqcrpn7xUszDxxnGjSag/5gyd9IPf7R7BS0QZ3G3ChxvZLEevlMnmSobvxsWamqO5Jw0TlE5yFTzkEVO18Gly1rYjqKnigcQvGApl5wWAFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744274072; c=relaxed/simple;
	bh=iscnuos1MCgR/3fIoF/rplF5OWxT+jhEEQCfsWnG/nU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cZusd8+raH2bAaUcgj/wyhvY6GBYLA1GY1B3S6FXxlrY/DFRWFhCu9mhArQn/oarANflpXo3SNa3mol4stuySU/0ukmHBy3TvsmtmDy2wWaK6p8eK1a3OBvuFR6n3bd6B6JdxcfPceP9OBXQLSYpJzOXjokYswlPas26r0WcOlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2nCixYM; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-af548cb1f83so556940a12.3;
        Thu, 10 Apr 2025 01:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744274070; x=1744878870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y4D1xnkm03W6KM6yUvVIo4vR1teUnn/xTtbt7FrnpAM=;
        b=b2nCixYMpWIqJ0g69vsAzFfHhYmN3n/1zl2H804h9zRWvnHJN9tmhomRLdoLzmVuM9
         J96aT8BqgpEb4Do2XK9AAd7y70WtjCtq3jZm0dL6fs1A26rjzbsjvsO0KT4kGDcpoMLL
         qYy2Xi0tCwBmnS3SSpIeF41trxC1RHWxHc3oIi73PzFaQYPUx0dPOlVLRLUJGxvTLi7T
         8TZJ9YuG9h81xBJZNtsU3UzMm5EsA/oLpALpstHleA4/U0tTIF5zOFIZzFhLts+QlDio
         UgLl/bFjt6wCjbmWPD93q4MBCYjkRHsuJ/NW0cSPwIHC1jBVcO6v8vN+kkZ4UmlXATr7
         ZHLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744274070; x=1744878870;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4D1xnkm03W6KM6yUvVIo4vR1teUnn/xTtbt7FrnpAM=;
        b=CTk6JYjfCg8ZrGjlsAzZdZYtbfFU81Ci6R2m1HkJCSh8uJp+C8RN2wAI1eRDIRBNYq
         k9EutM4XJnZQJqw276OrMX3eNXgO1eeKjFBqIQhriPakHwD6sOq0gcV0j3w4i7bwitz8
         jpI15bKE45fXJRhvPtkqySJO9TYTC7tmv/ZQ+sOXgiVvLx3MFK/Wt0R5de+VxQvuBt2O
         N5Zzn+9Xgqo3Y4RE/qbr0ti7KqhZioWNNKZaUBiv85/3ExjP5M6thKAf8z0KoJBgb0+X
         i/DHH2pzpY+9W7kypIrF3C1+zaRPdHks90VXeFW4OvksWYbVxLwpGzqlVq3ASE/f1Mct
         YXjQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2WV7hhmr/lO781KSCOuT0h2mthE+C6LZtkxtys7YymKLQuomgEl73keHGUd4SvDwxLxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyUuOQ/hw1P5JMo6+GUt6CjvL8jxzzEaUFvfgtghKSQXkm7SiY
	EWKZDebHwBxTg0ZhCq7DTTTE4Y2/zmhqWtsWmCWVKCYbGy2tk/A/Agqrvw==
X-Gm-Gg: ASbGnctGjAunBn3t5OYW+gBrP0nnXxZ6jjYGlvUL9rugPa4nRoerHsmps4dCyUihjQS
	vvd1nn+kQtZYPoO3CE6rEWHenB4Pdm7ljnwOrXqCJMQHROjWRVVr+rPH3YrYtwqBa2GxvlHov3H
	uw8BeAqvBXRe+u8X52DUw9zBkSo3Jt7pmO0oJjl7AMHkt4uhYF+FhZ0RYahbojYRUriYcTB1HQk
	khXYvR4U416SdxsPFjD8n9IuYwo1/Xye/40U/mcieAbWMvAodQUb7u02OKnsT9suXYqL6LhWZ9d
	6EfyEb+PDwKqIYJsI0H6Z2Umq/wapmtb19oJVAh0C4J2F32Ok3hZGFjnGtM2+qDzAqUvO22K4mK
	DRdBt07noo40PD16q
X-Google-Smtp-Source: AGHT+IFtl++67Bm6pMv5v57oFrhmVk8v9zeEsbrM5gb3vjfQwVxDWzONsxO5MTwn3nJCpeMAFmi/sQ==
X-Received: by 2002:a05:6a21:6481:b0:1f5:7873:304b with SMTP id adf61e73a8af0-201695c6f81mr3179006637.26.1744274070071;
        Thu, 10 Apr 2025 01:34:30 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a2d3a5e5sm2485773a12.54.2025.04.10.01.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 01:34:29 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH dwarves v1] dwarf_loader: Fix skipped encoding of function BTF on 32-bit systems
Date: Thu, 10 Apr 2025 01:33:59 -0700
Message-Id: <20250410083359.198724-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While doing JIT development on armhf BTF kernels, I hit a strange issue
where some functions were missing in BTF data. This required considerable
debugging but can be reproduced simply:

$ bpftool --version
bpftool v7.6.0
using libbpf v1.6
features: llvm, skeletons

$ pahole --version
v1.29

$ pahole -J -j --btf_features=decl_tag,consistent_func,decl_tag_kfuncs .tmp_vmlinux_armhf
btf_encoder__tag_kfunc: failed to find kfunc 'scx_bpf_select_cpu_dfl' in BTF
btf_encoder__tag_kfuncs: failed to tag kfunc 'scx_bpf_select_cpu_dfl'

$ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
<nothing>

$ pfunct -Fdwarf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);

$ pahole -J -j --btf_features=decl_tag,decl_tag_kfuncs .tmp_vmlinux_armhf

$ pfunct -Fbtf -E -f scx_bpf_select_cpu_dfl .tmp_vmlinux_armhf
bpf_kfunc s32 scx_bpf_select_cpu_dfl(struct task_struct * p, s32 prev_cpu, u64 wake_flags, bool * is_idle);

The key things to note are the pahole 'consistent_func' feature and the u64
'wake_flags' parameter vs. arm 32-bit registers. These point to existing
code handling arguments larger than register-size, but only structs.

Generalize the code for any type of argument exceeding register size (i.e.
cu->addr_size). This should work for integral or aggregate types, and also
avoids a bug in the current code where a register-sized struct could be
mistaken for larger.

Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
 dwarf_loader.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index e1ba7bc..22abfdb 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2914,23 +2914,9 @@ out:
 	return 0;
 }
 
-static bool param__is_struct(struct cu *cu, struct tag *tag)
+static bool param__is_wide(struct cu *cu, struct tag *tag)
 {
-	struct tag *type = cu__type(cu, tag->type);
-
-	if (!type)
-		return false;
-
-	switch (type->tag) {
-	case DW_TAG_structure_type:
-		return true;
-	case DW_TAG_const_type:
-	case DW_TAG_typedef:
-		/* handle "typedef struct", const parameter */
-		return param__is_struct(cu, type);
-	default:
-		return false;
-	}
+	return tag__size(tag, cu) > cu->addr_size;
 }
 
 static int cu__resolve_func_ret_types_optimized(struct cu *cu)
@@ -2942,9 +2928,9 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 		struct tag *tag = pt->entries[i];
 		struct parameter *pos;
 		struct function *fn = tag__function(tag);
-		bool has_unexpected_reg = false, has_struct_param = false;
+		bool has_unexpected_reg = false, has_wide_param = false;
 
-		/* mark function as optimized if parameter is, or
+		/* Mark function as optimized if parameter is, or
 		 * if parameter does not have a location; at this
 		 * point location presence has been marked in
 		 * abstract origins for cases where a parameter
@@ -2953,10 +2939,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 		 *
 		 * Also mark functions which, due to optimization,
 		 * use an unexpected register for a parameter.
-		 * Exception is functions which have a struct
-		 * as a parameter, as multiple registers may
-		 * be used to represent it, throwing off register
-		 * to parameter mapping.
+		 * Exception is functions which have a wide
+		 * parameter, as multiple registers may be used
+		 * to represent it, throwing off register to
+		 * parameter mapping. Examples could include
+		 * structs or 64-bit types on a 32-bit arch.
 		 */
 		ftype__for_each_parameter(&fn->proto, pos) {
 			if (pos->optimized || !pos->has_loc)
@@ -2967,11 +2954,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 		}
 		if (has_unexpected_reg) {
 			ftype__for_each_parameter(&fn->proto, pos) {
-				has_struct_param = param__is_struct(cu, &pos->tag);
-				if (has_struct_param)
+				has_wide_param = param__is_wide(cu, &pos->tag);
+				if (has_wide_param)
 					break;
 			}
-			if (!has_struct_param)
+			if (!has_wide_param)
 				fn->proto.unexpected_reg = 1;
 		}
 
-- 
2.34.1



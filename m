Return-Path: <bpf+bounces-61752-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 76FE4AEBA29
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 16:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC4A21C41FC4
	for <lists+bpf@lfdr.de>; Fri, 27 Jun 2025 14:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6007E1632C8;
	Fri, 27 Jun 2025 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xec9K+hX"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F4602E8E01
	for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751035432; cv=none; b=AP+GzcGPtwtTHrL3f142HPsf3CwvwGYt6wdnHjxd2Gwu1MrpAfSg5QoSvLviugBtJ+yUQ4FTC8cmOnJXlpCMSo3y4LYo9vJf00h8DpR8XNcPWJjHPrs6ZorUaVTe26OOBuMthib3kMVn1PjnnkHHjfcPw2MoQKd5ozWOfUEQG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751035432; c=relaxed/simple;
	bh=4WlzVJ5UN/XosvzPrcLW3lyRNCmuAfAHIr+ZDYYJCEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DXsskCrTggIYHMCuyeVkp7ytwDa++msRtnC3cLAoDsmPqTFO3cyIYlTdmfq1jfrm2VShyWoBq58DHUaC8bh1xakkyZ1OKRD2hOvc3FBGVwaWzcG4gcPKAAKPiNRf9RCqVe6u1VxBA42ogQFG5hI9NkfY2DtzM6gLfmR3VpDwLZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xec9K+hX; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4537deebb01so11982565e9.0
        for <bpf@vger.kernel.org>; Fri, 27 Jun 2025 07:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751035429; x=1751640229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HRtgvS49MzaVM25EOBNqiGn1pvPFsyqeI3Wt6Hfupmc=;
        b=Xec9K+hX1IZTSV3ag+4RXVIIpoLWEw6XJbUOWlRnDsgKqAPcax0JKSQYOjihABSWtb
         HiZ4tkf+0qrsP1qNVWMCYk1TahHSKCxigP3RYtB7F5DmXkCi48a50gFsSrPAibRR+C6Q
         sUdyde38TChwrIFM8wvSHQdjj7LeSEU/vbiluxCjKU2/ZIJg27RKNlwV8yvjNTPQtH9j
         gUcHt3dIPBtQ7gg269L8orH4kZlQq0B9uTSNX6tdW9InZK6onNa9q56hLMOgEu8tWzla
         N6nLnlIG2zGQOS4sauToa6Ul2hhGkZJ9VT8QxpW8bQfhhBmZ3HqDFpYdzLQMPQQL9+3R
         aeMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751035429; x=1751640229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HRtgvS49MzaVM25EOBNqiGn1pvPFsyqeI3Wt6Hfupmc=;
        b=craNm3qt+a29vPbi490FURQgh8Rw40hnJjd+LCdHDyg1wh5Z+56EM9GBNa9Ht5NP7B
         UPjUe/sgsnsXV3gBz32GSpAxRV7hBbUYinDtUG+tgW1qWguKBr3efEj2j990KS6/4zgg
         HxBs6PJjMA4ihxRB/tVH6GJ97GuI+gPW9khkFuKglfe6p6GiU715wfX9RbzWVf2y6Hsx
         A7ZBAOnMaVVmIVHc/3XyJq9KdpG8gM2YHLmf6J+2az93pHT3Q5ZT8hD1lP8iX+eSt7wL
         wZcdJGubdJi8II3VBi/GQIoVScrdyVthuASguuz4H2DJqwRwKC6JrH3BWVAbwAfvE3xo
         uvnw==
X-Gm-Message-State: AOJu0YxJ8zVGwH6dsn8qqVXMKKV/eQsh+GiBUrkKTCwIVpy9PigphtFB
	+xj51hQkxafXKqVuR2KCdaWxgY6d8jWBHVvHg/E9sQdpw5jPFw3/HaNfQmiDUA==
X-Gm-Gg: ASbGncstin2khgZqODSuzJeto8VyQodz1HgQJDpjtIJpc++5D9YDepicb1G9JPXmUm2
	vHeyawKGboNwsXLXcGAc62Ey2T9cOQDZBOGBU1x+tMMsmOvyl/a4rkj0DtxUryjfX5cNR+eWFq5
	3Z1MjxWJ5+Mf8ZZF+Mdne9KkzCDuUX6IJ6QO0EBtlNUCgcgUrrrPyXXNdM+P400XVbSxjQo/sFD
	/gmrlZ4laTr8mI9HF36MLC/lLQH2xfx0+y0Jz+Su+bxEB9SIbpQLWNOjb1kROaB3wf5dgOe2hOK
	hYg1KvQTCI8wlaZ2K9m88kayYzOM6C0qvMX9ppinOe05C3nn0fhIMsjNH+pk
X-Google-Smtp-Source: AGHT+IEt6A4M/Ck+vLVuvaZMuQAAGcbvx7x4GFkW0xMyIkSgPFzpm1m6764iqpD0Y7UIh1PYBBXXTg==
X-Received: by 2002:a05:600c:8b01:b0:450:d30e:ff96 with SMTP id 5b1f17b1804b1-4538ee5dc58mr38977825e9.0.1751035427662;
        Fri, 27 Jun 2025 07:43:47 -0700 (PDT)
Received: from localhost ([2a01:4b00:bf28:2e00:106b:a16d:4d49:8ce9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823c57d7sm86760845e9.40.2025.06.27.07.43.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Jun 2025 07:43:47 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] selftests/bpf: improve error messages in veristat
Date: Fri, 27 Jun 2025 15:43:42 +0100
Message-ID: <20250627144342.686896-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Return error if preset parsing fails. Avoid proceeding with veristat run
if preset does not parse.
Before:
```
./veristat set_global_vars.bpf.o -G "arr[999999999999999999999] = 1"
Failed to parse value '999999999999999999999'
Processing 'set_global_vars.bpf.o'...
File                   Program           Verdict  Duration (us)  Insns  States  Program size  Jited size
---------------------  ----------------  -------  -------------  -----  ------  ------------  ----------
set_global_vars.bpf.o  test_set_globals  success             27     64       0            82           0
---------------------  ----------------  -------  -------------  -----  ------  ------------  ----------
Done. Processed 1 files, 0 programs. Skipped 1 files, 0 programs.
```
After:
```
./veristat set_global_vars.bpf.o -G "arr[999999999999999999999] = 1"
Failed to parse value '999999999999999999999'
Failed to parse global variable presets: arr[999999999999999999999] = 1
```

Improve error messages:
 * If preset struct member can't be found.
 * Array index out of bounds

Extract rtrim function.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/testing/selftests/bpf/veristat.c | 36 ++++++++++++++++++--------
 1 file changed, 25 insertions(+), 11 deletions(-)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index 1e9f61f9fd0a..09cfbd486f92 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -890,6 +890,18 @@ static bool is_desc_sym(char c)
 	return c == 'v' || c == 'V' || c == '.' || c == '!' || c == '_';
 }
 
+static char *rtrim(char *str)
+{
+	int i;
+
+	for (i = strlen(str) - 1; i > 0; --i) {
+		if (!isspace(str[i]))
+			break;
+		str[i] = '\0';
+	}
+	return str;
+}
+
 static int parse_stat(const char *stat_name, struct stat_specs *specs)
 {
 	int id;
@@ -1666,7 +1678,7 @@ static int append_preset_atom(struct var_preset *preset, char *value, bool is_in
 static int parse_var_atoms(const char *full_var, struct var_preset *preset)
 {
 	char expr[256], var[256], *name, *saveptr;
-	int n, len, off;
+	int n, len, off, err;
 
 	snprintf(expr, sizeof(expr), "%s", full_var);
 	preset->atom_count = 0;
@@ -1677,7 +1689,9 @@ static int parse_var_atoms(const char *full_var, struct var_preset *preset)
 			fprintf(stderr, "Can't parse %s\n", name);
 			return -EINVAL;
 		}
-		append_preset_atom(preset, var, false);
+		err = append_preset_atom(preset, var, false);
+		if (err)
+			return err;
 
 		/* parse optional array indexes */
 		while (off < len) {
@@ -1685,7 +1699,9 @@ static int parse_var_atoms(const char *full_var, struct var_preset *preset)
 				fprintf(stderr, "Can't parse %s as index\n", name + off);
 				return -EINVAL;
 			}
-			append_preset_atom(preset, var, true);
+			err = append_preset_atom(preset, var, true);
+			if (err)
+				return err;
 			off += n;
 		}
 	}
@@ -1697,7 +1713,7 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
 	void *tmp;
 	struct var_preset *cur;
 	char var[256], val[256];
-	int n, err, i;
+	int n, err;
 
 	tmp = realloc(*presets, (*cnt + 1) * sizeof(**presets));
 	if (!tmp)
@@ -1712,11 +1728,7 @@ static int append_var_preset(struct var_preset **presets, int *cnt, const char *
 		return -EINVAL;
 	}
 	/* Remove trailing spaces from var, as scanf may add those */
-	for (i = strlen(var) - 1; i > 0; --i) {
-		if (!isspace(var[i]))
-			break;
-		var[i] = '\0';
-	}
+	rtrim(var);
 
 	err = parse_rvalue(val, &cur->value);
 	if (err)
@@ -1869,7 +1881,7 @@ static int adjust_var_secinfo_array(struct btf *btf, int tid, struct field_acces
 	if (err)
 		return err;
 	if (idx < 0 || idx >= barr->nelems) {
-		fprintf(stderr, "Array index %lld is out of bounds [0, %u]: %s\n",
+		fprintf(stderr, "Array index %lld is out of bounds [0, %u): %s\n",
 			idx, barr->nelems, array_name);
 		return -EINVAL;
 	}
@@ -1928,7 +1940,7 @@ static int adjust_var_secinfo_member(const struct btf *btf,
 		}
 	}
 
-	return -EINVAL;
+	return -ESRCH;
 }
 
 static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
@@ -1955,6 +1967,8 @@ static int adjust_var_secinfo(struct btf *btf, const struct btf_type *t,
 			break;
 		case FIELD_NAME:
 			err = adjust_var_secinfo_member(btf, base_type, 0, atom->name, sinfo);
+			if (err == -ESRCH)
+				fprintf(stderr, "Can't find '%s'\n", atom->name);
 			prev_name = atom->name;
 			break;
 		default:
-- 
2.50.0



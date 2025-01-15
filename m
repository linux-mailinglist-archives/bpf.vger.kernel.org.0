Return-Path: <bpf+bounces-48991-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EC30CA12E59
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 23:39:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4AC165B38
	for <lists+bpf@lfdr.de>; Wed, 15 Jan 2025 22:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E37C11DC070;
	Wed, 15 Jan 2025 22:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="htKLDlyi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6301D79A9
	for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 22:39:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980786; cv=none; b=OzsQxPuN9bggYlH8mxju26Ff/ZtqHb0tr1mgJ5VTw1qwaWrqE4TCA4a3qLSUuuGieIm6Ue9teHr7AHGutPR8Nye27kW65rw1lfb1gP9TQaEmUEiVdMRWLEo2li81W+M9Ob4UsqsT7lPBOIGaJ+bH07+ZsNmWqdoCs6hD7Ithh/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980786; c=relaxed/simple;
	bh=Xza5Plv+BGSJfshXbr426jeHaUKFiCvqHhdMej7xtpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kiUu4pMfbee9BOhQKNZnSkF7g6HIH0o6rXqIo3YPfWxIFQMyajcSJuWrtPIpDUKaxHnwXvyRy8uL7op7zbhTTG5IjbMu1FN+DtgMiIcuBYUc5RDXTVjZqPs5XQm6CMDn8fQJ/tD98OkuVMTSNk06VbQ1oysj8Sqhuosw5TOuXBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=htKLDlyi; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-219f8263ae0so3636125ad.0
        for <bpf@vger.kernel.org>; Wed, 15 Jan 2025 14:39:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736980784; x=1737585584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ubg6J6RwOrqLOX2VMxSRBEdwqm3xL0XVQe4aKX2nf5U=;
        b=htKLDlyiv6FR3bmCSOv5kITHLPNtw69K3APf3Knw9Qidb1joMH0jcCW1pTgts0Gqi4
         469JddBVg0wKLtunHGSEQoyflWBW38Fdz9TjFJp10L82YBtdiKQKMGJZdSUVDuw8IFb8
         3QnWBu1OxZugkG9sJ8FYjTtOGm/iukeL3AJlQRscLM8781NulZrBcXnC/wEuKJnilnNQ
         BgoyeZHDRmNs9MYu7ETkqZPlFPoI/7r5fbr128BGndA01zc0pXVWlmeHU4Ck/XDR3djI
         ubOK5FthuHmIskLG285PJjLhKR1cI0b5t3M5/XQ4TQpRjt78ML860QamRDzw48Kipo/n
         0H3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736980784; x=1737585584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubg6J6RwOrqLOX2VMxSRBEdwqm3xL0XVQe4aKX2nf5U=;
        b=WXeWlReOahqQ3SJFN3S/Qp3+goOXswiLINRyDYyA4t0qltbhr334fORZe404EX6jml
         lFRwi5NIMVfhM7peFlgNzawx6ccM5kzRjqL0Pt89aCZXHf9z+Au3dB03tmtwtSRh8E5l
         uf9PS/KhQGY+TeMep5pnOSRxT/v07bbYA0aHjQ3fEPoZKIG2OuJNQvWWXb1ZcNHzT9LJ
         vKrIaovpbEC80lVqrSC3BLiw9WKS5Ujy5fUMiPIsxQ2EHS6gBWlaheg8hXUvE5e8e957
         KjTL27feAiKE6MC3XfbUniSE7BtDLcZZWY8Kqj6Oswr7DciaD8UgdO1VTuMpoxWr1D/c
         FJNQ==
X-Gm-Message-State: AOJu0Yzgdbl5LXGVYmVY1dq/+m/wYh9lJOxGaQ7sMYZDvggNZekDbWtf
	tpP+Gl/Z05zMV8Nh5ET1SChf5vGr6Hv/R47IDn3ZG+vRvFo6c4UpI4qrUg==
X-Gm-Gg: ASbGnct+TvsCGdheu2FforQYcC5Qd4iOxR+JAoAN9CaZnyZp7TbnzVXgec6haOTk3AL
	rji5rUfH6tNlRH8Q213qV4LXjiO3c1Om5viqw54xY7RAW60cTNysD7IjJ9xi/ZRcVdlSkoQutRv
	nlIgZkols2CDNCxZHTOStnHQmFefeLYCzd9HaRhO/SLAYb0BJ6mdJicseBwg6wGEmpQgAjZMS/P
	W9bmQ4gkOxWLrRzFEgIxIkKM8SWId3ylqPXbBk/QzNo56YC3BHG
X-Google-Smtp-Source: AGHT+IE4mI+a+pfbUDG3nsySEq/zoiaWTCc1GZQP3zD3GJDRxIsioXNWy8p5hjH+b1XNoxTHc/+X9Q==
X-Received: by 2002:a05:6a00:1255:b0:71e:6c3f:2fb6 with SMTP id d2e1a72fcca58-72d21f4b05emr50938544b3a.8.1736980783884;
        Wed, 15 Jan 2025 14:39:43 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4065c532sm9905238b3a.97.2025.01.15.14.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2025 14:39:43 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	yatsenko@meta.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v1] veristat: load struct_ops programs only once
Date: Wed, 15 Jan 2025 14:38:35 -0800
Message-ID: <20250115223835.919989-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

libbpf automatically adjusts autoload for struct_ops programs,
see libbpf.c:bpf_object_adjust_struct_ops_autoload.

For example, if there is a map:

    SEC(".struct_ops.link")
    struct sched_ext_ops ops = {
    	.enqueue = foo,
        .tick = bar,
    };

Both 'foo' and 'bar' would be loaded if 'ops' autocreate is true,
both 'foo' and 'bar' would be skipped if 'ops' autocreate is false.

This means that when veristat processes object file with 'ops',
it would load 4 programs in total: two programs per each
'process_prog' call.

The adjustment occurs at object load time, and libbpf remembers
association between 'ops' and 'foo'/'bar' at object open time.
The only way to persuade libbpf to load one of two is to adjust map
initial value, such that only one program is referenced.
This patch does exactly that, significantly reducing time to process
object files with big number of struct_ops programs.

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/testing/selftests/bpf/veristat.c | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/tools/testing/selftests/bpf/veristat.c b/tools/testing/selftests/bpf/veristat.c
index b47836ee7d4d..23b64faa54ab 100644
--- a/tools/testing/selftests/bpf/veristat.c
+++ b/tools/testing/selftests/bpf/veristat.c
@@ -1103,6 +1103,42 @@ static int guess_prog_type_by_ctx_name(const char *ctx_name,
 	return -ESRCH;
 }
 
+/* Make sure only target program is referenced from struct_ops map,
+ * otherwise libbpf would automatically set autocreate for all
+ * referenced programs.
+ * See libbpf.c:bpf_object_adjust_struct_ops_autoload.
+ */
+static void mask_unrelated_struct_ops_progs(struct bpf_object *obj,
+					    struct bpf_map *map,
+					    struct bpf_program *prog)
+{
+	struct btf *btf = bpf_object__btf(obj);
+	const struct btf_type *t, *mt;
+	struct btf_member *m;
+	int i, ptr_sz, moff;
+	size_t data_sz;
+	void *data;
+
+	t = btf__type_by_id(btf, bpf_map__btf_value_type_id(map));
+	if (!btf_is_struct(t))
+		return;
+
+	data = bpf_map__initial_value(map, &data_sz);
+	ptr_sz = min(btf__pointer_size(btf), sizeof(void *));
+	for (i = 0; i < btf_vlen(t); i++) {
+		m = &btf_members(t)[i];
+		mt = btf__type_by_id(btf, m->type);
+		if (!btf_is_ptr(mt))
+			continue;
+		moff = m->offset / 8;
+		if (moff + ptr_sz > data_sz)
+			continue;
+		if (memcmp(data + moff, &prog, ptr_sz) == 0)
+			continue;
+		memset(data + moff, 0, ptr_sz);
+	}
+}
+
 static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const char *filename)
 {
 	struct bpf_map *map;
@@ -1118,6 +1154,9 @@ static void fixup_obj(struct bpf_object *obj, struct bpf_program *prog, const ch
 		case BPF_MAP_TYPE_INODE_STORAGE:
 		case BPF_MAP_TYPE_CGROUP_STORAGE:
 			break;
+		case BPF_MAP_TYPE_STRUCT_OPS:
+			mask_unrelated_struct_ops_progs(obj, map, prog);
+			break;
 		default:
 			if (bpf_map__max_entries(map) == 0)
 				bpf_map__set_max_entries(map, 1);
-- 
2.47.1



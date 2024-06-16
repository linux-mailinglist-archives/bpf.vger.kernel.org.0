Return-Path: <bpf+bounces-32235-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DF182909AB1
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 02:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD3061C21030
	for <lists+bpf@lfdr.de>; Sun, 16 Jun 2024 00:30:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE89A468E;
	Sun, 16 Jun 2024 00:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mm6K2Mwd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC0223BF;
	Sun, 16 Jun 2024 00:30:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718497809; cv=none; b=c1oiSYZREK4gcd28txug6nz2CcTTV4/8M4LQtfL2JfedQhAdexdbSZSoTEmG86CbbwNCfQM7b6xlbon6ObfNyXrwUhmoujD/yElJNowWZWGZ35/2QMM6bKE6LdUzDRAIOA6+MfKUfE6LhjXN3s+LwVEoR5elss26Pn/p2d+xJbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718497809; c=relaxed/simple;
	bh=WY60PRAGN65hKOjuRFFy2T6DnCrZjrVj79ITXNKWAAo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DQKyLuqy1QJ5MONexwRBTeoZh/+7nPfI5QyBksw0pB4N3cuVvg1jVXm3R/2r+IPMl9KTZEgdxPO6USp1rAZwDqxtdTNSm6/TiN/vRx/7VXjHK31FzYqPPK2OtklqlDaWRYx8VFZFgv6F5zCuDmjxFQHqD+C4gDCIe5Zs6g9Q854=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mm6K2Mwd; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-6e9f52e99c2so2551397a12.1;
        Sat, 15 Jun 2024 17:30:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718497807; x=1719102607; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BTBbcROF1kvXaM6dZlPyFTcs4OHmLeqwYC/d1IExwvY=;
        b=mm6K2MwdvYNRnRvjTUqHJ8WJtIu7yYwmSp4a2vAHYLlTnmclyL9VVodFGtlXfu1aVa
         481yWHZEtw7KN6UnY2YQn+tH8MCYOp0/rSmZRcnoJ9fnofU3Vkf+ISD7diHd7abkUVwk
         1ZudS38Ww8WyIUuWCNMaII/q+EF++8rGQ8RILJot44A7ghuyWEWR4L0ccUS3elwEJRG2
         vxVnpRgx9qVTTavLQZgQ8NRoMLYzleiZAcBu2YceTT+1hxcl1PLonBuBdjtJ0NpHmWFp
         nCJC8x6mNdhoyogP4+JkQuZrQomSSFibbKTka62e0gP0uXzNaH4cVa1cJg0a9r40ah02
         wS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718497807; x=1719102607;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BTBbcROF1kvXaM6dZlPyFTcs4OHmLeqwYC/d1IExwvY=;
        b=ipByYQ+KL1YYUrCkYUzdVqVb2KggBqsVWDFp+8mJP/uEbxrUwdwr7LLZqAxw+FNWNe
         GugtQ1xno/JkOXZrYt0uKdXovLtQ4adPSzyp2ApSF4qrzMJ6QgVcMQPouJJVMxFYSc9H
         OeESXET52p9/Z5+ojPA6IPRpfpUN9/X/10SjJ8lZnANAMwbXVKghsEV7637654h9q7fs
         y/lMB475zgw9qH5weMBHyBkzazkq1tZy+WnI8yCOfzCE0tWfNLVCd8nNYptBnw6QrufH
         r4KGtchu9T92yXeALdnwO0l1pW0dtL74BOxu+aEg525o+nUdNMWDWhBkrr6AfG8gbHiS
         i0OA==
X-Forwarded-Encrypted: i=1; AJvYcCWUprphPjXJybtezr3yvEaM8usm8yDGP+l8j8wzKeIs36mR/XEGWZ2B/QDledduQiAUE9t8yjeK1jBDPsH4PlWF3QgUgUnoxOu22Vf7jdGZNIqSIFj5tPbUXd/wL4bhnuYG
X-Gm-Message-State: AOJu0YykNSKDJ0Fx1GxLTgi6+sOUgozxD6wmwTuBomB352AKf5POGYNY
	GYa9HLs/jcEx+TVJm8kKe55kABBko3LKPcQKF4QcJeTAJ7nyddv+
X-Google-Smtp-Source: AGHT+IFjUoU4UWG+6jxvlrzjuNUmhH/5KBsT7DcS/d3T5ZFMnJwu7/MjDSKvyIVJmpcROP/wQ8RuRg==
X-Received: by 2002:a05:6a20:8427:b0:1b5:d00e:98e3 with SMTP id adf61e73a8af0-1bae7d97c20mr6501499637.11.1718497806983;
        Sat, 15 Jun 2024 17:30:06 -0700 (PDT)
Received: from ubuntu.localdomain ([240e:304:7697:ee96:7cea:342b:603a:c6])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2c4a769be25sm8612448a91.35.2024.06.15.17.30.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jun 2024 17:30:06 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org
Cc: daniel@iogearbox.net,
	song@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	haoluo@google.com,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH] libbpf: checking the btf_type kind when fixing variable offsets
Date: Sat, 15 Jun 2024 17:29:58 -0700
Message-Id: <20240616002958.2095829-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I encountered an issue when building the test_progs using the repository[1]:

$ clang --version
Ubuntu clang version 17.0.6 (++20231208085846+6009708b4367-1~exp1~20231208085949.74)
Target: x86_64-pc-linux-gnu
Thread model: posix
InstalledDir: /usr/bin

$ pwd
/work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/

$ make test_progs V=1
...
/work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/tools/sbin/bpftool
gen object
/work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_defrag.bpf.linked2.o
/work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_defrag.bpf.linked1.o
libbpf: failed to find symbol for variable 'bpf_dynptr_slice' in section
'.ksyms'
Error: failed to link
'/work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_defrag.bpf.linked1.o':
No such file or directory (2)
make: *** [Makefile:656:
/work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/ip_check_defrag.skel.h]
Error 254

After investigation, I found that the btf_types in the '.ksyms' section have a kind of
BTF_KIND_FUNC instead of BTF_KIND_VAR:

$ bpftool btf dump file ./ip_check_defrag.bpf.linked1.o
...
[2] DATASEC '.ksyms' size=0 vlen=2
        type_id=16 offset=0 size=0 (FUNC 'bpf_dynptr_from_skb')
        type_id=17 offset=0 size=0 (FUNC 'bpf_dynptr_slice')
...
[16] FUNC 'bpf_dynptr_from_skb' type_id=82 linkage=extern
[17] FUNC 'bpf_dynptr_slice' type_id=85 linkage=extern
...

To fix this, we can a add check for the kind.

[1] https://github.com/eddyz87/bpf/tree/binsort-btf-dedup
Link: https://lore.kernel.org/all/4f551dc5fc792936ca364ce8324c0adea38162f1.camel@gmail.com/

Fixes: 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext support")
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
 tools/lib/bpf/linker.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 0d4be829551b..7f5fc9ac4ad6 100644
--- a/tools/lib/bpf/linker.c
+++ b/tools/lib/bpf/linker.c
@@ -2213,10 +2213,17 @@ static int linker_fixup_btf(struct src_obj *obj)
 		vi = btf_var_secinfos(t);
 		for (j = 0, m = btf_vlen(t); j < m; j++, vi++) {
 			const struct btf_type *vt = btf__type_by_id(obj->btf, vi->type);
-			const char *var_name = btf__str_by_offset(obj->btf, vt->name_off);
-			int var_linkage = btf_var(vt)->linkage;
+			const char *var_name;
+			int var_linkage;
 			Elf64_Sym *sym;
 
+			/* should be a variable */
+			if (btf_kind(vt) != BTF_KIND_VAR)
+				continue;
+
+			var_name = btf__str_by_offset(obj->btf, vt->name_off);
+			var_linkage = btf_var(vt)->linkage;
+
 			/* no need to patch up static or extern vars */
 			if (var_linkage != BTF_VAR_GLOBAL_ALLOCATED)
 				continue;
-- 
2.25.1



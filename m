Return-Path: <bpf+bounces-32514-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D46A90EB17
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 14:26:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FCD28230C
	for <lists+bpf@lfdr.de>; Wed, 19 Jun 2024 12:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C253143752;
	Wed, 19 Jun 2024 12:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3B1OpPj"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5F8142E96;
	Wed, 19 Jun 2024 12:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718799931; cv=none; b=EEL55amw4xZZNmjSzjTZWiqE7qxrGNv6BEvki/JfZqmcGXcrxd2cJMAURo+s9jGgFuCDpu3u+ywUsieBs/OSE71TZcMXFQjx6kKQ89rwLDDbsBSKZJ7Dy7Hx08NmPYNR2XU+Ae4V5YRq8ff30rNOTPUJN8rm8bxluWef0xXRBY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718799931; c=relaxed/simple;
	bh=hQNDan+UFqR9ttiAhh9GsVYNs82AvEXxBGvx1OpaPW0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RIFn6C2Q8tWS0XsefiDh7sHrl+G0nzxJfjSLGJ3DKhgsLyttyeeLxHjIJkTAq5decdbCaMwT0dLzzalVfSqSwNV0p9HOWZDg5omCOOggGx0X0M064sa9KCn+WoB4tQlkzRwYKkqozUhmw/ITF2NMqiwPieJ0SPZs3BgMDO8Zirg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3B1OpPj; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-705fff50de2so563137b3a.1;
        Wed, 19 Jun 2024 05:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718799929; x=1719404729; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0Ug2g/wIn4Acp6+WRdmoDjC1CjnDCEohkjBAJAA0nk=;
        b=M3B1OpPjMfyYSchdw3dZLip852jfJboKKIbsxreIO2DtQRZ2u6dt8WG4o1vRd9g2l9
         xeyFTp+uYWIIqQ7bcJVdnwb1sVQISlkujXOqw0pPKc6gSRX6WPMlg6S2RLk+Zgw8CqOt
         SitnlohNSZ8xu7bQL7tpc9zoxoMWC42GT+rnIKLV62RMwUhXbs5GnuVbBWxc2THOqMHz
         Regf3R+eiY16Uq/N4DhIOU19EytysOTqZJQi5tXCu9wxm7+oPQqxuxOmqH8JNTITaOqR
         MXwvcz4ioUVLHZLtx4YQMTubjSftv348sLBi6i9bmgxuO399NjFSlJCuhf9I4SEeEz5o
         EMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718799929; x=1719404729;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Z0Ug2g/wIn4Acp6+WRdmoDjC1CjnDCEohkjBAJAA0nk=;
        b=Kcy4x/EYTHm9zUkcwfKg2wei6vcb92N094YU0pHRSatCv14TVBBi9I4qWcn7GMgL+q
         sPHMT9PCfZmhPlt2L/VUYuFHLPmigNrzsvwkRjVTxPX+Xbirqe8DR/OKJ4eLZhlqW09I
         wxYumFeOgsa+ymiKceXONi1sP/6LwIBQpzg7+pXULm+4yZ+D7Mz6YfgiZpPy+ZMV8gKn
         aqcrL9a2Ui4DHl8zVStT6ywCJVIo46fxQhUpTgolbMvtxjNfvBjbfifS+Ik/bUNe5gCg
         kYUdSAdj6OnQh6MCCwtlWICiw0SaK1JPU9VHEgXiemmD5J9YGnGbCIDlFkbU3Ig61vvO
         nXyA==
X-Forwarded-Encrypted: i=1; AJvYcCXATus8DDEG9j7fitje79dL5LuN5lUke+fnqkWomkiiVfSNnzoqczdTarKr7KdvdMkTYU9zRksgnwdrwrt6P/9M3Sx59hiVPWNBn9y3dZHpGxpI1z6273w1FkqAaiIYSrHu
X-Gm-Message-State: AOJu0Yzu4HSHtJ3kofbRkq/r2Van0HpveySwB2g2zKcW5xIEkriNfR9Q
	0QnLcfDWh/gb/yrvvfEEMznoVjhnd2eCN+6lp19agFm+m/kXw8mM
X-Google-Smtp-Source: AGHT+IE1n3e6J5vtH+XvnHz0Hcn1RKaFgUkqBTz8l9pQyCzGnMO9k0LxvqsUebPcdoSuJ03qhAwsaQ==
X-Received: by 2002:a62:ee11:0:b0:704:3580:8e16 with SMTP id d2e1a72fcca58-7061ac34763mr7365753b3a.17.1718799929303;
        Wed, 19 Jun 2024 05:25:29 -0700 (PDT)
Received: from ubuntu.localdomain ([124.126.129.60])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-705ccb3d19esm10500824b3a.122.2024.06.19.05.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jun 2024 05:25:28 -0700 (PDT)
From: Donglin Peng <dolinux.peng@gmail.com>
To: alan.maguire@oracle.com,
	eddyz87@gmail.com
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	song@kernel.org,
	andrii@kernel.org,
	haoluo@google.com,
	yonghong.song@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Donglin Peng <dolinux.peng@gmail.com>
Subject: [PATCH v2] libbpf: checking the btf_type kind when fixing variable offsets
Date: Wed, 19 Jun 2024 05:23:55 -0700
Message-Id: <20240619122355.426405-1-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I encountered an issue when building the test_progs from the repository[1]:

$ pwd
/work/Qemu/x86_64/linux-6.10-rc2/tools/testing/selftests/bpf/

$ make test_progs V=1
...
./tools/sbin/bpftool gen object ./ip_check_defrag.bpf.linked2.o ./ip_check_defrag.bpf.linked1.o
libbpf: failed to find symbol for variable 'bpf_dynptr_slice' in section '.ksyms'
Error: failed to link './ip_check_defrag.bpf.linked1.o': No such file or directory (2)
...

Upon investigation, I discovered that the btf_types referenced in the '.ksyms'
section had a kind of BTF_KIND_FUNC instead of BTF_KIND_VAR:

$ bpftool btf dump file ./ip_check_defrag.bpf.linked1.o
...
[2] DATASEC '.ksyms' size=0 vlen=2
        type_id=16 offset=0 size=0 (FUNC 'bpf_dynptr_from_skb')
        type_id=17 offset=0 size=0 (FUNC 'bpf_dynptr_slice')
...
[16] FUNC 'bpf_dynptr_from_skb' type_id=82 linkage=extern
[17] FUNC 'bpf_dynptr_slice' type_id=85 linkage=extern
...

For a detailed analysis, please refer to [2]. We can add a kind checking to
fix the issue.

[1] https://github.com/eddyz87/bpf/tree/binsort-btf-dedup
[2] https://lore.kernel.org/all/0c0ef20c-c05e-4db9-bad7-2cbc0d6dfae7@oracle.com/

Fixes: 8fd27bf69b86 ("libbpf: Add BPF static linker BTF and BTF.ext support")
Acked-by: Eduard Zingerman <eddyz87@gmail.com>
Reviewed-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Donglin Peng <dolinux.peng@gmail.com>
---
v2:
 - Refactored the code using btf_is_var
 - Improved the comment to be more reasonable
---
 tools/lib/bpf/linker.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/linker.c b/tools/lib/bpf/linker.c
index 0d4be829551b..5a583053e311 100644
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
 
+			/* could be a variable or function */
+			if (!btf_is_var(vt))
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



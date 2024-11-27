Return-Path: <bpf+bounces-45681-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8690C9DA073
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 02:50:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 02D09B21C53
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 01:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19311C6B8;
	Wed, 27 Nov 2024 01:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QOtF1uca"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17ADC8CE;
	Wed, 27 Nov 2024 01:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732672222; cv=none; b=RnqGztJAB+p3zFenzST8vI4jNRH+XYyYu/XQrZ6FVCSXZHd+H4ZN7fv0JFiCo8MJBgzp7Fbz14+z+vHPg7MvWu1nieoT8Hpk53ckbpxS1M1xUs8ugvV2wgx985G73SnAYisHUpEnMyEMBhIq5aq5HSfD9aqRBxZVlwFoXHtUjJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732672222; c=relaxed/simple;
	bh=xGmuB/AwKdNL1dmYV8vXlvuOB2qgbEiT3WS2hh/AiBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oC0vOtvoocNhpfjkcRFoJRcIk4JxrmEIYQUqXQgXO9le5qeyugHbhZN+6reokhMbWe0ErBpydSHzf3esKvO5J529NNXjMVZebZd9pqSrs8O/4ZN7PAujz85YvBktdaneHM2n1Ka4/0Hpt3Hzs4rQd3H8xaECSMzhxyhJWH9feGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QOtF1uca; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7fc2b84bc60so2157111a12.1;
        Tue, 26 Nov 2024 17:50:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732672220; x=1733277020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0NoYEwnt+GsMotgkEfml4R7jCL4w/LVlKCF08jFy8QI=;
        b=QOtF1ucaYYX/CaYdWtPyL5P3aFQ1QhPKLhF0iZu+2OiCgXi+upGOc7Q12PpFRj1E89
         uVI5W+kXcxtO8mZ2ox7yiD0KQEpkMqf/fqEdWG/1kXxD1BmhU0N/oNzW2dbVuMqh4ROV
         waIIeTNPyCY7yHYvYFLEyWAEkhS13HirFvZEAfOLE++ywQ8tE4NAAnZ2zouPQ+KFudqC
         lcC/qVLz6Vyu2arbObKbozT7Fpa88DYHg3PqLq99YrhN1tbX1IG1SOwGmPArp7aT2I1m
         aDzb0lfdNoqCejlwsokGLnLZ4GZhrUBtVj5lysucZoj6b1DHmJR5KV0lEGz82fOUhFRJ
         SGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732672220; x=1733277020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0NoYEwnt+GsMotgkEfml4R7jCL4w/LVlKCF08jFy8QI=;
        b=t4S6BnL1AVjfQPeI64yh6eQXqznH5txXeS9jva/cgqWfTsJ576RXDQvweKlkiyeJhw
         snrTb+FG+WCrL+R13Jcnju798mLS/F4FRowrj/jgVE9teWat2NmwTFDSDGK1OfvaQPOU
         Ac6tTioll5bvL6mDdjWZnsLmErTOdtHNlPuyRrI9E0enRTDbZ3HK+y/5VFTg6ncl0Att
         gZwJKYioF/bvM1LOKiMytirwg2Am0rN2mOZgn6e/jXWd84ZL4J3ncen76LdiXq7ogCZ1
         13Vnyr7mN06icJ8SmX7qHNT7ZY0TjnjHIcn+nYk8uAgJG8YwojoecC5Sbzy/OMVscI6j
         99ww==
X-Gm-Message-State: AOJu0YyQOZ+W2b5ZDdlzFVLzhnU0b/AxRmS3vuvHmMn5W12/hjKj0lxS
	H1ILXdoXCHEg2oUVzF5zvI/rGzkL67HfphZ/t/NjkL3cqVA1J9G1RNdIaw==
X-Gm-Gg: ASbGncuT5jYl/DgFeYhmRdB09RK7wYJt7FMZNE84m7Earvo5C6TGIZ8VCIANzZPFF9m
	RpvoHYCW2yHrjbKm15gfBySxXpEh6fkFMUjX0xXE7z51/OnksMV2jzbPH/xE4nO+LB4rUNDUwil
	AZoCKDoNoNelV7O5iMcl0OfNgQZePB8H1fKj+VCWX/zqAsOa9h2vIZJpfQZQTijeDJJ/Uw7E3zz
	QsG3gaMIZ5VLXstDq4J5Ah8UbLYEesSKdjQn1av6HaTVg==
X-Google-Smtp-Source: AGHT+IEuv0RnrfLsAAfdemrVjKuW7d2yr55T0mo/2CM/z0UkDD5EpWcIDN7BHqDI8yVo6Xv+AVpXYA==
X-Received: by 2002:a05:6a20:2449:b0:1db:eb56:be7c with SMTP id adf61e73a8af0-1e0e0b5377cmr2386587637.35.1732672219857;
        Tue, 26 Nov 2024 17:50:19 -0800 (PST)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724fcdec956sm6312435b3a.25.2024.11.26.17.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Nov 2024 17:50:19 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org,
	kernel-team@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Daniel Xu <dxu@dxuuu.xyz>,
	Jiri Olsa <olsajiri@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Vadim Fedorenko <vadfed@meta.com>
Subject: [PATCH dwarves v3 1/1] btf_encoder: handle .BTF_ids section endianness
Date: Tue, 26 Nov 2024 17:50:06 -0800
Message-ID: <20241127015006.2013050-2-eddyz87@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241127015006.2013050-1-eddyz87@gmail.com>
References: <20241127015006.2013050-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

btf_encoder__tag_kfuncs() reads .BTF_ids section to identify a set of
kfuncs present in the ELF file being processed.
This section consists of:
- arrays of uint32_t elements;
- arrays of records with the following structure:
  struct btf_id_and_flag {
      uint32_t id;
      uint32_t flags;
  };

When endianness of a binary operated by pahole differs from the host
system's endianness, these fields require byte-swapping before use.
Currently, this byte-swapping does not occur, resulting in kfuncs not
being marked with declaration tags.

This commit resolves the issue by using elf_getdata_rawchunk()
function to read .BTF_ids section data. When called with ELF_T_WORD as
'type' parameter it does necessary byte order conversion
(only if host and elf endianness do not match).

Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Daniel Xu <dxu@dxuuu.xyz>
Cc: Jiri Olsa <olsajiri@gmail.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Vadim Fedorenko <vadfed@meta.com>
Fixes: 72e88f29c6f7 ("pahole: Inject kfunc decl tags into BTF")
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index e1adddf..3754884 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -1904,18 +1904,32 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 			goto out;
 		}
 
-		data = elf_getdata(scn, 0);
-		if (!data) {
-			elf_error("Failed to get ELF section(%d) data", i);
-			goto out;
-		}
-
 		if (shdr.sh_type == SHT_SYMTAB) {
+			data = elf_getdata(scn, 0);
+			if (!data) {
+				elf_error("Failed to get ELF section(%d) data", i);
+				goto out;
+			}
+
 			symbols_shndx = i;
 			symscn = scn;
 			symbols = data;
 			strtabidx = shdr.sh_link;
 		} else if (!strcmp(secname, BTF_IDS_SECTION)) {
+			/* .BTF_ids section consists of uint32_t elements,
+			 * and thus might need byte order conversion.
+			 * However, it has type PROGBITS, hence elf_getdata()
+			 * won't automatically do the conversion.
+			 * Use elf_getdata_rawchunk() instead,
+			 * ELF_T_WORD tells it to do the necessary conversion.
+			 */
+			data = elf_getdata_rawchunk(elf, shdr.sh_offset, shdr.sh_size, ELF_T_WORD);
+			if (!data) {
+				elf_error("Failed to get %s ELF section(%d) data",
+					  BTF_IDS_SECTION, i);
+				goto out;
+			}
+
 			idlist_shndx = i;
 			idlist_addr = shdr.sh_addr;
 			idlist = data;
-- 
2.47.0



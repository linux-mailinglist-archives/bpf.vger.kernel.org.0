Return-Path: <bpf+bounces-57191-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 15F7DAA6B39
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 09:04:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A60CF3AA4DD
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 07:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8867E266F1D;
	Fri,  2 May 2025 07:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="crfkqoBJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8960BEC4;
	Fri,  2 May 2025 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746169440; cv=none; b=K/64gRnPD6LRdtWYA7+hZkHRSPw2flSuPvVH7UJoi/T1Ug3FqpGwTbJC1GJIy6fKUY/WC2IUfrV639Z2Ox7tnRTK27dNzFqBA6M5j2nr91fQlv8PeSHKfLCnNYuZ7v46ehRfq4rXV0KREmi82Ha2qZyb7UWfi3VYx2zsuSVh7uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746169440; c=relaxed/simple;
	bh=5NCyzHxoZmrrGUk8gb1hw1m1Gkot6OxYurRwplbQYyY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGBvhiELXQrKLvdXo+DXrVVDIes7vdh32T2ez89FGAtpC+n79pdhIVRCCVxz7v4pGLV86DFFASFeUTmXWaRsitw0iGNXxGHiLjKHQhQC9cZXpLPy8rimIuGe9iYPHnx9kgdlYms7LrLZYAqPcCm4XbBO1bThezUXVQ0Ellfj1uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=crfkqoBJ; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7403f3ece96so2416424b3a.0;
        Fri, 02 May 2025 00:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746169437; x=1746774237; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6FDGQJhNgEuOh2N4eI+6x1J4DY0UC6a+PG+ptep3NfQ=;
        b=crfkqoBJsgjDhXlqD7xh6IXK8kHnjkBc2PJE8aIPyNIDcp6jvn5IHi3TfpcouHfdvk
         t46qfwO6s3aaIns+zhLETeJjp3HV16EQlbrE5qqpo9Y07wX2c/hwtHGyd+6XC0Ixfx32
         f7pa7D+laDkzdLGoL5n/ryMWYo5GSOTjdMtGAoGRmabZRhk/0r+4povbvrrQxJBbTU84
         dac0DlKaIUuzffbDDZh5Ey9M9CNVqVTUs/uglG81CZC0RdKWC8wNh1fRZVIDLBXUUi2+
         yq/saqYZFgqr+hGrZ2R8E2d+7pWbNHgpBmbuU/yEO+cPml8wuDc1DDKbxUOFCIrR6FcU
         749A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746169437; x=1746774237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6FDGQJhNgEuOh2N4eI+6x1J4DY0UC6a+PG+ptep3NfQ=;
        b=ajmdlnxrFFO51WDeBfq/LJEJ1bCGscKVLCN26zDsgGNSs7Qll+72DWEGG7ykvmxRuS
         DxiWp9aPgky3Ttfm1QI3wU3UhB6EThpjCqoXlNDsmqvqMYfY4b46R4oqS7lXcfMCEBNK
         evekl3UGSsz5HQ8bswyyNRtZPXQ9ifJqmmc+LrJqHwjIsE5rfJRoK1ZGWZjhgI67tGfF
         TeSQ8YycNrfbSspOjC2Pyf6HNUwsjFT0/PwPIJUqSNamkG5PzHo97bnY422HoBBc3vZa
         e2MrRCLKUlO83VRzWo0LWTB2MVUjAhFmKRJ8mYOfXW6o5d/+eooYx47dkTiePhxoH0XV
         Agsg==
X-Forwarded-Encrypted: i=1; AJvYcCWixsqEqxfINEiUvFWUDUIukoKVvSCsg7mDTT/mz9QI0kwFr44FirceB145sdvmp/rqFzg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzgq+gYiEy8eGf1HbivN00fRKpZFnAgjfQWfvtdwBR54DISfvkV
	EIw684/FajOuVRANwif1Pb8KNODCk1b0ykQ2HCMMEi00dxP26Ad1QmyLtg==
X-Gm-Gg: ASbGncswdsMR+PvK52GmCgKYZ2q3zxuU3aBYFATLzLtsME3OkUHFqD5jshEdRwMxKeq
	6ifYgTSDTpUQf3EICAaeAsh6DVO45SH3j+Ei3XnuIRXygqPvDHxyAcnEgQK7iPHiyI5qLUYRjPY
	EVlr6UeMm1WMC892RTwcIi+DpvzbOvPI1+apW6tdXEpj6OG1s5Gen75BZU3Xw3tZTAaK7+YxofL
	LEVciyT6nDC9pykCC2QcH53I6vDy6YqJbw3S8VepMCODdS5xVq1ZrPys1Ut+FUZEeEHAJU0Qde3
	jVyCGHVi+hl5/pzQyzP6LLsgAqKQrMp2mU1iBgtu1MGpCw2rEbAXxvOblytdvFzZsGq5uEL74ZV
	VhH0asOmydJpRfJdYnsBHlC4P7L0=
X-Google-Smtp-Source: AGHT+IGz2pQ6N9cuMbwK9ZZ8Rq+H8aLFImVz37je5Fnkhb+tvjIBFfM3OdLxYKoTbZ+sJ/LZ6G6sGw==
X-Received: by 2002:a05:6a21:32aa:b0:201:85f4:ad21 with SMTP id adf61e73a8af0-20cdfee98dbmr2366529637.31.1746169437515;
        Fri, 02 May 2025 00:03:57 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7405902109dsm855071b3a.106.2025.05.02.00.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 May 2025 00:03:56 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>
Subject: [PATCH dwarves v2] dwarf_loader: Fix skipped encoding of function BTF on 32-bit systems
Date: Fri,  2 May 2025 00:03:18 -0700
Message-Id: <20250502070318.1561924-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Z/+HZ3w2KmbK5OAi@kodidev-ubuntu>
References: <Z/+HZ3w2KmbK5OAi@kodidev-ubuntu>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I encountered an issue building BTF kernels for 32-bit armhf, where many
functions are missing in BTF data:

  LD      vmlinux
  BTFIDS  vmlinux
WARN: resolve_btfids: unresolved symbol vfs_truncate
WARN: resolve_btfids: unresolved symbol vfs_fallocate
WARN: resolve_btfids: unresolved symbol scx_bpf_select_cpu_dfl
WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu_node
WARN: resolve_btfids: unresolved symbol scx_bpf_pick_idle_cpu
WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu_node
WARN: resolve_btfids: unresolved symbol scx_bpf_pick_any_cpu
WARN: resolve_btfids: unresolved symbol scx_bpf_kick_cpu
WARN: resolve_btfids: unresolved symbol scx_bpf_exit_bstr
WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_nr_queued
WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_vtime
WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move_to_local
WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_move
WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert_vtime
WARN: resolve_btfids: unresolved symbol scx_bpf_dsq_insert
WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime_from_dsq
WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_vtime
WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_vtime
WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq_set_slice
WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch_from_dsq
WARN: resolve_btfids: unresolved symbol scx_bpf_dispatch
WARN: resolve_btfids: unresolved symbol scx_bpf_destroy_dsq
WARN: resolve_btfids: unresolved symbol scx_bpf_create_dsq
WARN: resolve_btfids: unresolved symbol scx_bpf_consume
WARN: resolve_btfids: unresolved symbol bpf_throw
WARN: resolve_btfids: unresolved symbol bpf_sock_ops_enable_tx_tstamp
WARN: resolve_btfids: unresolved symbol bpf_percpu_obj_new_impl
WARN: resolve_btfids: unresolved symbol bpf_obj_new_impl
WARN: resolve_btfids: unresolved symbol bpf_lookup_user_key
WARN: resolve_btfids: unresolved symbol bpf_lookup_system_key
WARN: resolve_btfids: unresolved symbol bpf_iter_task_vma_new
WARN: resolve_btfids: unresolved symbol bpf_iter_scx_dsq_new
WARN: resolve_btfids: unresolved symbol bpf_get_kmem_cache
WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_xdp
WARN: resolve_btfids: unresolved symbol bpf_dynptr_from_skb
WARN: resolve_btfids: unresolved symbol bpf_cgroup_from_id
  NM      System.map

After further debugging this can be reproduced more simply:

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

Generalize the code for any type of argument misfit to register size (i.e.
zero or > cu->addr_size). This should work for integral or aggregate types,
and also avoids a bug in the current code where a register-sized struct
could be mistaken for larger.

Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
v1 -> v2:
 - Update to preserve existing behaviour where zero-sized struct params
   still permit the function to be encoded, as noted by Alan.

---
 dwarf_loader.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index e1ba7bc..abf1717 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2914,23 +2914,11 @@ out:
 	return 0;
 }
 
-static bool param__is_struct(struct cu *cu, struct tag *tag)
+static bool param__misfits_reg(struct cu *cu, struct tag *tag)
 {
-	struct tag *type = cu__type(cu, tag->type);
+	size_t sz = tag__size(tag, cu);
 
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
+	return sz == 0 || sz > cu->addr_size;
 }
 
 static int cu__resolve_func_ret_types_optimized(struct cu *cu)
@@ -2942,9 +2930,9 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 		struct tag *tag = pt->entries[i];
 		struct parameter *pos;
 		struct function *fn = tag__function(tag);
-		bool has_unexpected_reg = false, has_struct_param = false;
+		bool has_unexpected_reg = false, has_misfit_param = false;
 
-		/* mark function as optimized if parameter is, or
+		/* Mark function as optimized if parameter is, or
 		 * if parameter does not have a location; at this
 		 * point location presence has been marked in
 		 * abstract origins for cases where a parameter
@@ -2953,10 +2941,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 		 *
 		 * Also mark functions which, due to optimization,
 		 * use an unexpected register for a parameter.
-		 * Exception is functions which have a struct
-		 * as a parameter, as multiple registers may
-		 * be used to represent it, throwing off register
-		 * to parameter mapping.
+		 * Exception is functions with a wide/zero-sized
+		 * parameter, as single register won't be used
+		 * to represent it, throwing off register to
+		 * parameter mapping. Examples include large
+		 * structs or 64-bit types on a 32-bit arch.
 		 */
 		ftype__for_each_parameter(&fn->proto, pos) {
 			if (pos->optimized || !pos->has_loc)
@@ -2967,11 +2956,11 @@ static int cu__resolve_func_ret_types_optimized(struct cu *cu)
 		}
 		if (has_unexpected_reg) {
 			ftype__for_each_parameter(&fn->proto, pos) {
-				has_struct_param = param__is_struct(cu, &pos->tag);
-				if (has_struct_param)
+				has_misfit_param = param__misfits_reg(cu, &pos->tag);
+				if (has_misfit_param)
 					break;
 			}
-			if (!has_struct_param)
+			if (!has_misfit_param)
 				fn->proto.unexpected_reg = 1;
 		}
 
-- 
2.34.1



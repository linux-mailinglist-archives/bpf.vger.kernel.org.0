Return-Path: <bpf+bounces-58717-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3635AC04AB
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 08:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD17D16B726
	for <lists+bpf@lfdr.de>; Thu, 22 May 2025 06:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF54522155F;
	Thu, 22 May 2025 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZapXtbq/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0CDB6ADD;
	Thu, 22 May 2025 06:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747895850; cv=none; b=u/3eys5M6viC9Rydr5K4aIrcAJuVKi+6QUIbqTjMUpeMNpXLPf+HgbmTaadCNHMmNPUh/Y4oQ5GKktDmK+ixPHyB/cjEY+mn37+6za3vt+dZcbor5Gy7xaCg1TAR23/7/8qNslUy68tuddtvFIc9vkXGqpArVcb0H/9uKLRoKc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747895850; c=relaxed/simple;
	bh=U0qnvDVw1pYKE0WAa/bV9gGPzoUwWt0vaiNx9905jE8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOwkE7p7JtMp7Q8KCMn00BzSIG1xJhhFjMdE/fJv27qIbM8AcJ+z3fbqjoV0CJZS/J4YS2cnYwnUSZ55dpNEzFlvnJgF+kd8KQc0PBMlPbZOkEpMAeUPEwWrbBzQqkiAGLM99Rs8ppkLgi5wmBOOUx7QEi9gzBwcRPQjFUKcqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZapXtbq/; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b200047a6a5so7363587a12.0;
        Wed, 21 May 2025 23:37:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747895848; x=1748500648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ew1s/jg86gwjlQknnwMwAlr+xmpKIgZuY6XFmGTAPMI=;
        b=ZapXtbq/n8WL63GrWHRHn16NCD7sBoSSSNxfPEGx30j7jqMbTgXBkXcmpCoyZWESxP
         fK0qw6nV977X2SSQTpY31amULFkiCF4AUbyw0ePXJJzemEde6VKpneyC56UwmL7lGd8B
         E/tHwp1NLzSCcYgk9gklYlw74FC7JwQrIU3UsygRKWSDmxVgG8jk92Nkh+VqpulU4gB0
         wb8KjjNEHhkWZKiRs+ZMygUC6r1Umyp8/pIkok+v5nYx+1CnCopqCpnClxcgDD2d077c
         FNYXJXv29R+CjhG9kpzobl6WQJMBL2H/he8U9TxSc2v7XtPzXEjireA6HigIzXbOaRxC
         sJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747895848; x=1748500648;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ew1s/jg86gwjlQknnwMwAlr+xmpKIgZuY6XFmGTAPMI=;
        b=fwByxg71KZycmRDwsD3JNTGBiEM9np7GHSvJDvmkRhTx1V5XTOsnb/yq+2DTJbuOmT
         7pw7zg/X9y7F5GgwK3OkIitiNFohQE6Btbw7i4eQcxrqa3rvr8D5KaeIjxvtbXM3SN9Q
         Jvfgd0P/dD2sVqtjSzCOVPKJFlAyGDniLQ7EeTpEwDDche8GKx1o8vScYHtp9e92c9nS
         3VnoREuzPrFJVML/DlPo95h12rAkQPqIAUjWOteEOK+6WWZjoV5HMz3mqEfGyXzW5AlO
         7Z8Oqq8K7tASb6lK78SAkzXNn8Wh4HFfbjp+1bFoHUtoEqhRHI/EuJCWcv24Mgrb+kU6
         /wtg==
X-Forwarded-Encrypted: i=1; AJvYcCW2iWEs/1iOAvRwWrNfTthy/o/tIeVjiWHwMJhCke8WUBAVThgEXFWIrDPbtrZNviJwuuA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUpe1lUbK5PU+lhWW0Jy6tDVKNxcB8yArdDcZsRVWrqLbYqo8n
	DG49l0EvrQKytXa/iejWvIqRNlAwjNSlRT+cJ7FiL9jyE1tbxRo2g63bscizEQ==
X-Gm-Gg: ASbGnctkkk+ZMsauCSzZ6oEDSk7ffpACQp6YHJCMEHLFCn6h75RDtEuaoqZFshONJxt
	oZruBrWByBdsJK434V1DP38K/PjtfqIlpL00TKaZe/QOeK/MO0opdTgA64SJZMwvcSwLa6Lw6iE
	3NJNmXA4VUzDzLy6A+gb5pMC8ekycJmVZ3NUmbU0S5uLASZamRrqz5eQQcDnWJ3xuxAK9+aayjn
	7xS5qxfpaR5OEZ5H45fqC/GsD8K8UjDoR/1TKV136uSSXxCn7jZZ56ruGdVsUXnEyk420XdlqgR
	mTLBfN2Z1vV+GNVBxMp6uOTzFh6NaTqkzd918Ofk5i0K+3m7BcorFu9i/jmRafRtwzVYL8DIgUr
	OkgOzZzFSKle/bWGQoi1HCnnV/en9MSHkrpIy0g==
X-Google-Smtp-Source: AGHT+IE3TWyrKmijU9+S3XnOzdvfVpU8GInPZsAq8J+s2vXj3+OzNTq4u2Lg0+ZFV+S18C+EVZjplQ==
X-Received: by 2002:a17:90b:2dc8:b0:2fa:562c:c1cf with SMTP id 98e67ed59e1d1-30e4dac9789mr20558542a91.1.1747895847858;
        Wed, 21 May 2025 23:37:27 -0700 (PDT)
Received: from localhost.localdomain (69-172-146-21.cable.teksavvy.com. [69.172.146.21])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365e5dc6sm4787210a91.40.2025.05.21.23.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 May 2025 23:37:27 -0700 (PDT)
From: Tony Ambardar <tony.ambardar@gmail.com>
To: dwarves@vger.kernel.org,
	bpf@vger.kernel.org
Cc: Tony Ambardar <tony.ambardar@gmail.com>,
	Alan Maguire <alan.maguire@oracle.com>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	=?UTF-8?q?Alexis=20Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Subject: [PATCH dwarves v3] dwarf_loader: Fix skipped encoding of function BTF on 32-bit systems
Date: Wed, 21 May 2025 23:37:19 -0700
Message-Id: <20250522063719.1885902-1-tony.ambardar@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250502070318.1561924-1-tony.ambardar@gmail.com>
References: <20250502070318.1561924-1-tony.ambardar@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
code handling arguments larger than register-size, allowing them to be
BTF encoded but only if structs.

Generalize the code for any argument type larger than register size (i.e.
size > cu->addr_size). This should work for integral or aggregate types,
and also avoids a bug in the current code where a register-sized struct
could be mistaken for larger. Note that zero-sized arguments will still
be marked as inconsistent and not encoded.

Fixes: a53c58158b76 ("dwarf_loader: Mark functions that do not use expected registers for params")
Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Tested-by: Alan Maguire <alan.maguire@oracle.com>
Signed-off-by: Tony Ambardar <tony.ambardar@gmail.com>
---
v2 -> v3:
 - Added Tested-by: from Alexis and Alan.
 - Revert support for encoding 0-sized structs (as v1) after discussion:
   https://lore.kernel.org/dwarves/9a41b21f-c0ae-4298-bf95-09d0cdc3f3ab@oracle.com/
 - Inline param__is_wide() and clarify some naming/wording.

v1 -> v2:
 - Update to preserve existing behaviour where zero-sized struct params
   still permit the function to be encoded, as noted by Alan.

---
 dwarf_loader.c | 37 ++++++++++++-------------------------
 1 file changed, 12 insertions(+), 25 deletions(-)

diff --git a/dwarf_loader.c b/dwarf_loader.c
index e1ba7bc..134a76b 100644
--- a/dwarf_loader.c
+++ b/dwarf_loader.c
@@ -2914,23 +2914,9 @@ out:
 	return 0;
 }
 
-static bool param__is_struct(struct cu *cu, struct tag *tag)
+static inline bool param__is_wide(struct cu *cu, struct tag *tag)
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
+		 * Exception is functions with a wide parameter,
+		 * as single register won't be used to represent
+		 * it, throwing off register to parameter mapping.
+		 * Examples include large structs or 64-bit types
+		 * on a 32-bit arch.
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



Return-Path: <bpf+bounces-35822-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 358E293E373
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 05:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 61F961C21138
	for <lists+bpf@lfdr.de>; Sun, 28 Jul 2024 03:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 546334A05;
	Sun, 28 Jul 2024 03:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U3lVZ1Rl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E27F184D
	for <bpf@vger.kernel.org>; Sun, 28 Jul 2024 03:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722135704; cv=none; b=NXtZ8gcr6Anci5oMFyHKYz2vGKKKH4aa00/tN/RvGZvt/XcxPA1HamUR1ZrivqxgjXsb1S8GKc1o+mnnv+AztFAOpnxp4TQwiXeJcCAlU9ibh67WMhLjmQ8ktcBbHDhxWbwNmYT8mvj1dmzVCXia2Ua/f2BoZdKUS7+zf/Yq4tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722135704; c=relaxed/simple;
	bh=RwfWHgtCdrEbA9YQ9AdXSlgPIospQ0IeS9BdX2rF2GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TZyN7tjciYQR4zNyy6TyHQ9FAdxgoLcpoBdzgWEwWp5xE6DNs+cmSE/cLwP0H5vJ5/vYAyTfcQvoPs2mZ3ViKG17oFudtYXhqb+WEZHXaPeCCVY7mjDm4hphPmKM6W5ij2qXJFGOOeVx9sviVO/EzZId+4g2RlnkHc10UgydUMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U3lVZ1Rl; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6b7a4668f07so10712116d6.1
        for <bpf@vger.kernel.org>; Sat, 27 Jul 2024 20:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722135702; x=1722740502; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Dds8dIKOzIPsqNySyOBwetSI9ZRPmVfowMAUFUWv5g=;
        b=U3lVZ1RlEFGpchFwp41aJ6EYSBGWmhGuaL2SzQY5ItLLamNdEwXq/bd0l2aeNc/s34
         NRsuSPcNR+93YN9D0wgFlJyM0/AbZ6KrCHbtdryImP7Q+Vr82LPv74RZIb935GveAKy8
         mtD2qIpPZr0Rqhhjehxpu2l+ZFM3IIt8qbz+rXCElbnEXHLJIf24LtxaYBZ/RyWLRt6v
         bPU+1M6tQQEwp/OmcTS+4sa4kTXr3f422OuKcGZDQ9nJvCRpxGCNuZFIlwY2Omz/+27S
         vBoUQCEzSMcfGxGDFqIzHrGnW0y0CnH5nW7BTRqm1xg7gpkDQJduSXSG5dxHrZldWZBu
         uvuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722135702; x=1722740502;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Dds8dIKOzIPsqNySyOBwetSI9ZRPmVfowMAUFUWv5g=;
        b=gkFBBMuhs8Z+c1KObjDeVzGykazpI+sCyLFYJRzLaUalkr/8HwASpT85/iYIkHl1yq
         Pn9lKqzPRQnTckx59t0oke9uSkg+6xExn0G81AV4SAR5G6jakXDwcPYrdOsMjEn2auks
         KCGcUxCr8AbkC+rkfhKkZfFcOgm0OOn1Ral4aKjyZ77ERutNwXBG82NA2IHL+o/GlxBx
         0wTfVO11Y/wP4Ih98QBGwEvTp1LUeGI3oz+dpsD+N5ZC60aIS1jobuhjY2ysu01Nx/Js
         oU2YOZ1jRwfCFUg6JhlhHtFJiKCUqoctPveSrDdH0ztOL3Il0he88Bu/JNcvsQXr5dVI
         P1Gg==
X-Gm-Message-State: AOJu0YyDmHjZIytIUUjblBMBrq+IpWACXiCGoWMd3GNVblUOWm3PfvrS
	nCyv6nZ0+ffn9zOsHsEgpTOOppArPij8VsWtivFYCyOZvU5eCiDVx2JsOw==
X-Google-Smtp-Source: AGHT+IE1WlJ5GwfRoYu7Ldmc3Zos2PKOJwvQuuNq6QS+Jp3/ibLjv06WvmIfJNXrXsE1u28v3R7Xfw==
X-Received: by 2002:a05:6214:2261:b0:6b5:1976:98ac with SMTP id 6a1803df08f44-6bb55a6f10bmr59669306d6.28.1722135702047;
        Sat, 27 Jul 2024 20:01:42 -0700 (PDT)
Received: from n36-183-057.byted.org ([139.177.233.179])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f90e7b9sm37953306d6.52.2024.07.27.20.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jul 2024 20:01:41 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
X-Google-Original-From: Amery Hung <amery.hung@bytedance.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	davemarchevsky@fb.com,
	ameryhung@gmail.com,
	Amery Hung <amery.hung@bytedance.com>
Subject: [PATCH v1 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
Date: Sun, 28 Jul 2024 03:01:12 +0000
Message-Id: <20240728030115.3970543-2-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240728030115.3970543-1-amery.hung@bytedance.com>
References: <20240728030115.3970543-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Marchevsky <davemarchevsky@fb.com>

Currently btf_parse_fields is used in two places to create struct
btf_record's for structs: when looking at mapval type, and when looking
at any struct in program BTF. The former looks for kptr fields while the
latter does not. This patch modifies the btf_parse_fields call made when
looking at prog BTF struct types to search for kptrs as well.

Before this series there was no reason to search for kptrs in non-mapval
types: a referenced kptr needs some owner to guarantee resource cleanup,
and map values were the only owner that supported this. If a struct with
a kptr field were to have some non-kptr-aware owner, the kptr field
might not be properly cleaned up and result in resources leaking. Only
searching for kptr fields in mapval was a simple way to avoid this
problem.

In practice, though, searching for BPF_KPTR when populating
struct_meta_tab does not expose us to this risk, as struct_meta_tab is
only accessed through btf_find_struct_meta helper, and that helper is
only called in contexts where recognizing the kptr field is safe:

  * PTR_TO_BTF_ID reg w/ MEM_ALLOC flag
    * Such a reg is a local kptr and must be free'd via bpf_obj_drop,
      which will correctly handle kptr field

  * When handling specific kfuncs which either expect MEM_ALLOC input or
    return MEM_ALLOC output (obj_{new,drop}, percpu_obj_{new,drop},
    list+rbtree funcs, refcount_acquire)
     * Will correctly handle kptr field for same reasons as above

  * When looking at kptr pointee type
     * Called by functions which implement "correct kptr resource
       handling"

  * In btf_check_and_fixup_fields
     * Helper that ensures no ownership loops for lists and rbtrees,
       doesn't care about kptr field existence

So we should be able to find BPF_KPTR fields in all prog BTF structs
without leaking resources.

Further patches in the series will build on this change to support
kptr_xchg into non-mapval local kptr. Without this change there would be
no kptr field found in such a type.

On a side note, when building program BTF, the refcount of program BTF
is now initialized before btf_parse_struct_metas() to prevent a
refcount_inc() on zero warning. This happens when BPF_KPTR is present
in program BTF: btf_parse_struct_metas() -> btf_parse_fields()
-> btf_parse_kptr() -> btf_get(). This should be okay as the program BTF
is not available yet outside btf_parse().

Signed-off-by: Dave Marchevsky <davemarchevsky@fb.com>
Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 kernel/bpf/btf.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 95426d5b634e..7b8275e3e500 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -5585,7 +5585,8 @@ btf_parse_struct_metas(struct bpf_verifier_log *log, struct btf *btf)
 		type = &tab->types[tab->cnt];
 		type->btf_id = i;
 		record = btf_parse_fields(btf, t, BPF_SPIN_LOCK | BPF_LIST_HEAD | BPF_LIST_NODE |
-						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT, t->size);
+						  BPF_RB_ROOT | BPF_RB_NODE | BPF_REFCOUNT |
+						  BPF_KPTR, t->size);
 		/* The record cannot be unset, treat it as an error if so */
 		if (IS_ERR_OR_NULL(record)) {
 			ret = PTR_ERR_OR_ZERO(record) ?: -EFAULT;
@@ -5737,6 +5738,8 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 	if (err)
 		goto errout;
 
+	refcount_set(&btf->refcnt, 1);
+
 	struct_meta_tab = btf_parse_struct_metas(&env->log, btf);
 	if (IS_ERR(struct_meta_tab)) {
 		err = PTR_ERR(struct_meta_tab);
@@ -5759,7 +5762,6 @@ static struct btf *btf_parse(const union bpf_attr *attr, bpfptr_t uattr, u32 uat
 		goto errout_free;
 
 	btf_verifier_env_free(env);
-	refcount_set(&btf->refcnt, 1);
 	return btf;
 
 errout_meta:
-- 
2.20.1



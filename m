Return-Path: <bpf+bounces-36330-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CD5946665
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 02:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A15E1F22643
	for <lists+bpf@lfdr.de>; Sat,  3 Aug 2024 00:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A8F139B;
	Sat,  3 Aug 2024 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF0NJkZ2"
X-Original-To: bpf@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D49191
	for <bpf@vger.kernel.org>; Sat,  3 Aug 2024 00:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722643917; cv=none; b=J206uAOqjHPPnmNO/EQuo9DzjG1FxZEj/S+5AhcFVz0dzzzKVpUbK6qxp5i4BdIYc51SIveEVitaLoIejZoY/ZmaK40YxB/hWgBkkr5NcNDXMngEbldK/drOgGYmhqUfRIdCetabfEe2LNXwXPsIo8EncKBxNHQnUrwgYYLjNrw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722643917; c=relaxed/simple;
	bh=voNihqKQMuk1yidTHJCaxX/8Zu8tzRPycWP7ezl0scY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HcD/4HhYIufih+GHjMV0jqwUed/ZY8xy5/2ijOSnIQXvOiRBMVa0EHZdckKAgJMLj3mB4aLCtbIs8n8ntDIPmoLFG4WmfBW6KcK1cYMFc1L7K0fGJhOG2U2XTfdYLE7xJV2IADCgB9ZuekhbtoIszWG14He8e/Cw5CQvpcsRJW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF0NJkZ2; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4f6c136a947so4157543e0c.1
        for <bpf@vger.kernel.org>; Fri, 02 Aug 2024 17:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722643915; x=1723248715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wzbspOhbYy/qMsRWbmrmbMFro6v1ZxkA+TC7d+6sxbU=;
        b=QF0NJkZ2E43qbZV3MyWyasCE2JF3PV+NSInGWJ0MpS3hvE8vvN0yHYpJfzrNfOhGqp
         tuffaBrXNRbzu9BCe1Y8jz0gnUoGkPCyZha/WaPQtnqcjQvYeF4NhwjQb75KOd1G522f
         /iclMDr+vnKwkscm/2Lh4Id88FuxNhXxpyAqC/n+8xTPVCXUbZGu21BuGHTC5JmqEpfB
         J+lRgsH89zSIztStuyrsTkpSBT7dYl8gh+Jlofx9gOwi3/xUMqkiyYb1udP4CIrQvLUr
         55FJatJAR1uwRhgRM/6fxBTI75czZOCc7i5ByyBJEzWQAgLCq59edoF8AP56mSRFzSz7
         rh9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722643915; x=1723248715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wzbspOhbYy/qMsRWbmrmbMFro6v1ZxkA+TC7d+6sxbU=;
        b=r4WixVUdPqLlmigri3tzfFBPv0EfUgfKtI+nJ9mUAOVSgfzeqZi2L3KRv7PvQ+8AHZ
         oAgHNWNel1Klcwtw3gfMVe5uEQCs3zhn9arLx/ypvj4hd26rPKZNKCh73g2RXxaF6Rwa
         LH7Vuv6OqXTL6spD+m1DNIppZM6xCG+1wSG9u7vgcr6dXsMrawiNXLj/a0tHeyXbvFkL
         jABi9l5D0DhLp6u2n4O+wSeqMWZ5mN+gCnqZKvztBH1oW4x+SXbHp2sBcdiP2tAakQ6B
         oSyaXPND5TuHabTSb4TRF/wUnHZmd0bVm/nwsqWoNnp61p5QlgGq4c+8tZvHy983YIdC
         Om0w==
X-Gm-Message-State: AOJu0YxzTYxrsuISlUhpGCnGLuwtooFCZdl8Dh++c8uSWwZmfVL0Tyf6
	mN1wyJ9ze4cvLVrU7S1xYA9xG5YWoK7G3WHyiv2jjkqPsXXrMvn4KRHl+Q==
X-Google-Smtp-Source: AGHT+IEK7ZORyPVJDszlyQJIyCom9kbCjpykbDzc3EuZvyvoAJuyYPLAzzHQEDnNSK6MbbXAjMhnjg==
X-Received: by 2002:a05:6122:4598:b0:4f6:adb5:aee1 with SMTP id 71dfb90a1353d-4f8a00229f8mr6846803e0c.13.1722643914700;
        Fri, 02 Aug 2024 17:11:54 -0700 (PDT)
Received: from n36-183-057.byted.org ([130.44.215.84])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a34f6dce75sm129547485a.14.2024.08.02.17.11.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Aug 2024 17:11:54 -0700 (PDT)
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
Subject: [PATCH v2 bpf-next 1/4] bpf: Search for kptrs in prog BTF structs
Date: Sat,  3 Aug 2024 00:11:42 +0000
Message-Id: <20240803001145.635887-2-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20240803001145.635887-1-amery.hung@bytedance.com>
References: <20240803001145.635887-1-amery.hung@bytedance.com>
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

Acked-by: Martin KaFai Lau <martin.lau@kernel.org>
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



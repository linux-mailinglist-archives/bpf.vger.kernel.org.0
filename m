Return-Path: <bpf+bounces-78321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 48E52D0A5FA
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 14:21:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFD9A31E4CF5
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 13:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1304435E529;
	Fri,  9 Jan 2026 13:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZTOBZn3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480A135BDB6
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 13:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963632; cv=none; b=eKgsnsL3OHfPw342H59bhA5xRMABaiKI6GenLbSRBMnEWQTFxl3RGGyOb1NUpntOejWPKZpYLQ/gIUiXb1X9GRNVrdchqKJvbuE56BcLN0vVsgkf5AnRRPXg5UCe0B0Zkq96O0xiFenvQpZ8beOTjH3j7bb67jSAbzMf/mNMcos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963632; c=relaxed/simple;
	bh=mYzJ+kJtBrf1ZOrVJNkEAMPCA73IwwJ3Vq1Lvdq2Ri0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=joTSfhjKWGHa19v6aMGmxyzXmFjj+AY1AWUwYtbvgnYpjHQkIRPO+P51z5wCoT6d+uJuVS86pwWiEYeE8tdcauhM8pciPBPiNYdsJ7jMJftn9+zv7Szfd82Ol6w8+Cx+F1Ud5K6h+H8zOBLb6AwIkLNk4saHVrPMBfF9JL0XQzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MZTOBZn3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a099233e8dso31480725ad.3
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 05:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963631; x=1768568431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TUW7LB43dCgnLiOgR7S2ttrd8S36AZDQc8SQtsp0WmA=;
        b=MZTOBZn39HLC/jnQgGqREw3LqW29Y6bNB+PAzbre8wyPQkFmeoYjL/sQMMd4nYuJIR
         IJCsyfMqYNV9GCWUCiH2PH0O6UOhZGLpfZ2gIS4Q+uP3vKAcdh/yqeIoJU4Ee4Um90br
         yfnYhU7lcifIvnkc0mtXeTL0uFcl2IwGS4KSLHijtML68neuiAywg2IBRQMagyVM8/yh
         3e0scd3JWdAo/aOA82zVvucDmB6OG+QMMBjnbdsAjHbdMhziiatwMZCWeiACkY2lmAJw
         wEFOEjQDHxK81ukldOMmzG5MBSk11zUjvOMSRRoOJzsOPt8sp/8cF/whlt/geBLcDv8e
         VqCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963631; x=1768568431;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TUW7LB43dCgnLiOgR7S2ttrd8S36AZDQc8SQtsp0WmA=;
        b=obRuZmeukTWanMCeF5iLHTbSn564k/4O+yYXKfIfbxvrDDSeBo+zb3BDnuFb/Y3/7z
         PqUC8NwnbVjqjwXuK+TIPnP5GsFn6HGXQyifptFcEv0jqC4cHOjE0iy4RL0tQsfZM1CP
         +f0hh9f7YNZOhK3l5WLkTrVIcodPErEKibOQMTsQWgZuUb3KWTTk64WHtdDNI4WYV/d+
         TedOYnA+EDcxh+cvHRL7kcTxxQnQajdgBcV0jnWh4TQ1Tvzf9qbQ2gHlUOsDslCFLhtP
         akwd33cS9E1M2J5khe/OpJuuthfEsW20XnggMewOWTZalfhE9C9bTlrWhz6siVhdJ9oH
         2xvA==
X-Forwarded-Encrypted: i=1; AJvYcCU4vKagtb62Q8AODPLhbRz9cEruspUSq7aWeYOdQgtivzjV8wIxCRMZmPbzeu4GVMeBFF8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzdEg6Vaz7ijnoZ/d/TTXFIt7uhEaxTKk/hI3EJojeiQN3tkB5
	1MS5fEAgISV40HDb39Tta195khmZo6GN8ZYZlGO8S803XNGS1OF52Xuf
X-Gm-Gg: AY/fxX69ta5nZgODzbRcW3TuOWeZgGmn1EhIVe3iXC6nHB3i9+O59feIx28JSuJS7gS
	3AFCunq0BV90MBVtXclXI+RDPxsaTeYKfpWxZ2ovJPRhTQgYKNHoMI9PVPlX3rqzB3O0yF/QmrI
	SeyYCKX8LsKb1lr3vg+sY3l8ct9YGsr6Z55NxcpSckYetcDd7He92YDMprvi+dg5WSvytSrDWC3
	HY34lmdGDDl34AcOTnI3Q6Ckn6o1r0QM6c7xG7n9qNvZEqt6TWQ0GAmht+3lZIyVBKa3x9Jro9l
	HvdjI+PfuMVqqFnYgBYdB7bn+8fy+SknopqZGqQ/T9U8iEYQVq20oN68hMlgZy/QUNlGj0CmT0T
	z0XkFf7LK0YfvSAEcMEEj5FFIWp2zgLsvR4UQ1Pv/sMRSuPYDJ+Sy3WzUI91w+Hlag/++FvLF5A
	4cnPUZTjQGhDg1/Asb/wbSs/68iMo=
X-Google-Smtp-Source: AGHT+IFZdcePi4FWnR5ODfZLAiRMhV1+kMAPOJFuJ1swEbYXGuIYwPL7AAx1NXjqZtbj+QKXNQIdGg==
X-Received: by 2002:a17:903:38cc:b0:2a0:e5da:febf with SMTP id d9443c01a7336-2a3ee4aaa9cmr92963955ad.46.1767963630236;
        Fri, 09 Jan 2026 05:00:30 -0800 (PST)
Received: from pengdl-pc.mioffice.cn ([43.224.245.249])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3c3a328sm104927325ad.4.2026.01.09.05.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 05:00:29 -0800 (PST)
From: Donglin Peng <dolinux.peng@gmail.com>
To: ast@kernel.org,
	andrii.nakryiko@gmail.com,
	eddyz87@gmail.com
Cc: zhangxiaoqin@xiaomi.com,
	ihor.solodrai@linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Donglin Peng <pengdonglin@xiaomi.com>,
	Alan Maguire <alan.maguire@oracle.com>
Subject: [PATCH bpf-next v12 07/11] btf: Verify BTF sorting
Date: Fri,  9 Jan 2026 20:59:59 +0800
Message-Id: <20260109130003.3313716-8-dolinux.peng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260109130003.3313716-1-dolinux.peng@gmail.com>
References: <20260109130003.3313716-1-dolinux.peng@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Donglin Peng <pengdonglin@xiaomi.com>

This patch checks whether the BTF is sorted by name in ascending order.
If sorted, binary search will be used when looking up types.

Specifically, vmlinux and kernel module BTFs are always sorted during
the build phase with anonymous types placed before named types, so we
only need to identify the starting ID of named types.

Cc: Eduard Zingerman <eddyz87@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alan Maguire <alan.maguire@oracle.com>
Cc: Ihor Solodrai <ihor.solodrai@linux.dev>
Cc: Xiaoqin Zhang <zhangxiaoqin@xiaomi.com>
Signed-off-by: Donglin Peng <pengdonglin@xiaomi.com>
---
 kernel/bpf/btf.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index d1f4b984100d..12eecf59d71f 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -550,6 +550,46 @@ u32 btf_nr_types(const struct btf *btf)
 	return total;
 }
 
+/* Note that vmlinux and kernel module BTFs are always sorted
+ * during the building phase.
+ */
+static void btf_check_sorted(struct btf *btf)
+{
+	u32 i, n, named_start_id = 0;
+
+	n = btf_nr_types(btf);
+	if (btf_is_vmlinux(btf)) {
+		for (i = btf_start_id(btf); i < n; i++) {
+			const struct btf_type *t = btf_type_by_id(btf, i);
+			const char *n = btf_name_by_offset(btf, t->name_off);
+
+			if (n[0] != '\0') {
+				btf->named_start_id = i;
+				return;
+			}
+		}
+		return;
+	}
+
+	for (i = btf_start_id(btf) + 1; i < n; i++) {
+		const struct btf_type *ta = btf_type_by_id(btf, i - 1);
+		const struct btf_type *tb = btf_type_by_id(btf, i);
+		const char *na = btf_name_by_offset(btf, ta->name_off);
+		const char *nb = btf_name_by_offset(btf, tb->name_off);
+
+		if (strcmp(na, nb) > 0)
+			return;
+
+		if (named_start_id == 0 && na[0] != '\0')
+			named_start_id = i - 1;
+		if (named_start_id == 0 && nb[0] != '\0')
+			named_start_id = i;
+	}
+
+	if (named_start_id)
+		btf->named_start_id = named_start_id;
+}
+
 /* btf_named_start_id - Get the named starting ID for the BTF
  * @btf: Pointer to the target BTF object
  * @own: Flag indicating whether to query only the current BTF (true = current BTF only,
@@ -6302,6 +6342,7 @@ static struct btf *btf_parse_base(struct btf_verifier_env *env, const char *name
 	if (err)
 		goto errout;
 
+	btf_check_sorted(btf);
 	refcount_set(&btf->refcnt, 1);
 
 	return btf;
@@ -6436,6 +6477,7 @@ static struct btf *btf_parse_module(const char *module_name, const void *data,
 	}
 
 	btf_verifier_env_free(env);
+	btf_check_sorted(btf);
 	refcount_set(&btf->refcnt, 1);
 	return btf;
 
-- 
2.34.1



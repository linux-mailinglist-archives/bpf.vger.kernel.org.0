Return-Path: <bpf+bounces-39992-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 253DC979E49
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 11:19:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4E421F214F8
	for <lists+bpf@lfdr.de>; Mon, 16 Sep 2024 09:19:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EB2F1487E9;
	Mon, 16 Sep 2024 09:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TX0Pl5kY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F2081B85C1;
	Mon, 16 Sep 2024 09:19:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726478384; cv=none; b=i26VV96GWJpJZ6ncG5T7Kv3fFykLxfwv7ZjMC23REWi6uiiphIJIQThvIi7ikY8pbjEUkZ6ppwHAEvC9HLjNwuaJNrP5oPio9D2Zu8AOEmPi9ErmUaoAsgHyJRtsupF464LIzek6LS87jbSOrqL0V9b6a6IHx4P57FRXC0wwGKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726478384; c=relaxed/simple;
	bh=2GmQavj+2ovu91GK9cEdwMIDeZWOoZrwXdez2y1WTPU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlRcYiJh+XUQ+g8dfd2Z/AminCgMliTFrvwTWIf6nf15el4V+rJUBNSx8b0zNR1uo/NXYYUVPCZOQzff06Ccpn0ZU+5GLXbm/LE1hK8wWpu6zgpqhKW9byq50CBVVBs6eFzFn2F5dg3RQkO20xuazjjFM29/ArH+SvP2wadXns4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TX0Pl5kY; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7193010d386so2545741b3a.1;
        Mon, 16 Sep 2024 02:19:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726478383; x=1727083183; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QktFEEO18LrZlfY8LGBDynU4buhM4pi/Po4s1KCzk/M=;
        b=TX0Pl5kY3ar/+hv1JZu+iRUbiYAv/S460rqLub+efq1Vry1P3+5EXcqRzhaEPSA7lX
         f4AMQ+A0HaqWv+WujeXbXSp+p/Ir+vly41JeHN6VDaqu83qJhLknsgCC1VsEqrP4GKte
         g218ml4+KuvKzNiaqb8nZtCaCsYvCnIv3z7C9CzvG8Ud6L/essnuhAwpdn7L1zuA8Bsq
         8fnqlgy4goyROjm5zNA6cXd7eR/u/PxVbXJB+9AsSPs2i8XO13CGa7enoBFgr+xZAivI
         Sd+5BLHkrM2kfz3gSLv5x1y1jdExl16E+f6MjAnOtvrLlYApNuQqEZwA8votvlC8a7Kp
         bTuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726478383; x=1727083183;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QktFEEO18LrZlfY8LGBDynU4buhM4pi/Po4s1KCzk/M=;
        b=jMaPG238OZlkNaXhDwZ92xXfNYXUQWApglWR2N/gHLfOyVsVkOomsotPZdiFvZe59b
         nxVxWZ3vdWenOz2UYYQ/lI/94K7HjsW8OZSMtSIGrwsA6zsFQ/vjTHhaOayvx1W5/8r7
         9ol3aCLBNI+6OH1GYYkHdgjNNtvglRDxKtFmFb8nho1oASa7ohNy7q78A4ELpFMERE40
         Efe30eINes26PMpbK/uObqhufTbAyf9NWS0YtoL+D6mUmYu85GdmGziE3f5x/53vdB06
         u+cKb5oVul0aPCFvIOQCCpBGq1jiKZ4Rqczp1HXA/WYeNhBaubwRJOtxd0NmzHCrmfYx
         g9XA==
X-Gm-Message-State: AOJu0YyYP1qhH1Peaxy6s9ZqhKRykI/twnP5ZsnbKHMlpfoQTFlzg+UU
	+XalV0b3cZlMsNWbmK9EK2+OVzR/qcHiD+gQfjsD4osp0sF5G+ZHeIwZ0A==
X-Google-Smtp-Source: AGHT+IFEkqVeAJGnVyxxFJImbQHZHMHGhA4VNZhCrMMiIYTPJYvRLr2I6+13W+cRRcx+XDqCwIa0FA==
X-Received: by 2002:a05:6a00:238c:b0:70d:323f:d0c6 with SMTP id d2e1a72fcca58-71936b1a480mr18602430b3a.24.1726478382396;
        Mon, 16 Sep 2024 02:19:42 -0700 (PDT)
Received: from honey-badger.. ([38.34.87.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-7db498e05dbsm3790317a12.19.2024.09.16.02.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Sep 2024 02:19:41 -0700 (PDT)
From: Eduard Zingerman <eddyz87@gmail.com>
To: dwarves@vger.kernel.org,
	arnaldo.melo@gmail.com
Cc: bpf@vger.kernel.org,
	kernel-team@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	yonghong.song@linux.dev,
	martin.lau@linux.dev,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH dwarves v1] pahole: generate "bpf_fastcall" decl tags for eligible kfuncs
Date: Mon, 16 Sep 2024 02:19:21 -0700
Message-ID: <20240916091921.2929615-1-eddyz87@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For kfuncs marked with KF_FASTCALL flag generate the following pair of
decl tags:

    $ bpftool btf dump file vmlinux
    ...
    [A] FUNC 'bpf_rdonly_cast' type_id=...
    ...
    [B] DECL_TAG 'bpf_kfunc' type_id=A component_idx=-1
    [C] DECL_TAG 'bpf_fastcall' type_id=A component_idx=-1

So that bpftool could find 'bpf_fastcall' decl tag and generate
appropriate C declarations for such kfuncs, e.g.:

    #ifndef __VMLINUX_H__
    #define __VMLINUX_H__
    ...
    #define __bpf_fastcall __attribute__((bpf_fastcall))
    ...
    __bpf_fastcall extern void *bpf_rdonly_cast(...) ...;

For additional information about 'bpf_fastcall' attribute,
see the following commit in the LLVM source tree:

64e464349bfc ("[BPF] introduce __attribute__((bpf_fastcall))")

And the following Linux kernel commit:

52839f31cece ("Merge branch 'no_caller_saved_registers-attribute-for-helper-calls'")

Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 btf_encoder.c | 59 +++++++++++++++++++++++++++++++++++++--------------
 1 file changed, 43 insertions(+), 16 deletions(-)

diff --git a/btf_encoder.c b/btf_encoder.c
index 8a2d92e..ae059e0 100644
--- a/btf_encoder.c
+++ b/btf_encoder.c
@@ -39,15 +39,19 @@
 #define BTF_ID_SET8_PFX		"__BTF_ID__set8__"
 #define BTF_SET8_KFUNCS		(1 << 0)
 #define BTF_KFUNC_TYPE_TAG	"bpf_kfunc"
+#define BTF_FASTCALL_TAG	"bpf_fastcall"
+#define KF_FASTCALL		(1 << 12)
+
+struct btf_id_and_flag {
+        uint32_t id;
+        uint32_t flags;
+};
 
 /* Adapted from include/linux/btf_ids.h */
 struct btf_id_set8 {
         uint32_t cnt;
         uint32_t flags;
-        struct {
-                uint32_t id;
-                uint32_t flags;
-        } pairs[];
+	struct btf_id_and_flag pairs[];
 };
 
 /* state used to do later encoding of saved functions */
@@ -1517,21 +1521,34 @@ out:
 	return err;
 }
 
-static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc)
+static int add_kfunc_decl_tag(struct btf *btf, const char *tag, __u32 id, const char *kfunc)
+{
+	int err;
+
+	err = btf__add_decl_tag(btf, tag, id, -1);
+	if (err < 0) {
+		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
+			__func__, kfunc, err);
+		return err;
+	}
+	return 0;
+}
+
+static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *funcs, const char *kfunc, __u32 flags)
 {
 	struct btf_func key = { .name = kfunc };
 	struct btf *btf = encoder->btf;
 	struct btf_func *target;
 	const void *base;
 	unsigned int cnt;
-	int err = -1;
+	int err;
 
 	base = gobuffer__entries(funcs);
 	cnt = gobuffer__nr_entries(funcs);
 	target = bsearch(&key, base, cnt, sizeof(key), btf_func_cmp);
 	if (!target) {
 		fprintf(stderr, "%s: failed to find kfunc '%s' in BTF\n", __func__, kfunc);
-		goto out;
+		return -1;
 	}
 
 	/* Note we are unconditionally adding the btf_decl_tag even
@@ -1539,16 +1556,16 @@ static int btf_encoder__tag_kfunc(struct btf_encoder *encoder, struct gobuffer *
 	 * We are ok to do this b/c we will later btf__dedup() to remove
 	 * any duplicates.
 	 */
-	err = btf__add_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, -1);
-	if (err < 0) {
-		fprintf(stderr, "%s: failed to insert kfunc decl tag for '%s': %d\n",
-			__func__, kfunc, err);
-		goto out;
+	err = add_kfunc_decl_tag(btf, BTF_KFUNC_TYPE_TAG, target->type_id, kfunc);
+	if (err < 0)
+		return err;
+	if (flags & KF_FASTCALL) {
+		err = add_kfunc_decl_tag(btf, BTF_FASTCALL_TAG, target->type_id, kfunc);
+		if (err < 0)
+			return err;
 	}
 
-	err = 0;
-out:
-	return err;
+	return 0;
 }
 
 static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
@@ -1675,8 +1692,10 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 	/* Now inject BTF with kfunc decl tag for detected kfuncs */
 	for (i = 0; i < nr_syms; i++) {
 		const struct btf_kfunc_set_range *ranges;
+		const struct btf_id_and_flag *pair;
 		unsigned int ranges_cnt;
 		char *func, *name;
+		ptrdiff_t off;
 		GElf_Sym sym;
 		bool found;
 		int err;
@@ -1704,6 +1723,14 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 
 			if (ranges[j].start <= addr && addr < ranges[j].end) {
 				found = true;
+				off = addr - idlist_addr;
+				if (off < 0 || off + sizeof(*pair) > idlist->d_size) {
+					fprintf(stderr, "%s: kfunc '%s' offset outside section '%s'\n",
+						__func__, func, BTF_IDS_SECTION);
+					free(func);
+					goto out;
+				}
+				pair = idlist->d_buf + off;
 				break;
 			}
 		}
@@ -1712,7 +1739,7 @@ static int btf_encoder__tag_kfuncs(struct btf_encoder *encoder)
 			continue;
 		}
 
-		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func);
+		err = btf_encoder__tag_kfunc(encoder, &btf_funcs, func, pair->flags);
 		if (err) {
 			fprintf(stderr, "%s: failed to tag kfunc '%s'\n", __func__, func);
 			free(func);
-- 
2.46.0



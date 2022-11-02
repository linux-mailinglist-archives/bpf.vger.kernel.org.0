Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F5F9616EAF
	for <lists+bpf@lfdr.de>; Wed,  2 Nov 2022 21:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbiKBU2H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Nov 2022 16:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiKBU1w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Nov 2022 16:27:52 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A0821017
        for <bpf@vger.kernel.org>; Wed,  2 Nov 2022 13:27:48 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id q1-20020a17090a750100b002139ec1e999so2947773pjk.1
        for <bpf@vger.kernel.org>; Wed, 02 Nov 2022 13:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLH52kAHUJSGlMxD7rhzi1VBwt45mz63X43iTORvNqI=;
        b=TT00Ah8dfcUlJIyPKpw92qZJ7HP4PZ1VSk2GZY0Ax7bZEuiocVUtecljDtS0kb+0o5
         QP8OsW/r6z6cDTD22BPNMGkanffpQ+6vTY/fiiJbEb0YhEWdcWiyfMWZkOAJ1SsiZ3gH
         UudrWwxgNUr5ObQvg/zSROC2L+vWNN9CYPUthJJk0djok/DFbFY+BGmxmEkF3nwxFliI
         xIi/DuSs6mUTuO6PyB5H1A6V+Smd+85uIw7LaceYyPSNUzVmSBEDy+L0ZekO7cDrck1D
         VPtoNwi/eVEbWwsjRdagN1Uvhpvv/4DG/JRSdPS7gXWgOs5UG0g0LPbAxQNlk5DZpygU
         23zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLH52kAHUJSGlMxD7rhzi1VBwt45mz63X43iTORvNqI=;
        b=su2yrIHqVJz3veGp0syPBV+HekYL/IrqV132jjoRnrzos6dKNTfyZwNK9JgzOV9f43
         tijEvc8QuqVP/C5APg9rfBePvP/XddV3RolgX2j4B2Ki+1allfkBdDFri/9UFbH2psvu
         DjSXS1cEuX78hQUSwySSI7iw4oX9tBgvV84jSdzQC3kyLw4RP+2K5PpA3yZfb039NtzR
         pRp5PACaineJ3izT2WLuO4puMw1svF/z5eUKufnPePVqDDo8LF8tvvEv0M5mrvFzSHRi
         aG0xsRrPTks7QaOi/07hgU4tqd3JgkFF+8Ns/qD4yZmwZgq5f6SDwgfsj8b5RT6f/X87
         yWtw==
X-Gm-Message-State: ACrzQf33S2eq+9vMQTHGFQuVe9El/ELxYPHow7QhqWfBYO4nRLKQFzZm
        RUi1PkSn9NgXjYOGH4AlauJ48NswkH5TPA==
X-Google-Smtp-Source: AMsMyM4lzMdvzNQyK62pr9i5q24WIGqu/bHayI0osK852Jj4rc5d0ZVVzlLPQlscSz6LRPszoLBfTg==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr45634618pjb.164.1667420867510;
        Wed, 02 Nov 2022 13:27:47 -0700 (PDT)
Received: from localhost ([59.152.80.69])
        by smtp.gmail.com with ESMTPSA id a19-20020aa79713000000b0056bc1a41209sm8850869pfg.33.2022.11.02.13.27.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:27:47 -0700 (PDT)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v3 12/24] bpf: Verify ownership relationships for user BTF types
Date:   Thu,  3 Nov 2022 01:56:46 +0530
Message-Id: <20221102202658.963008-13-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221102202658.963008-1-memxor@gmail.com>
References: <20221102202658.963008-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5499; i=memxor@gmail.com; h=from:subject; bh=biQdkx9lpxV5rZMH5zF2DwM5c6T0YKQGoYk07bWNtrQ=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjYtIDuf1eowW4Snh6wLDtsA6OtP+wPTJUVTCXkzeL afvwAhaJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2LSAwAKCRBM4MiGSL8RyrzDEA C5/0E000+IWmZotEhm9OSsJ4ot1NeFq+FNNq92i3OA/Rr23zjF4QW8o0KEBigEKozqYAHFWu2L62SO +qNt9RUp1hrP4ajuwLIjyH5Enotg4rm1L9bw3dSwXGnF8/NxNtSZk76mKmJLCeMWTh9+ZRJ4CXnA1C 2d3+3BiQma6VnZuh9v+T/evA8bygNW2OhImDLl86YdxxiGtCIYMogFOcv4eMycHxhi99w0xTlrMUSj 8PtTX4+1+eITGdKFqDZdLY6aHQ4lt3hD9eBircrllm+6060BjFoK9gOCuc9iI1c4AUm8zC8zJk6JgQ haRutFPP47E6YV8b3VZasPmHnR41G55edR2rcCZwLZMpssvhs8thVB5djAcL9weIml2LTBuOhR/ShB +4IxbHvzpi+cF7xwaEx2mj1E3oUHFn0OIxZ1Es/pSC8v5gtSA/oJhCE5QM9J1ElTIbXChXOoSEumBy svhmmemVnvJ9nadPuyamLIIhX7/YuX6kpAHsjyA68FiI8J+dbHXOsLTxOhcclluOU5VlREmjR5+hjF wSf0Ybu3uS8upFmzw8p/gzTR+WCH/PL24TX+TFwLabB/axVzg0y2UbRWeBapmvj95zHbS+66zfI+Kn IaiKyhWp2/94ksl5YQPMXksgqQpKLz6uJ+3t9OFL02RYs+7XxrvEd8AowyQg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Ensure that there can be no ownership cycles among different types by
way of having owning objects that can hold some other type as their
element. For instance, a map value can only hold local kptrs, but these
are allowed to have another bpf_list_head. To prevent unbounded
recursion while freeing resources, elements of bpf_list_head in local
kptrs can never have a bpf_list_head which are part of list in a map
value.

Also, to make runtime destruction easier, once btf_struct_metas is fully
populated, we can stash the metadata of the value type directly in the
metadata of the list_head fields, as that allows easier access to the
value type's layout to destruct it at runtime from the btf_field entry
of the list head itself.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/linux/bpf.h  |  1 +
 include/linux/btf.h  |  1 +
 kernel/bpf/btf.c     | 71 ++++++++++++++++++++++++++++++++++++++++++++
 kernel/bpf/syscall.c |  4 +++
 4 files changed, 77 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index ba7781b8922e..489f73f19307 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -190,6 +190,7 @@ struct btf_field_list_head {
 	struct btf *btf;
 	u32 value_btf_id;
 	u32 node_offset;
+	struct btf_record *value_rec;
 };
 
 struct btf_field {
diff --git a/include/linux/btf.h b/include/linux/btf.h
index a01a8da20021..42d8f3730a8d 100644
--- a/include/linux/btf.h
+++ b/include/linux/btf.h
@@ -178,6 +178,7 @@ int btf_find_spin_lock(const struct btf *btf, const struct btf_type *t);
 int btf_find_timer(const struct btf *btf, const struct btf_type *t);
 struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type *t,
 				    u32 field_mask, u32 value_size);
+int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec);
 struct btf_field_offs *btf_parse_field_offs(struct btf_record *rec);
 bool btf_type_is_void(const struct btf_type *t);
 s32 btf_find_by_name_kind(const struct btf *btf, const char *name, u8 kind);
diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index bd78fc67a922..f0d2caf7f2f1 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3722,6 +3722,67 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	return ERR_PTR(ret);
 }
 
+int btf_check_and_fixup_fields(const struct btf *btf, struct btf_record *rec)
+{
+	int i;
+
+	/* There are two owning types, kptr_ref and bpf_list_head. The former
+	 * only supports storing kernel types, which can never store references
+	 * to program allocated local types, atleast not yet. Hence we only need
+	 * to ensure that bpf_list_head ownership does not form cycles.
+	 */
+	if (IS_ERR_OR_NULL(rec) || !(rec->field_mask & BPF_LIST_HEAD))
+		return 0;
+	for (i = 0; i < rec->cnt; i++) {
+		struct btf_struct_meta *meta;
+		u32 btf_id;
+
+		if (!(rec->fields[i].type & BPF_LIST_HEAD))
+			continue;
+		btf_id = rec->fields[i].list_head.value_btf_id;
+		meta = btf_find_struct_meta(btf, btf_id);
+		if (!meta)
+			return -EFAULT;
+		rec->fields[i].list_head.value_rec = meta->record;
+
+		if (!(rec->field_mask & BPF_LIST_NODE))
+			continue;
+
+		/* We need to ensure ownership acyclicity among all types. The
+		 * proper way to do it would be to topologically sort all BTF
+		 * IDs based on the ownership edges, since there can be multiple
+		 * bpf_list_head in a type. Instead, we use the following
+		 * reasoning:
+		 *
+		 * - A type can only be owned by another type in user BTF if it
+		 *   has a bpf_list_node.
+		 * - A type can only _own_ another type in user BTF if it has a
+		 *   bpf_list_head.
+		 *
+		 * We ensure that if a type has both bpf_list_head and
+		 * bpf_list_node, its element types cannot be owning types.
+		 *
+		 * To ensure acyclicity:
+		 *
+		 * When A only has bpf_list_head, ownership chain can be:
+		 *	A -> B -> C
+		 * Where:
+		 * - B has both bpf_list_head and bpf_list_node.
+		 * - C only has bpf_list_node.
+		 *
+		 * When A has both bpf_list_head and bpf_list_node, some other
+		 * type already owns it in the BTF domain, hence it can not own
+		 * another owning type through any of the bpf_list_head edges.
+		 *	A -> B
+		 * Where:
+		 * - B only has bpf_list_node.
+		 */
+		if (meta->record->field_mask & BPF_LIST_HEAD)
+			return -ELOOP;
+	}
+	return 0;
+}
+
 static int btf_field_offs_cmp(const void *_a, const void *_b, const void *priv)
 {
 	const u32 a = *(const u32 *)_a;
@@ -5406,6 +5467,16 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
 	}
 	btf->struct_meta_tab = struct_meta_tab;
 
+	if (struct_meta_tab) {
+		int i;
+
+		for (i = 0; i < struct_meta_tab->cnt; i++) {
+			err = btf_check_and_fixup_fields(btf, struct_meta_tab->types[i].record);
+			if (err < 0)
+				goto errout_meta;
+		}
+	}
+
 	if (log->level && bpf_verifier_log_full(log)) {
 		err = -ENOSPC;
 		goto errout_meta;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c96039a4e57f..4669020bb47d 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -1044,6 +1044,10 @@ static int map_check_btf(struct bpf_map *map, const struct btf *btf,
 		}
 	}
 
+	ret = btf_check_and_fixup_fields(btf, map->record);
+	if (ret < 0)
+		goto free_map_tab;
+
 	if (map->ops->map_check_btf) {
 		ret = map->ops->map_check_btf(map, btf, key_type, value_type);
 		if (ret < 0)
-- 
2.38.1


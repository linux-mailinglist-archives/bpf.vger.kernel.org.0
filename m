Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A92E162035D
	for <lists+bpf@lfdr.de>; Tue,  8 Nov 2022 00:10:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbiKGXK0 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Nov 2022 18:10:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232448AbiKGXKZ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Nov 2022 18:10:25 -0500
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01651FCD6
        for <bpf@vger.kernel.org>; Mon,  7 Nov 2022 15:10:23 -0800 (PST)
Received: by mail-pf1-x441.google.com with SMTP id 130so12199086pfu.8
        for <bpf@vger.kernel.org>; Mon, 07 Nov 2022 15:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rhA06fQZ2maF9obKz7l2Sp1w6d7RA8pXSzWK85L2jyU=;
        b=QHGMYFjzwmEXWDVZenwE6xV/M/K0Ia7iFZ7ESbsfqOK6dys0IsF6duGwz8j7BpwFdb
         xWNzYkWeeTjjR09/0gQsIT+gJJLdZsDmoxJOlv+AC3B0GuW8Ls9yFy2dhylWUOa2ASVA
         LjTSkIKxy08/eo94UmZg33gRIFPPYHusOdzlFP0omhWdAFdlwxxlnC30L0NXEymq7cyh
         qx1MFp1Vflm2FWwf34Cs7bCZYGACFHirEhHWk/+8ADSWFWbPENCARsGlfmjqKg3QbkKL
         donisfv63b3HBhFA/YQqpO2roi/axPOQPnJbPhcUa5aKGhK/L4Vst47UurQLnVxM9CZu
         tIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rhA06fQZ2maF9obKz7l2Sp1w6d7RA8pXSzWK85L2jyU=;
        b=LhDHfg2g7rKYSdiQ//PKgDfpgxIfQT4/DKhV6+gRG5OQI6y2aqGlyQOsNXxSP+Fw7v
         KI61h3EXNbQyIngtOrewI9+HD1oMYN+4LhwR3ugcDNeYLschKWia9eLAjHbK9qjOrtn+
         t+fqQMI/QolktD9/vKeVrBhaEE39ufl+rHYNBqyvsGWEDNHwU84OoQjj4LOxHjir7FXs
         GANYvlCUBNLX1ywWMq40n/08QtYSY+tsudlLR2RjC91HixeR6S1W8h1ZiO7F8gEpMss/
         +MsfOTaa8Y8qKFQClRSKtFiZ8apNpZs98vCb/YnBkWIsuDljps7CPsiS0CK6JV/3njay
         OfYg==
X-Gm-Message-State: ACrzQf1CwQ2IvA5kvpKcWRs8NcqlLc3c/ryu1ssMFguE50c6QygJ+NG6
        y0TnJb+JN50ON2J1DVsbdjCcT6zrNHdd5w==
X-Google-Smtp-Source: AMsMyM43P9h+kn2wkFYqwdr9GQl3GPUEWXiL7VouQ+L70gpFg3vPwyNtPToMpzzSonYWo7hd+o+Urg==
X-Received: by 2002:a63:dd16:0:b0:46f:9c0b:7f82 with SMTP id t22-20020a63dd16000000b0046f9c0b7f82mr40185810pgg.161.1667862622968;
        Mon, 07 Nov 2022 15:10:22 -0800 (PST)
Received: from localhost ([14.96.13.220])
        by smtp.gmail.com with ESMTPSA id f7-20020a170902ce8700b0018691ce1696sm5532564plg.131.2022.11.07.15.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 15:10:22 -0800 (PST)
From:   Kumar Kartikeya Dwivedi <memxor@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Dave Marchevsky <davemarchevsky@meta.com>,
        Delyan Kratunov <delyank@meta.com>
Subject: [PATCH bpf-next v5 08/25] bpf: Verify ownership relationships for user BTF types
Date:   Tue,  8 Nov 2022 04:39:33 +0530
Message-Id: <20221107230950.7117-9-memxor@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221107230950.7117-1-memxor@gmail.com>
References: <20221107230950.7117-1-memxor@gmail.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5565; i=memxor@gmail.com; h=from:subject; bh=dbxNcx/sah2xoNQU8s4VBd7QRq4f8gXikWmJQ28jzUY=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBjaY+24y7s5OT1ntUl2PXNooZ2kqLUPBbzeUAc6Lkh x+6Q19uJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCY2mPtgAKCRBM4MiGSL8RytW/D/ 99RP7Dit8WDiTaWhaGOmos1rAdxrXm1TAeduRVHzlbFdKW/crNcffKTmgAvi6RTwlJ0rUyANCe4OhQ L37UCinnkjLIjjFu91p8750n/2/ZorPVPpH59hRpM3Xbc9STxjbaDXFA7hoyaRG4pKrl1s5lEMONO2 GOklBPDv1mqaSjGw4gNSNrYAtjdypUBvbDyu1F19tnImQUqiawPS0rDeieqbfQKcSJPGxi61pLyIve uFtNa3Ujr17x69JQK0K9HAlwES8s1PGH0L4xJOipwjsSLRZkAxhtlGBAit9RBcQ8o9oXDWEvaXvqbp 0dSkMjn2hQX6iTdv7q+lUzljA3cHfQQ/Vuq0mRzJXh7oD8kK6z7Cx1td21mIITzRZir6U9IOxRtD3f jVLxVZiB1w/iEzcxqABJW7lkloCkqCEfAK48WRa6YKWZqdABexTEO9WtgErcQvTzeYGruaqpWRyPe8 vlrlpLQhVgPFhkF8ULCcsDs2MUISl2UsagJNpmWoED5TqOQvlv+RNqOMVgZTVnmRnCYuMOWM4XfBAh 0YWwSwvGjqLnuZC+gdEXf0etzW26gwzX1kNduClOmnC7smqW1ynRHxbPlAMsiMl9fnnn46ZnDoD0IY kmZMMUvEOgGG9GslBLZ4aA8OpPJ59wqzcE4vXfLj9QsPNQKltLBFPgE+3Fmw==
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
value. Later patches will verify this by having dedicated BTF selftests.

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
index dfcd34e36025..88ac4c12bab0 100644
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
index 5e3cffe4bc37..685a6998432b 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3721,6 +3721,67 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
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
@@ -5410,6 +5471,16 @@ static struct btf *btf_parse(bpfptr_t btf_data, u32 btf_data_size,
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


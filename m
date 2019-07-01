Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0FD15C11E
	for <lists+bpf@lfdr.de>; Mon,  1 Jul 2019 18:31:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728453AbfGAQbJ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 1 Jul 2019 12:31:09 -0400
Received: from mail-pl1-f201.google.com ([209.85.214.201]:39362 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726840AbfGAQbJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 1 Jul 2019 12:31:09 -0400
Received: by mail-pl1-f201.google.com with SMTP id r7so7556267plo.6
        for <bpf@vger.kernel.org>; Mon, 01 Jul 2019 09:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=RrgNUEkDrGeg2elyfbN93BGpRenDb5SclUREHfyGkOk=;
        b=qPbJ4W83vlHi8ZvryKPlkEaV5gIizAzXVNMIDBw1dcloJMUl7Iga98VDCQxGiDsO4U
         vJlHok/BCRCYZwgnBN+8R0Gt6Gnnw70EWt4caou+nwU8OT5P6kMClxEZnwNZdsHkoM84
         yo1RLTsR0jS5fBNceUqnqModT352JE3BC5znNuMfz2K8SNjopCsMcAxjR7RpX3cxgIFf
         7CkfGRDKNN7w+TlZSbHCe9JKZCO72nSbjEImxoNLyiU0w8hFwlQ7x7ahBbXzn2ozkYhv
         ZFXAVPrLgLS3WCG/cvrcsTqlMCTOxfxOn5F6VWbTxWKMMXPiqCPhK4dozQGplj0iZQwY
         P/vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=RrgNUEkDrGeg2elyfbN93BGpRenDb5SclUREHfyGkOk=;
        b=CpP58+MGSavWEh+sazpY0WmxVijLL4mHHtup5H7hYHklQkGMNaMktmm0hee21HZoLp
         5SQk8lRTscWEaruqz6aHvqIJxvoLAIP5z83YV8p5b1GLqqxJMxMBS71/UYeHsg3o5KJn
         fLCtQKP5pR81rXmJR1w9aExpTieyBXUc72TWnlIyVr0eZtXUn198UdFVCvfFsARG82zw
         Bcjd/76nnMlSFv0TeHZqgBvG0vJ541DPTugt4m9ky6meeg0XXXD9vHD5aZ6XuI7bH8WI
         aLfCBHERCtgQTiqIAD4hqyUuz5roABKf7qBSs4FnrYj5zizdq8GiCKkf3V9mf6uYyvwV
         pHlw==
X-Gm-Message-State: APjAAAX6cuXn5XytS+o2DnsoOTKYjOoggUHPner0Xpq6YeL1vbcHmfJ3
        +W334SL6zfE4QM9tWr76VIM3GVU=
X-Google-Smtp-Source: APXvYqy7lwsM4FjFX4Ti8GdP3wpKVehG8OTkzRPbvMOdSNxFQFMMkfz0dsMy0ZWAZsm1yQKi0/znkbc=
X-Received: by 2002:a63:ea0a:: with SMTP id c10mr26554590pgi.426.1561998667762;
 Mon, 01 Jul 2019 09:31:07 -0700 (PDT)
Date:   Mon,  1 Jul 2019 09:31:01 -0700
In-Reply-To: <20190701163103.237550-1-sdf@google.com>
Message-Id: <20190701163103.237550-2-sdf@google.com>
Mime-Version: 1.0
References: <20190701163103.237550-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [PATCH bpf-next v2 1/3] bpf: allow wide (u64) aligned stores for some
 fields of bpf_sock_addr
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Andrii Nakryiko <andriin@fb.com>, Yonghong Song <yhs@fb.com>,
        kernel test robot <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Since commit cd17d7770578 ("bpf/tools: sync bpf.h") clang decided
that it can do a single u64 store into user_ip6[2] instead of two
separate u32 ones:

 #  17: (18) r2 = 0x100000000000000
 #  ; ctx->user_ip6[2] = bpf_htonl(DST_REWRITE_IP6_2);
 #  19: (7b) *(u64 *)(r1 +16) = r2
 #  invalid bpf_context access off=16 size=8

From the compiler point of view it does look like a correct thing
to do, so let's support it on the kernel side.

Credit to Andrii Nakryiko for a proper implementation of
bpf_ctx_wide_store_ok.

Cc: Andrii Nakryiko <andriin@fb.com>
Cc: Yonghong Song <yhs@fb.com>
Fixes: cd17d7770578 ("bpf/tools: sync bpf.h")
Reported-by: kernel test robot <rong.a.chen@intel.com>
Acked-by: Yonghong Song <yhs@fb.com>
Acked-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 include/linux/filter.h   |  6 ++++++
 include/uapi/linux/bpf.h |  4 ++--
 net/core/filter.c        | 22 ++++++++++++++--------
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 340f7d648974..3901007e36f1 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -746,6 +746,12 @@ bpf_ctx_narrow_access_ok(u32 off, u32 size, u32 size_default)
 	return size <= size_default && (size & (size - 1)) == 0;
 }
 
+#define bpf_ctx_wide_store_ok(off, size, type, field)			\
+	(size == sizeof(__u64) &&					\
+	off >= offsetof(type, field) &&					\
+	off + sizeof(__u64) <= offsetofend(type, field) &&		\
+	off % sizeof(__u64) == 0)
+
 #define bpf_classic_proglen(fprog) (fprog->len * sizeof(fprog->filter[0]))
 
 static inline void bpf_prog_lock_ro(struct bpf_prog *fp)
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a396b516a2b2..586867fe6102 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3237,7 +3237,7 @@ struct bpf_sock_addr {
 	__u32 user_ip4;		/* Allows 1,2,4-byte read and 4-byte write.
 				 * Stored in network byte order.
 				 */
-	__u32 user_ip6[4];	/* Allows 1,2,4-byte read an 4-byte write.
+	__u32 user_ip6[4];	/* Allows 1,2,4-byte read an 4,8-byte write.
 				 * Stored in network byte order.
 				 */
 	__u32 user_port;	/* Allows 4-byte read and write.
@@ -3249,7 +3249,7 @@ struct bpf_sock_addr {
 	__u32 msg_src_ip4;	/* Allows 1,2,4-byte read an 4-byte write.
 				 * Stored in network byte order.
 				 */
-	__u32 msg_src_ip6[4];	/* Allows 1,2,4-byte read an 4-byte write.
+	__u32 msg_src_ip6[4];	/* Allows 1,2,4-byte read an 4,8-byte write.
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
diff --git a/net/core/filter.c b/net/core/filter.c
index dc8534be12fc..5d33f2146dab 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -6849,6 +6849,16 @@ static bool sock_addr_is_valid_access(int off, int size,
 			if (!bpf_ctx_narrow_access_ok(off, size, size_default))
 				return false;
 		} else {
+			if (bpf_ctx_wide_store_ok(off, size,
+						  struct bpf_sock_addr,
+						  user_ip6))
+				return true;
+
+			if (bpf_ctx_wide_store_ok(off, size,
+						  struct bpf_sock_addr,
+						  msg_src_ip6))
+				return true;
+
 			if (size != size_default)
 				return false;
 		}
@@ -7689,9 +7699,6 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
 /* SOCK_ADDR_STORE_NESTED_FIELD_OFF() has semantic similar to
  * SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF() but for store operation.
  *
- * It doesn't support SIZE argument though since narrow stores are not
- * supported for now.
- *
  * In addition it uses Temporary Field TF (member of struct S) as the 3rd
  * "register" since two registers available in convert_ctx_access are not
  * enough: we can't override neither SRC, since it contains value to store, nor
@@ -7699,7 +7706,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
  * instructions. But we need a temporary place to save pointer to nested
  * structure whose field we want to store to.
  */
-#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OFF, TF)		       \
+#define SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SIZE, OFF, TF)	       \
 	do {								       \
 		int tmp_reg = BPF_REG_9;				       \
 		if (si->src_reg == tmp_reg || si->dst_reg == tmp_reg)	       \
@@ -7710,8 +7717,7 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
 				      offsetof(S, TF));			       \
 		*insn++ = BPF_LDX_MEM(BPF_FIELD_SIZEOF(S, F), tmp_reg,	       \
 				      si->dst_reg, offsetof(S, F));	       \
-		*insn++ = BPF_STX_MEM(					       \
-			BPF_FIELD_SIZEOF(NS, NF), tmp_reg, si->src_reg,	       \
+		*insn++ = BPF_STX_MEM(SIZE, tmp_reg, si->src_reg,	       \
 			bpf_target_off(NS, NF, FIELD_SIZEOF(NS, NF),	       \
 				       target_size)			       \
 				+ OFF);					       \
@@ -7723,8 +7729,8 @@ static u32 xdp_convert_ctx_access(enum bpf_access_type type,
 						      TF)		       \
 	do {								       \
 		if (type == BPF_WRITE) {				       \
-			SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, OFF,    \
-							 TF);		       \
+			SOCK_ADDR_STORE_NESTED_FIELD_OFF(S, NS, F, NF, SIZE,   \
+							 OFF, TF);	       \
 		} else {						       \
 			SOCK_ADDR_LOAD_NESTED_FIELD_SIZE_OFF(		       \
 				S, NS, F, NF, SIZE, OFF);  \
-- 
2.22.0.410.gd8fdbe21b5-goog


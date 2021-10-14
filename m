Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5115A42DBC4
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231134AbhJNOhC (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231161AbhJNOhC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:37:02 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C27C061755
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:34:57 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id o20so20241336wro.3
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=NTV4GrMZbQTMVi4ELZg/UB6lBvL9dvLiF7pLXEVrNQA=;
        b=uKa32hFQaL188b8LnVZh9L2Tl0wBeyCn2bG1gV/rEODifI+2BZjiJKVsrmRvZ6z8ZF
         J2bdp9BzBgfX1FsXP2R3VSiqv96uzdXrBvsS7BbsTkvuL85sEWPUTmY2PZRLOk1fom3y
         Xc7eyuDrl+xgEfT90Z8GlQP2MKzcsboVENae4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NTV4GrMZbQTMVi4ELZg/UB6lBvL9dvLiF7pLXEVrNQA=;
        b=WgfGz2QyQjqucBrb/2hw0C0yVjcsGAe/VWkDK4FtBOVdrivg+yJ4JFMzFQbfu+eSNh
         dc4Q6fqyV0Vds6qxrnU/qzwSz08ucw3qhkMOxNCCvHzZyc3Mz6n1nSe6aBV1//d5oltm
         7fdE2Lg5Z+If7JR0lwSdgW7+WiRiSPBGJEjPM/7PCqfsg8HE6ZInaFIsmRQj5ct8CTLN
         OdLXveTs+D9qxHLxCD+TU9fLbW2Du3HfuRj329uNLs2hNgtSNyEkBmBuirq7aI5ziUJM
         VTXemH8FXwnr/94WYPbObcM5xUfHpAA+yqNWHx05TLmXzPyGePXnmboi88q80oRiKuyR
         24Jg==
X-Gm-Message-State: AOAM532tO3ifNMy5sFvfEMTM11fStrgso0TTG5mLs2u6jPrx2LEdxMPE
        FqkZfMuszOidpwxPAK2IuF6F+w==
X-Google-Smtp-Source: ABdhPJzIY3nj4/W/Q0gHrO8qV16gYaDLnYb+kAvaUISazEVX7XFyHDyEfXOkd3uoAgW7qbMXSYnbWA==
X-Received: by 2002:adf:ab46:: with SMTP id r6mr7046542wrc.71.1634222095281;
        Thu, 14 Oct 2021 07:34:55 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id k6sm2656439wri.83.2021.10.14.07.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:34:55 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [RFC 1/9] bpf: name enums used from userspace
Date:   Thu, 14 Oct 2021 15:34:25 +0100
Message-Id: <20211014143436.54470-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014143436.54470-1-lmb@cloudflare.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 include/uapi/linux/bpf.h | 58 +++++++++++++++++++++++-----------------
 1 file changed, 33 insertions(+), 25 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 6fc59d61937a..78b532d28761 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -50,7 +50,7 @@
 #define BPF_CMPXCHG	(0xf0 | BPF_FETCH)	/* atomic compare-and-write */
 
 /* Register numbers */
-enum {
+enum bpf_reg {
 	BPF_REG_0 = 0,
 	BPF_REG_1,
 	BPF_REG_2,
@@ -1056,16 +1056,19 @@ enum bpf_link_type {
  * All eligible programs are executed regardless of return code from
  * earlier programs.
  */
-#define BPF_F_ALLOW_OVERRIDE	(1U << 0)
-#define BPF_F_ALLOW_MULTI	(1U << 1)
-#define BPF_F_REPLACE		(1U << 2)
+enum bpf_prog_attach_flag {
+	BPF_F_ALLOW_OVERRIDE	= (1U << 0),
+	BPF_F_ALLOW_MULTI	= (1U << 1),
+	BPF_F_REPLACE		= (1U << 2),
+};
 
+enum bpf_prog_load_flag {
 /* If BPF_F_STRICT_ALIGNMENT is used in BPF_PROG_LOAD command, the
  * verifier will perform strict alignment checking as if the kernel
  * has been built with CONFIG_EFFICIENT_UNALIGNED_ACCESS not set,
  * and NET_IP_ALIGN defined to 2.
  */
-#define BPF_F_STRICT_ALIGNMENT	(1U << 0)
+	BPF_F_STRICT_ALIGNMENT = (1U << 0),
 
 /* If BPF_F_ANY_ALIGNMENT is used in BPF_PROF_LOAD command, the
  * verifier will allow any alignment whatsoever.  On platforms
@@ -1079,7 +1082,7 @@ enum bpf_link_type {
  * of an unaligned access the alignment check would trigger before
  * the one we are interested in.
  */
-#define BPF_F_ANY_ALIGNMENT	(1U << 1)
+	BPF_F_ANY_ALIGNMENT = (1U << 1),
 
 /* BPF_F_TEST_RND_HI32 is used in BPF_PROG_LOAD command for testing purpose.
  * Verifier does sub-register def/use analysis and identifies instructions whose
@@ -1097,10 +1100,10 @@ enum bpf_link_type {
  * Then, if verifier is not doing correct analysis, such randomization will
  * regress tests to expose bugs.
  */
-#define BPF_F_TEST_RND_HI32	(1U << 2)
+	BPF_F_TEST_RND_HI32 = (1U << 2),
 
 /* The verifier internal test flag. Behavior is undefined */
-#define BPF_F_TEST_STATE_FREQ	(1U << 3)
+	BPF_F_TEST_STATE_FREQ = (1U << 3),
 
 /* If BPF_F_SLEEPABLE is used in BPF_PROG_LOAD command, the verifier will
  * restrict map and helper usage for such programs. Sleepable BPF programs can
@@ -1108,8 +1111,10 @@ enum bpf_link_type {
  * Such programs are allowed to use helpers that may sleep like
  * bpf_copy_from_user().
  */
-#define BPF_F_SLEEPABLE		(1U << 4)
+	BPF_F_SLEEPABLE = (1U << 4),
+};
 
+enum bpf_pseudo_src_reg {
 /* When BPF ldimm64's insn[0].src_reg != 0 then this can have
  * the following extensions:
  *
@@ -1121,8 +1126,8 @@ enum bpf_link_type {
  * ldimm64 rewrite:  address of map
  * verifier type:    CONST_PTR_TO_MAP
  */
-#define BPF_PSEUDO_MAP_FD	1
-#define BPF_PSEUDO_MAP_IDX	5
+	BPF_PSEUDO_MAP_FD  = 1,
+	BPF_PSEUDO_MAP_IDX = 5,
 
 /* insn[0].src_reg:  BPF_PSEUDO_MAP_[IDX_]VALUE
  * insn[0].imm:      map fd or fd_idx
@@ -1132,8 +1137,8 @@ enum bpf_link_type {
  * ldimm64 rewrite:  address of map[0]+offset
  * verifier type:    PTR_TO_MAP_VALUE
  */
-#define BPF_PSEUDO_MAP_VALUE		2
-#define BPF_PSEUDO_MAP_IDX_VALUE	6
+	BPF_PSEUDO_MAP_VALUE     = 2,
+	BPF_PSEUDO_MAP_IDX_VALUE = 6,
 
 /* insn[0].src_reg:  BPF_PSEUDO_BTF_ID
  * insn[0].imm:      kernel btd id of VAR
@@ -1144,7 +1149,7 @@ enum bpf_link_type {
  * verifier type:    PTR_TO_BTF_ID or PTR_TO_MEM, depending on whether the var
  *                   is struct/union.
  */
-#define BPF_PSEUDO_BTF_ID	3
+	BPF_PSEUDO_BTF_ID = 3,
 /* insn[0].src_reg:  BPF_PSEUDO_FUNC
  * insn[0].imm:      insn offset to the func
  * insn[1].imm:      0
@@ -1153,19 +1158,20 @@ enum bpf_link_type {
  * ldimm64 rewrite:  address of the function
  * verifier type:    PTR_TO_FUNC.
  */
-#define BPF_PSEUDO_FUNC		4
+	BPF_PSEUDO_FUNC = 4,
 
 /* when bpf_call->src_reg == BPF_PSEUDO_CALL, bpf_call->imm == pc-relative
  * offset to another bpf function
  */
-#define BPF_PSEUDO_CALL		1
+	BPF_PSEUDO_CALL = 1,
 /* when bpf_call->src_reg == BPF_PSEUDO_KFUNC_CALL,
  * bpf_call->imm == btf_id of a BTF_KIND_FUNC in the running kernel
  */
-#define BPF_PSEUDO_KFUNC_CALL	2
+	BPF_PSEUDO_KFUNC_CALL = 2,
+};
 
 /* flags for BPF_MAP_UPDATE_ELEM command */
-enum {
+enum bpf_map_update_elem_flag {
 	BPF_ANY		= 0, /* create new element or update existing */
 	BPF_NOEXIST	= 1, /* create new element if it didn't exist */
 	BPF_EXIST	= 2, /* update existing element */
@@ -1173,7 +1179,7 @@ enum {
 };
 
 /* flags for BPF_MAP_CREATE command */
-enum {
+enum bpf_map_create_flag {
 	BPF_F_NO_PREALLOC	= (1U << 0),
 /* Instead of having one common LRU list in the
  * BPF_MAP_TYPE_LRU_[PERCPU_]HASH map, use a percpu LRU list
@@ -1213,17 +1219,19 @@ enum {
 };
 
 /* Flags for BPF_PROG_QUERY. */
-
+enum bpf_prog_query_flag {
 /* Query effective (directly attached + inherited from ancestor cgroups)
  * programs that will be executed for events within a cgroup.
  * attach_flags with this flag are returned only for directly attached programs.
  */
-#define BPF_F_QUERY_EFFECTIVE	(1U << 0)
-
-/* Flags for BPF_PROG_TEST_RUN */
+	BPF_F_QUERY_EFFECTIVE = (1U << 0),
+};
 
+/* Flags for BPF_PROG_RUN */
+enum bpf_prog_run_flag {
 /* If set, run the test on the cpu specified by bpf_attr.test.cpu */
-#define BPF_F_TEST_RUN_ON_CPU	(1U << 0)
+	BPF_F_TEST_RUN_ON_CPU = (1U << 0),
+};
 
 /* type for BPF_ENABLE_STATS */
 enum bpf_stats_type {
@@ -5230,7 +5238,7 @@ enum {
 };
 
 /* BPF ring buffer constants */
-enum {
+enum bpf_ringbuf_const {
 	BPF_RINGBUF_BUSY_BIT		= (1U << 31),
 	BPF_RINGBUF_DISCARD_BIT		= (1U << 30),
 	BPF_RINGBUF_HDR_SZ		= 8,
-- 
2.30.2


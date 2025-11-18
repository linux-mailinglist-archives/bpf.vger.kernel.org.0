Return-Path: <bpf+bounces-74853-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CC099C67267
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 04:30:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8B1504E1FA4
	for <lists+bpf@lfdr.de>; Tue, 18 Nov 2025 03:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46169254AF5;
	Tue, 18 Nov 2025 03:30:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SCI1/r1/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A4D1805E
	for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 03:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763436639; cv=none; b=BwqOCBRQJMwUxxG3ayGFxgpAzwi4fIAnm0EqGf8UidEdUGEA42WAemsyJ0xjqL0HIBeFb1xQC77STgPbwmrYtV/ricN/1cx5ZeAcnVZyv8N58D8BPKsCtOtBhVSt2IIgqnSWRgGS0rd7L4O8mtp+szIIYczdZPomt4CD3hTE4Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763436639; c=relaxed/simple;
	bh=BE9zsbvHGFfp+7aYyid9mP7IxTpWTd0oLS1V3AxM4xc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Tm7Fyq6Cxo45pGrktKswkT1nak1rMg/E8bgQuqTGznUYqm3u1OMVykL/aOzp3PJ+dO9XqSqVLFhYJ6HSvwcSVO9oHt234Xib1TPile3HfHkyNIsZ+ZnBXTM9zXHba0tVNx8MRg1/u4Hlic6Y263k1roUrRmdVKBSfaxPpHjB9dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SCI1/r1/; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-3437c093ef5so5019023a91.0
        for <bpf@vger.kernel.org>; Mon, 17 Nov 2025 19:30:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763436637; x=1764041437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AIpio3BmxnaLKRtG46m9gb4TEer3dPT7GOk9htkcR9A=;
        b=SCI1/r1/+s/lZFLoFqbF9sRBLLS9sLVLDV5qEELTpQZe6hax5JXqpGkABuUnsCXH83
         txDm3jo3zjJ6jcHZ5ISqB3kjXh1XMFD42fMQ6Qdctvd4/vDFtrCxxXWY04vi101erKZt
         swBnpCcWesczc4Eeu7t7TXYw2EmZ6oT/0b/5fzHDAsLFvSG3LCf1HZapvrnmhirvM17I
         V855Rcj7dI1HnJf8g3AFPt9r/Av/Z3ZlcNzF5zadhXuaIDsMeZwbG12waupM+JYM3jTY
         SQZ+1OZJFIk0MX0LjvJKFdYxepDEyxb1pDoybLQ3onhMMi6qqY7PM9MgozEh8TB5z4YM
         pzkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763436637; x=1764041437;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AIpio3BmxnaLKRtG46m9gb4TEer3dPT7GOk9htkcR9A=;
        b=cWvsQwEjrnz5hIlG8iZXOYgCSrpzOKe3hSMqF36AWJ+RPxjFVq7/es/aLImW6bWrsS
         4yc/jLh59HUsJaFdPkwpFQjP6/dJ0iyJr6lvLs6Bg8QvpQrCWibOPJvQcC+qeT4q7ZgY
         OcBo86l9X38uEVi9lLkNosZEMxBhGLGa1qnYbSQ0MCFqxX5bnAzvAYANgHIPoFwh43Pt
         FSXzBqYhq9I/d7D4i+jlhF6zYdG0XrV0G881IKTGkAEzjk0l/Okxk0kgd1lCd3WM//JT
         LsxbhkNL2V+aCRRjAKqpHBAqRCOmgof+IUO5J2ZRSrZVIty6AxKf+jaVEz4RZlQc60QI
         QlNg==
X-Forwarded-Encrypted: i=1; AJvYcCW5heRS2qs9OeplaIwPsLwsICpHL8rFPvnNJjr7QKoswH5BbDYMnZrar4VVS5Re8VGpTxU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTYubiEEdpZIOriTvHqmP6E3BJwYLY3FFa36JbgvMQDWMucet3
	2g+AHoDkOnKxs+V8Mp8CxiSfA+3oCSiYfroubNXlKZxVlsVa87tkQDjwk3G1Bj7K
X-Gm-Gg: ASbGncuSlKiefr5DeShB5Pkcft38NchLQuf5AW38JhbY0afkolgrgAiioYtv4X1d5Ik
	h8RSGJxNrACZGH1Xn7Kp0tC1nqGWfHmVysBqq6LBQbP9QSkDnnTr9mTGDKvvO7+bFcvF+zBXvx9
	MnltGXfkFaheNi9gWf9fvZ+oGTaoDSsQMBkNfQzaUSYB19YrBWJDFCUtE3c1Q10v7rwQ9cl9IQu
	hfe0rUSqWoW3z4tMrHX0Pek8M5nNScJIEr8nerlQ0PpCfs1GBMO4SVSI0JBaGf1DzVrDXYejRFt
	VmxZLPMyWBeSdDwq1NUDf2D17MQ5pxlqsbjuL+Efg+lUaQf0mdPTtxtdXDEdqwjevz0hPIwfv61
	873SSY0ctZ98sl75VsSvCvyMRlPDNfgf2IRZEo40LHQoy9+SzO0Qq2ZBe3+EysbfHmtf5PC2y6K
	p5wVh8vIUkfyME8fyWf4Zk+QypHxIgW1vBaA==
X-Google-Smtp-Source: AGHT+IG+IgR1Db1XjCV8ThNxAgsCmbbRs2M3HCU1m2p26WBqCzV20SgGglln8zkiaE2/Jgyz3VELZg==
X-Received: by 2002:a17:90b:55c6:b0:335:2823:3683 with SMTP id 98e67ed59e1d1-343f9eadd5bmr14823336a91.9.1763436637031;
        Mon, 17 Nov 2025 19:30:37 -0800 (PST)
Received: from DESKTOP-P5RIK7I.localdomain ([103.52.189.22])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3456513e090sm11172110a91.6.2025.11.17.19.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 19:30:36 -0800 (PST)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [GENERAL] (Safe Dynamic Programs and Tools))
Subject: [PATCH] libbpf: fix some incorrect @param descriptions in the comment of libbpf.h
Date: Tue, 18 Nov 2025 11:30:24 +0800
Message-Id: <20251118033025.11804-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some incorrect @param descriptions in the comment of libbpf.h
file. The following is a case:

  /**
  * @brief **bpf_link__unpin()** unpins the BPF link from a file
  * in the BPFFS specified by a path. This decrements the links
  * reference count.
  *
  * The file pinning the BPF link can also be unlinked by a different
  * process in which case this function will return an error.
  *
  * @param prog BPF program to unpin
  * @param path file path to the pin in a BPF file system
  * @return 0, on success; negative error code, otherwise
  */
  LIBBPF_API int bpf_link__unpin(struct bpf_link *link);

In the parameters of the bpf_link__unpin() function, there are no 'prog'
and 'path' parameters.

This patch fixes this kind of issues present in the comments of the
libbpf.h file.

Signed-off-by: Jianyun Gao <jianyungao89@gmail.com>
---
 tools/lib/bpf/libbpf.h | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index 5118d0a90e24..8ca7957c8dd4 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -481,14 +481,12 @@ LIBBPF_API int bpf_link__pin(struct bpf_link *link, const char *path);
 
 /**
  * @brief **bpf_link__unpin()** unpins the BPF link from a file
- * in the BPFFS specified by a path. This decrements the links
- * reference count.
+ * in the BPFFS. This decrements the links reference count.
  *
  * The file pinning the BPF link can also be unlinked by a different
  * process in which case this function will return an error.
  *
- * @param prog BPF program to unpin
- * @param path file path to the pin in a BPF file system
+ * @param link BPF link to unpin
  * @return 0, on success; negative error code, otherwise
  */
 LIBBPF_API int bpf_link__unpin(struct bpf_link *link);
@@ -995,8 +993,13 @@ LIBBPF_API __u32 bpf_program__line_info_cnt(const struct bpf_program *prog);
  *   - fentry/fexit/fmod_ret;
  *   - lsm;
  *   - freplace.
- * @param prog BPF program to set the attach type for
- * @param type attach type to set the BPF map to have
+ * @param prog BPF program to configure; must be not yet loaded.
+ * @param attach_prog_fd FD of target BPF program (for freplace/extension).
+ * If >0 and func name omitted, defers BTF ID resolution.
+ * @param attach_func_name Target function name. Used either with
+ * attach_prog_fd to find its BTF ID in that program, or alone
+ * (no attach_prog_fd) to resolve kernel (vmlinux/module) BTF ID. Must be
+ * provided if attach_prog_fd is 0.
  * @return error code; or 0 if no error occurred.
  */
 LIBBPF_API int
@@ -1098,6 +1101,7 @@ LIBBPF_API __u32 bpf_map__value_size(const struct bpf_map *map);
 /**
  * @brief **bpf_map__set_value_size()** sets map value size.
  * @param map the BPF map instance
+ * @param size the new value size
  * @return 0, on success; negative error, otherwise
  *
  * There is a special case for maps with associated memory-mapped regions, like
@@ -1202,7 +1206,7 @@ LIBBPF_API struct bpf_map *bpf_map__inner_map(struct bpf_map *map);
  * per-CPU values value size has to be aligned up to closest 8 bytes for
  * alignment reasons, so expected size is: `round_up(value_size, 8)
  * * libbpf_num_possible_cpus()`.
- * @flags extra flags passed to kernel for this operation
+ * @param flags extra flags passed to kernel for this operation
  * @return 0, on success; negative error, otherwise
  *
  * **bpf_map__lookup_elem()** is high-level equivalent of
@@ -1226,7 +1230,7 @@ LIBBPF_API int bpf_map__lookup_elem(const struct bpf_map *map,
  * per-CPU values value size has to be aligned up to closest 8 bytes for
  * alignment reasons, so expected size is: `round_up(value_size, 8)
  * * libbpf_num_possible_cpus()`.
- * @flags extra flags passed to kernel for this operation
+ * @param flags extra flags passed to kernel for this operation
  * @return 0, on success; negative error, otherwise
  *
  * **bpf_map__update_elem()** is high-level equivalent of
@@ -1242,7 +1246,7 @@ LIBBPF_API int bpf_map__update_elem(const struct bpf_map *map,
  * @param map BPF map to delete element from
  * @param key pointer to memory containing bytes of the key
  * @param key_sz size in bytes of key data, needs to match BPF map definition's **key_size**
- * @flags extra flags passed to kernel for this operation
+ * @param flags extra flags passed to kernel for this operation
  * @return 0, on success; negative error, otherwise
  *
  * **bpf_map__delete_elem()** is high-level equivalent of
@@ -1265,7 +1269,7 @@ LIBBPF_API int bpf_map__delete_elem(const struct bpf_map *map,
  * per-CPU values value size has to be aligned up to closest 8 bytes for
  * alignment reasons, so expected size is: `round_up(value_size, 8)
  * * libbpf_num_possible_cpus()`.
- * @flags extra flags passed to kernel for this operation
+ * @param flags extra flags passed to kernel for this operation
  * @return 0, on success; negative error, otherwise
  *
  * **bpf_map__lookup_and_delete_elem()** is high-level equivalent of
@@ -1637,6 +1641,7 @@ struct perf_buffer_opts {
  * @param sample_cb function called on each received data record
  * @param lost_cb function called when record loss has occurred
  * @param ctx user-provided extra context passed into *sample_cb* and *lost_cb*
+ * @param opts optional parameters for the perf buffer, mainly *sample_period*
  * @return a new instance of struct perf_buffer on success, NULL on error with
  * *errno* containing an error code
  */
-- 
2.34.1



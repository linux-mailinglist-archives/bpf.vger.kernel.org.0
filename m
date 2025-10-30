Return-Path: <bpf+bounces-72980-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C427FC1EDBF
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 08:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 243411899B7F
	for <lists+bpf@lfdr.de>; Thu, 30 Oct 2025 07:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B49338900;
	Thu, 30 Oct 2025 07:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTGxVqYT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC84338598
	for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 07:52:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761810769; cv=none; b=MNigGy0XbhNgVLhszyWwU4v1QucpsB4dV3JTSbP4XplPz5fCJrG0VxIfUrCYAbeFoPxk2Ab7bpL9kADQVHTu3SKJAkS93YIPOxUAVyDtZQBirN1Qj2mHlRvwS3mWr7f3BNK0NWWZVPyAoR38/A3PWxiNS7baL2O/3fPJ3ynN79s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761810769; c=relaxed/simple;
	bh=jCnVFmhEiH0CWgQ9Wkjj1WRdWmTVSADaUfBtR70yHBo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NP1UuE2fbIpGoEic+DsAmlgknPCsXo9ITYcolXmnK0FM0grV6uLeykGxDqCG86QQ4/oyf023floerKjoNnRbm05YCNdc/lLFeC6gMc+a/7MBdACvTgf+vvbIbAvhxFRiyXbUNsgNOEZCMSbE3gsXLqJWDv/a2TCEZvCT0GLi13k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTGxVqYT; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-78125ed4052so1216150b3a.0
        for <bpf@vger.kernel.org>; Thu, 30 Oct 2025 00:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761810766; x=1762415566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=es//t3hYUc1h16tXpqwms9mTk2LcY28iDx1fAoGPlsk=;
        b=kTGxVqYTvFJ5shJnWM3q3sKxg8rOMk7IhvWXxMcHGytdLv80gwpeR5xzvkEKZTDDaS
         QB4c4KrCwB8hh8Oa0hPeZomuD3LFbcfA9m9d+ExQiaL0DieGJwxD1ftT5LqoFyQ3fRpd
         6z6GDuzN7703DXOLwJFrK+F70mTDHD6a20xSPxcVc1GUnYeShcC9V1sh1BhQ5azpmO0z
         hKV/wEZmEXsC0Xz6rAUNxqtBu84+3bv5ninz9tsTVV9PLA+hW97C8u8s4pPkol3olO58
         yi5q6fL3keE3oRLNp4ySrpaSymVy62vX+Gj27owQl+Xbi9MzDZ0oLQ/NSaeudZqvz2Gv
         UpEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761810766; x=1762415566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=es//t3hYUc1h16tXpqwms9mTk2LcY28iDx1fAoGPlsk=;
        b=SWjKdKGSn0gN7BdIgbxZ27tvX1l5bWz5E/ihXMGGGC4oo4yb7slFemiHfojK3YwIG1
         Y/vyFVl/Ej//3fruzZLa9yZQ1HinUnyPKsPRWT6l6awFOYNu17+y4RZh7TDBrXtI8IAk
         tY4JZc1V69w1bX1AKMJkZ/DwEXxfz+yPp3vY069akeoaNAIGrAxOzvCWu8HxFkLImh9G
         iiGcwS0CJ7F9wy5GZL0m5jelhoFu44fpUhCgh59FkXkEdz4xQIYuE7rVDTwvEBJ0DMO5
         O4k+bkqvzgxTwB3BfJ40epLJz+a79zrUQpYwuu4lP8NDoSbhvr4qS8p9DPNuuih390U/
         Su9A==
X-Forwarded-Encrypted: i=1; AJvYcCWm4wf1LIHjPNtPqeGvfFDTEp7ZUkT9ZUsiJj29Ia4lEvklaHJLiOt6f0g0IeZ3Reo8fbc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXmbwmBUU6Dem2sJO5oENqmVV9Ufe0LQ9VGmn8626vFdauiOcI
	twM2NSAIm+Zc1P3MIKtuUuumt7J4VACeAi1j+ycJ+9xX9njiD0K+tacN
X-Gm-Gg: ASbGncu+hwYb+oo5tq6Xo6i7wN75B+oDvQiCRSlNJUfk97n6OgOBBXyg5aWe9MHiUu/
	W5Mr/c0DMnfmkzsVlv2GCMSYutvasgzPO2mw1j2PA2HPiK/5e6Mrn1GAeBfqtYdHfDXC4Vh/aUK
	imh7qclm2sRf2lcpLNRW+/UAIZ62EtUEj1rpwebTVL7G7HlaREpXOVlLF+Z1c8qNH1gUANcVART
	AXRRSH3fx0X5rWuHRVEi9hhMz6D6h1B6GxRK2xwvywCWYTtCBBwjn0P7z/CoG8ABvDQFPfujKRA
	tDW3+3rzxEzZo7nCbZ6yRDxDO0iF8SmEMD0OXLtodqOfbKh/AyvdMqSkxwtQulODuiErgfrMCUX
	4KKxs1qL4Ab6Z8hBYcjpWUFbxbtEUiMUKXQyl3muHInR+ix/igN1ZH4D83VeX9BWzWv3hzGoSWl
	mIcytLQ0P2WjDVxY5f0A==
X-Google-Smtp-Source: AGHT+IHZ8ksUbK5gXKZSid7wPAY7piPOvChEgdLcJImb7iQbWhTr5ZvKB9Bn7kp1zwGLCz13KWhebA==
X-Received: by 2002:a05:6a00:22ce:b0:7a2:75a9:b2b7 with SMTP id d2e1a72fcca58-7a62a3624d0mr2758460b3a.1.1761810766150;
        Thu, 30 Oct 2025 00:52:46 -0700 (PDT)
Received: from E07P150077.ecarx.com.cn ([103.52.189.24])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414065418sm17955236b3a.41.2025.10.30.00.52.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 00:52:45 -0700 (PDT)
From: Jianyun Gao <jianyungao89@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: Jianyun Gao <jianyungao89@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf))
Subject: [PATCH] libbpf: fix some mismatched @param tags in Doxygen comment of libbpf.h
Date: Thu, 30 Oct 2025 15:52:37 +0800
Message-Id: <20251030075237.1213902-1-jianyungao89@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are some mismatched @param tags in Doxygen comment of libbpf.h.
The following is a case:

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

This patch fixes the issues present in the Doxygen comments in the
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



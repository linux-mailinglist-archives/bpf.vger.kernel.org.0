Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B8E4642DBCC
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbhJNOhI (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231281AbhJNOhH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:37:07 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D140FC061570
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:02 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r18so20222592wrg.6
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BRUjR/ynNSZXKI1Qw/nmqBhG9Te4luaxiOMO8oANsB4=;
        b=ke8ImMeDAtcPAl6vDL0IzwHA40rSF2x4ssCVMHXFnFnmbENSLw47MK4a4g8QvMKXjF
         IpFG24JhclwmdM9O5jB/aBejG1igeA33RacC8fHTr3UDazv8oL0D5sAyiOQ7/gaiFBtJ
         tYkmBUl2tiBw6ftpvOAFWc2YDtjIJLwqNccHI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BRUjR/ynNSZXKI1Qw/nmqBhG9Te4luaxiOMO8oANsB4=;
        b=iQEYy5BdCxIEgj7bZFtU4iIOD0fQkhkk6AUQFaFZB2cgdGwOKzFzGrxmAEcHEzpS9h
         VISpdT/LgfrGmo2kOvXPG1stuzxDYQDF1npXv09mWyFhrSvdtdr1mIsr/3nl+sQItlYH
         bgWTqBKD4X3ngFwQSJuW65+6RXD696RgrU62PCRi2y83aSTquzJ2iqv/qF/R3cKpw8aS
         wOR2hDgJ4QD7H9ouUbXcWZK4d07YDwYtpctnDokwjjaJiuR7mZJgF51x0LwCz2dlZQCV
         YH0rojtY+r1Izu5WLkzPIZdwMZ2kRRb8zhIld4oM2a8/3/afvVOdy4+x/j0fuw6iwDzT
         MHIg==
X-Gm-Message-State: AOAM531HeZ1Rvl30bh5f4qFJpq4MFkHXMeIC6kwCG5nc2Q3HevImM32l
        L0K0sEiP9PZxmY3qhXZqP+4XZA==
X-Google-Smtp-Source: ABdhPJxeDnDYVtGi4ro7aSOb6rCa7StO5fjsvfOd5qtgVCmjl5mwZMJB2qY62d23Lq64gdX0S0RGyQ==
X-Received: by 2002:a5d:6481:: with SMTP id o1mr7354602wri.60.1634222101456;
        Thu, 14 Oct 2021 07:35:01 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id k6sm2656439wri.83.2021.10.14.07.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:35:01 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [RFC 7/9] bpf: split get_id and fd_by_id in bpf_attr
Date:   Thu, 14 Oct 2021 15:34:33 +0100
Message-Id: <20211014143436.54470-10-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014143436.54470-1-lmb@cloudflare.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 include/uapi/linux/bpf.h | 60 ++++++++++++++++++++++++++++++++--------
 kernel/bpf/syscall.c     | 18 ++++++------
 2 files changed, 58 insertions(+), 20 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index d3acd12d98c1..13d126c201ce 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1422,17 +1422,43 @@ union bpf_attr {
 		__u32		cpu;
 	} test;
 
-	struct { /* anonymous struct used by BPF_*_GET_*_ID */
-		union {
-			__u32		start_id;
-			__u32		prog_id;
-			__u32		map_id;
-			__u32		btf_id;
-			__u32		link_id;
-		};
-		__u32		next_id;
-		__u32		open_flags;
-	};
+	struct { /* used by BPF_PROG_GET_FD_BY_ID command */
+		__u32 id;
+	} prog_get_fd_by_id;
+
+	struct { /* used by BPF_MAP_GET_FD_BY_ID command */
+		__u32 id;
+		__u32 ingnored;
+		__u32 open_flags;
+	} map_get_fd_by_id;
+
+	struct { /* used by BPF_BTF_GET_FD_BY_ID command */
+		__u32 id;
+	} btf_get_fd_by_id;
+
+	struct { /* used by BPF_LINK_GET_FD_BY_ID command */
+		__u32 id;
+	} link_get_fd_by_id;
+
+	struct { /* used by BPF_PROG_GET_NEXT_ID command */
+		__u32 start_id;
+		__u32 next_id;
+	} prog_get_next_id;
+
+	struct { /* used by BPF_MAP_GET_NEXT_ID command */
+		__u32 start_id;
+		__u32 next_id;
+	} map_get_next_id;
+
+	struct { /* used by BPF_BTF_GET_NEXT_ID command */
+		__u32 start_id;
+		__u32 next_id;
+	} btf_get_next_id;
+
+	struct { /* used by BPF_LINK_GET_NEXT_ID command */
+		__u32 start_id;
+		__u32 next_id;
+	} link_get_next_id;
 
 	struct { /* anonymous struct used by BPF_OBJ_GET_INFO_BY_FD */
 		__u32		bpf_fd;
@@ -1557,6 +1583,18 @@ union bpf_attr {
 		};
 		__u64		flags;
 	};
+
+	struct { /* anonymous struct used by BPF_*_GET_*_ID */
+		union {
+			__u32		start_id;
+			__u32		prog_id;
+			__u32		map_id;
+			__u32		btf_id;
+			__u32		link_id;
+		};
+		__u32		next_id;
+		__u32		open_flags;
+	};
 } __attribute__((aligned(8)));
 
 /* The description below is an attempt at providing documentation to eBPF
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c4aecdbb390e..234860bd05bf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -3367,7 +3367,7 @@ struct bpf_prog *bpf_prog_get_curr_or_next(u32 *id)
 	return prog;
 }
 
-#define BPF_PROG_GET_FD_BY_ID_LAST_FIELD prog_id
+#define BPF_PROG_GET_FD_BY_ID_LAST_FIELD prog_get_fd_by_id.id
 
 struct bpf_prog *bpf_prog_by_id(u32 id)
 {
@@ -3389,7 +3389,7 @@ struct bpf_prog *bpf_prog_by_id(u32 id)
 static int bpf_prog_get_fd_by_id(const union bpf_attr *attr)
 {
 	struct bpf_prog *prog;
-	u32 id = attr->prog_id;
+	u32 id = attr->prog_get_fd_by_id.id;
 	int fd;
 
 	if (CHECK_ATTR(BPF_PROG_GET_FD_BY_ID))
@@ -3409,12 +3409,12 @@ static int bpf_prog_get_fd_by_id(const union bpf_attr *attr)
 	return fd;
 }
 
-#define BPF_MAP_GET_FD_BY_ID_LAST_FIELD open_flags
+#define BPF_MAP_GET_FD_BY_ID_LAST_FIELD map_get_fd_by_id.open_flags
 
 static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 {
 	struct bpf_map *map;
-	u32 id = attr->map_id;
+	u32 id = attr->map_get_fd_by_id.id;
 	int f_flags;
 	int fd;
 
@@ -3425,7 +3425,7 @@ static int bpf_map_get_fd_by_id(const union bpf_attr *attr)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	f_flags = bpf_get_file_flag(attr->open_flags);
+	f_flags = bpf_get_file_flag(attr->map_get_fd_by_id.open_flags);
 	if (f_flags < 0)
 		return f_flags;
 
@@ -3984,7 +3984,7 @@ static int bpf_btf_load(const union bpf_attr *attr, bpfptr_t uattr)
 	return btf_new_fd(attr, uattr);
 }
 
-#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_id
+#define BPF_BTF_GET_FD_BY_ID_LAST_FIELD btf_get_fd_by_id.id
 
 static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
 {
@@ -3994,7 +3994,7 @@ static int bpf_btf_get_fd_by_id(const union bpf_attr *attr)
 	if (!capable(CAP_SYS_ADMIN))
 		return -EPERM;
 
-	return btf_get_fd_by_id(attr->btf_id);
+	return btf_get_fd_by_id(attr->btf_get_fd_by_id.id);
 }
 
 static int bpf_task_fd_query_copy(const union bpf_attr *attr,
@@ -4369,12 +4369,12 @@ struct bpf_link *bpf_link_by_id(u32 id)
 	return link;
 }
 
-#define BPF_LINK_GET_FD_BY_ID_LAST_FIELD link_id
+#define BPF_LINK_GET_FD_BY_ID_LAST_FIELD link_get_fd_by_id.id
 
 static int bpf_link_get_fd_by_id(const union bpf_attr *attr)
 {
 	struct bpf_link *link;
-	u32 id = attr->link_id;
+	u32 id = attr->link_get_fd_by_id.id;
 	int fd;
 
 	if (CHECK_ATTR(BPF_LINK_GET_FD_BY_ID))
-- 
2.30.2


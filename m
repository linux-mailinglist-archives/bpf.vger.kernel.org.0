Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AED911BFE1
	for <lists+bpf@lfdr.de>; Wed, 11 Dec 2019 23:34:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727119AbfLKWeo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 11 Dec 2019 17:34:44 -0500
Received: from mail-pl1-f201.google.com ([209.85.214.201]:55650 "EHLO
        mail-pl1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726623AbfLKWeo (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 11 Dec 2019 17:34:44 -0500
Received: by mail-pl1-f201.google.com with SMTP id 66so181993plc.22
        for <bpf@vger.kernel.org>; Wed, 11 Dec 2019 14:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=lQpyK5Eg7lGx+o3sbDMKqWXZbBnjtobMbtVvJLV8vuU=;
        b=i6KUnPrg8wS8fz1OC/0FVlYjiKjXkPYU2ZAHAZqB4Kmj5Oa3h1CHwnILOk3hE97Auq
         yTVD2FtQL7GPkCAp3bU5NTy5AAYCPRjxRRLnBeI7nrHwYzYOOTj5hxX+lTPOzSW0yLLK
         SHABMziL+UoyOWehbOiYQRz7zzcY9P1ItJLZXrx3cdiFnW3FTVtwlNks6rCnlF2VUCE4
         LNZqp9hdmkSYTRSPO/w2VCySJAK+vOLKfFr23i8p3gnhRrz7uOAcro2a2YD1CvuwgUSj
         dZW9ZXNcOUTBFSKyA8yQMnip0xj9M07c7/NCe4rNhYTQF6k2aJ4BxRN0wbDu4xolfAaK
         qTTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=lQpyK5Eg7lGx+o3sbDMKqWXZbBnjtobMbtVvJLV8vuU=;
        b=qaaeLmRkb/HU5ayx8cmbsdIZtZSl5WQUx6BGprdAV/bgrF5pL7hq+1RYSzmG1o68cP
         5Wf0R2ZAeoL6kaplj67EZRQPU4/110KOhRz/luTFh4nydmDYLikbXXB5Tc31WAYtskgo
         kPLTYjCeP5ddEYiHszw2u9r4TE7oLuNPG44e/1whTz1WD7mBr+wWrU0Ahub051G80HmY
         0sB8rDg/6XotglSWXFWVdcmuwRmN+ykJrJ2cp8Fq1LeARyo+dXygJjtb2WwM1FdE/Wb9
         aU8b/agZn1S+tZOtaABIk6BsFcRUtCsnZiOPGiQYF7jceZALpCA2vfWBxefpREq7HvUO
         grwg==
X-Gm-Message-State: APjAAAVvPIeQwXddVYbKVno/CqMSv484KLfMNX0e5scqBMXUIAhK40rl
        1vmLuizlODskJc+bmE7gZRufiCN8Wvqh
X-Google-Smtp-Source: APXvYqyHtnoT9365ymVLlNBXEyHx74N+sr782SWuwTl1pDv4J6R0GdMSpVLwYZH0dkSCgSaY+jh5QQmING+u
X-Received: by 2002:a63:197:: with SMTP id 145mr6915703pgb.11.1576103683551;
 Wed, 11 Dec 2019 14:34:43 -0800 (PST)
Date:   Wed, 11 Dec 2019 14:33:41 -0800
In-Reply-To: <20191211223344.165549-1-brianvv@google.com>
Message-Id: <20191211223344.165549-9-brianvv@google.com>
Mime-Version: 1.0
References: <20191211223344.165549-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.1.735.g03f4e72817-goog
Subject: [PATCH v3 bpf-next 08/11] libbpf: add libbpf support to batch ops
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Brian Vazquez <brianvv@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Yonghong Song <yhs@fb.com>, Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>,
        Willem de Bruijn <willemb@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Yonghong Song <yhs@fb.com>

Added four libbpf API functions to support map batch operations:
  . int bpf_map_delete_batch( ... )
  . int bpf_map_lookup_batch( ... )
  . int bpf_map_lookup_and_delete_batch( ... )
  . int bpf_map_update_batch( ... )

Signed-off-by: Yonghong Song <yhs@fb.com>
---
 tools/lib/bpf/bpf.c      | 61 ++++++++++++++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h      | 14 +++++++++
 tools/lib/bpf/libbpf.map |  4 +++
 3 files changed, 79 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index 98596e15390fb..933a36a33d5a0 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -443,6 +443,67 @@ int bpf_map_freeze(int fd)
 	return sys_bpf(BPF_MAP_FREEZE, &attr, sizeof(attr));
 }
 
+static int bpf_map_batch_common(int cmd, int fd, void  *in_batch,
+				void *out_batch, void *keys, void *values,
+				__u32 *count, __u64 elem_flags,
+				__u64 flags)
+{
+	union bpf_attr attr = {};
+	int ret;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.batch.map_fd = fd;
+	attr.batch.in_batch = ptr_to_u64(in_batch);
+	attr.batch.out_batch = ptr_to_u64(out_batch);
+	attr.batch.keys = ptr_to_u64(keys);
+	attr.batch.values = ptr_to_u64(values);
+	if (count)
+		attr.batch.count = *count;
+	attr.batch.elem_flags = elem_flags;
+	attr.batch.flags = flags;
+
+	ret = sys_bpf(cmd, &attr, sizeof(attr));
+	if (count)
+		*count = attr.batch.count;
+
+	return ret;
+}
+
+int bpf_map_delete_batch(int fd, void *keys, __u32 *count,
+			 __u64 elem_flags, __u64 flags)
+{
+	return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, NULL,
+				    NULL, keys, NULL, count,
+				    elem_flags, flags);
+}
+
+int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch, void *keys,
+			 void *values, __u32 *count,
+			 __u64 elem_flags, __u64 flags)
+{
+	return bpf_map_batch_common(BPF_MAP_LOOKUP_BATCH, fd, in_batch,
+				    out_batch, keys, values, count,
+				    elem_flags, flags);
+}
+
+int bpf_map_lookup_and_delete_batch(int fd, void *in_batch, void *out_batch,
+				    void *keys, void *values,
+				    __u32 *count, __u64 elem_flags,
+				    __u64 flags)
+{
+	return bpf_map_batch_common(BPF_MAP_LOOKUP_AND_DELETE_BATCH,
+				    fd, in_batch, out_batch, keys, values,
+				    count, elem_flags, flags);
+}
+
+int bpf_map_update_batch(int fd, void *keys, void *values, __u32 *count,
+			 __u64 elem_flags, __u64 flags)
+{
+	return bpf_map_batch_common(BPF_MAP_UPDATE_BATCH,
+				    fd, NULL, NULL, keys, values,
+				    count, elem_flags, flags);
+}
+
 int bpf_obj_pin(int fd, const char *pathname)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index 3c791fa8e68e8..51c577393ec48 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -126,6 +126,20 @@ LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
 LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
+LIBBPF_API int bpf_map_delete_batch(int fd, void *keys,
+				    __u32 *count, __u64 elem_flags,
+				    __u64 flags);
+LIBBPF_API int bpf_map_lookup_batch(int fd, void *in_batch, void *out_batch,
+				    void *keys, void *values, __u32 *count,
+				    __u64 elem_flags, __u64 flags);
+LIBBPF_API int bpf_map_lookup_and_delete_batch(int fd, void *in_batch,
+					       void *out_batch, void *keys,
+					       void *values, __u32 *count,
+					       __u64 elem_flags, __u64 flags);
+LIBBPF_API int bpf_map_update_batch(int fd, void *keys, void *values,
+				    __u32 *count, __u64 elem_flags,
+				    __u64 flags);
+
 LIBBPF_API int bpf_obj_pin(int fd, const char *pathname);
 LIBBPF_API int bpf_obj_get(const char *pathname);
 LIBBPF_API int bpf_prog_attach(int prog_fd, int attachable_fd,
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 495df575f87f8..4efbf25888eb0 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -210,4 +210,8 @@ LIBBPF_0.0.6 {
 } LIBBPF_0.0.5;
 
 LIBBPF_0.0.7 {
+		bpf_map_delete_batch;
+		bpf_map_lookup_and_delete_batch;
+		bpf_map_lookup_batch;
+		bpf_map_update_batch;
 } LIBBPF_0.0.6;
-- 
2.24.1.735.g03f4e72817-goog


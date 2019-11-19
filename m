Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9BE102CA2
	for <lists+bpf@lfdr.de>; Tue, 19 Nov 2019 20:31:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbfKSTbE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 19 Nov 2019 14:31:04 -0500
Received: from mail-qv1-f74.google.com ([209.85.219.74]:35780 "EHLO
        mail-qv1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727498AbfKSTbE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Tue, 19 Nov 2019 14:31:04 -0500
Received: by mail-qv1-f74.google.com with SMTP id d3so12348994qvz.2
        for <bpf@vger.kernel.org>; Tue, 19 Nov 2019 11:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=+lN+OnV/OGJwrxgrmDkzu2oxVw2ucT8UYsYGvvebriE=;
        b=NM4XR6WWNRFmctuup2sP4jTFMScoszHL0nwBVfSPrvc1hbAKi1GXF75Ngf634ArcMF
         llrHQtDYx0UjImSHtxD2z9RK5M1KdBOeTVIsUWTIJZXbSmvem3sEHxWz27I1vig7o6ea
         VGrW2X6jeyynS7LkI/0IcRJpnIfRUR4qZujUzTbdeLb89zD+6oS12LzXAzEpLIILR9fo
         fBWk7Uc1JfRL5AB5szAXP4ag4PvOx7nIIniJVo83+U4X9Pvu9tfMRx58vTGi1A6wFJC6
         a9JFAzmx8xpL+V+rgG6cNcLTHH/03nuozbgzj1cmsV7swyn/p39g2aO7cSkrinAK3ope
         Y4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=+lN+OnV/OGJwrxgrmDkzu2oxVw2ucT8UYsYGvvebriE=;
        b=taE4C3GNJYA27zjlzJ2HgZmjBT6rSievHk/qVfrArO9f+5UTBAlXAQZ9ebYJ3fqCEk
         WHbxaQp5Y6Oig/cOPscY6PCTsbMTz4ruI6tSjimJSaRt4zFh2RYBGwv1z9wu0vR2pCPh
         NmShbhyGi7UmaejVyud5D/nIQ49F+Av3rrIWwdgTWsI8yszadM/WAwmOotVHb9ZV5mXR
         l5NeQnyLvU22DnicgZX2HoOWexTU6g74+8wG0h5ilwEdZ4P8e/bpP/ewjzsJxcXWqYUD
         KRFfSzkFTCXQlJRamLOTAX2YTQiPiDnQu5Fn1mq+PYfcnlRGNx0FFcp/iPFEAdg5s39r
         UIDA==
X-Gm-Message-State: APjAAAW7S1iIcPW7BBwh7WwglHtSaQ5/bgJuSOvC/d6AuocznOcoCgd/
        QOyxccFU6f4j8B9l5AQk6Bt/B0cc5/1R
X-Google-Smtp-Source: APXvYqxf+GNA8hu6R+vVbmfguwH7wdM89U2nb3UrGK4fF8N3LhjgyQzIbjEIuhA5rVO3LUKs+aI2rRRkLbzy
X-Received: by 2002:ac8:783:: with SMTP id l3mr34181632qth.257.1574191861009;
 Tue, 19 Nov 2019 11:31:01 -0800 (PST)
Date:   Tue, 19 Nov 2019 11:30:34 -0800
In-Reply-To: <20191119193036.92831-1-brianvv@google.com>
Message-Id: <20191119193036.92831-8-brianvv@google.com>
Mime-Version: 1.0
References: <20191119193036.92831-1-brianvv@google.com>
X-Mailer: git-send-email 2.24.0.432.g9d3f5f5b63-goog
Subject: [PATCH v2 bpf-next 7/9] libbpf: add libbpf support to batch ops
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
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
index 98596e15390fb..9acd9309b47b3 100644
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
+int bpf_map_delete_batch(int fd, void *in_batch, void *out_batch, __u32 *count,
+			 __u64 elem_flags, __u64 flags)
+{
+	return bpf_map_batch_common(BPF_MAP_DELETE_BATCH, fd, in_batch,
+				    out_batch, NULL, NULL, count,
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
index 3c791fa8e68e8..3ec63384400f1 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -126,6 +126,20 @@ LIBBPF_API int bpf_map_lookup_and_delete_elem(int fd, const void *key,
 LIBBPF_API int bpf_map_delete_elem(int fd, const void *key);
 LIBBPF_API int bpf_map_get_next_key(int fd, const void *key, void *next_key);
 LIBBPF_API int bpf_map_freeze(int fd);
+LIBBPF_API int bpf_map_delete_batch(int fd, void *in_batch, void *out_batch,
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
index 8ddc2c40e482d..56462fea66f74 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -207,4 +207,8 @@ LIBBPF_0.0.6 {
 		bpf_program__size;
 		btf__find_by_name_kind;
 		libbpf_find_vmlinux_btf_id;
+		bpf_map_delete_batch;
+		bpf_map_lookup_and_delete_batch;
+		bpf_map_lookup_batch;
+		bpf_map_update_batch;
 } LIBBPF_0.0.5;
-- 
2.24.0.432.g9d3f5f5b63-goog


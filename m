Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E38C735DAE6
	for <lists+bpf@lfdr.de>; Tue, 13 Apr 2021 11:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237414AbhDMJQo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 13 Apr 2021 05:16:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:29465 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S245592AbhDMJQj (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 13 Apr 2021 05:16:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1618305378;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0WQ0gS1Z35Vb1nS6NIi8g9cHCL5It5tExitM3okgeQ4=;
        b=i4yBPnVEweYI+T1OC/Bvqu0qhWp+jCJcairBrQnw+/xgYI7PcyuRf0ulnWxsj70b3Bfdx7
        FPEj7L0Y/o1f4xdQqmxwbiaWxzWxDPZ2arw4Oz7fwey6sQ0vAhD6uEeeAyoUm3IPJag4Zi
        ZiKOoD5oNjvXvxyns9b3nfhE8Cg/wc8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-oSDW4nezN0SwKIaE04sNtQ-1; Tue, 13 Apr 2021 05:16:16 -0400
X-MC-Unique: oSDW4nezN0SwKIaE04sNtQ-1
Received: by mail-ed1-f70.google.com with SMTP id k20-20020aa7d2d40000b0290382b9d237d6so946884edr.17
        for <bpf@vger.kernel.org>; Tue, 13 Apr 2021 02:16:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0WQ0gS1Z35Vb1nS6NIi8g9cHCL5It5tExitM3okgeQ4=;
        b=Ik5Hk3hM6eo3WZs/eq9a1fBkQGj6oDYPK9hbSChFf65F2QQP0EH/Y8Sqt0Je3j327N
         dfWV6e+4iCLePYSMiW1MfqbnHXUAE13Oes90KJt1L2XLR2XnEzezpkhZo7IjWpalqAdh
         MKFjvTxjAyJ/PS6jo2rh1wGv+NOS8OgYnyxjAizfmgEYdLjwJWKIOInnABeWXgEqsA5G
         uW3acu6y3sMrVxx7ktoTHcl+fWAjSSunD8sFh5xMxjxIY9aX5v8aXTRhZc4/mWtGlykD
         Cv8XAEFpGwyvhWjuFplEsxbFaY5OBzZzjclUeywu5Hljj2sSgYJ10uzyf1NZucMApSeG
         D6mQ==
X-Gm-Message-State: AOAM533UIb7vWhN2EwK8wLayRCOMR1Xel9zZaSyEbkAtlt80sGaycCaa
        F0oxrx50DLTRbVp10jYAcsSsqLtwCvLe418N/SYlDTL5VU66Bx3fLCksdMLlItZYhlC5LT31f/w
        Cr1sn61wz1rKc
X-Received: by 2002:a50:eb92:: with SMTP id y18mr25651158edr.230.1618305375698;
        Tue, 13 Apr 2021 02:16:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2WTTk9TI0R5UtWek42d/MF+SSdn93zgg4UslGBx/SiQnr5Ubifr07U6qmR+qkq6sFQMrx9g==
X-Received: by 2002:a50:eb92:: with SMTP id y18mr25651139edr.230.1618305375559;
        Tue, 13 Apr 2021 02:16:15 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id t7sm3869182ejo.120.2021.04.13.02.16.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 02:16:15 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 691241804E8; Tue, 13 Apr 2021 11:16:14 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 1/2] bpf: return target info when a tracing bpf_link is queried
Date:   Tue, 13 Apr 2021 11:16:06 +0200
Message-Id: <20210413091607.58945-1-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

There is currently no way to discover the target of a tracing program
attachment after the fact. Add this information to bpf_link_info and return
it when querying the bpf_link fd.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/linux/bpf_verifier.h   | 9 +++++++++
 include/uapi/linux/bpf.h       | 2 ++
 kernel/bpf/syscall.c           | 3 +++
 tools/include/uapi/linux/bpf.h | 2 ++
 4 files changed, 16 insertions(+)

diff --git a/include/linux/bpf_verifier.h b/include/linux/bpf_verifier.h
index 51c2ffa3d901..6023a1367853 100644
--- a/include/linux/bpf_verifier.h
+++ b/include/linux/bpf_verifier.h
@@ -487,6 +487,15 @@ static inline u64 bpf_trampoline_compute_key(const struct bpf_prog *tgt_prog,
 		return ((u64)btf_obj_id(btf) << 32) | 0x80000000 | btf_id;
 }
 
+/* unpack the IDs from the key as constructed above */
+static inline void bpf_trampoline_unpack_key(u64 key, u32 *obj_id, u32 *btf_id)
+{
+	if (obj_id)
+		*obj_id = key >> 32;
+	if (btf_id)
+		*btf_id = key & 0x7FFFFFFF;
+}
+
 int bpf_check_attach_target(struct bpf_verifier_log *log,
 			    const struct bpf_prog *prog,
 			    const struct bpf_prog *tgt_prog,
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 49371eba98ba..397884396671 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -5379,6 +5379,8 @@ struct bpf_link_info {
 		} raw_tracepoint;
 		struct {
 			__u32 attach_type;
+			__u32 target_obj_id; /* prog_id for PROG_EXT, otherwise btf object id */
+			__u32 target_btf_id; /* BTF type id inside the object */
 		} tracing;
 		struct {
 			__u64 cgroup_id;
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 6428634da57e..fd495190115e 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2551,6 +2551,9 @@ static int bpf_tracing_link_fill_link_info(const struct bpf_link *link,
 		container_of(link, struct bpf_tracing_link, link);
 
 	info->tracing.attach_type = tr_link->attach_type;
+	bpf_trampoline_unpack_key(tr_link->trampoline->key,
+				  &info->tracing.target_obj_id,
+				  &info->tracing.target_btf_id);
 
 	return 0;
 }
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 69902603012c..1a240be873d7 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -5373,6 +5373,8 @@ struct bpf_link_info {
 		} raw_tracepoint;
 		struct {
 			__u32 attach_type;
+			__u32 target_obj_id; /* prog_id for PROG_EXT, otherwise btf object id */
+			__u32 target_btf_id; /* BTF type id inside the object */
 		} tracing;
 		struct {
 			__u64 cgroup_id;
-- 
2.31.1


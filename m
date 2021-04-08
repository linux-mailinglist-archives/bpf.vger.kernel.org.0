Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9C6C358DEB
	for <lists+bpf@lfdr.de>; Thu,  8 Apr 2021 21:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232041AbhDHT6J (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 8 Apr 2021 15:58:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60255 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232014AbhDHT6H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 8 Apr 2021 15:58:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617911875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=u0nNX2o4h5m416muun3Jd14ek5DO05wnyGCg4TXEeew=;
        b=Q9O2dvNFjOw29voHGwQoXtkmyOVS5l92b2c9XxjKN7oBXZqgjUG9nJOvpiCVdVvO1mkru8
        NEw9YsEs2ONu378c1puH9NUsUR4NAYiD4COahuLfJQMY/qpa/4+4frNCgZQAW3i/yHd6Q/
        li9G9L41MqzuuraNbV+qR7fI6QCcNIU=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-232-eZQvHhhxM2SXs0q7_8HBjQ-1; Thu, 08 Apr 2021 15:57:53 -0400
X-MC-Unique: eZQvHhhxM2SXs0q7_8HBjQ-1
Received: by mail-ed1-f69.google.com with SMTP id dj13so1527445edb.14
        for <bpf@vger.kernel.org>; Thu, 08 Apr 2021 12:57:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u0nNX2o4h5m416muun3Jd14ek5DO05wnyGCg4TXEeew=;
        b=mmbJG6xTDTYyaHl3iSMvxV1LcKDwCqrvufpCUfPTxwyeEIRnZQaWNOfyqtKh2dLAW+
         2H7sHr9GTwYKmusNYltepjTJwHS8Asv/fwN7rUs0nUdJo4aUQOP0Tv95lvczeR3o7yta
         bjRj0lCo++s68lt7LOwlFyIcHW231Y7qwvKLexKr4C8fVQL/oDbjp1Ry6kjS71LkH5KD
         bq2D4ApNs/XFPUjK+yAVxLu2VP3tm3xoEgEIja68wl2Qo9KIgmceLBLYDnhEMcfRKWlE
         AbbQka9/+xIuAIxKKw6BGvTPgU3XQv4y6DR8lyjiDX9b9TDp5wD2zO8DnXXXHnKpn/S9
         FZ9Q==
X-Gm-Message-State: AOAM533q1MvnhQAC3gP1gFY7sgSVrhLPshpdxMNcbTxX0LmIIS+ehE0p
        POduWJuCP6b24htVeA9XlRHOqojjpI/YxeCBh5nD5yWNGxZSRQYgSXiEaLjG/9ktgRggJaYoTBC
        XgSEB3KYzEtgt
X-Received: by 2002:aa7:cd07:: with SMTP id b7mr13962236edw.293.1617911872566;
        Thu, 08 Apr 2021 12:57:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy54R4ftKO8Xjvg3SYcXRQN9uXALiuY1BQdTnNpyh7YToz/DAToSOK2txrLbguE4bqiQGLcqQ==
X-Received: by 2002:aa7:cd07:: with SMTP id b7mr13962214edw.293.1617911872155;
        Thu, 08 Apr 2021 12:57:52 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h3sm183291edv.80.2021.04.08.12.57.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 12:57:51 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id D4EFE18030D; Thu,  8 Apr 2021 21:57:50 +0200 (CEST)
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
Subject: [PATCH bpf-next 1/2] bpf: return target info when a tracing bpf_link is queried
Date:   Thu,  8 Apr 2021 21:57:39 +0200
Message-Id: <20210408195740.153029-1-toke@redhat.com>
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C91D73460
	for <lists+bpf@lfdr.de>; Wed, 24 Jul 2019 18:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728537AbfGXQ6k (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 24 Jul 2019 12:58:40 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:42312 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728496AbfGXQ6h (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 24 Jul 2019 12:58:37 -0400
Received: by mail-qk1-f202.google.com with SMTP id 199so39968150qkj.9
        for <bpf@vger.kernel.org>; Wed, 24 Jul 2019 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=glKaPZF0kuawPUQxXbpKIp+157oyf0yYPp3UELzJQsg=;
        b=rqq9g03PpRhF3ymvIyKsJZzyqpeGHYdT7zGj3bnG5I1MzwqawSR6jYQY47lcFaPh8u
         AC4HC3jBJ8Q6HPjbVfvzmz4thwjP+kPTjr2j5uQJzkIhru+IeBl/CNrBF8HUEJPBemGj
         YCZ8sgHUbNal4hCkX93eIDVTkVotYLPT72iFfHt7htZalJIeNAPgZOBv4v1Aggm/iBAF
         E4vT2Eug6Gz2suAsgF+EumINRAuFJHHIgZphdq8fz7jesmzD+kw6OvLpLQVJ3v4oNRKf
         6h7BMZEYGDGnq0Cb8crL9rOnzJd0xO2wfJjOb3bwSjthqNd8+O6dl4tNFBv5bU8iEhTG
         811w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=glKaPZF0kuawPUQxXbpKIp+157oyf0yYPp3UELzJQsg=;
        b=H3fA8hpU2p3AiPKrseoIyef/bKSAX1sC8xeEseg2XTJDqpLha8NzH1dloy02/ZIkgG
         8Nyy4DCktZeHqtdcR+YryVwfRPJ5wKrq4htvhQXDUULj0Q02/Ugg68pAMjuTSAS0TxPo
         IuBHCNe4Sy67lwVkG5MANcXViQKJ4B8qMmdKvuThBTp8VCedC4G9F2w/V+gywbOUf90U
         StVbLF1u+RDYLghzTggdL6OG7z/XXNI171Sdm3YqrCfsMXKMbdqUxWZ2GyaRpNAOjTDS
         RDS+jjC2vgThprYiT9HqprPeU7sIVeplWL0oYylHkP6NU74Rpa4aNVm0mx3AWpCaiB2g
         kMLw==
X-Gm-Message-State: APjAAAUHPvYxabHsPIwXY7ZbV+qK9TdGGSGWZ90FABUEK3TfhRpkxPi1
        /1GfmeEP9WUBBwO3ZT5t6bsMYRMrvxjm
X-Google-Smtp-Source: APXvYqwGhYKsmoggPNt4NsKlJiqWSzOCNjflzOiZPEzbK6MDkFFQIP6wyFXKUEoZQwNfArLV+zvI15TnxLV0
X-Received: by 2002:a0c:8a76:: with SMTP id 51mr60440819qvu.210.1563987516337;
 Wed, 24 Jul 2019 09:58:36 -0700 (PDT)
Date:   Wed, 24 Jul 2019 09:58:01 -0700
In-Reply-To: <20190724165803.87470-1-brianvv@google.com>
Message-Id: <20190724165803.87470-5-brianvv@google.com>
Mime-Version: 1.0
References: <20190724165803.87470-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.657.g960e92d24f-goog
Subject: [PATCH bpf-next 4/6] libbpf: support BPF_MAP_DUMP command
From:   Brian Vazquez <brianvv@google.com>
To:     Brian Vazquez <brianvv.kernel@gmail.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        "David S . Miller" <davem@davemloft.net>
Cc:     Stanislav Fomichev <sdf@google.com>,
        Willem de Bruijn <willemb@google.com>,
        Petar Penkov <ppenkov@google.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Brian Vazquez <brianvv@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Make libbpf aware of new BPF_MAP_DUMP command and add bpf_map_dump and
bpf_map_dump_flags to use them from the library.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/lib/bpf/bpf.c | 28 ++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h |  4 ++++
 2 files changed, 32 insertions(+)

diff --git a/tools/lib/bpf/bpf.c b/tools/lib/bpf/bpf.c
index c7d7993c44bb0..c1139b7db756a 100644
--- a/tools/lib/bpf/bpf.c
+++ b/tools/lib/bpf/bpf.c
@@ -368,6 +368,34 @@ int bpf_map_update_elem(int fd, const void *key, const void *value,
 	return sys_bpf(BPF_MAP_UPDATE_ELEM, &attr, sizeof(attr));
 }
 
+int bpf_map_dump(int fd, const void *prev_key, void *buf, void *buf_len)
+{
+	union bpf_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.dump.map_fd = fd;
+	attr.dump.prev_key = ptr_to_u64(prev_key);
+	attr.dump.buf = ptr_to_u64(buf);
+	attr.dump.buf_len = ptr_to_u64(buf_len);
+
+	return sys_bpf(BPF_MAP_DUMP, &attr, sizeof(attr));
+}
+
+int bpf_map_dump_flags(int fd, const void *prev_key, void *buf, void *buf_len,
+		       __u64 flags)
+{
+	union bpf_attr attr;
+
+	memset(&attr, 0, sizeof(attr));
+	attr.dump.map_fd = fd;
+	attr.dump.prev_key = ptr_to_u64(prev_key);
+	attr.dump.buf = ptr_to_u64(buf);
+	attr.dump.buf_len = ptr_to_u64(buf_len);
+	attr.dump.flags = flags;
+
+	return sys_bpf(BPF_MAP_DUMP, &attr, sizeof(attr));
+}
+
 int bpf_map_lookup_elem(int fd, const void *key, void *value)
 {
 	union bpf_attr attr;
diff --git a/tools/lib/bpf/bpf.h b/tools/lib/bpf/bpf.h
index ff42ca043dc8f..86496443440e9 100644
--- a/tools/lib/bpf/bpf.h
+++ b/tools/lib/bpf/bpf.h
@@ -112,6 +112,10 @@ LIBBPF_API int bpf_verify_program(enum bpf_prog_type type,
 LIBBPF_API int bpf_map_update_elem(int fd, const void *key, const void *value,
 				   __u64 flags);
 
+LIBBPF_API int bpf_map_dump(int fd, const void *prev_key, void *buf,
+				void *buf_len);
+LIBBPF_API int bpf_map_dump_flags(int fd, const void *prev_key, void *buf,
+				void *buf_len, __u64 flags);
 LIBBPF_API int bpf_map_lookup_elem(int fd, const void *key, void *value);
 LIBBPF_API int bpf_map_lookup_elem_flags(int fd, const void *key, void *value,
 					 __u64 flags);
-- 
2.22.0.657.g960e92d24f-goog


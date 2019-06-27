Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 684E758BA1
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2019 22:25:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfF0UZE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 27 Jun 2019 16:25:04 -0400
Received: from mail-pf1-f202.google.com ([209.85.210.202]:54470 "EHLO
        mail-pf1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726647AbfF0UYn (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 27 Jun 2019 16:24:43 -0400
Received: by mail-pf1-f202.google.com with SMTP id c17so2257504pfb.21
        for <bpf@vger.kernel.org>; Thu, 27 Jun 2019 13:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Qx6zTmWl7cnoAmaxAa2U3PPxEaWd7SQs0w5RBVcvKMg=;
        b=ZnXGrg/aKIIKDp6JCvIE36LhXe8OA/r2R56GEOXCcPwriAo1jlO0FIzmIrwoTxDw76
         ra+QLeGO+fg1Wv5c7XdTWn9tnRCQtDvJ42Rz8GNNADc7349KibWK6OiEdRjS1xBtVNfs
         LCghjBV+8KURbqaWR0yjtXBT1MUJSZW1xLBAvvJcZeyt367gIvDQ2RCd/yNF7FhO3TTP
         3utIh4ij4wqpttrTr5zHm4VNkKigjhsqPTyWCHsl/xKIa2sHteRRmGJC23g9rCVdHw20
         APJXPEOAlAtyQMeCqidLrog+2jpeD+p9+U2QhaTmnvchzxrDKYMgFtqQMNogs1HzfYU0
         EM0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Qx6zTmWl7cnoAmaxAa2U3PPxEaWd7SQs0w5RBVcvKMg=;
        b=GycqpeXEAXyvOWRcIN8AWXREEGq5N6nmYRzBQAq7rlOWMTozL2kkukxbdN+G/TGImF
         0yAXSqAbzBBJ4yuVAuVDIYYbobo+O/cZhAW+4Mm0w+QKoQ9FGPDAwlEKYgQIkkYz6wW0
         i5yHN7ENoCXMH4h9xSjDwq1Ly8W6iZKFCSB6kaChDivGjJCaqKJlPUnNgze3txDM/a4B
         1Kl4t586YT1Jo6SWIyBuItTSP683yaxVLeMeUv70JeSBvxCN/XINmIuiZZO929NIap6w
         lme0r1sbEQl7ek/b1TQe3rLhbcWngQ9Szg09CZsKxxgTZsWm0dP91qbOj5wjsEn1IFer
         8YfA==
X-Gm-Message-State: APjAAAXn6whjKgZUvptZZ9fKrUQE+kaLWe95WbkluJfiz+cjeP86VNee
        39iB5PRO2dqYJYrcjdXPTtF7b3qi4ylR
X-Google-Smtp-Source: APXvYqwO73/Wf8OjbR7AguARbIPpJbr9Skn1f30wxVASaYDnFEc20/KJItyzMesHlRyzSkcB+UUSWMjN07l/
X-Received: by 2002:a63:d354:: with SMTP id u20mr5374534pgi.129.1561667082596;
 Thu, 27 Jun 2019 13:24:42 -0700 (PDT)
Date:   Thu, 27 Jun 2019 13:24:15 -0700
In-Reply-To: <20190627202417.33370-1-brianvv@google.com>
Message-Id: <20190627202417.33370-5-brianvv@google.com>
Mime-Version: 1.0
References: <20190627202417.33370-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH bpf-next v2 4/6] libbpf: support BPF_MAP_DUMP command
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
 tools/lib/bpf/bpf.c      | 28 ++++++++++++++++++++++++++++
 tools/lib/bpf/bpf.h      |  4 ++++
 tools/lib/bpf/libbpf.map |  2 ++
 3 files changed, 34 insertions(+)

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
diff --git a/tools/lib/bpf/libbpf.map b/tools/lib/bpf/libbpf.map
index 2c6d835620d25..e7641773cfb0f 100644
--- a/tools/lib/bpf/libbpf.map
+++ b/tools/lib/bpf/libbpf.map
@@ -173,4 +173,6 @@ LIBBPF_0.0.4 {
 		btf__parse_elf;
 		bpf_object__load_xattr;
 		libbpf_num_possible_cpus;
+		bpf_map_dump;
+		bpf_map_dump_flags;
 } LIBBPF_0.0.3;
-- 
2.22.0.410.gd8fdbe21b5-goog


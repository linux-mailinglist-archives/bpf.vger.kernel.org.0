Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46E784F113
	for <lists+bpf@lfdr.de>; Sat, 22 Jun 2019 01:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726203AbfFUXRH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 21 Jun 2019 19:17:07 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:56383 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726186AbfFUXRH (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 21 Jun 2019 19:17:07 -0400
Received: by mail-qk1-f202.google.com with SMTP id j128so9212703qkd.23
        for <bpf@vger.kernel.org>; Fri, 21 Jun 2019 16:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ZJbz/C3e+sb5O/hI+5UE82UL50nEjTNC67t2N91YPtY=;
        b=b4QVZJcm4rzj68pH617zJHeAgNJm1LfNtYh0VU7Q9sMs7IbDt7O3+gLB9i+TQRnn8R
         isezYD5TuX4HIILEoC+ZDjgwi2NfSx4Bsde50eNKR2G1RNbKE/2O2GTEiK9QW/tGpKGI
         lO7QYYUcdoJuA1++3R/My85hSzs84tepI/ghmjcNszmGUxyMBBmFCXgeUsJtjss/BeRs
         Ku72dI/5CSMZ9R7lofjFbXZSIFwifeRdmfrwxvfEO2g5PQCdX3mZNilglita4A9ADGJV
         DryJY4lfbugkC26ZIDq1rerUemGvBbfqr8T6BtgAl7J2Rcd8XuoHcDnD+HJNZI9C1/EP
         b3/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ZJbz/C3e+sb5O/hI+5UE82UL50nEjTNC67t2N91YPtY=;
        b=QzEEcYtaRLDt/1HIjo5+SNcf9qrI1Gg11e6Z7o9cBeHrofvQ9wAlLBYNAQ61NAZrzq
         5ONIlWV0+/IrGW47Rol2phqMkDov09VGNfz411eUT+TO1heLkXHDliJgg/uZTg2ZI2n/
         zQhgZiq/MmB1NasHJyK3qnW3kQqgoA9EAjn9CFhd2PPQ4NhicCIdvcAxnC7ffU3ACf71
         m4U3Smo/zUjfqhEcS/I1WHnB40AyVPO9ATqp12qs7F93r1EAw6xlhu/uXh3AUwP5Lk7V
         Z0WpJvmvKFT0fDAM0uoNp2zDhl612fBpN8Zr8ukgEn9Cv5n57c4u/eyM+vFn0QUywhqo
         OLJw==
X-Gm-Message-State: APjAAAX7YLiff027AYJ7FfpWwA50cvacBJyUqN7mceO1OqlH0mI3ePk0
        48fPgSwrC9dVsSpvFlWWi0/agQXdwFdq
X-Google-Smtp-Source: APXvYqz/kKS6ujFbJd9+Guln2Rv6wk32UtbxZI5wpIlNdPvxaAXL5XvbwBo72Xmr42Ln2+xYuAIhyz3zyaoK
X-Received: by 2002:ae9:ebd0:: with SMTP id b199mr19266600qkg.56.1561159025911;
 Fri, 21 Jun 2019 16:17:05 -0700 (PDT)
Date:   Fri, 21 Jun 2019 16:16:47 -0700
In-Reply-To: <20190621231650.32073-1-brianvv@google.com>
Message-Id: <20190621231650.32073-4-brianvv@google.com>
Mime-Version: 1.0
References: <20190621231650.32073-1-brianvv@google.com>
X-Mailer: git-send-email 2.22.0.410.gd8fdbe21b5-goog
Subject: [RFC PATCH 3/6] bpf: keep bpf.h in sync with tools/
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

Adds bpf_attr.dump structure to libbpf.

Suggested-by: Stanislav Fomichev <sdf@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
---
 tools/include/uapi/linux/bpf.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index b077507efa3f3..1d753958874df 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -106,6 +106,7 @@ enum bpf_cmd {
 	BPF_TASK_FD_QUERY,
 	BPF_MAP_LOOKUP_AND_DELETE_ELEM,
 	BPF_MAP_FREEZE,
+	BPF_MAP_DUMP,
 };
 
 enum bpf_map_type {
@@ -385,6 +386,14 @@ union bpf_attr {
 		__u64		flags;
 	};
 
+	struct { /* struct used by BPF_MAP_DUMP command */
+		__u32		map_fd;
+		__aligned_u64	prev_key;
+		__aligned_u64	buf;
+		__aligned_u64	buf_len; /* input/output: len of buf */
+		__u64		flags;
+	} dump;
+
 	struct { /* anonymous struct used by BPF_PROG_LOAD command */
 		__u32		prog_type;	/* one of enum bpf_prog_type */
 		__u32		insn_cnt;
-- 
2.22.0.410.gd8fdbe21b5-goog


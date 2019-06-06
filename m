Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C537937B80
	for <lists+bpf@lfdr.de>; Thu,  6 Jun 2019 19:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729025AbfFFRvy (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 6 Jun 2019 13:51:54 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:55640 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728816AbfFFRvy (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 6 Jun 2019 13:51:54 -0400
Received: by mail-qk1-f202.google.com with SMTP id i4so2602325qkk.22
        for <bpf@vger.kernel.org>; Thu, 06 Jun 2019 10:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=3tOtYRuhXCtBCMG8P2HcvEDG0NzhuNf5NunKSxzELH4=;
        b=eCdWzDbUdSa4kepX8HThWqvQ6FEkFuDnry9hCdkM4Zt2g6hz98x3Q+7Urh+/fOyTb1
         dBcpKepTT9amz5kF7ndOLWnorlQvqoQQV6oFEeQ19SqN3gPBOIjm3DWLPqgD8ZE55qUI
         bEO9mDn3rzcmb1qRh4AsT2X7rpzo6OsCI7cKUYpjnT5zNN1Rj5oHzHIXowEuVPIGVhM1
         e8RAmpOl1NRtvU+nlboVAl+C0WUAptBJFAED8CUHbDxK7KZCW6ROEKuCOePebS+kaQGh
         2rq0wQTqlAM1SC6zAoKXjHJOg5pwBhB7f707ZVp0i4PONhAnb1W58mmChY0KtT1FGRjW
         oXTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=3tOtYRuhXCtBCMG8P2HcvEDG0NzhuNf5NunKSxzELH4=;
        b=Ji7Q+EFNU5xKiT1cbAyo2FvT4R+kdOEGNlQhH5L1ZfWmyGX0Te2oU+RRKybSXK9X/y
         ldmPPIRvkot8a2V0EpzDTNRi3BnihD5oMcHOP1K7lblOFFR18Acre8JaC3Uftv4t/wBV
         E1+t9COWivTLzFbAzjKjqnL0vw6aCUbaxutnHExDVtBB3fIIw6yh+grY6h7rEKYwf0rz
         hqCw6M5I3LtiPNh/QHH4mJROdH4sqFHmtAScRLtuXXju7ow4ZfzH9cyb/B1+ppe5xJcK
         iP4XhXznBLzGp0K6QLPC9vVLJ8ABSvFuvrONnLzDF5fowcpvH65rGBlw9OYk61yMZXZT
         SxPw==
X-Gm-Message-State: APjAAAWLis7t8CJdFPYSxrsWxgpk6ZYWpF3ZUcEk77wBay5UvQTwIken
        jSSdOV8AE6H/03L0KBPBdqmFjXw=
X-Google-Smtp-Source: APXvYqycamng+rPbnUuRN6QV9DVbXwrRtwwr5/56eA7JJXJEQpKlVOq1aAvb6k2VeyDfJESCnut5X+s=
X-Received: by 2002:a37:4d41:: with SMTP id a62mr36656042qkb.99.1559843513584;
 Thu, 06 Jun 2019 10:51:53 -0700 (PDT)
Date:   Thu,  6 Jun 2019 10:51:40 -0700
In-Reply-To: <20190606175146.205269-1-sdf@google.com>
Message-Id: <20190606175146.205269-3-sdf@google.com>
Mime-Version: 1.0
References: <20190606175146.205269-1-sdf@google.com>
X-Mailer: git-send-email 2.22.0.rc1.311.g5d7573a151-goog
Subject: [PATCH bpf-next v2 2/8] bpf: sync bpf.h to tools/
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Export new prog type and hook points to the libbpf.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/include/uapi/linux/bpf.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7c6aef253173..310b6bbfded8 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -170,6 +170,7 @@ enum bpf_prog_type {
 	BPF_PROG_TYPE_FLOW_DISSECTOR,
 	BPF_PROG_TYPE_CGROUP_SYSCTL,
 	BPF_PROG_TYPE_RAW_TRACEPOINT_WRITABLE,
+	BPF_PROG_TYPE_CGROUP_SOCKOPT,
 };
 
 enum bpf_attach_type {
@@ -192,6 +193,8 @@ enum bpf_attach_type {
 	BPF_LIRC_MODE2,
 	BPF_FLOW_DISSECTOR,
 	BPF_CGROUP_SYSCTL,
+	BPF_CGROUP_GETSOCKOPT,
+	BPF_CGROUP_SETSOCKOPT,
 	__MAX_BPF_ATTACH_TYPE
 };
 
@@ -3533,4 +3536,15 @@ struct bpf_sysctl {
 				 */
 };
 
+struct bpf_sockopt {
+	__bpf_md_ptr(struct bpf_sock *, sk);
+
+	__s32	level;
+	__s32	optname;
+
+	__u32	optlen;
+	__u32	optval;
+	__u32	optval_end;
+};
+
 #endif /* _UAPI__LINUX_BPF_H__ */
-- 
2.22.0.rc1.311.g5d7573a151-goog


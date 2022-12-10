Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF4164906C
	for <lists+bpf@lfdr.de>; Sat, 10 Dec 2022 20:36:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbiLJTgg (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 10 Dec 2022 14:36:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229683AbiLJTgf (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 10 Dec 2022 14:36:35 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBD9517041
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id h7so8299170wrs.6
        for <bpf@vger.kernel.org>; Sat, 10 Dec 2022 11:36:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8SBSj3VXVNzuIFcZAmzvJzu3WlWJZi+xQVEXNS8j/FM=;
        b=M0Gxma9x9tpJDc+WOL4OHy77hKvgyy8Rd1dwaw79luEEP2OasGKShpUzjGyg5ov5hO
         4tzpveIRiAdHXlTcivzY3g4nn2A6hS3v1E/UE8AvA5yJMvC9A5y9RaezzwRBRBNZhxni
         lP+0ZzP4yOg3SmMnyIg6Bo+a6BZF7PkHv9HxK8radEG08rceGXOzLZrT9/Pb4k0DSwT6
         Y8MRjzCxs7JMQkES30L+Yagr4i+pgp+G6Wa7/VVG6dZRZABkItvgL9/EpNyYG8dTDNWB
         nAAGD7qFrDinp7OobyTfHzcJYxvMeBwD5cDFX9OCTuRL0Vd7SsXFs8hJzOLp/HQ4QEw4
         f12Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8SBSj3VXVNzuIFcZAmzvJzu3WlWJZi+xQVEXNS8j/FM=;
        b=2YaCh8pE6yeguMeL1fswJOutNWPqOSF5ZQAJsIy5Ms13IK0oIRtWnmE5NbOHLeC6QO
         8dG8cdvDSg8AcQmLsIDO3smqgZee4jNUFbmGyxf4JYUd8sqp3ijBPec/Rh1dOxlzLibu
         y3bOa2CkUs4gdvmywldTzGV8XTu54317/3iHQTSBHSucOTgUVHGmWkNz2Zdab9CCTgOx
         eDyAsD/mnK0EJcCUU5XC8UNTg7gaoCelYGn6bK/gyViJFGQxQumx69IKH6cOYl3Bm1M5
         77a1vYYcWwSB5a8qx/Dzz+oB5n4PSD+M7B3lyuLFDtgW4adrFqaH+YiEhUFOLl6j1vP5
         L7NQ==
X-Gm-Message-State: ANoB5pllCe0dFqt/d07Ju94LaT/3GnlKs2rn521al/qal5x67XbXFfT1
        TvuMMSL2+Pzqi5aIt/gEmIqnRLvPHWqj6Q==
X-Google-Smtp-Source: AA0mqf4m4eciSEjgUfhMhPrGpSkhNdlyrGDCYN1JsrJLYv1z2mtjB6b5SNLmsNJmGLREbQTbRPvX+Q==
X-Received: by 2002:a5d:43cb:0:b0:242:22e4:998f with SMTP id v11-20020a5d43cb000000b0024222e4998fmr7024589wrr.55.1670700993102;
        Sat, 10 Dec 2022 11:36:33 -0800 (PST)
Received: from daandemeyer-fedora-PC1EV17T.thefacebook.com ([2620:10d:c092:400::5:366e])
        by smtp.googlemail.com with ESMTPSA id az18-20020adfe192000000b002423a5d7cb1sm4584676wrb.113.2022.12.10.11.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Dec 2022 11:36:32 -0800 (PST)
From:   Daan De Meyer <daan.j.demeyer@gmail.com>
To:     bpf@vger.kernel.org
Cc:     Daan De Meyer <daan.j.demeyer@gmail.com>, martin.lau@linux.dev,
        kernel-team@meta.com
Subject: [PATCH bpf-next v2 3/9] bpf: Support access to sun_path from cgroup sockaddr programs
Date:   Sat, 10 Dec 2022 20:35:53 +0100
Message-Id: <20221210193559.371515-4-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
References: <20221210193559.371515-1-daan.j.demeyer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Preparation for adding unix support to cgroup sockaddr bpf programs.
In this commit, no programs are allowed to access user_path. We'll
open this up to the new unix program types in a later commit.
---
 include/uapi/linux/bpf.h       |  1 +
 net/core/filter.c              | 19 +++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  1 +
 3 files changed, 21 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7cafcfdbb9b2..9e3c33f83bba 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6366,6 +6366,7 @@ struct bpf_sock_addr {
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
+	char user_path[108];    /* Allows 1 byte read and write. */
 	__u32 user_addrlen;	/* Allows 4 byte read and write. */
 };
 
diff --git a/net/core/filter.c b/net/core/filter.c
index d0620927dbca..cc86b38fc764 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -26,6 +26,7 @@
 #include <linux/socket.h>
 #include <linux/sock_diag.h>
 #include <linux/in.h>
+#include <linux/un.h>
 #include <linux/inet.h>
 #include <linux/netdevice.h>
 #include <linux/if_packet.h>
@@ -8830,6 +8831,8 @@ static bool sock_addr_is_valid_access(int off, int size,
 			return false;
 		}
 		break;
+	case bpf_ctx_range_till(struct bpf_sock_addr, user_path[0], user_path[107]):
+		return false;
 	}
 
 	switch (off) {
@@ -8876,6 +8879,10 @@ static bool sock_addr_is_valid_access(int off, int size,
 			return false;
 		info->reg_type = PTR_TO_SOCKET;
 		break;
+	case bpf_ctx_range_till(struct bpf_sock_addr, user_path[0], user_path[107]):
+		if (size != sizeof(char))
+			return false;
+		break;
 	case bpf_ctx_range(struct bpf_sock_addr, user_addrlen):
 		if (type != BPF_READ)
 			return false;
@@ -9995,6 +10002,18 @@ static u32 sock_addr_convert_ctx_access(enum bpf_access_type type,
 				      offsetof(struct bpf_sock_addr_kern, sk));
 		break;
 
+	case bpf_ctx_range_till(struct bpf_sock_addr, user_path[0], user_path[107]):
+		/* In kernelspace, addresses are always stored in
+		 * sockaddr_storage so any access in the full range of
+		 * sockaddr_un.sun_path is safe.
+		 */
+		off = si->off;
+		off -= offsetof(struct bpf_sock_addr, user_path[0]);
+		SOCK_ADDR_LOAD_OR_STORE_NESTED_FIELD_SIZE_OFF(
+			struct bpf_sock_addr_kern, struct sockaddr_un, uaddr,
+			sun_path, BPF_SIZE(si->code), off, tmp_reg);
+		break;
+
 	case offsetof(struct bpf_sock_addr, user_addrlen):
 		/* uaddrlen is a pointer so it should be accessed via indirect
 		 * loads and stores. Also for stores additional temporary
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 7cafcfdbb9b2..9e3c33f83bba 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -6366,6 +6366,7 @@ struct bpf_sock_addr {
 				 * Stored in network byte order.
 				 */
 	__bpf_md_ptr(struct bpf_sock *, sk);
+	char user_path[108];    /* Allows 1 byte read and write. */
 	__u32 user_addrlen;	/* Allows 4 byte read and write. */
 };
 
-- 
2.38.1


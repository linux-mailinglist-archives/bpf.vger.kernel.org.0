Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B4325D73D
	for <lists+bpf@lfdr.de>; Fri,  4 Sep 2020 13:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730182AbgIDL2j (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Sep 2020 07:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730187AbgIDL0C (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 4 Sep 2020 07:26:02 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F067C06123A
        for <bpf@vger.kernel.org>; Fri,  4 Sep 2020 04:24:16 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id z1so6408977wrt.3
        for <bpf@vger.kernel.org>; Fri, 04 Sep 2020 04:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wv2ddb+2QDJ2ZGRPuXQTiHYRYSzKaO0Pxw0bhRAUNbo=;
        b=LftXd0gAOiyniRk9C7WdEhC4KppmqK4hsYGQlUk5mKlxWg5X9r3MsPE8O1gnVfNlij
         aQg3Me/sxqLYaZd99RlpCyQAM4S6sC3pW5hA5uDfg4gqIPnaRpl3Wxd+6UI/3Ma5vSXB
         PvbJCye+wOqOOeaP5byZSOMPCWpE29016yC+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wv2ddb+2QDJ2ZGRPuXQTiHYRYSzKaO0Pxw0bhRAUNbo=;
        b=Ctjj9r3Eaf7nVdKQ4aNe/SS0wk5bFjLbJvA+5rxjX+t4+mp67vWd3f5TEl0OO2I3Jf
         7oknmCl1G1PKXId/3P1Hj1gw0K7y4De+1B5h6dn62e5SB0oify1oDvVqv8TYcb9CkkFy
         mdLnVKtV2RrfWmAx9ZeLhIrLsJH1k16LGubnnRsp14wzwApxjY486WRCVga5QZyaHP/b
         YkTkcDJ7Qt1J4DQdQ6rA82m6bItGuVXrKjNiw01poRZcj7PXKlex48zjpF/7+WfwQ3r2
         YmbQsydl34E+IowdFlQCGX4BlJupra7ovn42YKPsSvAQ2wmdHoSLY9tuZDkNqULc+nAW
         /R8Q==
X-Gm-Message-State: AOAM532ARh7PJzBrpN7nFjYDOPwx14z1dR35VxQZuVPy/93Rnt9jkaME
        w+RvyJO0jShBwxcOp4MpgopgyQ==
X-Google-Smtp-Source: ABdhPJyKnrZeNZ2IMQWcgv7+l+SG0nUyHTLMeud8GZY4Zfc9Huk/HsF8nPIUwN95oHJggIxADlKtsA==
X-Received: by 2002:adf:f082:: with SMTP id n2mr1838517wro.35.1599218654825;
        Fri, 04 Sep 2020 04:24:14 -0700 (PDT)
Received: from antares.lan (111.253.187.81.in-addr.arpa. [81.187.253.111])
        by smtp.gmail.com with ESMTPSA id v2sm9104408wrm.16.2020.09.04.04.24.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2020 04:24:14 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, yhs@fb.com, daniel@iogearbox.net, kafai@fb.com
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf-next 02/11] btf: add a global set of valid BTF socket ids
Date:   Fri,  4 Sep 2020 12:23:52 +0100
Message-Id: <20200904112401.667645-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200904112401.667645-1-lmb@cloudflare.com>
References: <20200904112401.667645-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Similar to the existing btf_sock_ids, add a set for the same data.
This allows searching for sockets using btf_set_contains.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 include/linux/btf_ids.h       | 1 +
 net/core/filter.c             | 7 +++++++
 tools/include/linux/btf_ids.h | 1 +
 3 files changed, 9 insertions(+)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index 42aa667d4433..eb6739ebbba4 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -174,6 +174,7 @@ MAX_BTF_SOCK_TYPE,
 };
 
 extern u32 btf_sock_ids[];
+extern struct btf_id_set btf_sock_ids_set;
 #endif
 
 #endif
diff --git a/net/core/filter.c b/net/core/filter.c
index 47eef9a0be6a..c7f96cfea1b0 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -9903,8 +9903,15 @@ BTF_ID_LIST_GLOBAL(btf_sock_ids)
 #define BTF_SOCK_TYPE(name, type) BTF_ID(struct, type)
 BTF_SOCK_TYPE_xxx
 #undef BTF_SOCK_TYPE
+
+BTF_SET_START_GLOBAL(btf_sock_ids_set)
+#define BTF_SOCK_TYPE(name, type) BTF_ID(struct, type)
+BTF_SOCK_TYPE_xxx
+#undef BTF_SOCK_TYPE
+BTF_SET_END(btf_sock_ids_set)
 #else
 u32 btf_sock_ids[MAX_BTF_SOCK_TYPE];
+struct btf_id_set btf_sock_ids_set;
 #endif
 
 static bool check_arg_btf_id(u32 btf_id, u32 arg)
diff --git a/tools/include/linux/btf_ids.h b/tools/include/linux/btf_ids.h
index 42aa667d4433..eb6739ebbba4 100644
--- a/tools/include/linux/btf_ids.h
+++ b/tools/include/linux/btf_ids.h
@@ -174,6 +174,7 @@ MAX_BTF_SOCK_TYPE,
 };
 
 extern u32 btf_sock_ids[];
+extern struct btf_id_set btf_sock_ids_set;
 #endif
 
 #endif
-- 
2.25.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C76BB42DBC5
	for <lists+bpf@lfdr.de>; Thu, 14 Oct 2021 16:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231161AbhJNOhD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 14 Oct 2021 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229994AbhJNOhC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 14 Oct 2021 10:37:02 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91889C061570
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:34:57 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id v17so20137589wrv.9
        for <bpf@vger.kernel.org>; Thu, 14 Oct 2021 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JB5Q5wNmb2hTXra88g0D3xIBP+iOpoIEWT0euuqnYlc=;
        b=UIM+Q0sLteuLNVadXphlCReMI9ZVnXbsjW+I7j4dkAub+Hju314RDaE9OD7VYgyPYX
         0W0a535iWYhYU0Ya2vyCpXZqa5iBbSjQ73XPqzpHGT431qjc7B9PGkAjrh00IzhaUdJL
         yWwJPOfmRqQ/tsrxViSGw/Fc6p4ZahMQtJAsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JB5Q5wNmb2hTXra88g0D3xIBP+iOpoIEWT0euuqnYlc=;
        b=VwEYA8QtES1bfdJ/OVGCeyDWypsY3nKOX9v4cWFFXgooBAxdsYkaGMdlJFFzem0S+t
         07XrKtq9oUp/UFvY8gEFFhvaWKAAQHMMyyO46OYuPx+KuWzHFSF6Plh50LiiGu7PmgTj
         +jEloqILt5NR6FwMW8ZWVR0bshrH7U94+1xRZw4UzLUuP/gqCdN8d3X3ftsUw6rFH3l2
         JEAdWQiKQOu3UZrwwde6LUuYS54wJxOyVBU7YKlgD53httwLS0qEDqEYinTIovZcDkbO
         RMTkVNwfsjkBvdU7tGce6Aa9KNpa5wrXf0xTo2/3tnTfkQWyRkRJRSDFd7aIpA7+5oI2
         +CaQ==
X-Gm-Message-State: AOAM531AOIUQOqJpYlGjuM/tHyol1wGtGBobNBfzKQ0WSlCBxWb1lPHF
        Jq59kNlsLdehWxV6W8Sbp09dcOowQ+lDbg==
X-Google-Smtp-Source: ABdhPJzw9bVs/HhOzdZQrDfMjY66uvWk1K4TTi/KplTQrwTxbeoJ6fxcuimWF2NlFR7SJ6CNqzCevg==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr20191902wmj.183.1634222095881;
        Thu, 14 Oct 2021 07:34:55 -0700 (PDT)
Received: from antares.. (4.4.a.7.5.8.b.d.d.b.6.7.4.d.a.6.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:6ad4:76bd:db85:7a44])
        by smtp.gmail.com with ESMTPSA id k6sm2656439wri.83.2021.10.14.07.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Oct 2021 07:34:55 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     andrii@kernel.org, ast@kernel.org, daniel@iogearbox.net
Cc:     bpf@vger.kernel.org, kernel-team@cloudflare.com,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [RFC 2/9] bpf: various constants
Date:   Thu, 14 Oct 2021 15:34:26 +0100
Message-Id: <20211014143436.54470-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211014143436.54470-1-lmb@cloudflare.com>
References: <20211014143436.54470-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

---
 include/uapi/linux/bpf.h | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 78b532d28761..211b9d902006 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1248,7 +1248,10 @@ enum bpf_stack_build_id_status {
 	BPF_STACK_BUILD_ID_IP = 2,
 };
 
-#define BPF_BUILD_ID_SIZE 20
+enum {
+	BPF_BUILD_ID_SIZE = 20,
+};
+
 struct bpf_stack_build_id {
 	__s32		status;
 	unsigned char	build_id[BPF_BUILD_ID_SIZE];
@@ -1258,7 +1261,9 @@ struct bpf_stack_build_id {
 	};
 };
 
-#define BPF_OBJ_NAME_LEN 16U
+enum {
+	BPF_OBJ_NAME_LEN = 16U,
+};
 
 union bpf_attr {
 	struct { /* anonymous struct used by BPF_MAP_CREATE command */
@@ -5464,7 +5469,9 @@ struct bpf_xdp_sock {
 	__u32 queue_id;
 };
 
-#define XDP_PACKET_HEADROOM 256
+enum {
+	XDP_PACKET_HEADROOM = 256,
+};
 
 /* User return codes for XDP prog type.
  * A valid XDP program must return one of these defined values. All other
@@ -5582,7 +5589,9 @@ struct sk_reuseport_md {
 	__bpf_md_ptr(struct bpf_sock *, migrating_sk);
 };
 
-#define BPF_TAG_SIZE	8
+enum {
+	BPF_TAG_SIZE = 8,
+};
 
 struct bpf_prog_info {
 	__u32 type;
-- 
2.30.2


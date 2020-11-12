Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 628832B0ECD
	for <lists+bpf@lfdr.de>; Thu, 12 Nov 2020 21:09:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgKLUJi (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 12 Nov 2020 15:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727034AbgKLUJi (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 12 Nov 2020 15:09:38 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 187B0C0613D1
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:09:36 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id p1so7315853wrf.12
        for <bpf@vger.kernel.org>; Thu, 12 Nov 2020 12:09:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7TtYo1PxIxzaXqQ92+BjQcHOSuanEJBk/khixUznWc=;
        b=QJ8Jtl+WZpjf5yduhb8CapzzbPXA3g3XODaEtW2SWUv6Ock/nei1tkkhKhv0Uu3vCz
         9HpCSmQOKbqt7EENwfppy8KpRVLY9hfLjrI0xeWiTVbd2D+/3TnW6gIVVbGY4qMRj1nc
         Hv4M8a+lF0N9cUNgH4I3SrgerWJty9FJpLJ6Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7TtYo1PxIxzaXqQ92+BjQcHOSuanEJBk/khixUznWc=;
        b=qUQWmlatcanxIopRwJRdTpvHO56AH7rddBzeVowPA4XTRIg1a6LZUdH6nhEciXbQ22
         GYCjWEJBKFmXguY7ZdxIneeVoc5gFhVbgGgBGsxRLn2DZ+OJOFec9XV5kxhPEXJAupTf
         XV39qQkjUpY13H7nBOL6Se2wa8av3BV1KBiiF6zphNypfP/JunRl7WchA9dGnREJIptC
         w1Z244sgLNc6fncQfNtHsEHvWy6s0JRNEFFQKB3h9nCyptiBwo76nxZzePX+pls49NF+
         Q/bs2rTo4YrtgvmLoJyUg1rJ5bf6N0GcvUm8qlC00UqQO06YYSj7T7veIbH6n2DmCwoK
         nVLg==
X-Gm-Message-State: AOAM530G4ERUnUCaywOOnYg+6DqqPPiG92a49lEwuDJFlSrfAJr2M9cO
        QyR8Dd718c54UAr21fdIBDjSPnohuK1kFRlP
X-Google-Smtp-Source: ABdhPJyFTHpTMFFLXUqoegQKs9aIO0k6XsjW9NUhBoGiF0NBrYgkmk1CXv7vmBywKXeD8k7OORJeDA==
X-Received: by 2002:adf:9407:: with SMTP id 7mr1552417wrq.182.1605211773935;
        Thu, 12 Nov 2020 12:09:33 -0800 (PST)
Received: from revest.zrh.corp.google.com ([2a00:79e0:42:204:f693:9fff:fef4:a569])
        by smtp.gmail.com with ESMTPSA id g4sm6913032wrp.0.2020.11.12.12.09.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2020 12:09:33 -0800 (PST)
From:   Florent Revest <revest@chromium.org>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, kafai@fb.com, yhs@fb.com,
        andrii@kernel.org, kpsingh@chromium.org, jackmanb@chromium.org,
        linux-kernel@vger.kernel.org, Florent Revest <revest@google.com>
Subject: [PATCH] bpf: Expose bpf_sk_storage_* to iterator programs
Date:   Thu, 12 Nov 2020 21:09:14 +0100
Message-Id: <20201112200914.2726327-1-revest@chromium.org>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Florent Revest <revest@google.com>

Iterators are currently used to expose kernel information to userspace
over fast procfs-like files but iterators could also be used to
initialize local storage. For example, the task_file iterator could be
used to store associations between processes and sockets.

This exposes the socket local storage helpers to all iterators. Martin
Kafai checked that this was safe to call these helpers from the
sk_storage_map iterators.

Signed-off-by: Florent Revest <revest@google.com>
---
 kernel/trace/bpf_trace.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index e4515b0f62a8..3530120fa280 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -17,6 +17,8 @@
 #include <linux/error-injection.h>
 #include <linux/btf_ids.h>
 
+#include <net/bpf_sk_storage.h>
+
 #include <uapi/linux/bpf.h>
 #include <uapi/linux/btf.h>
 
@@ -1750,6 +1752,14 @@ tracing_prog_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		       NULL;
 	case BPF_FUNC_d_path:
 		return &bpf_d_path_proto;
+	case BPF_FUNC_sk_storage_get:
+		return prog->expected_attach_type == BPF_TRACE_ITER ?
+		       &bpf_sk_storage_get_proto :
+		       NULL;
+	case BPF_FUNC_sk_storage_delete:
+		return prog->expected_attach_type == BPF_TRACE_ITER ?
+		       &bpf_sk_storage_delete_proto :
+		       NULL;
 	default:
 		return raw_tp_prog_func_proto(func_id, prog);
 	}
-- 
2.29.2.222.g5d2a92d10f8-goog


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20FA23F8EE3
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:45:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243528AbhHZTk6 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:40:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59873 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243535AbhHZTk5 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 15:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630006809;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Cz5FUM/QUQ2HTCjVFzxMUjYkqvve+4iMlPHPGJoE+bY=;
        b=g5TPky87oEMa902vleuwTw67ErNjaz9WlHlKdtcVGuSE9Jmldb9mIigb6JpDN80lvI/iGb
        A9gOeocO1aM5ZdL1YEg4AH3KkonA/IWM6T2S9HEEQYVrxwfZN1qaTmy22N8b/mgoa0JDHb
        5lCSJbUed1AzxgDsSE09GxvNHb08tH8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-P8HyeHacNl6pwM4MzlpjfA-1; Thu, 26 Aug 2021 15:40:08 -0400
X-MC-Unique: P8HyeHacNl6pwM4MzlpjfA-1
Received: by mail-wr1-f69.google.com with SMTP id n18-20020adfe792000000b00156ae576abdso1190932wrm.9
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:40:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Cz5FUM/QUQ2HTCjVFzxMUjYkqvve+4iMlPHPGJoE+bY=;
        b=W5ORW4crjXIULRR+Q9iatooD3v8fljc3S+pV+5rTVkqEWNq66eWGE+KHSoPlXj4XXt
         Kh83KLPje6pg4XTAhV3NEpAEYM0Bbz6mATxpCVIGtw8ThG81Ty0LIhxATz1I3EGILrr+
         IDbgvuLahBRYav3I14xwGVLssZYhnQEUV6LwslGvtsq5SemZqqHUIuNUmwpCNsWbKEB3
         /sbRws6g+c7a2iMCOakRPDj3QXnWEmW94AyiUrFLXLEJ0AgC1M5I4hFes0iXbAlbTYr0
         bPYijEXNtMG2aPj4mvAipMjvYq867JwHroHVzRE7FJtb0bPZo7gAXuxSkYEoIQKqE6Od
         XJpw==
X-Gm-Message-State: AOAM533RUtT8FoGU3TyPq4B7czBG8MycjSy/gNnKZiSJnuk/U8sqRuFz
        OXPyBKANFZUOCmytY8gsqVYdtStlbZNwIVB7yACmC9SqsyT3eTl6Wsbdj1nJpomsPodNV5TTvfn
        HdTiI4rcOPaOO
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr6082126wrm.1.1630006806980;
        Thu, 26 Aug 2021 12:40:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+oapw3UzB0tUkEstf0tZaeuwgr3wd1znhLKDrE5AJuTWzq9xPA/RbcYKzFpfOJzGc1FS3SA==
X-Received: by 2002:adf:e4c5:: with SMTP id v5mr6082103wrm.1.1630006806810;
        Thu, 26 Aug 2021 12:40:06 -0700 (PDT)
Received: from krava.redhat.com ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id f2sm4002494wru.31.2021.08.26.12.40.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:40:06 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, Daniel Xu <dxu@dxuuu.xyz>,
        Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v4 07/27] ftrace: Add multi direct modify interface
Date:   Thu, 26 Aug 2021 21:39:02 +0200
Message-Id: <20210826193922.66204-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826193922.66204-1-jolsa@kernel.org>
References: <20210826193922.66204-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Adding interface to modify registered direct function
for ftrace_ops. Adding following function:

   modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)

The function changes the currently registered direct
function for all attached functions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 include/linux/ftrace.h |  6 ++++++
 kernel/trace/ftrace.c  | 43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 93d8f12e70b3..63ca0a424947 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -318,6 +318,8 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 int unregister_ftrace_direct_multi(struct ftrace_ops *ops);
+int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+
 #else
 # define ftrace_direct_func_count 0
 static inline int register_ftrace_direct(unsigned long ip, unsigned long addr)
@@ -356,6 +358,10 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
 {
 	return -ENODEV;
 }
+int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7243769493c9..59940a6a907c 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5518,6 +5518,49 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops)
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
+
+int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	struct ftrace_hash *hash = ops->func_hash->filter_hash;
+	struct ftrace_func_entry *entry, *iter;
+	int i, size;
+	int err;
+
+	if (check_direct_multi(ops))
+		return -EINVAL;
+	if (!(ops->flags & FTRACE_OPS_FL_ENABLED))
+		return -EINVAL;
+
+	mutex_lock(&direct_mutex);
+	mutex_lock(&ftrace_lock);
+
+	/*
+	 * Shutdown the ops, change 'direct' pointer for each
+	 * ops entry in direct_functions hash and startup the
+	 * ops back again.
+	 */
+	err = ftrace_shutdown(ops, 0);
+	if (err)
+		goto out_unlock;
+
+	size = 1 << hash->size_bits;
+	for (i = 0; i < size; i++) {
+		hlist_for_each_entry(iter, &hash->buckets[i], hlist) {
+			entry = __ftrace_lookup_ip(direct_functions, iter->ip);
+			if (!entry)
+				continue;
+			entry->direct = addr;
+		}
+	}
+
+	err = ftrace_startup(ops, 0);
+
+ out_unlock:
+	mutex_unlock(&ftrace_lock);
+	mutex_unlock(&direct_mutex);
+	return err;
+}
+EXPORT_SYMBOL_GPL(modify_ftrace_direct_multi);
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 /**
-- 
2.31.1


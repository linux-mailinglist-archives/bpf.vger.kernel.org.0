Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB07B42666E
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 11:14:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235869AbhJHJQZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 05:16:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:42847 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237139AbhJHJQQ (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 05:16:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EXKKrinDM77WFUunxS5Afbd05XO3wolRRteT5kMHCY4=;
        b=Ajw8oZXpyPKUYjVGXzPPs7IXyVn8FUQA18STNKYb905SMgRPsCDmwBmhqPejk9Ih7vqMfJ
        MLilOw5TuEtoA+fGGIBVunONW4AICAnUfRqjaO1MCsU8LHg+HqNYcDKOvdsdw1Fa+/KZsq
        sdIZieTNdU2SLBJf4DiOuUyG1s1zRa8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-558-u8DjXsseNxCHZRO1CvBJlw-1; Fri, 08 Oct 2021 05:14:20 -0400
X-MC-Unique: u8DjXsseNxCHZRO1CvBJlw-1
Received: by mail-wr1-f70.google.com with SMTP id l6-20020adfa386000000b00160c4c1866eso6804130wrb.4
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 02:14:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EXKKrinDM77WFUunxS5Afbd05XO3wolRRteT5kMHCY4=;
        b=zLtLECBHeASVzPFO3H3+qjU4xmv3AsRQXhD0LEwkSTzt/R9SNh40a33+ezvj3EicFD
         0x+JNDQwNZR/kjle50VmaARS6HvdAJaXJ7ujN001++kqw6hWK9Dn5bIxAgdRXMUwNsRi
         XHr6FloCXLr0AOQueNzSL1p5wkyhGzxPdGfObNr/Jw47lVUpoJ1yQO72NFscgwVhSdSn
         DFPfWpU1vx3jQq1wHPSPGTcWVIuv8Zee7uoHd3yiDJGLDM42LOEoaHSQFm1bkEOZCL/2
         pbbv5zxAbCGZQIaGjhSH2djMe4bz8zPHlUNZGKXTveFWfj8Qgt66Fnm1PvT8Yzr5gFy6
         z1AQ==
X-Gm-Message-State: AOAM533tpR7LrPcno/f98aKKQa6Dg79tuugQ86kToxnG3T4MpLFabUez
        tGeOFYe1QuO17W3ywrd3YYXtk1PYohzv/z6wP4Ih5aSp2q8TgQnPB0k7YtRQGdlOC3AxBkSg/3S
        9KBlI6coejaN+
X-Received: by 2002:a05:600c:1907:: with SMTP id j7mr2161820wmq.184.1633684459439;
        Fri, 08 Oct 2021 02:14:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz84j7K2uFms5WNUH+r7ll2dxXog50Ofy2QktxnUnkOsHyey2rYBor+XjZJ2p6C+bIHLWsaKg==
X-Received: by 2002:a05:600c:1907:: with SMTP id j7mr2161801wmq.184.1633684459246;
        Fri, 08 Oct 2021 02:14:19 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id t3sm7861433wmj.33.2021.10.08.02.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:14:19 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 7/8] ftrace: Add multi direct modify interface
Date:   Fri,  8 Oct 2021 11:13:35 +0200
Message-Id: <20211008091336.33616-8-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008091336.33616-1-jolsa@kernel.org>
References: <20211008091336.33616-1-jolsa@kernel.org>
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
 include/linux/ftrace.h |  6 ++++
 kernel/trace/ftrace.c  | 62 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 68 insertions(+)

diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index ba5d02ba8166..c15b767f39cf 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -318,6 +318,8 @@ int ftrace_modify_direct_caller(struct ftrace_func_entry *entry,
 unsigned long ftrace_find_rec_direct(unsigned long ip);
 int register_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
 int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr);
+
 #else
 struct ftrace_ops;
 # define ftrace_direct_func_count 0
@@ -357,6 +359,10 @@ static inline int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigne
 {
 	return -ENODEV;
 }
+static inline int modify_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
+{
+	return -ENODEV;
+}
 #endif /* CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS */
 
 #ifndef CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9df7bffb770..d92f2591c3fc 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5547,6 +5547,68 @@ int unregister_ftrace_direct_multi(struct ftrace_ops *ops, unsigned long addr)
 	return err;
 }
 EXPORT_SYMBOL_GPL(unregister_ftrace_direct_multi);
+
+/**
+ * modify_ftrace_direct_multi - Modify an existing direct 'multi' call
+ * to call something else
+ * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the new trampoline to call at @ops functions
+ *
+ * This is used to unregister currently registered direct caller and
+ * register new one @addr on functions registered in @ops object.
+ *
+ * Note there's window between ftrace_shutdown and ftrace_startup calls
+ * where there will be no callbacks called.
+ *
+ * Returns: zero on success. Non zero on error, which includes:
+ *  -EINVAL - The @ops object was not properly registered.
+ */
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
+	 *
+	 * Note there is no callback called for @ops object after
+	 * this ftrace_shutdown call until ftrace_startup is called
+	 * later on.
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


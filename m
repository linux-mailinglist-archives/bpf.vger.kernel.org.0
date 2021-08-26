Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BED273F8ED9
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243520AbhHZTks (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:40:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243527AbhHZTkp (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 15:40:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630006797;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uK5Gw3luJndbFn1Fa9N5OtQXbRTUWbF3Z2jHUj38PoM=;
        b=JgdpZARtUwyw7ldeEnZIwFaeGUpSAl5jSTsPRlj2NFResSU6bM1Y+ko82atoMrNG0yyQ7k
        y6xMQlfWsYnq+ZO9AO8kUVNGPBWvUXZ6jkvIqoeO64AYJhrm18cc4+AZxeL4ulQwdCTHr0
        g1ypXfq8CsfRPUIyHMFbri5dDk+SGOY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-Czpd3H1hOU2kB5QIBn4TlA-1; Thu, 26 Aug 2021 15:39:55 -0400
X-MC-Unique: Czpd3H1hOU2kB5QIBn4TlA-1
Received: by mail-wm1-f69.google.com with SMTP id w25-20020a1cf6190000b0290252505ddd56so1273969wmc.3
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:39:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uK5Gw3luJndbFn1Fa9N5OtQXbRTUWbF3Z2jHUj38PoM=;
        b=eII2ypKlWiyfrgP2Q8OuRnD9nAR9D6WcoCpI0d+2BSX/IswyTuikjIBLnK9D/fKKY+
         FAYZGEahE3GzRKNKoHJ+jSbtXEXGNSwGfQK/eVmOX8A8DJGPgqst4Ig3psGxLDK9eKUW
         5EeH47Uj97RI0ORfy8wbVlczlQKFO+WaF4oIXGfcIl0hT0+sjNUkMg3O/J2ZqPAH8Ome
         kscVqwqJUhpm8NTV/ac/TXbiVXjHzLvXdTVNKnt5HTl6sPMX4OHQXiBbvL22P2b5zVXn
         WlSgeghkRKxFQe/rbPl0dfq23jnW2TR9zbHs8MD2nFQBQg38EFP/712ylyNG9OKWeCwg
         MnyQ==
X-Gm-Message-State: AOAM5303aTkPGb3V5uwH0LDAxCYUFCA3OC7jO+9Xp+VRTo/VvXAotCPZ
        RCmMfsIo5QLGgMUR7908QFKrAyP0AHgqNutgMOl1vk62VzT2HDp+i8xuPAy//zKKLdPtcK4rnWS
        V/8vfIGpdi6tj
X-Received: by 2002:adf:fb8f:: with SMTP id a15mr6051138wrr.92.1630006794546;
        Thu, 26 Aug 2021 12:39:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyFi9NXcOpnIV36WGLOJUq/THYNfhH3OgZ+38gkY2C+jDnkQzuS/bc0x0iDcjDVsSvlBt7Aug==
X-Received: by 2002:adf:fb8f:: with SMTP id a15mr6051116wrr.92.1630006794343;
        Thu, 26 Aug 2021 12:39:54 -0700 (PDT)
Received: from krava.redhat.com ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id b18sm4107493wrr.89.2021.08.26.12.39.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:39:54 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 05/27] ftrace: Add ftrace_add_rec_direct function
Date:   Thu, 26 Aug 2021 21:39:00 +0200
Message-Id: <20210826193922.66204-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826193922.66204-1-jolsa@kernel.org>
References: <20210826193922.66204-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Factor out the code that adds (ip, addr) tuple to direct_functions
hash in new ftrace_add_rec_direct function. It will be used in
following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 60 ++++++++++++++++++++++++++-----------------
 1 file changed, 36 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7b180f61e6d3..c60217d81040 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -2394,6 +2394,39 @@ unsigned long ftrace_find_rec_direct(unsigned long ip)
 	return entry->direct;
 }
 
+static struct ftrace_func_entry*
+ftrace_add_rec_direct(unsigned long ip, unsigned long addr,
+		      struct ftrace_hash **free_hash)
+{
+	struct ftrace_func_entry *entry;
+
+	if (ftrace_hash_empty(direct_functions) ||
+	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
+		struct ftrace_hash *new_hash;
+		int size = ftrace_hash_empty(direct_functions) ? 0 :
+			direct_functions->count + 1;
+
+		if (size < 32)
+			size = 32;
+
+		new_hash = dup_hash(direct_functions, size);
+		if (!new_hash)
+			return NULL;
+
+		*free_hash = direct_functions;
+		direct_functions = new_hash;
+	}
+
+	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return NULL;
+
+	entry->ip = ip;
+	entry->direct = addr;
+	__add_hash_entry(direct_functions, entry);
+	return entry;
+}
+
 static void call_direct_funcs(unsigned long ip, unsigned long pip,
 			      struct ftrace_ops *ops, struct ftrace_regs *fregs)
 {
@@ -5110,27 +5143,6 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	}
 
 	ret = -ENOMEM;
-	if (ftrace_hash_empty(direct_functions) ||
-	    direct_functions->count > 2 * (1 << direct_functions->size_bits)) {
-		struct ftrace_hash *new_hash;
-		int size = ftrace_hash_empty(direct_functions) ? 0 :
-			direct_functions->count + 1;
-
-		if (size < 32)
-			size = 32;
-
-		new_hash = dup_hash(direct_functions, size);
-		if (!new_hash)
-			goto out_unlock;
-
-		free_hash = direct_functions;
-		direct_functions = new_hash;
-	}
-
-	entry = kmalloc(sizeof(*entry), GFP_KERNEL);
-	if (!entry)
-		goto out_unlock;
-
 	direct = ftrace_find_direct_func(addr);
 	if (!direct) {
 		direct = ftrace_alloc_direct_func(addr);
@@ -5140,9 +5152,9 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 		}
 	}
 
-	entry->ip = ip;
-	entry->direct = addr;
-	__add_hash_entry(direct_functions, entry);
+	entry = ftrace_add_rec_direct(ip, addr, &free_hash);
+	if (!entry)
+		goto out_unlock;
 
 	ret = ftrace_set_filter_ip(&direct_ops, ip, 0, 0);
 	if (ret)
-- 
2.31.1


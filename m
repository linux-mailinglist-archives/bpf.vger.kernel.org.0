Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBEF6426669
	for <lists+bpf@lfdr.de>; Fri,  8 Oct 2021 11:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbhJHJQH (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 8 Oct 2021 05:16:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:59833 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237054AbhJHJQF (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 8 Oct 2021 05:16:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633684449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yPkTcBiMO+JyYGVU92LrpZqbnFZrp8nJBwqKNECsCoA=;
        b=JK/o7DHRARxi4NMUhlpDa2+ILvMVTyJkvSJsPtxSGYnNVVqWoR4sHYUtV/gLDAhlWVgdM0
        wxG9bfKZk/ty6cXNvo015EcDQQqtitTcmO/TzH5p6x3fbHxrC5b/3h+rK7oBOSAL9TGZzS
        Bj2ptE8DNPb5qrpTDnHEszFmQEwSmmA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-422-cNI_turoNmCGe7OKu0_0CA-1; Fri, 08 Oct 2021 05:14:08 -0400
X-MC-Unique: cNI_turoNmCGe7OKu0_0CA-1
Received: by mail-wr1-f72.google.com with SMTP id v15-20020adfa1cf000000b00160940b17a2so6795525wrv.19
        for <bpf@vger.kernel.org>; Fri, 08 Oct 2021 02:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yPkTcBiMO+JyYGVU92LrpZqbnFZrp8nJBwqKNECsCoA=;
        b=AlpFHvujxB+GylIfTY0A04/K1X6Xe+5OI29FD9tWf8MX7tslFowRTtATTDyEp21JhY
         xnJYECDOU1KWTNh+vVpt0UEzowrRCrBdZXn6Qv4Zt4R1HZX8JVQDN6h4CdmlW/F98w8w
         5I19HSL0T0KXw5iPCYPfJmJhF1ui5hvvWzcQ97gZIBdY2rHZgvR1COZdzCbwjbZCxbzA
         TMKdq26hFzPKy+0iWgpnr2mNKbbVZu6dwoSJpLs1iT4dhLNrren7wyZJuBd67Z+nRQTN
         h1XeEwol9Wxy1HFpQc2aIJ2Xv+EuQE4yNKjtDR7KZvlTguj/2uHegS46KazNuzUYJH+t
         4Qzw==
X-Gm-Message-State: AOAM531zbcfo9YKsKCSkjywV8Gy7rLLF4jTCFJQNGcjLVAo0/I9Q2/7m
        6F0XlPt/UQXCHz5zg+a803SWk1hjPwA0nK0Xbqx3/wK57KOd60kdw8A4c7NPle7fLyCbxcpo2SP
        uDZtFzy0s3qMm
X-Received: by 2002:a05:600c:3644:: with SMTP id y4mr2237324wmq.125.1633684447456;
        Fri, 08 Oct 2021 02:14:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdcvuUF+VLaW1cxuahKdcY46l87LC9jTZJGT4qjR69eSkhdKCU3uwWXVMNvZd4KGqGqF1o1A==
X-Received: by 2002:a05:600c:3644:: with SMTP id y4mr2237313wmq.125.1633684447312;
        Fri, 08 Oct 2021 02:14:07 -0700 (PDT)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id u3sm1800794wmc.16.2021.10.08.02.14.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 02:14:07 -0700 (PDT)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     "Steven Rostedt (VMware)" <rostedt@goodmis.org>
Cc:     bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andriin@fb.com>
Subject: [PATCH 5/8] ftrace: Add ftrace_add_rec_direct function
Date:   Fri,  8 Oct 2021 11:13:33 +0200
Message-Id: <20211008091336.33616-6-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211008091336.33616-1-jolsa@kernel.org>
References: <20211008091336.33616-1-jolsa@kernel.org>
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
 kernel/trace/ftrace.c | 64 +++++++++++++++++++++++++------------------
 1 file changed, 37 insertions(+), 27 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 3eec6792f115..6032a5441770 100644
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
@@ -5110,39 +5143,16 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
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
-		if (!direct) {
-			kfree(entry);
+		if (!direct)
 			goto out_unlock;
-		}
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


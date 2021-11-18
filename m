Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30E33455A25
	for <lists+bpf@lfdr.de>; Thu, 18 Nov 2021 12:26:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343780AbhKRL3E (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 18 Nov 2021 06:29:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:37598 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1343872AbhKRL2H (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 18 Nov 2021 06:28:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1637234705;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2wMk9r+qTWeACxM5RbfD+NjYv4ihc192PDuS22iqDs0=;
        b=g2Zrfmg69h51LojPViBqEgO906Hn46EkXpKNbh0x+TEUdo8PRbkT4lPlPSMORQglbLlX3N
        gVR0Wmu7VjC0z04gtIM9+2Kxedt4dAeEkg7KYE4d2l3ucOHJwPSy8UcycXeoXR9YoE1hHZ
        aDjuIlHEy0rBMCUk8wctV/sSXRFbFyk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-213-xSGlfLNIOwG5GHhVFjTJWQ-1; Thu, 18 Nov 2021 06:25:04 -0500
X-MC-Unique: xSGlfLNIOwG5GHhVFjTJWQ-1
Received: by mail-ed1-f70.google.com with SMTP id a3-20020a05640213c300b003e7d12bb925so5019498edx.9
        for <bpf@vger.kernel.org>; Thu, 18 Nov 2021 03:25:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2wMk9r+qTWeACxM5RbfD+NjYv4ihc192PDuS22iqDs0=;
        b=gweAL4XyDQDoMIR0Yyf2ZaZqlFHLzdLnZGoVdZ+tKi/LfCLtVfBnP1OCV/oIgymaa3
         8lnMn+ZzVZP9HdvE4kxb5pzIqeqQM9C7ZTlKLq53w7wKV3bCQavvefVaxm77qEbZwRip
         UBA8sS1ItO1T2FpXgGiw2Fm4KBwwsMBOlirTTGc2ssWXkYzAEfkoHEqHN8CMbBEk8gn8
         Hv40vH+IR0OnLKZBIjg4VVYIZUyIdn4zAmWPKUhTz61j/H3ndHN5Hc3QFncL44HSPuYt
         64Y/60yoF3OTVoiR+/X+FJnfFeZz78e/EeQGtMC3cB/8mebwaE072dCvrf8tKrpM3Ovg
         /juw==
X-Gm-Message-State: AOAM5327eCa1+5IYG92JfljM4wqXwvPas2Xj26SzFUGyLI7GrkMTDZsH
        YAiXrWjLfQyC7baNdQ/kBgPp559cSC0uCLTW7DmEElvXDJF/AhCVckL5Xz8unrBBqlkrnLF4LK9
        EMAIvI2wDZ/QB
X-Received: by 2002:a05:6402:1d50:: with SMTP id dz16mr9945786edb.125.1637234703355;
        Thu, 18 Nov 2021 03:25:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJr+RYD7h54P4G64E9M6OGatzmCpJfI84kSBT6M5VO0kPsTYqcMYXdLI/HU70s+2zCj0Sd6w==
X-Received: by 2002:a05:6402:1d50:: with SMTP id dz16mr9945762edb.125.1637234703224;
        Thu, 18 Nov 2021 03:25:03 -0800 (PST)
Received: from krava.redhat.com (nat-pool-brq-u.redhat.com. [213.175.37.12])
        by smtp.gmail.com with ESMTPSA id ht7sm1199357ejc.27.2021.11.18.03.25.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Nov 2021 03:25:02 -0800 (PST)
From:   Jiri Olsa <jolsa@redhat.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>
Cc:     Steven Rostedt <srostedt@vmware.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Subject: [PATCH bpf-next 01/29] ftrace: Use direct_ops hash in unregister_ftrace_direct
Date:   Thu, 18 Nov 2021 12:24:27 +0100
Message-Id: <20211118112455.475349-2-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211118112455.475349-1-jolsa@kernel.org>
References: <20211118112455.475349-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now when we have *direct_multi interface the direct_functions
hash is no longer owned just by direct_ops. It's also used by
any other ftrace_ops passed to *direct_multi interface.

Thus to find out that we are unregistering the last function
from direct_ops, we need to check directly direct_ops's hash.

Cc: Steven Rostedt <srostedt@vmware.com>
Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/trace/ftrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 30bc880c3849..7f0594e28226 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5217,6 +5217,7 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 {
 	struct ftrace_direct_func *direct;
 	struct ftrace_func_entry *entry;
+	struct ftrace_hash *hash;
 	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
@@ -5225,7 +5226,8 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 	if (!entry)
 		goto out_unlock;
 
-	if (direct_functions->count == 1)
+	hash = direct_ops.func_hash->filter_hash;
+	if (hash->count == 1)
 		unregister_ftrace_function(&direct_ops);
 
 	ret = ftrace_set_filter_ip(&direct_ops, ip, 1, 0);
-- 
2.31.1


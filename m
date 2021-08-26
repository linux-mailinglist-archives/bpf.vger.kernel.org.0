Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 329EB3F8EEF
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243583AbhHZTlp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:41:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:24094 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243476AbhHZTle (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 15:41:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630006846;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z2XITBrOxDpGRyjAJ/GeVEmFFxm+Vz1j/C47GlqXHzU=;
        b=CocDHnl9xXT2Mnawh/vuRjEM2/yahjy32SkyjftiNfIlmBPyzUnw47HUIZLTdlH98R50Qj
        3wiBGKc9xpog+yXWKx3DEfUDvTNCTfWxRAniCXive3EPEqnRtDNycEE1iQBwdYrwhJa2IE
        G4E/C9Av834Q5/TEQiKf+XOwaDwdIvI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-513-LABtArzFMqOzaGati3I0Mw-1; Thu, 26 Aug 2021 15:40:45 -0400
X-MC-Unique: LABtArzFMqOzaGati3I0Mw-1
Received: by mail-wm1-f70.google.com with SMTP id x125-20020a1c3183000000b002e73f079eefso3448637wmx.0
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:40:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z2XITBrOxDpGRyjAJ/GeVEmFFxm+Vz1j/C47GlqXHzU=;
        b=Qh+hoM3zzkmWGsbJEuaRah3n+hkzz6tsq4uvPJNzqAIr7Ofx4EqVeU4lYJFcrNj2da
         qNe8iGzNMhq+oozkrm/CIpfSoDZAw1AeUEnaU+5UMowFTJETffM1eclqCtQDiSTYRgGt
         viLL1cq7WEVxSzoW2qczhtWUzEPJmQ7nGenEbxlEanVDZC3fZZhdavi+7naqFsoRhsec
         6PAJ+m7j7BrrKSzwKw/40wE9znIPaEZ4dquISjHYjkOUv8yoiTZrecwsThK5r6zWlKlL
         qjjPfYaFMfVr9VcQXRvGJcgZPcgD//hoTbQWZ1UQEJHeRjc3lqfVamhdA5o+F1OVvfXZ
         kzlQ==
X-Gm-Message-State: AOAM530hnRRUpc1IlvfX00oTPLKaswFBcgG7i+DlQD1c00M5C7Q8LoiJ
        6uz17wVqDP5JsfS8Idz2rXBVTzi+TiDF5+QysM9XLRHryeH2uGevJi7ItN8K7KUnJxswI9wsxZA
        u+4GGEIUIuVsN
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr15751501wmh.8.1630006844415;
        Thu, 26 Aug 2021 12:40:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzitQXnasWLsuJudMdZeXK+TS2WTVT2UhHDl/35tfbJIVjoTYJHVpOxEFwQ00OumMXLgAsD+g==
X-Received: by 2002:a1c:ed10:: with SMTP id l16mr15751486wmh.8.1630006844263;
        Thu, 26 Aug 2021 12:40:44 -0700 (PDT)
Received: from krava.redhat.com ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id f7sm9136006wmh.20.2021.08.26.12.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:40:43 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 13/27] bpf: Factor out __bpf_trampoline_put function
Date:   Thu, 26 Aug 2021 21:39:08 +0200
Message-Id: <20210826193922.66204-14-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826193922.66204-1-jolsa@kernel.org>
References: <20210826193922.66204-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Separating out __bpf_trampoline_put function, so it can
be used from other places in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 6dba43266e0b..8aa0aca38b3a 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -522,18 +522,16 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 	return tr;
 }
 
-void bpf_trampoline_put(struct bpf_trampoline *tr)
+static void __bpf_trampoline_put(struct bpf_trampoline *tr)
 {
-	if (!tr)
-		return;
-	mutex_lock(&trampoline_mutex);
+	lockdep_assert_held(&trampoline_mutex);
 	if (!refcount_dec_and_test(&tr->refcnt))
-		goto out;
+		return;
 	WARN_ON_ONCE(mutex_is_locked(&tr->mutex));
 	if (WARN_ON_ONCE(!hlist_empty(&tr->progs_hlist[BPF_TRAMP_FENTRY])))
-		goto out;
+		return;
 	if (WARN_ON_ONCE(!hlist_empty(&tr->progs_hlist[BPF_TRAMP_FEXIT])))
-		goto out;
+		return;
 	/* This code will be executed even when the last bpf_tramp_image
 	 * is alive. All progs are detached from the trampoline and the
 	 * trampoline image is patched with jmp into epilogue to skip
@@ -542,7 +540,14 @@ void bpf_trampoline_put(struct bpf_trampoline *tr)
 	 */
 	hlist_del(&tr->hlist);
 	kfree(tr);
-out:
+}
+
+void bpf_trampoline_put(struct bpf_trampoline *tr)
+{
+	if (!tr)
+		return;
+	mutex_lock(&trampoline_mutex);
+	__bpf_trampoline_put(tr);
 	mutex_unlock(&trampoline_mutex);
 }
 
-- 
2.31.1


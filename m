Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE1AA3F8EEE
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:45:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243573AbhHZTln (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:41:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46557 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243586AbhHZTl2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 15:41:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630006840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gXpJHZO1cihtLBArG/eE/Ics75WBgBQPWIW5tbtMZsM=;
        b=Zmid3RIHz2Jxmur7Linz/Ppuo/7yLy+HZyfvRUsAHfvWcq8XBtPH0zM+YyOYE2V05oMDYx
        +MFIx9nwlTcF4CFA6xH9AZ5QPMnAk+zOnmvE4hVmhB53FPU9k1afAcqS5gm37FfkgrLlHQ
        F28a36+j7hhg1GPtWgCkwPBZvQrQoGs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-49-SYyEA1E3OvO9V8y9-4Jfyw-1; Thu, 26 Aug 2021 15:40:39 -0400
X-MC-Unique: SYyEA1E3OvO9V8y9-4Jfyw-1
Received: by mail-wr1-f71.google.com with SMTP id i16-20020adfded0000000b001572ebd528eso1176983wrn.19
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:40:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gXpJHZO1cihtLBArG/eE/Ics75WBgBQPWIW5tbtMZsM=;
        b=K/JughXegVNWnMXv8usq+0/Dj45zLwP6mOqEwshFmiV8lJktOI7q5ehmub8+PsHdrN
         6d6zDjKvaSV8RQ2paN1hGnv90JjfrS34npCNGHg7u2philM5sc75yvp0WrClUnka7MKe
         WYGXxzgF2CwFYU4O/sjihlClNRtodGPh0FU1B8HP3O9JGh2Mp3mglwDfu1VdpIHabPkn
         hg8D1digt0H/26zh8onqPTyKT1sDuLg7iFU9zr3bVcr3TndhyOxM6/QzV+y3nsL0buBh
         JO86tkIjlJHSUudC0z3mz5KVyUhd7H7kdJ/FPYsK8uZaPUxPyRpvnlt6A7UFs7HHyYE9
         rGdA==
X-Gm-Message-State: AOAM533d6R9ZbZBc4B2S6MEEVSL5nZoveWLVn3fpDYhj84vgPZjwAm5Q
        37kUZ+hPkG5GRC4qBtXaXxO6EFXV5G+s7B0HLAxPre3HDUKqMEV8R0FXaE8wU6JezjCdOOo+KJr
        OhRfhnj5hElK0
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr6017472wrh.356.1630006838126;
        Thu, 26 Aug 2021 12:40:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx03/eQ8lgmsE2bT+LDzqvydNywb8x2w37h8HYfEYEsVbKsve6VGBDJGD7R+bXh6oEAsZ3oyg==
X-Received: by 2002:adf:d0cf:: with SMTP id z15mr6017455wrh.356.1630006837992;
        Thu, 26 Aug 2021 12:40:37 -0700 (PDT)
Received: from krava.redhat.com ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id r12sm4234429wrv.96.2021.08.26.12.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:40:37 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 12/27] bpf: Factor out __bpf_trampoline_lookup function
Date:   Thu, 26 Aug 2021 21:39:07 +0200
Message-Id: <20210826193922.66204-13-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826193922.66204-1-jolsa@kernel.org>
References: <20210826193922.66204-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Separating out __bpf_trampoline_lookup function, so it can
be used from other places in following patches.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/trampoline.c | 26 ++++++++++++++++++++------
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index f44899c9698a..6dba43266e0b 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -70,23 +70,37 @@ static void bpf_trampoline_init(struct bpf_trampoline *tr, u64 key)
 		INIT_HLIST_HEAD(&tr->progs_hlist[i]);
 }
 
-static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
+static struct bpf_trampoline *__bpf_trampoline_lookup(u64 key)
 {
 	struct bpf_trampoline *tr;
 	struct hlist_head *head;
 
-	mutex_lock(&trampoline_mutex);
+	lockdep_assert_held(&trampoline_mutex);
+
 	head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
 	hlist_for_each_entry(tr, head, hlist) {
-		if (tr->key == key) {
-			refcount_inc(&tr->refcnt);
-			goto out;
-		}
+		if (tr->key == key)
+			return tr;
+	}
+	return NULL;
+}
+
+static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
+{
+	struct bpf_trampoline *tr;
+	struct hlist_head *head;
+
+	mutex_lock(&trampoline_mutex);
+	tr = __bpf_trampoline_lookup(key);
+	if (tr) {
+		refcount_inc(&tr->refcnt);
+		goto out;
 	}
 	tr = kzalloc(sizeof(*tr), GFP_KERNEL);
 	if (!tr)
 		goto out;
 	bpf_trampoline_init(tr, key);
+	head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
 	hlist_add_head(&tr->hlist, head);
 out:
 	mutex_unlock(&trampoline_mutex);
-- 
2.31.1


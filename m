Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7D023F8EF1
	for <lists+bpf@lfdr.de>; Thu, 26 Aug 2021 21:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243566AbhHZTlq (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 26 Aug 2021 15:41:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52809 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243598AbhHZTll (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 26 Aug 2021 15:41:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630006853;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zTg+zzMWSEF+4A/U8wBHLOWp42sO4HXvxr5/nTc1gqE=;
        b=a5KBP3g/y7ytiteK1wwxDfet8sMJpZGZvE1kAkPSqdLkjQpebBp7HYEwKOxmQWQfSrh0US
        GKIywtS750X+rWzi5nNa+9NWwkkpfxPpwSO3sYglB4nne0dWfnzxHXyIvUOW1M7St4BWRR
        thCytPk/yZ2MBOmTigW3ahnl6MaQzxo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-zoXyT7GLMUO3s08CKTOZOA-1; Thu, 26 Aug 2021 15:40:51 -0400
X-MC-Unique: zoXyT7GLMUO3s08CKTOZOA-1
Received: by mail-wm1-f72.google.com with SMTP id y188-20020a1c7dc5000000b002e80e0b2f87so4778221wmc.1
        for <bpf@vger.kernel.org>; Thu, 26 Aug 2021 12:40:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zTg+zzMWSEF+4A/U8wBHLOWp42sO4HXvxr5/nTc1gqE=;
        b=Fzu91QUauxKfXeITr57c2G3XPHRUDAsl/aQz43WFy4kSKVOaXc/rO4vJIX4laUnRtQ
         dYMuQTtM6zmDtxOZo52XIPRWFK/CB90H5xoAZ0zH6jPyAe0OIWCryAEQDF70PVGFdi/G
         UvTHoq4pvkJVY/ig51hbbV5DuYWapGkFVKbzYL+oBmFapGQVDhs0ZT4gXyKFJ9baWfki
         DSn3ywT5RiyGG4S9S2rpsQobN7vSYGFNLXP/NEidejwE4vN+JSynfj2bw3xUcIAxxuM1
         ADgzVXuMAORf7aVaK+lkGRmSHmfsbpxwHEPFrGpLsMk6DrTaF3SuKJn1Ye3vmusEeujJ
         wFPA==
X-Gm-Message-State: AOAM533hgRVxUT4wa8YltOSHIMub/gyQ+/zYq7xnsbBwvB7WcoHYkFxl
        Q/EdUg1JUwyu1X7IXT+xa6iJmfii0sjzr1WBIiMPw765qh+dEF0RLCzncVyrvzz+JghNNJOt2mn
        6fwhpDlUQfWrO
X-Received: by 2002:a5d:58e7:: with SMTP id f7mr6128985wrd.51.1630006850529;
        Thu, 26 Aug 2021 12:40:50 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwynqmTqvsqW9iFYuNy6lebFZRAvc8nScDmoxg+QC4b5TbglOriSiC/Vk1eFd/doAeMYyC5tA==
X-Received: by 2002:a5d:58e7:: with SMTP id f7mr6128964wrd.51.1630006850387;
        Thu, 26 Aug 2021 12:40:50 -0700 (PDT)
Received: from krava.redhat.com ([83.240.63.86])
        by smtp.gmail.com with ESMTPSA id h12sm3568113wmm.29.2021.08.26.12.40.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Aug 2021 12:40:50 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 14/27] bpf: Change bpf_trampoline_get to return error pointer
Date:   Thu, 26 Aug 2021 21:39:09 +0200
Message-Id: <20210826193922.66204-15-jolsa@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210826193922.66204-1-jolsa@kernel.org>
References: <20210826193922.66204-1-jolsa@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Changing bpf_trampoline_get to return error pointer,
so we can return other than ENOMEM error in following
changes.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
---
 kernel/bpf/syscall.c    | 4 ++--
 kernel/bpf/trampoline.c | 8 +++++---
 kernel/bpf/verifier.c   | 4 ++--
 3 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index e667d392cc33..537687664bdf 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2793,8 +2793,8 @@ static int bpf_tracing_prog_attach(struct bpf_prog *prog,
 			goto out_unlock;
 
 		tr = bpf_trampoline_get(key, &tgt_info);
-		if (!tr) {
-			err = -ENOMEM;
+		if (IS_ERR(tr)) {
+			err = PTR_ERR(tr);
 			goto out_unlock;
 		}
 	} else {
diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index 8aa0aca38b3a..c9794e9f24ee 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -97,8 +97,10 @@ static struct bpf_trampoline *bpf_trampoline_lookup(u64 key)
 		goto out;
 	}
 	tr = kzalloc(sizeof(*tr), GFP_KERNEL);
-	if (!tr)
+	if (!tr) {
+		tr = ERR_PTR(-ENOMEM);
 		goto out;
+	}
 	bpf_trampoline_init(tr, key);
 	head = &trampoline_table[hash_64(key, TRAMPOLINE_HASH_BITS)];
 	hlist_add_head(&tr->hlist, head);
@@ -508,8 +510,8 @@ struct bpf_trampoline *bpf_trampoline_get(u64 key,
 	struct bpf_trampoline *tr;
 
 	tr = bpf_trampoline_lookup(key);
-	if (!tr)
-		return NULL;
+	if (IS_ERR(tr))
+		return tr;
 
 	mutex_lock(&tr->mutex);
 	if (tr->func.addr)
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index e9e84adfb974..ad410e1222e4 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -13642,8 +13642,8 @@ static int check_attach_btf_id(struct bpf_verifier_env *env)
 
 	key = bpf_trampoline_compute_key(tgt_prog, prog->aux->attach_btf, btf_id);
 	tr = bpf_trampoline_get(key, &tgt_info);
-	if (!tr)
-		return -ENOMEM;
+	if (IS_ERR(tr))
+		return PTR_ERR(tr);
 
 	prog->aux->dst_trampoline = tr;
 	return 0;
-- 
2.31.1


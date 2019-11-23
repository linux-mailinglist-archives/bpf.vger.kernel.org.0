Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD59D107E24
	for <lists+bpf@lfdr.de>; Sat, 23 Nov 2019 12:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726774AbfKWLIE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 23 Nov 2019 06:08:04 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:33612 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbfKWLIE (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 23 Nov 2019 06:08:04 -0500
Received: by mail-lj1-f196.google.com with SMTP id t5so10302718ljk.0
        for <bpf@vger.kernel.org>; Sat, 23 Nov 2019 03:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RxMAa2iOTtRkT8FRp26jq90HvEuBpMxInXLJsam4QfI=;
        b=zEvKCwp4MD5fVn/qVLnuhj3XM5qQtwKvZlW8/6NuIcqkU4Aelr0fbGjNAinNAuc8ci
         5S9sxy7RZOEl3Qa23CjJczLIHvgyE7+srDhH28RqZkFzsIcrmOySleu9z926qlqlQBKg
         Mo8KaC1ODKyECgoqg7NROA0Ae6x3Tll/xJ7JA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RxMAa2iOTtRkT8FRp26jq90HvEuBpMxInXLJsam4QfI=;
        b=sTiv1al7W8j3+N3dKBBckVDr2hI4ZqMaXPrFBMs3FB3/TCQbspM/Nvfot6PUtRNpwx
         UuO3nK11JngnTgUZ/ECAhsVoaV/f1iTYvwYc2Bv50FKy3D0lP1/03i0KJyUOkWJwZZPQ
         Rx+FII06NPsgd5ewkcv4K3ZFUpJCfm1kY0W8BtgF5GyGlhUdbvCkS2cIaXoSxPEgXRl3
         3lPKB2rmnRaKP+KJvrqp/TJ/X8F2QydBjAd8SwyopmIuh8kt8NAXXCkWIPqWuiYFi1wa
         qAJmV1G/b1o37WHb6hSRb9Sww7bdYyBynHkQt651p2yxPt8zlA0fUMy83mUoEKleL3lL
         CGEw==
X-Gm-Message-State: APjAAAVJSr+BpUxVCsUVzKN6YrM6R9jWqLTUI+6f5HozcHA455a5wWue
        4QgP+lx7p0QgBj/NGXqPaaGral+0ReMAnw==
X-Google-Smtp-Source: APXvYqwlG8CLf+7V2QhjICvLInHx3UsWhjvsNoA2rW7NZbxfikD1k7W99cq2EGnGQEo6rak+gpC7yg==
X-Received: by 2002:a05:651c:87:: with SMTP id 7mr15911788ljq.20.1574507280699;
        Sat, 23 Nov 2019 03:08:00 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id q124sm596852ljq.93.2019.11.23.03.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Nov 2019 03:08:00 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next 5/8] bpf: Allow selecting reuseport socket from a SOCKMAP
Date:   Sat, 23 Nov 2019 12:07:48 +0100
Message-Id: <20191123110751.6729-6-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191123110751.6729-1-jakub@cloudflare.com>
References: <20191123110751.6729-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SOCKMAP now supports storing references to listening sockets. Nothing keeps
us from using it as an array of sockets to select from in SK_REUSEPORT
programs.

Whitelist the map type with the BPF helper for selecting socket. However,
impose a restriction that the selected socket needs to be a listening TCP
socket or a bound UDP socket (connected or not).

The only other map type that works with the BPF reuseport helper,
REUSEPORT_SOCKARRAY, has a corresponding check in its update operation
handler.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c | 6 ++++--
 net/core/filter.c     | 2 ++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index a0482e1c4a77..111a1eb543ab 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3685,7 +3685,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
 		    func_id != BPF_FUNC_map_delete_elem &&
-		    func_id != BPF_FUNC_msg_redirect_map)
+		    func_id != BPF_FUNC_msg_redirect_map &&
+		    func_id != BPF_FUNC_sk_select_reuseport)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_SOCKHASH:
@@ -3766,7 +3767,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 			goto error;
 		break;
 	case BPF_FUNC_sk_select_reuseport:
-		if (map->map_type != BPF_MAP_TYPE_REUSEPORT_SOCKARRAY)
+		if (map->map_type != BPF_MAP_TYPE_REUSEPORT_SOCKARRAY &&
+		    map->map_type != BPF_MAP_TYPE_SOCKMAP)
 			goto error;
 		break;
 	case BPF_FUNC_map_peek_elem:
diff --git a/net/core/filter.c b/net/core/filter.c
index 49ded4a7588a..e3fb77353248 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8723,6 +8723,8 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 	selected_sk = map->ops->map_lookup_elem(map, key);
 	if (!selected_sk)
 		return -ENOENT;
+	if (!sock_flag(selected_sk, SOCK_RCU_FREE))
+		return -EINVAL;
 
 	reuse = rcu_dereference(selected_sk->sk_reuseport_cb);
 	if (!reuse)
-- 
2.20.1


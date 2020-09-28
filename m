Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D9A127AA4C
	for <lists+bpf@lfdr.de>; Mon, 28 Sep 2020 11:09:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726749AbgI1JIo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 28 Sep 2020 05:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgI1JIl (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 28 Sep 2020 05:08:41 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E396AC0613CE
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 02:08:40 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id d4so258997wmd.5
        for <bpf@vger.kernel.org>; Mon, 28 Sep 2020 02:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YYDixzevsPSo33JShdSdjhqxSjI9v2Xq4t4tapCfmzk=;
        b=jDzH51beXtsOfB5MJ8R22hnkg/gHOPyEjJHn/cNlWySXVRMGQbYWwsdWvbwnpylU96
         qNnXBoEaiJ9O5z5cvIaA7m8treB9upUGgld7sgE8DnpVXHVLdWjhFObGqrNY622rBror
         XRyepHPi1wvGk3ZidPT2kuHpJACmt4KdJ758M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YYDixzevsPSo33JShdSdjhqxSjI9v2Xq4t4tapCfmzk=;
        b=YDeEVVbNUfmD/KnxvjWbu9J3yCpxk07ao+eFWkyyvkucXJcYZTCXqnnacmxL0bn6Bp
         go02J3sX3fZR9KRk2oY4OVgNrkRHYXchXMKQlFDsivsT6VwjXB8ISi8CAvjO43H2qXCc
         4OhYo0HPFftQMxV5tnwjdewQh7B4yUMW3kmQBfY6fw1vEoMC5DmQYsfdGn4jB+AsJAgG
         TZbY1+CJWji/QKLwCnYmKDyZtNO/6QXVAxUGlkgKT/YplyY+jIfc1IrfO8B9RWtfvCkA
         IPKv9tK+dQIMplFqkO4xAos8y0EsYwenVeMiZIg0JAtucZpYZhhr0GM6qapRcABmnonW
         zxVg==
X-Gm-Message-State: AOAM533bo62FUq1Np+OblW2vBu8wo6yCHyR9G6alAPrdB4HmLzkn9a2v
        F0UFtQqDXHHARwBmf3TSojgAbg==
X-Google-Smtp-Source: ABdhPJxdtoNKhBJ9GIZVyx52YPHnfv+PxBCZZGdgKrhy5lKN4eDkQz1btSLu2mu2K4OHcDptfzi5qw==
X-Received: by 2002:a7b:c210:: with SMTP id x16mr556653wmi.37.1601284119617;
        Mon, 28 Sep 2020 02:08:39 -0700 (PDT)
Received: from antares.lan (1.f.1.6.a.e.6.5.a.0.3.2.4.7.4.0.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:474:230a:56ea:61f1])
        by smtp.gmail.com with ESMTPSA id u13sm479631wrm.77.2020.09.28.02.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2020 02:08:39 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     kafai@fb.com, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Jakub Sitnicki <jakub@cloudflare.com>,
        Lorenz Bauer <lmb@cloudflare.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     kernel-team@cloudflare.com, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v2 1/4] bpf: sockmap: enable map_update_elem from bpf_iter
Date:   Mon, 28 Sep 2020 10:08:02 +0100
Message-Id: <20200928090805.23343-2-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200928090805.23343-1-lmb@cloudflare.com>
References: <20200928090805.23343-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Allow passing a pointer to a BTF struct sock_common* when updating
a sockmap or sockhash. Since BTF pointers can fault and therefore be
NULL at runtime we need to add an additional !sk check to
sock_map_update_elem. Since we may be passed a request or timewait
socket we also need to check sk_fullsock. Doing this allows calling
map_update_elem on sockmap from bpf_iter context, which uses
BTF pointers.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
---
 kernel/bpf/verifier.c | 2 +-
 net/core/sock_map.c   | 3 +++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index b25ba989c2dc..cc9c90d74dc1 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3943,7 +3943,7 @@ static int resolve_map_arg_type(struct bpf_verifier_env *env,
 	case BPF_MAP_TYPE_SOCKMAP:
 	case BPF_MAP_TYPE_SOCKHASH:
 		if (*arg_type == ARG_PTR_TO_MAP_VALUE) {
-			*arg_type = ARG_PTR_TO_SOCKET;
+			*arg_type = ARG_PTR_TO_BTF_ID_SOCK_COMMON;
 		} else {
 			verbose(env, "invalid arg_type for sockmap/sockhash\n");
 			return -EINVAL;
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index e1f05e3fa1d0..08bc86f51593 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -610,6 +610,9 @@ static int sock_map_update_elem(struct bpf_map *map, void *key,
 	struct sock *sk = (struct sock *)value;
 	int ret;
 
+	if (unlikely(!sk || !sk_fullsock(sk)))
+		return -EINVAL;
+
 	if (!sock_map_sk_is_suitable(sk))
 		return -EOPNOTSUPP;
 
-- 
2.25.1


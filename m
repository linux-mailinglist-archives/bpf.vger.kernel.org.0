Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7B9146D85
	for <lists+bpf@lfdr.de>; Thu, 23 Jan 2020 16:56:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729122AbgAWP4C (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 23 Jan 2020 10:56:02 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:44513 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728978AbgAWPzq (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 23 Jan 2020 10:55:46 -0500
Received: by mail-wr1-f66.google.com with SMTP id q10so3622542wrm.11
        for <bpf@vger.kernel.org>; Thu, 23 Jan 2020 07:55:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u4KFoB6a9qwjYl9Xl2tKGq3yT8GvqQL/hMZYCjtkwSE=;
        b=XIZ0t2firnJwZDGiFpo3qRPJwmPL+sk59Apcw44NoKZB8jcWy96AxAGbCs0xoewV1W
         3ZwdUhLI2Zfngd0mpbHm15ef7oK+D06bK6f/4zMz5nSO38Hz2esHhGTKMDAbhIC9mywJ
         ya+vIz29nbOivK9nxi+2Di+liw/PkkcFHqqdE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u4KFoB6a9qwjYl9Xl2tKGq3yT8GvqQL/hMZYCjtkwSE=;
        b=jldEC7MRHxkA6hSofKCSwOt/2OccRLskXLaDE4mnTzMV6tNB0AHlQYrkxwQBbNI5EV
         hGFSICvEpcXweu4Yo9dPGU+0qB1Fuxnv2uHj8lcfSMckQiCTjbUyNYRhbmbKMH8HeKoI
         YHZXMdG72b1yOC7vg11COXztZSDlxcI/GVXxLQd1x3CcDYq26ffnsgt5H3nlRtKBnYX3
         9Yn49rOGMjeTGDIiehmaM6Q68bkIk2MEIARNlO7mzLB37VvEiIxQj34O9/HBs94OpSEo
         X5J/jmTwSe2eBTkpDfKgVA6FYv+7lHPkoZU7Lcc3zxqBsRBprKUDQIPkIWG55Yp1BeEJ
         Qwfw==
X-Gm-Message-State: APjAAAVqMRILVbVu7L0ETlh3fMTgcPxPpynFoSclr0OOylQZlvgzLfuo
        v4ER6h+XjHYnclijzYdzmbHeNahc7gG97w==
X-Google-Smtp-Source: APXvYqyAzTzBoJ/lvxUan6wwQSO2i+JsYs6Ilo5GAFeLFG98vbKUzo9/aCgBqojxIBQqOQ5oYoJdTA==
X-Received: by 2002:adf:82a7:: with SMTP id 36mr18697182wrc.203.1579794943565;
        Thu, 23 Jan 2020 07:55:43 -0800 (PST)
Received: from cloudflare.com ([176.221.114.230])
        by smtp.gmail.com with ESMTPSA id j12sm3793264wrw.54.2020.01.23.07.55.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jan 2020 07:55:43 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Martin Lau <kafai@fb.com>
Subject: [PATCH bpf-next v4 06/12] bpf, sockmap: Don't set up sockmap progs for listening sockets
Date:   Thu, 23 Jan 2020 16:55:28 +0100
Message-Id: <20200123155534.114313-7-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200123155534.114313-1-jakub@cloudflare.com>
References: <20200123155534.114313-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Now that sockmap can hold listening sockets, when setting up the psock we
will (i) grab references to verdict/parser progs, and (2) override socket
upcalls sk_data_ready and sk_write_space.

We cannot redirect to listening sockets so we don't need to link the socket
to the BPF progs, but more importantly we don't want the listening socket
to have overridden upcalls because they would get inherited by child
sockets cloned from it.

Introduce a separate initialization path for listening sockets that does
not change the upcalls and ignores the BPF progs.

Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 45 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 38 insertions(+), 7 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 97bdceb29f09..2ff545e04f6e 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -228,6 +228,30 @@ static int sock_map_link(struct bpf_map *map, struct sk_psock_progs *progs,
 	return ret;
 }
 
+static int sock_map_link_no_progs(struct bpf_map *map, struct sock *sk)
+{
+	struct sk_psock *psock;
+	int ret;
+
+	psock = sk_psock_get_checked(sk);
+	if (IS_ERR(psock))
+		return PTR_ERR(psock);
+
+	if (psock) {
+		tcp_bpf_reinit(sk);
+		return 0;
+	}
+
+	psock = sk_psock_init(sk, map->numa_node);
+	if (!psock)
+		return -ENOMEM;
+
+	ret = tcp_bpf_init(sk);
+	if (ret < 0)
+		sk_psock_put(sk, psock);
+	return ret;
+}
+
 static void sock_map_free(struct bpf_map *map)
 {
 	struct bpf_stab *stab = container_of(map, struct bpf_stab, map);
@@ -330,6 +354,12 @@ static int sock_map_get_next_key(struct bpf_map *map, void *key, void *next)
 	return 0;
 }
 
+/* Is sock in a state that allows redirecting from/into it? */
+static bool sock_map_redirect_okay(const struct sock *sk)
+{
+	return sk->sk_state != TCP_LISTEN;
+}
+
 static int sock_map_update_common(struct bpf_map *map, u32 idx,
 				  struct sock *sk, u64 flags)
 {
@@ -352,7 +382,14 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 	if (!link)
 		return -ENOMEM;
 
-	ret = sock_map_link(map, &stab->progs, sk);
+	/* Only sockets we can redirect into/from in BPF need to hold
+	 * refs to parser/verdict progs and have their sk_data_ready
+	 * and sk_write_space callbacks overridden.
+	 */
+	if (sock_map_redirect_okay(sk))
+		ret = sock_map_link(map, &stab->progs, sk);
+	else
+		ret = sock_map_link_no_progs(map, sk);
 	if (ret < 0)
 		goto out_free;
 
@@ -419,12 +456,6 @@ static bool sock_hash_sk_is_suitable(const struct sock *sk)
 				      TCPF_SYN_RECV);
 }
 
-/* Is sock in a state that allows redirecting into it? */
-static bool sock_map_redirect_okay(const struct sock *sk)
-{
-	return sk->sk_state != TCP_LISTEN;
-}
-
 static int sock_map_update_elem(struct bpf_map *map, void *key,
 				void *value, u64 flags)
 {
-- 
2.24.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DCAC81454C0
	for <lists+bpf@lfdr.de>; Wed, 22 Jan 2020 14:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgAVNGD (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 22 Jan 2020 08:06:03 -0500
Received: from mail-lf1-f42.google.com ([209.85.167.42]:40577 "EHLO
        mail-lf1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729180AbgAVNGD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 22 Jan 2020 08:06:03 -0500
Received: by mail-lf1-f42.google.com with SMTP id i23so5267723lfo.7
        for <bpf@vger.kernel.org>; Wed, 22 Jan 2020 05:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VRgRB2ljZfV1WxhjTOkSW60w5swwoglu+a2B/D/6emY=;
        b=mgMYo1H350o+nTcxuOrQqt02hak6PUBK4/mlFaq3RDDokB76peByXSdO3q2jI8m3IK
         oBTM7W3bE+Sdaz3wv1hu5KlqtqjMecBUFp6jT/DUZyMw5dkfBklNSQQOD6CG9vPnB5Nc
         8b6NyUkDXoyeK4a3cH3UZQ4dgMwdKsMPdOV5M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VRgRB2ljZfV1WxhjTOkSW60w5swwoglu+a2B/D/6emY=;
        b=OQ2FpgomTx6tt7B0hp0Gwc/YdMey0n43fiA9cs2BlACnm6+H1OA/Nzl32BEv/MF0GO
         AhSyXZjDfXKSw9WmEMPSjNMTUNQZWpljr1TVBlkpF+1T+DHZuIiJJiPL8QwkHqtFmLIk
         WHGGLdikfwB51YcCecWOrxr2Y32WWnGpubAVh2h8K5Svi5qWvsByGQ5ZdGifx3+nOtKP
         Z4P/OVIkNJknHxUfGwh9OBd/fKJOO3dLshBZd6gVJjXaF/aHP8Kz91nXP0nHO60qUwpc
         z5tDtukiUTkxNMqXKmd7umG9BcyKfrfDYyUvzypsjHtcrw/AQXfOAXC8EdirBpfaXRFb
         +klg==
X-Gm-Message-State: APjAAAWnPo17TMWas70y3zXmocgsItDF+0c4YyWxGuhPjCXO8XKSJOLC
        np4js5sxFjzCcWviRJoigg+Zqr57XVv7Iw==
X-Google-Smtp-Source: APXvYqxSc/haUwmnAtsxlqChnJo8vQYoZGluCalrGFU2UxLzjVARm3hXGQGxX0P7Q2ZpP+S7Z2+EXQ==
X-Received: by 2002:ac2:47ec:: with SMTP id b12mr1759949lfp.162.1579698360356;
        Wed, 22 Jan 2020 05:06:00 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id s4sm20770881ljd.94.2020.01.22.05.05.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jan 2020 05:05:59 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Lorenz Bauer <lmb@cloudflare.com>, Martin Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 06/12] bpf, sockmap: Don't set up sockmap progs for listening sockets
Date:   Wed, 22 Jan 2020 14:05:43 +0100
Message-Id: <20200122130549.832236-7-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200122130549.832236-1-jakub@cloudflare.com>
References: <20200122130549.832236-1-jakub@cloudflare.com>
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

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 34 +++++++++++++++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 97bdceb29f09..439f1e0b995e 100644
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
@@ -352,7 +376,15 @@ static int sock_map_update_common(struct bpf_map *map, u32 idx,
 	if (!link)
 		return -ENOMEM;
 
-	ret = sock_map_link(map, &stab->progs, sk);
+	/* Only established or almost established sockets leaving
+	 * SYN_RECV state need to hold refs to parser/verdict progs
+	 * and have their sk_data_ready and sk_write_space callbacks
+	 * overridden.
+	 */
+	if (sk->sk_state == TCP_LISTEN)
+		ret = sock_map_link_no_progs(map, sk);
+	else
+		ret = sock_map_link(map, &stab->progs, sk);
 	if (ret < 0)
 		goto out_free;
 
-- 
2.24.1


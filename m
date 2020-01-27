Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1EEB014A440
	for <lists+bpf@lfdr.de>; Mon, 27 Jan 2020 13:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727430AbgA0Mzx (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 27 Jan 2020 07:55:53 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:36464 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727107AbgA0Mzx (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 27 Jan 2020 07:55:53 -0500
Received: by mail-lf1-f67.google.com with SMTP id f24so6120492lfh.3
        for <bpf@vger.kernel.org>; Mon, 27 Jan 2020 04:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5TGuskX+oyn2N1Rk9g6dmvecHvmmmyDhj23M/Fkvjgg=;
        b=KQcwpFLG/ZHJOfTM92ZqiG1GpCpTpXpHMY5kRLZgJN1LmFENnjTfMa42j0ItSlzjHK
         0Wlb9ssei8E9O8GI5BgsokiVejTtDotcjY4Owyop8NNjUs8NDX117B76+y+9Hya6z4jg
         rJdzhpxZQwolAnutz/422dt+0o0k382ZKkwi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5TGuskX+oyn2N1Rk9g6dmvecHvmmmyDhj23M/Fkvjgg=;
        b=h02dAcGAfb9yOOKTBO+BTeqbPj319bR0kVg2W8/Bi/woJ2qaJAKLTjS6WsNV6kmTjR
         NRr91OndqR6GHtBDieDYIVbKHBaCRvg0ivzZay9LeEHUxjTTriJ3B9EouB2jiuyXQur0
         nnt10Yt4/qbOh5buUlkS+8/o2eUgHqu0bQI9ajghKc9Ldd/A0VEhaa8Q7Mba+KFYgFV+
         uLbuPUsLOClg2AR0wFWwAFDw+OvmWiK8ycoO937s8cUw1qj9ODCfM+pgdPtJTVlBUBdG
         HSn+rjMI9t7GUVuOzk9FWC7Jm2nu1tlh2ZD8gDQYr0OsaxpKZ/8paJGaprn/BPL1SzR7
         jIrQ==
X-Gm-Message-State: APjAAAVZ9ra6TtAXd3DLNkE/x268CKzVLbPREnB8QdQnf+TEVHrbXD8e
        NZQzj6tW+ZEEl8IwFYr5j7PfBN6GWKTLeg==
X-Google-Smtp-Source: APXvYqwd98CLxvniYU1iMrO/eKFVwc4OJa7cGL9c40EQ+JeNNkN//0q3KkwjaOrO++j9BizNVFA2GQ==
X-Received: by 2002:a19:97:: with SMTP id 145mr8031233lfa.98.1580129750599;
        Mon, 27 Jan 2020 04:55:50 -0800 (PST)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id u25sm1362858ljj.70.2020.01.27.04.55.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2020 04:55:50 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        John Fastabend <john.fastabend@gmail.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v5 09/12] bpf: Allow selecting reuseport socket from a SOCKMAP
Date:   Mon, 27 Jan 2020 13:55:31 +0100
Message-Id: <20200127125534.137492-10-jakub@cloudflare.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200127125534.137492-1-jakub@cloudflare.com>
References: <20200127125534.137492-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

SOCKMAP now supports storing references to listening sockets. Nothing keeps
us from using it as an array of sockets to select from in BPF reuseport
programs. Whitelist the map type with the bpf_sk_select_reuseport helper.

The restriction that the socket has to be a member of a reuseport group
still applies. Socket from a SOCKMAP that does not have sk_reuseport_cb set
is not a valid target and we signal it with -EINVAL.

This lifts the restriction that SOCKARRAY imposes, if SOCKMAP is used with
reuseport BPF, the listening sockets can exist in more than one BPF map at
the same time.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 kernel/bpf/verifier.c |  6 ++++--
 net/core/filter.c     | 15 ++++++++++-----
 2 files changed, 14 insertions(+), 7 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1cc945daa9c8..9def066e6847 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -3693,7 +3693,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
 		if (func_id != BPF_FUNC_sk_redirect_map &&
 		    func_id != BPF_FUNC_sock_map_update &&
 		    func_id != BPF_FUNC_map_delete_elem &&
-		    func_id != BPF_FUNC_msg_redirect_map)
+		    func_id != BPF_FUNC_msg_redirect_map &&
+		    func_id != BPF_FUNC_sk_select_reuseport)
 			goto error;
 		break;
 	case BPF_MAP_TYPE_SOCKHASH:
@@ -3774,7 +3775,8 @@ static int check_map_func_compatibility(struct bpf_verifier_env *env,
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
index 792e3744b915..6922f1a55383 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -8620,6 +8620,7 @@ struct sock *bpf_run_sk_reuseport(struct sock_reuseport *reuse, struct sock *sk,
 BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 	   struct bpf_map *, map, void *, key, u32, flags)
 {
+	bool is_sockarray = map->map_type == BPF_MAP_TYPE_REUSEPORT_SOCKARRAY;
 	struct sock_reuseport *reuse;
 	struct sock *selected_sk;
 
@@ -8628,12 +8629,16 @@ BPF_CALL_4(sk_select_reuseport, struct sk_reuseport_kern *, reuse_kern,
 		return -ENOENT;
 
 	reuse = rcu_dereference(selected_sk->sk_reuseport_cb);
-	if (!reuse)
-		/* selected_sk is unhashed (e.g. by close()) after the
-		 * above map_lookup_elem().  Treat selected_sk has already
-		 * been removed from the map.
+	if (!reuse) {
+		/* reuseport_array has only sk with non NULL sk_reuseport_cb.
+		 * The only (!reuse) case here is - the sk has already been
+		 * unhashed (e.g. by close()), so treat it as -ENOENT.
+		 *
+		 * Other maps (e.g. sock_map) do not provide this guarantee and
+		 * the sk may never be in the reuseport group to begin with.
 		 */
-		return -ENOENT;
+		return is_sockarray ? -ENOENT : -EINVAL;
+	}
 
 	if (unlikely(reuse->reuseport_id != reuse_kern->reuseport_id)) {
 		struct sock *sk;
-- 
2.24.1


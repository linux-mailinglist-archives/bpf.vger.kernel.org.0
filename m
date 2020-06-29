Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACE6720E11F
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 23:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730094AbgF2Uw1 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 16:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731369AbgF2TN1 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:13:27 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8708C008644
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:49 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id g75so14757471wme.5
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oFfXGUJ5tvK97U58LQIn0NKX672onJPqp41bujeJCXE=;
        b=h7oYUfvrC3xot+cEiTG2VjZ8Kso5bLdXrVOsqfSBjHbv97QeHI2E/CM9cBddbLeZ02
         n/xOu90a6kB91tMUIC5lYjilqbTFwjNGrDn3vNIj+QvQc0uAv/e1HqHQj3mGShOmYUG4
         v1ajfZJdem+3WCV033nM3guNV4FKC1sKEBtfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oFfXGUJ5tvK97U58LQIn0NKX672onJPqp41bujeJCXE=;
        b=A76h49zkwCDa/YvCyZFnArn3XEA2w3I2qrTz8rTELtjqWmRTbHQODlzTLrN+qleARo
         ooDXj9i2M+0eotE88GAIntcSgqynhwMdtBSYMCc/PAhCp2wc23lCDuUjUovr700hd2x2
         SlLvgYkLpHlzGyhH52ASUgtVsuDqGUqgB3+8ITamLWy61F9h8vio8LTOSHArN4P8PRzX
         rOnK1TmYeYRdrW2wcwr2RHruyMgP8Z58VQ7HfILC9pish1kVU35CmBVCNMeZiSJhBKXK
         3W1eNu0LMpJ5B8wxfCeMr5kBSh0Lxaq9z/aFtyPPuA0aapot3Phlotpg1pkdHNfxjRaX
         2AwA==
X-Gm-Message-State: AOAM532I5BVvgniQuAYypHirP8q/tHubniclX7Jcc/YD4ZDKxciV7Wva
        mGNQjCFDvPsHdb4xAcWWO8vZkmDtoZ9FMA==
X-Google-Smtp-Source: ABdhPJwSR0cXrAQoAqc1/x0C7VFPJzbnrYCX47BAGZ0Ed9MBKo5K/KYizablzaeC3OdK1ndLrGm5Dw==
X-Received: by 2002:a7b:c250:: with SMTP id b16mr8783236wmj.30.1593424788562;
        Mon, 29 Jun 2020 02:59:48 -0700 (PDT)
Received: from antares.lan (d.b.7.8.9.b.a.6.9.b.2.7.e.d.5.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:55de:72b9:6ab9:87bd])
        by smtp.gmail.com with ESMTPSA id y7sm42565369wrt.11.2020.06.29.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 02:59:47 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, sdf@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2 4/6] bpf: sockmap: require attach_bpf_fd when detaching a program
Date:   Mon, 29 Jun 2020 10:56:28 +0100
Message-Id: <20200629095630.7933-5-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629095630.7933-1-lmb@cloudflare.com>
References: <20200629095630.7933-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The sockmap code currently ignores the value of attach_bpf_fd when
detaching a program. This is contrary to the usual behaviour of
checking that attach_bpf_fd represents the currently attached
program.

Ensure that attach_bpf_fd is indeed the currently attached
program. It turns out that all sockmap selftests already do this,
which indicates that this is unlikely to cause breakage.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: 604326b41a6f ("bpf, sockmap: convert to generic sk_msg interface")
---
 include/linux/bpf.h   | 13 +++++++++--
 include/linux/skmsg.h | 13 +++++++++++
 kernel/bpf/syscall.c  |  2 +-
 net/core/sock_map.c   | 50 ++++++++++++++++++++++++++++++++++++++-----
 4 files changed, 70 insertions(+), 8 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index 5d0506f46f24..6c3160fbae0b 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1555,13 +1555,16 @@ static inline void bpf_map_offload_map_free(struct bpf_map *map)
 #endif /* CONFIG_NET && CONFIG_BPF_SYSCALL */
 
 #if defined(CONFIG_BPF_STREAM_PARSER)
-int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog, u32 which);
+int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
+			 struct bpf_prog *old, u32 which);
 int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog);
+int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
 void sock_map_unhash(struct sock *sk);
 void sock_map_close(struct sock *sk, long timeout);
 #else
 static inline int sock_map_prog_update(struct bpf_map *map,
-				       struct bpf_prog *prog, u32 which)
+				       struct bpf_prog *prog,
+				       struct bpf_prog *old, u32 which)
 {
 	return -EOPNOTSUPP;
 }
@@ -1571,6 +1574,12 @@ static inline int sock_map_get_from_fd(const union bpf_attr *attr,
 {
 	return -EINVAL;
 }
+
+static inline int sock_map_prog_detach(const union bpf_attr *attr,
+				       enum bpf_prog_type ptype)
+{
+	return -EOPNOTSUPP;
+}
 #endif /* CONFIG_BPF_STREAM_PARSER */
 
 #if defined(CONFIG_INET) && defined(CONFIG_BPF_SYSCALL)
diff --git a/include/linux/skmsg.h b/include/linux/skmsg.h
index 08674cd14d5a..1e9ed840b9fc 100644
--- a/include/linux/skmsg.h
+++ b/include/linux/skmsg.h
@@ -430,6 +430,19 @@ static inline void psock_set_prog(struct bpf_prog **pprog,
 		bpf_prog_put(prog);
 }
 
+static inline int psock_replace_prog(struct bpf_prog **pprog,
+				     struct bpf_prog *prog,
+				     struct bpf_prog *old)
+{
+	if (cmpxchg(pprog, old, prog) != old)
+		return -ENOENT;
+
+	if (old)
+		bpf_prog_put(old);
+
+	return 0;
+}
+
 static inline void psock_progs_drop(struct sk_psock_progs *progs)
 {
 	psock_set_prog(&progs->msg_parser, NULL);
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index c0ec572f056c..77340045b071 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2893,7 +2893,7 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 	switch (ptype) {
 	case BPF_PROG_TYPE_SK_MSG:
 	case BPF_PROG_TYPE_SK_SKB:
-		return sock_map_get_from_fd(attr, NULL);
+		return sock_map_prog_detach(attr, ptype);
 	case BPF_PROG_TYPE_LIRC_MODE2:
 		return lirc_prog_detach(attr);
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index db45c1453d39..119f52a99dc1 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -77,7 +77,42 @@ int sock_map_get_from_fd(const union bpf_attr *attr, struct bpf_prog *prog)
 	map = __bpf_map_get(f);
 	if (IS_ERR(map))
 		return PTR_ERR(map);
-	ret = sock_map_prog_update(map, prog, attr->attach_type);
+	ret = sock_map_prog_update(map, prog, NULL, attr->attach_type);
+	fdput(f);
+	return ret;
+}
+
+int sock_map_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
+{
+	u32 ufd = attr->target_fd;
+	struct bpf_prog *prog;
+	struct bpf_map *map;
+	struct fd f;
+	int ret;
+
+	if (attr->attach_flags || attr->replace_bpf_fd)
+		return -EINVAL;
+
+	f = fdget(ufd);
+	map = __bpf_map_get(f);
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	prog = bpf_prog_get(attr->attach_bpf_fd);
+	if (IS_ERR(prog)) {
+		ret = PTR_ERR(prog);
+		goto put_map;
+	}
+
+	if (prog->type != ptype) {
+		ret = -EINVAL;
+		goto put_prog;
+	}
+
+	ret = sock_map_prog_update(map, NULL, prog, attr->attach_type);
+put_prog:
+	bpf_prog_put(prog);
+put_map:
 	fdput(f);
 	return ret;
 }
@@ -1212,27 +1247,32 @@ static struct sk_psock_progs *sock_map_progs(struct bpf_map *map)
 }
 
 int sock_map_prog_update(struct bpf_map *map, struct bpf_prog *prog,
-			 u32 which)
+			 struct bpf_prog *old, u32 which)
 {
 	struct sk_psock_progs *progs = sock_map_progs(map);
+	struct bpf_prog **pprog;
 
 	if (!progs)
 		return -EOPNOTSUPP;
 
 	switch (which) {
 	case BPF_SK_MSG_VERDICT:
-		psock_set_prog(&progs->msg_parser, prog);
+		pprog = &progs->msg_parser;
 		break;
 	case BPF_SK_SKB_STREAM_PARSER:
-		psock_set_prog(&progs->skb_parser, prog);
+		pprog = &progs->skb_parser;
 		break;
 	case BPF_SK_SKB_STREAM_VERDICT:
-		psock_set_prog(&progs->skb_verdict, prog);
+		pprog = &progs->skb_verdict;
 		break;
 	default:
 		return -EOPNOTSUPP;
 	}
 
+	if (old)
+		return psock_replace_prog(pprog, prog, old);
+
+	psock_set_prog(pprog, prog);
 	return 0;
 }
 
-- 
2.25.1


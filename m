Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C94726FC36
	for <lists+bpf@lfdr.de>; Fri, 18 Sep 2020 14:13:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726438AbgIRMMo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 18 Sep 2020 08:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgIRMMk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 18 Sep 2020 08:12:40 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D21EC06174A
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2020 05:12:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id lo4so7774289ejb.8
        for <bpf@vger.kernel.org>; Fri, 18 Sep 2020 05:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares-net.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LwJh2Jg+llItfiPMDTwpwTSCiYeiFLD+g/KxngTUH6c=;
        b=oVYgTbtocYLwTQ1yDb79D0yPhf6zQUR/yDffS2xPh2VZAMUm+h9otvXx+Qz3g1VutF
         uYV1VSEospDv5SxawHAukf9jwaZWhX5AsRc9SiXfuaf/dqhr/XOGK8LSOhXV9u1HwCM9
         HpZO+So0GJCh1GXsLz1CINYFnd6HCHcVCaz8v/JdqMV8Rc3rF/MoRk5SPBpZq4UBp84z
         vyWOb/tlbC5hT3nvNLsI33uipWVEAH/07E5sFXPpy7C1KkgyQEkWb3Sly9MP6wTfK1eU
         yNcLP/hncGwkNh9YxByvD59pl/F4s/R0amoOTK8ZpGJGaJK5ohOb3qHjAHwufNqJgeRc
         fBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LwJh2Jg+llItfiPMDTwpwTSCiYeiFLD+g/KxngTUH6c=;
        b=Idumvyqf2RbhkfPwmuxybyV0SHwEuZH5cc9N4Ak+6adg+AzE1va+5FWr0r0REAmqBc
         MZc1uJ8fY5sXRU6Wy4r0I6KP+Eu+wWT1dpbOcOiM9pPgTs1h36p3IAaRKk7Xp0XQ+okm
         u15S0Yy+4T8WH99Zub5B+k1+YSeLcmyDl6U6yahbUK9fJE0AV107tZBNs9hffcA/tDVS
         Y67o5efYmwrrkC7NLl+cmiPPDzoxr4bENzTwsThqmAhldGDWm0dlNxAbZtnR62862K9B
         Jrnf5mF9OwOHcyYseEkVNjGxbOlJUsMdSym213t0ttfeUnSjdlhqk/tiFZOU2O0Fw49O
         NiTA==
X-Gm-Message-State: AOAM530SDTvcJ7kx89tcyOVCW0wyTZxxXXPKne2p4qwcQ42K382Ou0qD
        pM8rnogvz/9s+o9/3bcE5c2+Ezp9YHSt9FVW
X-Google-Smtp-Source: ABdhPJzxhHDww5D+4AHJjLfbQSVVgWBHsh3RCLB87VoDO8t06KBqikrizZl6BvuqtoFiTvWkxR6yqQ==
X-Received: by 2002:a17:906:cb92:: with SMTP id mf18mr37269577ejb.485.1600431158958;
        Fri, 18 Sep 2020 05:12:38 -0700 (PDT)
Received: from localhost.localdomain ([87.66.33.240])
        by smtp.gmail.com with ESMTPSA id h64sm2084555edd.50.2020.09.18.05.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2020 05:12:38 -0700 (PDT)
From:   Nicolas Rybowski <nicolas.rybowski@tessares.net>
To:     Mat Martineau <mathew.j.martineau@linux.intel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>
Cc:     Nicolas Rybowski <nicolas.rybowski@tessares.net>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        mptcp@lists.01.org, linux-kernel@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf-next v3 2/5] mptcp: attach subflow socket to parent cgroup
Date:   Fri, 18 Sep 2020 14:10:41 +0200
Message-Id: <20200918121046.190240-2-nicolas.rybowski@tessares.net>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200918121046.190240-1-nicolas.rybowski@tessares.net>
References: <20200918121046.190240-1-nicolas.rybowski@tessares.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It has been observed that the kernel sockets created for the subflows
(except the first one) are not in the same cgroup as their parents.
That's because the additional subflows are created by kernel workers.

This is a problem with eBPF programs attached to the parent's
cgroup won't be executed for the children. But also with any other features
of CGroup linked to a sk.

This patch fixes this behaviour.

As the subflow sockets are created by the kernel, we can't use
'mem_cgroup_sk_alloc' because of the current context being the one of the
kworker. This is why we have to do low level memcg manipulation, if
required.

Suggested-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Acked-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Mat Martineau <mathew.j.martineau@linux.intel.com>
Acked-by: Song Liu <songliubraving@fb.com>
Signed-off-by: Nicolas Rybowski <nicolas.rybowski@tessares.net>
---
 net/mptcp/subflow.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index e8cac2655c82..535a3f9f8cfc 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1130,6 +1130,30 @@ int __mptcp_subflow_connect(struct sock *sk, int ifindex,
 	return err;
 }
 
+static void mptcp_attach_cgroup(struct sock *parent, struct sock *child)
+{
+#ifdef CONFIG_SOCK_CGROUP_DATA
+	struct sock_cgroup_data *parent_skcd = &parent->sk_cgrp_data,
+				*child_skcd = &child->sk_cgrp_data;
+
+	/* only the additional subflows created by kworkers have to be modified */
+	if (cgroup_id(sock_cgroup_ptr(parent_skcd)) !=
+	    cgroup_id(sock_cgroup_ptr(child_skcd))) {
+#ifdef CONFIG_MEMCG
+		struct mem_cgroup *memcg = parent->sk_memcg;
+
+		mem_cgroup_sk_free(child);
+		if (memcg && css_tryget(&memcg->css))
+			child->sk_memcg = memcg;
+#endif /* CONFIG_MEMCG */
+
+		cgroup_sk_free(child_skcd);
+		*child_skcd = *parent_skcd;
+		cgroup_sk_clone(child_skcd);
+	}
+#endif /* CONFIG_SOCK_CGROUP_DATA */
+}
+
 int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 {
 	struct mptcp_subflow_context *subflow;
@@ -1150,6 +1174,9 @@ int mptcp_subflow_create_socket(struct sock *sk, struct socket **new_sock)
 
 	lock_sock(sf->sk);
 
+	/* the newly created socket has to be in the same cgroup as its parent */
+	mptcp_attach_cgroup(sk, sf->sk);
+
 	/* kernel sockets do not by default acquire net ref, but TCP timer
 	 * needs it.
 	 */
-- 
2.28.0


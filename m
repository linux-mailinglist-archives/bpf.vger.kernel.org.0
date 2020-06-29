Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A222220DFFD
	for <lists+bpf@lfdr.de>; Mon, 29 Jun 2020 23:55:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387450AbgF2Ult (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 29 Jun 2020 16:41:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731665AbgF2TOF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 29 Jun 2020 15:14:05 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C5C008642
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:47 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id g75so14757362wme.5
        for <bpf@vger.kernel.org>; Mon, 29 Jun 2020 02:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WNrIM4dcsIFFa/TMKUX5m3YQ7IwclaUW1fyoFX6Q5H4=;
        b=AHXsWajMq//TLV1k8Stl+KqWnSLsMef0v5BZU5IlDuNrJPkXg/tI2ORmsKo3SaY/bw
         oh+0tyL+aATOFwSft8u5dymB9XONEDqf93el7IKT4ZOIwblXipfEZgSFW8ZGRMErMeSt
         ZONKmMqN4kYwdHjTnGhkXBaEU7Dl1OZY3gN0A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WNrIM4dcsIFFa/TMKUX5m3YQ7IwclaUW1fyoFX6Q5H4=;
        b=DkrJunill6+u04RGwjje4cvI4Izae+k+6sSHSn74UDpiZf2Tt3Ph1n/sS/8NkURLAh
         WEc4knzbqwQ397RnjkNfjbl8EY6X0MkoDbjNBJuyPSJfIgy/wxbN0Lyi9Xoe8fH5PFkv
         ownO3w+zorH1oxbaxosnNVNaR+IZ4TNO6WahT8gy51k8oxomK3xR8PtJ3cykyfBSBX5L
         bNcfDe5TTCEKrePp9Hyx2kQHgPrDOLOjuwOOL04CEBFF5A7StbA2Y4bPZCZ6WkglNVQP
         4Q9xOvfM7X9Sc4qWmuh7JMoADxUGnHlx0+G0FfF1616jrGsxP4H/pWu8bDmmjfpLpmZR
         0cdg==
X-Gm-Message-State: AOAM531FNePftXa8Z5z5gSBNd/NSpEvo7KjgNCoM8VJtqrf1MlTNmyry
        ExIhOjWezOzvrWPeRczKaCdgng==
X-Google-Smtp-Source: ABdhPJz2C0r4l1cyQH7J1rM71i/sHYAWh73J/Pm7OFXcM0iXRQ9k3AXYi/+RLmuqZ6zDD7wAOkgxWg==
X-Received: by 2002:a7b:c4d8:: with SMTP id g24mr15135958wmk.127.1593424786074;
        Mon, 29 Jun 2020 02:59:46 -0700 (PDT)
Received: from antares.lan (d.b.7.8.9.b.a.6.9.b.2.7.e.d.5.5.f.f.6.2.a.5.a.7.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:7a5a:26ff:55de:72b9:6ab9:87bd])
        by smtp.gmail.com with ESMTPSA id y7sm42565369wrt.11.2020.06.29.02.59.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 02:59:45 -0700 (PDT)
From:   Lorenz Bauer <lmb@cloudflare.com>
To:     ast@kernel.org, daniel@iogearbox.net, sdf@google.com,
        jakub@cloudflare.com, john.fastabend@gmail.com
Cc:     kernel-team@cloudflare.com, bpf@vger.kernel.org,
        Lorenz Bauer <lmb@cloudflare.com>
Subject: [PATCH bpf v2 2/6] bpf: flow_dissector: check value of unused flags to BPF_PROG_DETACH
Date:   Mon, 29 Jun 2020 10:56:26 +0100
Message-Id: <20200629095630.7933-3-lmb@cloudflare.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200629095630.7933-1-lmb@cloudflare.com>
References: <20200629095630.7933-1-lmb@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Using BPF_PROG_DETACH on a flow dissector program supports neither
attach_flags nor attach_bpf_fd. Yet no value is enforced for them.

Enforce that attach_flags are zero, and require the current program
to be passed via attach_bpf_fd. This allows us to remove the check
for CAP_SYS_ADMIN, since userspace can now no longer remove
arbitrary flow dissector programs.

Signed-off-by: Lorenz Bauer <lmb@cloudflare.com>
Fixes: b27f7bb590ba ("flow_dissector: Move out netns_bpf prog callbacks")
---
 include/linux/bpf-netns.h  |  5 +++--
 kernel/bpf/net_namespace.c | 19 +++++++++++++++----
 kernel/bpf/syscall.c       |  4 +---
 3 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/bpf-netns.h b/include/linux/bpf-netns.h
index 4052d649f36d..47d5b0c708c9 100644
--- a/include/linux/bpf-netns.h
+++ b/include/linux/bpf-netns.h
@@ -33,7 +33,7 @@ int netns_bpf_prog_query(const union bpf_attr *attr,
 			 union bpf_attr __user *uattr);
 int netns_bpf_prog_attach(const union bpf_attr *attr,
 			  struct bpf_prog *prog);
-int netns_bpf_prog_detach(const union bpf_attr *attr);
+int netns_bpf_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype);
 int netns_bpf_link_create(const union bpf_attr *attr,
 			  struct bpf_prog *prog);
 #else
@@ -49,7 +49,8 @@ static inline int netns_bpf_prog_attach(const union bpf_attr *attr,
 	return -EOPNOTSUPP;
 }
 
-static inline int netns_bpf_prog_detach(const union bpf_attr *attr)
+static inline int netns_bpf_prog_detach(const union bpf_attr *attr,
+					enum bpf_prog_type ptype)
 {
 	return -EOPNOTSUPP;
 }
diff --git a/kernel/bpf/net_namespace.c b/kernel/bpf/net_namespace.c
index bf18eabeaea2..7216215990ed 100644
--- a/kernel/bpf/net_namespace.c
+++ b/kernel/bpf/net_namespace.c
@@ -286,7 +286,8 @@ static void netns_bpf_run_array_detach(struct net *net,
 
 /* Must be called with netns_bpf_mutex held. */
 static int __netns_bpf_prog_detach(struct net *net,
-				   enum netns_bpf_attach_type type)
+				   enum netns_bpf_attach_type type,
+				   struct bpf_prog *old)
 {
 	struct bpf_prog *attached;
 
@@ -295,7 +296,7 @@ static int __netns_bpf_prog_detach(struct net *net,
 		return -EINVAL;
 
 	attached = net->bpf.progs[type];
-	if (!attached)
+	if (!attached || attached != old)
 		return -ENOENT;
 	netns_bpf_run_array_detach(net, type);
 	net->bpf.progs[type] = NULL;
@@ -303,19 +304,29 @@ static int __netns_bpf_prog_detach(struct net *net,
 	return 0;
 }
 
-int netns_bpf_prog_detach(const union bpf_attr *attr)
+int netns_bpf_prog_detach(const union bpf_attr *attr, enum bpf_prog_type ptype)
 {
 	enum netns_bpf_attach_type type;
+	struct bpf_prog *prog;
 	int ret;
 
+	if (attr->target_fd)
+		return -EINVAL;
+
 	type = to_netns_bpf_attach_type(attr->attach_type);
 	if (type < 0)
 		return -EINVAL;
 
+	prog = bpf_prog_get_type(attr->attach_bpf_fd, ptype);
+	if (IS_ERR(prog))
+		return PTR_ERR(prog);
+
 	mutex_lock(&netns_bpf_mutex);
-	ret = __netns_bpf_prog_detach(current->nsproxy->net_ns, type);
+	ret = __netns_bpf_prog_detach(current->nsproxy->net_ns, type, prog);
 	mutex_unlock(&netns_bpf_mutex);
 
+	bpf_prog_put(prog);
+
 	return ret;
 }
 
diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index 8da159936bab..c0ec572f056c 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -2897,9 +2897,7 @@ static int bpf_prog_detach(const union bpf_attr *attr)
 	case BPF_PROG_TYPE_LIRC_MODE2:
 		return lirc_prog_detach(attr);
 	case BPF_PROG_TYPE_FLOW_DISSECTOR:
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		return netns_bpf_prog_detach(attr);
+		return netns_bpf_prog_detach(attr, ptype);
 	case BPF_PROG_TYPE_CGROUP_DEVICE:
 	case BPF_PROG_TYPE_CGROUP_SKB:
 	case BPF_PROG_TYPE_CGROUP_SOCK:
-- 
2.25.1


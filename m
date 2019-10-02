Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37E88C9004
	for <lists+bpf@lfdr.de>; Wed,  2 Oct 2019 19:34:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728383AbfJBReE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 2 Oct 2019 13:34:04 -0400
Received: from mail-pg1-f201.google.com ([209.85.215.201]:46299 "EHLO
        mail-pg1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbfJBReD (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 2 Oct 2019 13:34:03 -0400
Received: by mail-pg1-f201.google.com with SMTP id f11so44138pgn.13
        for <bpf@vger.kernel.org>; Wed, 02 Oct 2019 10:34:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=/VBWQDNKn3TcIxOb7t7vmD6iPumOa4yGB+aJzx52tYg=;
        b=DEk3iio1O9Gkhdd1Bper2FkWRUZzlO8B0LsCrwcIq8bYfHbGhyvnjf5yXAT7B8D4gL
         HNaGBOzgculbN+413WEAO1tmP96PUi2U4ZT4L5eX9LxfWyMMMUd+rHLqvU/C1Q5FwWGZ
         Ob/bbYycfhO1OwkeLul/bmuq+9roomEwUh9OxW0f2xEAUPRTWoyTH4ZD7rIYpxqY4vFC
         oFsNwFYtPtB3rG7UDUd0lwV3d37NRTH0dEVqpiH9onFHNaaWFMWxN6lzMsnTCA+j129N
         gdO/BhRpUrn4Esgtq//3GvkuCa1xj5AAD8qStgbiZZuwpQQbySlft5eFqCXHWjDC82Gw
         aZFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=/VBWQDNKn3TcIxOb7t7vmD6iPumOa4yGB+aJzx52tYg=;
        b=XZ1JrhjerN+L1CJWSr61eFYuz87m24jpVq2ToxbK2e0foGpo5zjHUompRFxkRFkfux
         vhbL4b61lAfv2yysSCE0p/qVod4BFdccnBPU1gg+ANuuQkeB+oLuVkMe12Ys2gwP7j33
         0m8NJQehWGEnqwZ6Q28E73HwApPMgdfzk5yAXi8XeNlJ8uRUJcMc6Ng31Fu57aKbBDg9
         zbXEt/Gqg7TDHVnuNAs1lEZYbQaAhnY94jH3wCGroN6X8T0bbCHOozmDnrydd5T3vnTj
         DIltILHoh1HJzDDUlRhQcCiGhQ5Nr9mYPeoiOtpiGN/zJPZIE65RZ6+BCgEGVjSzLwPH
         UGWQ==
X-Gm-Message-State: APjAAAVevI5DqltLbw1uSemH76bPrDrOliR9mN6MkSsfY2aQ38Jy1lrk
        5A1gwaM+GuK8BvQHAqUMsG6QYwY=
X-Google-Smtp-Source: APXvYqyglF8UNEdYS45EjThGZAdjDsmAiJEwYvzOjxuOTeUF0fFP+fCSQ5Sg1OkkXelUfa5xabRuhmU=
X-Received: by 2002:a63:40c7:: with SMTP id n190mr4900842pga.446.1570037642776;
 Wed, 02 Oct 2019 10:34:02 -0700 (PDT)
Date:   Wed,  2 Oct 2019 10:33:56 -0700
In-Reply-To: <20191002173357.253643-1-sdf@google.com>
Message-Id: <20191002173357.253643-2-sdf@google.com>
Mime-Version: 1.0
References: <20191002173357.253643-1-sdf@google.com>
X-Mailer: git-send-email 2.23.0.444.g18eeb5a265-goog
Subject: [PATCH bpf-next 1/2] bpf/flow_dissector: add mode to enforce global
 BPF flow dissector
From:   Stanislav Fomichev <sdf@google.com>
To:     netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     davem@davemloft.net, ast@kernel.org, daniel@iogearbox.net,
        Stanislav Fomichev <sdf@google.com>,
        Petar Penkov <ppenkov@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Always use init_net flow dissector BPF program if it's attached and fall
back to the per-net namespace one. Also, deny installing new programs if
there is already one attached to the root namespace.
Users can still detach their BPF programs, but can't attach any
new ones (-EPERM).

Cc: Petar Penkov <ppenkov@google.com>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/bpf/prog_flow_dissector.rst |  3 +++
 net/core/flow_dissector.c                 | 11 ++++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/bpf/prog_flow_dissector.rst b/Documentation/bpf/prog_flow_dissector.rst
index a78bf036cadd..4d86780ab0f1 100644
--- a/Documentation/bpf/prog_flow_dissector.rst
+++ b/Documentation/bpf/prog_flow_dissector.rst
@@ -142,3 +142,6 @@ BPF flow dissector doesn't support exporting all the metadata that in-kernel
 C-based implementation can export. Notable example is single VLAN (802.1Q)
 and double VLAN (802.1AD) tags. Please refer to the ``struct bpf_flow_keys``
 for a set of information that's currently can be exported from the BPF context.
+
+When BPF flow dissector is attached to the root network namespace (machine-wide
+policy), users can't override it in their child network namespaces.
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 7c09d87d3269..494e2016fe84 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -115,6 +115,11 @@ int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
 	struct bpf_prog *attached;
 	struct net *net;
 
+	if (rcu_access_pointer(init_net.flow_dissector_prog)) {
+		/* Can't override root flow dissector program */
+		return -EPERM;
+	}
+
 	net = current->nsproxy->net_ns;
 	mutex_lock(&flow_dissector_mutex);
 	attached = rcu_dereference_protected(net->flow_dissector_prog,
@@ -910,7 +915,11 @@ bool __skb_flow_dissect(const struct net *net,
 	WARN_ON_ONCE(!net);
 	if (net) {
 		rcu_read_lock();
-		attached = rcu_dereference(net->flow_dissector_prog);
+		attached =
+			rcu_dereference(init_net.flow_dissector_prog);
+
+		if (!attached)
+			attached = rcu_dereference(net->flow_dissector_prog);
 
 		if (attached) {
 			struct bpf_flow_keys flow_keys;
-- 
2.23.0.444.g18eeb5a265-goog


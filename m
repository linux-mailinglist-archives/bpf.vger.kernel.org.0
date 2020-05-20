Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 930A41DBB3F
	for <lists+bpf@lfdr.de>; Wed, 20 May 2020 19:23:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728159AbgETRXE (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 20 May 2020 13:23:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgETRXC (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 20 May 2020 13:23:02 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A79C061A0F
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 10:23:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id x20so4902949ejb.11
        for <bpf@vger.kernel.org>; Wed, 20 May 2020 10:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdoJULNF4ZOJn60TD6kq6HAcbNwe48XKEyzovvw9zBM=;
        b=NZdH7cfivutOeU4FSA3YHpO8Jv+24jr8nQan6NAgtMW8ZiRyjVMir7fkvhMc1XXsYR
         6ufQDdFSFcx4iNqVhx0RMnJVyFiSGyd+rN4ww7nmzsL/uiOZwvQEZvQr0Z08TxeBq1I1
         YJs9NV8bdYa8OEhl0mZ1WlwLQEHGF5y2+zQaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=hdoJULNF4ZOJn60TD6kq6HAcbNwe48XKEyzovvw9zBM=;
        b=eDhZ0PiSQmOkMkRxuYJbx2tdvWQG8SIsu9l4BqNjAOuCKpY/7vpAPVq1soxaoNtWTJ
         M31cwkG7j5UXGuLi14I5qBvQ60L+FYkvE/eLzGHvTCyWg4PgLUJN6aheorIESUu9hBS0
         kq4lMu7QMwABhLwsXcEcp++h4f8dP8X2QM5iA3fT/Op+XbtBJAjtcVvKYGCrYmxAx+p5
         F2LEv/I7HTAJ8vVJb/Sayp+XoJg+bz19sMhwFqKYAHaqp2AeV/RvdyUMC0zOl3eAfkS1
         6NIoSMMFBgPNuxe6yeE+ZheWqKKRvuZnSgISIHg9Sy0t7jdsuh1IP29DDE46hLqVsbnD
         5+Uw==
X-Gm-Message-State: AOAM532o8b5hBc/8M+6SxN6nhZ5JFe1ZXPvripHnHuM40iupZThFfM0L
        Eaj2P+wRmeYkb4DAaUPLaoG81xP+6z4=
X-Google-Smtp-Source: ABdhPJyhxTaCSaNGLZWJp3O4t2hlLyWcJoLESAkuHR0YN6yqSYE1E6EuiY8a3ngY9CI7PP0tluCGfA==
X-Received: by 2002:a17:906:580e:: with SMTP id m14mr76000ejq.447.1589995380253;
        Wed, 20 May 2020 10:23:00 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id j26sm2425763ejc.118.2020.05.20.10.22.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 10:22:59 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Petar Penkov <ppenkov@google.com>,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATCH bpf] flow_dissector: Drop BPF flow dissector prog ref on netns cleanup
Date:   Wed, 20 May 2020 19:22:58 +0200
Message-Id: <20200520172258.551075-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

When attaching a flow dissector program to a network namespace with
bpf(BPF_PROG_ATTACH, ...) we grab a reference to bpf_prog.

If netns gets destroyed while a flow dissector is still attached, and there
are no other references to the prog, we leak the reference and the program
remains loaded.

Leak can be reproduced by running flow dissector tests from selftests/bpf:

  # bpftool prog list
  # ./test_flow_dissector.sh
  ...
  selftests: test_flow_dissector [PASS]
  # bpftool prog list
  4: flow_dissector  name _dissect  tag e314084d332a5338  gpl
          loaded_at 2020-05-20T18:50:53+0200  uid 0
          xlated 552B  jited 355B  memlock 4096B  map_ids 3,4
          btf_id 4
  #

Fix it by detaching the flow dissector program when netns is going away.

Fixes: d58e468b1112 ("flow_dissector: implements flow dissector BPF hook")
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---

Discovered while working on bpf_link support for netns-attached progs.
Looks like bpf tree material so pushing it out separately.

-jkbs

 net/core/flow_dissector.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 3eff84824c8b..b6179cd20158 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -179,6 +179,27 @@ int skb_flow_dissector_bpf_prog_detach(const union bpf_attr *attr)
 	return 0;
 }
 
+static void __net_exit flow_dissector_pernet_pre_exit(struct net *net)
+{
+	struct bpf_prog *attached;
+
+	/* We don't lock the update-side because there are no
+	 * references left to this netns when we get called. Hence
+	 * there can be no attach/detach in progress.
+	 */
+	rcu_read_lock();
+	attached = rcu_dereference(net->flow_dissector_prog);
+	if (attached) {
+		RCU_INIT_POINTER(net->flow_dissector_prog, NULL);
+		bpf_prog_put(attached);
+	}
+	rcu_read_unlock();
+}
+
+static struct pernet_operations flow_dissector_pernet_ops __net_initdata = {
+	.pre_exit = flow_dissector_pernet_pre_exit,
+};
+
 /**
  * __skb_flow_get_ports - extract the upper layer ports and return them
  * @skb: sk_buff to extract the ports from
@@ -1827,6 +1848,8 @@ EXPORT_SYMBOL(flow_keys_basic_dissector);
 
 static int __init init_default_flow_dissectors(void)
 {
+	int err;
+
 	skb_flow_dissector_init(&flow_keys_dissector,
 				flow_keys_dissector_keys,
 				ARRAY_SIZE(flow_keys_dissector_keys));
@@ -1836,7 +1859,11 @@ static int __init init_default_flow_dissectors(void)
 	skb_flow_dissector_init(&flow_keys_basic_dissector,
 				flow_keys_basic_dissector_keys,
 				ARRAY_SIZE(flow_keys_basic_dissector_keys));
-	return 0;
+
+	err = register_pernet_subsys(&flow_dissector_pernet_ops);
+
+	WARN_ON(err);
+	return err;
 }
 
 core_initcall(init_default_flow_dissectors);
-- 
2.25.4


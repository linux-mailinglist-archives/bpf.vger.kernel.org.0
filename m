Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E95F7D0B91
	for <lists+bpf@lfdr.de>; Wed,  9 Oct 2019 11:43:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729906AbfJIJnR (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Oct 2019 05:43:17 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:44011 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729320AbfJIJnQ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 9 Oct 2019 05:43:16 -0400
Received: by mail-lf1-f67.google.com with SMTP id u3so1130807lfl.10
        for <bpf@vger.kernel.org>; Wed, 09 Oct 2019 02:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0j2L3ajtr8f5T2LURsPPM1afMbZ2goV4TcNShICbZSQ=;
        b=W9YHeVthJzhR4HyfoPcLhD9CSnipcswAriGhFBpykn/ovxMVHbFPFTRbmCIAUNQ66a
         wKU4TQjFKSG3aszs/iGL8R72+0jQwD0l5+ut9flSTiOtRhodzwbqbXSGMxwQo3mTMcAL
         d1XudqxVbl7JugGM5lMedzJYMSwlMzUiBA2OQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=0j2L3ajtr8f5T2LURsPPM1afMbZ2goV4TcNShICbZSQ=;
        b=IZuZn/qyMSPju9tIJHT3oOdAlYA2kIO2fQ1MZ7aD+KwF8BAO4cRG8/SRAawhI2f89a
         ODFXGz2cpVdtddMz1jOMKmUMdYQeBqe02YlHpMnIjgvGFC/IOcJ4F4uOE03gTd0Dl/HD
         U0EBTd4iAwm8RnExpSenpA+zhGqTd2JFd9tb82Q235+qs5EDOXDBqPedpzg4NaiyvM+L
         P/BRpvkPm2CG1ag2d3gsUx/RiPbmtLIdALREgWEzODnvo1N7P4BDiwU5GUemmeHtTw6w
         PGCP3WbMfF/fWzDt9W8MOrLOy40R+OSs67lqV12dYYXBM1BfkuHbMJSwIwLbzhjFhI0z
         UVwQ==
X-Gm-Message-State: APjAAAUp5E6wBI+NDMnW/wqEHR15dCvmlqJoBoRKABfmlb4q3EMwHEQb
        eh30Ug304Z68TzraOtw1MOyzxrEbKvawrw==
X-Google-Smtp-Source: APXvYqwCFfDRuxxuDQYQBTmvHTwUIEw2zA+6lQukKjPlA736WaGtj5Y8JFuSoOY7VZ7UaZv0yAyg9g==
X-Received: by 2002:ac2:42c7:: with SMTP id n7mr1475211lfl.138.1570614194457;
        Wed, 09 Oct 2019 02:43:14 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id v1sm344353lfe.34.2019.10.09.02.43.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2019 02:43:13 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Stanislav Fomichev <sdf@google.com>
Subject: [PATH bpf-next 1/2] flow_dissector: Allow updating the flow dissector program atomically
Date:   Wed,  9 Oct 2019 11:43:11 +0200
Message-Id: <20191009094312.15284-1-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: bpf-owner@vger.kernel.org
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

It is currently not possible to detach the flow dissector program and
attach a new one in an atomic fashion, that is with a single syscall.
Attempts to do so will be met with EEXIST error.

This makes updates to flow dissector program hard. Traffic steering that
relies on BPF-powered flow dissection gets disrupted while old program has
been already detached but the new one has not been attached yet.

There is also a window of opportunity to attach a flow dissector to a
non-root namespace while updating the root flow dissector, thus blocking
the update.

Lastly, the behavior is inconsistent with cgroup BPF programs, which can be
replaced with a single bpf(BPF_PROG_ATTACH, ...) syscall without any
restrictions.

Allow attaching a new flow dissector program when another one is already
present with a restriction that it can't be the same program.

Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/flow_dissector.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 6b4b88d1599d..dbf502c18656 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -128,6 +128,8 @@ int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
 		struct net *ns;
 
 		for_each_net(ns) {
+			if (ns == &init_net)
+				continue;
 			if (rcu_access_pointer(ns->flow_dissector_prog)) {
 				ret = -EEXIST;
 				goto out;
@@ -145,12 +147,14 @@ int skb_flow_dissector_bpf_prog_attach(const union bpf_attr *attr,
 
 	attached = rcu_dereference_protected(net->flow_dissector_prog,
 					     lockdep_is_held(&flow_dissector_mutex));
-	if (attached) {
-		/* Only one BPF program can be attached at a time */
-		ret = -EEXIST;
+	if (attached == prog) {
+		/* The same program cannot be attached twice */
+		ret = -EINVAL;
 		goto out;
 	}
 	rcu_assign_pointer(net->flow_dissector_prog, prog);
+	if (attached)
+		bpf_prog_put(attached);
 out:
 	mutex_unlock(&flow_dissector_mutex);
 	return ret;
-- 
2.20.1


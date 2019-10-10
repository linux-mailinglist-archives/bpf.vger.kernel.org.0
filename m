Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05CA2D3015
	for <lists+bpf@lfdr.de>; Thu, 10 Oct 2019 20:18:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbfJJSR7 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Oct 2019 14:17:59 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42126 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfJJSR6 (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Oct 2019 14:17:58 -0400
Received: by mail-lj1-f195.google.com with SMTP id y23so7163815lje.9
        for <bpf@vger.kernel.org>; Thu, 10 Oct 2019 11:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0j2L3ajtr8f5T2LURsPPM1afMbZ2goV4TcNShICbZSQ=;
        b=rRE99pFtR8yCFCv5a6NZSu4SQKXEN73dkubVtttI6dITCxYqEmyQ+6hYsU1jX0SqXM
         WgCz3P3kGFQjBgauXYHYsfbNBfUW3NCetdNMPawDxXMWZH4Yo77PCKpjrWT03wtfVGHh
         b6wEYtbG1r6gEM3HhhZNqw7APRySuAEfPRNOI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0j2L3ajtr8f5T2LURsPPM1afMbZ2goV4TcNShICbZSQ=;
        b=GLNTvmqnBaUJvEy1vLJzNAdJTtfm9fe7UDVzl0Ej+ZATuo/Um/f1WsdzghQRSox9t8
         bWAvYa+kzBmu48n0VVjgCb00XL8SlfgxZqR3gTAOWYYIPrJbGBGOmJTNlxoT0JQfJA6J
         Py2BvPa+B8yhxN3EnSWkZKiJP2uXFRSir+W1DBA/ZLWkwaGgxFQ+PKCVGQcFvK6ZxCfU
         WOMj6h38nlguMyOkPDq4BqxJlQsHx8jjpi73rsmDwCgR1Rm1aleDGfEpYMd9Du+38JnT
         tXjBTjK13Lun1k4JMh9eCs90HnKPJxaAVCwZa6lWRCkpAyikmbDIwy0GRq92o3k4+wG1
         0ndw==
X-Gm-Message-State: APjAAAXQsOmtqvqeTC+SoAFz4bisBEbn0POb8vqDpdwncEYEPUHzAjQq
        WamL+5bc/6qLvU9FkYILN3Xf1/yTE4z/Lw==
X-Google-Smtp-Source: APXvYqysi0u7yXUEnPQdzQ4YGwVSgMBfSYz4hLtkxwRRmjyCV3BXfed4Z7pRy5BEqQyUPYTyh88bmg==
X-Received: by 2002:a2e:9816:: with SMTP id a22mr3764394ljj.102.1570731475236;
        Thu, 10 Oct 2019 11:17:55 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id m8sm1488173lfa.67.2019.10.10.11.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2019 11:17:54 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH bpf-next v2 1/2] flow_dissector: Allow updating the flow dissector program atomically
Date:   Thu, 10 Oct 2019 20:17:49 +0200
Message-Id: <20191010181750.5964-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191010181750.5964-1-jakub@cloudflare.com>
References: <20191010181750.5964-1-jakub@cloudflare.com>
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


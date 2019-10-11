Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D528D3B1E
	for <lists+bpf@lfdr.de>; Fri, 11 Oct 2019 10:30:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfJKI3x (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 11 Oct 2019 04:29:53 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:42835 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726843AbfJKI3w (ORCPT <rfc822;bpf@vger.kernel.org>);
        Fri, 11 Oct 2019 04:29:52 -0400
Received: by mail-lf1-f65.google.com with SMTP id c195so6402793lfg.9
        for <bpf@vger.kernel.org>; Fri, 11 Oct 2019 01:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wDme/K188djfYly/+Kr3bSId7Q+cO3Z3bkh0WCcZWRU=;
        b=yqjcsrWkk1QyfwuJS1YtfcUwzv3tMM28T4b9Bubfe+a31qt8peh9lpedQOGHWMdinI
         BeICfxRVkdJJerZUXFRDKJhmD0dmHK+olmKKz/sGRjBKprszgSsZOoftzH0S0ckQybD2
         c8HDgb2pkdMjD0DFoEmHTPTCQLIYraoCRIXko=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wDme/K188djfYly/+Kr3bSId7Q+cO3Z3bkh0WCcZWRU=;
        b=mo/pI7cI6oz+nO7TnHFglgv2Ks9+OeaEI/L5QC/1JSAtOW3Nyz9tS2NTpH6ky2hm3g
         9ahx64Gyui/K6j6Ghyk5EbZtKT3pVWxcvM3kxjfAD8i0ew+W3hyZBaFTW0NLrzpuYP2j
         mSB54y5VeWbfPCtr1TDOGcGWI49//JcFndQT7ZD6q+2jlij+GGREhis6JIraV4V/w7gS
         f6iRxX/qEE9iYP2DQaNuI32KJiu6VVKoQfFfEK2MLmH4ZqI4llelSJzWkie0jb2UEqLv
         24Bt6apvrF9EkSuen+gS32/QZndQ7bhyMu5583JO/57OSpk8I1gzUv1jGAIIFkPUrZLl
         Anzw==
X-Gm-Message-State: APjAAAX26huP2Zp4FGPefScSsruiVXvVSL6qTd95aee56rfiav50kTFQ
        pFkbz7/aBnjc712GJJkpFttQaeNCNwCj/w==
X-Google-Smtp-Source: APXvYqyu65Ad1932F6yGpn+BXiuOvlr/LPc+Y5FjVAAVH77Xz+0NyG3mIDKIlV+zNRuKlEU2dyfIqQ==
X-Received: by 2002:ac2:4215:: with SMTP id y21mr8172693lfh.85.1570782590380;
        Fri, 11 Oct 2019 01:29:50 -0700 (PDT)
Received: from cloudflare.com ([2a02:a310:c262:aa00:b35e:8938:2c2a:ba8b])
        by smtp.gmail.com with ESMTPSA id x76sm2266234ljb.81.2019.10.11.01.29.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Oct 2019 01:29:49 -0700 (PDT)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, kernel-team@cloudflare.com,
        Stanislav Fomichev <sdf@google.com>,
        Martin KaFai Lau <kafai@fb.com>
Subject: [PATCH bpf-next v3 1/2] flow_dissector: Allow updating the flow dissector program atomically
Date:   Fri, 11 Oct 2019 10:29:45 +0200
Message-Id: <20191011082946.22695-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191011082946.22695-1-jakub@cloudflare.com>
References: <20191011082946.22695-1-jakub@cloudflare.com>
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
Reviewed-by: Stanislav Fomichev <sdf@google.com>
Acked-by: Martin KaFai Lau <kafai@fb.com>
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


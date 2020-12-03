Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEEAF2CE0DC
	for <lists+bpf@lfdr.de>; Thu,  3 Dec 2020 22:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389329AbgLCVgz (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 3 Dec 2020 16:36:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:23268 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388093AbgLCVgy (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 3 Dec 2020 16:36:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607031327;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XeW+PrSGPFwf4qXKThBzV62+oNUX7du8v4rO75iY9HM=;
        b=J3IlGU+XF8H7kFMI2DBRlw3Ps/lfcZGB8fJCbVLJHKtjBddC7aZLCe0qspCbKTIXuRjBrc
        GuQ07WB7yKpzetL4H3w1Ep3tdNGEi76wjtU8UQkm8opVlH7FThZKjOSXqFjyWNjl4F51qf
        t9hVL2SYTj9D4DVK6rVNpQFXaFkr95g=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-58-isz-W0MEPnOGgwY0_4XrqQ-1; Thu, 03 Dec 2020 16:35:26 -0500
X-MC-Unique: isz-W0MEPnOGgwY0_4XrqQ-1
Received: by mail-qv1-f71.google.com with SMTP id f2so2823302qvb.7
        for <bpf@vger.kernel.org>; Thu, 03 Dec 2020 13:35:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=XeW+PrSGPFwf4qXKThBzV62+oNUX7du8v4rO75iY9HM=;
        b=RP6F2pRLTymod0DmWSSYlYj5+Je263ZDjR60n8tTTeY8TIgSrj58l/eI+VHrKGXScc
         YTNi/BLiLBVdDWp9OCNyqforDoY7Mi+6mwlHmEJDMNRIxhjOmJlg1I7QQaIYFMdkBNiZ
         i7cvPBh6Ew+tG+peZ+Mye8HRHfO6JnzDG+MJZWpSvgdvVFrGFGWs5RefpSR8Qc3/h89C
         zbMsH4LYUd3dFfwxJH+Bd/7mr1JqAp8jvoEWz839gfKR5sJGt5rUqPgNyvl32rHw3iXC
         h1ZZma/LKuUiPAeslTSMFSKEr4QKWDerzbB+iKDNvzyuiqN1cNBqT7J08D0k9rGycn6G
         V/BA==
X-Gm-Message-State: AOAM532d7v2XsvWKmhhxUzoXNCPlnMghqnl/C7ezz9joyDsJRiooAUZ8
        8fQNQLR+noITAatuubkE464E+Oi7aPTxj489T7N6APww99cMMjlaFbSnInrJsbvi5I3y8zxEwXL
        sj5fl7Cl8Xj6b
X-Received: by 2002:aed:3051:: with SMTP id 75mr5555403qte.64.1607031325029;
        Thu, 03 Dec 2020 13:35:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLduMaDaXPxJJZ7ytN1sVff2d9qoJUfQZ3hechVdcfKxQXqe9hByEvz/Mk4RWvgPMwMl8Z1g==
X-Received: by 2002:aed:3051:: with SMTP id 75mr5555379qte.64.1607031324842;
        Thu, 03 Dec 2020 13:35:24 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id z73sm2822101qkb.112.2020.12.03.13.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Dec 2020 13:35:23 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 711DC181CF8; Thu,  3 Dec 2020 22:35:20 +0100 (CET)
Subject: [PATCH bpf 3/7] netdevsim: Add debugfs toggle to reject BPF programs
 in verifier
From:   =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Alexei Starovoitov <ast@kernel.org>,
        Andrii Nakryiko <andriin@fb.com>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Romain Perier <romain.perier@gmail.com>,
        Allen Pais <apais@linux.microsoft.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Simon Horman <simon.horman@netronome.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Jiri Benc <jbenc@redhat.com>, oss-drivers@netronome.com,
        linux-omap@vger.kernel.org, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Date:   Thu, 03 Dec 2020 22:35:20 +0100
Message-ID: <160703132036.162669.7719186299991611592.stgit@toke.dk>
In-Reply-To: <160703131710.162669.9632344967082582016.stgit@toke.dk>
References: <160703131710.162669.9632344967082582016.stgit@toke.dk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

From: Toke Høiland-Jørgensen <toke@redhat.com>

This adds a new debugfs toggle ('bpf_bind_verifier_accept') that can be
used to make netdevsim reject BPF programs from being accepted by the
verifier. If this toggle (which defaults to true) is set to false,
nsim_bpf_verify_insn() will return EOPNOTSUPP on the last
instruction (after outputting the 'Hello from netdevsim' verifier message).

This makes it possible to check the verification callback in the driver
from test_offload.py in selftests, since the verifier now clears the
verifier log on a successful load, hiding the message from the driver.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/netdevsim/bpf.c       |   12 ++++++++++--
 drivers/net/netdevsim/netdevsim.h |    1 +
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/net/netdevsim/bpf.c b/drivers/net/netdevsim/bpf.c
index 85546664bdd5..90aafb56f140 100644
--- a/drivers/net/netdevsim/bpf.c
+++ b/drivers/net/netdevsim/bpf.c
@@ -63,15 +63,20 @@ static int
 nsim_bpf_verify_insn(struct bpf_verifier_env *env, int insn_idx, int prev_insn)
 {
 	struct nsim_bpf_bound_prog *state;
+	int ret = 0;
 
 	state = env->prog->aux->offload->dev_priv;
 	if (state->nsim_dev->bpf_bind_verifier_delay && !insn_idx)
 		msleep(state->nsim_dev->bpf_bind_verifier_delay);
 
-	if (insn_idx == env->prog->len - 1)
+	if (insn_idx == env->prog->len - 1) {
 		pr_vlog(env, "Hello from netdevsim!\n");
 
-	return 0;
+		if (!state->nsim_dev->bpf_bind_verifier_accept)
+			ret = -EOPNOTSUPP;
+	}
+
+	return ret;
 }
 
 static int nsim_bpf_finalize(struct bpf_verifier_env *env)
@@ -595,6 +600,9 @@ int nsim_bpf_dev_init(struct nsim_dev *nsim_dev)
 			    &nsim_dev->bpf_bind_accept);
 	debugfs_create_u32("bpf_bind_verifier_delay", 0600, nsim_dev->ddir,
 			   &nsim_dev->bpf_bind_verifier_delay);
+	nsim_dev->bpf_bind_verifier_accept = true;
+	debugfs_create_bool("bpf_bind_verifier_accept", 0600, nsim_dev->ddir,
+			    &nsim_dev->bpf_bind_verifier_accept);
 	return 0;
 }
 
diff --git a/drivers/net/netdevsim/netdevsim.h b/drivers/net/netdevsim/netdevsim.h
index 827fc80f50a0..d1d329af3e61 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -190,6 +190,7 @@ struct nsim_dev {
 	struct bpf_offload_dev *bpf_dev;
 	bool bpf_bind_accept;
 	u32 bpf_bind_verifier_delay;
+	bool bpf_bind_verifier_accept;
 	struct dentry *ddir_bpf_bound_progs;
 	u32 prog_id_gen;
 	struct list_head bpf_bound_progs;


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF6EE2CED96
	for <lists+bpf@lfdr.de>; Fri,  4 Dec 2020 12:54:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730110AbgLDLxo (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 4 Dec 2020 06:53:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:32350 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730100AbgLDLxh (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 4 Dec 2020 06:53:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607082730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zcUyCpLjDCll9Y1/aRPnij3wIkLUo17xw68D8racrjQ=;
        b=jD1AwDVFyyYt1H51xp8v9YSB2emkASH+WXcgSRJNSP70gOsUgwQMeSY4AzFAxgWdizz2N2
        VS1XfkySghH9U4Qyd5uaxrEfEbqpUl4uK/j5dY06hlGlvxmNY6TDYJuUDjbqheMvg3WLmO
        /FA0ea6jIpicxgISMHg4amQdukPQdPk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-255-N84jRdMPOcSGN-jxK5NfrQ-1; Fri, 04 Dec 2020 06:52:09 -0500
X-MC-Unique: N84jRdMPOcSGN-jxK5NfrQ-1
Received: by mail-ej1-f71.google.com with SMTP id p18so1964630ejl.14
        for <bpf@vger.kernel.org>; Fri, 04 Dec 2020 03:52:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=zcUyCpLjDCll9Y1/aRPnij3wIkLUo17xw68D8racrjQ=;
        b=JbqC8IMdsOmRvxhfLEgYo6vkWIX3CA9JnUfZnLbRbbPjXepHeO7L3kiO1rD67/pZUk
         1tE3M8ZJpXeXD07ZYFT9yFkVKxaSgNtBlfI/4fyd8JeUmk7rwqwy/1/huqskQXqweaR6
         Bz8w8noZNuU5ERtdVaoc7a5pz0n6wbJjM80CxmsNEVi+963QLTqmuWCRwAqXshgRVEBP
         Ja+Ta6xuu6Irhog9wgQUKzeT0QpLz3MsguwdLebLenTtP0Nggnbxg5/CqNt77uFmvVuH
         xHfAQzGCN/s2RyJlDxyCkInHOoR75LY6aknw3v+XAU9S0khj+2PTAduZwU9rpygUMVNO
         im9A==
X-Gm-Message-State: AOAM531ZjP7plAdiOM78yQBm2Vh/z+h0aCy9hikzopvfwF4w6fiSGhZY
        +9PhIzbeQ5f+J/MAfft4dqQrqYzVOy4u92KBbt/P9z4HGFf9r+oJzI6zJEDSRlm3ifqXG3/hbVW
        +AVcWjyq0XbGg
X-Received: by 2002:a17:906:c087:: with SMTP id f7mr867452ejz.492.1607082727621;
        Fri, 04 Dec 2020 03:52:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzyEu66EqzxOKKZOgHPeEZHy0BRghOA3Syefi21Q3iNsPa4ViPa5k+lx+HXAso5qKcEfAQ7TQ==
X-Received: by 2002:a17:906:c087:: with SMTP id f7mr867421ejz.492.1607082727090;
        Fri, 04 Dec 2020 03:52:07 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id k18sm3200968edx.18.2020.12.04.03.52.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 03:52:06 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 845291843EB; Fri,  4 Dec 2020 12:52:05 +0100 (CET)
Subject: [PATCH bpf v2 3/7] netdevsim: Add debugfs toggle to reject BPF
 programs in verifier
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
Date:   Fri, 04 Dec 2020 12:52:05 +0100
Message-ID: <160708272546.192754.15754148712783914808.stgit@toke.dk>
In-Reply-To: <160708272217.192754.14019805999368221369.stgit@toke.dk>
References: <160708272217.192754.14019805999368221369.stgit@toke.dk>
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

Acked-by: Jakub Kicinski <kuba@kernel.org>
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
index 827fc80f50a0..c4e7ad2a1964 100644
--- a/drivers/net/netdevsim/netdevsim.h
+++ b/drivers/net/netdevsim/netdevsim.h
@@ -189,6 +189,7 @@ struct nsim_dev {
 	struct dentry *take_snapshot;
 	struct bpf_offload_dev *bpf_dev;
 	bool bpf_bind_accept;
+	bool bpf_bind_verifier_accept;
 	u32 bpf_bind_verifier_delay;
 	struct dentry *ddir_bpf_bound_progs;
 	u32 prog_id_gen;


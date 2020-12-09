Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC8B2D43D8
	for <lists+bpf@lfdr.de>; Wed,  9 Dec 2020 15:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgLIOFL (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 9 Dec 2020 09:05:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20827 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728561AbgLIN7M (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 9 Dec 2020 08:59:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607522265;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kd24Xn2dhH1zXrik2YwWPbY1PxQPNHf5kApUVpBXmAY=;
        b=IJAGsO81E4veA4+mcNed9v5VT2WIwRnzyy+S1VxgrQDtIhtX9v9BO1Pc8eZwh8oyRa/Q+D
        A6Qyo8o+yRKHTr/DAQQE5ylp6NKM9isVTLOv2E4SBq8+NcnQit9HFeuItL37LD9GiqRH+9
        b0MS1BgEKPfrz2POJhI+BPaINvumtoY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-579-zfTGR8r2PWe6B9gk_eZhog-1; Wed, 09 Dec 2020 08:57:44 -0500
X-MC-Unique: zfTGR8r2PWe6B9gk_eZhog-1
Received: by mail-wr1-f69.google.com with SMTP id o12so684467wrq.13
        for <bpf@vger.kernel.org>; Wed, 09 Dec 2020 05:57:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=kd24Xn2dhH1zXrik2YwWPbY1PxQPNHf5kApUVpBXmAY=;
        b=Wi81J9MrAFaVDHqqwcSkygbPJZYkCKn3lpScexg9JmqPaz7hH9CCR4pooOcK38447p
         U3Q/JoPRluL8lQBpdibqXcBmi2PJUb7ldkIHn8L+mva0QkKExuMr5J9w0UqslvSpMlqF
         EjdhuyiLRCLx3EGKt7WwXs0mVdHmTuTPPfeRNnQAwoluZion8PQdfwlF+rj63m058gR4
         jbLN/LDUhzlCFADhE9O9Uj8foGEU0IIVVMBDEyU8jdAmKtwx6Qfnv2C+nFbfjnyRRBuD
         84Hsp0SbGiOsq/zSi3C9e39jKBqDFZsNRmJuXho5J51W0cuUYlbB/+teTIbkss7HPt6N
         no1Q==
X-Gm-Message-State: AOAM532tED87kohqeSCs1L2DtrSAILn3YdXaDeVnnIp9TOKQ/MdPSqX5
        CrsOnPDdj9IH08uwKJDBgvhjIwAe4qccA3xH6pJd+ore92f0yUuRacKThDN6N8johBE6OU7CXtS
        2VMdgc/WVh2hp
X-Received: by 2002:a5d:4001:: with SMTP id n1mr2855253wrp.243.1607522262141;
        Wed, 09 Dec 2020 05:57:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyTQ7Uk28vLGW0s2/2La7n7Jg/vXtS+Afkm0tL++DHgekx0oS3piYNKxtvPgh94aQjFeEzjEw==
X-Received: by 2002:a5d:4001:: with SMTP id n1mr2855205wrp.243.1607522261420;
        Wed, 09 Dec 2020 05:57:41 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id q12sm3922546wmc.45.2020.12.09.05.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 05:57:40 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A9ED5180003; Wed,  9 Dec 2020 14:57:39 +0100 (CET)
Subject: [PATCH bpf v4 3/7] netdevsim: Add debugfs toggle to reject BPF
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
Date:   Wed, 09 Dec 2020 14:57:39 +0100
Message-ID: <160752225964.110217.12584017165318065332.stgit@toke.dk>
In-Reply-To: <160752225643.110217.4104692937165406635.stgit@toke.dk>
References: <160752225643.110217.4104692937165406635.stgit@toke.dk>
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

Fixes: 6f8a57ccf851 ("bpf: Make verifier log more relevant by default")
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


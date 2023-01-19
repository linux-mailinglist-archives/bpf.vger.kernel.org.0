Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A57674614
	for <lists+bpf@lfdr.de>; Thu, 19 Jan 2023 23:32:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230023AbjASWcp (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 19 Jan 2023 17:32:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjASWcJ (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 19 Jan 2023 17:32:09 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77313AA5E1
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:15:43 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id i16-20020a17090332d000b00194a7b146b2so2074455plr.20
        for <bpf@vger.kernel.org>; Thu, 19 Jan 2023 14:15:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EluN9RAO3/5jehFBTCxE9iis6r5nEDoqZCY8f6MRQ0c=;
        b=coDhL6VYgQSzRwgHAqJRrcjjR8MX6QQyphmjRgVcyygMt6NhH6yY97M8+f8YP9/BHW
         8qQJmSQHHMvWcLu568tFBGwDIEcvka642kOTYOWyTJxjaFBeaBdDCcJOKsnJ/d0VCXON
         gK0StuznNmVH0Sf4PWHymM7P+S5DwA7psoHSmhMh8HSmGJrWT27Py+Pepa8l/HR2JIpw
         orYUe19thSdjXIjpSYEo//2tEM83aZFGdW+h/1+TIVksYa5z1UDfXRrehozFDxF9wqvl
         I1DOIqSzmrSM9wCdAmZO3dO/TxpVpqMKssL1FFsvCpnjsTOA3Ck6PeqpzwNFKLBgJ9VX
         v5jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EluN9RAO3/5jehFBTCxE9iis6r5nEDoqZCY8f6MRQ0c=;
        b=itOU1Umjvgsvd6lfmKov+jXQ9DTYpx5ual32MYVmJN4w8dzMx4csuf4NMpXpVb6khO
         bj86SpUdmd2y/n6tZNzuw4AmRBcwsoB84k0lbPXEd7EW50V11N2ZcBOUfW0kqRuYt0b7
         eAGO1CqsYh1UyiGJmRnw0cv72v/iuU0btqf+iDDdbN8W6bfMZDd1Rj/i4Sj+ucHg0pSO
         UvBfCinuI/GuqM/0jP0SqAdxXQnTXA6OVF1ZX8pIkdfmf6MFVNf9QgoRcrd64EadUnNm
         eUnWtTAd+Tgea3ZuL4q6U7K8n95dqSxLMq/f1/E5MCUtf7GQRRFT1YuCY9sgtZ4biiYM
         jzQQ==
X-Gm-Message-State: AFqh2kquY0j+bws96hIgHT3B3b+YTA8ztqhyMeaxWWl/chk275Zxpg80
        +Je4EP+QcSYHZHq/UVANYFWHtOnZ4aZEucHnYnlAt/QHREA0pSdJOCluEBhwuhq3lDTVc7OK7pu
        m3W/CAgztkgy9DXgRC3mu5sHF11K3GEdw/hgSCTYEXuQ0sqAAGA==
X-Google-Smtp-Source: AMrXdXudGjQpd7lEynyR7gDEllPV9Fnd2xvrdsgsu/+ujzvVVHCfLARJibeKxsIHtr/nzz7/x3VIEoY=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a17:902:f7d6:b0:192:b0a0:788f with SMTP id
 h22-20020a170902f7d600b00192b0a0788fmr1136821plw.51.1674166542678; Thu, 19
 Jan 2023 14:15:42 -0800 (PST)
Date:   Thu, 19 Jan 2023 14:15:22 -0800
In-Reply-To: <20230119221536.3349901-1-sdf@google.com>
Mime-Version: 1.0
References: <20230119221536.3349901-1-sdf@google.com>
X-Mailer: git-send-email 2.39.0.246.g2a6d74b583-goog
Message-ID: <20230119221536.3349901-4-sdf@google.com>
Subject: [PATCH bpf-next v8 03/17] bpf: Move offload initialization into late_initcall
From:   Stanislav Fomichev <sdf@google.com>
To:     bpf@vger.kernel.org
Cc:     ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
        martin.lau@linux.dev, song@kernel.org, yhs@fb.com,
        john.fastabend@gmail.com, kpsingh@kernel.org, sdf@google.com,
        haoluo@google.com, jolsa@kernel.org,
        David Ahern <dsahern@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Willem de Bruijn <willemb@google.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Anatoly Burakov <anatoly.burakov@intel.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        Maryam Tahhan <mtahhan@redhat.com>, xdp-hints@xdp-project.net,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

So we don't have to initialize it manually from several paths.

Cc: John Fastabend <john.fastabend@gmail.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>
Cc: Jesper Dangaard Brouer <brouer@redhat.com>
Cc: Anatoly Burakov <anatoly.burakov@intel.com>
Cc: Alexander Lobakin <alexandr.lobakin@intel.com>
Cc: Magnus Karlsson <magnus.karlsson@gmail.com>
Cc: Maryam Tahhan <mtahhan@redhat.com>
Cc: xdp-hints@xdp-project.net
Cc: netdev@vger.kernel.org
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 kernel/bpf/offload.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/offload.c b/kernel/bpf/offload.c
index f5769a8ecbee..621e8738f304 100644
--- a/kernel/bpf/offload.c
+++ b/kernel/bpf/offload.c
@@ -56,7 +56,6 @@ static const struct rhashtable_params offdevs_params = {
 };
 
 static struct rhashtable offdevs;
-static bool offdevs_inited;
 
 static int bpf_dev_offload_check(struct net_device *netdev)
 {
@@ -72,8 +71,6 @@ bpf_offload_find_netdev(struct net_device *netdev)
 {
 	lockdep_assert_held(&bpf_devs_lock);
 
-	if (!offdevs_inited)
-		return NULL;
 	return rhashtable_lookup_fast(&offdevs, &netdev, offdevs_params);
 }
 
@@ -673,18 +670,6 @@ struct bpf_offload_dev *
 bpf_offload_dev_create(const struct bpf_prog_offload_ops *ops, void *priv)
 {
 	struct bpf_offload_dev *offdev;
-	int err;
-
-	down_write(&bpf_devs_lock);
-	if (!offdevs_inited) {
-		err = rhashtable_init(&offdevs, &offdevs_params);
-		if (err) {
-			up_write(&bpf_devs_lock);
-			return ERR_PTR(err);
-		}
-		offdevs_inited = true;
-	}
-	up_write(&bpf_devs_lock);
 
 	offdev = kzalloc(sizeof(*offdev), GFP_KERNEL);
 	if (!offdev)
@@ -710,3 +695,10 @@ void *bpf_offload_dev_priv(struct bpf_offload_dev *offdev)
 	return offdev->priv;
 }
 EXPORT_SYMBOL_GPL(bpf_offload_dev_priv);
+
+static int __init bpf_offload_init(void)
+{
+	return rhashtable_init(&offdevs, &offdevs_params);
+}
+
+late_initcall(bpf_offload_init);
-- 
2.39.0.246.g2a6d74b583-goog


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0720A3A835C
	for <lists+bpf@lfdr.de>; Tue, 15 Jun 2021 16:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbhFOO5V (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Tue, 15 Jun 2021 10:57:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45010 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231482AbhFOO5Q (ORCPT
        <rfc822;bpf@vger.kernel.org>); Tue, 15 Jun 2021 10:57:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623768911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ByKk7NdGTOHi1KbabnH0lRUOaQxO13c2A34mff7i6os=;
        b=SbAXjpPeYT+081YcqQbCEc8ZSMc37BXsmElgi/VtCLhuLZ1BA5ZoLFdcADbU4psCwKfhUg
        NJvwgHh8OUtY4ZU4OeHBEtLcaX2K0uc5Ykn8ir1LAcs9b7iwrx/IPSmE0KLNYWeFQli3cG
        t4pnlzYFJMLLFWspKn+KBlK/a8H9NCI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-97-nXq09iPYP2a4b3YRpnoBtA-1; Tue, 15 Jun 2021 10:55:10 -0400
X-MC-Unique: nXq09iPYP2a4b3YRpnoBtA-1
Received: by mail-ej1-f72.google.com with SMTP id q7-20020a1709063607b02903f57f85ac45so4635283ejb.15
        for <bpf@vger.kernel.org>; Tue, 15 Jun 2021 07:55:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ByKk7NdGTOHi1KbabnH0lRUOaQxO13c2A34mff7i6os=;
        b=oQuWDbb4fyeqMSwu/flRWV4eTdewq7BoZoCMknDsOYP4LIWENVAbGQ9491b6bjNnfR
         cTjfLHy03UjLZrA0N6rUElfFeXegoU0zheGHf9y/Ql0vpiVMvLa75tIIk0hGzn/tjxAa
         fqnySbIdekUoSFA/jWKzdFVA1XVSeFnHc4jvfvHeprE151N5OvHo5/FsqX+PGSpfwbee
         pIMK5E8O9iI5Ww1Os5+QkiDuQ5plvRpp9Ac4AfdJ5DlQnzJ6fjFF8cGOc3e8dHC0/EUB
         0J94jnP62PI8DEXlB6Av04Q+bavfCxOoCGl5o3kfpvHqPY6kK0XXALDgz8UDnje521AN
         BD0Q==
X-Gm-Message-State: AOAM531pXo1UezQlomZimiO3ScmtLHU1a1sj5VBsJ/q6Zx2jvgb9XFsg
        q3U1wC6rh42qYPNm6Rxd82o6//ffHmstTOaaJ5lQZ2MGNNhnjjVLlPc9cIFVP0+9FAIzH81Eo2Q
        AEEtmxipnV8zn
X-Received: by 2002:a17:906:1790:: with SMTP id t16mr21140737eje.203.1623768908968;
        Tue, 15 Jun 2021 07:55:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzO7NzkHVdn3I9zDxJvs+KHKQGP1gNNIkOvx0CUNjvYdIP8qMYlgja+FT1bnm1L0s5u+E2uKg==
X-Received: by 2002:a17:906:1790:: with SMTP id t16mr21140717eje.203.1623768908806;
        Tue, 15 Jun 2021 07:55:08 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id o20sm11770169eds.20.2021.06.15.07.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Jun 2021 07:55:06 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 28118180738; Tue, 15 Jun 2021 16:54:59 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     bpf@vger.kernel.org, netdev@vger.kernel.org
Cc:     Martin KaFai Lau <kafai@fb.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        Magnus Karlsson <magnus.karlsson@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>
Subject: [PATCH bpf-next v2 15/16] stmmac: remove rcu_read_lock() around XDP program invocation
Date:   Tue, 15 Jun 2021 16:54:54 +0200
Message-Id: <20210615145455.564037-16-toke@redhat.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210615145455.564037-1-toke@redhat.com>
References: <20210615145455.564037-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The stmmac driver has rcu_read_lock()/rcu_read_unlock() pairs around XDP
program invocations. However, the actual lifetime of the objects referred
by the XDP program invocation is longer, all the way through to the call to
xdp_do_flush(), making the scope of the rcu_read_lock() too small. This
turns out to be harmless because it all happens in a single NAPI poll
cycle (and thus under local_bh_disable()), but it makes the rcu_read_lock()
misleading.

Rather than extend the scope of the rcu_read_lock(), just get rid of it
entirely. With the addition of RCU annotations to the XDP_REDIRECT map
types that take bh execution into account, lockdep even understands this to
be safe, so there's really no reason to keep it around.

Cc: Giuseppe Cavallaro <peppe.cavallaro@st.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Jose Abreu <joabreu@synopsys.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index bf9fe25fed69..5dcc8a42abf9 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -4654,7 +4654,6 @@ static int stmmac_xdp_xmit_back(struct stmmac_priv *priv,
 	return res;
 }
 
-/* This function assumes rcu_read_lock() is held by the caller. */
 static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
 				 struct bpf_prog *prog,
 				 struct xdp_buff *xdp)
@@ -4662,6 +4661,9 @@ static int __stmmac_xdp_run_prog(struct stmmac_priv *priv,
 	u32 act;
 	int res;
 
+	/* This code is invoked within a single NAPI poll cycle and thus under
+	 * local_bh_disable(), which provides the needed RCU protection.
+	 */
 	act = bpf_prog_run_xdp(prog, xdp);
 	switch (act) {
 	case XDP_PASS:
@@ -4696,17 +4698,14 @@ static struct sk_buff *stmmac_xdp_run_prog(struct stmmac_priv *priv,
 	struct bpf_prog *prog;
 	int res;
 
-	rcu_read_lock();
-
 	prog = READ_ONCE(priv->xdp_prog);
 	if (!prog) {
 		res = STMMAC_XDP_PASS;
-		goto unlock;
+		goto out;
 	}
 
 	res = __stmmac_xdp_run_prog(priv, prog, xdp);
-unlock:
-	rcu_read_unlock();
+out:
 	return ERR_PTR(-res);
 }
 
@@ -4976,10 +4975,8 @@ static int stmmac_rx_zc(struct stmmac_priv *priv, int limit, u32 queue)
 		buf->xdp->data_end = buf->xdp->data + buf1_len;
 		xsk_buff_dma_sync_for_cpu(buf->xdp, rx_q->xsk_pool);
 
-		rcu_read_lock();
 		prog = READ_ONCE(priv->xdp_prog);
 		res = __stmmac_xdp_run_prog(priv, prog, buf->xdp);
-		rcu_read_unlock();
 
 		switch (res) {
 		case STMMAC_XDP_PASS:
-- 
2.31.1


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 508F64702A8
	for <lists+bpf@lfdr.de>; Fri, 10 Dec 2021 15:21:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241993AbhLJOYa (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Fri, 10 Dec 2021 09:24:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:43296 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241916AbhLJOY2 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Fri, 10 Dec 2021 09:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639146053;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ds6QTVDpGNxBUDXmv5+fit0E/Kglxb7++rnaRLkBHbc=;
        b=iE8RJDq0IYTExwhzi3PjLjI7o7eN6yvlLRcKz3s4sXDblojyF6K9gkRuBrjLVR3Xybo8s1
        EKCkA9alz/XP8sP5r8RCtIeKsMYz4//TqSeQWbcVAri27fFRIjtpY4Ic6SUi1YqpNLRka8
        CYPlwDAeURf8lFHSLUrDxFKpfmMuaDk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-318-v7GSMmmuOCamwfj2DK6WHg-1; Fri, 10 Dec 2021 09:20:51 -0500
X-MC-Unique: v7GSMmmuOCamwfj2DK6WHg-1
Received: by mail-ed1-f72.google.com with SMTP id l15-20020a056402124f00b003e57269ab87so8292074edw.6
        for <bpf@vger.kernel.org>; Fri, 10 Dec 2021 06:20:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ds6QTVDpGNxBUDXmv5+fit0E/Kglxb7++rnaRLkBHbc=;
        b=wLvPwWg/4MPzDfwuKvGN5RsuWgqoAoZaf5JVxH2qKe1J8srF7y27iJyChT17GSZbZS
         SkmUR9OYtC76HKM62NsfQg+E+1DZop/dfU8oBlaTOAmEyeCZYrnWHatQPqg5RjIGvfrN
         UQjXfV4noHQqYhBPLz5FOnHnrhcOrUGWsqqYVU/8h7/BupcuUTWLVff9NiKTw3aj4nrt
         4CSnpyms2Nm7hY3bKrL3YLt4Iu5HRGO6a7fLk6MV4iMSZGvbDGo3+VsomrgrLRgSK2WG
         SCItN1u4G9gZMuUAKbYWg545/0KkL3fRq3sMOYSOWcSU2NUe2d8k2uGr2woWS42eDJSd
         asEg==
X-Gm-Message-State: AOAM533hKKAUJXZetCuRnVNupSxM+SxBFdb3Fh8ZibhqGa2THnVFQ5Jc
        poM2MrQmEMow+mZkdBaCm0eh5ovXx7Tk+vdYp9xSZqXq8KpMB9ZTr7l8ZNJpSql+fiS8+TEKeOZ
        LlD49gI97H4qk
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr38974933edd.113.1639146048422;
        Fri, 10 Dec 2021 06:20:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyQPNrwxoHeJ1zBX5rusBPXaetulvlR989nHBOFQocmTs6DRCihkQMrxhf/jAXHz/ufPxjaLg==
X-Received: by 2002:a05:6402:5206:: with SMTP id s6mr38974881edd.113.1639146048057;
        Fri, 10 Dec 2021 06:20:48 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id qw27sm1690236ejc.101.2021.12.10.06.20.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Dec 2021 06:20:46 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 23013180496; Fri, 10 Dec 2021 15:20:46 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        John Fastabend <john.fastabend@gmail.com>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 2/8] page_pool: Store the XDP mem id
Date:   Fri, 10 Dec 2021 15:20:02 +0100
Message-Id: <20211210142008.76981-3-toke@redhat.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211210142008.76981-1-toke@redhat.com>
References: <20211210142008.76981-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Store the XDP mem ID inside the page_pool struct so it can be retrieved
later for use in bpf_prog_run().

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/page_pool.h | 9 +++++++--
 net/core/page_pool.c    | 4 +++-
 net/core/xdp.c          | 2 +-
 3 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index a71201854c41..6bc0409c4ffd 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -96,6 +96,7 @@ struct page_pool {
 	unsigned int frag_offset;
 	struct page *frag_page;
 	long frag_users;
+	u32 xdp_mem_id;
 
 	/*
 	 * Data structure for allocation side
@@ -170,9 +171,12 @@ bool page_pool_return_skb_page(struct page *page);
 
 struct page_pool *page_pool_create(const struct page_pool_params *params);
 
+struct xdp_mem_info;
+
 #ifdef CONFIG_PAGE_POOL
 void page_pool_destroy(struct page_pool *pool);
-void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *));
+void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
+			   struct xdp_mem_info *mem);
 void page_pool_release_page(struct page_pool *pool, struct page *page);
 void page_pool_put_page_bulk(struct page_pool *pool, void **data,
 			     int count);
@@ -182,7 +186,8 @@ static inline void page_pool_destroy(struct page_pool *pool)
 }
 
 static inline void page_pool_use_xdp_mem(struct page_pool *pool,
-					 void (*disconnect)(void *))
+					 void (*disconnect)(void *),
+					 struct xdp_mem_info *mem)
 {
 }
 static inline void page_pool_release_page(struct page_pool *pool,
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index fb5a90b9d574..2605467251f1 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -695,10 +695,12 @@ static void page_pool_release_retry(struct work_struct *wq)
 	schedule_delayed_work(&pool->release_dw, DEFER_TIME);
 }
 
-void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *))
+void page_pool_use_xdp_mem(struct page_pool *pool, void (*disconnect)(void *),
+			   struct xdp_mem_info *mem)
 {
 	refcount_inc(&pool->user_cnt);
 	pool->disconnect = disconnect;
+	pool->xdp_mem_id = mem->id;
 }
 
 void page_pool_destroy(struct page_pool *pool)
diff --git a/net/core/xdp.c b/net/core/xdp.c
index 5ddc29f29bad..143388c6d9dd 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -318,7 +318,7 @@ int xdp_rxq_info_reg_mem_model(struct xdp_rxq_info *xdp_rxq,
 	}
 
 	if (type == MEM_TYPE_PAGE_POOL)
-		page_pool_use_xdp_mem(allocator, mem_allocator_disconnect);
+		page_pool_use_xdp_mem(allocator, mem_allocator_disconnect, mem);
 
 	mutex_unlock(&mem_id_lock);
 
-- 
2.34.0


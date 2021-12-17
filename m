Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77D3A478144
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbhLQA2H (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:28:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:43334 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230409AbhLQA17 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 19:27:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639700877;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T3nIDYOO+rRc5zoyuXunRApKHafOUIvZTAc+3CBJQLQ=;
        b=YrK8VsTgcvQ8eA1QXImTELVknELbq+LxxIn+jVu9nObimc389EiJCmeOcZfFlxDoF0p9Af
        7koofmS8a8kk5YpKRJnocH5pkX62YbPJqV+sFLUNj7nyPVPmd8w9Q/584B9oXa1SpwLOR5
        4M49vVIeQbkIF8n+iuuRWuMcsFEqUxU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-6wYAxVW0MlSmwM5_knQnZA-1; Thu, 16 Dec 2021 19:27:56 -0500
X-MC-Unique: 6wYAxVW0MlSmwM5_knQnZA-1
Received: by mail-ed1-f72.google.com with SMTP id y11-20020a056402358b00b003f7ce63b89eso424777edc.3
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:27:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T3nIDYOO+rRc5zoyuXunRApKHafOUIvZTAc+3CBJQLQ=;
        b=cniWYg6ajA2Y7XHpPzrC6g3MNm4278pL+4rf9n9XsiyILEL7m3OtE7NUCnGKSy2jH8
         AtBpt9TfGo4gCD8BrM3IT9L3PIiJ9DWpu1I+MkCyz/GbRDOOdqLp8wxeByfpIR3HtUuk
         8GBgM38KWfyGTfutdqxZQhC1ExutaUJjm6FeawX0pc5hOZ0ObTsO1aMuoDgYGzfaqmEI
         PK6j6MkiKkQTZ2ucSrqN3XGpbC6f6Ia2ISSXBNr+/FcnEMBt3CLbizFuDkLEZqSkTr02
         UkeedaEKdwwU7ea3wK0gylsExCTnWzB9vcLJ7XD9gG61zlYAPt75OpMr5fU1/sv6LJWC
         BhNg==
X-Gm-Message-State: AOAM5325Me6DrwEBQVk8mUIcQtg6iFHw7KpcpoeugPLVHPUZ5K/1CyOR
        hlA5JOlBDi/lkcTvbqOXc5a0XCo27Muj7RqjNZjkRAJ1OYyBwpnUIsFyoTgEP+dCra5XPjnLqHv
        +f9069aP3XsRA
X-Received: by 2002:a17:907:1629:: with SMTP id hb41mr482809ejc.328.1639700874335;
        Thu, 16 Dec 2021 16:27:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxO+HdAsYuMrLFu4r+Mr03ngCfctVYjDhysHrYTxRYUGFcxmVfUx4djvNWN1DY/+sKdRkwemg==
X-Received: by 2002:a17:907:1629:: with SMTP id hb41mr482768ejc.328.1639700873280;
        Thu, 16 Dec 2021 16:27:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id qa31sm2255723ejc.33.2021.12.16.16.27.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:27:52 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 9AE50183565; Fri, 17 Dec 2021 01:27:51 +0100 (CET)
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
Subject: [PATCH bpf-next v4 3/7] page_pool: Store the XDP mem id
Date:   Fri, 17 Dec 2021 01:27:37 +0100
Message-Id: <20211217002741.146797-4-toke@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217002741.146797-1-toke@redhat.com>
References: <20211217002741.146797-1-toke@redhat.com>
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
index d807b6800a4a..79a805542d0f 100644
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
index f53786f6666d..7347d5c7dbe0 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -693,10 +693,12 @@ static void page_pool_release_retry(struct work_struct *wq)
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
index ac476c84a986..2901bb7004cc 100644
--- a/net/core/xdp.c
+++ b/net/core/xdp.c
@@ -320,7 +320,7 @@ static struct xdp_mem_allocator *__xdp_reg_mem_model(struct xdp_mem_info *mem,
 	}
 
 	if (type == MEM_TYPE_PAGE_POOL)
-		page_pool_use_xdp_mem(allocator, mem_allocator_disconnect);
+		page_pool_use_xdp_mem(allocator, mem_allocator_disconnect, mem);
 
 	mutex_unlock(&mem_id_lock);
 
-- 
2.34.1


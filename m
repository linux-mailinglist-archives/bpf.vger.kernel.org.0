Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9DF5478142
	for <lists+bpf@lfdr.de>; Fri, 17 Dec 2021 01:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbhLQA15 (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 16 Dec 2021 19:27:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23759 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230515AbhLQA14 (ORCPT
        <rfc822;bpf@vger.kernel.org>); Thu, 16 Dec 2021 19:27:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639700875;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3Ki68U13fAIOpoyGaq1fUYBlJK+4OgqlFUiLYU2tac=;
        b=avfOu6bcYVoZ1buiwLi2wHwELuEfcxLVIcKWoXqv6Jy8ruzZ3O9iUpz/i/IdeKIZ5ELt/+
        isKJPxSfzLN4CmGCUVPC9+n11OX/+d+HExOlsg+qjvPoZRZhX651pDovJBEEjPXywYIRbD
        SSoNB1Rf1zK06vczi9cLrDkciWy/irg=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-126-o6WnSPCzP3SSia_3g2RS2Q-1; Thu, 16 Dec 2021 19:27:54 -0500
X-MC-Unique: o6WnSPCzP3SSia_3g2RS2Q-1
Received: by mail-ed1-f71.google.com with SMTP id v19-20020a056402349300b003f7eba50675so399061edc.12
        for <bpf@vger.kernel.org>; Thu, 16 Dec 2021 16:27:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3Ki68U13fAIOpoyGaq1fUYBlJK+4OgqlFUiLYU2tac=;
        b=y6rgISjPmqT+ix5Tw9kTyoOP/kZd8uEaXmzsVvx9aa38Gec2HhnEFu/LkVvd9McnLx
         nBOe8JVBcAFFVhKeGjsmktAE5JpFPY8G0/9ppbSrAjzDcGaSuXaIQ5DLXX1W88AMljfe
         kLT55zmfCRjdPRywESoId+QaeTGvtfXkF5BQ0z/nC9BuO701EA2jb1WOpOhTyyTzfayr
         vM3b5Ua4gPRQJP9Mo9uvfmje1v5OY+DOo1hm3zKx4bJ3CXq5G9jM1sA9Q1Qz1Ri3746o
         pVxUQaUZForuDX7Z6DhUXeIQcroHtKVgCPFJSlAp+omMMg3pulAGXYgLtyv/vuTi47pw
         1XnA==
X-Gm-Message-State: AOAM530HlzVaOdV7Bm9Hhhu78JQsJ+JiUzX5IoFZENxi2k59xLwJGo58
        er7rg0CZZLJDyF2m54tpAsozcWeW+BK2jU/rlQpTNhHx9mcaVcThMcxqpTbtc2MgVJIXbk/ulqE
        Q2CJJ1eyP7+u7
X-Received: by 2002:a17:906:341a:: with SMTP id c26mr471656ejb.302.1639700873042;
        Thu, 16 Dec 2021 16:27:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKHOai6unhD8UR5nPo+rEXp2deOsYXISMTLqbeVHYC+xWegeb1evVA2Fp6N+YnLdqYCHnBpQ==
X-Received: by 2002:a17:906:341a:: with SMTP id c26mr471639ejb.302.1639700872779;
        Thu, 16 Dec 2021 16:27:52 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id 24sm2239649eje.52.2021.12.16.16.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 16:27:51 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 19EE918044B; Fri, 17 Dec 2021 01:27:51 +0100 (CET)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>
Cc:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next v4 2/7] page_pool: Add callback to init pages when they are allocated
Date:   Fri, 17 Dec 2021 01:27:36 +0100
Message-Id: <20211217002741.146797-3-toke@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211217002741.146797-1-toke@redhat.com>
References: <20211217002741.146797-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add a new callback function to page_pool that, if set, will be called every
time a new page is allocated. This will be used from bpf_test_run() to
initialise the page data with the data provided by userspace when running
XDP programs with redirect turned on.

Acked-by: John Fastabend <john.fastabend@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/page_pool.h | 2 ++
 net/core/page_pool.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index a4082406a003..d807b6800a4a 100644
--- a/include/net/page_pool.h
+++ b/include/net/page_pool.h
@@ -80,6 +80,8 @@ struct page_pool_params {
 	enum dma_data_direction dma_dir; /* DMA mapping direction */
 	unsigned int	max_len; /* max DMA sync memory size */
 	unsigned int	offset;  /* DMA addr offset */
+	void (*init_callback)(struct page *page, void *arg);
+	void *init_arg;
 };
 
 struct page_pool {
diff --git a/net/core/page_pool.c b/net/core/page_pool.c
index 1a6978427d6c..f53786f6666d 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -217,6 +217,8 @@ static void page_pool_set_pp_info(struct page_pool *pool,
 {
 	page->pp = pool;
 	page->pp_magic |= PP_SIGNATURE;
+	if (pool->p.init_callback)
+		pool->p.init_callback(page, pool->p.init_arg);
 }
 
 static void page_pool_clear_pp_info(struct page *page)
-- 
2.34.1


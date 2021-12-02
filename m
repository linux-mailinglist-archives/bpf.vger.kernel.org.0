Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5690C465A50
	for <lists+bpf@lfdr.de>; Thu,  2 Dec 2021 01:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354081AbhLBAHZ (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 1 Dec 2021 19:07:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41965 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1353972AbhLBAHU (ORCPT
        <rfc822;bpf@vger.kernel.org>); Wed, 1 Dec 2021 19:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638403438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U/VVqJ2rvS3+utXonMTYrBEeM8oEcGBPKY47J7o2598=;
        b=ZIrBbXLQzkUR1tCw85ITHY9ioVmhxkMZcnDRTL4lVdo+wHaW9kTeEO/qcK9ESgO3RJ42DY
        dFRqKsJ2mlxUHAandiF6PhkrxjRlN4wcH22xjoswoHQkkxaZN0hUclJk+G6sfpm0pb1kNt
        v5RT3z61IuwKAi/vCfA1DctTDGp25tA=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-248-DWk6WA1UM8-S5oYeyc96SQ-1; Wed, 01 Dec 2021 19:03:55 -0500
X-MC-Unique: DWk6WA1UM8-S5oYeyc96SQ-1
Received: by mail-ed1-f70.google.com with SMTP id eg20-20020a056402289400b003eb56fcf6easo21746330edb.20
        for <bpf@vger.kernel.org>; Wed, 01 Dec 2021 16:03:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=U/VVqJ2rvS3+utXonMTYrBEeM8oEcGBPKY47J7o2598=;
        b=UMrnjW0EqsD/02sxzQiR+o1aa0w5mpWjlsbcmB5d6bjV6dJY0Uq2391LzdmkN7Jxm4
         2eI084tk6Uzyn+hgGCTANNyOMrtYZK9EYA9c3CnPDre1kQP7+Fa9aFTo0J+ksnME35fg
         owq+uSE+I4D67Lyvv2vg2hDYFhtGbo3DpqAvpBOmtFdhWxdFb0l/Dne3i/bcNGFhJzkK
         3siuP2gCL9dp68Jzzx5IRUJrWlFIyFRISGgnoU1xhY4HQ+ea1l9uFJgEkw4LE0oyTw+h
         Yw/YaBhDKG/oE/6+IpJsHGJpOTJTwNf8uM3rRM8Csd/R+cS9rXHQrKFlr+C4Kyo1UWJ8
         7Cjw==
X-Gm-Message-State: AOAM531JnJTgrfdyJd09g3vA13AFpgA8p+gfXtXohowPdJTiU7tyX/Wa
        gZLzOPSQGgh2v/SNiqXjt/tItKQn8xI2cOgxLDromXzvMFT1vF29yzEZdW2N166eOZeWCQzZE6V
        RLE5ms5/FIdaa
X-Received: by 2002:a50:e102:: with SMTP id h2mr12566890edl.298.1638403433879;
        Wed, 01 Dec 2021 16:03:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZmHop5Ge6qSzyuP7uAvHY/UWbBwr7FnWuIOUcaT9S7FEQFAGTzcI+yRyeuOzgpn3YScDHQA==
X-Received: by 2002:a50:e102:: with SMTP id h2mr12566858edl.298.1638403433621;
        Wed, 01 Dec 2021 16:03:53 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id g1sm621476eje.105.2021.12.01.16.03.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 16:03:53 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id ABD431802A0; Thu,  2 Dec 2021 01:03:52 +0100 (CET)
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
Subject: [PATCH bpf-next 1/8] page_pool: Add callback to init pages when they are allocated
Date:   Thu,  2 Dec 2021 01:02:22 +0100
Message-Id: <20211202000232.380824-2-toke@redhat.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211202000232.380824-1-toke@redhat.com>
References: <20211202000232.380824-1-toke@redhat.com>
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

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/page_pool.h | 2 ++
 net/core/page_pool.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/net/page_pool.h b/include/net/page_pool.h
index 3855f069627f..a71201854c41 100644
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
index 9b60e4301a44..fb5a90b9d574 100644
--- a/net/core/page_pool.c
+++ b/net/core/page_pool.c
@@ -219,6 +219,8 @@ static void page_pool_set_pp_info(struct page_pool *pool,
 {
 	page->pp = pool;
 	page->pp_magic |= PP_SIGNATURE;
+	if (unlikely(pool->p.init_callback))
+		pool->p.init_callback(page, pool->p.init_arg);
 }
 
 static void page_pool_clear_pp_info(struct page *page)
-- 
2.34.0


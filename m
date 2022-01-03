Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 198884833E8
	for <lists+bpf@lfdr.de>; Mon,  3 Jan 2022 16:08:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiACPIY (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 3 Jan 2022 10:08:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49922 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232478AbiACPIY (ORCPT
        <rfc822;bpf@vger.kernel.org>); Mon, 3 Jan 2022 10:08:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641222503;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D3Ki68U13fAIOpoyGaq1fUYBlJK+4OgqlFUiLYU2tac=;
        b=CoPzRSwo8EjQ477LR/2Uu8rBSUnyzatk8vaSBaMXBuxhTZw3v8eo//Oi6OfnciyCosKr/T
        TlC2+Qhv2e/wx9PDqxREEquUiFuwU6GxmIGRpVeeeXXRszAFjc7rnV+tXt9M3FA3fqiLYv
        zcxAXOBhoMVd1ujq4SK0SXcvNoOx3Lw=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-230-lXmZUgVuPYS4l232RCgFMw-1; Mon, 03 Jan 2022 10:08:22 -0500
X-MC-Unique: lXmZUgVuPYS4l232RCgFMw-1
Received: by mail-ed1-f71.google.com with SMTP id z8-20020a056402274800b003f8580bfb99so23088552edd.11
        for <bpf@vger.kernel.org>; Mon, 03 Jan 2022 07:08:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D3Ki68U13fAIOpoyGaq1fUYBlJK+4OgqlFUiLYU2tac=;
        b=hEn4eO0UEyJOwHtzLLvVxDonx4fOTuVX165JzSUKwPatLCPKxa410q15hh1STbI018
         00WL7dwOCEPxvIBUGAOe2yHtlZNuz2FKgiSgP6a/1yd8sasa+aOjdhYnjQ9MDta+hTuB
         dqzPIvoudP1lLQyD0hLgepT9qsLXKdXItKjvda9z1r+ddreSVLczLMkhwI7tqS0xyyvh
         UKI9yCy2JMjeS+0dC8volAQZA8E8w2kNnoVLjI4g5g3jZmjMYYEvhLzk5Fc94SQA4XBH
         k/GZE1quoQzdM8xA2I7hGUevq8wuYA6Im6lVVPLH1rxdhJ8283gWULZJ1dKW8lSByFOS
         cJHA==
X-Gm-Message-State: AOAM530sSLcBStjZnMk4YMLestptXgfJrIXasFpM0Pog7VF7AYoliz+T
        k3NSNPF1Aj7uNjnQYG2I91cvEx+Ak3ifW+Z9qeqagef8P+ISNQwQAIhd5sWFi9o7870u0agbU+e
        xeFAef+iZb64A
X-Received: by 2002:a50:fb8f:: with SMTP id e15mr45665079edq.94.1641222501101;
        Mon, 03 Jan 2022 07:08:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw40DUBTwyZabag+7r29H+wWRf9tdHz4kapbP/ceiyCGc435YR4PdDcwqr/kdn9Kl4wgvniDQ==
X-Received: by 2002:a50:fb8f:: with SMTP id e15mr45665036edq.94.1641222500788;
        Mon, 03 Jan 2022 07:08:20 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id d17sm10701147ejd.217.2022.01.03.07.08.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:08:20 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id C3C26181F2B; Mon,  3 Jan 2022 16:08:19 +0100 (CET)
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
Subject: [PATCH bpf-next v5 2/7] page_pool: Add callback to init pages when they are allocated
Date:   Mon,  3 Jan 2022 16:08:07 +0100
Message-Id: <20220103150812.87914-3-toke@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220103150812.87914-1-toke@redhat.com>
References: <20220103150812.87914-1-toke@redhat.com>
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


Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD0D4FAAF4
	for <lists+bpf@lfdr.de>; Sat,  9 Apr 2022 23:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232207AbiDIVds (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Sat, 9 Apr 2022 17:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231426AbiDIVdr (ORCPT <rfc822;bpf@vger.kernel.org>);
        Sat, 9 Apr 2022 17:33:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A233E1263E
        for <bpf@vger.kernel.org>; Sat,  9 Apr 2022 14:31:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649539897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=EO9xgnmNg3rKJKYPjZ5Nd4zEAwaYdY2kixTl9SNKnr0=;
        b=ba6yoieIL/ac4LhVlQ1lC9if4r/u7hArVxF/Zy96KJ0Rpi1VIj4PqWNYtw4IVsKQbeyW+h
        nDrFCVLqoM/kRiGzwA5NCXVEFx5KgpNkHJRd/HNNY4LhrUf/BVyMnDTLuHN8rwQVaFofA8
        TJmIWVnBN8XsB+nc90gX18dCtsW4w5A=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-232-b6OozXB4MWqhwxhcAy51Sw-1; Sat, 09 Apr 2022 17:31:35 -0400
X-MC-Unique: b6OozXB4MWqhwxhcAy51Sw-1
Received: by mail-ed1-f69.google.com with SMTP id k19-20020a05640212d300b0041cc3029356so6419463edx.11
        for <bpf@vger.kernel.org>; Sat, 09 Apr 2022 14:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=EO9xgnmNg3rKJKYPjZ5Nd4zEAwaYdY2kixTl9SNKnr0=;
        b=yEn6mkxkkwtEfj/XtURcyRLCKKUu2Y9gbIE9VP6uPpVTf6J3Gn0FsiyCirgr360gBB
         tJiYcQjy9r5mdw15g5+grX/nEZxeYjsAAefxdocEdyS2az0aDCmfqQFvO2OL7WQz23Yi
         6bWHMf1WWb96voTFmaAHQYDB1FUZMRE1Emv4gGbhLV194sFpoFlAx2xwFkdsI4ijh50e
         0f99+6gqY+eBZgSzryQAb2UZg2B7utMkPZm1nnC0jgRjBh5hn8kRqLsR41hcOom8voxa
         C8BYLfq4oxOrns0DCMGTTVuPDldwhhzsGO7U2/h0+YBwJ6pn8kv2oSkNK265LG/Nymp7
         sJYw==
X-Gm-Message-State: AOAM532UPtVDcnLQvX+uAHjibvZ+efPweidEhVqZjzo1Gg27SaSu3eRT
        kQBHbeaxstVvHLjdWN2RySqLvykkZWzvQ8MLF4jpKttl4aREwAQ90W4JIGRZspyNcTRJ4yUDtMi
        L/xzTS0O9PTBq
X-Received: by 2002:a17:907:9805:b0:6db:4c33:7883 with SMTP id ji5-20020a170907980500b006db4c337883mr24693770ejc.555.1649539893734;
        Sat, 09 Apr 2022 14:31:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyL5/gfEH4aSRPO1SsFiQRpKTISSLeu2BXnoBHkkORBctuhW5C8weQ8srGqhX5Y7ZGCNpea4Q==
X-Received: by 2002:a17:907:9805:b0:6db:4c33:7883 with SMTP id ji5-20020a170907980500b006db4c337883mr24693751ejc.555.1649539893374;
        Sat, 09 Apr 2022 14:31:33 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id u7-20020a170906654700b006e886beb300sm72987ejn.164.2022.04.09.14.31.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 14:31:32 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 111BB2755AD; Sat,  9 Apr 2022 23:31:31 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc:     Freysteinn Alfredsson <freysteinn.alfredsson@kau.se>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix release of page_pool in BPF_PROG_RUN
Date:   Sat,  9 Apr 2022 23:30:53 +0200
Message-Id: <20220409213053.3117305-1-toke@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The live packet mode in BPF_PROG_RUN allocates a page_pool instance for
each test run instance and uses it for the packet data. On setup it creates
the page_pool, and calls xdp_reg_mem_model() to allow pages to be returned
properly from the XDP data path. However, xdp_reg_mem_model() also raises
the reference count of the page_pool itself, so the single
page_pool_destroy() count on teardown was not enough to actually release
the pool. To fix this, add an additional xdp_unreg_mem_model() call on
teardown.

Fixes: b530e9e1063e ("bpf: Add "live packet" mode for XDP in BPF_PROG_RUN")
Reported-by: Freysteinn Alfredsson <freysteinn.alfredsson@kau.se>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/bpf/test_run.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index e7b9c2636d10..af709c182674 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -108,6 +108,7 @@ struct xdp_test_data {
 	struct page_pool *pp;
 	struct xdp_frame **frames;
 	struct sk_buff **skbs;
+	struct xdp_mem_info mem;
 	u32 batch_size;
 	u32 frame_cnt;
 };
@@ -147,7 +148,6 @@ static void xdp_test_run_init_page(struct page *page, void *arg)
 
 static int xdp_test_run_setup(struct xdp_test_data *xdp, struct xdp_buff *orig_ctx)
 {
-	struct xdp_mem_info mem = {};
 	struct page_pool *pp;
 	int err = -ENOMEM;
 	struct page_pool_params pp_params = {
@@ -174,7 +174,7 @@ static int xdp_test_run_setup(struct xdp_test_data *xdp, struct xdp_buff *orig_c
 	}
 
 	/* will copy 'mem.id' into pp->xdp_mem_id */
-	err = xdp_reg_mem_model(&mem, MEM_TYPE_PAGE_POOL, pp);
+	err = xdp_reg_mem_model(&xdp->mem, MEM_TYPE_PAGE_POOL, pp);
 	if (err)
 		goto err_mmodel;
 
@@ -202,6 +202,7 @@ static int xdp_test_run_setup(struct xdp_test_data *xdp, struct xdp_buff *orig_c
 
 static void xdp_test_run_teardown(struct xdp_test_data *xdp)
 {
+	xdp_unreg_mem_model(&xdp->mem);
 	page_pool_destroy(xdp->pp);
 	kfree(xdp->frames);
 	kfree(xdp->skbs);
-- 
2.35.1


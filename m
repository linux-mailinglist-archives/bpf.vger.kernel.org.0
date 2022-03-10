Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAC104D454B
	for <lists+bpf@lfdr.de>; Thu, 10 Mar 2022 12:02:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238500AbiCJLDl (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Thu, 10 Mar 2022 06:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237070AbiCJLDk (ORCPT <rfc822;bpf@vger.kernel.org>);
        Thu, 10 Mar 2022 06:03:40 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 53715E01D
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 03:02:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646910158;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3YkGvyVq/I4joIsjY6Ig9+NmZe2zrWU3ce/aUwJiE8c=;
        b=LXQWZjISvgybIEDlJlkUH4GhUe2uWpVKRWNTXoQ7j/72j1bZ8yhmOpQO7DXveAblF2bAqc
        L6GoxWnsbmtrG0MjDlqQOW0KTXybX+xKjyuYw7uaFxTLqjCtN9b7PnpFf5YSCpiAPQVfHJ
        Vw/5874i4v+72V8pen5JyxFkARjXolk=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-324-xZv8wqSoNd6DRJzKgPpdaQ-1; Thu, 10 Mar 2022 06:02:37 -0500
X-MC-Unique: xZv8wqSoNd6DRJzKgPpdaQ-1
Received: by mail-ed1-f70.google.com with SMTP id h17-20020a05640250d100b004133863d836so2942911edb.0
        for <bpf@vger.kernel.org>; Thu, 10 Mar 2022 03:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3YkGvyVq/I4joIsjY6Ig9+NmZe2zrWU3ce/aUwJiE8c=;
        b=40fyazBh3IJuTnlvyLhpmWFJEgJ3eoqqnU/M42oFN9gCNhUVQ0/6+qyVJeR7LmYLEi
         Vs54MwL3TTl+5rATM4iFXYHqRYfmhZtC2Rsf39JYmL+fp8sAm9fvtpc9yyeaQtTKj5/7
         vYi8QxnaTCkyDQZzv76nXwZ5KfTPUOYkopOcSWq2dwWokQh8noOsUnwbHoZxioZFTU7/
         z0P/fuPP7ozpshcvRh1bwT8MgEAYXRm4DX6DlYNeloZOzEaMF+navoGMhRWHDPUO41Il
         GxLbz+yG2FIxZiQf8JLuYMgDTOGTVu0lxmNRZ38Gea0xsr0dUYlEFtX6b+yEVcbyeMYl
         ZXwg==
X-Gm-Message-State: AOAM532CHC8uz2iO4L+j/7gf8hfuEaaeXv5/DXTZayi2YwrBorIbJFDZ
        EJsn7bEutSoR06y4LsaUQuT0x9xWlWrAPo1p44hqIVketu3kcWUvD2VFHon+V3rf5s7V2Q2sG7o
        S3uQDDab2avgG
X-Received: by 2002:a17:907:9485:b0:6db:331:591e with SMTP id dm5-20020a170907948500b006db0331591emr3602911ejc.478.1646910153958;
        Thu, 10 Mar 2022 03:02:33 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwanO7L3hNOd+MuVKT3aE8AD0/A95WmIdMlHB/jhjQXPOhasyxgGufXAhlmCNCMVmVxV3u0SQ==
X-Received: by 2002:a17:907:9485:b0:6db:331:591e with SMTP id dm5-20020a170907948500b006db0331591emr3602761ejc.478.1646910151616;
        Thu, 10 Mar 2022 03:02:31 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id u19-20020a170906125300b006ceb043c8e1sm1717294eja.91.2022.03.10.03.02.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 03:02:31 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id 7E5A7192CC1; Thu, 10 Mar 2022 12:02:30 +0100 (CET)
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
Cc:     kernel test robot <lkp@intel.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Subject: [PATCH bpf-next] bpf: initialise retval in bpf_prog_test_run_xdp()
Date:   Thu, 10 Mar 2022 12:02:28 +0100
Message-Id: <20220310110228.161869-1-toke@redhat.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

The kernel test robot pointed out that the newly added
bpf_test_run_xdp_live() runner doesn't set the retval in the caller (by
design), which means that the variable can be passed unitialised to
bpf_test_finish(). Fix this by initialising the variable properly.

Fixes: b530e9e1063e ("bpf: Add "live packet" mode for XDP in BPF_PROG_RUN")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 net/bpf/test_run.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bpf/test_run.c b/net/bpf/test_run.c
index 25169908be4a..0acdc37c8415 100644
--- a/net/bpf/test_run.c
+++ b/net/bpf/test_run.c
@@ -1207,9 +1207,9 @@ int bpf_prog_test_run_xdp(struct bpf_prog *prog, const union bpf_attr *kattr,
 	bool do_live = (kattr->test.flags & BPF_F_TEST_XDP_LIVE_FRAMES);
 	u32 tailroom = SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
 	u32 batch_size = kattr->test.batch_size;
+	u32 retval = 0, duration, max_data_sz;
 	u32 size = kattr->test.data_size_in;
 	u32 headroom = XDP_PACKET_HEADROOM;
-	u32 retval, duration, max_data_sz;
 	u32 repeat = kattr->test.repeat;
 	struct netdev_rx_queue *rxqueue;
 	struct skb_shared_info *sinfo;
-- 
2.35.1


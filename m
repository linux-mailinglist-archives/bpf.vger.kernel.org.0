Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E66573520
	for <lists+bpf@lfdr.de>; Wed, 13 Jul 2022 13:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbiGMLPS (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Wed, 13 Jul 2022 07:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235672AbiGMLPL (ORCPT <rfc822;bpf@vger.kernel.org>);
        Wed, 13 Jul 2022 07:15:11 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9D48B10149A
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 04:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657710889;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gCuW9cbcf8hMLILwpOQETuB1FTQ/X1nboKBZtIGXp00=;
        b=JJQEdz7oH6C1VGWemeMHNiJU7YSoksMPCjEcmQijpovj+KL3gMvDLl7TRA1M2We264YwG/
        MJGjPQhHZbbTq38QcL4aT5Cu1HrrxBBYuVincCAUVtmzp8nU+nZY+5AXFolD4NXkThW1qC
        wn3R1Z+hliscH3diXJXdWt3VySUoAdc=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-493-pWy7T083OB28YuvDD_zzdQ-1; Wed, 13 Jul 2022 07:14:48 -0400
X-MC-Unique: pWy7T083OB28YuvDD_zzdQ-1
Received: by mail-ej1-f71.google.com with SMTP id ji2-20020a170907980200b0072b5b6d60c2so2948370ejc.22
        for <bpf@vger.kernel.org>; Wed, 13 Jul 2022 04:14:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=gCuW9cbcf8hMLILwpOQETuB1FTQ/X1nboKBZtIGXp00=;
        b=g6uT8nIm5TFJpZjAHEo4ZqbB3C2pyAAYIYeyKaebCmVoiHff4LFEMTRIZcJgKFNqnj
         ruXg0koyptDYhx1nG6sj+BK/OhAz3EOV+Q1w3Aj+lZEc92NRO0vFskYWCMI9jeMv9FLD
         R4bHaZ0bg0HQORwLjzzh7E9pm1r1r97K+D8JMN+oNnys14+8f65MjXTghdGnoWrNDpdw
         lDupN5Pez8q1QIlV7QiY8FqPuGx5j4iJ6TVICfyMuSxaCIzqhYNkEE4CqejPL9rGXkt1
         S23d18VO02CfqkihGT9T4nSrGr3HhQmwxratZEBHAVd+OigynE/REKNBKO6h/b8M+M9q
         reGQ==
X-Gm-Message-State: AJIora+GZcPEgv0jUiC3cw2mXOSQXnUvheiXgvsF8tQnuWArCY2AXInZ
        srW9tjeNnlbvCLDOD6GsxMfRa1T2EyyQM5Lvdsg13vmeRpfNhbWULQwyDSPZMPQ+TrKnof8+RKk
        5kzEqPU3vj9Fj
X-Received: by 2002:aa7:c2d7:0:b0:43a:78af:6e57 with SMTP id m23-20020aa7c2d7000000b0043a78af6e57mr4117061edp.163.1657710885916;
        Wed, 13 Jul 2022 04:14:45 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sxEwR3OSiEpZ8MGJOFm3lT1P38sF2u7mDclfnoS5W7ITmvEBxkx/lZGY0yG0BKt6kuLj2+OQ==
X-Received: by 2002:aa7:c2d7:0:b0:43a:78af:6e57 with SMTP id m23-20020aa7c2d7000000b0043a78af6e57mr4116953edp.163.1657710884805;
        Wed, 13 Jul 2022 04:14:44 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id h5-20020a0564020e8500b0043a7404314csm7653673eda.8.2022.07.13.04.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 04:14:44 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
        id A7BF84D9919; Wed, 13 Jul 2022 13:14:39 +0200 (CEST)
From:   =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To:     Andrii Nakryiko <andrii@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <martin.lau@linux.dev>,
        Song Liu <song@kernel.org>, Yonghong Song <yhs@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@kernel.org>,
        Stanislav Fomichev <sdf@google.com>,
        Hao Luo <haoluo@google.com>, Jiri Olsa <jolsa@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jesper Dangaard Brouer <hawk@kernel.org>
Cc:     Kumar Kartikeya Dwivedi <memxor@gmail.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org,
        Freysteinn Alfredsson <freysteinn.alfredsson@kau.se>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Subject: [RFC PATCH 14/17] libbpf: Add support for querying dequeue programs
Date:   Wed, 13 Jul 2022 13:14:22 +0200
Message-Id: <20220713111430.134810-15-toke@redhat.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220713111430.134810-1-toke@redhat.com>
References: <20220713111430.134810-1-toke@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

Add support to libbpf for reading the dequeue program ID from netlink when
querying for installed XDP programs. No additional support is needed to
install dequeue programs, as they are just using a new mode flag for the
regular XDP program installation mechanism.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 tools/lib/bpf/libbpf.h  | 1 +
 tools/lib/bpf/netlink.c | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/tools/lib/bpf/libbpf.h b/tools/lib/bpf/libbpf.h
index e4d5353f757b..b15ff90279cb 100644
--- a/tools/lib/bpf/libbpf.h
+++ b/tools/lib/bpf/libbpf.h
@@ -906,6 +906,7 @@ struct bpf_xdp_query_opts {
 	__u32 drv_prog_id;	/* output */
 	__u32 hw_prog_id;	/* output */
 	__u32 skb_prog_id;	/* output */
+	__u32 dequeue_prog_id;	/* output */
 	__u8 attach_mode;	/* output */
 	size_t :0;
 };
diff --git a/tools/lib/bpf/netlink.c b/tools/lib/bpf/netlink.c
index 6c013168032d..64a9aceb9c9c 100644
--- a/tools/lib/bpf/netlink.c
+++ b/tools/lib/bpf/netlink.c
@@ -32,6 +32,7 @@ struct xdp_link_info {
 	__u32 drv_prog_id;
 	__u32 hw_prog_id;
 	__u32 skb_prog_id;
+	__u32 dequeue_prog_id;
 	__u8 attach_mode;
 };
 
@@ -354,6 +355,10 @@ static int get_xdp_info(void *cookie, void *msg, struct nlattr **tb)
 		xdp_id->info.hw_prog_id = libbpf_nla_getattr_u32(
 			xdp_tb[IFLA_XDP_HW_PROG_ID]);
 
+	if (xdp_tb[IFLA_XDP_DEQUEUE_PROG_ID])
+		xdp_id->info.dequeue_prog_id = libbpf_nla_getattr_u32(
+			xdp_tb[IFLA_XDP_DEQUEUE_PROG_ID]);
+
 	return 0;
 }
 
@@ -391,6 +396,7 @@ int bpf_xdp_query(int ifindex, int xdp_flags, struct bpf_xdp_query_opts *opts)
 	OPTS_SET(opts, drv_prog_id, xdp_id.info.drv_prog_id);
 	OPTS_SET(opts, hw_prog_id, xdp_id.info.hw_prog_id);
 	OPTS_SET(opts, skb_prog_id, xdp_id.info.skb_prog_id);
+	OPTS_SET(opts, dequeue_prog_id, xdp_id.info.dequeue_prog_id);
 	OPTS_SET(opts, attach_mode, xdp_id.info.attach_mode);
 
 	return 0;
@@ -415,6 +421,8 @@ int bpf_xdp_query_id(int ifindex, int flags, __u32 *prog_id)
 		*prog_id = opts.hw_prog_id;
 	else if (flags & XDP_FLAGS_SKB_MODE)
 		*prog_id = opts.skb_prog_id;
+	else if (flags & XDP_FLAGS_DEQUEUE_MODE)
+		*prog_id = opts.dequeue_prog_id;
 	else
 		*prog_id = 0;
 
-- 
2.37.0


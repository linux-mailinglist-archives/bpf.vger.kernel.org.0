Return-Path: <bpf-owner@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EAC4AC009
	for <lists+bpf@lfdr.de>; Mon,  7 Feb 2022 14:51:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345325AbiBGNun (ORCPT <rfc822;lists+bpf@lfdr.de>);
        Mon, 7 Feb 2022 08:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449007AbiBGNPF (ORCPT <rfc822;bpf@vger.kernel.org>);
        Mon, 7 Feb 2022 08:15:05 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E222CC0401C0
        for <bpf@vger.kernel.org>; Mon,  7 Feb 2022 05:15:03 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id k13so26737257lfg.9
        for <bpf@vger.kernel.org>; Mon, 07 Feb 2022 05:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K4b+1gU4xGtJcTniQUAVI+p3xLbAehO6nJB884Sw+pM=;
        b=OEMaG4vroO351YvW0nCd1W5AmcyT0nM9fnpK+x/NnX6/YakJjkfQUF6sOLFAaCv57B
         qb9Lc8MR8aFHd7q3HT34/PPW8MPdro8A+Q1bBEwuGuYozbLvKMDIHtiwAeTQ5U47iTbz
         QVZrT5u3W5HeqIgD8G1ifo6N63IdpYQE6YoGs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K4b+1gU4xGtJcTniQUAVI+p3xLbAehO6nJB884Sw+pM=;
        b=ExqVaBbO7Tj7kyvwYC6fWG2q6wQp1otnbN0Csv+JL1He9IFV+96ho9mUU56N+1JZmc
         tiD2yrD0qkQIQmNbmbficMNwRPghWrk86BzpbV7MRNPq0vTrw5e2vazN2bLgfdSZ3kKC
         M8Idhc66xidbQBcnzTatrqwVY49HF55dm4efRV8AUTrd5Pu56bR+U8otDNeNWO3X97KY
         IgUBC16ppr44EC03mwf6dDou2OhPYR+HhSFxUB0g9kl0RkPFD7dzEmOqz3kS2KNFtoXd
         XLAAD/ao/Q9LC77/oQb2RS08YRPf9B6Ltui/Nl6jK304EDmEthcpI/gdio8qDDo2k59V
         THSA==
X-Gm-Message-State: AOAM530CiyD8bo1iwlFqHYb+kccF/luv5PVv+26Zw4fh9RBnrjQNLV4u
        KL19QL+qW9nBu9bd2/cuiNlIsLrWSMHkpw==
X-Google-Smtp-Source: ABdhPJxb3CNNE0QJRWRGKkMTSDXDbSFmE4gGPN6+SiMtK5FhREgkDxR0qqZIEi8oIcVkqLLYwvX6DA==
X-Received: by 2002:a19:4301:: with SMTP id q1mr8151788lfa.170.1644239702106;
        Mon, 07 Feb 2022 05:15:02 -0800 (PST)
Received: from cloudflare.com (user-5-173-137-68.play-internet.pl. [5.173.137.68])
        by smtp.gmail.com with ESMTPSA id f10sm1588765ljf.116.2022.02.07.05.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 05:15:01 -0800 (PST)
From:   Jakub Sitnicki <jakub@cloudflare.com>
To:     bpf@vger.kernel.org
Cc:     netdev@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, kernel-team@cloudflare.com
Subject: [PATCH bpf-next 1/2] bpf: Make remote_port field in struct bpf_sk_lookup 16-bit wide
Date:   Mon,  7 Feb 2022 14:14:58 +0100
Message-Id: <20220207131459.504292-2-jakub@cloudflare.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220207131459.504292-1-jakub@cloudflare.com>
References: <20220207131459.504292-1-jakub@cloudflare.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <bpf.vger.kernel.org>
X-Mailing-List: bpf@vger.kernel.org

remote_port is another case of a BPF context field documented as a 32-bit
value in network byte order for which the BPF context access converter
generates a load of a zero-padded 16-bit integer in network byte order.

First such case was dst_port in bpf_sock which got addressed in commit
4421a582718a ("bpf: Make dst_port field in struct bpf_sock 16-bit wide").

Loading 4-bytes from the remote_port offset and converting the value with
bpf_ntohl() leads to surprising results, as the expected value is shifted
by 16 bits.

Reduce the confusion by splitting the field in two - a 16-bit field holding
a big-endian integer, and a 16-bit zero-padding anonymous field that
follows it.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 include/uapi/linux/bpf.h | 3 ++-
 net/core/filter.c        | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index a7f0ddedac1f..afe3d0d7f5f2 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6453,7 +6453,8 @@ struct bpf_sk_lookup {
 	__u32 protocol;		/* IP protocol (IPPROTO_TCP, IPPROTO_UDP) */
 	__u32 remote_ip4;	/* Network byte order */
 	__u32 remote_ip6[4];	/* Network byte order */
-	__u32 remote_port;	/* Network byte order */
+	__be16 remote_port;	/* Network byte order */
+	__u16 :16;		/* Zero padding */
 	__u32 local_ip4;	/* Network byte order */
 	__u32 local_ip6[4];	/* Network byte order */
 	__u32 local_port;	/* Host byte order */
diff --git a/net/core/filter.c b/net/core/filter.c
index 99a05199a806..83f06d3b2c52 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -10843,7 +10843,8 @@ static bool sk_lookup_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct bpf_sk_lookup, local_ip4):
 	case bpf_ctx_range_till(struct bpf_sk_lookup, remote_ip6[0], remote_ip6[3]):
 	case bpf_ctx_range_till(struct bpf_sk_lookup, local_ip6[0], local_ip6[3]):
-	case bpf_ctx_range(struct bpf_sk_lookup, remote_port):
+	case offsetof(struct bpf_sk_lookup, remote_port) ...
+	     offsetof(struct bpf_sk_lookup, local_ip4) - 1:
 	case bpf_ctx_range(struct bpf_sk_lookup, local_port):
 	case bpf_ctx_range(struct bpf_sk_lookup, ingress_ifindex):
 		bpf_ctx_record_field_size(info, sizeof(__u32));
-- 
2.31.1


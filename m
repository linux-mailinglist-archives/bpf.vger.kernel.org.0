Return-Path: <bpf+bounces-1202-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 329A071035F
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 05:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1AB472813FC
	for <lists+bpf@lfdr.de>; Thu, 25 May 2023 03:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07DE71FDA;
	Thu, 25 May 2023 03:38:09 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2FE1FAE
	for <bpf@vger.kernel.org>; Thu, 25 May 2023 03:38:08 +0000 (UTC)
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239B9135
	for <bpf@vger.kernel.org>; Wed, 24 May 2023 20:38:05 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96f850b32caso15933566b.3
        for <bpf@vger.kernel.org>; Wed, 24 May 2023 20:38:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fastly.com; s=google; t=1684985883; x=1687577883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=I9CZO1QJmaEIzooGVT01H6P49L+pRDKuTE/rV82q3uE=;
        b=FcgQ4sk5lg2T/Qh1D7nF/wq+4AxQE0J5uPWGsFka2BX7RMIYJMis9HIGXLmvmwVI/O
         JUEmZcVy5R8GKW1QuQBjuwKSInZARIEAiFBxSkJ+/an2wRJPyRYdUcIN2H4sQdXDAaL7
         cyJyC0x7i1X0CfZtO5Z4NXhoG9C0LFjktL+h8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684985883; x=1687577883;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I9CZO1QJmaEIzooGVT01H6P49L+pRDKuTE/rV82q3uE=;
        b=ZmlkAWBRejpQTsL+BlRbl9Q5r1GstuHJ08lbq3MObhSro+V6dFZMSj1W9vPblTBqZS
         K1f+n3pbQxwfnocp1z8q0OA6o9aTIUqDzN448CHt5hX++ZPWqb3KdKiFD6mFC6iYku0W
         c0IjFhZW2Jr52Ptxo79HH5OKBkfXtvpcO7H8+iVDcoYuh3rvmee+h24Nist+7ngM0hQX
         be0yD1rMz7h69EQeV9gMWmjLfTwZJN6CBh7H6L9yxA1zhhouJiDD4nMgo65UDNil4ocV
         5tPoYFkdZETb3lzrHIQBlh/RNNNCNwp5G3zuRK06GQJx/MTPLKO0lZfNOcNWQM5c/SAa
         z1XA==
X-Gm-Message-State: AC+VfDwLamu3udxE00tWc+mrm99CNXQgMizUEVXMzDIthDgon7WNI9mf
	2ApbkhQNX21QneUYzz16duIYKJQk1noIFBZ75AAcxGotDL9FwP1vuXk4jA2EE1SBSn9hWiroYp5
	hWk2uy/6kO0ooChtS8gZKduJoTOYm/945LbWSdDVXnXoyOxmX/CILNcDWyfanNFGG2NZ2vk6g
X-Google-Smtp-Source: ACHHUZ4mA+nGNjoLRLQPdQjkTPG5jQc+5K6muQISBDzfL7RTA981mVazRyUJLSYWl94kJa1JZg01zg==
X-Received: by 2002:a17:906:d54a:b0:96f:cde5:5f5e with SMTP id cr10-20020a170906d54a00b0096fcde55f5emr245881ejc.29.1684985883260;
        Wed, 24 May 2023 20:38:03 -0700 (PDT)
Received: from localhost.localdomain ([2620:11a:c019:0:65e:3115:2f58:c5fd])
        by smtp.gmail.com with ESMTPSA id k18-20020a170906579200b00965aee5be9asm219426ejq.170.2023.05.24.20.38.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 May 2023 20:38:02 -0700 (PDT)
From: Joe Damato <jdamato@fastly.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	edumazet@google.com,
	martin.lau@linux.dev,
	song@kernel.org,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@google.com,
	jolsa@kernel.org,
	haoluo@google.com,
	Joe Damato <jdamato@fastly.com>
Subject: [PATCH bpf-next] bpf: Export rx queue info for reuseport ebpf prog
Date: Thu, 25 May 2023 03:37:57 +0000
Message-Id: <20230525033757.47483-1-jdamato@fastly.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

BPF_PROG_TYPE_SK_REUSEPORT / sk_reuseport ebpf programs do not have
access to the queue_mapping or napi_id of the incoming skb. Having
this information can help ebpf progs determine which listen socket to
select.

This patch exposes both queue_mapping and napi_id so that
sk_reuseport ebpf programs can use this information to direct incoming
connections to the correct listen socket in the SOCKMAP.

For example:

A multi-threaded userland program with several threads accepting client
connections via a reuseport listen socket group might want to direct
incoming connections from specific receive queues (or NAPI IDs) to specific
listen sockets to maximize locality or for use with epoll busy-poll.

Signed-off-by: Joe Damato <jdamato@fastly.com>
---
 include/uapi/linux/bpf.h |  2 ++
 net/core/filter.c        | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 9273c654743c..31560b506535 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6286,6 +6286,8 @@ struct sk_reuseport_md {
 	 */
 	__u32 eth_protocol;
 	__u32 ip_protocol;	/* IP protocol. e.g. IPPROTO_TCP, IPPROTO_UDP */
+	__u32 rx_queue_mapping; /* Rx queue associated with the skb */
+	__u32 napi_id;          /* napi id associated with the skb */
 	__u32 bind_inany;	/* Is sock bound to an INANY address? */
 	__u32 hash;		/* A hash of the packet 4 tuples */
 	/* When reuse->migrating_sk is NULL, it is selecting a sk for the
diff --git a/net/core/filter.c b/net/core/filter.c
index 968139f4a1ac..71826e1ef7dc 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -11134,6 +11134,8 @@ sk_reuseport_is_valid_access(int off, int size,
 	case bpf_ctx_range(struct sk_reuseport_md, ip_protocol):
 	case bpf_ctx_range(struct sk_reuseport_md, bind_inany):
 	case bpf_ctx_range(struct sk_reuseport_md, len):
+	case bpf_ctx_range(struct sk_reuseport_md, rx_queue_mapping):
+	case bpf_ctx_range(struct sk_reuseport_md, napi_id):
 		bpf_ctx_record_field_size(info, size_default);
 		return bpf_ctx_narrow_access_ok(off, size, size_default);
 
@@ -11183,6 +11185,14 @@ static u32 sk_reuseport_convert_ctx_access(enum bpf_access_type type,
 		SK_REUSEPORT_LOAD_SKB_FIELD(protocol);
 		break;
 
+	case offsetof(struct sk_reuseport_md, rx_queue_mapping):
+		SK_REUSEPORT_LOAD_SKB_FIELD(queue_mapping);
+		break;
+
+	case offsetof(struct sk_reuseport_md, napi_id):
+		SK_REUSEPORT_LOAD_SKB_FIELD(napi_id);
+		break;
+
 	case offsetof(struct sk_reuseport_md, ip_protocol):
 		SK_REUSEPORT_LOAD_SK_FIELD(sk_protocol);
 		break;
-- 
2.25.1



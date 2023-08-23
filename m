Return-Path: <bpf+bounces-8362-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03344785B31
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 16:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08D7281271
	for <lists+bpf@lfdr.de>; Wed, 23 Aug 2023 14:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34681C8F6;
	Wed, 23 Aug 2023 14:54:06 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83C3C8E3
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 14:54:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A285FE76
	for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 07:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692802442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKCuiHdQBzYj0WQ4tg6o4MU6GBwpJn7fnEEut+9ftSM=;
	b=gBoyULIDjGMQCZRsH9TDjzTWbJnTDeJ0uB6arSiFhRuR7LiZglioazk4Ubyl7CvxeIL6sm
	7rg/WOy8qkBejCOdkopNIAWptQGJVbmyEvpFCiETlII5Aci1TPL0eT17aSU5YcYn6hhCch
	pqEhsq0moQWgUPQ8uKVUd7SClrAD9l8=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-PQDh2ltcOQ6oJ88N02DJNQ-1; Wed, 23 Aug 2023 10:54:01 -0400
X-MC-Unique: PQDh2ltcOQ6oJ88N02DJNQ-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-99bcf56a2e9so409168466b.2
        for <bpf@vger.kernel.org>; Wed, 23 Aug 2023 07:54:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692802440; x=1693407240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKCuiHdQBzYj0WQ4tg6o4MU6GBwpJn7fnEEut+9ftSM=;
        b=AMXGMocKMQ0jt3VHkhsY64vRASxN7ziqW3qHaRferQb52ZNfzSdFxBs07oSu6B1clr
         PggKTVT09HE0S6a9qcC3T/iCO+DeYmlwNWzva039eBDFWPgbwBesBDfbzKQ8v2+6rZIg
         CwGwbJ4+/tpfTQmy4tw2TVullShbKI9nYoS3CEfrs9ZdqC0n02blPlzHVbhLWE0yVCVb
         9Z6bH0kljbm7xtj8AafCHlHiE+jm5mlCLjfzZNWtkPuXDC9C1skI7CQd0cpiy7rlwhbg
         qH5EKnuXw05gh7RKxFx4S/vJK7G9XnfbvTSTTyA6dx3z91RfgZs+mizx9eE5Ps2ZNZlK
         ACKQ==
X-Gm-Message-State: AOJu0YwoS/n0Gvbby22GsLK8WxJ7gqW9MA8WmRUwnIgzD+5nCU/EI1rz
	Au0/2fUIcaPtx4JbnhcodIwIWhlwIvqlIYuEVc49wF5fouLSj9MbFQABGvtkMPo813SYg6JUXem
	1BJAobQNxVOn6
X-Received: by 2002:a17:907:2c57:b0:99d:bcc6:12f with SMTP id hf23-20020a1709072c5700b0099dbcc6012fmr9740536ejc.48.1692802440528;
        Wed, 23 Aug 2023 07:54:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFNokp0gSGu5JRhO0cj+u0ZyE+cKg6d5VSQcUvnB6oR8p8taKAI3I5kSTZg/uWs47gqj2m97w==
X-Received: by 2002:a17:907:2c57:b0:99d:bcc6:12f with SMTP id hf23-20020a1709072c5700b0099dbcc6012fmr9740517ejc.48.1692802440280;
        Wed, 23 Aug 2023 07:54:00 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f3-20020a170906084300b0099cb0a7098dsm10005473ejd.19.2023.08.23.07.53.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 07:53:57 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 64B32D3CED2; Wed, 23 Aug 2023 16:53:57 +0200 (CEST)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>
Cc: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 6/6] samples/bpf: Cleanup .gitignore
Date: Wed, 23 Aug 2023 16:53:42 +0200
Message-ID: <20230823145346.1462819-7-toke@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230823145346.1462819-1-toke@redhat.com>
References: <20230823145346.1462819-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Remove no longer present XDP utilities from .gitignore. Apart from the
recently removed XDP utilities this also includes the previously removed
xdpsock and xsk utilities.

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 samples/bpf/.gitignore | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/samples/bpf/.gitignore b/samples/bpf/.gitignore
index 0e7bfdbff80a..0002cd359fb1 100644
--- a/samples/bpf/.gitignore
+++ b/samples/bpf/.gitignore
@@ -37,22 +37,10 @@ tracex4
 tracex5
 tracex6
 tracex7
-xdp1
-xdp2
 xdp_adjust_tail
 xdp_fwd
-xdp_monitor
-xdp_redirect
-xdp_redirect_cpu
-xdp_redirect_map
-xdp_redirect_map_multi
 xdp_router_ipv4
-xdp_rxq_info
-xdp_sample_pkts
 xdp_tx_iptunnel
-xdpsock
-xdpsock_ctrl_proc
-xsk_fwd
 testfile.img
 hbm_out.log
 iperf.*
-- 
2.41.0



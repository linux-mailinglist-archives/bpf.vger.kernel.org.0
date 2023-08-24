Return-Path: <bpf+bounces-8460-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 686E9786CBE
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 12:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9985E1C20DFB
	for <lists+bpf@lfdr.de>; Thu, 24 Aug 2023 10:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE1711CB5;
	Thu, 24 Aug 2023 10:23:15 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0593111B2
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 10:23:14 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84846199D
	for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 03:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692872586;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKCuiHdQBzYj0WQ4tg6o4MU6GBwpJn7fnEEut+9ftSM=;
	b=I04914NMQiHwyi/aeOpLG88fOWyHoM7dCwJTPIYSu2l0Y+VZTVkzzXXPk174jqQKiuQv7k
	CpKFQlahr5YUrJ/XhzAAw458JBH6BWh9hsBB2ZY/K477wCZLf8VXoVUGDxlL34ZrY6QE9T
	++Hoieje5ipUqY9eVZOr2AmLmjtVd7Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-u6rLFQ_hNhCGE60xdCJ_0Q-1; Thu, 24 Aug 2023 06:23:05 -0400
X-MC-Unique: u6rLFQ_hNhCGE60xdCJ_0Q-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-51a5296eb8eso4685551a12.2
        for <bpf@vger.kernel.org>; Thu, 24 Aug 2023 03:23:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692872584; x=1693477384;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKCuiHdQBzYj0WQ4tg6o4MU6GBwpJn7fnEEut+9ftSM=;
        b=LuBPewbIJwvNH1oINKw3yZXheLP6umScJcZNzMfM6zbOiusP9gTvFxPVE1in2De4AB
         DadXD7ZaDo9vmpLPHhx0BqNyQEUsFSLTDq0Jv/5WT9zl/WCdPT6PulySgNmsIMn+jXkg
         ftNZ+gfuZEBj4TbKSZCY3cBRD/5hLHMSGoSqzEdfvgvJZkmuVhEVEsyphwKThTBNlq/k
         CvzmCAXMfZ33RDy2pRHcHOYDD6Qz62jEOnIZp9BxF95i6mfglk5WTGooyoJ5RlWTdPMH
         iIUJ5KkxpK4wY5cD7xAZCh0lwgNE/5o7nn//VulJcazsPCGqIWWk3ERzEZlGFAbygAnf
         jyuQ==
X-Gm-Message-State: AOJu0YygjjuFfCKX6MC1Rb78lQT/H2pW3n6GI5LQExKIs/xe3zkSSDNv
	pU8uPDBXheqw8TOjzfDjIOteVWtT8GTOk7LJBgxwrZYMK8KvRBZFWFilsr3J8j2ZkJrWGnE482b
	uuC7m4WQLKkBh
X-Received: by 2002:a05:6402:5154:b0:51d:95f2:ee76 with SMTP id n20-20020a056402515400b0051d95f2ee76mr11029991edd.27.1692872584174;
        Thu, 24 Aug 2023 03:23:04 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuVS1C4dZQg1itxhtVng1/fJa932rsK3LQoabgZbUEx0XRHvh+eyGe0j7LFk1WJImQOLwGIQ==
X-Received: by 2002:a05:6402:5154:b0:51d:95f2:ee76 with SMTP id n20-20020a056402515400b0051d95f2ee76mr11029976edd.27.1692872583898;
        Thu, 24 Aug 2023 03:23:03 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id q6-20020aa7d446000000b0052718577668sm10218554edr.11.2023.08.24.03.23.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 03:23:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 744EFD3D0A5; Thu, 24 Aug 2023 12:23:01 +0200 (CEST)
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
Subject: [PATCH bpf-next v3 6/7] samples/bpf: Cleanup .gitignore
Date: Thu, 24 Aug 2023 12:22:49 +0200
Message-ID: <20230824102255.1561885-7-toke@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230824102255.1561885-1-toke@redhat.com>
References: <20230824102255.1561885-1-toke@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
	autolearn=unavailable autolearn_force=no version=3.4.6
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



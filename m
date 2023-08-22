Return-Path: <bpf+bounces-8258-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D6F784403
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 16:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 495AD1C20960
	for <lists+bpf@lfdr.de>; Tue, 22 Aug 2023 14:25:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF501DA3C;
	Tue, 22 Aug 2023 14:23:12 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A13431DA30
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 14:23:12 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B199DCCA
	for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 07:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1692714188;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OKCuiHdQBzYj0WQ4tg6o4MU6GBwpJn7fnEEut+9ftSM=;
	b=H7EUOS1wEnHHOre/HwxdgfcRiEg3mCHwG/zsVa0bnnghMK8jP66DwN4xfZe5SxCDli2bA9
	zDdjXoK6SPgh+eDdcKQohsHAcd35swN7zvA3i8P1g2rtyJBaDabLFAy3IM29lmpTsVCjF3
	6+65P5ZS1ymuvRqJKBr2hXzlHpqnKLM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-321-lewLveljO6qiwfsHV_YUSg-1; Tue, 22 Aug 2023 10:23:07 -0400
X-MC-Unique: lewLveljO6qiwfsHV_YUSg-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5218b9647a8so2880621a12.1
        for <bpf@vger.kernel.org>; Tue, 22 Aug 2023 07:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692714186; x=1693318986;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKCuiHdQBzYj0WQ4tg6o4MU6GBwpJn7fnEEut+9ftSM=;
        b=XIzWHBfFXvf2rgI4WASfHl5has9jCOm3sNVpKoDDxDEZHn5CUKXRWjoC71mKOrYKrZ
         zKg5D+QLqP4epVWuJ+CVvujC7NQQpVM5quzTuwL9zj/cJSy4VDcdn1W50wOPq7B/a2Vj
         aSrlYkaf5Qmb/1dsURDzlcUcT2SW8rGetZRguUvXoHGkMc4S1kYvtvr44mPAneeUH5ej
         5j5MX5E29sq0REw3Vc5W5OABSmLIIE9+DhIk5kGlKuGPl/+Y4d1Eie3GAnh33qESSfok
         iyJVc6/jaR4Zr3E94Rb44y4N1slMlVXhL1J2ZOJBlvF1PvusqHU7r8FmXYhF4I0A/3jV
         DaGA==
X-Gm-Message-State: AOJu0Yww/mOqnV+7x3Ly4YiluqJ/s4IcyGSRPCm3knA++GjjB//L4C3d
	5Q+kEDVRhTu5KjL66+Rlw9sNm+6+O+AGsALq6dVLlTI8J2VhF2qX7FKBhqKvDZR0BSU2UjB8MS5
	ewQCPaRPKNbMv
X-Received: by 2002:aa7:d69a:0:b0:522:1956:a291 with SMTP id d26-20020aa7d69a000000b005221956a291mr7004901edr.8.1692714185952;
        Tue, 22 Aug 2023 07:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHDEC40RfeTG3HAvs3Nq5GI8r8LmxEpdF3ztCO13m/XOSspkKwAqyHWCuFDjoKz5YyWJzmmkg==
X-Received: by 2002:aa7:d69a:0:b0:522:1956:a291 with SMTP id d26-20020aa7d69a000000b005221956a291mr7004883edr.8.1692714185711;
        Tue, 22 Aug 2023 07:23:05 -0700 (PDT)
Received: from alrua-x1.borgediget.toke.dk ([45.145.92.2])
        by smtp.gmail.com with ESMTPSA id f18-20020a50ee92000000b0051e2670d599sm7617263edr.4.2023.08.22.07.23.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 07:23:03 -0700 (PDT)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id E4E99D3CCAB; Tue, 22 Aug 2023 16:23:02 +0200 (CEST)
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
Subject: [PATCH bpf-next 6/6] samples/bpf: Cleanup .gitignore
Date: Tue, 22 Aug 2023 16:22:44 +0200
Message-ID: <20230822142255.1340991-7-toke@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230822142255.1340991-1-toke@redhat.com>
References: <20230822142255.1340991-1-toke@redhat.com>
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
	SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
	version=3.4.6
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



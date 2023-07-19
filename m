Return-Path: <bpf+bounces-5220-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0B26758A78
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 02:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D6351C20E71
	for <lists+bpf@lfdr.de>; Wed, 19 Jul 2023 00:55:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282CAC138;
	Wed, 19 Jul 2023 00:50:24 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DA9BA35
	for <bpf@vger.kernel.org>; Wed, 19 Jul 2023 00:50:24 +0000 (UTC)
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F5D1BEE
	for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:19 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-768054797f7so505355285a.2
        for <bpf@vger.kernel.org>; Tue, 18 Jul 2023 17:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689727818; x=1692319818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lELx1Jor3ryyghgQ+HYk7Hk999TnyRY5ELpyAOdCAo8=;
        b=kh51wAObPhNEmOAF6xUu3EksFG8Jzcd7WXjvKK6sY85ydx0oCAjbKfJr7SfAn8ZIn3
         OGDI5Sza40VPT51V90ZS6M8PG8voBghdWBcI5NkF1Ln/E2NjdGFfN7ylSyhZB3H/2qSs
         Eux2cQM7uyHorES3YiVvkdVicwQZiumEj2S/+chWRKgcpZyK9fkMR/CLDlpe+s84ardD
         AKBPhERrtDXd34zmfEnd3tYdQcRIeQYrqvfg1/Y0DzpVit92JSl6lqih2sFM3FuYrzAZ
         fDskheDYTg3t3x7D1pKzM5RwsL+n/HiUxZZYtcVnsMAhT0q+Xp+oLec11WIcU0wG0jf8
         03Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689727818; x=1692319818;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lELx1Jor3ryyghgQ+HYk7Hk999TnyRY5ELpyAOdCAo8=;
        b=DTtThOZZsol97mSWWjGGlptu1ArKVOa7GdsFved0LnxGt08wCOxNloZsSoD+CeuK8f
         zQiCOylf8eJoe8hnMRqQz9blcyiCCIpo15aydB1uzs88fZUeYAb83BN8T2tIwalJkLi7
         Lwhlp5DilfcmMXbOWWghUH2+QHs87MzCsmAPYtKQyXLjkjtebqM2UPm8JXfk9h6zX6Y6
         IFwHL9qkf2fYPMBmBn5Griv4nhRpEP4ntUunCRefIsTWjd0MViALYPjZSr5yx+BJKo2P
         cZcm/bk06+jqGI4g9OVhEmsUWtCiBqRPwTz805MMAltsS3S6a3GCDf8rLFiWnWh5PHRF
         XR5A==
X-Gm-Message-State: ABy/qLYA/3/eLOWJSkOl7Hi9bqqAHPQJVmzIPZ0OAOo1suOD8bOyNjbR
	yBbw0UTj03ZL1/SnRk5Sq5g2JA==
X-Google-Smtp-Source: APBJJlHUp6yi3x2n9nRDT4fU8CPFc7u1hcZSiQvsFocXnMLLx8X+n9M7kAdjrUgvmbOkC1g5qOsF3Q==
X-Received: by 2002:a05:620a:8c13:b0:765:9e6b:139e with SMTP id qz19-20020a05620a8c1300b007659e6b139emr1162065qkn.16.1689727817783;
        Tue, 18 Jul 2023 17:50:17 -0700 (PDT)
Received: from [172.17.0.7] ([130.44.212.112])
        by smtp.gmail.com with ESMTPSA id c5-20020a05620a11a500b0076738337cd1sm968696qkk.1.2023.07.18.17.50.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jul 2023 17:50:17 -0700 (PDT)
From: Bobby Eshleman <bobby.eshleman@bytedance.com>
Date: Wed, 19 Jul 2023 00:50:14 +0000
Subject: [PATCH RFC net-next v5 10/14] virtio/vsock: add
 VIRTIO_VSOCK_F_DGRAM feature bit
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230413-b4-vsock-dgram-v5-10-581bd37fdb26@bytedance.com>
References: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
In-Reply-To: <20230413-b4-vsock-dgram-v5-0-581bd37fdb26@bytedance.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 "K. Y. Srinivasan" <kys@microsoft.com>, 
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>, 
 Dexuan Cui <decui@microsoft.com>, Bryan Tan <bryantan@vmware.com>, 
 Vishnu Dasa <vdasa@vmware.com>, 
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, 
 Simon Horman <simon.horman@corigine.com>, 
 Krasnov Arseniy <oxffffaa@gmail.com>, kvm@vger.kernel.org, 
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hyperv@vger.kernel.org, 
 bpf@vger.kernel.org, Bobby Eshleman <bobby.eshleman@bytedance.com>, 
 Jiang Wang <jiang.wang@bytedance.com>
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This commit adds a feature bit for virtio vsock to support datagrams.

Signed-off-by: Jiang Wang <jiang.wang@bytedance.com>
Signed-off-by: Bobby Eshleman <bobby.eshleman@bytedance.com>
---
 include/uapi/linux/virtio_vsock.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/uapi/linux/virtio_vsock.h b/include/uapi/linux/virtio_vsock.h
index 331be28b1d30..27b4b2b8bf13 100644
--- a/include/uapi/linux/virtio_vsock.h
+++ b/include/uapi/linux/virtio_vsock.h
@@ -40,6 +40,7 @@
 
 /* The feature bitmap for virtio vsock */
 #define VIRTIO_VSOCK_F_SEQPACKET	1	/* SOCK_SEQPACKET supported */
+#define VIRTIO_VSOCK_F_DGRAM		3	/* SOCK_DGRAM supported */
 
 struct virtio_vsock_config {
 	__le64 guest_cid;

-- 
2.30.2



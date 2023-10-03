Return-Path: <bpf+bounces-11307-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 560177B723F
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 22:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sy.mirrors.kernel.org (Postfix) with ESMTP id C08B1B208A3
	for <lists+bpf@lfdr.de>; Tue,  3 Oct 2023 20:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D5BC3D994;
	Tue,  3 Oct 2023 20:05:41 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7B993D386
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 20:05:38 +0000 (UTC)
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80189BD
	for <bpf@vger.kernel.org>; Tue,  3 Oct 2023 13:05:37 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5a586da6so1620427b3.1
        for <bpf@vger.kernel.org>; Tue, 03 Oct 2023 13:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696363536; x=1696968336; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jLfu6nduRDM3dWzYzq/o3BySxKJwELyZOaZ+Zwhe/8w=;
        b=rVru0ZV8kPByctmywulLQXCAmbmE/SqP8H4hixYi+jB2A2PF3M8f5PIUEHyW3MBhj8
         2Yi2jK/UIR9xt62Rw55GtsmzSzZ0uYQBCql3crRULVe4AHSwFrLimv9xWu7Hx2GxL/he
         WJZi4XkyJbhzYrD02xkcWnc3rWeS8MK1C5i/P8VTBxzAuXAeYP0exCL60+e7UgbVeiJD
         W7uNUF15zF/3jHCy+UkUiywV4iIsyijM1ncbdSnbrYJW9eXvV/EP2PupnGlDWdMtdMMg
         TcQG9TFhDyvCcpr1joxCXGDMCEZgSniZZpcK5DpG4z47gahLHfOsDiQ33YdlqBRE8YJi
         /89Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696363536; x=1696968336;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jLfu6nduRDM3dWzYzq/o3BySxKJwELyZOaZ+Zwhe/8w=;
        b=jQf30f7l7YUR2o7x1CYrIN77SThzj9KWM+nbq2jfTrEPzfePBbaDbhV+SCU76BKkov
         BEkF0s9wWAc0/6yh1LrNAEfu6W8w9ga8iie/7ZWvgjtB/RYuQ1hg+7zZ8E8ummbsyEKM
         /4koqBzT9Sbj7khBgKj3xqpjl6uy+fm5dbYHgB1usgwPakHrv7e6Krk4hnLO9cJj5Goi
         JOdRpbO7kBsCHLY1hrPD5QCl2YA6ZlPzz6h4QXvdxusrtm54r4B+AUK93mJGOH4sTTI3
         OQJPVI7W/OdUXAgVojw4BxOg0WX1ZPDE6Whhnc2TFZS8vEcojzNYRJOH1OvfTUw3PtHP
         88DA==
X-Gm-Message-State: AOJu0YxkTFuzqyDKNCuD4O535RFSSq5S52cRc5OzZ2VFU1vCN0aKwJOq
	Rt7hyjShzKrBDTayZcmgz4ZxmKzoYwqRJZUEW1a4WhGq2KhjWxM3cZQUzDQ0LULguELTHEWl7J/
	AGfeWDY/CQohmlq/VIS5lwRP4xg/qVrIyoDeB+Qogw4RBxx3pkg==
X-Google-Smtp-Source: AGHT+IG37FwY35BBpwUYvJZ3mMfpjvK56aS3ASvcODwAOF5iSPKj2kPihjeBEH1K+MuEKBkDJWFT/dM=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a81:4043:0:b0:59b:eb4b:2cad with SMTP id
 m3-20020a814043000000b0059beb4b2cadmr5069ywn.5.1696363536465; Tue, 03 Oct
 2023 13:05:36 -0700 (PDT)
Date: Tue,  3 Oct 2023 13:05:18 -0700
In-Reply-To: <20231003200522.1914523-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231003200522.1914523-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.582.g8ccd20d70d-goog
Message-ID: <20231003200522.1914523-7-sdf@google.com>
Subject: [PATCH bpf-next v3 06/10] selftests/xsk: Support tx_metadata_len
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	kuba@kernel.org, toke@kernel.org, willemb@google.com, dsahern@kernel.org, 
	magnus.karlsson@intel.com, bjorn@kernel.org, maciej.fijalkowski@intel.com, 
	hawk@kernel.org, yoong.siang.song@intel.com, netdev@vger.kernel.org, 
	xdp-hints@xdp-project.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Add new config field and propagate to umem registration setsockopt.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xsk.c | 3 +++
 tools/testing/selftests/bpf/xsk.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index d9fb2b730a2c..24f5313dbfde 100644
--- a/tools/testing/selftests/bpf/xsk.c
+++ b/tools/testing/selftests/bpf/xsk.c
@@ -115,6 +115,7 @@ static void xsk_set_umem_config(struct xsk_umem_config *cfg,
 		cfg->frame_size = XSK_UMEM__DEFAULT_FRAME_SIZE;
 		cfg->frame_headroom = XSK_UMEM__DEFAULT_FRAME_HEADROOM;
 		cfg->flags = XSK_UMEM__DEFAULT_FLAGS;
+		cfg->tx_metadata_len = 0;
 		return;
 	}
 
@@ -123,6 +124,7 @@ static void xsk_set_umem_config(struct xsk_umem_config *cfg,
 	cfg->frame_size = usr_cfg->frame_size;
 	cfg->frame_headroom = usr_cfg->frame_headroom;
 	cfg->flags = usr_cfg->flags;
+	cfg->tx_metadata_len = usr_cfg->tx_metadata_len;
 }
 
 static int xsk_set_xdp_socket_config(struct xsk_socket_config *cfg,
@@ -252,6 +254,7 @@ int xsk_umem__create(struct xsk_umem **umem_ptr, void *umem_area,
 	mr.chunk_size = umem->config.frame_size;
 	mr.headroom = umem->config.frame_headroom;
 	mr.flags = umem->config.flags;
+	mr.tx_metadata_len = umem->config.tx_metadata_len;
 
 	err = setsockopt(umem->fd, SOL_XDP, XDP_UMEM_REG, &mr, sizeof(mr));
 	if (err) {
diff --git a/tools/testing/selftests/bpf/xsk.h b/tools/testing/selftests/bpf/xsk.h
index d93200fdaa8d..bff8e50d7532 100644
--- a/tools/testing/selftests/bpf/xsk.h
+++ b/tools/testing/selftests/bpf/xsk.h
@@ -200,6 +200,7 @@ struct xsk_umem_config {
 	__u32 frame_size;
 	__u32 frame_headroom;
 	__u32 flags;
+	__u32 tx_metadata_len;
 };
 
 int xsk_attach_xdp_program(struct bpf_program *prog, int ifindex, u32 xdp_flags);
-- 
2.42.0.582.g8ccd20d70d-goog



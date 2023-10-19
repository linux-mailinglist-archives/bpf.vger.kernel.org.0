Return-Path: <bpf+bounces-12715-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7707D00EA
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2A06B213DF
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 17:50:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A153339852;
	Thu, 19 Oct 2023 17:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="umAo5Q2o"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64A838DE8
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 17:49:58 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D56A6114
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:49:57 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a3942461aso11979932276.2
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737797; x=1698342597; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LFEv0Rk4c58f8nW4wX3rlpCzBtUq44ORzcsZ1KWXaZA=;
        b=umAo5Q2opMRnodxyAX6rCCUKTBW9GW8lYORtbUMY9Qb3TNSVHuFC3IN/I+4Sc28VRt
         4ln1ISXo2E4Q2JZ4g/KGJugbyHiAxQRdkhzL80G4KIXqU+2v8StW1SXmS95rKScJFHvb
         34INEmeo+/YlLtOaFeuUvCrZdvIt1nskgnMF9Dj1Jhx0wG+1birYXl+AVRpGMXwlALgS
         GvSUfm3W8oTEEmq+96TiCVZrOWdm9D2FCf25oFvyBhyspZZhhdT9xxwbJ7BP+morWzHz
         3Sby+X3qwh2No/mcD+r7O9xP7RTPo7+L6KTLtBSKrjjvpmfVfLo+LwrggAUhCrh4AcLJ
         NO8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737797; x=1698342597;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LFEv0Rk4c58f8nW4wX3rlpCzBtUq44ORzcsZ1KWXaZA=;
        b=WAqoPU/BJqxLS/v1zNajYCVLfp/pfx+gTS97rOV62Nvct/jk+T/PyHzAcMq7311kWv
         Fd5hhb/Tu1TCEJ8ReRyy/XB7UqBy8RQFsh8ItmWpeSBgVEjnyMH+u0StCbmy4LGVAp4l
         FiWpu3MCttY0kBbJ+MTMaPm52AxQknxw0oZj/WcWmqHl0r13Yrfisp7HbTvYQq626Jd3
         ewjDWtIxJMBXYDU/SOAq1piE5/BYgvRzskayRh8QntxqiVS1SccVgV/yEvdBWMpHPBFv
         KrSVBgKkfVg5CK2+c4AcOOvWPnsxMburcZbW2+isifAouXnTguXUiOru033BqLbmc37u
         rz/Q==
X-Gm-Message-State: AOJu0YyV6QOG8/8OAPOih+HwEm3F5R9yRIAkUoWqQb8jwRElylShNqA3
	r9krZdJ6h+GuDmMh9m/w1obFyp7KPI9hwHOgplCf+bc+OxrR21l8R+6xLkiKI4HwVqgWPx1VZsR
	g0zGZZsrvVHQdmXzLfZtEAuEJirfKXA8Ia/osMgWj2EQDGYYjeg==
X-Google-Smtp-Source: AGHT+IHAsfsuXulyzsSaTEpkMFqhSNyAS6B6LpfnX0Hwmq64JVjOwQOL2Qg2Qh5GDN49DmPV8DUjz6o=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:2347:0:b0:d7e:7a8a:2159 with SMTP id
 j68-20020a252347000000b00d7e7a8a2159mr71389ybj.5.1697737796854; Thu, 19 Oct
 2023 10:49:56 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:49:39 -0700
In-Reply-To: <20231019174944.3376335-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019174944.3376335-7-sdf@google.com>
Subject: [PATCH bpf-next v4 06/11] selftests/xsk: Support tx_metadata_len
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

Add new config field and propagate to umem registration setsockopt.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/testing/selftests/bpf/xsk.c | 3 +++
 tools/testing/selftests/bpf/xsk.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/tools/testing/selftests/bpf/xsk.c b/tools/testing/selftests/bpf/xsk.c
index e574711eeb84..25d568abf0f2 100644
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
index 771570bc3731..93c2cc413cfc 100644
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
2.42.0.655.g421f12c284-goog



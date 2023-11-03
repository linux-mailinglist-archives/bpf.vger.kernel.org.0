Return-Path: <bpf+bounces-14071-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D2F7E022B
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 12:23:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2354C1C21084
	for <lists+bpf@lfdr.de>; Fri,  3 Nov 2023 11:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A718B154B8;
	Fri,  3 Nov 2023 11:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i1lM8GcK"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F39014F8D
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 11:22:53 +0000 (UTC)
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA2A51A8
	for <bpf@vger.kernel.org>; Fri,  3 Nov 2023 04:22:45 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a5f2193bso2094606e87.1
        for <bpf@vger.kernel.org>; Fri, 03 Nov 2023 04:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699010564; x=1699615364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uPCpAYyXrmpvTCFWCPrCoA7Y/NUTFBtBJEwkbOnbvfc=;
        b=i1lM8GcKEXGwpvsZiOvYzJfWQLlBT9KM9zPSHcovcpVfOUEcHgN7soS4vRKA5n9vgc
         oibbMAybJzuywLWn1ucF7/Fwgc/Xi5gQ5Q0UzXZiWacRbR5saNA7w5rHCge9gIPSkd18
         DuuTj1n+o/OrYwetV7NaPbuyFpbK47WCv8+5y58RaIoiYLwJi7B0g1+r7B78TojyFXqO
         dh0fbG/Dulcp+rdFzBDseUH/J6zWx0IWgJJw5fuITipSpMvXQuyn0X1hl1pdDt7lDfZC
         QnZF4CERetnMm6Pw14pDpHRyqfZ/VBgDolq7OUVvcMm6ZPQE2KgHZolDtsjY/XNQ+bB4
         0biA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699010564; x=1699615364;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uPCpAYyXrmpvTCFWCPrCoA7Y/NUTFBtBJEwkbOnbvfc=;
        b=K2a36df3MukeZ4BwV/DzbXbG5yLFdGKHzkB9JlVm6Rt4E4A1RIv0sPAjetwPycROh0
         rjfB6ynF8Y7ngKnEZ8zRzozQD1f2i0rXucbSWJWWP6Rd6tRgb3QxiRpxt9L7nbO3KfUF
         ebuJJqT6zPf3DGhaiy2oRaJzL5PtlHtEFs3jJhy2F02l7r2jR1XJixzLVeFDRbOGF9J7
         aUIgOQzUCGHL0SyJyDiQWK4Ep+SRfWOQm6xx3fApJhHn9iMbCrNvqbwXi4eZzQ7WCFVi
         TDqXeQzAhj77YkE+ayhjjfYFK2A+eCn7Wh6BYpRS5BVWKhRBqYDQMcNvk0k2hKcLn+CR
         zhyA==
X-Gm-Message-State: AOJu0YxZYHIkYjbB/J2alKoIrPHf7goQDYo+54dpRdta71+ZWTHsWIj/
	mn7jlCSTRmL3nyJg6gDEe/9BBA==
X-Google-Smtp-Source: AGHT+IFIZFoXGLwHbN1vbOa5GKa0O7Rxzp++onFknzG49QejR0WpxcOerL3lYrLgjbK1nj7lrwnLQA==
X-Received: by 2002:a19:7119:0:b0:509:dd1:74f8 with SMTP id m25-20020a197119000000b005090dd174f8mr871295lfc.2.1699010563946;
        Fri, 03 Nov 2023 04:22:43 -0700 (PDT)
Received: from localhost (c-9b0ee555.07-21-73746f28.bbcust.telenor.se. [85.229.14.155])
        by smtp.gmail.com with ESMTPSA id u23-20020a2eb817000000b002c50ba4a047sm210102ljo.80.2023.11.03.04.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Nov 2023 04:22:43 -0700 (PDT)
From: Anders Roxell <anders.roxell@linaro.org>
To: bjorn@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Anders Roxell <anders.roxell@linaro.org>
Subject: [PATCH] selftests: bpf: xskxceiver: ksft_print_msg: fix format type error
Date: Fri,  3 Nov 2023 12:22:37 +0100
Message-ID: <20231103112237.1756288-1-anders.roxell@linaro.org>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Crossbuilding selftests/bpf for architecture arm64, format specifies
type error show up like.

xskxceiver.c:912:34: error: format specifies type 'int' but the argument
has type '__u64' (aka 'unsigned long long') [-Werror,-Wformat]
 ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
                                                                ~~
                                                                %llu
                __func__, pkt->pkt_nb, meta->count);
                                       ^~~~~~~~~~~
xskxceiver.c:929:55: error: format specifies type 'unsigned long long' but
 the argument has type 'u64' (aka 'unsigned long') [-Werror,-Wformat]
 ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
                                    ~~~~             ^~~~

Fixing the issues by using the proposed format specifiers by the
compilor.

Signed-off-by: Anders Roxell <anders.roxell@linaro.org>
---
 tools/testing/selftests/bpf/xskxceiver.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/bpf/xskxceiver.c b/tools/testing/selftests/bpf/xskxceiver.c
index 591ca9637b23..dc03692f34d8 100644
--- a/tools/testing/selftests/bpf/xskxceiver.c
+++ b/tools/testing/selftests/bpf/xskxceiver.c
@@ -908,7 +908,7 @@ static bool is_metadata_correct(struct pkt *pkt, void *buffer, u64 addr)
 	struct xdp_info *meta = data - sizeof(struct xdp_info);
 
 	if (meta->count != pkt->pkt_nb) {
-		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%d]\n",
+		ksft_print_msg("[%s] expected meta_count [%d], got meta_count [%llu]\n",
 			       __func__, pkt->pkt_nb, meta->count);
 		return false;
 	}
@@ -926,11 +926,11 @@ static bool is_frag_valid(struct xsk_umem_info *umem, u64 addr, u32 len, u32 exp
 
 	if (addr >= umem->num_frames * umem->frame_size ||
 	    addr + len > umem->num_frames * umem->frame_size) {
-		ksft_print_msg("Frag invalid addr: %llx len: %u\n", addr, len);
+		ksft_print_msg("Frag invalid addr: %lx len: %u\n", addr, len);
 		return false;
 	}
 	if (!umem->unaligned_mode && addr % umem->frame_size + len > umem->frame_size) {
-		ksft_print_msg("Frag crosses frame boundary addr: %llx len: %u\n", addr, len);
+		ksft_print_msg("Frag crosses frame boundary addr: %lx len: %u\n", addr, len);
 		return false;
 	}
 
@@ -1029,7 +1029,7 @@ static int complete_pkts(struct xsk_socket_info *xsk, int batch_size)
 			u64 addr = *xsk_ring_cons__comp_addr(&xsk->umem->cq, idx + rcvd - 1);
 
 			ksft_print_msg("[%s] Too many packets completed\n", __func__);
-			ksft_print_msg("Last completion address: %llx\n", addr);
+			ksft_print_msg("Last completion address: %lx\n", addr);
 			return TEST_FAILURE;
 		}
 
@@ -1513,7 +1513,7 @@ static int validate_tx_invalid_descs(struct ifobject *ifobject)
 	}
 
 	if (stats.tx_invalid_descs != ifobject->xsk->pkt_stream->nb_pkts / 2) {
-		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%u] expected [%u]\n",
+		ksft_print_msg("[%s] tx_invalid_descs incorrect. Got [%llu] expected [%u]\n",
 			       __func__, stats.tx_invalid_descs,
 			       ifobject->xsk->pkt_stream->nb_pkts);
 		return TEST_FAILURE;
-- 
2.42.0



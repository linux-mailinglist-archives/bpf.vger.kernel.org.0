Return-Path: <bpf+bounces-69745-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52AA9BA08FC
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 18:15:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A1A3F7A7FDF
	for <lists+bpf@lfdr.de>; Thu, 25 Sep 2025 16:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD4C3054CE;
	Thu, 25 Sep 2025 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KAURFMnm"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027BF303C87
	for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 16:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758816897; cv=none; b=Nvg5yo6uuvph9BZt89YZeeM3TbMHwDhBwSSFhBAj8v+0QEkUAjMHJRUUdn+hK8PmRUTwvcXvQxNbobRFIbAg8Cp7gVdvmC1rQKEQ3p7Ge2Rj+JNimj+PXwgHufARvdmIsmJxOp46NjcXHr/ylu/NNagsaeiFG3pjsoW84VCAK5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758816897; c=relaxed/simple;
	bh=EEHslgxhV+3uof7tUSQV6LqlghG3tXhap2F1zIMfbxw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hvPKtcqUAz+YnQRnA/3TVlqH1aMD/y0AzlE76Nl3yV6Y1ANX48gdvmTWQtDiQeC1C/krMwC62ERR+IWsTsMGDoJhWAaHIzU/xP98OVK/omYo75eyfxEMaoVcjEEG5K9seUgGax0x5R/gPpihutSW8JOR9RC0hFeTJzNCqxw0Ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KAURFMnm; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-77f358c7b8fso1872546b3a.1
        for <bpf@vger.kernel.org>; Thu, 25 Sep 2025 09:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758816894; x=1759421694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zu5VyRA42TLq+enKOi2L+NGXj17XBn9sK2pdEIz7rm0=;
        b=KAURFMnmcafVTCUhIut35FTRF61qq5jZlRfiIJSZ2tZpOWB/VyB391V54HDFqRNQNo
         0wWXKWjGJIG6Qd8R1xDLcrA+LT0jYzlifYk+te6Tvb6Gl4BtUwYYagpk27C3LPSXsgIK
         UF9/TjdAVaS9704eNmjDAXpM4Vg4i0E1x5slX3tzOm4rGOAAdt2bN2QquUkOUuho8xY+
         l3O4EVBlT247AwHAHtl3lC5ROs0ZXbTSFAtAH4qgwCKykbXd7/3SIRMtLbrmlV7ldmiD
         eEUhbQ1R5Q3iax4HVdNUB4WB1velegSbdFuhdA3rmG7YifG7dvTc3IlahSQXZdW73+Ck
         +nig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758816894; x=1759421694;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zu5VyRA42TLq+enKOi2L+NGXj17XBn9sK2pdEIz7rm0=;
        b=oZ/RgpRd0HA3voSgMsUp7W0BuK12tcLtenln6xwqcpVjsNh1jZyrcU9wFtiE0QV1Ck
         exD7O44YAE2NT/9bn0+Q/wO3+D2v3xpacXPQy8GaYDWQCgekGh9OvAkQnZfpAfYd0O4f
         9RK8RvHZu3uKd3tV0alyO8QjSdIUmkdfzh2jSusTbPR0/V1Grb1csfJzHEbBC6ENLVzU
         oGOgdJyNSpcFdqXZvGq5EOckhBAPwR1HKTRDtTKCzgR2q0hvK+r1v36p+eOZ/Mjc4LDH
         2gr0ut32/e42l+GhgAbWJ4+3AdRblc4PckOVyl+c5ncK49pS7UOxjlNU0M1piA0Uiy+g
         bARQ==
X-Gm-Message-State: AOJu0YxIXb2G4X/hLGg3wl2Sxg7V3crz4XE60natnBYcyFH699elId6J
	z/Xhc1PlG3MG4xcqAB9Zlfu35RZpwRMAKnbamQoJFT/W3LOHoGtNi76o
X-Gm-Gg: ASbGncvHuBiXr5lQxUNd8ZWNkdIp04eeHfd1g/yee1Qb9H7eRXL74iezMM2+eYiABV2
	Fp7AXSXpU2UDafVClvBg4YCvNQ0r8Uog53QBai18Jbc6MpYgoF+9wqh++Af/uRhyc1WCS4XGnhh
	zHL4fj4GE/mUYM/lQSgKUjPV+fTAl4RGF3+hoFZ7ovWORBFYf0qDHUl0EF1pwrxV2igwKkEx39L
	C6fdGSlvpKyzxWSARIB4apS4cXGsXyHb5KG0KTka+YO3ZefdxmWQQiStUMPIqn3Uo2y/ZsMnNvd
	++4k6DeFbbrzgbjK5hk8FhuKrtrkj2DSvIc0cIt83fCwSD1G+HxXX6XqBPCdiZ6u792j27T19MK
	dqRdKenZC/sXF0g==
X-Google-Smtp-Source: AGHT+IF1G4EW92h4oYMvNkFLseuKn3GV8PGa6gXiBXkSmVu1nfKJuA3SyrVbXx+SjKggXaVgUlQE8Q==
X-Received: by 2002:a05:6a20:3949:b0:2c3:a04d:288a with SMTP id adf61e73a8af0-2e9abb1c468mr3967119637.24.1758816894039;
        Thu, 25 Sep 2025 09:14:54 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:40::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-781023c26d4sm2347331b3a.37.2025.09.25.09.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Sep 2025 09:14:53 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	kuba@kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	stfomichev@gmail.com,
	kernel-team@meta.com
Subject: [PATCH net-next 1/1] selftests: drv-net: Reload pkt pointer after calling filter_udphdr
Date: Thu, 25 Sep 2025 09:14:52 -0700
Message-ID: <20250925161452.1290694-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a verification failure. filter_udphdr() calls bpf_xdp_pull_data(),
which will invalidate all pkt pointers. Therefore, all ctx->data loaded
before filter_udphdr() cannot be used. Reload it to prevent verification
errors.

The error may not appear on some compiler versions if they decide to
load ctx->data after filter_udphdr() when it is first used.

Fixes: efec2e55bdef ("selftests: drv-net: Pull data before parsing headers")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 tools/testing/selftests/net/lib/xdp_native.bpf.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/net/lib/xdp_native.bpf.c b/tools/testing/selftests/net/lib/xdp_native.bpf.c
index df4eea5c192b..c368fc045f4b 100644
--- a/tools/testing/selftests/net/lib/xdp_native.bpf.c
+++ b/tools/testing/selftests/net/lib/xdp_native.bpf.c
@@ -420,7 +420,6 @@ static int xdp_adjst_tail_grow_data(struct xdp_md *ctx, __u16 offset)
 
 static int xdp_adjst_tail(struct xdp_md *ctx, __u16 port)
 {
-	void *data = (void *)(long)ctx->data;
 	struct udphdr *udph = NULL;
 	__s32 *adjust_offset, *val;
 	__u32 key, hdr_len;
@@ -432,7 +431,8 @@ static int xdp_adjst_tail(struct xdp_md *ctx, __u16 port)
 	if (!udph)
 		return XDP_PASS;
 
-	hdr_len = (void *)udph - data + sizeof(struct udphdr);
+	hdr_len = (void *)udph - (void *)(long)ctx->data +
+		  sizeof(struct udphdr);
 	key = XDP_ADJST_OFFSET;
 	adjust_offset = bpf_map_lookup_elem(&map_xdp_setup, &key);
 	if (!adjust_offset)
@@ -572,8 +572,6 @@ static int xdp_adjst_head_grow_data(struct xdp_md *ctx, __u64 hdr_len,
 
 static int xdp_head_adjst(struct xdp_md *ctx, __u16 port)
 {
-	void *data_end = (void *)(long)ctx->data_end;
-	void *data = (void *)(long)ctx->data;
 	struct udphdr *udph_ptr = NULL;
 	__u32 key, size, hdr_len;
 	__s32 *val;
@@ -584,7 +582,8 @@ static int xdp_head_adjst(struct xdp_md *ctx, __u16 port)
 	if (!udph_ptr)
 		return XDP_PASS;
 
-	hdr_len = (void *)udph_ptr - data + sizeof(struct udphdr);
+	hdr_len = (void *)udph_ptr - (void *)(long)ctx->data +
+		  sizeof(struct udphdr);
 
 	key = XDP_ADJST_OFFSET;
 	val = bpf_map_lookup_elem(&map_xdp_setup, &key);
-- 
2.47.3



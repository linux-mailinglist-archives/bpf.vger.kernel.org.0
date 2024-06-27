Return-Path: <bpf+bounces-33248-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A26D91A321
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 11:55:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2558D284157
	for <lists+bpf@lfdr.de>; Thu, 27 Jun 2024 09:54:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79F8513D296;
	Thu, 27 Jun 2024 09:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tos99T6z"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6DD13CA97;
	Thu, 27 Jun 2024 09:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719482070; cv=none; b=PMStxKOrU5thDQymLZ1EZgSGC5mpeDO8hccOoW1DUetryqBWtz3B/hXMvSCqQJ5O5QO+5ojusTVN5/uRDYCtABz8sPyyjpWiX+YphIu/+ubpkZMNuC9iZpT1Pc/QhSkM0b8LRQ37mlMJ7JH9D2QF36PDrSMoLvOliJQrJOZHvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719482070; c=relaxed/simple;
	bh=3g3g49tmB4NbXUpNJs7RZb6rQARY30a+Oo/Fn4kSrGc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PRWQ++RkGNJI3ihTPrcW6oygn0tHMVm2WbvT5ITPjLnNXGXyn5ycci/MeZPQfUJP2QSoo1tkHxKg8CykqTkT+uNe1hjCNWI5p6bSJvkAVPIIAZRFgk+0MdUv9Ytq0mdZLoma6Yz9Gy5H58r7G7GvEnl0PpiFNNLCnFcBvYTXnbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tos99T6z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4E8DC4AF07;
	Thu, 27 Jun 2024 09:54:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719482069;
	bh=3g3g49tmB4NbXUpNJs7RZb6rQARY30a+Oo/Fn4kSrGc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Tos99T6zcmIjcNYTiUk17gB/ocW6Fduk01Snk/AxIpReOuAjM1/7Qi94Tz05E9IYT
	 j9eHbQVr1Frg7cPLELrg7wHFfHoYanNq7w7yr4XuYO7GuOxPB/+xvd8FWzTd8Md5fx
	 QXMoveY7m2KOYC+oWAeDaADjSe+Ou7AM1vaJtUzhehlrBf1KFz4kCLMgghD94bhw4I
	 QutSwLtTf3jzTdw9o0oW+dQq3zj+ENJDRwFs29Jj+SlLUM3gfkXIdsgbLch/8WSiba
	 vsIoIMaei/avAjYZg9audoJcPIiSw7AyI1IiuQE56XBf08d9bR0aiHLnknsCiaRhE4
	 pIb3s+sSMRqTw==
From: Benjamin Tissoires <bentiss@kernel.org>
Date: Thu, 27 Jun 2024 11:54:19 +0200
Subject: [PATCH 3/6] HID: bpf: move the BIT() macro to hid_bpf_helpers.h
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240627-import-bpf-v1-3-0dbcda4a5b1f@kernel.org>
References: <20240627-import-bpf-v1-0-0dbcda4a5b1f@kernel.org>
In-Reply-To: <20240627-import-bpf-v1-0-0dbcda4a5b1f@kernel.org>
To: Jiri Kosina <jikos@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-input@vger.kernel.org, 
 bpf@vger.kernel.org, Benjamin Tissoires <bentiss@kernel.org>, 
 =?utf-8?q?Jos=C3=A9_Exp=C3=B3sito?= <jose.exposito89@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719482062; l=1509;
 i=bentiss@kernel.org; s=20230215; h=from:subject:message-id;
 bh=3g3g49tmB4NbXUpNJs7RZb6rQARY30a+Oo/Fn4kSrGc=;
 b=nDRCBTHZBJGTzHbKaAYeZQ20Q8klVXlctBTyMWIYVOJbv1g1yQSQkKJabkjFljQX2Mpo58R2w
 8EKg+JwDexiCNg47xGvjyUDR8Vql9F0vP2n0X+7TLahtGOXQxj8aBDv
X-Developer-Key: i=bentiss@kernel.org; a=ed25519;
 pk=7D1DyAVh6ajCkuUTudt/chMuXWIJHlv2qCsRkIizvFw=

This macro can be useful in mopre than one place

Link: https://gitlab.freedesktop.org/libevdev/udev-hid-bpf/-/commit/7970a9c17aa0756bad63e89fccb6ee4f2ec83ccc
Signed-off-by: José Expósito <jose.exposito89@gmail.com>
Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
---
 drivers/hid/bpf/progs/XPPen__Artist24.bpf.c | 2 --
 drivers/hid/bpf/progs/hid_bpf_helpers.h     | 1 +
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c b/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
index d4d062c3a653..c24fe905c50d 100644
--- a/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
+++ b/drivers/hid/bpf/progs/XPPen__Artist24.bpf.c
@@ -78,8 +78,6 @@ static const __u8 fixed_rdesc[] = {
 	0xc0,                          // End Collection                      106
 };
 
-#define BIT(n) (1UL << n)
-
 #define TIP_SWITCH		BIT(0)
 #define BARREL_SWITCH		BIT(1)
 #define ERASER			BIT(2)
diff --git a/drivers/hid/bpf/progs/hid_bpf_helpers.h b/drivers/hid/bpf/progs/hid_bpf_helpers.h
index 8f226f6e886b..3ba24d125a08 100644
--- a/drivers/hid/bpf/progs/hid_bpf_helpers.h
+++ b/drivers/hid/bpf/progs/hid_bpf_helpers.h
@@ -66,6 +66,7 @@ extern int hid_bpf_hw_request(struct hid_bpf_ctx *ctx,
 #define HID_VID_ANY				0x0000
 #define HID_PID_ANY				0x0000
 
+#define BIT(n) (1UL << (n))
 #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]))
 
 /* Helper macro to convert (foo, __LINE__)  into foo134 so we can use __LINE__ for

-- 
2.44.0



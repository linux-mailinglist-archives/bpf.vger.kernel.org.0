Return-Path: <bpf+bounces-55001-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B62A76F5E
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 22:33:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 70F0A7A5687
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 20:31:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA433215783;
	Mon, 31 Mar 2025 20:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KdVSKRLk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A672E1E0E0D
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 20:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743453121; cv=none; b=EIjK5g/9+gzKDS3ZeNZ9ndKup7vIU3ddMz3ZZssz34KJMXJbJ7B2TqlBZFksnN0hIoyrtO1cBNHV9E66JjWb9gszTUiOsZ6XI4e5l18QEHYZijCdVH7DQ0iW+HuMqlCvgJns6sZNJvNwUQmcba55WZsYLePx0H+/X6gYPJxkSXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743453121; c=relaxed/simple;
	bh=AgqxCsa7u7/GqrERlinz1v9hlQtSuvsGx3Ucq0DWxq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TGzeud0uHYIMok6uVDQ/E6SsamnDI2C4V++98C0vfv3aAdDOm89t6hs+JGn8QYkbHnuD4OvVBsfRF7vorHkWtPrx47nnXd/YtLCk1vxL5ICoRqAEDH3ci2+8LjuOIqg2fjWvxjladZCaPiGqHaK8MDiWEnRCtU7VDGOpHSYGjHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KdVSKRLk; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-ac2bdea5a38so802979766b.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 13:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743453117; x=1744057917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTlRu/142GTJE4p4Az4hv9VEZYubzamXsEThiSq3AUA=;
        b=KdVSKRLkG103t5nb+BQ3AjmnMKPkPz9zlE3c73HBBjLGenlnWFr+FzC/+s/RAYByUy
         Gb7/1Ey1xp0nCDUgZtVfdDs5UPedCcNTAQ2n12hYc12dYb39laEPHFp2rQjO1CP9WDST
         AMeWD0xiY6LO+ibstrbSIpMfc9XqHTPlKOgeRUNp1IWvJx5N6c3Bbqd2T0pD0cSy/M5Y
         LzzNPmZkloTaLNjF3e60ydMy2VyS/e0mpy/FdDon8YMeoWtjv7Et/CN7n8HL+FHXfYut
         T7sX58j6UtE2ZAC0JsxXevDONlN9zgU4/TyBRvvW2FNvjhhyXzwwcGNgjqppuErDzFum
         rsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743453117; x=1744057917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTlRu/142GTJE4p4Az4hv9VEZYubzamXsEThiSq3AUA=;
        b=MHJbgvqBLmUuyB04PcQ9TAhmLP2NhEDEdR+7l24T4bQZW7bT7Tsj+7nTqOHa/8MBvE
         2vxnrSxZn1J+Y8byfOPvOMfQKoNh1iqMxfutRy4SeJgcch0tfmvayIawp432eymZu01D
         /owKW06kS3eMuWfakHBooEkSnPROJOOT2acHyBY5WHP+9ZbdB67QXMWg0eHqyVdC50/r
         nyQu4v3QrQpjQbUpUV/JBWEeCc52Xohia2xRHN78Dg8O0yXzVAG+iHkvhIOLxdyaK7mk
         bBrC8tY7X0trPAIx0sqzetR0ltp7pKk1NnY0ZmEOZnU+nRl6btW64W8FbwpQx1hxiolt
         JtNg==
X-Gm-Message-State: AOJu0YzP2+3vQ3iR6ei5+fVEbw9vQPkm7pe+SHrsmqxA+c/P7jvex4vM
	Yc2sTjX2LGKcYMV5dGz7e6+zZuRySDHd3HltkCHPQPhM6q4D/KNvQIllwQ==
X-Gm-Gg: ASbGncv26B+ww2uwsQQdpQgaVjqjAuIMju7MlHkhfjVoDfRWxZZGV2iWWoPDzo96RW8
	alkjVmQfGUmElIiZh1qLzwhmoun5GbvH1AyhYlRdimGQ9owe62KruoDPie+/7cYiiV3czOBMn/u
	MhyxK8ELlPTDX6+8IDxXvouaUrhnuaZIqUjID490uwAkgJ0Nb2/TxNiE1GYsavHyZgbQfwd5F9V
	aqY6QISd9QzNqDQwF/66bflXfv7p6f4OdpuBAa4Fj12luq44AV2XUp6ju4WYnw82wGjJtPOpxIM
	MPf7NfLcSstQrZN4AbBRykBwdpTcSrCjbsK3N8YHYggEV01PPXzuRBVZZT6Jw8E8
X-Google-Smtp-Source: AGHT+IFJNAfRe8ojQLXKcDxd4UtS43NUzuckQ6f2X0iCCMTOwEb8HNjMJCsJfPThy2bRhgcBh/lYlw==
X-Received: by 2002:a17:907:a089:b0:abc:4b7:e3d3 with SMTP id a640c23a62f3a-ac738a3e93bmr1064636766b.27.1743453116943;
        Mon, 31 Mar 2025 13:31:56 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5edc16aae2fsm6030589a12.4.2025.03.31.13.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 13:31:56 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 1/2] bpf: fix a comment describing bpf_attr
Date: Mon, 31 Mar 2025 20:36:17 +0000
Message-Id: <20250331203618.1973691-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331203618.1973691-1-a.s.protopopov@gmail.com>
References: <20250331203618.1973691-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The map_fd field of the bpf_attr union is used in the BPF_MAP_FREEZE
syscall.  Explicitly mention this in the comments.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 include/uapi/linux/bpf.h       | 2 +-
 tools/include/uapi/linux/bpf.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 661de2444965..1388db053d9e 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -1506,7 +1506,7 @@ union bpf_attr {
 		__s32	map_token_fd;
 	};
 
-	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
+	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
 		__u32		map_fd;
 		__aligned_u64	key;
 		union {
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index 661de2444965..1388db053d9e 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -1506,7 +1506,7 @@ union bpf_attr {
 		__s32	map_token_fd;
 	};
 
-	struct { /* anonymous struct used by BPF_MAP_*_ELEM commands */
+	struct { /* anonymous struct used by BPF_MAP_*_ELEM and BPF_MAP_FREEZE commands */
 		__u32		map_fd;
 		__aligned_u64	key;
 		union {
-- 
2.34.1



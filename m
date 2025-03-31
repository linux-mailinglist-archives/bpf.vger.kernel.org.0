Return-Path: <bpf+bounces-54928-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE92A760F1
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 10:09:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91B1618886A2
	for <lists+bpf@lfdr.de>; Mon, 31 Mar 2025 08:09:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74E731D54C0;
	Mon, 31 Mar 2025 08:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OlEb8lRF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D9E487BE
	for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743408536; cv=none; b=ijYo2ongFeF8+oQmlFn+b0Tn6+QT2WbX0Wu/+Bg4l1SSXN8NKdP/VImpM5p2QNDBAvgEdu4JVQn6oZl43sZOzunrbfwpsbnzyDF9OxLDdhYyLxlrBza024mH75FPaQu40gVCOOtN6sB7iUu9k6z1Mc2sr8ZzmzBXSaSuvm4ZFuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743408536; c=relaxed/simple;
	bh=AgqxCsa7u7/GqrERlinz1v9hlQtSuvsGx3Ucq0DWxq4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KSZzIa3oiqLqS7cJPRcGCAziVRq39khbT2G30IQ1AU1VGSlE7CqH2DZMbQL5GX2O6jJT0Oo55zH3MZDGSL0P9MchIZBYV5lTuzV4KlnBXggIWZMmqfghYXSziZhUoAS/TiyQCnnriHj0h8WwdnQxVI0nOookkp5QKDawCxH8Gus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OlEb8lRF; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-39bf44be22fso2035032f8f.0
        for <bpf@vger.kernel.org>; Mon, 31 Mar 2025 01:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743408532; x=1744013332; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QTlRu/142GTJE4p4Az4hv9VEZYubzamXsEThiSq3AUA=;
        b=OlEb8lRFnOyRbW6vZKsDXjV8v32XXtxnpJJn/ju66MPtlzaCEFPYWEUxVULNnqKzkD
         q4WGiC+rHoOTiJkWBNf9HxLx30GXBkUjJQpZheVTL6TZSXOcbxTlorSiMGjbhpoHQpG7
         x5zTQ9NRPoUfWR4JoewGlZArX0UZYFkvYjhRTqJDvZeQXXeDyg6IjxLADd3+FPmLlDwb
         ZMV0jVa/PPfuFBgMYSfQSVYpStgSsowOQUU3974dRcF+3/XzH5RkPS1AGZjB7zPUDMYm
         sWCOBzGWZILM5oTymOXqprh4iGIlFGPylmha6EU+WjNaQIsDumrA6di4y7J5hvxPz7Dd
         QnfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743408532; x=1744013332;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QTlRu/142GTJE4p4Az4hv9VEZYubzamXsEThiSq3AUA=;
        b=Ut+fSlVdJC+1EDbOuLf7cHyAdS8QV5G0V1NHG1XgqS2f4dKLv32tRv6tQ6tMernOYz
         lKwwyLFgqJSiK27++0u7Y+WG0m/QCA3oKdhpui9ml1+S8wAcM7kCSi1pbSbmc2UI127G
         GdlRi+Ejr26njqPdKSdhcICbLalr/NY+/sCrUcY3V8yyXxRoT7sOa5/FLnssy5d/s74l
         rgu8hz5Vlu7qiUZJ2/Ihs0qXO0djmzXzU0Dk7Msy84vMN+HdMqqPFcpVQOVyhlNdYD5b
         Aorz2gfYWXOGl0PUfx9wLI+ZHK+KYTjCeRlrS/pG2oHZ580eyP4HKU1UiD/gnT4VhrJY
         zmaw==
X-Gm-Message-State: AOJu0YzQi52+dzqR1hjP+FAzvaVT9wgM5dLaPuLN9TAJAbPmVbIBdiYY
	d+PPHdZy9+vRQtwZaA33M8UrkrV+9QKSbYmJXxS/3L07DRTuTkzZRbSlmyf6
X-Gm-Gg: ASbGncvWGeiQVaRZaxhmVDQv3Vcdr8zWldSnmSjt9Pp5W3QjXu/d5t9X/7O60PHogES
	rT4U6lIcYvsGk6zvcQ03+ZLmqVRdDXB8UmSz/hMSwgbvhXOatBZ5NHJWZP3B6FoaCqNBVIgR8dA
	4oKulGEbNKUyycgBOLAZ1D1TfpF6o/8X6DQVKe+8p7ZRHIGs/S9Qy42PppfBdVMUSKivOY9kkpo
	d/5FSaEeKOPxOt68oqUHv1AshSECxPELvj3OR3Q3oB5yMyxwv0Zhxg0NgaFmQu/+hVXYBBIJNDJ
	si32PGAH/C0VyuCyhR3uCrYP1AtswO/ynvwwvVLR4a2KFeI4hhPP8yY6mtf+0Ub1
X-Google-Smtp-Source: AGHT+IHpNHa2I3zJ4Cg8hp1I6svLsSTwuJM/Bji+v3C19nQQ8KYxQaee03eCpo3yr21jBk0boIafRQ==
X-Received: by 2002:a5d:5f45:0:b0:39c:dfa:c3de with SMTP id ffacd0b85a97d-39c1211ccb3mr5616621f8f.47.1743408532053;
        Mon, 31 Mar 2025 01:08:52 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-39c0b658b5dsm10471987f8f.3.2025.03.31.01.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 01:08:51 -0700 (PDT)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH bpf-next 1/4] bpf: fix a comment describing bpf_attr
Date: Mon, 31 Mar 2025 08:13:05 +0000
Message-Id: <20250331081308.1722343-2-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
References: <20250331081308.1722343-1-a.s.protopopov@gmail.com>
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



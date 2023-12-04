Return-Path: <bpf+bounces-16602-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7E93803BE1
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 18:42:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E871D1C20ACC
	for <lists+bpf@lfdr.de>; Mon,  4 Dec 2023 17:42:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 023552EAE0;
	Mon,  4 Dec 2023 17:42:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jikU+oxI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79341FE
	for <bpf@vger.kernel.org>; Mon,  4 Dec 2023 09:42:34 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-5c627dd2accso1696776a12.0
        for <bpf@vger.kernel.org>; Mon, 04 Dec 2023 09:42:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701711754; x=1702316554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oclHkiXhP9AH9qxtZO4NZEqr37yXlDxNsnoG2f4TTTw=;
        b=jikU+oxIbJepbha1OTkJKnCyMd1mFh8aehjCIRYg/nEiwL8Tel5S7AB5TKgxHo26fo
         scxY/I2ZLLtLe3ppJGJFa7F+jJCB3pU6BeW1WVtqViWrV6YZdhdmL0XYnBoO4fXe61yJ
         LRZRh4YyaYAo5nSMIYolLAqdlbr0RcfDhz/Xs91RXbWoJ9tq4djH6+BmAuqbg4TUrTwo
         4cwHfvSHxDcFpFuTSwrwtti0EbTavOv37PpRDpOMjMkpYyiSw28CIUlc11qlnRyJxPep
         kgClByXAKUInPVWW3Lw6O0Q0INPpEikIX2JnaibW3rJi7JpgftSfFl9zWiS0iFDsD1y6
         yoNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701711754; x=1702316554;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oclHkiXhP9AH9qxtZO4NZEqr37yXlDxNsnoG2f4TTTw=;
        b=DVIJoS6kf4UtGbghPqRg1M/EhK1tIrzl547duD42Nu2Q5/cwFaIED9J8wgsCw4xnig
         N53EyFWSrofN6qoSXkBRYQkHGQY94Mw4f4JKGy6schVcrs02LxzouUTaLP6Za1bGf1xk
         eD9HxBxQjjair/KOko49JCW4fZoiCwDkhuFskkthDI31nu5nZy3rxrmMf92H2zzHE1Ue
         R937StFMXIVe8/lyVml+vK6nO2AbRc7oGCTYWxypM+HYsUgTkvFX3LPvcQt2+7JOPzet
         UobX6VqiwASCfPUm6Z3QKRnTFPx+UMKqTY0Rus94IgmImmS2m02uVy67Ux21gwvbwIU4
         t7cw==
X-Gm-Message-State: AOJu0Yz3r2MXG5vK1n4y2xyyYSGUvO0SpHeq3UvUXI12N0QlCRRYR1Kp
	wadJlaPsFK60NEtNyGjr9NuDAZ7Kf0+DZiciZYjKZeBDiIpsjZqYHDu5ptBWDhrjbuoLwaBhNwR
	P4eI7Gfl6MoKXqPu8l1k7G555C7cSmhQNhMbZ7Xhmr/ZyFOfScg==
X-Google-Smtp-Source: AGHT+IH5yAVIO/3R6uSF4o3BGdNrm5HO1yH9t7OQQdICWvUaAadHfp4HSnYzoDjRqB9kdScv2F3ApU0=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a63:2218:0:b0:5be:123c:5fc with SMTP id
 i24-20020a632218000000b005be123c05fcmr4147138pgi.10.1701711753640; Mon, 04
 Dec 2023 09:42:33 -0800 (PST)
Date: Mon,  4 Dec 2023 09:42:31 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Message-ID: <20231204174231.3457705-1-sdf@google.com>
Subject: [PATCH bpf-next] xsk: Add missing SPDX to AF_XDP TX metadata documentation
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org, 
	netdev@vger.kernel.org, Simon Horman <horms@kernel.org>
Content-Type: text/plain; charset="UTF-8"

Not sure how I missed that. I even acknowledged it explicitly
in the changelog [0]. Add the tag for real now.

[0]: https://lore.kernel.org/bpf/20231127190319.1190813-1-sdf@google.com/

Cc: netdev@vger.kernel.org
Cc: Simon Horman <horms@kernel.org>
Fixes: 11614723af26 ("xsk: Add option to calculate TX checksum in SW")
Suggested-by: Simon Horman <horms@kernel.org>
Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 Documentation/networking/xsk-tx-metadata.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/networking/xsk-tx-metadata.rst b/Documentation/networking/xsk-tx-metadata.rst
index 97ecfa480d00..bd033fe95cca 100644
--- a/Documentation/networking/xsk-tx-metadata.rst
+++ b/Documentation/networking/xsk-tx-metadata.rst
@@ -1,3 +1,5 @@
+.. SPDX-License-Identifier: GPL-2.0
+
 ==================
 AF_XDP TX Metadata
 ==================
-- 
2.43.0.rc2.451.g8631bc7472-goog



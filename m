Return-Path: <bpf+bounces-12712-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28A07D00E2
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 19:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7EBC62821F1
	for <lists+bpf@lfdr.de>; Thu, 19 Oct 2023 17:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1895636AE2;
	Thu, 19 Oct 2023 17:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="pfhCicow"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7EA374FD
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 17:49:53 +0000 (UTC)
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75A3B11D
	for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:49:52 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 3f1490d57ef6-d9a538026d1so11374118276.0
        for <bpf@vger.kernel.org>; Thu, 19 Oct 2023 10:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1697737791; x=1698342591; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=O+5AYyR/jNBakDxt1zQNoJ6ixNt0+bT1Lc6TVZJfgZI=;
        b=pfhCicowlpiEkplNiIemD+OQzieaAb9EUoDDo3Sn0J+bXRq0YpsVq/wZqPoXIRKtDf
         Oy4ER5dCOMc4exoWo6bKaOj04G4RkRkvF4RTrnnVctSpJDGYePp5C8wvaentgypKmrXq
         UZ7XmsgU8A8Drj/dg6EZpkC6BBlp+Wk8tQp4lKFbrZWBoCAd77Zp3SfrbqTfyJWasTxZ
         LKV/W9s2JuSDfKECx85EHApRJ7N46zhm/M1qBjnOht5vtJdjF86WkJKZPS17LsR3bxoi
         Upxp1gAzlFuG0h8HV7UPwoLb10KzG/C7xLPHVXlDXP6Aov+mCYGUpC15PwKFGIhaVwne
         CI5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697737791; x=1698342591;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=O+5AYyR/jNBakDxt1zQNoJ6ixNt0+bT1Lc6TVZJfgZI=;
        b=S6+s4KeD72AIMY0CuwS9P/9sfHHr4LYAsoSlPqT9fSTvsq1ZfNCL1oJdTtMMZ3aZNf
         vZzhWhIrh8L/ru3XQTYFKuLQQNLDXEBX7kzMy6ynSWfyqR6DbSJRatFXGXacmvnyrQXh
         fQGQHndZtHkJlqX1jOBJjA/9idQOyeS2FmN53q6BvbUa6MbzLbQkukngg4X1CBPUUvZU
         NHtfQYo3uvHQlcMdEvu9XLSNsLFcG+hGR3bk2GQypNs5HmT6KgC8g+rc+T7L7/TbUGKJ
         8WbhawqZtN9EFrX5gk1oZtB15Vy8+aF5rk8W0ct7SZm0zarvwh3OCEbyD6BHE2kOcCTI
         7qkA==
X-Gm-Message-State: AOJu0YwM0WqWC2oY3Q04P9AgzNm7aB9Bgh79PSJCt/qCFnUKnKhbIr0+
	QtB+b08lNbaS+dJkWkDH5iWSl/+TY45HUhvfA62AqGd2uCoGyGkKrOsSoejWyxfV41eNOVfAbCt
	9QP7mLcWszRtjkhaRkuixPN/4fdxnXjsokG0YKdcb+xpPDqui4g==
X-Google-Smtp-Source: AGHT+IF+6U1K2o1M3yW8aAnZpqMUW+oqpAG0sSbv/wmlpowAAYZII2r8d15MKzo3vCTr/bt0q2l4tzg=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:8490:0:b0:d9a:6b49:433d with SMTP id
 v16-20020a258490000000b00d9a6b49433dmr66530ybk.6.1697737791334; Thu, 19 Oct
 2023 10:49:51 -0700 (PDT)
Date: Thu, 19 Oct 2023 10:49:36 -0700
In-Reply-To: <20231019174944.3376335-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231019174944.3376335-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.655.g421f12c284-goog
Message-ID: <20231019174944.3376335-4-sdf@google.com>
Subject: [PATCH bpf-next v4 03/11] tools: ynl: Print xsk-features from the sample
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

Regenerate the userspace specs and print xsk-features bitmask.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/net/ynl/samples/netdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index b828225daad0..da7c2848f773 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -44,6 +44,12 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 			printf(" %s", netdev_xdp_rx_metadata_str(1 << i));
 	}
 
+	printf(" xsk-features (%llx):", d->xsk_features);
+	for (int i = 0; d->xsk_features > 1U << i; i++) {
+		if (d->xsk_features & (1U << i))
+			printf(" %s", netdev_xsk_flags_str(1 << i));
+	}
+
 	printf(" xdp-zc-max-segs=%u", d->xdp_zc_max_segs);
 
 	name = netdev_op_str(op);
-- 
2.42.0.655.g421f12c284-goog



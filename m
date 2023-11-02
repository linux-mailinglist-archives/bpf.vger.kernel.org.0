Return-Path: <bpf+bounces-14027-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 305477DFCBA
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 23:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E04BA281DA6
	for <lists+bpf@lfdr.de>; Thu,  2 Nov 2023 22:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704FF21106;
	Thu,  2 Nov 2023 22:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sHgr8sjh"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56F82233C
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 22:58:47 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C345B1A6
	for <bpf@vger.kernel.org>; Thu,  2 Nov 2023 15:58:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7b9e83b70so12190477b3.0
        for <bpf@vger.kernel.org>; Thu, 02 Nov 2023 15:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698965925; x=1699570725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yIQWlqlKx7HVoISOZnXwD//BGCQLkTId8oEkXKIs8r4=;
        b=sHgr8sjhD1xQJyhp5uq7ikcbzl/+zjcqkaIKHxi1RJjTMMPdUhR3HBIFD8hiTpx2lM
         9/ZDQQeA4o8CT9YcCVV0GW3jR7/YPdEwKIArKtDNcqE1DoWp6fOKSelozAZMUWKa12kz
         1C84Ir+tKSQQd0L+6pS3vlZfT7ny1WhCxJvjDWI4Xg35IJ5jbo+poCAVWnhDDH8fwmEF
         J/UPPmAt0JxnvNI9myYY/cvfJ3+tp40h/nAkJdESn3+Pp2RNlV1wVIyzN7vHDKYBOU/Q
         88pf9GV+M92NDl8d8619NVaUWBCDd0PkGcc+jWO9yuhW49dXc3viYGWNerCW5WnXS7TR
         14aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698965925; x=1699570725;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yIQWlqlKx7HVoISOZnXwD//BGCQLkTId8oEkXKIs8r4=;
        b=TQZA/Gzto4wUWm3COeSzAXFoh1h/6ievIj9lCTYpVpDd+7licjAmSfcTGWhTYOcoq4
         85vEbUPh0pjgppTrjx70btT95vCMdJCPNTUxdK/ML5wVPdlBePdX4DtOmcnJc98OYl2x
         XTyRYyVN2qFw8kfKsgtWxmAtc+zEPvRIogP8fYLi60pwfj/PQ7DaQJlxvcPsw5E3QnYU
         jAxsQEca75S3fM7ixGjgq8hOi2TZTXxKTPSfnrWmlaAI48h0MQnHb05Oy5HxF5bYRa9i
         xe5Cv1J1Y+xcE4SIiWzSj41Ohtdq4AHSwEijYgx+rbxV3HghCTD8w7OHAjKPzdVuY6xd
         /kLQ==
X-Gm-Message-State: AOJu0YxTH2DD9f4HF99P+lhxQH4240n8usj8nzxFgECZ+szo0YFNFIxN
	uTeZCbp6JwrCCWUdAyaHLhUvklstXCjM6gHc7lcZgZm84qmZwGiiJpCNLlceDIbsf2TvTKytg8N
	PaoNMZ2/6OIXw6l4HhiKiwFxm2/dcupc2FMeoMOuSn7ORGeLnqQ==
X-Google-Smtp-Source: AGHT+IGxEl/+xuhibdGZev48+wG7/mtLXtVNyeGjcD7sBqjMuhiBM+KGfxbvnH9d9S2CPir4NbnlgGQ=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:690c:88d:b0:5a8:207a:143a with SMTP id
 cd13-20020a05690c088d00b005a8207a143amr26239ywb.0.1698965924683; Thu, 02 Nov
 2023 15:58:44 -0700 (PDT)
Date: Thu,  2 Nov 2023 15:58:27 -0700
In-Reply-To: <20231102225837.1141915-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231102225837.1141915-1-sdf@google.com>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231102225837.1141915-4-sdf@google.com>
Subject: [PATCH bpf-next v5 03/13] tools: ynl: Print xsk-features from the sample
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

In a similar fashion we do for the other bit masks.
Fix mask parsing (>= vs >) while we are it.

Signed-off-by: Stanislav Fomichev <sdf@google.com>
---
 tools/net/ynl/samples/netdev.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/tools/net/ynl/samples/netdev.c b/tools/net/ynl/samples/netdev.c
index b828225daad0..591b90e21890 100644
--- a/tools/net/ynl/samples/netdev.c
+++ b/tools/net/ynl/samples/netdev.c
@@ -33,17 +33,23 @@ static void netdev_print_device(struct netdev_dev_get_rsp *d, unsigned int op)
 		return;
 
 	printf("xdp-features (%llx):", d->xdp_features);
-	for (int i = 0; d->xdp_features > 1U << i; i++) {
+	for (int i = 0; d->xdp_features >= 1U << i; i++) {
 		if (d->xdp_features & (1U << i))
 			printf(" %s", netdev_xdp_act_str(1 << i));
 	}
 
 	printf(" xdp-rx-metadata-features (%llx):", d->xdp_rx_metadata_features);
-	for (int i = 0; d->xdp_rx_metadata_features > 1U << i; i++) {
+	for (int i = 0; d->xdp_rx_metadata_features >= 1U << i; i++) {
 		if (d->xdp_rx_metadata_features & (1U << i))
 			printf(" %s", netdev_xdp_rx_metadata_str(1 << i));
 	}
 
+	printf(" xsk-features (%llx):", d->xsk_features);
+	for (int i = 0; d->xsk_features >= 1U << i; i++) {
+		if (d->xsk_features & (1U << i))
+			printf(" %s", netdev_xsk_flags_str(1 << i));
+	}
+
 	printf(" xdp-zc-max-segs=%u", d->xdp_zc_max_segs);
 
 	name = netdev_op_str(op);
-- 
2.42.0.869.gea05f2083d-goog



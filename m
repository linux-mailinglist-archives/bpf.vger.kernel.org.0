Return-Path: <bpf+bounces-15967-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D47FA989
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 20:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 457AAB21151
	for <lists+bpf@lfdr.de>; Mon, 27 Nov 2023 19:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA453EA75;
	Mon, 27 Nov 2023 19:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="yCqGIp0w"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B86AD5B
	for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:27 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id d2e1a72fcca58-6cb42be51easo5638403b3a.1
        for <bpf@vger.kernel.org>; Mon, 27 Nov 2023 11:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701111807; x=1701716607; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=NZmbhowMLIPaXt1/O5qGG+PgL70lJmkQfw56CCK9VMM=;
        b=yCqGIp0wh4kscly7TPfxKd8ENbvCWsBGz8UM0tXSFrkIlAvN3a4QmeG94+2NkL8f9g
         uAo/lbezA50R1bJhpwxl2iETPWJ1KUPDakkzYgkfpxiWbGD/0ZvDEzHePaqSWxkhHP1H
         EfUChIfKUrkEwDD+SSaTSEhULhTW7COugUYWJMnXiaTn/EG2lYwZL/Yd0SAjvpW8Sk3p
         b8i1prk7M+ptxJZfGVs3wsJZL9tGmlyoQZnJss/lkck93SH3gEiAxo7yw37aH8+BkaEl
         IflDKxk/H6OSvAsRY8E9HeMOrztK0ysaZ9N6Kw7zHJ0xCHXbUMc3/yNJJ+lRKY0xneaD
         vMsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701111807; x=1701716607;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NZmbhowMLIPaXt1/O5qGG+PgL70lJmkQfw56CCK9VMM=;
        b=nDjBBokVL2LQdElUV2MmgBv72ew2JTPE1Y23JOm1ko7ToMf5UBiguY2jUS0/LebBmP
         hUbmHjemYRQMqs1Adfh6BYKHkXPxr6T7aL18e18ygmSti5Na4DeUI8tetM/M6Szgj5GD
         erwvNQzmfhxXVuFLRoqlS1PZLzSwLT/OxAOtAjdecGjLx3jJDbyeED2BKPbgKwfAvx/m
         znv3WZXWjf4nBLju+isx/oJeDFNitujVhVSrFtK5xw4gQi76xxAUBTrlKj9Bo4yhCVTY
         S7IAxfVK3NqCLGpr6JwZ/TFfgHAjVy/gD/4v7+MzY0US28Yq84HeHTPxsojl5b7NC9Bn
         vZAw==
X-Gm-Message-State: AOJu0YzpexbxJqVm2bflDtaVejqarnn4A7FWl2gQaw8MBQr9IeKquOwP
	QihRRht0OL6W1xnGtdmugu9vXsFiEbQVZSpXGW9qQcfecl5XyjjMNEYcikfFFzFAvIB9AK0fz2f
	T3TnDD81ySrERQVZFtRtqHWpCkBI1yZhPYoMhYqbqEYyeHgrHSQ==
X-Google-Smtp-Source: AGHT+IFKylgGgz4FPHYQx7uLvq9IjNMDty/QvWbEOwBFCwVeAcMS9nY3gUMmOn56aiimoTypBJj+hDU=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6a00:3a12:b0:692:c216:8830 with SMTP id
 fj18-20020a056a003a1200b00692c2168830mr3426229pfb.0.1701111806732; Mon, 27
 Nov 2023 11:03:26 -0800 (PST)
Date: Mon, 27 Nov 2023 11:03:09 -0800
In-Reply-To: <20231127190319.1190813-1-sdf@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20231127190319.1190813-1-sdf@google.com>
X-Mailer: git-send-email 2.43.0.rc1.413.gea7ed67945-goog
Message-ID: <20231127190319.1190813-4-sdf@google.com>
Subject: [PATCH bpf-next v6 03/13] tools: ynl: Print xsk-features from the sample
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
2.43.0.rc1.413.gea7ed67945-goog



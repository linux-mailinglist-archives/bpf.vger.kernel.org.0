Return-Path: <bpf+bounces-22468-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96DC985EC1C
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 23:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1713B215B3
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 22:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410A86632;
	Wed, 21 Feb 2024 22:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="edL3vLAr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE673C470;
	Wed, 21 Feb 2024 22:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708556358; cv=none; b=a6qTvUG3YdXjPetVgKAPGYVhgBtx5N+RozWkrUK/rpKKmoRa2XzLPIlWAuI0xEHJ4LTk95DDt5rgYzbz9TCC1OXYA02keFaVQgDgYkABvlflOWPN2TxpkzRfgWrG5n9NMcEPyALja51pi3pid+mdqOQz83VXCd5ErQ5zpKKAEos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708556358; c=relaxed/simple;
	bh=8DszHd8Yh2iLgRH5yS1Ubvp/IpbprkrxBS0YFmimpR4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tXr6NcTICQPasPtmw6DGS2hGpiRHpPwVMH1/aERYbYwtwpEtihwQgFTvYTzed6/06az/lgEa2UTMA/KPzVzfOliZum32fpqutimdjlw297gO232EQ+RJDE9CDJCg3jDovcE8WdQCf/RLNmk3Y5OAQd3GEGSK8Yt2DYBgB79L9/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=edL3vLAr; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6079d44b02bso52642427b3.3;
        Wed, 21 Feb 2024 14:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708556355; x=1709161155; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ApHR3wqPEgShTz8EdjIgnsj0XrqO8wckCeRoLIO1Hlc=;
        b=edL3vLAro4/eES0SeMSbVmFS91KP/naGBIBwiR8hRlxHTHpZgLsL3Wp3MppxXMPjiW
         muMklmL+0Hc+vskwsmhK9lvIBQDbqSfTILUj/xdlj7qO4VYaFej1G6w0rouIJyluMBH1
         fbuPrOpk0WL5/Zy9WAczb+t1tSrcJiYyN/DHdK6mgqlO2vyJJO2ySI/AthfYCkrd9hpS
         ueZARtzugdyv2NpJUYYSdI4ewARRadLmUW0Uh4aYAKx/yVelETVhuAEmhnxJ7d6yNzcE
         i2Lqe9yf1iiAtlmP4zcjAb01StcizkXlDaljJ2bBOCdSOIDCN5muEm4ivQ+7R/0FylP+
         6Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708556355; x=1709161155;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ApHR3wqPEgShTz8EdjIgnsj0XrqO8wckCeRoLIO1Hlc=;
        b=mzympbhhHs2rts8arMSRCa7rVUAAWr1jDf4vIbBfvRKp/XZ2bYdF4DgV50Vt1yU8dB
         X6ufoDkkvVT0zdSrv3qoTHRvWtI0+aczucJ1V0ZrBMoXKVUZKKxOE3tDhHGlB5952Ey3
         Re81lGDmns6GfUEiKaZdjzyqZ+L2t1xIh4Jr1EE6f4i3mzO5kd+OWJSyNef4K9PTszYm
         NZVUfL306sF11y35ktE4C9SPI2bytcp1NuMyLiyaVxldQucI0xD4hp/UR/QAIuFTwp1h
         Gg4m6gKFvyYDA1ikUdCOjIbCFkQIAuzwt1t/Qe3f+cd86yvmh8nQkviOAMYQ7mTbdZGE
         Kzew==
X-Forwarded-Encrypted: i=1; AJvYcCXLFSYyd/ovPtEdRMGfdVO+jUMPe8LDyginIaVQ+oN8+0rl9OWrdvSlyMolDUOhUuupvBCrlIhn1odDjhIoG8KsTa75TZRU
X-Gm-Message-State: AOJu0YwjzLRT5tHQpeQI9pTOcQ5WitDsPiO2znML0OVZKIEYy7hVH1WH
	vAAvZayJb2yg3eh3w/NBtgEG5qSPweywztDvoC+4JYnp/hr86UZgmwRCknxR
X-Google-Smtp-Source: AGHT+IHiy7PkPnbN35acFNftsrHydVmFdo29ylKaVbWiUS2vDhj86RpTdukMThDBIg7AedqsjXPr3Q==
X-Received: by 2002:a81:ae13:0:b0:604:7b9e:f622 with SMTP id m19-20020a81ae13000000b006047b9ef622mr15760158ywh.30.1708556355445;
        Wed, 21 Feb 2024 14:59:15 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id s67-20020a0de946000000b006078c48a265sm2820090ywe.6.2024.02.21.14.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 14:59:15 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next v2 1/3] bpf, net: validate struct_ops when updating value.
Date: Wed, 21 Feb 2024 14:59:09 -0800
Message-Id: <20240221225911.757861-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221225911.757861-1-thinker.li@gmail.com>
References: <20240221225911.757861-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Perform all validations when updating values of struct_ops maps. Doing
validation in st_ops->reg() and st_ops->update() is not necessary anymore.
However, tcp_register_congestion_control() has been called in various
places. It still needs to do validations.

Cc: netdev@vger.kernel.org
Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 11 ++++++-----
 net/ipv4/tcp_cong.c         |  6 +-----
 2 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0d7be97a2411..c244ed5114fd 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -667,13 +667,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
 		*(unsigned long *)(udata + moff) = prog->aux->id;
 	}
 
+	if (st_ops->validate) {
+		err = st_ops->validate(kdata);
+		if (err)
+			goto reset_unlock;
+	}
+
 	if (st_map->map.map_flags & BPF_F_LINK) {
 		err = 0;
-		if (st_ops->validate) {
-			err = st_ops->validate(kdata);
-			if (err)
-				goto reset_unlock;
-		}
 		arch_protect_bpf_trampoline(st_map->image, PAGE_SIZE);
 		/* Let bpf_link handle registration & unregistration.
 		 *
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 1b34050a7538..28ffcfbeef14 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -146,11 +146,7 @@ EXPORT_SYMBOL_GPL(tcp_unregister_congestion_control);
 int tcp_update_congestion_control(struct tcp_congestion_ops *ca, struct tcp_congestion_ops *old_ca)
 {
 	struct tcp_congestion_ops *existing;
-	int ret;
-
-	ret = tcp_validate_congestion_control(ca);
-	if (ret)
-		return ret;
+	int ret = 0;
 
 	ca->key = jhash(ca->name, sizeof(ca->name), strlen(ca->name));
 
-- 
2.34.1



Return-Path: <bpf+bounces-22634-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 630FC86226D
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 04:03:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DD5E1F25161
	for <lists+bpf@lfdr.de>; Sat, 24 Feb 2024 03:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E09D12B9D;
	Sat, 24 Feb 2024 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M+Je6iTA"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12EDA111BD;
	Sat, 24 Feb 2024 03:03:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708743789; cv=none; b=c4nVIBBMt7FVZyVMQi010hX9UcW3PXPesHbYF/bDiFrOanYZgWNgYqN1bHqmt/ueygFWbNYFWm+B5pOpowyDxVnf4OpVOtG4tWrO8rqiS4s3goFKBHrT4YS/yRlCDYWY9mjbj56lwiUow2zA/B8s8Vw+QhuTgDJU/b41u4QvuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708743789; c=relaxed/simple;
	bh=jXerfatU1CwpvAHcMsYW6bl9Jwfiynfb9mgqJKQr9DU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tpePQS5s1jSHF+i/MGr27r2kiWPNCFt6m5tJ3xhpgWk5+EFM9sHh6/53UuLUNJwPfqJ76gcM5Za/ULgJ/1Zw2Tnf/h/N6fYtQ9AW73e76eX6n5Xop2QFfT4dXe/POHm1SlOSwUJ262vLcFViDynWvZi+4hK0TelhII6h6GrM4LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M+Je6iTA; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-608cf2e08f9so4452417b3.0;
        Fri, 23 Feb 2024 19:03:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708743786; x=1709348586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+FzNhVAX6d9zH/SLJZqcPC5xjwLaY0Izc8sijWP4CQ=;
        b=M+Je6iTAWO7thrbwNJKQpGUs1/cqdFM+2o8YFq/cDKkzNU8dUVMVbVyRAMPA9aNePy
         cfbsvQER2ZlDXS341heU9EU0tN5/JGItHRIV9TkfhqFX73rjy7FaaooGgw1UOWA9IYzE
         8bSfKlZ1oJ/7kM/fcIUHGwBl+FqbvVeYrjvwqqak0CmYbqTiKAH4IldYsYjHjBm9xmKR
         kEfnr0xEDiSdSD4peGTiO8Cj+wY0JDE+yNoWn5BSYgqMTClPXC+TJ40cYxecAWeW6y4D
         UnHTgPYOcauu6sAfzkK9EfQGtg8JSt3OH/vnyxc50oqm3cQvMc/iMWQ7DEOZt1KPeygn
         8MEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708743786; x=1709348586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d+FzNhVAX6d9zH/SLJZqcPC5xjwLaY0Izc8sijWP4CQ=;
        b=qDd3k2jYzuuq8FSUiypBrbSS9S4lHxetztNeu7wcLE4Mv1jBbyRdly+sSVWyON8s2q
         F4NUp0rFl3dKOA4F5meUlk2mnelqtnoQ5Xzsd/Do51iHhTHKxaz93aHchB3RIopZvLcg
         JMHOTZ/69GR31Tsb7hmH8v1uXfbIxsRwhN6Wvq+W4oGpnbYJWzbzkCGBB6DVYf2hXbn/
         JYtwQ2EWsvClL7A99fgbRoAFJ2xu08JzeFtKEN77Sg58GeginLX5UmFX6ZDbImsb5Sg6
         XCWDzfC5xcKhrJHM7E1jjGEps+kRSuSWVMzD58AF1tomTPjN37tRAJrpdbFO7IhNAmtE
         A8zw==
X-Forwarded-Encrypted: i=1; AJvYcCX46AlmG+wD7FtHE4LfJejQi7gHjAMAMoY3qN5JCWri/56rMsynpAcRa9MZYFgxE1sbODvDkfhEEszwCpGy5PFIeLNE+iaY
X-Gm-Message-State: AOJu0Yww5BoF81vIs6z/88paLAGpnwQIvqG8uV5Unt77MfUSXB9+UekX
	KiI/usQ+zSgdOTpvF9DWEXOlmH6jZ6CxguHrEXg1wRimXK+eJ1P/dZdDB2vm
X-Google-Smtp-Source: AGHT+IEDFwCUpHp9HcsjwTy+vd/T3aTI3OIfASsebByVaikRkaXtpdk7YWzI934phustI+ZNzNzjPQ==
X-Received: by 2002:a81:91c3:0:b0:604:3e53:758f with SMTP id i186-20020a8191c3000000b006043e53758fmr1698999ywg.7.1708743786577;
        Fri, 23 Feb 2024 19:03:06 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:f349:a51b:edf0:db7d])
        by smtp.gmail.com with ESMTPSA id w66-20020a817b45000000b006087a2fc6b9sm84515ywc.101.2024.02.23.19.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 19:03:06 -0800 (PST)
From: Kui-Feng Lee <thinker.li@gmail.com>
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
Subject: [PATCH bpf-next v3 1/3] bpf, net: validate struct_ops when updating value.
Date: Fri, 23 Feb 2024 19:03:00 -0800
Message-Id: <20240224030302.1500343-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240224030302.1500343-1-thinker.li@gmail.com>
References: <20240224030302.1500343-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index a6019087b467..07e554c191d1 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -672,13 +672,14 @@ static long bpf_struct_ops_map_update_elem(struct bpf_map *map, void *key,
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



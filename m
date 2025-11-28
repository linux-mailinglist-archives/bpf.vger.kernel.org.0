Return-Path: <bpf+bounces-75668-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA422C9062F
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 01:04:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FA2A3A932C
	for <lists+bpf@lfdr.de>; Fri, 28 Nov 2025 00:04:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3539A937;
	Fri, 28 Nov 2025 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b="V6pWVqvq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742509475
	for <bpf@vger.kernel.org>; Fri, 28 Nov 2025 00:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764288287; cv=none; b=cjfjksaQtps/8johZ4CBO0Ul+L+P2N2tPCJqZ1rskGNR4ybJw3jnpb5skkBiJxBvA4F0mf3namPI3g0557/dEJHWaIfHZmWtFFF3TpwIUGwn2KmHuSJflbO+cc8ksu1ZragJyZrZ2IZeXGt+VJWkRLI+6HtbaMv/pFYNNx83lxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764288287; c=relaxed/simple;
	bh=Rq6hPtU29mVWc08CgQ7jD+lv67qy1fRmI3I5be7NTwY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Wc0rShX8lbuHO7jlRxg3g7Gi1DpRx7FQQ7dhQ6hZMsdNHLkW0dECT8/Z4sJBmyNXDjAuKwzYG1opb64mB4J/tij5iHqrn3czKLyDqRYzPtmY03gO0Oo4Dss9sJ1NlPaVr6NVPPXOpLUqlyo/G1b3tcQRcOzC/v7rZIItU7jKJdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu; spf=pass smtp.mailfrom=superluminal.eu; dkim=pass (2048-bit key) header.d=superluminal.eu header.i=@superluminal.eu header.b=V6pWVqvq; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=superluminal.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=superluminal.eu
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-64198771a9bso2537737a12.2
        for <bpf@vger.kernel.org>; Thu, 27 Nov 2025 16:04:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=superluminal.eu; s=google; t=1764288282; x=1764893082; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mqfelh/GX+xBJmjeQjVwThJYuAe8oVQEYJ4JAP468m0=;
        b=V6pWVqvq6POawXwYWR9lowb1IJxrLCbCXkN+jBSLdCcsBgSb7qRc97vocXASLzfDEP
         bzCU0rBe3Git3pE1adSQjqqcB8ehJpwcEeORJXp+qyM5l224d8K41UDtkDPzF0FuMNd6
         kqeoGDb+gQTX01IKx7jWmU/ZWYLfN73x7+S7UYlcFQV1WlnNwvsRx0/LO1nKmqQwcHu+
         EP00H66el3H3Fnks/J8p0Xo2fDHcCR/683wJBVLYZFJN4qUVTI3KPizp6Kt6yx11eTPE
         kci0HlOg/qU4XudaIqyKTXfSuJ48AwZzZ1iY4hhTXzoo5S9GVu8vVH8UuJbKU0cEPxrD
         JR7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764288282; x=1764893082;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mqfelh/GX+xBJmjeQjVwThJYuAe8oVQEYJ4JAP468m0=;
        b=PgyrzVxvpLsQiFFJ0pLrUV3GqHk6stwfPSR87dW2GxTpi84EgaarUIHAr5el9bKtmN
         5sunfX+8L3k0XXS1s2xnpREaueqn1GFiR2ddy24/u6ArbWUDUEN6RMn7y3IH5an1DEcj
         36Dhol1RoV7G80VA4LOTtaeDiDIV6+a6RoyR/PGBwmnnjBX5xmEKJpHltYTaEerFMU5l
         e8nBWXROvuvjuwZdmw3vPQfPl4IXCYbKnwoA1f+8y66DUX4I8w/ofI/haiWZPzy+b93E
         tEkHZKv21SOabrQaM7d8IjdE+OwXHbQBgxToB09NXzqs69q64JVHO9pJGv6Cw5AHkveB
         vCyA==
X-Gm-Message-State: AOJu0YwQnajKNVD6dQybG8MFz+R6jm42PG33bOyp1aIo3n3BAhGp7hga
	rbQQ2OAP085KLK00TkvtcnSWRYTrBWFbHF5JRM6EMJagQubrfVho428Y26O1/ITnYQ6gG3ssPRW
	ySpNC
X-Gm-Gg: ASbGncvK2rphuFPbOgxK4EVtamfZscdAyD1uDpLj5yx86TystZma8EoE7VrhnJHgDAN
	95JRl3B3tsxnbVYdz5jiXy08gBzg8XG2nwPbiZouM24WGJzwCMpZ8HQKuKJ+dHXLQGgLOgCnEbB
	hrv0yPhHYfUIwX9fX+7M9+HTB4AGy5C+eERsc53TfLUJx/ci/X2qhk5nB4zyBHCz9ck8BQykYPh
	bolEuCAD2CcItf5VLviF0pAWW7FwEB5AgHkpxmdTwoNQoDFGpTZUwQU5aAMcNqMqXsCmNRPyAhi
	fDeZnh0sPxtw0RAigF5slcEtm6G/Ex2uYTomouCQtosU6Zog7Wfi779gqx2WAycE7kbVPUkfGak
	y3+RT2f29vir36z+qRAED17Y0hRqBmmvDfMfQhiWePxLP+ikXZtRqCu9Rh2SH3uzKM8fdB9Q1HH
	Cb70PQf5tPKVfTQ1Myra4ZVzIB9AqOYRG/+EjsD5BaX9PVf7HwwXzTynsjTjBC48un9GuHg+BD
X-Google-Smtp-Source: AGHT+IHyAZ7sLzD1W1HU2LvKBM4uXOfEIajqtKrFs5YCyredoiSPBhPH9ZK2QPwg6vuVanCil+5JHg==
X-Received: by 2002:a17:907:72d1:b0:b73:5c12:3f8a with SMTP id a640c23a62f3a-b767158cbe7mr2959377266b.18.1764288281501;
        Thu, 27 Nov 2025 16:04:41 -0800 (PST)
Received: from ritesh-fedora.localdomain (228-244-145-85.ftth.glasoperator.nl. [85.145.244.228])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b76f59aece0sm286581766b.32.2025.11.27.16.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Nov 2025 16:04:41 -0800 (PST)
From: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	houtao@huaweicloud.com,
	jelle@superluminal.eu,
	Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
Subject: [PATCH bpf-next] bpf: optimize bpf_map_update_elem() for map-in-map types
Date: Fri, 28 Nov 2025 01:02:35 +0100
Message-ID: <20251128000422.20462-1-ritesh@superluminal.eu>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Updating a BPF_MAP_TYPE_HASH_OF_MAPS or BPF_MAP_TYPE_ARRAY_OF_MAPS via
bpf_map_update_elem() is very expensive.

In one of our workloads, we're inserting ~1400 maps of type
BPF_MAP_TYPE_ARRAY into a BPF_MAP_TYPE_ARRAY_OF_MAPS. This takes ~21
seconds on a single thread, with an average of ~15ms per call:

Function Name:    map_update_elem
Number of calls:  1369
Total time:       21s 182ms 966µs
Maximum:          47ms 937µs
Average:          15ms 473µs
Minimum:          7µs

Profiling shows that nearly all of this time is going to synchronize_rcu(),
via maybe_wait_bpf_programs() in map_update_elem().

The call to synchronize_rcu() is done to ensure that after
bpf_map_update_elem() returns, no BPF programs are still looking at the old
value of the map, per commit 1ae80cf31938 ("bpf: wait for running BPF
programs when updating map-in-map").

As discussed on the bpf mailing list, replace synchronize_rcu() with
synchronize_rcu_expedited(). This is 175x faster: it now takes an average
of 88 microseconds per call, for a total of 127 milliseconds in the same
benchmark:

Function Name:    map_update_elem
Number of calls:  1439
Total time:       127ms 626µs
Maximum:          445µs
Average:          88µs
Minimum:          10µs

Link: https://lore.kernel.org/bpf/CAH6OuBR=w2kybK6u7aH_35B=Bo1PCukeMZefR=7V4Z2tJNK--Q@mail.gmail.com/

Signed-off-by: Ritesh Oedayrajsingh Varma <ritesh@superluminal.eu>
---
 kernel/bpf/syscall.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/syscall.c b/kernel/bpf/syscall.c
index d5851800b3de..ea4c19ae3edc 100644
--- a/kernel/bpf/syscall.c
+++ b/kernel/bpf/syscall.c
@@ -158,7 +158,7 @@ static void maybe_wait_bpf_programs(struct bpf_map *map)
 	 */
 	if (map->map_type == BPF_MAP_TYPE_HASH_OF_MAPS ||
 	    map->map_type == BPF_MAP_TYPE_ARRAY_OF_MAPS)
-		synchronize_rcu();
+		synchronize_rcu_expedited();
 }
 
 static void unpin_uptr_kaddr(void *kaddr)
-- 
2.52.0



Return-Path: <bpf+bounces-75988-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FEECA1786
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 20:50:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AB3603009976
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 19:50:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D644261573;
	Wed,  3 Dec 2025 19:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G/xQGMJW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C3925BEE5
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764791453; cv=none; b=JKLRO2yAPNLNV15NQD/QzmzcZwcmWnFVqWnnG2FnHh+bTeK0umFlknpeJLWn3ODgMNu09cJk/xxANneTQlBy9eXpMFYFk4rII/LhIAvnn4B0oFVvWmvTFj60eq2JFG2entKN7SeLoOO+SS5+DuLVSgYeFIKQWsdG1HoSdP2wU/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764791453; c=relaxed/simple;
	bh=41dOtqusncN9E2RfssSyTAfcSjKvqVItBQd+KmrBNRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iaU9VOcRmZd+rTsP8jTlkqBiQdr0rqqVQGbs4Gb1mrxgeBWMuEbJvfm95UsEU9a9/rU3VDC3+5MjEHYCa13w1cYXFIcUb7WWbfPF6VpDgoLZsmEPG86pFEDH6BoGy13ZKYkXyPnxJlEPmUsp/3S/YIwVZ8GDVUMhEQHkbcyuGDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G/xQGMJW; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34381ec9197so60286a91.1
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 11:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764791451; x=1765396251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JZy5D5GLl5XXXWjejn5nvOMqw72T5HlKWbW+3+0EFlI=;
        b=G/xQGMJWKPEikChPCFVH5foN8qVGKTcoVkvo2LqLKkjE1vGlA/iFpO+PU7o60Um3I+
         lF/EGsNpISMkzhCVSyFlsMcOBQ+VtH0FV3LTVb9O6LhG7a1NWR1W+Bio/rzgZjfgZRvW
         4GPaam+CXtfHtj/GcJUVjstsBzFXjNAHGr/cQ+4b2zXehdmrg9I/rfh1fdfVm6LBizQn
         dLx+ZvnZvmMbKt7JIv1HGsW6ykL5ADGpv1lGNzlBV9joQR1fZZ8cfTAwlbMwND4ztUuQ
         p0IJ+KwTxzslrGalGTf84DGlTBrn+Z+Q3D9inzkmVa8/h11EFluP6cr4JI7CJ6bsCFt7
         1tkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764791451; x=1765396251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JZy5D5GLl5XXXWjejn5nvOMqw72T5HlKWbW+3+0EFlI=;
        b=r4JQCfy+wwhXG7i1JfyTdql5EAbos6wK3iUKTpW0fQyQRIEIHRsrLEZvfE7K/9DJQr
         IqhK2xwHJEbE1551eRWLiAxOybym8cE9EPh5FKsV4M7K4cEJzWozwmbH3pAbIZPWbWsI
         Fs4OnzrI74iwoql7tuIxWKHok7OAqJwvX0EiXwmxZHCV/rFkkF7Zfx8DhPn4pHgeQjjI
         Z7a7G1L0Ey+YG7/b+r9bQ9/hh9vPIJTF8rJTuqamirbzvG2s5VCxXjlsG0jVNZdKfXOH
         kZp3IANPIdJ89pdnYN6FHINOeYW3QNFMZFFoMFWKUcyTLXtAugcXqwWdfRlZUWP8ltcG
         JCMg==
X-Gm-Message-State: AOJu0Yy6MX+TPVfFIQuoXWmMPj7sEPz9IaNZ3TBao1aO4O4oMPhGS4jn
	a30SvOjvW1qmTA4HjsSRk69ysH6SlWgUwkDR7b8z/CwOhFAmS+vgZujlNMtrXA==
X-Gm-Gg: ASbGncs/RwmThG7xSpUOEzX45kw9thswqt5pWchY6Izu7781S7Gs2QM9uhTCRrEHp6P
	8ESnvnB0dLec6nvuNkPwybC0/X0/3sKEdK0BLh2ZCH2tVw6Ra1+kODXWsSxwRoOLXeunJLr1MZf
	cj1l105yd7n3nl7+gqk1z9h1bhOuRmY1YNO8oTvhLhjk6hK0vxDBPaCRSMwbv46ehT1ktML8nM9
	LeRd5ybOQKETqDdiQ2AJlQi8oDAH9UV931+TrRCE3+9+DM7qWE0w0nKRFoi/Tgx+kdHNBewvBcn
	OsHEVahHIeYj/w04f2DoRRxFS9U5OZOBQEzjoEqkDAsvjjEC35ha//+gjBrVKJ0lUpDZXojp1LR
	BoEveaJLfGK1HbFlIu+uJPxxtpIvRR/Tb88bTcHMGXyVbfl2kBQJRvqvPqZbC2znlovQLcewm7m
	rlyE/Hc8V+wDUoyQ==
X-Google-Smtp-Source: AGHT+IHOHZKu1tD3C7dheKK6IXn9qUP02Y/Hksu+lMmybqUg3OQB9VcXGw0tYMjBgucWCzZ+7aUltg==
X-Received: by 2002:a17:90a:d444:b0:340:54a1:d703 with SMTP id 98e67ed59e1d1-3491270155bmr3679106a91.35.1764791451414;
        Wed, 03 Dec 2025 11:50:51 -0800 (PST)
Received: from localhost ([2a03:2880:ff:43::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34910b9ee6esm3579735a91.5.2025.12.03.11.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 11:50:51 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v3 1/2] bpf: Make sure all tail call callers use cgroup storage if the owner does
Date: Wed,  3 Dec 2025 11:50:49 -0800
Message-ID: <20251203195050.3215728-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
by requiring all callers to use cgroup storage if the owner does.

Cgroup storage is allocated lazily when attaching a cgroup bpf program.
With tail call, it is possible for a callee BPF program to see a NULL
storage pointer if the caller prorgam does not use cgroup storage.

Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn/
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index c8ae6ab31651..e249ea98f55d 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -2403,8 +2403,7 @@ static bool __bpf_prog_map_compatible(struct bpf_map *map,
 				break;
 			cookie = aux->cgroup_storage[i] ?
 				 aux->cgroup_storage[i]->cookie : 0;
-			ret = map->owner->storage_cookie[i] == cookie ||
-			      !cookie;
+			ret = map->owner->storage_cookie[i] == cookie;
 		}
 		if (ret &&
 		    map->owner->attach_func_proto != aux->attach_func_proto) {
-- 
2.47.3



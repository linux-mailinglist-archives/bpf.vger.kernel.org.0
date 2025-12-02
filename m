Return-Path: <bpf+bounces-75898-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C444C9C5C7
	for <lists+bpf@lfdr.de>; Tue, 02 Dec 2025 18:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A82073A2551
	for <lists+bpf@lfdr.de>; Tue,  2 Dec 2025 17:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F5842C030E;
	Tue,  2 Dec 2025 17:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vjmu1rLz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28362222565
	for <bpf@vger.kernel.org>; Tue,  2 Dec 2025 17:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764695779; cv=none; b=BCjfmuJDVipqw0ncLBWqpNlXKoBH8zNDXsaX1X08hCie80Da8yooKjUAOrvtQWV5/AENzDeFbMi+3rWwLPBmlhcfdzIgDQQeo0VoWSvm6QYMtkvDturRl+l4Dy5upOCtWKlckukBvo4rChtWyCg+4wK2oJrQ/ZX0sxK/0/VwRVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764695779; c=relaxed/simple;
	bh=17Y0XO27mmu/toiuHtUHAQq4bly4uft3m6Xn1TFd0uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rLvMRnmth6ROTZJsHovYsZ60x/Q+4AIZlyJyMQCjY151YYkdEs0PiVqkdOMjsbu0ac6LX4x4MPnx+YO10ybv6nB5VtyDCM4xKXLk6IY0xcPRAVZ+yh4gGALhxgCR+99wV4z5jSlB3HIdUq7yMnyd7MZTtKPm4mwl1f3gnx6s3GU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vjmu1rLz; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29845b06dd2so75966015ad.2
        for <bpf@vger.kernel.org>; Tue, 02 Dec 2025 09:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764695777; x=1765300577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KX1cJ0mYzITSZGbbk27b8/+sceC0x3Oa5gy+iqIrAiY=;
        b=Vjmu1rLzdmS9MJWUSL5EgiBheJyaCrjLmL/Jg/hLKDaU7c3hFZLchi7P/ReiByTApZ
         mZBbVqUZETrcGbWlKMVhoeyMa/RJZWXSBK90fK4Wfc9n1dEdeGqhBAg3GDhTq4eAi12G
         1AELN6WuZaR10VHPlTAwwnma7hiniGfUNN5MraiEC+v0SYBv+wGmqUevN/EPqsVAyBGe
         8l0OGaNWSSPOde+NQSdMircaUAfTEZF4IcjK10lJADcbITDyrdbfHulJ/YUM3tebw3Q6
         PwfUy+nfAKnSTpLyLWtZmmAM8DlBRr/3Yb56YbRYpSX4L5abhrZBArdA7ZAyQAIcKWU3
         2Yfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764695777; x=1765300577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KX1cJ0mYzITSZGbbk27b8/+sceC0x3Oa5gy+iqIrAiY=;
        b=Gr3rIQ0+gxduyqO9ZGteIOvPnBzq2/7Pk0s1WYxOkJ5O4UUdVSzNwuGTbzTQzSLj2G
         e42a3UaFaKn9eyh1juVrpPIKWHuwyoZ8BwG5+rD9uvVkVGPL1w85GidIOon8wl7XFmGb
         vMJBxZfQuAsm1x1ljVFAqIIkuK73DbR5kxkhX6lwzZ6QPEZzP5K5uTHV5kwBM2ecKK/g
         MyH3TAmv88ZyMf/cZYHXlJ25eVbFqvpSR0NW327uGcOGpS4PhjJSui/PLHDW5qteP3vn
         kZR4lBh24tKVfowcxZCJbq8pgft85W8GmNWW5TJd4gKszhaZ977uJ8XQcEvJ+wNVlByW
         77Yg==
X-Gm-Message-State: AOJu0YxKwvaHMJ6K3FN+/SmXGEDb0XgJEzvpwDCN+waoxs1YhLd5hyMH
	NrmdofGFCTPZnqmfQfwHLeEdKwR6ef7CeNeWL2LfnXbIBGIpeGfwO3wZnDjxMg==
X-Gm-Gg: ASbGncv0ZBZ3yFltHB0fKcpkJVqygjJVNzEMjcmN0iOZRJHjRAilHPVqeq3CC530s9g
	C2ddCMd2SsRDWaiBB4oGNvYYy1zmXhucLOwgR1ePnWmxoXfQBe4tJYjehmXrXtaiOCaWeVHJWS7
	D5uNvTrq2c2wv/PAd1s4sZyPL8gCKdqeemqfl1KXNVgY6kRY/Q7B8ic2xOPoUEe+Eg4OHcYWXU+
	/LNVyGWP2E5MxuvLA6AGFtJidfWMKwjOonf1HDHf8SXnZxctyAoPwCub29FIl19XzVN5bZaeAVd
	N3JHdQLAH0Hql0gfzjGvXGtZA66XKrY/tX1auNL8hrqeFIcavlJSSbnD3eiIqHPWzKP9lounuIY
	QFLE3OqCAYRgq2XgyoWutwI2wNZnqMvMO74SKZk8Zt4cA6EDjiaHBjh8MOimuakMpdRgT5Y0LGU
	zc5zi0bgUHwmqyJA==
X-Google-Smtp-Source: AGHT+IGQ4S51Vrai9feiSZx3qMe+rSfhtsa7eVXTEMovritIaLvnqt55H9woOkQykXHGkDwIEWy92g==
X-Received: by 2002:a17:902:c94a:b0:295:fe17:83e with SMTP id d9443c01a7336-29d65d0912cmr470515ad.19.1764695776677;
        Tue, 02 Dec 2025 09:16:16 -0800 (PST)
Received: from localhost ([2a03:2880:ff:19::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29bceb276a7sm158074465ad.48.2025.12.02.09.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Dec 2025 09:16:16 -0800 (PST)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	eddyz87@gmail.com,
	ameryhung@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf v2 1/2] bpf: Disallow tail call to programs that use cgroup storage
Date: Tue,  2 Dec 2025 09:16:14 -0800
Message-ID: <20251202171615.1027536-1-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mitigate a possible NULL pointer dereference in bpf_get_local_storage()
by disallowing tail call to programs that use cgroup storage. Cgroup
storage is allocated lazily when attaching a cgroup bpf program. With
tail call, it is possible for a callee BPF program to see a NULL
storage pointer if the caller prorgam does not use cgroup storage.

Reported-by: Yinhao Hu <dddddd@hust.edu.cn>
Reported-by: Kaiyan Mei <M202472210@hust.edu.cn>
Reported-by: Dongliang Mu <dzm91@hust.edu.cn>
Closes: https://lore.kernel.org/bpf/c9ac63d7-73be-49c5-a4ac-eb07f7521adb@hust.edu.cn/
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 kernel/bpf/arraymap.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 1eeb31c5b317..9c3f86ef9d16 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -884,8 +884,9 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 				 void *key, void *value, u64 map_flags)
 {
 	struct bpf_array *array = container_of(map, struct bpf_array, map);
+	u32 i, index = *(u32 *)key, ufd;
 	void *new_ptr, *old_ptr;
-	u32 index = *(u32 *)key, ufd;
+	struct bpf_prog *prog;
 
 	if (map_flags != BPF_ANY)
 		return -EINVAL;
@@ -898,6 +899,14 @@ int bpf_fd_array_map_update_elem(struct bpf_map *map, struct file *map_file,
 	if (IS_ERR(new_ptr))
 		return PTR_ERR(new_ptr);
 
+	if (map->map_type == BPF_MAP_TYPE_PROG_ARRAY) {
+		prog = (struct bpf_prog *)new_ptr;
+
+		for_each_cgroup_storage_type(i)
+			if (prog->aux->cgroup_storage[i])
+				return -EINVAL;
+	}
+
 	if (map->ops->map_poke_run) {
 		mutex_lock(&array->aux->poke_mutex);
 		old_ptr = xchg(array->ptrs + index, new_ptr);
-- 
2.47.3



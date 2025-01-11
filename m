Return-Path: <bpf+bounces-48626-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1591DA0A323
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 11:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2404E16B5B3
	for <lists+bpf@lfdr.de>; Sat, 11 Jan 2025 10:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A54DA191F8C;
	Sat, 11 Jan 2025 10:55:35 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f99.google.com (mail-ej1-f99.google.com [209.85.218.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CE914E2C2
	for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 10:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736592935; cv=none; b=Zdr64LJH0TnwVURvZQiWPQd+1LgMFdSGBVDgjye97zirbOxT2BRWiOx8AchEWKKbhxSEV4zhTG41gc04WKvYltPl2bMeDNBpcpwb7PVjW9ZGZiTuciSvxbU+j7mxOZOI6yuVOyUVnGChqJLRuY6g0RwKubNR2YkpdoqsT661Oi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736592935; c=relaxed/simple;
	bh=8npYrN58jYhQhXEVi28oZkfeQ2XvXdLuzCTz9w0JoJg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cPmPNHqE+YhcUnSpez29XvbPEwLNvv64XAalkvx4HvzSFRb2Npf4Hy09FPBfMyMqY7EDy6xsaahQ7OxhMukvBGNlJkbm/w6QWtG02Kq+C1IxkWOw0HoR/n6o8tz79/qWQYLJtyJz9Oc0W4a7j/76Pw8W54t4AxF0lShuZIFve5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=eurecom.fr; spf=pass smtp.mailfrom=6wind.com; arc=none smtp.client-ip=209.85.218.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=eurecom.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Received: by mail-ej1-f99.google.com with SMTP id a640c23a62f3a-aab925654d9so548400266b.2
        for <bpf@vger.kernel.org>; Sat, 11 Jan 2025 02:55:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736592932; x=1737197732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lXcq9nJZwBHlJS5PmX6lTzRjLEf4mQmNV6q14204gzM=;
        b=rpIZRVXEjkSHJTgbpj9bNFSH6j50y/G8Md4FIybTG38WVIoqE7YUWhMBfj6pkkk9ZJ
         t/Iazl/uhSEKyfDf4Jt7YCkdzPktr77ZBrXWb+wbe+USBSSzETzEh1nnSoYoKtFctJi3
         gSNCDlUwKPv2+sjRJLqSvHq3uH31zKA9I1GJt7Me5nh+aAJ4hpoN4VGD/+OVCnzjmAxZ
         h5AQRhSh4OYQVH4jwgP1fPetuhjRePCkMIbcJP5VcTcSikGjh2+0cy9wSz67LX++f/Uw
         tQhu0i5X38/SmK+E2iHmn3II+HjtRIcm7gux4aHVNu3oRUqA0trUCLnd2AOBpbpAYZz7
         39xA==
X-Gm-Message-State: AOJu0Yxky1snkVEGuoJA8nhZ+nEvnKaoVcIl3gwyFH/9f4OlNAE/zE6/
	QaTYFTPsd/etnUbH1r2IMMYu3jBzxHIBKTLgI40l4bzX9A0UOQ4B2kxCpWxJh/M4XAFrIK4deeL
	qtqHhGUnaNzAyu5TwTjO2w26yNxqykpCP
X-Gm-Gg: ASbGncv/nQ8SFedat/MQTL6AopVXhgNVMDTBcmUzL3LEbkJssKT5lFi1XL/DQpcqo83
	GJ7OTBL4ATDryQLd5stVnR/61tuuORfRL7p+EGa+slG3UNR3DbmdflSOwnyOD9HvEoxtNojbSzg
	7Z4S+o5/Ugrmfg5fHLciviAIKWB08WbkuoelNJwSa8rQUyVE1Xg4QNdY6+3PnCtAWn7nz0iQacl
	sEE5FfKlHiBsOqtopy0jg491HDGBdrQcDmPXD7ZwJvZWYr5Ur/1EhPgqvp7FIpippFQtJoChmhu
	zboc9nekhVgjSJnCiPCrcvdlXQ==
X-Google-Smtp-Source: AGHT+IFf5lJGPQOXqmsOQltHAlc/UOM2nRzKPlJWOqNPzcreHNtKgbHSbhYI1fIeBQq9xdD0k1CySNJIvoLL
X-Received: by 2002:a17:906:f58a:b0:aa6:b473:8500 with SMTP id a640c23a62f3a-ab2abcaafb9mr1202982566b.42.1736592931534;
        Sat, 11 Jan 2025 02:55:31 -0800 (PST)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id a640c23a62f3a-ab2c9560e67sm23465466b.131.2025.01.11.02.55.31;
        Sat, 11 Jan 2025 02:55:31 -0800 (PST)
X-Relaying-Domain: 6wind.com
Received: from localhost (rainbow.dev.6wind.com [10.17.1.165])
	by smtpservice.6wind.com (Postfix) with ESMTP id 5EC7813487;
	Sat, 11 Jan 2025 11:55:31 +0100 (CET)
From: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
To: bpf@vger.kernel.org
Cc: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Subject: [PATCH 1/1] net/core: kernel/bpf: Remove unused values
Date: Sat, 11 Jan 2025 11:54:45 +0100
Message-Id: <20250111105445.3830433-2-ariel.otilibili-anieli@eurecom.fr>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20250111105445.3830433-1-ariel.otilibili-anieli@eurecom.fr>
References: <20250111105445.3830433-1-ariel.otilibili-anieli@eurecom.fr>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

b gets assigned a value, but is overwritten before being used.

Coverity IDs: 1497121, 1496886
Fixes: 5ce6e77c7edf ("bpf: Implement bpf iterator for sock local storage map")
Fixes: d6c4503cc296 ("bpf: Implement bpf iterator for hash maps")
Signed-off-by: Ariel Otilibili <ariel.otilibili-anieli@eurecom.fr>
---
 kernel/bpf/hashtab.c      | 1 -
 net/core/bpf_sk_storage.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 40095dda891d..23b457536105 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -2039,7 +2039,6 @@ bpf_hash_map_seq_find_next(struct bpf_iter_seq_hash_map_info *info,
 			return elem;
 
 		/* not found, unlock and go to the next bucket */
-		b = &htab->buckets[bucket_id++];
 		rcu_read_unlock();
 		skip_elems = 0;
 	}
diff --git a/net/core/bpf_sk_storage.c b/net/core/bpf_sk_storage.c
index 7d41cde1bcca..7c1b79dcd996 100644
--- a/net/core/bpf_sk_storage.c
+++ b/net/core/bpf_sk_storage.c
@@ -729,7 +729,6 @@ bpf_sk_storage_map_seq_find_next(struct bpf_iter_seq_sk_storage_map_info *info,
 					 struct bpf_local_storage_elem, map_node);
 		if (!selem) {
 			/* not found, unlock and go to the next bucket */
-			b = &smap->buckets[bucket_id++];
 			rcu_read_unlock();
 			skip_elems = 0;
 			break;
-- 
2.30.2



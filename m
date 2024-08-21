Return-Path: <bpf+bounces-37698-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCBF0959A89
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 13:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B0B72820B9
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 11:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83F5F1CDFAD;
	Wed, 21 Aug 2024 11:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gc3E1xrv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE2A16D9B4;
	Wed, 21 Aug 2024 11:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239503; cv=none; b=Vi6dE/SvtoLWU30JpxY9JoNHGYOV0ICTxzJ3xXQyvCHVSObcz/hFtXF7Lxjjc00EUq+laPAVDLHVBSt9EL7uHrHRMO4Ta+x0lklTXJMIPf122vy1KtKf5SefpV7t1pemS2Fzwf7Cf28WY/YaINF+K1q0tJvTJw+GRD30/kX4n6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239503; c=relaxed/simple;
	bh=K/u6kXC3sS0dc6tnotjLO3Db8ukBo9LlGX69zS7MR4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mh41pyfrGIpk7cn1UcVTtq481bVRZMtsuOGQ91nXxgmO1e8EeYjo74M2+8OrVS3AfKHHdlcWwaWmjrCUKqhSnxhpQRexWmmvjw91UDRtzsdpHFTQ4wE5qMe7Vz1c1YL69lsqR0cnjVYVZ0BYCY0GNyzpm10a7eqd3xOAPx+ovLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gc3E1xrv; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-202089e57d8so4507655ad.0;
        Wed, 21 Aug 2024 04:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724239501; x=1724844301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ObPUc1mIg6ZtTw85xPS1olbYrr9JPBFQQQUdAwUsKfw=;
        b=gc3E1xrvFpTP4qj4gKjW1CxbVl0LsPTSUQaPC+ydD0UotpQEIHp47nki3Xk7r3Zsjc
         eifYNg/Pdm7eihKJwvy6RRhk98N+FZelFuLs7hEHn9WaaP+OkQZmdr8LI8NWQo4tOeH2
         EGGkvpG85S7j0KHahH3/YWWrmC99YfipnEePQ0QVhSx1ew180euMSoRXW4753A6CrUjD
         Ob0b0NTeTo1Gl9MeeCvtaP4vmdsvSweCDouAN4Z0ouixn2OGMIlq7LNQb0WJtB0LGhMZ
         IqrXnJLlP7gX41wZMQ8kX7iwEBaOia8H3BR4peEfQgpd8XI5Hu2eTJ1/9px87NHtnAVq
         E3eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239501; x=1724844301;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ObPUc1mIg6ZtTw85xPS1olbYrr9JPBFQQQUdAwUsKfw=;
        b=gfUQtAXz4bBABMMd/Lno0SWuIgtEcSncFNPQyOuJFKqJVPFAaIV9zdR9LjwcxzNr2j
         0gWA2DJydU0upfnv15dnmpV/6bhENwG6V1L2aLAGGGkqIowfoCtUxV/edVC70tVUSDtw
         wF+WTwctIL+E4Tp/A2k36qGK5Oh+PoUrCOLarcaZdupwBpj5KLdEyQE9MgsiS7UxcQ9v
         D30sP7CXMALhMi759hxi6XJCnqmCtj/0bTRl/ufgQnCJU/F0LCCDJWnTyO9lrjC86bO/
         GF/HHDSbyYFMtmmHPKfGhCukj+kP5x/0XPKQt7wf7IIJSj7Ow1S5jzN4KcU/UcGBgSyg
         tDXA==
X-Forwarded-Encrypted: i=1; AJvYcCUG77tiDN4I8OcgcXuQ34FTPN6i1+QyvAaSyVJE7AZxqQV1dtyR4kRQAA9Bwgx6i1SbQEQ=@vger.kernel.org, AJvYcCXg6s/5Lf5czRgluu10HTbLQzNxcDBGk3sQE8X70KM+5C0qteebKy9m/1Ox10HI3uJbC6Z4XBza2OKuyBur@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2lv1DZsSCV/ZIcPq4xpc1+dW7Ucjg7ZjqmzJghgyLNuMO2FoE
	6NlGVtmWg8KNNKp5L7YdK3HAjrxioRMD6z49pwp2C6h8970cUqd7
X-Google-Smtp-Source: AGHT+IGyp0ZVYxfCSEahmCa4q8M9qPyBTg6DfqOr0ezPkTzwg4DeP1BeP9NXHCIl2cI52k+Kk27bag==
X-Received: by 2002:a17:902:e741:b0:202:3469:2c8d with SMTP id d9443c01a7336-203680965e9mr35181955ad.28.1724239500862;
        Wed, 21 Aug 2024 04:25:00 -0700 (PDT)
Received: from s0man3.. (zaq31fa9922.rev.zaq.ne.jp. [49.250.153.34])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f03751f6sm92130345ad.169.2024.08.21.04.24.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 04:25:00 -0700 (PDT)
From: Soma Nakata <soma.nakata01@gmail.com>
To: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>
Cc: soma.nakata01@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] libbpf: Initialize st_ops->tname with strdup()
Date: Wed, 21 Aug 2024 20:23:46 +0900
Message-ID: <20240821112344.54299-3-soma.nakata01@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`tname` is returned by `btf__name_by_offset()` as well as `var_name`,
and these addresses point to strings in the btf. Since their locations
may change while loading the bpf program, using `strdup()` ensures
`tname` is safely stored.

Signed-off-by: Soma Nakata <soma.nakata01@gmail.com>
---
 tools/lib/bpf/libbpf.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a3be6f8fac09..f4ad1b993ec5 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -496,7 +496,7 @@ struct bpf_program {
 };
 
 struct bpf_struct_ops {
-	const char *tname;
+	char *tname;
 	const struct btf_type *type;
 	struct bpf_program **progs;
 	__u32 *kern_func_off;
@@ -1423,7 +1423,9 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		memcpy(st_ops->data,
 		       data->d_buf + vsi->offset,
 		       type->size);
-		st_ops->tname = tname;
+		st_ops->tname = strdup(tname);
+		if (!st_ops->tname)
+			return -ENOMEM;
 		st_ops->type = type;
 		st_ops->type_id = type_id;
 
@@ -8984,6 +8986,7 @@ static void bpf_map__destroy(struct bpf_map *map)
 	map->mmaped = NULL;
 
 	if (map->st_ops) {
+		zfree(&map->st_ops->tname);
 		zfree(&map->st_ops->data);
 		zfree(&map->st_ops->progs);
 		zfree(&map->st_ops->kern_func_off);
-- 
2.46.0



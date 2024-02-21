Return-Path: <bpf+bounces-22358-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1340285CD67
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 02:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4500C1C22CB7
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 01:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49FA5680;
	Wed, 21 Feb 2024 01:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c9E4aZ5v"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F431FD7
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 01:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708478628; cv=none; b=EW+X51IqigCp4bf7ahix7UDVbYNbKHwpi99wesc4nuevr2nB9wukrFNeVDNkJHO2Jt5j82WvQqeLr1GTwyTwB51pszLVKTjCmYHo2WSRhBuSRSLSH/Hxs5qcRB7OEMZm/BkTMMO8LkSliKaqeJzY3hCxGqsCgiIkuzPWIXTVRRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708478628; c=relaxed/simple;
	bh=9pgDJRa9T/5a4i1vhMmQqOlMwwmbYYmxCovw23ewryU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f9hBvoesslUk7sNTFXVEkGqgfQ33vPuuLYaX2tponQeDa/7Gj1eRGhNF8fqlYH6o5V7iun7oHTiqnrxLHgCKVhyNKvq0iZApMg9KY4GvJx86v3R1CHZWHjq6296RUUAhcwYVMg/k8wLqnT5oSkiAIYYwWCTfnqmQqe5FYR8n9hM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c9E4aZ5v; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-607f8482b88so45271707b3.0
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 17:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708478625; x=1709083425; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pBHML36fUv9H+qGSqsoz0y17RtRNnl1DXEIzsGFdTTM=;
        b=c9E4aZ5vWCtNnWZXa6DTNzwzMzECae7nynxp54mh0V3ipMP94nTQqr+SGZZc4I9Hjc
         /Wqycz6iSxjIOCGramoA2nf/RH0xSydN8vcqy4jOMnJYgAVJjqXl9n0biSSnFsI40NGW
         UA9dfh8+FZUJ+ipNUAowmAAFLvmSq+Uj6HSVvgyc6G5s4nRVA6hSUPKQidzR+Dj+Tlly
         hJNxznPHmM5rqCZGR7TKxaDcfDZgT1+NyMwA+Fc9ahPxMxMvxMpQKm+AK/jnQuCsBlmw
         94ooBiE7huBzrjDxBx0qBGXlg2Xodz+n1kk/yY7lOzIIj+jGZ6iKUatn30a8/tz3NZRG
         zwUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708478625; x=1709083425;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pBHML36fUv9H+qGSqsoz0y17RtRNnl1DXEIzsGFdTTM=;
        b=qIPbRH5Y22S5K4vDAhSg6ZJlzQNDo2LEK9R50x5JYrCfQAf5hK5Wr6Mm3nuzGqdvPs
         khS010Z6sQ2a4arcsjUpV+X5kyJ2vgDXE02zmwa4bxvn+aZ1og5hdmT5oc9k+MyIC/RZ
         2WKLpeVbL932Xuz622RNcJPmn5sVPvVQy2qxd+hYPf2onNDqg/eEytS7UUwvWyV/yn+5
         vmeNE9xkwDNi/P8hLo8yEvQzmgBM2NioC+vFKMB08bLWHjzK7HlyKKG2iOxh4DRQfOK/
         YmBKvv/Jwe9BQ3YbEBVR/lVvEf+R3obT7iO+OmTTfs/nDK8wMS89Qz3uhmGey1vidAHs
         Aj3A==
X-Gm-Message-State: AOJu0Yz/96h9w28tKxhxJwkveP7HkJ7eUXxO7Y76JD0BbRApqERjoVEL
	T8qwt6nhYF2wDXBrIuVM9DiBCF2KA/XQaQ4WqX8fv7OlqBeKJcDVlBlecqLW
X-Google-Smtp-Source: AGHT+IFki79F+jMELFfsj0JKNlTl9aJH04+gus6x6tXQkCEDvozqWlSnLbBPK6WNyii8mLSItanJxg==
X-Received: by 2002:a81:c252:0:b0:607:9e4b:f0e9 with SMTP id t18-20020a81c252000000b006079e4bf0e9mr17768394ywg.31.1708478625575;
        Tue, 20 Feb 2024 17:23:45 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id j64-20020a0de043000000b00607ef065781sm2396801ywe.138.2024.02.20.17.23.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 17:23:45 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v3 2/5] libbpf: set btf_value_type_id of struct bpf_map for struct_ops.
Date: Tue, 20 Feb 2024 17:23:26 -0800
Message-Id: <20240221012329.1387275-3-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240221012329.1387275-1-thinker.li@gmail.com>
References: <20240221012329.1387275-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

For a struct_ops map, btf_value_type_id is the type ID of it's struct
type. This value is required by bpftool to generate skeleton including
pointers of shadow types. The code generator gets the type ID from
bpf_map__btf_vaule_type_id() in order to get the type information of the
struct type of a map.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index ef8fd20f33ca..465b50235a01 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1229,6 +1229,7 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		map->name = strdup(var_name);
 		if (!map->name)
 			return -ENOMEM;
+		map->btf_value_type_id = type_id;
 
 		map->def.type = BPF_MAP_TYPE_STRUCT_OPS;
 		map->def.key_size = sizeof(int);
@@ -4818,7 +4819,9 @@ static int bpf_object__create_map(struct bpf_object *obj, struct bpf_map *map, b
 	if (obj->btf && btf__fd(obj->btf) >= 0) {
 		create_attr.btf_fd = btf__fd(obj->btf);
 		create_attr.btf_key_type_id = map->btf_key_type_id;
-		create_attr.btf_value_type_id = map->btf_value_type_id;
+		create_attr.btf_value_type_id =
+			def->type != BPF_MAP_TYPE_STRUCT_OPS ?
+			map->btf_value_type_id : 0;
 	}
 
 	if (bpf_map_type__is_map_in_map(def->type)) {
-- 
2.34.1



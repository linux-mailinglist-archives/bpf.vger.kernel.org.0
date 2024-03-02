Return-Path: <bpf+bounces-23216-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD42986EDC7
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 02:19:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1318D1C22115
	for <lists+bpf@lfdr.de>; Sat,  2 Mar 2024 01:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575CA6FCC;
	Sat,  2 Mar 2024 01:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJ/J88ux"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445A8566A
	for <bpf@vger.kernel.org>; Sat,  2 Mar 2024 01:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709342381; cv=none; b=pRjcrZ9/QRXiqYfFkeETKtTpC1QRoEM6yok4zErpO9QNh852PdMwGmqWQoCyZyvox1Alhnh5DMt+s0QftR9tuVnMI4P3Hg+h1MYQeyRPKbzgZAvSjRLxtTDVzeMtUD0pA79BLCrb7IHfYCv9rSTzS6z/vq8iNp9Nt00CQJyN0t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709342381; c=relaxed/simple;
	bh=MxAP1Mj+92zhg+N4eBULQMbyQMO4cUeudjXhJFMAEm8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YixHGZySwTtBz7Nh/BVsX26rYnUKL4RBwdNfF8L9rRZFQg68/W5RczASLSH43zByGTdUbFlFAKXpSbK+blQlcxK42s4vehn8gwmbi1HvrwoTzBGJGzBr9JrmEdd5S1pWaxcbrqPqL+7ftFahlK9cBUazWm8u5QX426DhgIQyq44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJ/J88ux; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d275e63590so35414521fa.2
        for <bpf@vger.kernel.org>; Fri, 01 Mar 2024 17:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709342378; x=1709947178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ac39i9sTIpkqIzsBXHyyh1hd2HLA5BkCt5GBSAjk6Yo=;
        b=VJ/J88uxnNZY9/3Q/hDIPtkE63zlZwgLKZ2vQ5SRvKUicIvlXBcYDdG88rlKKfDPHX
         0dksCFKJYgO8pRLrPNQUd1UBove4ocYdpH+zOp+9Ic15DmIZUL9SnrzZEZUuUvI4F7vq
         SyDsqcUOg2SXx7MuJYsgr5803GgFWq178k3ZcB0YuxRjaLKsrYdlBKkfJ87LSbOKaLiT
         8iSHSaSOjM/Sb8wht1JKckGj9iOgYJOqyvRa9OxV9EWlPUT3rBtkKZXzMNq+/MftsUjF
         hcO7ZtaWXLJ6/aX9yQmsG4jFo2GqD43yZJKYOo+xwzCSBqs8TyZhM0KmY0qbB7Z1pEGt
         dm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709342378; x=1709947178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ac39i9sTIpkqIzsBXHyyh1hd2HLA5BkCt5GBSAjk6Yo=;
        b=C62SQJjyGSgBq4GWWpvU8nivghanvhH6Pk/q6pcNb4UtgeRrCgHHQl0vig7Fe2oJlq
         XWTGLT2wviZ50YhIuz5PHCjFZrb92juL7WhpSJcuDR8Y3W4ArbOWylraOUScHgtw9/zX
         BK92qgxgzNcfcQGOvk6ICyMVCuPLQgP9TZUj1EPiWeYtW+oGeDOTOYgiNZW5WBhGuU9K
         7RNPp8lsgaxlNObH/AsrHKvwkPRyJWjSdO2GhfH+CIRTGzr3jYOGF0Nxll6DDQxIaMin
         w/mubOyy1s9h+eptyMjqlWwF91AfqG9Y6J1+rlk7jvdceHBH4gzQeJ/Kh1r2Vq1G5Q9C
         mOAQ==
X-Gm-Message-State: AOJu0Yw1TCfMvHhsKi/89HHz1JABdVY2onYIoljM0KH3lG17dNpiQlYy
	7CsqAo13OcSe6ceM1/I+gZbXH8G3y0NazRCDdJTi7Xbhbpmarzy2QyZDA7Ue
X-Google-Smtp-Source: AGHT+IF6bhZ20IaN1HeBs4utrzgkmYgavXdnKFH+q5OXZW1WSu0CrgFijx+cpEVbw64PjVRxQvf6Tg==
X-Received: by 2002:a2e:9254:0:b0:2d2:4637:63f with SMTP id v20-20020a2e9254000000b002d24637063fmr2183975ljg.45.1709342378145;
        Fri, 01 Mar 2024 17:19:38 -0800 (PST)
Received: from localhost.localdomain (host-176-36-0-241.b024.la.net.ua. [176.36.0.241])
        by smtp.gmail.com with ESMTPSA id z23-20020a2e9657000000b002d295828d3fsm767386ljh.9.2024.03.01.17.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 17:19:37 -0800 (PST)
From: Eduard Zingerman <eddyz87@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	kernel-team@fb.com,
	yonghong.song@linux.dev,
	void@manifault.com,
	sinquersw@gmail.com,
	Eduard Zingerman <eddyz87@gmail.com>
Subject: [PATCH bpf-next v2 03/15] libbpf: honor autocreate flag for struct_ops maps
Date: Sat,  2 Mar 2024 03:19:08 +0200
Message-ID: <20240302011920.15302-4-eddyz87@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240302011920.15302-1-eddyz87@gmail.com>
References: <20240302011920.15302-1-eddyz87@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Skip load steps for struct_ops maps not marked for automatic creation.
This should allow to load bpf object in situations like below:

    SEC("struct_ops/foo") int BPF_PROG(foo) { ... }
    SEC("struct_ops/bar") int BPF_PROG(bar) { ... }

    struct test_ops___v1 {
    	int (*foo)(void);
    };

    struct test_ops___v2 {
    	int (*foo)(void);
    	int (*does_not_exist)(void);
    };

    SEC(".struct_ops.link")
    struct test_ops___v1 map_for_old = {
    	.test_1 = (void *)foo
    };

    SEC(".struct_ops.link")
    struct test_ops___v2 map_for_new = {
    	.test_1 = (void *)foo,
    	.does_not_exist = (void *)bar
    };

Suppose program is loaded on old kernel that does not have definition
for 'does_not_exist' struct_ops member. After this commit it would be
possible to load such object file after the following tweaks:

    bpf_program__set_autoload(skel->progs.bar, false);
    bpf_map__set_autocreate(skel->maps.map_for_new, false);

Acked-by: David Vernet <void@manifault.com>
Signed-off-by: Eduard Zingerman <eddyz87@gmail.com>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 2c0cb72bc7a4..25c452c20d7d 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1209,7 +1209,7 @@ static int bpf_object__init_kern_struct_ops_maps(struct bpf_object *obj)
 	for (i = 0; i < obj->nr_maps; i++) {
 		map = &obj->maps[i];
 
-		if (!bpf_map__is_struct_ops(map))
+		if (!bpf_map__is_struct_ops(map) || !map->autocreate)
 			continue;
 
 		err = bpf_map__init_kern_struct_ops(map);
@@ -8136,7 +8136,7 @@ static int bpf_object_prepare_struct_ops(struct bpf_object *obj)
 	int i;
 
 	for (i = 0; i < obj->nr_maps; i++)
-		if (bpf_map__is_struct_ops(&obj->maps[i]))
+		if (bpf_map__is_struct_ops(&obj->maps[i]) && obj->maps[i].autocreate)
 			bpf_map_prepare_vdata(&obj->maps[i]);
 
 	return 0;
-- 
2.43.0



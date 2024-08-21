Return-Path: <bpf+bounces-37674-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 278D6959501
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 08:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20E12868EF
	for <lists+bpf@lfdr.de>; Wed, 21 Aug 2024 06:48:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 042E53DABE6;
	Wed, 21 Aug 2024 06:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5gq4gVY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2504321C194;
	Wed, 21 Aug 2024 06:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222921; cv=none; b=Ugd8jFSUVqlUvm3n7etginIGbAd9gvx8yAya0hwa5nbwuML9ViaHB6iOcoXmnwPqK9iXtB5ENQ8bCq6U8oXfzSHKlO2VX36SFIQTur5zg0T/T1m075iPZiNdybBH2u4rY+3K3v5R+30mA0rcTp8jXow1XXJwy/g2l5sTJ4YVTdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222921; c=relaxed/simple;
	bh=a1sRq4Gq81skHVAt1+bw0RLPlkdMgk0jG3K3SwJFKTE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=s24ILg+PUcUA8q2ncYBu6x9FUP3wNf32UuCEB2ZA6doBFAQlpkfqQz5Va13T1FcrVAHA3UJxWgRHsLxwZnCgOQtyNw9sEiFiYNCbhQYORY7wB5aRr64CsMehYG2VqPzbFEb5Wx9YXI2D+UNn4AfsZA6cyIesVj1dn+1H8ijo6y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5gq4gVY; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7142448aaf9so268380b3a.1;
        Tue, 20 Aug 2024 23:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724222919; x=1724827719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y+k2ccg0WxkmC5vADWYxJm5KTzwazJQ2WVodlbM2nw8=;
        b=D5gq4gVYFMPrfH3W+SLOSYE2ewRr1Cq8twEcN1DkZo2akzTkExORWLyCcr4p/m8lJ/
         qS6s/JeKxRvNcudeauw8WmXHfOLZz+Cg/OBhVtkZmsZ68egQ1cfp8hUsjypldLB6hm03
         HmldB7zDf0WFMC5YZdwWQP5pVSVE07kVB9dyAB6w8WOj4U69OqSQfANA4bSC3ufooY7e
         Y18wkPfSSWVim8nsEupDYw9/KhAu0rYlOsE4nc0ZFTdWOhcZZlJQkuYtqkcybZURC+mh
         lyap4QNdLZ9o4Q8o2Aa0OO3WcrcPEznJrThB34zcAnhoBXJIjPBnJcNj1vE6lg9q5gox
         PcYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724222919; x=1724827719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y+k2ccg0WxkmC5vADWYxJm5KTzwazJQ2WVodlbM2nw8=;
        b=f9j/Ugp/0uvonXXkfQyjUlh6ESHf1HAqkwUtXJIjV4D+36353Lj8KHkNkqSM2BvUVK
         WQ0jHts88ta/EILxbjOhbcMP4RQ/EemyRaZnNKqyvYYdVVItBj53IeXucvRwrQRc7ZQd
         tXje0Ol5Q2UEoOqtJhMrghZnxpstc3v6pitGYFNQbvEEoEdzn2BJqq3zLfHVqApO+TcH
         Go5k6NjuzHBmB8/XCJ6CdunI3kNMwGVO65vpWWRuuVT+E8W7//qDmrDIDOF7+mkgOR7Q
         Lhf3iLRAnx79x5eQHzadd1yTYVhcC7gY3PMP+y0aUJUpuYKiXmxvRIN/4l3S1c9sgFKj
         5Hpg==
X-Forwarded-Encrypted: i=1; AJvYcCU2+N8JgMTQKdq2ZTeADtYnFeq+a26pw+ZFEYjelHAtx4q42QGU9gaDq/CTf/cWnfU8Hey4BtMzpKJefml0@vger.kernel.org, AJvYcCXDAgctI0pV5XmEJcobkTfCSYzcnvauDnPlrMduHC9r2OS2ZQj28pWqjwXW0KQZ50syR1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCCRBaGV9KlNN/Ei0jbgzAT6Uglgyiy0Uyb1izwTAUAYU8GxBA
	WIAO7ruEWph9wlA0+CeBUvyz9jKDuBPVfoELoELOHZIDJstJFxQ+
X-Google-Smtp-Source: AGHT+IH33G7wUMnQBSPoCJutXyCEDVD3GPfUUh6S0Xc8BkHcpa3PxJ2uIuPLMKTCStj8Q4KifudEQQ==
X-Received: by 2002:a05:6a00:720d:b0:714:2922:7c6d with SMTP id d2e1a72fcca58-71429227dfbmr438666b3a.12.1724222919328;
        Tue, 20 Aug 2024 23:48:39 -0700 (PDT)
Received: from s0man3.. (zaq31fa9922.rev.zaq.ne.jp. [49.250.153.34])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7141e49cf12sm1103656b3a.186.2024.08.20.23.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 23:48:38 -0700 (PDT)
From: Soma Nakata <soma.nakata01@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
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
Cc: soma.nakata01@gmail.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] libbpf: Initialize st_ops->tname with strdup()
Date: Wed, 21 Aug 2024 15:46:33 +0900
Message-ID: <20240821064632.38716-3-soma.nakata01@gmail.com>
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
 tools/lib/bpf/libbpf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index a3be6f8fac09..ece1f1af2cd4 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1423,7 +1423,7 @@ static int init_struct_ops_maps(struct bpf_object *obj, const char *sec_name,
 		memcpy(st_ops->data,
 		       data->d_buf + vsi->offset,
 		       type->size);
-		st_ops->tname = tname;
+		st_ops->tname = strdup(tname);
 		st_ops->type = type;
 		st_ops->type_id = type_id;
 
-- 
2.46.0



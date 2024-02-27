Return-Path: <bpf+bounces-22772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 58647869A55
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 16:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CD5D1C231F2
	for <lists+bpf@lfdr.de>; Tue, 27 Feb 2024 15:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5762E145B07;
	Tue, 27 Feb 2024 15:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h1hm5vNP"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50673145322
	for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 15:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709047670; cv=none; b=lKlnXQXS5Kkt+WOEn9o4kKq0L9iIWTYLduV7vu6sKA9/L2SzEay1CJuunU4KlNW8tw9bdgheg4O8ISy1qUxgrh4yvwo43XEC+TryKvYAkx4skmiu2OFq77RZf4bjkj5LYtSnHSyxzpmrMTHWds9i/T5FBg5U3K4InSUztM6AR3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709047670; c=relaxed/simple;
	bh=2Df63Y5TkYPsmn8RWXJBQXHSQxfD9l2HfIHVhK6EdD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KTqhM729XBaPKSjYqryumDklLoy+3JJdt6WBesjca+GvP+anVKXryezqCTUedVQioCmyHgyHnHPNBNzqZpZVkR6bpfULX9T/GrR3LtUcEEHxireCEm4xe55J8PyoJPxVGUcQSBCd2qhNoJDxP+jJovmWd9IG8EOIkY3FGIrkErg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h1hm5vNP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709047668;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ENNrvrL9NDnFw3jJyvgsGCyMMkLB6+zPb2N9cTS8YnI=;
	b=h1hm5vNPlHU4wlYpsj9Tu6GMvcX/OmzxYrkK5W9ylPlyety8uVeCNmVNppk0yruQya4Z4Q
	siltX574MwJWtjfVdTsmoyKV6CIQc6yMV1sdV81ScRcMwb3ywpS3XNgSGBnSurK++e1uOy
	41w52mEbN0CtDZIE1lDqBpQjt7Wt0T8=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-uxJm0sH6OtWqyzWnK8pjdg-1; Tue, 27 Feb 2024 10:27:46 -0500
X-MC-Unique: uxJm0sH6OtWqyzWnK8pjdg-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5116e3cce79so4075160e87.2
        for <bpf@vger.kernel.org>; Tue, 27 Feb 2024 07:27:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709047665; x=1709652465;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ENNrvrL9NDnFw3jJyvgsGCyMMkLB6+zPb2N9cTS8YnI=;
        b=iMIsDWyeKMkgUBR2o0ex+OHGn9I+KDdjiUMdYYgl5fzxKxQ/WFBgMMYvqxx8WVXpCb
         7yQmsdbxAsSroAzzYr/hIx4fAVbf5rWikI0ypoN37D8GBo655TN88s5TFfuBOENrXdHj
         LnPqT00unEOzuAdYWa+3pPGBlzRbGyka+4ssZ9EBZL0685HMPQA+MvbVjNADuwM9f3Mw
         uewP74Avbzad2iZtOIb80giU/appVzLtv0IxB8eI4gB/sZGHL2CDNDBtAbZVEnH1aivn
         5QxXc+G/pQlx19P1WOkxUVzgrgKRiXUelecve0Rq56rVHa56/7+9q/BRzZDmOpNZNeY3
         uvxQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJJzcFOJFEZ25wiMYX9qrDusQUYvE2H0iQ4vC0TuKD6B4cnmK7ivK/Na4GUuOQzzirZSSxCbdOT5Q//BOq/h3nE/bV
X-Gm-Message-State: AOJu0YxXkrO2K/zUvN5FwcH+UOMJBsWdNsc0+HNZFZLQrm231n7RUCcy
	i1xx446KhlY2gwC90eCXz+GnHoBMSJTArMfiuEmSmWrAjTM11GvPHh3j2crDtEryJ8kzX3cn0FL
	Az7cswPQ3DoBlDWOJdu3p99QcS7r4x74KYkLaKRMbLfyZhhCI6w==
X-Received: by 2002:a05:6512:1317:b0:512:f59e:f425 with SMTP id x23-20020a056512131700b00512f59ef425mr7363487lfu.10.1709047664869;
        Tue, 27 Feb 2024 07:27:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFsvXx6NGEZzcHLLmTbDVJEU4gHIYzEfwKyfUcLPgu/V1ZCIC6i2RJjITcFdOioHQU6f8dOAw==
X-Received: by 2002:a05:6512:1317:b0:512:f59e:f425 with SMTP id x23-20020a056512131700b00512f59ef425mr7363461lfu.10.1709047664485;
        Tue, 27 Feb 2024 07:27:44 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id gg3-20020a170906e28300b00a3edb758561sm859047ejb.129.2024.02.27.07.27.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 07:27:44 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id B025C112E52F; Tue, 27 Feb 2024 16:27:43 +0100 (CET)
From: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Cc: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf] bpf: Fix DEVMAP_HASH overflow check on 32-bit arches
Date: Tue, 27 Feb 2024 16:27:40 +0100
Message-ID: <20240227152740.35120-1-toke@redhat.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The devmap code allocates a number hash buckets equal to the next power of two
of the max_entries value provided when creating the map. When rounding up to the
next power of two, the 32-bit variable storing the number of buckets can
overflow, and the code checks for overflow by checking if the truncated 32-bit value
is equal to 0. However, on 32-bit arches the rounding up itself can overflow
mid-way through, because it ends up doing a left-shift of 32 bits on an unsigned
long value. If the size of an unsigned long is four bytes, this is undefined
behaviour, so there is no guarantee that we'll end up with a nice and tidy
0-value at the end.

Syzbot managed to turn this into a crash on arm32 by creating a DEVMAP_HASH with
max_entries > 0x80000000 and then trying to update it. Fix this by moving the
overflow check to before the rounding up operation.

Fixes: 6f9d451ab1a3 ("xdp: Add devmap_hash map type for looking up devices by hashed index")
Link: https://lore.kernel.org/r/000000000000ed666a0611af6818@google.com
Reported-and-tested-by: syzbot+8cd36f6b65f3cafd400a@syzkaller.appspotmail.com
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 kernel/bpf/devmap.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index a936c704d4e7..9b2286f9c6da 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -130,13 +130,11 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 	bpf_map_init_from_attr(&dtab->map, attr);
 
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
-		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
-
-		if (!dtab->n_buckets) /* Overflow check */
+		if (dtab->map.max_entries > U32_MAX / 2)
 			return -EINVAL;
-	}
 
-	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
+		dtab->n_buckets = roundup_pow_of_two(dtab->map.max_entries);
+
 		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
 							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
-- 
2.43.2



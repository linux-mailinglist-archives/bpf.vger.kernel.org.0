Return-Path: <bpf+bounces-43249-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA849B1A71
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 20:55:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 17716B21745
	for <lists+bpf@lfdr.de>; Sat, 26 Oct 2024 18:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097511D6DB5;
	Sat, 26 Oct 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kkteNcbH"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFA5A2231C;
	Sat, 26 Oct 2024 18:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729968930; cv=none; b=sHFnZ5KKl07PZ51O6tJj3RSvCX15eMCSz6zS7c1rfM94ZeiahC1Ec+Jsrkq97qj/+qKDinjolA+dW1MyJvRsnjYRbR5Nn4p8aYaPb94eHKxmMfw3++/RrlTDpUMr2o+Hp0Dr038n4TRkbSRx6bLo8ZYxEn/lX7aJ/FMXmvC7NMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729968930; c=relaxed/simple;
	bh=HriS5NIsAdoA/0qgCCaEXAYOQke3Iu933uC/swXQiA0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qm5TLlg+qoe15AENWlb2xVw6ZqDOl+4IbDryNwyc9JVdQRep3ect4bHjxf/1TfN1iteG2qjqZKmXB3AsT1xCTVKclKTh5yfk2DuzkW++TE2sGNK1RxnM3hujce2ji6iBvDJsfK6lZiArpsWx/ZTwB3uRpxpqNnGl3VPZReM3Xh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kkteNcbH; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20cf3e36a76so30411355ad.0;
        Sat, 26 Oct 2024 11:55:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729968927; x=1730573727; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OZFtwMKKLX4yesi/4S8wlLXA+EQMu5+QDLofJmqHNsk=;
        b=kkteNcbH+/1Wh+rjSSq2x0ogAARjBz4vqmWjDe8RevipYXkHlg3BT+7mWydmCVPmsC
         OxclbL9phDVejcm35xlqGb7UVIj26mdaRjbBqe+Y98wf4X4wKNUh6zQ9dWH57DWVxWwi
         sJrhYFrQYXzBmudAflPOWjMsroJq/GFlF4vBW1TXKHpmD0lwlRdUhMkEFrvRyAIsI+EY
         RsDyDrT1QnO/y2qjlzP7T2tHwi5ODwYG8DSLUmrwkp+zrc8dR2uCqlnZ+BkJfHyap3Rw
         dIhIiZ3aChQDWNS1Tby+ugqGsfmUldAYdXHNKLGzBeSESV2QPyA1lrD5ECXZNJOBqBgA
         qF/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729968927; x=1730573727;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OZFtwMKKLX4yesi/4S8wlLXA+EQMu5+QDLofJmqHNsk=;
        b=r8rO8VLktXSXuLegknv4WuBf6ikRjcgiDC6ElGXXcHGUE7eJ0W088K7JjoWPEFN/v6
         uelzjR7asRRyJ+YDpSJZh0h6YRBgrA4HZQR4ODEBMlIe0/Z0Z7p7U/M+eEuUmeR845x0
         khcR6Ldn2DhxtAo7CfaOjVeQVVw9oSs3KLjgWvor0ZQ8Nq7APWgTS3I/HxffO4armTX8
         SeGuThoYqiiSxtabBo1hGnwn/4Jhm8/LwNl0Tuvv4k8e/2I/I24nGs1+EXJb38cBnxBc
         /MNQDcmgDSexKUK7uBQFzxD+y2VTJzFUrT1sSU0F2BZdoS0JIEF/dEvnxUf9PvtocUG+
         Wf8A==
X-Gm-Message-State: AOJu0YwH+rSAYihHwci/YREcXegRPeU6nNwG3rxpEA/TXM/iOl3f9NG5
	FEqPTdNp67G3EPZjxT5k1R9tdGHbZl+ICq5C6TkE08i8e9+5Alqcw7/s1Q==
X-Google-Smtp-Source: AGHT+IHOmyeOeu1wf7pjchwvUTH6wdWSzYTr6xKDHX9wv/ycBQGH+Wh/4wIzNHxis7UlEP7oB0WkYw==
X-Received: by 2002:a17:902:f60a:b0:20c:a055:9f07 with SMTP id d9443c01a7336-210c6c0210bmr45137055ad.26.1729968926025;
        Sat, 26 Oct 2024 11:55:26 -0700 (PDT)
Received: from pop-os.hsd1.ca.comcast.net ([2601:647:6881:9060:6a46:a288:5839:361d])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-210bbf4349asm26561625ad.46.2024.10.26.11.55.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Oct 2024 11:55:25 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	Cong Wang <cong.wang@bytedance.com>,
	Ruan Bonan <bonan.ruan@u.nus.edu>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Sitnicki <jakub@cloudflare.com>
Subject: [Patch bpf] sock_map: fix a NULL pointer dereference in sock_map_link_update_prog()
Date: Sat, 26 Oct 2024 11:55:22 -0700
Message-Id: <20241026185522.338562-1-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cong Wang <cong.wang@bytedance.com>

The following race condition could trigger a NULL pointer dereference:

sock_map_link_detach():		sock_map_link_update_prog():
   mutex_lock(&sockmap_mutex);
   ...
   sockmap_link->map = NULL;
   mutex_unlock(&sockmap_mutex);
   				   mutex_lock(&sockmap_mutex);
				   ...
				   sock_map_prog_link_lookup(sockmap_link->map);
				   mutex_unlock(&sockmap_mutex);
   <continue>

Fix it by adding a NULL pointer check. In this specific case, it makes
no sense to update a link which is being released.

Reported-by: Ruan Bonan <bonan.ruan@u.nus.edu>
Fixes: 699c23f02c65 ("bpf: Add bpf_link support for sk_msg and sk_skb progs")
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Cong Wang <cong.wang@bytedance.com>
---
 net/core/sock_map.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 07d6aa4e39ef..9fca4db52f57 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -1760,6 +1760,10 @@ static int sock_map_link_update_prog(struct bpf_link *link,
 		ret = -EINVAL;
 		goto out;
 	}
+	if (!sockmap_link->map) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	ret = sock_map_prog_link_lookup(sockmap_link->map, &pprog, &plink,
 					sockmap_link->attach_type);
-- 
2.34.1



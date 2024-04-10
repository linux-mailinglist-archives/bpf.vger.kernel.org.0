Return-Path: <bpf+bounces-26337-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63BB589E6FF
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 02:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F0AF28410B
	for <lists+bpf@lfdr.de>; Wed, 10 Apr 2024 00:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FDB9637;
	Wed, 10 Apr 2024 00:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VvVDvELW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F00387
	for <bpf@vger.kernel.org>; Wed, 10 Apr 2024 00:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712709717; cv=none; b=bugZCZkKvFEAG9nBDA+QRlQ3zZ5SNdGTVeIHXTN4TEkKJ72qhJfAfx+kGMS1Um6seHPZXQR0naS3qVG2ZUdB0PAalovsLyJ9Mti/GAVWCWmIuWdDsM4JB+kYHVY23pdNQdALnqVO2HPZ7st1vDn0tS0wOto8K6KZdbRGYs+a3l4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712709717; c=relaxed/simple;
	bh=Yi0PF2Xp4EiAjyXNPIst0YEunHuP+bb4DkipOWjFu/8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=REHVGRU1wHqBl5GGCJUYN5K30wJM0MAQPSWidQ79N8MuN4cE3jvpp+3nDgqCHhw1n7/8qHU+bej5IWX9QUB2QYm5xQ5P4hOn0GOtsIn79sUF+3IiNdnnKH4uyIzFKQa7YFjfRL7DU+WL8zfpp76MdhbB1C5vf66aiRjKkN0yF4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VvVDvELW; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5aa22ebd048so2784903eaf.1
        for <bpf@vger.kernel.org>; Tue, 09 Apr 2024 17:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712709715; x=1713314515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rwcJqrsJ+5ydXSsOGrm2hlF/YDtofk5BUbh6bX9mJA8=;
        b=VvVDvELWTSutaVSYkcH07ZYBShAH0/8AiNuexrqVNy4P96YLvBNHjNUnGYZgXWgTNJ
         joCI8qnAddVn+J7EdAY80wEVJEFomfKlXhBwNJmI73O1HxkQRUyD7JYHzg6+Xsx00Leo
         Ltg5MjPPwagxw015MWwZI88QEmEcYcqa649Sjf59iNChVWyi9kGAoF641qGdIBuqTnYl
         K/waA9tyPOv1ViCmWZb9VXo4iXinjJmwP9FVGNIZOGv7yHzIt6aPxP5AwzTq87ABAot+
         U3kr02N59eQCzcmZvlC3VI8bGI2u3DSvKx8fnDwF7I2jzmotXD6dsHvHHx8YgeG/bGAR
         UwjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712709715; x=1713314515;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rwcJqrsJ+5ydXSsOGrm2hlF/YDtofk5BUbh6bX9mJA8=;
        b=b2UYzn0HLGNmxqY4OlgXUpcb96xIa03by8KhV0b2FO+MA1kr+J83fAEmLbrAYHA1p2
         4zGo9J9aDsCx2BRjvH+7Wgs3EU9ulI69QDCo51+yjG0Wma6dzN6ZFzy8S+kAOiC7R1Yt
         Eg+eXd6nKdp4VzAJr5BZNhOm+h9EWX6VB5b4j8GSjeoHnG/K87GWsfU6RZyT6TVZi/mr
         9OBknJbOkMqMiONGIc6TKUKpg1ZMVjRShH4Eq2Fau/ZmfDj0az76h3FEzAbxCnKageVc
         f5UB0e86iNFiiY2PWM9AsFvyxDcDrzxPWyieEtJGvzG/CTenJFzUog9QFtMnOxchL+te
         NbKA==
X-Gm-Message-State: AOJu0YzsZGjpMzUxHg5SjFDvCczixhiUB6NJD1ZOzsZFId/jWpHQq/JY
	Nj8xcZRl7x2Lv8AxksWDFJnDWx4lr90U5MftnDTqMk8mOkA7NjBp8JdYLoE6
X-Google-Smtp-Source: AGHT+IFqKDvPeqmDYoKYwjPPftep1kf5gbRW7s2QYBu1o7fCa8hYs2Lxvr9yc3qzSqZB8DJZk1SdHw==
X-Received: by 2002:a05:6808:638d:b0:3c5:ee83:5205 with SMTP id ec13-20020a056808638d00b003c5ee835205mr1129668oib.37.1712709715036;
        Tue, 09 Apr 2024 17:41:55 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:d330:d0dc:41bd:be5b])
        by smtp.gmail.com with ESMTPSA id bf10-20020a056808190a00b003c5fbfe3ac3sm505124oib.21.2024.04.09.17.41.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 17:41:54 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next 01/11] bpf: Remove unnecessary checks on the offset of btf_field.
Date: Tue,  9 Apr 2024 17:41:40 -0700
Message-Id: <20240410004150.2917641-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410004150.2917641-1-thinker.li@gmail.com>
References: <20240410004150.2917641-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

reg_find_field_offset() always return a btf_field with a matching offset
value. Checking the offset of the returned btf_field is unnecessary.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 2aad6d90550f..0d44940c12d2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11529,7 +11529,7 @@ __process_kf_arg_ptr_to_graph_node(struct bpf_verifier_env *env,
 
 	node_off = reg->off + reg->var_off.value;
 	field = reg_find_field_offset(reg, node_off, node_field_type);
-	if (!field || field->offset != node_off) {
+	if (!field) {
 		verbose(env, "%s not found at offset=%u\n", node_type_name, node_off);
 		return -EINVAL;
 	}
-- 
2.34.1



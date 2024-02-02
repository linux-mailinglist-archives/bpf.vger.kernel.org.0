Return-Path: <bpf+bounces-21094-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679F1847C0E
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 23:09:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AB941C24AA9
	for <lists+bpf@lfdr.de>; Fri,  2 Feb 2024 22:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8350C85937;
	Fri,  2 Feb 2024 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b7rpDH60"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2EC85930
	for <bpf@vger.kernel.org>; Fri,  2 Feb 2024 22:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706911526; cv=none; b=jgaWlZhrLczQPRo0V538GnK5Xcq8tUQmi/NT3X7+WGSr8skkhdyO53n25MBIQ/2YE6ZDr9fp+MMxd3Zjcvm8ggHiRqAWGUC66SC7bwLXMTi+zzdjgxWgyyQkN6DxhOebFw7Vla2OYvIt2Ju2gSTfgQtZ7nfhaY5OF2BAlL45wzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706911526; c=relaxed/simple;
	bh=Fyrmq2ifvYeFH/iZKNZAZQpf3RUi27W7kBT61PEABpE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=I5RxIvoD3ORRS6QaeUtJ9e8bNBRC3mIKeI6Waa8MM/3tugTEKxnvQTNyjoT+n7LoNcn0ykevng9QFBuoxO9YCqQ9pXcAA1RZUJumc8c5L01sWOuAfvnXinhAv0/cDSQUznhqGaVLcTbLi2U6GQ1B35R/8NPu0Grb84RFmAyKhEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b7rpDH60; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so2305507276.1
        for <bpf@vger.kernel.org>; Fri, 02 Feb 2024 14:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706911523; x=1707516323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bc9EbQP4KhvlO8qubUZVLEubty2koZN9aeQrs7M1L1g=;
        b=b7rpDH60Qam8awkPlrrIith1I6Jazf7jBHFhst2eS4Sa12TcbkL8EsmAO++AtqQXvN
         Gc6OR17OZiPU6pQm5Nzdvlt+UndVqg4bgoQn2ULH+sMw2g2M67g3jSygGpbB7zLv6d7u
         Iy7VBYlkjqbS74fQiAsf3Ou5pw7+tGRpgiVwE8ZlFznAVKSNxkRQdEVA8UmSyvLm3Pa+
         QfAE7Rpj/raecX59RDcwhN6BwpGxm2V22uCjB2rpWqM3J/hMg5BlxYzcgpxtemEz1i8e
         5Fdyq2/0Y4MnoehgTBD7I30g8jyoVWq2VyJDFMycVZZCszKnJCe2WRGSQ7lEIOMsyw2s
         rLcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706911523; x=1707516323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bc9EbQP4KhvlO8qubUZVLEubty2koZN9aeQrs7M1L1g=;
        b=mRwi9ujM/BKAfk6mz6bwlD9Gv/YMlqvgqAL+zcZCV9K+KdbpH9w1Ipz6g3c0DG1GPk
         K6CLIQBdX2aktGqbg/bOCpAbemaiveGvp2qBtg4XyVMxkiQwk/JkT/Qw9ZNPqJxYh0XS
         KbKzQ2/o80HRiBvsWvHrJtOA487vtkXiemyubwuGxzLS4+VmeksX9yJcVBfr0NUNPjFR
         orhSY+0dV8BX6VEbMOjXPENv0P2h9zp90HdbnQrVmkFcKngQlsX2t6n3I14UX/TztU/u
         CIAz8NI5rRd9B6IA/6ZvhU7VB/sGWgA6Ds87hj7XTtwzpLQ1kyvzfNxKZPjWrnlWqsjk
         E0WQ==
X-Gm-Message-State: AOJu0Yz9TADlhk4Sc8IKjyVRQZFTFEqoG9kHPkejI2m+Z2qag7ZxLsX5
	3FjiOkdHGbP3P9jdLQdF3k2hlrUr4vBT1LOZ84ywGhDwqg4xzNphR3ZuVcpqPEo=
X-Google-Smtp-Source: AGHT+IHvOAiiW3uhYSWy2OCcWSfbIKPRIyVvvlGYjgtmjEJcqiNy4+Y4YCr4B+VjHbMs3r5v+0kQnw==
X-Received: by 2002:a81:b613:0:b0:604:ea3:6525 with SMTP id u19-20020a81b613000000b006040ea36525mr7367747ywh.0.1706911523003;
        Fri, 02 Feb 2024 14:05:23 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXnMJ/+hRElNUhzsn3PjTh/keDZh9YyuBlxQi+WnaodKsJUomP4kVXXHqJyWt3IVqPKMcNK/poKgRN5Eu6bt0R4avdTlep4w/t0ngEpevYQN+g/FhOJJJpYsD7isWUcU40JRQ8wJ0lZD/aXLhWsuBj8BlRKpc4+oR6r/DLRLweopi6BzdidcnvlTlzH+hO0aHWI7NQ8shEcRxGvKnFEA21AQNAk5AVsXqxO84sZ5Vg03rU33c1ASaKnV9Zk4Qb+LsSsf5VaqQfwFDhHjkDiWCf8apRccR95ikg1la6qFdMFlPc=
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b98b:e4f8:58e3:c2f])
        by smtp.gmail.com with ESMTPSA id z70-20020a814c49000000b006042345d3e2sm630696ywa.141.2024.02.02.14.05.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 14:05:22 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	davemarchevsky@meta.com,
	dvernet@meta.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next v4 3/6] bpf: Remove an unnecessary check.
Date: Fri,  2 Feb 2024 14:05:13 -0800
Message-Id: <20240202220516.1165466-4-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202220516.1165466-1-thinker.li@gmail.com>
References: <20240202220516.1165466-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

The "i" here is always equal to "btf_type_vlen(t)" since
the "for_each_member()" loop never breaks.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/bpf_struct_ops.c | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 0decd862dfe0..f98f580de77a 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -189,20 +189,17 @@ int bpf_struct_ops_desc_init(struct bpf_struct_ops_desc *st_ops_desc,
 		}
 	}
 
-	if (i == btf_type_vlen(t)) {
-		if (st_ops->init(btf)) {
-			pr_warn("Error in init bpf_struct_ops %s\n",
-				st_ops->name);
-			return -EINVAL;
-		} else {
-			st_ops_desc->type_id = type_id;
-			st_ops_desc->type = t;
-			st_ops_desc->value_id = value_id;
-			st_ops_desc->value_type = btf_type_by_id(btf,
-								 value_id);
-		}
+	if (st_ops->init(btf)) {
+		pr_warn("Error in init bpf_struct_ops %s\n",
+			st_ops->name);
+		return -EINVAL;
 	}
 
+	st_ops_desc->type_id = type_id;
+	st_ops_desc->type = t;
+	st_ops_desc->value_id = value_id;
+	st_ops_desc->value_type = btf_type_by_id(btf, value_id);
+
 	return 0;
 }
 
-- 
2.34.1



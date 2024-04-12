Return-Path: <bpf+bounces-26666-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 037368A37A8
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 23:12:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 251091C222BD
	for <lists+bpf@lfdr.de>; Fri, 12 Apr 2024 21:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E93815533C;
	Fri, 12 Apr 2024 21:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cDTR8xmC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com [209.85.210.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BCF4155337
	for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 21:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712956109; cv=none; b=IMLMvC9ty+P4bSNJMQDNRhTdabT8D3tB5S7C7m09yECL3B4pqfIbK6v2yrOb8jATk5PKLWqGRwO7VuLumDIgrbnz3G8LIUpsjDLUMTWwTd0zGxs18jGAINAQsnFea3WEAFnV2nUxH5oDr4HQSpSJLJVjJXmBmseYLg4S9Beyj8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712956109; c=relaxed/simple;
	bh=FnltRKvuB2ibpSeRZADOoapJF5TuPlRP9dDsHIkkVuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZUFhlRfzR8Wo9dvgk88T4F0xbed+GQooJm7GbAE3By4mhTONy98n94fCq6VnCiTZx7ciE9WG8z6i5+V+jh31LH/TyK0uXSPZ+pIRXZxT8UduNQyyo09BDQuWY/wfQcn7rpD/y5T/J7zUDIKCtQPfnlloNRwCIuz8pLSkhPPt7SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cDTR8xmC; arc=none smtp.client-ip=209.85.210.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f44.google.com with SMTP id 46e09a7af769-6eb6b6cdb6dso78274a34.1
        for <bpf@vger.kernel.org>; Fri, 12 Apr 2024 14:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712956107; x=1713560907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/GnXXeZfEMkA7zk9KrCCtAwm0v9n/2vjIg5x5unW63M=;
        b=cDTR8xmCigZxfoqnfmJQeHiLrZJLRCKI0wHWUTi4+astkohAhf5GnQrU6ea2VRhmfc
         p8UZdEUN9drfHRbe4Ifl9Jm1Rggq2LjzidkizRGsAPBgf4EhbVNMc9nNIZPW7ZEMst1S
         52pzo0LyKe6rBMUTpBFuqpdZk00H/JcdTyQtUigw/1PD97XS0qsHy4wNuMwXG21qXmR2
         4rKXWGfx7dOfIjEO/cS7IKZfccB7lg5zgHXW5tZ5aGk/Nt51ez4wIS9p9CMFxvKhCu8u
         rbzNVDgODseCFY1eT6LIlFYC8gqIBeMo3SPihK/m89db/2wL5naRSUzGfVZIsyGwk/JD
         4KJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712956107; x=1713560907;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/GnXXeZfEMkA7zk9KrCCtAwm0v9n/2vjIg5x5unW63M=;
        b=d+N8YkVS/IbAQRR2VXoXaAg0v/EWf2dgbTLLdss4bZ9Nw2J8YGF9nHVnkpqQJyNJ89
         /EIO8n9kARQ1EN98d2i6T8fQ851PS1g0TafPlbeQ7mr5nWTVM0vijzw3HcP3XWPG0X6H
         SSq3hzMkxaXfZckHCruLYzxwl/YtF8sxFXsgwXch4J/BADPK7yTUkkPW4nkX/itM1gcS
         x9pQgj4z+UW0gsGmJT3o5/murO7fghm8iR3kOuINW+FCkgKvGamjbB6iuT0hyYfck0Kp
         3hz0rPi0FBRsP8B8u3a742fk2n6KXUyYloJeRctIi7BZuxiugR/KA2CUfVh7D2Xae2fB
         19sw==
X-Gm-Message-State: AOJu0YyEzdf7oFqPsfADu0D/qyQl/0rKO4c9dImDfcXhm8yMmLWMucM2
	KzQvAa/Q5NtK0cHcSh7klEVaKoegOENRXi4EWAPtbM3Cjxay4HW9gufAKw==
X-Google-Smtp-Source: AGHT+IEI4tV2NzvY1tYsuoHwXQ/bzP1kBy0uppsch9CuEtyqhSOq9HOVzaYjGVUlu2/E1aJ6t6L9Wg==
X-Received: by 2002:a05:6870:b4aa:b0:22e:ddd1:4641 with SMTP id y42-20020a056870b4aa00b0022eddd14641mr3879065oap.35.1712956107288;
        Fri, 12 Apr 2024 14:08:27 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:a1a1:7d97:cada:fa46])
        by smtp.gmail.com with ESMTPSA id pk22-20020a056871d21600b002334685aedbsm1015117oac.11.2024.04.12.14.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Apr 2024 14:08:26 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 08/11] bpf: Enable and verify btf_field arrays.
Date: Fri, 12 Apr 2024 14:08:11 -0700
Message-Id: <20240412210814.603377-9-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240412210814.603377-1-thinker.li@gmail.com>
References: <20240412210814.603377-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Set the value of "nelems" of a btf_field with the length of the flattened
array if the btf_field represents an array. The "size" is the size of the
entire array rather than the size of an individual element.

Once "nelems" and "size" reflects the length and size of arrays
respectively, it allows BPF programs to easily declare multiple kptr,
btf_rb_root, or btf_list_head in a global array.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 kernel/bpf/btf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/btf.c b/kernel/bpf/btf.c
index 6fb482789f8e..ae17d3996843 100644
--- a/kernel/bpf/btf.c
+++ b/kernel/bpf/btf.c
@@ -3835,7 +3835,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 	rec->timer_off = -EINVAL;
 	rec->refcount_off = -EINVAL;
 	for (i = 0; i < cnt; i++) {
-		field_type_size = btf_field_type_size(info_arr[i].type);
+		field_type_size = btf_field_type_size(info_arr[i].type) * info_arr[i].nelems;
 		if (info_arr[i].off + field_type_size > value_size) {
 			WARN_ONCE(1, "verifier bug off %d size %d", info_arr[i].off, value_size);
 			ret = -EFAULT;
@@ -3851,7 +3851,7 @@ struct btf_record *btf_parse_fields(const struct btf *btf, const struct btf_type
 		rec->fields[i].offset = info_arr[i].off;
 		rec->fields[i].type = info_arr[i].type;
 		rec->fields[i].size = field_type_size;
-		rec->fields[i].nelems = 1;
+		rec->fields[i].nelems = info_arr[i].nelems;
 
 		switch (info_arr[i].type) {
 		case BPF_SPIN_LOCK:
-- 
2.34.1



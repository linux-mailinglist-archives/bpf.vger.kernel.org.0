Return-Path: <bpf+bounces-26886-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 621938A62E7
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 07:16:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 935C71C229AB
	for <lists+bpf@lfdr.de>; Tue, 16 Apr 2024 05:16:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64DB639FCF;
	Tue, 16 Apr 2024 05:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EdcQxBdw"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB0C39ADB;
	Tue, 16 Apr 2024 05:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713244545; cv=none; b=mWn9Au9LQD5A/Bbq1NfXaIxGUjR6tMtZSYcZmNblG228LS8Xve4pIpO+XVyCuvLe5IGkpbDO+bM5yr3nNXwEQ7rAcTIkGxL1WnFEcS0GxsNilY/IlawXmPNBx1HnhyahDggEZS9FsH6t160zxHeJvMDHSkqdLtGGdkO15NEtRGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713244545; c=relaxed/simple;
	bh=NKRLSKQh9GTrVLpQdC+orpgnX7CaNpuYCSVhDJ1A5oQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nesPFeLvWlCFxpAreLQufzrUMnMz1b93eC0IPyBpxD7TwNtj6nVYDAE6MLZ1MibZ/J2wN7FEusUM6RP+jKUDpSt4Sw6C049PRAleAbT61AUpj3QKKCeBtBJ9LB43HZTayQq1SBeG2KJnRpKhL8lmWvMHs95YS6048SDNGQcAaNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EdcQxBdw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a5534506790so29776866b.1;
        Mon, 15 Apr 2024 22:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713244542; x=1713849342; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h+jdsAeqCZ9ji/KUH4hSEhUfqGDV3k1TnFIBI36nkVQ=;
        b=EdcQxBdwIbA8tQlZwH7HGJB6z1In1nPfgUVRz0xBnAEiNmsvztsQB3Oa6kvYbXMX05
         p7NWX1eC35JwD0YDNAFNNHJXJXEvA1hrVpcNiPVqXWuVIm5+EzwWlAlNekGoSJDvgNWE
         yisBkFT4NC7VtxxbSGSDOpCuNRqiYRIe2+aDNykYf+Bvp1rPakJ4btGppDFnuEXZzc/4
         aAYDSOTVQ1nrLH4E2Jww7vWt4wlsS50vXjakFsU8+//lWiRT3J0WpKX69xGcJ6JjySVa
         Lo1FdJ76alKADeXwpbJ+EH/Yslr2F/rl4ZGwEZF412R2DSDxZOJGtZ1QIXkaWF9hDvyn
         ntvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713244542; x=1713849342;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h+jdsAeqCZ9ji/KUH4hSEhUfqGDV3k1TnFIBI36nkVQ=;
        b=SOwnPnheXQKNdyzgzFaSoqtm1IsG7/DisB9HG0V4k/JhVgnY2t38DCQgiUf1dG7BB4
         mNlAoC8ZDd9PSyHwvcTpaWvAhzwUVr3NoKR7i9dB8pS4a8rSUIRERR8+Xo0yVOSPp6s9
         /51KBZAyIo1B7DyseJrU3FyRlH8W5Vor6hcRZ29gMHBE8xcetR4EyHmbPyYiwCcDH/Y3
         skqU5q2VNkarM11dFlnbAxzIWTziqVg2P5gkt42wgDjastzuHAb8v7aNRpUtVHcRDzTR
         6Th5DMYd//WfppkGXnWuAysapuwUoKJ1fv10rCijLx0o1s/X2Mfuvs1y2AqZwHiv6je3
         i+/A==
X-Forwarded-Encrypted: i=1; AJvYcCUezLrkT6FNhs4Lk72nzjWPRdkQPQLdIHFAvAUQBcJ5RBPrIC7gymDxLhovu7PCSHaJEH43sOVko3EpvvryKlidLODDEH3bD5fXGGfohwIc7DxbvT2AWAuXp+8IOHNEQRXP
X-Gm-Message-State: AOJu0YyHKKu9Rqb2x+3CV3f3tDeTVKfQXZn3L56MS72lqczapITDW5FR
	bjyKJVRZUeSXnLA2ef3/xtGlIKsbpZWPBQXMODrtul8Krum8+lMf
X-Google-Smtp-Source: AGHT+IH5VnsFUJIDR+kM4iNcR9Gi+kXsrhs4Yd2WKI06S3nIR/atvJZZQhaftP7CdYt+msYQL+iRbQ==
X-Received: by 2002:a17:906:eec9:b0:a55:144a:adc2 with SMTP id wu9-20020a170906eec900b00a55144aadc2mr2144455ejb.6.1713244541343;
        Mon, 15 Apr 2024 22:15:41 -0700 (PDT)
Received: from dmitrii-TM1701.. ([87.200.40.246])
        by smtp.gmail.com with ESMTPSA id si5-20020a170906cec500b00a51a5c8ea6fsm6354091ejb.193.2024.04.15.22.15.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 22:15:41 -0700 (PDT)
From: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
To: olsajiri@gmail.com
Cc: andrii@kernel.org,
	ast@kernel.org,
	bpf@vger.kernel.org,
	daniel@iogearbox.net,
	dmitrii.bundin.a@gmail.com,
	dxu@dxuuu.xyz,
	eddyz87@gmail.com,
	haoluo@google.com,
	john.fastabend@gmail.com,
	khazhy@chromium.org,
	kpsingh@kernel.org,
	linux-kernel@vger.kernel.org,
	martin.lau@linux.dev,
	ncopa@alpinelinux.org,
	ndesaulniers@google.com,
	sdf@google.com,
	song@kernel.org,
	vmalik@redhat.com,
	yonghong.song@linux.dev
Subject: [PATCH bpf-next v2] bpf: btf: include linux/types.h for u32
Date: Tue, 16 Apr 2024 08:15:27 +0300
Message-Id: <20240416051527.3109380-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Zh0ZhEU1xhndl2k8@krava>
References: <Zh0ZhEU1xhndl2k8@krava>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inclusion of the header linux/btf_ids.h relies on indirect inclusion of
the header linux/types.h. Including it directly on the top level helps
to avoid potential problems if linux/types.h hasn't been included
before.

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---

Changes in v2: Add bpf-next to the subject

 include/linux/btf_ids.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/btf_ids.h b/include/linux/btf_ids.h
index e24aabfe8ecc..c0e3e1426a82 100644
--- a/include/linux/btf_ids.h
+++ b/include/linux/btf_ids.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_BTF_IDS_H
 #define _LINUX_BTF_IDS_H
 
+#include <linux/types.h> /* for u32 */
+
 struct btf_id_set {
 	u32 cnt;
 	u32 ids[];
-- 
2.34.1



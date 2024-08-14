Return-Path: <bpf+bounces-37149-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C7A95131A
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 05:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49F21F235C7
	for <lists+bpf@lfdr.de>; Wed, 14 Aug 2024 03:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 567844C62B;
	Wed, 14 Aug 2024 03:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gc7T9Gc/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80380383A1
	for <bpf@vger.kernel.org>; Wed, 14 Aug 2024 03:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723606222; cv=none; b=del/ts0YPvJvgYxH/Q8kEF9UBPuRLi0UDdxZu77YoiMEYSVvhBiDFrNZZVW0Gy3Ui5MdJDR/MqAFToZT1SVgiUx1NLu9UsrSv6DfjGqQldN+S8A2G9S8bl8BLmlGMtg4F0tiqtHyhUK7TyED23ak48X045aZ6lixev5n61yfbjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723606222; c=relaxed/simple;
	bh=5nFJ7ehyCvQFnjG/IjO9tfwq3gab+NR0irsJ84qK06k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mblk2XK3ceAd7O2IIqGxR7DI4ksmWn9JHs+AiepkQaES7DyqhtaZEKCdk4mD3lUTKBWIBvrV4uiyYh2kulRNf/LY28e1Z7NjfTL9+oSUM7rFsJY+1jZbEs3jYLZJMOgWZ/PAmFMSv9JAmDRBKcLg6tF9hhMgvm1gCkMitrlUhpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gc7T9Gc/; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-6512866fa87so55531537b3.2
        for <bpf@vger.kernel.org>; Tue, 13 Aug 2024 20:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723606220; x=1724211020; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wA7s9K430JAGPCORlT7sLO0AYsuu7LQN2Z75vPP4SaA=;
        b=Gc7T9Gc/Q74Q8Exl30itSWWfLef3LZsK/sujZD1Yfx29w+bdU9vDBYOLVktV80axsP
         hkZkulGE6t9wFK1ZTopnykzWPndAxhYpyJG4cX2b5a+0BRei/rXBqd55qFpBLfwLd7wy
         v0zoJDK7YC0tw+p3tA70ckxkCtmS5Fjkfx6bNYE0dB9zt0ioYf5jcp7GJHHLBvrICyTR
         99AS32rwwsZxs/rpa1+Dmi25z/jQLaTDntmu3PrApJlKvcX2YwRGr/KMcoE3mTzimytR
         97oJKW9/speMofNeasYAA3sRLern1FufRrXRhHaELonP6Lc9n0nng6MRhoJMVZwzU/2d
         WztQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723606220; x=1724211020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wA7s9K430JAGPCORlT7sLO0AYsuu7LQN2Z75vPP4SaA=;
        b=XxlwvkHeCA/h8C02qqLHgw0M6OEYd1QN9icCZI0wsMrEj4aYeY6K1r+L5/LG0JRwZ6
         id8WyD0Iiu9o1fuZu848c5LjvMbqGQ96ChqbODlIItFeYkomR5b3mIy8KVFA9jXI2NK3
         j1Ji25T1KoRZeKxtdQ85RZKvDGfKfIK9PBkNqWt5S28jiPR5HQG7/rcfyvMzPxbe1whC
         ZDjffLq2KdIE2rfvbAnDROWHmF7pZ+dAUtpx5syL0TJGHRtviK573m9GYKcO/2MJkakk
         slAoh9btZmhSmUpn8vTR43fHrE4ysJO5BJwIONLyMCwEzPBBZDF6TV5PXcPF2nisby6u
         1nhw==
X-Gm-Message-State: AOJu0YzD0XOUzNJQP4ioJruHPZTPBuRmUc/1AzyN6b8wHeQHJkuqF2Mq
	dTfc73lRc5ZxH3/ThdGq49aSy9XTK0zjasg1JNJE205CvxRuz/Ae9FDsqzoG
X-Google-Smtp-Source: AGHT+IHhkEU8y3rou4wvxD5yjHRSHQSxLSBZBNJ0KWmWaucD7T4SqW6lpNvzqBYiuN6r8j7MJy3lgw==
X-Received: by 2002:a05:690c:2a93:b0:647:e079:da73 with SMTP id 00721157ae682-6ac97b0f293mr13299927b3.10.1723606220189;
        Tue, 13 Aug 2024 20:30:20 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:3c23:99cc:16a9:8b68])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6a0a451b597sm15109587b3.117.2024.08.13.20.30.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 20:30:19 -0700 (PDT)
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
Subject: [RFC bpf-next v3 6/7] libbpf: define __uptr.
Date: Tue, 13 Aug 2024 20:30:09 -0700
Message-Id: <20240814033010.2980635-7-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240814033010.2980635-1-thinker.li@gmail.com>
References: <20240814033010.2980635-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make __uptr available to BPF programs to enable them to define uptrs.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 305c62817dd3..7ff9d947b976 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -185,6 +185,7 @@ enum libbpf_tristate {
 #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
 #define __kptr __attribute__((btf_type_tag("kptr")))
 #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
+#define __uptr __attribute__((btf_type_tag("uptr")))
 
 #if defined (__clang__)
 #define bpf_ksym_exists(sym) ({						\
-- 
2.34.1



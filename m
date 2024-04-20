Return-Path: <bpf+bounces-27277-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE018AB989
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 06:25:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB760281A92
	for <lists+bpf@lfdr.de>; Sat, 20 Apr 2024 04:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB7B6DDC1;
	Sat, 20 Apr 2024 04:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4TzBef9"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03CA4D51D;
	Sat, 20 Apr 2024 04:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713587135; cv=none; b=U4QsqZGOAqb4ta5wyygqfdgM8QqDpkLgTRVKA0GIpbBjqpDifNWrXos3PU9sBZp44LENsPs8eBaRBvnfSU+gmEXW0X1t6yF/xQvwykA8BHGnmEB/Zw8GdAXjViH/wIj2S9W42lSi+uYeQ9r7tKpmJ6imGcFA/jNQcMQOm+cKwEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713587135; c=relaxed/simple;
	bh=/PEvjtHQqmEPPLKgJcudtnHXTm8wBaeXvg9uwMu51GA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e1R3GX4JfXs1ZjzAYZpPOAF6hBiGuPa/uGqJfW/hUfYpBeQRP6XRBPFVGth39crPODZNPxxh51irdzjjK/FE6iel1wU1TFusbLmbejA1G4gmkxNhGNDf3yCvXI/QBARHYkVA7yNHpdjp6RZWjhIJ56kmgU12ipUxwfa8AoZaDWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e4TzBef9; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-571bc63b63fso540653a12.1;
        Fri, 19 Apr 2024 21:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713587132; x=1714191932; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AQZAvRuD90hcrrXB6EEjWoOApNA50EUXAF3WMASiQLA=;
        b=e4TzBef92AoyEiZ4lMOLI5Ir+H3WsHXgNa5LCHCiWaG1mcMObLuDDbAy+TYlR2DEB4
         lu1CE0YfAZA0whfdycAoRcwIyfbnuHZUr11WtIB/pwQhcXPKYXXkbnRLv/FsEjCLuw2g
         wEYKvBUe5p/+pzxELyVl0igyM3CWHOtOqEsLDAVW+lPm0VhHG3fGZnXkBHs0CrRUMdGA
         HPm7x3w2ic0Dl4vXJL+DuyXVE+3NcEsUBhuEX2kGUZ2DDVF5QIuQNBCZHWQU8cUADalS
         fqleeAqOy/UYOz7fiFiMD92x8pj5LgKbGyYQ3O4PhNOfgyI26Lh+IXT9j5b6+PF6fVyR
         SycQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713587132; x=1714191932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AQZAvRuD90hcrrXB6EEjWoOApNA50EUXAF3WMASiQLA=;
        b=S1NYkxiYcmf2mYOravT78Xl2VlO7sttTj5v+XDD6liJGiOjptpXNopUxEVAirCIpxp
         6c4lUanMZYdiiS8dmCYIGCJV/hP6c9qznezNIpEum/Gpxu3Ovh9HbiaUjEtjEM4YdvQL
         W+gjhHyzcodhH/0+3VZcCUy6/NBRtWm9OtRcGbp96gyrWD4w+NC7PFz+E6cB+2ARC4Qr
         2ftY61eUQAg6EI8DipLLW3fMwRltQCGt2805wxKn5X2A6gdLJIGPTs0XENVOTU/kASIN
         5uwbdLQK9i1rOn1WGwiA8kgIuuCbAppgfg6TzD7OHcUucs9O5G1uhSoSSYCnSCqSXw8i
         aQuw==
X-Forwarded-Encrypted: i=1; AJvYcCWm1dGouwLBvJjowVCzvz5YDxfEh8OSputuGyLtujCBygJ9AWh9F4/RUi2JYymz9VEMROXMjrVTkNd1HXvaKJhU8clkRAXY/64bbQ+nZ1ORVbcF+syZKiG9v7NrauYgib6Z
X-Gm-Message-State: AOJu0Yw/2skjGsJmMqTBWVSQRakyOIlB2SvMmdff7dGwFjVDjuq8smR/
	GbQ0NbeFj6UN+SQoHPiuPDFDACC8B261M8PrTefdU3BXE5mqL4XW
X-Google-Smtp-Source: AGHT+IFmR4dCbjwB6v3e+UyfIXF488rNXNckwltDeQ+1POM/5Gn3UOXXXGyLtipMVGE7MZ6mz0vUrQ==
X-Received: by 2002:a17:906:f201:b0:a52:6fed:7664 with SMTP id gt1-20020a170906f20100b00a526fed7664mr2455201ejb.6.1713587131844;
        Fri, 19 Apr 2024 21:25:31 -0700 (PDT)
Received: from dmitrii-TM1701.. ([87.200.40.246])
        by smtp.gmail.com with ESMTPSA id d13-20020a170906640d00b00a5267ee40efsm2957328ejm.18.2024.04.19.21.25.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 21:25:31 -0700 (PDT)
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
Subject: [PATCH bpf-next v3] bpf: btf: include linux/types.h for u32
Date: Sat, 20 Apr 2024 07:24:57 +0300
Message-Id: <20240420042457.3198883-1-dmitrii.bundin.a@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <Zh93hKfHgsw5wQAw@krava>
References: <Zh93hKfHgsw5wQAw@krava>
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

The main motiviation to introduce this it is to avoid similar problems that
was shown up in the bpf tool where GNU libc indirectly pulls
linux/types.h causing compile error of the form:

   error: unknown type name 'u32'
                             u32 cnt;
                             ^~~

The bpf tool compile error was fixed at 62248b22d01e96a4d669cde0d7005bd51ebf9e76

Fixes: 9707ac4fe2f5 ("tools/resolve_btfids: Refactor set sorting with types from btf_ids.h")

Signed-off-by: Dmitrii Bundin <dmitrii.bundin.a@gmail.com>
---

Changes in v2: Add bpf-next to the subject
Changes in v3: Add Fixes tag and bpf tool commit reference

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



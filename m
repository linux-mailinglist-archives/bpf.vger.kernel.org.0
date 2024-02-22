Return-Path: <bpf+bounces-22531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C8DE8605A6
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 23:26:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E7031C21464
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 22:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F32B7137908;
	Thu, 22 Feb 2024 22:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NhkI2NhQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE1973F20
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 22:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708640791; cv=none; b=P5GEPtUZDd3ENgCf+0vg9umcYGt1wnaiE7O+9PhaCSONL1U7WKsX8ZQfSFJBTaVE613CSbUa3a5o6C1RqWFApvFF7D+wRsAzscLp2mZuU5hce0wJRif1llFRGCvCp7ExNFI/ae7vGadH7XDHIVy0QhtTz7oTmzdcDt9vl76B13M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708640791; c=relaxed/simple;
	bh=HWPoxm2exu4cl2asl4FSemXYidKP2WSvF7Ldx5vlU6E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AId8cQIXLNN17eaTDevwBxrSWhfEdoezzbCSU30QO6LgXNdCjuLCsKClPIcxtu+qYK/LzTdIzvOeuC2ADsiPs+7JXWVJlDV2OkJEtcjWDoGRY4LU15gEJ2wnYzT0Rer0bbpZLisxCn2coek3zYtnO4PgI4nMg0NOmy8DTG2uOiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NhkI2NhQ; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-607bfa4c913so2897567b3.3
        for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 14:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708640789; x=1709245589; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+/99EYvY07+3bvMFvR7ARAdMavIYR92Oi8Q4MC2C/Go=;
        b=NhkI2NhQt1IxPNCvMxks1BBFyc8I5A7jqm3oPSFlPZKb5zm6zCmQ7sSbdpZ3rWtYuH
         KscNvqOoNKYzMZp6aPbJgEbKNXlA6heoXV6h+QpM7ltN7u6Sm5tj1Uv5DRjzIWvTx84y
         xAWy4/+SNPb5Z9wzZSqJXOSA83laxjXFaWFCxL+jN4PWrcoAL42tv3Dl9ZiBr+E8c1+x
         Pn5cCPRENjSHQt0N8z61J5HCdjFOCXM1E43GDzK+G03vE8hJpsX9Tx1JSxH3fEc/tSRJ
         PMg9IDOHoiFdcKyCSXY8yYVgiUnx+MD87uM2gopGJhuHhCLPKz5y00QKt9v4z015ktxk
         KdVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708640789; x=1709245589;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+/99EYvY07+3bvMFvR7ARAdMavIYR92Oi8Q4MC2C/Go=;
        b=D72xeZhWt5jJbedpMo1NdaNNAWWdnHlzuU+Lqs4jjKjY+3xeABS4M/22ieMjM1mPIp
         eQ3Z0QmSl0103rWKjtD5x5D4C6CySIHCVQZgMopv82fUOrQSOZ1HU+Sx4Td4OBsdPp7D
         6kC2re/HrHyp+mWlDPvaCaJ85zq/3dUxJghKxUOH7pXmfJIcmYCB9/ong+eZAxSKmAxV
         lBTEnrNpHQzHpXGAiqzrsFAt4SD3xmflyVqbWOSugAHewwOXpcCjs3drxI/OHEUUbDc7
         AlK6wfznHKkAFxux6YdbOVDrAstU0fbX3TdX+4GhzfGmH6zlJlhcRiXkI2YY5m3W3DzK
         1Ivw==
X-Gm-Message-State: AOJu0YzfVNKWAqwQsDuwl7V39vvJYKDiLOYIUFLi0v2Q+Cyx9qImkPuv
	TV1xFPtsfUDWyTGJBCy9H2bgJwIXIifRkuhvN1nG1AjJH2r1cq2L0MHlVx8G
X-Google-Smtp-Source: AGHT+IFg2CfsiMI6O9OA5OdS/HxgbBU+gL/8FIzmahLbaMW283Thp6tcAQyBbm3cZtkOyhP6xKBwaw==
X-Received: by 2002:a81:924e:0:b0:608:ab2f:cfd9 with SMTP id j75-20020a81924e000000b00608ab2fcfd9mr506926ywg.11.1708640788719;
        Thu, 22 Feb 2024 14:26:28 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:34d2:7236:710a:117c])
        by smtp.gmail.com with ESMTPSA id e129-20020a0df587000000b00604a2e45cf2sm3280666ywf.140.2024.02.22.14.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 14:26:28 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org,
	quentin@isovalent.com
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 1/6] libbpf: expose resolve_func_ptr() through libbpf_internal.h.
Date: Thu, 22 Feb 2024 14:26:19 -0800
Message-Id: <20240222222624.1163754-2-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240222222624.1163754-1-thinker.li@gmail.com>
References: <20240222222624.1163754-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

bpftool is going to reuse this helper function to support shadow types of
struct_ops maps.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/libbpf.c          | 2 +-
 tools/lib/bpf/libbpf_internal.h | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 01f407591a92..ef8fd20f33ca 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -2145,7 +2145,7 @@ skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id)
 	return t;
 }
 
-static const struct btf_type *
+const struct btf_type *
 resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id)
 {
 	const struct btf_type *t;
diff --git a/tools/lib/bpf/libbpf_internal.h b/tools/lib/bpf/libbpf_internal.h
index ad936ac5e639..17e6d381da6a 100644
--- a/tools/lib/bpf/libbpf_internal.h
+++ b/tools/lib/bpf/libbpf_internal.h
@@ -234,6 +234,8 @@ struct btf_type;
 struct btf_type *btf_type_by_id(const struct btf *btf, __u32 type_id);
 const char *btf_kind_str(const struct btf_type *t);
 const struct btf_type *skip_mods_and_typedefs(const struct btf *btf, __u32 id, __u32 *res_id);
+/* This function is exposed to bpftool */
+const struct btf_type *resolve_func_ptr(const struct btf *btf, __u32 id, __u32 *res_id);
 
 static inline enum btf_func_linkage btf_func_linkage(const struct btf_type *t)
 {
-- 
2.34.1



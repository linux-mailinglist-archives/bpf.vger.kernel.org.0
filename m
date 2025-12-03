Return-Path: <bpf+bounces-75976-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8678ECA019D
	for <lists+bpf@lfdr.de>; Wed, 03 Dec 2025 17:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 48BB3306D7C5
	for <lists+bpf@lfdr.de>; Wed,  3 Dec 2025 16:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A4E535CBB7;
	Wed,  3 Dec 2025 16:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="AM/9Zd7G"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0460935CBA5
	for <bpf@vger.kernel.org>; Wed,  3 Dec 2025 16:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764779211; cv=none; b=HHaKoFEWUAS1hT7bGnlCiu0uFE1EKLnEZbSWoHLnnfMiDJkvSmBEl0Td4JU5Qz4PrDDQVIOXE1CePkcmdoxkTzcj0Uz/Vfj6X5jGYVSiZ3xdGIDJnuhJmP1hJVMoZgSGw891IABlj0hZmZJeIokzP9Pp18V24yfCZG9VX9Wfm3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764779211; c=relaxed/simple;
	bh=701mWrRYRt2a17VcCOe1RgFlxgjK12oxNcWrZb4Lhi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XPsKXvrfPOXBRKj/yHrnPXT6lWbHwhaFe78IJegZd4hbhdcCo2mH3HrgO38uZnoP98WxHCrhLKV1m3ReEsAWMTvkFr6QB13Sa5Vv0coSHRfrLkCaqY7TjXMUzuOKiBQ9DewCJTzhJ6UehjucGme+4qcDpdSMQSaKVjzUGJyaKIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=AM/9Zd7G; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4ed861eb98cso74385891cf.3
        for <bpf@vger.kernel.org>; Wed, 03 Dec 2025 08:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1764779208; x=1765384008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b8IIUzlFpIarqimBABuL9++MSYvKzBOm+7w5uMZoYl4=;
        b=AM/9Zd7G5vD2LRiofm0Q25YCpnxTKRB3IXqMvtzPwvkKbPiZAmkgSWPVxbN+QkIIvJ
         iN0sx4SArQSs1sJhcViWtc+/yomtH2ulvkNqc26gh28vM84NBh717KOUmVx/64JadwFY
         HS1W3nDlwhJ+YkX1VXwSw5SQJLe8EIH35G0RyYeLUqtfBDUbvrKZ+WMnmpTobW24bQU7
         3n8STkBkAc/f2UIU4rXUG7YFj9tY0nTj+ngmrtcL+rtK7Vx4Jyh3dpI/WGyYoKXrqkV7
         kzPi5oM2PdO+eVEuGIg+HQzpFzCSQq6fERw0Z32v8HFX6TNeYJoUv6/Cab8D26myRKaP
         WkKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764779208; x=1765384008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=b8IIUzlFpIarqimBABuL9++MSYvKzBOm+7w5uMZoYl4=;
        b=sMSX04hjnPrPA6/Zs2tolJuGfcNAJBG88b5OvnZt5FJkF7NTPmT2gJLf5TVCMHRmyV
         vcHMohd8VP5bOUwVnNJ+RTPbWxK1VG0kZBMfkSIchrAqb4URtqzDh38a2/dvTdaeunz0
         EXvgd/54pSx3gbZ2+eJgJwm0NtHc6hHvM+72RlgGmcQDisMvi85YBVscPdO4ppwE05Zq
         Gaw5VNIIbey1Hw7TFGmyCqR0yw+LHXROyGEl5BzmgIGNoHlZZx3ojk9wQpfnTYFQIdjq
         D2WvfjbPpXOIACkCyrXVC3IvL9+Soh0GqV98GXUxOP+om99Z73pKWMpTDWBmMioo25Qf
         k6fQ==
X-Gm-Message-State: AOJu0Yzap7qRvN8cMRj3FZ0/NH27hZaH9O8VHhGyrdt8E23wntxUy54L
	yhc/eQL8jArOBsSksKhDfF4+62Rc58jdgCZgHYNMooQLgZYkwnJlpxGsOmcFy6dfpUW1xIEJWyx
	kat0kq2U=
X-Gm-Gg: ASbGncuw4E4WSjPrwn2JeIFE7Y+jUBd9r9/ChQtqMPz8w1bW04mg7n2QB49YVni0X57
	DEXDE4vrjVl4JDGU6olUG9sgmPEdWNgB4u8rMWNbbXrnO94jM57SG8EutWIJAAltsQA7a0bss5R
	WbBbNqtNdcGHdgLwa6s1dVMuToeQS4PmAn4e68j7SUir6SQ3Ms7caZ0InRE6VcFDY/vIwn88dtK
	svSV6QIIa5B6Ztumrr+XUPO+FOF+tPYVmuGfXCiaQJhNgPxpejnq/MWd117sIZTJA37/t4vH1OW
	v8vIgeCe1K66yz1YvxkkRUwbKqDRI5LyXT/rgFra3wU91vNg36xa7VJmnK+i3irdvH/S/xtDkAc
	is+LjuiEBBpkTplRNqui4r4UI5DPfFpEE2tXBAY1jWOJv4Xf5doBR0Rcx+oxE0Pd5ln86xZAdI+
	lS0iO2hkxkEQ==
X-Google-Smtp-Source: AGHT+IHqHn9+gLZd9cjJZw7tPBovz1UzCa2NizEKfPKWI8VteiUQb+3rX9LratnRxQUTzsriNYu/JQ==
X-Received: by 2002:ac8:7c52:0:b0:4ee:1fe2:3d72 with SMTP id d75a77b69052e-4f0176d9a48mr40283831cf.57.1764779207934;
        Wed, 03 Dec 2025 08:26:47 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4f0046825d6sm45279411cf.5.2025.12.03.08.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 08:26:47 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v2 2/4] bpf/verifier: do not limit maximum direct offset into arena map
Date: Wed,  3 Dec 2025 11:26:23 -0500
Message-ID: <20251203162625.13152-3-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20251203162625.13152-1-emil@etsalapatis.com>
References: <20251203162625.13152-1-emil@etsalapatis.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The verifier currently limits direct offsets into a map to 512MiB
to avoid overflow during pointer arithmetic. However, this prevents
arena maps from using direct addressing instructions to access data
at the end of > 512MiB arena maps. This is necessary when moving
arena globals to the end of the arena instead of the front.

Relax the limitation for direct offsets into arena maps to 4GiB,
the maximum arena size.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 kernel/bpf/verifier.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 098dd7f21c89..a64cc5caf4aa 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -21084,13 +21084,13 @@ static int resolve_pseudo_ldimm64(struct bpf_verifier_env *env)
 			} else {
 				u32 off = insn[1].imm;
 
-				if (off >= BPF_MAX_VAR_OFF) {
-					verbose(env, "direct value offset of %u is not allowed\n", off);
+				if (!map->ops->map_direct_value_addr) {
+					verbose(env, "no direct value access support for this map type\n");
 					return -EINVAL;
 				}
 
-				if (!map->ops->map_direct_value_addr) {
-					verbose(env, "no direct value access support for this map type\n");
+				if (off >= BPF_MAX_VAR_OFF && map->map_type != BPF_MAP_TYPE_ARENA) {
+					verbose(env, "direct value offset of %u is not allowed\n", off);
 					return -EINVAL;
 				}
 
-- 
2.49.0



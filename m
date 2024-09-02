Return-Path: <bpf+bounces-38724-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 80FD2968CBF
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 19:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3773F1F2328B
	for <lists+bpf@lfdr.de>; Mon,  2 Sep 2024 17:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 461B31A264E;
	Mon,  2 Sep 2024 17:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iJMBSIbT"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36EE41CB53C
	for <bpf@vger.kernel.org>; Mon,  2 Sep 2024 17:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725297454; cv=none; b=khNSTDNdsBDkioQUFKTtE41KYGryM1JmRBg18nsET2JxK7ZeC2YO9lPKhzd54twh42idylil8laRqy424TZn4T5l2vqFo3659sjjBVJUPDUO2uquh7EPdMpXDC8i4kkeoVGhK2SWtTJxkw8lepddGrgjHm4iG86lXI/4sUD55qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725297454; c=relaxed/simple;
	bh=Htv12HnIiyEKCwJ5aEIBKEHCgjVmgHldtd1NfJn9Vf4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cJLabN2GGUNHnb9cmCv002SYvuiR27pEC2MyWxH9+6Kys5babINvrldObZozMzq2hzaV09LsCC3PwLkR3frTEjusOdnWBvp+o1+sL3bNWS6efvOlzj1lsjk6lTDMONzwRjeAL2Kjz15+WO42oEVA+0TS9ewIfg3UMmRNA7ZXHNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iJMBSIbT; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2f51e5f0656so50055521fa.1
        for <bpf@vger.kernel.org>; Mon, 02 Sep 2024 10:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725297451; x=1725902251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mRYp8sh0q3WzRGvKbQ6WBnn9wQgWdNhSnKgqk+L6UMs=;
        b=iJMBSIbTiCKIlT7oTBEwXinSfpjlr6hJNYbUWf0U70cJBXWb7yPDkJy31ukV2HImUD
         LSJXHIr51NUFplEAF3YfTGfckuNXf0R9CBNhomG1xnYbjk2Br7FEoh5ELej3sUwflspS
         c03n2NZnDGznw3ZUxGIdM3KSogSnpFyuJyfKqAbsGQ56bpLJ8P8QvjQavF67WKm/Bj07
         5jgJyDew4t5S09ik+D/M5XUIooE6/DAq1bMysX0pF8t8DLvgKYy5NMWC441zkdLL13pP
         AKyreeN3BH0T/ATkvvei32/3Z1cAGPHxQJesSl0aApxZd4jAKn0FSGy9zpj68sxjkST/
         1bsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725297451; x=1725902251;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRYp8sh0q3WzRGvKbQ6WBnn9wQgWdNhSnKgqk+L6UMs=;
        b=ZgCgXKTO5WnhbLJFfFBN5+j4GXBjfAdBztbadhy7E1zevZg1MoV4d0lhyJ4iuVbrTw
         LbxaiVf+Jd44bZjbSXvRbBFfKDqaNeZ54f5yI2S1QubkOsucaHE8r6CiVlI8Z9rRfZ/m
         e2g87AFy6waEniSVvD9TNgDFX8gfwnG4Cth2lcoVzvudKRCYE9nLC4f2AqRHFqKkYseS
         6o6oRyz8T28AvghZ5oPOhJog2p8oZtfvtXNuVnil2F2HFPh7rXXaYAGExRMC0Rsx95ON
         bP4UWxYtvbZbvLEPruT9L4DvD+8dM4SguICv6dbJV3j1WPA+a3tTje78kl68AeN0F64z
         Fv+w==
X-Gm-Message-State: AOJu0YxuyKhQbiylJY3M7fmDctKkhL3/nVr2TXSVSAo/v8KVfDlU8JoR
	QyXeMsnxK5pJGHj0Qr9cBOSy6I249w9cEpf/Z8ZV99hvwDvxLAsC3nxIaBhA
X-Google-Smtp-Source: AGHT+IF+pdWQUZ9kpSgRBzbFmuJUIYAalc9+JyaAEKR+eQCT/mJnsh9EcVMB7OH93rW/HUW3pKkkNg==
X-Received: by 2002:a2e:5152:0:b0:2ef:2e1c:79ae with SMTP id 38308e7fff4ca-2f6103a76c6mr78968601fa.19.1725297450327;
        Mon, 02 Sep 2024 10:17:30 -0700 (PDT)
Received: from yatsenko-fedora-K2202N0103767.thefacebook.com ([2620:10d:c092:500::6:6ede])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c72c15sm5428200a12.24.2024.09.02.10.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Sep 2024 10:17:30 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next] bpftool: Fix handling enum64 in btf dump sorting
Date: Mon,  2 Sep 2024 18:17:21 +0100
Message-ID: <20240902171721.105253-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Wrong function is used to access the first enum64 element.
Substituting btf_enum(t) with btf_enum64(t) for BTF_KIND_ENUM64.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 tools/bpf/bpftool/btf.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/bpf/bpftool/btf.c b/tools/bpf/bpftool/btf.c
index 6789c7a4d5ca..3b57ba095ab6 100644
--- a/tools/bpf/bpftool/btf.c
+++ b/tools/bpf/bpftool/btf.c
@@ -561,9 +561,10 @@ static const char *btf_type_sort_name(const struct btf *btf, __u32 index, bool f
 	case BTF_KIND_ENUM64: {
 		int name_off = t->name_off;
 
-		/* Use name of the first element for anonymous enums if allowed */
-		if (!from_ref && !t->name_off && btf_vlen(t))
-			name_off = btf_enum(t)->name_off;
+		if (!from_ref && !name_off && btf_vlen(t))
+			name_off = btf_kind(t) == BTF_KIND_ENUM64 ?
+				btf_enum64(t)->name_off :
+				btf_enum(t)->name_off;
 
 		return btf__name_by_offset(btf, name_off);
 	}
-- 
2.46.0



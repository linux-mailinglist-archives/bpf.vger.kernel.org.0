Return-Path: <bpf+bounces-54320-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD672A6767B
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 15:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 211F7188ACB2
	for <lists+bpf@lfdr.de>; Tue, 18 Mar 2025 14:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EC220E6EA;
	Tue, 18 Mar 2025 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b="U5It/7w7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B491D20E334
	for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 14:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742308200; cv=none; b=kBC+M5zP1ISpMk58PDipR4PI0MvTTElN+i0isZf35Xa4I2v2E2OGys7UipL5TySlIy00vIlMBJ9iWea4SPm7WanoRFHomfy1dwSs5k9bn1pdIoxFcJSnxUf53hUDrxhbB0TBKO1rTIoZnI0EyguzlhwF6oCrKa00F4doXxb0yYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742308200; c=relaxed/simple;
	bh=NS8EittFMNW25RgnRu6qvLMb4bIk3LC88vj1CK0/b3U=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=biBHcCcrQwXT6FZIo9W4jMEOvFqzmxIzGEooB3QW8Wbe5JHGj0HBkLBAoEfa32fevgCtbnjfW8gNixF8p3NnfiWwdGQFx18Lsjkmozj6MyZlbjtSuul4JrUd82vEkJpVQVJLEttnS2uVZeasKdGnut3KsSKKdSmhN3uvQA28w+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com; spf=pass smtp.mailfrom=isovalent.com; dkim=pass (2048-bit key) header.d=isovalent.com header.i=@isovalent.com header.b=U5It/7w7; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=isovalent.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=isovalent.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-390cf7458f5so4871258f8f.2
        for <bpf@vger.kernel.org>; Tue, 18 Mar 2025 07:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1742308197; x=1742912997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yLBgtQo3i7/QjQG/n7woQBXoD6fz3iMecECPqm+wfQA=;
        b=U5It/7w7N0migjirPX1I7YE/w2xr3ZnWnWabyfLkWh+j92Hfci7nMO9w0pkP2kT2Th
         +mBcSesh5/71enXj7eNA4LJ1juEmFANDCsKl9WNDWJMcztxae/RaxkRgKuugo3JuctfC
         jP6t2NPT8rqArb+ie/tLZOUTizObQ9PGn0MTZn6kl7smCygFxRf2bW/dbHQ2fTCz69Iv
         ViRbscCEga875D78NgTYh5lEWK3/rf6Pn3jgB5SnJSVsW4ohhWtkEVlfq8bkhXxhJxZ0
         PHDgD1mYEJWDaSuaJLrf3ZdM9T/ifKQII76hOAFRz26JGMtVXFqKkF6dkl2lllrzTeED
         p5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742308197; x=1742912997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yLBgtQo3i7/QjQG/n7woQBXoD6fz3iMecECPqm+wfQA=;
        b=pGFgZ/Cd5PDq4kRzd9i7axRsu9NtRSn7Xwvfdn/qOtCtLTw6Ue6JjvfbN8Uz/BFne8
         fDrpBPLiHXhlq4lHIjYCgBkWG5cSM0J9C++Koexrsc/MwnOdv0fFemg/MuiUPiQZ4oR0
         FbtlOVxsXmK5E1nfe3sMwKcwFFvJlOO9IfJeRBXcNG5KwqXIshh7ZmlDPTLGt8dOiSTY
         DJQNzi8MXYl46PxMKL0xXH3RJzGKXNhzxy5cOGBj+nCuXsmF127ZYqOwTLaraVXd7ZlH
         iywWbRLCuKGrzhCWIZ//F7mv/83CZL+yxwe6wcrdc/P8mX0dsZ5yAjTU93raDILBvJeb
         xIYQ==
X-Gm-Message-State: AOJu0Yz9bs7GWz+06wLMXNG2ZJ3nfHYacd/aPAg8LY15+EcYJSrW2eaC
	Ce49Tsvli3RCm78XivWU6/YG/wcVZ8qccbJ6KO4v0jB8fJuZkEBqsZGxCVZMWlnWHGv40pdH8UB
	T
X-Gm-Gg: ASbGncuemVowNEOXZKCBJ4iuO0iHqExDkq2+BxteQBiEGxKHaIrjBUjf0VB2O0QGW2T
	aFWB160619Mz1k0Sll78x095zJt3I+OX3iJz93iW5krtbTTAzWOt6ZtF5UIBao0kXJLKTZsYk21
	LaCpaP2k6v99zS/8ZcdaOxZdG/puLRo2JjE11K0YOEGa/elV0g6K71zEuTZtkzas3Hs8pxsRFkb
	xt+qqV9x/CFivYJcRUGUUAbFtMv07rMUnjAehS78y03OKamca3Nb0K78DlOL6TMXc+o2g1ynVgD
	HagW2LQBqFtU6CajSNsAEr9I8oP8QYunU4l4loVT7SpXjMivRZ/J+v00/q4LJGWTxrRX
X-Google-Smtp-Source: AGHT+IESoez2zta8EjXMq7jZHvYw0t+7c0qBmedwIs+nvjEKqTEidYd6BTRbZas8Cax2UrdZBaCmog==
X-Received: by 2002:a5d:47c6:0:b0:391:3049:d58d with SMTP id ffacd0b85a97d-3971a58af82mr19819936f8f.0.1742308195900;
        Tue, 18 Mar 2025 07:29:55 -0700 (PDT)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdd0sm18348071f8f.77.2025.03.18.07.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 07:29:55 -0700 (PDT)
From: Anton Protopopov <aspsk@isovalent.com>
To: bpf@vger.kernel.org,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yonghong Song <yonghong.song@linux.dev>,
	Quentin Monnet <qmo@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Alexei Starovoitov <ast@kernel.org>
Subject: [RFC PATCH bpf-next 10/14] libbpf: add likely/unlikely macros
Date: Tue, 18 Mar 2025 14:33:14 +0000
Message-Id: <20250318143318.656785-11-aspsk@isovalent.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250318143318.656785-1-aspsk@isovalent.com>
References: <20250318143318.656785-1-aspsk@isovalent.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few selftests and, more importantly, a consequent changes to the
bpf_helpers.h file use likely/unlikely macros. So define them here.

Signed-off-by: Anton Protopopov <aspsk@isovalent.com>
---
 tools/lib/bpf/bpf_helpers.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 686824b8b413..a50773d4616e 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -15,6 +15,14 @@
 #define __array(name, val) typeof(val) *name[]
 #define __ulong(name, val) enum { ___bpf_concat(__unique_value, __COUNTER__) = val } name
 
+#ifndef likely
+#define likely(x)      (__builtin_expect(!!(x), 1))
+#endif
+
+#ifndef unlikely
+#define unlikely(x)    (__builtin_expect(!!(x), 0))
+#endif
+
 /*
  * Helper macro to place programs, maps, license in
  * different sections in elf_bpf file. Section names
-- 
2.34.1



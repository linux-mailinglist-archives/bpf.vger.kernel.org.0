Return-Path: <bpf+bounces-73589-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDB1C34A61
	for <lists+bpf@lfdr.de>; Wed, 05 Nov 2025 10:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E67AF4258AF
	for <lists+bpf@lfdr.de>; Wed,  5 Nov 2025 08:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 043CF2EE5FE;
	Wed,  5 Nov 2025 08:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S5ifYkc+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3C642ECD1B
	for <bpf@vger.kernel.org>; Wed,  5 Nov 2025 08:58:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762333084; cv=none; b=ITmqHZ2bIsfjrAt8amGl9cj0UOk1glvZXpnZqNZ9ufBXZJ0bFR6TrK6v4t6h1T0MCMQbX3aqYFn85OeolSXqMFRr6YGm7LZoNS1dxS8gQ+dNf+7PW7KxUg7NrSfxfvXzhwU3nsR1qqh+wepQCeIx30LXK1HcJR3mjemz8aeZRi8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762333084; c=relaxed/simple;
	bh=wVCcbEC0f/vUm7hZgm8tzTswgmCV9gvRzGJ1/CXBDtA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=daHUTH60Dfj8RyhG4zAuQQgMW8ER6ZOL57aArkzhaBYp2S3UpksYVaPH8lwFXCO4tkLZM0KdFulx5Or5Jz0sw37kawOrm+fTeiYMkFdrfDxF/L1r3z9FAIr4Z7XTZwgqw50/KR1ymkdnjLTlmtNTmcSC+oqH29KtFKsVn3laAQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S5ifYkc+; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso1019747766b.3
        for <bpf@vger.kernel.org>; Wed, 05 Nov 2025 00:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762333080; x=1762937880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B0AK7dxJuU1TIWPffDk2kNiVQwFno8HMSYg97tDuH3U=;
        b=S5ifYkc+Bnhz+6S49/Eu1sS5PT8nKlqy0fR6sWnxiPcNYUmy0HiDl82SEX+qGVkYug
         TsdhrDB7r9aE02DHHqg3TaZmu2i5EeRISxScKH5HqmVxNkoPaMGDtpO6MWCC/+6xQ/oW
         ScSLNyfVqKX+tgLCtuhcmsisRb1X5EGnw0lvILDUyZzNtQ1GslolsRZLV6Rq2d7pvrf1
         MWK8PTvFT2ZkaqME1flSgVVtWwVCWZ1tASy3m3rmn7SFjT/IE+yIOUCNbg43lgxnba3x
         1p4IO0nij9bPhVLePSHw8t4dOtyunBLz2ObQvexbyjtzE7iOAlUrcAgxLKdGLTKCOmhX
         aOwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762333080; x=1762937880;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B0AK7dxJuU1TIWPffDk2kNiVQwFno8HMSYg97tDuH3U=;
        b=tW0V9DEaHO+B0UoB/7li/8n+A78Z7FmvFRdgKcAd3mJHiRwS7QIjUYGmIhREUfSNDu
         Pp9bD95H40qWkJ7cZ3E+N/eeCcGmTCykQRiTrC0YoouiZCyBLrY9tzIagA2pem2Xj0Jx
         ihCXtfw+cUkYmum7VVbk9WYPkour9jq0xsy/3ncfFMPwmij6scGZcIv4NlkePNlSh7Ov
         LC+iB7xH0bhVUZPCSs11EdTrEjKoLL9TSEbk31vbcsoWjqKA93Y7GxVEn7MfoOvwB7l3
         15YjFNV54DdD8jbrg8MOMH985xkpJQmz4d9xCB69b9xSkVbyq/JBWWoYion8dUyAcHWa
         QGwA==
X-Gm-Message-State: AOJu0YyIHkgVV9g27pp8YPRxrhUZ35K82IUtV7aiBPDz1SZLGlizr3BV
	DObopzutk9F69NEznP3h8LGFkrZlrlZ7l0jNX/7dsrv+oMd1YXjvWJIjQgcTWg==
X-Gm-Gg: ASbGncusiJ4A5O7Al5eOhrO5biStQWLDu74vbzgzTbz8LN2zFyNo6/jd3kZtO/+7fVe
	qBKAhXVloU3ZURzUnD4AvZgFhD6/cafuL4jMrfaLcc47vuYYUGmvaXF95mV+YNcHMggq1h60Bxb
	fbL+eKK+ke2bcY8VAnsfGHO0XgFAp/f4DruAH1/EFY4t4uFYDWKlCTEhrj/zMJYyerjMVbPjgJ6
	hZTUyITPoSKCP4OiouNOKWQmYIdTuDUtWIQfqVJamzjyzPJSvc74WNZIx76c9QFrYHp0Cp1q9dp
	UUGdNbBkipZxLMPCZBwweVxaouNtSjqB5AWqBJ9cuFKPnwEqRJizbWurq+jo0FpP7kdGKzGed/f
	d+U71ZEatFo3v77lRgRI9+/sYzCXl5q1/0gP7vESAM7zkzr2T+sbFGuhvy3/qAdbBq4iQOH0Q5w
	oiEiGYRmI5SqjKwFRsmt+29L1SFajnmA==
X-Google-Smtp-Source: AGHT+IFlt+YKUMqC1qfH8PRUBEkmAsEw5sVQ14cGoI3pNkSyFAtPxKvFTIm2Y66+R46SwTMvSjMC8w==
X-Received: by 2002:a17:907:60ca:b0:b6d:6832:a9d3 with SMTP id a640c23a62f3a-b72654e31a7mr195473366b.39.1762333080433;
        Wed, 05 Nov 2025 00:58:00 -0800 (PST)
Received: from localhost.localdomain ([2a04:ee41:4:b2de:1ac0:4dff:fe0f:3782])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b723db0fd12sm429685466b.32.2025.11.05.00.57.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Nov 2025 00:58:00 -0800 (PST)
From: Anton Protopopov <a.s.protopopov@gmail.com>
To: bpf@vger.kernel.org,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Anton Protopopov <aspsk@isovalent.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Quentin Monnet <qmo@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>
Cc: Anton Protopopov <a.s.protopopov@gmail.com>
Subject: [PATCH v11 bpf-next 03/12] libbpf: Recognize insn_array map type
Date: Wed,  5 Nov 2025 09:04:01 +0000
Message-Id: <20251105090410.1250500-4-a.s.protopopov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
References: <20251105090410.1250500-1-a.s.protopopov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach libbpf about the existence of the new instruction array map.

Signed-off-by: Anton Protopopov <a.s.protopopov@gmail.com>
---
 tools/lib/bpf/libbpf.c        | 1 +
 tools/lib/bpf/libbpf_probes.c | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 27a07782bd72..777c848ac097 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -190,6 +190,7 @@ static const char * const map_type_name[] = {
 	[BPF_MAP_TYPE_USER_RINGBUF]             = "user_ringbuf",
 	[BPF_MAP_TYPE_CGRP_STORAGE]		= "cgrp_storage",
 	[BPF_MAP_TYPE_ARENA]			= "arena",
+	[BPF_MAP_TYPE_INSN_ARRAY]		= "insn_array",
 };
 
 static const char * const prog_type_name[] = {
diff --git a/tools/lib/bpf/libbpf_probes.c b/tools/lib/bpf/libbpf_probes.c
index 9dfbe7750f56..bccf4bb747e1 100644
--- a/tools/lib/bpf/libbpf_probes.c
+++ b/tools/lib/bpf/libbpf_probes.c
@@ -364,6 +364,10 @@ static int probe_map_create(enum bpf_map_type map_type)
 	case BPF_MAP_TYPE_SOCKHASH:
 	case BPF_MAP_TYPE_REUSEPORT_SOCKARRAY:
 		break;
+	case BPF_MAP_TYPE_INSN_ARRAY:
+		key_size	= sizeof(__u32);
+		value_size	= sizeof(struct bpf_insn_array_value);
+		break;
 	case BPF_MAP_TYPE_UNSPEC:
 	default:
 		return -EOPNOTSUPP;
-- 
2.34.1



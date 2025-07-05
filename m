Return-Path: <bpf+bounces-62467-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF7DDAF9E64
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 07:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D0FB4A6C75
	for <lists+bpf@lfdr.de>; Sat,  5 Jul 2025 05:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521C92673B5;
	Sat,  5 Jul 2025 05:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KCkxGn0a"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f65.google.com (mail-ed1-f65.google.com [209.85.208.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23968AD4B
	for <bpf@vger.kernel.org>; Sat,  5 Jul 2025 05:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751693451; cv=none; b=A0IlJHz1ZXQ3zEdpd359phizqU81jlsHg+ooyFaFT469cbBkAg1iEJ0kzjWTMY3WNrhIFeoATnc0EFj7N2ReZhlnJfdZ8PnaxgbbxpWiYWvHUx01MbfYMYj4QX78B48RkNetRF2kNg+dVJBc91BBn1Ks2oleXLoH+6p+xbbMK5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751693451; c=relaxed/simple;
	bh=kX/5jDdFoXc1ciGQfIgyhDSRa89daW3Bv0RU7g6v+9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fMD3VeE0xGagBhVb31+KJXd0zzltTYmNNesV4gkC9IAzCcDL+HIgNl3+xz/QZupLv2cy70BTU/CFlta9UVUx/Rwm73B6YutYbTKbj+9FvBGeekz5og6gDiybvNKserdJgvF3ZJredUs89ICvSV5rhq6pU9K2kS8OSJLizHs0bfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KCkxGn0a; arc=none smtp.client-ip=209.85.208.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f65.google.com with SMTP id 4fb4d7f45d1cf-60c3aafae23so5668270a12.1
        for <bpf@vger.kernel.org>; Fri, 04 Jul 2025 22:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751693448; x=1752298248; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2usC/a9qIJc//Ji7OWwUUWknW/QBNB2IhQETwAPwWOs=;
        b=KCkxGn0a1vrAfXc9HiRPEc2i1Mb2FbV9E6VeU9ZpvBUdHU4WOH4LG26IpkkeYUccD7
         PFR69W61mA1ab8Zh3Fd9sIvpdZkEkKg1o54YWv1hz0JtuXZtnqRnEC9iVZUeGl4w52lb
         9j4ZoL4NfIpt2TtR4gTXD+zSfJfIg3Ub5tCwPrFnAwozMkuyqaXrdh9oIQB8TbohGJQw
         qv9f0UbAgRKBv+s35xHLjwdfYxVLCfFMdztvuk2Xk9m08URHAHbt/cA8usp9rFl2K/VE
         8KE4tNlVOqVYa0rH3qWA9e/ml2yBeaOcoNcTB2o+azndQO3XY9Du81ol0psOPwT+EXeZ
         3y0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751693448; x=1752298248;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2usC/a9qIJc//Ji7OWwUUWknW/QBNB2IhQETwAPwWOs=;
        b=mpfKjYVEfoqxyAtM+Z8fIN3azDeZhl3ia1LaLWsAWkAus5MTPaaAS9n1bcSFZum3zh
         x/hoVMiBcUwzcJY/tD/oSVMHZX2xPmBYyRRloy/E90fGIzYw+gmyYixc9xTjtf7MLBWv
         LLPWUmRqPYU7sf8wIVRyj1QoPKiQ9zBFolHa5SFDbTBErhzOs1FFMeOknb/RlIgD6lKO
         h3Of9hJzkasDvm+7mRLR6xXE/HhDhFnwXyx1YpvJ21fhuoWgBSXJ79q5wH0fCdIqkZF3
         M1eh/fmoNk95N+v2lvolCR5Wn7U2PZ86lt3SXVJdGDHv4QA6lHiS7OVwGrqw4G+1qwCr
         i6Zw==
X-Gm-Message-State: AOJu0YwNzhMTWEkLdebJlcWR69+gOoE027OM517nDL8jXg3i+KrBhDJb
	QWfVhXaUXOgGVjwIfGvJZRsqjiqhLiwgmbFQV1G/Ad0FDihRH8P1PmVb4K5iYZ9EdR0=
X-Gm-Gg: ASbGncsff41o844GsJJPHb/BqQUaLJdH4wTcy8engGBfxGWxRaqzlTeRMVZuuTLP27N
	FaQhptNS5DPxW4BgECJ/LrYI3JUPncJdFWG+MLurBxxBacRNnYk9JSeUH61RM3ASyWJQ7xLyJlM
	/N09VIk4LAAzUWUWdTXqcpybO2PxbpqQjsjJGJrXNQkeEQ3fy/sXPVnN9Fk6fzadxf6nLW2pShP
	qNgYm6l7EsxGXp1XSwb/iVuUEkHkAecd+jEIhlxXrHEuCl7TcDrJV8SJpQnVpIv0/kOYyqSgnJx
	0ep0EF57YgAI+Qm2Z7i/C0Y9zAtyEnkLgxYcDPSrKjgThplEbsnN
X-Google-Smtp-Source: AGHT+IEVYwU43KG47JZeMJlnCicAh1tKVlEeLGQnXB8K49ayuTVXBzNHyxhCw652ADDKjfav8/jW1A==
X-Received: by 2002:a17:907:d01:b0:ae3:cec8:1c7e with SMTP id a640c23a62f3a-ae3f8309a4cmr516361566b.20.1751693443321;
        Fri, 04 Jul 2025 22:30:43 -0700 (PDT)
Received: from localhost ([2a03:2880:30ff:73::])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-60fca6676b8sm2147027a12.13.2025.07.04.22.30.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jul 2025 22:30:42 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: "kernelci.org bot" <bot@kernelci.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 2/2] bpf: Fix improper int-to-ptr cast in dump_stack_cb
Date: Fri,  4 Jul 2025 22:30:35 -0700
Message-ID: <20250705053035.3020320-3-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250705053035.3020320-1-memxor@gmail.com>
References: <20250705053035.3020320-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1263; h=from:subject; bh=kX/5jDdFoXc1ciGQfIgyhDSRa89daW3Bv0RU7g6v+9c=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBoaLO7CSnXL6oyACX4Ppp56SrLjCfC5UhBREOxC6zI 8dUloiuJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaGizuwAKCRBM4MiGSL8RypthEA CoD5Plod+fDMjj2Q4y6j8rnyGkmJz0CPOUBGCXfH6RNIcTMxipQG5Himi4SL6YIVIbB4fj/8WvV/aW 3rKc+UX0WP5f9SVR8MNqoznVDXGWh/hfq06xQkYC8vYDDSs+1HNpdAN4jyEsrwV0RCTZPFPqZK1k4P 4N8EvHFfv8X4U+FhKOrZJP6x1rn4YXh5FxWn3ZUb/8uH+ANidAKvBiRg7blF5Gl8dZZWIsRdOod+vt wkn2Ab1/PBU6OaEnJBSIvNVvRd2FniBCX+Pogcfeoq/PGaT7+OlDWL1GQI7KXiemIG8MrgZCUMAxvI 2JehcwQtDOhfiLBqL0aK7/cDiVaqGhfNkb7AgXNySM6hG6ndIYvpeszhlf4iAGizmdFRSoJ/DxtKMi g+K/1jctv9yIIn8sMx2RkgwQy1Y+0c4D1beZxCWMgysG0WDa0Oq+bKk0+BAl/vZ/4wsB4aCcNB+FOQ 2XwgouKIIM3Q1jPgJNrjPAH86VRVG+oKMr6neEAbLWQMA5INvX+ZKoV000iZ0zkAKWcHqEd/wvmoKF gCX2tOHU0GEKiufvE+FMiclb/DfSnIxFQu5JxZVz+psWESAmdGg87sNhkLWQNJEM9TL4+qKQw6KTO0 p+mwC/qco05x36VcEjLlWRUT49iEM9w/mh1AMV+aTAguB5boJv2N8iHxlkkQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

On 32-bit platforms, we'll try to convert a u64 directly to a pointer
type which is 32-bit, which causes the compiler to complain about cast
from an integer of a different size to a pointer type. Cast to long
before casting to the pointer type to match the pointer width.

Reported-by: kernelci.org bot <bot@kernelci.org>
Reported-by: Randy Dunlap <rdunlap@infradead.org>
Fixes: d7c431cafcb4 ("bpf: Add dump_stack() analogue to print to BPF stderr")
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/bpf/stream.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 8c842f845245..ab592db4a4bf 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -498,11 +498,11 @@ static bool dump_stack_cb(void *cookie, u64 ip, u64 sp, u64 bp)
 		if (ret < 0)
 			goto end;
 		ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n  %s @ %s:%d\n",
-						    (void *)ip, line, file, num);
+						    (void *)(long)ip, line, file, num);
 		return !ctxp->err;
 	}
 end:
-	ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)ip);
+	ctxp->err = bpf_stream_stage_printk(ctxp->ss, "%pS\n", (void *)(long)ip);
 	return !ctxp->err;
 }
 
-- 
2.47.1



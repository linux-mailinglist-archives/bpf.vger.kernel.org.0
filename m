Return-Path: <bpf+bounces-45920-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507609DFC0E
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 09:38:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11BEA281D75
	for <lists+bpf@lfdr.de>; Mon,  2 Dec 2024 08:38:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD0731F9F6B;
	Mon,  2 Dec 2024 08:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TeYYKcJc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE0A01F9F54
	for <bpf@vger.kernel.org>; Mon,  2 Dec 2024 08:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733128704; cv=none; b=Rw7b9zqbz1b6LbFUmjoJ1dMjo+eONvhFncKYHwJlkzorTG0i5PBiRB388+qBflIPdjKVkJujlDwWIWgLhbfFkL26z8d4qsVbVxzRhqKE9+fwee0ejZHAp9v5aJ+WuLOVizhOBbCydM2RXSWWCluW7gRr1y3132hi+bWKzl8pozA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733128704; c=relaxed/simple;
	bh=0f9/IXsdD2wpp3jPPE+35gn5ZfMT+UDAVZ6Q+0zzh0M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WrVl2EZPEhWSeqVcYZY7UzAWM/VbWIyuDzNBjS1bziT18hrmUW9r4x5eLeqp3YW+9PBMbTwMeaOdJpb5hxi4ChBpUQB5yjPNfhGYdUCrGjz03ov83N/5uHu6HtcEjZtNcgNB8/qPfN84J6coQIWNxVItG3JcOMBc1AnnPg0xmZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TeYYKcJc; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-434a099ba95so35617825e9.0
        for <bpf@vger.kernel.org>; Mon, 02 Dec 2024 00:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733128701; x=1733733501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nRF95go81yeay253Jkfjdhxv7Z65qGYIa1/dE4r10MY=;
        b=TeYYKcJc+xmJrCkj8ri3BaqloMuIkcrt8JGNurYl9811VG65nQhXiwpVLaYmm5DnFK
         OMaaHbi3fR4z2i4gVnsCMcTsdQTNQLbpbhWSkbVAY2h6iMiqTwXg7fCUIatatgfRxwh0
         60Jj31a8Aumn920TFWr3eWqQvimHrxpvRg0flEOKFL35aDIt7WiNcTiVwSI1aj8AP7Z9
         vn9gCubjFR/oBtTEGii7GhZjxIiSazOdNUq+Gh/hl8Bc3mvkyuMjqRa3TCV7u8Qe+spK
         Mhf5E2MslEUWqzlBMHuQRf9a2/pI0bpockktzJ1+PLgm788svNqVjU0wZeQvvcczv0eZ
         qvbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733128701; x=1733733501;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nRF95go81yeay253Jkfjdhxv7Z65qGYIa1/dE4r10MY=;
        b=Gh/rxRYwCl5M1owcj8eA3w8QowUpAM4vWYtDbfCJ5BZG1KGFrRp17YOVnKt9pj1hLv
         A48fK+ew2G9DRH4b9fdQxaIi5AhDoETmNQP1CCbXEnyVlG80d40I3S9jkViDDpmczsy5
         ZIJsvnX/eP0biLemr3Tr+weoFe0kvMolq0rsuAjvHri3gHaeDbAjmYUBLcYgZfg/NJHW
         JmXJ0gOE7cATqj4pr7T1j6yJOjok3ITSAfSVGRi4frVuXkcuqezt2x1ckYJb/kadREsL
         ia/0ukzsyXC+koyxmtdvgQqQBhLQLiMN5pz7le8jrq0v94Plh/UmMshXyC13QEf4P5JA
         3PEw==
X-Gm-Message-State: AOJu0YzIFVtc/ocwZDgiZCZbfK9U9yWSipHKQ3axeLOI379Vpasg0P5h
	85hV8P9xNrZYGOwO4NWBHXYAd9TjrbmcOa+oeMPpVCkTwsBfb+1GjCrk6RLa3Vo=
X-Gm-Gg: ASbGncsmw9zzpVmzVoYxQ3w9JLYr3MgECQdmEwfX5fGoDNUl6DgfO4pXJidSY7MUgXO
	1u4dNm/7/q+ZUIK9MpTzwG1Hr+hrjJ5YdGfIjYjcsBj+55uQhmt/JbG1DE086yrU6TSyDyWCzsB
	mKB/kgTyKXVprDxDyUZRKU/FvBp6VeC1eBaRwqL04QzNRPPw1v3304jMpOcPRZ/1YLIEsZlNI8/
	9VqQ6Xg2fO71TfHLLHO9505ehXv43cJnmEXBFk7jet6X2Vlh1MZQ+b0TWGl1kLROO6rTfPz6U83
	XQ==
X-Google-Smtp-Source: AGHT+IEOu+GEPSlf+mye97K1S/NlGD6sj3UC66hyv3N1tArkT/6zBo9Ujk06WMbrjQ387y8U6ZkvZw==
X-Received: by 2002:a05:600c:1549:b0:434:a169:6ff7 with SMTP id 5b1f17b1804b1-434a9dc0f05mr201232275e9.9.1733128700714;
        Mon, 02 Dec 2024 00:38:20 -0800 (PST)
Received: from localhost (fwdproxy-cln-019.fbsv.net. [2a03:2880:31ff:13::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f327casm146040145e9.27.2024.12.02.00.38.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Dec 2024 00:38:20 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Tao Lyu <tao.lyu@epfl.ch>,
	Mathias Payer <mathias.payer@nebelwelt.net>,
	Meng Xu <meng.xu.cs@uwaterloo.ca>,
	Sanidhya Kashyap <sanidhya.kashyap@epfl.ch>
Subject: [PATCH bpf-next v3 4/5] selftests/bpf: Add test for reading from STACK_INVALID slots
Date: Mon,  2 Dec 2024 00:38:13 -0800
Message-ID: <20241202083814.1888784-5-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241202083814.1888784-1-memxor@gmail.com>
References: <20241202083814.1888784-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1300; h=from:subject; bh=0f9/IXsdD2wpp3jPPE+35gn5ZfMT+UDAVZ6Q+0zzh0M=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnTXG0caEDQsBfdajdqdnI7WAGkL261xTZPnZ/byzO t8nmWaCJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ01xtAAKCRBM4MiGSL8RyqbYD/ 4hYwb4MUd6lFnFT7z0CE3V3Mq3aq9Zf0Kv1fT3AjZVn2zluZYsNd31+epU4FWV1dqASG1B7D2ta5Aa V1Digy65vwkZIZtZbbu4IML1QKPSPDK4mm5FtWHYVNr5A8Rogeja+kdOq6kxNkdrycB6OTyfHu8/jQ kccK1H1Ge67JDagbGGK0dQnIFhVRdl3JqOazhvUsd/sDmXl1rGoA5YXQ8jRS10KrYpmtOxvf3ATLD1 D/w9A75Q5qkEQPiaExgyd1ATo1PJUv1AGLeY9txa1KLDSI/mrVgnPh+CXii0dtHdr+li6DHdO/y6MK LpZS2XwJ/UCY2YOg63R2eVL0S0nzSuDCCBIt2D0E1cOX2yfB/5VjFIiEEU30VN60PlbiyqGGqszP4R Oeyr5HBxV0QVyWlcAVd4vDuSps1qrLlg24r54JFUbgeCvkulsdtk7ajsWiX38FWualDk2Ibn63yyoF Cn0d9xzPBiN+ayMxQCgHgw3KAFLoUL0971kzE3qJeLHiQA4oB7L000nCLinZzHNgijeuZTU49IabKY ExjSNjBoy0sKqZvqrOej1JuSFuLkL5wY68FN5PCxfNEZ06xb9QBWJxA5z9I8HplHQgBEbZcf+7iv57 9sQPkOmWPBcwUo462TV85i3prpW1QcLIzpdJ09cI9B+ckO1LtKuV4fN3Gekg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Ensure that when CAP_PERFMON is dropped, and the verifier sees
allow_ptr_leaks as false, we are not permitted to read from a
STACK_INVALID slot. Without the fix, the test will report unexpected
success in loading.

Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 .../selftests/bpf/progs/verifier_spill_fill.c   | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
index 671d9f415dbf..f5cd21326811 100644
--- a/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
+++ b/tools/testing/selftests/bpf/progs/verifier_spill_fill.c
@@ -1244,4 +1244,21 @@ __naked void old_stack_misc_vs_cur_ctx_ptr(void)
 	: __clobber_all);
 }
 
+SEC("tc")
+__description("stack_noperfmon: reject read of invalid slots")
+__success __failure_unpriv __msg_unpriv("invalid read from stack off -8+1 size 8")
+__caps_unpriv(CAP_BPF)
+__naked void stack_noperfmon_reject_invalid_read(void)
+{
+	asm volatile ("					\
+	r2 = 1;						\
+	r6 = r10;					\
+	r6 += -8;					\
+	*(u8 *)(r6 + 0) = r2;				\
+	r2 = *(u64 *)(r6 + 0);				\
+	r0 = 0;						\
+	exit;						\
+"	::: __clobber_all);
+}
+
 char _license[] SEC("license") = "GPL";
-- 
2.43.5



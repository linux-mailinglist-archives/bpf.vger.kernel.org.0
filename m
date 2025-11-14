Return-Path: <bpf+bounces-74491-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14CBCC5C451
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 10:30:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80F673BD5AF
	for <lists+bpf@lfdr.de>; Fri, 14 Nov 2025 09:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934232FBE02;
	Fri, 14 Nov 2025 09:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Il+n4sCY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f195.google.com (mail-pl1-f195.google.com [209.85.214.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50D930AACE
	for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 09:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763112326; cv=none; b=S69GSOrWpVOkvdmMdzMpJOpZu9SUEC7LJNAHPPKzp2AKb/9HQ/ofnz+EFVrSoKDQ3OsjoLdxuGnjhK0Gp2pskTYwuE9Yh89M6Aidf+2GuDgqOfhmY2+J+zkA5Y/Bf8nuzHJCzNQumUrzgrEQG/Y3AZxyfVIlHdJE5KLX52qqUf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763112326; c=relaxed/simple;
	bh=4ETTO9+rYsbYHmKk114m2zMiu+9FB8O2MF688r6MCdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iAzkeeTpGt6YV0dFjwYdQkRQQIffYmxfEchk5RXQKoyYHeo9SNxSH/5UoUgfbEgTcCV/MPILuf30sZJYIkIfVWqPoScFIwoelfLLWjg3GgBp6iQcKCruv+VGHRDlF823iibC1tzpWfzA7a6044TZgU9XUADhIruk4zqyzjflHeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Il+n4sCY; arc=none smtp.client-ip=209.85.214.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f195.google.com with SMTP id d9443c01a7336-295548467c7so20136155ad.2
        for <bpf@vger.kernel.org>; Fri, 14 Nov 2025 01:25:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763112324; x=1763717124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLWaDKWIVOGQHPd1CPktpd+aufU0XSiNZY9F4JwbLEQ=;
        b=Il+n4sCYzUga5HWfg84pzU6Uz2bquLvqAxCwvQKnXbX14qwYtRStknLg6pmXpIWf3u
         thMJcUdDtgn6o3namLNRa+t1aabSGPnA4SXx035YjtEMbNUM1ph1e3jzRfuWYp8lmUht
         zERO9y6LzmlVdr2aMFrxXNAGZg2CF8LAxb5PnvVuypiUFkDWPyOF970FoGGHJl1RpY3O
         0YLCA7eRYroQ5sztn3MSiNs/Hgm+liDGcOBY4fO7Lm9fxiGMAZQA2UL0GeRK8Muq2ka8
         XBAcbr57zr9OsyXnKdmoPLlGp1vpKmiSyn3Oc5TLEbYe7wiBaO/VCY2jlnZILA52iebC
         KF9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763112324; x=1763717124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dLWaDKWIVOGQHPd1CPktpd+aufU0XSiNZY9F4JwbLEQ=;
        b=u7K5rFYTs6fiXxq00wbRANejTs+OFvjfnfugkJfeEsXTZ9Cd6wDo87k+EnBGKCe3GC
         C4pXrd1qrER8Tq03pnNDHzAK7I4XZdymQ4e58ZAEizWSnLznYyfbdG7fWzMu+3oyS4c9
         fdBdwMYcrdClWdMkp0x+szgi7MnMWQ2CObl3kdg93QPbqWhc4HvzV1zbpGzSWNbSA8JQ
         tEsnEEfa7SL1GQjRqYIA5J/VVLMdQ5QklZgxkuEO0eICUCVyIGqzNFLr3a3JAy6DGPbj
         zbYQ5Dcx6pl4V48fUy70p3dK8/NoZfmrtRIqzd2QENPf67n/y7j3LpYjI4bACKUQ/q6T
         0xyQ==
X-Forwarded-Encrypted: i=1; AJvYcCUft7VE7hW//Y3/4wLztXNq1ZABlvP7PBebLEZr9H/5a4PGJiY5Iu8nlRTVAO4eStroXxo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqCCL9XXYlDVZx0iODnQzWzkVEvVacZPFcRsuHJjcP9wprhbJc
	1VHNopaHCs6+7BXM3YpPBMUhX6OrJhbSqkxDGyqitqv4yK7I95rAkp6A
X-Gm-Gg: ASbGncuK61JAXJMtya1A587cYNOBn+JTytdXgbcFwD/lEN6lJEiUHSKM3Dh43klrFhV
	1ZsbD36RF+4cqwTPX8kehH9BEOWMY7RtZqlWFosbnK0c6fjw1dMOPtCr8VVLxBJg4zZTGY3ADMF
	/XqOoJu1WfPjNlSleyMm79DZ5wOlvutRdK0wJ3UYf4lKJqKy8De3P3L7nevgh6qfQ+8WAx9PcwA
	Iv3SYn4gtFmqp22El89Kp4HCjNMlrklb9kLRAYg5KKZSZk5pu0/QJ5VVg3Twj7ePcR0rSnwsjtg
	l2BYSqu8dFvOqLcTqJ89Vk9nfSWewsOWnRJVZTfR+uz7Ai9ioAyZEEbE/aTt6PaqAaw3rtfljSZ
	FTtGlAMfAk7ojl5WcmhafHLAssEvJ5OqsHXi0JDf5OjR2h16w/uPwohNZk3z5bfZTJVThuJ7I6Q
	2SdefP4ATqq44=
X-Google-Smtp-Source: AGHT+IGD1QDIS4ynyjBaIAAdvUjVM3PwRMzMtqFE9pfIu5HzKqw4/Q93kRj/ILiTts1EGOTBvn+WJA==
X-Received: by 2002:a17:902:ebcd:b0:297:f527:a38f with SMTP id d9443c01a7336-2986a6bf92amr26828965ad.18.1763112324220;
        Fri, 14 Nov 2025 01:25:24 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2346dasm50451525ad.7.2025.11.14.01.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Nov 2025 01:25:23 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	rostedt@goodmis.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH RFC bpf-next 5/7] bpf: introduce bpf_arch_text_poke_type
Date: Fri, 14 Nov 2025 17:24:48 +0800
Message-ID: <20251114092450.172024-6-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251114092450.172024-1-dongml2@chinatelecom.cn>
References: <20251114092450.172024-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce the function bpf_arch_text_poke_type(), which is able to specify
both the current and new opcode. If it is not implemented by the arch,
bpf_arch_text_poke() will be called directly if the current opcode is the
same as the new one. Otherwise, -EOPNOTSUPP will be returned.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/bpf.h |  4 ++++
 kernel/bpf/core.c   | 10 ++++++++++
 2 files changed, 14 insertions(+)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d65a71042aa3..aec7c65539f5 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -3711,6 +3711,10 @@ enum bpf_text_poke_type {
 	BPF_MOD_JUMP,
 };
 
+int bpf_arch_text_poke_type(void *ip, enum bpf_text_poke_type old_t,
+			    enum bpf_text_poke_type new_t, void *addr1,
+			    void *addr2);
+
 int bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 		       void *addr1, void *addr2);
 
diff --git a/kernel/bpf/core.c b/kernel/bpf/core.c
index d595fe512498..608c636e6cf0 100644
--- a/kernel/bpf/core.c
+++ b/kernel/bpf/core.c
@@ -3135,6 +3135,16 @@ int __weak bpf_arch_text_poke(void *ip, enum bpf_text_poke_type t,
 	return -ENOTSUPP;
 }
 
+int __weak bpf_arch_text_poke_type(void *ip, enum bpf_text_poke_type old_t,
+				   enum bpf_text_poke_type new_t, void *old_addr,
+				   void *new_addr)
+{
+	if (old_t == new_t)
+		return bpf_arch_text_poke(ip, old_t, old_addr, new_addr);
+
+	return -EOPNOTSUPP;
+}
+
 void * __weak bpf_arch_text_copy(void *dst, void *src, size_t len)
 {
 	return ERR_PTR(-ENOTSUPP);
-- 
2.51.2



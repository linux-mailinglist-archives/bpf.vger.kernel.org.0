Return-Path: <bpf+bounces-70895-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6216ABD9042
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 13:28:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 870B018A6D76
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 493373101B1;
	Tue, 14 Oct 2025 11:27:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zi+GOJLa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257483101C1
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 11:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441225; cv=none; b=Iq38I12pEhNIBikB5u55xtPyazvuSPGi2CbQ6SFWIFDXCw25uppycC1EDJ6YHXjpgM2mKWQJmBxLsxs6LFIVdnKRbu6Qg39sas6+H1xcZFYth3ZpmSbgnCqwVQjdiKbAoN9X0xymTMj1LJl0hz9yYEdXAkLZNyXjtbX6DbpaIqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441225; c=relaxed/simple;
	bh=T1Nmm/R6LFBiTFjOpeGfSLW0d5l/K2N7bsDjPiEWPmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dq2pTCylsIN2/6ssn69Z0mvwXzW4hIUnmWb+7lRGVUrtSX8oG756nHHTAhaozW1h+qyN2FAp/EY2SZLGjSluSO/W/thxAXKUZcp9/VINhrFOqh/2PhKEUYfsOcce2d3bP+HQYTJkeIwe1B7LX8MfZ6DdiWG1o6sykdmIbp7NMSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zi+GOJLa; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-781997d195aso3710649b3a.3
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 04:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441223; x=1761046023; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Q3iRfExEJqSXZ9Zc1Icg4TjF6EtAHQb2pCdXlTokh4=;
        b=Zi+GOJLaSWqNICUjGYoVC6y93s4bW9axrH/dehEFEQGplsW2aYB30xT8OWdZlqTDbc
         64ZoCrnWHzrl7bhLdPPfC4PG7DkCIJQnXy2aQFR02K2ZMSj3m6sq9G/5s3iG8Ea1jvxO
         ICqhYT1H8smExYECw1vXUxFfWPuRMVqnDUftDBZuMDA6NlVmtkUQQIdcvLBf4AvvcdKy
         vioJ+4zKYqJtAlZYiXw2/BeE1ANXEO+4blwEpSOkiT8LU2pERusPaXob4ScEgZjH1yKY
         LiMcc0hmEUuv1n2PlZnAqhhcgkDr1vvtGiUSgC0S6Vfzlxz/KEmL0zK2GfHQVh7N3sHi
         xrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441223; x=1761046023;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7Q3iRfExEJqSXZ9Zc1Icg4TjF6EtAHQb2pCdXlTokh4=;
        b=QwRsaVMmlueLBBs+pKsCRE9pLY8Vl9RYaY+9U+NN9IoxcfrmXmq9DWZdOjZWRbKXXv
         XN+7Jwp6PwDrB4BubLSH2lO1+JEDxxdUVTEx1yOcHGsal8Na/SO8RzBJonQ+z5LpbuhY
         xzEhDTXzSXKSYLBIiuq/5NrzA0acoNJP1Sx1MMGJxG5JXdQDQIvg8tBYZhD9rU/sKOdN
         c7tyXU89DuCegq33jIq1mTMJeJzPX/YqR30bU9L+3ybw670p9lNOi+nIPgFl7OpnAPl/
         BXr7WSbEx2yvZaNrH6rF2A4LIcNHQUN+vebpHshG2HZ7KIECBp3fjBrZURzl1oapoaCn
         LELg==
X-Forwarded-Encrypted: i=1; AJvYcCU0tUfj53WgZ8xJInQSvEl442+wBZtEQ2BQki88wU2q7Mu2a6LKl/+h136GWk5wObU3C1Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YwASOGVLiGHfJdJyufosWyZMMg8oB4y8TIz3wJmj/wceuZQXGuv
	bPHWtoD/jPLKXFFJKnq9+UGMc5qN7W82fLHCXOtSYj/BBlqEHiLQCH3E
X-Gm-Gg: ASbGncveRyK6CobMEYqf60FKehWsvIvToEgwDJOP6nVenWxuD462P8ZlijByxdP1VMe
	eHafLl1BTbo9sSlVQVXUXMVZO76EL53XNpggeWRNjPXHglZFSKBt94Pj0NxHwWeTvpGuwVo0CQw
	UEdCTy4NqGATxpiZ/ALU3iakcA7PlECcIC1ePebwd3j2F0tGwOIzdHE9cSB+YylGlV447NJewpQ
	EKwPXFMgOGuWQLzUQYP6HQQjgMqpvAqclyZoWp/9R+V1fkEWwki1h7ldzGM7GGL1EmLa/0EWoZU
	GPO/RSVLlSXXbNmHj4IYEZj3WbO5NT/fjB4qW5JnJf20/6CmVyRGsFG3iM0kFWEUDi5FdzY32tG
	9h125uM/kKE8qpAPRRTVZJzpmtqwyS8JW3saZiZgujw==
X-Google-Smtp-Source: AGHT+IESAHoQT5qoaRUX6Sg1Z4sRZoIKiFEVF1CVFjtoN9V7EZsWdw8UMx2i81q1k2h2feHx/dvUDQ==
X-Received: by 2002:a17:902:e550:b0:268:15f:8358 with SMTP id d9443c01a7336-29027402ca0mr302264415ad.42.1760441223089;
        Tue, 14 Oct 2025 04:27:03 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:27:02 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	jakub@cloudflare.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiang.biao@linux.dev,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH bpf-next 2/4] bpf: introduce bpf_prog_run_pin_on_cpu_rcu()
Date: Tue, 14 Oct 2025 19:26:38 +0800
Message-ID: <20251014112640.261770-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251014112640.261770-1-dongml2@chinatelecom.cn>
References: <20251014112640.261770-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce bpf_prog_run_pin_on_cpu_rcu(), which will be called with
rcu_read_lock. migrate_disable_rcu and migrate_enable_rcu are used to get
better performance when CONFIG_PREEMPT_RCU is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/filter.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index f5c859b8131a..48eb42358543 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -747,6 +747,18 @@ static inline u32 bpf_prog_run_pin_on_cpu(const struct bpf_prog *prog,
 	return ret;
 }
 
+/* The same as bpf_prog_run_pin_on_cpu, except rcu_read_lock should be held */
+static inline u32 bpf_prog_run_pin_on_cpu_rcu(const struct bpf_prog *prog,
+					      const void *ctx)
+{
+	u32 ret;
+
+	migrate_disable_rcu();
+	ret = bpf_prog_run(prog, ctx);
+	migrate_enable_rcu();
+	return ret;
+}
+
 #define BPF_SKB_CB_LEN QDISC_CB_PRIV_LEN
 
 struct bpf_skb_data_end {
-- 
2.51.0



Return-Path: <bpf+bounces-46955-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77D4C9F1A0F
	for <lists+bpf@lfdr.de>; Sat, 14 Dec 2024 00:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E33CB16B2D7
	for <lists+bpf@lfdr.de>; Fri, 13 Dec 2024 23:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C5C1F4E24;
	Fri, 13 Dec 2024 23:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="fGwY7Nxb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f175.google.com (mail-qk1-f175.google.com [209.85.222.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F3781F4288
	for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 23:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734132615; cv=none; b=qAKnlOjZ2FmOaL4FJekU9/dbhzuHivsfTHWFOYNBDrTnqGXuir01bsi1V4bKLFlDrgseNC/pWUxXvFaYtyiI2X+JS/lvjGJREEWfkivZNlv1qgyFhn93OOVCMvuC19zd7WaClsxwbWdHqrVk6X4clv6M+3P0MbPncV5eUrid8qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734132615; c=relaxed/simple;
	bh=/0LCHSqF8KD3uMi26Ke2tYmcboVwQRw3xrgQ0ODt+Ao=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fka19lVh5qXqfMPz4IxEWw3Ob7HAcD/x4fgdyACVWEUGMcd4G7z8dc8vITdV6kioFeCBxcARNw9oNI8X9N/PC5KyHMe5yH+e5PJkPadbgWq2A7+KdUT7bME4qSthU7AjQyTNTfmw3w5RTziJcZPDDAR53/WSQwF4h+VzXMZy2ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=fGwY7Nxb; arc=none smtp.client-ip=209.85.222.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-qk1-f175.google.com with SMTP id af79cd13be357-7b6f1b54dc3so312449485a.1
        for <bpf@vger.kernel.org>; Fri, 13 Dec 2024 15:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1734132612; x=1734737412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C4MtU8Of42Vm+hc01puGWyYYlZFozHrm711A1SI/d2A=;
        b=fGwY7NxbOXEnbx4jxWu9lZYXo1+i/MMi/UGU6GB7OxiiTNY/UosKQfKXAPZsLCnVEZ
         iIy5w9m/C9OkJg8wB83SzZNUVgqtw846+rTpkC+KdOeY3ZGkeTX+JmaZgLQhOzeFpW8T
         jtnbCok440CxGAMbIAHX+JyDfn5d1/nYwaTouJi3L8Rx2sQaGw6cqKC67PjCurzNTqw8
         Rkb/Wui5J3aE8d/RrehjOxj8YEOZyFiwhxvpg/4fNpDUPpSNIK2nIpjGTxwh2K6NqU45
         8NNK5w4q0H8VTYAE2z5RxreVYseObPgqThnKGMohiVJtOudtUvWU2pjydBfmPt6ZHvKw
         EIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734132612; x=1734737412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C4MtU8Of42Vm+hc01puGWyYYlZFozHrm711A1SI/d2A=;
        b=OE+ws49gIUvvo8Nzk8HCxEoAfCQVZMICbtkYN8ehsndSjCF8vu41WjEtPSYFYMBjlB
         3L6g+0K3LzsAIv5MT7mC8+naqsHXeJUYkYpuddZ7g6coIUDwtlUy01/GvrXSpXfBmWo+
         vbHrqqpUm1OmCBzWxHsmsVgJpOIJcwCUb6MS7sZDD5iHwCaFlPePAfAc+Lm/70EaGOIc
         Aqhy2jhqk5KmT621+8NJK6MUGoi6sUoEVMMcXH7/QsR8mnSWibcBhNJOWmpAu+T2SW1F
         iliGz1LTWNLNuL9MM1HmjTK2UkLVVJgWFv7yR7Ivh/UDSFvkC9jk8hDWVBPtMjaVnD18
         WO7Q==
X-Gm-Message-State: AOJu0Yw/PkCxd1B0PcJsZY4h2gL0HVtQ8iJYOJjoysm2JWNku/vfajww
	tbRz9EEfGFj2hynBQRNGrulhjYkkq6lQbo5nax1nUcv4IZYXqs9k47v9ghS1AcM=
X-Gm-Gg: ASbGnctpXpQ/FKbODUqRBjmQYw7AVGrW19YATc+fDDX/K5Obrkx6uDsnsahUL94RW9j
	TX5V1J4W4+gApuLMoe+/zXxKSCW7FFzQZJO0YYJvwik8JQJaF0MByI7XcKX+nynCYfyw8vtV3V/
	35QMBdJq9n/MqzVsRBKbwmPrZpUCgZcAwS+tOKozeW1m8tbUiUuLsl/Z/OZfBI7fmVntLBqRvyS
	giZ9Neu470F5zxkTWap2Kdzo2gnGthWU4jBflyhezzBHDtdcaLff7+GXvrUDBoevCevoVYGqmHH
X-Google-Smtp-Source: AGHT+IGhk3WCBCy2FnCcgGdTSmylboXkEW41jLfVsnBq+KCm46Gw7HQPdPsfaiQEvFTTaC21Z5+zCA==
X-Received: by 2002:a05:620a:45aa:b0:7b6:ecaa:9633 with SMTP id af79cd13be357-7b6fbecc538mr761652485a.7.1734132612728;
        Fri, 13 Dec 2024 15:30:12 -0800 (PST)
Received: from n36-183-057.byted.org ([130.44.215.64])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7b7047d4a20sm25805085a.39.2024.12.13.15.30.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 15:30:11 -0800 (PST)
From: Amery Hung <amery.hung@bytedance.com>
To: netdev@vger.kernel.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	alexei.starovoitov@gmail.com,
	martin.lau@kernel.org,
	sinquersw@gmail.com,
	toke@redhat.com,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	stfomichev@gmail.com,
	ekarani.silvestre@ccc.ufcg.edu.br,
	yangpeihao@sjtu.edu.cn,
	xiyou.wangcong@gmail.com,
	yepeilin.cs@gmail.com,
	ameryhung@gmail.com
Subject: [PATCH bpf-next v1 10/13] bpf: net_sched: Allow writing to more Qdisc members
Date: Fri, 13 Dec 2024 23:29:55 +0000
Message-Id: <20241213232958.2388301-11-amery.hung@bytedance.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20241213232958.2388301-1-amery.hung@bytedance.com>
References: <20241213232958.2388301-1-amery.hung@bytedance.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow bpf qdisc to write to Qdisc->limit and Qdisc->q.qlen.

Signed-off-by: Amery Hung <amery.hung@bytedance.com>
---
 net/sched/bpf_qdisc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 3901f855effc..1caa9f696d2d 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -89,6 +89,12 @@ static int bpf_qdisc_qdisc_access(struct bpf_verifier_log *log,
 	size_t end;
 
 	switch (off) {
+	case offsetof(struct Qdisc, limit):
+		end = offsetofend(struct Qdisc, limit);
+		break;
+	case offsetof(struct Qdisc, q) + offsetof(struct qdisc_skb_head, qlen):
+		end = offsetof(struct Qdisc, q) + offsetofend(struct qdisc_skb_head, qlen);
+		break;
 	case offsetof(struct Qdisc, qstats) ... offsetofend(struct Qdisc, qstats) - 1:
 		end = offsetofend(struct Qdisc, qstats);
 		break;
-- 
2.20.1



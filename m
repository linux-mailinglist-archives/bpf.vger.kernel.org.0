Return-Path: <bpf+bounces-70897-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E317DBD905A
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 13:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B5983AE7DD
	for <lists+bpf@lfdr.de>; Tue, 14 Oct 2025 11:28:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069343112B8;
	Tue, 14 Oct 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZm/6l8e"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f194.google.com (mail-pg1-f194.google.com [209.85.215.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24BE330C62D
	for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 11:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760441237; cv=none; b=LUPfarFaP2FC12E+SicP1mdUDUJq9UCNsOfyUNuw20mB8w5q3Yat/OheSQV5EDvWuZoriuJ9jilwjQigazykKHKWyHKJm02Oe6iaWibKU4YXc6cFP/bhgIMsL68JPxXk3JoSaN1MVbd5hkPJhQ0HJr00DKcsuVXQW0gy7oWR6hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760441237; c=relaxed/simple;
	bh=Rx/YhkNxvLHTn1Rxzb2qa4X0/4hclpnv8IPkM9Xg0Oc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XngAyPjnBOke2PM/L2cfmjuD9EWD1nkJj/YIYUfwYSifM9nB9gkaUyu3qEjnmstjyfUPIMHMfxqHOjuIowTilV89Cs8dvRMWIHc6oSusQHEdRM+qZLxokw8yRf+73ZXtY8fAxl9ddmY7UaKRE1wc+ORIqGOQ+8uXRjyoxmBjjw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZm/6l8e; arc=none smtp.client-ip=209.85.215.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f194.google.com with SMTP id 41be03b00d2f7-b555ab7fabaso4776752a12.0
        for <bpf@vger.kernel.org>; Tue, 14 Oct 2025 04:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760441235; x=1761046035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iE4VzJhkO405E1xXiO2HovH6fVbTOd8AlZfv3OpV7tQ=;
        b=fZm/6l8etXCz+IX9EaYFXrINr+/EC5xO/KA/D/goPOt31MUJzDyet/ZxEgiA2sXwqP
         eo9ah2BfbtNGmFHVYg6leGsD6dSKaazLJBV8X5eJ8dZe6pJO8R+b9KzERmuoszWzy7xq
         EWKsaO9BpT57wDBvCdvLbDyqbaCk3dClrxpI/cuqgoIbEj8Z0Ame/e0gD1oBB/g1/rXA
         AGTSaU3PHg/qhnP93TsNC0VyiNpcmZKig5aOxq/I77v3nPd47l6Ec69LwUnTdATpGx1h
         URjqRZnr7Xh1ZPF+sUgVbVsvnhgUon5CCsQYhMKZGoylwSUVSOPJMa45YV1uV+9MHn0n
         Oq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760441235; x=1761046035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iE4VzJhkO405E1xXiO2HovH6fVbTOd8AlZfv3OpV7tQ=;
        b=GQavlD0er5vzZutBpfR5CfTmjGCf1p4JNJBwsGQKyZ3fiko79828/yqa+HeOfFKIDv
         qCsOfZ8boJ/PgrR2pa+mU6jV85XUzg7q4V2c8HdU2oSkRejdxPKOd+8acP2j+YaeR0RP
         gxYO1BKnRAi6biQM359QirvIammsRqIRt7I3fUSk1zGEf927wIA146no1/Qjy5qJYSTo
         qnpO5yROJ31W9sxwqL3ib/CoJDLFceosZX4RnHSclZ1MQGLjbRVAzYbeaqb0+VSvIgsQ
         qIS1jeXN3cAU+Qm1wKfkybotJEzryuI6mBv+Sq/nI15FbQrZpXUCU7on/F1Cp9cCzIDL
         r1eQ==
X-Forwarded-Encrypted: i=1; AJvYcCWotBz+3bXz/SVNPUSymp7AvST8tyTzXjbTUtJFk9kVKwPqH3tlFRNgVCRdLSFUylOcogk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyx0S1NfjQpYX+iWShNDTkVFKmx0XvLGxwQTnviqr3XuBqBUnNV
	LEdqCDsoraoLNYZypmGU3uedI9o3qApPcxFLJunGzf2pimQYkOfs1ud4
X-Gm-Gg: ASbGncswb+KP/PYzHaoeRgxaY6zUmiBjGGcTaaZwu2lGZLgneHemcN/heav5YzDJ/Bt
	9D5ry7My8/LSfgoUYRur9OzrhCF7SzilCwz3ls6ZTLuYAHYq9TtKnrlTDbplry5HtSrzBp9WD+2
	dMPPFc251/TZ2iZpI530lkhQ29mhIpUrUZaC7vRjVNouACC/ZG/CxHjkks4PmyY1VcoOBUlleg6
	a5DnlRHVEJuQLKGh+NNaQ/Ar7NSFhVLcbxO6kvORW863p/+tjhYp9OjNaoXZGa1i07bNhUb5Tvr
	VsGrd7E/HSBAQjN0pPbhgJHNQ2fQhMHIX1hgWoR74VvW4HBwju8Fvct8Ro1YhTqSztVaKALQ/Ry
	Khwd/QNHAvfc94SixEmtskhAqZmvHPz/DwpNz8dNGDpVqHh+D
X-Google-Smtp-Source: AGHT+IFYag3HNohwuOOUkgMrRymk2W/3k72l93HvciN+it3ayDICZ/f/o7hlITPi8oCOkannkiormQ==
X-Received: by 2002:a17:903:246:b0:24c:9309:5883 with SMTP id d9443c01a7336-290273ecb35mr316032095ad.28.1760441235366;
        Tue, 14 Oct 2025 04:27:15 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034e2062fsm161807285ad.48.2025.10.14.04.27.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Oct 2025 04:27:15 -0700 (PDT)
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
Subject: [PATCH bpf-next 4/4] bpf: use bpf_prog_run_pin_on_cpu_rcu() in bpf_prog_run_clear_cb
Date: Tue, 14 Oct 2025 19:26:40 +0800
Message-ID: <20251014112640.261770-5-dongml2@chinatelecom.cn>
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

All the calling of bpf_prog_run_clear_cb() is protected with
rcu_read_lock, so we can replace bpf_prog_run_pin_on_cpu() with
bpf_prog_run_pin_on_cpu_rcu() for it.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 include/linux/filter.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/filter.h b/include/linux/filter.h
index 48eb42358543..5ec5b16538f4 100644
--- a/include/linux/filter.h
+++ b/include/linux/filter.h
@@ -995,7 +995,7 @@ static inline u32 bpf_prog_run_clear_cb(const struct bpf_prog *prog,
 	if (unlikely(prog->cb_access))
 		memset(cb_data, 0, BPF_SKB_CB_LEN);
 
-	res = bpf_prog_run_pin_on_cpu(prog, skb);
+	res = bpf_prog_run_pin_on_cpu_rcu(prog, skb);
 	return res;
 }
 
-- 
2.51.0



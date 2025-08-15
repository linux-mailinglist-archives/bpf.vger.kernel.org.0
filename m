Return-Path: <bpf+bounces-65716-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E3BB278F8
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 08:19:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAF3188BE06
	for <lists+bpf@lfdr.de>; Fri, 15 Aug 2025 06:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2B3C2BE023;
	Fri, 15 Aug 2025 06:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gvWFhFoY"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8862153CE;
	Fri, 15 Aug 2025 06:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755238725; cv=none; b=TaYjsu0IV1eo+vzfswxR4o6h1iUfObwDMczBHTE9tFEMoflVOE0wu9dPobwFlSne6L0lGRnLANZiuvC4NTpKOlP+KVLGUJcJJlL19BX/HktLZXbvyNXjtG9ETGN6vmnA8xktUdgOvl5eoIYfKPkdzTweMZNpC6cOf6MSVtHrixk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755238725; c=relaxed/simple;
	bh=lR5h6MbApSZ5sM+smUV5Z0UymMEQuA/jTBLHSP9jWSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hv19HfsFuX6kHKNEe+582kDb7wylSq+lNPCoJlYLHVauOPQ8FjnxBvG8toWCGsvocETD3nGqf2nD3V+1euqgWP5yQ2mE8vFBFmolg/EcJp99yulK+PCo9WU+pkbtuxozVlQEEGrb1Ng+zUKs4gUIJ9Js/G8fvcEH/pJOaEt/r7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gvWFhFoY; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76e39ec6f52so1232396b3a.1;
        Thu, 14 Aug 2025 23:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755238722; x=1755843522; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ojMIruf+CfSEtOOKLXCYppMGwHdqsotd/cjThFA4M8A=;
        b=gvWFhFoYY2/ha+TDghbVq2/KGcZjj77Kx31EHlkoyRPEzABXuPOxG7GnRZBQBnkfcq
         1AFmdkGJqMV4Orr2M5gRmm/G5S7EY3OarV2N4yawkqykQMXRDoldSqBA7StX/syITpRq
         v8lZH3WHOjfv9qCpZElkK3a7MAqrME/ROARZigDLW8P2mCRx/GdxWVmbB9kR+waQ16OD
         nyBv0+TxSMRx9HEz1KvOK9GPwlhOM3OogNYxVntVmUK9hhW4hlGNtHBGThHlRIO+TYEp
         ola/GPF4GXEjAbua0nNDpdPdhmsGxpQqWWn9aBn+L1T0TSX8fDobO1q8/BbGBx/DtiIE
         KKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755238722; x=1755843522;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ojMIruf+CfSEtOOKLXCYppMGwHdqsotd/cjThFA4M8A=;
        b=svRgMbd0MeEa8QgNaB2RKGjaCaf13BLSHmO53y82cUJYhbgmmVswog02FnHwSv3KHI
         106ZIGKkg/B/BfbRxcgQTX92vp7K8GqxXOgirC87FjrpeVyTRQhpNtYA+24feMuoD7cT
         Cif8DUTh2hMPdBwGoaxFuSzIxoE/ED7s/cvaJ+xVxkf8QNZIu8HX90RkLQ3lCrukhVLC
         cJACRYNwPJoQlGO7+AojPurqcqVtYZ/GP57elIUrBqwxEomL4/8RvGA+3N67bflQf7OZ
         W+ERnERZGpXNupYmqT5vUF9pe57jxbc0ILnOxh1xk187QYNCQ+5Uk7eb1DIAjXh7GXeI
         4aHQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrFp4GQMup/i260jU5VGKH9+u/I0I/DofVdvCkxbJrgMBG9o2BZaJXc3HTzVYIULiqZSo=@vger.kernel.org, AJvYcCXWhNDB2wcfNQJT6gIwBncg2t9LBNaEpzFv3A3vk0Kt4cj8lAZc4uNO9qPdG9KLvv1rkBs5w+lci8CI/Of0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw92EtocvJ9T6e24nUykFAujVlhllMwmXU9qh7GG6ZGtyZVHjNq
	4eibZ8yL+4FH6iLdWSVypaRfNqJqb2yASTGpeJOY5dl0fS/EW2PHUTcIy700DormngE=
X-Gm-Gg: ASbGncsX7LTPlNXKsEqG3oo53gsJTN2r3yYzVrs6k3uRgKYUHeQAOuLK+ZsDkAyw/ag
	clT6o7GmMjgCKJ6r+pKBaJAg9mY0A37F4wVEuYE6XGK5mbneqZ+yJXoJgikSrOldMSFfDwvo8Bl
	/t0oEekYpPXNsOeTyZadmune+jYnP3YJzLoYRHgGQb0GFGw3qqL0UkPnyG4FUlxL5s4W8o4uT2R
	AxDT3fFh5uoqpFxgN2A46VPxdLJmtWAlaACMPpA4ivFU9PzMD2iXEL+sw5h/BSRS562uMaAXbIh
	PW++Faier+2DVHFe1NV6tNZYS3wsYIQFV+uwF5jgGZjjVoK2SlgIIfRXfrHLWPcZq/28Lo0VzPt
	4LTE2SkfrVFbEkhgymd4=
X-Google-Smtp-Source: AGHT+IGnGoG3feiYTpDg1rm0V+UULmIqyjLhO11TZdSGX9k33joBlyQrh5QuyGGd7rVPLCi3xRo+Aw==
X-Received: by 2002:a05:6a00:815:b0:76b:d8f7:d30b with SMTP id d2e1a72fcca58-76e446ef45amr1185825b3a.10.1755238721879;
        Thu, 14 Aug 2025 23:18:41 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e4558ae7bsm408607b3a.95.2025.08.14.23.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 23:18:41 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org
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
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 2/7] bpf: use rcu_migrate_* for bpf_cgrp_storage_free()
Date: Fri, 15 Aug 2025 14:18:19 +0800
Message-ID: <20250815061824.765906-3-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250815061824.765906-1-dongml2@chinatelecom.cn>
References: <20250815061824.765906-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the migrate_disable/migrate_enable with
rcu_migrate_disable/rcu_migrate_enable in bpf_cgrp_storage_free to obtain
better performance when PREEMPT_RCU is not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/bpf/bpf_cgrp_storage.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/bpf/bpf_cgrp_storage.c b/kernel/bpf/bpf_cgrp_storage.c
index 148da8f7ff36..9bbe74cdf918 100644
--- a/kernel/bpf/bpf_cgrp_storage.c
+++ b/kernel/bpf/bpf_cgrp_storage.c
@@ -45,7 +45,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 {
 	struct bpf_local_storage *local_storage;
 
-	migrate_disable();
+	rcu_migrate_disable();
 	rcu_read_lock();
 	local_storage = rcu_dereference(cgroup->bpf_cgrp_storage);
 	if (!local_storage)
@@ -56,7 +56,7 @@ void bpf_cgrp_storage_free(struct cgroup *cgroup)
 	bpf_cgrp_storage_unlock();
 out:
 	rcu_read_unlock();
-	migrate_enable();
+	rcu_migrate_enable();
 }
 
 static struct bpf_local_storage_data *
-- 
2.50.1



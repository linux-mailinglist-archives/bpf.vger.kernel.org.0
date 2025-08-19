Return-Path: <bpf+bounces-65984-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BECB2BD8A
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 700A4171A8B
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB4913203AD;
	Tue, 19 Aug 2025 09:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PQfBnwJc"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f193.google.com (mail-pf1-f193.google.com [209.85.210.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FCD311965;
	Tue, 19 Aug 2025 09:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596115; cv=none; b=EirWQVuQl1oRKAdpUFq/cmVn1HA90DCE4um5/PxUMW8AqbRdTOxj+nvP2Y9xLjY41EP5lWH1DzmtzxMQb2cAbpJjhNua+D6ThXBPEItGke0KmseNhwm/Muz7CvEWU43R/OyF/4HEsqVePUfOf6alBq7eomLDMwB+qhQDsAz/tNg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596115; c=relaxed/simple;
	bh=fhjRoedQgU3UpqJ/vxJWw+P3CekwicN1Qc+dzHfUufo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cZpYQuFxuD6UyKx6Mz0GN9euf1whS/C+GUCk/besMq51bc9H+mi0w8dRsR8FTX+KtvOxh1M3TmzVgWgfK7C+qvcNkkKDTX2RUUXAWrEvDvd/29DVrYaNT9Bo8oqnuJbOnGjhwLoogm45EeoN4Rb/IV1Qjpp20tPEZh+tbi3XZ/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PQfBnwJc; arc=none smtp.client-ip=209.85.210.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f193.google.com with SMTP id d2e1a72fcca58-76e2e613e90so3667023b3a.0;
        Tue, 19 Aug 2025 02:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596113; x=1756200913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5H/4foa1XV+6AOUTU8S+hYtTzGYqXPj/gnpmsQWpYc=;
        b=PQfBnwJczbZWjoLhpFk83aCVMDLZBglDATymkmJ26CpH9En9BWu0QtFuS8tF71LSBw
         9GYLRWJ1LP9FWVF0px71s1CstPR6guIT8+NRym934zGvYVyAx8jkp2vzV1BEXuMES3y5
         UQ9v6vnJGyKV32STtp0Dr8CSxhwv+WrSs8Rez2b1/R8li3gc2Ew5yDEXbnHaIQVoKVPi
         1rpxmhtUZLz7PYgKqjP46epGX0xrecZw9T2p0KFJRY8jTMqwG6ODU8+vfuHL70n5YHLx
         1ZQcH2300J4pnRrYQe2IXh/h27Ueyki1jYXlHkfZP6HNkSj1XslIZ4u7VH2xA3WhOJ6I
         EToA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596113; x=1756200913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5H/4foa1XV+6AOUTU8S+hYtTzGYqXPj/gnpmsQWpYc=;
        b=H1Uj2WlIDKD6W0sj5d/fVE55i4ONV/sClLgJ+hgV5bsVsB+ToqJ6LR4GSdNjv2wH1V
         AOafYWXM6RXmJobQIAnKkdu1gBdKWVoxY3YclZXXxzf8Kaqs8jrQa4O5nxBmtfXPoyKn
         bvSUX0JpWWXhsMB7gXJSM2dhg7C68+qehNgxz3bInwYgAD52mgh4TSHtXmSN9GmbJ4n4
         8JKzSuhhxEFD9e+VKsi3ZDyABiTw3xEMr3bq5sEEaV8b/Q43LuuWYqzv7iFTkrzSwPot
         eqtjhpbSWQIWPq3+wvJOyR34SrwYRpxlBLQJbrazMLFYt0xCv+HG/hlMvFFxntCRVqEF
         cM5w==
X-Forwarded-Encrypted: i=1; AJvYcCUvDPkstDP2tWv1ia74vqa2Xr8VcQk/0POf/yw1CvB357/jXvn/msG0+/r3Ikz4yDuJp9+P@vger.kernel.org, AJvYcCVN/04G/jZ9nPf4332gb0ADnbzxR/rzKtLbxsFe+j+upZsO5F/fvq1cc70UPqqXH5nnJtJS7LXAwRTBQUsq@vger.kernel.org, AJvYcCW7dS/GWg0I3iwG9g0jbRvSLV/tnJTR3e5llQ9kGWtahQwXTZQPtsJn2WUIo0wGlBlDzqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxiszStWswIjF9ljGyZr0SXxhxPGO9Z8Iv8edRgK3EvmKN5S17u
	A/S99tCITTpgHCIyx8ok2WQH92NKa7og1YcWbTNe7azCzjrN6vk8oLUf
X-Gm-Gg: ASbGnct2dIgH2GE11ItGUvYszqEgg1Khzn7cNzcMP9IEbjQhMZKPI5peMQA1Ebursbv
	9LU4uaZiAfC0O75lBDQpgPr7/Xve7v8L5NUQqYtmfkmpPaOo63UG+mPeuhg32x4cryU8d78k4JV
	bmygdYRTXZ2VyzKwThxGiSVXtH1QONV76CJpQSd1C3jqz0VcekxSj+T1DxNfv79g/3yH5VzUy73
	mVXzsAZsUq4JhjWieP1m9dYZy5ZvNMmPKikYj2JNhEMbC/eyDoCS4kXQmOelX31FVne3LhAH3kV
	YRD8iFU4X4bmc/bVVfAH27eiqCyNuNIASTd9v5AIdTDHOks/bwtj51IeavAn9XKDm0zPwJz8G7R
	CtA/QW9+RT4P2VCv/sFg=
X-Google-Smtp-Source: AGHT+IFcH7bSLcl4HGDbOr/umRDtxmIwhRc2AfH/G+OzMma/+aubmcK+Df1k4i0oK/PDDhk+wqoT6g==
X-Received: by 2002:a05:6a00:21c4:b0:76b:ee57:986c with SMTP id d2e1a72fcca58-76e80f0511amr2192612b3a.14.1755596113278;
        Tue, 19 Aug 2025 02:35:13 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1314a4sm1990945b3a.41.2025.08.19.02.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:35:12 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	daniel@iogearbox.net,
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
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 6/7] bpf: use rcu_read_lock_dont_migrate() for bpf_prog_run_array_cg()
Date: Tue, 19 Aug 2025 17:34:23 +0800
Message-ID: <20250819093424.1011645-7-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
References: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate() in
bpf_prog_run_array_cg to obtain better performance when PREEMPT_RCU is
not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 kernel/bpf/cgroup.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/cgroup.c b/kernel/bpf/cgroup.c
index 180b630279b9..9912c7b9a266 100644
--- a/kernel/bpf/cgroup.c
+++ b/kernel/bpf/cgroup.c
@@ -71,8 +71,7 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 	u32 func_ret;
 
 	run_ctx.retval = retval;
-	migrate_disable();
-	rcu_read_lock();
+	rcu_read_lock_dont_migrate();
 	array = rcu_dereference(cgrp->effective[atype]);
 	item = &array->items[0];
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
@@ -88,8 +87,7 @@ bpf_prog_run_array_cg(const struct cgroup_bpf *cgrp,
 		item++;
 	}
 	bpf_reset_run_ctx(old_run_ctx);
-	rcu_read_unlock();
-	migrate_enable();
+	rcu_read_unlock_migrate();
 	return run_ctx.retval;
 }
 
-- 
2.50.1



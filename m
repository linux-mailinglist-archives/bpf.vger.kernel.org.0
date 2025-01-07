Return-Path: <bpf+bounces-48101-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4745DA04168
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5817B7A0FA4
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:00:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2088F1F2391;
	Tue,  7 Jan 2025 14:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iEwez+pZ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141B41F2377;
	Tue,  7 Jan 2025 14:00:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258421; cv=none; b=JgnXI15X5cHWR+KdUnznxUsyMIjIEh+MQxQbg02datsSHp91JIxFuatDRgrMwnUafngs6129uMd2kx4SKdY4CtItWU4TRNsUyVdY5vyJipzHfHndZSQMjDF+EkL5Jyy7KpLjhUdu6Oc495QDCmUW7F6tXcFpp0i53JC6m5tLF7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258421; c=relaxed/simple;
	bh=WHhXMqIdalfkSexlY5e1BRqspbIYdrDmDQT3rX3AKP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b8BTRi327sPG1kM4gd5VWNQcP7Rt89jp0seuk2ss6v21MiAFBZht7vTV6/V7BzJ3iIIN5kZ4uvIW025t0SX0wgTFDo/R+kGB2T60r8mirxJepv6j47IMmZ8/PV9Krawl7XSuag2rKv1uaCduuf+tqWnz9UgwTMJVrFZiLnJDTGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iEwez+pZ; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-4361c705434so112614185e9.3;
        Tue, 07 Jan 2025 06:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258415; x=1736863215; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWs3GXRlx91qlbus5IlQPX+xUrucb3RvojJ3Jxtdv6A=;
        b=iEwez+pZnIqFnl+ZrdWs0XCen04DnI+ztRR9rNX5VcJNodSkXsLYPgej85g564piwm
         AA80Kqp47PePVY9bgVCRjEY0FUEcuizt1z/OccEkdrc6XREcdoOd+KfBl5KxR2vJwaM4
         4D54tOctkfKc59akLYkA+3P/eNC6Ul1dajBxTlJ/O5CjWv8KuSpHd17vYaxJqHi0ZfJx
         9uqx0ySuKOWUgckfCv25OiwXzhUsGn3cvZRFzYFBUs5I+qpVGFIKMnOy2bjz4lcrpvHn
         IK0vLfW/gnl0I62gl3C/MQZ2lHM2Ak4vQRVArukXu+0o4CIt9DpbCci7sZXhlmdRXni9
         7Gow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258415; x=1736863215;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWs3GXRlx91qlbus5IlQPX+xUrucb3RvojJ3Jxtdv6A=;
        b=a3KihMNmSb7PbFKeH1s5XBbXrvjIi7BsRlRu6iMykXNvhbjjVSs+/B1iUa2nWkVO44
         IM+SAm/bDMkutZ0tB4bdJPmVywgy1XoYs3igsqi+O194qpZ9cQ5wziIsjkA7nSnwRdj4
         sYJy3sI/kAfHoM8RTTUrEspoQJqLHOemg3HI/2o2o7sQQpdSmHM46ZTor4K3FFbTYzj8
         hPUGP4b3DnnyOIOIuisq5/QqnVoRIchs9A5pvY0jIGeQ4yBz9e50YcCXMyhwPvnFxnpO
         GGwx7uxW/6aVavs68MkRmZoXoIQZNy+LKqmE4swel2BUq9H7yNlZcGaGWiAUkJqL7BdE
         XcMg==
X-Forwarded-Encrypted: i=1; AJvYcCXIItR+T5kdHEkjUYuJN+Heu6TyaK5q7FVBR789nHNCN+kq7rIKprhH0wF8HQ+0CpO5mT1i5OOoJWrkfLA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yze9ATOkFV7Aqy4Oe7yaYe5xhhtt+jgHElDmt59C/R91RExSPmb
	qSlEXZ35O8eWcJ3S37AU90LLTDWwW0oORByf00O/5saWyOJQT4PhYwmOvrAdNfY96w==
X-Gm-Gg: ASbGncvRJoYa6B7HZrzPSPHGHSGuDYSA+banJlEjQxO9ZO45VxyXjqmAyWQBCwAqb6E
	evr74vquUgev2i8Mlovl77LpJEUyuVHnLRL9ehnB9VtuGiNbIrmlQFExn//LYw9yyijqPKM9/1I
	CgftehaEpNU+gJNPpDvSuLTNAkgvfQdnUJZFh7de5dfFNelbHt3h22XNujtc2+P9WElpymMvQE5
	oeekLOLuU4Ua4DUQtRWGViDjWTkN/X4bTihPjwSEDEJ8DQ=
X-Google-Smtp-Source: AGHT+IGl/quTfZ0QDDqXHqWjJoRsh8OWOhApvIvQS4MVfErU6O2RjHxPDcRXKkJfVFPrubLNmn/2ZA==
X-Received: by 2002:a05:600c:3b23:b0:434:9499:9e87 with SMTP id 5b1f17b1804b1-43668b5e194mr461369945e9.25.1736258415048;
        Tue, 07 Jan 2025 06:00:15 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:19::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43661200abesm596214235e9.18.2025.01.07.06.00.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:14 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Waiman Long <llong@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Josh Don <joshdon@google.com>,
	Dohyun Kim <dohyunkim@google.com>,
	kernel-team@meta.com
Subject: [PATCH bpf-next v1 03/22] locking: Allow obtaining result of arch_mcs_spin_lock_contended
Date: Tue,  7 Jan 2025 05:59:45 -0800
Message-ID: <20250107140004.2732830-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; h=from:subject; bh=WHhXMqIdalfkSexlY5e1BRqspbIYdrDmDQT3rX3AKP8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCcvzlsIk8Mh+hFnelZKKgCgtqU9iOBLKbPXk+b Hr7ixKqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnAAKCRBM4MiGSL8RyolEEA Cy9kJaG9NGyOsMOD1p4wmSnWMoa/VZ40oGbhBytzdYgJCRB2HL5vkDh8XXGQM15xQhcjHIre3XKFge MYxgtOeyRBxjlJ7I59jN0Abntd4t4JHzVb29xfXYU8mJ6ffYkcpeGfmF2m96iKFc0GF0IX1l3Zl+tj i9ByrgJ29NGd07AQC7LjB9Iu8AJUjtqOmWCj24rjwvHHSQHUJCx4Pm51Js3KSBijQHwSVkYKEeiTq6 z7qhjfaKS7scU2xicVnOoWomAW8nJjNaXJ/PjoyHRvzUr0xiw5zzYpElTFBan3s2Q1+NNF4llJ1LdM U+UWp2jrbwUAWFbJJK2dvmzZNuI6Lbp8ZQK2O5B2mRhsfDcdNwO/tje684Wbt1/DiSRKDoKzgZXNuk nKe8bA2w7YxQPsqOW8wrb6JRwt0mHs/71A2OykQrbDKhoGASCICezYQF+b9ri3D+MYXaaV6jJX9g4H EQrhRum92e4C2xxmWJuwFpCUs+WB5Q4rUDuSi6F9aC+MTVqIZiTpH1S7ZV0Co84Ck29cCyaEGwt4ed PWDaRhfOssUVISSpUCuPYn7j5zAmvb1EsJcHR9jMW0oiOxCSqKR8citOaPcAC147N3Enhj+jGRgbFK PrDzH4chobZEuLUX0q+qgdIxncgiEIi6OOrRGEhx/sxRMgjoUDUV63MOwvng==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

To support upcoming changes that require inspecting the return value
once the conditional waiting loop in arch_mcs_spin_lock_contended
terminates, modify the macro to preserve the result of
smp_cond_load_acquire. This enables checking the return value as needed,
which will help disambiguate the MCS node’s locked state in future
patches.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 kernel/locking/mcs_spinlock.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 16160ca8907f..5c92ba199b90 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -24,9 +24,7 @@
  * spinning, and smp_cond_load_acquire() provides that behavior.
  */
 #define arch_mcs_spin_lock_contended(l)					\
-do {									\
-	smp_cond_load_acquire(l, VAL);					\
-} while (0)
+	smp_cond_load_acquire(l, VAL)
 #endif
 
 #ifndef arch_mcs_spin_unlock_contended
-- 
2.43.5



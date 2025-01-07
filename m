Return-Path: <bpf+bounces-48099-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27F8A04161
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 15:00:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 437541886E85
	for <lists+bpf@lfdr.de>; Tue,  7 Jan 2025 14:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCE61F191A;
	Tue,  7 Jan 2025 14:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MRf5+fOq"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC5651F193B;
	Tue,  7 Jan 2025 14:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736258417; cv=none; b=PaNy2PbPTsCErPVXpdupL0F2Esm2nEQ5mgEHH9nVn5g0MtF7JyjUcwjHYdHlprV7gCoh48f3OPe/u5ItVyel/0s31XXJYCaucC8KsVIU720DrrOa2jp60fKcl30n7iZajUIpuDTSIzLKemJ/dxXvKOchngUBU6Mz2SJD69ZERao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736258417; c=relaxed/simple;
	bh=l+FzxzqcQOvCH8c5GurhKDmppajCdKyqii/WUkvzxT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=una7oSC+q8j55hWIbZbT179Ab1j39cZEijihYB5cZwp5SYsqMvqi6cuLNoXltxx6lDB0IyUrBBp1dKtqpqatL0Ovo6fEvF9jvvjyAQE4WRqO2/iaX90yckzhR+LqeYf7TU3nMSrMAYFcUhAWTAlbwcOehfYwGd5Ad/0XjvbZev4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MRf5+fOq; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-436202dd7f6so176459225e9.0;
        Tue, 07 Jan 2025 06:00:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736258412; x=1736863212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y4Fpzu6vEVBo0wCJhRUrT6eOf6iL8Bnn94ks0el4cwM=;
        b=MRf5+fOqWiLalDHMtMkzcAREIaOQRS42kj4G2g61Zda5WXCtsU/Glnt30QndqauyRd
         Y+/Nzg1JV8TcqVvCkJ/2E/mZdw63+fA3oZeLIXnZfX3nunDWtp445okAG2n8kI1xmN+p
         x0YmREAcTB0iaoJvX0KvDGCrVr1aX04GxnaFZF41c5ybEz3DWPHN+99r47dPcDzxXVY4
         A6n+hcfL27Xe7Ew1CiUS3M39S80snkyiS2h5YnYZK0Lfs9OsFcyM/ayM4Wb0BpSfku8h
         h60NJ2k/jVLGqW+ysQGSpVGiYNr6pj1En7eyQ7SM6W0W0jWvKbzjlmwMoOD/idsh9ymW
         pYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736258412; x=1736863212;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y4Fpzu6vEVBo0wCJhRUrT6eOf6iL8Bnn94ks0el4cwM=;
        b=dEbg0j2puqezYGCN73gQr+VcqqxlIINbcA/b2QmemVKjqOxFFwDK+rJocOrwlF9JCG
         +UGXLZNtHg0mm7NEfVOKoXh8FxjNBNNhi7OKsYajUDRJ9HrHbkHUOsMfZespnx7svuCr
         /PD3j7DNO43v6b/evRdYfC5IFfL6k3TUL27hkfIgOg5fo7oywlipLGnK9+qJfLGtEtn5
         FxkLPoKW4oVgyPG/f7bNrSLhZWmajbaOS93g8TJvJj+Joxx68lOVkgePCBHZGqJDpzU1
         Y4BIEXOO69IYG1rTsQM0vzSZTk6s+CbHLQoZCUMYEkTTJZjxg2devpno3QJfLiB1btlA
         mPcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVInmVuCNhtvPUd5Tnz3aqvYugc0jUyy1KybT3zah+V+5G8ztOok1FzHdAJ5ZSEcoB3wKkkenbbnizNLyA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDqnJYkfA8t0y1//UI7B0asWckxHFh79K021CglfQoNJX/knsM
	OOzltxXKZv5TulWPfQXowVcxJHxMgriAeJky8mzZ7Pl9/6CdgBV4Q3BiSP64ZQ18mg==
X-Gm-Gg: ASbGncuMOUhJEV9Y+ZE+SQ8aNHOcQYv5r6IaFzphV2JktOKnFvs550rM4aWVpQsJrE7
	8hnfo8wghwFmVRN0VZddkaUGa8WWAWXHOG++vy1PekkHU8jlFHRMbCsM02VNF6qmNo1a7fhGh+t
	y9/qHpqZcqmcedY3741yWvibgDv7fwDLPQpmrIJuiNnTqXZCfW1WyZJK7sokMeM4RZ8YwhNXz4o
	02jMlIr3lpf2u2eDx69pwgL6EyzGjmwSGISHzYGqfKmTQ==
X-Google-Smtp-Source: AGHT+IFl6ncqFkiiYBSYvdX/kEA3xJTbqA7J10nz8/oecZCW13qQPf/5qfgnHJmzgPA86GcY0NPjMw==
X-Received: by 2002:a05:600c:154a:b0:434:fd15:3adc with SMTP id 5b1f17b1804b1-43668b786bamr470644435e9.25.1736258412294;
        Tue, 07 Jan 2025 06:00:12 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:c::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4366e210cecsm563013435e9.2.2025.01.07.06.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jan 2025 06:00:11 -0800 (PST)
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
Subject: [PATCH bpf-next v1 01/22] locking: Move MCS struct definition to public header
Date: Tue,  7 Jan 2025 05:59:43 -0800
Message-ID: <20250107140004.2732830-2-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250107140004.2732830-1-memxor@gmail.com>
References: <20250107140004.2732830-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1522; h=from:subject; bh=l+FzxzqcQOvCH8c5GurhKDmppajCdKyqii/WUkvzxT8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnfTCcghejvu1V67bqXOIvMlrdiOA5EFuq9ml673Px YVwX7L2JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ30wnAAKCRBM4MiGSL8Ryi9PEA C8KWTI55qkfZK1+25430tCDz4Pfj7fNqIYyW6fCzd7K7eLFMYngqRj9hivT19MlwCEuUAOfbvIBZo8 zkQms5EJOYkBwj7X7gtJp9dxzzySOoiFS3TluYhnN+tuvgPWylkrZGGKPa2bvyT8i66YCpJtT3NQ0B hz2iGjXWtcwS7CopSQK/4yF13za3ECl7fVVGG/fU5H6tTC42LcZIHZ2ZbzjAGW2VolovB+M3jGJCU+ jsGelN+U+3DvNMAEQuPBKAmPuKkDtVa14JtO8KCYwyKeu6eVgHwS6Gl53Bh7BH+IbcUONrvUdYgjjr zAdEpgLZ4HpMmIkvxE3MqSXkB4527JrH+cS7ShKEitUo6AiybfOR3EHecJsKQzg6Sl9KOMZyzxQD9d 6TruhF1KYSj9Kth/QfVaqXilOnPCrk1DGjA6H8LgY1F0PY/rxJMvvDyJdFN+mErsBpKjp2SYDIE8E1 aaof92UGYgtpPfnpHh7etHzjcOIc07fqrDnJPE7Ejn8ihS9WF1lWsVtmzfbL+8iojeMdh5VxIomOvQ KXE7peVffA7paeB1e0hS72aWCgGp5vpDHo4e9zQ0RYW6+x0e7axLCWuROvvsMLWjn9IVTsl7Dtaxex Odifkj4y8CLYLgMfiLKrVR4UI8kxOfMvO7QjyxQfn+iMUjVU8bEsanOEwvAg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Move the definition of the struct mcs_spinlock from the private
mcs_spinlock.h header in kernel/locking to the mcs_spinlock.h
asm-generic header, since we will need to reference it from the
qspinlock.h header in subsequent commits.

Reviewed-by: Barret Rhoden <brho@google.com>
Signed-off-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
---
 include/asm-generic/mcs_spinlock.h | 6 ++++++
 kernel/locking/mcs_spinlock.h      | 6 ------
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/asm-generic/mcs_spinlock.h b/include/asm-generic/mcs_spinlock.h
index 10cd4ffc6ba2..39c94012b88a 100644
--- a/include/asm-generic/mcs_spinlock.h
+++ b/include/asm-generic/mcs_spinlock.h
@@ -1,6 +1,12 @@
 #ifndef __ASM_MCS_SPINLOCK_H
 #define __ASM_MCS_SPINLOCK_H
 
+struct mcs_spinlock {
+	struct mcs_spinlock *next;
+	int locked; /* 1 if lock acquired */
+	int count;  /* nesting count, see qspinlock.c */
+};
+
 /*
  * Architectures can define their own:
  *
diff --git a/kernel/locking/mcs_spinlock.h b/kernel/locking/mcs_spinlock.h
index 85251d8771d9..16160ca8907f 100644
--- a/kernel/locking/mcs_spinlock.h
+++ b/kernel/locking/mcs_spinlock.h
@@ -15,12 +15,6 @@
 
 #include <asm/mcs_spinlock.h>
 
-struct mcs_spinlock {
-	struct mcs_spinlock *next;
-	int locked; /* 1 if lock acquired */
-	int count;  /* nesting count, see qspinlock.c */
-};
-
 #ifndef arch_mcs_spin_lock_contended
 /*
  * Using smp_cond_load_acquire() provides the acquire semantics
-- 
2.43.5



Return-Path: <bpf+bounces-54118-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF91FA63382
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 05:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04D313B2621
	for <lists+bpf@lfdr.de>; Sun, 16 Mar 2025 04:06:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4BD1547E7;
	Sun, 16 Mar 2025 04:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l06BoCnE"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F47F1494C9;
	Sun, 16 Mar 2025 04:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742097950; cv=none; b=TzgzeXLY2wQ3pGdgthDqw8Qu1lrPtXFxrBSpXHNi8OxkHpET176W47vwKrqtWW4Mq1cDafK+q3NWPDptJB/Vcthf742W9guaZWvxVHPpOLxolPe2JpUWTof64mg7rqKyp5lzYs6mdbY69PLyN9pwhB44xaVcilmRM6NSHY3hkYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742097950; c=relaxed/simple;
	bh=bCYnbE+K73lTBoOLttYSRrRShne2EKo6ypzNdER5dO0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lqJkwoHONhD4KGeZandz7CPqKK2urVG1GSLzh4PTY4hT6l6PAufQMZExRwhQv8ffRCI/tmmy3/xsdIyYtaG737HgFf8qp/4foqjeuMcrln9b8w6naMkQt7Tpx21GZ7kfEjo3QmTeZx9V1EOW0gMDMphc1+AM61vevGjlGPVExTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l06BoCnE; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-3912c09be7dso2191583f8f.1;
        Sat, 15 Mar 2025 21:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742097947; x=1742702747; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arAQKO8UQM0dQfXie+8D2prlulJwIsVlpZ53Yt0ULrw=;
        b=l06BoCnE8cG5Y0t/nY1rFVHuMKAOiIz0VMdEjPnELfEvdA9ANbeFe64t2Ho/XGNL4z
         2+aSUp+dMHRTyPf2Ur1Yd8zgMobGY1nbmNEIkSMcgVRfif78YlDnYO7EcxBF0zijDobg
         7NTXmw/ed64z7/5JlV0R+pTuhqettZqRuhqeym7ekdz1v715Ki3wZt0BuFlbDSL7xvPO
         EpU27qdc1xf9c6HRLZAfJCFlkfM/7oQRMLnhDHFWHCoNh34ryPkJ2B0z7i9LUTFTHWso
         eped3kCMePMFuaFHRB1JWq5L1rZ7KzrlIwOcMr7ZjENbgKb/6XdYSrKXRHCxBgequw6K
         xXNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742097947; x=1742702747;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arAQKO8UQM0dQfXie+8D2prlulJwIsVlpZ53Yt0ULrw=;
        b=ULcbBM/liXbdwME7gl4PJ6Xo3UV2/ujdKWLTTbJucpyOsqaGvQcbjqHufA6+tweXBX
         2Az0/fxFaddeSakQkk0TxK27tqXE6Nm3EBSNXNE8M99bvIZazhrrohRP/6xP9rEMC7Rh
         yV4ic+vzFASb3F8uA4gKbQSUUyxv6GavimVGUNyQMdJcn5DKkUnAZVN8On3TefEUcinC
         sEg2+75YFdHPJFAOhD0jS28xE+pIQ8cNChK69Pp5zgbY75pCMJ01kwduhtdAYITqB1N6
         J5Qru125SkVJPAhbfEB94j07oep3JY7jFInNFwIGd8k/m+H4vp7rJcprd+9iUc7TLzsM
         Uo3g==
X-Forwarded-Encrypted: i=1; AJvYcCXXf1O4KPGoRMKlVO6bKwYSn9Fz92eFziTm/xC3znQ1wrMIQd1er3fmGVafZFCgMPs1OjeYivKUNnrtvJc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7b1E8ePUXBU9homgZ36eXQeFppKd5+1i+h5pVxXDwBd5VuWIw
	O8fgYUNqO51Gj42+yK/qsXbF8thS3dUU+TUc044aplvEZkx9w8Snk02ZROravcg=
X-Gm-Gg: ASbGncvGXPZoRhqyAu4T13c9TwI/drM7qy2bPkkBlxYH/4Xp+im/7rR5j3efrTzEoaR
	etJCv5MAyoBkADAIAtkBZns3exUWuaUeZ/1IbMkXprp2l/RJEVyHJpI/wExhWI3j0nz5cgqGdEx
	Y4AocfiRCD04WYMK1I3MMb+C26TgvM9f+Mvn3C88KH/ULk4iX/DzcizcW5HbvQ0OyRiDxgBhUmb
	xZwHzPCT2STziKAAU7KeG/3fVHBIu9udxZPVJ6JQS+/YyxI/0bdI2xWkMC8k7fKX51bcUY08NP7
	BOSP1RM9PxihDbp3IKK/FSZwTgzgsrhvWsI=
X-Google-Smtp-Source: AGHT+IGeJzY3eBGexLcsk1yze9S3oNLCw88EaC+mhaa9vg5SAERJj6XSK27DdfLilXTABNLSoX68Ig==
X-Received: by 2002:a5d:6487:0:b0:391:4999:778b with SMTP id ffacd0b85a97d-3971ded24eamr8650576f8f.28.1742097947068;
        Sat, 15 Mar 2025 21:05:47 -0700 (PDT)
Received: from localhost ([2a03:2880:31ff:48::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-395cb40cdafsm10936707f8f.62.2025.03.15.21.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 21:05:46 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Barret Rhoden <brho@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Will Deacon <will@kernel.org>,
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
	linux-arm-kernel@lists.infradead.org,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v4 03/25] locking: Allow obtaining result of arch_mcs_spin_lock_contended
Date: Sat, 15 Mar 2025 21:05:19 -0700
Message-ID: <20250316040541.108729-4-memxor@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250316040541.108729-1-memxor@gmail.com>
References: <20250316040541.108729-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; h=from:subject; bh=bCYnbE+K73lTBoOLttYSRrRShne2EKo6ypzNdER5dO0=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBn1k3bZVJO+UtaXh2ksd2ygsxMkhcgERBwBjs9FllI XcQQD02JAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ9ZN2wAKCRBM4MiGSL8RyrE+D/ 9mak4NXwqkExtA6v4P4pv81udcNOxwDMXUb35o6/CJjxArzw0HvdY428jcentyE0WrkYShVveSLa8v gbZpOY+R4DxGLAG9A7vhsHWyBPTG4Nm/fz4K6mql1dG8Rn86G+pi7KNm9DUbA8dhS79edorwxQ74w2 ZgfwIKcHyHKk//0Zzo+3TqqGOY647CW2eelFr/fOUbVF3aHHtj3H9SF2Cn5TYkGwX37s0nQT08NeRC 6lC3cRBakQV16GrBRvnzuxwKCr0riv4WOvH+At23JAXrPoKxRRCJyHthJUB5AjLXXVpWjd3vQRZ84e m4j04JXHSKMor4vL6CJNdPbQ45sjOyPq0IX85pP4AbEnoRaoWA17Z6Sc8YfUIE7vO6miyigFrZ/abj THdDEqULYZgI9XRQlWB8yDm/grvuD87SrkKzJWdCqZOqs254FuPsbYcY7KBd395/gAGmRcGdmPdBEn vM+vkNfbds7UMoaPYMZ25ck7vCMuPGGuBlKCj7EkeTPCiIB0tGsLZGXd2YsjABChEPH7pPPLS7CnTm TU+UtlJRzlhncgkJdmlb8xaZyibSXEjKB9b3pd4fVNDotHhyB0wT74fhCqGrDkuRX7vV7yNHq1zr5J hr44cNlreYhdVZJm7c3j0JwwYDA2zXpv5B2N5U9pbKtklVtFtNJa4aT0axtw==
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
2.47.1



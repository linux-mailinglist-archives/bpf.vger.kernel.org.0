Return-Path: <bpf+bounces-50637-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33590A2A661
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 11:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1058F18889B1
	for <lists+bpf@lfdr.de>; Thu,  6 Feb 2025 10:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20C6822ACEE;
	Thu,  6 Feb 2025 10:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ExLgXyzM"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E42092288D3;
	Thu,  6 Feb 2025 10:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738839284; cv=none; b=M5TbOVQcwMHX1BWL7R1kOPKGmIQI5u0MI3uww6eT5hGy18FylNHb14FKlCuAHdDVjKr3QrfCauM9znx+b92FZFLsgrMOnUfaeqLWojLN6XaYTuWtkFdk7B3i6NWEJwXQb0s5ynI4PK+pXH/Wfml+zMctaV//yyGhxmyK+3ssjcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738839284; c=relaxed/simple;
	bh=WHhXMqIdalfkSexlY5e1BRqspbIYdrDmDQT3rX3AKP8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WbhUv8r2jzKsbygWGjzYox31gOJ6rwwPv6r4+iQZtuVBOsLffa7VKe5QLubEQ9GUoDnxQik65wcZUnMliHIhV+o/9r+UQPrsyn0PLKa9iGuJ9OGa0mowDp0o3fsCC8oetLQ234IWScYu/qUA7J/yhL5Wf14aRjDr68khVg3kOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ExLgXyzM; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-43618283dedso7147175e9.3;
        Thu, 06 Feb 2025 02:54:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738839281; x=1739444081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OWs3GXRlx91qlbus5IlQPX+xUrucb3RvojJ3Jxtdv6A=;
        b=ExLgXyzMQ3wJtmyTQ3ChOhzAAOyDLmcgPnS3WhOqqdWSXUCGFGTRo04vhiwW3hQB7V
         Xh+3RkprZZmmuXtC8GYwcS9Srz6h16Mx19lymY0nN9LuAQHqgxqdPh4ECMBmmRmNchYF
         /WB61kCz4eGTDLuJWT1T9yUxY1DWKV+PdPOIvWOHqY8R/sLIb+KJhqJwJ9V6y8dksyQp
         DAFxt0AxZTtekA+Lq6w5u8ue0YNQMIqn5B6l7qRt7niG+hjnimWJgaPzc20B3f+P2RIU
         8AlqZ89NgfGHmGRABK0HYnTvp+KUhxHNMoL3j1HpJ92EyDqGr0iC0sql38HXwGLH+faW
         D2Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738839281; x=1739444081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OWs3GXRlx91qlbus5IlQPX+xUrucb3RvojJ3Jxtdv6A=;
        b=CAi0ayEmAuAzMysbobT3eqcBPAtIWkG+NiRqonbqqhpcYAe847xxs1qk3cx8N9ORKC
         OE5MgDJsgqs6erkQWXqmpSgOShLmQWMz5FKQFFS2Un9naee8uINUMM/IN2c0hHrjIM97
         p3yLYZ9cPEqSZ3HyWr7DCb0rXl9y5X7gqMy4Z4xllHfkOJfzCmsbByHyQa97GljYohSZ
         TxHXV3Xq4nraiQ/nE/Zkyw7LNwB/q0K/zTtDgDu9oG1JyBrrsJkRLePkLC8FlSuDjo/B
         8FcGcqQElKW8TXdKRoaFljyVT7SXruG8G35AIvnhLE53dQTHIykK6k4S9FNrDpJseIYM
         io0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUdmPVf1wTZmETKeGXLccQldUkbJW0cCyGJi8RWl/b5/+jFybcShZlSPGH+yd3ok9RVQmZr7lvU1XmFEFI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwcXQTapmcczyNg34+gQ9CGhTHsMIBxgm/18kxBtnKjR0VB26ZS
	jWw/lZWL17fRuoU0td8/fTsQJHi8k9aJKDcXmy9G9fE9s3glOgS4eBXPzc680hY=
X-Gm-Gg: ASbGncvw3KyZRUEZF+4CHEpVmNMDwy14aWq0FcTrOO6HhGM1RYxeV6mcpsCv3XkrqRw
	RLCIK1wpQdv+nLwyxwlkcGhtiwP0S4ulzgeGKh6znxCaWI3JIqXfLWtss6AA2bTzN2sNDpzyoEs
	KhyXiBpBMufbqDyeS/ZZF4bsddy1q5J3cd0kSCPoTTGLCoJoxe5Kob4OBmAlAWhw8DPQuiLrP+Y
	XwPHSUif9VRVKc0ILfxhlAUg+dfyW39FlUWV01jRueik3WfJ/CUG6cJRI2D0STXRwlca+V0pezG
	MsPpBQ==
X-Google-Smtp-Source: AGHT+IHeU2y2+7O/uQKeXcLLdS77pnq5NJz5kvWtZprZ6uplDLOI4uMkvBsICSMk+DCJ+KCjzZMlhA==
X-Received: by 2002:a05:600c:5114:b0:435:32e:8270 with SMTP id 5b1f17b1804b1-4390d43d8ecmr61035955e9.14.1738839280667;
        Thu, 06 Feb 2025 02:54:40 -0800 (PST)
Received: from localhost ([2a03:2880:31ff:1b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dbde0fd23sm1381770f8f.71.2025.02.06.02.54.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2025 02:54:40 -0800 (PST)
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
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 03/26] locking: Allow obtaining result of arch_mcs_spin_lock_contended
Date: Thu,  6 Feb 2025 02:54:11 -0800
Message-ID: <20250206105435.2159977-4-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250206105435.2159977-1-memxor@gmail.com>
References: <20250206105435.2159977-1-memxor@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1052; h=from:subject; bh=WHhXMqIdalfkSexlY5e1BRqspbIYdrDmDQT3rX3AKP8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnpJRkvzlsIk8Mh+hFnelZKKgCgtqU9iOBLKbPXk+b Hr7ixKqJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ6SUZAAKCRBM4MiGSL8RypWCD/ 9a6wXeJpwHCx6Ry/+60+90gq49Vx2iM0Ni2K5/JZ/w1SQ1K45M6aFIB7872eGf0XNmEL8eeYRcg6ky oIbxfK6Dz0h4c4cjezC6IO7ADwiRf1nt9gfi3HEwqdWIzBMac9NGH1ITZzTSB9FZuAkqXAfpZZq0iW l9L7JT2bKDalL+4TjYIHnpQaWg+MzdyiUwK9daJqckornGM5bI4UFqkTtWU74gzcj9I8Ww9UAJmZll /0oSi0NI558EvQj/JozkqtizlLGWLPs8WdwyXca/O84yRKYAhzPQZ+Ebe9SP1IcoorQstTzGtBQLkN zeZqTP0CpGFfPZy9B3ND9iBY7eJQQxB2h2yT74z85HkKKEjc2v0asUqBT4vT+B5nCPzdr638w7FtGe emuAf5iymDVjVyVtnlOV9UV5465nfpUZv9DqAwksMUOVSc3qvTgbKcDN4XsiSIJPYVu+XDqiFZqx3Y WlVVJyTFe+L+QnTVi8xn2N/fICy+rFILllPSBpOso5O/9KXfpcu9vnaCtViVPakzRGJqLFeOjxAQNd hQxMdvz26zEoWX77OknnGmg7FcT6xSJ9eFK4uTMlDQbiikiPsGIMVPxVutFarPkQs5maZ7giuy1hnE iy/9siJLZmE3DRYLv0bOoj+wxlb6+yk1cnr9VBCzo9XnhvUEn57+U1QY9opw==
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



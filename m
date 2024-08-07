Return-Path: <bpf+bounces-36644-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AC7194B3EC
	for <lists+bpf@lfdr.de>; Thu,  8 Aug 2024 01:58:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB7D31C21072
	for <lists+bpf@lfdr.de>; Wed,  7 Aug 2024 23:58:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE825158D6A;
	Wed,  7 Aug 2024 23:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kUTaH/cN"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6D0C156F46
	for <bpf@vger.kernel.org>; Wed,  7 Aug 2024 23:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723075097; cv=none; b=HfUDVNZ/CIeOoXkjjtdrDHAidHXVLikSLfsU50SgTI/im9ipqVtTXSuYhHyIzcYag3FezC0mwP7U0KO9c1H2cn4AB6SiyqUL7emO5rFabwPibqWMqLQfEsv+DOhdpxZ1DIhoa60qW2lTE3FlUQWpeQDtx/mYPV4/7YifPCoyPQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723075097; c=relaxed/simple;
	bh=VkEyMaYTV4M7Q5zy3FH3sEz35Wgh9L73d6JtaKql0Mg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zng9puNYVz7DChzlqKEeWONNuVTDyJ0DG0Q2mzyzYipYSERHc4teFpSsHHYKoOjIa9Q9o8rvl2+O6whDgzFn77cRy0n8VyRVuKJcTHJ4ndZT8vwI+fqL2duXBud13QjAvLoG5TEu5aXvDC7ujcvQABlFR3IZ3qaYeiOzReLpAbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kUTaH/cN; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-66599ca3470so3857337b3.2
        for <bpf@vger.kernel.org>; Wed, 07 Aug 2024 16:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723075095; x=1723679895; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H7qVad8YPhHo/SQc4ddqy/bJK9f8K0WBE0WOqtypkrs=;
        b=kUTaH/cNrSxFNMxfekb7Z3NX56kwXTBF4jtMrP/PbKGVKNrDipLY5icFb+fvWc0DI+
         EUN/3jgkZY8L88cicUvn3dOeuBzxYhuEzzmxCWZPbZiZ+zRxgKauCSuNPRD/dT7KQw3P
         R5MMuEYekoyxTgU7EbhxIsnri8GP+G1LHFOiebIqYdlLuV+3V4Wy1t884AB0YyDyeLWr
         hx7Tqoj5fhe7TrDvCVoKKlLCvmQL5DmX90t0OaaEec4jk0v/yXGcJbChclVWJMSeU2rU
         UN5J2XE5pTJn7yfKFrkRDz3YIz0I8tMA4GnnTAbCP6KD9jnqVBrS5Pn/2ojmgLuZxenD
         9pFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723075095; x=1723679895;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H7qVad8YPhHo/SQc4ddqy/bJK9f8K0WBE0WOqtypkrs=;
        b=BwHjkgUQhUNn3VT793QL7JOdoqMgjI0tXRBoFF0amwhUXW7Rf5UY9cqrDMmAQRf7An
         WvpW7Q3aZETiivi+U4TnJBLxCHTo/x2jpxFsQJmaUFbFzk/bGfC9E2D4HkAGJ4TfN2mU
         /fvsJ8WAbxLb9ElCz9vSCUhuhYsBp26uyzz4Fd1xTvaK+zaokBFQc6zCLYXwxfYcj9Jk
         cA0a7/gHb/b42wCmK80qOAkCmFtRfQ3H6o6+CeNxq2nZ+Wqc5VehJEnPHo7f6KSkOa4/
         FwyvZOS0C2rOgB9DqwNX6b1vh8RmfZXZKOhI78lTrxxEPj5uAuMbFh212D8+aWGF9LbQ
         w/KA==
X-Gm-Message-State: AOJu0YxjJVAqRQmdgNXgI0DXMQCjCJ3zpNuFWzMBBLaL/d5Yaq571fvs
	rMK33ZoLp1XRrf35nWCdUg66onioZoxnrOXAnw/A6PArd9V0GMQuWvRcT3F3
X-Google-Smtp-Source: AGHT+IHvn7KpJls2+Cv6GKIJ2NU8/RLMwPdL9QjNkYBCWlo0TowGWozDrfgP9opl07bpC3j0cnVLUg==
X-Received: by 2002:a05:690c:4a10:b0:665:b351:25e7 with SMTP id 00721157ae682-69bf77341ddmr1054777b3.14.1723075094875;
        Wed, 07 Aug 2024 16:58:14 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:fb5f:452b:3dfd:192])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-68a0f419358sm21092477b3.26.2024.08.07.16.58.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 16:58:14 -0700 (PDT)
From: Kui-Feng Lee <thinker.li@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [RFC bpf-next 4/5] libbpf: define __kptr_user.
Date: Wed,  7 Aug 2024 16:57:54 -0700
Message-Id: <20240807235755.1435806-5-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240807235755.1435806-1-thinker.li@gmail.com>
References: <20240807235755.1435806-1-thinker.li@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make __kptr_user available to BPF programs to enable them to define user
kptrs.

Signed-off-by: Kui-Feng Lee <thinker.li@gmail.com>
---
 tools/lib/bpf/bpf_helpers.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 305c62817dd3..8f7fb00b90e3 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -185,6 +185,7 @@ enum libbpf_tristate {
 #define __kptr_untrusted __attribute__((btf_type_tag("kptr_untrusted")))
 #define __kptr __attribute__((btf_type_tag("kptr")))
 #define __percpu_kptr __attribute__((btf_type_tag("percpu_kptr")))
+#define __kptr_user __attribute__((btf_type_tag("kptr_user")))
 
 #if defined (__clang__)
 #define bpf_ksym_exists(sym) ({						\
-- 
2.34.1



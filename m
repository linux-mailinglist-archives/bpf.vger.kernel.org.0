Return-Path: <bpf+bounces-21585-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A386684EF83
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 05:06:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F9861F22D93
	for <lists+bpf@lfdr.de>; Fri,  9 Feb 2024 04:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5304525E;
	Fri,  9 Feb 2024 04:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MoxBkRfv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067175221
	for <bpf@vger.kernel.org>; Fri,  9 Feb 2024 04:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707451580; cv=none; b=IgEOT0OiQL3MbIiEt6tsJvpMoWOXYxdIlAspqJ1CfzS2Hz2xe6CTY23JxKsXiXzAb2hHS0v4xbIIEOPsn5vHhV4HeI/F4BgFNLhmwIdcMApuzTnQ9N+nGNnXUjYKW+ky6nTj8Rg8Q5Dlgl6KyXfTfX6nsEdTzbapDD7yStO8Ka4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707451580; c=relaxed/simple;
	bh=FkMFrDSl3Yz+eaNiT7m7A+eMdr4uSrwOyWuovaBExdo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UVr9u1Z6oq53Bu3PDbKppu09OAX79jk0V/rQRCZ5o2VzzCLX+lxlM8OWSMNAlrXYrK/wwtdiBw9DSFcn3mTuQu12g+gfzGI41gqqk+d0Ti6QqjLFctF0VzfIMkhrSFkHbqRpjzskaVaCPjlVryJBzlKJUibGRcZdyMUI7hswdFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MoxBkRfv; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d72f71f222so4490595ad.1
        for <bpf@vger.kernel.org>; Thu, 08 Feb 2024 20:06:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707451577; x=1708056377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HiZXvAtRKK8jkFx0ziwixfKGMxiAC5XovXkV04D0O98=;
        b=MoxBkRfvIpktMBKBJGGxAXIVtSRMRwi07r7QJsnqIfcxoHsjozgzipm+T59ejx2iUA
         aouUUohsAAxa9gsVkgPt6aEn9yIGqL/xeIXtYi5qFW/IQI5M2/eCZeb81txIGIOpIb7R
         vIqmHFu4xF+4oHrrJ6iM0nVf+hW+thNMBdsSDSX9fwoXzZdi1T0MvqgC+iTUDQGgHl95
         Kml2kMyOUlBFnKAJjaXgVWqcRJG5L8a1dh8yE2tUyO+Y/gfbBT4AfOeNj4oj8/WdY8Ga
         lKn7nuu1x8OVvVws0Ha4eiZy+iNlPH8F0myw8c6aqDtYJ++u1NU5B021C+axPtZwQyqq
         LzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707451577; x=1708056377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HiZXvAtRKK8jkFx0ziwixfKGMxiAC5XovXkV04D0O98=;
        b=YWz7fs62ln1SKfimEBiBVQk4Uj/sfZeyH6qHJJFBEq1GfNa4UKMxOW9mLyOdTXYYX/
         IEJykMcMzzrM7wO4Yu2JnMqjZafanPQENqOBe4nL+1+WJ5FVLrjyCSOI/mA2Pavg4hxB
         5I3vVqLZta6NZIT051PqFPWqe2ZeirlUzgZXE+wbY+v4bx6kQA33sYb2GXmfjinNqDwC
         IXQCD4tzcR+PsPmhQW12F8/1FboFxfPIe7PQfXoxrTJjqwIk4GB4BLvcZSmT1mBdmokI
         GZCI9H4Ayxbd7tEahp/eMpKHF1vkOlI7g7hROhzcy81dQ8oVUx+aGFnrkOCstWrqUe+M
         TijA==
X-Gm-Message-State: AOJu0YwiuvU4QD7GnmeP6KaKB813kzBAOwx97xkImvSoytZNrAPsNzHM
	TWIfNMPvUEQSegFiX2nZsJ1r+sVuAFfFQsu/L552Q7hJpTbT49HHs6O2Ga67
X-Google-Smtp-Source: AGHT+IH0qd7DUNWL2d1Urm49Tarwt8Y7vlvkifg1t+rPqEzlKKds4sNBaEDojklBlzOW65EyuN84oQ==
X-Received: by 2002:a17:902:d512:b0:1d9:cc68:19c6 with SMTP id b18-20020a170902d51200b001d9cc6819c6mr505956plg.43.1707451577482;
        Thu, 08 Feb 2024 20:06:17 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0PSDSVSrkv+MnkyI+/hIYocwwt2ruGu8w0QAeQbBnRSNdSiWSEkbUIE0BAXyb5Zg9Ii4TSozKKj1jxxKcrHkZkTO0DaUSIlKkZtOh6JNQ36oXTkCUzMAX4yMunEMiwp3ti9w3FRrGlWp5IUZloJgZyY9JqybOu8LCa4fyoIMPi3oxP7rXgATE/KrV1IYoYtHNxPVCOE9ctb5w8jhL8M+66f6h0UCln/TA1zrEC55iEka/PM0Pl2LQsdp714N5FuoTkqyOpR7eEsHj8Kl1nmymCmhFm2o7SJ3zpjLN6vSGYhbm6ybyG83M8i1dSN/5Sz7UClBMTTVQu6Yl7l4iU8Sx1HbZa4/un5ZV0lD5c226Y0vpra+y0w==
Received: from macbook-pro-49.dhcp.thefacebook.com ([2620:10d:c090:400::4:a894])
        by smtp.gmail.com with ESMTPSA id mf3-20020a170902fc8300b001d9edac54b2sm544084plb.205.2024.02.08.20.06.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Feb 2024 20:06:17 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	memxor@gmail.com,
	eddyz87@gmail.com,
	tj@kernel.org,
	brho@google.com,
	hannes@cmpxchg.org,
	lstoakes@gmail.com,
	akpm@linux-foundation.org,
	urezki@gmail.com,
	hch@infradead.org,
	linux-mm@kvack.org,
	kernel-team@fb.com
Subject: [PATCH v2 bpf-next 01/20] bpf: Allow kfuncs return 'void *'
Date: Thu,  8 Feb 2024 20:05:49 -0800
Message-Id: <20240209040608.98927-2-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
References: <20240209040608.98927-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

Recognize return of 'void *' from kfunc as returning unknown scalar.

Acked-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 kernel/bpf/verifier.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index ddaf09db1175..d9c2dbb3939f 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12353,6 +12353,9 @@ static int check_kfunc_call(struct bpf_verifier_env *env, struct bpf_insn *insn,
 					meta.func_name);
 				return -EFAULT;
 			}
+		} else if (btf_type_is_void(ptr_type)) {
+			/* kfunc returning 'void *' is equivalent to returning scalar */
+			mark_reg_unknown(env, regs, BPF_REG_0);
 		} else if (!__btf_type_is_struct(ptr_type)) {
 			if (!meta.r0_size) {
 				__u32 sz;
-- 
2.34.1



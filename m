Return-Path: <bpf+bounces-75050-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A6738C6CEEA
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 07:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 1DBBF2E01D
	for <lists+bpf@lfdr.de>; Wed, 19 Nov 2025 06:28:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C32431ED77;
	Wed, 19 Nov 2025 06:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GmD43xjd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4152331E10B
	for <bpf@vger.kernel.org>; Wed, 19 Nov 2025 06:26:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763533573; cv=none; b=uYNi/T4mpFQzXL+rFOaww13VW9K/nkQoEHxRwG+carTG13vDwYK4HveTcFYeYR8nqO9Mnffk1oeAWWUOdMC/YNRYehArWHmaBMBbmqM0ijaIAR3gui9OlYhK+xlRGEcC5r4iB+rOI5y/rFAH953c3vgpdRApZ+5Gn6RRXrg93Xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763533573; c=relaxed/simple;
	bh=bOG7MFQkS3iZCbR1WAM2BNfX2hMyDdstzBOkhBe3YpA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N4Sex4GZczcrDZlR/oEIbAnqcQdcaclw9bdeUvhP3qNug+nL5kkOPhoTT3+GHmWcQ9fDy0Y9cj5nsGiJnixTX7mJugeGyYJDXGG+V2fJ+AyYaazKTdyad96xn09/yXiLzQP8ZElWJ5hjv9tnQI9k5dWssz5Z6yFRqhCiWOQYKck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GmD43xjd; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-29586626fbeso67624145ad.0
        for <bpf@vger.kernel.org>; Tue, 18 Nov 2025 22:26:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763533571; x=1764138371; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w3uck5SLJDFUscVdZUo0LHnIxtPzwUVM7ArDFS0hzBY=;
        b=GmD43xjdwe/q5Rqts7NkNlZCL9mQiiTIIdgSv6EJly+6kskPUj3PoALVcf6Edn1bhb
         uurom4RVvW/c1Dl9+VaITde0d19LzzhcjKuqR9nLUO4Jwo4RDUzpIJPXyP+8tEEpQK6r
         Nvr/U7CAnpOe64UBsOND4YhRfS3IA09n+0hl3rtj6dKvceX30Yfum4Hg0DNxqr0r3U5r
         eRoaOF4JgBUEHBnz0ipIyn90GsadKOhLVnKqFTZyjZ5gFo3SyzMg/uN56IzTS2fqOP8E
         sViWElOwDClg96Ip6uYz8sWa+UUheoAkUMTcqqTtZRXKctt4I64O3YyuXgB/3aZTca9e
         umtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763533571; x=1764138371;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w3uck5SLJDFUscVdZUo0LHnIxtPzwUVM7ArDFS0hzBY=;
        b=geXzr3EihV1JGbTIF/xTppYhfCsVVsoxmIuXwRQzkNsbfjkkjKYh5Oi0V0eVXG3FBH
         2MXcDNduAvlsZe2ZsK1sxUa4l34tFAwP4pb8DOp7iAVrtob74yTo3jjKOExXfDSnBcY1
         VIM3D/eOnzQ1WEuceEVWJRuDu5hOwGh8DMwiy34LHxwd/lIKGqGZciyU6LBPUC7152In
         YEIULfS5nb/mItAOYGoN7DHlsRJRclQa/BdFKHvuvctO6MCg101Dudk3aNJ83/ICLdkB
         ecCBEOpZVl3KAWAeVTn8uPXLLLVJBOd7J2P2Z/T0O5lEnG7GGZe+U0oCgATtb5w8LLNG
         BtMw==
X-Forwarded-Encrypted: i=1; AJvYcCVaowud2UHQxYFJo+MzarVWfkdXc6kiYW3QJUQfuBD1sNkvnHty5LuAiPSP7/r9/Wk9fLg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkn6wM3AJLG2TTJuSYh2FDD4shGsmqZJVrkvKsys5I6IVITt5v
	XmZEqqQiU4Ds2geZDFqGYlwYmi+LDibzqTfHj9Yb5wUZ1SyVrtVO9+ik
X-Gm-Gg: ASbGnctKJAqxKjb/vFL3S+r7XIYjo8Z5UcsnmoRbfxHNd1KEDc2CiK1e5bdEWELFjsH
	XikkEkWrHBI2ilZHiih9L0jw1smIIndcZr6wslcKI8aydnFvMjqPQNnyTvktyAARCIzZj2wujXR
	j7JGsY57mNalffrCSGwtoajdVNO70dkMWp0ZVFd3vNcXPzPyu+QsefxzsZ5p5/hM0/AxcDX6w57
	gSyzvgnA6QIo+I9spw8NbdTPfovchXpv333W+R+tnUiBc3vVcXgvBcnmhyMEUzzD1zVukxbh+nV
	dSVtqU+iDKWFHvZUSf7W1PZsj/P0kOJiUDJSS8fm6YIQKObU05pVyW+yW2TANpWbckJgtEZP5c8
	EXPkvmsppmo7Q7VGi4MNib695phqTh2hozI795JdcmCFOyyKeZqD6f1/NKNOtNeENWjCJ6XHtgf
	nQeqA7JxhIYc+XjugZ+Eg9uA5FAmHFIRI+I/wucd3lnG75ii0lET98qatJp4BfCqbBV0SwoM9Ee
	VYclw==
X-Google-Smtp-Source: AGHT+IGTgkIGWP9fMJYS46fqWm9eVKlbop6ssm2ZVW3H9bFUJ8EJrgktDkyGqkKhuRWps5cc6VoELg==
X-Received: by 2002:a17:903:2c04:b0:295:b7a3:30e6 with SMTP id d9443c01a7336-2986a6d55c0mr232723075ad.18.1763533571305;
        Tue, 18 Nov 2025 22:26:11 -0800 (PST)
Received: from prakrititz-UB.. ([119.161.98.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2376f6sm190992735ad.21.2025.11.18.22.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 22:26:10 -0800 (PST)
From: Nirbhay Sharma <nirbhay.lkd@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com,
	linux-kernel-mentees@lists.linuxfoundation.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nirbhay Sharma <nirbhay.lkd@gmail.com>
Subject: [PATCH] bpf: Document cfi_stubs and owner fields in struct bpf_struct_ops
Date: Wed, 19 Nov 2025 11:54:31 +0530
Message-ID: <20251119062430.997648-2-nirbhay.lkd@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing kernel-doc documentation for the cfi_stubs and owner
fields in struct bpf_struct_ops to fix the following warnings:

  Warning: include/linux/bpf.h:1931 struct member 'cfi_stubs' not
  described in 'bpf_struct_ops'
  Warning: include/linux/bpf.h:1931 struct member 'owner' not
  described in 'bpf_struct_ops'

The cfi_stubs field was added in commit 2cd3e3772e41 ("x86/cfi,bpf:
Fix bpf_struct_ops CFI") to provide CFI stub functions for trampolines,
and the owner field is used for module reference counting.

Signed-off-by: Nirbhay Sharma <nirbhay.lkd@gmail.com>
---
 include/linux/bpf.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index d808253f2e94..d39b4b2c8f35 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -1905,10 +1905,16 @@ struct btf_member;
  *	      reason, if this callback is not defined, the check is skipped as
  *	      the struct_ops map will have final verification performed in
  *	      @reg.
- * @type: BTF type.
- * @value_type: Value type.
+ * @cfi_stubs: Pointer to a structure of stub functions for CFI. These stubs
+ *	       provide the correct Control Flow Integrity hashes for the
+ *	       trampolines generated by BPF struct_ops.
+ * @owner: The module that owns this struct_ops. Used for module reference
+ *	   counting to ensure the module providing the struct_ops cannot be
+ *	   unloaded while in use.
  * @name: The name of the struct bpf_struct_ops object.
  * @func_models: Func models
+ * @type: BTF type.
+ * @value_type: Value type.
  * @type_id: BTF type id.
  * @value_id: BTF value id.
  */
-- 
2.48.1



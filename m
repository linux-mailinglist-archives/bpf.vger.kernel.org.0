Return-Path: <bpf+bounces-32302-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF8E90B467
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 17:31:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DA624B27CDC
	for <lists+bpf@lfdr.de>; Mon, 17 Jun 2024 14:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0529A198A3B;
	Mon, 17 Jun 2024 13:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LTcLyhwi"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED561198A39
	for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 13:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632158; cv=none; b=Kk1l6pmH3+251mKZiek52lZ0dP9cASbrXkM3EAXBoNch/cU47kFMf4vwDLnJMrouUwu0VIOYbqOljcPBVFVCkC99TTiduQV2Vzy9Vz8Cy4rl69a4ED/hS+BE5JVU+TFGMa8WuHmwXnzWzsPh8skpAbEZyEKEFZbxs4cBabH7va4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632158; c=relaxed/simple;
	bh=2Xbsy2jOeAb0CinZX/eUoy/y4kedKeR9v73EAzrgh24=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=YmgKecrYk49cdrH8f93m1VH+klpdPkk9pMAPSLTSMUOXW1N4vL54vKMo9tj8qINjrkGfuHHZEnO0f1XQ9LpxfytWGfmc+3MkI0qmWVrq+JNqSoz1cGaTG9qzOqmi9epCHSKNEDM9AgDxANyVMSTOT0B5K6F2yxhaBM/PupYE0Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LTcLyhwi; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a6efae34c83so547006966b.0
        for <bpf@vger.kernel.org>; Mon, 17 Jun 2024 06:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718632155; x=1719236955; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pXxwFWSnZJVrERSZOIlxDM3aKoJ/lC/CtIZMgzef9ZY=;
        b=LTcLyhwiDTVvA/ZohsB/kansz1LS5j7g/O4xY717u+Gw8AJyIvjJ+eAk1wuI41RqDI
         l92UWKQn9tXZ8AGq/kl542vZ1hJUvXL2wF+Ms+yKj2NT7Y00FmlB5hmdtluHfkmtjH/f
         3x7oksVCoDzdS5zhZazEIR8r+QNQqTKExQ8dmExA+PcmNuFRGpFvMVm2W9O0+FEryzkU
         booIsp7j5eVLBvqe0FqRjydSiIw1poxxLzi7q1AtwHjJrriX14bY9tC5OSjd7byVGCDJ
         u+hJbyfwV5FKu/KfnwUf9+j8+FtLadSRVh1WNNNnDqVR7/9uR0XS5yJy+l5EXGlmP9sF
         bPQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718632155; x=1719236955;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pXxwFWSnZJVrERSZOIlxDM3aKoJ/lC/CtIZMgzef9ZY=;
        b=b5HEeU7d3BO7MI+C8WJyXCrfYMiLD/fcTjo3Iz0wVJygJ/5U8SqonTBpuJmJaWCWPz
         WQlOsdbJcKJIj2juQRN2UKiigFgMH23CW85/XmYJqCXt450MSZWvg3TWqukj/MlP3HtP
         IPtTnefLWgvEnC1ODM+TLLMnTzHvur1L7dlSyIqisXbQLYYfCQ8BPgGAQFPCfVjDRJU8
         24Y9JVbUEVDLQqQa2FYbnXq5Yws5FzcHaWYKdB2+Vk2rcTR0xGQctRzGVdBMp3XCNekY
         XxKNgu0QQwU8murp79evj6UcHASKQYCSPhdHUGMBHQWyLsLpny+vVG8xE4Cm6zbORIm1
         QOeg==
X-Gm-Message-State: AOJu0Yy4uoN6uc20sFg/7TMmCOh7G5qEhgDgHl41WelPBTj6vUB1Gdmw
	n/rh6XpcggNxDjWCXUrbCl3ju6zHrKLdtyUd69lP55YkJ2uebrFPkNVkI/WJCXxzcMZejQFft95
	/wA==
X-Google-Smtp-Source: AGHT+IG3T8n6i9CIqttErV8Bo+INnBsiuLY/V2/ws4VnW3aD+GyIXYcSu4oxC9ufAuaH6Oo66dSI6g==
X-Received: by 2002:a17:906:c404:b0:a6f:49bc:e857 with SMTP id a640c23a62f3a-a6f60cf4f97mr613960866b.6.1718632154628;
        Mon, 17 Jun 2024 06:49:14 -0700 (PDT)
Received: from google.com (140.20.91.34.bc.googleusercontent.com. [34.91.20.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6f56f40fe2sm528451366b.148.2024.06.17.06.49.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jun 2024 06:49:14 -0700 (PDT)
Date: Mon, 17 Jun 2024 13:49:10 +0000
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, kpsingh@kernel.org, andrii@kernel.org,
	daniel@iogearbox.net
Subject: [PATCH bpf] bpf: update BPF LSM maintainer list
Message-ID: <ZnA-1qdtXS1TayD7@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

After catching up with KP recently, we discussed that I will be now be
responsible for co-maintaining the BPF LSM. Adding myself as
designated maintainer of the BPF LSM, and specifying more files in
which the BPF LSM maintenance responsibilities should now extend out
to. This is at the back of all the BPF kfuncs that have been added
recently, which are fundamentally restricted to being used only from
BPF LSM program types.

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index cd3277a98cfe..8f8ceca5a380 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4083,12 +4083,13 @@ F:	kernel/bpf/ringbuf.c
 
 BPF [SECURITY & LSM] (Security Audit and Enforcement using BPF)
 M:	KP Singh <kpsingh@kernel.org>
-R:	Matt Bobrowski <mattbobrowski@google.com>
+M:	Matt Bobrowski <mattbobrowski@google.com>
 L:	bpf@vger.kernel.org
 S:	Maintained
 F:	Documentation/bpf/prog_lsm.rst
 F:	include/linux/bpf_lsm.h
 F:	kernel/bpf/bpf_lsm.c
+F:	kernel/trace/bpf_trace.c
 F:	security/bpf/
 
 BPF [SELFTESTS] (Test Runners & Infrastructure)
-- 
2.45.2.627.g7a2c4fd464-goog

/M


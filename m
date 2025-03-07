Return-Path: <bpf+bounces-53584-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93F24A56C47
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 16:39:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4FE851895E3F
	for <lists+bpf@lfdr.de>; Fri,  7 Mar 2025 15:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCF421D594;
	Fri,  7 Mar 2025 15:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="xDBudGvK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017A21D3EE
	for <bpf@vger.kernel.org>; Fri,  7 Mar 2025 15:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741361935; cv=none; b=YHNcWbGo8StJ0LqdX95SmKgfSleGmjLJqa6cyK0JDkIFPzFmlGHbtsnKyTdV68Eht84lmJzTrP0kV39CVYte/DRZYZF13vwPKoRiGMHsAQ7uOKkgSSgffNh+2fitBHTzQeGOGUQX2mGR6wlLzlm/ap8SrM7YSzWg66CKDa7uco8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741361935; c=relaxed/simple;
	bh=rFZTYSWl0eezaS66lCvVt4f/bUV0/izir9bQLikr0dU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Sr9ZVrD54orQ4tntr9pwSFhoWJ9p9ck4ESRc+mVtkUb0LZ8skgcGzF3/W5iwElG7HJc9Ny/YjYSmCIDS90QuymtKYKFzPlmWeYm2vmB+te867N6dLN4jTSth0ZNnZNUM/Kos+IgO6qsFafd7SUAvL47FbBtQFNizEPeWYlhA3uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=xDBudGvK; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-7be8f28172dso136117685a.3
        for <bpf@vger.kernel.org>; Fri, 07 Mar 2025 07:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741361932; x=1741966732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y5BvWU1lOJVee2REZfYF5pBuuwA0bagLDDEWtdoU5Ls=;
        b=xDBudGvKmHkgYiTuWcPfIlgcHG7N+GP8VKUwqMbCfOZzTma7+P2/ypGnjUNAaVsO8e
         exT31QCd++CRAHS7CRZs6pf0GP2FUAarLrytdf7/7hXjTLhgjiDov1XgDNW6NucnbH4S
         vVEdb4ZSHEVoWmKfO3v0wIAXu7Roi6+kUG0q7tZaGEVbT8p7qf2CRwS0JbwmdwC33f+T
         1gr3I0URIX5iRps7SeGEc+AqBFzLiLE9kMo/AV/VJyOJa89J0ONAc9e6V/BOkL6mKZ8N
         j40p/cXXwaVhTjkLEB6scrNdE5+2eIgA9X6AeSDSULIDnu7naDvfCu8jAEqvUVjoaL7V
         RRZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741361932; x=1741966732;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y5BvWU1lOJVee2REZfYF5pBuuwA0bagLDDEWtdoU5Ls=;
        b=FFcFIt1OnSQ/6iYQohO826yS1q2WmyAbDm0ILN684H8iKJtZUO7TnRswU+XpFAgpuV
         tG1vIR6CIMlcrjzUE6Ku7KK4T23ZotT0uYI7IXZb9g8L2v1AS6AI0na/SolgqbRYCXXV
         geIhR7Al3ZqKbxLzg2vgZr9EFMqgGJgbI1Yb7CHY/Psx/GHrcwYZ62AMurEof7pSpmPv
         irvKcUKXJXnXTOvvHgfuHWE02LTZLMSAYqWL8MEBWUlVI6ElO7PgABFFlrgCpHpvc7at
         acB3FPCyO1iRdHe/QWJqhrTKEdDoTItzyPz18kTlUEiYcXM7uH4sURTDdwXkV15yRK8/
         /kZw==
X-Gm-Message-State: AOJu0YwU+tx+7l9nRxXIVGeFEwctr3xiBxDmIOoqJPfuVIiyEWtr6db8
	bxrHRT2V8BqKet4GNTjrb5nLAXeR0ieflvev5CtqMEpXZQCplKHpGxgZ8JuQkW8UmwLDtEnUARe
	XaZFoCA==
X-Gm-Gg: ASbGncurIj1f8jkiHTxdawq4r6l+1EKAKjtJvAf5vB1Ku6k/Q38QgdQZUlAd+pi95Xv
	lHTBVIPgk829PH+5kKqcZABLN+eE3/j7A9yQUU9rfK1jHsKvHp0imWXF4amebN3P/ZAIl8ALLUl
	5sWV6/JxZnOl5E0dJnj4g7YZHAog2I82TXjLKZCJdkjWhKNLyikfJcKWLfJTN9CQQsC0htbetSz
	QXC2Qz7sGNribS60JFpZPG/8VFGuvbNkDeHPcOXAfv9GBTzm+4klhGo8S2FzXWWTG/DWukwU1S8
	UftkiESRGOYxyaYWZ1Pnymd93MlJIuGpz9aNWfE93A==
X-Google-Smtp-Source: AGHT+IH8QVJe9RoT8r8D0hJgrK65fFRWRBS/VaVmXvlIuCpq13fbMucKrun0qOUdv9LwP9Wq2TYdYg==
X-Received: by 2002:a05:620a:63c4:b0:7c3:d2f7:ca60 with SMTP id af79cd13be357-7c4e166ae0cmr554940285a.2.1741361931620;
        Fri, 07 Mar 2025 07:38:51 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3e5511c63sm253828585a.113.2025.03.07.07.38.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Mar 2025 07:38:51 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	tj@kernel.org,
	memxor@gmail.com,
	houtao@huaweicloud.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v6 0/4] bpf: introduce helper for populating bpf_cpumask
Date: Fri,  7 Mar 2025 10:38:43 -0500
Message-ID: <20250307153847.8530-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some BPF programs like scx schedulers have their own internal CPU mask types, 
mask types, which they must transform into struct bpf_cpumask instances
before passing them to scheduling-related kfuncs. There is currently no
way to efficiently populate the bitfield of a bpf_cpumask from BPF memory, 
and programs must use multiple bpf_cpumask_[set, clear] calls to do so. 
Introduce a kfunc helper to populate the bitfield of a bpf_cpumask from valid 
BPF memory with a single call.

Changelog :
-----------
v5->v6
v5:https://lore.kernel.org/bpf/20250307041738.6665-1-emil@etsalapatis.com/

Addressed feedback by Hou Tao:
	* Removed __success attributes from cpumask selftests
	* Fixed stale patch description that used old function name

v4->v5
v4: https://lore.kernel.org/bpf/20250305211235.368399-1-emil@etsalapatis.com/

Addressed feedback by Hou Tao:
	* Readded the tests in tools/selftests/bpf/prog_tests/cpumask.c,
	turns out the selftest entries were not duplicates.
	* Removed stray whitespace in selftest.
	* Add patch the missing selftest to prog_tests/cpumask.c
	* Explicitly annotate all cpumask selftests with __success

The last patch could very well be its own cleanup patch, but I rolled it into 
this series because it came up in the discussion. If the last patch in the
series has any issues I'd be fine with applying the first 3 patches and dealing 
with it separately.

v3->v4
v3: https://lore.kernel.org/bpf/20250305161327.203396-1-emil@etsalapatis.com/

	* Removed new tests from tools/selftests/bpf/prog_tests/cpumask.c because
they were being run twice.

Addressed feedback by Alexei Starovoitov:
	* Added missing return value in function kdoc
	* Added an additional patch fixing some missing kdoc fields in
	kernel/bpf/cpumask.c

Addressed feedback by Tejun Heo:
	* Renamed the kfunc to bpf_cpumask_populate to avoid confusion
	w/ bitmap_fill()

v2->v3
v2: https://lore.kernel.org/bpf/20250305021020.1004858-1-emil@etsalapatis.com/

Addressed feedback by Alexei Starovoitov:
	* Added back patch descriptions dropped from v1->v2
	* Elide the alignment check for archs with efficient
	  unaligned accesses

v1->v2
v1: https://lore.kernel.org/bpf/20250228003321.1409285-1-emil@etsalapatis.com/

Addressed feedback by Hou Tao:
	* Add check that the input buffer is aligned to sizeof(long)
	* Adjust input buffer size check to use bitmap_size()
	* Add selftest for checking the bit pattern of the bpf_cpumask
	* Moved all selftests into existing files

Signed-off-by: Emil Tsalapatis (Meta) <emil@etsalapatis.com>

Emil Tsalapatis (4):
  bpf: add kfunc for populating cpumask bits
  selftests: bpf: add bpf_cpumask_populate selftests
  bpf: fix missing kdoc string fields in cpumask.c
  selftests: bpf: add cpumask test_refcount_null_tracking test to runner

 kernel/bpf/cpumask.c                          |  53 +++++++++
 .../selftests/bpf/prog_tests/cpumask.c        |   4 +
 .../selftests/bpf/progs/cpumask_common.h      |   1 +
 .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
 .../selftests/bpf/progs/cpumask_success.c     | 110 ++++++++++++++++++
 5 files changed, 206 insertions(+)

-- 
2.47.1



Return-Path: <bpf+bounces-53348-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 971CCA5044C
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 17:13:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60AC716A214
	for <lists+bpf@lfdr.de>; Wed,  5 Mar 2025 16:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E67250BF6;
	Wed,  5 Mar 2025 16:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="s2rO94re"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BA4B24FC1A
	for <bpf@vger.kernel.org>; Wed,  5 Mar 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741191214; cv=none; b=puiuf0+qzJiM2RJ3zE4PKmTLlFz8TlqhVfNwAy5Nq6SzZuip+qDFBDC0+BkDQ7pQeTWLj8H5QPwlcd6m/ODP6J+9I2yRwAwozNbVY+OmeQk9SC7uhODQnKwVZVn2BFzFK3NYiUmGLmQjpsGTDuSKxkWv0Lkf9T9aeMclHSfVo8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741191214; c=relaxed/simple;
	bh=8DXrmhzUVLapt/X0tl1IhkTmUx8PBCtfmCEHNi7P/+k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KFSrkfCw++tGdN1m0CziQ/HJojOtKxpTCj75zHlBVdsAF6Dz0uAYqsyLIafH1utD1bvRaN0mIysmyP2ppZn1NUdumkvbPkg3cuLWAm9y7U6U6ARQ3CnO9jLW2GmYbw4+STVdxKLDeU5DoAX0WRpIgEBbD1gQ8HhbFXK5n5BZjkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=s2rO94re; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-7c089b2e239so91837185a.0
        for <bpf@vger.kernel.org>; Wed, 05 Mar 2025 08:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1741191211; x=1741796011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NFtW2zuQqbQDp8xEgMN2yFXEVKLAN3g2b6YyBhZKE94=;
        b=s2rO94refDbEuA4O5ArQJvx2Ji5/lidqeJbEN6m4/YZyYE6c5ROEOgg1j9+taM+7HF
         ZwOXhzVvfO1KbWvyd6VHjJdnYF0LcDctdC+LsLlX1rgI7cYXuz2yLAGO5HNhV/MOCvNm
         JIFiel+sY7kIa1ajRCzz7fSlHEqt1V7xlNmh/P/IVw0HboaWufrwMplws21INFz0sr0c
         LxZMzQ4uJQP7zZckWigDTAY5PAABpUbSWdzaRAJ1PV6/TCXWXIt5yQYNP8z22yLVUHeF
         QsqnE0FwK1OczFmYZ0MpSzI/fguUeiGLnQIWmcD5U11d1KT6a5Kl/l3NCMVymw8F9DP3
         4ATw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741191211; x=1741796011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NFtW2zuQqbQDp8xEgMN2yFXEVKLAN3g2b6YyBhZKE94=;
        b=qlUAc1ynwQ4Zlz+MDLFn157C+NO6M3VUgXzspf2KwS5PbMVqIDIWO98vRcV+Rg06PJ
         o/kjM5sN58gbO6YSahjx7WQUZq993vSkUaPXD20iAaaEfMLoy2vQj8EVOVjo8gZJrFK/
         4jgyhZ0p/RTrneZQ37oT5GOFQWO3adl5UhqIx3hnImWc6SM0SZsWJVaWQD0QLWZ3BhxN
         t4sf+jCYussFBpBkdy7/SeQNplDG/A8vlQhcKQi1Fx742bLwjBaehV1uolhRlDdFyXz7
         i9HFi9RmyJj0ATJZH0vHOELWRH4EU6jLBCSvclErnPi+a9dze8v/E5ge3fZ26WBmxFdh
         aCYQ==
X-Gm-Message-State: AOJu0YyZc5v1Tn8nnaafon0+kpKcJLPFHo9f+ExKFOvDTsJtjfamzgMo
	6nQ+WryevaT9Vjj1XVCiLt8/W+kBYs6JqqCakRRJ1wFrA//d5vnQfra4ZVXl8FUXCeumvEXaa2A
	/DDwK/A==
X-Gm-Gg: ASbGncvP7HA0gSPJxxnFCO3zpYNJMFiZN+jP1+c4JtE7ZVS4PDQ5j4Nn4NN18pM7WbB
	7e8FSBMa0WLh54b1Htcr1qtMHf8RhiaQa02evGoMuezyxTZ9Abgw5mMm2D/4r0evB/W1cWRMTdK
	Fh9rPbKlfJSQPYfIy5aysgTWEyexyGQs6fr26og9masMhzj1q/2csdpQGtBSCQ70ROqMhABL6LS
	d5xxkg/wVO9GqSaryr1c6v+QhQG0VnAGsC/1EoAhIvzH5epOrug5bytokQXpfItAXbHMTgCo1wK
	89BufXmvhj+jC9La02AtJdCXripysW68xTAd0Y8qKQ==
X-Google-Smtp-Source: AGHT+IFz0Yv8vIlAgG0PCnvFbtClpX7BRGAs8cPr4vMKXbXp20iaplY3kak5SPs0gqAtFNevkIQxTg==
X-Received: by 2002:a05:620a:1d03:b0:7c0:9fab:bee with SMTP id af79cd13be357-7c3d917552cmr505274985a.10.1741191210878;
        Wed, 05 Mar 2025 08:13:30 -0800 (PST)
Received: from boreas.. ([140.174.215.88])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7c3c32aa5c6sm368393085a.48.2025.03.05.08.13.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Mar 2025 08:13:30 -0800 (PST)
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
Subject: [PATCH v3 0/2] bpf: introduce helper for populating bpf_cpumask
Date: Wed,  5 Mar 2025 11:13:25 -0500
Message-ID: <20250305161327.203396-1-emil@etsalapatis.com>
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

Emil Tsalapatis (2):
  bpf: add kfunc for populating cpumask bits
  selftests: bpf: add bpf_cpumask_fill selftests

 kernel/bpf/cpumask.c                          |  28 +++++
 .../selftests/bpf/prog_tests/cpumask.c        |   3 +
 .../selftests/bpf/progs/cpumask_failure.c     |  38 ++++++
 .../selftests/bpf/progs/cpumask_success.c     | 114 ++++++++++++++++++
 4 files changed, 183 insertions(+)

-- 
2.47.1



Return-Path: <bpf+bounces-43823-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 636519BA3EA
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 05:22:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F5CC1C21095
	for <lists+bpf@lfdr.de>; Sun,  3 Nov 2024 04:22:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E941212B169;
	Sun,  3 Nov 2024 04:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D1L2tiyF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2924BA31;
	Sun,  3 Nov 2024 04:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730607736; cv=none; b=C1zMW2tyy76cZYrNKDr67QUhoIow/Cpc0NvgRw5ki+Wb+vkpq13ymH2bn2Uz/bJ/qlcNGB3Is8eLj+8D0rMJ+JkYK4UsZiqzFU3ki73TYQVHOvUKK8MEX6ov3GcxtiwW+SMpZ2SWvTqiIrkmb8ggiSx2X0/NeYrw0ILR70G24Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730607736; c=relaxed/simple;
	bh=IerCCKyp+i7fDrVdh8gyikBCnf3TLCOlfEqRvSKTIXw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=ZJpWoOxB4lAC/DFBI22FiWYZbpNeqKMSVLZXDjygIgLmpLdZb0c/X0F4Cnh27c2J3uitbpHsVh/trd6+qfXAHByZw90DJ8ccv+QdiS4f/vuBvIyX8quPdi5OYRUfvXkJmV+RmH6W77QcJG7xA8I5oJ4njaDeyLpDOiy6vfha52c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D1L2tiyF; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e953f4e7cso2497561b3a.3;
        Sat, 02 Nov 2024 21:22:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730607734; x=1731212534; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hUpt+HATsZJL+RG8BWSpg0OeAVVkuazZ98fyiiRz2y8=;
        b=D1L2tiyFw48vDtfZ7/lJ3/A77tlT3MSd9K9kcjU7Tdt6rbBGRw2cuySx5Ovftj4nue
         BJhAyaBfWEYln9Sft+WA56o7AUxKL7CRW1ST4ooIHJ3kkm+7bMj54dCREhVLY16QFNJ6
         5seFV6LVsgrbOsK0fpT4LvbVgw+cyzxZYR7EvrlUL7I30kYHAgibDynO9A/sEhjj+655
         k2dplrSYj3zN7ib1a2HOncZRvQn8oVaTXPzQAEHieNR9Jz3t/kcmpZfaUdQEHFSkxgDm
         4VCNfjrU3FakvHHLHluZYs4Az8vfsXs4ahpdK3G0SY2J971HrvjMCStSV7BVkADNIx+l
         KcKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730607734; x=1731212534;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hUpt+HATsZJL+RG8BWSpg0OeAVVkuazZ98fyiiRz2y8=;
        b=oNN2VAzlqWSPe3iL3yg3e23isk0cZZdim3mxa6jUyQFHZ5aCn3oB0Lan3ubcvMsBJP
         C6vD6/fQD9ldQF/WfY213csWk+pSyYhv2KJtGrd0lciu8Jsm/uGNvZrulslw6cXGBm9K
         7pbnO/XZqBqa2jXcEfRIFeyRWrQkmEy9v+3/flmLFG/vwsXHdAnrYkJAiZpS9hITlpkr
         EFTAZIX77PLTux4fO2j7/XRJHOLoBt8/q/ti2k2TvsrXiy0KJEgD8ShI6aEfv+kj1wqw
         y5BtXtHXR7kOLig8HlbYuAk2C3oiDJZeQsX6JxBh76dKSr62Qz/s3hpeFJTl690zwDK8
         U4Ng==
X-Forwarded-Encrypted: i=1; AJvYcCUzMCeSQ7bxsCpcwlHrOAGW0f271cw0D8LAVS7eSb5eKKNYp0QIvghcCvDQYzFf2l+CRpmYjPzvnG/mlWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC1L+vU1kzUpYLUpQdQhnxd/WV5Cs/J0q7eefHoXSzVbP9QoDH
	I9XBXWAksAvUbE2AKXhciwYR1wbjS3tIxXq9j/2WgvxIyXdv08vG
X-Google-Smtp-Source: AGHT+IEVXlyCJ2b0V9cJd8wSOgdtUmBgxWmwBDAWN3QxAyR+y05vZdrpDOm9TKpLDuJRnKIEoSwi5Q==
X-Received: by 2002:a05:6a00:3910:b0:71d:fbf3:f769 with SMTP id d2e1a72fcca58-720c99ca5bemr13163861b3a.28.1730607734285;
        Sat, 02 Nov 2024 21:22:14 -0700 (PDT)
Received: from ub22 ([121.137.86.69])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc2c3db8sm4968276b3a.131.2024.11.02.21.22.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Nov 2024 21:22:13 -0700 (PDT)
Date: Sun, 3 Nov 2024 04:22:09 +0000
From: Byeonguk Jeong <jungbu2855@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Hou Tao <houtao1@huawei.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH bpf] selftests/bpf: Add a copyright notice to
 lpm_trie_map_get_next_key
Message-ID: <Zyb6cVpIqmMBld4U@ub22>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Add a copyright notice that was missed at the commit
d7f214aeacb9 ("selftests/bpf: Add test for trie_get_next_key()")

Signed-off-by: Byeonguk Jeong <jungbu2855@gmail.com>
---
 .../testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c
index 0ba015686492..3821d229cad3 100644
--- a/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c
+++ b/tools/testing/selftests/bpf/map_tests/lpm_trie_map_get_next_key.c
@@ -1,5 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
-
+/* Copyright (c) 2024 Ahnlab, Inc.  */
 #define _GNU_SOURCE
 #include <linux/bpf.h>
 #include <stdio.h>
-- 
2.43.0



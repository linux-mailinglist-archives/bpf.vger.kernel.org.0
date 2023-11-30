Return-Path: <bpf+bounces-16321-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA187FFC10
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 21:12:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 864A7B211AE
	for <lists+bpf@lfdr.de>; Thu, 30 Nov 2023 20:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F91553E3F;
	Thu, 30 Nov 2023 20:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="KQI/x0XK"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 749D41707
	for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 12:12:24 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1d00689f5c8so12940895ad.3
        for <bpf@vger.kernel.org>; Thu, 30 Nov 2023 12:12:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701375144; x=1701979944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7yRpge09PX0Wdf+lXNd5GtHqIwiw9GJP88cctVPhIEQ=;
        b=KQI/x0XKzHUwiun86pdojo9dG4VYDwNQHFMDnMXJ7jzWyRHIkwBARxnOnK+beQJo/c
         r4tPQ6ymCmsC/hT6wcqH19AItRpxtJVSsWWJBKGmCUi9x6oTSO9rpo+Sxkagf4WEUBx2
         WZvUWICIpqV8kynmH8B8vZs8UAmXLn6cva9o8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701375144; x=1701979944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7yRpge09PX0Wdf+lXNd5GtHqIwiw9GJP88cctVPhIEQ=;
        b=NDmOAU8o0U28hg6mWfaqI2sVw5LcoKsapaNCCBzGVdhhXRIy8hs6DMZfC0c1Oj9cTd
         RwV87OVQ3WpbzpIpshtwcL0K4hm5E3S+N0AgrKvlJ5qBqM5fHs/IT8GPcp1i9LFx05JR
         kGg6cSV7gwAyNyQfyjR8/pUmE7E7j1HzZvoBkRdhO9njAZ96/UZzESsDih5MF2+zr9/t
         AtQV7KZHbu8r1v88EQ/vQhYzK0sSar3Zunh1J63wwDmQ6nSzN9JME7MWV6kyu4OVzDCx
         +YML1v9YaJrg2QOo90+qJ5T/lVfJrUkNc90tYVll674Jh+xEyESyrX8toqI4rT8jYpFN
         Lgrg==
X-Gm-Message-State: AOJu0Yxzxu/w50qKOtvavI866vmNBErSZ6qSk0VKSSjT/ckxiqh6+NHv
	X50hYLae9QH9Soon7U1hrLdWy06q8HrsGfyRKA4=
X-Google-Smtp-Source: AGHT+IEDYvGJDcvQf6eDCqExzllAKwKdXUTeiStyIwP++5uBdiMWqPss+P+SimJ7F/qh2uGJAVp4Og==
X-Received: by 2002:a17:902:ecc8:b0:1d0:4d29:59fe with SMTP id a8-20020a170902ecc800b001d04d2959femr560911plh.11.1701375143939;
        Thu, 30 Nov 2023 12:12:23 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z10-20020a170902834a00b001c9bfd20d0csm1576359pln.124.2023.11.30.12.12.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 12:12:23 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Kees Cook <keescook@chromium.org>,
	Tejun Heo <tj@kernel.org>,
	Azeem Shaikh <azeemshaikh38@gmail.com>,
	Zefan Li <lizefan.x@bytedance.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Waiman Long <longman@redhat.com>,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v2 0/3] kernfs: Convert from strlcpy() to strscpy()
Date: Thu, 30 Nov 2023 12:12:16 -0800
Message-Id: <20231130200937.it.424-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1072; i=keescook@chromium.org;
 h=from:subject:message-id; bh=aEUE6lE4Q4cUS7kmRUCpsCDoI/XFYy6JmG/BqtvEWnc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlaOyjI+ulGzRHZE1zwS6WR9cpBI2cEhkIYffMO
 9/dfSozg3iJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZWjsowAKCRCJcvTf3G3A
 JvOLEACZaWfvn9Cv8vZlRQpBSWc4rShaO8nhhX/XpPHxU6M1Z5+XfBC2zl+AXSjGhXP4DV//eAJ
 /vRrKbqPD9FeLzKL45byGmDMqvYx5dV6aNAbzSFFHBltO5+yseaCpQpxQiowujYsZf7ggkHpPtb
 Br+dw8RrG6G9toJQz/2YW3z9ajNBETHg8Gi+DSyt4JhfTbVWb6mYukNCbyA43kqJPb2P3DKZjiq
 fVR2NmIsr1A7WnIyelCG8vMYUvOcaNeDkIVDg03yqfYUwDpITC8LRkTlkZyuz3jxvhzMRcWBswD
 pjYUqtjknDg1Ml60j29/Rqc2OkMM5o+IWNLmsx7pNR7vNo99Pzz8kqokZyo4nwGVB5OEwq4s8sM
 BO7JZVu4uhFLo939MvouGYFnXni3ka8rAZL+PY6wQD2aY4SvOYrvRn9K+pPLTImGc1RZbbGunQO
 ztkb+zjBiSlGDVUZ/qLogaTl7ngdqaGlBmh0uKIieptT4mdowHTkLci9peGu2KWCHWur6YBwIfu
 sXYEMP0mIluc6E+ZgnH7j1Duv3uLb1d2rW5G6xFT56jASPCfyKVlNuXCjdhYUtv+4TPfY2R1b4t
 HE8DQqBL7dCoA9Y3ViBzBe2Ql1UDcpQYm88yc5yYKiMkYtbaVwh3BGfB3ErxdERREMFmxqOYB3G
 JW65K4X oSJm3ZEA==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

Hi,

One of the last users of strlcpy() is kernfs, which has some complex
calling hierarchies that needed to be carefully examined. This series
refactors the strlcpy() calls into strscpy() calls, and bubbles up all
changes in return value checking for callers. Future work in kernfs and
sysfs will see the replacement of open-coded string handling with the
seq_buf API, but we need to do one thing at a time.

Thanks!

-kees

v2:
 - drop extraneous kernel/trace/trace_uprobe.c change
v1: https://lore.kernel.org/linux-hardening/20231116191718.work.246-kees@kernel.org/


Kees Cook (3):
  kernfs: Convert kernfs_walk_ns() from strlcpy() to strscpy()
  kernfs: Convert kernfs_name_locked() from strlcpy() to strscpy()
  kernfs: Convert kernfs_path_from_node_locked() from strlcpy() to
    strscpy()

 fs/kernfs/dir.c           | 53 +++++++++++++++++++++------------------
 kernel/cgroup/cgroup-v1.c |  2 +-
 kernel/cgroup/cgroup.c    |  4 +--
 kernel/cgroup/cpuset.c    |  2 +-
 4 files changed, 32 insertions(+), 29 deletions(-)

-- 
2.34.1



Return-Path: <bpf+bounces-76877-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E2779CC8D62
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 17:44:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 38F6230AB963
	for <lists+bpf@lfdr.de>; Wed, 17 Dec 2025 16:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50CA34E748;
	Wed, 17 Dec 2025 16:28:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="UbGQDrg+"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED5C534D4C8
	for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765988884; cv=none; b=tQZqivsUvH6w/IO90+Ni4jVKCovgZIMUNlLa9LbeEKz2QHIFKGA4xaZGKuzHmtrwfjqiMCE+ZwC/2eQkjY8ZdD5FUaAzDilfHFE7oMBEc+B9NZpA9YDBdZ/n0fprWyIyu1Pj5rtUSuy2nZkVl15dM9CYwKNC2oDuLgQIyzcIWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765988884; c=relaxed/simple;
	bh=0v6GiZwQmw10VgYg7XmvF5rjkeue5FWN8L2ipdtQVmk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=igyZOTFBuOyrF/jqZISeNVWLrECEUb+xiOQDn2OkrvoEYfUpKGwvpcIMliv2ZAd4hy+QsDIzT+yi626/iwfKXlOsH14vnZkuYAJsPgyDDbRjwL+MOg0Wmch8gvawfPKSVyeAZYOJedWDrbedPZ2u7Ow3JPBjh7cMUJKSUfprQWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=UbGQDrg+; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47a8195e515so49384085e9.0
        for <bpf@vger.kernel.org>; Wed, 17 Dec 2025 08:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1765988879; x=1766593679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AUIBRQ1EfMgD4rZghNrrxsliWBknI9gTPJQu3bDLcJY=;
        b=UbGQDrg+UUeEvVqqTzNHHL2CAtmr0I9eivMDfiPs4dvksQdkDU/B3/wR9FEybrFdHr
         SgIjdbP6RwhsIXv5PHq85HSnQFzcXVHnTKEStgGDukUaTAYffZ4OOz6dtGN1coTVe9FO
         Nehe2UuFXP6JgfANpbTmZK4g+WlyNCbIMgGcsLes3wNE3khOOdj7mNbWAcWsu+5PjlkQ
         9+URkf7nYwCCb5XIlw3QHFKkzA9OnvR6QP/5eil33+qX9EZRYOuR4wlL5GM+Ay/sqnGv
         Jr4mfbsJdqrdkWD6uyWFIOvjMcABh1LW7b5DWRBxnP5rg6R4V2AHdYMWnYBuIaRN+gLy
         72sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765988879; x=1766593679;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AUIBRQ1EfMgD4rZghNrrxsliWBknI9gTPJQu3bDLcJY=;
        b=jOLYsBllPLz3sGPNRZ1xmZNBHIvIdUFfQGFELKUMBHfpDXQ7c1FQ/VXVXLQBmQ8KGE
         pEYhhFYh0lLZfxIcUnSPKEaueBgkJnX8LlABjYmAA6cCJwsbDxHYeKABh8ThmIVEjOK1
         LKRXZ68pDOs1R9O4k3msY7yQWlbd5hUsiBfMXDzcKcK1N2JkA68elrTGsT3zqs2Srwxt
         YG2ORra7nYSWuxIN65KMKJP4UjwtDt0ceOfKSd52VXnME0nOCLPjFdvvv7paw5XWTRLx
         dEVzsANXMwbot0UNXGbAQVgwlW10RgD3AG5Br6rxyjoj5iwVAoTUXfN0QhSkF08exjFP
         LYjg==
X-Forwarded-Encrypted: i=1; AJvYcCVBIQjJsUaeloDRk0fjgPf/RzU357xiyorRpcFp66HdZTRiPAyAkqEtJ8AckYWvmloIEHg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyiA8np0iETyi8vdOW+TSqNLUj7hL7CAIqa3fQ9kOBhPnaXwgDp
	1pnIBSL2kpUeS43/XdxZDF0Kx71nWTjKLI2iJwgt39zkUg1AAMBupey3mBTzbnyvBQY=
X-Gm-Gg: AY/fxX7IIpqCxLf5TcJ03i5H4urwLT30odvge2toIkzzWgrpAhaVV8LeRRJ+DlQcUcu
	zKMgnkPqQxppxFlup88bUO6Sat6q5KhF58vD1s1yKR9Mxv8+dxQ4ng0kelkphDXcK/XUuQ+tSET
	rGT9+BQ5PC6tXrHTrku3Tca0GVr1/O35eKIrDSJN4C6o7kODC45vn3GHb/kOS9I/PxwTw+W66gV
	9xz5B94as1RV4aXnkzOuEABRNI9eg6UqiWbtGHbRE4LkTCL6JpegEZ+1fl8pLrMikV3Z+rzMqxS
	7BSv7r2bt6gBqKJtl4E9zk4baHgLh6Z+MIMiumiyMM/MJNHrjCjm2mjRsxywBYT+aXFc46Yjez/
	EoKiMiEACSz0vBrTPbAPWn99fTzpEppyCufIcrt4RphJr9KdJBwySlIsYl29bFoRcNYQzAkyIYV
	9koW8GaHMMQtIQgzTaHXLJr3V/jWHeUYA=
X-Google-Smtp-Source: AGHT+IHGmMOUEefQoO5S3en43Zsul1QO3grq/W53kRWnWoSN5JrVJ1XTvQBX4MbJYn1xXsNPaQdx7A==
X-Received: by 2002:a05:600c:5298:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-47bdf5f0e9dmr21345875e9.21.1765988879254;
        Wed, 17 Dec 2025 08:27:59 -0800 (PST)
Received: from blackdock.suse.cz (nat2.prg.suse.com. [195.250.132.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4310adeee0esm5728364f8f.29.2025.12.17.08.27.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 08:27:58 -0800 (PST)
From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
To: linux-block@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	netfilter-devel@vger.kernel.org,
	netdev@vger.kernel.org,
	coreteam@netfilter.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	cgroups@vger.kernel.org
Cc: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Hao Luo <haoluo@google.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Phil Sutter <phil@nwl.cc>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jens Axboe <axboe@kernel.dk>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Florian Westphal <fw@strlen.de>,
	Jiri Olsa <jolsa@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Song Liu <song@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Simon Horman <horms@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Tejun Heo <tj@kernel.org>,
	Josef Bacik <josef@toxicpanda.com>,
	Paolo Abeni <pabeni@redhat.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Yu Kuai <yukuai@fnnas.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 0/4] Use __counted_by for ancestor arrays
Date: Wed, 17 Dec 2025 17:27:32 +0100
Message-ID: <20251217162744.352391-1-mkoutny@suse.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The trick with utilizing space in cgroup_root for cgroup::ancetors flex
array was an obstacle for kernel reworks for
-Wflex-array-member-not-at-end.

The first patch fixes that, then I wanted to utilize __counted_by for
this flex array which required some more rework how cgroup level is
evaluated.

Similar flex array is also in struct ioc_gq where it was tempting to
simply use __counted_by(level), however, this would be off-by-one as it
has semantics like cgroup's level (0 == root).
Proper adjustment for __counted_by() would either need similar
level/ancestor helpers or abstracted macros for ancestors up/down
iterations.

I only made a simple comment fixup since I'm not sure about benefit of
__counted_by for structs that aren't sized based on direct user input.

Michal Koutný (4):
  cgroup: Eliminate cgrp_ancestor_storage in cgroup_root
  cgroup: Introduce cgroup_level() helper
  cgroup: Use __counted_by for cgroup::ancestors
  blk-iocost: Correct comment ioc_gq::level

 block/bfq-iosched.c           |  2 +-
 block/blk-iocost.c            |  6 ++---
 include/linux/cgroup-defs.h   | 43 +++++++++++++++++++----------------
 include/linux/cgroup.h        | 18 ++++++++++++---
 include/trace/events/cgroup.h |  8 +++----
 kernel/bpf/helpers.c          |  2 +-
 kernel/cgroup/cgroup.c        |  9 ++++----
 net/netfilter/nft_socket.c    |  2 +-
 8 files changed, 53 insertions(+), 37 deletions(-)


base-commit: 8f0b4cce4481fb22653697cced8d0d04027cb1e8
-- 
2.52.0



Return-Path: <bpf+bounces-30537-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FCA8CEC68
	for <lists+bpf@lfdr.de>; Sat, 25 May 2024 00:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F8B6B219C2
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 22:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 327F684E1A;
	Fri, 24 May 2024 22:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUQaTe5h"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6843D3B8
	for <bpf@vger.kernel.org>; Fri, 24 May 2024 22:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716589842; cv=none; b=byGhgbF82XrOAg9V8zy9r8A6/YIL6RHDqmrVF72wSrzlj1Kff9P71HKlkOxXKeot7WdFXSgUiPJqlE5W3SLm5nnOF3v9AfFavOVueAcvmeh9r2J4RTWu0w1cxQl8c5lsw8zx4p1he0kl+2fWTvKQ4GYBhYy62fEen4y2e+ocYjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716589842; c=relaxed/simple;
	bh=eePQqzbzNF6ZrvZM96FauMSpMGdumdlTkkfK4uEezCc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MI97spAcAIym2dZdSW3vHRrsI01nd4Y1hGZvTpDbo4gItCGeWLwwTGTilEeb1vegAosBaF1mSJQE2WEoxQEW6NFa+C5tNwDy9i3nZufE9aO8nZtOE2Dp1pVeSpDFVA4yfkKgXCOGyE/r7XD2Z+qApLJI4mo1eJXotuNs/SBcD4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUQaTe5h; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-62a0827316eso14555087b3.1
        for <bpf@vger.kernel.org>; Fri, 24 May 2024 15:30:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716589840; x=1717194640; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2rDjbJNFbH5Gj1X1vBqsys6KrCCIVd8ZwYPdMsCe1M=;
        b=EUQaTe5hxdDJtKgZfL3JYxAg3tmtv4gjavMnB4E6yHI+moiKAIxeTFBrCw4nXtIIJq
         2nCwEzLRaK/KkDq9GNLbZDf+i5pcF6QS5JSgnPG+3Din8sDuURPDtpal8+T7fN0yiC+W
         vC94IwxSvxhfBOyB/jv6ohMqN8+Tvf8omdm/DHkOx0BMLfHbGN8hQKz+z87ctpmfk9t7
         RE2mfO0PPb9f8p178D/zMp9SQTMqu3DD3hXGP04Ry3Jx8w5DAkUyK3PyQx8p6ieQnbxB
         ky4GiWP7Q2PvhFp4HY+ruLLJwvrQCY7OewB/kh9aSw946uPKbAO+nDDbNEvMA6XLOaXZ
         jmzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716589840; x=1717194640;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2rDjbJNFbH5Gj1X1vBqsys6KrCCIVd8ZwYPdMsCe1M=;
        b=VYpMc63W8otWP/3rJ1uhE0lvJOmk3oHYDe2ZbNWxPgV36nREEfeB6JhbqttIr6Mhia
         EgpT5i4sK7L6aIMWTra78bw7vyjdkE+kmVbp3PrmiurkyT8tzvfbd1C6Hx/ShyNKmxbr
         0sVa9Y3kbVX1lkKyRKZZUGKJpGDI+9aglA45zOdhpOODu0a/Jpg7p/h0HfHg/RMn6nCp
         WvaBpA8f4Gxl541duUMAPLSwn+ifJ12BD0h+FQ/aHJrwnB+PVURlMZOlv//AA9CDsfVf
         ORUQeKmQILP4JvMxZvDCd2LHNz1WjOa8l9AB3IpQfRPNKC4QclBMJdTXs1GkHXbETylF
         xs4w==
X-Gm-Message-State: AOJu0Yy4NUv1xBUqyxPv2hmY/kpAecMNK9ib9bHAvnUFKPnVv+kVzH98
	pfYAI3csDT2UMN22DGYmCKi5OO/VTLZLEsHP+yTGKB3rhJ4LADldfrgiFw==
X-Google-Smtp-Source: AGHT+IFiEmTD++v4iq1T9btal3UfsDn0vYoUZO8eWOVIGtSPL7xl2/cfDzbrTS411xy38B48a/nyTw==
X-Received: by 2002:a81:a1c9:0:b0:627:8791:5c4 with SMTP id 00721157ae682-62a08d2aab2mr35140847b3.8.1716589839688;
        Fri, 24 May 2024 15:30:39 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:6aeb:e91b:f49d:e77d])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a3bfa19sm4169987b3.44.2024.05.24.15.30.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 May 2024 15:30:39 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/8] Notify user space when a struct_ops object is detached/unregistered
Date: Fri, 24 May 2024 15:30:28 -0700
Message-Id: <20240524223036.318800-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The subsystems managing struct_ops objects may need to detach a
struct_ops object due to errors or other reasons. It would be useful
to notify user space programs so that error recovery or logging can be
carried out.

This patch set enables the detach feature for struct_ops links and
send an event to epoll when a link is detached.  Subsystems could call
link->ops->detach() to detach a link and notify user space programs
through epoll.

The signatures of callback functions in "struct bpf_struct_ops" have
been changed as well to pass an extra link argument to
subsystems. Subsystems could detach the links received from reg() and
update() callbacks if there is. This also provides a way that
subsystems can distinguish registrations for an object that has been
registered multiple times for several links.

However, bpf struct_ops maps without BPF_F_LINK have no any link.
Subsystems will receive NULL link pointer for this case.

---
Changes from v5:

 - Change the commit title of the patch for bpftool.

Changes from v4:

 - Change error code for bpf_struct_ops_map_link_update()

 - Always return 0 for bpf_struct_ops_map_link_detach()

 - Hold update_mutex in bpf_struct_ops_link_create()

 - Add a separated instance of file_operations for links supporting
   poll.

 - Fix bpftool for bpf_link_fops_poll.

Changes from v3:

 - Add a comment to explain why holding update_mutex is not necessary
   in bpf_struct_ops_link_create()

 - Use rcu_access_pointer() in bpf_struct_ops_map_link_poll().

Changes from v2:

 - Rephrased commit logs and comments.

 - Addressed some mistakes from patch splitting.

 - Replace mutex with spinlock in bpf_testmod.c to address lockdep
   Splat and simplify the implementation.

 - Fix an argument passing to rcu_dereference_protected().

Changes from v1:

 - Pass a link to reg, unreg, and update callbacks.

 - Provide a function to detach a link from underlying subsystems.

 - Add a kfunc to mimic detachments from subsystems, and provide a
   flexible way to control when to do detachments.

 - Add two tests to detach a link from the subsystem after the refcount
   of the link drops to zero.

v5: https://lore.kernel.org/all/20240523230848.2022072-1-thinker.li@gmail.com/
v4: https://lore.kernel.org/all/20240521225121.770930-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20240510002942.1253354-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240507055600.2382627-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240429213609.487820-1-thinker.li@gmail.com/

Kui-Feng Lee (8):
  bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
  bpf: enable detaching links of struct_ops objects.
  bpf: support epoll from bpf struct_ops links.
  bpf: export bpf_link_inc_not_zero.
  selftests/bpf: test struct_ops with epoll
  selftests/bpf: detach a struct_ops link from the subsystem managing
    it.
  selftests/bpf: make sure bpf_testmod handling racing link destroying
    well.
  bpftool: Change pid_iter.bpf.c to comply with the change of
    bpf_link_fops.

 include/linux/bpf.h                           |  13 +-
 kernel/bpf/bpf_struct_ops.c                   |  80 +++++++--
 kernel/bpf/syscall.c                          |  34 +++-
 net/bpf/bpf_dummy_struct_ops.c                |   4 +-
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 tools/bpf/bpftool/skeleton/pid_iter.bpf.c     |   7 +-
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     |   4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  48 ++++-
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 168 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_detach.c   |  16 ++
 11 files changed, 350 insertions(+), 31 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_detach.c

-- 
2.34.1



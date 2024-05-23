Return-Path: <bpf+bounces-30437-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0668A8CDD1E
	for <lists+bpf@lfdr.de>; Fri, 24 May 2024 01:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF9C285701
	for <lists+bpf@lfdr.de>; Thu, 23 May 2024 23:08:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61BDE128377;
	Thu, 23 May 2024 23:08:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BeZFTXZz"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70C01763E6
	for <bpf@vger.kernel.org>; Thu, 23 May 2024 23:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716505734; cv=none; b=OvpaRWI4EtGnqaBRgWD/AmNzGl8rPsKkymF+9GkaaelCbaIexfVML2yGlrpCtJ+fOZQm1hvVr4XtlPG5nQvO95yml3tmsn0nafYr6Jlcbsvynj92vvVxWweGOW4G2M3ce+Nf89wTXOtl2vyS/HffPVXkTraGdXHZuGDa7aem2xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716505734; c=relaxed/simple;
	bh=3Njgy3HT64cULMZwRwtacoh1EN0MKOziTDYCY/Q8mGc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eFhLLBFjdtfuJReQMl6ChEGZRMXuTG2vJVKLbQxx7xL9UZxanWBX96v5DgTEvYyLgSgldHRmyhIKZrJiz9Q9MvkJA/wwSMrEjEVa0BIgqXF0i8URL78r/ArNeUjf/X/nbign7zQCCh3szFk2Ek41e7NUOQB5aCIoYwOk6pYdsjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BeZFTXZz; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-627dde150d0so27912167b3.3
        for <bpf@vger.kernel.org>; Thu, 23 May 2024 16:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716505732; x=1717110532; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7BEcklPadE1UFyy77cokzYQCkNXVAh4spEZ9JW5vZwk=;
        b=BeZFTXZz0i/dHedt0hP/uM/epF+c0h3coZ9KTbauUHup/mBXCHGbKHhHvf7HOPWX3t
         qe4ncsC/5o5i2149n7h/yfPtFC2iu+L1I8Lr/e1AYlrpRMy6UoVMAyV9Q1jikmFcpcuW
         4bEDbfReCarL2pPu30zOhpUErEpqwiym7+RfJSQL/BcFt54y07E4vR57Qh+hefbHPJfZ
         cLgxBlxmJQZNd5jLRvSBxM/FN8OrTjbt4lvn1yxnPmx1rDLZyO8LhDj7ucR68GMHRu9a
         9KLXd6+jG/OWvL5dRF7gq3VqmUavoU/cyWt5Vh7jAcgWYJTqO2QsrplwVk0U5TKII7TW
         T9uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716505732; x=1717110532;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7BEcklPadE1UFyy77cokzYQCkNXVAh4spEZ9JW5vZwk=;
        b=ddN1fZhJAcgeoshroOiXl/uFVct7m44NkrvHMkTYte4imHEw2gq8SqjtHwiYkjU4GJ
         UbAq7R+wvrfPjHSVN3/IOvarVQ9JPNqIVZ6iYrACYTs5s30GYp4Y04Uatni3umok4wDr
         a780mOauhsOquiug7dK4dWDqDn/orpcjbvkPl3fMW+vq0ZcVNCVtaZRdv/BNwVlqJDYQ
         U8LoJ8C/0ctahxmD6RZ4SSa42op6WAcwkRZK94FUUfc/qdsPN8S6PA+cjUJW7Hm2wZbX
         tMJGRftfPHQiriKLdXsFvwuKWlagRyLTbE6SwR8R9sixBf4VQNL6wJ1wbGT1vt91GRuY
         ceWg==
X-Gm-Message-State: AOJu0YzwoDjjG+6CJqwALOnAEB3UF8ywZ5ZrXHAEqNrnXug8Yrn5r9In
	qsoGosw7PiV0cdq6L1J/n3T4ttsQVGCE+mJSMzau+TJTVPFIRrJpxGydmw==
X-Google-Smtp-Source: AGHT+IG5SAZBKwIx3q+Gn/PR6AkfVW/ABahSOASpmBND/X8sMQ1esmno7V6Bv8fn4FwY39IsHO1LgQ==
X-Received: by 2002:a0d:e214:0:b0:617:d864:7e0b with SMTP id 00721157ae682-62a08fb0fdcmr5843337b3.47.1716505732123;
        Thu, 23 May 2024 16:08:52 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b7f1:1457:70d4:ab6c])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-62a0a37d5d0sm474087b3.16.2024.05.23.16.08.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 16:08:51 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/8] Notify user space when a struct_ops object is detached/unregistered
Date: Thu, 23 May 2024 16:08:40 -0700
Message-Id: <20240523230848.2022072-1-thinker.li@gmail.com>
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
  bpftool: Fix pid_iter.bpf.c to comply with the change of
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



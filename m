Return-Path: <bpf+bounces-30171-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D141C8CB62B
	for <lists+bpf@lfdr.de>; Wed, 22 May 2024 00:53:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 770E5281DAE
	for <lists+bpf@lfdr.de>; Tue, 21 May 2024 22:53:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80FB8148820;
	Tue, 21 May 2024 22:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hR2u9WAJ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86143168BD
	for <bpf@vger.kernel.org>; Tue, 21 May 2024 22:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716331983; cv=none; b=nB6d/sAjwUyyNIlrTXtn97xC8n48oz4uXFCjAl62F/MdDVSBNy9KmMCr4vsW5tO1vTgksrr0mPAgt2XjsaKmU1oj1ZO6syKTvrKu7s+9f5jipuGmI0OypAhnMXUkzrZKR7mKxgIEgzT/WIWUFg5XT4j8jPbvEMqrCcp9/IFOyyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716331983; c=relaxed/simple;
	bh=5vt5uNJOvKCrJXPakyXdK5tT6pHazjb/XlrSmr99xMQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=N1+5/kp2WHOFJntSUF++0yUdaZ6th3mUJSHbtDS55RaqH/QqU+xakZPyWAB1keOKWdtjVp5jHe9EiXywDvWJg7WUTuGtlJfbaxDQrQy3BdjgIuZnUhIvtu5PyHrGXWlBRs/LULVkr2LsyBxHyHPpJWWgAkh2vGDt0C0gkozznfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hR2u9WAJ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-61be674f5d1so41230157b3.2
        for <bpf@vger.kernel.org>; Tue, 21 May 2024 15:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716331980; x=1716936780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yt6qbsNkDbFN4skJv9vyYrsyxVhc0Jxm0wzro/tcqns=;
        b=hR2u9WAJXllakI0KibxWQpd06Zkajacjb/ttboUPxqPx/b+ae5heGK7HYFsg3AEVkR
         AEJ7t4Jor4GbW+q/Oekpk9ylEMR49AJOtDWleY9XBYRltceDzqdzx8pIOK3oE0Hr18L1
         Gm9lCtfVa3HlxLDwzEhQr/Jar39O231kddixTPqicUyom9AYDNbeoHU0yCDudCO4WlX+
         hTOxPU5bJ1Wee45WQ3UgeMpaoT1MeV5fr4sgerk/eLdUE05bOVob1gZS8H3GihWi/20l
         pQUuSU4nPwpmjV0rb81qqYixvWPrcJ6az5z4bgZKnuyUrL/no5c1C9Jd/9CMZ2hpe73Z
         JsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716331980; x=1716936780;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yt6qbsNkDbFN4skJv9vyYrsyxVhc0Jxm0wzro/tcqns=;
        b=EN2n9q0qMJqH321+XAZyG+dw+d29giodcOEknuNzWoLdjhnJUCtIFRCPPSfvh6R0HR
         4i4rhKWtJ1rIVMcofkU1aAgYioTS5YNo7DCJ2XB2zn9jR/xAtABvpuRgjMcELGXD+I/1
         E4wNYGJGwVyfCxd56ntVWSUrd8AQlwIkorOrDC6DojiQz8ObjtyDNKBPSpNePwgzmvrd
         ZZOof0Mu3n6LbDicqT8w+x/ZSaSHKYfjWVZbUjjWE/wbvP9g7U/ISVnvxexsMO+6sWF1
         cQce7o6ZeztapHsgzOUASRGgGeKeRuUJScS4CTMaeLcvLdbZJ72DtWeQWBvWdZXSaTwt
         jxhw==
X-Gm-Message-State: AOJu0Yw4uhgsGD+lM85AP/RLd6ZLFrye8fD3TgKUw1ubBMJ3zrf2fkB0
	r3bl3opfjhuDwxYaOV1ABr4923nM9NiimRMCN7mmdPiN1/nyN1Tv3YOldQ==
X-Google-Smtp-Source: AGHT+IG8JiGU0oCkD+lJIc73HvkDxnnYzA54JlyvwtTVXzgo4N8S0WWfN20d9k1WVmp0Qsu8BswZaw==
X-Received: by 2002:a25:aa0a:0:b0:df4:7ad3:497c with SMTP id 3f1490d57ef6-df4e0fc3696mr556921276.64.1716331979673;
        Tue, 21 May 2024 15:52:59 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:1437:59a6:29be:9221])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-debd385be51sm5584956276.54.2024.05.21.15.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 15:52:58 -0700 (PDT)
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
Subject: [PATCH bpf-next v4 0/7] Notify user space when a struct_ops object is detached/unregistered
Date: Tue, 21 May 2024 15:51:14 -0700
Message-Id: <20240521225121.770930-1-thinker.li@gmail.com>
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

v3: https://lore.kernel.org/all/20240510002942.1253354-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240507055600.2382627-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240429213609.487820-1-thinker.li@gmail.com/

Kui-Feng Lee (7):
  bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
  bpf: enable detaching links of struct_ops objects.
  bpf: support epoll from bpf struct_ops links.
  bpf: export bpf_link_inc_not_zero.
  selftests/bpf: test struct_ops with epoll
  selftests/bpf: detach a struct_ops link from the subsystem managing
    it.
  selftests/bpf: make sure bpf_testmod handling racing link destroying
    well.

 include/linux/bpf.h                           |  13 +-
 kernel/bpf/bpf_struct_ops.c                   |  90 ++++++++--
 kernel/bpf/syscall.c                          |  14 +-
 net/bpf/bpf_dummy_struct_ops.c                |   4 +-
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     |   4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  48 ++++-
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 168 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_detach.c   |  16 ++
 10 files changed, 339 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_detach.c

-- 
2.34.1



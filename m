Return-Path: <bpf+bounces-28758-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3A3A8BDAE5
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 07:56:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9FD0A282426
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 05:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D8E36CDB4;
	Tue,  7 May 2024 05:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cL281oWv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEBE1854
	for <bpf@vger.kernel.org>; Tue,  7 May 2024 05:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715061375; cv=none; b=EK5hIsmlnmfuVO55zR6/eVkZPhnHqecTR8p1x7uc/hjMJHEdknWkyVWT8Y71mAeb3Z5kBqa/ytTsNRObuqr63hCyzhmwYYaUaMLPRLskLBsValegZ92dfmFzloqS12DH6NcLYAKHN4E0FANlsveT84tga9TnMQBBvR32kYgeTAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715061375; c=relaxed/simple;
	bh=34phiGNMxeF5dUVwHSrsbgpXMapzdfBzQH/VK+Uix44=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s3eY9egDcu7ms35a82S8ZvYSx6lK2JiZi6KP6i6YG1B6W8qPZkTr7nZKGNrd+y9Glio7/xMhQ9pykMIdZkt6sdUaq+7d4HWZruhjrmSAfAVAtyCLs1xVonlRfHiUwze0HO34ByHt/CTauUSPwMW8/aZt6RQzJ1kwLvxWmyRPE6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cL281oWv; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b21e393debso889646eaf.2
        for <bpf@vger.kernel.org>; Mon, 06 May 2024 22:56:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715061372; x=1715666172; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fkMUCiYEc11F0jT6FWM3/hL0pbBvwoEgIJNOOsj+16I=;
        b=cL281oWv1p8mroiYtjMgr6mseL7k8WIFpOFLDd0FUd4U0oUuLcTQO3Lgr4XZDB7fB4
         N6YohATwk7WOWSy5GtdPL93q/ktYtEPPhqTNJ3eDmzo2mV/8sSni+Uv8B1zkwc73nUEC
         WoWxhAzUXlYczS2ozXmmF7UmspCL/XrgedFogpAihRKAZVLx54xa2WrL4/EvJdhohjkJ
         lscK2eK/MpJBdTm+VICnWRmLxtKTypaKcNJI8VDeJJNVpwrMNjxi6roDHWl5j84UuO6U
         QXboPmmaALEv7uDlcYvGQ2ShdYJFz3neygPyJLXC6TXx1EkmWkrnmEbmWCmuLXlBYGCD
         E7fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715061372; x=1715666172;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fkMUCiYEc11F0jT6FWM3/hL0pbBvwoEgIJNOOsj+16I=;
        b=YSCNtCi3LcCssGSHB0tYBpa9LjxBsGUGQb1k3fDBWWXih09Mn3zjx2iguxLQwgBosl
         j5JD9ob3p6voNMMx562jE9enubxwwEpEzunRYGbg5jGjxFj1W91i7tjoKW/02vpVAFKX
         +e1LarRvRQDFs4I7ZGKNmhXqY28DgE7t9BqUCa2X1K3iBkqgwSXJM22bZSdqca9kTG/p
         SIWsbgENB0iiaT5NAclKUjtFEWwAmd0btcq7MnGvXAdpR6tVS52MkMGDS1PEu6UqUeHs
         0R71kbk3PBCB2XthcLACHvylufMzpJrijT2sRKEMNDQg5RmHNb3r52niSNylbH3WWKRc
         8+XA==
X-Gm-Message-State: AOJu0YynU4xqPQPMn9uFdYVmNoaKcdgmIcOZiixCSEqSDPC9BVAt4Kl2
	ZA3iv6wUK4RjGOJ7+8gyple5Wwrjfm5n3P1R62KW4ondSvJPfWLqvd+rNw==
X-Google-Smtp-Source: AGHT+IEB4qvyFnJsBDZGt9EB9cNl0sUNCZUf695uRX72OhAJtA/glWYjSg0E34DPbeOrVrAs+zQVlg==
X-Received: by 2002:a4a:684:0:b0:5b2:2f55:e30 with SMTP id 126-20020a4a0684000000b005b22f550e30mr1742209ooj.9.1715061372508;
        Mon, 06 May 2024 22:56:12 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:2e7d:922e:d30d:e503])
        by smtp.gmail.com with ESMTPSA id eo8-20020a0568200f0800b005a586b0906esm2317011oob.26.2024.05.06.22.56.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 May 2024 22:56:11 -0700 (PDT)
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
Subject: [PATCH bpf-next v2 0/6] Notify user space when a struct_ops object is detached/unregistered
Date: Mon,  6 May 2024 22:55:54 -0700
Message-Id: <20240507055600.2382627-1-thinker.li@gmail.com>
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
Changes from v1:

 - Pass a link to reg, unreg, and update callbacks.

 - Provide a function to detach a link from underlying subsystems.

 - Add a kfunc to minic detachments from subsystems, and provide a
   flexible way to control when to do detachments.

 - Add two tests to detach a link from the subsystem after the refcount
   of the link drops to zero.

v1: https://lore.kernel.org/all/20240429213609.487820-1-thinker.li@gmail.com/

Kui-Feng Lee (6):
  bpf: pass bpf_struct_ops_link to callbacks in bpf_struct_ops.
  bpf: enable detaching links of struct_ops objects.
  bpf: support epoll from bpf struct_ops links.
  selftests/bpf: test struct_ops with epoll
  selftests/bpf: detach a struct_ops link from the subsystem managing
    it.
  selftests/bpf: make sure bpf_testmod handling racing link destroying
    well.

 include/linux/bpf.h                           |   7 +-
 kernel/bpf/bpf_struct_ops.c                   |  77 ++++++--
 kernel/bpf/syscall.c                          |  11 ++
 net/bpf/bpf_dummy_struct_ops.c                |   4 +-
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     |   4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  40 ++++-
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 166 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_detach.c   |  37 ++++
 10 files changed, 329 insertions(+), 24 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_detach.c

-- 
2.34.1



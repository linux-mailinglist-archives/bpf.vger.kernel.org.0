Return-Path: <bpf+bounces-29413-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AAB38C1BBF
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 02:38:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B9BBB2337F
	for <lists+bpf@lfdr.de>; Fri, 10 May 2024 00:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B98552F9C;
	Fri, 10 May 2024 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jM17N6lb"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BB01FB4
	for <bpf@vger.kernel.org>; Fri, 10 May 2024 00:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715300988; cv=none; b=su1lSgrofFJsVwYqHVvcbqJshpwr/NiIQQJFxUP+zXOk4c/I1yYzj3JnSKvOY7Q/cyk9iplVm6OjoIICuphwVprzN9uABRrFrJMGYScOTEINgt75Ao1EOGyhGOoVQ+OCSonQpVZqrzK6Q97Q9q6cz9eVbAj0KXkbSerRjz0YIcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715300988; c=relaxed/simple;
	bh=PUTcppCxMBHmFAeMDc2gFOlSOUIw21931tiusHtIOpg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lpTCRoJLmuNi7nzgRWbCLJwnjDqLlH91f4Omygyq45bV3svzp9bAaZIYgTiCZ7h0Art4fYC/236bBfWockP/cP9fQ3CKYSj+t95f/rHpxl91hOThugZBDTIN6qc3C08bBXVOgdKYbgiBlLO9//0cCNcuGoI0S4WJ/jmPpk2QmaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jM17N6lb; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c96a556006so844341b6e.0
        for <bpf@vger.kernel.org>; Thu, 09 May 2024 17:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715300986; x=1715905786; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MfpSLwqdQ073cnx33x5uSOw2/xs5QK7l4lbnFG6TEaw=;
        b=jM17N6lbMRNJweOBJykSSPTk+fu69yLokXUkCUsji4NZSHBgY1ygmO8sO1BZ2EHTSW
         8SboUo76v8GGQAwvDqwc//44vtKlqvBnWXSRu9IRdTHK9O3aHmAqe4gykSDMCSt7ctjH
         mRl4ai/ojO5FySYIKMdjpn4wxgGyH11Rvru9zan92AOJISO0+XIlLhf5reJxhnUIjd3W
         0QjMlJDsIVerfBW3+vNPcPuoucxfsrMvvV3IcC/wQg6I5M4DKIs7GA7SVqd9Qd2Yh+fq
         T8e1fJ+kWHH5iLkzDzzJvV177lOAoDhEgxwRjXfq9D0qCNPPmIL+5r/YBbHRPqwTXmqg
         gF4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715300986; x=1715905786;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MfpSLwqdQ073cnx33x5uSOw2/xs5QK7l4lbnFG6TEaw=;
        b=GaV2xttQMSW3eI8Q9PxzCvfrQEZWx357Q1Ed96mPNeZlSmtH7OH66ReCG3yUc7Gpui
         vwf7JIOWnblzhesBQsSrH1ahpfLYJqBDTDonTyYaJwWt2etlFbXelNxLS18+THZ3GpNi
         I5RMRJjEeN8bA57mj6KyC0r97xzCqaTVo4Ypb7jIJd/Q6KBOBRIXEeuBJoJN/lk+WPES
         3HoOntcoVTDbiVf0DmuyMZjbDqC5PDd4vhjcdPkX+McdV3XERimlKVR1Repjh1iKEOX9
         a6EXSlYuzVnWUWIWkfCNlPno5iXqbX/k/sLtDI+s1zBkxxBd08yceNDZwq7jegi0gZTy
         ykfQ==
X-Gm-Message-State: AOJu0YwnivLJqdf0cKF0SMDnqgBOhK/sa2+thnmL7BGU3OOMEzchczSE
	xMn7L5vOVnTi7b4d+zm8EvxHDwgQql6l6WIFN3jb8PODbOpa3M1/mp8UNg==
X-Google-Smtp-Source: AGHT+IHslC1a83XL4Rxpc3QOxK+JcjZoTdvSAq3MSQidC+P3vKQvkFuKD48A7/Y98E7WWF94ILPk3A==
X-Received: by 2002:a05:6808:1803:b0:3c3:d47b:e4cf with SMTP id 5614622812f47-3c9970bd1c0mr1592444b6e.39.1715300984825;
        Thu, 09 May 2024 17:29:44 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:66fe:82c7:2d03:7176])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-3c98fc7e00bsm433251b6e.4.2024.05.09.17.29.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 17:29:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v3 0/7] Notify user space when a struct_ops object is detached/unregistered
Date: Thu,  9 May 2024 17:29:35 -0700
Message-Id: <20240510002942.1253354-1-thinker.li@gmail.com>
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
Changes from v2:

 - Rephrased commit logs and comments.

 - Addressed some mistakes from patch splitting.

 - Replace mutex with spinlock in bpf_testmod.c to address lockdep
   Splat and simplify the implementation.

 - Fix an argument passing to rcu_dereference_protected().

Changes from v1:

 - Pass a link to reg, unreg, and update callbacks.

 - Provide a function to detach a link from underlying subsystems.

 - Add a kfunc to minic detachments from subsystems, and provide a
   flexible way to control when to do detachments.

 - Add two tests to detach a link from the subsystem after the refcount
   of the link drops to zero.

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
 kernel/bpf/bpf_struct_ops.c                   |  77 ++++++--
 kernel/bpf/syscall.c                          |  14 +-
 net/bpf/bpf_dummy_struct_ops.c                |   4 +-
 net/ipv4/bpf_tcp_ca.c                         |   6 +-
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     |   4 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  48 ++++-
 .../bpf/bpf_testmod/bpf_testmod_kfunc.h       |   1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 168 ++++++++++++++++++
 .../selftests/bpf/progs/struct_ops_detach.c   |  16 ++
 10 files changed, 326 insertions(+), 25 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/struct_ops_detach.c

-- 
2.34.1



Return-Path: <bpf+bounces-28176-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B01388B64AE
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 23:36:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 64D6328995B
	for <lists+bpf@lfdr.de>; Mon, 29 Apr 2024 21:36:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8167B184102;
	Mon, 29 Apr 2024 21:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iG2T1Zky"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B042C1B94D
	for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714426575; cv=none; b=X501uHR0QrF/TSHhZWeXcdD8/7Ouu6dmJyRLc2InhV7xHSvMCZIBJ0OsnzZ09kuCYeMlU5HUGCnBcVURdP2JFEo4mUm1kD9hHpvCx9/kxUJTHWUFwZM5WbVQ0VHjdK2u5Fy+KTaBJX8kXLwK+el3oQkDyqQtzs826qwiIdxm294=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714426575; c=relaxed/simple;
	bh=4sEaEzzVFrrf8HuHaBjHxJlK7U6EYtOLx5ntUBLILK4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g4ziQ5CnJXFiGlzVkLgBoON5czYKlxWAdGypMhCKpd/TcxDPTxocLOPqkPspG5NcKksYVAbSKo68RbMfsUwCg3SR1Ud/eQwbCAb+8Z+txn4DhNecvFq3X6BoBLdm9tQka+ujvP6xwHi8pbx7Df2qjPGnGB5CZuesdK2d3Hdmido=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iG2T1Zky; arc=none smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3c751bf249cso2879964b6e.2
        for <bpf@vger.kernel.org>; Mon, 29 Apr 2024 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714426572; x=1715031372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PEepPFWPkmO2ff6PidenZqK8+zuhRP3CrDipwwdUP68=;
        b=iG2T1Zky3Fge4ARs3+hpJ9i0xS/DqhkHei+FFE8kXL4H8MlYrRlSzn5C4f7of6uakg
         l7NZk2m5QrHoen/2pc+0FECTWQyP37wJSS4IMV8xE2nNnnB6b2KvtlRyUfDVO6n29HVZ
         32lyPmz84SBULaV0iFBHEaML4qGwlEgjcUfzS3NBWbTo577LfBXpfQ6dP95YSGhRc1NB
         9/QYJtAPZS5hd0T+9e+CqPDnW+7+lY0E2+3R9XwHoilXruIDjVSpJ+xL+MrhhaRk+5ge
         iEQ7J/RR5fwINxuqgm6ABEn1iWdBLdC7/SIrlk5up0sF2ZcUtZMMvysL1imGTPjwMyeJ
         N7lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714426572; x=1715031372;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PEepPFWPkmO2ff6PidenZqK8+zuhRP3CrDipwwdUP68=;
        b=gEog4FZTYEGd8NaIz+IG2N/t3zY3Ct/3T5+uK8l2XfNA544f7GHVpmpFVz/ePRhm3h
         jpHtY+8JnggI/1+wEFPRGTUcLCzLyo8jX/ep/jv/rmLFdkC6nfJDOxFKX0jYdnhJBjFX
         kRPgJxB8MdKBK1mx/L51oYIuXvfzuoLLiZsDRoDSwFd+YFE1zuLpxRmsy5BNTK/ugMZ4
         GEcwartjD+2Fw1by/B6Ay/fO3zfbkiz7NeQowboWMxZfwG4nLK/MaHhT0QoPfejPCFsK
         YAAj29fKuKlHyuEMsMCbug+HVYjfbXa3W1PeeHEWMtH2UwW2VTBWE932v4IaU+fcSMAZ
         5v/Q==
X-Gm-Message-State: AOJu0YwQUandJZovcw8XulAfnCZGwMoU1TN+rrl3dn+bFIWAJH67EMDJ
	08t5afGBpKcdZVvFzJtYrKW0Xh3qA87KVeimS7VzPjyYCidoN088XMbtdw==
X-Google-Smtp-Source: AGHT+IEHZt8Tp3fTqjcCOXDRTwVo8wM6V/lXZkjZfgRCNuHNLttOmw6/q+29GLt04SElysPG4E+taw==
X-Received: by 2002:aca:2316:0:b0:3c8:643b:7ebe with SMTP id e22-20020aca2316000000b003c8643b7ebemr5848693oie.52.1714426572221;
        Mon, 29 Apr 2024 14:36:12 -0700 (PDT)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:b805:4ca7:fd75:4bf])
        by smtp.gmail.com with ESMTPSA id x5-20020a05680801c500b003c8642321c9sm714034oic.50.2024.04.29.14.36.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 14:36:11 -0700 (PDT)
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
Subject: [PATCH bpf-next 0/6] Notify user space when a struct_ops object is detached/unregisterd
Date: Mon, 29 Apr 2024 14:36:03 -0700
Message-Id: <20240429213609.487820-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The subsystems consuming struct_ops objects may need to detach or
unregister a struct_ops object due to errors or other reasons. It
would be useful to notify user space programs so that error recovery
or logging can be carried out.

We offer a function for the subsystems to remove an object that was
previously registered with them. The BPF struct_ops will detach the
corresponding link if one exists and send an event through
epoll. Additionally, we allow user space programs to disconnect a
struct_ops map from the attached link.

The user space programs could add an entry to an epoll file descriptor
for the link that a struct_ops object has been attached to, and
receive notifications when the object is detached from the link by
user space programs or the subsystem consuming the object.

However, bpf struct_ops maps without BPF_F_LINK are not supported
here. Although, the subsystems still can unregister them through the
function provided here, but the user space program doesn't get
notified since they don't have links.

Kui-Feng Lee (6):
  bpf: add a pointer of the attached link to bpf_struct_ops_map.
  bpf: export bpf_link_inc_not_zero().
  bpf: provide a function to unregister struct_ops objects from
    consumers.
  bpf: detach a bpf_struct_ops_map from a link.
  bpf: support epoll from bpf struct_ops links.
  selftests/bpf: test detaching struct_ops links.

 include/linux/bpf.h                           |   9 +
 kernel/bpf/bpf_struct_ops.c                   | 186 +++++++++++++++++-
 kernel/bpf/syscall.c                          |  17 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.c   |  18 +-
 .../selftests/bpf/bpf_testmod/bpf_testmod.h   |   1 +
 .../bpf/prog_tests/test_struct_ops_module.c   | 104 ++++++++++
 .../selftests/bpf/progs/struct_ops_module.c   |   7 +
 7 files changed, 328 insertions(+), 14 deletions(-)

-- 
2.34.1



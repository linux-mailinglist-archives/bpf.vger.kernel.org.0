Return-Path: <bpf+bounces-22386-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E35F85D1C6
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 08:52:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ABA6A1C24962
	for <lists+bpf@lfdr.de>; Wed, 21 Feb 2024 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6143B295;
	Wed, 21 Feb 2024 07:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FkMuoG2M"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95E9E3A8C6
	for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708501941; cv=none; b=CHSQMq2hBRIwMJusBfj9NBafBjPVUGNILoIYdoXF6y6U6l+rMFiICUJlvmbrMru0KLst6TLSpExmFrBlWWcO/e7cyJi1wTget0HpAUGIWlE1GrfAreTUgyF0aSMWsD9qNRejt9iHrOJ4c2kFKskh5jR2UwyiwZsdXwJ+yIzaXDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708501941; c=relaxed/simple;
	bh=J5FM464XD/lvmMQdbZY0Kwx88fMPqegOFxbDYw/a7nk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bGNH8VYJ8au5uTLwwxCQHwDP88lE/CPi7WSxggF2AbSuE28SYV/NFzuGAfd0uQsoupfGGeEFF7iV8CfJdVCYxTAlo+bGDtNQQkOXayJWrI+12lCJyVuvOwEWpIdRyTulB2T6boqAw0Pgi1b11bamFUvC9Aya6kX20t2IsCHgzzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FkMuoG2M; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-607d9c4fa90so65147567b3.2
        for <bpf@vger.kernel.org>; Tue, 20 Feb 2024 23:52:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708501938; x=1709106738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=6mgcQLEz+lLkqe9lb0kZPHMv8HFoY2QibH0g6M1ycO0=;
        b=FkMuoG2Mxuvi8+cJDAlVO0fTPWuR8OWn5tlv/B+r8r3XcN9kJKsXrtW6uPucPo2Pkl
         rzkAoEy62qilF+ps/yVs3E3E7kkHLUQpRuXyevCyvnuT1irzwlDiQpTI4aryJkBycklq
         6fWIW4cqo40Qv0ZM7VOb7mh9sBepMVq8A4NGDk30go8WGJr0xub+KXQwO7/Io+/0r0dm
         9F0XIXxU1I2XDoHqvURYF+UE3HFHw47EpT35fz/5JiGyOwLqDLQoEUw8lwP9t0kcTb+h
         tW8L+74gBHSv2AjPKmNpeTobjaaKRNcmGUVzGKwnzWiI5iubnEcryWfJBaXO2wR1ZLU/
         e6uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708501938; x=1709106738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6mgcQLEz+lLkqe9lb0kZPHMv8HFoY2QibH0g6M1ycO0=;
        b=WvaKvQPUSWKr+XLYTVOuH6iXa4uLmLcKBfW6BRBj7FDLKcDDNt83Yc4b/RSRdrGRY1
         d6CDVzMas2ZRouYv5Pxx4Q5i93oSmpuyBZdSbBMyORnH5uplQ5azwBE8JrGf/o4Ijzu0
         W934QaRtboL8Ub4PqAZabCjBsO8v4YDVV9CwPcCj8ZWDVke8RfyXz74LVGur/2Rdnxpa
         87Xz8fVEhp1UyKvENXhwlDUZM9OMMkv/YuVndfiEaQJ8rgTf7mhtY4imSXmb006030dQ
         shiL+3hhRQoCFlsLMi+23MIQ9wrfF/mbQjJ+4SRdTEIMxNjDN2+QzUkNpB/ROKxVc4A3
         soyg==
X-Gm-Message-State: AOJu0Yzn7Hw3q9YttEg2XaOuwpyHXfonRWiGM3/nPpfH6Y8nFuCs8HRB
	GRtHWYVsUYqlg1VrZd/ZNUq+y3ynW5MB8MkgXKud4y87IYuUabVa8KxT0hwS
X-Google-Smtp-Source: AGHT+IF4fFYwThGXe/SCMrumrTzhBoEgpF2OX2DrROZ5AETyMbVj42qUwGEldONEU/JuPXpKtslixg==
X-Received: by 2002:a81:5748:0:b0:607:ce29:c9f3 with SMTP id l69-20020a815748000000b00607ce29c9f3mr15177999ywb.0.1708501938031;
        Tue, 20 Feb 2024 23:52:18 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:26eb:2942:8151:a089])
        by smtp.gmail.com with ESMTPSA id m205-20020a8171d6000000b006048e2331fcsm2488715ywc.91.2024.02.20.23.52.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Feb 2024 23:52:17 -0800 (PST)
From: thinker.li@gmail.com
To: bpf@vger.kernel.org,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	kernel-team@meta.com,
	andrii@kernel.org
Cc: sinquersw@gmail.com,
	kuifeng@meta.com,
	Kui-Feng Lee <thinker.li@gmail.com>
Subject: [PATCH bpf-next v4 0/3] Check cfi_stubs before registering a struct_ops type.
Date: Tue, 20 Feb 2024 23:52:10 -0800
Message-Id: <20240221075213.2071454-1-thinker.li@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kui-Feng Lee <thinker.li@gmail.com>

Recently, cfi_stubs were introduced. However, existing struct_ops
types that are not in the upstream may not be aware of this, resulting
in kernel crashes. By rejecting struct_ops types that do not provide
cfi_stubs properly during registration, these crashes can be avoided.

---
Changes from v3:

 - Remove CFI stub function for get_info.

 - Allow passing NULL prog arg to check_member of struct
   bpf_struct_ops type.

 - Call check_member to determines if a CFI stub function should be
   defined for an operator.

Changes from v2:

 - Add a stub function for get_info of struct tcp_congestion_ops.

Changes from v1:

 - Check *(void **)(cfi_stubs + moff) to make sure stub functions are
   provided for every operator.

 - Add a test case to ensure that struct_ops rejects incomplete
   cfi_stub.

v3: https://lore.kernel.org/all/20240216193434.735874-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240216020350.2061373-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240215022401.1882010-1-thinker.li@gmail.com/

Kui-Feng Lee (3):
  bpf, net: allow passing NULL prog to check_member.
  bpf: Check cfi_stubs before registering a struct_ops type.
  selftests/bpf: Test case for lacking CFI stub functions.

 kernel/bpf/bpf_struct_ops.c                   | 17 ++++
 net/bpf/bpf_dummy_struct_ops.c                |  2 +-
 tools/testing/selftests/bpf/Makefile          | 10 +-
 .../selftests/bpf/bpf_test_no_cfi/Makefile    | 19 ++++
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     | 93 +++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_no_cfi.c   | 38 ++++++++
 tools/testing/selftests/bpf/testing_helpers.c |  4 +-
 tools/testing/selftests/bpf/testing_helpers.h |  2 +
 8 files changed, 181 insertions(+), 4 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c

-- 
2.34.1



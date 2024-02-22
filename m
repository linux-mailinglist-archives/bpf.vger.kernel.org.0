Return-Path: <bpf+bounces-22481-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 35EC385EF01
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 03:12:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C919B1F22A05
	for <lists+bpf@lfdr.de>; Thu, 22 Feb 2024 02:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4639814287;
	Thu, 22 Feb 2024 02:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IO9Vua84"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56044F516
	for <bpf@vger.kernel.org>; Thu, 22 Feb 2024 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708567871; cv=none; b=Mr+LoPS2hqb/b+EvW+4RCQGe27QptxIiihL7bWD7XLjNSeTxtcUUdqpQrhMX1RON9Ofv8TPdfNQuSixRjDH1OZM+piMQKubf7WghUPxpJHtQ4Ie2OEVKwwf636pM+4g8rTwdprnbkGU3XoquCi9VFNJo3Z1NJs9MI1t2VRni/QU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708567871; c=relaxed/simple;
	bh=qfJ5Yi7vHvnQYv4pnSBpSupvyc8NfJt2cQl9iKPMBNo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ORqkydqiTJKviMrR4dKGAGDOyMehCpKbKaThj2qPP5nSQgIgqVdnLLk7K0Bfhk89OUg4Er8LkvjDA/8rCHVdFKz+BUAJf9PoBEDAVFAzXRNUd/5IguUXQgAeA+iiN6DtjW68l6X7pzXIz6Ch1/CFyE1sdFB5MVlPYW4Sj5kKcR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IO9Vua84; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-dcbcea9c261so6920837276.3
        for <bpf@vger.kernel.org>; Wed, 21 Feb 2024 18:11:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708567869; x=1709172669; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZdUp7qQwCKjpmewl4kU92y+BQG+mrQtdN36vyTXtWk0=;
        b=IO9Vua84uEYFN+GSfPxcpdYHZtxXNLiktPcwCIPnkZpwDaMHqYzHa6DX2mxhY7ocHd
         ViQN4eaY9iyfgGrogjYYzjZw8AUhMBhEPI2oQYiU2UTmg2Hz/sETl+DZLqHKWL5peqFG
         tkN7gExPEs4u+zDGI5gl20A5Vqdx09H0fb+QY3X5rR9L9IfNDwE1bIX6zG9AF+XEg8tz
         WK9co0OMp5L3AvtNhIVawV//U6AlvXMI/axDpz30tAe/R2ue4giZlrc+NjQ2a6U3eJXU
         x9w4VJIqVp4NwxEQutTZEGm8kg3vUYjpmsF4K98onpWHEP0KTZ9eE9HvIs9nwcVFwOU5
         pwLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708567869; x=1709172669;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdUp7qQwCKjpmewl4kU92y+BQG+mrQtdN36vyTXtWk0=;
        b=uYfg+dI2/qNYv946SHXji4qxkzhFbWwigNUbCLxlN2c1XNOv4R0iT3iv/2PYyfk8qF
         jqCcx1c6MA1/5pKRxQEUx9tPZG8nWYvJzXk4t3RW2wnzD5OZyG3OW5Mt/ZYN4ggpVh4F
         +7iHxmw0nGlMt66Poz8A0oidDoHyCeWC9x+HLk5zXY+wo2E6N6hvRrDWruKKk7PyxSPe
         IZ796u02mGdsAYOrET3ljEG2C5iISZ7IqVfxKi9BIktjkCiUh3XbOLcZ3AWQTlnp6MP/
         9wXhrtxZifxz76RfzASvqNL7FCRHlYxaonmOj91fxYbxN1EuQULppll8ss9tv8BxhEc3
         9WLw==
X-Gm-Message-State: AOJu0Yz5xol5g1L1Z2Y7NAgjzR9bOHKdBDV1baMNfcp4uiEmLVOlm/P0
	Av99wGQpjr6ZEkWWRHsH/nSSgwnXB+Y7Ef9w0xeVkGJ6WNYKCiUDtTkwlKdM
X-Google-Smtp-Source: AGHT+IENr8Wj5OeCO7VvbLdCtA95hBTUVy6hUb2rrdAZ816pfWYTwtB+D8s3P5cM95gFnS2YFkZDfw==
X-Received: by 2002:a25:ad0d:0:b0:dc7:49e1:2b0e with SMTP id y13-20020a25ad0d000000b00dc749e12b0emr1144346ybi.45.1708567868620;
        Wed, 21 Feb 2024 18:11:08 -0800 (PST)
Received: from kickker.attlocal.net ([2600:1700:6cf8:1240:bc3b:b762:a625:955f])
        by smtp.gmail.com with ESMTPSA id t34-20020a25f622000000b00dc73705ec59sm2613590ybd.0.2024.02.21.18.11.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 18:11:08 -0800 (PST)
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
Subject: [PATCH bpf-next v5 0/2] Check cfi_stubs before registering a struct_ops type.
Date: Wed, 21 Feb 2024 18:11:03 -0800
Message-Id: <20240222021105.1180475-1-thinker.li@gmail.com>
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
Changes from v4:

 - Remove changes of check_member.

 - Remove checks of the pointers in cfi_stubs[].

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

v4: https://lore.kernel.org/all/20240221075213.2071454-1-thinker.li@gmail.com/
v3: https://lore.kernel.org/all/20240216193434.735874-1-thinker.li@gmail.com/
v2: https://lore.kernel.org/all/20240216020350.2061373-1-thinker.li@gmail.com/
v1: https://lore.kernel.org/all/20240215022401.1882010-1-thinker.li@gmail.com/

Kui-Feng Lee (2):
  bpf: Check cfi_stubs before registering a struct_ops type.
  selftests/bpf: Test case for lacking CFI stub functions.

 kernel/bpf/bpf_struct_ops.c                   |  5 ++
 tools/testing/selftests/bpf/Makefile          | 10 ++-
 .../selftests/bpf/bpf_test_no_cfi/Makefile    | 19 +++++
 .../bpf/bpf_test_no_cfi/bpf_test_no_cfi.c     | 84 +++++++++++++++++++
 .../bpf/prog_tests/test_struct_ops_no_cfi.c   | 38 +++++++++
 tools/testing/selftests/bpf/testing_helpers.c |  4 +-
 tools/testing/selftests/bpf/testing_helpers.h |  2 +
 7 files changed, 159 insertions(+), 3 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/Makefile
 create mode 100644 tools/testing/selftests/bpf/bpf_test_no_cfi/bpf_test_no_cfi.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/test_struct_ops_no_cfi.c

-- 
2.34.1



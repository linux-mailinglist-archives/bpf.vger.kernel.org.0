Return-Path: <bpf+bounces-26521-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E4A9C8A1553
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 15:11:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 954151F222A9
	for <lists+bpf@lfdr.de>; Thu, 11 Apr 2024 13:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C68E14AD3B;
	Thu, 11 Apr 2024 13:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AjhfT1NP"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D19D22096
	for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 13:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712841108; cv=none; b=fDnudhWI7ufUnKfMprIGvxW5WPITJovTCvSSkBH+DGYL8NQDz5c4LkMarWvOrFB8ba4TWOIaqkiVXcGwIa+qG/bY3YL0q3qtUS97MYXPaWXm4Q/wBgpzHiZs9sxZ5U51klFECcDfBFfMyHxS1/yspN56Pz1I2V5lATndfGdgbN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712841108; c=relaxed/simple;
	bh=6smDoteI9WlsVsjlfehbAvBWEMOvpjgxkAN8fNrttbo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IY/jfbcQTUmWmvKAKjo7NxVkmdV3M0FDaIrLHMjaszgFY4cynXg1SIJiI264ZNENIxg2tU+DnvXPqxqnQvnJTkE8tqCxlqhk1SQGog0eK50dAMfJfnC+2srDMocUT+Z16Hs2fumxjuHQHjwki7byiduG7pqEtTYMvQD8ZFrEnrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AjhfT1NP; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-6ed0e9ccca1so4579850b3a.0
        for <bpf@vger.kernel.org>; Thu, 11 Apr 2024 06:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712841106; x=1713445906; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8qFUxgTZwvgYgysBmcSWf0ZYKzsUVSFRs29+ocUla10=;
        b=AjhfT1NPonzqnRD5Ij2EYg8wggpmH1klEAfuzXgEROpWgefYPBjyXv9xfauJvim0wO
         LeVLcYb8VBmAcyDIJ3lRXQkDoRM9Bf69bq02w/FNbgDfJxBbnIwpCQmiU5Ipg4dvyQn/
         W958ur9RK1nWRDZAAYiGe3ISrG8p5kmzpy3+tYqEssq+flmCPc7mwYeoTDNG+MTzhwl8
         6kIwHWUONwDyn5ES8Zy5brPXcJexfIQOD65zRISDPDJ3sfw/2kWkG+b3F2FZbdVB1O3f
         5kDxGxFswltxNVsbf56VEgSDD1Qc/knPXdxBXQFKQuJK0xB5aN7lYumgL0Uccrn7gZ/E
         vupw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712841106; x=1713445906;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8qFUxgTZwvgYgysBmcSWf0ZYKzsUVSFRs29+ocUla10=;
        b=iUVwxCbccJjhNYcl8NXUyjw/ITTIK7xB7MWhz+5NkkL2Lr5jXH1CoLGAywKjyzu3Ul
         B/pivB+VbFi/RsDA3GBQJCIuCHTfu5kWa3ftp+RBwI6w3WcmQeEuKiKL5CO4pEGPAhzB
         wEaEyjZNmI9UDCuwAhLrS6FL0s5IiSYYsBliVW2viv+zY4AYA6cyllC/cZ1J2EA2kZNk
         5cbgXCGqQYXsT2O/rDj7Bt1kU6GSuEj8VJENeNyA/atVvE7MABTtdHLIctKdvxVNUOJi
         hX2mhuUYBRyBkXxkf2J9dZ8wLvMeW13syMDy38Q+PrNoyYhfCc5occLwWQZ57oACO9nD
         HhZA==
X-Gm-Message-State: AOJu0Yw3vc0vcMQUDQMiUT7tqCzknu1KhxIlsb46qQPDDraY669X3hGn
	TG6jeizJe+cBDaasGY4fj9hpk3LTk+R7wKtzxFmlcjf8gnP8rTty
X-Google-Smtp-Source: AGHT+IHrDk4ktpnHaWx3vR8XKulykeQvWWvKIdmw9rT22nEw6df0c2L9bNxmoqXNQj847W8xQXpsxg==
X-Received: by 2002:a05:6a00:cc4:b0:6ea:8e89:7faf with SMTP id b4-20020a056a000cc400b006ea8e897fafmr5921793pfv.28.1712841106428;
        Thu, 11 Apr 2024 06:11:46 -0700 (PDT)
Received: from localhost.localdomain ([39.144.104.192])
        by smtp.gmail.com with ESMTPSA id e10-20020a63aa0a000000b005dc5129ba9dsm1047654pgf.72.2024.04.11.06.11.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Apr 2024 06:11:45 -0700 (PDT)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next v6 0/2] bpf: Add a generic bits iterator
Date: Thu, 11 Apr 2024 21:11:25 +0800
Message-Id: <20240411131127.73098-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, have been
added for the new bpf_iter_bits functionality. These kfuncs enable the
iteration of the bits from a given address and a given number of bits.

- bpf_iter_bits_new
  Initialize a new bits iterator for a given memory area. Due to the
  limitation of bpf memalloc, the max number of bits to be iterated
  over is (4096 * 8).
- bpf_iter_bits_next
  Get the next bit in a bpf_iter_bits
- bpf_iter_bits_destroy
  Destroy a bpf_iter_bits

The bits iterator can be used in any context and on any address.

Changes:
- v5->v6:
  - Add positive tests (Andrii)
- v4->v5:
  - Simplify test cases (Andrii)
- v3->v4:
  - Fix endianness error on s390x (Andrii)
  - zero-initialize kit->bits_copy and zero out nr_bits (Andrii)
- v2->v3:
  - Optimization for u64/u32 mask (Andrii)
- v1->v2:
  - Simplify the CPU number verification code to avoid the failure on s390x
    (Eduard)
- bpf: Add bpf_iter_cpumask
  https://lwn.net/Articles/961104/
- bpf: Add new bpf helper bpf_for_each_cpu
  https://lwn.net/Articles/939939/

Yafang Shao (2):
  bpf: Add bits iterator
  selftests/bpf: Add selftest for bits iter

 kernel/bpf/helpers.c                          | 120 +++++++++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/verifier_bits_iter.c  | 127 ++++++++++++++++++
 3 files changed, 249 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_bits_iter.c

-- 
2.39.1



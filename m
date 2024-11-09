Return-Path: <bpf+bounces-44445-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E899C3006
	for <lists+bpf@lfdr.de>; Sun, 10 Nov 2024 00:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38C5C1C20B8C
	for <lists+bpf@lfdr.de>; Sat,  9 Nov 2024 23:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 901541A2645;
	Sat,  9 Nov 2024 23:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mQaA4Eh7"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753F48C07
	for <bpf@vger.kernel.org>; Sat,  9 Nov 2024 23:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731194076; cv=none; b=fmxrtRCa3tF0/oB/9tpSgjLQRS5e6jPuxZg1b9vXh+8esHpm1bUdQw0ZOQpM836eX0LleasiWk67V/WDb8pnRAIINmvPNjk8Jh5aG/zGa4KwGacZLW0BWKw+K9gk0ybguwWefVOkzPt7euHYE4tE7eXZ8CauVOw4L7NGcuGxJAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731194076; c=relaxed/simple;
	bh=C1OgHI4WWongABcrh3kF16rSMUOSULCn/DxUvReky+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eemxxE3b2lHnI+4Z4umKdYrOdyuaMODqhIm/IEEouephO8iv86MbCZrLFdffMlaEFm5t0LgYcLHpES6Bd2TnZfIStu+ZCeX+KOhZl75XmWkQvWfXZ+4jk2pvnYtZcxcQorOIvX81Cu48W6Y7VhS2I1DSK8D9urIfbPZ4lVkfda4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mQaA4Eh7; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-37d6ff1cbe1so2521487f8f.3
        for <bpf@vger.kernel.org>; Sat, 09 Nov 2024 15:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731194072; x=1731798872; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A2uI5MTHLo/uU+qr9xm8lorh56ok7B+fQtPyYyNI0S8=;
        b=mQaA4Eh7Ylp/61vdlRYXybAcRDwFgz3I/UfBpK7vmZOdy6+kbB8FSceqg0YswO4M7J
         HirrJ8Dlp6IhEhYBDMqA/OB1/R1x766QRgzvDbi4DleFebSm3Apkity9cqPZC4qsfKTC
         R/quqGzpe6gyrUB474J6WWXGgpjjbAqoNOfAz8K089ADixdfM1OZr/zaJBEVly2SquXo
         2rmPSsaorpr/N7fhXB6PNttKDjPv9EiRoJy4E248wOjHN5Yn+u2snYnQes0JqzQJzv8M
         JpsPwqfKoyPwdb1q9B2g9NPpyLJG5Je0JV4VknEqXTKsNshDxeyx93qCA0N1LDYkfrh4
         uVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731194072; x=1731798872;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A2uI5MTHLo/uU+qr9xm8lorh56ok7B+fQtPyYyNI0S8=;
        b=aX4jpqxrgLLuGbKR3gCzYyx8gM+qKYl0vxXYkRt13qspHcPfKvPfdxewHepJTCgH0q
         vhxzPyV/1EkogKRwjbhYTFrq0DcNt+4nU7vvn+55KcqGNv6FZXbzaoAUcUqzaav7wXOP
         A3O/szOljozl41JkQPZjNtPV/OcG0Gz5P3hNfpiHVJV6sTo371iRvjGDE+9DoeaTZjl1
         OxZTbXOTOSxMs6vyhHAuhNITh4bYnazLMae09kvLZp6s7zvdTQNdMbM2CZQPzK+r7IPo
         4wUiMG3tgV5cm7xZW7XNErhK9e7GhZrMjMK5YRjP8OkYzSLg6fvpH29KUqB3+oZ8AcFY
         oWJw==
X-Gm-Message-State: AOJu0YyFnLUunVYW3hgTphb5BHAjVU9Wfq6RW4tkI6bPEBLS4hZSUj+n
	gz+GYR6iO5Ua0T9lEuNluC2cbJPLXFpESnOlkLlvmhiW5WYzDFf7Gc17N2xR9LY=
X-Google-Smtp-Source: AGHT+IFcLPMBp7qbUubq93Y0nZi8ywyLeqVqq6kd6Yn/HOLQs9FxrnL/a9XsBRjk2qcmdLKPOQ3HeA==
X-Received: by 2002:a05:6000:18a5:b0:37d:453f:4469 with SMTP id ffacd0b85a97d-381f17212a9mr7225755f8f.22.1731194072153;
        Sat, 09 Nov 2024 15:14:32 -0800 (PST)
Received: from localhost (fwdproxy-cln-115.fbsv.net. [2a03:2880:31ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c1f61sm125967895e9.35.2024.11.09.15.14.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Nov 2024 15:14:31 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v6 0/2] Refactor lock management
Date: Sat,  9 Nov 2024 15:14:28 -0800
Message-ID: <20241109231430.2475236-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1861; h=from:subject; bh=C1OgHI4WWongABcrh3kF16rSMUOSULCn/DxUvReky+Q=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnL+wOhkT/QeVKoenCEG7p+Dm5Bwo1DI3ChGQB2Vsg DGObmKeJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZy/sDgAKCRBM4MiGSL8RyiRFD/ 9A/cMfe2cATD778zn59ZiWOVNPzcwrCR9RNcwfNcSBr+RuicPH2c1pasGAbotoj2x4FAG8X80qOvtC TOq7wG/hmAQ5TFHxgapXgcrs5u0bHKP3+d0XCe40i+kfolpaoW8r1f62A1PlDWnY9RHRDzi9hmtYMg oajp6ri85G/uefp+WGH/J0jkieGMWekgkDiLJl6fZeWVC+3fs4Hb2LD0robHcygEwq/Skp6KsLPfHN xnzDGddSGfJQYkbQyKASVNc6pXSqNfOmnj5cHDTYl6TSpGjKWABBp2mbII1NvWqzlDY/wCpRasOEXZ ER50e1wiD/AF5YWjnouxBq6Y/GO9gljIrh2XW1sIUtPDU6FtKFEsFMaCxcv6bxyyqs3TrQVcR3nsqN byh2L+4Wn7fDplCGXdUjFjfaEbOf/Xb5j/GxD2GAhRn50BVQ9HDA+wCuG2/ymy0nzKLXN1T0rXgNpc RafJuGxu40ZDO19AXAdKs2uZ8EwaI4YoyTApkVvjSo3aYql3Zzedw1dNvWYTy/wC3SlqwzCayyt0AM 4AqEe4qj6UtpnaqLeZKtE3zperpNVpfK7f1O5GUC+RctI5tSpMFOXGB8abEAEXdG3aC1qSCFIBTZvr ejUyrvzUuang9YkA7EGnd+vf6rqUoxS6TN/NIH7a0SHUYzhQk3sLQzuawXEA==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set refactors lock management in the verifier in preparation for
spin locks that can be acquired multiple times. In addition to this,
unnecessary code special case reference leak logic for callbacks is also
dropped, that is no longer necessary. See patches for details.

Changelog:
----------
v5 -> v6
v5: https://lore.kernel.org/bpf/20241109225243.2306756-1-memxor@gmail.com

 * Move active_locks mutation to {acquire,release}_lock_state (Alexei)

v4 -> v5
v4: https://lore.kernel.org/bpf/20241109074347.1434011-1-memxor@gmail.com

 * Make active_locks part of bpf_func_state (Alexei)
 * Remove unneeded in_callback_fn logic for references

v3 -> v4
v3: https://lore.kernel.org/bpf/20241104151716.2079893-1-memxor@gmail.com

* Address comments from Alexei
  * Drop struct bpf_active_lock definition
  * Name enum type, expand definition to multiple lines
  * s/REF_TYPE_BPF_LOCK/REF_TYPE_LOCK/g
  * Change active_lock type to int
  * Fix type of 'type' in acquire_lock_state
  * Filter by taking type explicitly in find_lock_state
  * WARN for default case in refsafe switch statement

v2 -> v3
v2: https://lore.kernel.org/bpf/20241103212252.547071-1-memxor@gmail.com

  * Rebase on bpf-next to resolve merge conflict

v1 -> v2
v1: https://lore.kernel.org/bpf/20241103205856.345580-1-memxor@gmail.com

  * Fix refsafe state comparison to check callback_ref and ptr separately.

Kumar Kartikeya Dwivedi (2):
  bpf: Refactor active lock management
  bpf: Drop special callback reference handling

 include/linux/bpf_verifier.h                  |  40 ++---
 kernel/bpf/verifier.c                         | 165 ++++++++++++------
 .../selftests/bpf/prog_tests/cb_refs.c        |   4 +-
 3 files changed, 123 insertions(+), 86 deletions(-)


base-commit: 163ea3dec3c8048618f561a2c3b30f4c5795e991
-- 
2.43.5



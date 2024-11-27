Return-Path: <bpf+bounces-45729-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596469DAC21
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 17:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A839281328
	for <lists+bpf@lfdr.de>; Wed, 27 Nov 2024 16:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D229C200BB2;
	Wed, 27 Nov 2024 16:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nz5mlqxl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com [209.85.128.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD98825760
	for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 16:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732726731; cv=none; b=DkCtB0HhwblCCozBjiFAbW5X+puqZ8W/Tb+cP2ozgXhLuiYPqbSk4fJg6VMS3xNC3gXKubRK9jtn6e+RVMT+JmVpK7R0eWWYtXmEKqJgpco6oeftuA9srRHonyVtdYTnWawZd13ZhkUBL4RLwUcoJpFzIsn0ud7MagvKJwauuzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732726731; c=relaxed/simple;
	bh=5OIvTEMVDeopt4wdFcvC1CMRToFX3prlmcwk8KsylL8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cOi7Ty0K4H/HKAQEL09vt9yD2toPWm0IMha811Mg8IVJklAU7CxwU/dwhTQo+uOBrk88KehR1XNJn4v6y06WTQhbI376ng3ddjIB62NEDCpOa7Sg1cu36OYFU+blxH9scyC3vqU/N7RpCzVmaaFTzEqy/5hNvq5T2uWEoTNNPBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nz5mlqxl; arc=none smtp.client-ip=209.85.128.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f67.google.com with SMTP id 5b1f17b1804b1-434aa472617so9177735e9.3
        for <bpf@vger.kernel.org>; Wed, 27 Nov 2024 08:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732726728; x=1733331528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xfDIjep6GWQY4rVg7t30pwM3wd/4L7y7zGdXP4gU7ao=;
        b=Nz5mlqxlg/T/y/8/PHKpqCdarHmHSdwue2CZrFDF+KULCKIOgNROVwUJseyiPM5VR4
         A/m8Jn7x2fJs/O/kM3XF1tJc0jtLJSAT9J57NCYNS6av0/W3qmNVInDkj7+38cD3xCUc
         gAgYMen2a7Syta5hCLMujAn9a5OFC4QQ4MUUKgJ3RU+jMb1XrzRqjK4sjItmV3gGzogS
         9tQFQb4a6/rp2i7f//2OGo29+kBGLqAhQDaNvQ9JjgpQ/MJNLa6KupKWI/a008J4Y++G
         aNr233zJ3UPu7tsVq1WlSekWbuJ7xemVVx0elz2P9lj2YuXX19JdT9O7DkVu98SHF+nb
         cgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732726728; x=1733331528;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xfDIjep6GWQY4rVg7t30pwM3wd/4L7y7zGdXP4gU7ao=;
        b=sYvGqcJw7YHXyHXHN7f7b1E+2grG4mWHVwV2q9WMvx40UE0ylTCcsLdjuBANVmzDG+
         vheKEf7ts1FuENzU37OmIDpG91J8YS5DsGG9/aks6UF8CVq8kwWo8FwJ9HbS/7xDJJDQ
         9EB83JSsIRFw0vFaSXerW9W0SFZPGnwNK8yxnxNwHw5FiRkr53jgoGXgxVnD73J9qRzn
         2CdpY3cl/tNIOAxoJ1mrbS/voAONncvmEyx/z5zg0O+qAY3GRGKGJqoZGlCfNNL/IcsN
         /FPe2x/JoPW7DVr/JdgLwQ28PBD/Bj+Ylk2g5HV5/7YbL53hVZlgKFq8pJxcsFIRrYkM
         toQg==
X-Gm-Message-State: AOJu0YzpAXbtLAU+Om8r0iJ5jx2Cgm0vmAd+db7YRGZ+tvrXP+rZaYZU
	Ieqy82nJmhMbskCBRjLe48i2S1qTvIDg7vC7vG0yeb3h02pHNwRhjeoivnyEbKY=
X-Gm-Gg: ASbGncvxbC80/FDh6VUs21eVy/VNhbTvumIy5+JXtmYeeEFNH3r+YqDEoRJ+7dBK8EG
	R7BNtPh6/6vpGd0Dlzmf5BRoLcsLoNatxHC6OE1RCC+jQU69r0FIZrrqnfma4lGZhfARkr0EjhD
	Yq+ed60HO6AcI+sGTXB9HvWbJqX582ZQYADV1pzJ6eB4xfIdHMHNiw6ubKbVL8Cw5bDXXboTNwK
	t3ubuRzVP8xWUU/2hvin8LMhphkNjnb9maTo8kbCqJ8nD5yKZu9DLpHWZbgPXfKrP1LMINuriKY
X-Google-Smtp-Source: AGHT+IGeACiFTxPxMmBkkI/jTonACttmLZnFlxWO7ukgZC9v4BYde9nOuwg4BO/oBLgIFOrYCU8ftg==
X-Received: by 2002:a05:600c:3546:b0:434:a83c:6a39 with SMTP id 5b1f17b1804b1-434a9db7b5bmr40930115e9.3.1732726727434;
        Wed, 27 Nov 2024 08:58:47 -0800 (PST)
Received: from localhost (fwdproxy-cln-007.fbsv.net. [2a03:2880:31ff:7::face:b00c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385c89fe5dbsm1809967f8f.102.2024.11.27.08.58.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Nov 2024 08:58:47 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: kkd@meta.com,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kernel-team@fb.com
Subject: [PATCH bpf-next v3 0/7] IRQ save/restore
Date: Wed, 27 Nov 2024 08:58:39 -0800
Message-ID: <20241127165846.2001009-1-memxor@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3260; h=from:subject; bh=5OIvTEMVDeopt4wdFcvC1CMRToFX3prlmcwk8KsylL8=; b=owEBbQKS/ZANAwAIAUzgyIZIvxHKAcsmYgBnR0+4BBzmTQb3ZlfSBjbWx5gmY0GHz3oBzpe4hqyL 1zHqEHGJAjMEAAEIAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZ0dPuAAKCRBM4MiGSL8RyteXD/ 4kYi7Xlc5dn/emKwuEQmuMPN54jIX7/04sbVTq+ShUnq4eO70Zb6RvL1NlghIsrL15FcLIeSBC7I5K GRYDLVK763dLAiWB7v5BnsfE00bhYvcxkD4z7/Fjnp1/lkLRBdo+JOCp/pwUCyW5TyR7jE2G6iMFGI clJHZIn1RtZ+kuoFheZETWROh2hPnlQephdkJViBP9TjuQUq1ACy95r+pSInJkaqU2wrmDNx7o3DaC ZH8EZmknLSn1HzKjMxtcjO5XfsgF2e3/lf6DoET4iUEhp+ERopg02tQzlbHD0a8oqY8aR9IP6DQd1B XPX/E1dx2RSVOMsGvy/8aC8SGV5xL1vBoeRMEYwO+zckQrsz3ECm/jZNFgJY0/yA7JeGqi/yLJoD5s 9XNAlE/TLp7WewIM/DntjxXA6nnKOpYUPV/q5Jmu/cj8je1ciXbC3PwCruoK14h9JNAACBg5W7c65E P29f6T5oPz0QSZBHgDf8LhuvNKAIRiKNFz/zxtJ3PHgrL050kOg6ChCTv4362q6azsToIeyS7Dioc0 hiA9SqW8DizPvMuK8EJNcpbfxCiXkumYJ8/nIzoySk/UCHHxgV+FpwE3eb2uyArlSfFT/ExBLdAias 9V8AG77N1KYmfb29BRp1iiMuxqla5U55faP+eGcx2/5IaJlpz5axZgzFskJQ==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

This set introduces support for managing IRQ state from BPF programs.
Two new kfuncs, bpf_local_irq_save, and bpf_local_irq_restore are
introduced to enable this functionality.

Intended use cases are writing IRQ safe data structures (e.g. memory
allocator) in BPF programs natively, and use in new spin locking
primitives intended to be introduced in the next few weeks.

The set begins with some refactoring patches before the actual
functionality is introduced. Patch 1 consolidates all resource related
state in bpf_verifier_state, and moves it out from bpf_func_state.

Patch 2 refactor acquire and release functions for reference state to
make them reusable without duplication for other resource types.

After this, patch 3 refactors stack slot liveness marking logic to be
shared between dynptr, and iterators, in preparation for introducing
same logic for irq flag object on stack.

Finally, patch 4 and 7 introduce the new kfuncs and their selftests. For
more details, please inspect the patch commit logs. Patch 5 makes the
error message in case of resource leaks under BPF_EXIT a bit clearer.
Patch 6 expands coverage of existing preempt-disable selftest to cover
sleepable kfuncs.

See individual patches for more details.

Changelog:
----------
v2 -> v3
v2: https://lore.kernel.org/bpf/20241127153306.1484562-1-memxor@gmail.com

 * Drop REF_TYPE_LOCK_MASK
 * Add kfunc declarations to selftest to silence s390 CI errors

v1 -> v2
v1: https://lore.kernel.org/bpf/20241121005329.408873-1-memxor@gmail.com

 * Drop reference -> resource renaming in the verifier (Eduard, Alexei)
 * Change verifier log for check_resource_leak for BPF_EXIT (Eduard)
 * Remove id parameter from acquire_resource_state, read s->id (Eduard)
 * Rename erase to release for reference state (Eduard)
 * Move resource state to bpf_verifier_state (Eduard, Alexei)
 * Drop unnecessary casting to/from u64 in helpers (Eduard)
 * Add test for arg != PTR_TO_STACK (Eduard)
 * Drop now redundant tests (Eduard)
 * Address some other misc nits
 * Add Reviewed-by and Acked-by from Eduard

Kumar Kartikeya Dwivedi (7):
  bpf: Consolidate locks and reference state in verifier state
  bpf: Refactor {acquire,release}_reference_state
  bpf: Refactor mark_{dynptr,iter}_read
  bpf: Introduce support for bpf_local_irq_{save,restore}
  bpf: Improve verifier log for resource leak on exit
  selftests/bpf: Expand coverage of preempt tests to sleepable kfunc
  selftests/bpf: Add IRQ save/restore tests

 include/linux/bpf_verifier.h                  |  19 +-
 kernel/bpf/helpers.c                          |  17 +
 kernel/bpf/log.c                              |  12 +-
 kernel/bpf/verifier.c                         | 531 +++++++++++++-----
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/exceptions_fail.c     |   4 +-
 tools/testing/selftests/bpf/progs/irq.c       | 397 +++++++++++++
 .../selftests/bpf/progs/preempt_lock.c        |  26 +-
 .../selftests/bpf/progs/verifier_spin_lock.c  |   2 +-
 9 files changed, 863 insertions(+), 147 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/irq.c


base-commit: c8d02b547363880d996f80c38cc8b997c7b90725
-- 
2.43.5



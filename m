Return-Path: <bpf+bounces-53699-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B29A5899A
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 01:13:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 27BBD3AB331
	for <lists+bpf@lfdr.de>; Mon, 10 Mar 2025 00:13:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E416E28F5;
	Mon, 10 Mar 2025 00:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jWDlsxjC"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F3C4C98
	for <bpf@vger.kernel.org>; Mon, 10 Mar 2025 00:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741565625; cv=none; b=N94qRfpFcZJWbnt6UEx9sT29kbJC0np+wpsnfngdCv5Tpi/dtMPh1GSKzKq5nHKj13aibBhgi9/WAaaL2Yl+m/g6p7PYvZPKteay7mKApwTNN3YwmEsxbcQoeb97kas0aocjixOdJL5AetM8f4eVXXnx9u9BRDaKeUhDBOfu6kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741565625; c=relaxed/simple;
	bh=h5aFRyflRTOMsyY1bZbuDVwJmte2sfwamiIksHGmmw4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GTHIgu4hqWFOaKP6f8zUiA5iC/1tmMf/ti3ChtPFj9ShUbfEldbXkMCR7EE+zXRPFXBp9hRv4K05H+YN6YfnK6vqOTABk6QwjWDVjuAQ2jrMTAzhmUIh0TQbbk0elZX22e39jmD8r5DUbrRPrb+lq/+SNlmRi28i8YUkNQSAPDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jWDlsxjC; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-3912c09bea5so3010169f8f.1
        for <bpf@vger.kernel.org>; Sun, 09 Mar 2025 17:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741565622; x=1742170422; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Raboxj8ViG9HbSTDYW+5GKum0UVYOjGW3AwSA+OHO1Y=;
        b=jWDlsxjC0YIryg0h5JPLcpOOg2+O0RhH+uWfDB6oUH8M7xwfqsrAUq8jiL5U+iwJ3H
         /IR2lOEm3KPim6VlGkZBQ36s6A6k5SWAGNhqbSaE9wV1dSaW0qdTwdhhSTAy1vkOu3hX
         amCKbbBzfo4jwBAGrSaG7S5KaCC4aSnJClbQakeEQnW3jjn2etIx8sdC9n+xEWnSdRVb
         b2cmsQ7muksJRaiUGynVgPv+9/ZLH3KaBh6fbIx2zyJZpN/SGS5HsMzFXPmJElPCH3i3
         LOwGIGksB/AsbyslNtuyjKpJ982ENyyFY8t3uULrvqT+gvUGCBgrgxRhND8sCi7lixBn
         FXYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741565622; x=1742170422;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Raboxj8ViG9HbSTDYW+5GKum0UVYOjGW3AwSA+OHO1Y=;
        b=ZAib7Y7qREpxeRFCN4sXuDZGDxznlT9nT9+zd9+csbsMEc2/NaU1QLvBwuNODxqi+S
         rCMIMS9TI2YAhbyamJphBDr1iRav8dF7MgFG8odia4YOLEgmOHBzhvaZNw+Ih/vqr8fe
         RZfzawr19XipQbp9lN/BVaFHWa+Vjst1r3hpUCsDFKdd79Ik5EZEHWPpk0KWLm3rIK/z
         26SzySUlFpLmN/b615wP53K8U/PukJdXdMWlf7giNK3znp4ccfjTjEQALcWcM0emES0k
         M4sFi56g2gA2b9IcmXAFbzZfFZgRJ0fP+xJvqZ/MocZMhaZitX/fZ0eVy2TN/J1MyqLE
         2gow==
X-Gm-Message-State: AOJu0YycHO+OYkIAq7QbGWFErHaaoiGrd5PbK1Mi0oiwOZDbb61liaZE
	0QKqqbwplIaJ+sJtcMU2QeOwwCKIQK1c2N4FOfUcDgd5IIye3KIcnCZNsw==
X-Gm-Gg: ASbGnctD+ajANcxx3VPNCbmnVV1ShHGQ729ElnOYwuug6cc5Hi/sVEimWOUwITtBuPF
	BhbVlSQ+oK56eYoAHfUWZOz97Y+pDp4S8kmITqdmYrb0s80xYpCO/MNtNHhe2i7I1RJhrHlfqnx
	SvJuo0Dkp2cHk6Qlhs34rq2VcoYiSpiMHF6Ygv++GsUKuBZYpLsUHgxwN1pdimOrVofXHOZUHKb
	wrPvM98f2drSsG893Pd3I/JGlM+hiq3OV9Jy9l7ReHupqC/HpEPY3H8OglK7dTI/NV8+AHfFuU4
	BoJmfs1iKZRqgt7mqnQk/5H0TEhe0f5y/8fBhkq/0AHJPGb2gJdY5B2RGI5UwqcgpTCyThW4AoK
	tmJ8MZFsnEQ/GkZ+zuhn6UhH+VsB5IU/tAIoEsmT8p4pIIw1ylg==
X-Google-Smtp-Source: AGHT+IEGfrBUmTGnQCFW9itVvZs/E+Okql7Hchav2CwzKeiH8k3+SsSTupRWMKCKlnoHJSIUWZjZwg==
X-Received: by 2002:a05:6000:1846:b0:390:f6be:af1d with SMTP id ffacd0b85a97d-39132d98ae2mr6922292f8f.41.1741565621901;
        Sun, 09 Mar 2025 17:13:41 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912bee262esm13181050f8f.0.2025.03.09.17.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Mar 2025 17:13:41 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	yonghong.song@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v4 0/4] Support freplace prog from user namespace
Date: Mon, 10 Mar 2025 00:13:15 +0000
Message-ID: <20250310001319.41393-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Freplace programs can't be loaded from user namespace, as
bpf_program__set_attach_target() requires searching for target prog BTF,
which is locked under CAP_SYS_ADMIN.
This patch set enables this use case by:
1. Relaxing capable check in bpf's BPF_BTF_GET_FD_BY_ID, check for CAP_BPF
instead of CAP_SYS_ADMIN, support BPF token in attr argument.
2. Pass BPF token around libbpf from bpf_program__set_attach_target() to
bpf syscall where capable check is.
3. Validate positive/negative scenarios in selftests

This patch set is enabled by the recent libbpf change[1], that
introduced bpf_object__prepare() API. Calling bpf_object__prepare() for
freplace program before bpf_program__set_attach_target() initializes BPF
token, which is then passed to bpf syscall by libbpf.

[1] https://lore.kernel.org/all/20250303135752.158343-1-mykyta.yatsenko5@gmail.com/

Mykyta Yatsenko (4):
  bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
  bpf: return prog btf_id without capable check
  libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
  selftests/bpf: test freplace from user namespace

 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/syscall.c                          | 25 ++++-
 tools/include/uapi/linux/bpf.h                |  1 +
 tools/lib/bpf/bpf.c                           |  3 +-
 tools/lib/bpf/bpf.h                           |  4 +-
 tools/lib/bpf/btf.c                           | 15 ++-
 tools/lib/bpf/libbpf.c                        | 10 +-
 tools/lib/bpf/libbpf_internal.h               |  1 +
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +-
 .../testing/selftests/bpf/prog_tests/token.c  | 97 ++++++++++++++++++-
 .../selftests/bpf/progs/priv_freplace_prog.c  | 13 +++
 tools/testing/selftests/bpf/progs/priv_prog.c |  6 +-
 12 files changed, 159 insertions(+), 20 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/priv_freplace_prog.c

-- 
2.48.1



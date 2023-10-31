Return-Path: <bpf+bounces-13689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD5C77DC678
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 07:23:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E738B20EED
	for <lists+bpf@lfdr.de>; Tue, 31 Oct 2023 06:23:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A953DF6D;
	Tue, 31 Oct 2023 06:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H34Bxbxy"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD8B33C4
	for <bpf@vger.kernel.org>; Tue, 31 Oct 2023 06:23:44 +0000 (UTC)
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FFB9E4
	for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:01:08 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1cc30bf9e22so21709385ad.1
        for <bpf@vger.kernel.org>; Mon, 30 Oct 2023 23:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698732007; x=1699336807; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ceDh1cKdWAOGY8e/9yNlJsDhemfIbrVzdDc5cnL3l2c=;
        b=H34Bxbxymdk7krH1NMteylYRs767xqRvwppYW2Qu0daxxMmeQ4OX9m3jLT24NFw1t7
         HvzOlsazIlaQR0KFpKenJe4XykuEEb2PvFVQBeLJVIJ89kryiiZCwjiOvy54oNTCfXf0
         sMUNCfYWJEDX0Fg/P6YPpBgOh7GKk89RXVe2rh+qV9SHGBysHGfcFLKNfM5hOLScZi9W
         xmjUcM4D7I6GhbtcxVnzdeLwMEIg+KPsTOBwMzErMXdlKg6dTOH1x7iDiaxL3xSQgvPB
         7KT+vA6C/7oFw2GLXxyofCmL7N9/Y1gZ0BDmVsYIAWKoKjPgo0PV+WZGIW4sOgiUYg4L
         1X/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698732007; x=1699336807;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ceDh1cKdWAOGY8e/9yNlJsDhemfIbrVzdDc5cnL3l2c=;
        b=UwTHt9Y2elNXlm6RFpVaGE0+hXGDnGcy9zJfMofpix/XskBnNYTGLR4s6/AyskZEWe
         X5gphmceWTBXfVPSYZz/mFbb9t7lTWRzfSN/gYm7ei0b10bPcWMJz3gbAVPsApeqIfss
         LaQRk4ueC+l4iD/JYc/m8lkkppsShOM1IaJdhePdXTcBzNihqAcHGKX5wHIexG0EF20b
         ST9jX0VlwS41eUESqE6LGCRFyBl02sN7mA7Kov5Zwrrn72Mmag3a/AIYTdzVoOr9yd4U
         SahUWkHv/KwgCIZotqKrpaJVFhJdSh3KjoRY9h5p42/7ji6l7GGLWurZVcnoJWWxLlbZ
         Jt3Q==
X-Gm-Message-State: AOJu0YzjpS51mT3R2feHs5aN4BO0M7DrPEONrugjeA3a17BNpcUW4sn6
	KxF7TPT0qYcw0jEYgUNvfa1bNIbJBbfEQA==
X-Google-Smtp-Source: AGHT+IFO7O9fOFN9h4Sz8YPC58JK03lqn7p7x5NeZkpOnMInE/cW7vTInMknei1MCovovpOyGd86jQ==
X-Received: by 2002:a17:903:2347:b0:1cc:5029:e3d4 with SMTP id c7-20020a170903234700b001cc5029e3d4mr2282899plh.23.1698732007173;
        Mon, 30 Oct 2023 23:00:07 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id x5-20020a170902b40500b001cc50f67fbasm460683plr.281.2023.10.30.23.00.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Oct 2023 23:00:06 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	keescook@chromium.org,
	luto@amacapital.net,
	wad@chromium.org,
	hengqi.chen@gmail.com
Subject: [PATCH bpf-next 0/6] bpf: Add seccomp program type
Date: Tue, 31 Oct 2023 01:24:01 +0000
Message-Id: <20231031012407.51371-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patchset introduces seccomp program type which can be
used to attach to the existing seccomp framework.

The motivation is to enable sharing of seccomp filter through
bpf prog fd and bpffs. With this in place, we can eliminate
a hot path of JITing cBPF program (seccomp filter) where we apply
the same seccomp filter to thousands of micro VMs on a bare metal
instance.

This also allows us to write seccomp filter in an intuitive way,
see selftests for reference.

Hengqi Chen (6):
  bpf: Introduce BPF_PROG_TYPE_SECCOMP
  bpf: Add test_run support for seccomp program type
  seccomp: Refactor filter copy/create for reuse
  seccomp: Support attaching BPF_PROG_TYPE_SECCOMP progs
  selftests/bpf: Add seccomp verifier tests
  selftests/bpf: Test BPF_PROG_TYPE_SECCOMP

 include/linux/bpf.h                           |   3 +
 include/linux/bpf_types.h                     |   4 +
 include/linux/seccomp.h                       |   3 +-
 include/uapi/linux/bpf.h                      |   1 +
 include/uapi/linux/seccomp.h                  |   2 +
 kernel/seccomp.c                              | 142 ++++++++++++++--
 net/bpf/test_run.c                            |  27 +++
 tools/include/uapi/linux/bpf.h                |   1 +
 tools/include/uapi/linux/seccomp.h            |   2 +
 tools/lib/bpf/libbpf.c                        |   2 +
 tools/lib/bpf/libbpf_probes.c                 |   1 +
 .../selftests/bpf/prog_tests/seccomp.c        |  40 +++++
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../selftests/bpf/progs/test_seccomp.c        |  24 +++
 .../selftests/bpf/progs/verifier_seccomp.c    | 154 ++++++++++++++++++
 15 files changed, 390 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/seccomp.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_seccomp.c
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_seccomp.c

-- 
2.34.1



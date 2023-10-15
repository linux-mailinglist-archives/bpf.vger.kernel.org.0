Return-Path: <bpf+bounces-12241-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E9BF67C9D01
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 03:47:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 726B7281667
	for <lists+bpf@lfdr.de>; Mon, 16 Oct 2023 01:47:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B83417D4;
	Mon, 16 Oct 2023 01:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YA4fFmc5"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D7F81369
	for <bpf@vger.kernel.org>; Mon, 16 Oct 2023 01:47:25 +0000 (UTC)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB043DF;
	Sun, 15 Oct 2023 18:47:23 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6b5cac99cfdso1525847b3a.2;
        Sun, 15 Oct 2023 18:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697420842; x=1698025642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hSKqSeuO60jQ7suM+oaQb4M4uYV7/Tl47jargmSs7Lg=;
        b=YA4fFmc5MhQGHEiS/MMMICIWHzS6Ze0W4gWwhDswvVd8UxzXyS1An2lxv/NRmCHSBX
         e6KchBDveTRzxhwq+vb7sNbSnuzlMJwqmdQwV6dDhREPlW8KqN4o/Llu4n0ZopgEFrFw
         ptTpVuR+smmYOQe/hrfeoXzkZ37EgN1T+P0bo7QkZ9AyEPfGmiG1YRFfmQkT9u6Jyhbi
         bi8KrS05pfcHCfBZ3KwNZNTjwbMN5D/mTQ/MZvDFJIxXoW4jZSQhfixUjGMBLobSQcdE
         ln6iEjLiFuH9rb+/XLtPw6Mm6kthE++5IWi0XMrHxNO6D41HPXkb+LytS8GNf4jHZgTs
         9Mgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697420842; x=1698025642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hSKqSeuO60jQ7suM+oaQb4M4uYV7/Tl47jargmSs7Lg=;
        b=E1Ew9xblItQd2xseQZuMg8HBwkwhNxfV7GG4pIZeF89g8ZhRjHFfPES4R40ZkSjTy9
         MSZ0jdf4EnieHiHifM7jjUmxzFtgh2nNTRP+VbNMukC8seQztiGAr2/I6yQaU1yyl59M
         6ofDaEOJPPrBzTgAR6NbX09alVlyjSEMfW4pnBb5vLmZqjT9daJgcOKyoSLJ8W46/mea
         Wu93vbS8thovpkBgtJex6BAr8qtWy7iS8waasEkmtvQg6G5RVIfNqE7QQeHT5lT5xLOz
         Gz40/FZUIHElV10qUGXa5bUe70i7kusKCTulXhNMT296RBErm93jOMjwC6L7AkVqYQPJ
         qUxQ==
X-Gm-Message-State: AOJu0YwrhL57Hc7wkNbu5TJekwHbDhn0yfSuU3TT20OvRgGjWM4W/4e4
	SnL8ipxIlBxf4Wh9OZXYvChVsJZ4ngzzUg==
X-Google-Smtp-Source: AGHT+IHMLIF7rf9pjwvioYRBIuzk2M7M+m2yoct3aQ1m26SK20BmGGAdrlyq5R3YgkSSwNphyVxj/g==
X-Received: by 2002:a05:6a20:9152:b0:14c:5fa6:e308 with SMTP id x18-20020a056a20915200b0014c5fa6e308mr29271328pzc.43.1697420842494;
        Sun, 15 Oct 2023 18:47:22 -0700 (PDT)
Received: from ubuntu.. ([203.205.141.13])
        by smtp.googlemail.com with ESMTPSA id pd17-20020a17090b1dd100b0027cfb5f010dsm3574377pjb.4.2023.10.15.18.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Oct 2023 18:47:21 -0700 (PDT)
From: Hengqi Chen <hengqi.chen@gmail.com>
To: linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Cc: keescook@chromium.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	luto@amacapital.net,
	wad@chromium.org,
	alexyonghe@tencent.com,
	hengqi.chen@gmail.com
Subject: [PATCH v2 0/5] seccomp: Make seccomp filter reusable
Date: Sun, 15 Oct 2023 23:29:48 +0000
Message-Id: <20231015232953.84836-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

This patchset introduces a new operation and a new flag
to split the SECCOMP_SET_MODE_FILTER process into two steps:
load filter and attach filter. Thus we can reuse the filter.

The new SECCOMP_LOAD_FILTER loads the filter and returns a fd
which can be pinned to bpffs. This extends the lifetime of the
filter and thus can be reused by different processes.
With this new operation, we can eliminate a hot path of JITing
BPF program (the filter) where we apply the same seccomp filter
to thousands of micro VMs on a bare metal instance.

The new flag SECCOMP_FILTER_FLAG_BPF_PROG_FD is used to attach
a filter which is loaded via SECCOMP_LOAD_FILTER and represented
by a seccomp bpf prog fd. The fd is either returned from
SECCOMP_LOAD_FILTER or obtained from bpffs using bpf syscall.

Change logs:
  v1 -> v2:
    - Add a flag to attach filter from fd
    - Update selftests

  RFC -> v1:
    - Addressed comments from Kees
    - Reuse filter copy/create code (patch 1)
    - Add a selftest (patch 4)

Hengqi Chen (5):
  seccomp: Refactor filter copy/create for reuse
  seccomp, bpf: Introduce SECCOMP_LOAD_FILTER operation
  seccomp: Introduce new flag SECCOMP_FILTER_FLAG_BPF_PROG_FD
  selftests/seccomp: Test seccomp filter load and attach
  selftests/bpf: Skip BPF_PROG_TYPE_SECCOMP-related tests

 include/linux/seccomp.h                       |   3 +-
 include/uapi/linux/bpf.h                      |   1 +
 include/uapi/linux/seccomp.h                  |   3 +
 kernel/seccomp.c                              | 170 +++++++++++++++---
 tools/include/uapi/linux/bpf.h                |   1 +
 .../selftests/bpf/prog_tests/libbpf_probes.c  |   3 +-
 .../selftests/bpf/prog_tests/libbpf_str.c     |   3 +
 tools/testing/selftests/seccomp/seccomp_bpf.c |  44 +++++
 8 files changed, 197 insertions(+), 31 deletions(-)

-- 
2.34.1



Return-Path: <bpf+bounces-40276-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 88E0F984F71
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 02:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03D4E1F2456B
	for <lists+bpf@lfdr.de>; Wed, 25 Sep 2024 00:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525584C9A;
	Wed, 25 Sep 2024 00:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="no1+9ZKh"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E02EEEA5
	for <bpf@vger.kernel.org>; Wed, 25 Sep 2024 00:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727223753; cv=none; b=WqrptLM3ETF6dPGCV7/mKC1u87QBOAcd0hOMRpTyxBzrFvZtxJuBhB5v/OXkrPMmlJIg9JfU/WyrlUBxLffj/iOYNegx6Fsxmkz8nJ/0+HT1k0hJvxWgsozLxJEzKqfowXU9QY6Tzcw1EK3OhQMxjwiuvU7bwXRc+WrgF49diLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727223753; c=relaxed/simple;
	bh=fb6BJqvG21k76ifXT3Dtb/2RVKxTbL6Z13914yS7WRo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJhYSvEtXlcTyd5fHQf29e3xqrkVrWOVN7b90Whl/tSF/L+FM9RUwt3ZFK3Kya22kuJyv8p2oEgiZ3kOqSLEeCJTfikvLz31BgXWazhqUSccCXN+ox7znunjRrQ0Jx43BsNAR2yBrQLSn/nOvIgJDjZj616KjZcyWDSvq2wgwOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=no1+9ZKh; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3e042f4636dso3650400b6e.1
        for <bpf@vger.kernel.org>; Tue, 24 Sep 2024 17:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727223751; x=1727828551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Pm4QOfNFQFLyxHFeubpA1n1fXQNCEbh3QGQrQIOsSQc=;
        b=no1+9ZKhy2A8AYyI+oumPNYlH8XdUmMkMOTDD1vustmXrCAIsd6VzATZxkhd1pvD2R
         255vCTrS1ZuB6cUH1ByZRx2FH7p4xjoiLa/P9f2OdPtfQc53GmPHVAPMviunaimBb+3m
         VVCYn8rqDnp22Xz/wnVDYAL6CdZ/vsfNVSizRN2+JbkHZhgYMW2XsYpxrzCByvyI6Mt0
         FPAHxi4a55rc2BaAXCdQWjshVZkhxUWT92N7YOdc5xLcUzKT+ItvHyTtx0sT0Gf9OMM8
         +hVmPuNsZaG7qi9OdW0AkrKjjIYHWMqjl/uh6mZwsywSCnxZOyhzG5IHzWR9KntYoqSE
         JFxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727223751; x=1727828551;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Pm4QOfNFQFLyxHFeubpA1n1fXQNCEbh3QGQrQIOsSQc=;
        b=Uk/3dUpVvwJJ32x8qaRimuH+OgZTB7jLpdLMFDm6ucLrq2nm/HBzS4Th5SrSmx6iIM
         NHFbVNOdQ6Y9u+n7tQtaVN5zVwcDKCN1DUtGh2pP/9Z26a0K3QaDG0Ec4cnn1j6gItRf
         S/iehcpitOON/fn/UngwIy6YNkgllU/ADsdFuIBkrbOp+khK5pA8WrMRAZVRSCwSsWTU
         Yyrpwx07m4/WCmBNSDQsS/PmcMU3VYaj1ZTJZ6TIE/RtdpSLaI1gEGQwQ8fva/h+Yku/
         26y7gzrOVdOEbqmH+nKet9+TBHioUojBGVODlB//rXijZKCro1vyJ9adqtyeMbvtIrFw
         87pw==
X-Gm-Message-State: AOJu0YzJLwKne7nwo0W6c6hf5bi0eL1bytu/0CVbVYUEi8pnBhP0/9dH
	0mcwCVPDFYPN/L7P1tVpFEP5Py7+f+oTJIn6nCFDtM4dK9M9KThyuXayeNcH
X-Google-Smtp-Source: AGHT+IGidvtT+NPxlzc5xIi5V/y/GSUOkYgcLnIztfGHPtZBe5o0pTuyXxO7m4q4Qgqym9dhzjhBCg==
X-Received: by 2002:a05:6808:10c7:b0:3e2:7b57:9930 with SMTP id 5614622812f47-3e29b7f3873mr793062b6e.36.1727223750691;
        Tue, 24 Sep 2024 17:22:30 -0700 (PDT)
Received: from localhost (fwdproxy-vll-113.fbsv.net. [2a03:2880:12ff:71::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e5bcfd5063sm720906eaf.27.2024.09.24.17.22.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Sep 2024 17:22:29 -0700 (PDT)
From: Manu Bretelle <chantr4@gmail.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	daniel@iogearbox.net,
	ast@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	eddyz87@gmail.com,
	dxu@dxuuu.xyz,
	yonghong.song@linux.dev
Subject: [PATCH v2 bpf-next] selftests/bpf: vm: add support for VIRTIO_FS
Date: Tue, 24 Sep 2024 17:22:10 -0700
Message-ID: <20240925002210.501266-1-chantr4@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

danobi/vmtest is going to migrate from using 9p to using virtio_fs to
mount the local rootfs: https://github.com/danobi/vmtest/pull/88

BPF CI uses danobi/vmtest to run bpf selftests and will need to support
VIRTIO_FS.

This change enables new kconfigs to be able to support the upcoming
danobi/vmtest.

Tested by building a new kernel with those config and confirming it
would successfully run with 9p (currently what is used by vmtest), and
with virtio_fs (using a local build of vmtest).

  $ vmtest -k arch/x86/boot/bzImage "findmnt /"
  => bzImage
  ===> Booting
  ===> Setting up VM
  ===> Running command
  TARGET SOURCE    FSTYPE OPTIONS
  /      /dev/root 9p     rw,relatime,cache=5,access=client,msize=512000,trans=virtio
  $ /home/chantra/local/danobi-vmtest/target/debug/vmtest -k arch/x86/boot/bzImage "findmnt /"
  => bzImage
  ===> Initializing host environment
  ===> Booting
  ===> Setting up VM
  ===> Running command
  TARGET SOURCE FSTYPE   OPTIONS
  /      rootfs virtiofs rw,relatime

Changes in v2:
* Sorted configs alphabetically

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/config.vm | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/config.vm b/tools/testing/selftests/bpf/config.vm
index a9746ca78777..da543b24c144 100644
--- a/tools/testing/selftests/bpf/config.vm
+++ b/tools/testing/selftests/bpf/config.vm
@@ -1,12 +1,15 @@
-CONFIG_9P_FS=y
 CONFIG_9P_FS_POSIX_ACL=y
 CONFIG_9P_FS_SECURITY=y
+CONFIG_9P_FS=y
 CONFIG_CRYPTO_DEV_VIRTIO=y
-CONFIG_NET_9P=y
+CONFIG_FUSE_FS=y
+CONFIG_FUSE_PASSTHROUGH=y
 CONFIG_NET_9P_VIRTIO=y
+CONFIG_NET_9P=y
 CONFIG_VIRTIO_BALLOON=y
 CONFIG_VIRTIO_BLK=y
 CONFIG_VIRTIO_CONSOLE=y
+CONFIG_VIRTIO_FS=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_VSOCKETS_COMMON=y
-- 
2.43.5



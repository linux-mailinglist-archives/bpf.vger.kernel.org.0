Return-Path: <bpf+bounces-40213-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D0D97F1D3
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 23:01:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E4D1F21FEE
	for <lists+bpf@lfdr.de>; Mon, 23 Sep 2024 21:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E837D7350E;
	Mon, 23 Sep 2024 21:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dBOcsE/O"
X-Original-To: bpf@vger.kernel.org
Received: from mail-oo1-f44.google.com (mail-oo1-f44.google.com [209.85.161.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB22C95
	for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 21:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727125277; cv=none; b=Vz/Eh1lizA3M0/GWa40t3sQPKDyMledhcIC89Y6rRjW7yuk8Zvw4WHbMIch42JqlOOT7q52d53oXPIVw3/uUo4V0rjkzIhzmi5kLYUmI0U6DWA6NjH8T4ja6aJXIY+s4A48SFgUJGLtAJQFjSUBo3HaKKF6jK0KylPmQ9Hf6gho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727125277; c=relaxed/simple;
	bh=bs4kTbP87rHryyAPZkIX7ZUogXgwyeyarnlc+A2EViU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=H9kWilY0+XpqYPxLwOBBS4YPTwumpjMSPNkyls4Pv18yqAS6u+lJ2oRQlcq3vTVF6TrTNxxhFoVQUEyLFNcYlun984f/OmgsnO9GAGmDTQZMxM+nXika0Xs6+ClL9ssiI0EPun62rHnYecy869iUXCaWEKb9Vx6h5M+ZAaa9soA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dBOcsE/O; arc=none smtp.client-ip=209.85.161.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f44.google.com with SMTP id 006d021491bc7-5e1b6e8720dso2704206eaf.0
        for <bpf@vger.kernel.org>; Mon, 23 Sep 2024 14:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727125274; x=1727730074; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ru+5aly/b3LdNDm7eG+dQil8Gp2DcZ+PRGe1nb9hD5k=;
        b=dBOcsE/OR93afmf6A/4CM5mEMrrnb3QwZQbqD5FoyUgayQg8kdikZyjYsdVXwLzgct
         hjpG4eYC+yke7IltBbYeun4oeu5Mc/5IU9FSnlv3HTNIOPxI6HkgEja7ZGNaS0EKQbzb
         YO/aU1FvqSM9x5CXTLkfQMcYW3YcTyz0V215HGul/s6DYgjbRWcKU/NNHsacTCSb19Rw
         s+N+gEdBIWvGtko1imrZ7GgAugLHpug1mxxWkUsezhuVWmDN8dpi9UqnLBU4MNXUo1SD
         gNNIZ9L9nSn/8d76XTFyo/RhGcT4Atcvqwu+pSNptRkx44AWNrzIFv0bsYv+tlUm0wJ4
         5t5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727125274; x=1727730074;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ru+5aly/b3LdNDm7eG+dQil8Gp2DcZ+PRGe1nb9hD5k=;
        b=G9wOyi+UpC8TjidpPvhTaGQ8wz05Rui9U3yZjNCTClERpfV8Tqg1DSp5dcnCnophZA
         Cv+/Lz6DEio8HryXOreFphMclNkv7K/dVSyfJhurY2jL7aTncVEn2DL2T4lWvYG13hXn
         rLY88Cq2AX3covVdUGNEiDOiVkyLMhsYj57xPEHhUwGuEoaY0157AjculXPl7U1/STng
         e4fyhoox34TR05rhHLYKjZfhRiCGxEBu4+s+RJOxJmV8vbCuFcf+PMQyaTjC9L1ZRSsU
         tsuLUpPvKMlg/2k6RggDWgNg+7RA0sUtAJouaV0ubWMlEOBshYHWrEoWiiDIY25vYfVV
         ZXJw==
X-Gm-Message-State: AOJu0YxgCQ87tociHcFkBieB8aM1KlhP9koG2Uy5pgiU8QVptgGdDvNV
	gb0fXh+UAEySbaQ6JuzAOzDcJNmtU+v6AFozG4mr9CeP3nLTx/9WZs0SCUy4
X-Google-Smtp-Source: AGHT+IHHL0qDcdJO34o56/lX4AFnDSfHRjNrUwJgSlPJfbc3SxOIiPCpSqgqNEs3qNs0rQEfHb8H1Q==
X-Received: by 2002:a05:6820:2296:b0:5e5:7086:ebe8 with SMTP id 006d021491bc7-5e58b848286mr5674157eaf.0.1727125274192;
        Mon, 23 Sep 2024 14:01:14 -0700 (PDT)
Received: from localhost (fwdproxy-vll-115.fbsv.net. [2a03:2880:12ff:73::face:b00c])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5e3b0d7d1d6sm3671776eaf.12.2024.09.23.14.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 14:01:13 -0700 (PDT)
From: Manu Bretelle <chantr4@gmail.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	dxu@dxuuu.xyz
Subject: [PATCH] selftests/bpf: vm: add support for VIRTIO_FS
Date: Mon, 23 Sep 2024 14:00:49 -0700
Message-ID: <20240923210049.2558881-1-chantr4@gmail.com>
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

Signed-off-by: Manu Bretelle <chantr4@gmail.com>
---
 tools/testing/selftests/bpf/config.vm | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/testing/selftests/bpf/config.vm b/tools/testing/selftests/bpf/config.vm
index a9746ca78777..b96b1fad2a04 100644
--- a/tools/testing/selftests/bpf/config.vm
+++ b/tools/testing/selftests/bpf/config.vm
@@ -10,3 +10,6 @@ CONFIG_VIRTIO_CONSOLE=y
 CONFIG_VIRTIO_NET=y
 CONFIG_VIRTIO_PCI=y
 CONFIG_VIRTIO_VSOCKETS_COMMON=y
+CONFIG_FUSE_FS=y
+CONFIG_VIRTIO_FS=y
+CONFIG_FUSE_PASSTHROUGH=y
-- 
2.43.5



Return-Path: <bpf+bounces-44519-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B5B9C4032
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 15:03:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B532839EF
	for <lists+bpf@lfdr.de>; Mon, 11 Nov 2024 14:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B40819E99E;
	Mon, 11 Nov 2024 14:03:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0GaUyBv"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C98F18BBA8
	for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 14:03:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731333802; cv=none; b=VKduKGXQ6Q0Dfd9SjtoCgFXJfKqryyESw9FPs628l/LrqX4AtTSo2SJUGNejsNY3JQKGb0T3NJFIYde2yitYtneCQHvr6HJCD/I6VDzw9rrUgYny8s2uD8Ca7CdOmclrVheUYdnxhyWO/CH5PvReeoCL1dfhFZTDRlo6xYvuHwk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731333802; c=relaxed/simple;
	bh=LoEcg354B+4fkxcSQH+M6GFaeji/p5hHxLDTPgv55Jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmL0pA5rYD20YgJZCoEWU7usEhvPX2RuRm6DNeLi/pumdZ6v44bnyflbQcjQCMJZxOHfnpVJ7HI2nA/llMGK0mlznxpXPREWbQ/qjYRUUzSvTVgWgzZqR43HbBpphyJbIYac647lUqdFkHricSgletmFjqTb7nV+VLuZ4DhJJUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0GaUyBv; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-539fb49c64aso6497655e87.0
        for <bpf@vger.kernel.org>; Mon, 11 Nov 2024 06:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731333799; x=1731938599; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=feLnU2HjyjVcvMD8PCEH+qFSuq+qXY5p7QQp5nG89EI=;
        b=f0GaUyBv8GlJlzpFYfnFQn8xWkoogOrbkW51gdP7t5iQAQsgS+YFn7rOc5/QVDsxwC
         xhn0MmaV1F9C9fIqEIT/IwF9LfMOESxEoZOOQPIkou0P5CFhrxIPKG7luAsuSGJifK+W
         caZyhkJzFsLF3xzkmdinQZH9NfN4XKc/V/MkHMmafe+DCfQA09p0dUrVPYHWOeZAG8Ib
         2vi+Xpvb20LOUUCRapq9aIIvK5SRrQNfS1KTAr9WmVXpWPGOtSAHqcS0pZMTuFzNDVD6
         5Py+tQOnR09R5iujT24Dtnub5LjEx+phRBxy2EcK2O1W1/CwgXrShXdWmeb4TwokIEY1
         m3cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731333799; x=1731938599;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=feLnU2HjyjVcvMD8PCEH+qFSuq+qXY5p7QQp5nG89EI=;
        b=IfXp5TH2S4mxWqLKh2WeqA5FpgiTEXVEkkAPWtzOSYU8SGb+gYGs5L9NEgthQiP1yU
         3PqSVUP4eS/hnJF+NBoDOXiBZ1eLgyy/NMID3fe5l6aRukDPXmZ0Ccqo5X/acZ/tS3JU
         6ki4uy7uZ9jreaojwjopxkq6SvicQAULckWJNM1qLGpWlZ6MAETbvxsHPP9qnBeRlcnb
         4umAvh/07vTIDYm93DgzDGWp8ZpnPIkfPVTm77nn1HVD9An3EoF96ee0+hvd1Lx7d0xP
         xHEo3wiWCQmbPZsSTxpWGAUowmqm4ktO/yG63qaMVFeQuT0V02pz4C0KtJEV4aIOO8Z2
         0IkQ==
X-Gm-Message-State: AOJu0Ywv3wZNhES0QVJd0eeTkqaaIqxXV75XPfUhNjGu+rodTo6KLFTP
	r0BFAMK6IleCk/uXsmrXWdQpHtQrCX2oKexKxp4fw68jrd5K9ZzHzp1qlw==
X-Google-Smtp-Source: AGHT+IEUjoi1BKHnV5/mwy8/f4Y6YWydGbXjsTDu1k6/LaVPYVE6xVleSJGGY64k8OHooI0o7iDQIw==
X-Received: by 2002:a05:6512:3c88:b0:53b:1e9b:b073 with SMTP id 2adb3069b0e04-53d862beb18mr6920679e87.3.1731333798602;
        Mon, 11 Nov 2024 06:03:18 -0800 (PST)
Received: from localhost.localdomain ([2a02:a03f:864b:8201:1677:ed83:8020:fb22])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0df2857sm597838766b.173.2024.11.11.06.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Nov 2024 06:03:17 -0800 (PST)
From: Daan De Meyer <daan.j.demeyer@gmail.com>
To: bpf@vger.kernel.org
Cc: Daan De Meyer <daan.j.demeyer@gmail.com>
Subject: [PATCH v2] bpftool: Set srctree correctly when not building out of source tree
Date: Mon, 11 Nov 2024 15:02:59 +0100
Message-ID: <20241111140305.832808-1-daan.j.demeyer@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This allows building bpftool directly via "make -C tools/bpf/bpftool".

Without this change, building bpftool via "make -C tools/bpf/bpftool"
fails with the following error:

"""
+ make ARCH=x86 -C tools/bpf/bpftool bootstrap
Makefile:127: tools/build/Makefile.feature: No such file or directory
make[3]: *** No rule to make target 'tools/build/Makefile.feature'.  Stop.
error: Bad exit status from /var/tmp/rpm-tmp.3p0IcJ (%build)
"""

This is the same workaround that is also applied in tools/bpf/Makefile.
---
 tools/bpf/bpftool/Makefile | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/bpf/bpftool/Makefile b/tools/bpf/bpftool/Makefile
index ba927379eb20..7c7d731077c9 100644
--- a/tools/bpf/bpftool/Makefile
+++ b/tools/bpf/bpftool/Makefile
@@ -2,6 +2,12 @@
 include ../../scripts/Makefile.include
 
 ifeq ($(srctree),)
+update_srctree := 1
+endif
+ifndef building_out_of_srctree
+update_srctree := 1
+endif
+ifeq ($(update_srctree),1)
 srctree := $(patsubst %/,%,$(dir $(CURDIR)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
 srctree := $(patsubst %/,%,$(dir $(srctree)))
-- 
2.47.0



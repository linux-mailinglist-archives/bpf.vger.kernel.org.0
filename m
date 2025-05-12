Return-Path: <bpf+bounces-58049-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D04AB45B2
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 22:54:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B2C8C3E78
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 20:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C327298CDB;
	Mon, 12 May 2025 20:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J2bkIG1d"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24F7125A32E
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 20:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747083235; cv=none; b=i83iCNytfSInciYsFKOa5kOxPDCh/5bUcYUIIuAnSClRwFiXNs9/NUpXkcE+Qa3rISAh7soeGWgvKWo5aUOdItVPJ5QsfXWLZ9hH4ozBseRqxmL3p06gJEGU93c5eY4Y05mQ/UOClIBA0lkNFn1qdpyzV55ZLI+Fca9pCFJwCPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747083235; c=relaxed/simple;
	bh=IjbPBh9Qzl1OF4Briwb0fMzIJeyl9wQgKtsN4vyGrSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MblS92sKwOXmqR90YSKMsdeOJVUy84/Xt5HjCfkQsVrRUpCUGEUWAq9FdR7TSl771vVccMs7ANyK345YtxeuZTLWkuvE1ps5wDLHWXtHPbbZ8Xbnt7sG2vL8M191M6raZoCtueqLgVqXe/um/ynNUJKleAJ5BggvlA2v7o++wUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J2bkIG1d; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cfdc2c8c9so28319435e9.2
        for <bpf@vger.kernel.org>; Mon, 12 May 2025 13:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747083232; x=1747688032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hm1Y4mbebxeENUCTJewajAhpY2X7jrsfytoFx12AMys=;
        b=J2bkIG1dBcd0T9X9TcJ7QvJxJ3b4VR/GAj9zvmfGArvYe8BSZrAApxY2EOu8AEdXgg
         okiw345DrSA51qrHuxF94OnQQW64cljT7L1pzlf6z6c2EPh8XRfzb2ogug4AAt2SFjUx
         1vEHrUOHOp3AKcn6Oce0jhtzv3FsxnUBelUN7TukulXV5AO2UZDAYN7U5QduxXyhWid2
         ZJ07xtZg0NZNwwzgVBXYYJYW86N/LkftwL6Yrn78sjXeSSRobBKcjpTIoNxliQZF9t/9
         41gMOEnMzOh8prOm86ul/yToHUDBVICdAj/ed8vbMe3QE97b4VWnIBP/GoJ39PKJA4cN
         n4Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747083232; x=1747688032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hm1Y4mbebxeENUCTJewajAhpY2X7jrsfytoFx12AMys=;
        b=sv2dhxzqYI01vHe6ZB821yYGyzUsdZMlAPGVhpFZMsNRBirvTHZ/I8VVh88n98Slr9
         sNT6e9bSSbQYUa3TriVVfG7KxjwvsnirkfHp8IXs5ReP3AjAsbT24ZmganMx8kb0GtVc
         KvkD3xoJ1RBccI5pbqFpZh76a03v7KmN4OZCM3ZfCFvvODifhVtwt//FoRnuhsxjE8wL
         tQCpjcapA7nrGkkYfwpGTH/WSKph5sm+SpK4OfkKfFP2mrC2N5sh+CtgaOjmSAYgz/Qm
         u20HYf0BxsjpmCFthD33ATVcrfRsC2BIWDCiHhVOySgOnq9UsUr5823C8ndNb+aQ3dAI
         hOdw==
X-Gm-Message-State: AOJu0Yzl+StzcCzwya62cLzmY9B0RxIXPocSoUfiQujKkkvXNsVIsrzK
	J0yyyvD8/NN2SvcNR+jlDgvtgf95tOvHVYzlf933W46Zj2qjiqkDDF84TQ==
X-Gm-Gg: ASbGncuxlbRxo+uC5a1oXRkNBF7P8xqNbJybTm7rK9+uV0mPXsMZNfK38JxSs+gmxjg
	dxJMWJE1xywZV6/XMl2BWRKGgnEa6CJ4GcN+5XzKUzPgQOIVq1T53uK2T7nH9K8Hdz14XmiMmHm
	tAPsliMnfNEILiFuVqJKcGEllgtDR6pc2A1+WR9XAYZLxN7qXsfBKeMC9r/R6ZaU6HJBo4aB2yp
	XqCtbIgmQQl48ruNc91Ix4uA9DXIlSca5/DMVuIBQ2kkk80g4lCfMB8bO5+gqet77Hjkpicci/R
	3nJtahSrT2Ucf7Dsve22lioQSthpAuS3hkVvaIXJaLlFZvFtGw9Wj2yh6o7DrmbEV8f/cQ==
X-Google-Smtp-Source: AGHT+IGs3FVmb+F9w++2JUMH3Lcpnu171xiVCiWc8DBxVMiMxSKw4MdhqIT+oDAWiq1wubd+0i4bTw==
X-Received: by 2002:a05:600c:154b:b0:441:ac58:ead5 with SMTP id 5b1f17b1804b1-442d6ddd0afmr151860155e9.31.1747083231989;
        Mon, 12 May 2025 13:53:51 -0700 (PDT)
Received: from msi-laptop.mynet ([2a01:4b00:bf28:2e00:ff96:2dac:a39:3e10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-442cd3285c7sm182800915e9.3.2025.05.12.13.53.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 13:53:51 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 0/3] Introduce kfuncs for memory reads into dynptrs
Date: Mon, 12 May 2025 21:53:45 +0100
Message-ID: <20250512205348.191079-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

This patch adds new kfuncs that enable reading variable-length
user or kernel data directly into dynptrs.
These kfuncs provide a way to perform dynamically-sized reads
while maintaining memory safety. Unlike existing
`bpf_probe_read_{user|kernel}` APIs, which are limited to constant-sized
reads, these new kfuncs allow for more flexible data access.

v4 -> v5
 * Fix pointers annotations, use __user where necessary, cast where needed

v3 -> v4
 * Added pid filtering in selftests

v2 -> v3
 * Add KF_TRUSTED_ARGS for kfuncs that take pointer to task_struct
 as an argument
 * Remove checks for non-NULL task, where it was not necessary
 * Added comments on constants used in selftests, etc.

v1 -> v2
 * Renaming helper functions to use "user_str" instead of "user_data_str"
 suffix
 
Mykyta Yatsenko (3):
  helpers: make few bpf helpers public
  bpf: implement dynptr copy kfuncs
  selftests/bpf: introduce tests for dynptr copy kfuncs

 include/linux/bpf.h                           |  14 ++
 kernel/bpf/helpers.c                          |  22 +-
 kernel/trace/bpf_trace.c                      | 193 +++++++++++++++
 tools/testing/selftests/bpf/DENYLIST          |   1 +
 .../testing/selftests/bpf/prog_tests/dynptr.c |  13 +
 .../selftests/bpf/progs/dynptr_success.c      | 230 ++++++++++++++++++
 6 files changed, 461 insertions(+), 12 deletions(-)

-- 
2.49.0



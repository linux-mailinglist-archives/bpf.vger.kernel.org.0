Return-Path: <bpf+bounces-34956-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EAF193419C
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 19:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3732A1F21BF5
	for <lists+bpf@lfdr.de>; Wed, 17 Jul 2024 17:45:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912BC1822F6;
	Wed, 17 Jul 2024 17:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YquGdEGL"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C00184F;
	Wed, 17 Jul 2024 17:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721238333; cv=none; b=VHtPmth59Cm9Bh6LTdKUFScbBvQ27d8K1eXwi+VT9QCIvPTQEwUHUPns6FQeZHaor7icJ0drtarQUpltdFmkXemkzAEUVthgkzveOpXn+sQmmQTiow1kcSFPpEHu5OEOM+CHWwccGBghMdGKt6dHiYdH4dNrgck712F4OlJD4I0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721238333; c=relaxed/simple;
	bh=FhIhVbW6u9gNdew2MOkhmvkID8oTdhNAeICbQzSiYJM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NLrL9V4tWoFvjYIRrDH5QKmGd1HJ/PPSgD5r1WJPKMp/t5VeJQa34l+cwv6Xb/lEdcGLPFT7MlR6v73cUBiPPCWBlQ8Y8vhshGbvQ84PdnJvgsKoAvdMgUHws7yvd5atDTGvot2uOoY7ZDOeWVt9s8x9zTNXQ0MZX1QRFeGAdA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YquGdEGL; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-704473c0698so280847a34.3;
        Wed, 17 Jul 2024 10:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721238331; x=1721843131; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=X48jdzMOGxaGLuAJ9XtwW1rcCVVhr2YB92q2wir0iFQ=;
        b=YquGdEGL1xzJXUXDRHqTu2mJ92z2x6qONY4r6OKam9YiRxjrizWf4LENBo2J8wfOds
         W5B2kIK6b/P0MxQh3btSqhDi6vMwrZRSaQi8MgXRyKMhihFxX/gGKo5MQYiCWluZN1A1
         YVHqwNdJyyk70LrudDcLzy1NFwDO+ns42zLLQwpepDbzi/AMFL5/moO/hTZxBZWKBQ1l
         CZg+2MqJIP8DIzY8RipTBZ6AFRh9u5WEmC/o/fmi1d1xjUhAJCyqRltMyZpSNr3uT2/m
         a7ncYXoDnX1fJgRPvvmV7hu3GeNU3z5AEi3SnpPvJpjyVFvq0kJcKm4WHrnUmOsa4ePm
         /QUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721238331; x=1721843131;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X48jdzMOGxaGLuAJ9XtwW1rcCVVhr2YB92q2wir0iFQ=;
        b=ix7aXE5J5rEx+iMzOjNOGAzOVSuLbMNxv8Sxa04GupjA0I8kLdVCjQWSvI5pKxllnr
         UEkdgJ3JexysESC22gg2lLz5+Cz9K8kprY6KQ+yWS1IznUa584gXlFqhUI02g7375a72
         nJ7A3Xl6bw/FkVjbxz5GTUQaYPZIRBdyeNWUVZY1DYGqmw0S4q7JH1B8JvzQLZ+xefUu
         UbCBcEsw0SNt06onDPb1m0UmvTXFHj1zs8z5L9M4GVhvJKLHTMsW35PRqpsKISgYx+b/
         uW2FcKpfaD9IqYuE677a+dcXwoeC7ADuhdqLn5lvQ10XwYDOT9jMC3kdPVnVDyiTFvqp
         sitw==
X-Forwarded-Encrypted: i=1; AJvYcCX64tTYv5ABmA72wm66ldhpCE6jslXmYbI8QUmffIwf3pb9055re9r3RUlzrhlGqn8eP2S8T50N61ZBrj5ldy4zn47tu51z4AntIEHHb8giMG5wTgDk8/b1VbYpqz6dt9rV
X-Gm-Message-State: AOJu0YzfsQdEdiwn+Uhka+ksGrtshRQksDBRDfxZ1SjwgA4YFiJ6U2fK
	DAzPjgxPmui+nM2OkeojO5JY3bl1xQBRF6+b0uyO2+z8UwJh5Lfo
X-Google-Smtp-Source: AGHT+IGJKcYBNSmO0p20V2qtFi2fRUiuQxtmQoLcpNO4KkKWG1YPUDssI94xRbO2ld955E9dSw4aAw==
X-Received: by 2002:a05:6830:6502:b0:708:5f27:dc61 with SMTP id 46e09a7af769-708e37b8475mr3013036a34.14.1721238330575;
        Wed, 17 Jul 2024 10:45:30 -0700 (PDT)
Received: from localhost ([116.198.225.81])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-78e33cb107asm6640260a12.25.2024.07.17.10.45.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jul 2024 10:45:29 -0700 (PDT)
From: Tao Chen <chen.dylane@gmail.com>
To: Quentin Monnet <qmo@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	chen.dylane@gmail.com
Cc: Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [v2 PATCH bpf-next 0/4] bpftool: add tcx subcommand in net
Date: Thu, 18 Jul 2024 01:45:20 +0800
Message-Id: <20240717174524.1511212-1-chen.dylane@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

XDP prog has already realised with net attach/detach subcommand.
As Qmonnet said [0], tcx prog may also can be added. So this patch set
adds tcx subcommand in net attach/detach.

[0] https://github.com/libbpf/bpftool/issues/124

Change list:
- v1 -> v2:
  - As suggested by Quentin, modification as fellows:
    - refactor xdp attach/detach type judgment in patch1
    - err handle fix for xdp in patch2
    - change command tcx* to tcx_* in patch2
    - some code modification for readable in patch2
    - document modification for readable in patch4

Revisions:
- v1 https://lore.kernel.org/bpf/20240715113704.1279881-1-chen.dylane@gmail.com

Tao Chen (4):
  bpftool: refactor xdp attach/detach type judgment
  bpftool: add net attach/detach command to tcx prog
  bpftool: add bash-completion for tcx subcommand
  bpftool: add document for net attach/detach on tcx subcommand

 tools/bpf/bpftool/Documentation/bpftool-net.rst | 22 +++++-
 tools/bpf/bpftool/bash-completion/bpftool     |  2 +-
 tools/bpf/bpftool/net.c                       | 69 +++++++++++++++++--
 3 files changed, 85 insertions(+), 8 deletions(-)

-- 
2.34.1



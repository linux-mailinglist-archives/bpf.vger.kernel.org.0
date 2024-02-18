Return-Path: <bpf+bounces-22228-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4120B8596B5
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 12:48:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF96B2832AC
	for <lists+bpf@lfdr.de>; Sun, 18 Feb 2024 11:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84CF6313A;
	Sun, 18 Feb 2024 11:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LOxBsMMf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1334EB58
	for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 11:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708256921; cv=none; b=E46PBzQeXMbr8+/2AkGejVXn+nLeNEEwUa69qAKFEP+2fwqA7A62dKpT/wyqVFmH4m7F7WS3Y5xJv2FHv2pW/AAsxK2NXHXAqEmw9erySvWgFD8bxZ6SJzH7wNQRet7QXqyDbnFA6nYRfYokxtJwmyT2c41C0Wqj6xfk4+yu77E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708256921; c=relaxed/simple;
	bh=gGOdVnn3cn0ghPirUGpWG7bk4HhDg8501SgqPdJ3FxA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=EVDmyEcyd6FCIhFzCYVEIVSyHIc8p4SPyn3UySevXDtmqXEs0XtYKMKLgfuoMmPS+jgRbioiH6xjGqXMkelAVztxzZ/uMgao7XqpjtUPdJTYTk3EVTF8+SVsS1d0l2au/QOB1dlQLCc8ELrYBrtKqrqRmuAk64HRBPZGkux8CTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LOxBsMMf; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-6e45c59fc6cso126494b3a.0
        for <bpf@vger.kernel.org>; Sun, 18 Feb 2024 03:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708256919; x=1708861719; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yp7Nk4x/glaDTBFwm+Pf8Q24/wdtQ/oMuLCmec1PwuU=;
        b=LOxBsMMfLpxugWYRCun9mgkdxDn+pzbL49vkIuqyN1Hk7L1Yo1k7Ub9JuJTCBI8Td/
         4XYkwMJF8/4MHyMPJlElsnWqFd84sMq7qBPtAD/xxrum2SkYPWGoirUt5F8d1ij5dTFB
         HSUblti/Lw6e2y274xUN3ZjYtaiDi7J+X8Ey7hYtGhjoZCnPxsNWWjtuq66Z70ceZKss
         ROvPSklcmapmq0bkdpy3V7ekeb2A11bTdf8RVJ40hbKJvjJeQfNqEFBG74EvpWcOAFaP
         neaYvqKt5NPd2hRz0YxMRY25pCePh4bT+1ZEoEmTnmKA+x1816lAF8N7/DKknUXi3cnK
         grig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708256919; x=1708861719;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yp7Nk4x/glaDTBFwm+Pf8Q24/wdtQ/oMuLCmec1PwuU=;
        b=SD0OfHFBDz6Y0bdQ4rU5Up0Iks0Rk8XhodCFirivzl93PghZQl5/kGWUk/9uanI889
         UIHzKYq130JGD6YQVWBUSnZTEfknzpvIF+EudA8AqF8sMuLshOCjvHQv6UT46bTAv4Uz
         PMvQTA2NqrKiXB5Bxq/WfrhyEWgubwQcF/ZkPHXn2uPRrVBIs0v4qUKAFbvingxZraex
         EcTTzOZgaustt+u9IXelbcHoF3YFD25h7kILon4pSOKTUY4ROnGg08dYT96pzAjCJJpl
         g6W7uEC9qqfVFO8YId5hlpqrKLFCBQrqlNq67dhJ5zMv6amR7fW370PWQ1uWgGMHviV/
         GQ1w==
X-Gm-Message-State: AOJu0Yzar5+U1B37XgoGWD3rDuqOCImjwOzl5tdaLXQli/bvIsCZbJfP
	iiDlF3b3GWgfp6Wwv+QCIhMMGU59pEy6aIlyDMlhvKryZjg+klsPLdUGLy9TuW41cmk/
X-Google-Smtp-Source: AGHT+IEgT0zgq66z9TNBiraxitIcHdtC9AQzTp+9cs0FIUH7IjRZ8uuRwQL2oFnFwDLtQJrGEtUe3w==
X-Received: by 2002:a05:6a20:ce43:b0:19e:a270:e766 with SMTP id id3-20020a056a20ce4300b0019ea270e766mr12971881pzb.5.1708256919253;
        Sun, 18 Feb 2024 03:48:39 -0800 (PST)
Received: from localhost.localdomain ([39.144.106.222])
        by smtp.gmail.com with ESMTPSA id 203-20020a6302d4000000b005dc832ed816sm2857551pgc.59.2024.02.18.03.48.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 18 Feb 2024 03:48:38 -0800 (PST)
From: Yafang Shao <laoar.shao@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@google.com,
	haoluo@google.com,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Yafang Shao <laoar.shao@gmail.com>
Subject: [PATCH bpf-next 0/2] bpf: Add a generic bits iterator
Date: Sun, 18 Feb 2024 19:48:16 +0800
Message-Id: <20240218114818.13585-1-laoar.shao@gmail.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introducing three new kfuncs, namely bpf_iter_bits_{new,next,destroy}, to
support the newly added bits iter functionality. These functions enable
seamless iteration of bits from a specified memory area.

- bpf_iter_bits_new
  Initializes a new bits iterator for a given memory area. Notably, due to
  limitations within bpf memalloc, the maximum number of bits that can be
  iterated over is constrained to (4096 * 8).
- bpf_iter_bits_next
  Get the next bit in a bpf_iter_bits
- bpf_iter_bits_destroy
  Destroy a bpf_iter_bits

The bits iterator can be used in any context and on any address.

In our specific use case, we leverage the cgroup iterator to traverse
percpu data, subsequently exposing it to userspace through a seq file.
For detailed usage examples, please refer to the example in patch #2.

Changes:
- bpf: Add bpf_iter_cpumask
  https://lwn.net/Articles/961104/
- bpf: Add new bpf helper bpf_for_each_cpu
  https://lwn.net/Articles/939939/

Yafang Shao (2):
  bpf: Add bits iterator
  selftests/bpf: Add selftest for bits iter

 kernel/bpf/helpers.c                          | 100 ++++++++++
 tools/testing/selftests/bpf/config            |   1 +
 .../selftests/bpf/prog_tests/bits_iter.c      | 180 ++++++++++++++++++
 .../bpf/progs/test_bits_iter_failure.c        |  53 ++++++
 .../bpf/progs/test_bits_iter_success.c        | 146 ++++++++++++++
 5 files changed, 480 insertions(+)
 create mode 100644 tools/testing/selftests/bpf/prog_tests/bits_iter.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_failure.c
 create mode 100644 tools/testing/selftests/bpf/progs/test_bits_iter_success.c

-- 
2.39.1



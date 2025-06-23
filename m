Return-Path: <bpf+bounces-61256-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9462BAE3424
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 06:04:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2965516D617
	for <lists+bpf@lfdr.de>; Mon, 23 Jun 2025 04:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FB81A23B6;
	Mon, 23 Jun 2025 04:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BaG8D44R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51810A1E;
	Mon, 23 Jun 2025 04:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750651478; cv=none; b=BtHgkmDL8y6j1VsB45ngNeg5g0YF7vPAWsd1eII1J7bt5qdyC4XxemwR2pLnrXbX5rJqrexawkYJSwY8JQVVe9MpIw0AHYyXVI3Dvhpa+4SINyPkj8IwpOxDO5Yw8ChAysFiho/lueHxlpTl9eLB4tIVrk13X9hradz+UGeLNo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750651478; c=relaxed/simple;
	bh=NMMH/a/h9GKlHxgqPIAhgpz1RgpPV9y01d9DBYIVi8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dL/zvAoLqHJeBpLTrerLQQYljjVwddMPyOU93sUi6QlvQ8p59usIV1kY1P7xnTR0ovm/oyRtuRZB4RZeM3EmB0MZSdWKq6zO6OlUAcy6NvKOHt+1Gt5OUdwzD9xBDwNvzSPZV4rL+t7IlZBzT2NGalrFm4AYCLyNnJlsMRa/Yfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BaG8D44R; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6fadb9a0325so32475516d6.2;
        Sun, 22 Jun 2025 21:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750651475; x=1751256275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Md8vFLFRSCAoAlCVLUSMYdQwjWVR5zcLjkPNgRxuLls=;
        b=BaG8D44Rlfy4V7HKafKiNms+CHggXWGrhOIZX3t1bajZR4rK4YJzzdw4xDEAD/4ktV
         UvaLyqzUrbYosTyK95H/liGTmiFH+MGH02j3mh4DdZKmLXjDiTkVSFUVJHN/QjvF3P7T
         NctvEZs+yvWN7JnCuE7V+BaG8s6fLTk5de4moKAEFyNw271oyfQOU5Mj+ZN0N/LucNvi
         0NGUxyKNvffLjZidufva6wpPlLY/Im/2pRzzyuD/khqqFDwEoTLbBC9xfadLKG+x+zH7
         IfC3Cu9lbbWToxbEkBlaRezRh7lHr18uj5D6pvHqTKgwGjbfK/0x+F061+UV0gZsAqGL
         Q+JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750651475; x=1751256275;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md8vFLFRSCAoAlCVLUSMYdQwjWVR5zcLjkPNgRxuLls=;
        b=u/x6OYmmGV4nrZwyvocHllGxFPHlFZD6EJar8VUM/2K9zUwqMB/Ys4nsh4kZyEereB
         XoWOG0EgO1yS8d3jznVSHGtqYRcfxdF2R3CNwArignZQJgFLaR9hfuRgiXyXhN5dV49G
         diAGjpHtQK/tgN2rTaz3jGLHCHJ7bhCiq3CpjcDxlI9FlXw3/VYLFHk5cMujuft8V8/x
         Gb9sNJxrHnGncQ4Q9263ThEOOKKvvbJ3sQgAQdtnojuVGSTny8ocWuBQN6SdkS5xzGRx
         mR23yhhX+kx+C5pdvg/8SNSMrLYZRAjdCvx6YBpWNC2jyhdclQgy40Sv5EHmLiWyY8O3
         gqqA==
X-Forwarded-Encrypted: i=1; AJvYcCVNHmmtuHGRjp+RkrTFVEbAKtsenUWfsbUGyrjLs+Aa1vesDDflV6oPFZmGURdvfEiKE5UCMBC9+4pSBfIl@vger.kernel.org, AJvYcCVpOC8xLpRSHCVXv+xn3jl59TcPYP2S4EqinM3Dt0bPKNEM/gVCS6TSr1UO6kh+rBLaZQc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxusqNywPKzlsKZhwR1NpevnWD4bSBHEMgfOZGOHOu4ZFmO8zRi
	7Qi/eAY/AHMvsAJd3eOhPm8xhj3HmfdD8n2ApVcFsbykuLdZig9FlgP6
X-Gm-Gg: ASbGncuO0n1fmmtS0XwM1EeSJwyF/4D2NMPIYzVvO+7rzwxeK7/jK5BbpZcMU2/fOpS
	34m/kTjrMIBmdd4x3pXKqLwUQxf0B8C5IOy9gCfA0LVDQFV2mxtPzZlWPfuP0I11WZoM5aRmMXv
	wDNVvNiuRbsXO2gQ7MuBZ01KzQTqTzDgvLh6rIhCPuR7kXjAU2ZVwhHN24zZRBizLlUHBJzSIUm
	uqcgSzq+aX+YaWZloVXZ4f22Au1YV4eE4+bXlvIf1LsPCv9M6pjcHjeWr+sMmbInzkISTY6xusj
	KAiLtaTm9Hgh6A1S7PzEdJOwGCnJQTq77SARf+MoJzAZKlohTOQftXYscPiDnJjoeFVrxZY+KAz
	RFMpsYCGXvawkOviJJhEb+2AIRWPylTN2L/QisH0iBTR4HT0qTkxRrIsjW4FHzxAy7LZuIA==
X-Google-Smtp-Source: AGHT+IGoqQ2krgFek93TTJE8oNo1dXpK2rhyDOE2arFxVMVJAR875laOmCSpHGxPcf6PmqtrT1yYLg==
X-Received: by 2002:ad4:5e87:0:b0:6fd:8fc:e2fa with SMTP id 6a1803df08f44-6fd0a570c7emr199623296d6.32.1750651475553;
        Sun, 22 Jun 2025 21:04:35 -0700 (PDT)
Received: from lima-default.. (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7d3f99fc0a8sm347274385a.80.2025.06.22.21.04.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jun 2025 21:04:35 -0700 (PDT)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: ast@kernel.org
Cc: m.shachnai@rutgers.edu,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/2] bpf, verifier: Improve precision of BPF_ADD and BPF_SUB
Date: Mon, 23 Jun 2025 00:03:55 -0400
Message-ID: <20250623040359.343235-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patchset improves the precision of BPF_ADD and BPF_SUB range
tracking. It also adds selftests that exercise the cases where precision
improvement occurs, and selftests for the cases where precise bounds
cannot be computed and the output register state values are set to
unbounded.

Changelog:

v3:
* Improve readability in selftests and commit message by using
  more readable constants (suggested by Eduard Zingerman).
* Add four new selftests for the cases where precise output register
  state bounds cannot be computed in scalar(32)_min_max_add/sub, so the
  output register state must be set to unbounded, i.e., [0, U64_MAX]
  or [0, U32_MAX].
* Add suggested-by Eduard tag to commit message for changes to
  verifier_bounds.c

v2:
* Add clearer example of precision improvement in the commit message for
  verifier.c changes.
* Add selftests that exercise the precision improvement to
  verifier_bounds.c (suggested by Eduard Zingerman).

v1:
  https://lore.kernel.org/bpf/20250610221356.2663491-1-harishankar.vishwanathan@gmail.com/

Harishankar Vishwanathan (2):
  bpf, verifier: Improve precision for BPF_ADD and BPF_SUB
  selftests/bpf: Add testcases for BPF_ADD and BPF_SUB

 kernel/bpf/verifier.c                         |  76 ++++++---
 .../selftests/bpf/progs/verifier_bounds.c     | 161 ++++++++++++++++++
 2 files changed, 217 insertions(+), 20 deletions(-)

-- 
2.45.2



Return-Path: <bpf+bounces-21200-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19E1984939C
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 06:56:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3E4711C2272E
	for <lists+bpf@lfdr.de>; Mon,  5 Feb 2024 05:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDE71B671;
	Mon,  5 Feb 2024 05:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jcoDqQ0m"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ej1-f68.google.com (mail-ej1-f68.google.com [209.85.218.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28BEBA28
	for <bpf@vger.kernel.org>; Mon,  5 Feb 2024 05:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112612; cv=none; b=i9kCDlAu2P5DrKEiGLHVpPTymrlFktPfeVWUEQgEd2AxURpWMZbCOG6yyyJQ3jZoBeEKeASSA//kYQf+i5PuOk+R5JCwGx2Qrl4eWH5P/ejSalS/cXTWR7r3Ch2N0h6k3t2wcSfJNe1G1te73ZiI33wyeUPIZ8Po2VsynvkHHzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112612; c=relaxed/simple;
	bh=vGcI2IvtY9zqfSlgGiw5X0sIBZPp5HMsBfEWNVl7nog=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J0UICGzu6B7qHe7oTJah7rWueX85DZXim5yUzpB2C8XHdPHNwG7/XOjxALy1SduIaDcR0E49ZUIQNHlbbfx+CeUMM8zrnrbiYzk1eEyOzBwYIRmFJos8CRv7gDO8oe++jdmSoq9Ta57lkhLbl9QG3CC97mGHrG1zGytiwpZ2e+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jcoDqQ0m; arc=none smtp.client-ip=209.85.218.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f68.google.com with SMTP id a640c23a62f3a-a354fc17f24so465989666b.0
        for <bpf@vger.kernel.org>; Sun, 04 Feb 2024 21:56:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707112608; x=1707717408; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=umTz2zQF+kgCRQa11VzHl4vNCHe3lv18onU/seK0d1Y=;
        b=jcoDqQ0mjzkrBlrUi1Zu6J7Z421CvlRKaGms+1ZGHxPCcoSA7PEpB3XeP+tdvYws/v
         01JxA8nIp40kwq60NDlhVZBgive7fgewLv4bP2PycapzExsOHNPlWi+hUoABQnpgFj0K
         g2haWJ8caTb3BdCXgGPA9brGyKigvjnHAAKch5mPkEy9QJZ+6cyigombe68U6ubGhmj8
         jaJLswMymsFndOheYumLmP/PP6FdZVhUe9XFGxmVgEOwzpbPwZy+Un4oj7SWZV/ocTwE
         s9/QG6AfFh+094xQEUNzLDcrpq/cZaGNXb4E4OnRQnDbC9cPLytYw0QQgliz93ZVhpbn
         w+9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707112608; x=1707717408;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=umTz2zQF+kgCRQa11VzHl4vNCHe3lv18onU/seK0d1Y=;
        b=qBUd8n32JWV4DedN5UZ3w6uQgeBBsXoSUMe83NXl4VDuKOILp1ycQk9NR7DseOzPjr
         ECjbCx53nbDeHEwCqtBWA9ZH9lJ5qcIOexO2QG3qa3AopCkXZTorRpVA46Mez0sk4q2B
         Ja1KaklfmR3TjqauI5x2rNzbVrFJrquSgNzoqbR4xE+DVXmvrL1n7uwdX1ib8HmtpX0T
         dP04E9drvaHzpkynUzVab8XW401AOYkA6h/NI7h/p8GOwZNx6g0QVRgS8F8yjjbBEg5L
         Cyell7/+kFrBuS6Vpkadm402NNWtx8flnmq61JikxGwQvicysmyoCV3XWHz2LaVfV96h
         GLEA==
X-Gm-Message-State: AOJu0YytDYGec3SwB9/0pXBOMQIip1uoiYnc+uWWYkG70zlsyRW6SUOr
	dVVam7+o9QL+h40R5t9awq84IuDLqG86wc5a57zWSylpIQ9QKXLGjcRz6zQwSgM=
X-Google-Smtp-Source: AGHT+IHDdLTeU1XQ77VSYyUkTDdHpgH/s7yEs7Fta3/77htnNCtVzJO5PtsQxFREumDaiGHEQFA/aA==
X-Received: by 2002:a17:906:3c13:b0:a35:7438:113f with SMTP id h19-20020a1709063c1300b00a357438113fmr7822711ejg.49.1707112608008;
        Sun, 04 Feb 2024 21:56:48 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVsxG7Ya9VxVDh6/3dskHPaKGR9O3gjlr7p8wBZLi6BhsLisdz4J1bVXMegk9KJ2UYBKlkiWZTI0Kqe/z/o52p6ET8LOJ0h2FMtjqu1H+crDz/yDj6xQvPP6M3ANWzSFkWliV0TL7uMHodWZVLz63hrqWt+5EMZg/jpxWbzVtgS3gpRo5lqchycw2rEHaPAtrmXyUi19WfbYZEyiUOhCspYq8F9ZifMjdGZlS7cT3Wfk/6xUUjyzxrd8gVQOpqEuRM=
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id vu4-20020a170907a64400b00a371238bb31sm3499906ejc.113.2024.02.04.21.56.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Feb 2024 21:56:47 -0800 (PST)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Yafang Shao <laoar.shao@gmail.com>,
	David Vernet <void@manifault.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH bpf-next v2 0/2] Transfer RCU lock state across subprog calls
Date: Mon,  5 Feb 2024 05:56:44 +0000
Message-Id: <20240205055646.1112186-1-memxor@gmail.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1457; i=memxor@gmail.com; h=from:subject; bh=vGcI2IvtY9zqfSlgGiw5X0sIBZPp5HMsBfEWNVl7nog=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBlwHiMmpAy/CFDRFl/GDYmT8pLBr52stRCvZPxc dOS+DMl3AmJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCZcB4jAAKCRBM4MiGSL8R ykctEACcf2qbJcyKOd//7hfK2LfQo1FvitBS6Xy0gJrFqiVNdJzI4GaGIBb+5RI+5Nmw4yxcnU5 380Xikc0TP8hX5AbuBk8TvMsZzUgQOYncoykd+zNu/0PovJDWjtVpkL80ftkwduoyx+4csFI7jS eWMKPLRq73TWTlbj2m+OBi4MUBKCVGpnNfazJe84iIV65ibkA6z4GdWCMdwA3SArWtzF7b5mhOl CZJ2qC8xc4OnyVyHyTHAn5PP2Legdell2ZWBA/NGgnQvQZ0sFvrTfGJGgeJw5DdWq834rIlpGDP oxPnvADm45OSc2ZtipiwlXdUvAa6hvvW4E/QoVi6yO2zfkpbDegg0pgT0fSu3uQy3jEJgJErecU n6+HzxwGBfctnuqAiJo8/rPNR8J7Us5XJMRzvmCC3faF4Q1dxDQ8e5tHmBUkj6q3ILrOS77bkpC j2wHGvveETlEk67Hul88PEihVn+0kXMnrWrHwal+9UhUPWB857oTfY1Iij/seQ+2h9RVagRcXUg k2ote4eOPk2jp3aT9/iLXe8qbcr6/zp/EZxPDDecSGRuigG1DRXYsNglSYu3ziiKsFRzdZTh3Kl M5eBIQgZmGcZU/sUu4UPk/D3SRXlnPhn2zpottrJNlHVQgpDrFPSaXJRZrL3x4RWwlgF6rUz6d0 i2lqKL0FR/bPLCg==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

David suggested during the discussion in [0] that we should handle RCU
locks in a similar fashion to spin locks where the verifier understands
when a lock held in a caller is released in callee, or lock taken in
callee is released in a caller, or the callee is called within a lock
critical section. This set extends the same semantics to RCU read locks
and adds a few selftests to verify correct behavior. This issue has also
come up for sched-ext programs.

This would now allow static subprog calls to be made without errors
within RCU read sections, for subprogs to release RCU locks of callers
and return to them, or for subprogs to take RCU lock which is later
released in the caller.

  [0]: https://lore.kernel.org/bpf/20240204120206.796412-1-memxor@gmail.com

Changelog:
----------
v1 -> v2:
v1: https://lore.kernel.org/bpf/20240204230231.1013964-1-memxor@gmail.com

 * Add tests for global subprog behaviour (Yafang)
 * Add Acks, Tested-by (Yonghong, Yafang)

Kumar Kartikeya Dwivedi (2):
  bpf: Transfer RCU lock state between subprog calls
  selftests/bpf: Add tests for RCU lock transfer between subprogs

 kernel/bpf/verifier.c                         |   3 +-
 .../selftests/bpf/prog_tests/rcu_read_lock.c  |   6 +
 .../selftests/bpf/progs/rcu_read_lock.c       | 120 ++++++++++++++++++
 3 files changed, 127 insertions(+), 2 deletions(-)


base-commit: 2a79690eae953daaac232f93e6c5ac47ac539f2d
-- 
2.40.1



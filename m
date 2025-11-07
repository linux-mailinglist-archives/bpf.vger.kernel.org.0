Return-Path: <bpf+bounces-73981-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AD20C416E3
	for <lists+bpf@lfdr.de>; Fri, 07 Nov 2025 20:24:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id DA727349CC0
	for <lists+bpf@lfdr.de>; Fri,  7 Nov 2025 19:24:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8505430101A;
	Fri,  7 Nov 2025 19:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YeWHFoTk"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F26B2E0B59
	for <bpf@vger.kernel.org>; Fri,  7 Nov 2025 19:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762543466; cv=none; b=AD3uqlJRcNzdfofA6Xr8ZlAMViQMKwCbgRv4shADk4SHv3lv9gLB/Vs96wD4dU02uGUNs79zr8llIPu5FYevvi5rG/r3UcnhwYw3wbLpHp06GAYgpvb+8ekZCcOD3X/KwpL9lx/Cvt+h39d7HH/aXuY/M7g2SJoIcJGBZNu8cB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762543466; c=relaxed/simple;
	bh=0aeA0EQ/qtUV1nnZR6e5uPNh1f0VQwXUpiK9gDrTR5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=giIbm5NNDbzwy6TSwwH2++gLydgW+xQzM6xJhMl8XJgW9wHUilcwv+zXlmHhxFce/km8Dd82Rk2EDA2MN/PmObgjDLf/eBy8Cqkt8/FPMMC7ElCy9ZfQdnQSiux5uZj++0hgEDquhjkHIyR9uX3jWUYDDvtOo4VS7d64qWnaZ1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YeWHFoTk; arc=none smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-4ed861eb98cso12674481cf.3
        for <bpf@vger.kernel.org>; Fri, 07 Nov 2025 11:24:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762543463; x=1763148263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YE0Sm4vbE8ykdJ1HuAxgdJ0mqOLChjiDAanVsAowUHM=;
        b=YeWHFoTk+NUDaGZG3VmXa8xldLXDrmrMwH95Z3s4uDzEpGmq1Qd+icoqzVR6Keaetu
         4+68XwS4n40OHUJi+3W9G+Nqe0pvJdEcau7bvowtAX89yIBoUqVzbjog39tzUuKXwlIo
         5Z8GmdMJmRhOJFgLQZiQ8eXmLgBoMEAZPw/wDqcbH+rcXIQr0Bc0E+5aIFGjCr0FfZLM
         xr32Yv8KaPmwAGBSMQN0C+4dRo8CqvQCDsDP7kCm/VuJpMVBPsbCZTjiYEImB4o9aE5i
         Ru2A8hn/cdZbEKNOqFs4GH+878u3qM8TAExHrEylw065ZVaKM0dPZkYY0Q0q3ShHqh3c
         1aUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762543463; x=1763148263;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE0Sm4vbE8ykdJ1HuAxgdJ0mqOLChjiDAanVsAowUHM=;
        b=rmcjc7g8dKrFTymuvXeTp50EbISE8DTC6q/kiwbUhRhKG3EDx+8Hrc0zNzA43O4A55
         3Z87kIGXeocJ7lG3elYDX6p/1lp6qxLcdu+Cu7/xHDz9GW2JGv4bKAE5z+LD6jvbVmco
         R8YJsDdfT7t6Krnui8EnsUFVs5f34uyZEMcr6hEw6jdID2FW+5bjTnMRC27vxQKvi2Ov
         2ROSHrpVBW76AmtE23eLXQBtvY9GNgPN3NPdqZ+FeVd4lEdkw9j2lOBi23hYn6ko5QsJ
         L1wquJkIqn4FDRd2P7p5WrQrOlWny80hWnxa+MmB4v/PLsL4lOV8CQs/6VVrsQBje+Lr
         wy1g==
X-Forwarded-Encrypted: i=1; AJvYcCWLNqbFOGJtK2Wjtdua0UQeAQsTLyiLw+++yxcozvloq2YM1mGhvt7I/JPoAzOjhuKFF1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpBcJcb7QYfc5afBm2duyZG5lwlOcWrm1mJ6SDJCloJXqZCZMc
	5rWEWbGB9r4U55PJPeBmqk+HC/xTKHRtnCnBPXIFG60qqpI8lD7zRsy7
X-Gm-Gg: ASbGncs8oaPDQFwiP8/OOU/UTYUXIA+zE7aap/3fXLa5pudtmRuqnYDXcxDwDjB0Hr8
	FdSlufOFkfIYyKWswGdVCVtwtD0YiXZZsXfqwJjqTdJgplBIm6sPFHNb/S1mkvAM7SWB/tZplOx
	ie1Nuu8lj1tAi8H1ZJfUWl8IrB/vy45ZIPv//IN5ylYJRtkpou3kbFLftHa5MhNcEzUUoDSMNJu
	6o69jdndUC9IdYmwh4Yo08AvA3p33kJ6IlAO0eQevCj0TJ832ChdPTut0PcEql1F6PrlwPG5eJ5
	RLooLTWLMBGnP2zBzCFo6u+qVxjxgWPI2OBztD3XwMLYl+gcpq9A30pcvCCZKere8DFdBxfPdpT
	6oevxbQXnk+s+pJCVSlEarB071wrZlSRJgmtcTmdEGh90Fye4YqzAENtpscJ2wQL6y01cHoTig9
	KOrzHc7uFoSDjqbQYYiBTq9j+j/8gfWB7O+P+XpzvooCzNkeU4OEGbTVujk5gJ1DlX9W939f+ue
	/9PYfJGEPcdXql//LTYBg==
X-Google-Smtp-Source: AGHT+IFdpz2lkLypQ1YAYGXXNqpB8UlvpOAw4vPZY4Y75ma7L6WvqhCiWCs17MNIjJSpgJsL+FXkbw==
X-Received: by 2002:ac8:5fd1:0:b0:4eb:9eb8:c9d5 with SMTP id d75a77b69052e-4eda4fb4876mr2741691cf.58.1762543463118;
        Fri, 07 Nov 2025 11:24:23 -0800 (PST)
Received: from lima-default.. (pool-108-50-252-180.nwrknj.fios.verizon.net. [108.50.252.180])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4eda57bf2cdsm251561cf.31.2025.11.07.11.24.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 11:24:22 -0800 (PST)
From: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
To: ast@kernel.org
Cc: m.shachnai@rutgers.edu,
	srinivas.narayana@rutgers.edu,
	santosh.nagarakatte@rutgers.edu,
	paul.chaignon@gmail.com,
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
Subject: [RFC PATCH 0/1] bpf, verifier: Detect empty intersection between tnum and ranges
Date: Fri,  7 Nov 2025 14:23:27 -0500
Message-ID: <20251107192328.2190680-1-harishankar.vishwanathan@gmail.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC introduces an algorithm called tnum_step that can be used to
detect when a tnum and the range have an empty intersection. This can
help the verifier avoid walking dead branches that lead to range
invariant violations. I am sending this as a patchset to keep the
motivation (this email) separate from the details of algorithm
(following email).

Several fuzzing campaigns have reported programs that trigger "REG
INVARIANTS VIOLATION" errors in the verifier [1, 2, 3, 4]. These
invariant violations happen when the verifier refines register bounds in
a branch that is actually dead. When reg_bounds_sync() attempts to
update the tnum and the range in such a dead branch, it can produce
inconsistent ranges, for example, a register state with umin > umax or
var_off values incompatible with the range bounds.

There is a solution is in the works by Eduard [5] to modify verifier's
logic to use the fact that the register's tnum and range bounds are
incompatible to detect that a branch cannot be taken. Detecting an empty
intersection between the range and the tnum could be a useful primitive
to detect incompatiblity.

* Detecting Empty Intersections

Consider a range r [umin, umax] and a tnum t (tval, tmask). A simple way
to check if the range and the tnum intersect is to compare their
bounds:

	tmin = tval
	tmax = tval | tmask

	if (tmin > umax || tmax < umin)
		return -1;  // no intersection

However, this approach fails when the tnum represents a non-contiguous
set of values, and the range lies entirely "in-between". For example:

	t = x0x1	{1, 3, 9, 11}
	r = [4, 8]	{4, 5, 6, 7, 8}

Here, tmin <= umax && tmax >= umin, yet the two sets have no
intersection.

To implement set intersection for tnum and ranges, it would be useful to
have the ability to walk through the values in the tnum. If the next
valid tnum value after umin already jumps past umax, then there is no
value of t in [umin, umax]. In other words, we need a "step" function
for tnums that can determine the next numerically larger concrete value
that is contained in the tnum's set.

* The tnum_step() primitive

To correctly detect these cases, we introduce a new helper:

    u64 tnum_step(struct tnum t, u64 z);

This function returns the smallest number greater than z that is
representable by the tnum t. Using tnum_step(), intersection detection
can be implemented as:

	if (tmin > umax || tmax < umin)
		return -1;  // no intersection

	/* next valid tnum value after umin already jumps past umax,
	* implying there's no value of t in [umin, umax].
	*/
	if (tnum_step(t, umin) > umax)
		return -1;  // no intersection

	return 1;  // intersection exists

* A sound and complete procedure that runs in constant time

At first glance, one might expect that computing tnum_step() would
require iterating over the individual bits of t and z. However, the
procedure for tnum_step(), introduced in the next patch, derives the
next tnum value greater than z purely through bitwise operations, and
thus runs in constant time.

Importantly, using the tnum_step() primitive we can construct a
range-tnum intersection test (as shown) that is both *sound and
complete*: it never reports "no intersection" when there is one, and
does not miss any cases of "no intersection".

* Usage in the verifier and next steps

The tnum_step() procedure is self-contained and can be incorporated
as-is.

Regarding incorporating the range-tnum intersection test, as it
stands, if is_branch_taken() cannot determine that a branch is dead,
reg_set_min_max()->regs_refine_cond_op() are called to update the
register bounds.

We can incorporate the range-tnum intersection test after the calls to
regs_refine_cond_op() or the calls to reg_bounds_sync(). If there is no
intersection between the ranges and the tnum, we are on a dead branch.

Alternatively, the range-tnum intersection check could be incorporated
as part of Eduard's upcoming patchset, which is expected to rework the
logic in reg_set_min_max() and is_branch_taken().

Looking forward to hearing any feedback and suggestions.

[1] https://lore.kernel.org/bpf/aKWytdZ8mRegBE0H@mail.gmail.com/
[2] https://lore.kernel.org/bpf/75b3af3d315d60c1c5bfc8e3929ac69bb57d5cea.1752099022.git.paul.chaignon@gmail.com/
[3] https://lore.kernel.org/bpf/CACkBjsZen6AA1jXqgmA=uoZZJt5bLu+7Hz3nx3BrvLAP=CqGuA@mail.gmail.com/T/#e6604e4092656b192cf617c98f9a00b16c67aad87
[4] https://lore.kernel.org/bpf/aPJZs5h7ihqOb-e6@mail.gmail.com/
[5] https://lore.kernel.org/bpf/CAEf4BzY_f=iNKC2CVz-myfe_OERN9XWHiuNG6vng43-MXUAvSw@mail.gmail.com/

Harishankar Vishwanathan (1):
  bpf, verifier: Introduce tnum_step to step through tnum's members

 include/linux/tnum.h |  3 ++-
 kernel/bpf/tnum.c    | 52 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 54 insertions(+), 1 deletion(-)

-- 
2.45.2



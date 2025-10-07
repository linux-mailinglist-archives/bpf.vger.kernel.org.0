Return-Path: <bpf+bounces-70544-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 38B0ABC2CFE
	for <lists+bpf@lfdr.de>; Wed, 08 Oct 2025 00:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E31684E40AE
	for <lists+bpf@lfdr.de>; Tue,  7 Oct 2025 22:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C89AC257437;
	Tue,  7 Oct 2025 22:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QTJsXM56"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3981CEAD6
	for <bpf@vger.kernel.org>; Tue,  7 Oct 2025 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759874634; cv=none; b=eCnEoPdfxO0nkbDeIE7BGf2i9Kd7KkARpj6MKRoHD6aBc44ClD9wqEvQVYQsj41esoboa55AO4nMwzTb1XY95hUzOi3b4ZLtDE+RZR5wIKr5xQ6e/0YsPLplVZtOKCkZLPS8Mt+CWKV2eWbN41JvX2jd6OplKBUIOQAw5F6PzEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759874634; c=relaxed/simple;
	bh=rbzUwIMYCtNmcOG3CgROn7GONtp/O0jT7B1DopxlO5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jTqBjBwMLq8NScRx8JSW/BMH65YWqTYeVROTRqQH48yCtp4mWYezNa+vxgzn5t9UHUu2F1kSZBedWZxDPg66y7XZFZqddvMwq5N+xrFa39Zb4sBZBb8wh+dP4NchnZaAS5Sbnaew0g+DDumTXUoVHti882G+HnhSvhobAXteUdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QTJsXM56; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso54778115e9.3
        for <bpf@vger.kernel.org>; Tue, 07 Oct 2025 15:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759874631; x=1760479431; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KCZgY7BO+8214iTbpizu8BvyIZ4pdSPSAZPIcyeWlJI=;
        b=QTJsXM56vMPJcnU4IGaQ0m0bKzZhkBrGV6rEjX9BedQ1V7+ZJz7lvNhGr5UMknoJNd
         Wjnu2Y4gmVHvjQXNNK71Uj8deRv+WyyDvnAJiDhPM8ta3hYZ2OBW7ZizabUTgDvZzQEx
         Rzv35S6hNA2jh7jj/DUE1+6wW6w/mzKw8CNTvrQNlv2YdEqMhI79u3AcW/kePhawxMbb
         WJ9JUibwORPszIVSWSFpnaPs99v9hcVC8/pTJfkhPlzAAQxqYielL2YmnUbIWuxkoqKm
         INYIsgZUPaD4FTJDhCbalU2vG+/MHEF0xkuk6WHeSGq81m7zb41TwGl3/DJZ6xn6xq74
         AATA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759874631; x=1760479431;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KCZgY7BO+8214iTbpizu8BvyIZ4pdSPSAZPIcyeWlJI=;
        b=cGVPb1n2mJobfzCGRgdiZSvoG32mb7h71JLBNA3T63JmDRYaF8l1VtsgfblQxI5bfH
         GPfoBN2TZ6xwx8g5M2F5gSnIJx5vOfRjBCS5/GTxdsectTQrpWQvBxdfl9KcLUXx2lw0
         O40XXqlnLaFb9GOMv+9Mm+4h41y7Gt3Ke2/l3Wwanu53lOJ93kulvm5oxypfYrhJ3aZJ
         b+crK0whECi/cMhQVR++Ilxj2UNjZXyy3lzxVGElBD7pV0AZ3QDAllGzZYsqidPEL8aI
         0KrDYGhGNTZ1YjoMNsnVwmPwhxyq4ifeA3V/M77lN0zZY2YES7rJa2Er+NimQ2l+SLfa
         9DiA==
X-Gm-Message-State: AOJu0YyqBt1FwTdozK2CHPHADUVIq18bB//WqM/++lkOvU2TJ0Nmz/r4
	y1q/tMdRsSzW3hzQUOwPzZByUdd5adoYKhJcwuYnNFGdMkWl70c5Qi6n2RJSVeCM
X-Gm-Gg: ASbGncu2M6VCJF0Dw2bgE6mnsmYrWo9phPptCg6bZNL64jbXJ/9kYt+Id97uVXP+/w9
	Da+tXVt1iEJTuTb0T/Mb0FQEnPP1YjrqwvXVIln/71MavjCu7cGvcHNSaPk9DgrRrCEvvAjPjR7
	zfypnueqa/9DZq5mGIQyi8bZL3u5R9PPiPK2uMZaer7nmO+m6PZOnbBh3cn1Z6n8/sSqjeZm6Vh
	ky/lOQMcbGeay7h//9su7D3I6PIoA+wHvURuBj2px4YqK8uMJZ1UgAYo6A9U2HmqJqRJ6VYgUjy
	LVDRO0LWxFRYOG2IS11EObB3SZFd0/9Mcab9mWkuVy4hYKaPV3oDWHEZYiEj+7j768BVNjivJ7Q
	x+zZX3QuPx3gukIRRkfAXRBXct5+1heQ2kIjKHQRri5+9t4QwBT4qY1IujI/0Ugt9Ut4OfVZrDs
	d30EiZH60ViUCkQcHhZfanx9Ji
X-Google-Smtp-Source: AGHT+IFOz1UK3PLb9R+EgMs2wrm68dvRVrHO5GYJ4Qq3kp052KLf8eBX07xU0qo/AiqbyEqh370Ncw==
X-Received: by 2002:a05:600c:5488:b0:46e:45f7:34fc with SMTP id 5b1f17b1804b1-46fa9b105ffmr7532965e9.29.1759874630407;
        Tue, 07 Oct 2025 15:03:50 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-46fa9c21302sm10133955e9.14.2025.10.07.15.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 15:03:49 -0700 (PDT)
From: Kumar Kartikeya Dwivedi <memxor@gmail.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	kkd@meta.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next v2 0/3] Fix sleepable context tracking for async callbacks
Date: Tue,  7 Oct 2025 22:03:46 +0000
Message-ID: <20251007220349.3852807-1-memxor@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2008; i=memxor@gmail.com; h=from:subject; bh=rbzUwIMYCtNmcOG3CgROn7GONtp/O0jT7B1DopxlO5s=; b=owEBbQKS/ZANAwAKAUzgyIZIvxHKAcsmYgBo5Ym3la4J4KgshW51oaY9sow3gIzNocYoHX65B xATSQeBKzGJAjMEAAEKAB0WIQRLvip+Buz51YI8YRFM4MiGSL8RygUCaOWJtwAKCRBM4MiGSL8R yqowEACDN6+S7bF1WRru8yt1ZjxKO2GT6OvF1XkbyRYnVpiDZW2M8JPMuK73ajOj+iLYBaKFZdz m0FxskKW2uMzRtWzPZTV8U9BbmMCr8gun+p+wVrIZx4zJOitbYuhEWYqa2TC2Ibxv2zFW6/VihG tB04suMSjlQRumRpM4YpzAwwXdrUtfUOSb0haIZ/pnIkOn+bMfT01NJJrY1YpUvz0A3CZAvgXRH d8dD8bINQK5OAiKMk3ZStj4egyDzjwWOIfhdVuRFxnj15z9Wqtpo1oanIh7scDZk53h4cy2iYjg AMUSq3+5HZr2wIjQnatSkrIzayQe3qsqpiMNx1iO6aNJoIfCFj3u/kENYGLXnFV6Q9ZUkHfFP3M uxjVi6ham2tQg7DEZLBMTEFS4q2+yY4nuuJfUrcQlXBqU/dGTX61xiJskrLVCSnVO/1l197P9hM Qa4hX7FxzcLEAGD+vox3eqmewEMIBaaPjK1UAzQnEnpXdgIApAnQdf5h7RYmG3u/ImZ5xL5QMDn dth5nfLsrUECcqzQ6LU9bwb7vm4PXd+wvCoZj6AjQcFNCJ5MYFwMdFXz6iahP6T4d7ngcgvB5Bt 9fE+KBm0paQNwVt21Tf1EFfiYNnfnc2rgDve6U3IpIU8AEunNEGORnpGb9QUd489MR56LCd6uhd 1Hv3xQcgzWWWo5w==
X-Developer-Key: i=memxor@gmail.com; a=openpgp; fpr=4BBE2A7E06ECF9D5823C61114CE0C88648BF11CA
Content-Transfer-Encoding: 8bit

Currently, asynchronous execution primitives set up their callback
execution simulation using push_async_cb, which will end up inheriting
the sleepable or non-sleepable bit from the program triggering the
simulation of the callback. This is incorrect, as the actual execution
context of the asynchronous callback has nothing to do with the program
arming its execution.

This set fixes this oversight, and supplies a few test cases ensuring
the correct behavior is tested across different types of primitives
(i.e. timer, wq, task_work).

While looking at this bug, it was noticed that the GFP flag setting
logic for storage_get helpers is also broken, hence fix it while we
are at it.

PSA: These fixes and unit tests were primarily produced by prompting an
AI assistant (Claude), and then modified in minor ways, in an exercise
to understand how useful it can be at general kernel development tasks.

Changelog:
----------
v1 -> v2
v1: https://lore.kernel.org/bpf/20251007014310.2889183-1-memxor@gmail.com

 * Squash fix for GFP flags into 1st commit. (Eduard)
 * Add a commit refactoring func_atomic to non_sleepable, make it
   generic, also set for kfuncs in addition to helpers. (Eduard)
 * Leave selftest as-is, coverage for global subprogs calling sleepable
   kfuncs or helpers is provided in rcu_read_lock.c.

Kumar Kartikeya Dwivedi (3):
  bpf: Fix sleepable context for async callbacks
  bpf: Refactor storage_get_func_atomic to generic non_sleepable flag
  selftests/bpf: Add tests for async cb context

 include/linux/bpf_verifier.h                  |   2 +-
 kernel/bpf/verifier.c                         |  54 ++++--
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_async_cb_context.c     | 181 ++++++++++++++++++
 4 files changed, 221 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_async_cb_context.c


base-commit: 0db4941d9dae159d887e7e2eac7e54e60c3aac87
-- 
2.51.0



Return-Path: <bpf+bounces-56873-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739A4A9FC0F
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 23:15:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC0D6188A05F
	for <lists+bpf@lfdr.de>; Mon, 28 Apr 2025 21:16:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EB601CB31D;
	Mon, 28 Apr 2025 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KDljh1YV"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D2528399
	for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 21:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745874948; cv=none; b=UdLk3NFgEwvCy4l13wM0VYKfzu+AZQxk3IKtUCP3NZyu0h12IaQBD2ZPtIU0X4bSIzvjhq11peJb6HT863BtUSyzCyBzu+/pjGELlB5KxyH8cZ5PZECgqqZ0FhiXZ0rCsSaPIJUwYkaNqKWWA7nEgSkNkfT3/4WX7VblILO2r4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745874948; c=relaxed/simple;
	bh=25zGVl3AzEC5aNZXC7O6v7JpZxO8oCf4x6KmaxKmk34=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=XjnBnn3nonincMrtqJpftA3DTA4sCYArno2rWLpXHg9wGo/4xtby3IbKpPCwrcbk8gGQyTCvN3ScPZ9UE2Fd/n0KKMD+bGkAWTb4ppABsTdv9Ku82AxtuxQ5121Z5ECsIiay2cAp3dzOQ6eTDeyi9TnIqvmGd4Y3s1YLPzluNnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KDljh1YV; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--zhuyifei.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-af5310c1ac1so3016744a12.2
        for <bpf@vger.kernel.org>; Mon, 28 Apr 2025 14:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745874946; x=1746479746; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=b09xnjWb8q+fXsXpXCF/ZFVhMFvSML+V0WFSLdrSB2g=;
        b=KDljh1YVJ/aSzD2yfY97hx6GEZtElHp6oHoKYKVq7EfROe2F7gistv1BmZqnZAz+L3
         npciR7Sc9p6sxS4KH8emLtOp1K9i7n5fg4+0X+Rfwr7r7XuNDathvhwwNdXrwMHwKSY8
         p5ElPIv0Js38cQhceRM8Kfn4nKfNcIDI9Of2GtOkUyZWi528P171e63CtPBpJk7ud6KK
         xI79jBC/6vBCBE7RQ3B+++IpTKutv7gSAH5ojOBsst8F8694YuEa9eDsDqGBo8rZE0H1
         cFbBYY4quLHgUI/d41N4aeKppuxwOaSKxP0OljPXecZ6bcb9vx0CewlU3lnuzlNQcLtW
         ClSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745874946; x=1746479746;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b09xnjWb8q+fXsXpXCF/ZFVhMFvSML+V0WFSLdrSB2g=;
        b=BU9irlq4elBdaba0iezsBTp5zMoaaEBZS5RIgCuk3C6o0y/4cjs//bFjMp0oTHFwIR
         LgyV+1QXs0rfdeipYFKtmQ3LWh0g384pK+SX/2+n6l45YRs/6/fW5cJ+TbTNT7ugADKd
         6RNYqH9uzaPFtCT56/Sbk/GgI/ADzefOU2caAZcq99673fqGcH6C/zjnN32/Jo2yOKCs
         ItPctITEV/tC5vBdSule1mj+85AKY0VRsI0+Oovm+ybrBz8SXe7t8hIdyLdhziZTinFW
         GMG9QKiXFNZ0lFoYF36RfJ3NsvQXsFONp9j9ECXB0TwsKeS6d0t0VT2niweJybvWyr3u
         4seQ==
X-Gm-Message-State: AOJu0YyGIYatyeO8hra0yJUnacsOIEL4rh9Qx1lNg9Rxnl1HnwrecaSA
	7OsUVd7+RvGMgBTKyCvcBITAEaol9ICsEP3hVZSG47sRwbQAZc3KPpHfBg/vX7iqWl9FqaHTPi4
	F2KKznW4f7lY04VYDfIknVadSVJvDAP066+rnT6+hhWeMFTH1kR7zfGhPhxQa9/8mHdD5utxe/X
	tSO4M+WNdrI39NtYYhrWMsIj4Ifm8n75k2eWvNcp4=
X-Google-Smtp-Source: AGHT+IF1AMSEueoDumoRzC1U4wmgH8T+9V8hckhwT3D7T7JMFbtyvOtiyeVNKNXIDbgJuLHPqdeHIuTLhzi1Kw==
X-Received: from pjbqc17.prod.google.com ([2002:a17:90b:2891:b0:2ef:82c0:cb8d])
 (user=zhuyifei job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90b:1f88:b0:2f4:49d8:e6f6 with SMTP id 98e67ed59e1d1-30a220b364cmr884634a91.3.1745874946281;
 Mon, 28 Apr 2025 14:15:46 -0700 (PDT)
Date: Mon, 28 Apr 2025 21:15:36 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <20250428211536.1651456-1-zhuyifei@google.com>
Subject: [PATCH bpf] bpftool: Fix regression of "bpftool cgroup tree" EINVAL
 on older kernels
From: YiFei Zhu <zhuyifei@google.com>
To: bpf@vger.kernel.org
Cc: Quentin Monnet <qmo@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Kenta Tada <tadakentaso@gmail.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Ian Rogers <irogers@google.com>, Greg Thelen <gthelen@google.com>, 
	Mahesh Bandewar <maheshb@google.com>, Minh-Anh Nguyen <minhanhdn@google.com>, 
	Sagarika Sharma <sharmasagarika@google.com>, XuanYao Zhang <xuanyao@google.com>, 
	YiFei Zhu <zhuyifei@google.com>
Content-Type: text/plain; charset="UTF-8"

If cgroup_has_attached_progs queries an attach type not supported
by the running kernel, due to the kernel being older than the bpftool
build, it would encounter an -EINVAL from BPF_PROG_QUERY syscall.

Prior to commit 98b303c9bf05 ("bpftool: Query only cgroup-related
attach types"), this EINVAL would be ignored by the function, allowing
the function to only consider supported attach types. The commit
changed so that, instead of querying all attach types, only attach
types from the array `cgroup_attach_types` is queried. The assumption
is that because these are only cgroup attach types, they should all
be supported. Unfortunately this assumption may be false when the
kernel is older than the bpftool build, where the attach types queried
by bpftool is not yet implemented in the kernel. This would result in
errors such as:

  $ bpftool cgroup tree
  CgroupPath
  ID       AttachType      AttachFlags     Name
  Error: can't query bpf programs attached to /sys/fs/cgroup: Invalid argument

This patch restores the logic of ignoring EINVAL from prior to that patch.

Fixes: 98b303c9bf05 ("bpftool: Query only cgroup-related attach types")
Reported-by: Sagarika Sharma <sharmasagarika@google.com>
Reported-by: Minh-Anh Nguyen <minhanhdn@google.com>
Signed-off-by: YiFei Zhu <zhuyifei@google.com>
---
 tools/bpf/bpftool/cgroup.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bpf/bpftool/cgroup.c b/tools/bpf/bpftool/cgroup.c
index 93b139bfb9880..3f1d6be512151 100644
--- a/tools/bpf/bpftool/cgroup.c
+++ b/tools/bpf/bpftool/cgroup.c
@@ -221,7 +221,7 @@ static int cgroup_has_attached_progs(int cgroup_fd)
 	for (i = 0; i < ARRAY_SIZE(cgroup_attach_types); i++) {
 		int count = count_attached_bpf_progs(cgroup_fd, cgroup_attach_types[i]);
 
-		if (count < 0)
+		if (count < 0 && errno != EINVAL)
 			return -1;
 
 		if (count > 0) {
-- 
2.49.0.901.g37484f566f-goog



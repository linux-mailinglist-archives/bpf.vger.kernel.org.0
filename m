Return-Path: <bpf+bounces-27993-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ED5D8B4292
	for <lists+bpf@lfdr.de>; Sat, 27 Apr 2024 01:16:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDE8AB21277
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 23:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 000E93B2A2;
	Fri, 26 Apr 2024 23:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T96rcwpG"
X-Original-To: bpf@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6D43C092
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 23:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714173385; cv=none; b=OOI5epdqmdIyb0SHH0/CVwLRtwzHcS+EXbz8u3VUBJyA9Js22cDF5eID8ql+f7tYIDtT2PjpovUMkCFwzIA9stuuThgmCi+0Tx3OflnVRF6WMQvh0htJtSlyjqKfucXZR8P3mYCjeWF8Nf00PRZpyMHInySQBaK9jfIgMvmU9mI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714173385; c=relaxed/simple;
	bh=Hw/Vm6LZ8E8f3p/6pvkT071TnyXIs5Nkopf7kc1tD7Y=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GCvpCvqEYe4pYq/Blgo9EfqBvr043Yw23j0dN8OTrRG4E029k1ppecYCZgBnKfDrTGo+DM5YQU0LMQdHeAv/LzfFFegs+rkNpb+irOmxcZZrpMaJndeP9d3pPLCl66ykX3rmiY3dLBDhoemz1ETjxaWpONvSgFjia80bXMiTb2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T96rcwpG; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--sdf.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-61510f72bb3so52550157b3.0
        for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 16:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714173383; x=1714778183; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6hE36stZFSpFdLbNBoVyWYgwDMImxgjqRQJEYsVAq9Q=;
        b=T96rcwpGEMOfZWDx/uX36rJ9L7M2iDywlMio2ROYutMlJjdYdGYpEd3j+bhPt3lm4C
         fK6fLGapJZ3by+JjwZqpwayJNSWsvx4Fm4pPKYd0lCojovd3wSDn7uIWrtVVdWZWjY2l
         9xNvrFAjcGV5iMir7Gruc4lJPmCpdcCGqOkv9nvltFOZBusucoO1F0OHocT6ke7EnQEN
         8bRWCpslPDp2czhVOhuRiytGHqmLvnS1YIWe+WQSYGz3N7R3zqMzxp2jOGyIEo52SXt9
         iaPSELk/ah9pgc1AkDjYGa4upAmgXYohQiEhvERs2F8xO8VDJHxtTAC6lo50iQWa9cMA
         BUog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714173383; x=1714778183;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6hE36stZFSpFdLbNBoVyWYgwDMImxgjqRQJEYsVAq9Q=;
        b=edLF42xo4Mgmp6xXQZ1cfBDl97Q0f2dKRk/FLjGnDL8T6HGfZq0AufEksiR0T+Cmgw
         Jp0gFUu33QazjwdXfGDluOiMPuVPUOBQCQt6Y1zWFBlGj2ZiXhAwdQRBvPY058GfoFVL
         H919WSn4X8lJqA8jWipdDy8nLCYx1CcDt7tVHdFV3FlneFvKPnmDJwXzEGMSqyx71da4
         8rwiJIQHAk8PMcGbqXmcksiXPmyDUJ6BugOO1S0krbjypSDp3fMydCSn/E7Amg63BPy0
         8AklyDEw9wPviWpuFSeLXuafOy/Ze2ATFEY/7nLq2NFvbnMpFAlQvR5ktDtFB9Rd4G4N
         +3ng==
X-Gm-Message-State: AOJu0YwLJz08WvYilCW1r3KW85gqmO8DYiPdj7ENveGH5IXHx2SiNQK1
	bWqt+npagrgB6J7/+iMFc/w9gsxHzigJUOTZg8Z5Ee27Odgx6vZLBta52xnXdEKETgVwx8TPuHW
	+a2rswk7y+5qeNvBGnsybmxKN0O+jgcpU76VXAVxH4EQjFqDvr7aolWIVUeYtXM9gic0nNc72lk
	FtgjgtQO+P8V07
X-Google-Smtp-Source: AGHT+IFBo8RF51gRGqri0rLARvh73ixOcb8Mq3xEpt0vPf3CxbirCHkuIF+JsoDbSRswMgqKXkYV9MI=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a05:6902:72b:b0:de5:319b:a226 with SMTP id
 l11-20020a056902072b00b00de5319ba226mr1212592ybt.1.1714173383019; Fri, 26 Apr
 2024 16:16:23 -0700 (PDT)
Date: Fri, 26 Apr 2024 16:16:17 -0700
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240426231621.2716876-1-sdf@google.com>
Subject: [PATCH bpf 0/3] bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type
 enforcement in BPF_LINK_CREATE
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org, netdev@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

Syzkaller found a case where it's possible to attach cgroup_skb program
to the sockopt hooks. Apparently it's currently possible to do that,
but only when using BPF_LINK_CREATE API. The first patch in the series
has more info on why that happens.

Stanislav Fomichev (3):
  bpf: Add BPF_PROG_TYPE_CGROUP_SKB attach type enforcement in
    BPF_LINK_CREATE
  selftests/bpf: Extend sockopt tests to use BPF_LINK_CREATE
  selftests/bpf: Add sockopt case to verify prog_type

 kernel/bpf/syscall.c                          |  5 ++
 .../selftests/bpf/prog_tests/sockopt.c        | 65 ++++++++++++++++---
 2 files changed, 62 insertions(+), 8 deletions(-)

-- 
2.44.0.769.g3c40516874-goog



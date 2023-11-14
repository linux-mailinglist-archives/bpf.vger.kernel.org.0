Return-Path: <bpf+bounces-15042-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 559187EA9D9
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 05:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E5FDB20A5B
	for <lists+bpf@lfdr.de>; Tue, 14 Nov 2023 04:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C41DDBA50;
	Tue, 14 Nov 2023 04:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SqPA7Yz4"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3313BE4D
	for <bpf@vger.kernel.org>; Tue, 14 Nov 2023 04:54:57 +0000 (UTC)
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 765DC123
	for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:54:56 -0800 (PST)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5a7cc433782so61739637b3.3
        for <bpf@vger.kernel.org>; Mon, 13 Nov 2023 20:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1699937695; x=1700542495; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n3reLfyyQbqXYuSA2bWx74AFYSeHyD/Rwn7FvvwnaJA=;
        b=SqPA7Yz4QDh5U6ColuTGa3SfyPaXvXamrxkuVdvJ3FYAquAIeIXyFDd3tMPt7CtdLd
         T4W0CotUM66JQIJ0oMe1rq+82z5/24vkreYeveF0K8cn2jVIA7VL7QTYtgsBBEXAdwCE
         s2Y1faLQvmti61laM551jIecd9JRWqZfD56W4kQZihD2EsScleNWcbfmoxUvZigGqFj1
         tEatHRe2ihzw2Sm5zSc3dV81vWRcyUjTbYbzUfHiu47IXkY1p8QuPoNK9WSNAjXhbdWP
         jO6gAt0tHyZzM07cmveBkPK9aWMCpycmSp1vfm5AzgNzFVuXobnO2tOqV722bPW50Ofj
         mveQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937695; x=1700542495;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n3reLfyyQbqXYuSA2bWx74AFYSeHyD/Rwn7FvvwnaJA=;
        b=J/u/4mVLBFEUQN1ikeGVFjNnTONMy5BrUsUZkqc8mA30EJIaG1oYEvrdesEFJBCC2j
         xYwJJ4SI5LyGb7/nACnrWgTnnSv68UwQcK1y7KYrSORTZuZDyAENB5OEKPc+IeRa6aR3
         vahG+0b2P9vi02vWEcCg/JdZyC+SKg7LL90aF6zi/j8XREOO+L/aUOBC6IvUBqzMgz1F
         VMKcZBKO3FeRbVLHyAK288DzquU+qcOASIX3qdxWaiGPs6vYQZC8AVA0OTcBtxFtua7R
         MaWYS+CGnbX547AaY9L2abF2bfIVDgQNm48wDqOqifv/Mz/+ReWMh2aG2k8VRCLP3Q9o
         Yn9A==
X-Gm-Message-State: AOJu0Yxg9tRJODu4arEpoulJeqCgZ2J3hbK4i3Po8PAjHvc+WFFRdHEY
	Fa16MPg0SymhmEOGrRcvLCFyC7sUux/YFsSQsMKRKRVQ4srABALrEqO9UqXH/wq4De1todPIHLX
	2bR8WGKSZ9WN806Qx96Xx0+lp6GxGfLitzzTg7UVaDaqxK6R1lQ==
X-Google-Smtp-Source: AGHT+IGH6sqOVtqMkGdl5xD1nL+Ma4GiEtl2N4FYaKVrfwEMb8XApSsIeiDBv35pAhoIWJPl7JUih9I=
X-Received: from sdf.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5935])
 (user=sdf job=sendgmr) by 2002:a25:ae1a:0:b0:da0:3117:f35 with SMTP id
 a26-20020a25ae1a000000b00da031170f35mr213355ybj.3.1699937695231; Mon, 13 Nov
 2023 20:54:55 -0800 (PST)
Date: Mon, 13 Nov 2023 20:54:51 -0800
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
Message-ID: <20231114045453.1816995-1-sdf@google.com>
Subject: [PATCH bpf-next 0/2] bpf: fix couple of netdevsim issues
From: Stanislav Fomichev <sdf@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, 
	martin.lau@linux.dev, song@kernel.org, yhs@fb.com, john.fastabend@gmail.com, 
	kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org
Content-Type: text/plain; charset="UTF-8"

The first one is found by the syzkaller and needs to make a proper
distinction between offloaded and dev-bound cases.

The second one restores behavior where the offloaded/dev-bound programs
with a dead netdev were not correctly skipped during BPF_PROG_GET_NEXT_ID.

Stanislav Fomichev (2):
  netdevsim: don't accept device bound programs
  bpf: bring back removal of dev-bound id from idr

 drivers/net/netdevsim/bpf.c |  4 ++--
 include/linux/bpf.h         |  2 ++
 kernel/bpf/offload.c        |  3 +++
 kernel/bpf/syscall.c        | 15 +++++++++++----
 4 files changed, 18 insertions(+), 6 deletions(-)

-- 
2.42.0.869.gea05f2083d-goog



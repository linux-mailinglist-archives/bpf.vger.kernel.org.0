Return-Path: <bpf+bounces-14222-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3B77E13AF
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 14:35:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3ED541C20A3C
	for <lists+bpf@lfdr.de>; Sun,  5 Nov 2023 13:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B68C2E3;
	Sun,  5 Nov 2023 13:35:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="EqiApErM"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150644423
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 13:35:08 +0000 (UTC)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ECF4CC
	for <bpf@vger.kernel.org>; Sun,  5 Nov 2023 05:35:07 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso2738269a12.3
        for <bpf@vger.kernel.org>; Sun, 05 Nov 2023 05:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1699191306; x=1699796106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GLUxCAvMAMlQ5S3jRvjvA+djKH82qjmPj//5dOcsTPk=;
        b=EqiApErMykJRakwln2pEQ+WWpSPPj/ZTsA8f+zUq6ktqa0Lq8RZcQhfeCWZuItYIcP
         XpmsgkZ2Tyh3RqQcOEWVYPGRt8Bqh0IMdcqW/+Prjo9hWqD/klxng0KJ/Xu4rap5TblJ
         G+unuOHK4hbwby8l6q6qo3HoLO3MEFo98/+ZA1GDsKzG2TogNT6lyeOLNz1JPXXCNMpI
         wEQ1NqtTdevaxPi6+o7rxCyFuLYoAoLFZ9ncphJ6PIt4n+iqtOP2NO0ywLaXroA3kHh2
         881/bWNfNfFj5oSTR3vL1AMzF15qSHwt9sY52E8x15pZCG3z8HavgZTcDVHYi48RiqbP
         bXow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699191306; x=1699796106;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GLUxCAvMAMlQ5S3jRvjvA+djKH82qjmPj//5dOcsTPk=;
        b=S779TTMmJnct3XfkHPeVFacBwhypXyRmW+Th7VCdfDUf7ehDbhXPV0dCG5en5RP4Jv
         /X6NXSnBhk6Riiv3tAeeyvHvA6ub8Njxe7OXRCQmDN9pU+XP5BzMFwl9opO9vXzqzepz
         yLtsFP50EQrrMSzFkzBIB3kK0edgv6SfuuQgbQ9PJPgzF80myA9Al+qyw0D0lkrGtGaH
         6VHMT2QbntcWS8TP4/S/JMAeVOvcFV9pwICIwnASz2H7Cn8g3qq+6qWUz2QQg6Iexdix
         XGE2jIB2k9pT0cFAFVMLYlJP95JTRRpdsEgYbf1frsN1UDmDoobx5jpSzHYPOImkwK3k
         UI+g==
X-Gm-Message-State: AOJu0Yy+QG4DtoZi4YfZSPlISRk1ByF/nukdcu//3fH5PhAavepypsjh
	p0N9mGGF5mTHnzr1XP2aIJe69OU76AMg5WtChN0=
X-Google-Smtp-Source: AGHT+IGZx1puYo+KVmUUUG7q2BUtI6+whTxpxivvIC6FTbSTcb2ldO3p3FzGnqCsXxHmbMjme7Y68A==
X-Received: by 2002:a05:6a20:6a0d:b0:160:a752:59e with SMTP id p13-20020a056a206a0d00b00160a752059emr31520498pzk.40.1699191306647;
        Sun, 05 Nov 2023 05:35:06 -0800 (PST)
Received: from n37-019-243.byted.org ([180.184.51.142])
        by smtp.gmail.com with ESMTPSA id iw21-20020a170903045500b001c8a0879805sm4219711plb.206.2023.11.05.05.35.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 05:35:06 -0800 (PST)
From: Chuyi Zhou <zhouchuyi@bytedance.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org,
	Chuyi Zhou <zhouchuyi@bytedance.com>
Subject: [PATCH bpf 0/2] Let BPF verifier consider {task,cgroup} is trusted in bpf_iter_reg
Date: Sun,  5 Nov 2023 21:34:56 +0800
Message-Id: <20231105133458.1315620-1-zhouchuyi@bytedance.com>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,
The patchset aims to let the BPF verivier consider
bpf_iter__cgroup->cgroup and bpf_iter__task->task is trused suggested by
Alexei[1].

Please see individual patches for more details. And comments are always
welcome.

Link[1]:https://lore.kernel.org/bpf/20231022154527.229117-1-zhouchuyi@bytedance.com/T/#mb57725edc8ccdd50a1b165765c7619b4d65ed1b0

Chuyi Zhou (2):
  bpf: Let verifier consider {task,cgroup} is trusted in bpf_iter_reg
  selftests/bpf: get trusted cgrp from bpf_iter__cgroup directly

 kernel/bpf/cgroup_iter.c                         |  2 +-
 kernel/bpf/task_iter.c                           |  2 +-
 .../testing/selftests/bpf/progs/iters_css_task.c | 16 ++++------------
 3 files changed, 6 insertions(+), 14 deletions(-)

-- 
2.20.1



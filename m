Return-Path: <bpf+bounces-30639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931988CFEBE
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 13:20:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4C151C21775
	for <lists+bpf@lfdr.de>; Mon, 27 May 2024 11:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691FF13C683;
	Mon, 27 May 2024 11:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="c9PKlWp3"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E36913A268
	for <bpf@vger.kernel.org>; Mon, 27 May 2024 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716808828; cv=none; b=J5WQFuSD0oiOT+ub864KBipiw2egEWGj65LcmmxUnKwvcmUX3BSwbDJhXbF8hPmDVUufuQZMvgNuh0jcK7cw0PG2mBDNqL/fWFFVflo6QokL07QDTzVRwZn7AgG+tnqLISqQY+pGUe5NbnNpZFHt6xRmN7szu6MjMMLB9HEIp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716808828; c=relaxed/simple;
	bh=mHPvcqlCPiD4ixpIV8umGn/U1pQHvruErBuxYy244fw=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=nfo5M9iihhgpaChnRt0K2kOxMBibpGNoUuKIsJzF0pe4+VgYd3b2W3HDSePcQthjErbN8QgsJl9b+rOV/ziCzOb6LVvb6FtKGcU2eriPf79auy3H+LWuDJdPk5s7C7Ufd4VfQ/RfJYRpHczDxCiBBu+1RiBWvGCbfp+LJQTo+SM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=c9PKlWp3; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-529661f2552so2921965e87.2
        for <bpf@vger.kernel.org>; Mon, 27 May 2024 04:20:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1716808825; x=1717413625; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D2Bb3MybI19ggammqMmoal9CWEBsf796KZVXAW0oF/0=;
        b=c9PKlWp3MzKGz68P0bzJeuloY6gQrNfCS5Ha695uU6w/I27IgQVKNgH6vfBLkPJr+7
         mgFIl0d38TCEG8hLEFOiedogmj5ci6/nKPSAgPntqbTmjbQ89J2xr4277sgsQNXATjNs
         Ms45NejMpclI1qhtAKyPUl+YE7ZhRXnu78rjOnSyoxCyn9r4qTIC0gLJ3xrEwrwuUVbM
         eLgM8q4JdxJgN6AvZwq3kg4gVwO7f/hpAFi6hUYzAwzmC8yJzpY9KgoMbjOpB0fMyS4V
         3Pbq/qH//z/zPN6rwqZNa7cDgzrn5+7LM/oGoSOTYBwgfd3EVL/zCDTy+Bq5JTJz2F72
         Wdeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716808825; x=1717413625;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D2Bb3MybI19ggammqMmoal9CWEBsf796KZVXAW0oF/0=;
        b=Uagj6RDphfjYz+9V1uvtfwagHw30C3CAqazv3Q8bzBVHdPbwRJIdPyTpI9UqR1ljm2
         nDdBPCPCXe8WVsTGbi1dQuB+uMoCj6dDAXMo0rbKkyVfT+5A818Rk3NQk28vTCajk95o
         pgSj/cbufh2gvWrgvd0GgqxNuZmWaF8O4uSsEVPqgWF+UZkHpZ8e1Dkq5LVvXZXMNIAd
         E5jc6vKiytN0phozC5Seo9K2DXUYL33Nc99JE5qQd1cKp3gWqhEHS/5YDZSctmVQc877
         yOeDiebfMrgTveqXRUgbrqusu5LPYKZDCXy7f5T12Dv+F7wkAlOVn62Z7TujZUxdq68w
         OoTQ==
X-Gm-Message-State: AOJu0YxbTM9EADdouwuM8JLQpmgn6jcsoxkHCytElFvM6k5mwriDtBEv
	WexaESfeUdFZYubOid9EFu6w9djWvzEX1kbNnugUCTIU1HjKurpn34EBPNGnANqSuzwCfj/NAb5
	a
X-Google-Smtp-Source: AGHT+IEnCJ46JCdkJSHOLT6ExYelSAqwKGqGgFektNI2vcBm9hMaznq6PKUUWLsephAZKKxctknQDw==
X-Received: by 2002:a05:6512:348c:b0:523:4230:9179 with SMTP id 2adb3069b0e04-52965761dc8mr5180099e87.40.1716808825379;
        Mon, 27 May 2024 04:20:25 -0700 (PDT)
Received: from cloudflare.com ([2a09:bac5:5063:2387::38a:20])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-57861b4ddefsm4401943a12.60.2024.05.27.04.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 May 2024 04:20:24 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Subject: [PATCH bpf 0/3] Block deletes from sockmap for tracing programs
Date: Mon, 27 May 2024 13:20:06 +0200
Message-Id: <20240527-sockmap-verify-deletes-v1-0-944b372f2101@cloudflare.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGZsVGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDUyNz3eL85OzcxALdMqC+tErdlNSc1JLUYl1LM1NTC2MTM/MkcwMloOa
 CotS0zAqwwdFKSQVpSrG1tQBL9a0sbQAAAA==
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, Hillf Danton <hdanton@sina.com>, 
 Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, 
 kernel-team@cloudflare.com, 
 syzbot+ec941d6e24f633a59172@syzkaller.appspotmail.com
X-Mailer: b4 0.13.0

We have seen a few syzkaller reports of locking violations triggered by
map_delete from sockmap/sockhash from an unexpected code path, for instance
when irqs were disabled, or during a kfree inside a map_update.

The consensus is [1] to block map_delete op in the verifier for programs
which are not allowed to update sockmap/sockhash already today, instead of
trying to make sockmap deletes lock-safe in every possible context.

[1] https://lore.kernel.org/r/87a5kfwe8l.fsf@cloudflare.com

---
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Hillf Danton <hdanton@sina.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>

---
Jakub Sitnicki (3):
      bpf: Allow delete from sockmap/sockhash only if update is allowed
      Revert "bpf, sockmap: Prevent lock inversion deadlock in map delete elem"
      selftests/bpf: Cover verifier checks for mutating sockmap/sockhash

 kernel/bpf/verifier.c                              |  10 +-
 net/core/sock_map.c                                |   6 -
 tools/testing/selftests/bpf/prog_tests/verifier.c  |   2 +
 .../selftests/bpf/progs/verifier_sockmap_mutate.c  | 187 +++++++++++++++++++++
 4 files changed, 196 insertions(+), 9 deletions(-)



Return-Path: <bpf+bounces-57162-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 01AD4AA6635
	for <lists+bpf@lfdr.de>; Fri,  2 May 2025 00:30:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE33C1BA6568
	for <lists+bpf@lfdr.de>; Thu,  1 May 2025 22:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD83265CDE;
	Thu,  1 May 2025 22:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dMrUlEMa"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F24F12116F6;
	Thu,  1 May 2025 22:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746138629; cv=none; b=TEZ5kA0NYrcyfch7k0KZt0QbmY4ggmaYFmfLnRGghBDZCMxtotJkMsrqWcSJR0oq1Ro5YIp0pV24oItwg0P+kb+RjPyXj5wTpuUAfDGiGfmiq/gGbvyF1go5b/T5lkLoYCHDw+xwEZbCFOrMULBgMmio0VUqcSS46n8/Q71B07I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746138629; c=relaxed/simple;
	bh=kLQep9bmg8wWr81k1RVnJWB8ytMKinxaaVMTlpawI0A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jYFTvT247K2dKPKblsnu967pMT5/6Vg+aEefMSMXG0CGGmoaDIwbFjBuBMHVJqLLpTVm6c1oiLgQBF1jETcK0a6PGWN+icBtIoRkeJkgnb3YKbJL5qAhEOWDWXefk2QGJSCcOPikd3YihC2N3d7cqgh/0qpvaBSPUAgx6CvKYzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dMrUlEMa; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-227b828de00so14784225ad.1;
        Thu, 01 May 2025 15:30:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746138627; x=1746743427; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yINMlcUVIapP1RPSyKuCq1GbWCHImvFpLdfYGwlgNrw=;
        b=dMrUlEMaNq0OSBd6m/y37kVTPsFwBjwnrhm0eT1RTyMpOVona2TMrC81YL6QzaSZvp
         CqTv42gVIsfCTduPf36vILCcbPszcuGFZ2ETwtZz97c1R9nV4H8fqILtRtetPB9MiG9e
         FChVUwjv1wgnVNENrsPhvGnszaPjjBkcB9Bzm54ST8nRtpEj9lKfuwlx/t36Me23zLEc
         Dbw0hYdKore5Du6QmU46MYhB51TGJvqx8ySk9hOgW9LIF5jvc85s6B8OEKcwhbacFYqU
         gyKWLBQGGDf6VrrQ2szEU7bmUQ+b5CeWT3sCIDMhPSB4VX1p4/XDljyBERns6z91bHxI
         1cQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746138627; x=1746743427;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yINMlcUVIapP1RPSyKuCq1GbWCHImvFpLdfYGwlgNrw=;
        b=oFdy5kCpOVW3qPn9UHcPQVmZtY+C/nwvLhaEZv9+g78yIPXml2iT3YtydM9bUCwpq/
         KfHNfnkQu5EsZg+/dLYtID8jecG6ZuTaX9rMnLhmNMB/ydRxSUia0bv3v9A9TRqDOD5W
         4V7NtDGpx4mBrQRq5DDI+L2/f2kuMxw/tEVj7AU7a02rdtcFlXsDmDP4hbZJt+jaEXz3
         pjvDOU5eXoVXZpiA3j1r0YesONZneyEWBo0Fw8t5W6DdpUyl0BcW6/dv9hgUQuy50ckZ
         jHBDqQ9RKPfTax88unsl1uLt2exj3B+jcQsz28NDKVxZUZNXklZC5OpCnUxjeK4gOrpU
         /PKQ==
X-Gm-Message-State: AOJu0YxhCzwzHljNjxSwDnBlSIROqXgZ0SblUsta3x3WlGPdcK55tMM0
	EwiKc9gYaqPSE9JZQ+50yIauT+hqD0vBwr7XJ63R764hjbQJVUmPHMqi0A==
X-Gm-Gg: ASbGncsTsuEtUgeF9MI6b306yyEwzJX7LgIR4ewJ7U/fipNLXlI8Z4doeIvc+07Uk5Z
	+Xja6C9I+F81YySC2K7cXvl8MrCg6V81Ewvxqzxq7t4hfMXwR+iB/ngrCkZw6lW7ggZd491HJHv
	klJQ9L12tWNqajl606+4EBMYl/qZ8uqUOvQiJ8d+6vqBa2HjLGvmKYq1ahd/N5aKVOHS2WMcjx7
	DBPqlR96aldxZ5FAl4AABLWgDTWQ5KYBcZuSGmDaCTY8LN6hjjIU8uhhWb8gpxbK6Do9J/dGSH2
	o5r51+jxeSO0u02L5TCzllVLkv4JUHMtr4jUw/G8Wes=
X-Google-Smtp-Source: AGHT+IF/SMFmWH5gx+rfK/8UZvxJdC1ATt7lo6NB5JaqFpkk0Y0bncxrb87ZkHGf5kUtZx/6fhqAMA==
X-Received: by 2002:a17:903:3b86:b0:220:c813:dfce with SMTP id d9443c01a7336-22e1033c8c8mr10189015ad.39.1746138627042;
        Thu, 01 May 2025 15:30:27 -0700 (PDT)
Received: from localhost ([2a03:2880:ff:73::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e108fd6a8sm1452715ad.133.2025.05.01.15.30.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 May 2025 15:30:26 -0700 (PDT)
From: Amery Hung <ameryhung@gmail.com>
To: bpf@vger.kernel.org
Cc: netdev@vger.kernel.org,
	alexei.starovoitov@gmail.com,
	andrii@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org,
	xiyou.wangcong@gmail.com,
	kernel-team@meta.com
Subject: [PATCH bpf-next/net v1 1/5] bpf: net_sched: Fix bpf qdisc init prologue when set as default qdisc
Date: Thu,  1 May 2025 15:30:21 -0700
Message-ID: <20250501223025.569020-2-ameryhung@gmail.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250501223025.569020-1-ameryhung@gmail.com>
References: <20250501223025.569020-1-ameryhung@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Allow .init to proceed if qdisc_lookup() returns NULL as it only happens
when called by qdisc_create_dflt() in mq/mqprio_init and the parent qdisc
has not been added to qdisc_hash yet. In qdisc_create(), the caller,
__tc_modify_qdisc(), would have made sure the parent qdisc already exist.

In addition, call qdisc_watchdog_init() whether .init succeeds or not to
prevent null-pointer dereference. In qdisc_create() and
qdisc_create_dflt(), if .init fails, .destroy will be called. As a
result, the destroy epilogue could call qdisc_watchdog_cancel() with an
uninitialized timer, causing null-pointer deference in hrtimer_cancel().

Fixes: Fixes: c8240344956e ("bpf: net_sched: Support implementation of Qdisc_ops in bpf")
Signed-off-by: Amery Hung <ameryhung@gmail.com>
---
 net/sched/bpf_qdisc.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/net/sched/bpf_qdisc.c b/net/sched/bpf_qdisc.c
index 9f32b305636f..a8efc3ff2b7e 100644
--- a/net/sched/bpf_qdisc.c
+++ b/net/sched/bpf_qdisc.c
@@ -234,18 +234,20 @@ __bpf_kfunc int bpf_qdisc_init_prologue(struct Qdisc *sch,
 	struct net_device *dev = qdisc_dev(sch);
 	struct Qdisc *p;
 
+	qdisc_watchdog_init(&q->watchdog, sch);
+
 	if (sch->parent != TC_H_ROOT) {
+		/* If qdisc_lookup() returns NULL, it means .init is called by
+		 * qdisc_create_dflt() in mq/mqprio_init and the parent qdisc
+		 * has not been added to qdisc_hash yet.
+		 */
 		p = qdisc_lookup(dev, TC_H_MAJ(sch->parent));
-		if (!p)
-			return -ENOENT;
-
-		if (!(p->flags & TCQ_F_MQROOT)) {
+		if (p && !(p->flags & TCQ_F_MQROOT)) {
 			NL_SET_ERR_MSG(extack, "BPF qdisc only supported on root or mq");
 			return -EINVAL;
 		}
 	}
 
-	qdisc_watchdog_init(&q->watchdog, sch);
 	return 0;
 }
 
-- 
2.47.1



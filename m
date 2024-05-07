Return-Path: <bpf+bounces-28771-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B55568BDE7F
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0C481C232E1
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 09:38:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95DA3156645;
	Tue,  7 May 2024 09:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MtT+8ywr"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE62155390;
	Tue,  7 May 2024 09:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074547; cv=none; b=drLS33OU0KDImWTemDXS/SlvjmF0Lrdry/x+jf+ZrHB3OUqPBvCn/x/VDjoURtLc6F3e15UAq98K52Sq16586KW9JT2n7XLtTF38eJDACNhvJHIUBUZifp+FDTJ8K+eYUBChT8yubgIUxJXDA6zClGWmXBNK1GYSG99H/3wnQ+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074547; c=relaxed/simple;
	bh=chdfDJkJUd2381b+AYErmHdsM+6kHBcN2R8PWQKTK+w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZldjTnukViJ49IyYLPPl/dXwoR5dmr+/JxUg8RbC4ickHWHshmB4IgGFui4jXpkReLLDh8QJ4dNoKLt6pBiGcv1gHFZy30x4Jf0fOrXw1RucqsgWQ+48t/ta322MpZvDLyJjmsEP+/BLQMbsK7PFl6MTZ4gmntlLOlTppamO3yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MtT+8ywr; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2e3f6166e4aso7187251fa.1;
        Tue, 07 May 2024 02:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074543; x=1715679343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qp9Gj7lq4ACmCS98GBHRZFh0tqGLeKwKmlOcd+I5en8=;
        b=MtT+8ywrCi5/iQhwutoypnQspkEBkOeIZ3ujcsFJewmsDbGXx6uzHcz+7KsakzSz3N
         /oJISuR6Vjaa58IlRdQ2xi9qE8mYaBnEJ/jt0VhNTFFrJ3cwVyDfSKAnQSE1qUy7Fhbm
         VHXpfrZxLKiDko0O20xheOore+68yCR3WR0HEDe8zHS3Tuakok80b4857eHUAhNwoU0a
         7OUIQ9DLSurTW5/fYqjaBYC310V+nHDOqZtTumQIcMh1e37jAvXNA/Qd7EGdHr/tFzkd
         ULb8QYz+Q4E1giAzOY0oYNyOSk7yZCxc7gCasQjaQMxN2pFwhxj09T75TfnRDztbIizr
         C3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074543; x=1715679343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qp9Gj7lq4ACmCS98GBHRZFh0tqGLeKwKmlOcd+I5en8=;
        b=Zhh/UtlKheF3Gx4Io58FsgUh1TCw3j7ztG3CQ2Z54EbUS0g3l7tSjNc5CgohqyTvpg
         nNZmNSearJUgYMOh60//2rXYlk31wlIiPN5lm06oGKvs/ZWkbRZi4xOdNMMTocVnmrSb
         vxpOaYzt+6no7CXYz+vNY7d3cJsel8L0IgEqEcxeo41O/BwcRhozTRemI5LQI7FqWC8f
         0WBY2gmsZK7Jzogzxdz4OMEQ0D9tS1fHWuVk6H1aa6bIwkuVYwLLUkAZRJP1aNMAuN0K
         X1laj1683FL75GjpsBZDO+1C6n9Ppb9LCBq8jIu84FPq5pAIvcAkgQNxhSPWGuS99RbJ
         n/xQ==
X-Forwarded-Encrypted: i=1; AJvYcCXreQtJiIo4EFqvgpFGG1cy7AEd6XhlTFhR1ERiOzXc0C1kmT4GgjEC/H289ilpC91edI8q919uuCLQmgdraCcTTgKeV0tNFtDG1L4fsaWFbLxO9PIpdSBBTpDtXekNS4uS
X-Gm-Message-State: AOJu0YygEgI3vICDO9iJqHiQfTITFSVJbvVLSBYNMBWCimOtzJAlzCKS
	6zBB9/lyjz1SacSIcyBtwrsRRSSRMLukuckQCgWPMmBAhmUDSYypQWsRQ59E
X-Google-Smtp-Source: AGHT+IE1e9KG4xXibyeIv5ywJLp8h+Y7KAHo9JjU55aHVH5tx8ojg9MGUZmij8FPRmFRUqtHpxZifw==
X-Received: by 2002:a2e:b8d4:0:b0:2e2:72a7:8440 with SMTP id s20-20020a2eb8d4000000b002e272a78440mr10513801ljp.41.1715074543428;
        Tue, 07 May 2024 02:35:43 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:43 -0700 (PDT)
From: "Uladzislau Rezki (Sony)" <urezki@gmail.com>
To: "Paul E . McKenney" <paulmck@kernel.org>
Cc: RCU <rcu@vger.kernel.org>,
	Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>,
	Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Uladzislau Rezki <urezki@gmail.com>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	bpf@vger.kernel.org,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 11/48] bpf: Select new NEED_TASKS_RCU Kconfig option
Date: Tue,  7 May 2024 11:34:53 +0200
Message-Id: <20240507093530.3043-12-urezki@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240507093530.3043-1-urezki@gmail.com>
References: <20240507093530.3043-1-urezki@gmail.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Paul E. McKenney" <paulmck@kernel.org>

Currently, if a Kconfig option depends on TASKS_RCU, it conditionally does
"select TASKS_RCU if PREEMPTION".  This works, but requires any change in
this enablement logic to be replicated across all such "select" clauses.
A new NEED_TASKS_RCU Kconfig option has been created to allow this
enablement logic to be in one place in kernel/rcu/Kconfig.

Therefore, make BPF select the new NEED_TASKS_RCU Kconfig option.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: <bpf@vger.kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/bpf/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/Kconfig b/kernel/bpf/Kconfig
index bc25f5098a25..4100df44c665 100644
--- a/kernel/bpf/Kconfig
+++ b/kernel/bpf/Kconfig
@@ -28,7 +28,7 @@ config BPF_SYSCALL
 	bool "Enable bpf() system call"
 	select BPF
 	select IRQ_WORK
-	select TASKS_RCU if PREEMPTION
+	select NEED_TASKS_RCU
 	select TASKS_TRACE_RCU
 	select BINARY_PRINTF
 	select NET_SOCK_MSG if NET
-- 
2.39.2



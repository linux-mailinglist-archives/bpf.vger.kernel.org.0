Return-Path: <bpf+bounces-28772-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B41708BDE86
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 11:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A7AE282DA0
	for <lists+bpf@lfdr.de>; Tue,  7 May 2024 09:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 921B915D5D2;
	Tue,  7 May 2024 09:35:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtzLRibQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D4715B11A;
	Tue,  7 May 2024 09:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715074551; cv=none; b=C31O6r5Lgnkr5mPrqyOXriq9ZaJIv+rIuCDWxzy9GqwgMpaNeweT1JK3hciQzF9kkB/jr9A/dJnLtkLbRvAyI1zC/L9SUdVAfbcAR/9CrPVCqUBQNaY49IVDhDwwOJKJPfCtdcRMnY8gGa1WQdlpVaWxGLFoq0Wy+vrbgBdmNHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715074551; c=relaxed/simple;
	bh=G5UgDUwYgbkYtBYd0068KteomsXMFoI4xHNbykAdpq8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dNWPNCHik5pgbLcaiWzM+X/fMB+XQNS7wnjO8I0ROuj/UBJiw5LW+ABa+AkTd1z4kBEUgCNWI4ROkROm2aaZWhZJES3s3uFT6BW9IVEguRxxdnAtF2HzwG0RM0DrI1ZOeoYSBKATC1hbGLox8zVj3+5uri1zm19hvb2Qx8xyHMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtzLRibQ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2e3e1ad0b19so8250161fa.0;
        Tue, 07 May 2024 02:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715074548; x=1715679348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/haxlK53UizV+SleK0qa7ThwxwFJdnlLNlR+JkvSJOE=;
        b=HtzLRibQ2FMBXjR7xQsprPaIwuSkHaplJiuUfg0EN0femlK2o2JM0DQBrPq33jxfJ2
         Ptmnr0+ZDGhB3aIy3hYF6PrOXd7dmpXHw+Ogwacy4JAyjepvl1ClvPsCd4EYAoK6/+w+
         n7+sjODPiODOJ9nbuCsddAIqfRgwkhww10T53VeiqFDB1V32LChC7Bs1huqIMK0RPPUP
         Q65dZuhQ8ue2DmYxa/Vw2vEfELn30t3ltSwS3y3CfIAwZPkXaq9Vp9SpqDSIW+vgrKUq
         17Ikx/EB4tVaYO3HNsCGlj63SNpjY/LqSDfWfBjbkROWPbarVv0C0g+4tWVU2h+KE4lR
         J2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715074548; x=1715679348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/haxlK53UizV+SleK0qa7ThwxwFJdnlLNlR+JkvSJOE=;
        b=kVJudqZuZwabvnVhdgqhvBQi357fSyFGLLD6GF7g/J/0nqRUsrC499Jfwzw8lzODOH
         DGsSWB/9AERAVHE5cwsVvKc6MRfNDyx6tpnSxWpT5XJ7bzXeovUxmz4o25zAqWu9TBGi
         lM3WP6P6dnIsEXo6Gk1O66z24dcLjW4+7jSb1A7hNg8NNlw4zg3DO56f2wEbPvIIhX3r
         g9rVwB0wTHn/vVkYeGgk+vkqr6D5MAlhi2rxgbE+wE/fUPLsghGXtgcKoD5mGUhb5rra
         qLVu/VjEqgkK44/5h2wYQegP70plyQ559JjpF3ZmuDlFVRQkAn4GOcDlikhsLL6w0x4E
         UmFQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2VyfD+7Vca4LHQkRrvyXBnN6T8mp/0/kTZbJGAIheVdXe6mQ0ITNzl5xHIF9A0LWh3GSCBPRp0qxowX39shGu0NkClE8ZSVsvzwYFf+ei8A2I2dun6OYNl5ab2+MUpYyu
X-Gm-Message-State: AOJu0Yzc2HTcPzAUTLuXrIci0Yf3iA2vIXz0wNjy+W6CA9ALF4+aHu2F
	2b1akwOAyJtPanjmjgI4kchhTQC4B2XCewDklL/OG9P/vxJEWm3+3ZFSmKID
X-Google-Smtp-Source: AGHT+IEoIfKd7XfhA0BRXVZFDJt+SXdbx+BppfUXbCeRu12K7jxUfWy7v/cBvFIssPL6qXdVfiZCLw==
X-Received: by 2002:a2e:2e0b:0:b0:2e2:3dac:447b with SMTP id u11-20020a2e2e0b000000b002e23dac447bmr9471075lju.18.1715074547523;
        Tue, 07 May 2024 02:35:47 -0700 (PDT)
Received: from pc638.lan (host-185-121-47-193.sydskane.nu. [185.121.47.193])
        by smtp.gmail.com with ESMTPSA id t18-20020a2e9d12000000b002e29c50c4dcsm1335473lji.27.2024.05.07.02.35.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 02:35:47 -0700 (PDT)
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
	John Fastabend <john.fastabend@gmail.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ankur Arora <ankur.a.arora@oracle.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	bpf@vger.kernel.org
Subject: [PATCH 15/48] bpf: Choose RCU Tasks based on TASKS_RCU rather than PREEMPTION
Date: Tue,  7 May 2024 11:34:57 +0200
Message-Id: <20240507093530.3043-16-urezki@gmail.com>
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

The advent of CONFIG_PREEMPT_AUTO, AKA lazy preemption, will mean that
even kernels built with CONFIG_PREEMPT_NONE or CONFIG_PREEMPT_VOLUNTARY
might see the occasional preemption, and that this preemption just might
happen within a trampoline.

Therefore, update bpf_tramp_image_put() to choose call_rcu_tasks()
based on CONFIG_TASKS_RCU instead of CONFIG_PREEMPTION.

This change might enable further simplifications, but the goal of this
effort is to make the code safe, not necessarily optimal.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: John Fastabend <john.fastabend@gmail.com>
Cc: Andrii Nakryiko <andrii@kernel.org>
Cc: Martin KaFai Lau <martin.lau@linux.dev>
Cc: Song Liu <song@kernel.org>
Cc: Yonghong Song <yonghong.song@linux.dev>
Cc: KP Singh <kpsingh@kernel.org>
Cc: Stanislav Fomichev <sdf@google.com>
Cc: Hao Luo <haoluo@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Ankur Arora <ankur.a.arora@oracle.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: <bpf@vger.kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
---
 kernel/bpf/trampoline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/bpf/trampoline.c b/kernel/bpf/trampoline.c
index db7599c59c78..88673a4267eb 100644
--- a/kernel/bpf/trampoline.c
+++ b/kernel/bpf/trampoline.c
@@ -333,7 +333,7 @@ static void bpf_tramp_image_put(struct bpf_tramp_image *im)
 		int err = bpf_arch_text_poke(im->ip_after_call, BPF_MOD_JUMP,
 					     NULL, im->ip_epilogue);
 		WARN_ON(err);
-		if (IS_ENABLED(CONFIG_PREEMPTION))
+		if (IS_ENABLED(CONFIG_TASKS_RCU))
 			call_rcu_tasks(&im->rcu, __bpf_tramp_image_put_rcu_tasks);
 		else
 			percpu_ref_kill(&im->pcref);
-- 
2.39.2



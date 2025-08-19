Return-Path: <bpf+bounces-65982-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2A5B2BD83
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 11:36:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51E7D524981
	for <lists+bpf@lfdr.de>; Tue, 19 Aug 2025 09:35:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB3C31AF0A;
	Tue, 19 Aug 2025 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ENRY3CDd"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pg1-f193.google.com (mail-pg1-f193.google.com [209.85.215.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAF0931A068;
	Tue, 19 Aug 2025 09:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755596102; cv=none; b=tnX5zCxdNOXaonow4mQpYm808dxfTOvQOBwaEQl5RAm3TM3y4rgMVzw5twPygNVTDfoBJFWnjlCu+y+1o4V3bIRH/e1KhXcRXNvOuWWzFgFcxegef/K5tIDbvTXFc3Ne+DqpR27pOhEhYvEzCMctT1U9k19pTsa8E5Oml4lObu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755596102; c=relaxed/simple;
	bh=eqO46c3pAN3PfhGNOqY8l83f0ewMbPj8kQ9DK6CPRUU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p79ZyrpLVgptZs3Z4ww8WlGfUo28PsaeGwh0u3Z8do25Pa4bqZNpyDcxOHc5+lnm7Oi+asOEp+24aiOotwcqL6Qi3oCwX1KYiAMTynzZ5GCoi6WriH7c+cGkXKzHkiBt6nNp/AGOMWQYR+M+R0Ap7mb2ZNcLTLi87iCn8iThJTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENRY3CDd; arc=none smtp.client-ip=209.85.215.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f193.google.com with SMTP id 41be03b00d2f7-b471738daabso4659582a12.1;
        Tue, 19 Aug 2025 02:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755596100; x=1756200900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=861OdxVnWv8IWFvxkcYe5tkgp3QAasS1lAYJfLFgMx4=;
        b=ENRY3CDdzcpfmOaHbiaDjgNllGhR1XD10QkQuL/LaozKJfIonkKhb8Ir+1T+G5mehp
         h6248DqbJ8fIaRx7bW9B3Ytim6Zedd/ZP2qvularElpUP71/aROxn+tU0ntIH5RMbOy0
         8kjFUD+0UgT1enwRiqOmtqxsexy63RhtElyLCeq9S7YYh/++SVUJsrxbUv5mlKPjQ6xJ
         kB8PumEPJFdiNZY/6aNPoOby29a5BBEQEc8KFVt/nP/2+j2BkiyGjL+oA6JtXQL4OVle
         z6JzFXmQn0OyxdxD4YqsY7tIppTMuRSkhQURxz3GJWs6uBPqsDtFolpfqoUc8/7I9pay
         ok5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755596100; x=1756200900;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=861OdxVnWv8IWFvxkcYe5tkgp3QAasS1lAYJfLFgMx4=;
        b=F03kzSP9naLzlk51swKZ5B/85LstiM6r8YGIJTHxUPiJmNMNKo2l+ILF6vLSj7XDdd
         i7kBjqhj1TmL8STZpU4QHg3lJR37Ied5H7QtRBQFs0Mrqzxd44PTa5JOV9M3trEizsKX
         dK3FU0cWqx+uPqKEkc0+gEpH5zTC0rF1B4TWsC/G560CIYzcUWNpihUjtOdh/r++5TKi
         tm/ZvGDDaC2eeth0y80Swg+JD1pva/0fZ4IsAzJdbJzG6JXKeMssqPGnwKyrp8ni9mIc
         +BGi8PQQCheTL5YuGVX871K2+SivNWnJaAwfju03sHHnFtg5WWzyrKVp9iS3u+o7jvsz
         Ip9w==
X-Forwarded-Encrypted: i=1; AJvYcCW6tT5NhZStLxd3FuWydaB7wcY6WFEEUsXBBm9mIy4qLAUb1lv1+qiHBFgknAola1cqXFo=@vger.kernel.org, AJvYcCWJ559SHxkiO3Y5S4SIaYvgy/MomBL3Jfochq5nhuEHuMMJuG+kSyrRFu8xg5OoznUAYnHK@vger.kernel.org, AJvYcCWTLtjC+YUZhVnzEUUpmSAQUFEqXNxd03IXNtkRm2ZhMNUgyLTJ37BzRe8JHWecPmYYAqPfhjwgKV+VGfGN@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4jUlX7nBfpTLfaktWUzFJ9j4mA4G6LdgXnER8gi9HquLaMPql
	Ir6/5quUvJb2A0iUrbF5qKXLcAWiJjTQ5HcNu72jSVniZ9AHwE1YAh0b
X-Gm-Gg: ASbGncudF84teGr3ZU2OLyNsAbMPkVV4yclSZGegX1jTz32QtRBiJnWdDKVd0rL+2Sl
	yHN4jncYXhaTn6VGdXRTq64eEAKpzKcKi81ueryQOztP0mYFe3FP+Hu2qWvVyf8XchcA6jyrgHe
	8Zmwy3iKDwlM9J9G1rcA25Pd/aqBpz9tAkEFgXKq9Hgv+U7RoUkQZW87ZXg1gS5r4dKySi6mluC
	3LzOqC5IP5yrqeJqkg+2ONXemKQe+V+vVU1gYnlOhROq6zyw5JuzVrSofUiqXSqeHIVc3eQs3UL
	OlcTg/eJEYDv8mMSqDD7xCUczvrdsgIOV8larvoA7NC5sEyjcgU1mh5mvtEmSuuKbH4XJARpioS
	wT4DgkkRJBxqh7Wwaqpw=
X-Google-Smtp-Source: AGHT+IE93gbHJgco21HqxguBff+5KzWKClvBeNlC34ItAW+lLtR8pGebvcMZTs8BzYxwIby0rAMFHQ==
X-Received: by 2002:a05:6a20:a122:b0:203:bb3b:5f1d with SMTP id adf61e73a8af0-2430d330f66mr2785284637.6.1755596100201;
        Tue, 19 Aug 2025 02:35:00 -0700 (PDT)
Received: from 7940hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e7d1314a4sm1990945b3a.41.2025.08.19.02.34.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 02:34:59 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	paulmck@kernel.org
Cc: frederic@kernel.org,
	neeraj.upadhyay@kernel.org,
	joelagnelf@nvidia.com,
	josh@joshtriplett.org,
	boqun.feng@gmail.com,
	urezki@gmail.com,
	rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiangshanlai@gmail.com,
	qiang.zhang@linux.dev,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH bpf-next v2 4/7] bpf: use rcu_read_lock_dont_migrate() for bpf_iter_run_prog()
Date: Tue, 19 Aug 2025 17:34:21 +0800
Message-ID: <20250819093424.1011645-5-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
References: <20250819093424.1011645-1-dongml2@chinatelecom.cn>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use rcu_read_lock_dont_migrate() and rcu_read_unlock_migrate() in
bpf_iter_run_prog to obtain better performance when PREEMPT_RCU is
not enabled.

Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
v2:
- use rcu_read_lock_dont_migrate() instead of rcu_migrate_disable()
---
 kernel/bpf/bpf_iter.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/bpf/bpf_iter.c b/kernel/bpf/bpf_iter.c
index 0cbcae727079..6ac35430c573 100644
--- a/kernel/bpf/bpf_iter.c
+++ b/kernel/bpf/bpf_iter.c
@@ -705,13 +705,11 @@ int bpf_iter_run_prog(struct bpf_prog *prog, void *ctx)
 		migrate_enable();
 		rcu_read_unlock_trace();
 	} else {
-		rcu_read_lock();
-		migrate_disable();
+		rcu_read_lock_dont_migrate();
 		old_run_ctx = bpf_set_run_ctx(&run_ctx);
 		ret = bpf_prog_run(prog, ctx);
 		bpf_reset_run_ctx(old_run_ctx);
-		migrate_enable();
-		rcu_read_unlock();
+		rcu_read_unlock_migrate();
 	}
 
 	/* bpf program can only return 0 or 1:
-- 
2.50.1



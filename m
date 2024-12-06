Return-Path: <bpf+bounces-46324-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC249E7A14
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 21:37:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 67F6F166704
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 20:37:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E528B1F63F0;
	Fri,  6 Dec 2024 20:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="FPQa01H8"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C62161C5490
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 20:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517439; cv=none; b=WSr2HLPaUzA/I4NIGUObSEe1jlbEVvNRR4kLIKNePv3eLweWGxRBXQxdUbVsYPF+NUgGV0ucOGoZsUl3A84CUdh4qtwhf7I5oUUwDy2L9XvK18KHZthjlHzeEYawFb8IZuYHITu81/04Lg1XXRZvozrrCypv9IC4DYEV+ESYf9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517439; c=relaxed/simple;
	bh=I8QH9yYP8JFwTKjCJAr/bedB4BBTOAmbOlClo2ps5zc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CmxJ/ETROiELiZJPD2ao75u+Uu5jhG++pFYvxPyYJ7UTKsxyAmssy2Dn3lrPx8vTZn28WuYTT41jQBxfNZA8+1TLS0n3Op7K9m4HWcoWvv8K7qXUD0g16tQO6j6NBgtyKdUllrBcJt5gjm14mXOJIsj5rKV2CZrirOozTlkEVKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=FPQa01H8; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4349338add3so10605e9.0
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 12:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733517436; x=1734122236; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iEYwwDGCTP7P7yGnkaQ5Z1LyGhjk0N+7h2F/y5Qegaw=;
        b=FPQa01H8OHPwePNjHuEboEhEbv4ruc050ykX2v8YnmSvk5fW4ZDHN+ijBiwu530ZCf
         w9uyO9IlMZrLaWcUWoX4MeM+UxbXXMJqr4euu4tUzI9ioTGrO6UhtX4zm7ldfW/dtpzq
         6y50HtnAOIfzBPfqoEHFbXxb7g6PbETGo2jaZb+ybswKny5M0fIGwJ1L48BRGeYSPQ1l
         NvtIQGDqM2gkwUOFnxhTwM6h7VveqVaYsi7zK+OJjm4mTsslJyPLDJQ7u5fq0VkxH/M+
         w631IJEq35ISpz+QkHfR9hfOeVVjYx2JvPjLbdKWzvrFIz8isxU+oG9/PF84QmeHUKfv
         olKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733517436; x=1734122236;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iEYwwDGCTP7P7yGnkaQ5Z1LyGhjk0N+7h2F/y5Qegaw=;
        b=HZmvh+6EhSZgMlcV9yk+XyljKQ/ucuRUWlWk4yYQNQ3EfhBreBU1hcWbGzfsNJnG4g
         DhdP+5GQQ8azolz/3awRV9RVwdIMG2MSJyLyakTv6ZXGSnT6wu62ayo1pUBgFQh+5xNG
         Nh59E6RbCV3BHMtSBRtBNwLmiF15QwqGLImFvOzT3m2i7L+5IQ7/LmScyUsV3Wevm2ew
         K4nM1W7qry04qgh9YwJ7M1u3on/mUDvEZh6WhAfChWj9d6Yuf+aG1ixs8cm1I1/9HUH+
         BpafPxG7chlO8EYE/Lp8ik1hvjf1g8EgPFgc2YntGbwnjsEohHiEkBua09E+MC6cGzPZ
         BpEg==
X-Gm-Message-State: AOJu0YwYy0sHxZYmVRxtiXIo7SD9VXS48PKDU7ZpoJ2XUN41beMFrQXb
	A6RdxpT/XT10+kcSKShDYu4b/CjBH8Y/yvZB7D6GLolko8GVFcbHtj9QmGdg+Q==
X-Gm-Gg: ASbGncubKC6GWI/t6U4Z3+XXrKlj7asuPdJSK9sjt4EUQl/LMW3kK8y3iyUh5HB0N9d
	WzzTVhXBF1Ix4/ie3cRpuI2hvQwaie6mmkgHRUsTGbsDkF/CXOY2kJ1g9O9oIN5k5blIavBSlZr
	R1OAFuupAyiYzOWRToi3Y/cvrA7Ro+EfiTl8WfjHdjD9g/QuO018ymgvUtOof4qdQhnL6yhWQiF
	jlXeKOC00UJDU2W+i3nilfwfOTdUCykqnBygvg=
X-Google-Smtp-Source: AGHT+IEyLEFRclI3pX1kv8//WWxlldusvhF+y5ETQFdRD1G0Bahr4xzoR/JRq0Rin2Hu5ZO57k//6w==
X-Received: by 2002:a05:600c:584b:b0:434:c967:e4b5 with SMTP id 5b1f17b1804b1-434e83df45cmr159425e9.1.1733517435663;
        Fri, 06 Dec 2024 12:37:15 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:a1dd:6aeb:389c:7fd7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434da113580sm68044935e9.29.2024.12.06.12.37.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:37:15 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Fri, 06 Dec 2024 21:37:03 +0100
Subject: [PATCH bpf] bpf: Fix prog_array UAF in __uprobe_perf_func()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-bpf-fix-uprobe-uaf-v1-1-6869c8a17258@google.com>
X-B4-Tracking: v=1; b=H4sIAG5gU2cC/x2MywqAIBAAfyX23ILZg+pXooPmWnsxUYpA+veWj
 gMzUyBTYsowVwUS3Zz5DAJNXcF2mLATshMGrXTXaDWgjR49P3jFdFrCy3jsWzfp0RrbOgUSxkR
 i/NMFxIf1fT/C+iYdaQAAAA==
X-Change-ID: 20241206-bpf-fix-uprobe-uaf-53d928bab3d0
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Andrii Nakryiko <andrii@kernel.org>, 
 Martin KaFai Lau <martin.lau@linux.dev>, 
 Eduard Zingerman <eddyz87@gmail.com>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, KP Singh <kpsingh@kernel.org>, 
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
 Jiri Olsa <jolsa@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Delyan Kratunov <delyank@fb.com>
Cc: bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Jann Horn <jannh@google.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733517431; l=4088;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=I8QH9yYP8JFwTKjCJAr/bedB4BBTOAmbOlClo2ps5zc=;
 b=ZuTXS1DTUtz9mwoP4jNWFIU2COR0aiA3HNcppch70BVqp7JPyDymwr8qZ82Qsf93jBM00n2VV
 xYabNIwirl+Bjfjh+gZiz1qDfsWSixzTsMnVf/p0fpHYxxcAVSaIGJi
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

Currently, the pointer stored in call->prog_array is loaded in
__uprobe_perf_func(), with no RCU annotation and no RCU protection, so the
loaded pointer can immediately be dangling. Later,
bpf_prog_run_array_uprobe() starts a RCU-trace read-side critical section,
but this is too late. It then uses rcu_dereference_check(), but this use of
rcu_dereference_check() does not actually dereference anything.

It looks like the intention was to pass a pointer to the member
call->prog_array into bpf_prog_run_array_uprobe() and actually dereference
the pointer in there. Fix the issue by actually doing that.

Fixes: 8c7dcb84e3b7 ("bpf: implement sleepable uprobes by chaining gps")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
To reproduce, patch include/linux/bpf.h like this:
```
@@ -30,6 +30,7 @@
 #include <linux/static_call.h>
 #include <linux/memcontrol.h>
 #include <linux/cfi.h>
+#include <linux/delay.h>

 struct bpf_verifier_env;
 struct bpf_verifier_log;
@@ -2203,6 +2204,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
        struct bpf_trace_run_ctx run_ctx;
        u32 ret = 1;

+       mdelay(10000);
        might_fault();

        rcu_read_lock_trace();
```

Build this userspace program:

```
$ cat dummy.c
#include <stdio.h>
int main(void) {
  printf("hello world\n");
}
$ gcc -o dummy dummy.c
```

Then build this BPF program and load it (change the path to point to
the "dummy" binary you built):

```
$ cat bpf-uprobe-kern.c
#include <linux/bpf.h>
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>
char _license[] SEC("license") = "GPL";

SEC("uprobe//home/user/bpf-uprobe-uaf/dummy:main")
int BPF_UPROBE(main_uprobe) {
  bpf_printk("main uprobe triggered\n");
  return 0;
}
$ clang -O2 -g -target bpf -c -o bpf-uprobe-kern.o bpf-uprobe-kern.c
$ sudo bpftool prog loadall bpf-uprobe-kern.o uprobe-test autoattach
```

Then run ./dummy in one terminal, and after launching it, run
`sudo umount uprobe-test` in another terminal. Once the 10-second
mdelay() is over, a use-after-free should occur, which may or may
not crash your kernel at the `prog->sleepable` check in
bpf_prog_run_array_uprobe() depending on your luck.
---
 include/linux/bpf.h         | 4 ++--
 kernel/trace/trace_uprobe.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/linux/bpf.h b/include/linux/bpf.h
index eaee2a819f4c150a34a7b1075584711609682e4c..00b3c5b197df75a0386233b9885b480b2ce72f5f 100644
--- a/include/linux/bpf.h
+++ b/include/linux/bpf.h
@@ -2193,7 +2193,7 @@ bpf_prog_run_array(const struct bpf_prog_array *array,
  * rcu-protected dynamically sized maps.
  */
 static __always_inline u32
-bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
+bpf_prog_run_array_uprobe(struct bpf_prog_array __rcu **array_rcu,
 			  const void *ctx, bpf_prog_run_fn run_prog)
 {
 	const struct bpf_prog_array_item *item;
@@ -2210,7 +2210,7 @@ bpf_prog_run_array_uprobe(const struct bpf_prog_array __rcu *array_rcu,
 
 	run_ctx.is_uprobe = true;
 
-	array = rcu_dereference_check(array_rcu, rcu_read_lock_trace_held());
+	array = rcu_dereference_check(*array_rcu, rcu_read_lock_trace_held());
 	if (unlikely(!array))
 		goto out;
 	old_run_ctx = bpf_set_run_ctx(&run_ctx.run_ctx);
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index fed382b7881b82ee3c334ea77860cce77581a74d..c4eef1eb5ddb3c65205aa9d64af1c72d62fab87f 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1404,7 +1404,7 @@ static void __uprobe_perf_func(struct trace_uprobe *tu,
 	if (bpf_prog_array_valid(call)) {
 		u32 ret;
 
-		ret = bpf_prog_run_array_uprobe(call->prog_array, regs, bpf_prog_run);
+		ret = bpf_prog_run_array_uprobe(&call->prog_array, regs, bpf_prog_run);
 		if (!ret)
 			return;
 	}

---
base-commit: 509df676c2d79c985ec2eaa3e3a3bbe557645861
change-id: 20241206-bpf-fix-uprobe-uaf-53d928bab3d0

-- 
Jann Horn <jannh@google.com>



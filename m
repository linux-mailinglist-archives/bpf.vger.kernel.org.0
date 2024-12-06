Return-Path: <bpf+bounces-46326-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD39F9E7A26
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 21:45:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DFEF1886062
	for <lists+bpf@lfdr.de>; Fri,  6 Dec 2024 20:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CDA1FFC4B;
	Fri,  6 Dec 2024 20:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K8Ctvefl"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E52221C54A8
	for <bpf@vger.kernel.org>; Fri,  6 Dec 2024 20:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733517936; cv=none; b=gtab3NUd4pj+vIpzZQN6wJSK1iBDnX+K2+cL/xnUZftGsLzPf/3mZGLyXozfvfxtiAN7/8Pq51oj9iksQZNVTTjLXGPio7dzQsOLdJRwO68eSRwRX/9/iEk6b7JnKz/yEM7KZ1WDU0sz7ZxxUh2fuNI+CD1SvGAeir05RAJueGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733517936; c=relaxed/simple;
	bh=m3PTfQDVngxMCgrvufrkVbQNh5egy7ThODyjfj2kRGY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ayVyoJaFFrosOcheadg1RxhFQVxIne+61htyLC6DGnjLfCBxVs9aZI+U8K6fj47HUR1gunKXpcI0iplXLsE02bXN9f9FNAHjU1S9uFwy+A0Pbhf8OxVgRfjuwAWllIBiSLdqyKdMwEQw/nwUnDbWTf0EpbajTPI1h3A6yTjpMfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K8Ctvefl; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-434a9f9a225so9585e9.1
        for <bpf@vger.kernel.org>; Fri, 06 Dec 2024 12:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733517932; x=1734122732; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vL/yjtQtoNZ0gBIy+DxtflUlVpr5YddZzBAjmwp/MkA=;
        b=K8CtveflPC8OOm58XgIJ0BHPYME804LEdiQy115Bz22B2vq5IA3DG9Tnoec4xTzbVX
         D5Ed4kgfuzTbLdwoCGIF2qNo4Gh1BXKksECOIi9qm3rwOBY4EN/+r9ALMmgUz3Lytjkq
         I30ObXVJh3/mOLI8/ms8FDoHCyWGoMYnLjj1wiW3dgG0Tbp/kURNyhHLtXAyOuBwHk4o
         Ii00KKyXd7LAfb+SYMRPNmq5zlIcFJlekTVoGZdAOoWkCmbzBhsVtnvyfw33cFwJSGPc
         J41GW3ROrtZIinEBBwWa9XkzzuP7TWFMFEKDFK5eZqtjOfgnuuHWMXg6+VMtUhF3AcW9
         i2+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733517932; x=1734122732;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vL/yjtQtoNZ0gBIy+DxtflUlVpr5YddZzBAjmwp/MkA=;
        b=mLCJrNAnEvhoLn5XJQrVYbQ5yCB/DwoDLlt10vG4RjUdY9tePUp8j3gedfA73lHs5d
         iHPF5dcqkqQhy02/S9jtfBW80fYT/e+MPiF8hVDG/CN+0FjAP7tB991tsac57qelLt53
         2hFZYP9znZreevRrq6qOus7YDfeAUNyB90K0/GawjrtuWPyYKcE3M72qscE6IBYoeelh
         C0u9Eq4sdOHL7PWKxR8Dxjrk4pEz8yuISRijecgUfw7R55yGOPnEfktINcma0ynBCAZY
         J/pGj2R6eweydjGLMfZ2cIakechDQ235stLW1levyXhMLAOH1PM+QAls+jfnHV2K7wkV
         w9Hg==
X-Gm-Message-State: AOJu0YwvIQnIdUDsg+6PzwDzlQz6u2PalUBUF0n80fwqeBqkARRZhapg
	80SILia+u1o1W5AWh3Taoy+UZ+HAX38jXhsIxbeWgGT6JLoz5oq5wYOK/rQcIw==
X-Gm-Gg: ASbGncuUnt7hz2AUUhfQnPbZg2L70b7hknnWw6y4hMYaHInUwgqockNsQPUXDkHR8d3
	dP6yJ7H0aBk2Cs4l7MMJL9Ji2pDcGwKjkz2v08bifP5BP4VKaLpCcLk1YyvU8z1HPlm+PpdqjEL
	wnkrQwPNg9DjxmL1ScG95+r7BG6teEYTToR7O9hB7RoLzxB0LGJNqS/2eORYd52FNa/r4w1N/LN
	wt4F4IkL6F6TEmxLU342JTSN2JWjbL33MbV9w==
X-Google-Smtp-Source: AGHT+IHfoEVwi7Atv6ROI6m52UQqMOVS5/908bxTefMRLKhkIJdwocTFIYOTCUKX87jLbZyKeTgo8Q==
X-Received: by 2002:a05:600c:34cf:b0:42b:8ff7:bee2 with SMTP id 5b1f17b1804b1-434e844cb4emr143245e9.5.1733517931771;
        Fri, 06 Dec 2024 12:45:31 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:a1dd:6aeb:389c:7fd7])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3861f59cd35sm5327236f8f.31.2024.12.06.12.45.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Dec 2024 12:45:30 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Fri, 06 Dec 2024 21:45:28 +0100
Subject: [PATCH bpf v2] bpf: Fix prog_array UAF in __uprobe_perf_func()
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241206-bpf-fix-uprobe-uaf-v2-1-4c75c54fe424@google.com>
X-B4-Tracking: v=1; b=H4sIAGdiU2cC/32NTQ7CIBSEr9K8tc8Uait15T1MF/w8WhItBCzRN
 L27hAO4nJlvZnZIFB0luDU7RMouOb8WwU8N6EWuM6EzRQNv+YXxdkAVLFr3wS1Erwg3abHvzMi
 FkqozLZRiiFSIOvqAwsNUzMWlt4/fepRZjf5tZoYMBzGMWkh25b24z97PTzpr/4LpOI4fERo6S
 boAAAA=
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733517930; l=3931;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=m3PTfQDVngxMCgrvufrkVbQNh5egy7ThODyjfj2kRGY=;
 b=gEZFzYLUA38vwsxc9tx3/JTv+8w0KjkGxS3pFSw0YcKqr/X+g226yWRb+R6bSEY+mvghll05g
 ioee4912xDxBkNE7zUGmZ64jnuMahywBXep9yxgm/swPydEtiLfNfue
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
To reproduce, in include/linux/bpf.h, patch in a mdelay(10000) directly
before the might_fault() in bpf_prog_run_array_uprobe() and add an
include of linux/delay.h.

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
Changes in v2:
- remove diff chunk in patch notes that confuses git
- Link to v1: https://lore.kernel.org/r/20241206-bpf-fix-uprobe-uaf-v1-1-6869c8a17258@google.com
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



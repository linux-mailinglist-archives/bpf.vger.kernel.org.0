Return-Path: <bpf+bounces-73391-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 863E4C2E64F
	for <lists+bpf@lfdr.de>; Tue, 04 Nov 2025 00:25:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4193C3B7CC5
	for <lists+bpf@lfdr.de>; Mon,  3 Nov 2025 23:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFC22FE592;
	Mon,  3 Nov 2025 23:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifyHL44R"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD62BD580
	for <bpf@vger.kernel.org>; Mon,  3 Nov 2025 23:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212208; cv=none; b=uX1jVK8l/ALmwn3UnhwP0vvNvXKWeUvd2u4RgC8WZEqfFSDbM4H6C/7VXJ/Gb0+AG+AbgxENt27s6H62hvpKpXD9wcMRmVCeiO33pj9kX6B+6Ol5S1YZeqCvkSU9wyf5jwL8M5CeyYGsWjV9740lWkPRTsRUj53LXwRTO/kUf/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212208; c=relaxed/simple;
	bh=Gf2f6qCRrK+5Rk57saTSHFPVYIg7z2+EA2bFUZBtTcE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WncaQIMdIfx/spqDGNKEnW5lRWrMb3KLwedyjI+f+lveNZ7T0yWQwHFPiflQtXTZZKw3G7TkcL6BBzYO2RG1NF4vN32GFrwCezdlKL1wYQBQ6Th5/OqPrnKCpE4MfpWFRBu2fBbTfQgmvLRKJ2IzDwsbNQgVKoHjg3LWj/kv/1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifyHL44R; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-477549b3082so1568945e9.0
        for <bpf@vger.kernel.org>; Mon, 03 Nov 2025 15:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762212205; x=1762817005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tnARLlpAPjYbrl5c29C0J1jn58aIot3ySFn1CdTVCLA=;
        b=ifyHL44RdVzcq85n9aqo16hws0eHXOr/2F2kpUXIn0RKFVfJAF8/bINjZ+bRrHelP4
         HsWltpItvpTTaSyaYI7EJ5cRKZAccz0GFk3DpbvelanzENNvWtLaEPbl5/JtAvAFR3Xa
         1G88BaWm4mKcQmPyYMYvy/TkaaggPuTNjNj15H1Ws5KJ8WAVlO0MxOf2cTwppUe3w4K6
         qqLe0j6Or2mTq3doesh6+9gfir3XuhiM1hK0ogIOaoeFBn5frnkEFfIjCU8j3D5fXBpW
         7QLJ0EQ+jL8W2eHCj/gJBgAIP+s7QJjxgKvOZWyZM4DqPrSNeq9zKHHK31/gA3yBFxe1
         XADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762212205; x=1762817005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tnARLlpAPjYbrl5c29C0J1jn58aIot3ySFn1CdTVCLA=;
        b=U9VIb4Cos8USuHptXTG5BtTlxoMz9afVyW6o7m5YhfqKD5/j9gyMPiCbYpJV4YRSaV
         77GeJ7Bdz64VUJsCLZ6gTzLjrAycku2ZCAt5198l8MdS3xKwaz7KfwrOx+DUmM0byhz4
         a9f/RRb4eilDNHTCnTlQSPfVLEoDlkCqyAXa9C0i+V/Fg9Qc4K7t5HWX5cOu3H3rMz8D
         k3ZBKVnS20XVwMajck0QJ09w/+kiRddDhDd5LONzyaRz7pdjU2lr2OEzyAiIsNSitEIG
         fO4391nrNN+pi89sq8qPk1cwSdvCunbWlYvh2J2KJQ0+KyON2GVbYDc5kckY6hCo8xJ3
         GydA==
X-Gm-Message-State: AOJu0YyanXYhLCnm7lkyhAa3dDM3c1wU7I0F7os30LfEih4a4V0Domuc
	udeLooc4+vi/FN1VH8OcnyQBY+xzYASLLhIboXVyeitxIc4EZtdoaZq4w2MuwA==
X-Gm-Gg: ASbGncs7YFD4R5Yfva+VZDzrYwt8AboWUJ5dUiPb5Qfh/T7bcWB2S6JtohTpcVoP5g1
	f/uYQOVHWi9OiIfjc0QovHr9jjLlmvBv8tgJEirBF6KKlUvR7t6EC/apns7aF8zYO5+fhABo0q6
	bh4idnOTC3b6bPoTEnW3k6o6TtG4g7gHic3mdEBMp1k1W+dz0GWVclTHxdh8Y8u52PrdUPLSQtr
	JSUKwI6AiK4PtqQ/yvCSETn/pgOuUIvzKRlizvS0O3fxZQCfS121e8NqifA05EmTURNHT8duiP4
	9WqEXz2ur19wU6cSkNHNM/19dJldJFdP/XTJAeo0/4rTmjveXi+YzT231zLXfKPrvmTGlrZgZCj
	LuW2o4XpOYRTQBRnZQlIVGfnqDbNJDVdoMePEWGSMTfcutYSZuuvxGNObVS+1cYS1fFCYog==
X-Google-Smtp-Source: AGHT+IGAg19b0//aTN05Rv+FJY3jvcYedw4W0fQsMFbrzX5/BO11UaE4eK2MzgjEn4H6Oc94qsba6A==
X-Received: by 2002:a05:600c:530f:b0:475:d8b3:a9d5 with SMTP id 5b1f17b1804b1-477307e3d3cmr118659395e9.10.1762212204543;
        Mon, 03 Nov 2025 15:23:24 -0800 (PST)
Received: from localhost ([2620:10d:c092:400::5:ad95])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429dc19258bsm1308899f8f.12.2025.11.03.15.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 15:23:24 -0800 (PST)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf v1] bpf: add _impl suffix for kfuncs with implicit args
Date: Mon,  3 Nov 2025 23:23:19 +0000
Message-ID: <20251103232319.122965-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

We’re introducing support for implicit kfunc arguments and need to
rename new kfuncs to comply with the naming convention.
This new feature, will for each kfunc of the form:

`bpf_foo_impl(args..., aux__prog)`

generate a public BTF type:

`bpf_foo(args...)`

and the verifier will resolve calls to bpf_foo() to bpf_foo_impl(),
supplying a valid struct bpf_prog_aux via aux__prog.

Three kfuncs new in 6.18 don’t follow this *_impl convention and
therefore won’t participate in the new mechanism:
 * bpf_task_work_schedule_resume()
 * bpf_task_work_schedule_signal()
 * bpf_stream_vprintk()

Rename them to align with the implicit-arg flow:
bpf_task_work_schedule_resume() -> bpf_task_work_schedule_resume_impl()
bpf_task_work_schedule_signal() -> bpf_task_work_schedule_signal_impl()
bpf_stream_vprintk() -> bpf_stream_vprintk_impl()

The implicit-arg mechanism is not in tree yet, so callers must switch to
the *_impl names for now. Once the new mechanism lands, the plain
names (without _impl) will be reintroduced as BTF-visible entry points
and will resolve to the _impl versions automatically.

Signed-off-by: Mykyta Yatsenko <yatsenko@meta.com>
---
 kernel/bpf/helpers.c                          | 26 +++++++++--------
 kernel/bpf/stream.c                           |  3 +-
 kernel/bpf/verifier.c                         | 12 ++++----
 .../bpftool/Documentation/bpftool-prog.rst    |  2 +-
 tools/lib/bpf/bpf_helpers.h                   | 28 +++++++++----------
 .../testing/selftests/bpf/progs/file_reader.c |  2 +-
 .../testing/selftests/bpf/progs/stream_fail.c |  6 ++--
 tools/testing/selftests/bpf/progs/task_work.c |  6 ++--
 .../selftests/bpf/progs/task_work_fail.c      |  8 +++---
 .../selftests/bpf/progs/task_work_stress.c    |  4 +--
 .../bpf/progs/verifier_async_cb_context.c     |  4 +--
 11 files changed, 53 insertions(+), 48 deletions(-)

diff --git a/kernel/bpf/helpers.c b/kernel/bpf/helpers.c
index 930e132f440f..96ea1c7a29be 100644
--- a/kernel/bpf/helpers.c
+++ b/kernel/bpf/helpers.c
@@ -4274,7 +4274,8 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
 }
 
 /**
- * bpf_task_work_schedule_signal - Schedule BPF callback using task_work_add with TWA_SIGNAL mode
+ * bpf_task_work_schedule_signal_impl - Schedule BPF callback using task_work_add with TWA_SIGNAL
+ * mode
  * @task: Task struct for which callback should be scheduled
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
  * @map__map: bpf_map that embeds struct bpf_task_work in the values
@@ -4283,15 +4284,17 @@ static int bpf_task_work_schedule(struct task_struct *task, struct bpf_task_work
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
-__bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct bpf_task_work *tw,
-					      void *map__map, bpf_task_work_callback_t callback,
-					      void *aux__prog)
+__bpf_kfunc int bpf_task_work_schedule_signal_impl(struct task_struct *task,
+						   struct bpf_task_work *tw, void *map__map,
+						   bpf_task_work_callback_t callback,
+						   void *aux__prog)
 {
 	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_SIGNAL);
 }
 
 /**
- * bpf_task_work_schedule_resume - Schedule BPF callback using task_work_add with TWA_RESUME mode
+ * bpf_task_work_schedule_resume_impl - Schedule BPF callback using task_work_add with TWA_RESUME
+ * mode
  * @task: Task struct for which callback should be scheduled
  * @tw: Pointer to struct bpf_task_work in BPF map value for internal bookkeeping
  * @map__map: bpf_map that embeds struct bpf_task_work in the values
@@ -4300,9 +4303,10 @@ __bpf_kfunc int bpf_task_work_schedule_signal(struct task_struct *task, struct b
  *
  * Return: 0 if task work has been scheduled successfully, negative error code otherwise
  */
-__bpf_kfunc int bpf_task_work_schedule_resume(struct task_struct *task, struct bpf_task_work *tw,
-					      void *map__map, bpf_task_work_callback_t callback,
-					      void *aux__prog)
+__bpf_kfunc int bpf_task_work_schedule_resume_impl(struct task_struct *task,
+						   struct bpf_task_work *tw, void *map__map,
+						   bpf_task_work_callback_t callback,
+						   void *aux__prog)
 {
 	return bpf_task_work_schedule(task, tw, map__map, callback, aux__prog, TWA_RESUME);
 }
@@ -4529,9 +4533,9 @@ BTF_ID_FLAGS(func, bpf_strncasestr);
 #if defined(CONFIG_BPF_LSM) && defined(CONFIG_CGROUPS)
 BTF_ID_FLAGS(func, bpf_cgroup_read_xattr, KF_RCU)
 #endif
-BTF_ID_FLAGS(func, bpf_stream_vprintk, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_signal, KF_TRUSTED_ARGS)
-BTF_ID_FLAGS(func, bpf_task_work_schedule_resume, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_stream_vprintk_impl, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_signal_impl, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, bpf_task_work_schedule_resume_impl, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_from_file, KF_TRUSTED_ARGS)
 BTF_ID_FLAGS(func, bpf_dynptr_file_discard)
 BTF_KFUNCS_END(common_btf_ids)
diff --git a/kernel/bpf/stream.c b/kernel/bpf/stream.c
index 96145ea4496b..0b6bc3f30335 100644
--- a/kernel/bpf/stream.c
+++ b/kernel/bpf/stream.c
@@ -212,7 +212,8 @@ __bpf_kfunc_start_defs();
  * Avoid using enum bpf_stream_id so that kfunc users don't have to pull in the
  * enum in headers.
  */
-__bpf_kfunc int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args, u32 len__sz, void *aux__prog)
+__bpf_kfunc int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const void *args,
+					u32 len__sz, void *aux__prog)
 {
 	struct bpf_bprintf_data data = {
 		.get_bin_args	= true,
diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 542e23fb19c7..a55709680878 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -12288,8 +12288,8 @@ enum special_kfunc_type {
 	KF_bpf_dynptr_from_file,
 	KF_bpf_dynptr_file_discard,
 	KF___bpf_trap,
-	KF_bpf_task_work_schedule_signal,
-	KF_bpf_task_work_schedule_resume,
+	KF_bpf_task_work_schedule_signal_impl,
+	KF_bpf_task_work_schedule_resume_impl,
 };
 
 BTF_ID_LIST(special_kfunc_list)
@@ -12362,13 +12362,13 @@ BTF_ID(func, bpf_res_spin_unlock_irqrestore)
 BTF_ID(func, bpf_dynptr_from_file)
 BTF_ID(func, bpf_dynptr_file_discard)
 BTF_ID(func, __bpf_trap)
-BTF_ID(func, bpf_task_work_schedule_signal)
-BTF_ID(func, bpf_task_work_schedule_resume)
+BTF_ID(func, bpf_task_work_schedule_signal_impl)
+BTF_ID(func, bpf_task_work_schedule_resume_impl)
 
 static bool is_task_work_add_kfunc(u32 func_id)
 {
-	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal] ||
-	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume];
+	return func_id == special_kfunc_list[KF_bpf_task_work_schedule_signal_impl] ||
+	       func_id == special_kfunc_list[KF_bpf_task_work_schedule_resume_impl];
 }
 
 static bool is_kfunc_ret_null(struct bpf_kfunc_call_arg_meta *meta)
diff --git a/tools/bpf/bpftool/Documentation/bpftool-prog.rst b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
index 009633294b09..35aeeaf5f711 100644
--- a/tools/bpf/bpftool/Documentation/bpftool-prog.rst
+++ b/tools/bpf/bpftool/Documentation/bpftool-prog.rst
@@ -182,7 +182,7 @@ bpftool prog tracelog
 
 bpftool prog tracelog { stdout | stderr } *PROG*
     Dump the BPF stream of the program. BPF programs can write to these streams
-    at runtime with the **bpf_stream_vprintk**\ () kfunc. The kernel may write
+    at runtime with the **bpf_stream_vprintk_impl**\ () kfunc. The kernel may write
     error messages to the standard error stream. This facility should be used
     only for debugging purposes.
 
diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index 80c028540656..d4e4e388e625 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -315,20 +315,20 @@ enum libbpf_tristate {
 			  ___param, sizeof(___param));		\
 })
 
-extern int bpf_stream_vprintk(int stream_id, const char *fmt__str, const void *args,
-			      __u32 len__sz, void *aux__prog) __weak __ksym;
-
-#define bpf_stream_printk(stream_id, fmt, args...)				\
-({										\
-	static const char ___fmt[] = fmt;					\
-	unsigned long long ___param[___bpf_narg(args)];				\
-										\
-	_Pragma("GCC diagnostic push")						\
-	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")			\
-	___bpf_fill(___param, args);						\
-	_Pragma("GCC diagnostic pop")						\
-										\
-	bpf_stream_vprintk(stream_id, ___fmt, ___param, sizeof(___param), NULL);\
+extern int bpf_stream_vprintk_impl(int stream_id, const char *fmt__str, const void *args,
+				   __u32 len__sz, void *aux__prog) __weak __ksym;
+
+#define bpf_stream_printk(stream_id, fmt, args...)					\
+({											\
+	static const char ___fmt[] = fmt;						\
+	unsigned long long ___param[___bpf_narg(args)];					\
+											\
+	_Pragma("GCC diagnostic push")							\
+	_Pragma("GCC diagnostic ignored \"-Wint-conversion\"")				\
+	___bpf_fill(___param, args);							\
+	_Pragma("GCC diagnostic pop")							\
+											\
+	bpf_stream_vprintk_impl(stream_id, ___fmt, ___param, sizeof(___param), NULL);	\
 })
 
 /* Use __bpf_printk when bpf_printk call has 3 or fewer fmt args
diff --git a/tools/testing/selftests/bpf/progs/file_reader.c b/tools/testing/selftests/bpf/progs/file_reader.c
index 166c3ac6957d..4d756b623557 100644
--- a/tools/testing/selftests/bpf/progs/file_reader.c
+++ b/tools/testing/selftests/bpf/progs/file_reader.c
@@ -77,7 +77,7 @@ int on_open_validate_file_read(void *c)
 		err = 1;
 		return 0;
 	}
-	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, task_work_callback, NULL);
+	bpf_task_work_schedule_signal_impl(task, &work->tw, &arrmap, task_work_callback, NULL);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/stream_fail.c b/tools/testing/selftests/bpf/progs/stream_fail.c
index b4a0d0cc8ec8..3662515f0107 100644
--- a/tools/testing/selftests/bpf/progs/stream_fail.c
+++ b/tools/testing/selftests/bpf/progs/stream_fail.c
@@ -10,7 +10,7 @@ SEC("syscall")
 __failure __msg("Possibly NULL pointer passed")
 int stream_vprintk_null_arg(void *ctx)
 {
-	bpf_stream_vprintk(BPF_STDOUT, "", NULL, 0, NULL);
+	bpf_stream_vprintk_impl(BPF_STDOUT, "", NULL, 0, NULL);
 	return 0;
 }
 
@@ -18,7 +18,7 @@ SEC("syscall")
 __failure __msg("R3 type=scalar expected=")
 int stream_vprintk_scalar_arg(void *ctx)
 {
-	bpf_stream_vprintk(BPF_STDOUT, "", (void *)46, 0, NULL);
+	bpf_stream_vprintk_impl(BPF_STDOUT, "", (void *)46, 0, NULL);
 	return 0;
 }
 
@@ -26,7 +26,7 @@ SEC("syscall")
 __failure __msg("arg#1 doesn't point to a const string")
 int stream_vprintk_string_arg(void *ctx)
 {
-	bpf_stream_vprintk(BPF_STDOUT, ctx, NULL, 0, NULL);
+	bpf_stream_vprintk_impl(BPF_STDOUT, ctx, NULL, 0, NULL);
 	return 0;
 }
 
diff --git a/tools/testing/selftests/bpf/progs/task_work.c b/tools/testing/selftests/bpf/progs/task_work.c
index 23217f06a3ec..663a80990f8f 100644
--- a/tools/testing/selftests/bpf/progs/task_work.c
+++ b/tools/testing/selftests/bpf/progs/task_work.c
@@ -66,7 +66,7 @@ int oncpu_hash_map(struct pt_regs *args)
 	if (!work)
 		return 0;
 
-	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, &work->tw, &hmap, process_work, NULL);
 	return 0;
 }
 
@@ -80,7 +80,7 @@ int oncpu_array_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_signal(task, &work->tw, &arrmap, process_work, NULL);
+	bpf_task_work_schedule_signal_impl(task, &work->tw, &arrmap, process_work, NULL);
 	return 0;
 }
 
@@ -102,6 +102,6 @@ int oncpu_lru_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&lrumap, &key);
 	if (!work || work->data[0])
 		return 0;
-	bpf_task_work_schedule_resume(task, &work->tw, &lrumap, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, &work->tw, &lrumap, process_work, NULL);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/task_work_fail.c b/tools/testing/selftests/bpf/progs/task_work_fail.c
index 77fe8f28facd..1270953fd092 100644
--- a/tools/testing/selftests/bpf/progs/task_work_fail.c
+++ b/tools/testing/selftests/bpf/progs/task_work_fail.c
@@ -53,7 +53,7 @@ int mismatch_map(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_resume(task, &work->tw, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, &work->tw, &hmap, process_work, NULL);
 	return 0;
 }
 
@@ -65,7 +65,7 @@ int no_map_task_work(struct pt_regs *args)
 	struct bpf_task_work tw;
 
 	task = bpf_get_current_task_btf();
-	bpf_task_work_schedule_resume(task, &tw, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, &tw, &hmap, process_work, NULL);
 	return 0;
 }
 
@@ -76,7 +76,7 @@ int task_work_null(struct pt_regs *args)
 	struct task_struct *task;
 
 	task = bpf_get_current_task_btf();
-	bpf_task_work_schedule_resume(task, NULL, &hmap, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, NULL, &hmap, process_work, NULL);
 	return 0;
 }
 
@@ -91,6 +91,6 @@ int map_null(struct pt_regs *args)
 	work = bpf_map_lookup_elem(&arrmap, &key);
 	if (!work)
 		return 0;
-	bpf_task_work_schedule_resume(task, &work->tw, NULL, process_work, NULL);
+	bpf_task_work_schedule_resume_impl(task, &work->tw, NULL, process_work, NULL);
 	return 0;
 }
diff --git a/tools/testing/selftests/bpf/progs/task_work_stress.c b/tools/testing/selftests/bpf/progs/task_work_stress.c
index 90fca06fff56..55e555f7f41b 100644
--- a/tools/testing/selftests/bpf/progs/task_work_stress.c
+++ b/tools/testing/selftests/bpf/progs/task_work_stress.c
@@ -51,8 +51,8 @@ int schedule_task_work(void *ctx)
 		if (!work)
 			return 0;
 	}
-	err = bpf_task_work_schedule_signal(bpf_get_current_task_btf(), &work->tw, &hmap,
-					    process_work, NULL);
+	err = bpf_task_work_schedule_signal_impl(bpf_get_current_task_btf(), &work->tw, &hmap,
+						 process_work, NULL);
 	if (err)
 		__sync_fetch_and_add(&schedule_error, 1);
 	else
diff --git a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
index 96ff6749168b..7efa9521105e 100644
--- a/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
+++ b/tools/testing/selftests/bpf/progs/verifier_async_cb_context.c
@@ -156,7 +156,7 @@ int task_work_non_sleepable_prog(void *ctx)
 	if (!task)
 		return 0;
 
-	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb, NULL);
+	bpf_task_work_schedule_resume_impl(task, &val->tw, &task_work_map, task_work_cb, NULL);
 	return 0;
 }
 
@@ -176,6 +176,6 @@ int task_work_sleepable_prog(void *ctx)
 	if (!task)
 		return 0;
 
-	bpf_task_work_schedule_resume(task, &val->tw, &task_work_map, task_work_cb, NULL);
+	bpf_task_work_schedule_resume_impl(task, &val->tw, &task_work_map, task_work_cb, NULL);
 	return 0;
 }
-- 
2.51.1



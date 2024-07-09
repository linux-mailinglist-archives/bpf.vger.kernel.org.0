Return-Path: <bpf+bounces-34300-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1BD92C529
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 23:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F2031C21FDD
	for <lists+bpf@lfdr.de>; Tue,  9 Jul 2024 21:10:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B97818560A;
	Tue,  9 Jul 2024 21:09:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zY3D1MfW"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f74.google.com (mail-ed1-f74.google.com [209.85.208.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBE3182A6E
	for <bpf@vger.kernel.org>; Tue,  9 Jul 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720559391; cv=none; b=gvYSG2Odckznb+8U1XkxhDegU8ADBOHwbPk0wo/V0GWOsYVuOd9bRnVIoFIQoEcKbnwP9yKVnuPorNfMGS26FUyTqQmAWgRCdhfWdapzVJyd2grFK34C0Ffosgx+wNxpiRpkHtW6snnfoNr6xEpVj5OIPjuQuphVG2PAvMZ94CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720559391; c=relaxed/simple;
	bh=BCJ6HkoM2Px1TFW1GTyX66VSA4uUzerNsSvvj8PyPt4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tR0WfB2Tq8REvU2mSU+/jvWzVW7vCnFcSUXvH0fgULFvARpXzNF+/wZ6o4S1KXzqVDudq7HFvXiQS121/hlQ08rmmw9zk+aB+HZBfQr/B4yYyPQkVBeXbcSn+xYRRaQ/GZPhOn47HcSTgobWXuKwFuojrT0W6Z4IIFpQPTucfKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zY3D1MfW; arc=none smtp.client-ip=209.85.208.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--mattbobrowski.bounces.google.com
Received: by mail-ed1-f74.google.com with SMTP id 4fb4d7f45d1cf-57851ae6090so4834231a12.3
        for <bpf@vger.kernel.org>; Tue, 09 Jul 2024 14:09:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720559387; x=1721164187; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bVhCQzoM0+A7bCPwm4HlaKQWczXPzKmzk7UAHLsMwkI=;
        b=zY3D1MfWYUhAmj/rnUoKINiWYKth3bP2vhtvB+Qvw6DOe5/3Oix2CAdaTM9UD5KcZm
         7FRsI8yuEicnIrZN4w6YF0+DPZWrieZFY8XNk4YBuwlQyswFhCKYYdbFggrqxCCGQQnu
         XtK8OjAhK4Dv6MBieX5C4RENwlmkFR376VP8OHAECxLpF9wJhAnKdjhCJCg7XIUjrykK
         G6q5DebZA+Ge6ijAnbwq0E4FT7CAVLvUjfH65SBeTqNtxrO59FZ3Xl/zWj+pItJmBtId
         8buv/li2HXTHGPG50VvZpT//5RF/svueAneQCSPng3TK0nse5saQk9ZSiOHdtJUAq2Xz
         hFTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720559387; x=1721164187;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bVhCQzoM0+A7bCPwm4HlaKQWczXPzKmzk7UAHLsMwkI=;
        b=mDEEB6gOFXSCOYUyTxCHlq1NB4Z56TTiN29BvuhIkk5DO40qas0xyYaLAdna/krG8F
         BlkTMZlRlZCNfJuVbBT0Fy49ENSzvn7CbBtbiFS1vdE9GRoa/JXwEa+jqWvAVEQP2L3D
         3MBAqHiAV1CNMiw3waKwaKDLFeukhhMmWnsCezTXFkhH4yrZxSYe3zVBrCr5utBCyFMQ
         wW1QFmGFicIoACjh2MYJ3KrPC0vOvbvX9mr6rSqYfVj7scmW2lodNmOOyqSHJW+OnYsw
         BnXFbMalAK+qLN8lf7HT0ZuGLIbqBNh8LsXwQO0UhrgoOaCzbTd5/Emc8/6G/hdbHLK2
         Q/Lw==
X-Gm-Message-State: AOJu0Yyv8y9dc9fjjo5pNGupsE5l9rMsQ2c/C75hNW2MNt3u+reUZMXH
	EBmz2un8r1VjWhpZvj8lylWXJSM33rjEKnGoBtJ9Y0TXxMMamIZwtVuu5Scg/BMqNF1RG9DBrUs
	gzzNGNOBtIjX1+mlgI3Dgf1tw6fqEqmJ4UJy23ILhjGiNPL45AHrKByL7mYw1ufqEPThh+OvIM2
	QbdNuZxrQAfqRGGRN93zNBZJlhfOMmvePfIjhfZPdRdjCMNus60+Ddm6Px6y/C61g21g==
X-Google-Smtp-Source: AGHT+IGHLe2GEULDlKqElMgsmCs2iYC+UH5AdnRHcucoIOdcdcDm+51g7FwkD9GYJ7Kjpnv+lQ7fDeBBuH2yy6gdzZDi
X-Received: from mattbobrowski.c.googlers.com ([fda3:e722:ac3:cc00:31:98fb:c0a8:c5c])
 (user=mattbobrowski job=sendgmr) by 2002:a05:6402:1756:b0:57d:474b:8101 with
 SMTP id 4fb4d7f45d1cf-594b9a0ee72mr3731a12.2.1720559387284; Tue, 09 Jul 2024
 14:09:47 -0700 (PDT)
Date: Tue,  9 Jul 2024 21:09:39 +0000
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.803.g4e1b14247a-goog
Message-ID: <20240709210939.1544011-1-mattbobrowski@google.com>
Subject: [PATCH bpf] bpf: relax zero fixed offset constraint on KF_TRUSTED_ARGS/KF_RCU
From: Matt Bobrowski <mattbobrowski@google.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org, memxor@gmail.com, 
	eddyz87@gmail.com, kpsingh@kernel.org, sdf@fomichev.me, jolsa@kernel.org, 
	Matt Bobrowski <mattbobrowski@google.com>
Content-Type: text/plain; charset="UTF-8"

Currently, BPF kfuncs which accept trusted pointer arguments
i.e. those flagged as KF_TRUSTED_ARGS, KF_RCU, or KF_RELEASE, all
require an original/unmodified trusted pointer argument to be supplied
to them. By original/unmodified, it means that the backing register
holding the trusted pointer argument that is to be supplied to the BPF
kfunc must have its fixed offset set to zero, or else the BPF verifier
will outright reject the BPF program load. However, this zero fixed
offset constraint that is currently enforced by the BPF verifier onto
BPF kfuncs specifically flagged to accept KF_TRUSTED_ARGS or KF_RCU
trusted pointer arguments is rather unnecessary, and can limit their
usability in practice. Specifically, it completely eliminates the
possibility of constructing a derived trusted pointer from an original
trusted pointer. To put it simply, a derived pointer is a pointer
which points to one of the nested member fields of the object being
pointed to by the original trusted pointer.

This patch relaxes the zero fixed offset constraint that is enforced
upon BPF kfuncs which specifically accept KF_TRUSTED_ARGS, or KF_RCU
arguments. Although, the zero fixed offset constraint technically also
applies to BPF kfuncs accepting KF_RELEASE arguments, relaxing this
constraint for such BPF kfuncs has subtle and unwanted
side-effects. This was discovered by experimenting a little further
with an initial version of this patch series [0]. The primary issue
with relaxing the zero fixed offset constraint on BPF kfuncs accepting
KF_RELEASE arguments is that it'd would open up the opportunity for
BPF programs to supply both trusted pointers and derived trusted
pointers to them. For KF_RELEASE BPF kfuncs specifically, this could
be problematic as resources associated with the backing pointer could
be released by the backing BPF kfunc and cause instabilities for the
rest of the kernel.

With this new fixed offset semantic in-place for BPF kfuncs accepting
KF_TRUSTED_ARGS and KF_RCU arguments, we now have more flexibility
when it comes to the BPF kfuncs that we're able to introduce moving
forward.

Early discussions covering the possibility of relaxing the zero fixed
offset constraint can be found using the link below. This will provide
more context on where all this has stemmed from [1].

Notably, pre-existing tests have been updated such that they provide
coverage for the updated zero fixed offset
functionality. Specifically, the nested offset test was converted from
a negative to positive test as it was already designed to assert zero
fixed offset semantics of a KF_TRUSTED_ARGS BPF kfunc.

[0] https://lore.kernel.org/bpf/ZnA9ndnXKtHOuYMe@google.com/
[1] https://lore.kernel.org/bpf/ZhkbrM55MKQ0KeIV@google.com/

Signed-off-by: Matt Bobrowski <mattbobrowski@google.com>
---
 kernel/bpf/verifier.c                                    | 9 +++------
 tools/testing/selftests/bpf/progs/nested_trust_failure.c | 8 --------
 tools/testing/selftests/bpf/progs/nested_trust_success.c | 8 ++++++++
 tools/testing/selftests/bpf/verifier/calls.c             | 2 +-
 4 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 3d6306c363b7..c0263fb5ca4b 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -11335,7 +11335,9 @@ static int process_kf_arg_ptr_to_btf_id(struct bpf_verifier_env *env,
 	    btf_type_ids_nocast_alias(&env->log, reg_btf, reg_ref_id, meta->btf, ref_id))
 		strict_type_match = true;
 
-	WARN_ON_ONCE(is_kfunc_trusted_args(meta) && reg->off);
+	WARN_ON_ONCE(is_kfunc_release(meta) &&
+		     (reg->off || !tnum_is_const(reg->var_off) ||
+		      reg->var_off.value));
 
 	reg_ref_t = btf_type_skip_modifiers(reg_btf, reg_ref_id, &reg_ref_id);
 	reg_ref_tname = btf_name_by_offset(reg_btf, reg_ref_t->name_off);
@@ -11917,12 +11919,8 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 					return -EINVAL;
 				}
 			}
-
 			fallthrough;
 		case KF_ARG_PTR_TO_CTX:
-			/* Trusted arguments have the same offset checks as release arguments */
-			arg_type |= OBJ_RELEASE;
-			break;
 		case KF_ARG_PTR_TO_DYNPTR:
 		case KF_ARG_PTR_TO_ITER:
 		case KF_ARG_PTR_TO_LIST_HEAD:
@@ -11935,7 +11933,6 @@ static int check_kfunc_args(struct bpf_verifier_env *env, struct bpf_kfunc_call_
 		case KF_ARG_PTR_TO_REFCOUNTED_KPTR:
 		case KF_ARG_PTR_TO_CONST_STR:
 		case KF_ARG_PTR_TO_WORKQUEUE:
-			/* Trusted by default */
 			break;
 		default:
 			WARN_ON_ONCE(1);
diff --git a/tools/testing/selftests/bpf/progs/nested_trust_failure.c b/tools/testing/selftests/bpf/progs/nested_trust_failure.c
index ea39497f11ed..3568ec450100 100644
--- a/tools/testing/selftests/bpf/progs/nested_trust_failure.c
+++ b/tools/testing/selftests/bpf/progs/nested_trust_failure.c
@@ -31,14 +31,6 @@ int BPF_PROG(test_invalid_nested_user_cpus, struct task_struct *task, u64 clone_
 	return 0;
 }
 
-SEC("tp_btf/task_newtask")
-__failure __msg("R1 must have zero offset when passed to release func or trusted arg to kfunc")
-int BPF_PROG(test_invalid_nested_offset, struct task_struct *task, u64 clone_flags)
-{
-	bpf_cpumask_first_zero(&task->cpus_mask);
-	return 0;
-}
-
 /* Although R2 is of type sk_buff but sock_common is expected, we will hit untrusted ptr first. */
 SEC("tp_btf/tcp_probe")
 __failure __msg("R2 type=untrusted_ptr_ expected=ptr_, trusted_ptr_, rcu_ptr_")
diff --git a/tools/testing/selftests/bpf/progs/nested_trust_success.c b/tools/testing/selftests/bpf/progs/nested_trust_success.c
index 833840bffd3b..2b66953ca82e 100644
--- a/tools/testing/selftests/bpf/progs/nested_trust_success.c
+++ b/tools/testing/selftests/bpf/progs/nested_trust_success.c
@@ -32,3 +32,11 @@ int BPF_PROG(test_skb_field, struct sock *sk, struct sk_buff *skb)
 	bpf_sk_storage_get(&sk_storage_map, skb->sk, 0, 0);
 	return 0;
 }
+
+SEC("tp_btf/task_newtask")
+__success
+int BPF_PROG(test_nested_offset, struct task_struct *task, u64 clone_flags)
+{
+	bpf_cpumask_first_zero(&task->cpus_mask);
+	return 0;
+}
diff --git a/tools/testing/selftests/bpf/verifier/calls.c b/tools/testing/selftests/bpf/verifier/calls.c
index ab25a81fd3a1..d76ef2018859 100644
--- a/tools/testing/selftests/bpf/verifier/calls.c
+++ b/tools/testing/selftests/bpf/verifier/calls.c
@@ -76,7 +76,7 @@
 	},
 	.prog_type = BPF_PROG_TYPE_SCHED_CLS,
 	.result = REJECT,
-	.errstr = "R1 must have zero offset when passed to release func or trusted arg to kfunc",
+	.errstr = "arg#0 expected pointer to ctx, but got PTR",
 	.fixup_kfunc_btf_id = {
 		{ "bpf_kfunc_call_test_pass_ctx", 2 },
 	},
-- 
2.45.2.803.g4e1b14247a-goog



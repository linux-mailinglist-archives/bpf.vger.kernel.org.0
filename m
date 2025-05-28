Return-Path: <bpf+bounces-59088-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 046E0AC6042
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 05:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 861069E6DE9
	for <lists+bpf@lfdr.de>; Wed, 28 May 2025 03:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68FF19DF7A;
	Wed, 28 May 2025 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDbPd7am"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F6D79FE;
	Wed, 28 May 2025 03:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748404179; cv=none; b=EF684i64bEAM1pEoVUYl8WmpNtdQEfyxMEbua/uvd4xZjoAloF+pESp+pXUX8T3aSHRkJsCV3bStCU0pi9cbZa3jlUfXxG+gFBfq/s1PgYHrYgOqks+8oGla0jcG3mJK4ECdrwd181jFglrMlMsLT9xKaBeUY26ghf/Hzdxf/Zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748404179; c=relaxed/simple;
	bh=VpOxDLtCCLaRkbmnHLjxYvgVK+VCfrqQqtJaOcMzFVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OMcmHkxHRLw0OETrDyIQMKq43P6Zqnm6ycdyJHOWIDoXimkryULMl4ul7YgZg0beLcCJ8QFWmgtRydBCV84p/VibS4qLx1h8RfxlGrzwwaW/Cv05QoC31mupBf4LfdfToH41+2NtMBnqYFmuvwQuOhXI+kfWePWm3vhH11HScWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDbPd7am; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-234bfe37cccso6983685ad.0;
        Tue, 27 May 2025 20:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748404176; x=1749008976; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XzyzbMvWUOyFazOMh1pAHgQ3SHM4z+OnF0DBC7L8JzI=;
        b=mDbPd7am2h0TPwNJn5F0YqvEFSSkocuh2nS2TVArm7cAdbCOzFE3bBdK9R79Laxx0X
         kX8/kS5+DRJAhrItrX9wIgTs8eWUKvkv9eP0g5ChaMwarobk2kJHrXSAscPQMKMTAs97
         o0hggd3lebyvL5IL7w52ZowQh0uTSbKgmvcVGCX+I7wdEvtnLDivQyeDyBp7DA3KLwY0
         izQCiRW+2umgwG3Y5UaHodadiIzomMMAgZwIQBtuJB9ihDokzqFcRrT/6WC95m5JFnzk
         j5ZkW1sNEaxIxosd/msK2dJ/EGfZyPCPNpsu5ab3GT/Xv4Rdx4V9V6C7/MUZcdFAN39B
         GZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748404177; x=1749008977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XzyzbMvWUOyFazOMh1pAHgQ3SHM4z+OnF0DBC7L8JzI=;
        b=axbyjWt/uGUDUIqCzKUDb0eqPAtNUSp6kczUDYtKYz1cXF/l3pCsjqGJsvw0BpdWzz
         DK4LV7Vt5Z2vHvPaBhnVrQ02GB+byFuFpy6bogUBV7srJBTKfrdPzqSG2b8qghaid+KS
         s7OBldCStC2E4uxHc20r1Ht54KrBOga2mAZb743UEs8KviYN4k3lDYbzBb7einXOnHm3
         oJ23KlA7UA2AAfcQ5TLhBeaJyxqcj0xCN7yu5CS6jL7Nys/qYLpCBDoxfkslUfmWEKTV
         /6Sk/d4vc+8CVDc/NfmbEr7rc6HeHVGfLMKhQEPlgH0ZaTzfXqis37D/L6fgFB75CMFA
         TMaw==
X-Forwarded-Encrypted: i=1; AJvYcCV8veJEgZWWpCrDMw2Wu6ug8SysmBqipbHNgpMc6/ftGYSm9GwXmnsaeB0jgDde5ornPunsr0Ah1THXB9w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAU8hvXTpLF+xrfWzphwrT/8qZQdogTW6Ble/aacwjsxSlF9Bx
	ZtwstcGvhVWEOgKd78iBrrl5+179b9+GAfuNx/JwY4I274UCEr2BiByD
X-Gm-Gg: ASbGncvdyhHMtAUo/YGEcGnZ0N0lOdIIAZPrFl0z79WRMfeVnOrxG0+OLvKmUciE/F1
	SLBInWJ1JJ1oE11DnuahCNIRQvWeBo14MVYRG0ABveqjrk8lxGqaeFNTggmiXwluwbyk7fxc6QI
	m0v0N1ODDTebG2+yfWoVWjebJX/jDTlwCYZqhFzmt69WqEJP906Aphwjrs1bFBst5KZL3ayp38U
	xkp+6SyJCzNpmCxox9d/mZFeOKHwZHK9sah4oRUaceK8XcBdJpPbQV5lzQJgG7aBPSdnozGKLZU
	yEmKtgOMhYXDbPSjwTIn+X4rWD2WEfG0gGE6A/pboRss8bEgpFZ57do6vnYGSd15zzJ/
X-Google-Smtp-Source: AGHT+IEfF6B6SHdyNFg0WCWGbI1KH1aJB8lPjmhI0YFFfQkSPlPQ8gyjeWw3pd5TyXcgJN1bNakPCg==
X-Received: by 2002:a17:902:ed93:b0:234:986c:66c4 with SMTP id d9443c01a7336-234986c6ad5mr71121325ad.1.1748404176366;
        Tue, 27 May 2025 20:49:36 -0700 (PDT)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-234d35ac417sm2074505ad.169.2025.05.27.20.49.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 May 2025 20:49:35 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: alexei.starovoitov@gmail.com,
	rostedt@goodmis.org,
	jolsa@kernel.org
Cc: bpf@vger.kernel.org,
	Menglong Dong <dongml2@chinatelecom.cn>,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 00/25] bpf: tracing multi-link support
Date: Wed, 28 May 2025 11:46:47 +0800
Message-Id: <20250528034712.138701-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After four months, I finally finish the coding and testing of this series.
This is my first time to write such a complex series, and it's so hard :/
Anyway, I finished it.
(I'm scared :/)

For now, the BPF program of type BPF_PROG_TYPE_TRACING is not allowed to
be attached to multiple hooks, and we have to create a BPF program for
each kernel function, for which we want to trace, even through all the
program have the same (or similar) logic. This can consume extra memory,
and make the program loading slow if we have plenty of kernel function to
trace.

In this series, we add the support to allow attaching a tracing BPF
program to multi hooks, which is similar to BPF_TRACE_KPROBE_MULTI.
Generally speaking, this series can be divided into 5 parts:

1. Add per-function metadata storage support.
2. Add bpf global trampoline support for x86_64.
3. Add bpf global trampoline link support.
4. Add tracing multi-link support.
5. Compatibility between tracing and tracing_multi.

per-function metadata storage
-----------------------------
The per-function metadata storage is the basic of the bpf global
trampoline. It has 2 mode: function padding mode and hash table mode. When
The CONFIG_FUNCTION_METADATA_PADDING is enabled, the function padding mode
will be used, and it has higher performance with almost no overhead. It
will allocate a metadata array and storage the index of the metadata to
the function padding.

The function padding can increase the text size, so it can be not
enabled sometimes. When the CONFIG_FUNCTION_METADATA is not enabled, we
will fallback to the hash table mode, and storage the function metadata
in a hlist.

The release of the metadata is a big difficulty in the function padding
mode. In this mode, we use a metadata array to store the metadata. The
array need to be enlarged when it is full. So we not only need to control
the release of the metadata, but also the release of the metadata array.
per-cpu ref and rcu are used in these situations. The release of the
metadata is much easier in the hash table mode. We just need to use the
rcu to release the metadata.

For now, function padding mode is supported in x86_64 and arm64. And
the function metadata is only used by the bpf global trampoline in x86_64.
So maybe we don't need to support the function padding mode in arm64 in
this series?

The performance comparison between the function padding mode and hash
table mode can be found in the following commit log. As Alexei pointed
out in [1], we can fallback to the hash table mode when the function
padding is not supported.

bpf global trampoline
---------------------
The bpf global trampoline is similar to the general bpf trampoline. The
bpf trampoline store the bpf progs and some metadata in the trampoline
instructions directly. However, the bpf global trampoline store and get
the metadata from the function metadata with kfunc_md_get_noref(). This
makes the bpf global trampoline more flexible and can be used for all the
kernel functions with a single instance.

The bpf global trampoline is designed to implement the tracing multi-link
for FENTRY, FEXIT and MODIFY_RETURN. Sleepable bpf progs are not
supported, as we call __bpf_prog_enter_recur() and __bpf_prog_exit_recur()
directly in the bpf global trampoline, which can be optimized later. And
we make __bpf_prog_{enter,exit}_recur() global to use it in the global
trampoline.

The overhead of the bpf global trampoline is slightly higher than the
function trampoline, as we need prepare all the things we need in the
stack. For example, we store the address of the traced function in the
stack for bpf_get_func_ip(), even if it is not used.

As Steven mentioned in [1], we need to mitigate for spectre, as we use
indirect call in the bpf global trampoline. I haven't fully understood
Spectre yet, and I make the indirect call with CALL_NOSPEC just like the
others do. Could it prevent the spectre?

bpf global trampoline link
--------------------------
We reuse part of the code in [2] to implement the tracing multi-link. The
struct bpf_gtramp_link is introduced for the bpf global trampoline link.
Similar to the bpf trampoline link, the bpf global trampoline link has
bpf_gtrampoline_link_prog() and bpf_gtrampoline_unlink_prog() to link and
unlink the bpf progs.

The "entries" in the bpf_gtramp_link is a array of struct
bpf_gtramp_link_entry, which contain all the information of the functions
that we trace, such as the address, the number of args, the cookie and so
on.

The bpf global trampoline is much simpler than the bpf trampoline, and we
introduce then new struct bpf_global_trampoline for it. The "image" field
is a pointer to bpf_global_caller. We implement the global trampoline
based on the direct ftrace, and the "fops" field for this propose. This
means bpf2bpf is not supported by the tracing multi-link.

When we link the bpf prog, we will add it to all the target functions'
kfunc_md. Then, we get all the function addresses that have bpf progs with
kfunc_md_bpf_ips(), and reset the ftrace filter of the fops to it. The
direct ftrace don't support to reset the filter functions yet, so we
introduce the reset_ftrace_direct_ips() to do this.

We use a global lock to protect the global trampoline, and we need to hold
it when we link or unlink the bpf prog. The global lock is a read-write.
In fact, it should be a mutex here, the rw_semaphore is used for the
following patches that make tracing_multi compatible with tracing.

tracing multi-link
------------------
Most of the code of this part comes from the series [2].

In the 10th patch, we add the support to record index of the accessed
function args of the target for tracing program. Meanwhile, we add the
function btf_check_func_part_match() to compare the accessed function args
of two function prototype. This function will be used in the next commit.

In the 11th patch, we refactor the struct modules_array to ptr_array, as
we need similar function to hold the target btf, target program and kernel
modules that we reference to in the following commit.

In the 15th patch, we implement the multi-link support for tracing, and
following new attach types are added:

  BPF_TRACE_FENTRY_MULTI
  BPF_TRACE_FEXIT_MULTI
  BPF_MODIFY_RETURN_MULTI

We introduce the struct bpf_tracing_multi_link for this purpose, which
can hold all the kernel modules, target bpf program (for attaching to bpf
program) or target btf (for attaching to kernel function) that we
referenced.

During loading, the first target is used for verification by the verifier.
And during attaching, we check the consistency of all the targets with
the first target.

Compatibility between tracing and tracing_multi
------------------------------------------------
The tracing_multi is not compatible with the tracing without the 16-18th
patches. For example, we will fail on attaching the FENTRY_MULTI to the
functions that FENTRY exists, and FENTRY will also fail if FENTRY_MULTI
exists.

Generally speaking, we will replace the global trampoline with bpf
trampoline if both of them exist on the same function. The function
replace_ftrace_direct() is added for this, which is used to replace the
direct ftrace_ops with another one for all the filter functions in the
source ftrace_ops.

The most difficult part is synchronization between
bpf_gtrampoline_link_prog and bpf_trampoline_link_prog, and we use a
rw_semaphore here, which is quite ugly. We hold the write lock in
bpf_gtrampoline_link_prog and read lock in bpf_trampoline_link_prog.

We introduce the function bpf_gtrampoline_link_tramp() to make
bpf_gtramp_link fit bpf_trampoline, which will be called in
bpf_gtrampoline_link_prog(). If the bpf_trampoline of the function exist
in the kfunc_md or we find it with bpf_trampoline_lookup_exist(), it means
that we need do the fitting. The fitting is simple, we create a
bpf_shim_tramp_link for our prog and link it to the bpf_trampoline with
__bpf_trampoline_link_prog().

It's a little complex for the bpf_trampoline_link_prog() case. We create
bpf_shim_tramp_link for all the bpf progs in kfunc_md and add it to the
bpf_trampoline before we call __bpf_trampoline_link_prog() in
bpf_gtrampoline_override(). And we will fallback in
bpf_gtrampoline_override_finish() if error is returned by
__bpf_trampoline_link_prog().

Another solution is to fit into the existing trampoline. For example, we
can add the bpf prog to the kfunc_md if tracing_multi bpf prog is attached
on the target function when we attach a tracing bpf prog. And we can also
update the tracing_multi prog to the trampoline if tracing prog exists
on the target function. I think this will make the compatibility much
easier.

The code in this part is very ugly and messy, and I think it will be a
liberation to split it out to another series :/

Performance comparison
----------------------
We have implemented the performance testings in the selftests in
test_tracing_multi_bench(), and you can get the result by running:

  ./test_progs -t tracing_multi_bench -v | grep time

In this testcase, bpf_fentry_test1() will be called 10000000 times, and
the time consumed will be returned and printed. Following cases is
considered:

- nop: nothing is attached to bpf_fentry_test1()
- fentry: a empty FENTRY bpf program is attached to bpf_fentry_test1()
- fentry_multi_single: a empty FENTRY_MULTI bpf program is attached to
  bpf_fentry_test1().
  We alias it as "fm_single" in the following.
- fentry_multi_all: a empty FENTRY_MULTI bpf program is attached to all
  the kernel functions.
  We alias it as "fm_all" in the following.
- kprobe_multi_single: a empty KPROBE_MULTI bpf program is attached to
  bpf_fentry_test1().
  We alias it as "km_single" in the following.
- kprobe_multi_all: a empty KPROBE_MULTI bpf program is attached to all
  the kernel functions.
  We alias it as "km_all" in the following.

The "fentry_multi_all" is used to test the performance of the hash table
mode of the function metadata.

Different kconfig can affect the performance, and the base kconfig we use
comes from debian 12.

no-mitigate + hash table mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
nop     | fentry    | fm_single | fm_all    | km_single | km_all
9.014ms | 162.378ms | 180.511ms | 446.286ms | 220.634ms | 1465.133ms
9.038ms | 161.600ms | 178.757ms | 445.807ms | 220.656ms | 1463.714ms
9.048ms | 161.435ms | 180.510ms | 452.530ms | 220.943ms | 1487.494ms
9.030ms | 161.585ms | 178.699ms | 448.167ms | 220.107ms | 1463.785ms
9.056ms | 161.530ms | 178.947ms | 445.609ms | 221.026ms | 1560.584ms

The mitigate is enabled by default in the kernel, and we can disable it
with the "mitigations=off" cmdline to do the testing.

The count of the kernel functions that we traced in the fentry_multi_all
and kprobe_multi_all testcase is 43871, which can be obtained by running:

$ ./test_progs -t trace_bench -v | grep before
attach 43871 functions before testings
attach 43871 functions before testings

However, we use hlist_add_tail_rcu() in the kfunc_md, and bpf_fentry_test1
is the 39425th function in
/sys/kernel/debug/tracing/available_filter_functions, which means the
bpf_fentry_test1 is in the tail of the hlist budget. So we can image that
the total traced functions is 79k(39425 * 2) to make the hash table lookup
fair enough.

Note, the performance of fentry can vary significantly with different
kconfig. When the kernel is compiled with "tinyconfig" of x86_64, the
performance of fentry is about 80ms, and the fentry_multi is about 95ms.

mitigate + hash table mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^
nop      | fentry    | fm_single | fm_all     | km_single  | km_all
37.348ms | 753.621ms | 844.110ms | 1033.151ms | 1033.814ms | 2403.759ms
37.439ms | 753.894ms | 843.922ms | 1033.182ms | 1034.066ms | 2364.879ms
37.420ms | 754.802ms | 844.430ms | 1046.192ms | 1035.357ms | 2368.233ms
37.436ms | 754.051ms | 844.831ms | 1035.204ms | 1034.431ms | 2252.827ms
37.425ms | 753.802ms | 844.714ms | 1106.462ms | 1034.119ms | 2252.217ms

The performance of fentry_multi is much higher than fentry with
mitigations, and I think that it is because we made one more function call
in the fentry_multi, which is the kfunc_md_get_noref(). What's more, the
mitigate for the indirect call in the bpf global trampoline also increase
the overhead. We can still do some optimizations in the bpf global
trampoline.

I think this is what Alexei meant in [1], that the performance suffers
from the mitigations anyway, so the indirect call doesn't matter in this
case.

no-mitigate + function padding mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
nop     | fentry    | fm_single | fm_all    | km_single | km_all
9.320ms | 166.454ms | 184.094ms | 193.884ms | 227.320ms | 1441.462ms
9.326ms | 166.651ms | 183.954ms | 193.912ms | 227.503ms | 1544.634ms
9.313ms | 170.501ms | 183.985ms | 191.738ms | 227.801ms | 1441.284ms
9.311ms | 166.957ms | 182.086ms | 192.063ms | 410.411ms | 1489.665ms
9.329ms | 166.332ms | 182.196ms | 194.154ms | 227.443ms | 1511.272ms

The overhead of fentry_multi_all is a little higher than the
fentry_multi_single. Maybe it is because the function
ktime_get_boottime_ns(), which is used in bpf_testmod_bench_run(), is also
traced? I haven't figured it out yet, but it doesn't matter :/

The overhead of fentry_multi_single is a little higher than the fentry,
and it makes sense, as we do more things in the bpf global trampoline. In
comparison, the bpf trampoline is simpler.

mitigate + function padding mode
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
nop      | fentry    | fm_single | fm_all    | km_single  | km_all
37.340ms | 754.659ms | 840.295ms | 849.632ms | 1043.997ms | 2180.874ms
37.543ms | 753.809ms | 840.535ms | 849.746ms | 1034.481ms | 2355.085ms
37.442ms | 753.803ms | 840.797ms | 850.012ms | 1034.462ms | 2276.567ms
37.501ms | 753.931ms | 840.789ms | 850.938ms | 1035.594ms | 2218.350ms
37.700ms | 753.714ms | 840.875ms | 851.614ms | 1034.465ms | 2329.307ms

conclusion
^^^^^^^^^^
The performance of fentry_multi is close to fentry in the function padding
mode. And in the hash table mode, the performance of fentry_multi can be
276% of fentry when the number of the traced functions is 79k.

Link: https://lore.kernel.org/all/20250303132837.498938-1-dongml2@chinatelecom.cn/ [1]
Link: https://lore.kernel.org/bpf/20240311093526.1010158-1-dongmenglong.8@bytedance.com/ [2]
Menglong Dong (25):
  add per-function metadata storage support
  x86: implement per-function metadata storage for x86
  arm64: implement per-function metadata storage for arm64
  bpf: make kfunc_md support global trampoline link
  x86,bpf: add bpf_global_caller for global trampoline
  ftrace: factor out ftrace_direct_update from register_ftrace_direct
  ftrace: add reset_ftrace_direct_ips
  bpf: introduce bpf_gtramp_link
  bpf: tracing: add support to record and check the accessed args
  bpf: refactor the modules_array to ptr_array
  bpf: verifier: add btf to the function args of bpf_check_attach_target
  bpf: verifier: move btf_id_deny to bpf_check_attach_target
  x86,bpf: factor out __arch_get_bpf_regs_nr
  bpf: tracing: add multi-link support
  ftrace: factor out __unregister_ftrace_direct
  ftrace: supporting replace direct ftrace_ops
  bpf: make trampoline compatible with global trampoline
  libbpf: don't free btf if tracing_multi progs existing
  libbpf: support tracing_multi
  libbpf: add btf type hash lookup support
  libbpf: add skip_invalid and attach_tracing for tracing_multi
  selftests/bpf: use the glob_match() from libbpf in test_progs.c
  selftests/bpf: add get_ksyms and get_addrs to test_progs.c
  selftests/bpf: add testcases for multi-link of tracing
  selftests/bpf: add performance bench test for trace prog

 arch/arm64/Kconfig                            |  21 +
 arch/arm64/Makefile                           |  23 +-
 arch/arm64/include/asm/ftrace.h               |  34 +
 arch/arm64/kernel/ftrace.c                    |  13 +-
 arch/x86/Kconfig                              |  30 +
 arch/x86/include/asm/alternative.h            |   2 +
 arch/x86/include/asm/ftrace.h                 |  47 ++
 arch/x86/kernel/asm-offsets.c                 |  15 +
 arch/x86/kernel/callthunks.c                  |   2 +-
 arch/x86/kernel/ftrace.c                      |  26 +
 arch/x86/kernel/ftrace_64.S                   | 231 ++++++
 arch/x86/net/bpf_jit_comp.c                   |  36 +-
 include/linux/bpf.h                           |  67 ++
 include/linux/bpf_types.h                     |   1 +
 include/linux/bpf_verifier.h                  |   1 +
 include/linux/ftrace.h                        |  15 +
 include/linux/kfunc_md.h                      |  63 ++
 include/uapi/linux/bpf.h                      |  10 +
 kernel/bpf/btf.c                              | 113 ++-
 kernel/bpf/syscall.c                          | 409 ++++++++++-
 kernel/bpf/trampoline.c                       | 476 +++++++++++-
 kernel/bpf/verifier.c                         | 161 ++--
 kernel/trace/Makefile                         |   1 +
 kernel/trace/bpf_trace.c                      |  48 +-
 kernel/trace/ftrace.c                         | 288 ++++++--
 kernel/trace/kfunc_md.c                       | 689 ++++++++++++++++++
 net/bpf/test_run.c                            |   3 +
 net/core/bpf_sk_storage.c                     |   2 +
 tools/bpf/bpftool/common.c                    |   3 +
 tools/include/uapi/linux/bpf.h                |  10 +
 tools/lib/bpf/bpf.c                           |  10 +
 tools/lib/bpf/bpf.h                           |   6 +
 tools/lib/bpf/btf.c                           | 102 +++
 tools/lib/bpf/btf.h                           |   6 +
 tools/lib/bpf/libbpf.c                        | 288 +++++++-
 tools/lib/bpf/libbpf.h                        |  25 +
 tools/lib/bpf/libbpf.map                      |   5 +
 tools/testing/selftests/bpf/Makefile          |   2 +-
 .../selftests/bpf/prog_tests/fentry_fexit.c   |  22 +-
 .../selftests/bpf/prog_tests/fentry_test.c    |  79 +-
 .../selftests/bpf/prog_tests/fexit_test.c     |  79 +-
 .../bpf/prog_tests/kprobe_multi_test.c        | 220 +-----
 .../selftests/bpf/prog_tests/modify_return.c  |  60 ++
 .../selftests/bpf/prog_tests/trace_bench.c    | 149 ++++
 .../bpf/prog_tests/tracing_multi_link.c       | 276 +++++++
 .../selftests/bpf/progs/fentry_empty.c        |  13 +
 .../selftests/bpf/progs/fentry_multi_empty.c  |  13 +
 .../testing/selftests/bpf/progs/trace_bench.c |  21 +
 .../bpf/progs/tracing_multi_override.c        |  28 +
 .../selftests/bpf/progs/tracing_multi_test.c  | 181 +++++
 .../selftests/bpf/test_kmods/bpf_testmod.c    |  40 +
 tools/testing/selftests/bpf/test_progs.c      | 349 ++++++++-
 tools/testing/selftests/bpf/test_progs.h      |   5 +
 53 files changed, 4334 insertions(+), 485 deletions(-)
 create mode 100644 include/linux/kfunc_md.h
 create mode 100644 kernel/trace/kfunc_md.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/trace_bench.c
 create mode 100644 tools/testing/selftests/bpf/prog_tests/tracing_multi_link.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_empty.c
 create mode 100644 tools/testing/selftests/bpf/progs/fentry_multi_empty.c
 create mode 100644 tools/testing/selftests/bpf/progs/trace_bench.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_override.c
 create mode 100644 tools/testing/selftests/bpf/progs/tracing_multi_test.c

-- 
2.39.5



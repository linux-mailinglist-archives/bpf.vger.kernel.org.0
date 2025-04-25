Return-Path: <bpf+bounces-56697-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4BA8A9CC0D
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 16:50:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57F773AFFE7
	for <lists+bpf@lfdr.de>; Fri, 25 Apr 2025 14:50:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136C82580F9;
	Fri, 25 Apr 2025 14:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ej+jyRw/"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E7228EC;
	Fri, 25 Apr 2025 14:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745592625; cv=none; b=NGYnkD0J75liADMS8pjMHBo1AbgyHgYRgmQ952kmmxBMRqLmUWIyPk279HMkTdATHJERusIqql0xW6PwrC0uKMbLHinGvkLbWbJFflbUu7fYIMhvgKcIPHeKyCiO8ZI9jX3DnMy5Q9nJjuBM7AqYDnePKEp8mmzIHFJfoAq7Rck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745592625; c=relaxed/simple;
	bh=rqBDcm5K2es7T/K3mF5QtiO717oSQOuvCM6FWzrNw6o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=Tyie0vADXhPQFF2JSUvtMpgTETVWPCx5icggAdaHIALQVpiwjVbb54PHqSWxr4ACgL7rHytSNmlKVuBugFFU5VLmPYoct/uV6lzEm9CYpec9NIZWEstt7/gRWJDHlTmZM1ncebcxcl8ekXZoFFaS5DUjD4IY6EdmurSvDiaIuO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ej+jyRw/; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-39c31e4c3e5so1524798f8f.0;
        Fri, 25 Apr 2025 07:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745592622; x=1746197422; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=SfJxTlL3V3a7gTMiYPH62HJiED0ZxboNjSbaytkQxb8=;
        b=ej+jyRw/lOo7AkbkOSzxwz/1CH2p7XRfuQJKDEH07M31P16o1R3NHamv8R6v9nIGkn
         4PoCFcwHSXQs1UO7BAvEbunxF7pPBT1dGaC2T9bA4mYjAtqoKI+hO/zQiPtKEGKHZfA6
         BTskS0GXctkSnEPdCdL+oXq69sylGl8vZv0ySTbOxQ9t4kaao99V/gw5ezk2rmRD+mu0
         r1OACvkkDUxLYELyUoWK32xObP7hOqtkyp2EPx2D1fPWBYJ97iJ4/03k4Zly7hI0ruAQ
         1915eQpddvu8F+vKNc2Ol1/WfPsh2EYhXijXHfSqx5w9asUnElM/rWkb20N6QmSFNMTF
         T/Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745592622; x=1746197422;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SfJxTlL3V3a7gTMiYPH62HJiED0ZxboNjSbaytkQxb8=;
        b=T56nPCFki+cY0GjHSNQ0qPJNzN8mOhthLjbRA+0QpJ6GsTKCR0/xltX0cHRdNhis6b
         6ydHqEtVSlyWEa5b8gURTJ5PKsvszpnc4SY7caY64QVUiZdnVwvR+cQ839PBk1L0dzS7
         evqNyrvEFBDm1mlcge2QVm0ycAMFSxnt2AE9fjsW4afoCiU+aDYj/q7BQR4vR9tBK6+d
         ButSossyR8hVVupobdUvCQckb5rl3B5WLO7wrZs6k12qIoFonkLY7Ywf1mOm/oH+fu4k
         RQLZZ2Euw9eKsKFaHbhvxdhgrsCkLjhfOgvvMo7V3bl9RIvlLYj04jeybJtD1ElDf8wF
         LSZw==
X-Forwarded-Encrypted: i=1; AJvYcCVyqtKH7jBg1Fs2SMFnloPwnlqFpR0zTewh3xk0v8OpAn2YWVw4skxE8kss1WkF1obSvtzyhQq2sg==@vger.kernel.org, AJvYcCWwdvpkB55TlwjcOHjGlMpwvS+q0OcbFTegKTo+CFnCp8aaLtT/zOCxl+EqK+igDZQ+dBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYmjOFrw4eNEn22rTN0Blfrg0zJG76MBeCnPU4rBsTq675dNHM
	ZunZe3DF+028cdYvgU9W+XkVDX9Sadf/1Hx7iZ5jRyL5+eW9s8xx+9+/yUFy68nomcU1TtzSztC
	cXDmidkhWIAI129rYWJsSd0D/LCo=
X-Gm-Gg: ASbGnctZ8/KbClM0buWJn95boMh7XVoqmMnQFC2bVe0DJAj17skKncSvIPVzu4NlUWG
	Hbcup7qJl4hi4G6Yz3F20+sDDAPelPNNvNVPwL9XErSqzU15/iEcAgBVNodv5v4zOAvmOFKbrGz
	xqG5k0aK+VPb9ypF5lII8FVX88echF7t1Lps/vZg==
X-Google-Smtp-Source: AGHT+IFCMSIvH/NcaG9Xw17exkXZ0AJPHqDIJQHH7BcdKGAHaFVFSo8buhi5GAOR/b1mJYRNmUB6JPckY7rqHAwMBYg=
X-Received: by 2002:a5d:5848:0:b0:399:6dc0:f15b with SMTP id
 ffacd0b85a97d-3a074f79246mr2231396f8f.48.1745592621871; Fri, 25 Apr 2025
 07:50:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 25 Apr 2025 07:50:10 -0700
X-Gm-Features: ATxdqUHu6zJTVSfX4-UMQhvcZPgod5cnqWEF4_l_itkOy51Mlgd-g2rUXZGawNY
Message-ID: <CAADnVQL+-LiJGXwxD3jEUrOonO-fX0SZC8496dVzUXvfkB7gYQ@mail.gmail.com>
Subject: pahole and gcc-14 issues
To: Alan Maguire <alan.maguire@oracle.com>, Arnaldo Carvalho de Melo <acme@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Eduard <eddyz87@gmail.com>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, bpf <bpf@vger.kernel.org>, dwarves@vger.kernel.org, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hi All,

Looks like pahole fails to deduplicate BTF when kernel and
kernel module are built with gcc-14.
I see this issue with various kernel .config-s on bpf and
bpf-next trees.
I tried pahole 1.28 and the latest master. Same issues.

BTF in bpf_testmod.ko built with gcc-14 has 2849 types.
When built with gcc-13 it has 454 types.
So something is confusing dedup logic.
Would be great if dedup experts can take a look,
since this dedup issue is breaking a lot of selftests/bpf.

Also vmlinux.h generated out of the kernel compiled with gcc-13
and out of the kernel compiled with gcc-14 shows these differences:

--- vmlinux13.h    2025-04-24 21:33:50.556884372 -0700
+++ vmlinux14.h    2025-04-24 21:39:10.310488992 -0700
@@ -148815,7 +148815,6 @@
 extern int hid_bpf_input_report(struct hid_bpf_ctx *ctx, enum
hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
 extern void hid_bpf_release_context(struct hid_bpf_ctx *ctx) __weak __ksym;
 extern int hid_bpf_try_input_report(struct hid_bpf_ctx *ctx, enum
hid_report_type type, u8 *buf, const size_t buf__sz) __weak __ksym;
-extern bool scx_bpf_consume(u64 dsq_id) __weak __ksym;
 extern int scx_bpf_cpu_node(s32 cpu) __weak __ksym;
 extern struct rq *scx_bpf_cpu_rq(s32 cpu) __weak __ksym;
 extern u32 scx_bpf_cpuperf_cap(s32 cpu) __weak __ksym;
@@ -148825,12 +148824,8 @@
 extern void scx_bpf_destroy_dsq(u64 dsq_id) __weak __ksym;
 extern void scx_bpf_dispatch(struct task_struct *p, u64 dsq_id, u64
slice, u64 enq_flags) __weak __ksym;
 extern void scx_bpf_dispatch_cancel(void) __weak __ksym;
-extern bool scx_bpf_dispatch_from_dsq(struct bpf_iter_scx_dsq
*it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
__ksym;
-extern void scx_bpf_dispatch_from_dsq_set_slice(struct
bpf_iter_scx_dsq *it__iter, u64 slice) __weak __ksym;
 extern void scx_bpf_dispatch_from_dsq_set_vtime(struct
bpf_iter_scx_dsq *it__iter, u64 vtime) __weak __ksym;
 extern u32 scx_bpf_dispatch_nr_slots(void) __weak __ksym;
-extern void scx_bpf_dispatch_vtime(struct task_struct *p, u64 dsq_id,
u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
-extern bool scx_bpf_dispatch_vtime_from_dsq(struct bpf_iter_scx_dsq
*it__iter, struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak
__ksym;
 extern void scx_bpf_dsq_insert(struct task_struct *p, u64 dsq_id, u64
slice, u64 enq_flags) __weak __ksym;
 extern void scx_bpf_dsq_insert_vtime(struct task_struct *p, u64
dsq_id, u64 slice, u64 vtime, u64 enq_flags) __weak __ksym;
 extern bool scx_bpf_dsq_move(struct bpf_iter_scx_dsq *it__iter,
struct task_struct *p, u64 dsq_id, u64 enq_flags) __weak __ksym;

gcc-14's kernel is clearly wrong.
These 5 kfuncs still exist in the kernel.
I manually checked there is no if __GNUC__ > 13 in the code.
Also:
nm bld/vmlinux|grep -w scx_bpf_consume
ffffffff8159d4b0 T scx_bpf_consume
ffffffff8120ea81 t scx_bpf_consume.cold

I suspect the second issue is not related to the dedup problem.
All 5 missing kfuncs have ".cold" optimized bodies.
But ".cold" maybe a red herring, since
nm bld/vmlinux|grep -w scx_bpf_dispatch
ffffffff8159d020 T scx_bpf_dispatch
ffffffff8120ea0f t scx_bpf_dispatch.cold
but this kfunc is present in vmlinux14.h

If it makes a difference I have these configs:
# CONFIG_DEBUG_INFO_DWARF4 is not set
# CONFIG_DEBUG_INFO_DWARF5 is not set
# CONFIG_DEBUG_INFO_REDUCED is not set
CONFIG_DEBUG_INFO_COMPRESSED_NONE=y
# CONFIG_DEBUG_INFO_COMPRESSED_ZLIB is not set
# CONFIG_DEBUG_INFO_SPLIT is not set
CONFIG_DEBUG_INFO_BTF=y
CONFIG_PAHOLE_HAS_SPLIT_BTF=y
CONFIG_DEBUG_INFO_BTF_MODULES=y


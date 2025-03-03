Return-Path: <bpf+bounces-53055-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70838A4C1E9
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 14:30:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8105116F93C
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 13:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC946212D8B;
	Mon,  3 Mar 2025 13:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6YGDhyn"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD65D212B15;
	Mon,  3 Mar 2025 13:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741008631; cv=none; b=hnCw1DRHlIluVcfqY0dMSjrvWjFzAzQUHyjYcmGb8xEK+X+FtNMB05fzcAzBpyKzo+5VwxE+GdEueRnfpnscmXBZy5OV/AW+xp6I0lv2WJ937Kp24BNRtfYa2wslj1k5n5zDtewb3OV5TQwCDwOF8HCh4uz/v4bbYwDRzz0Df/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741008631; c=relaxed/simple;
	bh=bWdVzLVWRtavYw5+TVc3lHNfvzogIph6bEYfLtcnLfk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rLxlE0FKI0UZCVe4rSz/zBWC85ETV6C+cG92ObCN9i+A1lPPTh6nc6rxw7e1V2ptWKr6E79XUKCeUPCYfwkQrcC0A7pgjGGDpGD4G15Jy+tOSvBMylHLqJjPmelMFYpSplHx/YjS87XVGKYvBn4FDoZ3cqIh+l/DSlYKNtYkCU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6YGDhyn; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-22349dc31bcso75967265ad.3;
        Mon, 03 Mar 2025 05:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741008629; x=1741613429; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gNjkZXsFxPWFMyK2OgocbrFn2IS3HWHLODQTFVqVxX4=;
        b=d6YGDhynFBYCicMoJndNUn2iixQPihBeBsSdb/DJN1CNomZ2FH99sTpeP+iEHBMTA8
         A728yazUhWaMq+ZhxgG893WPHcJNdwOEL2ovzCD+T7WLI+mw+2xp8PX5k+MmNbK7R9fH
         BJuiY/8AL76Q/pYvU1XpLqNkm4flQDMox/LFT+lJTXd5ZOSAoFRAekdPif1pbq21ZVBq
         KVymGAETuXMP3dJhQ3aMpwR4RB7tPS+69KoFMOxlALpspheu47zl8HmoO/YgMeI6ALuA
         Q2/QbsDMEjExw/+mzOCywZg45WfBtgBofoNx/pPqOZe174wiJ9rSkEox7Z8sKuLzNGBh
         4JXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741008629; x=1741613429;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gNjkZXsFxPWFMyK2OgocbrFn2IS3HWHLODQTFVqVxX4=;
        b=BR5oil1o6p3zHVOpWcn3VI4JqV2+CjszXRFAN9kJ7yomvj5GBrGp807ZG6R+dHgObj
         c25gOX9XWKAHirpm/nyoQtPXB4KtxZpBf9BzmfxEmim07mlbiRnZpFQJEoKt1srcmyyn
         0l9QaTcLS7n3slVzsL5H5upsuP6cu9MyJvSNIWg8pPA88D5tPFz1R1VAgyYkA643TPGJ
         WXRhr+IG0AUrNCtoETvIlIBpYdVW69Kw3RGlpZETmAfIB08MQMnkF5rPBOzzEAvqj5ZU
         eYK2NhdejFAb1XIG0uJMxlTDJcIzURbFmOWiDgOHHyk4Ci869wDHMkEoVDRW5OUuh6MV
         +CqQ==
X-Forwarded-Encrypted: i=1; AJvYcCUVm8V8DUDEFQjHzlaV290r+8RFaaZVL7m8Ar6AHoeH/qX+5WHh+kms7EBFLfThwcEQoBkwNQTr@vger.kernel.org, AJvYcCUk52hOLiQJB4Fz38zVW4feBblOUzBQ70VcvCdmwhfOGM9T4dRj798dwL4BJrsROg44frY=@vger.kernel.org, AJvYcCVD9byp5ywtSQd63k099HP+ZFihNqGAolk8xLy+4CeOe/6uCf64HKuEgj+Ih28EsZ3hqDpkomM7F+V9h34L@vger.kernel.org, AJvYcCVX3xjOOPtde6JaM9bpSzZP/hk3sKVgkr6KXJ39o0eVJDx+UpkmgXpHtTtoFGpwNiikllsOlTxf0YdTm3BTwFQk5umm@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9BA9XQx4s/Wa+96WArzM109k7opCqOkgRJbmbwvEhh5xLujWj
	9fWvEI2sp1C78u6jJw/KesQK6rtZsqBzafxR9F32YN3rR3k/hKtD
X-Gm-Gg: ASbGnctv1w4XHYBz92amDn3fs6NpK4eNaumxU3SUCxibAWbTT3EOT7Hl4D3j83CU4XS
	nWZ2Zbb7yL8iLSJu6ZzeCxMDahqzgDlDYDDqK3QyD3+SPSkO2kXWq6MWDTVMn7+yhrGRwDPud0w
	ildBKy2UBKfz+McXjUJYMkPkN2C08sdp1QpbCRZSWuWjii1Iq+2xd00poBTGLVPyFY/MTuM4JlJ
	KTlanD8TXPVgZfcp+0WFhRlY+iXdheRZUNqr46pvDiCO77C8LFVdY9PE8e9I6u+vd9FDrtR82c1
	g1N+IicJJZ1w3aG21Pc3C0ShN4BrKdsK3k9Pl7WVl1u3AvgP3jJAlZA4Jqefdw==
X-Google-Smtp-Source: AGHT+IGzwQpz8i9IoNIFYRlZqYmQzdkErFQv2wnbEGpUy1JVrV1T6QdikCneYnb/qYuevmlNGOS4BA==
X-Received: by 2002:a17:903:244d:b0:210:fce4:11ec with SMTP id d9443c01a7336-22368f6a5f1mr188695035ad.1.1741008628736;
        Mon, 03 Mar 2025 05:30:28 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-223505359b8sm77297035ad.253.2025.03.03.05.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Mar 2025 05:30:28 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: peterz@infradead.org,
	rostedt@goodmis.org,
	mark.rutland@arm.com,
	alexei.starovoitov@gmail.com
Cc: catalin.marinas@arm.com,
	will@kernel.org,
	mhiramat@kernel.org,
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	x86@kernel.org,
	hpa@zytor.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	jolsa@kernel.org,
	davem@davemloft.net,
	dsahern@kernel.org,
	mathieu.desnoyers@efficios.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	samitolvanen@google.com,
	kees@kernel.org,
	dongml2@chinatelecom.cn,
	akpm@linux-foundation.org,
	riel@surriel.com,
	rppt@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v4 0/4] per-function storage support
Date: Mon,  3 Mar 2025 21:28:33 +0800
Message-Id: <20250303132837.498938-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For now, there isn't a way to set and get per-function metadata with
a low overhead, which is not convenient for some situations. Take
BPF trampoline for example, we need to create a trampoline for each
kernel function, as we have to store some information of the function
to the trampoline, such as BPF progs, function arg count, etc. The
performance overhead and memory consumption can be higher to create
these trampolines. With the supporting of per-function metadata storage,
we can store these information to the metadata, and create a global BPF
trampoline for all the kernel functions. In the global trampoline, we
get the information that we need from the function metadata through the
ip (function address) with almost no overhead.

Another beneficiary can be ftrace. For now, all the kernel functions that
are enabled by dynamic ftrace will be added to a filter hash if there are
more than one callbacks. And hash lookup will happen when the traced
functions are called, which has an impact on the performance, see
__ftrace_ops_list_func() -> ftrace_ops_test(). With the per-function
metadata supporting, we can store the information that if the callback is
enabled on the kernel function to the metadata.

In the 1st patch, we factor out FINEIBT_INSN_OFFSET and CFI_INSN_OFFSET to
make fineibt works when the kernel function is 32-bytes aligned.

In the 2nd patch, we implement the per-function metadata storage by
storing the index of the metadata to the function padding space.

In the 3rd and 4th patch, we implement the per-function metadata storage
for x86 and arm64. And in the feature, we can support more arch.

Changes since V3:
- rebase to the newest tip/x86/core, the fineibt has some updating

Changes since V2:
- split the patch into a series.
- considering the effect to cfi and fineibt and introduce the 1st patch.

Changes since V1:
- add supporting for arm64
- split out arch relevant code
- refactor the commit log

Menglong Dong (4):
  x86/ibt: factor out cfi and fineibt offset
  add per-function metadata storage support
  x86: implement per-function metadata storage for x86
  arm64: implement per-function metadata storage for arm64

 arch/arm64/Kconfig              |  15 ++
 arch/arm64/Makefile             |  23 ++-
 arch/arm64/include/asm/ftrace.h |  34 +++++
 arch/arm64/kernel/ftrace.c      |  13 +-
 arch/x86/Kconfig                |  18 +++
 arch/x86/include/asm/cfi.h      |  13 +-
 arch/x86/include/asm/ftrace.h   |  54 ++++++++
 arch/x86/kernel/alternative.c   |  18 ++-
 arch/x86/net/bpf_jit_comp.c     |  22 +--
 include/linux/kfunc_md.h        |  25 ++++
 kernel/Makefile                 |   1 +
 kernel/trace/Makefile           |   1 +
 kernel/trace/kfunc_md.c         | 239 ++++++++++++++++++++++++++++++++
 13 files changed, 450 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/kfunc_md.h
 create mode 100644 kernel/trace/kfunc_md.c

-- 
2.39.5



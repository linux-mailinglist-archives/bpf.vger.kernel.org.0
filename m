Return-Path: <bpf+bounces-53016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13BE9A4B7FA
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 07:55:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 840FC3AC6B0
	for <lists+bpf@lfdr.de>; Mon,  3 Mar 2025 06:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50DC71E7C16;
	Mon,  3 Mar 2025 06:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RKD8z0Kt"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pj1-f68.google.com (mail-pj1-f68.google.com [209.85.216.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D231CAA4;
	Mon,  3 Mar 2025 06:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740984943; cv=none; b=AYoDa0giarHZ09N80GfUj8ebXt/0KZHekISapJQs1BLMpIh8HFwfy3STxhTzFoIon70RivPN5hflgSRjGNWqEID9G7ywk/tSLJV6/ngaAeSrNZlG+sEi/tpgPDGoKEuqQKGySvXFwyA6kVXGhh9gN/L0lO8ZpqvYCptvvv6yVRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740984943; c=relaxed/simple;
	bh=dG+GmQJ58+AjwIbzHzg+zHRT5V2GWAAOltkTkMVShO4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rC4px8pqVLWLqItEtasf3A9imUWfNTQknmrYcztobDDd/wkngVREGPiDaRgQKymaHkUKZh5jLm6kxMipXWi2hn6ukTGQio/cBmYRnw695Gy/028lJiiL8TD4U5SvbrQdCKQ5bwhqzWKMpIGZXLaZGnmASfc69adsyMeOoPHxwps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RKD8z0Kt; arc=none smtp.client-ip=209.85.216.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f68.google.com with SMTP id 98e67ed59e1d1-2fa8ada6662so8505663a91.1;
        Sun, 02 Mar 2025 22:55:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740984942; x=1741589742; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mRORuk1lZoTaQ72m0hDUrhIZjvt/8jV8y2hi7nR1rH4=;
        b=RKD8z0Ktm6Mxvgagou4iHrnS6X9Gxg+S1SPU5+OROiCsnLMQcbNcfQqCyBY5N1gRn2
         fi/xCDm86l+bI8SEaj8QWLjbXoCw1eLjiTSIzSV35dzrEGIjVuj3kf4hpdMJ3tZ1cxG+
         U7qu5GiCdQnQ/Ld8fGpJ6XiDEVheju9xDIGbo9zopiF/n8t7Hb5cGtWXKBgseqk6Lgq4
         1sXuR3fdZReyLC13gU3z5RCX3zoaRi6X7NqZeH0nD32b3YnMuItY/hZ7q0//z5Mee5wj
         DAIsQcdldkqm+qKDm6PYF7xhI+S5CW+a7OCHLa5wM7OEptbAtUCyituWsaWjG2XOVWuo
         CbxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740984942; x=1741589742;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mRORuk1lZoTaQ72m0hDUrhIZjvt/8jV8y2hi7nR1rH4=;
        b=suFwdiyNZA0JbWiEi0TXHf+IvW/ljHBkTfDJQ+2L4UlBrxDBNtc4IlHr+mpm8CIEXD
         WMGfuY15rS65JXe9FVzJeZgRO20UbSPtlX3qniEIg480H+c6Iuw2j4W/u39sShOcfvg8
         BHY+EJv5SUMKSkf9V+BT5XAl+TsSpazKZW2GokkmL8cUtY7PRN9aNgkTivyx3rsT3aTJ
         LfhHP4rVR7aKu+dhETTW7Z4TCP325Qvd3K3CZCYaOlv6Cpkgot85Yv78PLd2PawCJN+E
         OjgIzW9tJnpohjh1eTvoH/3R55zDuh8kkPxZNMCOfnvwmu++goupNbEKcJj784IaummP
         vSkA==
X-Forwarded-Encrypted: i=1; AJvYcCVaZ0LDfilroFGotxwUs0Pfwu23itUneKG16UXqhZBx+j22RlJpFBk50THHwJQgqs7FwKopujvCMg3KYSeJ@vger.kernel.org, AJvYcCVd2ZRLuKvEvWhuGEUpy4y40UgSxaCbXgbr/fZAIcNRlbHFnd5Oc8uEUkZiGF5DyHVIhc4=@vger.kernel.org, AJvYcCWLzJ+qic91j3VTUTKcT6wtq9IWpoqTX9o/dIQe2ua8o8yDpM1d1Pp4T/6wqVbYr4vI4GNlaBevdqk8bgaSj7IRvG55@vger.kernel.org, AJvYcCXI+S/wzQB6qwUw0SIhc1Z1+3L5tXeT/FUwz0yN0UeJzona5bR04qq/aXAYtSsdOfZ0QLBjZr/e@vger.kernel.org
X-Gm-Message-State: AOJu0YzY7fs14CO6IT6mBcyh++PE1n65c3BuzrmMew8tsIaJsMJUb/ne
	hEDghayiT+g3SxP0ZsrsGEt989NbuhW8X9KCj8PMiBn8buZJSbzs
X-Gm-Gg: ASbGncszGpdF4dJbPRVDq5RdSBzT473KXgm/jWG4RM85wuM9CXeD3ZqfBvQFLPJKEXi
	OLveof+iQj+zWaWe2/l17DtQ/MFsllqrs4agk1o/2PKwZa8+rGJA2qhblETps/08p4nMSDdO1ts
	NOKjs0v7rNC3NCDBTfEtJqJfgINvqON43jCy/fOLKBc7YF7F/dhOgHOIJHF5DdlbixsTWfxz+XO
	vmpebOanNRxb/HHToaiM0DlE3J296dJt9db+0kG8m316GM3mYAJQmmC75N19qugWDF91JBMcAYA
	XOFiM1eFI5MITkuS4qeAynOIPamRn7JRB8WXetAj2zHsep7yD6mhg6nLW00mZA==
X-Google-Smtp-Source: AGHT+IHkrQ6QYFMj0geZ0tfgbyR4QorZaQfQ/7JtrPSfKkhKbt8kMcBnshigR2/4fvzZe6e2RxKkcw==
X-Received: by 2002:a17:90b:3ec9:b0:2fa:17dd:6afa with SMTP id 98e67ed59e1d1-2febab78721mr21988807a91.17.1740984941579;
        Sun, 02 Mar 2025 22:55:41 -0800 (PST)
Received: from localhost.localdomain ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fea6769ad2sm8139575a91.11.2025.03.02.22.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 22:55:41 -0800 (PST)
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
Subject: [PATCH bpf-next v3 0/4] per-function storage support
Date: Mon,  3 Mar 2025 14:53:41 +0800
Message-Id: <20250303065345.229298-1-dongml2@chinatelecom.cn>
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
make fineibt works on the kernel function is 32-bytes aligned.

In the 2nd patch, we implement the per-function metadata storage by
storing the index of the metadata to the function padding space.

In the 3rd and 4th patch, we implement the per-function metadata storage
for x86 and arm64. And in the feature, we can support more arch.

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
 arch/x86/Kconfig                |  16 +++
 arch/x86/include/asm/cfi.h      |  12 +-
 arch/x86/include/asm/ftrace.h   |  54 ++++++++
 arch/x86/kernel/alternative.c   |  27 +++-
 arch/x86/net/bpf_jit_comp.c     |  22 +--
 include/linux/kfunc_md.h        |  25 ++++
 kernel/Makefile                 |   1 +
 kernel/trace/Makefile           |   1 +
 kernel/trace/kfunc_md.c         | 239 ++++++++++++++++++++++++++++++++
 13 files changed, 456 insertions(+), 26 deletions(-)
 create mode 100644 include/linux/kfunc_md.h
 create mode 100644 kernel/trace/kfunc_md.c

-- 
2.39.5



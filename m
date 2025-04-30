Return-Path: <bpf+bounces-57020-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 254A7AA3FD1
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 02:51:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7417E4A4061
	for <lists+bpf@lfdr.de>; Wed, 30 Apr 2025 00:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 627A44C8E;
	Wed, 30 Apr 2025 00:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="skysJ4Yf"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A8D6A41
	for <bpf@vger.kernel.org>; Wed, 30 Apr 2025 00:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745974299; cv=none; b=a32OHkHlNkJsICpP/38JJCcLvZeu6xLBswiZetkUgqWdb969VjQ/4+WhST/ZjOw1Yma0X8w1YqaL804XbFiy8vouyqOch/eatS0zMRdedzn3/Lh28KGVcjEPwv11tcoGmz6gpMZ8Kpp/b5U6B3rAYbOhL/6Nc7lvqTGpuos4NL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745974299; c=relaxed/simple;
	bh=DhNQFFfpN1iSLaLQX+VEMaKk7n2rygsYgfwzz2E0xvo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=f0ocylidRE6y0ibsp7qXmThZUs/ZiAJiPEydUGAljQM33OX8gPuTogFW+m++ai4yPR0luyPJ8YbVovk2DJwV3c1ujweSQTupT6PInf8lQlJt9+isJeRsRURnULS+sc2D+XGdTxcjFjc/+/qy73aDpbZJ/Jsz1jp2/8Ic5rurXrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=skysJ4Yf; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--yepeilin.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-7391d68617cso365691b3a.0
        for <bpf@vger.kernel.org>; Tue, 29 Apr 2025 17:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1745974297; x=1746579097; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aHnEwlLdwANwMc5RNNXk4BGzfuFS2i0ujkIzSPvzc6A=;
        b=skysJ4YfxlV/ntRLEGxi7RZVYpmalKlJhQUr/5APD35s0Ud5Vrewe8TzqnEz8v/eHj
         c7x2EkFrlvb7Vs1EFokuDCFJ7mewz4EMFacEEZrLUyQI+G86Alx97BORXBL+vtpu2xz9
         dcMRUp9K+gCOYDPShC4NmiNpuKOBJpZrk6rFnipYNAkIDTxgXzmoJBJKYX3U9jhbTxpf
         g3vm8ST3hOBSFlIHXK/CjQ+DHH+pxlL4OTJfEmZszQFK5JiIw0UisZ36sLF2Hc15+1d7
         Fp+nTj8utaQD6ZUkLQZ10jcGK/atLiY1VnTTynC7skbzwd7ZZOhSC83KK0f3+xcLMvRl
         lwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745974297; x=1746579097;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aHnEwlLdwANwMc5RNNXk4BGzfuFS2i0ujkIzSPvzc6A=;
        b=mdO+jMzKgIiWNmTFObX8CPEa5fsVP9aU8O0HLf5lSirjsIHD8zSRWegPN3ZMwLuWOW
         fyMIwG/q6matgS/huoXVmYBvLv3XrGgf+dgqTde9GC0dDhmTMjkhns4gXYQV+zvbYayP
         FdPIf5RQ9twC5xWNxZwCQa+aAIY3Sc45zHRX84ogHn/O9b1q8/Vgu/gZ+P/ODUkaCEjL
         9G4sN9gndUlhSB72xVcaCIf34757mmgArcbrm4XcBJLu2c25XNzH7HpRaoJuqwJLaXiw
         s650lH7sB6Pp0XQ3Q5DWUS2B6jm7bygTN7/F26RMKl627B7bODBduFAXRnyI8obZ517B
         INfA==
X-Gm-Message-State: AOJu0Yx1252YgDBVkvhJ+aRf/F/u1G2li8EPTLlUlEuI2kdguT1O/axF
	5qe37AlqRPn+TabAmBax9EOfIgFZNBUxJfn9FNNrWonUSRaUZptoPv8vnMgAqY7kAL4lWL3w7mY
	Uq1p34XR18l1KDF8z62WX8neS5Qt4KElk91XdIj6Hop5F55G1MbAKpZikT5B6AZtBlNzgD3RF7m
	PLaoHstd/fd6wiFx4RlySu8DFdKVWoVhd0DwniA/g=
X-Google-Smtp-Source: AGHT+IFBLQbfpmhOqzUmUk8dg9Ywwh7w/7lS8KAbii0xbxkFbfBJV9+bRpxlk1oIxeWy8ycFxabmhlLQMYZxJQ==
X-Received: from pfbgu22.prod.google.com ([2002:a05:6a00:4e56:b0:739:56be:f58c])
 (user=yepeilin job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:910c:b0:1fe:90c5:7cf4 with SMTP id adf61e73a8af0-20a90212e5amr1164249637.19.1745974296723;
 Tue, 29 Apr 2025 17:51:36 -0700 (PDT)
Date: Wed, 30 Apr 2025 00:51:32 +0000
In-Reply-To: <cover.1745970908.git.yepeilin@google.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1745970908.git.yepeilin@google.com>
X-Mailer: git-send-email 2.49.0.901.g37484f566f-goog
Message-ID: <755e831c84af2e7a4fc65fb52bc4724a6a7c2e53.1745970908.git.yepeilin@google.com>
Subject: [PATCH bpf-next 8/8] selftests/bpf: Enable non-arena
 load-acquire/store-release selftests for riscv64
From: Peilin Ye <yepeilin@google.com>
To: bpf@vger.kernel.org
Cc: Peilin Ye <yepeilin@google.com>, linux-riscv@lists.infradead.org, 
	Andrea Parri <parri.andrea@gmail.com>, 
	"=?UTF-8?q?Bj=C3=B6rn=20T=C3=B6pel?=" <bjorn@kernel.org>, Pu Lehui <pulehui@huawei.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>, 
	"Paul E. McKenney" <paulmck@kernel.org>, Song Liu <song@kernel.org>, 
	Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	KP Singh <kpsingh@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>, 
	Jiri Olsa <jolsa@kernel.org>, Luke Nelson <luke.r.nels@gmail.com>, Xi Wang <xi.wang@gmail.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Mykola Lysenko <mykolal@fb.com>, 
	Shuah Khan <shuah@kernel.org>, Josh Don <joshdon@google.com>, Barret Rhoden <brho@google.com>, 
	Neel Natu <neelnatu@google.com>, Benjamin Segall <bsegall@google.com>
Content-Type: text/plain; charset="UTF-8"

For riscv64, enable all BPF_{LOAD_ACQ,STORE_REL} selftests except the
arena_atomics/* ones (not guarded behind CAN_USE_LOAD_ACQ_STORE_REL),
since arena access is not yet supported.

Signed-off-by: Peilin Ye <yepeilin@google.com>
---
 tools/testing/selftests/bpf/progs/bpf_misc.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/bpf/progs/bpf_misc.h b/tools/testing/selftests/bpf/progs/bpf_misc.h
index 863df7c0fdd0..6e208e24ba3b 100644
--- a/tools/testing/selftests/bpf/progs/bpf_misc.h
+++ b/tools/testing/selftests/bpf/progs/bpf_misc.h
@@ -225,8 +225,9 @@
 #define CAN_USE_BPF_ST
 #endif
 
-#if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) && \
-	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86))
+#if __clang_major__ >= 18 && defined(ENABLE_ATOMICS_TESTS) &&		\
+	(defined(__TARGET_ARCH_arm64) || defined(__TARGET_ARCH_x86) ||	\
+	 (defined(__TARGET_ARCH_riscv) && __riscv_xlen == 64))
 #define CAN_USE_LOAD_ACQ_STORE_REL
 #endif
 
-- 
2.49.0.901.g37484f566f-goog



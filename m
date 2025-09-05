Return-Path: <bpf+bounces-67531-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F106B44D1D
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 07:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 54754580853
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 05:18:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E07C23BCE7;
	Fri,  5 Sep 2025 05:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="JmdFvnl1"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03ECA2AD00
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 05:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757049508; cv=none; b=ZMx+foMQ1futQAYnDdFp7N1bHCjBdAEBR6O8W0EjlUxlQGrA6uMc/Q1El/7KBtf1euqPZ2vdTdX9FFNeWfVVgfQJ8K4w5SiqZMFp5I6c2d82pZef/v81MGosaMae0oihf95yZDQ3CDPpjfyfX3oZ8+7Yk1yKZ7FJcPizRtZGqyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757049508; c=relaxed/simple;
	bh=ygTZIPfgCo6hNG+cPV9VDgeofT3k1nLuYT1YU2g1kQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n4OXsJcogdz/N/uurFuBLj1OSqF8nIj7oONlrd7X/ELkS+83RbdJOUyTAPEQDaqwCSqDXeuojtRP5Y5Cw1cPe6hTSnYYUpp/rhNEUf9YFzEhcC17NHCRTW56liop60QQafbrHKD6fP/0PnzADOcsNcIw6od/tWwTNpDU71BU6CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=JmdFvnl1; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3df15fdf0caso1378751f8f.0
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 22:18:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757049504; x=1757654304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KbidYaPpONskm2RHlehMffMFV6QihoSSM5d6KYCHNk0=;
        b=JmdFvnl16+cYHRk1Bvoh0HvzNM2zfOOjT7obNjzXDoIfAiDnWv21pItK5XT9P5lhXj
         YCELLl2FTc5s6uhDaofDLTw4GaBUiD2Bl2A0AlfY1yvbGBS40CLeHS9k60+aN4rYt03/
         umGtR/DVWLshNGN9HNjV/3PGdecfl0WrRDweRexz52ldM8teKFyxLDMV/twf3WWMF3Ly
         znQa21NpWij9uBchc1kVBI+1iuhcMBvbeq5UjFxWtaN5d2Yak7AMa3pSVPnRnU6W78NP
         mG23bazweJxSs4L1kE3R3j+qrRme+LwJ5uKTsKjBKhvvyW5hFfYPv2oDsIxRCBwV+4TT
         xHsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757049504; x=1757654304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KbidYaPpONskm2RHlehMffMFV6QihoSSM5d6KYCHNk0=;
        b=MtR3H6qShSTnniKWIVH53sZwcmndO5SfZwtvG99BPZ9FyN4xYLboEaZTVKTOJS2QQ7
         4NRlt7UH1f6x7hK6xH7qRiJKTKViBrJQWGNbDyaNEnlm/wmZbngJp3R0UzRvWmsyUwa4
         za1S4ZzzKqLNUxSZiulnyonAPBixsdzTW7GsAkq8ohwXcVl+8GsxIPNg0d+H3TuBbI4P
         S+kAVej8J2G5y4VDDIImwhnr68fbobUXKTAq0aiDJxubKiWghG9o+td5ZUw0+th3IJV+
         VHglDS66GBPD+0oWbrxlI5z6x4De/5i2mVVanoobqaMsb0FmiFpj+U2nWEB+QAH0SHlh
         T1cg==
X-Forwarded-Encrypted: i=1; AJvYcCWOMcAzVo/ktLatHQAhciHozf/1sqDbE4h6EhzvGXDG12ywyDi/pfcEdASlHDO1RJFZ3Es=@vger.kernel.org
X-Gm-Message-State: AOJu0YxYu5kN//R5He+ksR2W+RCwLsBgNiv5d7CHs3KJgo4Mf+aEU2pB
	4+b/Z7ruF2RCGJNATEeGrmkLTtZObJ9GU7rxWN2syiGlj/pNTjrAOTT+T/1RQ1rpE0k=
X-Gm-Gg: ASbGncupJur+dZ7Xnhcl979yUaJNE78vxxV0pEG3STF6ScM1pf5kdMGH1uPSBdwdxiC
	e65wU6CPb5vs1VBPj63ynzbpSm4ZdL9rmpvQX+Y7p55QjQ9mqheIn2/oU+TAuJf7ar5YE5zUBxe
	Yc5iKf+YZeqzTV/NxbGfCNKLn7dwLZpXF8oHSP69N0RkRGu2lsVA91+7kAvUCbYgzWVqRrGiu4V
	ddwM02l8XgfLvkVg4SRvaTJucj2lR8TO0hVFnHJHgNRVNxENF6QqvIpWaV7r3X62AItXxI5IioP
	0xxEIS/p9Hl8yGeq4pYZXTERBStwIXumuUUyYdtsM4/B973qJ4X/Cin2oYn1jPFNdnhnl91b2zc
	TUJiR+PsgUIzrSgh3s565pYG4LuEIycW24YhoQQ==
X-Google-Smtp-Source: AGHT+IFVJ7Ek9klNQOz86proipcWUUpbFNH1LIRA+A1sQqLYNggp1aEWZp2EFhKAmEv4xD4F+marag==
X-Received: by 2002:a5d:64c7:0:b0:3d0:ae58:e337 with SMTP id ffacd0b85a97d-3d1dcb76478mr17958366f8f.14.1757049504225;
        Thu, 04 Sep 2025 22:18:24 -0700 (PDT)
Received: from F5.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm27410154a91.26.2025.09.04.22.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 22:18:23 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: 
Cc: netdev@vger.kernel.org,
	Hoyeon Lee <hoyeon.lee@suse.com>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	bpf@vger.kernel.org (open list:BPF [LIBRARY] (libbpf)),
	linux-kernel@vger.kernel.org (open list),
	llvm@lists.linux.dev (open list:CLANG/LLVM BUILD SUPPORT:Keyword:\b(?i:clang|llvm)\b)
Subject: [RFC bpf-next v2 0/1] libbpf: add compile-time OOB warning to bpf_tail_call_static
Date: Fri,  5 Sep 2025 14:18:11 +0900
Message-ID: <20250905051814.291254-1-hoyeon.lee@suse.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This RFC adds a compile-time check to bpf_tail_call_static() to warn
when a constant slot(index) is >= map->max_entries. This uses a small
BPF_MAP_ENTRIES() macro together with Clang's diagnose_if attribute.

Clang front-end keeps the map type with a '(*max_entries)[N]' field,
so the expression

    sizeof(*(m)->max_entries) / sizeof(**(m)->max_entries)

is resolved to N entirely at compile time. This allows diagnose_if()
to emit a warning when a constant slot index is out of range.

Example:

    struct { /* BPF_MAP_TYPE_PROG_ARRAY = 3 */
        __uint(type, 3);             // int (*type)[3];
        __uint(max_entries, 100);    // int (*max_entries)[100];
        __type(key, __u32);          // typeof(__u32) *key;
        __type(value, __u32);        // typeof(__u32) *value;
    } progs SEC(".maps");

    bpf_tail_call_static(ctx, &progs, 111);

produces:

    bound.bpf.c:26:9: warning: bpf_tail_call: slot >= max_entries [-Wuser-defined-warnings]
       26 |         bpf_tail_call_static(ctx, &progs, 111);
          |         ^
    /usr/local/include/bpf/bpf_helpers.h:190:54: note: expanded from macro 'bpf_tail_call_static'
      190 |          __bpf_tail_call_warn(__slot >= BPF_MAP_ENTRIES(map));                  \
          |                                                             ^
    /usr/local/include/bpf/bpf_helpers.h:183:20: note: from 'diagnose_if' attribute on '__bpf_tail_call_warn':
      183 |     __attribute__((diagnose_if(oob, "bpf_tail_call: slot >= max_entries", "warning")));
          |                    ^           ~~~

Out-of-bounds tail call checkup is no-ops at runtime. Emitting a
compile-time warning can help developers detect mistakes earlier. The
check is currently limited to Clang (due to diagnose_if) and constant
indices, but should catch common errors.

---
Changes in V2:
- add function definition for __bpf_tail_call_warn for compile error

Hoyeon Lee (1):
  libbpf: add compile-time OOB warning to bpf_tail_call_static

 tools/lib/bpf/bpf_helpers.h | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

--
2.51.0


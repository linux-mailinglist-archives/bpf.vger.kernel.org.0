Return-Path: <bpf+bounces-67527-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA79B44BEB
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 04:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3F17A1BC2F26
	for <lists+bpf@lfdr.de>; Fri,  5 Sep 2025 02:55:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E73F226CFE;
	Fri,  5 Sep 2025 02:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="YqipehSF"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04027FBA1
	for <bpf@vger.kernel.org>; Fri,  5 Sep 2025 02:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757040874; cv=none; b=N3GbBC5xbEdefterOwSAOgZBltuS5ip6nEPpu+a9BhQ7VWPCuV1J1uQlax4NK6f5jJqLNO+qZAMYfdTsTtQ36Vf8ZBaedyD7DArRFCjMarjrkZiXNV0KCzrokMWR8gTCKx6mFWDiqBkATFsiy9rae08ZRn5ih/VO6m7trLFthT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757040874; c=relaxed/simple;
	bh=undCemkUqZF9gBus1X/Ltrp7nF3cY3rXTXb46EMVxBw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hWaNvEaCqfYURHdlqTZPxHEc6rYKnEpiqfUDWLf0hnfU2RCMaRcMkvsOg7JRLuW3F0V8MrcFYZxnffaFKuP1NPqSOfGUGIek6Ae+sph1TFSLqSuqQqs3LsxP93FzH1V14FD0d6cExFyNpY0e408schY4FSJqwbdWQCe18I6DFEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=YqipehSF; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-3e3aafe06a7so145694f8f.0
        for <bpf@vger.kernel.org>; Thu, 04 Sep 2025 19:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1757040870; x=1757645670; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CHgv0NAqDCmZyIrAUaPsVJq1dy+s9KkgFo573UQUBVs=;
        b=YqipehSFpj6XeradFN5rBMGGYV7W1mErq33XBFw8KtBxEsfeYThJ3cm1XBGpODmTcA
         Pd3plpOHym7pJcU3wIyrnEj6r9YDvgJBO6SF5W+R41Nd+9AKOtduwoyQgqpIv4fgyGYe
         3L4YPFixcXJ/3l+eqiqjFssSUnbvCzKIWN4eOj9zqKPAj3UDw+tgOT6mzjOtv08undh/
         R45LbrbsQkcAUZc/YuKCjsXop+2tgtyJPJ8zVTMUB63Y8qVLYyGbds86jkqU7s0WoST/
         EWiKggkVUOkRfeeCjzT9nlS+jV0doGBXl608j9OucvHRScvtTAFpAA0fOnJ6PpoxFPdc
         k9mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757040870; x=1757645670;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CHgv0NAqDCmZyIrAUaPsVJq1dy+s9KkgFo573UQUBVs=;
        b=ILs/ucvwdp3HEiTfP735M/lMyZuypTai0uGRhAN6CL3jAllCDLocs6lG09zlEnheHp
         Bi12SUMVbSzedeuiI2hkr7zARovUiQen7ci0163bsrTcKUtSCOR06QA3pTQi1r94Nkdq
         c6f6nyS9TLoleFAtSAJAFVWXKYL9Lr1QBcYMpQm8Q0h/xQZzBWQpLIJ142nmc5TQmsqT
         feuBSQku4pSeAclkzNAVQm8HO1ATCMOZwkeFJvHA6+GDFFPiuI0P7Gp+7wSrYgNX7QB+
         wAHFTJGl6MaZm9htliBO/gEbdJV+4dJa3TgQlIje+GqxIWin5Ajl1xeQrIwV8GGAxcpD
         4KmA==
X-Forwarded-Encrypted: i=1; AJvYcCWJXrGJ11nJPaOkxmH8fdj07+vo8d4LXRLAr/Tg9n7pKG3Gct+DxhM5oKZaq5VpgStrIBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCp01ndptOFOb66SVCXFCapN/WTbjEFVZO5v7+O/6B5XQtsM7/
	woHjQbOOg3ZK4ZSuMYWYfs9GXtaM1Bm/yokOL0SbfWkUGs8jBb3Jxz+3R9gSnuXdbzU=
X-Gm-Gg: ASbGncv4YTXVtOLoSphknKm/mh+GxLfCIfLCk0sn+Sa0K+oYQqXNm3e0F6HO2frQpzy
	hazjus+7DjAtFBSn8OYPAgHG5hSBGyph6bLZNkJixgmN4U31AwQIAdUkMxOUeoKVBPnIcHR6Cr6
	iXDcMXx+AWkTZiXce7L1G7MqXYBJ+4vtVtuDMANFuLicel2yr9/lYAGQMLtyhPQS22mzBSdMTUM
	hukyInvx7ZpGiT+Bqjyx9CaT4KzQxylR+QixdJJcoPc7UNzrg6J0J2E4gMr1maK/ilEhg/8nrBa
	RAL3M58hKh+seNJ1Mowzi7CJcDbSNOW/x43NDy7q03ZWcJPDcMI44SS0CukakABPL4HYsJSoFdp
	EYgIqGes5PxFkOKVz35GzM+yJqHg=
X-Google-Smtp-Source: AGHT+IHlQ5NtCWhhn706uFBkQkHtdTdgPPiLOwM5uLuiEP1poKNVs7I6ylodCTB9/wLUvkUlnXWfJg==
X-Received: by 2002:a05:6000:1887:b0:3e2:4a3e:d3cf with SMTP id ffacd0b85a97d-3e24a3ef8a9mr2789665f8f.5.1757040870188;
        Thu, 04 Sep 2025 19:54:30 -0700 (PDT)
Received: from F5.localdomain ([121.167.230.140])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b520b545a96sm457225a12.20.2025.09.04.19.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Sep 2025 19:54:29 -0700 (PDT)
From: Hoyeon Lee <hoyeon.lee@suse.com>
To: 
Cc: Hoyeon Lee <hoyeon.lee@suse.com>,
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
Subject: [RFC bpf-next 0/1] libbpf: add compile-time OOB warning to bpf_tail_call_static
Date: Fri,  5 Sep 2025 11:53:10 +0900
Message-ID: <20250905025314.245650-1-hoyeon.lee@suse.com>
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

Hoyeon Lee (1):
  libbpf: add compile-time OOB warning to bpf_tail_call_static

 tools/lib/bpf/bpf_helpers.h | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

--
2.51.0


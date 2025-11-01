Return-Path: <bpf+bounces-73219-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA20DC27468
	for <lists+bpf@lfdr.de>; Sat, 01 Nov 2025 01:40:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 111031897DEC
	for <lists+bpf@lfdr.de>; Sat,  1 Nov 2025 00:40:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44CB01E8320;
	Sat,  1 Nov 2025 00:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wk0j6nUg"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FC2A12FF69
	for <bpf@vger.kernel.org>; Sat,  1 Nov 2025 00:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761957618; cv=none; b=FoZexQZj3Oi/4nTJS9p9nzPhCOvwKOFrfZgD0ZxH+podEErG8ktTwDIOJBkM6Y8u+8dWn+NI+pc6W1IGXsAO1YMY5E5XGe6fr2i4zRqgTv+TkP80PRrxdJruwfuF0/Nqd0utClFuQNwbmn6YEnnPL7ERneImimECgpJjP+oYFx4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761957618; c=relaxed/simple;
	bh=tuc2PnOgm2YLtYMP0F778HnLiCMt6/prIBChUkCZOxs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=M3U1TUahPF7eq9X97IuPmN3eJUHHnutWAj9960F6cyRVTCE0FQAS5KMNl60semldBZbz1i7YGnkYyhlYefCggfN0sVSW0wICV2bVT22HxJgSpvL81PwbLwh7ffa9S/MD1u+lHBj5kgttnZftLkRuVQnbaMnexJYQ6XPByXWFyxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wk0j6nUg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2951a817541so21703785ad.2
        for <bpf@vger.kernel.org>; Fri, 31 Oct 2025 17:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761957616; x=1762562416; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rxAhY9/IIAMEF73p3JATHX00MjQhbGwW2XNufnHv32I=;
        b=Wk0j6nUgCxTg6LX6AgZIVK6aPZKfFH3RRqaP4o7pjTQaeleV0KaDwgxmTg5nRI+vBa
         0yN6NOjld2lBZSlN/hRpHSzYknaR9M6Ab6X185kXag5v/FV4kgDtpSp28j1CzEXwFmbn
         IGP2jmrbZekhyuQh5B9UFG0cJGgfM9gLKBYBAARRUKOb3nqNqG2P1A1oUupwagN+iRqM
         Q5DolwzJ+jTZcncxGENPkfu1EbxZFzBx2aQZaNZKaz5P74ZkYsCZevzm4bMNCXXfSUEE
         6iGFaBohcqEAZyTpqDaUAgowtYSAZbAeLmW2OOZrgClHPzgrMtihiTxXmBmuxCMufjQ7
         9Eqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761957616; x=1762562416;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rxAhY9/IIAMEF73p3JATHX00MjQhbGwW2XNufnHv32I=;
        b=pKzj4ykfhOwpEK99M4G0epgSbLbkd2BAy/sU7yz+8zt+gL1r8RJTgVEHICV1rW6Ccp
         p0HmDLBrFtbwBa1ffy1nUWsb7hJ4Y4qxHw9ARUto3UqUu15CvCVOiEQEHlzN0emXO1Fu
         FolbywaDi0IWgcGWcLYV942F3iE1LKFUluEms9ZgEi3FIS5FZ3R2BHg6OYJabEVl1vq4
         FxdKRbm0PQLIUQu2hrJjeNTweHZviT0CNHvX3m0Fpjip7p18Wx32qqftv68qr//r2FBp
         16R1WyLKmyjudy0aF+YPR1+H1B9DPDfZbXp0STK1qjfCExGYQX6OjwLXQS6pPlZSxITQ
         HuMA==
X-Gm-Message-State: AOJu0YwvugzgV757ZMpluBhP1fg8c8/7j0r7a2icMiGfhr50bD6PL4su
	WVQ8Q3ZMr3tC91y+J1cckiaI9XzVMnZ/i1Eo/oqmZN+EaZtmzwpFXlKY
X-Gm-Gg: ASbGncv9fbVqjkOLsMu+Nere9sltT33Wc1ZrSd+4O7NSE8vcMT0hAyny7E7+pBKVjKG
	NNBCqlkS+ImAPMsHm9/oFcKuh0upEVT8ITGCFUbsdER+b/NpbmQuDpSEkAcPucmHl5h85qoSCQM
	Wn6YlOTS5HZBkW9XAXnAr4Ba1sulAkizHXmWH1Bn9/F/SXLt/9a/o8eH6w/MxXk07rpBxaLsSx+
	l08ElOKq86NOmQygdH/HzI4T1y+heUSAJ0wh2JRxarU1SauSgTZVz79ebn0aXXb1ivchGMVZO/I
	KoHpFongqb48NnS2a3pufr1FBMEhGjOdrxVKm19KRkFVYa2i31ka7vvELFhPd7YpJBVPSXa9yy5
	rV3flvQOJ3/dKX6EyLnuMzwWGopO2TOyCsPm5nx3VtEOr5xYsurLTEx7qm8KTQgs2pz5n+th+z5
	gE9lwpY+rYro3++nb2qqiy8/gMyhhWc/CvjV3WB6JFAwHVbznEzecqxGg=
X-Google-Smtp-Source: AGHT+IGrj3rkGEwIY/3Jue1qaIC+OTXN9UH+Hknmqu5JftvblOnriXPAMUHzDsmHBeTnreT1xoDKrw==
X-Received: by 2002:a17:903:1206:b0:295:f1f:67b with SMTP id d9443c01a7336-2951a4fb05bmr65959985ad.39.1761957616567;
        Fri, 31 Oct 2025 17:40:16 -0700 (PDT)
Received: from localhost.localdomain ([2601:600:8380:1880:1886:6b2d:3a96:43e0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29526871b31sm37776095ad.8.2025.10.31.17.40.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 31 Oct 2025 17:40:16 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: torvalds@linux-foundation.org
Cc: bpf@vger.kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@kernel.org
Subject: [GIT PULL] BPF fixes for 6.18-rc4
Date: Fri, 31 Oct 2025 17:40:14 -0700
Message-ID: <20251101004014.80682-1-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 6548d364a3e850326831799d7e3ea2d7bb97ba08:

  Merge tag 'cgroup-for-6.18-rc2-fixes' of git://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup (2025-10-20 09:41:27 -1000)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git tags/bpf-fixes

for you to fetch changes up to be708ed300e1ebd32978b4092b909f0d9be0958f:

  bpf/arm64: Fix BPF_ST into arena memory (2025-10-31 11:20:53 -0700)

----------------------------------------------------------------
- Mark migrate_disable/enable() as always_inline to avoid issues with
  partial inlining (Yonghong Song)

- Fix powerpc stack register definition in libbpf bpf_tracing.h
  (Andrii Nakryiko)

- Reject negative head_room in __bpf_skb_change_head
  (Daniel Borkmann)

- Conditionally include dynptr copy kfuncs (Malin Jonsson)

- Sync pending IRQ work before freeing BPF ring buffer (Noorain Eqbal)

- Do not audit capability check in x86 do_jit() (Ondrej Mosnacek)

- Fix arm64 JIT of BPF_ST insn when it writes into arena memory
  (Puranjay Mohan)

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
----------------------------------------------------------------
Andrii Nakryiko (1):
      libbpf: Fix powerpc's stack register definition in bpf_tracing.h

Daniel Borkmann (1):
      bpf: Reject negative head_room in __bpf_skb_change_head

Malin Jonsson (1):
      bpf: Conditionally include dynptr copy kfuncs

Noorain Eqbal (1):
      bpf: Sync pending IRQ work before freeing ring buffer

Ondrej Mosnacek (1):
      bpf: Do not audit capability check in do_jit()

Puranjay Mohan (1):
      bpf/arm64: Fix BPF_ST into arena memory

Yonghong Song (1):
      bpf: Make migrate_disable always inline to avoid partial inlining

 arch/arm64/net/bpf_jit_comp.c | 5 +++--
 arch/x86/net/bpf_jit_comp.c   | 2 +-
 include/linux/sched.h         | 4 ++--
 kernel/bpf/helpers.c          | 2 ++
 kernel/bpf/ringbuf.c          | 2 ++
 net/core/filter.c             | 3 ++-
 tools/lib/bpf/bpf_tracing.h   | 2 +-
 7 files changed, 13 insertions(+), 7 deletions(-)


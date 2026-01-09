Return-Path: <bpf+bounces-78280-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BDF6D07CFA
	for <lists+bpf@lfdr.de>; Fri, 09 Jan 2026 09:28:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 53A2F3088080
	for <lists+bpf@lfdr.de>; Fri,  9 Jan 2026 08:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D90E133F386;
	Fri,  9 Jan 2026 08:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZokcZyoS"
X-Original-To: bpf@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2648833DEE5
	for <bpf@vger.kernel.org>; Fri,  9 Jan 2026 08:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947210; cv=none; b=gYY63uae5ApQcd9WRI68wqaesWWz70NpbCxfY5D2+CKA/i3yuVhnNUknhtKsjfNFVIOT1tAhMplrx8fs0e+c7S3xMlDNfwFf7flmrBA3mr8UC9xXg1GdFivXddyCZEIIRfdeiBTeTRLh9QeY96cmd6wcS7loVVNEt446qY032NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947210; c=relaxed/simple;
	bh=FjGEX8FjB7Dtv53DDGRI3kqS1oxMhyw9A893gULk8FU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aWcLyBwqZ8XWbIgLcwCbdA4Vcd3P2c4f0FD20fnhGPuq5UiBrxKCwgVeF3CSZhaAxqy4JzV3x59OJsjvMS5WIs0wq0CQw9UXjQ9tdTLkf3VqB6Yo+LLqIjmm54QVAwzrJoSr6AIZJvaAtH6jro1S9Uzd7f3ZSzM2LFcO5l9kCUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZokcZyoS; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2a0ac29fca1so29760495ad.2
        for <bpf@vger.kernel.org>; Fri, 09 Jan 2026 00:26:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767947205; x=1768552005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=76Kje5cI+iX8JvF8gU7mx+is++1lcR8C7sFvX3Upr/8=;
        b=ZokcZyoSOtgKmmFXR36PO8n8DW6OTG+b7AMGMUDXika93drkVt9i0aamLroo2uA2ZQ
         HfVC7RYk7/CZZjLLUgqpF+pJ3ys6zENYsUavoWqyhln7S96uAU+vECZezIQUi+GMj723
         o4Ymx4IRfdzp4UOwILOwYFfIypKdzYgyu4hxSLCl+YyZqJigYzE+AcNlAklB+iHAIh9F
         pEgByb7O8ORnzp/rQNVUSzBrV84XglBmi8iKHIYY3TH5jNbZPhMarcDuHABD3MWkqe/d
         T9DDwF9L/CEHozA0lVptDuyqp/vcu7lzpXAYBqg3i24JU3IIc4dn0lJ1tbFH/lZ/eA9K
         F+aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767947205; x=1768552005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=76Kje5cI+iX8JvF8gU7mx+is++1lcR8C7sFvX3Upr/8=;
        b=GXyMcfQZf0sD6p1hepF2HgVoBMD9V+9XoxIMZ4BKYG0thTdKdNT8HCVLBsQ88Oh9fk
         xDnwcez6TaZOW1B+Lb2L889oxptol14hpWoygy6GkONC7WD+bo/+IHBbROpwUG+rkltr
         lBpGYh+MY3TJRdUAbdKRKWYd/XWGMWyryzJfNVhmuRA9ZN8DQOS/2YKN9Z118DzYG+Nf
         iX27sAAMS6q9kekgKPYmAg6Xu4DLAuvLw5A/zIKlFqmx8Ee5NBADG5lCWaHjbgiQtNvV
         nKOdx6D71G/CEWsOLdhKZvbT3XnF42kncoDSrk0AtkvLP2kzhA+RV2lqT0h5CxL/RVm2
         Vtkg==
X-Forwarded-Encrypted: i=1; AJvYcCVOAvTDWR4j04QifzWNrtLJmcyMCpHuud57RjZdMf0KWHLjUQSiBIqOyk9OK2tCNuvWn44=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5CTD0o5PnscNrzAmwvEV2ANahmy369sBs6wHzCQe5lLyK/QmW
	wPbHZSBibpj/K5QDe5SGVV0ick/MnJ2NYZKHLcLW8PhqewO6xpe83/y/
X-Gm-Gg: AY/fxX7h7mQwQ+x3GB9ObfIKvzJstHsC0HqF4bbonJYlUeVw1OaEeNDoAWsz8CWfdmc
	Pu1sFj5F0YtusAYf1XdtdJC/nXUvQRo+blB/hr08reqPnjis8VmW01P1APCPnIeOw2vl0PV41Zm
	KaSfcLjG0SVnn73aJD+jk3vy7AWBJGklLt7ZK+1rtltMTTfR+FHB17aUGzkEB4fbODC101wBsdN
	AkIfK5/uMop0JNGyXxWz3HWJUq1Cd1fmp0TiVsDl98mW4NFZboLJ9a7Rhb3AL8bk2FgiNXAYDuN
	gBNghGtgjGG+p7HsZi5IRnRa22IVFOUDRaCBZzg4y6pP5ImgJa54KR9Mz/E2B0fMuGgdsXlHp7m
	o6GAvtc3yKjL9A9jwgUQeqDG6alvRr5N8McrRtE2hS5kl9MtiXGr+c45CV4EbrzbdxeqMh7Mo5E
	bv9uMQMBU=
X-Google-Smtp-Source: AGHT+IF2BgWzhKzhcpbfAopQAlREHEs1z5PoCyC0jd+zT4zLoJ3RGoztt+nOZwAHnTL9nX9zSdNZ9A==
X-Received: by 2002:a17:903:1745:b0:2a1:4c31:333 with SMTP id d9443c01a7336-2a3ee445ae3mr86760755ad.19.1767947205248;
        Fri, 09 Jan 2026 00:26:45 -0800 (PST)
Received: from 7940hx ([160.187.0.149])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3e3cc7912sm100104695ad.67.2026.01.09.00.26.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 00:26:44 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: ast@kernel.org,
	eddyz87@gmail.com
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next v3 0/3] bpf, x86: inline bpf_get_current_task() for x86_64
Date: Fri,  9 Jan 2026 16:26:28 +0800
Message-ID: <20260109082631.246647-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Inline bpf_get_current_task() and bpf_get_current_task_btf() for x86_64
to obtain better performance, and add the testcase for it.

Changes since v2:
* implement it in the verifier with BPF_MOV64_PERCPU_REG() instead of in
  x86_64 JIT (Alexei).

Changes since v1:
* add the testcase
* remove the usage of const_current_task

Menglong Dong (3):
  bpf, x86: inline bpf_get_current_task() for x86_64
  selftests/bpf: add TEST_TAG_KCONFIG_CHECK to test_loader
  selftests/bpf: test the jited inline of bpf_get_current_task

 kernel/bpf/verifier.c                         | 25 ++++++++++
 .../selftests/bpf/prog_tests/verifier.c       |  2 +
 tools/testing/selftests/bpf/progs/bpf_misc.h  |  3 ++
 .../selftests/bpf/progs/verifier_jit_inline.c | 36 +++++++++++++++
 tools/testing/selftests/bpf/test_loader.c     | 46 ++++++++++++++++++-
 5 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_jit_inline.c

-- 
2.52.0



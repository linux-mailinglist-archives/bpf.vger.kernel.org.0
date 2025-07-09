Return-Path: <bpf+bounces-62738-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C0AAFDD2B
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 03:57:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0E433BD43E
	for <lists+bpf@lfdr.de>; Wed,  9 Jul 2025 01:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C66319ADBA;
	Wed,  9 Jul 2025 01:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="fQUzzPdI"
X-Original-To: bpf@vger.kernel.org
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A4F19067C
	for <bpf@vger.kernel.org>; Wed,  9 Jul 2025 01:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752026241; cv=none; b=HjxSdQuf7GULjRpp9Q3LyhRLufao1+8D8Yw4i3ozHsTnXDnYmftHiNzb4VsrAHCRvl4NkIpt4SvR7z1F0i+hO+Ivbmuqo4TkzHLr3/BpTksOxVtOLNAi2/MQtMjxXxaYjnQBLhPyYmHlPxcLqkF/Et++xUAoE8R71oGfFEYDQmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752026241; c=relaxed/simple;
	bh=v6YGprjLpgEPK1ca6Qf1O4d4ENwQi9uROnVxpV7lL7E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VLxciexX5kg4a6D4ql0nE/+hL6CH3SP/UbfJWcjt9/i2xXEXOCoapdrYb9rxUZDrQpg+5sFB7/H+I7T7UqK92m5012qiI2veiMDb93ttZoBhw8prA8eeBAdDVYovz2rRY2GJ+ZKwKukCIk4N2D4ouE53R+/KPxm2ZRRot6++bBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=fQUzzPdI; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-4a44b0ed780so56042361cf.3
        for <bpf@vger.kernel.org>; Tue, 08 Jul 2025 18:57:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1752026236; x=1752631036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RAf9y/2ON439rFHtFFKS4ip/woPJoz3egvRo8xVeAjU=;
        b=fQUzzPdIGJJwuEIuXr0Dj6YSLeFSfmszcgPOMNTeCupI3BsQXEGhXKdVW9Hx3VO9g+
         KvYm7HwTSYFgCSJMkxrS8qhJ+I9rNhIl6J6tw7+0cG8IvCsUYChp2daCBC2+8Lt7Fj0O
         0PcLClLBdUGJU1AItNY+TXWpcnFXnSVT10ZIPkLty6N5RHKSlvVyJYirNq9ug1W0oUq1
         KnIaOV7fhv7ypYHLv5WpIcnbR4f8cOgMLgttsOzlSrac+vYABwcRHIIGTCl6ZxzgDENx
         zQDYzhcn9NOrwsorSiBqRkVyEVlmKHnW9eqfuVpHRt4bhsgWwXOdwRKvNHwvYfSX47op
         oHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752026236; x=1752631036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RAf9y/2ON439rFHtFFKS4ip/woPJoz3egvRo8xVeAjU=;
        b=TqOkVC8avIkYVRRMK2y8o0ltEOakTmNv02VKoNCcyctMNc0rYp9GzRJa7TJlhBvqq9
         ZSpgXHRck6MI5ThF5RUWOTQ83twIj8ROUeU9t0eXLArJUwwkgFURv7gGyXyKOv7rEsvR
         7dFvhMqMct3qER9tO275u/pwT2RYuvphmCY4jTtaEB2Qha3AS8HFZrWL+JHFBLuwmsQX
         LW3mYV5Hl87i/kL4+J7SyWGXESjQZIQQenTr/SUngrfd7CF2YlDYL3tMdCtWbpgpCTNt
         cZ2n8c3XUsKIWGqbocd4Eclcp9z3fCIoESK9Cu/Lqd115LAvw6uEaUrUvGhgMVW2z/ZB
         DeQg==
X-Gm-Message-State: AOJu0Yzl6Tc4jzydZsSht84x3Q0IQnDALc4djRViAVBRtjh5Kegxq9Zn
	NqQdHBw66onDkXAbSWX8HAmFp2IhVGhNebPGrgfoSh2R4Bx3oD46yUQAPwYLg/3WmtiTkn2Nagj
	3fV36LOk=
X-Gm-Gg: ASbGncvljZ+HNzaXO6Ku3dW60gQNGzXv75wGnspUDWOkeq1EFOMMu/QsYU/DY3/V7bj
	7hUE63ZYkaRqAwCBma0pPmxMVtU28zEWjQEzCMFw1vPJeiLvZDB68tl0+FlWMJP/bo8K9L0nP3G
	lt+gBGZEL4qGtECj7DYdg3EUhLq8InjSCXwWc7VLQck02OrWFj0jPdP0RIoERqKzHIDfyRZfiqZ
	34qlgOMUDxVtiYWpfJwJxwBnsgg45nIyRxN5ql9uJNnEev2bwLhSoc8v8zbCy0IXQS/nVmRpYet
	Z3MiNs51zQEp/MUaXX+hB+9Tx0BTUEBW5gqNzk8Tmt+3Be8e0xJJBG0fwtQ=
X-Google-Smtp-Source: AGHT+IE3FXevPW3/4SYNoSFn5j961GQQ1Rkp1gFI+KnlydMWrcwwIVZOqkkszOGEDIzrlhPtj2qiwg==
X-Received: by 2002:a05:622a:1493:b0:4a9:d98b:791a with SMTP id d75a77b69052e-4a9decedf60mr10659401cf.29.1752026236273;
        Tue, 08 Jul 2025 18:57:16 -0700 (PDT)
Received: from boreas.. ([140.174.215.70])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-4a994a79106sm92041421cf.45.2025.07.08.18.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Jul 2025 18:57:16 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: bpf@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	memxor@gmail.com,
	yonghong.song@linux.dev,
	sched-ext@meta.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v3 0/2] bpf/arena: Add kfunc for reserving arena memory
Date: Tue,  8 Jul 2025 21:57:10 -0400
Message-ID: <20250709015712.97099-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Resending the v3 because the email chain got mangled the first time
around, sorry for the noise)

Add a new kfunc for BPF arenas that reserves a region of the mapping
to prevent it from being mapped. These regions serve as guards against
out-of-bounds accesses and are useful for debugging arena-related code.

CHANGELOG
=========

>From v2 (20250702003351.197234-1-emil@etsalapatis.com)
------------------------------------------------------

- Removed -EALREADY and replaced with -EINVAL to bring error handling in
  line with the rest of the BPF code (Alexei).

>From v1 (20250620031118.245601-1-emil@etsalapatis.com)
------------------------------------------------------

- Removed the additional guard range tree. Adjusted tests accordingly. 
  Reserved regions now behave like allocated regions, and can be 
  unreserved using bpf_arena_free_pages(). They can also be allocated 
  from userspace through minor faults. It is up to the user to prevent 
  erroneous frees and/or use the BPF_F_SEGV_ON_FAULT flag to catch 
  stray userspace accesses (Alexei).
- Changed terminology from guard pages to reserved pages (Alexei,
  Kartikeya).

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (2):
  bpf/arena: add bpf_arena_reserve_pages kfunc
  selftests/bpf: add selftests for bpf_arena_reserve_pages

 kernel/bpf/arena.c                            |  43 +++++++
 .../testing/selftests/bpf/bpf_arena_common.h  |   3 +
 .../selftests/bpf/progs/verifier_arena.c      | 106 ++++++++++++++++++
 .../bpf/progs/verifier_arena_large.c          |  95 ++++++++++++++++
 4 files changed, 247 insertions(+)

-- 
2.49.0



Return-Path: <bpf+bounces-53861-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9BBA5D210
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 22:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0B691897C75
	for <lists+bpf@lfdr.de>; Tue, 11 Mar 2025 21:54:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A940264F83;
	Tue, 11 Mar 2025 21:54:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L51c2ciy"
X-Original-To: bpf@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 419EF264633
	for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741730068; cv=none; b=ty0x3KiBdXBdD0znYjynFAjwsnASbOR2f9B0BggWZ7nWYQnuiqClXgLCWxb3V846F01LpbeBrz7lRpgt+G2Gi1WbAhZ9sSzQYhAK1BWOfMdRnV7NWv8NgoChqXwjwJx05t34zEL5itxZFSeBYU12qsVQ2zEcEZs1AwKnVNgy9wI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741730068; c=relaxed/simple;
	bh=uEFFfGdRXos7JwsYfR5YujDKm70t3czLszZ4c85BDsc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ozEwJ/itt40yA7ETF5/EvojLmpIJ0TOgfYKxfX0/Q5M+9ln9bpZHU6meYMogE6zBaizElEAHMQgTh7Jw2g2U6/crvmjGxt2n/cEwnTmrTJKZQUKjqd3Wr71Xqr8LHyPlezXMSM2tF0aqMP/++6DGpbxPHLhwbpcCFKedIPW+lCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L51c2ciy; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-43cfba466b2so29079955e9.3
        for <bpf@vger.kernel.org>; Tue, 11 Mar 2025 14:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741730064; x=1742334864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OekS8ZnTqLZ56J5nF62yHDvXZINOTNK65VxH4hI/40o=;
        b=L51c2ciyA+M77nrKkXZm0Tjw54g8V3SUKzdrnbbTcyyPCvJknld6e+P2WtYmbrYeUp
         fiKm1SI4ml5PQRoL24nsHODgVqqesrDFIFnu7cmZh+ek3aV3eELgTcKIz/0L56fw2iEr
         Ze7PPW28QPmg3zSZeDRSgbc5B2PE0t8cTpCfyqtDLWfYGA12dCXGnDY9DX1Nv9qTSRD0
         spQzrw9q4Y2w2gMMY9n1xU7+ysLWGsOEwiPtAmm+Ek5DjpBfY65O5rO0RK+fWxykc55H
         YGqbbgBolcXP/w+zvkV1ypjvKUufBzMNo3i+MgyCs98NZKepqmGCS4Varr8SAMjioan+
         KbiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741730064; x=1742334864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OekS8ZnTqLZ56J5nF62yHDvXZINOTNK65VxH4hI/40o=;
        b=UZKqcWXvr845a6Ax4k6LcKXOt4i/IAYIvrPbDlYUj/JFWxzLVAEgRFV+i+VlJgoDa+
         qShjIssB38Fxjge5VEeYJQlfJZeaRJ3/WkyH56LovDyxqQAVhxAqvLt45rzhXaV+qhuv
         2za4fDsZfXQGowiuB1p8nXsLZiaEpczL19oHbiCT7YyRGs1ph6VQqaaugRjyORbSPT/V
         rteYXAU8AewJ2vEK91bGao6itL/LTg1Fuyp3gi9e8i1AAKioivGXTXNoZBnTHv7lZukP
         uv2VINZS5Fdk3fQlHjWy9369U0uEC6YCk5GaKrQny9qCyeRRUEJC2ZLcTUzvqwbg8o8b
         nkww==
X-Gm-Message-State: AOJu0YwY3GYybkSLyeTRod3JAHU7FlWtRBt9QYZ50EjuGmh+SOOmzlfG
	KGPgPTaAzqZN30FC45xcf+Sg7QkyEC5K37frGskr6j8+Rd2y9KQb8fFG6A==
X-Gm-Gg: ASbGncuj/mWkhBUAi3vfr1maVday7AvvQxgB5uh4JJglNw0+1bX6SEDdJbBcIZv0ldS
	ZBTya+nGQb+wMtRUTIFjJocXnEqb0lVLrnzuBp9GGxKRJqrWCT3cgaRoXiCPBQKvB66QYjVxDLy
	bi2R79PQ1h513gKgbxgy0MrTkHjDEiYvZbnA7F8048LGp5EeZXI/i07RRouCQifj8+jOFI+zyYv
	HTjPC5gHyUaXRUCkupkIcDHrkEzck/onw/8tMNhQvj8NqY3B9SR1EdWJHZxa9O2g5qxltjJ3jGx
	d5QgrRMzsM7uFYADsCS7zzJSafgQtp+Jg+BuvQLfT6EdCbZbRMuzm0RUC+ToFwqTYoUlknXxRdY
	ceQGPK4QhSuoQ+rYkPdTxeml02h2kuqRyy7QOdrPP96OkGwk4Y9TlaZv67FD+
X-Google-Smtp-Source: AGHT+IEb4pmYOIzujyc4SziL+iS8fnBX3GAhpibi1hoOQ53MgAtrnr7lnkVEuAYxyyoDalgUnwhSUQ==
X-Received: by 2002:a05:600c:3b92:b0:43d:45a:8fc1 with SMTP id 5b1f17b1804b1-43d045a9163mr55018835e9.4.1741730064013;
        Tue, 11 Mar 2025 14:54:24 -0700 (PDT)
Received: from localhost.localdomain (cpc158789-hari22-2-0-cust468.20-2.cable.virginm.net. [86.26.115.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3912c01cd62sm18815549f8f.46.2025.03.11.14.54.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Mar 2025 14:54:23 -0700 (PDT)
From: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	andrii@kernel.org,
	daniel@iogearbox.net,
	kafai@meta.com,
	kernel-team@meta.com,
	eddyz87@gmail.com,
	olsajiri@gmail.com,
	yonghong.song@linux.dev
Cc: Mykyta Yatsenko <yatsenko@meta.com>
Subject: [PATCH bpf-next v5 0/4] Support freplace prog from user namespace
Date: Tue, 11 Mar 2025 21:54:16 +0000
Message-ID: <20250311215420.456512-1-mykyta.yatsenko5@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mykyta Yatsenko <yatsenko@meta.com>

Freplace programs can't be loaded from user namespace, as
bpf_program__set_attach_target() requires searching for target prog BTF,
which is locked under CAP_SYS_ADMIN.
This patch set enables this use case by:
1. Relaxing capable check in bpf's BPF_BTF_GET_FD_BY_ID, check for CAP_BPF
instead of CAP_SYS_ADMIN, support BPF token in attr argument.
2. Pass BPF token around libbpf from bpf_program__set_attach_target() to
bpf syscall where capable check is.
3. Validate positive/negative scenarios in selftests

This patch set is enabled by the recent libbpf change[1], that
introduced bpf_object__prepare() API. Calling bpf_object__prepare() for
freplace program before bpf_program__set_attach_target() initializes BPF
token, which is then passed to bpf syscall by libbpf.

[1] https://lore.kernel.org/all/20250303135752.158343-1-mykyta.yatsenko5@gmail.com/

Mykyta Yatsenko (4):
  bpf: BPF token support for BPF_BTF_GET_FD_BY_ID
  bpf: return prog btf_id without capable check
  libbpf: pass BPF token from find_prog_btf_id to BPF_BTF_GET_FD_BY_ID
  selftests/bpf: test freplace from user namespace

 include/uapi/linux/bpf.h                      |  1 +
 kernel/bpf/syscall.c                          | 24 ++++-
 tools/include/uapi/linux/bpf.h                |  1 +
 tools/lib/bpf/bpf.c                           |  3 +-
 tools/lib/bpf/bpf.h                           |  3 +-
 tools/lib/bpf/btf.c                           | 15 ++-
 tools/lib/bpf/libbpf.c                        | 10 +-
 tools/lib/bpf/libbpf_internal.h               |  1 +
 .../bpf/prog_tests/libbpf_get_fd_by_id_opts.c |  3 +-
 .../testing/selftests/bpf/prog_tests/token.c  | 97 ++++++++++++++++++-
 .../selftests/bpf/progs/priv_freplace_prog.c  | 13 +++
 tools/testing/selftests/bpf/progs/priv_prog.c |  6 +-
 12 files changed, 158 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/priv_freplace_prog.c

-- 
2.48.1



Return-Path: <bpf+bounces-54218-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FC74A65B1B
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 141F37A8993
	for <lists+bpf@lfdr.de>; Mon, 17 Mar 2025 17:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B973D1B0437;
	Mon, 17 Mar 2025 17:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoSEchIQ"
X-Original-To: bpf@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 863D91AE01C
	for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 17:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742233248; cv=none; b=K/Lymnb1HTHGMu8VOxiyd5jIlp3rgyHhkB3AR5QTtOBCDhr6eUsmzZioFl0DpdiYpGOMWpFEkpESf4BgrDxssztzkOOp6/sdEC7QebbhjsEqfIR6ML03lzZb6ruoayhnHUXgFixvZhET12vypcLGYl0ZEQh+BoCmPU/rZKxtWKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742233248; c=relaxed/simple;
	bh=DnUrEt4EiTewj01uENsu2T2ENt5BpgFI37Rwsc0dy+8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oRFazr9hcVoserupz2snRzMiK1UFQKruGoBlFJVSa6jx6MSVTAPaXKSx/aa8QrN3hsQlwUpGoVZqEeL4L3zS9EpqyMNtmggmbVyJmCTIYcTmiXIEFh68/xGuxUCqIODDo3XFltc/1DjlF6A8UUYE/AMPojvIbVcwiModMbVnDDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoSEchIQ; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5e60cfef9cfso6645288a12.2
        for <bpf@vger.kernel.org>; Mon, 17 Mar 2025 10:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742233245; x=1742838045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Bx4oEYH/kEo434AWEglfIQgYk1Dv8X9JnwQYpwdydWs=;
        b=RoSEchIQI6vanY2+NOP0blDNK2kAxEx5oSnNk+mTdIr4EYTA3FoKpLYUwFpfETuIBI
         AODnbriEOgq+DXca/htJXXhZZbCrvAH30keeHBEUjJHm7Vq2K7c5evI6OFp2DLgCjHzX
         yWN4SJJfhsHAgNrurYSn9wUvkvMQy1i7H1EZEkjfw8TQq/0D5INeIRwQTieVdfI8zJo7
         J7QBXM7pLD1As/MvGcxxHO6ZrIwEvCR1272L4gqrlq3fwnTmENawHeFWJVs6PRzOM0X/
         5Mb24MFOmniMyu33HjHFhQQWJ3d8eefZjjqZWIbs69gXMP4AgS99D0sO1y3uBEZ8qQRg
         wBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742233245; x=1742838045;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bx4oEYH/kEo434AWEglfIQgYk1Dv8X9JnwQYpwdydWs=;
        b=etLWDMbM7lbBKE4V6EhOJ/YQZBdcfYxJtS7ZOfpTQjrxyS3WgE2AoCUT6ckJUoAtqj
         f6aVL0vBjrAe10HFvGPXP6iYQ8l1zczyV4siBBQR5dIh/cFL7eHDaYvE2VDo1xV4zx2N
         EkOU+NoZOjShyhhrc2539dY8EYu2H4YdQa7H4EHCMG6kUO/P6yDeNAQwiEzu5DRL6A5j
         64s8rxQq4/z8jp6/WejNYvktRgHsJFmt1AQ9moU0H8uDkiTlqlVC+m5DiveDiOnjVFlo
         cB1t4umxmoDqWdCf/zK+q/oxk8kUg/AtitlQMdibOe15CloukYfPIaexIBPS44FoJJgk
         uwnQ==
X-Gm-Message-State: AOJu0YxwRtVx5RXxPApPajJvlTsdG01ktfZoM3nR6zW8mnf90g5Qr8Q7
	7LRX5XVNh/WhD+9ZwZfdXPZS2QwRzLqWdt+VPapxe0TzB216m3LJYM5tJw==
X-Gm-Gg: ASbGncsZCknmfPwAI4KI0noCQgYa49uNpg5Nz+7dTNuSWQDatDsrBExAMHi42gDms/I
	eKtcuf1skVT8Snmy3p8bqrA/FVlmx/wLTcotDIao6h4bVosqR+h3ZlHAFVjSQGwtA1dnAmAxPFK
	5dchx770Nhy2TlW7YEbPkt3NuY/B5t2wzAVXU2rUWhv/pUsm0gm8q+GpH3kRr9HBjUalOL+0Zi+
	mMjmEa87juM/+/SbKAQq+7AAOMotY06hutnHu+jzO0Si6ZQxVfqMwwxfivkWmz5dESv+nQlVfzH
	fYzpZ9f8pc9GK+GQJ9aV1GptIy2tPR7XtH7b6IYer2niKbPlmHGdJNbZWg==
X-Google-Smtp-Source: AGHT+IECfSuO0RakQB9jUe71zv6IYswqz0Di/sriowwfXeurXxdzxL03ZJTNKi0dPd6l/fh+hjJ16Q==
X-Received: by 2002:a17:906:f043:b0:ac3:4139:9346 with SMTP id a640c23a62f3a-ac38d366faemr68287366b.9.1742233244439;
        Mon, 17 Mar 2025 10:40:44 -0700 (PDT)
Received: from msi-laptop.thefacebook.com ([2620:10d:c092:500::4:812])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac3147e9cadsm693917166b.48.2025.03.17.10.40.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Mar 2025 10:40:44 -0700 (PDT)
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
Subject: [PATCH bpf-next v6 0/4] Support freplace prog from user namespace
Date: Mon, 17 Mar 2025 17:40:35 +0000
Message-ID: <20250317174039.161275-1-mykyta.yatsenko5@gmail.com>
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
 kernel/bpf/syscall.c                          | 27 +++++-
 tools/include/uapi/linux/bpf.h                |  1 +
 tools/lib/bpf/bpf.c                           |  3 +-
 tools/lib/bpf/bpf.h                           |  3 +-
 tools/lib/bpf/btf.c                           | 15 ++-
 tools/lib/bpf/libbpf.c                        | 10 +-
 tools/lib/bpf/libbpf_internal.h               |  1 +
 .../testing/selftests/bpf/prog_tests/token.c  | 97 ++++++++++++++++++-
 .../selftests/bpf/progs/priv_freplace_prog.c  | 13 +++
 tools/testing/selftests/bpf/progs/priv_prog.c |  6 +-
 11 files changed, 160 insertions(+), 17 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/priv_freplace_prog.c

-- 
2.48.1



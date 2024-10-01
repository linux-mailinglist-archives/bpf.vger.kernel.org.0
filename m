Return-Path: <bpf+bounces-40636-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6384898B2DB
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 05:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16BE928322E
	for <lists+bpf@lfdr.de>; Tue,  1 Oct 2024 03:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE5A31B0118;
	Tue,  1 Oct 2024 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFJYfZLc"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314EB1AFB32;
	Tue,  1 Oct 2024 03:55:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727754926; cv=none; b=YZSE8Jj/nNyWNkMGSiUv++VfQtVigbpS+Izsig4rm7nCtaVW2ShMbHUS9wlkC4JEn5DVEzCYF8KPoJGUzRjVZso3An6Z1Fo2X/8zvWbm4VnnlkECXUh/0rBc5XwPbQ9cprUuTp669yWXjVQ2xu55K6+/d27nnlK3LQE+cmuNr3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727754926; c=relaxed/simple;
	bh=uchJyHZwSePmopkBZvOxuyt0es7TztoFkb8qVxM5/M0=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=t29PPFDCCWrXqoD8kosw6LVzM5F7kzJHgfjtMqUcPCwpQVNNqMxfWIdgzsWgJ6pgE4Fcn2h+3m4ZK8gE8rC75h+VY7rudfnlbf/HC4w7zWNwaNPYo5TSOK5DNWobLZH8kCxM5AETwot4DGNlHseYh+OKmOGFjQ7WmGk1VK5yJxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFJYfZLc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10FA5C4CEC6;
	Tue,  1 Oct 2024 03:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727754926;
	bh=uchJyHZwSePmopkBZvOxuyt0es7TztoFkb8qVxM5/M0=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=DFJYfZLcKZ1bvLsnOnzO8tHFnxnFrRUq725ax++fmm6wLdcVNJUwq9g90btY7UYpC
	 aEZMDxu+13ekHOdYKRaNeUZl3qTMiWKOkISrewDTHMTitzglsjtCs7ygzkACtEu4aF
	 tVhYt7RuVwkV0aT2ZxePdQUBwA7nn4WxL3+LX7b10sUuXbMlIQ4v3vtTfidM8fnMGf
	 /d1XyQqtn6N+1XFdZOCMaoBUdh6PqlmUN2Z+hQ6N7f6MIVQUzApOiHcd60MyPdgqDh
	 89uhBUt6Qt7Jc52BBW3r5/dh2qYE8cfNf+5aaFowva2MrYFXe1v5YBMk39aGGCL2NZ
	 t66lzrSSSPLWg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1727CEB2E5;
	Tue,  1 Oct 2024 03:55:25 +0000 (UTC)
From: Eric Long via B4 Relay <devnull+i.hack3r.moe@kernel.org>
Subject: [PATCH bpf-next v3 0/2] BPF static linker: fix linking duplicate
 extern functions
Date: Tue, 01 Oct 2024 11:55:20 +0800
Message-Id: <20241001-libbpf-dup-extern-funcs-v3-0-42f7774efbf3@hack3r.moe>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKhy+2YC/43NQQ6CMBAF0KuYrh3TDiDgynsYF7SdSqMW0kKDI
 dzd2p0rXf78+W9WFshbCuy0W5mnaIMdXArFfsdU37kbgdUpM+RY8hZbeFgpRwN6HoGWibwDMzs
 VoKmFKWWnUSCytB49Gbtk+cI+C5fO2TU1vQ3T4F/5ZRS5/6lHARy0EZWR+lhhJc99p+6FPzwHy
 mjEPyFMEFeqEZoKU7fmC9q27Q26m0ttEgEAAA==
X-Change-ID: 20240929-libbpf-dup-extern-funcs-871f4bad2122
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>, 
 Alexei Starovoitov <ast@kernel.org>, netdev@vger.kernel.org, 
 Eric Long <i@hack3r.moe>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1680; i=i@hack3r.moe;
 h=from:subject:message-id;
 bh=uchJyHZwSePmopkBZvOxuyt0es7TztoFkb8qVxM5/M0=;
 b=owGbwMvMwCUWYb/agfVY0D7G02pJDGm/i9b46y1w2bPjsYmno7l69LzH6VeEOM1uRISFOx0LM
 dinJ9fdUcrCIMbFICumyLLl8B+1BP3uTUu455TDzGFlAhnCwMUpABOpC2VkmJj6P/OzyI13RUXb
 H5qrMPzkMP9eKjxVJkG5Tn7e6hWtUxgZLuubNeifkZofaBm+LWjrJHGOK4LzZh38sejMhMbXB0U
 2MAAA
X-Developer-Key: i=i@hack3r.moe; a=openpgp;
 fpr=3A7A1F5A7257780C45A9A147E1487564916D3DF5
X-Endpoint-Received: by B4 Relay for i@hack3r.moe/default with auth_id=225
X-Original-From: Eric Long <i@hack3r.moe>
Reply-To: i@hack3r.moe

Currently, if `bpftool gen object` tries to link two objects that
contains the same extern function prototype, libbpf will try to get
their (non-existent) size by calling bpf__resolve_size like extern
variables and fail with:

	libbpf: global 'whatever': failed to resolve size of underlying type: -22

This should not be the case, and this series adds conditions to update
size only when the BTF kind is not function.

Fixes: a46349227cd8 ("libbpf: Add linker extern resolution support for functions and global variables")
Signed-off-by: Eric Long <i@hack3r.moe>
---
Changes in v3:
- Simplifiy changes and shorten subjects, according to reviews.
- Remove unused includes in selftests.
- Link to v2: https://lore.kernel.org/r/20240929-libbpf-dup-extern-funcs-v2-0-0cc81de3f79f@hack3r.moe

Changes in v2:
- Fix compile errors. Oops!
- Link to v1: https://lore.kernel.org/r/20240929-libbpf-dup-extern-funcs-v1-0-df15fbd6525b@hack3r.moe

---
Eric Long (2):
      libbpf: do not resolve size on duplicate FUNCs
      selftests/bpf: test linking with duplicate extern functions

 tools/lib/bpf/linker.c                                |  4 ++++
 tools/testing/selftests/bpf/Makefile                  |  3 ++-
 .../selftests/bpf/prog_tests/dup_extern_funcs.c       |  9 +++++++++
 tools/testing/selftests/bpf/progs/dup_extern_funcs1.c | 19 +++++++++++++++++++
 tools/testing/selftests/bpf/progs/dup_extern_funcs2.c | 17 +++++++++++++++++
 5 files changed, 51 insertions(+), 1 deletion(-)
---
base-commit: 93eeaab4563cc7fc0309bc1c4d301139762bbd60
change-id: 20240929-libbpf-dup-extern-funcs-871f4bad2122

Best regards,
-- 
Eric Long <i@hack3r.moe>




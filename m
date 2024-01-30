Return-Path: <bpf+bounces-20639-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDDE384174A
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 01:06:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BEE61F236EF
	for <lists+bpf@lfdr.de>; Tue, 30 Jan 2024 00:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAFFEC9;
	Tue, 30 Jan 2024 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLXd08qp"
X-Original-To: bpf@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42CB19440
	for <bpf@vger.kernel.org>; Tue, 30 Jan 2024 00:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706573213; cv=none; b=QACA2tuNy7cWJZIEaw6gnpCFYym5sJjwX7g+XhdSVcl/6J+lUi7PgH3IIU9WU+r470I2HEYJOxAfsfCQyqa+j72uOhSIJSHPlNWLv0KFiczijzUgxxw3VC6+YxMBmroyLs6bOqgw+MoOUbMLxmjbiIIrDiyTNrvQ/jyZmkUhRyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706573213; c=relaxed/simple;
	bh=0ObOGM8jIl75tRunmP4wh6ptJ1Fd4M79mwA6KusW/Mw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qfQxu6CMxhdPOAhqlMt54u0f3tqPMj0Oc2Ebp/1vzDcccvxAbTLQ+cdMw7kI1frHO1laI5dsrw1rF+Xmb0L0G7qEjIcK14IqDrbHY4EjszoTqyMBucdyEDiEwUJXU6iwwQ9DXZSj0CR9Jex+p7jObzQ22Dj+12KppELklBq2C2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLXd08qp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85929C433F1;
	Tue, 30 Jan 2024 00:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706573212;
	bh=0ObOGM8jIl75tRunmP4wh6ptJ1Fd4M79mwA6KusW/Mw=;
	h=From:To:Cc:Subject:Date:From;
	b=FLXd08qpjUYLV3fH7Igq4G3r9U4iNWSjL11PY1m/fsR1oUI20yJPxVC1pELWXFML8
	 u9t4K/XWtmyOTQIriIlGLV06qKBZcHgPDQ/JFh2FITCiT+gKYaC+xs6QCZf2BrWqZb
	 BrtmICKDYcPrXwI5tyC77FOCCMG5S/IpOoShCG36Z/1s46na/Pw8WIDi9dEGa+Wh/L
	 T8KQe0l9ewezMvVKsTT90E6RflEbiKqiB0vAd2zhVRCEZjVXUIDDuMoRECNpffjLnD
	 WGzlyP12HrJWpHtqUNvoAI6VGsvjLadZZQb06IkGZmkKEN02zl0d5rYXvCRs7Yz0Dv
	 IlzCs8ZmQL1pg==
From: Andrii Nakryiko <andrii@kernel.org>
To: bpf@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@kernel.org
Cc: andrii@kernel.org,
	kernel-team@meta.com
Subject: [PATCH v3 bpf-next 0/4] Trusted PTR_TO_BTF_ID arg support in global subprogs
Date: Mon, 29 Jan 2024 16:06:44 -0800
Message-Id: <20240130000648.2144827-1-andrii@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch set follows recent changes that added btf_decl_tag-based argument
annotation support for global subprogs. This time we add ability to pass
PTR_TO_BTF_ID (BTF-aware kernel pointers) arguments into global subprograms.
We support explicitly trusted arguments only, for now.

Patch #1 adds logic for arg:trusted tag support on the verifier side. Default
semantic of such arguments is non-NULL, enforced on caller side. But patch #2
adds arg:nullable tag that can be combined with arg:trusted to make callee
explicitly do the NULL check, which helps implement "optional" PTR_TO_BTF_ID
arguments.

Patch #3 adds libbpf-side __arg_trusted and __arg_nullable macros.

Patch #4 adds a bunch of tests validating __arg_trusted in combination with
__arg_nullable.

v2->v3:
  - went back to arg:nullable and __arg_nullable naming;
  - rebased on latest bpf-next after prepartory patches landed;
v1->v2:
  - added fix up to type enforcement changes, landed earlier;
  - dropped bpf_core_cast() changes, will post them separately, as they now
    are not used in added tests;
  - dropped arg:untrusted support (Alexei);
  - renamed arg:nullable to arg:maybe_null (Alexei);
  - and also added task_struct___local flavor tests (Alexei).

Andrii Nakryiko (4):
  bpf: add __arg_trusted global func arg tag
  bpf: add arg:nullable tag to be combined with trusted pointers
  libbpf: add __arg_trusted and __arg_nullable tag macros
  selftests/bpf: add trusted global subprog arg tests

 include/linux/bpf_verifier.h                  |   1 +
 kernel/bpf/btf.c                              | 109 ++++++++++--
 kernel/bpf/verifier.c                         |  24 +++
 tools/lib/bpf/bpf_helpers.h                   |   2 +
 .../selftests/bpf/prog_tests/verifier.c       |   2 +
 .../bpf/progs/verifier_global_ptr_args.c      | 156 ++++++++++++++++++
 6 files changed, 281 insertions(+), 13 deletions(-)
 create mode 100644 tools/testing/selftests/bpf/progs/verifier_global_ptr_args.c

-- 
2.34.1



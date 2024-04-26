Return-Path: <bpf+bounces-27923-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 248408B3702
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 14:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57D701C219F2
	for <lists+bpf@lfdr.de>; Fri, 26 Apr 2024 12:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC429145B09;
	Fri, 26 Apr 2024 12:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HczxP7UO"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5914144D15
	for <bpf@vger.kernel.org>; Fri, 26 Apr 2024 12:17:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714133862; cv=none; b=HsdF4iwKwSqOpTe1qxwryx5hf4p4L9aR5xnaixr4y4/qw4qRHDIDJmPR+IFWWxAjnG8POSGQFoz9s/N0vwWjeL4FeOZ2nJN2DRFfZ1q2Y8x+ssIUofwsVHhP3gvoZbyJLafTxzG9HbSczoEv5Rysvzs29/zLNBPQQ1PtimAu+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714133862; c=relaxed/simple;
	bh=ZBJzedNJy5lJ5v8akFfG3TH/5KA9q1DaqtheDuTLg54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MUNci+xB4dbAEZl2m0bnp/sdz4kO0izV9NPQtB70+OFzkt4C3rbxQnWdiX6maIJErJ8OojLZaTHaUJrHwwCyTrwi31j1fFKYJyIERxn0N1kpIwHqTG6RXAxTAb5F9HLqtD6TifSNVgA5KFfblMgpn0APhjxA//TibLbrXbB311A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HczxP7UO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714133859;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=XkBQv54BZYexj1GaK6x7GTIvgoTyL4x4c+0UIhtACtU=;
	b=HczxP7UO/qMUG8T8S7IaOGCSaPDmKILlsSt0NLmtbXzrjPxBnjyt+b/zCpM3zBaZzJ0+sV
	Sj7EMibl+rkiUvfm2tW/a4aRaWo/bZrXBNF9NXefwQDVLe+OuPh6vS8mkLFan0xUBTMXu9
	6nXMdTioOGXSHSrVA1TiSR5Yc5b5szQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-MOodWH3NMaCI5yC54iDL4A-1; Fri,
 26 Apr 2024 08:17:35 -0400
X-MC-Unique: MOodWH3NMaCI5yC54iDL4A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6B1C33813F2F;
	Fri, 26 Apr 2024 12:17:34 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.224.95])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 768BC1121313;
	Fri, 26 Apr 2024 12:17:31 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 0/2] libbpf: support "module:function" syntax for tracing programs
Date: Fri, 26 Apr 2024 14:17:25 +0200
Message-ID: <cover.1714133551.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

In some situations, it is useful to explicitly specify a kernel module
to search for a tracing program target (e.g. when a function of the same
name exists in multiple modules or in vmlinux).

This change enables that by allowing the "module:function" syntax for
the find_kernel_btf_id function. Thanks to this, the syntax can be used
both from a SEC macro (i.e. `SEC(fentry/module:function)`) and via the
bpf_program__set_attach_target API call.

Viktor Malik (2):
  libbpf: support "module:function" syntax for tracing programs
  selftests/bpf: add tests for the "module:function" syntax

 tools/lib/bpf/libbpf.c                        | 33 ++++++++++++++-----
 .../selftests/bpf/prog_tests/module_attach.c  |  6 ++++
 .../selftests/bpf/progs/test_module_attach.c  | 23 +++++++++++++
 3 files changed, 53 insertions(+), 9 deletions(-)

-- 
2.44.0



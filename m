Return-Path: <bpf+bounces-28238-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71CFE8B6EA6
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 11:40:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A40CC1C22CB8
	for <lists+bpf@lfdr.de>; Tue, 30 Apr 2024 09:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35962129E7E;
	Tue, 30 Apr 2024 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RawAErIn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C9C127E0D
	for <bpf@vger.kernel.org>; Tue, 30 Apr 2024 09:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714469903; cv=none; b=rO8DZ0XGj3y6SWUrGbW+jUN5AKHmOsRySzx7Pj0dgEVg2CG4CAkUGCnvCSB5DHFRf1FxEUVHnNwqCyJ18OjRPGA/cFuAmowzDMq0TdVjINnYgewM0ac5szEfd0M29ABJZcvRXXoMpkTMVTPJ5WaCCmbI6P5vMOLx16J1tQdJW+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714469903; c=relaxed/simple;
	bh=wl+C/hXKLC78LuOi56vuvV1Lot2kfxIGTOapKIGI9Xk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SRQpMqjvBoT5yvkkq0iof6V7i5OTsQ9NWh9f1U7eO8xXFi/Ai0KEhfcJCo1oao6b2tocEGDxZdSyMf32euNbzTlb9bxMuNgrEW5i3iFEeQweWPXo8bZDsaxcC/r+fWryxTh0UEYdMCqs4LgJ4w8smIAB0OPpTSelFKzQoHCGbxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RawAErIn; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714469901;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DY7uXL09OgeHU2tU9VHIsDtKDedgRxDA9XzGKzTBd7w=;
	b=RawAErInfNTNW6r7LHuJC5DXcT3dhc7px7PDAHPmouDqFSOoAwDnJkQZHxKdlYyH+q9iBn
	oQQBKa5pat4YlA019D3BBD1bTMtrV849TsOkkxd+Fn3ZVekEbDcwc0kK6+0P4pSWbDjJx7
	AVKFksFqqBeHmomgWrAxpk7bNrbuTgA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-0Oc1B0RCOoCc1_XoVNLUoA-1; Tue, 30 Apr 2024 05:38:15 -0400
X-MC-Unique: 0Oc1B0RCOoCc1_XoVNLUoA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8C15A80591B;
	Tue, 30 Apr 2024 09:38:14 +0000 (UTC)
Received: from vmalik-fedora.redhat.com (unknown [10.45.226.51])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 498202166B31;
	Tue, 30 Apr 2024 09:38:11 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next v2 0/2] libbpf: support "module:function" syntax for tracing programs
Date: Tue, 30 Apr 2024 11:38:05 +0200
Message-ID: <cover.1714469650.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

In some situations, it is useful to explicitly specify a kernel module
to search for a tracing program target (e.g. when a function of the same
name exists in multiple modules or in vmlinux).

This change enables that by allowing the "module:function" syntax for
the find_kernel_btf_id function. Thanks to this, the syntax can be used
both from a SEC macro (i.e. `SEC(fentry/module:function)`) and via the
bpf_program__set_attach_target API call.

--- 

Changes in v2:
- stylistic changes (suggested by Andrii)
- added Andrii's ack to the second patch

Viktor Malik (2):
  libbpf: support "module:function" syntax for tracing programs
  selftests/bpf: add tests for the "module:function" syntax

 tools/lib/bpf/libbpf.c                        | 35 ++++++++++++++-----
 .../selftests/bpf/prog_tests/module_attach.c  |  6 ++++
 .../selftests/bpf/progs/test_module_attach.c  | 23 ++++++++++++
 3 files changed, 55 insertions(+), 9 deletions(-)

-- 
2.44.0



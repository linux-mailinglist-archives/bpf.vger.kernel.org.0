Return-Path: <bpf+bounces-13212-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B33647D618C
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 08:19:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4C6D1C20DE3
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 06:19:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59BAE156CC;
	Wed, 25 Oct 2023 06:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="esViBVOp"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77915154B6
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:19:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8367BCC
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 23:19:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698214778;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0cOScpsY58vvdNy2vwFDL1fZWsJqXbmzD3bextbHu20=;
	b=esViBVOp0vPJDbAKYQd1hpGza85B2npnGbKByvhg2OepwkhfJaOnTGEJIZ7x/D2jra9Q8K
	D41CbjrA2JrPRwmnXEENZmco7dh4/mf17UyqGrCnUXzmglsziXyHiGQ0sMWyWs4AzrTnCE
	TGWs8lJMkbGg90LiCX6MbtlRiytG0AU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-240-WaN8A2LnPg6hQAx9AD-Icw-1; Wed,
 25 Oct 2023 02:19:27 -0400
X-MC-Unique: WaN8A2LnPg6hQAx9AD-Icw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 637203C0FC9F;
	Wed, 25 Oct 2023 06:19:26 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 8A6F01121319;
	Wed, 25 Oct 2023 06:19:24 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Donald Zickus <dzickus@redhat.com>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next 3/3] samples/bpf: Allow building with custom bpftool
Date: Wed, 25 Oct 2023 08:19:14 +0200
Message-ID: <bd746954ac271b02468d8d951ff9f11e655d485b.1698213811.git.vmalik@redhat.com>
In-Reply-To: <cover.1698213811.git.vmalik@redhat.com>
References: <cover.1698213811.git.vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

samples/bpf build its own bpftool boostrap to generate vmlinux.h as well
as some BPF objects. This is a redundant step if bpftool has been
already built, so update samples/bpf/Makefile such that it accepts a
path to bpftool passed via the BPFTOOL variable. The approach is
practically the same as tools/testing/selftests/bpf/Makefile uses.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 samples/bpf/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 378b9f3e9321..933f6c3fe6b0 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -260,8 +260,9 @@ $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
 
 BPFTOOLDIR := $(TOOLS_PATH)/bpf/bpftool
 BPFTOOL_OUTPUT := $(abspath $(BPF_SAMPLES_PATH))/bpftool
-BPFTOOL := $(BPFTOOL_OUTPUT)/bootstrap/bpftool
-$(BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile) | $(BPFTOOL_OUTPUT)
+DEFAULT_BPFTOOL := $(BPFTOOL_OUTPUT)/bootstrap/bpftool
+BPFTOOL ?= $(DEFAULT_BPFTOOL)
+$(DEFAULT_BPFTOOL): $(wildcard $(BPFTOOLDIR)/*.[ch] $(BPFTOOLDIR)/Makefile) | $(BPFTOOL_OUTPUT)
 	$(MAKE) -C $(BPFTOOLDIR) srctree=$(BPF_SAMPLES_PATH)/../../ 		\
 		OUTPUT=$(BPFTOOL_OUTPUT)/ bootstrap
 
-- 
2.41.0



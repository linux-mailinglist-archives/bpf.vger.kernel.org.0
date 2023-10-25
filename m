Return-Path: <bpf+bounces-13209-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3097D6188
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 08:19:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB37D281BD8
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 06:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC19154BE;
	Wed, 25 Oct 2023 06:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cjM+1X+I"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E481FF9D1
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:19:27 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFAC4CC
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 23:19:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698214766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e/SXWhtVIl2aQxob5hmmaj9zepJE9f+7c7cKHRPxmMY=;
	b=cjM+1X+IxVQufRpX8h4izi005vbQGVnAkIOotIJDwHE+5S4p+O62A46Zd0MYk8Let2Ccfj
	JHqM3Ro6mzOkfTZzhWEKvZH8C9AdViZl+94a3WvmeQS2aWOz8ghkJHZvJKhV651nAs63yB
	za5tMkiRdzpnMtRWzkddBC6yn5OM/no=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-T9mxgrfiMUOLuL6HktKSqA-1; Wed, 25 Oct 2023 02:19:22 -0400
X-MC-Unique: T9mxgrfiMUOLuL6HktKSqA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 46467800CAA;
	Wed, 25 Oct 2023 06:19:22 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 6F32C1121319;
	Wed, 25 Oct 2023 06:19:20 +0000 (UTC)
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
Subject: [PATCH bpf-next 1/3] samples/bpf: Allow building with custom CFLAGS/LDFLAGS
Date: Wed, 25 Oct 2023 08:19:12 +0200
Message-ID: <2d81100b830a71f0e72329cc7781edaefab75f62.1698213811.git.vmalik@redhat.com>
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

Currently, it is not possible to specify custom flags when building
samples/bpf. The flags are defined in TPROGS_CFLAGS/TPROGS_LDFLAGS
variables, however, when trying to override those from the make command,
compilation fails.

For example, when trying to build with PIE:

    $ make -C samples/bpf TPROGS_CFLAGS="-fpie" TPROGS_LDFLAGS="-pie"

This is because samples/bpf/Makefile updates these variables, especially
appends include paths to TPROGS_CFLAGS and these updates are overridden
by setting the variables from the make command.

This patch introduces variables TPROGS_USER_CFLAGS/TPROGS_USER_LDFLAGS
for this purpose, which can be set from the make command and their
values are propagated to TPROGS_CFLAGS/TPROGS_LDFLAGS.

Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 samples/bpf/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 90af76fa9dd8..5a9805edec93 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -150,6 +150,9 @@ always-y += ibumad_kern.o
 always-y += hbm_out_kern.o
 always-y += hbm_edt_kern.o
 
+TPROGS_CFLAGS = $(TPROGS_USER_CFLAGS)
+TPROGS_LDFLAGS = $(TPROGS_USER_LDFLAGS)
+
 ifeq ($(ARCH), arm)
 # Strip all except -D__LINUX_ARM_ARCH__ option needed to handle linux
 # headers when arm instruction set identification is requested.
@@ -316,7 +319,7 @@ XDP_SAMPLE_CFLAGS += -Wall -O2 \
 		     -I$(LIBBPF_INCLUDE) \
 		     -I$(src)/../../tools/testing/selftests/bpf
 
-$(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS)
+$(obj)/$(XDP_SAMPLE): TPROGS_CFLAGS = $(XDP_SAMPLE_CFLAGS) $(TPROGS_USER_CFLAGS)
 $(obj)/$(XDP_SAMPLE): $(src)/xdp_sample_user.h $(src)/xdp_sample_shared.h
 # Override includes for trace_helpers.o because __must_check won't be defined
 # in our include path.
-- 
2.41.0



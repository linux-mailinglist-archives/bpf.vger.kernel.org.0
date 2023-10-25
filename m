Return-Path: <bpf+bounces-13211-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EFD77D618A
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 08:19:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CD8C3281CF6
	for <lists+bpf@lfdr.de>; Wed, 25 Oct 2023 06:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D17AB15ACA;
	Wed, 25 Oct 2023 06:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OXp0bzEz"
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01BB0156CC
	for <bpf@vger.kernel.org>; Wed, 25 Oct 2023 06:19:29 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E3E12F
	for <bpf@vger.kernel.org>; Tue, 24 Oct 2023 23:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1698214768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QqAAeO7obnxUE7t7KKZny8wXxstCiwJieUW7z5BVo9s=;
	b=OXp0bzEzCKML63oy+Wy+tVycQTWwsrRVdURcQcIDEhfhEjanKB+2cLoPyibSRFXsX3Hcfa
	Og+BmotgafQU1EBctLArteRoo3G2UqOOB85D8haXcOxPHXAlllKqU2LUwPedkSGaPaJNHD
	ArzVXn02/YYtBriFtEXh/ka6DsU7g8w=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-227-RqS7jNx2Pq29oEJFoIWnOg-1; Wed,
 25 Oct 2023 02:19:24 -0400
X-MC-Unique: RqS7jNx2Pq29oEJFoIWnOg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 546323C0FC80;
	Wed, 25 Oct 2023 06:19:24 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.62])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 7BEEC1121319;
	Wed, 25 Oct 2023 06:19:22 +0000 (UTC)
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
Subject: [PATCH bpf-next 2/3] samples/bpf: Fix passing LDFLAGS to libbpf
Date: Wed, 25 Oct 2023 08:19:13 +0200
Message-ID: <c690de6671cc6c983d32a566d33fd7eabd18b526.1698213811.git.vmalik@redhat.com>
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

samples/bpf/Makefile passes LDFLAGS=$(TPROGS_LDFLAGS) to libbpf build
without surrounding quotes, which may cause compilation errors when
passing custom TPROGS_USER_LDFLAGS.

For example:

    $ make -C samples/bpf/ TPROGS_USER_LDFLAGS="-Wl,--as-needed -specs=/usr/lib/gcc/x86_64-redhat-linux/13/libsanitizer.spec"
    make: Entering directory './samples/bpf'
    make -C ../../ M=./samples/bpf BPF_SAMPLES_PATH=./samples/bpf
    make[1]: Entering directory '.'
    make -C ./samples/bpf/../../tools/lib/bpf RM='rm -rf' EXTRA_CFLAGS="-Wall -O2 -Wmissing-prototypes -Wstrict-prototypes  -I./usr/include -I./tools/testing/selftests/bpf/ -I./samples/bpf/libbpf/include -I./tools/include -I./tools/perf -I./tools/lib -DHAVE_ATTR_TEST=0" \
            LDFLAGS=-Wl,--as-needed -specs=/usr/lib/gcc/x86_64-redhat-linux/13/libsanitizer.spec srctree=./samples/bpf/../../ \
            O= OUTPUT=./samples/bpf/libbpf/ DESTDIR=./samples/bpf/libbpf prefix= \
            ./samples/bpf/libbpf/libbpf.a install_headers
    make: invalid option -- 'c'
    make: invalid option -- '='
    make: invalid option -- '/'
    make: invalid option -- 'u'
    make: invalid option -- '/'
    [...]

Fix the error by properly quoting $(TPROGS_LDFLAGS).

Signed-off-by: Viktor Malik <vmalik@redhat.com>
Suggested-by: Donald Zickus <dzickus@redhat.com>
---
 samples/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/bpf/Makefile b/samples/bpf/Makefile
index 5a9805edec93..378b9f3e9321 100644
--- a/samples/bpf/Makefile
+++ b/samples/bpf/Makefile
@@ -254,7 +254,7 @@ clean:
 $(LIBBPF): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OUTPUT)
 # Fix up variables inherited from Kbuild that tools/ build system won't like
 	$(MAKE) -C $(LIBBPF_SRC) RM='rm -rf' EXTRA_CFLAGS="$(TPROGS_CFLAGS)" \
-		LDFLAGS=$(TPROGS_LDFLAGS) srctree=$(BPF_SAMPLES_PATH)/../../ \
+		LDFLAGS="$(TPROGS_LDFLAGS)" srctree=$(BPF_SAMPLES_PATH)/../../ \
 		O= OUTPUT=$(LIBBPF_OUTPUT)/ DESTDIR=$(LIBBPF_DESTDIR) prefix= \
 		$@ install_headers
 
-- 
2.41.0



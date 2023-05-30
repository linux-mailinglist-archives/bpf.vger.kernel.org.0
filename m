Return-Path: <bpf+bounces-1439-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AF7A716076
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 14:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0C461C20C35
	for <lists+bpf@lfdr.de>; Tue, 30 May 2023 12:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943601992B;
	Tue, 30 May 2023 12:49:01 +0000 (UTC)
X-Original-To: bpf@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6386B1D2BD
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 12:49:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F341EE48
	for <bpf@vger.kernel.org>; Tue, 30 May 2023 05:48:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1685450889;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xJk0C1IJBWsqnaIZb03DSbZreiDIj0jixiSaulTSEd0=;
	b=i8vuR65jhcc9UzJo6KDtnGR5mUEzsG20DmG6y7F9ZDBelWaI2snBaFNY21nL8ymFYOnKOq
	fhk6Tpjzg8pXUT/mzwBYco+7EI3rr1SLbPdYzl8WRbgAQ9/do/PRq+1qIWIOnU/PMQI9Xh
	FmXe4siXEdRbxXh6jZYwS6bgclaHKI4=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-515-1lxMhZydPuO9vIlOekr3WQ-1; Tue, 30 May 2023 08:34:02 -0400
X-MC-Unique: 1lxMhZydPuO9vIlOekr3WQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8B9131C01E94;
	Tue, 30 May 2023 12:34:00 +0000 (UTC)
Received: from dhcpe212.fit.vutbr.cz (unknown [10.45.224.71])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 28EA820296C6;
	Tue, 30 May 2023 12:33:57 +0000 (UTC)
From: Viktor Malik <vmalik@redhat.com>
To: bpf@vger.kernel.org
Cc: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yhs@fb.com>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@google.com>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ian Rogers <irogers@google.com>,
	Shen Jiamin <shen_jiamin@comp.nus.edu.sg>,
	Viktor Malik <vmalik@redhat.com>
Subject: [PATCH bpf-next] tools/resolve_btfids: fix setting HOSTCFLAGS
Date: Tue, 30 May 2023 14:33:52 +0200
Message-Id: <20230530123352.1308488-1-vmalik@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Building BPF selftests with custom HOSTCFLAGS yields an error:

    # make HOSTCFLAGS="-O2"
    [...]
      HOSTCC  ./tools/testing/selftests/bpf/tools/build/resolve_btfids/main.o
    main.c:73:10: fatal error: linux/rbtree.h: No such file or directory
       73 | #include <linux/rbtree.h>
          |          ^~~~~~~~~~~~~~~~

The reason is that tools/bpf/resolve_btfids/Makefile passes header
include paths by extending HOSTCFLAGS which is overridden by setting
HOSTCFLAGS in the make command (because of Makefile rules [1]).

This patch fixes the above problem by passing the include paths via
`HOSTCFLAGS_resolve_btfids` which is used by tools/build/Build.include
and can be combined with overridding HOSTCFLAGS.

[1] https://www.gnu.org/software/make/manual/html_node/Overriding.html

Fixes: 56a2df7615fa ("tools/resolve_btfids: Compile resolve_btfids as host program")
Signed-off-by: Viktor Malik <vmalik@redhat.com>
---
 tools/bpf/resolve_btfids/Makefile | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/Makefile b/tools/bpf/resolve_btfids/Makefile
index ac548a7baa73..4b8079f294f6 100644
--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -67,7 +67,7 @@ $(BPFOBJ): $(wildcard $(LIBBPF_SRC)/*.[ch] $(LIBBPF_SRC)/Makefile) | $(LIBBPF_OU
 LIBELF_FLAGS := $(shell $(HOSTPKG_CONFIG) libelf --cflags 2>/dev/null)
 LIBELF_LIBS  := $(shell $(HOSTPKG_CONFIG) libelf --libs 2>/dev/null || echo -lelf)
 
-HOSTCFLAGS += -g \
+HOSTCFLAGS_resolve_btfids += -g \
           -I$(srctree)/tools/include \
           -I$(srctree)/tools/include/uapi \
           -I$(LIBBPF_INCLUDE) \
@@ -76,7 +76,7 @@ HOSTCFLAGS += -g \
 
 LIBS = $(LIBELF_LIBS) -lz
 
-export srctree OUTPUT HOSTCFLAGS Q HOSTCC HOSTLD HOSTAR
+export srctree OUTPUT HOSTCFLAGS_resolve_btfids Q HOSTCC HOSTLD HOSTAR
 include $(srctree)/tools/build/Makefile.include
 
 $(BINARY_IN): fixdep FORCE prepare | $(OUTPUT)
-- 
2.40.1



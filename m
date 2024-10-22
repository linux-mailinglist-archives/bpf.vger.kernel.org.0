Return-Path: <bpf+bounces-42799-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C69BE9AB4F8
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:24:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B8001F2468C
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20F481BE87D;
	Tue, 22 Oct 2024 17:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QP5y/+Bn"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 216151BD501
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 17:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617846; cv=none; b=UNnfEoKWzbwWCrHqD553wNPsAOKKubYoCYFTAI6k5vqeYFeBYTIX3Go/gZ+JPe0ukCt9p0WI4DH6R1Z3CBFhmMDVY7kdwooPdPN3kZkIe7f/q2HldCk8Yvbx7Mr3hKJ6Zhfe5pyck9hxPvg/p4Dzu6x2bPNUudEsJ1W6V2YiRyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617846; c=relaxed/simple;
	bh=SaqctSPFGF6+q/43+UbfzYOhWmidNdBhOWKugsa7uNA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i53rADpjQ0sCQ2/VD6NZvM+BKHshuxyipQL2tFsei1S2Tm5/MtMJvTraHUxvrSOmCbSKsJGC+BQOE/EdoIyh64nNbtq+VfFMgfuNNLa13AUPepS2N8ZgWd3wwwDFoT3ytmXrzUThmWAYVqSVazATzCgLqfTft363uu8QfUVGmOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QP5y/+Bn; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729617844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hrA6XcsZzgghH+9JDOcIvHjo0+Ys4rAGu6oSgw/o1H8=;
	b=QP5y/+Bnb5s9d178gnG7FP/Om969nD9Osuk4YfJUhuECLnNhUOSAs367pz8nbhulEGe9fi
	lyHIn5ShrtB6h4rktg60HPNCAbbrNqR34mOKMkJMFYhc4FiOMOgcY5HsrsW1uKpHAlenPs
	adY8KIObw+aZAr6QPYR0iFK++DcDcTI=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-214-JhPFMKQpO2q5Olk4kBzqng-1; Tue,
 22 Oct 2024 13:23:57 -0400
X-MC-Unique: JhPFMKQpO2q5Olk4kBzqng-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CEC851955D5E;
	Tue, 22 Oct 2024 17:23:54 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.192.92])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 02F5D1955E8F;
	Tue, 22 Oct 2024 17:23:47 +0000 (UTC)
From: Eder Zulian <ezulian@redhat.com>
To: bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	acme@redhat.com,
	vmalik@redhat.com,
	williams@redhat.com
Subject: [PATCH v2 1/3] resolve_btfids: Fix compiler warnings
Date: Tue, 22 Oct 2024 19:23:27 +0200
Message-ID: <20241022172329.3871958-2-ezulian@redhat.com>
In-Reply-To: <20241022172329.3871958-1-ezulian@redhat.com>
References: <20241022172329.3871958-1-ezulian@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Initialize 'set' and 'set8' pointers to NULL in sets_patch to prevent
possible compiler warnings which are issued for various optimization
levels, but do not happen when compiling with current default
compilation options.

For example, when compiling resolve_btfids with

  $ make "HOSTCFLAGS=-O2 -Wall" -C tools/bpf/resolve_btfids/ clean all

Clang version 17.0.6 and GCC 13.3.1 issue following
-Wmaybe-uninitialized warnings for variables 'set8' and 'set':

  In function ‘sets_patch’,
      inlined from ‘symbols_patch’ at main.c:748:6,
      inlined from ‘main’ at main.c:823:6:
  main.c:163:9: warning: ‘set8’ may be used uninitialized [-Wmaybe-uninitialized]
    163 |         eprintf(1, verbose, pr_fmt(fmt), ##__VA_ARGS__)
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  main.c:729:17: note: in expansion of macro ‘pr_debug’
    729 |                 pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
        |                 ^~~~~~~~
  main.c: In function ‘main’:
  main.c:682:37: note: ‘set8’ was declared here
    682 |                 struct btf_id_set8 *set8;
        |                                     ^~~~
  In function ‘sets_patch’,
      inlined from ‘symbols_patch’ at main.c:748:6,
      inlined from ‘main’ at main.c:823:6:
  main.c:163:9: warning: ‘set’ may be used uninitialized [-Wmaybe-uninitialized]
    163 |         eprintf(1, verbose, pr_fmt(fmt), ##__VA_ARGS__)
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  main.c:729:17: note: in expansion of macro ‘pr_debug’
    729 |                 pr_debug("sorting  addr %5lu: cnt %6d [%s]\n",
        |                 ^~~~~~~~
  main.c: In function ‘main’:
  main.c:683:36: note: ‘set’ was declared here
    683 |                 struct btf_id_set *set;
        |                                    ^~~

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 tools/bpf/resolve_btfids/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/resolve_btfids/main.c b/tools/bpf/resolve_btfids/main.c
index d54aaa0619df..bd9f960bce3d 100644
--- a/tools/bpf/resolve_btfids/main.c
+++ b/tools/bpf/resolve_btfids/main.c
@@ -679,8 +679,8 @@ static int sets_patch(struct object *obj)
 
 	next = rb_first(&obj->sets);
 	while (next) {
-		struct btf_id_set8 *set8;
-		struct btf_id_set *set;
+		struct btf_id_set8 *set8 = NULL;
+		struct btf_id_set *set = NULL;
 		unsigned long addr, off;
 		struct btf_id *id;
 
-- 
2.46.2



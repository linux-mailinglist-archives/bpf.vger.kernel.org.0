Return-Path: <bpf+bounces-36736-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4669294C7B1
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 02:41:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F121F1F231BC
	for <lists+bpf@lfdr.de>; Fri,  9 Aug 2024 00:41:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E53DC4C76;
	Fri,  9 Aug 2024 00:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RfBm9p3W"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423EF9443
	for <bpf@vger.kernel.org>; Fri,  9 Aug 2024 00:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723164090; cv=none; b=EHpkY3NGkTMpnOCt0bVxfnV8AjzWo/R4zYsNIvjSx6AytJ38EyPB3xM/2d8uqwB57Ns5C7GmgLs0zfdhbrw+5AiNmwJhgOhHPxJ7onOup9QHbFQWK62EAWvO5uPBrKFSz45hYDR6v0Zgq+wIE0NjdQMyAEe5sxXyHKeBrdyJZYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723164090; c=relaxed/simple;
	bh=NFa+S5nRZ5np4RSICk01ZaRv7d31GP5BnVyhNCYLInE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=geJAAKrkzsV42XEruSrk97jCq/iZt3uLRx5hMsLklpZsEWoAdH3nSMDRDWt5t6kkPpogROc1AZ+7g3+dTgBq61C0bOIMfATyPsUClFXk5arYatJfeGqenS+/1KtfZnI+3JU+jE4A3PVkQIag1eeJov9N1A6RJe5tuPkr3XyV6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RfBm9p3W; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723164087;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=M26YjynhmP9eZN38dbcolxe8l8x5YqVc9VhTntz3DNA=;
	b=RfBm9p3WZGBtURoMix3f9y+63biE8TK5yW8JKZ8tnD3lIKiH3ZrcgiujdMg1IZ7moTPLEg
	4CT+sjTIbpdApyyzVHDohFzEAaVvFtPmTM5Y5JrFslc2ryvqryicZ2YavwBgCQg8LdyDgN
	n5VcnHczP+LwMLkPdm28F9c1ZzElWFE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-688-ebXIiumTO0KlPSHu8G9wXg-1; Thu,
 08 Aug 2024 20:41:23 -0400
X-MC-Unique: ebXIiumTO0KlPSHu8G9wXg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A3F7E1956046;
	Fri,  9 Aug 2024 00:41:22 +0000 (UTC)
Received: from asgard.redhat.com (unknown [10.45.242.6])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 10DBE3000197;
	Fri,  9 Aug 2024 00:41:19 +0000 (UTC)
Date: Fri, 9 Aug 2024 02:41:15 +0200
From: Eugene Syromiatnikov <esyr@redhat.com>
To: Andrii Nakryiko <andrii@kernel.org>
Cc: Artem Savkov <asavkov@redhat.com>, bpf@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] selftests/bpf/Makefile: fix relative rpath usage
Message-ID: <20240809004115.GA23612@asgard.redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

The relative RPATH ("./") supplied to linker options in CFLAGS is resolved
relative to current working directory and not the executable directory,
which will lead in incorrect resolution when the test executable is run
from elsewhere.  Changing it to $ORIGIN makes it resolve relative
to the directory in which the executable resides, which is supposedly
the desired behaviour.

Discovered by the check-rpaths script[1][2] that checks for insecure
RPATH/RUNPATH[3], such as relative directories, during an attempt
to package BPF selftests for later use in CI:

    ERROR   0004: file '/usr/libexec/kselftests/bpf/urandom_read' contains an insecure runpath '.' in [.]

[1] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths
[2] https://github.com/rpm-software-management/rpm/blob/master/scripts/check-rpaths-worker
[3] https://cwe.mitre.org/data/definitions/426.html

Signed-off-by: Eugene Syromiatnikov <esyr@redhat.com>
---
 tools/testing/selftests/bpf/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/Makefile b/tools/testing/selftests/bpf/Makefile
index dd49c1d23a60..6a3dc9b99159 100644
--- a/tools/testing/selftests/bpf/Makefile
+++ b/tools/testing/selftests/bpf/Makefile
@@ -241,7 +241,7 @@ $(OUTPUT)/urandom_read: urandom_read.c urandom_read_aux.c $(OUTPUT)/liburandom_r
 		     $(filter-out -static,$(CFLAGS) $(LDFLAGS)) $(filter %.c,$^) \
 		     -lurandom_read $(filter-out -static,$(LDLIBS)) -L$(OUTPUT) \
 		     -fuse-ld=$(LLD) -Wl,-znoseparate-code -Wl,--build-id=sha1 \
-		     -Wl,-rpath=. -o $@
+		     -Wl,-rpath=\$$ORIGIN/ -o $@
 
 $(OUTPUT)/sign-file: ../../../../scripts/sign-file.c
 	$(call msg,SIGN-FILE,,$@)
-- 
2.28.0



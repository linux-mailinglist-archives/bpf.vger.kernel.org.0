Return-Path: <bpf+bounces-68689-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 596B4B815D7
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 20:39:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12D91620A5E
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 18:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500CB3002BF;
	Wed, 17 Sep 2025 18:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aVNow7ww"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3623D2FDC21
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758134358; cv=none; b=rb27/aXBzS0hByCatmlFxFoHcAFltRVWWTv4TjRv9SN9SzsVtv+Jo+WJzkwfrCgQgySojRjS0rETtfGcZK9/P8Nky+5eQhg/x0CklhjQmM6qJOoKm81flawgoHhZVOhjDWMFo3/5bHxW1ey+tS1O43zf46I44npHNfss7BfLPmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758134358; c=relaxed/simple;
	bh=P/C4zIH0IzEZivbIiTHxayIUAitJfKEorYaTVR+UD4g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKSXC5nGR4fu29sjN2Dr+HKwj0FKKdvjpwph7D1LqChZC5/us+BEt0wQ/ecP2jNnb21niX+BDGFW/5no18VzadgqSJoMvVkjpcPiTSoYev0wXfiGW7IDSzwWGaxidGXTIzLMZjO/XEugdO2XDswbI3xejUgLgt9BJw4IS3KlS8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aVNow7ww; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758134356;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5d5s/0ZBBE+Cu2V1uZOL/zKy4Yxu2PJz2qcn+cl+ZqE=;
	b=aVNow7wwv29rQLygZw5waTVOeXGm4K9zW/jD9tZalrCmVvFRDJ82IYhTZRua0Tv1slf8W1
	sefA4nliEaFFhwcAIhSfIJ7a5s79nMpAecJP6VLKjGtG/N3I1N9BRsdjrqdQhxOqRav5/m
	kFk/Fu9TQWr03aOvp6z6azSJBADw9VY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-530-3Kf6TL9NM0mfRtTFTlxZ3A-1; Wed,
 17 Sep 2025 14:39:14 -0400
X-MC-Unique: 3Kf6TL9NM0mfRtTFTlxZ3A-1
X-Mimecast-MFC-AGG-ID: 3Kf6TL9NM0mfRtTFTlxZ3A_1758134354
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB61F1800451
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 18:39:13 +0000 (UTC)
Received: from tstellar-thinkpadp1gen4i.remote.csb (unknown [10.22.64.13])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E2CE6180035E;
	Wed, 17 Sep 2025 18:39:12 +0000 (UTC)
From: Tom Stellard <tstellar@redhat.com>
To: bpf@vger.kernel.org
Cc: Tom Stellard <tstellar@redhat.com>
Subject: [PATCH] bpftool: Fix -Wuninitialized-const-pointer warnings with clang >= 21 v2
Date: Wed, 17 Sep 2025 11:38:47 -0700
Message-ID: <20250917183847.318163-1-tstellar@redhat.com>
In-Reply-To: <7949d9ee-b463-4fd4-830e-0bb74fb5b2a0@kernel.org>
References: <7949d9ee-b463-4fd4-830e-0bb74fb5b2a0@kernel.org>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

This fixes the build with -Werror -Wall.

btf_dumper.c:71:31: error: variable 'finfo' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
   71 |         info.func_info = ptr_to_u64(&finfo);
      |                                      ^~~~~

prog.c:2294:31: error: variable 'func_info' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
 2294 |         info.func_info = ptr_to_u64(&func_info);
      |

v2:
  - Initialize instead of using memset.

Signed-off-by: Tom Stellard <tstellar@redhat.com>
---
 tools/bpf/bpftool/btf_dumper.c | 4 +++-
 tools/bpf/bpftool/prog.c       | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 4e896d8a2416..89715c32a1a3 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -38,7 +38,9 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
 	__u32 info_len = sizeof(info);
 	const char *prog_name = NULL;
 	struct btf *prog_btf = NULL;
-	struct bpf_func_info finfo;
+	/* Initialize finfo to silence -Wuninitialized-const-pointer warning
+	 * in clang >= 21. */
+	struct bpf_func_info finfo = {};
 	__u32 finfo_rec_size;
 	char prog_str[1024];
 	int err;
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 96eea8a67225..2540f570a38b 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2216,7 +2216,9 @@ static void profile_print_readings(void)
 
 static char *profile_target_name(int tgt_fd)
 {
-	struct bpf_func_info func_info;
+	/* Initialize func_info to silence -Wuninitialized-const-pointer
+	 * warning in clang >= 21. */
+	struct bpf_func_info func_info = {};
 	struct bpf_prog_info info = {};
 	__u32 info_len = sizeof(info);
 	const struct btf_type *t;
-- 
2.51.0



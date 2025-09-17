Return-Path: <bpf+bounces-68664-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA9FDB7FA75
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 16:00:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F40893A16A0
	for <lists+bpf@lfdr.de>; Wed, 17 Sep 2025 13:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 451412FBDF1;
	Wed, 17 Sep 2025 13:58:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UUEH1is9"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5629C33C76E
	for <bpf@vger.kernel.org>; Wed, 17 Sep 2025 13:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758117503; cv=none; b=Q404xyhyt4lP/ijNUb13LEEQ8U8ZJEvHKMAd8uhsFhfe7RWqLFqeNcipTi/eSaa5CEDe3/wwvC1lYOVjRzXAHoChu/p36dn4lCgYpOTGUOy1ZuBg+lwIOEXcEDjMmwJR8I49NHgrrpebuyFxKWi/IMxkRG/M9J9FK1EwaN8kIfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758117503; c=relaxed/simple;
	bh=ZrkZi7FkdCI9YzuFvYCaKh7IZKRP8gRHls8DmSCkMN8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C8jCpp+zGnWpyDQTgKHH1hXKRfC0J9DrdoMlBw9/sTVBmetR/EQ6SKD8Z4K8CgHL3Zn0mUFcDPvWA/T+LvEUbtKleNopFfxRakfZsIVqQxdFi0sJfn4UrT2aIrcGnFkpezqcKFa2STqwT6Vpp6tIvwUj6/u70wDdC0FX+pBBppE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UUEH1is9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758117501;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=poH3A2RLDm0zpoEXm+HNN6PkITPXHgZz9FMbbyaM7tQ=;
	b=UUEH1is96JBOjDACD0p4QNYCvnLNN2wu2kJntZYPxgtGcsBLI9mjeg4/oG/5+iQYPPNPyy
	tWKvc2wVjv2Zt5NIzHbruqAcnicUmJekoF4S6KIJgQ3KWS6M/nsDX0T4FM7DJAFEbpJ2RS
	F7EFgmD0K/4ALD31agwNlJPZ4m+S0MI=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-263-JIUker0GMdiC0IrR4unkAg-1; Wed,
 17 Sep 2025 09:58:17 -0400
X-MC-Unique: JIUker0GMdiC0IrR4unkAg-1
X-Mimecast-MFC-AGG-ID: JIUker0GMdiC0IrR4unkAg_1758117494
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8726A195608F;
	Wed, 17 Sep 2025 13:58:13 +0000 (UTC)
Received: from tstellar-thinkpadp1gen4i.remote.csb (unknown [10.22.64.13])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9A4AD19560B1;
	Wed, 17 Sep 2025 13:58:08 +0000 (UTC)
From: Tom Stellard <tstellar@redhat.com>
To: bpf@vger.kernel.org
Cc: qmo@kernel.org,
	ast@kernel.org,
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
	Tom Stellard <tstellar@redhat.com>
Subject: [PATCH] bpftool: Fix -Wuninitialized-const-pointer warnings with clang >= 21
Date: Wed, 17 Sep 2025 06:57:58 -0700
Message-ID: <20250917135758.289415-1-tstellar@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

This fixes the build with -Werror -Wall.

btf_dumper.c:71:31: error: variable 'finfo' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
   71 |         info.func_info = ptr_to_u64(&finfo);
      |                                      ^~~~~

prog.c:2294:31: error: variable 'func_info' is uninitialized when passed as a const pointer argument here [-Werror,-Wuninitialized-const-pointer]
 2294 |         info.func_info = ptr_to_u64(&func_info);
      |

Signed-off-by: Tom Stellard <tstellar@redhat.com>
---
 tools/bpf/bpftool/btf_dumper.c | 2 ++
 tools/bpf/bpftool/prog.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/tools/bpf/bpftool/btf_dumper.c b/tools/bpf/bpftool/btf_dumper.c
index 4e896d8a2416..363d3e592ce2 100644
--- a/tools/bpf/bpftool/btf_dumper.c
+++ b/tools/bpf/bpftool/btf_dumper.c
@@ -68,6 +68,8 @@ static int dump_prog_id_as_func_ptr(const struct btf_dumper *d,
 	memset(&info, 0, sizeof(info));
 	info.nr_func_info = 1;
 	info.func_info_rec_size = finfo_rec_size;
+	/* Silence -Wuninitialized-const-pointer warning in clang >= 21. */
+	memset(&finfo,  0, sizeof(finfo));
 	info.func_info = ptr_to_u64(&finfo);
 
 	err = bpf_prog_get_info_by_fd(prog_fd, &info, &info_len);
diff --git a/tools/bpf/bpftool/prog.c b/tools/bpf/bpftool/prog.c
index 96eea8a67225..b56427a838aa 100644
--- a/tools/bpf/bpftool/prog.c
+++ b/tools/bpf/bpftool/prog.c
@@ -2245,6 +2245,8 @@ static char *profile_target_name(int tgt_fd)
 	memset(&info, 0, sizeof(info));
 	info.nr_func_info = 1;
 	info.func_info_rec_size = func_info_rec_size;
+	/* Silence -Wuninitialized-const-pointer warning in clang >= 21. */
+	memset(&func_info,  0, sizeof(func_info));
 	info.func_info = ptr_to_u64(&func_info);
 
 	err = bpf_prog_get_info_by_fd(tgt_fd, &info, &info_len);
-- 
2.51.0



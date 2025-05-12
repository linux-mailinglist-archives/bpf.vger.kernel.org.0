Return-Path: <bpf+bounces-58016-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 09ABAAB3A06
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 16:05:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A0B319E04F1
	for <lists+bpf@lfdr.de>; Mon, 12 May 2025 14:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38A4A1B0F3C;
	Mon, 12 May 2025 14:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="POHC/H9v"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3393A1E4110
	for <bpf@vger.kernel.org>; Mon, 12 May 2025 14:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747058712; cv=none; b=rU5Rnml0Eo2NDd7Sw2RtVvm2mbEl+9RT+Ax5KTf12N9JeP82Y78tv5ZUSXJ73KZYlRuUB4eVcxF0Q+0NI3hC/ldhfSgQbYsCSpKV/nsQVfNCCUitwLtVKmUHl4V6eLODHNc1AU5XB2QRqCkLrvTaipKX650fGpRx2f1wi0w5ySE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747058712; c=relaxed/simple;
	bh=0gwWx9irmOMthFADpUZAspVuOnxq1Msl3Vnd5VBRxng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J5YzpPblZEg6KQJAn07cv5rBFMEPZ34WMKYnexCPSkLFaMNkakMANBf8Giu3ecf4SFuWyrzPUV5pKik6zf/UO4BT6x4sDJUn13YcTNc2dyY8aLQY71EURFnerTA+pWrfuiUfrHWAoF8GtckXlS39y4LQsK5VvCT1xVjOUwEDzLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=POHC/H9v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747058710;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aKUKTM+Uls808I6r5VI2ZZha/bbLBqgJvDLDm/bGgqY=;
	b=POHC/H9vO+EoNq+ou2eFvfnWT7UJZ0yfidyo+hIW+fwH+YDUJOBHpc0o+ROmS7WMrPkSwQ
	CXCT+crsEqnVOdrgdBWrUZy8ZR4shLXTdC8VPUrlPIeqgjYotMCAFQ0uSPP3DVQQp3qe8f
	unCEWgm1jVDK2g+MtNLs5RzwJYwJsJ4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-56-xo2CYtBqOrmFUV3fYzVTCw-1; Mon,
 12 May 2025 10:05:05 -0400
X-MC-Unique: xo2CYtBqOrmFUV3fYzVTCw-1
X-Mimecast-MFC-AGG-ID: xo2CYtBqOrmFUV3fYzVTCw_1747058703
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 015C21800373;
	Mon, 12 May 2025 14:05:03 +0000 (UTC)
Received: from grbell-thinkpadx1carbongen9.rmtusnh.csb (unknown [10.22.88.193])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 649A91801A42;
	Mon, 12 May 2025 14:04:59 +0000 (UTC)
From: Gregory Bell <grbell@redhat.com>
To: bpf@vger.kernel.org
Cc: andrii@kernel.org,
	eddyz87@gmail.com,
	mykolal@fb.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	shuah@kernel.org,
	Gregory Bell <grbell@redhat.com>
Subject: [PATCH bpf-next 2/2] selftests/bpf: test_verifier verbose log overflows
Date: Mon, 12 May 2025 10:04:13 -0400
Message-ID: <e49267100f07f099a5877a3a5fc797b702bbaf0c.1747058195.git.grbell@redhat.com>
In-Reply-To: <cover.1747058195.git.grbell@redhat.com>
References: <cover.1747058195.git.grbell@redhat.com>
Precedence: bulk
X-Mailing-List: bpf@vger.kernel.org
List-Id: <bpf.vger.kernel.org>
List-Subscribe: <mailto:bpf+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:bpf+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

Tests:
 - 458/p ld_dw: xor semi-random 64-bit imms, test 5
 - 501/p scale: scale test 1
 - 502/p scale: scale test 2

fail in verbose mode due to bpf_vlog[] overflowing. These tests
generate large verifier logs that exceed the current buffer size,
causing them to fail to load.

Increase the size of the bpf_vlog[] buffer to accommodate larger
logs and prevent false failures during test runs with verbose output.

Signed-off-by: Gregory Bell <grbell@redhat.com>
---
 tools/testing/selftests/bpf/test_verifier.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/testing/selftests/bpf/test_verifier.c b/tools/testing/selftests/bpf/test_verifier.c
index 2d13e862b078..27db34ecf3f5 100644
--- a/tools/testing/selftests/bpf/test_verifier.c
+++ b/tools/testing/selftests/bpf/test_verifier.c
@@ -734,7 +734,7 @@ static __u32 btf_raw_types[] = {
 	BTF_MEMBER_ENC(71, 13, 128), /* struct prog_test_member __kptr *ptr; */
 };
 
-static char bpf_vlog[UINT_MAX >> 8];
+static char bpf_vlog[UINT_MAX >> 5];
 
 static int load_btf_spec(__u32 *types, int types_len,
 			 const char *strings, int strings_len)
-- 
2.49.0



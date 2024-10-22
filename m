Return-Path: <bpf+bounces-42801-lists+bpf=lfdr.de@vger.kernel.org>
X-Original-To: lists+bpf@lfdr.de
Delivered-To: lists+bpf@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A73B9AB4FC
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 19:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE9561F2469A
	for <lists+bpf@lfdr.de>; Tue, 22 Oct 2024 17:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE6E1BF7EA;
	Tue, 22 Oct 2024 17:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZHyB8fjt"
X-Original-To: bpf@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E061BDA81
	for <bpf@vger.kernel.org>; Tue, 22 Oct 2024 17:24:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729617856; cv=none; b=I4W62MTkefRfgeGpu8bPUijXpR3tamnm9gUnyWbTuQAj2fvFyXjCEgPAvJfREcEu61jBRkzQ0AoOGVGhEysgIdW3HLMQuuNFf1yMLidL+iCe8IYLyZRk21ykoeBrJ4pi0hA04Hpcob0xYNUetdFLnKhHc+KmZlGZOElwjGdAf0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729617856; c=relaxed/simple;
	bh=7A+wqXFqVEEFcs32UD2pyejQfKgGBcn0hHv+lq3Wn84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rk09WMPHMRtmYYe0ZZaDPz8wmzvkQhZ4/ZaafUyYKoiFJeliujEFeHBNjWMBg2XeSexheyUiAv1XN4kxaft3SyPvoXIVGOwuiVDp6tF1+6j0tW0VpXy08Khttx9hf1sQyB2HBBk1XWsZhynGI35kkV+YxjvIp2xfK70eHRQyDFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZHyB8fjt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729617853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+Wj5eXI3hv/U03ptO++QyvhlUUq9Z9g1YTNX9l3We/8=;
	b=ZHyB8fjtCouhG3rleoQW/Vezi7ztQ1kgqVPJ1GRz0wW9gXWVGQEwI02S/wiV7r9wR8VJDg
	GPeaNsRmXspPjZJ20y4vvvUwH8Q7h5kx2VcsqMEHBjbEAjIP5hhxs2hDQimUDm0yrqH+wj
	M9+gWX7zRJ7oDN5BySzbfOSury8EHrY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-zaLiM4tDNzulnG4h4IHkoA-1; Tue,
 22 Oct 2024 13:24:10 -0400
X-MC-Unique: zaLiM4tDNzulnG4h4IHkoA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B9E381955EAB;
	Tue, 22 Oct 2024 17:24:07 +0000 (UTC)
Received: from f39.redhat.com (unknown [10.39.192.92])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A53EE1955F30;
	Tue, 22 Oct 2024 17:24:00 +0000 (UTC)
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
Subject: [PATCH v2 3/3] libsubcmd: Silence compiler warning
Date: Tue, 22 Oct 2024 19:23:29 +0200
Message-ID: <20241022172329.3871958-4-ezulian@redhat.com>
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

Initialize the pointer 'o' in options__order to NULL to prevent a
compiler warning/error which is observed when compiling with the '-Og'
option, but is not emitted by the compiler with the current default
compilation options.

For example, when compiling libsubcmd with

 $ make "EXTRA_CFLAGS=-Og" -C tools/lib/subcmd/ clean all

Clang version 17.0.6 and GCC 13.3.1 fail to compile parse-options.c due
to following error:

  parse-options.c: In function ‘options__order’:
  parse-options.c:832:9: error: ‘o’ may be used uninitialized [-Werror=maybe-uninitialized]
    832 |         memcpy(&ordered[nr_opts], o, sizeof(*o));
        |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  parse-options.c:810:30: note: ‘o’ was declared here
    810 |         const struct option *o, *p = opts;
        |                              ^
  cc1: all warnings being treated as errors

Signed-off-by: Eder Zulian <ezulian@redhat.com>
---
 tools/lib/subcmd/parse-options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index eb896d30545b..555d617c1f50 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -807,7 +807,7 @@ static int option__cmp(const void *va, const void *vb)
 static struct option *options__order(const struct option *opts)
 {
 	int nr_opts = 0, nr_group = 0, nr_parent = 0, len;
-	const struct option *o, *p = opts;
+	const struct option *o = NULL, *p = opts;
 	struct option *opt, *ordered = NULL, *group;
 
 	/* flatten the options that have parents */
-- 
2.46.2


